Return-Path: <linux-kernel+bounces-10071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B50181CF94
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 22:55:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFCA41F24235
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 21:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 013292EAED;
	Fri, 22 Dec 2023 21:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jF1eNvYd"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1CD2E85F
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 21:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703282124; x=1734818124;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=aM5EjOg2Dh/MqhAoSxZw1m8rKaMc5thhLNNVopNH6sw=;
  b=jF1eNvYd5g+Wj/MRkxwH6BoamQDgDjpA2rhWWARE39LW4FhDZbW60kI/
   2FCxKlkVZc/A9oipkg68dhbgTtHbULjDdxeBjam8EdlJJw3KYJvALfIHx
   2SEs0XTQy1Z7ZrKZs4qr0z6D61IMsoEiF2PJ2InQJjUGxB0/WGtJkq4DQ
   bfS2fklTZIHi9wvRyLI5PCNkpC6AAR2YiBXtMmibrtzEBBIBLt5fsAK2s
   xChXGsSfTHwS1J7I6NPbOV5I2YhcgS4cqHO5b4OQLbDc7PM6IlxXZFgZr
   F4OnCIxD0WY/V4lbw/N9pt1wS3Dn83Nqh0ZYgXUba8ee3EC53FiFX6+M9
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="386589103"
X-IronPort-AV: E=Sophos;i="6.04,297,1695711600"; 
   d="scan'208";a="386589103"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 13:55:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="900520782"
X-IronPort-AV: E=Sophos;i="6.04,297,1695711600"; 
   d="scan'208";a="900520782"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 22 Dec 2023 13:55:21 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rGnT0-0009uD-1k;
	Fri, 22 Dec 2023 21:54:28 +0000
Date: Sat, 23 Dec 2023 05:54:02 +0800
From: kernel test robot <lkp@intel.com>
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: cfi_probe.c:(.xiptext+0x6f): dangerous relocation: windowed longcall
 crosses 1GB boundary; return may fail: __kmalloc
Message-ID: <202312230505.kAgJr7BM-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5414aea7b7508d01235ea0c95064ad66395c3239
commit: 03ce34cf8f50e4c62f9a4b62caffdba1165ca977 xtensa: add XIP-aware MTD support
date:   4 months ago
config: xtensa-randconfig-m031-20220228 (https://download.01.org/0day-ci/archive/20231223/202312230505.kAgJr7BM-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231223/202312230505.kAgJr7BM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312230505.kAgJr7BM-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/mtd/chips/cfi_probe.o: in function `cfi_chip_setup':
>> cfi_probe.c:(.xiptext+0x6f): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __kmalloc
>> cfi_probe.c:(.xiptext+0x7e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: memset
>> cfi_probe.c:(.xiptext+0x8e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
>> cfi_probe.c:(.xiptext+0x20e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   cfi_probe.c:(.xiptext+0x223): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   cfi_probe.c:(.xiptext+0x237): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   cfi_probe.c:(.xiptext+0x24c): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
>> cfi_probe.c:(.xiptext+0x2b6): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.text.unlikely+0x4)
>> cfi_probe.c:(.xiptext+0x2d7): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _printk
   cfi_probe.c:(.xiptext+0x303): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _printk
   cfi_probe.c:(.xiptext+0x31c): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _printk
   drivers/mtd/chips/cfi_probe.o: in function `cfi_probe_chip':
   cfi_probe.c:(.xiptext+0x3e6): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _printk
   cfi_probe.c:(.xiptext+0x44b): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _printk
   drivers/mtd/chips/cfi_util.o: in function `cfi_qry_present':
   cfi_util.c:(.xiptext+0x10): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   cfi_util.c:(.xiptext+0x20): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   cfi_util.c:(.xiptext+0x2e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   cfi_util.c:(.xiptext+0x86): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_util.o: in function `cfi_qry_mode_off':
   cfi_util.c:(.xiptext+0xa0): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   cfi_util.c:(.xiptext+0xdb): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   cfi_util.c:(.xiptext+0xfc): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   cfi_util.c:(.xiptext+0x128): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_util.o: in function `cfi_qry_mode_on':
   cfi_util.c:(.xiptext+0x154): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   cfi_util.c:(.xiptext+0x170): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   cfi_util.c:(.xiptext+0x19c): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   cfi_util.c:(.xiptext+0x1c2): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   cfi_util.c:(.xiptext+0x1f0): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   cfi_util.c:(.xiptext+0x216): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   cfi_util.c:(.xiptext+0x246): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   cfi_util.c:(.xiptext+0x27c): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   cfi_util.c:(.xiptext+0x2ac): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   cfi_util.c:(.xiptext+0x2d2): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   cfi_util.c:(.xiptext+0x300): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   cfi_util.c:(.xiptext+0x334): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   cfi_util.c:(.xiptext+0x362): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   cfi_util.c:(.xiptext+0x3b2): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _printk
   cfi_util.c:(.xiptext+0x3be): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __kmalloc
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `fixup_convert_atmel_pri':
   cfi_cmdset_0002.c:(.text+0x757): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.xiptext+0x80)
   cfi_cmdset_0002.c:(.text+0x796): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.xiptext+0x80)
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `do_panic_write_oneword':
   cfi_cmdset_0002.c:(.text+0x884): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.xiptext+0x80)
   cfi_cmdset_0002.c:(.text+0x897): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.xiptext+0x80)
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `cfi_fixup_m29ew_erase_suspend':
   cfi_cmdset_0002.c:(.text+0xb38): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.xiptext+0x80)
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `put_chip.isra.0':
   cfi_cmdset_0002.c:(.text+0xbfb): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.xiptext+0x80)
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `get_chip':
   cfi_cmdset_0002.c:(.text+0xd13): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.xiptext+0x7b4)
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `do_atmel_lock':
   cfi_cmdset_0002.c:(.text+0x1030): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.xiptext+0x80)
   cfi_cmdset_0002.c:(.text+0x105c): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.xiptext+0x148)
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `fwh_xxlock_oneblock':
   cfi_cmdset_0002.c:(.text+0x1150): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_qry_mode_on
   cfi_cmdset_0002.c:(.text+0x116f): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_qry_mode_off
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `cfi_amdstd_otp_walk':
   cfi_cmdset_0002.c:(.text+0x1426): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.xiptext+0x814)
   cfi_cmdset_0002.c:(.text+0x1597): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.xiptext+0x80)
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `cfi_amdstd_lock_user_prot_reg':
   cfi_cmdset_0002.c:(.text+0x15c2): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.xiptext+0x148)
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `cfi_amdstd_reboot':
   cfi_cmdset_0002.c:(.text+0x1d07): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.xiptext+0x7b4)
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `cfi_amdstd_secsi_read':
   cfi_cmdset_0002.c:(.text+0x1da3): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.xiptext+0xa90)
   cfi_cmdset_0002.c:(.text+0x1e1a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.xiptext+0x7b4)
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `cfi_amdstd_write_buffers':
   cfi_cmdset_0002.c:(.text+0x2100): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_read_pri
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `xip_enable':
   cfi_cmdset_0002.c:(.xiptext+0x13): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `do_write_buffer_reset':
   cfi_cmdset_0002.c:(.xiptext+0x4c): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   cfi_cmdset_0002.c:(.xiptext+0x60): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   cfi_cmdset_0002.c:(.xiptext+0x76): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `chip_ready':
   cfi_cmdset_0002.c:(.xiptext+0xa3): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   cfi_cmdset_0002.c:(.xiptext+0xbe): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `chip_good':
   cfi_cmdset_0002.c:(.xiptext+0x167): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `xip_udelay':
   cfi_cmdset_0002.c:(.xiptext+0x1d2): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   cfi_cmdset_0002.c:(.xiptext+0x226): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   cfi_cmdset_0002.c:(.xiptext+0x25b): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   cfi_cmdset_0002.c:(.xiptext+0x282): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_unlock
   cfi_cmdset_0002.c:(.xiptext+0x28e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_lock_nested
   cfi_cmdset_0002.c:(.xiptext+0x2e2): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.text+0x9f8)
   cfi_cmdset_0002.c:(.xiptext+0x32a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: add_wait_queue
   cfi_cmdset_0002.c:(.xiptext+0x332): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_unlock
   cfi_cmdset_0002.c:(.xiptext+0x338): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: schedule
   cfi_cmdset_0002.c:(.xiptext+0x342): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: remove_wait_queue
   cfi_cmdset_0002.c:(.xiptext+0x34c): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_lock_nested
   cfi_cmdset_0002.c:(.xiptext+0x3b0): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __usecs_to_jiffies
   cfi_cmdset_0002.c:(.xiptext+0x3ea): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: add_wait_queue
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `do_write_buffer_wait':
   cfi_cmdset_0002.c:(.xiptext+0x3f7): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_unlock
   cfi_cmdset_0002.c:(.xiptext+0x3fd): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: schedule
   cfi_cmdset_0002.c:(.xiptext+0x407): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: remove_wait_queue
   cfi_cmdset_0002.c:(.xiptext+0x41a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_lock_nested
   cfi_cmdset_0002.c:(.xiptext+0x446): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _printk
   cfi_cmdset_0002.c:(.xiptext+0x468): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.text+0x590)
   cfi_cmdset_0002.c:(.xiptext+0x4a2): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   cfi_cmdset_0002.c:(.xiptext+0x4b8): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   cfi_cmdset_0002.c:(.xiptext+0x4cf): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `do_write_oneword_once':
   cfi_cmdset_0002.c:(.xiptext+0x527): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: add_wait_queue
   cfi_cmdset_0002.c:(.xiptext+0x536): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_unlock
   cfi_cmdset_0002.c:(.xiptext+0x53c): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: schedule

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

