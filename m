Return-Path: <linux-kernel+bounces-105540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7897287DFE8
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 21:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A92E21C20D4C
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 20:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF7091F94D;
	Sun, 17 Mar 2024 20:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qNz/dLcX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A311EB2D;
	Sun, 17 Mar 2024 20:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710705848; cv=none; b=KoRfc45tylACsUBfkfareGXmfmFqQ3Y1Usq9enqzbqS72VshGMiXMlkC9mduScQGCSkNv+Vgh1u33N/Nu1aQ3bzgqNbO3sCEEsyHm0VZY0nZzpeqKDIv21FJ/DW4f6G0Y1tFBavrb9RPMYd7kAgEaza/PL0Dbfmk3Gw7MkBJ94s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710705848; c=relaxed/simple;
	bh=5REz72U9EXohcBm4t1ISQL1fVcumFebJbP7464UzW58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lvrHT/Sf+WPXEgf01GHjoZgfcRJfkEYAKSRrlxWE9Iife79OmuXlfJ8WeUMD/eB91p3hZBgPF+vvKhill64ktS8OEBTVStz1YkJvWejLV64/yW0eK9ltcw5CezZ0a31W0VlOoVGNzS8vRC+TCK8ygDhtTE17Qy8tssK54aU+cJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qNz/dLcX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62B2DC433C7;
	Sun, 17 Mar 2024 20:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710705847;
	bh=5REz72U9EXohcBm4t1ISQL1fVcumFebJbP7464UzW58=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qNz/dLcXv0wcHjcVrtYves10JWPaWLj69D66ZAG/JP5m0DvbluCEPotJjYIH0oKor
	 KoXt4ogga/oB/Xzh9sV5rZ3t42s1XTWwRre+zYqp2K1plAv+P++eS0X5y3qmmJr1R4
	 DsMb5rC9pyEU8XGCPrwkRiaoaq1x6K7I1fCJe7RuQBEz2Fi3/hW4/Ph5vbVkWPXXUU
	 dwX99GJz0vgQSXX5eLSwF2/QWvkjEPLHqEXjePj0m8uhSb5wjGYk4mYuYY+F4HDaSN
	 aD8a1lBmc6lQzqLk6EjHGwf/pcw+1bRfXF02k1PDkxuys5DfN4FCh7Tl4dCEy88XR5
	 2HPCQeIFjGm+g==
Date: Sun, 17 Mar 2024 14:04:04 -0600
From: Rob Herring <robh@kernel.org>
To: Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	herve.codina@bootlin.com, christophercordahi@nanometrics.ca
Subject: Re: [PATCH 01/13] ASoC: dt-bindings: davinci-mcbsp: convert McBSP
 bindings to yaml schema
Message-ID: <20240317200404.GA2123402-robh@kernel.org>
References: <20240315112745.63230-1-bastien.curutchet@bootlin.com>
 <20240315112745.63230-2-bastien.curutchet@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240315112745.63230-2-bastien.curutchet@bootlin.com>

On Fri, Mar 15, 2024 at 12:27:33PM +0100, Bastien Curutchet wrote:
> Convert the binding for McBSP controllers for TI SoCs from txt
> to YAML schema.
> 
> Add properties 'clocks', 'clock-names', 'power-domains' and
> '#sound-dai-cells' which were missing from the txt file.
> Add '#sound-dai-cells' and 'clocks' in the example which were missing
> from the txt file.
> 
> Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
> ---
>  .../bindings/sound/davinci-mcbsp.txt          | 50 ----------
>  .../bindings/sound/davinci-mcbsp.yaml         | 96 +++++++++++++++++++
>  2 files changed, 96 insertions(+), 50 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/davinci-mcbsp.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/davinci-mcbsp.yaml

> diff --git a/Documentation/devicetree/bindings/sound/davinci-mcbsp.yaml b/Documentation/devicetree/bindings/sound/davinci-mcbsp.yaml
> new file mode 100644
> index 000000000000..8b0e9b5da08f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/davinci-mcbsp.yaml
> @@ -0,0 +1,96 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/davinci-mcbsp.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: McBSP Controller for TI SoCs
> +
> +maintainers:
> +  - Bastien Curutchet <bastien.curutchet@bootlin.com>
> +
> +allOf:
> +  - $ref: dai-common.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,da850-mcbsp
> +
> +  reg:
> +    minItems: 1
> +    items:
> +      - description: CFG registers
> +      - description: data registers
> +
> +  reg-names:
> +    minItems: 1
> +    items:
> +      - const: mpu
> +      - const: dat
> +
> +  dmas:
> +    items:
> +      - description: transmission DMA channel
> +      - description: reception DMA channel
> +
> +  dma-names:
> +    items:
> +      - const: tx
> +      - const: rx
> +
> +  interrupts:
> +    items:
> +      - description: RX interrupt
> +      - description: TX interrupt
> +
> +  interrupt-names:
> +    items:
> +      - const: rx
> +      - const: tx
> +
> +  clocks:
> +    items:
> +      - description: functional clock
> +
> +  clock-names:
> +    items:
> +      - const: fck
> +
> +  power-domains:
> +    description: phandle to the corresponding power-domain

Drop

> +    maxItems: 1
> +
> +  "#sound-dai-cells":
> +    const: 0
> +
> +required:
> +  - "#sound-dai-cells"
> +  - compatible
> +  - reg
> +  - reg-names
> +  - dmas
> +  - dma-names
> +  - clocks
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    mcbsp0: mcbsp0@1d10000 {

Drop unused label.


> +      #sound-dai-cells = <0>;
> +      compatible = "ti,da850-mcbsp";
> +      pinctrl-names = "default";
> +      pinctrl-0 = <&mcbsp0_pins>;
> +
> +      reg = <0x111000 0x1000>,
> +            <0x311000 0x1000>;
> +      reg-names = "mpu", "dat";
> +      interrupts = <97>, <98>;
> +      interrupt-names = "rx", "tx";
> +      dmas = <&edma0 3 1
> +              &edma0 2 1>;

<> around each entry.

Otherwise,

Reviewed-by: Rob Herring <robh@kernel.org>

> +      dma-names = "tx", "rx";
> +
> +      clocks = <&psc1 14>;
> +    };
> -- 
> 2.43.2
> 

