Return-Path: <linux-kernel+bounces-11816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF3981EC03
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 05:19:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AC3A1C22170
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 04:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489603C23;
	Wed, 27 Dec 2023 04:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dsLdt9zY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50463C0D
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 04:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703650748; x=1735186748;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=FfW31FsHTVYGpce4eQE3bPJMMctBwdKYYJa67eZF0Ow=;
  b=dsLdt9zYu6YUAmZd0eUpkryTXB1TLKRfv5+XuItwjFKaS8rIKu/p2mjt
   3Zfej5uyZc9lfM+SZv9DddfaTsqmoJtczdGz6E3W6Z9eEmBrCG0Cg9CWg
   hHueVhTAy2sLqn66RAHp2AKZ95XICMs46UcGjOQO1C6bmA0avOWrqA6Pf
   TE3bBlSQeXRHbYfasm+J7JWi4JlN/RcNMrYMu1k0uXilQ6pTLwFJxpTBi
   lFWDin+5W2qx5rfPAbwRnr+4KL9N+TNJEECA3H7AmZpJkWDre5FexRenI
   FrI5ccX8Yjt33OVRlZzIuECphYLnlIHU6CNZUdkI469USr/f9c1lcM1VW
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10935"; a="381383051"
X-IronPort-AV: E=Sophos;i="6.04,308,1695711600"; 
   d="scan'208";a="381383051"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2023 20:19:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10935"; a="896771864"
X-IronPort-AV: E=Sophos;i="6.04,308,1695711600"; 
   d="scan'208";a="896771864"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 26 Dec 2023 20:19:06 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rILNo-000F3t-1K;
	Wed, 27 Dec 2023 04:19:04 +0000
Date: Wed, 27 Dec 2023 12:18:58 +0800
From: kernel test robot <lkp@intel.com>
To: David Howells <dhowells@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: fs/seq_file.c:960:12: sparse: sparse: incorrect type in assignment
 (different address spaces)
Message-ID: <202312271242.6AVwbkKf-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   fbafc3e621c3f4ded43720fdb1d6ce1728ec664e
commit: ad25f5cb39872ca14bcbe00816ae65c22fe04b89 rxrpc: Fix locking issue
date:   1 year, 7 months ago
config: x86_64-alldefconfig (https://download.01.org/0day-ci/archive/20231227/202312271242.6AVwbkKf-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231227/202312271242.6AVwbkKf-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312271242.6AVwbkKf-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   fs/seq_file.c:938:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   fs/seq_file.c:938:9: sparse:    struct list_head [noderef] __rcu *
   fs/seq_file.c:938:9: sparse:    struct list_head *
   fs/seq_file.c:938:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   fs/seq_file.c:938:9: sparse:    struct list_head [noderef] __rcu *
   fs/seq_file.c:938:9: sparse:    struct list_head *
>> fs/seq_file.c:960:12: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct list_head *lh @@     got struct list_head [noderef] __rcu * @@
   fs/seq_file.c:960:12: sparse:     expected struct list_head *lh
   fs/seq_file.c:960:12: sparse:     got struct list_head [noderef] __rcu *
   fs/seq_file.c:1087:24: sparse: sparse: incompatible types in comparison expression (different address spaces):
   fs/seq_file.c:1087:24: sparse:    struct hlist_node [noderef] __rcu *
   fs/seq_file.c:1087:24: sparse:    struct hlist_node *
   fs/seq_file.c:1089:24: sparse: sparse: incompatible types in comparison expression (different address spaces):
   fs/seq_file.c:1089:24: sparse:    struct hlist_node [noderef] __rcu *
   fs/seq_file.c:1089:24: sparse:    struct hlist_node *

vim +960 fs/seq_file.c

   933	
   934	struct list_head *seq_list_start_rcu(struct list_head *head, loff_t pos)
   935	{
   936		struct list_head *lh;
   937	
 > 938		list_for_each_rcu(lh, head)
   939			if (pos-- == 0)
   940				return lh;
   941	
   942		return NULL;
   943	}
   944	EXPORT_SYMBOL(seq_list_start_rcu);
   945	
   946	struct list_head *seq_list_start_head_rcu(struct list_head *head, loff_t pos)
   947	{
   948		if (!pos)
   949			return head;
   950	
   951		return seq_list_start_rcu(head, pos - 1);
   952	}
   953	EXPORT_SYMBOL(seq_list_start_head_rcu);
   954	
   955	struct list_head *seq_list_next_rcu(void *v, struct list_head *head,
   956					    loff_t *ppos)
   957	{
   958		struct list_head *lh;
   959	
 > 960		lh = list_next_rcu((struct list_head *)v);
   961		++*ppos;
   962		return lh == head ? NULL : lh;
   963	}
   964	EXPORT_SYMBOL(seq_list_next_rcu);
   965	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

