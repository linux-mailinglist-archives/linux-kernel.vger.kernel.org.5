Return-Path: <linux-kernel+bounces-62301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E2E851E40
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 21:00:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 790B52827CB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 20:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A5E482FF;
	Mon, 12 Feb 2024 20:00:25 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CC9481C2
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 20:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707768025; cv=none; b=L2j7gKNTUl0tZ/g3haa8jVA9TZBFW5qeRz3oL8IU370UYLcbkYlogK46XXARwU9EMVkvNCxb5sUrubvwxexJ78eAOD1ogHsrk/U1yR+lr3PfEOaHDAao2J+ccLIaUb/RnHidq4XZF2ArQzIcaQ8Lhb9rIvPJxFZLTx6V5bcAejU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707768025; c=relaxed/simple;
	bh=9r0Id5Y9RoU/xKvxd9uPoImX5rBlLcjKbbbOl+v6fnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mwfXeoMIfHjroxHyQ1SrQQk+kJ9qvDslH4QIXQkOLCODNC+GeHCL+jcZEXrNoEpMMZXK45w0kPdZ0iGiKUE8LyPFaeptk1X3yQTEbwiIKKoNf41gmhGD4Y+JZ8iBek3Pa4FaqRebkKb/7+7H81OYTDBTwT6u0nP21EV9wzqgiLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rZcTE-00053s-4C; Mon, 12 Feb 2024 21:00:04 +0100
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1rZcTC-000LdK-94; Mon, 12 Feb 2024 21:00:02 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1rZcTC-005fbl-0Z;
	Mon, 12 Feb 2024 21:00:02 +0100
Date: Mon, 12 Feb 2024 21:00:02 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: net: qca,ar9331: convert to DT schema
Message-ID: <Zcp4wvmGX-CJvC5J@pengutronix.de>
References: <20240212182911.233819-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240212182911.233819-1-krzysztof.kozlowski@linaro.org>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Mon, Feb 12, 2024 at 07:29:11PM +0100, Krzysztof Kozlowski wrote:
> Convert the Qualcomm Atheros AR9331 built-in switch bindings to DT
> schema.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>

Thank you!

> ---
> 
> DSA switch bindings still bring me headache...
> 
> Changes in v2:
> 1. Narrow pattern for phy children to ethernet-phy@ or phy@ (MIPS DTS
>    has the latter) - Conor.
> ---
>  .../devicetree/bindings/net/dsa/ar9331.txt    | 147 ----------------
>  .../bindings/net/dsa/qca,ar9331.yaml          | 161 ++++++++++++++++++
>  2 files changed, 161 insertions(+), 147 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/net/dsa/ar9331.txt
>  create mode 100644 Documentation/devicetree/bindings/net/dsa/qca,ar9331.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/dsa/ar9331.txt b/Documentation/devicetree/bindings/net/dsa/ar9331.txt
> deleted file mode 100644
> index f824fdae0da2..000000000000
> --- a/Documentation/devicetree/bindings/net/dsa/ar9331.txt
> +++ /dev/null
> @@ -1,147 +0,0 @@
> -Atheros AR9331 built-in switch
> -=============================
> -
> -It is a switch built-in to Atheros AR9331 WiSoC and addressable over internal
> -MDIO bus. All PHYs are built-in as well.
> -
> -Required properties:
> -
> - - compatible: should be: "qca,ar9331-switch"
> - - reg: Address on the MII bus for the switch.
> - - resets : Must contain an entry for each entry in reset-names.
> - - reset-names : Must include the following entries: "switch"
> - - interrupt-parent: Phandle to the parent interrupt controller
> - - interrupts: IRQ line for the switch
> - - interrupt-controller: Indicates the switch is itself an interrupt
> -   controller. This is used for the PHY interrupts.
> - - #interrupt-cells: must be 1
> - - mdio: Container of PHY and devices on the switches MDIO bus.
> -
> -See Documentation/devicetree/bindings/net/dsa/dsa.txt for a list of additional
> -required and optional properties.
> -Examples:
> -
> -eth0: ethernet@19000000 {
> -	compatible = "qca,ar9330-eth";
> -	reg = <0x19000000 0x200>;
> -	interrupts = <4>;
> -
> -	resets = <&rst 9>, <&rst 22>;
> -	reset-names = "mac", "mdio";
> -	clocks = <&pll ATH79_CLK_AHB>, <&pll ATH79_CLK_AHB>;
> -	clock-names = "eth", "mdio";
> -
> -	phy-mode = "mii";
> -	phy-handle = <&phy_port4>;
> -};
> -
> -eth1: ethernet@1a000000 {
> -	compatible = "qca,ar9330-eth";
> -	reg = <0x1a000000 0x200>;
> -	interrupts = <5>;
> -	resets = <&rst 13>, <&rst 23>;
> -	reset-names = "mac", "mdio";
> -	clocks = <&pll ATH79_CLK_AHB>, <&pll ATH79_CLK_AHB>;
> -	clock-names = "eth", "mdio";
> -
> -	phy-mode = "gmii";
> -
> -	fixed-link {
> -		speed = <1000>;
> -		full-duplex;
> -	};
> -
> -	mdio {
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -
> -		switch10: switch@10 {
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -
> -			compatible = "qca,ar9331-switch";
> -			reg = <0x10>;
> -			resets = <&rst 8>;
> -			reset-names = "switch";
> -
> -			interrupt-parent = <&miscintc>;
> -			interrupts = <12>;
> -
> -			interrupt-controller;
> -			#interrupt-cells = <1>;
> -
> -			ports {
> -				#address-cells = <1>;
> -				#size-cells = <0>;
> -
> -				switch_port0: port@0 {
> -					reg = <0x0>;
> -					ethernet = <&eth1>;
> -
> -					phy-mode = "gmii";
> -
> -					fixed-link {
> -						speed = <1000>;
> -						full-duplex;
> -					};
> -				};
> -
> -				switch_port1: port@1 {
> -					reg = <0x1>;
> -					phy-handle = <&phy_port0>;
> -					phy-mode = "internal";
> -				};
> -
> -				switch_port2: port@2 {
> -					reg = <0x2>;
> -					phy-handle = <&phy_port1>;
> -					phy-mode = "internal";
> -				};
> -
> -				switch_port3: port@3 {
> -					reg = <0x3>;
> -					phy-handle = <&phy_port2>;
> -					phy-mode = "internal";
> -				};
> -
> -				switch_port4: port@4 {
> -					reg = <0x4>;
> -					phy-handle = <&phy_port3>;
> -					phy-mode = "internal";
> -				};
> -			};
> -
> -			mdio {
> -				#address-cells = <1>;
> -				#size-cells = <0>;
> -
> -				interrupt-parent = <&switch10>;
> -
> -				phy_port0: phy@0 {
> -					reg = <0x0>;
> -					interrupts = <0>;
> -				};
> -
> -				phy_port1: phy@1 {
> -					reg = <0x1>;
> -					interrupts = <0>;
> -				};
> -
> -				phy_port2: phy@2 {
> -					reg = <0x2>;
> -					interrupts = <0>;
> -				};
> -
> -				phy_port3: phy@3 {
> -					reg = <0x3>;
> -					interrupts = <0>;
> -				};
> -
> -				phy_port4: phy@4 {
> -					reg = <0x4>;
> -					interrupts = <0>;
> -				};
> -			};
> -		};
> -	};
> -};
> diff --git a/Documentation/devicetree/bindings/net/dsa/qca,ar9331.yaml b/Documentation/devicetree/bindings/net/dsa/qca,ar9331.yaml
> new file mode 100644
> index 000000000000..fd9ddc59d38c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/dsa/qca,ar9331.yaml
> @@ -0,0 +1,161 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/dsa/qca,ar9331.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Atheros AR9331 built-in switch
> +
> +maintainers:
> +  - Oleksij Rempel <o.rempel@pengutronix.de>
> +
> +description:
> +  Qualcomm Atheros AR9331 is a switch built-in to Atheros AR9331 WiSoC and
> +  addressable over internal MDIO bus. All PHYs are built-in as well.
> +
> +properties:
> +  compatible:
> +    const: qca,ar9331-switch
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  interrupt-controller: true
> +
> +  '#interrupt-cells':
> +    const: 1
> +
> +  mdio:
> +    $ref: /schemas/net/mdio.yaml#
> +    unevaluatedProperties: false
> +    properties:
> +      interrupt-parent: true
> +
> +    patternProperties:
> +      '(ethernet-)?phy@[0-4]+$':
> +        type: object
> +        unevaluatedProperties: false
> +
> +        properties:
> +          reg: true
> +          interrupts:
> +            maxItems: 1
> +
> +  resets:
> +    maxItems: 1
> +
> +  reset-names:
> +    items:
> +      - const: switch
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - interrupt-controller
> +  - '#interrupt-cells'
> +  - mdio
> +  - ports
> +  - resets
> +  - reset-names
> +
> +allOf:
> +  - $ref: dsa.yaml#/$defs/ethernet-ports
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    mdio {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        switch10: switch@10 {
> +            compatible = "qca,ar9331-switch";
> +            reg = <0x10>;
> +
> +            interrupt-parent = <&miscintc>;
> +            interrupts = <12>;
> +            interrupt-controller;
> +            #interrupt-cells = <1>;
> +
> +            resets = <&rst 8>;
> +            reset-names = "switch";
> +
> +            ports {
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +
> +                port@0 {
> +                    reg = <0x0>;
> +                    ethernet = <&eth1>;
> +
> +                    phy-mode = "gmii";
> +
> +                    fixed-link {
> +                        speed = <1000>;
> +                        full-duplex;
> +                    };
> +                };
> +
> +                port@1 {
> +                    reg = <0x1>;
> +                    phy-handle = <&phy_port0>;
> +                    phy-mode = "internal";
> +                };
> +
> +                port@2 {
> +                    reg = <0x2>;
> +                    phy-handle = <&phy_port1>;
> +                    phy-mode = "internal";
> +                };
> +
> +                port@3 {
> +                    reg = <0x3>;
> +                    phy-handle = <&phy_port2>;
> +                    phy-mode = "internal";
> +                };
> +
> +                port@4 {
> +                    reg = <0x4>;
> +                    phy-handle = <&phy_port3>;
> +                    phy-mode = "internal";
> +                };
> +            };
> +
> +            mdio {
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +
> +                interrupt-parent = <&switch10>;
> +
> +                phy_port0: ethernet-phy@0 {
> +                    reg = <0x0>;
> +                    interrupts = <0>;
> +                };
> +
> +                phy_port1: ethernet-phy@1 {
> +                    reg = <0x1>;
> +                    interrupts = <0>;
> +                };
> +
> +                phy_port2: ethernet-phy@2 {
> +                    reg = <0x2>;
> +                    interrupts = <0>;
> +                };
> +
> +                phy_port3: ethernet-phy@3 {
> +                    reg = <0x3>;
> +                    interrupts = <0>;
> +                };
> +
> +                phy_port4: ethernet-phy@4 {
> +                    reg = <0x4>;
> +                    interrupts = <0>;
> +                };
> +            };
> +        };
> +    };
> -- 
> 2.34.1
> 
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

