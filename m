Return-Path: <linux-kernel+bounces-2775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3428981619B
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 19:30:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F14851C20D1B
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 18:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F4B44C94;
	Sun, 17 Dec 2023 18:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XOrYH5Yi"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147BB1E48B
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 18:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702837846; x=1734373846;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=by/dL7dQE84EI9OYlQVp92Qg861Ot5z0iA8WImFud4Y=;
  b=XOrYH5YiMEChINLuqIYifVHbp6BC6+UqOZX+XAfjKb1T9p/elGAXUXkV
   V1ksa25Bc6k4YIL6qYRXZKTlrZAhXGDsoi/g9YCRxaAqzlKlfRxBnKO9s
   WuO4eMfenGUarEUIR+Br6CPNZjFDyZpMm7QXV+UkET3EOgYA7PRsv/H3S
   Olel+msMd/Y24qRQasnR5N4D1taccdph14Okl1Zc3J1Zs2efIcUzAV7no
   GjkRev15ZYcnsvcE2NNFfvNUBQbHD/HwRqTXbhtalYyLSctUhZRRyOFyF
   d7Z9EHYp2Efg6PP7WdxuaHera7oEXfnUxWWxgAGQs5VwoYwRx5AE7tKL0
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="398212324"
X-IronPort-AV: E=Sophos;i="6.04,284,1695711600"; 
   d="scan'208";a="398212324"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2023 10:30:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,284,1695711600"; 
   d="scan'208";a="16917484"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 17 Dec 2023 10:30:45 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rEvuS-0003KC-2u;
	Sun, 17 Dec 2023 18:30:40 +0000
Date: Mon, 18 Dec 2023 02:30:01 +0800
From: kernel test robot <lkp@intel.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/firmware/efi/libstub/alignedmem.c:27: warning: Function
 parameter or struct member 'memory_type' not described in
 'efi_allocate_pages_aligned'
Message-ID: <202312180226.sLoRITQ4-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3b8a9b2e6809d281890dd0a1102dc14d2cd11caf
commit: 9cf42bca30e98a1c6c9e8abf876940a551eaa3d1 efi: libstub: use EFI_LOADER_CODE region when moving the kernel in memory
date:   1 year, 1 month ago
config: i386-randconfig-054-20231216 (https://download.01.org/0day-ci/archive/20231218/202312180226.sLoRITQ4-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231218/202312180226.sLoRITQ4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312180226.sLoRITQ4-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/firmware/efi/libstub/alignedmem.c:27: warning: Function parameter or struct member 'memory_type' not described in 'efi_allocate_pages_aligned'


vim +27 drivers/firmware/efi/libstub/alignedmem.c

43b1df0e013c25 Ard Biesheuvel 2020-03-27   7  
43b1df0e013c25 Ard Biesheuvel 2020-03-27   8  /**
43b1df0e013c25 Ard Biesheuvel 2020-03-27   9   * efi_allocate_pages_aligned() - Allocate memory pages
43b1df0e013c25 Ard Biesheuvel 2020-03-27  10   * @size:	minimum number of bytes to allocate
43b1df0e013c25 Ard Biesheuvel 2020-03-27  11   * @addr:	On return the address of the first allocated page. The first
43b1df0e013c25 Ard Biesheuvel 2020-03-27  12   *		allocated page has alignment EFI_ALLOC_ALIGN which is an
43b1df0e013c25 Ard Biesheuvel 2020-03-27  13   *		architecture dependent multiple of the page size.
43b1df0e013c25 Ard Biesheuvel 2020-03-27  14   * @max:	the address that the last allocated memory page shall not
43b1df0e013c25 Ard Biesheuvel 2020-03-27  15   *		exceed
43b1df0e013c25 Ard Biesheuvel 2020-03-27  16   * @align:	minimum alignment of the base of the allocation
43b1df0e013c25 Ard Biesheuvel 2020-03-27  17   *
43b1df0e013c25 Ard Biesheuvel 2020-03-27  18   * Allocate pages as EFI_LOADER_DATA. The allocated pages are aligned according
43b1df0e013c25 Ard Biesheuvel 2020-03-27  19   * to @align, which should be >= EFI_ALLOC_ALIGN. The last allocated page will
43b1df0e013c25 Ard Biesheuvel 2020-03-27  20   * not exceed the address given by @max.
43b1df0e013c25 Ard Biesheuvel 2020-03-27  21   *
43b1df0e013c25 Ard Biesheuvel 2020-03-27  22   * Return:	status code
43b1df0e013c25 Ard Biesheuvel 2020-03-27  23   */
43b1df0e013c25 Ard Biesheuvel 2020-03-27  24  efi_status_t efi_allocate_pages_aligned(unsigned long size, unsigned long *addr,
9cf42bca30e98a Ard Biesheuvel 2022-08-02  25  					unsigned long max, unsigned long align,
9cf42bca30e98a Ard Biesheuvel 2022-08-02  26  					int memory_type)
43b1df0e013c25 Ard Biesheuvel 2020-03-27 @27  {

:::::: The code at line 27 was first introduced by commit
:::::: 43b1df0e013c25abb536699f46d0e9f291b586a0 efi/libstub: Add API function to allocate aligned memory

:::::: TO: Ard Biesheuvel <ardb@kernel.org>
:::::: CC: Ard Biesheuvel <ardb@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

