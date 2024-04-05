Return-Path: <linux-kernel+bounces-133322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79EBB89A22F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 18:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C5F21F23C8D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F23C171082;
	Fri,  5 Apr 2024 16:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="0CNFw485"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3456116FF30;
	Fri,  5 Apr 2024 16:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712333589; cv=none; b=Cx5IyH43UOKv33imrRLuoGYc7t177GHpSQh+Ei6UFoDt2H9XhF1vNzq5PZsV3KjyUHEAVuR/OOcdtXLZb+BwYBadGBRTLjbVf3emRlQ+QS7iZrUArhReftyefVrIMtPs7EQWvtoKxLflLHN012BdQtqdWNObAgj8Kt/vUUA+xvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712333589; c=relaxed/simple;
	bh=iV4f770X9Ruw9+ADTeKTqxKbkKdRFybmaXsxULWIGDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oIzvuYbSeI214QGxYpgZ4V+5J1RXO/iVEdE7B17HuQGmCBW3RulaIdjgb0x3ht7UuigmOwuqxXOh5iHK8fr5r0DbHvXUZxmuLKP7NFyI28Rd2p7iAexoELrOJeSmNK6aGDXbylp8OxoL3f3Ix1U9Zx/aE5hcD9+K0sCUdWuxAzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=0CNFw485; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ociFhFa0cP7BJBgogyzRy65MXmUjnTulpYz1ZIcD8Qk=; b=0CNFw485XFrXYeKEmy3hSstO6K
	AHEV+xcniM7r9J5PAkHzeCOQH2WD6Pk46Yo6kriGExUqaVr2nxJG8YZOVj62SAEeDLAkKxpvLAOGJ
	OX7dKSZsbKPDXB2cEzBweCRemhHP5yRj4gFEHFlkpUzhyEvm7iVABd1NFVV+BtQRg8yo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rsmBX-00CJs8-BP; Fri, 05 Apr 2024 18:12:59 +0200
Date: Fri, 5 Apr 2024 18:12:59 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	David Jander <david@protonic.nl>
Subject: Re: [PATCH v2 2/2] arm64: dts: rockchip: add Protonic MECSBC
 device-tree
Message-ID: <a94e76b0-a1dc-4800-b0bb-c621b1364b0b@lunn.ch>
References: <20240405-protonic-mecsbc-v2-0-0a6fedc78b9f@pengutronix.de>
 <20240405-protonic-mecsbc-v2-2-0a6fedc78b9f@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405-protonic-mecsbc-v2-2-0a6fedc78b9f@pengutronix.de>

> +&gmac1 {
> +	assigned-clocks = <&cru SCLK_GMAC1_RX_TX>, <&cru SCLK_GMAC1>;
> +	assigned-clock-parents = <&cru SCLK_GMAC1_RGMII_SPEED>, <&cru CLK_MAC1_2TOP>;
> +	phy-handle = <&rgmii_phy1>;
> +	phy-mode = "rgmii-id";
> +	clock_in_out = "output";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&gmac1m1_miim
> +		     &gmac1m1_tx_bus2
> +		     &gmac1m1_rx_bus2
> +		     &gmac1m1_rgmii_clk
> +		     &gmac1m1_clkinout
> +		     &gmac1m1_rgmii_bus>;
> +	status = "okay";
> +};

Thank for changing it.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

