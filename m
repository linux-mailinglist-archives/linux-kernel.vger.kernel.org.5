Return-Path: <linux-kernel+bounces-26344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF0382DECA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 19:01:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F16221F22CCB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 18:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF6E18659;
	Mon, 15 Jan 2024 18:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="I4aNfnvM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B1A182BE;
	Mon, 15 Jan 2024 18:01:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75663C433C7;
	Mon, 15 Jan 2024 18:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705341689;
	bh=yxSqhSwwKhKP2cUSsvL6+OG7ycx4PeMrh9xTaqBxcis=;
	h=From:To:Cc:Subject:Date:From;
	b=I4aNfnvMp5uYD4ORv0nCb9n+1FCKK8hLZLuJD0u2OBU7d/TbSqGbE47Txen2mdNFL
	 N3VQaJeKMIHo1BFqEmrFiV2WPX6gjmLlX9NMkdM5Ls4G5mrbpt+BJn8M9F6guH7kSO
	 NzUcA9DTMuKJat97ur5HvdkaxEwGxk1Ga4iYHi04=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.4.267
Date: Mon, 15 Jan 2024 19:01:20 +0100
Message-ID: <2024011519-mating-tag-1f62@gregkh>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 5.4.267 kernel.

All users of the 5.4 kernel series must upgrade.

The updated 5.4.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.4.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                           |    2 
 arch/arm/mach-sunxi/mc_smp.c                       |    4 
 drivers/firewire/ohci.c                            |   51 ++++
 drivers/i2c/i2c-core.h                             |    4 
 drivers/mmc/core/block.c                           |    7 
 drivers/mmc/core/host.c                            |    1 
 drivers/mmc/host/sdhci-sprd.c                      |   10 
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |    4 
 drivers/net/ethernet/broadcom/genet/bcmgenet.c     |    4 
 drivers/net/ethernet/intel/i40e/i40e_main.c        |   11 -
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |   34 ++-
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h |    3 
 drivers/net/ethernet/qlogic/qla3xxx.c              |  198 ++++++++----------
 drivers/net/usb/ax88172a.c                         |    4 
 drivers/net/wireless/ath/ath10k/ce.c               |   79 +++----
 drivers/net/wireless/ath/ath10k/ce.h               |   15 -
 drivers/net/wireless/ath/ath10k/core.c             |   13 -
 drivers/net/wireless/ath/ath10k/hw.h               |    3 
 drivers/net/wireless/ath/ath10k/snoc.c             |   19 +
 drivers/net/wireless/ath/ath10k/snoc.h             |    1 
 drivers/pci/quirks.c                               |   28 ++
 include/net/dst_ops.h                              |    6 
 include/net/netns/ipv6.h                           |    4 
 mm/memory-failure.c                                |    6 
 mm/memory.c                                        |    4 
 net/can/raw.c                                      |   12 +
 net/core/dst.c                                     |   12 -
 net/core/sock.c                                    |    1 
 net/ipv4/ip_output.c                               |    2 
 net/ipv6/ip6_output.c                              |    2 
 net/ipv6/route.c                                   |   25 +-
 net/netfilter/nf_tables_api.c                      |   27 ++
 net/nfc/llcp_core.c                                |   39 +++
 net/sched/em_text.c                                |    4 
 net/socket.c                                       |    2 
 net/tls/tls_sw.c                                   |    2 
 sound/soc/meson/Kconfig                            |    4 
 sound/soc/meson/Makefile                           |    2 
 sound/soc/meson/g12a-tohdmitx.c                    |  227 ++++-----------------
 sound/soc/meson/meson-codec-glue.c                 |  149 +++++++++++++
 sound/soc/meson/meson-codec-glue.h                 |   32 ++
 41 files changed, 648 insertions(+), 409 deletions(-)

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

Douglas Anderson (3):
      ath10k: Wait until copy complete is actually done before completing
      ath10k: Keep track of which interrupts fired, don't poll them
      ath10k: Get rid of "per_ce_irq" hw param

Eric Dumazet (2):
      net/dst: use a smaller percpu_counter batch for dst entries accounting
      ipv6: make ip6_rt_gc_expire an atomic_t

Geert Uytterhoeven (1):
      mmc: core: Cancel delayed work before releasing host

Greg Kroah-Hartman (1):
      Linux 5.4.267

Hangyu Hua (1):
      net: sched: em_text: fix possible memory leak in em_text_destroy()

Jerome Brunet (2):
      ASoC: meson: g12a: extract codec-to-codec utils
      ASoC: meson: codec-glue: fix pcm format cast warning

Jiajun Xie (1):
      mm: fix unmap_mapping_range high bits shift bug

John Fastabend (1):
      net: tls, update curr on splice as well

Jon Maxwell (1):
      ipv6: remove max_size check inline with ipv4

Jorge Ramirez-Ortiz (1):
      mmc: rpmb: fixes pause retune on all RPMB partitions.

Ke Xiao (1):
      i40e: fix use-after-free in i40e_aqc_add_filters()

Marc Dionne (1):
      net: Save and restore msg_namelen in sock_sendmsg

Marc Kleine-Budde (2):
      can: raw: add support for SO_TXTIME/SCM_TXTIME
      can: raw: add support for SO_MARK

Mark Brown (2):
      ASoC: meson: g12a-tohdmitx: Validate written enum values
      ASoC: meson: g12a-tohdmitx: Fix event generation for S/PDIF mux

Matthew Wilcox (Oracle) (1):
      mm/memory-failure: check the mapcount of the precise page

Michael Chan (1):
      bnxt_en: Remove mis-applied code from bnxt_cfg_ntp_filters()

Phil Sutter (1):
      netfilter: nf_tables: Reject tables of unsupported family

Rakesh Pillai (1):
      ath10k: Add interrupt summary based CE processing

Siddh Raman Pant (1):
      nfc: llcp_core: Hold a ref to llcp_local->dev when holding a ref to llcp_local

Stefan Wahren (1):
      ARM: sun9i: smp: Fix array-index-out-of-bounds read in sunxi_mc_smp_init

Sudheer Mogilappagari (1):
      i40e: Fix filter input checks to prevent config with invalid values

Takashi Sakamoto (1):
      firewire: ohci: suppress unexpected system reboot in AMD Ryzen machines and ASM108x/VT630x PCIe cards

Thomas Lange (1):
      net: Implement missing SO_TIMESTAMPING_NEW cmsg support

Vadim Fedorenko (1):
      net-timestamp: extend SOF_TIMESTAMPING_OPT_ID to HW timestamps

Wenchao Chen (1):
      mmc: sdhci-sprd: Fix eMMC init failure after hw reset


