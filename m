Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5616803E98
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 20:42:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233250AbjLDTmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 14:42:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231501AbjLDTmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 14:42:17 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C910FF0
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 11:42:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701718944; x=1733254944;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=jr6ZC4QTHiMBOoU079Jyk/SGSEVXDbkp/sLimQ9ENpE=;
  b=XpbNo9GdLNPUDbp3F6U7qRcwpUyX6gEjZJT+IqeJIF7rnHDufWvTpRk6
   vWzIkgd0gF+SoC0ARIl8Iz/dj8ljVYPTQgrt663TzvHOjt2heIUfvu6kW
   YW1shSUd3OvIQR01UQ1OPWgfgYsEKvEQ4YyfG/IXJg9OQYZbmzGRHRqQC
   zQDCExRHmtL2CfC2p9DBYI/z34I0XzpjJ14uKH+MfDwsrzY827dw7HFbi
   TgpNgzBc1ns52rhE9PGWUwPrYAJWFDo7I60DqkZVfhWLa+Ej9ZXjPoBI9
   oeI7/24p1dB3Ag6NqdR6e9o0tDEK9lbt7PJ+6bgnkOU47QHdiw7UnYX+X
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="855510"
X-IronPort-AV: E=Sophos;i="6.04,250,1695711600"; 
   d="scan'208";a="855510"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 11:41:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="861493062"
X-IronPort-AV: E=Sophos;i="6.04,250,1695711600"; 
   d="scan'208";a="861493062"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 04 Dec 2023 11:41:44 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rAEou-00081v-05;
        Mon, 04 Dec 2023 19:41:34 +0000
Date:   Tue, 5 Dec 2023 03:40:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: io_uring/poll.c:819:40: sparse: sparse: incorrect type in argument 2
 (different base types)
Message-ID: <202312050238.labqn1bV-lkp@intel.com>
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
head:   33cc938e65a98f1d29d0a18403dbbee050dcad9a
commit: 063a007996bf725ba4c7d8741701670be9858300 io_uring: change arm poll return values
date:   1 year, 4 months ago
config: x86_64-alldefconfig (https://download.01.org/0day-ci/archive/20231205/202312050238.labqn1bV-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231205/202312050238.labqn1bV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312050238.labqn1bV-lkp@intel.com/

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
