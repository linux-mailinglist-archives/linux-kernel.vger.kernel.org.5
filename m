Return-Path: <linux-kernel+bounces-162684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D08748B5EF2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 18:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 814A31F231C9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 16:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C41CD84D27;
	Mon, 29 Apr 2024 16:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YdFmBhSI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0791684A30;
	Mon, 29 Apr 2024 16:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714408003; cv=none; b=VW4ikAVkKVysv6Xbjg8aIrngvbxBkhIFbLDv5AUzOg4ZjiZam+FDwUcqqOnkcrORTvZ4Hi+ZQmPxZnn8JxilL8Hz4kPm/zSxWpAL9IHkdegvYfTpD/vxy51/+Eu4stEMmVRf07v5lP2wwR0ktyFKseqYaRAI4lVMHON72Xzrp5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714408003; c=relaxed/simple;
	bh=rOM1bVRQ6p6GxSlIurAiFg7nkb2fTkqCkQNMOYHUCeA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jMY+ZgDU3Oor5MOCpHxhuk4iRJxzFKpsGhjgEABtYb1pY6yVENV2S/gkR9RKsBCa42PGyvkqhMnhmJZrfYJATS4/KG/y9VUJFcqGURuYfjiAJfkB5pJjPQPDRyPDUlAn3syazA7fqbnc3yAzuSurola+nHB3Kk0ylfaU0oaug+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YdFmBhSI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1138C113CD;
	Mon, 29 Apr 2024 16:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714408002;
	bh=rOM1bVRQ6p6GxSlIurAiFg7nkb2fTkqCkQNMOYHUCeA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YdFmBhSI3aPzF/AZRMgs7i0aFSVP/V7Oks9QzXQBZmQ5IlPgQXQwN3Lmz1frxFV7G
	 iLbbyIOgWK1elfUX2Q/JXAk55Gxj/4AmnqsWorIeuTUFHg+03bQKkW06E+JkRKqYsn
	 WA2jEKDrLQXeePIwFo8RBKc6M1D0YcXQoigWMnklXbSPc/Z0Kzx0VYHufhq6+443td
	 qa/VIGPpSiaR5rhi6TGuSQwL/F/aX8E9V0M+uLWN5HY1i+aOvi1ArOkOe3vxe9aPwr
	 Yy9+0PRNvEwRIT+BDJrlXjCSvhcFle8Hb9xIQCnHDY+H4V9FjPn23+nU6GIjhqVfNb
	 Z8/8gRFvb0Buw==
Date: Mon, 29 Apr 2024 11:26:38 -0500
From: Rob Herring <robh@kernel.org>
To: Kousik Sanagavarapu <five231003@gmail.com>
Cc: Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: Re: [RFC PATCH] spi: dt-bindings: ti,qspi: convert to dtschema
Message-ID: <20240429162638.GA2066527-robh@kernel.org>
References: <20240428070258.4121-1-five231003@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240428070258.4121-1-five231003@gmail.com>

On Sun, Apr 28, 2024 at 12:28:59PM +0530, Kousik Sanagavarapu wrote:
> Convert txt binding of TI's qspi controller (found on their omap SoCs) to
> dtschema to allow for validation.
> 
> It is however to be noted that it is not a one-to-one conversion, in the
> sense that the original txt binding needed to be updated, but these
> changes are included in the dtschema and are mentioned below.
> 
> The changes, w.r.t. the original txt binding, are:
> 
> - Introduce "clocks" and "clock-names" which was never mentioned.
> - Reflect that "ti,hwmods" is deprecated and is not a "required"
>   property anymore.
> - Introduce "num-cs" which allows for setting the number of chip
>   selects.
> 
> Signed-off-by: Kousik Sanagavarapu <five231003@gmail.com>
> ---
> I'm a bit iffy about this one as I guess the original txt binding failed
> to cover some things about the properties.  I added the properties based
> on their use in the *.dtsi files when I grepped for the compatible string
> 
>         arch/arm/boot/dts/ti/omap/dra7.dtsi
>         arch/arm/boot/dts/ti/omap/am4372.dtsi
> 
> I also looked at the probe function in the driver for it, which can be
> found at
> 
>         drivers/spi/spi-ti-qspi.c
> 
>  .../devicetree/bindings/spi/ti,qspi.yaml      | 94 +++++++++++++++++++
>  .../devicetree/bindings/spi/ti_qspi.txt       | 53 -----------
>  2 files changed, 94 insertions(+), 53 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/spi/ti,qspi.yaml
>  delete mode 100644 Documentation/devicetree/bindings/spi/ti_qspi.txt
> 
> diff --git a/Documentation/devicetree/bindings/spi/ti,qspi.yaml b/Documentation/devicetree/bindings/spi/ti,qspi.yaml
> new file mode 100644
> index 000000000000..77cabd7158f5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/ti,qspi.yaml
> @@ -0,0 +1,94 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/ti,qspi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: TI QSPI controller
> +
> +maintainers:
> +  - Kousik Sanagavarapu <five231003@gmail.com>
> +
> +allOf:
> +  - $ref: spi-controller.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,am4372-qspi
> +      - ti,dra7xxx-qspi
> +
> +  reg:
> +    items:
> +      - description: base registers
> +      - description: mapped memory
> +
> +  reg-names:
> +    items:
> +      - const: qspi_base
> +      - const: qspi_mmap
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    items:
> +      - const: fck
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  num-cs:
> +    maxItems: 1

This is not an array, so maxItems is not appropriate. If there are only 
certain values supported (default is up to 2^32), then you should 
define them with enum or maximum.

> +
> +  ti,hwmods:
> +    description:
> +      Name of the hwmod associated to the QSPI.  This is for legacy
> +      platforms only.
> +    $ref: /schemas/types.yaml#/definitions/string
> +    deprecated: true
> +
> +  syscon-chipselects:
> +    description:
> +      Handle to system control region contains QSPI chipselect register
> +      and offset of that register.
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    items:
> +      items:
> +        - description: phandle to system control register
> +        - description: register offset

This allows any number of phandle+offset entries. Is that what you want? 
If not, you need either '- items' for the 2nd 'items' or 'maxItems: 1'.

> +
> +  spi-max-frequency:
> +    description: Maximum SPI clocking speed of the controller in Hz.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - clocks
> +  - clock-names
> +  - interrupts
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/dra7.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    qspi: spi@0 {

Drop unused labels.

Unit-address is wrong.

> +        compatible = "ti,dra7xxx-qspi";
> +        reg = <0x4b300000 0x100>,
> +              <0x5c000000 0x4000000>;
> +        reg-names = "qspi_base", "qspi_mmap";
> +        syscon-chipselects = <&scm_conf 0x558>;
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        clocks = <&l4per2_clkctrl DRA7_L4PER2_QSPI_CLKCTRL 25>;
> +        clock-names = "fck";
> +        num-cs = <4>;
> +        spi-max-frequency = <48000000>;
> +        interrupts = <GIC_SPI 343 IRQ_TYPE_LEVEL_HIGH>;
> +    };
> +...

