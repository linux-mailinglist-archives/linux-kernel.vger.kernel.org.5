Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7B280B221
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 06:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbjLIFKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 00:10:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjLIFKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 00:10:18 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A9E10FC
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 21:10:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702098623; x=1733634623;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=nQHp3nmAsorJaFHSZZZ3W6p1t9FirI1ONhZfvksRzWE=;
  b=MewmzlKJeT/fYDRbPlCKsGD2u2L5/3UnGnoCgTXrq/XQRKefmOTW0T/N
   T74E5oK379wQT/5K917Yst7ROjRJch3BdVp5+ZL9xRPy/ozeXfYIYPL/E
   nadvuWHBM4l0/1jakfwRc2m8Mlcmsc2CWHMkWIhUjoroPuBZKCaZJ4nMd
   nY3EowCCG2hnuqXfwkowMQ5H4qqmZfIxye1qlNg+4H4APVXZ0r1Rw1wXu
   l6aRgPJpe8Jy9M7ZHvs7MvkjI1hNsa3zOTyenm9N+iEhb4hJa5/fW+seI
   t3le5PoBdJ8R8MvojJ5N8pCDH76PX6mSxayBjD3GWKzBN+/pEsIezCM07
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="7853662"
X-IronPort-AV: E=Sophos;i="6.04,262,1695711600"; 
   d="scan'208";a="7853662"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2023 21:10:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="806621397"
X-IronPort-AV: E=Sophos;i="6.04,262,1695711600"; 
   d="scan'208";a="806621397"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 08 Dec 2023 21:10:20 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rBpbW-000EqM-0i;
        Sat, 09 Dec 2023 05:10:18 +0000
Date:   Sat, 9 Dec 2023 13:07:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Satish Kharat <satishkh@cisco.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: drivers/scsi/fnic/vnic_dev.c:943:11: sparse: sparse: incorrect type
 in assignment (different address spaces)
Message-ID: <202312091328.ZHZinkT3-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f2e8a57ee9036c7d5443382b6c3c09b51a92ec7e
commit: e119d14ca38c146846e400182252c22df002db56 scsi: fnic: Enable fnic devcmd2 interface
date:   4 years, 11 months ago
config: x86_64-randconfig-123-20231025 (https://download.01.org/0day-ci/archive/20231209/202312091328.ZHZinkT3-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231209/202312091328.ZHZinkT3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312091328.ZHZinkT3-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/scsi/fnic/vnic_dev.c:257:5: sparse: sparse: symbol 'vnic_dev_cmd1' was not declared. Should it be static?
   drivers/scsi/fnic/vnic_dev.c:332:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem * @@     got unsigned int * @@
   drivers/scsi/fnic/vnic_dev.c:332:32: sparse:     expected void [noderef] __iomem *
   drivers/scsi/fnic/vnic_dev.c:332:32: sparse:     got unsigned int *
   drivers/scsi/fnic/vnic_dev.c:333:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem * @@     got unsigned int * @@
   drivers/scsi/fnic/vnic_dev.c:333:37: sparse:     expected void [noderef] __iomem *
   drivers/scsi/fnic/vnic_dev.c:333:37: sparse:     got unsigned int *
   drivers/scsi/fnic/vnic_dev.c:373:36: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem * @@     got unsigned int * @@
   drivers/scsi/fnic/vnic_dev.c:373:36: sparse:     expected void [noderef] __iomem *
   drivers/scsi/fnic/vnic_dev.c:373:36: sparse:     got unsigned int *
   drivers/scsi/fnic/vnic_dev.c:319:5: sparse: sparse: symbol 'vnic_dev_cmd2' was not declared. Should it be static?
   drivers/scsi/fnic/vnic_dev.c:469:32: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct vnic_wq_ctrl *wq_ctrl @@     got struct vnic_wq_ctrl [noderef] __iomem *ctrl @@
   drivers/scsi/fnic/vnic_dev.c:469:32: sparse:     expected struct vnic_wq_ctrl *wq_ctrl
   drivers/scsi/fnic/vnic_dev.c:469:32: sparse:     got struct vnic_wq_ctrl [noderef] __iomem *ctrl
>> drivers/scsi/fnic/vnic_dev.c:943:11: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *p @@     got void [noderef] __iomem * @@
   drivers/scsi/fnic/vnic_dev.c:943:11: sparse:     expected void *p
   drivers/scsi/fnic/vnic_dev.c:943:11: sparse:     got void [noderef] __iomem *

vim +943 drivers/scsi/fnic/vnic_dev.c

   937	
   938	int vnic_dev_cmd_init(struct vnic_dev *vdev)
   939	{
   940		int err;
   941		void *p;
   942	
 > 943		p = vnic_dev_get_res(vdev, RES_TYPE_DEVCMD2, 0);

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
