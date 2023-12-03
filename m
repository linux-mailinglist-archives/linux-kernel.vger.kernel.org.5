Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B99C80214D
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 07:34:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233141AbjLCGdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 01:33:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233082AbjLCGdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 01:33:40 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 211A51BC8
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 22:32:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701585169; x=1733121169;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=8JIjw8FW0Cvne8wwDp4pHQm7ue9DIwM89QlVaOK5lDo=;
  b=PWAxDTaPXYqXShKESecvy2wVMzB1tCodKXxI61Pfh0wTrfVSCIpxV02c
   ufMRhWaIgHtG9SUXMCvYd6Kdbg/XJRuY9pXKWS+wDXvbjxaBdjLKuFWpC
   v4c+pVSAPWGlw+urJ3Sk8Cm7WYT8v5NFbov5/qbe2R80iCMl38I6gO6s2
   y94exi5PBu9czKp+QACpMAHvgDCL84wpkNkvR6wuLXOsmndHdU5uzsJN6
   mk1EodRQgdIFdoFimw4yE4r8EyHYUdxwrphsG6ID8GhDSZaaHPFj2LCzo
   g0kw7vk24oqDspzLC1HCp5f0FrNjChrNm84AfATUBsY13Ld3pCnN3NvNG
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10912"; a="6906506"
X-IronPort-AV: E=Sophos;i="6.04,246,1695711600"; 
   d="scan'208";a="6906506"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2023 22:32:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10912"; a="770191152"
X-IronPort-AV: E=Sophos;i="6.04,246,1695711600"; 
   d="scan'208";a="770191152"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 02 Dec 2023 22:32:46 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r9g20-0006LA-0d;
        Sun, 03 Dec 2023 06:32:44 +0000
Date:   Sun, 3 Dec 2023 14:32:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jiri Kosina <jkosina@suse.cz>
Subject: drivers/hid/intel-ish-hid/ipc/ipc.c:685:13: sparse: sparse: invalid
 assignment: |=
Message-ID: <202312031125.9fIHZZo5-lkp@intel.com>
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
head:   1b8af6552cb7c9bf1194e871f8d733a19b113230
commit: ae02e5d40d5f829c589412c6253f925e35cf7a22 HID: intel-ish-hid: ipc layer
date:   7 years ago
config: x86_64-randconfig-123-20231101 (https://download.01.org/0day-ci/archive/20231203/202312031125.9fIHZZo5-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231203/202312031125.9fIHZZo5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312031125.9fIHZZo5-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/hid/intel-ish-hid/ipc/ipc.c:685:13: sparse: sparse: invalid assignment: |=
>> drivers/hid/intel-ish-hid/ipc/ipc.c:685:13: sparse:    left side has type unsigned short
>> drivers/hid/intel-ish-hid/ipc/ipc.c:685:13: sparse:    right side has type restricted pci_power_t
   drivers/hid/intel-ish-hid/ipc/ipc.c:691:13: sparse: sparse: invalid assignment: |=
   drivers/hid/intel-ish-hid/ipc/ipc.c:691:13: sparse:    left side has type unsigned short
   drivers/hid/intel-ish-hid/ipc/ipc.c:691:13: sparse:    right side has type restricted pci_power_t
   In file included from include/linux/kobject.h:21,
                    from include/linux/device.h:17,
                    from drivers/hid/intel-ish-hid/ishtp/bus.h:18,
                    from drivers/hid/intel-ish-hid/ishtp/ishtp-dev.h:21,
                    from drivers/hid/intel-ish-hid/ishtp/client.h:20,
                    from drivers/hid/intel-ish-hid/ipc/ipc.c:20:
   include/linux/sysfs.h: In function 'sysfs_get_dirent':
   include/linux/sysfs.h:517:44: warning: pointer targets in passing argument 2 of 'kernfs_find_and_get' differ in signedness [-Wpointer-sign]
     517 |         return kernfs_find_and_get(parent, name);
         |                                            ^~~~
         |                                            |
         |                                            const unsigned char *
   In file included from include/linux/sysfs.h:15,
                    from include/linux/kobject.h:21,
                    from include/linux/device.h:17,
                    from drivers/hid/intel-ish-hid/ishtp/bus.h:18,
                    from drivers/hid/intel-ish-hid/ishtp/ishtp-dev.h:21,
                    from drivers/hid/intel-ish-hid/ishtp/client.h:20,
                    from drivers/hid/intel-ish-hid/ipc/ipc.c:20:
   include/linux/kernfs.h:440:57: note: expected 'const char *' but argument is of type 'const unsigned char *'
     440 | kernfs_find_and_get(struct kernfs_node *kn, const char *name)
         |                                             ~~~~~~~~~~~~^~~~

vim +685 drivers/hid/intel-ish-hid/ipc/ipc.c

   640	
   641	/**
   642	 * _ish_hw_reset() - HW reset
   643	 * @dev: ishtp device pointer
   644	 *
   645	 * Reset ISH HW to recover if any error
   646	 *
   647	 * Return: 0 for success else error fault code
   648	 */
   649	static int _ish_hw_reset(struct ishtp_device *dev)
   650	{
   651		struct pci_dev *pdev = dev->pdev;
   652		int	rv;
   653		unsigned int	dma_delay;
   654		uint16_t csr;
   655	
   656		if (!pdev)
   657			return	-ENODEV;
   658	
   659		rv = pci_reset_function(pdev);
   660		if (!rv)
   661			dev->dev_state = ISHTP_DEV_RESETTING;
   662	
   663		if (!pdev->pm_cap) {
   664			dev_err(&pdev->dev, "Can't reset - no PM caps\n");
   665			return	-EINVAL;
   666		}
   667	
   668		/* Now trigger reset to FW */
   669		ish_reg_write(dev, IPC_REG_ISH_RMP2, 0);
   670	
   671		for (dma_delay = 0; dma_delay < MAX_DMA_DELAY &&
   672			_ish_read_fw_sts_reg(dev) & (IPC_ISH_IN_DMA);
   673			dma_delay += 5)
   674			mdelay(5);
   675	
   676		if (dma_delay >= MAX_DMA_DELAY) {
   677			dev_err(&pdev->dev,
   678				"Can't reset - stuck with DMA in-progress\n");
   679			return	-EBUSY;
   680		}
   681	
   682		pci_read_config_word(pdev, pdev->pm_cap + PCI_PM_CTRL, &csr);
   683	
   684		csr &= ~PCI_PM_CTRL_STATE_MASK;
 > 685		csr |= PCI_D3hot;
   686		pci_write_config_word(pdev, pdev->pm_cap + PCI_PM_CTRL, csr);
   687	
   688		mdelay(pdev->d3_delay);
   689	
   690		csr &= ~PCI_PM_CTRL_STATE_MASK;
   691		csr |= PCI_D0;
   692		pci_write_config_word(pdev, pdev->pm_cap + PCI_PM_CTRL, csr);
   693	
   694		ish_reg_write(dev, IPC_REG_ISH_RMP2, IPC_RMP2_DMA_ENABLED);
   695	
   696		/*
   697		 * Send 0 IPC message so that ISH FW wakes up if it was already
   698		 * asleep
   699		 */
   700		ish_reg_write(dev, IPC_REG_HOST2ISH_DRBL, IPC_DRBL_BUSY_BIT);
   701	
   702		/* Flush writes to doorbell and REMAP2 */
   703		ish_reg_read(dev, IPC_REG_ISH_HOST_FWSTS);
   704	
   705		return	0;
   706	}
   707	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
