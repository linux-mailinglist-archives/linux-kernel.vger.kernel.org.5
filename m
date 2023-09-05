Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E40D0792AAC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343568AbjIEQlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354582AbjIEMpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 08:45:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0BC3D8
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 05:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693917927; x=1725453927;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=EzNgbAolDS0RgHgfgYlr7Sxm2fQRjZKiPPUyl4EE+RY=;
  b=iHVxs8Y3uWdppcfFZVhGTV+TlR7Zn7sQCz8Q+Vp2McoClk641eEV6DXC
   HJOVszn2zllSY/+Bm7vS8NX63gOsDGREyEYQtWQ9+WJsBrFflO02dddTm
   M22RvFrZQH9SG2pA6oWZorLfcTgBru8bkQK/j2xUuAb/D6s/Xzn2iZ7EK
   BYjSuT+ZLDLcOre+wzPjq6GW2Oqo6UWp+TZ4aMii09QSL8NC05DEnuxtQ
   1DaTe/Zj/RJ6NlKoOJ9cIfFFmXbylgZYd51wgab/sP+oEIxmdpH2qzu67
   h+tx2qXW2nKjZO6uTTUq+/6nA2RH1YCV5wwQEfso7Ie3Td953MSRaJBtq
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="443182020"
X-IronPort-AV: E=Sophos;i="6.02,229,1688454000"; 
   d="scan'208";a="443182020"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 05:45:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="914826098"
X-IronPort-AV: E=Sophos;i="6.02,229,1688454000"; 
   d="scan'208";a="914826098"
Received: from lkp-server02.sh.intel.com (HELO e0b2ea88afd5) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 05 Sep 2023 05:45:25 -0700
Received: from kbuild by e0b2ea88afd5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qdVQk-0001fo-3B;
        Tue, 05 Sep 2023 12:45:20 +0000
Date:   Tue, 5 Sep 2023 20:44:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/firmware/efi/libstub/efi-stub-helper.c:662: warning:
 Function parameter or member 'out' not described in 'efi_load_initrd'
Message-ID: <202309052015.D3SZMitP-lkp@intel.com>
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

Hi Ard,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3f86ed6ec0b390c033eae7f9c487a3fea268e027
commit: f4dc7fffa9873db50ec25624572f8217a6225de8 efi: libstub: unify initrd loading between architectures
date:   11 months ago
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20230905/202309052015.D3SZMitP-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230905/202309052015.D3SZMitP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309052015.D3SZMitP-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/firmware/efi/libstub/efi-stub-helper.c:559: warning: Function parameter or member 'initrd' not described in 'efi_load_initrd_dev_path'
   drivers/firmware/efi/libstub/efi-stub-helper.c:559: warning: Excess function parameter 'load_addr' description in 'efi_load_initrd_dev_path'
   drivers/firmware/efi/libstub/efi-stub-helper.c:559: warning: Excess function parameter 'load_size' description in 'efi_load_initrd_dev_path'
>> drivers/firmware/efi/libstub/efi-stub-helper.c:662: warning: Function parameter or member 'out' not described in 'efi_load_initrd'


vim +662 drivers/firmware/efi/libstub/efi-stub-helper.c

f046fff8bc4c4d Ilias Apalodimas    2021-11-19  649  
8c0a839c2bccb7 Heinrich Schuchardt 2020-06-16  650  /**
8c0a839c2bccb7 Heinrich Schuchardt 2020-06-16  651   * efi_load_initrd() - Load initial RAM disk
8c0a839c2bccb7 Heinrich Schuchardt 2020-06-16  652   * @image:	EFI loaded image protocol
947228cb9f1a2c Atish Patra         2021-07-02  653   * @soft_limit:	preferred address for loading the initrd
947228cb9f1a2c Atish Patra         2021-07-02  654   * @hard_limit:	upper limit address for loading the initrd
8c0a839c2bccb7 Heinrich Schuchardt 2020-06-16  655   *
8c0a839c2bccb7 Heinrich Schuchardt 2020-06-16  656   * Return:	status code
8c0a839c2bccb7 Heinrich Schuchardt 2020-06-16  657   */
f61900fd0ebf6c Arvind Sankar       2020-04-30  658  efi_status_t efi_load_initrd(efi_loaded_image_t *image,
f61900fd0ebf6c Arvind Sankar       2020-04-30  659  			     unsigned long soft_limit,
f4dc7fffa9873d Ard Biesheuvel      2022-09-16  660  			     unsigned long hard_limit,
f4dc7fffa9873d Ard Biesheuvel      2022-09-16  661  			     const struct linux_efi_initrd **out)
f61900fd0ebf6c Arvind Sankar       2020-04-30 @662  {
f4dc7fffa9873d Ard Biesheuvel      2022-09-16  663  	efi_guid_t tbl_guid = LINUX_EFI_INITRD_MEDIA_GUID;
f4dc7fffa9873d Ard Biesheuvel      2022-09-16  664  	efi_status_t status = EFI_SUCCESS;
f4dc7fffa9873d Ard Biesheuvel      2022-09-16  665  	struct linux_efi_initrd initrd, *tbl;
f61900fd0ebf6c Arvind Sankar       2020-04-30  666  
f4dc7fffa9873d Ard Biesheuvel      2022-09-16  667  	if (!IS_ENABLED(CONFIG_BLK_DEV_INITRD) || efi_noinitrd)
f4dc7fffa9873d Ard Biesheuvel      2022-09-16  668  		return EFI_SUCCESS;
f4dc7fffa9873d Ard Biesheuvel      2022-09-16  669  
f4dc7fffa9873d Ard Biesheuvel      2022-09-16  670  	status = efi_load_initrd_dev_path(&initrd, hard_limit);
f61900fd0ebf6c Arvind Sankar       2020-04-30  671  	if (status == EFI_SUCCESS) {
f61900fd0ebf6c Arvind Sankar       2020-04-30  672  		efi_info("Loaded initrd from LINUX_EFI_INITRD_MEDIA_GUID device path\n");
f4dc7fffa9873d Ard Biesheuvel      2022-09-16  673  		if (initrd.size > 0)
f4dc7fffa9873d Ard Biesheuvel      2022-09-16  674  			efi_measure_initrd(initrd.base, initrd.size);
f61900fd0ebf6c Arvind Sankar       2020-04-30  675  	} else if (status == EFI_NOT_FOUND) {
f4dc7fffa9873d Ard Biesheuvel      2022-09-16  676  		status = efi_load_initrd_cmdline(image, &initrd, soft_limit,
f4dc7fffa9873d Ard Biesheuvel      2022-09-16  677  						 hard_limit);
f4dc7fffa9873d Ard Biesheuvel      2022-09-16  678  		/* command line loader disabled or no initrd= passed? */
f4dc7fffa9873d Ard Biesheuvel      2022-09-16  679  		if (status == EFI_UNSUPPORTED || status == EFI_NOT_READY)
f4dc7fffa9873d Ard Biesheuvel      2022-09-16  680  			return EFI_SUCCESS;
f4dc7fffa9873d Ard Biesheuvel      2022-09-16  681  		if (status == EFI_SUCCESS)
f61900fd0ebf6c Arvind Sankar       2020-04-30  682  			efi_info("Loaded initrd from command line option\n");
f61900fd0ebf6c Arvind Sankar       2020-04-30  683  	}
f4dc7fffa9873d Ard Biesheuvel      2022-09-16  684  	if (status != EFI_SUCCESS)
f4dc7fffa9873d Ard Biesheuvel      2022-09-16  685  		goto failed;
f4dc7fffa9873d Ard Biesheuvel      2022-09-16  686  
f4dc7fffa9873d Ard Biesheuvel      2022-09-16  687  	status = efi_bs_call(allocate_pool, EFI_LOADER_DATA, sizeof(initrd),
f4dc7fffa9873d Ard Biesheuvel      2022-09-16  688  			     (void **)&tbl);
f4dc7fffa9873d Ard Biesheuvel      2022-09-16  689  	if (status != EFI_SUCCESS)
f4dc7fffa9873d Ard Biesheuvel      2022-09-16  690  		goto free_initrd;
f046fff8bc4c4d Ilias Apalodimas    2021-11-19  691  
f4dc7fffa9873d Ard Biesheuvel      2022-09-16  692  	*tbl = initrd;
f4dc7fffa9873d Ard Biesheuvel      2022-09-16  693  	status = efi_bs_call(install_configuration_table, &tbl_guid, tbl);
f4dc7fffa9873d Ard Biesheuvel      2022-09-16  694  	if (status != EFI_SUCCESS)
f4dc7fffa9873d Ard Biesheuvel      2022-09-16  695  		goto free_tbl;
f4dc7fffa9873d Ard Biesheuvel      2022-09-16  696  
f4dc7fffa9873d Ard Biesheuvel      2022-09-16  697  	if (out)
f4dc7fffa9873d Ard Biesheuvel      2022-09-16  698  		*out = tbl;
f4dc7fffa9873d Ard Biesheuvel      2022-09-16  699  	return EFI_SUCCESS;
f4dc7fffa9873d Ard Biesheuvel      2022-09-16  700  
f4dc7fffa9873d Ard Biesheuvel      2022-09-16  701  free_tbl:
f4dc7fffa9873d Ard Biesheuvel      2022-09-16  702  	efi_bs_call(free_pool, tbl);
f4dc7fffa9873d Ard Biesheuvel      2022-09-16  703  free_initrd:
f4dc7fffa9873d Ard Biesheuvel      2022-09-16  704  	efi_free(initrd.size, initrd.base);
f4dc7fffa9873d Ard Biesheuvel      2022-09-16  705  failed:
f4dc7fffa9873d Ard Biesheuvel      2022-09-16  706  	efi_err("Failed to load initrd: 0x%lx\n", status);
f61900fd0ebf6c Arvind Sankar       2020-04-30  707  	return status;
f61900fd0ebf6c Arvind Sankar       2020-04-30  708  }
14c574f35cfbc9 Arvind Sankar       2020-05-18  709  

:::::: The code at line 662 was first introduced by commit
:::::: f61900fd0ebf6c6b91719d63272a54f4d11051df efi/libstub: Unify initrd loading across architectures

:::::: TO: Arvind Sankar <nivedita@alum.mit.edu>
:::::: CC: Ard Biesheuvel <ardb@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
