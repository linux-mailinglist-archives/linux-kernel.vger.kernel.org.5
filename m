Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45D387A6038
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 12:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbjISKxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 06:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231967AbjISKwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 06:52:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A69CD0;
        Tue, 19 Sep 2023 03:51:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1734FC433C8;
        Tue, 19 Sep 2023 10:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695120705;
        bh=KXW2Doy4LEtoW8h6J6Lr/aiMXCXdXqoKrpxEacfR7kg=;
        h=From:To:Cc:Subject:Date:From;
        b=mBpWyux0QCIrQJFHhwwwXvlLtHgMcYrDkHXtD49ne6MlQvd+eiULf9MzCeLJ7U3sc
         g9R8sKpE+JL3/CljtWA9qxR1PtZFPiAmRRE1RBVC/hnSZ+BSMI+tCH4QWbxtS73CIw
         aBt1V4ynUUIJG2LAF4xT1yabbpJ9qpiZuFjyRMV0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.5.4
Date:   Tue, 19 Sep 2023 12:51:32 +0200
Message-ID: <2023091933-skied-almanac-b158@gregkh>
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

I'm announcing the release of the 6.5.4 kernel.

All users of the 6.5 kernel series must upgrade.

The updated 6.5.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.5.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/admin-guide/cgroup-v1/memory.rst                                                     |    2 
 Documentation/devicetree/bindings/clock/xlnx,versal-clk.yaml                                       |    2 
 Makefile                                                                                           |    4 
 arch/arc/include/asm/atomic-llsc.h                                                                 |    6 
 arch/arc/include/asm/atomic64-arcv2.h                                                              |    6 
 arch/arm/boot/dts/broadcom/bcm4708-linksys-ea6500-v2.dts                                           |    3 
 arch/arm/boot/dts/qcom/qcom-msm8974pro-sony-xperia-shinano-castor.dts                              |    8 
 arch/arm/boot/dts/samsung/exynos4210-i9100.dts                                                     |    4 
 arch/arm64/boot/dts/nvidia/tegra186.dtsi                                                           |    3 
 arch/arm64/boot/dts/nvidia/tegra194.dtsi                                                           |    3 
 arch/arm64/boot/dts/nvidia/tegra210.dtsi                                                           |    3 
 arch/arm64/boot/dts/nvidia/tegra234.dtsi                                                           |    3 
 arch/arm64/boot/dts/qcom/msm8953-xiaomi-vince.dts                                                  |    1 
 arch/arm64/boot/dts/renesas/rzg2l-smarc-som.dtsi                                                   |    4 
 arch/arm64/boot/dts/renesas/rzg2lc-smarc-som.dtsi                                                  |    2 
 arch/arm64/boot/dts/renesas/rzg2ul-smarc-som.dtsi                                                  |    4 
 arch/mips/Makefile                                                                                 |    6 
 arch/parisc/include/asm/led.h                                                                      |    4 
 arch/parisc/include/asm/mckinley.h                                                                 |    8 
 arch/s390/net/bpf_jit_comp.c                                                                       |   10 
 arch/sh/boards/mach-ap325rxa/setup.c                                                               |    2 
 arch/sh/boards/mach-ecovec24/setup.c                                                               |    6 
 arch/sh/boards/mach-kfr2r09/setup.c                                                                |    2 
 arch/sh/boards/mach-migor/setup.c                                                                  |    2 
 arch/sh/boards/mach-se/7724/setup.c                                                                |    6 
 arch/sh/drivers/push-switch.c                                                                      |    2 
 arch/x86/include/asm/virtext.h                                                                     |    6 
 arch/x86/kvm/svm/avic.c                                                                            |   59 +
 arch/x86/kvm/svm/nested.c                                                                          |    9 
 arch/x86/kvm/svm/sev.c                                                                             |   14 
 arch/x86/kvm/svm/svm.c                                                                             |   45 -
 arch/x86/kvm/vmx/vmx.c                                                                             |   21 
 block/blk-throttle.c                                                                               |   99 +-
 drivers/accel/ivpu/ivpu_jsm_msg.c                                                                  |    3 
 drivers/ata/ahci.c                                                                                 |    2 
 drivers/ata/pata_falcon.c                                                                          |   50 -
 drivers/ata/pata_ftide010.c                                                                        |    1 
 drivers/ata/sata_gemini.c                                                                          |    1 
 drivers/block/null_blk/main.c                                                                      |   12 
 drivers/bus/mhi/host/pm.c                                                                          |    5 
 drivers/char/tpm/tpm_crb.c                                                                         |    5 
 drivers/clk/imx/clk-pll14xx.c                                                                      |   13 
 drivers/clk/qcom/camcc-sc7180.c                                                                    |    2 
 drivers/clk/qcom/dispcc-sm8450.c                                                                   |   13 
 drivers/clk/qcom/dispcc-sm8550.c                                                                   |   13 
 drivers/clk/qcom/gcc-mdm9615.c                                                                     |    2 
 drivers/clk/qcom/lpasscc-sc7280.c                                                                  |   16 
 drivers/clk/qcom/mss-sc7180.c                                                                      |   13 
 drivers/clk/qcom/q6sstop-qcs404.c                                                                  |   15 
 drivers/clk/qcom/turingcc-qcs404.c                                                                 |   13 
 drivers/clocksource/arm_arch_timer.c                                                               |    7 
 drivers/dma/sh/rz-dmac.c                                                                           |   11 
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c                                                        |   26 
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c                                                   |    3 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c                                                  |    4 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c                                            |    7 
 drivers/gpu/drm/amd/display/dc/Makefile                                                            |    1 
 drivers/gpu/drm/amd/display/dc/core/dc.c                                                           |   68 +
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_mpc.c                                                   |    5 
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c                                                 |   11 
 drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c                                               |   25 
 drivers/gpu/drm/amd/display/modules/freesync/freesync.c                                            |    9 
 drivers/gpu/drm/ast/ast_post.c                                                                     |    2 
 drivers/gpu/drm/i915/gt/intel_engine_types.h                                                       |    1 
 drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c                                                  |    3 
 drivers/gpu/drm/i915/gvt/gtt.c                                                                     |   27 
 drivers/gpu/drm/i915/gvt/gtt.h                                                                     |    1 
 drivers/gpu/drm/i915/i915_request.c                                                                |    7 
 drivers/gpu/drm/mxsfb/mxsfb_kms.c                                                                  |    9 
 drivers/gpu/drm/virtio/virtgpu_submit.c                                                            |   32 
 drivers/hwspinlock/qcom_hwspinlock.c                                                               |    9 
 drivers/i3c/master/svc-i3c-master.c                                                                |    1 
 drivers/input/keyboard/tca6416-keypad.c                                                            |   31 
 drivers/input/misc/iqs7222.c                                                                       |    8 
 drivers/mailbox/qcom-ipcc.c                                                                        |    4 
 drivers/misc/fastrpc.c                                                                             |   22 
 drivers/mtd/nand/raw/brcmnand/brcmnand.c                                                           |  112 ++
 drivers/mtd/spi-nor/winbond.c                                                                      |    5 
 drivers/net/dsa/microchip/ksz_common.c                                                             |   16 
 drivers/net/dsa/sja1105/sja1105.h                                                                  |    4 
 drivers/net/dsa/sja1105/sja1105_dynamic_config.c                                                   |   93 +-
 drivers/net/dsa/sja1105/sja1105_main.c                                                             |  120 ++-
 drivers/net/dsa/sja1105/sja1105_spi.c                                                              |    4 
 drivers/net/ethernet/adi/adin1110.c                                                                |   10 
 drivers/net/ethernet/cadence/macb_main.c                                                           |    5 
 drivers/net/ethernet/freescale/enetc/enetc_pf.c                                                    |    2 
 drivers/net/ethernet/google/gve/gve_rx_dqo.c                                                       |    5 
 drivers/net/ethernet/hisilicon/hns3/hnae3.h                                                        |    1 
 drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c                                                 |    7 
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c                                                    |   19 
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c                                                 |    4 
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c                                             |   20 
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c                                         |   14 
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c                                            |    5 
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h                                            |    2 
 drivers/net/ethernet/intel/igb/igb.h                                                               |    4 
 drivers/net/ethernet/intel/igb/igb_main.c                                                          |   10 
 drivers/net/ethernet/intel/igbvf/igbvf.h                                                           |    4 
 drivers/net/ethernet/intel/igc/igc.h                                                               |    4 
 drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c                                                       |   28 
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c                                                    |    5 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c                                                |   21 
 drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c                                                 |    6 
 drivers/net/ethernet/marvell/octeontx2/nic/cn10k.h                                                 |    2 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c                                           |   43 -
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h                                           |    3 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c                                               |    7 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c                                             |   30 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.h                                             |    4 
 drivers/net/ethernet/mediatek/mtk_eth_soc.c                                                        |    3 
 drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/ct.c                                             |    4 
 drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/mirred.c                                         |    1 
 drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/pedit.c                                          |    4 
 drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/redirect_ingress.c                               |    1 
 drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/vlan.c                                           |    1 
 drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/vlan_mangle.c                                    |    4 
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c                                                    |    1 
 drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c                                         |   62 +
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c                                                  |   64 +
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.h                                                  |    8 
 drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c                                         |   75 +
 drivers/net/ethernet/microchip/vcap/vcap_api.c                                                     |   18 
 drivers/net/ethernet/renesas/rswitch.c                                                             |    8 
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c                                                  |   10 
 drivers/net/phy/micrel.c                                                                           |    9 
 drivers/net/usb/r8152.c                                                                            |    3 
 drivers/net/veth.c                                                                                 |    6 
 drivers/parisc/led.c                                                                               |    4 
 drivers/parisc/sba_iommu.c                                                                         |   10 
 drivers/pinctrl/intel/pinctrl-cherryview.c                                                         |    5 
 drivers/platform/mellanox/Kconfig                                                                  |    4 
 drivers/platform/mellanox/mlxbf-pmc.c                                                              |   41 -
 drivers/platform/mellanox/mlxbf-tmfifo.c                                                           |   90 +-
 drivers/pwm/pwm-atmel-tcb.c                                                                        |   64 -
 drivers/pwm/pwm-lpc32xx.c                                                                          |   16 
 drivers/regulator/raa215300.c                                                                      |   32 
 drivers/regulator/tps6287x-regulator.c                                                             |    2 
 drivers/regulator/tps6594-regulator.c                                                              |   31 
 drivers/s390/crypto/zcrypt_api.c                                                                   |    1 
 drivers/scsi/qla2xxx/qla_attr.c                                                                    |    2 
 drivers/scsi/qla2xxx/qla_dbg.c                                                                     |    2 
 drivers/scsi/qla2xxx/qla_def.h                                                                     |   21 
 drivers/scsi/qla2xxx/qla_dfs.c                                                                     |   10 
 drivers/scsi/qla2xxx/qla_gbl.h                                                                     |    1 
 drivers/scsi/qla2xxx/qla_init.c                                                                    |  234 +++---
 drivers/scsi/qla2xxx/qla_inline.h                                                                  |   57 +
 drivers/scsi/qla2xxx/qla_iocb.c                                                                    |    1 
 drivers/scsi/qla2xxx/qla_isr.c                                                                     |    7 
 drivers/scsi/qla2xxx/qla_mbx.c                                                                     |    7 
 drivers/scsi/qla2xxx/qla_nvme.c                                                                    |    3 
 drivers/scsi/qla2xxx/qla_os.c                                                                      |   26 
 drivers/scsi/qla2xxx/qla_target.c                                                                  |   14 
 drivers/soc/qcom/qmi_encdec.c                                                                      |    4 
 drivers/ufs/core/ufs_bsg.c                                                                         |    3 
 drivers/ufs/core/ufshcd.c                                                                          |   10 
 drivers/video/backlight/gpio_backlight.c                                                           |    3 
 drivers/video/backlight/lp855x_bl.c                                                                |   20 
 drivers/video/fbdev/ep93xx-fb.c                                                                    |    1 
 drivers/watchdog/Kconfig                                                                           |    2 
 drivers/watchdog/intel-mid_wdt.c                                                                   |    1 
 fs/btrfs/disk-io.c                                                                                 |    5 
 fs/btrfs/extent-tree.c                                                                             |   43 -
 fs/btrfs/file-item.c                                                                               |   34 
 fs/btrfs/file-item.h                                                                               |    6 
 fs/btrfs/inode.c                                                                                   |    7 
 fs/btrfs/raid56.c                                                                                  |    4 
 fs/btrfs/relocation.c                                                                              |   12 
 fs/btrfs/scrub.c                                                                                   |  152 ++--
 fs/btrfs/space-info.c                                                                              |    6 
 fs/btrfs/transaction.c                                                                             |   26 
 fs/btrfs/zoned.c                                                                                   |   16 
 fs/ext4/balloc.c                                                                                   |   15 
 fs/ext4/block_validity.c                                                                           |    8 
 fs/ext4/crypto.c                                                                                   |    4 
 fs/ext4/ext4.h                                                                                     |    2 
 fs/ext4/extents_status.c                                                                           |   44 -
 fs/ext4/file.c                                                                                     |   25 
 fs/f2fs/data.c                                                                                     |    8 
 fs/f2fs/f2fs.h                                                                                     |   24 
 fs/f2fs/inline.c                                                                                   |    3 
 fs/f2fs/segment.c                                                                                  |    2 
 fs/fuse/readdir.c                                                                                  |   10 
 fs/gfs2/aops.c                                                                                     |    4 
 fs/gfs2/log.c                                                                                      |   25 
 fs/jbd2/checkpoint.c                                                                               |   22 
 fs/jbd2/recovery.c                                                                                 |   12 
 fs/kernfs/dir.c                                                                                    |    4 
 fs/nfs/direct.c                                                                                    |   20 
 fs/nfs/pnfs_dev.c                                                                                  |    2 
 fs/smb/client/cached_dir.c                                                                         |    2 
 fs/smb/client/cifsglob.h                                                                           |    1 
 fs/smb/client/connect.c                                                                            |    1 
 fs/smb/client/fscache.c                                                                            |    2 
 fs/smb/client/smb2ops.c                                                                            |   11 
 fs/smb/client/smb2pdu.c                                                                            |   11 
 fs/smb/common/smb2pdu.h                                                                            |   22 
 include/linux/audit.h                                                                              |    2 
 include/linux/bpf.h                                                                                |   12 
 include/linux/export-internal.h                                                                    |    2 
 include/linux/ipv6.h                                                                               |    1 
 include/linux/micrel_phy.h                                                                         |    7 
 include/linux/phylink.h                                                                            |    4 
 include/linux/tca6416_keypad.h                                                                     |    1 
 include/net/ip.h                                                                                   |    3 
 include/net/ip6_fib.h                                                                              |    5 
 include/net/ip_fib.h                                                                               |    5 
 include/net/ip_tunnels.h                                                                           |   15 
 include/net/ipv6.h                                                                                 |    7 
 include/net/scm.h                                                                                  |   14 
 include/net/sock.h                                                                                 |   29 
 kernel/auditsc.c                                                                                   |    2 
 kernel/bpf/bpf_local_storage.c                                                                     |   49 -
 kernel/bpf/core.c                                                                                  |   10 
 kernel/bpf/syscall.c                                                                               |    2 
 kernel/bpf/trampoline.c                                                                            |    5 
 kernel/trace/bpf_trace.c                                                                           |   11 
 lib/idr.c                                                                                          |    2 
 lib/kunit/test.c                                                                                   |    3 
 lib/test_meminit.c                                                                                 |    2 
 lib/test_scanf.c                                                                                   |    2 
 mm/hugetlb_vmemmap.c                                                                               |   34 
 mm/memcontrol.c                                                                                    |   32 
 mm/mremap.c                                                                                        |    2 
 mm/vmscan.c                                                                                        |   13 
 net/can/j1939/socket.c                                                                             |   10 
 net/core/flow_dissector.c                                                                          |    3 
 net/core/skbuff.c                                                                                  |   10 
 net/core/skmsg.c                                                                                   |   12 
 net/core/sock.c                                                                                    |   27 
 net/handshake/netlink.c                                                                            |   18 
 net/hsr/hsr_forward.c                                                                              |    1 
 net/ipv4/devinet.c                                                                                 |   10 
 net/ipv4/fib_semantics.c                                                                           |    5 
 net/ipv4/fib_trie.c                                                                                |    3 
 net/ipv4/inet_hashtables.c                                                                         |   36 
 net/ipv4/ip_input.c                                                                                |    3 
 net/ipv4/ip_output.c                                                                               |    2 
 net/ipv4/ip_sockglue.c                                                                             |    2 
 net/ipv4/route.c                                                                                   |    1 
 net/ipv4/tcp.c                                                                                     |    4 
 net/ipv4/tcp_output.c                                                                              |    2 
 net/ipv4/udp.c                                                                                     |    6 
 net/ipv6/addrconf.c                                                                                |    2 
 net/ipv6/ip6_input.c                                                                               |    3 
 net/ipv6/ip6_output.c                                                                              |    2 
 net/ipv6/ping.c                                                                                    |    2 
 net/ipv6/raw.c                                                                                     |    2 
 net/ipv6/route.c                                                                                   |    3 
 net/ipv6/udp.c                                                                                     |    2 
 net/kcm/kcmsock.c                                                                                  |   15 
 net/mptcp/protocol.c                                                                               |   23 
 net/netfilter/nf_tables_api.c                                                                      |   54 +
 net/netfilter/nfnetlink_osf.c                                                                      |    8 
 net/netfilter/nft_exthdr.c                                                                         |   22 
 net/netfilter/nft_set_rbtree.c                                                                     |    8 
 net/sched/sch_fq_pie.c                                                                             |   27 
 net/sched/sch_plug.c                                                                               |    2 
 net/sched/sch_qfq.c                                                                                |   22 
 net/sctp/proc.c                                                                                    |    2 
 net/sctp/socket.c                                                                                  |   10 
 net/smc/smc_core.c                                                                                 |    2 
 net/socket.c                                                                                       |   15 
 net/tls/tls_sw.c                                                                                   |    4 
 net/unix/af_unix.c                                                                                 |    2 
 net/unix/scm.c                                                                                     |    6 
 net/xdp/xsk_diag.c                                                                                 |    3 
 scripts/dummy-tools/gcc                                                                            |    3 
 scripts/kconfig/preprocess.c                                                                       |    3 
 scripts/mod/modpost.c                                                                              |    9 
 scripts/package/mkspec                                                                             |    2 
 sound/soc/tegra/tegra210_sfc.c                                                                     |   31 
 sound/soc/tegra/tegra210_sfc.h                                                                     |    4 
 tools/build/Makefile.build                                                                         |   10 
 tools/mm/Makefile                                                                                  |    4 
 tools/perf/Documentation/perf-dlfilter.txt                                                         |   22 
 tools/perf/Makefile.perf                                                                           |    2 
 tools/perf/builtin-lock.c                                                                          |    1 
 tools/perf/builtin-script.c                                                                        |   22 
 tools/perf/builtin-top.c                                                                           |    1 
 tools/perf/builtin-trace.c                                                                         |    9 
 tools/perf/dlfilters/dlfilter-test-api-v2.c                                                        |  377 ++++++++++
 tools/perf/include/perf/perf_dlfilter.h                                                            |   11 
 tools/perf/pmu-events/Build                                                                        |    6 
 tools/perf/pmu-events/arch/arm64/ampere/ampereone/cache.json                                       |    3 
 tools/perf/pmu-events/arch/powerpc/power10/cache.json                                              |   47 -
 tools/perf/pmu-events/arch/powerpc/power10/floating_point.json                                     |   66 +
 tools/perf/pmu-events/arch/powerpc/power10/frontend.json                                           |  188 ----
 tools/perf/pmu-events/arch/powerpc/power10/marked.json                                             |  194 +++--
 tools/perf/pmu-events/arch/powerpc/power10/memory.json                                             |   91 --
 tools/perf/pmu-events/arch/powerpc/power10/metrics.json                                            |   56 -
 tools/perf/pmu-events/arch/powerpc/power10/others.json                                             |  209 -----
 tools/perf/pmu-events/arch/powerpc/power10/pipeline.json                                           |  269 +++++--
 tools/perf/pmu-events/arch/powerpc/power10/pmc.json                                                |  193 ++++-
 tools/perf/pmu-events/arch/powerpc/power10/translation.json                                        |   42 -
 tools/perf/pmu-events/jevents.py                                                                   |    2 
 tools/perf/tests/dlfilter-test.c                                                                   |   38 -
 tools/perf/tests/shell/stat_bpf_counters.sh                                                        |    4 
 tools/perf/tests/shell/stat_bpf_counters_cgrp.sh                                                   |   28 
 tools/perf/ui/browsers/hists.c                                                                     |   60 -
 tools/perf/util/annotate.c                                                                         |   10 
 tools/perf/util/bpf-filter.c                                                                       |   14 
 tools/perf/util/dlfilter.c                                                                         |   30 
 tools/perf/util/expr.c                                                                             |    4 
 tools/perf/util/header.c                                                                           |   42 -
 tools/perf/util/parse-events.c                                                                     |    4 
 tools/perf/util/parse-events.y                                                                     |  256 ++++--
 tools/perf/util/pmu.c                                                                              |    4 
 tools/testing/selftests/bpf/prog_tests/bpf_obj_pinning.c                                           |    5 
 tools/testing/selftests/bpf/prog_tests/sockmap_helpers.h                                           |   26 
 tools/testing/selftests/bpf/prog_tests/sockmap_listen.c                                            |    7 
 tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-dynstring.tc     |    2 
 tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic_event_syntax_errors.tc |    2 
 tools/testing/selftests/kselftest/runner.sh                                                        |    3 
 tools/testing/selftests/lib.mk                                                                     |    4 
 tools/testing/selftests/net/bind_wildcard.c                                                        |    2 
 315 files changed, 3884 insertions(+), 2307 deletions(-)

Adrian Hunter (1):
      perf dlfilter: Add al_cleanup()

Ahmad Fatoum (1):
      clk: imx: pll14xx: dynamically configure PLL for 393216000/361267200Hz

Aleksey Nasibulin (1):
      ARM: dts: BCM5301X: Extend RAM to full 256MB for Linksys EA6500 V2

Alex Henrie (1):
      net: ipv6/addrconf: avoid integer underflow in ipv6_create_tempaddr

Anand Jain (1):
      btrfs: use the correct superblock to compare fsid in btrfs_validate_super

Andreas Gruenbacher (2):
      gfs2: Switch to wait_event in gfs2_logd
      gfs2: low-memory forced flush fixes

Andrew Donnellan (1):
      lib/test_meminit: allocate pages up to order MAX_ORDER

Andrzej Hajda (1):
      drm/i915: mark requests for GuC virtual engines to avoid use-after-free

Andy Shevchenko (1):
      s390/zcrypt: don't leak memory if dev_set_name() fails

Ariel Marcovitch (1):
      idr: fix param name in idr_alloc_cyclic() doc

Arnaldo Carvalho de Melo (5):
      perf trace: Really free the evsel->priv area
      perf annotate bpf: Don't enclose non-debug code with an assert()
      perf dlfilter: Initialize addr_location before passing it to thread__find_symbol_fb()
      perf top: Don't pass an ERR_PTR() directly to perf_session__delete()
      perf lock: Don't pass an ERR_PTR() directly to perf_session__delete()

Arnd Bergmann (1):
      bpf: fix bpf_probe_read_kernel prototype mismatch

Artur Weber (1):
      backlight: lp855x: Initialize PWM state on first brightness change

Baokun Li (1):
      ext4: fix slab-use-after-free in ext4_es_insert_extent()

Bean Huo (1):
      scsi: ufs: core: Add advanced RPMB support where UFSHCI 4.0 does not support EHS length in UTRD

Bharath SM (1):
      cifs: update desired access while requesting for directory lease

Biju Das (2):
      regulator: raa215300: Change the scope of the variables {clkin_name, xin_name}
      regulator: raa215300: Fix resource leak in case of error

Björn Töpel (2):
      kselftest/runner.sh: Propagate SIGTERM to runner child
      selftests: Keep symlinks, when possible

Bodong Wang (1):
      mlx5/core: E-Switch, Create ACL FT for eswitch manager in switchdev mode

Boris Burkov (2):
      btrfs: fix start transaction qgroup rsv double free
      btrfs: free qgroup rsv on io failure

Brian Foster (1):
      ext4: drop dio overwrite only flag and associated warning

Chengming Zhou (1):
      null_blk: fix poll request timeout handling

Chris Lew (1):
      soc: qcom: qmi_encdec: Restrict string length in decode

Chris Paterson (1):
      arm64: dts: renesas: rzg2l: Fix txdv-skew-psec typos

Christian Marangi (1):
      hwspinlock: qcom: add missing regmap config for SFPB MMIO implementation

Christophe JAILLET (1):
      tpm_crb: Fix an error handling path in crb_acpi_add()

Ciprian Regus (1):
      net:ethernet:adi:adin1110: Fix forwarding offload

Corinna Vinschen (2):
      igb: disable virtualization features on 82580
      igb: clean up in all error paths when enabling SR-IOV

Damien Le Moal (2):
      ata: sata_gemini: Add missing MODULE_DESCRIPTION
      ata: pata_ftide010: Add missing MODULE_DESCRIPTION

Dmitry Baryshkov (1):
      clk: qcom: gcc-mdm9615: use proper parent for pll0_vote clock

Dmitry Torokhov (2):
      Input: tca6416-keypad - always expect proper IRQ number in i2c client
      Input: tca6416-keypad - fix interrupt enable disbalance

Duoming Zhou (1):
      sh: push-switch: Reorder cleanup operations to avoid use-after-free bug

Ekansh Gupta (2):
      misc: fastrpc: Fix remote heap allocation request
      misc: fastrpc: Fix incorrect DMA mapping unmap request

Eric Dumazet (13):
      net/sched: fq_pie: avoid stalls in fq_pie_timer()
      sctp: annotate data-races around sk->sk_wmem_queued
      ipv4: annotate data-races around fi->fib_dead
      net: read sk->sk_family once in sk_mc_loop()
      net/handshake: fix null-ptr-deref in handshake_nl_done_doit()
      net: use sk_forward_alloc_get() in sk_get_meminfo()
      net: annotate data-races around sk->sk_forward_alloc
      mptcp: annotate data-races around msk->rmem_fwd_alloc
      net: annotate data-races around sk->sk_tsflags
      net: annotate data-races around sk->sk_bind_phc
      gve: fix frag_list chaining
      ip_tunnels: use DEV_STATS_INC()
      ipv6: fix ip6_sock_set_addr_preferences() typo

Fangzhi Zuo (1):
      drm/amd/display: Temporary Disable MST DP Colorspace Property

Fedor Pchelkin (1):
      NFSv4/pnfs: minor fix for cleanup path in nfs4_get_device_info

Filipe Manana (1):
      btrfs: don't start transaction when joining with TRANS_JOIN_NOSTART

Florent CARLI (1):
      watchdog: advantech_ec_wdt: fix Kconfig dependencies

Florian Westphal (2):
      net: fib: avoid warn splat in flow dissector
      netfilter: nftables: exthdr: fix 4-byte stack OOB write

Gabe Teeger (1):
      drm/amd/display: Remove wait while locked

Geert Uytterhoeven (1):
      platform/mellanox: NVSW_SN2201 should depend on ACPI

Geetha sowjanya (1):
      octeontx2-af: Fix truncation of smq in CN10K NIX AQ enqueue mbox handler

Greg Kroah-Hartman (1):
      Linux 6.5.4

Guangguan Wang (1):
      net/smc: use smc_lgr_list.lock to protect smc_lgr_list.list iterate in smcr_port_add

Gurchetan Singh (1):
      drm/virtio: Conditionally allocate virtio_gpu_fence

Hamza Mahfooz (5):
      drm/amd/display: fix mode scaling (RMX_.*)
      Revert "drm/amd/display: Remove v_startup workaround for dcn3+"
      drm/amd/display: limit the v_startup workaround to ASICs older than DCN3.1
      drm/amd/display: prevent potential division by zero errors
      drm/amdgpu: register a dirty framebuffer callback for fbcon

Hangyu Hua (2):
      net: ethernet: mvpp2_main: fix possible OOB write in mvpp2_ethtool_get_rxnfc()
      net: ethernet: mtk_eth_soc: fix possible NULL pointer dereference in mtk_hwlro_get_fdir_all()

Hao Chen (2):
      net: hns3: fix byte order conversion issue in hclge_dbg_fd_tcam_read()
      net: hns3: fix debugfs concurrency issue between kfree buffer and read

Hayes Wang (1):
      r8152: check budget for r8152_poll()

Helge Deller (3):
      parisc: led: Fix LAN receive and transmit LEDs
      parisc: led: Reduce CPU overhead for disk & lan LED computation
      parisc: sba_iommu: Fix build warning if procfs if disabled

Hien Huynh (1):
      dmaengine: sh: rz-dmac: Fix destination and source data size setting

Ian Kent (1):
      kernfs: fix missing kernfs_iattr_rwsem locking

Ian Rogers (5):
      perf parse-events: Separate YYABORT and YYNOMEM cases
      perf parse-events: Move instances of YYABORT to YYNOMEM
      perf parse-events: Separate ENOMEM memory handling
      perf parse-events: Additional error reporting
      perf header: Fix missing PMU caps

Ilkka Koskinen (1):
      perf vendor events arm64: Remove L1D_CACHE_LMISS from AmpereOne list

Ilya Leoshkevich (1):
      s390/bpf: Pass through tail call counter in trampolines

Ivan Babrou (1):
      perf script: Print "cgroup" field on the same line as "comm"

Jaegeuk Kim (3):
      f2fs: get out of a repeat loop when getting a locked data page
      f2fs: flush inode if atomic file is aborted
      f2fs: avoid false alarm of circular locking

Jakub Kicinski (1):
      net: phylink: fix sphinx complaint about invalid literal

Jay Cornwall (1):
      drm/amdkfd: Add missing gfx11 MQD manager callbacks

Jeff LaBundy (1):
      Input: iqs7222 - configure power mode before triggering ATI

Jerome Neanne (1):
      regulator: tps6594-regulator: Fix random kernel crash

Jian Shen (1):
      net: hns3: fix tx timeout issue

Jianbo Liu (1):
      net/mlx5e: Clear mirred devices array if the rule is split

Jie Wang (1):
      net: hns3: remove GSO partial feature bit

Jijie Shao (1):
      net: hns3: fix invalid mutex between tc qdisc and dcb ets command issue

Jinjie Ruan (2):
      kunit: Fix wild-memory-access bug in kunit_free_suite_set()
      net: microchip: vcap api: Fix possible memory leak for vcap_dup_rule()

Jiri Pirko (3):
      net/mlx5: Give esw_offloads_load/unload_rep() "mlx5_" prefix
      net/mlx5: Rework devlink port alloc/free into init/cleanup
      net/mlx5: Push devlink port PF/VF init/cleanup calls out of devlink_port_register/unregister()

Jiri Slaby (1):
      kbuild: dummy-tools: make MPROFILE_KERNEL checks work on BE

Johan Hovold (7):
      clk: qcom: camcc-sc7180: fix async resume during probe
      clk: qcom: turingcc-qcs404: fix missing resume during probe
      clk: qcom: dispcc-sm8450: fix runtime PM imbalance on probe errors
      clk: qcom: dispcc-sm8550: fix runtime PM imbalance on probe errors
      clk: qcom: lpasscc-sc7280: fix missing resume during probe
      clk: qcom: q6sstop-qcs404: fix missing resume during probe
      clk: qcom: mss-sc7180: fix missing resume during probe

Johannes Weiner (1):
      memcontrol: ensure memcg acquired by id is properly set up

John Fastabend (1):
      bpf, sockmap: Fix skb refcnt race after locking changes

Jonathan Marek (1):
      mailbox: qcom-ipcc: fix incorrect num_chans counting

Josef Bacik (1):
      btrfs: set page extent mapped after read_folio in relocate_one_page

Justin Stitt (1):
      accel/ivpu: refactor deprecated strncpy

Kajol Jain (6):
      perf vendor events: Update the JSON/events descriptions for power10 platform
      perf vendor events: Drop some of the JSON/events for power10 platform
      perf vendor events: Drop STORES_PER_INST metric event for power10 platform
      perf vendor events: Move JSON/events to appropriate files for power10 platform
      perf vendor events: Update metric event names for power10 platform
      perf test stat_bpf_counters_cgrp: Fix shellcheck issue about logical operators

Kalesh Singh (1):
      Multi-gen LRU: avoid race in inc_min_seq()

Katya Orlova (1):
      smb: propagate error code of extract_sharename()

Konstantin Meskhidze (1):
      kconfig: fix possible buffer overflow

Krzysztof Kozlowski (5):
      ARM: dts: qcom: msm8974pro-castor: correct inverted X of touchscreen
      arm64: dts: qcom: msm8953-vince: drop duplicated touschreen parent interrupt
      ARM: dts: qcom: msm8974pro-castor: correct touchscreen function names
      ARM: dts: qcom: msm8974pro-castor: correct touchscreen syna,nosleep-mode
      dt-bindings: clock: xlnx,versal-clk: drop select:false

Kuniyuki Iwashima (10):
      af_unix: Fix msg_controllen test in scm_pidfd_recv() for MSG_CMSG_COMPAT.
      af_unix: Fix data-races around user->unix_inflight.
      af_unix: Fix data-race around unix_tot_inflight.
      af_unix: Fix data-races around sk->sk_shutdown.
      af_unix: Fix data race around sk->sk_err.
      tcp: Factorise sk_family-independent comparison in inet_bind2_bucket_match(_addr_any).
      tcp: Fix bind() regression for v4-mapped-v6 wildcard address.
      tcp: Fix bind() regression for v4-mapped-v6 non-wildcard address.
      selftest: tcp: Fix address length in bind_wildcard.c.
      kcm: Fix error handling for SOCK_DGRAM in kcm_sendmsg().

Liang Chen (1):
      veth: Fixing transmit return status for dropped packets

Liming Sun (2):
      platform/mellanox: mlxbf-tmfifo: Drop the Rx packet if no more descriptors
      platform/mellanox: mlxbf-tmfifo: Drop jumbo frames

Linus Torvalds (1):
      vm: fix move_vma() memory accounting being off

Linus Walleij (1):
      mtd: spi-nor: Correct flags for Winbond w25q128

Liu Jian (2):
      net: ipv4: fix one memleak in __inet_del_ifa()
      net/tls: do not free tls_rec on async operation in bpf_exec_tx_verdict()

Liu Ying (1):
      drm/mxsfb: Disable overlay plane in mxsfb_plane_overlay_atomic_disable()

Lukasz Majewski (1):
      net: phy: Provide Module 4 KSZ9477 errata (DS80000754C)

Luís Henriques (1):
      ext4: fix memory leaks in ext4_fname_{setup_filename,prepare_lookup}

Maciej W. Rozycki (2):
      MIPS: Only fiddle with CHECKFLAGS if `need-compiler'
      MIPS: Fix CONFIG_CPU_DADDI_WORKAROUNDS `modules_install' regression

Magnus Karlsson (1):
      xsk: Fix xsk_diag use-after-free error during socket cleanup

Manish Rangankar (1):
      scsi: qla2xxx: Remove unsupported ql2xenabledif option

Marco Felsch (1):
      clk: imx: pll14xx: align pdiv with reference manual

Martin KaFai Lau (2):
      bpf: bpf_sk_storage: Fix invalid wait context lockdep report
      bpf: bpf_sk_storage: Fix the missing uncharge in sk_omem_alloc

Masahiro Yamada (3):
      kbuild: rpm-pkg: define _arch conditionally
      kbuild: do not run depmod for 'make modules_sign'
      linux/export: fix reference to exported functions for parisc64

Melissa Wen (1):
      drm/amd/display: enable cursor degamma for DCN3+ DRM legacy gamma

Michael Schmitz (1):
      ata: pata_falcon: fix IO base selection for Q40

Michal Hocko (1):
      memcg: drop kmem.limit_in_bytes

Miquel Raynal (1):
      i3c: master: svc: Describe member 'saved_regs'

Muchun Song (1):
      mm: hugetlb_vmemmap: fix a race between vmemmap pmd split

Namhyung Kim (8):
      perf bpf-filter: Fix sample flag check with ||
      perf test stat_bpf_counters_cgrp: Enhance perf stat cgroup BPF counter test
      perf hists browser: Fix hierarchy mode header
      perf build: Update build rule for generated files
      perf test shell stat_bpf_counters: Fix test on Intel
      perf tools: Handle old data in PERF_RECORD_ATTR
      perf build: Include generated header files properly
      perf hists browser: Fix the number of entries for 'e' key

Naohiro Aota (2):
      btrfs: zoned: do not zone finish data relocation block group
      btrfs: zoned: re-enable metadata over-commit for zoned mode

Nathan Chancellor (1):
      lib: test_scanf: Add explicit type cast to result initialization in test_number_prefix()

Naveen N Rao (1):
      selftests/ftrace: Fix dependencies for some of the synthetic event tests

Nilesh Javali (1):
      scsi: qla2xxx: Fix smatch warn for qla_init_iocb_limit()

Oleksij Rempel (1):
      net: phy: micrel: Correct bit assignments for phy_device flags

Olga Zaborska (3):
      igc: Change IGC_MIN to allow set rx/tx value between 64 and 80
      igbvf: Change IGBVF_MIN to allow set rx/tx value between 64 and 80
      igb: Change IGB_MIN to allow set rx/tx value between 64 and 80

Pablo Neira Ayuso (2):
      netfilter: nft_set_rbtree: skip sync GC for new elements in this transaction
      netfilter: nf_tables: Unbreak audit log reset

Paul Cercueil (1):
      ARM: dts: samsung: exynos4210-i9100: Fix LCD screen's physical size

Pavel Kozlov (1):
      ARC: atomics: Add compiler barrier to atomic operations...

Petr Tesarik (1):
      sh: boards: Fix CEU buffer size passed to dma_declare_coherent_memory()

Phil Sutter (2):
      netfilter: nf_tables: Audit log setelem reset
      netfilter: nf_tables: Audit log rule reset

Qiang Yu (1):
      bus: mhi: host: Skip MHI reset if device is in RDDM

Qu Wenruo (3):
      btrfs: scrub: avoid unnecessary extent tree search preparing stripes
      btrfs: scrub: avoid unnecessary csum tree search preparing stripes
      btrfs: scrub: fix grouping of read IO

Quan Tian (1):
      net/ipv6: SKB symmetric hash should incorporate transport ports

Quinn Tran (12):
      scsi: qla2xxx: Adjust IOCB resource on qpair create
      scsi: qla2xxx: Limit TMF to 8 per function
      scsi: qla2xxx: Fix deletion race condition
      scsi: qla2xxx: fix inconsistent TMF timeout
      scsi: qla2xxx: Fix command flush during TMF
      scsi: qla2xxx: Fix erroneous link up failure
      scsi: qla2xxx: Turn off noisy message log
      scsi: qla2xxx: Fix session hang in gnl
      scsi: qla2xxx: Fix TMF leak through
      scsi: qla2xxx: Flush mailbox commands on chip reset
      scsi: qla2xxx: Error code did not return to upper layer
      scsi: qla2xxx: Fix firmware resource tracking

Raag Jadav (2):
      pinctrl: cherryview: fix address_space_handler() argument
      watchdog: intel-mid_wdt: add MODULE_ALIAS() to allow auto-load

Ratheesh Kannoth (1):
      octeontx2-pf: Fix page pool cache index corruption.

Sameer Pujar (1):
      arm64: tegra: Update AHUB clock parent and rate

Sascha Hauer (1):
      net: macb: fix sleep inside spinlock

Sean Christopherson (13):
      KVM: SVM: Don't defer NMI unblocking until next exit for SEV-ES guests
      x86/virt: Drop unnecessary check on extended CPUID level in cpu_has_svm()
      drm/i915/gvt: Verify pfn is "valid" before dereferencing "struct page"
      drm/i915/gvt: Put the page reference obtained by KVM's gfn_to_pfn()
      drm/i915/gvt: Drop unused helper intel_vgpu_reset_gtt()
      KVM: VMX: Refresh available regs and IDT vectoring info before NMI handling
      KVM: SVM: Take and hold ir_list_lock when updating vCPU's Physical ID entry
      KVM: SVM: Don't inject #UD if KVM attempts to skip SEV guest insn
      KVM: SVM: Get source vCPUs from source VM for SEV-ES intrahost migration
      KVM: nSVM: Check instead of asserting on nested TSC scaling support
      KVM: nSVM: Load L1's TSC multiplier based on L1 state, not L2 state
      KVM: SVM: Set target pCPU during IRTE update if target vCPU is running
      KVM: SVM: Skip VMSA init in sev_es_init_vmcb() if pointer is NULL

Sebastian Andrzej Siewior (2):
      bpf: Invoke __bpf_prog_exit_sleepable_recur() on recursion in kern_sys_bpf().
      bpf: Assign bpf_tramp_run_ctx::saved_run_ctx before recursion check.

Sheetal (2):
      ASoC: tegra: Fix SFC conversion for few rates
      arm64: tegra: Update AHUB clock parent and rate on Tegra234

Shigeru Yoshida (2):
      kcm: Destroy mutex in kcm_exit_net()
      kcm: Fix memory leak in error path of kcm_sendmsg()

Shravan Kumar Ramani (2):
      platform/mellanox: mlxbf-pmc: Fix potential buffer overflows
      platform/mellanox: mlxbf-pmc: Fix reading of unprogrammed events

Sriram Yagnaraman (2):
      ipv4: ignore dst hint for multipath routes
      ipv6: ignore dst hint for multipath routes

Steve French (1):
      send channel sequence number in SMB3 requests after reconnects

Thomas Zimmermann (2):
      fbdev/ep93xx-fb: Do not assign to struct fb_info.dev
      drm/ast: Fix DRAM init on AST2200

Toke Høiland-Jørgensen (1):
      veth: Update XDP feature set when bringing up device

Trond Myklebust (1):
      NFS: Fix a potential data corruption

Uwe Kleine-König (2):
      pwm: atmel-tcb: Harmonize resource allocation order
      pwm: atmel-tcb: Fix resource freeing in error path and remove

Vadim Fedorenko (1):
      ixgbe: fix timestamp configuration code

Vincent Whitchurch (2):
      regulator: tps6287x: Fix n_voltages
      net: stmmac: fix handling of zero coalescing tx-usecs

Vladimir Oltean (9):
      net: dsa: sja1105: fix bandwidth discrepancy between tc-cbs software and offload
      net: dsa: sja1105: fix -ENOSPC when replacing the same tc-cbs too many times
      net: dsa: sja1105: complete tc-cbs offload support on SJA1110
      net: enetc: distinguish error from valid pointers in enetc_fixup_clear_rss_rfs()
      net: dsa: sja1105: hide all multicast addresses from "bridge fdb show"
      net: dsa: sja1105: propagate exact error code from sja1105_dynamic_config_poll_valid()
      net: dsa: sja1105: fix multicast forwarding working only for last added mdb entry
      net: dsa: sja1105: serialize sja1105_port_mcast_flood() with other FDB accesses
      net: dsa: sja1105: block FDB accesses that are concurrent with a switch reset

Vladimir Zapolskiy (1):
      pwm: lpc32xx: Remove handling of PWM channels

Walter Chang (1):
      clocksource/drivers/arm_arch_timer: Disable timer before programming CVAL

Wander Lairson Costa (1):
      netfilter: nfnetlink_osf: avoid OOB read

Wang Jianjian (1):
      ext4: add correct group descriptors and reserved GDT blocks to system zone

Wenjing Liu (1):
      drm/amd/display: always switch off ODM before committing more streams

Werner Fischer (1):
      ata: ahci: Add Elkhart Lake AHCI controller

Wesley Chalmers (1):
      drm/amd/display: Fix a bug when searching for insert_above_mpcc

William Zhang (4):
      mtd: rawnand: brcmnand: Fix crash during the panic_write
      mtd: rawnand: brcmnand: Fix potential out-of-bounds access in oob write
      mtd: rawnand: brcmnand: Fix potential false time out warning
      mtd: rawnand: brcmnand: Fix ECC level field setting for v7.2 controller

Xie XiuQi (1):
      tools/mm: fix undefined reference to pthread_once

Xu Kuohai (1):
      selftests/bpf: Fix a CI failure caused by vsock write

Yang Yingliang (1):
      net: ethernet: adi: adin1110: use eth_broadcast_addr() to assign broadcast address

Ying Liu (1):
      backlight: gpio_backlight: Drop output GPIO direction check for initial power state

Yisen Zhuang (1):
      net: hns3: fix the port information display when sfp is absent

Yonghong Song (1):
      selftests/bpf: Fix flaky cgroup_iter_sleepable subtest

Yoshihiro Shimoda (1):
      net: renesas: rswitch: Fix unmasking irq condition

Yu Kuai (2):
      blk-throttle: use calculate_io/bytes_allowed() for throtl_trim_slice()
      blk-throttle: consider 'carryover_ios/bytes' in throtl_trim_slice()

Zhang Yi (2):
      jbd2: fix checkpoint cleanup performance regression
      jbd2: correct the end of the journal recovery scan range

Zhihao Cheng (1):
      jbd2: check 'jh->b_transaction' before removing it from checkpoint

Ziyang Xuan (1):
      hsr: Fix uninit-value access in fill_frame_info()

ruanmeisi (1):
      fuse: nlookup missing decrement in fuse_direntplus_link

valis (1):
      net: sched: sch_qfq: Fix UAF in qfq_dequeue()

