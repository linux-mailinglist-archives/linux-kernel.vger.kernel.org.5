Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6203F7FC26E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:16:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjK1RL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 12:11:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234835AbjK1RLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 12:11:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F721BD3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 09:11:21 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CD39C433C8;
        Tue, 28 Nov 2023 17:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1701191481;
        bh=020P6jHouBqTrMgBrgr3rFxKEufCcXXOizIr3CADuhk=;
        h=From:To:Cc:Subject:Date:From;
        b=lOhm+SzrhELX3dsTw97a6Ce1+8/Bvy9QoHxStXCWks8X8tW8aYi4EhenKcOBwcGXu
         OuHZThYKNcjyznv8MIxe7+BLXsoAphQ2oKD9lD0mGrRvLlAuSBq8/kvZBqtOzfdS3M
         iJX4NeZZGlJBfGWsldZfgnzWkagEN3GUn2r0m+UU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.4.262
Date:   Tue, 28 Nov 2023 17:11:16 +0000
Message-ID: <2023112817-snare-stylist-f3a0@gregkh>
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

I'm announcing the release of the 5.4.262 kernel.

All users of the 5.4 kernel series must upgrade.

The updated 5.4.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.4.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                   |    2 
 arch/arm/include/asm/exception.h                           |    4 
 arch/parisc/include/uapi/asm/pdc.h                         |    1 
 arch/parisc/kernel/entry.S                                 |    7 
 arch/parisc/kernel/head.S                                  |    5 
 arch/x86/include/asm/msr-index.h                           |    1 
 arch/x86/include/asm/numa.h                                |    7 
 arch/x86/kernel/cpu/hygon.c                                |    8 
 arch/x86/kvm/hyperv.c                                      |   10 
 arch/x86/kvm/x86.c                                         |    2 
 arch/x86/mm/numa.c                                         |    7 
 crypto/pcrypt.c                                            |    4 
 drivers/acpi/resource.c                                    |   12 
 drivers/atm/iphase.c                                       |   20 
 drivers/bluetooth/btusb.c                                  |   35 
 drivers/clk/qcom/gcc-ipq8074.c                             |    6 
 drivers/clocksource/timer-atmel-tcb.c                      |    1 
 drivers/clocksource/timer-imx-gpt.c                        |   18 
 drivers/dma/stm32-mdma.c                                   |    4 
 drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c                |    1 
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c                |    6 
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c            |    4 
 drivers/gpu/drm/amd/include/pptable.h                      |    4 
 drivers/gpu/drm/amd/powerplay/hwmgr/pptable_v1_0.h         |   16 
 drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c |    9 
 drivers/hid/hid-ids.h                                      |    1 
 drivers/hid/hid-quirks.c                                   |    1 
 drivers/i2c/busses/i2c-i801.c                              |   19 
 drivers/i2c/busses/i2c-sun6i-p2wi.c                        |    5 
 drivers/i2c/i2c-core.h                                     |    2 
 drivers/i3c/master/i3c-master-cdns.c                       |    6 
 drivers/infiniband/hw/hfi1/pcie.c                          |    9 
 drivers/mcb/mcb-core.c                                     |    1 
 drivers/mcb/mcb-parse.c                                    |    2 
 drivers/media/pci/cobalt/cobalt-driver.c                   |   11 
 drivers/media/platform/qcom/venus/hfi_msgs.c               |    2 
 drivers/media/platform/qcom/venus/hfi_parser.c             |   15 
 drivers/media/platform/qcom/venus/hfi_venus.c              |   10 
 drivers/media/platform/vivid/vivid-rds-gen.c               |    2 
 drivers/media/rc/ir-sharp-decoder.c                        |    8 
 drivers/media/rc/lirc_dev.c                                |    6 
 drivers/media/usb/gspca/cpia1.c                            |    3 
 drivers/mmc/host/meson-gx-mmc.c                            |    1 
 drivers/mmc/host/vub300.c                                  |    1 
 drivers/net/bonding/bond_main.c                            |    6 
 drivers/net/dsa/lan9303_mdio.c                             |    4 
 drivers/net/ethernet/cortina/gemini.c                      |   45 -
 drivers/net/ethernet/cortina/gemini.h                      |    4 
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c            |    2 
 drivers/net/ethernet/mellanox/mlx5/core/devlink.c          |    2 
 drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c        |   10 
 drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c       |    4 
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c           |   13 
 drivers/net/ethernet/mellanox/mlx5/core/ipoib/ethtool.c    |    2 
 drivers/net/ethernet/mellanox/mlx5/core/main.c             |   10 
 drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h        |    3 
 drivers/net/ethernet/realtek/r8169_main.c                  |    4 
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c          |  148 ++-
 drivers/net/ipvlan/ipvlan_core.c                           |   41 -
 drivers/net/macvlan.c                                      |    2 
 drivers/net/ppp/ppp_synctty.c                              |    6 
 drivers/net/wireless/ath/ath10k/debug.c                    |    2 
 drivers/net/wireless/ath/ath10k/snoc.c                     |   18 
 drivers/net/wireless/ath/ath9k/debug.c                     |    2 
 drivers/net/wireless/ath/ath9k/htc_drv_debug.c             |    2 
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c                |   14 
 drivers/net/wireless/mac80211_hwsim.c                      |    2 
 drivers/pci/controller/dwc/pci-keystone.c                  |    8 
 drivers/pci/controller/dwc/pcie-tegra194.c                 |    9 
 drivers/pci/pci-acpi.c                                     |    2 
 drivers/pci/pci-sysfs.c                                    |    5 
 drivers/platform/x86/thinkpad_acpi.c                       |    1 
 drivers/ptp/ptp_chardev.c                                  |    3 
 drivers/ptp/ptp_clock.c                                    |    5 
 drivers/ptp/ptp_private.h                                  |    8 
 drivers/ptp/ptp_sysfs.c                                    |    3 
 drivers/scsi/libfc/fc_lport.c                              |    6 
 drivers/scsi/megaraid/megaraid_sas_base.c                  |    4 
 drivers/tty/hvc/hvc_xen.c                                  |    5 
 drivers/tty/serial/meson_uart.c                            |   33 
 drivers/tty/vcc.c                                          |   16 
 drivers/usb/gadget/function/f_ncm.c                        |   27 
 drivers/xen/events/events_base.c                           |    4 
 fs/btrfs/delalloc-space.c                                  |    3 
 fs/cifs/cifs_spnego.c                                      |    4 
 fs/ext4/acl.h                                              |    5 
 fs/ext4/extents_status.c                                   |    4 
 fs/ext4/resize.c                                           |   19 
 fs/gfs2/quota.c                                            |   11 
 fs/jbd2/recovery.c                                         |    8 
 fs/jfs/jfs_dmap.c                                          |   23 
 fs/jfs/jfs_imap.c                                          |    5 
 fs/nfs/nfs4proc.c                                          |    5 
 fs/nfsd/nfs4state.c                                        |    2 
 fs/quota/dquot.c                                           |   14 
 include/linux/mlx5/driver.h                                |    2 
 include/linux/pwm.h                                        |    4 
 include/linux/trace_events.h                               |    4 
 include/net/netfilter/nf_tables.h                          |  129 +--
 include/net/sock.h                                         |   26 
 include/uapi/linux/netfilter/nf_tables.h                   |    1 
 kernel/audit_watch.c                                       |    9 
 kernel/bpf/verifier.c                                      |    7 
 kernel/debug/debug_core.c                                  |    3 
 kernel/events/ring_buffer.c                                |    6 
 kernel/irq/generic-chip.c                                  |   25 
 kernel/locking/test-ww_mutex.c                             |   20 
 kernel/padata.c                                            |    2 
 kernel/power/snapshot.c                                    |   16 
 kernel/reboot.c                                            |    1 
 kernel/trace/trace.c                                       |   15 
 kernel/trace/trace.h                                       |    3 
 kernel/trace/trace_events.c                                |   39 
 kernel/trace/trace_events_filter.c                         |    3 
 mm/cma.c                                                   |    2 
 net/bluetooth/hci_conn.c                                   |    6 
 net/bluetooth/hci_sysfs.c                                  |   23 
 net/bridge/netfilter/nf_conntrack_bridge.c                 |    2 
 net/core/sock.c                                            |    2 
 net/ipv4/tcp_output.c                                      |    2 
 net/mac80211/cfg.c                                         |    4 
 net/ncsi/ncsi-aen.c                                        |    5 
 net/netfilter/nf_tables_api.c                              |  512 ++++++++++---
 net/netfilter/nft_chain_filter.c                           |    3 
 net/netfilter/nft_set_bitmap.c                             |    5 
 net/netfilter/nft_set_hash.c                               |  110 +-
 net/netfilter/nft_set_rbtree.c                             |  375 +++++++--
 net/tipc/netlink_compat.c                                  |    1 
 scripts/gcc-plugins/randomize_layout_plugin.c              |   11 
 sound/core/info.c                                          |   21 
 sound/hda/hdac_stream.c                                    |    6 
 sound/pci/hda/patch_realtek.c                              |    1 
 sound/soc/ti/omap-mcbsp.c                                  |    6 
 tools/power/x86/turbostat/turbostat.c                      |    2 
 tools/testing/selftests/efivarfs/create-read.c             |    2 
 135 files changed, 1625 insertions(+), 678 deletions(-)

Alain Michaud (1):
      Bluetooth: btusb: Add flag to define wideband speech capability

Alain Volmat (1):
      dmaengine: stm32-mdma: correct desc prep when channel running

Alexander Sverdlin (1):
      net: dsa: lan9303: consequently nested-lock physical MDIO

Anastasia Belova (1):
      cifs: spnego: add ';' in HOST_KEY_LEN

Artem Lukyanov (1):
      Bluetooth: btusb: Add Realtek RTL8852BE support ID 0x0cb8:0xc559

Axel Lin (1):
      i2c: sun6i-p2wi: Prevent potential division by zero

Baruch Siach (1):
      net: stmmac: fix rx budget limit check

Benjamin Bara (2):
      kernel/reboot: emergency_restart: Set correct system_state
      i2c: core: Run atomic i2c xfer when !preemptible

Bob Peterson (1):
      gfs2: ignore negated quota changes

Brian Geffon (2):
      PM: hibernate: Use __get_safe_page() rather than touching the list
      PM: hibernate: Clean up sync_read handling in snapshot_write_next()

Cezary Rojewski (1):
      ALSA: hda: Fix possible null-ptr-deref when assigning a stream

Chandradeep Dey (1):
      ALSA: hda/realtek - Enable internal speaker of ASUS K6500ZC

Chandrakanth patil (1):
      scsi: megaraid_sas: Increase register read retry rount from 3 to 30 for selected registers

Christian König (1):
      drm/amdgpu: fix error handling in amdgpu_bo_list_get()

Colin Ian King (1):
      serial: meson: remove redundant initialization of variable id

Dan Carpenter (2):
      pwm: Fix double shift bug
      mmc: vub300: fix an error code

David Woodhouse (1):
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

Eric Biggers (1):
      quota: explicitly forbid quota files from being encrypted

Eric Dumazet (5):
      net: annotate data-races around sk->sk_tx_queue_mapping
      net: annotate data-races around sk->sk_dst_pending_confirm
      ipvlan: add ipvlan_route_v6_outbound() helper
      ptp: annotate data-race around q->head and q->tail
      bonding: stop the device in bond_setup_by_slave()

Florian Westphal (4):
      netfilter: nft_set_rbtree: fix null deref on element insertion
      netfilter: nft_set_rbtree: fix overlap expiration walk
      netfilter: nf_tables: don't skip expired elements during walk
      netfilter: nf_tables: defer gc run if previous batch is still pending

Greg Kroah-Hartman (1):
      Linux 5.4.262

Guan Wentao (1):
      Bluetooth: btusb: Add 0bda:b85b for Fn-Link RTL8852BE

Hans Verkuil (1):
      media: vivid: avoid integer overflow

Hardik Gajjar (1):
      usb: gadget: f_ncm: Always set current gadget in ncm_bind()

Heiner Kallweit (2):
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

Jiri Kosina (1):
      HID: Add quirk for Dell Pro Wireless Keyboard and Mouse KM5221W

John Stultz (1):
      locking/ww_mutex/test: Fix potential workqueue corruption

Johnathan Mantey (1):
      Revert ncsi: Propagate carrier gain/loss events to the NCSI controller

Jose Abreu (1):
      net: stmmac: Rework stmmac_rx()

Josef Bacik (1):
      btrfs: don't arbitrarily slow down delalloc if we're committing

Joseph Hwang (1):
      Bluetooth: btusb: add Realtek 8822CE to usb_device_id table

Joshua Yeong (1):
      i3c: master: cdns: Fix reading status register

Juergen Gross (1):
      xen/events: fix delayed eoi list handling

Juntong Deng (2):
      fs/jfs: Add check for negative db_l2nbperpage
      fs/jfs: Add validity check for db_maxag and db_agpref

Kathiravan Thirumoorthy (1):
      clk: qcom: ipq8074: drop the CLK_SET_RATE_PARENT flag from PLL clocks

Kees Cook (1):
      randstruct: Fix gcc-plugin performance mode to stay in group

Kemeng Shi (3):
      ext4: correct offset of gdb backup in non meta_bg group to update_backups
      ext4: correct return value of ext4_convert_meta_bg
      ext4: remove gdb backup copy for meta bg in setup_new_flex_group_blocks

Lad Prabhakar (1):
      serial: meson: Use platform_get_irq() to get the interrupt

Larry Finger (2):
      bluetooth: Add device 0bda:887b to device tables
      bluetooth: Add device 13d3:3571 to device tables

Leon Romanovsky (1):
      net/mlx5_core: Clean driver version and name

Linkui Xiao (1):
      netfilter: nf_conntrack_bridge: initialize err to 0

Linus Walleij (3):
      net: ethernet: cortina: Fix max RX frame define
      net: ethernet: cortina: Handle large frames
      net: ethernet: cortina: Fix MTU max setting

Lu Jialin (1):
      crypto: pcrypt - Fix hungtask for PADATA_RESET

Lukas Wunner (1):
      PCI/sysfs: Protect driver's D3cold preference from user space

Maciej S. Szmigiero (1):
      KVM: x86: Ignore MSR_AMD64_TW_CFG access

Mahmoud Adam (1):
      nfsd: fix file memleak on client_opens_release

Manas Ghandat (2):
      jfs: fix array-index-out-of-bounds in dbFindLeaf
      jfs: fix array-index-out-of-bounds in diAlloc

Mario Limonciello (2):
      drm/amd: Fix UBSAN array-index-out-of-bounds for SMU7
      drm/amd: Fix UBSAN array-index-out-of-bounds for Polaris and Tonga

Masum Reza (1):
      Bluetooth: btusb: Add RTW8852BE device 13d3:3570 to device tables

Max Kellermann (1):
      ext4: apply umask if ACL support is disabled

Mike Rapoport (IBM) (1):
      x86/mm: Drop the 4 MB restriction on minimal NUMA node memory size

Miri Korenblit (1):
      wifi: iwlwifi: Use FW rate for non-data frames

Neil Armstrong (1):
      tty: serial: meson: retrieve port FIFO size from DT

Nicolas Saenz Julienne (1):
      KVM: x86: hyper-v: Don't auto-enable stimer on write from user-space

Olga Kornievskaia (1):
      NFSv4.1: fix SP4_MACH_CRED protection for pnfs IO

Olli Asikainen (1):
      platform/x86: thinkpad_acpi: Add battery quirk for Thinkpad X120e

Pablo Neira Ayuso (22):
      netfilter: nf_tables: pass context to nft_set_destroy()
      netfilter: nftables: rename set element data activation/deactivation functions
      netfilter: nf_tables: drop map element references from preparation phase
      netfilter: nft_set_rbtree: Switch to node list walk for overlap detection
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
      netfilter: nft_set_hash: try later when GC hits EAGAIN on iteration
      netfilter: nf_tables: fix memleak when more than 255 elements expired
      netfilter: nf_tables: unregister flowtable hooks on netns exit
      netfilter: nf_tables: double hook unregistration in netns path
      netfilter: nftables: update table flags from the commit phase
      netfilter: nf_tables: fix table flag updates
      netfilter: nf_tables: disable toggling dormant table state more than once
      netfilter: nf_tables: bogus EBUSY when deleting flowtable after flush (for 5.4)

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

Steven Rostedt (Google) (1):
      tracing: Have trace_event_file have ref counters

Takashi Iwai (1):
      ALSA: info: Fix potential deadlock at disconnection

Tony Lindgren (1):
      ASoC: ti: omap-mcbsp: Fix runtime PM underflow warnings

Uwe Kleine-König (2):
      PCI: keystone: Don't discard .remove() callback
      PCI: keystone: Don't discard .probe() callback

Vikash Garodia (4):
      media: venus: hfi: add checks to perform sanity on queue pointers
      media: venus: hfi_parser: Add check to keep the number of codecs within range
      media: venus: hfi: fix the check to handle session buffer requirement
      media: venus: hfi: add checks to handle capabilities from firmware

Vincent Whitchurch (1):
      ARM: 9320/1: fix stack depot IRQ stack filter

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

Zhang Rui (1):
      tools/power/turbostat: Fix a knl bug

Zhang Yi (1):
      ext4: correct the start block of counting reserved clusters

ZhengHan Wang (1):
      Bluetooth: Fix double free in hci_conn_cleanup

Zhihao Cheng (1):
      jbd2: fix potential data lost in recovering journal raced with synchronizing fs bdev

Zi Yan (1):
      mm/cma: use nth_page() in place of direct struct page manipulation

baozhu.liu (1):
      drm/komeda: drop all currently held locks if deadlock happens

zhujun2 (1):
      selftests/efivarfs: create-read: fix a resource leak

