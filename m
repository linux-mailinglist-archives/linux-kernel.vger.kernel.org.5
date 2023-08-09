Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1FAF7759A9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 13:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232933AbjHILC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 07:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232918AbjHILCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 07:02:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1850E1724;
        Wed,  9 Aug 2023 04:02:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8E76F630D7;
        Wed,  9 Aug 2023 11:02:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45C92C433C7;
        Wed,  9 Aug 2023 11:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691578942;
        bh=oYyrITB7BbWJjYKgL9nV2TSJXNxPve3d7E5ZCQ7zz/Q=;
        h=From:To:Cc:Subject:Date:From;
        b=cD4OGKZrvuL+CSpgcYS3H3nBPB3di1A7RdpADktGo4H06vWHty0hC4m1NkvlQ6PnP
         mtHw8IcptPqXZlaOXel8pM5bYLzeqOdJylWxrHknroHC36rxDBMBU54SJbo6cHKsIC
         mffPJT2CVA47LU+AZnWtbRKsGwo28boONNRHXzHU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: [PATCH 4.14 000/204] 4.14.322-rc1 review
Date:   Wed,  9 Aug 2023 12:38:58 +0200
Message-ID: <20230809103642.552405807@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.322-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.14.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.14.322-rc1
X-KernelTest-Deadline: 2023-08-11T10:36+00:00
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

This is the start of the stable review cycle for the 4.14.322 release.
There are 204 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Fri, 11 Aug 2023 10:36:10 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.322-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.14.322-rc1

Roger Quadros <rogerq@kernel.org>
    mtd: rawnand: omap_elm: Fix incorrect type in assignment

Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
    test_firmware: fix a memory leak with reqs buffer

Jan Kara <jack@suse.cz>
    ext2: Drop fragment support

Alan Stern <stern@rowland.harvard.edu>
    net: usbnet: Fix WARNING in usbnet_start_xmit/usb_submit_urb

Sungwoo Kim <iam@sung-woo.kim>
    Bluetooth: L2CAP: Fix use-after-free in l2cap_sock_ready_cb

Prince Kumar Maurya <princekumarmaurya06@gmail.com>
    fs/sysv: Null check to prevent null-ptr-deref bug

Ross Maynard <bids.7405@bigpond.com>
    USB: zaurus: Add ID for A-300/B-500/C-700

Ilya Dryomov <idryomov@gmail.com>
    libceph: fix potential hang in ceph_osdc_notify()

Bart Van Assche <bvanassche@acm.org>
    loop: Select I/O scheduler 'none' from inside add_disk()

Eric Dumazet <edumazet@google.com>
    tcp_metrics: fix data-race in tcpm_suck_dst() vs fastopen

Eric Dumazet <edumazet@google.com>
    tcp_metrics: annotate data-races around tm->tcpm_net

Eric Dumazet <edumazet@google.com>
    tcp_metrics: annotate data-races around tm->tcpm_vals[]

Eric Dumazet <edumazet@google.com>
    tcp_metrics: annotate data-races around tm->tcpm_lock

Eric Dumazet <edumazet@google.com>
    tcp_metrics: annotate data-races around tm->tcpm_stamp

Eric Dumazet <edumazet@google.com>
    tcp_metrics: fix addr_same() helper

Yue Haibing <yuehaibing@huawei.com>
    ip6mr: Fix skb_under_panic in ip6mr_cache_report()

valis <sec@valis.email>
    net/sched: cls_route: No longer copy tcf_result on update to avoid use-after-free

valis <sec@valis.email>
    net/sched: cls_u32: No longer copy tcf_result on update to avoid use-after-free

Eric Dumazet <edumazet@google.com>
    net: add missing data-race annotation for sk_ll_usec

Eric Dumazet <edumazet@google.com>
    net: add missing data-race annotations around sk->sk_peek_off

Georg Müller <georgmueller@gmx.net>
    perf test uprobe_from_different_cu: Skip if there is no gcc

Yuanjun Gong <ruc_gongyuanjun@163.com>
    net/mlx5e: fix return value check in mlx5e_ipsec_remove_trailer()

ndesaulniers@google.com <ndesaulniers@google.com>
    word-at-a-time: use the same return type for has_zero regardless of endianness

Peter Zijlstra <peterz@infradead.org>
    perf: Fix function pointer case

Lee Jones <lee@kernel.org>
    net/sched: cls_u32: Fix reference counter leak leading to overflow

Pedro Tammela <pctammela@mojatatu.com>
    net/sched: sch_qfq: account for stab overhead in qfq_enqueue

M A Ramdhan <ramdhan@starlabs.sg>
    net/sched: cls_fw: Fix improper refcount update leads to use-after-free

Jocelyn Falempe <jfalempe@redhat.com>
    drm/client: Fix memory leak in drm_client_target_cloned

Joe Thornber <ejt@redhat.com>
    dm cache policy smq: ensure IO doesn't prevent cleaner policy progress

Mark Brown <broonie@kernel.org>
    ASoC: wm8904: Fill the cache for WM8904_ADC_TEST_0 register

Stefan Haberland <sth@linux.ibm.com>
    s390/dasd: fix hanging device after quiesce/resume

Jonas Gorski <jonas.gorski@gmail.com>
    irq-bcm6345-l1: Do not assume a fixed block to cpu mapping

Alexander Steffen <Alexander.Steffen@infineon.com>
    tpm_tis: Explicitly check for error code

Gilles Buloz <Gilles.Buloz@kontron.com>
    hwmon: (nct7802) Fix for temp6 (PECI1) processed even if PECI1 disabled

Zhang Shurong <zhang_shurong@foxmail.com>
    staging: ks7010: potential buffer overflow in ks_wlan_set_encode_ext()

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Documentation: security-bugs.rst: update preferences when dealing with the linux-distros group

Ricardo Ribalda <ribalda@chromium.org>
    usb: xhci-mtk: set the dma max_seg_size

Guiting Shen <aarongt.shen@gmail.com>
    usb: ohci-at91: Fix the unhandle interrupt when resume

Marc Kleine-Budde <mkl@pengutronix.de>
    can: gs_usb: gs_can_close(): add missing set of CAN state to CAN_STATE_STOPPED

Johan Hovold <johan@kernel.org>
    USB: serial: simple: sort driver entries

Oliver Neukum <oneukum@suse.com>
    USB: serial: simple: add Kaufmann RKS+CAN VCP

Mohsen Tahmasebi <moh53n@moh53n.ir>
    USB: serial: option: add Quectel EC200A module support

Jerry Meng <jerry-meng@foxmail.com>
    USB: serial: option: support Quectel EM060K_128

Zheng Yejian <zhengyejian1@huawei.com>
    tracing: Fix warning in trace_buffered_event_disable()

Zheng Yejian <zhengyejian1@huawei.com>
    ring-buffer: Fix wrong stat of cpu_buffer->read

Arnd Bergmann <arnd@arndb.de>
    ata: pata_ns87415: mark ns87560_tf_read static

Yu Kuai <yukuai3@huawei.com>
    dm raid: fix missing reconfig_mutex unlock in raid_ctr() error paths

Bart Van Assche <bvanassche@acm.org>
    block: Fix a source code comment in include/uapi/linux/blkzoned.h

Matus Gajdos <matuszpd@gmail.com>
    ASoC: fsl_spdif: Silence output on stop

Yuanjun Gong <ruc_gongyuanjun@163.com>
    benet: fix return value check in be_lancer_xmit_workarounds()

Maxim Mikityanskiy <maxtram95@gmail.com>
    platform/x86: msi-laptop: Fix rfkill out-of-sync on MSI Wind U100

Hangbin Liu <liuhangbin@gmail.com>
    team: reset team's flags when down link is P2P device

Hangbin Liu <liuhangbin@gmail.com>
    bonding: reset bond's flags when down link is P2P device

Stewart Smith <trawets@amazon.com>
    tcp: Reduce chance of collisions in inet6_hashfn().

Maciej Żenczykowski <maze@google.com>
    ipv6 addrconf: fix bug where deleting a mngtmpaddr can create a new temporary address

Yuanjun Gong <ruc_gongyuanjun@163.com>
    ethernet: atheros: fix return value check in atl1e_tso_csum()

Wang Ming <machel@vivo.com>
    i40e: Fix an NULL vs IS_ERR() bug for debugfs_create_dir()

Hans de Goede <hdegoede@redhat.com>
    gpio: tps68470: Make tps68470_gpio_output() always set the initial value

Eric Dumazet <edumazet@google.com>
    tcp: annotate data-races around fastopenq.max_qlen

Eric Dumazet <edumazet@google.com>
    tcp: annotate data-races around tp->notsent_lowat

Eric Dumazet <edumazet@google.com>
    tcp: annotate data-races around rskq_defer_accept

Florian Westphal <fw@strlen.de>
    netfilter: nf_tables: fix spurious set element insertion failure

Kuniyuki Iwashima <kuniyu@amazon.com>
    llc: Don't drop packet from non-root netns.

Zhang Shurong <zhang_shurong@foxmail.com>
    fbdev: au1200fb: Fix missing IRQ check in au1200fb_drv_probe

Tanmay Patil <t-patil@ti.com>
    net: ethernet: ti: cpsw_ale: Fix cpsw_ale_get_field()/cpsw_ale_set_field()

Mario Limonciello <mario.limonciello@amd.com>
    pinctrl: amd: Use amd_pinconf_set() for all config options

Martin Kaiser <martin@kaiser.cx>
    fbdev: imxfb: warn about invalid left/right margin

Jonas Gorski <jonas.gorski@gmail.com>
    spi: bcm63xx: fix max prepend length

Ying Hsu <yinghsu@chromium.org>
    igb: Fix igb_down hung on surprise removal

Gustavo A. R. Silva <gustavoars@kernel.org>
    wifi: wext-core: Fix -Wstringop-overflow warning in ioctl_standard_iw_point()

Martin KaFai Lau <martin.lau@kernel.org>
    bpf: Address KCSAN report on bpf_lru_list

Yicong Yang <yangyicong@hisilicon.com>
    sched/fair: Don't balance task to its current running CPU

Thomas Gleixner <tglx@linutronix.de>
    posix-timers: Ensure timer ID search-loop limit is valid

Yu Kuai <yukuai3@huawei.com>
    md/raid10: prevent soft lockup while flush writes

Yu Kuai <yukuai3@huawei.com>
    md: fix data corruption for raid456 when reshape restart while grow up

Zhong Jinghua <zhongjinghua@huawei.com>
    nbd: Add the maximum limit of allocated index in nbd_dev_add

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    debugobjects: Recheck debug_objects_enabled before reporting

Eric Whitney <enwlinux@gmail.com>
    ext4: correct inline offset when handling xattrs in inode body

YueHaibing <yuehaibing@huawei.com>
    can: bcm: Fix UAF in bcm_proc_show()

Miklos Szeredi <mszeredi@redhat.com>
    fuse: revalidate: don't invalidate if interrupted

Georg Müller <georgmueller@gmx.net>
    perf probe: Add test for regression introduced by switch to die_get_decl_file()

Dan Carpenter <dan.carpenter@linaro.org>
    serial: atmel: don't enable IRQs prematurely

Shreyas Deodhar <sdeodhar@marvell.com>
    scsi: qla2xxx: Pointer may be dereferenced

Nilesh Javali <njavali@marvell.com>
    scsi: qla2xxx: Check valid rport returned by fc_bsg_to_rport()

Bikash Hazarika <bhazarika@marvell.com>
    scsi: qla2xxx: Fix potential NULL pointer dereference

Quinn Tran <qutran@marvell.com>
    scsi: qla2xxx: Wait for io return on terminate rport

Max Filippov <jcmvbkbc@gmail.com>
    xtensa: ISS: fix call to split_if_spec

Zheng Yejian <zhengyejian1@huawei.com>
    ring-buffer: Fix deadloop issue on reading trace_pipe

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    tty: serial: samsung_tty: Fix a memory leak in s3c24xx_serial_getclk() when iterating clk

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    tty: serial: samsung_tty: Fix a memory leak in s3c24xx_serial_getclk() in case of error

Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
    Revert "8250: add support for ASIX devices with a FIFO bug"

George Stark <gnstark@sberdevices.ru>
    meson saradc: fix clock divider mask length

Martin Kaiser <martin@kaiser.cx>
    hwrng: imx-rngc - fix the timeout for init and self check

Alexander Aring <aahringo@redhat.com>
    fs: dlm: return positive pid value for F_GETLK

Jason Baron <jbaron@akamai.com>
    md/raid0: add discard support for the 'original' layout

Damien Le Moal <dlemoal@kernel.org>
    misc: pci_endpoint_test: Re-init completion for every test

Robin Murphy <robin.murphy@arm.com>
    PCI: Add function 1 DMA alias quirk for Marvell 88SE9235

Siddh Raman Pant <code@siddh.me>
    jfs: jfs_dmap: Validate db_l2nbperpage while mounting

Baokun Li <libaokun1@huawei.com>
    ext4: only update i_reserved_data_blocks on successful block allocation

Kemeng Shi <shikemeng@huaweicloud.com>
    ext4: fix wrong unit use in ext4_mb_clear_bb

Adrian Hunter <adrian.hunter@intel.com>
    perf intel-pt: Fix CYC timestamps after standalone CBR

Ding Hui <dinghui@sangfor.com.cn>
    SUNRPC: Fix UAF in svc_tcp_listen_data_ready()

Jarkko Sakkinen <jarkko.sakkinen@tuni.fi>
    tpm: tpm_vtpm_proxy: fix a race condition in /dev/vtpmx creation

Pedro Tammela <pctammela@mojatatu.com>
    net/sched: make psched_mtu() RTNL-less safe

Randy Dunlap <rdunlap@infradead.org>
    wifi: airo: avoid uninitialized warning in airo_get_rate()

Ziyang Xuan <william.xuanziyang@huawei.com>
    ipv6/addrconf: fix a potential refcount underflow for idev

Yang Yingliang <yangyingliang@huawei.com>
    NTB: ntb_transport: fix possible memory leak while device_register() fails

Yuan Can <yuancan@huawei.com>
    ntb: intel: Fix error handling in intel_ntb_pci_driver_init()

Yuan Can <yuancan@huawei.com>
    NTB: amd: Fix error handling in amd_ntb_pci_driver_init()

Yuan Can <yuancan@huawei.com>
    ntb: idt: Fix error handling in idt_pci_driver_init()

Eric Dumazet <edumazet@google.com>
    udp6: fix udp6_ehashfn() typo

Klaus Kudielka <klaus.kudielka@gmail.com>
    net: mvneta: fix txq_map in case of txq_number==1

Linus Torvalds <torvalds@linux-foundation.org>
    workqueue: clean up WORK_* constant types, clarify masking

Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
    netfilter: nf_tables: prevent OOB access in nft_byteorder_eval

Florent Revest <revest@chromium.org>
    netfilter: conntrack: Avoid nf_ct_helper_hash uses after free

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: unbind non-anonymous set if rule construction fails

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: add NFT_TRANS_PREPARE_ERROR to deal with bound set/chain

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: incorrect error path handling with NFT_MSG_NEWRULE

Rasmus Villemoes <rasmus.villemoes@prevas.dk>
    spi: spi-fsl-spi: allow changing bits_per_word while CS is still active

Rasmus Villemoes <rasmus.villemoes@prevas.dk>
    spi: spi-fsl-spi: relax message sanity checking a little

Rasmus Villemoes <rasmus.villemoes@prevas.dk>
    spi: spi-fsl-spi: remove always-true conditional in fsl_spi_do_one_msg

Arnd Bergmann <arnd@arndb.de>
    ARM: orion5x: fix d2net gpio initialization

Filipe Manana <fdmanana@suse.com>
    btrfs: fix race when deleting quota root from the dirty cow roots list

Fabian Frederick <fabf@skynet.be>
    jffs2: reduce stack usage in jffs2_build_xattr_subsystem()

Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
    integrity: Fix possible multiple allocation in integrity_inode_get()

Robert Marko <robimarko@gmail.com>
    mmc: core: disable TRIM on Micron MTFC4GACAJCN-1M

Robert Marko <robimarko@gmail.com>
    mmc: core: disable TRIM on Kingston EMMC04G-M627

Dai Ngo <dai.ngo@oracle.com>
    NFSD: add encoding of op_recall flag for write delegation

Artur Rojek <contact@artur-rojek.eu>
    sh: dma: Fix DMA channel offset calculation

Lin Ma <linma@zju.edu.cn>
    net/sched: act_pedit: Add size check for TCA_PEDIT_PARMS_EX

Eric Dumazet <edumazet@google.com>
    tcp: annotate data races in __tcp_oow_rate_limited()

Vladimir Oltean <vladimir.oltean@nxp.com>
    net: bridge: keep ports without IFF_UNICAST_FLT in BR_PROMISC mode

Randy Dunlap <rdunlap@infradead.org>
    powerpc: allow PPC_EARLY_DEBUG_CPM only when SERIAL_CPM=y

Nishanth Menon <nm@ti.com>
    mailbox: ti-msgmgr: Fill non-message tx data fields with 0x0

Jonas Gorski <jonas.gorski@gmail.com>
    spi: bcm-qspi: return error if neither hif_mspi nor mspi is available

Tobias Heider <me@tobhe.de>
    Add MODULE_FIRMWARE() for FIRMWARE_TG357766.

Chengfeng Ye <dg573847474@gmail.com>
    sctp: fix potential deadlock on &net->sctp.addr_wq_lock

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    rtc: st-lpc: Release some resources in st_rtc_probe() in case of error

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    mfd: stmpe: Only disable the regulators if they are enabled

Jiasheng Jiang <jiasheng@iscas.ac.cn>
    mfd: intel-lpss: Add missing check for platform_get_resource

Stephan Gerhold <stephan@gerhold.net>
    mfd: rt5033: Drop rt5033-battery sub-device

Li Yang <lidaxian@hust.edu.cn>
    usb: phy: phy-tahvo: fix memory leak in tahvo_usb_probe()

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    extcon: Fix kernel doc of property capability fields to avoid warnings

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    extcon: Fix kernel doc of property fields to avoid warnings

Duoming Zhou <duoming@zju.edu.cn>
    media: usb: siano: Fix warning due to null work_func_t function pointer

Marek Vasut <marex@denx.de>
    media: videodev2.h: Fix struct v4l2_input tuner index comment

Daniil Dulov <d.dulov@aladdin.ru>
    media: usb: Check az6007_read() return value

John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
    sh: j2: Use ioremap() to translate device tree address into kernel memory

Dan Carpenter <dan.carpenter@oracle.com>
    w1: fix loop in w1_fini()

Michael Schmitz <schmitzmic@gmail.com>
    block: change all __u32 annotations to __be32 in affs_hardblocks.h

Davide Tronchin <davide.tronchin.94@gmail.com>
    USB: serial: option: add LARA-R6 01B PIDs

Dan Carpenter <dan.carpenter@linaro.org>
    modpost: fix off by one in is_executable_section()

Masahiro Yamada <masahiroy@kernel.org>
    modpost: fix section mismatch message for R_ARM_{PC24,CALL,JUMP24}

Masahiro Yamada <masahiroy@kernel.org>
    modpost: fix section mismatch message for R_ARM_ABS32

Randy Dunlap <rdunlap@infradead.org>
    crypto: nx - fix build warnings when DEBUG_FS is not enabled

Claudiu Beznea <claudiu.beznea@microchip.com>
    pinctrl: at91-pio4: check return value of devm_kasprintf()

Namhyung Kim <namhyung@kernel.org>
    perf dwarf-aux: Fix off-by-one in die_get_varname()

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    pinctrl: cherryview: Return correct value if pin in push-pull mode

Sui Jingfeng <suijingfeng@loongson.cn>
    PCI: Add pci_clear_master() stub for non-CONFIG_PCI

Yuchen Yang <u202114568@hust.edu.cn>
    scsi: 3w-xxxx: Add error handling for initialization failure in tw_probe()

Su Hui <suhui@nfschina.com>
    ALSA: ac97: Fix possible NULL dereference in snd_ac97_mixer

Nikita Zhandarovich <n.zhandarovich@fintech.ru>
    drm/radeon: fix possible division-by-zero errors

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    fbdev: omapfb: lcd_mipid: Fix an error handling path in mipid_spi_probe()

Randy Dunlap <rdunlap@infradead.org>
    soc/fsl/qe: fix usb.c build errors

Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
    ASoC: es8316: Increment max value for ALC Capture Target Volume control

Arnd Bergmann <arnd@arndb.de>
    ARM: ep93xx: fix missing-prototype warnings

Dario Binacchi <dario.binacchi@amarulasolutions.com>
    drm/panel: simple: fix active size for Ampire AM-480272H3TMQW-T01H

Marek Vasut <marex@denx.de>
    Input: adxl34x - do not hardcode interrupt trigger type

Rafał Miłecki <rafal@milecki.pl>
    ARM: dts: BCM5301X: Drop "clock-names" from the SPI node

Luca Weiss <luca@z3ntu.xyz>
    Input: drv260x - sleep between polling GO bit

Nikita Zhandarovich <n.zhandarovich@fintech.ru>
    radeon: avoid double free in ci_dpm_init()

Kuniyuki Iwashima <kuniyu@amazon.com>
    netlink: Add __sock_i_ino() for __netlink_diag_dump().

Ilia.Gavrilov <Ilia.Gavrilov@infotecs.ru>
    netfilter: nf_conntrack_sip: fix the ct_sip_parse_numerical_param() return value.

Jeremy Sowden <jeremy@azazel.net>
    lib/ts_bm: reset initial match offset for every block of text

Kuniyuki Iwashima <kuniyu@amazon.com>
    gtp: Fix use-after-free in __gtp_encap_destroy().

Eric Dumazet <edumazet@google.com>
    netlink: do not hard code device address lenth in fdb dumps

Eric Dumazet <edumazet@google.com>
    netlink: fix potential deadlock in netlink_set_err()

Dmitry Antipov <dmantipov@yandex.ru>
    wifi: ath9k: convert msecs to jiffies where needed

Remi Pommarel <repk@triplefau.lt>
    wifi: ath9k: Fix possible stall on ath9k_txq_list_has_key()

Arnd Bergmann <arnd@arndb.de>
    memstick r592: make memstick_debug_get_tpc_name() static

Zhen Lei <thunder.leizhen@huawei.com>
    kexec: fix a memory leak in crash_shrink_memory()

Douglas Anderson <dianders@chromium.org>
    watchdog/perf: more properly prevent false positives with turbo modes

Douglas Anderson <dianders@chromium.org>
    watchdog/perf: define dummy watchdog_update_hrtimer_threshold() on correct config

Fedor Pchelkin <pchelkin@ispras.ru>
    wifi: ath9k: don't allow to overwrite ENDPOINT0 attributes

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    wifi: ray_cs: Fix an error handling path in ray_probe()

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    wifi: wl3501_cs: Fix an error handling path in wl3501_probe()

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    wifi: atmel: Fix an error handling path in atmel_probe()

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    wifi: orinoco: Fix an error handling path in orinoco_cs_probe()

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    wifi: orinoco: Fix an error handling path in spectrum_cs_probe()

Fedor Pchelkin <pchelkin@ispras.ru>
    wifi: ath9k: avoid referencing uninit memory in ath9k_wmi_ctrl_rx

Peter Seiderer <ps.report@gmx.net>
    wifi: ath9k: fix AR9003 mac hardware hang check register offset calculation

Roberto Sassu <roberto.sassu@huawei.com>
    evm: Complete description of evm_inode_setattr()

Nikita Zhandarovich <n.zhandarovich@fintech.ru>
    PM: domains: fix integer overflow issues in genpd_parse_state()

Li Nan <linan122@huawei.com>
    md/raid10: fix io loss while replacement replace rdev

Li Nan <linan122@huawei.com>
    md/raid10: fix wrong setting of max_corr_read_errors

Li Nan <linan122@huawei.com>
    md/raid10: fix overflow of md/safe_mode_delay

Kees Cook <keescook@chromium.org>
    treewide: Remove uninitialized_var() usage

Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
    drm/amdgpu: Validate VM ioctl flags.

Ahmed S. Darwish <darwi@linutronix.de>
    scripts/tags.sh: Resolve gtags empty index generation

Lyude Paul <lyude@redhat.com>
    drm/edid: Fix uninitialized variable in drm_cvt_modes()

Zheng Wang <zyytlz.wz@163.com>
    fbdev: imsttfb: Fix use after free bug in imsttfb_probe

Thomas Gleixner <tglx@linutronix.de>
    x86/smp: Use dedicated cache-line for mwait_play_dead()

Borislav Petkov (AMD) <bp@alien8.de>
    x86/microcode/AMD: Load late on both threads too

Bob Peterson <rpeterso@redhat.com>
    gfs2: Don't deref jdesc in evict


-------------

Diffstat:

 Documentation/admin-guide/security-bugs.rst        | 24 +++----
 Makefile                                           |  4 +-
 arch/arm/boot/dts/bcm5301x.dtsi                    |  1 -
 arch/arm/mach-ep93xx/timer-ep93xx.c                |  3 +-
 arch/arm/mach-orion5x/board-dt.c                   |  3 +
 arch/arm/mach-orion5x/common.h                     |  6 ++
 arch/arm/mach-sa1100/assabet.c                     |  2 +-
 arch/ia64/kernel/process.c                         |  2 +-
 arch/ia64/mm/discontig.c                           |  2 +-
 arch/ia64/mm/tlb.c                                 |  2 +-
 arch/powerpc/Kconfig.debug                         |  2 +-
 arch/powerpc/include/asm/word-at-a-time.h          |  2 +-
 arch/powerpc/platforms/52xx/mpc52xx_pic.c          |  2 +-
 arch/s390/kernel/smp.c                             |  2 +-
 arch/sh/drivers/dma/dma-sh.c                       | 37 ++++++----
 arch/sh/kernel/cpu/sh2/probe.c                     |  2 +-
 arch/x86/kernel/cpu/microcode/amd.c                |  2 +-
 arch/x86/kernel/quirks.c                           | 10 +--
 arch/x86/kernel/smpboot.c                          | 24 ++++---
 arch/xtensa/platforms/iss/network.c                |  2 +-
 drivers/acpi/acpi_pad.c                            |  2 +-
 drivers/ata/libata-scsi.c                          |  2 +-
 drivers/ata/pata_ns87415.c                         |  2 +-
 drivers/atm/zatm.c                                 |  2 +-
 drivers/base/power/domain.c                        |  6 +-
 drivers/block/drbd/drbd_nl.c                       |  6 +-
 drivers/block/loop.c                               |  3 +-
 drivers/block/nbd.c                                |  3 +-
 drivers/char/hw_random/imx-rngc.c                  |  6 +-
 drivers/char/tpm/tpm_tis_core.c                    | 10 ++-
 drivers/char/tpm/tpm_vtpm_proxy.c                  | 30 ++------
 drivers/clk/clk-gate.c                             |  2 +-
 drivers/crypto/nx/Makefile                         |  2 +-
 drivers/crypto/nx/nx.h                             |  4 +-
 drivers/extcon/extcon.c                            |  8 +++
 drivers/firewire/ohci.c                            | 14 ++--
 drivers/gpio/gpio-tps68470.c                       |  6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             |  4 ++
 drivers/gpu/drm/bridge/sil-sii8620.c               |  2 +-
 drivers/gpu/drm/drm_edid.c                         |  4 +-
 drivers/gpu/drm/drm_fb_helper.c                    |  5 ++
 drivers/gpu/drm/exynos/exynos_drm_dsi.c            |  6 +-
 drivers/gpu/drm/panel/panel-simple.c               |  4 +-
 drivers/gpu/drm/radeon/ci_dpm.c                    | 28 +++++---
 drivers/gpu/drm/radeon/cypress_dpm.c               |  8 ++-
 drivers/gpu/drm/radeon/ni_dpm.c                    |  8 ++-
 drivers/gpu/drm/radeon/rv740_dpm.c                 |  8 ++-
 drivers/hwmon/nct7802.c                            |  2 +-
 drivers/i2c/busses/i2c-rk3x.c                      |  2 +-
 drivers/ide/ide-acpi.c                             |  2 +-
 drivers/ide/ide-atapi.c                            |  2 +-
 drivers/ide/ide-io-std.c                           |  4 +-
 drivers/ide/ide-io.c                               |  4 +-
 drivers/ide/ide-sysfs.c                            |  2 +-
 drivers/ide/umc8672.c                              |  2 +-
 drivers/iio/adc/meson_saradc.c                     |  2 +-
 drivers/infiniband/core/uverbs_cmd.c               |  4 +-
 drivers/infiniband/hw/cxgb4/cm.c                   |  2 +-
 drivers/infiniband/hw/mlx5/cq.c                    |  2 +-
 drivers/infiniband/hw/mthca/mthca_qp.c             | 10 +--
 drivers/input/misc/adxl34x.c                       |  3 +-
 drivers/input/misc/drv260x.c                       |  1 +
 drivers/input/serio/serio_raw.c                    |  2 +-
 drivers/irqchip/irq-bcm6345-l1.c                   | 14 ++--
 drivers/mailbox/ti-msgmgr.c                        | 12 +++-
 drivers/md/dm-cache-policy-smq.c                   | 28 +++++---
 drivers/md/dm-io.c                                 |  2 +-
 drivers/md/dm-ioctl.c                              |  2 +-
 drivers/md/dm-raid.c                               |  9 ++-
 drivers/md/dm-snap-persistent.c                    |  2 +-
 drivers/md/dm-table.c                              |  2 +-
 drivers/md/md.c                                    | 23 ++++--
 drivers/md/raid0.c                                 | 62 +++++++++++++---
 drivers/md/raid0.h                                 |  1 +
 drivers/md/raid10.c                                | 24 +++++--
 drivers/md/raid5.c                                 |  2 +-
 drivers/media/dvb-frontends/rtl2832.c              |  2 +-
 drivers/media/usb/dvb-usb-v2/az6007.c              |  3 +-
 drivers/media/usb/gspca/vicam.c                    |  2 +-
 drivers/media/usb/siano/smsusb.c                   |  3 +-
 drivers/media/usb/uvc/uvc_video.c                  |  8 +--
 drivers/memstick/host/jmb38x_ms.c                  |  2 +-
 drivers/memstick/host/r592.c                       |  4 +-
 drivers/memstick/host/tifm_ms.c                    |  2 +-
 drivers/mfd/intel-lpss-acpi.c                      |  3 +
 drivers/mfd/rt5033.c                               |  3 -
 drivers/mfd/stmpe.c                                |  4 +-
 drivers/misc/pci_endpoint_test.c                   |  4 ++
 drivers/mmc/core/quirks.h                          | 14 ++++
 drivers/mmc/host/sdhci.c                           |  2 +-
 drivers/mtd/nand/omap_elm.c                        | 24 +++----
 drivers/mtd/ubi/eba.c                              |  2 +-
 drivers/net/bonding/bond_main.c                    |  5 ++
 drivers/net/can/janz-ican3.c                       |  2 +-
 drivers/net/can/usb/gs_usb.c                       |  2 +
 drivers/net/ethernet/atheros/atl1e/atl1e_main.c    |  7 +-
 drivers/net/ethernet/broadcom/bnx2.c               |  4 +-
 drivers/net/ethernet/broadcom/tg3.c                |  1 +
 drivers/net/ethernet/emulex/benet/be_main.c        |  3 +-
 drivers/net/ethernet/intel/i40e/i40e_debugfs.c     |  2 +-
 drivers/net/ethernet/intel/igb/igb_main.c          |  5 ++
 drivers/net/ethernet/marvell/mvneta.c              |  4 +-
 .../mellanox/mlx5/core/en_accel/ipsec_rxtx.c       |  4 +-
 .../net/ethernet/mellanox/mlx5/core/pagealloc.c    |  4 +-
 drivers/net/ethernet/neterion/s2io.c               |  2 +-
 drivers/net/ethernet/qlogic/qla3xxx.c              |  2 +-
 drivers/net/ethernet/sun/cassini.c                 |  2 +-
 drivers/net/ethernet/sun/niu.c                     |  6 +-
 drivers/net/ethernet/ti/cpsw_ale.c                 | 24 +++++--
 drivers/net/gtp.c                                  |  2 +
 drivers/net/team/team.c                            |  9 +++
 drivers/net/usb/cdc_ether.c                        | 21 ++++++
 drivers/net/usb/usbnet.c                           |  6 ++
 drivers/net/usb/zaurus.c                           | 21 ++++++
 drivers/net/wan/z85230.c                           |  2 +-
 drivers/net/wireless/ath/ath10k/core.c             |  2 +-
 drivers/net/wireless/ath/ath6kl/init.c             |  2 +-
 drivers/net/wireless/ath/ath9k/ar9003_hw.c         | 27 ++++---
 drivers/net/wireless/ath/ath9k/htc_hst.c           |  8 ++-
 drivers/net/wireless/ath/ath9k/init.c              |  2 +-
 drivers/net/wireless/ath/ath9k/main.c              | 11 +--
 drivers/net/wireless/ath/ath9k/wmi.c               |  4 ++
 drivers/net/wireless/atmel/atmel_cs.c              | 13 +++-
 drivers/net/wireless/broadcom/b43/debugfs.c        |  2 +-
 drivers/net/wireless/broadcom/b43/dma.c            |  2 +-
 drivers/net/wireless/broadcom/b43/lo.c             |  2 +-
 drivers/net/wireless/broadcom/b43/phy_n.c          |  2 +-
 drivers/net/wireless/broadcom/b43/xmit.c           | 12 ++--
 drivers/net/wireless/broadcom/b43legacy/debugfs.c  |  2 +-
 drivers/net/wireless/broadcom/b43legacy/main.c     |  2 +-
 drivers/net/wireless/cisco/airo.c                  |  5 +-
 drivers/net/wireless/intel/iwlegacy/3945.c         |  2 +-
 drivers/net/wireless/intel/iwlegacy/4965-mac.c     |  2 +-
 drivers/net/wireless/intersil/orinoco/orinoco_cs.c | 13 +++-
 .../net/wireless/intersil/orinoco/spectrum_cs.c    | 13 +++-
 drivers/net/wireless/ray_cs.c                      | 16 +++--
 drivers/net/wireless/wl3501_cs.c                   | 16 +++--
 drivers/ntb/hw/amd/ntb_hw_amd.c                    |  7 +-
 drivers/ntb/hw/idt/ntb_hw_idt.c                    |  7 +-
 drivers/ntb/hw/intel/ntb_hw_intel.c                |  7 +-
 drivers/ntb/ntb_transport.c                        |  2 +-
 drivers/pci/quirks.c                               |  2 +
 drivers/pinctrl/intel/pinctrl-cherryview.c         | 15 ++--
 drivers/pinctrl/pinctrl-amd.c                      | 28 ++++----
 drivers/pinctrl/pinctrl-at91-pio4.c                |  2 +
 drivers/platform/x86/hdaps.c                       |  4 +-
 drivers/platform/x86/msi-laptop.c                  |  8 +--
 drivers/rtc/rtc-st-lpc.c                           |  2 +-
 drivers/s390/block/dasd_ioctl.c                    |  1 +
 drivers/scsi/3w-xxxx.c                             |  4 +-
 drivers/scsi/dc395x.c                              |  2 +-
 drivers/scsi/pm8001/pm8001_hwi.c                   |  2 +-
 drivers/scsi/pm8001/pm80xx_hwi.c                   |  2 +-
 drivers/scsi/qla2xxx/qla_attr.c                    | 13 ++++
 drivers/scsi/qla2xxx/qla_bsg.c                     |  6 ++
 drivers/scsi/qla2xxx/qla_iocb.c                    |  3 +-
 drivers/soc/fsl/qe/Kconfig                         |  1 +
 drivers/spi/spi-bcm-qspi.c                         | 10 +--
 drivers/spi/spi-bcm63xx.c                          |  2 +-
 drivers/spi/spi-fsl-spi.c                          | 25 +++----
 drivers/ssb/driver_chipcommon.c                    |  4 +-
 drivers/staging/ks7010/ks_wlan_net.c               |  6 +-
 drivers/tty/cyclades.c                             |  2 +-
 drivers/tty/isicom.c                               |  2 +-
 drivers/tty/serial/8250/8250.h                     |  1 -
 drivers/tty/serial/8250/8250_pci.c                 | 19 -----
 drivers/tty/serial/8250/8250_port.c                | 11 +--
 drivers/tty/serial/atmel_serial.c                  |  4 +-
 drivers/tty/serial/samsung.c                       | 14 +++-
 drivers/usb/host/ohci-at91.c                       |  8 ++-
 drivers/usb/host/xhci-mtk.c                        |  1 +
 drivers/usb/musb/cppi_dma.c                        |  2 +-
 drivers/usb/phy/phy-tahvo.c                        |  2 +-
 drivers/usb/serial/option.c                        | 10 +++
 drivers/usb/serial/usb-serial-simple.c             | 73 ++++++++++---------
 drivers/usb/storage/sddr55.c                       |  4 +-
 drivers/vhost/net.c                                |  4 +-
 drivers/video/fbdev/au1200fb.c                     |  3 +
 drivers/video/fbdev/imsttfb.c                      | 18 ++---
 drivers/video/fbdev/imxfb.c                        |  4 +-
 drivers/video/fbdev/matrox/matroxfb_maven.c        |  6 +-
 drivers/video/fbdev/omap/lcd_mipid.c               |  6 +-
 drivers/video/fbdev/pm3fb.c                        |  6 +-
 drivers/video/fbdev/riva/riva_hw.c                 |  3 +-
 drivers/virtio/virtio_ring.c                       |  2 +-
 drivers/w1/w1.c                                    |  4 +-
 fs/afs/dir.c                                       |  2 +-
 fs/afs/security.c                                  |  2 +-
 fs/btrfs/qgroup.c                                  |  2 +
 fs/dlm/netlink.c                                   |  2 +-
 fs/dlm/plock.c                                     |  4 +-
 fs/ext2/ext2.h                                     | 12 ----
 fs/ext2/super.c                                    | 23 ++----
 fs/ext4/indirect.c                                 |  8 +++
 fs/ext4/inode.c                                    | 10 ---
 fs/ext4/mballoc.c                                  |  4 +-
 fs/ext4/xattr.c                                    | 14 ++++
 fs/fat/dir.c                                       |  2 +-
 fs/fuse/control.c                                  |  2 +-
 fs/fuse/cuse.c                                     |  2 +-
 fs/fuse/dir.c                                      |  2 +-
 fs/fuse/file.c                                     |  2 +-
 fs/gfs2/aops.c                                     |  2 +-
 fs/gfs2/super.c                                    |  8 +++
 fs/hfsplus/unicode.c                               |  2 +-
 fs/isofs/namei.c                                   |  4 +-
 fs/jffs2/build.c                                   |  5 +-
 fs/jffs2/erase.c                                   |  2 +-
 fs/jffs2/xattr.c                                   | 13 ++--
 fs/jffs2/xattr.h                                   |  4 +-
 fs/jfs/jfs_dmap.c                                  |  6 ++
 fs/jfs/jfs_filsys.h                                |  2 +
 fs/nfsd/nfs4xdr.c                                  |  2 +-
 fs/nfsd/nfsctl.c                                   |  2 +-
 fs/ocfs2/alloc.c                                   |  4 +-
 fs/ocfs2/dir.c                                     | 14 ++--
 fs/ocfs2/extent_map.c                              |  4 +-
 fs/ocfs2/namei.c                                   |  2 +-
 fs/ocfs2/refcounttree.c                            |  2 +-
 fs/ocfs2/xattr.c                                   |  2 +-
 fs/omfs/file.c                                     |  2 +-
 fs/sysv/itree.c                                    |  4 ++
 fs/ubifs/commit.c                                  |  6 +-
 fs/ubifs/file.c                                    |  4 +-
 fs/ubifs/journal.c                                 |  2 +-
 fs/ubifs/lpt.c                                     |  2 +-
 fs/ubifs/tnc.c                                     |  6 +-
 fs/ubifs/tnc_misc.c                                |  4 +-
 fs/udf/balloc.c                                    |  2 +-
 fs/xfs/xfs_bmap_util.c                             |  2 +-
 include/asm-generic/word-at-a-time.h               |  2 +-
 include/linux/nmi.h                                |  2 +-
 include/linux/pci.h                                |  1 +
 include/linux/sched/signal.h                       |  2 +-
 include/linux/serial_8250.h                        |  1 -
 include/linux/tcp.h                                |  2 +-
 include/linux/workqueue.h                          | 15 ++--
 include/net/ipv6.h                                 |  8 +--
 include/net/netfilter/nf_tables.h                  |  1 +
 include/net/pkt_sched.h                            |  2 +-
 include/net/sock.h                                 |  1 +
 include/net/tcp.h                                  |  6 +-
 include/uapi/linux/affs_hardblocks.h               | 68 +++++++++---------
 include/uapi/linux/blkzoned.h                      | 10 +--
 include/uapi/linux/videodev2.h                     |  2 +-
 kernel/async.c                                     |  4 +-
 kernel/audit.c                                     |  2 +-
 kernel/bpf/bpf_lru_list.c                          | 21 +++---
 kernel/bpf/bpf_lru_list.h                          |  7 +-
 kernel/events/core.c                               | 10 ++-
 kernel/events/uprobes.c                            |  2 +-
 kernel/exit.c                                      |  2 +-
 kernel/futex.c                                     | 12 ++--
 kernel/kexec_core.c                                |  5 +-
 kernel/locking/lockdep.c                           |  6 +-
 kernel/sched/fair.c                                |  2 +-
 kernel/time/posix-timers.c                         | 31 ++++----
 kernel/trace/ring_buffer.c                         | 48 +++++++------
 kernel/trace/trace_events.c                        | 14 ++--
 kernel/watchdog_hld.c                              |  6 +-
 kernel/workqueue.c                                 | 13 ++--
 lib/debugobjects.c                                 |  9 +++
 lib/radix-tree.c                                   |  2 +-
 lib/test_firmware.c                                | 10 +++
 lib/ts_bm.c                                        |  4 +-
 mm/frontswap.c                                     |  2 +-
 mm/ksm.c                                           |  2 +-
 mm/memcontrol.c                                    |  2 +-
 mm/mempolicy.c                                     |  4 +-
 mm/percpu.c                                        |  2 +-
 mm/slub.c                                          |  4 +-
 mm/swap.c                                          |  4 +-
 net/bluetooth/l2cap_sock.c                         |  2 +
 net/bridge/br_if.c                                 |  5 +-
 net/can/bcm.c                                      | 12 ++--
 net/ceph/osd_client.c                              | 20 ++++--
 net/core/rtnetlink.c                               |  8 +--
 net/core/sock.c                                    | 23 ++++--
 net/dccp/options.c                                 |  2 +-
 net/ipv4/netfilter/nf_socket_ipv4.c                |  6 +-
 net/ipv4/tcp.c                                     | 17 ++---
 net/ipv4/tcp_fastopen.c                            |  6 +-
 net/ipv4/tcp_input.c                               | 12 +++-
 net/ipv4/tcp_metrics.c                             | 70 +++++++++++-------
 net/ipv6/addrconf.c                                | 17 +++--
 net/ipv6/ip6_flowlabel.c                           |  2 +-
 net/ipv6/ip6mr.c                                   |  2 +-
 net/ipv6/netfilter/nf_socket_ipv6.c                |  2 +-
 net/ipv6/udp.c                                     |  2 +-
 net/llc/llc_input.c                                |  3 -
 net/netfilter/nf_conntrack_ftp.c                   |  2 +-
 net/netfilter/nf_conntrack_helper.c                |  4 ++
 net/netfilter/nf_conntrack_sip.c                   |  2 +-
 net/netfilter/nf_tables_api.c                      | 32 +++++++--
 net/netfilter/nfnetlink_log.c                      |  2 +-
 net/netfilter/nfnetlink_queue.c                    |  4 +-
 net/netfilter/nft_byteorder.c                      | 14 ++--
 net/netlink/af_netlink.c                           |  5 +-
 net/netlink/diag.c                                 |  7 +-
 net/sched/act_pedit.c                              |  1 +
 net/sched/cls_flow.c                               |  2 +-
 net/sched/cls_fw.c                                 | 10 +--
 net/sched/cls_route.c                              |  1 -
 net/sched/cls_u32.c                                | 22 +++---
 net/sched/sch_cbq.c                                |  2 +-
 net/sched/sch_fq_codel.c                           |  2 +-
 net/sched/sch_qfq.c                                |  7 +-
 net/sched/sch_sfq.c                                |  2 +-
 net/sctp/socket.c                                  |  4 +-
 net/sunrpc/svcsock.c                               | 27 ++++---
 net/unix/af_unix.c                                 |  2 +-
 net/wireless/wext-core.c                           |  6 ++
 scripts/mod/modpost.c                              | 26 +++++--
 scripts/tags.sh                                    |  9 ++-
 security/integrity/evm/evm_main.c                  |  2 +
 security/integrity/iint.c                          | 15 ++--
 sound/core/control_compat.c                        |  2 +-
 sound/isa/sb/sb16_csp.c                            |  2 +-
 sound/pci/ac97/ac97_codec.c                        |  4 +-
 sound/soc/codecs/es8316.c                          |  9 ++-
 sound/soc/codecs/wm8904.c                          |  3 +
 sound/soc/fsl/fsl_spdif.c                          |  2 +
 sound/usb/endpoint.c                               |  2 +-
 .../tests/shell/test_uprobe_from_different_cu.sh   | 83 ++++++++++++++++++++++
 tools/perf/util/dwarf-aux.c                        |  2 +-
 .../perf/util/intel-pt-decoder/intel-pt-decoder.c  |  2 +
 326 files changed, 1531 insertions(+), 867 deletions(-)


