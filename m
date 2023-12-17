Return-Path: <linux-kernel+bounces-2802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF63816229
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 21:48:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C3D41C211FC
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 20:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A5D481CA;
	Sun, 17 Dec 2023 20:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UofGJTb3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD3848784
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 20:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702846069; x=1734382069;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=PPFhYVqymHHDzxLZ/KdRJS7d+N9/GE4L/gTaZssuEoQ=;
  b=UofGJTb3I42GWqzh4N4jd4t57B7Y8j/7ZfLui+6hnmTKG9NKPw+Eqj3E
   zicIcr2wj8uA286/J3Ev2gdrbIUUhvDXXNfUuBS9r7wlKG8Tjyh7wde1u
   WGvSNXDfIbqzV9QnX2HWDkAIo3xrtOUCvjeEV9oDRgitsxX50hVrjLva7
   oP/KDjj6cjIPLg4d7q+jY+SNyiHv6gWhqz+1eaHc0FnOJGVuPTtPxmQ8e
   lM4BnH8EyO22pANXoWvwCNEm6EuizEGVhZdIgBrBQJJJb2N/4zCeZdd8j
   6l5gqO8IFRkMEj8vk8yvPoX+7mDyW6EZD3ioUSjSIX54HEalv+BFeNVqs
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="2283683"
X-IronPort-AV: E=Sophos;i="6.04,284,1695711600"; 
   d="scan'208";a="2283683"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2023 12:47:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="898748131"
X-IronPort-AV: E=Sophos;i="6.04,284,1695711600"; 
   d="scan'208";a="898748131"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 17 Dec 2023 12:47:46 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rEy36-0003PU-1a;
	Sun, 17 Dec 2023 20:47:44 +0000
Date: Mon, 18 Dec 2023 04:47:31 +0800
From: kernel test robot <lkp@intel.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>
Subject: net/ipv4/udp_tunnel_nic.c:51: warning: Excess struct member
 'entries' description in 'udp_tunnel_nic'
Message-ID: <202312180458.MTvBk05H-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0e389834672c723435a44818ed2cabc4dad24429
commit: ef35bed6fad6eda8de0277eda77803c748f306d1 udp_tunnel: Use flex array to simplify code
date:   3 months ago
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231218/202312180458.MTvBk05H-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312180458.MTvBk05H-lkp@intel.com/

All warnings (new ones prefixed by >>):

   arch/x86/kernel/cpu/resctrl/rdtgroup.c:914: warning: Function parameter or member 'v' not described in 'rdt_bit_usage_show'
   arch/x86/kernel/cpu/resctrl/rdtgroup.c:1143: warning: Function parameter or member 'type' not described in '__rdtgroup_cbm_overlaps'
   arch/x86/kernel/cpu/resctrl/rdtgroup.c:1223: warning: Function parameter or member 'rdtgrp' not described in 'rdtgroup_mode_test_exclusive'
   arch/x86/kernel/cpu/resctrl/rdtgroup.c:1260: warning: Function parameter or member 'of' not described in 'rdtgroup_mode_write'
   arch/x86/kernel/cpu/resctrl/rdtgroup.c:1260: warning: Function parameter or member 'buf' not described in 'rdtgroup_mode_write'
   arch/x86/kernel/cpu/resctrl/rdtgroup.c:1260: warning: Function parameter or member 'nbytes' not described in 'rdtgroup_mode_write'
   arch/x86/kernel/cpu/resctrl/rdtgroup.c:1260: warning: Function parameter or member 'off' not described in 'rdtgroup_mode_write'
   arch/x86/kernel/cpu/resctrl/rdtgroup.c:1369: warning: Function parameter or member 'of' not described in 'rdtgroup_size_show'
   arch/x86/kernel/cpu/resctrl/rdtgroup.c:1369: warning: Function parameter or member 's' not described in 'rdtgroup_size_show'
   arch/x86/kernel/cpu/resctrl/rdtgroup.c:1369: warning: Function parameter or member 'v' not described in 'rdtgroup_size_show'
   arch/x86/kernel/cpu/resctrl/monitor.c:34: warning: Cannot understand  * @rmid_free_lru    A least recently used list of free RMIDs
    on line 34 - I thought it was a doc line
   arch/x86/kernel/cpu/resctrl/monitor.c:41: warning: Cannot understand  * @rmid_limbo_count     count of currently unused but (potentially)
    on line 41 - I thought it was a doc line
   arch/x86/kernel/cpu/resctrl/monitor.c:50: warning: Cannot understand  * @rmid_entry - The entry in the limbo and free lists.
    on line 50 - I thought it was a doc line
   kernel/relay.c: In function 'relay_create_buf_file':
   kernel/relay.c:357:42: warning: 'snprintf' output may be truncated before the last format character [-Wformat-truncation=]
     357 |         snprintf(tmpname, NAME_MAX, "%s%d", chan->base_filename, cpu);
         |                                          ^
   kernel/relay.c:357:9: note: 'snprintf' output between 2 and 266 bytes into a destination of size 255
     357 |         snprintf(tmpname, NAME_MAX, "%s%d", chan->base_filename, cpu);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/x86/kernel/cpu/sgx/main.c:740: warning: Function parameter or member 'low' not described in 'sgx_calc_section_metric'
   arch/x86/kernel/cpu/sgx/main.c:740: warning: Function parameter or member 'high' not described in 'sgx_calc_section_metric'
   arch/x86/kernel/cpu/sgx/main.c:740: warning: expecting prototype for A section metric is concatenated in a way that @low bits 12(). Prototype was for sgx_calc_section_metric() instead
   drivers/base/power/runtime.c:362: warning: Excess function parameter 'dev' description in '__rpm_callback'
   drivers/base/module.c: In function 'module_add_driver':
   drivers/base/module.c:36:13: warning: variable 'no_warn' set but not used [-Wunused-but-set-variable]
      36 |         int no_warn;
         |             ^~~~~~~
   kernel/latencytop.c:178: warning: Function parameter or member 'tsk' not described in '__account_scheduler_latency'
   kernel/latencytop.c:178: warning: Function parameter or member 'usecs' not described in '__account_scheduler_latency'
   kernel/latencytop.c:178: warning: Function parameter or member 'inter' not described in '__account_scheduler_latency'
   fs/proc/proc_net.c:161: warning: Function parameter or member 'state_size' not described in 'proc_create_net_data_write'
   arch/x86/kernel/apic/apic.c:2168: warning: Function parameter or member 'spurious_interrupt' not described in 'DEFINE_IDTENTRY_IRQ'
   arch/x86/kernel/apic/apic.c:2168: warning: expecting prototype for spurious_interrupt(). Prototype was for DEFINE_IDTENTRY_IRQ() instead
   kernel/trace/ftrace.c:1287: warning: Function parameter or member 'ops' not described in 'ftrace_free_filter'
   kernel/trace/ftrace.c:5487: warning: Function parameter or member 'addr' not described in 'unregister_ftrace_direct'
   kernel/trace/ftrace.c:5487: warning: Function parameter or member 'free_filters' not described in 'unregister_ftrace_direct'
   kernel/trace/ftrace.c:5638: warning: Function parameter or member 'ops' not described in 'ftrace_set_filter_ip'
   kernel/trace/ftrace.c:5638: warning: Function parameter or member 'ip' not described in 'ftrace_set_filter_ip'
   kernel/trace/ftrace.c:5638: warning: Function parameter or member 'remove' not described in 'ftrace_set_filter_ip'
   kernel/trace/ftrace.c:5638: warning: Function parameter or member 'reset' not described in 'ftrace_set_filter_ip'
   kernel/trace/ftrace.c:5661: warning: Function parameter or member 'ops' not described in 'ftrace_set_filter_ips'
   kernel/trace/ftrace.c:5661: warning: Function parameter or member 'ips' not described in 'ftrace_set_filter_ips'
   kernel/trace/ftrace.c:5661: warning: Function parameter or member 'cnt' not described in 'ftrace_set_filter_ips'
   kernel/trace/ftrace.c:5661: warning: Function parameter or member 'remove' not described in 'ftrace_set_filter_ips'
   kernel/trace/ftrace.c:5661: warning: Function parameter or member 'reset' not described in 'ftrace_set_filter_ips'
   kernel/trace/ftrace.c:5675: warning: Function parameter or member 'ops' not described in 'ftrace_ops_set_global_filter'
   kernel/trace/ftrace.c:5707: warning: Function parameter or member 'ops' not described in 'ftrace_set_filter'
   kernel/trace/ftrace.c:5707: warning: Function parameter or member 'buf' not described in 'ftrace_set_filter'
   kernel/trace/ftrace.c:5707: warning: Function parameter or member 'len' not described in 'ftrace_set_filter'
   kernel/trace/ftrace.c:5707: warning: Function parameter or member 'reset' not described in 'ftrace_set_filter'
   kernel/trace/ftrace.c:5730: warning: Function parameter or member 'ops' not described in 'ftrace_set_notrace'
   kernel/trace/ftrace.c:5730: warning: Function parameter or member 'buf' not described in 'ftrace_set_notrace'
   kernel/trace/ftrace.c:5730: warning: Function parameter or member 'len' not described in 'ftrace_set_notrace'
   kernel/trace/ftrace.c:5730: warning: Function parameter or member 'reset' not described in 'ftrace_set_notrace'
   kernel/trace/ftrace.c:5745: warning: Function parameter or member 'buf' not described in 'ftrace_set_global_filter'
   kernel/trace/ftrace.c:5745: warning: Function parameter or member 'len' not described in 'ftrace_set_global_filter'
   kernel/trace/ftrace.c:5745: warning: Function parameter or member 'reset' not described in 'ftrace_set_global_filter'
   kernel/trace/ftrace.c:5761: warning: Function parameter or member 'buf' not described in 'ftrace_set_global_notrace'
   kernel/trace/ftrace.c:5761: warning: Function parameter or member 'len' not described in 'ftrace_set_global_notrace'
   kernel/trace/ftrace.c:5761: warning: Function parameter or member 'reset' not described in 'ftrace_set_global_notrace'
   In file included from include/linux/string.h:254,
                    from include/linux/bitmap.h:11,
                    from include/linux/cpumask.h:12,
                    from arch/x86/include/asm/cpumask.h:5,
                    from arch/x86/include/asm/msr.h:11,
                    from arch/x86/include/asm/processor.h:23,
                    from arch/x86/include/asm/cpufeature.h:5,
                    from arch/x86/include/asm/thread_info.h:53,
                    from include/linux/thread_info.h:60,
                    from arch/x86/include/asm/preempt.h:9,
                    from include/linux/preempt.h:79,
                    from include/linux/spinlock.h:56,
                    from include/linux/mmzone.h:8,
                    from include/linux/memremap.h:5,
                    from drivers/dax/bus.c:3:
   In function 'strncpy',
       inlined from 'do_id_store' at drivers/dax/bus.c:106:5:
   include/linux/fortify-string.h:68:33: warning: '__builtin_strncpy' specified bound 30 equals destination size [-Wstringop-truncation]
      68 | #define __underlying_strncpy    __builtin_strncpy
         |                                 ^
   include/linux/fortify-string.h:151:16: note: in expansion of macro '__underlying_strncpy'
     151 |         return __underlying_strncpy(p, q, size);
         |                ^~~~~~~~~~~~~~~~~~~~
   kernel/trace/pid_list.c:458: warning: Function parameter or member 'pid_list' not described in 'trace_pid_list_free'
   drivers/dma-buf/dma-heap.c:44: warning: Function parameter or member 'priv' not described in 'dma_heap'
   drivers/dma-buf/dma-heap.c:44: warning: Function parameter or member 'heap_devt' not described in 'dma_heap'
   drivers/dma-buf/dma-heap.c:44: warning: Function parameter or member 'list' not described in 'dma_heap'
   drivers/dma-buf/dma-heap.c:44: warning: Function parameter or member 'heap_cdev' not described in 'dma_heap'
   kernel/context_tracking.c:467: warning: Function parameter or member 'state' not described in '__ct_user_enter'
   kernel/context_tracking.c:607: warning: Function parameter or member 'state' not described in '__ct_user_exit'
   kernel/trace/fgraph.c:334: warning: Function parameter or member 'task' not described in 'ftrace_graph_ret_addr'
   kernel/trace/fgraph.c:334: warning: Function parameter or member 'idx' not described in 'ftrace_graph_ret_addr'
   kernel/trace/fgraph.c:334: warning: Function parameter or member 'ret' not described in 'ftrace_graph_ret_addr'
   kernel/trace/fgraph.c:334: warning: Function parameter or member 'retp' not described in 'ftrace_graph_ret_addr'
   kernel/trace/trace_events_synth.c:1165: warning: Excess function parameter 'args' description in '__synth_event_gen_cmd_start'
   kernel/trace/trace_events_synth.c:1714: warning: Excess function parameter 'args' description in 'synth_event_trace'
>> net/ipv4/udp_tunnel_nic.c:51: warning: Excess struct member 'entries' description in 'udp_tunnel_nic'
   kernel/bpf/btf.c: In function 'btf_seq_show':
   kernel/bpf/btf.c:7094:29: warning: function 'btf_seq_show' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
    7094 |         seq_vprintf((struct seq_file *)show->target, fmt, args);
         |                             ^~~~~~~~
   kernel/bpf/btf.c: In function 'btf_snprintf_show':
   kernel/bpf/btf.c:7131:9: warning: function 'btf_snprintf_show' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
    7131 |         len = vsnprintf(show->target, ssnprintf->len_left, fmt, args);
         |         ^~~
   kernel/trace/trace_kprobe.c:985: warning: Excess function parameter 'args' description in '__kprobe_event_gen_cmd_start'
   kernel/trace/trace_kprobe.c:1053: warning: Excess function parameter 'args' description in '__kprobe_event_add_fields'
   drivers/firewire/init_ohci1394_dma.c:178: warning: Function parameter or member 'ohci' not described in 'init_ohci1394_wait_for_busresets'
   drivers/firewire/init_ohci1394_dma.c:196: warning: Function parameter or member 'ohci' not described in 'init_ohci1394_enable_physical_dma'
   drivers/firewire/init_ohci1394_dma.c:207: warning: Function parameter or member 'ohci' not described in 'init_ohci1394_reset_and_init_dma'
   drivers/firewire/init_ohci1394_dma.c:236: warning: Function parameter or member 'num' not described in 'init_ohci1394_controller'
   drivers/firewire/init_ohci1394_dma.c:236: warning: Function parameter or member 'slot' not described in 'init_ohci1394_controller'
   drivers/firewire/init_ohci1394_dma.c:236: warning: Function parameter or member 'func' not described in 'init_ohci1394_controller'
   drivers/firewire/init_ohci1394_dma.c:289: warning: Function parameter or member 'opt' not described in 'setup_ohci1394_dma'
   In file included from include/linux/kernel.h:30,
                    from arch/x86/include/asm/percpu.h:27,
                    from arch/x86/include/asm/preempt.h:6,
                    from include/linux/preempt.h:79,
                    from include/linux/spinlock.h:56,
                    from include/linux/wait.h:9,
                    from include/linux/wait_bit.h:8,
                    from include/linux/fs.h:6,
                    from include/linux/highmem.h:5,
                    from include/linux/bvec.h:10,
                    from include/linux/blk_types.h:10,
                    from include/linux/blkdev.h:9,
                    from drivers/scsi/scsi_devinfo.c:3:
   drivers/scsi/scsi_devinfo.c: In function 'scsi_dev_info_list_add_str':
   include/linux/kern_levels.h:5:25: warning: '%s' directive argument is null [-Wformat-overflow=]
       5 | #define KERN_SOH        "\001"          /* ASCII Start Of Header */
         |                         ^~~~~~
   include/linux/printk.h:427:25: note: in definition of macro 'printk_index_wrap'
     427 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                         ^~~~
   drivers/scsi/scsi_devinfo.c:554:25: note: in expansion of macro 'printk'
     554 |                         printk(KERN_ERR "%s: bad dev info string '%s' '%s'"
         |                         ^~~~~~
   include/linux/kern_levels.h:11:25: note: in expansion of macro 'KERN_SOH'
      11 | #define KERN_ERR        KERN_SOH "3"    /* error conditions */
         |                         ^~~~~~~~
   drivers/scsi/scsi_devinfo.c:554:32: note: in expansion of macro 'KERN_ERR'
     554 |                         printk(KERN_ERR "%s: bad dev info string '%s' '%s'"
         |                                ^~~~~~~~
   drivers/usb/core/usb.c: In function 'usb_alloc_dev':
   drivers/usb/core/usb.c:706:37: warning: '%d' directive output may be truncated writing between 1 and 11 bytes into a region of size between 0 and 15 [-Wformat-truncation=]
     706 |                                 "%s.%d", parent->devpath, port1);
         |                                     ^~
   drivers/usb/core/usb.c:706:33: note: using the range [-2147483648, 2147483647] for directive argument
     706 |                                 "%s.%d", parent->devpath, port1);
         |                                 ^~~~~~~
   drivers/usb/core/usb.c:705:25: note: 'snprintf' output between 3 and 28 bytes into a destination of size 16
     705 |                         snprintf(dev->devpath, sizeof dev->devpath,
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     706 |                                 "%s.%d", parent->devpath, port1);
         |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/usb/core/hcd.c: In function 'rh_string':
   drivers/usb/core/hcd.c:443:48: warning: '%s' directive output may be truncated writing up to 64 bytes into a region of size between 35 and 99 [-Wformat-truncation=]
     443 |                 snprintf (buf, sizeof buf, "%s %s %s", init_utsname()->sysname,
         |                                                ^~
     444 |                         init_utsname()->release, hcd->driver->description);
         |                         ~~~~~~~~~~~~~~~~~~~~~~~ 
   drivers/usb/core/hcd.c:443:17: note: 'snprintf' output 3 or more bytes (assuming 131) into a destination of size 100
     443 |                 snprintf (buf, sizeof buf, "%s %s %s", init_utsname()->sysname,
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     444 |                         init_utsname()->release, hcd->driver->description);
         |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/usb/host/xhci.c:1318: warning: Function parameter or member 'desc' not described in 'xhci_get_endpoint_index'
   drivers/input/keyboard/atkbd.c: In function 'atkbd_set_device_attrs':
   drivers/input/keyboard/atkbd.c:1153:21: warning: '/input0' directive output may be truncated writing 7 bytes into a region of size between 1 and 32 [-Wformat-truncation=]
    1153 |                  "%s/input0", atkbd->ps2dev.serio->phys);
         |                     ^~~~~~~
   drivers/input/keyboard/atkbd.c:1152:9: note: 'snprintf' output between 8 and 39 bytes into a destination of size 32
    1152 |         snprintf(atkbd->phys, sizeof(atkbd->phys),
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    1153 |                  "%s/input0", atkbd->ps2dev.serio->phys);
         |                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/input/mouse/psmouse-base.c: In function 'psmouse_connect':
   drivers/input/mouse/psmouse-base.c:1603:59: warning: '/input0' directive output may be truncated writing 7 bytes into a region of size between 1 and 32 [-Wformat-truncation=]
    1603 |         snprintf(psmouse->phys, sizeof(psmouse->phys), "%s/input0", serio->phys);
         |                                                           ^~~~~~~
   drivers/input/mouse/psmouse-base.c:1603:9: note: 'snprintf' output between 8 and 39 bytes into a destination of size 32
    1603 |         snprintf(psmouse->phys, sizeof(psmouse->phys), "%s/input0", serio->phys);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/net/usb/asix.h:28,
                    from drivers/net/usb/ax88172a.c:15:
   drivers/net/usb/ax88172a.c: In function 'ax88172a_reset':
   include/linux/phy.h:300:20: warning: '%s' directive output may be truncated writing up to 60 bytes into a region of size 20 [-Wformat-truncation=]
     300 | #define PHY_ID_FMT "%s:%02x"
         |                    ^~~~~~~~~
   drivers/net/usb/ax88172a.c:309:38: note: in expansion of macro 'PHY_ID_FMT'
     309 |         snprintf(priv->phy_name, 20, PHY_ID_FMT,
         |                                      ^~~~~~~~~~
   include/linux/phy.h:300:21: note: format string is defined here
     300 | #define PHY_ID_FMT "%s:%02x"
         |                     ^~
   include/linux/phy.h:300:20: note: directive argument in the range [0, 65535]
     300 | #define PHY_ID_FMT "%s:%02x"


vim +51 net/ipv4/udp_tunnel_nic.c

cc4e3835eff474 Jakub Kicinski     2020-07-09  27  
cc4e3835eff474 Jakub Kicinski     2020-07-09  28  /**
cc4e3835eff474 Jakub Kicinski     2020-07-09  29   * struct udp_tunnel_nic - UDP tunnel port offload state
cc4e3835eff474 Jakub Kicinski     2020-07-09  30   * @work:	async work for talking to hardware from process context
cc4e3835eff474 Jakub Kicinski     2020-07-09  31   * @dev:	netdev pointer
cc4e3835eff474 Jakub Kicinski     2020-07-09  32   * @need_sync:	at least one port start changed
cc4e3835eff474 Jakub Kicinski     2020-07-09  33   * @need_replay: space was freed, we need a replay of all ports
cc4e3835eff474 Jakub Kicinski     2020-07-09  34   * @work_pending: @work is currently scheduled
cc4e3835eff474 Jakub Kicinski     2020-07-09  35   * @n_tables:	number of tables under @entries
cc4e3835eff474 Jakub Kicinski     2020-07-09  36   * @missed:	bitmap of tables which overflown
cc4e3835eff474 Jakub Kicinski     2020-07-09  37   * @entries:	table of tables of ports currently offloaded
cc4e3835eff474 Jakub Kicinski     2020-07-09  38   */
cc4e3835eff474 Jakub Kicinski     2020-07-09  39  struct udp_tunnel_nic {
cc4e3835eff474 Jakub Kicinski     2020-07-09  40  	struct work_struct work;
cc4e3835eff474 Jakub Kicinski     2020-07-09  41  
cc4e3835eff474 Jakub Kicinski     2020-07-09  42  	struct net_device *dev;
cc4e3835eff474 Jakub Kicinski     2020-07-09  43  
cc4e3835eff474 Jakub Kicinski     2020-07-09  44  	u8 need_sync:1;
cc4e3835eff474 Jakub Kicinski     2020-07-09  45  	u8 need_replay:1;
cc4e3835eff474 Jakub Kicinski     2020-07-09  46  	u8 work_pending:1;
cc4e3835eff474 Jakub Kicinski     2020-07-09  47  
cc4e3835eff474 Jakub Kicinski     2020-07-09  48  	unsigned int n_tables;
cc4e3835eff474 Jakub Kicinski     2020-07-09  49  	unsigned long missed;
ef35bed6fad6ed Christophe JAILLET 2023-09-24  50  	struct udp_tunnel_nic_table_entry *entries[] __counted_by(n_tables);
cc4e3835eff474 Jakub Kicinski     2020-07-09 @51  };
cc4e3835eff474 Jakub Kicinski     2020-07-09  52  

:::::: The code at line 51 was first introduced by commit
:::::: cc4e3835eff474aa274d6e1d18f69d9d296d3b76 udp_tunnel: add central NIC RX port offload infrastructure

:::::: TO: Jakub Kicinski <kuba@kernel.org>
:::::: CC: David S. Miller <davem@davemloft.net>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

