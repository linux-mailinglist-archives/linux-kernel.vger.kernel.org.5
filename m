Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA3E57E0B20
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 23:30:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344655AbjKCW0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 18:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233906AbjKCW0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 18:26:20 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6898CA
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 15:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699050376; x=1730586376;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=E9d/E1FmntHa339lrgY0TFfqYflwLZDuA8s/zmMa9U4=;
  b=SckQFrbd7M1DgQaJgt8urzi8DKvVYOWFCraF0S3N8rt0fICi8U5Fap+P
   FhYx4Er5J+a6ckXqT82S585t31ule3be8ZGdSgupltkPKcPSqHazRvg/r
   ntTvO630BduaRS1Gc8k5dxYcoVG1pVswpcMzCrtLCCW3XATS/RujqcQ/P
   RxTOtuwE0rT227V+F9d0fR4hbOeYDCXrrtGZz9czlyGyyPV73+7EESRAC
   vEWiVBptevXS++bTq2aEYYKh8dYg9wfjvXKjBPzeingB6rRQR99002vqr
   UhQJRJZnOwDncxzS8ZX3oBKZMKFOwgZS55QLmQY0caHdb89aM8cklRcdw
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="475268602"
X-IronPort-AV: E=Sophos;i="6.03,275,1694761200"; 
   d="scan'208";a="475268602"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 15:26:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="827632787"
X-IronPort-AV: E=Sophos;i="6.03,275,1694761200"; 
   d="scan'208";a="827632787"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 03 Nov 2023 15:26:14 -0700
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qz2cG-00030M-0w;
        Fri, 03 Nov 2023 22:26:12 +0000
Date:   Sat, 4 Nov 2023 06:25:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: drivers/scsi/lpfc/lpfc_init.c:14771:53: warning: '.grp' directive
 output may be truncated writing 4 bytes into a region of size between 1 and
 80
Message-ID: <202311040654.NBvWmrLg-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lad,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e392ea4d4d00880bf94550151b1ace4f88a4b17a
commit: effae0e3d9e1139d583e9b5d050f4f948825b8a3 riscv: Kconfig: Enable cpufreq kconfig menu
date:   12 months ago
config: riscv-allyesconfig (https://download.01.org/0day-ci/archive/20231104/202311040654.NBvWmrLg-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231104/202311040654.NBvWmrLg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311040654.NBvWmrLg-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/scsi/lpfc/lpfc_init.c: In function 'lpfc_sli4_request_firmware_update':
>> drivers/scsi/lpfc/lpfc_init.c:14771:53: warning: '.grp' directive output may be truncated writing 4 bytes into a region of size between 1 and 80 [-Wformat-truncation=]
   14771 |         snprintf(file_name, ELX_MODEL_NAME_SIZE, "%s.grp", phba->ModelName);
         |                                                     ^~~~
   drivers/scsi/lpfc/lpfc_init.c:14771:9: note: 'snprintf' output between 5 and 84 bytes into a destination of size 80
   14771 |         snprintf(file_name, ELX_MODEL_NAME_SIZE, "%s.grp", phba->ModelName);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +14771 drivers/scsi/lpfc/lpfc_init.c

52d5244096017b James Smart 2011-05-24  14750  
c71ab8616d62d8 James Smart 2012-10-31  14751  /**
c71ab8616d62d8 James Smart 2012-10-31  14752   * lpfc_sli4_request_firmware_update - Request linux generic firmware upgrade
c71ab8616d62d8 James Smart 2012-10-31  14753   * @phba: pointer to lpfc hba data structure.
fe614acd583f5e Lee Jones   2020-07-23  14754   * @fw_upgrade: which firmware to update.
c71ab8616d62d8 James Smart 2012-10-31  14755   *
c71ab8616d62d8 James Smart 2012-10-31  14756   * This routine is called to perform Linux generic firmware upgrade on device
c71ab8616d62d8 James Smart 2012-10-31  14757   * that supports such feature.
c71ab8616d62d8 James Smart 2012-10-31  14758   **/
c71ab8616d62d8 James Smart 2012-10-31  14759  int
c71ab8616d62d8 James Smart 2012-10-31  14760  lpfc_sli4_request_firmware_update(struct lpfc_hba *phba, uint8_t fw_upgrade)
c71ab8616d62d8 James Smart 2012-10-31  14761  {
c71ab8616d62d8 James Smart 2012-10-31  14762  	uint8_t file_name[ELX_MODEL_NAME_SIZE];
c71ab8616d62d8 James Smart 2012-10-31  14763  	int ret;
c71ab8616d62d8 James Smart 2012-10-31  14764  	const struct firmware *fw;
c71ab8616d62d8 James Smart 2012-10-31  14765  
c71ab8616d62d8 James Smart 2012-10-31  14766  	/* Only supported on SLI4 interface type 2 for now */
27d6ac0a6e8300 James Smart 2018-02-22  14767  	if (bf_get(lpfc_sli_intf_if_type, &phba->sli4_hba.sli_intf) <
c71ab8616d62d8 James Smart 2012-10-31  14768  	    LPFC_SLI_INTF_IF_TYPE_2)
c71ab8616d62d8 James Smart 2012-10-31  14769  		return -EPERM;
c71ab8616d62d8 James Smart 2012-10-31  14770  
c71ab8616d62d8 James Smart 2012-10-31 @14771  	snprintf(file_name, ELX_MODEL_NAME_SIZE, "%s.grp", phba->ModelName);
c71ab8616d62d8 James Smart 2012-10-31  14772  
c71ab8616d62d8 James Smart 2012-10-31  14773  	if (fw_upgrade == INT_FW_UPGRADE) {
0733d83905326b Shawn Guo   2021-04-25  14774  		ret = request_firmware_nowait(THIS_MODULE, FW_ACTION_UEVENT,
c71ab8616d62d8 James Smart 2012-10-31  14775  					file_name, &phba->pcidev->dev,
c71ab8616d62d8 James Smart 2012-10-31  14776  					GFP_KERNEL, (void *)phba,
c71ab8616d62d8 James Smart 2012-10-31  14777  					lpfc_write_firmware);
c71ab8616d62d8 James Smart 2012-10-31  14778  	} else if (fw_upgrade == RUN_FW_UPGRADE) {
c71ab8616d62d8 James Smart 2012-10-31  14779  		ret = request_firmware(&fw, file_name, &phba->pcidev->dev);
c71ab8616d62d8 James Smart 2012-10-31  14780  		if (!ret)
c71ab8616d62d8 James Smart 2012-10-31  14781  			lpfc_write_firmware(fw, (void *)phba);
c71ab8616d62d8 James Smart 2012-10-31  14782  	} else {
c71ab8616d62d8 James Smart 2012-10-31  14783  		ret = -EINVAL;
c71ab8616d62d8 James Smart 2012-10-31  14784  	}
c71ab8616d62d8 James Smart 2012-10-31  14785  
c71ab8616d62d8 James Smart 2012-10-31  14786  	return ret;
c71ab8616d62d8 James Smart 2012-10-31  14787  }
c71ab8616d62d8 James Smart 2012-10-31  14788  

:::::: The code at line 14771 was first introduced by commit
:::::: c71ab8616d62d8d857c438f058839d9a0282e64c [SCSI] lpfc 8.3.36: Fixed boot from san failure

:::::: TO: James Smart <james.smart@emulex.com>
:::::: CC: James Bottomley <JBottomley@Parallels.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
