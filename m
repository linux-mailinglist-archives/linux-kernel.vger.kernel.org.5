Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B12B76E590
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 12:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235408AbjHCKX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 06:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235404AbjHCKWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 06:22:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D9DC35A5;
        Thu,  3 Aug 2023 03:20:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A2EE961D2B;
        Thu,  3 Aug 2023 10:20:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E8B2C433C8;
        Thu,  3 Aug 2023 10:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691058025;
        bh=wkeyvs4nOSoN5OCU+O/lqVUaUEU5JdyeQQKYdoBIkbY=;
        h=From:To:Cc:Subject:Date:From;
        b=upM1q3quPZzqqVFeR4gaVPLDI1KIDr32HQF+XobR4jaTNhvMBOtsX7aIDOPZLOLaZ
         uFp6QvlVEuRqRP0sQ2wjDW8X2t74nN8VBUyxT38yp1Zzct1CE0fLfiSydHdY1Rj6mV
         wXNFO1ecs39SRhAuaLKfIr+GAol58anyGjkyCYfI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.4.8
Date:   Thu,  3 Aug 2023 12:20:08 +0200
Message-ID: <2023080309-yen-foil-da73@gregkh>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm announcing the release of the 6.4.8 kernel.

All users of the 6.4 kernel series must upgrade.

The updated 6.4.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.4.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/ABI/testing/sysfs-module                                               |   11 
 Documentation/admin-guide/hw-vuln/spectre.rst                                        |   11 
 Documentation/filesystems/tmpfs.rst                                                  |   47 
 Documentation/process/security-bugs.rst                                              |   39 
 Makefile                                                                             |    2 
 arch/arm64/include/asm/virt.h                                                        |    1 
 arch/arm64/kernel/fpsimd.c                                                           |    4 
 arch/arm64/kvm/arm.c                                                                 |    9 
 arch/arm64/kvm/pkvm.c                                                                |    2 
 arch/loongarch/Kconfig                                                               |    1 
 arch/loongarch/lib/clear_user.S                                                      |    3 
 arch/loongarch/lib/copy_user.S                                                       |    3 
 arch/loongarch/net/bpf_jit.h                                                         |    2 
 arch/powerpc/platforms/pseries/vas.c                                                 |    9 
 arch/s390/kvm/pv.c                                                                   |    8 
 arch/s390/mm/fault.c                                                                 |    2 
 arch/s390/mm/gmap.c                                                                  |    1 
 arch/um/os-Linux/sigio.c                                                             |    7 
 arch/x86/include/asm/kvm-x86-ops.h                                                   |    1 
 arch/x86/include/asm/kvm_host.h                                                      |    3 
 arch/x86/kernel/cpu/bugs.c                                                           |   15 
 arch/x86/kernel/cpu/mce/amd.c                                                        |    4 
 arch/x86/kernel/traps.c                                                              |   18 
 arch/x86/kvm/svm/svm.c                                                               |    6 
 arch/x86/kvm/vmx/vmx.c                                                               |   41 
 arch/x86/kvm/x86.c                                                                   |   34 
 block/blk-core.c                                                                     |    3 
 block/blk-mq.c                                                                       |    9 
 drivers/acpi/arm64/iort.c                                                            |    3 
 drivers/ata/pata_ns87415.c                                                           |    2 
 drivers/base/power/power.h                                                           |    1 
 drivers/base/power/wakeirq.c                                                         |   12 
 drivers/base/regmap/regmap-kunit.c                                                   |    3 
 drivers/block/rbd.c                                                                  |  124 +
 drivers/block/ublk_drv.c                                                             |   11 
 drivers/char/tpm/tpm_tis_core.c                                                      |    9 
 drivers/cxl/acpi.c                                                                   |    5 
 drivers/dma-buf/dma-fence-unwrap.c                                                   |   26 
 drivers/dma-buf/dma-fence.c                                                          |    7 
 drivers/gpio/gpio-mvebu.c                                                            |   26 
 drivers/gpio/gpio-tps68470.c                                                         |    6 
 drivers/gpu/drm/amd/amdgpu/amdgpu.h                                                  |    1 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                                           |   19 
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c                                              |    6 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c                          |    2 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c                                |    3 
 drivers/gpu/drm/amd/display/dc/core/dc.c                                             |   25 
 drivers/gpu/drm/amd/display/dc/dc.h                                                  |    3 
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c                                         |    7 
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h                                         |    1 
 drivers/gpu/drm/amd/display/dc/dc_stream.h                                           |    1 
 drivers/gpu/drm/amd/display/dc/dc_types.h                                            |    1 
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c                                   |    4 
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c                                    |    7 
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubbub.c                                  |    1 
 drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c                              |  106 +
 drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c                                 |   23 
 drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c                                 |   25 
 drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.h                                 |    3 
 drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c                       |   39 
 drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.c                    |    3 
 drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c                               |   15 
 drivers/gpu/drm/amd/display/dc/dml/dcn314/display_rq_dlg_calc_314.c                  |   16 
 drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h                            |    3 
 drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c                                |    6 
 drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_fixed_vs_pe_retimer.c |   23 
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h                                          |    2 
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h                                      |    2 
 drivers/gpu/drm/amd/display/dmub/src/Makefile                                        |    2 
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c                                    |    5 
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.h                                    |    2 
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn314.c                                   |   67 
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn314.h                                   |   35 
 drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c                                      |   12 
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c                              |   89 -
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c                                       |   21 
 drivers/gpu/drm/drm_syncobj.c                                                        |    6 
 drivers/gpu/drm/i915/display/intel_dpt.c                                             |    4 
 drivers/gpu/drm/i915/gem/selftests/huge_pages.c                                      |    6 
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c                                                |    2 
 drivers/gpu/drm/msm/adreno/a6xx_gpu_state.h                                          |    2 
 drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.h                                        |   13 
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c                                           |    8 
 drivers/gpu/drm/msm/dsi/phy/dsi_phy_14nm.c                                           |    2 
 drivers/gpu/drm/msm/msm_fence.c                                                      |    6 
 drivers/gpu/drm/msm/msm_gem_submit.c                                                 |   16 
 drivers/gpu/drm/msm/msm_mdss.c                                                       |   19 
 drivers/gpu/drm/ttm/ttm_bo.c                                                         |    6 
 drivers/hwmon/aquacomputer_d5next.c                                                  |    2 
 drivers/hwmon/k10temp.c                                                              |   17 
 drivers/hwmon/nct7802.c                                                              |    2 
 drivers/hwmon/pmbus/pmbus_core.c                                                     |   20 
 drivers/i2c/busses/i2c-ibm_iic.c                                                     |    4 
 drivers/i2c/busses/i2c-nomadik.c                                                     |   42 
 drivers/i2c/busses/i2c-sh7760.c                                                      |    3 
 drivers/i2c/busses/i2c-tiny-usb.c                                                    |    4 
 drivers/infiniband/core/cma.c                                                        |    2 
 drivers/infiniband/hw/bnxt_re/ib_verbs.c                                             |   12 
 drivers/infiniband/hw/bnxt_re/qplib_fp.c                                             |   28 
 drivers/infiniband/hw/bnxt_re/qplib_fp.h                                             |    1 
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c                                           |  353 +++-
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.h                                           |   26 
 drivers/infiniband/hw/irdma/ctrl.c                                                   |   31 
 drivers/infiniband/hw/irdma/defs.h                                                   |   46 
 drivers/infiniband/hw/irdma/hw.c                                                     |    3 
 drivers/infiniband/hw/irdma/main.h                                                   |    2 
 drivers/infiniband/hw/irdma/puda.c                                                   |    6 
 drivers/infiniband/hw/irdma/type.h                                                   |    2 
 drivers/infiniband/hw/irdma/uk.c                                                     |    5 
 drivers/infiniband/hw/irdma/utils.c                                                  |    8 
 drivers/infiniband/hw/mlx4/qp.c                                                      |   18 
 drivers/infiniband/hw/mthca/mthca_qp.c                                               |    2 
 drivers/iommu/iommufd/device.c                                                       |   12 
 drivers/iommu/iommufd/iommufd_private.h                                              |   15 
 drivers/iommu/iommufd/main.c                                                         |   78 
 drivers/iommu/iommufd/pages.c                                                        |    2 
 drivers/irqchip/irq-bcm6345-l1.c                                                     |   14 
 drivers/irqchip/irq-gic-v3-its.c                                                     |   75 
 drivers/md/dm-cache-policy-smq.c                                                     |   28 
 drivers/md/dm-raid.c                                                                 |   20 
 drivers/md/md.c                                                                      |    2 
 drivers/media/i2c/tc358746.c                                                         |    4 
 drivers/media/platform/amphion/vpu_core.c                                            |    4 
 drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c                                 |  860 ++++------
 drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_hw.c                               |    4 
 drivers/media/platform/mediatek/jpeg/mtk_jpeg_enc_hw.c                               |    4 
 drivers/net/bonding/bond_main.c                                                      |    5 
 drivers/net/can/usb/gs_usb.c                                                         |    2 
 drivers/net/dsa/qca/qca8k-8xxx.c                                                     |    7 
 drivers/net/dsa/qca/qca8k-common.c                                                   |   19 
 drivers/net/ethernet/atheros/atl1e/atl1e_main.c                                      |    7 
 drivers/net/ethernet/atheros/atlx/atl1.c                                             |    7 
 drivers/net/ethernet/emulex/benet/be_main.c                                          |    3 
 drivers/net/ethernet/freescale/fec_main.c                                            |   18 
 drivers/net/ethernet/hisilicon/hns3/hnae3.h                                          |    3 
 drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_cmd.c                     |   21 
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c                               |   17 
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c                           |    3 
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c                                |    3 
 drivers/net/ethernet/intel/i40e/i40e_debugfs.c                                       |    2 
 drivers/net/ethernet/intel/iavf/iavf_main.c                                          |   11 
 drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c                                    |   26 
 drivers/net/ethernet/intel/igc/igc_main.c                                            |   40 
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c                                        |    2 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.c                             |   43 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.h                             |    8 
 drivers/net/ethernet/realtek/r8169_main.c                                            |   27 
 drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c                                     |    4 
 drivers/net/ipa/ipa_table.c                                                          |   20 
 drivers/net/macvlan.c                                                                |    1 
 drivers/net/phy/marvell10g.c                                                         |    7 
 drivers/net/team/team.c                                                              |    9 
 drivers/net/virtio_net.c                                                             |    4 
 drivers/net/vxlan/vxlan_core.c                                                       |  165 +
 drivers/pci/controller/pcie-rockchip-ep.c                                            |  156 -
 drivers/pci/controller/pcie-rockchip.h                                               |   40 
 drivers/pci/pcie/aspm.c                                                              |   55 
 drivers/phy/hisilicon/phy-hisi-inno-usb2.c                                           |    2 
 drivers/phy/mediatek/phy-mtk-dp.c                                                    |    2 
 drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c                                           |    2 
 drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c                                        |   72 
 drivers/platform/x86/amd/pmf/acpi.c                                                  |   23 
 drivers/platform/x86/amd/pmf/core.c                                                  |    9 
 drivers/platform/x86/amd/pmf/pmf.h                                                   |   16 
 drivers/platform/x86/amd/pmf/sps.c                                                   |   74 
 drivers/platform/x86/msi-laptop.c                                                    |    8 
 drivers/s390/block/dasd_3990_erp.c                                                   |    2 
 drivers/s390/block/dasd_ioctl.c                                                      |    1 
 drivers/soundwire/amd_manager.c                                                      |    4 
 drivers/soundwire/bus.c                                                              |    8 
 drivers/soundwire/qcom.c                                                             |    2 
 drivers/staging/ks7010/ks_wlan_net.c                                                 |    6 
 drivers/staging/media/atomisp/Kconfig                                                |    1 
 drivers/staging/rtl8712/rtl871x_xmit.c                                               |   43 
 drivers/staging/rtl8712/xmit_linux.c                                                 |    6 
 drivers/thermal/thermal_of.c                                                         |   27 
 drivers/tty/n_gsm.c                                                                  |    4 
 drivers/tty/serial/8250/8250_dwlib.c                                                 |    6 
 drivers/tty/serial/qcom_geni_serial.c                                                |    7 
 drivers/tty/serial/sh-sci.c                                                          |    2 
 drivers/tty/serial/sifive.c                                                          |    2 
 drivers/tty/tty_io.c                                                                 |    2 
 drivers/usb/cdns3/cdns3-gadget.c                                                     |    4 
 drivers/usb/core/quirks.c                                                            |    4 
 drivers/usb/dwc3/core.c                                                              |   20 
 drivers/usb/dwc3/core.h                                                              |    3 
 drivers/usb/dwc3/dwc3-pci.c                                                          |    6 
 drivers/usb/gadget/composite.c                                                       |    4 
 drivers/usb/gadget/legacy/raw_gadget.c                                               |   10 
 drivers/usb/gadget/udc/core.c                                                        |    1 
 drivers/usb/gadget/udc/tegra-xudc.c                                                  |    8 
 drivers/usb/host/ohci-at91.c                                                         |    8 
 drivers/usb/host/xhci-mtk.c                                                          |    1 
 drivers/usb/host/xhci-pci.c                                                          |    4 
 drivers/usb/host/xhci-ring.c                                                         |   25 
 drivers/usb/host/xhci-tegra.c                                                        |    8 
 drivers/usb/misc/ehset.c                                                             |    8 
 drivers/usb/serial/option.c                                                          |    6 
 drivers/usb/serial/usb-serial-simple.c                                               |   73 
 drivers/usb/typec/class.c                                                            |   15 
 drivers/xen/grant-table.c                                                            |   40 
 drivers/xen/xenbus/xenbus_probe.c                                                    |    3 
 fs/9p/fid.h                                                                          |    6 
 fs/9p/v9fs.h                                                                         |    2 
 fs/9p/vfs_dir.c                                                                      |    5 
 fs/9p/vfs_file.c                                                                     |    5 
 fs/btrfs/block-rsv.c                                                                 |    5 
 fs/btrfs/disk-io.c                                                                   |    7 
 fs/btrfs/extent_io.c                                                                 |   21 
 fs/btrfs/qgroup.c                                                                    |   18 
 fs/btrfs/transaction.c                                                               |   10 
 fs/btrfs/zoned.c                                                                     |    3 
 fs/ceph/metric.c                                                                     |    2 
 fs/ext4/mballoc.c                                                                    |  194 +-
 fs/file.c                                                                            |    6 
 fs/jbd2/checkpoint.c                                                                 |   32 
 fs/nfsd/nfs4state.c                                                                  |    2 
 fs/proc/vmcore.c                                                                     |    2 
 fs/smb/client/sess.c                                                                 |    4 
 fs/smb/server/ksmbd_netlink.h                                                        |    3 
 fs/smb/server/smb2pdu.c                                                              |   27 
 fs/smb/server/vfs.c                                                                  |   58 
 fs/smb/server/vfs.h                                                                  |    4 
 include/linux/dma-fence.h                                                            |    2 
 include/linux/mm.h                                                                   |   29 
 include/linux/mm_types.h                                                             |   28 
 include/linux/mmap_lock.h                                                            |   10 
 include/net/ipv6.h                                                                   |    8 
 include/net/vxlan.h                                                                  |   13 
 include/uapi/linux/blkzoned.h                                                        |   10 
 io_uring/io_uring.c                                                                  |   25 
 kernel/locking/rtmutex.c                                                             |  170 +
 kernel/locking/rtmutex_api.c                                                         |    2 
 kernel/locking/rtmutex_common.h                                                      |   47 
 kernel/locking/ww_mutex.h                                                            |   12 
 kernel/signal.c                                                                      |    4 
 kernel/trace/ring_buffer.c                                                           |   22 
 kernel/trace/trace_events.c                                                          |   14 
 lib/test_maple_tree.c                                                                |  163 -
 mm/memory-failure.c                                                                  |    2 
 mm/mempolicy.c                                                                       |   15 
 mm/mmap.c                                                                            |    1 
 net/ceph/messenger.c                                                                 |    1 
 net/ipv6/addrconf.c                                                                  |   14 
 net/mptcp/protocol.c                                                                 |    3 
 net/netfilter/nf_tables_api.c                                                        |    5 
 net/netfilter/nft_immediate.c                                                        |   27 
 net/netfilter/nft_set_rbtree.c                                                       |   20 
 net/sched/sch_mqprio.c                                                               |   14 
 net/tipc/crypto.c                                                                    |    3 
 net/tipc/node.c                                                                      |    2 
 sound/pci/hda/patch_realtek.c                                                        |    2 
 sound/soc/codecs/wm8904.c                                                            |    3 
 sound/soc/fsl/fsl_spdif.c                                                            |    2 
 tools/net/ynl/lib/ynl.py                                                             |    4 
 tools/testing/radix-tree/linux/init.h                                                |    1 
 tools/testing/radix-tree/maple.c                                                     |  147 -
 tools/testing/selftests/net/mptcp/mptcp_join.sh                                      |    4 
 virt/kvm/kvm_main.c                                                                  |   24 
 259 files changed, 3541 insertions(+), 2007 deletions(-)

Adrien Thierry (2):
      phy: qcom-snps-femto-v2: keep cfg_ahb_clk enabled during runtime suspend
      phy: qcom-snps-femto-v2: properly enable ref clock

Ahmad Fatoum (1):
      thermal: of: fix double-free on unregistration

Aleksa Savic (1):
      hwmon: (aquacomputer_d5next) Fix incorrect PWM value readout

Alex Elder (1):
      net: ipa: only reset hashed tables when supported

Alexander Steffen (1):
      tpm_tis: Explicitly check for error code

Andi Shyti (2):
      i2c: nomadik: Remove unnecessary goto label
      i2c: nomadik: Use devm_clk_get_enabled()

Andy Shevchenko (1):
      Revert "um: Use swap() to make code cleaner"

Arkadiusz Kubalewski (1):
      tools: ynl-gen: fix enum index in _decode_enum(..)

Arnd Bergmann (2):
      media: mtk_jpeg_core: avoid unused-variable warning
      ata: pata_ns87415: mark ns87560_tf_read static

Bart Van Assche (1):
      block: Fix a source code comment in include/uapi/linux/blkzoned.h

Bartosz Golaszewski (1):
      gpio: mvebu: fix irq domain leak

Baskaran Kannan (1):
      hwmon: (k10temp) Enable AMD3255 Proc to show negative temperature

Biju Das (1):
      tty: serial: sh-sci: Fix sleeping in atomic context

Bjorn Helgaas (1):
      PCI/ASPM: Return 0 or -ETIMEDOUT from pcie_retrain_link()

Breno Leitao (2):
      cxl/acpi: Fix a use-after-free in cxl_parse_cfmws()
      cxl/acpi: Return 'rc' instead of '0' in cxl_parse_cfmws()

Chaoyuan Peng (1):
      tty: n_gsm: fix UAF in gsm_cleanup_mux

Chenguang Zhao (1):
      LoongArch: BPF: Enable bpf_probe_read{, str}() on LoongArch

Christian Brauner (1):
      file: always lock position for FMODE_ATOMIC_POS

Christian König (2):
      drm/ttm: never consider pinned BOs for eviction&swap
      dma-buf: keep the signaling time of merged fences v3

Christian Marangi (4):
      net: dsa: qca8k: enable use_single_write for qca8xxx
      net: dsa: qca8k: fix search_and_insert wrong handling of new rule
      net: dsa: qca8k: fix broken search_and_del
      net: dsa: qca8k: fix mdb add/del case with 0 VID

Christoph Hellwig (2):
      btrfs: factor out a btrfs_verify_page helper
      btrfs: fix fsverify read error handling in end_page_read

Christophe JAILLET (3):
      i2c: nomadik: Remove a useless call in the remove function
      fs/9p: Fix a datatype used with V9FS_DIRECT_IO
      drm/i915: Fix an error handling path in igt_write_huge()

Claudio Imbrenda (2):
      KVM: s390: pv: simplify shutdown and fix race
      KVM: s390: pv: fix index value of replaced ASCE

Cruise Hung (1):
      drm/amd/display: Update correct DCN314 register header

Dan Carpenter (8):
      phy: phy-mtk-dp: Fix an error code in probe()
      soundwire: amd: Fix a check for errors in probe()
      RDMA/mlx4: Make check for invalid flags stricter
      drm/amd/display: Unlock on error path in dm_handle_mst_sideband_msg_ready_event()
      Revert "usb: gadget: tegra-xudc: Fix error check in tegra_xudc_powerdomain_init()"
      Revert "usb: xhci: tegra: Fix error check"
      proc/vmcore: fix signedness bug in read_from_oldmem()
      dma-buf: fix an error pointer vs NULL bug

Daniel Miess (2):
      drm/amd/display: Fix possible underflow for displays with large vblank
      drm/amd/display: Prevent vtotal from being set to 0

Demi Marie Obenour (1):
      xen: speed up grant-table reclaim

Dmitry Baryshkov (2):
      drm/msm/mdss: correct UBWC programming for SM8550
      drm/msm/dpu: drop enum dpu_core_perf_data_bus_id

Dmytro Laktyushkin (2):
      drm/amd/display: add pixel rate based CRB allocation support
      drm/amd/display: fix dcn315 single stream crb allocation

Dominique Martinet (1):
      9p: fix ignored return value in v9fs_dir_release

Eric Van Hensbergen (4):
      fs/9p: remove unnecessary and overrestrictive check
      fs/9p: fix typo in comparison logic for cache mode
      fs/9p: fix type mismatch in file cache mode helper
      fs/9p: remove unnecessary invalidate_inode_pages2

Fedor Pchelkin (1):
      tipc: stop tipc crypto on failure in tipc_node_create

Filipe Manana (4):
      btrfs: fix race between quota disable and relocation
      btrfs: account block group tree when calculating global reserve size
      btrfs: check if the transaction was aborted at btrfs_wait_for_commit()
      btrfs: check for commit error at btrfs_attach_transaction_barrier()

Florian Westphal (1):
      netfilter: nft_set_rbtree: fix overlap expiration walk

Frank Li (2):
      usb: gadget: call usb_gadget_check_config() to verify UDC capability
      usb: cdns3: fix incorrect calculation of ep_buf_size when more than one config

Gabe Teeger (1):
      drm/amd/display: update extended blank for dcn314 onwards

Gaosheng Cui (1):
      drm/msm: Fix IS_ERR_OR_NULL() vs NULL check in a5xx_submit_in_rb()

Gilles Buloz (1):
      hwmon: (nct7802) Fix for temp6 (PECI1) processed even if PECI1 disabled

Gratian Crisan (1):
      usb: dwc3: pci: skip BYT GPIO lookup table for hardwired phy

Greg Kroah-Hartman (3):
      Documentation: security-bugs.rst: update preferences when dealing with the linux-distros group
      Documentation: security-bugs.rst: clarify CVE handling
      Linux 6.4.8

Guanghui Feng (1):
      ACPI/IORT: Remove erroneous id_count check in iort_node_get_rmr_info()

Guenter Roeck (2):
      regmap: Disable locking for RBTREE and MAPLE unit tests
      hwmon: (pmbus_core) Fix Deadlock in pmbus_regulator_get_status

Guillaume Ranquet (1):
      phy: mediatek: hdmi: mt8195: fix prediv bad upper limit test

Guiting Shen (1):
      usb: ohci-at91: Fix the unhandle interrupt when resume

Hangbin Liu (2):
      bonding: reset bond's flags when down link is P2P device
      team: reset team's flags when down link is P2P device

Hans de Goede (1):
      gpio: tps68470: Make tps68470_gpio_output() always set the initial value

Hao Lan (1):
      net: hns3: fix the imp capability bit cannot exceed 32 bits issue

Haren Myneni (1):
      powerpc/pseries/vas: Hold mmap_mutex after mmap lock during window close

Harshit Mogalapalli (1):
      phy: hisilicon: Fix an out of bounds check in hisi_inno_phy_probe()

Heiner Kallweit (1):
      r8169: revert 2ab19de62d67 ("r8169: remove ASPM restrictions now that ASPM is disabled during NAPI poll")

Hugh Dickins (1):
      tmpfs: fix Documentation of noswap and huge mount options

Ilpo Järvinen (2):
      PCI/ASPM: Factor out pcie_wait_for_retrain()
      PCI/ASPM: Avoid link retraining race

Ilya Dryomov (3):
      rbd: make get_lock_owner_info() return a single locker or NULL
      rbd: harden get_lock_owner_info() a bit
      rbd: retrieve and check lock owner twice before blocklisting

Jacob Keller (2):
      iavf: fix potential deadlock on allocation failure
      iavf: check for removal state before IAVF_FLAG_PF_COMMS_FAILED

Jakub Vanek (1):
      Revert "usb: dwc3: core: Enable AutoRetry feature in the controller"

Jann Horn (3):
      mm: lock VMA in dup_anon_vma() before setting ->anon_vma
      mm: fix memory ordering for mm_lock_seq and vm_lock_seq
      mm/mempolicy: Take VMA lock before replacing policy

Jason Gunthorpe (2):
      iommufd: IOMMUFD_DESTROY should not increase the refcount
      iommufd: Set end correctly when doing batch carry

Jason Wang (1):
      virtio-net: fix race between set queues and probe

Jedrzej Jagielski (1):
      ice: Fix memory management in ice_ethtool_fdir.c

Jens Axboe (1):
      io_uring: gate iowait schedule on having pending requests

Jerry Meng (1):
      USB: serial: option: support Quectel EM060K_128

Jiawen Wu (1):
      net: phy: marvell10g: fix 88x3310 power up

Jijie Shao (2):
      net: hns3: fix wrong tc bandwidth weight data issue
      net: hns3: fix wrong bw weight of disabled tc issue

Jiri Benc (3):
      vxlan: calculate correct header length for GPE
      vxlan: generalize vxlan_parse_gpe_hdr and remove unused args
      vxlan: fix GRO with VXLAN-GPE

Jisheng Zhang (1):
      usb: dwc3: don't reset device side if dwc3 was configured as host-only

Joe Thornber (1):
      dm cache policy smq: ensure IO doesn't prevent cleaner policy progress

Johan Hovold (4):
      serial: qcom-geni: drop bogus runtime pm state update
      USB: serial: simple: sort driver entries
      soundwire: fix enumeration completion
      PM: sleep: wakeirq: fix wake irq arming

Jonas Gorski (1):
      irq-bcm6345-l1: Do not assume a fixed block to cpu mapping

Jonathan Marek (1):
      drm/msm/dpu: add missing flush and fetch bits for DMA4/DMA5 planes

Kashyap Desai (6):
      RDMA/bnxt_re: Prevent handling any completions after qp destroy
      RDMA/bnxt_re: Enhance the existing functions that wait for FW responses
      RDMA/bnxt_re: Avoid the command wait if firmware is inactive
      RDMA/bnxt_re: use shadow qd while posting non blocking rcfw command
      RDMA/bnxt_re: Simplify the function that sends the FW commands
      RDMA/bnxt_re: add helper function __poll_for_resp

Kemeng Shi (1):
      ext4: add EXT4_MB_HINT_GOAL_ONLY test in ext4_mb_use_preallocated

Kim Phillips (1):
      x86/cpu: Enable STIBP on AMD if Automatic IBRS is enabled

Kirill A. Shutemov (1):
      x86/traps: Fix load_unaligned_zeropad() handling for shared TDX memory

Kyle Tso (3):
      usb: typec: Set port->pd before adding device for typec_port
      usb: typec: Iterate pds array when showing the pd list
      usb: typec: Use sysfs_emit_at when concatenating the string

Larry Finger (1):
      staging: r8712: Fix memory leak in _r8712_init_xmit_priv()

Liam R. Howlett (2):
      maple_tree: add __init and __exit to test module
      maple_tree: fix 32 bit mas_next testing

Lin Ma (2):
      macvlan: add forgotten nla_policy for IFLA_MACVLAN_BC_CUTOFF
      net/sched: mqprio: Add length check for TCA_MQPRIO_{MAX/MIN}_RATE64

Linus Torvalds (1):
      mm: suppress mm fault logging if fatal signal already pending

Luka Guzenko (1):
      ALSA: hda/relatek: Enable Mute LED on HP 250 G8

Maciej Żenczykowski (1):
      ipv6 addrconf: fix bug where deleting a mngtmpaddr can create a new temporary address

Marc Kleine-Budde (1):
      can: gs_usb: gs_can_close(): add missing set of CAN state to CAN_STATE_STOPPED

Marc Zyngier (1):
      irqchip/gic-v4.1: Properly lock VPEs when doing a directLPI invalidation

Marijn Suijten (1):
      drm/msm/dsi: Drop unused regulators from QCM2290 14nm DSI PHY config

Mario Limonciello (5):
      drm/amd: Move helper for dynamic speed switch check out of smu13
      drm/amd: Align SMU11 SMU_MSG_OverridePcieParameters implementation with SMU13
      drm/amd/display: Set minimum requirement for using PSR-SU on Rembrandt
      drm/amd/display: Set minimum requirement for using PSR-SU on Phoenix
      drm/amd: Fix an error handling mistake in psp_sw_init()

Mark Brown (2):
      ASoC: wm8904: Fill the cache for WM8904_ADC_TEST_0 register
      arm64/sme: Set new vector length before reallocating

Markus Elfring (2):
      i2c: Delete error messages for failed memory allocations
      i2c: Improve size determinations

Matthieu Baerts (1):
      selftests: mptcp: join: only check for ip6tables if needed

Matus Gajdos (1):
      ASoC: fsl_spdif: Silence output on stop

Maxim Mikityanskiy (1):
      platform/x86: msi-laptop: Fix rfkill out-of-sync on MSI Wind U100

Michael Grzeschik (1):
      usb: gadget: core: remove unbalanced mutex_unlock in usb_gadget_activate

Michael Strauss (2):
      drm/amd/display: Convert Delaying Aux-I Disable To Monitor Patch
      drm/amd/display: Keep disable aux-i delay as 0

Ming Lei (3):
      ublk: fail to start device if queue setup is interrupted
      ublk: fail to recover device if queue setup is interrupted
      ublk: return -EINTR if breaking from waiting for existed users in DEL_DEV

Mohsen Tahmasebi (1):
      USB: serial: option: add Quectel EC200A module support

Muhammad Husaini Zulkifli (1):
      igc: Fix Kernel Panic during ndo_tx_timeout callback

Namjae Jeon (1):
      ksmbd: check if a mount point is crossed during path lookup

Naohiro Aota (1):
      btrfs: zoned: do not enable async discard

Nicolas Dufresne (1):
      media: amphion: Fix firmware path to match linux-firmware

Ojaswin Mujoo (1):
      ext4: fix rbtree traversal bug in ext4_mb_use_preallocated

Oliver Neukum (2):
      USB: serial: simple: add Kaufmann RKS+CAN VCP
      Revert "xhci: add quirk for host controllers that don't update endpoint DCS"

Ondrej Mosnacek (1):
      io_uring: don't audit the capability check in io_uring_create()

Pablo Neira Ayuso (2):
      netfilter: nf_tables: skip immediate deactivate in _PREPARE_ERROR
      netfilter: nf_tables: disallow rule addition to bound chain via NFTA_RULE_CHAIN_ID

Paolo Abeni (1):
      mptcp: more accurate NL event generation

Patrick Rudolph (2):
      hwmon: (pmbus_core) Fix pmbus_is_enabled()
      hwmon: (pmbus_core) Fix NULL pointer dereference

Pavel Asyutchenko (1):
      ALSA: hda/realtek: Support ASUS G713PV laptop

Peter Zijlstra (1):
      locking/rtmutex: Fix task->pi_waiters integrity

Radhakrishna Sripada (1):
      drm/i915/dpt: Use shmem for dpt objects

Randy Dunlap (1):
      media: mtk-jpeg: move data/code inside CONFIG_OF blocks

Ricardo Ribalda (1):
      usb: xhci-mtk: set the dma max_seg_size

Rick Wertenbroek (3):
      PCI: rockchip: Remove writes to unused registers
      PCI: rockchip: Fix window mapping and address translation for endpoint
      PCI: rockchip: Don't advertise MSI-X in PCIe capabilities

Ritesh Harjani (1):
      ext4: mballoc: Remove useless setting of ac_criteria

Rob Clark (3):
      drm/msm/adreno: Fix snapshot BINDLESS_DATA size
      drm/msm: Fix hw_fence error path cleanup
      drm/msm: Disallow submit with fence id 0

Rodrigo Siqueira (1):
      drm/amd/display: Add FAMS validation before trying to use it

Ross Lagerwall (1):
      blk-mq: Fix stall due to recursive flush plug

Ruihong Luo (1):
      serial: 8250_dw: Preserve original value of DLF register

Sakari Ailus (2):
      media: tc358746: Address compiler warnings
      media: staging: atomisp: select V4L2_FWNODE

Samuel Holland (1):
      serial: sifive: Fix sifive_serial_console_setup() section

Samuel Thibault (1):
      TIOCSTI: always enable for CAP_SYS_ADMIN

Sean Christopherson (3):
      KVM: Grab a reference to KVM for VM and vCPU stats file descriptors
      KVM: VMX: Don't fudge CR0 and CR4 for restricted L2 guest
      KVM: x86: Disallow KVM_SET_SREGS{2} if incoming CR0 is invalid

Selvin Xavier (1):
      RDMA/bnxt_re: Fix hang during driver unload

Shiraz Saleem (4):
      RDMA/irdma: Add missing read barriers
      RDMA/irdma: Fix data race on CQP completion stats
      RDMA/irdma: Fix data race on CQP request done
      RDMA/core: Update CMA destination address on rdma_resolve_addr

Shyam Sundar S K (2):
      platform/x86/amd/pmf: Notify OS power slider update
      platform/x86/amd/pmf: reduce verbosity of apmf_get_system_params

Sidhartha Kumar (1):
      mm/memory-failure: fix hardware poison check in unpoison_memory()

Sindhu Devale (2):
      RDMA/irdma: Fix op_type reporting in CQEs
      RDMA/irdma: Report correct WC error

Srinivas Kandagatla (1):
      soundwire: qcom: update status correctly with mask

Stefan Haberland (2):
      s390/dasd: fix hanging device after quiesce/resume
      s390/dasd: print copy pair message only for the correct error

Stefano Stabellini (1):
      xenbus: check xen_domain in xenbus_probe_initcall

Steve French (1):
      smb3: do not set NTLMSSP_VERSION flag for negotiate not auth request

Stewart Smith (1):
      tcp: Reduce chance of collisions in inet6_hashfn().

Sudeep Holla (1):
      KVM: arm64: Handle kvm_arm_init failure correctly in finalize_pkvm

Suman Ghosh (1):
      octeontx2-af: Fix hash extraction enable configuration

Sven Schnelle (1):
      s390/mm: fix per vma lock fault handling

Thomas Bogendoerfer (1):
      RDMA/mthca: Fix crash when polling CQ for shared QPs

Tiezhu Yang (1):
      LoongArch: BPF: Fix check condition to call lu32id in move_imm()

Trond Myklebust (1):
      nfsd: Remove incorrect check in nfsd4_validate_stateid

Uwe Kleine-König (1):
      gpio: mvebu: Make use of devm_pwmchip_add

Vincent Whitchurch (1):
      net: stmmac: Apply redundant write work around on 4.xx too

WANG Rui (1):
      LoongArch: Fix return value underflow in exception path

Wang Ming (1):
      i40e: Fix an NULL vs IS_ERR() bug for debugfs_create_dir()

Wei Fang (2):
      net: fec: avoid tx queue timeout when XDP is enabled
      net: fec: tx processing does not call XDP APIs if budget is 0

Xiubo Li (1):
      ceph: never send metrics if disable_send_metrics is set

Xu Yang (1):
      usb: misc: ehset: fix wrong if condition

Yazen Ghannam (1):
      x86/MCE/AMD: Decrement threshold_bank refcount when removing threshold blocks

Yu Kuai (3):
      dm raid: fix missing reconfig_mutex unlock in raid_ctr() error paths
      dm raid: clean up four equivalent goto tags in raid_ctr()
      dm raid: protect md_stop() with 'reconfig_mutex'

Yuanjun Gong (4):
      atheros: fix return value check in atl1_tso()
      ethernet: atheros: fix return value check in atl1e_tso_csum()
      benet: fix return value check in be_lancer_xmit_workarounds()
      tipc: check return value of pskb_trim()

Zhang Shurong (1):
      staging: ks7010: potential buffer overflow in ks_wlan_set_encode_ext()

Zheng Yejian (2):
      ring-buffer: Fix wrong stat of cpu_buffer->read
      tracing: Fix warning in trace_buffered_event_disable()

Zhihao Cheng (1):
      jbd2: Fix wrongly judgement for buffer head removing while doing checkpoint

Zqiang (1):
      USB: gadget: Fix the memory leak in raw_gadget driver

Łukasz Bartosik (1):
      USB: quirks: add quirk for Focusrite Scarlett

