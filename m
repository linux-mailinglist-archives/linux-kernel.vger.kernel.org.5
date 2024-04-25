Return-Path: <linux-kernel+bounces-159107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 821C48B298A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 22:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 106031F22AAD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 20:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C707311721;
	Thu, 25 Apr 2024 20:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="nJhedPiH"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E731534FD;
	Thu, 25 Apr 2024 20:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714076177; cv=none; b=Ntf6qYSPvUW6abUgg6JNAsPOVKb4RC9ZUaq+81jthxars3wNxFFaaU1yf64tb4oWrBdV0QzwdTB5N2iA5z3Gk2p9+3gthIizUbx77pJahxUEM2HMSjC+zoV9zvK1E61B4Yv+l1Pqr+ioM4OmJXfeE/mS3ly5i8CJiCDxRZQzMho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714076177; c=relaxed/simple;
	bh=K81+tA4eHurm+LtgiRStXLsxrTRQZz08hGj/EWeB+ik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qyEbScivQMiOCGSHb/zpY+oQOZEWMqAisyIRDnPfanSxa6asfvsofo/8aHKmY7C1rCW7RuAITVcm8mFFFEdcWTpiWFfCl08dGoNA7o1A4cEBsnJFvafrYDNn+zFqIjV3utDLWH+nX4UcugTukUMsjJcdk+EDLoySXI0bIzx2e7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=nJhedPiH; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=elu4sjaKrKGg5mM6SIUrWQhAoZsJ922o9SojYoxFNkg=; b=nJhedPiHAWOTMqyxOiP4bSL9A4
	1Q23PSsMWnLXfe/kNPXGuTmlweS2d0XZdlFaV1Uk8LB44wPBCOm5iLXduHDPVyydcObvtynGVC+Yn
	/nn9PRJ95+UuY8K5xhHuVshJpaJWlfPCxNTxd3U7rHai/3uP43dr569zJTOexEY/NZusenqkbewCZ
	F8F1+Fd068DzXbMf+bZuusDbCherckPQfZe/d2XVGAx3zpQxPBQlpZ+odGphvvxidfEhVhd1S7Tqy
	XUtRbqi2qpfgr1jYuPRmsqbOedacI0FaAR4S8nN4ItkW1FG02f+hYRJTS5a1wC9WG/SLQP/vUglm4
	VxDZT4lQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:54552)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1s05Vc-0007qW-2b;
	Thu, 25 Apr 2024 21:15:56 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1s05Vb-0005sC-1A; Thu, 25 Apr 2024 21:15:55 +0100
Date: Thu, 25 Apr 2024 21:15:54 +0100
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
Message-ID: <Ziq5+gRXGmqt9bXM@shell.armlinux.org.uk>
References: <Zh94yqo2EHRq8eEq@eichest-laptop>
 <ZiE156+BPpx/ciL6@shell.armlinux.org.uk>
 <Zikd+GxuwMRC+5Ae@shell.armlinux.org.uk>
 <Zikrv5UOWvSGjgcv@eichest-laptop>
 <ZilLz8f6vQQCg4NB@shell.armlinux.org.uk>
 <Zio9g9+wsFX39Vkx@eichest-laptop>
 <ZippHJrnvzXsTiK4@shell.armlinux.org.uk>
 <Zip8Hd/ozP3R8ASS@eichest-laptop>
 <ZiqFOko7zFjfTdz4@shell.armlinux.org.uk>
 <ZiqUB0lwgw7vIozG@eichest-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZiqUB0lwgw7vIozG@eichest-laptop>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Apr 25, 2024 at 07:33:59PM +0200, Stefan Eichenberger wrote:
> Now I got it, thanks a lot for the explanation. So the issue is that
> MLO_AN_INBAND + PHYLINK_PCS_NEG_OUTBAND is happening in my use case and
> therefore the link is not forced up because for that MLO_AN_PHY would be
> needed. I will also try to think about it.

Now that I've moved the setting of PortType and InBandAutoNegMode into
the pcs_config() method, I now have (on mvneta):

Value at address 0xf1036c00: 0x00008bfd	- PortType = 0
					  (SGMII, necessary to be able
					   to set InBandAnEn=0 below)

Value at address 0xf1036c08: 0x0000c018 - InBandAutoNegMode = 0
					  (1000Base-X mode)

Value at address 0xf1036c0c: 0x00009240	- 1000M, FD, unforced link
					  InBandAnEn = 0

Value at address 0xf1036c10: 0x0000600a - Sync, 1000M, FD, but no link

The reason that the link isn't being forced is because
mvneta_mac_link_up() is being called with mode = MLO_AN_INBAND
which expects the link to be controlled as a result of autoneg,
but we've configured autoneg to be off.

I'm wondering whether we need pl->cur_link_an_mode to be the desired
mode for selecting the result from phylink_pcs_neg_mode(), but also
maintain a separate pl->act_link_an_mode which phylink_pcs_neg_mode()
chooses, dependent on whether the PCS is using inband or outband
mode - and pl->act_link_an_mode is what gets passed to the MAC layer.
That would at least keep the MAC MLO_AN_* consistent with what the
PCS layer is using - and also has the advantage that it makes it
clear that pl->act_link_an_mode only gets updated in the "major
config" path.

A quick test of that... seems to work:

mvneta f1034000.ethernet eno2: PHY [i2c:sfp:16] driver [Broadcom BCM84881] (irq=POLL)
mvneta f1034000.ethernet eno2: phy: 2500base-x setting supported 00,00000000,00008000,0000206c advertising 00,00000000,00008000,0000206c
mvneta f1034000.ethernet eno2: major config 2500base-x
mvneta f1034000.ethernet eno2: link modes: pcs=02 phy=01
mvneta f1034000.ethernet eno2: phylink_mac_config: mode=inband/2500base-x/none adv=00,00000000,00008000,0000206c pause=04
mvneta f1034000.ethernet eno2: phylink_sfp_module_start()
mvneta f1034000.ethernet eno2: phylink_sfp_link_up()
mvneta f1034000.ethernet eno2: phy link down 2500base-x/Unknown/Unknown/none/off
mvneta f1034000.ethernet eno2: phy link up sgmii/1Gbps/Full/none/off
mvneta f1034000.ethernet eno2: major config sgmii
mvneta f1034000.ethernet eno2: link modes: pcs=03 phy=01
mvneta f1034000.ethernet eno2: phylink_mac_config: mode=phy/sgmii/none adv=00,00000000,00008000,0000206c pause=00
mvneta f1034000.ethernet eno2: pcs link down
mvneta f1034000.ethernet eno2: pcs link down
mvneta f1034000.ethernet eno2: can LPI, EEE enabled, active
mvneta f1034000.ethernet eno2: enabling tx_lpi, timer 250us
mvneta f1034000.ethernet eno2: Link is Up - 1Gbps/Full - flow control off

Value at address 0xf1036c00: 0x00008bfd
Value at address 0xf1036c08: 0x0000c018
Value at address 0xf1036c0c: 0x00009242
Value at address 0xf1036c10: 0x0000600b

So we can see in the two phylink_mac_config calls that the mode has
switched from "inband" to "phy" with this PHY (BCM84881) which
doesn't support inband in any interface modes.

However, there's still the issue with:

link modes: pcs=02 phy=01
phylink_mac_config: mode=inband/2500base-x/none adv=00,00000000,00008000,0000206c pause=04

and this is because of the missing code in this part:

	/* PHY present, inband mode depends on the capabilities
	 * of both.
	 */

but there's also the issue that the PCS and PHY capabilities like that
are incompatible. In this case, we're saved by the fact that if we do
this act_link_an_mode thing:

        pl->act_link_an_mode = pl->cur_link_an_mode;
        if (pl->pcs_neg_mode == PHYLINK_PCS_NEG_OUTBAND &&
            pl->act_link_an_mode == MLO_AN_INBAND)
                pl->act_link_an_mode = MLO_AN_PHY;

coupled with the new _behaviour_ of mvneta/mvpp2, we don't actually
end up in the "1000base-X must have AN enabled" trap... but that is
no basis to basing decisions at the phylink layer on.

So, I'm wondering whether we need to be a little more creative here.
Instead of simply passing a few bits, maybe something like:

	31-24: bitfield of "partner" capabilities that are supported
		for inband enabled mode
	23-16: bitfield of "partner" capabilities that are supported
		for inband disabled mode
	15-8: bitfield of "partner" capabilities that are supported
		for outband mode
	2: bypass mode supported
	1: inband enabled mode supported
	0: inband disabled mode supported

Now, a question will come up... what is different between inband
disabled and outband mode?

Consider 1000base-X fibre. 1000base-X is the media interface, and we
need to be able to configure autoneg there, enabling or disabling it.
If we don't support disabling autoneg (as is the case with mvneta
et.al. over fibre) then being able to use ethtool to disable autoneg
can't be used. In both these modes, the 1000base-X is the media side.

However, 1000base-X can be used to connect to a PHY, and the PHY
could do rate matching, so the we need to use an outband way to
access the media side (we need to talk to the PHY.)

Hence why PCS have a distinction between OUTBAND and INBAND_DISABLED.

Now, with 2500base-X we run into the problem that e.g. mvneta
operating in 1000base-X mode upclocked to 2.5G can only support
INBAND_ENABLED and not INBAND_DISABLED (we can't just turn off the
InBandAnEn bit). The change between INBAND_ENABLED and INBAND_DISABLED
can happen with the link up.

However, it can support OUTBAND by disabling the PortType bit and then
turning off InBandAnEn (which can only be done with the link *down*
and that is only guaranteed during a "major config" not through the
ethtool settings API - which is why pcs_config() can't do this for 
INBAND_DISABLED.)

So, a little bit of progress but not at a usable solution yet.

I'm afraid my current tree is in a hacky mess at the moment, I'll see
about updating the published patches as soon as I can.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

