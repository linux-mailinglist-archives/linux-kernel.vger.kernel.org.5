Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9018B784ACA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 21:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbjHVTra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 15:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjHVTr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 15:47:29 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71E25CD0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 12:47:24 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-99bc9e3cbf1so1004217166b.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 12:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692733643; x=1693338443;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wP8V56gMXjaMA8xuJivdqqb4a/TtPfVwzUH0TySnGFk=;
        b=LPcyBY6Q4QNpkQalwXGTtYZCiFulPmXItYy3/b8aUob4oxkCVmmRoW1RvqYR1saZM6
         wU5t4iP9L3wAty3cpb5TpDB9FVXbEqDs4Com3WHkbRwOHu/mzB7Zj+kVNerKiZl75Abl
         Crs2stECCBhYREA06BMqTSX0HW2BAZB/TQx5AyZ+JoHONbvFgQcM2XJtKCUSJc0bL87a
         31pWTfq1F4Zl7ZONEWWif7SLFEvcW3+VjebjI69zb1QsMwIdHkk3jvf/Zow1Z1Sz+q2C
         bhxr4MIdWMgcnXi6MBNfA5xLM28ZzQSXxBCF+3kgCZV3nBFTmaNVJubSFp3xdo5Y6mmC
         HN1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692733643; x=1693338443;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wP8V56gMXjaMA8xuJivdqqb4a/TtPfVwzUH0TySnGFk=;
        b=OK6ToooJMe4RHM7LSBzVJ2ETGOyRXHm1dghBU9is3THHSCv1Z+8vIZ+sVO6YtvX9X2
         eEU8dL4aZsJ834But1fS4gghStduE2ezyw/dnt4WSOeHUjCo6LEuyYN7CPIEipTbJ2oV
         z81ZgkNfScuYR4KyR3+ZyPKE5nCvqsKUaMn0ffWkALh5mH0njRJhJcCmLlxf/IWltCls
         v58lx/4KB5cZYUT+ZAPlwRyDgOn6kQM3IglVD9H6S1ILvsI8UbCg+SdgrMgo+pxNGqTf
         yHg0Sik/gu1OMSWWfSUp47M2psnk0SGAQFhCubdj9uGS6f2Et6wY+Vjs8DeszZxPfuZp
         UySw==
X-Gm-Message-State: AOJu0YyOK2EqeOg94LIK6H2tsxp9VptAEtYlDfDD5U010j8UyZGgl6gU
        yt8yb3LfYosTPZxsPN962Y1U2Q==
X-Google-Smtp-Source: AGHT+IFA6vaH037bqItmbCjTD2cq16Ead293Dy7L2D+0FCyaqdqwV2We88f45rka1i6WgI/a9bPy5w==
X-Received: by 2002:a17:906:c116:b0:993:f664:ce25 with SMTP id do22-20020a170906c11600b00993f664ce25mr11084012ejc.19.1692733642939;
        Tue, 22 Aug 2023 12:47:22 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id n12-20020a170906688c00b00982be08a9besm8870178ejr.172.2023.08.22.12.47.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Aug 2023 12:47:22 -0700 (PDT)
Message-ID: <5ad5ff92-1367-ba96-b126-da80511a2769@linaro.org>
Date:   Tue, 22 Aug 2023 21:47:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2 03/11] regulator: dt-bindings: mt6358: Convert to DT
 schema
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Zhiyong Tao <zhiyong.tao@mediatek.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230822084520.564937-1-wenst@chromium.org>
 <20230822084520.564937-4-wenst@chromium.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230822084520.564937-4-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/08/2023 10:45, Chen-Yu Tsai wrote:
> Convert this from the old style text based binding to the new DT schema
> style. This will make adding the MT6366 portion easier.
> 
> The examples have been trimmed down considerably, and the remaining
> entries now match what is seen in actual device trees.

...

> +---
> +$id: http://devicetree.org/schemas/regulator/mediatek,mt6358-regulator.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek MT6358 Regulator
> +
> +maintainers:
> +  - Zhiyong Tao <zhiyong.tao@mediatek.com>
> +
> +description: |

Do not need '|' unless you need to preserve formatting.

> +  Regulator node of the PMIC. This node should under the PMIC's device node.
> +  All voltage regulators provided by the PMIC are described as sub-nodes of
> +  this node.
> +
> +properties:
> +  compatible:
> +    const: mediatek,mt6358-regulator
> +
...


> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/regulator/mediatek,mt6397-regulator.h>

mt6397?

> +
> +    regulator {
> +        compatible = "mediatek,mt6358-regulator";
> +
> +        buck_vgpu {
> +            regulator-name = "vgpu";
> +            regulator-min-microvolt = <625000>;
> +            regulator-max-microvolt = <900000>;
> +            regulator-ramp-delay = <6250>;
> +            regulator-enable-ramp-delay = <200>;
> +            regulator-allowed-modes = <MT6397_BUCK_MODE_AUTO

mt6397?

Both cases look a bit confusing.

Best regards,
Krzysztof

