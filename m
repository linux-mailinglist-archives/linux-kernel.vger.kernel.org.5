Return-Path: <linux-kernel+bounces-165463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8709E8B8CDD
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 17:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 284F51F2647A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 15:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3874D130E55;
	Wed,  1 May 2024 15:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="0PDDoPG+"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C85130E5F;
	Wed,  1 May 2024 15:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714576769; cv=none; b=AiCUEwlDycHs5eYzBHnCs7ck6xkd2rPyWbivo62kSTavY+ZWOR8MTOf01/o9vDr78N/YiTPlaenQ3Vg2TjsbhUbdWplMCPp+VI7pROyel2E1fd97I9pqw/KmreNJA8WF1ZsUgRRSeQ8fCKsw0lHubAkaXP8V5EPakDx96l5acDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714576769; c=relaxed/simple;
	bh=ggyVYb1MLzPw5zF6olC495Bd7AckoWEWxI6WxWSxnPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=umj8i+sxr1/1yxdD3Y8OojkBAm89HIoM6sHveZUaOT8c8BAZT/cBrwgVO46vw8NGYQ7116ELejO4StXAYhmS+yYotbhaqAP6V1UKt4rtRp8TqzwCvKj7iYb+gv7SyBnSKc/kL4AW4/2qMDaS4T0bGrgFcrNzhjJj/mfyhHafgDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=0PDDoPG+; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=4KHxXFoHle5at+71GK2r6HDmZ6AFCTn9sko874lB3ng=; b=0PDDoPG+KYGb5n4URwBe/5vlVm
	UQ75rBGLxmblkbP/8XvPMaOl2RP/4bl3rtqNtLvzevCwX3t9n2/BdrJe1V+scA2mc/ZTnZ6JidhQ1
	7vPRuGWrPYQikQlvlkWQp359rJkjdzMv+u/LsCtf/ApYbThESMz51eNyy/EzgN++lIudvsP4vbdGV
	++o9omgFD6q2HyiFcWFQv8AeZpxI8BGccDP33gifyniQgZWGwyQ6+ngPkeGFkJKFqMpVEtdxy5cc/
	cS/C9UvcXbfJgkMPoskn9IUR0SGPaMLIYjRSKcRJl4EFc1iVrZSghJVksFxEpsbnIs9dTyqt8hlZ4
	Cj+48V7w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:40010)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1s2Bjq-0006Kn-28;
	Wed, 01 May 2024 16:19:18 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1s2Bjo-0002oQ-Gm; Wed, 01 May 2024 16:19:16 +0100
Date: Wed, 1 May 2024 16:19:16 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Halaney <ahalaney@redhat.com>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
	alexandre.torgue@foss.st.com, joabreu@synopsys.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, mcoquelin.stm32@gmail.com, hkallweit1@gmail.com
Subject: Re: racing ndo_open()/phylink*connect() with phy_probe()
Message-ID: <ZjJddIUpXQqH/IA+@shell.armlinux.org.uk>
References: <uz66kbjbxieof6vkliuwgpzhlrbcmeb2f5aeuourw2vqcoc4hv@2adpvba3zszx>
 <229b5a82-1086-40be-8ee5-16b7f3a03b30@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <229b5a82-1086-40be-8ee5-16b7f3a03b30@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, May 01, 2024 at 05:07:44PM +0200, Andrew Lunn wrote:
> On Tue, Apr 30, 2024 at 04:02:19PM -0500, Andrew Halaney wrote:
> > Hi,
> > 
> > I've been taking a look at the following error message:
> > 
> >     qcom-ethqos 23000000.ethernet end1: __stmmac_open: Cannot attach to PHY (error: -19)
> > 
> > end1 is using a phy on the mdio bus of end0, not on its own bus. Something
> > like this devicetree snippet highlights the relationship:
> > 
> >     // end0
> >     &ethernet0 {
> >             phy-mode = "sgmii";
> >             phy-handle = <&sgmii_phy0>;
> > 
> >             mdio {
> >                     compatible = "snps,dwmac-mdio";
> >                     sgmii_phy0: phy@8 {
> >                             compatible = "ethernet-phy-id0141.0dd4";
> >                             reg = <0x8>;
> >                             device_type = "ethernet-phy";
> >                     };
> > 
> >                     sgmii_phy1: phy@a {
> >                             compatible = "ethernet-phy-id0141.0dd4";
> >                             reg = <0xa>;
> >                             device_type = "ethernet-phy";
> >                     };
> >             };
> >     };
> > 
> >     // end1
> >     &ethernet1 {
> >             phy-mode = "sgmii";
> >             phy-handle = <&sgmii_phy1>;
> >     };
> 
> I agree with Russell here. You need to determine where the ENODEV
> comes from.
> 
> It seems unlikely, but one possibility is:
> 
> static int stmmac_xgmac2_mdio_read_c22(struct mii_bus *bus, int phyaddr,
>                                        int phyreg)
> {
>         struct net_device *ndev = bus->priv;
>         struct stmmac_priv *priv;
>         u32 addr;
> 
>         priv = netdev_priv(ndev);
> 
>         /* Until ver 2.20 XGMAC does not support C22 addr >= 4 */
>         if (priv->synopsys_id < DWXGMAC_CORE_2_20 &&
>             phyaddr > MII_XGMAC_MAX_C22ADDR)
>                 return -ENODEV;
> 
> Maybe if the interface is down, priv->synopsys_id has not been set
> yet? Your devices are at address 8 and 10, so if priv->synopsys_id
> where 0, this would give you the ENODEV.

Yes, I did look at that, but didn't read the DT snippet to realise
that the addresses would be trapped by that. So, looking at where
priv->synopsys_id is set... is in stmmac_hwif_init(), which is
called from stmmac_hw_init(), which in turn is called from
stmmac_dvr_probe(). This is the only path that leads here.

This all happens before the MDIO bus is registered, so the value of
priv->synopsys_id should be set by the time the MDIO bus is registered.

So I'm unconvinced... but I think Andrew Halaney needs to delve
deeper into debugging what is going on when the failure occurs.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

