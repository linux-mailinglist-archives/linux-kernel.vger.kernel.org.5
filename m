Return-Path: <linux-kernel+bounces-46087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54604843A1F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:05:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79BCD1C26054
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9887C69DE7;
	Wed, 31 Jan 2024 08:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZlZoqKvn"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C996869D32
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 08:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706691434; cv=none; b=QQAlTRoMVkli1W6RPD3gc7bLrbOBDcSZo+ju3EZoSJYvEJReGMvUz0S7Y5edzUWIVXu2xRTAg+qUGMQn6J3m8oHvUbmbZ7HhBxodW66mro1bP7GD79Xwq9hXAVvcXXAlRMKgwKmB71hLUtywMSiK73yv37j7G6S4kkcSbjl57vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706691434; c=relaxed/simple;
	bh=i/0xGVWxmLGZ/l4MKKj0oTxK2I+o2zUxh3bsKs/n+Iw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LvU3uReTnHLtZVWFVGJklzPa7gnNeX6MIt8X52pwVeMNvIKrwp1qKukJGC6Kqsw679luogDKdEc4cDoTTb2kx1B7SGHNiX2gKqs34sB87K/ziJr6JUKyBYmkH2uPnlYJ0FG1ESaFqrs6q6Nd9XK3wLSxJ1zi4BnuHbMgrhgu8iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZlZoqKvn; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-603e086c05bso28043927b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 00:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706691432; x=1707296232; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=19iyMKPgVV/OnzcKafV91f/kV0b2fJZ+DHL/skL3AYc=;
        b=ZlZoqKvnK9OMXxhyDnAHPKZgYrPCtuhp7e1LksxIle5ypFPscvs+hduyajZzs2TsSX
         RYtsEUu4xAzDEkY49ltoJ7lIGqG7G0rK6numdJxC4EvFci0hvUDp8tpx6A0DUs6i5KDM
         1eKhPoxhKPrzQgdE5Sbx8fVxdd0T9zA4dLZUHYRnULQpAF0+QagNHE+FNc4uqelEK9nx
         qA9/80W/aungYw0rIh4aDr26uyquHOWEDT/Tz8/uoZkavhvW27iFUkUhdtfJmgBhtUZi
         pbKEekHZNNVxIWXfvAWfRHImycGZwF1ggyonJH5IRMLR/Ke0VhT6dhH4rdEjenBJ7KDm
         gXcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706691432; x=1707296232;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=19iyMKPgVV/OnzcKafV91f/kV0b2fJZ+DHL/skL3AYc=;
        b=MYjM2nwPiMkzDaFRvnr8EdyOvM5eBB4CJVwrHy+uTGOM2NSfyS58cuii2woS5EV5b3
         QulHKNp+TYyK3F/FaSXMmgE9VKkDB+LmPMn5gMTqjJytmTgB5uL0DKDUwtv9DfUm0WnG
         FLLDKw5p/4tCElabmEjmw+DurlqJ785OAjxYCNodCBatluHH5C2Tb/zgdBu+GD6GeJyt
         wZl3TEJ/EbPei0ZrUwQj+JCpUCQInYS5zbbyx+EUHaZrpWXsM9ob3KX9f4JjJsuepB3j
         9Ol5FaqwzMvbqaAII91h06XWW2vu9fdv3DIa80rBjKin1YiOfVtP3InWICeaGQl3Ff4N
         k+aQ==
X-Gm-Message-State: AOJu0YxdwuxRXS4JmUvQS6l3DlehPUm4+00/OqcNXJOiv1x/qfBHSLqB
	eD/luvIhytXLUJKuJDgkn3fEqVzeJMABnn7o+ywr0P9Rjmp55VsoRRoTykvZymmmkc4PdV+9Y5a
	PHy9eA5BPJITUlth4w7Kh1fQuraIDMbE8iF9xKg==
X-Google-Smtp-Source: AGHT+IF+kfDZ/YF7mxYh80knn1UBEiVlr7hp7DfiTZ/EqM7NpiukfxSx7V7h2n9hbAXhnmqW7UvF5OBBTxTaOE6Q4vE=
X-Received: by 2002:a25:7904:0:b0:dc6:7e97:ae62 with SMTP id
 u4-20020a257904000000b00dc67e97ae62mr1105679ybc.21.1706691431753; Wed, 31 Jan
 2024 00:57:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129115216.96479-1-krzysztof.kozlowski@linaro.org> <20240129115216.96479-5-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240129115216.96479-5-krzysztof.kozlowski@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 31 Jan 2024 09:57:00 +0100
Message-ID: <CACRpkdYf4HUaV-Pjr81WjLbzy9zdAnyFWs9gPayPC6-3OjHQwA@mail.gmail.com>
Subject: Re: [PATCH v6 4/6] reset: Instantiate reset GPIO controller for
 shared reset-gpios
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Banajit Goswami <bgoswami@quicinc.com>, 
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

Hi Krzysztof,

something is odd with the addresses on this patch, because neither GPIO
maintainer is on CC nor linux-gpio@vger, and it's such a GPIO-related
patch. We only saw it through side effects making <linux/gpio/driver.h>
optional, as required by this patch.

Please also CC Geert Uytterhoeven, the author of the GPIO aggregator.

i.e. this:
> 2. !GPIOLIB stub:
>    https://lore.kernel.org/all/20240125081601.118051-3-krzysztof.kozlowsk=
i@linaro.org/

On Mon, Jan 29, 2024 at 12:53=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:

> Devices sharing a reset GPIO could use the reset framework for
> coordinated handling of that shared GPIO line.  We have several cases of
> such needs, at least for Devicetree-based platforms.
>
> If Devicetree-based device requests a reset line, while "resets"
> Devicetree property is missing but there is a "reset-gpios" one,
> instantiate a new "reset-gpio" platform device which will handle such
> reset line.  This allows seamless handling of such shared reset-gpios
> without need of changing Devicetree binding [1].
>
> To avoid creating multiple "reset-gpio" platform devices, store the
> Devicetree "reset-gpios" GPIO specifiers used for new devices on a
> linked list.  Later such Devicetree GPIO specifier (phandle to GPIO
> controller, GPIO number and GPIO flags) is used to check if reset
> controller for given GPIO was already registered.
>
> If two devices have conflicting "reset-gpios" property, e.g. with
> different ACTIVE_xxx flags, this would allow to spawn two separate
> "reset-gpio" devices, where the second would fail probing on busy GPIO
> request.
>
> Link: https://lore.kernel.org/all/YXi5CUCEi7YmNxXM@robh.at.kernel.org/ [1=
]
> Cc: Bartosz Golaszewski <brgl@bgdev.pl>
> Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>
> Cc: Sean Anderson <sean.anderson@seco.com>
> Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
(...)

In my naive view, this implements the following:

reset -> virtual "gpio" -> many physical gpios[0..n]

So if there was already a way in the kernel to map one GPIO to
many GPIOs, the framework could just use that with a simple
single GPIO?

See the bindings in:
Documentation/devicetree/bindings/gpio/gpio-delay.yaml

This is handled by drivers/gpio/gpio-aggregator.c.

This supports a 1-to-1 map: one GPIO in, one GPIO out, same offset.
So if that is extended to support 1-to-many, this problem is solved.

Proposed solution: add a single boolean property such as
aggregate-all-gpios; to the gpio-delay node, making it provide
one single gpio at offset 0 on the consumer side, and refuse any
more consumers.

This will also solve the problem with induced delays on
some GPIO lines as I can see was discussed in the bindings,
the gpio aggregator already supports that, but it would work
fine with a delay being zero as well.

This avoids all the hackery with driver stubs etc as well.

Yours,
Linus Walleij

