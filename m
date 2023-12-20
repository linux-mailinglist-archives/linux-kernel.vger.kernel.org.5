Return-Path: <linux-kernel+bounces-6879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C118A819ECA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 13:14:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14618B22975
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 12:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1732224B4C;
	Wed, 20 Dec 2023 12:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="WT9v2T2C"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00F32576A
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 12:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 43E3D240101
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 13:13:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1703074429; bh=ghFf4CN18foTQ+eaQD1oH17ewiDZ/klB8k+BuZ4kWRs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:
	 Content-Disposition:From;
	b=WT9v2T2Ct+9dnN6UsozlR2NwuBzASqWtX48HYqAoDn0SmgjA7+3jiFXA8RaxA1Xuo
	 3PxNdijKFmB8jMinq4ELF01NlEJk4OlSc8vwsXQmQt94eNr3SYcu97gxLIIoDWQfgf
	 SYWCk5tq6v0qZHMjtn5kKva29KDFWVn5vQeFGym45ViRHxXec5NJ6Un9jxNseDfLBc
	 R9sVS85HvYOK7ND7JZUeBhnPvUITyO1HLkXcX8PJyIIcpWwVoxU37vTog7xgL1pgK8
	 WZSwnzVNqKXajuHZ/RuOpnJJGWDIfiTLawTiUcjsmejBMJyNMqz/Mt1UthZ5MVDPf9
	 6F+8aArNWXcbA==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4SwCCB1vJ3z6tvx;
	Wed, 20 Dec 2023 13:13:42 +0100 (CET)
Date: Wed, 20 Dec 2023 12:13:38 +0000
From: Anne Macedo <retpolanne@posteo.net>
To: Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>
Cc: Andre Przywara <andre.przywara@arm.com>, 
	Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
	Samuel Holland <samuel@sholland.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, 
	"moderated list:ARM/Allwinner sunXi SoC support" <linux-arm-kernel@lists.infradead.org>, 
	"open list:ARM/Allwinner sunXi SoC support" <linux-sunxi@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>, 
	Corentin Labbe <clabbe@baylibre.com>
Subject: Re: [PATCH] arm64: dts: allwinner: Orange Pi One Plus PHY support
Message-ID: <6p6d6l7mxof227mmdud2wsbgjr45dlqjxithpfjxnpjut2l23m@xz65d6ckyvi3>
References: <20231212122835.10850-2-retpolanne@posteo.net>
 <20231213122523.219cbfc0@donnerap.manchester.arm.com>
 <ljqe2z34upvzaxh744labf6ephmvcj535img2ct4d2vijjmboh@abg7anbngfyv>
 <3456637.QJadu78ljV@jernej-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3456637.QJadu78ljV@jernej-laptop>

On Tue, Dec 19, 2023 at 07:54:23PM +0100, Jernej Skrabec wrote:
> Dne torek, 19. december 2023 ob 01:31:05 CET je Anne Macedo napisal(a):
> > On Wed, Dec 13, 2023 at 12:25:23PM +0000, Andre Przywara wrote:
> > > On Wed, 13 Dec 2023 11:02:39 +0000
> > > Anne Macedo <retpolanne@posteo.net> wrote:
> > > 
> > > Hi Anne,
> > > 
> > > > On Wed, Dec 13, 2023 at 01:35:44AM +0000, Andre Przywara wrote:
> > > > > On Tue, 12 Dec 2023 19:27:14 +0000
> > > > > Anne Macedo <retpolanne@posteo.net> wrote:
> > > > > 
> > > > > Hi Anne,
> > > > >   
> > > > > > On Tue, Dec 12, 2023 at 04:22:00PM +0000, Andre Przywara wrote:  
> > > > > > > On Tue, 12 Dec 2023 12:28:30 +0000
> > > > > > > Anne Macedo <retpolanne@posteo.net> wrote:
> > > > > > > 
> > > > > > > Hi Anne,
> > > > > > >     
> > > > > > > > Adds compatible values to mdio subnodes for Ethernet PHY representing
> > > > > > > > Realtek 8211 PHY to Orange Pi One Plus.    
> > > > > > > 
> > > > > > > So can you state why this would be needed? This is the RTL8211 ID,    
> > > > > > 
> > > > > > Apologies, I completely forgot to include some context. 
> > > > > >   
> > > > > > > right? Which should be autodetected via MDIO. Looking back in my inbox
> > > > > > > you proposed this change before, for U-Boot, specifically, but I fail to
> > > > > > > find a solution or explanation what really happens here. Two Renesas .dts
> > > > > > > files have the same compatible, and the commit message talks about the
> > > > > > > reset line there, is this related?
> > > > > > > 
> > > > > > > So can you please give some more background and explanation? That would be
> > > > > > > part of a good commit message anyway ("why", not "what").    
> > > > > > 
> > > > > > Should I resend the commit with a more meaningful explanation? The
> > > > > > context is the following:
> > > > > > 
> > > > > > currently, ethernet doesn't seem to work on both u-boot and Linux on the
> > > > > > Orange Pi One Plus board. 
> > > > > > 
> > > > > > On the kernel, this error shows up:
> > > > > > 
> > > > > > Configuring network interfaces... [    5.992589] dwmac-sun8i 5020000.ethernet eth0: Register MEM_TYPE_PAGE_POOL RxQ-0
> > > > > > [    6.000823] dwmac-sun8i 5020000.ethernet eth0: __stmmac_open: Cannot attach to PHY (error: -19)
> > > > > > 
> > > > > > After applying this fix, the PHY gets attached: 
> > > > > > 
> > > > > > Configuring network interfaces... [    6.060020] dwmac-sun8i 5020000.ethernet eth0: Register MEM_TYPE_PAGE_POOL RxQ-0
> > > > > > [    6.069460] dwmac-sun8i 5020000.ethernet eth0: PHY [stmmac-0:01] driver [RTL8211E Gigabit Ethernet] (irq=POLL)
> > > > > > 
> > > > > > The previous compatible list that had ethernet-phy-ieee802.3-c22 fails
> > > > > > to find a PHY, so this patch includes the correct PHY ID with the
> > > > > > RTL8211 ID. 
> > > > > > 
> > > > > > The behaviour is described on [1].  
> > > > > 
> > > > > So this is all an observation, but no real explanation, isn't it?  
> > > > 
> > > > I've made some analysis on [3] on this bug, but it was based solely on
> > > > u-boot. I was having trouble with the regulator and on u-boot nothing
> > > > would trigger the GPIO PD6 and the vcc-gmac-3v3 regulator, so the NIC
> > > > was completely dead. Next I did an analysis based on [2] because the
> > > > u-boot PHY initialization was flaky.
> > > > 
> > > > > To cite [1]: "If the PHY reports an incorrect ID (or none at all) ...".
> > > > > I am pretty sure this is not the case here, instead we are looking at
> > > > > some missing platform bits, like a missing clock, reset, or most likely
> > > > > regulator. Or one of the existing resources is wrongly assigned or  
> > > > 
> > > > As I mentioned, PHY initialization is flaky on u-boot, so maybe that
> > > > assumption is correct. 
> > > > 
> > > > > configured? If the PHY is not (yet?) powered correctly when the code
> > > > > does the auto-detection via the MDIO bus, then the initialisation would  
> > > > 
> > > > If I recall correctly (I don't know if I kept it in my notes :c), that
> > > > could be the case. regulator-boot-on makes the NIC work (LEDs blink, at
> > > > least) but it doesn't get initialized. 
> > > > 
> > > > > fail. But since it works when overriding the auto-detection, I feel
> > > > > like we are papering over something here.
> > > > > Do you have the schematics for this board? I can only find the one for
> > > > > the Orange Pi Plus 2E, and I don't know how similar those two are. This
> > > > > shows *two* regulators, but both are activated by the same GPIO.  
> > > > 
> > > > I do. It's available on [4]
> > > 
> > > Oh damn it, I got lost in Orange Pi's naming maze again - and was looking
> > > for the wrong board! So thanks for the link, and this clears things up!
> > > 
> > > So yes, the Orange Pi *One* Plus, much like the Orange Pi 3, uses *two*
> > > regulators for Ethernet: one 3.3V from the PMIC's ALDO2 rail to power the
> > > PHY, and a discrete 2.5V regulator, enabled by GPIO PD6, for the voltage
> > > level on the MDIO lines. On top of this there is a reset line for the PHY,
> > > though this is held up by a pull-up resistor, so it *should* work,
> > > although we should describe this in the DT.
> > > 
> > > So the DT looks wrong then: The reg_gmac_3v3 is actually a 2.5V regulator,
> > > and phy-supply is aldo2. I think it was done the way it is to somehow make
> > > it work with the current DT binding and code, which just supports one
> > > regulator. And aldo2 is referenced as the source of reg_gmac_3v3, which
> > > smells like another hack to me.
> > > 
> > > > > It would also be interesting to see if any of Corentin's work for the
> > > > > Orange Pi 3 helps here?  
> > > > 
> > > > Adding [5] for reference here, thanks! Will check it out. 
> > > 
> > > This is an older version, there are actually updates. And he also mentions
> > > your board as well, so I think it just can sail in the wake of the OPi 3
> > > Ethernet enablement.
> > > 
> > > Can you try if this change, just applied to your .dts instead, works?
> > > https://github.com/montjoie/linux/commit/cf6e192eca1d59be630e6729d2cef9e897b3da8c
> > 
> > Hello, 
> > 
> > I've tried applying this change but it didn't seem to work :( 
> 
> Those patches are obsolete, I took over the work and latest patches are here:
> https://github.com/jernejsk/linux-1/commits/opi3-net/ (last 3)
> 
> While I have OrangePi 3 and I have tested patches on it, I don't have Orange
> Pi One Plus.
> 
> > 
> > I got these errors:
> > 
> > [    5.117220] dwmac-sun8i 5020000.ethernet: IRQ eth_wake_irq not found
> > [    5.124366] dwmac-sun8i 5020000.ethernet: IRQ eth_lpi not found
> > [    5.130645] dwmac-sun8i 5020000.ethernet: No regulator found
> > [    5.137133] dwmac-sun8i 5020000.ethernet: PTP uses main clock
> > [    5.143925] dwmac-sun8i 5020000.ethernet: Current syscon value is not the default 58000 (expect 50000)
> > [    5.157588] dwmac-sun8i 5020000.ethernet: No HW DMA feature register supported
> > [    5.164905] dwmac-sun8i 5020000.ethernet: RX Checksum Offload Engine supported
> > [    5.172189] dwmac-sun8i 5020000.ethernet: COE Type 2
> > [    5.177213] dwmac-sun8i 5020000.ethernet: TX Checksum insertion supported
> > [    5.184033] dwmac-sun8i 5020000.ethernet: Normal descriptors
> > [    5.189724] dwmac-sun8i 5020000.ethernet: Chain mode enabled
> > [    5.381149] dwmac-sun8i 5020000.ethernet: EMAC reset timeout
> > [    5.386863] dwmac-sun8i 5020000.ethernet eth0: stmmac_dvr_remove: removing driver
> > [    5.438851] dwmac-sun8i: probe of 5020000.ethernet failed with error -110
> > 
> > I think I understand what is going on in Corentin's patch though. Please
> > correct me if I'm wrong:
> > 
> > 1. Instead of using the gmac-3v3, they use gmac-2v5 enabled by PD6.
> 
> Yes, 3v3 is completely wrong. Schematic only shows 2v5 regulator controlled
> with PD6.
> 
> > 2. For "phy-io", the 2v5 regulator is used
> > 3. For "ephy", the 3v3 regulator is used (aldo2 already sends this 3v3
> > signal)
> 
> Correct.
> 
> > 
> > My changes are here:
> > https://github.com/retpolanne/linux/commit/45aa2abde2606f9164f9a97d092fab6a36d45165
> > 
> > Maybe I should try to use the existing 3v3 regulator alongside a new 2v5
> > regulator on the DT. 
> 
> No.
> 
> Please make sure that you have
> https://github.com/jernejsk/linux-1/commit/25b44143ea8162209beb02759ca3ea3bd3be7a74

I was able to apply this one
https://github.com/jernejsk/linux-1/commit/18725ec6239ac4eedea4aefbe224594d2735399c

But not this one: 
https://github.com/jernejsk/linux-1/commit/25b44143ea8162209beb02759ca3ea3bd3be7a74

I believe this latter patch is required to make it work. Has it been
sent upstream? 

> 
> Without it, ethernet PHY won't be powered on and you will get errors in dmesg.
> 
> Best regards,
> Jernej
> 
> > > 
> > > Cheers,
> > > Andre
> > > 
> > > P.S. Is there any chance where I can reply/comment on your blog? It seems
> > > like I can clear some things up...
> > > 
> > > > [3] https://blog.retpolanne.com/hardware/embedded/2023/07/07/embedded-phy.html
> > > > [4] https://linux-sunxi.org/images/7/7c/OrangePi_OnePlus_Schematics_v2.0.pdf
> > > > [5] https://lore.kernel.org/netdev/20220509074857.195302-1-clabbe@baylibre.com/
> > > > 
> > > > Regards, Anne
> > > 
> > 
> > Regards, Anne
> > 
> 
> 
> 
> 

