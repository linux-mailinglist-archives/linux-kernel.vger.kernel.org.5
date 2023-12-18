Return-Path: <linux-kernel+bounces-3782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AEEF817146
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 14:56:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6C031F23568
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 13:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A3EE15AC0;
	Mon, 18 Dec 2023 13:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hYLXkS6s"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8B11D12B;
	Mon, 18 Dec 2023 13:56:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6829C433C8;
	Mon, 18 Dec 2023 13:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702907763;
	bh=mLfydx2vV807j8YzyrKI3/HvQ4/ENRHzCDtRBKvwUuc=;
	h=From:To:Cc:Subject:Date:From;
	b=hYLXkS6sx0ZdUmqZO6TdhPX2NAAbzaAef2GvwMzAEalTJYBAMTxq3cbCzbKC+18tz
	 VT4mPA0x7PRblNqQj2Ne4T7KoynNVKZejtAMDZp92G80c4angk3jobAhmzWkIgdFvd
	 dOdtoaoDa5c4jbzStxrpxkh6nHkO991hlT+rdoIE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org,
	akpm@linux-foundation.org,
	linux@roeck-us.net,
	shuah@kernel.org,
	patches@kernelci.org,
	lkft-triage@lists.linaro.org,
	pavel@denx.de,
	jonathanh@nvidia.com,
	f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net,
	rwarsow@gmx.de,
	conor@kernel.org,
	allen.lkml@gmail.com
Subject: [PATCH 6.1 000/106] 6.1.69-rc1 review
Date: Mon, 18 Dec 2023 14:50:14 +0100
Message-ID: <20231218135055.005497074@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.69-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.1.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.1.69-rc1
X-KernelTest-Deadline: 2023-12-20T13:50+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is the start of the stable review cycle for the 6.1.69 release.
There are 106 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed, 20 Dec 2023 13:50:31 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.69-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 6.1.69-rc1

Hayes Wang <hayeswang@realtek.com>
    r8152: fix the autosuspend doesn't work

Hayes Wang <hayeswang@realtek.com>
    r8152: remove rtl_vendor_mode function

Hayes Wang <hayeswang@realtek.com>
    r8152: avoid to change cfg for all devices

John Fastabend <john.fastabend@gmail.com>
    net: tls, update curr on splice as well

Steven Rostedt (Google) <rostedt@goodmis.org>
    ring-buffer: Have rb_time_cmpxchg() set the msb counter too

Steven Rostedt (Google) <rostedt@goodmis.org>
    ring-buffer: Do not try to put back write_stamp

Steven Rostedt (Google) <rostedt@goodmis.org>
    ring-buffer: Fix a race in rb_time_cmpxchg() for 32 bit archs

Steven Rostedt (Google) <rostedt@goodmis.org>
    ring-buffer: Fix writing to the buffer with max_data_size

Steven Rostedt (Google) <rostedt@goodmis.org>
    ring-buffer: Have saved event hold the entire event

Steven Rostedt (Google) <rostedt@goodmis.org>
    ring-buffer: Do not update before stamp when switching sub-buffers

Steven Rostedt (Google) <rostedt@goodmis.org>
    tracing: Update snapshot buffer on resize if it is allocated

Steven Rostedt (Google) <rostedt@goodmis.org>
    ring-buffer: Fix memory leak of free page

Paulo Alcantara <pc@manguebit.com>
    smb: client: fix OOB in smb2_query_reparse_point()

Paulo Alcantara <pc@manguebit.com>
    smb: client: fix NULL deref in asn1_ber_decoder()

Paulo Alcantara <pc@manguebit.com>
    smb: client: fix OOB in receive_encrypted_standard()

Ville Syrjälä <ville.syrjala@linux.intel.com>
    drm/i915: Fix remapped stride with CCS on ADL+

Mario Limonciello <mario.limonciello@amd.com>
    drm/amd/display: Disable PSR-SU on Parade 0803 TCON again

Christian König <christian.koenig@amd.com>
    drm/amdgpu: fix tear down order in amdgpu_vm_pt_free

Boris Burkov <boris@bur.io>
    btrfs: don't clear qgroup reserved bit in release_folio

Boris Burkov <boris@bur.io>
    btrfs: free qgroup reserve when ORDERED_IOERR is set

David Stevens <stevensd@chromium.org>
    mm/shmem: fix race in shmem_undo_range w/THP

Yu Zhao <yuzhao@google.com>
    mm/mglru: fix underprotected page cache

Amelie Delaunay <amelie.delaunay@foss.st.com>
    dmaengine: stm32-dma: avoid bitfield overflow assertion

Alex Deucher <alexander.deucher@amd.com>
    drm/amdgpu/sdma5.2: add begin/end_use ring callbacks

Florent Revest <revest@chromium.org>
    team: Fix use-after-free when an option instance allocation fails

James Houghton <jthoughton@google.com>
    arm64: mm: Always make sw-dirty PTEs hw-dirty in pte_modify

Baokun Li <libaokun1@huawei.com>
    ext4: prevent the normalized size from exceeding EXT_MAX_BLOCKS

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    soundwire: stream: fix NULL pointer dereference for multi_link

Josef Bacik <josef@toxicpanda.com>
    btrfs: do not allow non subvolume root targets for snapshot

Mark Rutland <mark.rutland@arm.com>
    perf: Fix perf_event_validate_size() lockdep splat

Denis Benato <benato.denis96@gmail.com>
    HID: hid-asus: add const to read-only outgoing usb buffer

Masahiro Yamada <masahiroy@kernel.org>
    arm64: add dependency between vmlinuz.efi and Image

Lech Perczak <lech.perczak@gmail.com>
    net: usb: qmi_wwan: claim interface 4 for ZTE MF290

Linus Torvalds <torvalds@linux-foundation.org>
    asm-generic: qspinlock: fix queued_spin_value_unlocked() implementation

Aoba K <nexp_0x17@outlook.com>
    HID: multitouch: Add quirk for HONOR GLO-GXXX touchpad

Denis Benato <benato.denis96@gmail.com>
    HID: hid-asus: reset the backlight brightness level on resume

Li Nan <linan122@huawei.com>
    nbd: pass nbd_sock to nbd_read_reply() instead of index

Oliver Neukum <oneukum@suse.com>
    HID: add ALWAYS_POLL quirk for Apple kb

Brett Raye <braye@fastmail.com>
    HID: glorious: fix Glorious Model I HID report

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    platform/x86: intel_telemetry: Fix kernel doc descriptions

Bibo Mao <maobibo@loongson.cn>
    LoongArch: Implement constant timer shutdown interface

Masahiro Yamada <masahiroy@kernel.org>
    LoongArch: Add dependency between vmlinuz.efi and vmlinux.efi

Eduard Zingerman <eddyz87@gmail.com>
    selftests/bpf: fix bpf_loop_bench for new callback verification scheme

Hannes Reinecke <hare@suse.de>
    nvme: catch errors from nvme_configure_metadata()

Mark O'Donovan <shiftee@posteo.net>
    nvme-auth: set explanation code for failure2 msgs

Li Nan <linan122@huawei.com>
    nbd: fold nbd config initialization into nbd_alloc_config()

Coly Li <colyli@suse.de>
    bcache: avoid NULL checking to c->root in run_cache_set()

Coly Li <colyli@suse.de>
    bcache: add code comments for bch_btree_node_get() and __bch_btree_node_alloc()

Colin Ian King <colin.i.king@gmail.com>
    bcache: remove redundant assignment to variable cur_idx

Coly Li <colyli@suse.de>
    bcache: avoid oversize memory allocation by small stripe_size

Ming Lei <ming.lei@redhat.com>
    blk-cgroup: bypass blkcg_deactivate_policy after destroying

Ming Lei <ming.lei@redhat.com>
    blk-throttle: fix lockdep warning of "cgroup_mutex or RCU read lock required!"

Jean Delvare <jdelvare@suse.de>
    stmmac: dwmac-loongson: Add architecture dependency

Oliver Neukum <oneukum@suse.com>
    usb: aqc111: check packet for fixup for true limit

Saurabh Sengar <ssengar@linux.microsoft.com>
    x86/hyperv: Fix the detection of E820_TYPE_PRAM in a Gen2 VM

Jason-JH.Lin <jason-jh.lin@mediatek.com>
    drm/mediatek: Add spinlock for setting vblank event in atomic_begin

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: fix wrong name of SMB2_CREATE_ALLOCATION_SIZE

Jiaxun Yang <jiaxun.yang@flygoat.com>
    PCI: loongson: Limit MRRS to 256

Bjorn Helgaas <bhelgaas@google.com>
    Revert "PCI: acpiphp: Reassign resources on bridge if necessary"

Hartmut Knaack <knaack.h@gmx.de>
    ALSA: hda/realtek: Apply mute LED quirk for HP15-db

Kai Vehmanen <kai.vehmanen@linux.intel.com>
    ALSA: hda/hdmi: add force-connect quirks for ASUSTeK Z170 variants

Kai Vehmanen <kai.vehmanen@linux.intel.com>
    ALSA: hda/hdmi: add force-connect quirk for NUC5CPYB

Hangyu Hua <hbh25y@gmail.com>
    fuse: dax: set fc->dax to NULL in fuse_dax_conn_free()

Jens Axboe <axboe@kernel.dk>
    cred: switch to using atomic_long_t

Igor Russkikh <irusskikh@marvell.com>
    net: atlantic: fix double free in ring reinit logic

Hyunwoo Kim <v4bel@theori.io>
    appletalk: Fix Use-After-Free in atalk_ioctl

Andrew Halaney <ahalaney@redhat.com>
    net: stmmac: Handle disabled MDIO busses from devicetree

Ioana Ciornei <ioana.ciornei@nxp.com>
    dpaa2-switch: do not ask for MDB, VLAN and FDB replay

Ioana Ciornei <ioana.ciornei@nxp.com>
    dpaa2-switch: fix size of the dma_unmap

Nikolay Kuratov <kniv@yandex-team.ru>
    vsock/virtio: Fix unsigned integer wrap around in virtio_transport_has_space()

Yusong Gao <a869920004@gmail.com>
    sign-file: Fix incorrect return values check

Yanteng Si <siyanteng@loongson.cn>
    stmmac: dwmac-loongson: Make sure MDIO is initialized before use

David Arinzon <darinzon@amazon.com>
    net: ena: Fix XDP redirection error

David Arinzon <darinzon@amazon.com>
    net: ena: Fix xdp drops handling due to multibuf packets

David Arinzon <darinzon@amazon.com>
    net: ena: Destroy correct number of xdp queues upon failure

Dong Chenchen <dongchenchen2@huawei.com>
    net: Remove acked SYN flag from packet in the transmit queue correctly

Dinghao Liu <dinghao.liu@zju.edu.cn>
    qed: Fix a potential use-after-free in qed_cxt_tables_alloc

Piotr Gardocki <piotrx.gardocki@intel.com>
    iavf: Handle ntuple on/off based on new state machines for flow director

Piotr Gardocki <piotrx.gardocki@intel.com>
    iavf: Introduce new state machines for flow director

Hyunwoo Kim <v4bel@theori.io>
    net/rose: Fix Use-After-Free in rose_ioctl

Hyunwoo Kim <v4bel@theori.io>
    atm: Fix Use-After-Free in do_vcc_ioctl

Hariprasad Kelam <hkelam@marvell.com>
    octeontx2-af: Update RSS algorithm index

Hariprasad Kelam <hkelam@marvell.com>
    octeontx2-pf: Fix promisc mcam entry action

Zhipeng Lu <alexious@zju.edu.cn>
    octeontx2-af: fix a use-after-free in rvu_nix_register_reporters

Radu Bulie <radu-andrei.bulie@nxp.com>
    net: fec: correct queue selection

Vladimir Oltean <vladimir.oltean@nxp.com>
    net: vlan: introduce skb_vlan_eth_hdr()

Chengfeng Ye <dg573847474@gmail.com>
    atm: solos-pci: Fix potential deadlock on &tx_queue_lock

Chengfeng Ye <dg573847474@gmail.com>
    atm: solos-pci: Fix potential deadlock on &cli_queue_lock

Michael Chan <michael.chan@broadcom.com>
    bnxt_en: Fix HWTSTAMP_FILTER_ALL packet timestamp logic

Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
    bnxt_en: Fix wrong return value check in bnxt_close_nic()

Michael Chan <michael.chan@broadcom.com>
    bnxt_en: Save ring error counters across reset

Somnath Kotur <somnath.kotur@broadcom.com>
    bnxt_en: Clear resource reservation during resume

Stefan Wahren <wahrenst@gmx.net>
    qca_spi: Fix reset behavior

Stefan Wahren <wahrenst@gmx.net>
    qca_debug: Fix ethtool -G iface tx behavior

Stefan Wahren <wahrenst@gmx.net>
    qca_debug: Prevent crash on TX ring changes

Maciej Żenczykowski <maze@google.com>
    net: ipv6: support reporting otherwise unknown prefix flags in RTM_NEWPREFIX

Moshe Shemesh <moshe@nvidia.com>
    net/mlx5e: Fix possible deadlock on mlx5e_tx_timeout_work

Mikhail Khvainitski <me@khvoinitsky.org>
    HID: lenovo: Restrict detection of patched firmware only to USB cptkbd

David Howells <dhowells@redhat.com>
    afs: Fix refcount underflow from error handling race

Zizhi Wo <wozizhi@huawei.com>
    ksmbd: fix memory leak in smb2_lock()

Jan Kara <jack@suse.cz>
    ext4: fix warning in ext4_dio_write_end_io()

Naveen N Rao <naveen@kernel.org>
    powerpc/ftrace: Fix stack teardown in ftrace_no_trace

Kelly Kane <kelly@hawknetworks.com>
    r8152: add vendor/device ID pair for ASUS USB-C2500

Antonio Napolitano <anton@polit.no>
    r8152: add vendor/device ID pair for D-Link DUB-E250

Bjørn Mork <bjorn@mork.no>
    r8152: add USB device driver for config selection

Kan Liang <kan.liang@linux.intel.com>
    perf/x86/uncore: Don't WARN_ON_ONCE() for a broken discovery table


-------------

Diffstat:

 Makefile                                           |   4 +-
 arch/arm64/Makefile                                |   2 +-
 arch/arm64/include/asm/pgtable.h                   |   6 +
 arch/loongarch/Makefile                            |   2 +
 arch/loongarch/kernel/time.c                       |  27 ++--
 arch/powerpc/kernel/trace/ftrace_mprofile.S        |   4 +-
 arch/x86/events/intel/uncore_discovery.c           |  18 ++-
 arch/x86/hyperv/hv_init.c                          |  25 ++-
 block/blk-cgroup.c                                 |  13 ++
 block/blk-throttle.c                               |   2 +
 drivers/atm/solos-pci.c                            |   8 +-
 drivers/block/nbd.c                                |  76 +++++----
 drivers/dma/stm32-dma.c                            |   8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c          |   3 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c             |  28 ++++
 .../drm/amd/display/modules/power/power_helpers.c  |   2 +
 drivers/gpu/drm/i915/display/intel_fb.c            |  16 +-
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c            |   5 +
 drivers/hid/hid-asus.c                             |  27 +++-
 drivers/hid/hid-glorious.c                         |  16 +-
 drivers/hid/hid-ids.h                              |  11 +-
 drivers/hid/hid-lenovo.c                           |   3 +-
 drivers/hid/hid-multitouch.c                       |   5 +
 drivers/hid/hid-quirks.c                           |   1 +
 drivers/md/bcache/bcache.h                         |   1 +
 drivers/md/bcache/btree.c                          |   7 +
 drivers/md/bcache/super.c                          |   4 +-
 drivers/md/bcache/writeback.c                      |   2 +-
 drivers/net/ethernet/amazon/ena/ena_eth_com.c      |   3 -
 drivers/net/ethernet/amazon/ena/ena_netdev.c       |  30 ++--
 drivers/net/ethernet/aquantia/atlantic/aq_ring.c   |   5 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c    |   3 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |  67 ++++++--
 drivers/net/ethernet/broadcom/bnxt/bnxt.h          |  25 ++-
 drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c  |  11 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c  |  19 +--
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c      |   5 +-
 drivers/net/ethernet/emulex/benet/be_main.c        |   2 +-
 .../ethernet/freescale/dpaa2/dpaa2-switch-flower.c |   7 +-
 .../net/ethernet/freescale/dpaa2/dpaa2-switch.c    |  11 +-
 drivers/net/ethernet/freescale/fec_main.c          |  27 ++--
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    |   2 +-
 drivers/net/ethernet/intel/i40e/i40e_txrx.c        |   2 +-
 drivers/net/ethernet/intel/iavf/iavf.h             |   1 +
 drivers/net/ethernet/intel/iavf/iavf_ethtool.c     |  27 ++--
 drivers/net/ethernet/intel/iavf/iavf_fdir.h        |  15 +-
 drivers/net/ethernet/intel/iavf/iavf_main.c        | 107 +++++++++++--
 drivers/net/ethernet/intel/iavf/iavf_virtchnl.c    |  71 ++++++++-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c      |   2 +-
 .../ethernet/marvell/octeontx2/af/rvu_devlink.c    |   5 +-
 .../net/ethernet/marvell/octeontx2/af/rvu_npc.c    |  55 +++++--
 .../net/ethernet/marvell/octeontx2/nic/otx2_pf.c   |  25 ++-
 drivers/net/ethernet/mellanox/mlx5/core/en.h       |   1 +
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |  27 +++-
 .../net/ethernet/qlogic/netxen/netxen_nic_main.c   |   2 +-
 drivers/net/ethernet/qlogic/qed/qed_cxt.c          |   1 +
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.c     |   4 +-
 drivers/net/ethernet/qualcomm/qca_debug.c          |  17 +-
 drivers/net/ethernet/qualcomm/qca_spi.c            |  20 ++-
 drivers/net/ethernet/sfc/tx_tso.c                  |   2 +-
 drivers/net/ethernet/stmicro/stmmac/Kconfig        |   2 +-
 .../net/ethernet/stmicro/stmmac/dwmac-loongson.c   |  14 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |   7 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c  |   6 +-
 drivers/net/team/team.c                            |   4 +-
 drivers/net/usb/aqc111.c                           |   8 +-
 drivers/net/usb/qmi_wwan.c                         |   1 +
 drivers/net/usb/r8152.c                            | 177 ++++++++++++---------
 drivers/nvme/host/auth.c                           |   2 +
 drivers/nvme/host/core.c                           |  19 ++-
 drivers/pci/controller/pci-loongson.c              |  46 +++++-
 drivers/pci/hotplug/acpiphp_glue.c                 |   9 +-
 drivers/platform/x86/intel/telemetry/core.c        |   4 +-
 drivers/soundwire/stream.c                         |   7 +-
 drivers/staging/gdm724x/gdm_lte.c                  |   4 +-
 fs/afs/rxrpc.c                                     |   2 +-
 fs/btrfs/extent_io.c                               |   3 +-
 fs/btrfs/ioctl.c                                   |   9 ++
 fs/btrfs/ordered-data.c                            |   4 +-
 fs/ext4/file.c                                     |  14 +-
 fs/ext4/mballoc.c                                  |   4 +
 fs/fuse/dax.c                                      |   1 +
 fs/smb/client/smb2misc.c                           |  26 ++-
 fs/smb/client/smb2ops.c                            |  40 +++--
 fs/smb/common/smb2pdu.h                            |   2 +-
 fs/smb/server/smb2pdu.c                            |   1 +
 include/asm-generic/qspinlock.h                    |   2 +-
 include/linux/cred.h                               |   8 +-
 include/linux/if_vlan.h                            |  12 +-
 include/linux/mm_inline.h                          |  23 +--
 include/linux/usb/r8152.h                          |   2 +
 include/net/addrconf.h                             |  12 +-
 include/net/if_inet6.h                             |   4 -
 kernel/cred.c                                      |  64 ++++----
 kernel/events/core.c                               |  10 ++
 kernel/trace/ring_buffer.c                         |  58 +++----
 kernel/trace/trace.c                               |   4 +-
 mm/shmem.c                                         |  19 ++-
 mm/vmscan.c                                        |   2 +-
 mm/workingset.c                                    |   6 +-
 net/appletalk/ddp.c                                |   9 +-
 net/atm/ioctl.c                                    |   7 +-
 net/batman-adv/soft-interface.c                    |   2 +-
 net/ipv4/tcp_output.c                              |   6 +
 net/ipv6/addrconf.c                                |   6 +-
 net/rose/af_rose.c                                 |   4 +-
 net/tls/tls_sw.c                                   |   2 +
 net/vmw_vsock/virtio_transport_common.c            |   2 +-
 scripts/sign-file.c                                |  12 +-
 sound/pci/hda/patch_hdmi.c                         |   3 +
 sound/pci/hda/patch_realtek.c                      |   1 +
 tools/testing/selftests/bpf/progs/bpf_loop_bench.c |  13 +-
 112 files changed, 1122 insertions(+), 514 deletions(-)



