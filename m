Return-Path: <linux-kernel+bounces-7336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7ECE81A5FA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 18:07:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FBDC1F22C6C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 17:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C634778E;
	Wed, 20 Dec 2023 17:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BRl0yeyk"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E12A47771;
	Wed, 20 Dec 2023 17:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40c256ffdbcso68824575e9.2;
        Wed, 20 Dec 2023 09:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703092033; x=1703696833; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=btkt3/Ub6w7H3XcLi44cnri98QOOc7fkwdM7Oeq81Eo=;
        b=BRl0yeykETh6Qc62GG9n3IKCsA/gZvRZnLOjgHLngh0FCupeF8kdVdI5QOcH/y9iee
         N9y48T8nwnKyoeKfj3BY/czkYiRgzNwpNb1lr/PAHHYWuTqPvj8NG6NElZPHWfJinc8k
         AbWvyWF+o2ssqOFG9hxOXb+tw/VwCurunjTgV6EE37eX7rGQwt1isP4TvLSV+iXhcIVZ
         8eSN4hk3/U83BwmNnZaIgpgp3h4bvwYhHS4UZhQjHpgNZ/8lsRcfJ6EmAFZ2q/WGWL5L
         JaUs0l2BCC0zqxM4MlhyodMn9LBBA7Weu41vn24wcmpJCZ9qyBxrZOw6RTQSw4kHRnFI
         1ATw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703092033; x=1703696833;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=btkt3/Ub6w7H3XcLi44cnri98QOOc7fkwdM7Oeq81Eo=;
        b=Wk1r5lrYWW+PH1Oqmj996k0gSnlfL3KDpvj9aK+069oyFZKdlRq7plGpwUeenFiO1T
         NrS+CScQXxj2nZLFiY5aF9Ay7iFaaq96zgDSP2b6xZNpZa8RYZFKqsRndzu0FREwFU1v
         2hORhYIU/wvOhTf06dHNu37O7rvN5zyy3/V5SUj2ks9I23cpEVvklkLpn4vC5GhUcMsg
         Ei0UpZLPMy8AoMXuLKsZLiu5d5tic/Yj2QCpVcW8bOpT2Z53k5UO+IYX7oY+7/XJaQBm
         sMi/OfLDsURgxS7Zcp162QrlAMVHO1vY1QmZQBK8XMjeYTAq7fxtHtEfvoJU+SCPOls1
         bhyw==
X-Gm-Message-State: AOJu0YzgQ+OYLtIVV6YnKTaCKpt024urX1Q7jhEake8trUHzAUZ9qnG9
	N0qQqpRRYnrqvxJCFMRSLbA=
X-Google-Smtp-Source: AGHT+IGvEP676wB5EEGLYgDzsgUKyE+KWhF17l1DqTPa5u1oabt9VHt0CW5KehWJlyW6Bsn5irovSw==
X-Received: by 2002:a1c:4b0c:0:b0:40d:12ad:e0c9 with SMTP id y12-20020a1c4b0c000000b0040d12ade0c9mr14037wma.10.1703092032496;
        Wed, 20 Dec 2023 09:07:12 -0800 (PST)
Received: from jernej-laptop.localnet (82-149-12-148.dynamic.telemach.net. [82.149.12.148])
        by smtp.gmail.com with ESMTPSA id ay14-20020a05600c1e0e00b0040c6ab53cd2sm282264wmb.10.2023.12.20.09.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 09:07:11 -0800 (PST)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Anne Macedo <retpolanne@posteo.net>
Cc: Andre Przywara <andre.przywara@arm.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Samuel Holland <samuel@sholland.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 "moderated list:ARM/Allwinner sunXi SoC support"
 <linux-arm-kernel@lists.infradead.org>,
 "open list:ARM/Allwinner sunXi SoC support" <linux-sunxi@lists.linux.dev>,
 open list <linux-kernel@vger.kernel.org>,
 Corentin Labbe <clabbe@baylibre.com>
Subject: Re: [PATCH] arm64: dts: allwinner: Orange Pi One Plus PHY support
Date: Wed, 20 Dec 2023 18:07:08 +0100
Message-ID: <1962081.yKVeVyVuyW@jernej-laptop>
In-Reply-To: <6p6d6l7mxof227mmdud2wsbgjr45dlqjxithpfjxnpjut2l23m@xz65d6ckyvi3>
References:
 <20231212122835.10850-2-retpolanne@posteo.net>
 <3456637.QJadu78ljV@jernej-laptop>
 <6p6d6l7mxof227mmdud2wsbgjr45dlqjxithpfjxnpjut2l23m@xz65d6ckyvi3>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Dne sreda, 20. december 2023 ob 13:13:38 CET je Anne Macedo napisal(a):
> On Tue, Dec 19, 2023 at 07:54:23PM +0100, Jernej Skrabec wrote:
> > Dne torek, 19. december 2023 ob 01:31:05 CET je Anne Macedo napisal(a):
> > > On Wed, Dec 13, 2023 at 12:25:23PM +0000, Andre Przywara wrote:
> > > > On Wed, 13 Dec 2023 11:02:39 +0000
> > > > Anne Macedo <retpolanne@posteo.net> wrote:
> > > > 
> > > > Hi Anne,
> > > > 
> > > > > On Wed, Dec 13, 2023 at 01:35:44AM +0000, Andre Przywara wrote:
> > > > > > On Tue, 12 Dec 2023 19:27:14 +0000
> > > > > > Anne Macedo <retpolanne@posteo.net> wrote:
> > > > > > 
> > > > > > Hi Anne,
> > > > > >   
> > > > > > > On Tue, Dec 12, 2023 at 04:22:00PM +0000, Andre Przywara wrote:  
> > > > > > > > On Tue, 12 Dec 2023 12:28:30 +0000
> > > > > > > > Anne Macedo <retpolanne@posteo.net> wrote:
> > > > > > > > 
> > > > > > > > Hi Anne,
> > > > > > > >     
> > > > > > > > > Adds compatible values to mdio subnodes for Ethernet PHY representing
> > > > > > > > > Realtek 8211 PHY to Orange Pi One Plus.    
> > > > > > > > 
> > > > > > > > So can you state why this would be needed? This is the RTL8211 ID,    
> > > > > > > 
> > > > > > > Apologies, I completely forgot to include some context. 
> > > > > > >   
> > > > > > > > right? Which should be autodetected via MDIO. Looking back in my inbox
> > > > > > > > you proposed this change before, for U-Boot, specifically, but I fail to
> > > > > > > > find a solution or explanation what really happens here. Two Renesas .dts
> > > > > > > > files have the same compatible, and the commit message talks about the
> > > > > > > > reset line there, is this related?
> > > > > > > > 
> > > > > > > > So can you please give some more background and explanation? That would be
> > > > > > > > part of a good commit message anyway ("why", not "what").    
> > > > > > > 
> > > > > > > Should I resend the commit with a more meaningful explanation? The
> > > > > > > context is the following:
> > > > > > > 
> > > > > > > currently, ethernet doesn't seem to work on both u-boot and Linux on the
> > > > > > > Orange Pi One Plus board. 
> > > > > > > 
> > > > > > > On the kernel, this error shows up:
> > > > > > > 
> > > > > > > Configuring network interfaces... [    5.992589] dwmac-sun8i 5020000.ethernet eth0: Register MEM_TYPE_PAGE_POOL RxQ-0
> > > > > > > [    6.000823] dwmac-sun8i 5020000.ethernet eth0: __stmmac_open: Cannot attach to PHY (error: -19)
> > > > > > > 
> > > > > > > After applying this fix, the PHY gets attached: 
> > > > > > > 
> > > > > > > Configuring network interfaces... [    6.060020] dwmac-sun8i 5020000.ethernet eth0: Register MEM_TYPE_PAGE_POOL RxQ-0
> > > > > > > [    6.069460] dwmac-sun8i 5020000.ethernet eth0: PHY [stmmac-0:01] driver [RTL8211E Gigabit Ethernet] (irq=POLL)
> > > > > > > 
> > > > > > > The previous compatible list that had ethernet-phy-ieee802.3-c22 fails
> > > > > > > to find a PHY, so this patch includes the correct PHY ID with the
> > > > > > > RTL8211 ID. 
> > > > > > > 
> > > > > > > The behaviour is described on [1].  
> > > > > > 
> > > > > > So this is all an observation, but no real explanation, isn't it?  
> > > > > 
> > > > > I've made some analysis on [3] on this bug, but it was based solely on
> > > > > u-boot. I was having trouble with the regulator and on u-boot nothing
> > > > > would trigger the GPIO PD6 and the vcc-gmac-3v3 regulator, so the NIC
> > > > > was completely dead. Next I did an analysis based on [2] because the
> > > > > u-boot PHY initialization was flaky.
> > > > > 
> > > > > > To cite [1]: "If the PHY reports an incorrect ID (or none at all) ...".
> > > > > > I am pretty sure this is not the case here, instead we are looking at
> > > > > > some missing platform bits, like a missing clock, reset, or most likely
> > > > > > regulator. Or one of the existing resources is wrongly assigned or  
> > > > > 
> > > > > As I mentioned, PHY initialization is flaky on u-boot, so maybe that
> > > > > assumption is correct. 
> > > > > 
> > > > > > configured? If the PHY is not (yet?) powered correctly when the code
> > > > > > does the auto-detection via the MDIO bus, then the initialisation would  
> > > > > 
> > > > > If I recall correctly (I don't know if I kept it in my notes :c), that
> > > > > could be the case. regulator-boot-on makes the NIC work (LEDs blink, at
> > > > > least) but it doesn't get initialized. 
> > > > > 
> > > > > > fail. But since it works when overriding the auto-detection, I feel
> > > > > > like we are papering over something here.
> > > > > > Do you have the schematics for this board? I can only find the one for
> > > > > > the Orange Pi Plus 2E, and I don't know how similar those two are. This
> > > > > > shows *two* regulators, but both are activated by the same GPIO.  
> > > > > 
> > > > > I do. It's available on [4]
> > > > 
> > > > Oh damn it, I got lost in Orange Pi's naming maze again - and was looking
> > > > for the wrong board! So thanks for the link, and this clears things up!
> > > > 
> > > > So yes, the Orange Pi *One* Plus, much like the Orange Pi 3, uses *two*
> > > > regulators for Ethernet: one 3.3V from the PMIC's ALDO2 rail to power the
> > > > PHY, and a discrete 2.5V regulator, enabled by GPIO PD6, for the voltage
> > > > level on the MDIO lines. On top of this there is a reset line for the PHY,
> > > > though this is held up by a pull-up resistor, so it *should* work,
> > > > although we should describe this in the DT.
> > > > 
> > > > So the DT looks wrong then: The reg_gmac_3v3 is actually a 2.5V regulator,
> > > > and phy-supply is aldo2. I think it was done the way it is to somehow make
> > > > it work with the current DT binding and code, which just supports one
> > > > regulator. And aldo2 is referenced as the source of reg_gmac_3v3, which
> > > > smells like another hack to me.
> > > > 
> > > > > > It would also be interesting to see if any of Corentin's work for the
> > > > > > Orange Pi 3 helps here?  
> > > > > 
> > > > > Adding [5] for reference here, thanks! Will check it out. 
> > > > 
> > > > This is an older version, there are actually updates. And he also mentions
> > > > your board as well, so I think it just can sail in the wake of the OPi 3
> > > > Ethernet enablement.
> > > > 
> > > > Can you try if this change, just applied to your .dts instead, works?
> > > > https://github.com/montjoie/linux/commit/cf6e192eca1d59be630e6729d2cef9e897b3da8c
> > > 
> > > Hello, 
> > > 
> > > I've tried applying this change but it didn't seem to work :( 
> > 
> > Those patches are obsolete, I took over the work and latest patches are here:
> > https://github.com/jernejsk/linux-1/commits/opi3-net/ (last 3)
> > 
> > While I have OrangePi 3 and I have tested patches on it, I don't have Orange
> > Pi One Plus.
> > 
> > > 
> > > I got these errors:
> > > 
> > > [    5.117220] dwmac-sun8i 5020000.ethernet: IRQ eth_wake_irq not found
> > > [    5.124366] dwmac-sun8i 5020000.ethernet: IRQ eth_lpi not found
> > > [    5.130645] dwmac-sun8i 5020000.ethernet: No regulator found
> > > [    5.137133] dwmac-sun8i 5020000.ethernet: PTP uses main clock
> > > [    5.143925] dwmac-sun8i 5020000.ethernet: Current syscon value is not the default 58000 (expect 50000)
> > > [    5.157588] dwmac-sun8i 5020000.ethernet: No HW DMA feature register supported
> > > [    5.164905] dwmac-sun8i 5020000.ethernet: RX Checksum Offload Engine supported
> > > [    5.172189] dwmac-sun8i 5020000.ethernet: COE Type 2
> > > [    5.177213] dwmac-sun8i 5020000.ethernet: TX Checksum insertion supported
> > > [    5.184033] dwmac-sun8i 5020000.ethernet: Normal descriptors
> > > [    5.189724] dwmac-sun8i 5020000.ethernet: Chain mode enabled
> > > [    5.381149] dwmac-sun8i 5020000.ethernet: EMAC reset timeout
> > > [    5.386863] dwmac-sun8i 5020000.ethernet eth0: stmmac_dvr_remove: removing driver
> > > [    5.438851] dwmac-sun8i: probe of 5020000.ethernet failed with error -110
> > > 
> > > I think I understand what is going on in Corentin's patch though. Please
> > > correct me if I'm wrong:
> > > 
> > > 1. Instead of using the gmac-3v3, they use gmac-2v5 enabled by PD6.
> > 
> > Yes, 3v3 is completely wrong. Schematic only shows 2v5 regulator controlled
> > with PD6.
> > 
> > > 2. For "phy-io", the 2v5 regulator is used
> > > 3. For "ephy", the 3v3 regulator is used (aldo2 already sends this 3v3
> > > signal)
> > 
> > Correct.
> > 
> > > 
> > > My changes are here:
> > > https://github.com/retpolanne/linux/commit/45aa2abde2606f9164f9a97d092fab6a36d45165
> > > 
> > > Maybe I should try to use the existing 3v3 regulator alongside a new 2v5
> > > regulator on the DT. 
> > 
> > No.
> > 
> > Please make sure that you have
> > https://github.com/jernejsk/linux-1/commit/25b44143ea8162209beb02759ca3ea3bd3be7a74
> 
> I was able to apply this one
> https://github.com/jernejsk/linux-1/commit/18725ec6239ac4eedea4aefbe224594d2735399c
> 
> But not this one: 
> https://github.com/jernejsk/linux-1/commit/25b44143ea8162209beb02759ca3ea3bd3be7a74
> 
> I believe this latter patch is required to make it work. Has it been
> sent upstream? 

No, but I plan to do that soon.

In any case, patches are based on v6.7-rc1, but you should be able to apply
them to v6.6 too. With older kernels there is issue in first chunk (include),
but that is trivial to resolve.

Best regards,
Jernej

> 
> > 
> > Without it, ethernet PHY won't be powered on and you will get errors in dmesg.
> > 
> > Best regards,
> > Jernej
> > 
> > > > 
> > > > Cheers,
> > > > Andre
> > > > 
> > > > P.S. Is there any chance where I can reply/comment on your blog? It seems
> > > > like I can clear some things up...
> > > > 
> > > > > [3] https://blog.retpolanne.com/hardware/embedded/2023/07/07/embedded-phy.html
> > > > > [4] https://linux-sunxi.org/images/7/7c/OrangePi_OnePlus_Schematics_v2.0.pdf
> > > > > [5] https://lore.kernel.org/netdev/20220509074857.195302-1-clabbe@baylibre.com/
> > > > > 
> > > > > Regards, Anne
> > > > 
> > > 
> > > Regards, Anne
> > > 
> > 
> > 
> > 
> > 
> 





