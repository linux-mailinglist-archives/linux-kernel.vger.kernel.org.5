Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1E778E8F6
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 11:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233624AbjHaJBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 05:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbjHaJBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 05:01:17 -0400
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A9F5CE6
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 02:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=sVn5DkV6XBahYJlGgHVxn87Ah3hspPLN913g7w+bU/A=;
  b=QmyxZR7yHgsYAIVV1d9eCNMC82DB/AxldjVnAlGUdMiHzZ8gdtijdU41
   xfsIpjjut+G8Gs8X+dcOT+wK56vd8es4B3gG93heSqpEC+63UqEBtY2Aa
   9em8swmrerKEOQRrarSXAEVCm6IHq8gIhCrc9ZaqoOnit3UMS2zNMyYEY
   c=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.02,216,1688421600"; 
   d="scan'208";a="123636226"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 11:01:02 +0200
Date:   Thu, 31 Aug 2023 11:01:02 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
To:     "Paul E. McKenney" <paulmck@kernel.org>
cc:     linux-kernel@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: [paulmck-rcu:dev.2023.08.22a 63/69] kernel/locking/locktorture.c:294:20-23:
 ERROR: t is NULL but dereferenced. (fwd)
Message-ID: <e24280d0-dfbb-f4f-64aa-9f50268450b@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,T_SPF_HELO_TEMPERROR,T_SPF_TEMPERROR
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maybe a ! has been forgotton on line 290?

julia

---------- Forwarded message ----------
Date: Thu, 31 Aug 2023 10:46:56 +0800
From: kernel test robot <lkp@intel.com>
To: oe-kbuild@lists.linux.dev
Cc: lkp@intel.com, Julia Lawall <julia.lawall@inria.fr>
Subject: [paulmck-rcu:dev.2023.08.22a 63/69]
    kernel/locking/locktorture.c:294:20-23: ERROR: t is NULL but dereferenced.

BCC: lkp@intel.com
CC: oe-kbuild-all@lists.linux.dev
CC: linux-kernel@vger.kernel.org
TO: "Paul E. McKenney" <paulmck@kernel.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2023.08.22a
head:   354957ec11dc80eac68c4b1e10c237d69adc1833
commit: 758918804e0d5216981df3cef99ffd7ba0842192 [63/69] locktorture: Add indication of task write-holding lock
:::::: branch date: 6 days ago
:::::: commit date: 7 days ago
config: i386-randconfig-053-20230831 (https://download.01.org/0day-ci/archive/20230831/202308311022.j7jKnIdL-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce: (https://download.01.org/0day-ci/archive/20230831/202308311022.j7jKnIdL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Julia Lawall <julia.lawall@inria.fr>
| Closes: https://lore.kernel.org/r/202308311022.j7jKnIdL-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> kernel/locking/locktorture.c:294:20-23: ERROR: t is NULL but dereferenced.
   kernel/locking/locktorture.c:294:43-47: ERROR: t is NULL but dereferenced.

vim +294 kernel/locking/locktorture.c

bdd8d60bd4047a Paul E. McKenney 2023-08-23  284
94a8fb5e4673d7 Paul E. McKenney 2023-08-22  285  static int torture_spin_lock_dump(struct notifier_block *nb, unsigned long v, void *ptr)
94a8fb5e4673d7 Paul E. McKenney 2023-08-22  286  {
758918804e0d52 Paul E. McKenney 2023-08-23  287  	struct task_struct *t = READ_ONCE(lock_is_write_held);
758918804e0d52 Paul E. McKenney 2023-08-23  288
94a8fb5e4673d7 Paul E. McKenney 2023-08-22  289  	pr_alert("%s invoked: v=%lu, duration=%lu.\n", __func__, v, (unsigned long)ptr);
758918804e0d52 Paul E. McKenney 2023-08-23  290  	if (t) {
758918804e0d52 Paul E. McKenney 2023-08-23  291  		pr_alert("%s No task holding lock.\n", __func__);
758918804e0d52 Paul E. McKenney 2023-08-23  292  	} else {
758918804e0d52 Paul E. McKenney 2023-08-23  293  		pr_alert("%s Lock held by task %ps %d %*s\n",
758918804e0d52 Paul E. McKenney 2023-08-23 @294  			 __func__, t, t->pid, TASK_COMM_LEN, t->comm);
758918804e0d52 Paul E. McKenney 2023-08-23  295  		sched_show_task(t);
758918804e0d52 Paul E. McKenney 2023-08-23  296  	}
bdd8d60bd4047a Paul E. McKenney 2023-08-23  297  	spinlock_dump(&torture_spinlock, true);
94a8fb5e4673d7 Paul E. McKenney 2023-08-22  298  	return NOTIFY_OK;
94a8fb5e4673d7 Paul E. McKenney 2023-08-22  299  }
94a8fb5e4673d7 Paul E. McKenney 2023-08-22  300

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
