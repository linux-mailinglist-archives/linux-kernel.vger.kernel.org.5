Return-Path: <linux-kernel+bounces-67073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C3EE8565CA
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 15:21:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3A88B298C8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 561FC132460;
	Thu, 15 Feb 2024 14:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YWuvvNYS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8A2131E30;
	Thu, 15 Feb 2024 14:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708006856; cv=none; b=p6NXcgxLzi8kKxOSPOuYNJ4Lf6P/fpHLVa5wJucaJqVjsfAtV2mZXoj2W15EMFZ5G19qD45qpSiuWKa27LxIpHHS4SAYKtJpbuorUcgfP/LANcDoHxn8pSbNPkmdZbLSXW/C6FZpXXvguCPnB+fxzazd6IFNan8FTzvOgYL6mew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708006856; c=relaxed/simple;
	bh=qG3ZHYBiDwbAE38UnY8R+8ABLhQ9dBG0ngefFLJqfQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uF69odVXWxJ3AftY8cx73ax1HeQT/XuN6bzn1sS1bBHmm8IFit0IOm/xlsdEgoeeWTwUTm3ixkhaYApoSR/BmfpCJFh3gdOD7jxkBnvLtlWZKEBB7dkbmaVt1xyxxlIahZ8+mPsj7651UL3PgRMK+qU8DDoGIcnwMw+oXI/qRhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YWuvvNYS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D682C433C7;
	Thu, 15 Feb 2024 14:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708006855;
	bh=qG3ZHYBiDwbAE38UnY8R+8ABLhQ9dBG0ngefFLJqfQw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YWuvvNYSkkYbAeaaoOcy8L5gq1oLZLOaKS5668bg69MkV9SPWOqz9ygbAXOsJYJ3D
	 dkOXamVOHnRWvK0xwGBkloa1s7T4YohYJaHFHdPf0VxpBbz0JMg8UgnQUW3fWuFnYH
	 IKSjr0LC782og6hOtPNSlMRDaFAxzG+1QGIdrK+TDDujmBrRAp2ViTvvSvk+Ab1p4v
	 SauZlv9oSzEzNT5XfMZH3D5tvaGCS47cV2mPOr88T+TOxn1233MUbUWkkkD6fHYW4q
	 tc60G2YvmseIfR3Yoo4kdTocKeIcnGLFh1/HeSwZc74SnyBeB5F7jUX20L3IRTKCSB
	 fNhfHXQrMvOTw==
Date: Thu, 15 Feb 2024 08:20:52 -0600
From: Rob Herring <robh@kernel.org>
To: Karel Balej <karelb@gimli.ms.mff.cuni.cz>
Cc: Karel Balej <balejk@matfyz.cz>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, linux-input@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Duje =?utf-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
	~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: Re: [RFC PATCH v2 1/6] dt-bindings: mfd: add entry for Marvell
 88PM886 PMIC
Message-ID: <20240215142052.GA4180777-robh@kernel.org>
References: <20240211094609.2223-1-karelb@gimli.ms.mff.cuni.cz>
 <20240211094609.2223-2-karelb@gimli.ms.mff.cuni.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240211094609.2223-2-karelb@gimli.ms.mff.cuni.cz>

On Sun, Feb 11, 2024 at 10:35:51AM +0100, Karel Balej wrote:
> From: Karel Balej <balejk@matfyz.cz>
> 
> Marvell 88PM886 is a PMIC with several subdevices such as onkey,
> regulators or battery and charger. It comes in at least two revisions,
> A0 and A1 -- only A1 is described here at the moment.
> 
> Signed-off-by: Karel Balej <balejk@matfyz.cz>
> ---
> 
> Notes:
>     RFC v2:
>     - Address Rob's feedback:
>       - Drop mention of 88PM880.
>       - Make sure the file passes bindings check (add the necessary header
>         and fix `interrupt-cells`).
>       - Other small changes.
>     - Add regulators. Changes with respect to the regulator RFC series:
>       - Address Krzysztof's comments:
>         - Drop unused compatible.
>         - Fix sub-node pattern.
> 
>  .../bindings/mfd/marvell,88pm88x.yaml         | 74 +++++++++++++++++++

Filename should match the compatible.

In general, drop the 'x' wildcard.

>  .../regulator/marvell,88pm88x-regulator.yaml  | 28 +++++++
>  2 files changed, 102 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/marvell,88pm88x.yaml
>  create mode 100644 Documentation/devicetree/bindings/regulator/marvell,88pm88x-regulator.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mfd/marvell,88pm88x.yaml b/Documentation/devicetree/bindings/mfd/marvell,88pm88x.yaml
> new file mode 100644
> index 000000000000..29ab979862d5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/marvell,88pm88x.yaml
> @@ -0,0 +1,74 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/marvell,88pm88x.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Marvell 88PM88X PMIC core
> +
> +maintainers:
> +  - Karel Balej <balejk@matfyz.cz>
> +
> +description:
> +  Marvell 88PM886 is a PMIC providing several functions such as onkey,
> +  regulators or battery and charger.
> +
> +properties:
> +  compatible:
> +    const: marvell,88pm886-a1
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupt-controller: true

What is the device providing interrupts to (in DT)?

> +
> +  interrupts:
> +    maxItems: 1
> +
> +  "#interrupt-cells":
> +    const: 1
> +
> +  regulators:
> +    $ref: /schemas/regulator/marvell,88pm88x-regulator.yaml#

That's simple enough, I'd just move the regulator nodes into this doc.

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupt-controller
> +  - interrupts
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +      pmic@30 {
> +        compatible = "marvell,88pm886-a1";
> +        reg = <0x30>;
> +        interrupts = <0 4 IRQ_TYPE_LEVEL_HIGH>;
> +        interrupt-parent = <&gic>;
> +        interrupt-controller;
> +        #interrupt-cells = <1>;
> +
> +        regulators {
> +          ldo2: ldo2 {
> +            regulator-min-microvolt = <3100000>;
> +            regulator-max-microvolt = <3300000>;
> +            };
> +
> +          ldo15: ldo15 {
> +            regulator-min-microvolt = <3300000>;
> +            regulator-max-microvolt = <3300000>;
> +            };
> +
> +          buck2: buck2 {
> +            regulator-min-microvolt = <1800000>;
> +            regulator-max-microvolt = <1800000>;
> +            };
> +        };
> +      };
> +    };
> +...
> diff --git a/Documentation/devicetree/bindings/regulator/marvell,88pm88x-regulator.yaml b/Documentation/devicetree/bindings/regulator/marvell,88pm88x-regulator.yaml
> new file mode 100644
> index 000000000000..1b4b5f1b4932
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/marvell,88pm88x-regulator.yaml
> @@ -0,0 +1,28 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/regulator/marvell,88pm88x-regulator.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Regulators of Marvell 88PM88X PMICs.
> +
> +maintainers:
> +  - Karel Balej <balejk@matfyz.cz>
> +
> +description: |
> +  This is a part of device tree bindings for Marvell 88PM88X MFD.
> +
> +  The regulators node is represented as a sub-node of the PMIC node on the
> +  device tree.
> +
> +  See also Documentation/devicetree/bindings/mfd/marvell,88pm88x.yaml for
> +  additional information and example.
> +
> +patternProperties:
> +  "^(ldo(1[0-6]|[1-9])|buck[1-5])$":
> +    type: object
> +    $ref: /schemas/regulator/regulator.yaml#
> +    description: LDO or buck regulator.
> +    unevaluatedProperties: false
> +
> +additionalProperties: false
> -- 
> 2.43.0
> 

