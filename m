Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9960E7F72D0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 12:35:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbjKXLev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 06:34:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjKXLes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 06:34:48 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEA7E10E7
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 03:34:51 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9c41e95efcbso253219766b.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 03:34:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700825690; x=1701430490; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yLGESbCFc50J+147aJNRVMMBSaHYgnNxVeCdiwumeiM=;
        b=CuyAjz5nHi+uv5nCltgJwq2mrRrJmpoPTFOwUr/YSnQS9i8rE5cQmYqzkyOb/PKtC7
         9KKkkvdmYAt0SwYTZ/84DSquu7nVPK1XQkPk/0QBgEBO4R2d0ydvPNQAmDpuCQz6zTtN
         tAQmZ8d84UA4jKIjxbnyDFD/ftjKBczQaKdjJXJrwVdOi9UKpyqRxmvTnICc4PqAGm/T
         xt2+8/cc/lgTlSZQ3E0XRfWRYP3rFbjA1D6sAGFFHsfrGMHrSuxOlJO+uHhhRsCOtOx1
         okFmzvxx+E75nbV+UC3G3AhuDLnYH2OEMCJLzk9AKfSAvGquaQK4cOXpydjj7gFaV83P
         +lOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700825690; x=1701430490;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yLGESbCFc50J+147aJNRVMMBSaHYgnNxVeCdiwumeiM=;
        b=kSC7Krw3xllpWKOymEzM4YSauzXgSH4XcCEp+sp0VJ24HkweDOzcnvq9f5/rBxe4UD
         SMCsDt1cEvyuisKjOztzkbIo67FWNx+sqaJC3vXiFJDQoMRelYxlIiqPOE327yesSBmY
         +Y0YYYVJ+BeBs4T6Gn2BdT2ouxJBhOaNaYlQZDhtfyJfkgUm76hyMV/QPAa6M6Bpnd6q
         hVHnUfjQ0whrZKD7O4J9rcO5idgwsDGNnr5lmzvhKnFxuaIdN7CEc2m2ATrltiS+6/Mb
         As3ZQNIVSyejDWCXYnZD9jOrGiAKQbz4Bc8GS1+Oh5M1ciGw5SLpbITuBe5yhqwgdE+R
         75vw==
X-Gm-Message-State: AOJu0Yxal4iZIUIyS5xc46eL0miWL5R4PUm2VAsf5Hx52Xqf0PIrsyPz
        1IxYVX5yBwajJ9cmthzeDvFFVc50azgwqCZni0o=
X-Google-Smtp-Source: AGHT+IHvkn9imfLXJr4obpg2rJD4Teu7AqvSqgkuYbZiQnmPDrN6wzAmp05SXIECdntD6XHt18LnUA==
X-Received: by 2002:a17:906:fa90:b0:9b2:be5e:7545 with SMTP id lt16-20020a170906fa9000b009b2be5e7545mr1792162ejb.36.1700825690024;
        Fri, 24 Nov 2023 03:34:50 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.100])
        by smtp.gmail.com with ESMTPSA id w24-20020a170906b19800b00992e14af9c3sm1985516ejy.143.2023.11.24.03.34.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Nov 2023 03:34:49 -0800 (PST)
Message-ID: <98044f53-7c9c-4e3b-a6f4-c65516e3738d@linaro.org>
Date:   Fri, 24 Nov 2023 12:34:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LINUX PATCH v2 3/3] pwm: pwm-cadence: Add support for TTC PWM
Content-Language: en-US
To:     Mubin Sayyed <mubin.sayyed@amd.com>,
        krzysztof.kozlowski+dt@linaro.org, u.kleine-koenig@pengutronix.de,
        thierry.reding@gmail.com, robh+dt@kernel.org, conor+dt@kernel.org,
        tglx@linutronix.de, daniel.lezcano@linaro.org, michal.simek@amd.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org, git@amd.com,
        mubin10@gmail.com
References: <20231114124748.581850-1-mubin.sayyed@amd.com>
 <20231114124748.581850-4-mubin.sayyed@amd.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231114124748.581850-4-mubin.sayyed@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/11/2023 13:47, Mubin Sayyed wrote:
> Cadence TTC timer can be configured as clocksource/clockevent
> or PWM device. Specific TTC device would be configured as PWM
> device, if pwm-cells property is present in the device tree
> node.
> 

...

> +
> +static struct platform_driver ttc_pwm_driver = {
> +	.probe = ttc_pwm_probe,
> +	.remove_new = ttc_pwm_remove,
> +	.driver = {
> +		.name = "ttc-pwm",
> +		.of_match_table = of_match_ptr(ttc_pwm_of_match),

Drop of_match_ptr(), you will have here warnings.

Best regards,
Krzysztof

