Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24BC578C16D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 11:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232528AbjH2J2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 05:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232102AbjH2J2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 05:28:20 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0501B1BD
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 02:27:46 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-529fb04a234so5551198a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 02:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693301213; x=1693906013;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o84nuugrdjBVbtNkpIQtkBSqIZbVDqCkc1ruQNscXdk=;
        b=EV4t8gBk64D0XNbgSsnnQdVfE2sUW1oNrwheARThIRcTxk/vBcAUmXPz7kChSleWq4
         pYfn5knvM1XECjmUjHb+9yTtTl+MWlK+1vhAnpxxXYBZyoK8FJGYgVHzPRBZhNqwa71Q
         xx0/s1PyDTsKHDDSKjNYJIARMuP/bqGmqYxQ+8XQ2MAT7D5vEDUD/SGxZhZJTTnK8336
         5BJCp5xZjEdgNxfaIfx9wEw+n10FmGxP8SnJihiOcii/DdE9QqJV2GMzuN9K6FpycdWA
         TjdoA88xaL01/BB8bfjSUqwDOSDWQ5vnbl+XKwfddlFO3IsGYeusI7eYWOAG48INynzc
         dZdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693301213; x=1693906013;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o84nuugrdjBVbtNkpIQtkBSqIZbVDqCkc1ruQNscXdk=;
        b=Lvz4SZrngESLLBqk/N3gB60Vjf3p3S961HYmJG9XNr6+UP95WHt+UYAVrnG3RCass+
         sVrVE9S3jkBftz8ds+WNz9OIHEnes15N2QoxKvy0eqpTKUAY6PNq++6w9UlSidPU6uAY
         Ykyna0r86IBd4fswRpABHqWpx+okOnaeDfbjIP5TcK1PX5onm+mhi5jVZN6fy/kzjFLN
         sJGXOMytqKWn2otIyVYfxIBhWU+We0FVsxb/Yg/2n9Sydpro132fNlSmdBv1kwvSOxrn
         rcZDoXeiYXkzpGU0typYrWOUw2gY4ymjcV/J2e+xTojxDuyMsNuvM9NkhBc5H5fa604s
         MwEg==
X-Gm-Message-State: AOJu0YyBKJjxTIi+Rlm4RnyJcBtxs+gxJcmMYamzQ1gSezG4RH5DD90z
        zgXqKVTXG6WJcRRTbLNgx7WC6g==
X-Google-Smtp-Source: AGHT+IFazeQCGVcL7gfIYS4bIY2nP2zweRigE32CaayM42mlnXhdwIYaRIol4X/Jni8R+DMqmHl70g==
X-Received: by 2002:aa7:d5ce:0:b0:523:69bf:2bd3 with SMTP id d14-20020aa7d5ce000000b0052369bf2bd3mr20812353eds.13.1693301212891;
        Tue, 29 Aug 2023 02:26:52 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.196])
        by smtp.gmail.com with ESMTPSA id r14-20020aa7d58e000000b0052a1a623267sm5403877edq.62.2023.08.29.02.26.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Aug 2023 02:26:52 -0700 (PDT)
Message-ID: <d42ae161-df43-d4c0-15e5-60ea06d825ce@linaro.org>
Date:   Tue, 29 Aug 2023 11:26:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 01/11] ARM: dts: exynos: enable polling in Exynos 4210
Content-Language: en-US
To:     Mateusz Majewski <m.majewski2@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
References: <20230829091853.626011-1-m.majewski2@samsung.com>
 <CGME20230829092405eucas1p14543d527d81e8714594ebb999ab5fc02@eucas1p1.samsung.com>
 <20230829091853.626011-2-m.majewski2@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230829091853.626011-2-m.majewski2@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/08/2023 11:18, Mateusz Majewski wrote:
> It seems that thermal in Exynos 4210 is broken without this, as it will
> never decrease cooling after increasing it.
> 
> Signed-off-by: Mateusz Majewski <m.majewski2@samsung.com>
> ---
>  arch/arm/boot/dts/samsung/exynos4210.dtsi | 10 ++++++++--

Please split unrelated patches for different subsystems into separate
patchsets.

>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/samsung/exynos4210.dtsi b/arch/arm/boot/dts/samsung/exynos4210.dtsi
> index 0e27c3375e2e..aae185b7f91c 100644
> --- a/arch/arm/boot/dts/samsung/exynos4210.dtsi
> +++ b/arch/arm/boot/dts/samsung/exynos4210.dtsi
> @@ -391,8 +391,14 @@ &cpu_alert2 {
>  };
>  
>  &cpu_thermal {
> -	polling-delay-passive = <0>;
> -	polling-delay = <0>;
> +	/* Exynos 4210 supports thermal interrupts, but only for the rising threshold.

Linux coding style comments are:

/*
 * Foo bar


Best regards,
Krzysztof

