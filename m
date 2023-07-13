Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9107C75220F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 15:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233464AbjGMNA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 09:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjGMNAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 09:00:25 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E8F81BF0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 06:00:21 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fbc77e76abso5849015e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 06:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689253219; x=1691845219;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BlrjL2Qse3Qh0f0nxQtFO3PHH8HvzbeF2y5rIxOXdos=;
        b=UrH2359fSWdzvyfUZqVcgo6QwELKcnoSTo4ZyfHUcOl/8YTMeWPp0UKTGcBXNHDePv
         8ibW/AKfM3j3zr4lybJwxbPz5m+Of59qKvYAP9tEQMKzEE3z5tb14lTX6cZRHuAYcP8L
         GOz5NHfuM8TfPJX56GtaRelExnfN/Y0tLrZ9uN7im5wgt3SXD1qzGYfufHRR5chIhHKC
         gXB5FxHCCDMm/6DpcSaFt7IpTP5PpCnwFg9+JFvrSia12zvj7t01FLS1wRkcMWMzE4K1
         lfMXdKlQsYoljqEPP4yXdyMEKOoEenLBPbDKFT2uacGFKgia7PxflhfJfwJt7Q1GtEvY
         19eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689253219; x=1691845219;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BlrjL2Qse3Qh0f0nxQtFO3PHH8HvzbeF2y5rIxOXdos=;
        b=EW0O0T7E3x4LgLpQGVOuSYzd6ACFcEpkkSbc9Lhmr6DW3kgnEFgXirUb65G2Zd4BiW
         7bvXSUbyTqXHsf9wBvP7cMH7lITQPspkclcVOSibTpSIlHVBy9MNqXL3dWLzPfqAsCeX
         ck5Q57ffRuG8ClF2qjtH0sJ8k2ODox2RV13o+SvV+XD+Q1OdFHlMmHxuSi09wfFP5Gwx
         aBLT4wCtdQDNuTtF3DZvJlI9aZ6JeO1Z8aOf2/AQNVpmTp5yq9aYMEEiY/ckFBDhvF1g
         TFc0xNXCZYwvLQHH9MJgYV2PSaPSCkv/by4lEkx774ftsssghF6gOspohebrdlPhvwAC
         /c8w==
X-Gm-Message-State: ABy/qLa3lDZ73cIWEnPOBXPVs0i9PrFWNZRcBnp7KMIeOsaP3rU76uM6
        +H89I1jQAUtK8LggZJoYjBSL9w==
X-Google-Smtp-Source: APBJJlGW4qBAshsKSJMXvfuhab1DNGBKrv8tQ12EQpoccoqOHZbA5T6z6/EJeQ0anX2QyFBgyPQqSQ==
X-Received: by 2002:a1c:f213:0:b0:3f9:b19c:aab4 with SMTP id s19-20020a1cf213000000b003f9b19caab4mr1235107wmc.6.1689253219433;
        Thu, 13 Jul 2023 06:00:19 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id o7-20020a5d6707000000b002c70ce264bfsm7924515wru.76.2023.07.13.06.00.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 06:00:19 -0700 (PDT)
Message-ID: <6e8b64f1-a285-227c-c335-c0dd0e683b50@linaro.org>
Date:   Thu, 13 Jul 2023 15:00:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/2] thermal/of: Add error information printing for
 devm_thermal_of_zone_register()
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230711124513.47771-1-frank.li@vivo.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230711124513.47771-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/07/2023 14:45, Yangtao Li wrote:
> Ensure that all error handling branches print error information. In this
> way, when this function fails, the upper-layer functions can directly
> return an error code without missing debugging information. Otherwise,
> the error message will be printed redundantly or missing.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>   drivers/thermal/thermal_of.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
> index 6fb14e521197..8ce231f7639a 100644
> --- a/drivers/thermal/thermal_of.c
> +++ b/drivers/thermal/thermal_of.c
> @@ -583,11 +583,14 @@ struct thermal_zone_device *devm_thermal_of_zone_register(struct device *dev, in
>   
>   	ptr = devres_alloc(devm_thermal_of_zone_release, sizeof(*ptr),
>   			   GFP_KERNEL);
> -	if (!ptr)
> +	if (!ptr) {
> +		dev_err(dev, "Failed to allocate device resource data\n");
>   		return ERR_PTR(-ENOMEM);
> +	}
>   
>   	tzd = thermal_of_zone_register(dev->of_node, sensor_id, data, ops);
>   	if (IS_ERR(tzd)) {
> +		dev_err(dev, "Failed to register thermal zone: %d\n", PTR_ERR(tzd));

Not sure if having this error is useful as we already have an error 
showing up with the thermal_of_zone_register() function

>   		devres_free(ptr);
>   		return tzd;
>   	}

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

