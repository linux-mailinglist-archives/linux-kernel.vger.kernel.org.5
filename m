Return-Path: <linux-kernel+bounces-46148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85CFE843B42
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:38:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12A961F2C665
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5874369979;
	Wed, 31 Jan 2024 09:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="xBkCE3xf"
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA91467E86
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 09:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706693864; cv=none; b=So2graLUdxX6qI/7Nbwq6G+ZjPT8Q4vuoqfghbGHzAsuPIdihWHj3nm70V+xwycpwO/EtmrdTaQTsPkWG8052uagTsPLwOCMBzXywnILcyl921cDDDJgG8iFGOsIlWPp1bAd69XvR/dmOaKShsTgmk0c3ATyUA19GRFaEqSEdj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706693864; c=relaxed/simple;
	bh=6g/9wBTl6BPCWec9Q4PfBb1jAfx/QsrhO21o+nVjTVw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XVnb0GTGJCrhD9SVCR7ps5njoEwhwgzZOviuNb0G+JccYLIqreVafip2VO1528miIoOFRzcVWgzGWg9cX3z4CboWjncdZvWDHhU14j1IXOVjKshbOuJDmP7Y9tRzUsmzmLpqE+9pbCzUdjTa85k76m1NCqGsxJFz1rMNwh99uMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=xBkCE3xf; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-4bd91d89fbeso1391829e0c.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 01:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1706693861; x=1707298661; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DmHeh0AnnU8R6/8VaEZIi+vqbQkcVNAn6pqy7RHvRQI=;
        b=xBkCE3xfgEp8qPGMcW2d28LiFylg+yIZOldTOmpHe5lUFK6l5+DI497ZIMUvKHvR3j
         5vOhoZK9QoLFDxfTn4kYxFh/FX3o8o25S/D6Sv8wZeP18QQPnyWKphT1Bh7/ezCzu4Wr
         s95RpLWANK4vYXBZrbepdIn0wldP0HdC2BxO0HdJ+8ZawP2n58lqMjREM5faykWBjJ45
         EtBMY2xpQgjmRDSFw9hHxeb8YH3+3DWp7ciglNRhkeikLvefwq2ngMcoIKg2ocnq/ql2
         RL8HFjKkqdVJR+bPWl1Add/iTs6kyaHX4qQGGvRX+gUYzPDz0BBz9JoiBd75cdYvLfG+
         ZdBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706693861; x=1707298661;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DmHeh0AnnU8R6/8VaEZIi+vqbQkcVNAn6pqy7RHvRQI=;
        b=mwAuWKThEQfRwUWQQ53hGN3F8G6zQFlmmeBhgk8mss/msbZGdYzGP8mXCGUHQDKR9w
         bNBYPMn7uNQtjR6uoPFJJI1iu77tjCB8ZROFtZylFtowBMRByNagi9WYp858NHAHPxEs
         HHrgiZaAc9H5bqNy+xgM8u7Teql3KfJd+FRtEOuziUQ6cGyla8GPlENlScfw0T49htCq
         xADldZD+QP+E1Ms58x/PKR4xXpEBnXHSlW2/KXZq/lRMgvLwSC2Xw3rKFkJP8MrVQBLR
         JtgTvFyhuigym4USWGRLA0paTSEuBn4lfKnaDSkIlrbF6s18NlMldhKVQaQ1Vtqp9wAn
         vVSw==
X-Gm-Message-State: AOJu0YwX9o/yKVjr6HJxY3TkZK7P0LmVVjkUkxnwTZkv9wdU3+g/lHsi
	nePSCYAMS1pnYu/V9MakbPmlnQ1LS9qnVOYNfOcSy15OwWNWHwX4vp84+otkTaqQQqha8LPT50a
	GZsAca9tI3O+h6WCxBIm6N2uYp0mHQ4v0DRJpVw==
X-Google-Smtp-Source: AGHT+IGYiHwBdTOPDnoFpMk4wG2qn9o70lLB7qc/tMqoiGXQQ1hR03EibuQ3mFexsetD4ArcCOazY4KDA9aeRUgU3NE=
X-Received: by 2002:a05:6122:4693:b0:4bf:dbbd:37aa with SMTP id
 di19-20020a056122469300b004bfdbbd37aamr937831vkb.15.1706693860441; Wed, 31
 Jan 2024 01:37:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129115216.96479-1-krzysztof.kozlowski@linaro.org>
 <20240129115216.96479-5-krzysztof.kozlowski@linaro.org> <CACRpkdYf4HUaV-Pjr81WjLbzy9zdAnyFWs9gPayPC6-3OjHQwA@mail.gmail.com>
In-Reply-To: <CACRpkdYf4HUaV-Pjr81WjLbzy9zdAnyFWs9gPayPC6-3OjHQwA@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 31 Jan 2024 10:37:29 +0100
Message-ID: <CAMRc=Mc1SGLeUOWmKg=fvCdM+RR6FSu2QkFuR17s7L99eRMGug@mail.gmail.com>
Subject: Re: [PATCH v6 4/6] reset: Instantiate reset GPIO controller for
 shared reset-gpios
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, 
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Banajit Goswami <bgoswami@quicinc.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Frank Rowand <frowand.list@gmail.com>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, 
	linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, Chris Packham <chris.packham@alliedtelesis.co.nz>, 
	Sean Anderson <sean.anderson@seco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 9:57=E2=80=AFAM Linus Walleij <linus.walleij@linaro=
org> wrote:
>
> Hi Krzysztof,
>
> something is odd with the addresses on this patch, because neither GPIO
> maintainer is on CC nor linux-gpio@vger, and it's such a GPIO-related
> patch. We only saw it through side effects making <linux/gpio/driver.h>
> optional, as required by this patch.
>
> Please also CC Geert Uytterhoeven, the author of the GPIO aggregator.
>
> i.e. this:
> > 2. !GPIOLIB stub:
> >    https://lore.kernel.org/all/20240125081601.118051-3-krzysztof.kozlow=
ski@linaro.org/
>
> On Mon, Jan 29, 2024 at 12:53=E2=80=AFPM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>
> > Devices sharing a reset GPIO could use the reset framework for
> > coordinated handling of that shared GPIO line.  We have several cases o=
f
> > such needs, at least for Devicetree-based platforms.
> >
> > If Devicetree-based device requests a reset line, while "resets"
> > Devicetree property is missing but there is a "reset-gpios" one,
> > instantiate a new "reset-gpio" platform device which will handle such
> > reset line.  This allows seamless handling of such shared reset-gpios
> > without need of changing Devicetree binding [1].
> >
> > To avoid creating multiple "reset-gpio" platform devices, store the
> > Devicetree "reset-gpios" GPIO specifiers used for new devices on a
> > linked list.  Later such Devicetree GPIO specifier (phandle to GPIO
> > controller, GPIO number and GPIO flags) is used to check if reset
> > controller for given GPIO was already registered.
> >
> > If two devices have conflicting "reset-gpios" property, e.g. with
> > different ACTIVE_xxx flags, this would allow to spawn two separate
> > "reset-gpio" devices, where the second would fail probing on busy GPIO
> > request.
> >
> > Link: https://lore.kernel.org/all/YXi5CUCEi7YmNxXM@robh.at.kernel.org/ =
[1]
> > Cc: Bartosz Golaszewski <brgl@bgdev.pl>
> > Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>
> > Cc: Sean Anderson <sean.anderson@seco.com>
> > Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> (...)
>
> In my naive view, this implements the following:
>
> reset -> virtual "gpio" -> many physical gpios[0..n]

This is a different problem: it supports many users enabling the same
GPIO (in Krzysztof's patch it's one but could be more if needed) but -
unlike the broken NONEXCLUSIVE GPIOs in GPIOLIB - it counts the number
of users and doesn't disable the GPIO for as long as there's at least
one.

Bart

>
> So if there was already a way in the kernel to map one GPIO to
> many GPIOs, the framework could just use that with a simple
> single GPIO?
>
> See the bindings in:
> Documentation/devicetree/bindings/gpio/gpio-delay.yaml
>
> This is handled by drivers/gpio/gpio-aggregator.c.
>
> This supports a 1-to-1 map: one GPIO in, one GPIO out, same offset.
> So if that is extended to support 1-to-many, this problem is solved.
>
> Proposed solution: add a single boolean property such as
> aggregate-all-gpios; to the gpio-delay node, making it provide
> one single gpio at offset 0 on the consumer side, and refuse any
> more consumers.
>
> This will also solve the problem with induced delays on
> some GPIO lines as I can see was discussed in the bindings,
> the gpio aggregator already supports that, but it would work
> fine with a delay being zero as well.
>
> This avoids all the hackery with driver stubs etc as well.
>
> Yours,
> Linus Walleij

