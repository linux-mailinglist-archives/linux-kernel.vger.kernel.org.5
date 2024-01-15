Return-Path: <linux-kernel+bounces-26347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 236CB82DED1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 19:02:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC4472833B8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 18:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9224518626;
	Mon, 15 Jan 2024 18:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yJcp3Dlh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13F618622;
	Mon, 15 Jan 2024 18:01:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD2A7C43390;
	Mon, 15 Jan 2024 18:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705341702;
	bh=eGU5zGqDHt/zlsfhjPCOcLKKWGhuiy2WSBjrSyW6VvI=;
	h=From:To:Cc:Subject:Date:From;
	b=yJcp3DlhPRTArp5XjXdlgFheEPpDDZLSbWyDj/UK/RJYIdNiNZ3jqOUI7QIxfmSZJ
	 zgdw6sV9PgOVT6YWSuCBm3r2XI7Y+NqrUyEw41GRWLMGUmMErhL5NCvQB6Yh/ZHFnE
	 GPeha4JOVyTrZdCQfHZREzpSC7bOBJ2UwFdYevgA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.10.208
Date: Mon, 15 Jan 2024 19:01:34 +0100
Message-ID: <2024011532-lustiness-hybrid-fc72@gregkh>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 5.10.208 kernel.

All users of the 5.10 kernel series must upgrade.

The updated 5.10.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.10.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                           |    2 
 arch/arm/mach-sunxi/mc_smp.c                       |    4 
 arch/powerpc/kernel/ppc_save_regs.S                |    6 
 arch/x86/kernel/kprobes/core.c                     |    3 
 drivers/firewire/ohci.c                            |   51 +++++
 drivers/gpu/drm/i915/display/intel_dp.c            |    2 
 drivers/gpu/drm/qxl/qxl_drv.h                      |    2 
 drivers/gpu/drm/qxl/qxl_dumb.c                     |    5 
 drivers/gpu/drm/qxl/qxl_gem.c                      |   25 +-
 drivers/gpu/drm/qxl/qxl_ioctl.c                    |    6 
 drivers/i2c/i2c-core.h                             |    4 
 drivers/mmc/core/block.c                           |    7 
 drivers/mmc/core/host.c                            |    1 
 drivers/mmc/host/meson-mx-sdhc-mmc.c               |   26 --
 drivers/mmc/host/sdhci-sprd.c                      |   10 -
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |    4 
 drivers/net/ethernet/broadcom/genet/bcmgenet.c     |    4 
 drivers/net/ethernet/intel/i40e/i40e_main.c        |   11 +
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |   34 +++
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h |    3 
 drivers/net/ethernet/marvell/octeontx2/af/npc.h    |    4 
 drivers/net/ethernet/qlogic/qla3xxx.c              |  198 +++++++++------------
 drivers/net/ethernet/sfc/rx_common.c               |    4 
 drivers/net/usb/ax88172a.c                         |    4 
 drivers/nvme/host/trace.h                          |    2 
 drivers/pci/quirks.c                               |   28 ++
 fs/block_dev.c                                     |   21 +-
 include/net/dst_ops.h                              |    2 
 mm/memory-failure.c                                |    6 
 mm/memory.c                                        |    4 
 net/core/dst.c                                     |    8 
 net/core/sock.c                                    |    1 
 net/dns_resolver/dns_key.c                         |   19 --
 net/ipv6/route.c                                   |   13 -
 net/netfilter/nf_tables_api.c                      |   57 +++++-
 net/netfilter/nft_immediate.c                      |    2 
 net/nfc/llcp_core.c                                |   39 +++-
 net/sched/em_text.c                                |    4 
 net/socket.c                                       |    2 
 net/tls/tls_sw.c                                   |    2 
 sound/pci/hda/patch_realtek.c                      |    1 
 sound/soc/meson/g12a-toacodec.c                    |    5 
 sound/soc/meson/g12a-tohdmitx.c                    |    8 
 43 files changed, 419 insertions(+), 225 deletions(-)

Aditya Gupta (1):
      powerpc: update ppc_save_regs to save current r1 in pt_regs

Adrian Cinal (1):
      net: bcmgenet: Fix FCS generation for fragmented skbuffs

Andrii Staikov (1):
      i40e: Restore VF MSI-X state during PCI reset

Bartosz Pawlowski (2):
      PCI: Extract ATS disabling to a helper function
      PCI: Disable ATS for specific Intel IPU E2000 devices

Benjamin Bara (1):
      i2c: core: Fix atomic xfer check for non-preempt config

Chen Ni (1):
      asix: Add check for usbnet_get_endpoints

Christophe JAILLET (1):
      net/qla3xxx: switch from 'pci_' to 'dma_' API

Dinghao Liu (1):
      net/qla3xxx: fix potential memleak in ql_alloc_buffer_queues

Edward Adam Davis (1):
      keys, dns: Fix missing size check of V1 server-list header

Geert Uytterhoeven (1):
      mmc: core: Cancel delayed work before releasing host

Greg Kroah-Hartman (2):
      Revert "nvme: use command_id instead of req->tag in trace_nvme_complete_rq()"
      Linux 5.10.208

Hangyu Hua (1):
      net: sched: em_text: fix possible memory leak in em_text_destroy()

Jiajun Xie (1):
      mm: fix unmap_mapping_range high bits shift bug

Jinghao Jia (1):
      x86/kprobes: fix incorrect return address calculation in kprobe_emulate_call_indirect

John Fastabend (1):
      net: tls, update curr on splice as well

Jon Maxwell (1):
      ipv6: remove max_size check inline with ipv4

Jorge Ramirez-Ortiz (1):
      mmc: rpmb: fixes pause retune on all RPMB partitions.

Ke Xiao (1):
      i40e: fix use-after-free in i40e_aqc_add_filters()

Khaled Almahallawy (1):
      drm/i915/dp: Fix passing the correct DPCD_REV for drm_dp_set_phy_test_pattern

Marc Dionne (1):
      net: Save and restore msg_namelen in sock_sendmsg

Mark Brown (4):
      ASoC: meson: g12a-toacodec: Validate written enum values
      ASoC: meson: g12a-tohdmitx: Validate written enum values
      ASoC: meson: g12a-toacodec: Fix event generation
      ASoC: meson: g12a-tohdmitx: Fix event generation for S/PDIF mux

Matthew Wilcox (Oracle) (1):
      mm/memory-failure: check the mapcount of the precise page

Michael Chan (1):
      bnxt_en: Remove mis-applied code from bnxt_cfg_ntp_filters()

Pablo Neira Ayuso (2):
      netfilter: nftables: add loop check helper function
      netfilter: nft_immediate: drop chain reference counter on error

Phil Sutter (1):
      netfilter: nf_tables: Reject tables of unsupported family

Sarthak Kukreti (1):
      block: Don't invalidate pagecache for invalid falloc modes

Siddh Raman Pant (1):
      nfc: llcp_core: Hold a ref to llcp_local->dev when holding a ref to llcp_local

Siddhesh Dharme (1):
      ALSA: hda/realtek: Fix mute and mic-mute LEDs for HP ProBook 440 G6

Stefan Wahren (1):
      ARM: sun9i: smp: Fix array-index-out-of-bounds read in sunxi_mc_smp_init

Sudheer Mogilappagari (1):
      i40e: Fix filter input checks to prevent config with invalid values

Suman Ghosh (1):
      octeontx2-af: Fix marking couple of structure as __packed

Takashi Sakamoto (1):
      firewire: ohci: suppress unexpected system reboot in AMD Ryzen machines and ASM108x/VT630x PCIe cards

Thomas Lange (1):
      net: Implement missing SO_TIMESTAMPING_NEW cmsg support

Wander Lairson Costa (1):
      drm/qxl: fix UAF on handle creation

Wenchao Chen (1):
      mmc: sdhci-sprd: Fix eMMC init failure after hw reset

Zhipeng Lu (1):
      sfc: fix a double-free bug in efx_probe_filters

Ziyang Huang (1):
      mmc: meson-mx-sdhc: Fix initialization frozen issue


