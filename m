Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50EA1792B30
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243540AbjIEQt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353969AbjIEI6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 04:58:08 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA156184;
        Tue,  5 Sep 2023 01:58:03 -0700 (PDT)
Received: from pendragon.ideasonboard.com (ftip006315900.acc1.colindale.21cn-nte.bt.net [81.134.214.249])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 7A2F610FE;
        Tue,  5 Sep 2023 10:56:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1693904195;
        bh=CEfJ5B7GYScrvKciZArVaQtY9njQRmml6KbxPfNxMr0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VSJ+CQNm7i1hzp8OTXh07Rkr+BR0y2/7qVCkkFaRlnESR5I52J6nZLH84eQYJn7FM
         sEsUu/N51ql8T+K0NxD1pLHSBBNH11eGqaM0fUxhBtyi7EWmGl4wCTVARTRKWrO8NV
         1DGHHqQ0GCtikXSjsmwM/oTTAxH4vgTreZ8K50go=
Date:   Tue, 5 Sep 2023 11:58:14 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Alain Volmat <alain.volmat@foss.st.com>
Cc:     Hugues Fruchet <hugues.fruchet@foss.st.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Russell King <linux@armlinux.org.uk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Dan Scally <dan.scally@ideasonboard.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/5] dt-bindings: media: add bindings for stm32 dcmipp
Message-ID: <20230905085814.GA31594@pendragon.ideasonboard.com>
References: <20230901155732.252436-1-alain.volmat@foss.st.com>
 <20230901155732.252436-2-alain.volmat@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230901155732.252436-2-alain.volmat@foss.st.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alain,

Thank you for the patch.

On Fri, Sep 01, 2023 at 05:57:20PM +0200, Alain Volmat wrote:
> Add the yaml binding for the ST Microelectronics STM32 DCMIPP
> (Digital Camera Memory Interface Pixel Processor)
> 
> Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  .../bindings/media/st,stm32-dcmipp.yaml       | 89 +++++++++++++++++++
>  1 file changed, 89 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/st,stm32-dcmipp.yaml
> 
> diff --git a/Documentation/devicetree/bindings/media/st,stm32-dcmipp.yaml b/Documentation/devicetree/bindings/media/st,stm32-dcmipp.yaml
> new file mode 100644
> index 000000000000..87731f3ce7bd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/st,stm32-dcmipp.yaml
> @@ -0,0 +1,89 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/st,stm32-dcmipp.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: STMicroelectronics STM32 DCMIPP Digital Camera Memory Interface Pixel Processor
> +
> +maintainers:
> +  - Hugues Fruchet <hugues.fruchet@foss.st.com>
> +  - Alain Volmat <alain.volmat@foss.st.com>
> +
> +properties:
> +  compatible:
> +    const: st,stm32mp13-dcmipp
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1
> +
> +  port:
> +    $ref: /schemas/graph.yaml#/$defs/port-base
> +    unevaluatedProperties: false
> +    description:
> +      DCMIPP supports a single port node with parallel bus.
> +
> +    properties:
> +      endpoint:
> +        $ref: video-interfaces.yaml#
> +        unevaluatedProperties: false
> +
> +        properties:
> +          bus-type:
> +            enum: [5, 6]
> +            default: 5
> +
> +          bus-width:
> +            enum: [8, 10, 12, 14]
> +            default: 8
> +
> +          pclk-sample: true
> +          hsync-active: true
> +          vsync-active: true
> +
> +        required:
> +          - pclk-sample
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - resets
> +  - port
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/stm32mp13-clks.h>
> +    #include <dt-bindings/reset/stm32mp13-resets.h>
> +    dcmipp@5a000000 {
> +        compatible = "st,stm32mp13-dcmipp";
> +        reg = <0x5a000000 0x400>;
> +        interrupts = <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
> +        resets = <&rcc DCMIPP_R>;
> +        clocks = <&rcc DCMIPP_K>;
> +
> +        port {
> +             endpoint {
> +                   remote-endpoint = <&mipid02_2>;
> +                   bus-width = <8>;
> +                   hsync-active = <0>;
> +                   vsync-active = <0>;
> +                   pclk-sample = <0>;
> +             };
> +        };
> +    };
> +
> +...

-- 
Regards,

Laurent Pinchart
