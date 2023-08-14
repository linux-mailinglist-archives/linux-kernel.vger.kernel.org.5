Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25E0477B3AE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 10:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233475AbjHNIQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 04:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234415AbjHNIPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 04:15:41 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB34E5C
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 01:15:40 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-99c0cb7285fso498854866b.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 01:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692000939; x=1692605739;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d4b4KvSQ4zGsIVaW+6y3IlJzRQxCj+lqbCpJjaY0MMI=;
        b=VJP8PZnNiJ+lKNNnZLC469cLYInNdnFluCb07BRhA/mynVb1zuVUDrvLpCv5g9n+dT
         S2b4h04uxgLhpf/FPgYS7dW/bkA8NuoeOTib98GTQz9ceVnpboksa/8IlBiXE48jCLb9
         IUaEn3MfqnSgYzac1pHpTN2ogUK/dVOhMkyOCofnzFvIaXstIpkLx6sivPchUkmWoHm4
         YST8sXLM+PunLl5q1cxabFjpHulGWEnyP7rkMAfEKt2LRg1l7wnUtKP1uUABcpxkmCbv
         yAX9M1S5AV+RIn5y1ECuuZRhqcrTRCIXFrvocY8y2jGyh5xtp2YR3OS7lNYNVI4lzzjo
         MxCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692000939; x=1692605739;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d4b4KvSQ4zGsIVaW+6y3IlJzRQxCj+lqbCpJjaY0MMI=;
        b=IYCrALlfATdoMaY6Ifmoo0wmb5qavcv/RFRB/AQvQTIudV2vgtfQJ/IcoVRD+c0Po/
         /gIXWDChDpu8PgpH3i64/k3NQic4XuJ7UVhnBkYWuRfJE5cTUniHtB3wwRfTKhkuxxy9
         P7HgnDDfZqIwBBS/KbqvFt9AqAR1eSm+1NlS55NNCTaBXoZagjqE/4WQPKcOaQSaM+wE
         sTrBxN/zIWZBgZWc4zuH3tGO94LM16QzvP/uJ6iqZ5dVZ3b7RzOKW/TbPUpYi3gFfPU0
         GoqPSJvFuQRpLj7JEPcAJMMDKmmHAVJePEnW5gP2CWORYG0TqfF3UUioTQeVcJztuWcx
         /JSg==
X-Gm-Message-State: AOJu0YxVjN8xA7gxIH86mvQImlM7Dee+o6ZiKHSz9ojAaSf9Mf5DrTtV
        Pz87WE+Y1AEtBKLUwPRAJmcaXQ==
X-Google-Smtp-Source: AGHT+IGrtnqibpc6tavHhEXSbncUheldK3H6/BVWl6P4Dc0G2arVDH7StgxhOFW9O/wBxmb4ceEmVw==
X-Received: by 2002:a17:906:3018:b0:99b:cf4f:9090 with SMTP id 24-20020a170906301800b0099bcf4f9090mr7026486ejz.66.1692000939269;
        Mon, 14 Aug 2023 01:15:39 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id a10-20020a170906244a00b00992d70f8078sm5378654ejb.106.2023.08.14.01.15.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 01:15:38 -0700 (PDT)
Message-ID: <705309a2-6c7f-8148-770e-75e3d1fe112b@linaro.org>
Date:   Mon, 14 Aug 2023 10:15:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2 4/6] dt-bindings: perf: Add Marvell Odyssey LLC-TAD pmu
Content-Language: en-US
To:     Gowthami Thiagarajan <gthiagarajan@marvell.com>, will@kernel.org,
        mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org
Cc:     sgoutham@marvell.com, bbhushan2@marvell.com, lcherian@marvell.com
References: <20230812142518.778259-1-gthiagarajan@marvell.com>
 <20230812142518.778259-5-gthiagarajan@marvell.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230812142518.778259-5-gthiagarajan@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/08/2023 16:25, Gowthami Thiagarajan wrote:
> Add binding documentation for Marvell Odyssey LLC-TAD performance
> monitor unit
> 
> Signed-off-by: Gowthami Thiagarajan <gthiagarajan@marvell.com>
> ---
> 
> v1->v2
> - Changed DT binding file name to match with compatible
> - Added respective document in MAINTAINERS
> 
>  .../perf/marvell,odyssey-tad-pmu.yaml         | 63 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 64 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/perf/marvell,odyssey-tad-pmu.yaml
> 
> diff --git a/Documentation/devicetree/bindings/perf/marvell,odyssey-tad-pmu.yaml b/Documentation/devicetree/bindings/perf/marvell,odyssey-tad-pmu.yaml
> new file mode 100644
> index 000000000000..a1b9ee71e5f7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/perf/marvell,odyssey-tad-pmu.yaml
> @@ -0,0 +1,63 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/perf/marvell,odyssey-tad-pmu.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Marvell Odyssey LLC-TAD performance monitor
> +
> +maintainers:
> +  - Gowthami Thiagarajan <gthiagarajan@marvell.com>
> +
> +description: |
> +  The Tag-and-Data units (TADs) maintain coherence and contain CN10K
> +  shared on-chip last level cache (LLC). The tad pmu measures the
> +  performance of last-level cache. Each tad pmu supports up to eight
> +  counters.
> +
> +  The DT setup comprises of number of tad blocks, the sizes of pmu
> +  regions, tad blocks and overall base address of the HW.
> +
> +properties:
> +  compatible:
> +    const: marvell,odyssey-tad-pmu
> +
> +  reg:
> +    maxItems: 1
> +
> +  marvell,tad-cnt:
> +    description: specifies the number of tads on the soc

Why would it differ? Each SoC is the same, right? Like factory makes 1
million of the same SoCs, so tad-cnt is the same on each of them

Please drop.

> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  marvell,tad-page-size:
> +    description: specifies the size of each tad page
> +    $ref: /schemas/types.yaml#/definitions/uint32

Same questions.

> +
> +  marvell,tad-pmu-page-size:
> +    description: specifies the size of page that the pmu uses
> +    $ref: /schemas/types.yaml#/definitions/uint32

Same questions.

> +
> +required:
> +  - compatible
> +  - reg
> +  - marvell,tad-cnt
> +  - marvell,tad-page-size
> +  - marvell,tad-pmu-page-size
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +

No need for blank line.

> +    tad {

No clue what tad is, use some generic name.

> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +



Best regards,
Krzysztof

