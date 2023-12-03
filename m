Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2325E802143
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 07:32:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233209AbjLCGbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 01:31:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233009AbjLCGbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 01:31:43 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB19E5
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 22:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701585109; x=1733121109;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=gL87HQzgMGpfWcfAalhQYp5v9PJIIP0g49ErB9OLcYk=;
  b=N/RXEduUh82Chbg6Mo3+7ou08uVxtQmemBMUt03DQSjD7NfdrUf4YZ0n
   r/odj6z3a1HoYsYlXJnU/Oi9QGwEvYhHcynrS1RTUOhSVKrcn+E32eSya
   WEiomlC9CjEat+ar414n5oDOYEEBy7CNPiXkXb4rxDa3ON+EoK36cULB6
   eeESehUTfuM/4ecsm7sNt4AhBuQ6PVCkGxTQ0/c4YcfTLOEgFLHslzx84
   ObeUFLiBMD3D/E2xMWhhsU9SwJgcMgtjh1y/eYe/BPP6My9lX7POerzmf
   GA2Yau7zCpK++wi9A9KiBwcdDuPDU6aqlwIqtyRgEGqw2jFAh3Q1/Addr
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10912"; a="15180362"
X-IronPort-AV: E=Sophos;i="6.04,246,1695711600"; 
   d="scan'208";a="15180362"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2023 22:31:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10912"; a="943556080"
X-IronPort-AV: E=Sophos;i="6.04,246,1695711600"; 
   d="scan'208";a="943556080"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 02 Dec 2023 22:31:46 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r9g11-0006KN-23;
        Sun, 03 Dec 2023 06:31:43 +0000
Date:   Sun, 3 Dec 2023 14:31:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Davide Caratti <dcaratti@redhat.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: net/core/dev.c:2647:23: sparse: sparse: incorrect type in argument 1
 (different base types)
Message-ID: <202312022338.Izl4Hpkq-lkp@intel.com>
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
head:   815fb87b753055df2d9e50f6cd80eb10235fe3e9
commit: b72b5bf6a8fc9065f270ae135bbd47abb9d96790 net: introduce skb_crc32c_csum_help
date:   7 years ago
config: openrisc-randconfig-r131-20231102 (https://download.01.org/0day-ci/archive/20231202/202312022338.Izl4Hpkq-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231202/202312022338.Izl4Hpkq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312022338.Izl4Hpkq-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   net/core/dev.c:2647:23: sparse: sparse: incorrect type in argument 4 (different base types) @@     expected restricted __wsum [usertype] csum @@     got unsigned int @@
   net/core/dev.c:2647:23: sparse:     expected restricted __wsum [usertype] csum
   net/core/dev.c:2647:23: sparse:     got unsigned int
   net/core/dev.c:2647:23: sparse: sparse: cast from restricted __wsum
   net/core/dev.c:2647:23: sparse: sparse: incorrect type in argument 4 (different base types) @@     expected restricted __wsum [usertype] csum @@     got unsigned int @@
   net/core/dev.c:2647:23: sparse:     expected restricted __wsum [usertype] csum
   net/core/dev.c:2647:23: sparse:     got unsigned int
>> net/core/dev.c:2647:23: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __wsum @@
   net/core/dev.c:2647:23: sparse:     expected unsigned int [usertype] val
   net/core/dev.c:2647:23: sparse:     got restricted __wsum
   net/core/dev.c:2647:23: sparse: sparse: incorrect type in argument 4 (different base types) @@     expected restricted __wsum [usertype] csum @@     got unsigned int @@
   net/core/dev.c:2647:23: sparse:     expected restricted __wsum [usertype] csum
   net/core/dev.c:2647:23: sparse:     got unsigned int
   net/core/dev.c:2647:23: sparse: sparse: cast from restricted __wsum
   net/core/dev.c:2647:23: sparse: sparse: incorrect type in argument 4 (different base types) @@     expected restricted __wsum [usertype] csum @@     got unsigned int @@
   net/core/dev.c:2647:23: sparse:     expected restricted __wsum [usertype] csum
   net/core/dev.c:2647:23: sparse:     got unsigned int
   net/core/dev.c:2647:23: sparse: sparse: cast from restricted __wsum
   net/core/dev.c:2647:23: sparse: sparse: incorrect type in argument 4 (different base types) @@     expected restricted __wsum [usertype] csum @@     got unsigned int @@
   net/core/dev.c:2647:23: sparse:     expected restricted __wsum [usertype] csum
   net/core/dev.c:2647:23: sparse:     got unsigned int
   net/core/dev.c:2647:23: sparse: sparse: cast from restricted __wsum
   net/core/dev.c:2647:23: sparse: sparse: incorrect type in argument 4 (different base types) @@     expected restricted __wsum [usertype] csum @@     got unsigned int @@
   net/core/dev.c:2647:23: sparse:     expected restricted __wsum [usertype] csum
   net/core/dev.c:2647:23: sparse:     got unsigned int
   net/core/dev.c:2647:23: sparse: sparse: cast from restricted __wsum
   net/core/dev.c:3168:9: sparse: sparse: context imbalance in '__dev_queue_xmit' - different lock contexts for basic block
   net/core/dev.c:5126:50: sparse: sparse: self-comparison always evaluates to false
   net/core/dev.c:5190:50: sparse: sparse: self-comparison always evaluates to false
   net/core/dev.c:5282:65: sparse: sparse: self-comparison always evaluates to false
   In file included from include/linux/if_ether.h:23,
                    from net/core/dev.c:92:
   In function '__skb_queue_before',
       inlined from '__skb_queue_tail' at include/linux/skbuff.h:1695:2,
       inlined from 'enqueue_to_backlog' at net/core/dev.c:3801:4,
       inlined from 'netif_rx_internal' at net/core/dev.c:3857:9:
   include/linux/skbuff.h:1661:9: warning: array subscript 'struct sk_buff[0]' is partly outside array bounds of 'struct softnet_data[1]' [-Warray-bounds=]
    1661 |         __skb_insert(newsk, next->prev, next, list);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/asm-generic/percpu.h:6,
                    from ./arch/openrisc/include/generated/asm/percpu.h:1,
                    from include/linux/percpu.h:12,
                    from include/linux/hrtimer.h:22,
                    from include/linux/sched.h:19,
                    from include/linux/uaccess.h:4,
                    from net/core/dev.c:75:
   net/core/dev.c: In function 'netif_rx_internal':
   net/core/dev.c:274:45: note: at offset 64 into object 'softnet_data' of size 188
     274 | DEFINE_PER_CPU_ALIGNED(struct softnet_data, softnet_data);
         |                                             ^~~~~~~~~~~~
   include/linux/percpu-defs.h:105:26: note: in definition of macro 'DEFINE_PER_CPU_SECTION'
     105 |         __typeof__(type) name
         |                          ^~~~
   net/core/dev.c:274:1: note: in expansion of macro 'DEFINE_PER_CPU_ALIGNED'
     274 | DEFINE_PER_CPU_ALIGNED(struct softnet_data, softnet_data);
         | ^~~~~~~~~~~~~~~~~~~~~~
   In function '__skb_insert',
       inlined from '__skb_queue_before' at include/linux/skbuff.h:1661:2,
       inlined from '__skb_queue_tail' at include/linux/skbuff.h:1695:2,
       inlined from 'enqueue_to_backlog' at net/core/dev.c:3801:4,
       inlined from 'netif_rx_internal' at net/core/dev.c:3857:9:
   include/linux/skbuff.h:1555:21: warning: array subscript 'struct sk_buff[0]' is partly outside array bounds of 'struct softnet_data[1]' [-Warray-bounds=]
    1555 |         next->prev  = prev->next = newsk;
         |         ~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~
   net/core/dev.c: In function 'netif_rx_internal':
   net/core/dev.c:274:45: note: at offset 64 into object 'softnet_data' of size 188
     274 | DEFINE_PER_CPU_ALIGNED(struct softnet_data, softnet_data);
         |                                             ^~~~~~~~~~~~
   include/linux/percpu-defs.h:105:26: note: in definition of macro 'DEFINE_PER_CPU_SECTION'
     105 |         __typeof__(type) name
         |                          ^~~~
   net/core/dev.c:274:1: note: in expansion of macro 'DEFINE_PER_CPU_ALIGNED'
     274 | DEFINE_PER_CPU_ALIGNED(struct softnet_data, softnet_data);
         | ^~~~~~~~~~~~~~~~~~~~~~
   net/core/dev.c:5607: warning: expecting prototype for netdev_has_upper_dev_all(). Prototype was for netdev_has_upper_dev_all_rcu() instead
   net/core/dev.c:6395: warning: expecting prototype for netdev_lower_change(). Prototype was for netdev_lower_state_changed() instead

vim +2647 net/core/dev.c

  2615	
  2616	int skb_crc32c_csum_help(struct sk_buff *skb)
  2617	{
  2618		__le32 crc32c_csum;
  2619		int ret = 0, offset, start;
  2620	
  2621		if (skb->ip_summed != CHECKSUM_PARTIAL)
  2622			goto out;
  2623	
  2624		if (unlikely(skb_is_gso(skb)))
  2625			goto out;
  2626	
  2627		/* Before computing a checksum, we should make sure no frag could
  2628		 * be modified by an external entity : checksum could be wrong.
  2629		 */
  2630		if (unlikely(skb_has_shared_frag(skb))) {
  2631			ret = __skb_linearize(skb);
  2632			if (ret)
  2633				goto out;
  2634		}
  2635		start = skb_checksum_start_offset(skb);
  2636		offset = start + offsetof(struct sctphdr, checksum);
  2637		if (WARN_ON_ONCE(offset >= skb_headlen(skb))) {
  2638			ret = -EINVAL;
  2639			goto out;
  2640		}
  2641		if (skb_cloned(skb) &&
  2642		    !skb_clone_writable(skb, offset + sizeof(__le32))) {
  2643			ret = pskb_expand_head(skb, 0, 0, GFP_ATOMIC);
  2644			if (ret)
  2645				goto out;
  2646		}
> 2647		crc32c_csum = cpu_to_le32(~__skb_checksum(skb, start,
  2648							  skb->len - start, ~(__u32)0,
  2649							  crc32c_csum_stub));
  2650		*(__le32 *)(skb->data + offset) = crc32c_csum;
  2651		skb->ip_summed = CHECKSUM_NONE;
  2652	out:
  2653		return ret;
  2654	}
  2655	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
