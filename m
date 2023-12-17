Return-Path: <linux-kernel+bounces-2778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 787D28161B4
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 20:04:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2528BB21BF4
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 19:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8D347F79;
	Sun, 17 Dec 2023 19:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KxTcwcJX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C66747F5E
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 19:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702839827; x=1734375827;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=48+XTY2gkrs6P0y3epjLvtCCTGNI4fb61l7Mfuy0DFs=;
  b=KxTcwcJXYMrnJtDnFWbuBS4/O25hCkkn19hVDEdLOzg0/uXX0IXbCdnb
   vmG0875As/Pc1lAUNS9mI4cw6oSJkFShhntsfO1ZXZP2pzRmxSQrzdGds
   J3Ir/AYlWT2XeTaktB1YcHhVB8x6AY0StaDIzX169YkVCYO18FrOb+7i8
   bOXch+EWlfcLg3lM/a1WGSDbqaQ221FY8Tgg/Po1OGnEU1CxQPwXDwUdn
   VPNssod1FilTQl3me4+eJXfWrUmOTcgywi4tJkBmD65W2a7GeC1+lySUj
   G0Wre8Gy9E3mdx1dGjBECYgf511OxtJEQB088+5p5cbGlvnxmXBDohHkJ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="16984344"
X-IronPort-AV: E=Sophos;i="6.04,284,1695711600"; 
   d="scan'208";a="16984344"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2023 11:03:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="775333238"
X-IronPort-AV: E=Sophos;i="6.04,284,1695711600"; 
   d="scan'208";a="775333238"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 17 Dec 2023 11:03:43 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rEwQP-0003LC-2G;
	Sun, 17 Dec 2023 19:03:41 +0000
Date: Mon, 18 Dec 2023 03:02:50 +0800
From: kernel test robot <lkp@intel.com>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Nick Desaulniers <ndesaulniers@google.com>
Subject: ERROR: modpost: vmlinux: local symbol 'mutex_lock' was exported
Message-ID: <202312180253.RvcUMkLX-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3b8a9b2e6809d281890dd0a1102dc14d2cd11caf
commit: 6d62b1c46b1e6e1686a0cf6617c96c80d4ab5cd5 modpost: check static EXPORT_SYMBOL* by modpost again
date:   6 months ago
config: riscv-randconfig-r004-20230629 (https://download.01.org/0day-ci/archive/20231218/202312180253.RvcUMkLX-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231218/202312180253.RvcUMkLX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312180253.RvcUMkLX-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

ERROR: modpost: vmlinux: local symbol '__tracepoint_sched_util_est_cfs_tp' was exported
ERROR: modpost: vmlinux: local symbol '__traceiter_sched_util_est_cfs_tp' was exported
ERROR: modpost: vmlinux: local symbol '__SCK__tp_func_sched_util_est_cfs_tp' was exported
ERROR: modpost: vmlinux: local symbol '__tracepoint_sched_util_est_se_tp' was exported
ERROR: modpost: vmlinux: local symbol '__traceiter_sched_util_est_se_tp' was exported
ERROR: modpost: vmlinux: local symbol '__SCK__tp_func_sched_util_est_se_tp' was exported
ERROR: modpost: vmlinux: local symbol '__tracepoint_sched_update_nr_running_tp' was exported
ERROR: modpost: vmlinux: local symbol '__traceiter_sched_update_nr_running_tp' was exported
ERROR: modpost: vmlinux: local symbol '__SCK__tp_func_sched_update_nr_running_tp' was exported
ERROR: modpost: vmlinux: local symbol 'migrate_disable' was exported
ERROR: modpost: vmlinux: local symbol 'migrate_enable' was exported
ERROR: modpost: vmlinux: local symbol 'set_cpus_allowed_ptr' was exported
ERROR: modpost: vmlinux: local symbol 'kick_process' was exported
ERROR: modpost: vmlinux: local symbol 'wake_up_process' was exported
ERROR: modpost: vmlinux: local symbol 'single_task_running' was exported
ERROR: modpost: vmlinux: local symbol 'kstat' was exported
ERROR: modpost: vmlinux: local symbol 'kernel_cpustat' was exported
ERROR: modpost: vmlinux: local symbol 'schedule' was exported
ERROR: modpost: vmlinux: local symbol 'preempt_schedule' was exported
ERROR: modpost: vmlinux: local symbol 'preempt_schedule_notrace' was exported
ERROR: modpost: vmlinux: local symbol 'default_wake_function' was exported
ERROR: modpost: vmlinux: local symbol 'set_user_nice' was exported
ERROR: modpost: vmlinux: local symbol 'sched_setattr_nocheck' was exported
ERROR: modpost: vmlinux: local symbol 'sched_set_fifo' was exported
ERROR: modpost: vmlinux: local symbol 'sched_set_fifo_low' was exported
ERROR: modpost: vmlinux: local symbol 'sched_set_normal' was exported
ERROR: modpost: vmlinux: local symbol '__cond_resched_lock' was exported
ERROR: modpost: vmlinux: local symbol '__cond_resched_rwlock_read' was exported
ERROR: modpost: vmlinux: local symbol '__cond_resched_rwlock_write' was exported
ERROR: modpost: vmlinux: local symbol 'yield' was exported
ERROR: modpost: vmlinux: local symbol 'yield_to' was exported
ERROR: modpost: vmlinux: local symbol 'io_schedule_timeout' was exported
ERROR: modpost: vmlinux: local symbol 'io_schedule' was exported
ERROR: modpost: vmlinux: local symbol 'sched_show_task' was exported
ERROR: modpost: vmlinux: local symbol 'play_idle_precise' was exported
ERROR: modpost: vmlinux: local symbol 'task_cputime_adjusted' was exported
ERROR: modpost: vmlinux: local symbol 'sched_clock' was exported
ERROR: modpost: vmlinux: local symbol 'avenrun' was exported
ERROR: modpost: vmlinux: local symbol 'complete' was exported
ERROR: modpost: vmlinux: local symbol 'complete_all' was exported
ERROR: modpost: vmlinux: local symbol 'wait_for_completion' was exported
ERROR: modpost: vmlinux: local symbol 'wait_for_completion_timeout' was exported
ERROR: modpost: vmlinux: local symbol 'wait_for_completion_io' was exported
ERROR: modpost: vmlinux: local symbol 'wait_for_completion_io_timeout' was exported
ERROR: modpost: vmlinux: local symbol 'wait_for_completion_interruptible' was exported
ERROR: modpost: vmlinux: local symbol 'wait_for_completion_interruptible_timeout' was exported
ERROR: modpost: vmlinux: local symbol 'wait_for_completion_killable' was exported
ERROR: modpost: vmlinux: local symbol 'wait_for_completion_state' was exported
ERROR: modpost: vmlinux: local symbol 'wait_for_completion_killable_timeout' was exported
ERROR: modpost: vmlinux: local symbol 'try_wait_for_completion' was exported
ERROR: modpost: vmlinux: local symbol 'completion_done' was exported
ERROR: modpost: vmlinux: local symbol '__init_swait_queue_head' was exported
ERROR: modpost: vmlinux: local symbol 'swake_up_locked' was exported
ERROR: modpost: vmlinux: local symbol 'swake_up_one' was exported
ERROR: modpost: vmlinux: local symbol 'swake_up_all' was exported
ERROR: modpost: vmlinux: local symbol 'prepare_to_swait_exclusive' was exported
ERROR: modpost: vmlinux: local symbol 'prepare_to_swait_event' was exported
ERROR: modpost: vmlinux: local symbol 'finish_swait' was exported
ERROR: modpost: vmlinux: local symbol 'bit_waitqueue' was exported
ERROR: modpost: vmlinux: local symbol 'wake_bit_function' was exported
ERROR: modpost: vmlinux: local symbol '__wait_on_bit' was exported
ERROR: modpost: vmlinux: local symbol 'out_of_line_wait_on_bit' was exported
ERROR: modpost: vmlinux: local symbol 'out_of_line_wait_on_bit_timeout' was exported
ERROR: modpost: vmlinux: local symbol '__wait_on_bit_lock' was exported
ERROR: modpost: vmlinux: local symbol 'out_of_line_wait_on_bit_lock' was exported
ERROR: modpost: vmlinux: local symbol '__wake_up_bit' was exported
ERROR: modpost: vmlinux: local symbol 'wake_up_bit' was exported
ERROR: modpost: vmlinux: local symbol '__var_waitqueue' was exported
ERROR: modpost: vmlinux: local symbol 'init_wait_var_entry' was exported
ERROR: modpost: vmlinux: local symbol 'wake_up_var' was exported
ERROR: modpost: vmlinux: local symbol 'bit_wait' was exported
ERROR: modpost: vmlinux: local symbol 'bit_wait_io' was exported
ERROR: modpost: vmlinux: local symbol 'bit_wait_timeout' was exported
ERROR: modpost: vmlinux: local symbol 'bit_wait_io_timeout' was exported
ERROR: modpost: vmlinux: local symbol '__init_waitqueue_head' was exported
ERROR: modpost: vmlinux: local symbol 'add_wait_queue' was exported
ERROR: modpost: vmlinux: local symbol 'add_wait_queue_exclusive' was exported
ERROR: modpost: vmlinux: local symbol 'add_wait_queue_priority' was exported
ERROR: modpost: vmlinux: local symbol 'remove_wait_queue' was exported
ERROR: modpost: vmlinux: local symbol '__wake_up' was exported
ERROR: modpost: vmlinux: local symbol '__wake_up_locked' was exported
ERROR: modpost: vmlinux: local symbol '__wake_up_locked_key' was exported
ERROR: modpost: vmlinux: local symbol '__wake_up_locked_key_bookmark' was exported
ERROR: modpost: vmlinux: local symbol '__wake_up_sync_key' was exported
ERROR: modpost: vmlinux: local symbol '__wake_up_locked_sync_key' was exported
ERROR: modpost: vmlinux: local symbol '__wake_up_sync' was exported
ERROR: modpost: vmlinux: local symbol 'prepare_to_wait' was exported
ERROR: modpost: vmlinux: local symbol 'prepare_to_wait_exclusive' was exported
ERROR: modpost: vmlinux: local symbol 'init_wait_entry' was exported
ERROR: modpost: vmlinux: local symbol 'prepare_to_wait_event' was exported
ERROR: modpost: vmlinux: local symbol 'do_wait_intr' was exported
ERROR: modpost: vmlinux: local symbol 'do_wait_intr_irq' was exported
ERROR: modpost: vmlinux: local symbol 'finish_wait' was exported
ERROR: modpost: vmlinux: local symbol 'autoremove_wake_function' was exported
ERROR: modpost: vmlinux: local symbol 'wait_woken' was exported
ERROR: modpost: vmlinux: local symbol 'woken_wake_function' was exported
ERROR: modpost: vmlinux: local symbol 'psi_memstall_enter' was exported
ERROR: modpost: vmlinux: local symbol 'psi_memstall_leave' was exported
ERROR: modpost: vmlinux: local symbol '__mutex_init' was exported
ERROR: modpost: vmlinux: local symbol 'mutex_is_locked' was exported
>> ERROR: modpost: vmlinux: local symbol 'mutex_lock' was exported
ERROR: modpost: vmlinux: local symbol 'mutex_unlock' was exported
ERROR: modpost: vmlinux: local symbol 'ww_mutex_unlock' was exported
ERROR: modpost: vmlinux: local symbol 'ww_mutex_trylock' was exported
>> ERROR: modpost: vmlinux: local symbol 'mutex_lock_interruptible' was exported
>> ERROR: modpost: vmlinux: local symbol 'mutex_lock_killable' was exported
>> ERROR: modpost: vmlinux: local symbol 'mutex_lock_io' was exported
ERROR: modpost: vmlinux: local symbol 'mutex_trylock' was exported
ERROR: modpost: vmlinux: local symbol 'ww_mutex_lock' was exported
ERROR: modpost: vmlinux: local symbol 'ww_mutex_lock_interruptible' was exported
ERROR: modpost: vmlinux: local symbol 'atomic_dec_and_mutex_lock' was exported
ERROR: modpost: vmlinux: local symbol 'down' was exported
ERROR: modpost: vmlinux: local symbol 'down_interruptible' was exported
ERROR: modpost: vmlinux: local symbol 'down_killable' was exported
ERROR: modpost: vmlinux: local symbol 'down_trylock' was exported
ERROR: modpost: vmlinux: local symbol 'down_timeout' was exported
ERROR: modpost: vmlinux: local symbol 'up' was exported
ERROR: modpost: vmlinux: local symbol '__init_rwsem' was exported
ERROR: modpost: vmlinux: local symbol 'down_read' was exported
ERROR: modpost: vmlinux: local symbol 'down_read_interruptible' was exported
ERROR: modpost: vmlinux: local symbol 'down_read_killable' was exported
ERROR: modpost: vmlinux: local symbol 'down_read_trylock' was exported
ERROR: modpost: vmlinux: local symbol 'down_write' was exported
ERROR: modpost: vmlinux: local symbol 'down_write_killable' was exported
ERROR: modpost: vmlinux: local symbol 'down_write_trylock' was exported
ERROR: modpost: vmlinux: local symbol 'up_read' was exported
ERROR: modpost: vmlinux: local symbol 'up_write' was exported
ERROR: modpost: vmlinux: local symbol 'downgrade_write' was exported
ERROR: modpost: vmlinux: local symbol '__percpu_init_rwsem' was exported
ERROR: modpost: vmlinux: local symbol 'percpu_free_rwsem' was exported
ERROR: modpost: vmlinux: local symbol '__percpu_down_read' was exported
ERROR: modpost: vmlinux: local symbol 'percpu_is_read_locked' was exported
ERROR: modpost: vmlinux: local symbol 'percpu_down_write' was exported
ERROR: modpost: vmlinux: local symbol 'percpu_up_write' was exported
ERROR: modpost: vmlinux: local symbol 'mutex_destroy' was exported
ERROR: modpost: vmlinux: local symbol '__mmiowb_state' was exported
ERROR: modpost: vmlinux: local symbol '_raw_spin_trylock' was exported
ERROR: modpost: vmlinux: local symbol '_raw_spin_trylock_bh' was exported
ERROR: modpost: vmlinux: local symbol '_raw_spin_lock' was exported
ERROR: modpost: vmlinux: local symbol '_raw_spin_lock_irqsave' was exported
ERROR: modpost: vmlinux: local symbol '_raw_spin_lock_irq' was exported
ERROR: modpost: vmlinux: local symbol '_raw_spin_lock_bh' was exported
ERROR: modpost: vmlinux: local symbol '_raw_spin_unlock' was exported
ERROR: modpost: vmlinux: local symbol '_raw_spin_unlock_irqrestore' was exported
ERROR: modpost: vmlinux: local symbol '_raw_spin_unlock_irq' was exported
ERROR: modpost: vmlinux: local symbol '_raw_spin_unlock_bh' was exported
ERROR: modpost: vmlinux: local symbol '_raw_read_trylock' was exported
ERROR: modpost: vmlinux: local symbol '_raw_read_lock' was exported
ERROR: modpost: vmlinux: local symbol '_raw_read_lock_irqsave' was exported
ERROR: modpost: vmlinux: local symbol '_raw_read_lock_irq' was exported
ERROR: modpost: vmlinux: local symbol '_raw_read_lock_bh' was exported
ERROR: modpost: vmlinux: local symbol '_raw_read_unlock' was exported
ERROR: modpost: vmlinux: local symbol '_raw_read_unlock_irqrestore' was exported
ERROR: modpost: vmlinux: local symbol '_raw_read_unlock_irq' was exported
ERROR: modpost: vmlinux: local symbol '_raw_read_unlock_bh' was exported
ERROR: modpost: vmlinux: local symbol '_raw_write_trylock' was exported
ERROR: modpost: vmlinux: local symbol '_raw_write_lock' was exported
ERROR: modpost: vmlinux: local symbol '_raw_write_lock_nested' was exported
ERROR: modpost: vmlinux: local symbol '_raw_write_lock_irqsave' was exported
ERROR: modpost: vmlinux: local symbol '_raw_write_lock_irq' was exported
ERROR: modpost: vmlinux: local symbol '_raw_write_lock_bh' was exported
ERROR: modpost: vmlinux: local symbol '_raw_write_unlock' was exported
ERROR: modpost: vmlinux: local symbol '_raw_write_unlock_irqrestore' was exported
ERROR: modpost: vmlinux: local symbol '_raw_write_unlock_irq' was exported
ERROR: modpost: vmlinux: local symbol '_raw_write_unlock_bh' was exported
ERROR: modpost: vmlinux: local symbol 'in_lock_functions' was exported
ERROR: modpost: vmlinux: local symbol 'rt_mutex_base_init' was exported
>> ERROR: modpost: vmlinux: local symbol 'rt_mutex_lock' was exported
ERROR: modpost: vmlinux: local symbol 'rt_mutex_lock_interruptible' was exported
ERROR: modpost: vmlinux: local symbol 'rt_mutex_lock_killable' was exported
ERROR: modpost: vmlinux: local symbol 'rt_mutex_trylock' was exported
ERROR: modpost: vmlinux: local symbol 'rt_mutex_unlock' was exported
ERROR: modpost: vmlinux: local symbol '__rt_mutex_init' was exported
ERROR: modpost: vmlinux: local symbol 'queued_read_lock_slowpath' was exported
ERROR: modpost: vmlinux: local symbol 'queued_write_lock_slowpath' was exported
ERROR: modpost: vmlinux: local symbol 'cpu_latency_qos_request_active' was exported
ERROR: modpost: vmlinux: local symbol 'cpu_latency_qos_add_request' was exported
ERROR: modpost: vmlinux: local symbol 'cpu_latency_qos_update_request' was exported
ERROR: modpost: vmlinux: local symbol 'cpu_latency_qos_remove_request' was exported
ERROR: modpost: vmlinux: local symbol 'freq_qos_add_request' was exported
ERROR: modpost: vmlinux: local symbol 'freq_qos_update_request' was exported
ERROR: modpost: vmlinux: local symbol 'freq_qos_remove_request' was exported
ERROR: modpost: vmlinux: local symbol 'freq_qos_add_notifier' was exported
ERROR: modpost: vmlinux: local symbol 'freq_qos_remove_notifier' was exported
ERROR: modpost: vmlinux: local symbol 'pm_wq' was exported
ERROR: modpost: vmlinux: local symbol 'console_printk' was exported
ERROR: modpost: vmlinux: local symbol 'ignore_console_lock_warning' was exported
ERROR: modpost: vmlinux: local symbol '__tracepoint_console' was exported
ERROR: modpost: vmlinux: local symbol '__traceiter_console' was exported
ERROR: modpost: vmlinux: local symbol '__SCK__tp_func_console' was exported
ERROR: modpost: vmlinux: local symbol 'oops_in_progress' was exported
ERROR: modpost: vmlinux: local symbol 'console_list' was exported
ERROR: modpost: vmlinux: local symbol 'console_list_lock' was exported
ERROR: modpost: vmlinux: local symbol 'console_list_unlock' was exported
ERROR: modpost: vmlinux: local symbol 'console_srcu_read_lock' was exported
ERROR: modpost: vmlinux: local symbol 'console_srcu_read_unlock' was exported
ERROR: modpost: vmlinux: local symbol 'console_set_on_cmdline' was exported
ERROR: modpost: vmlinux: local symbol 'vprintk_emit' was exported
ERROR: modpost: vmlinux: local symbol 'vprintk_default' was exported
ERROR: modpost: vmlinux: local symbol '_printk' was exported
ERROR: modpost: vmlinux: local symbol 'console_suspend_enabled' was exported
ERROR: modpost: vmlinux: local symbol 'console_verbose' was exported
ERROR: modpost: vmlinux: local symbol 'console_lock' was exported
ERROR: modpost: vmlinux: local symbol 'console_trylock' was exported
ERROR: modpost: vmlinux: local symbol 'is_console_locked' was exported
ERROR: modpost: vmlinux: local symbol 'console_unlock' was exported
ERROR: modpost: vmlinux: local symbol 'console_conditional_schedule' was exported
ERROR: modpost: vmlinux: local symbol 'console_stop' was exported
ERROR: modpost: vmlinux: local symbol 'console_start' was exported
ERROR: modpost: vmlinux: local symbol 'register_console' was exported
ERROR: modpost: vmlinux: local symbol 'unregister_console' was exported
ERROR: modpost: vmlinux: local symbol 'console_force_preferred_locked' was exported
ERROR: modpost: vmlinux: local symbol '__printk_ratelimit' was exported
ERROR: modpost: vmlinux: local symbol 'printk_timed_ratelimit' was exported
ERROR: modpost: vmlinux: local symbol 'kmsg_dump_register' was exported
ERROR: modpost: vmlinux: local symbol 'kmsg_dump_unregister' was exported
ERROR: modpost: vmlinux: local symbol 'kmsg_dump_reason_str' was exported
ERROR: modpost: vmlinux: local symbol 'kmsg_dump_get_line' was exported
ERROR: modpost: vmlinux: local symbol 'kmsg_dump_get_buffer' was exported
ERROR: modpost: vmlinux: local symbol 'kmsg_dump_rewind' was exported
ERROR: modpost: vmlinux: local symbol '__printk_cpu_sync_wait' was exported
ERROR: modpost: vmlinux: local symbol '__printk_cpu_sync_try_get' was exported
ERROR: modpost: vmlinux: local symbol '__printk_cpu_sync_put' was exported
ERROR: modpost: vmlinux: local symbol 'vprintk' was exported
ERROR: modpost: vmlinux: local symbol 'nr_irqs' was exported
ERROR: modpost: vmlinux: local symbol 'generic_handle_irq' was exported
ERROR: modpost: vmlinux: local symbol 'generic_handle_irq_safe' was exported
ERROR: modpost: vmlinux: local symbol 'generic_handle_domain_irq' was exported
ERROR: modpost: vmlinux: local symbol 'generic_handle_domain_irq_safe' was exported
ERROR: modpost: vmlinux: local symbol 'irq_free_descs' was exported
ERROR: modpost: vmlinux: local symbol '__irq_alloc_descs' was exported
ERROR: modpost: vmlinux: local symbol 'irq_get_percpu_devid_partition' was exported
ERROR: modpost: vmlinux: local symbol 'handle_bad_irq' was exported
ERROR: modpost: vmlinux: local symbol 'no_action' was exported
ERROR: modpost: vmlinux: local symbol 'synchronize_hardirq' was exported
ERROR: modpost: vmlinux: local symbol 'synchronize_irq' was exported
ERROR: modpost: vmlinux: local symbol 'irq_set_affinity' was exported
ERROR: modpost: vmlinux: local symbol 'irq_force_affinity' was exported
ERROR: modpost: vmlinux: local symbol '__irq_apply_affinity_hint' was exported
ERROR: modpost: vmlinux: local symbol 'irq_set_affinity_notifier' was exported
ERROR: modpost: vmlinux: local symbol 'irq_set_vcpu_affinity' was exported
ERROR: modpost: vmlinux: local symbol 'disable_irq_nosync' was exported
ERROR: modpost: vmlinux: local symbol 'disable_irq' was exported
ERROR: modpost: vmlinux: local symbol 'disable_hardirq' was exported
ERROR: modpost: vmlinux: local symbol 'enable_irq' was exported
ERROR: modpost: vmlinux: local symbol 'irq_set_irq_wake' was exported
ERROR: modpost: vmlinux: local symbol 'irq_set_parent' was exported
ERROR: modpost: vmlinux: local symbol 'irq_wake_thread' was exported
ERROR: modpost: vmlinux: local symbol 'free_irq' was exported
ERROR: modpost: vmlinux: local symbol 'request_threaded_irq' was exported
ERROR: modpost: vmlinux: local symbol 'request_any_context_irq' was exported
ERROR: modpost: vmlinux: local symbol 'enable_percpu_irq' was exported
ERROR: modpost: vmlinux: local symbol 'irq_percpu_is_enabled' was exported
ERROR: modpost: vmlinux: local symbol 'disable_percpu_irq' was exported
ERROR: modpost: vmlinux: local symbol 'free_percpu_irq' was exported
ERROR: modpost: vmlinux: local symbol '__request_percpu_irq' was exported
ERROR: modpost: vmlinux: local symbol 'irq_get_irqchip_state' was exported
ERROR: modpost: vmlinux: local symbol 'irq_set_irqchip_state' was exported
ERROR: modpost: vmlinux: local symbol 'irq_has_action' was exported
ERROR: modpost: vmlinux: local symbol 'irq_check_status_bit' was exported
ERROR: modpost: vmlinux: local symbol 'irq_inject_interrupt' was exported
ERROR: modpost: vmlinux: local symbol 'irq_set_chip' was exported
ERROR: modpost: vmlinux: local symbol 'irq_set_irq_type' was exported
ERROR: modpost: vmlinux: local symbol 'irq_set_handler_data' was exported
ERROR: modpost: vmlinux: local symbol 'irq_set_chip_data' was exported
ERROR: modpost: vmlinux: local symbol 'irq_get_irq_data' was exported
ERROR: modpost: vmlinux: local symbol 'handle_nested_irq' was exported
ERROR: modpost: vmlinux: local symbol 'handle_simple_irq' was exported
--
ERROR: modpost: vmlinux: local symbol 'irq_chip_eoi_parent' was exported
ERROR: modpost: vmlinux: local symbol 'irq_chip_set_affinity_parent' was exported
ERROR: modpost: vmlinux: local symbol 'irq_chip_set_type_parent' was exported
ERROR: modpost: vmlinux: local symbol 'irq_chip_retrigger_hierarchy' was exported
ERROR: modpost: vmlinux: local symbol 'irq_chip_set_vcpu_affinity_parent' was exported
ERROR: modpost: vmlinux: local symbol 'irq_chip_set_wake_parent' was exported
ERROR: modpost: vmlinux: local symbol 'irq_chip_request_resources_parent' was exported
ERROR: modpost: vmlinux: local symbol 'irq_chip_release_resources_parent' was exported
ERROR: modpost: vmlinux: local symbol 'dummy_irq_chip' was exported
ERROR: modpost: vmlinux: local symbol 'devm_request_threaded_irq' was exported
ERROR: modpost: vmlinux: local symbol 'devm_request_any_context_irq' was exported
ERROR: modpost: vmlinux: local symbol 'devm_free_irq' was exported
ERROR: modpost: vmlinux: local symbol '__devm_irq_alloc_descs' was exported
ERROR: modpost: vmlinux: local symbol 'devm_irq_alloc_generic_chip' was exported
ERROR: modpost: vmlinux: local symbol 'devm_irq_setup_generic_chip' was exported
ERROR: modpost: vmlinux: local symbol 'irq_gc_noop' was exported
ERROR: modpost: vmlinux: local symbol 'irq_gc_mask_disable_reg' was exported
ERROR: modpost: vmlinux: local symbol 'irq_gc_mask_set_bit' was exported
ERROR: modpost: vmlinux: local symbol 'irq_gc_mask_clr_bit' was exported
ERROR: modpost: vmlinux: local symbol 'irq_gc_unmask_enable_reg' was exported
ERROR: modpost: vmlinux: local symbol 'irq_gc_ack_set_bit' was exported
ERROR: modpost: vmlinux: local symbol 'irq_gc_set_wake' was exported
ERROR: modpost: vmlinux: local symbol 'irq_alloc_generic_chip' was exported
ERROR: modpost: vmlinux: local symbol '__irq_alloc_domain_generic_chips' was exported
ERROR: modpost: vmlinux: local symbol 'irq_get_domain_generic_chip' was exported
ERROR: modpost: vmlinux: local symbol 'irq_generic_chip_ops' was exported
ERROR: modpost: vmlinux: local symbol 'irq_setup_generic_chip' was exported
ERROR: modpost: vmlinux: local symbol 'irq_setup_alt_chip' was exported
ERROR: modpost: vmlinux: local symbol 'irq_remove_generic_chip' was exported
ERROR: modpost: vmlinux: local symbol 'irqchip_fwnode_ops' was exported
ERROR: modpost: vmlinux: local symbol '__irq_domain_alloc_fwnode' was exported
ERROR: modpost: vmlinux: local symbol 'irq_domain_free_fwnode' was exported
ERROR: modpost: vmlinux: local symbol '__irq_domain_add' was exported
ERROR: modpost: vmlinux: local symbol 'irq_domain_remove' was exported
ERROR: modpost: vmlinux: local symbol 'irq_domain_update_bus_token' was exported
ERROR: modpost: vmlinux: local symbol 'irq_domain_create_simple' was exported
ERROR: modpost: vmlinux: local symbol 'irq_domain_add_legacy' was exported
ERROR: modpost: vmlinux: local symbol 'irq_domain_create_legacy' was exported
ERROR: modpost: vmlinux: local symbol 'irq_find_matching_fwspec' was exported
ERROR: modpost: vmlinux: local symbol 'irq_set_default_host' was exported
ERROR: modpost: vmlinux: local symbol 'irq_get_default_host' was exported
ERROR: modpost: vmlinux: local symbol 'irq_domain_associate' was exported
ERROR: modpost: vmlinux: local symbol 'irq_domain_associate_many' was exported
ERROR: modpost: vmlinux: local symbol 'irq_create_mapping_affinity' was exported
ERROR: modpost: vmlinux: local symbol 'of_phandle_args_to_fwspec' was exported
ERROR: modpost: vmlinux: local symbol 'irq_create_fwspec_mapping' was exported
ERROR: modpost: vmlinux: local symbol 'irq_create_of_mapping' was exported
ERROR: modpost: vmlinux: local symbol 'irq_dispose_mapping' was exported
ERROR: modpost: vmlinux: local symbol '__irq_resolve_mapping' was exported
ERROR: modpost: vmlinux: local symbol 'irq_domain_xlate_onecell' was exported
ERROR: modpost: vmlinux: local symbol 'irq_domain_xlate_twocell' was exported
ERROR: modpost: vmlinux: local symbol 'irq_domain_xlate_onetwocell' was exported
ERROR: modpost: vmlinux: local symbol 'irq_domain_simple_ops' was exported
ERROR: modpost: vmlinux: local symbol 'irq_domain_translate_onecell' was exported
ERROR: modpost: vmlinux: local symbol 'irq_domain_translate_twocell' was exported
ERROR: modpost: vmlinux: local symbol 'irq_domain_reset_irq_data' was exported
ERROR: modpost: vmlinux: local symbol 'irq_domain_create_hierarchy' was exported
ERROR: modpost: vmlinux: local symbol 'irq_domain_disconnect_hierarchy' was exported
ERROR: modpost: vmlinux: local symbol 'irq_domain_get_irq_data' was exported
ERROR: modpost: vmlinux: local symbol 'irq_domain_set_hwirq_and_chip' was exported
ERROR: modpost: vmlinux: local symbol 'irq_domain_set_info' was exported
ERROR: modpost: vmlinux: local symbol 'irq_domain_free_irqs_common' was exported
ERROR: modpost: vmlinux: local symbol '__irq_domain_alloc_irqs' was exported
ERROR: modpost: vmlinux: local symbol 'irq_domain_push_irq' was exported
ERROR: modpost: vmlinux: local symbol 'irq_domain_pop_irq' was exported
ERROR: modpost: vmlinux: local symbol 'irq_domain_alloc_irqs_parent' was exported
ERROR: modpost: vmlinux: local symbol 'irq_domain_free_irqs_parent' was exported
ERROR: modpost: vmlinux: local symbol 'irq_domain_create_sim' was exported
ERROR: modpost: vmlinux: local symbol 'irq_domain_remove_sim' was exported
ERROR: modpost: vmlinux: local symbol 'devm_irq_domain_create_sim' was exported
ERROR: modpost: vmlinux: local symbol 'get_cached_msi_msg' was exported
ERROR: modpost: vmlinux: local symbol 'msi_lock_descs' was exported
ERROR: modpost: vmlinux: local symbol 'msi_unlock_descs' was exported
ERROR: modpost: vmlinux: local symbol 'msi_domain_first_desc' was exported
ERROR: modpost: vmlinux: local symbol 'msi_next_desc' was exported
ERROR: modpost: vmlinux: local symbol 'msi_domain_get_virq' was exported
ERROR: modpost: vmlinux: local symbol 'msi_device_has_isolated_msi' was exported
ERROR: modpost: vmlinux: local symbol 'ipi_get_hwirq' was exported
ERROR: modpost: vmlinux: local symbol 'ipi_send_single' was exported
ERROR: modpost: vmlinux: local symbol 'ipi_send_mask' was exported
ERROR: modpost: vmlinux: local symbol 'rcu_gp_is_normal' was exported
ERROR: modpost: vmlinux: local symbol 'rcu_async_should_hurry' was exported
ERROR: modpost: vmlinux: local symbol 'rcu_async_hurry' was exported
ERROR: modpost: vmlinux: local symbol 'rcu_async_relax' was exported
ERROR: modpost: vmlinux: local symbol 'rcu_gp_is_expedited' was exported
ERROR: modpost: vmlinux: local symbol 'rcu_expedite_gp' was exported
ERROR: modpost: vmlinux: local symbol 'rcu_unexpedite_gp' was exported
ERROR: modpost: vmlinux: local symbol 'rcu_inkernel_boot_has_ended' was exported
ERROR: modpost: vmlinux: local symbol 'wakeme_after_rcu' was exported
ERROR: modpost: vmlinux: local symbol '__wait_rcu_gp' was exported
ERROR: modpost: vmlinux: local symbol 'finish_rcuwait' was exported
ERROR: modpost: vmlinux: local symbol 'do_trace_rcu_torture_read' was exported
ERROR: modpost: vmlinux: local symbol 'rcutorture_sched_setaffinity' was exported
ERROR: modpost: vmlinux: local symbol 'rcu_cpu_stall_suppress' was exported
ERROR: modpost: vmlinux: local symbol 'rcu_cpu_stall_suppress_at_boot' was exported
ERROR: modpost: vmlinux: local symbol 'get_completed_synchronize_rcu' was exported
ERROR: modpost: vmlinux: local symbol 'call_rcu_tasks' was exported
ERROR: modpost: vmlinux: local symbol 'synchronize_rcu_tasks' was exported
ERROR: modpost: vmlinux: local symbol 'rcu_barrier_tasks' was exported
ERROR: modpost: vmlinux: local symbol 'show_rcu_tasks_classic_gp_kthread' was exported
>> ERROR: modpost: vmlinux: local symbol 'init_srcu_struct' was exported
ERROR: modpost: vmlinux: local symbol 'cleanup_srcu_struct' was exported
ERROR: modpost: vmlinux: local symbol '__srcu_read_lock' was exported
ERROR: modpost: vmlinux: local symbol '__srcu_read_unlock' was exported
ERROR: modpost: vmlinux: local symbol 'call_srcu' was exported
ERROR: modpost: vmlinux: local symbol 'synchronize_srcu_expedited' was exported
ERROR: modpost: vmlinux: local symbol 'synchronize_srcu' was exported
ERROR: modpost: vmlinux: local symbol 'get_state_synchronize_srcu' was exported
ERROR: modpost: vmlinux: local symbol 'start_poll_synchronize_srcu' was exported
ERROR: modpost: vmlinux: local symbol 'poll_state_synchronize_srcu' was exported
ERROR: modpost: vmlinux: local symbol 'srcu_barrier' was exported
ERROR: modpost: vmlinux: local symbol 'srcu_batches_completed' was exported
ERROR: modpost: vmlinux: local symbol 'srcutorture_get_gp_data' was exported
ERROR: modpost: vmlinux: local symbol 'srcu_torture_stats_print' was exported
ERROR: modpost: vmlinux: local symbol 'rcu_scheduler_active' was exported
ERROR: modpost: vmlinux: local symbol 'rcu_get_gp_kthreads_prio' was exported
ERROR: modpost: vmlinux: local symbol 'rcu_momentary_dyntick_idle' was exported
ERROR: modpost: vmlinux: local symbol 'rcu_get_gp_seq' was exported
ERROR: modpost: vmlinux: local symbol 'rcu_exp_batches_completed' was exported
ERROR: modpost: vmlinux: local symbol 'rcutorture_get_gp_data' was exported
ERROR: modpost: vmlinux: local symbol 'rcu_is_watching' was exported
ERROR: modpost: vmlinux: local symbol 'rcu_gp_slow_register' was exported
ERROR: modpost: vmlinux: local symbol 'rcu_gp_slow_unregister' was exported
ERROR: modpost: vmlinux: local symbol 'rcu_gp_set_torture_wait' was exported
ERROR: modpost: vmlinux: local symbol 'rcu_force_quiescent_state' was exported
ERROR: modpost: vmlinux: local symbol 'call_rcu' was exported
ERROR: modpost: vmlinux: local symbol 'kvfree_call_rcu' was exported
ERROR: modpost: vmlinux: local symbol 'synchronize_rcu' was exported
ERROR: modpost: vmlinux: local symbol 'get_completed_synchronize_rcu_full' was exported
ERROR: modpost: vmlinux: local symbol 'get_state_synchronize_rcu' was exported
ERROR: modpost: vmlinux: local symbol 'get_state_synchronize_rcu_full' was exported
ERROR: modpost: vmlinux: local symbol 'start_poll_synchronize_rcu' was exported
ERROR: modpost: vmlinux: local symbol 'start_poll_synchronize_rcu_full' was exported
ERROR: modpost: vmlinux: local symbol 'poll_state_synchronize_rcu' was exported
ERROR: modpost: vmlinux: local symbol 'poll_state_synchronize_rcu_full' was exported
ERROR: modpost: vmlinux: local symbol 'cond_synchronize_rcu' was exported
ERROR: modpost: vmlinux: local symbol 'cond_synchronize_rcu_full' was exported
ERROR: modpost: vmlinux: local symbol 'rcu_barrier' was exported
ERROR: modpost: vmlinux: local symbol 'rcu_exp_jiffies_till_stall_check' was exported
ERROR: modpost: vmlinux: local symbol 'rcu_jiffies_till_stall_check' was exported
ERROR: modpost: vmlinux: local symbol 'rcu_check_boost_fail' was exported
ERROR: modpost: vmlinux: local symbol 'show_rcu_gp_kthreads' was exported
ERROR: modpost: vmlinux: local symbol 'rcu_fwd_progress_check' was exported
ERROR: modpost: vmlinux: local symbol 'synchronize_rcu_expedited' was exported
ERROR: modpost: vmlinux: local symbol 'start_poll_synchronize_rcu_expedited' was exported
ERROR: modpost: vmlinux: local symbol 'start_poll_synchronize_rcu_expedited_full' was exported
ERROR: modpost: vmlinux: local symbol 'cond_synchronize_rcu_expedited' was exported
ERROR: modpost: vmlinux: local symbol 'cond_synchronize_rcu_expedited_full' was exported
ERROR: modpost: vmlinux: local symbol 'rcu_note_context_switch' was exported
ERROR: modpost: vmlinux: local symbol '__rcu_read_lock' was exported
ERROR: modpost: vmlinux: local symbol '__rcu_read_unlock' was exported
ERROR: modpost: vmlinux: local symbol 'dmam_free_coherent' was exported
ERROR: modpost: vmlinux: local symbol 'dmam_alloc_attrs' was exported
ERROR: modpost: vmlinux: local symbol 'dma_map_page_attrs' was exported
ERROR: modpost: vmlinux: local symbol 'dma_unmap_page_attrs' was exported
ERROR: modpost: vmlinux: local symbol 'dma_map_sg_attrs' was exported
ERROR: modpost: vmlinux: local symbol 'dma_map_sgtable' was exported
ERROR: modpost: vmlinux: local symbol 'dma_unmap_sg_attrs' was exported
ERROR: modpost: vmlinux: local symbol 'dma_map_resource' was exported
ERROR: modpost: vmlinux: local symbol 'dma_unmap_resource' was exported
ERROR: modpost: vmlinux: local symbol 'dma_sync_single_for_cpu' was exported
ERROR: modpost: vmlinux: local symbol 'dma_sync_single_for_device' was exported
ERROR: modpost: vmlinux: local symbol 'dma_sync_sg_for_cpu' was exported
ERROR: modpost: vmlinux: local symbol 'dma_sync_sg_for_device' was exported
ERROR: modpost: vmlinux: local symbol 'dma_get_sgtable_attrs' was exported
ERROR: modpost: vmlinux: local symbol 'dma_can_mmap' was exported
ERROR: modpost: vmlinux: local symbol 'dma_mmap_attrs' was exported
ERROR: modpost: vmlinux: local symbol 'dma_get_required_mask' was exported
ERROR: modpost: vmlinux: local symbol 'dma_alloc_attrs' was exported
ERROR: modpost: vmlinux: local symbol 'dma_free_attrs' was exported
ERROR: modpost: vmlinux: local symbol 'dma_alloc_pages' was exported
ERROR: modpost: vmlinux: local symbol 'dma_free_pages' was exported
ERROR: modpost: vmlinux: local symbol 'dma_mmap_pages' was exported
ERROR: modpost: vmlinux: local symbol 'dma_alloc_noncontiguous' was exported
ERROR: modpost: vmlinux: local symbol 'dma_free_noncontiguous' was exported
ERROR: modpost: vmlinux: local symbol 'dma_vmap_noncontiguous' was exported
ERROR: modpost: vmlinux: local symbol 'dma_vunmap_noncontiguous' was exported
ERROR: modpost: vmlinux: local symbol 'dma_mmap_noncontiguous' was exported
ERROR: modpost: vmlinux: local symbol 'dma_pci_p2pdma_supported' was exported
ERROR: modpost: vmlinux: local symbol 'dma_set_mask' was exported
ERROR: modpost: vmlinux: local symbol 'dma_set_coherent_mask' was exported
ERROR: modpost: vmlinux: local symbol 'dma_max_mapping_size' was exported
ERROR: modpost: vmlinux: local symbol 'dma_opt_mapping_size' was exported
ERROR: modpost: vmlinux: local symbol 'dma_need_sync' was exported
ERROR: modpost: vmlinux: local symbol 'dma_get_merge_boundary' was exported
>> ERROR: modpost: vmlinux: local symbol 'debug_dma_map_single' was exported
>> ERROR: modpost: vmlinux: local symbol 'debug_dma_mapping_error' was exported
ERROR: modpost: vmlinux: local symbol 'register_module_notifier' was exported
ERROR: modpost: vmlinux: local symbol 'unregister_module_notifier' was exported
ERROR: modpost: vmlinux: local symbol '__module_put_and_kthread_exit' was exported
ERROR: modpost: vmlinux: local symbol '__tracepoint_module_get' was exported
ERROR: modpost: vmlinux: local symbol '__traceiter_module_get' was exported
ERROR: modpost: vmlinux: local symbol '__SCK__tp_func_module_get' was exported
ERROR: modpost: vmlinux: local symbol 'module_refcount' was exported
ERROR: modpost: vmlinux: local symbol '__symbol_put' was exported
ERROR: modpost: vmlinux: local symbol 'symbol_put_addr' was exported
ERROR: modpost: vmlinux: local symbol '__module_get' was exported
ERROR: modpost: vmlinux: local symbol 'try_module_get' was exported
ERROR: modpost: vmlinux: local symbol 'module_put' was exported
ERROR: modpost: vmlinux: local symbol '__symbol_get' was exported
ERROR: modpost: vmlinux: local symbol '__request_module' was exported
ERROR: modpost: vmlinux: local symbol 'is_module_sig_enforced' was exported
ERROR: modpost: vmlinux: local symbol 'stack_trace_print' was exported
ERROR: modpost: vmlinux: local symbol 'stack_trace_snprint' was exported
ERROR: modpost: vmlinux: local symbol 'stack_trace_save' was exported
ERROR: modpost: vmlinux: local symbol 'filter_irq_stacks' was exported
ERROR: modpost: vmlinux: local symbol 'sys_tz' was exported
ERROR: modpost: vmlinux: local symbol 'jiffies_to_msecs' was exported
ERROR: modpost: vmlinux: local symbol 'jiffies_to_usecs' was exported
ERROR: modpost: vmlinux: local symbol 'mktime64' was exported
ERROR: modpost: vmlinux: local symbol 'ns_to_kernel_old_timeval' was exported
ERROR: modpost: vmlinux: local symbol 'set_normalized_timespec64' was exported
ERROR: modpost: vmlinux: local symbol 'ns_to_timespec64' was exported
ERROR: modpost: vmlinux: local symbol '__msecs_to_jiffies' was exported
ERROR: modpost: vmlinux: local symbol '__usecs_to_jiffies' was exported
ERROR: modpost: vmlinux: local symbol 'timespec64_to_jiffies' was exported
ERROR: modpost: vmlinux: local symbol 'jiffies_to_timespec64' was exported
ERROR: modpost: vmlinux: local symbol 'jiffies_to_clock_t' was exported
ERROR: modpost: vmlinux: local symbol 'clock_t_to_jiffies' was exported
ERROR: modpost: vmlinux: local symbol 'jiffies_64_to_clock_t' was exported
ERROR: modpost: vmlinux: local symbol 'jiffies64_to_nsecs' was exported
ERROR: modpost: vmlinux: local symbol 'jiffies64_to_msecs' was exported
ERROR: modpost: vmlinux: local symbol 'nsecs_to_jiffies64' was exported
ERROR: modpost: vmlinux: local symbol 'nsecs_to_jiffies' was exported
ERROR: modpost: vmlinux: local symbol 'get_timespec64' was exported
ERROR: modpost: vmlinux: local symbol 'put_timespec64' was exported
ERROR: modpost: vmlinux: local symbol 'get_old_timespec32' was exported
ERROR: modpost: vmlinux: local symbol 'put_old_timespec32' was exported
ERROR: modpost: vmlinux: local symbol 'get_itimerspec64' was exported
ERROR: modpost: vmlinux: local symbol 'put_itimerspec64' was exported
ERROR: modpost: vmlinux: local symbol 'get_old_itimerspec32' was exported
ERROR: modpost: vmlinux: local symbol 'put_old_itimerspec32' was exported
ERROR: modpost: vmlinux: local symbol 'jiffies_64' was exported
ERROR: modpost: vmlinux: local symbol '__round_jiffies' was exported
ERROR: modpost: vmlinux: local symbol '__round_jiffies_relative' was exported
ERROR: modpost: vmlinux: local symbol 'round_jiffies' was exported
ERROR: modpost: vmlinux: local symbol 'round_jiffies_relative' was exported
ERROR: modpost: vmlinux: local symbol '__round_jiffies_up' was exported
ERROR: modpost: vmlinux: local symbol '__round_jiffies_up_relative' was exported
ERROR: modpost: vmlinux: local symbol 'round_jiffies_up' was exported
ERROR: modpost: vmlinux: local symbol 'round_jiffies_up_relative' was exported
ERROR: modpost: vmlinux: local symbol 'init_timer_key' was exported
ERROR: modpost: vmlinux: local symbol 'mod_timer_pending' was exported
ERROR: modpost: vmlinux: local symbol 'mod_timer' was exported
ERROR: modpost: vmlinux: local symbol 'timer_reduce' was exported
ERROR: modpost: vmlinux: local symbol 'add_timer' was exported
ERROR: modpost: vmlinux: local symbol 'add_timer_on' was exported
ERROR: modpost: vmlinux: local symbol 'timer_delete' was exported
ERROR: modpost: vmlinux: local symbol 'timer_shutdown' was exported
ERROR: modpost: vmlinux: local symbol 'try_to_del_timer_sync' was exported
ERROR: modpost: vmlinux: local symbol 'timer_delete_sync' was exported
ERROR: modpost: vmlinux: local symbol 'timer_shutdown_sync' was exported
ERROR: modpost: vmlinux: local symbol 'schedule_timeout' was exported
ERROR: modpost: vmlinux: local symbol 'schedule_timeout_interruptible' was exported
ERROR: modpost: vmlinux: local symbol 'schedule_timeout_killable' was exported
ERROR: modpost: vmlinux: local symbol 'schedule_timeout_uninterruptible' was exported
ERROR: modpost: vmlinux: local symbol 'schedule_timeout_idle' was exported
ERROR: modpost: vmlinux: local symbol 'msleep' was exported
ERROR: modpost: vmlinux: local symbol 'msleep_interruptible' was exported
ERROR: modpost: vmlinux: local symbol 'usleep_range_state' was exported
ERROR: modpost: vmlinux: local symbol '__ktime_divns' was exported
ERROR: modpost: vmlinux: local symbol 'ktime_add_safe' was exported
ERROR: modpost: vmlinux: local symbol 'hrtimer_resolution' was exported
ERROR: modpost: vmlinux: local symbol 'hrtimer_forward' was exported
ERROR: modpost: vmlinux: local symbol 'hrtimer_start_range_ns' was exported
ERROR: modpost: vmlinux: local symbol 'hrtimer_try_to_cancel' was exported
ERROR: modpost: vmlinux: local symbol 'hrtimer_cancel' was exported
ERROR: modpost: vmlinux: local symbol '__hrtimer_get_remaining' was exported
ERROR: modpost: vmlinux: local symbol 'hrtimer_init' was exported
ERROR: modpost: vmlinux: local symbol 'hrtimer_active' was exported
ERROR: modpost: vmlinux: local symbol 'hrtimer_sleeper_start_expires' was exported
ERROR: modpost: vmlinux: local symbol 'hrtimer_init_sleeper' was exported
ERROR: modpost: vmlinux: local symbol 'schedule_hrtimeout_range_clock' was exported
ERROR: modpost: vmlinux: local symbol 'schedule_hrtimeout_range' was exported
ERROR: modpost: vmlinux: local symbol 'schedule_hrtimeout' was exported
ERROR: modpost: vmlinux: local symbol 'ktime_get_mono_fast_ns' was exported
ERROR: modpost: vmlinux: local symbol 'ktime_get_raw_fast_ns' was exported
ERROR: modpost: vmlinux: local symbol 'ktime_get_boot_fast_ns' was exported
ERROR: modpost: vmlinux: local symbol 'ktime_get_tai_fast_ns' was exported
ERROR: modpost: vmlinux: local symbol 'ktime_get_real_fast_ns' was exported
ERROR: modpost: vmlinux: local symbol 'pvclock_gtod_register_notifier' was exported
ERROR: modpost: vmlinux: local symbol 'pvclock_gtod_unregister_notifier' was exported
ERROR: modpost: vmlinux: local symbol 'ktime_get_real_ts64' was exported
ERROR: modpost: vmlinux: local symbol 'ktime_get' was exported
ERROR: modpost: vmlinux: local symbol 'ktime_get_resolution_ns' was exported
ERROR: modpost: vmlinux: local symbol 'ktime_get_with_offset' was exported
ERROR: modpost: vmlinux: local symbol 'ktime_get_coarse_with_offset' was exported

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

