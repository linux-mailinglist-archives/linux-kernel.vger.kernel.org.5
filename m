Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8575D7EB848
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 22:11:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232606AbjKNVLF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 16:11:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjKNVLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 16:11:03 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65300C3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 13:10:59 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-41cb615c6fbso37019601cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 13:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699996258; x=1700601058; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZCXP/b8LzUbZXJ5PFHY6mEdodKrFpUi38A/VBViCSxw=;
        b=D2ofLG3AXExOTX0r6tAvYyqS2IrBX2jsoHNn6euJ/3Eg/14u4C25mwieVENwnyTCR6
         wV1BFT7Y9QwDhea4T1YBiJac/8HSt0l62FYNCgP7yanLdEMfcGqBVoG6LSX4sF9uB8iI
         nCV/4LsIYrPXKxy9W62wUMvn2TZvi4KtRMTf9nnfwfKS8nqlbYg1Ms56oCB3MNPIht7C
         ZrP6/3DPi0Y3hOxPApOtiCm3x+fnie3fJ6s3DWZ8nKoTcFCGUoexOJZGCShLLIgcwLF3
         rWLC6uFOc4tbn/06HaTQc5eIIT8kL58u2lA+n0Tatw1hjgfpIP/CCJnQS6uDNiswRQO+
         WHKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699996258; x=1700601058;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZCXP/b8LzUbZXJ5PFHY6mEdodKrFpUi38A/VBViCSxw=;
        b=U7uHPjIDYKBrPNhJAfOZR77r/TeMGECC940oFZm28JFq5DBD4mTNE/D0SPqcqCMATW
         cwD7LFdvwIooIgk4FAh2Jzk56Je3kyDpNs+WzquK8ZatzxziwcbQA7GxwhYh7s6IrKQh
         s0WhjRQbbYRwVp0srrVht/gEKhB0IuZ5emmrCFlmEZiX5TrqMaufhy8WNfuQIW5XogP9
         fufwMyS8euxuGsKovzHsttHZ5PBBsmnBUp8UvCHVQse48Tjks2viYc8lnspFx0v3Qabe
         ERe4Ow0GWjNebTb0/7a4YHBvpPPwzgNBilc55DYpWJ07A3MOPVoyB/lyVmYHZmwhFzNz
         2Wfw==
X-Gm-Message-State: AOJu0YwnGl5iGV6rGu2H1H1oTV8/oVotOqGKGD1OpZqtyVXbwnjddZwV
        6W6Ol3KpN9OzrBlxn3iGnn8dbw==
X-Google-Smtp-Source: AGHT+IFefyC3sxzLwG0/nBnVrInr3jKA66qN98yn8IDD86CKaKKsF87Tee3Yzk8d9QCtShVFFkzeUQ==
X-Received: by 2002:a05:622a:284:b0:41e:204b:f947 with SMTP id z4-20020a05622a028400b0041e204bf947mr4293209qtw.62.1699996258545;
        Tue, 14 Nov 2023 13:10:58 -0800 (PST)
Received: from [172.25.83.73] ([12.186.190.2])
        by smtp.gmail.com with ESMTPSA id o2-20020ac841c2000000b0041803dfb240sm3022260qtm.45.2023.11.14.13.10.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Nov 2023 13:10:58 -0800 (PST)
Message-ID: <d37db10b-f9fa-49b0-8b1e-36e20acbcfd6@linaro.org>
Date:   Tue, 14 Nov 2023 22:10:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LINUX PATCH v2 1/3] clocksource: timer-cadence-ttc: Do not probe
 TTC device configured as PWM
Content-Language: en-US
To:     Mubin Sayyed <mubin.sayyed@amd.com>,
        krzysztof.kozlowski+dt@linaro.org, u.kleine-koenig@pengutronix.de,
        thierry.reding@gmail.com, robh+dt@kernel.org, conor+dt@kernel.org,
        tglx@linutronix.de, daniel.lezcano@linaro.org, michal.simek@amd.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org, git@amd.com,
        mubin10@gmail.com
References: <20231114124748.581850-1-mubin.sayyed@amd.com>
 <20231114124748.581850-2-mubin.sayyed@amd.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231114124748.581850-2-mubin.sayyed@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/11/2023 13:47, Mubin Sayyed wrote:
> TTC device can act either as clocksource/clockevent or
> PWM generator, it would be decided by pwm-cells property.
> TTC PWM feature would be supported through separate driver
> based on PWM framework.
> 
> If pwm-cells property is present in TTC node, it would be
> treated as PWM device, and clocksource driver should just
> skip it.
> 
> Signed-off-by: Mubin Sayyed <mubin.sayyed@amd.com>
> ---
> Changes for v2:
>     - Added comment regarding pwm-cells property
> ---
>  drivers/clocksource/timer-cadence-ttc.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/clocksource/timer-cadence-ttc.c b/drivers/clocksource/timer-cadence-ttc.c
> index 32daaac9b132..f8fcb1a4bdd0 100644
> --- a/drivers/clocksource/timer-cadence-ttc.c
> +++ b/drivers/clocksource/timer-cadence-ttc.c
> @@ -477,6 +477,13 @@ static int __init ttc_timer_probe(struct platform_device *pdev)
>  	u32 timer_width = 16;
>  	struct device_node *timer = pdev->dev.of_node;
>  
> +	/*
> +	 * If pwm-cells property is present in TTC node,
> +	 * it would be treated as PWM device.
> +	 */
> +	if (of_property_read_bool(timer, "#pwm-cells"))
> +		return -ENODEV;

You will introduce dmesg errors, so regressions.

This does not look right. What you want is to bind one device driver and
choose different functionality based on properties.

Best regards,
Krzysztof

