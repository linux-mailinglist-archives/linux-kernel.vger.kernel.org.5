Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8852280441D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 02:35:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346225AbjLEBex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 20:34:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjLEBev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 20:34:51 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F6F3FA
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 17:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701740097; x=1733276097;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=5xHDtRaLXGMH32pLIJvcltssPM2kAteoj8Xq4fGUkV0=;
  b=h+81Ow7mhwI3WzIGrhUJ1gA7SzbGBbzTR+dr94svh4tV4O9y7aDnYPDN
   MuVAeYdie6Ddo9/484TgfTzi8CADvCtCqY5IzFVP2zfzFprHBXdwXpmaD
   ONRD+WwZrBCCGt9tWF3DVWadG1HcBBbqqSQJ9iSL1Q2Y+HgGgIqM06IOR
   vNXTaLvBiJlukcu4/PjRIgsrQllG7HygYpB5u3Pj4UEQDIQ6aXx0T1HLf
   veYj+A+x3huRyvgfE4u1fkTmwS9qU6YxMWN6bcyXjtC2pt2V/bVYn7TK5
   R1UHRsyquZqg7xu8d8m+KcpR/mSVWeJM0Jaeczl1mf7LBRwTezuEL4xuW
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="396622399"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="396622399"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 17:34:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="944077451"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="944077451"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 04 Dec 2023 17:34:53 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rAKKn-0008Gm-15;
        Tue, 05 Dec 2023 01:34:50 +0000
Date:   Tue, 5 Dec 2023 09:34:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: io_uring/poll.c:819:40: sparse: sparse: incorrect type in argument 2
 (different base types)
Message-ID: <202312050925.mQD45OR7-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
head:   bee0e7762ad2c6025b9f5245c040fcc36ef2bde8
commit: 063a007996bf725ba4c7d8741701670be9858300 io_uring: change arm poll return values
date:   1 year, 4 months ago
config: x86_64-alldefconfig (https://download.01.org/0day-ci/archive/20231205/202312050925.mQD45OR7-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231205/202312050925.mQD45OR7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312050925.mQD45OR7-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   io_uring/poll.c: note: in included file (through io_uring/io_uring.h):
   io_uring/slist.h:138:29: sparse: sparse: no newline at end of file
   io_uring/poll.c:222:38: sparse: sparse: incorrect type in assignment (different base types) @@     expected signed int [usertype] res @@     got restricted __poll_t @@
   io_uring/poll.c:222:38: sparse:     expected signed int [usertype] res
   io_uring/poll.c:222:38: sparse:     got restricted __poll_t
   io_uring/poll.c:233:56: sparse: sparse: restricted __poll_t degrades to integer
   io_uring/poll.c:232:66: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __poll_t [usertype] val @@     got unsigned int @@
   io_uring/poll.c:232:66: sparse:     expected restricted __poll_t [usertype] val
   io_uring/poll.c:232:66: sparse:     got unsigned int
   io_uring/poll.c:232:52: sparse: sparse: incorrect type in initializer (different base types) @@     expected restricted __poll_t [usertype] mask @@     got unsigned short @@
   io_uring/poll.c:232:52: sparse:     expected restricted __poll_t [usertype] mask
   io_uring/poll.c:232:52: sparse:     got unsigned short
   io_uring/poll.c:236:46: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected signed int [usertype] res @@     got restricted __poll_t [usertype] mask @@
   io_uring/poll.c:236:46: sparse:     expected signed int [usertype] res
   io_uring/poll.c:236:46: sparse:     got restricted __poll_t [usertype] mask
   io_uring/poll.c:264:63: sparse: sparse: restricted __poll_t degrades to integer
   io_uring/poll.c:264:57: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __poll_t [usertype] val @@     got unsigned int @@
   io_uring/poll.c:264:57: sparse:     expected restricted __poll_t [usertype] val
   io_uring/poll.c:264:57: sparse:     got unsigned int
   io_uring/poll.c:372:40: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected int mask @@     got restricted __poll_t [usertype] mask @@
   io_uring/poll.c:372:40: sparse:     expected int mask
   io_uring/poll.c:372:40: sparse:     got restricted __poll_t [usertype] mask
   io_uring/poll.c:491:40: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected int mask @@     got restricted __poll_t [assigned] [usertype] mask @@
   io_uring/poll.c:491:40: sparse:     expected int mask
   io_uring/poll.c:491:40: sparse:     got restricted __poll_t [assigned] [usertype] mask
   io_uring/poll.c:543:45: sparse: sparse: restricted __poll_t degrades to integer
   io_uring/poll.c:543:43: sparse: sparse: incorrect type in initializer (different base types) @@     expected restricted __poll_t [usertype] mask @@     got unsigned int @@
   io_uring/poll.c:543:43: sparse:     expected restricted __poll_t [usertype] mask
   io_uring/poll.c:543:43: sparse:     got unsigned int
   io_uring/poll.c:588:38: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected int mask @@     got restricted __poll_t [assigned] [usertype] mask @@
   io_uring/poll.c:588:38: sparse:     expected int mask
   io_uring/poll.c:588:38: sparse:     got restricted __poll_t [assigned] [usertype] mask
   io_uring/poll.c:588:55: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected int events @@     got restricted __poll_t [usertype] events @@
   io_uring/poll.c:588:55: sparse:     expected int events
   io_uring/poll.c:588:55: sparse:     got restricted __poll_t [usertype] events
   io_uring/poll.c:745:24: sparse: sparse: invalid assignment: |=
   io_uring/poll.c:745:24: sparse:    left side has type unsigned int
   io_uring/poll.c:745:24: sparse:    right side has type restricted __poll_t
   io_uring/poll.c:747:24: sparse: sparse: invalid assignment: |=
   io_uring/poll.c:747:24: sparse:    left side has type unsigned int
   io_uring/poll.c:747:24: sparse:    right side has type restricted __poll_t
   io_uring/poll.c:749:55: sparse: sparse: restricted __poll_t degrades to integer
   io_uring/poll.c:748:29: sparse: sparse: restricted __poll_t degrades to integer
   io_uring/poll.c:748:38: sparse: sparse: incorrect type in return expression (different base types) @@     expected restricted __poll_t @@     got unsigned int @@
   io_uring/poll.c:748:38: sparse:     expected restricted __poll_t
   io_uring/poll.c:748:38: sparse:     got unsigned int
>> io_uring/poll.c:819:40: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected signed int [usertype] res @@     got restricted __poll_t [addressable] [assigned] [usertype] result_mask @@
   io_uring/poll.c:819:40: sparse:     expected signed int [usertype] res
   io_uring/poll.c:819:40: sparse:     got restricted __poll_t [addressable] [assigned] [usertype] result_mask
   io_uring/poll.c:873:38: sparse: sparse: invalid assignment: &=
   io_uring/poll.c:873:38: sparse:    left side has type restricted __poll_t
   io_uring/poll.c:873:38: sparse:    right side has type int
   io_uring/poll.c:874:52: sparse: sparse: restricted __poll_t degrades to integer
   io_uring/poll.c:874:38: sparse: sparse: invalid assignment: |=
   io_uring/poll.c:874:38: sparse:    left side has type restricted __poll_t
   io_uring/poll.c:874:38: sparse:    right side has type unsigned int
   io_uring/poll.c:632:24: sparse: sparse: context imbalance in 'io_poll_find' - wrong count at exit
   io_uring/poll.c:661:24: sparse: sparse: context imbalance in 'io_poll_file_find' - wrong count at exit
   io_uring/poll.c:716:28: sparse: sparse: context imbalance in '__io_poll_cancel' - unexpected unlock
   io_uring/poll.c:843:28: sparse: sparse: context imbalance in 'io_poll_remove' - unexpected unlock

vim +819 io_uring/poll.c

   734	
   735	static __poll_t io_poll_parse_events(const struct io_uring_sqe *sqe,
   736					     unsigned int flags)
   737	{
   738		u32 events;
   739	
   740		events = READ_ONCE(sqe->poll32_events);
   741	#ifdef __BIG_ENDIAN
   742		events = swahw32(events);
   743	#endif
   744		if (!(flags & IORING_POLL_ADD_MULTI))
 > 745			events |= EPOLLONESHOT;
   746		if (!(flags & IORING_POLL_ADD_LEVEL))
   747			events |= EPOLLET;
   748		return demangle_poll(events) |
   749			(events & (EPOLLEXCLUSIVE|EPOLLONESHOT|EPOLLET));
   750	}
   751	
   752	int io_poll_remove_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
   753	{
   754		struct io_poll_update *upd = io_kiocb_to_cmd(req);
   755		u32 flags;
   756	
   757		if (sqe->buf_index || sqe->splice_fd_in)
   758			return -EINVAL;
   759		flags = READ_ONCE(sqe->len);
   760		if (flags & ~(IORING_POLL_UPDATE_EVENTS | IORING_POLL_UPDATE_USER_DATA |
   761			      IORING_POLL_ADD_MULTI))
   762			return -EINVAL;
   763		/* meaningless without update */
   764		if (flags == IORING_POLL_ADD_MULTI)
   765			return -EINVAL;
   766	
   767		upd->old_user_data = READ_ONCE(sqe->addr);
   768		upd->update_events = flags & IORING_POLL_UPDATE_EVENTS;
   769		upd->update_user_data = flags & IORING_POLL_UPDATE_USER_DATA;
   770	
   771		upd->new_user_data = READ_ONCE(sqe->off);
   772		if (!upd->update_user_data && upd->new_user_data)
   773			return -EINVAL;
   774		if (upd->update_events)
   775			upd->events = io_poll_parse_events(sqe, flags);
   776		else if (sqe->poll32_events)
   777			return -EINVAL;
   778	
   779		return 0;
   780	}
   781	
   782	int io_poll_add_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
   783	{
   784		struct io_poll *poll = io_kiocb_to_cmd(req);
   785		u32 flags;
   786	
   787		if (sqe->buf_index || sqe->off || sqe->addr)
   788			return -EINVAL;
   789		flags = READ_ONCE(sqe->len);
   790		if (flags & ~(IORING_POLL_ADD_MULTI|IORING_POLL_ADD_LEVEL))
   791			return -EINVAL;
   792		if ((flags & IORING_POLL_ADD_MULTI) && (req->flags & REQ_F_CQE_SKIP))
   793			return -EINVAL;
   794	
   795		poll->events = io_poll_parse_events(sqe, flags);
   796		return 0;
   797	}
   798	
   799	int io_poll_add(struct io_kiocb *req, unsigned int issue_flags)
   800	{
   801		struct io_poll *poll = io_kiocb_to_cmd(req);
   802		struct io_poll_table ipt;
   803		int ret;
   804	
   805		ipt.pt._qproc = io_poll_queue_proc;
   806	
   807		/*
   808		 * If sqpoll or single issuer, there is no contention for ->uring_lock
   809		 * and we'll end up holding it in tw handlers anyway.
   810		 */
   811		if (!(issue_flags & IO_URING_F_UNLOCKED) &&
   812		    (req->ctx->flags & (IORING_SETUP_SQPOLL | IORING_SETUP_SINGLE_ISSUER)))
   813			req->flags |= REQ_F_HASH_LOCKED;
   814		else
   815			req->flags &= ~REQ_F_HASH_LOCKED;
   816	
   817		ret = __io_arm_poll_handler(req, poll, &ipt, poll->events);
   818		if (ret) {
 > 819			io_req_set_res(req, ipt.result_mask, 0);
   820			return IOU_OK;
   821		}
   822		if (ipt.error) {
   823			req_set_fail(req);
   824			return ipt.error;
   825		}
   826	
   827		return IOU_ISSUE_SKIP_COMPLETE;
   828	}
   829	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
