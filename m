Return-Path: <linux-kernel+bounces-2425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0AFE815CF6
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 02:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92A5828471F
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 01:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D178A5F;
	Sun, 17 Dec 2023 01:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dozMAKOu"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B4DED0;
	Sun, 17 Dec 2023 01:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3363ebb277bso1269744f8f.2;
        Sat, 16 Dec 2023 17:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702775582; x=1703380382; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SjinJKPfEbny44MeADKPhsqIyVSeVSzCT2ksQwpU4dU=;
        b=dozMAKOummEVrVn051vvo5lI0kUp2ZSjXj+sTkWefDaanWQHk+k5oRQ4mXZBak5rta
         dkLxaOOfI9jbd6/W6Q73NJyU/o3EFTqEK4ZEjB8XSbULQ6Hwa8FbOb6bIVpl6Hb9MwSp
         NQyRGRRjfpa/vMgfUuwH3iHhS+hcE8kwoPKbOsZeRIyqoa+2xOPlujoAVwzQA6wn4u6x
         1L2a3uRHIVhnc6m31clmXrjp12g1ncthJ316pQo3689q96M3BKHAphob9p0hG0sHHAWC
         w25P/Wo/119rRZ3zQsxirPe30fl7AFgeslbS7yPbEkGoGTo+zpwZXge919ucAjIc0RDU
         qqVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702775582; x=1703380382;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SjinJKPfEbny44MeADKPhsqIyVSeVSzCT2ksQwpU4dU=;
        b=O2PaFWxWbOgtYIZyQF7x77K7etzNYUxLY6ykDGUdPjf+EK5dTKFl5a6l1RSrwPg606
         6QV2EZ41f1g+8+Yu1cbsQZqZmkxSItzu3DeRn/RAxzA6hXdndopDDHKplEUxHPNi5G2l
         J6UCg7PDRfOkKS7sT0bjEdrnw6kZX8X1EzDnp7EjBWlhdR1FoxjdlFGCqXXbMHGPVasn
         l4ja9VhYS3lnDB8vEmpUS27U4OQbqVUBO7t1mdXeXBwMZEqE6gQ324+KF0jz/zKZFdN7
         hkiWiM7LqamM2VuaEsoFwCax0OiBUgrObmW+LObG5i/6RxWW+3Q+Mj46USajSjMfVpSy
         OcvQ==
X-Gm-Message-State: AOJu0YzqtChMh+1eqX2UH+SoB1Bg5RyJA5w5zpGA1+RvkwNmud0Xfeqn
	6nXASURh2dFvkmWRfbpyzys=
X-Google-Smtp-Source: AGHT+IE6QSyX5Vw0iQNhwCz8VP9nKC1VWqKzrRXg0WU8zWD+0pR+qU++qN+Rm/Rw/RL1HFqr/N5jqA==
X-Received: by 2002:adf:e4c9:0:b0:336:42cc:19ef with SMTP id v9-20020adfe4c9000000b0033642cc19efmr3274355wrm.92.1702775581877;
        Sat, 16 Dec 2023 17:13:01 -0800 (PST)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id t3-20020adff603000000b003364c0aadebsm6864595wrp.15.2023.12.16.17.13.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Dec 2023 17:13:01 -0800 (PST)
Message-ID: <657e4b1d.df0a0220.897b4.394e@mx.google.com>
X-Google-Original-Message-ID: <ZX5LGjhSuTU0YgoA@Ansuel-xps.>
Date: Sun, 17 Dec 2023 02:12:58 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: kernel test robot <lkp@intel.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [net-next PATCH v2 3/3] net: phy: led: dynamically allocate
 speed modes array
References: <20231214154906.29436-4-ansuelsmth@gmail.com>
 <202312152038.v9NZyBxd-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202312152038.v9NZyBxd-lkp@intel.com>

On Fri, Dec 15, 2023 at 08:50:28PM +0800, kernel test robot wrote:
> Hi Christian,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on net-next/main]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Christian-Marangi/net-phy-refactor-and-better-document-phy_speeds-function/20231215-064112
> base:   net-next/main
> patch link:    https://lore.kernel.org/r/20231214154906.29436-4-ansuelsmth%40gmail.com
> patch subject: [net-next PATCH v2 3/3] net: phy: led: dynamically allocate speed modes array
> config: arm-randconfig-002-20231215 (https://download.01.org/0day-ci/archive/20231215/202312152038.v9NZyBxd-lkp@intel.com/config)
> compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231215/202312152038.v9NZyBxd-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202312152038.v9NZyBxd-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
> >> drivers/net/phy/phy_led_triggers.c:89:30: error: call to undeclared function 'phy_supported_speeds_num'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>       89 |         phy->phy_num_led_triggers = phy_supported_speeds_num(phy);
>          |                                     ^
>    drivers/net/phy/phy_led_triggers.c:89:30: note: did you mean 'phy_supported_speeds'?
>    include/linux/phy.h:208:14: note: 'phy_supported_speeds' declared here
>      208 | unsigned int phy_supported_speeds(struct phy_device *phy,
>          |              ^
> >> drivers/net/phy/phy_led_triggers.c:133:2: error: call to undeclared library function 'free' with type 'void (void *)'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>      133 |         free(speeds);
>          |         ^
>    drivers/net/phy/phy_led_triggers.c:133:2: note: include the header <stdlib.h> or explicitly provide a declaration for 'free'
>    2 errors generated.
> 
> 
> vim +/phy_supported_speeds_num +89 drivers/net/phy/phy_led_triggers.c
> 
>     83	
>     84	int phy_led_triggers_register(struct phy_device *phy)
>     85	{
>     86		unsigned int *speeds;
>     87		int i, err;
>     88	
>   > 89		phy->phy_num_led_triggers = phy_supported_speeds_num(phy);
>     90		if (!phy->phy_num_led_triggers)
>     91			return 0;
>     92	
>     93		speeds = kmalloc_array(phy->phy_num_led_triggers, sizeof(*speeds),
>     94				       GFP_KERNEL);
>     95		if (!speeds)
>     96			return -ENOMEM;
>     97	
>     98		/* Presence of speed modes already checked up */
>     99		phy_supported_speeds(phy, speeds, phy->phy_num_led_triggers);
>    100	
>    101		phy->led_link_trigger = devm_kzalloc(&phy->mdio.dev,
>    102						     sizeof(*phy->led_link_trigger),
>    103						     GFP_KERNEL);
>    104		if (!phy->led_link_trigger) {
>    105			err = -ENOMEM;
>    106			goto out_clear;
>    107		}
>    108	
>    109		err = phy_led_trigger_register(phy, phy->led_link_trigger, 0, "link");
>    110		if (err)
>    111			goto out_free_link;
>    112	
>    113		phy->phy_led_triggers = devm_kcalloc(&phy->mdio.dev,
>    114						    phy->phy_num_led_triggers,
>    115						    sizeof(struct phy_led_trigger),
>    116						    GFP_KERNEL);
>    117		if (!phy->phy_led_triggers) {
>    118			err = -ENOMEM;
>    119			goto out_unreg_link;
>    120		}
>    121	
>    122		for (i = 0; i < phy->phy_num_led_triggers; i++) {
>    123			err = phy_led_trigger_register(phy, &phy->phy_led_triggers[i],
>    124						       speeds[i],
>    125						       phy_speed_to_str(speeds[i]));
>    126			if (err)
>    127				goto out_unreg;
>    128		}
>    129	
>    130		phy->last_triggered = NULL;
>    131		phy_led_trigger_change_speed(phy);
>    132	
>  > 133		free(speeds);
>    134	
>    135		return 0;
>    136	out_unreg:
>    137		while (i--)
>    138			phy_led_trigger_unregister(&phy->phy_led_triggers[i]);
>    139		devm_kfree(&phy->mdio.dev, phy->phy_led_triggers);
>    140	out_unreg_link:
>    141		phy_led_trigger_unregister(phy->led_link_trigger);
>    142	out_free_link:
>    143		devm_kfree(&phy->mdio.dev, phy->led_link_trigger);
>    144		phy->led_link_trigger = NULL;
>    145	out_clear:
>    146		free(speeds);
>    147		phy->phy_num_led_triggers = 0;
>    148		return err;
>    149	}
>    150	EXPORT_SYMBOL_GPL(phy_led_triggers_register);
>    151	
>

Ugh didn't think that LEDs netdev trigger doesn't have a dependency on
PHY...

Andrew any idea about this?

I can see 2 solution (or maybe 3???):

- Add the dependency for PHY
- Move phy_speeds net_utils.c (with the settings table moved there)
- Implement a custom function in ledtrig-netdev.c

It's sad since the phy_speed was just what we needed to implement this
ins a ""clean way"".

-- 
	Ansuel

