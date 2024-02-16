Return-Path: <linux-kernel+bounces-69149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B03E85851B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 19:27:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DB06B23523
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 908081350EF;
	Fri, 16 Feb 2024 18:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wbCgHubS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CB2130AD5;
	Fri, 16 Feb 2024 18:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708108060; cv=none; b=UGURXEmidXGZuXEIpazW1C9NFhss/sgiKAE/FTKBfiyn313le8z8Z1U1SEhbAk+TILDQFQmtBOnH3IqO7VwGdy6Hn0OSkRQDtvEUmKGIH0uKWGl3rh9WwgqNYuxa3n/BwcxvTgamAFu3ab2nHsCZvKBvhfpIxlNlcg/k3AOnlkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708108060; c=relaxed/simple;
	bh=CDdphN7I+FRntXd/EtAIlhcPcgaQb/31uP/MIsgTsAU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ifWy/e/JwkPz5WUq5qyNhQlO+JztO8gMMeDaRTIZQtjiQbHyl4vPS5+qe8aAYJp/q6rsmHjwKhvGbjkmddemvwZPpeOVxMYafi07sI44NiEFyQhav2D8F3l/TCuNNK/Lfa4XxdtBqLnaFSXunQRAtSrfKQugwFzZamujRYwC5Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wbCgHubS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54623C433C7;
	Fri, 16 Feb 2024 18:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708108059;
	bh=CDdphN7I+FRntXd/EtAIlhcPcgaQb/31uP/MIsgTsAU=;
	h=From:To:Cc:Subject:Date:From;
	b=wbCgHubShJ/aB2aWhLEnSilJ0v4V8KBOmn9Qd0FSgF24LBPVYPEc4uF4h+5FL/aqZ
	 74GBOMRE8ofjY2Ay9ijtupS+6xI0D3fz3Bk5mJRbnBv/5zlspLbvbN72gE/zPIZj0U
	 F4OyyKfWlSyH7AX4o7O8toMDo5bLKC6re0p2/WHU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.78
Date: Fri, 16 Feb 2024 19:27:34 +0100
Message-ID: <2024021633-various-omnivore-f47d@gregkh>
X-Mailer: git-send-email 2.43.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.1.78 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                 |    2 
 block/blk-core.c                                         |   11 +
 block/blk-iocost.c                                       |    7 
 drivers/atm/idt77252.c                                   |    2 
 drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c                  |   10 -
 drivers/dma/fsl-qdma.c                                   |   27 +--
 drivers/dma/ti/k3-udma.c                                 |   10 +
 drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c  |    2 
 drivers/gpu/drm/i915/gvt/handlers.c                      |    3 
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c              |    4 
 drivers/gpu/drm/msm/dp/dp_ctrl.c                         |    5 
 drivers/gpu/drm/msm/dp/dp_link.c                         |   22 +--
 drivers/gpu/drm/msm/dp/dp_reg.h                          |    3 
 drivers/hwmon/aspeed-pwm-tacho.c                         |    7 
 drivers/hwmon/coretemp.c                                 |   40 ++---
 drivers/infiniband/hw/irdma/verbs.c                      |    2 
 drivers/input/keyboard/atkbd.c                           |   13 +
 drivers/input/serio/i8042-acpipnpio.h                    |    6 
 drivers/mtd/parsers/ofpart_core.c                        |   19 ++
 drivers/net/ethernet/aquantia/atlantic/aq_ptp.c          |    4 
 drivers/net/ethernet/aquantia/atlantic/aq_ring.c         |   13 +
 drivers/net/ethernet/aquantia/atlantic/aq_ring.h         |    1 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c |   14 +
 drivers/net/ethernet/stmicro/stmmac/common.h             |    1 
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h           |    3 
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c      |   58 +++++++-
 drivers/net/netdevsim/dev.c                              |    8 -
 drivers/net/ppp/ppp_async.c                              |    4 
 drivers/phy/renesas/phy-rcar-gen3-usb2.c                 |    4 
 drivers/phy/ti/phy-omap-usb2.c                           |    4 
 drivers/scsi/scsi_error.c                                |    3 
 drivers/scsi/scsi_lib.c                                  |    4 
 drivers/usb/dwc3/host.c                                  |    4 
 drivers/usb/host/xhci-plat.c                             |    3 
 drivers/usb/serial/cp210x.c                              |    1 
 drivers/usb/serial/option.c                              |    1 
 drivers/usb/serial/qcserial.c                            |    2 
 drivers/vhost/vhost.c                                    |    5 
 fs/dlm/lowcomms.c                                        |   38 +----
 fs/ext4/mballoc.c                                        |   20 ++
 fs/f2fs/compress.c                                       |   27 +++
 fs/f2fs/f2fs.h                                           |    2 
 fs/f2fs/super.c                                          |    4 
 fs/ntfs3/ntfs_fs.h                                       |    2 
 fs/smb/client/sess.c                                     |    2 
 include/linux/dmaengine.h                                |    3 
 include/linux/hrtimer.h                                  |    4 
 include/uapi/linux/netfilter/nf_tables.h                 |    2 
 io_uring/net.c                                           |    1 
 kernel/time/clocksource.c                                |   25 +++
 kernel/time/hrtimer.c                                    |    3 
 net/ipv4/af_inet.c                                       |    6 
 net/ipv4/ip_tunnel_core.c                                |    2 
 net/mac80211/mlme.c                                      |    3 
 net/netfilter/nft_compat.c                               |   17 +-
 net/netfilter/nft_ct.c                                   |    3 
 net/netfilter/nft_set_pipapo.c                           |  108 +++++++--------
 net/netfilter/nft_set_pipapo.h                           |   18 +-
 net/netfilter/nft_set_pipapo_avx2.c                      |   17 +-
 net/netfilter/nft_set_rbtree.c                           |    6 
 net/rxrpc/conn_event.c                                   |    8 +
 net/tipc/bearer.c                                        |    6 
 net/unix/garbage.c                                       |   11 +
 sound/soc/amd/acp-config.c                               |   15 --
 sound/usb/quirks.c                                       |   38 +++--
 tools/testing/selftests/net/cmsg_ipv6.sh                 |    4 
 tools/testing/selftests/net/pmtu.sh                      |   18 +-
 tools/testing/selftests/net/udpgro_fwd.sh                |   14 +
 tools/testing/selftests/net/udpgso_bench_rx.c            |    2 
 69 files changed, 519 insertions(+), 242 deletions(-)

Abhinav Kumar (1):
      drm/msm/dpu: check for valid hw_pp in dpu_encoder_helper_phys_cleanup

Alexander Aring (1):
      fs: dlm: don't put dlm_local_addrs on heap

Alexander Tsoy (1):
      ALSA: usb-audio: Add delay quirk for MOTU M Series 2nd revision

Antoine Tenart (1):
      tunnels: fix out of bounds access when building IPv6 PMTU error

Baokun Li (1):
      ext4: regenerate buddy after block freeing failed if under fc replay

Christophe JAILLET (2):
      dmaengine: fsl-qdma: Fix a memory leak related to the status queue DMA
      dmaengine: fsl-qdma: Fix a memory leak related to the queue command DMA

Dan Carpenter (2):
      drm/i915/gvt: Fix uninitialized variable in handle_mmio()
      fs/ntfs3: Fix an NULL dereference bug

David Howells (1):
      rxrpc: Fix response to PING RESPONSE ACKs to a dead call

Eric Dumazet (3):
      netdevsim: avoid potential loop in nsim_dev_trap_report_work()
      inet: read sk->sk_family once in inet_recv_error()
      ppp_async: limit MRU to 64K

Florian Westphal (3):
      netfilter: nft_set_pipapo: store index in scratch maps
      netfilter: nft_set_pipapo: add helper to release pcpu scratch area
      netfilter: nft_set_pipapo: remove scratch_aligned pointer

Francesco Dolcini (1):
      mtd: parsers: ofpart: add workaround for #size-cells 0

Frank Li (1):
      dmaengine: fix is_slave_direction() return false when DMA_DEV_TO_DEV

Frederic Weisbecker (1):
      hrtimer: Report offline hrtimer enqueue

Furong Xu (2):
      net: stmmac: xgmac: fix handling of DPP safety error for DMA channels
      net: stmmac: xgmac: fix a typo of register name in DPP safety handling

Greg Kroah-Hartman (2):
      Revert "ASoC: amd: Add new dmi entries for acp5x platform"
      Linux 6.1.78

Guanhua Gao (1):
      dmaengine: fsl-dpaa2-qdma: Fix the size of dma pools

Hans de Goede (1):
      Input: atkbd - skip ATKBD_CMD_SETLEDS when skipping ATKBD_CMD_GETID

Ivan Vecera (1):
      net: atlantic: Fix DMA mapping for PTP hwts ring

JackBB Wu (1):
      USB: serial: qcserial: add new usb-id for Dell Wireless DW5826e

Jai Luthra (1):
      dmaengine: ti: k3-udma: Report short packet errors

Jakub Kicinski (1):
      selftests: cmsg_ipv6: repeat the exact packet

Jens Axboe (2):
      io_uring/net: fix sr->len for IORING_OP_RECV with MSG_WAITALL and buffers
      block: treat poll queue enter similarly to timeouts

Jiri Wiesner (1):
      clocksource: Skip watchdog check for large watchdog intervals

Johannes Berg (1):
      wifi: mac80211: fix waiting for beacons logic

Julian Sikorski (1):
      ALSA: usb-audio: Add a quirk for Yamaha YIT-W12TX transmitter

Kuniyuki Iwashima (1):
      af_unix: Call kfree_skb() for dead unix_(sk)->oob_skb in GC.

Kuogee Hsieh (2):
      drm/msms/dp: fixed link clock divider bits be over written in BPC unknown case
      drm/msm/dp: return correct Colorimetry for DP_TEST_DYNAMIC_RANGE_CEA case

Leonard Dallmayr (1):
      USB: serial: cp210x: add ID for IMST iM871A-USB

Loic Prylli (1):
      hwmon: (aspeed-pwm-tacho) mutex for tach reading

Mike Marciniszyn (1):
      RDMA/irdma: Fix support for 64k pages

Ming Lei (1):
      scsi: core: Move scsi_host_busy() out of host lock if it is for per-command

Pablo Neira Ayuso (5):
      netfilter: nft_compat: narrow down revision to unsigned 8-bits
      netfilter: nft_compat: reject unused compat flag
      netfilter: nft_compat: restrict match/target protocol to u16
      netfilter: nft_ct: reject direction for ct id
      netfilter: nft_set_rbtree: skip end interval element from gc

Paolo Abeni (2):
      selftests: net: cut more slack for gro fwd tests.
      selftests: net: avoid just another constant wait

Prashanth K (2):
      usb: dwc3: host: Set XHCI_SG_TRB_CACHE_SIZE_QUIRK
      usb: host: xhci-plat: Add support for XHCI_SG_TRB_CACHE_SIZE_QUIRK

Prathu Baronia (1):
      vhost: use kzalloc() instead of kmalloc() followed by memset()

Puliang Lu (1):
      USB: serial: option: add Fibocom FM101-GL variant

Sean Young (1):
      ALSA: usb-audio: add quirk for RODE NT-USB+

Sheng Yong (1):
      f2fs: add helper to check compression level

Shigeru Yoshida (1):
      tipc: Check the bearer type before calling tipc_udp_nl_bearer_add()

Shyam Prasad N (1):
      cifs: failure to add channel on iface should bump up weight

Simon Horman (1):
      net: stmmac: xgmac: use #define for string constants

Srinivasan Shanmugam (1):
      drm/amd/display: Implement bounds check for stream encoder creation in DCN301

Takashi Iwai (1):
      ALSA: usb-audio: Sort quirk table entries

Tejun Heo (1):
      blk-iocost: Fix an UBSAN shift-out-of-bounds warning

Tony Lindgren (1):
      phy: ti: phy-omap-usb2: Fix NULL pointer dereference for SRP

Werner Sembach (1):
      Input: i8042 - fix strange behavior of touchpad on Clevo NS70PU

Yoshihiro Shimoda (1):
      phy: renesas: rcar-gen3-usb2: Fix returning wrong error code

Zhang Rui (2):
      hwmon: (coretemp) Fix out-of-bounds memory access
      hwmon: (coretemp) Fix bogus core_id to attr name mapping

Zhipeng Lu (2):
      atm: idt77252: fix a memleak in open_card_ubr0
      octeontx2-pf: Fix a memleak otx2_sq_init


