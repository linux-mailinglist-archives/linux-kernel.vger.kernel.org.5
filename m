Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95E427AFD96
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 10:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbjI0IGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 04:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjI0IGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 04:06:07 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F37BF
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 01:06:06 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-99de884ad25so1333616666b.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 01:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695801964; x=1696406764; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s9lhIWUiEHwYDI/ZE1Mrd+/X49I6RpefneqXYBV0K7o=;
        b=ldLd8GK2hxPdTT50+icZledFOE8HkWRxj9ko2mxp40rjcVmZK2qinsnhIVjdapaGFX
         UqkEsvMrE8qVbPnU1O/BsbWgcAL7dPNXRfV1A6MdAm53k3dZysf2AAa19kz40r3kDOXa
         qY746og5F8K4Dig1FzT3fZSH8FvauhLBRY5F7LiTFHto5pxA+Ud6LhutPTkV54oDVfCQ
         4ZiLTaIQIUdAF+oC+DZ+RV+8TLZXgoDU3BtwMs0W3KMo2H/L7CRRka8sm07jT84GKxii
         gauWXVdQMGh2hsHm912zYK82lZFWPlvd2SsfKgyeHiVSt2fuuLKM++vLNK6tUom7B3hT
         zU/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695801964; x=1696406764;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s9lhIWUiEHwYDI/ZE1Mrd+/X49I6RpefneqXYBV0K7o=;
        b=Rdht1wwuO7Cg/FVr+3lC3i2sYCsEcdl4zWjumxPSQSbNhQ0ebY04yQwXJWqTdbGlmy
         Gv1yt/7vluWFl0vgJwCAeb1z/SX+Ut6KeW2b4pVSR/lGYB99+6LvWX4iVSO+7mOfDXR7
         /XM3ZbkBR0sjv9kWio7/XcLtL0D1dhBfIkebW7AFnQB1QvysJOSwdRilrYEEcJZ8RsnB
         32QW997LdM/5ZtS0LrXCjAopnSTtP68a7WYoW43u1oITRCsXNOpBG8LXgINXc9Pc3eph
         1Kktxy+g1epWMX1KEBXRRQ+X4EkH6VaWmTvmcoT9WpTgqmKJJASrrzJFzrNu3dfgn/Nc
         En+Q==
X-Gm-Message-State: AOJu0YytNJ53VrytbGAVT0DGm91LNJH1+g+ud9YdIDHr1m65BGK6PMzd
        NV4Y8WBHHv0Zr8uL9obn3DjhRw==
X-Google-Smtp-Source: AGHT+IEJHLpBtZHIOgcPBm1iXxyDo1WfxKr99oBFs2g4VeNxtdd/d/vypZAAAShqO3/0yuyisFZMMQ==
X-Received: by 2002:a17:906:d6:b0:9ae:2f33:4ad0 with SMTP id 22-20020a17090600d600b009ae2f334ad0mr1187387eji.71.1695801964602;
        Wed, 27 Sep 2023 01:06:04 -0700 (PDT)
Received: from [192.168.1.162] (host-87-4-82-94.retail.telecomitalia.it. [87.4.82.94])
        by smtp.gmail.com with ESMTPSA id b18-20020a170906039200b009ae5674825asm8886694eja.47.2023.09.27.01.06.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Sep 2023 01:06:04 -0700 (PDT)
Message-ID: <2c351ca0-cee4-4c1b-956b-6134ad101a9a@linaro.org>
Date:   Wed, 27 Sep 2023 10:06:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] dt-bindings: media: imx-jpeg: Assign slot for imx
 jpeg encoder/decoder
Content-Language: en-US
To:     Ming Qian <ming.qian@nxp.com>, mirela.rabulea@oss.nxp.com,
        robh+dt@kernel.org, shawnguo@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        xiahong.bao@nxp.com, eagle.zhou@nxp.com, tao.jiang_2@nxp.com,
        linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230926101000.13392-1-ming.qian@nxp.com>
 <20230926101000.13392-2-ming.qian@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20230926101000.13392-2-ming.qian@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/09/2023 12:10, Ming Qian wrote:
> There are total 4 slots available in the IP, and we only need to use one
> slot in one os, assign a single slot, configure interrupt and power
> domain only for 1 slot, not for the all 4 slots.
> 
> Signed-off-by: Ming Qian <ming.qian@nxp.com>
> ---
> v4
> - improve commit message
> - don't make an ABI break
> v3
> - add vender prefix, change property slot to nxp,slot
> - add type for property slot
> 
>  .../bindings/media/nxp,imx8-jpeg.yaml         | 45 +++++++++----------
>  1 file changed, 21 insertions(+), 24 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml b/Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml
> index 3d9d1db37040..4bcfc815c894 100644
> --- a/Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml
> +++ b/Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml
> @@ -32,19 +32,26 @@ properties:
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
>  
>    power-domains:
>      description:
>        List of phandle and PM domain specifier as documented in
>        Documentation/devicetree/bindings/power/power_domain.txt
> -    minItems: 2               # Wrapper and 1 slot
> -    maxItems: 5               # Wrapper and 4 slots
> +    minItems: 1               # VPUMIX
> +    maxItems: 2               # Wrapper and 1 slot
> +
> +  nxp,slot:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Integer number of slot index used. There are 4 slots available in the IP,
> +      and driver can use a certain slot, it should have an associated interrupt
> +      and power-domain. In theory, it supports 4 os or vm. If not specified, 0
> +      is used by default.
> +    minimum: 0
> +    maximum: 3

NAK, you still did not answer concerns why this is needed and justified.
I keep asking and you keep ignoring...

Best regards,
Krzysztof

