Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23D4280AACA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 18:30:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233781AbjLHRaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 12:30:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232094AbjLHRaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 12:30:11 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC1ED85;
        Fri,  8 Dec 2023 09:30:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702056618; x=1733592618;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hlI+7ac35Zf/h2Mk8ufew+uIX6Fjs/DlJAJSupwNauI=;
  b=bObnG7cKewLqE2T15P7GU7U+UfiV2H3diRiEZMHHLejaAe5ObghwYDbv
   qGE9kwtI6vHSTP1fYJ4E81RkSFiaEBA1VA09ONDRqQGhyidhUxC7IcWLO
   AzzZlPR6pQ92tj3ZMoAnNWtHP+WrHIk0ZzaIZ8EYVyXV6Gg4XXfNL/D5C
   6KLEPuD8EAS34kfbyFyeoX8JSy4bPvvNlcIeKJ+LEz5gbSEngxRKqZ5QH
   3tzF2jLEknrHKyGud1yeVWb1xXnqtTfExX1m3fPO+sPcUGrTozieHNYsm
   Y0vAFgrYqCCYbCghekrlTYF3S0K4bcCK6oyHN0GNH+EbTUWchZE9z7Xl0
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="13132808"
X-IronPort-AV: E=Sophos;i="6.04,261,1695711600"; 
   d="scan'208";a="13132808"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2023 09:30:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="806467986"
X-IronPort-AV: E=Sophos;i="6.04,261,1695711600"; 
   d="scan'208";a="806467986"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 08 Dec 2023 09:30:12 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rBefy-000E6l-1k;
        Fri, 08 Dec 2023 17:30:10 +0000
Date:   Sat, 9 Dec 2023 01:29:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Shinas Rasheed <srasheed@marvell.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, hgani@marvell.com,
        vimleshk@marvell.com, egallen@redhat.com, mschmidt@redhat.com,
        pabeni@redhat.com, horms@kernel.org, kuba@kernel.org,
        davem@davemloft.net, wizhao@redhat.com, kheib@redhat.com,
        konguyen@redhat.com, Shinas Rasheed <srasheed@marvell.com>,
        Veerasenareddy Burru <vburru@marvell.com>,
        Sathesh Edara <sedara@marvell.com>,
        Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next v1 1/4] octeon_ep: add PF-VF mailbox
 communication
Message-ID: <202312090134.EZuetV2i-lkp@intel.com>
References: <20231208070352.2606192-2-srasheed@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208070352.2606192-2-srasheed@marvell.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shinas,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Shinas-Rasheed/octeon_ep-add-PF-VF-mailbox-communication/20231208-150756
base:   net-next/main
patch link:    https://lore.kernel.org/r/20231208070352.2606192-2-srasheed%40marvell.com
patch subject: [PATCH net-next v1 1/4] octeon_ep: add PF-VF mailbox communication
config: x86_64-randconfig-121-20231208 (https://download.01.org/0day-ci/archive/20231209/202312090134.EZuetV2i-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231209/202312090134.EZuetV2i-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312090134.EZuetV2i-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/ethernet/marvell/octeon_ep/octep_cnxk_pf.c: In function 'octep_poll_pfvf_mailbox_cnxk_pf':
>> drivers/net/ethernet/marvell/octeon_ep/octep_cnxk_pf.c:406:6: warning: variable 'handled' set but not used [-Wunused-but-set-variable]
     int handled = 0;
         ^~~~~~~


vim +/handled +406 drivers/net/ethernet/marvell/octeon_ep/octep_cnxk_pf.c

   401	
   402	static void octep_poll_pfvf_mailbox_cnxk_pf(struct octep_device *oct)
   403	{
   404		u32 vf, active_vfs, active_rings_per_vf, vf_mbox_queue;
   405		u64 reg0;
 > 406		int handled = 0;
   407	
   408		reg0 = octep_read_csr64(oct, CNXK_SDP_EPF_MBOX_RINT(0));
   409		if (reg0) {
   410			active_vfs = CFG_GET_ACTIVE_VFS(oct->conf);
   411			active_rings_per_vf = CFG_GET_ACTIVE_RPVF(oct->conf);
   412			for (vf = 0; vf < active_vfs; vf++) {
   413				vf_mbox_queue = vf * active_rings_per_vf;
   414				if (!(reg0 & (0x1UL << vf_mbox_queue)))
   415					continue;
   416	
   417				if (!oct->mbox[vf_mbox_queue]) {
   418					dev_err(&oct->pdev->dev, "bad mbox vf %d\n", vf);
   419					continue;
   420				}
   421				schedule_work(&oct->mbox[vf_mbox_queue]->wk.work);
   422			}
   423			if (reg0)
   424				octep_write_csr64(oct, CNXK_SDP_EPF_MBOX_RINT(0), reg0);
   425	
   426			handled = 1;
   427		}
   428	}
   429	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
