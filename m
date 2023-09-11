Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC94079B0D0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378700AbjIKWgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243840AbjIKR6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 13:58:37 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5CCCE0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 10:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694455112; x=1725991112;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Gxf0vmQoEIhvZqod62jZG9UmG56BBOre7Atf5NAKTnE=;
  b=l3dEOkvqLzAjjs9cSxfaUiHn9sl/8gUxJFwSysNFWr2P7G3WbsPv0bth
   e8r3DEMR8AR3nnsIHZ1q8H9clhK2WtwWnGw/bE0/qrXZ0iPSs4UiZQy36
   AFAHzZqYd0Nin74w9e3Wp09IQm7aetkRqU/nJQd4GB2L6B+SLZeykFpWf
   DnEnNYBlP5uNNxTLtgH3d7hCf3oVhffRHy3gTWe6oo2dMBFt5k7JDEdSU
   xkwS8v9p6iw+TlEjUUEfLmMtSYZ5x8KECu2TrK/K6Ba0FERRHmJacZaL+
   MhWEpBeHcjgM2GdyvxhDtxA95m3D09V4jBHsRGnClDpowbBuItLuGSMGp
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="363196796"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="363196796"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 10:58:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="693180664"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="693180664"
Received: from lkp-server01.sh.intel.com (HELO 59b3c6e06877) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 11 Sep 2023 10:58:30 -0700
Received: from kbuild by 59b3c6e06877 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qflB6-0006Ya-12;
        Mon, 11 Sep 2023 17:58:28 +0000
Date:   Tue, 12 Sep 2023 01:57:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>
Subject: kernel/bpf/bpf_iter.c:789:17: warning: no previous declaration for
 'bpf_iter_num_new'
Message-ID: <202309120150.uX27LKII-lkp@intel.com>
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
head:   0bb80ecc33a8fb5a682236443c1e740d5c917d1d
commit: 6018e1f407cccf39b804d1f75ad4de7be4e6cc45 bpf: implement numbers iterator
date:   6 months ago
config: x86_64-randconfig-002-20230910 (https://download.01.org/0day-ci/archive/20230912/202309120150.uX27LKII-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230912/202309120150.uX27LKII-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309120150.uX27LKII-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/bpf/bpf_iter.c:789:17: warning: no previous declaration for 'bpf_iter_num_new' [-Wmissing-declarations]
    __bpf_kfunc int bpf_iter_num_new(struct bpf_iter_num *it, int start, int end)
                    ^~~~~~~~~~~~~~~~
>> kernel/bpf/bpf_iter.c:822:18: warning: no previous declaration for 'bpf_iter_num_next' [-Wmissing-declarations]
    __bpf_kfunc int *bpf_iter_num_next(struct bpf_iter_num* it)
                     ^~~~~~~~~~~~~~~~~
>> kernel/bpf/bpf_iter.c:841:18: warning: no previous declaration for 'bpf_iter_num_destroy' [-Wmissing-declarations]
    __bpf_kfunc void bpf_iter_num_destroy(struct bpf_iter_num *it)
                     ^~~~~~~~~~~~~~~~~~~~


vim +/bpf_iter_num_new +789 kernel/bpf/bpf_iter.c

   784	
   785	__diag_push();
   786	__diag_ignore_all("-Wmissing-prototypes",
   787			  "Global functions as their definitions will be in vmlinux BTF");
   788	
 > 789	__bpf_kfunc int bpf_iter_num_new(struct bpf_iter_num *it, int start, int end)
   790	{
   791		struct bpf_iter_num_kern *s = (void *)it;
   792	
   793		BUILD_BUG_ON(sizeof(struct bpf_iter_num_kern) != sizeof(struct bpf_iter_num));
   794		BUILD_BUG_ON(__alignof__(struct bpf_iter_num_kern) != __alignof__(struct bpf_iter_num));
   795	
   796		BTF_TYPE_EMIT(struct btf_iter_num);
   797	
   798		/* start == end is legit, it's an empty range and we'll just get NULL
   799		 * on first (and any subsequent) bpf_iter_num_next() call
   800		 */
   801		if (start > end) {
   802			s->cur = s->end = 0;
   803			return -EINVAL;
   804		}
   805	
   806		/* avoid overflows, e.g., if start == INT_MIN and end == INT_MAX */
   807		if ((s64)end - (s64)start > BPF_MAX_LOOPS) {
   808			s->cur = s->end = 0;
   809			return -E2BIG;
   810		}
   811	
   812		/* user will call bpf_iter_num_next() first,
   813		 * which will set s->cur to exactly start value;
   814		 * underflow shouldn't matter
   815		 */
   816		s->cur = start - 1;
   817		s->end = end;
   818	
   819		return 0;
   820	}
   821	
 > 822	__bpf_kfunc int *bpf_iter_num_next(struct bpf_iter_num* it)
   823	{
   824		struct bpf_iter_num_kern *s = (void *)it;
   825	
   826		/* check failed initialization or if we are done (same behavior);
   827		 * need to be careful about overflow, so convert to s64 for checks,
   828		 * e.g., if s->cur == s->end == INT_MAX, we can't just do
   829		 * s->cur + 1 >= s->end
   830		 */
   831		if ((s64)(s->cur + 1) >= s->end) {
   832			s->cur = s->end = 0;
   833			return NULL;
   834		}
   835	
   836		s->cur++;
   837	
   838		return &s->cur;
   839	}
   840	
 > 841	__bpf_kfunc void bpf_iter_num_destroy(struct bpf_iter_num *it)
   842	{
   843		struct bpf_iter_num_kern *s = (void *)it;
   844	
   845		s->cur = s->end = 0;
   846	}
   847	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
