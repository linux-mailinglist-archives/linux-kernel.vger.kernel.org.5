Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 837DA797AF1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 19:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245597AbjIGR6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 13:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245424AbjIGR6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 13:58:11 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0619C1724
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 10:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694109465; x=1725645465;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=5uoTSBy7AZ8mb0iA8MkDFh2iCLv0MmPK+4Gs5H6DI0g=;
  b=fa3tpogdFWksrGCOCoF+mPi96VIrAgxkLgCDdlsom+xM/uGD7tiZFP4H
   485i40kSA+Vz+1jhdHKpMUi2XiwE73DRe1ax5MTcXqZPbeGykgpx6VUxx
   wMdy4hgn7tDv5ZDd5dLE+nfBNcQ7l6QkX3wblkb3Vowpi5gEWyMWzTvus
   BXKwz3FsazAG465VA1JsOGuX/BzerrnlJ7zKdWxwUsmArlPUmZBAPhrJH
   F0/ikV+bn5Ebk6IsCp8jXCZw8XDv7I3GqH9zPa1glIpMHNZPcuR75lnQ/
   NKpxsUYM4uX/dZi7SAERD+2QHADGnYAh80SyMJAemXgqxuB04rFLyT+io
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="367525936"
X-IronPort-AV: E=Sophos;i="6.02,234,1688454000"; 
   d="scan'208";a="367525936"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 02:13:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="777003172"
X-IronPort-AV: E=Sophos;i="6.02,234,1688454000"; 
   d="scan'208";a="777003172"
Received: from lkp-server01.sh.intel.com (HELO 59b3c6e06877) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 07 Sep 2023 02:13:58 -0700
Received: from kbuild by 59b3c6e06877 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qeB5I-00015X-06;
        Thu, 07 Sep 2023 09:13:56 +0000
Date:   Thu, 7 Sep 2023 17:13:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Stanislav Fomichev <sdf@google.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: net/core/xdp.c:725:5: error: no previous declaration for
 'bpf_xdp_metadata_rx_timestamp'
Message-ID: <202309071703.HVdMzfuS-lkp@intel.com>
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

Hi Stanislav,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   7ba2090ca64ea1aa435744884124387db1fac70f
commit: 3d76a4d3d4e591af3e789698affaad88a5a8e8ab bpf: XDP metadata RX kfuncs
date:   8 months ago
config: x86_64-sof-customedconfig-avs-defconfig (https://download.01.org/0day-ci/archive/20230907/202309071703.HVdMzfuS-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230907/202309071703.HVdMzfuS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309071703.HVdMzfuS-lkp@intel.com/

All errors (new ones prefixed by >>):

>> net/core/xdp.c:725:5: error: no previous declaration for 'bpf_xdp_metadata_rx_timestamp' [-Werror=missing-declarations]
    int bpf_xdp_metadata_rx_timestamp(const struct xdp_md *ctx, u64 *timestamp)
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> net/core/xdp.c:737:5: error: no previous declaration for 'bpf_xdp_metadata_rx_hash' [-Werror=missing-declarations]
    int bpf_xdp_metadata_rx_hash(const struct xdp_md *ctx, u32 *hash)
        ^~~~~~~~~~~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors


vim +/bpf_xdp_metadata_rx_timestamp +725 net/core/xdp.c

   713	
   714	__diag_push();
   715	__diag_ignore_all("-Wmissing-prototypes",
   716			  "Global functions as their definitions will be in vmlinux BTF");
   717	
   718	/**
   719	 * bpf_xdp_metadata_rx_timestamp - Read XDP frame RX timestamp.
   720	 * @ctx: XDP context pointer.
   721	 * @timestamp: Return value pointer.
   722	 *
   723	 * Returns 0 on success or ``-errno`` on error.
   724	 */
 > 725	int bpf_xdp_metadata_rx_timestamp(const struct xdp_md *ctx, u64 *timestamp)
   726	{
   727		return -EOPNOTSUPP;
   728	}
   729	
   730	/**
   731	 * bpf_xdp_metadata_rx_hash - Read XDP frame RX hash.
   732	 * @ctx: XDP context pointer.
   733	 * @hash: Return value pointer.
   734	 *
   735	 * Returns 0 on success or ``-errno`` on error.
   736	 */
 > 737	int bpf_xdp_metadata_rx_hash(const struct xdp_md *ctx, u32 *hash)
   738	{
   739		return -EOPNOTSUPP;
   740	}
   741	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
