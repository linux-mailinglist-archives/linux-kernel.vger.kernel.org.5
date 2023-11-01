Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45F767DE617
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 19:47:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344819AbjKASeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 14:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232266AbjKASeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 14:34:07 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE3E111
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 11:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698863640; x=1730399640;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=l2hha5y0uZTR/Q8rjd8NFwaLRluMfCDBLP1FED/gGgo=;
  b=i1cflBjD1Cknc0gFK+H21JcLzRed+hPEMdmT1p+r90B8/FvHWGIKJpQx
   oHYu/n0KM1dJyz+dRhtE3pRV5QIcZ/YCkgRnBGexMojSr6u84lhZhKhkk
   Dni6aJ8PaO3P0HAWAa+1Xf280XlThRn6jbALWfl6a41/edNQOPp3qqdrU
   EhU7vrI97GOhfmS85mzRY25u40GecCbKCsK4OzWdIfscZLDnP9WU5rtbx
   JmDJmvFRlruYYRcBaAkxAA7ZenhtzuwsXIIxA8aafMjY11C2+8ea7EUZ+
   5FbcD3h7IaHVb0io5ZxXigdHmweWRW10f+jC1zH9UGA8P3BeHbCdr7vlk
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="419672861"
X-IronPort-AV: E=Sophos;i="6.03,269,1694761200"; 
   d="scan'208";a="419672861"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 11:34:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,269,1694761200"; 
   d="scan'208";a="9132839"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 01 Nov 2023 11:33:58 -0700
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qyG2O-0000u8-1p;
        Wed, 01 Nov 2023 18:33:56 +0000
Date:   Thu, 2 Nov 2023 02:33:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Stanislav Fomichev <sdf@google.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: net/core/xdp.c:737:5: warning: no previous declaration for
 'bpf_xdp_metadata_rx_hash'
Message-ID: <202311020203.CdXuCwy2-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   8bc9e6515183935fa0cccaf67455c439afe4982b
commit: 3d76a4d3d4e591af3e789698affaad88a5a8e8ab bpf: XDP metadata RX kfuncs
date:   9 months ago
config: i386-defconfig (https://download.01.org/0day-ci/archive/20231102/202311020203.CdXuCwy2-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231102/202311020203.CdXuCwy2-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311020203.CdXuCwy2-lkp@intel.com/

All warnings (new ones prefixed by >>):

   net/core/xdp.c:725:5: warning: no previous declaration for 'bpf_xdp_metadata_rx_timestamp' [-Wmissing-declarations]
    int bpf_xdp_metadata_rx_timestamp(const struct xdp_md *ctx, u64 *timestamp)
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> net/core/xdp.c:737:5: warning: no previous declaration for 'bpf_xdp_metadata_rx_hash' [-Wmissing-declarations]
    int bpf_xdp_metadata_rx_hash(const struct xdp_md *ctx, u32 *hash)
        ^~~~~~~~~~~~~~~~~~~~~~~~


vim +/bpf_xdp_metadata_rx_hash +737 net/core/xdp.c

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
