Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9D177F83D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 16:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351642AbjHQOCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 10:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351637AbjHQOCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 10:02:10 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48CDD2D5A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 07:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692280929; x=1723816929;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=JuPa8OVLOG69vezId3TNDdzM98GUMGynxIy+MWC7MRk=;
  b=LPUF7SkkgZHM9bNe96PCl0+nRRAVS4n58eemOtLbmrR6Vv5viym/c06Y
   AaGmGjy0qThxy0NWlmudvPwlUINDUaP41t8y01Ww2bGI6kfVaMszjIho4
   c4oUGdlNGqKye79x2Q3Vi+jaYEwy4rbRhJ0ROuQzTAIvux4ipfdiBkR7r
   5b40lBv+Om/Y5tTBfk2/1F8GQNyqZgFy+BaDyI2ILzxBhIe0sxBGDeuxx
   UbsDro9h3Oc8vy9yuHEI8Vkc4pTwlIbCV8vPkCYfhgaxE1+PLHkKqnRq4
   DsE6NQKd/jDwIN5WYj9uu8FAWeI97g2VfPPvQxws8nDR6Ph+xVaF5YqeP
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="376566208"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="376566208"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 06:29:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="734659761"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="734659761"
Received: from lkp-server02.sh.intel.com (HELO a9caf1a0cf30) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 17 Aug 2023 06:29:18 -0700
Received: from kbuild by a9caf1a0cf30 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qWd3p-0001AN-2I;
        Thu, 17 Aug 2023 13:29:14 +0000
Date:   Thu, 17 Aug 2023 21:28:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kashyap Desai <kashyap.desai@broadcom.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Leon Romanovsky <leon@kernel.org>,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: drivers/infiniband/hw/bnxt_re/qplib_rcfw.c:68: warning: Function
 parameter or member 'rcfw' not described in '__wait_for_resp'
Message-ID: <202308172136.ipx1wvs6-lkp@intel.com>
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
head:   4853c74bd7ab7fdb83f319bd9ace8a08c031e9b6
commit: 8cf1d12ad56beb73d2439ccf334b7148e71de58e RDMA/bnxt_re: Enhance the existing functions that wait for FW responses
date:   9 weeks ago
config: sparc-allyesconfig (https://download.01.org/0day-ci/archive/20230817/202308172136.ipx1wvs6-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230817/202308172136.ipx1wvs6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308172136.ipx1wvs6-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/infiniband/hw/bnxt_re/qplib_rcfw.c:68: warning: Function parameter or member 'rcfw' not described in '__wait_for_resp'
>> drivers/infiniband/hw/bnxt_re/qplib_rcfw.c:68: warning: Function parameter or member 'cookie' not described in '__wait_for_resp'
>> drivers/infiniband/hw/bnxt_re/qplib_rcfw.c:106: warning: Function parameter or member 'rcfw' not described in '__block_for_resp'
>> drivers/infiniband/hw/bnxt_re/qplib_rcfw.c:106: warning: Function parameter or member 'cookie' not described in '__block_for_resp'


vim +68 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c

1ac5a404797523 Selvin Xavier 2017-02-10   55  
8cf1d12ad56beb Kashyap Desai 2023-06-09   56  /**
8cf1d12ad56beb Kashyap Desai 2023-06-09   57   * __wait_for_resp   -	Don't hold the cpu context and wait for response
8cf1d12ad56beb Kashyap Desai 2023-06-09   58   * @rcfw      -   rcfw channel instance of rdev
8cf1d12ad56beb Kashyap Desai 2023-06-09   59   * @cookie    -   cookie to track the command
8cf1d12ad56beb Kashyap Desai 2023-06-09   60   *
8cf1d12ad56beb Kashyap Desai 2023-06-09   61   * Wait for command completion in sleepable context.
8cf1d12ad56beb Kashyap Desai 2023-06-09   62   *
8cf1d12ad56beb Kashyap Desai 2023-06-09   63   * Returns:
8cf1d12ad56beb Kashyap Desai 2023-06-09   64   * 0 if command is completed by firmware.
8cf1d12ad56beb Kashyap Desai 2023-06-09   65   * Non zero error code for rest of the case.
8cf1d12ad56beb Kashyap Desai 2023-06-09   66   */
cc1ec769b87c7d Devesh Sharma 2017-05-22   67  static int __wait_for_resp(struct bnxt_qplib_rcfw *rcfw, u16 cookie)
1ac5a404797523 Selvin Xavier 2017-02-10  @68  {
cee0c7bba48691 Devesh Sharma 2020-02-15   69  	struct bnxt_qplib_cmdq_ctx *cmdq;
1ac5a404797523 Selvin Xavier 2017-02-10   70  	u16 cbit;
8cf1d12ad56beb Kashyap Desai 2023-06-09   71  	int ret;
1ac5a404797523 Selvin Xavier 2017-02-10   72  
cee0c7bba48691 Devesh Sharma 2020-02-15   73  	cmdq = &rcfw->cmdq;
bd1c24ccf9eb07 Devesh Sharma 2018-12-12   74  	cbit = cookie % rcfw->cmdq_depth;
8cf1d12ad56beb Kashyap Desai 2023-06-09   75  
8cf1d12ad56beb Kashyap Desai 2023-06-09   76  	do {
8cf1d12ad56beb Kashyap Desai 2023-06-09   77  		/* Non zero means command completed */
8cf1d12ad56beb Kashyap Desai 2023-06-09   78  		ret = wait_event_timeout(cmdq->waitq,
cee0c7bba48691 Devesh Sharma 2020-02-15   79  					 !test_bit(cbit, cmdq->cmdq_bitmap),
8cf1d12ad56beb Kashyap Desai 2023-06-09   80  					 msecs_to_jiffies(10000));
8cf1d12ad56beb Kashyap Desai 2023-06-09   81  
8cf1d12ad56beb Kashyap Desai 2023-06-09   82  		if (!test_bit(cbit, cmdq->cmdq_bitmap))
8cf1d12ad56beb Kashyap Desai 2023-06-09   83  			return 0;
8cf1d12ad56beb Kashyap Desai 2023-06-09   84  
8cf1d12ad56beb Kashyap Desai 2023-06-09   85  		bnxt_qplib_service_creq(&rcfw->creq.creq_tasklet);
8cf1d12ad56beb Kashyap Desai 2023-06-09   86  
8cf1d12ad56beb Kashyap Desai 2023-06-09   87  		if (!test_bit(cbit, cmdq->cmdq_bitmap))
8cf1d12ad56beb Kashyap Desai 2023-06-09   88  			return 0;
8cf1d12ad56beb Kashyap Desai 2023-06-09   89  
8cf1d12ad56beb Kashyap Desai 2023-06-09   90  	} while (true);
1ac5a404797523 Selvin Xavier 2017-02-10   91  };
1ac5a404797523 Selvin Xavier 2017-02-10   92  
8cf1d12ad56beb Kashyap Desai 2023-06-09   93  /**
8cf1d12ad56beb Kashyap Desai 2023-06-09   94   * __block_for_resp   -	hold the cpu context and wait for response
8cf1d12ad56beb Kashyap Desai 2023-06-09   95   * @rcfw      -   rcfw channel instance of rdev
8cf1d12ad56beb Kashyap Desai 2023-06-09   96   * @cookie    -   cookie to track the command
8cf1d12ad56beb Kashyap Desai 2023-06-09   97   *
8cf1d12ad56beb Kashyap Desai 2023-06-09   98   * This function will hold the cpu (non-sleepable context) and
8cf1d12ad56beb Kashyap Desai 2023-06-09   99   * wait for command completion. Maximum holding interval is 8 second.
8cf1d12ad56beb Kashyap Desai 2023-06-09  100   *
8cf1d12ad56beb Kashyap Desai 2023-06-09  101   * Returns:
8cf1d12ad56beb Kashyap Desai 2023-06-09  102   * -ETIMEOUT if command is not completed in specific time interval.
8cf1d12ad56beb Kashyap Desai 2023-06-09  103   * 0 if command is completed by firmware.
8cf1d12ad56beb Kashyap Desai 2023-06-09  104   */
cc1ec769b87c7d Devesh Sharma 2017-05-22  105  static int __block_for_resp(struct bnxt_qplib_rcfw *rcfw, u16 cookie)
1ac5a404797523 Selvin Xavier 2017-02-10 @106  {
8cf1d12ad56beb Kashyap Desai 2023-06-09  107  	struct bnxt_qplib_cmdq_ctx *cmdq = &rcfw->cmdq;
8cf1d12ad56beb Kashyap Desai 2023-06-09  108  	unsigned long issue_time = 0;
1ac5a404797523 Selvin Xavier 2017-02-10  109  	u16 cbit;
1ac5a404797523 Selvin Xavier 2017-02-10  110  
bd1c24ccf9eb07 Devesh Sharma 2018-12-12  111  	cbit = cookie % rcfw->cmdq_depth;
8cf1d12ad56beb Kashyap Desai 2023-06-09  112  	issue_time = jiffies;
8cf1d12ad56beb Kashyap Desai 2023-06-09  113  
1ac5a404797523 Selvin Xavier 2017-02-10  114  	do {
b9b43ad3ce883f Selvin Xavier 2021-09-15  115  		udelay(1);
8cf1d12ad56beb Kashyap Desai 2023-06-09  116  
53c2a706ae7858 Allen Pais    2020-09-03  117  		bnxt_qplib_service_creq(&rcfw->creq.creq_tasklet);
8cf1d12ad56beb Kashyap Desai 2023-06-09  118  		if (!test_bit(cbit, cmdq->cmdq_bitmap))
8cf1d12ad56beb Kashyap Desai 2023-06-09  119  			return 0;
8cf1d12ad56beb Kashyap Desai 2023-06-09  120  
8cf1d12ad56beb Kashyap Desai 2023-06-09  121  	} while (time_before(jiffies, issue_time + (8 * HZ)));
8cf1d12ad56beb Kashyap Desai 2023-06-09  122  
8cf1d12ad56beb Kashyap Desai 2023-06-09  123  	return -ETIMEDOUT;
1ac5a404797523 Selvin Xavier 2017-02-10  124  };
1ac5a404797523 Selvin Xavier 2017-02-10  125  

:::::: The code at line 68 was first introduced by commit
:::::: 1ac5a404797523cedaf424a3aaa3cf8f9548dff8 RDMA/bnxt_re: Add bnxt_re RoCE driver

:::::: TO: Selvin Xavier <selvin.xavier@broadcom.com>
:::::: CC: Doug Ledford <dledford@redhat.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
