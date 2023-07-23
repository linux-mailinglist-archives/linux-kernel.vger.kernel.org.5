Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 789B175E1D9
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 14:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbjGWM2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 08:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbjGWM2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 08:28:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE82E6C;
        Sun, 23 Jul 2023 05:28:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3DBDE60C80;
        Sun, 23 Jul 2023 12:28:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17C02C433BB;
        Sun, 23 Jul 2023 12:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690115319;
        bh=pRy9o7z73NyLVr0Mp7qoj3EZfRxTFiwQZatvzVWA4xs=;
        h=From:To:Cc:Subject:Date:From;
        b=ds1ROH+4xmGPgVfHeg8UTuGctletKKnxeNxd/HKgjPLmteNCpU02macd0K9cnqnIi
         ZYZAVP4J/jj0ZmUTVzRakkkJ7mEC0u1tDS14Zw+ZJzaEV1Ll0Btlsi7YF6peg66rpG
         B2ueaDq9IhjUrr9SEOzi16o0Y4N1ICxxwfogkLsM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.4.5
Date:   Sun, 23 Jul 2023 14:28:31 +0200
Message-ID: <2023072332-antitoxic-uninvited-1306@gregkh>
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

I'm announcing the release of the 6.4.5 kernel.

All users of the 6.4 kernel series must upgrade.

The updated 6.4.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.4.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/arm64/silicon-errata.rst                              |    3 
 Documentation/userspace-api/media/v4l/vidioc-subdev-g-routing.rst   |    2 
 Makefile                                                            |   28 -
 arch/arm64/Kconfig                                                  |   19 
 arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-nor.dtso       |    7 
 arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts                    |   42 -
 arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts              |   76 +-
 arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi                    |   29 +
 arch/arm64/kernel/cpu_errata.c                                      |    7 
 arch/arm64/kernel/traps.c                                           |    2 
 arch/arm64/kvm/hyp/pgtable.c                                        |   14 
 arch/arm64/mm/fault.c                                               |    2 
 arch/arm64/tools/cpucaps                                            |    1 
 arch/mips/Makefile                                                  |   10 
 arch/mips/include/asm/cpu-features.h                                |    4 
 arch/mips/include/asm/kvm_host.h                                    |    6 
 arch/mips/kernel/cpu-probe.c                                        |    9 
 arch/mips/kvm/emulate.c                                             |   22 
 arch/mips/kvm/mips.c                                                |   16 
 arch/mips/kvm/stats.c                                               |    4 
 arch/mips/kvm/trace.h                                               |    8 
 arch/mips/kvm/vz.c                                                  |   20 
 arch/openrisc/include/uapi/asm/sigcontext.h                         |    6 
 arch/openrisc/kernel/signal.c                                       |    4 
 arch/powerpc/Makefile                                               |    8 
 arch/powerpc/kernel/security.c                                      |   37 -
 arch/powerpc/mm/book3s64/hash_native.c                              |   13 
 arch/riscv/mm/init.c                                                |    2 
 arch/riscv/net/bpf_jit.h                                            |    6 
 arch/riscv/net/bpf_jit_core.c                                       |   19 
 arch/s390/Makefile                                                  |    1 
 arch/x86/events/intel/core.c                                        |    7 
 arch/xtensa/platforms/iss/network.c                                 |    2 
 block/blk-crypto-profile.c                                          |   12 
 drivers/accel/ivpu/ivpu_drv.h                                       |    1 
 drivers/accel/ivpu/ivpu_hw_mtl.c                                    |   20 
 drivers/base/regmap/regmap-irq.c                                    |    2 
 drivers/bus/intel-ixp4xx-eb.c                                       |    2 
 drivers/char/hw_random/imx-rngc.c                                   |    6 
 drivers/char/tpm/tpm-chip.c                                         |    7 
 drivers/char/tpm/tpm_crb.c                                          |   19 
 drivers/char/tpm/tpm_tis.c                                          |   25 
 drivers/char/tpm/tpm_tis_core.c                                     |  103 +++
 drivers/char/tpm/tpm_tis_core.h                                     |    4 
 drivers/char/tpm/tpm_tis_i2c.c                                      |   59 +-
 drivers/char/tpm/tpm_vtpm_proxy.c                                   |   30 -
 drivers/firmware/stratix10-svc.c                                    |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c                    |    3 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c                              |   12 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c                   |   64 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.h               |    2 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c           |   26 +
 drivers/gpu/drm/amd/display/dc/core/dc.c                            |    3 
 drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c             |   10 
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c                  |   11 
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c                  |    4 
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c                   |    2 
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.h                   |    1 
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c               |    2 
 drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c                |   15 
 drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.h                |    2 
 drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c |   11 
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h                         |    2 
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h                        |    4 
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c                   |    2 
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c                     |    2 
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c             |    2 
 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c                  |    2 
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c                      |   67 ++
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c                |   35 -
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c                |    2 
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c                |   33 -
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c                           |    9 
 drivers/gpu/drm/bridge/ti-sn65dsi86.c                               |   35 -
 drivers/gpu/drm/display/drm_dp_mst_topology.c                       |   54 +-
 drivers/gpu/drm/drm_atomic.c                                        |   11 
 drivers/gpu/drm/drm_atomic_helper.c                                 |   11 
 drivers/gpu/drm/drm_client.c                                        |   21 
 drivers/gpu/drm/drm_fbdev_dma.c                                     |    6 
 drivers/gpu/drm/drm_fbdev_generic.c                                 |    4 
 drivers/gpu/drm/exynos/exynos_drm_fbdev.c                           |    4 
 drivers/gpu/drm/gma500/fbdev.c                                      |    4 
 drivers/gpu/drm/i915/display/intel_display.c                        |    1 
 drivers/gpu/drm/i915/display/intel_dp.c                             |    7 
 drivers/gpu/drm/i915/gt/intel_gtt.c                                 |    2 
 drivers/gpu/drm/msm/msm_fbdev.c                                     |    4 
 drivers/gpu/drm/nouveau/dispnv50/disp.c                             |   12 
 drivers/gpu/drm/nouveau/nouveau_chan.c                              |    1 
 drivers/gpu/drm/nouveau/nouveau_chan.h                              |    1 
 drivers/gpu/drm/nouveau/nouveau_drm.c                               |   20 
 drivers/gpu/drm/nouveau/nvkm/engine/disp/g94.c                      |    1 
 drivers/gpu/drm/nouveau/nvkm/engine/disp/gt215.c                    |    2 
 drivers/gpu/drm/nouveau/nvkm/subdev/acr/base.c                      |    2 
 drivers/gpu/drm/omapdrm/omap_fbdev.c                                |    4 
 drivers/gpu/drm/panel/panel-simple.c                                |    2 
 drivers/gpu/drm/radeon/radeon_fbdev.c                               |    4 
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c                         |    8 
 drivers/gpu/drm/tegra/fbdev.c                                       |    4 
 drivers/gpu/drm/ttm/ttm_bo.c                                        |   23 
 drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_desc.c                       |   30 -
 drivers/hid/hid-hyperv.c                                            |   10 
 drivers/hid/hid-input.c                                             |    7 
 drivers/iio/adc/meson_saradc.c                                      |    2 
 drivers/md/dm-integrity.c                                           |    4 
 drivers/md/dm-verity-loadpin.c                                      |    3 
 drivers/md/raid0.c                                                  |   62 ++
 drivers/md/raid0.h                                                  |    1 
 drivers/mfd/qcom-pm8008.c                                           |    1 
 drivers/misc/fastrpc.c                                              |    2 
 drivers/misc/pci_endpoint_test.c                                    |   10 
 drivers/mtd/nand/raw/meson_nand.c                                   |    4 
 drivers/net/dsa/hirschmann/hellcreek.c                              |   14 
 drivers/net/dsa/ocelot/felix.c                                      |    6 
 drivers/net/dsa/ocelot/felix.h                                      |    1 
 drivers/net/dsa/ocelot/felix_vsc9959.c                              |   28 -
 drivers/net/dsa/qca/qca8k-8xxx.c                                    |    3 
 drivers/net/dsa/sja1105/sja1105_tas.c                               |    7 
 drivers/net/ethernet/amazon/ena/ena_com.c                           |    3 
 drivers/net/ethernet/broadcom/bgmac.c                               |    4 
 drivers/net/ethernet/broadcom/genet/bcmmii.c                        |    2 
 drivers/net/ethernet/engleder/tsnep_selftests.c                     |   12 
 drivers/net/ethernet/engleder/tsnep_tc.c                            |    4 
 drivers/net/ethernet/freescale/enetc/enetc_qos.c                    |    6 
 drivers/net/ethernet/freescale/fec.h                                |   17 
 drivers/net/ethernet/freescale/fec_main.c                           |  178 ++++--
 drivers/net/ethernet/google/gve/gve_ethtool.c                       |    3 
 drivers/net/ethernet/intel/ice/ice_main.c                           |   23 
 drivers/net/ethernet/intel/ice/ice_tc_lib.c                         |   22 
 drivers/net/ethernet/intel/ice/ice_tc_lib.h                         |    1 
 drivers/net/ethernet/intel/igc/igc.h                                |   15 
 drivers/net/ethernet/intel/igc/igc_ethtool.c                        |    2 
 drivers/net/ethernet/intel/igc/igc_main.c                           |  158 +++++-
 drivers/net/ethernet/intel/igc/igc_ptp.c                            |   25 
 drivers/net/ethernet/intel/igc/igc_tsn.c                            |   68 +-
 drivers/net/ethernet/marvell/mvneta.c                               |    4 
 drivers/net/ethernet/marvell/octeontx2/af/ptp.c                     |   19 
 drivers/net/ethernet/marvell/octeontx2/af/rvu.c                     |    2 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c                 |   11 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.c            |   23 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c             |    8 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c                |   15 
 drivers/net/ethernet/mellanox/mlx5/core/en/fs_tt_redirect.c         |    6 
 drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c                    |    6 
 drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c                  |   14 
 drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.h                  |    1 
 drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c                    |    3 
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/fs_tcp.c           |    1 
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c                     |   44 -
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c                     |    6 
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c                   |    3 
 drivers/net/ethernet/mellanox/mlx5/core/thermal.c                   |   19 
 drivers/net/ethernet/microchip/Kconfig                              |    2 
 drivers/net/ethernet/microchip/lan743x_main.c                       |   21 
 drivers/net/ethernet/microchip/lan966x/lan966x_tc.c                 |   10 
 drivers/net/ethernet/mscc/ocelot_mm.c                               |    7 
 drivers/net/ethernet/netronome/nfp/nfp_net_common.c                 |    5 
 drivers/net/ethernet/pensando/ionic/ionic_lif.c                     |    5 
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c                     |    7 
 drivers/net/ethernet/ti/am65-cpsw-qos.c                             |   11 
 drivers/net/ethernet/wangxun/txgbe/txgbe_hw.c                       |    3 
 drivers/net/netdevsim/dev.c                                         |    9 
 drivers/net/phy/dp83td510.c                                         |   23 
 drivers/net/wireless/cisco/airo.c                                   |    5 
 drivers/net/wireless/realtek/rtw89/debug.c                          |    5 
 drivers/ntb/hw/amd/ntb_hw_amd.c                                     |    7 
 drivers/ntb/hw/idt/ntb_hw_idt.c                                     |    7 
 drivers/ntb/hw/intel/ntb_hw_gen1.c                                  |    7 
 drivers/ntb/ntb_transport.c                                         |    2 
 drivers/ntb/test/ntb_tool.c                                         |    2 
 drivers/nvme/host/core.c                                            |   36 +
 drivers/nvme/host/pci.c                                             |    2 
 drivers/opp/core.c                                                  |    3 
 drivers/pci/controller/dwc/pcie-qcom.c                              |    2 
 drivers/pci/controller/pcie-rockchip-ep.c                           |   65 --
 drivers/pci/controller/pcie-rockchip.c                              |   17 
 drivers/pci/controller/pcie-rockchip.h                              |   11 
 drivers/pci/endpoint/functions/pci-epf-test.c                       |   40 +
 drivers/pci/pci.c                                                   |   10 
 drivers/pci/probe.c                                                 |    4 
 drivers/pci/quirks.c                                                |    2 
 drivers/perf/riscv_pmu.c                                            |    3 
 drivers/pinctrl/pinctrl-amd.c                                       |  103 +--
 drivers/pinctrl/pinctrl-amd.h                                       |    2 
 drivers/platform/x86/wmi.c                                          |   22 
 drivers/pwm/pwm-meson.c                                             |   28 -
 drivers/s390/crypto/zcrypt_msgtype6.c                               |    6 
 drivers/s390/net/ism_drv.c                                          |  139 ++---
 drivers/scsi/lpfc/lpfc_crtn.h                                       |    1 
 drivers/scsi/lpfc/lpfc_els.c                                        |   30 -
 drivers/scsi/lpfc/lpfc_hbadisc.c                                    |   24 
 drivers/scsi/mpi3mr/mpi3mr_fw.c                                     |    5 
 drivers/scsi/qla2xxx/qla_attr.c                                     |   13 
 drivers/scsi/qla2xxx/qla_bsg.c                                      |    6 
 drivers/scsi/qla2xxx/qla_def.h                                      |   22 
 drivers/scsi/qla2xxx/qla_edif.c                                     |    4 
 drivers/scsi/qla2xxx/qla_gbl.h                                      |    2 
 drivers/scsi/qla2xxx/qla_init.c                                     |  258 +++++++++-
 drivers/scsi/qla2xxx/qla_inline.h                                   |    5 
 drivers/scsi/qla2xxx/qla_iocb.c                                     |   38 +
 drivers/scsi/qla2xxx/qla_isr.c                                      |   64 ++
 drivers/scsi/qla2xxx/qla_nvme.c                                     |    3 
 drivers/scsi/qla2xxx/qla_os.c                                       |  133 ++---
 drivers/soc/qcom/mdt_loader.c                                       |   16 
 drivers/soundwire/qcom.c                                            |    3 
 drivers/tty/n_tty.c                                                 |   25 
 drivers/tty/serial/8250/8250.h                                      |    1 
 drivers/tty/serial/8250/8250_pci.c                                  |   19 
 drivers/tty/serial/8250/8250_port.c                                 |   11 
 drivers/tty/serial/atmel_serial.c                                   |    4 
 drivers/tty/serial/imx.c                                            |   18 
 drivers/tty/serial/samsung_tty.c                                    |   14 
 drivers/ufs/host/Kconfig                                            |    1 
 drivers/usb/host/xhci-mem.c                                         |   39 +
 drivers/usb/host/xhci-pci.c                                         |   12 
 drivers/usb/host/xhci.h                                             |    2 
 drivers/xen/grant-dma-ops.c                                         |    2 
 fs/ceph/addr.c                                                      |   85 ++-
 fs/ceph/caps.c                                                      |    9 
 fs/ceph/super.h                                                     |   13 
 fs/dlm/ast.c                                                        |    8 
 fs/dlm/lockspace.c                                                  |   12 
 fs/dlm/lockspace.h                                                  |    1 
 fs/dlm/lowcomms.c                                                   |    1 
 fs/dlm/midcomms.c                                                   |    3 
 fs/dlm/plock.c                                                      |  115 ++--
 fs/erofs/inode.c                                                    |    3 
 fs/erofs/zdata.c                                                    |    4 
 fs/ext2/inode.c                                                     |    5 
 fs/ext4/indirect.c                                                  |    8 
 fs/ext4/inode.c                                                     |   10 
 fs/ext4/ioctl.c                                                     |    5 
 fs/ext4/mballoc.c                                                   |   17 
 fs/ext4/super.c                                                     |   31 -
 fs/f2fs/dir.c                                                       |    9 
 fs/f2fs/super.c                                                     |   30 -
 fs/f2fs/xattr.c                                                     |    6 
 fs/jfs/jfs_dmap.c                                                   |    6 
 fs/jfs/jfs_filsys.h                                                 |    2 
 fs/smb/client/cifs_dfs_ref.c                                        |   20 
 fs/smb/client/cifsproto.h                                           |    2 
 fs/smb/client/cifssmb.c                                             |    2 
 fs/smb/client/dfs.c                                                 |   43 -
 fs/smb/client/file.c                                                |    4 
 fs/smb/client/fs_context.c                                          |   59 +-
 fs/smb/client/misc.c                                                |   17 
 fs/smb/client/smb2transport.c                                       |    7 
 fs/smb/server/smb2pdu.c                                             |  109 ++--
 include/drm/display/drm_dp_mst_helper.h                             |    7 
 include/linux/blk-crypto-profile.h                                  |    1 
 include/linux/ism.h                                                 |    7 
 include/linux/kasan.h                                               |    2 
 include/linux/nvme.h                                                |    2 
 include/linux/rethook.h                                             |    1 
 include/linux/serial_8250.h                                         |    1 
 include/net/netfilter/nf_conntrack_tuple.h                          |    3 
 include/net/netfilter/nf_tables.h                                   |   31 +
 include/net/pkt_sched.h                                             |    9 
 include/soc/mscc/ocelot.h                                           |    1 
 kernel/bpf/cpumap.c                                                 |   40 -
 kernel/bpf/verifier.c                                               |    5 
 kernel/dma/swiotlb.c                                                |   46 +
 kernel/power/qos.c                                                  |    9 
 kernel/trace/fprobe.c                                               |   15 
 kernel/trace/ftrace.c                                               |   45 +
 kernel/trace/rethook.c                                              |   13 
 kernel/trace/ring_buffer.c                                          |   24 
 kernel/trace/trace.c                                                |    3 
 kernel/trace/trace.h                                                |    2 
 kernel/trace/trace_eprobe.c                                         |   18 
 kernel/trace/trace_events_hist.c                                    |    8 
 kernel/trace/trace_events_user.c                                    |    6 
 kernel/trace/trace_probe.c                                          |    2 
 kernel/trace/trace_probe_kernel.h                                   |   30 -
 kernel/trace/trace_probe_tmpl.h                                     |   10 
 kernel/trace/trace_uprobe.c                                         |    3 
 mm/kasan/common.c                                                   |    2 
 mm/kasan/generic.c                                                  |   73 +-
 mm/kasan/kasan.h                                                    |  171 +++---
 mm/kasan/report.c                                                   |   17 
 mm/kasan/report_generic.c                                           |   12 
 mm/kasan/report_hw_tags.c                                           |    2 
 mm/kasan/report_sw_tags.c                                           |    2 
 mm/kasan/shadow.c                                                   |   36 -
 mm/kasan/sw_tags.c                                                  |   20 
 mm/mmap.c                                                           |    9 
 mm/slab.h                                                           |   16 
 net/ceph/messenger_v2.c                                             |   41 +
 net/core/net-traces.c                                               |    2 
 net/core/skbuff.c                                                   |    5 
 net/core/xdp.c                                                      |    2 
 net/ipv6/addrconf.c                                                 |    3 
 net/ipv6/icmp.c                                                     |    5 
 net/ipv6/udp.c                                                      |    4 
 net/mptcp/protocol.c                                                |    7 
 net/ncsi/ncsi-rsp.c                                                 |   93 ---
 net/netfilter/nf_conntrack_core.c                                   |   20 
 net/netfilter/nf_tables_api.c                                       |  163 +++---
 net/netfilter/nft_flow_offload.c                                    |    6 
 net/netfilter/nft_immediate.c                                       |    8 
 net/netfilter/nft_objref.c                                          |    8 
 net/sched/cls_flower.c                                              |   10 
 net/sched/cls_fw.c                                                  |   10 
 net/sched/sch_qfq.c                                                 |   18 
 net/sched/sch_taprio.c                                              |    4 
 samples/ftrace/ftrace-direct-too.c                                  |   14 
 security/integrity/platform_certs/load_powerpc.c                    |   40 +
 tools/testing/selftests/net/mptcp/config                            |    1 
 tools/testing/selftests/net/mptcp/mptcp_connect.sh                  |    3 
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh                  |   29 -
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c                       |   10 
 tools/testing/selftests/net/mptcp/userspace_pm.sh                   |    4 
 311 files changed, 3509 insertions(+), 1986 deletions(-)

Adrián Larumbe (1):
      drm: bridge: dw_hdmi: fix connector access for scdc

Alan Liu (1):
      drm/amd/display: Fix in secure display context creation

Alexander Aring (8):
      fs: dlm: revert check required context while close
      fs: dlm: return positive pid value for F_GETLK
      fs: dlm: fix cleanup pending ops when interrupted
      fs: dlm: interrupt posix locks only when process is killed
      fs: dlm: make F_SETLK use unkillable wait_event
      fs: dlm: fix mismatch of plock results from userspace
      fs: dlm: clear pending bit when queue was empty
      fs: dlm: fix missing pending to false

Alexander Sverdlin (2):
      tpm: tis_i2c: Limit read bursts to I2C_SMBUS_BLOCK_MAX (32) bytes
      tpm: tis_i2c: Limit write bursts to I2C_SMBUS_BLOCK_MAX (32) bytes

Alvin Lee (1):
      drm/amd/display: Limit DCN32 8 channel or less parts to DPM1 for FPO

Andrey Konovalov (2):
      kasan, slub: fix HW_TAGS zeroing with slub_debug
      kasan: fix type cast in memory_is_poisoned_n

Andy Shevchenko (1):
      platform/x86: wmi: Break possible infinite loop when parsing GUID

Ankit Kumar (1):
      nvme: fix the NVME_ID_NS_NVM_STS_MASK definition

Aravindhan Gunasekaran (1):
      igc: Handle PPS start time programming for past time values

Arnd Bergmann (3):
      HID: hyperv: avoid struct memcpy overrun warning
      kasan: add kasan_tag_mismatch prototype
      kasan: use internal prototypes matching gcc-13 builtins

Arseniy Krasnov (1):
      mtd: rawnand: meson: fix unaligned DMA buffers handling

Aurabindo Pillai (1):
      drm/amd/display: Add monitor specific edid quirk

Austin Zheng (1):
      drm/amd/display: Remove Phantom Pipe Check When Calculating K1 and K2

Baokun Li (2):
      ext4: turn quotas off if mount failed after enabling quotas
      ext4: only update i_reserved_data_blocks on successful block allocation

Basavaraj Natikar (2):
      HID: amd_sfh: Rename the float32 variable
      HID: amd_sfh: Fix for shift-out-of-bounds

Beau Belgrave (1):
      tracing/user_events: Fix struct arg size match check

Bharath SM (1):
      cifs: if deferred close is disabled then close files immediately

Bikash Hazarika (2):
      scsi: qla2xxx: Fix potential NULL pointer dereference
      scsi: qla2xxx: Correct the index of array

Björn Töpel (1):
      riscv, bpf: Fix inconsistent JIT image generation

Brian Norris (2):
      drm/atomic: Allow vblank-enabled + self-refresh "disable"
      drm/rockchip: vop: Leave vblank enabled in self-refresh

Chao Yu (2):
      f2fs: don't reset unchangable mount option in f2fs_remount()
      ext4: fix to check return value of freeze_bdev() in ext4_shutdown()

Christian Hesse (2):
      tpm/tpm_tis: Disable interrupts for Framework Laptop Intel 12th gen
      tpm/tpm_tis: Disable interrupts for Framework Laptop Intel 13th gen

Christian Marangi (1):
      soc: qcom: mdt_loader: Fix unconditional call to scm_pas_mem_setup

Christoph Hellwig (1):
      nvme: don't reject probe due to duplicate IDs for single-ported PCIe devices

Christophe JAILLET (3):
      tty: serial: samsung_tty: Fix a memory leak in s3c24xx_serial_getclk() in case of error
      tty: serial: samsung_tty: Fix a memory leak in s3c24xx_serial_getclk() when iterating clk
      firmware: stratix10-svc: Fix a potential resource leak in svc_create_memory_pool()

Chungkai Yang (1):
      PM: QoS: Restore support for default value on frequency QoS

Chunhai Guo (2):
      erofs: avoid useless loops in z_erofs_pcluster_readmore() when reading beyond EOF
      erofs: avoid infinite loop in z_erofs_do_read_page() when reading beyond EOF

Damien Le Moal (5):
      PCI: epf-test: Fix DMA transfer completion initialization
      PCI: epf-test: Fix DMA transfer completion detection
      PCI: rockchip: Set address alignment for endpoint mode
      misc: pci_endpoint_test: Free IRQs before removing the device
      misc: pci_endpoint_test: Re-init completion for every test

Dan Carpenter (5):
      scsi: qla2xxx: Fix error code in qla2x00_start_sp()
      netdevsim: fix uninitialized data in nsim_dev_trap_fa_cookie_write()
      serial: atmel: don't enable IRQs prematurely
      scsi: qla2xxx: Fix end of loop test
      net: dsa: ocelot: unlock on error in vsc9959_qos_port_tas_set()

Daniel Vetter (1):
      drm/atomic: Fix potential use-after-free in nonblocking commits

David Woodhouse (1):
      mm/mmap: Fix error return in do_vmi_align_munmap()

Dmitry Torokhov (1):
      HID: input: fix mapping for camera access keys

Dmytro Laktyushkin (1):
      drm/amd/display: fix seamless odm transitions

Douglas Anderson (1):
      drm/bridge: ti-sn65dsi86: Fix auxiliary bus lifetime

Dragos Tatulea (2):
      net/mlx5e: RX, Fix flush and close release flow of regular rq for legacy rq
      net/mlx5e: RX, Fix page_pool page fragment tracking for XDP

Ekansh Gupta (1):
      misc: fastrpc: Create fastrpc scalar with correct buffer count

Eric Biggers (1):
      blk-crypto: use dynamic lock class for blk_crypto_profile::lock

Eric Dumazet (1):
      udp6: fix udp6_ehashfn() typo

Eric Lin (1):
      perf: RISC-V: Remove PERF_HES_STOPPED flag checking in riscv_pmu_start()

Evan Quan (1):
      drm/amd/pm: share the code around SMU13 pcie parameters update

Fabio Estevam (1):
      drm/panel: simple: Add connector_type for innolux_at043tn24

Florent Revest (1):
      samples: ftrace: Save required argument registers in sample trampolines

Florian Bezdeka (1):
      tpm/tpm_tis: Disable interrupts for Lenovo L590 devices

Florian Fainelli (1):
      net: bcmgenet: Ensure MDIO unregistration has clocks enabled

Florian Kauer (6):
      igc: Rename qbv_enable to taprio_offload_enable
      igc: Do not enable taprio offload for invalid arguments
      igc: Handle already enabled taprio offload for basetime 0
      igc: No strict mode in pure launchtime/CBS offload
      igc: Fix launchtime before start of cycle
      igc: Fix inserting of empty frame for launchtime

Florian Westphal (1):
      netfilter: conntrack: don't fold port numbers into addresses before hashing

Frank Wunderlich (1):
      arm64: dts: mt7986: use size of reserved partition for bl2

Geert Uytterhoeven (1):
      drm/fbdev-dma: Fix documented default preferred_bpp value

George Stark (1):
      meson saradc: fix clock divider mask length

Greg Kroah-Hartman (1):
      Linux 6.4.5

Gustavo A. R. Silva (1):
      smb: client: Fix -Wstringop-overflow issues

Hamza Mahfooz (1):
      drm/amd/display: perform a bounds check before filling dirty rectangles

Harald Freudenberger (1):
      s390/zcrypt: do not retry administrative requests

Heiko Carstens (1):
      s390/decompressor: fix misaligned symbol build error

Heiner Kallweit (2):
      pwm: meson: modify and simplify calculation in meson_pwm_get_state
      pwm: meson: fix handling of period/duty if greater than UINT_MAX

Hersen Wu (1):
      drm/amd/display: edp do not add non-edid timings

Huacai Chen (3):
      MIPS: Loongson: Fix cpu_probe_loongson() again
      MIPS: Loongson: Fix build error when make modules_install
      MIPS: KVM: Fix NULL pointer dereference

Hui Li (1):
      tty: fix hang on tty device with no_room set

Ido Schimmel (1):
      net/sched: flower: Ensure both minimum and maximum ports are specified

Ilya Bakoulin (1):
      drm/amd/display: Fix 128b132b link loss handling

Ilya Dryomov (1):
      libceph: harden msgr2.1 frame segment length checks

Isaac J. Manjarres (1):
      regmap-irq: Fix out-of-bounds access when allocating config buffers

Ivan Babrou (1):
      udp6: add a missing call into udp_fail_queue_rcv_skb tracepoint

Ivan Mikhaylov (2):
      net/ncsi: make one oem_gma function for all mfr id
      net/ncsi: change from ndo_set_mac_address to dev_set_mac_address

Jaegeuk Kim (1):
      f2fs: fix deadlock in i_xattr_sem and inode page lock

Jarkko Sakkinen (1):
      tpm: tpm_vtpm_proxy: fix a race condition in /dev/vtpmx creation

Jason Baron (1):
      md/raid0: add discard support for the 'original' layout

Jerry Snitselaar (1):
      tpm: return false from tpm_amd_is_rng_defective on non-x86 platforms

Jesper Dangaard Brouer (2):
      igc: Add igc_xdp_buff wrapper for xdp_buff in driver
      igc: Add XDP hints kfuncs for RX hash

Jiaqing Zhao (1):
      Revert "8250: add support for ASIX devices with a FIFO bug"

Jiasheng Jiang (2):
      NTB: ntb_tool: Add check for devm_kcalloc
      net: dsa: qca8k: Add check for skb_copy

Jiawen Wu (1):
      net: txgbe: fix eeprom calculation error

Jiaxun Yang (1):
      MIPS: cpu-features: Use boot_cpu_type for CPU type based features

Jiri Olsa (1):
      fprobe: Release rethook after the ftrace_ops is unregistered

Jisheng Zhang (1):
      riscv: mm: fix truncation warning on RV32

Johan Hovold (1):
      mfd: pm8008: Fix module autoloading

Jonas Gorski (1):
      bus: ixp4xx: fix IXP4XX_EXP_T1_MASK

Junfeng Guo (1):
      gve: Set default duplex configuration to full

Justin Tee (1):
      scsi: lpfc: Fix double free in lpfc_cmpl_els_logo_acc() caused by lpfc_nlp_not_used()

Karol Herbst (4):
      drm/nouveau/disp: fix HDMI on gt215+
      drm/nouveau/disp/g94: enable HDMI
      drm/nouveau/acr: Abort loading ACR if no firmware was found
      drm/nouveau: bring back blit subchannel for pre nv50 GPUs

Karol Wachowski (2):
      accel/ivpu: Fix VPU register access in irq disable
      accel/ivpu: Clear specific interrupt status bits on C0

Kemeng Shi (3):
      ext4: fix wrong unit use in ext4_mb_clear_bb
      ext4: get block from bh in ext4_free_blocks for fast commit replay
      ext4: fix wrong unit use in ext4_mb_new_blocks

Klaus Kudielka (1):
      net: mvneta: fix txq_map in case of txq_number==1

Kornel Dulęba (1):
      pinctrl: amd: Detect and mask spurious interrupts

Krister Johansen (1):
      net: ena: fix shift-out-of-bounds in exponential backoff

Krzysztof Kozlowski (1):
      soundwire: qcom: fix storing port config out-of-bounds

Kumar Kartikeya Dwivedi (1):
      bpf: Fix max stack depth check for async callbacks

Kuniyuki Iwashima (1):
      icmp6: Fix null-ptr-deref of ip6_null_entry->rt6i_idev in icmp6_dev().

Larysa Zaremba (1):
      xdp: use trusted arguments in XDP hints kfuncs

Leo Chen (1):
      drm/amd/display: disable seamless boot if force_odm_combine is enabled

Lino Sanfilippo (1):
      tpm,tpm_tis: Disable interrupts after 1000 unhandled IRQs

Lu Hongfei (1):
      net: dsa: Removed unneeded of_node_put in felix_parse_ports_node

M A Ramdhan (1):
      net/sched: cls_fw: Fix improper refcount update leads to use-after-free

Maher Sanalla (1):
      net/mlx5: Query hca_cap_2 only when supported

Manish Rangankar (1):
      scsi: qla2xxx: Remove unused nvme_ls_waitq wait queue

Manivannan Sadhasivam (1):
      PCI: qcom: Disable write access to read only registers for IP v2.3.3

Marek Vasut (1):
      drm/panel: simple: Add Powertip PH800480T013 drm_display_mode flags

Mario Limonciello (11):
      pinctrl: amd: Detect internal GPIO0 debounce handling
      pinctrl: amd: Fix mistake in handling clearing pins at startup
      pinctrl: amd: Revert "pinctrl: amd: disable and mask interrupts on probe"
      pinctrl: amd: Only use special debounce behavior for GPIO 0
      pinctrl: amd: Use amd_pinconf_set() for all config options
      pinctrl: amd: Drop pull up select configuration
      pinctrl: amd: Unify debounce handling into amd_pinconf_set()
      drm/amd: Disable PSR-SU on Parade 0803 TCON
      drm/amd/display: Correct `DMUB_FW_VERSION` macro
      drm/amd/pm: conditionally disable pcie lane/speed switching for SMU13
      Revert "drm/amd: Disable PSR-SU on Parade 0803 TCON"

Martin Fuzzey (1):
      tty: serial: imx: fix rs485 rx after tx

Martin Kaiser (1):
      hwrng: imx-rngc - fix the timeout for init and self check

Masahiro Yamada (1):
      kbuild: make modules_install copy modules.builtin(.modinfo)

Masami Hiramatsu (Google) (6):
      fprobe: Ensure running fprobe_exit_handler() finished before calling rethook_free()
      tracing/probes: Fix to avoid double count of the string length on the array
      tracing/probes: Fix not to count error code to total length
      tracing/probes: Fix to update dynamic data counter if fetcharg uses it
      Revert "tracing: Add "(fault)" name injection to kernel probes"
      tracing/probes: Fix to record 0-length data_loc in fetch_store_string*() if fails

Mateusz Stachyra (1):
      tracing: Fix null pointer dereference in tracing_err_log_open()

Matthias Kaehlcke (1):
      dm: verity-loadpin: Add NULL pointer check for 'bdev' parameter

Matthieu Baerts (7):
      selftests: mptcp: sockopt: use 'iptables-legacy' if available
      selftests: mptcp: connect: fail if nft supposed to work
      selftests: mptcp: sockopt: return error if wrong mark
      selftests: mptcp: userspace_pm: use correct server port
      selftests: mptcp: userspace_pm: report errors with 'remove' tests
      selftests: mptcp: depend on SYN_COOKIES
      selftests: mptcp: pm_nl_ctl: fix 32-bit support

Max Filippov (1):
      xtensa: ISS: fix call to split_if_spec

Michael Ellerman (2):
      powerpc/security: Fix Speculation_Store_Bypass reporting on Power10
      powerpc/64s: Fix native_hpte_remove() to be irq-safe

Mikulas Patocka (1):
      dm integrity: reduce vmalloc space footprint on 32-bit architectures

Ming Lei (1):
      nvme-pci: fix DMA direction of unmapping integrity data

Mohamed Khalfella (1):
      tracing/histograms: Add histograms to hist_vars if they have referenced variables

Moritz Fischer (1):
      net: lan743x: Don't sleep in atomic context

Muhammad Husaini Zulkifli (3):
      igc: Add condition for qbv_config_change_errors counter
      igc: Remove delay during TX ring configuration
      igc: Fix TX Hang issue when QBV Gate is closed

Namhyung Kim (1):
      perf/x86: Fix lockdep warning in for_each_sibling_event() on SPR

Namjae Jeon (2):
      ksmbd: add missing compound request handing in some commands
      ksmbd: fix out of bounds read in smb2_sess_setup

Naveen N Rao (1):
      powerpc: Fail build if using recordmcount with binutils v2.37

Nayna Jain (1):
      security/integrity: fix pointer to ESL data and its size on pseries

Niklas Schnelle (3):
      s390/ism: Fix locking for forwarding of IRQs and events to clients
      s390/ism: Fix and simplify add()/remove() callback handling
      s390/ism: Do not unregister clients with registered DMBs

Nilesh Javali (3):
      scsi: qla2xxx: Array index may go out of bound
      scsi: qla2xxx: Avoid fcport pointer dereference
      scsi: qla2xxx: Check valid rport returned by fc_bsg_to_rport()

Nitya Sunkad (1):
      ionic: remove WARN_ON to prevent panic_on_warn

Oleksij Rempel (1):
      net: phy: dp83td510: fix kernel stall during netboot in DP83TD510E PHY driver

Oliver Upton (1):
      arm64: errata: Mitigate Ampere1 erratum AC03_CPU_38 at stage-2

Ondrej Zary (1):
      PCI/PM: Avoid putting EloPOS E2/S2/H2 PCIe Ports in D3cold

Pablo Neira Ayuso (1):
      netfilter: nf_tables: report use refcount overflow

Paolo Abeni (3):
      net: prevent skb corruption on frag list segmentation
      mptcp: do not rely on implicit state check in mptcp_listen()
      mptcp: ensure subflow is unhashed before cleaning the backlog

Paulo Alcantara (2):
      smb: client: improve DFS mount check
      smb: client: fix parsing of source mount option

Pedro Tammela (3):
      net/sched: make psched_mtu() RTNL-less safe
      net/sched: sch_qfq: reintroduce lmax bound check for MTU
      net/sched: sch_qfq: account for stab overhead in qfq_enqueue

Peter Ujfalusi (1):
      tpm: tpm_tis: Disable interrupts *only* for AEON UPX-i11

Petr Pavlu (1):
      xen/virtio: Fix NULL deref when a bridge of PCI root bus has no parent

Petr Tesarik (2):
      swiotlb: always set the number of areas before allocating the pool
      swiotlb: reduce the number of areas to match actual memory pool size

Prasad Koya (1):
      igc: set TP bit in 'supported' and 'advertising' fields of ethtool_link_ksettings

Pu Lehui (1):
      bpf: cpumap: Fix memory leak in cpu_map_update_elem

Quinn Tran (7):
      scsi: qla2xxx: Multi-que support for TMF
      scsi: qla2xxx: Fix task management cmd failure
      scsi: qla2xxx: Fix task management cmd fail due to unavailable resource
      scsi: qla2xxx: Fix hang in task management
      scsi: qla2xxx: Wait for io return on terminate rport
      scsi: qla2xxx: Fix mem access after free
      scsi: qla2xxx: Fix buffer overrun

Rafał Miłecki (1):
      net: bgmac: postpone turning IRQs off to avoid SoC hangs

Randy Dunlap (2):
      scsi: ufs: ufs-mediatek: Add dependency for RESET_CONTROLLER
      wifi: airo: avoid uninitialized warning in airo_get_rate()

Ratheesh Kannoth (1):
      octeontx2-af: Promisc enable/disable through mbox

Rick Wertenbroek (5):
      PCI: rockchip: Assert PCI Configuration Enable bit after probe
      PCI: rockchip: Write PCI Device ID to correct register
      PCI: rockchip: Add poll and timeout to wait for PHY PLLs to be locked
      PCI: rockchip: Fix legacy IRQ generation for RK3399 PCIe endpoint core
      PCI: rockchip: Use u32 variable to access 32-bit registers

Ritesh Harjani (IBM) (1):
      ext2/dax: Fix ext2_setsize when len is page aligned

Robin Murphy (1):
      PCI: Add function 1 DMA alias quirk for Marvell 88SE9235

Ross Lagerwall (1):
      PCI: Release resource invalidated by coalescing

Saeed Mahameed (1):
      net/mlx5: Register a unique thermal zone per device

Sai Krishna (1):
      octeontx2-af: Move validation of ptp pointer before its usage

Sakari Ailus (1):
      media: uapi: Fix [GS]_ROUTING ACTIVE flag value

Samuel Pitoiset (1):
      drm/amdgpu: fix clearing mappings for BOs that are always valid in VM

Sathya Prakash (1):
      scsi: mpi3mr: Propagate sense data for admin queue SCSI I/O

Shreyas Deodhar (1):
      scsi: qla2xxx: Pointer may be dereferenced

Siddh Raman Pant (1):
      jfs: jfs_dmap: Validate db_l2nbperpage while mounting

Simon Horman (1):
      net: lan743x: select FIXED_PHY

Sinthu Raja (1):
      arm64: dts: ti: k3-j721s2: Fix wkup pinmux range

Sridhar Samudrala (2):
      ice: Fix max_rate check while configuring TX rate limits
      ice: Fix tx queue rate limit when TCs are configured

Stafford Horne (1):
      openrisc: Union fpcsr and oldmask in sigcontext to unbreak userspace ABI

Stanislav Lisovskiy (1):
      drm/i915: Don't preserve dpll_hw_state for slave crtc in Bigjoiner

Stephan Gerhold (1):
      opp: Fix use-after-free in lazy_opp_tables after probe deferral

Suman Ghosh (1):
      octeontx2-pf: Add additional check for MCAM rules

Sung-huai Wang (1):
      drm/amd/display: add a NULL pointer check

Tan Tee Min (1):
      igc: Include the length/type field and VLAN tag in queueMaxSDU

Theodore Ts'o (1):
      ext4: avoid updating the superblock on a r/o mount if not needed

Thomas Bogendoerfer (1):
      MIPS: kvm: Fix build error with KVM_MIPS_DEBUG_COP0_COUNTERS enabled

Thomas Hellström (2):
      drm/ttm: Don't leak a resource on eviction error
      drm/ttm: Don't leak a resource on swapout move error

Thomas Zimmermann (1):
      drm/client: Send hotplug event after registering a client

Tvrtko Ursulin (1):
      drm/i915: Fix one wrong caching mode enum usage

Tzvetomir Stoyanov (VMware) (1):
      kernel/trace: Fix cleanup logic of enable_trace_eprobe

Valentin David (1):
      tpm: Do not remap from ACPI resources again for Pluton TPM

Vlad Buslov (1):
      net/mlx5e: Check for NOT_READY flag state after locking

Vladimir Oltean (3):
      net: dsa: felix: make vsc9959_tas_guard_bands_update() visible to ocelot->ops
      net: mscc: ocelot: fix oversize frame dropping for preemptible TCs
      net/sched: taprio: replace tc_taprio_qopt_offload :: enable with a "cmd" enum

Wayne Lin (1):
      drm/dp_mst: Clear MSG_RDY flag before sending new message

Wei Fang (4):
      net: fec: remove useless fec_enet_reset_skb()
      net: fec: remove last_bdp from fec_enet_txq_xmit_frame()
      net: fec: recycle pages for transmitted XDP frames
      net: fec: increase the size of tx ring and update tx_wake_threshold

Weitao Wang (3):
      xhci: Fix resume issue of some ZHAOXIN hosts
      xhci: Fix TRB prefetch issue of ZHAOXIN hosts
      xhci: Show ZHAOXIN xHCI root hub speed correctly

Winston Wen (1):
      cifs: fix session state check in smb2_find_smb_ses

Xin Yin (1):
      erofs: fix fsdax unavailability for chunk-based regular files

Xiubo Li (3):
      ceph: add a dedicated private data for netfs rreq
      ceph: fix blindly expanding the readahead windows
      ceph: don't let check_caps skip sending responses for revoke msgs

Yang Wang (1):
      drm/amd/pm: fix smu i2c data read risk

Yang Yingliang (1):
      NTB: ntb_transport: fix possible memory leak while device_register() fails

Yevgeny Kliteynik (1):
      net/mlx5e: TC, CT: Offload ct clear only once

Yinjun Zhang (1):
      nfp: clean mc addresses in application firmware when closing port

Yuan Can (3):
      ntb: idt: Fix error handling in idt_pci_driver_init()
      NTB: amd: Fix error handling in amd_ntb_pci_driver_init()
      ntb: intel: Fix error handling in intel_ntb_pci_driver_init()

Ze Gao (1):
      fprobe: add unlock to match a succeeded ftrace_test_recursion_trylock

Zhang Shurong (1):
      wifi: rtw89: debug: fix error code in rtw89_debug_priv_send_h2c_set()

Zheng Yejian (3):
      tracing: Fix memory leak of iter->temp when reading trace_pipe
      ring-buffer: Fix deadloop issue on reading trace_pipe
      ftrace: Fix possible warning on checking all pages used in ftrace_process_locs()

Zhengchao Shao (3):
      net/mlx5e: fix double free in mlx5e_destroy_flow_table
      net/mlx5e: fix memory leak in mlx5e_fs_tt_redirect_any_create
      net/mlx5e: fix memory leak in mlx5e_ptp_open

Zhihao Cheng (1):
      ext4: Fix reusing stale buffer heads from last failed mounting

Ziyang Xuan (1):
      ipv6/addrconf: fix a potential refcount underflow for idev

gaba (1):
      drm/amdgpu: avoid restore process run into dead loop.

sunliming (1):
      tracing/user_events: Fix incorrect return value for writing operation when events are disabled

