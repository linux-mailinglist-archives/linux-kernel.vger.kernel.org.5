Return-Path: <linux-kernel+bounces-7260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71CF381A3F8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 17:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EDEC2881EA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 16:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E00B44B154;
	Wed, 20 Dec 2023 16:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pBj3SIzK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378234B145;
	Wed, 20 Dec 2023 16:08:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C7BCC433C7;
	Wed, 20 Dec 2023 16:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703088523;
	bh=scdrN4IyqAfaK2gUdrjfChqcBC7W0lsQH3EqbX5IuVY=;
	h=From:To:Cc:Subject:Date:From;
	b=pBj3SIzKkiTmK+cmtswcxB5GhMWgKpC0rs7NMGQLViu35g4zUZ1zMVuTD/U2Xaxg3
	 +U9hdwmoiXrHJoSurs8jYRHx+F2btLjAb43RKGSZLtVN6bpmkRFFd/CiuaT7NeKrR+
	 25hSRZC2nr/I65YccV+Fy2T4YTubG8kNadzJ2mr4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.69
Date: Wed, 20 Dec 2023 17:08:31 +0100
Message-ID: <2023122032-frown-shading-0ec1@gregkh>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.1.69 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                   |    2 
 arch/arm64/Makefile                                        |    2 
 arch/arm64/include/asm/pgtable.h                           |    6 
 arch/loongarch/Makefile                                    |    2 
 arch/loongarch/kernel/time.c                               |   23 -
 arch/powerpc/kernel/trace/ftrace_mprofile.S                |    4 
 arch/x86/events/intel/uncore_discovery.c                   |   18 +
 arch/x86/hyperv/hv_init.c                                  |   25 +
 block/blk-cgroup.c                                         |   13 
 block/blk-throttle.c                                       |    2 
 drivers/atm/solos-pci.c                                    |    8 
 drivers/block/nbd.c                                        |   76 +++--
 drivers/dma/stm32-dma.c                                    |    8 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c                  |    3 
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c                     |   28 ++
 drivers/gpu/drm/amd/display/modules/power/power_helpers.c  |    2 
 drivers/gpu/drm/i915/display/intel_fb.c                    |   16 +
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c                    |    5 
 drivers/hid/hid-asus.c                                     |   27 +
 drivers/hid/hid-glorious.c                                 |   16 +
 drivers/hid/hid-ids.h                                      |   11 
 drivers/hid/hid-lenovo.c                                   |    3 
 drivers/hid/hid-multitouch.c                               |    5 
 drivers/hid/hid-quirks.c                                   |    1 
 drivers/md/bcache/bcache.h                                 |    1 
 drivers/md/bcache/btree.c                                  |    7 
 drivers/md/bcache/super.c                                  |    4 
 drivers/md/bcache/writeback.c                              |    2 
 drivers/net/ethernet/amazon/ena/ena_eth_com.c              |    3 
 drivers/net/ethernet/amazon/ena/ena_netdev.c               |   30 +-
 drivers/net/ethernet/aquantia/atlantic/aq_ring.c           |    5 
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c            |    3 
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                  |   67 ++++
 drivers/net/ethernet/broadcom/bnxt/bnxt.h                  |   25 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c          |   11 
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c          |   19 -
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c              |    5 
 drivers/net/ethernet/emulex/benet/be_main.c                |    2 
 drivers/net/ethernet/freescale/dpaa2/dpaa2-switch-flower.c |    7 
 drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c        |   11 
 drivers/net/ethernet/freescale/fec_main.c                  |   27 -
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c            |    2 
 drivers/net/ethernet/intel/i40e/i40e_txrx.c                |    2 
 drivers/net/ethernet/intel/iavf/iavf.h                     |    1 
 drivers/net/ethernet/intel/iavf/iavf_ethtool.c             |   27 +
 drivers/net/ethernet/intel/iavf/iavf_fdir.h                |   15 +
 drivers/net/ethernet/intel/iavf/iavf_main.c                |  107 +++++++
 drivers/net/ethernet/intel/iavf/iavf_virtchnl.c            |   71 ++++-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c              |    2 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c    |    5 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c        |   55 +++-
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c       |   25 +
 drivers/net/ethernet/mellanox/mlx5/core/en.h               |    1 
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c          |   27 +
 drivers/net/ethernet/qlogic/netxen/netxen_nic_main.c       |    2 
 drivers/net/ethernet/qlogic/qed/qed_cxt.c                  |    1 
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.c             |    4 
 drivers/net/ethernet/qualcomm/qca_debug.c                  |   17 -
 drivers/net/ethernet/qualcomm/qca_spi.c                    |   20 +
 drivers/net/ethernet/sfc/tx_tso.c                          |    2 
 drivers/net/ethernet/stmicro/stmmac/Kconfig                |    2 
 drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c       |   14 -
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c          |    7 
 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c          |    6 
 drivers/net/team/team.c                                    |    4 
 drivers/net/usb/aqc111.c                                   |    8 
 drivers/net/usb/qmi_wwan.c                                 |    1 
 drivers/net/usb/r8152.c                                    |  177 +++++++------
 drivers/nvme/host/auth.c                                   |    2 
 drivers/nvme/host/core.c                                   |   19 -
 drivers/pci/controller/pci-loongson.c                      |   46 +++
 drivers/pci/hotplug/acpiphp_glue.c                         |    9 
 drivers/platform/x86/intel/telemetry/core.c                |    4 
 drivers/soundwire/stream.c                                 |    7 
 drivers/staging/gdm724x/gdm_lte.c                          |    4 
 fs/afs/rxrpc.c                                             |    2 
 fs/btrfs/extent_io.c                                       |    3 
 fs/btrfs/ioctl.c                                           |    9 
 fs/btrfs/ordered-data.c                                    |    4 
 fs/ext4/file.c                                             |   14 -
 fs/ext4/mballoc.c                                          |    4 
 fs/fuse/dax.c                                              |    1 
 fs/smb/client/smb2misc.c                                   |   26 -
 fs/smb/client/smb2ops.c                                    |   40 +-
 fs/smb/common/smb2pdu.h                                    |    2 
 fs/smb/server/smb2pdu.c                                    |    1 
 include/asm-generic/qspinlock.h                            |    2 
 include/linux/cred.h                                       |    8 
 include/linux/if_vlan.h                                    |   12 
 include/linux/mm_inline.h                                  |   23 +
 include/linux/usb/r8152.h                                  |    2 
 include/net/addrconf.h                                     |   12 
 include/net/if_inet6.h                                     |    4 
 kernel/cred.c                                              |   64 ++--
 kernel/events/core.c                                       |   10 
 kernel/trace/ring_buffer.c                                 |   58 +---
 kernel/trace/trace.c                                       |    4 
 mm/shmem.c                                                 |   19 +
 mm/vmscan.c                                                |    2 
 mm/workingset.c                                            |    6 
 net/appletalk/ddp.c                                        |    9 
 net/atm/ioctl.c                                            |    7 
 net/batman-adv/soft-interface.c                            |    2 
 net/ipv4/tcp_output.c                                      |    6 
 net/ipv6/addrconf.c                                        |    6 
 net/rose/af_rose.c                                         |    4 
 net/tls/tls_sw.c                                           |    2 
 net/vmw_vsock/virtio_transport_common.c                    |    2 
 scripts/sign-file.c                                        |   12 
 sound/pci/hda/patch_hdmi.c                                 |    3 
 sound/pci/hda/patch_realtek.c                              |    1 
 tools/testing/selftests/bpf/progs/bpf_loop_bench.c         |   13 
 112 files changed, 1119 insertions(+), 511 deletions(-)

Alex Deucher (1):
      drm/amdgpu/sdma5.2: add begin/end_use ring callbacks

Amelie Delaunay (1):
      dmaengine: stm32-dma: avoid bitfield overflow assertion

Andrew Halaney (1):
      net: stmmac: Handle disabled MDIO busses from devicetree

Andy Shevchenko (1):
      platform/x86: intel_telemetry: Fix kernel doc descriptions

Antonio Napolitano (1):
      r8152: add vendor/device ID pair for D-Link DUB-E250

Aoba K (1):
      HID: multitouch: Add quirk for HONOR GLO-GXXX touchpad

Baokun Li (1):
      ext4: prevent the normalized size from exceeding EXT_MAX_BLOCKS

Bibo Mao (1):
      LoongArch: Implement constant timer shutdown interface

Bjorn Helgaas (1):
      Revert "PCI: acpiphp: Reassign resources on bridge if necessary"

Bjørn Mork (1):
      r8152: add USB device driver for config selection

Boris Burkov (2):
      btrfs: free qgroup reserve when ORDERED_IOERR is set
      btrfs: don't clear qgroup reserved bit in release_folio

Brett Raye (1):
      HID: glorious: fix Glorious Model I HID report

Chengfeng Ye (2):
      atm: solos-pci: Fix potential deadlock on &cli_queue_lock
      atm: solos-pci: Fix potential deadlock on &tx_queue_lock

Christian König (1):
      drm/amdgpu: fix tear down order in amdgpu_vm_pt_free

Colin Ian King (1):
      bcache: remove redundant assignment to variable cur_idx

Coly Li (3):
      bcache: avoid oversize memory allocation by small stripe_size
      bcache: add code comments for bch_btree_node_get() and __bch_btree_node_alloc()
      bcache: avoid NULL checking to c->root in run_cache_set()

David Arinzon (3):
      net: ena: Destroy correct number of xdp queues upon failure
      net: ena: Fix xdp drops handling due to multibuf packets
      net: ena: Fix XDP redirection error

David Howells (1):
      afs: Fix refcount underflow from error handling race

David Stevens (1):
      mm/shmem: fix race in shmem_undo_range w/THP

Denis Benato (2):
      HID: hid-asus: reset the backlight brightness level on resume
      HID: hid-asus: add const to read-only outgoing usb buffer

Dinghao Liu (1):
      qed: Fix a potential use-after-free in qed_cxt_tables_alloc

Dong Chenchen (1):
      net: Remove acked SYN flag from packet in the transmit queue correctly

Eduard Zingerman (1):
      selftests/bpf: fix bpf_loop_bench for new callback verification scheme

Florent Revest (1):
      team: Fix use-after-free when an option instance allocation fails

Greg Kroah-Hartman (1):
      Linux 6.1.69

Hangyu Hua (1):
      fuse: dax: set fc->dax to NULL in fuse_dax_conn_free()

Hannes Reinecke (1):
      nvme: catch errors from nvme_configure_metadata()

Hariprasad Kelam (2):
      octeontx2-pf: Fix promisc mcam entry action
      octeontx2-af: Update RSS algorithm index

Hartmut Knaack (1):
      ALSA: hda/realtek: Apply mute LED quirk for HP15-db

Hayes Wang (3):
      r8152: avoid to change cfg for all devices
      r8152: remove rtl_vendor_mode function
      r8152: fix the autosuspend doesn't work

Hyunwoo Kim (3):
      atm: Fix Use-After-Free in do_vcc_ioctl
      net/rose: Fix Use-After-Free in rose_ioctl
      appletalk: Fix Use-After-Free in atalk_ioctl

Igor Russkikh (1):
      net: atlantic: fix double free in ring reinit logic

Ioana Ciornei (2):
      dpaa2-switch: fix size of the dma_unmap
      dpaa2-switch: do not ask for MDB, VLAN and FDB replay

James Houghton (1):
      arm64: mm: Always make sw-dirty PTEs hw-dirty in pte_modify

Jan Kara (1):
      ext4: fix warning in ext4_dio_write_end_io()

Jason-JH.Lin (1):
      drm/mediatek: Add spinlock for setting vblank event in atomic_begin

Jean Delvare (1):
      stmmac: dwmac-loongson: Add architecture dependency

Jens Axboe (1):
      cred: switch to using atomic_long_t

Jiaxun Yang (1):
      PCI: loongson: Limit MRRS to 256

John Fastabend (1):
      net: tls, update curr on splice as well

Josef Bacik (1):
      btrfs: do not allow non subvolume root targets for snapshot

Kai Vehmanen (2):
      ALSA: hda/hdmi: add force-connect quirk for NUC5CPYB
      ALSA: hda/hdmi: add force-connect quirks for ASUSTeK Z170 variants

Kalesh AP (1):
      bnxt_en: Fix wrong return value check in bnxt_close_nic()

Kan Liang (1):
      perf/x86/uncore: Don't WARN_ON_ONCE() for a broken discovery table

Kelly Kane (1):
      r8152: add vendor/device ID pair for ASUS USB-C2500

Krzysztof Kozlowski (1):
      soundwire: stream: fix NULL pointer dereference for multi_link

Lech Perczak (1):
      net: usb: qmi_wwan: claim interface 4 for ZTE MF290

Li Nan (2):
      nbd: fold nbd config initialization into nbd_alloc_config()
      nbd: pass nbd_sock to nbd_read_reply() instead of index

Linus Torvalds (1):
      asm-generic: qspinlock: fix queued_spin_value_unlocked() implementation

Maciej Żenczykowski (1):
      net: ipv6: support reporting otherwise unknown prefix flags in RTM_NEWPREFIX

Mario Limonciello (1):
      drm/amd/display: Disable PSR-SU on Parade 0803 TCON again

Mark O'Donovan (1):
      nvme-auth: set explanation code for failure2 msgs

Mark Rutland (1):
      perf: Fix perf_event_validate_size() lockdep splat

Masahiro Yamada (2):
      LoongArch: Add dependency between vmlinuz.efi and vmlinux.efi
      arm64: add dependency between vmlinuz.efi and Image

Michael Chan (2):
      bnxt_en: Save ring error counters across reset
      bnxt_en: Fix HWTSTAMP_FILTER_ALL packet timestamp logic

Mikhail Khvainitski (1):
      HID: lenovo: Restrict detection of patched firmware only to USB cptkbd

Ming Lei (2):
      blk-throttle: fix lockdep warning of "cgroup_mutex or RCU read lock required!"
      blk-cgroup: bypass blkcg_deactivate_policy after destroying

Moshe Shemesh (1):
      net/mlx5e: Fix possible deadlock on mlx5e_tx_timeout_work

Namjae Jeon (1):
      ksmbd: fix wrong name of SMB2_CREATE_ALLOCATION_SIZE

Naveen N Rao (1):
      powerpc/ftrace: Fix stack teardown in ftrace_no_trace

Nikolay Kuratov (1):
      vsock/virtio: Fix unsigned integer wrap around in virtio_transport_has_space()

Oliver Neukum (2):
      usb: aqc111: check packet for fixup for true limit
      HID: add ALWAYS_POLL quirk for Apple kb

Paulo Alcantara (3):
      smb: client: fix OOB in receive_encrypted_standard()
      smb: client: fix NULL deref in asn1_ber_decoder()
      smb: client: fix OOB in smb2_query_reparse_point()

Piotr Gardocki (2):
      iavf: Introduce new state machines for flow director
      iavf: Handle ntuple on/off based on new state machines for flow director

Radu Bulie (1):
      net: fec: correct queue selection

Saurabh Sengar (1):
      x86/hyperv: Fix the detection of E820_TYPE_PRAM in a Gen2 VM

Somnath Kotur (1):
      bnxt_en: Clear resource reservation during resume

Stefan Wahren (3):
      qca_debug: Prevent crash on TX ring changes
      qca_debug: Fix ethtool -G iface tx behavior
      qca_spi: Fix reset behavior

Steven Rostedt (Google) (8):
      ring-buffer: Fix memory leak of free page
      tracing: Update snapshot buffer on resize if it is allocated
      ring-buffer: Do not update before stamp when switching sub-buffers
      ring-buffer: Have saved event hold the entire event
      ring-buffer: Fix writing to the buffer with max_data_size
      ring-buffer: Fix a race in rb_time_cmpxchg() for 32 bit archs
      ring-buffer: Do not try to put back write_stamp
      ring-buffer: Have rb_time_cmpxchg() set the msb counter too

Ville Syrjälä (1):
      drm/i915: Fix remapped stride with CCS on ADL+

Vladimir Oltean (1):
      net: vlan: introduce skb_vlan_eth_hdr()

Yanteng Si (1):
      stmmac: dwmac-loongson: Make sure MDIO is initialized before use

Yu Zhao (1):
      mm/mglru: fix underprotected page cache

Yusong Gao (1):
      sign-file: Fix incorrect return values check

Zhipeng Lu (1):
      octeontx2-af: fix a use-after-free in rvu_nix_register_reporters

Zizhi Wo (1):
      ksmbd: fix memory leak in smb2_lock()


