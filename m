Return-Path: <linux-kernel+bounces-119103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C13188C434
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:58:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5FA21F631F6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 13:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91EF37602D;
	Tue, 26 Mar 2024 13:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="TfAnJHGU"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C6E125C9;
	Tue, 26 Mar 2024 13:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711461498; cv=none; b=Gw07PqYOqx7crn9tsWT6l+MMtBjCKQ3PDCLE9PVD88/ZsG96BGmeFGLsHCWBH0Z7C2KanbWZiRnNDg1yaZjfHfkkAhYdC5ClS3HeeAM0c5EM7NV9FYbOmU8zsybNQEx/E/AmyeoQR70bBxK3DU2Mhaa7DLy+4kgR3H/Zo7NgLQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711461498; c=relaxed/simple;
	bh=UkX75V9l2kKeZPRM2sj6rUQZY2m0OPjpnlnv9BQJ7zM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q3Pt8hp1CxKwdcnBlBLTbEUWdOtxAX7MsIV16yx4zTkWfXhLQIYGgB5uCwvxwKLm+bqmMtNbg1RalAh6enLrJd/duzPD3OwSJ1A9b48eAC+MWkMbWPcHQSa/lH8WsYpak4SoFzN/ZgYmfoMo8f/8FX80JKh+MsjLPzH5VFJ0kNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=TfAnJHGU; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=vNnrYFubP6muTfOE3nnaUwzi5pQkV31BF/tVPuyXjRs=; b=TfAnJHGU62uIy+XDLC9mejbExn
	EyKUGfPCjZbxdkxhdmwkZHLJWY8syH7wZdLL0KzAmlsqj0lh3RPaRm4fmWJmjFrDIzT2Cc4vvJeDQ
	KLyQ7UFGJojCR5tYNwV/RZG4lPqL+vGXbCnppM77jN9sAqp4A6NiDvLPjzpF5iqw9wlU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rp7JT-00BHZx-Kb; Tue, 26 Mar 2024 14:58:03 +0100
Date: Tue, 26 Mar 2024 14:58:03 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Christophe Roullier <christophe.roullier@foss.st.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Marek Vasut <marex@denx.de>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: net: add phy-supply property for
 stm32
Message-ID: <0e14ad5d-3c25-40ab-981a-fbc4e245fc94@lunn.ch>
References: <20240326125849.226765-1-christophe.roullier@foss.st.com>
 <20240326125849.226765-2-christophe.roullier@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326125849.226765-2-christophe.roullier@foss.st.com>

On Tue, Mar 26, 2024 at 01:58:48PM +0100, Christophe Roullier wrote:
> Phandle to a regulator that provides power to the PHY. This
> regulator will be managed during the PHY power on/off sequence.
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>
> ---
>  Documentation/devicetree/bindings/net/stm32-dwmac.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/stm32-dwmac.yaml b/Documentation/devicetree/bindings/net/stm32-dwmac.yaml
> index fc8c96b08d7dc..80937b28fa046 100644
> --- a/Documentation/devicetree/bindings/net/stm32-dwmac.yaml
> +++ b/Documentation/devicetree/bindings/net/stm32-dwmac.yaml
> @@ -82,6 +82,9 @@ properties:
>        Should be phandle/offset pair. The phandle to the syscon node which
>        encompases the glue register, and the offset of the control register
>  
> +  phy-supply:
> +    description: PHY regulator

~/linux/drivers/net/ethernet/stmicro/stmmac$ grep regulator_get *
dwmac-rk.c:	bsp_priv->regulator = devm_regulator_get(dev, "phy");
dwmac-sun8i.c:	gmac->regulator = devm_regulator_get_optional(dev, "phy");
dwmac-sunxi.c:	gmac->regulator = devm_regulator_get_optional(dev, "phy");

Maybe i'm missing something, but i don't see an actual implementation
of this binding?

	Andrew

