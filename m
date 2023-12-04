Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59A4C804117
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 22:44:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234470AbjLDVoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 16:44:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234395AbjLDVoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 16:44:30 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2821C3
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 13:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701726275; x=1733262275;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=WP2aq4rr2Ypd4HsEs8qi2OsgN1POFH/NicUsWNl1ZnU=;
  b=n65nCidTkGPLA7l+sz2mVu61l+q51lOSOUJM4LGzS9NkwSRSnUgg0QsK
   xnv3rEYkKLijLFFAoHv8CSbxlpMiwKUoMaE3OzTFIuLSBTtgawuBXMI2U
   7WNMt8tyaj0FH6QJ/EFseRYjcpVohj25XX9qSmWmvSF61YlrORwjHNRdF
   cndGoSxAKOInTHlKN3S/tg+w0ayzVY+keXAemshOw0UWST0kZFUpON00k
   RbM599I9Kbkm4EYiKrum4RlT8id6SyFQjkoO8d3IOiMqnm6bGv7AeOFqU
   2Bah7WRBOtlYOiqaXYP4jsoXmeI80TAYyqa9u2UsSnZ5UaUDMtZFWeoPV
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="460296253"
X-IronPort-AV: E=Sophos;i="6.04,250,1695711600"; 
   d="scan'208";a="460296253"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 13:44:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="914575946"
X-IronPort-AV: E=Sophos;i="6.04,250,1695711600"; 
   d="scan'208";a="914575946"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 04 Dec 2023 13:44:31 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rAGjs-00086b-2U;
        Mon, 04 Dec 2023 21:44:28 +0000
Date:   Tue, 5 Dec 2023 05:44:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: io_uring/poll.c:480:43: sparse: sparse: incorrect type in
 initializer (different base types)
Message-ID: <202312050538.PfWFol7m-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   33cc938e65a98f1d29d0a18403dbbee050dcad9a
commit: b9ba8a4463cd78d0aee520c4bf2569820ac29929 io_uring: add support for level triggered poll
date:   1 year, 4 months ago
config: x86_64-alldefconfig (https://download.01.org/0day-ci/archive/20231205/202312050538.PfWFol7m-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231205/202312050538.PfWFol7m-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312050538.PfWFol7m-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   io_uring/poll.c:165:38: sparse: sparse: incorrect type in assignment (different base types) @@     expected signed int [usertype] res @@     got restricted __poll_t @@
   io_uring/poll.c:165:38: sparse:     expected signed int [usertype] res
   io_uring/poll.c:165:38: sparse:     got restricted __poll_t
   io_uring/poll.c:176:56: sparse: sparse: restricted __poll_t degrades to integer
   io_uring/poll.c:175:66: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __poll_t [usertype] val @@     got unsigned int @@
   io_uring/poll.c:175:66: sparse:     expected restricted __poll_t [usertype] val
   io_uring/poll.c:175:66: sparse:     got unsigned int
   io_uring/poll.c:175:52: sparse: sparse: incorrect type in initializer (different base types) @@     expected restricted __poll_t [usertype] mask @@     got unsigned short @@
   io_uring/poll.c:175:52: sparse:     expected restricted __poll_t [usertype] mask
   io_uring/poll.c:175:52: sparse:     got unsigned short
   io_uring/poll.c:181:50: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected signed int [usertype] res @@     got restricted __poll_t [usertype] mask @@
   io_uring/poll.c:181:50: sparse:     expected signed int [usertype] res
   io_uring/poll.c:181:50: sparse:     got restricted __poll_t [usertype] mask
   io_uring/poll.c:216:63: sparse: sparse: restricted __poll_t degrades to integer
   io_uring/poll.c:216:57: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __poll_t [usertype] val @@     got unsigned int @@
   io_uring/poll.c:216:57: sparse:     expected restricted __poll_t [usertype] val
   io_uring/poll.c:216:57: sparse:     got unsigned int
   io_uring/poll.c:334:40: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected int mask @@     got restricted __poll_t [usertype] mask @@
   io_uring/poll.c:334:40: sparse:     expected int mask
   io_uring/poll.c:334:40: sparse:     got restricted __poll_t [usertype] mask
   io_uring/poll.c:430:24: sparse: sparse: incorrect type in return expression (different base types) @@     expected int @@     got restricted __poll_t [assigned] [usertype] mask @@
   io_uring/poll.c:430:24: sparse:     expected int
   io_uring/poll.c:430:24: sparse:     got restricted __poll_t [assigned] [usertype] mask
   io_uring/poll.c:451:40: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected int mask @@     got restricted __poll_t [assigned] [usertype] mask @@
   io_uring/poll.c:451:40: sparse:     expected int mask
   io_uring/poll.c:451:40: sparse:     got restricted __poll_t [assigned] [usertype] mask
   io_uring/poll.c:480:45: sparse: sparse: restricted __poll_t degrades to integer
>> io_uring/poll.c:480:43: sparse: sparse: incorrect type in initializer (different base types) @@     expected restricted __poll_t [usertype] mask @@     got unsigned int @@
   io_uring/poll.c:480:43: sparse:     expected restricted __poll_t [usertype] mask
   io_uring/poll.c:480:43: sparse:     got unsigned int
   io_uring/poll.c:528:33: sparse: sparse: incorrect type in argument 5 (different base types) @@     expected int mask @@     got restricted __poll_t [assigned] [usertype] mask @@
   io_uring/poll.c:528:33: sparse:     expected int mask
   io_uring/poll.c:528:33: sparse:     got restricted __poll_t [assigned] [usertype] mask
   io_uring/poll.c:528:50: sparse: sparse: incorrect type in argument 6 (different base types) @@     expected int events @@     got restricted __poll_t [usertype] events @@
   io_uring/poll.c:528:50: sparse:     expected int events
   io_uring/poll.c:528:50: sparse:     got restricted __poll_t [usertype] events
   io_uring/poll.c:642:24: sparse: sparse: invalid assignment: |=
   io_uring/poll.c:642:24: sparse:    left side has type unsigned int
   io_uring/poll.c:642:24: sparse:    right side has type restricted __poll_t
   io_uring/poll.c:644:24: sparse: sparse: invalid assignment: |=
   io_uring/poll.c:644:24: sparse:    left side has type unsigned int
   io_uring/poll.c:644:24: sparse:    right side has type restricted __poll_t
   io_uring/poll.c:646:55: sparse: sparse: restricted __poll_t degrades to integer
   io_uring/poll.c:645:29: sparse: sparse: restricted __poll_t degrades to integer
   io_uring/poll.c:645:38: sparse: sparse: incorrect type in return expression (different base types) @@     expected restricted __poll_t @@     got unsigned int @@
   io_uring/poll.c:645:38: sparse:     expected restricted __poll_t
   io_uring/poll.c:645:38: sparse:     got unsigned int
   io_uring/poll.c:741:38: sparse: sparse: invalid assignment: &=
   io_uring/poll.c:741:38: sparse:    left side has type restricted __poll_t
   io_uring/poll.c:741:38: sparse:    right side has type int
   io_uring/poll.c:742:52: sparse: sparse: restricted __poll_t degrades to integer
   io_uring/poll.c:742:38: sparse: sparse: invalid assignment: |=
   io_uring/poll.c:742:38: sparse:    left side has type restricted __poll_t
   io_uring/poll.c:742:38: sparse:    right side has type unsigned int
   io_uring/poll.c: note: in included file:
   io_uring/io_uring_types.h:92:37: sparse: sparse: array of flexible structures

vim +480 io_uring/poll.c

   473	
   474	int io_arm_poll_handler(struct io_kiocb *req, unsigned issue_flags)
   475	{
   476		const struct io_op_def *def = &io_op_defs[req->opcode];
   477		struct io_ring_ctx *ctx = req->ctx;
   478		struct async_poll *apoll;
   479		struct io_poll_table ipt;
 > 480		__poll_t mask = POLLPRI | POLLERR | EPOLLET;
   481		int ret;
   482	
   483		if (!def->pollin && !def->pollout)
   484			return IO_APOLL_ABORTED;
   485		if (!file_can_poll(req->file))
   486			return IO_APOLL_ABORTED;
   487		if ((req->flags & (REQ_F_POLLED|REQ_F_PARTIAL_IO)) == REQ_F_POLLED)
   488			return IO_APOLL_ABORTED;
   489		if (!(req->flags & REQ_F_APOLL_MULTISHOT))
   490			mask |= EPOLLONESHOT;
   491	
   492		if (def->pollin) {
   493			mask |= EPOLLIN | EPOLLRDNORM;
   494	
   495			/* If reading from MSG_ERRQUEUE using recvmsg, ignore POLLIN */
   496			if (req->flags & REQ_F_CLEAR_POLLIN)
   497				mask &= ~EPOLLIN;
   498		} else {
   499			mask |= EPOLLOUT | EPOLLWRNORM;
   500		}
   501		if (def->poll_exclusive)
   502			mask |= EPOLLEXCLUSIVE;
   503		if (req->flags & REQ_F_POLLED) {
   504			apoll = req->apoll;
   505			kfree(apoll->double_poll);
   506		} else if (!(issue_flags & IO_URING_F_UNLOCKED) &&
   507			   !list_empty(&ctx->apoll_cache)) {
   508			apoll = list_first_entry(&ctx->apoll_cache, struct async_poll,
   509							poll.wait.entry);
   510			list_del_init(&apoll->poll.wait.entry);
   511		} else {
   512			apoll = kmalloc(sizeof(*apoll), GFP_ATOMIC);
   513			if (unlikely(!apoll))
   514				return IO_APOLL_ABORTED;
   515		}
   516		apoll->double_poll = NULL;
   517		req->apoll = apoll;
   518		req->flags |= REQ_F_POLLED;
   519		ipt.pt._qproc = io_async_queue_proc;
   520	
   521		io_kbuf_recycle(req, issue_flags);
   522	
   523		ret = __io_arm_poll_handler(req, &apoll->poll, &ipt, mask);
   524		if (ret || ipt.error)
   525			return ret ? IO_APOLL_READY : IO_APOLL_ABORTED;
   526	
   527		trace_io_uring_poll_arm(ctx, req, req->cqe.user_data, req->opcode,
   528					mask, apoll->poll.events);
   529		return IO_APOLL_OK;
   530	}
   531	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
