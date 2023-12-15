Return-Path: <linux-kernel+bounces-990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C245E8148E6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 14:17:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53C51286482
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 13:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1597C2D05F;
	Fri, 15 Dec 2023 13:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h0qVfuuU"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE3D2D7BE
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 13:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702646174; x=1734182174;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=EV/kG4sinT3otF7Cj9i3xRL9iFuhxd2et3B7nxiTSb0=;
  b=h0qVfuuU87rDAvtR/AGeMen9jwb/1zgmU+aEkf+2Wnh8jLst91T38RMi
   4MCuNixvJvwjcze9ur661KWfpWWDsqBUwp8ctN5KEHHduMC/iqCFZesSG
   TAwk27CSpjjS+2p4P+UGRho7YLC5OtsdCg7E6q4yzBmM9xHtsnLo7UjhM
   M8fwKisVpfc2IFzXcQM+qAQD0qCo4tEMZcReMWF2t8nZAfIGVh6MdgOg0
   lMsjoe5jLzrxuIq/uwn/inxZFZfxKtLAEAEKYAc2TSTlTSOmAlQbuY4IC
   pbOp7IlnYJgYcdmZOt4C5h5kkNxI68qFizjp670WsnVZJt2hs07GX/5Z8
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="2440860"
X-IronPort-AV: E=Sophos;i="6.04,278,1695711600"; 
   d="scan'208";a="2440860"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 05:16:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,278,1695711600"; 
   d="scan'208";a="16294273"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 15 Dec 2023 05:16:11 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rE82z-0000Ee-0Q;
	Fri, 15 Dec 2023 13:16:09 +0000
Date: Fri, 15 Dec 2023 21:15:24 +0800
From: kernel test robot <lkp@intel.com>
To: Tudor Ambarus <tudor.ambarus@microchip.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>
Subject: scripts/kernel-doc: drivers/dma/at_hdmac.c:253: warning: Function
 parameter or struct member 'boundary' not described in 'at_desc'
Message-ID: <202312152131.DQztdy4c-lkp@intel.com>
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
commit: 5cecadc3e2a4fb72ab37d9420df0a9e1179b8a3e dmaengine: at_hdmac: Keep register definitions and structures private to at_hdmac.c
date:   1 year, 1 month ago
config: arm-randconfig-001-20231215 (https://download.01.org/0day-ci/archive/20231215/202312152131.DQztdy4c-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project.git 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231215/202312152131.DQztdy4c-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312152131.DQztdy4c-lkp@intel.com/

All warnings (new ones prefixed by >>):

   scripts/kernel-doc: drivers/dma/at_hdmac.c:253: warning: Function parameter or struct member 'lli' not described in 'at_desc'
   scripts/kernel-doc: drivers/dma/at_hdmac.c:253: warning: Function parameter or struct member 'tx_list' not described in 'at_desc'
>> scripts/kernel-doc: drivers/dma/at_hdmac.c:253: warning: Function parameter or struct member 'boundary' not described in 'at_desc'
>> scripts/kernel-doc: drivers/dma/at_hdmac.c:253: warning: Function parameter or struct member 'dst_hole' not described in 'at_desc'
>> scripts/kernel-doc: drivers/dma/at_hdmac.c:253: warning: Function parameter or struct member 'src_hole' not described in 'at_desc'
>> scripts/kernel-doc: drivers/dma/at_hdmac.c:253: warning: Function parameter or struct member 'memset_buffer' not described in 'at_desc'
>> scripts/kernel-doc: drivers/dma/at_hdmac.c:253: warning: Function parameter or struct member 'memset_paddr' not described in 'at_desc'
>> scripts/kernel-doc: drivers/dma/at_hdmac.c:253: warning: Function parameter or struct member 'memset_vaddr' not described in 'at_desc'
   scripts/kernel-doc: drivers/dma/at_hdmac.c:253: warning: Excess struct member 'at_lli' description in 'at_desc'
   scripts/kernel-doc: drivers/dma/at_hdmac.c:253: warning: Excess struct member 'at_lli' description in 'at_desc'
>> scripts/kernel-doc: drivers/dma/at_hdmac.c:269: warning: cannot understand function prototype: 'enum atc_status '
   scripts/kernel-doc: drivers/dma/at_hdmac.c:384: warning: Function parameter or struct member 'dma_common' not described in 'at_dma'
>> scripts/kernel-doc: drivers/dma/at_hdmac.c:384: warning: Function parameter or struct member 'regs' not described in 'at_dma'
>> scripts/kernel-doc: drivers/dma/at_hdmac.c:384: warning: Function parameter or struct member 'memset_pool' not described in 'at_dma'
   scripts/kernel-doc: drivers/dma/at_hdmac.c:384: warning: Excess struct member 'chan_common' description in 'at_dma'
>> scripts/kernel-doc: drivers/dma/at_hdmac.c:384: warning: Excess struct member 'atdma_devtype' description in 'at_dma'
>> scripts/kernel-doc: drivers/dma/at_hdmac.c:384: warning: Excess struct member 'ch_regs' description in 'at_dma'
>> scripts/kernel-doc: drivers/dma/at_hdmac.c:384: warning: Excess struct member 'atdma_devtype' description in 'at_dma'
>> scripts/kernel-doc: drivers/dma/at_hdmac.c:384: warning: Excess struct member 'ch_regs' description in 'at_dma'
   scripts/kernel-doc: drivers/dma/at_hdmac.c:384: warning: Excess struct member 'chan_common' description in 'at_dma'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

