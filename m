Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEFDE7ABF51
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 11:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231409AbjIWJ2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 05:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbjIWJ2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 05:28:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC137CC7;
        Sat, 23 Sep 2023 02:27:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDF84C433CA;
        Sat, 23 Sep 2023 09:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695461273;
        bh=tEfq7fqHFdjBCKsKRp8p69p76OJCHnoaOnX4mIlGA98=;
        h=From:To:Cc:Subject:Date:From;
        b=IXIUBi//+avRquRwvjI0K+fxHj1bP8q43+CDhajQhZvWdxbHf6YiPM6AG1ocUX5xy
         2wb+09cCliLrLdXINdsj7pkdi0monxUH12jbAiusbd3gXZ885IXRC6DPDViUcNGpSc
         h/Hm97/o6EAbwzE1eRBN+I58ciw1J+F5+ipB6gaA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.5.5
Date:   Sat, 23 Sep 2023 11:27:39 +0200
Message-ID: <2023092340-overpay-cognition-aa89@gregkh>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm announcing the release of the 6.5.5 kernel.

All users of the 6.5 kernel series must upgrade.

The updated 6.5.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.5.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/admin-guide/cgroup-v1/memory.rst                      |    2 
 Documentation/arch/arm64/silicon-errata.rst                         |    3 
 Makefile                                                            |    2 
 arch/arm/kernel/hw_breakpoint.c                                     |    8 
 arch/arm/kernel/machine_kexec.c                                     |   14 -
 arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts          |   16 +
 arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts        |    2 
 arch/arm64/boot/dts/qcom/sm6125-xiaomi-laurel-sprout.dts            |    2 
 arch/arm64/boot/dts/qcom/sm6350.dtsi                                |    2 
 arch/arm64/boot/dts/qcom/sm8150-sony-xperia-kumano.dtsi             |    2 
 arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo.dtsi                |    2 
 arch/arm64/kernel/hw_breakpoint.c                                   |    4 
 arch/mips/cavium-octeon/octeon-usb.c                                |    8 
 arch/powerpc/platforms/pseries/ibmebus.c                            |    1 
 arch/riscv/kernel/elf_kexec.c                                       |    8 
 arch/s390/boot/startup.c                                            |    9 
 arch/x86/boot/compressed/ident_map_64.c                             |    8 
 arch/x86/include/asm/boot.h                                         |   45 ++-
 arch/x86/include/asm/linkage.h                                      |    8 
 arch/x86/include/asm/uaccess_64.h                                   |    2 
 arch/x86/kernel/alternative.c                                       |    9 
 arch/x86/kernel/amd_nb.c                                            |    8 
 arch/x86/kernel/apic/x2apic_uv_x.c                                  |   11 
 arch/x86/kernel/callthunks.c                                        |    1 
 arch/x86/kernel/smpboot.c                                           |   12 
 arch/x86/lib/copy_user_64.S                                         |   57 ----
 arch/x86/lib/putuser.S                                              |    4 
 arch/x86/purgatory/Makefile                                         |    4 
 block/blk-mq.c                                                      |   19 +
 crypto/lrw.c                                                        |    6 
 crypto/xts.c                                                        |    6 
 drivers/acpi/acpica/psopcode.c                                      |    2 
 drivers/acpi/arm64/iort.c                                           |    5 
 drivers/acpi/video_detect.c                                         |   27 +
 drivers/acpi/x86/s2idle.c                                           |    6 
 drivers/ata/ahci.c                                                  |    9 
 drivers/ata/libahci.c                                               |   35 +-
 drivers/ata/libata-core.c                                           |    7 
 drivers/ata/libata-sata.c                                           |   19 +
 drivers/bluetooth/btusb.c                                           |   15 +
 drivers/bus/ti-sysc.c                                               |    2 
 drivers/char/tpm/tpm_tis_core.c                                     |   13 
 drivers/comedi/Kconfig                                              |  103 ++-----
 drivers/firewire/core-device.c                                      |    2 
 drivers/firewire/core-topology.c                                    |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu.h                                 |    1 
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c                              |   18 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                          |   26 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c                              |    8 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h                              |    7 
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c                             |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c                              |    2 
 drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c                 |    2 
 drivers/gpu/drm/amd/amdgpu/ih_v6_0.c                                |    4 
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c                              |    4 
 drivers/gpu/drm/amd/amdgpu/vega10_ih.c                              |    4 
 drivers/gpu/drm/amd/amdgpu/vega20_ih.c                              |    4 
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h                               |    3 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c                   |  112 ++++++--
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c        |    2 
 drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c               |   35 ++
 drivers/gpu/drm/amd/display/dc/dc.h                                 |    1 
 drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c             |   23 +
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c                   |    3 
 drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c      |    4 
 drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c    |    4 
 drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c |    7 
 drivers/gpu/drm/amd/display/dc/inc/core_types.h                     |    1 
 drivers/gpu/drm/amd/display/dc/link/link_factory.c                  |    4 
 drivers/gpu/drm/bridge/samsung-dsim.c                               |    2 
 drivers/gpu/drm/bridge/tc358762.c                                   |    2 
 drivers/gpu/drm/drm_edid.c                                          |    1 
 drivers/gpu/drm/exynos/exynos_drm_crtc.c                            |    5 
 drivers/gpu/drm/i915/display/intel_bios.c                           |   21 +
 drivers/gpu/drm/i915/display/intel_bios.h                           |    1 
 drivers/gpu/drm/i915/display/intel_dp.c                             |    7 
 drivers/gpu/drm/mediatek/mtk_dp.c                                   |    6 
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c                               |    3 
 drivers/gpu/drm/msm/adreno/adreno_device.c                          |   19 +
 drivers/gpu/drm/msm/adreno/adreno_gpu.h                             |    2 
 drivers/gpu/drm/radeon/radeon_sa.c                                  |    2 
 drivers/gpu/drm/tiny/gm12u320.c                                     |   10 
 drivers/i2c/busses/i2c-aspeed.c                                     |    7 
 drivers/interconnect/core.c                                         |   18 +
 drivers/md/dm-core.h                                                |    1 
 drivers/md/dm-ioctl.c                                               |    7 
 drivers/md/dm-table.c                                               |   32 +-
 drivers/md/dm.c                                                     |   23 -
 drivers/md/md.c                                                     |   23 +
 drivers/md/md.h                                                     |    3 
 drivers/md/raid1.c                                                  |    3 
 drivers/media/pci/cx23885/cx23885-video.c                           |    2 
 drivers/media/pci/intel/ipu3/ipu3-cio2-main.c                       |    2 
 drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c                |    2 
 drivers/media/tuners/qt1010.c                                       |   11 
 drivers/media/usb/dvb-usb-v2/af9035.c                               |    9 
 drivers/media/usb/dvb-usb-v2/anysee.c                               |    2 
 drivers/media/usb/dvb-usb-v2/az6007.c                               |    8 
 drivers/media/usb/dvb-usb-v2/gl861.c                                |    2 
 drivers/media/usb/dvb-usb/af9005.c                                  |    5 
 drivers/media/usb/dvb-usb/dw2102.c                                  |   24 +
 drivers/misc/Kconfig                                                |    1 
 drivers/mmc/host/sdhci-esdhc-imx.c                                  |    7 
 drivers/mtd/spi-nor/atmel.c                                         |    8 
 drivers/mtd/spi-nor/core.c                                          |   23 +
 drivers/mtd/spi-nor/core.h                                          |    4 
 drivers/mtd/spi-nor/issi.c                                          |    4 
 drivers/mtd/spi-nor/macronix.c                                      |    4 
 drivers/mtd/spi-nor/micron-st.c                                     |    4 
 drivers/mtd/spi-nor/spansion.c                                      |   86 +++++-
 drivers/mtd/spi-nor/sst.c                                           |    8 
 drivers/mtd/spi-nor/winbond.c                                       |    4 
 drivers/mtd/spi-nor/xilinx.c                                        |    4 
 drivers/net/can/Kconfig                                             |    4 
 drivers/net/can/sun4i_can.c                                         |   22 +
 drivers/net/ethernet/atheros/alx/ethtool.c                          |    5 
 drivers/net/ethernet/intel/ice/ice_eswitch.c                        |    3 
 drivers/net/wireless/ath/ath10k/pci.c                               |    2 
 drivers/net/wireless/ath/ath10k/usb.c                               |    2 
 drivers/net/wireless/ath/ath11k/pci.c                               |    2 
 drivers/net/wireless/ath/ath12k/dp.c                                |   30 ++
 drivers/net/wireless/ath/ath12k/dp.h                                |    2 
 drivers/net/wireless/ath/ath12k/mac.c                               |    7 
 drivers/net/wireless/ath/ath12k/pci.c                               |    2 
 drivers/net/wireless/ath/ath12k/wmi.c                               |   24 +
 drivers/net/wireless/ath/ath9k/ahb.c                                |    4 
 drivers/net/wireless/ath/ath9k/mac.h                                |    6 
 drivers/net/wireless/ath/ath9k/pci.c                                |    4 
 drivers/net/wireless/ath/ath9k/xmit.c                               |    4 
 drivers/net/wireless/ath/wil6210/txrx.c                             |    2 
 drivers/net/wireless/ath/wil6210/txrx.h                             |    6 
 drivers/net/wireless/ath/wil6210/txrx_edma.c                        |    2 
 drivers/net/wireless/ath/wil6210/txrx_edma.h                        |    6 
 drivers/net/wireless/atmel/at76c50x-usb.c                           |    8 
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c                       |   11 
 drivers/net/wireless/intersil/orinoco/orinoco_usb.c                 |   12 
 drivers/net/wireless/legacy/rndis_wlan.c                            |    2 
 drivers/net/wireless/marvell/mwifiex/tdls.c                         |    9 
 drivers/net/wireless/mediatek/mt76/mt7603/Kconfig                   |    2 
 drivers/net/wireless/mediatek/mt76/mt7615/Kconfig                   |    2 
 drivers/net/wireless/mediatek/mt76/mt76x0/Kconfig                   |    4 
 drivers/net/wireless/mediatek/mt76/mt76x2/Kconfig                   |    4 
 drivers/net/wireless/mediatek/mt76/mt7915/Kconfig                   |    2 
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c                     |    4 
 drivers/net/wireless/mediatek/mt76/mt7996/Kconfig                   |    2 
 drivers/net/wireless/mediatek/mt7601u/Kconfig                       |    2 
 drivers/net/wireless/purelifi/plfxlc/Kconfig                        |    2 
 drivers/net/wireless/ralink/rt2x00/Kconfig                          |    2 
 drivers/net/wireless/realtek/rtw88/main.c                           |    4 
 drivers/net/wireless/realtek/rtw88/pci.c                            |    2 
 drivers/net/wireless/realtek/rtw88/usb.c                            |    2 
 drivers/net/wireless/realtek/rtw89/pci.c                            |    2 
 drivers/net/wireless/virtual/mac80211_hwsim.c                       |   12 
 drivers/net/wireless/zydas/zd1201.c                                 |    6 
 drivers/nvme/host/core.c                                            |   54 ++-
 drivers/nvme/target/tcp.c                                           |    2 
 drivers/pci/controller/dwc/pci-imx6.c                               |    1 
 drivers/pci/controller/dwc/pcie-fu740.c                             |    1 
 drivers/pci/controller/vmd.c                                        |   19 +
 drivers/perf/arm_smmuv3_pmu.c                                       |   46 +++
 drivers/perf/fsl_imx8_ddr_perf.c                                    |   21 +
 drivers/platform/chrome/cros_ec_lpc.c                               |    4 
 drivers/platform/x86/eeepc-laptop.c                                 |    2 
 drivers/scsi/lpfc/lpfc.h                                            |    1 
 drivers/scsi/lpfc/lpfc_debugfs.c                                    |   14 -
 drivers/scsi/lpfc/lpfc_els.c                                        |   25 +
 drivers/scsi/lpfc/lpfc_init.c                                       |   20 +
 drivers/scsi/lpfc/lpfc_sli.c                                        |    8 
 drivers/scsi/megaraid/megaraid_sas.h                                |    2 
 drivers/scsi/megaraid/megaraid_sas_base.c                           |   21 -
 drivers/scsi/pm8001/pm8001_init.c                                   |   51 +--
 drivers/scsi/qla2xxx/qla_dfs.c                                      |    6 
 drivers/scsi/qla2xxx/qla_inline.h                                   |    2 
 drivers/scsi/qla2xxx/qla_isr.c                                      |    6 
 drivers/scsi/qla2xxx/qla_target.c                                   |    3 
 drivers/scsi/qla2xxx/tcm_qla2xxx.c                                  |    4 
 drivers/spi/spi-sun6i.c                                             |   29 +-
 drivers/staging/wlan-ng/prism2usb.c                                 |   48 +--
 drivers/target/iscsi/iscsi_target_configfs.c                        |   54 +--
 drivers/target/target_core_transport.c                              |    1 
 drivers/tty/serial/cpm_uart/cpm_uart_core.c                         |   13 
 drivers/usb/cdns3/cdns3-plat.c                                      |    3 
 drivers/usb/cdns3/cdnsp-pci.c                                       |    3 
 drivers/usb/cdns3/core.c                                            |   15 -
 drivers/usb/cdns3/core.h                                            |    7 
 drivers/usb/chipidea/ci.h                                           |    1 
 drivers/usb/chipidea/ci_hdrc_imx.c                                  |    4 
 drivers/usb/chipidea/core.c                                         |    2 
 drivers/usb/chipidea/host.c                                         |    1 
 drivers/usb/gadget/udc/fsl_qe_udc.c                                 |    2 
 drivers/usb/host/ehci-hcd.c                                         |    8 
 drivers/usb/host/ehci-hub.c                                         |   10 
 drivers/usb/host/ehci.h                                             |   10 
 drivers/usb/typec/mux/intel_pmc_mux.c                               |   25 +
 drivers/usb/typec/tcpm/Kconfig                                      |    1 
 drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c                       |   37 ++
 fs/attr.c                                                           |   20 +
 fs/autofs/waitq.c                                                   |    3 
 fs/btrfs/block-group.c                                              |   23 +
 fs/btrfs/delayed-inode.c                                            |   19 +
 fs/btrfs/disk-io.c                                                  |   22 -
 fs/btrfs/extent-tree.c                                              |   78 ++++-
 fs/btrfs/extent_io.c                                                |   43 +--
 fs/btrfs/extent_io.h                                                |    7 
 fs/btrfs/fs.h                                                       |    3 
 fs/btrfs/ioctl.c                                                    |    8 
 fs/btrfs/ordered-data.c                                             |    2 
 fs/btrfs/volumes.c                                                  |    8 
 fs/btrfs/volumes.h                                                  |    1 
 fs/btrfs/zoned.c                                                    |  131 +++++++--
 fs/btrfs/zoned.h                                                    |   20 -
 fs/efivarfs/super.c                                                 |   14 -
 fs/ext2/xattr.c                                                     |    4 
 fs/ext4/mballoc.c                                                   |   61 +---
 fs/ext4/mballoc.h                                                   |   14 +
 fs/ext4/namei.c                                                     |   26 +
 fs/iomap/buffered-io.c                                              |    2 
 fs/jfs/jfs_dmap.c                                                   |    1 
 fs/jfs/jfs_imap.c                                                   |    1 
 fs/locks.c                                                          |    2 
 fs/nfsd/nfs4proc.c                                                  |    4 
 fs/overlayfs/copy_up.c                                              |    3 
 fs/overlayfs/file.c                                                 |    9 
 fs/tracefs/inode.c                                                  |    3 
 include/drm/drm_kunit_helpers.h                                     |    4 
 include/linux/acpi_iort.h                                           |    1 
 include/linux/bpf.h                                                 |    3 
 include/linux/bpf_verifier.h                                        |    2 
 include/linux/instruction_pointer.h                                 |    5 
 include/linux/libata.h                                              |    4 
 include/linux/pci_ids.h                                             |    2 
 include/linux/perf_event.h                                          |   22 +
 include/linux/sched/task.h                                          |   28 +-
 include/linux/trace_events.h                                        |    6 
 include/linux/usb/chipidea.h                                        |    1 
 include/uapi/linux/netfilter_bridge/ebtables.h                      |   14 -
 io_uring/io_uring.c                                                 |   16 +
 io_uring/net.c                                                      |    5 
 kernel/bpf/verifier.c                                               |   13 
 kernel/fork.c                                                       |    8 
 kernel/panic.c                                                      |    1 
 kernel/power/hibernate.c                                            |   12 
 kernel/printk/internal.h                                            |    2 
 kernel/printk/printk.c                                              |  139 +++++++---
 kernel/printk/printk_safe.c                                         |    9 
 kernel/rcu/rcuscale.c                                               |    2 
 kernel/scftorture.c                                                 |    6 
 kernel/trace/trace.c                                                |   68 ++++
 kernel/trace/trace.h                                                |    2 
 kernel/trace/trace_events.c                                         |    6 
 kernel/trace/trace_events_inject.c                                  |    3 
 kernel/trace/trace_events_synth.c                                   |    2 
 lib/kobject.c                                                       |    5 
 lib/mpi/mpi-cmp.c                                                   |    8 
 mm/memcontrol.c                                                     |   10 
 net/bluetooth/hci_core.c                                            |    4 
 net/bridge/netfilter/ebtables.c                                     |    3 
 net/core/sock.c                                                     |    6 
 net/devlink/leftover.c                                              |    4 
 net/ipv4/ip_output.c                                                |    2 
 net/mac80211/cfg.c                                                  |   15 -
 net/mac80211/rx.c                                                   |    4 
 net/netlink/af_netlink.c                                            |   90 ++----
 net/netlink/af_netlink.h                                            |   22 -
 net/netlink/diag.c                                                  |   10 
 net/sunrpc/clnt.c                                                   |    2 
 net/wireless/mlme.c                                                 |   13 
 net/wireless/ocb.c                                                  |    3 
 samples/hw_breakpoint/data_breakpoint.c                             |    4 
 security/selinux/hooks.c                                            |   10 
 sound/hda/intel-dsp-config.c                                        |    8 
 sound/soc/intel/boards/sof_sdw.c                                    |    4 
 sound/soc/sof/amd/acp-ipc.c                                         |    4 
 sound/soc/sof/topology.c                                            |    5 
 tools/iio/iio_generic_buffer.c                                      |   17 -
 tools/lib/bpf/libbpf.c                                              |    1 
 tools/testing/selftests/arm64/signal/testcases/zt_regs.c            |    1 
 tools/testing/selftests/ftrace/ftracetest                           |    8 
 tools/testing/selftests/nolibc/nolibc-test.c                        |   35 ++
 279 files changed, 2255 insertions(+), 1018 deletions(-)

Abhishek Mainkar (1):
      ACPICA: Add AML_NO_OPERAND_RESOLVE flag to Timer

Alan Stern (1):
      Fix nomenclature for USB and PCI wireless devices

Alex Deucher (1):
      drm/radeon: make fence wait in suballocator uninterrruptable

Alexander Gordeev (1):
      s390/boot: cleanup number of page table levels setup

Alexander Steffen (1):
      tpm_tis: Resend command to recover from data transfer errors

Alvin Lee (1):
      drm/amd/display: Use max memclk variable when setting max memclk

Amir Goldstein (2):
      ovl: fix failed copyup of fileattr on a symlink
      ovl: fix incorrect fdput() on aio completion

Anand Jain (2):
      btrfs: add a helper to read the superblock metadata_uuid
      btrfs: compare the correct fsid/metadata_uuid in btrfs_validate_super

Andrew Kanner (1):
      fs/jfs: prevent double-free in dbUnmount() after failed jfs_remount()

AngeloGioacchino Del Regno (1):
      drm/mediatek: dp: Change logging to dev for mtk_dp_aux_transfer()

Arnd Bergmann (1):
      samples/hw_breakpoint: fix building without module unloading

Austin Zheng (1):
      drm/amd/display: Use DTBCLK as refclk instead of DPREFCLK

Avadhut Naik (1):
      x86/amd_nb: Add PCI IDs for AMD Family 1Ah-based models

Avraham Stern (1):
      wifi: iwlwifi: pcie: avoid a warning in case prepare card failed

Azeem Shaikh (1):
      crypto: lrw,xts - Replace strlcpy with strscpy

Baokun Li (3):
      ext4: add two helper functions extent_logical_end() and pa_logical_end()
      ext4: avoid overlapping preallocations due to overflow
      ext4: fix BUG in ext4_mb_new_inode_pa() due to overflow

Baoquan He (1):
      misc: open-dice: make OPEN_DICE depend on HAS_IOMEM

Chen Yu (1):
      PM: hibernate: Fix the exclusive get block device in test_resume mode

Chengming Zhou (3):
      blk-mq: fix tags leak when shrink nr_hw_queues
      blk-mq: prealloc tags when increase tagset nr_hw_queues
      blk-mq: fix tags UAF when shrinking q->nr_hw_queues

Chenyuan Mi (1):
      tools: iio: iio_generic_buffer: Fix some integer type and calculation

Chris Lu (3):
      Bluetooth: btusb: Add a new VID/PID 0489/e0f6 for MT7922
      Bluetooth: btusb: Add new VID/PID 0489/e102 for MT7922
      Bluetooth: btusb: Add new VID/PID 04ca/3804 for MT7922

Christian Brauner (1):
      attr: block mode changes of symlinks

Christian König (1):
      drm/amdgpu: fix amdgpu_cs_p1_user_fence

Christophe Leroy (1):
      serial: cpm_uart: Avoid suspicious locking

Damien Le Moal (1):
      scsi: pm8001: Setup IRQs on resume

Dave Marchevsky (2):
      bpf: Consider non-owning refs trusted
      bpf: Consider non-owning refs to refcounted nodes RCU protected

David Disseldorp (1):
      scsi: target: core: Fix target_cmd_counter leak

Ding Xiang (1):
      kselftest/arm64: fix a memleak in zt_regs_run()

Dmitry Antipov (4):
      wifi: ath9k: fix fortify warnings
      wifi: rtw88: delete timer and free skb queue when unloading
      wifi: mwifiex: fix fortify warning
      wifi: wil6210: fix fortify warnings

Dmitry Baryshkov (1):
      usb: typec: qcom-pmic-typec: register drm_bridge

Dongliang Mu (1):
      wifi: ath9k: fix printk specifier

Eric Dumazet (1):
      netlink: convert nlk->flags to atomic flags

Fedor Pchelkin (1):
      autofs: fix memory leak of waitqueues in autofs_catatonic_mode

Filipe Manana (3):
      btrfs: fix lockdep splat and potential deadlock after failure running delayed items
      btrfs: fix race between finishing block group creation and its item update
      btrfs: release path before inode lookup during the ino lookup ioctl

GONG, Ruiqi (2):
      alx: fix OOB-read compiler warning
      netfilter: ebtables: fix fortify warnings in size_entry_mwt()

Georg Ottinger (1):
      ext2: fix datatype of block number in ext2_xattr_set2()

Giulio Benetti (1):
      mmc: sdhci-esdhc-imx: improve ESDHC_FLAG_ERR010450

Greg Kroah-Hartman (2):
      Revert "memcg: drop kmem.limit_in_bytes"
      Linux 6.5.5

Hamza Mahfooz (1):
      Revert "drm/amd: Disable S/G for APUs when 64GB or more host memory"

Hans Verkuil (2):
      media: tuners: qt1010: replace BUG_ON with a regular error
      media: pci: cx23885: replace BUG with error return

Hans de Goede (1):
      ACPI: video: Add backlight=native DMI quirk for Apple iMac12,1 and iMac12,2

Hao Luo (1):
      libbpf: Free btf_vmlinux when closing bpf_object

Harish Kasiviswanathan (1):
      drm/amdkfd: Insert missing TLB flush on GFX10 and later

Heinrich Schuchardt (1):
      efivarfs: fix statfs() on efivarfs

Ian Abbott (1):
      Revert "comedi: add HAS_IOPORT dependencies"

Jeff Layton (1):
      nfsd: fix change_info in NFSv4 RENAME replies

Jens Axboe (2):
      io_uring: annotate the struct io_kiocb slab for appropriate user copy
      dm: don't attempt to queue IO under RCU protection

Jinjie Ruan (3):
      drm: gm12u320: Fix the timeout usage for usb_bulk_msg()
      scsi: qla2xxx: Fix NULL vs IS_ERR() bug for debugfs_create_dir()
      scsi: lpfc: Fix the NULL vs IS_ERR() bug for debugfs_create_file()

Jiri Pirko (1):
      devlink: remove reload failed checks in params get/set callbacks

Jiri Slaby (SUSE) (1):
      ACPI: video: Add backlight=native DMI quirk for Lenovo Ideapad Z470

Johannes Berg (6):
      wifi: mac80211: check S1G action frame size
      wifi: cfg80211: reject auth/assoc to AP with our address
      wifi: cfg80211: ocb: don't leave if not joined
      wifi: mac80211: check for station first in client probe
      wifi: mac80211_hwsim: drop short frames
      Revert "wifi: mac80211_hwsim: check the return value of nla_put_u32"

John Ogness (5):
      printk: Reduce console_unblank() usage in unsafe scenarios
      printk: Keep non-panic-CPUs out of console lock
      printk: Do not take console lock for console_flush_on_panic()
      printk: Consolidate console deferred printing
      printk: Rename abandon_console_lock_in_panic() to other_cpu_in_panic()

John Watts (2):
      can: sun4i_can: Add acceptance register quirk
      can: sun4i_can: Add support for the Allwinner D1

Josef Bacik (1):
      btrfs: check for BTRFS_FS_ERROR in pending ordered assert

Josh Poimboeuf (1):
      x86/alternatives: Remove faulty optimization

Junxiao Bi (1):
      scsi: megaraid_sas: Fix deadlock on firmware crashdump

Justin Tee (1):
      scsi: lpfc: Abort outstanding ELS cmds when mailbox timeout error is detected

Keith Busch (1):
      nvme: avoid bogus CRTO values

Kirill A. Shutemov (1):
      x86/boot/compressed: Reserve more memory for page tables

Konrad Dybcio (1):
      arm64: dts: qcom: sc8280xp-x13s: Add camera activity LED

Konstantin Shelekhin (1):
      scsi: target: iscsi: Fix buffer overflow in lio_target_nacl_info_show()

Krzysztof Kozlowski (5):
      arm64: dts: qcom: sm6125-pdx201: correct ramoops pmsg-size
      arm64: dts: qcom: sm6125-sprout: correct ramoops pmsg-size
      arm64: dts: qcom: sm6350: correct ramoops pmsg-size
      arm64: dts: qcom: sm8150-kumano: correct ramoops pmsg-size
      arm64: dts: qcom: sm8250-edo: correct ramoops pmsg-size

Kuniyuki Iwashima (1):
      net: Use sockaddr_storage for getsockopt(SO_PEERNAME).

Ladislav Michl (1):
      usb: dwc3: dwc3-octeon: Verify clock divider

Leo Chen (2):
      drm/amd/display: Blocking invalid 420 modes on HDMI TMDS for DCN31
      drm/amd/display: Blocking invalid 420 modes on HDMI TMDS for DCN314

Leo Ma (1):
      drm/amd/display: Fix underflow issue on 175hz timing

Lijo Lazar (1):
      drm/amdgpu: Update ring scheduler info as needed

Liu Shixin via Jfs-discussion (1):
      jfs: fix invalid free of JFS_IP(ipimap)->i_imap in diUnmount

Lu Hongfei (1):
      media: mdp3: Fix resource leaks in of_find_device_by_node

Lukas Wunner (1):
      panic: Reenable preemption in WARN slowpath

Ma Ke (1):
      usb: gadget: fsl_qe_udc: validate endpoint index for ch9 udc

Madhu M (1):
      usb: typec: intel_pmc_mux: Add new ACPI ID for Lunar Lake IOM device

Maksim Kiselev (1):
      spi: sun6i: add quirk for dual and quad SPI modes support

Marek Vasut (2):
      drm/bridge: tc358762: Instruct DSI host to generate HSE packets
      drm: bridge: samsung-dsim: Drain command transfer FIFO before transfer

Mario Limonciello (1):
      ACPI: x86: s2idle: Catch multiple ACPI_TYPE_PACKAGE objects

Mariusz Tkaczyk (1):
      md: Put the right device in md_seq_next

Mark Brown (1):
      PCI: dwc: Provide deinit callback for i.MX

Mark O'Donovan (1):
      crypto: lib/mpi - avoid null pointer deref in mpi_cmp_ui()

Masami Hiramatsu (Google) (1):
      selftests: tracing: Fix to unmount tracefs for recovering environment

Mateusz Guzik (1):
      x86: bring back rep movsq for user access on CPUs without ERMS

Matt Whitlock (1):
      mt76: mt7921: don't assume adequate headroom for SDIO headers

Mikulas Patocka (1):
      dm: fix a race condition in retrieve_deps

Mustapha Ghaddar (2):
      drm/amd/display: Add DPIA Link Encoder Assignment Fix
      drm/amd/display: Fix 2nd DPIA encoder Assignment

Mårten Lindahl (1):
      ARM: 9317/1: kexec: Make smp stop calls asynchronous

Naohiro Aota (5):
      btrfs: introduce struct to consolidate extent buffer write context
      btrfs: zoned: introduce block group context to btrfs_eb_write_context
      btrfs: zoned: return int from btrfs_check_meta_write_pointer
      btrfs: zoned: defer advancing meta write pointer
      btrfs: zoned: activate metadata block group on write time

Nigel Croxon (1):
      md/raid1: fix error: ISO C90 forbids mixed declarations

Niklas Cassel (2):
      ata: libata-core: fetch sense data for successful commands iff CDL enabled
      ata: libata: disallow dev-initiated LPM transitions to unsupported states

Nilesh Javali (1):
      scsi: qla2xxx: Use raw_smp_processor_id() instead of smp_processor_id()

Nirmal Patel (1):
      PCI: vmd: Disable bridge window for domain reset

Ondrej Mosnacek (1):
      selinux: fix handling of empty opts in selinux_fs_context_submount()

Paul E. McKenney (1):
      scftorture: Forgive memory-allocation failure if KASAN

Pavel Begunkov (1):
      io_uring/net: fix iter retargeting for selected buf

Peter Zijlstra (3):
      x86/ibt: Suppress spurious ENDBR
      x86/ibt: Avoid duplicate ENDBR in __put_user_nocheck*()
      x86,static_call: Fix static-call vs return-thunk

Philip Yang (1):
      drm/amdgpu: Increase soft IH ring size

Pierre-Louis Bossart (2):
      ASoC: SOF: topology: simplify code to prevent static analysis warnings
      ALSA: hda: intel-dsp-cfg: add LunarLake support

Qu Wenruo (3):
      btrfs: handle errors properly in update_inline_extent_backref()
      btrfs: output extra debug info if we failed to find an inline backref
      btrfs: fix a compilation error if DEBUG is defined in btree_dirty_folio

Rajat Soni (1):
      wifi: ath12k: Fix memory leak in rx_desc and tx_desc

Ralph Campbell (1):
      drm/edid: Add quirk for OSVR HDK 2.0

Ricardo Neri (1):
      x86/sched: Restore the SD_ASYM_PACKING flag in the DIE domain

Ritesh Harjani (IBM) (1):
      iomap: Fix possible overflow condition in iomap_write_delalloc_scan

Rob Barnes (1):
      platform/chrome: cros_ec_lpc: Remove EC panic shutdown timeout

Rob Clark (4):
      drm/msm/adreno: Use quirk identify hw_apriv
      drm/msm/adreno: Use quirk to identify cached-coherent support
      interconnect: Fix locking for runpm vs reclaim
      interconnect: Teach lockdep about icc_bw_lock order

Roger Gammans (1):
      Bluetooth: btusb: Add support for another MediaTek 7922 VID/PID

Rong Tao (1):
      samples/hw_breakpoint: Fix kernel BUG 'invalid opcode: 0000'

Sakari Ailus (1):
      media: pci: ipu3-cio2: Initialise timing struct to avoid a compiler warning

Shida Zhang (1):
      ext4: fix rec_len verify error

Simon Pilkington (1):
      drm/amd: Make fence wait in suballocator uninterruptible

Song Liu (1):
      x86/purgatory: Remove LTO flags

Song Shuai (1):
      riscv: kexec: Align the kexeced kernel entry

Steve Wahl (1):
      x86/platform/uv: Use alternate source for socket to node data

Steven Rostedt (Google) (7):
      tracing/synthetic: Fix order of struct trace_dynamic_info
      tracing: Have tracing_max_latency inc the trace array ref count
      tracing: Have event inject files inc the trace array ref count
      tracing: Increase trace array ref count on enable and filter files
      tracing: Have current_trace inc the trace array ref count
      tracing: Have option files inc the trace array ref count
      tracefs: Add missing lockdown check to tracefs_create_dir()

Szuying Chen (1):
      ata: libahci: clear pending interrupt status

Takahiro Kuwano (2):
      mtd: spi-nor: spansion: use CLPEF as an alternative to CLSR
      mtd: spi-nor: spansion: preserve CFR2V[7] when writing MEMLAT

Takashi Sakamoto (1):
      Revert "firewire: core: obsolete usage of GFP_ATOMIC at building node tree"

Tero Kristo (1):
      tracing/synthetic: Print out u64 values properly

Thomas Hellström (1):
      drm/tests: helpers: Avoid a driver uaf

Thomas Weißschuh (1):
      selftests/nolibc: prevent out of bounds access in expect_vfprintf

Tomislav Novak (1):
      hw_breakpoint: fix single-stepping when using bpf_overflow_handler

Tommy Huang (1):
      i2c: aspeed: Reset the i2c controller when timeout occurs

Tony Lindgren (1):
      bus: ti-sysc: Configure uart quirks for k3 SoC

Trond Myklebust (1):
      Revert "SUNRPC: Fail faster on bad verifier"

Tuo Li (1):
      drm/exynos: fix a possible null-pointer dereference due to data race in exynos_drm_crtc_atomic_disable()

Uday M Bhat (1):
      ASoC: Intel: sof_sdw: Update BT offload config for soundwire config

Valentin David (1):
      Bluetooth: btusb: Add device 0489:e0f5 as MT7922 device

Varun Prakash (1):
      nvmet-tcp: pass iov_len instead of sg->length to bvec_set_page()

Vijendar Mukunda (1):
      ASoC: SOF: amd: clear panic mask status when panic occurs

Ville Syrjälä (1):
      drm/i915: Only check eDP HPD when AUX CH is shared

Wander Lairson Costa (1):
      kernel/fork: beware of __put_task_struct() calling context

Wayne Lin (1):
      drm/amd/display: Adjust the MST resume flow

Wen Gong (3):
      wifi: ath12k: Fix a NULL pointer dereference in ath12k_mac_op_hw_scan()
      wifi: ath12k: avoid array overflow of hw mode for preferred_hw_mode
      wifi: ath12k: add check max message length while scanning with extraie

Will Shiu (1):
      locks: fix KASAN: use-after-free in trace_event_raw_event_filelock_lock

Wojciech Drewek (1):
      ice: Don't tx before switchdev is fully configured

Xiaolei Wang (1):
      usb: cdns3: Put the cdns set active part outside the spin lock

Xu Yang (3):
      perf/imx_ddr: speed up overflow frequency of cycle
      usb: ehci: add workaround for chipidea PORTSC.PEC bug
      usb: chipidea: add workaround for chipidea PEC bug

Yicong Yang (1):
      perf/smmuv3: Enable HiSilicon Erratum 162001900 quirk for HIP08/09

Yifan Zhang (1):
      drm/amd/display: fix the white screen issue when >= 64GB DRAM

Ying Hsu (1):
      Bluetooth: Fix hci_suspend_sync crash

Yong-Xuan Wang (1):
      PCI: fu740: Set the number of MSI vectors

Yu Kuai (2):
      md: don't dereference mddev after export_rdev()
      md: fix warning for holder mismatch from export_rdev()

Zhang Shurong (7):
      md: raid1: fix potential OOB in raid1_remove_disk()
      media: dvb-usb-v2: af9035: Fix null-ptr-deref in af9035_i2c_master_xfer
      media: dw2102: Fix null-ptr-deref in dw2102_i2c_transfer()
      media: af9005: Fix null-ptr-deref in af9005_i2c_xfer
      media: anysee: fix null-ptr-deref in anysee_master_xfer
      media: az6007: Fix null-ptr-deref in az6007_i2c_xfer()
      media: dvb-usb-v2: gl861: Fix null-ptr-deref in gl861_i2c_master_xfer

Zhangjin Wu (1):
      selftests/nolibc: fix up kernel parameters support

Zhen Lei (1):
      kobject: Add sanity check for kset->kobj.ktype in kset_register()

Zqiang (1):
      rcuscale: Move rcu_scale_writer() schedule_timeout_uninterruptible() to _idle()

ruanjinjie (1):
      powerpc/pseries: fix possible memory leak in ibmebus_bus_init()

xu xin (1):
      net/ipv4: return the real errno instead of -EINVAL

