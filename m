Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF49E7F8E26
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 20:45:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbjKYTpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 14:45:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjKYTpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 14:45:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C413B3
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 11:45:16 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6424C433C7;
        Sat, 25 Nov 2023 19:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700941516;
        bh=5uxg7H44j/9hXDCtmzbCEr3DKqAFhI0SQICg2uwB2eQ=;
        h=From:To:Cc:Subject:Date:From;
        b=Nz4H8uraQQwDg6YLV+4ua811VtkMXg/00O8oKJDXy37ZMSJRpKU77i9+Qp90fzn4A
         Xt2ANSQ5z3ZM2Ed77/M/NQlRMhErIL5xs4oZPixGS1MyoxaP+cw+qLzhzm5ZMBlZVC
         fKdasPwA32QGcSZsqGy0NijK3FCVyCwK4vtb4Okg=
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
Subject: [PATCH 5.4 000/153] 5.4.262-rc3 review
Date:   Sat, 25 Nov 2023 19:45:13 +0000
Message-ID: <20231125194331.369464812@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.262-rc3.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.4.262-rc3
X-KernelTest-Deadline: 2023-11-27T19:43+00:00
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

This is the start of the stable review cycle for the 5.4.262 release.
There are 153 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Mon, 27 Nov 2023 19:43:06 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.262-rc3.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 5.4.262-rc3

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: bogus EBUSY when deleting flowtable after flush (for 5.4)

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: disable toggling dormant table state more than once

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: fix table flag updates

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nftables: update table flags from the commit phase

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: double hook unregistration in netns path

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: unregister flowtable hooks on netns exit

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: fix memleak when more than 255 elements expired

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nft_set_hash: try later when GC hits EAGAIN on iteration

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nft_set_rbtree: use read spinlock to avoid datapath contention

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nft_set_rbtree: skip sync GC for new elements in this transaction

Florian Westphal <fw@strlen.de>
    netfilter: nf_tables: defer gc run if previous batch is still pending

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: use correct lock to protect gc_list

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: GC transaction race with abort path

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: GC transaction race with netns dismantle

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: fix GC transaction races with netns and netlink event exit path

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: remove busy mark and gc batch API

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nft_set_hash: mark set element as dead when deleting from packet path

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: adapt set backend to use GC transaction API

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: GC transaction API to avoid race with control plane

Florian Westphal <fw@strlen.de>
    netfilter: nf_tables: don't skip expired elements during walk

Florian Westphal <fw@strlen.de>
    netfilter: nft_set_rbtree: fix overlap expiration walk

Florian Westphal <fw@strlen.de>
    netfilter: nft_set_rbtree: fix null deref on element insertion

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nft_set_rbtree: Switch to node list walk for overlap detection

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: drop map element references from preparation phase

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nftables: rename set element data activation/deactivation functions

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: pass context to nft_set_destroy()

Steven Rostedt (Google) <rostedt@goodmis.org>
    tracing: Have trace_event_file have ref counters

Christian König <christian.koenig@amd.com>
    drm/amdgpu: fix error handling in amdgpu_bo_list_get()

Kemeng Shi <shikemeng@huaweicloud.com>
    ext4: remove gdb backup copy for meta bg in setup_new_flex_group_blocks

Zhang Yi <yi.zhang@huawei.com>
    ext4: correct the start block of counting reserved clusters

Kemeng Shi <shikemeng@huaweicloud.com>
    ext4: correct return value of ext4_convert_meta_bg

Kemeng Shi <shikemeng@huaweicloud.com>
    ext4: correct offset of gdb backup in non meta_bg group to update_backups

Max Kellermann <max.kellermann@ionos.com>
    ext4: apply umask if ACL support is disabled

Heiner Kallweit <hkallweit1@gmail.com>
    Revert "net: r8169: Disable multicast filter for RTL8168H and RTL8107E"

Mahmoud Adam <mngyadam@amazon.com>
    nfsd: fix file memleak on client_opens_release

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

Johnathan Mantey <johnathanx.mantey@intel.com>
    Revert ncsi: Propagate carrier gain/loss events to the NCSI controller

Guan Wentao <guanwentao@uniontech.com>
    Bluetooth: btusb: Add 0bda:b85b for Fn-Link RTL8852BE

Masum Reza <masumrezarock100@gmail.com>
    Bluetooth: btusb: Add RTW8852BE device 13d3:3570 to device tables

Larry Finger <Larry.Finger@lwfinger.net>
    bluetooth: Add device 13d3:3571 to device tables

Larry Finger <Larry.Finger@lwfinger.net>
    bluetooth: Add device 0bda:887b to device tables

Artem Lukyanov <dukzcry@ya.ru>
    Bluetooth: btusb: Add Realtek RTL8852BE support ID 0x0cb8:0xc559

Joseph Hwang <josephsih@chromium.org>
    Bluetooth: btusb: add Realtek 8822CE to usb_device_id table

Alain Michaud <alainm@chromium.org>
    Bluetooth: btusb: Add flag to define wideband speech capability

Pavel Krasavin <pkrasavin@imaqliq.com>
    tty: serial: meson: fix hard LOCKUP on crtscts mode

Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
    serial: meson: Use platform_get_irq() to get the interrupt

Neil Armstrong <narmstrong@baylibre.com>
    tty: serial: meson: retrieve port FIFO size from DT

Colin Ian King <colin.king@canonical.com>
    serial: meson: remove redundant initialization of variable id

Chandradeep Dey <codesigning@chandradeepdey.com>
    ALSA: hda/realtek - Enable internal speaker of ASUS K6500ZC

Takashi Iwai <tiwai@suse.de>
    ALSA: info: Fix potential deadlock at disconnection

Helge Deller <deller@gmx.de>
    parisc/pgtable: Do not drop upper 5 address bits of physical address

Helge Deller <deller@gmx.de>
    parisc: Prevent booting 64-bit kernels on PA1.x machines

Joshua Yeong <joshua.yeong@starfivetech.com>
    i3c: master: cdns: Fix reading status register

Zi Yan <ziy@nvidia.com>
    mm/cma: use nth_page() in place of direct struct page manipulation

Heiko Carstens <hca@linux.ibm.com>
    s390/cmma: fix handling of swapper_pg_dir and invalid_pg_dir

Alain Volmat <alain.volmat@foss.st.com>
    dmaengine: stm32-mdma: correct desc prep when channel running

Sanjuán García, Jorge <Jorge.SanjuanGarcia@duagon.com>
    mcb: fix error handling for different scenarios when parsing

Benjamin Bara <benjamin.bara@skidata.com>
    i2c: core: Run atomic i2c xfer when !preemptible

Benjamin Bara <benjamin.bara@skidata.com>
    kernel/reboot: emergency_restart: Set correct system_state

Eric Biggers <ebiggers@google.com>
    quota: explicitly forbid quota files from being encrypted

Zhihao Cheng <chengzhihao1@huawei.com>
    jbd2: fix potential data lost in recovering journal raced with synchronizing fs bdev

Josef Bacik <josef@toxicpanda.com>
    btrfs: don't arbitrarily slow down delalloc if we're committing

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

Werner Sembach <wse@tuxedocomputers.com>
    ACPI: resource: Do IRQ override on TongFang GMxXGxx

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

Nicolas Saenz Julienne <nsaenz@amazon.com>
    KVM: x86: hyper-v: Don't auto-enable stimer on write from user-space

Pu Wen <puwen@hygon.cn>
    x86/cpu/hygon: Fix the CPU topology evaluation for real

Chandrakanth patil <chandrakanth.patil@broadcom.com>
    scsi: megaraid_sas: Increase register read retry rount from 3 to 30 for selected registers

Shung-Hsi Yu <shung-hsi.yu@suse.com>
    bpf: Fix precision tracking for BPF_ALU | BPF_TO_BE | BPF_END

Kees Cook <keescook@chromium.org>
    randstruct: Fix gcc-plugin performance mode to stay in group

Vikash Garodia <quic_vgarodia@quicinc.com>
    media: venus: hfi: add checks to perform sanity on queue pointers

Anastasia Belova <abelova@astralinux.ru>
    cifs: spnego: add ';' in HOST_KEY_LEN

Zhang Rui <rui.zhang@intel.com>
    tools/power/turbostat: Fix a knl bug

Vlad Buslov <vladbu@nvidia.com>
    macvlan: Don't propagate promisc change to lower dev in passthru

Rahul Rameshbabu <rrameshbabu@nvidia.com>
    net/mlx5e: Check return value of snprintf writing to fw_version buffer for representors

Leon Romanovsky <leonro@nvidia.com>
    net/mlx5_core: Clean driver version and name

Dust Li <dust.li@linux.alibaba.com>
    net/mlx5e: fix double free of encap_header

Baruch Siach <baruch@tkos.co.il>
    net: stmmac: fix rx budget limit check

Jose Abreu <Jose.Abreu@synopsys.com>
    net: stmmac: Rework stmmac_rx()

Linkui Xiao <xiaolinkui@kylinos.cn>
    netfilter: nf_conntrack_bridge: initialize err to 0

Linus Walleij <linus.walleij@linaro.org>
    net: ethernet: cortina: Fix MTU max setting

Linus Walleij <linus.walleij@linaro.org>
    net: ethernet: cortina: Handle large frames

Linus Walleij <linus.walleij@linaro.org>
    net: ethernet: cortina: Fix max RX frame define

Eric Dumazet <edumazet@google.com>
    bonding: stop the device in bond_setup_by_slave()

Eric Dumazet <edumazet@google.com>
    ptp: annotate data-race around q->head and q->tail

Juergen Gross <jgross@suse.com>
    xen/events: fix delayed eoi list handling

Willem de Bruijn <willemb@google.com>
    ppp: limit MRU to 64K

Shigeru Yoshida <syoshida@redhat.com>
    tipc: Fix kernel-infoleak due to uninitialized TLV value

Yonglong Liu <liuyonglong@huawei.com>
    net: hns3: fix variable may not initialized problem in hns3_init_mac_addr()

Shigeru Yoshida <syoshida@redhat.com>
    tty: Fix uninit-value access in ppp_sync_receive()

Eric Dumazet <edumazet@google.com>
    ipvlan: add ipvlan_route_v6_outbound() helper

Olga Kornievskaia <kolga@netapp.com>
    NFSv4.1: fix SP4_MACH_CRED protection for pnfs IO

Miri Korenblit <miriam.rachel.korenblit@intel.com>
    wifi: iwlwifi: Use FW rate for non-data frames

Dan Carpenter <dan.carpenter@linaro.org>
    pwm: Fix double shift bug

Tony Lindgren <tony@atomide.com>
    ASoC: ti: omap-mcbsp: Fix runtime PM underflow warnings

Douglas Anderson <dianders@chromium.org>
    kgdb: Flush console before entering kgdb on panic

Wayne Lin <wayne.lin@amd.com>
    drm/amd/display: Avoid NULL dereference of timing generator

Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
    media: cobalt: Use FIELD_GET() to extract Link Width

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

Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
    PCI: tegra194: Use FIELD_GET()/FIELD_PREP() with Link Width fields

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

baozhu.liu <lucas.liu@siengine.com>
    drm/komeda: drop all currently held locks if deadlock happens

Olli Asikainen <olli.asikainen@gmail.com>
    platform/x86: thinkpad_acpi: Add battery quirk for Thinkpad X120e

ZhengHan Wang <wzhmmmmm@gmail.com>
    Bluetooth: Fix double free in hci_conn_cleanup

Douglas Anderson <dianders@chromium.org>
    wifi: ath10k: Don't touch the CE interrupt registers after power up

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

Dmitry Antipov <dmantipov@yandex.ru>
    wifi: mac80211_hwsim: fix clang-specific fortify warning

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

 Makefile                                           |   4 +-
 arch/arm/include/asm/exception.h                   |   4 -
 arch/parisc/include/uapi/asm/pdc.h                 |   1 +
 arch/parisc/kernel/entry.S                         |   7 +-
 arch/parisc/kernel/head.S                          |   5 +-
 arch/s390/mm/page-states.c                         |   6 +
 arch/x86/include/asm/msr-index.h                   |   1 +
 arch/x86/include/asm/numa.h                        |   7 -
 arch/x86/kernel/cpu/hygon.c                        |   8 +-
 arch/x86/kvm/hyperv.c                              |  10 +-
 arch/x86/kvm/x86.c                                 |   2 +
 arch/x86/mm/numa.c                                 |   7 -
 crypto/pcrypt.c                                    |   4 +
 drivers/acpi/resource.c                            |  12 +
 drivers/atm/iphase.c                               |  20 +-
 drivers/bluetooth/btusb.c                          |  35 +-
 drivers/clk/qcom/gcc-ipq8074.c                     |   6 -
 drivers/clocksource/timer-atmel-tcb.c              |   1 +
 drivers/clocksource/timer-imx-gpt.c                |  18 +-
 drivers/dma/stm32-mdma.c                           |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c        |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c        |   6 +
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c    |   4 +-
 drivers/gpu/drm/amd/include/pptable.h              |   4 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/pptable_v1_0.h |  16 +-
 .../drm/arm/display/komeda/komeda_pipeline_state.c |   9 +-
 drivers/hid/hid-ids.h                              |   1 +
 drivers/hid/hid-quirks.c                           |   1 +
 drivers/i2c/busses/i2c-i801.c                      |  19 +-
 drivers/i2c/busses/i2c-sun6i-p2wi.c                |   5 +
 drivers/i2c/i2c-core.h                             |   2 +-
 drivers/i3c/master/i3c-master-cdns.c               |   6 +-
 drivers/infiniband/hw/hfi1/pcie.c                  |   9 +-
 drivers/mcb/mcb-core.c                             |   1 +
 drivers/mcb/mcb-parse.c                            |   2 +-
 drivers/media/pci/cobalt/cobalt-driver.c           |  11 +-
 drivers/media/platform/qcom/venus/hfi_msgs.c       |   2 +-
 drivers/media/platform/qcom/venus/hfi_parser.c     |  15 +
 drivers/media/platform/qcom/venus/hfi_venus.c      |  10 +
 drivers/media/platform/vivid/vivid-rds-gen.c       |   2 +-
 drivers/media/rc/ir-sharp-decoder.c                |   8 +-
 drivers/media/rc/lirc_dev.c                        |   6 +-
 drivers/media/usb/gspca/cpia1.c                    |   3 +
 drivers/mmc/host/meson-gx-mmc.c                    |   1 -
 drivers/mmc/host/vub300.c                          |   1 +
 drivers/net/bonding/bond_main.c                    |   6 +
 drivers/net/dsa/lan9303_mdio.c                     |   4 +-
 drivers/net/ethernet/cortina/gemini.c              |  45 +-
 drivers/net/ethernet/cortina/gemini.h              |   4 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    |   2 +-
 drivers/net/ethernet/mellanox/mlx5/core/devlink.c  |   2 +-
 .../net/ethernet/mellanox/mlx5/core/en/tc_tun.c    |  10 +-
 .../net/ethernet/mellanox/mlx5/core/en_ethtool.c   |   4 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c   |  13 +-
 .../ethernet/mellanox/mlx5/core/ipoib/ethtool.c    |   2 +-
 drivers/net/ethernet/mellanox/mlx5/core/main.c     |  10 +-
 .../net/ethernet/mellanox/mlx5/core/mlx5_core.h    |   3 -
 drivers/net/ethernet/realtek/r8169_main.c          |   4 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  | 148 +++---
 drivers/net/ipvlan/ipvlan_core.c                   |  41 +-
 drivers/net/macvlan.c                              |   2 +-
 drivers/net/ppp/ppp_synctty.c                      |   6 +-
 drivers/net/wireless/ath/ath10k/debug.c            |   2 +-
 drivers/net/wireless/ath/ath10k/snoc.c             |  18 +-
 drivers/net/wireless/ath/ath9k/debug.c             |   2 +-
 drivers/net/wireless/ath/ath9k/htc_drv_debug.c     |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c        |  14 +-
 drivers/net/wireless/mac80211_hwsim.c              |   2 +-
 drivers/pci/controller/dwc/pci-keystone.c          |   8 +-
 drivers/pci/controller/dwc/pcie-tegra194.c         |   9 +-
 drivers/pci/pci-acpi.c                             |   2 +-
 drivers/pci/pci-sysfs.c                            |   5 +-
 drivers/platform/x86/thinkpad_acpi.c               |   1 +
 drivers/ptp/ptp_chardev.c                          |   3 +-
 drivers/ptp/ptp_clock.c                            |   5 +-
 drivers/ptp/ptp_private.h                          |   8 +-
 drivers/ptp/ptp_sysfs.c                            |   3 +-
 drivers/scsi/libfc/fc_lport.c                      |   6 +
 drivers/scsi/megaraid/megaraid_sas_base.c          |   4 +-
 drivers/tty/hvc/hvc_xen.c                          |   5 +-
 drivers/tty/serial/meson_uart.c                    |  33 +-
 drivers/tty/vcc.c                                  |  16 +-
 drivers/usb/gadget/function/f_ncm.c                |  27 +-
 drivers/xen/events/events_base.c                   |   4 +-
 fs/btrfs/delalloc-space.c                          |   3 -
 fs/cifs/cifs_spnego.c                              |   4 +-
 fs/ext4/acl.h                                      |   5 +
 fs/ext4/extents_status.c                           |   4 +-
 fs/ext4/resize.c                                   |  19 +-
 fs/gfs2/quota.c                                    |  11 +
 fs/jbd2/recovery.c                                 |   8 +
 fs/jfs/jfs_dmap.c                                  |  23 +-
 fs/jfs/jfs_imap.c                                  |   5 +-
 fs/nfs/nfs4proc.c                                  |   5 +-
 fs/nfsd/nfs4state.c                                |   2 +-
 fs/quota/dquot.c                                   |  14 +
 include/linux/mlx5/driver.h                        |   2 +
 include/linux/pwm.h                                |   4 +-
 include/linux/trace_events.h                       |   4 +
 include/net/netfilter/nf_tables.h                  | 129 ++----
 include/net/sock.h                                 |  26 +-
 include/uapi/linux/netfilter/nf_tables.h           |   1 +
 kernel/audit_watch.c                               |   9 +-
 kernel/bpf/verifier.c                              |   7 +-
 kernel/debug/debug_core.c                          |   3 +
 kernel/events/ring_buffer.c                        |   6 +
 kernel/irq/generic-chip.c                          |  25 +-
 kernel/locking/test-ww_mutex.c                     |  20 +-
 kernel/padata.c                                    |   2 +-
 kernel/power/snapshot.c                            |  16 +-
 kernel/reboot.c                                    |   1 +
 kernel/trace/trace.c                               |  15 +
 kernel/trace/trace.h                               |   3 +
 kernel/trace/trace_events.c                        |  39 +-
 kernel/trace/trace_events_filter.c                 |   3 +
 mm/cma.c                                           |   2 +-
 net/bluetooth/hci_conn.c                           |   6 +-
 net/bluetooth/hci_sysfs.c                          |  23 +-
 net/bridge/netfilter/nf_conntrack_bridge.c         |   2 +-
 net/core/sock.c                                    |   2 +-
 net/ipv4/tcp_output.c                              |   2 +-
 net/mac80211/cfg.c                                 |   4 +
 net/ncsi/ncsi-aen.c                                |   5 -
 net/netfilter/nf_tables_api.c                      | 512 +++++++++++++++++----
 net/netfilter/nft_chain_filter.c                   |   3 +
 net/netfilter/nft_set_bitmap.c                     |   5 +-
 net/netfilter/nft_set_hash.c                       | 110 +++--
 net/netfilter/nft_set_rbtree.c                     | 375 ++++++++++++---
 net/tipc/netlink_compat.c                          |   1 +
 scripts/gcc-plugins/randomize_layout_plugin.c      |  11 +-
 sound/core/info.c                                  |  21 +-
 sound/hda/hdac_stream.c                            |   6 +-
 sound/pci/hda/patch_realtek.c                      |   1 +
 sound/soc/ti/omap-mcbsp.c                          |   6 +-
 tools/power/x86/turbostat/turbostat.c              |   2 +-
 tools/testing/selftests/efivarfs/create-read.c     |   2 +
 136 files changed, 1632 insertions(+), 679 deletions(-)


