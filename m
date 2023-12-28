Return-Path: <linux-kernel+bounces-12424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5668681F4A6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 05:58:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7B44283406
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 04:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D38121FDE;
	Thu, 28 Dec 2023 04:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="By4PuHuw"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7300D15C3
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 04:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703739507; x=1735275507;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=6hsmZetemzPbvg2Lz4S0HCjMQ16nHWdvthEQKX9XUMI=;
  b=By4PuHuw8XdxsLpLJ8ZoV4Qy61rA0tjc7eihWvpCZhUiZ5TOcG3NPcEq
   TNE3Dy6ybaRwMv7CKj3er3sPZpx9RkBs4PXZKN1HuGUuFrbuqnpa/vI/H
   FmpEPJc/4InZnYDEs0r7XEOALFZPes9gfsFUd6YyE2F3lm7oi7zO7RSX/
   u5L63OrU4Ei10lS0WAkMZoPLvsofqivJhmOmlB4tbqkQF+7Dpnom6s4Z8
   LveshlswxYF6YzIrDxPBCs7YZ6tApB9cecL1HsyUIu7HaY/QS81fMCqFT
   DM0rKdjEw7FT1OJbLDQmvaIUPoZFAR/gnjSq1BxBhVLKVB71RTzILLXE1
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="462928252"
X-IronPort-AV: E=Sophos;i="6.04,311,1695711600"; 
   d="scan'208";a="462928252"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 20:58:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="807332879"
X-IronPort-AV: E=Sophos;i="6.04,311,1695711600"; 
   d="scan'208";a="807332879"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 27 Dec 2023 20:58:25 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rIiTO-000G5p-2Z;
	Thu, 28 Dec 2023 04:58:22 +0000
Date: Thu, 28 Dec 2023 12:57:58 +0800
From: kernel test robot <lkp@intel.com>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: io_uring/poll.c:819:40: sparse: sparse: incorrect type in argument 2
 (different base types)
Message-ID: <202312281221.Xmo2DIaO-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f5837722ffecbbedf1b1dbab072a063565f0dad1
commit: 063a007996bf725ba4c7d8741701670be9858300 io_uring: change arm poll return values
date:   1 year, 5 months ago
config: x86_64-alldefconfig (https://download.01.org/0day-ci/archive/20231228/202312281221.Xmo2DIaO-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231228/202312281221.Xmo2DIaO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312281221.Xmo2DIaO-lkp@intel.com/

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

