Return-Path: <linux-kernel+bounces-3913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40BC481750F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:18:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9A791F2164F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 15:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F9C3D577;
	Mon, 18 Dec 2023 15:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uH+hX3bx"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD15229411;
	Mon, 18 Dec 2023 15:17:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49290C433C8;
	Mon, 18 Dec 2023 15:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702912640;
	bh=Y2AbD1zR1eP2E6YbgGaYlyb+Rv+NoXGbIguzY9TYF+M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uH+hX3bxsibP2IzdFAFraViSj2c3EKBA+vg98LMVTaanUWvaeDExoG7X8q6kCnBUm
	 Dv1V29e4Ka1B8X2rf5pLY0zonx2asWLO2PoKzMi+80CKPSUEcc/GaX/F1A7bPESnM6
	 A5TY6NDjHI0Zls6dip8zSZVCSs24lelmKL1D5zX1uJCEDBNroPdon06u5jRsmiIHhX
	 Q0+ZSSs62ZBCtzKLQU7PumZc6OJp0U2VLiSqFXB1tl9wxE8u/K/X1uyKPaK4dNEd/H
	 Mv8I9VEJI6gaV656NOSWtLlN/JKtGmaStqEm3y3muWyjTL3G0fiuJCNwDOwxVmoBth
	 X8+hsU5pRBVJA==
Received: (nullmailer pid 3834100 invoked by uid 1000);
	Mon, 18 Dec 2023 15:17:18 -0000
Date: Mon, 18 Dec 2023 09:17:18 -0600
From: Rob Herring <robh@kernel.org>
To: Karel Balej <karelb@gimli.ms.mff.cuni.cz>
Cc: Karel Balej <balejk@matfyz.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Duje =?utf-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>, ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: Re: [RFC PATCH 1/5] dt-bindings: mfd: add entry for the Marvell
 88PM88X PMICs
Message-ID: <20231218151718.GA3827526-robh@kernel.org>
References: <20231217131838.7569-1-karelb@gimli.ms.mff.cuni.cz>
 <20231217131838.7569-2-karelb@gimli.ms.mff.cuni.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231217131838.7569-2-karelb@gimli.ms.mff.cuni.cz>

On Sun, Dec 17, 2023 at 02:16:59PM +0100, Karel Balej wrote:
> From: Karel Balej <balejk@matfyz.cz>
> 
> Marvell 88PM880 and 88PM886 are two similar PMICs with mostly matching
> register mapping and subdevices such as onkey, regulators or battery and
> charger. Both seem to come in two revisions which seem to be handled
> slightly differently in some subdevice drivers.
> 
> Signed-off-by: Karel Balej <balejk@matfyz.cz>
> ---
>  .../bindings/mfd/marvell,88pm88x.yaml         | 55 +++++++++++++++++++
>  1 file changed, 55 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/marvell,88pm88x.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mfd/marvell,88pm88x.yaml b/Documentation/devicetree/bindings/mfd/marvell,88pm88x.yaml
> new file mode 100644
> index 000000000000..e075729c360f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/marvell,88pm88x.yaml
> @@ -0,0 +1,55 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/marvell,88pm88x.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Marvell 88PM88X PMIC core MFD

Drop 'MFD'.

> +
> +maintainers:
> +  - Karel Balej <balejk@matfyz.cz>
> +
> +description: |

Don't need '|' as there is no formatting to preserve.

> +  Marvell 88PM880 and 88PM886 are two similar PMICs providing
> +  several functions such as onkey, regulators or battery and
> +  charger. Both seem to come in two revisions -- A0 and A1.
> +
> +properties:
> +  compatible:
> +    const: marvell,88pm886-a1

The description talks about 4 different devices, but only 1 here. 

Do you expect to need A0 support? Devices with these PMICs should be 
known and few, right? 

> +
> +  reg:
> +    description: I2C device address

Drop.

> +    maxItems: 1
> +
> +  interrupt-controller: true
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  "#interrupt-cells":
> +    const: 2
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
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +      pmic0: 88pm886@30 {

pmic@30

Drop the unused label.

> +        compatible = "marvell,88pm886-a1";
> +        reg = <0x30>;
> +        interrupts = <0 4 IRQ_TYPE_LEVEL_HIGH>;

You need the header for this.

You'll find the input binding fails too. Please test your bindings 
before sending.

> +        interrupt-parent = <&gic>;
> +        interrupt-controller;
> +        #interrupt-cells = <1>;
> +      };
> +    };
> +...
> -- 
> 2.43.0
> 

