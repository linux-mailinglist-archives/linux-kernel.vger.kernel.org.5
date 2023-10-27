Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D98BA7D96B7
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 13:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbjJ0Ld0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 07:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231617AbjJ0LdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 07:33:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 850C41B9;
        Fri, 27 Oct 2023 04:33:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5144FC433C7;
        Fri, 27 Oct 2023 11:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698406398;
        bh=q/s6bwfSs+/ywtFUyIqksVIROBIaJ1IAB9WfI4d6joU=;
        h=Date:From:To:Cc:Subject:From;
        b=lmWgVZSU8NebZDDn/lBV+XfRzMeU9yhwT4bbRLCknuj/BR5mo6a8+W0aW1JMhgINA
         l2MredAvSVs4GF/hd5Qs1BRmawCqmQNAFs5DADZ+6V1ALWLSQnVFqgjtwUVnEDF1HC
         CDYs0GbabjrChnvNmsc1/ZshXYlkQFVY2eeRJf7YFhOOuhY9EJ0DPz/R0bbVRPsGwl
         fA2fKXNzcv82uMMgskPljCEaSF+sGLufLc0KG5k/PMz9xcckrX6yTZWbSBOtJIQMiT
         XUtf4LPUX6HlOccJ49QMA+Lqo3W3vOGQliI1/tpFAaiAyvMgjAyAisdtSDHZz5JKKh
         zrdH+KW1SUE8A==
Date:   Fri, 27 Oct 2023 13:33:15 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Z qiang <qiang.zhang1211@gmail.com>
Subject: [GIT PULL] RCU changes for v6.7
Message-ID: <ZTuf+xNrfqGjHFDK@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URG_BIZ,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

Once the merge window opens, please pull the latest RCU git tree from:

  git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git tags/rcu-next-v6.7

# HEAD: d97ae6474ca0411bb8c2696e5764ec946dba43d0:

  Merge branches 'rcu/torture', 'rcu/fixes', 'rcu/docs', 'rcu/refscale', 'rcu/tasks' and 'rcu/stall' into rcu/next (2023-10-23 15:24:11 +0200)

----------------------------------------------------------------
RCU pull request for v6.7

This pull request contains the following branches:

rcu/torture: RCU torture, locktorture and generic torture infrastructure
	updates that include various fixes, cleanups and consolidations.
	Among the user visible things, ftrace dumps can now be found into
	their own file, and module parameters get better documented and
	reported on dumps.

rcu/fixes: Generic and misc fixes all over the place. Some highlights:

	* Hotplug handling has seen some light cleanups and comments.

	* An RCU barrier can now be triggered through sysfs to serialize
	memory stress testing and avoid OOM.

	* Object information is now dumped in case of invalid callback
	invocation.

	* Also various SRCU issues, too hard to trigger to deserve urgent
	pull requests, have been fixed.

rcu/docs: RCU documentation updates

rcu/refscale: RCU reference scalability test minor fixes and doc
	improvements.

rcu/tasks: RCU tasks minor fixes

rcu/stall: Stall detection updates. Introduce RCU CPU Stall notifiers
	that allows a subsystem to provide informations to help debugging.
	Also cure some false positive stalls.

----------------------------------------------------------------
Arnd Bergmann (1):
      rcu: Include torture_sched_setaffinity() declaration

Catalin Marinas (1):
      rcu: kmemleak: Ignore kmemleak false positives when RCU-freeing objects

Dan Carpenter (1):
      locktorture: Check the correct variable for allocation failure

Denis Arefev (1):
      srcu: Fix srcu_struct node grpmask overflow on 64-bit systems

Frederic Weisbecker (10):
      rcu: Use rcu_segcblist_segempty() instead of open coding it
      rcu: Assume IRQS disabled from rcu_report_dead()
      rcu: Assume rcu_report_dead() is always called locally
      rcu: Remove references to rcu_migrate_callbacks() from diagrams
      rcu: Conditionally build CPU-hotplug teardown callbacks
      rcu: Standardize explicit CPU-hotplug calls
      rcu: Comment why callbacks migration can't wait for CPUHP_RCUTREE_PREP
      srcu: Fix callbacks acceleration mishandling
      srcu: Only accelerate on enqueue time
      Merge branches 'rcu/torture', 'rcu/fixes', 'rcu/docs', 'rcu/refscale', 'rcu/tasks' and 'rcu/stall' into rcu/next

Jiapeng Chong (1):
      rcu-tasks: Make rcu_tasks_lazy_ms static

Joel Fernandes (Google) (7):
      rcu/tree: Defer setting of jiffies during stall reset
      Revert "checkpatch: Error out if deprecated RCU API used"
      srcu: Fix error handling in init_srcu_struct_fields()
      rcu/tree: Remove superfluous return from void call_rcu* functions
      rcutorture: Fix stuttering races and other issues
      rcutorture: Copy out ftrace into its own console file
      rcutorture: Replace schedule_timeout*() 1-jiffy waits with HZ/20

Matthew Wilcox (Oracle) (1):
      rcu: Describe listRCU read-side guarantees

Paul E. McKenney (26):
      rcu: Add RCU CPU stall notifier
      rcutorture: Add test of RCU CPU stall notifiers
      rcu-tasks: Add printk()s to localize boot-time self-test hang
      rcu-tasks: Pull sampling of ->percpu_dequeue_lim out of loop
      refscale: Fix misplaced data re-read
      refscale: Print out additional module parameters
      doc: Add refscale.lookup_instances to kernel-parameters.txt
      rcu: Add sysfs to provide throttled access to rcu_barrier()
      rcu: Eliminate rcu_gp_slow_unregister() false positive
      torture: Share torture_random_state with torture_shuffle_tasks()
      torture: Make kvm-recheck.sh use mktemp
      torture: Make torture_hrtimeout_ns() take an hrtimer mode parameter
      torture: Move rcutorture_sched_setaffinity() out of rcutorture
      locktorture: Add readers_bind and writers_bind module parameters
      rcutorture: Add CONFIG_DEBUG_OBJECTS to RCU Tasks testing
      locktorture: Alphabetize torture_param() entries
      locktorture: Consolidate "if" statements in lock_torture_writer()
      locktorture: Add acq_writer_lim to complain about long acquistion times
      torture: Print out torture module parameters
      torture: Make torture.sh refscale testing qualify verbose_batched
      locktorture: Add new module parameters to lock_torture_print_module_parms()
      locktorture: Add call_rcu_chains module parameter
      doc: Catch-up update for locktorture module parameters
      locktorture: Rename readers_bind/writers_bind to bind_readers/bind_writers
      torture: Add kvm.sh --debug-info argument
      torture: Convert parse-console.sh to mktemp

Wei Zhang (1):
      Documentation: RCU: Fix section numbers after adding Section 7 in whatisRCU.rst

Yue Haibing (1):
      rcu: Remove unused function declaration rcu_eqs_special_set()

Zhen Lei (5):
      rcu: Delete a redundant check in rcu_check_gp_kthread_starvation()
      rcu: Don't redump the stalled CPU where RCU GP kthread last ran
      rcu: Eliminate check_cpu_stall() duplicate code
      mm: Remove kmem_valid_obj()
      rcu: Dump memory object info if callback function is invalid

Zqiang (1):
      rcutorture: Traverse possible cpu to set maxcpu in rcu_nocb_toggle()

 .../Expedited-Grace-Periods.rst                    |   2 +-
 .../Memory-Ordering/TreeRCU-callback-registry.svg  |   9 -
 .../RCU/Design/Memory-Ordering/TreeRCU-gp-fqs.svg  |   4 +-
 .../RCU/Design/Memory-Ordering/TreeRCU-gp.svg      |  13 +-
 .../RCU/Design/Memory-Ordering/TreeRCU-hotplug.svg |   4 +-
 .../RCU/Design/Requirements/Requirements.rst       |   4 +-
 Documentation/RCU/listRCU.rst                      |   9 +
 Documentation/RCU/whatisRCU.rst                    |   4 +-
 Documentation/admin-guide/kernel-parameters.txt    |  70 +++++-
 arch/arm64/kernel/smp.c                            |   4 +-
 arch/powerpc/kernel/smp.c                          |   2 +-
 arch/s390/kernel/smp.c                             |   2 +-
 arch/x86/kernel/smpboot.c                          |   2 +-
 include/linux/interrupt.h                          |   2 +-
 include/linux/rcu_notifier.h                       |  32 +++
 include/linux/rcupdate.h                           |   2 -
 include/linux/rcutiny.h                            |   2 +-
 include/linux/rcutree.h                            |  17 +-
 include/linux/slab.h                               |   5 +-
 include/linux/torture.h                            |   8 +-
 kernel/cpu.c                                       |  13 +-
 kernel/locking/locktorture.c                       | 214 +++++++++++++-----
 kernel/rcu/rcu.h                                   |  17 +-
 kernel/rcu/rcu_segcblist.c                         |   4 +-
 kernel/rcu/rcutorture.c                            |  37 +++-
 kernel/rcu/refscale.c                              |   6 +-
 kernel/rcu/srcutiny.c                              |   1 +
 kernel/rcu/srcutree.c                              |  74 +++++--
 kernel/rcu/tasks.h                                 |  11 +-
 kernel/rcu/tiny.c                                  |   1 +
 kernel/rcu/tree.c                                  | 242 +++++++++++++++------
 kernel/rcu/tree.h                                  |   4 +
 kernel/rcu/tree_exp.h                              |   6 +-
 kernel/rcu/tree_stall.h                            | 135 ++++++++----
 kernel/rcu/update.c                                |   9 +-
 kernel/torture.c                                   |  75 +++----
 mm/slab_common.c                                   |  41 +---
 mm/util.c                                          |   4 +-
 scripts/checkpatch.pl                              |   9 -
 .../testing/selftests/rcutorture/bin/functions.sh  |  29 +++
 .../selftests/rcutorture/bin/kvm-recheck.sh        |   2 +-
 tools/testing/selftests/rcutorture/bin/kvm.sh      |  17 +-
 .../selftests/rcutorture/bin/parse-console.sh      |   9 +-
 tools/testing/selftests/rcutorture/bin/torture.sh  |   2 +-
 .../selftests/rcutorture/configs/rcu/TRACE02       |   1 +
 45 files changed, 809 insertions(+), 351 deletions(-)
 create mode 100644 include/linux/rcu_notifier.h
 mode change 100644 => 100755 tools/testing/selftests/rcutorture/bin/functions.sh
