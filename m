Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA5817DA927
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 21:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbjJ1Tyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 15:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjJ1Tyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 15:54:40 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BDF094
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 12:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698522878; x=1730058878;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=KupxvW8SfWEkvi0E1VvZswZQbyHs9XvqZKnOmX6fp6s=;
  b=dm3fnr3xpYJ9g1vFtTIa0E2X/fAMAQA7aN/3EaOq12jiqrEDOd1i/V1I
   slJFkk+pWbViYh5FyMlBJQQlcbmCYyV6Zp4XLwo4b+wpXYJUGxVyPhGzI
   BV1PMj1IwDkLAeTw7VSofJGE1TFkQZfUXe+e5Cp3w1B/qmLLhb18o5H2L
   iwIuZXYYLIn1oebSWo29aCnLOndzJgkcE9WPDQhtGhsfFymB0lbd47kfg
   9PeMPBeTHVvTK1jONeZpctABlJRiFP8Iqm1SCJHiuMM3CnaGl9+EoAYTF
   LyGVyQ4rGGsJAMfmGEPSfrsYiuGXHccin7REfUGMSmIXMzYceVvJWD6IF
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10877"; a="419028602"
X-IronPort-AV: E=Sophos;i="6.03,259,1694761200"; 
   d="scan'208";a="419028602"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2023 12:54:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10877"; a="763541224"
X-IronPort-AV: E=Sophos;i="6.03,259,1694761200"; 
   d="scan'208";a="763541224"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 28 Oct 2023 12:54:36 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qwpOE-000C2R-1P;
        Sat, 28 Oct 2023 19:54:34 +0000
Date:   Sun, 29 Oct 2023 03:53:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: fs/eventpoll.c:526:9: sparse: sparse: restricted __poll_t degrades
 to integer
Message-ID: <202310290310.o2kYsmHJ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   2af9b20dbb39f6ebf9b9b6c090271594627d818e
commit: caf1aeaffc3b09649a56769e559333ae2c4f1802 eventpoll: add EPOLL_URING_WAKE poll wakeup flag
date:   11 months ago
config: x86_64-randconfig-123-20231016 (https://download.01.org/0day-ci/archive/20231029/202310290310.o2kYsmHJ-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231029/202310290310.o2kYsmHJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310290310.o2kYsmHJ-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> fs/eventpoll.c:526:9: sparse: sparse: restricted __poll_t degrades to integer
>> fs/eventpoll.c:526:9: sparse: sparse: cast to restricted __poll_t
>> fs/eventpoll.c:1213:53: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected unsigned int pollflags @@     got restricted __poll_t @@
   fs/eventpoll.c:1213:53: sparse:     expected unsigned int pollflags
   fs/eventpoll.c:1213:53: sparse:     got restricted __poll_t

vim +526 fs/eventpoll.c

   493	
   494	static void ep_poll_safewake(struct eventpoll *ep, struct epitem *epi,
   495				     unsigned pollflags)
   496	{
   497		struct eventpoll *ep_src;
   498		unsigned long flags;
   499		u8 nests = 0;
   500	
   501		/*
   502		 * To set the subclass or nesting level for spin_lock_irqsave_nested()
   503		 * it might be natural to create a per-cpu nest count. However, since
   504		 * we can recurse on ep->poll_wait.lock, and a non-raw spinlock can
   505		 * schedule() in the -rt kernel, the per-cpu variable are no longer
   506		 * protected. Thus, we are introducing a per eventpoll nest field.
   507		 * If we are not being call from ep_poll_callback(), epi is NULL and
   508		 * we are at the first level of nesting, 0. Otherwise, we are being
   509		 * called from ep_poll_callback() and if a previous wakeup source is
   510		 * not an epoll file itself, we are at depth 1 since the wakeup source
   511		 * is depth 0. If the wakeup source is a previous epoll file in the
   512		 * wakeup chain then we use its nests value and record ours as
   513		 * nests + 1. The previous epoll file nests value is stable since its
   514		 * already holding its own poll_wait.lock.
   515		 */
   516		if (epi) {
   517			if ((is_file_epoll(epi->ffd.file))) {
   518				ep_src = epi->ffd.file->private_data;
   519				nests = ep_src->nests;
   520			} else {
   521				nests = 1;
   522			}
   523		}
   524		spin_lock_irqsave_nested(&ep->poll_wait.lock, flags, nests);
   525		ep->nests = nests + 1;
 > 526		wake_up_locked_poll(&ep->poll_wait, EPOLLIN | pollflags);
   527		ep->nests = 0;
   528		spin_unlock_irqrestore(&ep->poll_wait.lock, flags);
   529	}
   530	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
