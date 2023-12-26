Return-Path: <linux-kernel+bounces-11327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BCB581E49E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 03:38:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A1B5282B3A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 02:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805015C9C;
	Tue, 26 Dec 2023 02:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ABFXXIsN"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95644139B
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 02:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703558275; x=1735094275;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=mw3eMdd+XKYLUwKGPs69J+sBgC9pAE6Es42XpLwLqVU=;
  b=ABFXXIsNdttoNqWcIY+KhWbNxhpvs9yvl4hfkom/fyiioKbOseMspMh6
   6SG74dvJlv3tPe8U9sn5ukK8u4+LbI9gzdb9Ea+siwjEV0XkMA31M0CzV
   OWqGqiZrbomikZ9Qhhxf3rMXZNRINboF3a1Vm66K56O7O9UwjNDI2Nz/0
   qDEIuwDsWjlBVoADe5KcJxDY8qCTyUW3T3zqwRtbAC5vMyPhgmHm6yk/p
   orwgvb4Bko6yz8FNxSH6jfjoXc0DigYxobihYF0fVerZBo52/UeAEDE/S
   pzjt03DEwoGiJuGXaasIL5LqELfCcRvRd13sGpp/kcpuktQJWpauHnF7E
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="399100739"
X-IronPort-AV: E=Sophos;i="6.04,304,1695711600"; 
   d="scan'208";a="399100739"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2023 18:37:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="727632708"
X-IronPort-AV: E=Sophos;i="6.04,304,1695711600"; 
   d="scan'208";a="727632708"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 25 Dec 2023 18:37:52 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rHxKI-000Dtf-0l;
	Tue, 26 Dec 2023 02:37:50 +0000
Date: Tue, 26 Dec 2023 10:36:51 +0800
From: kernel test robot <lkp@intel.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Chandan Babu R <chandanbabu@kernel.org>,
	Christoph Hellwig <hch@lst.de>
Subject: WARNING: modpost: vmlinux: section mismatch in reference:
 hi6220_mbox_probe+0x142 (section: .text) -> tick_broadcast_init (section:
 .init.text)
Message-ID: <202312261002.BxqFLtTy-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   fbafc3e621c3f4ded43720fdb1d6ce1728ec664e
commit: 9c235dfc3d3f901fe22acb20f2ab37ff39f2ce02 xfs: dquot recovery does not validate the recovered dquot
date:   5 weeks ago
config: riscv-randconfig-r016-20230704 (https://download.01.org/0day-ci/archive/20231226/202312261002.BxqFLtTy-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231226/202312261002.BxqFLtTy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312261002.BxqFLtTy-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: vmlinux: section mismatch in reference: of_dma_configure_id+0x188 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: of_dma_configure_id+0x192 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: of_dma_configure_id+0x19e (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: of_dma_configure_id+0x1aa (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: of_dma_configure_id+0x1b6 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: of_dma_configure_id+0x1be (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: of_dma_configure_id+0x1ca (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: of_dma_configure_id+0x1d4 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: of_dma_configure_id+0x1e2 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: of_dma_configure_id+0x1ee (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: of_dma_configure_id+0x1fa (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: of_dma_configure_id+0x202 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: of_dma_configure_id+0x20c (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: of_dma_configure_id+0x212 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: of_dma_configure_id+0x21c (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: of_dma_configure_id+0x22a (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: of_dma_configure_id+0x236 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: of_dma_configure_id+0x242 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: of_dma_configure_id+0x24a (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: of_dma_configure_id+0x284 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: of_dma_configure_id+0x29a (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: of_dma_configure_id+0x29e (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: of_dma_configure_id+0x2b8 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: of_dma_configure_id+0x2bc (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: of_dma_configure_id+0x2c8 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: of_dma_configure_id+0x2ca (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: of_dma_configure_id+0x2ce (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: of_dma_configure_id+0x2d2 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: of_dma_configure_id+0x2d6 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: of_dma_configure_id+0x2da (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: of_dma_configure_id+0x2de (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: of_dma_configure_id+0x2e2 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: of_dma_configure_id+0x2e8 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: of_dma_configure_id+0x2ec (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: of_dma_configure_id+0x304 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: of_dma_configure_id+0x308 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: of_dma_configure_id+0x314 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: of_dma_configure_id+0x318 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: of_dma_configure_id+0x31c (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: of_dma_configure_id+0x320 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: of_dma_configure_id+0x324 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: of_dma_configure_id+0x32a (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: of_dma_configure_id+0x32e (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: of_dma_configure_id+0x33a (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: of_device_modalias+0x0 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: of_device_modalias+0xa (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: of_device_modalias+0x12 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: of_device_modalias+0x32 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: of_device_modalias+0x36 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: of_device_modalias+0x4e (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: of_device_uevent_modalias+0x0 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: of_device_uevent_modalias+0x1a (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: of_device_uevent_modalias+0x22 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: of_device_uevent_modalias+0x28 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: of_device_uevent_modalias+0x2c (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: of_device_uevent_modalias+0x38 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: of_device_uevent_modalias+0x3c (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: of_device_uevent_modalias+0x62 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: of_device_uevent_modalias+0x6c (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: of_device_uevent_modalias+0x78 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: of_device_uevent+0x0 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: of_device_uevent+0x1e (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: of_device_uevent+0x26 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: of_device_uevent+0x2a (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: of_device_uevent+0x3a (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: of_device_uevent+0x3e (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: of_device_uevent+0x52 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: of_device_uevent+0x56 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: of_device_uevent+0x64 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: of_device_uevent+0x66 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: of_device_uevent+0x6a (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: of_device_uevent+0x7e (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: of_device_uevent+0x82 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: of_device_uevent+0x9e (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: of_device_uevent+0xa2 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: of_device_uevent+0xa6 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: of_device_uevent+0xc8 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: of_device_uevent+0xce (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: of_device_uevent+0xd2 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: of_device_uevent+0xe6 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: of_device_uevent+0xf6 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: of_device_uevent+0x102 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: of_device_uevent+0x106 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: of_device_uevent+0x10a (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: of_device_uevent+0x114 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: of_device_uevent+0x130 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: of_device_uevent+0x138 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: bcma_find_core_unit+0x12 (section: .text) -> __setup_str_dma_debug_cmdline (section: .init.rodata)
WARNING: modpost: vmlinux: section mismatch in reference: bcma_find_core_unit+0x18 (section: .text) -> __setup_dma_debug_driver_setup (section: .init.setup)
WARNING: modpost: vmlinux: section mismatch in reference: bcma_find_core_unit+0x20 (section: .text) -> __setup_dma_debug_entries_cmdline (section: .init.setup)
WARNING: modpost: vmlinux: section mismatch in reference: bcma_find_core_unit+0x30 (section: .text) -> __setup_dma_debug_cmdline (section: .init.setup)
WARNING: modpost: vmlinux: section mismatch in reference: fieldbus_dev_register+0xc8 (section: .text) -> alarmtimer_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: fieldbus_dev_register+0xd4 (section: .text) -> init_posix_timers (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: fieldbus_dev_register+0xfa (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: fieldbus_dev_register+0x148 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: fieldbus_open+0x16 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: fieldbus_open+0x34 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: fieldbus_open+0x40 (section: .text) -> alarmtimer_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: a37xx_mbox_shutdown+0x48 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: hi6220_mbox_probe+0x140 (section: .text) -> tick_init (section: .init.text)
>> WARNING: modpost: vmlinux: section mismatch in reference: hi6220_mbox_probe+0x142 (section: .text) -> tick_broadcast_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: hi6220_mbox_probe+0x146 (section: .text) -> tick_broadcast_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: pdc_tx_list_sg_add+0xe2 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: pdc_tx_list_sg_add+0x13e (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: pdc_send_data+0x12a (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: pdc_send_data+0x13a (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: pdc_send_data+0x284 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: pdc_send_data+0x32e (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: pdc_send_data+0x36c (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: pdc_startup+0xc (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: pdc_probe+0x4e (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: pdc_probe+0x200 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: pdc_probe+0x20c (section: .text) -> sched_clock_syscore_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: pdc_probe+0x2e0 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: mpfs_mbox_shutdown+0x16 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: fsa9480_probe+0xa6 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: gpio_extcon_probe+0xf6 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: max3355_probe+0xd4 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: max77693_muic_probe+0x33c (section: .text) -> (unknown) (section: .init.text)
>> WARNING: modpost: vmlinux: section mismatch in reference: palmas_usb_probe+0x292 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: rt8973a_muic_i2c_probe+0x218 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: sm5022_muic_i2c_probe+0x220 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: usb_extcon_probe+0xe0 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: mcb_bus_add_devices+0xa (section: .text) -> cgroup_init_subsys (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: mcb_release_bus+0xa (section: .text) -> cgroup_init_subsys (section: .init.text)
>> WARNING: modpost: vmlinux: section mismatch in reference: intel_th_free+0x54 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: gth_output_parm_get+0x10 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: gth_output_parm_get+0x14 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: gth_output_parm_get+0x26 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: gth_output_parm_get+0x2e (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: gth_output_parm_get+0x38 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: gth_output_parm_get+0x42 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: gth_output_parm_get+0x4c (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: gth_output_parm_get+0x54 (section: .text) -> cgroup_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: intel_th_gth_prepare+0x1a (section: .text) -> cgroup_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: intel_th_gth_prepare+0x1e (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: intel_th_gth_prepare+0x26 (section: .text) -> cgroup_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: intel_th_gth_prepare+0x2e (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: intel_th_gth_prepare+0x3a (section: .text) -> cgroup_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: intel_th_gth_assign+0x18 (section: .text) -> cgroup_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: intel_th_gth_assign+0x24 (section: .text) -> cgroup_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: intel_th_gth_assign+0x3a (section: .text) -> cgroup_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: intel_th_gth_assign+0x42 (section: .text) -> cgroup_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: intel_th_gth_assign+0x7e (section: .text) -> cgroup_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: intel_th_gth_assign+0x80 (section: .text) -> cgroup_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: intel_th_gth_assign+0x8c (section: .text) -> cgroup_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: intel_th_gth_assign+0x92 (section: .text) -> cgroup_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: intel_th_gth_unassign+0x4 (section: .text) -> cgroup_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: intel_th_gth_unassign+0x56 (section: .text) -> cgroup_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: intel_th_gth_unassign+0x60 (section: .text) -> cgroup_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: mmiowb_set_pending+0x14 (section: .text) -> cgroup_init (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: mmiowb_set_pending+0x1c (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: mmiowb_set_pending+0x30 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: mmiowb_set_pending+0x34 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: mmiowb_set_pending+0x44 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: gth_master_set+0xc (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: gth_master_set+0x1c (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: gth_master_set+0x3a (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: gth_master_set+0x52 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: gth_output_set+0x38 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: gth_smcfreq_set+0x40 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: intel_th_gth_stop+0x2a (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: intel_th_gth_stop+0x46 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: intel_th_gth_stop+0x62 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: intel_th_gth_stop+0x6a (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: intel_th_gth_stop+0x78 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: intel_th_gth_stop+0x7a (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: intel_th_gth_stop+0x7c (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: intel_th_gth_stop+0x80 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: intel_th_gth_stop+0x90 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: intel_th_gth_stop+0x94 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: intel_th_gth_stop+0xa0 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: intel_th_gth_stop+0xaa (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: intel_th_gth_stop+0xae (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: intel_th_gth_stop+0xc0 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: intel_th_gth_stop+0xda (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: intel_th_gth_disable+0x36 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: intel_th_gth_disable+0x3e (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: intel_th_gth_disable+0x66 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: intel_th_gth_disable+0x7a (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: intel_th_gth_disable+0xa8 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: master_attr_show+0x44 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: master_attr_show+0x48 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: master_attr_show+0x4c (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: master_attr_show+0x5c (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: master_attr_show+0x5e (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: master_attr_show+0x62 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: master_attr_store+0x34 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: master_attr_store+0x40 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: master_attr_store+0x5c (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: master_attr_store+0x9a (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: master_attr_store+0xa4 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: master_attr_store+0xb0 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: master_attr_store+0xc2 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: master_attr_store+0xf4 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: master_attr_store+0xfc (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: master_attr_store+0x112 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: intel_th_gth_probe+0x36 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: intel_th_gth_probe+0x46 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: intel_th_gth_probe+0x4c (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: intel_th_gth_probe+0x52 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: intel_th_gth_probe+0x56 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: intel_th_gth_probe+0x6e (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: intel_th_gth_probe+0x72 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: intel_th_gth_probe+0x8a (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: intel_th_gth_probe+0x96 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: intel_th_gth_probe+0x9a (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: intel_th_gth_probe+0x9e (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: intel_th_gth_probe+0xa2 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: intel_th_gth_probe+0xba (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: intel_th_gth_probe+0xcc (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: intel_th_gth_probe+0xd8 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: intel_th_gth_probe+0xec (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: intel_th_gth_probe+0xfc (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: intel_th_gth_probe+0x104 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: intel_th_gth_probe+0x10c (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: intel_th_gth_probe+0x11a (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: intel_th_gth_probe+0x124 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: intel_th_gth_probe+0x138 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: intel_th_gth_probe+0x154 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: intel_th_gth_probe+0x15c (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: intel_th_gth_probe+0x16e (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: intel_th_gth_probe+0x186 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: intel_th_gth_probe+0x1a2 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: intel_th_gth_probe+0x1c0 (section: .text) -> (unknown) (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: intel_th_gth_probe+0x1f2 (section: .text) -> (unknown) (section: .init.text)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

