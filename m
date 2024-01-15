Return-Path: <linux-kernel+bounces-26342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BCDA82DEC7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 19:01:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5051F1F22C72
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 18:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E610182C7;
	Mon, 15 Jan 2024 18:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vBun+Yez"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47A3182AE;
	Mon, 15 Jan 2024 18:01:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4B17C433F1;
	Mon, 15 Jan 2024 18:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705341679;
	bh=jz8zJKOiXbrdgUUyV7C+GnU23XpIF9FkwFoZH7sG08w=;
	h=From:To:Cc:Subject:Date:From;
	b=vBun+YezG5BjOr9ozXt6mnO40EcJ+iwWEm/9N6jnCYXqSXA+L6DtAqOCAi3KqkWBS
	 uA3hsFlGmJBiVaQmgWxgexA6dbCjS4w1x0Sm7sPIjXsvtFof6LDLvMnsKJQW1JfBlS
	 b2IH+o2HEYf+yer3eKSTQwaIt55RPuyJ27/Smokw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 4.19.305
Date: Mon, 15 Jan 2024 19:01:10 +0100
Message-ID: <2024011508-shakiness-resonant-f15e@gregkh>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 4.19.305 kernel.

All users of the 4.19 kernel series must upgrade.

The updated 4.19.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-4.19.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                           |    2 
 arch/arm/mach-sunxi/mc_smp.c                       |    4 
 drivers/firewire/ohci.c                            |   51 +++++
 drivers/mmc/core/block.c                           |    7 
 drivers/mmc/core/host.c                            |    1 
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |    4 
 drivers/net/ethernet/broadcom/genet/bcmgenet.c     |    4 
 drivers/net/ethernet/intel/i40e/i40e_main.c        |   11 +
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |   34 +++
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h |    3 
 drivers/net/ethernet/qlogic/qla3xxx.c              |  198 +++++++++------------
 drivers/net/usb/ax88172a.c                         |    4 
 drivers/pci/quirks.c                               |   28 ++
 fs/fuse/dir.c                                      |   10 -
 include/net/dst_ops.h                              |    6 
 include/net/netns/ipv6.h                           |    4 
 mm/memory-failure.c                                |    6 
 mm/memory.c                                        |    4 
 net/core/dst.c                                     |    8 
 net/ipv6/route.c                                   |   25 +-
 net/netfilter/nf_tables_api.c                      |   27 ++
 net/nfc/llcp_core.c                                |   39 +++-
 net/sched/em_text.c                                |    4 
 net/socket.c                                       |    2 
 24 files changed, 330 insertions(+), 156 deletions(-)

Adrian Cinal (1):
      net: bcmgenet: Fix FCS generation for fragmented skbuffs

Andrii Staikov (1):
      i40e: Restore VF MSI-X state during PCI reset

Bartosz Pawlowski (2):
      PCI: Extract ATS disabling to a helper function
      PCI: Disable ATS for specific Intel IPU E2000 devices

Chen Ni (1):
      asix: Add check for usbnet_get_endpoints

Christophe JAILLET (1):
      net/qla3xxx: switch from 'pci_' to 'dma_' API

Dinghao Liu (1):
      net/qla3xxx: fix potential memleak in ql_alloc_buffer_queues

Eric Dumazet (2):
      net/dst: use a smaller percpu_counter batch for dst entries accounting
      ipv6: make ip6_rt_gc_expire an atomic_t

Geert Uytterhoeven (1):
      mmc: core: Cancel delayed work before releasing host

Greg Kroah-Hartman (1):
      Linux 4.19.305

Hangyu Hua (1):
      net: sched: em_text: fix possible memory leak in em_text_destroy()

Jiajun Xie (1):
      mm: fix unmap_mapping_range high bits shift bug

Jon Maxwell (1):
      ipv6: remove max_size check inline with ipv4

Jorge Ramirez-Ortiz (1):
      mmc: rpmb: fixes pause retune on all RPMB partitions.

Ke Xiao (1):
      i40e: fix use-after-free in i40e_aqc_add_filters()

Marc Dionne (1):
      net: Save and restore msg_namelen in sock_sendmsg

Matthew Wilcox (Oracle) (1):
      mm/memory-failure: check the mapcount of the precise page

Michael Chan (1):
      bnxt_en: Remove mis-applied code from bnxt_cfg_ntp_filters()

Peter Oskolkov (1):
      net: add a route cache full diagnostic message

Phil Sutter (1):
      netfilter: nf_tables: Reject tables of unsupported family

Siddh Raman Pant (1):
      nfc: llcp_core: Hold a ref to llcp_local->dev when holding a ref to llcp_local

Stefan Wahren (1):
      ARM: sun9i: smp: Fix array-index-out-of-bounds read in sunxi_mc_smp_init

Sudheer Mogilappagari (1):
      i40e: Fix filter input checks to prevent config with invalid values

Takashi Sakamoto (1):
      firewire: ohci: suppress unexpected system reboot in AMD Ryzen machines and ASM108x/VT630x PCIe cards

ruanmeisi (1):
      fuse: nlookup missing decrement in fuse_direntplus_link


