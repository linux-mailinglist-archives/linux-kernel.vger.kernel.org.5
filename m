Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB1F7996C1
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 09:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343498AbjIIHnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 03:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241735AbjIIHnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 03:43:00 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B46419A5
        for <linux-kernel@vger.kernel.org>; Sat,  9 Sep 2023 00:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694245375; x=1725781375;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=vrV7eID+EpNFWHsHgEhdGzIjenU+vubPeFIcJg5eUZg=;
  b=fZsn+aoq5+M9x61lOuKGsQKpEwW5KUVkRxjvEq9inooVl7lWfWiOsVPh
   JQg5xWoNdmD9uvrSraGDXWQyEQL0f6DETX8uNpNyDk+hk7ljILGqVlnb+
   QWqCtjcBWasEKGXgNB+nf+u/LY/T/flwrr4hmM97RKABebw+ul1hxe4gX
   baylR8X9OKTVujM+KCKyxfVn6XveaDKamEQEIQDGbpb+IWPqqeRn2Qa6n
   y0eoUjVzjCTm3KKuiKzJS7gNJHGo1fIJtb0NOfezL9x7lPoKfa/CXpEsU
   2QfoQZBO7fRl7XQcCGo7P5JJlb57J01NSGA8MwA2rqOzVHQekoIDMrRev
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="444234731"
X-IronPort-AV: E=Sophos;i="6.02,239,1688454000"; 
   d="scan'208";a="444234731"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2023 00:42:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="832915246"
X-IronPort-AV: E=Sophos;i="6.02,239,1688454000"; 
   d="scan'208";a="832915246"
Received: from lkp-server01.sh.intel.com (HELO 59b3c6e06877) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 09 Sep 2023 00:42:52 -0700
Received: from kbuild by 59b3c6e06877 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qescE-000361-2L;
        Sat, 09 Sep 2023 07:42:50 +0000
Date:   Sat, 9 Sep 2023 15:42:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Brian King <brking@linux.vnet.ibm.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        John Garry <john.g.garry@oracle.com>
Subject: drivers/scsi/ipr.c:5430:6: warning: variable 'ioasc' set but not used
Message-ID: <202309091516.3PVdvSso-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6099776f9f268e61fe5ecd721f994a8cfce5306f
commit: 65a15d6560dff065339f6cac91de4beded60fe3f scsi: ipr: Remove SATA support
date:   5 months ago
config: x86_64-randconfig-005-20230909 (https://download.01.org/0day-ci/archive/20230909/202309091516.3PVdvSso-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230909/202309091516.3PVdvSso-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309091516.3PVdvSso-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/scsi/ipr.c: In function 'ipr_init_res_entry':
   drivers/scsi/ipr.c:1104:15: warning: variable 'proto' set but not used [-Wunused-but-set-variable]
    1104 |  unsigned int proto;
         |               ^~~~~
   drivers/scsi/ipr.c: In function 'ipr_update_res_entry':
   drivers/scsi/ipr.c:1261:15: warning: variable 'proto' set but not used [-Wunused-but-set-variable]
    1261 |  unsigned int proto;
         |               ^~~~~
   drivers/scsi/ipr.c: In function 'ipr_change_queue_depth':
   drivers/scsi/ipr.c:4417:29: warning: variable 'res' set but not used [-Wunused-but-set-variable]
    4417 |  struct ipr_resource_entry *res;
         |                             ^~~
   drivers/scsi/ipr.c: In function 'ipr_process_hrrq':
>> drivers/scsi/ipr.c:5430:6: warning: variable 'ioasc' set but not used [-Wunused-but-set-variable]
    5430 |  u32 ioasc;
         |      ^~~~~


vim +/ioasc +5430 drivers/scsi/ipr.c

3feeb89d40cc0ab Wayne Boyer                 2009-10-20  5426  
b53d124a154d002 wenxiong@linux.vnet.ibm.com 2013-01-11  5427  static int ipr_process_hrrq(struct ipr_hrr_queue *hrr_queue, int budget,
05a6538a9a20499 wenxiong@linux.vnet.ibm.com 2013-01-11  5428  						struct list_head *doneq)
05a6538a9a20499 wenxiong@linux.vnet.ibm.com 2013-01-11  5429  {
05a6538a9a20499 wenxiong@linux.vnet.ibm.com 2013-01-11 @5430  	u32 ioasc;
05a6538a9a20499 wenxiong@linux.vnet.ibm.com 2013-01-11  5431  	u16 cmd_index;
05a6538a9a20499 wenxiong@linux.vnet.ibm.com 2013-01-11  5432  	struct ipr_cmnd *ipr_cmd;
05a6538a9a20499 wenxiong@linux.vnet.ibm.com 2013-01-11  5433  	struct ipr_ioa_cfg *ioa_cfg = hrr_queue->ioa_cfg;
05a6538a9a20499 wenxiong@linux.vnet.ibm.com 2013-01-11  5434  	int num_hrrq = 0;
05a6538a9a20499 wenxiong@linux.vnet.ibm.com 2013-01-11  5435  
05a6538a9a20499 wenxiong@linux.vnet.ibm.com 2013-01-11  5436  	/* If interrupts are disabled, ignore the interrupt */
56d6aa33d3f6847 wenxiong@linux.vnet.ibm.com 2013-01-11  5437  	if (!hrr_queue->allow_interrupts)
05a6538a9a20499 wenxiong@linux.vnet.ibm.com 2013-01-11  5438  		return 0;
05a6538a9a20499 wenxiong@linux.vnet.ibm.com 2013-01-11  5439  
05a6538a9a20499 wenxiong@linux.vnet.ibm.com 2013-01-11  5440  	while ((be32_to_cpu(*hrr_queue->hrrq_curr) & IPR_HRRQ_TOGGLE_BIT) ==
05a6538a9a20499 wenxiong@linux.vnet.ibm.com 2013-01-11  5441  	       hrr_queue->toggle_bit) {
05a6538a9a20499 wenxiong@linux.vnet.ibm.com 2013-01-11  5442  
05a6538a9a20499 wenxiong@linux.vnet.ibm.com 2013-01-11  5443  		cmd_index = (be32_to_cpu(*hrr_queue->hrrq_curr) &
05a6538a9a20499 wenxiong@linux.vnet.ibm.com 2013-01-11  5444  			     IPR_HRRQ_REQ_RESP_HANDLE_MASK) >>
05a6538a9a20499 wenxiong@linux.vnet.ibm.com 2013-01-11  5445  			     IPR_HRRQ_REQ_RESP_HANDLE_SHIFT;
05a6538a9a20499 wenxiong@linux.vnet.ibm.com 2013-01-11  5446  
05a6538a9a20499 wenxiong@linux.vnet.ibm.com 2013-01-11  5447  		if (unlikely(cmd_index > hrr_queue->max_cmd_id ||
05a6538a9a20499 wenxiong@linux.vnet.ibm.com 2013-01-11  5448  			     cmd_index < hrr_queue->min_cmd_id)) {
05a6538a9a20499 wenxiong@linux.vnet.ibm.com 2013-01-11  5449  			ipr_isr_eh(ioa_cfg,
05a6538a9a20499 wenxiong@linux.vnet.ibm.com 2013-01-11  5450  				"Invalid response handle from IOA: ",
05a6538a9a20499 wenxiong@linux.vnet.ibm.com 2013-01-11  5451  				cmd_index);
05a6538a9a20499 wenxiong@linux.vnet.ibm.com 2013-01-11  5452  			break;
05a6538a9a20499 wenxiong@linux.vnet.ibm.com 2013-01-11  5453  		}
05a6538a9a20499 wenxiong@linux.vnet.ibm.com 2013-01-11  5454  
05a6538a9a20499 wenxiong@linux.vnet.ibm.com 2013-01-11  5455  		ipr_cmd = ioa_cfg->ipr_cmnd_list[cmd_index];
05a6538a9a20499 wenxiong@linux.vnet.ibm.com 2013-01-11  5456  		ioasc = be32_to_cpu(ipr_cmd->s.ioasa.hdr.ioasc);
05a6538a9a20499 wenxiong@linux.vnet.ibm.com 2013-01-11  5457  
05a6538a9a20499 wenxiong@linux.vnet.ibm.com 2013-01-11  5458  		ipr_trc_hook(ipr_cmd, IPR_TRACE_FINISH, ioasc);
05a6538a9a20499 wenxiong@linux.vnet.ibm.com 2013-01-11  5459  
05a6538a9a20499 wenxiong@linux.vnet.ibm.com 2013-01-11  5460  		list_move_tail(&ipr_cmd->queue, doneq);
05a6538a9a20499 wenxiong@linux.vnet.ibm.com 2013-01-11  5461  
05a6538a9a20499 wenxiong@linux.vnet.ibm.com 2013-01-11  5462  		if (hrr_queue->hrrq_curr < hrr_queue->hrrq_end) {
05a6538a9a20499 wenxiong@linux.vnet.ibm.com 2013-01-11  5463  			hrr_queue->hrrq_curr++;
05a6538a9a20499 wenxiong@linux.vnet.ibm.com 2013-01-11  5464  		} else {
05a6538a9a20499 wenxiong@linux.vnet.ibm.com 2013-01-11  5465  			hrr_queue->hrrq_curr = hrr_queue->hrrq_start;
05a6538a9a20499 wenxiong@linux.vnet.ibm.com 2013-01-11  5466  			hrr_queue->toggle_bit ^= 1u;
05a6538a9a20499 wenxiong@linux.vnet.ibm.com 2013-01-11  5467  		}
05a6538a9a20499 wenxiong@linux.vnet.ibm.com 2013-01-11  5468  		num_hrrq++;
b53d124a154d002 wenxiong@linux.vnet.ibm.com 2013-01-11  5469  		if (budget > 0 && num_hrrq >= budget)
b53d124a154d002 wenxiong@linux.vnet.ibm.com 2013-01-11  5470  			break;
05a6538a9a20499 wenxiong@linux.vnet.ibm.com 2013-01-11  5471  	}
b53d124a154d002 wenxiong@linux.vnet.ibm.com 2013-01-11  5472  
05a6538a9a20499 wenxiong@linux.vnet.ibm.com 2013-01-11  5473  	return num_hrrq;
05a6538a9a20499 wenxiong@linux.vnet.ibm.com 2013-01-11  5474  }
b53d124a154d002 wenxiong@linux.vnet.ibm.com 2013-01-11  5475  

:::::: The code at line 5430 was first introduced by commit
:::::: 05a6538a9a204999e0c0f7faee00b81b334f4fc7 [SCSI] ipr: Add support for MSI-X and distributed completion

:::::: TO: wenxiong@linux.vnet.ibm.com <wenxiong@linux.vnet.ibm.com>
:::::: CC: James Bottomley <JBottomley@Parallels.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
