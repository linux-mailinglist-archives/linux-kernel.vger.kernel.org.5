Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C371787ACD
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 23:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243786AbjHXV7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 17:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243713AbjHXV6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 17:58:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3341172D;
        Thu, 24 Aug 2023 14:58:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6896A62EEC;
        Thu, 24 Aug 2023 21:58:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCFA6C433C8;
        Thu, 24 Aug 2023 21:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692914326;
        bh=jDXAjQi5jNegqMxp/YO+vbuWqKgJ/j4R2E5d/nmjBVc=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=Ns6XmA3CxSl9YWk/EH389B1kxdZIXGU8d5goSH/Rad5hYD/SkOzI9HKsZgyelt9RS
         cE2pCCFj84xb1n2gMX3vrO2F/dDk/MTqERIYULeA/R6V0FnCisKM0vWJ+SYRrHi5OH
         WhvcLYFxU3Ko0xJGKg5EJ4+51c0rlWwbcuUflZEH2Vo4x30yACwiTjVShDVMNdk+QU
         cWqwbTvCU8hie4JhwgWxFfCPZ2/5lBD+BoH8pf/5Y+PpG7tktnKfRgXMPQzcN7c2bs
         fqsDNuTPiZxfagXsgdSlrQJTXrvYL4HG8qGRr9TvwQo3Aw6xXbN6QwhgG1lkG/vtr2
         ueLSq6A6AiJmA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 593B0CE134A; Thu, 24 Aug 2023 14:58:46 -0700 (PDT)
Date:   Thu, 24 Aug 2023 14:58:46 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rcu@vger.kernel.org, mingo@kernel.org, tglx@linutronix.de
Subject: [GIT PULL] RCU changes for v6.6
Message-ID: <222d7653-b6c8-4132-863d-94c04c781f1d@paulmck-laptop>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Linus,

Once the merge window opens, please pull the latest RCU git tree from:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/rcu.2023.08.21a
  # HEAD: fe24a0b63278808013e1756e235e0e17e8bae281: Merge branches 'doc.2023.07.14b', 'fixes.2023.08.16a', 'rcu-tasks.2023.07.24a', 'rcuscale.2023.07.14b', 'refscale.2023.07.14b', 'torture.2023.08.14a' and 'torturescripts.2023.07.20a' into HEAD (2023-08-16 14:31:08 -0700)

----------------------------------------------------------------
RCU pull request for v6.6

doc.2023.07.14b: Documentation updates.

fixes.2023.08.16a: Miscellaneous fixes, perhaps most notably simplifying
	SRCU_NOTIFIER_INIT() as suggested.

rcu-tasks.2023.07.24a:  RCU Tasks updates, most notably treating
	Tasks RCU callbacks as lazy while still treating synchronous
	grace periods as urgent.  Also fixes one bug that restores the
	ability to apply debug-objects to RCU Tasks and another that
	fixes a race condition that could result in false-positive
	failures of the boot-time self-test code.

rcuscale.2023.07.14b: RCU-scalability performance-test updates,
	most notably adding the ability to measure the RCU-Tasks's
	grace-period kthread's CPU consumption.  This proved
	quite useful for the rcu-tasks.2023.07.24a work.

refscale.2023.07.14b: Reference-acquisition/release performance-test
	updates, including a fix for an uninitialized wait_queue_head_t.

torture.2023.08.14a: Miscellaneous torture-test updates.

torturescripts.2023.07.20a: Torture-test scripting updates, including
	removal of the non-longer-functional formal-verification scripts,
	test builds of individual RCU Tasks flavors, better diagnostics
	for loss of connectivity for distributed rcutorture tests,
	disabling of reboot loops in qemu/KVM-based rcutorture testing,
	and passing of init parameters to rcutorture's init program.

----------------------------------------------------------------
Alan Huang (2):
      docs/RCU: Add the missing rcu_read_unlock()
      rcu: Use WRITE_ONCE() for assignments to ->next for rculist_nulls

Arnd Bergmann (1):
      rcuscale: fix building with RCU_TINY

Connor O'Brien (1):
      torture: Support randomized shuffling for proxy exec testing

Dietmar Eggemann (1):
      torture: Add lock_torture writer_fifo module parameter

Paul E. McKenney (52):
      rcu-tasks: Treat only synchronous grace periods urgently
      rcu-tasks: Remove redundant #ifdef CONFIG_TASKS_RCU
      rcu-tasks: Add kernel boot parameters for callback laziness
      rcu-tasks: Cancel callback laziness if too many callbacks
      refscale: Add CONFIG_PREEMPT_DYNAMIC=n to NOPREEMPT scenario
      refscale: Add a "jiffies" test
      rcuscale: Permit blocking delays between writers
      rcuscale: Fix gp_async_max typo: s/reader/writer/
      rcuscale: Add minruntime module parameter
      rcuscale: Print out full set of module parameters
      rcuscale: Print out full set of kfree_rcu parameters
      rcuscale: Measure grace-period kthread CPU time
      rcuscale: Add kfree_by_call_rcu and kfree_mult to documentation
      rcuscale: Print grace-period kthread CPU time, if recorded
      rcuscale: Measure RCU Tasks Trace grace-period kthread CPU time
      rcuscale: Add RCU Tasks Rude testing
      rcuscale: Add CONFIG_PREEMPT_DYNAMIC=n to TRACE01 scenario
      rcutorture: Dump grace-period state upon rtort_pipe_count incidents
      rcutorture: Remove obsolete BOOTPARAM_HOTPLUG_CPU0 Kconfig option
      rcu: Remove formal-verification tests
      torture: Add "--no-" as synonym for "--do-no-" in torture.sh
      rcutorture: Remove contradictory Kconfig constraint
      torture: Allow #CHECK# in --kconfig argument to kvm.sh
      torture: Make kvm-recheck.sh report .config errors
      torture: Add RCU Tasks individual-flavor build tests
      torture: Make kvm-remote print diagnostics on initial ssh failure
      rcutorture: Remove obsolete parameter check from mkinitrd.sh
      torture: Place --bootargs parameters at end of -append list
      torture: Make torture.sh summarize config and build errors
      torture: Loosen .config checks for KCSAN kernels
      rcu: Update synchronize_rcu_mult() comment for call_rcu_hurry()
      rcu: Clarify rcu_is_watching() kernel-doc comment
      torture: Add srcu_lockdep.sh to torture.sh
      torture: Avoid torture-test reboot loops
      torture: Add init-program support for loongarch
      torture: Switch qemu from -nographic to -display none
      torture: Make init program dump command-line arguments
      torture: Cause mkinitrd.sh to indicate failure on compile errors
      checkpatch: Complain about unexpected uses of RCU Tasks Trace
      rcu-tasks: Permit use of debug-objects with RCU Tasks flavors
      rcu-tasks: Fix boot-time RCU tasks debug-only deadlock
      torture: Add a kthread-creation callback to _torture_create_kthread()
      torture: Make torture_hrtimeout_*() use TASK_IDLE
      torture: Move torture_onoff() timeouts to hrtimers
      torture: Move torture_shuffle() timeouts to hrtimers
      torture: Move stutter_wait() timeouts to hrtimers
      torture: Stop right-shifting torture_random() return values
      rcutorture: Stop right-shifting torture_random() return values
      srcu,notifier: Remove #ifdefs in favor of SRCU Tiny srcu_usage
      rcu: Mark __rcu_irq_enter_check_tick() ->rcu_urgent_qs load
      rcu: Make the rcu_nocb_poll boot parameter usable via boot config
      Merge branches 'doc.2023.07.14b', 'fixes.2023.08.16a', 'rcu-tasks.2023.07.24a', 'rcuscale.2023.07.14b', 'refscale.2023.07.14b', 'torture.2023.08.14a' and 'torturescripts.2023.07.20a' into HEAD

SeongJae Park (5):
      Docs/RCU/rculist_nulls: Fix trivial coding style
      Docs/RCU/rculist_nulls: Assign 'obj' before use from the examples
      Docs/RCU/rculist_nulls: Specify type of the object in examples
      Docs/RCU/rculist_nulls: Fix hlist_[nulls]_head field names of 'obj'
      Docs/RCU/rculist_nulls: Fix text about atomic_set_release()

Tycho Andersen (1):
      documentation/rcu: Fix typo

Waiman Long (1):
      refscale: Fix uninitalized use of wait_queue_head_t

Zqiang (1):
      rcuscale: Move rcu_scale_writer() schedule_timeout_uninterruptible() to _idle()

 Documentation/RCU/lockdep-splat.rst                |   2 +-
 Documentation/RCU/rculist_nulls.rst                |  38 ++-
 Documentation/admin-guide/kernel-parameters.txt    |  56 ++-
 include/linux/notifier.h                           |  11 -
 include/linux/rculist_nulls.h                      |   4 +-
 include/linux/rcupdate_trace.h                     |   1 +
 include/linux/rcupdate_wait.h                      |   5 +
 include/linux/srcutiny.h                           |   4 +
 include/linux/torture.h                            |   7 +-
 kernel/locking/locktorture.c                       |  12 +-
 kernel/rcu/rcu.h                                   |   8 +
 kernel/rcu/rcuscale.c                              |  83 ++++-
 kernel/rcu/rcutorture.c                            |   7 +-
 kernel/rcu/refscale.c                              |  37 +-
 kernel/rcu/tasks.h                                 | 136 ++++++--
 kernel/rcu/tree.c                                  |  16 +-
 kernel/rcu/tree_nocb.h                             |   4 +-
 kernel/torture.c                                   |  39 ++-
 scripts/checkpatch.pl                              |  24 ++
 .../selftests/rcutorture/bin/configcheck.sh        |  61 ++--
 .../testing/selftests/rcutorture/bin/functions.sh  |   2 +-
 .../rcutorture/bin/kvm-recheck-rcuscale.sh         |   8 +-
 .../selftests/rcutorture/bin/kvm-recheck.sh        |  44 ++-
 .../testing/selftests/rcutorture/bin/kvm-remote.sh |  12 +-
 .../selftests/rcutorture/bin/kvm-test-1-run.sh     |  12 +-
 tools/testing/selftests/rcutorture/bin/kvm.sh      |   2 +-
 tools/testing/selftests/rcutorture/bin/mkinitrd.sh |  17 +-
 tools/testing/selftests/rcutorture/bin/torture.sh  | 123 +++++--
 .../rcutorture/configs/lock/ver_functions.sh       |   5 +-
 .../selftests/rcutorture/configs/rcu/TASKS03       |   1 -
 .../selftests/rcutorture/configs/rcu/TREE01        |   1 -
 .../rcutorture/configs/rcu/ver_functions.sh        |   5 +-
 .../selftests/rcutorture/configs/rcuscale/CFcommon |   2 +
 .../selftests/rcutorture/configs/rcuscale/TRACE01  |   2 +
 .../rcutorture/configs/rcuscale/ver_functions.sh   |   5 +-
 .../rcutorture/configs/refscale/NOPREEMPT          |   1 +
 .../rcutorture/configs/refscale/ver_functions.sh   |   5 +-
 .../rcutorture/configs/scf/ver_functions.sh        |   5 +-
 .../rcutorture/formal/srcu-cbmc/.gitignore         |   2 -
 .../selftests/rcutorture/formal/srcu-cbmc/Makefile |  17 -
 .../formal/srcu-cbmc/empty_includes/linux/delay.h  |   0
 .../formal/srcu-cbmc/empty_includes/linux/export.h |   0
 .../formal/srcu-cbmc/empty_includes/linux/mutex.h  |   0
 .../formal/srcu-cbmc/empty_includes/linux/percpu.h |   0
 .../srcu-cbmc/empty_includes/linux/preempt.h       |   0
 .../srcu-cbmc/empty_includes/linux/rcupdate.h      |   0
 .../formal/srcu-cbmc/empty_includes/linux/sched.h  |   0
 .../formal/srcu-cbmc/empty_includes/linux/smp.h    |   0
 .../srcu-cbmc/empty_includes/linux/workqueue.h     |   0
 .../srcu-cbmc/empty_includes/uapi/linux/types.h    |   0
 .../formal/srcu-cbmc/include/linux/.gitignore      |   2 -
 .../formal/srcu-cbmc/include/linux/kconfig.h       |   1 -
 .../formal/srcu-cbmc/include/linux/types.h         | 152 ---------
 .../rcutorture/formal/srcu-cbmc/modify_srcu.awk    | 376 ---------------------
 .../rcutorture/formal/srcu-cbmc/src/assume.h       |  17 -
 .../rcutorture/formal/srcu-cbmc/src/barriers.h     |  41 ---
 .../rcutorture/formal/srcu-cbmc/src/bug_on.h       |  14 -
 .../formal/srcu-cbmc/src/combined_source.c         |  14 -
 .../rcutorture/formal/srcu-cbmc/src/config.h       |  28 --
 .../rcutorture/formal/srcu-cbmc/src/include_srcu.c |  32 --
 .../rcutorture/formal/srcu-cbmc/src/int_typedefs.h |  34 --
 .../rcutorture/formal/srcu-cbmc/src/locks.h        | 221 ------------
 .../rcutorture/formal/srcu-cbmc/src/misc.c         |  12 -
 .../rcutorture/formal/srcu-cbmc/src/misc.h         |  58 ----
 .../rcutorture/formal/srcu-cbmc/src/percpu.h       |  93 -----
 .../rcutorture/formal/srcu-cbmc/src/preempt.c      |  79 -----
 .../rcutorture/formal/srcu-cbmc/src/preempt.h      |  59 ----
 .../formal/srcu-cbmc/src/simple_sync_srcu.c        |  51 ---
 .../rcutorture/formal/srcu-cbmc/src/workqueues.h   | 103 ------
 .../srcu-cbmc/tests/store_buffering/.gitignore     |   2 -
 .../srcu-cbmc/tests/store_buffering/Makefile       |  12 -
 .../tests/store_buffering/assert_end.fail          |   1 -
 .../srcu-cbmc/tests/store_buffering/force.fail     |   1 -
 .../srcu-cbmc/tests/store_buffering/force2.fail    |   1 -
 .../srcu-cbmc/tests/store_buffering/force3.fail    |   1 -
 .../srcu-cbmc/tests/store_buffering/main.pass      |   0
 .../formal/srcu-cbmc/tests/store_buffering/test.c  |  73 ----
 .../formal/srcu-cbmc/tests/test_script.sh          | 103 ------
 78 files changed, 636 insertions(+), 1771 deletions(-)
 delete mode 100644 tools/testing/selftests/rcutorture/formal/srcu-cbmc/.gitignore
 delete mode 100644 tools/testing/selftests/rcutorture/formal/srcu-cbmc/Makefile
 delete mode 100644 tools/testing/selftests/rcutorture/formal/srcu-cbmc/empty_includes/linux/delay.h
 delete mode 100644 tools/testing/selftests/rcutorture/formal/srcu-cbmc/empty_includes/linux/export.h
 delete mode 100644 tools/testing/selftests/rcutorture/formal/srcu-cbmc/empty_includes/linux/mutex.h
 delete mode 100644 tools/testing/selftests/rcutorture/formal/srcu-cbmc/empty_includes/linux/percpu.h
 delete mode 100644 tools/testing/selftests/rcutorture/formal/srcu-cbmc/empty_includes/linux/preempt.h
 delete mode 100644 tools/testing/selftests/rcutorture/formal/srcu-cbmc/empty_includes/linux/rcupdate.h
 delete mode 100644 tools/testing/selftests/rcutorture/formal/srcu-cbmc/empty_includes/linux/sched.h
 delete mode 100644 tools/testing/selftests/rcutorture/formal/srcu-cbmc/empty_includes/linux/smp.h
 delete mode 100644 tools/testing/selftests/rcutorture/formal/srcu-cbmc/empty_includes/linux/workqueue.h
 delete mode 100644 tools/testing/selftests/rcutorture/formal/srcu-cbmc/empty_includes/uapi/linux/types.h
 delete mode 100644 tools/testing/selftests/rcutorture/formal/srcu-cbmc/include/linux/.gitignore
 delete mode 100644 tools/testing/selftests/rcutorture/formal/srcu-cbmc/include/linux/kconfig.h
 delete mode 100644 tools/testing/selftests/rcutorture/formal/srcu-cbmc/include/linux/types.h
 delete mode 100755 tools/testing/selftests/rcutorture/formal/srcu-cbmc/modify_srcu.awk
 delete mode 100644 tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/assume.h
 delete mode 100644 tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/barriers.h
 delete mode 100644 tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/bug_on.h
 delete mode 100644 tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/combined_source.c
 delete mode 100644 tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/config.h
 delete mode 100644 tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/include_srcu.c
 delete mode 100644 tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/int_typedefs.h
 delete mode 100644 tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/locks.h
 delete mode 100644 tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/misc.c
 delete mode 100644 tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/misc.h
 delete mode 100644 tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/percpu.h
 delete mode 100644 tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/preempt.c
 delete mode 100644 tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/preempt.h
 delete mode 100644 tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/simple_sync_srcu.c
 delete mode 100644 tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/workqueues.h
 delete mode 100644 tools/testing/selftests/rcutorture/formal/srcu-cbmc/tests/store_buffering/.gitignore
 delete mode 100644 tools/testing/selftests/rcutorture/formal/srcu-cbmc/tests/store_buffering/Makefile
 delete mode 100644 tools/testing/selftests/rcutorture/formal/srcu-cbmc/tests/store_buffering/assert_end.fail
 delete mode 100644 tools/testing/selftests/rcutorture/formal/srcu-cbmc/tests/store_buffering/force.fail
 delete mode 100644 tools/testing/selftests/rcutorture/formal/srcu-cbmc/tests/store_buffering/force2.fail
 delete mode 100644 tools/testing/selftests/rcutorture/formal/srcu-cbmc/tests/store_buffering/force3.fail
 delete mode 100644 tools/testing/selftests/rcutorture/formal/srcu-cbmc/tests/store_buffering/main.pass
 delete mode 100644 tools/testing/selftests/rcutorture/formal/srcu-cbmc/tests/store_buffering/test.c
 delete mode 100755 tools/testing/selftests/rcutorture/formal/srcu-cbmc/tests/test_script.sh
