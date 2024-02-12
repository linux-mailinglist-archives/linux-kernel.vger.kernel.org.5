Return-Path: <linux-kernel+bounces-61667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A20851526
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:31:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB4E81C20297
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 792083A1C1;
	Mon, 12 Feb 2024 13:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YBQqvgd8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA613C499;
	Mon, 12 Feb 2024 13:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707743794; cv=none; b=JxQFYiAeVrT2BsF8LBDwBUGH3MwK3lqp6m+/5rlGiB6KuZmQiHtrxq95iZY6gVgniZ1z1+3ks6HToIe88aykwj6fSooKpTR5ntdG8LCPzaRubrHf1ltIkXUZlj1q58AVfkOC1C/Ad4i7Zv4/AkeB1SjE98h0t6kLFcSxyrPlFLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707743794; c=relaxed/simple;
	bh=9sevq/yqb1NYFYOfIyOHJePYkgdalV/0E1nKUcbcKNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sSzrwvI7QBitIOeStPnOUy993pXYlSUVcPOj1P8+7lmFV56KX1RiQs1ED954JGMlYDlhv2OedvVlk+4cCvVH3EL8kdUmJLELHCbPv4PGzNoizHO1XXuw7kYGsX4RIdR+hCtvjzPngSYpN1vHOYrdyLGcR5ZwurMKoDaLdGXvR6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YBQqvgd8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE4D6C433C7;
	Mon, 12 Feb 2024 13:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707743794;
	bh=9sevq/yqb1NYFYOfIyOHJePYkgdalV/0E1nKUcbcKNc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YBQqvgd8VpHznL+2fPx1BpJzFkdBIj+hfBKMURUlx4Z+sCT3dE9pI+lR3o8sdRVJG
	 p+D5J1WaYWTFQDs2QJXQPx9aZnFO89wgHY/ouZlRqC5hUnR+PFwKNi292GrE6S97d3
	 euxsGhWTecaAeQ5MK1A8v56g4a1VT8zgUJWWSTFeustlByzP4NcYIJCLZFATGU8g74
	 lt2+P+kXZz+E7Ayk/tTCBiZt6M33n/ecVTYrVQHwwqLt/DqC5g/lIAVM58SHTTdVj3
	 epfb/TKkslN0bqdi4JsxDSRCtQpo7npzpbcEKBZ0Bdg34yNqNweKkNq/O1S2ovqtBG
	 LqJV0tJs8rUzg==
Date: Mon, 12 Feb 2024 07:16:31 -0600
From: Rob Herring <robh@kernel.org>
To: Sebastian Reichel <sre@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	NXP Linux Team <linux-imx@nxp.com>,
	Dong Aisheng <aisheng.dong@nxp.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 02/14] dt-bindings: bus: imx-weim: convert to YAML
Message-ID: <20240212131631.GA13910-robh@kernel.org>
References: <20240210012114.489102-1-sre@kernel.org>
 <20240210012114.489102-3-sre@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240210012114.489102-3-sre@kernel.org>

On Sat, Feb 10, 2024 at 02:18:06AM +0100, Sebastian Reichel wrote:
> Convert the i.MX  Wireless External Interface Module binding to YAML.
> 
> Signed-off-by: Sebastian Reichel <sre@kernel.org>
> ---
>  .../devicetree/bindings/bus/fsl,imx-weim.yaml | 225 ++++++++++++++++++
>  .../devicetree/bindings/bus/imx-weim.txt      | 117 ---------
>  2 files changed, 225 insertions(+), 117 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/bus/fsl,imx-weim.yaml
>  delete mode 100644 Documentation/devicetree/bindings/bus/imx-weim.txt
> 
> diff --git a/Documentation/devicetree/bindings/bus/fsl,imx-weim.yaml b/Documentation/devicetree/bindings/bus/fsl,imx-weim.yaml
> new file mode 100644
> index 000000000000..3d27bdaef304
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/bus/fsl,imx-weim.yaml
> @@ -0,0 +1,225 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/bus/fsl,imx-weim.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: i.MX Wireless External Interface Module (WEIM)
> +
> +maintainers:
> +  - Shawn Guo <shawnguo@kernel.org>
> +  - Sascha Hauer <s.hauer@pengutronix.de>
> +
> +description:
> +  The term "wireless" does not imply that the WEIM is literally an interface
> +  without wires. It simply means that this module was originally designed for
> +  wireless and mobile applications that use low-power technology. The actual
> +  devices are instantiated from the child nodes of a WEIM node.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - enum:
> +          - fsl,imx1-weim
> +          - fsl,imx27-weim
> +          - fsl,imx50-weim
> +          - fsl,imx51-weim
> +          - fsl,imx6q-weim
> +      - items:
> +          - enum:
> +              - fsl,imx31-weim
> +              - fsl,imx35-weim
> +          - const: fsl,imx27-weim
> +      - items:
> +          - enum:
> +              - fsl,imx6sx-weim
> +              - fsl,imx6ul-weim
> +          - const: fsl,imx6q-weim
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  '#address-cells':
> +    const: 2
> +
> +  '#size-cells':
> +    const: 1
> +
> +  ranges: true
> +
> +  fsl,weim-cs-gpr:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: |
> +      Phandle to the system General Purpose Register controller that contains
> +      WEIM CS GPR register, e.g. IOMUXC_GPR1 on i.MX6Q. IOMUXC_GPR1[11:0]
> +      should be set up as one of the following 4 possible values depending on
> +      the CS space configuration.
> +
> +      IOMUXC_GPR1[11:0]    CS0    CS1    CS2    CS3
> +      ---------------------------------------------
> +              05          128M     0M     0M     0M
> +              033          64M    64M     0M     0M
> +              0113         64M    32M    32M     0M
> +              01111        32M    32M    32M    32M
> +
> +      In case that the property is absent, the reset value or what bootloader
> +      sets up in IOMUXC_GPR1[11:0] will be used.
> +
> +  fsl,burst-clk-enable:
> +    type: boolean
> +    description:
> +      The presence of this property indicates that the weim bus should operate
> +      in Burst Clock Mode.
> +
> +  fsl,continuous-burst-clk:
> +    type: boolean
> +    description:
> +      Make Burst Clock to output continuous clock. Without this option Burst
> +      Clock will output clock only when necessary.
> +
> +patternProperties:
> +  "^.*@[0-7],[0-9a-f]+$":
> +    description: Devices attached to chip selects are represented as subnodes.
> +    type: object
> +    additionalProperties: true
> +    properties:
> +      fsl,weim-cs-timing:
> +        $ref: /schemas/types.yaml#/definitions/uint32-array
> +        description:
> +          Timing values for the child node.
> +    required:
> +      - fsl,weim-cs-timing

This needs to go in its own schema doc and then added to 
memory-controllers/mc-peripheral-props.yaml

We should probably also move this binding to memory-controllers/


> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          not:
> +            contains:
> +              enum:
> +                - fsl,imx50-weim
> +                - fsl,imx6q-weim
> +    then:
> +      properties:
> +        fsl,weim-cs-gpr: false
> +        fsl,burst-clk-enable: false
> +  - if:
> +      properties:
> +        fsl,burst-clk-enable: false
> +    then:
> +      properties:
> +        fsl,continuous-burst-clk: false
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: fsl,imx1-weim
> +    then:
> +      patternProperties:
> +        "^.*@[0-7],[0-9a-f]+$":
> +          properties:
> +            fsl,weim-cs-timing:
> +              items:
> +                items:
> +                  - description: CSxU
> +                  - description: CSxL
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - fsl,imx27-weim
> +              - fsl,imx31-weim
> +              - fsl,imx35-weim
> +    then:
> +      patternProperties:
> +        "^.*@[0-7],[0-9a-f]+$":
> +          properties:
> +            fsl,weim-cs-timing:
> +              items:
> +                items:
> +                  - description: CSCRxU
> +                  - description: CSCRxL
> +                  - description: CSCRxA
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - fsl,imx50-weim
> +              - fsl,imx51-weim
> +              - fsl,imx6q-weim
> +              - fsl,imx6sx-weim
> +              - fsl,imx6ul-weim
> +    then:
> +      patternProperties:
> +        "^.*@[0-7],[0-9a-f]+$":
> +          properties:
> +            fsl,weim-cs-timing:
> +              items:
> +                items:
> +                  - description: CSxGCR1
> +                  - description: CSxGCR2
> +                  - description: CSxRCR1
> +                  - description: CSxRCR2
> +                  - description: CSxWCR1
> +                  - description: CSxWCR2
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - '#address-cells'
> +  - '#size-cells'
> +  - ranges
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    weim@21b8000 {

bus or external-bus

> +        compatible = "fsl,imx6q-weim";
> +        reg = <0x021b8000 0x4000>;
> +        clocks = <&clks 196>;
> +        #address-cells = <2>;
> +        #size-cells = <1>;
> +        ranges = <0 0 0x08000000 0x08000000>;
> +        fsl,weim-cs-gpr = <&gpr>;
> +
> +        nor@0,0 {
> +            compatible = "cfi-flash";
> +            reg = <0 0 0x02000000>;
> +            #address-cells = <1>;
> +            #size-cells = <1>;
> +            bank-width = <2>;
> +            fsl,weim-cs-timing = <0x00620081 0x00000001 0x1c022000
> +            0x0000c000 0x1404a38e 0x00000000>;
> +        };
> +    };
> +  - |
> +    weim@21b8000 {
> +        compatible = "fsl,imx6q-weim";
> +        reg = <0x021b8000 0x4000>;
> +        clocks = <&clks 196>;
> +        #address-cells = <2>;
> +        #size-cells = <1>;
> +        ranges = <0 0 0x08000000 0x02000000
> +                  1 0 0x0a000000 0x02000000
> +                  2 0 0x0c000000 0x02000000
> +                  3 0 0x0e000000 0x02000000>;
> +        fsl,weim-cs-gpr = <&gpr>;
> +
> +        acme@0,0 {
> +            compatible = "acme,whatever";

Real bindings only please.

> +            reg = <0 0 0x100>, <0 0x400000 0x800>,
> +                  <1 0x400000 0x800>;
> +            fsl,weim-cs-timing = <0x024400b1 0x00001010 0x20081100
> +                                  0x00000000 0xa0000240 0x00000000>;
> +        };
> +    };

