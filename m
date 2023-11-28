Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3327FC206
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:16:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345678AbjK1RVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 12:21:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232982AbjK1RVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 12:21:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B54A610F4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 09:21:34 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4A44C433CC;
        Tue, 28 Nov 2023 17:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1701192094;
        bh=bNeSgrONMFsGqambWUyMI/hlcl2JNIaeUmdr8IHesyM=;
        h=From:To:Cc:Subject:Date:From;
        b=bzP/nxeoAN51aR/PXTaAAnY8BHxTuG7dnIBZmkBdu/Fu+m/HpS1uSA4jlMsU7fpgD
         pJDcFtjc7bEc2afBwzL54hLeIhXexTlyoRjEbwAZQgMPeezVSbpnTqLe/6VJ0wVutU
         0Djn+YdSsCFGTpeQDcjuqRDrr6/bVYMHRD1WeRQs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.15.140
Date:   Tue, 28 Nov 2023 17:21:26 +0000
Message-ID: <2023112827-slogan-capitol-571e@gregkh>
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

I'm announcing the release of the 5.15.140 kernel.

All users of the 5.15 kernel series must upgrade.

The updated 5.15.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.15.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                   |    2 
 arch/arm/include/asm/exception.h                           |    4 
 arch/arm64/Kconfig                                         |    2 
 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi             |   46 +-
 arch/arm64/boot/dts/qcom/ipq6018.dtsi                      |   15 
 arch/parisc/include/uapi/asm/pdc.h                         |    1 
 arch/parisc/kernel/entry.S                                 |    7 
 arch/parisc/kernel/head.S                                  |    5 
 arch/powerpc/perf/core-book3s.c                            |    5 
 arch/powerpc/platforms/powernv/opal-prd.c                  |   17 
 arch/powerpc/platforms/pseries/iommu.c                     |   11 
 arch/riscv/kernel/probes/simulate-insn.c                   |    2 
 arch/s390/mm/page-states.c                                 |    6 
 arch/x86/crypto/sha1_ssse3_glue.c                          |   12 
 arch/x86/crypto/sha256_ssse3_glue.c                        |   12 
 arch/x86/include/asm/msr-index.h                           |    1 
 arch/x86/include/asm/numa.h                                |    7 
 arch/x86/kernel/cpu/hygon.c                                |    8 
 arch/x86/kvm/hyperv.c                                      |   10 
 arch/x86/kvm/x86.c                                         |    2 
 arch/x86/mm/numa.c                                         |    7 
 crypto/pcrypt.c                                            |    4 
 drivers/acpi/acpi_fpdt.c                                   |   45 ++
 drivers/acpi/resource.c                                    |   12 
 drivers/atm/iphase.c                                       |   20 -
 drivers/base/dd.c                                          |    4 
 drivers/base/regmap/regcache.c                             |   30 +
 drivers/block/virtio_blk.c                                 |    4 
 drivers/bluetooth/btusb.c                                  |   15 
 drivers/clk/qcom/gcc-ipq6018.c                             |    6 
 drivers/clk/qcom/gcc-ipq8074.c                             |    6 
 drivers/clk/socfpga/stratix10-clk.h                        |    4 
 drivers/clocksource/timer-atmel-tcb.c                      |    1 
 drivers/clocksource/timer-imx-gpt.c                        |   18 -
 drivers/cpufreq/cpufreq_stats.c                            |   14 
 drivers/dma/stm32-mdma.c                                   |    4 
 drivers/firmware/qcom_scm.c                                |    7 
 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c                   |    5 
 drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c                |    1 
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c                |    6 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                 |    3 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c                    |    9 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c                   |    2 
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c                       |   13 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c          |   13 
 drivers/gpu/drm/amd/display/dc/core/dc.c                   |   12 
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c            |    4 
 drivers/gpu/drm/amd/display/dc/dc.h                        |    5 
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h                |   22 -
 drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c            |   32 +
 drivers/gpu/drm/amd/include/pptable.h                      |    4 
 drivers/gpu/drm/amd/pm/amdgpu_pm.c                         |    8 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/pptable_v1_0.h      |   16 
 drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c |    9 
 drivers/gpu/drm/i915/gem/i915_gem_context.c                |    1 
 drivers/gpu/drm/i915/i915_perf.c                           |   15 
 drivers/gpu/drm/msm/dp/dp_panel.c                          |   21 -
 drivers/gpu/drm/panel/panel-arm-versatile.c                |    2 
 drivers/gpu/drm/panel/panel-sitronix-st7703.c              |   25 -
 drivers/gpu/drm/panel/panel-tpo-tpg110.c                   |    2 
 drivers/gpu/drm/qxl/qxl_display.c                          |    3 
 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c                    |    4 
 drivers/hid/hid-ids.h                                      |    1 
 drivers/hid/hid-lenovo.c                                   |   68 ++-
 drivers/hid/hid-quirks.c                                   |    1 
 drivers/i2c/busses/i2c-designware-master.c                 |   19 -
 drivers/i2c/busses/i2c-i801.c                              |   19 -
 drivers/i2c/busses/i2c-pxa.c                               |   76 +++-
 drivers/i2c/busses/i2c-sun6i-p2wi.c                        |    5 
 drivers/i2c/i2c-core.h                                     |    2 
 drivers/i2c/i2c-dev.c                                      |    4 
 drivers/i3c/master/i3c-master-cdns.c                       |    6 
 drivers/i3c/master/mipi-i3c-hci/dat_v1.c                   |   29 +
 drivers/i3c/master/mipi-i3c-hci/dma.c                      |    2 
 drivers/i3c/master/svc-i3c-master.c                        |   45 ++
 drivers/infiniband/hw/hfi1/pcie.c                          |    9 
 drivers/input/joystick/xpad.c                              |    1 
 drivers/mcb/mcb-core.c                                     |    1 
 drivers/mcb/mcb-parse.c                                    |    2 
 drivers/media/cec/platform/Makefile                        |    2 
 drivers/media/i2c/ccs/ccs-core.c                           |    2 
 drivers/media/i2c/ccs/ccs-quirk.h                          |    4 
 drivers/media/pci/cobalt/cobalt-driver.c                   |   11 
 drivers/media/platform/cadence/cdns-csi2rx.c               |    7 
 drivers/media/platform/qcom/camss/camss-vfe-170.c          |   22 -
 drivers/media/platform/qcom/camss/camss-vfe.c              |    5 
 drivers/media/platform/qcom/camss/camss.c                  |   12 
 drivers/media/platform/qcom/venus/hfi_msgs.c               |    2 
 drivers/media/platform/qcom/venus/hfi_parser.c             |   15 
 drivers/media/platform/qcom/venus/hfi_venus.c              |   10 
 drivers/media/rc/imon.c                                    |    6 
 drivers/media/rc/ir-sharp-decoder.c                        |    8 
 drivers/media/rc/lirc_dev.c                                |    6 
 drivers/media/test-drivers/vivid/vivid-rds-gen.c           |    2 
 drivers/media/usb/gspca/cpia1.c                            |    3 
 drivers/misc/pci_endpoint_test.c                           |    4 
 drivers/mmc/host/meson-gx-mmc.c                            |    1 
 drivers/mmc/host/sdhci-pci-gli.c                           |   22 +
 drivers/mmc/host/sdhci_am654.c                             |    2 
 drivers/mmc/host/vub300.c                                  |    1 
 drivers/mtd/chips/cfi_cmdset_0001.c                        |   20 +
 drivers/net/bonding/bond_main.c                            |    6 
 drivers/net/dsa/lan9303_mdio.c                             |    4 
 drivers/net/ethernet/atheros/atl1c/atl1c.h                 |    3 
 drivers/net/ethernet/atheros/atl1c/atl1c_main.c            |   67 ---
 drivers/net/ethernet/cortina/gemini.c                      |   45 +-
 drivers/net/ethernet/cortina/gemini.h                      |    4 
 drivers/net/ethernet/hisilicon/hns3/hclge_mbx.h            |   47 ++
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c            |    2 
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c    |   33 +
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c     |   62 +--
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_trace.h   |    2 
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  |   29 +
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h  |    3 
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_mbx.c   |   87 ++--
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_trace.h |    2 
 drivers/net/ethernet/mellanox/mlx5/core/en/mod_hdr.c       |   47 ++
 drivers/net/ethernet/mellanox/mlx5/core/en/mod_hdr.h       |   13 
 drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c   |    4 
 drivers/net/ethernet/mellanox/mlx5/core/en/tc/sample.c     |    5 
 drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c         |   25 -
 drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c        |   30 -
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c           |   12 
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c            |  234 +++++--------
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.h            |    5 
 drivers/net/ethernet/mellanox/mlx5/core/esw/indir_table.c  |    5 
 drivers/net/ethernet/realtek/r8169_main.c                  |   10 
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c          |    2 
 drivers/net/ipvlan/ipvlan_core.c                           |   41 +-
 drivers/net/macvlan.c                                      |    2 
 drivers/net/phy/phylink.c                                  |    1 
 drivers/net/ppp/ppp_synctty.c                              |    6 
 drivers/net/wireless/ath/ath10k/debug.c                    |    2 
 drivers/net/wireless/ath/ath10k/snoc.c                     |   18 -
 drivers/net/wireless/ath/ath11k/dp_rx.c                    |    8 
 drivers/net/wireless/ath/ath11k/wmi.c                      |   12 
 drivers/net/wireless/ath/ath9k/debug.c                     |    2 
 drivers/net/wireless/ath/ath9k/htc_drv_debug.c             |    2 
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c                |   14 
 drivers/net/wireless/mac80211_hwsim.c                      |    2 
 drivers/net/wireless/microchip/wilc1000/wlan.c             |    2 
 drivers/pci/controller/dwc/pci-exynos.c                    |    4 
 drivers/pci/controller/dwc/pci-keystone.c                  |    8 
 drivers/pci/controller/dwc/pcie-tegra194.c                 |    9 
 drivers/pci/pci-acpi.c                                     |    2 
 drivers/pci/pci-sysfs.c                                    |   10 
 drivers/pci/pci.c                                          |   13 
 drivers/pci/pcie/aspm.c                                    |    2 
 drivers/pci/quirks.c                                       |   35 +
 drivers/platform/x86/thinkpad_acpi.c                       |    1 
 drivers/ptp/ptp_chardev.c                                  |    3 
 drivers/ptp/ptp_clock.c                                    |    5 
 drivers/ptp/ptp_private.h                                  |    8 
 drivers/ptp/ptp_sysfs.c                                    |    3 
 drivers/s390/crypto/ap_bus.c                               |    4 
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c                     |   13 
 drivers/scsi/ibmvscsi/ibmvfc.c                             |  124 ++++++
 drivers/scsi/libfc/fc_lport.c                              |    6 
 drivers/scsi/megaraid/megaraid_sas_base.c                  |    4 
 drivers/scsi/mpt3sas/mpt3sas_base.c                        |    4 
 drivers/scsi/qla2xxx/qla_os.c                              |   12 
 drivers/tty/hvc/hvc_xen.c                                  |   39 +-
 drivers/tty/serial/meson_uart.c                            |   25 -
 drivers/tty/sysrq.c                                        |    3 
 drivers/tty/vcc.c                                          |   16 
 drivers/usb/gadget/function/f_ncm.c                        |   27 -
 drivers/usb/host/xhci-pci.c                                |    4 
 drivers/watchdog/sbsa_gwdt.c                               |    4 
 drivers/xen/events/events_base.c                           |    4 
 fs/9p/xattr.c                                              |    5 
 fs/btrfs/delalloc-space.c                                  |    3 
 fs/cifs/cifs_spnego.c                                      |    4 
 fs/cifs/smb2transport.c                                    |    5 
 fs/exfat/namei.c                                           |   29 +
 fs/ext4/acl.h                                              |    5 
 fs/ext4/extents_status.c                                   |    4 
 fs/ext4/resize.c                                           |   23 -
 fs/f2fs/compress.c                                         |    2 
 fs/gfs2/inode.c                                            |   14 
 fs/gfs2/quota.c                                            |   11 
 fs/gfs2/super.c                                            |    2 
 fs/jbd2/recovery.c                                         |    8 
 fs/jfs/jfs_dmap.c                                          |   23 +
 fs/jfs/jfs_imap.c                                          |    5 
 fs/ksmbd/smbacl.c                                          |   29 +
 fs/nfs/nfs4proc.c                                          |    5 
 fs/nfsd/nfs4state.c                                        |    2 
 fs/overlayfs/super.c                                       |    2 
 fs/proc/proc_sysctl.c                                      |    1 
 fs/quota/dquot.c                                           |   14 
 fs/xfs/libxfs/xfs_dir2_leaf.c                              |    9 
 fs/xfs/libxfs/xfs_inode_fork.c                             |    1 
 fs/xfs/libxfs/xfs_log_recover.h                            |   14 
 fs/xfs/libxfs/xfs_trans_resv.c                             |    2 
 fs/xfs/xfs_attr_inactive.c                                 |    8 
 fs/xfs/xfs_buf_item_recover.c                              |   66 +++
 fs/xfs/xfs_error.c                                         |    9 
 fs/xfs/xfs_inode.c                                         |    4 
 fs/xfs/xfs_log.c                                           |    9 
 fs/xfs/xfs_log_priv.h                                      |    3 
 fs/xfs/xfs_log_recover.c                                   |   44 +-
 fs/xfs/xfs_qm.c                                            |    7 
 fs/xfs/xfs_reflink.c                                       |  197 +++++++++-
 fs/xfs/xfs_sysfs.h                                         |    7 
 include/linux/ethtool.h                                    |    4 
 include/linux/lsm_hook_defs.h                              |    4 
 include/linux/preempt.h                                    |   36 +-
 include/linux/pwm.h                                        |    4 
 include/linux/string.h                                     |   40 ++
 include/linux/sunrpc/clnt.h                                |    1 
 include/linux/trace_events.h                               |    4 
 include/linux/trace_recursion.h                            |    8 
 include/linux/workqueue.h                                  |   46 ++
 include/net/inet_connection_sock.h                         |    2 
 include/net/inet_hashtables.h                              |   42 --
 include/net/netfilter/nf_tables.h                          |   19 -
 include/net/sock.h                                         |   26 +
 include/sound/soc-card.h                                   |   37 ++
 include/sound/soc.h                                        |   11 
 io_uring/io_uring.c                                        |   18 -
 kernel/audit_watch.c                                       |    9 
 kernel/bpf/core.c                                          |    6 
 kernel/bpf/verifier.c                                      |    9 
 kernel/debug/debug_core.c                                  |    3 
 kernel/events/internal.h                                   |    7 
 kernel/events/ring_buffer.c                                |    6 
 kernel/irq/generic-chip.c                                  |   25 +
 kernel/kexec.c                                             |    2 
 kernel/locking/test-ww_mutex.c                             |   20 -
 kernel/padata.c                                            |    2 
 kernel/power/snapshot.c                                    |   16 
 kernel/rcu/tree.c                                          |   21 +
 kernel/rcu/tree.h                                          |    4 
 kernel/rcu/tree_stall.h                                    |   20 +
 kernel/reboot.c                                            |    1 
 kernel/trace/ring_buffer.c                                 |    9 
 kernel/trace/trace.c                                       |   15 
 kernel/trace/trace.h                                       |    3 
 kernel/trace/trace_events.c                                |   43 +-
 kernel/trace/trace_events_filter.c                         |    3 
 kernel/trace/trace_events_synth.c                          |    2 
 kernel/watch_queue.c                                       |    2 
 kernel/watchdog.c                                          |    7 
 kernel/workqueue.c                                         |   20 -
 mm/cma.c                                                   |    2 
 mm/memcontrol.c                                            |    3 
 mm/memory_hotplug.c                                        |    2 
 net/9p/client.c                                            |    2 
 net/9p/trans_fd.c                                          |   13 
 net/bluetooth/hci_conn.c                                   |    6 
 net/bluetooth/hci_sysfs.c                                  |   23 -
 net/bridge/netfilter/nf_conntrack_bridge.c                 |    2 
 net/bridge/netfilter/nft_meta_bridge.c                     |    2 
 net/core/sock.c                                            |    2 
 net/dccp/proto.c                                           |    1 
 net/ipv4/inet_diag.c                                       |    5 
 net/ipv4/inet_hashtables.c                                 |  121 +-----
 net/ipv4/tcp.c                                             |    1 
 net/ipv4/tcp_ipv4.c                                        |   21 -
 net/ipv4/tcp_output.c                                      |    2 
 net/ipv6/inet6_hashtables.c                                |    5 
 net/mac80211/cfg.c                                         |    4 
 net/mptcp/mptcp_diag.c                                     |  105 +++++
 net/ncsi/ncsi-aen.c                                        |    5 
 net/netfilter/nf_tables_api.c                              |   53 ++
 net/netfilter/nft_byteorder.c                              |    6 
 net/netfilter/nft_meta.c                                   |    2 
 net/netfilter/nft_osf.c                                    |    2 
 net/netfilter/nft_socket.c                                 |    8 
 net/netfilter/nft_tproxy.c                                 |    6 
 net/netfilter/nft_xfrm.c                                   |    8 
 net/sunrpc/clnt.c                                          |    7 
 net/sunrpc/rpcb_clnt.c                                     |    4 
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c                    |    3 
 net/tipc/netlink_compat.c                                  |    1 
 net/unix/af_unix.c                                         |    9 
 scripts/gcc-plugins/randomize_layout_plugin.c              |   11 
 security/integrity/iint.c                                  |   48 ++
 security/integrity/ima/ima_api.c                           |    5 
 security/integrity/ima/ima_main.c                          |   16 
 security/integrity/integrity.h                             |    2 
 security/keys/trusted-keys/trusted_core.c                  |   20 -
 sound/core/info.c                                          |   21 -
 sound/hda/hdac_stream.c                                    |    6 
 sound/pci/hda/patch_realtek.c                              |   20 -
 sound/soc/codecs/lpass-wsa-macro.c                         |    3 
 sound/soc/ti/omap-mcbsp.c                                  |    6 
 tools/power/x86/turbostat/turbostat.c                      |    3 
 tools/testing/selftests/efivarfs/create-read.c             |    2 
 tools/testing/selftests/resctrl/cmt_test.c                 |    3 
 tools/testing/selftests/resctrl/mba_test.c                 |    2 
 tools/testing/selftests/resctrl/mbm_test.c                 |    2 
 292 files changed, 2756 insertions(+), 1345 deletions(-)

Ajay Singh (1):
      wifi: wilc1000: use vmm_table as array in wilc struct

Al Viro (1):
      gfs2: fix an oops in gfs2_permission

Alain Volmat (1):
      dmaengine: stm32-mdma: correct desc prep when channel running

Alex Deucher (1):
      drm/amdgpu: don't use ATRM for external devices

Alexander Sverdlin (1):
      net: dsa: lan9303: consequently nested-lock physical MDIO

Alexey Kardashevskiy (1):
      powerpc/pseries/ddw: simplify enable_ddw()

Amir Goldstein (1):
      ima: annotate iint mutex to avoid lockdep false positive warnings

Anastasia Belova (1):
      cifs: spnego: add ';' in HOST_KEY_LEN

Andreas Gruenbacher (1):
      gfs2: Silence "suspicious RCU usage in gfs2_permission" warning

Andrew Lunn (1):
      net: ethtool: Fix documentation of ethtool_sprintf()

Artem Lukyanov (1):
      Bluetooth: btusb: Add Realtek RTL8852BE support ID 0x0cb8:0xc559

Axel Lin (1):
      i2c: sun6i-p2wi: Prevent potential division by zero

Bartosz Pawlowski (2):
      PCI: Extract ATS disabling to a helper function
      PCI: Disable ATS for specific Intel IPU E2000 devices

Baruch Siach (1):
      net: stmmac: fix rx budget limit check

Bas Nieuwenhuizen (1):
      drm/amd/pm: Handle non-terminated overdrive commands.

Basavaraj Natikar (1):
      xhci: Enable RPM on controllers that support low-power states

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

Bryan O'Donoghue (4):
      media: qcom: camss: Fix pm_domain_on sequence in probe
      media: qcom: camss: Fix vfe_get() error jump
      media: qcom: camss: Fix VFE-17x vfe_disable_output()
      media: qcom: camss: Fix missing vfe_lite clocks check

Catalin Marinas (1):
      rcu: kmemleak: Ignore kmemleak false positives when RCU-freeing objects

Cezary Rojewski (1):
      ALSA: hda: Fix possible null-ptr-deref when assigning a stream

Chandan Babu R (1):
      xfs: Fix false ENOSPC when performing direct write on a delalloc extent in cow fork

Chandradeep Dey (1):
      ALSA: hda/realtek - Enable internal speaker of ASUS K6500ZC

Chandrakanth patil (1):
      scsi: megaraid_sas: Increase register read retry rount from 3 to 30 for selected registers

Chen Yu (1):
      tools/power/turbostat: Enable the C-state Pre-wake printing

Christian König (1):
      drm/amdgpu: fix error handling in amdgpu_bo_list_get()

Christian Marangi (1):
      cpufreq: stats: Fix buffer overflow detection in trans_stats()

Chuck Lever (1):
      svcrdma: Drop connection after an RDMA Read error

ChunHao Lin (1):
      r8169: fix network lost after resume on DASH systems

Dan Carpenter (4):
      pwm: Fix double shift bug
      SUNRPC: Add an IS_ERR() check back to where it was
      netfilter: nf_tables: fix pointer math issue in nft_byteorder_eval()
      mmc: vub300: fix an error code

Darren Hart (1):
      sbsa_gwdt: Calculate timeout with 64-bit math

Darrick J. Wong (8):
      xfs: refactor buffer cancellation table allocation
      xfs: don't leak xfs_buf_cancel structures when recovery fails
      xfs: convert buf_cancel_table allocation to kmalloc_array
      xfs: prevent a UAF when log IO errors race with unmount
      xfs: fix use-after-free in xattr node block inactivation
      xfs: don't leak memory when attr fork loading fails
      xfs: fix intermittent hang during quotacheck
      xfs: avoid a UAF when log intent item recovery fails

David Woodhouse (3):
      hvc/xen: fix console unplug
      hvc/xen: fix error path in xen_hvc_init() to always register frontend driver
      hvc/xen: fix event channel handling for secondary consoles

Dmitry Antipov (3):
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

Finn Thain (1):
      sched/core: Optimize in_task() and in_interrupt() a bit

Florian Westphal (4):
      mptcp: diag: switch to context structure
      mptcp: listen diag dump support
      netfilter: nf_tables: use the correct get/put helpers
      netfilter: nf_tables: add and use BE register load-store helpers

Frank Li (5):
      i3c: master: svc: fix race condition in ibi work thread
      i3c: master: svc: fix wrong data return when IBI happen during start frame
      i3c: master: svc: fix ibi may not return mandatory data byte
      i3c: master: svc: fix check wrong status register in irq handler
      i3c: master: svc: fix SDA keep low when polling IBIWON timeout happen

Frederic Weisbecker (1):
      workqueue: Provide one lock class key per work_on_cpu() callsite

Gao Xiang (1):
      xfs: add missing cmap->br_state = XFS_EXT_NORM update

Gavin Li (1):
      net/mlx5e: fix double free of encap_header in update funcs

Greg Kroah-Hartman (1):
      Linux 5.15.140

Guan Wentao (1):
      Bluetooth: btusb: Add 0bda:b85b for Fn-Link RTL8852BE

Guo Xuenan (1):
      xfs: fix exception caused by unexpected illegal bestcount in leaf dir

Gustavo A. R. Silva (1):
      clk: socfpga: Fix undefined behavior bug in struct stratix10_clock_data

Hans Verkuil (1):
      media: vivid: avoid integer overflow

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

Helge Deller (3):
      parisc/pdc: Add width field to struct pdc_model
      parisc: Prevent booting 64-bit kernels on PA1.x machines
      parisc/pgtable: Do not drop upper 5 address bits of physical address

Herve Codina (1):
      genirq/generic_chip: Make irq_remove_generic_chip() irqdomain aware

Ilpo Järvinen (7):
      RDMA/hfi1: Use FIELD_GET() to extract Link Width
      PCI: tegra194: Use FIELD_GET()/FIELD_PREP() with Link Width fields
      atm: iphase: Do PCI error checks on own line
      PCI: Use FIELD_GET() to extract Link Width
      media: cobalt: Use FIELD_GET() to extract Link Width
      selftests/resctrl: Remove duplicate feature check from CMT test
      selftests/resctrl: Reduce failures due to outliers in MBA/MBM tests

Jacky Bai (1):
      clocksource/drivers/timer-imx-gpt: Fix potential memory leak

Jani Nikula (1):
      drm/msm/dp: skip validity check for DP CTS EDID checksum

Jarkko Nikula (1):
      i3c: mipi-i3c-hci: Fix out of bounds access in hci_dma_irq_handler

Jarkko Sakkinen (1):
      KEYS: trusted: Rollback init_trusted() consistently

Jens Axboe (1):
      io_uring/fdinfo: lock SQ thread while retrieving thread cpu/pid

Jesse Zhang (1):
      drm/amdkfd: Fix shift out-of-bounds issue

Jian Shen (3):
      net: hns3: fix add VLAN fail issue
      net: hns3: refine the definition for struct hclge_pf_to_vf_msg
      net: hns3: fix incorrect capability bit display for copper port

Jie Wang (1):
      net: hns3: add byte order conversion for PF to VF mailbox message

Jijie Shao (2):
      net: hns3: fix VF reset fail issue
      net: hns3: fix VF wrong speed and duplex issue

Jiri Kosina (1):
      HID: Add quirk for Dell Pro Wireless Keyboard and Mouse KM5221W

Joel Fernandes (Google) (1):
      rcu/tree: Defer setting of jiffies during stall reset

Johan Hovold (3):
      wifi: ath11k: fix temperature event locking
      wifi: ath11k: fix dfs radar event locking
      wifi: ath11k: fix htt pktlog locking

John Stultz (1):
      locking/ww_mutex/test: Fix potential workqueue corruption

Johnathan Mantey (1):
      Revert ncsi: Propagate carrier gain/loss events to the NCSI controller

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

Kaixu Xia (1):
      xfs: use invalidate_lock to check the state of mmap_lock

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

Klaus Kudielka (1):
      net: phylink: initialize carrier state at creation

Krister Johansen (1):
      watchdog: move softlockup_panic back to early_param

Krzysztof Kozlowski (2):
      ASoC: codecs: wsa-macro: fix uninitialized stack variables with name prefix
      arm64: dts: qcom: ipq6018: switch TCSR mutex to MMIO

Kumar Kartikeya Dwivedi (1):
      bpf: Detect IP == ksym.end as part of BPF program

Kunwu Chan (1):
      drm/i915: Fix potential spectre vulnerability

Lad Prabhakar (1):
      serial: meson: Use platform_get_irq() to get the interrupt

Larry Finger (2):
      bluetooth: Add device 0bda:887b to device tables
      bluetooth: Add device 13d3:3571 to device tables

Laurentiu Tudor (1):
      arm64: dts: ls208xa: use a pseudo-bus to constrain usb dma size

Lewis Huang (1):
      drm/amd/display: Change the DMCUB mailbox memory location from FB to inbox

Li Zetao (1):
      xfs: Fix unreferenced object reported by kmemleak in xfs_sysfs_init()

Linkui Xiao (1):
      netfilter: nf_conntrack_bridge: initialize err to 0

Linus Walleij (4):
      net: ethernet: cortina: Fix max RX frame define
      net: ethernet: cortina: Handle large frames
      net: ethernet: cortina: Fix MTU max setting
      mtd: cfi_cmdset_0001: Byte swap OTP info

Lu Jialin (1):
      crypto: pcrypt - Fix hungtask for PADATA_RESET

Lukas Wunner (1):
      PCI/sysfs: Protect driver's D3cold preference from user space

Ma Ke (3):
      drm/panel: fix a possible null pointer dereference
      drm/panel/panel-tpo-tpg110: fix a possible null pointer dereference
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

Marek Szyprowski (1):
      media: cec: meson: always include meson sub-directory in Makefile

Mario Limonciello (2):
      drm/amd: Fix UBSAN array-index-out-of-bounds for SMU7
      drm/amd: Fix UBSAN array-index-out-of-bounds for Polaris and Tonga

Mark Brown (1):
      regmap: Ensure range selector registers are updated after cache sync

Martin KaFai Lau (3):
      net: inet: Remove count from inet_listen_hashbucket
      net: inet: Open code inet_hash2 and inet_unhash2
      net: inet: Retire port only listening_hash

Masum Reza (1):
      Bluetooth: btusb: Add RTW8852BE device 13d3:3570 to device tables

Max Kellermann (1):
      ext4: apply umask if ACL support is disabled

Michael Ellerman (1):
      powerpc/powernv: Fix fortify source warnings in opal-prd.c

Mike Rapoport (IBM) (1):
      x86/mm: Drop the 4 MB restriction on minimal NUMA node memory size

Mikhail Khvainitski (1):
      HID: lenovo: Detect quirk-free fw on cptkbd and stop applying workaround

Mimi Zohar (1):
      ima: detect changes to the backing overlay file

Miri Korenblit (1):
      wifi: iwlwifi: Use FW rate for non-data frames

Muhammad Usama Anjum (1):
      tty/sysrq: replace smp_processor_id() with get_cpu()

Nam Cao (1):
      riscv: kprobes: allow writing to x0

Namjae Jeon (1):
      ksmbd: fix slab out of bounds write in smb_inherit_dacl()

Nathan Chancellor (1):
      arm64: Restrict CPU_BIG_ENDIAN to GNU as or LLVM IAS 15.x or newer

Nicholas Piggin (1):
      powerpc/perf: Fix disabling BHRB and instruction sampling

Nicolas Saenz Julienne (1):
      KVM: x86: hyper-v: Don't auto-enable stimer on write from user-space

Nitin Yadav (1):
      mmc: sdhci_am654: fix start loop index for TAP value parsing

Olga Kornievskaia (1):
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

Paul Blakey (1):
      net/mlx5e: Refactor mod header management API

Paul Moore (2):
      audit: don't take task_lock() in audit_exe_compare() code path
      audit: don't WARN_ON_ONCE(!current->mm) in audit_exe_compare()

Pavel Krasavin (1):
      tty: serial: meson: fix hard LOCKUP on crtscts mode

Philipp Stanner (5):
      string.h: add array-wrappers for (v)memdup_user()
      kernel: kexec: copy user-array safely
      kernel: watch_queue: copy user-array safely
      drm: vmwgfx_surface.c: copy user-array safely
      i2c: dev: copy userspace array safely

Ping-Ke Shih (1):
      wifi: mac80211: don't return unset power in ieee80211_get_tx_power()

Pratyush Yadav (1):
      media: cadence: csi2rx: Unregister v4l2 async notifier

Pu Wen (1):
      x86/cpu/hygon: Fix the CPU topology evaluation for real

Qu Huang (1):
      drm/amdgpu: Fix a null pointer access when the smc_rreg pointer is NULL

Quinn Tran (1):
      scsi: qla2xxx: Fix system crash due to bad pointer access

Rahul Rameshbabu (1):
      net/mlx5e: Check return value of snprintf writing to fw_version buffer for representors

Rajeshwar R Shinde (1):
      media: gspca: cpia1: shift-out-of-bounds in set_flicker

Ranjan Kumar (1):
      scsi: mpt3sas: Fix loop logic

Richard Fitzgerald (1):
      ASoC: soc-card: Add storage for PCI SSID

Robert Marko (1):
      Revert "i2c: pxa: move to generic GPIO recovery"

Roi Dayan (2):
      net/mlx5e: Remove incorrect addition of action fwd flag
      net/mlx5e: Move mod hdr allocation to a single place

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

Shigeru Yoshida (2):
      tty: Fix uninit-value access in ppp_sync_receive()
      tipc: Fix kernel-infoleak due to uninitialized TLV value

Shuai Xue (1):
      perf/core: Bail out early if the request AUX area is out of bound

Shung-Hsi Yu (1):
      bpf: Fix precision tracking for BPF_ALU | BPF_TO_BE | BPF_END

Sieng-Piaw Liew (1):
      atl1c: Work around the DMA RX overflow issue

Stanislav Fomichev (1):
      net: set SOCK_RCU_FREE before inserting socket into hashtable

Stanley.Yang (1):
      drm/amdgpu: Fix potential null pointer derefernce

Steven Rostedt (Google) (2):
      tracing: Have the user copy of synthetic event address use correct context
      tracing: Have trace_event_file have ref counters

Steven Rostedt (VMware) (2):
      tracing: Reuse logic from perf's get_recursion_context()
      tracing/perf: Add interrupt_context_level() helper

Su Hui (1):
      f2fs: avoid format-overflow warning

Takashi Iwai (2):
      media: imon: fix access to invalid resource for the second interface
      ALSA: info: Fix potential deadlock at disconnection

Tam Nguyen (1):
      i2c: designware: Disable TX_EMPTY irq while waiting for block length byte

Tony Lindgren (1):
      ASoC: ti: omap-mcbsp: Fix runtime PM underflow warnings

Trond Myklebust (1):
      SUNRPC: ECONNRESET might require a rebind

Tyrel Datwyler (1):
      scsi: ibmvfc: Remove BUG_ON in the case of an empty event pool

Uwe Kleine-König (3):
      PCI: exynos: Don't discard .remove() callback
      PCI: keystone: Don't discard .remove() callback
      PCI: keystone: Don't discard .probe() callback

Vasily Khoruzhick (1):
      ACPI: FPDT: properly handle invalid FPDT subtables

Vicki Pfau (1):
      Input: xpad - add VID for Turtle Beach controllers

Victor Shih (2):
      mmc: sdhci-pci-gli: A workaround to allow GL9750 to enter ASPM L1.2
      mmc: sdhci-pci-gli: GL9750: Mask the replay timer timeout of AER

Vignesh Viswanathan (2):
      arm64: dts: qcom: ipq6018: Fix hwlock index for SMEM
      arm64: dts: qcom: ipq6018: Fix tcsr_mutex register size

Vikash Garodia (4):
      media: venus: hfi: add checks to perform sanity on queue pointers
      media: venus: hfi_parser: Add check to keep the number of codecs within range
      media: venus: hfi: fix the check to handle session buffer requirement
      media: venus: hfi: add checks to handle capabilities from firmware

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

Xiaogang Chen (1):
      drm/amdkfd: Fix a race condition of vram buffer unref in svm code

Yi Yang (1):
      tty: vcc: Add check for kstrdup() in vcc_probe()

Yihang Li (1):
      scsi: hisi_sas: Set debugfs_dir pointer to NULL after removing debugfs

Yonglong Liu (2):
      net: hns3: add barrier in vf mailbox reply process
      net: hns3: fix variable may not initialized problem in hns3_init_mac_addr()

Yoshihiro Shimoda (1):
      misc: pci_endpoint_test: Add Device ID for R-Car S4-8 PCIe controller

Yuezhang Mo (1):
      exfat: support handle zero-size directory

Zeng Heng (1):
      xfs: fix memory leak in xfs_errortag_init

Zhang Rui (1):
      tools/power/turbostat: Fix a knl bug

Zhang Yi (2):
      xfs: flush inode gc workqueue before clearing agi bucket
      ext4: correct the start block of counting reserved clusters

ZhengHan Wang (1):
      Bluetooth: Fix double free in hci_conn_cleanup

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

hexiaole (1):
      xfs: fix inode reservation space for removing transaction

youwan Wang (1):
      Bluetooth: btusb: Add date->evt_skb is NULL check

zhenwei pi (1):
      virtio-blk: fix implicit overflow on virtio_max_dma_size

zhujun2 (1):
      selftests/efivarfs: create-read: fix a resource leak

