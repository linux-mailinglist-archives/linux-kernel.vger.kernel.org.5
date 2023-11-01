Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E02E7DDCFC
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 08:11:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbjKAHL3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 03:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKAHL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 03:11:28 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C914CF1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 00:11:21 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-54394328f65so900263a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 00:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698822680; x=1699427480; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cdY23XifuOs1pgzJmPJHQdXKP+0gYg26W2EQxD1+XuQ=;
        b=q9u3rkh+MmnaS7htM/tVYU2EYKXgzvUovl8pwJcwLq/L3BDBx07MywdAm+70q4dDE1
         JcfV95jfxGbDw7Z7pwrNyeHtBVKcq/pB88j3n2moJ5gqo+9CypeJU1jHekK63kVWpVbf
         3WpJ5SPNL76/EWWOnDLS+nsKMWPjbIF4kjElGGU3nUlixafwS3HnPla515R+gkKHMCHm
         RLAhHQV6qBrr8lSlH0wpNMDzxnqNyMSeMoFiBehKPjbCRLu5+Fp+Zf5MT7GOdkbwtk5T
         RnPBatlEf9qi9AUHoncaSm61gpfPQsucIxsVX5yOYBXXvD9j0qHef3ml1b2oruiikkmE
         TlGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698822680; x=1699427480;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cdY23XifuOs1pgzJmPJHQdXKP+0gYg26W2EQxD1+XuQ=;
        b=vavOk02aQw3a2rvqtg3jFrg2HeNyVyqDmJ7Ht3XHdjl15zGKcjJaCunAxkuIu15LhX
         cSBhWkJx8hYy4+hFtIn7KKIKQsIbaKSKCHh7Iqlyu10V/Ehji4kdWHEa/LpJTP1Je3aq
         i87CSJVGow9NDMTqTRSvDqCZfRisD2W3CkRxMwJyj0mtTD5IZHkVDqggO8/qhi5BsePG
         xsFmUpz2nCKFtVumBltUMA9cwYMuW6dhKZffaJYxah55gmQ+YQNqL9jgz9hE5ZW5sEv9
         hn8+wOmQrHcDYipdXlfDO+n4ZiP5mfxbxXmJHb8/1BXmjusLLYnJxbMW40ZxSNxn9+mP
         KEVQ==
X-Gm-Message-State: AOJu0YwEL2uoZ9Trnc/TPWDGTGiPPKTrsY/ChTPDZnBhInTiS2ahAkew
        ABZoZ+CBxzq4iVA34pRxHKxxLA==
X-Google-Smtp-Source: AGHT+IEOJBCutFdaggedvDwy/WSV0nAUlYeOUiD0DStd4oMGO31/idO53T+adXsgeS/KwQxT3RMNmQ==
X-Received: by 2002:a05:6402:35c2:b0:53d:be55:5fc with SMTP id z2-20020a05640235c200b0053dbe5505fcmr14428165edc.27.1698822680160;
        Wed, 01 Nov 2023 00:11:20 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id z1-20020aa7c641000000b005402748cf29sm711141edr.50.2023.11.01.00.11.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Nov 2023 00:11:19 -0700 (PDT)
Message-ID: <102d2314-b832-4889-9828-8d532f826652@linaro.org>
Date:   Wed, 1 Nov 2023 08:11:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: phy: Add Spreadtrum usb20 hsphy yaml
Content-Language: en-US
To:     Pu Li <pu.li@unisoc.com>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Zhiyong Liu <zhiyong.liu@unisoc.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231101054432.27509-1-pu.li@unisoc.com>
 <20231101054432.27509-2-pu.li@unisoc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231101054432.27509-2-pu.li@unisoc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/11/2023 06:44, Pu Li wrote:
> Add device tree binding Documentation details for Spreadtrum
> usb20 hsphy driver.
> 
> Signed-off-by: Pu Li <pu.li@unisoc.com>
> ---
>  .../bindings/phy/phy-sprd-usb20-hs.yaml       | 70 +++++++++++++++++++
>  1 file changed, 70 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/phy-sprd-usb20-hs.yaml

Filename matching compatible syntax.

> 
> diff --git a/Documentation/devicetree/bindings/phy/phy-sprd-usb20-hs.yaml b/Documentation/devicetree/bindings/phy/phy-sprd-usb20-hs.yaml
> new file mode 100644
> index 000000000000..102b49d3482e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/phy-sprd-usb20-hs.yaml
> @@ -0,0 +1,70 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright 2020-2023 Unisoc Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/phy-sprd-usb20-hs.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Spreadtrum USB20 High Speed PHY
> +
> +maintainers:
> +  - Pu Li <lip308226@gmail.com>
> +
> +properties:
> +  compatible:
> +    oneOf:

No need for oneOf.

> +      - items:

No need of ritems,

> +          - enum:
> +              - sprd,pike2-phy
> +              - sprd,sharkle-phy
> +              - sprd,sharkl3-phy
> +              - sprd,sharkl5-phy
> +              - sprd,sharkl5pro-phy
> +              - sprd,qogirl6-phy
> +              - sprd,qogirn6lite-phy
> +              - sprd,uis8520-phy

What are these? pike2 is the SoC and the binding covers all phys? All?

> +
> +  reg:
> +    maxItems: 1
> +
> +  reg-names:
> +    const: phy_glb_regs

Drop, not needed for one entry.
> +
> +  sprd,syscon-enable:
> +    description:
> +      Phandle to aon apb syscon register region.

You called it syscon-enable but write aon-apb-syscon. Decide which one.
Also, you need to describe the purpose.

> +    $ref: /schemas/types.yaml#/definitions/phandle
> +
> +  sprd,syscon-ana:
> +    description:
> +      Phandle to analog syscon register region.

Two syscons? Nope, do not use syscons instead of regular abstractions.

> +    $ref: /schemas/types.yaml#/definitions/phandle
> +
> +  sprd,vdd-voltage:
> +    description:
> +      It represents the value of one analog power supply of phy,
> +      the unit is uV.

Then you must use -microvolt unit suffix.

> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  "#phy-cells":
> +    const: 0
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - "#phy-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    hsphy@64570000 {

phy@

> +      compatible = "sprd,qogirl6-phy";


Best regards,
Krzysztof

