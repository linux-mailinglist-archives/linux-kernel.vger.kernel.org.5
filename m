Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79EE37BB645
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 13:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232069AbjJFLTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 07:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbjJFLTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 07:19:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74686CE;
        Fri,  6 Oct 2023 04:19:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F8A3C433B8;
        Fri,  6 Oct 2023 11:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696591146;
        bh=m/5h+TZnKHYHvHlAgq9L2U+/Eq+UQqHgA9PYs8olcQ0=;
        h=From:To:Cc:Subject:Date:From;
        b=q2gk+K1pXn8+WQ1niqMNEF4BH4QAXeakhDtiLh4DUGMEdkLk55pQv/yLq3+VZvZ7K
         d349MVR/IvjRZouXx9R1ZYfbW7FMfzAI8zKotN61MhUzVNuaN4CtbOkwGp+plKHa9i
         pz8HoJygeuGQ/e33CJ6rNRMU6nxLnMYePjo7tlac=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.5.6
Date:   Fri,  6 Oct 2023 13:19:01 +0200
Message-ID: <2023100601-happier-prominent-40c6@gregkh>
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

I'm announcing the release of the 6.5.6 kernel.

All users of the 6.5 kernel series must upgrade.

The updated 6.5.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.5.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/admin-guide/cgroup-v1/memory.rst                    |    9 
 Documentation/sound/designs/midi-2.0.rst                          |    4 
 Makefile                                                          |    2 
 arch/arm/boot/dts/ti/omap/motorola-mapphone-common.dtsi           |    4 
 arch/arm/boot/dts/ti/omap/omap3-cpu-thermal.dtsi                  |    3 
 arch/arm/boot/dts/ti/omap/omap4-cpu-thermal.dtsi                  |    5 
 arch/arm/boot/dts/ti/omap/omap443x.dtsi                           |    1 
 arch/arm/boot/dts/ti/omap/omap4460.dtsi                           |    1 
 arch/arm64/boot/dts/freescale/Makefile                            |    1 
 arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi                     |   32 
 arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts               |    5 
 arch/arm64/boot/dts/freescale/imx8mp.dtsi                         |    6 
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts                        |    9 
 arch/arm64/configs/defconfig                                      |    1 
 arch/loongarch/include/asm/addrspace.h                            |   12 
 arch/loongarch/include/asm/elf.h                                  |    9 
 arch/loongarch/kernel/mem.c                                       |    4 
 arch/loongarch/kernel/module.c                                    |   22 
 arch/loongarch/kernel/numa.c                                      |    2 
 arch/loongarch/kernel/vmlinux.lds.S                               |   55 -
 arch/mips/alchemy/devboards/db1000.c                              |    4 
 arch/mips/alchemy/devboards/db1200.c                              |    6 
 arch/mips/alchemy/devboards/db1300.c                              |    4 
 arch/parisc/include/asm/ropes.h                                   |    7 
 arch/parisc/kernel/drivers.c                                      |    2 
 arch/parisc/kernel/irq.c                                          |    2 
 arch/powerpc/kernel/hw_breakpoint.c                               |   16 
 arch/powerpc/kernel/hw_breakpoint_constraints.c                   |    7 
 arch/powerpc/kernel/stacktrace.c                                  |   27 
 arch/powerpc/kernel/traps.c                                       |   56 -
 arch/powerpc/perf/hv-24x7.c                                       |    2 
 arch/riscv/include/asm/errata_list.h                              |    4 
 arch/x86/Kconfig                                                  |    2 
 arch/x86/include/asm/kexec.h                                      |    2 
 arch/x86/include/asm/kvm_host.h                                   |    3 
 arch/x86/include/asm/linkage.h                                    |    7 
 arch/x86/include/asm/processor.h                                  |    2 
 arch/x86/include/asm/reboot.h                                     |    2 
 arch/x86/kernel/cpu/amd.c                                         |   28 
 arch/x86/kernel/cpu/bugs.c                                        |   17 
 arch/x86/kernel/cpu/common.c                                      |    2 
 arch/x86/kernel/cpu/sgx/encl.c                                    |   30 
 arch/x86/kernel/crash.c                                           |   31 
 arch/x86/kernel/reboot.c                                          |   22 
 arch/x86/kernel/setup.c                                           |    8 
 arch/x86/kvm/mmu/mmu.c                                            |   20 
 arch/x86/kvm/mmu/mmu_internal.h                                   |   15 
 arch/x86/kvm/mmu/tdp_mmu.c                                        |  152 +--
 arch/x86/kvm/mmu/tdp_mmu.h                                        |    5 
 arch/x86/kvm/svm/sev.c                                            |   34 
 arch/x86/kvm/svm/svm.c                                            |    9 
 arch/x86/kvm/svm/svm.h                                            |    1 
 arch/x86/kvm/vmx/vmx.c                                            |   10 
 arch/x86/kvm/x86.c                                                |    5 
 arch/x86/lib/memcpy_64.S                                          |    2 
 arch/x86/lib/memmove_64.S                                         |    2 
 arch/x86/lib/memset_64.S                                          |    2 
 arch/xtensa/boot/Makefile                                         |    3 
 arch/xtensa/boot/lib/zmem.c                                       |    5 
 arch/xtensa/include/asm/core.h                                    |    4 
 arch/xtensa/lib/umulsidi3.S                                       |    4 
 arch/xtensa/platforms/iss/network.c                               |    4 
 crypto/sm2.c                                                      |    6 
 drivers/accel/ivpu/ivpu_fw.c                                      |    8 
 drivers/accel/ivpu/ivpu_gem.h                                     |    5 
 drivers/accel/ivpu/ivpu_ipc.c                                     |   11 
 drivers/acpi/nfit/core.c                                          |    2 
 drivers/ata/libata-core.c                                         |   41 
 drivers/ata/libata-eh.c                                           |   16 
 drivers/ata/libata-scsi.c                                         |   53 +
 drivers/ata/libata-transport.c                                    |    9 
 drivers/ata/libata.h                                              |    2 
 drivers/ata/sata_mv.c                                             |    4 
 drivers/block/rbd.c                                               |  412 +++++-----
 drivers/bus/ti-sysc.c                                             |   31 
 drivers/char/agp/parisc-agp.c                                     |    2 
 drivers/clk/clk-si521xx.c                                         |    9 
 drivers/clk/sprd/ums512-clk.c                                     |    2 
 drivers/clk/tegra/clk-bpmp.c                                      |    2 
 drivers/cxl/core/mbox.c                                           |   23 
 drivers/cxl/core/port.c                                           |   13 
 drivers/cxl/core/region.c                                         |   24 
 drivers/cxl/pci.c                                                 |    6 
 drivers/firewire/sbp2.c                                           |    9 
 drivers/firmware/arm_ffa/driver.c                                 |   16 
 drivers/firmware/arm_scmi/perf.c                                  |   93 +-
 drivers/firmware/cirrus/cs_dsp.c                                  |   34 
 drivers/firmware/imx/imx-dsp.c                                    |    1 
 drivers/gpio/gpio-pmic-eic-sprd.c                                 |    1 
 drivers/gpio/gpio-tb10x.c                                         |    6 
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c                        |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h                           |    3 
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c                           |   19 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c                           |    6 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h                      |    9 
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c                            |    2 
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c                            |    2 
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c                             |    2 
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c                             |    2 
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c                             |    2 
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c                             |    7 
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c                           |   76 -
 drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c                            |    3 
 drivers/gpu/drm/amd/amdgpu/soc21.c                                |    2 
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c                             |    3 
 drivers/gpu/drm/amd/amdkfd/kfd_crat.h                             |    4 
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c             |    2 
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c                      |   34 
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h                      |    2 
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c                  |    2 
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c                  |    2 
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c                  |   43 +
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c                   |   46 -
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c                   |    2 
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c                         |   77 +
 drivers/gpu/drm/amd/amdkfd/kfd_topology.h                         |    2 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c                 |    4 
 drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c       |    4 
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c                |   43 -
 drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c     |  105 +-
 drivers/gpu/drm/amd/include/kgd_kfd_interface.h                   |    6 
 drivers/gpu/drm/i915/gem/i915_gem_shmem.c                         |   11 
 drivers/gpu/drm/i915/gt/intel_engine_cs.c                         |    1 
 drivers/gpu/drm/i915/gt/intel_execlists_submission.c              |    2 
 drivers/gpu/drm/i915/gt/intel_ggtt.c                              |   23 
 drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c                 |   38 
 drivers/gpu/drm/meson/meson_encoder_hdmi.c                        |    2 
 drivers/gpu/drm/tests/drm_mm_test.c                               |    2 
 drivers/gpu/drm/virtio/virtgpu_submit.c                           |    1 
 drivers/i2c/busses/i2c-designware-common.c                        |   17 
 drivers/i2c/busses/i2c-designware-core.h                          |    3 
 drivers/i2c/busses/i2c-i801.c                                     |    1 
 drivers/i2c/busses/i2c-npcm7xx.c                                  |   17 
 drivers/i2c/busses/i2c-xiic.c                                     |    2 
 drivers/i2c/muxes/i2c-demux-pinctrl.c                             |    4 
 drivers/i2c/muxes/i2c-mux-gpio.c                                  |    4 
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c                   |   27 
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
 drivers/net/ethernet/engleder/tsnep_ethtool.c                     |    6 
 drivers/net/ethernet/engleder/tsnep_main.c                        |   18 
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c                   |    9 
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c           |   13 
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c         |    3 
 drivers/net/ethernet/huawei/hinic/hinic_port.c                    |    3 
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
 drivers/net/ethernet/microchip/vcap/vcap_api_kunit.c              |   59 +
 drivers/net/ethernet/pensando/ionic/ionic_dev.h                   |    1 
 drivers/net/ethernet/pensando/ionic/ionic_txrx.c                  |   10 
 drivers/net/team/team.c                                           |   10 
 drivers/net/thunderbolt/main.c                                    |    3 
 drivers/net/vxlan/vxlan_core.c                                    |    4 
 drivers/nvme/host/fc.c                                            |    2 
 drivers/nvme/host/pci.c                                           |    3 
 drivers/parisc/ccio-dma.c                                         |   18 
 drivers/parisc/iommu-helpers.h                                    |    8 
 drivers/parisc/iosapic.c                                          |    4 
 drivers/parisc/iosapic_private.h                                  |    4 
 drivers/parisc/sba_iommu.c                                        |   28 
 drivers/platform/mellanox/Kconfig                                 |    1 
 drivers/platform/x86/asus-nb-wmi.c                                |    9 
 drivers/platform/x86/intel_scu_ipc.c                              |   66 -
 drivers/power/supply/ab8500_btemp.c                               |    9 
 drivers/power/supply/ab8500_chargalg.c                            |    2 
 drivers/power/supply/mt6370-charger.c                             |    2 
 drivers/power/supply/power_supply_sysfs.c                         |    7 
 drivers/power/supply/rk817_charger.c                              |   16 
 drivers/power/supply/rt9467-charger.c                             |    4 
 drivers/power/supply/ucs1002_power.c                              |    3 
 drivers/scsi/iscsi_tcp.c                                          |    4 
 drivers/scsi/pm8001/pm8001_hwi.c                                  |    2 
 drivers/scsi/pm8001/pm80xx_hwi.c                                  |    4 
 drivers/scsi/qedf/qedf_io.c                                       |   10 
 drivers/scsi/qedf/qedf_main.c                                     |    7 
 drivers/scsi/scsi.c                                               |   11 
 drivers/scsi/scsi_scan.c                                          |    2 
 drivers/scsi/sd.c                                                 |  101 +-
 drivers/scsi/sd.h                                                 |    1 
 drivers/soc/imx/soc-imx8m.c                                       |   10 
 drivers/spi/spi-gxp.c                                             |    2 
 drivers/spi/spi-intel-pci.c                                       |    1 
 drivers/spi/spi-nxp-fspi.c                                        |    7 
 drivers/spi/spi-stm32.c                                           |    8 
 drivers/spi/spi-sun6i.c                                           |   31 
 drivers/spi/spi-zynqmp-gqspi.c                                    |   12 
 drivers/thermal/thermal_of.c                                      |    8 
 drivers/thermal/thermal_sysfs.c                                   |    9 
 drivers/tty/n_gsm.c                                               |    4 
 drivers/tty/serial/8250/8250_port.c                               |    5 
 drivers/ufs/core/ufshcd.c                                         |   13 
 drivers/vfio/mdev/mdev_sysfs.c                                    |    3 
 drivers/video/fbdev/Kconfig                                       |    2 
 fs/binfmt_elf_fdpic.c                                             |    5 
 fs/btrfs/delayed-inode.c                                          |   85 +-
 fs/btrfs/extent_io.c                                              |    8 
 fs/btrfs/file.c                                                   |   16 
 fs/btrfs/inode.c                                                  |   29 
 fs/btrfs/super.c                                                  |    2 
 fs/ceph/caps.c                                                    |    6 
 fs/ceph/mds_client.c                                              |   12 
 fs/ceph/mds_client.h                                              |   11 
 fs/ceph/quota.c                                                   |   14 
 fs/ceph/snap.c                                                    |   10 
 fs/ceph/super.c                                                   |   75 +
 fs/ceph/super.h                                                   |    3 
 fs/ext4/mballoc.c                                                 |   60 -
 fs/gfs2/glock.c                                                   |    4 
 fs/gfs2/glops.c                                                   |    9 
 fs/libfs.c                                                        |    1 
 fs/netfs/buffered_read.c                                          |    6 
 fs/nfs/direct.c                                                   |  134 ++-
 fs/nfs/flexfilelayout/flexfilelayout.c                            |    1 
 fs/nfs/nfs4client.c                                               |    9 
 fs/nfs/nfs4proc.c                                                 |   14 
 fs/nfs/nfs4state.c                                                |   38 
 fs/nfs/write.c                                                    |   23 
 fs/nfsd/nfs4xdr.c                                                 |    4 
 fs/nilfs2/gcinode.c                                               |    6 
 fs/proc/internal.h                                                |    2 
 fs/proc/task_nommu.c                                              |   64 -
 fs/smb/client/cifsglob.h                                          |    1 
 fs/smb/client/fs_context.c                                        |    1 
 fs/smb/client/inode.c                                             |    2 
 fs/smb/client/smb2ops.c                                           |    6 
 fs/smb/client/transport.c                                         |   34 
 include/linux/atomic/atomic-arch-fallback.h                       |   10 
 include/linux/bpf.h                                               |    2 
 include/linux/btf_ids.h                                           |    2 
 include/linux/compiler_attributes.h                               |   26 
 include/linux/if_team.h                                           |    2 
 include/linux/interrupt.h                                         |    6 
 include/linux/libata.h                                            |    4 
 include/linux/memcontrol.h                                        |    4 
 include/linux/nfs_fs_sb.h                                         |    1 
 include/linux/nfs_page.h                                          |    4 
 include/linux/resume_user_mode.h                                  |    2 
 include/linux/seqlock.h                                           |    2 
 include/net/netfilter/nf_tables.h                                 |    7 
 include/scsi/scsi.h                                               |    3 
 include/scsi/scsi_device.h                                        |    5 
 include/uapi/linux/bpf.h                                          |    4 
 include/uapi/linux/stddef.h                                       |   11 
 io_uring/fs.c                                                     |    2 
 kernel/bpf/btf.c                                                  |    2 
 kernel/bpf/offload.c                                              |   12 
 kernel/bpf/queue_stack_maps.c                                     |   21 
 kernel/dma/debug.c                                                |   20 
 kernel/dma/swiotlb.c                                              |    4 
 kernel/sched/core.c                                               |    2 
 kernel/sched/cpupri.c                                             |    1 
 kernel/sched/idle.c                                               |    1 
 kernel/trace/bpf_trace.c                                          |   16 
 kernel/trace/ring_buffer.c                                        |   38 
 kernel/trace/trace_events_user.c                                  |   58 +
 mm/damon/vaddr-test.h                                             |    2 
 mm/memcontrol.c                                                   |   13 
 mm/mempolicy.c                                                    |   39 
 mm/page_alloc.c                                                   |   12 
 mm/slab_common.c                                                  |   12 
 net/bridge/br_forward.c                                           |    4 
 net/bridge/br_input.c                                             |    4 
 net/core/flow_dissector.c                                         |    2 
 net/dccp/ipv4.c                                                   |    9 
 net/dccp/ipv6.c                                                   |    9 
 net/handshake/handshake-test.c                                    |   14 
 net/hsr/hsr_framereg.c                                            |    4 
 net/hsr/hsr_main.h                                                |    2 
 net/ipv4/route.c                                                  |    4 
 net/mptcp/options.c                                               |    5 
 net/mptcp/protocol.c                                              |   41 
 net/mptcp/subflow.c                                               |   36 
 net/ncsi/ncsi-aen.c                                               |    5 
 net/netfilter/ipset/ip_set_core.c                                 |   12 
 net/netfilter/nf_conntrack_bpf.c                                  |    2 
 net/netfilter/nf_conntrack_extend.c                               |    4 
 net/netfilter/nf_tables_api.c                                     |   79 +
 net/netfilter/nft_set_hash.c                                      |   11 
 net/netfilter/nft_set_pipapo.c                                    |    4 
 net/netfilter/nft_set_rbtree.c                                    |    8 
 net/rds/rdma_transport.c                                          |   12 
 net/smc/smc_stats.h                                               |    3 
 net/sunrpc/clnt.c                                                 |   15 
 scripts/atomic/gen-atomic-fallback.sh                             |    2 
 sound/core/rawmidi.c                                              |    2 
 sound/core/seq/seq_ump_client.c                                   |   24 
 sound/core/seq/seq_ump_convert.c                                  |    2 
 sound/hda/intel-sdw-acpi.c                                        |    8 
 sound/pci/hda/hda_intel.c                                         |    1 
 sound/pci/hda/patch_realtek.c                                     |    3 
 sound/soc/amd/yc/acp6x-mach.c                                     |   35 
 sound/soc/codecs/cs35l56-i2c.c                                    |    1 
 sound/soc/codecs/cs35l56.c                                        |    1 
 sound/soc/codecs/cs42l42-sdw.c                                    |   20 
 sound/soc/codecs/cs42l42.c                                        |   21 
 sound/soc/codecs/cs42l42.h                                        |    1 
 sound/soc/codecs/rt5640.c                                         |   33 
 sound/soc/codecs/wm_adsp.c                                        |   13 
 sound/soc/fsl/imx-audmix.c                                        |    2 
 sound/soc/fsl/imx-pcm-rpmsg.c                                     |    1 
 sound/soc/fsl/imx-rpmsg.c                                         |    8 
 sound/soc/intel/avs/boards/hdaudio.c                              |    3 
 sound/soc/meson/axg-spdifin.c                                     |   49 -
 sound/soc/sof/core.c                                              |    3 
 sound/soc/sof/intel/mtl.c                                         |    2 
 sound/soc/sof/intel/mtl.h                                         |    1 
 sound/soc/sof/ipc4-topology.c                                     |    2 
 sound/soc/sof/sof-audio.c                                         |    3 
 tools/include/linux/btf_ids.h                                     |    2 
 tools/include/linux/mm.h                                          |    4 
 tools/include/linux/seq_file.h                                    |    2 
 tools/include/uapi/linux/bpf.h                                    |    4 
 tools/objtool/check.c                                             |    3 
 tools/perf/util/Build                                             |    6 
 tools/testing/memblock/internal.h                                 |    4 
 tools/testing/memblock/mmzone.c                                   |    2 
 tools/testing/memblock/tests/basic_api.c                          |    2 
 tools/testing/memblock/tests/common.h                             |    1 
 tools/testing/selftests/bpf/test_verifier.c                       |    2 
 tools/testing/selftests/ftrace/test.d/instances/instance-event.tc |    2 
 tools/testing/selftests/kselftest_deps.sh                         |   77 +
 tools/testing/selftests/mm/charge_reserved_hugetlb.sh             |    4 
 tools/testing/selftests/mm/hugetlb_reparenting_test.sh            |    4 
 tools/testing/selftests/net/tls.c                                 |    8 
 tools/testing/selftests/powerpc/Makefile                          |    7 
 tools/testing/selftests/powerpc/pmu/Makefile                      |   11 
 346 files changed, 3168 insertions(+), 1861 deletions(-)

Adam Ford (3):
      bus: ti-sysc: Fix missing AM35xx SoC matching
      arm64: dts: imx8mp: Fix SDMA2/3 clocks
      arm64: dts: imx8mp-beacon-kit: Fix audio_pll2 clock

Al Viro (1):
      direct_write_fallback(): on error revert the ->ki_pos update from buffered write

Alex Deucher (2):
      drm/amdgpu/soc21: don't remap HDP registers for SR-IOV
      drm/amdgpu/nbio4.3: set proper rmmio_remap.reg_offset for SR-IOV

Alexey Dobriyan (2):
      uapi: stddef.h: Fix header guard location
      uapi: stddef.h: Fix __DECLARE_FLEX_ARRAY for C++

Alison Schofield (1):
      cxl/region: Match auto-discovered region decoders by HPA range

Amit Pundir (1):
      arm64: dts: qcom: sdm845-db845c: Mark cont splash memory region as reserved

Andreas Gruenbacher (1):
      gfs2: Fix another freeze/thaw hang

Andy Shevchenko (2):
      LoongArch: Use _UL() and _ULL()
      serial: 8250_port: Check IRQ data before use

Ard Biesheuvel (1):
      efi/x86: Ensure that EFI_RUNTIME_MAP is enabled for kexec

Arnaldo Carvalho de Melo (1):
      perf build: Define YYNOMEM as YYNOABORT for bison < 3.81

Artem Chernyshev (1):
      net: rds: Fix possible NULL-pointer dereference

Artem Savkov (1):
      selftests/bpf: fix unpriv_disabled check in test_verifier

August Wikerfors (1):
      ASoC: amd: yc: Fix non-functional mic on Lenovo 82QF and 82UG

Bard Liao (1):
      ASoC: SOF: ipc4-topology: fix wrong sizeof argument

Beau Belgrave (1):
      tracing/user_events: Align set_bit() address for all archs

Ben Wolsieffer (2):
      proc: nommu: /proc/<pid>/maps: release mmap read lock
      proc: nommu: fix empty /proc/<pid>/maps

Benjamin Gray (4):
      powerpc/dexcr: Move HASHCHK trap handler
      powerpc/watchpoints: Disable preemption in thread_change_pc()
      powerpc/watchpoint: Disable pagefaults when getting user instruction
      powerpc/watchpoints: Annotate atomic context in more places

Benjamin Poirier (1):
      vxlan: Add missing entries to vxlan_get_size()

Bernd Schubert (1):
      btrfs: file_remove_privs needs an exclusive lock in direct io write

Bob Peterson (1):
      gfs2: fix glock shrinker ref issues

Cai Huoqing (1):
      net: hinic: Fix warning-hinic_set_vlan_fliter() warn: variable dereferenced before check 'hwdev'

Chancel Liu (1):
      ASoC: imx-rpmsg: Set ignore_pmdown_time for dai_link

Charles Kearney (1):
      spi: spi-gxp: BUG: Correct spi write return value

Chen Ni (1):
      ASoC: hdaudio.c: Add missing check for devm_kstrdup

Chris Morgan (1):
      power: supply: rk817: Fix node refcount leak

Christoph Hellwig (1):
      MIPS: Alchemy: only build mmc support helpers if au1xmmc is enabled

Christophe JAILLET (5):
      bpf: Fix a erroneous check after snprintf()
      gpio: tb10x: Fix an error handling path in tb10x_gpio_probe()
      power: supply: rt9467: Fix rt9467_run_aicl()
      firmware: imx-dsp: Fix an error handling path in imx_dsp_setup_channels()
      ata: sata_mv: Fix incorrect string length computation in mv_dump_mem()

Chuck Lever (1):
      NFSD: Fix zero NFSv4 READ results when RQ_SPLICE_OK is not set

Cristian Marussi (1):
      firmware: arm_scmi: Harden perf domain info access

Damien Le Moal (7):
      scsi: core: ata: Do no try to probe for CDL on old drives
      ata: libata-scsi: link ata port and scsi device
      scsi: sd: Differentiate system and runtime start/stop management
      scsi: sd: Do not issue commands to suspended disks on shutdown
      ata: libata-core: Fix ata_port_request_pm() locking
      ata: libata-core: Fix port and device removal
      ata: libata-core: Do not register PM operations for SAS ports

Dan Carpenter (1):
      power: supply: ucs1002: fix error code in ucs1002_get_property()

Dan Williams (1):
      cxl/port: Fix cxl_test register enumeration regression

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

David Francis (2):
      drm/amdkfd: Checkpoint and restore queues on GFX11
      drm/amdgpu: Handle null atom context in VBIOS info ioctl

David Thompson (1):
      platform/mellanox: mlxbf-bootctl: add NET dependency into Kconfig

Eduard Zingerman (1):
      bpf: Avoid dummy bpf_offload_netdev in __bpf_prog_dev_bound_init

Eric Dumazet (3):
      scsi: iscsi_tcp: restrict to TCP sockets
      dccp: fix dccp_v4_err()/dccp_v6_err() again
      net: bridge: use DEV_STATS_INC()

Filipe Manana (6):
      btrfs: improve error message after failure to add delayed dir index item
      btrfs: remove BUG() after failure to insert delayed dir index item
      btrfs: assert delayed node locked when removing delayed item
      btrfs: refresh dir last index during a rewinddir(3) call
      btrfs: set last dir index to the current last index when opening dir
      btrfs: fix race between reading a directory and adding entries to it

Florian Westphal (3):
      netfilter: nf_tables: fix memleak when more than 255 elements expired
      netfilter: conntrack: fix extension size table
      netfilter: nf_tables: disable toggling dormant table state more than once

Frederic Weisbecker (1):
      timers: Tag (hr)timer softirq as hotplug safe

Gerhard Engleder (3):
      tsnep: Fix NAPI scheduling
      tsnep: Fix ethtool channels
      tsnep: Fix NAPI polling with budget 0

Greg Kroah-Hartman (1):
      Linux 6.5.6

Greg Ungerer (1):
      fs: binfmt_elf_efpic: fix personality for ELF-FDPIC

Guangguan Wang (1):
      net/smc: bugfix for smcr v2 server connect success statistic

Haitao Huang (1):
      x86/sgx: Resolves SECS reclaim vs. page fault for EAUG race

Hamza Mahfooz (1):
      drm/amd/display: fix the ability to use lower resolution modes on eDP

Han Xu (1):
      spi: nxp-fspi: reset the FLSHxCR1 registers

Hans Verkuil (1):
      media: vb2: frame_vector.c: replace WARN_ONCE with a comment

Hans de Goede (6):
      ASoC: rt5640: Revert "Fix sleep in atomic context"
      ASoC: rt5640: Fix sleep in atomic context
      ASoC: rt5640: Do not disable/enable IRQ twice on suspend/resume
      ASoC: rt5640: Enable the IRQ on resume after configuring jack-detect
      ASoC: rt5640: Fix IRQ not being free-ed for HDA jack detect mode
      ASoC: rt5640: Only cancel jack-detect work on suspend if active

Harshit Mogalapalli (1):
      power: supply: mt6370: Fix missing error code in mt6370_chg_toggle_cfo()

Hawking Zhang (1):
      drm/amdgpu: fallback to old RAS error message for aqua_vanjaram

Heiner Kallweit (1):
      i2c: i801: unregister tco_pdev in i801_probe() error path

Helge Deller (7):
      parisc: sba: Fix compile warning wrt list of SBA devices
      parisc: sba-iommu: Fix sparse warnigs
      parisc: ccio-dma: Fix sparse warnings
      parisc: iosapic.c: Fix sparse warnings
      parisc: drivers: Fix sparse warning
      parisc: irq: Make irq_stack_union static to avoid sparse warning
      LoongArch: Fix lockdep static memory detection

Huacai Chen (2):
      LoongArch: Set all reserved memblocks on Node#0 at initialization
      LoongArch: numa: Fix high_memory calculation

Icenowy Zheng (1):
      riscv: errata: fix T-Head dcache.cva encoding

Ilya Dryomov (4):
      rbd: move rbd_dev_refresh() definition
      rbd: decouple header read-in from updating rbd_dev->header
      rbd: decouple parent info read-in from updating rbd_dev
      rbd: take header_rwsem in rbd_dev_refresh() only when updating

Ilya Leoshkevich (1):
      netfilter, bpf: Adjust timeouts of non-confirmed CTs in bpf_ct_insert_entry()

Ira Weiny (1):
      cxl/mbox: Fix CEL logic for poison and security commands

Ivan Vecera (1):
      i40e: Fix VF VLAN offloading when port VLAN is configured

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

Jiadong Zhu (1):
      drm/amdgpu: set completion status as preempted for the resubmission

Jian Shen (1):
      net: hns3: only enable unicast promisc when mac table full

Jie Wang (3):
      net: hns3: add cmdq check for vf periodic service task
      net: hns3: fix GRE checksum offload issue
      net: hns3: add 5ms delay before clear firmware reset irq source

Jijie Shao (1):
      net: hns3: fix fail to delete tc flower rules during reset issue

Jinjie Ruan (8):
      net: microchip: sparx5: Fix memory leak for vcap_api_rule_add_keyvalue_test()
      net: microchip: sparx5: Fix memory leak for vcap_api_rule_add_actionvalue_test()
      net: microchip: sparx5: Fix possible memory leak in vcap_api_encode_rule_test()
      net: microchip: sparx5: Fix possible memory leaks in test_vcap_xn_rule_creator()
      net: microchip: sparx5: Fix possible memory leaks in vcap_api_kunit
      net/handshake: Fix memory leak in __sock_create() and sock_alloc_file()
      vfio/mdev: Fix a null-ptr-deref bug for mdev_unregister_parent()
      mm/damon/vaddr-test: fix memory leak in damon_do_test_apply_three_regions()

Jiri Olsa (2):
      bpf: Add override check to kprobe multi link attach
      bpf: Fix BTF_ID symbol generation collision

Joel Fernandes (Google) (1):
      sched/rt: Fix live lock between select_fallback_rq() and RT push

Johan Hovold (1):
      spi: zynqmp-gqspi: fix clock imbalance on probe failure

Johannes Weiner (2):
      mm: page_alloc: fix CMA and HIGHATOMIC landing on the wrong buddy list
      mm: memcontrol: fix GFP_NOFS recursion in memory.high enforcement

Johnathan Mantey (1):
      ncsi: Propagate carrier gain/loss events to the NCSI controller

Josef Bacik (1):
      btrfs: properly report 0 avail for very full file systems

Josh Poimboeuf (5):
      x86/srso: Fix srso_show_state() side effect
      x86/srso: Set CPUID feature bits independently of bug or mitigation status
      x86/srso: Don't probe microcode in a guest
      x86/srso: Fix SBPB enablement for spec_rstack_overflow=off
      objtool: Fix _THIS_IP_ detection for cold functions

José Pekkarinen (1):
      drm/virtio: clean out_fence on complete_submit

Jozsef Kadlecsik (1):
      netfilter: ipset: Fix race between IPSET_CMD_CREATE and IPSET_CMD_SWAP

Julia Lawall (1):
      thermal/of: add missing of_node_put()

Julien Panis (1):
      bus: ti-sysc: Use fsleep() instead of usleep_range() in sysc_reset()

Juntong Deng (1):
      selftests/mm: fix awk usage in charge_reserved_hugetlb.sh and hugetlb_reparenting_test.sh that may cause error

Kailang Yang (1):
      ALSA: hda: Disable power save for solving pop issue on Lenovo ThinkCentre M70q

Kajol Jain (1):
      powerpc/perf/hv-24x7: Update domain value check

Karol Wachowski (1):
      accel/ivpu: Use cached buffers for FW loading

Kees Cook (1):
      Compiler Attributes: counted_by: Adjust name and identifier expansion

Kemeng Shi (1):
      ext4: replace the traditional ternary conditional operator with with max()/min()

Kiwoong Kim (2):
      scsi: ufs: core: Move __ufshcd_send_uic_cmd() outside host_lock
      scsi: ufs: core: Poll HCS.UCRDY before issuing a UIC command

Knyazev Arseniy (1):
      ALSA: hda/realtek: Splitting the UX3402 into two separate models

Kyle Zeng (1):
      ipv4: fix null-deref in ipv4_link_failure

Liam R. Howlett (1):
      kernel/sched: Modify initial boot task idle setup

Liang He (1):
      i2c: mux: gpio: Add missing fwnode_handle_put()

Linus Walleij (1):
      power: supply: ab8500: Set typing and props

Liu Ying (1):
      arm64: dts: imx8mm-evk: Fix hdmi@3d node

Lukasz Majewski (1):
      net: hsr: Properly parse HSRv1 supervisor frames.

Luke D. Jones (1):
      platform/x86: asus-wmi: Support 2023 ROG X16 tablet mode

Marek Vasut (2):
      clk: si521xx: Use REGCACHE_FLAT instead of NONE
      clk: si521xx: Fix regmap write accessor

Mario Limonciello (1):
      ASoC: amd: yc: Fix a non-functional mic on Lenovo 82TL

Mark Rutland (1):
      locking/atomic: scripts: fix fallback ifdeffery

Matthew Wilcox (Oracle) (1):
      i915: Limit the length of an sg list to the requested length

Matthias Schiffer (1):
      ata: libata-sata: increase PMP SRST timeout to 10s

Max Filippov (2):
      xtensa: add default definition for XCHAL_HAVE_DIV32
      xtensa: boot/lib: fix function prototypes

Michael Ellerman (2):
      powerpc/stacktrace: Fix arch_stack_walk_reliable()
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

Muhammad Husaini Zulkifli (1):
      igc: Expose tx-usecs coalesce setting to user

Mukul Joshi (3):
      drm/amdgpu: Store CU info from all XCCs for GFX v9.4.3
      drm/amdkfd: Update cache info reporting for GFX v9.4.3
      drm/amdkfd: Update CU masking for GFX 9.4.3

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

Niklas Cassel (3):
      ata: libata-eh: do not clear ATA_PFLAG_EH_PENDING in ata_eh_reset()
      ata: libata-eh: do not thaw the port twice in ata_eh_reset()
      ata: libata-scsi: ignore reserved bits for REPORT SUPPORTED OPERATION CODES

Olga Kornievskaia (3):
      NFSv4.1: use EXCHGID4_FLAG_USE_PNFS_DS for DS server
      NFSv4.1: fix pnfs MDS=DS session trunking
      NFSv4.1: fix zero value filehandle in post open getattr

Pablo Neira Ayuso (6):
      netfilter: nft_set_rbtree: use read spinlock to avoid datapath contention
      netfilter: nft_set_pipapo: call nft_trans_gc_queue_sync() in catchall GC
      netfilter: nft_set_pipapo: stop GC iteration if GC transaction allocation fails
      netfilter: nft_set_hash: try later when GC hits EAGAIN on iteration
      netfilter: nf_tables: disallow rule removal from chain binding
      netfilter: nf_tables: disallow element removal on anonymous sets

Pan Bian (1):
      nilfs2: fix potential use after free in nilfs_gccache_submit_read_data()

Paolo Abeni (3):
      mptcp: fix bogus receive window shrinkage with multiple subflows
      mptcp: move __mptcp_error_report in protocol.c
      mptcp: process pending subflow error on close

Paolo Bonzini (2):
      KVM: SVM: INTERCEPT_RDTSCP is never intercepted anyway
      KVM: x86/mmu: Do not filter address spaces in for_each_tdp_mmu_root_yield_safe()

Peter Ujfalusi (3):
      ASoC: SOF: core: Only call sof_ops_free() on remove if the probe was successful
      ALSA: hda: intel-sdw-acpi: Use u8 type for link index
      ASoC: SOF: sof-audio: Fix DSP core put imbalance on widget setup failure

Petr Oros (2):
      iavf: add iavf_schedule_aq_request() helper
      iavf: schedule a request immediately after add/delete vlan

Phil Sutter (1):
      netfilter: nf_tables: Fix entries val in rule reset audit log

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

Rafael J. Wysocki (1):
      thermal: sysfs: Fix trip_point_hyst_store()

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

Richard Fitzgerald (7):
      ASoC: cs35l56: Disable low-power hibernation mode
      ASoC: cs42l42: Ensure a reset pulse meets minimum pulse width.
      ASoC: cs42l42: Don't rely on GPIOD_OUT_LOW to set RESET initially low
      ASoC: cs42l42: Avoid stale SoundWire ATTACH after hard reset
      firmware: cirrus: cs_dsp: Only log list of algorithms in debug build
      ASoC: wm_adsp: Fix missing locking in wm_adsp_[read|write]_ctl()
      ASoC: cs35l56: Call pm_runtime_dont_use_autosuspend()

Ricky WU (1):
      misc: rtsx: Fix some platforms can not boot and move the l1ss judgment to probe

Rik van Riel (1):
      x86/mm, kexec, ima: Use memblock_free_late() from ima_free_kexec_buffer()

Rob Herring (1):
      arm64: dts: imx: Add imx8mm-prt8mm.dtb to build

Rong Tao (1):
      memblock tests: Fix compilation errors.

Ross Lagerwall (1):
      swiotlb: use the calculated number of areas

Sabrina Dubroca (1):
      selftests: tls: swap the TX and RX sockets in some tests

Sakari Ailus (2):
      media: v4l: Use correct dependency for camera sensor drivers
      media: via: Use correct dependency for camera sensor drivers

Sasha Neftin (1):
      net/core: Fix ETH_P_1588 flow dissector

Sean Christopherson (3):
      x86/reboot: VMCLEAR active VMCSes before emergency reboot
      KVM: x86/mmu: Open code leaf invalidation from mmu_notifier
      KVM: x86/mmu: Stop zapping invalidated TDP MMU roots asynchronously

Sebastian Andrzej Siewior (5):
      locking/seqlock: Do the lockdep annotation before locking in do_write_seqcount_begin_nested()
      net: ena: Flush XDP packets on error.
      bnxt_en: Flush XDP for bnxt_poll_nitroa0()'s NAPI
      octeontx2-pf: Do xdp_do_flush() after redirects.
      net: hsr: Add __packed to struct hsr_sup_tlv.

Sebastian Reichel (1):
      power: supply: core: fix use after free in uevent

Senhong Liu (1):
      ASoC: rt5640: fix typos

Sergey Senozhatsky (1):
      dma-debug: don't call __dma_entry_alloc_check_leak() under free_entries_lock

Shengjiu Wang (2):
      ASoC: imx-audmix: Fix return error with devm_clk_get()
      ASoC: fsl: imx-pcm-rpmsg: Add SNDRV_PCM_INFO_BATCH flag

Shinas Rasheed (1):
      octeon_ep: fix tx dma unmap len values in SG

Shubh (1):
      ASoC: amd: yc: Add DMI entries to support Victus by HP Gaming Laptop 15-fb0xxx (8A3E)

Sibi Sankar (1):
      firmware: arm_scmi: Fixup perf power-cost/microwatt support

Smita Koralahalli (1):
      cxl/pci: Fix appropriate checking for _OSC while handling CXL RAS registers

Stanislav Fomichev (1):
      bpf: Clarify error expectations from bpf_clone_redirect

Stanislaw Gruszka (1):
      accel/ivpu: Do not use wait event interruptible

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

Swapnil Patel (1):
      drm/amd/display: Don't check registers, if using AUX BL control

Takashi Iwai (4):
      ALSA: docs: Fix a typo of midi2_ump_probe option for snd-usb-audio
      ALSA: seq: Avoid delivery of events for disabled UMP groups
      ALSA: seq: ump: Fix -Wformat-truncation warning
      ALSA: rawmidi: Fix NULL dereference at proc read

Thomas Zimmermann (1):
      fbdev/sh7760fb: Depend on FB=y

Tianjia Zhang (1):
      crypto: sm2 - Fix crash caused by uninitialized context

Tiezhu Yang (3):
      LoongArch: Define relocation types for ABI v2.10
      LoongArch: Add support for 32_PCREL relocation type
      LoongArch: Add support for 64_PCREL relocation type

Timo Alho (1):
      clk: tegra: fix error return case for recalc_rate

Tobias Schramm (2):
      spi: sun6i: reduce DMA RX transfer width to single byte
      spi: sun6i: fix race between DMA RX transfer completion and RX FIFO drain

Toke Høiland-Jørgensen (1):
      bpf: Avoid deadlock when using queue and stack maps from NMI

Tom Lendacky (1):
      KVM: SVM: Fix TSC_AUX virtualization setup

Tony Lindgren (3):
      ARM: dts: ti: omap: Fix bandgap thermal cells addressing for omap3/4
      ARM: dts: ti: omap: motorola-mapphone: Fix abe_clkctrl warning on boot
      bus: ti-sysc: Fix SYSC_QUIRK_SWSUP_SIDLE_ACT handling for uart wake-up

Trond Myklebust (9):
      NFS: Fix error handling for O_DIRECT write scheduling
      NFS: Fix O_DIRECT locking issues
      NFS: More O_DIRECT accounting fixes for error paths
      NFS: Use the correct commit info in nfs_join_page_group()
      NFS: More fixes for nfs_direct_write_reschedule_io()
      NFS/pNFS: Report EINVAL errors from connect() to the server
      SUNRPC: Mark the cred for revalidation if the server rejects it
      Revert "SUNRPC dont update timeout value on connection reset"
      NFSv4: Fix a state manager thread deadlock regression

Umesh Nerlige Ramappa (2):
      i915/pmu: Move execlist stats initialization to execlist specific setup
      i915/guc: Get runtime pm in busyness worker only if already active

Valentin Caron (1):
      spi: stm32: add a delay before SPI disable

Vincent Whitchurch (1):
      x86/asm: Fix build of UML with KASAN

Vinicius Costa Gomes (1):
      igc: Fix infinite initialization loop with early XDP redirect

Walt Holman (1):
      Add DMI ID for MSI Bravo 15 B7ED

Wenhua Lin (1):
      gpio: pmic-eic-sprd: Add can_sleep flag for PMIC EIC chip

Wenjing Liu (2):
      drm/amd/display: Update DPG test pattern programming
      drm/amd/display: fix a regression in blank pixel data caused by coding mistake

William A. Kennington III (1):
      i2c: npcm7xx: Fix callback completion ordering

Xiaoke Wang (1):
      i2c: mux: demux-pinctrl: check the return value of devm_kstrdup()

Xiubo Li (1):
      ceph: drop messages from MDS when unmounting

Yang Shi (1):
      mm: mempolicy: keep VMA walk if both MPOL_MF_STRICT and MPOL_MF_MOVE are specified

Yann Sionneau (1):
      i2c: designware: fix __i2c_dw_disable() in case master is holding SCL low

Yu Liao (1):
      ACPI: NFIT: Fix incorrect calculation of idt size

YuBiao Wang (1):
      drm/amdkfd: Use gpu_offset for user queue's wptr

Zhang Xiaoxu (1):
      cifs: Fix UAF in cifs_demultiplex_thread()

Zheng Yejian (3):
      selftests/ftrace: Correctly enable event in instance-event.tc
      ring-buffer: Avoid softlockup in ring_buffer_resize()
      ring-buffer: Fix bytes info in per_cpu buffer stats

Zhifeng Tang (1):
      clk: sprd: Fix thm_parents incorrect configuration

Ziyang Xuan (1):
      team: fix null-ptr-deref when team device type is changed

