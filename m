Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA0E770401
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 17:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232025AbjHDPG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 11:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231947AbjHDPGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 11:06:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C2249FD;
        Fri,  4 Aug 2023 08:06:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A80C76206C;
        Fri,  4 Aug 2023 15:06:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DB64C43397;
        Fri,  4 Aug 2023 15:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691161575;
        bh=mXPGxySXlPcOky6tfQhNOiPYHQydjvuSV/GV9+Qzuik=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ff/VCFJZ+CkRWah5LUhBHL37ShaFpg9fouBEv1q7/ZDWVynISmV6ux7imbw1KDKvf
         IOrtU1ge3Gx1+UFW/t2rZ7l68omwHaeHXs6YrJCBDf8CJLNxUIaGRGg63KUGQWJ6V1
         cQ7SvMq8j0GkW4rnw8QDjKudi3i7MwcSKS0X1KCi4UfMNaLxHvf3KP1I5y4EUv5cRN
         abciOGPZ3jfvVQsT0TvPuZMtpUnxkI6VXBSOKxQoz1OZc1fWje5UGBmYXIsisZjw1u
         NDe+6uOoKB/MsInufmcSsS/HbId6lFZiTTlgp1m5sl6L8hdxZkco8gcdIXWioRKg2Q
         kSaIJJP4GbLzQ==
Received: (nullmailer pid 1386743 invoked by uid 1000);
        Fri, 04 Aug 2023 15:06:13 -0000
Date:   Fri, 4 Aug 2023 09:06:13 -0600
From:   Rob Herring <robh@kernel.org>
To:     Raphael Gallais-Pou <rgallaispou@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: irqchip: convert st,stih407-irq-syscfg to
 DT schema
Message-ID: <20230804150613.GA1365416-robh@kernel.org>
References: <20230801214651.27418-1-rgallaispou@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801214651.27418-1-rgallaispou@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2023 at 11:46:51PM +0200, Raphael Gallais-Pou wrote:
> Convert deprecated format to DT schema format.
> 
> Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
> ---
>  .../st,sti-irq-syscfg.txt                     | 30 ---------
>  .../st,stih407-irq-syscfg.yaml                | 67 +++++++++++++++++++
>  2 files changed, 67 insertions(+), 30 deletions(-)
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
> index 000000000000..fce18d444c56
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/st,stih407-irq-syscfg.yaml
> @@ -0,0 +1,67 @@
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
> +  Configuration registers.  This driver is used to unmask them prior to use.
> +
> +properties:
> +  compatible:
> +    const: st,stih407-irq-syscfg
> +
> +  st,syscfg:
> +    description: Phandle to Cortex-A9 IRQ system config registers
> +    $ref: "/schemas/types.yaml#/definitions/phandle"

Drop quotes. Here and other $refs.

> +
> +  st,irq-device:
> +    description: Array of IRQs to enable.
> +    $ref: "/schemas/types.yaml#/definitions/uint32-array"
> +    items:
> +      - description: Enable the IRQ of the channel one.
> +      - description: Enable the IRQ of the channel two.
> +
> +  st,fiq-device:
> +    description: Array of FIQs to enable.
> +    $ref: "/schemas/types.yaml#/definitions/uint32-array"
> +    items:
> +      - description: Enable the IRQ of the channel one.
> +      - description: Enable the IRQ of the channel two.
> +
> +  st,invert-ext:
> +    description: External IRQs can be inverted at will. This property inverts
> +      these IRQs using bitwise logic.
> +    $ref: "/schemas/types.yaml#/definitions/uint32"
> +    enum:
> +      - ST_IRQ_SYSCFG_EXT_1_INV
> +      - ST_IRQ_SYSCFG_EXT_2_INV
> +      - ST_IRQ_SYSCFG_EXT_3_INV

Defines don't work here. Add the property to the example and you'll see.

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
