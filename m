Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2957BE955
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 20:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377795AbjJISbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 14:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377561AbjJISbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 14:31:14 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A178D9D
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 11:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696876271; x=1728412271;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=VdXncW0U9jjlVhSTWMHhcTrn4bvbd2/U7FP3oYFw/SE=;
  b=D3RwmSn/HSYBEBgxjOa+POxS8mUxviVt7z0Tk0BWiXBX82oO0+jFKhCA
   sG0JwC/QcKL4NgwgCEqZCVX2wU4QbsnRccCKEs5yO+R2hwl+ka7vNHKJr
   FhZtxp3ASPfGl0CVYFkkfU9lo1wDdv568vOBkSRDOcqcYjZ9+7UfzajvL
   q5NVoAfQ/wKpVHal+29l0VNah1lwpURF1VMBDr2P5A12MK2KyxXdQTya6
   i7L1Ux7acgYcgXsXIpQhzHMawgPnTfpwDbY2sY470ZPE6Kbx5Rhm6G1Al
   nkHLvPQ7/9CMfznM1nRSkenXBLhsTl5Sdu2yTOtDNJOPYn5IKobb+GGKB
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="470477909"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="470477909"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 11:31:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="823428007"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="823428007"
Received: from lkp-server02.sh.intel.com (HELO 4ed589823ba4) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 09 Oct 2023 11:31:09 -0700
Received: from kbuild by 4ed589823ba4 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qpv23-0000W6-0O;
        Mon, 09 Oct 2023 18:31:07 +0000
Date:   Tue, 10 Oct 2023 02:30:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: kernel/fork.c:1134: warning: Function parameter or member 'mm' not
 described in 'set_mm_exe_file'
Message-ID: <202310100237.RjecPfNo-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   94f6f0550c625fab1f373bb86a6669b45e9748b3
commit: b1fbfcb4a20949df08dd995927cdc5ad220c128d kbuild: make single target builds even faster
date:   3 years, 11 months ago
config: openrisc-allnoconfig (https://download.01.org/0day-ci/archive/20231010/202310100237.RjecPfNo-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 12.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231010/202310100237.RjecPfNo-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310100237.RjecPfNo-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/fork.c:1134: warning: Function parameter or member 'mm' not described in 'set_mm_exe_file'
>> kernel/fork.c:1134: warning: Function parameter or member 'new_exe_file' not described in 'set_mm_exe_file'
>> kernel/fork.c:1158: warning: Function parameter or member 'mm' not described in 'get_mm_exe_file'
>> kernel/fork.c:1178: warning: Function parameter or member 'task' not described in 'get_task_exe_file'
>> kernel/fork.c:1203: warning: Function parameter or member 'task' not described in 'get_task_mm'
--
>> kernel/reboot.c:214: warning: Function parameter or member 'cmd' not described in 'do_kernel_restart'
--
>> kernel/irq_work.c:53:13: warning: no previous prototype for 'arch_irq_work_raise' [-Wmissing-prototypes]
      53 | void __weak arch_irq_work_raise(void)
         |             ^~~~~~~~~~~~~~~~~~~
--
>> kernel/stacktrace.c:139: warning: Function parameter or member 'tsk' not described in 'stack_trace_save_tsk'
>> kernel/stacktrace.c:139: warning: Excess function parameter 'task' description in 'stack_trace_save_tsk'
--
>> lib/argv_split.c:36: warning: Function parameter or member 'argv' not described in 'argv_free'
--
>> lib/scatterlist.c:270: warning: Function parameter or member 'first_chunk' not described in '__sg_alloc_table'
>> lib/scatterlist.c:676: warning: Function parameter or member 'flags' not described in 'sg_miter_start'
--
>> lib/hweight.c:14: warning: Function parameter or member 'w' not described in '__sw_hweight32'
   lib/hweight.c:14: warning: Excess function parameter 'x' description in '__sw_hweight32'
--
>> kernel/irq/irqdomain.c:105: warning: Function parameter or member 'fwnode' not described in 'irq_domain_free_fwnode'
>> kernel/irq/irqdomain.c:930: warning: Function parameter or member 'd' not described in 'irq_domain_xlate_onecell'
>> kernel/irq/irqdomain.c:930: warning: Function parameter or member 'ctrlr' not described in 'irq_domain_xlate_onecell'
>> kernel/irq/irqdomain.c:930: warning: Function parameter or member 'intspec' not described in 'irq_domain_xlate_onecell'
>> kernel/irq/irqdomain.c:930: warning: Function parameter or member 'intsize' not described in 'irq_domain_xlate_onecell'
>> kernel/irq/irqdomain.c:930: warning: Function parameter or member 'out_hwirq' not described in 'irq_domain_xlate_onecell'
>> kernel/irq/irqdomain.c:930: warning: Function parameter or member 'out_type' not described in 'irq_domain_xlate_onecell'
>> kernel/irq/irqdomain.c:949: warning: Function parameter or member 'd' not described in 'irq_domain_xlate_twocell'
>> kernel/irq/irqdomain.c:949: warning: Function parameter or member 'ctrlr' not described in 'irq_domain_xlate_twocell'
>> kernel/irq/irqdomain.c:949: warning: Function parameter or member 'intspec' not described in 'irq_domain_xlate_twocell'
>> kernel/irq/irqdomain.c:949: warning: Function parameter or member 'intsize' not described in 'irq_domain_xlate_twocell'
>> kernel/irq/irqdomain.c:949: warning: Function parameter or member 'out_hwirq' not described in 'irq_domain_xlate_twocell'
>> kernel/irq/irqdomain.c:949: warning: Function parameter or member 'out_type' not described in 'irq_domain_xlate_twocell'
>> kernel/irq/irqdomain.c:972: warning: Function parameter or member 'd' not described in 'irq_domain_xlate_onetwocell'
>> kernel/irq/irqdomain.c:972: warning: Function parameter or member 'ctrlr' not described in 'irq_domain_xlate_onetwocell'
>> kernel/irq/irqdomain.c:972: warning: Function parameter or member 'intspec' not described in 'irq_domain_xlate_onetwocell'
>> kernel/irq/irqdomain.c:972: warning: Function parameter or member 'intsize' not described in 'irq_domain_xlate_onetwocell'
>> kernel/irq/irqdomain.c:972: warning: Function parameter or member 'out_hwirq' not described in 'irq_domain_xlate_onetwocell'
>> kernel/irq/irqdomain.c:972: warning: Function parameter or member 'out_type' not described in 'irq_domain_xlate_onetwocell'
>> kernel/irq/irqdomain.c:1001: warning: Function parameter or member 'd' not described in 'irq_domain_translate_twocell'
   kernel/irq/irqdomain.c:1001: warning: Function parameter or member 'fwspec' not described in 'irq_domain_translate_twocell'
   kernel/irq/irqdomain.c:1001: warning: Function parameter or member 'out_hwirq' not described in 'irq_domain_translate_twocell'
   kernel/irq/irqdomain.c:1001: warning: Function parameter or member 'out_type' not described in 'irq_domain_translate_twocell'
   kernel/irq/irqdomain.c:1580: warning: Function parameter or member 'domain' not described in 'irq_domain_alloc_irqs_parent'
   kernel/irq/irqdomain.c:1599: warning: Function parameter or member 'domain' not described in 'irq_domain_free_irqs_parent'
--
   kernel/sched/fair.c:5095:6: warning: no previous prototype for 'init_cfs_bandwidth' [-Wmissing-prototypes]
    5095 | void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b) {}
         |      ^~~~~~~~~~~~~~~~~~
>> kernel/sched/fair.c:10384:6: warning: no previous prototype for 'free_fair_sched_group' [-Wmissing-prototypes]
   10384 | void free_fair_sched_group(struct task_group *tg) { }
         |      ^~~~~~~~~~~~~~~~~~~~~
>> kernel/sched/fair.c:10386:5: warning: no previous prototype for 'alloc_fair_sched_group' [-Wmissing-prototypes]
   10386 | int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)
         |     ^~~~~~~~~~~~~~~~~~~~~~
   kernel/sched/fair.c:10391:6: warning: no previous prototype for 'online_fair_sched_group' [-Wmissing-prototypes]
   10391 | void online_fair_sched_group(struct task_group *tg) { }
         |      ^~~~~~~~~~~~~~~~~~~~~~~
>> kernel/sched/fair.c:10393:6: warning: no previous prototype for 'unregister_fair_sched_group' [-Wmissing-prototypes]
   10393 | void unregister_fair_sched_group(struct task_group *tg) { }
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
--
>> kernel/time/tick-broadcast.c:884: warning: Function parameter or member 'bc' not described in 'tick_broadcast_setup_oneshot'
--
   kernel/time/timekeeping.c:403: warning: Function parameter or member 'tkf' not described in 'update_fast_timekeeper'
   kernel/time/timekeeping.c:452: warning: Function parameter or member 'tkf' not described in '__ktime_get_fast_ns'
   kernel/time/timekeeping.c:585: warning: Function parameter or member 'nb' not described in 'pvclock_gtod_register_notifier'
   kernel/time/timekeeping.c:604: warning: Function parameter or member 'nb' not described in 'pvclock_gtod_unregister_notifier'
   kernel/time/timekeeping.c:698: warning: Function parameter or member 'tk' not described in 'timekeeping_forward_now'
   kernel/time/timekeeping.c:1274: warning: Function parameter or member 'ts' not described in 'timekeeping_inject_offset'
   kernel/time/timekeeping.c:1274: warning: Excess function parameter 'tv' description in 'timekeeping_inject_offset'
   kernel/time/timekeeping.c:1350: warning: Function parameter or member 'tk' not described in '__timekeeping_set_tai_offset'
   kernel/time/timekeeping.c:1350: warning: Function parameter or member 'tai_offset' not described in '__timekeeping_set_tai_offset'
   kernel/time/timekeeping.c:1361: warning: Function parameter or member 'data' not described in 'change_clocksource'
   kernel/time/timekeeping.c:1486: warning: Function parameter or member 'ts' not described in 'read_persistent_clock64'
   kernel/time/timekeeping.c:1506: warning: Function parameter or member 'wall_time' not described in 'read_persistent_wall_and_boot_offset'
   kernel/time/timekeeping.c:1506: warning: Function parameter or member 'boot_offset' not described in 'read_persistent_wall_and_boot_offset'
   kernel/time/timekeeping.c:1589: warning: Function parameter or member 'tk' not described in '__timekeeping_inject_sleeptime'
   kernel/time/timekeeping.c:1962: warning: Function parameter or member 'tk' not described in 'accumulate_nsecs_to_secs'
   kernel/time/timekeeping.c:2012: warning: Function parameter or member 'tk' not described in 'logarithmic_accumulation'
   kernel/time/timekeeping.c:2012: warning: Function parameter or member 'offset' not described in 'logarithmic_accumulation'
   kernel/time/timekeeping.c:2012: warning: Function parameter or member 'shift' not described in 'logarithmic_accumulation'
   kernel/time/timekeeping.c:2012: warning: Function parameter or member 'clock_set' not described in 'logarithmic_accumulation'
   kernel/time/timekeeping.c:2248: warning: Function parameter or member 'txc' not described in 'timekeeping_validate_timex'
>> kernel/time/timekeeping.c:2314: warning: Function parameter or member 'txc' not described in 'do_adjtimex'
>> kernel/time/timekeeping.c:2378: warning: Function parameter or member 'phase_ts' not described in 'hardpps'
>> kernel/time/timekeeping.c:2378: warning: Function parameter or member 'raw_ts' not described in 'hardpps'


vim +1134 kernel/fork.c

a1b2289cef92ef Sherry Yang           2017-10-03  1121  
90f31d0ea88880 Konstantin Khlebnikov 2015-04-16  1122  /**
90f31d0ea88880 Konstantin Khlebnikov 2015-04-16  1123   * set_mm_exe_file - change a reference to the mm's executable file
90f31d0ea88880 Konstantin Khlebnikov 2015-04-16  1124   *
90f31d0ea88880 Konstantin Khlebnikov 2015-04-16  1125   * This changes mm's executable file (shown as symlink /proc/[pid]/exe).
90f31d0ea88880 Konstantin Khlebnikov 2015-04-16  1126   *
6e399cd144d850 Davidlohr Bueso       2015-04-16  1127   * Main users are mmput() and sys_execve(). Callers prevent concurrent
6e399cd144d850 Davidlohr Bueso       2015-04-16  1128   * invocations: in mmput() nobody alive left, in execve task is single
6e399cd144d850 Davidlohr Bueso       2015-04-16  1129   * threaded. sys_prctl(PR_SET_MM_MAP/EXE_FILE) also needs to set the
6e399cd144d850 Davidlohr Bueso       2015-04-16  1130   * mm->exe_file, but does so without using set_mm_exe_file() in order
6e399cd144d850 Davidlohr Bueso       2015-04-16  1131   * to do avoid the need for any locks.
90f31d0ea88880 Konstantin Khlebnikov 2015-04-16  1132   */
3864601387cf41 Jiri Slaby            2011-05-26  1133  void set_mm_exe_file(struct mm_struct *mm, struct file *new_exe_file)
3864601387cf41 Jiri Slaby            2011-05-26 @1134  {
6e399cd144d850 Davidlohr Bueso       2015-04-16  1135  	struct file *old_exe_file;
6e399cd144d850 Davidlohr Bueso       2015-04-16  1136  
6e399cd144d850 Davidlohr Bueso       2015-04-16  1137  	/*
6e399cd144d850 Davidlohr Bueso       2015-04-16  1138  	 * It is safe to dereference the exe_file without RCU as
6e399cd144d850 Davidlohr Bueso       2015-04-16  1139  	 * this function is only called if nobody else can access
6e399cd144d850 Davidlohr Bueso       2015-04-16  1140  	 * this mm -- see comment above for justification.
6e399cd144d850 Davidlohr Bueso       2015-04-16  1141  	 */
6e399cd144d850 Davidlohr Bueso       2015-04-16  1142  	old_exe_file = rcu_dereference_raw(mm->exe_file);
90f31d0ea88880 Konstantin Khlebnikov 2015-04-16  1143  
3864601387cf41 Jiri Slaby            2011-05-26  1144  	if (new_exe_file)
3864601387cf41 Jiri Slaby            2011-05-26  1145  		get_file(new_exe_file);
90f31d0ea88880 Konstantin Khlebnikov 2015-04-16  1146  	rcu_assign_pointer(mm->exe_file, new_exe_file);
90f31d0ea88880 Konstantin Khlebnikov 2015-04-16  1147  	if (old_exe_file)
90f31d0ea88880 Konstantin Khlebnikov 2015-04-16  1148  		fput(old_exe_file);
3864601387cf41 Jiri Slaby            2011-05-26  1149  }
3864601387cf41 Jiri Slaby            2011-05-26  1150  
90f31d0ea88880 Konstantin Khlebnikov 2015-04-16  1151  /**
90f31d0ea88880 Konstantin Khlebnikov 2015-04-16  1152   * get_mm_exe_file - acquire a reference to the mm's executable file
90f31d0ea88880 Konstantin Khlebnikov 2015-04-16  1153   *
90f31d0ea88880 Konstantin Khlebnikov 2015-04-16  1154   * Returns %NULL if mm has no associated executable file.
90f31d0ea88880 Konstantin Khlebnikov 2015-04-16  1155   * User must release file via fput().
90f31d0ea88880 Konstantin Khlebnikov 2015-04-16  1156   */
3864601387cf41 Jiri Slaby            2011-05-26  1157  struct file *get_mm_exe_file(struct mm_struct *mm)
3864601387cf41 Jiri Slaby            2011-05-26 @1158  {
3864601387cf41 Jiri Slaby            2011-05-26  1159  	struct file *exe_file;
3864601387cf41 Jiri Slaby            2011-05-26  1160  
90f31d0ea88880 Konstantin Khlebnikov 2015-04-16  1161  	rcu_read_lock();
90f31d0ea88880 Konstantin Khlebnikov 2015-04-16  1162  	exe_file = rcu_dereference(mm->exe_file);
90f31d0ea88880 Konstantin Khlebnikov 2015-04-16  1163  	if (exe_file && !get_file_rcu(exe_file))
90f31d0ea88880 Konstantin Khlebnikov 2015-04-16  1164  		exe_file = NULL;
90f31d0ea88880 Konstantin Khlebnikov 2015-04-16  1165  	rcu_read_unlock();
3864601387cf41 Jiri Slaby            2011-05-26  1166  	return exe_file;
3864601387cf41 Jiri Slaby            2011-05-26  1167  }
11163348a23cdb Davidlohr Bueso       2015-04-16  1168  EXPORT_SYMBOL(get_mm_exe_file);
3864601387cf41 Jiri Slaby            2011-05-26  1169  
cd81a9170e69e0 Mateusz Guzik         2016-08-23  1170  /**
cd81a9170e69e0 Mateusz Guzik         2016-08-23  1171   * get_task_exe_file - acquire a reference to the task's executable file
cd81a9170e69e0 Mateusz Guzik         2016-08-23  1172   *
cd81a9170e69e0 Mateusz Guzik         2016-08-23  1173   * Returns %NULL if task's mm (if any) has no associated executable file or
cd81a9170e69e0 Mateusz Guzik         2016-08-23  1174   * this is a kernel thread with borrowed mm (see the comment above get_task_mm).
cd81a9170e69e0 Mateusz Guzik         2016-08-23  1175   * User must release file via fput().
cd81a9170e69e0 Mateusz Guzik         2016-08-23  1176   */
cd81a9170e69e0 Mateusz Guzik         2016-08-23  1177  struct file *get_task_exe_file(struct task_struct *task)
cd81a9170e69e0 Mateusz Guzik         2016-08-23 @1178  {
cd81a9170e69e0 Mateusz Guzik         2016-08-23  1179  	struct file *exe_file = NULL;
cd81a9170e69e0 Mateusz Guzik         2016-08-23  1180  	struct mm_struct *mm;
cd81a9170e69e0 Mateusz Guzik         2016-08-23  1181  
cd81a9170e69e0 Mateusz Guzik         2016-08-23  1182  	task_lock(task);
cd81a9170e69e0 Mateusz Guzik         2016-08-23  1183  	mm = task->mm;
cd81a9170e69e0 Mateusz Guzik         2016-08-23  1184  	if (mm) {
cd81a9170e69e0 Mateusz Guzik         2016-08-23  1185  		if (!(task->flags & PF_KTHREAD))
cd81a9170e69e0 Mateusz Guzik         2016-08-23  1186  			exe_file = get_mm_exe_file(mm);
cd81a9170e69e0 Mateusz Guzik         2016-08-23  1187  	}
cd81a9170e69e0 Mateusz Guzik         2016-08-23  1188  	task_unlock(task);
cd81a9170e69e0 Mateusz Guzik         2016-08-23  1189  	return exe_file;
cd81a9170e69e0 Mateusz Guzik         2016-08-23  1190  }
cd81a9170e69e0 Mateusz Guzik         2016-08-23  1191  EXPORT_SYMBOL(get_task_exe_file);
3864601387cf41 Jiri Slaby            2011-05-26  1192  
^1da177e4c3f41 Linus Torvalds        2005-04-16  1193  /**
^1da177e4c3f41 Linus Torvalds        2005-04-16  1194   * get_task_mm - acquire a reference to the task's mm
^1da177e4c3f41 Linus Torvalds        2005-04-16  1195   *
246bb0b1deb297 Oleg Nesterov         2008-07-25  1196   * Returns %NULL if the task has no mm.  Checks PF_KTHREAD (meaning
^1da177e4c3f41 Linus Torvalds        2005-04-16  1197   * this kernel workthread has transiently adopted a user mm with use_mm,
^1da177e4c3f41 Linus Torvalds        2005-04-16  1198   * to do its AIO) is not set and if so returns a reference to it, after
^1da177e4c3f41 Linus Torvalds        2005-04-16  1199   * bumping up the use count.  User must release the mm via mmput()
^1da177e4c3f41 Linus Torvalds        2005-04-16  1200   * after use.  Typically used by /proc and ptrace.
^1da177e4c3f41 Linus Torvalds        2005-04-16  1201   */
^1da177e4c3f41 Linus Torvalds        2005-04-16  1202  struct mm_struct *get_task_mm(struct task_struct *task)
^1da177e4c3f41 Linus Torvalds        2005-04-16 @1203  {
^1da177e4c3f41 Linus Torvalds        2005-04-16  1204  	struct mm_struct *mm;
^1da177e4c3f41 Linus Torvalds        2005-04-16  1205  
^1da177e4c3f41 Linus Torvalds        2005-04-16  1206  	task_lock(task);
^1da177e4c3f41 Linus Torvalds        2005-04-16  1207  	mm = task->mm;
^1da177e4c3f41 Linus Torvalds        2005-04-16  1208  	if (mm) {
246bb0b1deb297 Oleg Nesterov         2008-07-25  1209  		if (task->flags & PF_KTHREAD)
^1da177e4c3f41 Linus Torvalds        2005-04-16  1210  			mm = NULL;
^1da177e4c3f41 Linus Torvalds        2005-04-16  1211  		else
3fce371bfac2be Vegard Nossum         2017-02-27  1212  			mmget(mm);
^1da177e4c3f41 Linus Torvalds        2005-04-16  1213  	}
^1da177e4c3f41 Linus Torvalds        2005-04-16  1214  	task_unlock(task);
^1da177e4c3f41 Linus Torvalds        2005-04-16  1215  	return mm;
^1da177e4c3f41 Linus Torvalds        2005-04-16  1216  }
^1da177e4c3f41 Linus Torvalds        2005-04-16  1217  EXPORT_SYMBOL_GPL(get_task_mm);
^1da177e4c3f41 Linus Torvalds        2005-04-16  1218  

:::::: The code at line 1134 was first introduced by commit
:::::: 3864601387cf4196371e3c1897fdffa5228296f9 mm: extract exe_file handling from procfs

:::::: TO: Jiri Slaby <jslaby@suse.cz>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
