Return-Path: <linux-kernel+bounces-161739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B23DF8B507B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 07:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D74B01C21A03
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 05:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0478CD520;
	Mon, 29 Apr 2024 05:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nxGCJSnH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1422B372;
	Mon, 29 Apr 2024 05:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714367265; cv=none; b=qYnRAXy3sCjtiae6EkqcM6tX3i5VDaGqCtcHQgDX01ngqPLEHqYf3p6xax1q45N/iETfny3oVXaR9BVZq6q56YPFd/8Nc/ivvoKW4nmDzdyroIl4KqJZMZXC7zu622v0n6nuVHfetR3m6QIhvQJjpJ8+pg+TVz2cLefwHCCHRAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714367265; c=relaxed/simple;
	bh=4yumOtWk+CUvCeDlMuZqjH/oo4gxzHrDIJIlWnfOnqc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J5pJqvaMFLUSaVpQBjaDoAhMpmK1hO17ZuqJVVjzCbBjdSFZUbbgs/58j3CtmR802/X/4F57Dz/B8aBWfZtbdcbTDh3QsQac1yiKlplXWkGEZ7vJ+ndGerdLh3y3ZTto/obfvkVgyYagxMXVB4jz4PO0K+YFR/q6FtvTM6KzVRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nxGCJSnH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F703C113CD;
	Mon, 29 Apr 2024 05:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714367264;
	bh=4yumOtWk+CUvCeDlMuZqjH/oo4gxzHrDIJIlWnfOnqc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nxGCJSnHiaf6RUrZklrHzo1HZdMckjjdvP2zLZ8HzvklBZX34c2KkrwjE1HmDWQ3H
	 zXM+rolOVYqnAN9DFaRmomB4FazqXumdD2tYOzVnp4TXChvQeeZRfx8/Tgd5JsveHT
	 k7r/8Ak/5HtDUtVYIXkzjgVYbJSSKxIt6iB+Y7zgLEXyLPX4NFzeac55QHjSGbvUwL
	 7D8M5+D69fyj7DW2uQ9FCflLeF217/cF8A3mcsAkUXIrObXOO36jKRsjn3FtmnfBSJ
	 x6JG2xog+ykpLrcfta69TyKGN246CD+U8ctiDts1VxjN8rzi1Pv5ymwFW6E419GRaA
	 dVZ1UdBPYiqKw==
Message-ID: <59fe75b6-a4a4-4c90-a3c4-c8a4b539e879@kernel.org>
Date: Mon, 29 Apr 2024 07:07:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] spi: dt-bindings: ti,qspi: convert to dtschema
To: Kousik Sanagavarapu <five231003@gmail.com>,
 Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
References: <20240428070258.4121-1-five231003@gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240428070258.4121-1-five231003@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/04/2024 08:58, Kousik Sanagavarapu wrote:
> Convert txt binding of TI's qspi controller (found on their omap SoCs) to
> dtschema to allow for validation.
> 
> It is however to be noted that it is not a one-to-one conversion, in the
> sense that the original txt binding needed to be updated, but these
> changes are included in the dtschema and are mentioned below.

Drop this paragraph.

> 
> The changes, w.r.t. the original txt binding, are:

You also dropped qspi_ctrlmod during conversion.

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
> +
> +  spi-max-frequency:
> +    description: Maximum SPI clocking speed of the controller in Hz.
> +    $ref: /schemas/types.yaml#/definitions/uint32


Are you sure that's actually needed? That's not a property of controller.

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

Drop. Are you sure driver parses it?

> +        interrupts = <GIC_SPI 343 IRQ_TYPE_LEVEL_HIGH>;
> +    };



Best regards,
Krzysztof


