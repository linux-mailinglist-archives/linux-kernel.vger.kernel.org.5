Return-Path: <linux-kernel+bounces-150644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E938AA238
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 20:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDAD61F214EE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 18:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827BF17AD74;
	Thu, 18 Apr 2024 18:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L4BjSN0t"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59022168B17;
	Thu, 18 Apr 2024 18:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713465838; cv=none; b=HkJTAjg81ezNIfoEwpdzxOVOI5EYYkNw3B6FLYG8lJf0AHBhIDv9c5pHvC6yxX3hg23g1QKlZqnd9c1FGl/HNfv4r7yCpM1QGjgdhSt7QLQRJLVBuHvuttOEMpmjJwaHuwMlXCCGszw2cvaieRrkZp7+q8IAcF9XJS2IzAGgozs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713465838; c=relaxed/simple;
	bh=VGl2c/vY8S75SdXUFQeJ2MVgJ7rcxWPDOWmJuiOufl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gZokZk0HXkFnRVWESga2UfRoYcU7lqf3qAKP88Vbs30Fpv9rX5TP7CVQfrZSxvRFsYcfDs0Kl0I+XdWcB9g7+qc7LO1BVdfUpDzLbjdV3suPdj7DOUQQqSV0hJLf8WIa9rHQqeBRZ2z5zhb6Td5aBke0GngWuDKf7nVUPitnknU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L4BjSN0t; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713465836; x=1745001836;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VGl2c/vY8S75SdXUFQeJ2MVgJ7rcxWPDOWmJuiOufl0=;
  b=L4BjSN0tLM/O8+7x7vqORIikBC/U6QnY7jE2eOyOa9uJTmkdAx1chX8+
   9/aUr/jybUv0H3aIdEPxxHoaNcvzIc4pHixGRIe+l1G/VraZaaa8C0xbl
   jnBzYXyPUHI22evclyZh+7pvWQMjKd7N90qzO014hc3TarTMajvAQxX/v
   NwmP6rDoadNpEfeOD4EyB2qKcoL1gGCocqKlCw2RIvtfJgopKXxzXgESc
   2jzGNK9SzKnC0nVrSq4UDvhnI73bNzQCFXJi3tk29Oqr8J4YJjChDTw18
   5AAgab1H+c4Oj0c5xx5IhG6mSBBcyiOd9yRNi4sbwcyFZ9Tw64wLVQ9i0
   w==;
X-CSE-ConnectionGUID: 4EZXg6bXQyO7mk7vKruhXQ==
X-CSE-MsgGUID: 8dl9lVSUQgWbS+4vjNrhpQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="12872155"
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="12872155"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 11:43:55 -0700
X-CSE-ConnectionGUID: b+kG4epdSnOW6UL5vyF8fA==
X-CSE-MsgGUID: o92+kmM3RHWGbK9yDuPdGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="23705452"
Received: from unknown (HELO 23c141fc0fd8) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 18 Apr 2024 11:43:50 -0700
Received: from kbuild by 23c141fc0fd8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rxWjb-00096X-1T;
	Thu, 18 Apr 2024 18:43:47 +0000
Date: Fri, 19 Apr 2024 02:43:16 +0800
From: kernel test robot <lkp@intel.com>
To: Daniel Machon <daniel.machon@microchip.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Lars Povlsen <lars.povlsen@microchip.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	UNGLinuxDriver@microchip.com, Russell King <linux@armlinux.org.uk>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Yue Haibing <yuehaibing@huawei.com>,
	Daniel Machon <daniel.machon@microchip.com>
Subject: Re: [PATCH net-next 3/5] net: sparx5: add port mirroring
 implementation
Message-ID: <202404190240.Iei7Gkj3-lkp@intel.com>
References: <20240418-port-mirroring-v1-3-e05c35007c55@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418-port-mirroring-v1-3-e05c35007c55@microchip.com>

Hi Daniel,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 1c25fe9a044d5334153a3585754b26553f8287b9]

url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-Machon/net-sparx5-add-new-register-definitions/20240418-155244
base:   1c25fe9a044d5334153a3585754b26553f8287b9
patch link:    https://lore.kernel.org/r/20240418-port-mirroring-v1-3-e05c35007c55%40microchip.com
patch subject: [PATCH net-next 3/5] net: sparx5: add port mirroring implementation
config: hexagon-allyesconfig (https://download.01.org/0day-ci/archive/20240419/202404190240.Iei7Gkj3-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 7089c359a3845323f6f30c44a47dd901f2edfe63)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240419/202404190240.Iei7Gkj3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404190240.Iei7Gkj3-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/net/ethernet/microchip/sparx5/sparx5_mirror.c:7:
   In file included from drivers/net/ethernet/microchip/sparx5/sparx5_main.h:11:
   In file included from include/linux/phy/phy.h:17:
   In file included from include/linux/regulator/consumer.h:35:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:26:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     547 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     560 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from drivers/net/ethernet/microchip/sparx5/sparx5_mirror.c:7:
   In file included from drivers/net/ethernet/microchip/sparx5/sparx5_main.h:11:
   In file included from include/linux/phy/phy.h:17:
   In file included from include/linux/regulator/consumer.h:35:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:26:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     573 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from drivers/net/ethernet/microchip/sparx5/sparx5_mirror.c:7:
   In file included from drivers/net/ethernet/microchip/sparx5/sparx5_main.h:11:
   In file included from include/linux/phy/phy.h:17:
   In file included from include/linux/regulator/consumer.h:35:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:26:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     584 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     594 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     604 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   In file included from drivers/net/ethernet/microchip/sparx5/sparx5_mirror.c:7:
   In file included from drivers/net/ethernet/microchip/sparx5/sparx5_main.h:11:
   In file included from include/linux/phy/phy.h:17:
   In file included from include/linux/regulator/consumer.h:35:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:21:
   In file included from include/linux/mm.h:2208:
   include/linux/vmstat.h:522:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     522 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> drivers/net/ethernet/microchip/sparx5/sparx5_mirror.c:36:12: warning: comparison of distinct pointer types ('typeof ((reg)) *' (aka 'unsigned int *') and 'uint64_t *' (aka 'unsigned long long *')) [-Wcompare-distinct-pointer-types]
      36 |         val = BIT(do_div(reg, 32));
         |               ~~~~^~~~~~~~~~~~~~~~
   include/asm-generic/div64.h:222:28: note: expanded from macro 'do_div'
     222 |         (void)(((typeof((n)) *)0) == ((uint64_t *)0));  \
         |                                   ^  ~~~~~~~~~~~~~~~
   include/vdso/bits.h:7:30: note: expanded from macro 'BIT'
       7 | #define BIT(nr)                 (UL(1) << (nr))
         |                                            ^~
   drivers/net/ethernet/microchip/sparx5/sparx5_mirror.c:36:12: error: incompatible pointer types passing 'u32 *' (aka 'unsigned int *') to parameter of type 'uint64_t *' (aka 'unsigned long long *') [-Werror,-Wincompatible-pointer-types]
      36 |         val = BIT(do_div(reg, 32));
         |               ~~~~^~~~~~~~~~~~~~~~
   include/asm-generic/div64.h:238:22: note: expanded from macro 'do_div'
     238 |                 __rem = __div64_32(&(n), __base);       \
         |                                    ^
   include/vdso/bits.h:7:30: note: expanded from macro 'BIT'
       7 | #define BIT(nr)                 (UL(1) << (nr))
         |                                            ^~
   include/asm-generic/div64.h:213:38: note: passing argument to parameter 'dividend' here
     213 | extern uint32_t __div64_32(uint64_t *dividend, uint32_t divisor);
         |                                      ^
>> drivers/net/ethernet/microchip/sparx5/sparx5_mirror.c:36:12: warning: shift count >= width of type [-Wshift-count-overflow]
      36 |         val = BIT(do_div(reg, 32));
         |                   ^~~~~~~~~~~~~~~
   include/asm-generic/div64.h:234:25: note: expanded from macro 'do_div'
     234 |         } else if (likely(((n) >> 32) == 0)) {          \
         |                                ^  ~~
   include/linux/compiler.h:76:40: note: expanded from macro 'likely'
      76 | # define likely(x)      __builtin_expect(!!(x), 1)
         |                                             ^
   include/vdso/bits.h:7:30: note: expanded from macro 'BIT'
       7 | #define BIT(nr)                 (UL(1) << (nr))
         |                                            ^~
   drivers/net/ethernet/microchip/sparx5/sparx5_mirror.c:49:12: warning: comparison of distinct pointer types ('typeof ((reg)) *' (aka 'unsigned int *') and 'uint64_t *' (aka 'unsigned long long *')) [-Wcompare-distinct-pointer-types]
      49 |         val = BIT(do_div(reg, 32));
         |               ~~~~^~~~~~~~~~~~~~~~
   include/asm-generic/div64.h:222:28: note: expanded from macro 'do_div'
     222 |         (void)(((typeof((n)) *)0) == ((uint64_t *)0));  \
         |                                   ^  ~~~~~~~~~~~~~~~
   include/vdso/bits.h:7:30: note: expanded from macro 'BIT'
       7 | #define BIT(nr)                 (UL(1) << (nr))
         |                                            ^~
   drivers/net/ethernet/microchip/sparx5/sparx5_mirror.c:49:12: error: incompatible pointer types passing 'u32 *' (aka 'unsigned int *') to parameter of type 'uint64_t *' (aka 'unsigned long long *') [-Werror,-Wincompatible-pointer-types]
      49 |         val = BIT(do_div(reg, 32));
         |               ~~~~^~~~~~~~~~~~~~~~
   include/asm-generic/div64.h:238:22: note: expanded from macro 'do_div'
     238 |                 __rem = __div64_32(&(n), __base);       \
         |                                    ^
   include/vdso/bits.h:7:30: note: expanded from macro 'BIT'
       7 | #define BIT(nr)                 (UL(1) << (nr))
         |                                            ^~
   include/asm-generic/div64.h:213:38: note: passing argument to parameter 'dividend' here
     213 | extern uint32_t __div64_32(uint64_t *dividend, uint32_t divisor);
         |                                      ^
   drivers/net/ethernet/microchip/sparx5/sparx5_mirror.c:49:12: warning: shift count >= width of type [-Wshift-count-overflow]
      49 |         val = BIT(do_div(reg, 32));
         |                   ^~~~~~~~~~~~~~~
   include/asm-generic/div64.h:234:25: note: expanded from macro 'do_div'
     234 |         } else if (likely(((n) >> 32) == 0)) {          \
         |                                ^  ~~
   include/linux/compiler.h:76:40: note: expanded from macro 'likely'
      76 | # define likely(x)      __builtin_expect(!!(x), 1)
         |                                             ^
   include/vdso/bits.h:7:30: note: expanded from macro 'BIT'
       7 | #define BIT(nr)                 (UL(1) << (nr))
         |                                            ^~
   11 warnings and 2 errors generated.


vim +36 drivers/net/ethernet/microchip/sparx5/sparx5_mirror.c

    30	
    31	/* Add port to mirror (only front ports) */
    32	static void sparx5_mirror_port_add(struct sparx5 *sparx5, u32 idx, u32 portno)
    33	{
    34		u32 val, reg = portno;
    35	
  > 36		val = BIT(do_div(reg, 32));
    37	
    38		if (reg == 0)
    39			return spx5_rmw(val, val, sparx5, ANA_AC_PROBE_PORT_CFG(idx));
    40		else
    41			return spx5_rmw(val, val, sparx5, ANA_AC_PROBE_PORT_CFG1(idx));
    42	}
    43	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

