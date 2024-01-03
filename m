Return-Path: <linux-kernel+bounces-15986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 853A1823698
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 21:32:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 351FA1F25ABD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 20:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53DCB1D548;
	Wed,  3 Jan 2024 20:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gwn/u0yH"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465A71D541
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 20:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704313914; x=1735849914;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=YZ05VNNjcmH++LVoRCkEfx6RPzJBopest22eQyg/bbA=;
  b=Gwn/u0yHt4H1Yl/J1kuGDX+bbrqnnKcT+eP6wFXxJ5EbAekYXtjf+f//
   8SlWmfaHa7QVFakwee+Gns54WwZXYmXMSOhhziv2K1TE0epAFXuT4ttem
   NcUcrKOIoHhERd1sD6MXao3wIro2dl2DhluE/b8pMMNlbGiNDJvy8T1Xl
   oEVP+PtzDjuZJ4BVhMrshF3W53VMHyybljO65Q2WncVTWFW4GgkWLQcpx
   E9RRH2RXL9f4ghNDFVJ4utni/+RXjk8bm+CDdCrMCkWsZssOE+8edjxU8
   6d15hHSwwS2kELJraZsOESEf6wkDF8vsgip6IFoHIGnN/7P2vZU0B9dHO
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="10458680"
X-IronPort-AV: E=Sophos;i="6.04,328,1695711600"; 
   d="scan'208";a="10458680"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 12:31:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="783611563"
X-IronPort-AV: E=Sophos;i="6.04,328,1695711600"; 
   d="scan'208";a="783611563"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 03 Jan 2024 12:31:52 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rL7u2-000MXo-05;
	Wed, 03 Jan 2024 20:31:50 +0000
Date: Thu, 4 Jan 2024 04:31:49 +0800
From: kernel test robot <lkp@intel.com>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	"Borislav Petkov (AMD)" <bp@alien8.de>
Subject: [tip:ras/core 11/13] include/linux/ras.h:9:10: fatal error:
 'uapi/asm/mce.h' file not found
Message-ID: <202401040401.z915YJoV-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git ras/core
head:   d48d30d8c358004c7b1cb2e16969a569d45953b3
commit: 8e1d0790e0a749a62428ff039c7a9050a06e9feb [11/13] RAS: Introduce AMD Address Translation Library
config: arm-randconfig-002-20240103 (https://download.01.org/0day-ci/archive/20240104/202401040401.z915YJoV-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project.git 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240104/202401040401.z915YJoV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401040401.z915YJoV-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/ras/ras.c:10:
>> include/linux/ras.h:9:10: fatal error: 'uapi/asm/mce.h' file not found
   #include <uapi/asm/mce.h>
            ^~~~~~~~~~~~~~~~
   1 error generated.


vim +9 include/linux/ras.h

     8	
   > 9	#include <uapi/asm/mce.h>
    10	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

