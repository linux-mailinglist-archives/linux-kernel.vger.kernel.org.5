Return-Path: <linux-kernel+bounces-69155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9004A858528
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 19:29:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4FF4B2444B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF01136643;
	Fri, 16 Feb 2024 18:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VNOCNi64"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7F8135A5A;
	Fri, 16 Feb 2024 18:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708108086; cv=none; b=AejoYYNOWEX0An8+xyZ4y8hd5kMJHaIkYrAFdvoACLOa8NRmKwUvbL6cvu+5zoobsFxM+ew8eqCpPo/V10C74Xfg3e4PCLdSdTmjr9Evz3ndrj/EoLCtEyOshBSZ4ebcdwwO4yd39O4+kQKj+k6udk6J6drEBTCtaYWRi6eTWgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708108086; c=relaxed/simple;
	bh=M/0ZJkFuxcR1v6W8ZdvCSPObn9F3J0nWItxAQGkG5XM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XzTsInorgfL1tEOe43cnzt7Kqba3+XKpkyMjMUSIlaAH85u4iMSwxrTlM4+OMV0JEtpKmvllqh8QIzNOGZUNqGnTOGVebbqPin/kNe1kVeSgiHqOXZncny7qpQHFNqj3vhTQlwsg+F4Tz7ZzjDnt9DS3QPXrT5wldnLa7LD9ols=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VNOCNi64; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E51CC433F1;
	Fri, 16 Feb 2024 18:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708108086;
	bh=M/0ZJkFuxcR1v6W8ZdvCSPObn9F3J0nWItxAQGkG5XM=;
	h=From:To:Cc:Subject:Date:From;
	b=VNOCNi64NvcumgGZA2TsWYLlJ8iu9mdWR3DDA+oPLv/7BbR9RBMB4+Iq/AqMusrcL
	 m1pYpRTRN9k5ZsANW0V5eWt34JEhxu2w8sItMe7Lz/n8o4gOCTtVN7jJSpb9tcJS52
	 YFWP4QRi6o2HYvstoCRCvW9NBYI7pb8aPxLtIens=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.7.5
Date: Fri, 16 Feb 2024 19:27:48 +0100
Message-ID: <2024021648-sprout-fanning-0ab4@gregkh>
X-Mailer: git-send-email 2.43.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.7.5 kernel.

All users of the 6.7 kernel series must upgrade.

The updated 6.7.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.7.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                    |    2 
 arch/arc/include/asm/cacheflush.h                           |    1 
 arch/arm/include/asm/cacheflush.h                           |    2 
 arch/csky/abiv1/inc/abi/cacheflush.h                        |    1 
 arch/csky/abiv2/inc/abi/cacheflush.h                        |    1 
 arch/m68k/include/asm/cacheflush_mm.h                       |    1 
 arch/mips/include/asm/cacheflush.h                          |    2 
 arch/nios2/include/asm/cacheflush.h                         |    1 
 arch/parisc/include/asm/cacheflush.h                        |    1 
 arch/riscv/include/asm/cacheflush.h                         |    3 
 arch/riscv/include/asm/hugetlb.h                            |    3 
 arch/riscv/include/asm/stacktrace.h                         |    5 
 arch/riscv/include/asm/tlb.h                                |    2 
 arch/riscv/include/asm/tlbflush.h                           |    2 
 arch/riscv/mm/hugetlbpage.c                                 |   78 ++++++-
 arch/riscv/mm/init.c                                        |    4 
 arch/riscv/mm/tlbflush.c                                    |    6 
 arch/sh/include/asm/cacheflush.h                            |    1 
 arch/sparc/include/asm/cacheflush_32.h                      |    1 
 arch/sparc/include/asm/cacheflush_64.h                      |    1 
 arch/x86/boot/header.S                                      |   14 -
 arch/x86/boot/setup.ld                                      |    6 
 arch/x86/lib/getuser.S                                      |   24 +-
 arch/x86/lib/putuser.S                                      |   20 -
 arch/xtensa/include/asm/cacheflush.h                        |    6 
 block/blk-iocost.c                                          |    7 
 drivers/atm/idt77252.c                                      |    2 
 drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c                     |   10 
 drivers/dma/fsl-qdma.c                                      |   28 --
 drivers/dma/ti/k3-udma.c                                    |   10 
 drivers/firmware/efi/libstub/efistub.h                      |    3 
 drivers/firmware/efi/libstub/kaslr.c                        |    2 
 drivers/firmware/efi/libstub/randomalloc.c                  |   12 -
 drivers/firmware/efi/libstub/x86-stub.c                     |   25 +-
 drivers/firmware/efi/libstub/x86-stub.h                     |    4 
 drivers/firmware/efi/libstub/zboot.c                        |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                  |   24 --
 drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c     |    2 
 drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c     |   63 +++--
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c                   |   33 ---
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h               |    1 
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c        |    8 
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c        |    8 
 drivers/gpu/drm/i915/gvt/handlers.c                         |    3 
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c                 |    4 
 drivers/gpu/drm/msm/dp/dp_ctrl.c                            |    5 
 drivers/gpu/drm/msm/dp/dp_link.c                            |   22 +-
 drivers/gpu/drm/msm/dp/dp_reg.h                             |    3 
 drivers/hwmon/aspeed-pwm-tacho.c                            |    7 
 drivers/hwmon/coretemp.c                                    |   40 +--
 drivers/input/keyboard/atkbd.c                              |   13 -
 drivers/input/serio/i8042-acpipnpio.h                       |    6 
 drivers/net/ethernet/aquantia/atlantic/aq_ptp.c             |    4 
 drivers/net/ethernet/aquantia/atlantic/aq_ring.c            |   13 +
 drivers/net/ethernet/aquantia/atlantic/aq_ring.h            |    1 
 drivers/net/ethernet/engleder/tsnep_main.c                  |   16 +
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c    |   14 +
 drivers/net/ethernet/stmicro/stmmac/common.h                |    1 
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h              |    3 
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c         |   58 +++++
 drivers/net/netdevsim/dev.c                                 |    8 
 drivers/net/ppp/ppp_async.c                                 |    4 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c |    6 
 drivers/net/wireless/intel/iwlwifi/fw/api/debug.h           |    2 
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c           |    6 
 drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c       |    9 
 drivers/nvme/host/core.c                                    |    7 
 drivers/pci/bus.c                                           |   49 +++-
 drivers/pci/controller/dwc/pcie-qcom.c                      |    2 
 drivers/pci/pci.c                                           |   78 ++++---
 drivers/pci/pci.h                                           |    4 
 drivers/pci/pcie/aspm.c                                     |   13 -
 drivers/phy/qualcomm/phy-qcom-qmp-usb.c                     |   30 ++
 drivers/phy/renesas/phy-rcar-gen3-usb2.c                    |    4 
 drivers/phy/ti/phy-omap-usb2.c                              |    4 
 drivers/scsi/scsi_error.c                                   |    3 
 drivers/scsi/scsi_lib.c                                     |    4 
 drivers/usb/dwc3/dwc3-pci.c                                 |    4 
 drivers/usb/dwc3/host.c                                     |    4 
 drivers/usb/host/xhci-plat.c                                |    3 
 drivers/usb/host/xhci-ring.c                                |   80 ++++++-
 drivers/usb/host/xhci.h                                     |    1 
 drivers/usb/serial/cp210x.c                                 |    1 
 drivers/usb/serial/option.c                                 |    1 
 drivers/usb/serial/qcserial.c                               |    2 
 drivers/usb/typec/tcpm/tcpm.c                               |    3 
 fs/bcachefs/clock.c                                         |    4 
 fs/bcachefs/fs-io.c                                         |    2 
 fs/bcachefs/fs-ioctl.c                                      |   42 ++-
 fs/bcachefs/journal_io.c                                    |    3 
 fs/bcachefs/move.c                                          |    2 
 fs/bcachefs/move.h                                          |    1 
 fs/bcachefs/rebalance.c                                     |   13 +
 fs/bcachefs/replicas.c                                      |   10 
 fs/bcachefs/snapshot.c                                      |    2 
 fs/bcachefs/util.c                                          |    5 
 fs/ceph/inode.c                                             |    2 
 fs/ext4/mballoc.c                                           |   20 +
 fs/namei.c                                                  |   16 +
 fs/ntfs3/ntfs_fs.h                                          |    2 
 fs/smb/client/sess.c                                        |    2 
 fs/smb/client/smb2pdu.c                                     |    2 
 include/asm-generic/cacheflush.h                            |    6 
 include/linux/ceph/messenger.h                              |    2 
 include/linux/dmaengine.h                                   |    3 
 include/linux/hrtimer.h                                     |    4 
 include/linux/namei.h                                       |    1 
 include/linux/pci.h                                         |    5 
 include/net/cfg80211.h                                      |    4 
 include/net/netfilter/nf_tables.h                           |   16 +
 include/trace/events/rxrpc.h                                |    8 
 include/uapi/linux/netfilter/nf_tables.h                    |    2 
 io_uring/io_uring.h                                         |    7 
 io_uring/net.c                                              |   50 +++-
 io_uring/poll.c                                             |   49 ++--
 io_uring/poll.h                                             |    9 
 io_uring/rw.c                                               |   10 
 kernel/time/hrtimer.c                                       |    3 
 mm/percpu.c                                                 |    8 
 net/ceph/messenger_v1.c                                     |   33 +--
 net/ceph/messenger_v2.c                                     |    4 
 net/ceph/osd_client.c                                       |    9 
 net/core/datagram.c                                         |    2 
 net/devlink/core.c                                          |   12 -
 net/ipv4/af_inet.c                                          |    6 
 net/ipv4/ip_tunnel_core.c                                   |    2 
 net/mac80211/cfg.c                                          |   14 -
 net/mac80211/mlme.c                                         |  106 +++++++--
 net/mac80211/tx.c                                           |    7 
 net/netfilter/nf_tables_api.c                               |    4 
 net/netfilter/nfnetlink_queue.c                             |   13 -
 net/netfilter/nft_compat.c                                  |   17 +
 net/netfilter/nft_ct.c                                      |    3 
 net/netfilter/nft_set_hash.c                                |    8 
 net/netfilter/nft_set_pipapo.c                              |  128 ++++++------
 net/netfilter/nft_set_pipapo.h                              |   18 +
 net/netfilter/nft_set_pipapo_avx2.c                         |   17 -
 net/netfilter/nft_set_rbtree.c                              |   17 -
 net/rxrpc/ar-internal.h                                     |   37 ++-
 net/rxrpc/call_event.c                                      |   12 -
 net/rxrpc/call_object.c                                     |    1 
 net/rxrpc/conn_event.c                                      |   10 
 net/rxrpc/input.c                                           |  115 +++++++++-
 net/rxrpc/output.c                                          |    8 
 net/rxrpc/proc.c                                            |    2 
 net/rxrpc/rxkad.c                                           |    4 
 net/tipc/bearer.c                                           |    6 
 net/unix/garbage.c                                          |   11 +
 net/wireless/scan.c                                         |   63 +++++
 sound/soc/amd/acp-config.c                                  |   15 -
 sound/usb/quirks.c                                          |   38 ++-
 tools/perf/tests/shell/script.sh                            |   73 ++++++
 tools/perf/util/evlist.c                                    |    9 
 tools/testing/selftests/core/close_range_test.c             |    1 
 tools/testing/selftests/net/big_tcp.sh                      |    4 
 tools/testing/selftests/net/cmsg_ipv6.sh                    |    4 
 tools/testing/selftests/net/pmtu.sh                         |   52 ++--
 tools/testing/selftests/net/udpgro_fwd.sh                   |   14 +
 tools/testing/selftests/net/udpgso_bench_rx.c               |    2 
 tools/testing/selftests/net/unicast_extensions.sh           |  101 ++++-----
 160 files changed, 1559 insertions(+), 735 deletions(-)

Abhinav Kumar (1):
      drm/msm/dpu: check for valid hw_pp in dpu_encoder_helper_phys_cleanup

Al Viro (2):
      new helper: user_path_locked_at()
      bch2_ioctl_subvolume_destroy(): fix locking

Alexander Tsoy (1):
      ALSA: usb-audio: Add delay quirk for MOTU M Series 2nd revision

Alexandre Ghiti (5):
      mm: Introduce flush_cache_vmap_early()
      riscv: Fix set_huge_pte_at() for NAPOT mapping
      riscv: Fix hugetlb_mask_last_page() when NAPOT is enabled
      riscv: Flush the tlb when a page directory is freed
      riscv: Fix arch_hugetlb_migration_supported() for NAPOT

Antoine Tenart (1):
      tunnels: fix out of bounds access when building IPv6 PMTU error

Ard Biesheuvel (3):
      x86/efistub: Give up if memory attribute protocol returns an error
      x86/efistub: Avoid placing the kernel below LOAD_PHYSICAL_ADDR
      x86/efistub: Use 1:1 file:memory mapping for PE/COFF .compat section

Badhri Jagan Sridharan (1):
      Revert "usb: typec: tcpm: fix cc role at port reset"

Baokun Li (1):
      ext4: regenerate buddy after block freeing failed if under fc replay

Ben Dooks (1):
      riscv: declare overflow_stack as exported from traps.c

Benjamin Berg (2):
      wifi: iwlwifi: mvm: skip adding debugfs symlink for reconfig
      wifi: cfg80211: consume both probe response and beacon IEs

Christoph Hellwig (1):
      bcachefs: fix incorrect usage of REQ_OP_FLUSH

Christophe JAILLET (2):
      dmaengine: fsl-qdma: Fix a memory leak related to the status queue DMA
      dmaengine: fsl-qdma: Fix a memory leak related to the queue command DMA

Dan Carpenter (2):
      drm/i915/gvt: Fix uninitialized variable in handle_mmio()
      fs/ntfs3: Fix an NULL dereference bug

Daniel Hill (1):
      bcachefs: rebalance should wakeup on shutdown if disabled

David Howells (4):
      rxrpc: Fix generation of serial numbers to skip zero
      rxrpc: Fix delayed ACKs to not set the reference serial number
      rxrpc: Fix response to PING RESPONSE ACKs to a dead call
      rxrpc: Fix counting of new acks and nacks

Emmanuel Grumbach (1):
      wifi: iwlwifi: mvm: fix a battery life regression

Eric Dumazet (3):
      netdevsim: avoid potential loop in nsim_dev_trap_report_work()
      inet: read sk->sk_family once in inet_recv_error()
      ppp_async: limit MRU to 64K

Florian Westphal (4):
      netfilter: nfnetlink_queue: un-break NF_REPEAT
      netfilter: nft_set_pipapo: store index in scratch maps
      netfilter: nft_set_pipapo: add helper to release pcpu scratch area
      netfilter: nft_set_pipapo: remove scratch_aligned pointer

Frank Li (1):
      dmaengine: fix is_slave_direction() return false when DMA_DEV_TO_DEV

Frederic Weisbecker (1):
      hrtimer: Report offline hrtimer enqueue

Furong Xu (2):
      net: stmmac: xgmac: fix handling of DPP safety error for DMA channels
      net: stmmac: xgmac: fix a typo of register name in DPP safety handling

Gerhard Engleder (1):
      tsnep: Fix mapping for zero copy XDP_TX action

Greg Kroah-Hartman (2):
      Revert "ASoC: amd: Add new dmi entries for acp5x platform"
      Linux 6.7.5

Guanhua Gao (1):
      dmaengine: fsl-dpaa2-qdma: Fix the size of dma pools

Guoyu Ou (1):
      bcachefs: unlock parent dir if entry is not found in subvolume deletion

Hangbin Liu (2):
      selftests/net: convert unicast_extensions.sh to run it in unique namespace
      selftests/net: convert pmtu.sh to run it in unique namespace

Hans de Goede (1):
      Input: atkbd - skip ATKBD_CMD_SETLEDS when skipping ATKBD_CMD_GETID

Heikki Krogerus (1):
      usb: dwc3: pci: add support for the Intel Arrow Lake-H

Ian Rogers (1):
      perf tests: Add perf script test

Ivan Vecera (1):
      net: atlantic: Fix DMA mapping for PTP hwts ring

JackBB Wu (1):
      USB: serial: qcserial: add new usb-id for Dell Wireless DW5826e

Jai Luthra (1):
      dmaengine: ti: k3-udma: Report short packet errors

Jakub Kicinski (1):
      selftests: cmsg_ipv6: repeat the exact packet

James Clark (1):
      perf evlist: Fix evlist__new_default() for > 1 core PMU

Jens Axboe (6):
      io_uring/net: fix sr->len for IORING_OP_RECV with MSG_WAITALL and buffers
      io_uring/poll: move poll execution helpers higher up
      io_uring/net: un-indent mshot retry path in io_recv_finish()
      io_uring/rw: ensure poll based multishot read retries appropriately
      io_uring/poll: add requeue return code from poll multishot handling
      io_uring/net: limit inline multishot retries

Jiri Pirko (1):
      devlink: avoid potential loop in devlink_rel_nested_in_notify_work()

Johan Hovold (1):
      PCI/ASPM: Fix deadlock when enabling ASPM

Johannes Berg (5):
      wifi: cfg80211: detect stuck ECSA element in probe resp
      wifi: mac80211: improve CSA/ECSA connection refusal
      wifi: mac80211: fix RCU use in TDLS fast-xmit
      wifi: mac80211: fix unsolicited broadcast probe config
      wifi: mac80211: fix waiting for beacons logic

Julian Sikorski (1):
      ALSA: usb-audio: Add a quirk for Yamaha YIT-W12TX transmitter

Kees Cook (1):
      wifi: brcmfmac: Adjust n_channels usage for __counted_by

Kent Overstreet (4):
      bcachefs: Don't pass memcmp() as a pointer
      bcachefs: Add missing bch2_moving_ctxt_flush_all()
      bcachefs: bch2_kthread_io_clock_wait() no longer sleeps until full amount
      bcachefs: time_stats: Check for last_event == 0 when updating freq stats

Kuniyuki Iwashima (1):
      af_unix: Call kfree_skb() for dead unix_(sk)->oob_skb in GC.

Kuogee Hsieh (2):
      drm/msms/dp: fixed link clock divider bits be over written in BPC unknown case
      drm/msm/dp: return correct Colorimetry for DP_TEST_DYNAMIC_RANGE_CEA case

Leonard Dallmayr (1):
      USB: serial: cp210x: add ID for IMST iM871A-USB

Loic Prylli (1):
      hwmon: (aspeed-pwm-tacho) mutex for tach reading

Mantas Pucka (2):
      phy: qcom-qmp-usb: fix register offsets for ipq8074/ipq6018
      phy: qcom-qmp-usb: fix serdes init sequence for IPQ6018

Mario Limonciello (1):
      Revert "drm/amd/pm: fix the high voltage and temperature issue"

Mathias Nyman (1):
      xhci: process isoc TD properly when there was a transaction error mid TD.

Maurizio Lombardi (1):
      nvme-host: fix the updating of the firmware version

Michael Lass (1):
      net: Fix from address in memcpy_to_iter_csum()

Michal Pecio (1):
      xhci: handle isoc Babble and Buffer Overrun events properly

Ming Lei (1):
      scsi: core: Move scsi_host_busy() out of host lock if it is for per-command

Miri Korenblit (1):
      wifi: iwlwifi: exit eSR only after the FW does

Muhammad Usama Anjum (1):
      selftests: core: include linux/close_range.h for CLOSE_RANGE_* macros

Pablo Neira Ayuso (7):
      netfilter: nft_compat: narrow down revision to unsigned 8-bits
      netfilter: nft_compat: reject unused compat flag
      netfilter: nft_compat: restrict match/target protocol to u16
      netfilter: nft_set_pipapo: remove static in nft_pipapo_get()
      netfilter: nft_ct: reject direction for ct id
      netfilter: nf_tables: use timestamp to check for set element timeout
      netfilter: nft_set_rbtree: skip end interval element from gc

Paolo Abeni (4):
      selftests: net: cut more slack for gro fwd tests.
      selftests: net: fix tcp listener handling in pmtu.sh
      selftests: net: avoid just another constant wait
      selftests: net: let big_tcp test cope with slow env

Prashanth K (2):
      usb: dwc3: host: Set XHCI_SG_TRB_CACHE_SIZE_QUIRK
      usb: host: xhci-plat: Add support for XHCI_SG_TRB_CACHE_SIZE_QUIRK

Puliang Lu (1):
      USB: serial: option: add Fibocom FM101-GL variant

Qiuxu Zhuo (1):
      x86/lib: Revert to _ASM_EXTABLE_UA() for {get,put}_user() fixups

Sean Young (1):
      ALSA: usb-audio: add quirk for RODE NT-USB+

Shigeru Yoshida (1):
      tipc: Check the bearer type before calling tipc_udp_nl_bearer_add()

Shyam Prasad N (2):
      cifs: avoid redundant calls to disable multichannel
      cifs: failure to add channel on iface should bump up weight

Simon Horman (1):
      net: stmmac: xgmac: use #define for string constants

Srinivasan Shanmugam (3):
      drm/amd/display: Fix 'panel_cntl' could be null in 'dcn21_set_backlight_level()'
      drm/amd/display: Add NULL test for 'timing generator' in 'dcn21_set_pipe()'
      drm/amd/display: Implement bounds check for stream encoder creation in DCN301

Su Yue (2):
      bcachefs: kvfree bch_fs::snapshots in bch2_fs_snapshots_exit
      bcachefs: grab s_umount only if snapshotting

Takashi Iwai (1):
      ALSA: usb-audio: Sort quirk table entries

Tejun Heo (1):
      blk-iocost: Fix an UBSAN shift-out-of-bounds warning

Thomas Richter (1):
      perf test: Fix 'perf script' tests on s390

Tony Lindgren (1):
      phy: ti: phy-omap-usb2: Fix NULL pointer dereference for SRP

Vincent Chen (1):
      riscv: mm: execute local TLB flush after populating vmemmap

Werner Sembach (1):
      Input: i8042 - fix strange behavior of touchpad on Clevo NS70PU

Xiubo Li (3):
      libceph: rename read_sparse_msg_*() to read_partial_sparse_msg_*()
      libceph: just wait for more data to be available on the socket
      ceph: always set initial i_blkbits to CEPH_FSCRYPT_BLOCK_SHIFT

Yoshihiro Shimoda (1):
      phy: renesas: rcar-gen3-usb2: Fix returning wrong error code

Yujie Liu (1):
      selftests/net: change shebang to bash to support "source"

Zhang Rui (2):
      hwmon: (coretemp) Fix out-of-bounds memory access
      hwmon: (coretemp) Fix bogus core_id to attr name mapping

Zhipeng Lu (2):
      atm: idt77252: fix a memleak in open_card_ubr0
      octeontx2-pf: Fix a memleak otx2_sq_init


