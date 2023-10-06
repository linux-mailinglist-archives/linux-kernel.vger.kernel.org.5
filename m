Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC747BB857
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 14:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232292AbjJFM7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 08:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232283AbjJFM7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 08:59:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64EDCC6;
        Fri,  6 Oct 2023 05:59:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B729C433C9;
        Fri,  6 Oct 2023 12:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696597180;
        bh=c78r1uQV9oOvU61toeYXUUiP0IM9iPm0KI91BsTBeM4=;
        h=From:To:Cc:Subject:Date:From;
        b=BHZgm5mu+GMvQ1Ls0wes051+M3YxUIh5Yj1RfkmklZwsr7jj2ksoH3h34WkSnHSdu
         vfPL98EGJJ+K02jEISB7ILyxubwMbn+TEcT0k1vd39iPGCUMFrSFzxVrX+3Ni5KaBE
         oiny+mDiYofngrnJGumBnejGT8kRPINMAxNmf6QY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.56
Date:   Fri,  6 Oct 2023 14:59:34 +0200
Message-ID: <2023100635-pushchair-predator-9ae3@gregkh>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm announcing the release of the 6.1.56 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/admin-guide/cgroup-v1/memory.rst                    |    9 
 Makefile                                                          |    2 
 arch/arm/boot/dts/am335x-guardian.dts                             |    3 
 arch/arm/boot/dts/am3517-evm.dts                                  |    2 
 arch/arm/boot/dts/bcm4708-linksys-ea6500-v2.dts                   |    3 
 arch/arm/boot/dts/exynos4210-i9100.dts                            |    4 
 arch/arm/boot/dts/logicpd-torpedo-baseboard.dtsi                  |    2 
 arch/arm/boot/dts/motorola-mapphone-common.dtsi                   |   48 -
 arch/arm/boot/dts/omap-gpmc-smsc911x.dtsi                         |    6 
 arch/arm/boot/dts/omap-gpmc-smsc9221.dtsi                         |    6 
 arch/arm/boot/dts/omap3-cm-t3517.dts                              |   12 
 arch/arm/boot/dts/omap3-cpu-thermal.dtsi                          |    3 
 arch/arm/boot/dts/omap3-gta04.dtsi                                |    8 
 arch/arm/boot/dts/omap3-ldp.dts                                   |    2 
 arch/arm/boot/dts/omap3-n900.dts                                  |   40 -
 arch/arm/boot/dts/omap3-zoom3.dts                                 |   44 -
 arch/arm/boot/dts/omap4-cpu-thermal.dtsi                          |   29 
 arch/arm/boot/dts/omap4-duovero-parlor.dts                        |   12 
 arch/arm/boot/dts/omap4-duovero.dtsi                              |   18 
 arch/arm/boot/dts/omap4-kc1.dts                                   |   14 
 arch/arm/boot/dts/omap4-mcpdm.dtsi                                |    2 
 arch/arm/boot/dts/omap4-panda-common.dtsi                         |   30 
 arch/arm/boot/dts/omap4-panda-es.dts                              |    8 
 arch/arm/boot/dts/omap4-sdp.dts                                   |   36 
 arch/arm/boot/dts/omap4-var-om44customboard.dtsi                  |   24 
 arch/arm/boot/dts/omap4-var-som-om44-wlan.dtsi                    |    6 
 arch/arm/boot/dts/omap4-var-som-om44.dtsi                         |   22 
 arch/arm/boot/dts/omap443x.dtsi                                   |    1 
 arch/arm/boot/dts/omap4460.dtsi                                   |    1 
 arch/arm/boot/dts/omap5-cm-t54.dts                                |   64 -
 arch/arm/boot/dts/qcom-msm8974pro-sony-xperia-shinano-castor.dts  |    8 
 arch/arm/boot/dts/twl6030_omap4.dtsi                              |    4 
 arch/arm64/boot/dts/freescale/Makefile                            |    1 
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts                        |    9 
 arch/arm64/configs/defconfig                                      |    1 
 arch/loongarch/include/asm/elf.h                                  |    9 
 arch/loongarch/kernel/mem.c                                       |    4 
 arch/loongarch/kernel/module.c                                    |    2 
 arch/loongarch/kernel/numa.c                                      |    2 
 arch/mips/alchemy/devboards/db1000.c                              |    4 
 arch/mips/alchemy/devboards/db1200.c                              |    6 
 arch/mips/alchemy/devboards/db1300.c                              |    4 
 arch/parisc/include/asm/ropes.h                                   |    3 
 arch/parisc/kernel/drivers.c                                      |    2 
 arch/parisc/kernel/irq.c                                          |    2 
 arch/powerpc/kernel/hw_breakpoint.c                               |   16 
 arch/powerpc/kernel/hw_breakpoint_constraints.c                   |    7 
 arch/powerpc/perf/hv-24x7.c                                       |    2 
 arch/riscv/include/asm/errata_list.h                              |    4 
 arch/x86/include/asm/kexec.h                                      |    2 
 arch/x86/include/asm/reboot.h                                     |    2 
 arch/x86/kernel/cpu/bugs.c                                        |    4 
 arch/x86/kernel/cpu/common.c                                      |    2 
 arch/x86/kernel/cpu/sgx/encl.c                                    |   30 
 arch/x86/kernel/crash.c                                           |   31 
 arch/x86/kernel/reboot.c                                          |   22 
 arch/x86/kernel/setup.c                                           |    8 
 arch/x86/kvm/mmu/mmu.c                                            |    8 
 arch/x86/kvm/mmu/tdp_mmu.c                                        |   31 
 arch/x86/kvm/mmu/tdp_mmu.h                                        |    3 
 arch/x86/kvm/svm/sev.c                                            |   34 
 arch/x86/kvm/svm/svm.c                                            |    9 
 arch/x86/kvm/svm/svm.h                                            |    1 
 arch/x86/kvm/vmx/vmx.c                                            |   10 
 arch/xtensa/boot/Makefile                                         |    3 
 arch/xtensa/boot/lib/zmem.c                                       |    5 
 arch/xtensa/include/asm/core.h                                    |    4 
 arch/xtensa/lib/umulsidi3.S                                       |    4 
 arch/xtensa/platforms/iss/network.c                               |    4 
 drivers/ata/libata-core.c                                         |   41 -
 drivers/ata/libata-eh.c                                           |   13 
 drivers/ata/libata-scsi.c                                         |   47 +
 drivers/ata/libata-transport.c                                    |    9 
 drivers/ata/libata.h                                              |    2 
 drivers/ata/sata_mv.c                                             |    4 
 drivers/bus/ti-sysc.c                                             |   31 
 drivers/char/agp/parisc-agp.c                                     |    2 
 drivers/clk/sprd/ums512-clk.c                                     |    2 
 drivers/clk/tegra/clk-bpmp.c                                      |    2 
 drivers/firmware/arm_ffa/driver.c                                 |   16 
 drivers/firmware/arm_scmi/perf.c                                  |   93 +-
 drivers/firmware/cirrus/cs_dsp.c                                  |   34 
 drivers/firmware/imx/imx-dsp.c                                    |    1 
 drivers/gpio/gpio-pmic-eic-sprd.c                                 |    1 
 drivers/gpio/gpio-tb10x.c                                         |    6 
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c                           |   17 
 drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c                            |    3 
 drivers/gpu/drm/amd/amdgpu/soc21.c                                |    2 
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c             |    2 
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h                             |    5 
 drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c       |    4 
 drivers/gpu/drm/bridge/ti-sn65dsi83.c                             |    4 
 drivers/gpu/drm/i915/gt/intel_engine_cs.c                         |    1 
 drivers/gpu/drm/i915/gt/intel_execlists_submission.c              |    2 
 drivers/gpu/drm/i915/gt/intel_ggtt.c                              |   23 
 drivers/gpu/drm/meson/meson_encoder_hdmi.c                        |    2 
 drivers/gpu/drm/tests/drm_mm_test.c                               |    2 
 drivers/i2c/busses/i2c-i801.c                                     |    1 
 drivers/i2c/busses/i2c-npcm7xx.c                                  |   17 
 drivers/i2c/busses/i2c-xiic.c                                     |    2 
 drivers/i2c/muxes/i2c-demux-pinctrl.c                             |    4 
 drivers/i2c/muxes/i2c-mux-gpio.c                                  |    4 
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c                   |   27 
 drivers/md/dm-core.h                                              |    1 
 drivers/md/dm-ioctl.c                                             |    7 
 drivers/md/dm-table.c                                             |   32 
 drivers/media/common/videobuf2/frame_vector.c                     |    6 
 drivers/media/platform/marvell/Kconfig                            |    4 
 drivers/media/platform/via/Kconfig                                |    2 
 drivers/media/usb/em28xx/Kconfig                                  |    4 
 drivers/media/usb/go7007/Kconfig                                  |    2 
 drivers/media/usb/uvc/uvc_ctrl.c                                  |    3 
 drivers/misc/cardreader/rts5227.c                                 |   55 -
 drivers/misc/cardreader/rts5228.c                                 |   57 -
 drivers/misc/cardreader/rts5249.c                                 |   56 -
 drivers/misc/cardreader/rts5260.c                                 |   43 -
 drivers/misc/cardreader/rts5261.c                                 |   52 -
 drivers/misc/cardreader/rtsx_pcr.c                                |   51 +
 drivers/net/ethernet/amazon/ena/ena_netdev.c                      |    3 
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                         |    5 
 drivers/net/ethernet/engleder/tsnep_main.c                        |   18 
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c                   |    9 
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c           |   13 
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c         |    3 
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c                |    8 
 drivers/net/ethernet/intel/iavf/iavf.h                            |    2 
 drivers/net/ethernet/intel/iavf/iavf_ethtool.c                    |    2 
 drivers/net/ethernet/intel/iavf/iavf_main.c                       |   17 
 drivers/net/ethernet/intel/igc/igc_ethtool.c                      |   31 
 drivers/net/ethernet/intel/igc/igc_main.c                         |    2 
 drivers/net/ethernet/marvell/octeon_ep/octep_main.c               |    8 
 drivers/net/ethernet/marvell/octeon_ep/octep_tx.c                 |    8 
 drivers/net/ethernet/marvell/octeon_ep/octep_tx.h                 |   16 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c            |   19 
 drivers/net/ethernet/pensando/ionic/ionic_dev.h                   |    1 
 drivers/net/ethernet/pensando/ionic/ionic_txrx.c                  |   10 
 drivers/net/team/team.c                                           |   10 
 drivers/net/thunderbolt.c                                         |    3 
 drivers/net/wireless/ath/ath11k/dp.h                              |    4 
 drivers/net/wireless/ath/ath11k/dp_tx.c                           |   39 
 drivers/net/wireless/ath/ath11k/dp_tx.h                           |    1 
 drivers/nvme/host/fc.c                                            |    2 
 drivers/nvme/host/pci.c                                           |  121 +--
 drivers/parisc/iosapic.c                                          |    4 
 drivers/parisc/iosapic_private.h                                  |    4 
 drivers/platform/mellanox/Kconfig                                 |    1 
 drivers/platform/x86/asus-nb-wmi.c                                |    9 
 drivers/platform/x86/intel_scu_ipc.c                              |   66 +
 drivers/power/supply/ab8500_btemp.c                               |    9 
 drivers/power/supply/ab8500_chargalg.c                            |    2 
 drivers/power/supply/mt6370-charger.c                             |    2 
 drivers/power/supply/rk817_charger.c                              |   16 
 drivers/power/supply/ucs1002_power.c                              |    3 
 drivers/s390/crypto/pkey_api.c                                    |   16 
 drivers/s390/crypto/zcrypt_ep11misc.c                             |   61 +
 drivers/s390/crypto/zcrypt_ep11misc.h                             |    3 
 drivers/scsi/iscsi_tcp.c                                          |    4 
 drivers/scsi/pm8001/pm8001_hwi.c                                  |    2 
 drivers/scsi/pm8001/pm80xx_hwi.c                                  |    4 
 drivers/scsi/qedf/qedf_io.c                                       |   10 
 drivers/scsi/qedf/qedf_main.c                                     |    7 
 drivers/scsi/qla2xxx/qla_def.h                                    |    3 
 drivers/scsi/qla2xxx/qla_init.c                                   |    5 
 drivers/scsi/qla2xxx/qla_inline.h                                 |   58 +
 drivers/scsi/qla2xxx/qla_isr.c                                    |   12 
 drivers/scsi/qla2xxx/qla_nvme.c                                   |    4 
 drivers/scsi/qla2xxx/qla_os.c                                     |    6 
 drivers/scsi/qla2xxx/qla_target.c                                 |    3 
 drivers/scsi/qla2xxx/tcm_qla2xxx.c                                |    4 
 drivers/soc/imx/soc-imx8m.c                                       |   10 
 drivers/spi/spi-gxp.c                                             |    2 
 drivers/spi/spi-intel-pci.c                                       |    1 
 drivers/spi/spi-nxp-fspi.c                                        |    7 
 drivers/spi/spi-stm32.c                                           |    8 
 drivers/spi/spi-sun6i.c                                           |   31 
 drivers/thermal/thermal_of.c                                      |    8 
 drivers/tty/n_gsm.c                                               |    4 
 drivers/tty/serial/8250/8250_port.c                               |    5 
 drivers/ufs/core/ufshcd.c                                         |   13 
 drivers/vfio/mdev/mdev_sysfs.c                                    |    3 
 drivers/video/fbdev/Kconfig                                       |    2 
 fs/binfmt_elf_fdpic.c                                             |    5 
 fs/btrfs/delayed-inode.c                                          |   85 +-
 fs/btrfs/extent_io.c                                              |    8 
 fs/btrfs/super.c                                                  |    2 
 fs/ceph/caps.c                                                    |    6 
 fs/ceph/mds_client.c                                              |   12 
 fs/ceph/mds_client.h                                              |   11 
 fs/ceph/quota.c                                                   |   14 
 fs/ceph/snap.c                                                    |   10 
 fs/ceph/super.c                                                   |   75 +
 fs/ceph/super.h                                                   |    3 
 fs/ext4/mballoc.c                                                 |   60 -
 fs/f2fs/data.c                                                    |   25 
 fs/f2fs/dir.c                                                     |   34 
 fs/f2fs/f2fs.h                                                    |    5 
 fs/f2fs/gc.c                                                      |    4 
 fs/netfs/buffered_read.c                                          |    6 
 fs/nfs/direct.c                                                   |  134 ++-
 fs/nfs/flexfilelayout/flexfilelayout.c                            |    1 
 fs/nfs/nfs4client.c                                               |    9 
 fs/nfs/nfs4proc.c                                                 |   10 
 fs/nfs/write.c                                                    |   23 
 fs/nilfs2/gcinode.c                                               |    6 
 fs/proc/internal.h                                                |    2 
 fs/proc/task_nommu.c                                              |   64 -
 fs/smb/client/cifsglob.h                                          |    1 
 fs/smb/client/fs_context.c                                        |    1 
 fs/smb/client/inode.c                                             |    2 
 fs/smb/client/smb2ops.c                                           |    6 
 fs/smb/client/transport.c                                         |   34 
 include/linux/bpf.h                                               |    2 
 include/linux/btf_ids.h                                           |    2 
 include/linux/if_team.h                                           |    2 
 include/linux/interrupt.h                                         |    6 
 include/linux/libata.h                                            |    4 
 include/linux/memcontrol.h                                        |    4 
 include/linux/nfs_fs_sb.h                                         |    1 
 include/linux/nfs_page.h                                          |    4 
 include/linux/resume_user_mode.h                                  |    2 
 include/linux/seqlock.h                                           |    2 
 include/net/netfilter/nf_tables.h                                 |  127 +--
 include/uapi/linux/bpf.h                                          |    4 
 io_uring/fs.c                                                     |    2 
 kernel/bpf/queue_stack_maps.c                                     |   21 
 kernel/dma/debug.c                                                |   20 
 kernel/sched/core.c                                               |    2 
 kernel/sched/cpupri.c                                             |    1 
 kernel/sched/idle.c                                               |    1 
 kernel/trace/bpf_trace.c                                          |   16 
 kernel/trace/ring_buffer.c                                        |   10 
 mm/damon/vaddr-test.h                                             |    2 
 mm/memcontrol.c                                                   |   13 
 mm/slab_common.c                                                  |   12 
 net/bridge/br_forward.c                                           |    4 
 net/bridge/br_input.c                                             |    4 
 net/core/flow_dissector.c                                         |    2 
 net/dccp/ipv4.c                                                   |    9 
 net/dccp/ipv6.c                                                   |    9 
 net/hsr/hsr_framereg.c                                            |    4 
 net/hsr/hsr_main.h                                                |    2 
 net/ipv4/route.c                                                  |    4 
 net/mptcp/options.c                                               |    5 
 net/ncsi/ncsi-aen.c                                               |    5 
 net/netfilter/ipset/ip_set_core.c                                 |   12 
 net/netfilter/nf_conntrack_bpf.c                                  |    2 
 net/netfilter/nf_conntrack_extend.c                               |    4 
 net/netfilter/nf_tables_api.c                                     |  400 ++++++++--
 net/netfilter/nft_set_hash.c                                      |   87 +-
 net/netfilter/nft_set_pipapo.c                                    |   69 +
 net/netfilter/nft_set_rbtree.c                                    |  161 ++--
 net/rds/rdma_transport.c                                          |   12 
 net/smc/smc_stats.h                                               |    3 
 net/sunrpc/clnt.c                                                 |   15 
 security/smack/smack.h                                            |    1 
 security/smack/smack_lsm.c                                        |   63 +
 sound/hda/intel-sdw-acpi.c                                        |    8 
 sound/pci/hda/hda_intel.c                                         |    1 
 sound/pci/hda/patch_realtek.c                                     |    3 
 sound/soc/amd/yc/acp6x-mach.c                                     |   21 
 sound/soc/codecs/cs42l42.c                                        |   10 
 sound/soc/codecs/rt5640.c                                         |   13 
 sound/soc/fsl/imx-audmix.c                                        |    2 
 sound/soc/fsl/imx-pcm-rpmsg.c                                     |    1 
 sound/soc/fsl/imx-rpmsg.c                                         |    8 
 sound/soc/intel/avs/boards/hdaudio.c                              |    3 
 sound/soc/meson/axg-spdifin.c                                     |   49 -
 sound/soc/sof/core.c                                              |    3 
 sound/soc/sof/intel/mtl.c                                         |    2 
 sound/soc/sof/intel/mtl.h                                         |    1 
 tools/include/linux/btf_ids.h                                     |    2 
 tools/include/linux/mm.h                                          |    2 
 tools/include/linux/seq_file.h                                    |    2 
 tools/include/uapi/linux/bpf.h                                    |    4 
 tools/perf/util/Build                                             |    6 
 tools/testing/memblock/tests/basic_api.c                          |    2 
 tools/testing/memblock/tests/common.h                             |    1 
 tools/testing/selftests/ftrace/test.d/instances/instance-event.tc |    2 
 tools/testing/selftests/kselftest_deps.sh                         |   77 +
 tools/testing/selftests/net/tls.c                                 |    8 
 tools/testing/selftests/powerpc/Makefile                          |   15 
 tools/testing/selftests/powerpc/pmu/Makefile                      |   40 -
 282 files changed, 2842 insertions(+), 1575 deletions(-)

Adam Ford (1):
      bus: ti-sysc: Fix missing AM35xx SoC matching

Aleksey Nasibulin (1):
      ARM: dts: BCM5301X: Extend RAM to full 256MB for Linksys EA6500 V2

Alex Deucher (2):
      drm/amdgpu/soc21: don't remap HDP registers for SR-IOV
      drm/amdgpu/nbio4.3: set proper rmmio_remap.reg_offset for SR-IOV

Amit Pundir (1):
      arm64: dts: qcom: sdm845-db845c: Mark cont splash memory region as reserved

Andy Shevchenko (1):
      serial: 8250_port: Check IRQ data before use

Arnaldo Carvalho de Melo (1):
      perf build: Define YYNOMEM as YYNOABORT for bison < 3.81

Artem Chernyshev (1):
      net: rds: Fix possible NULL-pointer dereference

August Wikerfors (1):
      ASoC: amd: yc: Fix non-functional mic on Lenovo 82QF and 82UG

Ben Wolsieffer (2):
      proc: nommu: /proc/<pid>/maps: release mmap read lock
      proc: nommu: fix empty /proc/<pid>/maps

Benjamin Gray (5):
      selftests/powerpc: Use CLEAN macro to fix make warning
      selftests/powerpc: Pass make context to children
      powerpc/watchpoints: Disable preemption in thread_change_pc()
      powerpc/watchpoint: Disable pagefaults when getting user instruction
      powerpc/watchpoints: Annotate atomic context in more places

Chancel Liu (1):
      ASoC: imx-rpmsg: Set ignore_pmdown_time for dai_link

Chao Yu (1):
      f2fs: optimize iteration over sparse directories

Charles Kearney (1):
      spi: spi-gxp: BUG: Correct spi write return value

Chen Ni (1):
      ASoC: hdaudio.c: Add missing check for devm_kstrdup

Chris Morgan (1):
      power: supply: rk817: Fix node refcount leak

Christoph Hellwig (3):
      MIPS: Alchemy: only build mmc support helpers if au1xmmc is enabled
      nvme-pci: factor the iod mempool creation into a helper
      nvme-pci: factor out a nvme_pci_alloc_dev helper

Christophe JAILLET (3):
      gpio: tb10x: Fix an error handling path in tb10x_gpio_probe()
      firmware: imx-dsp: Fix an error handling path in imx_dsp_setup_channels()
      ata: sata_mv: Fix incorrect string length computation in mv_dump_mem()

Cristian Marussi (1):
      firmware: arm_scmi: Harden perf domain info access

Damien Le Moal (4):
      ata: libata-scsi: link ata port and scsi device
      ata: libata-core: Fix ata_port_request_pm() locking
      ata: libata-core: Fix port and device removal
      ata: libata-core: Do not register PM operations for SAS ports

Dan Carpenter (1):
      power: supply: ucs1002: fix error code in ucs1002_get_property()

Daniel Borkmann (1):
      bpf: Annotate bpf_long_memcpy with data_race

Daniel Scally (1):
      i2c: xiic: Correct return value check for xiic_reinit()

Daniel Starke (1):
      Revert "tty: n_gsm: fix UAF in gsm_cleanup_mux"

Dave Wysochanski (1):
      netfs: Only call folio_start_fscache() one time for each folio

David Christensen (1):
      ionic: fix 16bit math issue when PAGE_SIZE >= 64KB

David Francis (1):
      drm/amdgpu: Handle null atom context in VBIOS info ioctl

David Thompson (1):
      platform/mellanox: mlxbf-bootctl: add NET dependency into Kconfig

Eric Dumazet (3):
      scsi: iscsi_tcp: restrict to TCP sockets
      dccp: fix dccp_v4_err()/dccp_v6_err() again
      net: bridge: use DEV_STATS_INC()

Filipe Manana (3):
      btrfs: improve error message after failure to add delayed dir index item
      btrfs: remove BUG() after failure to insert delayed dir index item
      btrfs: assert delayed node locked when removing delayed item

Florian Westphal (7):
      netfilter: nf_tables: don't skip expired elements during walk
      netfilter: nf_tables: don't fail inserts if duplicate has expired
      netfilter: nf_tables: defer gc run if previous batch is still pending
      netfilter: nf_tables: fix memleak when more than 255 elements expired
      netfilter: conntrack: fix extension size table
      netfilter: nf_tables: disable toggling dormant table state more than once
      netfilter: nf_tables: fix kdoc warnings after gc rework

Frederic Weisbecker (1):
      timers: Tag (hr)timer softirq as hotplug safe

Gerhard Engleder (2):
      tsnep: Fix NAPI scheduling
      tsnep: Fix NAPI polling with budget 0

Gleb Chesnokov (1):
      scsi: qla2xxx: Fix NULL pointer dereference in target mode

Greg Kroah-Hartman (1):
      Linux 6.1.56

Greg Ungerer (1):
      fs: binfmt_elf_efpic: fix personality for ELF-FDPIC

Guangguan Wang (1):
      net/smc: bugfix for smcr v2 server connect success statistic

Haitao Huang (1):
      x86/sgx: Resolves SECS reclaim vs. page fault for EAUG race

Han Xu (1):
      spi: nxp-fspi: reset the FLSHxCR1 registers

Hans Verkuil (1):
      media: vb2: frame_vector.c: replace WARN_ONCE with a comment

Hans de Goede (2):
      ASoC: rt5640: Revert "Fix sleep in atomic context"
      ASoC: rt5640: Fix IRQ not being free-ed for HDA jack detect mode

Harish Kasiviswanathan (1):
      drm/amdkfd: Insert missing TLB flush on GFX10 and later

Harshit Mogalapalli (1):
      power: supply: mt6370: Fix missing error code in mt6370_chg_toggle_cfo()

Heiner Kallweit (1):
      i2c: i801: unregister tco_pdev in i801_probe() error path

Helge Deller (4):
      parisc: sba: Fix compile warning wrt list of SBA devices
      parisc: iosapic.c: Fix sparse warnings
      parisc: drivers: Fix sparse warning
      parisc: irq: Make irq_stack_union static to avoid sparse warning

Holger Dengler (1):
      s390/pkey: fix PKEY_TYPE_EP11_AES handling in PKEY_CLR2SECK2 IOCTL

Huacai Chen (2):
      LoongArch: Set all reserved memblocks on Node#0 at initialization
      LoongArch: numa: Fix high_memory calculation

Icenowy Zheng (1):
      riscv: errata: fix T-Head dcache.cva encoding

Ilya Leoshkevich (1):
      netfilter, bpf: Adjust timeouts of non-confirmed CTs in bpf_ct_insert_entry()

Irvin Cote (1):
      nvme-pci: always return an ERR_PTR from nvme_pci_alloc_dev

Ivan Vecera (1):
      i40e: Fix VF VLAN offloading when port VLAN is configured

Jaegeuk Kim (1):
      f2fs: get out of a repeat loop when getting a locked data page

Jan Kara (2):
      ext4: move setting of trimmed bit into ext4_try_to_trim_range()
      ext4: do not let fstrim block system suspend

Jani Nikula (1):
      drm/meson: fix memory leak on ->hpd_notify callback

Janusz Krzysztofik (1):
      drm/tests: Fix incorrect argument in drm_test_mm_insert_range

Javed Hasan (1):
      scsi: qedf: Add synchronization between I/O completions and abort

Javier Pello (1):
      drm/i915/gt: Fix reservation address in ggtt_reserve_guc_top

Jens Axboe (1):
      io_uring/fs: remove sqe->rw_flags checking from LINKAT

Jerome Brunet (1):
      ASoC: meson: spdifin: start hw on dai probe

Jian Shen (1):
      net: hns3: only enable unicast promisc when mac table full

Jie Wang (3):
      net: hns3: add cmdq check for vf periodic service task
      net: hns3: fix GRE checksum offload issue
      net: hns3: add 5ms delay before clear firmware reset irq source

Jijie Shao (1):
      net: hns3: fix fail to delete tc flower rules during reset issue

Jinjie Ruan (2):
      vfio/mdev: Fix a null-ptr-deref bug for mdev_unregister_parent()
      mm/damon/vaddr-test: fix memory leak in damon_do_test_apply_three_regions()

Jiri Olsa (2):
      bpf: Add override check to kprobe multi link attach
      bpf: Fix BTF_ID symbol generation collision

Joel Fernandes (Google) (1):
      sched/rt: Fix live lock between select_fallback_rq() and RT push

Johannes Weiner (1):
      mm: memcontrol: fix GFP_NOFS recursion in memory.high enforcement

Johnathan Mantey (1):
      ncsi: Propagate carrier gain/loss events to the NCSI controller

Josef Bacik (1):
      btrfs: properly report 0 avail for very full file systems

Josh Poimboeuf (2):
      x86/srso: Fix srso_show_state() side effect
      x86/srso: Fix SBPB enablement for spec_rstack_overflow=off

Jozsef Kadlecsik (1):
      netfilter: ipset: Fix race between IPSET_CMD_CREATE and IPSET_CMD_SWAP

Julia Lawall (1):
      thermal/of: add missing of_node_put()

Julien Panis (1):
      bus: ti-sysc: Use fsleep() instead of usleep_range() in sysc_reset()

Kailang Yang (1):
      ALSA: hda: Disable power save for solving pop issue on Lenovo ThinkCentre M70q

Kajol Jain (1):
      powerpc/perf/hv-24x7: Update domain value check

Kemeng Shi (1):
      ext4: replace the traditional ternary conditional operator with with max()/min()

Kiwoong Kim (2):
      scsi: ufs: core: Move __ufshcd_send_uic_cmd() outside host_lock
      scsi: ufs: core: Poll HCS.UCRDY before issuing a UIC command

Knyazev Arseniy (1):
      ALSA: hda/realtek: Splitting the UX3402 into two separate models

Krzysztof Kozlowski (4):
      ARM: dts: qcom: msm8974pro-castor: correct inverted X of touchscreen
      ARM: dts: qcom: msm8974pro-castor: correct touchscreen function names
      ARM: dts: qcom: msm8974pro-castor: correct touchscreen syna,nosleep-mode
      ARM: dts: omap: correct indentation

Kyle Zeng (1):
      ipv4: fix null-deref in ipv4_link_failure

Liam R. Howlett (1):
      kernel/sched: Modify initial boot task idle setup

Liang He (1):
      i2c: mux: gpio: Add missing fwnode_handle_put()

Linus Walleij (1):
      power: supply: ab8500: Set typing and props

Lukasz Majewski (1):
      net: hsr: Properly parse HSRv1 supervisor frames.

Luke D. Jones (1):
      platform/x86: asus-wmi: Support 2023 ROG X16 tablet mode

Marek Vasut (1):
      drm/bridge: ti-sn65dsi83: Do not generate HFP/HBP/HSA and EOT packet

Mario Limonciello (1):
      ASoC: amd: yc: Fix a non-functional mic on Lenovo 82TL

Matthias Schiffer (1):
      ata: libata-sata: increase PMP SRST timeout to 10s

Max Filippov (2):
      xtensa: add default definition for XCHAL_HAVE_DIV32
      xtensa: boot/lib: fix function prototypes

Michael Ellerman (1):
      selftests/powerpc: Fix emit_tests to work with run_kselftest.sh

Michal Grzedzicki (2):
      scsi: pm80xx: Use phy-specific SAS address when sending PHY_START command
      scsi: pm80xx: Avoid leaking tags when processing OPC_INB_SET_CONTROLLER_CONFIG command

Michal Hocko (2):
      memcg: drop kmem.limit_in_bytes
      mm, memcg: reconsider kmem.limit_in_bytes deprecation

Mika Westerberg (2):
      spi: intel-pci: Add support for Granite Rapids SPI serial flash
      net: thunderbolt: Fix TCPv6 GSO checksum calculation

Mike Rapoport (IBM) (2):
      memblock tests: fix warning: "__ALIGN_KERNEL" redefined
      memblock tests: fix warning ‘struct seq_file’ declared inside parameter list

Mikko Rapeli (1):
      arm64: defconfig: remove CONFIG_COMMON_CLK_NPCM8XX=y

Mikulas Patocka (1):
      dm: fix a race condition in retrieve_deps

Muhammad Husaini Zulkifli (1):
      igc: Expose tx-usecs coalesce setting to user

Nathan Rossi (1):
      soc: imx8m: Enable OCOTP clock for imx8mm before reading registers

Nick Desaulniers (1):
      bpf: Fix BTF_ID symbol generation collision in tools/

Nicolas Frattaroli (1):
      power: supply: rk817: Add missing module alias

Nicolin Chen (1):
      iommu/arm-smmu-v3: Fix soft lockup triggered by arm_smmu_mm_invalidate_range

Nigel Kirkland (1):
      nvme-fc: Prevent null pointer dereference in nvme_fc_io_getuuid()

Niklas Cassel (2):
      ata: libata-eh: do not clear ATA_PFLAG_EH_PENDING in ata_eh_reset()
      ata: libata-scsi: ignore reserved bits for REPORT SUPPORTED OPERATION CODES

Nilesh Javali (1):
      scsi: qla2xxx: Use raw_smp_processor_id() instead of smp_processor_id()

Olga Kornievskaia (3):
      NFSv4.1: use EXCHGID4_FLAG_USE_PNFS_DS for DS server
      NFSv4.1: fix pnfs MDS=DS session trunking
      NFSv4.1: fix zero value filehandle in post open getattr

Pablo Neira Ayuso (15):
      netfilter: nf_tables: GC transaction API to avoid race with control plane
      netfilter: nf_tables: adapt set backend to use GC transaction API
      netfilter: nft_set_hash: mark set element as dead when deleting from packet path
      netfilter: nf_tables: remove busy mark and gc batch API
      netfilter: nf_tables: fix GC transaction races with netns and netlink event exit path
      netfilter: nf_tables: GC transaction race with netns dismantle
      netfilter: nf_tables: GC transaction race with abort path
      netfilter: nf_tables: use correct lock to protect gc_list
      netfilter: nft_set_rbtree: skip sync GC for new elements in this transaction
      netfilter: nft_set_rbtree: use read spinlock to avoid datapath contention
      netfilter: nft_set_pipapo: call nft_trans_gc_queue_sync() in catchall GC
      netfilter: nft_set_pipapo: stop GC iteration if GC transaction allocation fails
      netfilter: nft_set_hash: try later when GC hits EAGAIN on iteration
      netfilter: nf_tables: disallow element removal on anonymous sets
      netfilter: nf_tables: disallow rule removal from chain binding

Pan Bian (1):
      nilfs2: fix potential use after free in nilfs_gccache_submit_read_data()

Paolo Abeni (1):
      mptcp: fix bogus receive window shrinkage with multiple subflows

Paolo Bonzini (2):
      KVM: SVM: INTERCEPT_RDTSCP is never intercepted anyway
      KVM: x86/mmu: Do not filter address spaces in for_each_tdp_mmu_root_yield_safe()

Paul Cercueil (1):
      ARM: dts: samsung: exynos4210-i9100: Fix LCD screen's physical size

Peter Ujfalusi (2):
      ASoC: SOF: core: Only call sof_ops_free() on remove if the probe was successful
      ALSA: hda: intel-sdw-acpi: Use u8 type for link index

Petr Oros (2):
      iavf: add iavf_schedule_aq_request() helper
      iavf: schedule a request immediately after add/delete vlan

Philip Yang (1):
      drm/amdkfd: Flush TLB after unmapping for GFX v9.4.3

Pradeep Kumar Chitrapu (1):
      wifi: ath11k: fix tx status reporting in encap offload mode

Pratyush Yadav (1):
      nvme-pci: do not set the NUMA node of device if it has none

Pu Wen (1):
      x86/srso: Add SRSO mitigation for Hygon processors

Qu Wenruo (1):
      btrfs: reset destination buffer when read_extent_buffer() gets invalid range

Quang Le (1):
      fs/smb/client: Reset password pointer to NULL

Radoslaw Tyl (1):
      iavf: do not process adminq tasks when __IAVF_IN_REMOVE_TASK is set

Rafael Aquini (1):
      mm/slab_common: fix slab_caches list corruption after kmem_cache_destroy()

Randy Dunlap (3):
      xtensa: iss/network: make functions static
      xtensa: boot: don't add include-dirs
      xtensa: umulsidi3: fix conditional expression

Ranjani Sridharan (1):
      ASoC: SOF: Intel: MTL: Reduce the DSP init timeout

Ricardo B. Marliere (1):
      selftests: fix dependency checker script

Ricardo Ribalda (1):
      media: uvcvideo: Fix OOB read

Richard Fitzgerald (3):
      ASoC: cs42l42: Ensure a reset pulse meets minimum pulse width.
      ASoC: cs42l42: Don't rely on GPIOD_OUT_LOW to set RESET initially low
      firmware: cirrus: cs_dsp: Only log list of algorithms in debug build

Ricky WU (1):
      misc: rtsx: Fix some platforms can not boot and move the l1ss judgment to probe

Rik van Riel (1):
      x86/mm, kexec, ima: Use memblock_free_late() from ima_free_kexec_buffer()

Rob Herring (1):
      arm64: dts: imx: Add imx8mm-prt8mm.dtb to build

Roberto Sassu (2):
      smack: Record transmuting in smk_transmuted
      smack: Retrieve transmuting information in smack_inode_getsecurity()

Sabrina Dubroca (1):
      selftests: tls: swap the TX and RX sockets in some tests

Sakari Ailus (2):
      media: v4l: Use correct dependency for camera sensor drivers
      media: via: Use correct dependency for camera sensor drivers

Sasha Neftin (1):
      net/core: Fix ETH_P_1588 flow dissector

Sean Christopherson (2):
      x86/reboot: VMCLEAR active VMCSes before emergency reboot
      KVM: x86/mmu: Open code leaf invalidation from mmu_notifier

Sebastian Andrzej Siewior (5):
      locking/seqlock: Do the lockdep annotation before locking in do_write_seqcount_begin_nested()
      net: ena: Flush XDP packets on error.
      bnxt_en: Flush XDP for bnxt_poll_nitroa0()'s NAPI
      octeontx2-pf: Do xdp_do_flush() after redirects.
      net: hsr: Add __packed to struct hsr_sup_tlv.

Sergey Senozhatsky (1):
      dma-debug: don't call __dma_entry_alloc_check_leak() under free_entries_lock

Shengjiu Wang (2):
      ASoC: imx-audmix: Fix return error with devm_clk_get()
      ASoC: fsl: imx-pcm-rpmsg: Add SNDRV_PCM_INFO_BATCH flag

Shinas Rasheed (1):
      octeon_ep: fix tx dma unmap len values in SG

Shreyas Deodhar (1):
      scsi: qla2xxx: Select qpair depending on which CPU post_cmd() gets called

Sibi Sankar (1):
      firmware: arm_scmi: Fixup perf power-cost/microwatt support

Stanislav Fomichev (1):
      bpf: Clarify error expectations from bpf_clone_redirect

Stephen Boyd (4):
      platform/x86: intel_scu_ipc: Check status after timeout in busy_loop()
      platform/x86: intel_scu_ipc: Check status upon timeout in ipc_wait_for_interrupt()
      platform/x86: intel_scu_ipc: Don't override scu in intel_scu_ipc_dev_simple_command()
      platform/x86: intel_scu_ipc: Fail IPC send if still busy

Steve French (1):
      smb3: correct places where ENOTSUPP is used instead of preferred EOPNOTSUPP

Steven Rostedt (Google) (2):
      ring-buffer: Do not attempt to read past "commit"
      ring-buffer: Update "shortest_full" in polling

Sudeep Holla (1):
      firmware: arm_ffa: Don't set the memory region attributes for MEM_LEND

Sven Eckelmann (2):
      wifi: ath11k: Cleanup mac80211 references on failure during tx_complete
      wifi: ath11k: Don't drop tx_status when peer cannot be found

Swapnil Patel (1):
      drm/amd/display: Don't check registers, if using AUX BL control

Thomas Zimmermann (1):
      fbdev/sh7760fb: Depend on FB=y

Tiezhu Yang (1):
      LoongArch: Define relocation types for ABI v2.10

Timo Alho (1):
      clk: tegra: fix error return case for recalc_rate

Tobias Schramm (2):
      spi: sun6i: reduce DMA RX transfer width to single byte
      spi: sun6i: fix race between DMA RX transfer completion and RX FIFO drain

Toke Høiland-Jørgensen (1):
      bpf: Avoid deadlock when using queue and stack maps from NMI

Tom Lendacky (1):
      KVM: SVM: Fix TSC_AUX virtualization setup

Tony Lindgren (5):
      ARM: dts: ti: omap: Fix bandgap thermal cells addressing for omap3/4
      ARM: dts: Unify pwm-omap-dmtimer node names
      ARM: dts: Unify pinctrl-single pin group nodes for omap4
      ARM: dts: ti: omap: motorola-mapphone: Fix abe_clkctrl warning on boot
      bus: ti-sysc: Fix SYSC_QUIRK_SWSUP_SIDLE_ACT handling for uart wake-up

Trond Myklebust (8):
      NFS: Fix error handling for O_DIRECT write scheduling
      NFS: Fix O_DIRECT locking issues
      NFS: More O_DIRECT accounting fixes for error paths
      NFS: Use the correct commit info in nfs_join_page_group()
      NFS: More fixes for nfs_direct_write_reschedule_io()
      NFS/pNFS: Report EINVAL errors from connect() to the server
      SUNRPC: Mark the cred for revalidation if the server rejects it
      Revert "SUNRPC dont update timeout value on connection reset"

Umesh Nerlige Ramappa (1):
      i915/pmu: Move execlist stats initialization to execlist specific setup

Valentin Caron (1):
      spi: stm32: add a delay before SPI disable

Vinicius Costa Gomes (1):
      igc: Fix infinite initialization loop with early XDP redirect

Wenhua Lin (1):
      gpio: pmic-eic-sprd: Add can_sleep flag for PMIC EIC chip

William A. Kennington III (1):
      i2c: npcm7xx: Fix callback completion ordering

Xiaoke Wang (1):
      i2c: mux: demux-pinctrl: check the return value of devm_kstrdup()

Xiubo Li (1):
      ceph: drop messages from MDS when unmounting

YuBiao Wang (1):
      drm/amdkfd: Use gpu_offset for user queue's wptr

Zhang Xiaoxu (1):
      cifs: Fix UAF in cifs_demultiplex_thread()

Zheng Yejian (2):
      selftests/ftrace: Correctly enable event in instance-event.tc
      ring-buffer: Avoid softlockup in ring_buffer_resize()

Zhifeng Tang (1):
      clk: sprd: Fix thm_parents incorrect configuration

Ziyang Xuan (1):
      team: fix null-ptr-deref when team device type is changed

