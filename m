Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B282809002
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 19:36:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233041AbjLGSdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 13:33:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232994AbjLGSdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 13:33:40 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B66E0
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 10:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701974025; x=1733510025;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=MQBjZ8+y+p2IJ6g3NcHVHa4SyQJVTgb4ouRIiHCadbQ=;
  b=IqmNCIZrqZniwK0lzryu0Gxw/ozuaypvLTpsOl8sq8m8OJwq3TO4aUF8
   IkkrMFthlJNcjTKyieesgEEXD9IXLblqI8/u0vVTx36M+6Q4Xy7Ajbuyv
   2CaqO0l9Si/bNzZbbgokaQRig9TiFc9atsUj9FiF56RkcW8/b8JdII/iJ
   C5OhedRNO/POYHg6GgUogUoznU8Mp3Kss9zReKmPy+U60o79aQN2byHAG
   vgMDO4UwlDfKPHvgOhMxBIP2YtOjY158aUSIvkwlcF3tvum/c5xg7YS2N
   KLLgkqCk3i1EdJwAIfJHa1l12nYYxVreAXUSnZTvAsv/BSyfS4on94m4e
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="12992459"
X-IronPort-AV: E=Sophos;i="6.04,258,1695711600"; 
   d="scan'208";a="12992459"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 10:33:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="945131425"
X-IronPort-AV: E=Sophos;i="6.04,258,1695711600"; 
   d="scan'208";a="945131425"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 07 Dec 2023 10:33:43 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rBJBs-000Cg7-1r;
        Thu, 07 Dec 2023 18:33:40 +0000
Date:   Fri, 8 Dec 2023 02:32:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Satish Kharat <satishkh@cisco.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: drivers/scsi/fnic/vnic_dev.c:332:32: sparse: sparse: incorrect type
 in argument 1 (different address spaces)
Message-ID: <202312080252.JoDdCz3O-lkp@intel.com>
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
commit: 0a2fdd2215e1fa3b417792bd6e9cb719822cbfb6 scsi: fnic: Adding devcmd2 init and posting interfaces
date:   4 years, 11 months ago
config: x86_64-randconfig-123-20231025 (https://download.01.org/0day-ci/archive/20231208/202312080252.JoDdCz3O-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231208/202312080252.JoDdCz3O-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312080252.JoDdCz3O-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/scsi/fnic/vnic_dev.c:257:5: sparse: sparse: symbol 'vnic_dev_cmd1' was not declared. Should it be static?
>> drivers/scsi/fnic/vnic_dev.c:332:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem * @@     got unsigned int * @@
   drivers/scsi/fnic/vnic_dev.c:332:32: sparse:     expected void [noderef] __iomem *
   drivers/scsi/fnic/vnic_dev.c:332:32: sparse:     got unsigned int *
   drivers/scsi/fnic/vnic_dev.c:333:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem * @@     got unsigned int * @@
   drivers/scsi/fnic/vnic_dev.c:333:37: sparse:     expected void [noderef] __iomem *
   drivers/scsi/fnic/vnic_dev.c:333:37: sparse:     got unsigned int *
   drivers/scsi/fnic/vnic_dev.c:373:36: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem * @@     got unsigned int * @@
   drivers/scsi/fnic/vnic_dev.c:373:36: sparse:     expected void [noderef] __iomem *
   drivers/scsi/fnic/vnic_dev.c:373:36: sparse:     got unsigned int *
   drivers/scsi/fnic/vnic_dev.c:319:5: sparse: sparse: symbol 'vnic_dev_cmd2' was not declared. Should it be static?
>> drivers/scsi/fnic/vnic_dev.c:469:32: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct vnic_wq_ctrl *wq_ctrl @@     got struct vnic_wq_ctrl [noderef] __iomem *ctrl @@
   drivers/scsi/fnic/vnic_dev.c:469:32: sparse:     expected struct vnic_wq_ctrl *wq_ctrl
   drivers/scsi/fnic/vnic_dev.c:469:32: sparse:     got struct vnic_wq_ctrl [noderef] __iomem *ctrl

vim +332 drivers/scsi/fnic/vnic_dev.c

   256	
 > 257	int vnic_dev_cmd1(struct vnic_dev *vdev, enum vnic_devcmd_cmd cmd, int wait)
   258	{
   259		struct vnic_devcmd __iomem *devcmd = vdev->devcmd;
   260		int delay;
   261		u32 status;
   262		int dev_cmd_err[] = {
   263			/* convert from fw's version of error.h to host's version */
   264			0,	/* ERR_SUCCESS */
   265			EINVAL,	/* ERR_EINVAL */
   266			EFAULT,	/* ERR_EFAULT */
   267			EPERM,	/* ERR_EPERM */
   268			EBUSY,  /* ERR_EBUSY */
   269		};
   270		int err;
   271		u64 *a0 = &vdev->args[0];
   272		u64 *a1 = &vdev->args[1];
   273	
   274		status = ioread32(&devcmd->status);
   275		if (status & STAT_BUSY) {
   276			printk(KERN_ERR "Busy devcmd %d\n", _CMD_N(cmd));
   277			return -EBUSY;
   278		}
   279	
   280		if (_CMD_DIR(cmd) & _CMD_DIR_WRITE) {
   281			writeq(*a0, &devcmd->args[0]);
   282			writeq(*a1, &devcmd->args[1]);
   283			wmb();
   284		}
   285	
   286		iowrite32(cmd, &devcmd->cmd);
   287	
   288		if ((_CMD_FLAGS(cmd) & _CMD_FLAGS_NOWAIT))
   289				return 0;
   290	
   291		for (delay = 0; delay < wait; delay++) {
   292	
   293			udelay(100);
   294	
   295			status = ioread32(&devcmd->status);
   296			if (!(status & STAT_BUSY)) {
   297	
   298				if (status & STAT_ERROR) {
   299					err = dev_cmd_err[(int)readq(&devcmd->args[0])];
   300					printk(KERN_ERR "Error %d devcmd %d\n",
   301						err, _CMD_N(cmd));
   302					return -err;
   303				}
   304	
   305				if (_CMD_DIR(cmd) & _CMD_DIR_READ) {
   306					rmb();
   307					*a0 = readq(&devcmd->args[0]);
   308					*a1 = readq(&devcmd->args[1]);
   309				}
   310	
   311				return 0;
   312			}
   313		}
   314	
   315		printk(KERN_ERR "Timedout devcmd %d\n", _CMD_N(cmd));
   316		return -ETIMEDOUT;
   317	}
   318	
   319	int vnic_dev_cmd2(struct vnic_dev *vdev, enum vnic_devcmd_cmd cmd,
   320			int wait)
   321	{
   322		struct devcmd2_controller *dc2c = vdev->devcmd2;
   323		struct devcmd2_result *result;
   324		u8 color;
   325		unsigned int i;
   326		int delay;
   327		int err;
   328		u32 fetch_index;
   329		u32 posted;
   330		u32 new_posted;
   331	
 > 332		posted = ioread32(&dc2c->wq_ctrl->posted_index);
   333		fetch_index = ioread32(&dc2c->wq_ctrl->fetch_index);
   334	
   335		if (posted == 0xFFFFFFFF || fetch_index == 0xFFFFFFFF) {
   336			/* Hardware surprise removal: return error */
   337			pr_err("%s: devcmd2 invalid posted or fetch index on cmd %d\n",
   338					pci_name(vdev->pdev), _CMD_N(cmd));
   339			pr_err("%s: fetch index: %u, posted index: %u\n",
   340					pci_name(vdev->pdev), fetch_index, posted);
   341	
   342			return -ENODEV;
   343	
   344		}
   345	
   346		new_posted = (posted + 1) % DEVCMD2_RING_SIZE;
   347	
   348		if (new_posted == fetch_index) {
   349			pr_err("%s: devcmd2 wq full while issuing cmd %d\n",
   350					pci_name(vdev->pdev), _CMD_N(cmd));
   351			pr_err("%s: fetch index: %u, posted index: %u\n",
   352					pci_name(vdev->pdev), fetch_index, posted);
   353			return -EBUSY;
   354	
   355		}
   356		dc2c->cmd_ring[posted].cmd = cmd;
   357		dc2c->cmd_ring[posted].flags = 0;
   358	
   359		if ((_CMD_FLAGS(cmd) & _CMD_FLAGS_NOWAIT))
   360			dc2c->cmd_ring[posted].flags |= DEVCMD2_FNORESULT;
   361		if (_CMD_DIR(cmd) & _CMD_DIR_WRITE) {
   362			for (i = 0; i < VNIC_DEVCMD_NARGS; i++)
   363				dc2c->cmd_ring[posted].args[i] = vdev->args[i];
   364	
   365		}
   366	
   367		/* Adding write memory barrier prevents compiler and/or CPU
   368		 * reordering, thus avoiding descriptor posting before
   369		 * descriptor is initialized. Otherwise, hardware can read
   370		 * stale descriptor fields.
   371		 */
   372		wmb();
   373		iowrite32(new_posted, &dc2c->wq_ctrl->posted_index);
   374	
   375		if (dc2c->cmd_ring[posted].flags & DEVCMD2_FNORESULT)
   376			return 0;
   377	
   378		result = dc2c->result + dc2c->next_result;
   379		color = dc2c->color;
   380	
   381		dc2c->next_result++;
   382		if (dc2c->next_result == dc2c->result_size) {
   383			dc2c->next_result = 0;
   384			dc2c->color = dc2c->color ? 0 : 1;
   385		}
   386	
   387		for (delay = 0; delay < wait; delay++) {
   388			udelay(100);
   389			if (result->color == color) {
   390				if (result->error) {
   391					err = -(int) result->error;
   392					if (err != ERR_ECMDUNKNOWN ||
   393							cmd != CMD_CAPABILITY)
   394						pr_err("%s:Error %d devcmd %d\n",
   395							pci_name(vdev->pdev),
   396							err, _CMD_N(cmd));
   397					return err;
   398				}
   399				if (_CMD_DIR(cmd) & _CMD_DIR_READ) {
   400					rmb(); /*prevent reorder while reding result*/
   401					for (i = 0; i < VNIC_DEVCMD_NARGS; i++)
   402						vdev->args[i] = result->results[i];
   403				}
   404				return 0;
   405			}
   406		}
   407	
   408		pr_err("%s:Timed out devcmd %d\n", pci_name(vdev->pdev), _CMD_N(cmd));
   409	
   410		return -ETIMEDOUT;
   411	}
   412	
   413	
   414	int vnic_dev_init_devcmd1(struct vnic_dev *vdev)
   415	{
   416		vdev->devcmd = vnic_dev_get_res(vdev, RES_TYPE_DEVCMD, 0);
   417		if (!vdev->devcmd)
   418			return -ENODEV;
   419	
   420		vdev->devcmd_rtn = &vnic_dev_cmd1;
   421		return 0;
   422	}
   423	
   424	
   425	int vnic_dev_init_devcmd2(struct vnic_dev *vdev)
   426	{
   427		int err;
   428		unsigned int fetch_index;
   429	
   430		if (vdev->devcmd2)
   431			return 0;
   432	
   433		vdev->devcmd2 = kzalloc(sizeof(*vdev->devcmd2), GFP_ATOMIC);
   434		if (!vdev->devcmd2)
   435			return -ENOMEM;
   436	
   437		vdev->devcmd2->color = 1;
   438		vdev->devcmd2->result_size = DEVCMD2_RING_SIZE;
   439		err = vnic_wq_devcmd2_alloc(vdev, &vdev->devcmd2->wq,
   440					DEVCMD2_RING_SIZE, DEVCMD2_DESC_SIZE);
   441		if (err)
   442			goto err_free_devcmd2;
   443	
   444		fetch_index = ioread32(&vdev->devcmd2->wq.ctrl->fetch_index);
   445		if (fetch_index == 0xFFFFFFFF) { /* check for hardware gone  */
   446			pr_err("error in devcmd2 init");
   447			return -ENODEV;
   448		}
   449	
   450		/*
   451		 * Don't change fetch_index ever and
   452		 * set posted_index same as fetch_index
   453		 * when setting up the WQ for devcmd2.
   454		 */
   455		vnic_wq_init_start(&vdev->devcmd2->wq, 0, fetch_index,
   456				fetch_index, 0, 0);
   457	
   458		vnic_wq_enable(&vdev->devcmd2->wq);
   459	
   460		err = vnic_dev_alloc_desc_ring(vdev, &vdev->devcmd2->results_ring,
   461				DEVCMD2_RING_SIZE, DEVCMD2_DESC_SIZE);
   462		if (err)
   463			goto err_free_wq;
   464	
   465		vdev->devcmd2->result =
   466			(struct devcmd2_result *) vdev->devcmd2->results_ring.descs;
   467		vdev->devcmd2->cmd_ring =
   468			(struct vnic_devcmd2 *) vdev->devcmd2->wq.ring.descs;
 > 469		vdev->devcmd2->wq_ctrl = vdev->devcmd2->wq.ctrl;
   470		vdev->args[0] = (u64) vdev->devcmd2->results_ring.base_addr |
   471					VNIC_PADDR_TARGET;
   472		vdev->args[1] = DEVCMD2_RING_SIZE;
   473	
   474		err = vnic_dev_cmd2(vdev, CMD_INITIALIZE_DEVCMD2, 1000);
   475		if (err)
   476			goto err_free_desc_ring;
   477	
   478		vdev->devcmd_rtn = &vnic_dev_cmd2;
   479	
   480		return 0;
   481	
   482	err_free_desc_ring:
   483		vnic_dev_free_desc_ring(vdev, &vdev->devcmd2->results_ring);
   484	err_free_wq:
   485		vnic_wq_disable(&vdev->devcmd2->wq);
   486		vnic_wq_free(&vdev->devcmd2->wq);
   487	err_free_devcmd2:
   488		kfree(vdev->devcmd2);
   489		vdev->devcmd2 = NULL;
   490	
   491		return err;
   492	}
   493	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
