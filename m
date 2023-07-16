Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84AFC754EC7
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 15:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjGPNRg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 09:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGPNRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 09:17:34 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D1FEE66
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 06:17:33 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fbf7fbe722so36162045e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 06:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1689513452; x=1692105452;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bmfAeWrrqVPeSkZg9dIHhxIlmmrykDXgz8hEhOGRWN0=;
        b=MREiTVSmpTvtlWDoIlnykkVP5hCOzf2VUc6KNugTi/EJt7VZdQkKy1tHyDYesyOoOP
         Rh3FawYUbgltfUk8CEAquytvNggJeChn9X/ZWqY5yOph3rkyNopNC+w3DR/0g4BZd8e/
         ubZALIWIDNzIZyYmEcvZuzMDAq6DJgM11b2jDbhr7z1sryX9GkMbsWfbF3AgkGcltJli
         9F/TBnrDLsjSwkinoRaKJFm2uYWAEqNQQwJDCak8aZgsS57jFQnm3pYb9oHTGoSF3boa
         mLQa0FmVRX4yVLur8SREnc4of1Ydi2FBUpJbSRe4dkXuHzJo/bbaiUf7X/djl06476L3
         Z2nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689513452; x=1692105452;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bmfAeWrrqVPeSkZg9dIHhxIlmmrykDXgz8hEhOGRWN0=;
        b=coQyumCXpVu6zMYqI9L4KGzmmZAAdk5TfKZhSrXemKVBWSW/sxJ2lPE6tfbWQxCaL1
         1ddVktujR256W+wxXWCG7mp/618q/sXdUBbQLHFZoUfYxFMZAh4xS4gB3z9Jg+nwwgod
         hdLeZ/5QX2ozbYawKsBvMzUwyTl3nqXDXc2kYp3vKMRoCgItDW9Syovc435Nc0C1kGGs
         5GFDga6r2HwF7bClAuUVhC/PwREJhfm+DglGmvDgr7w8lsf4V1Pad4eDW1vPSLiuAtOa
         vaS8rIJMiWreEzZ8uWGT5UtemuT7mC1uvhCaN2ijn3WivdKKjdO4SNmHFw7tc+30uHuF
         Cucg==
X-Gm-Message-State: ABy/qLb7/8Ul8lEj5FBv1It+wsxp7CFugzKIUp/1Ey5e4QDiKRaMHBVG
        dHgrwVp049yqrO9nnk3mdb/MFQ==
X-Google-Smtp-Source: APBJJlGJrdX/nLoqDtRSoOx1zIs/qfGhjHSgsRR/LbDY3E2Xp30BZn2AhG1gGcSP1SEb7/fOxsHVqw==
X-Received: by 2002:a5d:4dcc:0:b0:314:385d:6099 with SMTP id f12-20020a5d4dcc000000b00314385d6099mr8997377wru.35.1689513452005;
        Sun, 16 Jul 2023 06:17:32 -0700 (PDT)
Received: from [10.0.2.15] ([82.78.167.79])
        by smtp.gmail.com with ESMTPSA id t16-20020a5d49d0000000b003143bb5ecd5sm16436704wrs.69.2023.07.16.06.17.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Jul 2023 06:17:31 -0700 (PDT)
Message-ID: <8d9726de-a9e4-009d-44cc-57d362473bed@tuxon.dev>
Date:   Sun, 16 Jul 2023 16:17:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v6] pwm: atmel: Enable clk when pwm already enabled in
 bootloader
Content-Language: en-US
To:     Guiting Shen <aarongt.shen@gmail.com>, claudiu.beznea@microchip.com
Cc:     linux-pwm@vger.kernel.org, alexandre.belloni@bootlin.com,
        linux-kernel@vger.kernel.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de,
        linux-arm-kernel@lists.infradead.org
References: <20230716020652.18557-1-aarongt.shen@gmail.com>
From:   claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20230716020652.18557-1-aarongt.shen@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_FMBLA_NEWDOM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.07.2023 05:06, Guiting Shen wrote:
> The driver would never call clk_enable() if the PWM channel was already
> enabled in bootloader which lead to dump the warning message "the PWM
> clock already disabled" when turning off the PWM channel.
> 
> Add atmel_pwm_enable_clk_if_on() in probe function to enable clock if
> the PWM channel was already enabled in bootloader.
> 
> Signed-off-by: Guiting Shen <aarongt.shen@gmail.com>

Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>

> ---
>   drivers/pwm/pwm-atmel.c | 47 +++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 45 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
> index cdbc23649032..fc89282db645 100644
> --- a/drivers/pwm/pwm-atmel.c
> +++ b/drivers/pwm/pwm-atmel.c
> @@ -36,7 +36,7 @@
>   #define PWM_SR			0x0C
>   #define PWM_ISR			0x1C
>   /* Bit field in SR */
> -#define PWM_SR_ALL_CH_ON	0x0F
> +#define PWM_SR_ALL_CH_MASK	0x0F
>   
>   /* The following register is PWM channel related registers */
>   #define PWM_CH_REG_OFFSET	0x200
> @@ -464,6 +464,42 @@ static const struct of_device_id atmel_pwm_dt_ids[] = {
>   };
>   MODULE_DEVICE_TABLE(of, atmel_pwm_dt_ids);
>   
> +static int atmel_pwm_enable_clk_if_on(struct atmel_pwm_chip *atmel_pwm, bool on)
> +{
> +	unsigned int i, cnt = 0;
> +	int ret = 0;
> +	u32 sr;
> +
> +	sr = atmel_pwm_readl(atmel_pwm, PWM_SR) & PWM_SR_ALL_CH_MASK;
> +	if (!sr)
> +		return 0;
> +
> +	cnt = bitmap_weight((unsigned long *)&sr, atmel_pwm->chip.npwm);
> +
> +	if (!on)
> +		goto disable_clk;
> +
> +	for (i = 0; i < cnt; i++) {
> +		ret = clk_enable(atmel_pwm->clk);
> +		if (ret) {
> +			dev_err(atmel_pwm->chip.dev,
> +				"failed to enable clock for pwm %pe\n",
> +				ERR_PTR(ret));
> +
> +			cnt = i;
> +			goto disable_clk;
> +		}
> +	}
> +
> +	return 0;
> +
> +disable_clk:
> +	while (cnt--)
> +		clk_disable(atmel_pwm->clk);
> +
> +	return ret;
> +}
> +
>   static int atmel_pwm_probe(struct platform_device *pdev)
>   {
>   	struct atmel_pwm_chip *atmel_pwm;
> @@ -496,16 +532,23 @@ static int atmel_pwm_probe(struct platform_device *pdev)
>   	atmel_pwm->chip.ops = &atmel_pwm_ops;
>   	atmel_pwm->chip.npwm = 4;
>   
> +	ret = atmel_pwm_enable_clk_if_on(atmel_pwm, true);
> +	if (ret < 0)
> +		goto unprepare_clk;
> +
>   	ret = pwmchip_add(&atmel_pwm->chip);
>   	if (ret < 0) {
>   		dev_err(&pdev->dev, "failed to add PWM chip %d\n", ret);
> -		goto unprepare_clk;
> +		goto disable_clk;
>   	}
>   
>   	platform_set_drvdata(pdev, atmel_pwm);
>   
>   	return ret;
>   
> +disable_clk:
> +	atmel_pwm_enable_clk_if_on(atmel_pwm, false);
> +
>   unprepare_clk:
>   	clk_unprepare(atmel_pwm->clk);
>   	return ret;
