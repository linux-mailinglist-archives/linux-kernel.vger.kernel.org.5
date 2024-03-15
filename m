Return-Path: <linux-kernel+bounces-104184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD4C87CA5E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 10:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD4A3282679
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 09:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3506B17736;
	Fri, 15 Mar 2024 09:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="uxb9xEco"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C215B175A5
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 09:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710493569; cv=none; b=g2tLHZregscZhKP1UPE2s6hoicQuX3Iic3UVWFy8VSfY5W09Vv6VVgAjZErlxXRBGq/wpwgxjqwrYDjO5KQE+1JxFUhCxUeyALRtmj7mdBq24sOMr1iOXJH1AKGYl/IqQdXIUC4/Ew48S4PpNTl6vbqLZx2PUa5LOS2pD95szlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710493569; c=relaxed/simple;
	bh=VYYch6XeureEVUpN2Mw2LknizCfpr7ksjmijCa7rU1g=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=rLC1ZtKKQz/w3rWWZq3TKUV/zuLWA/i5C2TumbCg0h0Xb7Lp86/fB4jZMTKwYXZb5yfz95WUDpHm37VO1P1ubAipr8ot0jMQyPkHbP5PrKJ5NHSIaeNOXFvAxzJbrrEGz/UEqv25E5nf26LToGrvsYR2ISu2WsiKXH5BLxAk6BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=uxb9xEco; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-412e784060cso17594445e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 02:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1710493565; x=1711098365; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=ZpMSBa9vXitkcuu7vgMM3w3/yA6IqPigK2dGLCTN5uc=;
        b=uxb9xEcoW06sfo43xA0iTAYPNc/sHcZzFzBdFoMm+3EOzpxR7jYZ/onGi6nNR8uU/v
         hl02w0ZJJNgsZcO+8zUMT/ZhxT7Ey0uKjCJnmqRq86yVfuKsQntH3/BKSW6mbMMDPDIs
         9t6UgkeVK8jQ72uKve4rd1X8oaBEKaVXA+ZkyDOoQYuNXEMneLNEABWHxQUjJBbEpGzY
         /I+RhDbrsHd9aCGoUaVegA21Y7cErzy+NM5ghfysg2RlnChMoeDwYEyHATPnBBGLmnCL
         5izbvTWkvXkmUI63aC40YFTXBmYB/uzsyes0oRGna1aEKGa7wfOsaTouDqyBioAxPrT0
         WaDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710493565; x=1711098365;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZpMSBa9vXitkcuu7vgMM3w3/yA6IqPigK2dGLCTN5uc=;
        b=QXFxVcS9K25oNITgJshKmz/CVt23P9Y7azbjoDSJYl1sqAbsvpWJ5POxrUIB0GWbim
         8Yg2tYoEWERrLiNdCylQ4N8xCYOWFTCO27pYDetY5bcgC0yBE6sI5HGB5CrhOyqnlSdg
         zNjF30QmyQDBWBV9Fy/BXlUu/OI5MrvJMuWN4x3YM/Qn5xj4SeBilXhQozcdoxrkijAt
         U4s/ac77SbEZbevasmJj1LSo8OYUL4c6bKOboZsAcRdGWSKAL0xNpYofjxK4FFCNS5+m
         RrAb8iq4hjMlIJ7CSBOGmpR69z/cFBRBc2GNMe1Js8ftPBumDwiTqH/bHkLfvnh5Wfj0
         qmvA==
X-Forwarded-Encrypted: i=1; AJvYcCWh+YS3+rnSt5i9KTJ5jltwzJ6uHMaQuMr17mrWYOrk38sEcpcgdkGrlSD3zbxS95MXKd9vuLCEYMqcGv/HmH9NO6eZ0P+e6/73dK4A
X-Gm-Message-State: AOJu0Yz6F9puCZA711o3YZdHhw35bV2q4dzk94+GiMI+7RSKKOetYuK6
	PxxLLqc4cTwrwASVOuIt0K8zRuL8kBn/3G6M9aHlv5RL5pw/mOLkSculIXOx3Ec=
X-Google-Smtp-Source: AGHT+IGv2qeT4+XV+fkhSqD7rZTLCUTw8RubHWgYTp3yu9LMq3zgewNkauR43y7qOB4OhUkwae7l8g==
X-Received: by 2002:a05:600c:4f11:b0:414:37f:2798 with SMTP id l17-20020a05600c4f1100b00414037f2798mr483210wmq.6.1710493564904;
        Fri, 15 Mar 2024 02:06:04 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:8151:4d0a:14d8:1124])
        by smtp.gmail.com with ESMTPSA id fj6-20020a05600c0c8600b00414024b2f49sm900044wmb.0.2024.03.15.02.06.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 02:06:04 -0700 (PDT)
References: <20240314232201.2102178-1-jan.dakinevich@salutedevices.com>
 <20240314232201.2102178-2-jan.dakinevich@salutedevices.com>
User-agent: mu4e 1.10.8; emacs 29.2
From: Jerome Brunet <jbrunet@baylibre.com>
To: Jan Dakinevich <jan.dakinevich@salutedevices.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Jerome Brunet
 <jbrunet@baylibre.com>, Michael  Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Rob  Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Kevin
 Hilman <khilman@baylibre.com>, Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org,
 linux-sound@vger.kernel.org, linux-gpio@vger.kernel.org,
 kernel@salutedevices.com
Subject: Re: [PATCH 01/25] clk: meson: a1: restrict an amount of 'hifi_pll'
 params
Date: Fri, 15 Mar 2024 09:58:50 +0100
In-reply-to: <20240314232201.2102178-2-jan.dakinevich@salutedevices.com>
Message-ID: <1j8r2jj24k.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


On Fri 15 Mar 2024 at 02:21, Jan Dakinevich <jan.dakinevich@salutedevices.com> wrote:

> Existing values were insufficient to produce accurate clock for audio
> devices. New values are safe and most suitable to produce 48000Hz sample
> rate.

The hifi pll is not about 48k only. I see no reason to restrict the PLL
to a single setting.

You've provided no justification why the PLL driver can't reach the same
setting for 48k. The setting below is just the crude part. the fine
tuning is done done with the frac parameter so I doubt this provides a
more accurate rate.

>
> Signed-off-by: Jan Dakinevich <jan.dakinevich@salutedevices.com>
> ---
>  drivers/clk/meson/a1-pll.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/clk/meson/a1-pll.c b/drivers/clk/meson/a1-pll.c
> index 4325e8a6a3ef..00e06d03445b 100644
> --- a/drivers/clk/meson/a1-pll.c
> +++ b/drivers/clk/meson/a1-pll.c
> @@ -74,9 +74,9 @@ static struct clk_regmap fixed_pll = {
>  	},
>  };
>  
> -static const struct pll_mult_range hifi_pll_mult_range = {
> -	.min = 32,
> -	.max = 64,
> +static const struct pll_params_table hifi_pll_params_table[] = {
> +	PLL_PARAMS(128, 5),
> +	{ },
>  };
>  
>  static const struct reg_sequence hifi_init_regs[] = {
> @@ -124,7 +124,7 @@ static struct clk_regmap hifi_pll = {
>  			.shift   = 6,
>  			.width   = 1,
>  		},
> -		.range = &hifi_pll_mult_range,
> +		.table = hifi_pll_params_table,
>  		.init_regs = hifi_init_regs,
>  		.init_count = ARRAY_SIZE(hifi_init_regs),
>  	},


-- 
Jerome

