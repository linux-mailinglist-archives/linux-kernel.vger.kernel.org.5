Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08D537F050F
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 10:48:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbjKSJsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 04:48:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbjKSJst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 04:48:49 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AAC6192
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 01:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700387326; x=1731923326;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=JV3VNbXlZB5Eh2dU7Ve0s9JjXX74PSMg8M4ztBSLvvI=;
  b=VM/6iKlVsCd26zzPy0GqWG7R/rMN1/VaEFX39pewqjSVjbRsLY3ULU9W
   SvqkUznZaAa2zpi47I7SYql4wNQes0/H8uIudaj34fNCvtNC36hxjSi7W
   BWg9aVcXXpPACuFvDo5y+LUVSHKsEBh8tby6hUUpr4UFUGJ8wUqJMbDA+
   rHfm0x6ZYhHqiF5pcKhTpOtWucoHQwoFlIiyRXQBJwLmZlpoES/z2vL5l
   IuqdbCV8K3chN+FwQ0KOtZ6nDnfLIVPKVAOzvPaziZsRhdZxMeDG1hGLV
   cNgM6LGL5TjrI8eIY+IKDhAQ0g8Yz8c1Ls1/1b38DHYxeul53DqeAyEOj
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10898"; a="381870557"
X-IronPort-AV: E=Sophos;i="6.04,210,1695711600"; 
   d="scan'208";a="381870557"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2023 01:48:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10898"; a="909818004"
X-IronPort-AV: E=Sophos;i="6.04,210,1695711600"; 
   d="scan'208";a="909818004"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 19 Nov 2023 01:48:44 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r4ePx-0004vz-2y;
        Sun, 19 Nov 2023 09:48:41 +0000
Date:   Sun, 19 Nov 2023 17:48:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>
Subject: kernel/bpf/helpers.c:1960:13: sparse: sparse: Using plain integer as
 NULL pointer
Message-ID: <202311191708.PLWPE6Tr-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   037266a5f7239ead1530266f7d7af153d2a867fa
commit: c3c510ce431cd99fa10dcd50d995c8e89330ee5b bpf: Add 'owner' field to bpf_{list,rb}_node
date:   4 months ago
config: hexagon-randconfig-r121-20231119 (https://download.01.org/0day-ci/archive/20231119/202311191708.PLWPE6Tr-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20231119/202311191708.PLWPE6Tr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311191708.PLWPE6Tr-lkp@intel.com/

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
