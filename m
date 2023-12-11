Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 197D580D994
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 19:55:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345296AbjLKSzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 13:55:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjLKSzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 13:55:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A61BB4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 10:55:05 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65AA7C433C8;
        Mon, 11 Dec 2023 18:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1702320904;
        bh=CoJzGTdwqfWtmUxY03pxB6OvLUACLQJ5mbNLKqPqo4U=;
        h=From:To:Cc:Subject:Date:From;
        b=z8dk7E30rLMcGqDN3a+Dq0wDECTjqBzeexN0YRFCv6nde+Xh9Zqyj5utNuF0Vypob
         zNckhp/uBYmja6boeaTr/Rc/JgWNlrTcbn3rDtEIAvn87Hwv93awOLYh8Aaw9LCihD
         M6QFN+ut9DiBQ/7kt6DTMKX/n3zLvosdSiJomGP4=
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
Subject: [PATCH 5.15 000/141] 5.15.143-rc1 review
Date:   Mon, 11 Dec 2023 19:20:59 +0100
Message-ID: <20231211182026.503492284@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.143-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.15.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.15.143-rc1
X-KernelTest-Deadline: 2023-12-13T18:20+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 5.15.143 release.
There are 141 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed, 13 Dec 2023 18:19:59 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.143-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 5.15.143-rc1

Mukesh Ojha <quic_mojha@quicinc.com>
    devcoredump: Send uevent once devcd is ready

Mukesh Ojha <quic_mojha@quicinc.com>
    devcoredump : Serialize devcd_del work

Paulo Alcantara <pc@manguebit.com>
    smb: client: fix potential NULL deref in parse_dfs_referrals()

David Howells <dhowells@redhat.com>
    cifs: Fix non-availability of dedup breaking generic/304

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Revert "btrfs: add dmesg output for first mount and last unmount of a filesystem"

Jiaxun Yang <jiaxun.yang@flygoat.com>
    MIPS: Loongson64: Enable DMA noncoherent support

Jiaxun Yang <jiaxun.yang@flygoat.com>
    MIPS: Loongson64: Reserve vgabios memory on boot

Sean Christopherson <seanjc@google.com>
    KVM: SVM: Update EFER software model on CR0 trap for SEV-ES

Claudio Imbrenda <imbrenda@linux.ibm.com>
    KVM: s390/mm: Properly reset no-dat

Borislav Petkov (AMD) <bp@alien8.de>
    x86/CPU/AMD: Check vendor in the AMD microcode callback

Ronald Wahl <ronald.wahl@raritan.com>
    serial: 8250_omap: Add earlycon support for the AM654 UART controller

Ronald Wahl <ronald.wahl@raritan.com>
    serial: 8250: 8250_omap: Do not start RX DMA on THRI interrupt

Ronald Wahl <ronald.wahl@raritan.com>
    serial: 8250: 8250_omap: Clear UART_HAS_RHR_IT_DIS bit

Daniel Mack <daniel@zonque.org>
    serial: sc16is7xx: address RX timeout interrupt errata

Arnd Bergmann <arnd@arndb.de>
    ARM: PL011: Fix DMA support

RD Babiera <rdbabiera@google.com>
    usb: typec: class: fix typec_altmode_put_partner to put plugs

Mathias Nyman <mathias.nyman@linux.intel.com>
    Revert "xhci: Loosen RPM as default policy to cover for AMD xHC 1.1"

Cameron Williams <cang1@live.co.uk>
    parport: Add support for Brainboxes IX/UC/PX parallel cards

Konstantin Aladyshev <aladyshev22@gmail.com>
    usb: gadget: f_hid: fix report descriptor allocation

Arnd Bergmann <arnd@arndb.de>
    Kbuild: move to -std=gnu11

Mark Rutland <mark.rutland@arm.com>
    Kbuild: use -Wdeclaration-after-statement

Prike Liang <Prike.Liang@amd.com>
    drm/amdgpu: correct the amdgpu runtime dereference usage count

Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
    drm/amd/amdgpu: Fix warnings in amdgpu/amdgpu_display.c

Boerge Struempfel <boerge.struempfel@gmail.com>
    gpiolib: sysfs: Fix error handling on failed export

Peter Zijlstra <peterz@infradead.org>
    perf: Fix perf_event_validate_size()

Namhyung Kim <namhyung@kernel.org>
    perf/core: Add a new read format to get a number of lost samples

Hsin-Yi Wang <hsinyi@chromium.org>
    arm64: dts: mt8183: kukui: Fix underscores in node names

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    arm64: dts: mediatek: add missing space before {

AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
    arm64: dts: mediatek: mt8183: Move thermal-zones to the root node

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    arm64: dts: mediatek: align thermal zone node names with dtschema

Namhyung Kim <namhyung@kernel.org>
    tools headers UAPI: Sync linux/perf_event.h with the kernel sources

Akira Yokosawa <akiyks@gmail.com>
    docs/process/howto: Replace C89 with C11

Hans de Goede <hdegoede@redhat.com>
    platform/x86: asus-wmi: Fix kbd_dock_devid tablet-switch reporting

Florian Westphal <fw@strlen.de>
    netfilter: nft_set_pipapo: skip inactive elements during set walk

Pavel Begunkov <asml.silence@gmail.com>
    io_uring/af_unix: disable sending io_uring over sockets

Hugh Dickins <hughd@google.com>
    mm: fix oops when filemap_map_pmd() without prealloc_pte

ChunHao Lin <hau@realtek.com>
    r8169: fix rtl8125b PAUSE frames blasting when suspended

Steven Rostedt (Google) <rostedt@goodmis.org>
    tracing: Stop current tracer when resizing buffer

Zheng Yejian <zhengyejian1@huawei.com>
    tracing: Set actual size after ring buffer resize

Steven Rostedt (Google) <rostedt@goodmis.org>
    ring-buffer: Force absolute timestamp on discard of event

Su Hui <suhui@nfschina.com>
    misc: mei: client.c: fix problem of return '-EOVERFLOW' in mei_cl_write

Su Hui <suhui@nfschina.com>
    misc: mei: client.c: return negative error code in mei_cl_write

Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    coresight: etm4x: Remove bogous __exit annotation for some functions

Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    coresight: etm4x: Make etm4_remove_dev() return void

Jiri Olsa <jolsa@kernel.org>
    kallsyms: Make kallsyms_on_each_symbol generally available

Carlos Llamas <cmllamas@google.com>
    binder: fix memory leaks of spam and pending work

AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
    arm64: dts: mediatek: mt8183: Fix unit address for scp reserved memory

AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
    arm64: dts: mediatek: mt8173-evb: Fix regulator-fixed node names

Eugen Hristev <eugen.hristev@collabora.com>
    arm64: dts: mediatek: mt8183-kukui-jacuzzi: fix dsi unnecessary cells properties

Eugen Hristev <eugen.hristev@collabora.com>
    arm64: dts: mediatek: mt7622: fix memory node warning check

Francesco Dolcini <francesco.dolcini@toradex.com>
    platform/surface: aggregator: fix recv_buf() return value

Matthias Reichl <hias@horus.com>
    regmap: fix bogus error on regcache_sync success

Daniel Borkmann <daniel@iogearbox.net>
    packet: Move reference count in packet_sock to atomic_long_t

Petr Pavlu <petr.pavlu@suse.com>
    tracing: Fix a possible race when disabling buffered events

Petr Pavlu <petr.pavlu@suse.com>
    tracing: Fix incomplete locking when disabling buffered events

Steven Rostedt (Google) <rostedt@goodmis.org>
    tracing: Disable snapshot buffer when stopping instance tracers

Steven Rostedt (Google) <rostedt@goodmis.org>
    tracing: Always update snapshot buffer size

Heiko Carstens <hca@linux.ibm.com>
    checkstack: fix printed address

Ryusuke Konishi <konishi.ryusuke@gmail.com>
    nilfs2: prevent WARNING in nilfs_sufile_set_segment_usage()

Ryusuke Konishi <konishi.ryusuke@gmail.com>
    nilfs2: fix missing error check for sb_set_blocksize call

Bin Li <bin.li@canonical.com>
    ALSA: hda/realtek: Enable headset on Lenovo M90 Gen5

Jason Zhang <jason.zhang@rock-chips.com>
    ALSA: pcm: fix out-of-bounds in snd_pcm_state_names

Sarah Grant <s@srd.tw>
    ALSA: usb-audio: Add Pioneer DJM-450 mixer controls

Pavel Begunkov <asml.silence@gmail.com>
    io_uring: fix mutex_unlock with unreferenced ctx

Georg Gottleuber <ggo@tuxedocomputers.com>
    nvme-pci: Add sleep quirk for Kingston drives

JP Kobryn <inwardvessel@gmail.com>
    kprobes: consistent rcu api usage for kretprobe holder

Yu Kuai <yukuai3@huawei.com>
    md: don't leave 'MD_RECOVERY_FROZEN' in error path of md_set_readonly()

Ye Bin <yebin10@huawei.com>
    md: introduce md_ro_state

Clément Léger <cleger@rivosinc.com>
    riscv: fix misaligned access handling of C.SWSP and C.SDSP

Fabio Estevam <festevam@denx.de>
    ARM: dts: imx28-xea: Pass the 'model' property

Philipp Zabel <p.zabel@pengutronix.de>
    ARM: dts: imx7: Declare timers compatible with fsl,imx6dl-gpt

Kunwu Chan <chentao@kylinos.cn>
    ARM: imx: Check return value of devm_kasprintf in imx_mmdc_perf_init

Dinghao Liu <dinghao.liu@zju.edu.cn>
    scsi: be2iscsi: Fix a memleak in beiscsi_init_wrb_handle()

Petr Pavlu <petr.pavlu@suse.com>
    tracing: Fix a warning when allocating buffered events fails

Fabio Estevam <festevam@denx.de>
    ARM: dts: imx6ul-pico: Describe the Ethernet PHY clock

Nathan Rossi <nathan.rossi@digi.com>
    arm64: dts: imx8mp: imx8mq: Add parkmode-disable-ss-quirk on DWC3

Peng Fan <peng.fan@nxp.com>
    arm64: dts: imx8mq: drop usb3-resume-missing-cas from usb

Shifeng Li <lishifeng@sangfor.com.cn>
    RDMA/irdma: Avoid free the non-cqp_request scratch

Mike Marciniszyn <mike.marciniszyn@intel.com>
    RDMA/core: Fix umem iterator when PAGE_SIZE is greater then HCA pgsz

Dinghao Liu <dinghao.liu@zju.edu.cn>
    ASoC: wm_adsp: fix memleak in wm_adsp_buffer_populate

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    hwmon: (nzxt-kraken2) Fix error handling path in kraken2_probe()

Armin Wolf <W_Armin@gmx.de>
    hwmon: (acpi_power_meter) Fix 4.29 MW bug

Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
    RDMA/bnxt_re: Correct module description string

Jack Wang <jinpu.wang@ionos.com>
    RDMA/rtrs-clt: Remove the warnings for req in_use check

Jack Wang <jinpu.wang@ionos.com>
    RDMA/rtrs-clt: Fix the max_send_wr setting

Md Haris Iqbal <haris.iqbal@ionos.com>
    RDMA/rtrs-srv: Destroy path files after making sure no IOs in-flight

Md Haris Iqbal <haris.iqbal@ionos.com>
    RDMA/rtrs-srv: Free srv_mr iu only when always_invalidate is true

Md Haris Iqbal <haris.iqbal@ionos.com>
    RDMA/rtrs-srv: Check return values while processing info request

Jack Wang <jinpu.wang@ionos.com>
    RDMA/rtrs-clt: Start hb after path_up

Jack Wang <jinpu.wang@ionos.com>
    RDMA/rtrs-srv: Do not unconditionally enable irq

Alex Bee <knaerzche@gmail.com>
    arm64: dts: rockchip: Expand reg size of vdec node for RK3399

Mustafa Ismail <mustafa.ismail@intel.com>
    RDMA/irdma: Add wait for suspend on SQD

Mustafa Ismail <mustafa.ismail@intel.com>
    RDMA/irdma: Do not modify to SQD on error

Junxian Huang <huangjunxian6@hisilicon.com>
    RDMA/hns: Fix unnecessary err return when using invalid congest control algorithm

Sumit Garg <sumit.garg@linaro.org>
    tee: optee: Fix supplicant based device enumeration

Ido Schimmel <idosch@nvidia.com>
    drop_monitor: Require 'CAP_SYS_ADMIN' when joining "events" group

Jakub Kicinski <kuba@kernel.org>
    net: add missing kdoc for struct genl_multicast_group::flags

Ido Schimmel <idosch@nvidia.com>
    psample: Require 'CAP_NET_ADMIN' when joining "packets" group

John Fastabend <john.fastabend@gmail.com>
    bpf: sockmap, updating the sg structure should also update curr

Eric Dumazet <edumazet@google.com>
    tcp: do not accept ACK of bytes we never sent

Phil Sutter <phil@nwl.cc>
    netfilter: xt_owner: Fix for unsafe access of sk->sk_socket

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: validate family when identifying table via handle

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: bail out on mismatching dynset and set expressions

Rahul Bhansali <rbhansali@marvell.com>
    octeontx2-af: Update Tx link register range

Yonglong Liu <liuyonglong@huawei.com>
    net: hns: fix fake link up on xge port

Shigeru Yoshida <syoshida@redhat.com>
    ipv4: ip_gre: Avoid skb_pull() failure in ipgre_xmit()

Brett Creeley <brett.creeley@amd.com>
    ionic: Fix dim work handling in split interrupt mode

Shannon Nelson <shannon.nelson@amd.com>
    ionic: fix snprintf format length warning

Dinghao Liu <dinghao.liu@zju.edu.cn>
    net: bnxt: fix a potential use-after-free in bnxt_init_tc

Ivan Vecera <ivecera@redhat.com>
    i40e: Fix unexpected MFS warning message

Zhipeng Lu <alexious@zju.edu.cn>
    octeontx2-af: fix a use-after-free in rvu_npa_register_reporters

Jianheng Zhang <Jianheng.Zhang@synopsys.com>
    net: stmmac: fix FPE events losing

Thomas Reichinger <thomas.reichinger@sohard.de>
    arcnet: restoring support for multiple Sohard Arcnet cards

Kunwu Chan <chentao@kylinos.cn>
    platform/mellanox: Check devm_hwmon_device_register_with_groups() return value

Kunwu Chan <chentao@kylinos.cn>
    platform/mellanox: Add null pointer checks for devm_kasprintf()

David Thompson <davthompson@nvidia.com>
    mlxbf-bootctl: correctly identify secure boot with development keys

Douglas Anderson <dianders@chromium.org>
    r8152: Add RTL8152_INACCESSIBLE to r8153_aldps_en()

Douglas Anderson <dianders@chromium.org>
    r8152: Add RTL8152_INACCESSIBLE to r8153_pre_firmware_1()

Douglas Anderson <dianders@chromium.org>
    r8152: Add RTL8152_INACCESSIBLE to r8156b_wait_loading_flash()

Douglas Anderson <dianders@chromium.org>
    r8152: Add RTL8152_INACCESSIBLE checks to more loops

Douglas Anderson <dianders@chromium.org>
    r8152: Rename RTL8152_UNPLUG to RTL8152_INACCESSIBLE

Randy Dunlap <rdunlap@infradead.org>
    hv_netvsc: rndis_filter needs to select NLS

Subbaraya Sundeep <sbhatta@marvell.com>
    octeontx2-af: Check return value of nix_get_nixlf before using nixlf

Subbaraya Sundeep <sbhatta@marvell.com>
    octeontx2-pf: Add missing mutex lock in otx2_get_pauseparam

Eric Dumazet <edumazet@google.com>
    ipv6: fix potential NULL deref in fib6_add()

Armin Wolf <W_Armin@gmx.de>
    platform/x86: wmi: Skip blocks with zero instances

Mario Limonciello <mario.limonciello@amd.com>
    platform/x86: wmi: Allow duplicate GUIDs for drivers that use struct wmi_driver

Luca Ceresoli <luca.ceresoli@bootlin.com>
    of: dynamic: Fix of_reconfig_get_state_change() return value documentation

Hans de Goede <hdegoede@redhat.com>
    platform/x86: asus-wmi: Move i8042 filter install to shared asus-wmi code

Hans de Goede <hdegoede@redhat.com>
    platform/x86: asus-wmi: Simplify tablet-mode-switch handling

Hans de Goede <hdegoede@redhat.com>
    platform/x86: asus-wmi: Simplify tablet-mode-switch probing

Luke D. Jones <luke@ljones.dev>
    platform/x86: asus-wmi: Add support for ROG X13 tablet mode

Luke D. Jones <luke@ljones.dev>
    platform/x86: asus-wmi: Adjust tablet/lidflip handling to use enum

YuanShang <YuanShang.Mao@amd.com>
    drm/amdgpu: correct chunk_ptr to a pointer to chunk.

Masahiro Yamada <masahiroy@kernel.org>
    kconfig: fix memory leak from range properties

Alex Pakhunov <alexey.pakhunov@spacex.com>
    tg3: Increment tx_dropped in tg3_tso_bug()

Alex Pakhunov <alexey.pakhunov@spacex.com>
    tg3: Move the [rt]x_dropped counters to tg3_napi

Jozsef Kadlecsik <kadlec@netfilter.org>
    netfilter: ipset: fix race condition between swap/destroy and kernel side add/del/test

Jan Bottorff <janb@os.amperecomputing.com>
    i2c: designware: Fix corrupted memory seen in the ISR

Thomas Gleixner <tglx@linutronix.de>
    hrtimers: Push pending hrtimers away from outgoing CPU earlier

Steve Sistare <steven.sistare@oracle.com>
    vdpa/mlx5: preserve CVQ vringh index


-------------

Diffstat:

 Documentation/ABI/testing/sysfs-bus-optee-devices  |   9 +
 Documentation/process/howto.rst                    |   2 +-
 Documentation/process/programming-language.rst     |   6 +-
 Documentation/translations/it_IT/process/howto.rst |   2 +-
 .../it_IT/process/programming-language.rst         |   4 +-
 Documentation/translations/ja_JP/howto.rst         |   2 +-
 Documentation/translations/ko_KR/howto.rst         |   2 +-
 Documentation/translations/zh_CN/process/howto.rst |   2 +-
 .../zh_CN/process/programming-language.rst         |   3 +-
 Documentation/translations/zh_TW/process/howto.rst |   2 +-
 .../zh_TW/process/programming-language.rst         |   3 +-
 Makefile                                           |  11 +-
 arch/arm/boot/dts/imx28-xea.dts                    |   1 +
 arch/arm/boot/dts/imx6ul-pico.dtsi                 |   2 +
 arch/arm/boot/dts/imx7s.dtsi                       |   8 +-
 arch/arm/mach-imx/mmdc.c                           |   7 +-
 arch/arm64/boot/dts/freescale/imx8mp.dtsi          |   2 +
 arch/arm64/boot/dts/freescale/imx8mq.dtsi          |   4 +-
 .../boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts  |   2 +-
 arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts       |   2 +-
 arch/arm64/boot/dts/mediatek/mt8173-evb.dts        |   4 +-
 arch/arm64/boot/dts/mediatek/mt8173.dtsi           |   2 +-
 arch/arm64/boot/dts/mediatek/mt8183-evb.dts        |  50 ++---
 .../boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi    |   8 +-
 arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi     |  90 ++++----
 arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts    |  12 +-
 arch/arm64/boot/dts/mediatek/mt8183.dtsi           | 242 ++++++++++-----------
 arch/arm64/boot/dts/rockchip/rk3399.dtsi           |   6 +-
 arch/arm64/kernel/vdso32/Makefile                  |   3 +-
 arch/mips/Kconfig                                  |   2 +
 arch/mips/include/asm/mach-loongson64/boot_param.h |   3 +-
 arch/mips/loongson64/env.c                         |  10 +-
 arch/mips/loongson64/init.c                        |   5 +
 arch/riscv/kernel/traps_misaligned.c               |   6 +-
 arch/s390/mm/pgtable.c                             |   2 +-
 arch/x86/kernel/cpu/amd.c                          |   3 +
 arch/x86/kvm/svm/svm.c                             |   8 +-
 drivers/android/binder.c                           |   1 +
 drivers/base/devcoredump.c                         |  86 +++++++-
 drivers/base/regmap/regcache.c                     |   3 +-
 drivers/gpio/gpiolib-sysfs.c                       |  15 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c             |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c        |  49 +++--
 drivers/hwmon/acpi_power_meter.c                   |   4 +
 drivers/hwmon/nzxt-kraken2.c                       |   4 +-
 drivers/hwtracing/coresight/coresight-etm4x-core.c |  13 +-
 drivers/i2c/busses/i2c-designware-common.c         |  16 +-
 drivers/infiniband/core/umem.c                     |   6 -
 drivers/infiniband/hw/bnxt_re/main.c               |   2 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c         |  13 +-
 drivers/infiniband/hw/irdma/hw.c                   |  10 +-
 drivers/infiniband/hw/irdma/main.c                 |   2 +-
 drivers/infiniband/hw/irdma/main.h                 |   2 +-
 drivers/infiniband/hw/irdma/verbs.c                |  28 ++-
 drivers/infiniband/hw/irdma/verbs.h                |   1 +
 drivers/infiniband/ulp/rtrs/rtrs-clt.c             |   7 +-
 drivers/infiniband/ulp/rtrs/rtrs-srv.c             |  37 +++-
 drivers/md/md.c                                    | 174 ++++++++-------
 drivers/misc/mei/client.c                          |   4 +-
 drivers/net/arcnet/arcdevice.h                     |   2 +
 drivers/net/arcnet/com20020-pci.c                  |  89 ++++----
 drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c       |   1 +
 drivers/net/ethernet/broadcom/tg3.c                |  42 +++-
 drivers/net/ethernet/broadcom/tg3.h                |   4 +-
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c  |  29 +++
 drivers/net/ethernet/intel/i40e/i40e_main.c        |   2 +-
 .../ethernet/marvell/octeontx2/af/rvu_devlink.c    |   5 +-
 .../net/ethernet/marvell/octeontx2/af/rvu_npc.c    |   8 +-
 .../net/ethernet/marvell/octeontx2/af/rvu_reg.c    |   4 +-
 .../ethernet/marvell/octeontx2/nic/otx2_ethtool.c  |   6 +-
 drivers/net/ethernet/pensando/ionic/ionic_dev.h    |   2 +-
 drivers/net/ethernet/pensando/ionic/ionic_lif.c    |  16 +-
 drivers/net/ethernet/realtek/r8169_main.c          |   7 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac5.c       |  45 ++--
 drivers/net/ethernet/stmicro/stmmac/dwmac5.h       |   4 +-
 .../net/ethernet/stmicro/stmmac/dwxgmac2_core.c    |   3 +-
 drivers/net/ethernet/stmicro/stmmac/hwif.h         |   4 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |   8 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c    |   1 +
 drivers/net/hyperv/Kconfig                         |   1 +
 drivers/net/usb/r8152.c                            | 110 ++++++----
 drivers/nvme/host/nvme.h                           |   5 +
 drivers/nvme/host/pci.c                            |  16 +-
 drivers/of/dynamic.c                               |   5 +-
 drivers/parport/parport_pc.c                       |  21 ++
 drivers/platform/mellanox/mlxbf-bootctl.c          |  39 ++--
 drivers/platform/mellanox/mlxbf-pmc.c              |  14 ++
 drivers/platform/surface/aggregator/core.c         |   5 +-
 drivers/platform/x86/Kconfig                       |   2 +-
 drivers/platform/x86/asus-nb-wmi.c                 |  46 ++--
 drivers/platform/x86/asus-wmi.c                    | 118 +++++-----
 drivers/platform/x86/asus-wmi.h                    |  10 +-
 drivers/platform/x86/wmi.c                         |  54 ++++-
 drivers/scsi/be2iscsi/be_main.c                    |   1 +
 drivers/tee/optee/device.c                         |  17 +-
 drivers/tty/serial/8250/8250_early.c               |   1 +
 drivers/tty/serial/8250/8250_omap.c                |  14 +-
 drivers/tty/serial/amba-pl011.c                    | 112 +++++-----
 drivers/tty/serial/sc16is7xx.c                     |  12 +
 drivers/usb/gadget/function/f_hid.c                |   7 +-
 drivers/usb/host/xhci-pci.c                        |   2 -
 drivers/usb/typec/class.c                          |   5 +-
 drivers/vdpa/mlx5/net/mlx5_vnet.c                  |   7 +-
 fs/btrfs/disk-io.c                                 |   1 -
 fs/btrfs/super.c                                   |   5 +-
 fs/cifs/cifsfs.c                                   |   4 +-
 fs/cifs/smb2ops.c                                  |   2 +
 fs/nilfs2/sufile.c                                 |  44 +++-
 fs/nilfs2/the_nilfs.c                              |   6 +-
 include/linux/cpuhotplug.h                         |   1 +
 include/linux/hrtimer.h                            |   4 +-
 include/linux/kallsyms.h                           |   7 +-
 include/linux/kprobes.h                            |   7 +-
 include/linux/perf_event.h                         |   2 +
 include/linux/platform_data/x86/asus-wmi.h         |   1 +
 include/linux/stmmac.h                             |   1 +
 include/net/genetlink.h                            |   7 +-
 include/rdma/ib_umem.h                             |   9 +-
 include/rdma/ib_verbs.h                            |   1 +
 include/uapi/linux/perf_event.h                    |   5 +-
 io_uring/io_uring.c                                |  64 +-----
 kernel/cpu.c                                       |   8 +-
 kernel/events/core.c                               |  80 ++++---
 kernel/events/ring_buffer.c                        |   5 +-
 kernel/kallsyms.c                                  |   2 -
 kernel/kprobes.c                                   |   4 +-
 kernel/time/hrtimer.c                              |  33 +--
 kernel/trace/ring_buffer.c                         |  19 +-
 kernel/trace/trace.c                               | 219 ++++++++-----------
 mm/filemap.c                                       |   2 +-
 net/core/drop_monitor.c                            |   4 +-
 net/core/filter.c                                  |  19 ++
 net/core/scm.c                                     |   6 +
 net/ipv4/ip_gre.c                                  |  11 +-
 net/ipv4/tcp_input.c                               |   6 +-
 net/ipv6/ip6_fib.c                                 |   6 +-
 net/netfilter/ipset/ip_set_core.c                  |  14 +-
 net/netfilter/nf_tables_api.c                      |   5 +-
 net/netfilter/nft_dynset.c                         |  13 +-
 net/netfilter/nft_set_pipapo.c                     |   3 +
 net/netfilter/xt_owner.c                           |  16 +-
 net/netlink/genetlink.c                            |   3 +
 net/packet/af_packet.c                             |  16 +-
 net/packet/internal.h                              |   2 +-
 net/psample/psample.c                              |   3 +-
 scripts/checkstack.pl                              |   8 +-
 scripts/kconfig/symbol.c                           |  14 +-
 scripts/mod/modpost.c                              |   4 +-
 sound/core/pcm.c                                   |   1 +
 sound/pci/hda/patch_realtek.c                      |   1 +
 sound/soc/codecs/wm_adsp.c                         |   8 +-
 sound/usb/mixer_quirks.c                           |  30 +++
 tools/include/uapi/linux/perf_event.h              |   5 +-
 153 files changed, 1576 insertions(+), 1082 deletions(-)


