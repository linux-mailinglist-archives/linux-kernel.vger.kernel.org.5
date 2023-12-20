Return-Path: <linux-kernel+bounces-6283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A2018196BB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 03:13:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D5261C21558
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 02:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEEF2846B;
	Wed, 20 Dec 2023 02:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DH+asZcf"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0CA8BF9
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 02:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703038381; x=1734574381;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=qvElR0VuNTsTCRh739xalK/xA37rYZ++RNiKjcrnyYQ=;
  b=DH+asZcfHMAu1yyOk46CtiE+kIuViTl/uL6+qpmQqPkcNz6zE64/BmgY
   OvompPKrtBMXsgBcQggd66tdPknYuuu7lsohGvo2Rr+Dx+OkyrppHo2X7
   vDBivj1vAGTFr2IoBkzG8bgqZZb03ro+/n1uJ/w+nk3EISr/oinEeQxsE
   K4GWEOX+iiTEJA6J+QSFI0GAFNyHD5exelOZinLwO697vq2Xt0b5hZTZA
   pc/KmYdJRaa+ZKXrXfOTy/CUsZ4rmtew7lj3n5xbYkkgn0M8t4EdlwmKD
   s8mgPsP7IjzX5wUQfXZQh8Y9u0SfFvDc0696Tr4c/rJJb0OGSbwMPljFv
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="9211884"
X-IronPort-AV: E=Sophos;i="6.04,290,1695711600"; 
   d="scan'208";a="9211884"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 18:13:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="1023328218"
X-IronPort-AV: E=Sophos;i="6.04,290,1695711600"; 
   d="scan'208";a="1023328218"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 19 Dec 2023 18:12:57 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rFm4r-0006DF-2Z;
	Wed, 20 Dec 2023 02:12:53 +0000
Date: Wed, 20 Dec 2023 10:12:47 +0800
From: kernel test robot <lkp@intel.com>
To: Marco Elver <elver@google.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: /bin/bash: line 1:  9839 Segmentation fault
      LLVM_OBJCOPY="llvm-objcopy" pahole -J --btf_gen_floats -j
 --lang_exclude=rust --skip_encoding_btf_inconsistent_proto
 --btf_gen_optimized --btf_base vmlinux drivers/media/i2c/s5c73m3/s5c73m3.ko
Message-ID: <202312201039.FtWl6EvV-lkp@intel.com>
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
commit: aebc7b0d8d91bbc69e976909963046bc48bca4fd list: Introduce CONFIG_LIST_HARDENED
date:   4 months ago
config: hexagon-randconfig-r021-20220917 (https://download.01.org/0day-ci/archive/20231220/202312201039.FtWl6EvV-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231220/202312201039.FtWl6EvV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312201039.FtWl6EvV-lkp@intel.com/

All errors (new ones prefixed by >>):

   die__process_unit: DW_TAG_member (0xd) @ <0x12b7b> not handled!
   die__process_unit: tag not supported 0xd (member)!
   die__process: got compile_unit unexpected tag after DW_TAG_compile_unit!
   die__process_unit: DW_TAG_member (0xd) @ <0x33951> not handled!
   die__process: got compile_unit unexpected tag after DW_TAG_compile_unit!
>> /bin/bash: line 1:  9839 Segmentation fault      LLVM_OBJCOPY="llvm-objcopy" pahole -J --btf_gen_floats -j --lang_exclude=rust --skip_encoding_btf_inconsistent_proto --btf_gen_optimized --btf_base vmlinux drivers/media/i2c/s5c73m3/s5c73m3.ko

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

