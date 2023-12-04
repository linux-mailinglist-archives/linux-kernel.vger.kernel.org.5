Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7980F804115
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 22:44:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234400AbjLDVoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 16:44:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234225AbjLDVo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 16:44:28 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29299BB
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 13:44:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701726273; x=1733262273;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=fbufUyl04oUebM6FbmZxCeKqoWYqrUHsWmhLIUrPjVk=;
  b=ZfPEyM4/XMu/2dblBjwBpqpEgEpsKraQYX8fprCLMb5EKrdbOvoTrswn
   MBZr+MiQmZlokY6dm9vqzBW3DtRSof02M1lpYrI0JqQhNtWWhFX5P55b9
   OHLPoyh1jmIgeixfdg3I5JizqqXuGfCDIi51zf1y7V/ftSN4PP3zXFi2X
   +EMVKFTiz36Ek+k/pzJ+q72YETQrXe3B5CBtjJ4lnpDMcaDmsQknBPrP0
   eGu2OslqBNxaN26yab3eb76tCsxbvOakiBIKnNGkkyGs7tyO3VMqKSGdv
   n+Ky+PJuuZcAWLOXzLF+AWGiwsCNUORxTum3nIZjH+eOJj1TorlocsGpD
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="460296249"
X-IronPort-AV: E=Sophos;i="6.04,250,1695711600"; 
   d="scan'208";a="460296249"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 13:44:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="914575942"
X-IronPort-AV: E=Sophos;i="6.04,250,1695711600"; 
   d="scan'208";a="914575942"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 04 Dec 2023 13:44:30 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rAGjs-00086Y-1s;
        Mon, 04 Dec 2023 21:44:28 +0000
Date:   Tue, 5 Dec 2023 05:44:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: io_uring/poll.c:480:43: sparse: sparse: incorrect type in
 initializer (different base types)
Message-ID: <202312050531.k063Lttm-lkp@intel.com>
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
config: x86_64-alldefconfig (https://download.01.org/0day-ci/archive/20231205/202312050531.k063Lttm-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231205/202312050531.k063Lttm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312050531.k063Lttm-lkp@intel.com/

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

   288	
   289	static int io_poll_wake(struct wait_queue_entry *wait, unsigned mode, int sync,
   290				void *key)
   291	{
   292		struct io_kiocb *req = wqe_to_req(wait);
   293		struct io_poll *poll = container_of(wait, struct io_poll, wait);
   294		__poll_t mask = key_to_poll(key);
   295	
   296		if (unlikely(mask & POLLFREE)) {
   297			io_poll_mark_cancelled(req);
   298			/* we have to kick tw in case it's not already */
   299			io_poll_execute(req, 0, poll->events);
   300	
   301			/*
   302			 * If the waitqueue is being freed early but someone is already
   303			 * holds ownership over it, we have to tear down the request as
   304			 * best we can. That means immediately removing the request from
   305			 * its waitqueue and preventing all further accesses to the
   306			 * waitqueue via the request.
   307			 */
   308			list_del_init(&poll->wait.entry);
   309	
   310			/*
   311			 * Careful: this *must* be the last step, since as soon
   312			 * as req->head is NULL'ed out, the request can be
   313			 * completed and freed, since aio_poll_complete_work()
   314			 * will no longer need to take the waitqueue lock.
   315			 */
   316			smp_store_release(&poll->head, NULL);
   317			return 1;
   318		}
   319	
   320		/* for instances that support it check for an event match first */
   321		if (mask && !(mask & (poll->events & ~IO_ASYNC_POLL_COMMON)))
   322			return 0;
   323	
   324		if (io_poll_get_ownership(req)) {
   325			/* optional, saves extra locking for removal in tw handler */
   326			if (mask && poll->events & EPOLLONESHOT) {
   327				list_del_init(&poll->wait.entry);
   328				poll->head = NULL;
   329				if (wqe_is_double(wait))
   330					req->flags &= ~REQ_F_DOUBLE_POLL;
   331				else
   332					req->flags &= ~REQ_F_SINGLE_POLL;
   333			}
 > 334			__io_poll_execute(req, mask, poll->events);
   335		}
   336		return 1;
   337	}
   338	
   339	static void __io_queue_proc(struct io_poll *poll, struct io_poll_table *pt,
   340				    struct wait_queue_head *head,
   341				    struct io_poll **poll_ptr)
   342	{
   343		struct io_kiocb *req = pt->req;
   344		unsigned long wqe_private = (unsigned long) req;
   345	
   346		/*
   347		 * The file being polled uses multiple waitqueues for poll handling
   348		 * (e.g. one for read, one for write). Setup a separate io_poll
   349		 * if this happens.
   350		 */
   351		if (unlikely(pt->nr_entries)) {
   352			struct io_poll *first = poll;
   353	
   354			/* double add on the same waitqueue head, ignore */
   355			if (first->head == head)
   356				return;
   357			/* already have a 2nd entry, fail a third attempt */
   358			if (*poll_ptr) {
   359				if ((*poll_ptr)->head == head)
   360					return;
   361				pt->error = -EINVAL;
   362				return;
   363			}
   364	
   365			poll = kmalloc(sizeof(*poll), GFP_ATOMIC);
   366			if (!poll) {
   367				pt->error = -ENOMEM;
   368				return;
   369			}
   370			/* mark as double wq entry */
   371			wqe_private |= 1;
   372			req->flags |= REQ_F_DOUBLE_POLL;
   373			io_init_poll_iocb(poll, first->events, first->wait.func);
   374			*poll_ptr = poll;
   375			if (req->opcode == IORING_OP_POLL_ADD)
   376				req->flags |= REQ_F_ASYNC_DATA;
   377		}
   378	
   379		req->flags |= REQ_F_SINGLE_POLL;
   380		pt->nr_entries++;
   381		poll->head = head;
   382		poll->wait.private = (void *) wqe_private;
   383	
   384		if (poll->events & EPOLLEXCLUSIVE)
   385			add_wait_queue_exclusive(head, &poll->wait);
   386		else
   387			add_wait_queue(head, &poll->wait);
   388	}
   389	
   390	static void io_poll_queue_proc(struct file *file, struct wait_queue_head *head,
   391				       struct poll_table_struct *p)
   392	{
   393		struct io_poll_table *pt = container_of(p, struct io_poll_table, pt);
   394		struct io_poll *poll = io_kiocb_to_cmd(pt->req);
   395	
   396		__io_queue_proc(poll, pt, head,
   397				(struct io_poll **) &pt->req->async_data);
   398	}
   399	
   400	static int __io_arm_poll_handler(struct io_kiocb *req,
   401					 struct io_poll *poll,
   402					 struct io_poll_table *ipt, __poll_t mask)
   403	{
   404		struct io_ring_ctx *ctx = req->ctx;
   405		int v;
   406	
   407		INIT_HLIST_NODE(&req->hash_node);
   408		req->work.cancel_seq = atomic_read(&ctx->cancel_seq);
   409		io_init_poll_iocb(poll, mask, io_poll_wake);
   410		poll->file = req->file;
   411	
   412		req->apoll_events = poll->events;
   413	
   414		ipt->pt._key = mask;
   415		ipt->req = req;
   416		ipt->error = 0;
   417		ipt->nr_entries = 0;
   418	
   419		/*
   420		 * Take the ownership to delay any tw execution up until we're done
   421		 * with poll arming. see io_poll_get_ownership().
   422		 */
   423		atomic_set(&req->poll_refs, 1);
   424		mask = vfs_poll(req->file, &ipt->pt) & poll->events;
   425	
   426		if (mask &&
   427		   ((poll->events & (EPOLLET|EPOLLONESHOT)) == (EPOLLET|EPOLLONESHOT))) {
   428			io_poll_remove_entries(req);
   429			/* no one else has access to the req, forget about the ref */
   430			return mask;
   431		}
   432	
   433		if (!mask && unlikely(ipt->error || !ipt->nr_entries)) {
   434			io_poll_remove_entries(req);
   435			if (!ipt->error)
   436				ipt->error = -EINVAL;
   437			return 0;
   438		}
   439	
   440		spin_lock(&ctx->completion_lock);
   441		io_poll_req_insert(req);
   442		spin_unlock(&ctx->completion_lock);
   443	
   444		if (mask && (poll->events & EPOLLET)) {
   445			/* can't multishot if failed, just queue the event we've got */
   446			if (unlikely(ipt->error || !ipt->nr_entries)) {
   447				poll->events |= EPOLLONESHOT;
   448				req->apoll_events |= EPOLLONESHOT;
   449				ipt->error = 0;
   450			}
   451			__io_poll_execute(req, mask, poll->events);
   452			return 0;
   453		}
   454	
   455		/*
   456		 * Release ownership. If someone tried to queue a tw while it was
   457		 * locked, kick it off for them.
   458		 */
   459		v = atomic_dec_return(&req->poll_refs);
   460		if (unlikely(v & IO_POLL_REF_MASK))
   461			__io_poll_execute(req, 0, poll->events);
   462		return 0;
   463	}
   464	
   465	static void io_async_queue_proc(struct file *file, struct wait_queue_head *head,
   466				       struct poll_table_struct *p)
   467	{
   468		struct io_poll_table *pt = container_of(p, struct io_poll_table, pt);
   469		struct async_poll *apoll = pt->req->apoll;
   470	
   471		__io_queue_proc(&apoll->poll, pt, head, &apoll->double_poll);
   472	}
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
