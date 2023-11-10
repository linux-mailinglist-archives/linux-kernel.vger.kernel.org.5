Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB5B57E7FE4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:01:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235550AbjKJSAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:00:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235592AbjKJR7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 12:59:42 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38DC37694
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 22:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699598051; x=1731134051;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=VFWGNgp16NNLjoze1Z5Sc/JWrS+473CTDO2l9O/CBCU=;
  b=POxkRevU0uYH5Ju5EcxnFTgMO48mOkfDdDk+wR6qWsv0MN4YgXCezn3E
   DVpmTMGO/eUIuZsspu2vuIDZUPen3c9RaKMIR4SrmaRlu/IzbdoDstqzW
   sDoYgIiHUNEh6W3ufSeEPb5Ted8w1JzdavHyn3DMLzzoY4vKJMewwHU5Z
   Kz2+Kw6IPO+FeASFwuiaqh7+k2RX485CHfVzSqwBVyknrQf8C/1QZ/zrl
   QB9ZKM9Kv+9uLMe7CMwtg+5Z/R4O72twQByHo3rEF/S87JnCdwhfmNrUe
   fMNwaXzFM3QtVPFEv7oIn+sTVnyCBCAkxB6vVu5L3Mj7/lWeAuxHNzsu1
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="387295438"
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; 
   d="scan'208";a="387295438"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 21:26:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="763662512"
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; 
   d="scan'208";a="763662512"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 09 Nov 2023 21:26:40 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r1K2P-0009RC-2O;
        Fri, 10 Nov 2023 05:26:37 +0000
Date:   Fri, 10 Nov 2023 13:26:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: drivers/scsi/mpt3sas/mpt3sas_base.c:4323:16: sparse: sparse:
 incorrect type in argument 1 (different base types)
Message-ID: <202311101302.nsMeQMm1-lkp@intel.com>
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
head:   89cdf9d556016a54ff6ddd62324aa5ec790c05cc
commit: f920642e406cfa17ebecf03d5b83a02273ec718e scsi: mpt3sas: Revert "scsi: mpt3sas: Fix writel() use"
date:   1 year, 2 months ago
config: sparc-randconfig-r121-20231110 (https://download.01.org/0day-ci/archive/20231110/202311101302.nsMeQMm1-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231110/202311101302.nsMeQMm1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311101302.nsMeQMm1-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/scsi/mpt3sas/mpt3sas_base.c:4323:16: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] l @@     got restricted __le32 [usertype] @@
   drivers/scsi/mpt3sas/mpt3sas_base.c:4323:16: sparse:     expected unsigned int [usertype] l
   drivers/scsi/mpt3sas/mpt3sas_base.c:4323:16: sparse:     got restricted __le32 [usertype]
   drivers/scsi/mpt3sas/mpt3sas_base.c:4345:16: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] l @@     got restricted __le32 [usertype] @@
   drivers/scsi/mpt3sas/mpt3sas_base.c:4345:16: sparse:     expected unsigned int [usertype] l
   drivers/scsi/mpt3sas/mpt3sas_base.c:4345:16: sparse:     got restricted __le32 [usertype]
   drivers/scsi/mpt3sas/mpt3sas_base.c:4368:16: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] l @@     got restricted __le32 [usertype] @@
   drivers/scsi/mpt3sas/mpt3sas_base.c:4368:16: sparse:     expected unsigned int [usertype] l
   drivers/scsi/mpt3sas/mpt3sas_base.c:4368:16: sparse:     got restricted __le32 [usertype]
   drivers/scsi/mpt3sas/mpt3sas_base.c:4389:16: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] l @@     got restricted __le32 [usertype] @@
   drivers/scsi/mpt3sas/mpt3sas_base.c:4389:16: sparse:     expected unsigned int [usertype] l
   drivers/scsi/mpt3sas/mpt3sas_base.c:4389:16: sparse:     got restricted __le32 [usertype]
   drivers/scsi/mpt3sas/mpt3sas_base.c:7066:24: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] l @@     got restricted __le32 [usertype] @@
   drivers/scsi/mpt3sas/mpt3sas_base.c:7066:24: sparse:     expected unsigned int [usertype] l
   drivers/scsi/mpt3sas/mpt3sas_base.c:7066:24: sparse:     got restricted __le32 [usertype]

vim +4323 drivers/scsi/mpt3sas/mpt3sas_base.c

  4302	
  4303	/**
  4304	 * _base_put_smid_scsi_io_atomic - send SCSI_IO request to firmware using
  4305	 *   Atomic Request Descriptor
  4306	 * @ioc: per adapter object
  4307	 * @smid: system request message index
  4308	 * @handle: device handle, unused in this function, for function type match
  4309	 *
  4310	 * Return: nothing.
  4311	 */
  4312	static void
  4313	_base_put_smid_scsi_io_atomic(struct MPT3SAS_ADAPTER *ioc, u16 smid,
  4314		u16 handle)
  4315	{
  4316		Mpi26AtomicRequestDescriptor_t descriptor;
  4317		u32 *request = (u32 *)&descriptor;
  4318	
  4319		descriptor.RequestFlags = MPI2_REQ_DESCRIPT_FLAGS_SCSI_IO;
  4320		descriptor.MSIxIndex = _base_set_and_get_msix_index(ioc, smid);
  4321		descriptor.SMID = cpu_to_le16(smid);
  4322	
> 4323		writel(cpu_to_le32(*request), &ioc->chip->AtomicRequestDescriptorPost);
  4324	}
  4325	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
