Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4142805351
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 12:47:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442133AbjLELre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 06:47:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345333AbjLELrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 06:47:32 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E59EEC9
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 03:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701776857; x=1733312857;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=EZESWglnD6hHxxirrP3dgQu2i8GEJVaTVw6r1o8riU4=;
  b=BdsrVWDOnUbjyVTKC8MGtIXuFx/0GtD5x9Zx3sqhBPJLcvjD/uAeeZtJ
   7M2G/d4Q6/za7lQONxarhJPCW9QtcPExsOY9TI8IjU0/dlPFaD5E3bTvV
   Xqrxf6Anq4hyii5Ia0nEdUZ2vxgsBr2aO2cSosmhG6Ag1E1gHPyDCAbEZ
   w7AJGk+gOwzRBG3R6QmMHnANKBOAIz2qLrz877/PKF+A+Vi+pxU1lY0Sw
   o4HPum9F3f+n4uP7qFYgBU7X5VeiaujhQDfK8xEzDHRu5P1aL/42SiKvL
   rMX6hWgWsR58vsrwgNb12pbsu37lP4s0je7RcecNNjwEqwR5GeBGUqNs7
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="384279806"
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; 
   d="scan'208";a="384279806"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 03:47:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="1018198399"
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; 
   d="scan'208";a="1018198399"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 05 Dec 2023 03:47:35 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rATtl-0008ul-0o;
        Tue, 05 Dec 2023 11:47:33 +0000
Date:   Tue, 5 Dec 2023 19:46:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: io_uring/poll.c:164:38: sparse: sparse: incorrect type in assignment
 (different base types)
Message-ID: <202312051944.ErjU79Lr-lkp@intel.com>
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
commit: 329061d3e2f9a0082a097e9558bd5497098586c6 io_uring: move poll handling into its own file
date:   1 year, 4 months ago
config: x86_64-alldefconfig (https://download.01.org/0day-ci/archive/20231205/202312051944.ErjU79Lr-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231205/202312051944.ErjU79Lr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312051944.ErjU79Lr-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> io_uring/poll.c:164:38: sparse: sparse: incorrect type in assignment (different base types) @@     expected signed int [usertype] res @@     got restricted __poll_t @@
   io_uring/poll.c:164:38: sparse:     expected signed int [usertype] res
   io_uring/poll.c:164:38: sparse:     got restricted __poll_t
>> io_uring/poll.c:175:56: sparse: sparse: restricted __poll_t degrades to integer
>> io_uring/poll.c:174:66: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __poll_t [usertype] val @@     got unsigned int @@
   io_uring/poll.c:174:66: sparse:     expected restricted __poll_t [usertype] val
   io_uring/poll.c:174:66: sparse:     got unsigned int
>> io_uring/poll.c:174:52: sparse: sparse: incorrect type in initializer (different base types) @@     expected restricted __poll_t [usertype] mask @@     got unsigned short @@
   io_uring/poll.c:174:52: sparse:     expected restricted __poll_t [usertype] mask
   io_uring/poll.c:174:52: sparse:     got unsigned short
>> io_uring/poll.c:180:50: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected signed int [usertype] res @@     got restricted __poll_t [usertype] mask @@
   io_uring/poll.c:180:50: sparse:     expected signed int [usertype] res
   io_uring/poll.c:180:50: sparse:     got restricted __poll_t [usertype] mask
   io_uring/poll.c:215:63: sparse: sparse: restricted __poll_t degrades to integer
   io_uring/poll.c:215:57: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __poll_t [usertype] val @@     got unsigned int @@
   io_uring/poll.c:215:57: sparse:     expected restricted __poll_t [usertype] val
   io_uring/poll.c:215:57: sparse:     got unsigned int
>> io_uring/poll.c:333:40: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected int mask @@     got restricted __poll_t [usertype] mask @@
   io_uring/poll.c:333:40: sparse:     expected int mask
   io_uring/poll.c:333:40: sparse:     got restricted __poll_t [usertype] mask
   io_uring/poll.c:428:24: sparse: sparse: incorrect type in return expression (different base types) @@     expected int @@     got restricted __poll_t [assigned] [usertype] mask @@
   io_uring/poll.c:428:24: sparse:     expected int
   io_uring/poll.c:428:24: sparse:     got restricted __poll_t [assigned] [usertype] mask
>> io_uring/poll.c:448:40: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected int mask @@     got restricted __poll_t [assigned] [usertype] mask @@
   io_uring/poll.c:448:40: sparse:     expected int mask
   io_uring/poll.c:448:40: sparse:     got restricted __poll_t [assigned] [usertype] mask
   io_uring/poll.c:477:33: sparse: sparse: incorrect type in initializer (different base types) @@     expected restricted __poll_t [usertype] mask @@     got int @@
   io_uring/poll.c:477:33: sparse:     expected restricted __poll_t [usertype] mask
   io_uring/poll.c:477:33: sparse:     got int
   io_uring/poll.c:525:33: sparse: sparse: incorrect type in argument 5 (different base types) @@     expected int mask @@     got restricted __poll_t [assigned] [usertype] mask @@
   io_uring/poll.c:525:33: sparse:     expected int mask
   io_uring/poll.c:525:33: sparse:     got restricted __poll_t [assigned] [usertype] mask
>> io_uring/poll.c:525:50: sparse: sparse: incorrect type in argument 6 (different base types) @@     expected int events @@     got restricted __poll_t [usertype] events @@
   io_uring/poll.c:525:50: sparse:     expected int events
   io_uring/poll.c:525:50: sparse:     got restricted __poll_t [usertype] events
>> io_uring/poll.c:639:24: sparse: sparse: invalid assignment: |=
>> io_uring/poll.c:639:24: sparse:    left side has type unsigned int
>> io_uring/poll.c:639:24: sparse:    right side has type restricted __poll_t
   io_uring/poll.c:640:65: sparse: sparse: restricted __poll_t degrades to integer
   io_uring/poll.c:640:29: sparse: sparse: restricted __poll_t degrades to integer
>> io_uring/poll.c:640:38: sparse: sparse: incorrect type in return expression (different base types) @@     expected restricted __poll_t @@     got unsigned int @@
   io_uring/poll.c:640:38: sparse:     expected restricted __poll_t
   io_uring/poll.c:640:38: sparse:     got unsigned int
   io_uring/poll.c:735:38: sparse: sparse: invalid assignment: &=
>> io_uring/poll.c:735:38: sparse:    left side has type restricted __poll_t
>> io_uring/poll.c:735:38: sparse:    right side has type int
   io_uring/poll.c:736:52: sparse: sparse: restricted __poll_t degrades to integer
   io_uring/poll.c:736:38: sparse: sparse: invalid assignment: |=
   io_uring/poll.c:736:38: sparse:    left side has type restricted __poll_t
>> io_uring/poll.c:736:38: sparse:    right side has type unsigned int
   io_uring/poll.c: note: in included file:
   io_uring/io_uring_types.h:90:37: sparse: sparse: array of flexible structures

vim +164 io_uring/poll.c

   135	
   136	/*
   137	 * All poll tw should go through this. Checks for poll events, manages
   138	 * references, does rewait, etc.
   139	 *
   140	 * Returns a negative error on failure. >0 when no action require, which is
   141	 * either spurious wakeup or multishot CQE is served. 0 when it's done with
   142	 * the request, then the mask is stored in req->cqe.res.
   143	 */
   144	static int io_poll_check_events(struct io_kiocb *req, bool *locked)
   145	{
   146		struct io_ring_ctx *ctx = req->ctx;
   147		int v, ret;
   148	
   149		/* req->task == current here, checking PF_EXITING is safe */
   150		if (unlikely(req->task->flags & PF_EXITING))
   151			return -ECANCELED;
   152	
   153		do {
   154			v = atomic_read(&req->poll_refs);
   155	
   156			/* tw handler should be the owner, and so have some references */
   157			if (WARN_ON_ONCE(!(v & IO_POLL_REF_MASK)))
   158				return 0;
   159			if (v & IO_POLL_CANCEL_FLAG)
   160				return -ECANCELED;
   161	
   162			if (!req->cqe.res) {
   163				struct poll_table_struct pt = { ._key = req->apoll_events };
 > 164				req->cqe.res = vfs_poll(req->file, &pt) & req->apoll_events;
   165			}
   166	
   167			if ((unlikely(!req->cqe.res)))
   168				continue;
   169			if (req->apoll_events & EPOLLONESHOT)
   170				return 0;
   171	
   172			/* multishot, just fill a CQE and proceed */
   173			if (!(req->flags & REQ_F_APOLL_MULTISHOT)) {
 > 174				__poll_t mask = mangle_poll(req->cqe.res &
 > 175							    req->apoll_events);
   176				bool filled;
   177	
   178				spin_lock(&ctx->completion_lock);
   179				filled = io_fill_cqe_aux(ctx, req->cqe.user_data,
 > 180							 mask, IORING_CQE_F_MORE);
   181				io_commit_cqring(ctx);
   182				spin_unlock(&ctx->completion_lock);
   183				if (filled) {
   184					io_cqring_ev_posted(ctx);
   185					continue;
   186				}
   187				return -ECANCELED;
   188			}
   189	
   190			ret = io_poll_issue(req, locked);
   191			if (ret)
   192				return ret;
   193	
   194			/*
   195			 * Release all references, retry if someone tried to restart
   196			 * task_work while we were executing it.
   197			 */
   198		} while (atomic_sub_return(v & IO_POLL_REF_MASK, &req->poll_refs));
   199	
   200		return 1;
   201	}
   202	
   203	static void io_poll_task_func(struct io_kiocb *req, bool *locked)
   204	{
   205		struct io_ring_ctx *ctx = req->ctx;
   206		int ret;
   207	
   208		ret = io_poll_check_events(req, locked);
   209		if (ret > 0)
   210			return;
   211	
   212		if (!ret) {
   213			struct io_poll *poll = io_kiocb_to_cmd(req);
   214	
   215			req->cqe.res = mangle_poll(req->cqe.res & poll->events);
   216		} else {
   217			req->cqe.res = ret;
   218			req_set_fail(req);
   219		}
   220	
   221		io_poll_remove_entries(req);
   222		spin_lock(&ctx->completion_lock);
   223		hash_del(&req->hash_node);
   224		req->cqe.flags = 0;
   225		__io_req_complete_post(req);
   226		io_commit_cqring(ctx);
   227		spin_unlock(&ctx->completion_lock);
   228		io_cqring_ev_posted(ctx);
   229	}
   230	
   231	static void io_apoll_task_func(struct io_kiocb *req, bool *locked)
   232	{
   233		struct io_ring_ctx *ctx = req->ctx;
   234		int ret;
   235	
   236		ret = io_poll_check_events(req, locked);
   237		if (ret > 0)
   238			return;
   239	
   240		io_poll_remove_entries(req);
   241		spin_lock(&ctx->completion_lock);
   242		hash_del(&req->hash_node);
   243		spin_unlock(&ctx->completion_lock);
   244	
   245		if (!ret)
   246			io_req_task_submit(req, locked);
   247		else
   248			io_req_complete_failed(req, ret);
   249	}
   250	
   251	static void __io_poll_execute(struct io_kiocb *req, int mask,
   252				      __poll_t __maybe_unused events)
   253	{
   254		io_req_set_res(req, mask, 0);
   255		/*
   256		 * This is useful for poll that is armed on behalf of another
   257		 * request, and where the wakeup path could be on a different
   258		 * CPU. We want to avoid pulling in req->apoll->events for that
   259		 * case.
   260		 */
   261		if (req->opcode == IORING_OP_POLL_ADD)
   262			req->io_task_work.func = io_poll_task_func;
   263		else
   264			req->io_task_work.func = io_apoll_task_func;
   265	
   266		trace_io_uring_task_add(req->ctx, req, req->cqe.user_data, req->opcode, mask);
   267		io_req_task_work_add(req);
   268	}
   269	
   270	static inline void io_poll_execute(struct io_kiocb *req, int res,
   271			__poll_t events)
   272	{
   273		if (io_poll_get_ownership(req))
   274			__io_poll_execute(req, res, events);
   275	}
   276	
   277	static void io_poll_cancel_req(struct io_kiocb *req)
   278	{
   279		io_poll_mark_cancelled(req);
   280		/* kick tw, which should complete the request */
   281		io_poll_execute(req, 0, 0);
   282	}
   283	
   284	#define wqe_to_req(wait)	((void *)((unsigned long) (wait)->private & ~1))
   285	#define wqe_is_double(wait)	((unsigned long) (wait)->private & 1)
   286	#define IO_ASYNC_POLL_COMMON	(EPOLLONESHOT | EPOLLPRI)
   287	
   288	static int io_poll_wake(struct wait_queue_entry *wait, unsigned mode, int sync,
   289				void *key)
   290	{
   291		struct io_kiocb *req = wqe_to_req(wait);
   292		struct io_poll *poll = container_of(wait, struct io_poll, wait);
   293		__poll_t mask = key_to_poll(key);
   294	
   295		if (unlikely(mask & POLLFREE)) {
   296			io_poll_mark_cancelled(req);
   297			/* we have to kick tw in case it's not already */
   298			io_poll_execute(req, 0, poll->events);
   299	
   300			/*
   301			 * If the waitqueue is being freed early but someone is already
   302			 * holds ownership over it, we have to tear down the request as
   303			 * best we can. That means immediately removing the request from
   304			 * its waitqueue and preventing all further accesses to the
   305			 * waitqueue via the request.
   306			 */
   307			list_del_init(&poll->wait.entry);
   308	
   309			/*
   310			 * Careful: this *must* be the last step, since as soon
   311			 * as req->head is NULL'ed out, the request can be
   312			 * completed and freed, since aio_poll_complete_work()
   313			 * will no longer need to take the waitqueue lock.
   314			 */
   315			smp_store_release(&poll->head, NULL);
   316			return 1;
   317		}
   318	
   319		/* for instances that support it check for an event match first */
   320		if (mask && !(mask & (poll->events & ~IO_ASYNC_POLL_COMMON)))
   321			return 0;
   322	
   323		if (io_poll_get_ownership(req)) {
   324			/* optional, saves extra locking for removal in tw handler */
   325			if (mask && poll->events & EPOLLONESHOT) {
   326				list_del_init(&poll->wait.entry);
   327				poll->head = NULL;
   328				if (wqe_is_double(wait))
   329					req->flags &= ~REQ_F_DOUBLE_POLL;
   330				else
   331					req->flags &= ~REQ_F_SINGLE_POLL;
   332			}
 > 333			__io_poll_execute(req, mask, poll->events);
   334		}
   335		return 1;
   336	}
   337	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
