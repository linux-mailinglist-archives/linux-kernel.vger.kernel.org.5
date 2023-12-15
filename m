Return-Path: <linux-kernel+bounces-1515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 658B5814F98
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 19:18:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03DD11F225FB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 18:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91BB3DBA1;
	Fri, 15 Dec 2023 18:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eZKjJbtC"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2523E30128
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 18:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702664298; x=1734200298;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=oIy/GeRIK9X1C9SdD2TD84Y3G6YhriV7Fh3rv+hzjLE=;
  b=eZKjJbtCYamR+brd2PCEL9K5ai0uefVLjCWxdwd00k4GrPmdJRczSGP3
   nROmR6M6aW9ehCK1R84kFZ+MOd2WIfm3f23kQ6HWLkKH+dcRVQp6T+KMm
   CYcun3BHqR+B5D7hRE8Na29fF99i62E9hKLR5i23UXjiclvUleNlodTbU
   eFh+CNcxbBo5EqkNruikrAs/Qy4coELqb4PB2zgHiPbrWQ1rjuqnwO377
   lGm8F1E1/69R2gQvkUpFPsfcjdBiOsL+VGvioYYcxmoIkGijKvGk21PuS
   UR/1hnFiHTA6xmeRhSJcVVxBP3nrVkCrcdgqk4QNZsMoN1OXDv4UTPO1v
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="399146936"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="399146936"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 10:18:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="22936309"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 15 Dec 2023 10:18:16 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rEClJ-0000as-2T;
	Fri, 15 Dec 2023 18:18:13 +0000
Date: Sat, 16 Dec 2023 02:17:40 +0800
From: kernel test robot <lkp@intel.com>
To: Tudor Ambarus <tudor.ambarus@microchip.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>
Subject: scripts/kernel-doc: drivers/dma/at_hdmac.c:240: warning: Function
 parameter or struct member 'sglen' not described in 'at_desc'
Message-ID: <202312160248.qdLfKzJz-lkp@intel.com>
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
commit: ac803b56860f6506c55a3c9330007837e3f4edda dmaengine: at_hdmac: Convert driver to use virt-dma
date:   1 year, 1 month ago
config: arm-randconfig-001-20231215 (https://download.01.org/0day-ci/archive/20231216/202312160248.qdLfKzJz-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project.git 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231216/202312160248.qdLfKzJz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312160248.qdLfKzJz-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> scripts/kernel-doc: drivers/dma/at_hdmac.c:240: warning: Function parameter or struct member 'sglen' not described in 'at_desc'
   scripts/kernel-doc: drivers/dma/at_hdmac.c:240: warning: Function parameter or struct member 'boundary' not described in 'at_desc'
   scripts/kernel-doc: drivers/dma/at_hdmac.c:240: warning: Function parameter or struct member 'dst_hole' not described in 'at_desc'
   scripts/kernel-doc: drivers/dma/at_hdmac.c:240: warning: Function parameter or struct member 'src_hole' not described in 'at_desc'
   scripts/kernel-doc: drivers/dma/at_hdmac.c:240: warning: Function parameter or struct member 'memset_buffer' not described in 'at_desc'
   scripts/kernel-doc: drivers/dma/at_hdmac.c:240: warning: Function parameter or struct member 'memset_paddr' not described in 'at_desc'
   scripts/kernel-doc: drivers/dma/at_hdmac.c:240: warning: Function parameter or struct member 'memset_vaddr' not described in 'at_desc'
>> scripts/kernel-doc: drivers/dma/at_hdmac.c:240: warning: Excess struct member 'sg_len' description in 'at_desc'
>> scripts/kernel-doc: drivers/dma/at_hdmac.c:240: warning: Excess struct member 'sg_len' description in 'at_desc'
   scripts/kernel-doc: drivers/dma/at_hdmac.c:249: warning: cannot understand function prototype: 'enum atc_status '
>> scripts/kernel-doc: drivers/dma/at_hdmac.c:284: warning: Function parameter or struct member 'cyclic' not described in 'at_dma_chan'
   scripts/kernel-doc: drivers/dma/at_hdmac.c:348: warning: Function parameter or struct member 'regs' not described in 'at_dma'
   scripts/kernel-doc: drivers/dma/at_hdmac.c:348: warning: Function parameter or struct member 'memset_pool' not described in 'at_dma'
   scripts/kernel-doc: drivers/dma/at_hdmac.c:348: warning: Excess struct member 'atdma_devtype' description in 'at_dma'
   scripts/kernel-doc: drivers/dma/at_hdmac.c:348: warning: Excess struct member 'ch_regs' description in 'at_dma'
   scripts/kernel-doc: drivers/dma/at_hdmac.c:348: warning: Excess struct member 'atdma_devtype' description in 'at_dma'
   scripts/kernel-doc: drivers/dma/at_hdmac.c:348: warning: Excess struct member 'ch_regs' description in 'at_dma'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

