Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0CB5770997
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 22:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbjHDUUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 16:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjHDUUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 16:20:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E2F84C28;
        Fri,  4 Aug 2023 13:20:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D604661EF4;
        Fri,  4 Aug 2023 20:20:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9198C433C8;
        Fri,  4 Aug 2023 20:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691180436;
        bh=G8udJxOpNHfLfAgVbMDuQU5gAGWI4L+Vi3PvkaOfwkQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=s2hHJlmecTjyoVmvVcMuXBvJqO0HZ7pPNfiAd8TJDBL7TesU+Q87bG+nSo3zlfRWV
         m6BOgXGLDMhb0qs+7cII969YBJYF9LO/SWKnJ48hUi0C3XR+LLai+rOGB1XcXSIuoX
         MQAZd2xI4O0O7HOBtp+7QvWtxYgsGUhXAI6aOPg9ZRm2NAZ0UnDNr9r1UCDlbVEoJ5
         WlcaBrwthCcocail2sEHxZvPXVMybaIRsU0zeCPRGfOxLYvTbiSYZm4Dy7ACapkMbT
         9hAzxe3hOSFaTuKw8PMErKM8yOc60iMqlX4XOwog/kxye2CeEq7HE3TD2y3G7acN9p
         0B9tmBOokb/eA==
Date:   Fri, 4 Aug 2023 13:20:34 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Ivan Mikhaylov <fr0st61te@gmail.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Po-Yu Chuang <ratbert@faraday-tech.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v3] dt-bindings: net: ftgmac100: convert to yaml version
 from txt
Message-ID: <20230804132034.4561f9d7@kernel.org>
In-Reply-To: <20230731074426.4653-1-fr0st61te@gmail.com>
References: <20230731074426.4653-1-fr0st61te@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CC: Conor 

in case the missing CC is the reason for higher than usual 
review latency :)

On Mon, 31 Jul 2023 10:44:26 +0300 Ivan Mikhaylov wrote:
> Conversion from ftgmac100.txt to yaml format version.
> 
> Signed-off-by: Ivan Mikhaylov <fr0st61te@gmail.com>
> ---
>  .../bindings/net/faraday,ftgmac100.yaml       | 104 ++++++++++++++++++
>  .../devicetree/bindings/net/ftgmac100.txt     |  67 -----------
>  2 files changed, 104 insertions(+), 67 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
>  delete mode 100644 Documentation/devicetree/bindings/net/ftgmac100.txt
> 
> diff --git a/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml b/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
> new file mode 100644
> index 000000000000..965e6db38970
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
> @@ -0,0 +1,104 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Faraday Technology FTGMAC100 gigabit ethernet controller
> +
> +allOf:
> +  - $ref: ethernet-controller.yaml#
> +
> +maintainers:
> +  - Po-Yu Chuang <ratbert@faraday-tech.com>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: faraday,ftgmac100
> +      - items:
> +          - enum:
> +              - aspeed,ast2400-mac
> +              - aspeed,ast2500-mac
> +              - aspeed,ast2600-mac
> +          - const: faraday,ftgmac100
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    minItems: 1
> +    items:
> +      - description: MAC IP clock
> +      - description: RMII RCLK gate for AST2500/2600
> +
> +  clock-names:
> +    minItems: 1
> +    maxItems: 2
> +    contains:
> +      enum:
> +        - MACCLK
> +        - RCLK
> +
> +  phy-mode:
> +    enum:
> +      - rgmii
> +      - rmii
> +
> +  phy-handle: true
> +
> +  use-ncsi:
> +    description:
> +      Use the NC-SI stack instead of an MDIO PHY. Currently assumes
> +      rmii (100bT) but kept as a separate property in case NC-SI grows support
> +      for a gigabit link.
> +    type: boolean
> +
> +  no-hw-checksum:
> +    description:
> +      Used to disable HW checksum support. Here for backward
> +      compatibility as the driver now should have correct defaults based on
> +      the SoC.
> +    type: boolean
> +    deprecated: true
> +
> +  mdio:
> +    $ref: /schemas/net/mdio.yaml#
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    ethernet@1e660000 {
> +        compatible = "aspeed,ast2500-mac", "faraday,ftgmac100";
> +        reg = <0x1e660000 0x180>;
> +        interrupts = <2>;
> +        use-ncsi;
> +    };
> +
> +    ethernet@1e680000 {
> +        compatible = "aspeed,ast2500-mac", "faraday,ftgmac100";
> +        reg = <0x1e680000 0x180>;
> +        interrupts = <2>;
> +
> +        phy-handle = <&phy>;
> +        phy-mode = "rgmii";
> +
> +        mdio {
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            phy: ethernet-phy@1 {
> +                compatible = "ethernet-phy-ieee802.3-c22";
> +                reg = <1>;
> +            };
> +        };
> +    };
> diff --git a/Documentation/devicetree/bindings/net/ftgmac100.txt b/Documentation/devicetree/bindings/net/ftgmac100.txt
> deleted file mode 100644
> index 29234021f601..000000000000
> --- a/Documentation/devicetree/bindings/net/ftgmac100.txt
> +++ /dev/null
> @@ -1,67 +0,0 @@
> -* Faraday Technology FTGMAC100 gigabit ethernet controller
> -
> -Required properties:
> -- compatible: "faraday,ftgmac100"
> -
> -  Must also contain one of these if used as part of an Aspeed AST2400
> -  or 2500 family SoC as they have some subtle tweaks to the
> -  implementation:
> -
> -     - "aspeed,ast2400-mac"
> -     - "aspeed,ast2500-mac"
> -     - "aspeed,ast2600-mac"
> -
> -- reg: Address and length of the register set for the device
> -- interrupts: Should contain ethernet controller interrupt
> -
> -Optional properties:
> -- phy-handle: See ethernet.txt file in the same directory.
> -- phy-mode: See ethernet.txt file in the same directory. If the property is
> -  absent, "rgmii" is assumed. Supported values are "rgmii*" and "rmii" for
> -  aspeed parts. Other (unknown) parts will accept any value.
> -- use-ncsi: Use the NC-SI stack instead of an MDIO PHY. Currently assumes
> -  rmii (100bT) but kept as a separate property in case NC-SI grows support
> -  for a gigabit link.
> -- no-hw-checksum: Used to disable HW checksum support. Here for backward
> -  compatibility as the driver now should have correct defaults based on
> -  the SoC.
> -- clocks: In accordance with the generic clock bindings. Must describe the MAC
> -  IP clock, and optionally an RMII RCLK gate for the AST2500/AST2600. The
> -  required MAC clock must be the first cell.
> -- clock-names:
> -
> -      - "MACCLK": The MAC IP clock
> -      - "RCLK": Clock gate for the RMII RCLK
> -
> -Optional subnodes:
> -- mdio: See mdio.txt file in the same directory.
> -
> -Example:
> -
> -	mac0: ethernet@1e660000 {
> -		compatible = "aspeed,ast2500-mac", "faraday,ftgmac100";
> -		reg = <0x1e660000 0x180>;
> -		interrupts = <2>;
> -		use-ncsi;
> -	};
> -
> -Example with phy-handle:
> -
> -	mac1: ethernet@1e680000 {
> -		compatible = "aspeed,ast2500-mac", "faraday,ftgmac100";
> -		reg = <0x1e680000 0x180>;
> -		interrupts = <2>;
> -
> -		phy-handle = <&phy>;
> -		phy-mode = "rgmii";
> -
> -		mdio {
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -
> -			phy: ethernet-phy@1 {
> -				compatible = "ethernet-phy-ieee802.3-c22";
> -				reg = <1>;
> -			};
> -		};
> -	};

