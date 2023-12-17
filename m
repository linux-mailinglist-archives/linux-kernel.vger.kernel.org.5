Return-Path: <linux-kernel+bounces-2536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C7B815E8E
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 11:39:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 454D51C2103D
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 10:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A056D63BF;
	Sun, 17 Dec 2023 10:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="udqbuGp2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FB55681;
	Sun, 17 Dec 2023 10:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=9QmkKIQvWtPcr2zP/EVJLB2/wfX5Qw1nAwZBRQGpf8E=; b=udqbuGp2YROpNMEmu8AV15JERC
	iqEmy9L9J2J19/J7z1cHfcj773Rz7v+nA4n2xLUVG37jqckO2XJlzWrfIpdmj3LD+6OO3F0fFCfzt
	XmF39EQceS6xJiE6i0N4DP744jh7LO27AahxRmgFty9xEYQygOZn7vYysxfXMmurd7x2JKYcjr99K
	staTQoU8tXXhFvZ/AoTmb0M+/tcHBWfpF21E66M4j44WSnUqn+TlvRxlE0FeqN9kYFiQ0XwRnQFU8
	AUWIsPZyV3Aqxjv8brnibyX2WYTRmUf/5hcyYbP1TcO4gLhsBr/ox6SW1YKsNy5iF69HHKKP/r5FM
	nHvqQkhQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:55616)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rEoXh-0004KI-1M;
	Sun, 17 Dec 2023 10:38:41 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rEoXh-0005ck-LJ; Sun, 17 Dec 2023 10:38:41 +0000
Date: Sun, 17 Dec 2023 10:38:41 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: kernel test robot <lkp@intel.com>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [net-next PATCH v2 3/3] net: phy: led: dynamically allocate
 speed modes array
Message-ID: <ZX7PsYST5vSz+HNn@shell.armlinux.org.uk>
References: <20231214154906.29436-4-ansuelsmth@gmail.com>
 <202312152038.v9NZyBxd-lkp@intel.com>
 <657e4b1d.df0a0220.897b4.394e@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <657e4b1d.df0a0220.897b4.394e@mx.google.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sun, Dec 17, 2023 at 02:12:58AM +0100, Christian Marangi wrote:
> On Fri, Dec 15, 2023 at 08:50:28PM +0800, kernel test robot wrote:
> > Hi Christian,
> > 
> > kernel test robot noticed the following build errors:
> > 
> > [auto build test ERROR on net-next/main]
> > 
> > url:    https://github.com/intel-lab-lkp/linux/commits/Christian-Marangi/net-phy-refactor-and-better-document-phy_speeds-function/20231215-064112
> > base:   net-next/main
> > patch link:    https://lore.kernel.org/r/20231214154906.29436-4-ansuelsmth%40gmail.com
> > patch subject: [net-next PATCH v2 3/3] net: phy: led: dynamically allocate speed modes array
> > config: arm-randconfig-002-20231215 (https://download.01.org/0day-ci/archive/20231215/202312152038.v9NZyBxd-lkp@intel.com/config)
> > compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231215/202312152038.v9NZyBxd-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202312152038.v9NZyBxd-lkp@intel.com/
> > 
> > All errors (new ones prefixed by >>):
> > 
> > >> drivers/net/phy/phy_led_triggers.c:89:30: error: call to undeclared function 'phy_supported_speeds_num'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
> >       89 |         phy->phy_num_led_triggers = phy_supported_speeds_num(phy);
> >          |                                     ^
> >    drivers/net/phy/phy_led_triggers.c:89:30: note: did you mean 'phy_supported_speeds'?
> >    include/linux/phy.h:208:14: note: 'phy_supported_speeds' declared here
> >      208 | unsigned int phy_supported_speeds(struct phy_device *phy,
> >          |              ^
> > >> drivers/net/phy/phy_led_triggers.c:133:2: error: call to undeclared library function 'free' with type 'void (void *)'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
> >      133 |         free(speeds);
> >          |         ^
> >    drivers/net/phy/phy_led_triggers.c:133:2: note: include the header <stdlib.h> or explicitly provide a declaration for 'free'
> >    2 errors generated.
> > 
> > 
> > vim +/phy_supported_speeds_num +89 drivers/net/phy/phy_led_triggers.c
> > 
> >     83	
> >     84	int phy_led_triggers_register(struct phy_device *phy)
> >     85	{
> >     86		unsigned int *speeds;
> >     87		int i, err;
> >     88	
> >   > 89		phy->phy_num_led_triggers = phy_supported_speeds_num(phy);
> >     90		if (!phy->phy_num_led_triggers)
> >     91			return 0;
> >     92	
> >     93		speeds = kmalloc_array(phy->phy_num_led_triggers, sizeof(*speeds),
> >     94				       GFP_KERNEL);
> >     95		if (!speeds)
> >     96			return -ENOMEM;
> >     97	
> >     98		/* Presence of speed modes already checked up */
> >     99		phy_supported_speeds(phy, speeds, phy->phy_num_led_triggers);
> >    100	
> >    101		phy->led_link_trigger = devm_kzalloc(&phy->mdio.dev,
> >    102						     sizeof(*phy->led_link_trigger),
> >    103						     GFP_KERNEL);
> >    104		if (!phy->led_link_trigger) {
> >    105			err = -ENOMEM;
> >    106			goto out_clear;
> >    107		}
> >    108	
> >    109		err = phy_led_trigger_register(phy, phy->led_link_trigger, 0, "link");
> >    110		if (err)
> >    111			goto out_free_link;
> >    112	
> >    113		phy->phy_led_triggers = devm_kcalloc(&phy->mdio.dev,
> >    114						    phy->phy_num_led_triggers,
> >    115						    sizeof(struct phy_led_trigger),
> >    116						    GFP_KERNEL);
> >    117		if (!phy->phy_led_triggers) {
> >    118			err = -ENOMEM;
> >    119			goto out_unreg_link;
> >    120		}
> >    121	
> >    122		for (i = 0; i < phy->phy_num_led_triggers; i++) {
> >    123			err = phy_led_trigger_register(phy, &phy->phy_led_triggers[i],
> >    124						       speeds[i],
> >    125						       phy_speed_to_str(speeds[i]));
> >    126			if (err)
> >    127				goto out_unreg;
> >    128		}
> >    129	
> >    130		phy->last_triggered = NULL;
> >    131		phy_led_trigger_change_speed(phy);
> >    132	
> >  > 133		free(speeds);
> >    134	
> >    135		return 0;
> >    136	out_unreg:
> >    137		while (i--)
> >    138			phy_led_trigger_unregister(&phy->phy_led_triggers[i]);
> >    139		devm_kfree(&phy->mdio.dev, phy->phy_led_triggers);
> >    140	out_unreg_link:
> >    141		phy_led_trigger_unregister(phy->led_link_trigger);
> >    142	out_free_link:
> >    143		devm_kfree(&phy->mdio.dev, phy->led_link_trigger);
> >    144		phy->led_link_trigger = NULL;
> >    145	out_clear:
> >    146		free(speeds);
> >    147		phy->phy_num_led_triggers = 0;
> >    148		return err;
> >    149	}
> >    150	EXPORT_SYMBOL_GPL(phy_led_triggers_register);
> >    151	
> >
> 
> Ugh didn't think that LEDs netdev trigger doesn't have a dependency on
> PHY...

I don't think you've read and comprehended the kernel build bot
message.

It's complaining that:

1) phy_supported_speeds_num() is not declared in a header file. We can
   see this plainly in patch 2, where you introduce this new function,
   but don't add a function prototype to *any* header file.

2) the function "free" doesn't exist (which is absolutely correct,
   this isn't userspace code).

Obviously, this could not have been build-tested prior to sending it out
either of these would cause a build error. Maybe you built a kernel with
a config that had LEDs support disabled?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

