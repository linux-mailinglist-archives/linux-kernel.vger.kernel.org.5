Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACF087F8C64
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 17:33:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232273AbjKYQcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 11:32:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232276AbjKYQcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 11:32:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F442FB
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 08:32:53 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EDE3C433C7;
        Sat, 25 Nov 2023 16:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700929972;
        bh=FPWVGN4eNtRWMaoTxq9aOQyGdbcLNSQBuR1zJzQJz7A=;
        h=From:To:Cc:Subject:Date:From;
        b=0fyXKgmsk9FUaNZo35SL1pISUBwn7tSje23bzLyTID8xicslXMwCm1CuvGbahAH/9
         w7vEYjKKQ4EzHwpWpQIBhvlYOvGnReNmmt1Kh5+bDTstCavqqxyalJ/DlKc47bKGsZ
         UT5LZUOouC5f758P5bTh3tCEEM/VhWfq+O/Ze4FM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        allen.lkml@gmail.com
Subject: [PATCH 4.19 00/93] 4.19.300-rc2 review
Date:   Sat, 25 Nov 2023 16:32:49 +0000
Message-ID: <20231125163104.203147306@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.300-rc2.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.19.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.19.300-rc2
X-KernelTest-Deadline: 2023-11-27T16:31+00:00
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

This is the start of the stable review cycle for the 4.19.300 release.
There are 93 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Mon, 27 Nov 2023 16:30:48 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.300-rc2.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.19.300-rc2

Eric Dumazet <edumazet@google.com>
    net: sched: fix race condition in qdisc_graft()

Matthew Wilcox (Oracle) <willy@infradead.org>
    iomap: Set all uptodate bits for an Uptodate page

Dongli Zhang <dongli.zhang@oracle.com>
    scsi: virtio_scsi: limit number of hw queues by nr_cpu_ids

Christian König <christian.koenig@amd.com>
    drm/amdgpu: fix error handling in amdgpu_bo_list_get()

Kemeng Shi <shikemeng@huaweicloud.com>
    ext4: remove gdb backup copy for meta bg in setup_new_flex_group_blocks

Kemeng Shi <shikemeng@huaweicloud.com>
    ext4: correct return value of ext4_convert_meta_bg

Kemeng Shi <shikemeng@huaweicloud.com>
    ext4: correct offset of gdb backup in non meta_bg group to update_backups

Max Kellermann <max.kellermann@ionos.com>
    ext4: apply umask if ACL support is disabled

Heiner Kallweit <hkallweit1@gmail.com>
    Revert "net: r8169: Disable multicast filter for RTL8168H and RTL8107E"

Vikash Garodia <quic_vgarodia@quicinc.com>
    media: venus: hfi: add checks to handle capabilities from firmware

Vikash Garodia <quic_vgarodia@quicinc.com>
    media: venus: hfi: fix the check to handle session buffer requirement

Vikash Garodia <quic_vgarodia@quicinc.com>
    media: venus: hfi_parser: Add check to keep the number of codecs within range

Sean Young <sean@mess.org>
    media: sharp: fix sharp encoding

Sean Young <sean@mess.org>
    media: lirc: drop trailing space from scancode transmit

Heiner Kallweit <hkallweit1@gmail.com>
    i2c: i801: fix potential race in i801_block_transaction_byte_by_byte

Alexander Sverdlin <alexander.sverdlin@siemens.com>
    net: dsa: lan9303: consequently nested-lock physical MDIO

Pavel Krasavin <pkrasavin@imaqliq.com>
    tty: serial: meson: fix hard LOCKUP on crtscts mode

Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
    serial: meson: Use platform_get_irq() to get the interrupt

Neil Armstrong <narmstrong@baylibre.com>
    tty: serial: meson: retrieve port FIFO size from DT

Colin Ian King <colin.king@canonical.com>
    serial: meson: remove redundant initialization of variable id

Loys Ollivier <lollivier@baylibre.com>
    tty: serial: meson: if no alias specified use an available id

Chandradeep Dey <codesigning@chandradeepdey.com>
    ALSA: hda/realtek - Enable internal speaker of ASUS K6500ZC

Takashi Iwai <tiwai@suse.de>
    ALSA: info: Fix potential deadlock at disconnection

Helge Deller <deller@gmx.de>
    parisc/pgtable: Do not drop upper 5 address bits of physical address

Helge Deller <deller@gmx.de>
    parisc: Prevent booting 64-bit kernels on PA1.x machines

Heiko Carstens <hca@linux.ibm.com>
    s390/cmma: fix handling of swapper_pg_dir and invalid_pg_dir

Alain Volmat <alain.volmat@foss.st.com>
    dmaengine: stm32-mdma: correct desc prep when channel running

Sanjuán García, Jorge <Jorge.SanjuanGarcia@duagon.com>
    mcb: fix error handling for different scenarios when parsing

Eric Biggers <ebiggers@google.com>
    quota: explicitly forbid quota files from being encrypted

Zhihao Cheng <chengzhihao1@huawei.com>
    jbd2: fix potential data lost in recovering journal raced with synchronizing fs bdev

Brian Geffon <bgeffon@google.com>
    PM: hibernate: Clean up sync_read handling in snapshot_write_next()

Brian Geffon <bgeffon@google.com>
    PM: hibernate: Use __get_safe_page() rather than touching the list

Dan Carpenter <dan.carpenter@linaro.org>
    mmc: vub300: fix an error code

Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
    clk: qcom: ipq8074: drop the CLK_SET_RATE_PARENT flag from PLL clocks

Helge Deller <deller@gmx.de>
    parisc/pdc: Add width field to struct pdc_model

Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    PCI: keystone: Don't discard .probe() callback

Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    PCI: keystone: Don't discard .remove() callback

Herve Codina <herve.codina@bootlin.com>
    genirq/generic_chip: Make irq_remove_generic_chip() irqdomain aware

Rong Chen <rong.chen@amlogic.com>
    mmc: meson-gx: Remove setting of CMD_CFG_ERROR

Lukas Wunner <lukas@wunner.de>
    PCI/sysfs: Protect driver's D3cold preference from user space

David Woodhouse <dwmw@amazon.co.uk>
    hvc/xen: fix error path in xen_hvc_init() to always register frontend driver

Paul Moore <paul@paul-moore.com>
    audit: don't WARN_ON_ONCE(!current->mm) in audit_exe_compare()

Paul Moore <paul@paul-moore.com>
    audit: don't take task_lock() in audit_exe_compare() code path

Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
    KVM: x86: Ignore MSR_AMD64_TW_CFG access

Kees Cook <keescook@chromium.org>
    randstruct: Fix gcc-plugin performance mode to stay in group

Vikash Garodia <quic_vgarodia@quicinc.com>
    media: venus: hfi: add checks to perform sanity on queue pointers

Anastasia Belova <abelova@astralinux.ru>
    cifs: spnego: add ';' in HOST_KEY_LEN

Vlad Buslov <vladbu@nvidia.com>
    macvlan: Don't propagate promisc change to lower dev in passthru

Linus Walleij <linus.walleij@linaro.org>
    net: ethernet: cortina: Fix MTU max setting

Linus Walleij <linus.walleij@linaro.org>
    net: ethernet: cortina: Handle large frames

Linus Walleij <linus.walleij@linaro.org>
    net: ethernet: cortina: Fix max RX frame define

Eric Dumazet <edumazet@google.com>
    ptp: annotate data-race around q->head and q->tail

Juergen Gross <jgross@suse.com>
    xen/events: fix delayed eoi list handling

Willem de Bruijn <willemb@google.com>
    ppp: limit MRU to 64K

Shigeru Yoshida <syoshida@redhat.com>
    tipc: Fix kernel-infoleak due to uninitialized TLV value

Shigeru Yoshida <syoshida@redhat.com>
    tty: Fix uninit-value access in ppp_sync_receive()

Eric Dumazet <edumazet@google.com>
    ipvlan: add ipvlan_route_v6_outbound() helper

Olga Kornievskaia <kolga@netapp.com>
    NFSv4.1: fix SP4_MACH_CRED protection for pnfs IO

Dan Carpenter <dan.carpenter@linaro.org>
    pwm: Fix double shift bug

Wayne Lin <wayne.lin@amd.com>
    drm/amd/display: Avoid NULL dereference of timing generator

Bob Peterson <rpeterso@redhat.com>
    gfs2: ignore negated quota changes

Hans Verkuil <hverkuil-cisco@xs4all.nl>
    media: vivid: avoid integer overflow

Rajeshwar R Shinde <coolrrsh@gmail.com>
    media: gspca: cpia1: shift-out-of-bounds in set_flicker

Axel Lin <axel.lin@ingics.com>
    i2c: sun6i-p2wi: Prevent potential division by zero

Hardik Gajjar <hgajjar@de.adit-jv.com>
    usb: gadget: f_ncm: Always set current gadget in ncm_bind()

Yi Yang <yiyang13@huawei.com>
    tty: vcc: Add check for kstrdup() in vcc_probe()

Jiri Kosina <jkosina@suse.cz>
    HID: Add quirk for Dell Pro Wireless Keyboard and Mouse KM5221W

Wenchao Hao <haowenchao2@huawei.com>
    scsi: libfc: Fix potential NULL pointer dereference in fc_lport_ptp_setup()

Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
    atm: iphase: Do PCI error checks on own line

Cezary Rojewski <cezary.rojewski@intel.com>
    ALSA: hda: Fix possible null-ptr-deref when assigning a stream

Vincent Whitchurch <vincent.whitchurch@axis.com>
    ARM: 9320/1: fix stack depot IRQ stack filter

Manas Ghandat <ghandatmanas@gmail.com>
    jfs: fix array-index-out-of-bounds in diAlloc

Manas Ghandat <ghandatmanas@gmail.com>
    jfs: fix array-index-out-of-bounds in dbFindLeaf

Juntong Deng <juntong.deng@outlook.com>
    fs/jfs: Add validity check for db_maxag and db_agpref

Juntong Deng <juntong.deng@outlook.com>
    fs/jfs: Add check for negative db_l2nbperpage

Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
    RDMA/hfi1: Use FIELD_GET() to extract Link Width

Lu Jialin <lujialin4@huawei.com>
    crypto: pcrypt - Fix hungtask for PADATA_RESET

zhujun2 <zhujun2@cmss.chinamobile.com>
    selftests/efivarfs: create-read: fix a resource leak

Qu Huang <qu.huang@linux.dev>
    drm/amdgpu: Fix a null pointer access when the smc_rreg pointer is NULL

Mario Limonciello <mario.limonciello@amd.com>
    drm/amd: Fix UBSAN array-index-out-of-bounds for Polaris and Tonga

Mario Limonciello <mario.limonciello@amd.com>
    drm/amd: Fix UBSAN array-index-out-of-bounds for SMU7

Olli Asikainen <olli.asikainen@gmail.com>
    platform/x86: thinkpad_acpi: Add battery quirk for Thinkpad X120e

ZhengHan Wang <wzhmmmmm@gmail.com>
    Bluetooth: Fix double free in hci_conn_cleanup

Eric Dumazet <edumazet@google.com>
    net: annotate data-races around sk->sk_dst_pending_confirm

Eric Dumazet <edumazet@google.com>
    net: annotate data-races around sk->sk_tx_queue_mapping

Dmitry Antipov <dmantipov@yandex.ru>
    wifi: ath10k: fix clang-specific fortify warning

Dmitry Antipov <dmantipov@yandex.ru>
    wifi: ath9k: fix clang-specific fortify warnings

Ping-Ke Shih <pkshih@realtek.com>
    wifi: mac80211: don't return unset power in ieee80211_get_tx_power()

Mike Rapoport (IBM) <rppt@kernel.org>
    x86/mm: Drop the 4 MB restriction on minimal NUMA node memory size

Ronald Wahl <ronald.wahl@raritan.com>
    clocksource/drivers/timer-atmel-tcb: Fix initialization on SAM9 hardware

Jacky Bai <ping.bai@nxp.com>
    clocksource/drivers/timer-imx-gpt: Fix potential memory leak

Shuai Xue <xueshuai@linux.alibaba.com>
    perf/core: Bail out early if the request AUX area is out of bound

John Stultz <jstultz@google.com>
    locking/ww_mutex/test: Fix potential workqueue corruption


-------------

Diffstat:

 Makefile                                           |  4 +-
 arch/arm/include/asm/exception.h                   |  4 --
 arch/parisc/include/uapi/asm/pdc.h                 |  1 +
 arch/parisc/kernel/entry.S                         |  7 ++--
 arch/parisc/kernel/head.S                          |  5 +--
 arch/s390/mm/page-states.c                         |  6 +++
 arch/x86/include/asm/msr-index.h                   |  1 +
 arch/x86/include/asm/numa.h                        |  7 ----
 arch/x86/kvm/x86.c                                 |  2 +
 arch/x86/mm/numa.c                                 |  7 ----
 crypto/pcrypt.c                                    |  4 ++
 drivers/atm/iphase.c                               | 20 +++++-----
 drivers/clk/qcom/gcc-ipq8074.c                     |  6 ---
 drivers/clocksource/tcb_clksrc.c                   |  1 +
 drivers/clocksource/timer-imx-gpt.c                | 18 ++++++---
 drivers/dma/stm32-mdma.c                           |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c        |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c        |  6 +++
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c    |  4 +-
 drivers/gpu/drm/amd/include/pptable.h              |  4 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/pptable_v1_0.h | 16 ++++----
 drivers/hid/hid-ids.h                              |  1 +
 drivers/hid/hid-quirks.c                           |  1 +
 drivers/i2c/busses/i2c-i801.c                      | 19 +++++----
 drivers/i2c/busses/i2c-sun6i-p2wi.c                |  5 +++
 drivers/infiniband/hw/hfi1/pcie.c                  |  9 +----
 drivers/mcb/mcb-core.c                             |  1 +
 drivers/mcb/mcb-parse.c                            |  2 +-
 drivers/media/platform/qcom/venus/hfi_msgs.c       |  2 +-
 drivers/media/platform/qcom/venus/hfi_parser.c     | 15 ++++++++
 drivers/media/platform/qcom/venus/hfi_venus.c      | 10 +++++
 drivers/media/platform/vivid/vivid-rds-gen.c       |  2 +-
 drivers/media/rc/ir-sharp-decoder.c                |  8 ++--
 drivers/media/rc/lirc_dev.c                        |  6 ++-
 drivers/media/usb/gspca/cpia1.c                    |  3 ++
 drivers/mmc/host/meson-gx-mmc.c                    |  1 -
 drivers/mmc/host/vub300.c                          |  1 +
 drivers/net/dsa/lan9303_mdio.c                     |  4 +-
 drivers/net/ethernet/cortina/gemini.c              | 45 ++++++++++++++--------
 drivers/net/ethernet/cortina/gemini.h              |  4 +-
 drivers/net/ethernet/realtek/r8169_main.c          |  4 +-
 drivers/net/ipvlan/ipvlan_core.c                   | 41 ++++++++++++--------
 drivers/net/macvlan.c                              |  2 +-
 drivers/net/ppp/ppp_synctty.c                      |  6 ++-
 drivers/net/wireless/ath/ath10k/debug.c            |  2 +-
 drivers/net/wireless/ath/ath9k/debug.c             |  2 +-
 drivers/net/wireless/ath/ath9k/htc_drv_debug.c     |  2 +-
 drivers/pci/controller/dwc/pci-keystone.c          |  8 ++--
 drivers/pci/pci-acpi.c                             |  2 +-
 drivers/pci/pci-sysfs.c                            |  5 +--
 drivers/platform/x86/thinkpad_acpi.c               |  1 +
 drivers/ptp/ptp_chardev.c                          |  3 +-
 drivers/ptp/ptp_clock.c                            |  5 ++-
 drivers/ptp/ptp_private.h                          |  8 +++-
 drivers/ptp/ptp_sysfs.c                            |  3 +-
 drivers/scsi/libfc/fc_lport.c                      |  6 +++
 drivers/scsi/virtio_scsi.c                         |  1 +
 drivers/tty/hvc/hvc_xen.c                          |  5 ++-
 drivers/tty/serial/meson_uart.c                    | 44 ++++++++++++++++-----
 drivers/tty/vcc.c                                  | 16 ++++++--
 drivers/usb/gadget/function/f_ncm.c                | 27 ++++++-------
 drivers/xen/events/events_base.c                   |  4 +-
 fs/cifs/cifs_spnego.c                              |  4 +-
 fs/ext4/acl.h                                      |  5 +++
 fs/ext4/resize.c                                   | 19 ++++-----
 fs/gfs2/quota.c                                    | 11 ++++++
 fs/iomap.c                                         |  3 ++
 fs/jbd2/recovery.c                                 |  8 ++++
 fs/jfs/jfs_dmap.c                                  | 23 ++++++++---
 fs/jfs/jfs_imap.c                                  |  5 ++-
 fs/nfs/nfs4proc.c                                  |  5 ++-
 fs/quota/dquot.c                                   | 14 +++++++
 include/linux/pwm.h                                |  4 +-
 include/net/sock.h                                 | 26 +++++++++----
 kernel/audit_watch.c                               |  9 ++++-
 kernel/events/ring_buffer.c                        |  6 +++
 kernel/irq/generic-chip.c                          | 25 +++++++++---
 kernel/locking/test-ww_mutex.c                     | 20 ++++++----
 kernel/padata.c                                    |  2 +-
 kernel/power/snapshot.c                            | 16 ++++----
 net/bluetooth/hci_conn.c                           |  6 +--
 net/bluetooth/hci_sysfs.c                          | 23 +++++------
 net/core/sock.c                                    |  2 +-
 net/ipv4/tcp_output.c                              |  2 +-
 net/mac80211/cfg.c                                 |  4 ++
 net/sched/sch_api.c                                |  5 ++-
 net/tipc/netlink_compat.c                          |  1 +
 scripts/gcc-plugins/randomize_layout_plugin.c      | 11 ++++--
 sound/core/info.c                                  | 21 ++++++----
 sound/hda/hdac_stream.c                            |  6 ++-
 sound/pci/hda/patch_realtek.c                      |  1 +
 tools/testing/selftests/efivarfs/create-read.c     |  2 +
 92 files changed, 488 insertions(+), 265 deletions(-)


