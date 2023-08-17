Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FFE777F1EF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 10:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348811AbjHQISR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 04:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348797AbjHQIRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 04:17:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56EA2701
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 01:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692260273; x=1723796273;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ER+vPI4lDQFaR/UT3asH0oLGVkhxE58YGH7Um+/Pxaw=;
  b=WIlOOh45RrU1bMI/+RH58OxPKsnydyEpWHhmknF4q63BkfOyXrp+4eAA
   aXOzoxax43CVTvJq5IsHppvAYYUEqLNht28OUwTbECH1+8xrHOa2F4HGW
   t1HUG++rWAsT3BWZgrCkDZZh8a/bn6u2dfhW1fk465TLlYvcBfSSx25AJ
   hq6I9fWSfY41rsbk+PrUPGCJKVdkDUlxiT64LCmCu174DaJJ5HQN8hgz9
   I1lJvphp/0he9AnUa1fFd678Uq8JAmv6gbeRQ0mgmoSb6L2lvvxRTT9at
   XeF+y80xfJAcxBnbrZb/2B++OD5rH1zgPASpqtfQYyaZZNE0BGJk18CJu
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="353063409"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="353063409"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 01:17:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="769524778"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="769524778"
Received: from lkp-server02.sh.intel.com (HELO a9caf1a0cf30) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 17 Aug 2023 01:17:51 -0700
Received: from kbuild by a9caf1a0cf30 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qWYCU-0000wT-1L;
        Thu, 17 Aug 2023 08:17:50 +0000
Date:   Thu, 17 Aug 2023 16:17:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sreekanth Reddy <sreekanth.reddy@broadcom.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: drivers/scsi/mpi3mr/mpi3mr_transport.c:695: warning: Function
 parameter or member 'port_id' not described in 'mpi3mr_get_hba_port_by_id'
Message-ID: <202308171606.rcBEycYE-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   4853c74bd7ab7fdb83f319bd9ace8a08c031e9b6
commit: 125ad1e6b445e8538e50d77d9c82ec811e98895e scsi: mpi3mr: Add helper functions to retrieve device objects
date:   12 months ago
config: microblaze-randconfig-r032-20230817 (https://download.01.org/0day-ci/archive/20230817/202308171606.rcBEycYE-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230817/202308171606.rcBEycYE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308171606.rcBEycYE-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/scsi/mpi3mr/mpi3mr_transport.c:695: warning: Function parameter or member 'port_id' not described in 'mpi3mr_get_hba_port_by_id'


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
