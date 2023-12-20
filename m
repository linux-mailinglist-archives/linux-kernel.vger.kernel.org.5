Return-Path: <linux-kernel+bounces-7214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A6281A351
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 16:57:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7455B230EA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 15:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B498E4176B;
	Wed, 20 Dec 2023 15:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N7ZSy2ad"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05BB41212
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 15:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703087809; x=1734623809;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=UyqkERrebNXCWciZ0CD17kB1QTehp07FvEacc4l/nlo=;
  b=N7ZSy2adRxYkgQ25scBN5YGtpBCd6uQbyX+KTXhjH5CTKvCqIDGulDJp
   4UcACMixEg8HUsSiw2mDXPu45XNxjEehYXwDuLs3c+ecEcCnNjJapW+9Q
   sGY9sGk00w6JoXqkT53vN3ISvaCiLAyXz9XhO67v8yUmD7yTHSjENoaB8
   50k+cyWts7WmOEOeBiIQob/o3CMseTQ5ZxYk14m8QZWJueYb0hlRclv9G
   HiKaUaLZ3i2nLEgWPY3YYWIn/dLZz1/VpAba9rPtN/ktJwIlamfrTiMix
   d3oSRnKsNpkIqYrhF5WMjJWPVS3bjbZ/PetxgMBwXkGf/MNkBIlYtIKoP
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="17387097"
X-IronPort-AV: E=Sophos;i="6.04,291,1695711600"; 
   d="scan'208";a="17387097"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 07:56:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="1023511515"
X-IronPort-AV: E=Sophos;i="6.04,291,1695711600"; 
   d="scan'208";a="1023511515"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 20 Dec 2023 07:56:46 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rFyw6-000781-2z;
	Wed, 20 Dec 2023 15:56:43 +0000
Date: Wed, 20 Dec 2023 23:56:13 +0800
From: kernel test robot <lkp@intel.com>
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/mtd/chips/cfi_util.o:(.xiptext+0x32): dangerous relocation:
 windowed longcall crosses 1GB boundary; return may fail: __tsan_func_entry
Message-ID: <202312202322.pnefvRhA-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   55cb5f43689d7a9ea5bf35ef050f12334f197347
commit: 03ce34cf8f50e4c62f9a4b62caffdba1165ca977 xtensa: add XIP-aware MTD support
date:   4 months ago
config: xtensa-randconfig-r016-20230707 (https://download.01.org/0day-ci/archive/20231220/202312202322.pnefvRhA-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231220/202312202322.pnefvRhA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312202322.pnefvRhA-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/mtd/chips/cfi_util.o:(.xiptext+0x32): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_func_entry
>> drivers/mtd/chips/cfi_util.o:(.xiptext+0x3a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_util.o:(.xiptext+0x44): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_util.o: in function `cfi_qry_present':
>> cfi_util.c:(.xiptext+0x56): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   cfi_util.c:(.xiptext+0x64): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   cfi_util.c:(.xiptext+0x74): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
>> cfi_util.c:(.xiptext+0x7e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_util.c:(.xiptext+0x8e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
>> cfi_util.c:(.xiptext+0x9f): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_volatile_read1
   cfi_util.c:(.xiptext+0xac): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_volatile_read1
   cfi_util.c:(.xiptext+0xbe): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_volatile_read1
>> cfi_util.c:(.xiptext+0xdb): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_volatile_read2
   cfi_util.c:(.xiptext+0xe8): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_volatile_read2
   cfi_util.c:(.xiptext+0xfa): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_volatile_read2
>> cfi_util.c:(.xiptext+0x116): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_volatile_read4
   cfi_util.c:(.xiptext+0x126): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_volatile_read4
   cfi_util.c:(.xiptext+0x130): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_volatile_read4
>> cfi_util.c:(.xiptext+0x15a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_func_exit
>> cfi_util.c:(.xiptext+0x186): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_func_entry
   cfi_util.c:(.xiptext+0x190): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
>> cfi_util.c:(.xiptext+0x1a7): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   cfi_util.c:(.xiptext+0x1af): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_util.c:(.xiptext+0x1c4): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   cfi_util.c:(.xiptext+0x1df): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_util.c:(.xiptext+0x1f4): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   cfi_util.c:(.xiptext+0x1fc): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_util.c:(.xiptext+0x212): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   cfi_util.c:(.xiptext+0x21a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_util.o: in function `cfi_qry_mode_on':
   cfi_util.c:(.xiptext+0x22f): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   cfi_util.c:(.xiptext+0x246): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_util.c:(.xiptext+0x25c): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   cfi_util.c:(.xiptext+0x264): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_util.c:(.xiptext+0x27a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   cfi_util.c:(.xiptext+0x290): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_util.c:(.xiptext+0x2a6): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   cfi_util.c:(.xiptext+0x2ae): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_util.c:(.xiptext+0x2c4): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   cfi_util.c:(.xiptext+0x2cc): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_util.c:(.xiptext+0x2e2): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   cfi_util.c:(.xiptext+0x2ea): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_util.c:(.xiptext+0x300): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   cfi_util.c:(.xiptext+0x317): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_util.c:(.xiptext+0x32c): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   cfi_util.c:(.xiptext+0x334): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_util.c:(.xiptext+0x34b): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   cfi_util.c:(.xiptext+0x353): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_util.c:(.xiptext+0x368): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   cfi_util.c:(.xiptext+0x370): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_util.c:(.xiptext+0x386): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   cfi_util.c:(.xiptext+0x39a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_func_exit
   cfi_util.c:(.xiptext+0x3be): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_func_entry
   cfi_util.c:(.xiptext+0x3c8): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_util.c:(.xiptext+0x3df): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   cfi_util.c:(.xiptext+0x3e7): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_util.c:(.xiptext+0x3ff): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   cfi_util.c:(.xiptext+0x408): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_util.c:(.xiptext+0x416): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_util.c:(.xiptext+0x437): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_util.c:(.xiptext+0x44e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   cfi_util.c:(.xiptext+0x454): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_func_exit
   drivers/mtd/chips/cfi_util.o: in function `cfi_qry_mode_off':
   cfi_util.c:(.xiptext+0x48a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_func_entry
   cfi_util.c:(.xiptext+0x493): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_util.c:(.xiptext+0x4a0): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_util.c:(.xiptext+0x4ac): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
>> cfi_util.c:(.xiptext+0x4cb): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _printk
>> cfi_util.c:(.xiptext+0x4d6): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __kmalloc
   cfi_util.c:(.xiptext+0x514): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_util.c:(.xiptext+0x520): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
>> cfi_util.c:(.xiptext+0x52c): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.text+0x5a8)
   cfi_util.c:(.xiptext+0x538): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_util.c:(.xiptext+0x54e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_util.o: in function `cfi_read_pri':
>> cfi_util.c:(.xiptext+0x5a3): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write1
   cfi_util.c:(.xiptext+0x5c8): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_util.c:(.xiptext+0x5d2): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_util.c:(.xiptext+0x5de): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.text+0x5a8)
   cfi_util.c:(.xiptext+0x5e7): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_func_exit
   drivers/mtd/chips/cfi_cmdset_0020.o: in function `cfi_staa_setup':
>> cfi_cmdset_0020.c:(.text+0xa93): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_read_pri
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `fixup_convert_atmel_pri':
>> cfi_cmdset_0002.c:(.text+0xef3): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_read_pri
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `cfi_amdstd_resume':
>> cfi_cmdset_0002.c:(.text+0x1f17): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.xiptext+0x238)
   cfi_cmdset_0002.c:(.text+0x1fbc): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.xiptext+0x238)
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `do_read_secsi_onechip':
   cfi_cmdset_0002.c:(.text+0x2268): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.xiptext+0x238)
   cfi_cmdset_0002.c:(.text+0x227b): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.xiptext+0x238)
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `cfi_fixup_m29ew_erase_suspend':
   cfi_cmdset_0002.c:(.text+0x25ec): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.xiptext+0x238)
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `cfi_amdstd_panic_wait':
   cfi_cmdset_0002.c:(.text+0x275a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.xiptext+0x238)
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `put_chip.isra.0':
>> cfi_cmdset_0002.c:(.text+0x2eb2): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_qry_mode_on
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `get_chip':
>> cfi_cmdset_0002.c:(.text+0x2f80): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_qry_mode_off
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `fwh_xxlock_oneblock':
   cfi_cmdset_0002.c:(.text+0x3a14): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.xiptext+0xc20)
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `cfi_amdstd_otp_walk':
   cfi_cmdset_0002.c:(.text+0x3d3c): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.xiptext+0x1854)
   cfi_cmdset_0002.c:(.text+0x404c): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.xiptext+0x238)
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `cfi_amdstd_lock_user_prot_reg':
   cfi_cmdset_0002.c:(.text+0x4084): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.xiptext+0x71c)
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `cfi_amdstd_read':
   cfi_cmdset_0002.c:(.text+0x440f): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.xiptext+0x1854)
   cfi_cmdset_0002.c:(.text+0x4523): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.xiptext+0x1854)
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `cfi_amdstd_destroy':
   cfi_cmdset_0002.c:(.text+0x471c): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.xiptext+0x1854)
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `cfi_amdstd_erase_chip':
   cfi_cmdset_0002.c:(.text+0x48cb): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.xiptext+0x1e80)
>> drivers/mtd/chips/cfi_cmdset_0002.o:(.xiptext+0x16): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_func_entry
   drivers/mtd/chips/cfi_cmdset_0002.o:(.xiptext+0x24): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.o:(.xiptext+0x2e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `do_write_buffer_reset':
   cfi_cmdset_0002.c:(.xiptext+0x3c): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_cmdset_0002.c:(.xiptext+0x53): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   cfi_cmdset_0002.c:(.xiptext+0x5c): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_cmdset_0002.c:(.xiptext+0x66): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_cmdset_0002.c:(.xiptext+0x72): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_cmdset_0002.c:(.xiptext+0x86): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   cfi_cmdset_0002.c:(.xiptext+0x8e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_cmdset_0002.c:(.xiptext+0x98): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_cmdset_0002.c:(.xiptext+0xa2): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_cmdset_0002.c:(.xiptext+0xb7): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   cfi_cmdset_0002.c:(.xiptext+0xbd): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_func_exit
   cfi_cmdset_0002.c:(.xiptext+0xf2): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_func_entry
   cfi_cmdset_0002.c:(.xiptext+0xfb): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_cmdset_0002.c:(.xiptext+0x107): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_cmdset_0002.c:(.xiptext+0x12a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   cfi_cmdset_0002.c:(.xiptext+0x138): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `xip_enable':
   cfi_cmdset_0002.c:(.xiptext+0x148): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_cmdset_0002.c:(.xiptext+0x162): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_volatile_write1
   cfi_cmdset_0002.c:(.xiptext+0x186): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_volatile_write2
   cfi_cmdset_0002.c:(.xiptext+0x1a3): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_volatile_write4
   cfi_cmdset_0002.c:(.xiptext+0x1bb): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_atomic_signal_fence
   cfi_cmdset_0002.c:(.xiptext+0x1c6): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   cfi_cmdset_0002.c:(.xiptext+0x1d2): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_cmdset_0002.c:(.xiptext+0x1dc): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_cmdset_0002.c:(.xiptext+0x1eb): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_volatile_read1
   cfi_cmdset_0002.c:(.xiptext+0x1ff): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_volatile_read2
   cfi_cmdset_0002.c:(.xiptext+0x213): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_volatile_read4
   cfi_cmdset_0002.c:(.xiptext+0x226): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_func_exit
   cfi_cmdset_0002.c:(.xiptext+0x24a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_func_entry
   cfi_cmdset_0002.c:(.xiptext+0x253): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_cmdset_0002.c:(.xiptext+0x25e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_cmdset_0002.c:(.xiptext+0x26b): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read1
   cfi_cmdset_0002.c:(.xiptext+0x27c): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read1
   cfi_cmdset_0002.c:(.xiptext+0x293): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   cfi_cmdset_0002.c:(.xiptext+0x29e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_cmdset_0002.c:(.xiptext+0x2a8): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_cmdset_0002.c:(.xiptext+0x2b3): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_cmdset_0002.c:(.xiptext+0x2cb): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   cfi_cmdset_0002.c:(.xiptext+0x2d3): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_cmdset_0002.c:(.xiptext+0x2de): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_cmdset_0002.c:(.xiptext+0x2ef): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_cmdset_0002.c:(.xiptext+0x2fa): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `chip_ready':
   cfi_cmdset_0002.c:(.xiptext+0x30e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_volatile_read1
   cfi_cmdset_0002.c:(.xiptext+0x326): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_volatile_read2
   cfi_cmdset_0002.c:(.xiptext+0x33c): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_volatile_read4
   cfi_cmdset_0002.c:(.xiptext+0x35f): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_volatile_read1
   cfi_cmdset_0002.c:(.xiptext+0x36a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_volatile_read1
   cfi_cmdset_0002.c:(.xiptext+0x383): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_volatile_read2
   cfi_cmdset_0002.c:(.xiptext+0x38e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_volatile_read2
   cfi_cmdset_0002.c:(.xiptext+0x3a8): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_volatile_read4
   cfi_cmdset_0002.c:(.xiptext+0x3b2): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_volatile_read4
   cfi_cmdset_0002.c:(.xiptext+0x3ca): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_cmdset_0002.c:(.xiptext+0x3e0): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_func_exit
   cfi_cmdset_0002.c:(.xiptext+0x3fe): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_func_entry
   cfi_cmdset_0002.c:(.xiptext+0x407): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_cmdset_0002.c:(.xiptext+0x412): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_cmdset_0002.c:(.xiptext+0x42f): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_func_exit
   cfi_cmdset_0002.c:(.xiptext+0x456): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_func_entry
   cfi_cmdset_0002.c:(.xiptext+0x467): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_cmdset_0002.c:(.xiptext+0x474): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_cmdset_0002.c:(.xiptext+0x486): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_cmdset_0002.c:(.xiptext+0x490): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_cmdset_0002.c:(.xiptext+0x4a0): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_cmdset_0002.c:(.xiptext+0x4b7): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   cfi_cmdset_0002.c:(.xiptext+0x4c0): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `chip_good':
   cfi_cmdset_0002.c:(.xiptext+0x4ca): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_cmdset_0002.c:(.xiptext+0x4d6): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_cmdset_0002.c:(.xiptext+0x4ea): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   cfi_cmdset_0002.c:(.xiptext+0x4f2): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_cmdset_0002.c:(.xiptext+0x4fc): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_cmdset_0002.c:(.xiptext+0x508): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_cmdset_0002.c:(.xiptext+0x51e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   cfi_cmdset_0002.c:(.xiptext+0x526): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_cmdset_0002.c:(.xiptext+0x532): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_cmdset_0002.c:(.xiptext+0x53c): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_cmdset_0002.c:(.xiptext+0x552): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   cfi_cmdset_0002.c:(.xiptext+0x55b): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_cmdset_0002.c:(.xiptext+0x567): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_cmdset_0002.c:(.xiptext+0x57a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `do_write_oneword_done':
   cfi_cmdset_0002.c:(.xiptext+0x587): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_cmdset_0002.c:(.xiptext+0x59e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.text+0x2390)
   cfi_cmdset_0002.c:(.xiptext+0x5a7): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_unlock
   cfi_cmdset_0002.c:(.xiptext+0x5ad): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_func_exit
   cfi_cmdset_0002.c:(.xiptext+0x5d6): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_func_entry
   cfi_cmdset_0002.c:(.xiptext+0x5e4): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_lock_nested
   cfi_cmdset_0002.c:(.xiptext+0x5f4): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.text+0x2534)
   cfi_cmdset_0002.c:(.xiptext+0x602): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_unlock
   cfi_cmdset_0002.c:(.xiptext+0x617): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_cmdset_0002.c:(.xiptext+0x624): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_cmdset_0002.c:(.xiptext+0x634): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_cmdset_0002.c:(.xiptext+0x63e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_cmdset_0002.c:(.xiptext+0x64e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   cfi_cmdset_0002.c:(.xiptext+0x663): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

