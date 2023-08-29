Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37F3B78C1FF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 12:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234682AbjH2KIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 06:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbjH2KHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 06:07:52 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 797451B9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 03:07:46 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-99c353a395cso540456266b.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 03:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693303665; x=1693908465;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AK8VKMPKX43G8TnDLhp1uNUtjlZXUueKOCa7XLr7nu0=;
        b=YSgcXrzV8EzGt5SnK8QV9WKK2eCsnGrymS0cstaXZoV3MJzC1pr2WZ5fCKW3Rjtz3r
         IGcNR9wBwOVelFCbvEaJnFcjOg0XORDrphHkqfyT0HXscgwFyd2sPrp8PxSW8xEDdRiZ
         ka1etnCgqCDaTOpOWcxg0jlp3wvj5ZN3Qh+2O77GxbXfXPEcb/tVwP53Y+fNsbiuG8B6
         ePRCj9IrGYQwvg+n4Zz4qacwEFpoMHSkG4WNbym67vYL988ef45acYIJ05irQKNi94nf
         xK8W7Z1584OcP10l3JjCGgSMNXJx8RN7HWwnCNqj/IFWUPKFHVDTUxr8BHniORfIugN0
         i1hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693303665; x=1693908465;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AK8VKMPKX43G8TnDLhp1uNUtjlZXUueKOCa7XLr7nu0=;
        b=IVABIRoLSqEDBPb6MPk9QXOWEOjk+Ha/1pF9I+qkjGhYGrdGgBAlMgFeAwnh4FywbJ
         km0Y8CAmI6iJ++wVKVnxgkGy+e/RiphQFffcbRfjsHf0NYnOF+qHWyz54c5u8Zo1hibj
         9mPBwGcQYhRv+q1OvUqC07HbLg5IfFT306lV+rsWH0Jvi3rGsyK0RMmu3XEcRo73lCW+
         0GS9k9M12AwK9qQQ7fPfvQvilZtl8yexW1KiKyygXPSAEJTWXgCxkaXgfKKXS+uKVP8L
         W7bFb+ewXEWn89d/Se3eAo63AbUs+FDrSO8hO0Wd71V58OARAGO+bXw2qhjWQ/SL/Sin
         PZcg==
X-Gm-Message-State: AOJu0Yz7LnnZKibyAY34p0GKwTmHESS4vEdonb/BqGhyP+u4NY36Jk+x
        TZUTC8sh0+LlHGr89sxQV+zEOA==
X-Google-Smtp-Source: AGHT+IGZZZjXp6j21UbP+1z9NZRDH53mfiuPk9Pm8MPLmROzk+i5V7Dp6uPhDVnIgeesMZcg5P8j1Q==
X-Received: by 2002:a17:906:20c7:b0:9a1:ecb5:732e with SMTP id c7-20020a17090620c700b009a1ecb5732emr13018241ejc.71.1693303664920;
        Tue, 29 Aug 2023 03:07:44 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.196])
        by smtp.gmail.com with ESMTPSA id w24-20020a17090649d800b009930308425csm5761744ejv.31.2023.08.29.03.07.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Aug 2023 03:07:44 -0700 (PDT)
Message-ID: <a0c1d7ab-593d-f693-33aa-c8b7247f5e1d@linaro.org>
Date:   Tue, 29 Aug 2023 12:07:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 11/11] ARM: dts: exynos: disable polling in Odroid
 XU3-related devices
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
 <CGME20230829092426eucas1p222c2a1c2013f4eb9ee739f03761e5236@eucas1p2.samsung.com>
 <20230829091853.626011-12-m.majewski2@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230829091853.626011-12-m.majewski2@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/08/2023 11:18, Mateusz Majewski wrote:
> After having switched to dynamic trip points, we no longer have a
> hardware limit for trip point count and can support as many as we want
> without polling.
> 
> Signed-off-by: Mateusz Majewski <m.majewski2@samsung.com>
> ---
>  .../dts/samsung/exynos5422-odroidxu3-common.dtsi | 16 +++++-----------
>  1 file changed, 5 insertions(+), 11 deletions(-)
> 

This will need to wait for release after driver changes get accepted.
You sent your patchset just after merge window started, so unfortunately
this means it will get in 2 releases.

Best regards,
Krzysztof

