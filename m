Return-Path: <linux-kernel+bounces-1209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC0FF814BAF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 16:24:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF5B61C21ED6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 15:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B67E36AEA;
	Fri, 15 Dec 2023 15:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EaoPKP86"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039A5364C9
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 15:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702653891; x=1734189891;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=jXQXQlomGFjmJz8HswweNDJQzewf1HjzjMYpjnVcIao=;
  b=EaoPKP86lPbPlTsb+FuUEk9ka0S6a4Bx7r3NDAN6RBAfqvomspGhMAdk
   0E5nozZ3nsFyU09F+humh/Eegw3kbAK0sZy+QumVJzR2FYo1gfo1g1X4K
   uMeldWGqgn8jLeEBYTNueQuJOAcikcyA201fgWMrCZYpApfOYrWbtPmSL
   MVx7QR7fS8ZE7sXL5H+1hJgLetbVzg/jGbUNtgQbJ6uDL3fRVA17xQPNb
   3JfzymwuWQbk6BK+8Zmf78pJj252TxTglC3clRzB6Q/3tOzqyn5rYdE6g
   hL653ThHRfdfUCgFHD8vjV6CmLDIIt3qwC3HzjaJJBNBd/KPEimHLxhZP
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="8646431"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="8646431"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 07:24:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="840694243"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="840694243"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 15 Dec 2023 07:24:43 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rEA3M-0000Me-2z;
	Fri, 15 Dec 2023 15:24:40 +0000
Date: Fri, 15 Dec 2023 23:24:21 +0800
From: kernel test robot <lkp@intel.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: scripts/kernel-doc: drivers/firmware/efi/libstub/alignedmem.c:27:
 warning: Function parameter or struct member 'memory_type' not described in
 'efi_allocate_pages_aligned'
Message-ID: <202312152342.b4KOX5yb-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3f7168591ebf7bbdb91797d02b1afaf00a4289b1
commit: 9cf42bca30e98a1c6c9e8abf876940a551eaa3d1 efi: libstub: use EFI_LOADER_CODE region when moving the kernel in memory
date:   1 year, 1 month ago
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20231215/202312152342.b4KOX5yb-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231215/202312152342.b4KOX5yb-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312152342.b4KOX5yb-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> scripts/kernel-doc: drivers/firmware/efi/libstub/alignedmem.c:27: warning: Function parameter or struct member 'memory_type' not described in 'efi_allocate_pages_aligned'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

