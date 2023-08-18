Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD7B78059C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 07:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357170AbjHRFXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 01:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358009AbjHRFWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 01:22:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83FAA4223
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 22:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692336063; x=1723872063;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Pc8skSgqvI0jZyRSGkKNJvsoFZDcMpnbDIPjb0OmGz8=;
  b=BiHkpcdOLlc6IlnT3ajLI4HWGOGUfx2bPJEEFKFl713NGqtrVtYKYtuw
   7j16wRijCxYYqZ/rAgzMn9VaRnVS5EfvHXDa6frY9BitkoKLr0brQSIz8
   t4ya21tVMRb3ke+3sWAwIgPG1GE87GQ0/5xMT8SGEw+ApB4ES7Qeli3O4
   maq7mWMYGlfIboJp0dFobpN/FkDilwEy3RxfQ8PYeN9SsGd07F9s4DQxZ
   +tY81QtXdhSEKJ47b2+z24CwmUNM7iilXesNT1JjC/2VcDDNzNq2aaSlK
   dz5ij7U6Te35AtnwuVXkRGFRdz4kGw5DWLZocbEGXYmqbqV8vYwiH9ZHa
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="353320917"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; 
   d="scan'208";a="353320917"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 22:20:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="711858235"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; 
   d="scan'208";a="711858235"
Received: from lkp-server02.sh.intel.com (HELO a9caf1a0cf30) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 17 Aug 2023 22:20:51 -0700
Received: from kbuild by a9caf1a0cf30 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qWrt8-00028A-36;
        Fri, 18 Aug 2023 05:19:43 +0000
Date:   Fri, 18 Aug 2023 13:16:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Stanislav Fomichev <sdf@google.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: net/core/xdp.c:725:5: error: no previous declaration for
 'bpf_xdp_metadata_rx_timestamp'
Message-ID: <202308181346.WLEAMI1Y-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   16931859a6500d360b90aeacab3b505a3560a3ed
commit: 3d76a4d3d4e591af3e789698affaad88a5a8e8ab bpf: XDP metadata RX kfuncs
date:   7 months ago
config: x86_64-sof-customedconfig-avs-defconfig (https://download.01.org/0day-ci/archive/20230818/202308181346.WLEAMI1Y-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce: (https://download.01.org/0day-ci/archive/20230818/202308181346.WLEAMI1Y-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308181346.WLEAMI1Y-lkp@intel.com/

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
