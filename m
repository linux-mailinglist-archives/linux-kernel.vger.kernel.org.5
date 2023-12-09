Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D804F80B459
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 13:56:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbjLIMqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 07:46:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjLIMq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 07:46:28 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4030CF;
        Sat,  9 Dec 2023 04:46:30 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-3333074512bso2109310f8f.1;
        Sat, 09 Dec 2023 04:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702125989; x=1702730789; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xjdryzYl36inEQGef/Je4h5B071Ib3F2VDmAwmitwYo=;
        b=OucDDvk/KNbR2X0Xbu4A3Up/pTVC3+i4bk49C9TYOvzqA6bOVyfYqqI4poxqLgHTsX
         wKWMYhv5jiB3T20IZA0/bo/gm7DtrjrhtQ8mbDTqxFBjcMcxIC7nRrRWBYazCosaJKIB
         1WgieZSZ7aOBTr6PbzogH4BrfATw832FyVdjSCYh3ID3E8E/RmezKF81jWuUjeped3xe
         8X6jogUIRMdFwyURQeDF/0KGCJiBMSoU4Y00bg1xw/ptyKs57o6+M9ePz+M/aLMlQeod
         VK4kZphJp2+EvaOwFcfwwcYHtVU5YC20k50P5GUiZXCJb9RNFFsENNcXnWGMaQVqpgk+
         PJoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702125989; x=1702730789;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xjdryzYl36inEQGef/Je4h5B071Ib3F2VDmAwmitwYo=;
        b=XNLgcFFdMOUF2tdNAjPHjYCgCQsejZ1Gcn5qw4R5+XPRVZHGs4qAGZf18SLgX/5CBN
         e2JobL3lah3m2uba21jj/PIjmsAcSg/JN2f7YFhcryKt8011wCkUSsaA/FJZkTTY3ZGE
         D+NVYYmiUxtrPX/Qfwhk7uCOASXqrdXRhqySHgfLWSgm+FxFdEppZKqlesEIvQOwnyrR
         aRnQgJOtGSd3TCwwvTucP+HuJRvtTJrw0Qk6zfBZv5eRaKyfraBsIWmB77bY+HFducU0
         KaVjiyDja7hhJNXWxy8wiWqvvqbWVRBpC6/2DKcj1tDMRvrMIaNVkgSE+se1y8OhCK+8
         ISMA==
X-Gm-Message-State: AOJu0YxF5ZNUYnGuc4h3pvJ7XKblqWl1T0F0VOq39Nlp2L5tR0SgtfTo
        kQaBCK9CG4QFp6/zPznXP1U=
X-Google-Smtp-Source: AGHT+IEieSRwwhaURIRh7mltRByGXy6JtzTWhxnklcvsWAvsOtWxPKnn7gd0SkjyFZfvU3/s3j4Auw==
X-Received: by 2002:a05:600c:748:b0:40c:281a:25ff with SMTP id j8-20020a05600c074800b0040c281a25ffmr783705wmn.101.1702125988658;
        Sat, 09 Dec 2023 04:46:28 -0800 (PST)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id c11-20020a5d414b000000b0033342f72bf8sm4334859wrq.9.2023.12.09.04.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Dec 2023 04:46:28 -0800 (PST)
Message-ID: <657461a4.5d0a0220.42455.0c13@mx.google.com>
X-Google-Original-Message-ID: <ZXRhLMemQgponswE@Ansuel-xps.>
Date:   Sat, 9 Dec 2023 13:44:28 +0100
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     kernel test robot <lkp@intel.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [net-next PATCH 2/2] net: phy: at803x: add LED support for
 qca808x
References: <20231209014828.28194-2-ansuelsmth@gmail.com>
 <202312092051.FcBofskz-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202312092051.FcBofskz-lkp@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 09, 2023 at 08:38:38PM +0800, kernel test robot wrote:
> Hi Christian,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on net-next/main]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Christian-Marangi/net-phy-at803x-add-LED-support-for-qca808x/20231209-095014
> base:   net-next/main
> patch link:    https://lore.kernel.org/r/20231209014828.28194-2-ansuelsmth%40gmail.com
> patch subject: [net-next PATCH 2/2] net: phy: at803x: add LED support for qca808x
> config: arm-randconfig-003-20231209 (https://download.01.org/0day-ci/archive/20231209/202312092051.FcBofskz-lkp@intel.com/config)
> compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231209/202312092051.FcBofskz-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202312092051.FcBofskz-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from include/linux/bitops.h:68,
>                     from include/linux/log2.h:12,
>                     from include/asm-generic/div64.h:55,
>                     from arch/arm/include/asm/div64.h:107,
>                     from include/linux/math.h:6,
>                     from include/linux/math64.h:6,
>                     from include/linux/time64.h:5,
>                     from include/linux/restart_block.h:10,
>                     from include/linux/thread_info.h:14,
>                     from include/asm-generic/preempt.h:5,
>                     from ./arch/arm/include/generated/asm/preempt.h:1,
>                     from include/linux/preempt.h:79,
>                     from include/linux/spinlock.h:56,
>                     from include/linux/phy.h:15,
>                     from drivers/net/phy/at803x.c:10:
>    drivers/net/phy/at803x.c: In function 'qca808x_led_hw_control_get':
> >> drivers/net/phy/at803x.c:2270:25: error: 'TRIGGER_NETDEV_LINK_2500' undeclared (first use in this function); did you mean 'TRIGGER_NETDEV_LINK_1000'?
>     2270 |                 set_bit(TRIGGER_NETDEV_LINK_2500, rules);
>          |                         ^~~~~~~~~~~~~~~~~~~~~~~~
>    arch/arm/include/asm/bitops.h:183:31: note: in definition of macro 'ATOMIC_BITOP'
>      183 |         (__builtin_constant_p(nr) ? ____atomic_##name(nr, p) : _##name(nr,p))
>          |                               ^~
>    drivers/net/phy/at803x.c:2270:17: note: in expansion of macro 'set_bit'
>     2270 |                 set_bit(TRIGGER_NETDEV_LINK_2500, rules);
>          |                 ^~~~~~~
>    drivers/net/phy/at803x.c:2270:25: note: each undeclared identifier is reported only once for each function it appears in
>     2270 |                 set_bit(TRIGGER_NETDEV_LINK_2500, rules);
>          |                         ^~~~~~~~~~~~~~~~~~~~~~~~
>    arch/arm/include/asm/bitops.h:183:31: note: in definition of macro 'ATOMIC_BITOP'
>      183 |         (__builtin_constant_p(nr) ? ____atomic_##name(nr, p) : _##name(nr,p))
>          |                               ^~
>    drivers/net/phy/at803x.c:2270:17: note: in expansion of macro 'set_bit'
>     2270 |                 set_bit(TRIGGER_NETDEV_LINK_2500, rules);
>          |                 ^~~~~~~
> 
> 
> vim +2270 drivers/net/phy/at803x.c

Hi,
this error is caused by the lack of the commits for the recently added
support for additional link speed in the netdev LED trigger.

These additional modes has been merged in Lee tree but I guess we need
an immutable branch for net-next to actually use them?

> 
>   2242	
>   2243	static int qca808x_led_hw_control_get(struct phy_device *phydev, u8 index,
>   2244					      unsigned long *rules)
>   2245	{
>   2246		u16 reg;
>   2247		int val;
>   2248	
>   2249		if (index > 2)
>   2250			return -EINVAL;
>   2251	
>   2252		/* Check if we have hw control enabled */
>   2253		if (qca808x_led_hw_control_status(phydev, index))
>   2254			return -EINVAL;
>   2255	
>   2256		reg = QCA808X_MMD7_LED_CTRL(index);
>   2257	
>   2258		val = phy_read_mmd(phydev, MDIO_MMD_AN, reg);
>   2259		if (val & QCA808X_LED_TX_BLINK)
>   2260			set_bit(TRIGGER_NETDEV_TX, rules);
>   2261		if (val & QCA808X_LED_RX_BLINK)
>   2262			set_bit(TRIGGER_NETDEV_RX, rules);
>   2263		if (val & QCA808X_LED_SPEED10_ON)
>   2264			set_bit(TRIGGER_NETDEV_LINK_10, rules);
>   2265		if (val & QCA808X_LED_SPEED100_ON)
>   2266			set_bit(TRIGGER_NETDEV_LINK_100, rules);
>   2267		if (val & QCA808X_LED_SPEED1000_ON)
>   2268			set_bit(TRIGGER_NETDEV_LINK_1000, rules);
>   2269		if (val & QCA808X_LED_SPEED2500_ON)
> > 2270			set_bit(TRIGGER_NETDEV_LINK_2500, rules);
>   2271		if (val & QCA808X_LED_HALF_DUPLEX_ON)
>   2272			set_bit(TRIGGER_NETDEV_HALF_DUPLEX, rules);
>   2273		if (val & QCA808X_LED_FULL_DUPLEX_ON)
>   2274			set_bit(TRIGGER_NETDEV_FULL_DUPLEX, rules);
>   2275	
>   2276		return 0;
>   2277	}
>   2278	
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

-- 
	Ansuel
