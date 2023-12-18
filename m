Return-Path: <linux-kernel+bounces-3810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9838481728D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 15:10:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 024E4B23668
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 14:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9E73A1CE;
	Mon, 18 Dec 2023 14:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IFOD+S4u"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95011D14B;
	Mon, 18 Dec 2023 14:07:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0CBDC433C7;
	Mon, 18 Dec 2023 14:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702908462;
	bh=eUSEC0XarlYi5X6EXCM67NchB6hRnTuMGm4ueZzOtHE=;
	h=From:To:Cc:Subject:Date:From;
	b=IFOD+S4uRXEDfuLGXJxXGh2aeRJPWWHrygyYgfMslRjNuMa/xkw0qvsFog7lasTfL
	 XHaeW9T+bj2O+Dod/+hMTJs8TsDf/ZVdcKN5mFPzYp2Z50Kkp5196y43ci9wp6d44H
	 HlXQqfF49fWpEXh4xHbjlEUntrG7JVfoVqzgxcLM=
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
Subject: [PATCH 5.10 00/62] 5.10.205-rc1 review
Date: Mon, 18 Dec 2023 14:51:24 +0100
Message-ID: <20231218135046.178317233@linuxfoundation.org>
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
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.205-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.10.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.10.205-rc1
X-KernelTest-Deadline: 2023-12-20T13:50+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is the start of the stable review cycle for the 5.10.205 release.
There are 62 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed, 20 Dec 2023 13:50:31 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.205-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 5.10.205-rc1

Naveen N Rao <naveen@kernel.org>
    powerpc/ftrace: Fix stack teardown in ftrace_no_trace

Naveen N Rao <naveen@kernel.org>
    powerpc/ftrace: Create a dummy stackframe to fix stack unwind

Mazin Al Haddad <mazinalhaddad05@gmail.com>
    tty: n_gsm: add sanity check for gsm->receive in gsm_receive_buf()

Jiri Slaby <jirislaby@kernel.org>
    tty: n_gsm, remove duplicates of parameters

Daniel Starke <daniel.starke@siemens.com>
    tty: n_gsm: fix tty registration before control channel open

Roy Luo <royluo@google.com>
    USB: gadget: core: adjust uevent timing on gadget unbind

Steven Rostedt (Google) <rostedt@goodmis.org>
    ring-buffer: Fix a race in rb_time_cmpxchg() for 32 bit archs

Steven Rostedt (Google) <rostedt@goodmis.org>
    ring-buffer: Fix writing to the buffer with max_data_size

Steven Rostedt (Google) <rostedt@goodmis.org>
    ring-buffer: Have saved event hold the entire event

Steven Rostedt (Google) <rostedt@goodmis.org>
    tracing: Update snapshot buffer on resize if it is allocated

Steven Rostedt (Google) <rostedt@goodmis.org>
    ring-buffer: Fix memory leak of free page

Florent Revest <revest@chromium.org>
    team: Fix use-after-free when an option instance allocation fails

James Houghton <jthoughton@google.com>
    arm64: mm: Always make sw-dirty PTEs hw-dirty in pte_modify

Baokun Li <libaokun1@huawei.com>
    ext4: prevent the normalized size from exceeding EXT_MAX_BLOCKS

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    soundwire: stream: fix NULL pointer dereference for multi_link

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
    blk-throttle: fix lockdep warning of "cgroup_mutex or RCU read lock required!"

Oliver Neukum <oneukum@suse.com>
    usb: aqc111: check packet for fixup for true limit

Jason-JH.Lin <jason-jh.lin@mediatek.com>
    drm/mediatek: Add spinlock for setting vblank event in atomic_begin

Maxime Ripard <maxime@cerno.tech>
    drm: Use state helper instead of CRTC state pointer

Maxime Ripard <maxime@cerno.tech>
    drm/atomic: Pass the full state to CRTC atomic begin and flush

Jiaxun Yang <jiaxun.yang@flygoat.com>
    PCI: loongson: Limit MRRS to 256

Bjorn Helgaas <bhelgaas@google.com>
    Revert "PCI: acpiphp: Reassign resources on bridge if necessary"

Hartmut Knaack <knaack.h@gmx.de>
    ALSA: hda/realtek: Apply mute LED quirk for HP15-db

Kai Vehmanen <kai.vehmanen@linux.intel.com>
    ALSA: hda/hdmi: add force-connect quirks for ASUSTeK Z170 variants

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

Nikolay Kuratov <kniv@yandex-team.ru>
    vsock/virtio: Fix unsigned integer wrap around in virtio_transport_has_space()

Yusong Gao <a869920004@gmail.com>
    sign-file: Fix incorrect return values check

David Arinzon <darinzon@amazon.com>
    net: ena: Fix XDP redirection error

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

Florian Westphal <fw@strlen.de>
    netfilter: nf_tables: fix 'exist' matching on bigendian arches


-------------

Diffstat:

 Makefile                                           |   4 +-
 arch/arm64/include/asm/pgtable.h                   |   6 +
 arch/powerpc/kernel/trace/ftrace_64_mprofile.S     |  17 ++-
 block/blk-throttle.c                               |   2 +
 drivers/atm/solos-pci.c                            |   8 +-
 drivers/gpu/drm/arm/display/komeda/komeda_crtc.c   |   8 +-
 drivers/gpu/drm/arm/hdlcd_crtc.c                   |   2 +-
 drivers/gpu/drm/armada/armada_crtc.c               |  12 +-
 drivers/gpu/drm/ast/ast_mode.c                     |   9 +-
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c     |   4 +-
 drivers/gpu/drm/drm_atomic_helper.c                |   8 +-
 drivers/gpu/drm/exynos/exynos_drm_crtc.c           |   4 +-
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c         |   2 +-
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c     |   4 +-
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c    |   4 +-
 drivers/gpu/drm/imx/dcss/dcss-crtc.c               |   4 +-
 drivers/gpu/drm/imx/ipuv3-crtc.c                   |   4 +-
 drivers/gpu/drm/ingenic/ingenic-drm-drv.c          |  22 ++--
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c            |  24 ++--
 drivers/gpu/drm/meson/meson_crtc.c                 |   4 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c           |   4 +-
 drivers/gpu/drm/msm/disp/mdp4/mdp4_crtc.c          |   4 +-
 drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c          |   4 +-
 drivers/gpu/drm/mxsfb/mxsfb_kms.c                  |   2 +-
 drivers/gpu/drm/omapdrm/omap_crtc.c                |   4 +-
 drivers/gpu/drm/qxl/qxl_display.c                  |   2 +-
 drivers/gpu/drm/rcar-du/rcar_du_crtc.c             |   4 +-
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c        |  14 ++-
 drivers/gpu/drm/sti/sti_crtc.c                     |   2 +-
 drivers/gpu/drm/stm/ltdc.c                         |   2 +-
 drivers/gpu/drm/sun4i/sun4i_crtc.c                 |   6 +-
 drivers/gpu/drm/tegra/dc.c                         |  12 +-
 drivers/gpu/drm/tidss/tidss_crtc.c                 |   4 +-
 drivers/gpu/drm/tilcdc/tilcdc_crtc.c               |   2 +-
 drivers/gpu/drm/vboxvideo/vbox_mode.c              |   2 +-
 drivers/gpu/drm/vc4/vc4_drv.h                      |   3 +-
 drivers/gpu/drm/vc4/vc4_hvs.c                      |   4 +-
 drivers/gpu/drm/virtio/virtgpu_display.c           |   6 +-
 drivers/gpu/drm/vkms/vkms_crtc.c                   |   4 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c                |   4 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.h                |   4 +-
 drivers/gpu/drm/xlnx/zynqmp_disp.c                 |   4 +-
 drivers/gpu/drm/zte/zx_vou.c                       |   2 +-
 drivers/hid/hid-asus.c                             |  25 +++-
 drivers/hid/hid-glorious.c                         |  16 ++-
 drivers/hid/hid-ids.h                              |  11 +-
 drivers/hid/hid-lenovo.c                           |   3 +-
 drivers/hid/hid-multitouch.c                       |   5 +
 drivers/hid/hid-quirks.c                           |   1 +
 drivers/md/bcache/bcache.h                         |   1 +
 drivers/md/bcache/btree.c                          |   7 ++
 drivers/md/bcache/super.c                          |   4 +-
 drivers/md/bcache/writeback.c                      |   2 +-
 drivers/net/ethernet/amazon/ena/ena_eth_com.c      |   3 -
 drivers/net/ethernet/amazon/ena/ena_netdev.c       |  13 +-
 drivers/net/ethernet/aquantia/atlantic/aq_ring.c   |   5 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c    |   3 +-
 drivers/net/ethernet/emulex/benet/be_main.c        |   2 +-
 drivers/net/ethernet/freescale/fec_main.c          |  27 ++---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    |   2 +-
 drivers/net/ethernet/intel/i40e/i40e_txrx.c        |   2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c      |   2 +-
 .../net/ethernet/qlogic/netxen/netxen_nic_main.c   |   2 +-
 drivers/net/ethernet/qlogic/qed/qed_cxt.c          |   1 +
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.c     |   4 +-
 drivers/net/ethernet/qualcomm/qca_debug.c          |  17 +--
 drivers/net/ethernet/qualcomm/qca_spi.c            |  20 +++-
 drivers/net/ethernet/sfc/tx_tso.c                  |   2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |  13 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c  |   8 +-
 drivers/net/team/team.c                            |   4 +-
 drivers/net/usb/aqc111.c                           |   8 +-
 drivers/net/usb/qmi_wwan.c                         |   1 +
 drivers/pci/controller/pci-loongson.c              |  46 +++++++-
 drivers/pci/hotplug/acpiphp_glue.c                 |   9 +-
 drivers/platform/x86/intel_telemetry_core.c        |   4 +-
 drivers/soundwire/stream.c                         |   7 +-
 drivers/staging/gdm724x/gdm_lte.c                  |   4 +-
 drivers/tty/n_gsm.c                                | 131 +++++++++++++--------
 drivers/usb/gadget/udc/core.c                      |   4 +-
 fs/afs/rxrpc.c                                     |   2 +-
 fs/ext4/mballoc.c                                  |   4 +
 fs/fuse/dax.c                                      |   1 +
 include/asm-generic/qspinlock.h                    |   2 +-
 include/drm/drm_modeset_helper_vtables.h           |   4 +-
 include/linux/cred.h                               |   8 +-
 include/linux/if_vlan.h                            |  12 +-
 include/net/addrconf.h                             |  12 +-
 include/net/if_inet6.h                             |   4 -
 kernel/cred.c                                      |  64 +++++-----
 kernel/events/core.c                               |  10 ++
 kernel/trace/ring_buffer.c                         |  18 ++-
 kernel/trace/trace.c                               |   4 +-
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
 sound/pci/hda/patch_hdmi.c                         |   2 +
 sound/pci/hda/patch_realtek.c                      |   1 +
 105 files changed, 564 insertions(+), 312 deletions(-)



