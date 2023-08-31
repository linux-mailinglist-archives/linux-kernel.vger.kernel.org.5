Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7D578F125
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 18:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244471AbjHaQWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 12:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236721AbjHaQWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 12:22:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC55D124
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 09:22:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 700C562444
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 16:22:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC838C433C8;
        Thu, 31 Aug 2023 16:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693498938;
        bh=JrMZKx4CpXJp7uU1vEvb0IgYXij8rPo+tfyY+LtuhXs=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Q6RGFzLtIZ9qOUnC/GL4Vr+bAtTPCFR8ggUlJHJ50Phb95qSFofROmX3nQ0TuVdm5
         MayToVDYej5OgrHS9EKDfnCCUwKbVSBVnUnLROx1BpsAxAsKbOzDrMsEPlIMVY0txw
         DznCF+1N7ls/UP0jOqjz1E7RpGNY1H7vi8IVL+ox2a1w4yypkzHI9kPMYTV6U5XAWz
         SKkUFyneKBoPuldDNL/aqQ5x9ChIaQpNViFq8YLy3qWBxwierQJXE5dw34xD0FvciB
         KxbOfvdxLRF8E8+GnOIpWM/H63C2U1S1CrLQ0cc8Td+ZC/Ds6GAEdS+VCeHIl4z7/c
         73g6YcnzrkD8g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 9BE5FCE0737; Thu, 31 Aug 2023 09:22:17 -0700 (PDT)
Date:   Thu, 31 Aug 2023 09:22:17 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     linux-kernel@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [paulmck-rcu:dev.2023.08.22a 63/69]
 kernel/locking/locktorture.c:294:20-23: ERROR: t is NULL but dereferenced.
 (fwd)
Message-ID: <7c706521-1e20-44da-91a7-e71f238a235e@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <e24280d0-dfbb-f4f-64aa-9f50268450b@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e24280d0-dfbb-f4f-64aa-9f50268450b@inria.fr>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2023 at 11:01:02AM +0200, Julia Lawall wrote:
> Maybe a ! has been forgotton on line 290?

Right you are, and thank you!

I will go get my brown paper bag.  ;-)

							Thanx, Paul

> julia
> 
> ---------- Forwarded message ----------
> Date: Thu, 31 Aug 2023 10:46:56 +0800
> From: kernel test robot <lkp@intel.com>
> To: oe-kbuild@lists.linux.dev
> Cc: lkp@intel.com, Julia Lawall <julia.lawall@inria.fr>
> Subject: [paulmck-rcu:dev.2023.08.22a 63/69]
>     kernel/locking/locktorture.c:294:20-23: ERROR: t is NULL but dereferenced.
> 
> BCC: lkp@intel.com
> CC: oe-kbuild-all@lists.linux.dev
> CC: linux-kernel@vger.kernel.org
> TO: "Paul E. McKenney" <paulmck@kernel.org>
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2023.08.22a
> head:   354957ec11dc80eac68c4b1e10c237d69adc1833
> commit: 758918804e0d5216981df3cef99ffd7ba0842192 [63/69] locktorture: Add indication of task write-holding lock
> :::::: branch date: 6 days ago
> :::::: commit date: 7 days ago
> config: i386-randconfig-053-20230831 (https://download.01.org/0day-ci/archive/20230831/202308311022.j7jKnIdL-lkp@intel.com/config)
> compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
> reproduce: (https://download.01.org/0day-ci/archive/20230831/202308311022.j7jKnIdL-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Julia Lawall <julia.lawall@inria.fr>
> | Closes: https://lore.kernel.org/r/202308311022.j7jKnIdL-lkp@intel.com/
> 
> cocci warnings: (new ones prefixed by >>)
> >> kernel/locking/locktorture.c:294:20-23: ERROR: t is NULL but dereferenced.
>    kernel/locking/locktorture.c:294:43-47: ERROR: t is NULL but dereferenced.
> 
> vim +294 kernel/locking/locktorture.c
> 
> bdd8d60bd4047a Paul E. McKenney 2023-08-23  284
> 94a8fb5e4673d7 Paul E. McKenney 2023-08-22  285  static int torture_spin_lock_dump(struct notifier_block *nb, unsigned long v, void *ptr)
> 94a8fb5e4673d7 Paul E. McKenney 2023-08-22  286  {
> 758918804e0d52 Paul E. McKenney 2023-08-23  287  	struct task_struct *t = READ_ONCE(lock_is_write_held);
> 758918804e0d52 Paul E. McKenney 2023-08-23  288
> 94a8fb5e4673d7 Paul E. McKenney 2023-08-22  289  	pr_alert("%s invoked: v=%lu, duration=%lu.\n", __func__, v, (unsigned long)ptr);
> 758918804e0d52 Paul E. McKenney 2023-08-23  290  	if (t) {
> 758918804e0d52 Paul E. McKenney 2023-08-23  291  		pr_alert("%s No task holding lock.\n", __func__);
> 758918804e0d52 Paul E. McKenney 2023-08-23  292  	} else {
> 758918804e0d52 Paul E. McKenney 2023-08-23  293  		pr_alert("%s Lock held by task %ps %d %*s\n",
> 758918804e0d52 Paul E. McKenney 2023-08-23 @294  			 __func__, t, t->pid, TASK_COMM_LEN, t->comm);
> 758918804e0d52 Paul E. McKenney 2023-08-23  295  		sched_show_task(t);
> 758918804e0d52 Paul E. McKenney 2023-08-23  296  	}
> bdd8d60bd4047a Paul E. McKenney 2023-08-23  297  	spinlock_dump(&torture_spinlock, true);
> 94a8fb5e4673d7 Paul E. McKenney 2023-08-22  298  	return NOTIFY_OK;
> 94a8fb5e4673d7 Paul E. McKenney 2023-08-22  299  }
> 94a8fb5e4673d7 Paul E. McKenney 2023-08-22  300
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
