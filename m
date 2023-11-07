Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A00C77E4677
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 17:58:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234969AbjKGQ6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 11:58:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjKGQ6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 11:58:42 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F35A193
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 08:58:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699376319; x=1730912319;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=88aQzXP3D0IAQZ/WFA4CjozxHNibdPYVgfCMXdrwJLU=;
  b=FbHYtwfurFYwRSK+d+s6teY00CnHtpon3taLudCGWbm1lPTxLIX0F7yM
   JEL/nAx8558n2hInr3P9LXV80+X//MCcEdYgFgW30l5NGcKfeikzEVLZ9
   K08Y+HfYUF/hMLqfkfIQJgbaoXxQ9S6Lg1rCy2ZcFlpLLsR1tdasnj51S
   yEKJPXdYXkBc1nbfdQNiRqLXKMEvbRsIJkMHMVjrQOM39EZlzZTeKmduU
   ClVrO40XvlG3LMliSldK0hWTspczmcRhLbGNtZQpGGMfe03PsXuCmfpK5
   7N5ydjB7SDmDbQLI7e80hPkT6m2k2PmZ6ySG5p2y8unNbyPcqE/04cdOI
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="389359549"
X-IronPort-AV: E=Sophos;i="6.03,284,1694761200"; 
   d="scan'208";a="389359549"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 08:58:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="762764648"
X-IronPort-AV: E=Sophos;i="6.03,284,1694761200"; 
   d="scan'208";a="762764648"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 07 Nov 2023 08:58:37 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r0PPP-0007F9-1U;
        Tue, 07 Nov 2023 16:58:35 +0000
Date:   Wed, 8 Nov 2023 00:57:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: drivers/scsi/mpt3sas/mpt3sas_base.c:4323:9: sparse: sparse: cast
 from restricted __le32
Message-ID: <202311080059.uscQqMAV-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   be3ca57cfb777ad820c6659d52e60bbdd36bf5ff
commit: d82e68483b81768c8d19bc7529635dad741607ce scsi: mpt3sas: Revert "scsi: mpt3sas: Fix ioc->base_readl() use"
date:   1 year, 1 month ago
config: riscv-randconfig-r121-20231107 (https://download.01.org/0day-ci/archive/20231108/202311080059.uscQqMAV-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231108/202311080059.uscQqMAV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311080059.uscQqMAV-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   WARNING: invalid argument to '-march': '_zicbom_zihintpause'
>> drivers/scsi/mpt3sas/mpt3sas_base.c:4323:9: sparse: sparse: cast from restricted __le32
   drivers/scsi/mpt3sas/mpt3sas_base.c:4345:9: sparse: sparse: cast from restricted __le32
   drivers/scsi/mpt3sas/mpt3sas_base.c:4368:9: sparse: sparse: cast from restricted __le32
   drivers/scsi/mpt3sas/mpt3sas_base.c:4389:9: sparse: sparse: cast from restricted __le32
   drivers/scsi/mpt3sas/mpt3sas_base.c:7066:17: sparse: sparse: cast from restricted __le32
   drivers/scsi/mpt3sas/mpt3sas_base.c:7085:20: sparse: sparse: cast to restricted __le16
   drivers/scsi/mpt3sas/mpt3sas_base.c:7093:20: sparse: sparse: cast to restricted __le16
   drivers/scsi/mpt3sas/mpt3sas_base.c:7106:36: sparse: sparse: cast to restricted __le16

vim +4323 drivers/scsi/mpt3sas/mpt3sas_base.c

f92363d1235949 Sreekanth Reddy  2012-11-30  4302  
79c74d03d527f8 Suganath Prabu S 2019-05-31  4303  /**
79c74d03d527f8 Suganath Prabu S 2019-05-31  4304   * _base_put_smid_scsi_io_atomic - send SCSI_IO request to firmware using
79c74d03d527f8 Suganath Prabu S 2019-05-31  4305   *   Atomic Request Descriptor
79c74d03d527f8 Suganath Prabu S 2019-05-31  4306   * @ioc: per adapter object
79c74d03d527f8 Suganath Prabu S 2019-05-31  4307   * @smid: system request message index
79c74d03d527f8 Suganath Prabu S 2019-05-31  4308   * @handle: device handle, unused in this function, for function type match
79c74d03d527f8 Suganath Prabu S 2019-05-31  4309   *
2910a4a9e90a58 Randy Dunlap     2021-04-18  4310   * Return: nothing.
79c74d03d527f8 Suganath Prabu S 2019-05-31  4311   */
79c74d03d527f8 Suganath Prabu S 2019-05-31  4312  static void
79c74d03d527f8 Suganath Prabu S 2019-05-31  4313  _base_put_smid_scsi_io_atomic(struct MPT3SAS_ADAPTER *ioc, u16 smid,
79c74d03d527f8 Suganath Prabu S 2019-05-31  4314  	u16 handle)
79c74d03d527f8 Suganath Prabu S 2019-05-31  4315  {
79c74d03d527f8 Suganath Prabu S 2019-05-31  4316  	Mpi26AtomicRequestDescriptor_t descriptor;
79c74d03d527f8 Suganath Prabu S 2019-05-31  4317  	u32 *request = (u32 *)&descriptor;
79c74d03d527f8 Suganath Prabu S 2019-05-31  4318  
79c74d03d527f8 Suganath Prabu S 2019-05-31  4319  	descriptor.RequestFlags = MPI2_REQ_DESCRIPT_FLAGS_SCSI_IO;
998c3001d31a27 Suganath Prabu S 2019-05-31  4320  	descriptor.MSIxIndex = _base_set_and_get_msix_index(ioc, smid);
79c74d03d527f8 Suganath Prabu S 2019-05-31  4321  	descriptor.SMID = cpu_to_le16(smid);
79c74d03d527f8 Suganath Prabu S 2019-05-31  4322  
f920642e406cfa Damien Le Moal   2022-09-16 @4323  	writel(cpu_to_le32(*request), &ioc->chip->AtomicRequestDescriptorPost);
79c74d03d527f8 Suganath Prabu S 2019-05-31  4324  }
79c74d03d527f8 Suganath Prabu S 2019-05-31  4325  

:::::: The code at line 4323 was first introduced by commit
:::::: f920642e406cfa17ebecf03d5b83a02273ec718e scsi: mpt3sas: Revert "scsi: mpt3sas: Fix writel() use"

:::::: TO: Damien Le Moal <damien.lemoal@opensource.wdc.com>
:::::: CC: Martin K. Petersen <martin.petersen@oracle.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
