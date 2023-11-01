Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E05C37DE7AB
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 22:47:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345566AbjKAV2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 17:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345506AbjKAV2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 17:28:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE0CA134
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 14:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698874074; x=1730410074;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Vvc4zxaF2jHdB5ttg4cf4Zt+cw2B1Cg5jwqZeEaviY8=;
  b=N6Epush9JbiawJ5nrp+0TRA5VQbHLTTuByCfZRZNyKyVdcD5+ndJnPrX
   XnauHtPM6yxbACx2MWGK2B5aMv3dl+GEHjaZVGsYVv/oZBiWU+ZAovnvt
   /YQvyu3FKQ1GhoRcEEc+v5XKrUIFPPKW+gBH0qziVtzh3jP87/Vg0vEhx
   4xCrP/FmR5Cgdtc+lvs2nyjJNXJLMhUIO0uRqrny9eLMd2hhKf8Vk88Mq
   ads2Gv3D6pDaKF+d1jmiNQZ9MWLa1kY09LfB4ix1/8zyRQlKngzuSoghl
   5d9vXdiG35w/vDlT8OlChRVOozgEwvBSLL7h+YUmGfUSF7nN+w5QEh7PZ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="1499993"
X-IronPort-AV: E=Sophos;i="6.03,269,1694761200"; 
   d="scan'208";a="1499993"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 14:27:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="710927215"
X-IronPort-AV: E=Sophos;i="6.03,269,1694761200"; 
   d="scan'208";a="710927215"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 01 Nov 2023 14:27:16 -0700
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qyIk6-0000xk-0T;
        Wed, 01 Nov 2023 21:27:14 +0000
Date:   Thu, 2 Nov 2023 05:26:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>
Subject: net/core/filter.c:11662:17: warning: no previous declaration for
 'bpf_dynptr_from_xdp'
Message-ID: <202311020505.2zgymACj-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   7d461b291e65938f15f56fe58da2303b07578a76
commit: 05421aecd4ed65da0dc17b0c3c13779ef334e9e5 bpf: Add xdp dynptrs
date:   8 months ago
config: i386-defconfig (https://download.01.org/0day-ci/archive/20231102/202311020505.2zgymACj-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231102/202311020505.2zgymACj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311020505.2zgymACj-lkp@intel.com/

All warnings (new ones prefixed by >>):

   net/core/filter.c:11649:17: warning: no previous declaration for 'bpf_dynptr_from_skb' [-Wmissing-declarations]
    __bpf_kfunc int bpf_dynptr_from_skb(struct sk_buff *skb, u64 flags,
                    ^~~~~~~~~~~~~~~~~~~
>> net/core/filter.c:11662:17: warning: no previous declaration for 'bpf_dynptr_from_xdp' [-Wmissing-declarations]
    __bpf_kfunc int bpf_dynptr_from_xdp(struct xdp_buff *xdp, u64 flags,
                    ^~~~~~~~~~~~~~~~~~~


vim +/bpf_dynptr_from_xdp +11662 net/core/filter.c

 11661	
 11662	__bpf_kfunc int bpf_dynptr_from_xdp(struct xdp_buff *xdp, u64 flags,
 11663					    struct bpf_dynptr_kern *ptr__uninit)
 11664	{
 11665		if (flags) {
 11666			bpf_dynptr_set_null(ptr__uninit);
 11667			return -EINVAL;
 11668		}
 11669	
 11670		bpf_dynptr_init(ptr__uninit, xdp, BPF_DYNPTR_TYPE_XDP, 0, xdp_get_buff_len(xdp));
 11671	
 11672		return 0;
 11673	}
 11674	__diag_pop();
 11675	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
