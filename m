Return-Path: <linux-kernel+bounces-62399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2D1851FAC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 22:33:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 658711F22E77
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 21:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6FF44D9F2;
	Mon, 12 Feb 2024 21:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="UYkLqjxT"
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFECC4EB4A
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 21:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707773591; cv=none; b=eblwEUJXatmCOfYmVENYSX6WcYtEnVdvOm48PMhjBuoUL9g/g7g9ZJRWPt80N+nHysHcduqYNR/6sikFlk0munkJdjGeNFSaDXmBiXQdmBKjPgojjvp2PERjs0muO182yXiupckEu9E3QZ8Bd2NpWACvl2xLwHb7sTOBkqpfr8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707773591; c=relaxed/simple;
	bh=UccBZcWyRgHb8CdqI4SfdswhlCvqeiofHLzpJGOSCIM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SwIHUfGsGsPYojLyKGvqeRdFjk5Mk0mwEaCc5XCEA9dJSTkiESTAR0P6otUM9Umo2Eyhihg1SY8iuGlooulqCcHusvmGwhwV2Xp0c222oqgthJc51OsUzjC5mBqvAzPhKTCvwo0MyGb5iC5h2cjNpvStNmsqkf+RDWfGpC8SEGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=UYkLqjxT; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-4c02be905beso741004e0c.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 13:33:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1707773587; x=1708378387; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FJH2iY95UEJbzAWLAhKcrIml1wV+F91i2EVUBYNcdJo=;
        b=UYkLqjxT9GoSJnOQq93tXQa+t0FQEHckVJXzZ4Jk2drByJPW6AwZFaxvGLKlhTGEFi
         fIC2RwbEQumys6l1cZt1ESJw6pvC5N7OCy9a717BecKgaHCOBtBM8jDfYvUDUUxC6hXU
         CcjdrbpP+U3US/7ljiib3qOQfgLiS+PVQrQWCwwuUm+KWCVEynGTYESjb6Es50mKIkFb
         VYgQM00Qdwc/ULLhUEa24iTyV5/OXUXrzGqzuo+X7Qi34NUFTec7UZjSEX12Js2XUc0C
         1I0MbGz8i740ZFB+MBT4+S4og+EaSnQsTs8gm+jn1dzEi95J6p7mbRtsXInOnTo3ftYp
         7Kng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707773587; x=1708378387;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FJH2iY95UEJbzAWLAhKcrIml1wV+F91i2EVUBYNcdJo=;
        b=hmMHFBKI4NlEYB30ZJW2IA2+lNmeVt9rNCnRoNKsD0sjPCLjZ8e1DxTdshIZYnT2LT
         qWmHffnFKdnBW0oJh/sJcsz+x8rnVg4qysO9PuYE5R2rTV/kBbzpvV8rtiT2qGW/xa7x
         /+JmbWh7ot83hkWO3yRHESfF0kjcK+wsNYo3BsjSyhYp8h33DqFo6cGU+H/Tjk5wDMYu
         N0XhuBytyEmOsbp9aSaD62KV6NbSQI9pehiJnuWWcvvYwawBKa7L6HEYXPl2h8dWIER1
         6T4VLtq2+gg8RYV+k7OGE7Uw1r0Fwu9GdNxs2KnP1F/9yo0p9v4+mcFouKJU3RNZuR1y
         pg3Q==
X-Gm-Message-State: AOJu0YyQXWBNvFGrfPtfaoDg9UQ+0HePunFOg5NSFEIdzDWAbuxpilD2
	3+GGFY532g/lZHajrxfHl+t7gy17MdvLt2rNXlRgSuwvVK6poP7rMfwpyVunmbaEOjqufZVkIsZ
	lugavmp555mWwrQocQTc0ewvpojict/S+1/pLQQ==
X-Google-Smtp-Source: AGHT+IG9JhWk1ypXImx7gtdukOOrn/OVeJ91OyJ0AaFvoBMaRZsO4e81KwtlPywmU6wMBSTdbrnt6I7BaNpH/6tSHa8=
X-Received: by 2002:a1f:e7c3:0:b0:4c0:21c4:3a9b with SMTP id
 e186-20020a1fe7c3000000b004c021c43a9bmr4103383vkh.15.1707773587581; Mon, 12
 Feb 2024 13:33:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129115216.96479-1-krzysztof.kozlowski@linaro.org>
 <20240129115216.96479-5-krzysztof.kozlowski@linaro.org> <CACRpkdbMFHPK0SBSxiZ3FOqChQFCBdOny0yYG--6V+1S=CKgiw@mail.gmail.com>
In-Reply-To: <CACRpkdbMFHPK0SBSxiZ3FOqChQFCBdOny0yYG--6V+1S=CKgiw@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 12 Feb 2024 22:32:56 +0100
Message-ID: <CAMRc=MeEPvhB1nTwBT5fG7p0G4L2J5FjJfM0GMusQuDnnEN35g@mail.gmail.com>
Subject: Re: [PATCH v6 4/6] reset: Instantiate reset GPIO controller for
 shared reset-gpios
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
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

On Mon, Feb 12, 2024 at 9:48=E2=80=AFPM Linus Walleij <linus.walleij@linaro=
org> wrote:
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
>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>
> I can't think of anything better, that is reasonable to ask for.
>
> I feel slightly icky about the way the code reaches into gpiolib, and I t=
hink

As long as it doesn't include gpiolib.h, I'm fine with it.

> regulators should be able to reuse the code, but unfortunately only the d=
ay
> they have no board files left :/
>
> I do feel the core code handling "reset-gpios" could as well have been
> used to handle "enable-gpios" in regulators, just that the regulator code
> has more requirements, and would be really hard to rewrite, and deals
> with descriptors passed in from drivers instead of centralizing it.
>
> Like regulators, reset grows core support for handling GPIO for resets
> which is *long due*, given how common it must be. We really need
> something like this, and this is certainly elegant enough to do the job.
>
> Yours,
> Linus Walleij

Agreed.

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

I will pick up the stub patches tomorrow and send a tag for Philipp to pull=
.

Bartosz

