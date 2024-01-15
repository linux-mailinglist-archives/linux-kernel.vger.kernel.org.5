Return-Path: <linux-kernel+bounces-26348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A591482DED4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 19:03:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5ADD51F22C76
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 18:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 157EC18643;
	Mon, 15 Jan 2024 18:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VINB6ag9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2625E18EBB;
	Mon, 15 Jan 2024 18:01:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36915C433F1;
	Mon, 15 Jan 2024 18:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705341707;
	bh=5S2Ln2iTBG+rtW8LZsJ8WTeV5bW1LfqzpXHM/sigx2c=;
	h=From:To:Cc:Subject:Date:From;
	b=VINB6ag9MH1RGFGSMHIIwzdg4fUDHiwerRqQ1MvnPYG6kf5OYQGR+AgBjHImANuRC
	 VJ2zk7wJcav6v52oJqcw7F0B690r3YKrsSwxUEUtKBOtjzXdkAID+wJG5y0s16XSX4
	 chENx7f9b1A2E3drMB3WPdCXqRR6WIhECTQFIQgc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.15.147
Date: Mon, 15 Jan 2024 19:01:42 +0100
Message-ID: <2024011541-defective-scuff-c55e@gregkh>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 5.15.147 kernel.

All users of the 5.15 kernel series must upgrade.

The updated 5.15.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.15.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                 |    2 
 arch/arm/mach-sunxi/mc_smp.c                             |    4 
 arch/x86/kernel/kprobes/core.c                           |    3 
 block/fops.c                                             |   21 +-
 drivers/firewire/ohci.c                                  |   51 +++++
 drivers/gpu/drm/bridge/ti-sn65dsi86.c                    |    4 
 drivers/gpu/drm/i915/display/intel_dp.c                  |    2 
 drivers/i2c/i2c-core.h                                   |    4 
 drivers/mmc/core/block.c                                 |    7 
 drivers/mmc/core/host.c                                  |    1 
 drivers/mmc/host/meson-mx-sdhc-mmc.c                     |   26 --
 drivers/mmc/host/sdhci-sprd.c                            |   10 -
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                |    4 
 drivers/net/ethernet/broadcom/genet/bcmgenet.c           |    4 
 drivers/net/ethernet/intel/i40e/i40e_main.c              |   11 +
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c       |   34 +++
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h       |    3 
 drivers/net/ethernet/intel/igc/igc.h                     |    1 
 drivers/net/ethernet/intel/igc/igc_ethtool.c             |   42 ++++
 drivers/net/ethernet/intel/igc/igc_tsn.c                 |    2 
 drivers/net/ethernet/marvell/octeontx2/af/cgx.c          |   68 ++++--
 drivers/net/ethernet/marvell/octeontx2/af/lmac_common.h  |    1 
 drivers/net/ethernet/marvell/octeontx2/af/npc.h          |    4 
 drivers/net/ethernet/marvell/octeontx2/af/rpm.c          |   77 ++++---
 drivers/net/ethernet/marvell/octeontx2/af/rpm.h          |    1 
 drivers/net/ethernet/marvell/octeontx2/af/rvu.h          |    3 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c      |   33 +++
 drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c      |  146 ++-------------
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c |    1 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c     |   15 -
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c     |   12 -
 drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_rx.c |    9 
 drivers/net/ethernet/qlogic/qla3xxx.c                    |    2 
 drivers/net/ethernet/realtek/r8169_main.c                |    2 
 drivers/net/ethernet/sfc/rx_common.c                     |    4 
 drivers/net/usb/ax88172a.c                               |    4 
 drivers/net/usb/ax88179_178a.c                           |  115 ++---------
 drivers/net/wireless/intel/iwlwifi/pcie/internal.h       |    4 
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c             |    8 
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c          |   17 -
 drivers/pci/pci.c                                        |    6 
 drivers/pci/pci.h                                        |    2 
 drivers/pci/pcie/aspm.c                                  |   19 +
 include/linux/module.h                                   |    9 
 include/net/dst_ops.h                                    |    2 
 kernel/module.c                                          |    2 
 kernel/trace/trace_kprobe.c                              |    2 
 mm/memory-failure.c                                      |    6 
 mm/memory.c                                              |    4 
 net/can/raw.c                                            |   12 +
 net/core/dst.c                                           |    8 
 net/core/sock.c                                          |   12 +
 net/dns_resolver/dns_key.c                               |   19 -
 net/ipv4/ip_output.c                                     |    2 
 net/ipv6/ip6_output.c                                    |    2 
 net/ipv6/route.c                                         |   13 -
 net/netfilter/nf_tables_api.c                            |   27 ++
 net/netfilter/nft_immediate.c                            |    2 
 net/nfc/llcp_core.c                                      |   39 +++-
 net/sched/em_text.c                                      |    4 
 net/socket.c                                             |    2 
 net/tls/tls_sw.c                                         |    2 
 sound/pci/hda/patch_realtek.c                            |    1 
 sound/soc/fsl/fsl_rpmsg.c                                |   10 -
 sound/soc/meson/g12a-toacodec.c                          |    5 
 sound/soc/meson/g12a-tohdmitx.c                          |    8 
 tools/perf/util/genelf.h                                 |    4 
 tools/testing/selftests/vm/memfd_secret.c                |    3 
 68 files changed, 587 insertions(+), 402 deletions(-)

Adrian Cinal (1):
      net: bcmgenet: Fix FCS generation for fragmented skbuffs

Adrian Hunter (1):
      perf inject: Fix GEN_ELF_TEXT_OFFSET for jit

Andrii Nakryiko (1):
      tracing/kprobes: Fix symbol counting logic by looking at modules as well

Andrii Staikov (1):
      i40e: Restore VF MSI-X state during PCI reset

Benjamin Bara (1):
      i2c: core: Fix atomic xfer check for non-preempt config

Bjorn Helgaas (1):
      Revert "PCI/ASPM: Remove pcie_aspm_pm_state_change()"

Chancel Liu (1):
      ASoC: fsl_rpmsg: Fix error handler with pm_runtime_enable

Chen Ni (1):
      asix: Add check for usbnet_get_endpoints

David Thompson (1):
      mlxbf_gige: fix receive packet race condition

Dinghao Liu (1):
      net/qla3xxx: fix potential memleak in ql_alloc_buffer_queues

Douglas Anderson (1):
      drm/bridge: ti-sn65dsi86: Never store more than msg->size bytes in AUX xfer

Edward Adam Davis (1):
      keys, dns: Fix missing size check of V1 server-list header

Geert Uytterhoeven (1):
      mmc: core: Cancel delayed work before releasing host

Greg Kroah-Hartman (1):
      Linux 5.15.147

Hangyu Hua (1):
      net: sched: em_text: fix possible memory leak in em_text_destroy()

Hariprasad Kelam (1):
      octeontx2-af: Don't enable Pause frames by default

Jiajun Xie (1):
      mm: fix unmap_mapping_range high bits shift bug

Jinghao Jia (1):
      x86/kprobes: fix incorrect return address calculation in kprobe_emulate_call_indirect

Jiri Olsa (1):
      kallsyms: Make module_kallsyms_on_each_symbol generally available

Johannes Berg (1):
      wifi: iwlwifi: pcie: don't synchronize IRQs from IRQ

John Fastabend (1):
      net: tls, update curr on splice as well

Jon Maxwell (1):
      ipv6: remove max_size check inline with ipv4

Jorge Ramirez-Ortiz (1):
      mmc: rpmb: fixes pause retune on all RPMB partitions.

Justin Chen (2):
      net: usb: ax88179_178a: remove redundant init code
      net: usb: ax88179_178a: move priv to driver_priv

Jörn-Thorben Hinz (1):
      net: Implement missing getsockopt(SO_TIMESTAMPING_NEW)

Kai-Heng Feng (1):
      r8169: Fix PCI error on system resume

Ke Xiao (1):
      i40e: fix use-after-free in i40e_aqc_add_filters()

Khaled Almahallawy (1):
      drm/i915/dp: Fix passing the correct DPCD_REV for drm_dp_set_phy_test_pattern

Kurt Kanzenbach (3):
      igc: Report VLAN EtherType matching back to user
      igc: Check VLAN TCI mask
      igc: Check VLAN EtherType mask

Marc Dionne (1):
      net: Save and restore msg_namelen in sock_sendmsg

Marc Kleine-Budde (2):
      can: raw: add support for SO_TXTIME/SCM_TXTIME
      can: raw: add support for SO_MARK

Mark Brown (4):
      ASoC: meson: g12a-toacodec: Validate written enum values
      ASoC: meson: g12a-tohdmitx: Validate written enum values
      ASoC: meson: g12a-toacodec: Fix event generation
      ASoC: meson: g12a-tohdmitx: Fix event generation for S/PDIF mux

Matthew Wilcox (Oracle) (1):
      mm/memory-failure: check the mapcount of the precise page

Michael Chan (1):
      bnxt_en: Remove mis-applied code from bnxt_cfg_ntp_filters()

Muhammad Usama Anjum (1):
      selftests: secretmem: floor the memory size to the multiple of page_size

Naveen Mamindlapalli (2):
      octeontx2-af: Always configure NIX TX link credits based on max frame size
      octeontx2-af: Re-enable MAC TX in otx2_stop processing

Pablo Neira Ayuso (1):
      netfilter: nft_immediate: drop chain reference counter on error

Phil Sutter (1):
      netfilter: nf_tables: Reject tables of unsupported family

Rodrigo Cataldo (1):
      igc: Fix hicredit calculation

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

Sunil Goutham (1):
      octeontx2-af: Set NIX link credits based on max LMAC

Takashi Sakamoto (1):
      firewire: ohci: suppress unexpected system reboot in AMD Ryzen machines and ASM108x/VT630x PCIe cards

Thomas Lange (1):
      net: Implement missing SO_TIMESTAMPING_NEW cmsg support

Vadim Fedorenko (1):
      net-timestamp: extend SOF_TIMESTAMPING_OPT_ID to HW timestamps

Wenchao Chen (1):
      mmc: sdhci-sprd: Fix eMMC init failure after hw reset

Zhipeng Lu (1):
      sfc: fix a double-free bug in efx_probe_filters

Ziyang Huang (1):
      mmc: meson-mx-sdhc: Fix initialization frozen issue


