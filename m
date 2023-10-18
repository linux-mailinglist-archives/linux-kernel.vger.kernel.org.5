Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21D937CDA2E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 13:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbjJRLVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 07:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbjJRLVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 07:21:41 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB495111
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 04:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697628098; x=1729164098;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=r6dVqWWmSayqUq9Nu7FXUft/lWJCnhEhxmJySsICjcQ=;
  b=I06s5JgjjgJDXU5PiASBDN0iS3U11QOq9QjC7WQJIbG5L2GYrxIWfuKa
   031pHmF4WwqKxmNoqZ1IYsVFGWG/hl5t7Y8VPnkEsI8gc/0RZ8YfMzVGy
   d1MdtTXSUGHY+XmSJ+WggtLc6gZ/aFfCsLJ93ZWModEjLy2fpLgqP8EZ7
   MdJT4p61PmjLGIbovGUKHrJSrlQy9G/AbcWAwGfM0yz45w/YjHMb/My3x
   gC7sB2OytkObb00KpHBVb39/eiFAnupd1IZsQWWalXYqNFwCRN9spQ2sp
   26gx1yc/Gt/FeqIbgB4NDu0qxB8mPoQXROxTY0sFMZdlgvG/JeN//nJZK
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="365341505"
X-IronPort-AV: E=Sophos;i="6.03,234,1694761200"; 
   d="scan'208";a="365341505"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 04:21:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="1003777738"
X-IronPort-AV: E=Sophos;i="6.03,234,1694761200"; 
   d="scan'208";a="1003777738"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 18 Oct 2023 04:21:36 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qt4cI-0000Hs-11;
        Wed, 18 Oct 2023 11:21:34 +0000
Date:   Wed, 18 Oct 2023 19:21:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Karan Tilak Kumar <kartilak@cisco.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sesidhar Baddela <sebaddel@cisco.com>,
        Arulprabhu Ponnusamy <arulponn@cisco.com>
Subject: drivers/scsi/fnic/fnic_scsi.c:98:38: warning: array subscript -1 is
 outside array bounds of 'struct scsi_cmnd[23529010298098917]'
Message-ID: <202310181947.fzMfU0gi-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   06dc10eae55b5ceabfef287a7e5f16ceea204aa0
commit: 514f0c400bde6b62405467daaf2a0a86bcf7794b scsi: fnic: Fix sg_reset success path
date:   3 weeks ago
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20231018/202310181947.fzMfU0gi-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231018/202310181947.fzMfU0gi-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310181947.fzMfU0gi-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In function 'fnic_io_lock_hash',
       inlined from 'fnic_fcpio_itmf_cmpl_handler' at drivers/scsi/fnic/fnic_scsi.c:1086:13:
>> drivers/scsi/fnic/fnic_scsi.c:98:38: warning: array subscript -1 is outside array bounds of 'struct scsi_cmnd[23529010298098917]' [-Warray-bounds]
      98 |         u32 hash = scsi_cmd_to_rq(sc)->tag & (FNIC_IO_LOCKS - 1);
         |                    ~~~~~~~~~~~~~~~~~~^~~~~
>> drivers/scsi/fnic/fnic_scsi.c:98:38: warning: array subscript -1 is outside array bounds of 'struct scsi_cmnd[23529010298098917]' [-Warray-bounds]
>> drivers/scsi/fnic/fnic_scsi.c:98:38: warning: array subscript -1 is outside array bounds of 'struct scsi_cmnd[23529010298098917]' [-Warray-bounds]
>> drivers/scsi/fnic/fnic_scsi.c:98:38: warning: array subscript -1 is outside array bounds of 'struct scsi_cmnd[23529010298098917]' [-Warray-bounds]


vim +98 drivers/scsi/fnic/fnic_scsi.c

5df6d737dd4b0f Abhijeet Joglekar 2009-04-17   94  
5df6d737dd4b0f Abhijeet Joglekar 2009-04-17   95  static inline spinlock_t *fnic_io_lock_hash(struct fnic *fnic,
5df6d737dd4b0f Abhijeet Joglekar 2009-04-17   96  					    struct scsi_cmnd *sc)
5df6d737dd4b0f Abhijeet Joglekar 2009-04-17   97  {
e1c9f0cfac4f2e Bart Van Assche   2021-08-09  @98  	u32 hash = scsi_cmd_to_rq(sc)->tag & (FNIC_IO_LOCKS - 1);
5df6d737dd4b0f Abhijeet Joglekar 2009-04-17   99  
5df6d737dd4b0f Abhijeet Joglekar 2009-04-17  100  	return &fnic->io_req_lock[hash];
5df6d737dd4b0f Abhijeet Joglekar 2009-04-17  101  }
5df6d737dd4b0f Abhijeet Joglekar 2009-04-17  102  

:::::: The code at line 98 was first introduced by commit
:::::: e1c9f0cfac4f2ed2bc6e89f2f4061dcf1538d4cd scsi: fnic: Use scsi_cmd_to_rq() instead of scsi_cmnd.request

:::::: TO: Bart Van Assche <bvanassche@acm.org>
:::::: CC: Martin K. Petersen <martin.petersen@oracle.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
