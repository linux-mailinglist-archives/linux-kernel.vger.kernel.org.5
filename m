Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D26547C6E5C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 14:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378517AbjJLMjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 08:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378561AbjJLMjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 08:39:12 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA35CA
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 05:39:10 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-32d849cc152so892224f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 05:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697114348; x=1697719148; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SKYKtF8Rs4Df9JqahwPF42+aeaV4P03MLBBouRg8VCs=;
        b=lBeelQmy8Jp8v3LkBLBjIzze0RVfupV6jscYc+Il2wYZvU8cKHvo2nuzQX+It9MnjS
         NAA5l9DGk43hLKiWEnq85gS3h1/9EbwtNVx+OENgFBBAEZGHRdRJLkuBIzVy1UXi+PhJ
         MSqeeFtXHI62tvW4/LDx6Q6ritAxhX2p7ZaqilN6QVrLwGmHIeeGNlxHt0j2wBwDL5QI
         xMv+rnYTK8JjUEIN3JotdE0TvAirf5XAlFzD0ZkcDrgPfN2OsrNiN6GRuNwz2hnJcptj
         AfBc9S82RGSdIVmFKpGtcjaxZW/I1uenBAHJH4mRmsqs9nwuCeWMMqptVPpwGfDPqBbB
         PyQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697114348; x=1697719148;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SKYKtF8Rs4Df9JqahwPF42+aeaV4P03MLBBouRg8VCs=;
        b=Q69yBkgZln/FVPr1Y9nmp4T12jd0GU1gTj7UoPmptz8HWk6ZtqLdrQxWiG6XgpMIeU
         0UPgFb4xCJLwJ3BOf99262NWF13TlggC9ISbvWNMm0hHRI7uaP4ZdPOe9qFC/9JhSqdC
         4xwZdPG98EOgAdiZ/tAR62lX7uPQNWyE3mvLuBplgihSnNeT5xu4II8ydr6iLhY1gJ2v
         2QVXcAqcyLq4r+2kS4mg7rbEBOtQGr//OLDaPe+VfTbR3JLgnJDbu+ZB3POhM9gbEwGw
         CP/edpnLT1QhXLRweboZbHiD+/np57bnomvL0UMGUbPNhTz127uNOR5cUqILvXJ08Szm
         7jZg==
X-Gm-Message-State: AOJu0YxVhcPDeMl7gmjnBQIhKG79gzFjkdLdVMTSv0qrNI1bQgqJuFIA
        O28nst2isNcj+0Dh+HMGvEdJyQ==
X-Google-Smtp-Source: AGHT+IFBWgt+00+f3S0x0ai2M74aG+SX8T3vAsi59DA/kcaO81wHegEjRyQgxUJBa/frUcvaQZKWIg==
X-Received: by 2002:a5d:55ce:0:b0:32d:8ac4:d23f with SMTP id i14-20020a5d55ce000000b0032d8ac4d23fmr2836947wrw.29.1697114348486;
        Thu, 12 Oct 2023 05:39:08 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.100])
        by smtp.gmail.com with ESMTPSA id n4-20020a5d4004000000b003197c7d08ddsm18412766wrp.71.2023.10.12.05.39.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Oct 2023 05:39:08 -0700 (PDT)
Message-ID: <315c152a-da9f-4df8-aa91-9f641a33f1e2@linaro.org>
Date:   Thu, 12 Oct 2023 14:39:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] dt-bindings: media: Document STM32MP25 VDEC & VENC
 video codecs
Content-Language: en-US
To:     Hugues Fruchet <hugues.fruchet@foss.st.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Daniel Almeida <daniel.almeida@collabora.com>,
        Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>, linux-media@vger.kernel.org,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Cc:     Marco Felsch <m.felsch@pengutronix.de>,
        Adam Ford <aford173@gmail.com>
References: <20231010091643.3666290-1-hugues.fruchet@foss.st.com>
 <20231010091643.3666290-2-hugues.fruchet@foss.st.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231010091643.3666290-2-hugues.fruchet@foss.st.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/2023 11:16, Hugues Fruchet wrote:
> Add STM32MP25 VDEC video decoder & VENC video encoder bindings.
> 
> Signed-off-by: Hugues Fruchet <hugues.fruchet@foss.st.com>
> ---
>  .../media/st,stm32mp25-video-codec.yaml       | 58 +++++++++++++++++++
>  1 file changed, 58 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/st,stm32mp25-video-codec.yaml
> 
> diff --git a/Documentation/devicetree/bindings/media/st,stm32mp25-video-codec.yaml b/Documentation/devicetree/bindings/media/st,stm32mp25-video-codec.yaml
> new file mode 100644
> index 000000000000..479566171568
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/st,stm32mp25-video-codec.yaml
> @@ -0,0 +1,58 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/st,stm32mp25-video-codec.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: STMicroelectronics STM32MP25 VDEC video decoder & VENC video encoder
> +
> +maintainers:
> +  - Hugues Fruchet <hugues.fruchet@foss.st.com>
> +
> +description:
> +  The STMicroelectronics STM32MP25 SOCs embeds a VDEC video hardware
> +  decoder peripheral based on Verisilicon VC8000NanoD IP (former Hantro G1)
> +  and a VENC video hardware encoder peripheral based on Verisilicon
> +  VC8000NanoE IP (former Hantro H1).
> +
> +properties:
> +  compatible:
> +    items:

Drop "items", we keep simple enum in such case.

> +      - enum:
> +          - st,stm32mp25-vdec
> +          - st,stm32mp25-venc
> +
> +  reg:
> +    maxItems: 1
> +

...

> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    vdec: video-codec@580d0000 {
> +        compatible = "st,stm32mp25-vdec";
> +        reg = <0x580d0000 0x3c8>;
> +        interrupts = <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>;
> +        clocks = <&ck_icn_p_vdec>;
> +    };
> +  - |
> +    venc: video-codec@580e0000 {
> +        compatible = "st,stm32mp25-venc";
> +        reg = <0x580e0000 0x800>;
> +        interrupts = <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>;
> +        clocks = <&ck_icn_p_venc>;
> +    };

You can drop second example - it is the same as the first.

Best regards,
Krzysztof

