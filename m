Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C763D778BD8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 12:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235630AbjHKKTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 06:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235863AbjHKKSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 06:18:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C743C17;
        Fri, 11 Aug 2023 03:17:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 28AEA66EE4;
        Fri, 11 Aug 2023 10:17:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C090C433C9;
        Fri, 11 Aug 2023 10:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691749062;
        bh=j/r1lq65ggEloK25dSF1IJzdai1yyoWffT9gblTQ3WM=;
        h=From:To:Cc:Subject:Date:From;
        b=0qiVJOujjm5i5ovtBg7pTbDCN0PkLd902mFBCHmX1kj0hZxPIpM68xWeivN8f+0oc
         eLYh9zJ/9Z4bWvqh2J4RYhXKtu4D7oRoJcumJuwY/gPvE59oTduPf5RX3ssrklLZAN
         c3L02axDRLEKcuj/Xg4vZmbqxnRdjp1y4fkB596k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.10.190
Date:   Fri, 11 Aug 2023 12:17:34 +0200
Message-ID: <2023081135-stinging-brick-608f@gregkh>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm announcing the release of the 5.10.190 kernel.

All users of the 5.10 kernel series must upgrade.

The updated 5.10.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.10.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/admin-guide/security-bugs.rst                   |   39 
 Makefile                                                      |    2 
 arch/arm/boot/dts/imx6qdl.dtsi                                |    4 
 arch/arm/boot/dts/imx6sl.dtsi                                 |    3 
 arch/arm/boot/dts/imx6sll.dtsi                                |   26 
 arch/arm/boot/dts/imx6sx.dtsi                                 |    3 
 arch/arm/boot/dts/imx6ul.dtsi                                 |    2 
 arch/arm/boot/dts/imx7d.dtsi                                  |    6 
 arch/arm/boot/dts/imx7s.dtsi                                  |    2 
 arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts        |    2 
 arch/arm64/boot/dts/altera/socfpga_stratix10_socdk_nand.dts   |    2 
 arch/arm64/boot/dts/freescale/imx8mn-var-som.dtsi             |    2 
 arch/powerpc/include/asm/word-at-a-time.h                     |    2 
 arch/powerpc/mm/init_64.c                                     |    3 
 arch/s390/kernel/sthyi.c                                      |    6 
 arch/s390/kvm/intercept.c                                     |    9 
 arch/s390/mm/gmap.c                                           |    1 
 arch/x86/include/asm/cpufeatures.h                            |    1 
 arch/x86/include/asm/kprobes.h                                |   24 
 arch/x86/include/asm/processor.h                              |    2 
 arch/x86/kernel/cpu/amd.c                                     |   19 
 arch/x86/kernel/kprobes/core.c                                |  639 -
 arch/x86/kernel/traps.c                                       |    5 
 arch/x86/kvm/vmx/vmx.c                                        |   87 
 drivers/acpi/processor_perflib.c                              |   38 
 drivers/ata/pata_ns87415.c                                    |    2 
 drivers/base/power/power.h                                    |    8 
 drivers/base/power/runtime.c                                  |    6 
 drivers/base/power/wakeirq.c                                  |  111 
 drivers/block/loop.c                                          |    3 
 drivers/char/tpm/tpm_tis_core.c                               |   10 
 drivers/cpufreq/intel_pstate.c                                |   14 
 drivers/gpio/gpio-tps68470.c                                  |    6 
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c                         |    2 
 drivers/gpu/drm/msm/adreno/a6xx_gpu_state.h                   |    2 
 drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.h                 |   13 
 drivers/gpu/drm/ttm/ttm_bo.c                                  |   16 
 drivers/gpu/drm/ttm/ttm_bo_util.c                             |    2 
 drivers/hwmon/nct7802.c                                       |    2 
 drivers/i2c/busses/i2c-ibm_iic.c                              |    4 
 drivers/i2c/busses/i2c-nomadik.c                              |   42 
 drivers/i2c/busses/i2c-sh7760.c                               |    3 
 drivers/i2c/busses/i2c-tiny-usb.c                             |    4 
 drivers/infiniband/hw/mlx4/qp.c                               |   18 
 drivers/infiniband/hw/mthca/mthca_qp.c                        |    2 
 drivers/irqchip/irq-bcm6345-l1.c                              |   14 
 drivers/irqchip/irq-gic-v3-its.c                              |   75 
 drivers/isdn/hardware/mISDN/hfcpci.c                          |   10 
 drivers/md/dm-cache-policy-smq.c                              |   28 
 drivers/md/dm-raid.c                                          |   20 
 drivers/md/md.c                                               |    2 
 drivers/mtd/nand/raw/fsl_upm.c                                |    2 
 drivers/mtd/nand/raw/meson_nand.c                             |    3 
 drivers/mtd/nand/raw/omap_elm.c                               |   24 
 drivers/mtd/nand/spi/toshiba.c                                |    4 
 drivers/net/Makefile                                          |    2 
 drivers/net/bonding/bond_main.c                               |    5 
 drivers/net/can/usb/gs_usb.c                                  |    2 
 drivers/net/dsa/bcm_sf2.c                                     |    8 
 drivers/net/ethernet/atheros/atl1e/atl1e_main.c               |    7 
 drivers/net/ethernet/emulex/benet/be_main.c                   |    3 
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c        |   60 
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c         |    3 
 drivers/net/ethernet/intel/i40e/i40e_debugfs.c                |    2 
 drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c             |   26 
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c                 |    2 
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.c |    4 
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c             |  103 
 drivers/net/ethernet/mellanox/mlx5/core/steering/dr_cmd.c     |    5 
 drivers/net/ethernet/socionext/netsec.c                       |   11 
 drivers/net/ethernet/xilinx/ll_temac_main.c                   |   16 
 drivers/net/phy/marvell10g.c                                  |    7 
 drivers/net/tap.c                                             |    2 
 drivers/net/team/team.c                                       |    9 
 drivers/net/tun.c                                             |    2 
 drivers/net/usb/cdc_ether.c                                   |   21 
 drivers/net/usb/usbnet.c                                      |    6 
 drivers/net/usb/zaurus.c                                      |   21 
 drivers/net/virtio_net.c                                      |    4 
 drivers/net/vxlan.c                                           | 4829 ----------
 drivers/net/vxlan/Makefile                                    |    7 
 drivers/net/vxlan/vxlan_core.c                                | 4826 +++++++++
 drivers/net/wireless/mediatek/mt76/mac80211.c                 |    8 
 drivers/net/wireless/mediatek/mt76/mt76.h                     |    2 
 drivers/net/wireless/mediatek/mt76/mt7603/eeprom.c            |    2 
 drivers/net/wireless/mediatek/mt76/mt7615/dma.c               |    2 
 drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c            |   22 
 drivers/net/wireless/mediatek/mt76/mt76x0/eeprom.c            |    6 
 drivers/net/wireless/mediatek/mt76/mt76x0/init.c              |    4 
 drivers/net/wireless/mediatek/mt76/mt76x0/phy.c               |    4 
 drivers/net/wireless/mediatek/mt76/mt76x02_eeprom.c           |    8 
 drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c            |    8 
 drivers/net/wireless/mediatek/mt76/mt7915/init.c              |    5 
 drivers/pci/pcie/aspm.c                                       |   55 
 drivers/phy/hisilicon/phy-hisi-inno-usb2.c                    |    2 
 drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c                 |   86 
 drivers/platform/x86/msi-laptop.c                             |    8 
 drivers/pwm/pwm-meson.c                                       |   25 
 drivers/s390/block/dasd_ioctl.c                               |    1 
 drivers/s390/net/qeth_core.h                                  |    1 
 drivers/s390/net/qeth_core_main.c                             |    2 
 drivers/s390/net/qeth_l2_main.c                               |    9 
 drivers/s390/net/qeth_l3_main.c                               |    8 
 drivers/s390/scsi/zfcp_fc.c                                   |    6 
 drivers/soundwire/bus.c                                       |   31 
 drivers/staging/ks7010/ks_wlan_net.c                          |    6 
 drivers/staging/media/atomisp/Kconfig                         |    1 
 drivers/staging/rtl8712/ieee80211.c                           |   12 
 drivers/staging/rtl8712/rtl871x_ioctl_linux.c                 |    8 
 drivers/staging/rtl8712/rtl871x_mlme.c                        |   10 
 drivers/staging/rtl8712/rtl871x_xmit.c                        |   46 
 drivers/staging/rtl8712/wifi.h                                |   15 
 drivers/staging/rtl8712/xmit_linux.c                          |    6 
 drivers/tty/n_gsm.c                                           |    4 
 drivers/tty/serial/8250/8250_dwlib.c                          |    6 
 drivers/tty/serial/qcom_geni_serial.c                         |    7 
 drivers/tty/serial/sifive.c                                   |    2 
 drivers/usb/core/quirks.c                                     |    4 
 drivers/usb/dwc3/core.c                                       |   20 
 drivers/usb/dwc3/core.h                                       |    3 
 drivers/usb/dwc3/dwc3-pci.c                                   |    6 
 drivers/usb/gadget/legacy/raw_gadget.c                        |   10 
 drivers/usb/gadget/udc/tegra-xudc.c                           |    8 
 drivers/usb/host/ohci-at91.c                                  |    8 
 drivers/usb/host/xhci-mtk.c                                   |    1 
 drivers/usb/host/xhci-tegra.c                                 |    8 
 drivers/usb/serial/option.c                                   |    6 
 drivers/usb/serial/usb-serial-simple.c                        |   73 
 fs/btrfs/ctree.c                                              |    2 
 fs/btrfs/qgroup.c                                             |   18 
 fs/btrfs/transaction.c                                        |   10 
 fs/ceph/mds_client.c                                          |    4 
 fs/ceph/mds_client.h                                          |    5 
 fs/ceph/metric.c                                              |    2 
 fs/ceph/super.c                                               |   10 
 fs/dlm/plock.c                                                |  100 
 fs/exfat/balloc.c                                             |    6 
 fs/exfat/dir.c                                                |   70 
 fs/exfat/exfat_fs.h                                           |    7 
 fs/exfat/namei.c                                              |    9 
 fs/ext2/ext2.h                                                |   12 
 fs/ext2/super.c                                               |   23 
 fs/ext4/ioctl.c                                               |    5 
 fs/file.c                                                     |   24 
 fs/nfsd/nfs4state.c                                           |    2 
 fs/open.c                                                     |    2 
 fs/super.c                                                    |   11 
 fs/sysv/itree.c                                               |    4 
 include/asm-generic/word-at-a-time.h                          |    2 
 include/drm/ttm/ttm_bo_api.h                                  |   28 
 include/linux/pm_wakeirq.h                                    |    9 
 include/linux/trace_events.h                                  |    4 
 include/net/ipv6.h                                            |    8 
 include/net/vxlan.h                                           |   17 
 include/trace/trace_events.h                                  |    2 
 include/uapi/linux/blkzoned.h                                 |   10 
 io_uring/io_uring.c                                           |   33 
 kernel/events/core.c                                          |    8 
 kernel/trace/bpf_trace.c                                      |    6 
 kernel/trace/ring_buffer.c                                    |   22 
 kernel/trace/trace.c                                          |   76 
 kernel/trace/trace.h                                          |    2 
 kernel/trace/trace_events.c                                   |   14 
 kernel/trace/trace_output.c                                   |   12 
 net/bluetooth/l2cap_sock.c                                    |    2 
 net/ceph/osd_client.c                                         |   20 
 net/core/bpf_sk_storage.c                                     |    5 
 net/core/rtnetlink.c                                          |    8 
 net/core/sock.c                                               |   21 
 net/core/sock_map.c                                           |    2 
 net/dcb/dcbnl.c                                               |    2 
 net/ipv4/tcp_metrics.c                                        |   70 
 net/ipv6/addrconf.c                                           |   14 
 net/ipv6/ip6mr.c                                              |    2 
 net/netfilter/nf_tables_api.c                                 |   20 
 net/netfilter/nft_immediate.c                                 |   27 
 net/netfilter/nft_set_rbtree.c                                |   20 
 net/sched/cls_fw.c                                            |    1 
 net/sched/cls_route.c                                         |    1 
 net/sched/cls_u32.c                                           |   57 
 net/sched/sch_mqprio.c                                        |  144 
 net/tipc/crypto.c                                             |    3 
 net/tipc/node.c                                               |    2 
 net/unix/af_unix.c                                            |    2 
 net/wireless/scan.c                                           |    2 
 sound/pci/hda/patch_realtek.c                                 |    1 
 sound/soc/codecs/cs42l51-i2c.c                                |    6 
 sound/soc/codecs/cs42l51.c                                    |    7 
 sound/soc/codecs/cs42l51.h                                    |    1 
 sound/soc/codecs/wm8904.c                                     |    3 
 sound/soc/fsl/fsl_spdif.c                                     |    2 
 tools/perf/tests/shell/test_uprobe_from_different_cu.sh       |    8 
 tools/testing/selftests/net/mptcp/config                      |    1 
 tools/testing/selftests/rseq/rseq.c                           |   31 
 194 files changed, 6995 insertions(+), 6018 deletions(-)

Adrien Thierry (2):
      phy: qcom-snps-femto-v2: keep cfg_ahb_clk enabled during runtime suspend
      phy: qcom-snps-femto-v2: properly enable ref clock

Alan Stern (1):
      net: usbnet: Fix WARNING in usbnet_start_xmit/usb_submit_urb

Aleksa Sarai (1):
      open: make RESOLVE_CACHED correctly test for O_TMPFILE

Alexander Aring (3):
      dlm: cleanup plock_op vs plock_xop
      dlm: rearrange async condition return
      fs: dlm: interrupt posix locks only when process is killed

Alexander Steffen (1):
      tpm_tis: Explicitly check for error code

Alexandra Winter (1):
      s390/qeth: Don't call dev_close/dev_open (DOWN/UP)

Andi Shyti (2):
      i2c: nomadik: Remove unnecessary goto label
      i2c: nomadik: Use devm_clk_get_enabled()

Andreas Kemnade (1):
      ARM: dts: imx6sll: fixup of operating points

Aneesh Kumar K.V (1):
      powerpc/mm/altmap: Fix altmap boundary check

Arnd Bergmann (1):
      ata: pata_ns87415: mark ns87560_tf_read static

Arseniy Krasnov (1):
      mtd: rawnand: meson: fix OOB available bytes for ECC

Bart Van Assche (2):
      block: Fix a source code comment in include/uapi/linux/blkzoned.h
      loop: Select I/O scheduler 'none' from inside add_disk()

Benjamin Poirier (1):
      vxlan: Fix nexthop hash size

Bjorn Helgaas (1):
      PCI/ASPM: Return 0 or -ETIMEDOUT from pcie_retrain_link()

Borislav Petkov (AMD) (1):
      x86/CPU/AMD: Do not leak quotient data after a division by 0

Chao Yu (1):
      ext4: fix to check return value of freeze_bdev() in ext4_shutdown()

Chaoyuan Peng (1):
      tty: n_gsm: fix UAF in gsm_cleanup_mux

Chengfeng Ye (1):
      mISDN: hfcpci: Fix potential deadlock on &hc->lock

Christian Brauner (1):
      file: always lock position for FMODE_ATOMIC_POS

Christian König (3):
      drm/ttm: add ttm_bo_pin()/ttm_bo_unpin() v2
      drm/ttm: never consider pinned BOs for eviction&swap
      drm/ttm: make ttm_bo_unpin more defensive

Christophe JAILLET (3):
      i2c: nomadik: Remove a useless call in the remove function
      staging: rtl8712: Use constants from <linux/ieee80211.h>
      mtd: rawnand: fsl_upm: Fix an off-by one test in fun_exec_op()

Chunfeng Yun (1):
      PM / wakeirq: support enabling wake-up irq after runtime_suspend called

Claudio Imbrenda (1):
      KVM: s390: pv: fix index value of replaced ASCE

Dan Carpenter (4):
      RDMA/mlx4: Make check for invalid flags stricter
      Revert "usb: gadget: tegra-xudc: Fix error check in tegra_xudc_powerdomain_init()"
      Revert "usb: xhci: tegra: Fix error check"
      net: ll_temac: fix error checking of irq_of_parse_and_map()

Dinh Nguyen (1):
      arm64: dts: stratix10: fix incorrect I2C property for SCL signal

Dmitry Baryshkov (1):
      drm/msm/dpu: drop enum dpu_core_perf_data_bus_id

Douglas Anderson (1):
      tracing: Fix sleeping while atomic in kdb ftdump

Eric Dumazet (12):
      net: annotate data-races around sk->sk_max_pacing_rate
      net: add missing READ_ONCE(sk->sk_rcvlowat) annotation
      net: add missing READ_ONCE(sk->sk_sndbuf) annotation
      net: add missing READ_ONCE(sk->sk_rcvbuf) annotation
      net: add missing data-race annotations around sk->sk_peek_off
      net: add missing data-race annotation for sk_ll_usec
      tcp_metrics: fix addr_same() helper
      tcp_metrics: annotate data-races around tm->tcpm_stamp
      tcp_metrics: annotate data-races around tm->tcpm_lock
      tcp_metrics: annotate data-races around tm->tcpm_vals[]
      tcp_metrics: annotate data-races around tm->tcpm_net
      tcp_metrics: fix data-race in tcpm_suck_dst() vs fastopen

Fedor Pchelkin (1):
      tipc: stop tipc crypto on failure in tipc_node_create

Filipe Manana (4):
      btrfs: fix race between quota disable and relocation
      btrfs: fix extent buffer leak after tree mod log failure at split_node()
      btrfs: check for commit error at btrfs_attach_transaction_barrier()
      btrfs: check if the transaction was aborted at btrfs_wait_for_commit()

Florian Westphal (1):
      netfilter: nft_set_rbtree: fix overlap expiration walk

Gaosheng Cui (1):
      drm/msm: Fix IS_ERR_OR_NULL() vs NULL check in a5xx_submit_in_rb()

Georg Müller (1):
      perf test uprobe_from_different_cu: Skip if there is no gcc

Gilles Buloz (1):
      hwmon: (nct7802) Fix for temp6 (PECI1) processed even if PECI1 disabled

Gratian Crisan (1):
      usb: dwc3: pci: skip BYT GPIO lookup table for hardwired phy

Greg Kroah-Hartman (3):
      Documentation: security-bugs.rst: update preferences when dealing with the linux-distros group
      Documentation: security-bugs.rst: clarify CVE handling
      Linux 5.10.190

Guangbin Huang (1):
      net: hns3: reconstruct function hclge_ets_validate()

Guchun Chen (1):
      drm/ttm: check null pointer before accessing when swapping

Guiting Shen (1):
      usb: ohci-at91: Fix the unhandle interrupt when resume

Gustavo A. R. Silva (2):
      kprobes/x86: Fix fall-through warnings for Clang
      mt76: mt7615: Fix fall-through warnings for Clang

Hangbin Liu (2):
      bonding: reset bond's flags when down link is P2P device
      team: reset team's flags when down link is P2P device

Hans de Goede (1):
      gpio: tps68470: Make tps68470_gpio_output() always set the initial value

Harshit Mogalapalli (1):
      phy: hisilicon: Fix an out of bounds check in hisi_inno_phy_probe()

Heiko Carstens (1):
      KVM: s390: fix sthyi error handling

Heiner Kallweit (1):
      pwm: meson: fix handling of period/duty if greater than UINT_MAX

Hugo Villeneuve (1):
      arm64: dts: imx8mn-var-som: add missing pull-up for onboard PHY reset pinmux

Hyeongseok Kim (1):
      exfat: speed up iterate/lookup by fixing start point of traversing cluster chain

Ilan Peer (1):
      wifi: cfg80211: Fix return value in scan logic

Ilpo Järvinen (2):
      PCI/ASPM: Factor out pcie_wait_for_retrain()
      PCI/ASPM: Avoid link retraining race

Ilya Dryomov (1):
      libceph: fix potential hang in ceph_osdc_notify()

Jakub Vanek (1):
      Revert "usb: dwc3: core: Enable AutoRetry feature in the controller"

Jamal Hadi Salim (1):
      net: sched: cls_u32: Fix match key mis-addressing

Jan Kara (2):
      fs: Protect reconfiguration of sb read-write from racing writes
      ext2: Drop fragment support

Jason Wang (1):
      virtio-net: fix race between set queues and probe

Jedrzej Jagielski (1):
      ice: Fix memory management in ice_ethtool_fdir.c

Jens Axboe (2):
      io_uring: treat -EAGAIN for REQ_F_NOWAIT as final for io-wq
      io_uring: gate iowait schedule on having pending requests

Jerry Meng (1):
      USB: serial: option: support Quectel EM060K_128

Jianbo Liu (2):
      net/mlx5: fs_core: Make find_closest_ft more generic
      net/mlx5: fs_core: Skip the FTs in the same FS_TYPE_PRIO_CHAINS fs_prio

Jiawen Wu (1):
      net: phy: marvell10g: fix 88x3310 power up

Jijie Shao (1):
      net: hns3: fix wrong bw weight of disabled tc issue

Jiri Benc (1):
      vxlan: calculate correct header length for GPE

Jiri Olsa (1):
      bpf: Disable preemption in bpf_event_output

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

Krzysztof Kozlowski (1):
      phy: qcom-snps: correct struct qcom_snps_hsphy kerneldoc

Larry Finger (1):
      staging: r8712: Fix memory leak in _r8712_init_xmit_priv()

Laszlo Ersek (2):
      net: tun_chr_open(): set sk_uid from current_fsuid()
      net: tap_open(): set sk_uid from current_fsuid()

Lin Ma (4):
      net/sched: mqprio: Add length check for TCA_MQPRIO_{MAX/MIN}_RATE64
      bpf: Add length check for SK_DIAG_BPF_STORAGE_REQ_MAP_FD parsing
      rtnetlink: let rtnl_bridge_setlink checks IFLA_BRIDGE_MODE length
      net: dcb: choose correct policy to parse DCB_ATTR_BCN

Linus Torvalds (1):
      file: reinstate f_pos locking optimization for regular files

Lorenzo Bianconi (1):
      mt76: move band capabilities in mt76_phy

Luka Guzenko (1):
      ALSA: hda/relatek: Enable Mute LED on HP 250 G8

Maciej Żenczykowski (1):
      ipv6 addrconf: fix bug where deleting a mngtmpaddr can create a new temporary address

Marc Kleine-Budde (1):
      can: gs_usb: gs_can_close(): add missing set of CAN state to CAN_STATE_STOPPED

Marc Zyngier (1):
      irqchip/gic-v4.1: Properly lock VPEs when doing a directLPI invalidation

Mark Brown (2):
      ASoC: wm8904: Fill the cache for WM8904_ADC_TEST_0 register
      net: netsec: Ignore 'phy-mode' on SynQuacer in DT mode

Markus Elfring (2):
      i2c: Delete error messages for failed memory allocations
      i2c: Improve size determinations

Masami Hiramatsu (6):
      tracing: Show real address for trace event arguments
      x86/kprobes: Do not decode opcode in resume_execution()
      x86/kprobes: Retrieve correct opcode for group instruction
      x86/kprobes: Identify far indirect JMP correctly
      x86/kprobes: Use int3 instead of debug trap for single-step
      x86/kprobes: Fix to identify indirect jmp and others using range case

Masami Hiramatsu (Google) (1):
      x86/kprobes: Update kcb status flag after singlestepping

Matthieu Baerts (1):
      selftests: mptcp: depend on SYN_COOKIES

Matus Gajdos (1):
      ASoC: fsl_spdif: Silence output on stop

Maxim Mikityanskiy (1):
      platform/x86: msi-laptop: Fix rfkill out-of-sync on MSI Wind U100

Michael Jeanson (1):
      selftests/rseq: check if libc rseq support is registered

Mohsen Tahmasebi (1):
      USB: serial: option: add Quectel EC200A module support

Nadav Amit (1):
      x86/kprobes: Fix JNG/JNLE emulation

Namjae Jeon (1):
      exfat: check if filename entries exceeds max filename length

Oliver Neukum (1):
      USB: serial: simple: add Kaufmann RKS+CAN VCP

Olivier Maignial (1):
      mtd: spinand: toshiba: Fix ecc_get_status

Ondrej Mosnacek (1):
      io_uring: don't audit the capability check in io_uring_create()

Pablo Neira Ayuso (3):
      netfilter: nftables: add helper function to validate set element data
      netfilter: nf_tables: skip immediate deactivate in _PREPARE_ERROR
      netfilter: nf_tables: disallow rule addition to bound chain via NFTA_RULE_CHAIN_ID

Paul Fertser (1):
      wifi: mt76: mt7615: do not advertise 5 GHz on first phy of MT7615D (DBDC)

Peng Fan (1):
      ARM: dts: imx: add usb alias

Peter Zijlstra (1):
      perf: Fix function pointer case

Pierre-Louis Bossart (2):
      soundwire: bus: add better dev_dbg to track complete() calls
      soundwire: bus: pm_runtime_request_resume on peripheral attachment

Prince Kumar Maurya (1):
      fs/sysv: Null check to prevent null-ptr-deref bug

Rafael J. Wysocki (3):
      ACPI: processor: perflib: Use the "no limit" frequency QoS
      ACPI: processor: perflib: Avoid updating frequency QoS unnecessarily
      cpufreq: intel_pstate: Drop ACPI _PSS states table patching

Ricardo Ribalda (1):
      usb: xhci-mtk: set the dma max_seg_size

Rob Clark (1):
      drm/msm/adreno: Fix snapshot BINDLESS_DATA size

Roger Quadros (1):
      mtd: rawnand: omap_elm: Fix incorrect type in assignment

Roopa Prabhu (1):
      vxlan: move to its own directory

Ross Maynard (1):
      USB: zaurus: Add ID for A-300/B-500/C-700

Ruihong Luo (1):
      serial: 8250_dw: Preserve original value of DLF register

Sakari Ailus (1):
      media: staging: atomisp: select V4L2_FWNODE

Samuel Holland (1):
      serial: sifive: Fix sifive_serial_console_setup() section

Sean Christopherson (5):
      KVM: VMX: Invert handling of CR0.WP for EPT without unrestricted guest
      KVM: VMX: Fold ept_update_paging_mode_cr0() back into vmx_set_cr0()
      KVM: nVMX: Do not clear CR3 load/store exiting bits if L1 wants 'em
      KVM: VMX: Don't fudge CR0 and CR4 for restricted L2 guest
      selftests/rseq: Play nice with binaries statically linked against glibc 2.35+

Stefan Haberland (1):
      s390/dasd: fix hanging device after quiesce/resume

Steffen Maier (1):
      scsi: zfcp: Defer fc_rport blocking until after ADISC response

Stewart Smith (1):
      tcp: Reduce chance of collisions in inet6_hashfn().

Sungjong Seo (1):
      exfat: release s_lock before calling dir_emit()

Sungwoo Kim (1):
      Bluetooth: L2CAP: Fix use-after-free in l2cap_sock_ready_cb

Thomas Bogendoerfer (1):
      RDMA/mthca: Fix crash when polling CQ for shared QPs

Thomas Petazzoni (1):
      ASoC: cs42l51: fix driver to properly autoload with automatic module loading

Tomas Glozar (1):
      bpf: sockmap: Remove preempt_disable in sock_map_sk_acquire

Trond Myklebust (1):
      nfsd: Remove incorrect check in nfsd4_validate_stateid

Uwe Kleine-König (1):
      pwm: meson: Simplify duplicated per-channel tracking

Vladimir Oltean (2):
      net/sched: mqprio: refactor nlattr parsing to a separate function
      net/sched: mqprio: add extack to mqprio_parse_nlattr()

Wang Ming (1):
      i40e: Fix an NULL vs IS_ERR() bug for debugfs_create_dir()

Wei Yongjun (1):
      x86/kprobes: Move 'inline' to the beginning of the kprobe_is_ss() declaration

Xiubo Li (2):
      ceph: never send metrics if disable_send_metrics is set
      ceph: defer stopping mdsc delayed_work

Xu Yang (1):
      ARM: dts: nxp/imx6sll: fix wrong property name in usbphy node

Yang Yingliang (1):
      net: ll_temac: Switch to use dev_err_probe() helper

Yu Kuai (3):
      dm raid: fix missing reconfig_mutex unlock in raid_ctr() error paths
      dm raid: clean up four equivalent goto tags in raid_ctr()
      dm raid: protect md_stop() with 'reconfig_mutex'

Yuan Can (1):
      phy: qcom-snps: Use dev_err_probe() to simplify code

Yuanjun Gong (5):
      ethernet: atheros: fix return value check in atl1e_tso_csum()
      benet: fix return value check in be_lancer_xmit_workarounds()
      tipc: check return value of pskb_trim()
      net/mlx5e: fix return value check in mlx5e_ipsec_remove_trailer()
      net: dsa: fix value check in bcm_sf2_sw_probe()

Yue Haibing (1):
      ip6mr: Fix skb_under_panic in ip6mr_cache_report()

Yuezhang Mo (1):
      exfat: support dynamic allocate bh for exfat_entry_set_cache

Zhang Shurong (1):
      staging: ks7010: potential buffer overflow in ks_wlan_set_encode_ext()

Zheng Yejian (2):
      ring-buffer: Fix wrong stat of cpu_buffer->read
      tracing: Fix warning in trace_buffered_event_disable()

Zhengchao Shao (1):
      net/mlx5: DR, fix memory leak in mlx5dr_cmd_create_reformat_ctx

Zqiang (1):
      USB: gadget: Fix the memory leak in raw_gadget driver

gaoming (1):
      exfat: use kvmalloc_array/kvfree instead of kmalloc_array/kfree

ndesaulniers@google.com (1):
      word-at-a-time: use the same return type for has_zero regardless of endianness

valis (3):
      net/sched: cls_u32: No longer copy tcf_result on update to avoid use-after-free
      net/sched: cls_fw: No longer copy tcf_result on update to avoid use-after-free
      net/sched: cls_route: No longer copy tcf_result on update to avoid use-after-free

Łukasz Bartosik (1):
      USB: quirks: add quirk for Focusrite Scarlett

