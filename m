Return-Path: <linux-kernel+bounces-126422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F3388937AC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 05:09:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D7B7281949
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 03:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA8A1FAA;
	Mon,  1 Apr 2024 03:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d6M5E941"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A87A5F
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 03:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711940949; cv=none; b=aL4LiQUYFJH4YPGyv31t3AJ8XcvKDcsaG+W3HWwHLvT4nK0VjQt38VvnWBhnkzdOs8DUJoDwK3rznx4Fq+LvR0FIMo/yUmm8MpHiGTIS5McYHHtHdVsD5+Pjzyvh4RnsCm/dNe5INGevWlDXUm5POhf/Z5tVphK9CO859CCjAOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711940949; c=relaxed/simple;
	bh=swY/Pv8MLPfDKkh1kLYkz8IzjgF9q7YDRTl8lmbFf/c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=AF96AEsSqQZ6nHa7Sp246Jh8cujEpUUnhwD0rw7v4HWWZxtjSdczyc6ALfl0Yr5OHkuO7lPRK/0zhLwSpb0ByqJ1kHp4Twr0MaennJD75PUOfgW/XbGu8zFD5zCcauUWvoZCHcdVjCUVHkqTLCc9j1JQ0QDKFqYV+wTNW4F9hzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d6M5E941; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711940944; x=1743476944;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=swY/Pv8MLPfDKkh1kLYkz8IzjgF9q7YDRTl8lmbFf/c=;
  b=d6M5E941tAkjY6rRHo9YXlI8zOiYa6O3/wqW+4EGCi1AAjZmHYGUzjVN
   MZVoWS0TnZ7KJ5HrGi4YBBC5F2l5S4otdA2DAivbJ4MFZNaG71Tj7Z2M1
   dEfxnTGoSBe9jEdbXBbg8kcC04fVvP+E+v2SQjX9LECScWrK7DkEKzAPp
   Ikqevm03R6otgqOVvdZWQouFgO9RlKe2UZ5IeNi92PWzueg4+H1rklwSV
   bd17BEwdUZCvdFqG8xfuLY45CQ9VcIAcDI9wpxsrlgDU9rkVZ/0ODOrix
   vhJ6yk88EWKcuTNAou6i2iHbuo9snDB6kZFxXqi1yMoQ78skcNNHVeq3u
   A==;
X-CSE-ConnectionGUID: pPiUE3DSTDK0CdrpBRcK1Q==
X-CSE-MsgGUID: HqZQYlbNQCedkDFHkCx5Ew==
X-IronPort-AV: E=McAfee;i="6600,9927,11030"; a="6953709"
X-IronPort-AV: E=Sophos;i="6.07,171,1708416000"; 
   d="scan'208";a="6953709"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2024 20:09:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,171,1708416000"; 
   d="scan'208";a="48562881"
Received: from lkp-server01.sh.intel.com (HELO 3d808bfd2502) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 31 Mar 2024 20:09:01 -0700
Received: from kbuild by 3d808bfd2502 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rr82d-0001c6-0y;
	Mon, 01 Apr 2024 03:08:59 +0000
Date: Mon, 1 Apr 2024 11:08:03 +0800
From: kernel test robot <lkp@intel.com>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Huacai Chen <chenhuacai@kernel.org>
Subject: kernel/kprobes.c:145: warning: Function parameter or member 'c' not
 described in '__get_insn_slot'
Message-ID: <202404011027.QGLZE6SP-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Tiezhu,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   39cd87c4eb2b893354f3b850f916353f2658ae6f
commit: 6d4cc40fb5f58147defc6c0e9d86e6232fe31616 LoongArch: Add kprobes support
date:   1 year, 1 month ago
config: loongarch-randconfig-r034-20230511 (https://download.01.org/0day-ci/archive/20240401/202404011027.QGLZE6SP-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20240401/202404011027.QGLZE6SP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404011027.QGLZE6SP-lkp@intel.com/

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

