Return-Path: <linux-kernel+bounces-50603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46784847B7A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 22:24:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A4A51C23948
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 21:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B066839E1;
	Fri,  2 Feb 2024 21:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="teO9xkwH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478C081723;
	Fri,  2 Feb 2024 21:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706909063; cv=none; b=Xl/H97OixZJI+XjGBdIDj/1rYQNf4KvKLOZY0BZoAvcXfOalCbqb6Jd9kUQhSAbvfSofpJOFQ5sy/+0p0//zGgXADcSUrlqTBtejHCP7tqzXGAFmQ+66oTfVfM9Kp8UY3c+DkTSU4NUd05dL6fejfqnt7JVxfs88mJv7czkjJxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706909063; c=relaxed/simple;
	bh=UZ+yJRgsFPGKwSTDFBg0r03EZWgLZlspYa2WkFy5MiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=goq9bPtHpSphbJUcmyaffnWXk3ljf+3AEMMY5yS/NFlZTLq3rgkR1gY8IF6P8tmM/qKrM8b7ByynHMQxfWyBvUiHA6zcK/U3634HngYj1x3DEakuaNTWAImWW1HHLeIjYd7JiV4V5klkCJvv/oH3qFghWHC/QD9NAdRRkPG+UHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=teO9xkwH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72D71C433C7;
	Fri,  2 Feb 2024 21:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706909062;
	bh=UZ+yJRgsFPGKwSTDFBg0r03EZWgLZlspYa2WkFy5MiA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=teO9xkwHltv0T0lPtU2+7uxbSRQZXu6/REzvx0bSQvNw23ajHvQTtRrzcbKgqgcto
	 Qz5I/ZL8Yae+1FbTMmiWOORN+yWt+6zMVotV2Omv2qFLh02dsTev+gZjT+02Xoj1Pa
	 55RKD0O1gA/FcygEaO3shOHwz1wmfjact06vT2h7azz/dnW0UEq87+/ijVeqPz8sWU
	 J1hcDtKIs0hN1bamIt4it/ivIsZN6b5KRfDv4eSuL89IMxiDOg45sxDHcZP8OyQG7M
	 VB6q6WyV8NOavbjqr1LVh4oqfoz3W5hMd8t5KwIAtsdrnAhkvrW5+H4RC+e+uSeed+
	 jX/JQcBYko2Xg==
Date: Fri, 2 Feb 2024 15:24:20 -0600
From: Rob Herring <robh@kernel.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Bc-bocun Chen <bc-bocun.chen@mediatek.com>,
	Steven Liu <steven.liu@mediatek.com>,
	John Crispin <john@phrozen.org>,
	Chunfeng Yun <chunfeng.yun@mediatek.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Qingfang Deng <dqfext@gmail.com>,
	SkyLake Huang <SkyLake.Huang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: phy: mediatek,xfi-tphy: add new bindings
Message-ID: <20240202212420.GA1561174-robh@kernel.org>
References: <702afb0c1246d95c90b22e57105304028bdd3083.1706823233.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <702afb0c1246d95c90b22e57105304028bdd3083.1706823233.git.daniel@makrotopia.org>

On Thu, Feb 01, 2024 at 09:52:20PM +0000, Daniel Golle wrote:
> Add bindings for the MediaTek XFI T-PHY Ethernet SerDes PHY found in the
> MediaTek MT7988 SoC which can operate at various interfaces modes:

This is v4 unless I'm confused[1]. Where's the revision history?

Rob

[1] https://lore.kernel.org/all/b875f693f6d4367a610a12ef324584f3bf3a1c1c.1702352117.git.daniel@makrotopia.org/

> 
> via USXGMII PCS:
>  * USXGMII
>  * 10GBase-R
>  * 5GBase-R
> 
> via LynxI SGMII PCS:
>  * 2500Base-X
>  * 1000Base-X
>  * Cisco SGMII (MAC side)
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>  .../bindings/phy/mediatek,xfi-tphy.yaml       | 80 +++++++++++++++++++
>  1 file changed, 80 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/mediatek,xfi-tphy.yaml
> 
> diff --git a/Documentation/devicetree/bindings/phy/mediatek,xfi-tphy.yaml b/Documentation/devicetree/bindings/phy/mediatek,xfi-tphy.yaml
> new file mode 100644
> index 0000000000000..e897118dcf7e6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/mediatek,xfi-tphy.yaml
> @@ -0,0 +1,80 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/mediatek,xfi-tphy.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek XFI T-PHY
> +
> +maintainers:
> +  - Daniel Golle <daniel@makrotopia.org>
> +
> +description:
> +  The MediaTek XFI SerDes T-PHY provides the physical SerDes lanes
> +  used by the (10G/5G) USXGMII PCS and (1G/2.5G) LynxI PCS found in
> +  MediaTek's 10G-capabale SoCs.
> +
> +properties:
> +  $nodename:
> +    pattern: "^phy@[0-9a-f]+$"
> +
> +  compatible:
> +    const: mediatek,mt7988-xfi-tphy
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: XFI PHY clock
> +      - description: XFI register clock
> +
> +  clock-names:
> +    items:
> +      - const: xfipll
> +      - const: topxtal
> +
> +  resets:
> +    items:
> +      - description: PEXTP reset

What is PEXTP?

