Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8E277E0153
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 11:31:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbjKCIla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 04:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbjKCIl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 04:41:28 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF3AD42
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 01:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699000882; x=1730536882;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=fcSMotAw7NpTW6d2CGDMFiwEtwcNdQT/9Azw52N/s/Y=;
  b=E/0+T1fPYnQT0M3JBAPPk4aUzP1P34OB5OugXiLg34xa0uDZXB+irQeB
   pXqMBk4YY13FgAtbtHz9ZhwEtI4N8YI0wMR/MJ2658PYLgYV8//DBrKwy
   nQ8H3oZANlRwVvY1ClipPOvD66bhLzgiCLZw++ZZkXNJviKvAySD4fSue
   X01YWKBJwgp+RX6qM8AhL5KtyKzajWmEtvJSRSo1Qk54Hx5UiL3oLCA0Y
   jifuoAlskHPMaMgLFHsNjnXinydW4hM3gI/5uLXMbpBX2VyAbOHq4H58M
   rCj/kpN1BH+xpfqySlCl8gKmQtwsHf9v0i9zyZn86LxaKWW/jul6L7uJG
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="379305546"
X-IronPort-AV: E=Sophos;i="6.03,273,1694761200"; 
   d="scan'208";a="379305546"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 01:41:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,273,1694761200"; 
   d="scan'208";a="2832995"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 03 Nov 2023 01:41:20 -0700
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qypjy-0002Nc-03;
        Fri, 03 Nov 2023 08:41:18 +0000
Date:   Fri, 3 Nov 2023 16:40:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Florian Westphal <fw@strlen.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: net/netfilter/nft_set_rbtree.c:636:33: warning: variable 'nft_net'
 set but not used
Message-ID: <202311031627.Kx0hfrUu-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
head:   8f6f76a6a29f36d2f3e4510d0bde5046672f6924
commit: 7d259f021aaa78904b6c836d975e8e00d83a182a netfilter: nft_set_rbtree: prefer sync gc to async worker
date:   10 days ago
config: s390-defconfig (https://download.01.org/0day-ci/archive/20231103/202311031627.Kx0hfrUu-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231103/202311031627.Kx0hfrUu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311031627.Kx0hfrUu-lkp@intel.com/

All warnings (new ones prefixed by >>):

   net/netfilter/nft_set_rbtree.c: In function 'nft_rbtree_gc':
>> net/netfilter/nft_set_rbtree.c:636:33: warning: variable 'nft_net' set but not used [-Wunused-but-set-variable]
     636 |         struct nftables_pernet *nft_net;
         |                                 ^~~~~~~


vim +/nft_net +636 net/netfilter/nft_set_rbtree.c

7d259f021aaa78 Florian Westphal  2023-10-13  631  
7d259f021aaa78 Florian Westphal  2023-10-13  632  static void nft_rbtree_gc(struct nft_set *set)
8d8540c4f5e03d Pablo Neira Ayuso 2018-05-16  633  {
7d259f021aaa78 Florian Westphal  2023-10-13  634  	struct nft_rbtree *priv = nft_set_priv(set);
f6c383b8c31a93 Pablo Neira Ayuso 2023-08-09  635  	struct nft_rbtree_elem *rbe, *rbe_end = NULL;
f6c383b8c31a93 Pablo Neira Ayuso 2023-08-09 @636  	struct nftables_pernet *nft_net;
7d259f021aaa78 Florian Westphal  2023-10-13  637  	struct rb_node *node, *next;
f6c383b8c31a93 Pablo Neira Ayuso 2023-08-09  638  	struct nft_trans_gc *gc;
5d235d6ce75c12 Pablo Neira Ayuso 2023-01-14  639  	struct net *net;
8d8540c4f5e03d Pablo Neira Ayuso 2018-05-16  640  
8d8540c4f5e03d Pablo Neira Ayuso 2018-05-16  641  	set  = nft_set_container_of(priv);
5d235d6ce75c12 Pablo Neira Ayuso 2023-01-14  642  	net  = read_pnet(&set->net);
f6c383b8c31a93 Pablo Neira Ayuso 2023-08-09  643  	nft_net = nft_pernet(net);
f6c383b8c31a93 Pablo Neira Ayuso 2023-08-09  644  
7d259f021aaa78 Florian Westphal  2023-10-13  645  	gc = nft_trans_gc_alloc(set, 0, GFP_KERNEL);
f6c383b8c31a93 Pablo Neira Ayuso 2023-08-09  646  	if (!gc)
7d259f021aaa78 Florian Westphal  2023-10-13  647  		return;
f6c383b8c31a93 Pablo Neira Ayuso 2023-08-09  648  
7d259f021aaa78 Florian Westphal  2023-10-13  649  	for (node = rb_first(&priv->root); node ; node = next) {
7d259f021aaa78 Florian Westphal  2023-10-13  650  		next = rb_next(node);
f6c383b8c31a93 Pablo Neira Ayuso 2023-08-09  651  
8d8540c4f5e03d Pablo Neira Ayuso 2018-05-16  652  		rbe = rb_entry(node, struct nft_rbtree_elem, node);
8d8540c4f5e03d Pablo Neira Ayuso 2018-05-16  653  
5d235d6ce75c12 Pablo Neira Ayuso 2023-01-14  654  		/* elements are reversed in the rbtree for historical reasons,
5d235d6ce75c12 Pablo Neira Ayuso 2023-01-14  655  		 * from highest to lowest value, that is why end element is
5d235d6ce75c12 Pablo Neira Ayuso 2023-01-14  656  		 * always visited before the start element.
5d235d6ce75c12 Pablo Neira Ayuso 2023-01-14  657  		 */
8d8540c4f5e03d Pablo Neira Ayuso 2018-05-16  658  		if (nft_rbtree_interval_end(rbe)) {
a13f814a67b12a Taehee Yoo        2018-08-30  659  			rbe_end = rbe;
8d8540c4f5e03d Pablo Neira Ayuso 2018-05-16  660  			continue;
8d8540c4f5e03d Pablo Neira Ayuso 2018-05-16  661  		}
8d8540c4f5e03d Pablo Neira Ayuso 2018-05-16  662  		if (!nft_set_elem_expired(&rbe->ext))
8d8540c4f5e03d Pablo Neira Ayuso 2018-05-16  663  			continue;
5d235d6ce75c12 Pablo Neira Ayuso 2023-01-14  664  
7d259f021aaa78 Florian Westphal  2023-10-13  665  		gc = nft_trans_gc_queue_sync(gc, GFP_KERNEL);
f6c383b8c31a93 Pablo Neira Ayuso 2023-08-09  666  		if (!gc)
f6c383b8c31a93 Pablo Neira Ayuso 2023-08-09  667  			goto try_later;
8d8540c4f5e03d Pablo Neira Ayuso 2018-05-16  668  
7d259f021aaa78 Florian Westphal  2023-10-13  669  		/* end element needs to be removed first, it has
7d259f021aaa78 Florian Westphal  2023-10-13  670  		 * no timeout extension.
7d259f021aaa78 Florian Westphal  2023-10-13  671  		 */
7d259f021aaa78 Florian Westphal  2023-10-13  672  		if (rbe_end) {
7d259f021aaa78 Florian Westphal  2023-10-13  673  			nft_rbtree_gc_remove(net, set, priv, rbe_end);
f6c383b8c31a93 Pablo Neira Ayuso 2023-08-09  674  			nft_trans_gc_elem_add(gc, rbe_end);
a13f814a67b12a Taehee Yoo        2018-08-30  675  			rbe_end = NULL;
7d259f021aaa78 Florian Westphal  2023-10-13  676  		}
7d259f021aaa78 Florian Westphal  2023-10-13  677  
7d259f021aaa78 Florian Westphal  2023-10-13  678  		gc = nft_trans_gc_queue_sync(gc, GFP_KERNEL);
f6c383b8c31a93 Pablo Neira Ayuso 2023-08-09  679  		if (!gc)
f6c383b8c31a93 Pablo Neira Ayuso 2023-08-09  680  			goto try_later;
f6c383b8c31a93 Pablo Neira Ayuso 2023-08-09  681  
7d259f021aaa78 Florian Westphal  2023-10-13  682  		nft_rbtree_gc_remove(net, set, priv, rbe);
f6c383b8c31a93 Pablo Neira Ayuso 2023-08-09  683  		nft_trans_gc_elem_add(gc, rbe);
8d8540c4f5e03d Pablo Neira Ayuso 2018-05-16  684  	}
f6c383b8c31a93 Pablo Neira Ayuso 2023-08-09  685  
f6c383b8c31a93 Pablo Neira Ayuso 2023-08-09  686  try_later:
8d8540c4f5e03d Pablo Neira Ayuso 2018-05-16  687  
7d259f021aaa78 Florian Westphal  2023-10-13  688  	if (gc) {
7d259f021aaa78 Florian Westphal  2023-10-13  689  		gc = nft_trans_gc_catchall_sync(gc);
7d259f021aaa78 Florian Westphal  2023-10-13  690  		nft_trans_gc_queue_sync_done(gc);
7d259f021aaa78 Florian Westphal  2023-10-13  691  		priv->last_gc = jiffies;
7d259f021aaa78 Florian Westphal  2023-10-13  692  	}
8d8540c4f5e03d Pablo Neira Ayuso 2018-05-16  693  }
8d8540c4f5e03d Pablo Neira Ayuso 2018-05-16  694  

:::::: The code at line 636 was first introduced by commit
:::::: f6c383b8c31a93752a52697f8430a71dcbc46adf netfilter: nf_tables: adapt set backend to use GC transaction API

:::::: TO: Pablo Neira Ayuso <pablo@netfilter.org>
:::::: CC: Pablo Neira Ayuso <pablo@netfilter.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
