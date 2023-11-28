Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4167FC309
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:25:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345832AbjK1SZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 13:25:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjK1SZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 13:25:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FEBB9D
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 10:25:30 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FFBDC433C7;
        Tue, 28 Nov 2023 18:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1701195929;
        bh=FM/aYBdi294klMt0AojxfDrn0F5w6y6QV+6BA5Hot94=;
        h=From:To:Cc:Subject:Date:From;
        b=inazheuAeeQ1/KP850pZA5Ko3AaevrV5/X5ZtLGeoCm8b4pqUvsY7Oxc7EJKBc7M8
         H/6jiRAcsKoyqe+1uC525bSfvzCyEoMcub1WqEpzvQ9Y3Sth/HXhzTWr5XIpfI/yKB
         D1IbvFZkTJidU02YWbP0OWiOdtF5wse2Ut5vwfZ8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.64
Date:   Tue, 28 Nov 2023 18:25:25 +0000
Message-ID: <2023112826-glitter-onion-8533@gregkh>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm announcing the release of the 6.1.64 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/admin-guide/kernel-parameters.txt            |    7 
 Makefile                                                   |    2 
 arch/arm/include/asm/exception.h                           |    4 
 arch/arm64/Kconfig                                         |    2 
 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi             |   46 ++-
 arch/arm64/boot/dts/qcom/ipq6018.dtsi                      |    4 
 arch/arm64/boot/dts/qcom/ipq8074.dtsi                      |    2 
 arch/loongarch/include/asm/percpu.h                        |   10 
 arch/parisc/include/uapi/asm/pdc.h                         |    1 
 arch/parisc/kernel/entry.S                                 |    7 
 arch/parisc/kernel/head.S                                  |    5 
 arch/powerpc/perf/core-book3s.c                            |    5 
 arch/powerpc/platforms/powernv/opal-prd.c                  |   17 -
 arch/riscv/include/asm/page.h                              |    4 
 arch/riscv/kernel/probes/simulate-insn.c                   |    2 
 arch/riscv/kernel/smp.c                                    |    1 
 arch/riscv/mm/ptdump.c                                     |    3 
 arch/s390/mm/page-states.c                                 |    6 
 arch/x86/crypto/sha1_ssse3_glue.c                          |   12 
 arch/x86/crypto/sha256_ssse3_glue.c                        |   12 
 arch/x86/include/asm/msr-index.h                           |    1 
 arch/x86/include/asm/numa.h                                |    7 
 arch/x86/kernel/cpu/hygon.c                                |    8 
 arch/x86/kvm/hyperv.c                                      |   10 
 arch/x86/kvm/lapic.c                                       |   26 +-
 arch/x86/kvm/x86.c                                         |    2 
 arch/x86/mm/numa.c                                         |    7 
 crypto/pcrypt.c                                            |    4 
 drivers/acpi/acpi_fpdt.c                                   |   45 +++
 drivers/acpi/ec.c                                          |   10 
 drivers/acpi/resource.c                                    |   12 
 drivers/atm/iphase.c                                       |   20 -
 drivers/base/dd.c                                          |    2 
 drivers/base/regmap/regcache.c                             |   30 ++
 drivers/block/virtio_blk.c                                 |    4 
 drivers/bluetooth/btusb.c                                  |   15 +
 drivers/clk/qcom/gcc-ipq6018.c                             |    6 
 drivers/clk/qcom/gcc-ipq8074.c                             |    6 
 drivers/clk/socfpga/stratix10-clk.h                        |    4 
 drivers/clk/visconti/pll.h                                 |    5 
 drivers/clocksource/timer-atmel-tcb.c                      |    1 
 drivers/clocksource/timer-imx-gpt.c                        |   18 +
 drivers/cpufreq/cpufreq_stats.c                            |   14 -
 drivers/crypto/hisilicon/qm.c                              |    2 
 drivers/cxl/acpi.c                                         |    2 
 drivers/cxl/core/core.h                                    |   11 
 drivers/cxl/core/hdm.c                                     |    3 
 drivers/cxl/core/port.c                                    |   91 +++----
 drivers/cxl/core/region.c                                  |  134 +++++++---
 drivers/cxl/cxl.h                                          |    4 
 drivers/cxl/cxlmem.h                                       |   12 
 drivers/cxl/mem.c                                          |   38 +++
 drivers/dma/stm32-mdma.c                                   |    4 
 drivers/firmware/qcom_scm.c                                |    7 
 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c                   |    5 
 drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c                |    1 
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c                     |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c                |    6 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                 |   11 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c                    |    9 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c                    |    7 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c                   |    2 
 drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c                     |    5 
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c                       |   13 -
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c          |   24 +
 drivers/gpu/drm/amd/display/dc/core/dc.c                   |   20 +
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c            |    4 
 drivers/gpu/drm/amd/display/dc/dc.h                        |    5 
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c         |    3 
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h                |   22 +
 drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c            |   32 +-
 drivers/gpu/drm/amd/include/pptable.h                      |    4 
 drivers/gpu/drm/amd/pm/amdgpu_pm.c                         |    8 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/pptable_v1_0.h      |   16 -
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c                  |    2 
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h              |    2 
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h               |    4 
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c            |    4 
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c    |    8 
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c             |    4 
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c       |   40 ---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c       |    9 
 drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c |    9 
 drivers/gpu/drm/drm_lease.c                                |    4 
 drivers/gpu/drm/gma500/psb_drv.h                           |    1 
 drivers/gpu/drm/gma500/psb_irq.c                           |    5 
 drivers/gpu/drm/i915/display/intel_cdclk.c                 |   12 
 drivers/gpu/drm/i915/gem/i915_gem_context.c                |    1 
 drivers/gpu/drm/i915/i915_perf.c                           |   15 -
 drivers/gpu/drm/mediatek/mtk_dp.c                          |    6 
 drivers/gpu/drm/msm/dp/dp_panel.c                          |   21 -
 drivers/gpu/drm/panel/panel-arm-versatile.c                |    2 
 drivers/gpu/drm/panel/panel-sitronix-st7703.c              |   25 +-
 drivers/gpu/drm/panel/panel-tpo-tpg110.c                   |    2 
 drivers/gpu/drm/qxl/qxl_display.c                          |    3 
 drivers/gpu/drm/radeon/radeon_connectors.c                 |    2 
 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c                    |    4 
 drivers/hid/hid-ids.h                                      |    1 
 drivers/hid/hid-lenovo.c                                   |  118 ++++++---
 drivers/hid/hid-quirks.c                                   |    1 
 drivers/i2c/busses/i2c-designware-master.c                 |   19 +
 drivers/i2c/busses/i2c-i801.c                              |   19 -
 drivers/i2c/busses/i2c-pxa.c                               |   76 +++++-
 drivers/i2c/busses/i2c-sun6i-p2wi.c                        |    5 
 drivers/i2c/i2c-core-base.c                                |   13 -
 drivers/i2c/i2c-core.h                                     |    2 
 drivers/i2c/i2c-dev.c                                      |    4 
 drivers/i3c/master/i3c-master-cdns.c                       |    6 
 drivers/i3c/master/mipi-i3c-hci/dat_v1.c                   |   29 +-
 drivers/i3c/master/mipi-i3c-hci/dma.c                      |    2 
 drivers/i3c/master/svc-i3c-master.c                        |   60 ++++
 drivers/iio/adc/stm32-adc-core.c                           |    9 
 drivers/infiniband/hw/hfi1/pcie.c                          |    9 
 drivers/input/joystick/xpad.c                              |    1 
 drivers/mcb/mcb-core.c                                     |    1 
 drivers/mcb/mcb-parse.c                                    |    2 
 drivers/md/dm-verity-fec.c                                 |    4 
 drivers/md/dm-verity-target.c                              |   23 -
 drivers/md/dm-verity.h                                     |    2 
 drivers/media/i2c/ccs/ccs-core.c                           |    2 
 drivers/media/i2c/ccs/ccs-quirk.h                          |    4 
 drivers/media/pci/cobalt/cobalt-driver.c                   |   11 
 drivers/media/platform/qcom/camss/camss-csid-gen2.c        |    9 
 drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c   |    2 
 drivers/media/platform/qcom/camss/camss-vfe-170.c          |   22 -
 drivers/media/platform/qcom/camss/camss-vfe-480.c          |   22 -
 drivers/media/platform/qcom/camss/camss-vfe.c              |    5 
 drivers/media/platform/qcom/camss/camss.c                  |   12 
 drivers/media/platform/qcom/venus/hfi_msgs.c               |    2 
 drivers/media/platform/qcom/venus/hfi_parser.c             |   15 +
 drivers/media/platform/qcom/venus/hfi_venus.c              |   10 
 drivers/media/rc/imon.c                                    |    6 
 drivers/media/rc/ir-sharp-decoder.c                        |    8 
 drivers/media/rc/lirc_dev.c                                |    6 
 drivers/media/test-drivers/vivid/vivid-rds-gen.c           |    2 
 drivers/media/usb/gspca/cpia1.c                            |    3 
 drivers/mfd/intel-lpss-pci.c                               |   13 +
 drivers/mfd/qcom-spmi-pmic.c                               |  101 +++++---
 drivers/misc/pci_endpoint_test.c                           |    4 
 drivers/mmc/core/block.c                                   |    4 
 drivers/mmc/core/card.h                                    |    4 
 drivers/mmc/core/mmc.c                                     |    8 
 drivers/mmc/core/quirks.h                                  |    7 
 drivers/mmc/host/meson-gx-mmc.c                            |    1 
 drivers/mmc/host/sdhci-pci-gli.c                           |   30 ++
 drivers/mmc/host/sdhci_am654.c                             |    2 
 drivers/mmc/host/vub300.c                                  |    1 
 drivers/mtd/chips/cfi_cmdset_0001.c                        |   20 +
 drivers/mtd/nand/raw/intel-nand-controller.c               |   10 
 drivers/mtd/nand/raw/meson_nand.c                          |    3 
 drivers/mtd/nand/raw/tegra_nand.c                          |    4 
 drivers/net/bonding/bond_main.c                            |    6 
 drivers/net/dsa/lan9303_mdio.c                             |    4 
 drivers/net/ethernet/atheros/atl1c/atl1c.h                 |    3 
 drivers/net/ethernet/atheros/atl1c/atl1c_main.c            |   67 +----
 drivers/net/ethernet/cortina/gemini.c                      |   45 ++-
 drivers/net/ethernet/cortina/gemini.h                      |    4 
 drivers/net/ethernet/engleder/tsnep.h                      |    2 
 drivers/net/ethernet/engleder/tsnep_main.c                 |   12 
 drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c         |    9 
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c            |    2 
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c    |   33 ++
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  |   25 +-
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h  |    1 
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_mbx.c   |    7 
 drivers/net/ethernet/marvell/mvneta.c                      |   28 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c   |    4 
 drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c        |   30 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c       |   13 -
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c           |   12 
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c            |   60 ++--
 drivers/net/ethernet/realtek/r8169_main.c                  |   46 ++-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c          |    3 
 drivers/net/ipvlan/ipvlan_core.c                           |   41 ++-
 drivers/net/macvlan.c                                      |    2 
 drivers/net/phy/phylink.c                                  |    1 
 drivers/net/ppp/ppp_synctty.c                              |    6 
 drivers/net/wireless/ath/ath10k/debug.c                    |    2 
 drivers/net/wireless/ath/ath10k/snoc.c                     |   18 +
 drivers/net/wireless/ath/ath11k/dp_rx.c                    |    8 
 drivers/net/wireless/ath/ath11k/wmi.c                      |   19 +
 drivers/net/wireless/ath/ath9k/debug.c                     |    2 
 drivers/net/wireless/ath/ath9k/htc_drv_debug.c             |    2 
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c                |   14 -
 drivers/net/wireless/mac80211_hwsim.c                      |    2 
 drivers/net/wireless/microchip/wilc1000/wlan.c             |    2 
 drivers/net/wireless/purelifi/plfxlc/mac.c                 |    2 
 drivers/parisc/power.c                                     |   16 +
 drivers/pci/controller/dwc/pci-exynos.c                    |    4 
 drivers/pci/controller/dwc/pci-keystone.c                  |    8 
 drivers/pci/controller/dwc/pcie-kirin.c                    |    4 
 drivers/pci/controller/dwc/pcie-tegra194.c                 |    9 
 drivers/pci/controller/pci-mvebu.c                         |    2 
 drivers/pci/pci-acpi.c                                     |    2 
 drivers/pci/pci-sysfs.c                                    |   10 
 drivers/pci/pci.c                                          |   22 -
 drivers/pci/pcie/aspm.c                                    |    2 
 drivers/pci/probe.c                                        |    6 
 drivers/pci/quirks.c                                       |   41 ++-
 drivers/platform/chrome/cros_ec_proto_test.c               |    1 
 drivers/platform/x86/thinkpad_acpi.c                       |    1 
 drivers/ptp/ptp_chardev.c                                  |    3 
 drivers/ptp/ptp_clock.c                                    |    5 
 drivers/ptp/ptp_private.h                                  |    8 
 drivers/ptp/ptp_sysfs.c                                    |    3 
 drivers/s390/crypto/ap_bus.c                               |    4 
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c                     |   13 -
 drivers/scsi/ibmvscsi/ibmvfc.c                             |  124 +++++++++-
 drivers/scsi/libfc/fc_lport.c                              |    6 
 drivers/scsi/megaraid/megaraid_sas_base.c                  |    4 
 drivers/scsi/mpt3sas/mpt3sas_base.c                        |    4 
 drivers/scsi/qla2xxx/qla_os.c                              |   12 
 drivers/soc/bcm/bcm2835-power.c                            |    2 
 drivers/soc/imx/gpc.c                                      |    1 
 drivers/soundwire/dmi-quirks.c                             |    2 
 drivers/thunderbolt/quirks.c                               |    3 
 drivers/tty/hvc/hvc_xen.c                                  |   39 ++-
 drivers/tty/serial/meson_uart.c                            |   14 -
 drivers/tty/sysrq.c                                        |    3 
 drivers/tty/vcc.c                                          |   16 +
 drivers/usb/dwc3/core.c                                    |  160 ++++++++++---
 drivers/usb/dwc3/core.h                                    |   13 +
 drivers/usb/gadget/function/f_ncm.c                        |   27 --
 drivers/usb/host/xhci-pci.c                                |    4 
 drivers/vhost/vdpa.c                                       |    1 
 drivers/watchdog/sbsa_gwdt.c                               |    4 
 drivers/xen/events/events_base.c                           |    4 
 fs/9p/xattr.c                                              |    5 
 fs/btrfs/delalloc-space.c                                  |    3 
 fs/btrfs/inode.c                                           |    7 
 fs/exfat/namei.c                                           |   29 +-
 fs/ext4/acl.h                                              |    5 
 fs/ext4/extents_status.c                                   |    4 
 fs/ext4/file.c                                             |  153 +++++-------
 fs/ext4/inode.c                                            |   14 +
 fs/ext4/resize.c                                           |   23 -
 fs/f2fs/compress.c                                         |    2 
 fs/f2fs/node.c                                             |    7 
 fs/f2fs/xattr.c                                            |   20 +
 fs/gfs2/inode.c                                            |   14 -
 fs/gfs2/quota.c                                            |   11 
 fs/gfs2/super.c                                            |    2 
 fs/inode.c                                                 |   16 +
 fs/jbd2/recovery.c                                         |    8 
 fs/jfs/jfs_dmap.c                                          |   23 +
 fs/jfs/jfs_imap.c                                          |    5 
 fs/nfs/nfs4proc.c                                          |   12 
 fs/nfsd/nfs4state.c                                        |    2 
 fs/overlayfs/super.c                                       |    2 
 fs/proc/proc_sysctl.c                                      |    8 
 fs/quota/dquot.c                                           |   14 +
 fs/smb/client/cifs_debug.c                                 |    6 
 fs/smb/client/cifs_spnego.c                                |    4 
 fs/smb/client/cifsfs.c                                     |    1 
 fs/smb/client/cifspdu.h                                    |    2 
 fs/smb/client/cifsproto.h                                  |    7 
 fs/smb/client/connect.c                                    |   15 -
 fs/smb/client/inode.c                                      |    4 
 fs/smb/client/sess.c                                       |    1 
 fs/smb/client/smb2misc.c                                   |    2 
 fs/smb/client/smb2ops.c                                    |    8 
 fs/smb/client/smb2transport.c                              |    5 
 fs/smb/client/transport.c                                  |   11 
 fs/smb/client/xattr.c                                      |    5 
 fs/smb/server/smb_common.c                                 |   11 
 fs/smb/server/smbacl.c                                     |   29 ++
 fs/xfs/xfs_inode_item_recover.c                            |   32 +-
 include/linux/damon.h                                      |    7 
 include/linux/ethtool.h                                    |    4 
 include/linux/fs.h                                         |   45 +++
 include/linux/generic-radix-tree.h                         |    7 
 include/linux/lsm_hook_defs.h                              |    4 
 include/linux/mmc/card.h                                   |    2 
 include/linux/preempt.h                                    |   15 +
 include/linux/pwm.h                                        |    4 
 include/linux/socket.h                                     |    1 
 include/linux/string.h                                     |   40 +++
 include/linux/sunrpc/clnt.h                                |    1 
 include/linux/sysctl.h                                     |    6 
 include/linux/trace_events.h                               |    4 
 include/linux/workqueue.h                                  |   46 +++
 include/net/netfilter/nf_tables.h                          |    4 
 include/net/sock.h                                         |   26 +-
 include/sound/soc-acpi.h                                   |    7 
 include/sound/soc-card.h                                   |   37 +++
 include/sound/soc.h                                        |   11 
 include/sound/sof.h                                        |    8 
 include/uapi/linux/vm_sockets.h                            |   17 +
 init/main.c                                                |    4 
 kernel/audit_watch.c                                       |    9 
 kernel/bpf/core.c                                          |    6 
 kernel/bpf/verifier.c                                      |   16 +
 kernel/cpu.c                                               |   11 
 kernel/debug/debug_core.c                                  |    3 
 kernel/events/ring_buffer.c                                |    6 
 kernel/irq/generic-chip.c                                  |   25 +-
 kernel/kexec.c                                             |    2 
 kernel/locking/test-ww_mutex.c                             |   20 -
 kernel/padata.c                                            |    2 
 kernel/power/snapshot.c                                    |   16 -
 kernel/rcu/srcutree.c                                      |    4 
 kernel/rcu/tree.c                                          |   21 +
 kernel/rcu/tree.h                                          |    4 
 kernel/rcu/tree_stall.h                                    |   20 +
 kernel/reboot.c                                            |    1 
 kernel/smp.c                                               |   13 -
 kernel/trace/trace.c                                       |   15 +
 kernel/trace/trace.h                                       |    3 
 kernel/trace/trace_events.c                                |   43 ++-
 kernel/trace/trace_events_filter.c                         |    3 
 kernel/trace/trace_events_synth.c                          |    2 
 kernel/watch_queue.c                                       |    2 
 kernel/watchdog.c                                          |    7 
 kernel/workqueue.c                                         |   20 -
 lib/generic-radix-tree.c                                   |   17 +
 mm/cma.c                                                   |    2 
 mm/damon/lru_sort.c                                        |    4 
 mm/damon/ops-common.c                                      |    5 
 mm/damon/sysfs.c                                           |   87 ++++---
 mm/huge_memory.c                                           |   16 -
 mm/memcontrol.c                                            |    3 
 mm/memory_hotplug.c                                        |    2 
 net/9p/client.c                                            |    2 
 net/9p/trans_fd.c                                          |   13 -
 net/bluetooth/hci_conn.c                                   |    6 
 net/bluetooth/hci_sysfs.c                                  |   23 -
 net/bridge/netfilter/nf_conntrack_bridge.c                 |    2 
 net/core/sock.c                                            |    2 
 net/ipv4/inet_hashtables.c                                 |    2 
 net/ipv4/tcp_output.c                                      |    2 
 net/mac80211/cfg.c                                         |    4 
 net/mptcp/pm_netlink.c                                     |    5 
 net/mptcp/protocol.c                                       |    4 
 net/mptcp/sockopt.c                                        |    3 
 net/ncsi/ncsi-aen.c                                        |    5 
 net/netfilter/nf_tables_api.c                              |   53 ++--
 net/netfilter/nft_byteorder.c                              |    5 
 net/netfilter/nft_meta.c                                   |    2 
 net/sunrpc/clnt.c                                          |    7 
 net/sunrpc/rpcb_clnt.c                                     |    4 
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c                    |    3 
 net/tipc/netlink_compat.c                                  |    1 
 net/unix/af_unix.c                                         |    9 
 net/vmw_vsock/af_vsock.c                                   |    6 
 scripts/gcc-plugins/randomize_layout_plugin.c              |   11 
 security/integrity/iint.c                                  |   48 +++
 security/integrity/ima/ima_api.c                           |    5 
 security/integrity/ima/ima_main.c                          |   16 +
 security/integrity/integrity.h                             |    2 
 security/keys/trusted-keys/trusted_core.c                  |   20 -
 security/keys/trusted-keys/trusted_tee.c                   |   64 +----
 sound/core/info.c                                          |   21 +
 sound/hda/hdac_stream.c                                    |    6 
 sound/pci/hda/patch_realtek.c                              |   26 --
 sound/soc/codecs/lpass-wsa-macro.c                         |    3 
 sound/soc/intel/common/soc-acpi-intel-cht-match.c          |   43 +++
 sound/soc/sof/ipc4.c                                       |    3 
 sound/soc/sof/sof-audio.c                                  |    7 
 sound/soc/sof/sof-pci-dev.c                                |    8 
 sound/soc/ti/omap-mcbsp.c                                  |    6 
 tools/perf/util/intel-pt.c                                 |    2 
 tools/power/x86/turbostat/turbostat.c                      |    3 
 tools/testing/cxl/test/cxl.c                               |  147 +++++++++++
 tools/testing/selftests/efivarfs/create-read.c             |    2 
 tools/testing/selftests/lkdtm/config                       |    1 
 tools/testing/selftests/lkdtm/tests.txt                    |    2 
 tools/testing/selftests/resctrl/Makefile                   |    2 
 tools/testing/selftests/resctrl/cmt_test.c                 |    3 
 tools/testing/selftests/resctrl/mba_test.c                 |    2 
 tools/testing/selftests/resctrl/mbm_test.c                 |    2 
 tools/testing/selftests/resctrl/resctrl.h                  |    1 
 371 files changed, 3389 insertions(+), 1476 deletions(-)

Adrian Hunter (1):
      perf intel-pt: Fix async branch flags

Ajay Singh (1):
      wifi: wilc1000: use vmm_table as array in wilc struct

Al Viro (1):
      gfs2: fix an oops in gfs2_permission

Alain Volmat (1):
      dmaengine: stm32-mdma: correct desc prep when channel running

Alex Deucher (3):
      drm/amdgpu/smu13: drop compute workload workaround
      drm/amdgpu: don't use pci_is_thunderbolt_attached()
      drm/amdgpu: don't use ATRM for external devices

Alex Spataru (1):
      ALSA: hda/realtek: Add quirk for ASUS UX7602ZM

Alexander Sverdlin (1):
      net: dsa: lan9303: consequently nested-lock physical MDIO

Amir Goldstein (1):
      ima: annotate iint mutex to avoid lockdep false positive warnings

Anastasia Belova (1):
      cifs: spnego: add ';' in HOST_KEY_LEN

Andreas Gruenbacher (1):
      gfs2: Silence "suspicious RCU usage in gfs2_permission" warning

Andrew Lunn (1):
      net: ethtool: Fix documentation of ethtool_sprintf()

Andrey Konovalov (1):
      media: qcom: camss: Fix csid-gen2 for test pattern generator

Andrii Nakryiko (1):
      bpf: Ensure proper register state printing for cond jumps

Arseniy Krasnov (1):
      vsock: read from socket's error queue

Artem Lukyanov (1):
      Bluetooth: btusb: Add Realtek RTL8852BE support ID 0x0cb8:0xc559

Axel Lin (1):
      i2c: sun6i-p2wi: Prevent potential division by zero

Bartosz Pawlowski (2):
      PCI: Extract ATS disabling to a helper function
      PCI: Disable ATS for specific Intel IPU E2000 devices

Baruch Siach (2):
      net: stmmac: fix rx budget limit check
      net: stmmac: avoid rx queue overrun

Bas Nieuwenhuizen (1):
      drm/amd/pm: Handle non-terminated overdrive commands.

Basavaraj Natikar (1):
      xhci: Enable RPM on controllers that support low-power states

Bean Huo (1):
      mmc: Add quirk MMC_QUIRK_BROKEN_CACHE_FLUSH for Micron eMMC Q2J54A

Benjamin Bara (2):
      kernel/reboot: emergency_restart: Set correct system_state
      i2c: core: Run atomic i2c xfer when !preemptible

Billy Tsai (1):
      i3c: master: mipi-i3c-hci: Fix a kernel panic for accessing DAT_data.

Bjorn Helgaas (1):
      PCI: Use FIELD_GET() in Sapphire RX 5600 XT Pulse quirk

Bob Peterson (1):
      gfs2: ignore negated quota changes

Brian Geffon (2):
      PM: hibernate: Use __get_safe_page() rather than touching the list
      PM: hibernate: Clean up sync_read handling in snapshot_write_next()

Bryan O'Donoghue (6):
      media: qcom: camss: Fix pm_domain_on sequence in probe
      media: qcom: camss: Fix vfe_get() error jump
      media: qcom: camss: Fix VFE-17x vfe_disable_output()
      media: qcom: camss: Fix VFE-480 vfe_disable_output()
      media: qcom: camss: Fix missing vfe_lite clocks check
      media: qcom: camss: Fix invalid clock enable bit disjunction

Catalin Marinas (1):
      rcu: kmemleak: Ignore kmemleak false positives when RCU-freeing objects

Cezary Rojewski (1):
      ALSA: hda: Fix possible null-ptr-deref when assigning a stream

Chandradeep Dey (1):
      ALSA: hda/realtek - Enable internal speaker of ASUS K6500ZC

Chandrakanth patil (1):
      scsi: megaraid_sas: Increase register read retry rount from 3 to 30 for selected registers

Chen Yu (1):
      tools/power/turbostat: Enable the C-state Pre-wake printing

Christian König (2):
      drm/amdgpu: fix error handling in amdgpu_bo_list_get()
      drm/amdgpu: lower CS errors to debug severity

Christian Marangi (1):
      cpufreq: stats: Fix buffer overflow detection in trans_stats()

Chuck Lever (1):
      svcrdma: Drop connection after an RDMA Read error

ChunHao Lin (2):
      r8169: fix network lost after resume on DASH systems
      r8169: add handling DASH when DASH is disabled

Clark Wang (1):
      i3c: master: svc: add NACK check after start byte sent

Conor Dooley (1):
      RISC-V: drop error print from riscv_hartid_to_cpuid()

Dan Carpenter (5):
      pwm: Fix double shift bug
      SUNRPC: Add an IS_ERR() check back to where it was
      vhost-vdpa: fix use after free in vhost_vdpa_probe()
      netfilter: nf_tables: fix pointer math issue in nft_byteorder_eval()
      mmc: vub300: fix an error code

Dan Williams (5):
      cxl/region: Validate region mode vs decoder mode
      cxl/region: Cleanup target list on attach error
      cxl/region: Move region-position validation to a helper
      cxl/mem: Move devm_cxl_add_endpoint() from cxl_core to cxl_mem
      tools/testing/cxl: Define a fixed volatile configuration to parse

Dario Binacchi (1):
      clk: visconti: remove unused visconti_pll_provider::regmap

Darren Hart (1):
      sbsa_gwdt: Calculate timeout with 64-bit math

Dave Chinner (1):
      xfs: recovery should not clear di_flushiter unconditionally

David (Ming Qiang) Wu (1):
      drm/amdgpu: not to save bo in the case of RAS err_event_athub

David Woodhouse (3):
      hvc/xen: fix console unplug
      hvc/xen: fix error path in xen_hvc_init() to always register frontend driver
      hvc/xen: fix event channel handling for secondary consoles

Denis Arefev (1):
      srcu: Fix srcu_struct node grpmask overflow on 64-bit systems

Dmitry Antipov (4):
      wifi: plfxlc: fix clang-specific fortify warning
      wifi: mac80211_hwsim: fix clang-specific fortify warning
      wifi: ath9k: fix clang-specific fortify warnings
      wifi: ath10k: fix clang-specific fortify warning

Dominique Martinet (1):
      9p: v9fs_listxattr: fix %s null argument warning

Douglas Anderson (2):
      wifi: ath10k: Don't touch the CE interrupt registers after power up
      kgdb: Flush console before entering kgdb on panic

Dust Li (1):
      net/mlx5e: fix double free of encap_header

Ekaterina Esina (1):
      cifs: fix check of rc in function generate_smb3signingkey

Eric Biggers (1):
      quota: explicitly forbid quota files from being encrypted

Eric Dumazet (6):
      net: annotate data-races around sk->sk_tx_queue_mapping
      net: annotate data-races around sk->sk_dst_pending_confirm
      ipvlan: add ipvlan_route_v6_outbound() helper
      ptp: annotate data-race around q->head and q->tail
      bonding: stop the device in bond_setup_by_slave()
      af_unix: fix use-after-free in unix_stream_read_actor()

Eymen Yigit (1):
      ALSA: hda/realtek: Enable Mute LED on HP 255 G8

Finn Thain (1):
      sched/core: Optimize in_task() and in_interrupt() a bit

Frank Li (6):
      i3c: master: svc: fix race condition in ibi work thread
      i3c: master: svc: fix wrong data return when IBI happen during start frame
      i3c: master: svc: fix ibi may not return mandatory data byte
      i3c: master: svc: fix check wrong status register in irq handler
      i3c: master: svc: fix SDA keep low when polling IBIWON timeout happen
      i3c: master: svc: fix random hot join failure since timeout error

Frederic Weisbecker (1):
      workqueue: Provide one lock class key per work_on_cpu() callsite

Gavin Li (1):
      net/mlx5e: fix double free of encap_header in update funcs

Geliang Tang (1):
      mptcp: add validity check for sending RM_ADDR

Gerhard Engleder (1):
      tsnep: Fix tsnep_request_irq() format-overflow warning

Greg Kroah-Hartman (1):
      Linux 6.1.64

Guan Wentao (1):
      Bluetooth: btusb: Add 0bda:b85b for Fn-Link RTL8852BE

Gustavo A. R. Silva (2):
      clk: socfpga: Fix undefined behavior bug in struct stratix10_clock_data
      clk: visconti: Fix undefined behavior bug in struct visconti_pll_provider

Hans Verkuil (1):
      media: vivid: avoid integer overflow

Hans de Goede (1):
      ASoC: Intel: soc-acpi-cht: Add Lenovo Yoga Tab 3 Pro YT3-X90 quirk

Hao Sun (1):
      bpf: Fix check_stack_write_fixed_off() to correctly spill imm

Harald Freudenberger (1):
      s390/ap: fix AP bus crash on early config change callback invocation

Hardik Gajjar (1):
      usb: gadget: f_ncm: Always set current gadget in ncm_bind()

Harshit Mogalapalli (1):
      i915/perf: Fix NULL deref bugs with drm_dbg() calls

Heiko Carstens (1):
      s390/cmma: fix detection of DAT pages

Heiner Kallweit (3):
      PCI/ASPM: Fix L1 substate handling in aspm_attr_store_common()
      i2c: i801: fix potential race in i801_block_transaction_byte_by_byte
      Revert "net: r8169: Disable multicast filter for RTL8168H and RTL8107E"

Helge Deller (5):
      parisc/pdc: Add width field to struct pdc_model
      parisc/power: Add power soft-off when running on qemu
      parisc: Prevent booting 64-bit kernels on PA1.x machines
      parisc/pgtable: Do not drop upper 5 address bits of physical address
      parisc/power: Fix power soft-off when running on qemu

Herve Codina (1):
      genirq/generic_chip: Make irq_remove_generic_chip() irqdomain aware

Ilpo Järvinen (10):
      RDMA/hfi1: Use FIELD_GET() to extract Link Width
      PCI: tegra194: Use FIELD_GET()/FIELD_PREP() with Link Width fields
      PCI: mvebu: Use FIELD_PREP() with Link Width
      atm: iphase: Do PCI error checks on own line
      PCI: Do error check on own line to split long "if" conditions
      PCI: Use FIELD_GET() to extract Link Width
      media: cobalt: Use FIELD_GET() to extract Link Width
      selftests/resctrl: Remove duplicate feature check from CMT test
      selftests/resctrl: Move _GNU_SOURCE define into Makefile
      selftests/resctrl: Reduce failures due to outliers in MBA/MBM tests

Jacky Bai (1):
      clocksource/drivers/timer-imx-gpt: Fix potential memory leak

Jaegeuk Kim (1):
      f2fs: do not return EFSCORRUPTED, but try to run online repair

Jamie Lentin (1):
      hid: lenovo: Resend all settings on reset_resume for compact keyboards

Jan Kara (1):
      ext4: properly sync file size update after O_SYNC direct IO

Jani Nikula (3):
      drm/msm/dp: skip validity check for DP CTS EDID checksum
      drm/mediatek/dp: fix memory leak on ->get_edid callback audio detection
      drm/mediatek/dp: fix memory leak on ->get_edid callback error path

Jarkko Nikula (2):
      mfd: intel-lpss: Add Intel Lunar Lake-M PCI IDs
      i3c: mipi-i3c-hci: Fix out of bounds access in hci_dma_irq_handler

Jarkko Sakkinen (1):
      KEYS: trusted: Rollback init_trusted() consistently

Jeff Layton (1):
      fs: add ctime accessors infrastructure

Jesse Zhang (1):
      drm/amdkfd: Fix shift out-of-bounds issue

Jian Shen (2):
      net: hns3: fix add VLAN fail issue
      net: hns3: fix incorrect capability bit display for copper port

Jijie Shao (2):
      net: hns3: fix VF reset fail issue
      net: hns3: fix VF wrong speed and duplex issue

Jim Harris (2):
      cxl/region: Do not try to cleanup after cxl_region_setup_targets() fails
      cxl/region: Fix x1 root-decoder granularity calculations

Jiri Kosina (1):
      HID: Add quirk for Dell Pro Wireless Keyboard and Mouse KM5221W

Joel Fernandes (Google) (1):
      rcu/tree: Defer setting of jiffies during stall reset

Johan Hovold (6):
      wifi: ath11k: fix temperature event locking
      wifi: ath11k: fix dfs radar event locking
      wifi: ath11k: fix htt pktlog locking
      wifi: ath11k: fix gtk offload status event locking
      mfd: qcom-spmi-pmic: Fix reference leaks in revid helper
      mfd: qcom-spmi-pmic: Fix revid implementation

John Stultz (1):
      locking/ww_mutex/test: Fix potential workqueue corruption

Johnathan Mantey (1):
      Revert ncsi: Propagate carrier gain/loss events to the NCSI controller

Jonathan Denose (1):
      ACPI: EC: Add quirk for HP 250 G7 Notebook PC

Josef Bacik (1):
      btrfs: don't arbitrarily slow down delalloc if we're committing

Joshua Yeong (1):
      i3c: master: cdns: Fix reading status register

Juergen Gross (1):
      xen/events: fix delayed eoi list handling

Juntong Deng (2):
      fs/jfs: Add check for negative db_l2nbperpage
      fs/jfs: Add validity check for db_maxag and db_agpref

Kailang Yang (1):
      ALSA: hda/realtek - Add Dell ALC295 to pin fall back table

Kathiravan Thirumoorthy (3):
      clk: qcom: ipq8074: drop the CLK_SET_RATE_PARENT flag from PLL clocks
      clk: qcom: ipq6018: drop the CLK_SET_RATE_PARENT flag from PLL clocks
      firmware: qcom_scm: use 64-bit calling convention only when client is 64-bit

Kees Cook (1):
      randstruct: Fix gcc-plugin performance mode to stay in group

Kemeng Shi (4):
      ext4: correct offset of gdb backup in non meta_bg group to update_backups
      ext4: correct return value of ext4_convert_meta_bg
      ext4: remove gdb backup copy for meta bg in setup_new_flex_group_blocks
      ext4: add missed brelse in update_backups

Kent Overstreet (1):
      lib/generic-radix-tree.c: Don't overflow in peek()

Klaus Kudielka (1):
      net: phylink: initialize carrier state at creation

Krister Johansen (2):
      proc: sysctl: prevent aliased sysctls from getting passed to init
      watchdog: move softlockup_panic back to early_param

Krzysztof Kozlowski (1):
      ASoC: codecs: wsa-macro: fix uninitialized stack variables with name prefix

Kumar Kartikeya Dwivedi (1):
      bpf: Detect IP == ksym.end as part of BPF program

Kunwu Chan (1):
      drm/i915: Fix potential spectre vulnerability

Larry Finger (2):
      bluetooth: Add device 0bda:887b to device tables
      bluetooth: Add device 13d3:3571 to device tables

Laurentiu Tudor (1):
      arm64: dts: ls208xa: use a pseudo-bus to constrain usb dma size

Lewis Huang (1):
      drm/amd/display: Change the DMCUB mailbox memory location from FB to inbox

Linkui Xiao (1):
      netfilter: nf_conntrack_bridge: initialize err to 0

Linus Walleij (4):
      net: ethernet: cortina: Fix max RX frame define
      net: ethernet: cortina: Handle large frames
      net: ethernet: cortina: Fix MTU max setting
      mtd: cfi_cmdset_0001: Byte swap OTP info

Longfang Liu (1):
      crypto: hisilicon/qm - prevent soft lockup in receive loop

Lu Jialin (1):
      crypto: pcrypt - Fix hungtask for PADATA_RESET

Lukas Wunner (1):
      PCI/sysfs: Protect driver's D3cold preference from user space

Ma Jun (1):
      drm/amd/pm: Fix error of MACO flag setting code

Ma Ke (4):
      drm/panel: fix a possible null pointer dereference
      drm/panel/panel-tpo-tpg110: fix a possible null pointer dereference
      drm/radeon: fix a possible null pointer dereference
      drm/amdgpu/vkms: fix a possible null pointer dereference

Maciej S. Szmigiero (1):
      KVM: x86: Ignore MSR_AMD64_TW_CFG access

Mahmoud Adam (1):
      nfsd: fix file memleak on client_opens_release

Manas Ghandat (2):
      jfs: fix array-index-out-of-bounds in dbFindLeaf
      jfs: fix array-index-out-of-bounds in diAlloc

Marco Elver (1):
      9p/trans_fd: Annotate data-racy writes to file::f_flags

Mario Limonciello (4):
      drm/amd: Update `update_pcie_parameters` functions to use uint8_t arguments
      drm/amd: Fix UBSAN array-index-out-of-bounds for SMU7
      drm/amd: Fix UBSAN array-index-out-of-bounds for Polaris and Tonga
      drm/amd/display: fix a NULL pointer dereference in amdgpu_dm_i2c_xfer()

Mark Brown (1):
      regmap: Ensure range selector registers are updated after cache sync

Masum Reza (1):
      Bluetooth: btusb: Add RTW8852BE device 13d3:3570 to device tables

Matus Malych (1):
      ALSA: hda/realtek: Enable Mute LED on HP 255 G10

Max Kellermann (1):
      ext4: apply umask if ACL support is disabled

Maíra Canal (1):
      pmdomain: bcm: bcm2835-power: check if the ASB register is equal to enable

Michael Ellerman (1):
      powerpc/powernv: Fix fortify source warnings in opal-prd.c

Mika Westerberg (1):
      thunderbolt: Apply USB 3.x bandwidth quirk only in software connection manager

Mike Rapoport (IBM) (1):
      x86/mm: Drop the 4 MB restriction on minimal NUMA node memory size

Mikhail Khvainitski (1):
      HID: lenovo: Detect quirk-free fw on cptkbd and stop applying workaround

Mikulas Patocka (1):
      dm-verity: don't use blocking calls from tasklets

Mimi Zohar (1):
      ima: detect changes to the backing overlay file

Miri Korenblit (1):
      wifi: iwlwifi: Use FW rate for non-data frames

Muhammad Ahmed (1):
      drm/amd/display: enable dsc_clk even if dsc_pg disabled

Muhammad Usama Anjum (1):
      tty/sysrq: replace smp_processor_id() with get_cpu()

Nam Cao (1):
      riscv: kprobes: allow writing to x0

Namjae Jeon (2):
      ksmbd: handle malformed smb1 message
      ksmbd: fix slab out of bounds write in smb_inherit_dacl()

Naohiro Aota (1):
      btrfs: zoned: wait for data BG to be finished on direct IO allocation

Nathan Chancellor (2):
      arm64: Restrict CPU_BIG_ENDIAN to GNU as or LLVM IAS 15.x or newer
      LoongArch: Mark __percpu functions as always inline

Nicholas Piggin (1):
      powerpc/perf: Fix disabling BHRB and instruction sampling

Nicolas Saenz Julienne (1):
      KVM: x86: hyper-v: Don't auto-enable stimer on write from user-space

Nitin Yadav (1):
      mmc: sdhci_am654: fix start loop index for TAP value parsing

Ojaswin Mujoo (1):
      ext4: mark buffer new if it is unwritten to avoid stale data exposure

Olga Kornievskaia (2):
      NFSv4.1: fix handling NFS4ERR_DELAY when testing for session trunking
      NFSv4.1: fix SP4_MACH_CRED protection for pnfs IO

Olli Asikainen (1):
      platform/x86: thinkpad_acpi: Add battery quirk for Thinkpad X120e

Ondrej Jirman (1):
      drm/panel: st7703: Pick different reset sequence

Ondrej Mosnacek (2):
      lsm: fix default return value for vm_enough_memory
      lsm: fix default return value for inode_getsecctx

Pablo Neira Ayuso (2):
      netfilter: nf_tables: remove catchall element in GC sync path
      netfilter: nf_tables: split async and sync catchall in two functions

Paolo Abeni (2):
      mptcp: deal with large GSO size
      mptcp: fix setsockopt(IP_TOS) subflow locking

Paul Moore (2):
      audit: don't take task_lock() in audit_exe_compare() code path
      audit: don't WARN_ON_ONCE(!current->mm) in audit_exe_compare()

Paulo Alcantara (2):
      smb: client: fix use-after-free bug in cifs_debug_data_proc_show()
      smb: client: fix potential deadlock when releasing mids

Pavel Krasavin (1):
      tty: serial: meson: fix hard LOCKUP on crtscts mode

Pengfei Li (1):
      pmdomain: imx: Make imx pgc power domain also set the fwnode

Philipp Stanner (6):
      string.h: add array-wrappers for (v)memdup_user()
      kernel: kexec: copy user-array safely
      kernel: watch_queue: copy user-array safely
      drm_lease.c: copy user-array safely
      drm: vmwgfx_surface.c: copy user-array safely
      i2c: dev: copy userspace array safely

Pierre-Louis Bossart (1):
      soundwire: dmi-quirks: update HP Omen match

Ping-Ke Shih (1):
      wifi: mac80211: don't return unset power in ieee80211_get_tx_power()

Pu Wen (1):
      x86/cpu/hygon: Fix the CPU topology evaluation for real

Qu Huang (1):
      drm/amdgpu: Fix a null pointer access when the smc_rreg pointer is NULL

Quinn Tran (1):
      scsi: qla2xxx: Fix system crash due to bad pointer access

Rahul Rameshbabu (2):
      net/mlx5e: Check return value of snprintf writing to fw_version buffer
      net/mlx5e: Check return value of snprintf writing to fw_version buffer for representors

Rajeshwar R Shinde (1):
      media: gspca: cpia1: shift-out-of-bounds in set_flicker

Ran Xiaokai (1):
      cpu/hotplug: Don't offline the last non-isolated CPU

Rander Wang (1):
      ASoC: SOF: ipc4: handle EXCEPTION_CAUGHT notification from firmware

Ranjan Kumar (1):
      scsi: mpt3sas: Fix loop logic

Ricardo Cañuelo (1):
      selftests/lkdtm: Disable CONFIG_UBSAN_TRAP in test config

Richard Fitzgerald (2):
      ASoC: soc-card: Add storage for PCI SSID
      ASoC: SOF: Pass PCI SSID to machine driver

Rik van Riel (1):
      smp,csd: Throw an error if a CSD lock is stuck for too long

Robert Marko (1):
      Revert "i2c: pxa: move to generic GPIO recovery"

Robert Richter (2):
      cxl: Unify debug messages when calling devm_cxl_add_port()
      cxl/port: Fix NULL pointer access in devm_cxl_add_port()

Roman Gushchin (1):
      mm: kmem: drop __GFP_NOFAIL when allocating objcg vectors

Ronald Wahl (1):
      clocksource/drivers/timer-atmel-tcb: Fix initialization on SAM9 hardware

Rong Chen (1):
      mmc: meson-gx: Remove setting of CMD_CFG_ERROR

Roxana Nicolescu (1):
      crypto: x86/sha - load modules based on CPU features

Saeed Mahameed (1):
      net/mlx5e: Reduce the size of icosq_str

Sakari Ailus (2):
      media: ccs: Fix driver quirk struct documentation
      media: ccs: Correctly initialise try compose rectangle

Sanjuán García, Jorge (1):
      mcb: fix error handling for different scenarios when parsing

Saravana Kannan (1):
      driver core: Release all resources during unbind before updating device links

Sean Young (2):
      media: lirc: drop trailing space from scancode transmit
      media: sharp: fix sharp encoding

SeongJae Park (6):
      mm/damon/sysfs: remove requested targets when online-commit inputs
      mm/damon/sysfs: update monitoring target regions for online input commit
      mm/damon/lru_sort: avoid divide-by-zero in hot threshold calculation
      mm/damon/ops-common: avoid divide-by-zero during region hotness calculation
      mm/damon: implement a function for max nr_accesses safe calculation
      mm/damon/sysfs: check error from damon_sysfs_update_target()

Shigeru Yoshida (2):
      tty: Fix uninit-value access in ppp_sync_receive()
      tipc: Fix kernel-infoleak due to uninitialized TLV value

Shuai Xue (1):
      perf/core: Bail out early if the request AUX area is out of bound

Shung-Hsi Yu (1):
      bpf: Fix precision tracking for BPF_ALU | BPF_TO_BE | BPF_END

Shyam Prasad N (3):
      cifs: reconnect helper should set reconnect for the right channel
      cifs: force interface update before a fresh session setup
      cifs: do not reset chan_max if multichannel is not supported at mount

Sieng-Piaw Liew (1):
      atl1c: Work around the DMA RX overflow issue

Song Shuai (2):
      riscv: mm: Update the comment of CONFIG_PAGE_OFFSET
      riscv: correct pt_level name via pgtable_l5/4_enabled

Stanislav Fomichev (1):
      net: set SOCK_RCU_FREE before inserting socket into hashtable

Stanley Chang (1):
      usb: dwc3: core: configure TX/RX threshold for DWC3_IP

Stanley.Yang (1):
      drm/amdgpu: Fix potential null pointer derefernce

Stefan Binding (1):
      ALSA: hda/realtek: Add quirks for HP Laptops

Stefan Roesch (1):
      mm: fix for negative counter: nr_file_hugepages

Steve French (3):
      smb3: fix creating FIFOs when mounting with "sfu" mount option
      smb3: fix touch -h of symlink
      smb3: fix caching of ctime on setxattr

Steven Rostedt (Google) (2):
      tracing: Have the user copy of synthetic event address use correct context
      tracing: Have trace_event_file have ref counters

Su Hui (1):
      f2fs: avoid format-overflow warning

Sui Jingfeng (1):
      drm/gma500: Fix call trace when psb_gem_mm_init() fails

Sumit Garg (1):
      KEYS: trusted: tee: Refactor register SHM usage

Sven Auhagen (1):
      net: mvneta: fix calls to page_pool_get_stats

Takashi Iwai (2):
      media: imon: fix access to invalid resource for the second interface
      ALSA: info: Fix potential deadlock at disconnection

Tam Nguyen (1):
      i2c: designware: Disable TX_EMPTY irq while waiting for block length byte

Tao Su (1):
      KVM: x86: Clear bit12 of ICR after APIC-write VM-exit

Tianci Yin (1):
      drm/amd/display: Enable fast plane updates on DCN3.2 and above

Tony Lindgren (1):
      ASoC: ti: omap-mcbsp: Fix runtime PM underflow warnings

Trond Myklebust (1):
      SUNRPC: ECONNRESET might require a rebind

Tyrel Datwyler (1):
      scsi: ibmvfc: Remove BUG_ON in the case of an empty event pool

Tzung-Bi Shih (1):
      platform/chrome: kunit: initialize lock for fake ec_dev

Uwe Kleine-König (4):
      PCI: keystone: Don't discard .remove() callback
      PCI: keystone: Don't discard .probe() callback
      PCI: kirin: Don't discard .remove() callback
      PCI: exynos: Don't discard .remove() callback

Vasily Khoruzhick (1):
      ACPI: FPDT: properly handle invalid FPDT subtables

Vicki Pfau (1):
      Input: xpad - add VID for Turtle Beach controllers

Victor Shih (3):
      mmc: sdhci-pci-gli: A workaround to allow GL9750 to enter ASPM L1.2
      mmc: sdhci-pci-gli: GL9750: Mask the replay timer timeout of AER
      mmc: sdhci-pci-gli: GL9755: Mask the replay timer timeout of AER

Vignesh Viswanathan (3):
      arm64: dts: qcom: ipq6018: Fix hwlock index for SMEM
      arm64: dts: qcom: ipq8074: Fix hwlock index for SMEM
      arm64: dts: qcom: ipq6018: Fix tcsr_mutex register size

Vikash Garodia (4):
      media: venus: hfi: add checks to perform sanity on queue pointers
      media: venus: hfi_parser: Add check to keep the number of codecs within range
      media: venus: hfi: fix the check to handle session buffer requirement
      media: venus: hfi: add checks to handle capabilities from firmware

Ville Syrjälä (1):
      drm/i915: Bump GLK CDCLK frequency when driving multiple pipes

Vincent Whitchurch (1):
      ARM: 9320/1: fix stack depot IRQ stack filter

Vitaly Prosyak (1):
      drm/amdgpu: fix software pci_unplug on some chips

Vlad Buslov (2):
      net/mlx5e: Fix pedit endianness
      macvlan: Don't propagate promisc change to lower dev in passthru

Wayne Lin (1):
      drm/amd/display: Avoid NULL dereference of timing generator

Wenchao Hao (1):
      scsi: libfc: Fix potential NULL pointer dereference in fc_lport_ptp_setup()

Wenjing Liu (1):
      drm/amd/display: use full update for clip size increase of large plane source

Werner Sembach (1):
      ACPI: resource: Do IRQ override on TongFang GMxXGxx

Willem de Bruijn (1):
      ppp: limit MRU to 64K

Wolfram Sang (1):
      i2c: fix memleak in i2c_new_client_device()

Xiaogang Chen (1):
      drm/amdkfd: Fix a race condition of vram buffer unref in svm code

Yi Yang (4):
      tty: vcc: Add check for kstrdup() in vcc_probe()
      mtd: rawnand: tegra: add missing check for platform_get_irq()
      mtd: rawnand: intel: check return value of devm_kasprintf()
      mtd: rawnand: meson: check return value of devm_kasprintf()

Yihang Li (1):
      scsi: hisi_sas: Set debugfs_dir pointer to NULL after removing debugfs

Yonglong Liu (3):
      net: hns3: add barrier in vf mailbox reply process
      net: hns3: fix out-of-bounds access may occur when coalesce info is read via debugfs
      net: hns3: fix variable may not initialized problem in hns3_init_mac_addr()

Yoshihiro Shimoda (1):
      misc: pci_endpoint_test: Add Device ID for R-Car S4-8 PCIe controller

Yuezhang Mo (1):
      exfat: support handle zero-size directory

Zhang Rui (1):
      tools/power/turbostat: Fix a knl bug

Zhang Shurong (1):
      iio: adc: stm32-adc: harden against NULL pointer deref in stm32_adc_probe()

Zhang Yi (1):
      ext4: correct the start block of counting reserved clusters

ZhengHan Wang (1):
      Bluetooth: Fix double free in hci_conn_cleanup

Zhiguo Niu (1):
      f2fs: fix error handling of __get_node_page

Zhihao Cheng (1):
      jbd2: fix potential data lost in recovering journal raced with synchronizing fs bdev

Zi Yan (2):
      mm/cma: use nth_page() in place of direct struct page manipulation
      mm/memory_hotplug: use pfn math in place of direct struct page manipulation

Zongmin Zhou (1):
      drm/qxl: prevent memory leak

baozhu.liu (1):
      drm/komeda: drop all currently held locks if deadlock happens

felix (1):
      SUNRPC: Fix RPC client cleaned up the freed pipefs dentries

youwan Wang (1):
      Bluetooth: btusb: Add date->evt_skb is NULL check

zhenwei pi (1):
      virtio-blk: fix implicit overflow on virtio_max_dma_size

zhujun2 (1):
      selftests/efivarfs: create-read: fix a resource leak

