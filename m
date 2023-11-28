Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9F27FC1B9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:15:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344931AbjK1Rik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 12:38:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345117AbjK1RKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 12:10:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D321D1701
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 09:10:47 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 205E8C433CA;
        Tue, 28 Nov 2023 17:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1701191447;
        bh=9HkhLsP8awmbu7dQGB98GsGOc+FGL31HtDkXO/25eXY=;
        h=From:To:Cc:Subject:Date:From;
        b=rbatdfO4P1OvNKtUd7kt82bampp3KQsWyBfJuL18MAxeXLZUnBFvdtb7De+8cn9sU
         oZFCD2FD868hLqi92gBGzX4AAdegcH1MpdCH0VjzhNIgzcCISQt9jU5foiDAY0wFMv
         OXgf2xuXX5M1q+aZ1NqJK8GDkC2eKKq/zZo31Hug=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 4.19.300
Date:   Tue, 28 Nov 2023 17:10:40 +0000
Message-ID: <2023112841-myspace-outsell-affd@gregkh>
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

I'm announcing the release of the 4.19.300 kernel.

All users of the 4.19 kernel series must upgrade.

The updated 4.19.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-4.19.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                           |    2 
 arch/arm/include/asm/exception.h                   |    4 -
 arch/parisc/include/uapi/asm/pdc.h                 |    1 
 arch/parisc/kernel/entry.S                         |    7 +--
 arch/parisc/kernel/head.S                          |    5 --
 arch/x86/include/asm/msr-index.h                   |    1 
 arch/x86/include/asm/numa.h                        |    7 ---
 arch/x86/kvm/x86.c                                 |    2 
 arch/x86/mm/numa.c                                 |    7 ---
 crypto/pcrypt.c                                    |    4 +
 drivers/atm/iphase.c                               |   20 +++++----
 drivers/clk/qcom/gcc-ipq8074.c                     |    6 --
 drivers/clocksource/tcb_clksrc.c                   |    1 
 drivers/clocksource/timer-imx-gpt.c                |   18 ++++++--
 drivers/dma/stm32-mdma.c                           |    4 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c        |    1 
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c        |    6 ++
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c    |    4 -
 drivers/gpu/drm/amd/include/pptable.h              |    4 -
 drivers/gpu/drm/amd/powerplay/hwmgr/pptable_v1_0.h |   16 +++----
 drivers/hid/hid-ids.h                              |    1 
 drivers/hid/hid-quirks.c                           |    1 
 drivers/i2c/busses/i2c-i801.c                      |   19 ++++----
 drivers/i2c/busses/i2c-sun6i-p2wi.c                |    5 ++
 drivers/infiniband/hw/hfi1/pcie.c                  |    9 ----
 drivers/mcb/mcb-core.c                             |    1 
 drivers/mcb/mcb-parse.c                            |    2 
 drivers/media/platform/qcom/venus/hfi_msgs.c       |    2 
 drivers/media/platform/qcom/venus/hfi_parser.c     |   15 +++++++
 drivers/media/platform/qcom/venus/hfi_venus.c      |   10 ++++
 drivers/media/platform/vivid/vivid-rds-gen.c       |    2 
 drivers/media/rc/ir-sharp-decoder.c                |    8 ++-
 drivers/media/rc/lirc_dev.c                        |    6 ++
 drivers/media/usb/gspca/cpia1.c                    |    3 +
 drivers/mmc/host/meson-gx-mmc.c                    |    1 
 drivers/mmc/host/vub300.c                          |    1 
 drivers/net/dsa/lan9303_mdio.c                     |    4 -
 drivers/net/ethernet/cortina/gemini.c              |   45 +++++++++++++--------
 drivers/net/ethernet/cortina/gemini.h              |    4 -
 drivers/net/ethernet/realtek/r8169_main.c          |    4 -
 drivers/net/ipvlan/ipvlan_core.c                   |   41 +++++++++++--------
 drivers/net/macvlan.c                              |    2 
 drivers/net/ppp/ppp_synctty.c                      |    6 ++
 drivers/net/wireless/ath/ath10k/debug.c            |    2 
 drivers/net/wireless/ath/ath9k/debug.c             |    2 
 drivers/net/wireless/ath/ath9k/htc_drv_debug.c     |    2 
 drivers/pci/controller/dwc/pci-keystone.c          |    8 +--
 drivers/pci/pci-acpi.c                             |    2 
 drivers/pci/pci-sysfs.c                            |    5 --
 drivers/platform/x86/thinkpad_acpi.c               |    1 
 drivers/ptp/ptp_chardev.c                          |    3 -
 drivers/ptp/ptp_clock.c                            |    5 +-
 drivers/ptp/ptp_private.h                          |    8 ++-
 drivers/ptp/ptp_sysfs.c                            |    3 -
 drivers/scsi/libfc/fc_lport.c                      |    6 ++
 drivers/scsi/virtio_scsi.c                         |    1 
 drivers/tty/hvc/hvc_xen.c                          |    5 +-
 drivers/tty/serial/meson_uart.c                    |   44 +++++++++++++++-----
 drivers/tty/vcc.c                                  |   16 ++++++-
 drivers/usb/gadget/function/f_ncm.c                |   27 +++++-------
 drivers/xen/events/events_base.c                   |    4 +
 fs/cifs/cifs_spnego.c                              |    4 -
 fs/ext4/acl.h                                      |    5 ++
 fs/ext4/resize.c                                   |   19 +++-----
 fs/gfs2/quota.c                                    |   11 +++++
 fs/iomap.c                                         |    3 +
 fs/jbd2/recovery.c                                 |    8 +++
 fs/jfs/jfs_dmap.c                                  |   23 ++++++++--
 fs/jfs/jfs_imap.c                                  |    5 +-
 fs/nfs/nfs4proc.c                                  |    5 +-
 fs/quota/dquot.c                                   |   14 ++++++
 include/linux/pwm.h                                |    4 -
 include/net/sock.h                                 |   26 ++++++++----
 kernel/audit_watch.c                               |    9 +++-
 kernel/events/ring_buffer.c                        |    6 ++
 kernel/irq/generic-chip.c                          |   25 ++++++++---
 kernel/locking/test-ww_mutex.c                     |   20 +++++----
 kernel/padata.c                                    |    2 
 kernel/power/snapshot.c                            |   16 +++----
 net/bluetooth/hci_conn.c                           |    6 --
 net/bluetooth/hci_sysfs.c                          |   23 +++++-----
 net/core/sock.c                                    |    2 
 net/ipv4/tcp_output.c                              |    2 
 net/mac80211/cfg.c                                 |    4 +
 net/sched/sch_api.c                                |    5 +-
 net/tipc/netlink_compat.c                          |    1 
 scripts/gcc-plugins/randomize_layout_plugin.c      |   11 +++--
 sound/core/info.c                                  |   21 ++++++---
 sound/hda/hdac_stream.c                            |    6 +-
 sound/pci/hda/patch_realtek.c                      |    1 
 tools/testing/selftests/efivarfs/create-read.c     |    2 
 91 files changed, 481 insertions(+), 264 deletions(-)

Alain Volmat (1):
      dmaengine: stm32-mdma: correct desc prep when channel running

Alexander Sverdlin (1):
      net: dsa: lan9303: consequently nested-lock physical MDIO

Anastasia Belova (1):
      cifs: spnego: add ';' in HOST_KEY_LEN

Axel Lin (1):
      i2c: sun6i-p2wi: Prevent potential division by zero

Bob Peterson (1):
      gfs2: ignore negated quota changes

Brian Geffon (2):
      PM: hibernate: Use __get_safe_page() rather than touching the list
      PM: hibernate: Clean up sync_read handling in snapshot_write_next()

Cezary Rojewski (1):
      ALSA: hda: Fix possible null-ptr-deref when assigning a stream

Chandradeep Dey (1):
      ALSA: hda/realtek - Enable internal speaker of ASUS K6500ZC

Christian König (1):
      drm/amdgpu: fix error handling in amdgpu_bo_list_get()

Colin Ian King (1):
      serial: meson: remove redundant initialization of variable id

Dan Carpenter (2):
      pwm: Fix double shift bug
      mmc: vub300: fix an error code

David Woodhouse (1):
      hvc/xen: fix error path in xen_hvc_init() to always register frontend driver

Dmitry Antipov (2):
      wifi: ath9k: fix clang-specific fortify warnings
      wifi: ath10k: fix clang-specific fortify warning

Dongli Zhang (1):
      scsi: virtio_scsi: limit number of hw queues by nr_cpu_ids

Eric Biggers (1):
      quota: explicitly forbid quota files from being encrypted

Eric Dumazet (5):
      net: annotate data-races around sk->sk_tx_queue_mapping
      net: annotate data-races around sk->sk_dst_pending_confirm
      ipvlan: add ipvlan_route_v6_outbound() helper
      ptp: annotate data-race around q->head and q->tail
      net: sched: fix race condition in qdisc_graft()

Greg Kroah-Hartman (1):
      Linux 4.19.300

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

Ilpo Järvinen (2):
      RDMA/hfi1: Use FIELD_GET() to extract Link Width
      atm: iphase: Do PCI error checks on own line

Jacky Bai (1):
      clocksource/drivers/timer-imx-gpt: Fix potential memory leak

Jiri Kosina (1):
      HID: Add quirk for Dell Pro Wireless Keyboard and Mouse KM5221W

John Stultz (1):
      locking/ww_mutex/test: Fix potential workqueue corruption

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

Linus Walleij (3):
      net: ethernet: cortina: Fix max RX frame define
      net: ethernet: cortina: Handle large frames
      net: ethernet: cortina: Fix MTU max setting

Loys Ollivier (1):
      tty: serial: meson: if no alias specified use an available id

Lu Jialin (1):
      crypto: pcrypt - Fix hungtask for PADATA_RESET

Lukas Wunner (1):
      PCI/sysfs: Protect driver's D3cold preference from user space

Maciej S. Szmigiero (1):
      KVM: x86: Ignore MSR_AMD64_TW_CFG access

Manas Ghandat (2):
      jfs: fix array-index-out-of-bounds in dbFindLeaf
      jfs: fix array-index-out-of-bounds in diAlloc

Mario Limonciello (2):
      drm/amd: Fix UBSAN array-index-out-of-bounds for SMU7
      drm/amd: Fix UBSAN array-index-out-of-bounds for Polaris and Tonga

Matthew Wilcox (Oracle) (1):
      iomap: Set all uptodate bits for an Uptodate page

Max Kellermann (1):
      ext4: apply umask if ACL support is disabled

Mike Rapoport (IBM) (1):
      x86/mm: Drop the 4 MB restriction on minimal NUMA node memory size

Neil Armstrong (1):
      tty: serial: meson: retrieve port FIFO size from DT

Olga Kornievskaia (1):
      NFSv4.1: fix SP4_MACH_CRED protection for pnfs IO

Olli Asikainen (1):
      platform/x86: thinkpad_acpi: Add battery quirk for Thinkpad X120e

Paul Moore (2):
      audit: don't take task_lock() in audit_exe_compare() code path
      audit: don't WARN_ON_ONCE(!current->mm) in audit_exe_compare()

Pavel Krasavin (1):
      tty: serial: meson: fix hard LOCKUP on crtscts mode

Ping-Ke Shih (1):
      wifi: mac80211: don't return unset power in ieee80211_get_tx_power()

Qu Huang (1):
      drm/amdgpu: Fix a null pointer access when the smc_rreg pointer is NULL

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

Takashi Iwai (1):
      ALSA: info: Fix potential deadlock at disconnection

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

Willem de Bruijn (1):
      ppp: limit MRU to 64K

Yi Yang (1):
      tty: vcc: Add check for kstrdup() in vcc_probe()

ZhengHan Wang (1):
      Bluetooth: Fix double free in hci_conn_cleanup

Zhihao Cheng (1):
      jbd2: fix potential data lost in recovering journal raced with synchronizing fs bdev

zhujun2 (1):
      selftests/efivarfs: create-read: fix a resource leak

