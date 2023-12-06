Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3B3C806691
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 06:26:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376712AbjLFF0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 00:26:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376711AbjLFF0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 00:26:10 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 079321BC
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 21:26:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701840376; x=1733376376;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=a8oZJs17yR59p0N2qAEy0rE9ccbStnSHF4k0WSN3V0Q=;
  b=BL4XMcVmmLNsXQD1suU2ngMSL7iVnXn3dYHKc7R9GeWEoqgujd+CwRxo
   l/KHTWHn+ibnMb+hrnVxUnO9BP/zS5JyAvXJGzG+H05Fsw/vT7mB4HTeK
   GWZ4w/8FjXa0y6hgSRJ8s5AVkUK7lfz1p7MX4R2LUu9TdVHONMLs8Z1kZ
   g1ceFoC39KzWR/1aKh9e+CjAi8QFVf6sTIlHrJBppC5BT4owTDXdJhKk9
   jsAfQqpYgBlEfpQq8+9ma6Pj/BXLTPFwc+Tt15ApqBV9RfdxSrNtvt0KW
   GDGn2JdxORyKa+XhEpsRZ1p2WirqV7peSWhr4nyvyT3iv0nMuOMOTZngp
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="392877451"
X-IronPort-AV: E=Sophos;i="6.04,254,1695711600"; 
   d="scan'208";a="392877451"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 21:25:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="841706551"
X-IronPort-AV: E=Sophos;i="6.04,254,1695711600"; 
   d="scan'208";a="841706551"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 05 Dec 2023 21:25:57 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rAkPy-000AK2-2z;
        Wed, 06 Dec 2023 05:25:54 +0000
Date:   Wed, 6 Dec 2023 13:25:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: io_uring/poll.c:480:43: sparse: sparse: incorrect type in
 initializer (different base types)
Message-ID: <202312061345.ae8SDp8J-lkp@intel.com>
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
commit: b9ba8a4463cd78d0aee520c4bf2569820ac29929 io_uring: add support for level triggered poll
date:   1 year, 4 months ago
config: x86_64-alldefconfig (https://download.01.org/0day-ci/archive/20231206/202312061345.ae8SDp8J-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231206/202312061345.ae8SDp8J-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312061345.ae8SDp8J-lkp@intel.com/

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
