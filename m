Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15F7D7FC150
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:15:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345683AbjK1RVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 12:21:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345858AbjK1RVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 12:21:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD28A10EC
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 09:21:25 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDD40C433C7;
        Tue, 28 Nov 2023 17:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1701192085;
        bh=m1pQuxCMUOdHXv/Lj/ymW1iChY6ccvsi6+iPHrH0SCE=;
        h=From:To:Cc:Subject:Date:From;
        b=a+gIRcz3RCVd06rJuYb6AuHmlgwFO9CZZ4hHiBnfauIpJKxifQ/6hstDdGK3XGRlN
         VMrrkRdHwD+nC5V13bwvkGzt1nXQWbOsuI1Lw1OeZPzxK5CRJbDgNISFTnCcOklP8S
         VFPvaAnImDeFg7/Y56nl+qHISlLPpOLOCR6bsljs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.10.202
Date:   Tue, 28 Nov 2023 17:21:21 +0000
Message-ID: <2023112821-zoologist-wavy-3123@gregkh>
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

I'm announcing the release of the 5.10.202 kernel.

All users of the 5.10 kernel series must upgrade.

The updated 5.10.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.10.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                   |    2 
 arch/arm/include/asm/exception.h                           |    4 
 arch/arm64/Kconfig                                         |    2 
 arch/arm64/boot/dts/qcom/ipq6018.dtsi                      |   15 -
 arch/parisc/include/uapi/asm/pdc.h                         |    1 
 arch/parisc/kernel/entry.S                                 |    7 
 arch/parisc/kernel/head.S                                  |    5 
 arch/powerpc/perf/core-book3s.c                            |    5 
 arch/x86/include/asm/msr-index.h                           |    1 
 arch/x86/include/asm/numa.h                                |    7 
 arch/x86/kernel/cpu/hygon.c                                |    8 
 arch/x86/kvm/hyperv.c                                      |   10 -
 arch/x86/kvm/x86.c                                         |    2 
 arch/x86/mm/numa.c                                         |    7 
 crypto/pcrypt.c                                            |    4 
 drivers/acpi/resource.c                                    |   12 +
 drivers/atm/iphase.c                                       |   20 +-
 drivers/bluetooth/btusb.c                                  |   15 +
 drivers/clk/qcom/gcc-ipq6018.c                             |    6 
 drivers/clk/qcom/gcc-ipq8074.c                             |    6 
 drivers/clocksource/timer-atmel-tcb.c                      |    1 
 drivers/clocksource/timer-imx-gpt.c                        |   18 +-
 drivers/cpufreq/cpufreq_stats.c                            |   14 -
 drivers/dma/stm32-mdma.c                                   |    4 
 drivers/firmware/qcom_scm.c                                |    7 
 drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c                |    1 
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c                |    6 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                 |    3 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c                    |    9 -
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c          |   13 -
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c            |    4 
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h                |   22 +-
 drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c            |   32 ++-
 drivers/gpu/drm/amd/include/pptable.h                      |    4 
 drivers/gpu/drm/amd/pm/amdgpu_pm.c                         |    8 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/pptable_v1_0.h      |   16 -
 drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c |    9 -
 drivers/gpu/drm/msm/dp/dp_panel.c                          |   21 --
 drivers/gpu/drm/panel/panel-arm-versatile.c                |    2 
 drivers/gpu/drm/panel/panel-sitronix-st7703.c              |   25 +--
 drivers/gpu/drm/panel/panel-tpo-tpg110.c                   |    2 
 drivers/hid/hid-ids.h                                      |    1 
 drivers/hid/hid-lenovo.c                                   |   68 +++++---
 drivers/hid/hid-quirks.c                                   |    1 
 drivers/i2c/busses/i2c-designware-master.c                 |   19 +-
 drivers/i2c/busses/i2c-i801.c                              |   19 +-
 drivers/i2c/busses/i2c-sun6i-p2wi.c                        |    5 
 drivers/i2c/i2c-core.h                                     |    2 
 drivers/i3c/master/i3c-master-cdns.c                       |    6 
 drivers/infiniband/hw/hfi1/pcie.c                          |    9 -
 drivers/interconnect/qcom/bcm-voter.c                      |    5 
 drivers/interconnect/qcom/icc-rpmh.h                       |    2 
 drivers/mcb/mcb-core.c                                     |    1 
 drivers/mcb/mcb-parse.c                                    |    2 
 drivers/media/pci/cobalt/cobalt-driver.c                   |   11 -
 drivers/media/platform/qcom/camss/camss-vfe.c              |    2 
 drivers/media/platform/qcom/venus/hfi_msgs.c               |    2 
 drivers/media/platform/qcom/venus/hfi_parser.c             |   15 +
 drivers/media/platform/qcom/venus/hfi_venus.c              |   10 +
 drivers/media/rc/imon.c                                    |    6 
 drivers/media/rc/ir-sharp-decoder.c                        |    8 
 drivers/media/rc/lirc_dev.c                                |    6 
 drivers/media/test-drivers/vivid/vivid-rds-gen.c           |    2 
 drivers/media/usb/gspca/cpia1.c                            |    3 
 drivers/misc/pci_endpoint_test.c                           |    4 
 drivers/mmc/host/meson-gx-mmc.c                            |    1 
 drivers/mmc/host/sdhci_am654.c                             |    2 
 drivers/mmc/host/vub300.c                                  |    1 
 drivers/mtd/chips/cfi_cmdset_0001.c                        |   20 ++
 drivers/net/bonding/bond_main.c                            |    6 
 drivers/net/dsa/lan9303_mdio.c                             |    4 
 drivers/net/ethernet/cortina/gemini.c                      |   45 +++--
 drivers/net/ethernet/cortina/gemini.h                      |    4 
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c            |    2 
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  |   14 +
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h  |    1 
 drivers/net/ethernet/mellanox/mlx5/core/devlink.c          |    2 
 drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c        |   10 -
 drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c       |    4 
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c           |   13 -
 drivers/net/ethernet/mellanox/mlx5/core/ipoib/ethtool.c    |    2 
 drivers/net/ethernet/mellanox/mlx5/core/main.c             |   10 -
 drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h        |    3 
 drivers/net/ethernet/realtek/r8169_main.c                  |    4 
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c          |    2 
 drivers/net/ipvlan/ipvlan_core.c                           |   41 +++-
 drivers/net/macvlan.c                                      |    2 
 drivers/net/phy/phylink.c                                  |    1 
 drivers/net/ppp/ppp_synctty.c                              |    6 
 drivers/net/wireless/ath/ath10k/debug.c                    |    2 
 drivers/net/wireless/ath/ath10k/snoc.c                     |   18 +-
 drivers/net/wireless/ath/ath11k/dp_rx.c                    |    8 
 drivers/net/wireless/ath/ath11k/wmi.c                      |   12 +
 drivers/net/wireless/ath/ath9k/debug.c                     |    2 
 drivers/net/wireless/ath/ath9k/htc_drv_debug.c             |    2 
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c                |   14 +
 drivers/net/wireless/mac80211_hwsim.c                      |    2 
 drivers/pci/controller/dwc/pci-exynos.c                    |    4 
 drivers/pci/controller/dwc/pci-keystone.c                  |    8 
 drivers/pci/controller/dwc/pcie-tegra194.c                 |    9 -
 drivers/pci/pci-acpi.c                                     |    2 
 drivers/pci/pci-sysfs.c                                    |    5 
 drivers/pci/pcie/aspm.c                                    |    2 
 drivers/platform/x86/thinkpad_acpi.c                       |    1 
 drivers/ptp/ptp_chardev.c                                  |    3 
 drivers/ptp/ptp_clock.c                                    |    5 
 drivers/ptp/ptp_private.h                                  |    8 
 drivers/ptp/ptp_sysfs.c                                    |    3 
 drivers/scsi/libfc/fc_lport.c                              |    6 
 drivers/scsi/megaraid/megaraid_sas_base.c                  |    4 
 drivers/scsi/mpt3sas/mpt3sas_base.c                        |    4 
 drivers/tty/hvc/hvc_xen.c                                  |   37 +++-
 drivers/tty/serial/meson_uart.c                            |   33 ++-
 drivers/tty/sysrq.c                                        |    3 
 drivers/tty/vcc.c                                          |   16 +
 drivers/usb/gadget/function/f_ncm.c                        |   27 +--
 drivers/usb/host/xhci-pci.c                                |    4 
 drivers/usb/host/xhci-ring.c                               |  108 ++++++-------
 drivers/xen/events/events_base.c                           |    4 
 fs/btrfs/delalloc-space.c                                  |    3 
 fs/cifs/cifs_spnego.c                                      |    4 
 fs/cifs/smb2transport.c                                    |    5 
 fs/exfat/namei.c                                           |   29 ++-
 fs/ext4/acl.h                                              |    5 
 fs/ext4/extents_status.c                                   |    4 
 fs/ext4/resize.c                                           |   19 --
 fs/f2fs/compress.c                                         |    2 
 fs/gfs2/inode.c                                            |   14 +
 fs/gfs2/quota.c                                            |   11 +
 fs/gfs2/super.c                                            |    2 
 fs/jbd2/recovery.c                                         |    8 
 fs/jfs/jfs_dmap.c                                          |   23 ++
 fs/jfs/jfs_imap.c                                          |    5 
 fs/nfs/nfs4proc.c                                          |    5 
 fs/nfsd/nfs4state.c                                        |    2 
 fs/overlayfs/super.c                                       |    2 
 fs/proc/proc_sysctl.c                                      |    1 
 fs/quota/dquot.c                                           |   14 +
 include/linux/lsm_hook_defs.h                              |    4 
 include/linux/mlx5/driver.h                                |    2 
 include/linux/pwm.h                                        |    4 
 include/linux/sunrpc/clnt.h                                |    1 
 include/linux/trace_events.h                               |    4 
 include/net/netfilter/nf_tables.h                          |    3 
 include/net/sock.h                                         |   26 ++-
 include/sound/soc-card.h                                   |   37 ++++
 include/sound/soc.h                                        |   11 +
 include/uapi/linux/netfilter/nf_tables.h                   |    1 
 io_uring/io_uring.c                                        |   18 +-
 kernel/audit_watch.c                                       |    9 -
 kernel/bpf/core.c                                          |    6 
 kernel/bpf/verifier.c                                      |    9 -
 kernel/debug/debug_core.c                                  |    3 
 kernel/events/ring_buffer.c                                |    6 
 kernel/irq/generic-chip.c                                  |   25 ++-
 kernel/locking/test-ww_mutex.c                             |   20 +-
 kernel/padata.c                                            |    2 
 kernel/power/snapshot.c                                    |   16 -
 kernel/rcu/tree.c                                          |    9 +
 kernel/reboot.c                                            |    1 
 kernel/trace/trace.c                                       |   15 +
 kernel/trace/trace.h                                       |    3 
 kernel/trace/trace_events.c                                |   43 +++--
 kernel/trace/trace_events_filter.c                         |    3 
 kernel/watchdog.c                                          |    7 
 mm/cma.c                                                   |    2 
 mm/memcontrol.c                                            |    3 
 mm/memory_hotplug.c                                        |    2 
 net/9p/trans_fd.c                                          |   13 +
 net/bluetooth/hci_conn.c                                   |    6 
 net/bluetooth/hci_sysfs.c                                  |   23 +-
 net/bridge/netfilter/nf_conntrack_bridge.c                 |    2 
 net/core/sock.c                                            |    2 
 net/ipv4/tcp_output.c                                      |    2 
 net/mac80211/cfg.c                                         |    4 
 net/ncsi/ncsi-aen.c                                        |    5 
 net/netfilter/nf_tables_api.c                              |   62 +++++--
 net/sunrpc/clnt.c                                          |    7 
 net/sunrpc/rpcb_clnt.c                                     |    4 
 net/tipc/netlink_compat.c                                  |    1 
 scripts/gcc-plugins/randomize_layout_plugin.c              |   11 -
 security/integrity/ima/ima_api.c                           |    5 
 security/integrity/ima/ima_main.c                          |   16 +
 security/integrity/integrity.h                             |    2 
 sound/core/info.c                                          |   21 +-
 sound/hda/hdac_stream.c                                    |    6 
 sound/pci/hda/patch_realtek.c                              |   20 --
 sound/soc/ti/omap-mcbsp.c                                  |    6 
 tools/power/x86/turbostat/turbostat.c                      |    2 
 tools/testing/selftests/efivarfs/create-read.c             |    2 
 190 files changed, 1186 insertions(+), 614 deletions(-)

Al Viro (1):
      gfs2: fix an oops in gfs2_permission

Alain Volmat (1):
      dmaengine: stm32-mdma: correct desc prep when channel running

Alexander Sverdlin (1):
      net: dsa: lan9303: consequently nested-lock physical MDIO

Anastasia Belova (1):
      cifs: spnego: add ';' in HOST_KEY_LEN

Andreas Gruenbacher (1):
      gfs2: Silence "suspicious RCU usage in gfs2_permission" warning

Artem Lukyanov (1):
      Bluetooth: btusb: Add Realtek RTL8852BE support ID 0x0cb8:0xc559

Axel Lin (1):
      i2c: sun6i-p2wi: Prevent potential division by zero

Baruch Siach (1):
      net: stmmac: fix rx budget limit check

Bas Nieuwenhuizen (1):
      drm/amd/pm: Handle non-terminated overdrive commands.

Basavaraj Natikar (1):
      xhci: Enable RPM on controllers that support low-power states

Benjamin Bara (2):
      kernel/reboot: emergency_restart: Set correct system_state
      i2c: core: Run atomic i2c xfer when !preemptible

Bob Peterson (1):
      gfs2: ignore negated quota changes

Brian Geffon (2):
      PM: hibernate: Use __get_safe_page() rather than touching the list
      PM: hibernate: Clean up sync_read handling in snapshot_write_next()

Bryan O'Donoghue (1):
      media: qcom: camss: Fix vfe_get() error jump

Catalin Marinas (1):
      rcu: kmemleak: Ignore kmemleak false positives when RCU-freeing objects

Cezary Rojewski (1):
      ALSA: hda: Fix possible null-ptr-deref when assigning a stream

Chandradeep Dey (1):
      ALSA: hda/realtek - Enable internal speaker of ASUS K6500ZC

Chandrakanth patil (1):
      scsi: megaraid_sas: Increase register read retry rount from 3 to 30 for selected registers

Christian König (1):
      drm/amdgpu: fix error handling in amdgpu_bo_list_get()

Christian Marangi (1):
      cpufreq: stats: Fix buffer overflow detection in trans_stats()

Colin Ian King (1):
      serial: meson: remove redundant initialization of variable id

Dan Carpenter (3):
      pwm: Fix double shift bug
      SUNRPC: Add an IS_ERR() check back to where it was
      mmc: vub300: fix an error code

David Woodhouse (2):
      hvc/xen: fix console unplug
      hvc/xen: fix error path in xen_hvc_init() to always register frontend driver

Dmitry Antipov (3):
      wifi: mac80211_hwsim: fix clang-specific fortify warning
      wifi: ath9k: fix clang-specific fortify warnings
      wifi: ath10k: fix clang-specific fortify warning

Douglas Anderson (2):
      wifi: ath10k: Don't touch the CE interrupt registers after power up
      kgdb: Flush console before entering kgdb on panic

Dust Li (1):
      net/mlx5e: fix double free of encap_header

Ekaterina Esina (1):
      cifs: fix check of rc in function generate_smb3signingkey

Eric Biggers (1):
      quota: explicitly forbid quota files from being encrypted

Eric Dumazet (5):
      net: annotate data-races around sk->sk_tx_queue_mapping
      net: annotate data-races around sk->sk_dst_pending_confirm
      ipvlan: add ipvlan_route_v6_outbound() helper
      ptp: annotate data-race around q->head and q->tail
      bonding: stop the device in bond_setup_by_slave()

Greg Kroah-Hartman (1):
      Linux 5.10.202

Guan Wentao (1):
      Bluetooth: btusb: Add 0bda:b85b for Fn-Link RTL8852BE

Hans Verkuil (1):
      media: vivid: avoid integer overflow

Hao Sun (1):
      bpf: Fix check_stack_write_fixed_off() to correctly spill imm

Hardik Gajjar (1):
      usb: gadget: f_ncm: Always set current gadget in ncm_bind()

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

Ilpo Järvinen (4):
      RDMA/hfi1: Use FIELD_GET() to extract Link Width
      PCI: tegra194: Use FIELD_GET()/FIELD_PREP() with Link Width fields
      atm: iphase: Do PCI error checks on own line
      media: cobalt: Use FIELD_GET() to extract Link Width

Jacky Bai (1):
      clocksource/drivers/timer-imx-gpt: Fix potential memory leak

Jani Nikula (1):
      drm/msm/dp: skip validity check for DP CTS EDID checksum

Jens Axboe (1):
      io_uring/fdinfo: lock SQ thread while retrieving thread cpu/pid

Jijie Shao (1):
      net: hns3: fix VF reset fail issue

Jiri Kosina (1):
      HID: Add quirk for Dell Pro Wireless Keyboard and Mouse KM5221W

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

Kathiravan Thirumoorthy (3):
      clk: qcom: ipq8074: drop the CLK_SET_RATE_PARENT flag from PLL clocks
      clk: qcom: ipq6018: drop the CLK_SET_RATE_PARENT flag from PLL clocks
      firmware: qcom_scm: use 64-bit calling convention only when client is 64-bit

Kees Cook (1):
      randstruct: Fix gcc-plugin performance mode to stay in group

Kemeng Shi (3):
      ext4: correct offset of gdb backup in non meta_bg group to update_backups
      ext4: correct return value of ext4_convert_meta_bg
      ext4: remove gdb backup copy for meta bg in setup_new_flex_group_blocks

Klaus Kudielka (1):
      net: phylink: initialize carrier state at creation

Krister Johansen (1):
      watchdog: move softlockup_panic back to early_param

Krzysztof Kozlowski (1):
      arm64: dts: qcom: ipq6018: switch TCSR mutex to MMIO

Kumar Kartikeya Dwivedi (1):
      bpf: Detect IP == ksym.end as part of BPF program

Lad Prabhakar (1):
      serial: meson: Use platform_get_irq() to get the interrupt

Larry Finger (2):
      bluetooth: Add device 0bda:887b to device tables
      bluetooth: Add device 13d3:3571 to device tables

Leon Romanovsky (1):
      net/mlx5_core: Clean driver version and name

Lewis Huang (1):
      drm/amd/display: Change the DMCUB mailbox memory location from FB to inbox

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

Ma Ke (2):
      drm/panel: fix a possible null pointer dereference
      drm/panel/panel-tpo-tpg110: fix a possible null pointer dereference

Maciej S. Szmigiero (1):
      KVM: x86: Ignore MSR_AMD64_TW_CFG access

Mahmoud Adam (1):
      nfsd: fix file memleak on client_opens_release

Manas Ghandat (2):
      jfs: fix array-index-out-of-bounds in dbFindLeaf
      jfs: fix array-index-out-of-bounds in diAlloc

Marco Elver (1):
      9p/trans_fd: Annotate data-racy writes to file::f_flags

Mario Limonciello (2):
      drm/amd: Fix UBSAN array-index-out-of-bounds for SMU7
      drm/amd: Fix UBSAN array-index-out-of-bounds for Polaris and Tonga

Masum Reza (1):
      Bluetooth: btusb: Add RTW8852BE device 13d3:3570 to device tables

Mathias Nyman (1):
      xhci: turn cancelled td cleanup to its own function

Max Kellermann (1):
      ext4: apply umask if ACL support is disabled

Mike Rapoport (IBM) (1):
      x86/mm: Drop the 4 MB restriction on minimal NUMA node memory size

Mike Tipton (1):
      interconnect: qcom: Add support for mask-based BCMs

Mikhail Khvainitski (1):
      HID: lenovo: Detect quirk-free fw on cptkbd and stop applying workaround

Mimi Zohar (1):
      ima: detect changes to the backing overlay file

Miri Korenblit (1):
      wifi: iwlwifi: Use FW rate for non-data frames

Muhammad Usama Anjum (1):
      tty/sysrq: replace smp_processor_id() with get_cpu()

Nathan Chancellor (1):
      arm64: Restrict CPU_BIG_ENDIAN to GNU as or LLVM IAS 15.x or newer

Neil Armstrong (1):
      tty: serial: meson: retrieve port FIFO size from DT

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

Pablo Neira Ayuso (3):
      netfilter: nftables: update table flags from the commit phase
      netfilter: nf_tables: fix table flag updates
      netfilter: nf_tables: disable toggling dormant table state more than once

Paul Moore (2):
      audit: don't take task_lock() in audit_exe_compare() code path
      audit: don't WARN_ON_ONCE(!current->mm) in audit_exe_compare()

Pavel Krasavin (1):
      tty: serial: meson: fix hard LOCKUP on crtscts mode

Ping-Ke Shih (1):
      wifi: mac80211: don't return unset power in ieee80211_get_tx_power()

Pu Wen (1):
      x86/cpu/hygon: Fix the CPU topology evaluation for real

Qu Huang (1):
      drm/amdgpu: Fix a null pointer access when the smc_rreg pointer is NULL

Rahul Rameshbabu (1):
      net/mlx5e: Check return value of snprintf writing to fw_version buffer for representors

Rajeshwar R Shinde (1):
      media: gspca: cpia1: shift-out-of-bounds in set_flicker

Ranjan Kumar (1):
      scsi: mpt3sas: Fix loop logic

Richard Fitzgerald (1):
      ASoC: soc-card: Add storage for PCI SSID

Roman Gushchin (1):
      mm: kmem: drop __GFP_NOFAIL when allocating objcg vectors

Ronald Wahl (1):
      clocksource/drivers/timer-atmel-tcb: Fix initialization on SAM9 hardware

Rong Chen (1):
      mmc: meson-gx: Remove setting of CMD_CFG_ERROR

Sanjuán García, Jorge (1):
      mcb: fix error handling for different scenarios when parsing

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

Stanley.Yang (1):
      drm/amdgpu: Fix potential null pointer derefernce

Steven Rostedt (Google) (1):
      tracing: Have trace_event_file have ref counters

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

Uwe Kleine-König (3):
      PCI: keystone: Don't discard .remove() callback
      PCI: keystone: Don't discard .probe() callback
      PCI: exynos: Don't discard .remove() callback

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

Vlad Buslov (1):
      macvlan: Don't propagate promisc change to lower dev in passthru

Wayne Lin (1):
      drm/amd/display: Avoid NULL dereference of timing generator

Wenchao Hao (1):
      scsi: libfc: Fix potential NULL pointer dereference in fc_lport_ptp_setup()

Werner Sembach (1):
      ACPI: resource: Do IRQ override on TongFang GMxXGxx

Willem de Bruijn (1):
      ppp: limit MRU to 64K

Yi Yang (1):
      tty: vcc: Add check for kstrdup() in vcc_probe()

Yonglong Liu (1):
      net: hns3: fix variable may not initialized problem in hns3_init_mac_addr()

Yoshihiro Shimoda (1):
      misc: pci_endpoint_test: Add Device ID for R-Car S4-8 PCIe controller

Yuezhang Mo (1):
      exfat: support handle zero-size directory

Zhang Rui (1):
      tools/power/turbostat: Fix a knl bug

Zhang Yi (1):
      ext4: correct the start block of counting reserved clusters

ZhengHan Wang (1):
      Bluetooth: Fix double free in hci_conn_cleanup

Zhihao Cheng (1):
      jbd2: fix potential data lost in recovering journal raced with synchronizing fs bdev

Zi Yan (2):
      mm/cma: use nth_page() in place of direct struct page manipulation
      mm/memory_hotplug: use pfn math in place of direct struct page manipulation

baozhu.liu (1):
      drm/komeda: drop all currently held locks if deadlock happens

felix (1):
      SUNRPC: Fix RPC client cleaned up the freed pipefs dentries

youwan Wang (1):
      Bluetooth: btusb: Add date->evt_skb is NULL check

zhujun2 (1):
      selftests/efivarfs: create-read: fix a resource leak

