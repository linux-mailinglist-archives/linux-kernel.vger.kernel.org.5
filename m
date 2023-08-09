Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A33EE77573E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 12:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbjHIKnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 06:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjHIKnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 06:43:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7857E10F3;
        Wed,  9 Aug 2023 03:43:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 06BAC6311F;
        Wed,  9 Aug 2023 10:43:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A781FC433C7;
        Wed,  9 Aug 2023 10:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691577827;
        bh=WNL1T+qlfgCWrpRCjd3t3EZNJLhbgehsTsxvOkhvv7k=;
        h=From:To:Cc:Subject:Date:From;
        b=TKu4RGeSPz1yCM2Wi4MNJpC4v6Hayl60Qa5fN+6ASm2l5EFTnngxS1bUYr4sBABo9
         j0wYzTICMGhD9KLcRR0fgU1p4llfQ8G9dLRa+Yd5pDET0uQ8mhY7iMIchvUbIoT1SY
         LiAKzOXD2UzS4AXv+hWX4KOESbpcVS2NnvNHR2N8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: [PATCH 6.4 000/165] 6.4.10-rc1 review
Date:   Wed,  9 Aug 2023 12:38:51 +0200
Message-ID: <20230809103642.720851262@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.4.10-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.4.10-rc1
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

This is the start of the stable review cycle for the 6.4.10 release.
There are 165 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Fri, 11 Aug 2023 10:36:10 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.4.10-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.4.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 6.4.10-rc1

Andi Shyti <andi.shyti@linux.intel.com>
    drm/i915/gt: Enable the CCS_FLUSH bit in the pipe control and in the CS

Andi Shyti <andi.shyti@linux.intel.com>
    drm/i915/gt: Support aux invalidation on all engines

Jonathan Cavitt <jonathan.cavitt@intel.com>
    drm/i915/gt: Poll aux invalidation register bit on invalidation

Andi Shyti <andi.shyti@linux.intel.com>
    drm/i915/gt: Rename flags with bit_group_X according to the datasheet

Tejas Upadhyay <tejas.upadhyay@intel.com>
    drm/i915/gt: Add workaround 14016712196

Jonathan Cavitt <jonathan.cavitt@intel.com>
    drm/i915/gt: Ensure memory quiesced before invalidation

Andi Shyti <andi.shyti@linux.intel.com>
    drm/i915: Add the gen12_needs_ccs_aux_inv helper

Xu Yang <xu.yang_2@nxp.com>
    ARM: dts: nxp/imx6sll: fix wrong property name in usbphy node

Sean Christopherson <seanjc@google.com>
    selftests/rseq: Play nice with binaries statically linked against glibc 2.35+

Lijo Lazar <lijo.lazar@amd.com>
    drm/amdgpu: Use apt name for FW reserved region

Alexander Stein <alexander.stein@ew.tq-group.com>
    drm/imx/ipuv3: Fix front porch adjustment upon hactive aligning

Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
    powerpc/mm/altmap: Fix altmap boundary check

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    mtd: rawnand: fsl_upm: Fix an off-by one test in fun_exec_op()

Arnd Bergmann <arnd@arndb.de>
    mtd: spi-nor: avoid holes in struct spi_mem_op

Chen-Yu Tsai <wenst@chromium.org>
    clk: mediatek: mt8183: Add back SSPM related clocks

Johan Jonker <jbx6244@gmail.com>
    mtd: rawnand: rockchip: Align hwecc vs. raw page helper layouts

Johan Jonker <jbx6244@gmail.com>
    mtd: rawnand: rockchip: fix oobfree offset and description

Roger Quadros <rogerq@kernel.org>
    mtd: rawnand: omap_elm: Fix incorrect type in assignment

Pavel Begunkov <asml.silence@gmail.com>
    io_uring: annotate offset timeout races

Chao Yu <chao@kernel.org>
    f2fs: fix to do sanity check on direct node in truncate_dnode()

Filipe Manana <fdmanana@suse.com>
    btrfs: remove BUG_ON()'s in add_new_free_space()

Jan Kara <jack@suse.cz>
    ext2: Drop fragment support

Jason Gunthorpe <jgg@ziepe.ca>
    mm/gup: do not return 0 from pin_user_pages_fast() for bad args

Jan Kara <jack@suse.cz>
    fs: Protect reconfiguration of sb read-write from racing writes

Alan Stern <stern@rowland.harvard.edu>
    net: usbnet: Fix WARNING in usbnet_start_xmit/usb_submit_urb

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    debugobjects: Recheck debug_objects_enabled before reporting

Sungwoo Kim <iam@sung-woo.kim>
    Bluetooth: L2CAP: Fix use-after-free in l2cap_sock_ready_cb

Prince Kumar Maurya <princekumarmaurya06@gmail.com>
    fs/sysv: Null check to prevent null-ptr-deref bug

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    kasan,kmsan: remove __GFP_KSWAPD_RECLAIM usage from kasan/kmsan

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    fs/ntfs3: Use __GFP_NOWARN allocation at ntfs_load_attr_list()

Roman Gushchin <roman.gushchin@linux.dev>
    mm: kmem: fix a NULL pointer dereference in obj_stock_flush_required()

Linus Torvalds <torvalds@linux-foundation.org>
    file: reinstate f_pos locking optimization for regular files

Geert Uytterhoeven <geert+renesas@glider.be>
    clk: imx93: Propagate correct error in imx93_clocks_probe()

Stephen Rothwell <sfr@canb.auug.org.au>
    sunvnet: fix sparc64 build error after gso code split

Mike Kravetz <mike.kravetz@oracle.com>
    Revert "page cache: fix page_cache_next/prev_miss off by one"

Andi Shyti <andi.shyti@linux.intel.com>
    drm/i915/gt: Cleanup aux invalidation registers

Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
    drm/i915: Fix premature release of request's reusable memory

Guchun Chen <guchun.chen@amd.com>
    drm/ttm: check null pointer before accessing when swapping

Aleksa Sarai <cyphar@cyphar.com>
    open: make RESOLVE_CACHED correctly test for O_TMPFILE

Mark Brown <broonie@kernel.org>
    arm64/ptrace: Don't enable SVE when setting streaming SVE

Mark Brown <broonie@kernel.org>
    arm64/ptrace: Flush FP state when setting ZT0

Mark Brown <broonie@kernel.org>
    arm64/fpsimd: Sync FPSIMD state with SVE for SME only systems

Mark Brown <broonie@kernel.org>
    arm64/fpsimd: Clear SME state in the target task when setting the VL

Mark Brown <broonie@kernel.org>
    arm64/fpsimd: Sync and zero pad FPSIMD state for streaming SVE

Mike Rapoport (IBM) <rppt@kernel.org>
    parisc/mm: preallocate fixmap page tables at init

Naveen N Rao <naveen@kernel.org>
    powerpc/ftrace: Create a dummy stackframe to fix stack unwind

Paulo Alcantara <pc@manguebit.com>
    smb: client: fix dfs link mount against w2k8

Jiri Olsa <jolsa@kernel.org>
    bpf: Disable preemption in bpf_event_output

Ilya Dryomov <idryomov@gmail.com>
    rbd: prevent busy loop when requesting exclusive lock

Michael Kelley <mikelley@microsoft.com>
    x86/hyperv: Disable IBT when hypercall page lacks ENDBR instruction

Paul Fertser <fercerpav@gmail.com>
    wifi: mt76: mt7615: do not advertise 5 GHz on first phy of MT7615D (DBDC)

Laszlo Ersek <lersek@redhat.com>
    net: tap_open(): set sk_uid from current_fsuid()

Laszlo Ersek <lersek@redhat.com>
    net: tun_chr_open(): set sk_uid from current_fsuid()

Dinh Nguyen <dinguyen@kernel.org>
    arm64: dts: stratix10: fix incorrect I2C property for SCL signal

Jiri Olsa <jolsa@kernel.org>
    bpf: Disable preemption in bpf_perf_event_output

Song Shuai <suagrfillet@gmail.com>
    riscv: Export va_kernel_pa_offset in vmcoreinfo

Arseniy Krasnov <AVKrasnov@sberdevices.ru>
    mtd: rawnand: meson: fix OOB available bytes for ECC

Olivier Maignial <olivier.maignial@hotmail.fr>
    mtd: spinand: winbond: Fix ecc_get_status

Olivier Maignial <olivier.maignial@hotmail.fr>
    mtd: spinand: toshiba: Fix ecc_get_status

Sungjong Seo <sj1557.seo@samsung.com>
    exfat: release s_lock before calling dir_emit()

Namjae Jeon <linkinjeon@kernel.org>
    exfat: check if filename entries exceeds max filename length

gaoming <gaoming20@hihonor.com>
    exfat: use kvmalloc_array/kvfree instead of kmalloc_array/kfree

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    firmware: arm_scmi: Drop OF node reference in the transport channel setup

Xiubo Li <xiubli@redhat.com>
    ceph: defer stopping mdsc delayed_work

Ross Maynard <bids.7405@bigpond.com>
    USB: zaurus: Add ID for A-300/B-500/C-700

Ilya Dryomov <idryomov@gmail.com>
    libceph: fix potential hang in ceph_osdc_notify()

Song Shuai <suagrfillet@gmail.com>
    Documentation: kdump: Add va_kernel_pa_offset for RISCV64

Michael Kelley <mikelley@microsoft.com>
    scsi: storvsc: Limit max_sectors for virtual Fibre Channel devices

Steffen Maier <maier@linux.ibm.com>
    scsi: zfcp: Defer fc_rport blocking until after ADISC response

Boqun Feng <boqun.feng@gmail.com>
    rust: allocator: Prevent mis-aligned allocation

Stefano Garzarella <sgarzare@redhat.com>
    test/vsock: remove vsock_perf executable on `make clean`

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

Jonas Gorski <jonas.gorski@bisdn.de>
    prestera: fix fallback to previous version on same major version

Leon Romanovsky <leon@kernel.org>
    net/mlx5e: Set proper IPsec source port in L4 selector

Jianbo Liu <jianbol@nvidia.com>
    net/mlx5: fs_core: Skip the FTs in the same FS_TYPE_PRIO_CHAINS fs_prio

Jianbo Liu <jianbol@nvidia.com>
    net/mlx5: fs_core: Make find_closest_ft more generic

Benjamin Poirier <bpoirier@nvidia.com>
    vxlan: Fix nexthop hash size

Yue Haibing <yuehaibing@huawei.com>
    ip6mr: Fix skb_under_panic in ip6mr_cache_report()

Alexandra Winter <wintera@linux.ibm.com>
    s390/qeth: Don't call dev_close/dev_open (DOWN/UP)

Lin Ma <linma@zju.edu.cn>
    net: dcb: choose correct policy to parse DCB_ATTR_BCN

Michael Chan <michael.chan@broadcom.com>
    bnxt_en: Fix max_mtu setting for multi-buf XDP

Somnath Kotur <somnath.kotur@broadcom.com>
    bnxt_en: Fix page pool logic for page size >= 64K

Kuniyuki Iwashima <kuniyu@amazon.com>
    selftest: net: Assert on a proper value in so_incoming_cpu.c.

Mark Brown <broonie@kernel.org>
    net: netsec: Ignore 'phy-mode' on SynQuacer in DT mode

Yuanjun Gong <ruc_gongyuanjun@163.com>
    net: korina: handle clk prepare error in korina_probe()

Dan Carpenter <dan.carpenter@linaro.org>
    net: ll_temac: fix error checking of irq_of_parse_and_map()

Tomas Glozar <tglozar@redhat.com>
    bpf: sockmap: Remove preempt_disable in sock_map_sk_acquire

valis <sec@valis.email>
    net/sched: cls_route: No longer copy tcf_result on update to avoid use-after-free

valis <sec@valis.email>
    net/sched: cls_fw: No longer copy tcf_result on update to avoid use-after-free

valis <sec@valis.email>
    net/sched: cls_u32: No longer copy tcf_result on update to avoid use-after-free

Hou Tao <houtao1@huawei.com>
    bpf, cpumap: Handle skb as well when clean up ptr_ring

Hou Tao <houtao1@huawei.com>
    bpf, cpumap: Make sure kthread is running before map update returns

Andrii Nakryiko <andrii@kernel.org>
    bpf: Centralize permissions checks for all BPF map types

Andrii Nakryiko <andrii@kernel.org>
    bpf: Inline map creation logic in map_create() function

Andrii Nakryiko <andrii@kernel.org>
    bpf: Move unprivileged checks into map_create() and bpf_prog_load()

Michal Schmidt <mschmidt@redhat.com>
    octeon_ep: initialize mbox mutexes

Jakub Kicinski <kuba@kernel.org>
    bnxt: don't handle XDP in netpoll

Rafal Rogalski <rafalx.rogalski@intel.com>
    ice: Fix RDMA VSI removal during queue rebuild

Duoming Zhou <duoming@zju.edu.cn>
    net: usb: lan78xx: reorder cleanup operations to avoid UAF bugs

Kuniyuki Iwashima <kuniyu@amazon.com>
    net/sched: taprio: Limit TCA_TAPRIO_ATTR_SCHED_CYCLE_TIME to INT_MAX.

Eric Dumazet <edumazet@google.com>
    net: annotate data-races around sk->sk_priority

Eric Dumazet <edumazet@google.com>
    net: add missing data-race annotation for sk_ll_usec

Eric Dumazet <edumazet@google.com>
    net: add missing data-race annotations around sk->sk_peek_off

Eric Dumazet <edumazet@google.com>
    net: annotate data-races around sk->sk_mark

Eric Dumazet <edumazet@google.com>
    net: add missing READ_ONCE(sk->sk_rcvbuf) annotation

Eric Dumazet <edumazet@google.com>
    net: add missing READ_ONCE(sk->sk_sndbuf) annotation

Eric Dumazet <edumazet@google.com>
    net: add missing READ_ONCE(sk->sk_rcvlowat) annotation

Eric Dumazet <edumazet@google.com>
    net: annotate data-races around sk->sk_max_pacing_rate

Eric Dumazet <edumazet@google.com>
    net: annotate data-race around sk->sk_txrehash

Eric Dumazet <edumazet@google.com>
    net: annotate data-races around sk->sk_reserved_mem

Richard Gobert <richardbgobert@gmail.com>
    net: gro: fix misuse of CB in udp socket lookup

Eric Dumazet <edumazet@google.com>
    net: move gso declarations and functions to their own files

Konstantin Khorenko <khorenko@virtuozzo.com>
    qed: Fix scheduling in a tasklet while getting stats

Thierry Reding <treding@nvidia.com>
    net: stmmac: tegra: Properly allocate clock bulk data

Chengfeng Ye <dg573847474@gmail.com>
    mISDN: hfcpci: Fix potential deadlock on &hc->lock

Jamal Hadi Salim <jhs@mojatatu.com>
    net: sched: cls_u32: Fix match key mis-addressing

Georg Müller <georgmueller@gmx.net>
    perf test uprobe_from_different_cu: Skip if there is no gcc

Yuanjun Gong <ruc_gongyuanjun@163.com>
    net: dsa: fix value check in bcm_sf2_sw_probe()

Lin Ma <linma@zju.edu.cn>
    rtnetlink: let rtnl_bridge_setlink checks IFLA_BRIDGE_MODE length

Lin Ma <linma@zju.edu.cn>
    bpf: Add length check for SK_DIAG_BPF_STORAGE_REQ_MAP_FD parsing

Shay Drory <shayd@nvidia.com>
    net/mlx5: Unregister devlink params in case interface is down

Chris Mi <cmi@nvidia.com>
    net/mlx5: fs_chains: Fix ft prio if ignore_flow_level is not supported

Jianbo Liu <jianbol@nvidia.com>
    net/mlx5e: kTLS, Fix protection domain in use syndrome when devlink reload

Dragos Tatulea <dtatulea@nvidia.com>
    net/mlx5e: xsk: Fix crash on regular rq reactivation

Dragos Tatulea <dtatulea@nvidia.com>
    net/mlx5e: xsk: Fix invalid buffer access for legacy rq

Jianbo Liu <jianbol@nvidia.com>
    net/mlx5e: Move representor neigh cleanup to profile cleanup_tx

Amir Tzin <amirtz@nvidia.com>
    net/mlx5e: Fix crash moving to switchdev mode when ntuple offload is set

Chris Mi <cmi@nvidia.com>
    net/mlx5e: Don't hold encap tbl lock if there is no encap action

Shay Drory <shayd@nvidia.com>
    net/mlx5: Honor user input for migratable port fn attr

Yuanjun Gong <ruc_gongyuanjun@163.com>
    net/mlx5e: fix return value check in mlx5e_ipsec_remove_trailer()

Zhengchao Shao <shaozhengchao@huawei.com>
    net/mlx5: fix potential memory leak in mlx5e_init_rep_rx

Zhengchao Shao <shaozhengchao@huawei.com>
    net/mlx5: DR, fix memory leak in mlx5dr_cmd_create_reformat_ctx

Zhengchao Shao <shaozhengchao@huawei.com>
    net/mlx5e: fix double free in macsec_fs_tx_create_crypto_table_groups

Ilan Peer <ilan.peer@intel.com>
    wifi: cfg80211: Fix return value in scan logic

Haixin Yu <yuhaixin.yhx@linux.alibaba.com>
    perf pmu arm64: Fix reading the PMU cpu slots in sysfs

Gao Xiang <xiang@kernel.org>
    erofs: fix wrong primary bvec selection on deduplicated extents

Heiko Carstens <hca@linux.ibm.com>
    KVM: s390: fix sthyi error handling

Sven Schnelle <svens@linux.ibm.com>
    s390/vmem: split pages when debug pagealloc is enabled

ndesaulniers@google.com <ndesaulniers@google.com>
    word-at-a-time: use the same return type for has_zero regardless of endianness

Durai Manickam KR <durai.manickamkr@microchip.com>
    ARM: dts: at91: sam9x60: fix the SOC detection

Claudiu Beznea <claudiu.beznea@microchip.com>
    ARM: dts: at91: use generic name for shutdown controller

Claudiu Beznea <claudiu.beznea@microchip.com>
    ARM: dts: at91: use clock-controller name for sckc nodes

Claudiu Beznea <claudiu.beznea@microchip.com>
    ARM: dts: at91: use clock-controller name for PMC nodes

Cristian Marussi <cristian.marussi@arm.com>
    firmware: arm_scmi: Fix chan_free cleanup on SMC

Lucas Stach <l.stach@pengutronix.de>
    soc: imx: imx8mp-blk-ctrl: register HSIO PLL clock as bus_power_dev child

Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
    ARM: dts: nxp/imx: limit sk-imx53 supported frequencies

Yury Norov <yury.norov@gmail.com>
    lib/bitmap: workaround const_eval test build failure

Sukrut Bellary <sukrut.bellary@linux.com>
    firmware: arm_scmi: Fix signed error return values handling

Punit Agrawal <punit.agrawal@bytedance.com>
    firmware: smccc: Fix use of uninitialised results structure

Benjamin Gaignard <benjamin.gaignard@collabora.com>
    arm64: dts: freescale: Fix VPU G2 clock

Hugo Villeneuve <hvilleneuve@dimonoff.com>
    arm64: dts: imx8mn-var-som: add missing pull-up for onboard PHY reset pinmux

Yashwanth Varakala <y.varakala@phytec.de>
    arm64: dts: phycore-imx8mm: Correction in gpio-line-names

Yashwanth Varakala <y.varakala@phytec.de>
    arm64: dts: phycore-imx8mm: Label typo-fix of VPU

Tim Harvey <tharvey@gateworks.com>
    arm64: dts: imx8mm-venice-gw7904: disable disp_blk_ctrl

Tim Harvey <tharvey@gateworks.com>
    arm64: dts: imx8mm-venice-gw7903: disable disp_blk_ctrl

Robin Murphy <robin.murphy@arm.com>
    iommu/arm-smmu-v3: Document nesting-related errata

Robin Murphy <robin.murphy@arm.com>
    iommu/arm-smmu-v3: Add explicit feature for nesting

Robin Murphy <robin.murphy@arm.com>
    iommu/arm-smmu-v3: Document MMU-700 erratum 2812531

Robin Murphy <robin.murphy@arm.com>
    iommu/arm-smmu-v3: Work around MMU-600 erratum 1076982

Jann Horn <jannh@google.com>
    mm: lock_vma_under_rcu() must check vma->anon_vma under vma lock


-------------

Diffstat:

 Documentation/admin-guide/kdump/vmcoreinfo.rst     |   6 +
 Documentation/arm64/silicon-errata.rst             |   4 +
 Makefile                                           |   4 +-
 arch/arm/boot/dts/at91-qil_a9260.dts               |   2 +-
 arch/arm/boot/dts/at91-sama5d27_som1_ek.dts        |   2 +-
 arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts          |   2 +-
 arch/arm/boot/dts/at91-sama5d2_xplained.dts        |   2 +-
 arch/arm/boot/dts/at91rm9200.dtsi                  |   2 +-
 arch/arm/boot/dts/at91sam9260.dtsi                 |   4 +-
 arch/arm/boot/dts/at91sam9260ek.dts                |   2 +-
 arch/arm/boot/dts/at91sam9261.dtsi                 |   4 +-
 arch/arm/boot/dts/at91sam9263.dtsi                 |   4 +-
 arch/arm/boot/dts/at91sam9g20.dtsi                 |   2 +-
 arch/arm/boot/dts/at91sam9g20ek_common.dtsi        |   2 +-
 arch/arm/boot/dts/at91sam9g25.dtsi                 |   2 +-
 arch/arm/boot/dts/at91sam9g35.dtsi                 |   2 +-
 arch/arm/boot/dts/at91sam9g45.dtsi                 |   6 +-
 arch/arm/boot/dts/at91sam9n12.dtsi                 |   4 +-
 arch/arm/boot/dts/at91sam9rl.dtsi                  |   6 +-
 arch/arm/boot/dts/at91sam9x25.dtsi                 |   2 +-
 arch/arm/boot/dts/at91sam9x35.dtsi                 |   2 +-
 arch/arm/boot/dts/at91sam9x5.dtsi                  |   6 +-
 arch/arm/boot/dts/imx53-sk-imx53.dts               |  10 +
 arch/arm/boot/dts/imx6sll.dtsi                     |   2 +-
 arch/arm/boot/dts/sam9x60.dtsi                     |  32 +--
 arch/arm/boot/dts/sama5d2.dtsi                     |   6 +-
 arch/arm/boot/dts/sama5d3.dtsi                     |   6 +-
 arch/arm/boot/dts/sama5d3_emac.dtsi                |   2 +-
 arch/arm/boot/dts/sama5d4.dtsi                     |   6 +-
 arch/arm/boot/dts/sama7g5.dtsi                     |   4 +-
 arch/arm/boot/dts/usb_a9260.dts                    |   2 +-
 arch/arm/boot/dts/usb_a9263.dts                    |   2 +-
 .../boot/dts/altera/socfpga_stratix10_socdk.dts    |   2 +-
 .../dts/altera/socfpga_stratix10_socdk_nand.dts    |   2 +-
 .../dts/freescale/imx8mm-phyboard-polis-rdk.dts    |   2 +-
 .../boot/dts/freescale/imx8mm-phycore-som.dtsi     |   4 +-
 .../boot/dts/freescale/imx8mm-venice-gw7903.dts    |   4 +
 .../boot/dts/freescale/imx8mm-venice-gw7904.dts    |   4 +
 arch/arm64/boot/dts/freescale/imx8mn-var-som.dtsi  |   2 +-
 arch/arm64/boot/dts/freescale/imx8mq.dtsi          |   2 +-
 arch/arm64/kernel/fpsimd.c                         |   9 +-
 arch/arm64/kernel/ptrace.c                         |  10 +-
 arch/parisc/mm/fixmap.c                            |   3 -
 arch/parisc/mm/init.c                              |  34 +++
 arch/powerpc/include/asm/word-at-a-time.h          |   2 +-
 arch/powerpc/kernel/trace/ftrace_mprofile.S        |   9 +-
 arch/powerpc/mm/init_64.c                          |   3 +-
 arch/riscv/kernel/crash_core.c                     |   2 +
 arch/s390/kernel/sthyi.c                           |   6 +-
 arch/s390/kvm/intercept.c                          |   9 +-
 arch/s390/mm/vmem.c                                |   2 +
 arch/x86/hyperv/hv_init.c                          |  21 ++
 drivers/block/rbd.c                                |  28 ++-
 drivers/clk/imx/clk-imx93.c                        |   2 +-
 drivers/clk/mediatek/clk-mt8183.c                  |  27 ++
 drivers/firmware/arm_scmi/mailbox.c                |   4 +-
 drivers/firmware/arm_scmi/raw_mode.c               |   5 +-
 drivers/firmware/arm_scmi/smc.c                    |  21 +-
 drivers/firmware/smccc/soc_id.c                    |   5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c            |  35 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h            |   3 +-
 drivers/gpu/drm/i915/gt/gen8_engine_cs.c           | 178 ++++++++++----
 drivers/gpu/drm/i915/gt/gen8_engine_cs.h           |  21 +-
 drivers/gpu/drm/i915/gt/intel_gpu_commands.h       |   2 +
 drivers/gpu/drm/i915/gt/intel_gt_regs.h            |  16 +-
 drivers/gpu/drm/i915/gt/intel_lrc.c                |  17 +-
 drivers/gpu/drm/i915/i915_active.c                 |  99 +++++---
 drivers/gpu/drm/i915/i915_request.c                |  11 +
 drivers/gpu/drm/imx/ipuv3/ipuv3-crtc.c             |   2 +-
 drivers/gpu/drm/ttm/ttm_bo.c                       |   3 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c        |  50 ++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h        |   8 +
 drivers/isdn/hardware/mISDN/hfcpci.c               |  10 +-
 drivers/mtd/nand/raw/fsl_upm.c                     |   2 +-
 drivers/mtd/nand/raw/meson_nand.c                  |   3 +-
 drivers/mtd/nand/raw/omap_elm.c                    |  24 +-
 drivers/mtd/nand/raw/rockchip-nand-controller.c    |  45 ++--
 drivers/mtd/nand/spi/toshiba.c                     |   4 +-
 drivers/mtd/nand/spi/winbond.c                     |   4 +-
 drivers/mtd/spi-nor/spansion.c                     |   4 +-
 drivers/net/dsa/bcm_sf2.c                          |   8 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |  85 ++++---
 drivers/net/ethernet/broadcom/bnxt/bnxt.h          |   2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c      |  14 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h      |   2 +-
 drivers/net/ethernet/broadcom/tg3.c                |   1 +
 drivers/net/ethernet/intel/ice/ice_main.c          |  18 ++
 drivers/net/ethernet/korina.c                      |   3 +-
 .../ethernet/marvell/octeon_ep/octep_ctrl_mbox.c   |   3 +
 .../net/ethernet/marvell/prestera/prestera_pci.c   |   3 +-
 .../ethernet/mellanox/mlx5/core/en/tc_tun_encap.c  |   3 -
 .../net/ethernet/mellanox/mlx5/core/en/xsk/rx.c    |   5 +-
 .../mellanox/mlx5/core/en_accel/ipsec_fs.c         |   4 +-
 .../mellanox/mlx5/core/en_accel/ipsec_rxtx.c       |   4 +-
 .../ethernet/mellanox/mlx5/core/en_accel/ktls.c    |   8 -
 .../ethernet/mellanox/mlx5/core/en_accel/ktls_tx.c |  29 ++-
 .../mellanox/mlx5/core/en_accel/macsec_fs.c        |   1 +
 drivers/net/ethernet/mellanox/mlx5/core/en_arfs.c  |  10 +
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |  29 ++-
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c   |  20 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c    |  21 +-
 .../ethernet/mellanox/mlx5/core/eswitch_offloads.c |   3 +-
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c  | 105 ++++++--
 .../ethernet/mellanox/mlx5/core/lib/fs_chains.c    |   2 +-
 drivers/net/ethernet/mellanox/mlx5/core/main.c     |   1 +
 .../ethernet/mellanox/mlx5/core/steering/dr_cmd.c  |   5 +-
 drivers/net/ethernet/myricom/myri10ge/myri10ge.c   |   1 +
 drivers/net/ethernet/qlogic/qed/qed_dev_api.h      |  16 ++
 drivers/net/ethernet/qlogic/qed/qed_fcoe.c         |  19 +-
 drivers/net/ethernet/qlogic/qed/qed_fcoe.h         |  17 +-
 drivers/net/ethernet/qlogic/qed/qed_hw.c           |  26 +-
 drivers/net/ethernet/qlogic/qed/qed_iscsi.c        |  19 +-
 drivers/net/ethernet/qlogic/qed/qed_iscsi.h        |   8 +-
 drivers/net/ethernet/qlogic/qed/qed_l2.c           |  19 +-
 drivers/net/ethernet/qlogic/qed/qed_l2.h           |  24 ++
 drivers/net/ethernet/qlogic/qed/qed_main.c         |   6 +-
 drivers/net/ethernet/sfc/siena/tx_common.c         |   1 +
 drivers/net/ethernet/sfc/tx_common.c               |   1 +
 drivers/net/ethernet/socionext/netsec.c            |  11 +
 drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c  |   3 +-
 drivers/net/ethernet/sun/sunvnet_common.c          |   1 +
 drivers/net/ethernet/xilinx/ll_temac_main.c        |  12 +-
 drivers/net/tap.c                                  |   3 +-
 drivers/net/tun.c                                  |   2 +-
 drivers/net/usb/cdc_ether.c                        |  21 ++
 drivers/net/usb/lan78xx.c                          |   7 +-
 drivers/net/usb/r8152.c                            |   1 +
 drivers/net/usb/usbnet.c                           |   6 +
 drivers/net/usb/zaurus.c                           |  21 ++
 drivers/net/wireguard/device.c                     |   1 +
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c        |   1 +
 drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c |   6 +-
 drivers/s390/net/qeth_core.h                       |   1 -
 drivers/s390/net/qeth_core_main.c                  |   2 -
 drivers/s390/net/qeth_l2_main.c                    |   9 +-
 drivers/s390/net/qeth_l3_main.c                    |   8 +-
 drivers/s390/scsi/zfcp_fc.c                        |   6 +-
 drivers/scsi/storvsc_drv.c                         |   4 +
 drivers/soc/imx/imx8mp-blk-ctrl.c                  |   2 +-
 fs/btrfs/block-group.c                             |  51 ++--
 fs/btrfs/block-group.h                             |   4 +-
 fs/btrfs/free-space-tree.c                         |  24 +-
 fs/ceph/mds_client.c                               |   4 +-
 fs/ceph/mds_client.h                               |   5 +
 fs/ceph/super.c                                    |  10 +
 fs/erofs/zdata.c                                   |   7 +-
 fs/exfat/balloc.c                                  |   6 +-
 fs/exfat/dir.c                                     |  36 +--
 fs/ext2/ext2.h                                     |  12 -
 fs/ext2/super.c                                    |  23 +-
 fs/f2fs/f2fs.h                                     |   1 -
 fs/f2fs/file.c                                     |   5 -
 fs/f2fs/node.c                                     |  14 +-
 fs/file.c                                          |  18 +-
 fs/ntfs3/attrlist.c                                |   4 +-
 fs/open.c                                          |   2 +-
 fs/smb/client/dfs.c                                |   6 +-
 fs/super.c                                         |  11 +-
 fs/sysv/itree.c                                    |   4 +
 include/asm-generic/word-at-a-time.h               |   2 +-
 include/linux/f2fs_fs.h                            |   1 +
 include/linux/netdevice.h                          |  26 +-
 include/linux/skbuff.h                             |  71 ------
 include/linux/spi/spi-mem.h                        |   4 +
 include/net/gro.h                                  |  44 ++++
 include/net/gso.h                                  | 109 ++++++++
 include/net/inet_sock.h                            |   7 +-
 include/net/ip.h                                   |   2 +-
 include/net/route.h                                |   4 +-
 include/net/udp.h                                  |   1 +
 include/net/vxlan.h                                |   4 +-
 io_uring/timeout.c                                 |   2 +-
 kernel/bpf/bloom_filter.c                          |   3 -
 kernel/bpf/bpf_local_storage.c                     |   3 -
 kernel/bpf/bpf_struct_ops.c                        |   3 -
 kernel/bpf/cpumap.c                                |  39 +--
 kernel/bpf/devmap.c                                |   3 -
 kernel/bpf/hashtab.c                               |   6 -
 kernel/bpf/lpm_trie.c                              |   3 -
 kernel/bpf/queue_stack_maps.c                      |   4 -
 kernel/bpf/reuseport_array.c                       |   3 -
 kernel/bpf/stackmap.c                              |   3 -
 kernel/bpf/syscall.c                               | 136 ++++++----
 kernel/trace/bpf_trace.c                           |  17 +-
 lib/Makefile                                       |   6 +
 lib/debugobjects.c                                 |   9 +
 lib/test_bitmap.c                                  |   8 +-
 mm/filemap.c                                       |  26 +-
 mm/gup.c                                           |   2 +-
 mm/kasan/generic.c                                 |   4 +-
 mm/kasan/tags.c                                    |   2 +-
 mm/kmsan/core.c                                    |   6 +-
 mm/kmsan/instrumentation.c                         |   2 +-
 mm/memcontrol.c                                    |  19 +-
 mm/memory.c                                        |  28 ++-
 net/bluetooth/l2cap_sock.c                         |   2 +
 net/can/raw.c                                      |   2 +-
 net/ceph/osd_client.c                              |  20 +-
 net/core/Makefile                                  |   2 +-
 net/core/bpf_sk_storage.c                          |   5 +-
 net/core/dev.c                                     |  70 +-----
 net/core/gro.c                                     |  59 +----
 net/core/gso.c                                     | 273 +++++++++++++++++++++
 net/core/rtnetlink.c                               |   8 +-
 net/core/skbuff.c                                  | 142 +----------
 net/core/sock.c                                    |  45 ++--
 net/core/sock_map.c                                |   6 -
 net/dcb/dcbnl.c                                    |   2 +-
 net/dccp/ipv6.c                                    |   4 +-
 net/ipv4/af_inet.c                                 |   1 +
 net/ipv4/esp4_offload.c                            |   1 +
 net/ipv4/gre_offload.c                             |   1 +
 net/ipv4/inet_diag.c                               |   4 +-
 net/ipv4/ip_output.c                               |   9 +-
 net/ipv4/ip_sockglue.c                             |   2 +-
 net/ipv4/raw.c                                     |   2 +-
 net/ipv4/route.c                                   |   4 +-
 net/ipv4/tcp_ipv4.c                                |   4 +-
 net/ipv4/tcp_metrics.c                             |  70 ++++--
 net/ipv4/tcp_offload.c                             |   1 +
 net/ipv4/udp.c                                     |   9 +-
 net/ipv4/udp_offload.c                             |   8 +-
 net/ipv6/esp6_offload.c                            |   1 +
 net/ipv6/ip6_offload.c                             |   1 +
 net/ipv6/ip6_output.c                              |   1 +
 net/ipv6/ip6mr.c                                   |   2 +-
 net/ipv6/ping.c                                    |   2 +-
 net/ipv6/raw.c                                     |   6 +-
 net/ipv6/route.c                                   |   7 +-
 net/ipv6/tcp_ipv6.c                                |   9 +-
 net/ipv6/udp.c                                     |  12 +-
 net/ipv6/udp_offload.c                             |   8 +-
 net/l2tp/l2tp_ip6.c                                |   2 +-
 net/mac80211/tx.c                                  |   1 +
 net/mpls/af_mpls.c                                 |   1 +
 net/mpls/mpls_gso.c                                |   1 +
 net/mptcp/sockopt.c                                |   2 +-
 net/netfilter/nf_flow_table_ip.c                   |   1 +
 net/netfilter/nfnetlink_queue.c                    |   1 +
 net/netfilter/nft_socket.c                         |   2 +-
 net/netfilter/xt_socket.c                          |   4 +-
 net/nsh/nsh.c                                      |   1 +
 net/openvswitch/actions.c                          |   1 +
 net/openvswitch/datapath.c                         |   1 +
 net/packet/af_packet.c                             |  12 +-
 net/sched/act_police.c                             |   1 +
 net/sched/cls_fw.c                                 |   1 -
 net/sched/cls_route.c                              |   1 -
 net/sched/cls_u32.c                                |  57 ++++-
 net/sched/sch_cake.c                               |   1 +
 net/sched/sch_netem.c                              |   1 +
 net/sched/sch_taprio.c                             |  16 +-
 net/sched/sch_tbf.c                                |   1 +
 net/sctp/offload.c                                 |   1 +
 net/smc/af_smc.c                                   |   2 +-
 net/unix/af_unix.c                                 |   2 +-
 net/wireless/scan.c                                |   2 +-
 net/xdp/xsk.c                                      |   2 +-
 net/xdp/xskmap.c                                   |   4 -
 net/xfrm/xfrm_device.c                             |   1 +
 net/xfrm/xfrm_interface_core.c                     |   1 +
 net/xfrm/xfrm_output.c                             |   1 +
 net/xfrm/xfrm_policy.c                             |   2 +-
 rust/bindings/bindings_helper.h                    |   1 +
 rust/kernel/allocator.rs                           |  74 ++++--
 tools/perf/arch/arm64/util/pmu.c                   |   7 +-
 .../tests/shell/test_uprobe_from_different_cu.sh   |   8 +-
 .../selftests/bpf/prog_tests/unpriv_bpf_disabled.c |   6 +-
 tools/testing/selftests/net/so_incoming_cpu.c      |   2 +-
 tools/testing/selftests/rseq/rseq.c                |  28 ++-
 .../tc-testing/tc-tests/qdiscs/taprio.json         |  25 ++
 tools/testing/vsock/Makefile                       |   2 +-
 272 files changed, 2293 insertions(+), 1234 deletions(-)


