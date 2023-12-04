Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B93CA8042DA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 00:50:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343610AbjLDXuk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 18:50:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343599AbjLDXuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 18:50:11 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC2D10E9
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 15:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701733797; x=1733269797;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=AtkrICPjiZHP+OWMe4qCLMgikIAzA6FGZxabuDPrmZw=;
  b=NSs0lEdlqnT5ur95YMtPlEoYBXJuLOGhrqNHsdF2aXcNPF67x6c8mEcI
   BJxXq2Hok2LLMFP5cp0JNnMthYXz50+S0xvhb3fkdqJQWzhXK9sZMAWzD
   2JjHKpUuai5lJQThM1F2RNWIz+0MVfCAkKtvSAC+gXGhZLg/jxHO9HCby
   GfgmCqAEtuUqRcD5AXVWFnAaAKcuYFl8Cbzhe0srGizwbrjSu1pHK6xvA
   0TMbgm81+qGjP8H+P9biTdVd7C0bztEDNAo+xoi5TTBYf6t7okB7tEEVq
   huji+YduUrx2+alNQSQ0n4B2Vh9lWz0tqypJlW2rrFhYKnSMQ7TMpFMeA
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="458137664"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="458137664"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 15:49:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="861552921"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="861552921"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 04 Dec 2023 15:49:43 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rAIh2-0008BW-1a;
        Mon, 04 Dec 2023 23:49:40 +0000
Date:   Tue, 5 Dec 2023 07:48:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sabrina Dubroca <sd@queasysnail.net>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Steffen Klassert <steffen.klassert@secunet.com>
Subject: net/xfrm/xfrm_state.c:2695:31: sparse: sparse: incorrect type in
 assignment (different address spaces)
Message-ID: <202312050721.MVWRa0sp-lkp@intel.com>
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
head:   bee0e7762ad2c6025b9f5245c040fcc36ef2bde8
commit: fe9f1d8779cb47046e76ea209b6eece7ec56d1b4 xfrm: add state hashtable keyed by seq
date:   2 years, 7 months ago
config: openrisc-randconfig-r133-20231130 (https://download.01.org/0day-ci/archive/20231205/202312050721.MVWRa0sp-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231205/202312050721.MVWRa0sp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312050721.MVWRa0sp-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   net/xfrm/xfrm_state.c:1093:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1093:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1093:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1093:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1093:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1093:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1093:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1093:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1093:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1093:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1093:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1093:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1093:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1093:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1093:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1110:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1110:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1110:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1110:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1110:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1110:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1110:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1110:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1110:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1110:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1110:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1110:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1110:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1110:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1110:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1110:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1110:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1110:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1110:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1110:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1168:77: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct hlist_head *h @@     got struct hlist_head [noderef] __rcu * @@
   net/xfrm/xfrm_state.c:1168:77: sparse:     expected struct hlist_head *h
   net/xfrm/xfrm_state.c:1168:77: sparse:     got struct hlist_head [noderef] __rcu *
   net/xfrm/xfrm_state.c:1170:77: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct hlist_head *h @@     got struct hlist_head [noderef] __rcu * @@
   net/xfrm/xfrm_state.c:1170:77: sparse:     expected struct hlist_head *h
   net/xfrm/xfrm_state.c:1170:77: sparse:     got struct hlist_head [noderef] __rcu *
   net/xfrm/xfrm_state.c:1173:85: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct hlist_head *h @@     got struct hlist_head [noderef] __rcu * @@
   net/xfrm/xfrm_state.c:1173:85: sparse:     expected struct hlist_head *h
   net/xfrm/xfrm_state.c:1173:85: sparse:     got struct hlist_head [noderef] __rcu *
   net/xfrm/xfrm_state.c:1177:85: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct hlist_head *h @@     got struct hlist_head [noderef] __rcu * @@
   net/xfrm/xfrm_state.c:1177:85: sparse:     expected struct hlist_head *h
   net/xfrm/xfrm_state.c:1177:85: sparse:     got struct hlist_head [noderef] __rcu *
   net/xfrm/xfrm_state.c:1195:42: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct xfrm_state [noderef] __rcu *x @@     got struct xfrm_state *[assigned] x @@
   net/xfrm/xfrm_state.c:1195:42: sparse:     expected struct xfrm_state [noderef] __rcu *x
   net/xfrm/xfrm_state.c:1195:42: sparse:     got struct xfrm_state *[assigned] x
   net/xfrm/xfrm_state.c:1282:61: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct hlist_head *h @@     got struct hlist_head [noderef] __rcu * @@
   net/xfrm/xfrm_state.c:1282:61: sparse:     expected struct hlist_head *h
   net/xfrm/xfrm_state.c:1282:61: sparse:     got struct hlist_head [noderef] __rcu *
   net/xfrm/xfrm_state.c:1285:61: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct hlist_head *h @@     got struct hlist_head [noderef] __rcu * @@
   net/xfrm/xfrm_state.c:1285:61: sparse:     expected struct hlist_head *h
   net/xfrm/xfrm_state.c:1285:61: sparse:     got struct hlist_head [noderef] __rcu *
   net/xfrm/xfrm_state.c:1291:69: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct hlist_head *h @@     got struct hlist_head [noderef] __rcu * @@
   net/xfrm/xfrm_state.c:1291:69: sparse:     expected struct hlist_head *h
   net/xfrm/xfrm_state.c:1291:69: sparse:     got struct hlist_head [noderef] __rcu *
   net/xfrm/xfrm_state.c:1297:69: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct hlist_head *h @@     got struct hlist_head [noderef] __rcu * @@
   net/xfrm/xfrm_state.c:1297:69: sparse:     expected struct hlist_head *h
   net/xfrm/xfrm_state.c:1297:69: sparse:     got struct hlist_head [noderef] __rcu *
   net/xfrm/xfrm_state.c:1411:69: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct hlist_head *h @@     got struct hlist_head [noderef] __rcu * @@
   net/xfrm/xfrm_state.c:1411:69: sparse:     expected struct hlist_head *h
   net/xfrm/xfrm_state.c:1411:69: sparse:     got struct hlist_head [noderef] __rcu *
   net/xfrm/xfrm_state.c:1413:69: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct hlist_head *h @@     got struct hlist_head [noderef] __rcu * @@
   net/xfrm/xfrm_state.c:1413:69: sparse:     expected struct hlist_head *h
   net/xfrm/xfrm_state.c:1413:69: sparse:     got struct hlist_head [noderef] __rcu *
   net/xfrm/xfrm_state.c:1972:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1972:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1972:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1972:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1972:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1972:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1972:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1972:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1972:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1972:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1972:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1972:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1972:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1972:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1972:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1972:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1972:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1972:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1972:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1972:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:2076:69: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct hlist_head *h @@     got struct hlist_head [noderef] __rcu * @@
   net/xfrm/xfrm_state.c:2076:69: sparse:     expected struct hlist_head *h
   net/xfrm/xfrm_state.c:2076:69: sparse:     got struct hlist_head [noderef] __rcu *
   net/xfrm/xfrm_state.c:2686:31: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct hlist_head [noderef] __rcu *state_bydst @@     got struct hlist_head * @@
   net/xfrm/xfrm_state.c:2686:31: sparse:     expected struct hlist_head [noderef] __rcu *state_bydst
   net/xfrm/xfrm_state.c:2686:31: sparse:     got struct hlist_head *
   net/xfrm/xfrm_state.c:2689:31: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct hlist_head [noderef] __rcu *state_bysrc @@     got struct hlist_head * @@
   net/xfrm/xfrm_state.c:2689:31: sparse:     expected struct hlist_head [noderef] __rcu *state_bysrc
   net/xfrm/xfrm_state.c:2689:31: sparse:     got struct hlist_head *
   net/xfrm/xfrm_state.c:2692:31: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct hlist_head [noderef] __rcu *state_byspi @@     got struct hlist_head * @@
   net/xfrm/xfrm_state.c:2692:31: sparse:     expected struct hlist_head [noderef] __rcu *state_byspi
   net/xfrm/xfrm_state.c:2692:31: sparse:     got struct hlist_head *
>> net/xfrm/xfrm_state.c:2695:31: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct hlist_head [noderef] __rcu *state_byseq @@     got struct hlist_head * @@
   net/xfrm/xfrm_state.c:2695:31: sparse:     expected struct hlist_head [noderef] __rcu *state_byseq
   net/xfrm/xfrm_state.c:2695:31: sparse:     got struct hlist_head *
   net/xfrm/xfrm_state.c:2708:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct hlist_head *n @@     got struct hlist_head [noderef] __rcu *state_byspi @@
   net/xfrm/xfrm_state.c:2708:33: sparse:     expected struct hlist_head *n
   net/xfrm/xfrm_state.c:2708:33: sparse:     got struct hlist_head [noderef] __rcu *state_byspi
   net/xfrm/xfrm_state.c:2710:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct hlist_head *n @@     got struct hlist_head [noderef] __rcu *state_bysrc @@
   net/xfrm/xfrm_state.c:2710:33: sparse:     expected struct hlist_head *n
   net/xfrm/xfrm_state.c:2710:33: sparse:     got struct hlist_head [noderef] __rcu *state_bysrc
   net/xfrm/xfrm_state.c:2712:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct hlist_head *n @@     got struct hlist_head [noderef] __rcu *state_bydst @@
   net/xfrm/xfrm_state.c:2712:33: sparse:     expected struct hlist_head *n
   net/xfrm/xfrm_state.c:2712:33: sparse:     got struct hlist_head [noderef] __rcu *state_bydst
>> net/xfrm/xfrm_state.c:2728:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct hlist_head const *h @@     got struct hlist_head [noderef] __rcu *state_byseq @@
   net/xfrm/xfrm_state.c:2728:9: sparse:     expected struct hlist_head const *h
   net/xfrm/xfrm_state.c:2728:9: sparse:     got struct hlist_head [noderef] __rcu *state_byseq
>> net/xfrm/xfrm_state.c:2729:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct hlist_head *n @@     got struct hlist_head [noderef] __rcu *state_byseq @@
   net/xfrm/xfrm_state.c:2729:33: sparse:     expected struct hlist_head *n
   net/xfrm/xfrm_state.c:2729:33: sparse:     got struct hlist_head [noderef] __rcu *state_byseq
   net/xfrm/xfrm_state.c:2730:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct hlist_head const *h @@     got struct hlist_head [noderef] __rcu *state_byspi @@
   net/xfrm/xfrm_state.c:2730:9: sparse:     expected struct hlist_head const *h
   net/xfrm/xfrm_state.c:2730:9: sparse:     got struct hlist_head [noderef] __rcu *state_byspi
   net/xfrm/xfrm_state.c:2731:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct hlist_head *n @@     got struct hlist_head [noderef] __rcu *state_byspi @@
   net/xfrm/xfrm_state.c:2731:33: sparse:     expected struct hlist_head *n
   net/xfrm/xfrm_state.c:2731:33: sparse:     got struct hlist_head [noderef] __rcu *state_byspi
   net/xfrm/xfrm_state.c:2732:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct hlist_head const *h @@     got struct hlist_head [noderef] __rcu *state_bysrc @@
   net/xfrm/xfrm_state.c:2732:9: sparse:     expected struct hlist_head const *h
   net/xfrm/xfrm_state.c:2732:9: sparse:     got struct hlist_head [noderef] __rcu *state_bysrc
   net/xfrm/xfrm_state.c:2733:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct hlist_head *n @@     got struct hlist_head [noderef] __rcu *state_bysrc @@
   net/xfrm/xfrm_state.c:2733:33: sparse:     expected struct hlist_head *n
   net/xfrm/xfrm_state.c:2733:33: sparse:     got struct hlist_head [noderef] __rcu *state_bysrc
   net/xfrm/xfrm_state.c:2734:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct hlist_head const *h @@     got struct hlist_head [noderef] __rcu *state_bydst @@
   net/xfrm/xfrm_state.c:2734:9: sparse:     expected struct hlist_head const *h
   net/xfrm/xfrm_state.c:2734:9: sparse:     got struct hlist_head [noderef] __rcu *state_bydst
   net/xfrm/xfrm_state.c:2735:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct hlist_head *n @@     got struct hlist_head [noderef] __rcu *state_bydst @@
   net/xfrm/xfrm_state.c:2735:33: sparse:     expected struct hlist_head *n
   net/xfrm/xfrm_state.c:2735:33: sparse:     got struct hlist_head [noderef] __rcu *state_bydst
   net/xfrm/xfrm_state.c: note: in included file (through include/linux/workqueue.h):
   include/linux/rcupdate.h:709:9: sparse: sparse: context imbalance in 'xfrm_register_type' - unexpected unlock
   include/linux/rcupdate.h:709:9: sparse: sparse: context imbalance in 'xfrm_unregister_type' - unexpected unlock
   net/xfrm/xfrm_state.c:328:13: sparse: sparse: context imbalance in 'xfrm_get_type' - unexpected unlock
   include/linux/rcupdate.h:709:9: sparse: sparse: context imbalance in 'xfrm_register_type_offload' - unexpected unlock
   include/linux/rcupdate.h:709:9: sparse: sparse: context imbalance in 'xfrm_unregister_type_offload' - unexpected unlock
   include/linux/rcupdate.h:709:9: sparse: sparse: context imbalance in 'xfrm_get_type_offload' - unexpected unlock
   net/xfrm/xfrm_state.c:734:17: sparse: sparse: dereference of noderef expression
   net/xfrm/xfrm_state.c:795:17: sparse: sparse: dereference of noderef expression
   net/xfrm/xfrm_state.c:755:17: sparse: sparse: dereference of noderef expression
   net/xfrm/xfrm_state.c:839:17: sparse: sparse: dereference of noderef expression
   net/xfrm/xfrm_state.c:54:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct refcount_struct [usertype] *r @@     got struct refcount_struct [noderef] __rcu * @@
   net/xfrm/xfrm_state.c:54:39: sparse:     expected struct refcount_struct [usertype] *r
   net/xfrm/xfrm_state.c:54:39: sparse:     got struct refcount_struct [noderef] __rcu *
   net/xfrm/xfrm_state.c:54:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct refcount_struct [usertype] *r @@     got struct refcount_struct [noderef] __rcu * @@
   net/xfrm/xfrm_state.c:54:39: sparse:     expected struct refcount_struct [usertype] *r
   net/xfrm/xfrm_state.c:54:39: sparse:     got struct refcount_struct [noderef] __rcu *
   net/xfrm/xfrm_state.c:54:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct refcount_struct [usertype] *r @@     got struct refcount_struct [noderef] __rcu * @@
   net/xfrm/xfrm_state.c:54:39: sparse:     expected struct refcount_struct [usertype] *r
   net/xfrm/xfrm_state.c:54:39: sparse:     got struct refcount_struct [noderef] __rcu *
   net/xfrm/xfrm_state.c:1227:9: sparse: sparse: dereference of noderef expression
   net/xfrm/xfrm_state.c:1321:9: sparse: sparse: dereference of noderef expression
   net/xfrm/xfrm_state.c:1356:9: sparse: sparse: dereference of noderef expression
   net/xfrm/xfrm_state.c: note: in included file:
   include/net/xfrm.h:1731:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   include/net/xfrm.h:1731:16: sparse:    struct sock [noderef] __rcu *
   include/net/xfrm.h:1731:16: sparse:    struct sock *

vim +2695 net/xfrm/xfrm_state.c

  2673	
  2674	int __net_init xfrm_state_init(struct net *net)
  2675	{
  2676		unsigned int sz;
  2677	
  2678		if (net_eq(net, &init_net))
  2679			xfrm_state_cache = KMEM_CACHE(xfrm_state,
  2680						      SLAB_HWCACHE_ALIGN | SLAB_PANIC);
  2681	
  2682		INIT_LIST_HEAD(&net->xfrm.state_all);
  2683	
  2684		sz = sizeof(struct hlist_head) * 8;
  2685	
  2686		net->xfrm.state_bydst = xfrm_hash_alloc(sz);
  2687		if (!net->xfrm.state_bydst)
  2688			goto out_bydst;
  2689		net->xfrm.state_bysrc = xfrm_hash_alloc(sz);
  2690		if (!net->xfrm.state_bysrc)
  2691			goto out_bysrc;
  2692		net->xfrm.state_byspi = xfrm_hash_alloc(sz);
  2693		if (!net->xfrm.state_byspi)
  2694			goto out_byspi;
> 2695		net->xfrm.state_byseq = xfrm_hash_alloc(sz);
  2696		if (!net->xfrm.state_byseq)
  2697			goto out_byseq;
  2698		net->xfrm.state_hmask = ((sz / sizeof(struct hlist_head)) - 1);
  2699	
  2700		net->xfrm.state_num = 0;
  2701		INIT_WORK(&net->xfrm.state_hash_work, xfrm_hash_resize);
  2702		spin_lock_init(&net->xfrm.xfrm_state_lock);
  2703		seqcount_spinlock_init(&net->xfrm.xfrm_state_hash_generation,
  2704				       &net->xfrm.xfrm_state_lock);
  2705		return 0;
  2706	
  2707	out_byseq:
  2708		xfrm_hash_free(net->xfrm.state_byspi, sz);
  2709	out_byspi:
  2710		xfrm_hash_free(net->xfrm.state_bysrc, sz);
  2711	out_bysrc:
  2712		xfrm_hash_free(net->xfrm.state_bydst, sz);
  2713	out_bydst:
  2714		return -ENOMEM;
  2715	}
  2716	
  2717	void xfrm_state_fini(struct net *net)
  2718	{
  2719		unsigned int sz;
  2720	
  2721		flush_work(&net->xfrm.state_hash_work);
  2722		flush_work(&xfrm_state_gc_work);
  2723		xfrm_state_flush(net, 0, false, true);
  2724	
  2725		WARN_ON(!list_empty(&net->xfrm.state_all));
  2726	
  2727		sz = (net->xfrm.state_hmask + 1) * sizeof(struct hlist_head);
> 2728		WARN_ON(!hlist_empty(net->xfrm.state_byseq));
> 2729		xfrm_hash_free(net->xfrm.state_byseq, sz);
  2730		WARN_ON(!hlist_empty(net->xfrm.state_byspi));
  2731		xfrm_hash_free(net->xfrm.state_byspi, sz);
  2732		WARN_ON(!hlist_empty(net->xfrm.state_bysrc));
  2733		xfrm_hash_free(net->xfrm.state_bysrc, sz);
  2734		WARN_ON(!hlist_empty(net->xfrm.state_bydst));
  2735		xfrm_hash_free(net->xfrm.state_bydst, sz);
  2736	}
  2737	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
