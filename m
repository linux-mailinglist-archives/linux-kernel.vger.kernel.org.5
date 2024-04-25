Return-Path: <linux-kernel+bounces-158441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 026718B2024
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 13:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24B431C22DCB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 11:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C2248612E;
	Thu, 25 Apr 2024 11:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Po607BEc"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D0B22616;
	Thu, 25 Apr 2024 11:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714044298; cv=none; b=IbUc35e7u+44ZRVLLsmE2DJ2fLGbqusjPNCsfneVWlk+jpR1MQ78hNqfIX/h9t4rxLkB80bbCwtm0915IeonWML6v7E0W1faaiyXd2DFhMZ2YhayHvUGNuD8qUMH3s4Z2FDNHw3wS2AIRRmZp1YP4SBLFTOjfZX7MMQJhhzAn9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714044298; c=relaxed/simple;
	bh=AOEho0aKVWyW91WXEE9mGidXdOVNcHHcfhU3xlIjZNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SmXARHHlOKDhSQFsXL0D8TFM2Pl7ZVBfyObAou7W8ca/mtR43xAuq684AwP4LniMkpETdKR5DhO34aMpPP2xrTZNz6qxxSdXsUWyhuNgSidPAUEu2js4dTvEjkLVt70x+Re+eVyOBPbDUdlOLg4lDdim+N+ZYnNWQGa12R7SycA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Po607BEc; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-349c4505058so598220f8f.3;
        Thu, 25 Apr 2024 04:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714044294; x=1714649094; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8ah5f3e80zlaRos4N0gOxsro4Angf5608kIkCZWsVI8=;
        b=Po607BEcoPHzlpgOYFn3BlNiL+dVN3W82u2kgIWw1+0OLgKPfjbYfaoFbXn1VbI/c8
         OuB44UyPmoCykKfcy2qCeNesZnCyJGI7FfX4PeR/v18GKmKTubN4/QnzptI99roRvf9/
         gSgHej40yXAkkFEFnREf/aFEAZXHDcFzJocdG5IGZjVjV37FwHHKFXMK0WYpWW4gM+37
         QBdrR/VrGSH6p7E72yttzT4PswrcnpJ+pntUXVfSA0ABbHMmJkaLzjrIHZp2Nvzqyl00
         OcpVC6UkST6B48Ok9EKYUNssH/kNmo5AV75FDoCtkzGeuGmrootnK8oRUzCMKxwrzpbX
         QFZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714044294; x=1714649094;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ah5f3e80zlaRos4N0gOxsro4Angf5608kIkCZWsVI8=;
        b=O3d6FWtosxeqNKQhB6US0oJF+FGl99CvDAjVeDvMO6JW83+nTmUKwgNgUzaidWDYUW
         FXCnwKXHNTwWEajFRNKLVToxW/IG+Pvmg7h5wySmF/ExfZ2ktqES8tGv6rOsaPvk9gz3
         OJkmuxgiJY6js3TWgA8fbg/Y5/T3qH0H+90X0enZl0F3fkJFuAYfp4hnj3M4Ds4rb+X0
         pTnU0ByGnCymYoMelBMfC/Mt3tQzoiFOadwXhOAOrU2NnP/krJgsGQ7T6du2UNSaL8pG
         CW/PMDZOXTSjPekX0M2SkO2TLsvSYhXFbukXRQ5Ulzqc+8F3m+9tUWjJT0/Uvxs2CP1b
         hucw==
X-Forwarded-Encrypted: i=1; AJvYcCWaOJMcoYoLgR8eB32MEqM9t8gcy5D5N92h8himZEI11+UB+6L5EVXw6s3ECezvc/gnGYo+sPw2QfD9RNbKxDKu4PDTtP5/4bQSyEwHJQKSCjyDN8lvBv+ZklqPeo4qMFh2wm/MX3DYqeUJMLjZOza67H6tMKWwX5BeCClwIyuORQ==
X-Gm-Message-State: AOJu0Yxx9Z9gB+0cHpk7osd0IAHsZHJLWA1tqIsUiOqOI/OeOPwvi0iY
	xBfcXpy72HRgKZLLJJZm+jWft2OdbSTMKSo4rjHa3lTLg9D1Az9i
X-Google-Smtp-Source: AGHT+IHeABBUN8fyQLayL6cSWVKt2sEH9HPl9nK/18d2SeT2a0F3Mf6Zjv4A/qMw22hf3DdvYdGBaA==
X-Received: by 2002:a5d:5446:0:b0:345:72af:769b with SMTP id w6-20020a5d5446000000b0034572af769bmr3610560wrv.38.1714044294162;
        Thu, 25 Apr 2024 04:24:54 -0700 (PDT)
Received: from eichest-laptop ([2a02:168:af72:0:aab0:e3cb:ca44:d27])
        by smtp.gmail.com with ESMTPSA id d5-20020a5d6445000000b0034659d971a6sm19539881wrw.26.2024.04.25.04.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 04:24:53 -0700 (PDT)
Date: Thu, 25 Apr 2024 13:24:51 +0200
From: Stefan Eichenberger <eichest@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	lxu@maxlinear.com, hkallweit1@gmail.com, michael@walle.cc,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] net: phy: mxl-gpy: add new device tree property
 to disable SGMII autoneg
Message-ID: <Zio9g9+wsFX39Vkx@eichest-laptop>
References: <Zh6clAtI3NO+nMEi@eichest-laptop>
 <5ed39628-4ac0-4c4e-9a16-fd4bf9a6db29@lunn.ch>
 <Zh6mIv1Ee+1h21Xo@shell.armlinux.org.uk>
 <Zh6z90iCpLqF4fla@eichest-laptop>
 <Zh6/oVHUvnOVtHaC@shell.armlinux.org.uk>
 <Zh94yqo2EHRq8eEq@eichest-laptop>
 <ZiE156+BPpx/ciL6@shell.armlinux.org.uk>
 <Zikd+GxuwMRC+5Ae@shell.armlinux.org.uk>
 <Zikrv5UOWvSGjgcv@eichest-laptop>
 <ZilLz8f6vQQCg4NB@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZilLz8f6vQQCg4NB@shell.armlinux.org.uk>

On Wed, Apr 24, 2024 at 07:13:35PM +0100, Russell King (Oracle) wrote:
> On Wed, Apr 24, 2024 at 05:56:47PM +0200, Stefan Eichenberger wrote:
> > On Wed, Apr 24, 2024 at 03:58:00PM +0100, Russell King (Oracle) wrote:
> > > On Thu, Apr 18, 2024 at 04:01:59PM +0100, Russell King (Oracle) wrote:
> > > > On Wed, Apr 17, 2024 at 09:22:50AM +0200, Stefan Eichenberger wrote:
> > > > > I also checked the datasheet and you are right about the 1000base-X mode
> > > > > and in-band AN. What worked for us so far was to use SGMII mode even for
> > > > > 2.5Gbps and disable in-band AN (which is possible for SGMII). I think
> > > > > this works because as you wrote, the genphy just multiplies the clock by
> > > > > 2.5 and doesn't care if it's 1000base-X or SGMII. With your patches we
> > > > > might even be able to use in-band autonegoation for 10,100 and 1000Mbps
> > > > > and then just disable it for 2.5Gbps. I need to test it, but I have hope
> > > > > that this should work.
> > > > 
> > > > There is another way we could address this. If the querying support
> > > > had a means to identify that the endpoint supports bypass mode, we
> > > > could then have phylink identify that, and arrange to program the
> > > > mvpp2 end to be in 1000base-X + x2.5 clock + AN bypass, which would
> > > > mean it wouldn't require the inband 16-bit word to be present.
> > > > 
> > > > I haven't fully thought it through yet - for example, I haven't
> > > > considered how we should indicate to the PCS that AN bypass mode
> > > > should be enabled or disabled via the pcs_config() method.
> > > 
> > > Okay, I've been trying to put more effort into this, but it's been slow
> > > progress (sorry).
> > > 
> > > My thoughts from a design point of view were that we could just switch
> > > to PHYLINK_PCS_NEG_OUTBAND instead of PHYLINK_PCS_NEG_INBAND_* and
> > > everything at the PCS layer should be able to cope, but this is not the
> > > case, especially with mvneta/mvpp2.
> > > 
> > > The problem is that mvneta/mvpp2 (and probably more) expect that
> > > 
> > > 1) MLO_AN_INBAND means that the PCS will be using inband, and that
> > >    means the link up/down state won't be forced. This basically implies
> > >    that only PHYLINK_PCS_NEG_INBAND_* can be used can be used for the
> > >    PCS.
> > > 
> > > 2) !MLO_AN_INBAND means that an out-of-band mechanism will be used and
> > >    that means that the link needs to be forced (since there's no way
> > >    for the hardware to know whether the link should be up or down.)
> > >    It's therefore expected that only PHYLINK_PCS_NEG_OUTBAND will be
> > >    used for the PCS.
> > > 
> > > So, attempting to put a resolution of the PHY and PCS abilities into
> > > phylink_pcs_neg_mode() and select the appropriate PHYLINK_PCS_NEG_*
> > > mode alone just doesn't work. Yet... we need to do that in there when
> > > considering whether inband can be enabled or not for non-PHY links.
> > > 
> > > Basically, it needs a re-think how to solve this...
> > 
> > Today I was playing around with my combination of mxl-gpy and mvpp2 and
> > I got it working again with your patches applied. However, I hacked the
> > phylink driver to only rely on what the phy and pcs support. I know this
> > is not a proper solution, but it allowed me to verify the other changes.
> > My idea was if the phy and pcs support inband then use it, otherwise use
> > outband and ignore the rest.
> > 
> > Here is how my minimal phylink_pcs_neg_mode test function looks like:
> > 
> > static unsigned int phylink_pcs_neg_mode(struct phylink *pl,
> > 					 struct phylink_pcs *pcs,
> > 					 unsigned int mode,
> > 					 phy_interface_t interface,
> > 					 const unsigned long *advertising)
> > {
> > 	unsigned int phy_link_mode = 0;
> > 	unsigned int pcs_link_mode;
> > 
> > 	pcs_link_mode = phylink_pcs_query_inband(pcs, interface);
> > 	if (pl->phydev)
> > 		phy_link_mode = phy_query_inband(pl->phydev, interface);
> > 
> > 	/* If the PCS or PHY can not provide inband, then use
> > 	 * outband.
> > 	 */
> > 	if (!(pcs_link_mode & LINK_INBAND_VALID) ||
> > 	    !(phy_link_mode & LINK_INBAND_VALID))
> > 		return PHYLINK_PCS_NEG_OUTBAND;
> > 
> > 	return PHYLINK_PCS_NEG_INBAND_ENABLED;
> > }
> 
> Note that I've changed the flags that get reported to be disable (bit 0)/
> enable (bit 1) rather than valid/possible/required because the former
> makes the resolution easier.
> 
> The problem is that merely returning outband doesn't cause mvneta/mvpp2
> to force the link up. So for example, here's a SFP module which doesn't
> support any inband for 2500base-X nor SGMII:
> 
> mvneta f1034000.ethernet eno2: copper SFP: interfaces=[mac=4,9-12,19,22-23, sfp=
> 4,23,27]
> mvneta f1034000.ethernet eno2: copper SFP: chosen 2500base-x interface
> mvneta f1034000.ethernet eno2: PHY i2c:sfp:16 uses interfaces 4,23,27, validatin
> g 4,23
> mvneta f1034000.ethernet eno2:  interface 4 (sgmii) rate match none supports 2-3
> ,5-6,13
> mvneta f1034000.ethernet eno2:  interface 23 (2500base-x) rate match none suppor
> ts 6,13,47
> mvneta f1034000.ethernet eno2: PHY [i2c:sfp:16] driver [Broadcom BCM84881] (irq=
> POLL)
> mvneta f1034000.ethernet eno2: phy: 2500base-x setting supported 00,00000000,000
> 08000,0000206c advertising 00,00000000,00008000,0000206c
> mvneta f1034000.ethernet eno2: copper SFP: PHY link in-band modes 0x1
> mvneta f1034000.ethernet eno2: major config 2500base-x
> mvneta f1034000.ethernet eno2: link modes: pcs=02 phy=01
> mvneta f1034000.ethernet eno2: phylink_mac_config: mode=inband/2500base-x/none a
> dv=00,00000000,00008000,0000206c pause=04
> mvneta f1034000.ethernet eno2: phylink_sfp_module_start()
> mvneta f1034000.ethernet eno2: phylink_sfp_link_up()
> mvneta f1034000.ethernet eno2: phy link down 2500base-x/Unknown/Unknown/none/off
> mvneta f1034000.ethernet eno2: phy link up sgmii/1Gbps/Full/none/off
> mvneta f1034000.ethernet eno2: major config sgmii
> mvneta f1034000.ethernet eno2: link modes: pcs=03 phy=01
> mvneta f1034000.ethernet eno2: phylink_mac_config: mode=inband/sgmii/none adv=00,00000000,00008000,0000206c pause=00
> mvneta f1034000.ethernet eno2: pcs link down
> mvneta f1034000.ethernet eno2: pcs link down
> mvneta f1034000.ethernet eno2: can LPI, EEE enabled, active
> mvneta f1034000.ethernet eno2: enabling tx_lpi, timer 250us
> mvneta f1034000.ethernet eno2: Link is Up - 1Gbps/Full - flow control off
> 
> This looks like the link is up, but it isn't - note "pcs link down".
> If we look at the value of the GMAC AN status register:
> 
> Value at address 0xf1036c10: 0x0000600a
> 
> which indicates that the link is down, so no packets will pass.

What I changed in mvpp2 is to allow turing off inband in 2500base-x. The
mvpp2 driver can handle this use case in pcs_config, it will turn off AN
and force the link up. I think it should also work for mvneta, at least
the code looks almost the same. I get the following for the Port
Auto-Negotiation Configuration Register:

For 1Gbit/s it switches to SGMII and enables inband AN:
Memory mapped at address 0xffffa0112000.
Value at address 0xF2132E0C (0xffffa0112e0c): 0xB0C6

For 2.5Gbit/s it disables inband AN and forces the link to be up:
Memory mapped at address 0xffffaff88000.
Value at address 0xF2132E0C (0xffffaff88e0c): 0x9042

Then the status register shows also link up for 2.5Gbit/s:
Memory mapped at address 0xffffa5fe2000.
Value at address 0xF2132E10 (0xffffa5fe2e10): 0x683B

What might be confusing is that the port type, bit 1 in MAC Control
Register0, is set to SGMII for 2.5Gbit/s, because we can only turn off
autonegotiation for SGMII:
Memory mapped at address 0xffff8c26c000.
Value at address 0xF2132E00 (0xffff8c26ce00): 0x8BFD

My example patch still uses the old macros:

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index 97e38f61ac65..15fadfd61313 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -6223,9 +6223,12 @@ static unsigned int mvpp2_gmac_pcs_query_inband(struct phylink_pcs *pcs,
 	 * When <PortType> = 1 (1000BASE-X) this field must be set to 1.
 	 * Therefore, inband is "required".
 	 */
-	if (phy_interface_mode_is_8023z(interface))
+	if (interface == PHY_INTERFACE_MODE_1000BASEX)
 		return LINK_INBAND_VALID | LINK_INBAND_REQUIRED;
 
+	if (interface == PHY_INTERFACE_MODE_2500BASEX)
+		return LINK_INBAND_VALID | LINK_INBAND_POSSIBLE;
+
 	/* SGMII and RGMII can be configured to use inband signalling of the
 	 * AN result. Indicate these as "possible".
 	 */

