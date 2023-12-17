Return-Path: <linux-kernel+bounces-2568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A6F815EE5
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 13:12:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D4641C2130C
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 12:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 439D332C7D;
	Sun, 17 Dec 2023 12:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jeH/A1hT"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D275837148;
	Sun, 17 Dec 2023 12:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-32f8441dfb5so1996819f8f.0;
        Sun, 17 Dec 2023 04:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702815166; x=1703419966; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mG/OqA3Puopx0rbvKAh5VO+JZ7ATsfopQJ1Gvh31l5s=;
        b=jeH/A1hTg/cBT7b/Bfewc/UNE3iD4qVk8YNG0ixBdxKvIBsVC37Ofp5S3JGT0Aksbb
         r852nOGg3nV+gdsf8BX/lnrQ0+WxYCmXk17/ju5BB7JbBHPNa3hK5eWPSimDH5sXFpSO
         A2bgfViC5Dg4b++zxiUbctaMGdLtRMxy5zSZt/m45n+bwPXHAHI/G2P4XODJLDhuFk49
         oUUNWvgb1j5q+VJRiAkNaaSdEgoTUihCcJRNDlO+6uAFZYcWzlcYqHoz2eOOyI1tC74w
         VmJ+ARUnfv98JbwXlcGtFDCOCKw37XuNeTZ0pB0xInawlq0byIpiZnAKnyXNfQ07GFZZ
         JIzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702815166; x=1703419966;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mG/OqA3Puopx0rbvKAh5VO+JZ7ATsfopQJ1Gvh31l5s=;
        b=qzPHN2IH7AD2PeBbIZHzGq5WBWH77pmjmz/P5RY8uNft597e0kTAOOHuJFeLtLKZbN
         lgWUFGtMKSqz4xKftRNZzRRSIhj5RtaGDlwvHI++INgp4dzAEly1TA7tnxUCN3A5eY5i
         ycmNX7nPH0d8B8yYsRJnhSTEA7niSUnP+m2xi1SXN07f76csRieTeIdQGCiHSdbd090y
         eK1/KeunA3lXYdQBI5g30RYYGVle60SSTnl4cvt4sNEC8RDI1Ob2T/jwt02fRndT13vB
         nNj96jfRAAWakOfkCh3UYVAUfeVsberAqGRbQjiXIODIBKyDGac1u+vKYUELbtXpGghL
         mF9g==
X-Gm-Message-State: AOJu0Yx+RvDdfikT3NrDY8FTACdFLvnkAjSMBe9CUjTDS0033b75z1Xb
	rwaFD6CNURO3HS+y3T9ZSKY=
X-Google-Smtp-Source: AGHT+IGth4Y7zqpzzDliTfDhI7RgwTXAjidcMernCiPCgAPxqM3Sd2VRYD7ZfeN/4jqsDedr3sMpvA==
X-Received: by 2002:a5d:614f:0:b0:336:3557:f724 with SMTP id y15-20020a5d614f000000b003363557f724mr4946306wrt.49.1702815165701;
        Sun, 17 Dec 2023 04:12:45 -0800 (PST)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id o7-20020a056000010700b003365fc41bcasm3306683wrx.51.2023.12.17.04.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Dec 2023 04:12:39 -0800 (PST)
Message-ID: <657ee5b7.050a0220.b2609.70f4@mx.google.com>
X-Google-Original-Message-ID: <ZX7lstjQI99rp-mc@Ansuel-xps.>
Date: Sun, 17 Dec 2023 13:12:34 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: kernel test robot <lkp@intel.com>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [net-next PATCH v2 3/3] net: phy: led: dynamically allocate
 speed modes array
References: <20231214154906.29436-4-ansuelsmth@gmail.com>
 <202312152038.v9NZyBxd-lkp@intel.com>
 <657e4b1d.df0a0220.897b4.394e@mx.google.com>
 <ZX7PsYST5vSz+HNn@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZX7PsYST5vSz+HNn@shell.armlinux.org.uk>

On Sun, Dec 17, 2023 at 10:38:41AM +0000, Russell King (Oracle) wrote:
> On Sun, Dec 17, 2023 at 02:12:58AM +0100, Christian Marangi wrote:
> > On Fri, Dec 15, 2023 at 08:50:28PM +0800, kernel test robot wrote:
> > > Hi Christian,
> > > 
> > > kernel test robot noticed the following build errors:
> > > 
> > > [auto build test ERROR on net-next/main]
> > > 
> > > url:    https://github.com/intel-lab-lkp/linux/commits/Christian-Marangi/net-phy-refactor-and-better-document-phy_speeds-function/20231215-064112
> > > base:   net-next/main
> > > patch link:    https://lore.kernel.org/r/20231214154906.29436-4-ansuelsmth%40gmail.com
> > > patch subject: [net-next PATCH v2 3/3] net: phy: led: dynamically allocate speed modes array
> > > config: arm-randconfig-002-20231215 (https://download.01.org/0day-ci/archive/20231215/202312152038.v9NZyBxd-lkp@intel.com/config)
> > > compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
> > > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231215/202312152038.v9NZyBxd-lkp@intel.com/reproduce)
> > > 
> > > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > > the same patch/commit), kindly add following tags
> > > | Reported-by: kernel test robot <lkp@intel.com>
> > > | Closes: https://lore.kernel.org/oe-kbuild-all/202312152038.v9NZyBxd-lkp@intel.com/
> > > 
> > > All errors (new ones prefixed by >>):
> > > 
> > > >> drivers/net/phy/phy_led_triggers.c:89:30: error: call to undeclared function 'phy_supported_speeds_num'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
> > >       89 |         phy->phy_num_led_triggers = phy_supported_speeds_num(phy);
> > >          |                                     ^
> > >    drivers/net/phy/phy_led_triggers.c:89:30: note: did you mean 'phy_supported_speeds'?
> > >    include/linux/phy.h:208:14: note: 'phy_supported_speeds' declared here
> > >      208 | unsigned int phy_supported_speeds(struct phy_device *phy,
> > >          |              ^
> > > >> drivers/net/phy/phy_led_triggers.c:133:2: error: call to undeclared library function 'free' with type 'void (void *)'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
> > >      133 |         free(speeds);
> > >          |         ^
> > >    drivers/net/phy/phy_led_triggers.c:133:2: note: include the header <stdlib.h> or explicitly provide a declaration for 'free'
> > >    2 errors generated.
> > > 
> > > 
> > > vim +/phy_supported_speeds_num +89 drivers/net/phy/phy_led_triggers.c
> > > 
> > >     83	
> > >     84	int phy_led_triggers_register(struct phy_device *phy)
> > >     85	{
> > >     86		unsigned int *speeds;
> > >     87		int i, err;
> > >     88	
> > >   > 89		phy->phy_num_led_triggers = phy_supported_speeds_num(phy);
> > >     90		if (!phy->phy_num_led_triggers)
> > >     91			return 0;
> > >     92	
> > >     93		speeds = kmalloc_array(phy->phy_num_led_triggers, sizeof(*speeds),
> > >     94				       GFP_KERNEL);
> > >     95		if (!speeds)
> > >     96			return -ENOMEM;
> > >     97	
> > >     98		/* Presence of speed modes already checked up */
> > >     99		phy_supported_speeds(phy, speeds, phy->phy_num_led_triggers);
> > >    100	
> > >    101		phy->led_link_trigger = devm_kzalloc(&phy->mdio.dev,
> > >    102						     sizeof(*phy->led_link_trigger),
> > >    103						     GFP_KERNEL);
> > >    104		if (!phy->led_link_trigger) {
> > >    105			err = -ENOMEM;
> > >    106			goto out_clear;
> > >    107		}
> > >    108	
> > >    109		err = phy_led_trigger_register(phy, phy->led_link_trigger, 0, "link");
> > >    110		if (err)
> > >    111			goto out_free_link;
> > >    112	
> > >    113		phy->phy_led_triggers = devm_kcalloc(&phy->mdio.dev,
> > >    114						    phy->phy_num_led_triggers,
> > >    115						    sizeof(struct phy_led_trigger),
> > >    116						    GFP_KERNEL);
> > >    117		if (!phy->phy_led_triggers) {
> > >    118			err = -ENOMEM;
> > >    119			goto out_unreg_link;
> > >    120		}
> > >    121	
> > >    122		for (i = 0; i < phy->phy_num_led_triggers; i++) {
> > >    123			err = phy_led_trigger_register(phy, &phy->phy_led_triggers[i],
> > >    124						       speeds[i],
> > >    125						       phy_speed_to_str(speeds[i]));
> > >    126			if (err)
> > >    127				goto out_unreg;
> > >    128		}
> > >    129	
> > >    130		phy->last_triggered = NULL;
> > >    131		phy_led_trigger_change_speed(phy);
> > >    132	
> > >  > 133		free(speeds);
> > >    134	
> > >    135		return 0;
> > >    136	out_unreg:
> > >    137		while (i--)
> > >    138			phy_led_trigger_unregister(&phy->phy_led_triggers[i]);
> > >    139		devm_kfree(&phy->mdio.dev, phy->phy_led_triggers);
> > >    140	out_unreg_link:
> > >    141		phy_led_trigger_unregister(phy->led_link_trigger);
> > >    142	out_free_link:
> > >    143		devm_kfree(&phy->mdio.dev, phy->led_link_trigger);
> > >    144		phy->led_link_trigger = NULL;
> > >    145	out_clear:
> > >    146		free(speeds);
> > >    147		phy->phy_num_led_triggers = 0;
> > >    148		return err;
> > >    149	}
> > >    150	EXPORT_SYMBOL_GPL(phy_led_triggers_register);
> > >    151	
> > >
> > 
> > Ugh didn't think that LEDs netdev trigger doesn't have a dependency on
> > PHY...
> 
> I don't think you've read and comprehended the kernel build bot
> message.
> 
> It's complaining that:
> 
> 1) phy_supported_speeds_num() is not declared in a header file. We can
>    see this plainly in patch 2, where you introduce this new function,
>    but don't add a function prototype to *any* header file.
> 
> 2) the function "free" doesn't exist (which is absolutely correct,
>    this isn't userspace code).
> 
> Obviously, this could not have been build-tested prior to sending it out
> either of these would cause a build error. Maybe you built a kernel with
> a config that had LEDs support disabled?
>

Yes you are correct and I have sent this revision by mistake. (already
sent other revision that have this corrected)

Anyway I have sent the question to the wrong series... Resending it to
the correct one, sorry for the noise. (anyway thanks for answering. Yes
the problem in that series is that with a kernel randconfig PHY kconfig
is not built and LED trigger doesn't depend on it, so it's a matter of
decide it worth to add an additional dependency or move functions)

-- 
	Ansuel

