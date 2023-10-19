Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1027CF0FE
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 09:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232891AbjJSHTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 03:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232788AbjJSHTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 03:19:17 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE1AE124
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 00:19:14 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40572aeb6d0so69814785e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 00:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697699953; x=1698304753; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oMk48fNPeMbwiPT4mA/TH80iCg6Ebj3s0QIfDkvnauE=;
        b=rregEQjI6w88i14szei2X1wO719KaM6zQQxiw3NH/zDgQxHbt38LeKjF3I+p1URybQ
         VVyVrQ5nCqqeJ+tcqO2iQ5xEL/yA/pbKn2hrPLMqj1RVG0YrHEHsjy3spyyAwfDAFxBK
         wQ/md2esX+gwA5NVM4iiTQjWowPM9S7bLOePNpq372TYJsYQXKUiTLPJ1YbSE0ip87zC
         WjVJSCdqtk9LG5thTRxTB2aE3QQWuqK/P2V2geRQtPsBOZUmKFFt7eDqgFlut1qB8/44
         oMKrBiPhBMoiyodhGW2Hwx2YdERwa5VFERDQA5F0BKKhOIXQAyBpjwykoK9cU6qDi6+Y
         eloQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697699953; x=1698304753;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oMk48fNPeMbwiPT4mA/TH80iCg6Ebj3s0QIfDkvnauE=;
        b=OdYTN+s/wsbX/9C7vBalexR0Nr7T1ueW6fdRPOwPfzFIU9iYWH0eYhkU5H1+6ZKHDS
         qj5WZL4vUFOUaEwtxa3MwsZyquExPAUrYOqSmim+k/ock0ooHeYunXRXjqcunBMNncgh
         nMbLqH7tVFCc7oxfu4UvzaJv4M8+yP4Xoble3iCeWTqkio5fX6p5OO4ZpqIhmHXjAlPU
         3voKIrwt1cZYJlpJLJd8VMUWeZ+vmqcCYq12IVe/AG/x8zzyMR3qyOaNdHIxvV/wcgOm
         EG+ZvLVOpE7zLinjHNCFNtDMqMWUh5pgdZ6m/XB07LCj1HDZA1ZMJPCow5TN12VlL+UG
         C/ig==
X-Gm-Message-State: AOJu0Yyg7EV060rynEybwJ5P92LBMn2G5MwEFN3XWg1FJdlS/Uq0oK53
        59zI2QPaZgyBnqEe1pxEMQpEMA==
X-Google-Smtp-Source: AGHT+IH22H7cf3TKJw7PfKcUyvqMF1SQ8wGA+P4mbnIzVYBkIArA77tzRFNnMvM3wv80vuC9ESCtYw==
X-Received: by 2002:a05:600c:4f02:b0:405:3885:490a with SMTP id l2-20020a05600c4f0200b004053885490amr1177060wmq.0.1697699953215;
        Thu, 19 Oct 2023 00:19:13 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.49])
        by smtp.gmail.com with ESMTPSA id o30-20020a05600c511e00b004063cd8105csm3683692wms.22.2023.10.19.00.19.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Oct 2023 00:19:12 -0700 (PDT)
Message-ID: <d640f5c2-8af5-4402-a981-0e962d4f2aca@linaro.org>
Date:   Thu, 19 Oct 2023 09:19:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/3] dt-bindings: media: imx-jpeg: Assign slot for imx
 jpeg encoder/decoder
Content-Language: en-US
To:     "Ming Qian (OSS)" <ming.qian@oss.nxp.com>,
        mirela.rabulea@oss.nxp.com, robh+dt@kernel.org, shawnguo@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        xiahong.bao@nxp.com, eagle.zhou@nxp.com, tao.jiang_2@nxp.com,
        ming.qian@nxp.com, linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <cover.1697597713.git.ming.qian@nxp.com>
 <c7995af1f91733626ff4e86f0575dea5d2ff0bb8.1697597713.git.ming.qian@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <c7995af1f91733626ff4e86f0575dea5d2ff0bb8.1697597713.git.ming.qian@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/10/2023 04:48, Ming Qian (OSS) wrote:
> From: Ming Qian <ming.qian@nxp.com>
> 
> This IP includes a jpeg wrapper and a jpeg engine, the wrapper is
> working on descriptor based manner. It supports up to 4 slots, each slot
> can have its own chained descriptors. Host won't configure the engine
> directly, but fill some descriptors to encode or decode one jpeg
> picture. Then configure the descriptors to certain slot register. The
> jpeg wrapper will schedule between different slots. When some slot is
> finished, the slot interrupt will be triggered. The purpose of slot is
> that engine can be shared across multiple VMS and os.
> 
> Currently, power domains and interrupts are enabled for all 4 slots, but
> only one slot is used. There is no benefit in using more that one slot
> from within the same OS, as the slots are scheduled in round-robin
> manner and not executed in parallel.
> 
> Use the property "nxp,slot" to assign a single slot, and just expose the
> parts of the h/w for the assigned slot. For example, only put slot 1's
> power-domains entry in the DT when slot 1 is assigned. If not specified,
> 0 is used by default.
> 
> Signed-off-by: Ming Qian <ming.qian@nxp.com>
> ---
> v5
> - improve commit message
> - improve property description
> 
> v4
> - improve commit message
> - drop line making the property required, to avoid ABI break
> 
> v3
> - add vender prefix, change property slot to nxp,slot
> - add type for property slot
> 
> v2
> - add a new property in bindings document
> 
>  .../bindings/media/nxp,imx8-jpeg.yaml         | 46 +++++++++----------
>  1 file changed, 22 insertions(+), 24 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml b/Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml
> index 3d9d1db37040..0961856bdcab 100644
> --- a/Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml
> +++ b/Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml
> @@ -32,19 +32,27 @@ properties:
>      maxItems: 1
>  
>    interrupts:
> -    description: |
> -      There are 4 slots available in the IP, which the driver may use
> -      If a certain slot is used, it should have an associated interrupt
> -      The interrupt with index i is assumed to be for slot i
> -    minItems: 1               # At least one slot is needed by the driver
> -    maxItems: 4               # The IP has 4 slots available for use
> +    description:
> +      Interrupt number for slot
> +    maxItems: 1

The device still has four interrupts, so we should allow up to four of
them. One given OS might want to use two or all four slots.


>  
>    power-domains:
>      description:
>        List of phandle and PM domain specifier as documented in
>        Documentation/devicetree/bindings/power/power_domain.txt
> -    minItems: 2               # Wrapper and 1 slot
> -    maxItems: 5               # Wrapper and 4 slots
> +    minItems: 1               # Mixed power domain
> +    maxItems: 2               # Wrapper and 1 slot
> +
> +  nxp,slot:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Integer number of slot index used. This IP includes a jpeg wrapper, the
> +      wrapper is working on descriptor based manner. It supports up to 4 slots,
> +      each slot can have its own chained descriptors. The purpose is to share
> +      the jpeg engine across multiple VMS and os. We use this property to
> +      assign a single slot. If not specified, 0 is used by default.
> +    minimum: 0
> +    maximum: 3

default: 0



Best regards,
Krzysztof

