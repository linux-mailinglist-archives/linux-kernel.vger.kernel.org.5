Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9B8766BEF
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 13:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236271AbjG1LlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 07:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236264AbjG1LlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 07:41:17 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A0E3AAC
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 04:41:15 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-98377c5d53eso280238866b.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 04:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690544474; x=1691149274;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=chJum8DsPi4e4yNZjTu0Awky7kqHNb01AFG+BX5GXog=;
        b=wbNMqpMkWwbtQEtoygrsxcf1GfEH82DZi9yoleP9yUVZOTBXVuYjeqX+wJxonNtx8f
         g3qOnKSrXgsVG+9BTUKA4Zc4QGw2S7HPILxucQQX95MNkuIr6gCmIFrE8uB9fQuMCV9d
         0Z7WanmX4M6yHRlWAgck3QH5Zu6Mqbv1yrN8iDisRimsgbrsDMCNqovaFvRbsdxN1oYN
         wRoIPyphAH9HEXsUvCRf+4xvtWbbjWLRTQs988RvDuQuEsRKg5QU2HpckJAeci2Bv0hF
         4J3Qnm/zzyHJ6ivArYRW9czusO1AxBPTtVRH/g830Rarhbsuy+RiSrFJIxQJngHUyHcU
         9+uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690544474; x=1691149274;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=chJum8DsPi4e4yNZjTu0Awky7kqHNb01AFG+BX5GXog=;
        b=R4YPUXuB2rV8bGsmyGqZ3qk6qzZ7CpLJkyo3sz8gig/a3ZnF9ayu9lACyavhMTEGT4
         bgkm8weRIKs/j51X5beJQmOjmcBeZ7OA7WMXSTmvzcGspDcr6D0P1uWY4t10HbRvknr8
         aPj/Qx6oB8ejQPa5uXzD+XsRl8lsK/KPknpACLVu5Vm3sIi2yl61QeLKqCbuQxRxGGKN
         kONzGtrrBnjy4sZDQx8tzSbSwEJc0oFsz7QhpNKPWLMLveVqD4Qlk8qYnIQRf5fVYCSS
         l0Vh5pzqyWcbdAmC8IU/dNSOcNxGGlaZf3+g2WfH2QvGAor3FLB7t7cP3WeR+pV3NHUN
         Dglg==
X-Gm-Message-State: ABy/qLYbQ8Cz47nmmXvN7GMXtU3YQnHlVG0y0/5EjCOap+zh3Ib6a8ej
        TQkAYHojnX1nRDSIKBTUKP0PGw==
X-Google-Smtp-Source: APBJJlHr6hiK/sYO4h5KSRU75Rc6MKS6zTW3yHyDNObUMR/ON5be5+7LRWx3PaqkZ0/XPXFOB8Lguw==
X-Received: by 2002:a17:906:cc50:b0:997:ea90:96b4 with SMTP id mm16-20020a170906cc5000b00997ea9096b4mr2104895ejb.61.1690544474363;
        Fri, 28 Jul 2023 04:41:14 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id p9-20020a1709060dc900b0099bc038eb2bsm1947811eji.58.2023.07.28.04.41.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 04:41:13 -0700 (PDT)
Message-ID: <2899bb14-91ee-3d4c-9cd2-9ce9d92bb46f@linaro.org>
Date:   Fri, 28 Jul 2023 13:41:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 06/50] dt-bindings: reset: atmel,at91sam9260-reset: add
 sam9x7
Content-Language: en-US
To:     Varshini Rajendran <varshini.rajendran@microchip.com>,
        p.zabel@pengutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        claudiu.beznea@microchip.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230728102359.265568-1-varshini.rajendran@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230728102359.265568-1-varshini.rajendran@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/07/2023 12:23, Varshini Rajendran wrote:
> Add documentation for SAM9X7 reset controller.
> 
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> ---
>  .../devicetree/bindings/reset/atmel,at91sam9260-reset.yaml    | 4 ++++


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

