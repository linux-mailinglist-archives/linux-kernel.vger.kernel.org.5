Return-Path: <linux-kernel+bounces-145528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D71618A576E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 18:16:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D4341F2395B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 16:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B8781AB6;
	Mon, 15 Apr 2024 16:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CftzDQ2p"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6123581203;
	Mon, 15 Apr 2024 16:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713197638; cv=none; b=nP1leYSKDZx3mfLZDxZo/ea+6gc22IxLCay1LKV4UtZurKv5pFC3ZyU8MC09J/fuG/0ad6N6hlvjegejf1s0NwWo/8HIOliGfdFgze8pVxcwBYrVKZHOeEIukI52q6Q++PTPSJsSN7cDxKeXLejjp4jV7+dRcXWiZZ2YiJoEmXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713197638; c=relaxed/simple;
	bh=KKu+vZ2OEGjFvRiDZlnd/RfKG7AThwSN7L1inFyOabE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q5U3t457ifwh76XvwNZRfSQPuYBz153zNEzO9yJYvExzcS1n4rzuch//vumem8+7AI3EvnFauuES8Ci2Lrko0WCU7ecxvkgXJ04lkf/KO4dTB7AdnJNCcfTAXGLbJ+d7TLTKWYkxrjezRdB1cxg70zZaeB/xtBC8IP6BxxQWToc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CftzDQ2p; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713197636; x=1744733636;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KKu+vZ2OEGjFvRiDZlnd/RfKG7AThwSN7L1inFyOabE=;
  b=CftzDQ2plWDqNEYLurL+Z6xvrWEwBFRCWO8kiYBy5Iq5MvycRT1Lk2Od
   ccynVJY3QC1h8ugaIe8CSABDLAT65DBjaQhDYzO2eFmr7JjnWWaaHQbB5
   bTSm+17eKVC/Xx2LekDLv4scCTd5eA+I/L6yFu8G+t3D6OnAX8BtmP1Ob
   cUeZM1zo9dowXsKEVFqz87utaWBAtTtilfW/C0Sumbs1b8zXwe1uemaUK
   qPws5sFwPIOT8xAIVNg2pM3klKwTbzd1+yoeR1CgL8/DFgOG7cAksTppw
   uFkxV97YftpBtJOyEUMSNkQL1/LJN+qZZPu3fU6ZkLsPkTkfYZjEJoCmv
   w==;
X-CSE-ConnectionGUID: gPbpsHK6S1eV+zpxVRasfQ==
X-CSE-MsgGUID: XvsZFou9R+qyo19U8P9rtw==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="8468340"
X-IronPort-AV: E=Sophos;i="6.07,203,1708416000"; 
   d="scan'208";a="8468340"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 09:13:55 -0700
X-CSE-ConnectionGUID: r9v/WhZ6T22EvgOoCIENRw==
X-CSE-MsgGUID: 43M0YHyiRCK8MFjVlbeidw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,203,1708416000"; 
   d="scan'208";a="22050906"
Received: from unknown (HELO 23c141fc0fd8) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 15 Apr 2024 09:13:51 -0700
Received: from kbuild by 23c141fc0fd8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rwOxp-0004Nu-0J;
	Mon, 15 Apr 2024 16:13:49 +0000
Date: Tue, 16 Apr 2024 00:13:14 +0800
From: kernel test robot <lkp@intel.com>
To: Cristian Marussi <cristian.marussi@arm.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	sudeep.holla@arm.com, cristian.marussi@arm.com,
	jassisinghbrar@gmail.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	jonathan.cameron@huawei.com
Subject: Re: [PATCH v4 2/2] mailbox: arm_mhuv3: Add driver
Message-ID: <202404152338.axJTOvpQ-lkp@intel.com>
References: <20240412192801.554464-3-cristian.marussi@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412192801.554464-3-cristian.marussi@arm.com>

Hi Cristian,

kernel test robot noticed the following build warnings:

[auto build test WARNING on robh/for-next]
[also build test WARNING on soc/for-next linus/master v6.9-rc4 next-20240415]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Cristian-Marussi/dt-bindings-mailbox-arm-mhuv3-Add-bindings/20240415-094106
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20240412192801.554464-3-cristian.marussi%40arm.com
patch subject: [PATCH v4 2/2] mailbox: arm_mhuv3: Add driver
config: hexagon-allyesconfig (https://download.01.org/0day-ci/archive/20240415/202404152338.axJTOvpQ-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 8b3b4a92adee40483c27f26c478a384cd69c6f05)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240415/202404152338.axJTOvpQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404152338.axJTOvpQ-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/mailbox/arm_mhuv3.c:15:
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
   In file included from drivers/mailbox/arm_mhuv3.c:15:
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
   In file included from drivers/mailbox/arm_mhuv3.c:15:
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
>> drivers/mailbox/arm_mhuv3.c:374:2: warning: result of comparison of constant 18446744073709551615 with expression of type 'typeof (_Generic((_bmask), char: (unsigned char)0, unsigned char: (unsigned char)0, signed char: (unsigned char)0, unsigned short: (unsigned short)0, short: (unsigned short)0, unsigned int: (unsigned int)0, int: (unsigned int)0, unsigned long: (unsigned long)0, long: (unsigned long)0, unsigned long long: (unsigned long long)0, long long: (unsigned long long)0, default: (_bmask)))' (aka 'unsigned long') is always false [-Wtautological-constant-out-of-range-compare]
     374 |         writel_relaxed_bitmask(0x1, &mhu->pbx->dbcw[priv->ch_idx].int_en, tfr_ack);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/mailbox/arm_mhuv3.c:219:12: note: expanded from macro 'writel_relaxed_bitmask'
     219 |                 _rval |= FIELD_PREP(_bmask, _value);                    \
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:115:3: note: expanded from macro 'FIELD_PREP'
     115 |                 __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:72:53: note: expanded from macro '__BF_FIELD_CHECK'
      72 |                 BUILD_BUG_ON_MSG(__bf_cast_unsigned(_mask, _mask) >     \
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
      73 |                                  __bf_cast_unsigned(_reg, ~0ull),       \
         |                                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      74 |                                  _pfx "type of reg too small for mask"); \
         |                                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:449:22: note: expanded from macro 'compiletime_assert'
     449 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:437:23: note: expanded from macro '_compiletime_assert'
     437 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:429:9: note: expanded from macro '__compiletime_assert'
     429 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   drivers/mailbox/arm_mhuv3.c:384:2: warning: result of comparison of constant 18446744073709551615 with expression of type 'typeof (_Generic((_bmask), char: (unsigned char)0, unsigned char: (unsigned char)0, signed char: (unsigned char)0, unsigned short: (unsigned short)0, short: (unsigned short)0, unsigned int: (unsigned int)0, int: (unsigned int)0, unsigned long: (unsigned long)0, long: (unsigned long)0, unsigned long long: (unsigned long long)0, long long: (unsigned long long)0, default: (_bmask)))' (aka 'unsigned long') is always false [-Wtautological-constant-out-of-range-compare]
     384 |         writel_relaxed_bitmask(0x0, &mhu->pbx->dbcw[priv->ch_idx].int_en, tfr_ack);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/mailbox/arm_mhuv3.c:219:12: note: expanded from macro 'writel_relaxed_bitmask'
     219 |                 _rval |= FIELD_PREP(_bmask, _value);                    \
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:115:3: note: expanded from macro 'FIELD_PREP'
     115 |                 __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:72:53: note: expanded from macro '__BF_FIELD_CHECK'
      72 |                 BUILD_BUG_ON_MSG(__bf_cast_unsigned(_mask, _mask) >     \
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
      73 |                                  __bf_cast_unsigned(_reg, ~0ull),       \
         |                                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      74 |                                  _pfx "type of reg too small for mask"); \
         |                                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:449:22: note: expanded from macro 'compiletime_assert'
     449 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:437:23: note: expanded from macro '_compiletime_assert'
     437 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:429:9: note: expanded from macro '__compiletime_assert'
     429 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   drivers/mailbox/arm_mhuv3.c:387:2: warning: result of comparison of constant 18446744073709551615 with expression of type 'typeof (_Generic((_bmask), char: (unsigned char)0, unsigned char: (unsigned char)0, signed char: (unsigned char)0, unsigned short: (unsigned short)0, short: (unsigned short)0, unsigned int: (unsigned int)0, int: (unsigned int)0, unsigned long: (unsigned long)0, long: (unsigned long)0, unsigned long long: (unsigned long long)0, long long: (unsigned long long)0, default: (_bmask)))' (aka 'unsigned long') is always false [-Wtautological-constant-out-of-range-compare]
     387 |         writel_relaxed_bitmask(0x1, &mhu->pbx->dbcw[priv->ch_idx].int_clr, tfr_ack);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/mailbox/arm_mhuv3.c:219:12: note: expanded from macro 'writel_relaxed_bitmask'
     219 |                 _rval |= FIELD_PREP(_bmask, _value);                    \
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:115:3: note: expanded from macro 'FIELD_PREP'
     115 |                 __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:72:53: note: expanded from macro '__BF_FIELD_CHECK'
      72 |                 BUILD_BUG_ON_MSG(__bf_cast_unsigned(_mask, _mask) >     \
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
      73 |                                  __bf_cast_unsigned(_reg, ~0ull),       \
         |                                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      74 |                                  _pfx "type of reg too small for mask"); \
         |                                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:449:22: note: expanded from macro 'compiletime_assert'
     449 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:437:23: note: expanded from macro '_compiletime_assert'
     437 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:429:9: note: expanded from macro '__compiletime_assert'
     429 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   drivers/mailbox/arm_mhuv3.c:579:4: warning: result of comparison of constant 18446744073709551615 with expression of type 'typeof (_Generic((_bmask), char: (unsigned char)0, unsigned char: (unsigned char)0, signed char: (unsigned char)0, unsigned short: (unsigned short)0, short: (unsigned short)0, unsigned int: (unsigned int)0, int: (unsigned int)0, unsigned long: (unsigned long)0, long: (unsigned long)0, unsigned long long: (unsigned long long)0, long long: (unsigned long long)0, default: (_bmask)))' (aka 'unsigned long') is always false [-Wtautological-constant-out-of-range-compare]
     579 |                         writel_relaxed_bitmask(0x1, &dbcw[i].int_clr, tfr_ack);
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/mailbox/arm_mhuv3.c:219:12: note: expanded from macro 'writel_relaxed_bitmask'
     219 |                 _rval |= FIELD_PREP(_bmask, _value);                    \
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:115:3: note: expanded from macro 'FIELD_PREP'
     115 |                 __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:72:53: note: expanded from macro '__BF_FIELD_CHECK'
      72 |                 BUILD_BUG_ON_MSG(__bf_cast_unsigned(_mask, _mask) >     \
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
      73 |                                  __bf_cast_unsigned(_reg, ~0ull),       \
         |                                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      74 |                                  _pfx "type of reg too small for mask"); \
         |                                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:449:22: note: expanded from macro 'compiletime_assert'
     449 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:437:23: note: expanded from macro '_compiletime_assert'
     437 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +374 drivers/mailbox/arm_mhuv3.c

   368	
   369	static void mhuv3_doorbell_tx_startup(struct mhuv3 *mhu, struct mbox_chan *chan)
   370	{
   371		struct mhuv3_mbox_chan_priv *priv = chan->con_priv;
   372	
   373		/* Enable Transfer Acknowledgment events */
 > 374		writel_relaxed_bitmask(0x1, &mhu->pbx->dbcw[priv->ch_idx].int_en, tfr_ack);
   375	}
   376	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

