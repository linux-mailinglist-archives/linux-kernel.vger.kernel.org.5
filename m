Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB086783B84
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 10:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233717AbjHVIOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 04:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233721AbjHVIOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 04:14:45 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B89196
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 01:14:43 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-99d937b83efso537465066b.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 01:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692692082; x=1693296882;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UcevB7am2pXeP5lqY50CZLpg9C14+QBxX9cH++gplMk=;
        b=ulHC1p5RFSlmcCJ/iqa2uNeOtQCu/getFfhJm7Zc/LHNNdL4h+XXi8GFR5Ed3OCtGZ
         1kNb8rNkW0DOHkrk0Rz8KTOiVyg2B0fdzw5OjbtKrQOO4J7iQAiiGzdngEijHAkB7z90
         YR7FKFsT+wn1cM8K7DGdTMZ4iKt7eX1bIunvf6XQeNaYT2FqI762hBjpGamvzfWtRcPC
         yK6JMZM2OIxjdREEkPqVN7JGCKjuXL7puf3OOUz6M61Xb+DlKhHQcTd5jFJ5WB8U5AM8
         JPim9SByzY/xbnd5RhYxMY/g5vg/JTaHE34CczXh0s1L3V9ggG3kpwvl6GrNjPwsd9wT
         RQnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692692082; x=1693296882;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UcevB7am2pXeP5lqY50CZLpg9C14+QBxX9cH++gplMk=;
        b=dHoULYNeIqJxyUhkQmsnXmyIW0AlxDRxSr8HgqmiDOCiw0wYHdxur5q3cmn+Td1UE9
         /NpvNJrBbvdS1l9pHehie0n+DBP1r3MSQ1qs+BbLWAOJ4tTCLJANvRctZqTtTCwLAgyz
         YKTypisp3PQiiyE76wq6qZK3d/6yj8aBrDNSw/SM03AhdU7ApOXHVF4mlLoD+giYA2hc
         kKWZFAq5/uy2jiaP8x62tAiEveZE3hv6L87U3zziTE45rHZE4OzrzNsiwuiGS6saMsQn
         z2k6zSYXOdKYb5aOj8VEjIW49MYN0VY6OHfWgVOvN3fQgUu75gAh+LAfbeYFWAjmgQ6F
         JMGA==
X-Gm-Message-State: AOJu0YyIQiP0uia257kpSJ34RVkVv5+iCBVJYZlXO9JMvnkXNZbBTKeg
        0kUvEPn1AYsVphhhCmaJVTgTbA==
X-Google-Smtp-Source: AGHT+IGtKfT4WD2eA78KlisViKcPwv4slLcoTtQRurM0VXYw54htN9Rs67jp21lp8SezCPKmCqgnyA==
X-Received: by 2002:a17:906:3017:b0:9a1:649b:46f9 with SMTP id 23-20020a170906301700b009a1649b46f9mr6558539ejz.74.1692692081945;
        Tue, 22 Aug 2023 01:14:41 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id m7-20020a17090679c700b009875a6d28b0sm7748312ejo.51.2023.08.22.01.14.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Aug 2023 01:14:41 -0700 (PDT)
Message-ID: <063c70e6-8ee4-eac9-e0ce-7fc460d58c1f@linaro.org>
Date:   Tue, 22 Aug 2023 10:14:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 1/2] dt-bindings: spi: Convert sprd spi bindings to yaml
Content-Language: en-US
To:     Jiansheng Wu <jiansheng.wu@unisoc.com>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        yongzhi.chen@unisoc.com, xiaoqing.wu@unisoc.com,
        jinfeng.lin1@unisoc.com, jianshengwu16@gmail.com
References: <20230822075113.25506-1-jiansheng.wu@unisoc.com>
 <20230822075113.25506-2-jiansheng.wu@unisoc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230822075113.25506-2-jiansheng.wu@unisoc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/08/2023 09:51, Jiansheng Wu wrote:
> Convert sprd,sc27xx-pmic.txt to yaml, and add UMP962x series PMICs.
> 
> Signed-off-by: Jiansheng Wu <jiansheng.wu@unisoc.com>

Subject is bogus. This is not SPI.

> ---
>  .../bindings/mfd/sprd,sc27xx-pmic.txt         | 40 ---------
>  .../bindings/mfd/sprd,sc27xx-pmic.yaml        | 84 +++++++++++++++++++
>  2 files changed, 84 insertions(+), 40 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mfd/sprd,sc27xx-pmic.txt
>  create mode 100644 Documentation/devicetree/bindings/mfd/sprd,sc27xx-pmic.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mfd/sprd,sc27xx-pmic.txt b/Documentation/devicetree/bindings/mfd/sprd,sc27xx-pmic.txt
> deleted file mode 100644
> index 21b9a897fca5..000000000000
> --- a/Documentation/devicetree/bindings/mfd/sprd,sc27xx-pmic.txt
> +++ /dev/null
> @@ -1,40 +0,0 @@
> -Spreadtrum SC27xx Power Management Integrated Circuit (PMIC)
> -
> -The Spreadtrum SC27xx series PMICs contain SC2720, SC2721, SC2723, SC2730
> -and SC2731. The Spreadtrum PMIC belonging to SC27xx series integrates all
> -mobile handset power management, audio codec, battery management and user
> -interface support function in a single chip. It has 6 major functional
> -blocks:
> -- DCDCs to support CPU, memory.
> -- LDOs to support both internal and external requirement.
> -- Battery management system, such as charger, fuel gauge.
> -- Audio codec.
> -- User interface function, such as indicator, flash LED and so on.
> -- IC level interface, such as power on/off control, RTC and typec and so on.
> -
> -Required properties:
> -- compatible: Should be one of the following:
> -	"sprd,sc2720"
> -	"sprd,sc2721"
> -	"sprd,sc2723"
> -	"sprd,sc2730"
> -	"sprd,sc2731"
> -- reg: The address of the device chip select, should be 0.
> -- spi-max-frequency: Typically set to 26000000.
> -- interrupts: The interrupt line the device is connected to.
> -- interrupt-controller: Marks the device node as an interrupt controller.
> -- #interrupt-cells: The number of cells to describe an PMIC IRQ, must be 2.
> -- #address-cells: Child device offset number of cells, must be 1.
> -- #size-cells: Child device size number of cells, must be 0.
> -
> -Example:
> -pmic@0 {
> -	compatible = "sprd,sc2731";
> -	reg = <0>;
> -	spi-max-frequency = <26000000>;
> -	interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
> -	interrupt-controller;
> -	#interrupt-cells = <2>;
> -	#address-cells = <1>;
> -	#size-cells = <0>;
> -};
> diff --git a/Documentation/devicetree/bindings/mfd/sprd,sc27xx-pmic.yaml b/Documentation/devicetree/bindings/mfd/sprd,sc27xx-pmic.yaml
> new file mode 100644
> index 000000000000..590970a17143
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/sprd,sc27xx-pmic.yaml
> @@ -0,0 +1,84 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/sprd,sc27xx-pmic.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: |
> +  Spreadtrum SC27xx and UMP96xx Power Management Integrated Circuit (PMIC)
> +
> +maintainers:
> +  - Orson Zhai <orsonzhai@gmail.com>
> +  - Baolin Wang <baolin.wang7@gmail.com>
> +  - Chunyan Zhang <zhang.lyra@gmail.com>
> +
> +description: |
> +  The Spreadtrum SC27xx series PMICs contain SC2720, SC2721, SC2723, SC2730, SC2731
> +  and UMP96xx series PMICs contain ump9620, ump962 and ump9622. The Spreadtrum PMIC
> +  belonging to SC27xx series and ump962x series integrates all mobile handset power
> +  management, audio codec, battery management and user interface support function in
> +  a single chip. It has 6 major functional.
> +
> +blocks:

Please don't use confusing YAML syntax.

> +  - DCDCs to support CPU, memory.
> +  - LDOs to support both internal and external requirement.
> +  - Battery management system, such as charger, fuel gauge.
> +  - Audio codec.
> +  - User interface function, such as indicator, flash LED and so on.
> +  - IC level interface, such as power on/off control, RTC and typec and so on.
> +
> +allOf:
> +  - $ref: /schemas/spi/sprd,spi-adi.yaml#

This is confusing. How is this device a SPI controller? You have
entirely different compatibles, so no, it's wrong. Missing ref to
spi-peripheral properties. See other bindings.

> +
> +properties:
> +  compatible:
> +    enum:
> +      - sprd,sc2720
> +      - sprd,sc2721
> +      - sprd,sc2723
> +      - sprd,sc2730
> +      - sprd,sc2731
> +      - sprd,ump9620
> +      - sprd,ump9621
> +      - sprd,ump9622

This does not match your previous bindings and nothing is explained in
commit msg.

> +
> +  reg:
> +    maxItems: 7
> +    description: The address of the device chip select

7 items? No way.

> +
> +  spi-max-frequency:
> +    default: 26000000
> +
> +  interrupts: true

You need constraints.

> +
> +  interrupt-controller:
> +    description: Marks the device node as an interrupt controller.

Drop description. ": true" instead

> +
> +  interrupt-cells:
> +    const: 2
> +    description: The number of cells to describe an PMIC IRQ, must be 2.

You did not test it.

> +
> +required:
> +  - compatible
> +  - reg
> +  - spi-max-frequency
> +  - '#address-cells' # Child device offset number of cells, must be 1.

??

> +  - '#size-cells' # Child device size number of cells, must be 0.

?? No way. You do not have any children. Drop bogus properties and
explain it in commit msg.

> +
> +unevaluatedProperties: false
> +
> +Example:
> +  - |
> +    adi_bus {

No underscores in node names, generic node names, whatever this supposed
to be. I guess spi...

> +        pmic@0 {
> +            compatible = "sprd,sc2731";
> +            reg = <0>;
> +            spi-max-frequency = <26000000>;
> +            interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
> +            interrupt-controller;
> +            #interrupt-cells = <2>;

Test your bindings...

> +...

Best regards,
Krzysztof

