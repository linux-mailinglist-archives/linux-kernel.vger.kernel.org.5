Return-Path: <linux-kernel+bounces-158718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 557BA8B2422
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 16:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 789CC1C22C7E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 14:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D36914A4F0;
	Thu, 25 Apr 2024 14:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="jLH72VqO"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF8512C47C;
	Thu, 25 Apr 2024 14:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714055477; cv=none; b=pdf8aTD0efttSyTBc30F73nn4Zw18SvI57KvQ5mx5rnkZhklwlzWAKItLBQuDpGqQy1hsD15lBELRmuPd1vO7Du0R9rEW94+1ZVVYvR1DojdGnKPoNPw/FB3oOON+BV2TCYyUhFlLZjhtarxkqIJQtDKZzR1xHKQp2jDDCvYQwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714055477; c=relaxed/simple;
	bh=XNDONZ50zkNw24VHGSrLtBVRo25TyhBYrvxwY6adhPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=huMQSaWQt86n6eHp4G82uX/osamrxeoz8+ZwFLomUFexmCK/TOBa7t8kmNUcUI2aCMmFsDHWU4Y/EXYN2oAGPKgoXfxXlpCN5h4XkF2JiVXsLD3mMsE9Y9COR9SOWLMAn5AnBX8m7BNTF1VU3WrKRlGco5Ur/8ZlqcAWy82wIVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=jLH72VqO; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=bhEOlHPHwzer5w9ZMmE08QQPlZ3NpIRrXVu+LpBumv4=; b=jLH72VqOH3gpURD01C2ne9BQzQ
	vEWyeN+NPnbnu9rYbatMXdAw8ipHOyXtQ3jDk8Fp5vCppyACBIitFV4SsNvQzO/6LjE82J4cBIc7O
	tesZD3ULKMHXIlVheHZuB96S3iZ0xubXxt6mkZyCDQfmTe2Bv93Smty/RhFLom3JekduJ7WUuFPow
	jvowSjItxO6DtyotKyAm7HLiJFUJxxRG3HIuXFMYJe3cKLysaTNsjoFg51oRC7Q+GOrRzrcZJl0ST
	NJ+QAABshwCgu8JVyQeD5/JW9Heij6jENzc/kvGkLq/spz3WUvmpcOUGLjEzyfJFUPUnubWPOISqb
	8vN+3Npw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44198)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1s007j-0007WW-1L;
	Thu, 25 Apr 2024 15:30:55 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1s007g-0005ea-OW; Thu, 25 Apr 2024 15:30:52 +0100
Date: Thu, 25 Apr 2024 15:30:52 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Stefan Eichenberger <eichest@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	lxu@maxlinear.com, hkallweit1@gmail.com, michael@walle.cc,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] net: phy: mxl-gpy: add new device tree property
 to disable SGMII autoneg
Message-ID: <ZippHJrnvzXsTiK4@shell.armlinux.org.uk>
References: <5ed39628-4ac0-4c4e-9a16-fd4bf9a6db29@lunn.ch>
 <Zh6mIv1Ee+1h21Xo@shell.armlinux.org.uk>
 <Zh6z90iCpLqF4fla@eichest-laptop>
 <Zh6/oVHUvnOVtHaC@shell.armlinux.org.uk>
 <Zh94yqo2EHRq8eEq@eichest-laptop>
 <ZiE156+BPpx/ciL6@shell.armlinux.org.uk>
 <Zikd+GxuwMRC+5Ae@shell.armlinux.org.uk>
 <Zikrv5UOWvSGjgcv@eichest-laptop>
 <ZilLz8f6vQQCg4NB@shell.armlinux.org.uk>
 <Zio9g9+wsFX39Vkx@eichest-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zio9g9+wsFX39Vkx@eichest-laptop>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Apr 25, 2024 at 01:24:51PM +0200, Stefan Eichenberger wrote:
> On Wed, Apr 24, 2024 at 07:13:35PM +0100, Russell King (Oracle) wrote:
> > On Wed, Apr 24, 2024 at 05:56:47PM +0200, Stefan Eichenberger wrote:
> > > On Wed, Apr 24, 2024 at 03:58:00PM +0100, Russell King (Oracle) wrote:
> > > > On Thu, Apr 18, 2024 at 04:01:59PM +0100, Russell King (Oracle) wrote:
> > > > > On Wed, Apr 17, 2024 at 09:22:50AM +0200, Stefan Eichenberger wrote:
> > > > > > I also checked the datasheet and you are right about the 1000base-X mode
> > > > > > and in-band AN. What worked for us so far was to use SGMII mode even for
> > > > > > 2.5Gbps and disable in-band AN (which is possible for SGMII). I think
> > > > > > this works because as you wrote, the genphy just multiplies the clock by
> > > > > > 2.5 and doesn't care if it's 1000base-X or SGMII. With your patches we
> > > > > > might even be able to use in-band autonegoation for 10,100 and 1000Mbps
> > > > > > and then just disable it for 2.5Gbps. I need to test it, but I have hope
> > > > > > that this should work.
> > > > > 
> > > > > There is another way we could address this. If the querying support
> > > > > had a means to identify that the endpoint supports bypass mode, we
> > > > > could then have phylink identify that, and arrange to program the
> > > > > mvpp2 end to be in 1000base-X + x2.5 clock + AN bypass, which would
> > > > > mean it wouldn't require the inband 16-bit word to be present.
> > > > > 
> > > > > I haven't fully thought it through yet - for example, I haven't
> > > > > considered how we should indicate to the PCS that AN bypass mode
> > > > > should be enabled or disabled via the pcs_config() method.
> > > > 
> > > > Okay, I've been trying to put more effort into this, but it's been slow
> > > > progress (sorry).
> > > > 
> > > > My thoughts from a design point of view were that we could just switch
> > > > to PHYLINK_PCS_NEG_OUTBAND instead of PHYLINK_PCS_NEG_INBAND_* and
> > > > everything at the PCS layer should be able to cope, but this is not the
> > > > case, especially with mvneta/mvpp2.
> > > > 
> > > > The problem is that mvneta/mvpp2 (and probably more) expect that
> > > > 
> > > > 1) MLO_AN_INBAND means that the PCS will be using inband, and that
> > > >    means the link up/down state won't be forced. This basically implies
> > > >    that only PHYLINK_PCS_NEG_INBAND_* can be used can be used for the
> > > >    PCS.
> > > > 
> > > > 2) !MLO_AN_INBAND means that an out-of-band mechanism will be used and
> > > >    that means that the link needs to be forced (since there's no way
> > > >    for the hardware to know whether the link should be up or down.)
> > > >    It's therefore expected that only PHYLINK_PCS_NEG_OUTBAND will be
> > > >    used for the PCS.
> > > > 
> > > > So, attempting to put a resolution of the PHY and PCS abilities into
> > > > phylink_pcs_neg_mode() and select the appropriate PHYLINK_PCS_NEG_*
> > > > mode alone just doesn't work. Yet... we need to do that in there when
> > > > considering whether inband can be enabled or not for non-PHY links.
> > > > 
> > > > Basically, it needs a re-think how to solve this...
> > > 
> > > Today I was playing around with my combination of mxl-gpy and mvpp2 and
> > > I got it working again with your patches applied. However, I hacked the
> > > phylink driver to only rely on what the phy and pcs support. I know this
> > > is not a proper solution, but it allowed me to verify the other changes.
> > > My idea was if the phy and pcs support inband then use it, otherwise use
> > > outband and ignore the rest.
> > > 
> > > Here is how my minimal phylink_pcs_neg_mode test function looks like:
> > > 
> > > static unsigned int phylink_pcs_neg_mode(struct phylink *pl,
> > > 					 struct phylink_pcs *pcs,
> > > 					 unsigned int mode,
> > > 					 phy_interface_t interface,
> > > 					 const unsigned long *advertising)
> > > {
> > > 	unsigned int phy_link_mode = 0;
> > > 	unsigned int pcs_link_mode;
> > > 
> > > 	pcs_link_mode = phylink_pcs_query_inband(pcs, interface);
> > > 	if (pl->phydev)
> > > 		phy_link_mode = phy_query_inband(pl->phydev, interface);
> > > 
> > > 	/* If the PCS or PHY can not provide inband, then use
> > > 	 * outband.
> > > 	 */
> > > 	if (!(pcs_link_mode & LINK_INBAND_VALID) ||
> > > 	    !(phy_link_mode & LINK_INBAND_VALID))
> > > 		return PHYLINK_PCS_NEG_OUTBAND;
> > > 
> > > 	return PHYLINK_PCS_NEG_INBAND_ENABLED;
> > > }
> > 
> > Note that I've changed the flags that get reported to be disable (bit 0)/
> > enable (bit 1) rather than valid/possible/required because the former
> > makes the resolution easier.
> > 
> > The problem is that merely returning outband doesn't cause mvneta/mvpp2
> > to force the link up. So for example, here's a SFP module which doesn't
> > support any inband for 2500base-X nor SGMII:
> > 
> > mvneta f1034000.ethernet eno2: copper SFP: interfaces=[mac=4,9-12,19,22-23, sfp=
> > 4,23,27]
> > mvneta f1034000.ethernet eno2: copper SFP: chosen 2500base-x interface
> > mvneta f1034000.ethernet eno2: PHY i2c:sfp:16 uses interfaces 4,23,27, validatin
> > g 4,23
> > mvneta f1034000.ethernet eno2:  interface 4 (sgmii) rate match none supports 2-3
> > ,5-6,13
> > mvneta f1034000.ethernet eno2:  interface 23 (2500base-x) rate match none suppor
> > ts 6,13,47
> > mvneta f1034000.ethernet eno2: PHY [i2c:sfp:16] driver [Broadcom BCM84881] (irq=
> > POLL)
> > mvneta f1034000.ethernet eno2: phy: 2500base-x setting supported 00,00000000,000
> > 08000,0000206c advertising 00,00000000,00008000,0000206c
> > mvneta f1034000.ethernet eno2: copper SFP: PHY link in-band modes 0x1
> > mvneta f1034000.ethernet eno2: major config 2500base-x
> > mvneta f1034000.ethernet eno2: link modes: pcs=02 phy=01
> > mvneta f1034000.ethernet eno2: phylink_mac_config: mode=inband/2500base-x/none a
> > dv=00,00000000,00008000,0000206c pause=04
> > mvneta f1034000.ethernet eno2: phylink_sfp_module_start()
> > mvneta f1034000.ethernet eno2: phylink_sfp_link_up()
> > mvneta f1034000.ethernet eno2: phy link down 2500base-x/Unknown/Unknown/none/off
> > mvneta f1034000.ethernet eno2: phy link up sgmii/1Gbps/Full/none/off
> > mvneta f1034000.ethernet eno2: major config sgmii
> > mvneta f1034000.ethernet eno2: link modes: pcs=03 phy=01
> > mvneta f1034000.ethernet eno2: phylink_mac_config: mode=inband/sgmii/none adv=00,00000000,00008000,0000206c pause=00
> > mvneta f1034000.ethernet eno2: pcs link down
> > mvneta f1034000.ethernet eno2: pcs link down
> > mvneta f1034000.ethernet eno2: can LPI, EEE enabled, active
> > mvneta f1034000.ethernet eno2: enabling tx_lpi, timer 250us
> > mvneta f1034000.ethernet eno2: Link is Up - 1Gbps/Full - flow control off
> > 
> > This looks like the link is up, but it isn't - note "pcs link down".
> > If we look at the value of the GMAC AN status register:
> > 
> > Value at address 0xf1036c10: 0x0000600a
> > 
> > which indicates that the link is down, so no packets will pass.
> 
> What I changed in mvpp2 is to allow turing off inband in 2500base-x. The
> mvpp2 driver can handle this use case in pcs_config, it will turn off AN
> and force the link up.

pcs_config can't force the link up.

> I think it should also work for mvneta, at least
> the code looks almost the same. I get the following for the Port
> Auto-Negotiation Configuration Register:
> 
> For 1Gbit/s it switches to SGMII and enables inband AN:
> Memory mapped at address 0xffffa0112000.
> Value at address 0xF2132E0C (0xffffa0112e0c): 0xB0C6

So here the link is forced up which is wrong for inband, because then
we have no way to detect the link going down.

> For 2.5Gbit/s it disables inband AN and forces the link to be up:
> Memory mapped at address 0xffffaff88000.
> Value at address 0xF2132E0C (0xffffaff88e0c): 0x9042
> 
> Then the status register shows also link up for 2.5Gbit/s:
> Memory mapped at address 0xffffa5fe2000.
> Value at address 0xF2132E10 (0xffffa5fe2e10): 0x683B
> 
> What might be confusing is that the port type, bit 1 in MAC Control
> Register0, is set to SGMII for 2.5Gbit/s, because we can only turn off
> autonegotiation for SGMII:
> Memory mapped at address 0xffff8c26c000.
> Value at address 0xF2132E00 (0xffff8c26ce00): 0x8BFD

Control register 0 bit 1 is the port type bit, which controls whether
the port is in "1000base-X" mode or SGMII mode. This has no effect on
the interpretation of the inband control word.

Control register 2 bit 0 controls whether the port uses 802.3z
format control words or SGMII format control words.

> My example patch still uses the old macros:
> 
> diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> index 97e38f61ac65..15fadfd61313 100644
> --- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> +++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> @@ -6223,9 +6223,12 @@ static unsigned int mvpp2_gmac_pcs_query_inband(struct phylink_pcs *pcs,
>  	 * When <PortType> = 1 (1000BASE-X) this field must be set to 1.
>  	 * Therefore, inband is "required".
>  	 */
> -	if (phy_interface_mode_is_8023z(interface))
> +	if (interface == PHY_INTERFACE_MODE_1000BASEX)
>  		return LINK_INBAND_VALID | LINK_INBAND_REQUIRED;
>  
> +	if (interface == PHY_INTERFACE_MODE_2500BASEX)
> +		return LINK_INBAND_VALID | LINK_INBAND_POSSIBLE;

This is not correct though. If we set PortType = 1, then this applies:

  Bit   Field        Type / InitVal   Description

  2     InBandAnEn   RW               In-band Auto-Negotiation enable.
..
                                      When <PortType> = 1 (1000BASE-X)
                                      this field must be set to 1.
                                                                                                                      When <PortType> = 0 (SGMII) and this
                                      field is 1, in-band Flow Control not
				      supported.

So, if we have the port in 1000base-X mode (PortType = 1) then bit 2
of the Autoneg configuration register needs to be set to be compliant
with the documentation. Therefore, since we set PortType = 1 for
2500BASE-X (and note that I _do_ run 2500BASE-X with inband AN enabled
over fibre transceivers here, so this is needed), we also need to
enable InBandAnEn.

This is exactly where the difficulty comes - because what you're
suggesting will break currently working setups such as what I have
here.

Switching the port to SGMII mode for 2500base-X doesn't sound like a
sensible thing to do.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

