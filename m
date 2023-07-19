Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30B88759D2C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 20:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbjGSSWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 14:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjGSSWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 14:22:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A421FC8;
        Wed, 19 Jul 2023 11:22:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 186B8617D8;
        Wed, 19 Jul 2023 18:22:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C188C433C8;
        Wed, 19 Jul 2023 18:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689790928;
        bh=sp4JMZHJA+829ThoZ/Zig1BxBGReZArQFiCA4dwxmn8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sOkum4AT2oJeNwiVsoHgYWs97q9c1gstUyTsMQbNSUD1nKEA47RIlSuVzlifBJlK9
         etNjegAQTkLulUmAgOTxK9o9eXy/9Hh2hRHbjFJkV/CcOqdQrraZTklrOiWCXJIM/d
         hOl2szJw1Qwbm/tLhv0wG+twH5qkPRjqRvYVKfGgOSNSxrGnIH3seiPijDR2OVNgcX
         ciuk0/I4mx/k88QdEHDleXXPMXoogs7ksfcIDJTa4c0kuhwSnGymK1CEfU8RdaEum6
         bTyaETuqn3V/c/8yOcowlkxCVsK1VFTw5zf7P3adPvPWYfk+MF6xq7TTl6TnqWXcBW
         EbIRhtgJq76Bw==
Received: (nullmailer pid 540738 invoked by uid 1000);
        Wed, 19 Jul 2023 18:22:06 -0000
Date:   Wed, 19 Jul 2023 12:22:06 -0600
From:   Rob Herring <robh@kernel.org>
To:     Pranavi Somisetty <pranavi.somisetty@amd.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        michal.simek@amd.com, harini.katakam@amd.com, git@amd.com,
        radhey.shyam.pandey@amd.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] dt-bindings: net: xilinx_gmii2rgmii: Convert to json
 schema
Message-ID: <20230719182206.GA537052-robh@kernel.org>
References: <20230719061808.30967-1-pranavi.somisetty@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230719061808.30967-1-pranavi.somisetty@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 12:18:08AM -0600, Pranavi Somisetty wrote:
> Convert the Xilinx GMII to RGMII Converter device tree binding
> documentation to json schema.
> This converter is usually used as gem <---> gmii2rgmii <---> external phy
> and, it's phy-handle should point to the phandle of the external phy.
> 
> Signed-off-by: Pranavi Somisetty <pranavi.somisetty@amd.com>
> ---
> Changes v2:
> 1. Changed description for the property "reg".
> 2. Added a reference to the description of "phy-handle" property.
> ---
>  .../bindings/net/xilinx_gmii2rgmii.txt        | 35 ------------
>  .../bindings/net/xlnx,gmii-to-rgmii.yaml      | 54 +++++++++++++++++++
>  2 files changed, 54 insertions(+), 35 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/net/xilinx_gmii2rgmii.txt
>  create mode 100644 Documentation/devicetree/bindings/net/xlnx,gmii-to-rgmii.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/xilinx_gmii2rgmii.txt b/Documentation/devicetree/bindings/net/xilinx_gmii2rgmii.txt
> deleted file mode 100644
> index 038dda48b8e6..000000000000
> --- a/Documentation/devicetree/bindings/net/xilinx_gmii2rgmii.txt
> +++ /dev/null
> @@ -1,35 +0,0 @@
> -XILINX GMIITORGMII Converter Driver Device Tree Bindings
> ---------------------------------------------------------
> -
> -The Gigabit Media Independent Interface (GMII) to Reduced Gigabit Media
> -Independent Interface (RGMII) core provides the RGMII between RGMII-compliant
> -Ethernet physical media devices (PHY) and the Gigabit Ethernet controller.
> -This core can be used in all three modes of operation(10/100/1000 Mb/s).
> -The Management Data Input/Output (MDIO) interface is used to configure the
> -Speed of operation. This core can switch dynamically between the three
> -Different speed modes by configuring the conveter register through mdio write.
> -
> -This converter sits between the ethernet MAC and the external phy.
> -MAC <==> GMII2RGMII <==> RGMII_PHY
> -
> -For more details about mdio please refer phy.txt file in the same directory.
> -
> -Required properties:
> -- compatible	: Should be "xlnx,gmii-to-rgmii-1.0"
> -- reg		: The ID number for the phy, usually a small integer
> -- phy-handle	: Should point to the external phy device.
> -		  See ethernet.txt file in the same directory.
> -
> -Example:
> -	mdio {
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -		phy: ethernet-phy@0 {
> -			......
> -		};
> -		gmiitorgmii: gmiitorgmii@8 {
> -			compatible = "xlnx,gmii-to-rgmii-1.0";
> -			reg = <8>;
> -			phy-handle = <&phy>;
> -		};
> -	};
> diff --git a/Documentation/devicetree/bindings/net/xlnx,gmii-to-rgmii.yaml b/Documentation/devicetree/bindings/net/xlnx,gmii-to-rgmii.yaml
> new file mode 100644
> index 000000000000..9d22382a64ba
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/xlnx,gmii-to-rgmii.yaml
> @@ -0,0 +1,54 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/xlnx,gmii-to-rgmii.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Xilinx GMII to RGMII Converter
> +
> +maintainers:
> +  - Harini Katakam <harini.katakam@amd.com>
> +
> +description:
> +  The Gigabit Media Independent Interface (GMII) to Reduced Gigabit Media
> +  Independent Interface (RGMII) core provides the RGMII between RGMII-compliant
> +  ethernet physical media devices (PHY) and the Gigabit Ethernet controller.
> +  This core can be used in all three modes of operation(10/100/1000 Mb/s).
> +  The Management Data Input/Output (MDIO) interface is used to configure the
> +  speed of operation. This core can switch dynamically between the three
> +  different speed modes by configuring the converter register through mdio write.
> +  The core cannot function without an external phy connected to it.
> +
> +properties:
> +  compatible:
> +    const: xlnx,gmii-to-rgmii-1.0
> +
> +  reg:
> +    minimum: 0
> +    maximum: 31
> +    description: The ID number for the phy.
> +
> +  phy-handle:
> +    $ref: ethernet-controller.yaml#/properties/phy-handle

Don't reference individual properties like this. Instead add a $ref at 
the top level to just "ethernet-controller.yaml#". Since this is the 
only property you want from there, put a 'phy-handle: true' here and use 
additionalProperties instead of unevaluatedProperties below.

> +
> +required:
> +  - compatible
> +  - reg
> +  - phy-handle
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    mdio {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        phy: ethernet-phy@0 {
> +            reg = <0>;
> +        };
> +        gmiitorgmii@8 {
> +            compatible = "xlnx,gmii-to-rgmii-1.0";
> +            reg = <8>;
> +            phy-handle = <&phy>;
> +        };
> +    };
> -- 
> 2.36.1
> 
