Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDED7767675
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 21:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234466AbjG1Tkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 15:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234133AbjG1Tkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 15:40:35 -0400
Received: from mgamail.intel.com (unknown [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B63D63A81
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 12:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690573230; x=1722109230;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=YOjZKuUxxHiGhA2pOjH1UI6pwT6R7qzhpZ86ZJt+rfM=;
  b=So4s5pjdMgxxlNzYDGMnx2NpSsJv1A1XGWMk8qO5wO5+qw++ON/K/hqc
   J2cZQTF7ZB68pn4PND/rvdhm6TjzFPa3ucAjoTilTbUCFf2b+ZjkQvq2M
   ckFTYIPC1HRpKrOyr5J91KtjpjxqsjHQnilPFghUfAZnn75C0ZxOsvUug
   Qgr40JA1fA3kYXVcxkN7dXAJYJaUvSA92w0ZiKHTWCHRNM66Wb31LI4s3
   019k+4MCN14IJJ5VEc1Zh/xhxaV5aa9DCxtAxin6wscS4nGw695NsXxQz
   9b5HSziNXO6tyQjRylZSYepnPgIDBZYk+bxFSY9MQkiWSjq4p1JPf9wwL
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10785"; a="432482253"
X-IronPort-AV: E=Sophos;i="6.01,238,1684825200"; 
   d="scan'208";a="432482253"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 12:40:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10785"; a="727574334"
X-IronPort-AV: E=Sophos;i="6.01,238,1684825200"; 
   d="scan'208";a="727574334"
Received: from lkp-server02.sh.intel.com (HELO 953e8cd98f7d) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 28 Jul 2023 12:40:28 -0700
Received: from kbuild by 953e8cd98f7d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qPTK7-0003Wp-33;
        Fri, 28 Jul 2023 19:40:27 +0000
Date:   Sat, 29 Jul 2023 03:39:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Qing Zhang <zhangqing@loongson.cn>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Huacai Chen <chenhuacai@kernel.org>
Subject: net/core/netpoll.c:317:9: sparse: sparse: incorrect type in argument
 1 (different address spaces)
Message-ID: <202307290318.zQhLsxWq-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   57012c57536f8814dec92e74197ee96c3498d24e
commit: 93a4fa622eb061f75f87f0cf9609ab4e69c67d01 LoongArch: Add STACKTRACE support
date:   12 months ago
config: loongarch-randconfig-r072-20230728 (https://download.01.org/0day-ci/archive/20230729/202307290318.zQhLsxWq-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230729/202307290318.zQhLsxWq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307290318.zQhLsxWq-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> net/core/netpoll.c:317:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   net/core/netpoll.c:317:9: sparse:     expected void *ptr
   net/core/netpoll.c:317:9: sparse:     got unsigned int [noderef] __percpu *
>> net/core/netpoll.c:317:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   net/core/netpoll.c:317:9: sparse:     expected void *ptr
   net/core/netpoll.c:317:9: sparse:     got unsigned int [noderef] __percpu *
>> net/core/netpoll.c:317:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   net/core/netpoll.c:317:9: sparse:     expected void *ptr
   net/core/netpoll.c:317:9: sparse:     got unsigned int [noderef] __percpu *
>> net/core/netpoll.c:317:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   net/core/netpoll.c:317:9: sparse:     expected void *ptr
   net/core/netpoll.c:317:9: sparse:     got unsigned int [noderef] __percpu *
>> net/core/netpoll.c:317:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   net/core/netpoll.c:317:9: sparse:     expected void *ptr
   net/core/netpoll.c:317:9: sparse:     got int [noderef] __percpu *
>> net/core/netpoll.c:317:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   net/core/netpoll.c:317:9: sparse:     expected void *ptr
   net/core/netpoll.c:317:9: sparse:     got int [noderef] __percpu *
>> net/core/netpoll.c:317:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   net/core/netpoll.c:317:9: sparse:     expected void *ptr
   net/core/netpoll.c:317:9: sparse:     got int [noderef] __percpu *
>> net/core/netpoll.c:317:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   net/core/netpoll.c:317:9: sparse:     expected void *ptr
   net/core/netpoll.c:317:9: sparse:     got int [noderef] __percpu *
   net/core/netpoll.c:348:25: sparse: sparse: context imbalance in '__netpoll_send_skb' - different lock contexts for basic block

vim +317 net/core/netpoll.c

bea3348eef27e60 Stephen Hemminger   2007-10-03  307  
2899656b494dcd1 Amerigo Wang        2012-08-10  308  /* call with IRQ disabled */
1ddabdfaf70c202 Eric Dumazet        2020-05-07  309  static netdev_tx_t __netpoll_send_skb(struct netpoll *np, struct sk_buff *skb)
^1da177e4c3f415 Linus Torvalds      2005-04-16  310  {
a54776f2c4939bd Yunjian Wang        2020-04-29  311  	netdev_tx_t status = NETDEV_TX_BUSY;
307f660d056b5eb Eric Dumazet        2020-05-07  312  	struct net_device *dev;
2bdfe0baeca0e27 Stephen Hemminger   2006-10-26  313  	unsigned long tries;
de85d99eb7b595f Herbert Xu          2010-06-10  314  	/* It is up to the caller to keep npinfo alive. */
2899656b494dcd1 Amerigo Wang        2012-08-10  315  	struct netpoll_info *npinfo;
f0d3459d0722782 Matt Mackall        2005-08-11  316  
af0733937317e1e Frederic Weisbecker 2017-11-06 @317  	lockdep_assert_irqs_disabled();
2899656b494dcd1 Amerigo Wang        2012-08-10  318  
307f660d056b5eb Eric Dumazet        2020-05-07  319  	dev = np->dev;
307f660d056b5eb Eric Dumazet        2020-05-07  320  	npinfo = rcu_dereference_bh(dev->npinfo);
307f660d056b5eb Eric Dumazet        2020-05-07  321  
2bdfe0baeca0e27 Stephen Hemminger   2006-10-26  322  	if (!npinfo || !netif_running(dev) || !netif_device_present(dev)) {
080b3c19a4ffe46 Eric W. Biederman   2014-03-27  323  		dev_kfree_skb_irq(skb);
1ddabdfaf70c202 Eric Dumazet        2020-05-07  324  		return NET_XMIT_DROP;
^1da177e4c3f415 Linus Torvalds      2005-04-16  325  	}
^1da177e4c3f415 Linus Torvalds      2005-04-16  326  
2bdfe0baeca0e27 Stephen Hemminger   2006-10-26  327  	/* don't get messages out of order, and no recursion */
bea3348eef27e60 Stephen Hemminger   2007-10-03  328  	if (skb_queue_len(&npinfo->txq) == 0 && !netpoll_owner_active(dev)) {
fd2ea0a79faad82 David S. Miller     2008-07-17  329  		struct netdev_queue *txq;
a49f99ffca57a2e Andrew Morton       2006-12-11  330  
4bd97d51a5e602e Paolo Abeni         2019-03-20  331  		txq = netdev_core_pick_tx(dev, skb, NULL);
fd2ea0a79faad82 David S. Miller     2008-07-17  332  
2bdfe0baeca0e27 Stephen Hemminger   2006-10-26  333  		/* try until next clock tick */
e37b8d931936f88 Andrew Morton       2006-12-09  334  		for (tries = jiffies_to_usecs(1)/USEC_PER_POLL;
e37b8d931936f88 Andrew Morton       2006-12-09  335  		     tries > 0; --tries) {
5efeac44cfca62f Eric W. Biederman   2014-03-27  336  			if (HARD_TX_TRYLOCK(dev, txq)) {
944e294857033db Eric W. Biederman   2014-03-27  337  				if (!netif_xmit_stopped(txq))
944e294857033db Eric W. Biederman   2014-03-27  338  					status = netpoll_start_xmit(skb, dev, txq);
689971b44613883 Amerigo Wang        2012-08-10  339  
5efeac44cfca62f Eric W. Biederman   2014-03-27  340  				HARD_TX_UNLOCK(dev, txq);
^1da177e4c3f415 Linus Torvalds      2005-04-16  341  
2c1644cf6d46a82 Feng Sun            2019-08-26  342  				if (dev_xmit_complete(status))
2bdfe0baeca0e27 Stephen Hemminger   2006-10-26  343  					break;
8834807b43200b1 Jeremy Fitzhardinge 2006-06-26  344  
0db3dc73f7a3a73 Stephen Hemminger   2007-06-27  345  			}
0db3dc73f7a3a73 Stephen Hemminger   2007-06-27  346  
2bdfe0baeca0e27 Stephen Hemminger   2006-10-26  347  			/* tickle device maybe there is some cleanup */
2a49e001cbe3ebf Joe Perches         2011-06-30  348  			netpoll_poll_dev(np->dev);
^1da177e4c3f415 Linus Torvalds      2005-04-16  349  
2bdfe0baeca0e27 Stephen Hemminger   2006-10-26  350  			udelay(USEC_PER_POLL);
2bdfe0baeca0e27 Stephen Hemminger   2006-10-26  351  		}
79b1bee888d43b1 Dongdong Deng       2009-08-21  352  
79b1bee888d43b1 Dongdong Deng       2009-08-21  353  		WARN_ONCE(!irqs_disabled(),
d75f773c86a2b8b Sakari Ailus        2019-03-25  354  			"netpoll_send_skb_on_dev(): %s enabled interrupts in poll (%pS)\n",
944e294857033db Eric W. Biederman   2014-03-27  355  			dev->name, dev->netdev_ops->ndo_start_xmit);
79b1bee888d43b1 Dongdong Deng       2009-08-21  356  
e37b8d931936f88 Andrew Morton       2006-12-09  357  	}
f0d3459d0722782 Matt Mackall        2005-08-11  358  
2c1644cf6d46a82 Feng Sun            2019-08-26  359  	if (!dev_xmit_complete(status)) {
5de4a473bda4955 Stephen Hemminger   2006-10-26  360  		skb_queue_tail(&npinfo->txq, skb);
4c1ac1b49122b80 David Howells       2006-12-05  361  		schedule_delayed_work(&npinfo->tx_work,0);
2bdfe0baeca0e27 Stephen Hemminger   2006-10-26  362  	}
1ddabdfaf70c202 Eric Dumazet        2020-05-07  363  	return NETDEV_TX_OK;
^1da177e4c3f415 Linus Torvalds      2005-04-16  364  }
fb1eee476b0d3be Eric Dumazet        2020-05-07  365  

:::::: The code at line 317 was first introduced by commit
:::::: af0733937317e1e03b60f3af8cf9cd59d665593c netpoll: Use lockdep to assert IRQs are disabled/enabled

:::::: TO: Frederic Weisbecker <frederic@kernel.org>
:::::: CC: Ingo Molnar <mingo@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
