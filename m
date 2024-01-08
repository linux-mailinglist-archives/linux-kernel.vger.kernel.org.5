Return-Path: <linux-kernel+bounces-20169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76BF4827B4A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 00:07:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 544351C22D93
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 23:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A8454BE8;
	Mon,  8 Jan 2024 23:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m+8Ur2ir"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA5A46556
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 23:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704755236; x=1736291236;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=MPuGkQ47lwZWSNh2DxTeXV6pTB57JtfH43mk/yL4O2M=;
  b=m+8Ur2irxogltJamrArWYlU0K/F0MIX/yHnb1ziX/kemUsYwvzoR9rVz
   yx47YocCIcXLrl+aJ3wP1ZD44hwz1mhGi5/u1HSroC3Sh4A+B13CJszf8
   PZZ9DJGQ/PV3GvrS5+lXdhlpden0ng6a9oh+RRjxhl1a4q1+v3FtmKVJZ
   RgOiAEEw6L/KP6fvjqUhNhUKBXBnr6wM9VHIuJ3JFD7BblQJBMNW6M+Oq
   21SsFY4hTL2aHTo6RSFRzbratRdjxKm0qzcr/t417MV4Vc4dHfJxYLeKn
   m3WMwE2VGHOEn9xuosFdxyIficDD2my6ABJysEm6RilkXjRtIWXr/QlgB
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="388467287"
X-IronPort-AV: E=Sophos;i="6.04,181,1695711600"; 
   d="scan'208";a="388467287"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 15:07:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="781575429"
X-IronPort-AV: E=Sophos;i="6.04,181,1695711600"; 
   d="scan'208";a="781575429"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 08 Jan 2024 15:07:12 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rMyi6-0005DI-29;
	Mon, 08 Jan 2024 23:07:10 +0000
Date: Tue, 9 Jan 2024 07:06:12 +0800
From: kernel test robot <lkp@intel.com>
To: Robert Elliott <elliott@hpe.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: arch/arm/crypto/sha512-glue.c:34:3: warning: cast from 'void (*)(u64
 *, const u8 *, int)' (aka 'void (*)(unsigned long long *, const unsigned
 char *, int)') to 'sha512_block_fn *' (aka 'void (*)(struct sha512_state *,
 const unsigned char *, int)') convert...
Message-ID: <202401090628.aXpavLWp-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Robert,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5db8752c3b81bd33a549f6f812bab81e3bb61b20
commit: 4a329fecc9aaebb27a53fa7abfa53bbc2ee42f3f crypto: Kconfig - submenus for arm and arm64
date:   1 year, 4 months ago
config: arm-randconfig-003-20240107 (https://download.01.org/0day-ci/archive/20240109/202401090628.aXpavLWp-lkp@intel.com/config)
compiler: clang version 18.0.0git (https://github.com/llvm/llvm-project 7e186d366d6c7def0543acc255931f617e76dff0)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240109/202401090628.aXpavLWp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401090628.aXpavLWp-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> arch/arm/crypto/sha512-glue.c:34:3: warning: cast from 'void (*)(u64 *, const u8 *, int)' (aka 'void (*)(unsigned long long *, const unsigned char *, int)') to 'sha512_block_fn *' (aka 'void (*)(struct sha512_state *, const unsigned char *, int)') converts to incompatible function type [-Wcast-function-type-strict]
      34 |                 (sha512_block_fn *)sha512_block_data_order);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/arm/crypto/sha512-glue.c:40:3: warning: cast from 'void (*)(u64 *, const u8 *, int)' (aka 'void (*)(unsigned long long *, const unsigned char *, int)') to 'sha512_block_fn *' (aka 'void (*)(struct sha512_state *, const unsigned char *, int)') converts to incompatible function type [-Wcast-function-type-strict]
      40 |                 (sha512_block_fn *)sha512_block_data_order);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/arm/crypto/sha512-glue.c:48:3: warning: cast from 'void (*)(u64 *, const u8 *, int)' (aka 'void (*)(unsigned long long *, const unsigned char *, int)') to 'sha512_block_fn *' (aka 'void (*)(struct sha512_state *, const unsigned char *, int)') converts to incompatible function type [-Wcast-function-type-strict]
      48 |                 (sha512_block_fn *)sha512_block_data_order);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   3 warnings generated.


vim +34 arch/arm/crypto/sha512-glue.c

c80ae7ca372606a Ard Biesheuvel 2015-05-08  29  
c80ae7ca372606a Ard Biesheuvel 2015-05-08  30  int sha512_arm_update(struct shash_desc *desc, const u8 *data,
c80ae7ca372606a Ard Biesheuvel 2015-05-08  31  		      unsigned int len)
c80ae7ca372606a Ard Biesheuvel 2015-05-08  32  {
c80ae7ca372606a Ard Biesheuvel 2015-05-08  33  	return sha512_base_do_update(desc, data, len,
c80ae7ca372606a Ard Biesheuvel 2015-05-08 @34  		(sha512_block_fn *)sha512_block_data_order);
c80ae7ca372606a Ard Biesheuvel 2015-05-08  35  }
c80ae7ca372606a Ard Biesheuvel 2015-05-08  36  

:::::: The code at line 34 was first introduced by commit
:::::: c80ae7ca372606a3971dcdfa3420275cf17ef6b6 crypto: arm/sha512 - accelerated SHA-512 using ARM generic ASM and NEON

:::::: TO: Ard Biesheuvel <ard.biesheuvel@linaro.org>
:::::: CC: Herbert Xu <herbert@gondor.apana.org.au>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

