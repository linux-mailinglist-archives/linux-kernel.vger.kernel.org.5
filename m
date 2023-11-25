Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 560CC7F8C63
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 17:33:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232242AbjKYQcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 11:32:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbjKYQcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 11:32:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A2C102
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 08:32:47 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B843FC433C7;
        Sat, 25 Nov 2023 16:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700929967;
        bh=tZx0+ZtHR3FGIgPlYbxvCPgxc0eJfqAf3/1gVfOwfSg=;
        h=From:To:Cc:Subject:Date:From;
        b=TJ97gjagETgjnspI8CaG2EuoBE/4hlyCBd3HbUJvKvXfDDejm+9AnSlK10UymJhY5
         BzjDwdo+3k/CnN7O2o6Yh1lRFGBu10Uqxof97I9lXK4whmxh0fDvSnxl4YiDRh9GVS
         MJbyUrMKQnNACetOTHxQmBGGRHuZU4MDasDazTss=
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
Subject: [PATCH 4.14 00/53] 4.14.331-rc2 review
Date:   Sat, 25 Nov 2023 16:32:43 +0000
Message-ID: <20231125163059.878143365@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.331-rc2.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.14.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.14.331-rc2
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

This is the start of the stable review cycle for the 4.14.331 release.
There are 53 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Mon, 27 Nov 2023 16:30:48 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.331-rc2.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.14.331-rc2

Eric Dumazet <edumazet@google.com>
    net: sched: fix race condition in qdisc_graft()

Dongli Zhang <dongli.zhang@oracle.com>
    scsi: virtio_scsi: limit number of hw queues by nr_cpu_ids

Kemeng Shi <shikemeng@huaweicloud.com>
    ext4: remove gdb backup copy for meta bg in setup_new_flex_group_blocks

Kemeng Shi <shikemeng@huaweicloud.com>
    ext4: correct return value of ext4_convert_meta_bg

Kemeng Shi <shikemeng@huaweicloud.com>
    ext4: correct offset of gdb backup in non meta_bg group to update_backups

Max Kellermann <max.kellermann@ionos.com>
    ext4: apply umask if ACL support is disabled

Vikash Garodia <quic_vgarodia@quicinc.com>
    media: venus: hfi: fix the check to handle session buffer requirement

Sean Young <sean@mess.org>
    media: sharp: fix sharp encoding

Heiner Kallweit <hkallweit1@gmail.com>
    i2c: i801: fix potential race in i801_block_transaction_byte_by_byte

Alexander Sverdlin <alexander.sverdlin@siemens.com>
    net: dsa: lan9303: consequently nested-lock physical MDIO

Takashi Iwai <tiwai@suse.de>
    ALSA: info: Fix potential deadlock at disconnection

Helge Deller <deller@gmx.de>
    parisc/pgtable: Do not drop upper 5 address bits of physical address

Helge Deller <deller@gmx.de>
    parisc: Prevent booting 64-bit kernels on PA1.x machines

Sanjuán García, Jorge <Jorge.SanjuanGarcia@duagon.com>
    mcb: fix error handling for different scenarios when parsing

Zhihao Cheng <chengzhihao1@huawei.com>
    jbd2: fix potential data lost in recovering journal raced with synchronizing fs bdev

Herve Codina <herve.codina@bootlin.com>
    genirq/generic_chip: Make irq_remove_generic_chip() irqdomain aware

Rong Chen <rong.chen@amlogic.com>
    mmc: meson-gx: Remove setting of CMD_CFG_ERROR

Brian Geffon <bgeffon@google.com>
    PM: hibernate: Clean up sync_read handling in snapshot_write_next()

Brian Geffon <bgeffon@google.com>
    PM: hibernate: Use __get_safe_page() rather than touching the list

Dan Carpenter <dan.carpenter@linaro.org>
    mmc: vub300: fix an error code

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

Dan Carpenter <dan.carpenter@linaro.org>
    pwm: Fix double shift bug

Bob Peterson <rpeterso@redhat.com>
    gfs2: ignore negated quota changes

Hans Verkuil <hverkuil-cisco@xs4all.nl>
    media: vivid: avoid integer overflow

Rajeshwar R Shinde <coolrrsh@gmail.com>
    media: gspca: cpia1: shift-out-of-bounds in set_flicker

Axel Lin <axel.lin@ingics.com>
    i2c: sun6i-p2wi: Prevent potential division by zero

Yi Yang <yiyang13@huawei.com>
    tty: vcc: Add check for kstrdup() in vcc_probe()

Wenchao Hao <haowenchao2@huawei.com>
    scsi: libfc: Fix potential NULL pointer dereference in fc_lport_ptp_setup()

Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
    atm: iphase: Do PCI error checks on own line

Cezary Rojewski <cezary.rojewski@intel.com>
    ALSA: hda: Fix possible null-ptr-deref when assigning a stream

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

Mario Limonciello <mario.limonciello@amd.com>
    drm/amd: Fix UBSAN array-index-out-of-bounds for Polaris and Tonga

Mario Limonciello <mario.limonciello@amd.com>
    drm/amd: Fix UBSAN array-index-out-of-bounds for SMU7

Eric Dumazet <edumazet@google.com>
    net: annotate data-races around sk->sk_dst_pending_confirm

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

John Stultz <jstultz@google.com>
    locking/ww_mutex/test: Fix potential workqueue corruption


-------------

Diffstat:

 Makefile                                           |  4 ++--
 arch/parisc/kernel/entry.S                         |  7 +++---
 arch/parisc/kernel/head.S                          |  5 ++---
 arch/x86/include/asm/msr-index.h                   |  1 +
 arch/x86/include/asm/numa.h                        |  7 ------
 arch/x86/kvm/x86.c                                 |  2 ++
 arch/x86/mm/numa.c                                 |  7 ------
 crypto/pcrypt.c                                    |  4 ++++
 drivers/atm/iphase.c                               | 20 +++++++++--------
 drivers/clocksource/tcb_clksrc.c                   |  1 +
 drivers/clocksource/timer-imx-gpt.c                | 18 +++++++++++-----
 drivers/gpu/drm/amd/include/pptable.h              |  4 ++--
 drivers/gpu/drm/amd/powerplay/hwmgr/pptable_v1_0.h | 16 +++++++-------
 drivers/i2c/busses/i2c-i801.c                      | 19 ++++++++--------
 drivers/i2c/busses/i2c-sun6i-p2wi.c                |  5 +++++
 drivers/infiniband/hw/hfi1/pcie.c                  |  9 ++------
 drivers/mcb/mcb-core.c                             |  1 +
 drivers/mcb/mcb-parse.c                            |  2 +-
 drivers/media/platform/qcom/venus/hfi_msgs.c       |  2 +-
 drivers/media/platform/qcom/venus/hfi_venus.c      | 10 +++++++++
 drivers/media/platform/vivid/vivid-rds-gen.c       |  2 +-
 drivers/media/rc/ir-sharp-decoder.c                |  8 ++++---
 drivers/media/usb/gspca/cpia1.c                    |  3 +++
 drivers/mmc/host/meson-gx-mmc.c                    |  1 -
 drivers/mmc/host/vub300.c                          |  1 +
 drivers/net/dsa/lan9303_mdio.c                     |  4 ++--
 drivers/net/wireless/ath/ath10k/debug.c            |  2 +-
 drivers/net/wireless/ath/ath9k/debug.c             |  2 +-
 drivers/net/wireless/ath/ath9k/htc_drv_debug.c     |  2 +-
 drivers/pci/pci-acpi.c                             |  2 +-
 drivers/pci/pci-sysfs.c                            |  5 +----
 drivers/scsi/libfc/fc_lport.c                      |  6 ++++++
 drivers/scsi/virtio_scsi.c                         |  1 +
 drivers/tty/hvc/hvc_xen.c                          |  5 +++--
 drivers/tty/vcc.c                                  | 16 +++++++++++---
 fs/ext4/acl.h                                      |  5 +++++
 fs/ext4/resize.c                                   | 19 ++++++----------
 fs/gfs2/quota.c                                    | 11 ++++++++++
 fs/jbd2/recovery.c                                 |  8 +++++++
 fs/jfs/jfs_dmap.c                                  | 23 +++++++++++++++-----
 fs/jfs/jfs_imap.c                                  |  5 ++++-
 include/linux/pwm.h                                |  4 ++--
 include/net/sock.h                                 |  6 +++---
 kernel/audit_watch.c                               |  9 +++++++-
 kernel/irq/generic-chip.c                          | 25 ++++++++++++++++------
 kernel/locking/test-ww_mutex.c                     | 20 ++++++++++-------
 kernel/padata.c                                    |  2 +-
 kernel/power/snapshot.c                            | 16 ++++++--------
 net/core/sock.c                                    |  2 +-
 net/ipv4/tcp_output.c                              |  2 +-
 net/mac80211/cfg.c                                 |  4 ++++
 net/sched/sch_api.c                                |  5 +++--
 scripts/gcc-plugins/randomize_layout_plugin.c      | 11 +++++++---
 sound/core/info.c                                  | 21 +++++++++++-------
 sound/hda/hdac_stream.c                            |  6 ++++--
 tools/testing/selftests/efivarfs/create-read.c     |  2 ++
 56 files changed, 259 insertions(+), 151 deletions(-)


