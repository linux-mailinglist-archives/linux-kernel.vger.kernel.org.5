Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7802E7D90DF
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 10:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbjJ0IQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 04:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjJ0IQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 04:16:23 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BB9E1A1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 01:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698394579; x=1729930579;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=9xqg8s9JRDopeUrGstxy8wPksU924qPFR2ul+3V/JZ0=;
  b=bvWtmTs9ZY5IOcn5uqowe+TuQgd0cvX8a/7gYjGBx6vQEXMVEn/Qyd+Q
   rHoRi4CEbaM0B3Cgia8lac1crzpUH0Qp2Wa87fVTBipEQEfH2eG/Y4Bqc
   1prypO165rD/tx8hTJvFBzOuArpH51SEQnJ+Gu6UCODh/kDi+uKnrG/CX
   K1nkFbPVUtKOqgRA48hM93T3ZiCNIC7PI4EJibBKPTG7aLseSfW4HR/EU
   VXhY1sGuEO88jH1uzEANWFVXEZShYkobEzRHSanlGwYAOnbp8mWZV+AmD
   nLFhvBDMSKS0GWtZfnnMdWXcg9+27Sv4aMeoCmd/QFMvVRDq5XCoyvfYy
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="9270256"
X-IronPort-AV: E=Sophos;i="6.03,255,1694761200"; 
   d="scan'208";a="9270256"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 01:16:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,255,1694761200"; 
   d="scan'208";a="758746"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 27 Oct 2023 01:16:05 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qwI0s-000AdP-2X;
        Fri, 27 Oct 2023 08:16:14 +0000
Date:   Fri, 27 Oct 2023 16:15:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: ERROR: modpost: vmlinux: local symbol 'get_rcu_tasks_gp_kthread' was
 exported
Message-ID: <202310271646.UEGZOjqk-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3a568e3a961ba330091cd031647e4c303fa0badb
commit: 271a8467a5f7ab7654f06541d2483b5340bb7192 rcuscale: Measure RCU Tasks Trace grace-period kthread CPU time
date:   3 months ago
config: riscv-randconfig-c033-20221102 (https://download.01.org/0day-ci/archive/20231027/202310271646.UEGZOjqk-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231027/202310271646.UEGZOjqk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310271646.UEGZOjqk-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

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
ERROR: modpost: vmlinux: local symbol 'rcu_read_lock_sched_held' was exported
ERROR: modpost: vmlinux: local symbol 'rcu_gp_is_normal' was exported
ERROR: modpost: vmlinux: local symbol 'rcu_async_should_hurry' was exported
ERROR: modpost: vmlinux: local symbol 'rcu_async_hurry' was exported
ERROR: modpost: vmlinux: local symbol 'rcu_async_relax' was exported
ERROR: modpost: vmlinux: local symbol 'rcu_gp_is_expedited' was exported
ERROR: modpost: vmlinux: local symbol 'rcu_expedite_gp' was exported
ERROR: modpost: vmlinux: local symbol 'rcu_unexpedite_gp' was exported
ERROR: modpost: vmlinux: local symbol 'rcu_inkernel_boot_has_ended' was exported
ERROR: modpost: vmlinux: local symbol 'rcu_lock_map' was exported
ERROR: modpost: vmlinux: local symbol 'rcu_bh_lock_map' was exported
ERROR: modpost: vmlinux: local symbol 'rcu_sched_lock_map' was exported
ERROR: modpost: vmlinux: local symbol 'rcu_callback_map' was exported
ERROR: modpost: vmlinux: local symbol 'debug_lockdep_rcu_enabled' was exported
ERROR: modpost: vmlinux: local symbol 'rcu_read_lock_held' was exported
ERROR: modpost: vmlinux: local symbol 'rcu_read_lock_bh_held' was exported
ERROR: modpost: vmlinux: local symbol 'rcu_read_lock_any_held' was exported
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
>> ERROR: modpost: vmlinux: local symbol 'get_rcu_tasks_gp_kthread' was exported
ERROR: modpost: vmlinux: local symbol 'call_rcu_tasks_rude' was exported
ERROR: modpost: vmlinux: local symbol 'synchronize_rcu_tasks_rude' was exported
ERROR: modpost: vmlinux: local symbol 'rcu_barrier_tasks_rude' was exported
ERROR: modpost: vmlinux: local symbol 'show_rcu_tasks_rude_gp_kthread' was exported
ERROR: modpost: vmlinux: local symbol 'rcu_trace_lock_map' was exported
ERROR: modpost: vmlinux: local symbol 'rcu_trc_cmpxchg_need_qs' was exported
ERROR: modpost: vmlinux: local symbol 'rcu_read_unlock_trace_special' was exported
ERROR: modpost: vmlinux: local symbol 'rcu_tasks_trace_qs_blkd' was exported
ERROR: modpost: vmlinux: local symbol 'call_rcu_tasks_trace' was exported
ERROR: modpost: vmlinux: local symbol 'synchronize_rcu_tasks_trace' was exported
ERROR: modpost: vmlinux: local symbol 'rcu_barrier_tasks_trace' was exported
ERROR: modpost: vmlinux: local symbol 'show_rcu_tasks_trace_gp_kthread' was exported
ERROR: modpost: vmlinux: local symbol 'get_rcu_tasks_trace_gp_kthread' was exported
ERROR: modpost: vmlinux: local symbol '__init_srcu_struct' was exported
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
ERROR: modpost: vmlinux: local symbol 'register_module_notifier' was exported
ERROR: modpost: vmlinux: local symbol 'unregister_module_notifier' was exported

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
