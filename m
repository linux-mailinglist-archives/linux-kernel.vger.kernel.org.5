Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4007664BE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 09:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233771AbjG1HE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 03:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233748AbjG1HEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 03:04:23 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA6772681
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 00:04:16 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-51ff0e3d8c1so2267134a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 00:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690527855; x=1691132655;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3sC0D4X3+6tgLPKYm2qip+QkMvs29ewl4q1rgH6EOrw=;
        b=uHmDTxMRMoxIzIjKOOYeYiKLYOJooFeDvbfoSlzHZdXGbxnLHH5PJKZr0gj4sK6ez6
         AV3n2ymNvY8spG+sic2cNAEOQ+iC8LJzTgvqrhmcIX7MHWLcV+i2iaGEV56j46m4FZ7/
         c4yJ2Q31KELd+6yXLvVxqw71/z/3ewO0pbq4p73kkxth82sFBEpqp8ws/QcE/Z0pTzWq
         SWuE1wut7ZAxy6KPx9xqQnFnIYhybgVJz5UJn07Mu8AOV8nIqZABt63owT4tGQEv8MTq
         UMtsIuBh9cZycAGvPu23vQ10DytpTiIdCH9HsHUNJ3Duk4W6oie+z95VQMmAmYnnBNmE
         2jUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690527855; x=1691132655;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3sC0D4X3+6tgLPKYm2qip+QkMvs29ewl4q1rgH6EOrw=;
        b=QuVeaVrPhCocndQoJSWk7XmQmIJuuIYJNltZiJb4w0+xTuveAs7PhCxLM4J9t3Kln4
         3u9WlsU/OKA5zBhIYcUxJnXj2cqcP1EPyNOGX3ePhtgsXgDuREvXSsyyQ3qlESzv4wXk
         rblhxQxfqvs8czPyfvrA+coVKEwRgmDeuS0RIsahXmtK1/smFZKossHChc/yvcmnYWCB
         tuqQT+C3n1kRo/d7KN5GOf1P3kvpnYBaBHUgD92bcG5DS3qZU0gkHNn010pWgUI/rS4+
         /nbiif7cwhlVpulmllYPC9L68V8oePJZZMF3WhyKlFcZ90nswuaRZ5TAO89yZc/Gp66I
         P9uA==
X-Gm-Message-State: ABy/qLb8kCdymeUONVzXo0ftJxA0tKxcw1wYD3pBhPVDz9w8H+YIYYze
        2g1gxk3MI4b+qOsFj6S44HRrZA==
X-Google-Smtp-Source: APBJJlEtXC4Gm9hLaI//LMFaCogOFIPzyoIf53PT93ahA3haTyMsAwALERW3DZX4Qhc8aH5BteiCSg==
X-Received: by 2002:a05:6402:1602:b0:522:2711:871 with SMTP id f2-20020a056402160200b0052227110871mr948667edv.1.1690527855057;
        Fri, 28 Jul 2023 00:04:15 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id ca12-20020aa7cd6c000000b005222005e361sm1502223edb.45.2023.07.28.00.04.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 00:04:14 -0700 (PDT)
Message-ID: <4bbdd646-ad16-1a7d-a727-878c6cf92410@linaro.org>
Date:   Fri, 28 Jul 2023 09:04:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 2/2] doc: dt: bindings: usb: realtek,dwc3: Add Realtek
 DHC RTD SoC DWC3 USB
Content-Language: en-US
To:     Stanley Chang <stanley_chang@realtek.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230728035318.18741-1-stanley_chang@realtek.com>
 <20230728035318.18741-2-stanley_chang@realtek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230728035318.18741-2-stanley_chang@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/07/2023 05:53, Stanley Chang wrote:
> Document the DWC3 USB bindings for Realtek SoCs.

Please use subject prefixes matching the subsystem. You can get them for
example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
your patch is touching.

My filtering of emails depends on it.

> 
> Signed-off-by: Stanley Chang <stanley_chang@realtek.com>
> ---
>  .../devicetree/bindings/usb/realtek,dwc3.yaml | 107 ++++++++++++++++++
>  1 file changed, 107 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/realtek,dwc3.yaml
> 
> diff --git a/Documentation/devicetree/bindings/usb/realtek,dwc3.yaml b/Documentation/devicetree/bindings/usb/realtek,dwc3.yaml

realtek,rtd-dwc3.yaml

> new file mode 100644
> index 000000000000..74d388809924
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/realtek,dwc3.yaml
> @@ -0,0 +1,107 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright 2023 Realtek Semiconductor Corporation
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/usb/realtek,dwc3.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"

Drop quotes. Wasn't tested, because dtschema reports warnings here...

> +
> +title: Realtek DWC3 USB SoC Controller Glue
> +
> +maintainers:
> +  - Stanley Chang <stanley_chang@realtek.com>
> +
> +description:
> +  The Realtek DHC SoC embeds a DWC3 USB IP Core configured for USB 2.0
> +  and USB 3.0 in host or dual-role mode.
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - realtek,rtd1295-dwc3
> +          - realtek,rtd1315e-dwc3
> +          - realtek,rtd1319-dwc3
> +          - realtek,rtd1319d-dwc3
> +          - realtek,rtd1395-dwc3
> +          - realtek,rtd1619-dwc3
> +          - realtek,rtd1619b-dwc3
> +      - const: realtek,rtd-dwc3
> +
> +  reg:
> +    maxItems: 1
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 1
> +
> +  ranges: true
> +
> +  realtek,unlink-usb3-port:
> +    description: Disable link between USB 3.0 PHY and USB mac.
> +      Only for RTD1619 SoC, if the board design support maximum 2.0 speed.
> +    type: boolean
> +
> +  realtek,disable-usb3-phy:
> +    description: Close USB 3.0 PHY if the board design not support USB 3.0.
> +    type: boolean
> +
> +  realtek,enable-l4icg:
> +    description: Enable the power saving feature l4icg by hardware clock.
> +      gating.

You described the desired Linux feature or behavior, not the actual
hardware. The bindings are about the latter, so instead you need to
rephrase the property and its description to match actual hardware
capabilities/features/configuration etc.

> +    type: boolean
> +
> +patternProperties:
> +  "^usb@[0-9a-f]+$":
> +    $ref: snps,dwc3.yaml#
> +    description: Required child node
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#address-cells"
> +  - "#size-cells"
> +  - ranges
> +
> +allOf:
> +  - if:
> +      not:
> +        properties:
> +          compatible:
> +            contains:
> +              enum:
> +                - realtek,rtd1619-dwc3
> +    then:
> +      properties:
> +        realtek,unlink-usb3-port: false
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    usb@98013e00 {
> +        compatible = "realtek,rtd1319d-dwc3", "realtek,rtd-dwc3";
> +        reg = <0x98013e00 0x200>;
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +        ranges;
> +        status = "okay";

Drop status.

> +        realtek,disable-usb3-phy;
> +        realtek,enable-l4icg;
> +
> +        usb@98050000 {
> +            compatible = "snps,dwc3";
> +            reg = <0x98050000 0x9000>;
> +            interrupts = <0 94 4>;
> +            phys = <&usb2phy &usb3phy>;
> +            phy-names = "usb2-phy", "usb3-phy";
> +            dr_mode = "otg";
> +            usb-role-switch;
> +            role-switch-default-mode = "host";
> +            snps,dis_u2_susphy_quirk;
> +            snps,parkmode-disable-ss-quirk;
> +            snps,parkmode-disable-hs-quirk;
> +            maximum-speed = "high-speed";
> +        };
> +    };

Best regards,
Krzysztof

