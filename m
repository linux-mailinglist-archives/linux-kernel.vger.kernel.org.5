Return-Path: <linux-kernel+bounces-77868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2889860B4D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 08:26:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78207283FAE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 07:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B141428B;
	Fri, 23 Feb 2024 07:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MDz0KtI3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808A210A3C;
	Fri, 23 Feb 2024 07:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708673196; cv=none; b=gaidZ08Y0PzEN4BeiWSFTl0KJBGdRJnzR1N/oCF2rWe3j8ratFhn5HJf2LOKMPGdnoeCuBkBHzZ5Ozk8m7b4atQsVmd0yGS8cr7P3YANw9ZYoo2nTOVSEaRh7wkBae+SQit6+bpJv9Pb/azAu+bD3ayK46jUavcAqEsvCurZbSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708673196; c=relaxed/simple;
	bh=MggdtTdNw8mylUar0VkrV2kyqmicZbRW6tZzUEI3nWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nFkYEYwynnCb+S6OpvCNU9FFIyuNCefO1NiAMDRDIKDXck46GtEw/DBV4f6mYx3S3x3XAbq6I4cz+RgklIPTeB8amWl0Jsvew1d/kf2EibXRcbxva2uhd4QtqoqHkWVfnlqX04VjGXdr9U0/71mSDWn7WP1zu4yTINt7l14VJtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MDz0KtI3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99CD4C433F1;
	Fri, 23 Feb 2024 07:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708673196;
	bh=MggdtTdNw8mylUar0VkrV2kyqmicZbRW6tZzUEI3nWQ=;
	h=From:To:Cc:Subject:Date:From;
	b=MDz0KtI3GJjaLrkBp85M44DpnrT6pbpwqUthUIqfKhG6R6a2qfPq2mGARnkRz9TTJ
	 gfbYNRnBrREJkx6lgM0yaLMczj9Q8j5meoHAPfv6nDS+GEX0PIoLMULnvLNCmdLOr2
	 x6ed6pRNaMijEPgZkbHinYJh1RapJ0nBtQoHnAb0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 4.19.307
Date: Fri, 23 Feb 2024 08:26:31 +0100
Message-ID: <2024022331-zoology-tried-3716@gregkh>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 4.19.307 kernel.

All users of the 4.19 kernel series must upgrade.

The updated 4.19.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-4.19.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/ABI/testing/sysfs-class-net-queues          |   22 -
 Documentation/ABI/testing/sysfs-class-net-statistics      |   60 +++-
 Documentation/sound/soc/dapm.rst                          |    2 
 Makefile                                                  |    2 
 arch/arm/boot/dts/imx1-ads.dts                            |    2 
 arch/arm/boot/dts/imx1-apf9328.dts                        |    2 
 arch/arm/boot/dts/imx1.dtsi                               |    5 
 arch/arm/boot/dts/imx23-sansa.dts                         |   12 
 arch/arm/boot/dts/imx23.dtsi                              |    2 
 arch/arm/boot/dts/imx25-eukrea-cpuimx25.dtsi              |    2 
 arch/arm/boot/dts/imx27-apf27dev.dts                      |    2 
 arch/arm/boot/dts/imx27-eukrea-cpuimx27.dtsi              |    4 
 arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi           |    2 
 arch/arm/boot/dts/imx27.dtsi                              |    3 
 arch/arm/boot/dts/imx28.dtsi                              |    2 
 arch/arm/boot/dts/imx7s.dtsi                              |    4 
 arch/arm/boot/dts/rk3036.dtsi                             |   14 -
 arch/mips/include/asm/checksum.h                          |    3 
 arch/mips/kernel/elf.c                                    |    6 
 arch/parisc/kernel/firmware.c                             |    4 
 arch/powerpc/include/asm/mmu.h                            |    4 
 arch/powerpc/include/asm/mmzone.h                         |    3 
 arch/powerpc/kernel/traps.c                               |    2 
 arch/powerpc/lib/Makefile                                 |    4 
 arch/powerpc/lib/sstep.c                                  |   10 
 arch/powerpc/mm/init-common.c                             |    5 
 arch/s390/kernel/ptrace.c                                 |    6 
 arch/s390/kvm/kvm-s390.c                                  |    5 
 arch/um/drivers/net_kern.c                                |    2 
 arch/um/include/shared/kern_util.h                        |    2 
 arch/um/kernel/process.c                                  |    2 
 arch/um/os-Linux/helper.c                                 |    6 
 arch/um/os-Linux/util.c                                   |   19 +
 arch/x86/Kconfig.cpu                                      |    2 
 arch/x86/include/asm/syscall_wrapper.h                    |   25 +
 arch/x86/kernel/cpu/amd.c                                 |   20 -
 arch/x86/mm/ident_map.c                                   |   23 +
 block/bio.c                                               |    5 
 block/blk-mq.c                                            |   16 +
 crypto/algapi.c                                           |    1 
 drivers/acpi/acpi_extlog.c                                |    5 
 drivers/acpi/acpi_video.c                                 |    9 
 drivers/android/binder.c                                  |   10 
 drivers/atm/idt77252.c                                    |    2 
 drivers/base/core.c                                       |   44 +++
 drivers/base/power/domain.c                               |    2 
 drivers/char/hw_random/core.c                             |   34 +-
 drivers/clk/hisilicon/clk-hi3620.c                        |    4 
 drivers/clk/mmp/clk-of-pxa168.c                           |    3 
 drivers/crypto/stm32/stm32_crc32.c                        |    2 
 drivers/firewire/core-device.c                            |    7 
 drivers/gpio/gpio-eic-sprd.c                              |   32 ++
 drivers/gpio/gpiolib-acpi.c                               |   14 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c          |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                |    1 
 drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c                  |    3 
 drivers/gpu/drm/bridge/nxp-ptn3460.c                      |    6 
 drivers/gpu/drm/drm_file.c                                |    2 
 drivers/gpu/drm/drm_framebuffer.c                         |    2 
 drivers/gpu/drm/drm_mipi_dsi.c                            |   17 +
 drivers/gpu/drm/drm_plane.c                               |    1 
 drivers/gpu/drm/exynos/exynos_drm_drv.c                   |   11 
 drivers/gpu/drm/exynos/exynos_drm_gsc.c                   |    2 
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c               |    5 
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h                   |    1 
 drivers/gpu/drm/nouveau/nouveau_vmm.c                     |    3 
 drivers/hid/hid-apple.c                                   |   63 ++++
 drivers/hid/hid-ids.h                                     |    1 
 drivers/hid/hid-quirks.c                                  |    1 
 drivers/hid/wacom_sys.c                                   |   63 +++-
 drivers/hid/wacom_wac.c                                   |    9 
 drivers/hwmon/aspeed-pwm-tacho.c                          |    7 
 drivers/hwmon/coretemp.c                                  |   40 +--
 drivers/infiniband/ulp/ipoib/ipoib_multicast.c            |    7 
 drivers/input/keyboard/atkbd.c                            |   13 -
 drivers/irqchip/irq-brcmstb-l2.c                          |    3 
 drivers/leds/trigger/ledtrig-panic.c                      |    5 
 drivers/md/md.c                                           |   54 +++-
 drivers/md/raid5.c                                        |   12 
 drivers/media/pci/ddbridge/ddbridge-main.c                |    2 
 drivers/media/platform/rockchip/rga/rga.c                 |   15 -
 drivers/media/usb/stk1160/stk1160-video.c                 |    5 
 drivers/mfd/Kconfig                                       |    1 
 drivers/net/bonding/bond_alb.c                            |    3 
 drivers/net/ethernet/aquantia/atlantic/aq_nic.c           |    1 
 drivers/net/ethernet/cisco/enic/enic_ethtool.c            |    1 
 drivers/net/ethernet/freescale/fec_main.c                 |    2 
 drivers/net/ethernet/intel/i40e/i40e_main.c               |    2 
 drivers/net/ethernet/intel/ixgbe/ixgbe_82598.c            |   36 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c            |   61 ++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_common.c           |  177 ++++++--------
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c          |    2 
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c             |   44 +--
 drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.c              |   34 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.h              |    1 
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c              |  105 ++++----
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h              |    2 
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c            |    2 
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h             |   51 ----
 drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c             |   45 +--
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c             |  149 ++++++-----
 drivers/net/ethernet/mellanox/mlx5/core/en_arfs.c         |   26 +-
 drivers/net/ethernet/netronome/nfp/nfpcore/nfp6000_pcie.c |    6 
 drivers/net/fjes/fjes_hw.c                                |   37 ++
 drivers/net/ppp/ppp_async.c                               |    4 
 drivers/net/virtio_net.c                                  |    9 
 drivers/net/wan/lmc/lmc_proto.c                           |    4 
 drivers/net/wireless/ath/ath9k/htc_drv_txrx.c             |    5 
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c     |   12 
 drivers/net/wireless/realtek/rtlwifi/rtl8723ae/phy.c      |    6 
 drivers/net/wireless/realtek/rtlwifi/rtl8723be/phy.c      |    4 
 drivers/net/xen-netback/netback.c                         |   84 +++---
 drivers/pci/controller/pcie-mediatek.c                    |   10 
 drivers/pci/quirks.c                                      |   24 +
 drivers/phy/ti/phy-omap-usb2.c                            |    4 
 drivers/pnp/pnpacpi/rsparser.c                            |   12 
 drivers/rpmsg/virtio_rpmsg_bus.c                          |    1 
 drivers/scsi/fcoe/fcoe_ctlr.c                             |   20 -
 drivers/scsi/isci/request.c                               |    2 
 drivers/scsi/libfc/fc_fcp.c                               |   18 -
 drivers/scsi/lpfc/lpfc.h                                  |    1 
 drivers/scsi/lpfc/lpfc_init.c                             |    4 
 drivers/spi/spi-ppc4xx.c                                  |    5 
 drivers/staging/iio/impedance-analyzer/ad5933.c           |    2 
 drivers/tty/serial/max310x.c                              |   21 +
 drivers/tty/serial/sc16is7xx.c                            |    8 
 drivers/usb/core/hub.c                                    |   34 +-
 drivers/usb/gadget/function/f_mass_storage.c              |   20 +
 drivers/usb/serial/cp210x.c                               |    1 
 drivers/usb/serial/option.c                               |    1 
 drivers/usb/serial/qcserial.c                             |    2 
 drivers/vhost/vhost.c                                     |    5 
 fs/afs/server.c                                           |    7 
 fs/btrfs/extent-tree.c                                    |    3 
 fs/btrfs/ioctl.c                                          |    9 
 fs/btrfs/send.c                                           |    2 
 fs/ceph/caps.c                                            |    9 
 fs/compat_ioctl.c                                         |    3 
 fs/dcache.c                                               |    7 
 fs/ext4/mballoc.c                                         |   26 +-
 fs/ext4/move_extent.c                                     |    6 
 fs/ext4/resize.c                                          |   37 +-
 fs/f2fs/recovery.c                                        |   23 +
 fs/jfs/jfs_dmap.c                                         |   57 ++--
 fs/jfs/jfs_dtree.c                                        |    7 
 fs/jfs/jfs_imap.c                                         |    3 
 fs/jfs/jfs_mount.c                                        |    6 
 fs/nilfs2/file.c                                          |    8 
 fs/nilfs2/recovery.c                                      |    7 
 fs/nilfs2/segment.c                                       |    8 
 fs/pstore/ram.c                                           |    1 
 include/drm/drm_mipi_dsi.h                                |    2 
 include/linux/bpf.h                                       |    6 
 include/linux/device.h                                    |    3 
 include/linux/dmaengine.h                                 |    3 
 include/linux/hrtimer.h                                   |    4 
 include/linux/lsm_hooks.h                                 |    9 
 include/linux/pci_ids.h                                   |    1 
 include/linux/security.h                                  |    9 
 include/linux/spi/spi.h                                   |    1 
 include/linux/syscalls.h                                  |    1 
 include/linux/units.h                                     |   92 +++++++
 include/net/af_unix.h                                     |   20 +
 include/net/llc_pdu.h                                     |    6 
 include/uapi/linux/btrfs.h                                |    3 
 include/uapi/linux/netfilter/nf_tables.h                  |    2 
 kernel/audit.c                                            |   31 +-
 kernel/bpf/arraymap.c                                     |   12 
 kernel/bpf/hashtab.c                                      |    6 
 kernel/bpf/map_in_map.c                                   |    2 
 kernel/bpf/map_in_map.h                                   |    2 
 kernel/power/swap.c                                       |   38 +--
 kernel/sched/membarrier.c                                 |    6 
 kernel/time/hrtimer.c                                     |    3 
 kernel/time/tick-sched.c                                  |    5 
 kernel/trace/ring_buffer.c                                |    2 
 kernel/trace/trace_events_trigger.c                       |    6 
 kernel/trace/tracing_map.c                                |    7 
 mm/page-writeback.c                                       |    2 
 net/8021q/vlan_netlink.c                                  |    4 
 net/ipv4/af_inet.c                                        |    6 
 net/ipv4/ip_output.c                                      |   12 
 net/ipv4/tcp.c                                            |    1 
 net/ipv6/addrconf_core.c                                  |   21 +
 net/iucv/af_iucv.c                                        |   14 -
 net/llc/af_llc.c                                          |   26 +-
 net/llc/llc_core.c                                        |    7 
 net/netfilter/nf_log.c                                    |    7 
 net/netfilter/nf_tables_api.c                             |   20 -
 net/netfilter/nft_byteorder.c                             |    5 
 net/netfilter/nft_compat.c                                |   11 
 net/netlink/af_netlink.c                                  |    2 
 net/nfc/nci/core.c                                        |    4 
 net/rds/af_rds.c                                          |    2 
 net/rxrpc/conn_event.c                                    |    8 
 net/rxrpc/conn_service.c                                  |    3 
 net/sched/sch_cbs.c                                       |   30 +-
 net/smc/smc_diag.c                                        |    2 
 net/sunrpc/xprtmultipath.c                                |   17 +
 net/tipc/bearer.c                                         |    6 
 net/unix/af_unix.c                                        |   14 -
 net/unix/diag.c                                           |    2 
 net/wireless/scan.c                                       |    4 
 security/security.c                                       |   17 +
 security/selinux/hooks.c                                  |   28 ++
 security/smack/smack_lsm.c                                |    1 
 security/tomoyo/tomoyo.c                                  |    1 
 sound/pci/hda/hda_intel.c                                 |    2 
 sound/pci/hda/patch_conexant.c                            |   18 +
 sound/soc/codecs/rt5645.c                                 |    1 
 tools/lib/subcmd/help.c                                   |   18 +
 211 files changed, 1781 insertions(+), 998 deletions(-)

Akinobu Mita (1):
      include/linux/units.h: add helpers for kelvin to/from Celsius conversion

Al Viro (1):
      fast_dput(): handle underflows gracefully

Aleksander Mazur (1):
      x86/Kconfig: Transmeta Crusoe is CPU family 5, not 6

Alex Henrie (1):
      HID: apple: Add support for the 2021 Magic Keyboard

Alex Lyakas (1):
      md: Whenassemble the array, consult the superblock of the freshest device

Alexander Stein (2):
      ARM: dts: imx7s: Fix lcdif compatible
      ARM: dts: imx7s: Fix nand-controller #size-cells

Alexey Khoroshilov (1):
      ASoC: rt5645: Fix deadlock in rt5645_jack_detect_work()

Alfred Piccioni (1):
      lsm: new security_file_ioctl_compat() hook

Andrzej Hajda (1):
      driver core: add device probe log helper

Andy Shevchenko (1):
      driver core: Annotate dev_err_probe() with __must_check

Anna Schumaker (1):
      SUNRPC: Fix a suspicious RCU usage warning

Anton Ivanov (1):
      um: Fix naming clash between UML and scheduler

Baokun Li (4):
      ext4: unify the type of flexbg_size to unsigned int
      ext4: remove unnecessary check from alloc_flex_gd()
      ext4: avoid online resizing failures due to oversized flex bg
      ext4: fix double-free of blocks due to wrong extents moved_len

Benjamin Berg (3):
      wifi: cfg80211: free beacon_ies when overridden from hidden BSS
      um: Don't use vfprintf() for os_info()
      HID: apple: Add 2021 magic keyboard FN key mapping

Boris Burkov (1):
      btrfs: forbid creating subvol qgroups

Breno Leitao (2):
      net: sysfs: Fix /sys/class/net/<iface> path
      net: sysfs: Fix /sys/class/net/<iface> path for statistics

Carlos Llamas (1):
      binder: signal epoll threads of self-work

Chao Yu (1):
      f2fs: fix to check return value of f2fs_reserve_new_block()

Chris Riches (1):
      audit: Send netlink ACK before setting connection in auditd_set

Christophe JAILLET (1):
      ixgbe: Fix an error handling path in ixgbe_read_iosf_sb_reg_x550()

Cristian Ciocaltea (1):
      ASoC: doc: Fix undefined SND_SOC_DAPM_NOPM argument

Dan Carpenter (3):
      drm/bridge: nxp-ptn3460: fix i2c_master_send() error checking
      drm/bridge: nxp-ptn3460: simplify some error checking
      netfilter: nf_tables: fix pointer math issue in nft_byteorder_eval()

Daniel Basilio (1):
      nfp: use correct macro for LengthSelect in BAR config

Daniel Lezcano (3):
      units: Add Watt units
      units: change from 'L' to 'UL'
      units: add the HZ macros

Daniel Vacek (1):
      IB/ipoib: Fix mcast list locking

Dave Airlie (1):
      nouveau/vmm: don't set addr on the fail path to avoid warning

David Howells (1):
      rxrpc: Fix response to PING RESPONSE ACKs to a dead call

David Schiller (1):
      staging: iio: ad5933: fix type mismatch regression

David Sterba (2):
      btrfs: don't warn if discard range is not aligned to sector
      btrfs: send: return EOPNOTSUPP on unknown flags

Denis Efremov (1):
      net/mlx5: Use kfree(ft->g) in arfs_create_groups()

Dmitry Antipov (1):
      PNP: ACPI: fix fortify warning

Doug Berger (1):
      irqchip/irq-brcmstb-l2: Add write memory barrier before exit

Douglas Anderson (1):
      drm/exynos: Call drm_atomic_helper_shutdown() at shutdown/unbind time

Edward Adam Davis (3):
      jfs: fix uaf in jfs_evict_inode
      jfs: fix array-index-out-of-bounds in diNewExt
      wifi: cfg80211: fix RCU dereference in __cfg80211_bss_update

Eric Dumazet (5):
      llc: make llc_ui_sendmsg() more robust against bonding changes
      llc: call sock_orphan() at release time
      af_unix: fix lockdep positive in sk_diag_dump_icons()
      inet: read sk->sk_family once in inet_recv_error()
      ppp_async: limit MRU to 64K

Fabio Estevam (7):
      ARM: dts: imx25/27-eukrea: Fix RTC node name
      ARM: dts: imx: Use flash@0,0 pattern
      ARM: dts: imx27: Fix sram node
      ARM: dts: imx1: Fix sram node
      ARM: dts: imx27-apf27dev: Fix LED name
      ARM: dts: imx23-sansa: Use preferred i2c-gpios properties
      ARM: dts: imx23/28: Fix the DMA controller node name

Fedor Pchelkin (2):
      drm/exynos: gsc: minor fix for loop iteration in gsc_runtime_resume
      nfc: nci: free rx_data_reassembly skb on NCI device cleanup

Felix Kuehling (1):
      drm/amdgpu: Let KFD sync with VM fences

Florian Westphal (2):
      netfilter: nf_tables: restrict anonymous set and map names to 16 bytes
      netfilter: nf_tables: reject QUEUE/DROP verdict parameters

Frank Li (1):
      dmaengine: fix is_slave_direction() return false when DMA_DEV_TO_DEV

Frederic Weisbecker (1):
      hrtimer: Report offline hrtimer enqueue

Ghanshyam Agrawal (1):
      media: stk1160: Fixed high volume of stk1160_dbg messages

Greg Kroah-Hartman (2):
      Revert "driver core: Annotate dev_err_probe() with __must_check"
      Linux 4.19.307

Guenter Roeck (1):
      MIPS: Add 'memory' clobber to csum_ipv6_magic() inline assembler

Guilherme G. Piccoli (1):
      PCI: Only override AMD USB controller if required

Hannes Reinecke (2):
      scsi: libfc: Don't schedule abort twice
      scsi: libfc: Fix up timeout error in fc_fcp_rec_error()

Hans de Goede (1):
      Input: atkbd - skip ATKBD_CMD_SETLEDS when skipping ATKBD_CMD_GETID

Hardik Gajjar (1):
      usb: hub: Replace hardcoded quirk value with BIT() macro

Heiko Carstens (2):
      s390/ptrace: handle setting of fpc register correctly
      KVM: s390: fix setting of fpc register

Heiner Kallweit (1):
      leds: trigger: panic: Don't register panic notifier if creating the trigger failed

Helge Deller (2):
      parisc/firmware: Fix F-extend for PDC addresses
      ipv6: Ensure natural alignment of const ipv6 loopback and router addresses

Herbert Xu (2):
      crypto: api - Disallow identical driver names
      hwrng: core - Fix page fault dead lock on mmap-ed hwrng

Hongchen Zhang (1):
      PM: hibernate: Enforce ordering during image compression/decompression

Hou Tao (1):
      bpf: Add map and need_defer parameters to .map_fd_put_ptr()

Hugo Villeneuve (4):
      serial: sc16is7xx: set safe default SPI clock frequency
      serial: sc16is7xx: add check for unsupported SPI modes during probe
      serial: max310x: set default value when reading clock ready bit
      serial: max310x: improve crystal stable clock detection

Ian Rogers (1):
      libsubcmd: Fix memory leak in uniq()

Ido Schimmel (1):
      PCI: Add no PM reset quirk for NVIDIA Spectrum devices

Ivan Vecera (1):
      i40e: Fix waiting for queues of all VSIs to be disabled

Jack Wang (1):
      RDMA/IPoIB: Fix error code return in ipoib_mcast_join

JackBB Wu (1):
      USB: serial: qcserial: add new usb-id for Dell Wireless DW5826e

Jan Beulich (1):
      xen-netback: properly sync TX responses

Jason Gerecke (1):
      HID: wacom: Do not register input devices until after hid_hw_start

Jedrzej Jagielski (2):
      ixgbe: Refactor returning internal error codes
      ixgbe: Refactor overtemp event handling

Johan Jonker (1):
      ARM: dts: rockchip: fix rk3036 hdmi ports node

Julian Wiedmann (2):
      net/af_iucv: clean up a try_then_request_module()
      Documentation: net-sysfs: describe missing statistics

Junxiao Bi (1):
      Revert "md/raid5: Wait for MD_SB_CHANGE_PENDING in raid5d"

Justin Tee (1):
      scsi: lpfc: Fix possible file string name overflow when updating firmware

Konrad Dybcio (1):
      pmdomain: core: Move the unused cleanup to a _sync initcall

Kuan-Wei Chiu (2):
      clk: hi3620: Fix memory leak in hi3620_mmc_clk_init()
      clk: mmp: pxa168: Fix memory leak in pxa168_clk_init()

Kuniyuki Iwashima (1):
      llc: Drop support for ETH_P_TR_802_2.

Kunwu Chan (1):
      powerpc/mm: Fix null-pointer dereference in pgtable_cache_add

Lee Duncan (1):
      scsi: Revert "scsi: fcoe: Fix potential deadlock on &fip->ctlr_lock"

Leonard Dallmayr (1):
      USB: serial: cp210x: add ID for IMST iM871A-USB

Lin Ma (1):
      vlan: skip nested type that is not IFLA_VLAN_QOS_MAPPING

Linus Torvalds (1):
      sched/membarrier: reduce the ability to hammer on sys_membarrier

Loic Prylli (1):
      hwmon: (aspeed-pwm-tacho) mutex for tach reading

Maciej S. Szmigiero (1):
      x86/CPU/AMD: Fix disabling XSAVES on AMD family 0x17 due to erratum

Manas Ghandat (2):
      jfs: fix slab-out-of-bounds Read in dtSearch
      jfs: fix array-index-out-of-bounds in dbAdjTree

Mario Limonciello (1):
      gpiolib: acpi: Ignore touchpad wakeup on GPD G1619-04

Masami Hiramatsu (Google) (1):
      tracing/trigger: Fix to return error if failed to alloc snapshot

Matthew Wilcox (Oracle) (1):
      block: Remove special-casing of compound pages

Mauro Carvalho Chehab (1):
      drivers: core: fix kernel-doc markup for dev_err_probe()

Michael Ellerman (2):
      powerpc: Fix build error due to is_valid_bugaddr()
      powerpc/mm: Fix build failures due to arch_reserved_kernel_pages()

Michael Tretter (1):
      media: rockchip: rga: fix swizzling for RGB formats

Michał Mirosław (1):
      driver code: print symbolic error code

Ming Lei (1):
      blk-mq: fix IO hang from sbitmap wakeup race

Minsuk Kang (1):
      wifi: ath9k: Fix potential array-index-out-of-bounds read in ath9k_htc_txstatus()

Nathan Chancellor (2):
      powerpc: Use always instead of always-y in for crtsavres.o
      um: net: Fix return type of uml_net_start_xmit()

Naveen N Rao (1):
      powerpc/lib: Validate size for vector operations

Oleg Nesterov (2):
      afs: fix the usage of read_seqbegin_or_lock() in afs_find_server*()
      rxrpc_find_service_conn_rcu: fix the usage of read_seqbegin_or_lock()

Oleksij Rempel (1):
      spi: introduce SPI_MODE_X_MASK macro

Oliver Neukum (1):
      USB: hub: check for alternate port before enabling A_ALT_HNP_SUPPORT

Osama Muhammad (2):
      FS:JFS:UBSAN:array-index-out-of-bounds in dbAdjTree
      UBSAN: array-index-out-of-bounds in dtSplitRoot

Pablo Neira Ayuso (3):
      netfilter: nf_log: replace BUG_ON by WARN_ON_ONCE when putting logger
      netfilter: nft_compat: reject unused compat flag
      netfilter: nft_compat: restrict match/target protocol to u16

Peter Robinson (1):
      mfd: ti_am335x_tscadc: Fix TI SoC dependencies

Petr Pavlu (1):
      tracing: Ensure visibility when inserting an element into tracing_map

Pierre-Louis Bossart (2):
      PCI: add INTEL_HDA_ARL to pci_ids.h
      ALSA: hda: Intel: add HDA_ARL PCI ID support

Piotr Skajewski (1):
      ixgbe: Remove non-inclusive language

Prarit Bhargava (1):
      ACPI: extlog: fix NULL pointer dereference check

Prathu Baronia (1):
      vhost: use kzalloc() instead of kmalloc() followed by memset()

Puliang Lu (1):
      USB: serial: option: add Fibocom FM101-GL variant

Qu Wenruo (1):
      btrfs: defrag: reject unknown flags of btrfs_ioctl_defrag_range_args

Richard Palethorpe (1):
      x86/entry/ia32: Ensure s32 is sign extended to s64

Rob Clark (1):
      drm/msm/dpu: Ratelimit framedone timeout msgs

Ryusuke Konishi (3):
      nilfs2: fix data corruption in dsync block recovery for small block sizes
      nilfs2: fix hang in nilfs_lookup_dirty_data_buffers()
      nilfs2: fix potential bug in end_buffer_async_write

Salvatore Dipietro (1):
      tcp: Add memory barrier to tcp_push()

Sharath Srinivasan (1):
      net/rds: Fix UBSAN: array-index-out-of-bounds in rds_cmsg_recv

Shenwei Wang (1):
      net: fec: fix the unhandled context fault from smmu

Shigeru Yoshida (1):
      tipc: Check the bearer type before calling tipc_udp_nl_bearer_add()

Srinivasan Shanmugam (2):
      drm/amdgpu: Drop 'fence' check in 'to_amdgpu_amdkfd_fence()'
      drm/amdgpu: Release 'adev->pm.fw' before return in 'amdgpu_device_need_post()'

Steve Wahl (1):
      x86/mm/ident_map: Use gbpages only where full GB page should be mapped.

Su Hui (3):
      wifi: rtlwifi: rtl8723{be,ae}: using calculate_bit_shift()
      media: ddbridge: fix an error code problem in ddb_probe
      scsi: isci: Fix an error code problem in isci_io_request_build()

Suraj Jitindar Singh (1):
      ext4: allow for the last group to be marked as trimmed

Takashi Sakamoto (1):
      firewire: core: correct documentation of fw_csr_string() kernel API

Tatsunosuke Tobita (1):
      HID: wacom: generic: Avoid reporting a serial of '0' to userspace

Thomas Bourgoin (1):
      crypto: stm32/crc32 - fix parsing list of devices

Tim Chen (1):
      tick/sched: Preserve number of idle sleeps across CPU hotplug events

Tom Rix (1):
      net: remove unneeded break

Tomi Valkeinen (3):
      drm/drm_file: fix use of uninitialized variable
      drm/framebuffer: Fix use of uninitialized variable
      drm/mipi-dsi: Fix detach call without attach

Tony Lindgren (1):
      phy: ti: phy-omap-usb2: Fix NULL pointer dereference for SRP

Uwe Kleine-König (1):
      spi: ppc4xx: Drop write-only variable

Ville Syrjälä (1):
      drm: Don't unref the same fb many times by mistake due to deadlock handling

Vincent Donnefort (1):
      ring-buffer: Clean ring_buffer_poll_wait() error return

Vinicius Costa Gomes (1):
      net/sched: cbs: Fix not adding cbs instance to list

Weichen Chen (1):
      pstore/ram: Fix crash when setting number of cpus to an odd number

Wen Gu (1):
      net/smc: fix illegal rmb_desc access in SMC-D connection dump

Wenhua Lin (1):
      gpio: eic-sprd: Clear interrupt after set the interrupt type

Xi Ruoyao (1):
      mips: Call lose_fpu(0) before initializing fcr31 in mips_set_personality_nan

Xiaolei Wang (1):
      rpmsg: virtio: Free driver_override when rpmsg_remove()

Xiubo Li (1):
      ceph: fix deadlock or deadcode of misusing dget()

Ye Bin (1):
      ext4: fix inconsistent between segment fstrim and full fstrim

Yuluo Qiu (1):
      ACPI: video: Add quirk for the Colorful X15 AT 23 Laptop

Zach O'Keefe (1):
      mm/writeback: fix possible divide-by-zero in wb_dirty_limits(), again

Zenm Chen (1):
      wifi: rtl8xxxu: Add additional USB IDs for RTL8192EU devices

Zhang Rui (2):
      hwmon: (coretemp) Fix out-of-bounds memory access
      hwmon: (coretemp) Fix bogus core_id to attr name mapping

Zhengchao Shao (3):
      netlink: fix potential sleeping issue in mqueue_flush_file
      bonding: return -ENOMEM instead of BUG in alb_upper_dev_walk
      bonding: remove print in bond_verify_device_path

Zhipeng Lu (4):
      net/mlx5e: fix a double-free in arfs_create_groups
      fjes: fix memleaks in fjes_hw_setup
      net: ipv4: fix a memleak in ip_setup_cork
      atm: idt77252: fix a memleak in open_card_ubr0

Zhu Yanjun (1):
      virtio_net: Fix "‘%d’ directive writing between 1 and 11 bytes into a region of size 10" warnings

bo liu (1):
      ALSA: hda/conexant: Add quirk for SWS JS201D

free5lot (1):
      HID: apple: Swap the Fn and Left Control keys on Apple keyboards

qizhong cheng (1):
      PCI: mediatek: Clear interrupt status before dispatching handler

yuan linyu (1):
      usb: f_mass_storage: forbid async queue when shutdown happen


