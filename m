Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 758C975D1B3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 20:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbjGUSvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 14:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231172AbjGUSvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 14:51:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E14B930CA;
        Fri, 21 Jul 2023 11:51:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 59D3F61D7F;
        Fri, 21 Jul 2023 18:51:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9100C433C9;
        Fri, 21 Jul 2023 18:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689965502;
        bh=y8ybHIKLO1WffI89aT/joYxkA7HYmOxDcXBEHS8R354=;
        h=From:To:Cc:Subject:Date:From;
        b=0YYI87c+SG+fWtva2AarBc9PfYak1HeOF6CyNKVIITWIlb7xmSGH5VX8I2Pa/pXyI
         4PI97jnwMGC7uulv19Yz90zf/5HeipNRYmWoj5dvmVbnfKdNk0xFjGlNQ1bagS8Dj3
         bDWnhT7zZ2HCJQ54YTxOlGFhmU+YesHeq6JH24hU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: [PATCH 5.15 000/532] 5.15.121-rc1 review
Date:   Fri, 21 Jul 2023 17:58:24 +0200
Message-ID: <20230721160614.695323302@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.121-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.15.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.15.121-rc1
X-KernelTest-Deadline: 2023-07-23T16:06+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 5.15.121 release.
There are 532 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sun, 23 Jul 2023 16:04:40 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.121-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 5.15.121-rc1

Pedro Tammela <pctammela@mojatatu.com>
    net/sched: sch_qfq: reintroduce lmax bound check for MTU

Thomas Bogendoerfer <tsbogend@alpha.franken.de>
    MIPS: kvm: Fix build error with KVM_MIPS_DEBUG_COP0_COUNTERS enabled

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
    scsi: qla2xxx: Fix buffer overrun

Nilesh Javali <njavali@marvell.com>
    scsi: qla2xxx: Avoid fcport pointer dereference

Nilesh Javali <njavali@marvell.com>
    scsi: qla2xxx: Array index may go out of bound

Quinn Tran <qutran@marvell.com>
    scsi: qla2xxx: Wait for io return on terminate rport

Masami Hiramatsu (Google) <mhiramat@kernel.org>
    tracing/probes: Fix to update dynamic data counter if fetcharg uses it

Masami Hiramatsu (Google) <mhiramat@kernel.org>
    tracing/probes: Fix not to count error code to total length

Matthieu Baerts <matthieu.baerts@tessares.net>
    selftests: mptcp: depend on SYN_COOKIES

Matthieu Baerts <matthieu.baerts@tessares.net>
    selftests: mptcp: sockopt: return error if wrong mark

Mateusz Stachyra <m.stachyra@samsung.com>
    tracing: Fix null pointer dereference in tracing_err_log_open()

Max Filippov <jcmvbkbc@gmail.com>
    xtensa: ISS: fix call to split_if_spec

Zheng Yejian <zhengyejian1@huawei.com>
    ftrace: Fix possible warning on checking all pages used in ftrace_process_locs()

Zheng Yejian <zhengyejian1@huawei.com>
    ring-buffer: Fix deadloop issue on reading trace_pipe

Krister Johansen <kjlx@templeofstupid.com>
    net: ena: fix shift-out-of-bounds in exponential backoff

Florent Revest <revest@chromium.org>
    samples: ftrace: Save required argument registers in sample trampolines

Zheng Yejian <zhengyejian1@huawei.com>
    tracing: Fix memory leak of iter->temp when reading trace_pipe

Mohamed Khalfella <mkhalfella@purestorage.com>
    tracing/histograms: Add histograms to hist_vars if they have referenced variables

Heiko Carstens <hca@linux.ibm.com>
    s390/decompressor: fix misaligned symbol build error

Jonas Gorski <jonas.gorski@gmail.com>
    bus: ixp4xx: fix IXP4XX_EXP_T1_MASK

Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
    Revert "8250: add support for ASIX devices with a FIFO bug"

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    soundwire: qcom: fix storing port config out-of-bounds

Stephan Gerhold <stephan.gerhold@kernkonzept.com>
    opp: Fix use-after-free in lazy_opp_tables after probe deferral

George Stark <gnstark@sberdevices.ru>
    meson saradc: fix clock divider mask length

Weitao Wang <WeitaoWang-oc@zhaoxin.com>
    xhci: Show ZHAOXIN xHCI root hub speed correctly

Weitao Wang <WeitaoWang-oc@zhaoxin.com>
    xhci: Fix TRB prefetch issue of ZHAOXIN hosts

Weitao Wang <WeitaoWang-oc@zhaoxin.com>
    xhci: Fix resume issue of some ZHAOXIN hosts

Xiubo Li <xiubli@redhat.com>
    ceph: don't let check_caps skip sending responses for revoke msgs

Ilya Dryomov <idryomov@gmail.com>
    libceph: harden msgr2.1 frame segment length checks

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    firmware: stratix10-svc: Fix a potential resource leak in svc_create_memory_pool()

Martin Fuzzey <martin.fuzzey@flowbird.group>
    tty: serial: imx: fix rs485 rx after tx

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    tty: serial: samsung_tty: Fix a memory leak in s3c24xx_serial_getclk() when iterating clk

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    tty: serial: samsung_tty: Fix a memory leak in s3c24xx_serial_getclk() in case of error

Dan Carpenter <dan.carpenter@linaro.org>
    serial: atmel: don't enable IRQs prematurely

Christian König <christian.koenig@amd.com>
    drm/ttm: never consider pinned BOs for eviction&swap

Thomas Hellström <thomas.hellstrom@linux.intel.com>
    drm/ttm: Don't leak a resource on swapout move error

gaba <gaba@amd.com>
    drm/amdgpu: avoid restore process run into dead loop.

Mario Limonciello <mario.limonciello@amd.com>
    drm/amd/display: Correct `DMUB_FW_VERSION` macro

Samuel Pitoiset <samuel.pitoiset@gmail.com>
    drm/amdgpu: fix clearing mappings for BOs that are always valid in VM

Brian Norris <briannorris@chromium.org>
    drm/rockchip: vop: Leave vblank enabled in self-refresh

Brian Norris <briannorris@chromium.org>
    drm/atomic: Allow vblank-enabled + self-refresh "disable"

Alexander Aring <aahringo@redhat.com>
    fs: dlm: return positive pid value for F_GETLK

Peter Korsgaard <peter@korsgaard.com>
    dm init: add dm-mod.waitfor to wait for asynchronously probed block devices

Jason Baron <jbaron@akamai.com>
    md/raid0: add discard support for the 'original' layout

Johan Hovold <johan+linaro@kernel.org>
    mfd: pm8008: Fix module autoloading

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

Manivannan Sadhasivam <mani@kernel.org>
    PCI: qcom: Disable write access to read only registers for IP v2.3.3

Igor Mammedov <imammedo@redhat.com>
    PCI: acpiphp: Reassign resources on bridge if necessary

Robin Murphy <robin.murphy@arm.com>
    PCI: Add function 1 DMA alias quirk for Marvell 88SE9235

Ondrej Zary <linux@zary.sk>
    PCI/PM: Avoid putting EloPOS E2/S2/H2 PCIe Ports in D3cold

Mikulas Patocka <mpatocka@redhat.com>
    dm integrity: reduce vmalloc space footprint on 32-bit architectures

Martin Kaiser <martin@kaiser.cx>
    hwrng: imx-rngc - fix the timeout for init and self check

Siddh Raman Pant <code@siddh.me>
    jfs: jfs_dmap: Validate db_l2nbperpage while mounting

Baokun Li <libaokun1@huawei.com>
    ext4: only update i_reserved_data_blocks on successful block allocation

Baokun Li <libaokun1@huawei.com>
    ext4: turn quotas off if mount failed after enabling quotas

Chao Yu <chao@kernel.org>
    ext4: fix to check return value of freeze_bdev() in ext4_shutdown()

Kemeng Shi <shikemeng@huaweicloud.com>
    ext4: fix wrong unit use in ext4_mb_new_blocks

Kemeng Shi <shikemeng@huaweicloud.com>
    ext4: get block from bh in ext4_free_blocks for fast commit replay

Kemeng Shi <shikemeng@huaweicloud.com>
    ext4: fix wrong unit use in ext4_mb_clear_bb

Zhihao Cheng <chengzhihao1@huawei.com>
    ext4: Fix reusing stale buffer heads from last failed mounting

Huacai Chen <chenhuacai@kernel.org>
    MIPS: KVM: Fix NULL pointer dereference

Huacai Chen <chenhuacai@kernel.org>
    MIPS: Loongson: Fix cpu_probe_loongson() again

Gao Xiang <hsiangkao@linux.alibaba.com>
    erofs: fix compact 4B support for 16k block size

Suzuki K Poulose <suzuki.poulose@arm.com>
    arm64: errata: Add detection for TRBE overwrite in FILL mode

Michael Ellerman <mpe@ellerman.id.au>
    powerpc/security: Fix Speculation_Store_Bypass reporting on Power10

Ekansh Gupta <quic_ekangupt@quicinc.com>
    misc: fastrpc: Create fastrpc scalar with correct buffer count

Naveen N Rao <naveen@kernel.org>
    powerpc: Fail build if using recordmcount with binutils v2.37

Ryan Roberts <ryan.roberts@arm.com>
    mm/damon/ops-common: atomically test and clear young on ptes and pmds

Florian Fainelli <florian.fainelli@broadcom.com>
    net: bcmgenet: Ensure MDIO unregistration has clocks enabled

Arseniy Krasnov <AVKrasnov@sberdevices.ru>
    mtd: rawnand: meson: fix unaligned DMA buffers handling

Jarkko Sakkinen <jarkko.sakkinen@tuni.fi>
    tpm: tpm_vtpm_proxy: fix a race condition in /dev/vtpmx creation

Mario Limonciello <mario.limonciello@amd.com>
    pinctrl: amd: Only use special debounce behavior for GPIO 0

Kornel Dulęba <korneld@chromium.org>
    pinctrl: amd: Detect and mask spurious interrupts

Mario Limonciello <mario.limonciello@amd.com>
    pinctrl: amd: Detect internal GPIO0 debounce handling

Mario Limonciello <mario.limonciello@amd.com>
    pinctrl: amd: Fix mistake in handling clearing pins at startup

Chao Yu <chao@kernel.org>
    f2fs: fix to avoid NULL pointer dereference f2fs_write_end_io()

Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
    fs/ntfs3: Check fields while reading

Ming Lei <ming.lei@redhat.com>
    nvme-pci: fix DMA direction of unmapping integrity data

Keith Busch <kbusch@kernel.org>
    nvme-pci: remove nvme_queue from nvme_iod

Pedro Tammela <pctammela@mojatatu.com>
    net/sched: sch_qfq: account for stab overhead in qfq_enqueue

Pedro Tammela <pctammela@mojatatu.com>
    net/sched: sch_qfq: refactor parsing of netlink parameters

Pedro Tammela <pctammela@mojatatu.com>
    net/sched: make psched_mtu() RTNL-less safe

Dan Carpenter <dan.carpenter@linaro.org>
    netdevsim: fix uninitialized data in nsim_dev_trap_fa_cookie_write()

Jisheng Zhang <jszhang@kernel.org>
    riscv: mm: fix truncation warning on RV32

Ido Schimmel <idosch@nvidia.com>
    net/sched: flower: Ensure both minimum and maximum ports are specified

Pu Lehui <pulehui@huawei.com>
    bpf: cpumap: Fix memory leak in cpu_map_update_elem

Randy Dunlap <rdunlap@infradead.org>
    wifi: airo: avoid uninitialized warning in airo_get_rate()

Xin Yin <yinxin.x@bytedance.com>
    erofs: fix fsdax unavailability for chunk-based regular files

Gao Xiang <hsiangkao@linux.alibaba.com>
    erofs: decouple basic mount options from fs_context

Chunhai Guo <guochunhai@vivo.com>
    erofs: avoid infinite loop in z_erofs_do_read_page() when reading beyond EOF

Suman Ghosh <sumang@marvell.com>
    octeontx2-pf: Add additional check for MCAM rules

Tvrtko Ursulin <tvrtko.ursulin@intel.com>
    drm/i915: Fix one wrong caching mode enum usage

Björn Töpel <bjorn@rivosinc.com>
    riscv, bpf: Fix inconsistent JIT image generation

Pu Lehui <pulehui@huawei.com>
    bpf, riscv: Support riscv jit to provide bpf_line_info

Florian Kauer <florian.kauer@linutronix.de>
    igc: Fix inserting of empty frame for launchtime

Florian Kauer <florian.kauer@linutronix.de>
    igc: Fix launchtime before start of cycle

Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
    kernel/trace: Fix cleanup logic of enable_trace_eprobe

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    platform/x86: wmi: Break possible infinite loop when parsing GUID

Barnabás Pőcze <pobrn@protonmail.com>
    platform/x86: wmi: move variables

Barnabás Pőcze <pobrn@protonmail.com>
    platform/x86: wmi: use guid_t and guid_equal()

Barnabás Pőcze <pobrn@protonmail.com>
    platform/x86: wmi: remove unnecessary argument

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

Paolo Abeni <pabeni@redhat.com>
    net: prevent skb corruption on frag list segmentation

Rafał Miłecki <rafal@milecki.pl>
    net: bgmac: postpone turning IRQs off to avoid SoC hangs

Nitya Sunkad <nitya.sunkad@amd.com>
    ionic: remove WARN_ON to prevent panic_on_warn

Junfeng Guo <junfeng.guo@intel.com>
    gve: Set default duplex configuration to full

M A Ramdhan <ramdhan@starlabs.sg>
    net/sched: cls_fw: Fix improper refcount update leads to use-after-free

Klaus Kudielka <klaus.kudielka@gmail.com>
    net: mvneta: fix txq_map in case of txq_number==1

Kumar Kartikeya Dwivedi <memxor@gmail.com>
    bpf: Fix max stack depth check for async callbacks

Dan Carpenter <dan.carpenter@linaro.org>
    scsi: qla2xxx: Fix error code in qla2x00_start_sp()

Aravindhan Gunasekaran <aravindhan.gunasekaran@intel.com>
    igc: Handle PPS start time programming for past time values

Prasad Koya <prasad@arista.com>
    igc: set TP bit in 'supported' and 'advertising' fields of ethtool_link_ksettings

Vlad Buslov <vladbu@nvidia.com>
    net/mlx5e: Check for NOT_READY flag state after locking

Zhengchao Shao <shaozhengchao@huawei.com>
    net/mlx5e: fix memory leak in mlx5e_ptp_open

Zhengchao Shao <shaozhengchao@huawei.com>
    net/mlx5e: fix double free in mlx5e_destroy_flow_table

Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
    igc: Remove delay during TX ring configuration

Marek Vasut <marex@denx.de>
    drm/panel: simple: Add Powertip PH800480T013 drm_display_mode flags

Douglas Anderson <dianders@chromium.org>
    drm/bridge: ti-sn65dsi86: Fix auxiliary bus lifetime

Fabio Estevam <festevam@denx.de>
    drm/panel: simple: Add connector_type for innolux_at043tn24

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: validate session id and tree id in the compound request

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: fix out-of-bound read in smb2_write

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: validate command payload size

Ralph Boehme <slow@samba.org>
    ksmbd: use ksmbd_req_buf_next() in ksmbd_smb2_check_message()

Linus Torvalds <torvalds@linux-foundation.org>
    workqueue: clean up WORK_* constant types, clarify masking

Moritz Fischer <moritzf@google.com>
    net: lan743x: Don't sleep in atomic context

Jens Axboe <axboe@kernel.dk>
    io_uring: add reschedule point to handle_tw_list()

Andres Freund <andres@anarazel.de>
    io_uring: Use io_schedule* in cqring wait

Michael Schmitz <schmitzmic@gmail.com>
    block/partition: fix signedness issue for Amiga partitions

Sherry Sun <sherry.sun@nxp.com>
    tty: serial: fsl_lpuart: add earlycon for imx8ulp platform

Jason A. Donenfeld <Jason@zx2c4.com>
    wireguard: netlink: send staged packets when setting initial private key

Jason A. Donenfeld <Jason@zx2c4.com>
    wireguard: queueing: use saner cpu selection wrapping

Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
    netfilter: nf_tables: prevent OOB access in nft_byteorder_eval

Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
    netfilter: nf_tables: do not ignore genmask when looking up chain by id

Florent Revest <revest@chromium.org>
    netfilter: conntrack: Avoid nf_ct_helper_hash uses after free

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: unbind non-anonymous set if rule construction fails

Amir Goldstein <amir73il@gmail.com>
    fanotify: disallow mount/sb marks on kernel internal pseudo fs

Zhihao Cheng <chengzhihao1@huawei.com>
    ovl: fix null pointer dereference in ovl_get_acl_rcu()

Jan Kara <jack@suse.cz>
    fs: no need to check source

Christian Marangi <ansuelsmth@gmail.com>
    leds: trigger: netdev: Recheck NETDEV_LED_MODE_LINKUP on dev rename

Arnd Bergmann <arnd@arndb.de>
    ARM: orion5x: fix d2net gpio initialization

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    ARM: dts: qcom: ipq4019: fix broken NAND controller properties override

Ricardo Ribalda Delgado <ribalda@chromium.org>
    ASoC: mediatek: mt8173: Fix snd_soc_component_initialize error path

Ricardo Ribalda Delgado <ribalda@chromium.org>
    ASoC: mediatek: mt8173: Fix irq error path

Filipe Manana <fdmanana@suse.com>
    btrfs: do not BUG_ON() on tree mod log failure at __btrfs_cow_block()

Filipe Manana <fdmanana@suse.com>
    btrfs: fix extent buffer leak after tree mod log failure at split_node()

Filipe Manana <fdmanana@suse.com>
    btrfs: fix race when deleting quota root from the dirty cow roots list

Naohiro Aota <naota@elisp.net>
    btrfs: reinsert BGs failed to reclaim

Naohiro Aota <naota@elisp.net>
    btrfs: bail out reclaim process if filesystem is read-only

Naohiro Aota <naota@elisp.net>
    btrfs: delete unused BGs while reclaiming BGs

Matt Corallo <blnxfsl@bluematt.me>
    btrfs: add handling for RAID1C23/DUP to btrfs_reduce_alloc_profile

Thomas Weißschuh <linux@weissschuh.net>
    fs: avoid empty option when generating legacy mount string

Fabian Frederick <fabf@skynet.be>
    jffs2: reduce stack usage in jffs2_build_xattr_subsystem()

Abhijeet Rastogi <abhijeet.1989@gmail.com>
    ipvs: increase ip_vs_conn_tab_bits range for 64BIT

Jan Kara <jack@suse.cz>
    fs: Lock moved directories

Jan Kara <jack@suse.cz>
    fs: Establish locking order for unrelated directories

Jan Kara <jack@suse.cz>
    Revert "f2fs: fix potential corruption when moving a directory"

Jan Kara <jack@suse.cz>
    ext4: Remove ext4 locking of moved directory

Roberto Sassu <roberto.sassu@huawei.com>
    shmem: use ramfs_kill_sb() for kill_sb method of ramfs-based tmpfs

Arnd Bergmann <arnd@arndb.de>
    autofs: use flexible array in ioctl structure

Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
    integrity: Fix possible multiple allocation in integrity_inode_get()

Kees Cook <keescook@chromium.org>
    um: Use HOST_DIR for mrproper

Zheng Wang <zyytlz.wz@163.com>
    bcache: Fix __bch_btree_node_alloc to make the failure behavior consistent

Zheng Wang <zyytlz.wz@163.com>
    bcache: Remove unnecessary NULL point check in node allocations

Mingzhe Zou <mingzhe.zou@easystack.cn>
    bcache: fixup btree_cache_wait list damage

Chevron Li <chevron.li@bayhubtech.com>
    mmc: sdhci: fix DMA configure compatibility issue when 64bit DMA mode is used.

Ulf Hansson <ulf.hansson@linaro.org>
    mmc: mmci: Set PROBE_PREFER_ASYNCHRONOUS

Robert Marko <robimarko@gmail.com>
    mmc: core: disable TRIM on Micron MTFC4GACAJCN-1M

Robert Marko <robimarko@gmail.com>
    mmc: core: disable TRIM on Kingston EMMC04G-M627

Jens Axboe <axboe@kernel.dk>
    io_uring: wait interruptibly for request completions on exit

Dai Ngo <dai.ngo@oracle.com>
    NFSD: add encoding of op_recall flag for write delegation

Shuai Jiang <d202180596@hust.edu.cn>
    i2c: qup: Add missing unwind goto in qup_i2c_probe()

Filipe Manana <fdmanana@suse.com>
    btrfs: do not BUG_ON() on tree mod log failure at balance_level()

Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    extcon: usbc-tusb320: Convert to i2c's .probe_new()

Robert Hancock <robert.hancock@calian.com>
    i2c: xiic: Don't try to handle more interrupt events after error

Marek Vasut <marex@denx.de>
    i2c: xiic: Defer xiic_wakeup() and __xiic_start_xfer() in xiic_process()

Danila Chernetsov <listdansp@mail.ru>
    apparmor: fix missing error check for rhashtable_insert_fast

Artur Rojek <contact@artur-rojek.eu>
    sh: dma: Fix DMA channel offset calculation

Thorsten Winkler <twinkler@linux.ibm.com>
    s390/qeth: Fix vipa deletion

Hariprasad Kelam <hkelam@marvell.com>
    octeontx-af: fix hardware timestamp configuration

Vladimir Oltean <vladimir.oltean@nxp.com>
    net: dsa: tag_sja1105: fix MAC DA patching from meta frames

Guillaume Nault <gnault@redhat.com>
    pptp: Fix fib lookup calls.

Woody Zhang <woodylab@foxmail.com>
    riscv: move memblock_allow_resize() after linear mapping is ready

Lin Ma <linma@zju.edu.cn>
    net/sched: act_pedit: Add size check for TCA_PEDIT_PARMS_EX

Ilya Maximets <i.maximets@ovn.org>
    xsk: Honor SO_BINDTODEVICE on bind

Eric Dumazet <edumazet@google.com>
    tcp: annotate data races in __tcp_oow_rate_limited()

Vladimir Oltean <vladimir.oltean@nxp.com>
    net: bridge: keep ports without IFF_UNICAST_FLT in BR_PROMISC mode

Randy Dunlap <rdunlap@infradead.org>
    powerpc: allow PPC_EARLY_DEBUG_CPM only when SERIAL_CPM=y

Zeng Heng <zengheng4@huawei.com>
    ntfs: Fix panic about slab-out-of-bounds caused by ntfs_listxattr()

Hariprasad Kelam <hkelam@marvell.com>
    octeontx2-af: Add validation before accessing cgx and lmac

Hariprasad Kelam <hkelam@marvell.com>
    octeontx2-af: Fix mapping for NIX block from CGX connection

Chao Yu <chao@kernel.org>
    f2fs: fix error path handling in truncate_dnode()

Nishanth Menon <nm@ti.com>
    mailbox: ti-msgmgr: Fill non-message tx data fields with 0x0

Jonas Gorski <jonas.gorski@gmail.com>
    spi: bcm-qspi: return error if neither hif_mspi nor mspi is available

Pawel Dembicki <paweldembicki@gmail.com>
    net: dsa: vsc73xx: fix MTU configuration

Nick Child <nnac123@linux.ibm.com>
    ibmvnic: Do not reset dql stats on NON_FATAL err

Tobias Heider <me@tobhe.de>
    Add MODULE_FIRMWARE() for FIRMWARE_TG357766.

Florian Westphal <fw@strlen.de>
    net/sched: act_ipt: add sanity checks on table name and hook locations

Chengfeng Ye <dg573847474@gmail.com>
    sctp: fix potential deadlock on &net->sctp.addr_wq_lock

Randy Dunlap <rdunlap@infradead.org>
    media: cec: i2c: ch7322: also select REGMAP

Jouni Högander <jouni.hogander@intel.com>
    drm/i915/psr: Use hw.adjusted mode when calculating io/fast wake times

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    rtc: st-lpc: Release some resources in st_rtc_probe() in case of error

Li Nan <linan122@huawei.com>
    md/raid10: fix the condition to call bio_end_io_acct()

Shuijing Li <shuijing.li@mediatek.com>
    pwm: mtk_disp: Fix the disable flow of disp_pwm

Dan Carpenter <dan.carpenter@linaro.org>
    pwm: ab8500: Fix error code in probe()

Marek Vasut <marex@denx.de>
    pwm: sysfs: Do not apply state to already disabled PWMs

Fancy Fang <chen.fang@nxp.com>
    pwm: imx-tpm: force 'real_period' to be zero in suspend

Claudiu Beznea <claudiu.beznea@microchip.com>
    phy: tegra: xusb: check return value of devm_kzalloc()

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    mfd: stmpe: Only disable the regulators if they are enabled

Christian Borntraeger <borntraeger@linux.ibm.com>
    KVM: s390/diag: fix racy access of physical cpu number in diag 9c handler

Pierre Morel <pmorel@linux.ibm.com>
    KVM: s390: vsie: fix the length of APCB bitmap

Amelie Delaunay <amelie.delaunay@foss.st.com>
    mfd: stmfx: Nullify stmfx->vdd in case of error

Amelie Delaunay <amelie.delaunay@foss.st.com>
    mfd: stmfx: Fix error path in stmfx_chip_init

Phil Elwell <phil@raspberrypi.com>
    nvmem: rmem: Use NVMEM_DEVID_AUTO

Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
    test_firmware: return ENOMEM instead of ENOSPC on failed memory allocation

Tony Lindgren <tony@atomide.com>
    serial: 8250_omap: Use force_suspend and resume for system suspend

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Revert "usb: common: usb-conn-gpio: Set last role to unknown before initial detection"

Jiasheng Jiang <jiasheng@iscas.ac.cn>
    mfd: intel-lpss: Add missing check for platform_get_resource

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    usb: dwc3-meson-g12a: Fix an error handling path in dwc3_meson_g12a_probe()

Prashanth K <quic_prashk@quicinc.com>
    usb: common: usb-conn-gpio: Set last role to unknown before initial detection

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    usb: dwc3: qcom: Fix an error handling path in dwc3_qcom_probe()

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    usb: dwc3: qcom: Release the correct resources in dwc3_qcom_remove()

Nico Boehr <nrb@linux.ibm.com>
    KVM: s390: fix KVM_S390_GET_CMMA_BITS for GFNs in memslot holes

Dan Carpenter <dan.carpenter@linaro.org>
    media: atomisp: gmin_platform: fix out_len in gmin_get_config_dsm_var()

Rikard Falkeborn <rikard.falkeborn@gmail.com>
    media: venus: helpers: Fix ALIGN() of non power of two

Stephan Gerhold <stephan@gerhold.net>
    mfd: rt5033: Drop rt5033-battery sub-device

James Clark <james.clark@arm.com>
    coresight: Fix loss of connection info when a module is unloaded

Muchun Song <songmuchun@bytedance.com>
    kernfs: fix missing kernfs_idr_lock to remove an ID from the IDR

John Ogness <john.ogness@linutronix.de>
    serial: 8250: lock port for UART_IER access in omap8250_irq()

John Ogness <john.ogness@linutronix.de>
    serial: 8250: lock port for stop_rx() in omap8250_irq()

Arnd Bergmann <arnd@arndb.de>
    usb: hide unused usbfs_notify_suspend/resume functions

Li Yang <lidaxian@hust.edu.cn>
    usb: phy: phy-tahvo: fix memory leak in tahvo_usb_probe()

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    extcon: Fix kernel doc of property capability fields to avoid warnings

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    extcon: Fix kernel doc of property fields to avoid warnings

Prashanth K <quic_prashk@quicinc.com>
    usb: gadget: u_serial: Add null pointer check in gserial_suspend

Vladislav Efanov <VEfanov@ispras.ru>
    usb: dwc3: qcom: Fix potential memory leak

Robert Marko <robimarko@gmail.com>
    clk: qcom: ipq6018: fix networking resets

Robert Marko <robimarko@gmail.com>
    clk: qcom: reset: support resetting multiple bits

Stephan Gerhold <stephan.gerhold@kernkonzept.com>
    clk: qcom: reset: Allow specifying custom reset delay

Daniel Scally <dan.scally@ideasonboard.com>
    media: i2c: Correct format propagation for st-mipid02

Duoming Zhou <duoming@zju.edu.cn>
    media: usb: siano: Fix warning due to null work_func_t function pointer

Marek Vasut <marex@denx.de>
    media: videodev2.h: Fix struct v4l2_input tuner index comment

Daniil Dulov <d.dulov@aladdin.ru>
    media: usb: Check az6007_read() return value

Mantas Pucka <mantas@8devices.com>
    clk: qcom: gcc-ipq6018: Use floor ops for sdcc clocks

Taniya Das <quic_tdas@quicinc.com>
    clk: qcom: camcc-sc7180: Add parent dependency to all camera GDSCs

Tony Lindgren <tony@atomide.com>
    serial: 8250: omap: Fix freeing of resources on failed register

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    usb: dwc2: Fix some error handling paths

Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    usb: dwc2: platform: Improve error reporting for problems during .remove()

John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
    sh: j2: Use ioremap() to translate device tree address into kernel memory

Dan Carpenter <dan.carpenter@oracle.com>
    w1: fix loop in w1_fini()

Stefan Wahren <stefan.wahren@i2se.com>
    w1: w1_therm: fix locking behavior in convert_t

Ding Hui <dinghui@sangfor.com.cn>
    SUNRPC: Fix UAF in svc_tcp_listen_data_ready()

Demi Marie Obenour <demi@invisiblethingslab.com>
    block: increment diskseq on all media change events

Michael Schmitz <schmitzmic@gmail.com>
    block: change all __u32 annotations to __be32 in affs_hardblocks.h

Michael Schmitz <schmitzmic@gmail.com>
    block: add overflow checks for Amiga partition support

Michael Schmitz <schmitzmic@gmail.com>
    block: fix signed int overflow in Amiga partition support

Takashi Iwai <tiwai@suse.de>
    ALSA: jack: Fix mutex call in snd_jack_report()

Werner Sembach <wse@tuxedocomputers.com>
    ALSA: hda/realtek: Add quirk for Clevo NPx0SNx

Sean Nyekjaer <sean@geanix.com>
    iio: accel: fxls8962af: fixup buffer scan element type

Sean Nyekjaer <sean@geanix.com>
    iio: accel: fxls8962af: errata bug only applicable for FXLS8962AF

Fabrizio Lamarque <fl.scratchpad@gmail.com>
    iio: adc: ad7192: Fix internal/external clock selection

Fabrizio Lamarque <fl.scratchpad@gmail.com>
    iio: adc: ad7192: Fix null ad7192_state pointer access

EJ Hsu <ejh@nvidia.com>
    phy: tegra: xusb: Clear the driver reference in usb-phy dev

Krishna Kurapati <quic_kriskura@quicinc.com>
    usb: dwc3: gadget: Propagate core init errors to UDC during pullup

Davide Tronchin <davide.tronchin.94@gmail.com>
    USB: serial: option: add LARA-R6 01B PIDs

Jens Axboe <axboe@kernel.dk>
    io_uring: ensure IOPOLL locks around deferred work

Liu Shixin <liushixin2@huawei.com>
    bootmem: remove the vmemmap pages from kmemleak in free_bootmem_page

Kiran K <kiran.k@intel.com>
    ACPI: utils: Fix acpi_evaluate_dsm_typed() redefinition error

Arnd Bergmann <arnd@arndb.de>
    ksmbd: avoid field overflow warning

Ard Biesheuvel <ardb@kernel.org>
    efi/libstub: Disable PCI DMA before grabbing the EFI memory map

Sami Tolvanen <samitolvanen@google.com>
    kbuild: Disable GCOV for *.mod.o

Martin Kaiser <martin@kaiser.cx>
    hwrng: st - keep clock enabled while hwrng is registered

Tarun Sahu <tsahu@linux.ibm.com>
    dax/kmem: Pass valid argument to memory_group_register_static

Dan Williams <dan.j.williams@intel.com>
    dax: Introduce alloc_dev_dax_id()

Dan Williams <dan.j.williams@intel.com>
    dax: Fix dax_mapping_release() use after free

Bharath SM <bharathsm@microsoft.com>
    SMB3: Do not send lease break acknowledgment if all file handles have been closed

Olga Kornievskaia <kolga@netapp.com>
    NFSv4.1: freeze the session table upon receiving NFS4ERR_BADSESSION

Hareshx Sankar Raj <hareshx.sankar.raj@intel.com>
    crypto: qat - unmap buffers before free for RSA

Hareshx Sankar Raj <hareshx.sankar.raj@intel.com>
    crypto: qat - unmap buffer before free for DH

Herbert Xu <herbert@gondor.apana.org.au>
    crypto: qat - Use helper to set reqsize

Herbert Xu <herbert@gondor.apana.org.au>
    crypto: kpp - Add helper to set reqsize

Damian Muszynski <damian.muszynski@intel.com>
    crypto: qat - use reference to structure in dma_map_single()

Andre Przywara <andre.przywara@arm.com>
    crypto: qat - replace get_current_node() with numa_node_id()

Giovanni Cabiddu <giovanni.cabiddu@intel.com>
    crypto: qat - honor CRYPTO_TFM_REQ_MAY_SLEEP flag

Masahiro Yamada <masahiroy@kernel.org>
    ARC: define ASM_NL and __ALIGN(_STR) outside #ifdef __ASSEMBLY__ guard

Dan Carpenter <dan.carpenter@linaro.org>
    modpost: fix off by one in is_executable_section()

Arnd Bergmann <arnd@arndb.de>
    crypto: marvell/cesa - Fix type mismatch warning

Masahiro Yamada <masahiroy@kernel.org>
    modpost: fix section mismatch message for R_ARM_{PC24,CALL,JUMP24}

Masahiro Yamada <masahiroy@kernel.org>
    modpost: fix section mismatch message for R_ARM_ABS32

Randy Dunlap <rdunlap@infradead.org>
    crypto: nx - fix build warnings when DEBUG_FS is not enabled

Masahiro Yamada <masahiroy@kernel.org>
    modpost: remove broken calculation of exception_table_entry size

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

Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
    powerpc/book3s64/mm: Fix DirectMap stats in /proc/meminfo

Tiezhu Yang <yangtiezhu@loongson.cn>
    riscv: uprobes: Restore thread.bad_cause

Aditya Gupta <adityag@linux.ibm.com>
    powerpc: update ppc_save_regs to save current r1 in pt_regs

Nicholas Piggin <npiggin@gmail.com>
    powerpc: simplify ppc_save_regs

Colin Ian King <colin.i.king@gmail.com>
    powerpc/powernv/sriov: perform null check on iov before dereferencing iov

Claudiu Beznea <claudiu.beznea@microchip.com>
    pinctrl: at91-pio4: check return value of devm_kasprintf()

Claudiu Beznea <claudiu.beznea@microchip.com>
    pinctrl: microchip-sgpio: check return value of devm_kasprintf()

Nicholas Piggin <npiggin@gmail.com>
    powerpc/64s: Fix VAS mm use after free

Namhyung Kim <namhyung@kernel.org>
    perf dwarf-aux: Fix off-by-one in die_get_varname()

Arnaldo Carvalho de Melo <acme@redhat.com>
    perf script: Fix allocation of evsel->priv related to per-event dump files

Christophe Leroy <christophe.leroy@csgroup.eu>
    powerpc/signal32: Force inlining of __unsafe_save_user_regs() and save_tm_user_regs_unsafe()

Christophe Leroy <christophe.leroy@csgroup.eu>
    powerpc/interrupt: Don't read MSR from interrupt_exit_kernel_prepare()

Christophe Leroy <christophe.leroy@csgroup.eu>
    kcsan: Don't expect 64 bits atomic builtins from 32 bits architectures

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    pinctrl: cherryview: Return correct value if pin in push-pull mode

Arnaldo Carvalho de Melo <acme@redhat.com>
    perf bench: Add missing setlocale() call to allow usage of %'d style formatting

Sohaib Mohamed <sohaib.amhmd@gmail.com>
    perf bench: Use unbuffered output when pipe/tee'ing to a file

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

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    pinctrl: bcm2835: Handle gpiochip_add_pin_range() errors

Jinhong Zhu <jinhongzhu@hust.edu.cn>
    scsi: qedf: Fix NULL dereference in error handling

Nirmal Patel <nirmal.patel@linux.intel.com>
    PCI: vmd: Reset VMD config register between soft reboots

Siddharth Vadapalli <s-vadapalli@ti.com>
    PCI: cadence: Fix Gen2 Link Retraining process

Fei Shao <fshao@chromium.org>
    clk: Fix memory leak in devm_clk_notifier_register()

Claudiu Beznea <claudiu.beznea@microchip.com>
    ASoC: imx-audmix: check return value of devm_kasprintf()

Amir Goldstein <amir73il@gmail.com>
    ovl: update of dentry revalidate flags after copy up

Alexey Romanov <avromanov@sberdevices.ru>
    drivers: meson: secure-pwrc: always enable DMA domain

Claudiu Beznea <claudiu.beznea@microchip.com>
    clk: ti: clkctrl: check return value of kasprintf()

Claudiu Beznea <claudiu.beznea@microchip.com>
    clk: keystone: sci-clk: check return value of kasprintf()

Claudiu Beznea <claudiu.beznea@microchip.com>
    clk: si5341: free unused memory on probe failure

Claudiu Beznea <claudiu.beznea@microchip.com>
    clk: si5341: check return value of {devm_}kasprintf()

Claudiu Beznea <claudiu.beznea@microchip.com>
    clk: si5341: return error if one synth clock registration fails

Claudiu Beznea <claudiu.beznea@microchip.com>
    clk: cdce925: check return value of kasprintf()

Claudiu Beznea <claudiu.beznea@microchip.com>
    clk: vc5: check memory returned by kasprintf()

Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
    drm/msm/dpu: correct MERGE_3D length

Nícolas F. R. A. Prado <nfraprado@collabora.com>
    arm64: dts: mediatek: mt8192: Fix CPUs capacity-dmips-mhz

Allen-KH Cheng <allen-kh.cheng@mediatek.com>
    arm64: dts: mediatek: Add cpufreq nodes for MT8192

Bjorn Andersson <quic_bjorande@quicinc.com>
    drm/msm/dp: Free resources after unregistering them

Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
    drm/msm/dpu: do not enable color-management if DSPPs are not available

Su Hui <suhui@nfschina.com>
    ALSA: ac97: Fix possible NULL dereference in snd_ac97_mixer

Yuan Can <yuancan@huawei.com>
    clk: tegra: tegra124-emc: Fix potential memory leak

Dan Carpenter <dan.carpenter@linaro.org>
    clk: clocking-wizard: Fix Oops in clk_wzrd_register_divider()

Marijn Suijten <marijn.suijten@somainline.org>
    arm64: dts: qcom: sm8250-edo: Panel framebuffer is 2.5k instead of 4k

Yuxing Liu <lyx2022@hust.edu.cn>
    clk: imx: clk-imx8mp: improve error handling in imx8mp_clocks_probe()

Hao Luo <m202171776@hust.edu.cn>
    clk: imx: clk-imx8mn: fix memory leak in imx8mn_clocks_probe

Kashyap Desai <kashyap.desai@broadcom.com>
    RDMA/bnxt_re: Avoid calling wake_up threads from spin_lock context

Kashyap Desai <kashyap.desai@broadcom.com>
    RDMA/bnxt_re: wraparound mbox producer index

Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
    drm/msm/a5xx: really check for A510 in a5xx_gpu_init

Chia-I Wu <olvaffe@gmail.com>
    amdgpu: validate offset_in_bo of drm_amdgpu_gem_va

Nikita Zhandarovich <n.zhandarovich@fintech.ru>
    drm/radeon: fix possible division-by-zero errors

Aurabindo Pillai <aurabindo.pillai@amd.com>
    drm/amd/display: Fix artifacting on eDP panels when engaging freesync video mode

Daniil Dulov <d.dulov@aladdin.ru>
    drm/amdkfd: Fix potential deallocation of previously deallocated memory.

Christian Lamparter <chunkeey@gmail.com>
    ARM: dts: BCM5301X: fix duplex-full => full-duplex

Guenter Roeck <linux@roeck-us.net>
    hwmon: (pmbus/adm1275) Fix problems with temperature monitoring on ADM1272

Potin Lai <potin.lai@quantatw.com>
    hwmon: (adm1275) Allow setting sample averaging

Tim Harvey <tharvey@gateworks.com>
    hwmon: (gsc-hwmon) fix fan pwm temperature scaling

Olivier Moysan <olivier.moysan@foss.st.com>
    ARM: dts: stm32: fix i2s endpoint format property for stm32mp15xx-dkx

Marek Vasut <marex@denx.de>
    ARM: dts: stm32: Fix audio routing on STM32MP15xx DHCOM PDK2

Keerthy <j-keerthy@ti.com>
    arm64: dts: ti: k3-j7200: Fix physical address of pin

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    fbdev: omapfb: lcd_mipid: Fix an error handling path in mipid_spi_probe()

Wolfram Sang <wsa+renesas@sang-engineering.com>
    arm64: dts: renesas: ulcb-kf: Remove flow control for SCIF1

Geert Uytterhoeven <geert+renesas@glider.be>
    ARM: dts: iwg20d-q7-common: Fix backlight pwm specifier

Chengchang Tang <tangchengchang@huawei.com>
    RDMA/hns: Fix hns_roce_table_get return value

Brendan Cunningham <bcunningham@cornelisnetworks.com>
    IB/hfi1: Fix wrong mmu_node used for user SDMA packet after invalidate

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    IB/hfi1: Use bitmap_zalloc() when applicable

Arnd Bergmann <arnd@arndb.de>
    RDMA/irdma: avoid fortify-string warning in irdma_clr_wqes

Randy Dunlap <rdunlap@infradead.org>
    soc/fsl/qe: fix usb.c build errors

Martin Blumenstingl <martin.blumenstingl@googlemail.com>
    ARM: dts: meson8: correct uart_B and uart_C clock references

Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
    ASoC: es8316: Do not set rate constraints for unsupported MCLKs

Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
    ASoC: es8316: Increment max value for ALC Capture Target Volume control

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    memory: brcmstb_dpfe: fix testing array offset after use

Marek Vasut <marex@denx.de>
    ARM: dts: stm32: Shorten the AV96 HDMI sound card name

Douglas Anderson <dianders@chromium.org>
    arm64: dts: mediatek: mt8183: Add mediatek,broken-save-restore-fw to kukui

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    arm64: dts: qcom: apq8096: fix fixed regulator name property

Arnd Bergmann <arnd@arndb.de>
    ARM: omap2: fix missing tick_broadcast() prototype

Arnd Bergmann <arnd@arndb.de>
    ARM: ep93xx: fix missing-prototype warnings

Dario Binacchi <dario.binacchi@amarulasolutions.com>
    drm/panel: simple: fix active size for Ampire AM-480272H3TMQW-T01H

Stephan Gerhold <stephan@gerhold.net>
    arm64: dts: qcom: apq8016-sbc: Fix 1.8V power rail on LS expansion

Stephan Gerhold <stephan@gerhold.net>
    arm64: dts: qcom: apq8016-sbc: Fix regulator constraints

Stephan Gerhold <stephan@gerhold.net>
    arm64: dts: qcom: Drop unneeded extra device-specific includes

Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
    arm64: dts: qcom: apq8016-sbc: fix mpps state names

Stephan Gerhold <stephan@gerhold.net>
    arm64: dts: qcom: apq8016-sbc: Clarify firmware-names

Bjorn Andersson <bjorn.andersson@linaro.org>
    arm64: dts: qcom: apq8016-sbc: Update modem and WiFi firmware path

Yassine Oudjana <y.oudjana@protonmail.com>
    arm64: dts: qcom: db820c: Move blsp1_uart2 pin states to msm8996.dtsi

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    arm64: dts: qcom: sdm845: correct camss unit address

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    arm64: dts: qcom: sdm630: correct camss unit address

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    arm64: dts: qcom: msm8996: correct camss unit address

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    arm64: dts: qcom: msm8994: correct SPMI unit address

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    arm64: dts: qcom: msm8916: correct camss unit address

Tony Lindgren <tony@atomide.com>
    ARM: dts: gta04: Move model property out of pinctrl node

Konrad Dybcio <konrad.dybcio@linaro.org>
    drm/msm/dpu: Set DPU_DATA_HCTL_EN for in INTF_SC7180_MASK

Vinod Polimera <quic_vpolimer@quicinc.com>
    drm/msm/disp/dpu: get timing engine status from intf status register

Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
    drm/msm/dsi: don't allow enabling 14nm VCO with unprogrammed rate

Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
    RDMA/bnxt_re: Fix to remove an unnecessary log

Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
    RDMA/bnxt_re: Remove a redundant check inside bnxt_re_update_gid

Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
    RDMA/bnxt_re: Use unique names while registering interrupts

Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
    RDMA/bnxt_re: Fix to remove unnecessary return labels

Selvin Xavier <selvin.xavier@broadcom.com>
    RDMA/bnxt_re: Disable/kill tasklet only if it is enabled

Dan Carpenter <dan.carpenter@linaro.org>
    clk: imx: scu: use _safe list iterator to avoid a use after free

Robert Marko <robert.marko@sartura.hr>
    arm64: dts: microchip: sparx5: do not use PSCI on reference boards

Tony Lindgren <tony@atomide.com>
    bus: ti-sysc: Fix dispc quirk masking bool variables

Marek Vasut <marex@denx.de>
    ARM: dts: stm32: Move ethernet MAC EEPROM from SoM to carrier boards

Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
    drm/panel: sharp-ls043t1le01: adjust mode settings

XuDong Liu <m202071377@hust.edu.cn>
    drm: sun4i_tcon: use devm_clk_get_enabled in `sun4i_tcon_init_clocks`

Marek Vasut <marex@denx.de>
    Input: adxl34x - do not hardcode interrupt trigger type

hfdevel@gmx.net <hfdevel@gmx.net>
    ARM: dts: meson8b: correct uart_B and uart_C clock references

Rafał Miłecki <rafal@milecki.pl>
    ARM: dts: BCM5301X: Drop "clock-names" from the SPI node

Luc Ma <luc@sietium.com>
    drm/vram-helper: fix function names in vram helper doc

Francesco Dolcini <francesco.dolcini@toradex.com>
    drm/bridge: tc358768: fix THS_TRAILCNT computation

Francesco Dolcini <francesco.dolcini@toradex.com>
    drm/bridge: tc358768: fix TXTAGOCNT computation

Francesco Dolcini <francesco.dolcini@toradex.com>
    drm/bridge: tc358768: fix THS_ZEROCNT computation

Francesco Dolcini <francesco.dolcini@toradex.com>
    drm/bridge: tc358768: fix TCLK_TRAILCNT computation

Francesco Dolcini <francesco.dolcini@toradex.com>
    drm/bridge: tc358768: Add atomic_get_input_bus_fmts() implementation

Francesco Dolcini <francesco.dolcini@toradex.com>
    drm/bridge: tc358768: fix TCLK_ZEROCNT computation

Francesco Dolcini <francesco.dolcini@toradex.com>
    drm/bridge: tc358768: fix PLL target frequency

Francesco Dolcini <francesco.dolcini@toradex.com>
    drm/bridge: tc358768: fix PLL parameters computation

Francesco Dolcini <francesco.dolcini@toradex.com>
    drm/bridge: tc358768: always enable HS video mode

Luca Weiss <luca@z3ntu.xyz>
    Input: drv260x - sleep between polling GO bit

Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
    drm/amd/display: Explicitly specify update type per plane info change

Nikita Zhandarovich <n.zhandarovich@fintech.ru>
    radeon: avoid double free in ci_dpm_init()

Wesley Chalmers <Wesley.Chalmers@amd.com>
    drm/amd/display: Add logging for display MALL refresh setting

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

Edward Cree <ecree.xilinx@gmail.com>
    sfc: fix crash when reading stats while NIC is resetting

Maxim Kochetkov <fido_max@inbox.ru>
    net: axienet: Move reset before 64-bit DMA detection

Kuniyuki Iwashima <kuniyu@amazon.com>
    gtp: Fix use-after-free in __gtp_encap_destroy().

Sabrina Dubroca <sd@queasysnail.net>
    selftests: rtnetlink: remove netdevsim device after ipsec offload test

Eric Dumazet <edumazet@google.com>
    bonding: do not assume skb mac_header is set

Eric Dumazet <edumazet@google.com>
    netlink: do not hard code device address lenth in fdb dumps

Eric Dumazet <edumazet@google.com>
    netlink: fix potential deadlock in netlink_set_err()

Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
    net: stmmac: fix double serdes powerdown

Vinicius Costa Gomes <vinicius.gomes@intel.com>
    igc: Fix race condition in PTP tx code

Vincent Mailhol <mailhol.vincent@wanadoo.fr>
    can: length: fix bitstuffing count

Gilad Sever <gilad9366@gmail.com>
    bpf: Fix bpf socket lookup from tc/xdp to respect socket VRF bindings

Gilad Sever <gilad9366@gmail.com>
    bpf: Call __bpf_sk_lookup()/__bpf_skc_lookup() directly via TC hookpoint

Gilad Sever <gilad9366@gmail.com>
    bpf: Factor out socket lookup functions for the TC hookpoint.

Tobias Klauser <tklauser@distanz.ch>
    bpf: Omit superfluous address family check in __bpf_skc_lookup

Dmitry Antipov <dmantipov@yandex.ru>
    wifi: ath9k: convert msecs to jiffies where needed

Johannes Berg <johannes.berg@intel.com>
    wifi: iwlwifi: mvm: indicate HW decrypt for beacon protection

Benjamin Berg <benjamin.berg@intel.com>
    wifi: cfg80211: rewrite merging of inherited elements

Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
    wifi: iwlwifi: pcie: fix NULL pointer dereference in iwl_pcie_irq_rx_msix_handler()

Emmanuel Grumbach <emmanuel.grumbach@intel.com>
    iwlwifi: don't dump_stack() when we get an unexpected interrupt

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

Marek Vasut <marex@denx.de>
    wifi: rsi: Do not configure WoWlan in shutdown hook if not enabled

Jesper Dangaard Brouer <brouer@redhat.com>
    selftests/bpf: Fix check_mtu using wrong variable type

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

Alan Maguire <alan.maguire@oracle.com>
    bpftool: JIT limited misreported as negative value on aarch64

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    nfc: llcp: fix possible use of uninitialized variable in nfc_llcp_send_connect()

Joy Chakraborty <joychakr@google.com>
    spi: dw: Round of n_bytes to power of 2

Stanislav Fomichev <sdf@google.com>
    bpf: Don't EFAULT for {g,s}setsockopt with wrong optlen

Andrii Nakryiko <andrii@kernel.org>
    libbpf: fix offsetof() and container_of() to work with CO-RE

Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
    sctp: add bpf_bypass_getsockopt proto callback

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    wifi: mwifiex: Fix the size of a memory allocation in mwifiex_ret_802_11_scan()

Amisha Patel <amisha.patel@microchip.com>
    wifi: wilc1000: fix for absent RSN capabilities WFA testcase

Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
    spi: spi-geni-qcom: Correct CS_TOGGLE bit in SPI_TRANS_CFG

Pengcheng Yang <yangpc@wangsu.com>
    samples/bpf: Fix buffer overflow in tcp_basertt

Martin KaFai Lau <martin.lau@kernel.org>
    libbpf: btf_dump_type_data_check_overflow needs to consider BTF_MEMBER_BITFIELD_SIZE

Fedor Pchelkin <pchelkin@ispras.ru>
    wifi: ath9k: avoid referencing uninit memory in ath9k_wmi_ctrl_rx

Peter Seiderer <ps.report@gmx.net>
    wifi: ath9k: fix AR9003 mac hardware hang check register offset calculation

Jesper Dangaard Brouer <brouer@redhat.com>
    igc: Enable and fix RX hash usage by netstack

Jiasheng Jiang <jiasheng@iscas.ac.cn>
    pstore/ram: Add check for kstrdup

Roberto Sassu <roberto.sassu@huawei.com>
    ima: Fix build warnings

Roberto Sassu <roberto.sassu@huawei.com>
    evm: Fix build warnings

Roberto Sassu <roberto.sassu@huawei.com>
    evm: Complete description of evm_inode_setattr()

Mark Rutland <mark.rutland@arm.com>
    locking/atomic: arm: fix sync ops

Juergen Gross <jgross@suse.com>
    x86/mm: Fix __swp_entry_to_pte() for Xen PV guests

Ravi Bangoria <ravi.bangoria@amd.com>
    perf/ibs: Fix interface via core pmu events

Colin Ian King <colin.i.king@gmail.com>
    kselftest: vDSO: Fix accumulation of uninitialized ret when CLOCK_REALTIME is undefined

Qiuxu Zhuo <qiuxu.zhuo@intel.com>
    rcu/rcuscale: Stop kfree_scale_thread thread(s) after unloading rcuscale

Qiuxu Zhuo <qiuxu.zhuo@intel.com>
    rcu/rcuscale: Move rcu_scale_*() after kfree_scale_cleanup()

Paul E. McKenney <paulmck@kernel.org>
    rcuscale: Move shutdown from wait_event() to wait_event_idle()

Li Zhijian <zhijianx.li@intel.com>
    rcuscale: Always log error message

Paul E. McKenney <paulmck@kernel.org>
    rcutorture: Correct name of use_softirq module parameter

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    thermal/drivers/sun8i: Fix some error handling paths in sun8i_ths_probe()

Tero Kristo <tero.kristo@linux.intel.com>
    cpufreq: intel_pstate: Fix energy_performance_preference for passive

Arnd Bergmann <arnd@arndb.de>
    ARM: 9303/1: kprobes: avoid missing-declaration warnings

Zhang Rui <rui.zhang@intel.com>
    powercap: RAPL: Fix CONFIG_IOSF_MBI dependency

Robin Murphy <robin.murphy@arm.com>
    perf/arm-cmn: Fix DTC reset

Nikita Zhandarovich <n.zhandarovich@fintech.ru>
    PM: domains: fix integer overflow issues in genpd_parse_state()

Feng Mingxi <m202271825@hust.edu.cn>
    clocksource/drivers/cadence-ttc: Fix memory leak in ttc_timer_probe

Sebastian Andrzej Siewior <bigeasy@linutronix.de>
    tracing/timer: Add missing hrtimer modes to decode_hrtimer_mode().

Thomas Gleixner <tglx@linutronix.de>
    posix-timers: Prevent RT livelock in itimer_delete()

Chuck Lever <chuck.lever@oracle.com>
    svcrdma: Prevent page release when nothing was received

John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
    irqchip/jcore-aic: Fix missing allocation of IRQ descriptors

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

Li Nan <linan122@huawei.com>
    blk-iocost: use spin_lock_irqsave in adjust_inuse_and_calc_cost

Shawn Wang <shawnwang@linux.alibaba.com>
    x86/resctrl: Only show tasks' pid in current pid namespace

Arnd Bergmann <arnd@arndb.de>
    fs: pipe: reveal missing function protoypes

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: drop map element references from preparation phase


-------------

Diffstat:

 .../admin-guide/device-mapper/dm-init.rst          |    8 +
 Documentation/arm64/silicon-errata.rst             |    4 +
 Documentation/filesystems/autofs-mount-control.rst |    2 +-
 Documentation/filesystems/autofs.rst               |    2 +-
 Documentation/filesystems/directory-locking.rst    |   26 +-
 Documentation/networking/af_xdp.rst                |    9 +
 Makefile                                           |    4 +-
 arch/arc/include/asm/linkage.h                     |    8 +-
 arch/arm/boot/dts/bcm53015-meraki-mr26.dts         |    2 +-
 arch/arm/boot/dts/bcm53016-meraki-mr32.dts         |    2 +-
 arch/arm/boot/dts/bcm5301x.dtsi                    |    1 -
 arch/arm/boot/dts/iwg20d-q7-common.dtsi            |    2 +-
 arch/arm/boot/dts/meson8.dtsi                      |    4 +-
 arch/arm/boot/dts/meson8b.dtsi                     |    4 +-
 arch/arm/boot/dts/omap3-gta04a5one.dts             |    4 +-
 arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1-c1.dts    |    8 +-
 arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1.dtsi      |   10 +-
 arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1.dtsi      |   12 +-
 arch/arm/boot/dts/stm32mp15xx-dhcom-pdk2.dtsi      |   11 +-
 arch/arm/boot/dts/stm32mp15xx-dhcor-avenger96.dtsi |    8 +-
 arch/arm/boot/dts/stm32mp15xx-dhcor-som.dtsi       |    6 -
 arch/arm/boot/dts/stm32mp15xx-dkx.dtsi             |    2 +-
 arch/arm/include/asm/assembler.h                   |   17 +
 arch/arm/include/asm/sync_bitops.h                 |   29 +-
 arch/arm/lib/bitops.h                              |   14 +-
 arch/arm/lib/testchangebit.S                       |    4 +
 arch/arm/lib/testclearbit.S                        |    4 +
 arch/arm/lib/testsetbit.S                          |    4 +
 arch/arm/mach-ep93xx/timer-ep93xx.c                |    3 +-
 arch/arm/mach-omap2/board-generic.c                |    1 +
 arch/arm/mach-orion5x/board-dt.c                   |    3 +
 arch/arm/mach-orion5x/common.h                     |    6 +
 arch/arm/probes/kprobes/checkers-common.c          |    2 +-
 arch/arm/probes/kprobes/core.c                     |    2 +-
 arch/arm/probes/kprobes/opt-arm.c                  |    2 -
 arch/arm/probes/kprobes/test-core.c                |    2 +-
 arch/arm/probes/kprobes/test-core.h                |    4 +
 arch/arm64/Kconfig                                 |   41 +
 arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi     |    4 +
 arch/arm64/boot/dts/mediatek/mt8192.dtsi           |   22 +-
 arch/arm64/boot/dts/microchip/sparx5.dtsi          |    2 +-
 .../boot/dts/microchip/sparx5_pcb_common.dtsi      |   12 +
 arch/arm64/boot/dts/qcom/apq8016-sbc.dts           |  840 ++++++++++++++-
 arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi          |  826 ---------------
 arch/arm64/boot/dts/qcom/apq8096-db820c.dts        | 1070 ++++++++++++++++++-
 arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi       | 1105 --------------------
 arch/arm64/boot/dts/qcom/apq8096-ifc6640.dts       |    4 +-
 arch/arm64/boot/dts/qcom/msm8916-mtp.dts           |   15 +-
 arch/arm64/boot/dts/qcom/msm8916-mtp.dtsi          |   21 -
 arch/arm64/boot/dts/qcom/msm8916.dtsi              |    4 +-
 arch/arm64/boot/dts/qcom/msm8994.dtsi              |    2 +-
 arch/arm64/boot/dts/qcom/msm8996-mtp.dts           |   24 +-
 arch/arm64/boot/dts/qcom/msm8996-mtp.dtsi          |   30 -
 arch/arm64/boot/dts/qcom/msm8996.dtsi              |   19 +-
 arch/arm64/boot/dts/qcom/sdm630.dtsi               |    2 +-
 arch/arm64/boot/dts/qcom/sdm845.dtsi               |    2 +-
 .../boot/dts/qcom/sm8250-sony-xperia-edo.dtsi      |    7 +-
 arch/arm64/boot/dts/renesas/ulcb-kf.dtsi           |    3 +-
 .../boot/dts/ti/k3-j7200-common-proc-board.dts     |   28 +-
 arch/arm64/kernel/cpu_errata.c                     |   26 +
 arch/arm64/tools/cpucaps                           |    1 +
 arch/mips/include/asm/kvm_host.h                   |    6 +-
 arch/mips/kernel/cpu-probe.c                       |    9 +-
 arch/mips/kvm/emulate.c                            |   22 +-
 arch/mips/kvm/mips.c                               |   16 +-
 arch/mips/kvm/stats.c                              |    4 +-
 arch/mips/kvm/trace.h                              |    8 +-
 arch/mips/kvm/vz.c                                 |   20 +-
 arch/powerpc/Kconfig.debug                         |    2 +-
 arch/powerpc/Makefile                              |    8 +
 arch/powerpc/kernel/interrupt.c                    |    3 +-
 arch/powerpc/kernel/ppc_save_regs.S                |   61 +-
 arch/powerpc/kernel/security.c                     |   37 +-
 arch/powerpc/kernel/signal_32.c                    |   15 +-
 arch/powerpc/mm/book3s64/radix_pgtable.c           |   34 +-
 arch/powerpc/mm/init_64.c                          |    2 +-
 arch/powerpc/platforms/powernv/pci-sriov.c         |    6 +-
 arch/powerpc/platforms/powernv/vas-window.c        |    2 +-
 arch/powerpc/platforms/pseries/vas.c               |    2 +-
 arch/riscv/kernel/probes/uprobes.c                 |    2 +
 arch/riscv/mm/init.c                               |    6 +-
 arch/riscv/net/bpf_jit.h                           |    5 +-
 arch/riscv/net/bpf_jit_core.c                      |   15 +-
 arch/s390/Makefile                                 |    1 +
 arch/s390/kvm/diag.c                               |    8 +-
 arch/s390/kvm/kvm-s390.c                           |    4 +
 arch/s390/kvm/vsie.c                               |    6 +-
 arch/sh/drivers/dma/dma-sh.c                       |   37 +-
 arch/sh/kernel/cpu/sh2/probe.c                     |    2 +-
 arch/um/Makefile                                   |    2 +-
 arch/x86/events/amd/core.c                         |    2 +-
 arch/x86/events/amd/ibs.c                          |   53 +-
 arch/x86/include/asm/perf_event.h                  |    2 +
 arch/x86/include/asm/pgtable_64.h                  |    4 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c             |    8 +-
 arch/xtensa/platforms/iss/network.c                |    2 +-
 block/blk-iocost.c                                 |    7 +-
 block/disk-events.c                                |    1 +
 block/partitions/amiga.c                           |  104 +-
 drivers/base/power/domain.c                        |    6 +-
 drivers/bus/intel-ixp4xx-eb.c                      |    2 +-
 drivers/bus/ti-sysc.c                              |    4 +-
 drivers/char/hw_random/imx-rngc.c                  |    6 +-
 drivers/char/hw_random/st-rng.c                    |   21 +-
 drivers/char/hw_random/virtio-rng.c                |   88 +-
 drivers/char/tpm/tpm_vtpm_proxy.c                  |   30 +-
 drivers/clk/clk-cdce925.c                          |   12 +
 drivers/clk/clk-si5341.c                           |   38 +-
 drivers/clk/clk-versaclock5.c                      |   29 +
 drivers/clk/clk.c                                  |    1 +
 drivers/clk/imx/clk-imx8mn.c                       |    8 +-
 drivers/clk/imx/clk-imx8mp.c                       |   24 +-
 drivers/clk/imx/clk-scu.c                          |    4 +-
 drivers/clk/keystone/sci-clk.c                     |    2 +
 drivers/clk/qcom/camcc-sc7180.c                    |   19 +-
 drivers/clk/qcom/gcc-ipq6018.c                     |   34 +-
 drivers/clk/qcom/reset.c                           |    8 +-
 drivers/clk/qcom/reset.h                           |    2 +
 drivers/clk/tegra/clk-tegra124-emc.c               |    2 +
 drivers/clk/ti/clkctrl.c                           |    7 +
 drivers/clocksource/timer-cadence-ttc.c            |   19 +-
 drivers/cpufreq/intel_pstate.c                     |    2 +
 drivers/crypto/marvell/cesa/cipher.c               |    2 +-
 drivers/crypto/nx/Makefile                         |    2 +-
 drivers/crypto/nx/nx.h                             |    4 +-
 drivers/crypto/qat/qat_common/adf_common_drv.h     |    5 -
 drivers/crypto/qat/qat_common/qat_algs.c           |   23 +-
 drivers/crypto/qat/qat_common/qat_asym_algs.c      |   53 +-
 drivers/crypto/qat/qat_common/qat_crypto.h         |    5 +
 drivers/dax/bus.c                                  |   61 +-
 drivers/dax/dax-private.h                          |    4 +-
 drivers/dax/kmem.c                                 |    2 +-
 drivers/extcon/extcon-usbc-tusb320.c               |    5 +-
 drivers/extcon/extcon.c                            |    8 +
 drivers/firmware/efi/libstub/efi-stub-helper.c     |    7 +-
 drivers/firmware/stratix10-svc.c                   |    2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c   |    3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             |   28 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c    |   13 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |    2 +
 .../dc/clk_mgr/dcn30/dcn30_clk_mgr_smu_msg.c       |    3 +
 drivers/gpu/drm/amd/display/dc/core/dc.c           |    3 -
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h        |    2 +-
 drivers/gpu/drm/bridge/tc358768.c                  |   93 +-
 drivers/gpu/drm/bridge/ti-sn65dsi86.c              |   33 +-
 drivers/gpu/drm/drm_atomic_helper.c                |   11 +-
 drivers/gpu/drm/drm_gem_vram_helper.c              |    6 +-
 drivers/gpu/drm/i915/display/intel_psr.c           |    4 +-
 drivers/gpu/drm/i915/gt/intel_gtt.c                |    2 +-
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c              |    3 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c           |    5 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c     |   10 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h     |   12 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c        |    8 +-
 drivers/gpu/drm/msm/dp/dp_display.c                |    2 +-
 drivers/gpu/drm/msm/dsi/phy/dsi_phy_14nm.c         |    3 +
 drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c    |   11 +-
 drivers/gpu/drm/panel/panel-simple.c               |    6 +-
 drivers/gpu/drm/radeon/ci_dpm.c                    |   28 +-
 drivers/gpu/drm/radeon/cypress_dpm.c               |    8 +-
 drivers/gpu/drm/radeon/ni_dpm.c                    |    8 +-
 drivers/gpu/drm/radeon/rv740_dpm.c                 |    8 +-
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c        |    8 +-
 drivers/gpu/drm/sun4i/sun4i_tcon.c                 |   19 +-
 drivers/gpu/drm/ttm/ttm_bo.c                       |    7 +
 drivers/hwmon/gsc-hwmon.c                          |    6 +-
 drivers/hwmon/pmbus/adm1275.c                      |   90 +-
 drivers/hwtracing/coresight/coresight-core.c       |    9 +-
 drivers/i2c/busses/i2c-qup.c                       |   21 +-
 drivers/i2c/busses/i2c-xiic.c                      |   39 +-
 drivers/iio/accel/fxls8962af-core.c                |    8 +-
 drivers/iio/adc/ad7192.c                           |    8 +-
 drivers/iio/adc/meson_saradc.c                     |    2 +-
 drivers/infiniband/hw/bnxt_re/main.c               |   20 +-
 drivers/infiniband/hw/bnxt_re/qplib_fp.c           |   40 +-
 drivers/infiniband/hw/bnxt_re/qplib_fp.h           |    2 +-
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c         |   46 +-
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.h         |    1 +
 drivers/infiniband/hw/hfi1/ipoib_tx.c              |    4 +-
 drivers/infiniband/hw/hfi1/mmu_rb.c                |  101 +-
 drivers/infiniband/hw/hfi1/mmu_rb.h                |    3 +
 drivers/infiniband/hw/hfi1/sdma.c                  |   23 +-
 drivers/infiniband/hw/hfi1/sdma.h                  |   47 +-
 drivers/infiniband/hw/hfi1/sdma_txreq.h            |    2 +
 drivers/infiniband/hw/hfi1/user_sdma.c             |  145 +--
 drivers/infiniband/hw/hfi1/user_sdma.h             |    1 -
 drivers/infiniband/hw/hfi1/vnic_sdma.c             |    4 +-
 drivers/infiniband/hw/hns/hns_roce_hem.c           |    7 +-
 drivers/infiniband/hw/irdma/uk.c                   |   10 +-
 drivers/input/misc/adxl34x.c                       |    3 +-
 drivers/input/misc/drv260x.c                       |    1 +
 drivers/irqchip/irq-jcore-aic.c                    |    7 +
 drivers/leds/trigger/ledtrig-netdev.c              |    3 +
 drivers/mailbox/ti-msgmgr.c                        |   12 +-
 drivers/md/bcache/btree.c                          |   25 +-
 drivers/md/bcache/btree.h                          |    1 +
 drivers/md/bcache/super.c                          |    4 +-
 drivers/md/bcache/writeback.c                      |   10 +
 drivers/md/dm-init.c                               |   22 +-
 drivers/md/dm-integrity.c                          |    4 +-
 drivers/md/md-bitmap.c                             |   17 +-
 drivers/md/md.c                                    |    9 +-
 drivers/md/raid0.c                                 |   62 +-
 drivers/md/raid0.h                                 |    1 +
 drivers/md/raid10.c                                |   38 +-
 drivers/media/cec/i2c/Kconfig                      |    1 +
 drivers/media/i2c/st-mipid02.c                     |    9 +-
 drivers/media/platform/qcom/venus/helpers.c        |    4 +-
 drivers/media/usb/dvb-usb-v2/az6007.c              |    3 +-
 drivers/media/usb/siano/smsusb.c                   |    3 +-
 drivers/memory/brcmstb_dpfe.c                      |    4 +-
 drivers/memstick/host/r592.c                       |    4 +-
 drivers/mfd/intel-lpss-acpi.c                      |    3 +
 drivers/mfd/qcom-pm8008.c                          |    1 +
 drivers/mfd/rt5033.c                               |    3 -
 drivers/mfd/stmfx.c                                |    7 +-
 drivers/mfd/stmpe.c                                |    4 +-
 drivers/misc/fastrpc.c                             |    2 +-
 drivers/misc/pci_endpoint_test.c                   |   10 +-
 drivers/mmc/core/quirks.h                          |   14 +
 drivers/mmc/host/mmci.c                            |    1 +
 drivers/mmc/host/sdhci.c                           |    4 +-
 drivers/mtd/nand/raw/meson_nand.c                  |    4 +
 drivers/net/bonding/bond_main.c                    |    2 +-
 drivers/net/dsa/vitesse-vsc73xx-core.c             |    6 +-
 drivers/net/ethernet/amazon/ena/ena_com.c          |    3 +
 drivers/net/ethernet/broadcom/bgmac.c              |    4 +-
 drivers/net/ethernet/broadcom/genet/bcmmii.c       |    2 +
 drivers/net/ethernet/broadcom/tg3.c                |    1 +
 drivers/net/ethernet/google/gve/gve_ethtool.c      |    3 +
 drivers/net/ethernet/ibm/ibmvnic.c                 |    9 +-
 drivers/net/ethernet/intel/igc/igc.h               |   33 +-
 drivers/net/ethernet/intel/igc/igc_ethtool.c       |    2 +
 drivers/net/ethernet/intel/igc/igc_main.c          |   45 +-
 drivers/net/ethernet/intel/igc/igc_ptp.c           |   82 +-
 drivers/net/ethernet/marvell/mvneta.c              |    4 +-
 drivers/net/ethernet/marvell/octeontx2/af/cgx.c    |    7 +
 drivers/net/ethernet/marvell/octeontx2/af/rvu.h    |   11 +
 .../net/ethernet/marvell/octeontx2/af/rvu_cgx.c    |    4 +-
 .../ethernet/marvell/octeontx2/nic/otx2_flows.c    |    8 +
 .../net/ethernet/marvell/octeontx2/nic/otx2_tc.c   |   15 +
 drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c   |    6 +-
 .../ethernet/mellanox/mlx5/core/en_accel/fs_tcp.c  |    1 +
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c    |    6 +-
 drivers/net/ethernet/microchip/lan743x_main.c      |   21 +-
 drivers/net/ethernet/pensando/ionic/ionic_lif.c    |    5 -
 drivers/net/ethernet/sfc/ef10.c                    |   13 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |    6 -
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c  |   10 +-
 drivers/net/gtp.c                                  |    2 +
 drivers/net/ipvlan/ipvlan_core.c                   |    9 +-
 drivers/net/netdevsim/dev.c                        |    9 +-
 drivers/net/ppp/pptp.c                             |   31 +-
 drivers/net/wireguard/netlink.c                    |   14 +-
 drivers/net/wireguard/queueing.c                   |    1 +
 drivers/net/wireguard/queueing.h                   |   25 +-
 drivers/net/wireguard/receive.c                    |    2 +-
 drivers/net/wireguard/send.c                       |    2 +-
 drivers/net/wireless/ath/ath9k/ar9003_hw.c         |   27 +-
 drivers/net/wireless/ath/ath9k/htc_hst.c           |    8 +-
 drivers/net/wireless/ath/ath9k/main.c              |   11 +-
 drivers/net/wireless/ath/ath9k/wmi.c               |    4 +
 drivers/net/wireless/atmel/atmel_cs.c              |   13 +-
 drivers/net/wireless/cisco/airo.c                  |    5 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c       |    5 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c      |    9 +-
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c       |   12 +-
 drivers/net/wireless/intersil/orinoco/orinoco_cs.c |   13 +-
 .../net/wireless/intersil/orinoco/spectrum_cs.c    |   13 +-
 drivers/net/wireless/marvell/mwifiex/scan.c        |    6 +-
 drivers/net/wireless/microchip/wilc1000/hif.c      |    8 +-
 drivers/net/wireless/ray_cs.c                      |   36 +-
 drivers/net/wireless/rsi/rsi_91x_sdio.c            |    9 +-
 drivers/net/wireless/wl3501_cs.c                   |   19 +-
 drivers/ntb/hw/amd/ntb_hw_amd.c                    |    7 +-
 drivers/ntb/hw/idt/ntb_hw_idt.c                    |    7 +-
 drivers/ntb/hw/intel/ntb_hw_gen1.c                 |    7 +-
 drivers/ntb/ntb_transport.c                        |    2 +-
 drivers/ntb/test/ntb_tool.c                        |    2 +
 drivers/nvme/host/pci.c                            |   30 +-
 drivers/nvmem/rmem.c                               |    1 +
 drivers/opp/core.c                                 |    3 +
 drivers/pci/controller/cadence/pcie-cadence-host.c |   27 +
 drivers/pci/controller/dwc/pcie-qcom.c             |    2 +
 drivers/pci/controller/pci-ftpci100.c              |   14 +-
 drivers/pci/controller/pcie-rockchip-ep.c          |   65 +-
 drivers/pci/controller/pcie-rockchip.c             |   17 +
 drivers/pci/controller/pcie-rockchip.h             |   11 +-
 drivers/pci/controller/vmd.c                       |    8 +
 drivers/pci/hotplug/acpiphp_glue.c                 |    5 +-
 drivers/pci/hotplug/pciehp_ctrl.c                  |    8 +
 drivers/pci/pci.c                                  |   10 +-
 drivers/pci/pcie/aspm.c                            |   21 +-
 drivers/pci/quirks.c                               |    2 +
 drivers/perf/arm-cmn.c                             |    7 +-
 drivers/phy/tegra/xusb.c                           |    4 +
 drivers/pinctrl/bcm/pinctrl-bcm2835.c              |    6 +-
 drivers/pinctrl/intel/pinctrl-cherryview.c         |   15 +-
 drivers/pinctrl/pinctrl-amd.c                      |   25 +-
 drivers/pinctrl/pinctrl-amd.h                      |    1 +
 drivers/pinctrl/pinctrl-at91-pio4.c                |    2 +
 drivers/pinctrl/pinctrl-microchip-sgpio.c          |    3 +
 drivers/platform/x86/wmi.c                         |   64 +-
 drivers/powercap/Kconfig                           |    4 +-
 drivers/powercap/intel_rapl_msr.c                  |    1 -
 drivers/pwm/pwm-ab8500.c                           |    2 +-
 drivers/pwm/pwm-imx-tpm.c                          |    7 +
 drivers/pwm/pwm-mtk-disp.c                         |   13 +-
 drivers/pwm/sysfs.c                                |   17 +
 drivers/regulator/core.c                           |   30 +-
 drivers/rtc/rtc-st-lpc.c                           |    2 +-
 drivers/s390/net/qeth_l3_sys.c                     |    2 +-
 drivers/scsi/3w-xxxx.c                             |    4 +-
 drivers/scsi/qedf/qedf_main.c                      |    3 +-
 drivers/scsi/qla2xxx/qla_attr.c                    |   13 +
 drivers/scsi/qla2xxx/qla_bsg.c                     |    6 +
 drivers/scsi/qla2xxx/qla_def.h                     |    1 -
 drivers/scsi/qla2xxx/qla_edif.c                    |    4 +-
 drivers/scsi/qla2xxx/qla_init.c                    |    2 +-
 drivers/scsi/qla2xxx/qla_inline.h                  |    5 +-
 drivers/scsi/qla2xxx/qla_iocb.c                    |    5 +-
 drivers/scsi/qla2xxx/qla_nvme.c                    |    3 -
 drivers/scsi/qla2xxx/qla_os.c                      |    3 +-
 drivers/soc/amlogic/meson-secure-pwrc.c            |    2 +-
 drivers/soc/fsl/qe/Kconfig                         |    1 +
 drivers/soundwire/qcom.c                           |    3 +-
 drivers/spi/spi-bcm-qspi.c                         |   10 +-
 drivers/spi/spi-dw-core.c                          |    5 +-
 drivers/spi/spi-geni-qcom.c                        |    2 +-
 .../clocking-wizard/clk-xlnx-clock-wizard.c        |    2 +-
 .../media/atomisp/pci/atomisp_gmin_platform.c      |    2 +-
 drivers/thermal/sun8i_thermal.c                    |   55 +-
 drivers/tty/serial/8250/8250.h                     |    1 -
 drivers/tty/serial/8250/8250_omap.c                |   25 +-
 drivers/tty/serial/8250/8250_pci.c                 |   19 -
 drivers/tty/serial/8250/8250_port.c                |   11 +-
 drivers/tty/serial/atmel_serial.c                  |    4 +-
 drivers/tty/serial/fsl_lpuart.c                    |    1 +
 drivers/tty/serial/imx.c                           |   18 +-
 drivers/tty/serial/samsung_tty.c                   |   14 +-
 drivers/usb/core/devio.c                           |    2 +
 drivers/usb/dwc2/platform.c                        |   18 +-
 drivers/usb/dwc3/dwc3-meson-g12a.c                 |    5 +-
 drivers/usb/dwc3/dwc3-qcom.c                       |   17 +-
 drivers/usb/dwc3/gadget.c                          |    4 +-
 drivers/usb/gadget/function/u_serial.c             |   13 +-
 drivers/usb/host/xhci-mem.c                        |   39 +-
 drivers/usb/host/xhci-pci.c                        |   12 +
 drivers/usb/host/xhci.h                            |    2 +
 drivers/usb/phy/phy-tahvo.c                        |    2 +-
 drivers/usb/serial/option.c                        |    4 +
 drivers/video/fbdev/omap/lcd_mipid.c               |    6 +-
 drivers/w1/slaves/w1_therm.c                       |   31 +-
 drivers/w1/w1.c                                    |    4 +-
 fs/btrfs/block-group.c                             |   36 +-
 fs/btrfs/ctree.c                                   |   28 +-
 fs/btrfs/qgroup.c                                  |    2 +
 fs/ceph/caps.c                                     |    9 +
 fs/cifs/file.c                                     |   25 +-
 fs/dlm/plock.c                                     |    4 +-
 fs/erofs/inode.c                                   |    5 +-
 fs/erofs/internal.h                                |   16 +-
 fs/erofs/super.c                                   |   58 +-
 fs/erofs/xattr.c                                   |    4 +-
 fs/erofs/zdata.c                                   |   10 +-
 fs/erofs/zmap.c                                    |    6 +-
 fs/ext4/indirect.c                                 |    8 +
 fs/ext4/inode.c                                    |   10 -
 fs/ext4/ioctl.c                                    |    5 +-
 fs/ext4/mballoc.c                                  |   17 +-
 fs/ext4/namei.c                                    |   17 +-
 fs/ext4/super.c                                    |   19 +-
 fs/f2fs/f2fs.h                                     |    2 +-
 fs/f2fs/file.c                                     |    2 +-
 fs/f2fs/gc.c                                       |   21 +-
 fs/f2fs/namei.c                                    |   16 +-
 fs/f2fs/node.c                                     |    4 +-
 fs/fs_context.c                                    |    3 +-
 fs/inode.c                                         |   42 +
 fs/internal.h                                      |    2 +
 fs/jffs2/build.c                                   |    5 +-
 fs/jffs2/xattr.c                                   |   13 +-
 fs/jffs2/xattr.h                                   |    4 +-
 fs/jfs/jfs_dmap.c                                  |    6 +
 fs/jfs/jfs_filsys.h                                |    2 +
 fs/kernfs/dir.c                                    |    2 +
 fs/ksmbd/server.c                                  |   33 +-
 fs/ksmbd/smb2misc.c                                |   38 +-
 fs/ksmbd/smb2pdu.c                                 |   44 +-
 fs/ksmbd/smb_common.c                              |    2 +-
 fs/namei.c                                         |   25 +-
 fs/nfs/nfs4proc.c                                  |    1 +
 fs/nfsd/nfs4xdr.c                                  |    2 +-
 fs/notify/fanotify/fanotify_user.c                 |   22 +-
 fs/ntfs3/index.c                                   |   84 +-
 fs/ntfs3/inode.c                                   |   18 +-
 fs/ntfs3/ntfs_fs.h                                 |    4 +-
 fs/ntfs3/run.c                                     |    7 +-
 fs/ntfs3/xattr.c                                   |  112 +-
 fs/overlayfs/copy_up.c                             |    2 +
 fs/overlayfs/dir.c                                 |    3 +-
 fs/overlayfs/export.c                              |    3 +-
 fs/overlayfs/inode.c                               |   10 +-
 fs/overlayfs/namei.c                               |    3 +-
 fs/overlayfs/overlayfs.h                           |    6 +-
 fs/overlayfs/super.c                               |    2 +-
 fs/overlayfs/util.c                                |   24 +-
 fs/pstore/ram_core.c                               |    2 +
 fs/ramfs/inode.c                                   |    2 +-
 include/acpi/acpi_bus.h                            |    3 +-
 include/crypto/internal/kpp.h                      |    6 +
 include/linux/bootmem_info.h                       |    2 +
 include/linux/can/length.h                         |   14 +-
 include/linux/netdevice.h                          |    9 +
 include/linux/nmi.h                                |    2 +-
 include/linux/pci.h                                |    1 +
 include/linux/pipe_fs_i.h                          |    4 -
 include/linux/ramfs.h                              |    1 +
 include/linux/serial_8250.h                        |    1 -
 include/linux/workqueue.h                          |   15 +-
 include/net/netfilter/nf_tables.h                  |    5 +-
 include/net/pkt_sched.h                            |    2 +-
 include/net/sock.h                                 |    1 +
 include/trace/events/timer.h                       |    6 +-
 include/uapi/linux/affs_hardblocks.h               |   68 +-
 include/uapi/linux/auto_dev-ioctl.h                |    2 +-
 include/uapi/linux/videodev2.h                     |    2 +-
 io_uring/io_uring.c                                |   66 +-
 kernel/bpf/cgroup.c                                |   15 +
 kernel/bpf/cpumap.c                                |   40 +-
 kernel/bpf/verifier.c                              |    5 +-
 kernel/kcsan/core.c                                |    2 +
 kernel/kexec_core.c                                |    5 +-
 kernel/rcu/rcuscale.c                              |  212 ++--
 kernel/time/posix-timers.c                         |   43 +-
 kernel/trace/ftrace.c                              |   45 +-
 kernel/trace/ring_buffer.c                         |   24 +-
 kernel/trace/trace.c                               |    3 +-
 kernel/trace/trace_eprobe.c                        |   18 +-
 kernel/trace/trace_events_hist.c                   |    8 +-
 kernel/trace/trace_probe_tmpl.h                    |   14 +-
 kernel/watchdog_hld.c                              |    6 +-
 kernel/workqueue.c                                 |   13 +-
 lib/test_firmware.c                                |   12 +-
 lib/ts_bm.c                                        |    4 +-
 mm/damon/vaddr.c                                   |   20 +-
 mm/shmem.c                                         |    2 +-
 net/bridge/br_if.c                                 |    5 +-
 net/ceph/messenger_v2.c                            |   41 +-
 net/core/filter.c                                  |  131 ++-
 net/core/rtnetlink.c                               |  104 +-
 net/core/skbuff.c                                  |    5 +
 net/core/sock.c                                    |   17 +-
 net/dsa/tag_sja1105.c                              |    4 +-
 net/ipv4/tcp_input.c                               |   12 +-
 net/ipv6/addrconf.c                                |    3 +-
 net/ipv6/icmp.c                                    |    5 +-
 net/ipv6/udp.c                                     |    2 +-
 net/netfilter/ipvs/Kconfig                         |   27 +-
 net/netfilter/ipvs/ip_vs_conn.c                    |    4 +-
 net/netfilter/nf_conntrack_helper.c                |    4 +
 net/netfilter/nf_conntrack_proto_dccp.c            |   52 +-
 net/netfilter/nf_conntrack_sip.c                   |    2 +-
 net/netfilter/nf_tables_api.c                      |  158 ++-
 net/netfilter/nft_byteorder.c                      |   14 +-
 net/netfilter/nft_set_bitmap.c                     |    5 +-
 net/netfilter/nft_set_hash.c                       |   23 +-
 net/netfilter/nft_set_pipapo.c                     |   14 +-
 net/netfilter/nft_set_rbtree.c                     |    5 +-
 net/netlink/af_netlink.c                           |    5 +-
 net/netlink/diag.c                                 |    7 +-
 net/nfc/llcp.h                                     |    1 -
 net/nfc/llcp_commands.c                            |   15 +-
 net/nfc/llcp_core.c                                |   49 +-
 net/nfc/llcp_sock.c                                |   21 +-
 net/nfc/netlink.c                                  |   20 +-
 net/nfc/nfc.h                                      |    1 +
 net/sched/act_ipt.c                                |   27 +-
 net/sched/act_pedit.c                              |    1 +
 net/sched/cls_flower.c                             |   10 +
 net/sched/cls_fw.c                                 |   10 +-
 net/sched/sch_qfq.c                                |   41 +-
 net/sctp/socket.c                                  |   22 +-
 net/sunrpc/svcsock.c                               |   23 +-
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c            |   12 +-
 net/wireless/scan.c                                |  213 ++--
 net/xdp/xsk.c                                      |    5 +
 samples/bpf/tcp_basertt_kern.c                     |    2 +-
 samples/ftrace/ftrace-direct-too.c                 |   14 +-
 scripts/Makefile.modfinal                          |    2 +-
 scripts/mod/modpost.c                              |   86 +-
 security/apparmor/policy_unpack.c                  |    9 +-
 security/integrity/evm/evm_crypto.c                |    2 +-
 security/integrity/evm/evm_main.c                  |    4 +-
 security/integrity/iint.c                          |   15 +-
 security/integrity/ima/ima_modsig.c                |    3 +
 security/integrity/ima/ima_policy.c                |    3 +-
 sound/core/jack.c                                  |   15 +-
 sound/pci/ac97/ac97_codec.c                        |    4 +-
 sound/pci/hda/patch_realtek.c                      |    1 +
 sound/soc/codecs/es8316.c                          |   23 +-
 sound/soc/fsl/imx-audmix.c                         |    9 +
 sound/soc/mediatek/mt8173/mt8173-afe-pcm.c         |   13 +-
 tools/bpf/bpftool/feature.c                        |   24 +-
 tools/lib/bpf/bpf_helpers.h                        |   15 +-
 tools/lib/bpf/btf_dump.c                           |   22 +-
 tools/perf/builtin-bench.c                         |    7 +-
 tools/perf/builtin-script.c                        |   16 +-
 tools/perf/tests/builtin-test.c                    |    3 +
 tools/perf/util/dwarf-aux.c                        |    2 +-
 tools/testing/selftests/bpf/prog_tests/check_mtu.c |    2 +-
 tools/testing/selftests/net/mptcp/config           |    1 +
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh |    9 +-
 tools/testing/selftests/net/rtnetlink.sh           |    1 +
 .../rcutorture/configs/rcu/BUSTED-BOOST.boot       |    2 +-
 .../selftests/rcutorture/configs/rcu/TREE03.boot   |    2 +-
 .../selftests/vDSO/vdso_test_clock_getres.c        |    4 +-
 tools/testing/selftests/wireguard/netns.sh         |   30 +-
 518 files changed, 6687 insertions(+), 4483 deletions(-)


