Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84BF08042DC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 00:51:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235576AbjLDXu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 18:50:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234874AbjLDXu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 18:50:29 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3203D1737
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 15:50:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701733812; x=1733269812;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=cqD0ebx9AvjoFI+eSDtISBhABBTDrc3sxSjfKpoRzB8=;
  b=hhgjD8Q6AAxQbppgY/l8DIt7UObl/qorPX+uyXSZKIIm2pRYQbbHkyrj
   1qG5S/t8zBJMIhVP5MQYYrvtMg6d+SCI9n1NQpCwvMlN8cL6Zt2l2ALTX
   oUYPXtgPPGAu+gpp9F+dovcd/XYzIb9VskUc4XYz0IvS23tTJdpuXWhx8
   0bsSU7/QhFVX+b/ZNxkrcOln0SXY9SZ3NYrqzfBMObDml+yxQoA3aYa2s
   2UstS7wAsi7/EL79UMOSMXPizkf0QEtjZc/Nczub1wOmx+hkHILa9NZDs
   VBVrn5p6rP5Wz37ejM3ktONuqnRPt91uga7edQYOoQBoJUHJ7i/trjfkE
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="458137670"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="458137670"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 15:49:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="861552920"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="861552920"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 04 Dec 2023 15:49:43 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rAIh2-0008BY-1g;
        Mon, 04 Dec 2023 23:49:40 +0000
Date:   Tue, 5 Dec 2023 07:49:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>
Subject: drivers/scsi/fnic/vnic_dev.c:332:32: sparse: sparse: incorrect type
 in argument 1 (different address spaces)
Message-ID: <202312050758.btNPkqxI-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   bee0e7762ad2c6025b9f5245c040fcc36ef2bde8
commit: 8f28ca6bd8211214faf717677bbffe375c2a6072 iomap: constify ioreadX() iomem argument (as in generic implementation)
date:   3 years, 4 months ago
config: x86_64-randconfig-123-20231025 (https://download.01.org/0day-ci/archive/20231205/202312050758.btNPkqxI-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231205/202312050758.btNPkqxI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312050758.btNPkqxI-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/scsi/fnic/vnic_dev.c:332:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem * @@     got unsigned int * @@
   drivers/scsi/fnic/vnic_dev.c:332:32: sparse:     expected void const [noderef] __iomem *
   drivers/scsi/fnic/vnic_dev.c:332:32: sparse:     got unsigned int *
   drivers/scsi/fnic/vnic_dev.c:333:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem * @@     got unsigned int * @@
   drivers/scsi/fnic/vnic_dev.c:333:37: sparse:     expected void const [noderef] __iomem *
   drivers/scsi/fnic/vnic_dev.c:333:37: sparse:     got unsigned int *
   drivers/scsi/fnic/vnic_dev.c:373:36: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem * @@     got unsigned int * @@
   drivers/scsi/fnic/vnic_dev.c:373:36: sparse:     expected void [noderef] __iomem *
   drivers/scsi/fnic/vnic_dev.c:373:36: sparse:     got unsigned int *
   drivers/scsi/fnic/vnic_dev.c:469:32: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct vnic_wq_ctrl *wq_ctrl @@     got struct vnic_wq_ctrl [noderef] __iomem *ctrl @@
   drivers/scsi/fnic/vnic_dev.c:469:32: sparse:     expected struct vnic_wq_ctrl *wq_ctrl
   drivers/scsi/fnic/vnic_dev.c:469:32: sparse:     got struct vnic_wq_ctrl [noderef] __iomem *ctrl
   drivers/scsi/fnic/vnic_dev.c:943:11: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *p @@     got void [noderef] __iomem * @@
   drivers/scsi/fnic/vnic_dev.c:943:11: sparse:     expected void *p
   drivers/scsi/fnic/vnic_dev.c:943:11: sparse:     got void [noderef] __iomem *

vim +332 drivers/scsi/fnic/vnic_dev.c

5df6d737dd4b0f Abhijeet Joglekar 2009-04-17  318  
363f4d937501ba Jason Yan         2020-04-15  319  static int vnic_dev_cmd2(struct vnic_dev *vdev, enum vnic_devcmd_cmd cmd,
0a2fdd2215e1fa Satish Kharat     2019-01-18  320  		int wait)
0a2fdd2215e1fa Satish Kharat     2019-01-18  321  {
0a2fdd2215e1fa Satish Kharat     2019-01-18  322  	struct devcmd2_controller *dc2c = vdev->devcmd2;
0a2fdd2215e1fa Satish Kharat     2019-01-18  323  	struct devcmd2_result *result;
0a2fdd2215e1fa Satish Kharat     2019-01-18  324  	u8 color;
0a2fdd2215e1fa Satish Kharat     2019-01-18  325  	unsigned int i;
0a2fdd2215e1fa Satish Kharat     2019-01-18  326  	int delay;
0a2fdd2215e1fa Satish Kharat     2019-01-18  327  	int err;
0a2fdd2215e1fa Satish Kharat     2019-01-18  328  	u32 fetch_index;
0a2fdd2215e1fa Satish Kharat     2019-01-18  329  	u32 posted;
0a2fdd2215e1fa Satish Kharat     2019-01-18  330  	u32 new_posted;
0a2fdd2215e1fa Satish Kharat     2019-01-18  331  
0a2fdd2215e1fa Satish Kharat     2019-01-18 @332  	posted = ioread32(&dc2c->wq_ctrl->posted_index);
0a2fdd2215e1fa Satish Kharat     2019-01-18  333  	fetch_index = ioread32(&dc2c->wq_ctrl->fetch_index);
0a2fdd2215e1fa Satish Kharat     2019-01-18  334  
0a2fdd2215e1fa Satish Kharat     2019-01-18  335  	if (posted == 0xFFFFFFFF || fetch_index == 0xFFFFFFFF) {
0a2fdd2215e1fa Satish Kharat     2019-01-18  336  		/* Hardware surprise removal: return error */
0a2fdd2215e1fa Satish Kharat     2019-01-18  337  		pr_err("%s: devcmd2 invalid posted or fetch index on cmd %d\n",
0a2fdd2215e1fa Satish Kharat     2019-01-18  338  				pci_name(vdev->pdev), _CMD_N(cmd));
0a2fdd2215e1fa Satish Kharat     2019-01-18  339  		pr_err("%s: fetch index: %u, posted index: %u\n",
0a2fdd2215e1fa Satish Kharat     2019-01-18  340  				pci_name(vdev->pdev), fetch_index, posted);
0a2fdd2215e1fa Satish Kharat     2019-01-18  341  
0a2fdd2215e1fa Satish Kharat     2019-01-18  342  		return -ENODEV;
0a2fdd2215e1fa Satish Kharat     2019-01-18  343  
0a2fdd2215e1fa Satish Kharat     2019-01-18  344  	}
0a2fdd2215e1fa Satish Kharat     2019-01-18  345  
0a2fdd2215e1fa Satish Kharat     2019-01-18  346  	new_posted = (posted + 1) % DEVCMD2_RING_SIZE;
0a2fdd2215e1fa Satish Kharat     2019-01-18  347  
0a2fdd2215e1fa Satish Kharat     2019-01-18  348  	if (new_posted == fetch_index) {
0a2fdd2215e1fa Satish Kharat     2019-01-18  349  		pr_err("%s: devcmd2 wq full while issuing cmd %d\n",
0a2fdd2215e1fa Satish Kharat     2019-01-18  350  				pci_name(vdev->pdev), _CMD_N(cmd));
0a2fdd2215e1fa Satish Kharat     2019-01-18  351  		pr_err("%s: fetch index: %u, posted index: %u\n",
0a2fdd2215e1fa Satish Kharat     2019-01-18  352  				pci_name(vdev->pdev), fetch_index, posted);
0a2fdd2215e1fa Satish Kharat     2019-01-18  353  		return -EBUSY;
0a2fdd2215e1fa Satish Kharat     2019-01-18  354  
0a2fdd2215e1fa Satish Kharat     2019-01-18  355  	}
0a2fdd2215e1fa Satish Kharat     2019-01-18  356  	dc2c->cmd_ring[posted].cmd = cmd;
0a2fdd2215e1fa Satish Kharat     2019-01-18  357  	dc2c->cmd_ring[posted].flags = 0;
0a2fdd2215e1fa Satish Kharat     2019-01-18  358  
0a2fdd2215e1fa Satish Kharat     2019-01-18  359  	if ((_CMD_FLAGS(cmd) & _CMD_FLAGS_NOWAIT))
0a2fdd2215e1fa Satish Kharat     2019-01-18  360  		dc2c->cmd_ring[posted].flags |= DEVCMD2_FNORESULT;
0a2fdd2215e1fa Satish Kharat     2019-01-18  361  	if (_CMD_DIR(cmd) & _CMD_DIR_WRITE) {
0a2fdd2215e1fa Satish Kharat     2019-01-18  362  		for (i = 0; i < VNIC_DEVCMD_NARGS; i++)
0a2fdd2215e1fa Satish Kharat     2019-01-18  363  			dc2c->cmd_ring[posted].args[i] = vdev->args[i];
0a2fdd2215e1fa Satish Kharat     2019-01-18  364  
0a2fdd2215e1fa Satish Kharat     2019-01-18  365  	}
0a2fdd2215e1fa Satish Kharat     2019-01-18  366  
0a2fdd2215e1fa Satish Kharat     2019-01-18  367  	/* Adding write memory barrier prevents compiler and/or CPU
0a2fdd2215e1fa Satish Kharat     2019-01-18  368  	 * reordering, thus avoiding descriptor posting before
0a2fdd2215e1fa Satish Kharat     2019-01-18  369  	 * descriptor is initialized. Otherwise, hardware can read
0a2fdd2215e1fa Satish Kharat     2019-01-18  370  	 * stale descriptor fields.
0a2fdd2215e1fa Satish Kharat     2019-01-18  371  	 */
0a2fdd2215e1fa Satish Kharat     2019-01-18  372  	wmb();
0a2fdd2215e1fa Satish Kharat     2019-01-18  373  	iowrite32(new_posted, &dc2c->wq_ctrl->posted_index);
0a2fdd2215e1fa Satish Kharat     2019-01-18  374  
0a2fdd2215e1fa Satish Kharat     2019-01-18  375  	if (dc2c->cmd_ring[posted].flags & DEVCMD2_FNORESULT)
0a2fdd2215e1fa Satish Kharat     2019-01-18  376  		return 0;
0a2fdd2215e1fa Satish Kharat     2019-01-18  377  
0a2fdd2215e1fa Satish Kharat     2019-01-18  378  	result = dc2c->result + dc2c->next_result;
0a2fdd2215e1fa Satish Kharat     2019-01-18  379  	color = dc2c->color;
0a2fdd2215e1fa Satish Kharat     2019-01-18  380  
0a2fdd2215e1fa Satish Kharat     2019-01-18  381  	dc2c->next_result++;
0a2fdd2215e1fa Satish Kharat     2019-01-18  382  	if (dc2c->next_result == dc2c->result_size) {
0a2fdd2215e1fa Satish Kharat     2019-01-18  383  		dc2c->next_result = 0;
0a2fdd2215e1fa Satish Kharat     2019-01-18  384  		dc2c->color = dc2c->color ? 0 : 1;
0a2fdd2215e1fa Satish Kharat     2019-01-18  385  	}
0a2fdd2215e1fa Satish Kharat     2019-01-18  386  
0a2fdd2215e1fa Satish Kharat     2019-01-18  387  	for (delay = 0; delay < wait; delay++) {
0a2fdd2215e1fa Satish Kharat     2019-01-18  388  		udelay(100);
0a2fdd2215e1fa Satish Kharat     2019-01-18  389  		if (result->color == color) {
0a2fdd2215e1fa Satish Kharat     2019-01-18  390  			if (result->error) {
0a2fdd2215e1fa Satish Kharat     2019-01-18  391  				err = -(int) result->error;
0a2fdd2215e1fa Satish Kharat     2019-01-18  392  				if (err != ERR_ECMDUNKNOWN ||
0a2fdd2215e1fa Satish Kharat     2019-01-18  393  						cmd != CMD_CAPABILITY)
0a2fdd2215e1fa Satish Kharat     2019-01-18  394  					pr_err("%s:Error %d devcmd %d\n",
0a2fdd2215e1fa Satish Kharat     2019-01-18  395  						pci_name(vdev->pdev),
0a2fdd2215e1fa Satish Kharat     2019-01-18  396  						err, _CMD_N(cmd));
0a2fdd2215e1fa Satish Kharat     2019-01-18  397  				return err;
0a2fdd2215e1fa Satish Kharat     2019-01-18  398  			}
0a2fdd2215e1fa Satish Kharat     2019-01-18  399  			if (_CMD_DIR(cmd) & _CMD_DIR_READ) {
0a2fdd2215e1fa Satish Kharat     2019-01-18  400  				rmb(); /*prevent reorder while reding result*/
0a2fdd2215e1fa Satish Kharat     2019-01-18  401  				for (i = 0; i < VNIC_DEVCMD_NARGS; i++)
0a2fdd2215e1fa Satish Kharat     2019-01-18  402  					vdev->args[i] = result->results[i];
0a2fdd2215e1fa Satish Kharat     2019-01-18  403  			}
0a2fdd2215e1fa Satish Kharat     2019-01-18  404  			return 0;
0a2fdd2215e1fa Satish Kharat     2019-01-18  405  		}
0a2fdd2215e1fa Satish Kharat     2019-01-18  406  	}
0a2fdd2215e1fa Satish Kharat     2019-01-18  407  
0a2fdd2215e1fa Satish Kharat     2019-01-18  408  	pr_err("%s:Timed out devcmd %d\n", pci_name(vdev->pdev), _CMD_N(cmd));
0a2fdd2215e1fa Satish Kharat     2019-01-18  409  
0a2fdd2215e1fa Satish Kharat     2019-01-18  410  	return -ETIMEDOUT;
0a2fdd2215e1fa Satish Kharat     2019-01-18  411  }
0a2fdd2215e1fa Satish Kharat     2019-01-18  412  

:::::: The code at line 332 was first introduced by commit
:::::: 0a2fdd2215e1fa3b417792bd6e9cb719822cbfb6 scsi: fnic: Adding devcmd2 init and posting interfaces

:::::: TO: Satish Kharat <satishkh@cisco.com>
:::::: CC: Martin K. Petersen <martin.petersen@oracle.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
