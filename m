Return-Path: <linux-kernel+bounces-2616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62AC4815F7E
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 14:48:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D960528449A
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 13:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D08C84438C;
	Sun, 17 Dec 2023 13:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WSN7Lr1g"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E42A4437E
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 13:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702820901; x=1734356901;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=3bmy019Ze3o0nhRb7RQ/W5So8i0WEX5x0CPBGipLuM8=;
  b=WSN7Lr1giU/JVw/uOJJOvnw3dHgTXNpVkxaYFzuShI+mtOSEDMCnF+53
   rCPyYhz90BOE1LghzRTM5Rv2XrE28sOZEZ4sHCUJVJWfm6qQPsLGkztYZ
   tK7zxkwGpCEds+BK6As/CE+XI89i19dxBvlGlm4qYkkOEFeB/xK9D/A4l
   eHwU2UciBc7p27J4zPGznpgVESioQP4bbEvcRyk+Mif6n39gIwPvBwbMC
   SeGK6oxcuK6iEVrbKviKfdBAB0IwcHF8uQA4XC8Ara1wA1nSVJ3/LmzLt
   pcQ73KsKZ5NdnqSeT9JslvAXFx2mXEX5VPW+04B4921kMae35KQfEd5q9
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10926"; a="380408269"
X-IronPort-AV: E=Sophos;i="6.04,283,1695711600"; 
   d="scan'208";a="380408269"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2023 05:48:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,283,1695711600"; 
   d="scan'208";a="16869810"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 17 Dec 2023 05:48:20 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rErVA-00035E-1f;
	Sun, 17 Dec 2023 13:48:16 +0000
Date: Sun, 17 Dec 2023 21:47:21 +0800
From: kernel test robot <lkp@intel.com>
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	Vineet Gupta <vgupta@synopsys.com>
Subject: arch/arc/plat-hsdk/platform.c:16:5: sparse: sparse: symbol
 'arc_hsdk_axi_dmac_coherent' was not declared. Should it be static?
Message-ID: <202312172140.FvgljCBk-lkp@intel.com>
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
commit: ce0eff0d9b4d37702df48a39e3fddb5e39b2c25b ARC: [plat-hsdk]: allow to switch between AXI DMAC port configurations
date:   4 years, 4 months ago
config: arc-randconfig-r111-20231107 (https://download.01.org/0day-ci/archive/20231217/202312172140.FvgljCBk-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231217/202312172140.FvgljCBk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312172140.FvgljCBk-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> arch/arc/plat-hsdk/platform.c:16:5: sparse: sparse: symbol 'arc_hsdk_axi_dmac_coherent' was not declared. Should it be static?
   arch/arc/plat-hsdk/platform.c:27:17: sparse: sparse: undefined identifier '__builtin_arc_sr'
   arch/arc/plat-hsdk/platform.c:34:17: sparse: sparse: undefined identifier '__builtin_arc_sr'

vim +/arc_hsdk_axi_dmac_coherent +16 arch/arc/plat-hsdk/platform.c

    15	
  > 16	int arc_hsdk_axi_dmac_coherent __section(.data) = 0;
    17	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

