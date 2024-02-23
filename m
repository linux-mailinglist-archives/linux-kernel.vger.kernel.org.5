Return-Path: <linux-kernel+bounces-78558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 069FB861501
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:00:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B7C81C2158F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040E02E3EB;
	Fri, 23 Feb 2024 14:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HHcGPQ7B"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C689341C76;
	Fri, 23 Feb 2024 14:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708700394; cv=none; b=pvk/d4Cl2MtDcao11fSmkGhCDgpx7Vi4ZpvQATPbxMCklpZbB9fxhZ4uPxlycBJB0Yu16m6BNAdtHaB1VBpOJWfzUdr9yxCsSbvIiSNszY1Qo2mqVshyqhl9o3yGVXxoVstngEztZu2bWVH6LcBdAwY77a0eGc5Lo2yIW+JWHiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708700394; c=relaxed/simple;
	bh=MapGcJXvJ1do5pbJr3GOwM6FY+f/YxO7N3h8jA/dxVk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fCaRM83ylMc1bZNTPgK+SO8XUTWIGIfSt+1pJYN8+DLKywE/S6YeCcyDkC9CLTvvfVbrbRC8BdsjwDR35K4rZDkFR9xvU0Y9orxBcBTq6F5XHgZa+MwHOcZOsOPfrvgIYb0PBKzsE9+KIEsWxlDAO8W8Sy5L8tqvytr3HYuG32s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HHcGPQ7B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2B07C433F1;
	Fri, 23 Feb 2024 14:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708700394;
	bh=MapGcJXvJ1do5pbJr3GOwM6FY+f/YxO7N3h8jA/dxVk=;
	h=From:To:Cc:Subject:Date:From;
	b=HHcGPQ7BY+6s5XpAavWBXRJ0GHgm19ONIGuTxDYf9ffHlxnFrn7XovKgqd+/rKTqo
	 2fH3por7QlmT5IT0W8iPIu27/OsW1ukGuOHMpY1RDAE7G4NFQ8AqlmGvRLMjuWKsi8
	 I3tZI8YPe+uFNDMcxIjp+v4gi4P2S6B3uOg4xrXw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.10.210
Date: Fri, 23 Feb 2024 15:59:49 +0100
Message-ID: <2024022350-lint-rascal-031e@gregkh>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 5.10.210 kernel.

All users of the 5.10 kernel series must upgrade.

The updated 5.10.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.10.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/ABI/testing/sysfs-class-net-queues                |   22 
 Documentation/ABI/testing/sysfs-class-net-statistics            |   48 -
 Documentation/filesystems/directory-locking.rst                 |   29 -
 Documentation/filesystems/locking.rst                           |    5 
 Documentation/filesystems/porting.rst                           |   18 
 Documentation/sound/soc/dapm.rst                                |    2 
 Makefile                                                        |    2 
 arch/arm/boot/dts/exynos4210-i9100.dts                          |    8 
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
 arch/arm/boot/dts/imx25.dtsi                                    |    2 
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
 arch/arm64/boot/dts/qcom/sc7180.dtsi                            |    8 
 arch/arm64/boot/dts/qcom/sdm845.dtsi                            |   16 
 arch/arm64/kernel/entry.S                                       |    8 
 arch/arm64/kernel/perf_event.c                                  |    6 
 arch/mips/include/asm/checksum.h                                |    3 
 arch/mips/kernel/elf.c                                          |    6 
 arch/mips/mm/init.c                                             |   15 
 arch/parisc/kernel/firmware.c                                   |    4 
 arch/powerpc/include/asm/mmu.h                                  |    4 
 arch/powerpc/include/asm/mmzone.h                               |    3 
 arch/powerpc/kernel/traps.c                                     |    2 
 arch/powerpc/kvm/book3s_hv_uvmem.c                              |    2 
 arch/powerpc/lib/sstep.c                                        |   10 
 arch/powerpc/mm/book3s64/pgtable.c                              |    2 
 arch/powerpc/mm/init-common.c                                   |    5 
 arch/powerpc/mm/kasan/kasan_init_32.c                           |    1 
 arch/s390/crypto/aes_s390.c                                     |    4 
 arch/s390/crypto/paes_s390.c                                    |    4 
 arch/s390/kernel/ptrace.c                                       |    6 
 arch/s390/kvm/kvm-s390.c                                        |    5 
 arch/um/drivers/net_kern.c                                      |    2 
 arch/um/include/shared/kern_util.h                              |    2 
 arch/um/kernel/process.c                                        |    2 
 arch/um/os-Linux/helper.c                                       |    6 
 arch/um/os-Linux/util.c                                         |   19 
 arch/x86/Kconfig.cpu                                            |    2 
 arch/x86/boot/compressed/ident_map_64.c                         |    5 
 arch/x86/boot/compressed/idt_64.c                               |    1 
 arch/x86/boot/compressed/idt_handlers_64.S                      |    1 
 arch/x86/boot/compressed/misc.h                                 |    1 
 arch/x86/include/asm/syscall_wrapper.h                          |   25 
 arch/x86/kernel/cpu/mce/core.c                                  |   16 
 arch/x86/kvm/mmu/page_track.c                                   |    2 
 arch/x86/kvm/x86.c                                              |    4 
 arch/x86/mm/ident_map.c                                         |   23 
 block/bio.c                                                     |    9 
 block/blk-iocost.c                                              |    7 
 block/blk-mq.c                                                  |   16 
 crypto/algapi.c                                                 |    1 
 drivers/acpi/acpi_extlog.c                                      |    5 
 drivers/acpi/acpi_video.c                                       |    9 
 drivers/acpi/apei/ghes.c                                        |   29 -
 drivers/android/binder.c                                        |   10 
 drivers/ata/libata-eh.c                                         |    2 
 drivers/atm/idt77252.c                                          |    2 
 drivers/base/power/domain.c                                     |    2 
 drivers/base/power/main.c                                       |  251 +++++-----
 drivers/base/power/runtime.c                                    |   22 
 drivers/block/rbd.c                                             |   22 
 drivers/block/rnbd/rnbd-srv.c                                   |   19 
 drivers/bluetooth/hci_qca.c                                     |    1 
 drivers/bus/mhi/host/main.c                                     |    4 
 drivers/bus/moxtet.c                                            |    7 
 drivers/char/hw_random/core.c                                   |   34 -
 drivers/clk/hisilicon/clk-hi3620.c                              |    4 
 drivers/clk/mmp/clk-of-pxa168.c                                 |    3 
 drivers/crypto/ccp/sev-dev.c                                    |   10 
 drivers/crypto/stm32/stm32-crc32.c                              |    2 
 drivers/devfreq/devfreq.c                                       |   24 
 drivers/dma/dmaengine.c                                         |    3 
 drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c                         |   10 
 drivers/dma/fsl-qdma.c                                          |   27 -
 drivers/dma/ti/k3-udma.c                                        |   10 
 drivers/firewire/core-device.c                                  |    7 
 drivers/gpio/gpio-eic-sprd.c                                    |   32 +
 drivers/gpio/gpiolib-acpi.c                                     |   14 
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c                |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                      |    1 
 drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c                        |    3 
 drivers/gpu/drm/amd/display/dc/core/dc.c                        |    4 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c  |    2 
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
 drivers/gpu/drm/msm/dp/dp_link.c                                |   12 
 drivers/gpu/drm/msm/dp/dp_reg.h                                 |    3 
 drivers/gpu/drm/msm/dsi/phy/dsi_phy.c                           |    4 
 drivers/gpu/drm/nouveau/nouveau_vmm.c                           |    3 
 drivers/gpu/drm/panel/panel-simple.c                            |    2 
 drivers/gpu/drm/tidss/tidss_crtc.c                              |   10 
 drivers/hid/hid-apple.c                                         |   33 +
 drivers/hid/hid-ids.h                                           |    1 
 drivers/hid/hid-quirks.c                                        |    1 
 drivers/hid/wacom_sys.c                                         |   63 +-
 drivers/hid/wacom_wac.c                                         |    9 
 drivers/hwmon/aspeed-pwm-tacho.c                                |    7 
 drivers/hwmon/coretemp.c                                        |   40 -
 drivers/i2c/busses/i2c-i801.c                                   |   19 
 drivers/i3c/master/i3c-master-cdns.c                            |    7 
 drivers/iio/accel/Kconfig                                       |    2 
 drivers/iio/adc/ad7091r-base.c                                  |  173 ++++++
 drivers/iio/adc/ad7091r-base.h                                  |    8 
 drivers/iio/adc/ad7091r5.c                                      |   29 -
 drivers/iio/magnetometer/rm3100-core.c                          |   10 
 drivers/infiniband/ulp/ipoib/ipoib_multicast.c                  |    7 
 drivers/input/keyboard/atkbd.c                                  |   13 
 drivers/input/serio/i8042-acpipnpio.h                           |    6 
 drivers/irqchip/irq-brcmstb-l2.c                                |    5 
 drivers/irqchip/irq-gic-v3-its.c                                |   22 
 drivers/leds/trigger/ledtrig-panic.c                            |    5 
 drivers/md/dm-core.h                                            |    2 
 drivers/md/dm-ioctl.c                                           |    3 
 drivers/md/dm-table.c                                           |    9 
 drivers/md/md.c                                                 |   54 +-
 drivers/md/raid5.c                                              |   12 
 drivers/media/pci/ddbridge/ddbridge-main.c                      |    2 
 drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c                 |    6 
 drivers/media/platform/rockchip/rga/rga.c                       |   15 
 drivers/media/rc/bpf-lirc.c                                     |    6 
 drivers/media/rc/ir_toy.c                                       |    2 
 drivers/media/rc/lirc_dev.c                                     |    5 
 drivers/media/rc/rc-core-priv.h                                 |    2 
 drivers/media/usb/stk1160/stk1160-video.c                       |    5 
 drivers/mfd/Kconfig                                             |    1 
 drivers/misc/fastrpc.c                                          |    2 
 drivers/mmc/core/block.c                                        |   46 +
 drivers/mmc/core/slot-gpio.c                                    |    6 
 drivers/mmc/host/mmc_spi.c                                      |  186 -------
 drivers/net/bonding/bond_alb.c                                  |    3 
 drivers/net/dsa/mv88e6xxx/chip.h                                |    4 
 drivers/net/dsa/mv88e6xxx/serdes.c                              |    8 
 drivers/net/dsa/mv88e6xxx/serdes.h                              |    8 
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                       |    5 
 drivers/net/ethernet/broadcom/genet/bcmgenet.c                  |   22 
 drivers/net/ethernet/broadcom/genet/bcmgenet.h                  |    3 
 drivers/net/ethernet/broadcom/genet/bcmmii.c                    |    6 
 drivers/net/ethernet/freescale/fec_main.c                       |    2 
 drivers/net/ethernet/intel/i40e/i40e_main.c                     |    2 
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c              |   32 +
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h              |    1 
 drivers/net/ethernet/intel/ixgbe/ixgbe_82598.c                  |   36 -
 drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c                  |   61 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_common.c                 |  177 +++----
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c                |    2 
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c                   |   44 -
 drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.c                    |   34 -
 drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.h                    |    1 
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c                    |  105 ++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h                    |    2 
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c                  |    2 
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h                   |   51 --
 drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c                   |   44 -
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c                   |  149 +++--
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c                 |   27 +
 drivers/net/ethernet/mellanox/mlx5/core/en_arfs.c               |   26 -
 drivers/net/ethernet/mellanox/mlx5/core/steering/dr_action.c    |    1 
 drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c         |    2 
 drivers/net/ethernet/netronome/nfp/nfpcore/nfp6000_pcie.c       |    6 
 drivers/net/ethernet/pensando/ionic/ionic_dev.c                 |    1 
 drivers/net/ethernet/pensando/ionic/ionic_dev.h                 |    1 
 drivers/net/ethernet/pensando/ionic/ionic_main.c                |    2 
 drivers/net/ethernet/stmicro/stmmac/common.h                    |    1 
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h                  |    3 
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c             |   58 ++
 drivers/net/fjes/fjes_hw.c                                      |   37 +
 drivers/net/hyperv/netvsc.c                                     |    5 
 drivers/net/ppp/ppp_async.c                                     |    4 
 drivers/net/virtio_net.c                                        |    9 
 drivers/net/wireless/ath/ath9k/htc_drv_txrx.c                   |    5 
 drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c                |    2 
 drivers/net/wireless/ralink/rt2x00/rt2x00dev.c                  |    3 
 drivers/net/wireless/ralink/rt2x00/rt2x00mac.c                  |   11 
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c           |   12 
 drivers/net/wireless/realtek/rtlwifi/rtl8723ae/phy.c            |    6 
 drivers/net/wireless/realtek/rtlwifi/rtl8723be/phy.c            |    4 
 drivers/net/xen-netback/netback.c                               |   84 +--
 drivers/of/property.c                                           |    2 
 drivers/of/unittest.c                                           |   12 
 drivers/pci/controller/dwc/pcie-designware-ep.c                 |    2 
 drivers/pci/controller/pcie-mediatek.c                          |   10 
 drivers/pci/pcie/aer.c                                          |    9 
 drivers/pci/quirks.c                                            |   24 
 drivers/pci/switch/switchtec.c                                  |   25 
 drivers/phy/renesas/phy-rcar-gen3-usb2.c                        |    4 
 drivers/phy/ti/phy-omap-usb2.c                                  |    4 
 drivers/pnp/pnpacpi/rsparser.c                                  |   12 
 drivers/regulator/core.c                                        |   56 +-
 drivers/rpmsg/virtio_rpmsg_bus.c                                |    1 
 drivers/rtc/rtc-cmos.c                                          |    4 
 drivers/s390/net/qeth_l3_main.c                                 |    9 
 drivers/scsi/arcmsr/arcmsr.h                                    |    4 
 drivers/scsi/arcmsr/arcmsr_hba.c                                |    6 
 drivers/scsi/device_handler/scsi_dh_alua.c                      |    4 
 drivers/scsi/device_handler/scsi_dh_emc.c                       |    4 
 drivers/scsi/device_handler/scsi_dh_rdac.c                      |    4 
 drivers/scsi/fcoe/fcoe_ctlr.c                                   |   20 
 drivers/scsi/isci/request.c                                     |    2 
 drivers/scsi/libfc/fc_fcp.c                                     |   18 
 drivers/scsi/lpfc/lpfc.h                                        |    1 
 drivers/scsi/lpfc/lpfc_init.c                                   |    4 
 drivers/scsi/scsi_error.c                                       |   73 +-
 drivers/scsi/scsi_lib.c                                         |    6 
 drivers/scsi/scsi_priv.h                                        |    4 
 drivers/spi/spi-bcm-qspi.c                                      |    4 
 drivers/spi/spi-ppc4xx.c                                        |    5 
 drivers/staging/iio/impedance-analyzer/ad5933.c                 |    2 
 drivers/tty/serial/8250/8250_core.c                             |    1 
 drivers/tty/serial/8250/8250_exar.c                             |   13 
 drivers/tty/serial/max310x.c                                    |   21 
 drivers/tty/serial/sc16is7xx.c                                  |    8 
 drivers/tty/tty_ioctl.c                                         |    4 
 drivers/usb/cdns3/ep0.c                                         |    4 
 drivers/usb/cdns3/gadget.c                                      |  150 ++++-
 drivers/usb/cdns3/gadget.h                                      |    3 
 drivers/usb/core/hub.c                                          |   34 -
 drivers/usb/gadget/function/f_mass_storage.c                    |   20 
 drivers/usb/host/xhci-plat.c                                    |    3 
 drivers/usb/serial/cp210x.c                                     |    1 
 drivers/usb/serial/option.c                                     |    1 
 drivers/usb/serial/qcserial.c                                   |    2 
 drivers/usb/typec/ucsi/ucsi_acpi.c                              |   17 
 drivers/vhost/vhost.c                                           |    5 
 drivers/watchdog/it87_wdt.c                                     |   14 
 drivers/xen/gntdev-dmabuf.c                                     |   50 -
 fs/afs/callback.c                                               |    3 
 fs/afs/dir.c                                                    |    8 
 fs/afs/server.c                                                 |    7 
 fs/btrfs/disk-io.c                                              |   13 
 fs/btrfs/extent-tree.c                                          |    3 
 fs/btrfs/inode.c                                                |   43 -
 fs/btrfs/ioctl.c                                                |   12 
 fs/btrfs/qgroup.c                                               |   14 
 fs/btrfs/ref-verify.c                                           |    6 
 fs/btrfs/send.c                                                 |    2 
 fs/btrfs/tree-checker.c                                         |    2 
 fs/ceph/caps.c                                                  |   12 
 fs/cifs/smb2misc.c                                              |    2 
 fs/cifs/smb2ops.c                                               |   14 
 fs/cifs/smb2pdu.c                                               |   13 
 fs/cifs/smb2pdu.h                                               |   42 -
 fs/dcache.c                                                     |    7 
 fs/ecryptfs/inode.c                                             |    8 
 fs/exec.c                                                       |    3 
 fs/ext4/mballoc.c                                               |   26 -
 fs/ext4/move_extent.c                                           |    6 
 fs/ext4/resize.c                                                |   37 -
 fs/f2fs/recovery.c                                              |   25 
 fs/ioctl.c                                                      |    3 
 fs/jfs/jfs_dmap.c                                               |   57 +-
 fs/jfs/jfs_dtree.c                                              |    7 
 fs/jfs/jfs_imap.c                                               |    3 
 fs/jfs/jfs_mount.c                                              |    6 
 fs/kernfs/dir.c                                                 |   12 
 fs/namei.c                                                      |   60 +-
 fs/nilfs2/dat.c                                                 |   27 -
 fs/nilfs2/file.c                                                |    8 
 fs/nilfs2/recovery.c                                            |    7 
 fs/nilfs2/segment.c                                             |    8 
 fs/pipe.c                                                       |   19 
 fs/pstore/ram.c                                                 |    1 
 fs/ubifs/dir.c                                                  |    2 
 include/drm/drm_color_mgmt.h                                    |    1 
 include/drm/drm_mipi_dsi.h                                      |    2 
 include/linux/async.h                                           |    2 
 include/linux/bpf.h                                             |    6 
 include/linux/dmaengine.h                                       |    3 
 include/linux/hrtimer.h                                         |    4 
 include/linux/lsm_hook_defs.h                                   |    2 
 include/linux/mmzone.h                                          |   18 
 include/linux/netfilter/ipset/ip_set.h                          |    4 
 include/linux/pci_ids.h                                         |    1 
 include/linux/pipe_fs_i.h                                       |   16 
 include/linux/pm_runtime.h                                      |    8 
 include/linux/security.h                                        |    9 
 include/linux/serial_core.h                                     |    1 
 include/linux/spi/spi.h                                         |    1 
 include/linux/stddef.h                                          |   13 
 include/linux/syscalls.h                                        |    1 
 include/linux/units.h                                           |   10 
 include/linux/vmalloc.h                                         |    5 
 include/net/af_unix.h                                           |   20 
 include/net/inet_connection_sock.h                              |    8 
 include/net/llc_pdu.h                                           |    6 
 include/net/netfilter/nf_tables.h                               |    4 
 include/scsi/scsi.h                                             |   21 
 include/scsi/scsi_dh.h                                          |    3 
 include/scsi/scsi_eh.h                                          |    2 
 include/uapi/linux/btrfs.h                                      |    3 
 include/uapi/linux/netfilter/nf_tables.h                        |    2 
 include/uapi/linux/stddef.h                                     |   23 
 kernel/async.c                                                  |   85 ++-
 kernel/audit.c                                                  |   31 -
 kernel/bpf/arraymap.c                                           |   12 
 kernel/bpf/hashtab.c                                            |    6 
 kernel/bpf/map_in_map.c                                         |    2 
 kernel/bpf/map_in_map.h                                         |    2 
 kernel/bpf/syscall.c                                            |    6 
 kernel/events/core.c                                            |   38 +
 kernel/power/swap.c                                             |   38 -
 kernel/sched/membarrier.c                                       |    9 
 kernel/time/clocksource.c                                       |   25 
 kernel/time/hrtimer.c                                           |   17 
 kernel/time/tick-sched.c                                        |    5 
 kernel/trace/ring_buffer.c                                      |    2 
 kernel/trace/trace.c                                            |   78 +--
 kernel/trace/trace_events_trigger.c                             |    6 
 kernel/trace/tracing_map.c                                      |    7 
 lib/debugobjects.c                                              |  200 +++----
 lib/mpi/ec.c                                                    |    3 
 mm/page-writeback.c                                             |    2 
 mm/sparse.c                                                     |   17 
 mm/util.c                                                       |   50 +
 net/8021q/vlan_netlink.c                                        |    4 
 net/bluetooth/l2cap_core.c                                      |    3 
 net/can/j1939/j1939-priv.h                                      |    1 
 net/can/j1939/socket.c                                          |   22 
 net/core/request_sock.c                                         |    3 
 net/core/skbuff.c                                               |    3 
 net/hsr/hsr_device.c                                            |    4 
 net/ipv4/af_inet.c                                              |    9 
 net/ipv4/inet_connection_sock.c                                 |    4 
 net/ipv4/ip_output.c                                            |   12 
 net/ipv4/ip_tunnel_core.c                                       |    2 
 net/ipv4/tcp.c                                                  |   45 +
 net/ipv6/addrconf_core.c                                        |   21 
 net/ipv6/af_inet6.c                                             |    3 
 net/ipv6/ip6_tunnel.c                                           |   28 -
 net/iucv/af_iucv.c                                              |   14 
 net/llc/af_llc.c                                                |   26 -
 net/llc/llc_core.c                                              |    7 
 net/mac80211/tx.c                                               |    3 
 net/netfilter/ipset/ip_set_bitmap_gen.h                         |   14 
 net/netfilter/ipset/ip_set_core.c                               |   39 +
 net/netfilter/ipset/ip_set_hash_gen.h                           |   19 
 net/netfilter/ipset/ip_set_list_set.c                           |   13 
 net/netfilter/nf_log.c                                          |    7 
 net/netfilter/nf_tables_api.c                                   |   20 
 net/netfilter/nft_byteorder.c                                   |    5 
 net/netfilter/nft_chain_filter.c                                |   11 
 net/netfilter/nft_compat.c                                      |   23 
 net/netfilter/nft_ct.c                                          |   27 +
 net/netfilter/nft_flow_offload.c                                |    5 
 net/netfilter/nft_meta.c                                        |    2 
 net/netfilter/nft_nat.c                                         |    5 
 net/netfilter/nft_rt.c                                          |    5 
 net/netfilter/nft_set_pipapo.c                                  |  108 ++--
 net/netfilter/nft_set_pipapo.h                                  |   18 
 net/netfilter/nft_set_pipapo_avx2.c                             |   17 
 net/netfilter/nft_set_rbtree.c                                  |    6 
 net/netfilter/nft_socket.c                                      |    5 
 net/netfilter/nft_synproxy.c                                    |    7 
 net/netfilter/nft_tproxy.c                                      |    5 
 net/netfilter/nft_xfrm.c                                        |    5 
 net/netlink/af_netlink.c                                        |    2 
 net/nfc/nci/core.c                                              |    4 
 net/openvswitch/flow_netlink.c                                  |   49 +
 net/rds/af_rds.c                                                |    2 
 net/rxrpc/conn_event.c                                          |    8 
 net/rxrpc/conn_service.c                                        |    3 
 net/smc/smc_diag.c                                              |    2 
 net/sunrpc/xprtmultipath.c                                      |   17 
 net/tipc/bearer.c                                               |    6 
 net/unix/af_unix.c                                              |   14 
 net/unix/diag.c                                                 |    2 
 net/wireless/scan.c                                             |    4 
 scripts/decode_stacktrace.sh                                    |   64 ++
 scripts/get_abi.pl                                              |    2 
 scripts/kernel-doc                                              |    3 
 scripts/link-vmlinux.sh                                         |    9 
 scripts/mod/sumversion.c                                        |    7 
 security/security.c                                             |   32 +
 security/selinux/hooks.c                                        |   28 +
 security/smack/smack_lsm.c                                      |    1 
 security/tomoyo/tomoyo.c                                        |    1 
 sound/hda/hdac_stream.c                                         |    9 
 sound/hda/intel-dsp-config.c                                    |   10 
 sound/pci/hda/hda_intel.c                                       |    2 
 sound/pci/hda/patch_conexant.c                                  |   18 
 sound/pci/hda/patch_realtek.c                                   |    3 
 sound/soc/codecs/rt5645.c                                       |    1 
 tools/lib/subcmd/help.c                                         |   18 
 tools/testing/selftests/bpf/prog_tests/btf.c                    |    1 
 tools/testing/selftests/bpf/progs/pyperf180.c                   |   22 
 tools/testing/selftests/drivers/net/netdevsim/udp_tunnel_nic.sh |    9 
 tools/testing/selftests/net/pmtu.sh                             |   18 
 virt/kvm/kvm_main.c                                             |    4 
 416 files changed, 3967 insertions(+), 2174 deletions(-)

Aaron Conole (1):
      net: openvswitch: limit the number of recursions from action sets

Adrian Reber (1):
      tty: allow TIOCSLCKTRMIOS with CAP_CHECKPOINT_RESTORE

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

Alexandra Winter (1):
      s390/qeth: Fix potential loss of L3-IP@ in case of network issues

Alexey Dobriyan (1):
      uapi: stddef.h: Fix __DECLARE_FLEX_ARRAY for C++

Alexey Khoroshilov (1):
      ASoC: rt5645: Fix deadlock in rt5645_jack_detect_work()

Alfred Piccioni (1):
      lsm: new security_file_ioctl_compat() hook

Amelie Delaunay (1):
      dmaengine: fix NULL pointer in channel unregistration function

Andrii Nakryiko (1):
      selftests/bpf: satisfy compiler by having explicit return in btf test

Andrii Staikov (1):
      i40e: Fix VF disable behavior to block all traffic

Andrzej Hajda (1):
      debugobjects: Stop accessing objects after releasing hash bucket lock

Andy Shevchenko (1):
      mmc: mmc_spi: remove custom DMA mapped buffers

Anna Schumaker (1):
      SUNRPC: Fix a suspicious RCU usage warning

Antoine Tenart (1):
      tunnels: fix out of bounds access when building IPv6 PMTU error

Anton Ivanov (1):
      um: Fix naming clash between UML and scheduler

Arjun Roy (1):
      net-zerocopy: Refactor frag-is-remappable test.

Arnd Bergmann (1):
      drm/exynos: fix accidental on-stack copy of exynos_drm_plane

Avri Altman (1):
      mmc: core: Use mrq.sbc in close-ended ffu

Baokun Li (4):
      ext4: unify the type of flexbg_size to unsigned int
      ext4: remove unnecessary check from alloc_flex_gd()
      ext4: avoid online resizing failures due to oversized flex bg
      ext4: fix double-free of blocks due to wrong extents moved_len

Bart Van Assche (1):
      scsi: core: Introduce enum scsi_disposition

Benjamin Berg (3):
      wifi: cfg80211: free beacon_ies when overridden from hidden BSS
      um: Don't use vfprintf() for os_info()
      HID: apple: Add 2021 magic keyboard FN key mapping

Bernd Edlinger (1):
      exec: Fix error handling in begin_new_exec()

Bjorn Helgaas (2):
      PM: sleep: Use dev_printk() when possible
      PCI/AER: Decode Requester ID when no error info found

Boris Burkov (2):
      btrfs: forbid creating subvol qgroups
      btrfs: forbid deleting live subvol qgroup

Breno Leitao (2):
      net: sysfs: Fix /sys/class/net/<iface> path
      net: sysfs: Fix /sys/class/net/<iface> path for statistics

Carlos Llamas (2):
      binder: signal epoll threads of self-work
      scripts/decode_stacktrace.sh: optionally use LLVM utilities

Chao Yu (1):
      f2fs: fix to check return value of f2fs_reserve_new_block()

Charan Teja Kalla (1):
      mm/sparsemem: fix race in accessing memory_section->usage

Chris Riches (1):
      audit: Send netlink ACK before setting connection in auditd_set

Christian A. Ehrhardt (2):
      of: unittest: Fix compile in the non-dynamic case
      usb: ucsi_acpi: Fix command completion handling

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

Dan Carpenter (4):
      drm/bridge: nxp-ptn3460: fix i2c_master_send() error checking
      drm/bridge: nxp-ptn3460: simplify some error checking
      netfilter: nf_tables: fix pointer math issue in nft_byteorder_eval()
      PCI: dwc: Fix a 64bit bug in dw_pcie_ep_raise_msix_irq()

Daniel Basilio (1):
      nfp: use correct macro for LengthSelect in BAR config

Daniel Lezcano (2):
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

David Senoner (1):
      ALSA: hda/realtek: Fix the external mic not being recognised for Acer Swift 1 SF114-32

David Sterba (2):
      btrfs: don't warn if discard range is not aligned to sector
      btrfs: send: return EOPNOTSUPP on unknown flags

Davidlohr Bueso (1):
      hrtimer: Ignore slack time for RT tasks in schedule_hrtimeout_range()

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

Emmanuel Grumbach (1):
      wifi: iwlwifi: fix a memory corruption

Eric Dumazet (9):
      llc: make llc_ui_sendmsg() more robust against bonding changes
      ip6_tunnel: use dev_sw_netstats_rx_add()
      ip6_tunnel: make sure to pull inner header in __ip6_tnl_rcv()
      tcp: add sanity checks to rx zerocopy
      llc: call sock_orphan() at release time
      af_unix: fix lockdep positive in sk_diag_dump_icons()
      inet: read sk->sk_family once in inet_recv_error()
      ppp_async: limit MRU to 64K
      net: prevent mss overflow in skb_segment()

Fabio Estevam (9):
      ARM: dts: imx25/27-eukrea: Fix RTC node name
      ARM: dts: imx: Use flash@0,0 pattern
      ARM: dts: imx27: Fix sram node
      ARM: dts: imx1: Fix sram node
      ARM: dts: imx25: Fix the iim compatible string
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

Florian Westphal (5):
      netfilter: nf_tables: restrict anonymous set and map names to 16 bytes
      netfilter: nf_tables: reject QUEUE/DROP verdict parameters
      netfilter: nft_set_pipapo: store index in scratch maps
      netfilter: nft_set_pipapo: add helper to release pcpu scratch area
      netfilter: nft_set_pipapo: remove scratch_aligned pointer

Frank Li (5):
      usb: cdns3: fix uvc failure work since sg support enabled
      usb: cdns3: fix incorrect calculation of ep_buf_size when more than one config
      usb: cdns3: fix iso transfer error when mult is not zero
      usb: cdns3: Fix uvc fail when DMA cross 4k boundery since sg enabled
      dmaengine: fix is_slave_direction() return false when DMA_DEV_TO_DEV

Frederic Weisbecker (1):
      hrtimer: Report offline hrtimer enqueue

Frédéric Danis (1):
      Bluetooth: L2CAP: Fix possible multiple reject send

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
      Linux 5.10.210

Guanhua Gao (1):
      dmaengine: fsl-dpaa2-qdma: Fix the size of dma pools

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

Herbert Xu (3):
      crypto: api - Disallow identical driver names
      hwrng: core - Fix page fault dead lock on mmap-ed hwrng
      crypto: s390/aes - Fix buffer overread in CTR mode

Hongchen Zhang (1):
      PM: hibernate: Enforce ordering during image compression/decompression

Hou Tao (2):
      bpf: Add map and need_defer parameters to .map_fd_put_ptr()
      bpf: Set uattr->batch.count as zero before batched update or deletion

Hugo Villeneuve (4):
      serial: sc16is7xx: set safe default SPI clock frequency
      serial: sc16is7xx: add check for unsupported SPI modes during probe
      serial: max310x: set default value when reading clock ready bit
      serial: max310x: improve crystal stable clock detection

Ian Rogers (1):
      libsubcmd: Fix memory leak in uniq()

Ido Schimmel (1):
      PCI: Add no PM reset quirk for NVIDIA Spectrum devices

Ilpo Järvinen (2):
      serial: Add rs485_supported to uart_port
      serial: 8250_exar: Fill in rs485_supported

Ilya Dryomov (1):
      rbd: don't move requests to the running list on errors

Ivan Vecera (1):
      i40e: Fix waiting for queues of all VSIs to be disabled

Jack Wang (1):
      RDMA/IPoIB: Fix error code return in ipoib_mcast_join

JackBB Wu (1):
      USB: serial: qcserial: add new usb-id for Dell Wireless DW5826e

Jaegeuk Kim (1):
      f2fs: fix write pointers on zoned device after roll forward

Jai Luthra (1):
      dmaengine: ti: k3-udma: Report short packet errors

Jakub Kicinski (1):
      selftests: netdevsim: fix the udp_tunnel_nic test

Jan Beulich (1):
      xen-netback: properly sync TX responses

Jason Gerecke (1):
      HID: wacom: Do not register input devices until after hid_hw_start

Jean Delvare (1):
      i2c: i801: Fix block process call transactions

Jedrzej Jagielski (2):
      ixgbe: Refactor returning internal error codes
      ixgbe: Refactor overtemp event handling

Jenishkumar Maheshbhai Patel (1):
      net: mvpp2: clear BM pool before initialization

Jiangfeng Xiao (1):
      powerpc/kasan: Fix addr error caused by page alignment

Jiri Wiesner (1):
      clocksource: Skip watchdog check for large watchdog intervals

Johan Hovold (3):
      arm64: dts: qcom: sdm845: fix USB wakeup interrupt types
      arm64: dts: qcom: sdm845: fix USB DP/DM HS PHY interrupts
      arm64: dts: qcom: sc7180: fix USB wakeup interrupt types

Johan Jonker (1):
      ARM: dts: rockchip: fix rk3036 hdmi ports node

Johannes Berg (1):
      wifi: mac80211: reload info pointer in ieee80211_tx_dequeue()

Jonathan Cameron (1):
      iio:adc:ad7091r: Move exports into IIO_AD7091R namespace.

Jozsef Kadlecsik (2):
      netfilter: ipset: fix performance regression in swap operation
      netfilter: ipset: Missing gc cancellations fixed

Julian Wiedmann (1):
      net/af_iucv: clean up a try_then_request_module()

Jun'ichi Nomura (1):
      x86/boot: Ignore NMIs during very early boot

Junxiao Bi (1):
      Revert "md/raid5: Wait for MD_SB_CHANGE_PENDING in raid5d"

Justin Tee (1):
      scsi: lpfc: Fix possible file string name overflow when updating firmware

Kamal Dasu (1):
      spi: bcm-qspi: fix SFDP BFPT read by usig mspi read

Kees Cook (3):
      stddef: Introduce DECLARE_FLEX_ARRAY() helper
      smb3: Replace smb2pdu 1-element arrays with flex-arrays
      block/rnbd-srv: Check for unlikely string overflow

Kim Phillips (1):
      crypto: ccp - Fix null pointer dereference in __sev_platform_shutdown_locked

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

Kuogee Hsieh (1):
      drm/msm/dp: return correct Colorimetry for DP_TEST_DYNAMIC_RANGE_CEA case

Lee Duncan (1):
      scsi: Revert "scsi: fcoe: Fix potential deadlock on &fip->ctlr_lock"

Leonard Dallmayr (1):
      USB: serial: cp210x: add ID for IMST iM871A-USB

Li zeming (1):
      PM: core: Remove unnecessary (void *) conversions

Lin Ma (1):
      vlan: skip nested type that is not IFLA_VLAN_QOS_MAPPING

Lino Sanfilippo (1):
      serial: 8250_exar: Set missing rs485_supported flag

Linus Torvalds (1):
      sched/membarrier: reduce the ability to hammer on sys_membarrier

Loic Prylli (1):
      hwmon: (aspeed-pwm-tacho) mutex for tach reading

Luka Guzenko (1):
      ALSA: hda/realtek: Enable Mute LED on HP Laptop 14-fq0xxx

Lukas Schauer (1):
      pipe: wakeup wr_wait after setting max_usage

Manas Ghandat (2):
      jfs: fix slab-out-of-bounds Read in dtSearch
      jfs: fix array-index-out-of-bounds in dbAdjTree

Mao Jinlong (2):
      arm64: dts: qcom: msm8996: Fix 'in-ports' is a required property
      arm64: dts: qcom: msm8998: Fix 'out-ports' is a required property

Marc Zyngier (1):
      irqchip/gic-v3-its: Fix GICv4.1 VPE affinity update

Marcelo Schmitt (3):
      iio: adc: ad7091r: Set alert bit in config register
      iio: adc: ad7091r: Allow users to configure device events
      iio: adc: ad7091r: Enable internal vref if external vref is not supplied

Mario Limonciello (3):
      rtc: Adjust failure return code for cmos_set_alarm()
      gpiolib: acpi: Ignore touchpad wakeup on GPD G1619-04
      iio: accel: bma400: Fix a compilation problem

Mark Rutland (1):
      drivers/perf: pmuv3: don't expose SW_INCR event in sysfs

Markus Niebel (1):
      drm: panel-simple: add missing bus flags for Tianma tm070jvhg[30/33]

Masami Hiramatsu (Google) (1):
      tracing/trigger: Fix to return error if failed to alloc snapshot

Matthew Wilcox (Oracle) (1):
      block: Remove special-casing of compound pages

Max Kellermann (2):
      fs/pipe: move check to pipe_has_watch_queue()
      fs/kernfs/dir: obey S_ISGID

Meenakshikumar Somasundaram (1):
      drm/amd/display: Fix tiled display misalignment

Michael Chan (1):
      bnxt_en: Wait for FLR to complete during probe

Michael Ellerman (2):
      powerpc: Fix build error due to is_valid_bugaddr()
      powerpc/mm: Fix build failures due to arch_reserved_kernel_pages()

Michael Tretter (1):
      media: rockchip: rga: fix swizzling for RGB formats

Miguel Ojeda (1):
      scripts: decode_stacktrace: demangle Rust symbols

Mikulas Patocka (1):
      dm: limit the number of targets and parameter size area

Ming Lei (3):
      blk-mq: fix IO hang from sbitmap wakeup race
      scsi: core: Move scsi_host_busy() out of host lock for waking up EH handler
      scsi: core: Move scsi_host_busy() out of host lock if it is for per-command

Minsuk Kang (1):
      wifi: ath9k: Fix potential array-index-out-of-bounds read in ath9k_htc_txstatus()

Mukesh Ojha (1):
      PM / devfreq: Synchronize devfreq_monitor_[start/stop]

Nathan Chancellor (2):
      um: net: Fix return type of uml_net_start_xmit()
      kbuild: Fix changing ELF file type for output of gen_btf for big endian

Naveen N Rao (1):
      powerpc/lib: Validate size for vector operations

Nikita Zhandarovich (1):
      net: hsr: remove WARN_ONCE() in send_hsr_supervision_frame()

Niklas Cassel (1):
      PCI: dwc: endpoint: Fix dw_pcie_ep_raise_msix_irq() alignment support

Nikolay Borisov (1):
      btrfs: remove err variable from btrfs_delete_subvolume

Nuno Sa (1):
      of: property: fix typo in io-channels

Oleg Nesterov (3):
      afs: fix the usage of read_seqbegin_or_lock() in afs_lookup_volume_rcu()
      afs: fix the usage of read_seqbegin_or_lock() in afs_find_server*()
      rxrpc_find_service_conn_rcu: fix the usage of read_seqbegin_or_lock()

Oleksandr Tyshchenko (1):
      xen/gntdev: Fix the abuse of underlying struct page in DMA-buf import

Oleksij Rempel (2):
      spi: introduce SPI_MODE_X_MASK macro
      can: j1939: Fix UAF in j1939_sk_match_filter during setsockopt(SO_J1939_FILTER)

Oliver Neukum (1):
      USB: hub: check for alternate port before enabling A_ALT_HNP_SUPPORT

Omar Sandoval (2):
      btrfs: don't abort filesystem when attempting to snapshot deleted subvolume
      btrfs: avoid copying BTRFS_ROOT_SUBVOL_DEAD flag to snapshot of subvolume being deleted

Ondrej Mosnacek (1):
      lsm: fix the logic in security_inode_getsecctx()

Osama Muhammad (2):
      FS:JFS:UBSAN:array-index-out-of-bounds in dbAdjTree
      UBSAN: array-index-out-of-bounds in dtSplitRoot

Pablo Neira Ayuso (8):
      netfilter: nf_tables: validate NFPROTO_* family
      netfilter: nft_chain_filter: handle NETDEV_UNREGISTER for inet/ingress basechain
      netfilter: nf_log: replace BUG_ON by WARN_ON_ONCE when putting logger
      netfilter: nft_ct: sanitize layer 3 and 4 protocol number in custom expectations
      netfilter: nft_compat: reject unused compat flag
      netfilter: nft_compat: restrict match/target protocol to u16
      netfilter: nft_ct: reject direction for ct id
      netfilter: nft_set_rbtree: skip end interval element from gc

Paolo Abeni (1):
      selftests: net: avoid just another constant wait

Paolo Bonzini (2):
      mm: vmalloc: introduce array allocation functions
      KVM: use __vcalloc for very large allocations

Paul Cercueil (1):
      ARM: dts: samsung: exynos4210-i9100: Unconditionally enable LDO12

Pawel Laszczak (1):
      usb: cdns3: Fixes for sparse warnings

Peter Robinson (1):
      mfd: ti_am335x_tscadc: Fix TI SoC dependencies

Peter Zijlstra (1):
      perf: Fix the nr_addr_filters fix

Petr Pavlu (1):
      tracing: Ensure visibility when inserting an element into tracing_map

Pierre-Louis Bossart (3):
      PCI: add INTEL_HDA_ARL to pci_ids.h
      ALSA: hda: Intel: add HDA_ARL PCI ID support
      ALSA: hda: intel-dspcfg: add filters for ARL-S and ARL

Piotr Skajewski (1):
      ixgbe: Remove non-inclusive language

Prarit Bhargava (1):
      ACPI: extlog: fix NULL pointer dereference check

Prashanth K (1):
      usb: host: xhci-plat: Add support for XHCI_SG_TRB_CACHE_SIZE_QUIRK

Prathu Baronia (1):
      vhost: use kzalloc() instead of kmalloc() followed by memset()

Puliang Lu (1):
      USB: serial: option: add Fibocom FM101-GL variant

Qiang Yu (1):
      bus: mhi: host: Drop chan lock before queuing buffers

Qu Wenruo (2):
      btrfs: defrag: reject unknown flags of btrfs_ioctl_defrag_range_args
      btrfs: do not ASSERT() if the newly created subvolume already got read

Radek Krejci (1):
      modpost: trim leading spaces when processing source files list

Rafael J. Wysocki (5):
      async: Split async_schedule_node_domain()
      async: Introduce async_schedule_dev_nocall()
      PM: sleep: Avoid calling put_device() under dpm_list_mtx
      PM: sleep: Fix possible deadlocks in core system-wide PM code
      PM: sleep: Fix error handling in dpm_prepare()

Richard Palethorpe (1):
      x86/entry/ia32: Ensure s32 is sign extended to s64

Rishabh Dave (1):
      ceph: prevent use-after-free in encode_cap_msg()

Rob Clark (1):
      drm/msm/dpu: Ratelimit framedone timeout msgs

Rolf Eike Beer (1):
      mm: use __pfn_to_section() instead of open coding it

Rui Zhang (1):
      regulator: core: Only increment use_count when enable_count changes

Ryusuke Konishi (4):
      nilfs2: fix data corruption in dsync block recovery for small block sizes
      nilfs2: fix hang in nilfs_lookup_dirty_data_buffers()
      nilfs2: fix potential bug in end_buffer_async_write
      nilfs2: replace WARN_ONs for invalid DAT metadata block requests

Salvatore Dipietro (1):
      tcp: Add memory barrier to tcp_push()

Sandeep Maheswaram (1):
      arm64: dts: qcom: sc7180: Use pdc interrupts for USB instead of GIC interrupts

Schspa Shi (1):
      scripts/decode_stacktrace.sh: support old bash version

Sean Young (1):
      media: rc: bpf attach/detach requires write permission

Serge Semin (1):
      mips: Fix max_mapnr being uninitialized on early stages

Shannon Nelson (1):
      ionic: pass opcode to devcmd_wait

Sharath Srinivasan (1):
      net/rds: Fix UBSAN: array-index-out-of-bounds in rds_cmsg_recv

Shenwei Wang (1):
      net: fec: fix the unhandled context fault from smmu

Shigeru Yoshida (1):
      tipc: Check the bearer type before calling tipc_udp_nl_bearer_add()

Shiji Yang (1):
      wifi: rt2x00: restart beacon queue when hardware reset

Shuai Xue (1):
      ACPI: APEI: set memory failure flags as MF_ACTION_REQUIRED on synchronous events

Simon Horman (1):
      net: stmmac: xgmac: use #define for string constants

Sjoerd Simons (1):
      bus: moxtet: Add spi device table

Souradeep Chakrabarti (1):
      hv_netvsc: Fix race condition between netvsc_probe and netvsc_remove

Srinivasan Shanmugam (3):
      drm/amdgpu: Drop 'fence' check in 'to_amdgpu_amdkfd_fence()'
      drm/amd/powerplay: Fix kzalloc parameter 'ATOM_Tonga_PPM_Table' in 'get_platform_power_management_table()'
      drm/amdgpu: Release 'adev->pm.fw' before return in 'amdgpu_device_need_post()'

Stephen Boyd (1):
      scripts/decode_stacktrace.sh: silence stderr messages from addr2line/nm

Stephen Rothwell (2):
      powerpc: pmd_move_must_withdraw() is only needed for CONFIG_TRANSPARENT_HUGEPAGE
      drm: using mul_u32_u32() requires linux/math64.h

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

Takashi Iwai (1):
      ALSA: hda: Refer to correct stream index at loops

Takashi Sakamoto (1):
      firewire: core: correct documentation of fw_csr_string() kernel API

Tatsunosuke Tobita (1):
      HID: wacom: generic: Avoid reporting a serial of '0' to userspace

Tejun Heo (1):
      blk-iocost: Fix an UBSAN shift-out-of-bounds warning

Thomas Bourgoin (1):
      crypto: stm32/crc32 - fix parsing list of devices

Tianjia Zhang (1):
      crypto: lib/mpi - Fix unexpected pointer access in mpi_ec_init

Tim Chen (1):
      tick/sched: Preserve number of idle sleeps across CPU hotplug events

Tobias Waldekranz (1):
      net: dsa: mv88e6xxx: Fix mv88e6352_serdes_get_stats error path

Tomi Valkeinen (4):
      drm/tidss: Fix atomic_flush check
      drm/drm_file: fix use of uninitialized variable
      drm/framebuffer: Fix use of uninitialized variable
      drm/mipi-dsi: Fix detach call without attach

Tony Lindgren (1):
      phy: ti: phy-omap-usb2: Fix NULL pointer dereference for SRP

Uwe Kleine-König (1):
      spi: ppc4xx: Drop write-only variable

Vegard Nossum (1):
      scripts/get_abi: fix source path leak

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

Werner Fischer (1):
      watchdog: it87_wdt: Keep WDTCTRL bit 3 unmodified for IT8784/IT8786

Werner Sembach (1):
      Input: i8042 - fix strange behavior of touchpad on Clevo NS70PU

Xi Ruoyao (1):
      mips: Call lose_fpu(0) before initializing fcr31 in mips_set_personality_nan

Xiang Yang (1):
      Revert "arm64: Stash shadow stack pointer in the task struct on interrupt"

Xiaolei Wang (1):
      rpmsg: virtio: Free driver_override when rpmsg_remove()

Xiubo Li (1):
      ceph: fix deadlock or deadcode of misusing dget()

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

Zheng Wang (1):
      media: mtk-jpeg: Fix use after free bug due to error path handling in mtk_jpeg_dec_device_run

Zhengchao Shao (5):
      tcp: make sure init the accept_queue's spinlocks once
      netlink: fix potential sleeping issue in mqueue_flush_file
      ipv6: init the accept_queue's spinlocks in inet6_create
      bonding: return -ENOMEM instead of BUG in alb_upper_dev_walk
      bonding: remove print in bond_verify_device_path

Zhihao Cheng (1):
      ubifs: ubifs_symlink: Fix memleak of inode->i_link in error path

Zhipeng Lu (5):
      net/mlx5e: fix a double-free in arfs_create_groups
      fjes: fix memleaks in fjes_hw_setup
      net: ipv4: fix a memleak in ip_setup_cork
      atm: idt77252: fix a memleak in open_card_ubr0
      media: ir_toy: fix a memleak in irtoy_tx

Zhiquan Li (1):
      x86/mce: Mark fatal MCE's page as poison to avoid panic in the kdump kernel

Zhu Yanjun (1):
      virtio_net: Fix "‘%d’ directive writing between 1 and 11 bytes into a region of size 10" warnings

Zijun Hu (1):
      Bluetooth: qca: Set both WIDEBAND_SPEECH and LE_STATES quirks for QCA2066

bo liu (1):
      ALSA: hda/conexant: Add quirk for SWS JS201D

ching Huang (1):
      scsi: arcmsr: Support new PCI device IDs 1883 and 1886

qizhong cheng (1):
      PCI: mediatek: Clear interrupt status before dispatching handler

yuan linyu (1):
      usb: f_mass_storage: forbid async queue when shutdown happen

zhili.liu (1):
      iio: magnetometer: rm3100: add boundary check for the value read from RM3100_REG_TMRC


