Return-Path: <linux-kernel+bounces-133598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6EE689A620
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 23:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BD721F229AA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 21:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DEC6175547;
	Fri,  5 Apr 2024 21:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CwtjxYLv"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F15175542
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 21:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712353146; cv=none; b=QJS9Wm8l263J4ULqrqwE2DFVaG7X2AVVIUwBqNV6wkXiYREP4EOpsPEFSv4IWkQXR1iPXW1sq3MOzEODEMTw5KdPSJu8L5mOubukXsIiufBYAdUYprwAyElarWk2DSTFqI7uYyaAyKfLCAG2GbvexssxXtsHkBVCNxfF8TzDtIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712353146; c=relaxed/simple;
	bh=RApPKc3hERr9acqKp2HDcK1WouGmIIjMZlqQdY0Nznc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gn2BZ+pRnmJ36j4xRIgiiLDt7XCBw+u/pwOTtrgyuUMz4UP9kL7MXKyGAHOgsuri0Sr/XENgOJ2s+OA7YcdhsiDoYKXY++xq23NYZpcpwhH4dsKFHK/bE2Ufq2srgJ4/RuLBwOabq3ZWdLvWdLH4u8qYs9lhmmbQM+zIJqgol48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CwtjxYLv; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712353144; x=1743889144;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=RApPKc3hERr9acqKp2HDcK1WouGmIIjMZlqQdY0Nznc=;
  b=CwtjxYLvLcxeFSSiagmjun0kCD5l8fFy/G3+WIgkWUJsWPodSDvXGVLL
   dbTM7nyldPXEZqV9+9XG5QAn8+5pUz9fQsfirYY+LF9YtdpQvX6Bt0u4k
   9tqzKMavkG2cK5mXVNuH1vA1kEBN+TbgzN8q8ldVJo4y+kcJQYgbUgvjc
   HuoGWSvFbeIR/qnpEOz7hzP+mcNGXkygqbzsqq8Ewre5YgDVjcpyNKkiR
   peWloTvje26lG1Ne269E/5iwe9U9vUgcsfoZ4prQXkl00Q7S3qVpSxQkQ
   aStjrrnCgeyYLRvGt72TR4fvOyHxZxwO8bICcrvYL8bkxueKAFSLKBc59
   Q==;
X-CSE-ConnectionGUID: qLhRhKeFTuK8qkbVB8XSEA==
X-CSE-MsgGUID: RHx2+OmQRv+75YToN9X/JA==
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="18840577"
X-IronPort-AV: E=Sophos;i="6.07,182,1708416000"; 
   d="scan'208";a="18840577"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 14:39:04 -0700
X-CSE-ConnectionGUID: GxtPERJYSjeB/dWEZryBdw==
X-CSE-MsgGUID: I+/WaPIQRA208X13N8nkHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,182,1708416000"; 
   d="scan'208";a="24019680"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 05 Apr 2024 14:39:02 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rsrH1-0002jh-21;
	Fri, 05 Apr 2024 21:38:59 +0000
Date: Sat, 6 Apr 2024 05:38:30 +0800
From: kernel test robot <lkp@intel.com>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Nick Desaulniers <ndesaulniers@google.com>
Subject: ERROR: modpost: vmlinux: local symbol 'halt_poll_ns' was exported
Message-ID: <202404060553.ewUhiAmu-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Masahiro,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   8cb4a9a82b21623dbb4b3051dd30d98356cf95bc
commit: 6d62b1c46b1e6e1686a0cf6617c96c80d4ab5cd5 modpost: check static EXPORT_SYMBOL* by modpost again
date:   10 months ago
config: riscv-randconfig-r042-20221001 (https://download.01.org/0day-ci/archive/20240406/202404060553.ewUhiAmu-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240406/202404060553.ewUhiAmu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404060553.ewUhiAmu-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: vmlinux: section mismatch in reference: vortex_a3d_register_controls.isra.0 (section: .text.unlikely) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vortex_a3d_register_controls.isra.0 (section: .text.unlikely) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vortex_a3d_register_controls.isra.0 (section: .text.unlikely) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vortex_a3d_register_controls.isra.0 (section: .text.unlikely) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: $xrv32i2p1_m2p0_a2p1_zicsr2p0_zifencei2p0_zihintpause2p0_zmmul1p0 (section: .text.unlikely) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: $xrv32i2p1_m2p0_a2p1_zicsr2p0_zifencei2p0_zihintpause2p0_zmmul1p0 (section: .text.unlikely) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: $xrv32i2p1_m2p0_a2p1_zicsr2p0_zifencei2p0_zihintpause2p0_zmmul1p0 (section: .text.unlikely) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: $xrv32i2p1_m2p0_a2p1_zicsr2p0_zifencei2p0_zihintpause2p0_zmmul1p0 (section: .text.unlikely) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: $xrv32i2p1_m2p0_a2p1_zicsr2p0_zifencei2p0_zihintpause2p0_zmmul1p0 (section: .text.unlikely) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: $xrv32i2p1_m2p0_a2p1_zicsr2p0_zifencei2p0_zihintpause2p0_zmmul1p0 (section: .text.unlikely) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: $xrv32i2p1_m2p0_a2p1_zicsr2p0_zifencei2p0_zihintpause2p0_zmmul1p0 (section: .text.unlikely) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: $xrv32i2p1_m2p0_a2p1_zicsr2p0_zifencei2p0_zihintpause2p0_zmmul1p0 (section: .text.unlikely) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: $xrv32i2p1_m2p0_a2p1_zicsr2p0_zifencei2p0_zihintpause2p0_zmmul1p0 (section: .text.unlikely) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: $xrv32i2p1_m2p0_a2p1_zicsr2p0_zifencei2p0_zihintpause2p0_zmmul1p0 (section: .text.unlikely) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: $xrv32i2p1_m2p0_a2p1_zicsr2p0_zifencei2p0_zihintpause2p0_zmmul1p0 (section: .text.unlikely) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: $xrv32i2p1_m2p0_a2p1_zicsr2p0_zifencei2p0_zihintpause2p0_zmmul1p0 (section: .text.unlikely) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: $xrv32i2p1_m2p0_a2p1_zicsr2p0_zifencei2p0_zihintpause2p0_zmmul1p0 (section: .text.unlikely) -> riscv_kvm_exit (section: .exit.text)
WARNING: modpost: vmlinux: section mismatch in reference: $xrv32i2p1_m2p0_a2p1_zicsr2p0_zifencei2p0_zihintpause2p0_zmmul1p0 (section: .text.unlikely) -> riscv_kvm_exit (section: .exit.text)
WARNING: modpost: vmlinux: section mismatch in reference: $xrv32i2p1_m2p0_a2p1_zicsr2p0_zifencei2p0_zihintpause2p0_zmmul1p0 (section: .text.unlikely) -> riscv_kvm_exit (section: .exit.text)
WARNING: modpost: vmlinux: section mismatch in reference: $xrv32i2p1_m2p0_a2p1_zicsr2p0_zifencei2p0_zihintpause2p0_zmmul1p0 (section: .text.unlikely) -> riscv_kvm_exit (section: .exit.text)
WARNING: modpost: vmlinux: section mismatch in reference: $xrv32i2p1_m2p0_a2p1_zicsr2p0_zifencei2p0_zihintpause2p0_zmmul1p0 (section: .text.unlikely) -> init_setup (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: $xrv32i2p1_m2p0_a2p1_zicsr2p0_zifencei2p0_zihintpause2p0_zmmul1p0 (section: .text.unlikely) -> init_setup (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: $xrv32i2p1_m2p0_a2p1_zicsr2p0_zifencei2p0_zihintpause2p0_zmmul1p0 (section: .text.unlikely) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: $xrv32i2p1_m2p0_a2p1_zicsr2p0_zifencei2p0_zihintpause2p0_zmmul1p0 (section: .text.unlikely) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: $xrv32i2p1_m2p0_a2p1_zicsr2p0_zifencei2p0_zihintpause2p0_zmmul1p0 (section: .exit.text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: $xrv32i2p1_m2p0_a2p1_zicsr2p0_zifencei2p0_zihintpause2p0_zmmul1p0 (section: .exit.text) -> debug_kernel (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: $xrv32i2p1_m2p0_a2p1_zicsr2p0_zifencei2p0_zihintpause2p0_zmmul1p0 (section: .exit.text) -> debug_kernel (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: isi_unregister (section: .exit.text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: isi_unregister (section: .exit.text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: $xrv32i2p1_m2p0_a2p1_zicsr2p0_zifencei2p0_zihintpause2p0_zmmul1p0 (section: .exit.text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: $xrv32i2p1_m2p0_a2p1_zicsr2p0_zifencei2p0_zihintpause2p0_zmmul1p0 (section: .exit.text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: $xrv32i2p1_m2p0_a2p1_zicsr2p0_zifencei2p0_zihintpause2p0_zmmul1p0 (section: .exit.text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: $xrv32i2p1_m2p0_a2p1_zicsr2p0_zifencei2p0_zihintpause2p0_zmmul1p0 (section: .exit.text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: $xrv32i2p1_m2p0_a2p1_zicsr2p0_zifencei2p0_zihintpause2p0_zmmul1p0 (section: .exit.text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: $xrv32i2p1_m2p0_a2p1_zicsr2p0_zifencei2p0_zihintpause2p0_zmmul1p0 (section: .exit.text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: $xrv32i2p1_m2p0_a2p1_zicsr2p0_zifencei2p0_zihintpause2p0_zmmul1p0 (section: .exit.text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: $xrv32i2p1_m2p0_a2p1_zicsr2p0_zifencei2p0_zihintpause2p0_zmmul1p0 (section: .exit.text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: $xrv32i2p1_m2p0_a2p1_zicsr2p0_zifencei2p0_zihintpause2p0_zmmul1p0 (section: .exit.text) -> set_reset_devices (section: .init.text)
ERROR: modpost: vmlinux: local symbol 'system_state' was exported
ERROR: modpost: vmlinux: local symbol 'static_key_initialized' was exported
ERROR: modpost: vmlinux: local symbol 'reset_devices' was exported
ERROR: modpost: vmlinux: local symbol 'loops_per_jiffy' was exported
ERROR: modpost: vmlinux: local symbol 'init_uts_ns' was exported
ERROR: modpost: vmlinux: local symbol 'name_to_dev_t' was exported
ERROR: modpost: vmlinux: local symbol 'wait_for_initramfs' was exported
ERROR: modpost: vmlinux: local symbol 'init_task' was exported
ERROR: modpost: vmlinux: local symbol 'riscv_cached_mvendorid' was exported
ERROR: modpost: vmlinux: local symbol 'riscv_cached_marchid' was exported
ERROR: modpost: vmlinux: local symbol 'riscv_cached_mimpid' was exported
ERROR: modpost: vmlinux: local symbol 'riscv_isa_extension_base' was exported
ERROR: modpost: vmlinux: local symbol '__riscv_isa_extension_available' was exported
ERROR: modpost: vmlinux: local symbol 'riscv_get_intc_hwnode' was exported
ERROR: modpost: vmlinux: local symbol 'pm_power_off' was exported
ERROR: modpost: vmlinux: local symbol 'riscv_timebase' was exported
ERROR: modpost: vmlinux: local symbol 'memset' was exported
ERROR: modpost: vmlinux: local symbol 'memcpy' was exported
ERROR: modpost: vmlinux: local symbol 'memmove' was exported
ERROR: modpost: vmlinux: local symbol 'strcmp' was exported
ERROR: modpost: vmlinux: local symbol 'strlen' was exported
ERROR: modpost: vmlinux: local symbol 'strncmp' was exported
ERROR: modpost: vmlinux: local symbol '__memset' was exported
ERROR: modpost: vmlinux: local symbol '__memcpy' was exported
ERROR: modpost: vmlinux: local symbol '__memmove' was exported
ERROR: modpost: vmlinux: local symbol 'riscv_set_cacheinfo_ops' was exported
ERROR: modpost: vmlinux: local symbol 'riscv_ipi_for_rfence' was exported
ERROR: modpost: vmlinux: local symbol 'arch_smp_send_reschedule' was exported
ERROR: modpost: vmlinux: local symbol 'sbi_spec_version' was exported
ERROR: modpost: vmlinux: local symbol 'sbi_ecall' was exported
ERROR: modpost: vmlinux: local symbol 'sbi_err_map_linux_errno' was exported
ERROR: modpost: vmlinux: local symbol 'sbi_console_putchar' was exported
ERROR: modpost: vmlinux: local symbol 'sbi_console_getchar' was exported
ERROR: modpost: vmlinux: local symbol 'sbi_shutdown' was exported
ERROR: modpost: vmlinux: local symbol 'sbi_send_ipi' was exported
ERROR: modpost: vmlinux: local symbol 'sbi_remote_fence_i' was exported
ERROR: modpost: vmlinux: local symbol 'sbi_remote_sfence_vma' was exported
ERROR: modpost: vmlinux: local symbol 'sbi_remote_sfence_vma_asid' was exported
ERROR: modpost: vmlinux: local symbol 'sbi_remote_hfence_gvma' was exported
ERROR: modpost: vmlinux: local symbol 'sbi_remote_hfence_gvma_vmid' was exported
ERROR: modpost: vmlinux: local symbol 'sbi_remote_hfence_vvma' was exported
ERROR: modpost: vmlinux: local symbol 'sbi_remote_hfence_vvma_asid' was exported
ERROR: modpost: vmlinux: local symbol 'sbi_probe_extension' was exported
ERROR: modpost: vmlinux: local symbol 'sbi_get_mvendorid' was exported
ERROR: modpost: vmlinux: local symbol 'sbi_get_marchid' was exported
ERROR: modpost: vmlinux: local symbol 'sbi_get_mimpid' was exported
ERROR: modpost: vmlinux: local symbol 'kernel_map' was exported
ERROR: modpost: vmlinux: local symbol 'satp_mode' was exported
ERROR: modpost: vmlinux: local symbol 'pgtable_l4_enabled' was exported
ERROR: modpost: vmlinux: local symbol 'pgtable_l5_enabled' was exported
ERROR: modpost: vmlinux: local symbol 'phys_ram_base' was exported
ERROR: modpost: vmlinux: local symbol 'empty_zero_page' was exported
ERROR: modpost: vmlinux: local symbol 'vm_get_page_prot' was exported
ERROR: modpost: vmlinux: local symbol 'flush_icache_all' was exported
ERROR: modpost: vmlinux: local symbol 'riscv_cbom_block_size' was exported
ERROR: modpost: vmlinux: local symbol 'riscv_cboz_block_size' was exported
ERROR: modpost: vmlinux: local symbol 'arch_wb_cache_pmem' was exported
ERROR: modpost: vmlinux: local symbol 'arch_invalidate_pmem' was exported
ERROR: modpost: vmlinux: local symbol '__virt_to_phys' was exported
ERROR: modpost: vmlinux: local symbol '__phys_addr_symbol' was exported
ERROR: modpost: vmlinux: local symbol 'linear_mapping_va_to_pa' was exported
ERROR: modpost: vmlinux: local symbol 'linear_mapping_pa_to_va' was exported
>> ERROR: modpost: vmlinux: local symbol 'halt_poll_ns' was exported
>> ERROR: modpost: vmlinux: local symbol 'halt_poll_ns_grow' was exported
>> ERROR: modpost: vmlinux: local symbol 'halt_poll_ns_grow_start' was exported
>> ERROR: modpost: vmlinux: local symbol 'halt_poll_ns_shrink' was exported
>> ERROR: modpost: vmlinux: local symbol 'kvm_debugfs_dir' was exported
>> ERROR: modpost: vmlinux: local symbol 'vcpu_load' was exported
>> ERROR: modpost: vmlinux: local symbol 'vcpu_put' was exported
>> ERROR: modpost: vmlinux: local symbol 'kvm_make_all_cpus_request' was exported
>> ERROR: modpost: vmlinux: local symbol 'kvm_flush_remote_tlbs' was exported
>> ERROR: modpost: vmlinux: local symbol 'kvm_destroy_vcpus' was exported
>> ERROR: modpost: vmlinux: local symbol 'kvm_get_kvm' was exported
>> ERROR: modpost: vmlinux: local symbol 'kvm_get_kvm_safe' was exported
>> ERROR: modpost: vmlinux: local symbol 'kvm_put_kvm' was exported
>> ERROR: modpost: vmlinux: local symbol 'kvm_put_kvm_no_destroy' was exported
>> ERROR: modpost: vmlinux: local symbol '__kvm_set_memory_region' was exported
>> ERROR: modpost: vmlinux: local symbol 'kvm_set_memory_region' was exported
>> ERROR: modpost: vmlinux: local symbol 'gfn_to_memslot' was exported
>> ERROR: modpost: vmlinux: local symbol 'kvm_is_visible_gfn' was exported
>> ERROR: modpost: vmlinux: local symbol 'kvm_vcpu_is_visible_gfn' was exported
>> ERROR: modpost: vmlinux: local symbol 'gfn_to_hva_memslot' was exported
ERROR: modpost: vmlinux: local symbol 'gfn_to_hva' was exported
ERROR: modpost: vmlinux: local symbol 'kvm_vcpu_gfn_to_hva' was exported
ERROR: modpost: vmlinux: local symbol '__gfn_to_pfn_memslot' was exported
ERROR: modpost: vmlinux: local symbol 'gfn_to_pfn_prot' was exported
ERROR: modpost: vmlinux: local symbol 'gfn_to_pfn_memslot' was exported
ERROR: modpost: vmlinux: local symbol 'gfn_to_pfn_memslot_atomic' was exported
ERROR: modpost: vmlinux: local symbol 'kvm_vcpu_gfn_to_pfn_atomic' was exported
ERROR: modpost: vmlinux: local symbol 'gfn_to_pfn' was exported
ERROR: modpost: vmlinux: local symbol 'kvm_vcpu_gfn_to_pfn' was exported
ERROR: modpost: vmlinux: local symbol 'gfn_to_page_many_atomic' was exported
ERROR: modpost: vmlinux: local symbol 'gfn_to_page' was exported
ERROR: modpost: vmlinux: local symbol 'kvm_vcpu_map' was exported
ERROR: modpost: vmlinux: local symbol 'kvm_vcpu_unmap' was exported
ERROR: modpost: vmlinux: local symbol 'kvm_release_page_clean' was exported
ERROR: modpost: vmlinux: local symbol 'kvm_release_pfn_clean' was exported
ERROR: modpost: vmlinux: local symbol 'kvm_release_page_dirty' was exported
ERROR: modpost: vmlinux: local symbol 'kvm_release_pfn_dirty' was exported
ERROR: modpost: vmlinux: local symbol 'kvm_set_pfn_dirty' was exported
ERROR: modpost: vmlinux: local symbol 'kvm_set_pfn_accessed' was exported
ERROR: modpost: vmlinux: local symbol 'kvm_read_guest_page' was exported
ERROR: modpost: vmlinux: local symbol 'kvm_vcpu_read_guest_page' was exported
ERROR: modpost: vmlinux: local symbol 'kvm_read_guest' was exported
ERROR: modpost: vmlinux: local symbol 'kvm_vcpu_read_guest' was exported
ERROR: modpost: vmlinux: local symbol 'kvm_vcpu_read_guest_atomic' was exported
ERROR: modpost: vmlinux: local symbol 'kvm_write_guest_page' was exported
ERROR: modpost: vmlinux: local symbol 'kvm_vcpu_write_guest_page' was exported
ERROR: modpost: vmlinux: local symbol 'kvm_write_guest' was exported
ERROR: modpost: vmlinux: local symbol 'kvm_vcpu_write_guest' was exported
ERROR: modpost: vmlinux: local symbol 'kvm_gfn_to_hva_cache_init' was exported
ERROR: modpost: vmlinux: local symbol 'kvm_write_guest_offset_cached' was exported
ERROR: modpost: vmlinux: local symbol 'kvm_write_guest_cached' was exported
ERROR: modpost: vmlinux: local symbol 'kvm_read_guest_offset_cached' was exported
ERROR: modpost: vmlinux: local symbol 'kvm_read_guest_cached' was exported
ERROR: modpost: vmlinux: local symbol 'kvm_clear_guest' was exported
ERROR: modpost: vmlinux: local symbol 'mark_page_dirty_in_slot' was exported
ERROR: modpost: vmlinux: local symbol 'mark_page_dirty' was exported
ERROR: modpost: vmlinux: local symbol 'kvm_vcpu_mark_page_dirty' was exported
ERROR: modpost: vmlinux: local symbol 'kvm_vcpu_halt' was exported
ERROR: modpost: vmlinux: local symbol 'kvm_vcpu_wake_up' was exported
ERROR: modpost: vmlinux: local symbol 'kvm_vcpu_kick' was exported
ERROR: modpost: vmlinux: local symbol 'kvm_vcpu_yield_to' was exported
ERROR: modpost: vmlinux: local symbol 'kvm_vcpu_on_spin' was exported
ERROR: modpost: vmlinux: local symbol 'file_is_kvm' was exported
ERROR: modpost: vmlinux: local symbol 'kvm_rebooting' was exported
ERROR: modpost: vmlinux: local symbol 'kvm_io_bus_write' was exported
ERROR: modpost: vmlinux: local symbol 'kvm_io_bus_get_dev' was exported
ERROR: modpost: vmlinux: local symbol 'kvm_get_running_vcpu' was exported
ERROR: modpost: vmlinux: local symbol 'kvm_init' was exported
ERROR: modpost: vmlinux: local symbol 'kvm_exit' was exported
ERROR: modpost: vmlinux: local symbol 'lockdep_tasklist_lock_is_held' was exported
ERROR: modpost: vmlinux: local symbol 'free_task' was exported
ERROR: modpost: vmlinux: local symbol '__mmdrop' was exported
ERROR: modpost: vmlinux: local symbol '__put_task_struct' was exported
ERROR: modpost: vmlinux: local symbol 'mmput' was exported
ERROR: modpost: vmlinux: local symbol 'mmput_async' was exported
ERROR: modpost: vmlinux: local symbol 'get_task_mm' was exported
ERROR: modpost: vmlinux: local symbol 'panic_timeout' was exported
ERROR: modpost: vmlinux: local symbol 'panic_notifier_list' was exported
ERROR: modpost: vmlinux: local symbol 'panic_blink' was exported
ERROR: modpost: vmlinux: local symbol 'nmi_panic' was exported
ERROR: modpost: vmlinux: local symbol 'panic' was exported
ERROR: modpost: vmlinux: local symbol 'test_taint' was exported
ERROR: modpost: vmlinux: local symbol 'add_taint' was exported
ERROR: modpost: vmlinux: local symbol '__warn_printk' was exported
ERROR: modpost: vmlinux: local symbol 'cpuhp_tasks_frozen' was exported
ERROR: modpost: vmlinux: local symbol 'cpus_read_lock' was exported
ERROR: modpost: vmlinux: local symbol 'cpus_read_trylock' was exported
ERROR: modpost: vmlinux: local symbol 'cpus_read_unlock' was exported
ERROR: modpost: vmlinux: local symbol 'cpu_hotplug_disable' was exported
ERROR: modpost: vmlinux: local symbol 'cpu_hotplug_enable' was exported
ERROR: modpost: vmlinux: local symbol 'remove_cpu' was exported
ERROR: modpost: vmlinux: local symbol 'add_cpu' was exported
ERROR: modpost: vmlinux: local symbol '__cpuhp_state_add_instance' was exported
ERROR: modpost: vmlinux: local symbol '__cpuhp_setup_state_cpuslocked' was exported
ERROR: modpost: vmlinux: local symbol '__cpuhp_setup_state' was exported
ERROR: modpost: vmlinux: local symbol '__cpuhp_state_remove_instance' was exported
ERROR: modpost: vmlinux: local symbol '__cpuhp_remove_state_cpuslocked' was exported
ERROR: modpost: vmlinux: local symbol '__cpuhp_remove_state' was exported
ERROR: modpost: vmlinux: local symbol 'cpu_bit_bitmap' was exported
ERROR: modpost: vmlinux: local symbol 'cpu_all_bits' was exported
ERROR: modpost: vmlinux: local symbol '__cpu_possible_mask' was exported
ERROR: modpost: vmlinux: local symbol '__cpu_online_mask' was exported
ERROR: modpost: vmlinux: local symbol '__cpu_present_mask' was exported
ERROR: modpost: vmlinux: local symbol '__cpu_active_mask' was exported
ERROR: modpost: vmlinux: local symbol '__cpu_dying_mask' was exported
ERROR: modpost: vmlinux: local symbol '__num_online_cpus' was exported
ERROR: modpost: vmlinux: local symbol 'cpu_mitigations_off' was exported
ERROR: modpost: vmlinux: local symbol 'cpu_mitigations_auto_nosmt' was exported
ERROR: modpost: vmlinux: local symbol 'rcuwait_wake_up' was exported
ERROR: modpost: vmlinux: local symbol 'thread_group_exited' was exported
ERROR: modpost: vmlinux: local symbol 'abort' was exported
ERROR: modpost: vmlinux: local symbol 'irq_stat' was exported
ERROR: modpost: vmlinux: local symbol 'hardirqs_enabled' was exported
ERROR: modpost: vmlinux: local symbol 'hardirq_context' was exported
ERROR: modpost: vmlinux: local symbol '__local_bh_disable_ip' was exported
ERROR: modpost: vmlinux: local symbol '_local_bh_enable' was exported
ERROR: modpost: vmlinux: local symbol '__local_bh_enable_ip' was exported
ERROR: modpost: vmlinux: local symbol '__tasklet_schedule' was exported
ERROR: modpost: vmlinux: local symbol '__tasklet_hi_schedule' was exported
ERROR: modpost: vmlinux: local symbol 'tasklet_setup' was exported

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

