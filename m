Return-Path: <linux-kernel+bounces-4398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C0EC2817C75
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 22:11:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5094AB20CF6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 21:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF491740A3;
	Mon, 18 Dec 2023 21:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HKPSqRYs"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F687349F
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 21:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702933881; x=1734469881;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=2SjGn2tryVayCtCuqYVyNr6BagJ3U4ONAKLbTRr9UdA=;
  b=HKPSqRYsVo2sECFTLaW53qmbAKartVKTKhkzuQ03HZCVt5j+W1CwO1Yn
   3YZkyS2ZCntMXu+JmQ+/fAVPBTjKOBTd+R0M3ZErQMRPnko5pjpD3jl65
   DLhWJ827byfbyFRzGtdjF9JS8HCoII1BoXCZMJokYE68or3zu3W4UI5aB
   gx+7xtmKOPTkw/4np1h2UkgD6GZOj3g9ZY5qRCbgvDgjqfzQ7QGcBmYeS
   Ku3368HT+3DuLhew920BjirwWtFo59ix7hcYE30cvDeU26up3WnKtjjx3
   4us94dgGvjFuM86sveE5AxEylWFNs75ULZomqOhbhOHf0ffX32KxYCMbO
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="395294789"
X-IronPort-AV: E=Sophos;i="6.04,286,1695711600"; 
   d="scan'208";a="395294789"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 13:11:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="846087929"
X-IronPort-AV: E=Sophos;i="6.04,286,1695711600"; 
   d="scan'208";a="846087929"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 18 Dec 2023 13:11:19 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rFKtQ-0004X3-27;
	Mon, 18 Dec 2023 21:11:16 +0000
Date: Tue, 19 Dec 2023 05:10:17 +0800
From: kernel test robot <lkp@intel.com>
To: Peng Ma <peng.ma@nxp.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Vinod Koul <vkoul@kernel.org>
Subject: drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c:183:18: sparse: sparse:
 incorrect type in assignment (different base types)
Message-ID: <202312190533.Lbc18dxc-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   2cf4f94d8e8646803f8fb0facf134b0cd7fb691a
commit: 7fdf9b05c73b79c4d9a85b5a9905efa10ee482a6 dmaengine: fsl-dpaa2-qdma: Add NXP dpaa2 qDMA controller driver for Layerscape SoCs
date:   4 years, 2 months ago
config: arm64-randconfig-r112-20231117 (https://download.01.org/0day-ci/archive/20231219/202312190533.Lbc18dxc-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231219/202312190533.Lbc18dxc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312190533.Lbc18dxc-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c:183:18: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] cmd @@     got restricted __le32 [usertype] @@
   drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c:183:18: sparse:     expected unsigned int [usertype] cmd
   drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c:183:18: sparse:     got restricted __le32 [usertype]
   drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c:188:26: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] cmd @@     got restricted __le32 [usertype] @@
   drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c:188:26: sparse:     expected unsigned int [usertype] cmd
   drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c:188:26: sparse:     got restricted __le32 [usertype]
   drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c:190:26: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] cmd @@     got restricted __le32 [usertype] @@
   drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c:190:26: sparse:     expected unsigned int [usertype] cmd
   drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c:190:26: sparse:     got restricted __le32 [usertype]
--
>> drivers/dma/fsl-dpaa2-qdma/dpdmai.c:81:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le64 [usertype] @@     got restricted __le32 [usertype] @@
   drivers/dma/fsl-dpaa2-qdma/dpdmai.c:81:24: sparse:     expected restricted __le64 [usertype]
   drivers/dma/fsl-dpaa2-qdma/dpdmai.c:81:24: sparse:     got restricted __le32 [usertype]
>> drivers/dma/fsl-dpaa2-qdma/dpdmai.c:148:9: sparse: sparse: invalid assignment: |=
>> drivers/dma/fsl-dpaa2-qdma/dpdmai.c:148:9: sparse:    left side has type restricted __le64
>> drivers/dma/fsl-dpaa2-qdma/dpdmai.c:148:9: sparse:    right side has type unsigned long long
>> drivers/dma/fsl-dpaa2-qdma/dpdmai.c:148:9: sparse: sparse: invalid assignment: |=
>> drivers/dma/fsl-dpaa2-qdma/dpdmai.c:148:9: sparse:    left side has type restricted __le64
>> drivers/dma/fsl-dpaa2-qdma/dpdmai.c:148:9: sparse:    right side has type unsigned long long

vim +183 drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c

   170	
   171	/* first frame list for descriptor buffer */
   172	static void
   173	dpaa2_qdma_populate_first_framel(struct dpaa2_fl_entry *f_list,
   174					 struct dpaa2_qdma_comp *dpaa2_comp,
   175					 bool wrt_changed)
   176	{
   177		struct dpaa2_qdma_sd_d *sdd;
   178	
   179		sdd = dpaa2_comp->desc_virt_addr;
   180		memset(sdd, 0, 2 * (sizeof(*sdd)));
   181	
   182		/* source descriptor CMD */
 > 183		sdd->cmd = cpu_to_le32(QDMA_SD_CMD_RDTTYPE_COHERENT);
   184		sdd++;
   185	
   186		/* dest descriptor CMD */
   187		if (wrt_changed)
   188			sdd->cmd = cpu_to_le32(LX2160_QDMA_DD_CMD_WRTTYPE_COHERENT);
   189		else
   190			sdd->cmd = cpu_to_le32(QDMA_DD_CMD_WRTTYPE_COHERENT);
   191	
   192		memset(f_list, 0, sizeof(struct dpaa2_fl_entry));
   193	
   194		/* first frame list to source descriptor */
   195		dpaa2_fl_set_addr(f_list, dpaa2_comp->desc_bus_addr);
   196		dpaa2_fl_set_len(f_list, 0x20);
   197		dpaa2_fl_set_format(f_list, QDMA_FL_FMT_SBF | QDMA_FL_SL_LONG);
   198	
   199		/* bypass memory translation */
   200		if (smmu_disable)
   201			f_list->bpid = cpu_to_le16(QDMA_FL_BMT_ENABLE);
   202	}
   203	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

