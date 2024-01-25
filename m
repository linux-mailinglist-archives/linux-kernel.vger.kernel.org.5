Return-Path: <linux-kernel+bounces-38064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C4B83BA85
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 08:20:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6091B1F2285B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 07:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3FA11C82;
	Thu, 25 Jan 2024 07:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tdlwibwj"
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7E311713;
	Thu, 25 Jan 2024 07:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706167243; cv=none; b=gI5bSOred/fB14LybWxpaJP7/1r786wg0IngoekiuKP6+ZGl4v/MueHpH2x2gLC3U0N/dM1Lfb6ecDf7sIGy3htWGSCHZkCEDElGoA78H0kFgYviJQy7DGl5d3AQTWLlnBRqrUvjds2nuOWMlBa4UiRAGkEp+Ti2aeKgwp1EzM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706167243; c=relaxed/simple;
	bh=ihulYfjCfEWVoZz/Z/GfoBK+jSFE4nHTh23lsVfj3aY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F9LHtjiQn78064W5d1qubhThVqSErfT4LOb1oV2mQ43w0FyxmWmNebRLtbK264oIUbw81g/FWTmlKDPGftinl7jvqzQnHFI+hMCDJgjxHi8RMy8Uz3H+furmwHx1Z+LI8929FMsISqD360CdSYbjaAOcCwMixA6Q3THGT1usskk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tdlwibwj; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6e0e08c70f7so3330911a34.2;
        Wed, 24 Jan 2024 23:20:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706167241; x=1706772041; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3pofvpEUvE2DG0LQ8xo53uhzJmM6FRGjdvVMnUevHNs=;
        b=TdlwibwjuaL5grg5vfElJsN2G0tCeqXaDf0MKJJ4fY7DHupQ6Yz8mDaKEvZbvXW6UJ
         u21SaK15Dd4YXTo+UylKMRwrj61lAhZjhEkYNh5yP9QoHNCnTmPUpWg27vsaN+Fhhb6z
         e5uCSoZ5K2ctJJhLsyS2/Nbpzc7k9l3I5XgQM1CETONVO4EIpq5PLQDNX2f5a9u118Na
         1Jh6JXzZd0KlGBGexDVTh0dB6+ATBSj7femGlZ3JVbV96Zr0EvKHVAGClaBLqS516LI9
         +8xRLXfR9QgVS4Mmc6qXMH1ExF0zzGVbze31mQcq3tvHM6Q9ABKgDC/WMCYEOP2itUDY
         mixA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706167241; x=1706772041;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3pofvpEUvE2DG0LQ8xo53uhzJmM6FRGjdvVMnUevHNs=;
        b=It0B0ib8DAndCSfIwPgs5ZeEblYq0jDsPIlnSHm/eqdS0zm4ZyghBdIqd3SUvJHOaG
         jvuAo9tQ1sJwYbr+rg2o5oihSZYkkJDfH0I6TBpa0MB3ptDaM7obsGEd0RRMEiCQZ6DM
         OzJp97TahYwPk5achun2KWCK6Irw123+865TJ8qTceqt4zOeN/3FFK3fNRPv62NYzjAf
         PrSic8B561F17/bh3rj7mY/kxcjH3TtId3t/VCpcupMqL1vLWxNqSz93R3nVTLild0Ad
         H69C1kCYEJ7PwL62Y1zVIUI3nozyjd7f8euRVrw7+yoHQLUYkqDrqZM8jwxO1dS7g7mG
         wK9w==
X-Gm-Message-State: AOJu0YwIeFyn5gvGU1/Mq55sTw3YRLFgbCyQnxAOlEeai9990Lw0CkTj
	RohFxqB2u7hDpesYr8J6cxoQwkUL8JJSz9Q805sOluGFQuWW8GZQPudYiRCbSHyXae0tgKkyLxd
	BA5M38IGppZoMdveJ1Rdh4AV/5yA=
X-Google-Smtp-Source: AGHT+IEvvRZvW1Z6yIqBkAu9YjlW5ApPGFtR6jRbJbnK1TME2cQlVfAOReWvV/ty4FhATo9HE+mlqFjqa3Ij2GopCgM=
X-Received: by 2002:a05:6871:7994:b0:210:aec0:e8ed with SMTP id
 pb20-20020a056871799400b00210aec0e8edmr523829oac.73.1706167241216; Wed, 24
 Jan 2024 23:20:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125025533.10315-1-Wenhua.Lin@unisoc.com> <20240125025533.10315-3-Wenhua.Lin@unisoc.com>
In-Reply-To: <20240125025533.10315-3-Wenhua.Lin@unisoc.com>
From: Chunyan Zhang <zhang.lyra@gmail.com>
Date: Thu, 25 Jan 2024 15:20:04 +0800
Message-ID: <CAAfSe-t68Jq+mKaSdzz5P2tPetxup7w1UoMsk+Z__3YWtV6EhQ@mail.gmail.com>
Subject: Re: [PATCH V2 2/6] pwm: sprd: Improve the pwm backlight control function
To: Wenhua Lin <Wenhua.Lin@unisoc.com>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, wenhua lin <wenhua.lin1994@gmail.com>, 
	Xiongpeng Wu <xiongpeng.wu@unisoc.com>, zhaochen su <zhaochen.su29@gmail.com>, 
	Zhaochen Su <Zhaochen.Su@unisoc.com>, Xiaolong Wang <Xiaolong.Wang@unisoc.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 25 Jan 2024 at 11:09, Wenhua Lin <Wenhua.Lin@unisoc.com> wrote:
>
> The pwm-sprd driver support only 8-bit linear control of backlight. Now,
> new requests of supporting 9-bit, 10-bit, 11-bit and 12-bit linear
> control of backlight are proposed. Besides, different channels of pwm
> could be configured into different linear control of backlight. Thus,
> sprd,mod attribute is introduced into dts for every channel of pwm
> device. This attribute would determine the value of MOD and eventually
> realize the new requirements.
>
> Signed-off-by: Wenhua Lin <Wenhua.Lin@unisoc.com>
> ---
>  drivers/pwm/pwm-sprd.c | 42 ++++++++++++++++++++++++++++++++++--------
>  1 file changed, 34 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/pwm/pwm-sprd.c b/drivers/pwm/pwm-sprd.c
> index bc1e3ed13528..cc54aa77c7e6 100644
> --- a/drivers/pwm/pwm-sprd.c
> +++ b/drivers/pwm/pwm-sprd.c
> @@ -18,7 +18,8 @@
>  #define SPRD_PWM_DUTY          0x8
>  #define SPRD_PWM_ENABLE                0x18
>
> -#define SPRD_PWM_MOD_MAX       GENMASK(7, 0)
> +#define SPRD_PWM_MOD_MAX       GENMASK(15, 0)
> +#define SPRD_PWM_MOD_DEFAULT   GENMASK(9, 0)
>  #define SPRD_PWM_DUTY_MSK      GENMASK(15, 0)
>  #define SPRD_PWM_PRESCALE_MSK  GENMASK(7, 0)
>  #define SPRD_PWM_ENABLE_BIT    BIT(0)
> @@ -43,6 +44,7 @@ struct sprd_pwm_chip {
>         const struct sprd_pwm_data *pdata;
>         int num_pwms;
>         struct sprd_pwm_chn chn[SPRD_PWM_CHN_NUM];
> +       u32 mod[SPRD_PWM_CHN_NUM];
>  };
>
>  static const struct sprd_pwm_data ums512_data = {
> @@ -120,7 +122,7 @@ static int sprd_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
>          */
>         val = sprd_pwm_read(spc, pwm->hwpwm, SPRD_PWM_PRESCALE);
>         prescale = val & SPRD_PWM_PRESCALE_MSK;
> -       tmp = (prescale + 1) * NSEC_PER_SEC * SPRD_PWM_MOD_MAX;
> +       tmp = (prescale + 1) * NSEC_PER_SEC * spc->mod[pwm->hwpwm];
>         state->period = DIV_ROUND_CLOSEST_ULL(tmp, chn->clk_rate);
>
>         val = sprd_pwm_read(spc, pwm->hwpwm, SPRD_PWM_DUTY);
> @@ -140,7 +142,7 @@ static int sprd_pwm_config(struct sprd_pwm_chip *spc, struct pwm_device *pwm,
>                            int duty_ns, int period_ns)
>  {
>         struct sprd_pwm_chn *chn = &spc->chn[pwm->hwpwm];
> -       u32 prescale, duty;
> +       u32 prescale, duty, mod;
>         u64 tmp;
>
>         /*
> @@ -148,16 +150,21 @@ static int sprd_pwm_config(struct sprd_pwm_chip *spc, struct pwm_device *pwm,
>          * The period length is (PRESCALE + 1) * MOD counter steps.
>          * The duty cycle length is (PRESCALE + 1) * DUTY counter steps.
>          *
> -        * To keep the maths simple we're always using MOD = SPRD_PWM_MOD_MAX.
> +        * The value for MOD is obtained from dts.
>          * The value for PRESCALE is selected such that the resulting period
>          * gets the maximal length not bigger than the requested one with the
> -        * given settings (MOD = SPRD_PWM_MOD_MAX and input clock).
> +        * given settings (MOD and input clock).
>          */
> -       duty = duty_ns * SPRD_PWM_MOD_MAX / period_ns;
> +       mod = spc->mod[pwm->hwpwm];
> +       duty = duty_ns * mod / period_ns;
>
>         tmp = (u64)chn->clk_rate * period_ns;
>         do_div(tmp, NSEC_PER_SEC);
> -       prescale = DIV_ROUND_CLOSEST_ULL(tmp, SPRD_PWM_MOD_MAX) - 1;
> +       prescale = DIV_ROUND_CLOSEST_ULL(tmp, mod);
> +       if (prescale < 1)
> +               prescale = 1;
> +       prescale--;
> +
>         if (prescale > SPRD_PWM_PRESCALE_MSK)
>                 prescale = SPRD_PWM_PRESCALE_MSK;
>
> @@ -170,7 +177,7 @@ static int sprd_pwm_config(struct sprd_pwm_chip *spc, struct pwm_device *pwm,
>          * before changing a new configuration to avoid mixed settings.
>          */
>         sprd_pwm_write(spc, pwm->hwpwm, SPRD_PWM_PRESCALE, prescale);
> -       sprd_pwm_write(spc, pwm->hwpwm, SPRD_PWM_MOD, SPRD_PWM_MOD_MAX);
> +       sprd_pwm_write(spc, pwm->hwpwm, SPRD_PWM_MOD, mod);
>         sprd_pwm_write(spc, pwm->hwpwm, SPRD_PWM_DUTY, duty);
>
>         return 0;
> @@ -263,6 +270,21 @@ static int sprd_pwm_clk_init(struct sprd_pwm_chip *spc)
>         return 0;
>  }
>
> +static int sprd_pwm_get_mod(struct platform_device *pdev)
> +{
> +       int i, ret;
> +       struct sprd_pwm_chip *spc = platform_get_drvdata(pdev);

Before using platform_get_drvdata(), you have to call
platform_set_drvdata, otherwise spc is NULL here and it will cause a
crash.

> +
> +       ret = of_property_read_u32_array(pdev->dev.of_node,
> +                                        "sprd,mod", spc->mod, spc->num_pwms);
> +       if (ret) {


> +               for (i = 0; i < spc->num_pwms; i++)
> +                       spc->mod[i] = SPRD_PWM_MOD_DEFAULT;
> +       }
> +
> +       return ret;
> +}
> +
>  static int sprd_pwm_probe(struct platform_device *pdev)
>  {
>         struct sprd_pwm_chip *spc;
> @@ -288,6 +310,10 @@ static int sprd_pwm_probe(struct platform_device *pdev)
>         if (ret)
>                 return ret;
>
> +       ret = sprd_pwm_get_mod(pdev);
> +       if (ret)
> +               dev_info(&pdev->dev, "get pwm mod failed! Use default setting\n");
> +
>         spc->chip.dev = &pdev->dev;
>         spc->chip.ops = &sprd_pwm_ops;
>         spc->chip.npwm = spc->num_pwms;
> --
> 2.17.1
>

