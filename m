Return-Path: <linux-kernel+bounces-63363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F9B3852E2F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:40:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7E49282ED7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65CD52868D;
	Tue, 13 Feb 2024 10:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="dRekwuaE"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DC922636
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 10:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707820829; cv=none; b=mbO0xRsaujRzUZShWGtBWsLmVLRU5ziXHCUHVpALvrJldK3mIPr7yujkQFL7H0dJFl1uF0nr0AvpjeQL+fJkdznThs17B1I0FfI+4kdQ8iFq5UuiL/8k0izmblmJMjLZBMoIllTWs85AluDXI7q5emF+psRod223i7Sb0k0srgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707820829; c=relaxed/simple;
	bh=krsCH14lzt/9Maep29rwlQil5zrN1KmqSS4gA+WXvOk=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=WCkGyWTBYYn+uI3L7yNhLClmV80iQT8IN9nQ4cRDslLJSy0Sx/+SoQjQDa0ugpfU4kxlVL8/WJ/ynyNGRDYwHd0TQcye558MVSXKgB2IPlu6x7AaOqMKsgWbP60MoYUgWESY4dsAjevc8cRY4kp1LhsMVGrBoAdceNdeJSonOxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=dRekwuaE; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-410ee8ed659so11433225e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 02:40:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1707820825; x=1708425625; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=73nQOWwOG85LqUQijwY3y2kTDnNiZFOlELYxkV2QtZQ=;
        b=dRekwuaEN/PJB6ElhQrBAPT8MKPsf+sVFNnTx4uq9lqFRkgl9j76at1fMwg5H0A1rQ
         Knwr5M0Pjcg4LAQX0TDb3EOCLezIwwRSoueWqX0m/5iBzf9RWh+cWvC32zVL6dl1KZCl
         /W5rASlMgMLr9RGIdKq4tdjTMpa9NncimRb7yA3TfV2jP4R0+adCPHpExFSKYTiYiem5
         nJQHjBhjEUtE9l4ec0Zp6SXImWnGNPAfjYyI9v+ydBFB5uROmDqCnTH2Bfbxt4pPyvyW
         E2Pkmu1Su/0Vo/lzSVwMKyXUGJ3upZ28Ny5TvQSUNuPMzL9ZiwSYd07QCpB5Ncy4rfjH
         jtgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707820825; x=1708425625;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=73nQOWwOG85LqUQijwY3y2kTDnNiZFOlELYxkV2QtZQ=;
        b=JU/wleLxzGxPoABcrCPiwr1RiyPSGqqCUtgOL9I7M3qRGEKu5aYeyZ7cOJt2dMCulV
         hh7WYJOSNeJPFn7O+6voMlHvtW9Rh3Xx6VfDxtwAsdeImJnPVws7s5voaYAx/q11lzB2
         PkkY5EEiO0kwwvYrulh2ljxsFyS1JQoSrQabuiiM4mN7qSQfMKCzFAzuSeEowCiz0v9/
         PjjIeDuI5cV9KOy9HMDAmSuzrQKwgAs/xZUnrTnNIR0Vd8Or0dzt0sUmRsYL5z5+ncCp
         zRovkIBUUEjFz+vP3x8i9XXi5llGlvl/7PXh6mq/u2k4BCvmuXK7wYfox21/3APe9KYf
         8wNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRAZaI+SKTjwcYeBN8b4U02CFPijzj9AGiPa6/yh6cJmau2rd4gqUOJm1TRcgtQEXeU5U6CfzAP4qEP6IjtdKWw/j8IirG8KkqSm3s
X-Gm-Message-State: AOJu0Ywyz2HgrUyro2nCRztdNHEgtjmJrDtbyhQa0vwIwgPXn4K8wdk5
	WgCua3jguJz9eDzJU7UhMBKa378XtxHqm6EzMGSh2LeuPS+3bOOPsaNqAqSzuRs=
X-Google-Smtp-Source: AGHT+IFE2dDl+7H9jhreEKYF+PUjtVPBRcNJ1aERTrrwwC5G4DL6A6zOSd3wAcqga8EO4wTyXt03Pg==
X-Received: by 2002:a05:600c:35d6:b0:410:bb99:af83 with SMTP id r22-20020a05600c35d600b00410bb99af83mr5171034wmq.23.1707820824810;
        Tue, 13 Feb 2024 02:40:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUmcpbchwPyNzBfnbLcEYhaLnxRQSdBvMKjGg0MfaCh7YWyITG3KZKFcRYjfwe4AlHSq1gIXWIjsiVyv1IInLv1tZVd8zmquscCy1pDKYwdz6ynaEkFHraLMWSkLqh5TRj+L/JjihgJpQCVLPbPVfylHTV3batPXQXXindEdpdMqE0SUk5RUOICCx9f4Eb8h5DTJ8vDSxJbXIeNoJfFhXRq8lNOY7jMZ0c+xcyncspd16YHa0IkYhvVU1WUQqEArUfvTF+SOUM4Dt6OU0uFU2i45yO6k7zltzOl+BYRYI7XlCDdoZkIcl6ELjYAmedeiuco7vlSNcPnTNVtdkYiXPyrZF4K/En7BMlacB3N5g8zIxanpUjM7LvvquL2djRo3o6JaZB2FQXw7cwz+qwougFRtQ5bk+HRzQ8Ra85TnWjlTyaRM3YUC2vSlcte05ZhhsU6FN+8sVvI8CBvm84Yfr43mveqKKKtpCM3lfNAJocWu3ZsxvGPwGF945dM0y7mcsU7DT3vSkHlfGIfh+vu1JdHCc99fhNPmRDiBz88JQwxFhk5TEvCYmvJFBeL6rPDrBlBgM2F5Ni3KdJGf3GhrGtWo9/OtDGksh6UCEtuWoWIVDh1P6usyEPmTFpYFe0IEzH8GUOB4to5Jo8wRg+cp9MHbcK38SJVltJ8NNXA
Received: from localhost ([2a01:e0a:3c5:5fb1:509b:4241:48a3:e3e0])
        by smtp.gmail.com with ESMTPSA id m20-20020a7bce14000000b00410e0fd6179sm4811973wmc.34.2024.02.13.02.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 02:40:24 -0800 (PST)
References: <20240213101220.459641-1-arnd@kernel.org>
User-agent: mu4e 1.10.8; emacs 29.1
From: Jerome Brunet <jbrunet@baylibre.com>
To: Arnd Bergmann <arnd@kernel.org>, Stephen Boyd <sboyd@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Jerome
 Brunet <jbrunet@baylibre.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Neil
 Armstrong <neil.armstrong@linaro.org>, Kevin Hilman
 <khilman@baylibre.com>, Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>, Nathan Chancellor
 <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Bill
 Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] ASoC: meson: add helpers for clk_disable_unprepare
Date: Tue, 13 Feb 2024 11:36:28 +0100
In-reply-to: <20240213101220.459641-1-arnd@kernel.org>
Message-ID: <1jbk8kk5pk.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


On Tue 13 Feb 2024 at 11:11, Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
>
> Casting between incompatible function types causes a warning with clang-16
> because it breaks control flow integrity (KCFI) rules:
>
> sound/soc/meson/aiu.c:243:12: error: cast from 'void (*)(struct clk *)' to
> 'void (*)(void *)' converts to incompatible function type
> [-Werror,-Wcast-function-type-strict]
>   243 |                                        (void(*)(void *))clk_disable_unprepare,
>       |                                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> include/linux/device.h:406:34: note: expanded from macro 'devm_add_action_or_reset'
>   406 |         __devm_add_action_or_reset(dev, action, data, #action)
>       |                                         ^~~~~~
> sound/soc/meson/t9015.c:274:4: error: cast from 'void (*)(struct clk *)' to
> 'void (*)(void *)' converts to incompatible function type
> [-Werror,-Wcast-function-type-strict]
>   274 |                         (void(*)(void *))clk_disable_unprepare,
>       |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> include/linux/device.h:406:34: note: expanded from macro 'devm_add_action_or_reset'
>   406 |         __devm_add_action_or_reset(dev, action, data, #action)
>       |                                         ^~~~~~
>
> These two meson drivers cast clk_disable_unprepare() into a different type
> in order to have it automatically called from the driver relase. Add
> trivial helpers to do the same using correct types.
>
> Fixes: 33901f5b9b16 ("ASoC: meson: add t9015 internal DAC driver")
> Fixes: 6ae9ca9ce986 ("ASoC: meson: aiu: add i2s and spdif support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  sound/soc/meson/aiu.c   | 9 ++++++---
>  sound/soc/meson/t9015.c | 9 ++++++---
>  2 files changed, 12 insertions(+), 6 deletions(-)
>
> diff --git a/sound/soc/meson/aiu.c b/sound/soc/meson/aiu.c
> index 7109b81cc3d0..211f360df284 100644
> --- a/sound/soc/meson/aiu.c
> +++ b/sound/soc/meson/aiu.c
> @@ -209,6 +209,11 @@ static const char * const aiu_spdif_ids[] = {
>  	[MCLK]	= "spdif_mclk_sel"
>  };
>  
> +static void aiu_clk_disable(void *clk)
> +{
> +	clk_disable_unprepare(clk);
> +}
> +
>  static int aiu_clk_get(struct device *dev)
>  {
>  	struct aiu *aiu = dev_get_drvdata(dev);
> @@ -239,9 +244,7 @@ static int aiu_clk_get(struct device *dev)
>  		return ret;
>  	}
>  
> -	ret = devm_add_action_or_reset(dev,
> -				       (void(*)(void *))clk_disable_unprepare,
> -				       aiu->pclk);
> +	ret = devm_add_action_or_reset(dev, aiu_clk_disable, aiu->pclk);

Hi Arnd,

This probably pre-dates the introduction of devm_clk_get_enabled()
It would probably be better to use that instead of duplicating helper
functions which do the same thing.

If for any reason it is not possible, a common helper in clk.h would
preferable I think.

>  	if (ret)
>  		dev_err(dev, "failed to add reset action on pclk");
>  
> diff --git a/sound/soc/meson/t9015.c b/sound/soc/meson/t9015.c
> index 9c6b4dac6893..e0f9a603a5e9 100644
> --- a/sound/soc/meson/t9015.c
> +++ b/sound/soc/meson/t9015.c
> @@ -243,6 +243,11 @@ static const struct regmap_config t9015_regmap_config = {
>  	.max_register		= POWER_CFG,
>  };
>  
> +static void t9015_clk_disable(void *clk)
> +{
> +	clk_disable_unprepare(clk);
> +}
> +
>  static int t9015_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -270,9 +275,7 @@ static int t9015_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> -	ret = devm_add_action_or_reset(dev,
> -			(void(*)(void *))clk_disable_unprepare,
> -			priv->pclk);
> +	ret = devm_add_action_or_reset(dev, t9015_clk_disable, priv->pclk);
>  	if (ret)
>  		return ret;


-- 
Jerome

