Return-Path: <linux-kernel+bounces-3816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE9A817312
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 15:14:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 832311C24FDB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 14:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C7F37876;
	Mon, 18 Dec 2023 14:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vtUWJlOE"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562DA129EF7;
	Mon, 18 Dec 2023 14:13:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3570C433C7;
	Mon, 18 Dec 2023 14:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702908790;
	bh=mSWH7cZfSokSyoj4C8/QxLMgjQVveZ+rMNM8kQnml/g=;
	h=From:To:Cc:Subject:Date:From;
	b=vtUWJlOE0GlSUKbqU+7tdice6A9Cw2jSO5a6kqVzLkUfOcHPe2Q+ANlWEmqQr1vvl
	 aMs7R7RfFnrxuKBuNZ4TL6IYGwQLCNVc1ZQp5BLOYmh9e4p7BKChnZjeHz5D+IYllA
	 geBhXH0sO7HgVBDi65uD8rwV49FF4ZaDO6YOyOuQ=
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
Subject: [PATCH 5.15 00/83] 5.15.144-rc1 review
Date: Mon, 18 Dec 2023 14:51:21 +0100
Message-ID: <20231218135049.738602288@linuxfoundation.org>
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
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.144-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.15.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.15.144-rc1
X-KernelTest-Deadline: 2023-12-20T13:50+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is the start of the stable review cycle for the 5.15.144 release.
There are 83 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed, 20 Dec 2023 13:50:31 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.144-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 5.15.144-rc1

Hayes Wang <hayeswang@realtek.com>
    r8152: fix the autosuspend doesn't work

Hayes Wang <hayeswang@realtek.com>
    r8152: remove rtl_vendor_mode function

Hayes Wang <hayeswang@realtek.com>
    r8152: avoid to change cfg for all devices

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    ksmbd: Mark as BROKEN in the 5.15.y kernel

Naveen N Rao <naveen@kernel.org>
    powerpc/ftrace: Fix stack teardown in ftrace_no_trace

Naveen N Rao <naveen@kernel.org>
    powerpc/ftrace: Create a dummy stackframe to fix stack unwind

Christopher Bednarz <christopher.n.bednarz@intel.com>
    RDMA/irdma: Prevent zero-length STAG registration

Roy Luo <royluo@google.com>
    USB: gadget: core: adjust uevent timing on gadget unbind

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

Lech Perczak <lech.perczak@gmail.com>
    net: usb: qmi_wwan: claim interface 4 for ZTE MF290

Linus Torvalds <torvalds@linux-foundation.org>
    asm-generic: qspinlock: fix queued_spin_value_unlocked() implementation

Aoba K <nexp_0x17@outlook.com>
    HID: multitouch: Add quirk for HONOR GLO-GXXX touchpad

Denis Benato <benato.denis96@gmail.com>
    HID: hid-asus: reset the backlight brightness level on resume

Oliver Neukum <oneukum@suse.com>
    HID: add ALWAYS_POLL quirk for Apple kb

Brett Raye <braye@fastmail.com>
    HID: glorious: fix Glorious Model I HID report

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    platform/x86: intel_telemetry: Fix kernel doc descriptions

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

Jason-JH.Lin <jason-jh.lin@mediatek.com>
    drm/mediatek: Add spinlock for setting vblank event in atomic_begin

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

Rasmus Villemoes <linux@rasmusvillemoes.dk>
    net: stmmac: use dev_err_probe() for reporting mdio bus registration failure

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

Stefan Wahren <wahrenst@gmx.net>
    qca_spi: Fix reset behavior

Stefan Wahren <wahrenst@gmx.net>
    qca_debug: Fix ethtool -G iface tx behavior

Stefan Wahren <wahrenst@gmx.net>
    qca_debug: Prevent crash on TX ring changes

Maciej Żenczykowski <maze@google.com>
    net: ipv6: support reporting otherwise unknown prefix flags in RTM_NEWPREFIX

Mikhail Khvainitski <me@khvoinitsky.org>
    HID: lenovo: Restrict detection of patched firmware only to USB cptkbd

David Howells <dhowells@redhat.com>
    afs: Fix refcount underflow from error handling race

Zizhi Wo <wozizhi@huawei.com>
    ksmbd: fix memory leak in smb2_lock()

Jiaxun Yang <jiaxun.yang@flygoat.com>
    MIPS: Loongson64: Handle more memory types passed from firmware

David Hildenbrand <david@redhat.com>
    memblock: allow to specify flags with memblock_add_node()

David Hildenbrand <david@redhat.com>
    mm/memory_hotplug: handle memblock_add_node() failures in add_memory_resource()

Florian Westphal <fw@strlen.de>
    netfilter: nf_tables: fix 'exist' matching on bigendian arches

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
 arch/arc/mm/init.c                                 |   4 +-
 arch/arm64/include/asm/pgtable.h                   |   6 +
 arch/ia64/mm/contig.c                              |   2 +-
 arch/ia64/mm/init.c                                |   2 +-
 arch/m68k/mm/mcfmmu.c                              |   3 +-
 arch/m68k/mm/motorola.c                            |   6 +-
 arch/mips/include/asm/mach-loongson64/boot_param.h |   6 +-
 arch/mips/loongson64/init.c                        |  42 +++--
 arch/mips/sgi-ip27/ip27-memory.c                   |   3 +-
 arch/powerpc/kernel/trace/ftrace_64_mprofile.S     |  17 +-
 arch/s390/kernel/setup.c                           |   3 +-
 arch/x86/events/intel/uncore_discovery.c           |  18 ++-
 block/blk-cgroup.c                                 |  13 ++
 block/blk-throttle.c                               |   2 +
 drivers/atm/solos-pci.c                            |   8 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c             |  28 ++++
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c            |   5 +
 drivers/hid/hid-asus.c                             |  27 +++-
 drivers/hid/hid-glorious.c                         |  16 +-
 drivers/hid/hid-ids.h                              |  11 +-
 drivers/hid/hid-lenovo.c                           |   3 +-
 drivers/hid/hid-multitouch.c                       |   5 +
 drivers/hid/hid-quirks.c                           |   1 +
 drivers/infiniband/hw/irdma/ctrl.c                 |   6 +
 drivers/infiniband/hw/irdma/type.h                 |   2 +
 drivers/infiniband/hw/irdma/verbs.c                |  10 +-
 drivers/md/bcache/bcache.h                         |   1 +
 drivers/md/bcache/btree.c                          |   7 +
 drivers/md/bcache/super.c                          |   4 +-
 drivers/md/bcache/writeback.c                      |   2 +-
 drivers/net/ethernet/amazon/ena/ena_eth_com.c      |   3 -
 drivers/net/ethernet/amazon/ena/ena_netdev.c       |  30 ++--
 drivers/net/ethernet/aquantia/atlantic/aq_ring.c   |   5 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c    |   3 +-
 drivers/net/ethernet/emulex/benet/be_main.c        |   2 +-
 .../ethernet/freescale/dpaa2/dpaa2-switch-flower.c |   7 +-
 drivers/net/ethernet/freescale/fec_main.c          |  27 ++--
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    |   2 +-
 drivers/net/ethernet/intel/i40e/i40e_txrx.c        |   2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c      |   2 +-
 .../ethernet/marvell/octeontx2/af/rvu_devlink.c    |   5 +-
 .../net/ethernet/marvell/octeontx2/af/rvu_npc.c    |  55 +++++--
 .../net/ethernet/marvell/octeontx2/nic/otx2_pf.c   |  25 ++-
 .../net/ethernet/qlogic/netxen/netxen_nic_main.c   |   2 +-
 drivers/net/ethernet/qlogic/qed/qed_cxt.c          |   1 +
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.c     |   4 +-
 drivers/net/ethernet/qualcomm/qca_debug.c          |  17 +-
 drivers/net/ethernet/qualcomm/qca_spi.c            |  20 ++-
 drivers/net/ethernet/sfc/tx_tso.c                  |   2 +-
 drivers/net/ethernet/stmicro/stmmac/Kconfig        |   2 +-
 .../net/ethernet/stmicro/stmmac/dwmac-loongson.c   |  14 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |  13 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c  |   8 +-
 drivers/net/team/team.c                            |   4 +-
 drivers/net/usb/aqc111.c                           |   8 +-
 drivers/net/usb/qmi_wwan.c                         |   1 +
 drivers/net/usb/r8152.c                            | 177 ++++++++++++---------
 drivers/pci/controller/pci-loongson.c              |  46 +++++-
 drivers/pci/hotplug/acpiphp_glue.c                 |   9 +-
 drivers/platform/x86/intel/telemetry/core.c        |   4 +-
 drivers/soundwire/stream.c                         |   7 +-
 drivers/staging/gdm724x/gdm_lte.c                  |   4 +-
 drivers/usb/gadget/udc/core.c                      |   4 +-
 fs/afs/rxrpc.c                                     |   2 +-
 fs/btrfs/ioctl.c                                   |   9 ++
 fs/ext4/mballoc.c                                  |   4 +
 fs/fuse/dax.c                                      |   1 +
 fs/ksmbd/Kconfig                                   |   1 +
 fs/ksmbd/smb2pdu.c                                 |   1 +
 include/asm-generic/qspinlock.h                    |   2 +-
 include/linux/cred.h                               |   8 +-
 include/linux/if_vlan.h                            |  12 +-
 include/linux/memblock.h                           |   3 +-
 include/linux/mm.h                                 |   2 +-
 include/linux/usb/r8152.h                          |   2 +
 include/net/addrconf.h                             |  12 +-
 include/net/if_inet6.h                             |   4 -
 kernel/cred.c                                      |  64 ++++----
 kernel/events/core.c                               |  10 ++
 kernel/trace/ring_buffer.c                         |  56 +++----
 kernel/trace/trace.c                               |   4 +-
 mm/memblock.c                                      |   9 +-
 mm/memory_hotplug.c                                |   8 +-
 net/appletalk/ddp.c                                |   9 +-
 net/atm/ioctl.c                                    |   7 +-
 net/batman-adv/soft-interface.c                    |   2 +-
 net/ipv4/tcp_output.c                              |   6 +
 net/ipv6/addrconf.c                                |   6 +-
 net/netfilter/nft_exthdr.c                         |   2 +-
 net/netfilter/nft_fib.c                            |   8 +-
 net/rose/af_rose.c                                 |   4 +-
 net/vmw_vsock/virtio_transport_common.c            |   2 +-
 scripts/sign-file.c                                |  12 +-
 sound/pci/hda/patch_hdmi.c                         |   3 +
 sound/pci/hda/patch_realtek.c                      |   1 +
 96 files changed, 699 insertions(+), 359 deletions(-)



