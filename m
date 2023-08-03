Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F57A76E583
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 12:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235388AbjHCKW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 06:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235377AbjHCKV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 06:21:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D30349E6;
        Thu,  3 Aug 2023 03:20:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A16761D07;
        Thu,  3 Aug 2023 10:20:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC42EC433C8;
        Thu,  3 Aug 2023 10:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691058003;
        bh=YKFXGyrt/dSFlCOFDW00Qrcn0I/8eDOE0xfqif8gG60=;
        h=From:To:Cc:Subject:Date:From;
        b=W8oIrtfwrkzI+6NUdKl4rmpee3lXQDhJyH+Q2nHdkN05eB3dhv4Ztu8R/JKygGGYO
         UCqA7wH34oTlQBr1efCXtdnWHZvL5r6MriZDl4Qbf7ECr1aEtcsxlHtbPTD+K39Cux
         /SDgrSEA+OXUatbMP6g4rBPbmjmtzEB7eI0/3EdA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.43
Date:   Thu,  3 Aug 2023 12:19:54 +0200
Message-ID: <2023080354-antivirus-villain-c9aa@gregkh>
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

I'm announcing the release of the 6.1.43 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/ABI/testing/sysfs-module                              |   11 
 Documentation/admin-guide/security-bugs.rst                         |   39 -
 Documentation/arm64/silicon-errata.rst                              |    3 
 Documentation/trace/kprobetrace.rst                                 |    8 
 Makefile                                                            |    2 
 arch/arm64/Kconfig                                                  |   19 
 arch/arm64/kernel/cpu_errata.c                                      |    7 
 arch/arm64/kernel/fpsimd.c                                          |    4 
 arch/arm64/kvm/hyp/pgtable.c                                        |   16 
 arch/arm64/tools/cpucaps                                            |    1 
 arch/loongarch/Kconfig                                              |    1 
 arch/loongarch/net/bpf_jit.h                                        |    2 
 arch/mips/Makefile                                                  |   34 
 arch/mips/loongson2ef/Platform                                      |   35 -
 arch/mips/loongson64/Platform                                       |   16 
 arch/powerpc/platforms/pseries/vas.c                                |    9 
 arch/s390/mm/gmap.c                                                 |    1 
 arch/um/os-Linux/sigio.c                                            |    7 
 arch/x86/include/asm/kvm-x86-ops.h                                  |    1 
 arch/x86/include/asm/kvm_host.h                                     |    3 
 arch/x86/kernel/cpu/mce/amd.c                                       |    4 
 arch/x86/kernel/traps.c                                             |   18 
 arch/x86/kvm/svm/svm.c                                              |    6 
 arch/x86/kvm/vmx/vmx.c                                              |   41 -
 arch/x86/kvm/x86.c                                                  |   34 
 block/blk-core.c                                                    |    3 
 block/blk-mq.c                                                      |    9 
 drivers/acpi/arm64/iort.c                                           |    3 
 drivers/acpi/processor_perflib.c                                    |   38 -
 drivers/ata/pata_ns87415.c                                          |    2 
 drivers/base/power/power.h                                          |    1 
 drivers/base/power/wakeirq.c                                        |   12 
 drivers/block/rbd.c                                                 |  124 ++-
 drivers/block/ublk_drv.c                                            |  145 +---
 drivers/char/tpm/tpm_tis_core.c                                     |    9 
 drivers/cpufreq/intel_pstate.c                                      |   14 
 drivers/cxl/acpi.c                                                  |    5 
 drivers/dma-buf/dma-fence-unwrap.c                                  |   26 
 drivers/dma-buf/dma-fence.c                                         |    7 
 drivers/gpio/gpio-mvebu.c                                           |   26 
 drivers/gpio/gpio-tps68470.c                                        |    6 
 drivers/gpu/drm/amd/amdgpu/amdgpu.h                                 |    1 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                          |   19 
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c                             |    6 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c                   |  121 ++-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c         |    2 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c             |    4 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c               |    3 
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c      |    5 
 drivers/gpu/drm/amd/display/dc/core/dc.c                            |  348 ++++++----
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c                   |   20 
 drivers/gpu/drm/amd/display/dc/dc.h                                 |   64 -
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c                        |    7 
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h                        |    1 
 drivers/gpu/drm/amd/display/dc/dc_stream.h                          |    5 
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c                  |    4 
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c                   |    7 
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubbub.c                 |    1 
 drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c             |  110 +++
 drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c                |   23 
 drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c                |   49 +
 drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.h                |    4 
 drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c      |   39 -
 drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.c   |    3 
 drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c              |   15 
 drivers/gpu/drm/amd/display/dc/dml/dcn314/display_rq_dlg_calc_314.c |   16 
 drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c                |   19 
 drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h           |    3 
 drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c               |    6 
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h                         |    2 
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h                     |    2 
 drivers/gpu/drm/amd/display/dmub/src/Makefile                       |    2 
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c                   |    5 
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.h                   |    2 
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn314.c                  |   67 +
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn314.h                  |   35 +
 drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c                     |   12 
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c             |   89 --
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c                      |   21 
 drivers/gpu/drm/drm_syncobj.c                                       |    6 
 drivers/gpu/drm/i915/display/intel_dpt.c                            |    4 
 drivers/gpu/drm/i915/gem/selftests/huge_pages.c                     |    6 
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c                               |    2 
 drivers/gpu/drm/msm/adreno/a6xx_gpu_state.h                         |    2 
 drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.h                       |   13 
 drivers/gpu/drm/msm/msm_drv.c                                       |    6 
 drivers/gpu/drm/msm/msm_gem_submit.c                                |   12 
 drivers/gpu/drm/msm/msm_gpu.h                                       |    2 
 drivers/gpu/drm/msm/msm_submitqueue.c                               |    2 
 drivers/gpu/drm/ttm/ttm_bo.c                                        |   25 
 drivers/hwmon/k10temp.c                                             |   17 
 drivers/hwmon/nct7802.c                                             |    2 
 drivers/i2c/busses/i2c-ibm_iic.c                                    |    4 
 drivers/i2c/busses/i2c-nomadik.c                                    |   42 -
 drivers/i2c/busses/i2c-sh7760.c                                     |    3 
 drivers/i2c/busses/i2c-tiny-usb.c                                   |    4 
 drivers/infiniband/hw/bnxt_re/ib_verbs.c                            |   12 
 drivers/infiniband/hw/bnxt_re/qplib_fp.c                            |   18 
 drivers/infiniband/hw/bnxt_re/qplib_fp.h                            |    1 
 drivers/infiniband/hw/irdma/ctrl.c                                  |   31 
 drivers/infiniband/hw/irdma/defs.h                                  |   46 -
 drivers/infiniband/hw/irdma/hw.c                                    |    3 
 drivers/infiniband/hw/irdma/main.h                                  |    2 
 drivers/infiniband/hw/irdma/puda.c                                  |    6 
 drivers/infiniband/hw/irdma/type.h                                  |    2 
 drivers/infiniband/hw/irdma/uk.c                                    |    5 
 drivers/infiniband/hw/irdma/utils.c                                 |    8 
 drivers/infiniband/hw/mlx4/qp.c                                     |   18 
 drivers/infiniband/hw/mthca/mthca_qp.c                              |    2 
 drivers/irqchip/irq-bcm6345-l1.c                                    |   14 
 drivers/irqchip/irq-gic-v3-its.c                                    |   75 +-
 drivers/md/dm-cache-policy-smq.c                                    |   28 
 drivers/md/dm-raid.c                                                |   20 
 drivers/md/md.c                                                     |    2 
 drivers/media/platform/amphion/vpu_core.c                           |    4 
 drivers/net/bonding/bond_main.c                                     |    5 
 drivers/net/can/usb/gs_usb.c                                        |    2 
 drivers/net/dsa/qca/qca8k-common.c                                  |   19 
 drivers/net/ethernet/atheros/atl1e/atl1e_main.c                     |    7 
 drivers/net/ethernet/atheros/atlx/atl1.c                            |    7 
 drivers/net/ethernet/emulex/benet/be_main.c                         |    3 
 drivers/net/ethernet/hisilicon/hns3/hnae3.h                         |    3 
 drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_cmd.c    |   21 
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c              |   17 
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c          |    3 
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c               |    3 
 drivers/net/ethernet/intel/i40e/i40e_debugfs.c                      |    2 
 drivers/net/ethernet/intel/iavf/iavf_main.c                         |   11 
 drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c                   |   26 
 drivers/net/ethernet/intel/igc/igc_main.c                           |   40 -
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c                       |    2 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.c            |   59 +
 drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.h            |    8 
 drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c                    |    4 
 drivers/net/phy/marvell10g.c                                        |    7 
 drivers/net/team/team.c                                             |    9 
 drivers/net/virtio_net.c                                            |    4 
 drivers/net/vxlan/vxlan_core.c                                      |  165 +++-
 drivers/pci/controller/pcie-rockchip-ep.c                           |  156 ++--
 drivers/pci/controller/pcie-rockchip.h                              |   40 -
 drivers/pci/pcie/aspm.c                                             |   55 +
 drivers/phy/hisilicon/phy-hisi-inno-usb2.c                          |    2 
 drivers/phy/mediatek/phy-mtk-dp.c                                   |    2 
 drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c                       |   74 +-
 drivers/platform/x86/amd/pmf/acpi.c                                 |   23 
 drivers/platform/x86/amd/pmf/core.c                                 |    9 
 drivers/platform/x86/amd/pmf/pmf.h                                  |   16 
 drivers/platform/x86/amd/pmf/sps.c                                  |   74 ++
 drivers/platform/x86/msi-laptop.c                                   |    8 
 drivers/s390/block/dasd_3990_erp.c                                  |    2 
 drivers/s390/block/dasd_ioctl.c                                     |    1 
 drivers/soundwire/bus.c                                             |    8 
 drivers/soundwire/qcom.c                                            |    2 
 drivers/staging/ks7010/ks_wlan_net.c                                |    6 
 drivers/staging/media/atomisp/Kconfig                               |    1 
 drivers/staging/rtl8712/rtl871x_xmit.c                              |   43 -
 drivers/staging/rtl8712/xmit_linux.c                                |    6 
 drivers/tty/n_gsm.c                                                 |    4 
 drivers/tty/n_tty.c                                                 |   29 
 drivers/tty/serial/8250/8250_dwlib.c                                |    6 
 drivers/tty/serial/qcom_geni_serial.c                               |    7 
 drivers/tty/serial/sifive.c                                         |    2 
 drivers/usb/cdns3/cdns3-gadget.c                                    |    4 
 drivers/usb/core/quirks.c                                           |    4 
 drivers/usb/dwc3/core.c                                             |   20 
 drivers/usb/dwc3/core.h                                             |    3 
 drivers/usb/dwc3/dwc3-pci.c                                         |    6 
 drivers/usb/gadget/composite.c                                      |    4 
 drivers/usb/gadget/legacy/raw_gadget.c                              |   10 
 drivers/usb/gadget/udc/core.c                                       |    1 
 drivers/usb/gadget/udc/tegra-xudc.c                                 |    8 
 drivers/usb/host/ohci-at91.c                                        |    8 
 drivers/usb/host/xhci-mtk.c                                         |    1 
 drivers/usb/host/xhci-pci.c                                         |    4 
 drivers/usb/host/xhci-ring.c                                        |   25 
 drivers/usb/host/xhci-tegra.c                                       |    8 
 drivers/usb/misc/ehset.c                                            |    8 
 drivers/usb/serial/option.c                                         |    6 
 drivers/usb/serial/usb-serial-simple.c                              |   73 +-
 drivers/usb/typec/class.c                                           |   15 
 drivers/xen/grant-table.c                                           |   40 -
 drivers/xen/xenbus/xenbus_probe.c                                   |    3 
 fs/btrfs/block-rsv.c                                                |    5 
 fs/btrfs/qgroup.c                                                   |   18 
 fs/btrfs/transaction.c                                              |   10 
 fs/ceph/metric.c                                                    |    2 
 fs/file.c                                                           |    6 
 fs/jbd2/checkpoint.c                                                |   32 
 fs/nfsd/nfs4state.c                                                 |    2 
 fs/overlayfs/inode.c                                                |    5 
 fs/proc/vmcore.c                                                    |    2 
 fs/smb/client/sess.c                                                |    4 
 include/linux/dma-fence.h                                           |    2 
 include/linux/pwm.h                                                 |    5 
 include/net/ipv6.h                                                  |    8 
 include/net/vxlan.h                                                 |   13 
 include/uapi/linux/blkzoned.h                                       |   10 
 io_uring/io_uring.c                                                 |    2 
 kernel/locking/rtmutex.c                                            |  170 +++-
 kernel/locking/rtmutex_api.c                                        |    2 
 kernel/locking/rtmutex_common.h                                     |   47 -
 kernel/locking/ww_mutex.h                                           |   12 
 kernel/signal.c                                                     |    4 
 kernel/trace/ring_buffer.c                                          |   22 
 kernel/trace/trace.c                                                |    2 
 kernel/trace/trace.h                                                |    6 
 kernel/trace/trace_events.c                                         |   14 
 kernel/trace/trace_events_hist.c                                    |    7 
 kernel/trace/trace_events_synth.c                                   |   80 ++
 kernel/trace/trace_probe.c                                          |   46 -
 kernel/trace/trace_probe.h                                          |   16 
 kernel/trace/trace_probe_kernel.h                                   |   30 
 kernel/trace/trace_probe_tmpl.h                                     |   59 +
 kernel/trace/trace_synth.h                                          |    1 
 kernel/trace/trace_uprobe.c                                         |    3 
 lib/test_firmware.c                                                 |   12 
 lib/test_maple_tree.c                                               |  233 ++++--
 net/ceph/messenger.c                                                |    1 
 net/ipv6/addrconf.c                                                 |   14 
 net/mptcp/protocol.c                                                |   20 
 net/netfilter/nf_tables_api.c                                       |   18 
 net/netfilter/nft_immediate.c                                       |   27 
 net/netfilter/nft_set_rbtree.c                                      |   20 
 net/sched/sch_mqprio.c                                              |  144 ++--
 net/tipc/crypto.c                                                   |    3 
 net/tipc/node.c                                                     |    2 
 sound/pci/hda/patch_realtek.c                                       |    2 
 sound/soc/codecs/wm8904.c                                           |    3 
 sound/soc/fsl/fsl_spdif.c                                           |    2 
 tools/testing/radix-tree/linux/init.h                               |    1 
 tools/testing/radix-tree/maple.c                                    |  147 ++--
 tools/testing/selftests/net/mptcp/mptcp_join.sh                     |    4 
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh                  |   24 
 virt/kvm/kvm_main.c                                                 |   24 
 234 files changed, 3171 insertions(+), 1774 deletions(-)

Adrien Thierry (2):
      phy: qcom-snps-femto-v2: keep cfg_ahb_clk enabled during runtime suspend
      phy: qcom-snps-femto-v2: properly enable ref clock

Agustin Gutierrez (1):
      drm/amd/display: Keep PHY active for dp config

Alexander Steffen (1):
      tpm_tis: Explicitly check for error code

Alvin Lee (1):
      drm/amd/display: Use min transition for all SubVP plane add/remove

Andi Shyti (2):
      i2c: nomadik: Remove unnecessary goto label
      i2c: nomadik: Use devm_clk_get_enabled()

Andy Shevchenko (2):
      pwm: Add a stub for devm_pwmchip_add()
      Revert "um: Use swap() to make code cleaner"

Arnd Bergmann (1):
      ata: pata_ns87415: mark ns87560_tf_read static

Bart Van Assche (1):
      block: Fix a source code comment in include/uapi/linux/blkzoned.h

Bartosz Golaszewski (1):
      gpio: mvebu: fix irq domain leak

Baskaran Kannan (1):
      hwmon: (k10temp) Enable AMD3255 Proc to show negative temperature

Benjamin Cheng (1):
      drm/amd/display: Write to correct dirty_rect

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

Christian Marangi (3):
      net: dsa: qca8k: fix search_and_insert wrong handling of new rule
      net: dsa: qca8k: fix broken search_and_del
      net: dsa: qca8k: fix mdb add/del case with 0 VID

Christophe JAILLET (2):
      i2c: nomadik: Remove a useless call in the remove function
      drm/i915: Fix an error handling path in igt_write_huge()

Claudio Imbrenda (1):
      KVM: s390: pv: fix index value of replaced ASCE

Cruise Hung (1):
      drm/amd/display: Update correct DCN314 register header

Dan Carpenter (7):
      phy: phy-mtk-dp: Fix an error code in probe()
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

Dmitry Baryshkov (1):
      drm/msm/dpu: drop enum dpu_core_perf_data_bus_id

Dmytro Laktyushkin (5):
      drm/amd/display: use low clocks for no plane configs
      drm/amd/display: fix unbounded requesting for high pixel rate modes on dcn315
      drm/amd/display: add pixel rate based CRB allocation support
      drm/amd/display: fix dcn315 single stream crb allocation
      drm/amd/display: set per pipe dppclk to 0 when dpp is off

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
      Linux 6.1.43

Guanghui Feng (1):
      ACPI/IORT: Remove erroneous id_count check in iort_node_get_rmr_info()

Guiting Shen (1):
      usb: ohci-at91: Fix the unhandle interrupt when resume

Hamza Mahfooz (2):
      drm/amd/display: add FB_DAMAGE_CLIPS support
      drm/amd/display: perform a bounds check before filling dirty rectangles

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

Huacai Chen (1):
      MIPS: Loongson: Fix build error when make modules_install

Hui Li (1):
      tty: fix hang on tty device with no_room set

Ilpo Järvinen (3):
      PCI/ASPM: Factor out pcie_wait_for_retrain()
      PCI/ASPM: Avoid link retraining race
      n_tty: Rename tail to old_tail in n_tty_read()

Ilya Dryomov (3):
      rbd: make get_lock_owner_info() return a single locker or NULL
      rbd: harden get_lock_owner_info() a bit
      rbd: retrieve and check lock owner twice before blocklisting

Jacob Keller (2):
      iavf: fix potential deadlock on allocation failure
      iavf: check for removal state before IAVF_FLAG_PF_COMMS_FAILED

Jakub Vanek (1):
      Revert "usb: dwc3: core: Enable AutoRetry feature in the controller"

Jason Wang (1):
      virtio-net: fix race between set queues and probe

Jedrzej Jagielski (1):
      ice: Fix memory management in ice_ethtool_fdir.c

Jerry Meng (1):
      USB: serial: option: support Quectel EM060K_128

Jiawen Wu (1):
      net: phy: marvell10g: fix 88x3310 power up

Jiaxun Yang (1):
      MIPS: Loongson: Move arch cflags to MIPS top level Makefile

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

Kashyap Desai (1):
      RDMA/bnxt_re: Prevent handling any completions after qp destroy

Kirill A. Shutemov (1):
      x86/traps: Fix load_unaligned_zeropad() handling for shared TDX memory

Krzysztof Kozlowski (1):
      phy: qcom-snps: correct struct qcom_snps_hsphy kerneldoc

Kyle Tso (3):
      usb: typec: Set port->pd before adding device for typec_port
      usb: typec: Iterate pds array when showing the pd list
      usb: typec: Use sysfs_emit_at when concatenating the string

Larry Finger (1):
      staging: r8712: Fix memory leak in _r8712_init_xmit_priv()

Liam R. Howlett (3):
      test_maple_tree: test modifications while iterating
      maple_tree: add __init and __exit to test module
      maple_tree: fix 32 bit mas_next testing

Lin Ma (1):
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

Masami Hiramatsu (Google) (4):
      tracing/probes: Add symstr type for dynamic events
      tracing/probes: Fix to avoid double count of the string length on the array
      Revert "tracing: Add "(fault)" name injection to kernel probes"
      tracing/probes: Fix to record 0-length data_loc in fetch_store_string*() if fails

Matthieu Baerts (2):
      selftests: mptcp: join: only check for ip6tables if needed
      selftests: mptcp: sockopt: use 'iptables-legacy' if available

Matus Gajdos (1):
      ASoC: fsl_spdif: Silence output on stop

Maxim Mikityanskiy (1):
      platform/x86: msi-laptop: Fix rfkill out-of-sync on MSI Wind U100

Menglong Dong (1):
      mptcp: introduce 'sk' to replace 'sock->sk' in mptcp_listen()

Michael Grzeschik (1):
      usb: gadget: core: remove unbalanced mutex_unlock in usb_gadget_activate

Ming Lei (3):
      ublk_drv: move ublk_get_device_from_id into ublk_ctrl_uring_cmd
      ublk: fail to start device if queue setup is interrupted
      ublk: fail to recover device if queue setup is interrupted

Mirsad Goran Todorovac (1):
      test_firmware: return ENOMEM instead of ENOSPC on failed memory allocation

Mohsen Tahmasebi (1):
      USB: serial: option: add Quectel EC200A module support

Muhammad Husaini Zulkifli (1):
      igc: Fix Kernel Panic during ndo_tx_timeout callback

Nicolas Dufresne (1):
      media: amphion: Fix firmware path to match linux-firmware

Oliver Neukum (2):
      USB: serial: simple: add Kaufmann RKS+CAN VCP
      Revert "xhci: add quirk for host controllers that don't update endpoint DCS"

Oliver Upton (2):
      KVM: arm64: Condition HW AF updates on config option
      arm64: errata: Mitigate Ampere1 erratum AC03_CPU_38 at stage-2

Ondrej Mosnacek (1):
      io_uring: don't audit the capability check in io_uring_create()

Pablo Neira Ayuso (4):
      netfilter: nf_tables: fix underflow in object reference counter
      netfilter: nf_tables: fix underflow in chain reference counter
      netfilter: nf_tables: skip immediate deactivate in _PREPARE_ERROR
      netfilter: nf_tables: disallow rule addition to bound chain via NFTA_RULE_CHAIN_ID

Paolo Abeni (2):
      mptcp: do not rely on implicit state check in mptcp_listen()
      mptcp: ensure subflow is unhashed before cleaning the backlog

Pavel Asyutchenko (1):
      ALSA: hda/realtek: Support ASUS G713PV laptop

Peter Zijlstra (1):
      locking/rtmutex: Fix task->pi_waiters integrity

Radhakrishna Sripada (1):
      drm/i915/dpt: Use shmem for dpt objects

Rafael J. Wysocki (3):
      ACPI: processor: perflib: Use the "no limit" frequency QoS
      ACPI: processor: perflib: Avoid updating frequency QoS unnecessarily
      cpufreq: intel_pstate: Drop ACPI _PSS states table patching

Randy Dunlap (1):
      drm/amd/display: fix dc/core/dc.c kernel-doc

Ricardo Ribalda (1):
      usb: xhci-mtk: set the dma max_seg_size

Rick Wertenbroek (3):
      PCI: rockchip: Remove writes to unused registers
      PCI: rockchip: Fix window mapping and address translation for endpoint
      PCI: rockchip: Don't advertise MSI-X in PCIe capabilities

Rob Clark (3):
      drm/msm/adreno: Fix snapshot BINDLESS_DATA size
      drm/msm: Switch idr_lock to spinlock
      drm/msm: Disallow submit with fence id 0

Rodrigo Siqueira (7):
      drm/amd/display: Check if link state is valid
      drm/amd/display: Rework context change check
      drm/amd/display: Enable new commit sequence only for DCN32x
      drm/amd/display: Copy DC context in the commit streams
      drm/amd/display: Include surface of unaffected streams
      drm/amd/display: Rework comments on dc file
      drm/amd/display: Add FAMS validation before trying to use it

Ross Lagerwall (1):
      blk-mq: Fix stall due to recursive flush plug

Ruihong Luo (1):
      serial: 8250_dw: Preserve original value of DLF register

Sakari Ailus (1):
      media: staging: atomisp: select V4L2_FWNODE

Samson Tam (1):
      drm/amd/display: add ODM case when looking for first split pipe

Samuel Holland (1):
      serial: sifive: Fix sifive_serial_console_setup() section

Sean Christopherson (3):
      KVM: Grab a reference to KVM for VM and vCPU stats file descriptors
      KVM: VMX: Don't fudge CR0 and CR4 for restricted L2 guest
      KVM: x86: Disallow KVM_SET_SREGS{2} if incoming CR0 is invalid

Shiraz Saleem (3):
      RDMA/irdma: Add missing read barriers
      RDMA/irdma: Fix data race on CQP completion stats
      RDMA/irdma: Fix data race on CQP request done

Shyam Sundar S K (2):
      platform/x86/amd/pmf: Notify OS power slider update
      platform/x86/amd/pmf: reduce verbosity of apmf_get_system_params

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

Steven Rostedt (Google) (2):
      tracing: Allow synthetic events to pass around stacktraces
      tracing: Fix trace_event_raw_event_synth() if else statement

Stewart Smith (1):
      tcp: Reduce chance of collisions in inet6_hashfn().

Suman Ghosh (1):
      octeontx2-af: Fix hash extraction enable configuration

Sunil Goutham (1):
      octeontx2-af: Removed unnecessary debug messages.

Thomas Bogendoerfer (1):
      RDMA/mthca: Fix crash when polling CQ for shared QPs

Thomas Hellström (2):
      drm/ttm: Don't print error message if eviction was interrupted
      drm/ttm: Don't leak a resource on eviction error

Tiezhu Yang (1):
      LoongArch: BPF: Fix check condition to call lu32id in move_imm()

Trond Myklebust (1):
      nfsd: Remove incorrect check in nfsd4_validate_stateid

Uwe Kleine-König (1):
      gpio: mvebu: Make use of devm_pwmchip_add

Vincent Whitchurch (1):
      net: stmmac: Apply redundant write work around on 4.xx too

Vladimir Oltean (2):
      net/sched: mqprio: refactor nlattr parsing to a separate function
      net/sched: mqprio: add extack to mqprio_parse_nlattr()

Wang Ming (1):
      i40e: Fix an NULL vs IS_ERR() bug for debugfs_create_dir()

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

Zhihao Cheng (2):
      ovl: fix null pointer dereference in ovl_permission()
      jbd2: Fix wrongly judgement for buffer head removing while doing checkpoint

Zqiang (1):
      USB: gadget: Fix the memory leak in raw_gadget driver

Łukasz Bartosik (1):
      USB: quirks: add quirk for Focusrite Scarlett

