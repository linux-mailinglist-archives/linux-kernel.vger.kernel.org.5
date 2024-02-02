Return-Path: <linux-kernel+bounces-50551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89101847AA9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 21:45:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27F441F25CCA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 20:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876B77A71F;
	Fri,  2 Feb 2024 20:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="daMElx/P"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1FF182AE;
	Fri,  2 Feb 2024 20:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706906738; cv=none; b=SZn1L4Hq+WazEG1D2nshxAbbE7jeO2uzrbDEN2qh4rgX2fCReMdpX2HxiBoKM2I0+dP+S9JFYlP3l2eKON4o8f2LytG0r4O0TEvP/CYPalgjrl8WQdCojuc6SLO61yaJqRtPm8iPYXZv0WxpVndqd4q797efr5nCDi3pc8o6IuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706906738; c=relaxed/simple;
	bh=C/VMZZQUDDRS58ykeTSF3+aBedhLWIE8vgnf5IcVwP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=as8X5D2t385/8WSBCf3Gk6v2BoWNiEaXseBpe2GkpiypyUgd7qmGJj7GbdNK9GUVKdVWZLTpUuq74PvUQdJ8zR/4ZdNdUs+T8z+ES4d+sffmLTnYjir0SC1vnGT/MKCUiJ2/dDF+NLKgd2gzmn9yIMWl8jNjhe88DoQMA4uIOWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=daMElx/P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69277C433C7;
	Fri,  2 Feb 2024 20:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706906738;
	bh=C/VMZZQUDDRS58ykeTSF3+aBedhLWIE8vgnf5IcVwP8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=daMElx/PKpI8YTRhsyTr/jvScSii2tQ8GF91s6fySyRKJByq3Sn1D3JifvWoEAnUc
	 O6ZNJXb4+Uw5Elp2kTusqHZ8TUVLINsY+9gcsm2BJKe+v1YJcefZUi/5QswfYO6DBt
	 Zs6Ef3eeqIUPqrh6XyrL3qdh4cTeuI/++VXMVBmGSTSKe8k41SCaFe0SodvjuK0bY1
	 cl8o75Oy6PofpDtta2YbciQXQuWhnHH3T6RJKgmKcbuh4PyY9jzJyvh804+olgVnxV
	 aT78kPZ4I+aLhkd0y+3L4pUi/A0/RLX8XXnAnVQv4XOqjs68C3mRw4LFxXW9tmdv9s
	 HAv1KoW3N6qug==
Date: Fri, 2 Feb 2024 14:45:36 -0600
From: Rob Herring <robh@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Frank Rowand <frowand.list@gmail.com>,
	Robert Marko <robert.marko@sartura.hr>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [net-next PATCH v5 6/9] dt-bindings: net: Document Qcom QCA807x
 PHY package
Message-ID: <20240202204536.GB1075521-robh@kernel.org>
References: <20240201151747.7524-1-ansuelsmth@gmail.com>
 <20240201151747.7524-7-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201151747.7524-7-ansuelsmth@gmail.com>

On Thu, Feb 01, 2024 at 04:17:32PM +0100, Christian Marangi wrote:
> Document Qcom QCA807x PHY package.
> 
> Qualcomm QCA807X Ethernet PHY is PHY package of 2 or 5
> IEEE 802.3 clause 22 compliant 10BASE-Te, 100BASE-TX and
> 1000BASE-T PHY-s.
> 
> Document the required property to make the PHY package correctly
> configure and work.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  .../devicetree/bindings/net/qcom,qca807x.yaml | 142 ++++++++++++++++++
>  1 file changed, 142 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/qcom,qca807x.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/qcom,qca807x.yaml b/Documentation/devicetree/bindings/net/qcom,qca807x.yaml
> new file mode 100644
> index 000000000000..1c3692897b02
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/qcom,qca807x.yaml
> @@ -0,0 +1,142 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/qcom,qca807x.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm QCA807X Ethernet PHY
> +
> +maintainers:
> +  - Christian Marangi <ansuelsmth@gmail.com>
> +  - Robert Marko <robert.marko@sartura.hr>
> +
> +description: |
> +  Qualcomm QCA807X Ethernet PHY is PHY package of 2 or 5
> +  IEEE 802.3 clause 22 compliant 10BASE-Te, 100BASE-TX and
> +  1000BASE-T PHY-s.
> +
> +  They feature 2 SerDes, one for PSGMII or QSGMII connection with
> +  MAC, while second one is SGMII for connection to MAC or fiber.
> +
> +  Both models have a combo port that supports 1000BASE-X and
> +  100BASE-FX fiber.
> +
> +  Each PHY inside of QCA807x series has 4 digitally controlled
> +  output only pins that natively drive LED-s for up to 2 attached
> +  LEDs. Some vendor also use these 4 output for GPIO usage without
> +  attaching LEDs.
> +
> +  Note that output pins can be set to drive LEDs OR GPIO, mixed
> +  definition are not accepted.
> +
> +  PHY package can be configured in 3 mode following this table:
> +
> +                First Serdes mode       Second Serdes mode
> +  Option 1      PSGMII for copper       Disabled
> +                ports 0-4
> +  Option 2      PSGMII for copper       1000BASE-X / 100BASE-FX
> +                ports 0-4
> +  Option 3      QSGMII for copper       SGMII for
> +                ports 0-3               copper port 4
> +
> +$ref: ethernet-phy-package.yaml#
> +
> +properties:
> +  compatible:
> +    const: qcom,qca807x-package
> +
> +  qcom,package-mode:
> +    enum:
> +      - qsgmii
> +      - psgmii
> +
> +  qcom,tx-driver-strength:
> +    description: set the TX Amplifier value in mv.
> +      If not defined, 600mw is set by default.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [140, 160, 180, 200, 220,
> +           240, 260, 280, 300, 320,
> +           400, 500, 600]
> +
> +patternProperties:
> +  ^ethernet-phy(@[a-f0-9]+)?$:

I don't get how an address is optional.

Rob

