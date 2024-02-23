Return-Path: <linux-kernel+bounces-77876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34CF3860B62
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 08:41:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C66E286952
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 07:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CDE714A97;
	Fri, 23 Feb 2024 07:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ayrx/GJO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7FF15AF9;
	Fri, 23 Feb 2024 07:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708674044; cv=none; b=OZHgVHW953IVpRDKa1j6ENlz8HCD3xPtPJW5LBVkysWbJ09+c3u+EV5Mns1tnTzw0UcgaST5OP/OubhUGXmZEZg48lG1PLpIlMLgqNqX2KXdZl9Eh3ZP4ONPxwfvr8NKhscHt7DN8/lOcFPYv5qjW0aN0wO7scAsZW1NIBNwoVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708674044; c=relaxed/simple;
	bh=aEf10Dc1wUMnd1yHvc/i0Ps/8qto5co1GhaUnTczjsM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kWa2m7TXHGWXbuAZl07gxgFBTSQTOSAUBtRWnmfqXLrvedH3UgMVufiPvccTRXdH7fQtMTya9KKpr98kRzAhYdtewngTHEG8y8YD+Ae8XKpcaCquYpD8T/PQr3rxgcHe33P7gEStXDKxavrOjKEb/0h+AbDL9mLqb0QLssMD4YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ayrx/GJO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D67EC43390;
	Fri, 23 Feb 2024 07:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708674044;
	bh=aEf10Dc1wUMnd1yHvc/i0Ps/8qto5co1GhaUnTczjsM=;
	h=From:To:Cc:Subject:Date:From;
	b=Ayrx/GJOrQHZQAvHQbuSKTufRRxVUzQmLLZ2UyxsW83vXtEszj38/jDvaMgxCWsyt
	 TX0Rfc/8fIUAnbB3rSX/jTc5Hc9gvyQXs41hpC5Aq2Qe3EB/iHfaM8jE2YlNZfoEmg
	 RicRM4kWLBG4j4EzpIR2gGZTbA+4iaLPQkhRNKlM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.4.269
Date: Fri, 23 Feb 2024 08:40:39 +0100
Message-ID: <2024022339-shadily-sustainer-39ba@gregkh>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 5.4.269 kernel.

All users of the 5.4 kernel series must upgrade.

The updated 5.4.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.4.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/ABI/testing/sysfs-class-net-queues                |   22 
 Documentation/filesystems/directory-locking.rst                 |   25 
 Documentation/filesystems/locking.rst                           |    5 
 Documentation/filesystems/porting.rst                           |   18 
 Documentation/sound/soc/dapm.rst                                |    2 
 Makefile                                                        |    2 
 arch/arm/boot/dts/imx1-ads.dts                                  |    2 
 arch/arm/boot/dts/imx1-apf9328.dts                              |    2 
 arch/arm/boot/dts/imx1.dtsi                                     |    5 
 arch/arm/boot/dts/imx23-sansa.dts                               |   12 
 arch/arm/boot/dts/imx23.dtsi                                    |    2 
 arch/arm/boot/dts/imx25-eukrea-cpuimx25.dtsi                    |    2 
 arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-cmo-qvga.dts |    2 
 arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-dvi-svga.dts |    2 
 arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-dvi-vga.dts  |    2 
 arch/arm/boot/dts/imx25-pdk.dts                                 |    2 
 arch/arm/boot/dts/imx27-apf27dev.dts                            |    4 
 arch/arm/boot/dts/imx27-eukrea-cpuimx27.dtsi                    |    4 
 arch/arm/boot/dts/imx27-eukrea-mbimxsd27-baseboard.dts          |    2 
 arch/arm/boot/dts/imx27-phytec-phycard-s-rdk.dts                |    2 
 arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts                  |    2 
 arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi                 |    2 
 arch/arm/boot/dts/imx27.dtsi                                    |    3 
 arch/arm/boot/dts/imx28.dtsi                                    |    2 
 arch/arm/boot/dts/imx7d.dtsi                                    |    3 
 arch/arm/boot/dts/imx7s.dtsi                                    |   10 
 arch/arm/boot/dts/rk3036.dtsi                                   |   14 
 arch/arm64/boot/dts/qcom/msm8996.dtsi                           |   21 
 arch/arm64/boot/dts/qcom/msm8998.dtsi                           |   32 -
 arch/arm64/boot/dts/qcom/sdm845.dtsi                            |    8 
 arch/ia64/kernel/topology.c                                     |    5 
 arch/ia64/mm/numa.c                                             |    5 
 arch/mips/include/asm/checksum.h                                |    3 
 arch/mips/include/asm/mmzone.h                                  |    6 
 arch/mips/kernel/elf.c                                          |    6 
 arch/mips/mm/init.c                                             |   15 
 arch/nds32/include/asm/memory.h                                 |    6 
 arch/parisc/kernel/firmware.c                                   |    4 
 arch/powerpc/include/asm/mmu.h                                  |    4 
 arch/powerpc/include/asm/mmzone.h                               |    3 
 arch/powerpc/kernel/traps.c                                     |    2 
 arch/powerpc/lib/Makefile                                       |    4 
 arch/powerpc/lib/sstep.c                                        |   10 
 arch/powerpc/mm/book3s64/pgtable.c                              |    2 
 arch/powerpc/mm/init-common.c                                   |    5 
 arch/s390/kernel/ptrace.c                                       |    6 
 arch/s390/kvm/kvm-s390.c                                        |    5 
 arch/um/drivers/net_kern.c                                      |    2 
 arch/um/include/shared/kern_util.h                              |    2 
 arch/um/kernel/process.c                                        |    2 
 arch/um/os-Linux/helper.c                                       |    6 
 arch/um/os-Linux/util.c                                         |   19 
 arch/x86/Kconfig.cpu                                            |    2 
 arch/x86/include/asm/syscall_wrapper.h                          |   25 
 arch/x86/kernel/cpu/amd.c                                       |   20 
 arch/x86/kernel/cpu/mce/core.c                                  |   16 
 arch/x86/mm/ident_map.c                                         |   23 
 arch/xtensa/include/asm/page.h                                  |    4 
 block/bio.c                                                     |    9 
 block/blk-mq.c                                                  |   16 
 crypto/algapi.c                                                 |    1 
 drivers/acpi/acpi_extlog.c                                      |    5 
 drivers/acpi/acpi_video.c                                       |    9 
 drivers/android/binder.c                                        |   10 
 drivers/atm/idt77252.c                                          |    2 
 drivers/base/power/domain.c                                     |    2 
 drivers/base/power/runtime.c                                    |   22 
 drivers/block/rbd.c                                             |   22 
 drivers/bus/moxtet.c                                            |    7 
 drivers/char/hw_random/core.c                                   |   34 -
 drivers/clk/hisilicon/clk-hi3620.c                              |    4 
 drivers/clk/mmp/clk-of-pxa168.c                                 |    3 
 drivers/crypto/stm32/stm32-crc32.c                              |    2 
 drivers/dma/fsl-qdma.c                                          |   27 -
 drivers/firewire/core-device.c                                  |    7 
 drivers/gpio/gpio-eic-sprd.c                                    |   32 +
 drivers/gpio/gpiolib-acpi.c                                     |   14 
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c                |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                      |    1 
 drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c                        |    3 
 drivers/gpu/drm/bridge/nxp-ptn3460.c                            |    6 
 drivers/gpu/drm/drm_file.c                                      |    2 
 drivers/gpu/drm/drm_framebuffer.c                               |    2 
 drivers/gpu/drm/drm_mipi_dsi.c                                  |   17 
 drivers/gpu/drm/drm_plane.c                                     |    1 
 drivers/gpu/drm/exynos/exynos5433_drm_decon.c                   |    4 
 drivers/gpu/drm/exynos/exynos_drm_drv.c                         |   11 
 drivers/gpu/drm/exynos/exynos_drm_fimd.c                        |    4 
 drivers/gpu/drm/exynos/exynos_drm_gsc.c                         |    2 
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c                     |    5 
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h                         |    1 
 drivers/gpu/drm/msm/dsi/phy/dsi_phy.c                           |    4 
 drivers/gpu/drm/nouveau/nouveau_vmm.c                           |    3 
 drivers/hid/hid-apple.c                                         |   63 ++
 drivers/hid/hid-ids.h                                           |    1 
 drivers/hid/hid-quirks.c                                        |    1 
 drivers/hid/wacom_sys.c                                         |   63 +-
 drivers/hid/wacom_wac.c                                         |    9 
 drivers/hwmon/aspeed-pwm-tacho.c                                |    7 
 drivers/hwmon/coretemp.c                                        |   40 -
 drivers/i2c/busses/i2c-i801.c                                   |   19 
 drivers/i3c/master/i3c-master-cdns.c                            |    7 
 drivers/iio/magnetometer/rm3100-core.c                          |   10 
 drivers/infiniband/ulp/ipoib/ipoib_multicast.c                  |    7 
 drivers/input/keyboard/atkbd.c                                  |   13 
 drivers/irqchip/irq-brcmstb-l2.c                                |    5 
 drivers/leds/trigger/ledtrig-panic.c                            |    5 
 drivers/md/md.c                                                 |   54 +-
 drivers/md/raid5.c                                              |   12 
 drivers/media/pci/ddbridge/ddbridge-main.c                      |    2 
 drivers/media/platform/rockchip/rga/rga.c                       |   15 
 drivers/media/usb/stk1160/stk1160-video.c                       |    5 
 drivers/mfd/Kconfig                                             |    1 
 drivers/misc/fastrpc.c                                          |    2 
 drivers/mmc/core/block.c                                        |   46 +
 drivers/mmc/core/slot-gpio.c                                    |    6 
 drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c                      |    2 
 drivers/mtd/nand/spi/macronix.c                                 |    2 
 drivers/net/bonding/bond_alb.c                                  |    3 
 drivers/net/ethernet/aquantia/atlantic/aq_nic.c                 |    1 
 drivers/net/ethernet/broadcom/genet/bcmgenet.c                  |   22 
 drivers/net/ethernet/broadcom/genet/bcmgenet.h                  |    3 
 drivers/net/ethernet/broadcom/genet/bcmmii.c                    |    6 
 drivers/net/ethernet/cisco/enic/enic_ethtool.c                  |    1 
 drivers/net/ethernet/freescale/fec_main.c                       |    2 
 drivers/net/ethernet/intel/i40e/i40e_main.c                     |    2 
 drivers/net/ethernet/intel/ixgbe/ixgbe_82598.c                  |   36 -
 drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c                  |   61 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_common.c                 |  177 +++---
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c                |    2 
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c                   |   44 -
 drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.c                    |   34 -
 drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.h                    |    1 
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c                    |  105 ++-
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h                    |    2 
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c                  |    2 
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h                   |   51 -
 drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c                   |   45 -
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c                   |  149 ++---
 drivers/net/ethernet/mellanox/mlx5/core/en_arfs.c               |   26 
 drivers/net/ethernet/mellanox/mlx5/core/steering/dr_action.c    |    1 
 drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c         |    2 
 drivers/net/ethernet/netronome/nfp/nfpcore/nfp6000_pcie.c       |    6 
 drivers/net/ethernet/stmicro/stmmac/common.h                    |    1 
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h                  |    3 
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c             |   58 ++
 drivers/net/fjes/fjes_hw.c                                      |   37 +
 drivers/net/ppp/ppp_async.c                                     |    4 
 drivers/net/virtio_net.c                                        |    9 
 drivers/net/wan/lmc/lmc_proto.c                                 |    4 
 drivers/net/wireless/ath/ath9k/htc_drv_txrx.c                   |    5 
 drivers/net/wireless/ralink/rt2x00/rt2x00dev.c                  |    3 
 drivers/net/wireless/ralink/rt2x00/rt2x00mac.c                  |   11 
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c           |   12 
 drivers/net/wireless/realtek/rtlwifi/rtl8723ae/phy.c            |    6 
 drivers/net/wireless/realtek/rtlwifi/rtl8723be/phy.c            |    4 
 drivers/net/xen-netback/netback.c                               |   84 +--
 drivers/of/unittest-data/Makefile                               |    8 
 drivers/of/unittest-data/overlay_gpio_01.dts                    |   23 
 drivers/of/unittest-data/overlay_gpio_02a.dts                   |   16 
 drivers/of/unittest-data/overlay_gpio_02b.dts                   |   16 
 drivers/of/unittest-data/overlay_gpio_03.dts                    |   23 
 drivers/of/unittest-data/overlay_gpio_04a.dts                   |   16 
 drivers/of/unittest-data/overlay_gpio_04b.dts                   |   16 
 drivers/of/unittest.c                                           |  265 +++++++++-
 drivers/pci/controller/pcie-mediatek.c                          |   10 
 drivers/pci/pcie/aer.c                                          |    9 
 drivers/pci/quirks.c                                            |   24 
 drivers/pci/switch/switchtec.c                                  |   25 
 drivers/phy/renesas/phy-rcar-gen3-usb2.c                        |    4 
 drivers/phy/ti/phy-omap-usb2.c                                  |    4 
 drivers/pnp/pnpacpi/rsparser.c                                  |   12 
 drivers/regulator/core.c                                        |   56 +-
 drivers/rpmsg/virtio_rpmsg_bus.c                                |    1 
 drivers/scsi/fcoe/fcoe_ctlr.c                                   |   20 
 drivers/scsi/isci/request.c                                     |    2 
 drivers/scsi/libfc/fc_fcp.c                                     |   18 
 drivers/scsi/lpfc/lpfc.h                                        |    1 
 drivers/scsi/lpfc/lpfc_init.c                                   |    4 
 drivers/spi/spi-bcm-qspi.c                                      |    4 
 drivers/spi/spi-ppc4xx.c                                        |    5 
 drivers/staging/iio/impedance-analyzer/ad5933.c                 |    2 
 drivers/tty/serial/max310x.c                                    |   21 
 drivers/tty/serial/sc16is7xx.c                                  |    8 
 drivers/usb/core/hub.c                                          |   34 -
 drivers/usb/gadget/function/f_mass_storage.c                    |   20 
 drivers/usb/serial/cp210x.c                                     |    1 
 drivers/usb/serial/option.c                                     |    1 
 drivers/usb/serial/qcserial.c                                   |    2 
 drivers/vhost/vhost.c                                           |    5 
 fs/afs/dir.c                                                    |    8 
 fs/afs/server.c                                                 |    7 
 fs/btrfs/extent-tree.c                                          |    3 
 fs/btrfs/ioctl.c                                                |    9 
 fs/btrfs/qgroup.c                                               |   14 
 fs/btrfs/ref-verify.c                                           |    6 
 fs/btrfs/send.c                                                 |    2 
 fs/btrfs/tree-checker.c                                         |    2 
 fs/ceph/caps.c                                                  |    9 
 fs/compat_ioctl.c                                               |    3 
 fs/dcache.c                                                     |    7 
 fs/ecryptfs/inode.c                                             |    8 
 fs/ext4/mballoc.c                                               |   26 
 fs/ext4/move_extent.c                                           |    6 
 fs/ext4/resize.c                                                |   37 -
 fs/f2fs/recovery.c                                              |   23 
 fs/inode.c                                                      |   32 +
 fs/jfs/jfs_dmap.c                                               |   57 +-
 fs/jfs/jfs_dtree.c                                              |    7 
 fs/jfs/jfs_imap.c                                               |    3 
 fs/jfs/jfs_mount.c                                              |    6 
 fs/kernfs/dir.c                                                 |   12 
 fs/namei.c                                                      |  144 ++++-
 fs/nilfs2/file.c                                                |    8 
 fs/nilfs2/recovery.c                                            |    7 
 fs/nilfs2/segment.c                                             |    8 
 fs/ocfs2/namei.c                                                |    1 
 fs/pstore/ram.c                                                 |    1 
 fs/ubifs/dir.c                                                  |    2 
 include/drm/drm_mipi_dsi.h                                      |    2 
 include/linux/bpf.h                                             |    6 
 include/linux/dmaengine.h                                       |    3 
 include/linux/fs.h                                              |    1 
 include/linux/gfp.h                                             |    4 
 include/linux/hrtimer.h                                         |    4 
 include/linux/lsm_hooks.h                                       |    9 
 include/linux/netfilter/ipset/ip_set.h                          |    4 
 include/linux/pci_ids.h                                         |    1 
 include/linux/pm_runtime.h                                      |    9 
 include/linux/security.h                                        |    9 
 include/linux/spi/spi.h                                         |    1 
 include/linux/syscalls.h                                        |    1 
 include/linux/units.h                                           |   92 +++
 include/net/af_unix.h                                           |   20 
 include/net/llc_pdu.h                                           |    6 
 include/net/netfilter/nf_tables.h                               |    4 
 include/uapi/linux/btrfs.h                                      |    3 
 include/uapi/linux/netfilter/nf_tables.h                        |    2 
 kernel/audit.c                                                  |   31 -
 kernel/bpf/arraymap.c                                           |   12 
 kernel/bpf/hashtab.c                                            |    6 
 kernel/bpf/map_in_map.c                                         |    2 
 kernel/bpf/map_in_map.h                                         |    2 
 kernel/events/core.c                                            |   38 -
 kernel/power/swap.c                                             |   38 -
 kernel/sched/membarrier.c                                       |    9 
 kernel/time/hrtimer.c                                           |    3 
 kernel/time/tick-sched.c                                        |    5 
 kernel/trace/ring_buffer.c                                      |    2 
 kernel/trace/trace.c                                            |   78 +-
 kernel/trace/trace_events_trigger.c                             |    6 
 kernel/trace/tracing_map.c                                      |    7 
 mm/page-writeback.c                                             |    2 
 net/8021q/vlan_netlink.c                                        |    4 
 net/can/j1939/j1939-priv.h                                      |    1 
 net/can/j1939/socket.c                                          |   22 
 net/core/skbuff.c                                               |    3 
 net/ipv4/af_inet.c                                              |    6 
 net/ipv4/ip_output.c                                            |   12 
 net/ipv4/tcp.c                                                  |    1 
 net/ipv6/addrconf_core.c                                        |   21 
 net/iucv/af_iucv.c                                              |   14 
 net/llc/af_llc.c                                                |   26 
 net/llc/llc_core.c                                              |    7 
 net/netfilter/ipset/ip_set_bitmap_gen.h                         |   14 
 net/netfilter/ipset/ip_set_core.c                               |   39 +
 net/netfilter/ipset/ip_set_hash_gen.h                           |   19 
 net/netfilter/ipset/ip_set_list_set.c                           |   13 
 net/netfilter/nf_log.c                                          |    7 
 net/netfilter/nf_tables_api.c                                   |   20 
 net/netfilter/nft_byteorder.c                                   |    5 
 net/netfilter/nft_compat.c                                      |   23 
 net/netfilter/nft_ct.c                                          |   27 +
 net/netfilter/nft_flow_offload.c                                |    5 
 net/netfilter/nft_meta.c                                        |    2 
 net/netfilter/nft_nat.c                                         |    5 
 net/netfilter/nft_rt.c                                          |    5 
 net/netfilter/nft_set_rbtree.c                                  |    7 
 net/netfilter/nft_socket.c                                      |    5 
 net/netfilter/nft_synproxy.c                                    |    7 
 net/netfilter/nft_tproxy.c                                      |    5 
 net/netfilter/nft_xfrm.c                                        |    5 
 net/netlink/af_netlink.c                                        |    2 
 net/nfc/nci/core.c                                              |    4 
 net/rds/af_rds.c                                                |    2 
 net/rxrpc/conn_event.c                                          |    8 
 net/rxrpc/conn_service.c                                        |    3 
 net/smc/smc_diag.c                                              |    2 
 net/sunrpc/xprtmultipath.c                                      |   17 
 net/tipc/bearer.c                                               |    6 
 net/unix/af_unix.c                                              |   14 
 net/unix/diag.c                                                 |    2 
 net/wireless/scan.c                                             |    4 
 scripts/link-vmlinux.sh                                         |    9 
 security/security.c                                             |   17 
 security/selinux/hooks.c                                        |   28 +
 security/smack/smack_lsm.c                                      |    1 
 security/tomoyo/tomoyo.c                                        |    1 
 sound/pci/hda/hda_intel.c                                       |    2 
 sound/pci/hda/patch_conexant.c                                  |   18 
 sound/pci/hda/patch_realtek.c                                   |    1 
 sound/soc/codecs/rt5645.c                                       |    1 
 tools/lib/subcmd/help.c                                         |   18 
 tools/testing/selftests/bpf/progs/pyperf180.c                   |   22 
 tools/testing/selftests/bpf/test_btf.c                          |    1 
 tools/testing/selftests/net/pmtu.sh                             |   18 
 virt/kvm/arm/vgic/vgic-its.c                                    |    5 
 307 files changed, 2951 insertions(+), 1287 deletions(-)

Akinobu Mita (1):
      include/linux/units.h: add helpers for kelvin to/from Celsius conversion

Al Viro (2):
      rename(): fix the locking of subdirectories
      fast_dput(): handle underflows gracefully

Aleksander Mazur (1):
      x86/Kconfig: Transmeta Crusoe is CPU family 5, not 6

Alex Henrie (1):
      HID: apple: Add support for the 2021 Magic Keyboard

Alex Lyakas (1):
      md: Whenassemble the array, consult the superblock of the freshest device

Alexander Stein (4):
      ARM: dts: imx7d: Fix coresight funnel ports
      ARM: dts: imx7s: Fix lcdif compatible
      ARM: dts: imx7s: Fix nand-controller #size-cells
      mmc: slot-gpio: Allow non-sleeping GPIO ro

Alexey Khoroshilov (1):
      ASoC: rt5645: Fix deadlock in rt5645_jack_detect_work()

Alfred Piccioni (1):
      lsm: new security_file_ioctl_compat() hook

Andrii Nakryiko (1):
      selftests/bpf: satisfy compiler by having explicit return in btf test

Anna Schumaker (1):
      SUNRPC: Fix a suspicious RCU usage warning

Anton Ivanov (1):
      um: Fix naming clash between UML and scheduler

Arnd Bergmann (1):
      drm/exynos: fix accidental on-stack copy of exynos_drm_plane

Avri Altman (1):
      mmc: core: Use mrq.sbc in close-ended ffu

Baokun Li (4):
      ext4: unify the type of flexbg_size to unsigned int
      ext4: remove unnecessary check from alloc_flex_gd()
      ext4: avoid online resizing failures due to oversized flex bg
      ext4: fix double-free of blocks due to wrong extents moved_len

Benjamin Berg (3):
      wifi: cfg80211: free beacon_ies when overridden from hidden BSS
      um: Don't use vfprintf() for os_info()
      HID: apple: Add 2021 magic keyboard FN key mapping

Bjorn Helgaas (1):
      PCI/AER: Decode Requester ID when no error info found

Boris Burkov (2):
      btrfs: forbid creating subvol qgroups
      btrfs: forbid deleting live subvol qgroup

Breno Leitao (1):
      net: sysfs: Fix /sys/class/net/<iface> path

Carlos Llamas (1):
      binder: signal epoll threads of self-work

Chao Yu (1):
      f2fs: fix to check return value of f2fs_reserve_new_block()

Chris Riches (1):
      audit: Send netlink ACK before setting connection in auditd_set

Christian A. Ehrhardt (1):
      of: unittest: Fix compile in the non-dynamic case

Christoph Hellwig (1):
      block: prevent an integer overflow in bvec_try_merge_hw_page

Christophe JAILLET (3):
      ixgbe: Fix an error handling path in ixgbe_read_iosf_sb_reg_x550()
      dmaengine: fsl-qdma: Fix a memory leak related to the status queue DMA
      dmaengine: fsl-qdma: Fix a memory leak related to the queue command DMA

Chung-Chiang Cheng (1):
      btrfs: tree-checker: fix inline ref size in error messages

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

Daniel Stodden (1):
      PCI: switchtec: Fix stdev_release() crash after surprise hot remove

Daniel Vacek (1):
      IB/ipoib: Fix mcast list locking

Daniel de Villiers (1):
      nfp: flower: prevent re-adding mac index for bonded port

Dave Airlie (1):
      nouveau/vmm: don't set addr on the fail path to avoid warning

David Howells (2):
      afs: Hide silly-rename files from userspace
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

Dmitry Baryshkov (1):
      PM: runtime: add devm_pm_runtime_enable helper

Doug Berger (1):
      irqchip/irq-brcmstb-l2: Add write memory barrier before exit

Douglas Anderson (2):
      drm/exynos: Call drm_atomic_helper_shutdown() at shutdown/unbind time
      PM: runtime: Have devm_pm_runtime_enable() handle pm_runtime_dont_use_autosuspend()

Edson Juliano Drosdeck (1):
      ALSA: hda/realtek: Enable headset mic on Vaio VJFE-ADL

Edward Adam Davis (3):
      jfs: fix uaf in jfs_evict_inode
      jfs: fix array-index-out-of-bounds in diNewExt
      wifi: cfg80211: fix RCU dereference in __cfg80211_bss_update

Ekansh Gupta (1):
      misc: fastrpc: Mark all sessions as invalid in cb_remove

Eric Dumazet (6):
      llc: make llc_ui_sendmsg() more robust against bonding changes
      llc: call sock_orphan() at release time
      af_unix: fix lockdep positive in sk_diag_dump_icons()
      inet: read sk->sk_family once in inet_recv_error()
      ppp_async: limit MRU to 64K
      net: prevent mss overflow in skb_segment()

Fabio Estevam (8):
      ARM: dts: imx25/27-eukrea: Fix RTC node name
      ARM: dts: imx: Use flash@0,0 pattern
      ARM: dts: imx27: Fix sram node
      ARM: dts: imx1: Fix sram node
      ARM: dts: imx25/27: Pass timing0
      ARM: dts: imx27-apf27dev: Fix LED name
      ARM: dts: imx23-sansa: Use preferred i2c-gpios properties
      ARM: dts: imx23/28: Fix the DMA controller node name

Fedor Pchelkin (3):
      btrfs: ref-verify: free ref cache before clearing mount opt
      drm/exynos: gsc: minor fix for loop iteration in gsc_runtime_resume
      nfc: nci: free rx_data_reassembly skb on NCI device cleanup

Felix Kuehling (1):
      drm/amdgpu: Let KFD sync with VM fences

Florian Fainelli (1):
      net: bcmgenet: Fix EEE implementation

Florian Westphal (2):
      netfilter: nf_tables: restrict anonymous set and map names to 16 bytes
      netfilter: nf_tables: reject QUEUE/DROP verdict parameters

Frank Li (1):
      dmaengine: fix is_slave_direction() return false when DMA_DEV_TO_DEV

Frank Rowand (3):
      of: unittest: add overlay gpio test to catch gpio hog problem
      of: unittest: fix EXPECT text for gpio hog errors
      of: gpio unittest kfree() wrong object

Frederic Weisbecker (1):
      hrtimer: Report offline hrtimer enqueue

Furong Xu (2):
      net: stmmac: xgmac: fix handling of DPP safety error for DMA channels
      net: stmmac: xgmac: fix a typo of register name in DPP safety handling

Gabriel Krisman Bertazi (1):
      ecryptfs: Reject casefold directory inodes

Ghanshyam Agrawal (1):
      media: stk1160: Fixed high volume of stk1160_dbg messages

Greg KH (1):
      perf/core: Fix narrow startup race when creating the perf nr_addr_filters sysfs file

Greg Kroah-Hartman (1):
      Linux 5.4.269

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

Harshit Shah (1):
      i3c: master: cdns: Update maximum prescaler value for i2c clock

Heiko Carstens (2):
      s390/ptrace: handle setting of fpc register correctly
      KVM: s390: fix setting of fpc register

Heiner Kallweit (2):
      leds: trigger: panic: Don't register panic notifier if creating the trigger failed
      i2c: i801: Remove i801_set_block_buffer_mode

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

Ilya Dryomov (1):
      rbd: don't move requests to the running list on errors

Ivan Vecera (1):
      i40e: Fix waiting for queues of all VSIs to be disabled

Jack Wang (1):
      RDMA/IPoIB: Fix error code return in ipoib_mcast_join

JackBB Wu (1):
      USB: serial: qcserial: add new usb-id for Dell Wireless DW5826e

JaimeLiao (1):
      mtd: spinand: macronix: Fix MX35LFxGE4AD page size

Jan Beulich (1):
      xen-netback: properly sync TX responses

Jason Gerecke (1):
      HID: wacom: Do not register input devices until after hid_hw_start

Jean Delvare (1):
      i2c: i801: Fix block process call transactions

Jedrzej Jagielski (2):
      ixgbe: Refactor returning internal error codes
      ixgbe: Refactor overtemp event handling

Johan Hovold (1):
      arm64: dts: qcom: sdm845: fix USB wakeup interrupt types

Johan Jonker (1):
      ARM: dts: rockchip: fix rk3036 hdmi ports node

Jozsef Kadlecsik (2):
      netfilter: ipset: fix performance regression in swap operation
      netfilter: ipset: Missing gc cancellations fixed

Julian Wiedmann (1):
      net/af_iucv: clean up a try_then_request_module()

Junxiao Bi (1):
      Revert "md/raid5: Wait for MD_SB_CHANGE_PENDING in raid5d"

Justin Tee (1):
      scsi: lpfc: Fix possible file string name overflow when updating firmware

Kamal Dasu (1):
      spi: bcm-qspi: fix SFDP BFPT read by usig mspi read

Konrad Dybcio (2):
      pmdomain: core: Move the unused cleanup to a _sync initcall
      drm/msm/dsi: Enable runtime PM

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

Mao Jinlong (2):
      arm64: dts: qcom: msm8996: Fix 'in-ports' is a required property
      arm64: dts: qcom: msm8998: Fix 'out-ports' is a required property

Mario Limonciello (1):
      gpiolib: acpi: Ignore touchpad wakeup on GPD G1619-04

Masami Hiramatsu (Google) (1):
      tracing/trigger: Fix to return error if failed to alloc snapshot

Matthew Wilcox (Oracle) (1):
      block: Remove special-casing of compound pages

Max Kellermann (1):
      fs/kernfs/dir: obey S_ISGID

Max Krummenacher (1):
      Revert "Revert "mtd: rawnand: gpmi: Fix setting busy timeout setting""

Michael Ellerman (2):
      powerpc: Fix build error due to is_valid_bugaddr()
      powerpc/mm: Fix build failures due to arch_reserved_kernel_pages()

Michael Tretter (1):
      media: rockchip: rga: fix swizzling for RGB formats

Mike Rapoport (1):
      arch, mm: remove stale mentions of DISCONIGMEM

Ming Lei (1):
      blk-mq: fix IO hang from sbitmap wakeup race

Minsuk Kang (1):
      wifi: ath9k: Fix potential array-index-out-of-bounds read in ath9k_htc_txstatus()

Nathan Chancellor (3):
      powerpc: Use always instead of always-y in for crtsavres.o
      um: net: Fix return type of uml_net_start_xmit()
      kbuild: Fix changing ELF file type for output of gen_btf for big endian

Naveen N Rao (1):
      powerpc/lib: Validate size for vector operations

Oleg Nesterov (2):
      afs: fix the usage of read_seqbegin_or_lock() in afs_find_server*()
      rxrpc_find_service_conn_rcu: fix the usage of read_seqbegin_or_lock()

Oleksij Rempel (2):
      spi: introduce SPI_MODE_X_MASK macro
      can: j1939: Fix UAF in j1939_sk_match_filter during setsockopt(SO_J1939_FILTER)

Oliver Neukum (1):
      USB: hub: check for alternate port before enabling A_ALT_HNP_SUPPORT

Oliver Upton (1):
      KVM: arm64: vgic-its: Avoid potential UAF in LPI translation cache

Osama Muhammad (2):
      FS:JFS:UBSAN:array-index-out-of-bounds in dbAdjTree
      UBSAN: array-index-out-of-bounds in dtSplitRoot

Pablo Neira Ayuso (7):
      netfilter: nf_tables: validate NFPROTO_* family
      netfilter: nf_log: replace BUG_ON by WARN_ON_ONCE when putting logger
      netfilter: nft_ct: sanitize layer 3 and 4 protocol number in custom expectations
      netfilter: nft_compat: reject unused compat flag
      netfilter: nft_compat: restrict match/target protocol to u16
      netfilter: nft_ct: reject direction for ct id
      netfilter: nft_set_rbtree: skip end interval element from gc

Paolo Abeni (1):
      selftests: net: avoid just another constant wait

Peter Robinson (1):
      mfd: ti_am335x_tscadc: Fix TI SoC dependencies

Peter Zijlstra (1):
      perf: Fix the nr_addr_filters fix

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

Rui Zhang (1):
      regulator: core: Only increment use_count when enable_count changes

Ryusuke Konishi (3):
      nilfs2: fix data corruption in dsync block recovery for small block sizes
      nilfs2: fix hang in nilfs_lookup_dirty_data_buffers()
      nilfs2: fix potential bug in end_buffer_async_write

Salvatore Dipietro (1):
      tcp: Add memory barrier to tcp_push()

Serge Semin (1):
      mips: Fix max_mapnr being uninitialized on early stages

Sharath Srinivasan (1):
      net/rds: Fix UBSAN: array-index-out-of-bounds in rds_cmsg_recv

Shenwei Wang (1):
      net: fec: fix the unhandled context fault from smmu

Shigeru Yoshida (1):
      tipc: Check the bearer type before calling tipc_udp_nl_bearer_add()

Shiji Yang (1):
      wifi: rt2x00: restart beacon queue when hardware reset

Simon Horman (1):
      net: stmmac: xgmac: use #define for string constants

Sjoerd Simons (1):
      bus: moxtet: Add spi device table

Srinivasan Shanmugam (2):
      drm/amdgpu: Drop 'fence' check in 'to_amdgpu_amdkfd_fence()'
      drm/amdgpu: Release 'adev->pm.fw' before return in 'amdgpu_device_need_post()'

Stephen Rothwell (1):
      powerpc: pmd_move_must_withdraw() is only needed for CONFIG_TRANSPARENT_HUGEPAGE

Steve Wahl (1):
      x86/mm/ident_map: Use gbpages only where full GB page should be mapped.

Steven Rostedt (Google) (2):
      tracing: Fix wasted memory in saved_cmdlines logic
      tracing: Inform kmemleak of saved_cmdlines allocation

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

Yang Xu (2):
      fs: add mode_strip_sgid() helper
      fs: move S_ISGID stripping into the vfs_*() helpers

Ye Bin (1):
      ext4: fix inconsistent between segment fstrim and full fstrim

Yevgeny Kliteynik (1):
      net/mlx5: DR, Use the right GVMI number for drop action

Yonghong Song (1):
      selftests/bpf: Fix pyperf180 compilation failure with clang18

Yoshihiro Shimoda (1):
      phy: renesas: rcar-gen3-usb2: Fix returning wrong error code

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

Zhihao Cheng (1):
      ubifs: ubifs_symlink: Fix memleak of inode->i_link in error path

Zhipeng Lu (4):
      net/mlx5e: fix a double-free in arfs_create_groups
      fjes: fix memleaks in fjes_hw_setup
      net: ipv4: fix a memleak in ip_setup_cork
      atm: idt77252: fix a memleak in open_card_ubr0

Zhiquan Li (1):
      x86/mce: Mark fatal MCE's page as poison to avoid panic in the kdump kernel

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

zhili.liu (1):
      iio: magnetometer: rm3100: add boundary check for the value read from RM3100_REG_TMRC


