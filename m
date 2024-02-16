Return-Path: <linux-kernel+bounces-69152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C14858522
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 19:28:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDD9A282A2F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 192301350F2;
	Fri, 16 Feb 2024 18:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="a+TuFVum"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F35F1350E6;
	Fri, 16 Feb 2024 18:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708108071; cv=none; b=t3nGz/Vv8r9JpLMi+w8yL0/8uI8KsYyF+1DS1X87V+D8+RKUC0+G7pmLiz3WGb5/kEbUvYxoA3h9hmrJDWzZ1CkCGLEFodfZ8j0QHGa4dfAeZfy3SBl4/R3eWk+gRoxKrjs6Qlc9pW5x2/wyfOjONA9lfoTpEB4aIR8jJAMVLUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708108071; c=relaxed/simple;
	bh=HvH1EUKZ861Sh44bj5UKh2Xj3ezGkzR6Ah4W5JYddw0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gbl6iaH1BpZdemcPQUp0L1cs9qGDjH6AE5oKJZcm9mShpswbt2vFmgs4buDlNhD2gnOlt9Cv4pUVZy2Pu/6cmoCUBRLlCjI2w1as+gIJMFAE6vtjY8BeO1SpQDPmH7TMI3ylDvcOTViiJygPj/dNn6oK1ALQQ0h5UhwEgjg+/HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=a+TuFVum; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8423C433F1;
	Fri, 16 Feb 2024 18:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708108071;
	bh=HvH1EUKZ861Sh44bj5UKh2Xj3ezGkzR6Ah4W5JYddw0=;
	h=From:To:Cc:Subject:Date:From;
	b=a+TuFVum/gpbMugUXME4dijjPLf7rd0ph9+0CNX/9vJVLCNnprCvc4NnXpZifl/XJ
	 vnXkpuIYCiRE7F92VvIPbpR2Fnb7FhYA8UNv/prZzMQV0iA2u/hwYkFm6yEqV770Zm
	 +2B6Nnc8jcR7L9S1UgAcFJL/uImmGcJ2091WufgI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.17
Date: Fri, 16 Feb 2024 19:27:42 +0100
Message-ID: <2024021642-opposite-senorita-0b31@gregkh>
X-Mailer: git-send-email 2.43.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.6.17 kernel.

All users of the 6.6 kernel series must upgrade.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/process/changes.rst                           |    2 
 MAINTAINERS                                                 |    1 
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
 arch/riscv/include/asm/sbi.h                                |    3 
 arch/riscv/include/asm/stacktrace.h                         |    5 
 arch/riscv/include/asm/tlb.h                                |    8 
 arch/riscv/include/asm/tlbflush.h                           |   17 -
 arch/riscv/kernel/sbi.c                                     |   32 -
 arch/riscv/mm/hugetlbpage.c                                 |   78 ++++
 arch/riscv/mm/init.c                                        |    4 
 arch/riscv/mm/tlbflush.c                                    |  158 +++++----
 arch/sh/include/asm/cacheflush.h                            |    1 
 arch/sparc/include/asm/cacheflush_32.h                      |    1 
 arch/sparc/include/asm/cacheflush_64.h                      |    1 
 arch/x86/lib/getuser.S                                      |   24 -
 arch/x86/lib/putuser.S                                      |   20 -
 arch/xtensa/include/asm/cacheflush.h                        |    6 
 block/blk-iocost.c                                          |    7 
 drivers/atm/idt77252.c                                      |    2 
 drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c                     |   10 
 drivers/dma/fsl-qdma.c                                      |   27 -
 drivers/dma/ti/k3-udma.c                                    |   10 
 drivers/firmware/efi/libstub/efistub.h                      |    3 
 drivers/firmware/efi/libstub/kaslr.c                        |    2 
 drivers/firmware/efi/libstub/randomalloc.c                  |   12 
 drivers/firmware/efi/libstub/x86-stub.c                     |   25 -
 drivers/firmware/efi/libstub/x86-stub.h                     |    4 
 drivers/firmware/efi/libstub/zboot.c                        |    2 
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hwseq.c          |   63 ++-
 drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c     |    2 
 drivers/gpu/drm/i915/gvt/handlers.c                         |    3 
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c                 |    4 
 drivers/gpu/drm/msm/dp/dp_ctrl.c                            |    5 
 drivers/gpu/drm/msm/dp/dp_link.c                            |   22 -
 drivers/gpu/drm/msm/dp/dp_reg.h                             |    3 
 drivers/hwmon/aspeed-pwm-tacho.c                            |    7 
 drivers/hwmon/coretemp.c                                    |   40 +-
 drivers/input/keyboard/atkbd.c                              |   13 
 drivers/input/serio/i8042-acpipnpio.h                       |    6 
 drivers/media/pci/solo6x10/solo6x10-offsets.h               |   10 
 drivers/net/ethernet/aquantia/atlantic/aq_ptp.c             |    4 
 drivers/net/ethernet/aquantia/atlantic/aq_ring.c            |   13 
 drivers/net/ethernet/aquantia/atlantic/aq_ring.h            |    1 
 drivers/net/ethernet/engleder/tsnep_main.c                  |   16 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c    |   14 
 drivers/net/ethernet/stmicro/stmmac/common.h                |    1 
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h              |    3 
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c         |   58 +++
 drivers/net/netdevsim/dev.c                                 |    8 
 drivers/net/ppp/ppp_async.c                                 |    4 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c |    6 
 drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c       |    6 
 drivers/phy/renesas/phy-rcar-gen3-usb2.c                    |    4 
 drivers/phy/ti/phy-omap-usb2.c                              |    4 
 drivers/scsi/scsi_error.c                                   |    3 
 drivers/scsi/scsi_lib.c                                     |    4 
 drivers/usb/dwc3/dwc3-pci.c                                 |    4 
 drivers/usb/dwc3/host.c                                     |    4 
 drivers/usb/host/xhci-plat.c                                |    3 
 drivers/usb/host/xhci-ring.c                                |   80 +++-
 drivers/usb/host/xhci.h                                     |    1 
 drivers/usb/serial/cp210x.c                                 |    1 
 drivers/usb/serial/option.c                                 |    1 
 drivers/usb/serial/qcserial.c                               |    2 
 drivers/usb/typec/tcpm/tcpm.c                               |    3 
 fs/ext4/mballoc.c                                           |   20 +
 fs/ntfs3/ntfs_fs.h                                          |    2 
 fs/smb/client/sess.c                                        |    2 
 fs/smb/client/smb2pdu.c                                     |    2 
 fs/xfs/Kconfig                                              |    2 
 fs/xfs/libxfs/xfs_alloc.c                                   |   27 +
 fs/xfs/libxfs/xfs_bmap.c                                    |   21 -
 fs/xfs/libxfs/xfs_defer.c                                   |   28 +
 fs/xfs/libxfs/xfs_defer.h                                   |    2 
 fs/xfs/libxfs/xfs_inode_buf.c                               |    3 
 fs/xfs/libxfs/xfs_rtbitmap.c                                |   33 +
 fs/xfs/libxfs/xfs_sb.h                                      |    2 
 fs/xfs/xfs_bmap_util.c                                      |   24 -
 fs/xfs/xfs_dquot.c                                          |    5 
 fs/xfs/xfs_dquot_item_recover.c                             |   21 +
 fs/xfs/xfs_file.c                                           |   63 +++
 fs/xfs/xfs_inode.c                                          |   24 +
 fs/xfs/xfs_inode.h                                          |   17 +
 fs/xfs/xfs_inode_item_recover.c                             |   14 
 fs/xfs/xfs_ioctl.c                                          |   30 +
 fs/xfs/xfs_iops.c                                           |    7 
 fs/xfs/xfs_log.c                                            |   23 -
 fs/xfs/xfs_log_recover.c                                    |    2 
 fs/xfs/xfs_reflink.c                                        |    5 
 fs/xfs/xfs_rtalloc.c                                        |   33 +
 fs/xfs/xfs_rtalloc.h                                        |   27 -
 include/asm-generic/cacheflush.h                            |    6 
 include/linux/ceph/messenger.h                              |    2 
 include/linux/dmaengine.h                                   |    3 
 include/linux/hrtimer.h                                     |    4 
 include/trace/events/rxrpc.h                                |    8 
 include/uapi/linux/netfilter/nf_tables.h                    |    2 
 io_uring/io_uring.h                                         |    7 
 io_uring/net.c                                              |   50 ++-
 io_uring/poll.c                                             |   39 +-
 kernel/time/hrtimer.c                                       |    3 
 mm/percpu.c                                                 |    8 
 net/ceph/messenger_v1.c                                     |   33 +
 net/ceph/messenger_v2.c                                     |    4 
 net/ceph/osd_client.c                                       |    9 
 net/ipv4/af_inet.c                                          |    6 
 net/ipv4/ip_tunnel_core.c                                   |    2 
 net/mac80211/mlme.c                                         |    3 
 net/mac80211/tx.c                                           |    7 
 net/netfilter/nft_compat.c                                  |   17 -
 net/netfilter/nft_ct.c                                      |    3 
 net/netfilter/nft_set_pipapo.c                              |  108 +++---
 net/netfilter/nft_set_pipapo.h                              |   18 -
 net/netfilter/nft_set_pipapo_avx2.c                         |   17 -
 net/netfilter/nft_set_rbtree.c                              |    6 
 net/rxrpc/ar-internal.h                                     |   37 +-
 net/rxrpc/call_event.c                                      |   12 
 net/rxrpc/call_object.c                                     |    1 
 net/rxrpc/conn_event.c                                      |   10 
 net/rxrpc/input.c                                           |  115 +++++-
 net/rxrpc/output.c                                          |    8 
 net/rxrpc/proc.c                                            |    2 
 net/rxrpc/rxkad.c                                           |    4 
 net/tipc/bearer.c                                           |    6 
 net/unix/garbage.c                                          |   11 
 rust/alloc/alloc.rs                                         |   21 -
 rust/alloc/boxed.rs                                         |   56 ++-
 rust/alloc/lib.rs                                           |   13 
 rust/alloc/raw_vec.rs                                       |   30 +
 rust/alloc/vec/drain_filter.rs                              |  199 ------------
 rust/alloc/vec/extract_if.rs                                |  115 ++++++
 rust/alloc/vec/mod.rs                                       |  110 +++---
 rust/alloc/vec/spec_extend.rs                               |    8 
 rust/compiler_builtins.rs                                   |    1 
 rust/kernel/print.rs                                        |    1 
 rust/kernel/sync/arc.rs                                     |    2 
 rust/kernel/task.rs                                         |    2 
 scripts/min-tool-version.sh                                 |    2 
 sound/soc/amd/acp-config.c                                  |   15 
 sound/usb/quirks.c                                          |   38 +-
 tools/perf/util/evlist.c                                    |    9 
 tools/testing/selftests/net/big_tcp.sh                      |    4 
 tools/testing/selftests/net/cmsg_ipv6.sh                    |    4 
 tools/testing/selftests/net/pmtu.sh                         |   52 +--
 tools/testing/selftests/net/udpgro_fwd.sh                   |   14 
 tools/testing/selftests/net/udpgso_bench_rx.c               |    2 
 tools/testing/selftests/net/unicast_extensions.sh           |  101 ++----
 157 files changed, 1701 insertions(+), 1017 deletions(-)

Abhinav Kumar (1):
      drm/msm/dpu: check for valid hw_pp in dpu_encoder_helper_phys_cleanup

Alexander Tsoy (1):
      ALSA: usb-audio: Add delay quirk for MOTU M Series 2nd revision

Alexandre Ghiti (8):
      riscv: Improve tlb_flush()
      riscv: Make __flush_tlb_range() loop over pte instead of flushing the whole tlb
      riscv: Improve flush_tlb_kernel_range()
      mm: Introduce flush_cache_vmap_early()
      riscv: Fix set_huge_pte_at() for NAPOT mapping
      riscv: Fix hugetlb_mask_last_page() when NAPOT is enabled
      riscv: Flush the tlb when a page directory is freed
      riscv: Fix arch_hugetlb_migration_supported() for NAPOT

Anthony Iliopoulos (1):
      xfs: fix again select in kconfig XFS_ONLINE_SCRUB_STATS

Antoine Tenart (1):
      tunnels: fix out of bounds access when building IPv6 PMTU error

Ard Biesheuvel (2):
      x86/efistub: Give up if memory attribute protocol returns an error
      x86/efistub: Avoid placing the kernel below LOAD_PHYSICAL_ADDR

Aurelien Jarno (1):
      media: solo6x10: replace max(a, min(b, c)) by clamp(b, a, c)

Badhri Jagan Sridharan (1):
      Revert "usb: typec: tcpm: fix cc role at port reset"

Baokun Li (1):
      ext4: regenerate buddy after block freeing failed if under fc replay

Ben Dooks (1):
      riscv: declare overflow_stack as exported from traps.c

Catherine Hoang (2):
      MAINTAINERS: add Catherine as xfs maintainer for 6.6.y
      xfs: allow read IO and FICLONE to run concurrently

Cheng Lin (1):
      xfs: introduce protection for drop nlink

Christoph Hellwig (4):
      xfs: handle nimaps=0 from xfs_bmapi_write in xfs_alloc_file_space
      xfs: only remap the written blocks in xfs_reflink_end_cow_extent
      xfs: clean up FS_XFLAG_REALTIME handling in xfs_ioctl_setattr_xflags
      xfs: respect the stable writes flag on the RT device

Christophe JAILLET (2):
      dmaengine: fsl-qdma: Fix a memory leak related to the status queue DMA
      dmaengine: fsl-qdma: Fix a memory leak related to the queue command DMA

Dan Carpenter (2):
      drm/i915/gvt: Fix uninitialized variable in handle_mmio()
      fs/ntfs3: Fix an NULL dereference bug

Darrick J. Wong (8):
      xfs: bump max fsgeom struct version
      xfs: hoist freeing of rt data fork extent mappings
      xfs: prevent rt growfs when quota is enabled
      xfs: rt stubs should return negative errnos when rt disabled
      xfs: fix units conversion error in xfs_bmap_del_extent_delay
      xfs: make sure maxlen is still congruent with prod when rounding down
      xfs: clean up dqblk extraction
      xfs: dquot recovery does not validate the recovered dquot

Dave Chinner (1):
      xfs: inode recovery does not validate the recovered inode

David Howells (4):
      rxrpc: Fix generation of serial numbers to skip zero
      rxrpc: Fix delayed ACKs to not set the reference serial number
      rxrpc: Fix response to PING RESPONSE ACKs to a dead call
      rxrpc: Fix counting of new acks and nacks

Eric Dumazet (3):
      netdevsim: avoid potential loop in nsim_dev_trap_report_work()
      inet: read sk->sk_family once in inet_recv_error()
      ppp_async: limit MRU to 64K

Florian Westphal (3):
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
      Linux 6.6.17

Guanhua Gao (1):
      dmaengine: fsl-dpaa2-qdma: Fix the size of dma pools

Hangbin Liu (2):
      selftests/net: convert unicast_extensions.sh to run it in unique namespace
      selftests/net: convert pmtu.sh to run it in unique namespace

Hans de Goede (1):
      Input: atkbd - skip ATKBD_CMD_SETLEDS when skipping ATKBD_CMD_GETID

Heikki Krogerus (1):
      usb: dwc3: pci: add support for the Intel Arrow Lake-H

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

Jens Axboe (5):
      io_uring/net: fix sr->len for IORING_OP_RECV with MSG_WAITALL and buffers
      io_uring/poll: move poll execution helpers higher up
      io_uring/net: un-indent mshot retry path in io_recv_finish()
      io_uring/poll: add requeue return code from poll multishot handling
      io_uring/net: limit inline multishot retries

Johannes Berg (2):
      wifi: mac80211: fix RCU use in TDLS fast-xmit
      wifi: mac80211: fix waiting for beacons logic

Julian Sikorski (1):
      ALSA: usb-audio: Add a quirk for Yamaha YIT-W12TX transmitter

Kees Cook (1):
      wifi: brcmfmac: Adjust n_channels usage for __counted_by

Kuniyuki Iwashima (1):
      af_unix: Call kfree_skb() for dead unix_(sk)->oob_skb in GC.

Kuogee Hsieh (2):
      drm/msms/dp: fixed link clock divider bits be over written in BPC unknown case
      drm/msm/dp: return correct Colorimetry for DP_TEST_DYNAMIC_RANGE_CEA case

Leah Rumancik (1):
      xfs: up(ic_sema) if flushing data device fails

Leonard Dallmayr (1):
      USB: serial: cp210x: add ID for IMST iM871A-USB

Loic Prylli (1):
      hwmon: (aspeed-pwm-tacho) mutex for tach reading

Long Li (2):
      xfs: factor out xfs_defer_pending_abort
      xfs: abort intent items when recovery intents fail

Mathias Nyman (1):
      xhci: process isoc TD properly when there was a transaction error mid TD.

Michal Pecio (1):
      xhci: handle isoc Babble and Buffer Overrun events properly

Miguel Ojeda (5):
      rust: arc: add explicit `drop()` around `Box::from_raw()`
      rust: upgrade to Rust 1.72.1
      rust: task: remove redundant explicit link
      rust: print: use explicit link in documentation
      rust: upgrade to Rust 1.73.0

Ming Lei (1):
      scsi: core: Move scsi_host_busy() out of host lock if it is for per-command

Miri Korenblit (1):
      wifi: iwlwifi: exit eSR only after the FW does

Omar Sandoval (1):
      xfs: fix internal error from AGFL exhaustion

Pablo Neira Ayuso (5):
      netfilter: nft_compat: narrow down revision to unsigned 8-bits
      netfilter: nft_compat: reject unused compat flag
      netfilter: nft_compat: restrict match/target protocol to u16
      netfilter: nft_ct: reject direction for ct id
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

Takashi Iwai (1):
      ALSA: usb-audio: Sort quirk table entries

Tejun Heo (1):
      blk-iocost: Fix an UBSAN shift-out-of-bounds warning

Tony Lindgren (1):
      phy: ti: phy-omap-usb2: Fix NULL pointer dereference for SRP

Vincent Chen (1):
      riscv: mm: execute local TLB flush after populating vmemmap

Werner Sembach (1):
      Input: i8042 - fix strange behavior of touchpad on Clevo NS70PU

Xiubo Li (2):
      libceph: rename read_sparse_msg_*() to read_partial_sparse_msg_*()
      libceph: just wait for more data to be available on the socket

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


