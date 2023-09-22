Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 996877AB5A1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 18:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232053AbjIVQMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 12:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231604AbjIVQMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 12:12:10 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9026D99
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 09:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695399124; x=1726935124;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+1ZYtVBUsifH9zjdqoNORhsulycKouwOTBpUcx6Yzrc=;
  b=bZT4gNFoTU0w8Kwd3G+LRzkmFEiHIRBMEUoYoaKDMgGPJqQNHxO7qs3p
   0H8Uu5JJoMhaVPgIcrnvkc5ykfNbMjtz5NlZhjiG3xVGK4dnd5wFjuqMF
   fokNEboulwvH5N34kPWJunBfA3Ij02QtsgctbzOy7o+tawoPCSupnv1lD
   Jn+iRS5LTL/5JDl049WYBUywaPXaLu1D/htlnujq5mwJ2UHglGZtBCj0n
   kYUgwF1rWdqMTJSfZS2w/AoL3e1G04Sewj+PFm6twTpCtRe0O7xG1+7lT
   982klDpwBHh6P1C5cAeKqbbxdR+9ZqVDWSUmFRxy4U6+74TTu8esfaKJH
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10841"; a="380768241"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="380768241"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2023 09:05:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10841"; a="813110592"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="813110592"
Received: from lkp-server02.sh.intel.com (HELO 493f6c7fed5d) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 22 Sep 2023 09:05:38 -0700
Received: from kbuild by 493f6c7fed5d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qjieu-0000wf-17;
        Fri, 22 Sep 2023 16:05:36 +0000
Date:   Sat, 23 Sep 2023 00:05:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Stanislav Fomichev <sdf@google.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: net/core/xdp.c:725:5: error: no previous declaration for
 'bpf_xdp_metadata_rx_timestamp'
Message-ID: <202309230010.Eio2q6e0-lkp@intel.com>
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

Hi Stanislav,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   27bbf45eae9ca98877a2d52a92a188147cd61b07
commit: 3d76a4d3d4e591af3e789698affaad88a5a8e8ab bpf: XDP metadata RX kfuncs
date:   8 months ago
config: x86_64-sof-customedconfig-avs-defconfig (https://download.01.org/0day-ci/archive/20230923/202309230010.Eio2q6e0-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230923/202309230010.Eio2q6e0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309230010.Eio2q6e0-lkp@intel.com/

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
