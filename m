Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 557E277F0BC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 08:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348328AbjHQGtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 02:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348317AbjHQGtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 02:49:15 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 897E92705
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 23:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692254954; x=1723790954;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=IwF3ELsb7G7WN2iEO1OWOWIAlSPhvx1YYTmAg49PYwI=;
  b=aAvp9bCSy20GWm8kJhTPTNw1wny3SlSDtQ5Z3KsmUP+cg8CJznhbubR2
   Hswq5aZ67RJKX36djIK9jNHnwdwP47HGVmlShIWMtGDwRI9r8HIhHlVOq
   VP7hqZnq/z0mwwEZRzxRQ4TYis1N2pbW9CzLWa/OW8VDgRLHO/d606xZ0
   SWk2ioA2FLjW6qc59jO/1nCngSVOv5NpzVzuuXo/VQzlNFSGKTm6D+Dj7
   TFEQsmR95M87NdFaY3si9ctaj3r8xVKJ9VwQuwd6HgwCLwjphZCsGwBTW
   KorKEM43iolzJFDryFW47pCwlFnvw22m3oYBki1v4/nXyFNQbJQfNhHe9
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="375495454"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="375495454"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 23:49:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="734548646"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="734548646"
Received: from lkp-server02.sh.intel.com (HELO a9caf1a0cf30) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 16 Aug 2023 23:49:10 -0700
Received: from kbuild by a9caf1a0cf30 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qWWof-0000s7-1m;
        Thu, 17 Aug 2023 06:49:09 +0000
Date:   Thu, 17 Aug 2023 14:48:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Clark Wang <xiaoning.wang@nxp.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: drivers/i3c/master/svc-i3c-master.c:204: warning: Function parameter
 or member 'saved_regs' not described in 'svc_i3c_master'
Message-ID: <202308171435.0xQ82lvu-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   4853c74bd7ab7fdb83f319bd9ace8a08c031e9b6
commit: 1c5ee2a77b1bacd4c333bebea93610aaf17977be i3c: master: svc: fix i3c suspend/resume issue
date:   2 months ago
config: microblaze-randconfig-r025-20230817 (https://download.01.org/0day-ci/archive/20230817/202308171435.0xQ82lvu-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230817/202308171435.0xQ82lvu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308171435.0xQ82lvu-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/i3c/master/svc-i3c-master.c:204: warning: Function parameter or member 'saved_regs' not described in 'svc_i3c_master'


vim +204 drivers/i3c/master/svc-i3c-master.c

1c5ee2a77b1bac Clark Wang    2023-05-17  152  
dd3c52846d5954 Miquel Raynal 2021-01-21  153  /**
dd3c52846d5954 Miquel Raynal 2021-01-21  154   * struct svc_i3c_master - Silvaco I3C Master structure
dd3c52846d5954 Miquel Raynal 2021-01-21  155   * @base: I3C master controller
dd3c52846d5954 Miquel Raynal 2021-01-21  156   * @dev: Corresponding device
dd3c52846d5954 Miquel Raynal 2021-01-21  157   * @regs: Memory mapping
dd3c52846d5954 Miquel Raynal 2021-01-21  158   * @free_slots: Bit array of available slots
dd3c52846d5954 Miquel Raynal 2021-01-21  159   * @addrs: Array containing the dynamic addresses of each attached device
dd3c52846d5954 Miquel Raynal 2021-01-21  160   * @descs: Array of descriptors, one per attached device
dd3c52846d5954 Miquel Raynal 2021-01-21  161   * @hj_work: Hot-join work
dd3c52846d5954 Miquel Raynal 2021-01-21  162   * @ibi_work: IBI work
dd3c52846d5954 Miquel Raynal 2021-01-21  163   * @irq: Main interrupt
dd3c52846d5954 Miquel Raynal 2021-01-21  164   * @pclk: System clock
dd3c52846d5954 Miquel Raynal 2021-01-21  165   * @fclk: Fast clock (bus)
dd3c52846d5954 Miquel Raynal 2021-01-21  166   * @sclk: Slow clock (other events)
dd3c52846d5954 Miquel Raynal 2021-01-21  167   * @xferqueue: Transfer queue structure
dd3c52846d5954 Miquel Raynal 2021-01-21  168   * @xferqueue.list: List member
dd3c52846d5954 Miquel Raynal 2021-01-21  169   * @xferqueue.cur: Current ongoing transfer
dd3c52846d5954 Miquel Raynal 2021-01-21  170   * @xferqueue.lock: Queue lock
dd3c52846d5954 Miquel Raynal 2021-01-21  171   * @ibi: IBI structure
dd3c52846d5954 Miquel Raynal 2021-01-21  172   * @ibi.num_slots: Number of slots available in @ibi.slots
dd3c52846d5954 Miquel Raynal 2021-01-21  173   * @ibi.slots: Available IBI slots
dd3c52846d5954 Miquel Raynal 2021-01-21  174   * @ibi.tbq_slot: To be queued IBI slot
dd3c52846d5954 Miquel Raynal 2021-01-21  175   * @ibi.lock: IBI lock
dd3c52846d5954 Miquel Raynal 2021-01-21  176   */
dd3c52846d5954 Miquel Raynal 2021-01-21  177  struct svc_i3c_master {
dd3c52846d5954 Miquel Raynal 2021-01-21  178  	struct i3c_master_controller base;
dd3c52846d5954 Miquel Raynal 2021-01-21  179  	struct device *dev;
dd3c52846d5954 Miquel Raynal 2021-01-21  180  	void __iomem *regs;
1c5ee2a77b1bac Clark Wang    2023-05-17  181  	struct svc_i3c_regs_save saved_regs;
dd3c52846d5954 Miquel Raynal 2021-01-21  182  	u32 free_slots;
dd3c52846d5954 Miquel Raynal 2021-01-21  183  	u8 addrs[SVC_I3C_MAX_DEVS];
dd3c52846d5954 Miquel Raynal 2021-01-21  184  	struct i3c_dev_desc *descs[SVC_I3C_MAX_DEVS];
dd3c52846d5954 Miquel Raynal 2021-01-21  185  	struct work_struct hj_work;
dd3c52846d5954 Miquel Raynal 2021-01-21  186  	struct work_struct ibi_work;
dd3c52846d5954 Miquel Raynal 2021-01-21  187  	int irq;
dd3c52846d5954 Miquel Raynal 2021-01-21  188  	struct clk *pclk;
dd3c52846d5954 Miquel Raynal 2021-01-21  189  	struct clk *fclk;
dd3c52846d5954 Miquel Raynal 2021-01-21  190  	struct clk *sclk;
dd3c52846d5954 Miquel Raynal 2021-01-21  191  	struct {
dd3c52846d5954 Miquel Raynal 2021-01-21  192  		struct list_head list;
dd3c52846d5954 Miquel Raynal 2021-01-21  193  		struct svc_i3c_xfer *cur;
dd3c52846d5954 Miquel Raynal 2021-01-21  194  		/* Prevent races between transfers */
dd3c52846d5954 Miquel Raynal 2021-01-21  195  		spinlock_t lock;
dd3c52846d5954 Miquel Raynal 2021-01-21  196  	} xferqueue;
dd3c52846d5954 Miquel Raynal 2021-01-21  197  	struct {
dd3c52846d5954 Miquel Raynal 2021-01-21  198  		unsigned int num_slots;
dd3c52846d5954 Miquel Raynal 2021-01-21  199  		struct i3c_dev_desc **slots;
dd3c52846d5954 Miquel Raynal 2021-01-21  200  		struct i3c_ibi_slot *tbq_slot;
dd3c52846d5954 Miquel Raynal 2021-01-21  201  		/* Prevent races within IBI handlers */
dd3c52846d5954 Miquel Raynal 2021-01-21  202  		spinlock_t lock;
dd3c52846d5954 Miquel Raynal 2021-01-21  203  	} ibi;
dd3c52846d5954 Miquel Raynal 2021-01-21 @204  };
dd3c52846d5954 Miquel Raynal 2021-01-21  205  

:::::: The code at line 204 was first introduced by commit
:::::: dd3c52846d5954acd43f0e771689302f27dadc28 i3c: master: svc: Add Silvaco I3C master driver

:::::: TO: Miquel Raynal <miquel.raynal@bootlin.com>
:::::: CC: Alexandre Belloni <alexandre.belloni@bootlin.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
