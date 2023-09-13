Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA0F79E1D8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 10:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238494AbjIMITH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 04:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232223AbjIMITF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 04:19:05 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC15199D
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 01:12:01 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-50079d148aeso11166292e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 01:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694592719; x=1695197519; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Eia8zDzv+HtcosL0sFP1xVfmwcdZSEW7E/46TEr37W0=;
        b=aPG7MYuphs06h2MiTJoIP3w48iXxygjRv9Wpg3RbzNSW88KW0dDZ/duMIsBR4eDWOY
         q58R68pCXif+VM1LZCGpgo5Tf8dTUEFLdIKNkc7NSUwQZ8Sy4vPOFPFcjN5Mm9Q89vYH
         IyaGKkuDz6J65ipA/W016TopVjK8q6XN98QXf8BHnYKn1m5+ZYJEbUuLi/BH45+vIrvj
         WLyNP+G8kfZe/3MtEkHAbnVM3JpiysEnYjuo9kGdVBto2mzDkOPU2tEfa4w7Z5VRkB+6
         ePUHT6OFormAetsQsFd/VMoMEPkMYXsR/xTP0DybdjMdLaCK9avO3wFIsjt5RsYB/7Wy
         zY4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694592719; x=1695197519;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Eia8zDzv+HtcosL0sFP1xVfmwcdZSEW7E/46TEr37W0=;
        b=ipNIZ7oesIveGKof71e8K3XdOsS3mC41KEo3isQxOFowQ65KVErXR7Q7MsRVgy3r0g
         OiBJbrBO7OxDayzFIG6ktNOYFUqnIbn6hWfooaDhqedFsP3whAojWDN3KE554BXrJAxV
         vIcIV9zfVvJRxAf7YcrIvK3NtYQJTL/DAh6hly1FBhyAvNZ/APDSIVbChZ+yPIVVdki4
         IGisUz/LD2IqFUDNLpPbRR42kTDS03shezTSXd6y+UsL+VdQmKlg9TnkVt4F3slO8460
         6iq5kr70XUoVhqXNlQ5bjjkhjY99QZitxpktkoKE8AJwc/5QhVrk7xqzq6Q4J0U2Jlam
         Qi2A==
X-Gm-Message-State: AOJu0Yw7/XchI/DYGQ2DhWQWM/SA5agoRcfnpmAvrmlhQCoRisjyUqbZ
        5pjtiw8A+fhyZ6nqosCuJNor9A==
X-Google-Smtp-Source: AGHT+IHp5o0wXS0xcvX2jwn9i5O9G2Ix9P6EWjUc3OAKHKI6CAMbJiUEbTX5kD1YW/2b/KBnTbb5rA==
X-Received: by 2002:a05:6512:551:b0:4fb:8435:3efc with SMTP id h17-20020a056512055100b004fb84353efcmr1283002lfl.16.1694592719163;
        Wed, 13 Sep 2023 01:11:59 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id v1-20020a5d6b01000000b0031f300a4c26sm14741521wrw.93.2023.09.13.01.11.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 01:11:58 -0700 (PDT)
Message-ID: <bf9a07ff-5628-05ab-2362-a917d3d38313@linaro.org>
Date:   Wed, 13 Sep 2023 10:11:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2 4/7] thermal: exynos: simplify regulator
 (de)initialization
Content-Language: en-US
To:     Mateusz Majewski <m.majewski2@samsung.com>,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
References: <20230911133435.14061-1-m.majewski2@samsung.com>
 <CGME20230911133616eucas1p10c5eeb0f0240dde975ccc5935cb5c311@eucas1p1.samsung.com>
 <20230911133435.14061-5-m.majewski2@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230911133435.14061-5-m.majewski2@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/09/2023 15:34, Mateusz Majewski wrote:
> This does reduce the error granularity a bit, but the code
> simplification seems to be worth it.
> 
> Signed-off-by: Mateusz Majewski <m.majewski2@samsung.com>
> ---
>  drivers/thermal/samsung/exynos_tmu.c | 33 +++++++---------------------
>  1 file changed, 8 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
> index ba9414b419ef..8451deb65f43 100644
> --- a/drivers/thermal/samsung/exynos_tmu.c
> +++ b/drivers/thermal/samsung/exynos_tmu.c
> @@ -157,7 +157,6 @@ enum soc_type {
>   * @reference_voltage: reference voltage of amplifier
>   *	in the positive-TC generator block
>   *	0 < reference_voltage <= 31
> - * @regulator: pointer to the TMU regulator structure.
>   * @tzd: pointer to thermal_zone_device structure
>   * @ntrip: number of supported trip points.
>   * @enabled: current status of TMU device
> @@ -183,7 +182,6 @@ struct exynos_tmu_data {
>  	u16 temp_error1, temp_error2;
>  	u8 gain;
>  	u8 reference_voltage;
> -	struct regulator *regulator;
>  	struct thermal_zone_device *tzd;
>  	unsigned int ntrip;
>  	bool enabled;
> @@ -994,42 +992,34 @@ static int exynos_tmu_probe(struct platform_device *pdev)
>  	 * TODO: Add regulator as an SOC feature, so that regulator enable
>  	 * is a compulsory call.
>  	 */
> -	data->regulator = devm_regulator_get_optional(&pdev->dev, "vtmu");
> -	if (!IS_ERR(data->regulator)) {
> -		ret = regulator_enable(data->regulator);
> -		if (ret) {
> -			dev_err(&pdev->dev, "failed to enable vtmu\n");
> -			return ret;
> -		}
> -	} else {
> -		if (PTR_ERR(data->regulator) == -EPROBE_DEFER)
> +	ret = devm_regulator_get_enable_optional(&pdev->dev, "vtmu");
> +	if (ret) {
> +		if (ret == -EPROBE_DEFER)
>  			return -EPROBE_DEFER;
> -		dev_info(&pdev->dev, "Regulator node (vtmu) not found\n");
> +		dev_info(&pdev->dev, "Failed to get regulator node (vtmu)\n");

This is not equivalent. If regulator is provided and enable fails, the
old code is nicely returning error. Now, it will print misleading
message - failed to get regulator - and continue.

While this simplifies the code, it ignores important running condition -
having regulator enabled.

Best regards,
Krzysztof

