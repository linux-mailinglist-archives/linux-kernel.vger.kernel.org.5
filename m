Return-Path: <linux-kernel+bounces-163310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D53568B6938
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 05:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AF6B282090
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 03:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584EC10A3F;
	Tue, 30 Apr 2024 03:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YsvaRvb/"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D8610965
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 03:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714448953; cv=none; b=WCaFtix1CKffgYqxuk7Iu16MK7RKHoCRkoIr/5MuxDGQcj2SyMI5UQtqbdBxUfeDpmmIhXMOo1n/jZUu+K+iWo5Y0nTN1yKy+W4A/N59zgpjJrbTcIq35J+1zHxNYm4Wzi+j7kBSFFtRfe7Zwb0pFFobm1WOsgp4uFb6XHiiQeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714448953; c=relaxed/simple;
	bh=VnJo6D8keLMhdCEdKLIo/k8kio/Nymk9dgYI4CFTF1U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TPWSG2xrw4NkYFc1vWrbssQXf66/PENeXvBBgghRHqL9WdB5VFwMvWaBzgR7O+0vAPZcuQHtxlimg/UcYuva8PTUzxCWRjcC/NwmUMZq1LTVYLypiaqd3HI3N66nirTHOLYF9FpYPhUBmxrge7ICIaMSjl6fSRkW/9NvUVQEdsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YsvaRvb/; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714448951; x=1745984951;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=VnJo6D8keLMhdCEdKLIo/k8kio/Nymk9dgYI4CFTF1U=;
  b=YsvaRvb/7Ckk5mippBJtZut0mmOZqH7q7NQROA9Ss5SlTPjyw+TguT5k
   f7DwFCgkXnTt0Hkrz8L7YdkO9a870eC9U6ir7V5dnPzw4disUbRFAOCU1
   i62LeK6jXBt7pnlwnOpsBH31qVOkG8LHyW/YkDLIeSIdo1LiN1NWRfyRF
   DUI7oNdo3nbopBZdFk5O7K/UH2A0eROzWQgSvJ1hTHJ3Bqdiyrt7lDmxD
   vCaxmc4QTcirbVBHJc48FQwRV5AE4zq+P5byhI9/ai5vkBSkjdp8KNicc
   YL/W4By3+o6U2nAZVguOHze/TOqVEB2QbAoR5cabgbT1xoWs669fgNlUb
   Q==;
X-CSE-ConnectionGUID: GCt8HWWYSPisLDa/vKLAMA==
X-CSE-MsgGUID: aPpHjUfoSvOF2Y+qihjHcw==
X-IronPort-AV: E=McAfee;i="6600,9927,11059"; a="10058988"
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; 
   d="scan'208";a="10058988"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 20:49:11 -0700
X-CSE-ConnectionGUID: y2F3fv3QTQe+b5JnbI2K/g==
X-CSE-MsgGUID: BisON/nbSWGUt9AbFHZqog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; 
   d="scan'208";a="26184532"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 29 Apr 2024 20:49:09 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s1eUM-0007hO-0o;
	Tue, 30 Apr 2024 03:49:06 +0000
Date: Tue, 30 Apr 2024 11:48:13 +0800
From: kernel test robot <lkp@intel.com>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Alex Deucher <alexander.deucher@amd.com>,
	Shashank Sharma <shashank.sharma@amd.com>
Subject: WARNING: modpost: vmlinux: section mismatch in reference:
 init_engine+0x338 (section: .text) -> rcu_init_nohz (section: .init.text)
Message-ID: <202404301123.JIEK38Pb-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Johannes,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   98369dccd2f8e16bf4c6621053af7aa4821dcf8e
commit: 8678b1060ae2b75feb60b87e5b75e17374e3c1c5 drm/amdgpu: fix deadlock while reading mqd from debugfs
date:   5 weeks ago
config: riscv-randconfig-s041-20221002 (https://download.01.org/0day-ci/archive/20240430/202404301123.JIEK38Pb-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240430/202404301123.JIEK38Pb-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404301123.JIEK38Pb-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: vmlinux: section mismatch in reference: test_card_set_id+0x3b0 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: test_card_set_id+0x3cc (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: snd_via82xx_hw_params+0x2ac (section: .text) -> test_ww_mutex_exit (section: .exit.text)
WARNING: modpost: vmlinux: section mismatch in reference: snd_via82xx_hw_params+0x2d8 (section: .text) -> test_ww_mutex_exit (section: .exit.text)
WARNING: modpost: vmlinux: section mismatch in reference: snd_via82xx_hw_params+0x2e0 (section: .text) -> test_ww_mutex_exit (section: .exit.text)
WARNING: modpost: vmlinux: section mismatch in reference: snd_via82xx_hw_params+0x2f0 (section: .text) -> test_ww_mutex_exit (section: .exit.text)
WARNING: modpost: vmlinux: section mismatch in reference: snd_via82xx_hw_params+0x2f4 (section: .text) -> test_ww_mutex_exit (section: .exit.text)
WARNING: modpost: vmlinux: section mismatch in reference: snd_via82xx_hw_params+0x324 (section: .text) -> test_ww_mutex_exit (section: .exit.text)
WARNING: modpost: vmlinux: section mismatch in reference: __snd_via82xx_probe+0x7c (section: .text) -> test_ww_mutex_exit (section: .exit.text)
WARNING: modpost: vmlinux: section mismatch in reference: __snd_via82xx_probe+0xbc (section: .text) -> (unknown) (section: .exit.text)
WARNING: modpost: vmlinux: section mismatch in reference: __snd_via82xx_probe+0xc4 (section: .text) -> udelay_test_exit (section: .exit.text)
WARNING: modpost: vmlinux: section mismatch in reference: __snd_via82xx_probe+0x568 (section: .text) -> test_ww_mutex_exit (section: .exit.text)
WARNING: modpost: vmlinux: section mismatch in reference: __snd_via82xx_probe+0x728 (section: .text) -> test_ww_mutex_exit (section: .exit.text)
WARNING: modpost: vmlinux: section mismatch in reference: __snd_via82xx_probe+0x890 (section: .text) -> test_ww_mutex_exit (section: .exit.text)
WARNING: modpost: vmlinux: section mismatch in reference: __snd_via82xx_probe+0xa80 (section: .text) -> test_ww_mutex_exit (section: .exit.text)
WARNING: modpost: vmlinux: section mismatch in reference: alc655_iec958_route_get+0x70 (section: .text) -> pm_states_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: alc655_iec958_route_get+0xb4 (section: .text) -> pm_sysrq_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: snd_ac97_mixer+0x2928 (section: .text) -> mem_sleep_default_setup (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: snd_ac97_mixer+0x2948 (section: .text) -> mem_sleep_default_setup (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: snd_ac97_mixer+0x2978 (section: .text) -> mem_sleep_default_setup (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: snd_ac97_mixer+0x2990 (section: .text) -> mem_sleep_default_setup (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: snd_ac97_mixer+0x29a8 (section: .text) -> mem_sleep_default_setup (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: snd_ac97_mixer+0x29bc (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: snd_ac97_mixer+0x29c4 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: snd_ac97_mixer+0x29d4 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: snd_ac97_mixer+0x2a14 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: snd_ac97_mixer+0x2a60 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: snd_ac97_mixer+0x2a80 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: snd_ac97_mixer+0x2ac0 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: snd_ac97_mixer+0x2af4 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: snd_ac97_mixer+0x2b00 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: snd_ac97_mixer+0x2b54 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: snd_ac97_mixer+0x2b5c (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: snd_ac97_mixer+0x2b8c (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vortex_adbdma_setbuffers+0x6bc (section: .text) -> early_irq_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vortex_adbdma_setbuffers+0x6d4 (section: .text) -> set_handle_irq (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vortex_adbdma_setbuffers+0x704 (section: .text) -> early_irq_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vortex_adbdma_setbuffers+0x734 (section: .text) -> early_irq_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vortex_adbdma_setbuffers+0x764 (section: .text) -> early_irq_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vortex_adbdma_setbuffers+0x77c (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vortex_adbdma_setbuffers+0x79c (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vortex_adb_delroutes+0x1a0 (section: .text) -> irq_sysfs_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vortex_adb_delroutes+0x1d0 (section: .text) -> early_irq_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vortex_adb_delroutes+0x278 (section: .text) -> irq_sysfs_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vortex_adb_delroutes+0x2dc (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vortex_adb_delroutes+0x2ec (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vortex_adb_delroutes+0x2f4 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vortex_adb_delroutes+0x31c (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vortex_adb_delroutes+0x378 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vortex_adb_delroutes+0x3bc (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vortex_adb_delroutes+0x3c4 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vortex_adb_delroutes+0x3f4 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vortex_adb_delroutes+0x40c (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vortex_adb_delroutes+0x41c (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vortex_adb_delroutes+0x428 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vortex_adb_delroutes+0x438 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vortex_adb_delroutes+0x45c (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vortex_route+0x68 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vortex_route+0xa0 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vortex_adb_allocroute+0xa0 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vortex_adb_allocroute+0x1c4 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vortex_adb_allocroute+0x238 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vortex_adb_allocroute+0x320 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vortex_adb_allocroute+0x38c (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vortex_adb_allocroute+0x450 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vortex_adb_allocroute+0x678 (section: .text) -> irq_affinity_setup (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vortex_adb_allocroute+0x6b4 (section: .text) -> irq_sysfs_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vortex_adb_allocroute+0x6c4 (section: .text) -> irq_affinity_setup (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vortex_adb_allocroute+0x704 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vortex_adb_allocroute+0x748 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vortex_adb_allocroute+0x7b8 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vortex_adb_allocroute+0x810 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vortex_adb_allocroute+0x894 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vortex_adb_allocroute+0x8a4 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vortex_adb_allocroute+0x8bc (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vortex_adb_allocroute+0x8dc (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vortex_adb_allocroute+0x8e4 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vortex_adb_allocroute+0x90c (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vortex_adb_allocroute+0x91c (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vortex_adb_allocroute+0x954 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vortex_adb_allocroute+0xcb0 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vortex_adb_allocroute+0x145c (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vortex_connect_default+0x48 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vortex_connect_default+0x64 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vortex_connect_default+0x1d4 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vortex_connect_default+0x1f0 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vortex_connect_default+0x298 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vortex_connect_default+0x2b4 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vortex_connect_default+0x410 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vortex_connect_default+0x42c (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: __snd_vortex_probe.isra.0+0x99c (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: __snd_vortex_probe.isra.0+0x9a8 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: __snd_vortex_probe.isra.0+0x9f4 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: snd_cs46xx_playback_trigger+0xf0 (section: .text) -> irq_pm_init_ops (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: snd_cs46xx_playback_trigger+0x120 (section: .text) -> irq_pm_init_ops (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: snd_cs46xx_mixer+0x140 (section: .text) -> irq_pm_init_ops (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: snd_cs46xx_mixer+0x158 (section: .text) -> irq_debugfs_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: hw_rule_playback_format_by_channels+0xdc (section: .text) -> check_cpu_stall_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: hw_rule_playback_format_by_channels+0x15c (section: .text) -> rcu_sysrq_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: init_engine+0x334 (section: .text) -> rcu_init (section: .init.text)
>> WARNING: modpost: vmlinux: section mismatch in reference: init_engine+0x338 (section: .text) -> rcu_init_nohz (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: init_engine+0x364 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: init_engine+0x3b8 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: init_engine+0x420 (section: .text) -> rcu_init_nohz (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: init_engine+0x444 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: init_engine+0x48c (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: init_engine+0x4b8 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: init_engine+0x508 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: init_engine+0x510 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: init_engine+0x52c (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: init_engine+0x558 (section: .text) -> rcu_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: init_engine+0x588 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: init_engine+0x5d0 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: init_engine+0x68c (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: init_engine+0x698 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: init_engine+0x6a4 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: init_engine+0x6b8 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: init_engine+0x6c0 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: init_engine+0x6d0 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: init_engine+0x6f0 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: init_engine+0x6f4 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: init_engine+0x704 (section: .text) -> rcu_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: init_engine+0x718 (section: .text) -> rcu_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: init_engine+0x724 (section: .text) -> rcu_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: init_engine+0x734 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: init_engine+0x744 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: init_engine+0x754 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: init_engine+0x760 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: init_engine+0x770 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: init_engine+0x794 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: init_engine+0x7a0 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: init_engine+0x7ac (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: init_engine+0x7d8 (section: .text) -> kfree_rcu_batch_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: init_engine+0x7f0 (section: .text) -> rcu_bootup_announce_oddness (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: init_engine+0x8f0 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: snd_echo_mixer_put+0x78 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: snd_echo_mixer_put+0x9c (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: snd_echo_mixer_put+0xc4 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: snd_echo_mixer_put+0x200 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: snd_echo_mixer_put+0x23c (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: snd_echo_mixer_put+0x260 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: snd_echo_mixer_put+0x270 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: snd_echo_mixer_put+0x28c (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: snd_echo_mixer_put+0x298 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: snd_echo_mixer_put+0x2a4 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: snd_echo_mixer_put+0x2bc (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: snd_echo_mixer_put+0x2d4 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: snd_echo_mixer_put+0x2ec (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: snd_echo_mixer_put+0x334 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: stop_transport+0x68 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: stop_transport+0xcc (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: stop_transport+0xf8 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: stop_transport+0x16c (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: stop_transport+0x198 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: stop_transport+0x1bc (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: stop_transport+0x1ec (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: stop_transport+0x1fc (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: stop_transport+0x200 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: stop_transport+0x214 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: stop_transport+0x23c (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: snd_echo_free+0x3c (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: snd_echo_free+0x94 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: snd_echo_free+0x110 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: snd_echo_free+0x1c4 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: snd_echo_output_gain_put+0x13c (section: .text) -> rcu_init_one (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: snd_echo_output_gain_put+0x148 (section: .text) -> rcu_spawn_gp_kthread (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: snd_echo_output_gain_put+0x258 (section: .text) -> rcu_init_one (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: snd_echo_output_gain_put+0x278 (section: .text) -> rcu_init_one (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: snd_echo_output_gain_put+0x2a8 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: snd_echo_output_gain_put+0x2c0 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: snd_echo_output_gain_put+0x2d8 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: snd_echo_output_gain_put+0x324 (section: .text) -> rcu_init_one (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: snd_echo_input_gain_put+0x7c (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: snd_echo_input_gain_put+0x9c (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: snd_echo_input_gain_put+0xa8 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: snd_echo_input_gain_put+0xc0 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: snd_echo_input_gain_put+0xd0 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: snd_echo_input_gain_put+0xfc (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: snd_echo_input_gain_put+0x120 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: snd_echo_input_gain_put+0x16c (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: snd_echo_input_gain_put+0x188 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: snd_echo_input_gain_put+0x1f4 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: snd_echo_input_gain_put+0x220 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: snd_echo_input_gain_put+0x244 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: snd_echo_input_gain_put+0x264 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: snd_echo_input_gain_put+0x27c (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: snd_echo_input_gain_put+0x294 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: snd_echo_input_gain_put+0x2bc (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: snd_echo_input_gain_put+0x2e0 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: restore_dsp_rettings.part.0+0x70 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: restore_dsp_rettings.part.0+0x74 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: restore_dsp_rettings.part.0+0x80 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: restore_dsp_rettings.part.0+0xd0 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: restore_dsp_rettings.part.0+0xe0 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: restore_dsp_rettings.part.0+0xf0 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: restore_dsp_rettings.part.0+0x118 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: restore_dsp_rettings.part.0+0x14c (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: restore_dsp_rettings.part.0+0x170 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: restore_dsp_rettings.part.0+0x17c (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: restore_dsp_rettings.part.0+0x1cc (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: restore_dsp_rettings.part.0+0x1d8 (section: .text) -> (unknown) (section: .init.text)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

