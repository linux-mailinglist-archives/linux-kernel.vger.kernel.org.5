Return-Path: <linux-kernel+bounces-50557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 690D6847AC6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 21:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BEA71F26180
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 20:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381D97E0F0;
	Fri,  2 Feb 2024 20:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hcrOBerv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A19EE56D;
	Fri,  2 Feb 2024 20:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706907182; cv=none; b=IS6JDCGyE7qOSRXMtQ7N8iESdBrEaJEytmtOcZ2XrS+qMypeMLgw/3CD0X8J1pcDiAW8zUiNIrP13/qtT2HF5+hgLce6GWVhEjXjqSNfDwImVjObL1T6d4lC5nsuKn5orLRBJYE+crhqTTpRxIrBx7yPPHHdNeX4W1Gr2z1tA+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706907182; c=relaxed/simple;
	bh=/yqpP3jaYkYNKAfNhsligWnXBos/FxQhmM7JjELkl4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jX9e9cuNKP1DbFuvJ7Ctivnem/CzKz1GG5Ol9yCJKho0hvf9Bmd36mqi3rW/VP4sdaqWbii+oG1pp+OZd6duDTqXbShFkHtLm9vhFz3B+rJjQWCk4ymEJ8+wFTKuu3vs604BrIeMlxSx8MsXApEsz6YSRTyz1m2OMojr7NNBGic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hcrOBerv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A7B6C43390;
	Fri,  2 Feb 2024 20:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706907181;
	bh=/yqpP3jaYkYNKAfNhsligWnXBos/FxQhmM7JjELkl4Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hcrOBervaP1ngOyNEjJ/MnG0UuT7XMcI8VvPUUHlG5XnBRpHt6kVB32ZxRWwqbE4H
	 AvKPm69MzpJ2qeDuJi+kbG4uACPjX937cPG2k7iZ+gXm+Xdftc+7OShgYTMJdQpWtw
	 woQUfvn92TEs4aCLqXPNhimLIgkracinge3M8QIlKKWQvwBFE+edC3VEv/82Xm0U5u
	 8vfr9vrn8ORMd8y/qA1qAfkz6Uh5uVTx5GHe+sdihtHc5hb37NGuVTEVnhble8IVJq
	 taLb+qFq+nxWTK/Vb3KBZHkwOWmZrDQHG670EfALRGUyO0CXBnf7pkRvS2WhTv7uMB
	 yh/wCMapez8Lg==
Date: Fri, 2 Feb 2024 14:52:59 -0600
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
Subject: Re: [net-next PATCH v5 1/9] dt-bindings: net: document ethernet PHY
 package nodes
Message-ID: <20240202205259.GC1075521-robh@kernel.org>
References: <20240201151747.7524-1-ansuelsmth@gmail.com>
 <20240201151747.7524-2-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201151747.7524-2-ansuelsmth@gmail.com>

On Thu, Feb 01, 2024 at 04:17:27PM +0100, Christian Marangi wrote:
> Document ethernet PHY package nodes used to describe PHY shipped in
> bundle of 2-5 PHY. The special node describe a container of PHY that
> share common properties. This is a generic schema and PHY package
> should create specialized version with the required additional shared
> properties.
> 
> Example are PHY packages that have some regs only in one PHY of the
> package and will affect every other PHY in the package, for example
> related to PHY interface mode calibration or global PHY mode selection.
> 
> The PHY package node MUST declare the base address used by the PHY driver
> for global configuration by calculating the offsets of the global PHY
> based on the base address of the PHY package.
> 
> Each reg of the PHYs defined in the PHY Package node is an offset of the
> PHY Package reg.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  .../bindings/net/ethernet-phy-package.yaml    | 55 +++++++++++++++++++
>  1 file changed, 55 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/ethernet-phy-package.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/ethernet-phy-package.yaml b/Documentation/devicetree/bindings/net/ethernet-phy-package.yaml
> new file mode 100644
> index 000000000000..d7cdbb1a4b3e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/ethernet-phy-package.yaml
> @@ -0,0 +1,55 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/ethernet-phy-package.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Ethernet PHY Package Common Properties
> +
> +maintainers:
> +  - Christian Marangi <ansuelsmth@gmail.com>
> +
> +description:
> +  PHY packages are multi-port Ethernet PHY of the same family
> +  and each Ethernet PHY is affected by the global configuration
> +  of the PHY package.
> +
> +  Each reg of the PHYs defined in the PHY Package node is
> +  an offset of the PHY Package reg.
> +
> +  Each Ethernet PHYs defined in the PHY package node is
> +  reachable in the MDIO bus at the address of the PHY
> +  Package offset of the Ethernet PHY reg.

If the phys are addressed with an MDIO address, then just use those.

> +
> +properties:
> +  $nodename:
> +    pattern: "^ethernet-phy-package(@[a-f0-9]+)?$"

Can't be optional if 'reg' is required (which it should be).

> +
> +  reg:
> +    minimum: 0
> +    maximum: 31
> +    description:
> +      The base ID number for the PHY package.
> +      Commonly the ID of the first PHY in the PHY package.
> +
> +      Some PHY in the PHY package might be not defined but
> +      still occupy ID on the device (just not attached to
> +      anything) hence the PHY package reg might correspond
> +      to a not attached PHY (offset 0).
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
> +patternProperties:
> +  ^ethernet-phy(@[a-f0-9]+)?$:

Same issue here.

> +    $ref: ethernet-phy.yaml#
> +
> +required:
> +  - reg
> +  - '#address-cells'
> +  - '#size-cells'
> +
> +additionalProperties: true
> -- 
> 2.43.0
> 

