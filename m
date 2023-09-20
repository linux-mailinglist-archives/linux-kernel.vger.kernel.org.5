Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1C87A7F34
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 14:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235808AbjITMZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 08:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235975AbjITMZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 08:25:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 095AFA3;
        Wed, 20 Sep 2023 05:25:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2D03C433C8;
        Wed, 20 Sep 2023 12:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695212700;
        bh=cvOwJF764Jxca3TysJY4fe9TgZ1uVMHGY61WEj31hrM=;
        h=From:To:Cc:Subject:Date:From;
        b=eOP9VPvjKI9k78PNcJw+IISnZa3Gr38uo4g8Pdyp0E9kCQ3jfhKy17m4eJ01FNUYV
         CDDQbx6vAYz/3mGy3P7EDgUwkuXFPnfVH7D1o9NFJk1X7JtnZn8jP00H1tIdivCWsS
         56HRmTCW5WI8KHQxgCB3Zt+YBs2j/jqcE+pHJXto=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: [PATCH 5.4 000/367] 5.4.257-rc1 review
Date:   Wed, 20 Sep 2023 13:26:17 +0200
Message-ID: <20230920112858.471730572@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.257-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.4.257-rc1
X-KernelTest-Deadline: 2023-09-22T11:29+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 5.4.257 release.
There are 367 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Fri, 22 Sep 2023 11:28:09 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.257-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 5.4.257-rc1

Jamal Hadi Salim <jhs@mojatatu.com>
    net/sched: Retire rsvp classifier

Christian König <christian.koenig@amd.com>
    drm/amdgpu: fix amdgpu_cs_p1_user_fence

William Zhang <william.zhang@broadcom.com>
    mtd: rawnand: brcmnand: Fix ECC level field setting for v7.2 controller

Shida Zhang <zhangshida@kylinos.cn>
    ext4: fix rec_len verify error

Junxiao Bi <junxiao.bi@oracle.com>
    scsi: megaraid_sas: Fix deadlock on firmware crashdump

Tommy Huang <tommy_huang@aspeedtech.com>
    i2c: aspeed: Reset the i2c controller when timeout occurs

Steven Rostedt (Google) <rostedt@goodmis.org>
    tracefs: Add missing lockdown check to tracefs_create_dir()

Jeff Layton <jlayton@kernel.org>
    nfsd: fix change_info in NFSv4 RENAME replies

Steven Rostedt (Google) <rostedt@goodmis.org>
    tracing: Have option files inc the trace array ref count

Steven Rostedt (Google) <rostedt@goodmis.org>
    tracing: Have current_trace inc the trace array ref count

Filipe Manana <fdmanana@suse.com>
    btrfs: fix lockdep splat and potential deadlock after failure running delayed items

Christian Brauner <brauner@kernel.org>
    attr: block mode changes of symlinks

Nigel Croxon <ncroxon@redhat.com>
    md/raid1: fix error: ISO C90 forbids mixed declarations

Masami Hiramatsu (Google) <mhiramat@kernel.org>
    selftests: tracing: Fix to unmount tracefs for recovering environment

Anand Jain <anand.jain@oracle.com>
    btrfs: compare the correct fsid/metadata_uuid in btrfs_validate_super

Anand Jain <anand.jain@oracle.com>
    btrfs: add a helper to read the superblock metadata_uuid

Josef Bacik <josef@toxicpanda.com>
    btrfs: move btrfs_pinned_by_swapfile prototype into volumes.h

Namhyung Kim <namhyung@kernel.org>
    perf build: Update build rule for generated files

Ian Rogers <rogers.email@gmail.com>
    perf jevents: Switch build to use jevents.py

Ian Rogers <irogers@google.com>
    perf tools: Add an option to build without libbfd

John Garry <john.garry@huawei.com>
    perf jevents: Make build dependency on test JSONs

Arnaldo Carvalho de Melo <acme@redhat.com>
    tools features: Add feature test to check if libbfd has buildid support

Zhen Lei <thunder.leizhen@huawei.com>
    kobject: Add sanity check for kset->kobj.ktype in kset_register()

Sakari Ailus <sakari.ailus@linux.intel.com>
    media: pci: ipu3-cio2: Initialise timing struct to avoid a compiler warning

Christophe Leroy <christophe.leroy@csgroup.eu>
    serial: cpm_uart: Avoid suspicious locking

Konstantin Shelekhin <k.shelekhin@yadro.com>
    scsi: target: iscsi: Fix buffer overflow in lio_target_nacl_info_show()

Ma Ke <make_ruc2021@163.com>
    usb: gadget: fsl_qe_udc: validate endpoint index for ch9 udc

Hans Verkuil <hverkuil-cisco@xs4all.nl>
    media: pci: cx23885: replace BUG with error return

Hans Verkuil <hverkuil-cisco@xs4all.nl>
    media: tuners: qt1010: replace BUG_ON with a regular error

Zhang Shurong <zhang_shurong@foxmail.com>
    media: az6007: Fix null-ptr-deref in az6007_i2c_xfer()

Zhang Shurong <zhang_shurong@foxmail.com>
    media: anysee: fix null-ptr-deref in anysee_master_xfer

Zhang Shurong <zhang_shurong@foxmail.com>
    media: af9005: Fix null-ptr-deref in af9005_i2c_xfer

Zhang Shurong <zhang_shurong@foxmail.com>
    media: dw2102: Fix null-ptr-deref in dw2102_i2c_transfer()

Zhang Shurong <zhang_shurong@foxmail.com>
    media: dvb-usb-v2: af9035: Fix null-ptr-deref in af9035_i2c_master_xfer

ruanjinjie <ruanjinjie@huawei.com>
    powerpc/pseries: fix possible memory leak in ibmebus_bus_init()

Liu Shixin via Jfs-discussion <jfs-discussion@lists.sourceforge.net>
    jfs: fix invalid free of JFS_IP(ipimap)->i_imap in diUnmount

Andrew Kanner <andrew.kanner@gmail.com>
    fs/jfs: prevent double-free in dbUnmount() after failed jfs_remount()

Georg Ottinger <g.ottinger@gmx.at>
    ext2: fix datatype of block number in ext2_xattr_set2()

Zhang Shurong <zhang_shurong@foxmail.com>
    md: raid1: fix potential OOB in raid1_remove_disk()

Tony Lindgren <tony@atomide.com>
    bus: ti-sysc: Configure uart quirks for k3 SoC

Tuo Li <islituo@gmail.com>
    drm/exynos: fix a possible null-pointer dereference due to data race in exynos_drm_crtc_atomic_disable()

Hao Luo <haoluo@google.com>
    libbpf: Free btf_vmlinux when closing bpf_object

Johannes Berg <johannes.berg@intel.com>
    wifi: mac80211_hwsim: drop short frames

GONG, Ruiqi <gongruiqi1@huawei.com>
    alx: fix OOB-read compiler warning

Giulio Benetti <giulio.benetti@benettiengineering.com>
    mmc: sdhci-esdhc-imx: improve ESDHC_FLAG_ERR010450

Alexander Steffen <Alexander.Steffen@infineon.com>
    tpm_tis: Resend command to recover from data transfer errors

Mark O'Donovan <shiftee@posteo.net>
    crypto: lib/mpi - avoid null pointer deref in mpi_cmp_ui()

Dmitry Antipov <dmantipov@yandex.ru>
    wifi: mwifiex: fix fortify warning

Dongliang Mu <dzm91@hust.edu.cn>
    wifi: ath9k: fix printk specifier

Jiri Pirko <jiri@nvidia.com>
    devlink: remove reload failed checks in params get/set callbacks

Tomislav Novak <tnovak@meta.com>
    hw_breakpoint: fix single-stepping when using bpf_overflow_handler

Yicong Yang <yangyicong@hisilicon.com>
    perf/smmuv3: Enable HiSilicon Erratum 162001900 quirk for HIP08/09

Jiri Slaby (SUSE) <jirislaby@kernel.org>
    ACPI: video: Add backlight=native DMI quirk for Lenovo Ideapad Z470

Wander Lairson Costa <wander@redhat.com>
    kernel/fork: beware of __put_task_struct() calling context

Abhishek Mainkar <abmainkar@nvidia.com>
    ACPICA: Add AML_NO_OPERAND_RESOLVE flag to Timer

Will Shiu <Will.Shiu@mediatek.com>
    locks: fix KASAN: use-after-free in trace_event_raw_event_filelock_lock

Qu Wenruo <wqu@suse.com>
    btrfs: output extra debug info if we failed to find an inline backref

Fedor Pchelkin <pchelkin@ispras.ru>
    autofs: fix memory leak of waitqueues in autofs_catatonic_mode

Helge Deller <deller@gmx.de>
    parisc: Drop loops_per_jiffy from per_cpu struct

Wesley Chalmers <wesley.chalmers@amd.com>
    drm/amd/display: Fix a bug when searching for insert_above_mpcc

Kuniyuki Iwashima <kuniyu@amazon.com>
    kcm: Fix error handling for SOCK_DGRAM in kcm_sendmsg().

Vadim Fedorenko <vadim.fedorenko@linux.dev>
    ixgbe: fix timestamp configuration code

Liu Jian <liujian56@huawei.com>
    net/tls: do not free tls_rec on async operation in bpf_exec_tx_verdict()

Liming Sun <limings@nvidia.com>
    platform/mellanox: mlxbf-tmfifo: Drop jumbo frames

Michael S. Tsirkin <mst@redhat.com>
    mlxbf-tmfifo: sparse tags for config access

Liming Sun <limings@nvidia.com>
    platform/mellanox: mlxbf-tmfifo: Drop the Rx packet if no more descriptors

Shigeru Yoshida <syoshida@redhat.com>
    kcm: Fix memory leak in error path of kcm_sendmsg()

Hayes Wang <hayeswang@realtek.com>
    r8152: check budget for r8152_poll()

Hangyu Hua <hbh25y@gmail.com>
    net: ethernet: mtk_eth_soc: fix possible NULL pointer dereference in mtk_hwlro_get_fdir_all()

Hangyu Hua <hbh25y@gmail.com>
    net: ethernet: mvpp2_main: fix possible OOB write in mvpp2_ethtool_get_rxnfc()

Liu Jian <liujian56@huawei.com>
    net: ipv4: fix one memleak in __inet_del_ifa()

Ahmad Fatoum <a.fatoum@pengutronix.de>
    clk: imx: pll14xx: dynamically configure PLL for 393216000/361267200Hz

Anson Huang <Anson.Huang@nxp.com>
    clk: imx: pll14xx: Add new frequency entries for pll1443x table

YueHaibing <yuehaibing@huawei.com>
    clk: imx: clk-pll14xx: Make two variables static

Anson Huang <Anson.Huang@nxp.com>
    clk: imx8mm: Move 1443X/1416X PLL clock structure to common place

Aleksey Nasibulin <alealexpro100@ya.ru>
    ARM: dts: BCM5301X: Extend RAM to full 256MB for Linksys EA6500 V2

RD Babiera <rdbabiera@google.com>
    usb: typec: bus: verify partner exists in typec_altmode_attention

Hans de Goede <hdegoede@redhat.com>
    usb: typec: tcpm: Refactor tcpm_handle_vdm_request

Hans de Goede <hdegoede@redhat.com>
    usb: typec: tcpm: Refactor tcpm_handle_vdm_request payload handling

Namhyung Kim <namhyung@kernel.org>
    perf tools: Handle old data in PERF_RECORD_ATTR

Namhyung Kim <namhyung@kernel.org>
    perf hists browser: Fix hierarchy mode header

William Zhang <william.zhang@broadcom.com>
    mtd: rawnand: brcmnand: Fix potential false time out warning

William Zhang <william.zhang@broadcom.com>
    mtd: rawnand: brcmnand: Fix potential out-of-bounds access in oob write

William Zhang <william.zhang@broadcom.com>
    mtd: rawnand: brcmnand: Fix crash during the panic_write

Anand Jain <anand.jain@oracle.com>
    btrfs: use the correct superblock to compare fsid in btrfs_validate_super

Filipe Manana <fdmanana@suse.com>
    btrfs: don't start transaction when joining with TRANS_JOIN_NOSTART

ruanmeisi <ruan.meisi@zte.com.cn>
    fuse: nlookup missing decrement in fuse_direntplus_link

Damien Le Moal <dlemoal@kernel.org>
    ata: pata_ftide010: Add missing MODULE_DESCRIPTION

Damien Le Moal <dlemoal@kernel.org>
    ata: sata_gemini: Add missing MODULE_DESCRIPTION

Petr Tesarik <petr.tesarik.ext@huawei.com>
    sh: boards: Fix CEU buffer size passed to dma_declare_coherent_memory()

Yisen Zhuang <yisen.zhuang@huawei.com>
    net: hns3: fix the port information display when sfp is absent

Wander Lairson Costa <wander@redhat.com>
    netfilter: nfnetlink_osf: avoid OOB read

Eric Dumazet <edumazet@google.com>
    ip_tunnels: use DEV_STATS_INC()

Ariel Marcovitch <arielmarcovitch@gmail.com>
    idr: fix param name in idr_alloc_cyclic() doc

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    s390/zcrypt: don't leak memory if dev_set_name() fails

Olga Zaborska <olga.zaborska@intel.com>
    igb: Change IGB_MIN to allow set rx/tx value between 64 and 80

Olga Zaborska <olga.zaborska@intel.com>
    igbvf: Change IGBVF_MIN to allow set rx/tx value between 64 and 80

Olga Zaborska <olga.zaborska@intel.com>
    igc: Change IGC_MIN to allow set rx/tx value between 64 and 80

Shigeru Yoshida <syoshida@redhat.com>
    kcm: Destroy mutex in kcm_exit_net()

valis <sec@valis.email>
    net: sched: sch_qfq: Fix UAF in qfq_dequeue()

Kuniyuki Iwashima <kuniyu@amazon.com>
    af_unix: Fix data race around sk->sk_err.

Kuniyuki Iwashima <kuniyu@amazon.com>
    af_unix: Fix data-races around sk->sk_shutdown.

Kuniyuki Iwashima <kuniyu@amazon.com>
    af_unix: Fix data-race around unix_tot_inflight.

Kuniyuki Iwashima <kuniyu@amazon.com>
    af_unix: Fix data-races around user->unix_inflight.

Alex Henrie <alexhenrie24@gmail.com>
    net: ipv6/addrconf: avoid integer underflow in ipv6_create_tempaddr

Liang Chen <liangchen.linux@gmail.com>
    veth: Fixing transmit return status for dropped packets

Corinna Vinschen <vinschen@redhat.com>
    igb: disable virtualization features on 82580

Eric Dumazet <edumazet@google.com>
    net: read sk->sk_family once in sk_mc_loop()

Eric Dumazet <edumazet@google.com>
    ipv4: annotate data-races around fi->fib_dead

Eric Dumazet <edumazet@google.com>
    sctp: annotate data-races around sk->sk_wmem_queued

Vladimir Zapolskiy <vz@mleia.com>
    pwm: lpc32xx: Remove handling of PWM channels

Raag Jadav <raag.jadav@intel.com>
    watchdog: intel-mid_wdt: add MODULE_ALIAS() to allow auto-load

Arnaldo Carvalho de Melo <acme@redhat.com>
    perf top: Don't pass an ERR_PTR() directly to perf_session__delete()

Sean Christopherson <seanjc@google.com>
    x86/virt: Drop unnecessary check on extended CPUID level in cpu_has_svm()

Arnaldo Carvalho de Melo <acme@redhat.com>
    perf annotate bpf: Don't enclose non-debug code with an assert()

Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
    kconfig: fix possible buffer overflow

Fedor Pchelkin <pchelkin@ispras.ru>
    NFSv4/pnfs: minor fix for cleanup path in nfs4_get_device_info

Chris Lew <quic_clew@quicinc.com>
    soc: qcom: qmi_encdec: Restrict string length in decode

Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
    clk: qcom: gcc-mdm9615: use proper parent for pll0_vote clock

Helge Deller <deller@gmx.de>
    parisc: led: Reduce CPU overhead for disk & lan LED computation

Helge Deller <deller@gmx.de>
    parisc: led: Fix LAN receive and transmit LEDs

Andrew Donnellan <ajd@linux.ibm.com>
    lib/test_meminit: allocate pages up to order MAX_ORDER

Thomas Zimmermann <tzimmermann@suse.de>
    drm/ast: Fix DRAM init on AST2200

Thomas Zimmermann <tzimmermann@suse.de>
    fbdev/ep93xx-fb: Do not assign to struct fb_info.dev

Manish Rangankar <mrangankar@marvell.com>
    scsi: qla2xxx: Remove unsupported ql2xenabledif option

Quinn Tran <qutran@marvell.com>
    scsi: qla2xxx: Turn off noisy message log

Quinn Tran <qutran@marvell.com>
    scsi: qla2xxx: Fix erroneous link up failure

Quinn Tran <qutran@marvell.com>
    scsi: qla2xxx: fix inconsistent TMF timeout

Quan Tian <qtian@vmware.com>
    net/ipv6: SKB symmetric hash should incorporate transport ports

Jia Yang <jiayang5@huawei.com>
    drm: fix double free for gbo in drm_gem_vram_init and drm_gem_vram_create

Tom Rix <trix@redhat.com>
    udf: initialize newblock to 0

Marco Felsch <m.felsch@pengutronix.de>
    usb: typec: tcpci: clear the fault status bit

Hugo Villeneuve <hvilleneuve@dimonoff.com>
    serial: sc16is7xx: fix broken port 0 uart init

Daniel Mack <daniel@zonque.org>
    sc16is7xx: Set iobase to device index

Gustavo A. R. Silva <gustavoars@kernel.org>
    cpufreq: brcmstb-avs-cpufreq: Fix -Warray-bounds bug

Thomas Bourgoin <thomas.bourgoin@foss.st.com>
    crypto: stm32 - fix loop iterating through scatterlist for DMA

Sven Schnelle <svens@linux.ibm.com>
    s390/ipl: add missing secure/has_secure file to ipl type 'unknown'

Enlin Mu <enlin.mu@unisoc.com>
    pstore/ram: Check start of empty przs during init

Eric Biggers <ebiggers@google.com>
    fsverity: skip PKCS#7 parser when keyring is empty

Nicolas Dichtel <nicolas.dichtel@6wind.com>
    net: handle ARPHRD_PPP in dev_is_mac_header_xmit()

Thore Sommer <public@thson.de>
    X.509: if signature is unsupported skip validation

Jann Horn <jannh@google.com>
    dccp: Fix out of bounds access in DCCP error handler

Alexander Aring <aahringo@redhat.com>
    dlm: fix plock lookup when using multiple lockspaces

Helge Deller <deller@gmx.de>
    parisc: Fix /proc/cpuinfo output for lscpu

Aleksa Sarai <cyphar@cyphar.com>
    procfs: block chmod on /proc/thread-self/comm

Bjorn Helgaas <bhelgaas@google.com>
    Revert "PCI: Mark NVIDIA T4 GPUs to avoid bus reset"

Dave Jiang <dave.jiang@intel.com>
    ntb: Fix calculation ntb_transport_tx_free_entry()

Dave Jiang <dave.jiang@intel.com>
    ntb: Clean up tx tail index on link down

Dave Jiang <dave.jiang@intel.com>
    ntb: Drop packets when qp link is down

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    media: dvb: symbol fixup for dvb_attach()

Max Filippov <jcmvbkbc@gmail.com>
    xtensa: PMU: fix base address for the newer hardware

Thomas Zimmermann <tzimmermann@suse.de>
    backlight/lv5207lp: Compare against struct fb_info.device

Thomas Zimmermann <tzimmermann@suse.de>
    backlight/bd6107: Compare against struct fb_info.device

Thomas Zimmermann <tzimmermann@suse.de>
    backlight/gpio_backlight: Compare against struct fb_info.device

Gustavo A. R. Silva <gustavoars@kernel.org>
    ARM: OMAP2+: Fix -Warray-bounds warning in _pwrdm_state_switch()

Yi Yang <yiyang13@huawei.com>
    ipmi_si: fix a memleak in try_smi_init()

Takashi Iwai <tiwai@suse.de>
    ALSA: pcm: Fix missing fixup call in compat hw_refine ioctl

Boris Brezillon <boris.brezillon@collabora.com>
    PM / devfreq: Fix leak in devfreq_dev_release()

Radoslaw Tyl <radoslawx.tyl@intel.com>
    igb: set max size RX buffer when store bad packet is enabled

Mohamed Khalfella <mkhalfella@purestorage.com>
    skbuff: skb_segment, Call zero copy functions before using skbuff frags

Wander Lairson Costa <wander@redhat.com>
    netfilter: xt_sctp: validate the flag_info count

Wander Lairson Costa <wander@redhat.com>
    netfilter: xt_u32: validate user space input

Kyle Zeng <zengyhkyle@gmail.com>
    netfilter: ipset: add the missing IP_SET_HASH_WITH_NET0 macro for ip_set_hash_netportnet.c

Eric Dumazet <edumazet@google.com>
    igmp: limit igmpv3_newpack() packet size to IP_MAX_MTU

Yuan Yao <yuanyaogoog@chromium.org>
    virtio_ring: fix avail_wrap_counter in virtqueue_add_packed

Liao Chang <liaochang1@huawei.com>
    cpufreq: Fix the race condition while updating the transition_task of policy

ruanjinjie <ruanjinjie@huawei.com>
    dmaengine: ste_dma40: Add missing IRQ check in d40_probe

Randy Dunlap <rdunlap@infradead.org>
    um: Fix hostaudio build errors

Yi Yang <yiyang13@huawei.com>
    mtd: rawnand: fsmc: handle clk prepare error in fsmc_nand_resume()

Jiasheng Jiang <jiasheng@iscas.ac.cn>
    rpmsg: glink: Add check for kstrdup

Jonas Karlman <jonas@kwiboo.se>
    phy/rockchip: inno-hdmi: do not power on rk3328 post pll on reg write

Zheng Yang <zhengyang@rock-chips.com>
    phy/rockchip: inno-hdmi: round fractal pixclock in rk3328 recalc_rate

Jonas Karlman <jonas@kwiboo.se>
    phy/rockchip: inno-hdmi: use correct vco_div_5 macro on rk3328

Zheng Yejian <zhengyejian1@huawei.com>
    tracing: Fix race issue between cpu buffer write and swap

Dave Hansen <dave.hansen@linux.intel.com>
    x86/speculation: Mark all Skylake CPUs as vulnerable to GDS

Rahul Rameshbabu <sergeantsagara@protonmail.com>
    HID: multitouch: Correct devm device reference for hidinput input_dev name

Nikita Zhandarovich <n.zhandarovich@fintech.ru>
    HID: logitech-dj: Fix error handling in logi_dj_recv_switch_to_dj_mode()

Guoqing Jiang <guoqing.jiang@linux.dev>
    RDMA/siw: Correct wrong debug message

Guoqing Jiang <guoqing.jiang@linux.dev>
    RDMA/siw: Balance the reference of cep->kref in the error path

Leon Romanovsky <leonro@nvidia.com>
    Revert "IB/isert: Fix incorrect release of isert connection"

Peng Fan <peng.fan@nxp.com>
    amba: bus: fix refcount leak

Yi Yang <yiyang13@huawei.com>
    serial: tegra: handle clk prepare error in tegra_uart_hw_init()

Chengfeng Ye <dg573847474@gmail.com>
    scsi: fcoe: Fix potential deadlock on &fip->ctlr_lock

Tony Battersby <tonyb@cybernetics.com>
    scsi: core: Use 32-bit hostnum in scsi_host_lookup()

Hans de Goede <hdegoede@redhat.com>
    media: ov2680: Fix regulators being left enabled on ov2680_power_on() errors

Hans de Goede <hdegoede@redhat.com>
    media: ov2680: Fix vflip / hflip set functions

Hans de Goede <hdegoede@redhat.com>
    media: ov2680: Fix ov2680_bayer_order()

Hans de Goede <hdegoede@redhat.com>
    media: ov2680: Remove auto-gain and auto-exposure controls

Dave Stevenson <dave.stevenson@raspberrypi.com>
    media: i2c: ov2680: Set V4L2_CTRL_FLAG_MODIFY_LAYOUT on flips

Marek Vasut <marex@denx.de>
    media: ov5640: Enable MIPI interface in ov5640_set_power_mipi()

Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
    media: i2c: ov5640: Configure HVP lines in s_power callback

Alan Stern <stern@rowland.harvard.edu>
    USB: gadget: f_mass_storage: Fix unused variable warning

Colin Ian King <colin.i.king@gmail.com>
    media: go7007: Remove redundant if statement

Yanfei Xu <yanfei.xu@intel.com>
    iommu/vt-d: Fix to flush cache of PASID directory table

Xiang Yang <xiangyang3@huawei.com>
    IB/uverbs: Fix an potential error pointer dereference

Dan Carpenter <dan.carpenter@linaro.org>
    driver core: test_async: fix an error code

Rob Clark <robdclark@chromium.org>
    dma-buf/sync_file: Fix docs syntax

Ruidong Tian <tianruidong@linux.alibaba.com>
    coresight: tmc: Explicit type conversions to prevent integer overflow

Oleksandr Natalenko <oleksandr@redhat.com>
    scsi: qedf: Do not touch __user pointer in qedf_dbg_fp_int_cmd_read() directly

Oleksandr Natalenko <oleksandr@redhat.com>
    scsi: qedf: Do not touch __user pointer in qedf_dbg_debug_cmd_read() directly

Oleksandr Natalenko <oleksandr@redhat.com>
    scsi: qedf: Do not touch __user pointer in qedf_dbg_stop_io_on_error_cmd_read() directly

Randy Dunlap <rdunlap@infradead.org>
    x86/APM: drop the duplicate APM_MINOR_DEV macro

Chunyan Zhang <chunyan.zhang@unisoc.com>
    serial: sprd: Fix DMA buffer leak issue

Chunyan Zhang <chunyan.zhang@unisoc.com>
    serial: sprd: Assign sprd_port after initialized to avoid wrong access

Chunyan Zhang <chunyan.zhang@unisoc.com>
    serial: sprd: remove redundant sprd_port cleanup

Chunyan Zhang <chunyan.zhang@unisoc.com>
    serial: sprd: getting port index via serial aliases only

Lin Ma <linma@zju.edu.cn>
    scsi: qla4xxx: Add length check when parsing nlattrs

Lin Ma <linma@zju.edu.cn>
    scsi: be2iscsi: Add length check when parsing nlattrs

Lin Ma <linma@zju.edu.cn>
    scsi: iscsi: Add strlen() check in iscsi_if_set{_host}_param()

Xu Yang <xu.yang_2@nxp.com>
    usb: phy: mxs: fix getting wrong state with mxs_phy_is_otg_host()

Irui Wang <irui.wang@mediatek.com>
    media: mediatek: vcodec: Return NULL if no vdec_fb is found

Daniil Dulov <d.dulov@aladdin.ru>
    media: cx24120: Add retval check for cx24120_message_send()

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    media: dvb-usb: m920x: Fix a potential memory leak in m920x_i2c_xfer()

Daniil Dulov <d.dulov@aladdin.ru>
    media: dib7000p: Fix potential division by zero

Dongliang Mu <dzm91@hust.edu.cn>
    drivers: usb: smsusb: fix error handling code in smsusb_init_device

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    media: v4l2-core: Fix a potential resource leak in v4l2_fwnode_parse_link()

Marco Felsch <m.felsch@pengutronix.de>
    media: v4l2-fwnode: simplify v4l2_fwnode_parse_link

Marco Felsch <m.felsch@pengutronix.de>
    media: v4l2-fwnode: fix v4l2_fwnode_parse_link handling

Benjamin Coddington <bcodding@redhat.com>
    NFS: Guard against READDIR loop when entry names exceed MAXNAMELEN

Chuck Lever <chuck.lever@oracle.com>
    NFSD: da_addr_body field missing in some GETDEVICEINFO replies

Su Hui <suhui@nfschina.com>
    fs: lockd: avoid possible wrong NULL parameter

Alexei Filippov <halip0503@gmail.com>
    jfs: validate max amount of blocks before allocation.

Russell Currey <ruscur@russell.cc>
    powerpc/iommu: Fix notifiers being shared by PCI and VIO buses

Dan Carpenter <dan.carpenter@linaro.org>
    nfs/blocklayout: Use the passed in gfp flags

Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
    wifi: ath10k: Use RMW accessors for changing LNKCTL

Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
    drm/radeon: Use RMW accessors for changing LNKCTL

Frederick Lawler <fred@fredlawl.com>
    drm/radeon: Prefer pcie_capability_read_word()

Bjorn Helgaas <bhelgaas@google.com>
    drm/radeon: Replace numbers with PCI_EXP_LNKCTL2 definitions

Bjorn Helgaas <bhelgaas@google.com>
    drm/radeon: Correct Transmit Margin masks

Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
    drm/amdgpu: Use RMW accessors for changing LNKCTL

Frederick Lawler <fred@fredlawl.com>
    drm/amdgpu: Prefer pcie_capability_read_word()

Bjorn Helgaas <bhelgaas@google.com>
    drm/amdgpu: Replace numbers with PCI_EXP_LNKCTL2 definitions

Bjorn Helgaas <bhelgaas@google.com>
    drm/amdgpu: Correct Transmit Margin masks

Bjorn Helgaas <bhelgaas@google.com>
    PCI: Add #defines for Enter Compliance, Transmit Margin

Sourabh Jain <sourabhjain@linux.ibm.com>
    powerpc/fadump: reset dump area size if fadump memory reserve fails

Ahmad Fatoum <a.fatoum@pengutronix.de>
    clk: imx: composite-8m: fix clock pauses when set_rate would be a no-op

Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
    PCI/ASPM: Use RMW accessors for changing LNKCTL

Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
    PCI: pciehp: Use RMW accessors for changing LNKCTL

Wu Zongyong <wuzongyong@linux.alibaba.com>
    PCI: Mark NVIDIA T4 GPUs to avoid bus reset

Zhang Jianhua <chris.zjh@huawei.com>
    clk: sunxi-ng: Modify mismatched function name

Minjie Du <duminjie@vivo.com>
    drivers: clk: keystone: Fix parameter judgment in _of_pll_clk_init()

Corey Minyard <minyard@acm.org>
    ipmi:ssif: Fix a memory leak when scanning for an adapter

Jiasheng Jiang <jiasheng@iscas.ac.cn>
    ipmi:ssif: Add check for kstrdup

Su Hui <suhui@nfschina.com>
    ALSA: ac97: Fix possible error value of *rac97

Geert Uytterhoeven <geert+renesas@glider.be>
    of: unittest: Fix overlay type in apply/revert check

Sui Jingfeng <suijingfeng@loongson.cn>
    drm/mediatek: Fix potential memory leak if vmap() fail

Gaosheng Cui <cuigaosheng1@huawei.com>
    audit: fix possible soft lockup in __audit_inode_child()

Dan Carpenter <dan.carpenter@linaro.org>
    smackfs: Prevent underflow in smk_set_cipso()

Daniel Vetter <daniel.vetter@ffwll.ch>
    drm/msm/mdp5: Don't leak some plane state

Nayna Jain <nayna@linux.ibm.com>
    ima: Remove deprecated IMA_TRUSTED_KEYRING Kconfig

Marek Vasut <marex@denx.de>
    drm/panel: simple: Add missing connector type and pixel format for AUO T215HVN01

Geert Uytterhoeven <geert+renesas@glider.be>
    drm/armada: Fix off-by-one error in armada_overlay_get_property()

Ruan Jinjie <ruanjinjie@huawei.com>
    of: unittest: fix null pointer dereferencing in of_unittest_find_node_by_name()

Yangtao Li <frank.li@vivo.com>
    drm/tegra: dpaux: Fix incorrect return value of platform_get_irq

Tan Zhongjun <tanzhongjun@yulong.com>
    drm/tegra: Remove superfluous error messages around platform_get_irq()

Yu Kuai <yukuai3@huawei.com>
    md/md-bitmap: hold 'reconfig_mutex' in backlog_store()

Guoqing Jiang <guoqing.jiang@linux.dev>
    md/bitmap: don't set max_write_behind if there is no write mostly device

Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
    drm/amdgpu: Update min() to min_t() in 'amdgpu_info_ioctl'

Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
    arm64: dts: qcom: sdm845: Add missing RPMh power domain to GCC

Rafał Miłecki <rafal@milecki.pl>
    ARM: dts: BCM53573: Fix Ethernet info for Luxul devices

Bogdan Togorean <bogdan.togorean@analog.com>
    drm: adv7511: Fix low refresh rate register for ADV7533/5

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    ARM: dts: samsung: s5pv210-smdkv210: correct ethernet reg addresses (split)

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    ARM: dts: s5pv210: add dummy 5V regulator for backlight on SMDKv210

Krzysztof Kozlowski <krzk@kernel.org>
    ARM: dts: s5pv210: correct ethernet unit address in SMDKV210

Krzysztof Kozlowski <krzk@kernel.org>
    ARM: dts: s5pv210: use defines for IRQ flags in SMDKV210

Krzysztof Kozlowski <krzk@kernel.org>
    ARM: dts: s5pv210: add RTC 32 KHz clock in SMDKV210

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    ARM: dts: samsung: s3c6410-mini6410: correct ethernet reg addresses (split)

Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
    ARM: dts: s3c64xx: align pinctrl with dtschema

Krzysztof Kozlowski <krzk@kernel.org>
    ARM: dts: s3c6410: align node SROM bus node name with dtschema in Mini6410

Krzysztof Kozlowski <krzk@kernel.org>
    ARM: dts: s3c6410: move fixed clocks under root node in Mini6410

Lucas Stach <l.stach@pengutronix.de>
    drm/etnaviv: fix dumping of active MMU context

Rafał Miłecki <rafal@milecki.pl>
    ARM: dts: BCM53573: Use updated "spi-gpio" binding properties

Rafał Miłecki <rafal@milecki.pl>
    ARM: dts: BCM53573: Add cells sizes to PCIe node

Rafał Miłecki <rafal@milecki.pl>
    ARM: dts: BCM53573: Drop nonexistent "default-off" LED trigger

Arnd Bergmann <arnd@arndb.de>
    drm/amdgpu: avoid integer overflow warning in amdgpu_device_resize_fb_bar()

Baokun Li <libaokun1@huawei.com>
    quota: fix dqput() to follow the guarantees dquot_srcu should provide

Baokun Li <libaokun1@huawei.com>
    quota: add new helper dquot_active()

Baokun Li <libaokun1@huawei.com>
    quota: rename dquot_active() to inode_quota_active()

Baokun Li <libaokun1@huawei.com>
    quota: factor out dquot_write_dquot()

Chengguang Xu <cgxu519@zoho.com.cn>
    quota: avoid increasing DQST_LOOKUPS when iterating over dirty/inuse list

Marek Vasut <marex@denx.de>
    drm/bridge: tc358764: Fix debug print parameter order

Kuniyuki Iwashima <kuniyu@amazon.com>
    netrom: Deny concurrent connect().

Budimir Markovic <markovicbudimir@gmail.com>
    net/sched: sch_hfsc: Ensure inner classes have fsc curve

Vadim Pasternak <vadimp@nvidia.com>
    mlxsw: i2c: Limit single transaction buffer size

Vadim Pasternak <vadimp@nvidia.com>
    mlxsw: i2c: Fix chunk size setting in output mailbox buffer

Jinjie Ruan <ruanjinjie@huawei.com>
    net: arcnet: Do not call kfree_skb() under local_irq_disable()

Wang Ming <machel@vivo.com>
    wifi: ath9k: use IS_ERR() with debugfs_create_dir()

Dmitry Antipov <dmantipov@yandex.ru>
    wifi: mwifiex: avoid possible NULL skb pointer dereference

Fedor Pchelkin <pchelkin@ispras.ru>
    wifi: ath9k: protect WMI command response buffer replacement with a lock

Fedor Pchelkin <pchelkin@ispras.ru>
    wifi: ath9k: fix races between ath9k_wmi_cmd and ath9k_wmi_ctrl_rx

Polaris Pi <pinkperfect2021@gmail.com>
    wifi: mwifiex: Fix missed return in oob checks failed path

Dmitry Antipov <dmantipov@yandex.ru>
    wifi: mwifiex: fix memory leak in mwifiex_histogram_read()

Artem Chernyshev <artem.chernyshev@red-soft.ru>
    fs: ocfs2: namei: check return value of ocfs2_add_entry()

Yan Zhai <yan@cloudflare.com>
    lwt: Check LWTUNNEL_XMIT_CONTINUE strictly

Yan Zhai <yan@cloudflare.com>
    lwt: Fix return values of BPF xmit ops

Florian Fainelli <florian.fainelli@broadcom.com>
    hwrng: iproc-rng200 - Implement suspend and resume calls

Julia Lawall <Julia.Lawall@inria.fr>
    hwrng: iproc-rng200 - use semicolons rather than commas to separate statements

Gaurav Jain <gaurav.jain@nxp.com>
    crypto: caam - fix unchecked return value error

Yuanjun Gong <ruc_gongyuanjun@163.com>
    Bluetooth: nokia: fix value check in nokia_bluetooth_serdev_probe()

Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    crypto: stm32 - Properly handle pm_runtime_get failing

Dmitry Antipov <dmantipov@yandex.ru>
    wifi: mwifiex: fix error recovery in PCIE buffer descriptor management

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    mwifiex: switch from 'pci_' to 'dma_' API

Polaris Pi <pinkperfect2021@gmail.com>
    wifi: mwifiex: Fix OOB and integer underflow when rx packets

Marc Kleine-Budde <mkl@pengutronix.de>
    can: gs_usb: gs_usb_receive_bulk_callback(): count RX overflow errors also in case of OOM

Zhang Shurong <zhang_shurong@foxmail.com>
    spi: tegra20-sflash: fix to check return value of platform_get_irq() in tegra_sflash_probe()

Dan Carpenter <dan.carpenter@linaro.org>
    regmap: rbtree: Use alloc_flags for memory allocations

Eric Dumazet <edumazet@google.com>
    tcp: tcp_enter_quickack_mode() should be static

Yafang Shao <laoar.shao@gmail.com>
    bpf: Clear the probe_addr for uprobe

Liao Chang <liaochang1@huawei.com>
    cpufreq: powernow-k8: Use related_cpus instead of cpus in driver.exit()

Xu Yang <xu.yang_2@nxp.com>
    perf/imx_ddr: don't enable counter0 if none of 4 counters are used

Ard Biesheuvel <ardb@kernel.org>
    x86/decompressor: Don't rely on upper 32 bits of GPRs being preserved

Jiri Slaby <jslaby@suse.cz>
    x86/boot: Annotate local functions

Jiri Slaby <jslaby@suse.cz>
    x86/asm: Make more symbols local

Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
    OPP: Fix passing 0 to PTR_ERR in _opp_attach_genpd()

Christian Brauner <brauner@kernel.org>
    tmpfs: verify {g,u}id mount options correctly

Wang Ming <machel@vivo.com>
    fs: Fix error checking for d_hash_and_lookup()

Al Viro <viro@zeniv.linux.org.uk>
    new helper: lookup_positive_unlocked()

Wen Yang <wenyang.linux@foxmail.com>
    eventfd: prevent underflow for eventfd semaphores

David Woodhouse <dwmw@amazon.co.uk>
    eventfd: Export eventfd_ctx_do_read()

Matthew Wilcox <willy@infradead.org>
    reiserfs: Check the return value from __getblk()

Sabrina Dubroca <sd@queasysnail.net>
    Revert "net: macsec: preserve ingress frame ordering"

Jan Kara <jack@suse.cz>
    udf: Handle error when adding extent to a file

Vladislav Efanov <VEfanov@ispras.ru>
    udf: Check consistency of Space Bitmap Descriptor

Christophe Leroy <christophe.leroy@csgroup.eu>
    powerpc/32s: Fix assembler warning about r0

Jordan Rife <jrife@google.com>
    net: Avoid address overwrite in kernel_connect

Shih-Yi Chen <shihyic@nvidia.com>
    platform/mellanox: Fix mlxbf-tmfifo not handling all virtio CONSOLE notifications

Takashi Iwai <tiwai@suse.de>
    ALSA: seq: oss: Fix racy open/close of MIDI devices

Michael Kelley <mikelley@microsoft.com>
    scsi: storvsc: Always set no_report_opcodes

Shyam Prasad N <sprasad@microsoft.com>
    cifs: add a warning when the in-flight count goes negative

Dan Carpenter <dan.carpenter@linaro.org>
    sctp: handle invalid error codes without calling BUG()

David Christensen <drc@linux.vnet.ibm.com>
    bnx2x: fix page fault following EEH recovery

Dmitry Mastykin <dmastykin@astralinux.ru>
    netlabel: fix shift wrapping bug in netlbl_catmap_setlong()

Chengfeng Ye <dg573847474@gmail.com>
    scsi: qedi: Fix potential deadlock on &qedi_percpu->p_work_lock

Baoquan He <bhe@redhat.com>
    idmaengine: make FSL_EDMA and INTEL_IDMA64 depends on HAS_IOMEM

Martin Kohn <m.kohn@welotec.com>
    net: usb: qmi_wwan: add Quectel EM05GV2

Baoquan He <bhe@redhat.com>
    clk: fixed-mmio: make COMMON_CLK_FIXED_MMIO depend on HAS_IOMEM

Christian Göttsche <cgzones@googlemail.com>
    security: keys: perform capable check only on privileged operations

Konstantin Shelekhin <k.shelekhin@ftml.net>
    platform/x86: huawei-wmi: Silence ambient light sensor

Hans de Goede <hdegoede@redhat.com>
    platform/x86: intel: hid: Always call BTNL ACPI method

Guiting Shen <aarongt.shen@gmail.com>
    ASoC: atmel: Fix the 8K sample parameter in I2SC master

Edgar <ljijcj@163.com>
    ASoc: codecs: ES8316: Fix DMIC config

Winston Wen <wentao@uniontech.com>
    fs/nls: make load_nls() take a const parameter

Stefan Haberland <sth@linux.ibm.com>
    s390/dasd: fix hanging device after request requeue

Stefan Haberland <sth@linux.ibm.com>
    s390/dasd: use correct number of retries for ERP requests

Ben Hutchings <benh@debian.org>
    m68k: Fix invalid .section syntax

Jiri Benc <jbenc@redhat.com>
    vxlan: generalize vxlan_parse_gpe_hdr and remove unused args

Yuanjun Gong <ruc_gongyuanjun@163.com>
    ethernet: atheros: fix return value check in atl1c_tso_csum()

Dmytro Maluka <dmy@semihalf.com>
    ASoC: da7219: Check for failure reading AAD IRQ events

Dmytro Maluka <dmy@semihalf.com>
    ASoC: da7219: Flush pending AAD IRQ when suspending

Dominique Martinet <asmadeus@codewreck.org>
    9p: virtio: make sure 'offs' is initialized in zc_request

Mario Limonciello <mario.limonciello@amd.com>
    pinctrl: amd: Don't show `Invalid config param` errors

Ryusuke Konishi <konishi.ryusuke@gmail.com>
    nilfs2: fix WARNING in mark_buffer_dirty due to discarded buffer reuse

Ryusuke Konishi <konishi.ryusuke@gmail.com>
    nilfs2: fix general protection fault in nilfs_lookup_dirty_data_buffers()

Juerg Haefliger <juerg.haefliger@canonical.com>
    fsi: master-ast-cf: Add MODULE_FIRMWARE macro

Wang Ming <machel@vivo.com>
    firmware: stratix10-svc: Fix an NULL vs IS_ERR() bug in probe

Hugo Villeneuve <hvilleneuve@dimonoff.com>
    serial: sc16is7xx: fix bug when first setting GPIO direction

Zheng Wang <zyytlz.wz@163.com>
    Bluetooth: btsdio: fix use after free bug in btsdio_remove due to race condition

Nam Cao <namcaov@gmail.com>
    staging: rtl8712: fix race condition

Aaron Armstrong Skomra <aaron.skomra@wacom.com>
    HID: wacom: remove the battery when the EKR is off

Slark Xiao <slark_xiao@163.com>
    USB: serial: option: add FOXCONN T99W368/T99W373 product

Martin Kohn <m.kohn@welotec.com>
    USB: serial: option: add Quectel EM05G variant (0x030e)

Christoph Hellwig <hch@lst.de>
    modules: only allow symbol_get of EXPORT_SYMBOL_GPL modules

Christoph Hellwig <hch@lst.de>
    rtc: ds1685: use EXPORT_SYMBOL_GPL for ds1685_rtc_poweroff

Christoph Hellwig <hch@lst.de>
    net: enetc: use EXPORT_SYMBOL_GPL for enetc_phc_index

Christoph Hellwig <hch@lst.de>
    mmc: au1xmmc: force non-modular build and remove symbol_get usage

Arnd Bergmann <arnd@arndb.de>
    ARM: pxa: remove use of symbol_get()

Gao Xiang <hsiangkao@linux.alibaba.com>
    erofs: ensure that the post-EOF tails are all zeroed


-------------

Diffstat:

 Documentation/arm64/silicon-errata.rst             |   3 +
 Makefile                                           |   4 +-
 arch/arm/boot/dts/bcm4708-linksys-ea6500-v2.dts    |   3 +-
 arch/arm/boot/dts/bcm47189-luxul-xap-1440.dts      |  14 +-
 arch/arm/boot/dts/bcm47189-luxul-xap-810.dts       |  15 +-
 arch/arm/boot/dts/bcm53573.dtsi                    |   3 +
 arch/arm/boot/dts/bcm947189acdbmr.dts              |   6 +-
 arch/arm/boot/dts/s3c6410-mini6410.dts             |  38 +-
 arch/arm/boot/dts/s3c64xx-pinctrl.dtsi             | 210 +++---
 arch/arm/boot/dts/s5pv210-smdkv210.dts             |  24 +-
 arch/arm/kernel/hw_breakpoint.c                    |   8 +-
 arch/arm/mach-omap2/powerdomain.c                  |   2 +-
 arch/arm/mach-pxa/sharpsl_pm.c                     |   2 -
 arch/arm/mach-pxa/spitz.c                          |  14 +-
 arch/arm64/boot/dts/qcom/sdm845.dtsi               |   1 +
 arch/arm64/kernel/hw_breakpoint.c                  |   4 +-
 arch/m68k/fpsp040/skeleton.S                       |   4 +-
 arch/m68k/ifpsp060/os.S                            |   4 +-
 arch/m68k/kernel/relocate_kernel.S                 |   4 +-
 arch/mips/alchemy/devboards/db1000.c               |   8 +-
 arch/mips/alchemy/devboards/db1200.c               |  19 +-
 arch/mips/alchemy/devboards/db1300.c               |  10 +-
 arch/parisc/include/asm/led.h                      |   4 +-
 arch/parisc/include/asm/processor.h                |   1 -
 arch/parisc/kernel/processor.c                     |  18 +-
 arch/powerpc/kernel/fadump.c                       |   1 +
 arch/powerpc/kernel/head_32.S                      |   2 +-
 arch/powerpc/kernel/iommu.c                        |  17 +-
 arch/powerpc/platforms/pseries/ibmebus.c           |   1 +
 arch/s390/kernel/ipl.c                             |   2 +
 arch/sh/boards/mach-ap325rxa/setup.c               |   2 +-
 arch/sh/boards/mach-ecovec24/setup.c               |   6 +-
 arch/sh/boards/mach-kfr2r09/setup.c                |   2 +-
 arch/sh/boards/mach-migor/setup.c                  |   2 +-
 arch/sh/boards/mach-se/7724/setup.c                |   6 +-
 arch/um/configs/i386_defconfig                     |   1 +
 arch/um/configs/x86_64_defconfig                   |   1 +
 arch/um/drivers/Kconfig                            |  16 +-
 arch/um/drivers/Makefile                           |   2 +-
 arch/x86/boot/compressed/head_32.S                 |   3 +-
 arch/x86/boot/compressed/head_64.S                 |  39 +-
 arch/x86/boot/pmjump.S                             |   6 +-
 arch/x86/entry/entry_64.S                          |   4 +-
 arch/x86/include/asm/virtext.h                     |   6 -
 arch/x86/kernel/apm_32.c                           |   6 -
 arch/x86/kernel/cpu/common.c                       |   8 +-
 arch/x86/realmode/rm/wakeup_asm.S                  |   6 +-
 arch/xtensa/include/asm/core.h                     |   9 +
 arch/xtensa/kernel/perf_event.c                    |  17 +-
 crypto/asymmetric_keys/x509_public_key.c           |   5 +
 drivers/acpi/acpica/psopcode.c                     |   2 +-
 drivers/acpi/arm64/iort.c                          |   5 +-
 drivers/acpi/video_detect.c                        |   9 +
 drivers/amba/bus.c                                 |   1 +
 drivers/ata/pata_ftide010.c                        |   1 +
 drivers/ata/sata_gemini.c                          |   1 +
 drivers/base/regmap/regcache-rbtree.c              |  10 +-
 drivers/base/test/test_async_driver_probe.c        |   2 +-
 drivers/bluetooth/btsdio.c                         |   1 +
 drivers/bluetooth/hci_nokia.c                      |   6 +-
 drivers/bus/ti-sysc.c                              |   2 +
 drivers/char/hw_random/iproc-rng200.c              |  33 +-
 drivers/char/ipmi/ipmi_si_intf.c                   |   5 +
 drivers/char/ipmi/ipmi_ssif.c                      |   7 +-
 drivers/char/tpm/tpm_tis_core.c                    |  15 +-
 drivers/clk/Kconfig                                |   1 +
 drivers/clk/imx/clk-composite-8m.c                 |  12 +-
 drivers/clk/imx/clk-imx8mm.c                       |  87 +--
 drivers/clk/imx/clk-pll14xx.c                      |  30 +
 drivers/clk/imx/clk.h                              |   3 +
 drivers/clk/keystone/pll.c                         |   2 +-
 drivers/clk/qcom/gcc-mdm9615.c                     |   2 +-
 drivers/clk/sunxi-ng/ccu_mmc_timing.c              |   2 +-
 drivers/cpufreq/brcmstb-avs-cpufreq.c              |   6 +-
 drivers/cpufreq/cpufreq.c                          |   2 +
 drivers/cpufreq/powernow-k8.c                      |   3 +-
 drivers/crypto/caam/caampkc.c                      |   4 +-
 drivers/crypto/stm32/stm32-hash.c                  |   9 +-
 drivers/devfreq/devfreq.c                          |   1 +
 drivers/dma/Kconfig                                |   2 +
 drivers/dma/ste_dma40.c                            |   4 +
 drivers/firmware/stratix10-svc.c                   |   2 +-
 drivers/fsi/fsi-master-ast-cf.c                    |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c             |  18 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c            |  14 +-
 drivers/gpu/drm/amd/amdgpu/cik.c                   |  97 +--
 drivers/gpu/drm/amd/amdgpu/si.c                    |  99 +--
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_mpc.c   |   5 +-
 drivers/gpu/drm/armada/armada_overlay.c            |   6 +-
 drivers/gpu/drm/ast/ast_post.c                     |   2 +-
 drivers/gpu/drm/bridge/adv7511/adv7511_drv.c       |   9 +-
 drivers/gpu/drm/bridge/tc358764.c                  |   2 +-
 drivers/gpu/drm/drm_gem_vram_helper.c              |  24 +-
 drivers/gpu/drm/etnaviv/etnaviv_dump.c             |  14 +-
 drivers/gpu/drm/exynos/exynos_drm_crtc.c           |   5 +-
 drivers/gpu/drm/mediatek/mtk_drm_gem.c             |   6 +-
 drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c         |   3 +-
 drivers/gpu/drm/panel/panel-simple.c               |   4 +-
 drivers/gpu/drm/radeon/cik.c                       |  96 +--
 drivers/gpu/drm/radeon/si.c                        |  98 +--
 drivers/gpu/drm/tegra/dpaux.c                      |   6 +-
 drivers/hid/hid-logitech-dj.c                      |   5 +-
 drivers/hid/hid-multitouch.c                       |  13 +-
 drivers/hid/wacom.h                                |   1 +
 drivers/hid/wacom_sys.c                            |  25 +-
 drivers/hid/wacom_wac.c                            |   1 +
 drivers/hid/wacom_wac.h                            |   1 +
 drivers/hwtracing/coresight/coresight-tmc-etf.c    |   2 +-
 drivers/hwtracing/coresight/coresight-tmc-etr.c    |   5 +-
 drivers/hwtracing/coresight/coresight-tmc.h        |   2 +-
 drivers/i2c/busses/i2c-aspeed.c                    |   7 +-
 .../infiniband/core/uverbs_std_types_counters.c    |   2 +
 drivers/infiniband/sw/siw/siw_cm.c                 |   1 -
 drivers/infiniband/sw/siw/siw_verbs.c              |   2 +-
 drivers/infiniband/ulp/isert/ib_isert.c            |   2 +
 drivers/iommu/intel-pasid.c                        |   2 +-
 drivers/md/md-bitmap.c                             |  26 +
 drivers/md/raid1.c                                 |   3 +
 drivers/media/dvb-frontends/ascot2e.c              |   2 +-
 drivers/media/dvb-frontends/atbm8830.c             |   2 +-
 drivers/media/dvb-frontends/au8522_dig.c           |   2 +-
 drivers/media/dvb-frontends/bcm3510.c              |   2 +-
 drivers/media/dvb-frontends/cx22700.c              |   2 +-
 drivers/media/dvb-frontends/cx22702.c              |   2 +-
 drivers/media/dvb-frontends/cx24110.c              |   2 +-
 drivers/media/dvb-frontends/cx24113.c              |   2 +-
 drivers/media/dvb-frontends/cx24116.c              |   2 +-
 drivers/media/dvb-frontends/cx24120.c              |   6 +-
 drivers/media/dvb-frontends/cx24123.c              |   2 +-
 drivers/media/dvb-frontends/cxd2820r_core.c        |   2 +-
 drivers/media/dvb-frontends/cxd2841er.c            |   4 +-
 drivers/media/dvb-frontends/cxd2880/cxd2880_top.c  |   2 +-
 drivers/media/dvb-frontends/dib0070.c              |   2 +-
 drivers/media/dvb-frontends/dib0090.c              |   4 +-
 drivers/media/dvb-frontends/dib3000mb.c            |   2 +-
 drivers/media/dvb-frontends/dib3000mc.c            |   2 +-
 drivers/media/dvb-frontends/dib7000m.c             |   2 +-
 drivers/media/dvb-frontends/dib7000p.c             |   4 +-
 drivers/media/dvb-frontends/dib8000.c              |   2 +-
 drivers/media/dvb-frontends/dib9000.c              |   2 +-
 drivers/media/dvb-frontends/drx39xyj/drxj.c        |   2 +-
 drivers/media/dvb-frontends/drxd_hard.c            |   2 +-
 drivers/media/dvb-frontends/drxk_hard.c            |   2 +-
 drivers/media/dvb-frontends/ds3000.c               |   2 +-
 drivers/media/dvb-frontends/dvb-pll.c              |   2 +-
 drivers/media/dvb-frontends/ec100.c                |   2 +-
 drivers/media/dvb-frontends/helene.c               |   4 +-
 drivers/media/dvb-frontends/horus3a.c              |   2 +-
 drivers/media/dvb-frontends/isl6405.c              |   2 +-
 drivers/media/dvb-frontends/isl6421.c              |   2 +-
 drivers/media/dvb-frontends/isl6423.c              |   2 +-
 drivers/media/dvb-frontends/itd1000.c              |   2 +-
 drivers/media/dvb-frontends/ix2505v.c              |   2 +-
 drivers/media/dvb-frontends/l64781.c               |   2 +-
 drivers/media/dvb-frontends/lg2160.c               |   2 +-
 drivers/media/dvb-frontends/lgdt3305.c             |   2 +-
 drivers/media/dvb-frontends/lgdt3306a.c            |   2 +-
 drivers/media/dvb-frontends/lgdt330x.c             |   2 +-
 drivers/media/dvb-frontends/lgs8gxx.c              |   2 +-
 drivers/media/dvb-frontends/lnbh25.c               |   2 +-
 drivers/media/dvb-frontends/lnbp21.c               |   4 +-
 drivers/media/dvb-frontends/lnbp22.c               |   2 +-
 drivers/media/dvb-frontends/m88ds3103.c            |   2 +-
 drivers/media/dvb-frontends/m88rs2000.c            |   2 +-
 drivers/media/dvb-frontends/mb86a16.c              |   2 +-
 drivers/media/dvb-frontends/mb86a20s.c             |   2 +-
 drivers/media/dvb-frontends/mt312.c                |   2 +-
 drivers/media/dvb-frontends/mt352.c                |   2 +-
 drivers/media/dvb-frontends/nxt200x.c              |   2 +-
 drivers/media/dvb-frontends/nxt6000.c              |   2 +-
 drivers/media/dvb-frontends/or51132.c              |   2 +-
 drivers/media/dvb-frontends/or51211.c              |   2 +-
 drivers/media/dvb-frontends/s5h1409.c              |   2 +-
 drivers/media/dvb-frontends/s5h1411.c              |   2 +-
 drivers/media/dvb-frontends/s5h1420.c              |   2 +-
 drivers/media/dvb-frontends/s5h1432.c              |   2 +-
 drivers/media/dvb-frontends/s921.c                 |   2 +-
 drivers/media/dvb-frontends/si21xx.c               |   2 +-
 drivers/media/dvb-frontends/sp887x.c               |   2 +-
 drivers/media/dvb-frontends/stb0899_drv.c          |   2 +-
 drivers/media/dvb-frontends/stb6000.c              |   2 +-
 drivers/media/dvb-frontends/stb6100.c              |   2 +-
 drivers/media/dvb-frontends/stv0288.c              |   2 +-
 drivers/media/dvb-frontends/stv0297.c              |   2 +-
 drivers/media/dvb-frontends/stv0299.c              |   2 +-
 drivers/media/dvb-frontends/stv0367.c              |   6 +-
 drivers/media/dvb-frontends/stv0900_core.c         |   2 +-
 drivers/media/dvb-frontends/stv090x.c              |   2 +-
 drivers/media/dvb-frontends/stv6110.c              |   2 +-
 drivers/media/dvb-frontends/stv6110x.c             |   2 +-
 drivers/media/dvb-frontends/tda10021.c             |   2 +-
 drivers/media/dvb-frontends/tda10023.c             |   2 +-
 drivers/media/dvb-frontends/tda10048.c             |   2 +-
 drivers/media/dvb-frontends/tda1004x.c             |   4 +-
 drivers/media/dvb-frontends/tda10086.c             |   2 +-
 drivers/media/dvb-frontends/tda665x.c              |   2 +-
 drivers/media/dvb-frontends/tda8083.c              |   2 +-
 drivers/media/dvb-frontends/tda8261.c              |   2 +-
 drivers/media/dvb-frontends/tda826x.c              |   2 +-
 drivers/media/dvb-frontends/ts2020.c               |   2 +-
 drivers/media/dvb-frontends/tua6100.c              |   2 +-
 drivers/media/dvb-frontends/ves1820.c              |   2 +-
 drivers/media/dvb-frontends/ves1x93.c              |   2 +-
 drivers/media/dvb-frontends/zl10036.c              |   2 +-
 drivers/media/dvb-frontends/zl10039.c              |   2 +-
 drivers/media/dvb-frontends/zl10353.c              |   2 +-
 drivers/media/i2c/ov2680.c                         | 246 ++-----
 drivers/media/i2c/ov5640.c                         | 127 ++--
 drivers/media/pci/bt8xx/dst.c                      |   2 +-
 drivers/media/pci/bt8xx/dst_ca.c                   |   2 +-
 drivers/media/pci/cx23885/cx23885-video.c          |   2 +-
 drivers/media/pci/intel/ipu3/ipu3-cio2.c           |   2 +-
 .../media/platform/mtk-vcodec/vdec/vdec_vp9_if.c   |   5 +-
 drivers/media/tuners/fc0011.c                      |   2 +-
 drivers/media/tuners/fc0012.c                      |   2 +-
 drivers/media/tuners/fc0013.c                      |   2 +-
 drivers/media/tuners/max2165.c                     |   2 +-
 drivers/media/tuners/mc44s803.c                    |   2 +-
 drivers/media/tuners/mt2060.c                      |   2 +-
 drivers/media/tuners/mt2131.c                      |   2 +-
 drivers/media/tuners/mt2266.c                      |   2 +-
 drivers/media/tuners/mxl5005s.c                    |   2 +-
 drivers/media/tuners/qt1010.c                      |  13 +-
 drivers/media/tuners/tda18218.c                    |   2 +-
 drivers/media/tuners/xc4000.c                      |   2 +-
 drivers/media/tuners/xc5000.c                      |   2 +-
 drivers/media/usb/dvb-usb-v2/af9035.c              |  14 +-
 drivers/media/usb/dvb-usb-v2/anysee.c              |   2 +-
 drivers/media/usb/dvb-usb-v2/az6007.c              |   8 +
 drivers/media/usb/dvb-usb/af9005.c                 |   5 +
 drivers/media/usb/dvb-usb/dw2102.c                 |  24 +
 drivers/media/usb/dvb-usb/m920x.c                  |   5 +-
 drivers/media/usb/go7007/go7007-i2c.c              |   2 -
 drivers/media/usb/siano/smsusb.c                   |  21 +-
 drivers/media/v4l2-core/v4l2-fwnode.c              |  43 +-
 drivers/mmc/host/Kconfig                           |   5 +-
 drivers/mmc/host/sdhci-esdhc-imx.c                 |   7 +-
 drivers/mtd/nand/raw/brcmnand/brcmnand.c           | 112 ++-
 drivers/mtd/nand/raw/fsmc_nand.c                   |   7 +-
 drivers/net/arcnet/arcnet.c                        |   2 +-
 drivers/net/can/usb/gs_usb.c                       |   5 +-
 drivers/net/ethernet/atheros/alx/ethtool.c         |   5 +-
 drivers/net/ethernet/atheros/atl1c/atl1c_main.c    |   7 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c   |   9 +-
 drivers/net/ethernet/freescale/enetc/enetc_ptp.c   |   2 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c |   4 +-
 drivers/net/ethernet/intel/igb/igb.h               |   4 +-
 drivers/net/ethernet/intel/igb/igb_main.c          |  16 +-
 drivers/net/ethernet/intel/igbvf/igbvf.h           |   4 +-
 drivers/net/ethernet/intel/igc/igc.h               |   4 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c       |  28 +-
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c    |   5 +
 drivers/net/ethernet/mediatek/mtk_eth_soc.c        |   3 +
 drivers/net/ethernet/mellanox/mlxsw/i2c.c          |   5 +-
 drivers/net/macsec.c                               |   3 +-
 drivers/net/usb/qmi_wwan.c                         |   1 +
 drivers/net/usb/r8152.c                            |   3 +
 drivers/net/veth.c                                 |   4 +-
 drivers/net/vxlan.c                                |  58 +-
 drivers/net/wireless/ath/ath10k/pci.c              |   9 +-
 drivers/net/wireless/ath/ath9k/ahb.c               |   4 +-
 drivers/net/wireless/ath/ath9k/htc_drv_debug.c     |   2 +-
 drivers/net/wireless/ath/ath9k/pci.c               |   4 +-
 drivers/net/wireless/ath/ath9k/wmi.c               |  20 +-
 drivers/net/wireless/mac80211_hwsim.c              |   7 +-
 drivers/net/wireless/marvell/mwifiex/debugfs.c     |   9 +-
 drivers/net/wireless/marvell/mwifiex/pcie.c        | 176 ++---
 drivers/net/wireless/marvell/mwifiex/sta_rx.c      |  12 +-
 drivers/net/wireless/marvell/mwifiex/tdls.c        |   9 +-
 drivers/net/wireless/marvell/mwifiex/uap_txrx.c    |  30 +-
 drivers/net/wireless/marvell/mwifiex/util.c        |  10 +-
 drivers/ntb/ntb_transport.c                        |  19 +-
 drivers/of/unittest.c                              |  12 +-
 drivers/opp/core.c                                 |   2 +-
 drivers/parisc/led.c                               |   4 +-
 drivers/pci/hotplug/pciehp_hpc.c                   |  12 +-
 drivers/pci/pcie/aspm.c                            |  30 +-
 drivers/perf/arm_smmuv3_pmu.c                      |  46 +-
 drivers/perf/fsl_imx8_ddr_perf.c                   |  24 +-
 drivers/phy/rockchip/phy-rockchip-inno-hdmi.c      |  18 +-
 drivers/pinctrl/pinctrl-amd.c                      |   4 +-
 drivers/platform/mellanox/mlxbf-tmfifo.c           | 104 ++-
 drivers/platform/x86/huawei-wmi.c                  |   2 +
 drivers/platform/x86/intel-hid.c                   |  21 +-
 drivers/pwm/pwm-lpc32xx.c                          |  16 +-
 drivers/rpmsg/qcom_glink_native.c                  |   4 +
 drivers/rtc/rtc-ds1685.c                           |   2 +-
 drivers/s390/block/dasd.c                          | 125 ++--
 drivers/s390/block/dasd_3990_erp.c                 |   2 +-
 drivers/s390/crypto/zcrypt_api.c                   |   1 +
 drivers/scsi/be2iscsi/be_iscsi.c                   |   4 +
 drivers/scsi/fcoe/fcoe_ctlr.c                      |  20 +-
 drivers/scsi/hosts.c                               |   4 +-
 drivers/scsi/megaraid/megaraid_sas.h               |   2 +-
 drivers/scsi/megaraid/megaraid_sas_base.c          |  21 +-
 drivers/scsi/qedf/qedf_dbg.h                       |   2 +
 drivers/scsi/qedf/qedf_debugfs.c                   |  35 +-
 drivers/scsi/qedi/qedi_main.c                      |   5 +-
 drivers/scsi/qla2xxx/qla_attr.c                    |   2 -
 drivers/scsi/qla2xxx/qla_dbg.c                     |   2 +-
 drivers/scsi/qla2xxx/qla_init.c                    |   3 +-
 drivers/scsi/qla2xxx/qla_isr.c                     |   7 +-
 drivers/scsi/qla2xxx/qla_nvme.c                    |   2 +-
 drivers/scsi/qla2xxx/qla_os.c                      |   9 +-
 drivers/scsi/qla4xxx/ql4_os.c                      |  15 +
 drivers/scsi/scsi_transport_iscsi.c                |   8 +
 drivers/scsi/storvsc_drv.c                         |   2 +
 drivers/soc/qcom/qmi_encdec.c                      |   4 +-
 drivers/spi/spi-tegra20-sflash.c                   |   6 +-
 drivers/staging/rtl8712/os_intfs.c                 |   1 +
 drivers/staging/rtl8712/usb_intf.c                 |   1 -
 drivers/target/iscsi/iscsi_target_configfs.c       |  54 +-
 drivers/tty/serial/cpm_uart/cpm_uart_core.c        |  13 +-
 drivers/tty/serial/sc16is7xx.c                     |  18 +-
 drivers/tty/serial/serial-tegra.c                  |   6 +-
 drivers/tty/serial/sprd_serial.c                   |  68 +-
 drivers/usb/gadget/function/f_mass_storage.c       |   2 +-
 drivers/usb/gadget/udc/fsl_qe_udc.c                |   2 +
 drivers/usb/phy/phy-mxs-usb.c                      |  10 +-
 drivers/usb/serial/option.c                        |   7 +
 drivers/usb/typec/bus.c                            |  12 +-
 drivers/usb/typec/tcpm/tcpci.c                     |   4 +
 drivers/usb/typec/tcpm/tcpci.h                     |   1 +
 drivers/usb/typec/tcpm/tcpm.c                      | 122 ++--
 drivers/video/backlight/bd6107.c                   |   2 +-
 drivers/video/backlight/gpio_backlight.c           |   2 +-
 drivers/video/backlight/lv5207lp.c                 |   2 +-
 drivers/video/fbdev/ep93xx-fb.c                    |   1 -
 drivers/virtio/virtio_ring.c                       |   2 +-
 drivers/watchdog/intel-mid_wdt.c                   |   1 +
 fs/attr.c                                          |  20 +-
 fs/autofs/waitq.c                                  |   3 +-
 fs/btrfs/ctree.h                                   |   2 -
 fs/btrfs/delayed-inode.c                           |  19 +-
 fs/btrfs/disk-io.c                                 |  13 +-
 fs/btrfs/extent-tree.c                             |   5 +
 fs/btrfs/transaction.c                             |   7 +-
 fs/btrfs/volumes.c                                 |   8 +
 fs/btrfs/volumes.h                                 |   3 +
 fs/cifs/cifsfs.c                                   |   7 +-
 fs/cifs/smb2ops.c                                  |   1 +
 fs/debugfs/inode.c                                 |   6 +-
 fs/dlm/plock.c                                     |   6 +-
 fs/erofs/zdata.c                                   |   2 +
 fs/eventfd.c                                       |   7 +-
 fs/ext2/xattr.c                                    |   4 +-
 fs/ext4/namei.c                                    |  26 +-
 fs/fuse/readdir.c                                  |  10 +-
 fs/jfs/jfs_dmap.c                                  |   1 +
 fs/jfs/jfs_extent.c                                |   5 +
 fs/jfs/jfs_imap.c                                  |   1 +
 fs/kernfs/mount.c                                  |   2 +-
 fs/lockd/mon.c                                     |   3 +
 fs/locks.c                                         |   2 +-
 fs/namei.c                                         |  22 +-
 fs/nfs/blocklayout/dev.c                           |   4 +-
 fs/nfs/nfs2xdr.c                                   |   2 +-
 fs/nfs/nfs3xdr.c                                   |   2 +-
 fs/nfs/pnfs_dev.c                                  |   2 +-
 fs/nfsd/blocklayoutxdr.c                           |   9 +
 fs/nfsd/flexfilelayoutxdr.c                        |   9 +
 fs/nfsd/nfs3xdr.c                                  |   4 +-
 fs/nfsd/nfs4proc.c                                 |   4 +-
 fs/nfsd/nfs4xdr.c                                  |  36 +-
 fs/nilfs2/alloc.c                                  |   3 +-
 fs/nilfs2/inode.c                                  |   7 +-
 fs/nilfs2/segment.c                                |   5 +
 fs/nls/nls_base.c                                  |   4 +-
 fs/ocfs2/namei.c                                   |   4 +
 fs/overlayfs/namei.c                               |  24 +-
 fs/proc/base.c                                     |   3 +-
 fs/pstore/ram_core.c                               |   2 +-
 fs/quota/dquot.c                                   | 184 +++--
 fs/reiserfs/journal.c                              |   4 +-
 fs/tracefs/inode.c                                 |   3 +
 fs/udf/balloc.c                                    |  31 +-
 fs/udf/inode.c                                     |  45 +-
 fs/verity/signature.c                              |  16 +
 include/linux/acpi_iort.h                          |   1 +
 include/linux/eventfd.h                            |   6 +
 include/linux/if_arp.h                             |   4 +
 include/linux/namei.h                              |   1 +
 include/linux/nls.h                                |   2 +-
 include/linux/perf_event.h                         |  22 +-
 include/linux/sched/task.h                         |  28 +-
 include/linux/trace_events.h                       |   3 +-
 include/linux/usb/typec_altmode.h                  |   2 +-
 include/net/ip_tunnels.h                           |  15 +-
 include/net/lwtunnel.h                             |   5 +-
 include/net/tcp.h                                  |   1 -
 include/scsi/scsi_host.h                           |   2 +-
 include/uapi/linux/pci_regs.h                      |   2 +
 include/uapi/linux/sync_file.h                     |   2 +-
 kernel/auditsc.c                                   |   2 +
 kernel/fork.c                                      |   8 +
 kernel/module.c                                    |  15 +-
 kernel/trace/bpf_trace.c                           |   2 +-
 kernel/trace/trace.c                               |  43 +-
 kernel/trace/trace_uprobe.c                        |   3 +-
 lib/idr.c                                          |   2 +-
 lib/kobject.c                                      |   5 +
 lib/mpi/mpi-cmp.c                                  |   8 +-
 lib/test_meminit.c                                 |   2 +-
 mm/shmem.c                                         |  28 +-
 net/9p/trans_virtio.c                              |   2 +-
 net/core/devlink.c                                 |   4 +-
 net/core/flow_dissector.c                          |   3 +-
 net/core/lwt_bpf.c                                 |   7 +-
 net/core/skbuff.c                                  |  34 +-
 net/core/sock.c                                    |   9 +-
 net/dccp/ipv4.c                                    |  13 +-
 net/dccp/ipv6.c                                    |  15 +-
 net/ipv4/devinet.c                                 |  10 +-
 net/ipv4/fib_semantics.c                           |   5 +-
 net/ipv4/fib_trie.c                                |   3 +-
 net/ipv4/igmp.c                                    |   3 +-
 net/ipv4/ip_output.c                               |   2 +-
 net/ipv4/tcp_input.c                               |   3 +-
 net/ipv6/addrconf.c                                |   2 +-
 net/ipv6/ip6_output.c                              |   2 +-
 net/kcm/kcmsock.c                                  |  15 +-
 net/netfilter/ipset/ip_set_hash_netportnet.c       |   1 +
 net/netfilter/nfnetlink_osf.c                      |   8 +
 net/netfilter/xt_sctp.c                            |   2 +
 net/netfilter/xt_u32.c                             |  21 +
 net/netlabel/netlabel_kapi.c                       |   3 +-
 net/netrom/af_netrom.c                             |   5 +
 net/sched/Kconfig                                  |  28 -
 net/sched/Makefile                                 |   2 -
 net/sched/cls_rsvp.c                               |  24 -
 net/sched/cls_rsvp.h                               | 777 ---------------------
 net/sched/cls_rsvp6.c                              |  24 -
 net/sched/sch_hfsc.c                               |   4 +
 net/sched/sch_plug.c                               |   2 +-
 net/sched/sch_qfq.c                                |  22 +-
 net/sctp/proc.c                                    |   2 +-
 net/sctp/sm_sideeffect.c                           |   5 +-
 net/sctp/socket.c                                  |  10 +-
 net/socket.c                                       |   6 +-
 net/tls/tls_sw.c                                   |   4 +-
 net/unix/af_unix.c                                 |   2 +-
 net/unix/scm.c                                     |   6 +-
 scripts/kconfig/preprocess.c                       |   3 +
 security/integrity/ima/Kconfig                     |  12 -
 security/keys/keyctl.c                             |  11 +-
 security/smack/smackfs.c                           |   2 +-
 sound/Kconfig                                      |   2 +-
 sound/core/pcm_compat.c                            |   8 +-
 sound/core/seq/oss/seq_oss_midi.c                  |  35 +-
 sound/pci/ac97/ac97_codec.c                        |   5 +-
 sound/soc/atmel/atmel-i2s.c                        |   5 +-
 sound/soc/codecs/da7219-aad.c                      |  12 +-
 sound/soc/codecs/es8316.c                          |   2 +-
 tools/build/Makefile.build                         |  10 +
 tools/build/Makefile.feature                       |   2 +
 tools/build/feature/Makefile                       |   4 +
 tools/build/feature/test-all.c                     |   5 +
 tools/build/feature/test-libbfd-buildid.c          |   8 +
 tools/lib/bpf/libbpf.c                             |   1 +
 tools/perf/Makefile.config                         |  62 +-
 tools/perf/Makefile.perf                           |   1 +
 tools/perf/builtin-top.c                           |   1 +
 tools/perf/pmu-events/Build                        |  22 +-
 tools/perf/pmu-events/empty-pmu-events.c           | 158 +++++
 tools/perf/ui/browsers/hists.c                     |   2 +-
 tools/perf/util/annotate.c                         |  10 +-
 tools/perf/util/header.c                           |  11 +-
 tools/testing/selftests/ftrace/ftracetest          |   8 +
 469 files changed, 3117 insertions(+), 2928 deletions(-)


