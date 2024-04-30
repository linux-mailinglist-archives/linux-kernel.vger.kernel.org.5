Return-Path: <linux-kernel+bounces-163354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D05368B69C1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 07:14:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEEFAB20DBA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 05:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6B417584;
	Tue, 30 Apr 2024 05:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WEUCOj2K"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F692F43
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 05:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714454057; cv=none; b=XVh56abhxdDrUOveUtHkuatsKOePCevKib91DCzdhEVz1Qt/ZMK6NfT4O4TdkUQCsKoXyazSUmwMm5JuokEjVhY2Yddeae6D9KYEfiSAWgqIATv1+K9h8Gp0Q3mpdVvBBesfyYUZqyvy2x1+ym70SKqaqBOTpYrypOmBTOj3ikY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714454057; c=relaxed/simple;
	bh=YgtIxmrnhUDebM6aeMA9/KykmonzDPSJ6lP25rDmwpc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=OSlCd0CLWB5X+fcpsfHJrLmJzT8lie/TM/7TzaOI1ZwKk88leZcZJi/Sd9dQv9YHtEAsr2ta78V1vgZgicryIw8TbFKUFXeU67aMVbOryHya3Yvd8Doc9/kvEduqEVV8uF9ZMqZJ8YPPJKyyBh+Yl/KUTt4DgUpP5oiMS+4bd+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WEUCOj2K; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714454053; x=1745990053;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=YgtIxmrnhUDebM6aeMA9/KykmonzDPSJ6lP25rDmwpc=;
  b=WEUCOj2KsDruwMDujon16zFZnwZEk8sIVYjSyajQAn1DtPQJQWeIfsAH
   JZCCtrVI6G5WCx7pMJlsBBRrljLOlcYtDeFkFjRcy7mBuQbQJD81D10sp
   R5mpflSTB2+7i5HcE4PrZyk3DsKI4QdD0CQJMLitaVGVmqrg9UQCt6Yaa
   73wSl5cOqXKcmZ78u0OcriOpKnEOjhPTSU0KnmHHcjTlkF39XodvLnO+5
   fX9V0rqS+izoNXVHgLABsGAKHWVSDl3i8MYMBTapiRaIXw77Eedj8QbHQ
   ZD3JQPuQRbb3jv8DR1OAe7Lg6lwJYMsdeH5x10n9IrW083S3sh8s5ji1y
   g==;
X-CSE-ConnectionGUID: IBbV931nQ2+JdBgE0SdeiQ==
X-CSE-MsgGUID: j5tehuDjTw2QNOcB3ndnEw==
X-IronPort-AV: E=McAfee;i="6600,9927,11059"; a="13968239"
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; 
   d="scan'208";a="13968239"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 22:14:12 -0700
X-CSE-ConnectionGUID: KzNmFBgLTwm6MEhlmPkuIA==
X-CSE-MsgGUID: jyOkjnzyQf+o7ID7EpKCPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; 
   d="scan'208";a="26424754"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 29 Apr 2024 22:14:10 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s1foe-0007l6-0d;
	Tue, 30 Apr 2024 05:14:08 +0000
Date: Tue, 30 Apr 2024 13:13:30 +0800
From: kernel test robot <lkp@intel.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: WARNING: modpost: vmlinux: section mismatch in reference:
 ipc_imem_handle_irq+0x292 (section: .text) -> .L0  (section: .init.text)
Message-ID: <202404301338.VtPxCQfW-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git =
master
head:   98369dccd2f8e16bf4c6621053af7aa4821dcf8e
commit: 561e4f9451d65fc2f7eef564e0064373e3019793 io_uring/kbuf: hold io_buf=
fer_list reference over mmap
date:   4 weeks ago
config: riscv-randconfig-r021-20230409 (https://download.01.org/0day-ci/arc=
hive/20240430/202404301338.VtPxCQfW-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 13.2.0
reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archive=
/20240430/202404301338.VtPxCQfW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new versio=
n of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404301338.VtPxCQfW-lkp@i=
ntel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: vmlinux: section mismatch in reference: mv88e6393x_xg_pcs=
_get_state+0xc0 (section: .text) -> .L165 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: alx_mdio_write+0x=
6a (section: .text) -> .L200 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: bnad_pci_remove+0=
x1ae (section: .text) -> .LBE89 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: bnad_pci_probe+0x=
8d0 (section: .text) -> .LBE89 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: t1_interrupt_thre=
ad+0x56 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: init_one+0x724 (s=
ection: .text) -> .L191 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: t3_l2t_get+0xca (=
section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: t3_l2t_send_slow+=
0x1e8 (section: .text) -> .L190 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: t3_l2t_update+0x8=
c (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: cxgb_redirect+0x1=
f6 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: cxgb_redirect+0x2=
e8 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: cxgb3_offload_dea=
ctivate+0xfc (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: link_start+0x9c (=
section: .text) -> .L0  (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: remove_one+0x78 (=
section: .text) -> .LBE89 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: init_one+0x1454 (=
section: .text) -> .LBE89 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: t4_handle_get_por=
t_info+0x45a (section: .text) -> .L0  (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: cxgb4_update_dev_=
clip+0x42 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: set_fecparam+0xb4=
 (section: .text) -> .L0  (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: set_link_ksetting=
s+0x1c0 (section: .text) -> .L0  (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: set_pauseparam+0x=
b0 (section: .text) -> .L0  (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: mk_act_open_req6.=
isra.0+0x238 (section: .text) -> .L61 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: mk_act_open_req.i=
sra.0+0x236 (section: .text) -> .L61 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: __rhashtable_look=
up.isra.0+0x68 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: __rhashtable_look=
up.isra.0+0x136 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: __rhashtable_look=
up.isra.0+0x28c (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: cxgb4_tc_flower_d=
estroy+0xcc (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: cxgb4_tc_flower_d=
estroy+0x180 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: cxgb4_cudbg_colle=
ct+0xda (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: cxgb4_dcb_cleanup=
_apps+0x12a (section: .text) -> .L0  (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: cxgb4_setapp+0x74=
 (section: .text) -> .L0  (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: cxgb4_dcb_handle_=
fw_update+0x4de (section: .text) -> .L0  (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: tsnep_netdev_bpf+=
0x5e (section: .text) -> .L456 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: tsnep_probe+0x4ea=
 (section: .text) -> .L58 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: e1000_setup_tx_re=
sources+0x28 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: e1000_setup_rx_re=
sources+0x22 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: e1000_watchdog+0x=
22a (section: .text) -> .L64 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: e1000_get_ethtool=
_stats+0x30 (section: .text) -> .L64 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: mlx4_catas_end+0x=
2a (section: .text) -> .LBE89 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: mlx4_multi_func_i=
nit+0x6de (section: .text) -> .LBE89 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: mlx4_multi_func_c=
leanup+0x2a (section: .text) -> .LBE89 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: mlx4_unload_one+0=
x2c2 (section: .text) -> .LBE100 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: mlx4_unload_one+0=
x2ec (section: .text) -> .LBE100 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: mlx4_load_one+0x1=
0e2 (section: .text) -> .LBE100 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: mlx4_load_one+0x1=
174 (section: .text) -> .LBE100 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: mlx4_en_remove+0x=
10c (section: .text) -> .LBE89 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: mlx4_en_get_stats=
64+0x3e (section: .text) -> .L1=025 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: mlx4_en_dcbnl_set=
app+0x58 (section: .text) -> .L0  (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: __mlxsw_core_bus_=
device_register+0x378 (section: .text) -> .LBE89 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: __mlxsw_core_bus_=
device_register+0x6a0 (section: .text) -> .LBE89 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: mlxsw_core_bus_de=
vice_unregister+0x28c (section: .text) -> .LBE89 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: mlxsw_core_bus_de=
vice_unregister+0x2de (section: .text) -> .LBE89 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: __rhashtable_look=
up.isra.0+0x60 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: __rhashtable_look=
up.isra.0+0x12a (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: __rhashtable_look=
up.isra.0+0x280 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: mlxsw_afa_block_a=
ppend_drop+0xea (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: mlxsw_afa_block_a=
ppend_drop+0x332 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: mlxsw_afa_block_a=
ppend_drop+0x426 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: mlxsw_linecard_fi=
ni.isra.0+0x9a (section: .text) -> repair_env_string (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: mlxsw_linecards_i=
nit+0xba (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: mlxsw_m_get_modul=
e_info+0x2a (section: .text) -> __setup_set_debug_rodata (section: .init.se=
tup)
WARNING: modpost: vmlinux: section mismatch in reference: mlxfw_mfa2_file_c=
omponent_get+0x32c (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: lan966x_remove+0x=
56 (section: .text) -> .LBE89 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: lan966x_probe+0x8=
b6 (section: .text) -> .LBE89 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: lan966x_fdb_deini=
t+0x20 (section: .text) -> .LBE89 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: lan966x_tc_flower=
_add+0x35e (section: .text) -> .L74 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: lan966x_tc_flower=
+0x3c (section: .text) -> .L74 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vcap_tc_flower_ha=
ndler_ethaddr_usage+0xaa (section: .text) -> obsolete_checksetup (section: =
=2Einit.text)
WARNING: modpost: vmlinux: section mismatch in reference: vcap_tc_flower_ha=
ndler_ethaddr_usage+0x12c (section: .text) -> obsolete_checksetup (section:=
 .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: ocelot_deinit+0x2=
2 (section: .text) -> .LBE89 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: ocelot_init+0x99c=
 (section: .text) -> .LBE89 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: ocelot_stats_init=
+0x134 (section: .text) -> .LBE89 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: ocelot_stats_dein=
it+0x24 (section: .text) -> .LBE89 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: ocelot_probe_port=
+0x250 (section: .text) -> .L151 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: ocelot_release_po=
rt+0x3a (section: .text) -> .L151 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: txgbe_open+0x34 (=
section: .text) -> .L108 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: txgbe_up+0x16 (se=
ction: .text) -> .L108 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: w5100_probe+0x506=
 (section: .text) -> .LBE89 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: w5100_remove+0x7a=
 (section: .text) -> .LBE89 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: plip_rewrite_addr=
ess+0x6e (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: plip_rewrite_addr=
ess+0xfc (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: ppp_channel_bridg=
e_input+0x6c (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: net_generic+0x70 =
(section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: ppp_dev_uninit+0x=
84 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: ppp_register_net_=
channel+0xa6 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: ppp_unit_register=
+0x84 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: ppp_unregister_ch=
annel+0xd0 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: ppp_connect_chann=
el+0x80 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: ppp_ioctl+0x260 (=
section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: net_generic+0x70 =
(section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: pppoe_seq_stop+0x=
78 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: pppoe_seq_start+0=
x7e (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: pppoe_seq_next+0x=
80 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: pppoe_flush_dev+0=
x8a (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: pppoe_flush_dev+0=
x320 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: pppoe_release+0x1=
26 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: pppoe_rcv+0x1c2 (=
section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: pppoe_connect+0x1=
38 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: pppoe_connect+0x3=
5c (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: pppoe_disc_rcv+0x=
162 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: slip_write_wakeup=
+0x68 (section: .text) -> early_hostname (section: .init.text)
>> WARNING: modpost: vmlinux: section mismatch in reference: ipc_imem_handl=
e_irq+0x292 (section: .text) -> .L0  (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: ipc_wwan_receive+=
0xf2 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: ipc_wwan_tx_flowc=
trl+0x8c (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: ipc_protocol_pm_d=
ev_sleep_handle+0x66 (section: .text) -> __setup_set_reset_devices (section=
: .init.setup)
WARNING: modpost: vmlinux: section mismatch in reference: vmxnet3_suspend+0=
x24e (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vmxnet3_suspend+0=
x316 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vmxnet3_xdp_set.i=
sra.0+0x11a (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vmxnet3_process_x=
dp_small+0x120 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vmxnet3_process_x=
dp+0x10a (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: do_neigh_solicit+=
0x21a (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: net_failover_hand=
le_frame+0x38 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: net_failover_hand=
le_frame+0xb2 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: net_failover_hand=
le_frame+0x12c (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: net_failover_comp=
ute_features+0x38 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: net_failover_comp=
ute_features+0x148 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: net_failover_vlan=
_rx_kill_vid+0x34 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: net_failover_vlan=
_rx_kill_vid+0xd8 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: net_failover_vlan=
_rx_add_vid+0x36 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: net_failover_vlan=
_rx_add_vid+0xda (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: net_failover_sele=
ct_queue+0x36 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: net_failover_dest=
roy+0x3a (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: net_failover_get_=
stats+0xbe (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: net_failover_get_=
stats+0x18a (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: net_failover_set_=
rx_mode+0x6a (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: net_failover_set_=
rx_mode+0x118 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: mpt_detach+0x7e (=
section: .text) -> .LBE89 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: mpt_detach+0xaa (=
section: .text) -> .LBE89 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: mpt_attach+0x912 =
(section: .text) -> .LBE89 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: mpt_attach+0x9ae =
(section: .text) -> .LBE89 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: mpt_attach+0xb20 =
(section: .text) -> .LBE89 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: mptscsih_remove+0=
xd0 (section: .text) -> .L0  (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: sbp2_remove+0x1c4=
 (section: .text) -> .L0  (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: sbp2_probe+0x3a4 =
(section: .text) -> .L0  (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vfio_combine_iova=
_ranges+0x4e (section: .text) -> .LBB106 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vfio_combine_iova=
_ranges+0xd6 (section: .text) -> .LBB106 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vfio_ioctl_device=
_feature_logging_start+0x1ec (section: .text) -> .LBB106 (section: .init.te=
xt)
WARNING: modpost: vmlinux: section mismatch in reference: vfio_virqfd_exit+=
0x18 (section: .text) -> .LBE89 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vfio_pci_rw+0xf4 =
(section: .text) -> .L436 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vfio_pci_core_dis=
able+0x3d6 (section: .text) -> .L443 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vfio_user_config_=
read+0x86 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vfio_basic_config=
_write+0x60 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vfio_basic_config=
_write+0x274 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vfio_raw_config_r=
ead+0x8a (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: pcmcia_bus_add_so=
cket+0x1a (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: pcmcia_device_add=
=2Eisra.0+0x1a (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: aoechr_write+0x2a=
e (section: .text) -> .L119 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: usb_hub_cleanup+0=
x18 (section: .text) -> .LBE89 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: usb_uevent+0x1e (=
section: .text) -> .L460 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: usb_uevent+0x22 (=
section: .text) -> .L460 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: usb_device_match+=
0x1e (section: .text) -> .L460 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: usb_device_match+=
0x22 (section: .text) -> .L460 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: usb_remove_sysfs_=
dev_files+0x28 (section: .text) -> .L460 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: usb_remove_sysfs_=
dev_files+0x2c (section: .text) -> .L460 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: usb_create_sysfs_=
dev_files+0x1c (section: .text) -> .L460 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: usb_create_sysfs_=
dev_files+0x20 (section: .text) -> .L460 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: dwc2_resume+0x20c=
 (section: .text) -> .L0  (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: ohci_hcd_sm501_dr=
v_probe+0x22a (section: .text) -> setup_boot_config (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: xhci_init_driver+=
0x15c (section: .text) -> .L338 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: xhci_init_driver+=
0x17c (section: .text) -> .L338 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: uas_disconnect+0x=
ac (section: .text) -> .L0  (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: uas_probe+0x3d4 (=
section: .text) -> .L0  (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: release_everythin=
g+0xaa (section: .text) -> .L0  (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: mts_usb_disconnec=
t+0x34 (section: .text) -> .L0  (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: mts_usb_probe+0x2=
dc (section: .text) -> .L0  (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: ci_hdrc_otg_destr=
oy+0x28 (section: .text) -> .LBE89 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: tcpm_set_vconn+0x=
4e (section: .text) -> .L0  (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: tcpm_src_attach+0=
x178 (section: .text) -> .L0  (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: run_state_machine=
+0x2a56 (section: .text) -> .L0  (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: fusb302_remove+0x=
62 (section: .text) -> .LBE89 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: fusb302_probe+0x4=
a2 (section: .text) -> .LBE89 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: _max_tcpci_irq+0x=
1c8 (section: .text) -> .L0  (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: anx7411_data_role=
_detect+0x5a (section: .text) -> .L0  (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: anx7411_i2c_remov=
e+0xa8 (section: .text) -> .LBE89 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: anx7411_i2c_probe=
+0x626 (section: .text) -> .LBE89 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: stusb160x_detach+=
0x4a (section: .text) -> .L0  (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: stusb160x_attach+=
0x19a (section: .text) -> .L0  (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: input_pass_values=
+0xb2 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: input_inject_even=
t+0xb4 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: psmouse_resync+0x=
a4 (section: .text) -> set_debug_rodata (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: cypress_ps2_read_=
cmd_status+0xae (section: .text) -> set_debug_rodata (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: psmouse_smbus_cre=
ate_companion+0x6c (section: .text) -> .L329 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: psmouse_smbus_mod=
ule_exit+0x30 (section: .text) -> .LBE89 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: rtc_ktime_to_tm+0=
x68 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: rtc_add_offset+0x=
92 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: rtc_subtract_offs=
et+0x74 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: __rtc_read_alarm+=
0x462 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: wakealarm_store+0=
x1e2 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: ds1374_read_time+=
0xbc (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: ds1374_set_alarm+=
0xfa (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: ds1374_read_alarm=
+0x194 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: ds2404_read_time+=
0x92 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: ftrtc010_rtc_read=
_time+0x74 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: test_rtc_read_ala=
rm+0x5c (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: test_rtc_read_tim=
e+0x3a (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: i2c_register_adap=
ter+0x31e (section: .text) -> __setup_str_quiet_kernel (section: .init.roda=
ta)
WARNING: modpost: vmlinux: section mismatch in reference: i2c_register_adap=
ter+0x322 (section: .text) -> __setup_str_quiet_kernel (section: .init.roda=
ta)
WARNING: modpost: vmlinux: section mismatch in reference: i2c_register_adap=
ter+0x3a4 (section: .text) -> __setup_str_quiet_kernel (section: .init.roda=
ta)
WARNING: modpost: vmlinux: section mismatch in reference: of_i2c_get_board_=
info+0x4a (section: .text) -> .L220 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: i3c_masterdev_rel=
ease+0x5c (section: .text) -> .LBE89 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: i3c_dev_free_ibi_=
locked+0x7a (section: .text) -> .LBE89 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: adv7180_subscribe=
_event+0x56 (section: .text) -> .L0  (section: .init.text)
--
WARNING: modpost: vmlinux: section mismatch in reference: esp_output_done+0=
x112 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: tunnel4_err+0x34 =
(section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: tunnel4_err+0xd0 =
(section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: tunnel64_err+0x34=
 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: tunnel64_err+0xd0=
 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: tunnelmpls4_err+0=
x34 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: tunnelmpls4_err+0=
xd0 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: tunnel4_rcv_cb+0x=
66 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: tunnel4_rcv_cb+0x=
11a (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: tunnel64_rcv+0x7c=
 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: tunnel64_rcv+0x10=
e (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: tunnelmpls4_rcv+0=
x78 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: tunnelmpls4_rcv+0=
x10a (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: tunnel4_rcv+0x78 =
(section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: tunnel4_rcv+0x10a=
 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: ip_route_me_harde=
r+0x8a (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: ip_route_me_harde=
r+0x2aa (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: ip_route_me_harde=
r+0x2fe (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: ip_route_me_harde=
r+0x39e (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: ip_route_me_harde=
r+0x44c (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: nf_tproxy_laddr4+=
0x42 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: nf_tproxy_laddr4+=
0xba (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: nf_tproxy_laddr4+=
0x162 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: nf_send_reset+0xb=
0 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: nf_send_reset+0x1=
48 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: nf_send_reset+0x1=
8e (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: nf_send_reset+0x2=
1c (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: nf_send_reset+0x2=
ca (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: inet_diag_lock_ha=
ndler+0xae (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: inet_diag_dump_on=
e_icsk+0xca (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: tcp_diag_get_aux+=
0x8a (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: tcp_diag_get_aux_=
size+0xd2 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: sk_psock_get+0x68=
 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: sk_psock_get+0x68=
 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: xfrm4_rcv_encap_f=
inish+0x28 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: xfrm4_rcv_encap_f=
inish2+0x28 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: xfrm4_gro_udp_enc=
ap_rcv+0xec (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: xfrm4_transport_f=
inish+0x1c6 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: xfrm4_transport_f=
inish+0x2d2 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: __xfrm4_output+0x=
32 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: __xfrm4_output+0x=
92 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: xfrm4_output+0x40=
 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: xfrm4_output+0x10=
e (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: xfrm4_ipcomp_err+=
0x34 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: xfrm4_ipcomp_err+=
0xd0 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: xfrm4_ah_err+0x34=
 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: xfrm4_ah_err+0xd0=
 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: xfrm4_esp_err+0x3=
4 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: xfrm4_esp_err+0xd=
0 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: xfrm4_rcv_cb+0x6c=
 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: xfrm4_rcv_cb+0x10=
e (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: xfrm4_rcv_encap+0=
xa4 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: xfrm4_rcv_encap+0=
x13c (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: xfrm4_rcv_encap+0=
x1de (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: xfrm4_ipcomp_rcv+=
0x34 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: xfrm4_ipcomp_rcv+=
0xd4 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: xfrm4_ah_rcv+0x34=
 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: xfrm4_ah_rcv+0xd4=
 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: xfrm4_esp_rcv+0x3=
4 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: xfrm4_esp_rcv+0xd=
4 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: sk_psock_get+0x68=
 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: tls_get_info+0xb2=
 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: sk_psock_get+0x68=
 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: tls_sw_sock_is_re=
adable+0x72 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: tls_strp_dev_exit=
+0x18 (section: .text) -> .LBE89 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: policy_hash_bysel=
+0x212 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: policy_hash_direc=
t+0x1c6 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: xfrm_policy_get_a=
finfo+0x9c (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: xfrm_bundle_creat=
e+0x5aa (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: xfrm_bundle_creat=
e+0x630 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: __xfrm_policy_ine=
xact_prune_bin+0x154 (section: .text) -> early_hostname (section: .init.tex=
t)
WARNING: modpost: vmlinux: section mismatch in reference: __xfrm_policy_ine=
xact_prune_bin+0x23a (section: .text) -> early_hostname (section: .init.tex=
t)
WARNING: modpost: vmlinux: section mismatch in reference: xdst_queue_output=
+0x2e (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: xdst_queue_output=
+0x106 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: xdst_queue_output=
+0x154 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: xdst_queue_output=
+0x19a (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: xfrm_create_dummy=
_bundle+0x1b2 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: xfrm_create_dummy=
_bundle+0x244 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: __xfrm_decode_ses=
sion+0x284 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: __xfrm_decode_ses=
sion+0x2e2 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: __xfrm_decode_ses=
sion+0x338 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: xfrm_icmp_flow_de=
code+0x164 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: xfrm_sk_policy_lo=
okup+0xac (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: xfrm_policy_queue=
_process+0xee (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: xfrm_policy_queue=
_process+0x3c6 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: xfrm_policy_queue=
_process+0x43e (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: xfrm_policy_queue=
_process+0x4f6 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: xfrm_policy_queue=
_process+0x676 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: __xfrm_route_forw=
ard+0x9c (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: __xfrm_route_forw=
ard+0xec (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: __xfrm_route_forw=
ard+0x132 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: __xfrm_route_forw=
ard+0x208 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: __xfrm_route_forw=
ard+0x27e (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: __xfrm_policy_che=
ck+0x9e (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: __xfrm_policy_che=
ck+0x236 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: __xfrm_sk_clone_p=
olicy+0xa4 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: xfrm_state_afinfo=
_get_rcu+0x5e (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: xfrm_replay_timer=
_handler+0x96 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: xfrm_state_get_af=
info+0xa0 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: xfrm_rcv_cb+0xea =
(section: .text) -> early_hostname (section: .init.text)
>> WARNING: modpost: vmlinux: section mismatch in reference: xfrm_input+0x5=
84 (section: .text) -> .L0  (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: xfrm_input+0x5f4 =
(section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: xfrm_input+0x644 =
(section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: xfrm_input+0x68a =
(section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: xfrm_input+0x720 =
(section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: xfrm_input+0xd48 =
(section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: xfrm_input+0xf6c =
(section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: ip_skb_dst_mtu+0x=
9c (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: ip_skb_dst_mtu+0x=
1f6 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: ip_skb_dst_mtu+0x=
248 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: xfrm4_extract_out=
put+0xc4 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: xfrm6_tunnel_chec=
k_size+0x28 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: xfrm6_tunnel_chec=
k_size+0x1d4 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: xfrm6_tunnel_chec=
k_size+0x370 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: xfrm_output_one+0=
x2e (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: xfrm_output_one+0=
xa6 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: xfrm_output_one+0=
x30e (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: xfrm_output_one+0=
x35e (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: xfrm_output_one+0=
x3a4 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: xfrm_output_one+0=
x438 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: xfrm_output_one+0=
x588 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: xfrm_output_resum=
e+0x38 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: xfrm_output_resum=
e+0xe4 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: xfrm_output_resum=
e+0x16e (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: xfrm_output_resum=
e+0x1d2 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: xfrm_output_resum=
e+0x23a (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: xfrm_output_resum=
e+0x282 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: xfrm_output+0x30 =
(section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: xfrm_output+0x74 =
(section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: xfrm_output+0xee =
(section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: xfrm_replay_advan=
ce_bmp+0x1c4 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: xfrm_replay_advan=
ce_esn+0x20e (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: xfrm_replay_advan=
ce+0x1b0 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: xfrm_replay_overf=
low+0xfe (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: xfrm_replay_overf=
low+0x294 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: xfrm_replay_overf=
low+0x40c (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: attach_aead+0x34 =
(section: .text) -> .L86 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: xfrm_is_alive+0x7=
0 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: xfrm_notify_polic=
y+0x256 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: xfrm_send_report+=
0x98 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: xfrm_send_mapping=
+0xc0 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: xfrm_send_acquire=
+0xd2 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: xfrm_send_migrate=
+0xea (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: xfrm_set_default+=
0x1cc (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: xfrm_exp_policy_n=
otify+0x24a (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: xfrm_send_policy_=
notify+0x11a (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: xfrm_notify_sa+0x=
18a (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: xfrm_send_state_n=
otify+0x1b8 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: xfrm_send_state_n=
otify+0x2e4 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: xfrm_send_state_n=
otify+0x474 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: xfrmi_dev_uninit+=
0x7c (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: xfrmi_locate+0x7a=
 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: xfrmi_changelink+=
0x178 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: xfrmi_newlink+0xc=
0 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: xfrmi_newlink+0x3=
1c (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: xfrmi_input+0x170=
 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: xfrmi_input+0x1ce=
 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: xfrmi_xmit2+0x3c =
(section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: xfrmi_xmit2+0x96 =
(section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: xfrmi_xmit2+0x124=
 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: xfrmi_xmit2+0x33e=
 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: xfrmi_xmit2+0x4c4=
 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: xfrmi_xmit2+0x5b0=
 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: xfrmi_xmit+0x36 (=
section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: espintcp_close+0x=
28 (section: .text) -> __setup_quiet_kernel (section: .init.setup)
WARNING: modpost: vmlinux: section mismatch in reference: espintcp_close+0x=
2c (section: .text) -> __setup_quiet_kernel (section: .init.setup)
WARNING: modpost: vmlinux: section mismatch in reference: unix_write_space+=
0x92 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: unix_write_space+=
0x196 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: unix_release_sock=
+0x32c (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: unix_shutdown+0x1=
de (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: unix_shutdown+0x2=
ee (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: sk_psock_get+0x68=
 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: ipv6_route_input+=
0x32 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: inet6_sk_rebuild_=
header+0x188 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: inet6_sk_rebuild_=
header+0x340 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: inet6_sk_rebuild_=
header+0x3d2 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: ac6_get_next+0x36=
 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: ac6_get_next+0xbe=
 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: ac6_get_next+0x18=
2 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: ac6_get_next+0x21=
8 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: ac6_seq_start+0xb=
8 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: ac6_seq_start+0x1=
62 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: ipv6_sock_ac_join=
+0x240 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: ipv6_sock_ac_drop=
+0x1ca (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: __ipv6_sock_ac_cl=
ose+0x150 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: ipv6_chk_acast_ad=
dr+0x8e (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: ipv6_chk_acast_ad=
dr+0x11a (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: ipv6_chk_acast_ad=
dr+0x1e0 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: ipv6_chk_acast_ad=
dr+0x2e6 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: ipv6_chk_acast_ad=
dr+0x394 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: __ip6_flush_pendi=
ng_frames.isra.0+0x5c (section: .text) -> early_hostname (section: .init.te=
xt)
WARNING: modpost: vmlinux: section mismatch in reference: __ip6_flush_pendi=
ng_frames.isra.0+0xa8 (section: .text) -> early_hostname (section: .init.te=
xt)
WARNING: modpost: vmlinux: section mismatch in reference: dst_output+0x30 (=
section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: ip6_forward_finis=
h+0x7c (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: ip6_copy_metadata=
+0x8e (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: ip6_finish_output=
2+0x48 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: ip6_finish_output=
2+0x2b6 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: ip6_xmit+0xbe (se=
ction: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: ip6_xmit+0x6ee (s=
ection: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: ip6_xmit+0x7ec (s=
ection: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: ip6_xmit+0x8ee (s=
ection: .text) -> early_hostname (section: .init.text)

--=20
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

