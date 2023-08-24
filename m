Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B62E57870D6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 15:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241278AbjHXNsk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 09:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238758AbjHXNse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 09:48:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8A9B128;
        Thu, 24 Aug 2023 06:48:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A95066D46;
        Thu, 24 Aug 2023 13:48:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDE0EC433C8;
        Thu, 24 Aug 2023 13:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692884910;
        bh=8fxc/BIlwezL6vOn3Kkvna2hc1WrAKRczerXKpLFxrE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lbn2BI9NV/piImyIta+KBYlI3hz081EbhqLWgpyRuYbVVVkBzvfwuEz/G0es9IHXw
         p9s5bk8XXIcj+c5xEB86PGMB308a4q1+qXkeQQO46aRg54PcThEL+BouQtubqBKbEB
         UHJSd8brVIABHtaZPoV4ynoGjsy81vuFOjxUJoExmuguHqP2NWi/S5SXvxWNJlWRQF
         dpYUGkv2bL6kuPRX9mVRFc+yiRAYP7rhnfpV5MuiiZjPKuFqiH568RLpfAhjz1j134
         4NEWF11y1BeuldM5s2qRw1XsVwBajxKK2rZWOxWHdiJXEC/eVkiruRTD4akg61xr6Z
         UzACwC72A7yng==
Received: (nullmailer pid 686612 invoked by uid 1000);
        Thu, 24 Aug 2023 13:48:28 -0000
Date:   Thu, 24 Aug 2023 08:48:28 -0500
From:   Rob Herring <robh@kernel.org>
To:     Raphael Gallais-Pou <rgallaispou@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v3] dt-bindings: irqchip: convert st,stih407-irq-syscfg
 to DT schema
Message-ID: <20230824134828.GA683810-robh@kernel.org>
References: <20230823224453.126963-1-rgallaispou@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230823224453.126963-1-rgallaispou@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 12:44:53AM +0200, Raphael Gallais-Pou wrote:
> Convert deprecated format to DT schema format.
> 
> Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> Changes in v2:
> 	- Added Conor's r-by
> 	- Removed quotes surrounding $refs
> 	- Hardcoded 'st,invert-ext' possible values
> 
> Changes in v3:
> 	- Fixed enum syntax warnings
> 	- Removed reference to driver in favor of device
> ---
>  .../st,sti-irq-syscfg.txt                     | 30 ---------
>  .../st,stih407-irq-syscfg.yaml                | 64 +++++++++++++++++++
>  2 files changed, 64 insertions(+), 30 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/st,sti-irq-syscfg.txt
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/st,stih407-irq-syscfg.yaml
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/st,sti-irq-syscfg.txt b/Documentation/devicetree/bindings/interrupt-controller/st,sti-irq-syscfg.txt
> deleted file mode 100644
> index 977d7ed3670e..000000000000
> --- a/Documentation/devicetree/bindings/interrupt-controller/st,sti-irq-syscfg.txt
> +++ /dev/null
> @@ -1,30 +0,0 @@
> -STMicroelectronics STi System Configuration Controlled IRQs
> ------------------------------------------------------------
> -
> -On STi based systems; External, CTI (Core Sight), PMU (Performance Management),
> -and PL310 L2 Cache IRQs are controlled using System Configuration registers.
> -This driver is used to unmask them prior to use.
> -
> -Required properties:
> -- compatible	: Should be "st,stih407-irq-syscfg"
> -- st,syscfg	: Phandle to Cortex-A9 IRQ system config registers
> -- st,irq-device	: Array of IRQs to enable - should be 2 in length
> -- st,fiq-device	: Array of FIQs to enable - should be 2 in length
> -
> -Optional properties:
> -- st,invert-ext	: External IRQs can be inverted at will.  This property inverts
> -		  these IRQs using bitwise logic.  A number of defines have been
> -		  provided for convenience:
> -			ST_IRQ_SYSCFG_EXT_1_INV
> -			ST_IRQ_SYSCFG_EXT_2_INV
> -			ST_IRQ_SYSCFG_EXT_3_INV
> -Example:
> -
> -irq-syscfg {
> -	compatible    = "st,stih407-irq-syscfg";
> -	st,syscfg     = <&syscfg_cpu>;
> -	st,irq-device = <ST_IRQ_SYSCFG_PMU_0>,
> -			<ST_IRQ_SYSCFG_PMU_1>;
> -	st,fiq-device = <ST_IRQ_SYSCFG_DISABLED>,
> -			<ST_IRQ_SYSCFG_DISABLED>;
> -};
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/st,stih407-irq-syscfg.yaml b/Documentation/devicetree/bindings/interrupt-controller/st,stih407-irq-syscfg.yaml
> new file mode 100644
> index 000000000000..985fa281f027
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/st,stih407-irq-syscfg.yaml
> @@ -0,0 +1,64 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/interrupt-controller/st,stih407-irq-syscfg.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: STMicroelectronics STi System Configuration Controlled IRQs
> +
> +maintainers:
> +  - Patrice Chotard <patrice.chotard@foss.st.com>
> +
> +description:
> +  On STi based systems; External, CTI (Core Sight), PMU (Performance
> +  Management), and PL310 L2 Cache IRQs are controlled using System
> +  Configuration registers.  This device is used to unmask them prior to use.
> +
> +properties:
> +  compatible:
> +    const: st,stih407-irq-syscfg
> +
> +  st,syscfg:
> +    description: Phandle to Cortex-A9 IRQ system config registers
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +
> +  st,irq-device:
> +    description: Array of IRQs to enable.
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    items:
> +      - description: Enable the IRQ of the channel one.
> +      - description: Enable the IRQ of the channel two.
> +
> +  st,fiq-device:
> +    description: Array of FIQs to enable.
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    items:
> +      - description: Enable the IRQ of the channel one.
> +      - description: Enable the IRQ of the channel two.
> +
> +  st,invert-ext:
> +    description: External IRQs can be inverted at will. This property inverts
> +      these IRQs using bitwise logic.

So this is a mask?

> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [ 1, 2, 4]

If so, then this is wrong if you want to set more than 1 bit.

> +
> +required:
> +  - compatible
> +  - st,syscfg
> +  - st,irq-device
> +  - st,fiq-device
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq-st.h>
> +    irq-syscfg {
> +        compatible    = "st,stih407-irq-syscfg";
> +        st,syscfg     = <&syscfg_cpu>;
> +        st,irq-device = <ST_IRQ_SYSCFG_PMU_0>,
> +                        <ST_IRQ_SYSCFG_PMU_1>;
> +        st,fiq-device = <ST_IRQ_SYSCFG_DISABLED>,
> +                        <ST_IRQ_SYSCFG_DISABLED>;
> +    };
> +...
> -- 
> 2.41.0
> 
