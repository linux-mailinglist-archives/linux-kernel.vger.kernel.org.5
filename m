Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E52E7CC7A7
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 17:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344397AbjJQPmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 11:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344230AbjJQPmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 11:42:42 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CEF39F
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 08:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697557361; x=1729093361;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=bwUxNyPHAlvxJuhQ+abNRmVmPBDIFivaxaY40bdm3VM=;
  b=TJomQR0yHRwBdqVFZvpgJgN3ZplzRxHackGowAnkvk5RLkQlLqh5BfdQ
   Z2FKmCF1SC5O1qQL+I4qQyScEnLmtLbI6xhyBDgujW4IKkMv+Hwz1IoZ5
   L3VrU5MleeH5mRaWLUAdEJX4AuGM6ONT3gEMeMMO6yMK5sVP5Ua+I7ac2
   bBdf32um9ERMf2AYVN71AKLMia7KDBQMz+VLZzW0ipnpfedbcmZKvtkyN
   tWHaab0dFj92xQ3JVUXbnZVdGgbQSn5MWGCUW5euAAcNFY37x9nJmdwl8
   TzMm/SFnpCFtiIboOeYXqHad08MbW2yPU5iOKG2E/XyqBA9eL+AN4YOch
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="385649174"
X-IronPort-AV: E=Sophos;i="6.03,232,1694761200"; 
   d="scan'208";a="385649174"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 08:42:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="846871767"
X-IronPort-AV: E=Sophos;i="6.03,232,1694761200"; 
   d="scan'208";a="846871767"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 17 Oct 2023 08:42:39 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qsmDN-0009kl-0g;
        Tue, 17 Oct 2023 15:42:37 +0000
Date:   Tue, 17 Oct 2023 23:42:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sreekanth Reddy <sreekanth.reddy@broadcom.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: drivers/scsi/mpi3mr/mpi3mr_transport.c:695: warning: Function
 parameter or member 'port_id' not described in 'mpi3mr_get_hba_port_by_id'
Message-ID: <202310172303.u91HpHDR-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sreekanth,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   213f891525c222e8ed145ce1ce7ae1f47921cb9c
commit: 125ad1e6b445e8538e50d77d9c82ec811e98895e scsi: mpi3mr: Add helper functions to retrieve device objects
date:   1 year, 2 months ago
config: x86_64-randconfig-x063-20230716 (https://download.01.org/0day-ci/archive/20231017/202310172303.u91HpHDR-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231017/202310172303.u91HpHDR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310172303.u91HpHDR-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/scsi/mpi3mr/mpi3mr_transport.c:695: warning: Function parameter or member 'port_id' not described in 'mpi3mr_get_hba_port_by_id'

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for DRM_I915_DEBUG_GEM
   Depends on [n]: HAS_IOMEM [=y] && DRM_I915 [=y] && EXPERT [=y] && DRM_I915_WERROR [=n]
   Selected by [y]:
   - DRM_I915_DEBUG [=y] && HAS_IOMEM [=y] && DRM_I915 [=y] && EXPERT [=y] && !COMPILE_TEST [=n]


vim +695 drivers/scsi/mpi3mr/mpi3mr_transport.c

   684	
   685	/**
   686	 * mpi3mr_get_hba_port_by_id - find hba port by id
   687	 * @mrioc: Adapter instance reference
   688	 * @port_id - Port ID to search
   689	 *
   690	 * Return: mpi3mr_hba_port reference for the matched port
   691	 */
   692	
   693	struct mpi3mr_hba_port *mpi3mr_get_hba_port_by_id(struct mpi3mr_ioc *mrioc,
   694		u8 port_id)
 > 695	{

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
