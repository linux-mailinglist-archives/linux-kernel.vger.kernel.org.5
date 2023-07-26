Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE3677627DB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 02:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbjGZAsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 20:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjGZAsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 20:48:02 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A2A7128
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 17:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690332480; x=1721868480;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1RzY+w/A6bDZQgl4mvtGb+uOCErPiUjXggo61dsxgf4=;
  b=QP7SGSKRyh+bVfpwlHHhHP1GCyP5aObXoms5F1L0Z4NyJdmSLtj9MWLP
   yjhpQIfbX+7vN11vOjFpreWuLuf6g1+vuEtShSWqjUTtX5GwZTydj/ai6
   nvApyCtrbKt7o1pAw0tjFrdzDeJAgjrWFGBoBIb3KDpkBCwR5Xv7cXqpf
   4jej7l3mJR4YBuviHSvTZo0xW2E07+KCdULteScS/dy70nZo0P8r78BgC
   WlqMef/Z098oOQ3YxGXm+97gkvtVDSV61UXNuKqaG0Dq7B7lKGAjdR1VI
   QrR0YW2kp5Wz0uCXgFo17BXFAUC8A0Xwje0MiS9aR08pzvHjrE4jP/jcB
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="352781278"
X-IronPort-AV: E=Sophos;i="6.01,231,1684825200"; 
   d="scan'208";a="352781278"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 17:48:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="791602579"
X-IronPort-AV: E=Sophos;i="6.01,231,1684825200"; 
   d="scan'208";a="791602579"
Received: from lkp-server02.sh.intel.com (HELO 953e8cd98f7d) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 25 Jul 2023 17:47:57 -0700
Received: from kbuild by 953e8cd98f7d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qOSh3-0000U7-0I;
        Wed, 26 Jul 2023 00:47:57 +0000
Date:   Wed, 26 Jul 2023 08:47:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sunil V L <sunilvl@ventanamicro.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: drivers/scsi/hisi_sas/hisi_sas_v3_hw.c:4567:35: sparse: sparse:
 incorrect type in argument 4 (different base types)
Message-ID: <202307260823.whMNpZ1C-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sunil,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   18b44bc5a67275641fb26f2c54ba7eef80ac5950
commit: a91a9ffbd3a55a0ae1bb75e2b6e85b2a03f64e8f RISC-V: Add support to build the ACPI core
date:   8 weeks ago
config: riscv-randconfig-r072-20230725 (https://download.01.org/0day-ci/archive/20230726/202307260823.whMNpZ1C-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230726/202307260823.whMNpZ1C-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307260823.whMNpZ1C-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   WARNING: invalid argument to '-march': '_zihintpause'
   drivers/scsi/hisi_sas/hisi_sas_v3_hw.c:2218:43: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/hisi_sas/hisi_sas_v3_hw.c:2219:46: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/hisi_sas/hisi_sas_v3_hw.c:2235:34: sparse: sparse: restricted __le32 degrades to integer
>> drivers/scsi/hisi_sas/hisi_sas_v3_hw.c:4567:35: sparse: sparse: incorrect type in argument 4 (different base types) @@     expected restricted __le32 [usertype] *[assigned] ptr @@     got unsigned int * @@
   drivers/scsi/hisi_sas/hisi_sas_v3_hw.c:4567:35: sparse:     expected restricted __le32 [usertype] *[assigned] ptr
   drivers/scsi/hisi_sas/hisi_sas_v3_hw.c:4567:35: sparse:     got unsigned int *

vim +4567 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c

cd96fe600cc492 Luo Jiaxing 2021-01-26  4559  
cd96fe600cc492 Luo Jiaxing 2021-01-26  4560  static int debugfs_fifo_data_v3_hw_show(struct seq_file *s, void *p)
cd96fe600cc492 Luo Jiaxing 2021-01-26  4561  {
cd96fe600cc492 Luo Jiaxing 2021-01-26  4562  	struct hisi_sas_phy *phy = s->private;
cd96fe600cc492 Luo Jiaxing 2021-01-26  4563  
cd96fe600cc492 Luo Jiaxing 2021-01-26  4564  	debugfs_read_fifo_data_v3_hw(phy);
cd96fe600cc492 Luo Jiaxing 2021-01-26  4565  
cd96fe600cc492 Luo Jiaxing 2021-01-26  4566  	debugfs_show_row_32_v3_hw(s, 0, HISI_SAS_FIFO_DATA_DW_SIZE * 4,
cd96fe600cc492 Luo Jiaxing 2021-01-26 @4567  				  phy->fifo.rd_data);
cd96fe600cc492 Luo Jiaxing 2021-01-26  4568  
cd96fe600cc492 Luo Jiaxing 2021-01-26  4569  	return 0;
cd96fe600cc492 Luo Jiaxing 2021-01-26  4570  }
cd96fe600cc492 Luo Jiaxing 2021-01-26  4571  DEFINE_SHOW_ATTRIBUTE(debugfs_fifo_data_v3_hw);
cd96fe600cc492 Luo Jiaxing 2021-01-26  4572  

:::::: The code at line 4567 was first introduced by commit
:::::: cd96fe600cc4924d8d0cc6e3161870219c0d2c12 scsi: hisi_sas: Add trace FIFO debugfs support

:::::: TO: Luo Jiaxing <luojiaxing@huawei.com>
:::::: CC: Martin K. Petersen <martin.petersen@oracle.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
