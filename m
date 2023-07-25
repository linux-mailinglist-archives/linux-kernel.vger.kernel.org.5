Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FDBC761617
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 13:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234753AbjGYLgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 07:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234809AbjGYLgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 07:36:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B690D1BF8;
        Tue, 25 Jul 2023 04:36:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 383A3616A4;
        Tue, 25 Jul 2023 11:36:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E97A8C433C8;
        Tue, 25 Jul 2023 11:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690284960;
        bh=QkI/2ci/fVRJYSMDldF2W0POCeU+g1SnpE2CAXltxFM=;
        h=From:To:Cc:Subject:Date:From;
        b=nsPp2nyXkJUJeaLoXuJm2Upl9bcgc97j2UzpjEPlHeDKdl1TR2tztY7kEPVJqwNnN
         0/v3eNju79q3s89pGxhFVuioQzvAvQDr3OFmmQZOAEirMPFRQKflG2DYGRhTv0iAyR
         37K11cRDcgupOb/ITyYVmxQd1RJfuSHn2r86Ypoo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: [PATCH 5.4 000/313] 5.4.251-rc1 review
Date:   Tue, 25 Jul 2023 12:42:33 +0200
Message-ID: <20230725104521.167250627@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.251-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.4.251-rc1
X-KernelTest-Deadline: 2023-07-27T10:45+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 5.4.251 release.
There are 313 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Thu, 27 Jul 2023 10:44:26 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.251-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 5.4.251-rc1

Mohamed Khalfella <mkhalfella@purestorage.com>
    tracing/histograms: Return an error if we fail to add histogram to hist_vars list

Eric Dumazet <edumazet@google.com>
    tcp: annotate data-races around fastopenq.max_qlen

Eric Dumazet <edumazet@google.com>
    tcp: annotate data-races around tp->notsent_lowat

Eric Dumazet <edumazet@google.com>
    tcp: annotate data-races around rskq_defer_accept

Eric Dumazet <edumazet@google.com>
    tcp: annotate data-races around tp->linger2

Cambda Zhu <cambda@linux.alibaba.com>
    net: Replace the limit of TCP_LINGER2 with TCP_FIN_TIMEOUT_MAX

Eric Dumazet <edumazet@google.com>
    tcp: annotate data-races around tp->tcp_tx_delay

Florian Westphal <fw@strlen.de>
    netfilter: nf_tables: can't schedule in nft_chain_validate

Florian Westphal <fw@strlen.de>
    netfilter: nf_tables: fix spurious set element insertion failure

Kuniyuki Iwashima <kuniyu@amazon.com>
    llc: Don't drop packet from non-root netns.

Zhang Shurong <zhang_shurong@foxmail.com>
    fbdev: au1200fb: Fix missing IRQ check in au1200fb_drv_probe

Kuniyuki Iwashima <kuniyu@amazon.com>
    Revert "tcp: avoid the lookup process failing to get sk in ehash table"

Yuanjun Gong <ruc_gongyuanjun@163.com>
    net:ipv6: check return value of pskb_trim()

Ding Hui <dinghui@sangfor.com.cn>
    iavf: Fix use-after-free in free_netdev

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

Johannes Berg <johannes.berg@intel.com>
    wifi: iwlwifi: mvm: avoid baid size integer overflow

Gustavo A. R. Silva <gustavoars@kernel.org>
    wifi: wext-core: Fix -Wstringop-overflow warning in ioctl_standard_iw_point()

Petr Oros <poros@redhat.com>
    devlink: report devlink_port_type_warn source device

Martin KaFai Lau <martin.lau@kernel.org>
    bpf: Address KCSAN report on bpf_lru_list

Yicong Yang <yangyicong@hisilicon.com>
    sched/fair: Don't balance task to its current running CPU

Mark Rutland <mark.rutland@arm.com>
    arm64: mm: fix VA-range sanity check

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

Jocelyn Falempe <jfalempe@redhat.com>
    drm/client: Fix memory leak in drm_client_modeset_probe

Jocelyn Falempe <jfalempe@redhat.com>
    drm/client: Fix memory leak in drm_client_target_cloned

YueHaibing <yuehaibing@huawei.com>
    can: bcm: Fix UAF in bcm_proc_show()

Matthieu Baerts <matthieu.baerts@tessares.net>
    selftests: tc: set timeout to 15 minutes

Miklos Szeredi <mszeredi@redhat.com>
    fuse: revalidate: don't invalidate if interrupted

Filipe Manana <fdmanana@suse.com>
    btrfs: fix warning when putting transaction with qgroups enabled after abort

Georg Müller <georgmueller@gmx.net>
    perf probe: Add test for regression introduced by switch to die_get_decl_file()

Daniel Vetter <daniel.vetter@ffwll.ch>
    drm/atomic: Fix potential use-after-free in nonblocking commits

Manish Rangankar <mrangankar@marvell.com>
    scsi: qla2xxx: Remove unused nvme_ls_waitq wait queue

Shreyas Deodhar <sdeodhar@marvell.com>
    scsi: qla2xxx: Pointer may be dereferenced

Bikash Hazarika <bhazarika@marvell.com>
    scsi: qla2xxx: Correct the index of array

Nilesh Javali <njavali@marvell.com>
    scsi: qla2xxx: Check valid rport returned by fc_bsg_to_rport()

Bikash Hazarika <bhazarika@marvell.com>
    scsi: qla2xxx: Fix potential NULL pointer dereference

Quinn Tran <qutran@marvell.com>
    scsi: qla2xxx: Wait for io return on terminate rport

Masami Hiramatsu (Google) <mhiramat@kernel.org>
    tracing/probes: Fix not to count error code to total length

Mateusz Stachyra <m.stachyra@samsung.com>
    tracing: Fix null pointer dereference in tracing_err_log_open()

Max Filippov <jcmvbkbc@gmail.com>
    xtensa: ISS: fix call to split_if_spec

Zheng Yejian <zhengyejian1@huawei.com>
    ring-buffer: Fix deadloop issue on reading trace_pipe

Mohamed Khalfella <mkhalfella@purestorage.com>
    tracing/histograms: Add histograms to hist_vars if they have referenced variables

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    tty: serial: samsung_tty: Fix a memory leak in s3c24xx_serial_getclk() when iterating clk

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    tty: serial: samsung_tty: Fix a memory leak in s3c24xx_serial_getclk() in case of error

Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
    Revert "8250: add support for ASIX devices with a FIFO bug"

George Stark <gnstark@sberdevices.ru>
    meson saradc: fix clock divider mask length

Xiubo Li <xiubli@redhat.com>
    ceph: don't let check_caps skip sending responses for revoke msgs

Martin Kaiser <martin@kaiser.cx>
    hwrng: imx-rngc - fix the timeout for init and self check

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    firmware: stratix10-svc: Fix a potential resource leak in svc_create_memory_pool()

Dan Carpenter <dan.carpenter@linaro.org>
    serial: atmel: don't enable IRQs prematurely

Brian Norris <briannorris@chromium.org>
    drm/rockchip: vop: Leave vblank enabled in self-refresh

Brian Norris <briannorris@chromium.org>
    drm/atomic: Allow vblank-enabled + self-refresh "disable"

Alexander Aring <aahringo@redhat.com>
    fs: dlm: return positive pid value for F_GETLK

Jason Baron <jbaron@akamai.com>
    md/raid0: add discard support for the 'original' layout

Damien Le Moal <dlemoal@kernel.org>
    misc: pci_endpoint_test: Re-init completion for every test

Damien Le Moal <dlemoal@kernel.org>
    misc: pci_endpoint_test: Free IRQs before removing the device

Damien Le Moal <dlemoal@kernel.org>
    PCI: rockchip: Set address alignment for endpoint mode

Rick Wertenbroek <rick.wertenbroek@gmail.com>
    PCI: rockchip: Use u32 variable to access 32-bit registers

Rick Wertenbroek <rick.wertenbroek@gmail.com>
    PCI: rockchip: Fix legacy IRQ generation for RK3399 PCIe endpoint core

Rick Wertenbroek <rick.wertenbroek@gmail.com>
    PCI: rockchip: Add poll and timeout to wait for PHY PLLs to be locked

Rick Wertenbroek <rick.wertenbroek@gmail.com>
    PCI: rockchip: Write PCI Device ID to correct register

Rick Wertenbroek <rick.wertenbroek@gmail.com>
    PCI: rockchip: Assert PCI Configuration Enable bit after probe

Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
    PCI: qcom: Disable write access to read only registers for IP v2.3.3

Robin Murphy <robin.murphy@arm.com>
    PCI: Add function 1 DMA alias quirk for Marvell 88SE9235

Ondrej Zary <linux@zary.sk>
    PCI/PM: Avoid putting EloPOS E2/S2/H2 PCIe Ports in D3cold

Siddh Raman Pant <code@siddh.me>
    jfs: jfs_dmap: Validate db_l2nbperpage while mounting

Baokun Li <libaokun1@huawei.com>
    ext4: only update i_reserved_data_blocks on successful block allocation

Chao Yu <chao@kernel.org>
    ext4: fix to check return value of freeze_bdev() in ext4_shutdown()

Kemeng Shi <shikemeng@huaweicloud.com>
    ext4: fix wrong unit use in ext4_mb_clear_bb

Gao Xiang <hsiangkao@linux.alibaba.com>
    erofs: fix compact 4B support for 16k block size

Ding Hui <dinghui@sangfor.com.cn>
    SUNRPC: Fix UAF in svc_tcp_listen_data_ready()

Ekansh Gupta <quic_ekangupt@quicinc.com>
    misc: fastrpc: Create fastrpc scalar with correct buffer count

Naveen N Rao <naveen@kernel.org>
    powerpc: Fail build if using recordmcount with binutils v2.37

Florian Fainelli <florian.fainelli@broadcom.com>
    net: bcmgenet: Ensure MDIO unregistration has clocks enabled

Arseniy Krasnov <AVKrasnov@sberdevices.ru>
    mtd: rawnand: meson: fix unaligned DMA buffers handling

Jarkko Sakkinen <jarkko.sakkinen@tuni.fi>
    tpm: tpm_vtpm_proxy: fix a race condition in /dev/vtpmx creation

Mario Limonciello <mario.limonciello@amd.com>
    pinctrl: amd: Only use special debounce behavior for GPIO 0

Mario Limonciello <mario.limonciello@amd.com>
    pinctrl: amd: Detect internal GPIO0 debounce handling

Mario Limonciello <mario.limonciello@amd.com>
    pinctrl: amd: Fix mistake in handling clearing pins at startup

Pedro Tammela <pctammela@mojatatu.com>
    net/sched: make psched_mtu() RTNL-less safe

Ido Schimmel <idosch@nvidia.com>
    net/sched: flower: Ensure both minimum and maximum ports are specified

Guillaume Nault <gnault@redhat.com>
    cls_flower: Add extack support for src and dst port range options

Randy Dunlap <rdunlap@infradead.org>
    wifi: airo: avoid uninitialized warning in airo_get_rate()

Chunhai Guo <guochunhai@vivo.com>
    erofs: avoid infinite loop in z_erofs_do_read_page() when reading beyond EOF

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    platform/x86: wmi: Break possible infinite loop when parsing GUID

Barnabás Pőcze <pobrn@protonmail.com>
    platform/x86: wmi: move variables

Barnabás Pőcze <pobrn@protonmail.com>
    platform/x86: wmi: use guid_t and guid_equal()

Barnabás Pőcze <pobrn@protonmail.com>
    platform/x86: wmi: remove unnecessary argument

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    platform/x86: wmi: Fix indentation in some cases

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    platform/x86: wmi: Replace UUID redefinitions by their originals

Ziyang Xuan <william.xuanziyang@huawei.com>
    ipv6/addrconf: fix a potential refcount underflow for idev

Jiasheng Jiang <jiasheng@iscas.ac.cn>
    NTB: ntb_tool: Add check for devm_kcalloc

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

Kuniyuki Iwashima <kuniyu@amazon.com>
    icmp6: Fix null-ptr-deref of ip6_null_entry->rt6i_idev in icmp6_dev().

Nitya Sunkad <nitya.sunkad@amd.com>
    ionic: remove WARN_ON to prevent panic_on_warn

Shannon Nelson <snelson@pensando.io>
    ionic: ionic_intr_free parameter change

Shannon Nelson <snelson@pensando.io>
    ionic: move irq request to qcq alloc

Shannon Nelson <snelson@pensando.io>
    ionic: clean irq affinity on queue deinit

Shannon Nelson <snelson@pensando.io>
    ionic: improve irq numa locality

M A Ramdhan <ramdhan@starlabs.sg>
    net/sched: cls_fw: Fix improper refcount update leads to use-after-free

Klaus Kudielka <klaus.kudielka@gmail.com>
    net: mvneta: fix txq_map in case of txq_number==1

Dan Carpenter <dan.carpenter@linaro.org>
    scsi: qla2xxx: Fix error code in qla2x00_start_sp()

Prasad Koya <prasad@arista.com>
    igc: set TP bit in 'supported' and 'advertising' fields of ethtool_link_ksettings

Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
    igc: Remove delay during TX ring configuration

Fabio Estevam <festevam@denx.de>
    drm/panel: simple: Add connector_type for innolux_at043tn24

Laurent Pinchart <laurent.pinchart@ideasonboard.com>
    drm/panel: Add and fill drm_panel type field

Laurent Pinchart <laurent.pinchart@ideasonboard.com>
    drm/panel: Initialise panel dev and funcs through drm_panel_init()

Linus Torvalds <torvalds@linux-foundation.org>
    workqueue: clean up WORK_* constant types, clarify masking

Moritz Fischer <moritzf@google.com>
    net: lan743x: Don't sleep in atomic context

Michael Schmitz <schmitzmic@gmail.com>
    block/partition: fix signedness issue for Amiga partitions

Sherry Sun <sherry.sun@nxp.com>
    tty: serial: fsl_lpuart: add earlycon for imx8ulp platform

Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
    netfilter: nf_tables: prevent OOB access in nft_byteorder_eval

Florent Revest <revest@chromium.org>
    netfilter: conntrack: Avoid nf_ct_helper_hash uses after free

Florian Westphal <fw@strlen.de>
    netfilter: nf_tables: fix scheduling-while-atomic splat

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: unbind non-anonymous set if rule construction fails

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: reject unbound anonymous set before commit phase

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: add NFT_TRANS_PREPARE_ERROR to deal with bound set/chain

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: incorrect error path handling with NFT_MSG_NEWRULE

Florian Westphal <fw@strlen.de>
    netfilter: nf_tables: add rescheduling points during loop detection walks

Florian Westphal <fw@strlen.de>
    netfilter: nf_tables: use net_generic infra for transaction data

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: add helper function to set up the nfnetlink header and use it

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nftables: add helper function to set the base sequence number

Florian Westphal <fw@strlen.de>
    netfilter: nf_tables: fix nat hook table deletion

Michael Schmitz <schmitzmic@gmail.com>
    block: add overflow checks for Amiga partition support

Amir Goldstein <amir73il@gmail.com>
    fanotify: disallow mount/sb marks on kernel internal pseudo fs

Jan Kara <jack@suse.cz>
    fs: no need to check source

Arnd Bergmann <arnd@arndb.de>
    ARM: orion5x: fix d2net gpio initialization

Filipe Manana <fdmanana@suse.com>
    btrfs: fix race when deleting quota root from the dirty cow roots list

Jan Kara <jack@suse.cz>
    fs: Lock moved directories

Jan Kara <jack@suse.cz>
    fs: Establish locking order for unrelated directories

Jan Kara <jack@suse.cz>
    Revert "f2fs: fix potential corruption when moving a directory"

Jan Kara <jack@suse.cz>
    ext4: Remove ext4 locking of moved directory

Thomas Weißschuh <linux@weissschuh.net>
    fs: avoid empty option when generating legacy mount string

Fabian Frederick <fabf@skynet.be>
    jffs2: reduce stack usage in jffs2_build_xattr_subsystem()

Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
    integrity: Fix possible multiple allocation in integrity_inode_get()

Zheng Wang <zyytlz.wz@163.com>
    bcache: Remove unnecessary NULL point check in node allocations

Chevron Li <chevron.li@bayhubtech.com>
    mmc: sdhci: fix DMA configure compatibility issue when 64bit DMA mode is used.

Robert Marko <robimarko@gmail.com>
    mmc: core: disable TRIM on Micron MTFC4GACAJCN-1M

Robert Marko <robimarko@gmail.com>
    mmc: core: disable TRIM on Kingston EMMC04G-M627

Dai Ngo <dai.ngo@oracle.com>
    NFSD: add encoding of op_recall flag for write delegation

Takashi Iwai <tiwai@suse.de>
    ALSA: jack: Fix mutex call in snd_jack_report()

Robert Hancock <robert.hancock@calian.com>
    i2c: xiic: Don't try to handle more interrupt events after error

Marek Vasut <marex@denx.de>
    i2c: xiic: Defer xiic_wakeup() and __xiic_start_xfer() in xiic_process()

Artur Rojek <contact@artur-rojek.eu>
    sh: dma: Fix DMA channel offset calculation

Vladimir Oltean <vladimir.oltean@nxp.com>
    net: dsa: tag_sja1105: fix MAC DA patching from meta frames

Lin Ma <linma@zju.edu.cn>
    net/sched: act_pedit: Add size check for TCA_PEDIT_PARMS_EX

Ilya Maximets <i.maximets@ovn.org>
    xsk: Honor SO_BINDTODEVICE on bind

Magnus Karlsson <magnus.karlsson@intel.com>
    xsk: Improve documentation for AF_XDP

Eric Dumazet <edumazet@google.com>
    tcp: annotate data races in __tcp_oow_rate_limited()

Vladimir Oltean <vladimir.oltean@nxp.com>
    net: bridge: keep ports without IFF_UNICAST_FLT in BR_PROMISC mode

Randy Dunlap <rdunlap@infradead.org>
    powerpc: allow PPC_EARLY_DEBUG_CPM only when SERIAL_CPM=y

Chao Yu <chao@kernel.org>
    f2fs: fix error path handling in truncate_dnode()

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

Marek Vasut <marex@denx.de>
    pwm: sysfs: Do not apply state to already disabled PWMs

Fancy Fang <chen.fang@nxp.com>
    pwm: imx-tpm: force 'real_period' to be zero in suspend

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    mfd: stmpe: Only disable the regulators if they are enabled

Pierre Morel <pmorel@linux.ibm.com>
    KVM: s390: vsie: fix the length of APCB bitmap

Amelie Delaunay <amelie.delaunay@foss.st.com>
    mfd: stmfx: Fix error path in stmfx_chip_init

Tony Lindgren <tony@atomide.com>
    serial: 8250_omap: Use force_suspend and resume for system suspend

Jiasheng Jiang <jiasheng@iscas.ac.cn>
    mfd: intel-lpss: Add missing check for platform_get_resource

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    usb: dwc3: qcom: Release the correct resources in dwc3_qcom_remove()

Nico Boehr <nrb@linux.ibm.com>
    KVM: s390: fix KVM_S390_GET_CMMA_BITS for GFNs in memslot holes

Stephan Gerhold <stephan@gerhold.net>
    mfd: rt5033: Drop rt5033-battery sub-device

Arnd Bergmann <arnd@arndb.de>
    usb: hide unused usbfs_notify_suspend/resume functions

Li Yang <lidaxian@hust.edu.cn>
    usb: phy: phy-tahvo: fix memory leak in tahvo_usb_probe()

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    extcon: Fix kernel doc of property capability fields to avoid warnings

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    extcon: Fix kernel doc of property fields to avoid warnings

Vladislav Efanov <VEfanov@ispras.ru>
    usb: dwc3: qcom: Fix potential memory leak

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

Michael Schmitz <schmitzmic@gmail.com>
    block: fix signed int overflow in Amiga partition support

Krishna Kurapati <quic_kriskura@quicinc.com>
    usb: dwc3: gadget: Propagate core init errors to UDC during pullup

Davide Tronchin <davide.tronchin.94@gmail.com>
    USB: serial: option: add LARA-R6 01B PIDs

Martin Kaiser <martin@kaiser.cx>
    hwrng: st - keep clock enabled while hwrng is registered

Herbert Xu <herbert@gondor.apana.org.au>
    hwrng: st - Fix W=1 unused variable warning

Olga Kornievskaia <kolga@netapp.com>
    NFSv4.1: freeze the session table upon receiving NFS4ERR_BADSESSION

Masahiro Yamada <masahiroy@kernel.org>
    ARC: define ASM_NL and __ALIGN(_STR) outside #ifdef __ASSEMBLY__ guard

Dan Carpenter <dan.carpenter@linaro.org>
    modpost: fix off by one in is_executable_section()

Arnd Bergmann <arnd@arndb.de>
    crypto: marvell/cesa - Fix type mismatch warning

Eric Biggers <ebiggers@google.com>
    crypto: skcipher - remove crypto_has_ablkcipher()

Eric Biggers <ebiggers@google.com>
    crypto: skcipher - unify the crypto_has_skcipher*() functions

Masahiro Yamada <masahiroy@kernel.org>
    modpost: fix section mismatch message for R_ARM_{PC24,CALL,JUMP24}

Masahiro Yamada <masahiroy@kernel.org>
    modpost: fix section mismatch message for R_ARM_ABS32

Randy Dunlap <rdunlap@infradead.org>
    crypto: nx - fix build warnings when DEBUG_FS is not enabled

Herbert Xu <herbert@gondor.apana.org.au>
    hwrng: virtio - Fix race on data_avail and actual data

Laurent Vivier <lvivier@redhat.com>
    hwrng: virtio - always add a pending request

Laurent Vivier <lvivier@redhat.com>
    hwrng: virtio - don't waste entropy

Laurent Vivier <lvivier@redhat.com>
    hwrng: virtio - don't wait on cleanup

Laurent Vivier <lvivier@redhat.com>
    hwrng: virtio - add an internal buffer

Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
    powerpc/mm/dax: Fix the condition when checking if altmap vmemap can cross-boundary

Claudiu Beznea <claudiu.beznea@microchip.com>
    pinctrl: at91-pio4: check return value of devm_kasprintf()

Namhyung Kim <namhyung@kernel.org>
    perf dwarf-aux: Fix off-by-one in die_get_varname()

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    pinctrl: cherryview: Return correct value if pin in push-pull mode

Sui Jingfeng <suijingfeng@loongson.cn>
    PCI: Add pci_clear_master() stub for non-CONFIG_PCI

Junyan Ye <yejunyan@hust.edu.cn>
    PCI: ftpci100: Release the clock resources

Rongguang Wei <weirongguang@kylinos.cn>
    PCI: pciehp: Cancel bringup sequence if card is not present

Yuchen Yang <u202114568@hust.edu.cn>
    scsi: 3w-xxxx: Add error handling for initialization failure in tw_probe()

Ding Hui <dinghui@sangfor.com.cn>
    PCI/ASPM: Disable ASPM on MFD function removal to avoid use-after-free

Jinhong Zhu <jinhongzhu@hust.edu.cn>
    scsi: qedf: Fix NULL dereference in error handling

Claudiu Beznea <claudiu.beznea@microchip.com>
    ASoC: imx-audmix: check return value of devm_kasprintf()

Claudiu Beznea <claudiu.beznea@microchip.com>
    clk: keystone: sci-clk: check return value of kasprintf()

Claudiu Beznea <claudiu.beznea@microchip.com>
    clk: cdce925: check return value of kasprintf()

Su Hui <suhui@nfschina.com>
    ALSA: ac97: Fix possible NULL dereference in snd_ac97_mixer

Yuan Can <yuancan@huawei.com>
    clk: tegra: tegra124-emc: Fix potential memory leak

Nikita Zhandarovich <n.zhandarovich@fintech.ru>
    drm/radeon: fix possible division-by-zero errors

Daniil Dulov <d.dulov@aladdin.ru>
    drm/amdkfd: Fix potential deallocation of previously deallocated memory.

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    fbdev: omapfb: lcd_mipid: Fix an error handling path in mipid_spi_probe()

Wolfram Sang <wsa+renesas@sang-engineering.com>
    arm64: dts: renesas: ulcb-kf: Remove flow control for SCIF1

Patrick Kelsey <pat.kelsey@cornelisnetworks.com>
    IB/hfi1: Fix sdma.h tx->num_descs off-by-one errors

Randy Dunlap <rdunlap@infradead.org>
    soc/fsl/qe: fix usb.c build errors

Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
    ASoC: es8316: Do not set rate constraints for unsupported MCLKs

Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
    ASoC: es8316: Increment max value for ALC Capture Target Volume control

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    memory: brcmstb_dpfe: fix testing array offset after use

Arnd Bergmann <arnd@arndb.de>
    ARM: ep93xx: fix missing-prototype warnings

Dario Binacchi <dario.binacchi@amarulasolutions.com>
    drm/panel: simple: fix active size for Ampire AM-480272H3TMQW-T01H

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    arm64: dts: qcom: msm8916: correct camss unit address

Tony Lindgren <tony@atomide.com>
    ARM: dts: gta04: Move model property out of pinctrl node

Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
    RDMA/bnxt_re: Fix to remove an unnecessary log

XuDong Liu <m202071377@hust.edu.cn>
    drm: sun4i_tcon: use devm_clk_get_enabled in `sun4i_tcon_init_clocks`

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

Cambda Zhu <cambda@linux.alibaba.com>
    ipvlan: Fix return value of ipvlan_queue_xmit()

Ilia.Gavrilov <Ilia.Gavrilov@infotecs.ru>
    netfilter: nf_conntrack_sip: fix the ct_sip_parse_numerical_param() return value.

Florian Westphal <fw@strlen.de>
    netfilter: conntrack: dccp: copy entire header to stack buffer, not just basic one

Jeremy Sowden <jeremy@azazel.net>
    lib/ts_bm: reset initial match offset for every block of text

Lin Ma <linma@zju.edu.cn>
    net: nfc: Fix use-after-free caused by nfc_llcp_find_local

Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
    nfc: llcp: simplify llcp_sock_connect() error paths

Kuniyuki Iwashima <kuniyu@amazon.com>
    gtp: Fix use-after-free in __gtp_encap_destroy().

Sabrina Dubroca <sd@queasysnail.net>
    selftests: rtnetlink: remove netdevsim device after ipsec offload test

Eric Dumazet <edumazet@google.com>
    netlink: do not hard code device address lenth in fdb dumps

Eric Dumazet <edumazet@google.com>
    netlink: fix potential deadlock in netlink_set_err()

Dmitry Antipov <dmantipov@yandex.ru>
    wifi: ath9k: convert msecs to jiffies where needed

Benjamin Berg <benjamin.berg@intel.com>
    wifi: cfg80211: rewrite merging of inherited elements

Johannes Berg <johannes.berg@intel.com>
    wifi: iwlwifi: pull from TXQs with softirqs disabled

Edwin Peer <edwin.peer@broadcom.com>
    rtnetlink: extend RTEXT_FILTER_SKIP_STATS to IFLA_VF_INFO

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

Marek Vasut <marex@denx.de>
    wifi: rsi: Do not set MMC_PM_KEEP_POWER in shutdown

Fedor Pchelkin <pchelkin@ispras.ru>
    wifi: ath9k: don't allow to overwrite ENDPOINT0 attributes

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    wifi: ray_cs: Fix an error handling path in ray_probe()

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    wifi: ray_cs: Drop useless status variable in parse_addr()

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    wifi: ray_cs: Utilize strnlen() in parse_addr()

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    wifi: wl3501_cs: Fix an error handling path in wl3501_probe()

Jakub Kicinski <kuba@kernel.org>
    wl3501_cs: use eth_hw_addr_set()

Jakub Kicinski <kuba@kernel.org>
    net: create netdev->dev_addr assignment helpers

Lee Jones <lee.jones@linaro.org>
    wl3501_cs: Fix misspelling and provide missing documentation

Alex Dewar <alex.dewar90@gmail.com>
    wl3501_cs: Remove unnecessary NULL check

Lee Jones <lee.jones@linaro.org>
    wl3501_cs: Fix a bunch of formatting issues related to function docs

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    wifi: atmel: Fix an error handling path in atmel_probe()

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    wifi: orinoco: Fix an error handling path in orinoco_cs_probe()

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    wifi: orinoco: Fix an error handling path in spectrum_cs_probe()

Geert Uytterhoeven <geert+renesas@glider.be>
    regulator: core: Streamline debugfs operations

Geert Uytterhoeven <geert+renesas@glider.be>
    regulator: core: Fix more error checking for debugfs_create_dir()

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    nfc: llcp: fix possible use of uninitialized variable in nfc_llcp_send_connect()

Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
    nfc: constify several pointers to u8, char and sk_buff

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    wifi: mwifiex: Fix the size of a memory allocation in mwifiex_ret_802_11_scan()

Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
    spi: spi-geni-qcom: Correct CS_TOGGLE bit in SPI_TRANS_CFG

Pengcheng Yang <yangpc@wangsu.com>
    samples/bpf: Fix buffer overflow in tcp_basertt

Fedor Pchelkin <pchelkin@ispras.ru>
    wifi: ath9k: avoid referencing uninit memory in ath9k_wmi_ctrl_rx

Peter Seiderer <ps.report@gmx.net>
    wifi: ath9k: fix AR9003 mac hardware hang check register offset calculation

Roberto Sassu <roberto.sassu@huawei.com>
    ima: Fix build warnings

Jiasheng Jiang <jiasheng@iscas.ac.cn>
    pstore/ram: Add check for kstrdup

Roberto Sassu <roberto.sassu@huawei.com>
    evm: Complete description of evm_inode_setattr()

Arnd Bergmann <arnd@arndb.de>
    ARM: 9303/1: kprobes: avoid missing-declaration warnings

Zhang Rui <rui.zhang@intel.com>
    powercap: RAPL: Fix CONFIG_IOSF_MBI dependency

Nikita Zhandarovich <n.zhandarovich@fintech.ru>
    PM: domains: fix integer overflow issues in genpd_parse_state()

Feng Mingxi <m202271825@hust.edu.cn>
    clocksource/drivers/cadence-ttc: Fix memory leak in ttc_timer_probe

Rajan Vaja <rajan.vaja@xilinx.com>
    clocksource/drivers/cadence-ttc: Use ttc driver as platform driver

Sebastian Andrzej Siewior <bigeasy@linutronix.de>
    tracing/timer: Add missing hrtimer modes to decode_hrtimer_mode().

John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
    irqchip/jcore-aic: Fix missing allocation of IRQ descriptors

Marc Zyngier <maz@kernel.org>
    irqchip/jcore-aic: Kill use of irq_create_strict_mappings()

Li Nan <linan122@huawei.com>
    md/raid10: fix io loss while replacement replace rdev

Li Nan <linan122@huawei.com>
    md/raid10: fix null-ptr-deref of mreplace in raid10_sync_request

Li Nan <linan122@huawei.com>
    md/raid10: fix wrong setting of max_corr_read_errors

Li Nan <linan122@huawei.com>
    md/raid10: fix overflow of md/safe_mode_delay

Li Nan <linan122@huawei.com>
    md/raid10: check slab-out-of-bounds in md_bitmap_get_counter

Shawn Wang <shawnwang@linux.alibaba.com>
    x86/resctrl: Only show tasks' pid in current pid namespace

James Morse <james.morse@arm.com>
    x86/resctrl: Use is_closid_match() in more places

Rafał Miłecki <rafal@milecki.pl>
    bgmac: fix *initial* chip reset to support BCM5358

Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
    drm/amdgpu: Validate VM ioctl flags.

Ahmed S. Darwish <darwi@linutronix.de>
    scripts/tags.sh: Resolve gtags empty index generation

Chris Wilson <chris@chris-wilson.co.uk>
    drm/i915: Initialise outparam for error return from wait_for_register

Jason Gerecke <jason.gerecke@wacom.com>
    HID: wacom: Use ktime_t rather than int when dealing with timestamps

Zheng Wang <zyytlz.wz@163.com>
    fbdev: imsttfb: Fix use after free bug in imsttfb_probe

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    video: imsttfb: check for ioremap() failures

Thomas Gleixner <tglx@linutronix.de>
    x86/smp: Use dedicated cache-line for mwait_play_dead()

Bob Peterson <rpeterso@redhat.com>
    gfs2: Don't deref jdesc in evict


-------------

Diffstat:

 Documentation/crypto/api-skcipher.rst              |   2 +-
 Documentation/filesystems/directory-locking.rst    |  26 +-
 Documentation/networking/af_xdp.rst                | 268 +++++++++--
 Makefile                                           |   4 +-
 arch/arc/include/asm/linkage.h                     |   8 +-
 arch/arm/boot/dts/bcm5301x.dtsi                    |   1 -
 arch/arm/boot/dts/omap3-gta04a5one.dts             |   4 +-
 arch/arm/mach-ep93xx/timer-ep93xx.c                |   3 +-
 arch/arm/mach-orion5x/board-dt.c                   |   3 +
 arch/arm/mach-orion5x/common.h                     |   6 +
 arch/arm/probes/kprobes/checkers-common.c          |   2 +-
 arch/arm/probes/kprobes/core.c                     |   2 +-
 arch/arm/probes/kprobes/opt-arm.c                  |   2 -
 arch/arm/probes/kprobes/test-core.c                |   2 +-
 arch/arm/probes/kprobes/test-core.h                |   4 +
 arch/arm64/boot/dts/qcom/msm8916.dtsi              |   2 +-
 arch/arm64/boot/dts/renesas/ulcb-kf.dtsi           |   3 +-
 arch/arm64/mm/mmu.c                                |   4 +-
 arch/powerpc/Kconfig.debug                         |   2 +-
 arch/powerpc/Makefile                              |   8 +
 arch/powerpc/mm/init_64.c                          |   2 +-
 arch/s390/kvm/kvm-s390.c                           |   4 +
 arch/s390/kvm/vsie.c                               |   6 +-
 arch/sh/drivers/dma/dma-sh.c                       |  37 +-
 arch/sh/kernel/cpu/sh2/probe.c                     |   2 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c             |  36 +-
 arch/x86/kernel/smpboot.c                          |  24 +-
 arch/xtensa/platforms/iss/network.c                |   2 +-
 block/partitions/amiga.c                           | 104 ++++-
 crypto/skcipher.c                                  |   4 +-
 drivers/base/power/domain.c                        |   6 +-
 drivers/block/nbd.c                                |   3 +-
 drivers/char/hw_random/imx-rngc.c                  |   6 +-
 drivers/char/hw_random/st-rng.c                    |  24 +-
 drivers/char/hw_random/virtio-rng.c                |  86 +++-
 drivers/char/tpm/tpm_vtpm_proxy.c                  |  30 +-
 drivers/clk/clk-cdce925.c                          |  12 +
 drivers/clk/keystone/sci-clk.c                     |   2 +
 drivers/clk/tegra/clk-emc.c                        |   2 +
 drivers/clocksource/timer-cadence-ttc.c            |  45 +-
 drivers/crypto/marvell/cipher.c                    |   2 +-
 drivers/crypto/nx/Makefile                         |   2 +-
 drivers/crypto/nx/nx.h                             |   4 +-
 drivers/extcon/extcon.c                            |   8 +
 drivers/firmware/stratix10-svc.c                   |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             |   4 +
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c    |  13 +-
 drivers/gpu/drm/drm_atomic.c                       |  11 +-
 drivers/gpu/drm/drm_atomic_helper.c                |  11 +-
 drivers/gpu/drm/drm_client_modeset.c               |   6 +
 drivers/gpu/drm/drm_panel.c                        |  14 +-
 drivers/gpu/drm/i915/intel_uncore.c                |   3 +-
 drivers/gpu/drm/panel/panel-arm-versatile.c        |   5 +-
 .../gpu/drm/panel/panel-feiyang-fy07024di26a30d.c  |   5 +-
 drivers/gpu/drm/panel/panel-ilitek-ili9322.c       |   5 +-
 drivers/gpu/drm/panel/panel-ilitek-ili9881c.c      |   5 +-
 drivers/gpu/drm/panel/panel-innolux-p079zca.c      |   5 +-
 drivers/gpu/drm/panel/panel-jdi-lt070me05000.c     |   5 +-
 drivers/gpu/drm/panel/panel-kingdisplay-kd097d04.c |   5 +-
 drivers/gpu/drm/panel/panel-lg-lb035q02.c          |   5 +-
 drivers/gpu/drm/panel/panel-lg-lg4573.c            |   5 +-
 drivers/gpu/drm/panel/panel-lvds.c                 |   5 +-
 drivers/gpu/drm/panel/panel-nec-nl8048hl11.c       |   5 +-
 drivers/gpu/drm/panel/panel-novatek-nt39016.c      |   5 +-
 drivers/gpu/drm/panel/panel-olimex-lcd-olinuxino.c |   5 +-
 drivers/gpu/drm/panel/panel-orisetech-otm8009a.c   |   5 +-
 drivers/gpu/drm/panel/panel-osd-osd101t2587-53ts.c |   5 +-
 .../gpu/drm/panel/panel-panasonic-vvx10f034n00.c   |   5 +-
 .../gpu/drm/panel/panel-raspberrypi-touchscreen.c  |   5 +-
 drivers/gpu/drm/panel/panel-raydium-rm67191.c      |   5 +-
 drivers/gpu/drm/panel/panel-raydium-rm68200.c      |   5 +-
 drivers/gpu/drm/panel/panel-rocktech-jh057n00900.c |   5 +-
 drivers/gpu/drm/panel/panel-ronbo-rb070d30.c       |   5 +-
 drivers/gpu/drm/panel/panel-samsung-ld9040.c       |   5 +-
 drivers/gpu/drm/panel/panel-samsung-s6d16d0.c      |   5 +-
 drivers/gpu/drm/panel/panel-samsung-s6e3ha2.c      |   5 +-
 drivers/gpu/drm/panel/panel-samsung-s6e63j0x03.c   |   5 +-
 drivers/gpu/drm/panel/panel-samsung-s6e63m0.c      |   5 +-
 drivers/gpu/drm/panel/panel-samsung-s6e8aa0.c      |   5 +-
 drivers/gpu/drm/panel/panel-seiko-43wvf1g.c        |   5 +-
 drivers/gpu/drm/panel/panel-sharp-lq101r1sx01.c    |   5 +-
 drivers/gpu/drm/panel/panel-sharp-ls037v7dw01.c    |   5 +-
 drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c    |   5 +-
 drivers/gpu/drm/panel/panel-simple.c               |  33 +-
 drivers/gpu/drm/panel/panel-sitronix-st7701.c      |   5 +-
 drivers/gpu/drm/panel/panel-sitronix-st7789v.c     |   5 +-
 drivers/gpu/drm/panel/panel-sony-acx565akm.c       |   5 +-
 drivers/gpu/drm/panel/panel-tpo-td028ttec1.c       |   5 +-
 drivers/gpu/drm/panel/panel-tpo-td043mtea1.c       |   5 +-
 drivers/gpu/drm/panel/panel-tpo-tpg110.c           |   5 +-
 drivers/gpu/drm/panel/panel-truly-nt35597.c        |   5 +-
 drivers/gpu/drm/radeon/ci_dpm.c                    |  28 +-
 drivers/gpu/drm/radeon/cypress_dpm.c               |   8 +-
 drivers/gpu/drm/radeon/ni_dpm.c                    |   8 +-
 drivers/gpu/drm/radeon/rv740_dpm.c                 |   8 +-
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c        |   8 +-
 drivers/gpu/drm/sun4i/sun4i_tcon.c                 |  19 +-
 drivers/hid/wacom_wac.c                            |   6 +-
 drivers/hid/wacom_wac.h                            |   2 +-
 drivers/i2c/busses/i2c-xiic.c                      |  39 +-
 drivers/iio/adc/meson_saradc.c                     |   2 +-
 drivers/infiniband/hw/bnxt_re/qplib_fp.c           |   5 +-
 drivers/infiniband/hw/hfi1/sdma.c                  |   4 +-
 drivers/infiniband/hw/hfi1/sdma.h                  |  15 +-
 drivers/input/misc/adxl34x.c                       |   3 +-
 drivers/input/misc/drv260x.c                       |   1 +
 drivers/irqchip/irq-jcore-aic.c                    |  11 +-
 drivers/mailbox/ti-msgmgr.c                        |  12 +-
 drivers/md/bcache/btree.c                          |  10 +-
 drivers/md/bcache/super.c                          |   4 +-
 drivers/md/md-bitmap.c                             |  17 +-
 drivers/md/md.c                                    |  23 +-
 drivers/md/raid0.c                                 |  62 ++-
 drivers/md/raid0.h                                 |   1 +
 drivers/md/raid10.c                                |  38 +-
 drivers/media/usb/dvb-usb-v2/az6007.c              |   3 +-
 drivers/media/usb/siano/smsusb.c                   |   3 +-
 drivers/memory/brcmstb_dpfe.c                      |   4 +-
 drivers/memstick/host/r592.c                       |   4 +-
 drivers/mfd/intel-lpss-acpi.c                      |   3 +
 drivers/mfd/rt5033.c                               |   3 -
 drivers/mfd/stmfx.c                                |   2 +-
 drivers/mfd/stmpe.c                                |   4 +-
 drivers/misc/fastrpc.c                             |   2 +-
 drivers/misc/pci_endpoint_test.c                   |  10 +-
 drivers/mmc/core/quirks.h                          |  14 +
 drivers/mmc/host/sdhci.c                           |   4 +-
 drivers/mtd/nand/raw/meson_nand.c                  |   4 +
 drivers/net/ethernet/broadcom/bgmac.c              |   8 +-
 drivers/net/ethernet/broadcom/bgmac.h              |   2 +
 drivers/net/ethernet/broadcom/genet/bcmmii.c       |   2 +
 drivers/net/ethernet/broadcom/tg3.c                |   1 +
 drivers/net/ethernet/intel/iavf/iavf_main.c        |   5 +-
 drivers/net/ethernet/intel/igb/igb_main.c          |   5 +
 drivers/net/ethernet/intel/igc/igc_ethtool.c       |   2 +
 drivers/net/ethernet/intel/igc/igc_main.c          |   1 -
 drivers/net/ethernet/marvell/mvneta.c              |   4 +-
 drivers/net/ethernet/microchip/lan743x_main.c      |  21 +-
 drivers/net/ethernet/pensando/ionic/ionic_lif.c    |  57 ++-
 drivers/net/ethernet/ti/cpsw_ale.c                 |  24 +-
 drivers/net/gtp.c                                  |   2 +
 drivers/net/ipvlan/ipvlan_core.c                   |   9 +-
 drivers/net/wireless/ath/ath9k/ar9003_hw.c         |  27 +-
 drivers/net/wireless/ath/ath9k/htc_hst.c           |   8 +-
 drivers/net/wireless/ath/ath9k/main.c              |  11 +-
 drivers/net/wireless/ath/ath9k/wmi.c               |   4 +
 drivers/net/wireless/atmel/atmel_cs.c              |  13 +-
 drivers/net/wireless/cisco/airo.c                  |   5 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c       |   5 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c       |   2 +-
 drivers/net/wireless/intersil/orinoco/orinoco_cs.c |  13 +-
 .../net/wireless/intersil/orinoco/spectrum_cs.c    |  13 +-
 drivers/net/wireless/marvell/mwifiex/scan.c        |   6 +-
 drivers/net/wireless/ray_cs.c                      |  36 +-
 drivers/net/wireless/rsi/rsi_91x_sdio.c            |   3 -
 drivers/net/wireless/wl3501_cs.c                   |  51 +-
 drivers/ntb/hw/amd/ntb_hw_amd.c                    |   7 +-
 drivers/ntb/hw/idt/ntb_hw_idt.c                    |   7 +-
 drivers/ntb/hw/intel/ntb_hw_gen1.c                 |   7 +-
 drivers/ntb/ntb_transport.c                        |   2 +-
 drivers/ntb/test/ntb_tool.c                        |   2 +
 drivers/pci/controller/dwc/pcie-qcom.c             |   2 +
 drivers/pci/controller/pci-ftpci100.c              |  14 +-
 drivers/pci/controller/pcie-rockchip-ep.c          |  65 +--
 drivers/pci/controller/pcie-rockchip.c             |  17 +
 drivers/pci/controller/pcie-rockchip.h             |  11 +-
 drivers/pci/hotplug/pciehp_ctrl.c                  |   8 +
 drivers/pci/pci.c                                  |  10 +-
 drivers/pci/pcie/aspm.c                            |  21 +-
 drivers/pci/quirks.c                               |   2 +
 drivers/pinctrl/intel/pinctrl-cherryview.c         |  15 +-
 drivers/pinctrl/pinctrl-amd.c                      |  41 +-
 drivers/pinctrl/pinctrl-amd.h                      |   1 +
 drivers/pinctrl/pinctrl-at91-pio4.c                |   2 +
 drivers/platform/x86/wmi.c                         |  81 ++--
 drivers/powercap/Kconfig                           |   4 +-
 drivers/powercap/intel_rapl_msr.c                  |   1 -
 drivers/pwm/pwm-imx-tpm.c                          |   7 +
 drivers/pwm/sysfs.c                                |  17 +
 drivers/regulator/core.c                           |  30 +-
 drivers/rtc/rtc-st-lpc.c                           |   2 +-
 drivers/scsi/3w-xxxx.c                             |   4 +-
 drivers/scsi/qedf/qedf_main.c                      |   3 +-
 drivers/scsi/qla2xxx/qla_attr.c                    |  13 +
 drivers/scsi/qla2xxx/qla_bsg.c                     |   6 +
 drivers/scsi/qla2xxx/qla_def.h                     |   1 -
 drivers/scsi/qla2xxx/qla_inline.h                  |   5 +-
 drivers/scsi/qla2xxx/qla_iocb.c                    |   5 +-
 drivers/scsi/qla2xxx/qla_nvme.c                    |   3 -
 drivers/soc/fsl/qe/Kconfig                         |   1 +
 drivers/spi/spi-bcm-qspi.c                         |  10 +-
 drivers/spi/spi-bcm63xx.c                          |   2 +-
 drivers/spi/spi-geni-qcom.c                        |   2 +-
 drivers/tty/serial/8250/8250.h                     |   1 -
 drivers/tty/serial/8250/8250_omap.c                |  20 +-
 drivers/tty/serial/8250/8250_pci.c                 |  19 -
 drivers/tty/serial/8250/8250_port.c                |  11 +-
 drivers/tty/serial/atmel_serial.c                  |   4 +-
 drivers/tty/serial/fsl_lpuart.c                    |   1 +
 drivers/tty/serial/samsung.c                       |  14 +-
 drivers/usb/core/devio.c                           |   2 +
 drivers/usb/dwc3/dwc3-qcom.c                       |  12 +-
 drivers/usb/dwc3/gadget.c                          |   4 +-
 drivers/usb/phy/phy-tahvo.c                        |   2 +-
 drivers/usb/serial/option.c                        |   4 +
 drivers/video/fbdev/au1200fb.c                     |   3 +
 drivers/video/fbdev/imsttfb.c                      |  34 +-
 drivers/video/fbdev/imxfb.c                        |   4 +-
 drivers/video/fbdev/omap/lcd_mipid.c               |   6 +-
 drivers/w1/w1.c                                    |   4 +-
 fs/btrfs/qgroup.c                                  |   3 +
 fs/ceph/caps.c                                     |   9 +
 fs/dlm/plock.c                                     |   4 +-
 fs/erofs/zdata.c                                   |   2 +-
 fs/erofs/zmap.c                                    |   6 +-
 fs/ext4/indirect.c                                 |   8 +
 fs/ext4/inode.c                                    |  10 -
 fs/ext4/ioctl.c                                    |   5 +-
 fs/ext4/mballoc.c                                  |   4 +-
 fs/ext4/namei.c                                    |  17 +-
 fs/ext4/xattr.c                                    |  14 +
 fs/f2fs/namei.c                                    |  16 +-
 fs/f2fs/node.c                                     |   4 +-
 fs/fs_context.c                                    |   3 +-
 fs/fuse/dir.c                                      |   2 +-
 fs/gfs2/super.c                                    |   8 +
 fs/inode.c                                         |  42 ++
 fs/internal.h                                      |   2 +
 fs/jffs2/build.c                                   |   5 +-
 fs/jffs2/xattr.c                                   |  13 +-
 fs/jffs2/xattr.h                                   |   4 +-
 fs/jfs/jfs_dmap.c                                  |   6 +
 fs/jfs/jfs_filsys.h                                |   2 +
 fs/namei.c                                         |  25 +-
 fs/nfs/nfs4proc.c                                  |   1 +
 fs/nfsd/nfs4xdr.c                                  |   2 +-
 fs/notify/fanotify/fanotify_user.c                 |  22 +-
 fs/pstore/ram_core.c                               |   2 +
 include/crypto/skcipher.h                          |  19 +-
 include/drm/drm_panel.h                            |  13 +-
 include/linux/crypto.h                             |  31 --
 include/linux/etherdevice.h                        |  12 +
 include/linux/netdevice.h                          |  18 +
 include/linux/netfilter/nfnetlink.h                |  27 ++
 include/linux/nmi.h                                |   2 +-
 include/linux/pci.h                                |   1 +
 include/linux/sched/signal.h                       |   2 +-
 include/linux/serial_8250.h                        |   1 -
 include/linux/tcp.h                                |   2 +-
 include/linux/workqueue.h                          |  15 +-
 include/net/netfilter/nf_tables.h                  |  14 +
 include/net/netns/nftables.h                       |   6 -
 include/net/nfc/nfc.h                              |   4 +-
 include/net/pkt_sched.h                            |   2 +-
 include/net/sock.h                                 |   1 +
 include/net/tcp.h                                  |   7 +-
 include/trace/events/timer.h                       |   6 +-
 include/uapi/linux/affs_hardblocks.h               |  68 +--
 include/uapi/linux/videodev2.h                     |   2 +-
 kernel/bpf/bpf_lru_list.c                          |  21 +-
 kernel/bpf/bpf_lru_list.h                          |   7 +-
 kernel/kexec_core.c                                |   5 +-
 kernel/sched/fair.c                                |   2 +-
 kernel/time/posix-timers.c                         |  31 +-
 kernel/trace/ring_buffer.c                         |  24 +-
 kernel/trace/trace.c                               |   2 +-
 kernel/trace/trace_events_hist.c                   |   9 +-
 kernel/trace/trace_probe_tmpl.h                    |   2 +
 kernel/watchdog_hld.c                              |   6 +-
 kernel/workqueue.c                                 |  13 +-
 lib/debugobjects.c                                 |   9 +
 lib/ts_bm.c                                        |   4 +-
 net/bridge/br_if.c                                 |   5 +-
 net/can/bcm.c                                      |  12 +-
 net/core/devlink.c                                 |   5 +-
 net/core/rtnetlink.c                               | 104 +++--
 net/core/sock.c                                    |  17 +-
 net/dsa/tag_sja1105.c                              |   4 +-
 net/ipv4/inet_hashtables.c                         |  17 +-
 net/ipv4/inet_timewait_sock.c                      |   8 +-
 net/ipv4/tcp.c                                     |  31 +-
 net/ipv4/tcp_fastopen.c                            |   6 +-
 net/ipv4/tcp_input.c                               |  12 +-
 net/ipv6/addrconf.c                                |   3 +-
 net/ipv6/icmp.c                                    |   5 +-
 net/ipv6/ip6_gre.c                                 |   3 +-
 net/ipv6/udp.c                                     |   2 +-
 net/llc/llc_input.c                                |   3 -
 net/netfilter/ipset/ip_set_core.c                  |  17 +-
 net/netfilter/nf_conntrack_helper.c                |   4 +
 net/netfilter/nf_conntrack_netlink.c               |  77 +---
 net/netfilter/nf_conntrack_proto_dccp.c            |  52 ++-
 net/netfilter/nf_conntrack_sip.c                   |   2 +-
 net/netfilter/nf_tables_api.c                      | 513 ++++++++++++---------
 net/netfilter/nf_tables_offload.c                  |  29 +-
 net/netfilter/nf_tables_trace.c                    |   9 +-
 net/netfilter/nfnetlink_acct.c                     |  11 +-
 net/netfilter/nfnetlink_cthelper.c                 |  11 +-
 net/netfilter/nfnetlink_cttimeout.c                |  22 +-
 net/netfilter/nfnetlink_log.c                      |  11 +-
 net/netfilter/nfnetlink_queue.c                    |  12 +-
 net/netfilter/nft_byteorder.c                      |  14 +-
 net/netfilter/nft_chain_filter.c                   |  11 +-
 net/netfilter/nft_compat.c                         |  11 +-
 net/netfilter/nft_dynset.c                         |   6 +-
 net/netlink/af_netlink.c                           |   5 +-
 net/netlink/diag.c                                 |   7 +-
 net/nfc/core.c                                     |   4 +-
 net/nfc/hci/llc_shdlc.c                            |  10 +-
 net/nfc/llcp.h                                     |   9 +-
 net/nfc/llcp_commands.c                            |  59 ++-
 net/nfc/llcp_core.c                                |  95 ++--
 net/nfc/llcp_sock.c                                |  21 +-
 net/nfc/netlink.c                                  |  20 +-
 net/nfc/nfc.h                                      |   3 +-
 net/sched/act_pedit.c                              |   1 +
 net/sched/cls_flower.c                             |  36 +-
 net/sched/cls_fw.c                                 |  10 +-
 net/sctp/socket.c                                  |   4 +-
 net/sunrpc/svcsock.c                               |  27 +-
 net/wireless/scan.c                                | 217 +++++----
 net/wireless/wext-core.c                           |   6 +
 net/xdp/xsk.c                                      |   5 +
 samples/bpf/tcp_basertt_kern.c                     |   2 +-
 scripts/mod/modpost.c                              |  26 +-
 scripts/tags.sh                                    |   9 +-
 security/integrity/evm/evm_main.c                  |   2 +
 security/integrity/iint.c                          |  15 +-
 security/integrity/ima/ima_modsig.c                |   3 +
 security/integrity/ima/ima_policy.c                |   3 +-
 sound/core/jack.c                                  |  15 +-
 sound/pci/ac97/ac97_codec.c                        |   4 +-
 sound/soc/codecs/es8316.c                          |  23 +-
 sound/soc/fsl/imx-audmix.c                         |   9 +
 .../tests/shell/test_uprobe_from_different_cu.sh   |  77 ++++
 tools/perf/util/dwarf-aux.c                        |   2 +-
 tools/testing/selftests/net/rtnetlink.sh           |   1 +
 tools/testing/selftests/tc-testing/settings        |   1 +
 338 files changed, 3035 insertions(+), 1780 deletions(-)


