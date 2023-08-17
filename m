Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C60F777F57A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 13:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350408AbjHQLnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 07:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350464AbjHQLnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 07:43:04 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFBA01728
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 04:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692272583; x=1723808583;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=pPCmEoRP32epEQDCgK8R0OgJjoyRrG7zANWIdRwe6QQ=;
  b=Y1eX/UoQgGbsi0pYR4Ipka+13O/2pM0Ts4K0zN6FuYX8zDHNVjhEK7Yd
   +XtNwuEx0P03d6WVKoKCfjYTRDhUPO1A9oFcpyf+n+04MpgPf1HvNGoJR
   D1gga+3lR7XTWMB3IgJgTLE1BMAfYTqDJnptFokACJDy/Ahg5Zlv+97jt
   ClTX+O16z2NkXJ+UxLjGu2oy3PxmVZW6Qxvj9v2J6zXRCYZeJUfFdLZAY
   MERgBP9689F73UZRHIPSQPUtjU1BtS3s8EKQ4EMysKj8uPKufLLNCkcnE
   v6053pEH+VmlNL7iCk+Ow4wzC7mFYebnrK/fl3ncHB0QTOd9/eS44pOBR
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="403766685"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="403766685"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 04:41:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="764051245"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="764051245"
Received: from lkp-server02.sh.intel.com (HELO a9caf1a0cf30) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 17 Aug 2023 04:41:49 -0700
Received: from kbuild by a9caf1a0cf30 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qWbNp-00015p-2R;
        Thu, 17 Aug 2023 11:41:46 +0000
Date:   Thu, 17 Aug 2023 19:41:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bradley Grove <bgrove@attotech.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Rob Crispo <rcrispo@attotech.com>
Subject: drivers/scsi/mpt3sas/mpt3sas_base.c:5487: warning: Function
 parameter or member 'sas_addr' not described in 'mpt3sas_atto_get_sas_addr'
Message-ID: <202308171957.Z6vvWcGO-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   4853c74bd7ab7fdb83f319bd9ace8a08c031e9b6
commit: 91cf186aa1bfea06c7438b16eb40a612a4c3b87a scsi: mpt3sas: Add support for ATTO ExpressSAS H12xx GT devices
date:   12 months ago
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20230817/202308171957.Z6vvWcGO-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230817/202308171957.Z6vvWcGO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308171957.Z6vvWcGO-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/scsi/mpt3sas/mpt3sas_base.c:5487: warning: Function parameter or member 'sas_addr' not described in 'mpt3sas_atto_get_sas_addr'


vim +5487 drivers/scsi/mpt3sas/mpt3sas_base.c

  5477	
  5478	/**
  5479	 * mpt3sas_atto_get_sas_addr - get the ATTO SAS address from mfg page 1
  5480	 *
  5481	 * @ioc : per adapter object
  5482	 * @*sas_addr : return sas address
  5483	 * Return: 0 for success, non-zero for failure.
  5484	 */
  5485	static int
  5486	mpt3sas_atto_get_sas_addr(struct MPT3SAS_ADAPTER *ioc, union ATTO_SAS_ADDRESS *sas_addr)
> 5487	{
  5488		Mpi2ManufacturingPage1_t mfg_pg1;
  5489		Mpi2ConfigReply_t mpi_reply;
  5490		struct ATTO_SAS_NVRAM *nvram;
  5491		int r;
  5492		__be64 addr;
  5493	
  5494		r = mpt3sas_config_get_manufacturing_pg1(ioc, &mpi_reply, &mfg_pg1);
  5495		if (r) {
  5496			ioc_err(ioc, "Failed to read manufacturing page 1\n");
  5497			return r;
  5498		}
  5499	
  5500		/* validate nvram */
  5501		nvram = (struct ATTO_SAS_NVRAM *) mfg_pg1.VPD;
  5502		r = mpt3sas_atto_validate_nvram(ioc, nvram);
  5503		if (r)
  5504			return r;
  5505	
  5506		addr = *((__be64 *) nvram->SasAddr);
  5507		sas_addr->q = cpu_to_le64(be64_to_cpu(addr));
  5508		return r;
  5509	}
  5510	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
