Return-Path: <linux-kernel+bounces-129949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E63AC897266
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:23:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 068661C26EB2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 759237317F;
	Wed,  3 Apr 2024 14:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UhQIzFBh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1A7149C41;
	Wed,  3 Apr 2024 14:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712154168; cv=none; b=Z6wezxP7BVtcvA83gs5C7hZv/lQu7sjlYAB9Iv9zc4X762eBSmLHQiWfsQTQvsvEkzJEuzUzbqwANAJGBs4Yl1u+MuZ4KR0vctn4+H6vP5r9E84MNaMLY2Bd9+v7R08d8/3aSR1AqWqh7su1zSxrE14DQjG8lO0v0QP1bIff180=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712154168; c=relaxed/simple;
	bh=oGlpiSDlV8awN5uJfbmTVqAfipKd8R4PEzQRYqxeXDA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=U/ezUS7Kgh8t0Dc5srqUA3QPXT4mddVewh8LKGhrFa7VBCvbdgT2wcYYdu2Su9+UhDCegWzwBFvX0UmS2pglDWiQBZKwbdjMWWhXOzuAoYxFjRLeQy4DtQ2DrL8gEtorRFB/nUXuwJvuOI1cdolep5EZD9rrvUfq4LjE+XKbfFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UhQIzFBh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB8BFC43390;
	Wed,  3 Apr 2024 14:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712154167;
	bh=oGlpiSDlV8awN5uJfbmTVqAfipKd8R4PEzQRYqxeXDA=;
	h=From:To:Cc:Subject:Date:From;
	b=UhQIzFBhAUmkUbfGXkkYk5CNRBrw8DADpl/BC4Lcu2/B+9oI0k3KZNRXyxv8znooY
	 ltVW0PkZOaJjVeX44xA11id7gFrAknX6H2VbV0Pji5zDr152XfV0hhmtb6RQNyHS1w
	 CLdtHQAeiz6y8E/bbDr8dUgLhQHsZ1xxzy73mzHc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.24
Date: Wed,  3 Apr 2024 16:22:37 +0200
Message-ID: <2024040338-unroasted-frozen-2e73@gregkh>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.6.24 kernel.

All users of the 6.6 kernel series must upgrade.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/admin-guide/kernel-parameters.txt                  |    4 
 Documentation/arch/x86/amd-memory-encryption.rst                 |   16 
 Documentation/conf.py                                            |    6 
 Documentation/userspace-api/media/mediactl/media-types.rst       |   11 
 Makefile                                                         |    2 
 arch/arm/Kconfig                                                 |    4 
 arch/arm/boot/dts/marvell/mmp2-brownstone.dts                    |    2 
 arch/arm/configs/imx_v6_v7_defconfig                             |    1 
 arch/arm/include/asm/mman.h                                      |   14 
 arch/arm/kernel/Makefile                                         |    2 
 arch/arm/kernel/iwmmxt.S                                         |   51 -
 arch/arm/kernel/pj4-cp0.c                                        |  135 -----
 arch/arm/mm/flush.c                                              |    3 
 arch/arm64/boot/dts/qcom/sc7280.dtsi                             |   12 
 arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts       |    2 
 arch/arm64/boot/dts/qcom/sm8550-mtp.dts                          |    2 
 arch/arm64/boot/dts/qcom/sm8550-qrd.dts                          |    2 
 arch/hexagon/kernel/vmlinux.lds.S                                |    1 
 arch/loongarch/crypto/crc32-loongarch.c                          |    2 
 arch/loongarch/include/asm/Kbuild                                |    1 
 arch/loongarch/include/asm/io.h                                  |    2 
 arch/loongarch/include/asm/percpu.h                              |    7 
 arch/loongarch/include/asm/qspinlock.h                           |   18 
 arch/parisc/include/asm/assembly.h                               |   18 
 arch/parisc/include/asm/checksum.h                               |   10 
 arch/parisc/include/asm/mman.h                                   |   14 
 arch/parisc/kernel/unaligned.c                                   |   27 -
 arch/powerpc/include/asm/reg_fsl_emb.h                           |   11 
 arch/powerpc/kernel/prom.c                                       |   12 
 arch/powerpc/lib/Makefile                                        |    2 
 arch/sparc/include/asm/parport.h                                 |  259 ----------
 arch/sparc/include/asm/parport_64.h                              |  256 +++++++++
 arch/sparc/kernel/nmi.c                                          |    2 
 arch/sparc/vdso/vma.c                                            |    7 
 arch/x86/Kconfig                                                 |   13 
 arch/x86/boot/compressed/efi_mixed.S                             |   29 -
 arch/x86/coco/core.c                                             |    7 
 arch/x86/include/asm/asm.h                                       |   14 
 arch/x86/include/asm/coco.h                                      |    8 
 arch/x86/include/asm/mem_encrypt.h                               |   15 
 arch/x86/include/asm/sev.h                                       |    4 
 arch/x86/include/asm/suspend_32.h                                |   10 
 arch/x86/include/asm/x86_init.h                                  |    3 
 arch/x86/kernel/cpu/amd.c                                        |   10 
 arch/x86/kernel/eisa.c                                           |    3 
 arch/x86/kernel/fpu/xstate.c                                     |    5 
 arch/x86/kernel/fpu/xstate.h                                     |   14 
 arch/x86/kernel/kprobes/core.c                                   |   11 
 arch/x86/kernel/mpparse.c                                        |   10 
 arch/x86/kernel/nmi.c                                            |    2 
 arch/x86/kernel/probe_roms.c                                     |   10 
 arch/x86/kernel/setup.c                                          |    3 
 arch/x86/kernel/sev-shared.c                                     |   12 
 arch/x86/kernel/sev.c                                            |   31 -
 arch/x86/kernel/x86_init.c                                       |    2 
 arch/x86/kvm/cpuid.c                                             |   21 
 arch/x86/kvm/lapic.c                                             |    5 
 arch/x86/kvm/reverse_cpuid.h                                     |   35 -
 arch/x86/kvm/svm/sev.c                                           |   23 
 arch/x86/kvm/x86.c                                               |   10 
 arch/x86/kvm/xen.c                                               |    2 
 arch/x86/kvm/xen.h                                               |   18 
 arch/x86/mm/mem_encrypt_amd.c                                    |   18 
 arch/x86/mm/mem_encrypt_identity.c                               |   38 -
 block/bio.c                                                      |    7 
 block/blk-mq.c                                                   |    9 
 block/blk-settings.c                                             |    4 
 block/mq-deadline.c                                              |    3 
 drivers/accessibility/speakup/synth.c                            |    4 
 drivers/ata/ahci.c                                               |    5 
 drivers/ata/libata-eh.c                                          |    5 
 drivers/ata/libata-scsi.c                                        |    9 
 drivers/base/power/wakeirq.c                                     |    4 
 drivers/bluetooth/btnxpuart.c                                    |    3 
 drivers/char/tpm/tpm_tis_core.c                                  |    3 
 drivers/clk/qcom/gcc-ipq5018.c                                   |    3 
 drivers/clk/qcom/gcc-ipq6018.c                                   |    2 
 drivers/clk/qcom/gcc-ipq8074.c                                   |    2 
 drivers/clk/qcom/gcc-ipq9574.c                                   |    1 
 drivers/clk/qcom/gcc-sdm845.c                                    |    1 
 drivers/clk/qcom/mmcc-apq8084.c                                  |    2 
 drivers/clk/qcom/mmcc-msm8974.c                                  |    2 
 drivers/clocksource/arm_global_timer.c                           |    2 
 drivers/cpufreq/amd-pstate.c                                     |    2 
 drivers/cpufreq/cpufreq-dt.c                                     |    2 
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c              |   34 -
 drivers/crypto/intel/qat/qat_common/adf_aer.c                    |   22 
 drivers/crypto/rockchip/rk3288_crypto_ahash.c                    |    4 
 drivers/cxl/core/trace.h                                         |   14 
 drivers/firewire/ohci.c                                          |    2 
 drivers/firmware/efi/efi.c                                       |    2 
 drivers/firmware/efi/libstub/randomalloc.c                       |    2 
 drivers/firmware/efi/libstub/x86-stub.c                          |    1 
 drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c                          |   20 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c                         |   46 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c                          |    1 
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h                            |    2 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c                |   49 +
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c               |   12 
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c                |   17 
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c              |    3 
 drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c    |   13 
 drivers/gpu/drm/amd/pm/amdgpu_pm.c                               |   12 
 drivers/gpu/drm/bridge/lontium-lt8912b.c                         |   24 
 drivers/gpu/drm/drm_bridge.c                                     |   46 +
 drivers/gpu/drm/drm_panel.c                                      |   17 
 drivers/gpu/drm/drm_probe_helper.c                               |    7 
 drivers/gpu/drm/etnaviv/etnaviv_drv.c                            |    2 
 drivers/gpu/drm/etnaviv/etnaviv_hwdb.c                           |    9 
 drivers/gpu/drm/exynos/exynos_drm_vidi.c                         |    4 
 drivers/gpu/drm/exynos/exynos_hdmi.c                             |    4 
 drivers/gpu/drm/i915/display/icl_dsi.c                           |    3 
 drivers/gpu/drm/i915/display/intel_bios.c                        |   46 +
 drivers/gpu/drm/i915/display/intel_display_power_well.c          |   17 
 drivers/gpu/drm/i915/display/intel_display_trace.h               |    6 
 drivers/gpu/drm/i915/display/intel_dpll_mgr.c                    |    2 
 drivers/gpu/drm/i915/gem/i915_gem_userptr.c                      |    3 
 drivers/gpu/drm/i915/gt/intel_engine_pm.c                        |    3 
 drivers/gpu/drm/i915/gt/intel_execlists_submission.c             |    3 
 drivers/gpu/drm/i915/i915_hwmon.c                                |   37 -
 drivers/gpu/drm/imx/ipuv3/parallel-display.c                     |    4 
 drivers/gpu/drm/nouveau/include/nvkm/core/client.h               |    1 
 drivers/gpu/drm/nouveau/nouveau_dmem.c                           |   12 
 drivers/gpu/drm/nouveau/nouveau_gem.c                            |    2 
 drivers/gpu/drm/nouveau/nvkm/core/client.c                       |    1 
 drivers/gpu/drm/nouveau/nvkm/core/object.c                       |   26 -
 drivers/gpu/drm/ttm/ttm_bo_util.c                                |   13 
 drivers/gpu/drm/ttm/ttm_tt.c                                     |   13 
 drivers/gpu/drm/vc4/vc4_hdmi.c                                   |    2 
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c                              |   15 
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c                          |   14 
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c                              |   17 
 drivers/hwmon/amc6821.c                                          |   11 
 drivers/i2c/busses/i2c-i801.c                                    |    4 
 drivers/iio/accel/adxl367.c                                      |    8 
 drivers/iio/accel/adxl367_i2c.c                                  |    2 
 drivers/iio/adc/rockchip_saradc.c                                |    6 
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c                       |    2 
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c                    |    5 
 drivers/input/joystick/xpad.c                                    |    6 
 drivers/iommu/dma-iommu.c                                        |    9 
 drivers/irqchip/irq-renesas-rzg2l.c                              |   93 ++-
 drivers/leds/trigger/ledtrig-netdev.c                            |    4 
 drivers/md/dm-raid.c                                             |    2 
 drivers/md/dm-snap.c                                             |    4 
 drivers/md/md-bitmap.c                                           |    9 
 drivers/md/raid5.c                                               |   14 
 drivers/media/mc/mc-entity.c                                     |   93 ++-
 drivers/media/platform/nxp/imx8-isi/imx8-isi-crossbar.c          |    4 
 drivers/media/tuners/xc4000.c                                    |    4 
 drivers/misc/fastrpc.c                                           |   10 
 drivers/misc/lis3lv02d/lis3lv02d_i2c.c                           |   21 
 drivers/misc/mei/hw-me-regs.h                                    |    2 
 drivers/misc/mei/pci-me.c                                        |    2 
 drivers/mmc/core/block.c                                         |   14 
 drivers/mmc/host/sdhci-of-dwcmshc.c                              |   28 -
 drivers/mmc/host/sdhci-omap.c                                    |    3 
 drivers/mmc/host/tmio_mmc_core.c                                 |    2 
 drivers/mtd/nand/raw/meson_nand.c                                |    2 
 drivers/mtd/nand/raw/nand_base.c                                 |   46 +
 drivers/mtd/ubi/fastmap.c                                        |    7 
 drivers/mtd/ubi/vtbl.c                                           |    6 
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_trace.h         |    8 
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_trace.h       |    8 
 drivers/net/ethernet/xilinx/ll_temac_main.c                      |    2 
 drivers/net/wireguard/netlink.c                                  |   10 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/bca/core.c      |   15 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c      |   60 --
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.h      |    2 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c      |   33 -
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.c       |    3 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil.c          |    1 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil_types.h    |    2 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.c         |   14 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.h         |   33 -
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/wcc/core.c      |   16 
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c                      |   15 
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c                |    2 
 drivers/net/wireless/intel/iwlwifi/pcie/internal.h               |    8 
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c                     |    2 
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c                  |   12 
 drivers/net/wireless/realtek/rtw88/mac.c                         |    7 
 drivers/net/wireless/realtek/rtw88/rtw8821cu.c                   |   40 +
 drivers/nvmem/meson-efuse.c                                      |   25 
 drivers/pci/controller/dwc/pcie-designware-ep.c                  |    7 
 drivers/pci/controller/dwc/pcie-qcom.c                           |   10 
 drivers/pci/controller/pci-hyperv.c                              |    3 
 drivers/pci/pci-driver.c                                         |    7 
 drivers/pci/pcie/err.c                                           |   20 
 drivers/pci/quirks.c                                             |    2 
 drivers/phy/tegra/xusb.c                                         |   13 
 drivers/platform/x86/intel/tpmi.c                                |    9 
 drivers/powercap/intel_rapl_common.c                             |   34 +
 drivers/powercap/intel_rapl_msr.c                                |    8 
 drivers/powercap/intel_rapl_tpmi.c                               |   15 
 drivers/pwm/pwm-img.c                                            |    4 
 drivers/remoteproc/remoteproc_virtio.c                           |    6 
 drivers/s390/crypto/zcrypt_api.c                                 |    2 
 drivers/scsi/hosts.c                                             |    7 
 drivers/scsi/libsas/sas_expander.c                               |   51 +
 drivers/scsi/lpfc/lpfc_bsg.c                                     |    4 
 drivers/scsi/lpfc/lpfc_nvmet.c                                   |    2 
 drivers/scsi/qla2xxx/qla_attr.c                                  |   14 
 drivers/scsi/qla2xxx/qla_def.h                                   |    2 
 drivers/scsi/qla2xxx/qla_gbl.h                                   |    2 
 drivers/scsi/qla2xxx/qla_init.c                                  |  128 ++--
 drivers/scsi/qla2xxx/qla_iocb.c                                  |   68 +-
 drivers/scsi/qla2xxx/qla_mbx.c                                   |    2 
 drivers/scsi/qla2xxx/qla_os.c                                    |    3 
 drivers/scsi/qla2xxx/qla_target.c                                |   10 
 drivers/scsi/scsi_scan.c                                         |   34 +
 drivers/scsi/sd.c                                                |   23 
 drivers/slimbus/core.c                                           |    4 
 drivers/soc/fsl/qbman/qman.c                                     |   25 
 drivers/staging/media/ipu3/ipu3-v4l2.c                           |   16 
 drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c            |    5 
 drivers/tee/optee/device.c                                       |    3 
 drivers/thermal/devfreq_cooling.c                                |    2 
 drivers/thermal/intel/int340x_thermal/processor_thermal_device.c |    8 
 drivers/thermal/intel/int340x_thermal/processor_thermal_rapl.c   |    8 
 drivers/thermal/intel/intel_tcc.c                                |   12 
 drivers/thermal/intel/x86_pkg_temp_thermal.c                     |    8 
 drivers/thermal/mediatek/auxadc_thermal.c                        |    3 
 drivers/tty/serial/8250/8250_port.c                              |    6 
 drivers/tty/serial/fsl_lpuart.c                                  |    7 
 drivers/tty/serial/imx.c                                         |   22 
 drivers/tty/serial/max310x.c                                     |    7 
 drivers/tty/serial/qcom_geni_serial.c                            |   10 
 drivers/tty/serial/serial_core.c                                 |   12 
 drivers/tty/serial/serial_port.c                                 |   25 
 drivers/tty/vt/vt.c                                              |    2 
 drivers/usb/class/cdc-wdm.c                                      |    6 
 drivers/usb/core/hub.c                                           |   23 
 drivers/usb/core/hub.h                                           |    2 
 drivers/usb/core/port.c                                          |   43 +
 drivers/usb/core/sysfs.c                                         |   16 
 drivers/usb/dwc2/core.h                                          |   14 
 drivers/usb/dwc2/core_intr.c                                     |   72 +-
 drivers/usb/dwc2/gadget.c                                        |   10 
 drivers/usb/dwc2/hcd.c                                           |   49 +
 drivers/usb/dwc2/hcd_ddma.c                                      |   17 
 drivers/usb/dwc2/hw.h                                            |    2 
 drivers/usb/dwc2/platform.c                                      |    2 
 drivers/usb/dwc3/core.c                                          |    2 
 drivers/usb/dwc3/core.h                                          |    2 
 drivers/usb/dwc3/dwc3-am62.c                                     |   13 
 drivers/usb/dwc3/dwc3-pci.c                                      |    2 
 drivers/usb/dwc3/gadget.c                                        |   10 
 drivers/usb/dwc3/host.c                                          |   11 
 drivers/usb/gadget/function/f_ncm.c                              |    2 
 drivers/usb/gadget/udc/core.c                                    |    4 
 drivers/usb/gadget/udc/tegra-xudc.c                              |   39 -
 drivers/usb/host/xhci-ring.c                                     |    8 
 drivers/usb/host/xhci.c                                          |    2 
 drivers/usb/phy/phy-generic.c                                    |    7 
 drivers/usb/serial/cp210x.c                                      |    4 
 drivers/usb/serial/ftdi_sio.c                                    |    2 
 drivers/usb/serial/ftdi_sio_ids.h                                |    6 
 drivers/usb/serial/option.c                                      |    6 
 drivers/usb/storage/isd200.c                                     |   23 
 drivers/usb/storage/uas.c                                        |   28 -
 drivers/usb/typec/altmodes/displayport.c                         |   18 
 drivers/usb/typec/class.c                                        |    7 
 drivers/usb/typec/tcpm/tcpm.c                                    |    7 
 drivers/usb/typec/ucsi/ucsi.c                                    |   46 +
 drivers/usb/typec/ucsi/ucsi.h                                    |    4 
 drivers/usb/typec/ucsi/ucsi_acpi.c                               |   75 +-
 drivers/vfio/fsl-mc/vfio_fsl_mc_intr.c                           |    7 
 drivers/vfio/pci/pds/lm.c                                        |   13 
 drivers/vfio/pci/pds/lm.h                                        |    1 
 drivers/vfio/pci/pds/vfio_dev.c                                  |    4 
 drivers/vfio/pci/vfio_pci_intrs.c                                |  176 ++++--
 drivers/vfio/platform/vfio_platform_irq.c                        |  105 ++--
 drivers/vfio/virqfd.c                                            |   21 
 drivers/virtio/virtio.c                                          |   10 
 fs/aio.c                                                         |    8 
 fs/btrfs/block-group.c                                           |    3 
 fs/btrfs/extent_io.c                                             |   75 ++
 fs/btrfs/qgroup.c                                                |   10 
 fs/btrfs/scrub.c                                                 |   12 
 fs/btrfs/volumes.c                                               |    2 
 fs/dlm/user.c                                                    |   10 
 fs/exec.c                                                        |    1 
 fs/ext4/mballoc.c                                                |   17 
 fs/ext4/resize.c                                                 |    3 
 fs/f2fs/f2fs.h                                                   |    1 
 fs/f2fs/segment.c                                                |    4 
 fs/fat/nfs.c                                                     |    6 
 fs/fuse/dir.c                                                    |    6 
 fs/fuse/file.c                                                   |    8 
 fs/fuse/fuse_i.h                                                 |    1 
 fs/fuse/inode.c                                                  |    7 
 fs/nfs/direct.c                                                  |   11 
 fs/nfs/read.c                                                    |    2 
 fs/nfs/write.c                                                   |    2 
 fs/nfsd/trace.h                                                  |    2 
 fs/nilfs2/btree.c                                                |    9 
 fs/nilfs2/direct.c                                               |    9 
 fs/nilfs2/inode.c                                                |    2 
 fs/smb/client/cached_dir.c                                       |    3 
 fs/smb/client/cifs_debug.c                                       |    2 
 fs/smb/client/cifsglob.h                                         |    5 
 fs/smb/client/cifsproto.h                                        |    8 
 fs/smb/client/connect.c                                          |   10 
 fs/smb/client/file.c                                             |    8 
 fs/smb/client/fs_context.c                                       |   27 -
 fs/smb/client/inode.c                                            |   17 
 fs/smb/client/readdir.c                                          |  133 ++---
 fs/smb/client/sess.c                                             |   45 -
 fs/smb/client/smb2ops.c                                          |    2 
 fs/smb/client/smb2pdu.c                                          |   10 
 fs/smb/server/smb2pdu.c                                          |  180 ++++--
 fs/smb/server/smb_common.c                                       |   11 
 fs/smb/server/vfs.c                                              |   12 
 fs/ubifs/file.c                                                  |   13 
 fs/xfs/libxfs/xfs_ag.c                                           |   36 +
 fs/xfs/libxfs/xfs_ag.h                                           |    2 
 fs/xfs/libxfs/xfs_attr.c                                         |    6 
 fs/xfs/libxfs/xfs_bmap.c                                         |   75 +-
 fs/xfs/libxfs/xfs_btree_staging.c                                |    4 
 fs/xfs/libxfs/xfs_btree_staging.h                                |    6 
 fs/xfs/libxfs/xfs_da_btree.c                                     |    7 
 fs/xfs/libxfs/xfs_defer.c                                        |  105 ++--
 fs/xfs/libxfs/xfs_defer.h                                        |    5 
 fs/xfs/libxfs/xfs_format.h                                       |    2 
 fs/xfs/libxfs/xfs_log_recover.h                                  |    5 
 fs/xfs/libxfs/xfs_rtbitmap.c                                     |    2 
 fs/xfs/libxfs/xfs_rtbitmap.h                                     |   83 +++
 fs/xfs/libxfs/xfs_sb.c                                           |   20 
 fs/xfs/libxfs/xfs_sb.h                                           |    2 
 fs/xfs/libxfs/xfs_types.h                                        |   13 
 fs/xfs/scrub/common.c                                            |    6 
 fs/xfs/scrub/common.h                                            |   25 
 fs/xfs/scrub/fscounters.c                                        |    2 
 fs/xfs/scrub/inode.c                                             |    8 
 fs/xfs/scrub/reap.c                                              |    2 
 fs/xfs/scrub/rtbitmap.c                                          |    3 
 fs/xfs/scrub/rtsummary.c                                         |    3 
 fs/xfs/scrub/trace.h                                             |    3 
 fs/xfs/xfs_attr_item.c                                           |   23 
 fs/xfs/xfs_bmap_item.c                                           |   14 
 fs/xfs/xfs_buf.c                                                 |   44 +
 fs/xfs/xfs_buf.h                                                 |    1 
 fs/xfs/xfs_extfree_item.c                                        |   14 
 fs/xfs/xfs_fsmap.c                                               |    2 
 fs/xfs/xfs_fsops.c                                               |    9 
 fs/xfs/xfs_inode_item.c                                          |    3 
 fs/xfs/xfs_log.c                                                 |    1 
 fs/xfs/xfs_log_priv.h                                            |    1 
 fs/xfs/xfs_log_recover.c                                         |  118 ++--
 fs/xfs/xfs_refcount_item.c                                       |   13 
 fs/xfs/xfs_rmap_item.c                                           |   14 
 fs/xfs/xfs_rtalloc.c                                             |   14 
 fs/xfs/xfs_rtalloc.h                                             |   73 --
 fs/xfs/xfs_trans.h                                               |    4 
 include/drm/drm_bridge.h                                         |   33 +
 include/drm/drm_modeset_helper_vtables.h                         |    3 
 include/drm/ttm/ttm_tt.h                                         |    9 
 include/linux/cpu.h                                              |    2 
 include/linux/cpufreq.h                                          |   15 
 include/linux/gfp.h                                              |    9 
 include/linux/hyperv.h                                           |   22 
 include/linux/intel_rapl.h                                       |    6 
 include/linux/intel_tcc.h                                        |    2 
 include/linux/libata.h                                           |    1 
 include/linux/mman.h                                             |    8 
 include/linux/mtd/spinand.h                                      |    2 
 include/linux/nfs_fs.h                                           |    1 
 include/linux/phy/tegra/xusb.h                                   |    1 
 include/linux/ring_buffer.h                                      |    1 
 include/linux/serial_core.h                                      |    3 
 include/linux/skbuff.h                                           |   10 
 include/linux/vfio.h                                             |    2 
 include/media/media-entity.h                                     |    2 
 include/net/cfg80211.h                                           |    2 
 include/net/cfg802154.h                                          |    1 
 include/scsi/scsi_driver.h                                       |    1 
 include/scsi/scsi_host.h                                         |    1 
 include/uapi/linux/snmp.h                                        |    3 
 init/Kconfig                                                     |    6 
 init/initramfs.c                                                 |    2 
 io_uring/io_uring.c                                              |    5 
 io_uring/net.c                                                   |    5 
 kernel/bounds.c                                                  |    2 
 kernel/cgroup/cpuset.c                                           |    2 
 kernel/dma/swiotlb.c                                             |   35 -
 kernel/entry/common.c                                            |    8 
 kernel/power/suspend.c                                           |    1 
 kernel/printk/printk.c                                           |   27 -
 kernel/sched/core.c                                              |   38 -
 kernel/sys.c                                                     |    7 
 kernel/trace/ring_buffer.c                                       |  233 +++++---
 kernel/trace/trace.c                                             |   21 
 kernel/workqueue.c                                               |    2 
 lib/pci_iomap.c                                                  |    2 
 mm/compaction.c                                                  |    7 
 mm/filemap.c                                                     |   16 
 mm/kasan/kasan_test.c                                            |    3 
 mm/memtest.c                                                     |    4 
 mm/mmap.c                                                        |   10 
 mm/page_alloc.c                                                  |   10 
 mm/shmem_quota.c                                                 |   10 
 mm/swapfile.c                                                    |   13 
 mm/vmscan.c                                                      |    5 
 net/bluetooth/hci_core.c                                         |    6 
 net/bluetooth/hci_sync.c                                         |    5 
 net/ipv4/esp4.c                                                  |    8 
 net/ipv4/ip_output.c                                             |    2 
 net/ipv4/proc.c                                                  |    3 
 net/ipv6/esp6.c                                                  |    8 
 net/ipv6/ip6_output.c                                            |    6 
 net/ipv6/mcast.c                                                 |    5 
 net/ipv6/ndisc.c                                                 |    2 
 net/ipv6/proc.c                                                  |    3 
 net/ipv6/raw.c                                                   |    2 
 net/mac80211/cfg.c                                               |    5 
 net/mac802154/llsec.c                                            |   18 
 net/netfilter/nf_tables_api.c                                    |    7 
 net/wireless/wext-core.c                                         |    7 
 net/xfrm/xfrm_user.c                                             |    3 
 scripts/Makefile.extrawarn                                       |    2 
 security/landlock/syscalls.c                                     |   18 
 security/smack/smack_lsm.c                                       |   12 
 sound/pci/hda/patch_realtek.c                                    |   13 
 sound/pci/hda/tas2781_hda_i2c.c                                  |   83 +--
 sound/sh/aica.c                                                  |   17 
 sound/soc/amd/yc/acp6x-mach.c                                    |    7 
 tools/include/linux/btf_ids.h                                    |    2 
 tools/perf/builtin-top.c                                         |    4 
 tools/testing/selftests/mm/gup_test.c                            |   67 +-
 tools/testing/selftests/mm/soft-dirty.c                          |    2 
 tools/testing/selftests/mm/split_huge_page_test.c                |    2 
 tools/testing/selftests/mm/uffd-common.c                         |    3 
 tools/testing/selftests/mm/uffd-common.h                         |    2 
 tools/testing/selftests/mm/uffd-unit-tests.c                     |   13 
 tools/testing/selftests/mqueue/setting                           |    1 
 tools/testing/selftests/net/mptcp/diag.sh                        |    6 
 tools/testing/selftests/wireguard/qemu/arch/riscv32.config       |    1 
 tools/testing/selftests/wireguard/qemu/arch/riscv64.config       |    1 
 virt/kvm/async_pf.c                                              |   31 +
 440 files changed, 4308 insertions(+), 2478 deletions(-)

Adamos Ttofari (1):
      x86/fpu: Keep xfd_state in sync with MSR_IA32_XFD

Akira Yokosawa (1):
      docs: Restore "smart quotes" for quotes

Alan Stern (4):
      USB: usb-storage: Prevent divide-by-0 error in isd200_ata_command
      USB: core: Fix deadlock in usb_deauthorize_interface()
      USB: core: Add hub_get() and hub_put() routines
      USB: core: Fix deadlock in port "disable" sysfs attribute

Alex Deucher (1):
      drm/amd/display: handle range offsets in VRR ranges

Alex Williamson (7):
      vfio/pci: Disable auto-enable of exclusive INTx IRQ
      vfio/pci: Lock external INTx masking ops
      vfio/platform: Disable virqfds on cleanup
      vfio: Introduce interface to flush virqfd inject workqueue
      vfio/pci: Create persistent INTx handler
      vfio/platform: Create persistent IRQ handlers
      vfio/fsl-mc: Block calling interrupt handler without trigger

Alexander Aring (1):
      dlm: fix user space lkb refcounting

Alexander Stein (1):
      Revert "usb: phy: generic: Get the vbus supply"

Alexander Usyskin (2):
      mei: me: add arrow lake point S DID
      mei: me: add arrow lake point H DID

Alison Schofield (1):
      cxl/trace: Properly initialize cxl_poison region name

Amit Pundir (1):
      clk: qcom: gcc-sdm845: Add soft dependency on rpmhpd

Andrey Albershteyn (1):
      xfs: reset XFS_ATTR_INCOMPLETE filter on node removal

Andrey Jr. Melnikov (1):
      ahci: asm1064: correct count of reported ports

Andrey Skvortsov (1):
      crypto: sun8i-ce - Fix use after free in unprepare

André Rösti (1):
      entry: Respect changes to system call number by trace_sys_enter()

Andy Chi (1):
      ALSA: hda/realtek: fix mute/micmute LEDs for HP EliteBook

Anton Altaparmakov (1):
      x86/pm: Work around false positive kmemleak report in msr_build_context()

Ard Biesheuvel (6):
      x86/efistub: Call mixed mode boot services on the firmware's stack
      x86/sev: Fix position dependent variable references in startup code
      ARM: 9352/1: iwmmxt: Remove support for PJ4/PJ4B cores
      x86/efistub: Add missing boot_params for mixed mode compat entry
      efi/libstub: Cast away type warning in use of max()
      x86/efistub: Reinstate soft limit for initrd loading

Arend van Spriel (2):
      wifi: brcmfmac: avoid invalid list operation when vendor attach fails
      wifi: brcmfmac: add per-vendor feature detection callback

Arnd Bergmann (2):
      kasan/test: avoid gcc warning for intentional overflow
      staging: vc04_services: changen strncpy() to strscpy_pad()

Arseniy Krasnov (1):
      mtd: rawnand: meson: fix scrambling mode value in command macro

Audra Mitchell (1):
      workqueue: Shorten events_freezable_power_efficient name

Aurélien Jacobs (1):
      USB: serial: option: add MeiG Smart SLM320 product

Badhri Jagan Sridharan (1):
      usb: typec: tpcm: Fix PORT_RESET behavior for self powered devices

Baokun Li (1):
      ext4: correct best extent lstart adjustment logic

Bart Van Assche (2):
      Revert "block/mq-deadline: use correct way to throttling write requests"
      fs/aio: Check IOCB_AIO_RW before the struct aio_kiocb conversion

Benjamin Coddington (1):
      NFS: Read unlock folio on nfs_page_create_from_folio() error

Bernd Schubert (1):
      fuse: fix VM_MAYSHARE and direct_io_allow_mmap

Bharath SM (1):
      cifs: prevent updating file size from server if we have a read/write lease

Biju Das (4):
      irqchip/renesas-rzg2l: Flush posted write in irq_eoi()
      irqchip/renesas-rzg2l: Rename rzg2l_tint_eoi()
      irqchip/renesas-rzg2l: Rename rzg2l_irq_eoi()
      irqchip/renesas-rzg2l: Prevent spurious interrupts when setting trigger type

Bikash Hazarika (1):
      scsi: qla2xxx: Update manufacturer detail

Bitterblue Smith (1):
      wifi: rtw88: 8821cu: Fix connection failure

Borislav Petkov (AMD) (2):
      x86/CPU/AMD: Update the Zenbleed microcode revisions
      x86/Kconfig: Remove CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT

Breno Leitao (1):
      x86/nmi: Fix the inverse "in NMI handler" check

Brett Creeley (2):
      vfio/pds: Always clear the save/restore FDs on reset
      vfio/pds: Make sure migration file isn't accessed after reset

Cameron Williams (1):
      USB: serial: add device ID for VeriFone adapter

Carlos Maiolino (1):
      tmpfs: fix race on handling dquot rbtree

Chris Wilson (1):
      drm/i915/gt: Reset queue_priority_hint on parking

Christian A. Ehrhardt (4):
      usb: typec: ucsi: Clear EVENT_PENDING under PPM lock
      usb: typec: ucsi: Ack unsupported commands
      usb: typec: ucsi_acpi: Refactor and fix DELL quirk
      usb: typec: ucsi: Clear UCSI_CCI_RESET_COMPLETE before reset

Christian Gmeiner (1):
      drm/etnaviv: Restore some id values

Christian Häggström (1):
      USB: serial: cp210x: add ID for MGP Instruments PDS100

Christian Marangi (1):
      leds: trigger: netdev: Fix kernel panic on interface rename trig notify

Christoph Hellwig (1):
      xfs: consider minlen sized extents in xfs_rtallocate_extent_block

Christophe JAILLET (1):
      slimbus: core: Remove usage of the deprecated ida_simple_xx() API

Claudiu Beznea (2):
      irqchip/renesas-rzg2l: Implement restriction when writing ISCR register
      irqchip/renesas-rzg2l: Add macro to retrieve TITSR register offset based on register's index

Claus Hansen Ries (1):
      net: ll_temac: platform_get_resource replaced by wrong function

Conrad Kostecki (1):
      ahci: asm1064: asm1166: don't limit reported ports

Cosmin Tanislav (2):
      iio: accel: adxl367: fix DEVID read after reset
      iio: accel: adxl367: fix I2C FIFO data register

Damian Muszynski (1):
      crypto: qat - resolve race condition during AER recovery

Damien Le Moal (3):
      block: Clear zone limits for a non-zoned stacked queue
      block: Do not force full zone append completion in req_bio_endio()
      scsi: sd: Fix TCG OPAL unlock on system resume

Dan Carpenter (3):
      cifs: delete unnecessary NULL checks in cifs_chan_update_iface()
      cifs: make cifs_chan_update_iface() a void function
      staging: vc04_services: fix information leak in create_component()

Daniel Vogelbacher (1):
      USB: serial: ftdi_sio: add support for GMC Z216C Adapter IR-USB

Darrick J. Wong (16):
      xfs: move the xfs_rtbitmap.c declarations to xfs_rtbitmap.h
      xfs: convert rt bitmap extent lengths to xfs_rtbxlen_t
      xfs: don't leak recovered attri intent items
      xfs: use xfs_defer_pending objects to recover intent items
      xfs: pass the xfs_defer_pending object to iop_recover
      xfs: transfer recovered intent item ownership in ->iop_recover
      xfs: make rextslog computation consistent with mkfs
      xfs: fix 32-bit truncation in xfs_compute_rextslog
      xfs: don't allow overly small or large realtime volumes
      xfs: make xchk_iget safer in the presence of corrupt inode btrees
      xfs: remove unused fields from struct xbtree_ifakeroot
      xfs: recompute growfsrtfree transaction reservation while growing rt volume
      xfs: fix an off-by-one error in xreap_agextent_binval
      xfs: force all buffers to be written during btree bulk load
      xfs: add missing nrext64 inode flag check to scrub
      xfs: remove conditional building of rt geometry validator functions

Dave Airlie (1):
      nouveau: lock the client object tree.

Dave Chinner (1):
      xfs: initialise di_crc in xfs_log_dinode

Dave Hansen (1):
      Revert "x86/bugs: Use fixed addressing for VERW operand"

David Hildenbrand (1):
      virtio: reenable config if freezing device failed

David Woodhouse (1):
      KVM: x86/xen: inject vCPU upcall vector when local APIC is enabled

Dominique Martinet (1):
      mmc: core: Fix switch on gp3 partition

Douglas Anderson (1):
      Revert "tty: serial: simplify qcom_geni_serial_send_chunk_fifo()"

Dragos Tatulea (1):
      net: esp: fix bad handling of pages from page_pool

Duje Mihanović (1):
      arm: dts: marvell: Fix maxium->maxim typo in brownstone dts

Duoming Zhou (2):
      nouveau/dmem: handle kcalloc() allocation failure
      ALSA: sh: aica: reorder cleanup operations to avoid UAF bugs

Edmund Raile (1):
      firewire: ohci: prevent leak of left-over IRQ on unbind

Edward Liaw (2):
      selftests/mm: sigbus-wp test requires UFFD_FEATURE_WP_HUGETLBFS_SHMEM
      selftests/mm: fix ARM related issue with fork after pthread_create

Ekansh Gupta (1):
      misc: fastrpc: Pass proper arguments to scm call

Eric Huang (1):
      drm/amdkfd: fix TLB flush after unmap for GFX9.4.2

Eric Sandeen (1):
      xfs: short circuit xfs_growfs_data_private() if delta is zero

Eugene Korenevsky (1):
      cifs: open_cached_dir(): add FILE_READ_EA to desired access

Ezra Buehler (1):
      mtd: spinand: Add support for 5-byte IDs

Fabio Estevam (1):
      ARM: imx_v6_v7_defconfig: Restore CONFIG_BACKLIGHT_CLASS_DEVICE

Fedor Pchelkin (1):
      mac802154: fix llsec key resources release in mac802154_llsec_key_del

Felix Fietkau (1):
      wifi: mac80211: check/clear fast rx for non-4addr sta VLAN changes

Filipe Manana (1):
      btrfs: fix off-by-one chunk length calculation at contains_pending_extent()

Frank Wunderlich (1):
      thermal/drivers/mediatek: Fix control buffer enablement on MT7896

Gabor Juhos (6):
      clk: qcom: gcc-ipq5018: fix terminating of frequency table arrays
      clk: qcom: gcc-ipq6018: fix terminating of frequency table arrays
      clk: qcom: gcc-ipq8074: fix terminating of frequency table arrays
      clk: qcom: gcc-ipq9574: fix terminating of frequency table arrays
      clk: qcom: mmcc-apq8084: fix terminating of frequency table arrays
      clk: qcom: mmcc-msm8974: fix terminating of frequency table arrays

Geliang Tang (1):
      selftests: mptcp: diag: return KSFT_FAIL not test_cnt

George Shen (1):
      drm/amd/display: Disconnect phantom pipe OPP from OPTC being disabled

Gergo Koteles (2):
      ALSA: hda/tas2781: remove digital gain kcontrol
      ALSA: hda/tas2781: add locks to kcontrols

Greg Kroah-Hartman (1):
      Linux 6.6.24

Guenter Roeck (5):
      parisc/unaligned: Rewrite 64-bit inline assembly of emulate_ldd()
      parisc: Fix ip_fast_csum
      parisc: Fix csum_ipv6_magic on 32-bit systems
      parisc: Fix csum_ipv6_magic on 64-bit systems
      parisc: Strip upper 32 bit of sum in csum_ipv6_magic for 64-bit builds

Gui-Dong Han (2):
      media: xc4000: Fix atomicity violation in xc4000_get_frequency
      md/raid5: fix atomicity violation in raid5_cache_count

Guilherme G. Piccoli (1):
      scsi: core: Fix unremoved procfs host directory regression

Hans de Goede (1):
      misc: lis3lv02d_i2c: Fix regulators getting en-/dis-abled twice on suspend/resume

Harald Freudenberger (1):
      s390/zcrypt: fix reference counting on zcrypt card objects

Harry Wentland (1):
      Revert "drm/amd/display: Fix sending VSC (+ colorimetry) packets for DP/eDP displays without PSR"

Hector Martin (2):
      wifi: brcmfmac: cfg80211: Use WSEC to set SAE password
      wifi: brcmfmac: Demote vendor-specific attach/detach messages to info

Heikki Krogerus (1):
      usb: dwc3: pci: Drop duplicate ID

Heiner Kallweit (1):
      i2c: i801: Avoid potential double call to gpiod_remove_lookup_table

Heming Zhao (1):
      md/md-bitmap: fix incorrect usage for sb_index

Heng Guo (1):
      net: fix IPSTATS_MIB_OUTPKGS increment in OutForwDatagrams.

Herbert Xu (1):
      crypto: rk3288 - Fix use after free in unprepare

Hidenori Kobayashi (1):
      media: staging: ipu3-imgu: Set fields before media_entity_pads_init()

Huacai Chen (2):
      LoongArch: Change __my_cpu_offset definition to avoid mis-optimization
      LoongArch: Define the __io_aw() hook as mmiowb()

Hugo Villeneuve (1):
      serial: max310x: fix NULL pointer dereference in I2C instantiation

Ilya Bakoulin (2):
      drm/amd/display: Fix hang/underflow when transitioning to ODM4:1
      drm/amd/display: Clear OPTC mem select on disable

Jameson Thies (1):
      usb: typec: ucsi: Clean up UCSI_CABLE_PROP macros

Jan Kara (1):
      fat: fix uninitialized field in nostale filehandles

Jani Nikula (9):
      drm/probe-helper: warn about negative .get_modes()
      drm/panel: do not return negative error codes from drm_panel_get_modes()
      drm/exynos: do not return negative values from .get_modes()
      drm/imx/ipuv3: do not return negative values from .get_modes()
      drm/vc4: hdmi: do not return negative values from .get_modes()
      drm/bridge: add ->edid_read hook and drm_bridge_edid_read()
      drm/bridge: lt8912b: use drm_bridge_edid_read()
      drm/bridge: lt8912b: clear the EDID property on failures
      drm/bridge: lt8912b: do not return negative values from .get_modes()

Janusz Krzysztofik (1):
      drm/i915/hwmon: Fix locking inversion in sysfs getter

Jason A. Donenfeld (3):
      wireguard: netlink: check for dangling peer via is_dead instead of empty list
      wireguard: netlink: access device through ctx instead of peer
      wireguard: selftests: set RISCV_ISA_FALLBACK on riscv{32,64}

Jean-Baptiste Maneyrol (2):
      iio: imu: inv_mpu6050: fix frequency setting when chip is off
      iio: imu: inv_mpu6050: fix FIFO parsing when empty

Jeff Layton (1):
      server: convert to new timestamp accessors

Jens Axboe (1):
      io_uring/net: correctly handle multishot recvmsg retry setup

Jerome Brunet (1):
      nvmem: meson-efuse: fix function pointer type mismatch

Jiachen Zhang (1):
      xfs: ensure logflagsp is initialized in xfs_bmap_del_extent_real

Jiawei Wang (1):
      ASoC: amd: yc: Revert "Fix non-functional mic on Lenovo 21J2"

Jim Mattson (2):
      KVM: x86: Advertise CPUID.(EAX=7,ECX=2):EDX[5:0] to userspace
      KVM: x86: Use a switch statement and macros in __feature_translate()

Joakim Zhang (1):
      remoteproc: virtio: Fix wdg cannot recovery remote processor

Jocelyn Falempe (1):
      drm/vmwgfx: Create debugfs ttm_resource_manager entry only if needed

Johan Hovold (1):
      arm64: dts: qcom: sc8280xp-x13s: limit pcie4 link speed

Johannes Berg (4):
      wifi: iwlwifi: pcie: fix RB status reading
      wifi: cfg80211: add a flag to disable wireless extensions
      wifi: iwlwifi: mvm: disable MLO for the time being
      wifi: iwlwifi: fw: don't always use FW dump trig

Johannes Thumshirn (2):
      btrfs: zoned: don't skip block groups with 100% zone unusable
      btrfs: zoned: use zone aware sb location for scrub

Johannes Weiner (2):
      mm: cachestat: fix two shmem bugs
      drm/amdgpu: fix deadlock while reading mqd from debugfs

John David Anglin (1):
      parisc: Avoid clobbering the C/B bits in the PSW with tophys and tovirt macros

John Ogness (1):
      printk: Update @console_may_schedule in console_trylock_spinning()

John Sperbeck (1):
      init: open /initrd.image with O_LARGEFILE

Jonas Gorski (1):
      serial: core: only stop transmit when HW fifo is empty

Jonathon Hall (1):
      drm/i915: Do not match JSL in ehl_combo_pll_div_frac_wa_needed()

Josef Bacik (2):
      nfs: fix UAF in direct writes
      btrfs: fix deadlock with fiemap and extent locking

Josua Mayer (1):
      hwmon: (amc6821) add of_match table

KONDO KAZUMA(近藤　和真) (1):
      efi/libstub: fix efi_random_alloc() to allocate memory at alloc_min or higher address

Kailang Yang (2):
      ALSA: hda/realtek - Fix headset Mic no show at resume back for Lenovo ALC897 platform
      ALSA: hda/realtek - Add Headset Mic supported Acer NB platform

Kamalesh Babulal (1):
      cgroup/cpuset: Fix retval in update_cpumask()

Kan Liang (1):
      perf top: Use evsel's cpus to replace user_requested_cpus

Karol Herbst (1):
      drm/nouveau: fix stale locked mutex in nouveau_gem_ioctl_pushbuf

Kees Cook (1):
      init/Kconfig: lower GCC version check for -Warray-bounds

Kevin Loughlin (1):
      x86/sev: Skip ROM range scans and validation for SEV-SNP guests

Krishna Kurapati (1):
      usb: gadget: ncm: Fix handling of zero block length packets

Krishna chaitanya chundru (1):
      arm64: dts: qcom: sc7280: Add additional MSI interrupts

Krzysztof Kozlowski (2):
      arm64: dts: qcom: sm8550-qrd: correct WCD9385 TX port mapping
      arm64: dts: qcom: sm8550-mtp: correct WCD9385 TX port mapping

Kyle Tso (1):
      usb: typec: Return size of buffer if pd_set operation succeeds

Laurent Pinchart (6):
      media: mc: Add local pad to pipeline regardless of the link state
      media: mc: Fix flags handling when creating pad links
      media: mc: Add num_links flag to media_pad
      media: mc: Rename pad variable to clarify intent
      media: mc: Expand MUST_CONNECT flag to always require an enabled link
      media: nxp: imx8-isi: Mark all crossbar sink pads as MUST_CONNECT

Leo Ma (1):
      drm/amd/display: Fix noise issue on HDMI AV mute

Liming Sun (1):
      sdhci-of-dwcmshc: disable PM runtime in dwcmshc_remove()

Lino Sanfilippo (1):
      tpm,tpm_tis: Avoid warning splat at shutdown

Long Li (2):
      xfs: add lock protection when remove perag from radix tree
      xfs: fix perag leak when growfs fails

Luiz Augusto von Dentz (1):
      Bluetooth: hci_sync: Fix not checking error on hci_cmd_sync_cancel_sync

Ma Jun (1):
      drm/amdgpu/pm: Fix the error of pwm1_enable setting

Manivannan Sadhasivam (1):
      PCI: qcom: Enable BDF to SID translation properly

Marcel Ziswiler (1):
      Bluetooth: btnxpuart: Fix btnxpuart_close

Marek Szyprowski (1):
      cpufreq: dt: always allocate zeroed cpumask

Marek Vasut (1):
      media: nxp: imx8-isi: Check whether crossbar pad is non-NULL before access

Mario Limonciello (1):
      drm/amd/display: Use freesync when `DRM_EDID_FEATURE_CONTINUOUS_FREQ` found

Marios Makassikis (2):
      ksmbd: replace generic_fillattr with vfs_getattr
      ksmbd: retrieve number of blocks using vfs_getattr in set_file_allocation_info

Martin Blumenstingl (1):
      clocksource/drivers/arm_global_timer: Fix maximum prescaler value

Masami Hiramatsu (Google) (1):
      kprobes/x86: Use copy_from_kernel_nofault() to read from unsafe address

Mathias Nyman (2):
      usb: port: Don't try to peer unused USB ports based on location
      xhci: Fix failure to detect ring expansion need.

Matthew Wilcox (Oracle) (2):
      bounds: support non-power-of-two CONFIG_NR_CPUS
      ubifs: Set page uptodate in the correct place

Maulik Shah (1):
      PM: suspend: Set mem_sleep_current during kernel command line setup

Max Filippov (1):
      exec: Fix NOMMU linux_binprm::exec in transfer_args_to_stack()

Max Nguyen (1):
      Input: xpad - add additional HyperX Controller Identifiers

Maximilian Heyne (1):
      ext4: fix corruption during on-line resize

Michael Ellerman (3):
      powerpc/smp: Adjust nr_cpu_ids to cover all threads of a core
      powerpc/smp: Increase nr_cpu_ids to include the boot CPU
      powerpc/fsl: Fix mfpmr build errors with newer binutils

Michael Kelley (2):
      PCI: hv: Fix ring buffer size calculation
      Drivers: hv: vmbus: Calculate ring buffer size for more efficient use of memory

Mickaël Salaün (1):
      landlock: Warn once if a Landlock action is requested while disabled

Mikko Rapeli (2):
      mmc: core: Initialize mmc_blk_ioc_data
      mmc: core: Avoid negative index with array access

Miklos Szeredi (3):
      fuse: replace remaining make_bad_inode() with fuse_make_bad()
      fuse: fix root lookup with nonzero generation
      fuse: don't unhash root

Mikulas Patocka (1):
      dm snapshot: fix lockup in dm_exception_table_exit

Minas Harutyunyan (5):
      usb: dwc2: host: Fix remote wakeup from hibernation
      usb: dwc2: host: Fix hibernation flow
      usb: dwc2: host: Fix ISOC flow in DDMA mode
      usb: dwc2: gadget: Fix exiting from clock gating
      usb: dwc2: gadget: LPM flow fix

Miquel Raynal (2):
      mtd: rawnand: Fix and simplify again the continuous read derivations
      mtd: rawnand: Constrain even more when continuous reads are enabled

Muhammad Usama Anjum (3):
      selftests/mm: gup_test: conform test to TAP format output
      scsi: lpfc: Correct size for cmdwqe/rspwqe for memset()
      scsi: lpfc: Correct size for wqe for memset()

Natanael Copa (1):
      tools/resolve_btfids: fix build with musl libc

Nathan Chancellor (4):
      powerpc: xor_vmx: Add '-mhard-float' to CFLAGS
      kbuild: Move -Wenum-{compare-conditional,enum-conversion} into W=1
      xfrm: Avoid clang fortify warning in copy_to_user_tmpl()
      hexagon: vmlinux.lds.S: handle attributes section

Nick Morrow (1):
      wifi: rtw88: Add missing VID/PIDs for 8811CU and 8821CU

Nicolas Pitre (1):
      vt: fix unicode buffer corruption when deleting characters

Nicolin Chen (1):
      iommu/dma: Force swiotlb_max_mapping_size on an untrusted device

Niklas Cassel (1):
      PCI: dwc: endpoint: Fix advertised resizable BAR size

Nirmoy Das (1):
      drm/i915: Check before removing mm notifier

Oleksandr Tymoshenko (1):
      efi: fix panic in kdump kernel

Oliver Neukum (1):
      usb: cdc-wdm: close race between read and workqueue

Pablo Neira Ayuso (3):
      netfilter: nf_tables: mark set as dead when unbinding anonymous set with timeout
      netfilter: nf_tables: disallow anonymous set with timeout flag
      netfilter: nf_tables: reject constant set with timeout

Paolo Bonzini (1):
      SEV: disable SEV-ES DebugSwap by default

Paul Menzel (1):
      PCI/DPC: Quirk PIO log size for Intel Raptor Lake Root Ports

Paulo Alcantara (1):
      smb: client: stop revalidating reparse points unnecessarily

Pavel Begunkov (2):
      io_uring: fix mshot io-wq checks
      io_uring: clean rings on NO_MMAP alloc fail

Pawan Gupta (1):
      x86/bugs: Use fixed addressing for VERW operand

Peter Collingbourne (1):
      serial: Lock console when calling into driver before registration

Peter Zijlstra (1):
      sched: Simplify tg_set_cfs_bandwidth()

Philip Yang (1):
      drm/amdgpu: amdgpu_ttm_gart_bind set gtt bound flag

Philipp Stanner (1):
      pci_iounmap(): Fix MMIO mapping leak

Prashanth K (1):
      usb: xhci: Add error handling in xhci_map_urb_for_dma

Qiang Zhang (1):
      memtest: use {READ,WRITE}_ONCE in memory scanning

Qingliang Li (1):
      PM: sleep: wakeirq: fix wake irq warning in system suspend

Qu Wenruo (1):
      btrfs: qgroup: always free reserved space for extent records

Quentin Schulz (2):
      iio: adc: rockchip_saradc: fix bitmask for channels on SARADCv2
      iio: adc: rockchip_saradc: use mask for write_enable bitfield

Quinn Tran (6):
      scsi: qla2xxx: Prevent command send on chip reset
      scsi: qla2xxx: Fix N2N stuck connection
      scsi: qla2xxx: Split FCE|EFT trace control
      scsi: qla2xxx: NVME|FCP prefer flag not being honored
      scsi: qla2xxx: Fix command flush on cable pull
      scsi: qla2xxx: Delay I/O Abort on PCI error

RD Babiera (1):
      usb: typec: altmodes/displayport: create sysfs nodes as driver's default device attribute group

Rafael J. Wysocki (1):
      PCI/PM: Drain runtime-idle callbacks before driver removal

Randy Dunlap (2):
      sparc64: NMI watchdog: fix return value of __setup handler
      sparc: vDSO: fix return value of __setup handler

Richard Weinberger (1):
      ubi: Check for too small LEB size in VTBL code

Rickard x Andersson (1):
      tty: serial: imx: Fix broken RS485

Roberto Sassu (2):
      smack: Set SMACK64TRANSMUTE only for dirs in smack_inode_setxattr()
      smack: Handle SMACK64TRANSMUTE in smack_inode_setsecurity()

Rodrigo Siqueira (1):
      drm/amd/display: Return the correct HDCP error code

Roger Quadros (2):
      usb: dwc3-am62: fix module unload/reload behavior
      usb: dwc3-am62: Disable wakeup at remove

Romain Naour (1):
      mmc: sdhci-omap: re-tuning is needed after a pm transition to support emmc HS200 mode

Ryan Roberts (1):
      mm: swap: fix race between free_swap_and_cache() and swapoff()

Ryusuke Konishi (2):
      nilfs2: fix failure to detect DAT corruption in btree and direct mappings
      nilfs2: prevent kernel bug at submit_bh_wbc()

Sam Ravnborg (1):
      sparc32: Fix parport build with sparc32

Samuel Thibault (1):
      speakup: Fix 8bit characters from direct synth

Saurav Kashyap (3):
      scsi: qla2xxx: Fix double free of the ha->vp_map pointer
      scsi: qla2xxx: Fix double free of fcport
      scsi: qla2xxx: Change debug message during driver unload

Sean Anderson (2):
      soc: fsl: qbman: Always disable interrupts when taking cgr_lock
      soc: fsl: qbman: Use raw spinlock for cgr_lock

Sean Christopherson (3):
      KVM: Always flush async #PF workqueue when vCPU is being destroyed
      KVM: x86: Mark target gfn of emulated atomic instruction as dirty
      KVM: SVM: Flush pages under kvm->lock to fix UAF in svm_register_enc_region()

SeongJae Park (1):
      selftests/mqueue: Set timeout to 180 seconds

Sherry Sun (1):
      tty: serial: fsl_lpuart: avoid idle preamble pending if CTS is enabled

Shivnandan Kumar (1):
      cpufreq: Limit resolving a frequency to policy min/max

Shyam Prasad N (4):
      cifs: add xid to query server interface call
      cifs: make sure server interfaces are requested only for SMB3+
      cifs: do not let cifs_chan_update_iface deallocate channels
      cifs: reduce warning log level for server not advertising interfaces

Srinivas Pandruvada (1):
      platform/x86/intel/tpmi: Change vsec offset to u64

Stanislaw Gruszka (1):
      PCI/AER: Block runtime suspend when handling errors

Steve French (1):
      cifs: allow changing password during remount

Steven Rostedt (Google) (9):
      ring-buffer: Fix waking up ring buffer readers
      ring-buffer: Do not set shortest_full when full target is hit
      ring-buffer: Fix resetting of shortest_full
      ring-buffer: Fix full_waiters_pending in poll
      ring-buffer: Use wait_event_interruptible() in ring_buffer_wait()
      NFSD: Fix nfsd_clid_class use of __string_len() macro
      drm/i915: Add missing ; to __assign_str() macros in tracepoint code
      net: hns3: tracing: fix hclgevf trace event strings
      tracing: Use .flush() call to wake up readers

Sumit Garg (1):
      tee: optee: Fix kernel panic caused by incorrect error handling

Sunmin Jeong (2):
      f2fs: mark inode dirty for FI_ATOMIC_COMMITTED flag
      f2fs: truncate page cache before clearing flags when aborting atomic write

Tavian Barnes (1):
      btrfs: fix race in read_extent_buffer_pages()

Thinh Nguyen (1):
      usb: dwc3: Properly set system wakeup

Thomas Gleixner (1):
      x86/mpparse: Register APIC address only once

Tony Battersby (1):
      block: Fix page refcounts for unaligned buffers in __bio_release_pages()

Tor Vic (1):
      cpufreq: amd-pstate: Fix min_perf assignment in amd_pstate_adjust_perf()

Toru Katagiri (1):
      USB: serial: cp210x: add pid/vid for TDK NC0110013M and MM0110113M

Ville Syrjälä (3):
      drm/i915: Don't explode when the dig port we don't have an AUX CH
      drm/i915/bios: Tolerate devdata==NULL in intel_bios_encoder_supports_dp_dual_mode()
      drm/i915/dsi: Go back to the previous INIT_OTP/DISPLAY_ON order, mostly

Vitaly Chikunov (1):
      selftests/mm: Fix build with _FORTIFY_SOURCE

Vitaly Prosyak (1):
      drm/amdgpu: fix use-after-free bug

Vlastimil Babka (2):
      mm, mmap: fix vma_merge() case 7 with vma_ops->close
      mm, vmscan: prevent infinite loop for costly GFP_NOIO | __GFP_RETRY_MAYFAIL allocations

Wayne Chang (2):
      phy: tegra: xusb: Add API to retrieve the port number of phy
      usb: gadget: tegra-xudc: Fix USB3 PHY retrieval logic

Weitao Wang (1):
      USB: UAS: return ENODEV when submit urbs fail with device not attached

Will Deacon (3):
      swiotlb: Fix double-allocation of slots due to broken alignment handling
      swiotlb: Honour dma_alloc_coherent() alignment in swiotlb_alloc()
      swiotlb: Fix alignment checks when both allocation and DMA masks are present

Wolfram Sang (1):
      mmc: tmio: avoid concurrent runs of mmc_request_done()

Xingui Yang (2):
      scsi: libsas: Add a helper sas_get_sas_addr_and_dev_type()
      scsi: libsas: Fix disk not being scanned in after being removed

Ye Zhang (1):
      thermal: devfreq_cooling: Fix perf state when calculate dfc res_util

Yicong Yang (1):
      serial: port: Don't suspend if the port is still busy

Yongqiang Liu (1):
      ARM: 9359/1: flush: check if the folio is reserved for no-mapping addresses

Yu Kuai (1):
      dm-raid: fix lockdep waring in "pers->hot_add_disk"

Yuli Wang (1):
      LoongArch/crypto: Clean up useless assignment operations

Zack Rusin (4):
      drm/vmwgfx: Unmap the surface before resetting it on a plane state
      drm/vmwgfx: Fix possible null pointer derefence with invalid contexts
      drm/vmwgfx: Fix the lifetime of the bo cursor memory
      drm/ttm: Make sure the mapped tt pages are decrypted when needed

Zev Weiss (2):
      prctl: generalize PR_SET_MDWE support check to be per-arch
      ARM: prctl: reject PR_SET_MDWE on pre-ARMv6

Zhang Rui (5):
      thermal/intel: Fix intel_tcc_get_temp() to support negative CPU temperature
      powercap: intel_rapl: Fix a NULL pointer dereference
      powercap: intel_rapl: Fix locking in TPMI RAPL
      powercap: intel_rapl_tpmi: Fix a register bug
      powercap: intel_rapl_tpmi: Fix System Domain probing

Zhang Tianci (1):
      xfs: update dir3 leaf block metadata after swap

Zhang Yi (1):
      ubi: correct the calculation of fastmap size

Zheng Wang (1):
      wifi: brcmfmac: Fix use-after-free bug in brcmf_cfg80211_detach

Zoltan HERPAI (1):
      pwm: img: fix pwm clock lookup

yuan linyu (1):
      usb: udc: remove warning when queue disabled ep


