Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 036F97DFA3B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 19:47:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377335AbjKBSra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 14:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377207AbjKBSr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 14:47:28 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 605C7F0
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 11:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698950844; x=1730486844;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+S5bE0eyMk0xKSaIZ9ZTosanRGgw57g+/ZX5ZTi1bJs=;
  b=ZkTy+HP80bL9aJdEyn5JmEUnurhobLniwMutF7QVSTQxNP7TCybtlXSd
   UGNEuWsq6I653F+ziHgKczcjK8BWvBVqgU65ubyDinIhO9ilcsNNkMEzh
   tXWbyL+XJOUr+GHDVdGHkxkKO+sqqwHye43eShOc4AZn3DEqm62agl4CI
   Nilg+vBOXhkh1n4Gdsb32p9X5oQuHydGeF28RYlbEeVijnCyoirCyBoho
   dwcuahQ9zZYRHlW+jgd1l/wflZb+jflbVhYw78TLo1bB3v0F/2yruOkR8
   EUGMUpynd1nYQDesf+078c4uEhx3csd/nLsMExexm5KwQkywCSA5ir4Nl
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="1718046"
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="1718046"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 11:47:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="765016251"
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="765016251"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 02 Nov 2023 11:47:20 -0700
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qycis-0001mB-0x;
        Thu, 02 Nov 2023 18:47:18 +0000
Date:   Fri, 3 Nov 2023 02:46:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/scsi/mpi3mr/mpi3mr_fw.c:721:58: warning: '%d' directive
 output may be truncated writing between 1 and 3 bytes into a region of size
 between 1 and 32
Message-ID: <202311030237.81SbvSC3-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   21e80f3841c01aeaf32d7aee7bbc87b3db1aa0c6
commit: 3753af778dd9d0d5199d6a7d01b0ead33135d095 kbuild: fix single directory build
date:   1 year, 1 month ago
config: parisc-randconfig-002-20231102 (https://download.01.org/0day-ci/archive/20231103/202311030237.81SbvSC3-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231103/202311030237.81SbvSC3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311030237.81SbvSC3-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/scsi/mpi3mr/mpi3mr_fw.c: In function 'mpi3mr_setup_isr':
>> drivers/scsi/mpi3mr/mpi3mr_fw.c:721:58: warning: '%d' directive output may be truncated writing between 1 and 3 bytes into a region of size between 1 and 32 [-Wformat-truncation=]
     721 |         snprintf(intr_info->name, MPI3MR_NAME_LENGTH, "%s%d-msix%d",
         |                                                          ^~
   In function 'mpi3mr_request_irq',
       inlined from 'mpi3mr_setup_isr' at drivers/scsi/mpi3mr/mpi3mr_fw.c:846:12:
   drivers/scsi/mpi3mr/mpi3mr_fw.c:721:55: note: directive argument in the range [0, 255]
     721 |         snprintf(intr_info->name, MPI3MR_NAME_LENGTH, "%s%d-msix%d",
         |                                                       ^~~~~~~~~~~~~
   drivers/scsi/mpi3mr/mpi3mr_fw.c:721:55: note: directive argument in the range [0, 65535]
   drivers/scsi/mpi3mr/mpi3mr_fw.c:721:9: note: 'snprintf' output between 8 and 45 bytes into a destination of size 32
     721 |         snprintf(intr_info->name, MPI3MR_NAME_LENGTH, "%s%d-msix%d",
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     722 |             mrioc->driver_name, mrioc->id, index);
         |             ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/mpi3mr/mpi3mr_fw.c: In function 'mpi3mr_start_watchdog':
>> drivers/scsi/mpi3mr/mpi3mr_fw.c:2545:60: warning: '%s' directive output may be truncated writing up to 31 bytes into a region of size 11 [-Wformat-truncation=]
    2545 |             sizeof(mrioc->watchdog_work_q_name), "watchdog_%s%d", mrioc->name,
         |                                                            ^~
   drivers/scsi/mpi3mr/mpi3mr_fw.c:2545:50: note: directive argument in the range [0, 255]
    2545 |             sizeof(mrioc->watchdog_work_q_name), "watchdog_%s%d", mrioc->name,
         |                                                  ^~~~~~~~~~~~~~~
   drivers/scsi/mpi3mr/mpi3mr_fw.c:2544:9: note: 'snprintf' output between 11 and 44 bytes into a destination of size 20
    2544 |         snprintf(mrioc->watchdog_work_q_name,
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    2545 |             sizeof(mrioc->watchdog_work_q_name), "watchdog_%s%d", mrioc->name,
         |             ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    2546 |             mrioc->id);
         |             ~~~~~~~~~~
--
   drivers/scsi/mpi3mr/mpi3mr_os.c: In function 'mpi3mr_probe':
>> drivers/scsi/mpi3mr/mpi3mr_os.c:4919:33: warning: '%d' directive writing between 1 and 3 bytes into a region of size between 1 and 32 [-Wformat-overflow=]
    4919 |         sprintf(mrioc->name, "%s%d", mrioc->driver_name, mrioc->id);
         |                                 ^~
   drivers/scsi/mpi3mr/mpi3mr_os.c:4919:30: note: directive argument in the range [0, 255]
    4919 |         sprintf(mrioc->name, "%s%d", mrioc->driver_name, mrioc->id);
         |                              ^~~~~~
   drivers/scsi/mpi3mr/mpi3mr_os.c:4919:9: note: 'sprintf' output between 2 and 35 bytes into a destination of size 32
    4919 |         sprintf(mrioc->name, "%s%d", mrioc->driver_name, mrioc->id);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/scsi/mpi3mr/mpi3mr_os.c:4999:16: warning: '%d' directive output may be truncated writing between 1 and 3 bytes into a region of size between 1 and 32 [-Wformat-truncation=]
    4999 |             "%s%d_fwevt_wrkr", mrioc->driver_name, mrioc->id);
         |                ^~
   drivers/scsi/mpi3mr/mpi3mr_os.c:4999:13: note: directive argument in the range [0, 255]
    4999 |             "%s%d_fwevt_wrkr", mrioc->driver_name, mrioc->id);
         |             ^~~~~~~~~~~~~~~~~
   drivers/scsi/mpi3mr/mpi3mr_os.c:4998:9: note: 'snprintf' output between 13 and 46 bytes into a destination of size 32
    4998 |         snprintf(mrioc->fwevt_worker_name, sizeof(mrioc->fwevt_worker_name),
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    4999 |             "%s%d_fwevt_wrkr", mrioc->driver_name, mrioc->id);
         |             ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--
>> drivers/scsi/mpi3mr/mpi3mr_transport.c:1029: warning: Function parameter or member 'port_id' not described in 'mpi3mr_get_hba_port_by_id'


vim +721 drivers/scsi/mpi3mr/mpi3mr_fw.c

7f9f953d537a7c Sreekanth Reddy 2022-09-12  701  
824a156633dfdb Kashyap Desai   2021-05-20  702  /**
824a156633dfdb Kashyap Desai   2021-05-20  703   * mpi3mr_request_irq - Request IRQ and register ISR
824a156633dfdb Kashyap Desai   2021-05-20  704   * @mrioc: Adapter instance reference
824a156633dfdb Kashyap Desai   2021-05-20  705   * @index: IRQ vector index
824a156633dfdb Kashyap Desai   2021-05-20  706   *
824a156633dfdb Kashyap Desai   2021-05-20  707   * Request threaded ISR with primary ISR and secondary
824a156633dfdb Kashyap Desai   2021-05-20  708   *
824a156633dfdb Kashyap Desai   2021-05-20  709   * Return: 0 on success and non zero on failures.
824a156633dfdb Kashyap Desai   2021-05-20  710   */
824a156633dfdb Kashyap Desai   2021-05-20  711  static inline int mpi3mr_request_irq(struct mpi3mr_ioc *mrioc, u16 index)
824a156633dfdb Kashyap Desai   2021-05-20  712  {
824a156633dfdb Kashyap Desai   2021-05-20  713  	struct pci_dev *pdev = mrioc->pdev;
824a156633dfdb Kashyap Desai   2021-05-20  714  	struct mpi3mr_intr_info *intr_info = mrioc->intr_info + index;
824a156633dfdb Kashyap Desai   2021-05-20  715  	int retval = 0;
824a156633dfdb Kashyap Desai   2021-05-20  716  
824a156633dfdb Kashyap Desai   2021-05-20  717  	intr_info->mrioc = mrioc;
824a156633dfdb Kashyap Desai   2021-05-20  718  	intr_info->msix_index = index;
824a156633dfdb Kashyap Desai   2021-05-20  719  	intr_info->op_reply_q = NULL;
824a156633dfdb Kashyap Desai   2021-05-20  720  
824a156633dfdb Kashyap Desai   2021-05-20 @721  	snprintf(intr_info->name, MPI3MR_NAME_LENGTH, "%s%d-msix%d",
824a156633dfdb Kashyap Desai   2021-05-20  722  	    mrioc->driver_name, mrioc->id, index);
824a156633dfdb Kashyap Desai   2021-05-20  723  

:::::: The code at line 721 was first introduced by commit
:::::: 824a156633dfdb0e17979a0d0bb2c757d1bb949c scsi: mpi3mr: Base driver code

:::::: TO: Kashyap Desai <kashyap.desai@broadcom.com>
:::::: CC: Martin K. Petersen <martin.petersen@oracle.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
