Return-Path: <linux-kernel+bounces-163182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB928B66DA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 02:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD0111C217E0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 00:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC7464D;
	Tue, 30 Apr 2024 00:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VAWrDpfv"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC62161
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 00:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714436746; cv=none; b=T1ZH6Zrzv0rQEplS7GKAy4Ioqr4E9sWqhDOkP73vwaPVcKDY7VsURodOEnfv9NroXfGCX9WHbI3Rx5rLRNC92V2VaGALIpatRqlsLYmLGzKPcb7bk7Xw99i+2rN3Rn4CKdM/YvElkNH6fBW1hQ0WVPOjskORMW3sMTKB4x7dFIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714436746; c=relaxed/simple;
	bh=zwPt2lvgjEi+qEoGvCrFr8fXb9eObsoy+u8I7jCZVxg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HfPzUSszsYYpYqg8fM+UDBft3HXizd0scOF+iC41rqcKs4CoTbycmUb6h7D5Qj4H5rWnVpQiJkEMc3pVKpT1jYuBB9mz3OjrtGMEDPYMUqNN3z1ogxN3BWdhdHXBmlePOVlVOx3eBrGIulbGFyIQwhph9kM2dUuH0aAjAi1ZIds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VAWrDpfv; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714436744; x=1745972744;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=zwPt2lvgjEi+qEoGvCrFr8fXb9eObsoy+u8I7jCZVxg=;
  b=VAWrDpfvJ8Yb+PY5GNCgj0oqSqbmwTyT+keuhg8g4LneJwXKEjrd0xL9
   gkuG1iJjogr0zNTrmSeF8/XfB7Jx1NLqfLA6HDYDcliqZmHGRzhIka1TK
   vH5pZzwm+OvWcVflXIgwNPiOAnKMLu+52SSFeG4Z1D57mThSEa0/mPHUU
   NjJLZ2uSYIfiuk2/r/PD90bpsF6zOynGDdFlfNkA1JvCrhChcP3/kqh9+
   L5G8FaHVqhZhHTw6I129wEXHH05wyDtk1AyBxjZcPYWJm+6EeaJpdmQRS
   925IK5qorzQAfpaKxRTSVf7LBJJ0fyXjA3VSZOiU0+S3bYIgmSyGZmuad
   Q==;
X-CSE-ConnectionGUID: e2ekHp31S0yJGB+Qu+LCEQ==
X-CSE-MsgGUID: //4fJ002TGyxRhyYOjLRUw==
X-IronPort-AV: E=McAfee;i="6600,9927,11059"; a="27639720"
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; 
   d="scan'208";a="27639720"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 17:25:43 -0700
X-CSE-ConnectionGUID: 9TkBRgSlSGKCjntmzO4jwA==
X-CSE-MsgGUID: +l8ECnu8TuuGDt0JOkMv8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; 
   d="scan'208";a="31075335"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 29 Apr 2024 17:25:42 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s1bJT-0007YO-0H;
	Tue, 30 Apr 2024 00:25:39 +0000
Date: Tue, 30 Apr 2024 08:25:12 +0800
From: kernel test robot <lkp@intel.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: WARNING: modpost: vmlinux: section mismatch in reference:
 psmouse_resync+0xa4 (section: .text) -> .LBB102 (section: .init.text)
Message-ID: <202404300842.JYA2baD8-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Jens,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   98369dccd2f8e16bf4c6621053af7aa4821dcf8e
commit: 6b69c4ab4f685327d9e10caf0d84217ba23a8c4b io_uring/kbuf: protect io_buffer_list teardown with a reference
date:   4 weeks ago
config: riscv-randconfig-r021-20230409 (https://download.01.org/0day-ci/archive/20240430/202404300842.JYA2baD8-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240430/202404300842.JYA2baD8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404300842.JYA2baD8-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: vmlinux: section mismatch in reference: ntb_netdev_change_mtu+0x17e (section: .text) -> .L385 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: ntb_netdev_close+0x44 (section: .text) -> .L385 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: ntb_netdev_open+0xec (section: .text) -> .L385 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: tbnet_resume+0x18 (section: .text) -> .L194 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: tbnet_resume+0x1c (section: .text) -> .L194 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: tbnet_suspend+0x18 (section: .text) -> .L194 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: tbnet_suspend+0x1c (section: .text) -> .L194 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: trace_event_raw_event_tbnet_frame+0xba (section: .text) -> .LBE112 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: trace_event_raw_event_tbnet_ip_frame+0xbc (section: .text) -> .LBE112 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: trace_event_raw_event_tbnet_skb+0xb8 (section: .text) -> .LBE112 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: eni_send+0x3e (section: .text) -> .L385 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: free_scq+0xbe (section: .text) -> .L385 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: free_scq+0x15c (section: .text) -> .L385 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: recycle_rx_skb+0x16c (section: .text) -> .L385 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: add_rx_skb+0x342 (section: .text) -> .L385 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: drain_scq+0xae (section: .text) -> .L385 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: idt77252_send+0x84 (section: .text) -> .L385 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: idt77252_send+0x114 (section: .text) -> .L385 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: idt77252_send+0x16e (section: .text) -> .L385 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: idt77252_send_oam+0x15a (section: .text) -> .L385 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: idt77252_send_oam+0x22a (section: .text) -> .L385 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: idt77252_rx_raw+0x28e (section: .text) -> .L385 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: dequeue_rx+0x36a (section: .text) -> .L385 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: dequeue_rx+0x68e (section: .text) -> .L385 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: atm_remove+0x158 (section: .text) -> .L385 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: atm_remove+0x1ae (section: .text) -> .L385 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: atm_remove+0x1cc (section: .text) -> .L385 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: pclose+0x310 (section: .text) -> .L385 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: atmtcp_c_send+0x2b4 (section: .text) -> .L385 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: atmtcp_send_control+0xaa (section: .text) -> .L385 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: atmtcp_v_send+0x4a (section: .text) -> .L385 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: atmtcp_v_send+0x84 (section: .text) -> .L385 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: atmtcp_v_send+0xb8 (section: .text) -> .L385 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: atmtcp_v_send+0x12a (section: .text) -> .L385 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: atmtcp_v_send+0x1fa (section: .text) -> .L385 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: mptspi_dv_renegotiate_work+0x60 (section: .text) -> .L0  (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: mptspi_dv_renegotiate_work+0xf6 (section: .text) -> .L0  (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: mptspi_dv_renegotiate_work+0x116 (section: .text) -> .L0  (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: mptspi_dv_renegotiate_work+0x13c (section: .text) -> .L0  (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: mpt_work_wrapper+0x56 (section: .text) -> .L0  (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: mpt_work_wrapper+0xde (section: .text) -> .L0  (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: mptctl_getiocinfo+0x204 (section: .text) -> .L0  (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: mptctl_getiocinfo+0x25e (section: .text) -> .L0  (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: mptctl_gettargetinfo+0x10a (section: .text) -> .L0  (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: mptctl_gettargetinfo+0x1b6 (section: .text) -> .L0  (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: mptctl_do_mpt_command.isra.0+0x35c (section: .text) -> .L0  (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: mptctl_do_mpt_command.isra.0+0x3d0 (section: .text) -> .L0  (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: fwnet_tx+0xe4 (section: .text) -> .L385 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: fwnet_tx+0x474 (section: .text) -> .L385 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vfio_pci_core_runtime_suspend+0x50 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vfio_msi_set_vector_signal+0xda (section: .text) -> .L0  (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vfio_msi_set_vector_signal+0x368 (section: .text) -> .L0  (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vfio_pci_set_intx_trigger+0xd0 (section: .text) -> .L0  (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vfio_pci_set_intx_trigger+0x30e (section: .text) -> .L0  (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vfio_user_config_read+0x86 (section: .text) -> __setup_str_early_hostname (section: .init.rodata)
WARNING: modpost: vmlinux: section mismatch in reference: vfio_basic_config_write+0x60 (section: .text) -> __setup_str_early_hostname (section: .init.rodata)
WARNING: modpost: vmlinux: section mismatch in reference: vfio_basic_config_write+0x274 (section: .text) -> __setup_str_early_hostname (section: .init.rodata)
WARNING: modpost: vmlinux: section mismatch in reference: vfio_basic_config_write+0x346 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: vfio_raw_config_read+0x8a (section: .text) -> __setup_str_early_hostname (section: .init.rodata)
WARNING: modpost: vmlinux: section mismatch in reference: ktiocomplete+0x5f6 (section: .text) -> .L385 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: aoe_flush_iocq_by_index+0x1b6 (section: .text) -> .L385 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: skbfree+0xd2 (section: .text) -> .L385 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: is_aoe_netif+0x40 (section: .text) -> early_randomize_kstack_offset (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: is_aoe_netif+0x1e8 (section: .text) -> early_randomize_kstack_offset (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: aoenet_rcv+0x4a (section: .text) -> .L385 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: aoenet_rcv+0x268 (section: .text) -> .L385 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: hub_port_connect+0x144 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: usb_port_runtime_resume+0x142 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: usb_hub_create_port_device+0x238 (section: .text) -> .L0  (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: ohci_hcd_sm501_drv_probe+0x22a (section: .text) -> .LBE107 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: trace_xhci_dbg_cancel_urb+0x38 (section: .text) -> pt_ops (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: xhci_alloc_virt_device+0xd0 (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: xhci_alloc_virt_device+0xf2 (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: xhci_alloc_command_with_ctx+0x3c (section: .text) -> set_reset_devices (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: trace_xhci_dbg_cancel_urb+0x38 (section: .text) -> pt_ops (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: trace_event_raw_event_xhci_log_msg+0xd6 (section: .text) -> .LBE112 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: trace_event_raw_event_xhci_log_trb+0xc0 (section: .text) -> .LBE112 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: trace_event_raw_event_xhci_log_free_virt_dev+0xd8 (section: .text) -> .LBE112 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: trace_event_raw_event_xhci_log_virt_dev+0xf6 (section: .text) -> .LBE112 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: trace_event_raw_event_xhci_log_urb+0x102 (section: .text) -> .LBE112 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: trace_event_raw_event_xhci_log_ep_ctx+0xbe (section: .text) -> .LBE112 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: trace_event_raw_event_xhci_log_slot_ctx+0xb6 (section: .text) -> .LBE112 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: trace_event_raw_event_xhci_log_ctrl_ctx+0xaa (section: .text) -> .LBE112 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: trace_event_raw_event_xhci_log_portsc+0xb6 (section: .text) -> .LBE112 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: trace_event_raw_event_xhci_log_doorbell+0xaa (section: .text) -> .LBE112 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: trace_event_raw_event_xhci_dbc_log_request+0xbe (section: .text) -> .LBE112 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: trace_event_raw_event_xhci_log_ctx+0x124 (section: .text) -> .LBE112 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: trace_event_raw_event_xhci_log_ring+0xf2 (section: .text) -> .LBE112 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: sisusb_probe+0x26 (section: .text) -> .L330 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: trace_event_raw_event_musb_regb+0xba (section: .text) -> .LBE112 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: trace_event_raw_event_musb_regw+0xba (section: .text) -> .LBE112 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: trace_event_raw_event_musb_regl+0xba (section: .text) -> .LBE112 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: trace_event_raw_event_musb_req+0xe4 (section: .text) -> .LBE112 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: trace_event_raw_event_musb_log+0x1c8 (section: .text) -> .LBE112 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: trace_event_raw_event_musb_isr+0x20c (section: .text) -> .LBE112 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: trace_event_raw_event_musb_urb+0x204 (section: .text) -> .LBE112 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: trace_event_raw_event_musb_state+0x23a (section: .text) -> .LBE112 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: musb_urb_dequeue+0x22 (section: .text) -> .LBE99 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: musb_urb_dequeue+0x26 (section: .text) -> .LBE99 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: ci_hdrc_imx_notify_event+0x44 (section: .text) -> .L189 (section: .init.text)
>> WARNING: modpost: vmlinux: section mismatch in reference: psmouse_resync+0xa4 (section: .text) -> .LBB102 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: cypress_ps2_read_cmd_status+0xae (section: .text) -> .LBB102 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: iqs626_input_init+0x2b4 (section: .text) -> .LBB108 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: rtc_ktime_to_tm+0x68 (section: .text) -> __initramfs_size (section: .init.ramfs.info)
WARNING: modpost: vmlinux: section mismatch in reference: trace_event_raw_event_rtc_time_alarm_class+0xb2 (section: .text) -> .LBE112 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: trace_event_raw_event_rtc_irq_set_freq+0xaa (section: .text) -> .LBE112 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: trace_event_raw_event_rtc_irq_set_state+0xaa (section: .text) -> .LBE112 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: trace_event_raw_event_rtc_alarm_irq_enable+0xaa (section: .text) -> .LBE112 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: trace_event_raw_event_rtc_offset_class+0xaa (section: .text) -> .LBE112 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: trace_event_raw_event_rtc_timer_class+0xbc (section: .text) -> .LBE112 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: rtc_add_offset+0x92 (section: .text) -> __initramfs_size (section: .init.ramfs.info)
WARNING: modpost: vmlinux: section mismatch in reference: rtc_subtract_offset+0x74 (section: .text) -> __initramfs_size (section: .init.ramfs.info)
WARNING: modpost: vmlinux: section mismatch in reference: __rtc_read_alarm+0x462 (section: .text) -> __initramfs_size (section: .init.ramfs.info)
WARNING: modpost: vmlinux: section mismatch in reference: wakealarm_store+0x1e2 (section: .text) -> __initramfs_size (section: .init.ramfs.info)
WARNING: modpost: vmlinux: section mismatch in reference: ds1374_read_time+0xbc (section: .text) -> __initramfs_size (section: .init.ramfs.info)
WARNING: modpost: vmlinux: section mismatch in reference: ds1374_set_alarm+0xfa (section: .text) -> __initramfs_size (section: .init.ramfs.info)
WARNING: modpost: vmlinux: section mismatch in reference: ds1374_read_alarm+0x194 (section: .text) -> __initramfs_size (section: .init.ramfs.info)
WARNING: modpost: vmlinux: section mismatch in reference: ds2404_read_time+0x92 (section: .text) -> __initramfs_size (section: .init.ramfs.info)
WARNING: modpost: vmlinux: section mismatch in reference: ftrtc010_rtc_read_time+0x74 (section: .text) -> __initramfs_size (section: .init.ramfs.info)
WARNING: modpost: vmlinux: section mismatch in reference: test_rtc_read_alarm+0x5c (section: .text) -> __initramfs_size (section: .init.ramfs.info)
WARNING: modpost: vmlinux: section mismatch in reference: test_rtc_read_time+0x3a (section: .text) -> __initramfs_size (section: .init.ramfs.info)
WARNING: modpost: vmlinux: section mismatch in reference: trace_event_raw_event_i2c_read+0xc8 (section: .text) -> .LBE112 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: trace_event_raw_event_i2c_result+0xb4 (section: .text) -> .LBE112 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: trace_event_raw_event_i2c_write+0xe8 (section: .text) -> .LBE112 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: trace_event_raw_event_i2c_reply+0xe8 (section: .text) -> .LBE112 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: i2c_register_adapter+0x31e (section: .text) -> .L0  (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: i2c_register_adapter+0x322 (section: .text) -> .L0  (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: i2c_register_adapter+0x3a4 (section: .text) -> .L0  (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: trace_event_raw_event_smbus_read+0xc8 (section: .text) -> .LBE112 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: trace_event_raw_event_smbus_result+0xd8 (section: .text) -> .LBE112 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: trace_event_raw_event_smbus_write+0x17c (section: .text) -> .LBE112 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: trace_event_raw_event_smbus_reply+0x180 (section: .text) -> .LBE112 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: trace_event_raw_event_i2c_slave+0xfc (section: .text) -> .LBE112 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: i2c_dw_set_timings_master+0xb8 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: i2c_dw_set_timings_master+0x156 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: i2c_dw_set_timings_master+0x1a4 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: i2c_dw_set_timings_master+0x27c (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: dw_i2c_plat_probe+0x284 (section: .text) -> .L223 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: i2c_dw_pci_probe+0x204 (section: .text) -> .L223 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: adv7511_probe+0x182 (section: .text) -> .L0  (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: adv7511_probe+0x226 (section: .text) -> .L0  (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: adv7511_probe+0x248 (section: .text) -> .L0  (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: adv76xx_probe+0x874 (section: .text) -> .L0  (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: adv76xx_probe+0x91c (section: .text) -> .L0  (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: adv7842_probe+0x4a2 (section: .text) -> .L0  (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: adv7842_probe+0x54e (section: .text) -> .L0  (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: tda18271c1_rf_tracking_filter_calibration.isra.0+0x2a (section: .text) -> done (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: tda18271_channel_configuration.isra.0+0xec (section: .text) -> done (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: v4l2_flash_init_controls+0x164 (section: .text) -> .L0  (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: v4l2_ctrl_new_fwnode_properties+0x54 (section: .text) -> .L0  (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: trace_event_raw_event_v4l2_event_class+0x150 (section: .text) -> .LBE112 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: trace_event_raw_event_vb2_v4l2_event_class+0x134 (section: .text) -> .LBE112 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: trace_event_raw_event_vb2_event_class+0xd4 (section: .text) -> .LBE112 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: si4713_probe+0x6a0 (section: .text) -> .L0  (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: wl1273_fm_radio_probe+0x3b4 (section: .text) -> .L0  (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: usb_keene_probe+0x132 (section: .text) -> .L0  (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: power_supply_unregister+0x6e (section: .text) -> .LBB92 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: power_supply_uevent+0x196 (section: .text) -> do_early_param (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: power_supply_uevent+0x19a (section: .text) -> do_early_param (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: trace_event_raw_event_hwmon_attr_show_string+0x1ea (section: .text) -> .LBE112 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: trace_event_raw_event_hwmon_attr_class+0x110 (section: .text) -> .LBE112 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: trace_event_raw_event_thermal_temperature+0x154 (section: .text) -> .LBE112 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: trace_event_raw_event_thermal_zone_trip+0x154 (section: .text) -> .LBE112 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: trace_event_raw_event_cdev_update+0x15c (section: .text) -> .LBE112 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: __thermal_of_unbind+0xd6 (section: .text) -> .L108 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: bang_bang_control+0x1dc (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: raid5_quiesce+0x320 (section: .text) -> .L0  (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: bch_btree_set_root+0x28 (section: .text) -> __setup_str_debug_kernel (section: .init.rodata)
WARNING: modpost: vmlinux: section mismatch in reference: bch_btree_set_root+0x2c (section: .text) -> __setup_str_debug_kernel (section: .init.rodata)
WARNING: modpost: vmlinux: section mismatch in reference: cached_dev_write+0x88 (section: .text) -> __setup_str_warn_bootconfig (section: .init.rodata)
WARNING: modpost: vmlinux: section mismatch in reference: bch_cache_set_alloc+0x7c4 (section: .text) -> .L3 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: trace_event_raw_event_bcache_request+0xf0 (section: .text) -> .LBE112 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: trace_event_raw_event_bkey+0xd6 (section: .text) -> .LBE112 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: trace_event_raw_event_bcache_bio+0xd4 (section: .text) -> .LBE112 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: trace_event_raw_event_bcache_read+0xe4 (section: .text) -> .LBE112 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: trace_event_raw_event_bcache_journal_write+0xdc (section: .text) -> .LBE112 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: trace_event_raw_event_bcache_btree_gc_coalesce+0xa2 (section: .text) -> .LBE112 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: trace_event_raw_event_bcache_keyscan+0xd4 (section: .text) -> .LBE112 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: trace_event_raw_event_bcache_alloc_fail+0x15c (section: .text) -> .LBE112 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: trace_event_raw_event_bcache_btree_insert_key+0x17a (section: .text) -> .LBE112 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: trace_event_raw_event_bcache_invalidate+0x108 (section: .text) -> .LBE112 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: trace_event_raw_event_bcache_alloc+0xec (section: .text) -> .LBE112 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: trace_event_raw_event_bcache_write+0xfa (section: .text) -> .LBE112 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: trace_event_raw_event_cache_set+0xb4 (section: .text) -> .LBE112 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: trace_event_raw_event_btree_node+0x11c (section: .text) -> .LBE112 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: trace_event_raw_event_btree_split+0x124 (section: .text) -> .LBE112 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: trace_event_raw_event_bcache_btree_write+0x156 (section: .text) -> .LBE112 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: bch_parse_uuid+0xde (section: .text) -> early_randomize_kstack_offset (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: dm_table_set_restrictions+0x5cc (section: .text) -> .L0  (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: read_exceptions+0x46 (section: .text) -> .L128 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: dm_block_manager_create+0x5e (section: .text) -> .L128 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: commit+0x84 (section: .text) -> .L122 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: pool_status+0x196 (section: .text) -> .L122 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: alloc_data_block+0x20c (section: .text) -> .L122 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: dm_cache_set_dirty_bits+0x108 (section: .text) -> early_hostname (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: dm_integrity_ctr+0x19f2 (section: .text) -> .L128 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: dev_pm_opp_clear_config+0x2a (section: .text) -> .L0  (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: devm_pm_opp_config_release+0x2a (section: .text) -> .L0  (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: trace_event_raw_event_mmc_request_done+0x51a (section: .text) -> .LBE112 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: trace_event_raw_event_mmc_request_start+0x42c (section: .text) -> .LBE112 (section: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: trace_event_raw_event_ufshcd_command+0xec (section: .text) -> .LBE112 (section: .init.text)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

