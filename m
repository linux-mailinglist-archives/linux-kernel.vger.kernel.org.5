Return-Path: <linux-kernel+bounces-32118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B638356B7
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 17:46:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 055731C21324
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 16:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2443C37712;
	Sun, 21 Jan 2024 16:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="rJIjmPmD"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38637EC4;
	Sun, 21 Jan 2024 16:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705855571; cv=none; b=QD8ZHewLVLD6i6NFTTB5Kdow4w28Be5CVOFydmqgUQnlu4jAyF0gUPseI1H5sDB0Jm7PBb8e26QgEnnuTvdypiKKHw+dFpbsS0BhFJzBVN4Zu9AZFmPG1/O4zYkJ3nfpRvn3Y1q3NrYA8h0wGA1y3uET4kurv0QV23ENOC+3bBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705855571; c=relaxed/simple;
	bh=SXpGnpIGQfJuOVAZ0umiygpDbMYgAaWjCZV42ZZzXjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GQUOoz+D2yaVkKYCzFh1217OsDGJJdL/V+JFXkdeB9tvrh1E1bDSNahMFrz7tG0+GYMe4QRkCqA3kRCs5T5CizG01vMkcf/6cqJg8kMwLaAEJvoozANkBJfpZepwBuEGnDRdxd9CqySIr2lsM11XyBAxWBqnFcB8boTtCowWq24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=rJIjmPmD; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=BHOFZcuTxHKtAFe+5SXsdTjosX9ZtBXP8Ft5m35WZew=; b=rJIjmPmDd+Ls+Hr9hu4nE6G5vU
	P+4nn6S6zoEq1QaRKrNmnKbBQXlQey7L64fNlXwpar8zVrsIuvXfct4SNX8HYYHQAgtCRlWpTb3TX
	Xz83hyOOws5wjAE37qqzF+/NYHSoLWQkvgf181YS+chDM4AVLVSjvgD9j5zGdoDcluZw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rRaxL-005f5v-RN; Sun, 21 Jan 2024 17:45:59 +0100
Date: Sun, 21 Jan 2024 17:45:59 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Ziyang Huang <hzyitc@outlook.com>
Cc: mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	richardcochran@gmail.com, p.zabel@pengutronix.de,
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 7/8] arm64: dts: qcom: ipq5018: enable ethernet support
Message-ID: <b8510b38-3669-4a04-9ca6-dbe937ecbec3@lunn.ch>
References: <TYZPR01MB55563BD6A2B78402E4BB44D4C9762@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
 <TYZPR01MB5556FA040B07F48AFE544680C9762@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYZPR01MB5556FA040B07F48AFE544680C9762@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>

On Sun, Jan 21, 2024 at 08:42:36PM +0800, Ziyang Huang wrote:
> Signed-off-by: Ziyang Huang <hzyitc@outlook.com>
> ---
>  arch/arm64/boot/dts/qcom/ipq5018.dtsi | 120 +++++++++++++++++++++++++-
>  1 file changed, 116 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/ipq5018.dtsi b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
> index e502a3ecf4b7..b36e5c2136b7 100644
> --- a/arch/arm64/boot/dts/qcom/ipq5018.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
> @@ -94,6 +94,63 @@ soc: soc@0 {
>  		#size-cells = <1>;
>  		ranges = <0 0 0 0xffffffff>;
>  
> +		mdio0: mdio@88000 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			compatible = "qcom,ipq5018-mdio", "qcom,qca-mdio";
> +			reg = <0x88000 0x64>;
> +			resets = <&gcc GCC_GEPHY_MDC_SW_ARES>,
> +				 <&gcc GCC_GEPHY_DSP_HW_ARES>;

What do these two resets do? An MDIO bus controller is unlikely to
have a DSP in it. That is something a PHY is more likely to have. An
MDIO bus controller does have an MDC line, but why is it
GCC_GEPHY_MDC_SW_ARES not GCC_MDIO_MDC_SW_ARES? So this again makes me
think this is a PHY reset, so should be in the PHY node.

A device tree binding will help sort this out.


    Andrew

---
pw-bot: cr

