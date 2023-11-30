Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA2D07FE6A1
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 03:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344133AbjK3CS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 21:18:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjK3CSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 21:18:55 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98880D5C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 18:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701310741; x=1732846741;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=byRkLg7cLRaRvq6OSMZrA87/Agu7TXJbj07YZC1yHzI=;
  b=T3NC5RWCQHP6vg13gxyPyGyGyCXGfmKSXhUJPrab0CWlNMxOqaHq4qoa
   whDtXgwgqltLpNw+c+pflz2fDnZjliVSf3v9mKVGNGfumuOcuNll9Z2gG
   MhxuAJYnxmhB1XWNG+6vmeY/l92uIi/8q1Fd++gDXRm8pO2WG491IEZry
   vpjJy/5MvXWd/6nKegzvOyY/JtNeO0b//WEeTFzPIXg7jILwTyxAaYPqB
   aKZiMafe7rAU7K1EDC6PjBgOXvozf/dN0BpTECPBmDx+E/juJ7zisCxOz
   13Z/rY84i1U5OgkLpQu8NaRWgc8Igu4FUb71e+VhXHBhAp5/ebfrBGY8O
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="378281155"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="378281155"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 18:19:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="887069379"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="887069379"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 29 Nov 2023 18:18:59 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r8Wdl-0001Ez-0i;
        Thu, 30 Nov 2023 02:18:57 +0000
Date:   Thu, 30 Nov 2023 10:18:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Huacai Chen <chenhuacai@kernel.org>
Subject: kernel/kprobes.c:145: warning: Function parameter or member 'c' not
 described in '__get_insn_slot'
Message-ID: <202311300504.zYicjFKi-lkp@intel.com>
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
head:   3b47bc037bd44f142ac09848e8d3ecccc726be99
commit: 6d4cc40fb5f58147defc6c0e9d86e6232fe31616 LoongArch: Add kprobes support
date:   9 months ago
config: loongarch-randconfig-r034-20230511 (https://download.01.org/0day-ci/archive/20231130/202311300504.zYicjFKi-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20231130/202311300504.zYicjFKi-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311300504.zYicjFKi-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/kprobes.c:145: warning: Function parameter or member 'c' not described in '__get_insn_slot'


vim +145 kernel/kprobes.c

b4c6c34a530b4d1 Masami Hiramatsu           2006-12-06  139  
9ec4b1f356b3bad Ananth N Mavinakayanahalli 2005-06-27  140  /**
129415607845d4d Masami Hiramatsu           2009-01-06  141   * __get_insn_slot() - Find a slot on an executable page for an instruction.
9ec4b1f356b3bad Ananth N Mavinakayanahalli 2005-06-27  142   * We allocate an executable page if there's no room on existing ones.
9ec4b1f356b3bad Ananth N Mavinakayanahalli 2005-06-27  143   */
55479f64756fc50 Masami Hiramatsu           2014-04-17  144  kprobe_opcode_t *__get_insn_slot(struct kprobe_insn_cache *c)
9ec4b1f356b3bad Ananth N Mavinakayanahalli 2005-06-27 @145  {
9ec4b1f356b3bad Ananth N Mavinakayanahalli 2005-06-27  146  	struct kprobe_insn_page *kip;
c802d64a356b5cf Heiko Carstens             2013-09-11  147  	kprobe_opcode_t *slot = NULL;
9ec4b1f356b3bad Ananth N Mavinakayanahalli 2005-06-27  148  
5b485629ba0d5d0 Masami Hiramatsu           2017-01-08  149  	/* Since the slot array is not protected by rcu, we need a mutex */
c802d64a356b5cf Heiko Carstens             2013-09-11  150  	mutex_lock(&c->mutex);
b4c6c34a530b4d1 Masami Hiramatsu           2006-12-06  151   retry:
5b485629ba0d5d0 Masami Hiramatsu           2017-01-08  152  	rcu_read_lock();
5b485629ba0d5d0 Masami Hiramatsu           2017-01-08  153  	list_for_each_entry_rcu(kip, &c->pages, list) {
4610ee1d3638fa0 Masami Hiramatsu           2010-02-25  154  		if (kip->nused < slots_per_page(c)) {
9ec4b1f356b3bad Ananth N Mavinakayanahalli 2005-06-27  155  			int i;
223a76b268c9cfa Masami Hiramatsu           2021-09-14  156  
4610ee1d3638fa0 Masami Hiramatsu           2010-02-25  157  			for (i = 0; i < slots_per_page(c); i++) {
ab40c5c6b6861ee Masami Hiramatsu           2007-01-30  158  				if (kip->slot_used[i] == SLOT_CLEAN) {
ab40c5c6b6861ee Masami Hiramatsu           2007-01-30  159  					kip->slot_used[i] = SLOT_USED;
9ec4b1f356b3bad Ananth N Mavinakayanahalli 2005-06-27  160  					kip->nused++;
c802d64a356b5cf Heiko Carstens             2013-09-11  161  					slot = kip->insns + (i * c->insn_size);
5b485629ba0d5d0 Masami Hiramatsu           2017-01-08  162  					rcu_read_unlock();
c802d64a356b5cf Heiko Carstens             2013-09-11  163  					goto out;
9ec4b1f356b3bad Ananth N Mavinakayanahalli 2005-06-27  164  				}
9ec4b1f356b3bad Ananth N Mavinakayanahalli 2005-06-27  165  			}
4610ee1d3638fa0 Masami Hiramatsu           2010-02-25  166  			/* kip->nused is broken. Fix it. */
4610ee1d3638fa0 Masami Hiramatsu           2010-02-25  167  			kip->nused = slots_per_page(c);
4610ee1d3638fa0 Masami Hiramatsu           2010-02-25  168  			WARN_ON(1);
9ec4b1f356b3bad Ananth N Mavinakayanahalli 2005-06-27  169  		}
9ec4b1f356b3bad Ananth N Mavinakayanahalli 2005-06-27  170  	}
5b485629ba0d5d0 Masami Hiramatsu           2017-01-08  171  	rcu_read_unlock();
9ec4b1f356b3bad Ananth N Mavinakayanahalli 2005-06-27  172  
b4c6c34a530b4d1 Masami Hiramatsu           2006-12-06  173  	/* If there are any garbage slots, collect it and try again. */
4610ee1d3638fa0 Masami Hiramatsu           2010-02-25  174  	if (c->nr_garbage && collect_garbage_slots(c) == 0)
b4c6c34a530b4d1 Masami Hiramatsu           2006-12-06  175  		goto retry;
4610ee1d3638fa0 Masami Hiramatsu           2010-02-25  176  
4610ee1d3638fa0 Masami Hiramatsu           2010-02-25  177  	/* All out of space.  Need to allocate a new page. */
4610ee1d3638fa0 Masami Hiramatsu           2010-02-25  178  	kip = kmalloc(KPROBE_INSN_PAGE_SIZE(slots_per_page(c)), GFP_KERNEL);
6f716acd5fa20ae Christoph Hellwig          2007-05-08  179  	if (!kip)
c802d64a356b5cf Heiko Carstens             2013-09-11  180  		goto out;
9ec4b1f356b3bad Ananth N Mavinakayanahalli 2005-06-27  181  
af96397de860023 Heiko Carstens             2013-09-11  182  	kip->insns = c->alloc();
9ec4b1f356b3bad Ananth N Mavinakayanahalli 2005-06-27  183  	if (!kip->insns) {
9ec4b1f356b3bad Ananth N Mavinakayanahalli 2005-06-27  184  		kfree(kip);
c802d64a356b5cf Heiko Carstens             2013-09-11  185  		goto out;
9ec4b1f356b3bad Ananth N Mavinakayanahalli 2005-06-27  186  	}
c5cb5a2d8d7dc87 Masami Hiramatsu           2009-06-30  187  	INIT_LIST_HEAD(&kip->list);
4610ee1d3638fa0 Masami Hiramatsu           2010-02-25  188  	memset(kip->slot_used, SLOT_CLEAN, slots_per_page(c));
ab40c5c6b6861ee Masami Hiramatsu           2007-01-30  189  	kip->slot_used[0] = SLOT_USED;
9ec4b1f356b3bad Ananth N Mavinakayanahalli 2005-06-27  190  	kip->nused = 1;
b4c6c34a530b4d1 Masami Hiramatsu           2006-12-06  191  	kip->ngarbage = 0;
af96397de860023 Heiko Carstens             2013-09-11  192  	kip->cache = c;
5b485629ba0d5d0 Masami Hiramatsu           2017-01-08  193  	list_add_rcu(&kip->list, &c->pages);
c802d64a356b5cf Heiko Carstens             2013-09-11  194  	slot = kip->insns;
69e49088692899d Adrian Hunter              2020-05-12  195  
69e49088692899d Adrian Hunter              2020-05-12  196  	/* Record the perf ksymbol register event after adding the page */
69e49088692899d Adrian Hunter              2020-05-12  197  	perf_event_ksymbol(PERF_RECORD_KSYMBOL_TYPE_OOL, (unsigned long)kip->insns,
69e49088692899d Adrian Hunter              2020-05-12  198  			   PAGE_SIZE, false, c->sym);
c802d64a356b5cf Heiko Carstens             2013-09-11  199  out:
c802d64a356b5cf Heiko Carstens             2013-09-11  200  	mutex_unlock(&c->mutex);
c802d64a356b5cf Heiko Carstens             2013-09-11  201  	return slot;
129415607845d4d Masami Hiramatsu           2009-01-06  202  }
129415607845d4d Masami Hiramatsu           2009-01-06  203  

:::::: The code at line 145 was first introduced by commit
:::::: 9ec4b1f356b3bad928ae8e2aa9caebfa737d52df [PATCH] kprobes: fix single-step out of line - take2

:::::: TO: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
