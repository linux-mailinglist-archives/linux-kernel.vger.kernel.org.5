Return-Path: <linux-kernel+bounces-314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E079C813F34
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 02:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D4F6283E63
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 01:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271F9624;
	Fri, 15 Dec 2023 01:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QLZmR93D"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04692256D
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 01:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702603853; x=1734139853;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=7jfCdFKlVTDv1z8bnln4/sQRQXdCp5k5pDGNd46wXa4=;
  b=QLZmR93D/rQZGVPvzhK0Z5wqOBxLYG/jaGdGOQW7YIOEGvSyTaUpp8b4
   bZfV3/RIrCNX/63Woq1l5jf0fPkwABz0ysSzi8A/qtPKjLPHuCV+fdnJG
   6dsMI2KGzZYvnonvnbhhGeYjl9oWsC+mf5fUuuyrJKfLE2NLBpHb6qp+o
   Gu6W8F5MoJiTQItbToS0O55FLdzMGe51BGmpWbB8WfiF8MRLOFYJsY2Xk
   ru4SdVtVfTHGy4qfJWK283YT8dGmsnvN1Yv7KbQ3mqBZVmFwKQda7rHms
   GT871Bvvijb9sL9H5QH653J0sGI5erMXvbtoZ1DJniM8BU2bT3uCRO6fL
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="398002823"
X-IronPort-AV: E=Sophos;i="6.04,277,1695711600"; 
   d="scan'208";a="398002823"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 17:30:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="750754256"
X-IronPort-AV: E=Sophos;i="6.04,277,1695711600"; 
   d="scan'208";a="750754256"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 14 Dec 2023 17:30:50 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rDx2N-000Mx1-39;
	Fri, 15 Dec 2023 01:30:47 +0000
Date: Fri, 15 Dec 2023 09:30:23 +0800
From: kernel test robot <lkp@intel.com>
To: Tudor Ambarus <tudor.ambarus@microchip.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>
Subject: drivers/dma/at_hdmac.c:240: warning: Excess struct member 'sg_len'
 description in 'at_desc'
Message-ID: <202312150931.ptq0FuhB-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c7402612e2e61b76177f22e6e7f705adcbecc6fe
commit: ac803b56860f6506c55a3c9330007837e3f4edda dmaengine: at_hdmac: Convert driver to use virt-dma
date:   1 year, 1 month ago
config: arm-defconfig (https://download.01.org/0day-ci/archive/20231215/202312150931.ptq0FuhB-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231215/202312150931.ptq0FuhB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312150931.ptq0FuhB-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/dma/at_hdmac.c:240: warning: Function parameter or member 'sglen' not described in 'at_desc'
   drivers/dma/at_hdmac.c:240: warning: Function parameter or member 'boundary' not described in 'at_desc'
   drivers/dma/at_hdmac.c:240: warning: Function parameter or member 'dst_hole' not described in 'at_desc'
   drivers/dma/at_hdmac.c:240: warning: Function parameter or member 'src_hole' not described in 'at_desc'
   drivers/dma/at_hdmac.c:240: warning: Function parameter or member 'memset_buffer' not described in 'at_desc'
   drivers/dma/at_hdmac.c:240: warning: Function parameter or member 'memset_paddr' not described in 'at_desc'
   drivers/dma/at_hdmac.c:240: warning: Function parameter or member 'memset_vaddr' not described in 'at_desc'
>> drivers/dma/at_hdmac.c:240: warning: Excess struct member 'sg_len' description in 'at_desc'
   drivers/dma/at_hdmac.c:249: warning: cannot understand function prototype: 'enum atc_status '
   drivers/dma/at_hdmac.c:284: warning: Function parameter or member 'cyclic' not described in 'at_dma_chan'
   drivers/dma/at_hdmac.c:348: warning: Function parameter or member 'regs' not described in 'at_dma'
   drivers/dma/at_hdmac.c:348: warning: Function parameter or member 'memset_pool' not described in 'at_dma'
   drivers/dma/at_hdmac.c:348: warning: Excess struct member 'atdma_devtype' description in 'at_dma'
   drivers/dma/at_hdmac.c:348: warning: Excess struct member 'ch_regs' description in 'at_dma'


vim +240 drivers/dma/at_hdmac.c

ac803b56860f65 Tudor Ambarus 2022-10-25  216  
5cecadc3e2a4fb Tudor Ambarus 2022-10-25  217  /**
5cecadc3e2a4fb Tudor Ambarus 2022-10-25  218   * struct at_desc - software descriptor
ac803b56860f65 Tudor Ambarus 2022-10-25  219   * @vd: pointer to the virtual dma descriptor.
ac803b56860f65 Tudor Ambarus 2022-10-25  220   * @atchan: pointer to the atmel dma channel.
5cecadc3e2a4fb Tudor Ambarus 2022-10-25  221   * @total_len: total transaction byte count
ac803b56860f65 Tudor Ambarus 2022-10-25  222   * @sg_len: number of sg entries.
ac803b56860f65 Tudor Ambarus 2022-10-25  223   * @sg: array of sgs.
5cecadc3e2a4fb Tudor Ambarus 2022-10-25  224   */
5cecadc3e2a4fb Tudor Ambarus 2022-10-25  225  struct at_desc {
ac803b56860f65 Tudor Ambarus 2022-10-25  226  	struct				virt_dma_desc vd;
ac803b56860f65 Tudor Ambarus 2022-10-25  227  	struct				at_dma_chan *atchan;
5cecadc3e2a4fb Tudor Ambarus 2022-10-25  228  	size_t				total_len;
ac803b56860f65 Tudor Ambarus 2022-10-25  229  	unsigned int			sglen;
5cecadc3e2a4fb Tudor Ambarus 2022-10-25  230  	/* Interleaved data */
5cecadc3e2a4fb Tudor Ambarus 2022-10-25  231  	size_t				boundary;
5cecadc3e2a4fb Tudor Ambarus 2022-10-25  232  	size_t				dst_hole;
5cecadc3e2a4fb Tudor Ambarus 2022-10-25  233  	size_t				src_hole;
5cecadc3e2a4fb Tudor Ambarus 2022-10-25  234  
5cecadc3e2a4fb Tudor Ambarus 2022-10-25  235  	/* Memset temporary buffer */
5cecadc3e2a4fb Tudor Ambarus 2022-10-25  236  	bool				memset_buffer;
5cecadc3e2a4fb Tudor Ambarus 2022-10-25  237  	dma_addr_t			memset_paddr;
5cecadc3e2a4fb Tudor Ambarus 2022-10-25  238  	int				*memset_vaddr;
ac803b56860f65 Tudor Ambarus 2022-10-25  239  	struct atdma_sg			sg[];
5cecadc3e2a4fb Tudor Ambarus 2022-10-25 @240  };
5cecadc3e2a4fb Tudor Ambarus 2022-10-25  241  

:::::: The code at line 240 was first introduced by commit
:::::: 5cecadc3e2a4fb72ab37d9420df0a9e1179b8a3e dmaengine: at_hdmac: Keep register definitions and structures private to at_hdmac.c

:::::: TO: Tudor Ambarus <tudor.ambarus@microchip.com>
:::::: CC: Vinod Koul <vkoul@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

