Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7038B799C4B
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 04:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344172AbjIJCAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 22:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233350AbjIJCAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 22:00:15 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA9AD132
        for <linux-kernel@vger.kernel.org>; Sat,  9 Sep 2023 19:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694311209; x=1725847209;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=JNFGM5eSTMbD5FHEUqo7i2Bh7InZ7iX5RgnaEQIj+4M=;
  b=gbJxDwHjm33wP+UuFlC5Ap+pMDjEGxLbe81tFkf1vFJWIsjPfJ6CUp/b
   mAGHEB5O83vK4MHsmM/xDHyHg5BZa18oqFo9o5DodOorUXqGTDZtEAGUu
   djMABfR7tS1wqrcL6oJDMU6IZ8L+cfT5J+4sRiOvlUsmuyYttZ5TRsrqH
   JvXNF+iXKcloiph60MbsIoHbI955JhQM6Nx00jbMbucXR6WQeHyXQVKtk
   zB7NdfDBXy+sub8bmXiy6DCNlJ8WRIX+NyyY9tNYyY3siho6YN8cpQbDF
   Dq1ZerjvIVkc+jcNV4eW1iBdb6asFzqmFtiZz2qPCzGU4slay0I4v0fSp
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="362909121"
X-IronPort-AV: E=Sophos;i="6.02,240,1688454000"; 
   d="scan'208";a="362909121"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2023 19:00:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="736364071"
X-IronPort-AV: E=Sophos;i="6.02,240,1688454000"; 
   d="scan'208";a="736364071"
Received: from lkp-server01.sh.intel.com (HELO 59b3c6e06877) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 09 Sep 2023 19:00:07 -0700
Received: from kbuild by 59b3c6e06877 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qf9k5-0004Cl-0Q;
        Sun, 10 Sep 2023 02:00:05 +0000
Date:   Sun, 10 Sep 2023 09:59:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexei Starovoitov <ast@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: kernel/bpf/hashtab.c:1059:30: sparse: sparse: incorrect type in
 assignment (different address spaces)
Message-ID: <202309100946.Ulnm01iI-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   a3c57ab79a06e333a869ae340420cb3c6f5921d3
commit: ee4ed53c5eb62f49f23560cc2642353547e46c32 bpf: Convert percpu hash map to per-cpu bpf_mem_alloc.
date:   1 year ago
config: i386-randconfig-063-20230910 (https://download.01.org/0day-ci/archive/20230910/202309100946.Ulnm01iI-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230910/202309100946.Ulnm01iI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309100946.Ulnm01iI-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> kernel/bpf/hashtab.c:1059:30: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __percpu *[assigned] pptr @@     got void * @@
   kernel/bpf/hashtab.c:1059:30: sparse:     expected void [noderef] __percpu *[assigned] pptr
   kernel/bpf/hashtab.c:1059:30: sparse:     got void *
>> kernel/bpf/hashtab.c:1065:44: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *ptr_to_pptr @@     got void [noderef] __percpu *[assigned] pptr @@
   kernel/bpf/hashtab.c:1065:44: sparse:     expected void *ptr_to_pptr
   kernel/bpf/hashtab.c:1065:44: sparse:     got void [noderef] __percpu *[assigned] pptr
>> kernel/bpf/hashtab.c:1066:34: sparse: sparse: cast removes address space '__percpu' of expression
   kernel/bpf/hashtab.c:1066:30: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __percpu *[assigned] pptr @@     got void * @@
   kernel/bpf/hashtab.c:1066:30: sparse:     expected void [noderef] __percpu *[assigned] pptr
   kernel/bpf/hashtab.c:1066:30: sparse:     got void *
   kernel/bpf/hashtab.c:1441:27: sparse: sparse: context imbalance in 'htab_map_delete_elem' - unexpected unlock
   kernel/bpf/hashtab.c:1475:27: sparse: sparse: context imbalance in 'htab_lru_map_delete_elem' - unexpected unlock
   kernel/bpf/hashtab.c:1650:27: sparse: sparse: context imbalance in '__htab_map_lookup_and_delete_elem' - unexpected unlock
   kernel/bpf/hashtab.c: note: in included file (through include/linux/workqueue.h, include/linux/bpf.h):
   include/linux/rcupdate.h:737:9: sparse: sparse: context imbalance in '__htab_map_lookup_and_delete_batch' - unexpected unlock
   include/linux/rcupdate.h:737:9: sparse: sparse: context imbalance in 'bpf_hash_map_seq_find_next' - unexpected unlock
   include/linux/rcupdate.h:737:9: sparse: sparse: context imbalance in 'bpf_hash_map_seq_stop' - unexpected unlock

vim +1059 kernel/bpf/hashtab.c

  1006	
  1007	static struct htab_elem *alloc_htab_elem(struct bpf_htab *htab, void *key,
  1008						 void *value, u32 key_size, u32 hash,
  1009						 bool percpu, bool onallcpus,
  1010						 struct htab_elem *old_elem)
  1011	{
  1012		u32 size = htab->map.value_size;
  1013		bool prealloc = htab_is_prealloc(htab);
  1014		struct htab_elem *l_new, **pl_new;
  1015		void __percpu *pptr;
  1016	
  1017		if (prealloc) {
  1018			if (old_elem) {
  1019				/* if we're updating the existing element,
  1020				 * use per-cpu extra elems to avoid freelist_pop/push
  1021				 */
  1022				pl_new = this_cpu_ptr(htab->extra_elems);
  1023				l_new = *pl_new;
  1024				htab_put_fd_value(htab, old_elem);
  1025				*pl_new = old_elem;
  1026			} else {
  1027				struct pcpu_freelist_node *l;
  1028	
  1029				l = __pcpu_freelist_pop(&htab->freelist);
  1030				if (!l)
  1031					return ERR_PTR(-E2BIG);
  1032				l_new = container_of(l, struct htab_elem, fnode);
  1033			}
  1034		} else {
  1035			if (is_map_full(htab))
  1036				if (!old_elem)
  1037					/* when map is full and update() is replacing
  1038					 * old element, it's ok to allocate, since
  1039					 * old element will be freed immediately.
  1040					 * Otherwise return an error
  1041					 */
  1042					return ERR_PTR(-E2BIG);
  1043			inc_elem_count(htab);
  1044			l_new = bpf_mem_cache_alloc(&htab->ma);
  1045			if (!l_new) {
  1046				l_new = ERR_PTR(-ENOMEM);
  1047				goto dec_count;
  1048			}
  1049			check_and_init_map_value(&htab->map,
  1050						 l_new->key + round_up(key_size, 8));
  1051		}
  1052	
  1053		memcpy(l_new->key, key, key_size);
  1054		if (percpu) {
  1055			if (prealloc) {
  1056				pptr = htab_elem_get_ptr(l_new, key_size);
  1057			} else {
  1058				/* alloc_percpu zero-fills */
> 1059				pptr = bpf_mem_cache_alloc(&htab->pcpu_ma);
  1060				if (!pptr) {
  1061					bpf_mem_cache_free(&htab->ma, l_new);
  1062					l_new = ERR_PTR(-ENOMEM);
  1063					goto dec_count;
  1064				}
> 1065				l_new->ptr_to_pptr = pptr;
> 1066				pptr = *(void **)pptr;
  1067			}
  1068	
  1069			pcpu_init_value(htab, pptr, value, onallcpus);
  1070	
  1071			if (!prealloc)
  1072				htab_elem_set_ptr(l_new, key_size, pptr);
  1073		} else if (fd_htab_map_needs_adjust(htab)) {
  1074			size = round_up(size, 8);
  1075			memcpy(l_new->key + round_up(key_size, 8), value, size);
  1076		} else {
  1077			copy_map_value(&htab->map,
  1078				       l_new->key + round_up(key_size, 8),
  1079				       value);
  1080		}
  1081	
  1082		l_new->hash = hash;
  1083		return l_new;
  1084	dec_count:
  1085		dec_elem_count(htab);
  1086		return l_new;
  1087	}
  1088	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
