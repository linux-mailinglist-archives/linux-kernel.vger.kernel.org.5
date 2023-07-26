Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FACF763D55
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 19:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbjGZRLC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 13:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbjGZRLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 13:11:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C5AC1BD6;
        Wed, 26 Jul 2023 10:10:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F86761BF5;
        Wed, 26 Jul 2023 17:10:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FB60C433CA;
        Wed, 26 Jul 2023 17:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690391458;
        bh=nqd3LMNaH7Pa5TyNSfP1cxXXeNyUyq8BvWWp1a6eL5s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c3KVXa/BftZsgtsVOG6sVtMnW4yVaCAKx3x6ZNvAbDwv7VyRyoBd0vPkYnJPeIraJ
         iYuRgx/dDWeqrOgml4dWVxgyMTBefa7Q8sIYxZ7XereBIdNxNHIa3S37AsSKX/9ZsX
         xDkPunCSBxn1FEdHcGOQ5iMNHgHu8JHlLeNavgewVx5HbG9JpMhlgELd5tGarGhUXa
         C+A59Xzx1Z8Gyet45HrU8xPZncpHOqCWDcjoCTrdMmop4A2KV1x9Mf2aQfaspLsdIO
         lwXZTWJkU2I8Xd1sJ8D0/ZEcv4VEv6WHmtaZFLtWaLJrRXslQP/1Sp9m2xGM3r7DAH
         6cWPRrVCwaxag==
Received: (nullmailer pid 1608179 invoked by uid 1000);
        Wed, 26 Jul 2023 17:10:56 -0000
Date:   Wed, 26 Jul 2023 11:10:56 -0600
From:   Rob Herring <robh@kernel.org>
To:     Nishanth Menon <nm@ti.com>
Cc:     Tony Lindgren <tony@atomide.com>,
        =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Vibhore Vardhan <vibhore@ti.com>, Dhruva Gole <d-gole@ti.com>,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 4/5] dt-bindings: opp: Convert ti-omap5-opp-supply.txt to
 yaml binding
Message-ID: <20230726171056.GA1593547-robh@kernel.org>
References: <20230724153911.1376830-1-nm@ti.com>
 <20230724153911.1376830-5-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724153911.1376830-5-nm@ti.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 10:39:10AM -0500, Nishanth Menon wrote:
> Rename ti-omap5-opp-supply to be bit more generic omap-opp-supply and
> convert the binding to yaml.
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>  .../bindings/opp/ti,omap-opp-supply.yaml      | 108 ++++++++++++++++++
>  .../bindings/opp/ti-omap5-opp-supply.txt      |  63 ----------
>  2 files changed, 108 insertions(+), 63 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/opp/ti,omap-opp-supply.yaml
>  delete mode 100644 Documentation/devicetree/bindings/opp/ti-omap5-opp-supply.txt
> 
> diff --git a/Documentation/devicetree/bindings/opp/ti,omap-opp-supply.yaml b/Documentation/devicetree/bindings/opp/ti,omap-opp-supply.yaml
> new file mode 100644
> index 000000000000..ff1b3d8fea31
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/opp/ti,omap-opp-supply.yaml
> @@ -0,0 +1,108 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/opp/ti,omap-opp-supply.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments OMAP compatible OPP supply description

Drop "description"

> +
> +description: |
> +  OMAP5, DRA7, and AM57 family of SoCs have Class0 AVS eFuse registers which
> +  contain data that can be used to adjust voltages programmed for some of their
> +  supplies for more efficient operation. This binding provides the information
> +  needed to read these values and use them to program the main regulator during
> +  an OPP transitions.
> +
> +  Also, some supplies may have an associated vbb-supply which is an Adaptive Body
> +  Bias regulator which much be transitioned in a specific sequence with regards
> +  to the vdd-supply and clk when making an OPP transition. By supplying two
> +  regulators to the device that will undergo OPP transitions we can make use
> +  of the multi regulator binding that is part of the OPP core described
> +  to describe both regulators needed by the platform.
> +
> +maintainers:
> +  - Nishanth Menon <nm@ti.com>
> +
> +properties:
> +  $nodename:
> +    pattern: '^opp-supply(@[0-9a-f]+)?$'
> +
> +  compatible:
> +    oneOf:
> +      - description: Basic OPP supply controlling VDD and VBB
> +        items:
> +          - const: ti,omap-opp-supply
> +      - description: OMAP5+ optimized voltages in efuse(Class 0) VDD along with
> +          VBB.
> +        items:
> +          - const: ti,omap5-opp-supply
> +      - description: OMAP5+ optimized voltages in efuse(class0) VDD but no VBB
> +        items:
> +          - const: ti,omap5-core-opp-supply
> +
> +  reg:
> +    description: Address and length of the efuse register set for the device

Drop

> +    maxItems: 1
> +
> +  ti,absolute-max-voltage-uv:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Absolute maximum voltage for the OPP supply
> +
> +  ti,efuse-settings:
> +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
> +    description: An array of u32 tuple items providing information about
> +      optimized efuse configuration. Each item consists of the following
> +      voltage_in_uV - reference voltage (OPP Voltage)
> +      efuse_offset - efuse offset fromr eg where the optimized voltage is
> +        stored.
> +    items:
> +      minItems: 2
> +      maxItems: 2

Constraints on the values?

> +    minItems: 1
> +
> +required:
> +  - compatible
> +  - ti,absolute-max-voltage-uv
> +
> +allOf:
> +  - if:
> +      not:
> +        properties:
> +          compatible:
> +            contains:
> +              const: ti,omap-opp-supply
> +    then:
> +      required:
> +        - reg
> +        - ti,efuse-settings
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    opp_supply_mpu_iva_hd: opp-supply {

Drop unused labels.

> +        compatible = "ti,omap-opp-supply";
> +        ti,absolute-max-voltage-uv = <1375000>;
> +    };
> +  - |
> +    opp_supply_mpu: opp-supply@4a003b20 {
> +        compatible = "ti,omap5-opp-supply";
> +        reg = <0x4a003b20 0x8>;
> +        ti,efuse-settings =
> +            /* uV   offset */
> +            <1060000 0x0>,
> +            <1160000 0x4>,
> +            <1210000 0x8>;
> +        ti,absolute-max-voltage-uv = <1500000>;
> +    };
> +  - |
> +    opp_supply_mpu2: opp-supply@4a003b00 {
> +        compatible = "ti,omap5-core-opp-supply";
> +        reg = <0x4a003b00 0x8>;
> +        ti,efuse-settings =
> +            /* uV   offset */
> +            <1060000 0x0>,
> +            <1160000 0x4>,
> +            <1210000 0x8>;
> +        ti,absolute-max-voltage-uv = <1500000>;
> +    };

The 3rd example doesn't add anything. It's just different values.

Rob
