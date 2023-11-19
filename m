Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1EC7F085D
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 19:43:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbjKSSnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 13:43:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjKSSnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 13:43:51 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BEE7C2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 10:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700419428; x=1731955428;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=LE8o5lnNNHtK0VORIM/aFWUNtXB/9Dy0DufI4vrEsPw=;
  b=U9w032cIPY4Vq3NySzlyn/lZ+Jq/UOxXAPZcyU4NwZ6vwmukCklmyI3j
   MAbO+Po4Y7fS2D4aMe1GYXfvL32oFBSl9hldlG/v7VDHqbIHcBBeDUMfD
   TTqCIaiYng8DSKBJ2+iCO67cLbecGOfgmsUQ1wgfGjOAbJ8HLQxunT8xh
   SkodwrRgeVeBmV06VZXnMP1eCPmKw2yVpl+mixHRwA/zy5goza7gfwap/
   j7BnFKRyxO/NiGxBP6wEFMDRNGYKuxmIs3Z/S82p0ICoUAup+KquPtV0T
   Ne3gMMNxY+FBryxlLy9S7jnrTSw1GUHtYiu1M0CZY4V+comig+7gErSNr
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="10181185"
X-IronPort-AV: E=Sophos;i="6.04,210,1695711600"; 
   d="scan'208";a="10181185"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2023 10:43:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="795277726"
X-IronPort-AV: E=Sophos;i="6.04,210,1695711600"; 
   d="scan'208";a="795277726"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 19 Nov 2023 10:43:46 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r4mlk-0005PR-05;
        Sun, 19 Nov 2023 18:43:44 +0000
Date:   Mon, 20 Nov 2023 02:43:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>
Subject: kernel/bpf/helpers.c:1960:13: sparse: sparse: Using plain integer as
 NULL pointer
Message-ID: <202311200222.YfH38g2S-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   037266a5f7239ead1530266f7d7af153d2a867fa
commit: c3c510ce431cd99fa10dcd50d995c8e89330ee5b bpf: Add 'owner' field to bpf_{list,rb}_node
date:   4 months ago
config: hexagon-randconfig-r121-20231119 (https://download.01.org/0day-ci/archive/20231120/202311200222.YfH38g2S-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20231120/202311200222.YfH38g2S-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311200222.YfH38g2S-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> kernel/bpf/helpers.c:1960:13: sparse: sparse: Using plain integer as NULL pointer
   kernel/bpf/helpers.c:2059:13: sparse: sparse: Using plain integer as NULL pointer
   kernel/bpf/helpers.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/umh.h, include/linux/kmod.h, ...):
   include/linux/page-flags.h:240:46: sparse: sparse: self-comparison always evaluates to false
   kernel/bpf/helpers.c:2419:18: sparse: sparse: context imbalance in 'bpf_rcu_read_lock' - wrong count at exit
   kernel/bpf/helpers.c:2424:18: sparse: sparse: context imbalance in 'bpf_rcu_read_unlock' - unexpected unlock

vim +1960 kernel/bpf/helpers.c

  1944	
  1945	static int __bpf_list_add(struct bpf_list_node_kern *node,
  1946				  struct bpf_list_head *head,
  1947				  bool tail, struct btf_record *rec, u64 off)
  1948	{
  1949		struct list_head *n = &node->list_head, *h = (void *)head;
  1950	
  1951		/* If list_head was 0-initialized by map, bpf_obj_init_field wasn't
  1952		 * called on its fields, so init here
  1953		 */
  1954		if (unlikely(!h->next))
  1955			INIT_LIST_HEAD(h);
  1956	
  1957		/* node->owner != NULL implies !list_empty(n), no need to separately
  1958		 * check the latter
  1959		 */
> 1960		if (cmpxchg(&node->owner, NULL, BPF_PTR_POISON)) {
  1961			/* Only called from BPF prog, no need to migrate_disable */
  1962			__bpf_obj_drop_impl((void *)n - off, rec);
  1963			return -EINVAL;
  1964		}
  1965	
  1966		tail ? list_add_tail(n, h) : list_add(n, h);
  1967		WRITE_ONCE(node->owner, head);
  1968	
  1969		return 0;
  1970	}
  1971	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
