Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08F3780D59D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 19:26:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345314AbjLKS02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 13:26:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbjLKS01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 13:26:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7082CD2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 10:26:30 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55DF8C433C8;
        Mon, 11 Dec 2023 18:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1702319190;
        bh=1+GIiFqGysp3XA6obPxv7NIK4jMXUb9CnoZfcHZ+GUw=;
        h=From:To:Cc:Subject:Date:From;
        b=jokCCDYM7MxYU9QLIgbdzqfPXP5o0Yiog9GLyvKuvD9bTH0+ma6PwY2LJ8xk95GvC
         oNTyd3aUz0gfD6GA0YWww8SZmeriEomZRZyvRK0HbcIGbj7NMTNaQYEVgN3xrvfJNh
         hrGu0fcS4tIHhZEhhLU3qYf43MgknPHk2T6fZ/Ik=
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
Subject: [PATCH 6.6 000/244] 6.6.7-rc1 review
Date:   Mon, 11 Dec 2023 19:18:13 +0100
Message-ID: <20231211182045.784881756@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.7-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.6.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.6.7-rc1
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

This is the start of the stable review cycle for the 6.6.7 release.
There are 244 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed, 13 Dec 2023 18:19:59 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.7-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 6.6.7-rc1

Lijo Lazar <lijo.lazar@amd.com>
    drm/amdgpu: Restrict extended wait to PSP v13.0.6

Asad Kamal <asad.kamal@amd.com>
    drm/amdgpu: update retry times for psp BL wait

Lijo Lazar <lijo.lazar@amd.com>
    drm/amdgpu: Fix refclk reporting for SMU v13.0.6

Jia Jie Ho <jiajie.ho@starfivetech.com>
    riscv: Kconfig: Add select ARM_AMBA to SOC_STARFIVE

Gustavo A. R. Silva <gustavoars@kernel.org>
    gcc-plugins: randstruct: Update code comment in relayout_struct()

Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
    ASoC: qcom: sc8280xp: Limit speaker digital volumes

Florian Westphal <fw@strlen.de>
    netfilter: nft_set_pipapo: skip inactive elements during set walk

Jiaxun Yang <jiaxun.yang@flygoat.com>
    MIPS: Loongson64: Enable DMA noncoherent support

Jiaxun Yang <jiaxun.yang@flygoat.com>
    MIPS: Loongson64: Handle more memory types passed from firmware

Jiaxun Yang <jiaxun.yang@flygoat.com>
    MIPS: Loongson64: Reserve vgabios memory on boot

Ian Rogers <irogers@google.com>
    perf metrics: Avoid segv if default metricgroup isn't set

Ian Rogers <irogers@google.com>
    perf list: Fix JSON segfault by setting the used skip_duplicate_pmus callback

Sean Christopherson <seanjc@google.com>
    KVM: SVM: Update EFER software model on CR0 trap for SEV-ES

Claudio Imbrenda <imbrenda@linux.ibm.com>
    KVM: s390/mm: Properly reset no-dat

Thomas Bogendoerfer <tsbogend@alpha.franken.de>
    MIPS: kernel: Clear FPU states when setting up kernel threads

David Howells <dhowells@redhat.com>
    cifs: Fix flushing, invalidation and file size with FICLONE

David Howells <dhowells@redhat.com>
    cifs: Fix flushing, invalidation and file size with copy_file_range()

Roy Luo <royluo@google.com>
    USB: gadget: core: adjust uevent timing on gadget unbind

Naveen N Rao <naveen@kernel.org>
    powerpc/ftrace: Fix stack teardown in ftrace_no_trace

Borislav Petkov (AMD) <bp@alien8.de>
    x86/CPU/AMD: Check vendor in the AMD microcode callback

Mukesh Ojha <quic_mojha@quicinc.com>
    devcoredump: Send uevent once devcd is ready

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

Paulo Alcantara <pc@manguebit.com>
    smb: client: fix potential NULL deref in parse_dfs_referrals()

Mathias Nyman <mathias.nyman@linux.intel.com>
    Revert "xhci: Loosen RPM as default policy to cover for AMD xHC 1.1"

David Howells <dhowells@redhat.com>
    cifs: Fix non-availability of dedup breaking generic/304

Cameron Williams <cang1@live.co.uk>
    parport: Add support for Brainboxes IX/UC/PX parallel cards

Andi Shyti <andi.shyti@kernel.org>
    serial: ma35d1: Validate console index before assignment

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    serial: 8250_dw: Add ACPI ID for Granite Rapids-D UART

Miquel Raynal <miquel.raynal@bootlin.com>
    nvmem: Do not expect fixed layouts to grab a layout driver

Konstantin Aladyshev <aladyshev22@gmail.com>
    usb: gadget: f_hid: fix report descriptor allocation

JP Kobryn <inwardvessel@gmail.com>
    kprobes: consistent rcu api usage for kretprobe holder

Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
    ASoC: ops: add correct range check for limiting volume

Boerge Struempfel <boerge.struempfel@gmail.com>
    gpiolib: sysfs: Fix error handling on failed export

Ashwin Dayanand Kamat <ashwin.kamat@broadcom.com>
    x86/sev: Fix kernel crash due to late update to read-only ghcb_version

Peter Zijlstra <peterz@infradead.org>
    perf: Fix perf_event_validate_size()

Jiadong Zhu <Jiadong.Zhu@amd.com>
    drm/amdgpu: disable MCBP by default

Hsin-Yi Wang <hsinyi@chromium.org>
    arm64: dts: mt8183: kukui: Fix underscores in node names

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    arm64: dts: mediatek: add missing space before {

Helge Deller <deller@gmx.de>
    parisc: Fix asm operand number out of range build error in bug table

Helge Deller <deller@gmx.de>
    parisc: Reduce size of the bug_table on 64-bit kernel by half

Hengqi Chen <hengqi.chen@gmail.com>
    LoongArch: BPF: Don't sign extend function return value

Hengqi Chen <hengqi.chen@gmail.com>
    LoongArch: BPF: Don't sign extend memory load operand

Ilkka Koskinen <ilkka@os.amperecomputing.com>
    perf vendor events arm64: AmpereOne: Add missing DefaultMetricgroupName fields

Su Hui <suhui@nfschina.com>
    misc: mei: client.c: fix problem of return '-EOVERFLOW' in mei_cl_write

Su Hui <suhui@nfschina.com>
    misc: mei: client.c: return negative error code in mei_cl_write

Junhao He <hejunhao3@huawei.com>
    coresight: ultrasoc-smb: Fix uninitialized before use buf_hw_base

Junhao He <hejunhao3@huawei.com>
    coresight: ultrasoc-smb: Config SMB buffer before register sink

Junhao He <hejunhao3@huawei.com>
    coresight: ultrasoc-smb: Fix sleep while close preempt in enable_smb

Junhao He <hejunhao3@huawei.com>
    hwtracing: hisi_ptt: Add dummy callback pmu::read()

James Clark <james.clark@arm.com>
    coresight: Fix crash when Perf and sysfs modes are used concurrently

Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    coresight: etm4x: Remove bogous __exit annotation for some functions

AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
    arm64: dts: mediatek: mt8186: Change gpu speedbin nvmem cell name

Eugen Hristev <eugen.hristev@collabora.com>
    arm64: dts: mediatek: mt8186: fix clock names for power domains

AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
    arm64: dts: mediatek: mt8183-evb: Fix unit_address_vs_reg warning on ntc

AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
    arm64: dts: mediatek: mt8183: Move thermal-zones to the root node

AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
    arm64: dts: mediatek: mt8183: Fix unit address for scp reserved memory

AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
    arm64: dts: mediatek: mt8195: Fix PM suspend/resume with venc clocks

AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
    arm64: dts: mediatek: mt8173-evb: Fix regulator-fixed node names

AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
    arm64: dts: mediatek: cherry: Fix interrupt cells for MT6360 on I2C7

Eugen Hristev <eugen.hristev@collabora.com>
    arm64: dts: mediatek: mt8183-kukui-jacuzzi: fix dsi unnecessary cells properties

Eugen Hristev <eugen.hristev@collabora.com>
    arm64: dts: mediatek: mt7622: fix memory node warning check

Eric Woudstra <ericwouds@gmail.com>
    arm64: dts: mt7986: fix emmc hs400 mode without uboot initialization

Frank Wunderlich <frank-w@public-files.de>
    arm64: dts: mt7986: define 3W max power to both SFP on BPI-R3

Frank Wunderlich <frank-w@public-files.de>
    arm64: dts: mt7986: change cooling trips

Ville Syrjälä <ville.syrjala@linux.intel.com>
    drm/i915: Skip some timing checks on BXT/GLK DSI transcoders

Ville Syrjälä <ville.syrjala@linux.intel.com>
    drm/i915/mst: Reject modes that require the bigjoiner

Ville Syrjälä <ville.syrjala@linux.intel.com>
    drm/i915/mst: Fix .mode_valid_ctx() return values

Thomas Zimmermann <tzimmermann@suse.de>
    drm/atomic-helpers: Invoke end_fb_access while owning plane state

David Jeffery <djeffery@redhat.com>
    md/raid6: use valid sector values to determine if an I/O should wait on the reshape

Lukasz Luba <lukasz.luba@arm.com>
    powercap: DTPM: Fix missing cpufreq_cpu_put() calls

Sumanth Korikkar <sumanthk@linux.ibm.com>
    mm/memory_hotplug: fix error handling in add_memory_resource()

Hugh Dickins <hughd@google.com>
    mm: fix oops when filemap_map_pmd() without prealloc_pte

Sumanth Korikkar <sumanthk@linux.ibm.com>
    mm/memory_hotplug: add missing mem_hotplug_lock

Baoquan He <bhe@redhat.com>
    drivers/base/cpu: crash data showing should depends on KEXEC_CORE

Mike Kravetz <mike.kravetz@oracle.com>
    hugetlb: fix null-ptr-deref in hugetlb_vma_lock_write

Tejun Heo <tj@kernel.org>
    workqueue: Make sure that wq_unbound_cpumask is never empty

Francesco Dolcini <francesco.dolcini@toradex.com>
    platform/surface: aggregator: fix recv_buf() return value

Matthias Reichl <hias@horus.com>
    regmap: fix bogus error on regcache_sync success

ChunHao Lin <hau@realtek.com>
    r8169: fix rtl8125b PAUSE frames blasting when suspended

Daniel Borkmann <daniel@iogearbox.net>
    packet: Move reference count in packet_sock to atomic_long_t

Hui Zhou <hui.zhou@corigine.com>
    nfp: flower: fix for take a mutex lock in soft irq context and rcu lock

Heiner Kallweit <hkallweit1@gmail.com>
    leds: trigger: netdev: fix RTNL handling to prevent potential deadlock

Petr Pavlu <petr.pavlu@suse.com>
    tracing: Fix a possible race when disabling buffered events

Petr Pavlu <petr.pavlu@suse.com>
    tracing: Fix incomplete locking when disabling buffered events

Steven Rostedt (Google) <rostedt@goodmis.org>
    tracing: Disable snapshot buffer when stopping instance tracers

Steven Rostedt (Google) <rostedt@goodmis.org>
    tracing: Stop current tracer when resizing buffer

Steven Rostedt (Google) <rostedt@goodmis.org>
    tracing: Always update snapshot buffer size

Heiko Carstens <hca@linux.ibm.com>
    checkstack: fix printed address

Tim Van Patten <timvp@google.com>
    cgroup_freezer: cgroup_freezing: Check if not frozen

Ming Lei <ming.lei@redhat.com>
    lib/group_cpus.c: avoid acquiring cpu hotplug lock in group_cpus_evenly

Ryusuke Konishi <konishi.ryusuke@gmail.com>
    nilfs2: prevent WARNING in nilfs_sufile_set_segment_usage()

Ryusuke Konishi <konishi.ryusuke@gmail.com>
    nilfs2: fix missing error check for sb_set_blocksize call

Su Hui <suhui@nfschina.com>
    highmem: fix a memory copy problem in memcpy_from_folio

Steven Rostedt (Google) <rostedt@goodmis.org>
    ring-buffer: Force absolute timestamp on discard of event

Steven Rostedt (Google) <rostedt@goodmis.org>
    ring-buffer: Test last update in 32bit version of __rb_time_read()

Takashi Iwai <tiwai@suse.de>
    ALSA: hda/realtek: Add quirk for Lenovo Yoga Pro 7

Mario Limonciello <mario.limonciello@amd.com>
    ALSA: hda/realtek: Add Framework laptop 16 to quirks

Tim Bosse <flinn@timbos.se>
    ALSA: hda/realtek: add new Framework laptop to quirks

Bin Li <bin.li@canonical.com>
    ALSA: hda/realtek: Enable headset on Lenovo M90 Gen5

Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
    ALSA: hda/realtek: fix speakers on XPS 9530 (2023)

Pascal Noël <pascal@pascalcompiles.com>
    ALSA: hda/realtek: Apply quirk for ASUS UM3504DA

Jason Zhang <jason.zhang@rock-chips.com>
    ALSA: pcm: fix out-of-bounds in snd_pcm_state_names

Sarah Grant <s@srd.tw>
    ALSA: usb-audio: Add Pioneer DJM-450 mixer controls

Pavel Begunkov <asml.silence@gmail.com>
    io_uring: fix mutex_unlock with unreferenced ctx

Georg Gottleuber <ggo@tuxedocomputers.com>
    nvme-pci: Add sleep quirk for Kingston drives

Pavel Begunkov <asml.silence@gmail.com>
    io_uring/af_unix: disable sending io_uring over sockets

Malcolm Hart <malcolm@5harts.com>
    ASoC: amd: yc: Fix non-functional mic on ASUS E1504FA

Masami Hiramatsu (Google) <mhiramat@kernel.org>
    rethook: Use __rcu pointer for rethook::handler

Florian Fainelli <florian.fainelli@broadcom.com>
    scripts/gdb: fix lx-device-list-bus and lx-device-list-class

Baoquan He <bhe@redhat.com>
    kernel/Kconfig.kexec: drop select of KEXEC for CRASH_DUMP

Yu Kuai <yukuai3@huawei.com>
    md: don't leave 'MD_RECOVERY_FROZEN' in error path of md_set_readonly()

Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
    riscv: errata: andes: Probe for IOCP only once in boot stage

Clément Léger <cleger@rivosinc.com>
    riscv: fix misaligned access handling of C.SWSP and C.SDSP

Sam Edwards <cfsworks@gmail.com>
    arm64: dts: rockchip: Fix eMMC Data Strobe PD on rk3588

Fabio Estevam <festevam@denx.de>
    ARM: dts: imx28-xea: Pass the 'model' property

Philipp Zabel <p.zabel@pengutronix.de>
    ARM: dts: imx7: Declare timers compatible with fsl,imx6dl-gpt

Stefan Eichenberger <stefan.eichenberger@toradex.com>
    arm64: dts: imx8-apalis: set wifi regulator to always-on

Kunwu Chan <chentao@kylinos.cn>
    ARM: imx: Check return value of devm_kasprintf in imx_mmdc_perf_init

Peng Fan <peng.fan@nxp.com>
    arm64: dts: imx93: correct mediamix power

Alexander Stein <alexander.stein@ew.tq-group.com>
    arm64: dts: freescale: imx8-ss-lsio: Fix #pwm-cells

Fabio Estevam <festevam@denx.de>
    arm64: dts: imx8-ss-lsio: Add PWM interrupts

Dinghao Liu <dinghao.liu@zju.edu.cn>
    scsi: be2iscsi: Fix a memleak in beiscsi_init_wrb_handle()

Petr Pavlu <petr.pavlu@suse.com>
    tracing: Fix a warning when allocating buffered events fails

Jens Axboe <axboe@kernel.dk>
    io_uring/kbuf: check for buffer list readiness after NULL check

Dan Carpenter <dan.carpenter@linaro.org>
    io_uring/kbuf: Fix an NULL vs IS_ERR() bug in io_alloc_pbuf_ring()

Fabio Estevam <festevam@denx.de>
    ARM: dts: imx6ul-pico: Describe the Ethernet PHY clock

Nathan Rossi <nathan.rossi@digi.com>
    arm64: dts: imx8mp: imx8mq: Add parkmode-disable-ss-quirk on DWC3

Arnd Bergmann <arnd@arndb.de>
    drm/bridge: tc358768: select CONFIG_VIDEOMODE_HELPERS

Shifeng Li <lishifeng@sangfor.com.cn>
    RDMA/irdma: Avoid free the non-cqp_request scratch

Mike Marciniszyn <mike.marciniszyn@intel.com>
    RDMA/irdma: Fix support for 64k pages

Mike Marciniszyn <mike.marciniszyn@intel.com>
    RDMA/irdma: Ensure iWarp QP queue memory is OS paged aligned

Mike Marciniszyn <mike.marciniszyn@intel.com>
    RDMA/core: Fix umem iterator when PAGE_SIZE is greater then HCA pgsz

Dinghao Liu <dinghao.liu@zju.edu.cn>
    ASoC: wm_adsp: fix memleak in wm_adsp_buffer_populate

Sudeep Holla <sudeep.holla@arm.com>
    firmware: arm_scmi: Fix possible frequency truncation when using level indexing mode

Ulf Hansson <ulf.hansson@linaro.org>
    firmware: arm_scmi: Simplify error path in scmi_dvfs_device_opps_add()

Sudeep Holla <sudeep.holla@arm.com>
    firmware: arm_scmi: Fix frequency truncation by promoting multiplier type

Ulf Hansson <ulf.hansson@linaro.org>
    firmware: arm_scmi: Extend perf protocol ops to get information of a domain

Ulf Hansson <ulf.hansson@linaro.org>
    firmware: arm_scmi: Extend perf protocol ops to get number of domains

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    hwmon: (nzxt-kraken2) Fix error handling path in kraken2_probe()

Neil Armstrong <neil.armstrong@linaro.org>
    ASoC: codecs: lpass-tx-macro: set active_decimator correct default value

Armin Wolf <W_Armin@gmx.de>
    hwmon: (acpi_power_meter) Fix 4.29 MW bug

Stefan Wahren <wahrenst@gmx.net>
    ARM: dts: bcm2711-rpi-400: Fix delete-node of led_act

Alex Bee <knaerzche@gmail.com>
    ARM: dts: rockchip: Fix sdmmc_pwren's pinmux setting for RK3128

Stefan Kerkmann <s.kerkmann@pengutronix.de>
    ARM: dts: imx6q: skov: fix ethernet clock regression

Alexander Stein <alexander.stein@ew.tq-group.com>
    arm64: dt: imx93: tqma9352-mba93xxla: Fix LPUART2 pad config

Shifeng Li <lishifeng1992@126.com>
    RDMA/irdma: Fix UAF in irdma_sc_ccq_get_cqe_info()

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

Shengjiu Wang <shengjiu.wang@nxp.com>
    ASoC: fsl_sai: Fix no frame sync clock issue on i.MX8MP

Alex Bee <knaerzche@gmail.com>
    arm64: dts: rockchip: Expand reg size of vdec node for RK3399

Jonas Karlman <jonas@kwiboo.se>
    arm64: dts: rockchip: Expand reg size of vdec node for RK3328

Mustafa Ismail <mustafa.ismail@intel.com>
    RDMA/irdma: Add wait for suspend on SQD

Mustafa Ismail <mustafa.ismail@intel.com>
    RDMA/irdma: Do not modify to SQD on error

Junxian Huang <huangjunxian6@hisilicon.com>
    RDMA/hns: Fix unnecessary err return when using invalid congest control algorithm

Shigeru Yoshida <syoshida@redhat.com>
    RDMA/core: Fix uninit-value access in ib_get_eth_speed()

Sumit Garg <sumit.garg@linaro.org>
    tee: optee: Fix supplicant based device enumeration

Dan Carpenter <dan.carpenter@linaro.org>
    mm/damon/sysfs: eliminate potential uninitialized variable warning

Arvind Yadav <Arvind.Yadav@amd.com>
    drm/amdkfd: get doorbell's absolute offset based on the db_size

Lee Jones <lee@kernel.org>
    drm/amd/amdgpu/amdgpu_doorbell_mgr: Correct misdocumented param 'doorbell_index'

Wen Gu <guwen@linux.alibaba.com>
    net/smc: fix missing byte order conversion in CLC handshake

Sean Nyekjaer <sean@geanix.com>
    net: dsa: microchip: provide a list of valid protocols for xmit handler

Ido Schimmel <idosch@nvidia.com>
    drop_monitor: Require 'CAP_SYS_ADMIN' when joining "events" group

Ido Schimmel <idosch@nvidia.com>
    psample: Require 'CAP_NET_ADMIN' when joining "packets" group

John Fastabend <john.fastabend@gmail.com>
    bpf: sockmap, updating the sg structure should also update curr

John Fastabend <john.fastabend@gmail.com>
    net: tls, update curr on splice as well

Tobias Waldekranz <tobias@waldekranz.com>
    net: dsa: mv88e6xxx: Restore USXGMII support for 6393X

Eric Dumazet <edumazet@google.com>
    tcp: do not accept ACK of bytes we never sent

Phil Sutter <phil@nwl.cc>
    netfilter: xt_owner: Fix for unsafe access of sk->sk_socket

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: validate family when identifying table via handle

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: bail out on mismatching dynset and set expressions

Florian Westphal <fw@strlen.de>
    netfilter: nf_tables: fix 'exist' matching on bigendian arches

D. Wythe <alibuda@linux.alibaba.com>
    netfilter: bpf: fix bad registration on nf_defrag

Konrad Dybcio <konrad.dybcio@linaro.org>
    dt-bindings: interrupt-controller: Allow #power-domain-cells

Rahul Bhansali <rbhansali@marvell.com>
    octeontx2-af: Update Tx link register range

Geetha sowjanya <gakula@marvell.com>
    octeontx2-af: Add missing mcs flr handler call

Geetha sowjanya <gakula@marvell.com>
    octeontx2-af: Fix mcs stats register address

Geetha sowjanya <gakula@marvell.com>
    octeontx2-af: Fix mcs sa cam entries size

Nithin Dabilpuram <ndabilpuram@marvell.com>
    octeontx2-af: Adjust Tx credits when MCS external bypass is disabled

Yonglong Liu <liuyonglong@huawei.com>
    net: hns: fix fake link up on xge port

Yonglong Liu <liuyonglong@huawei.com>
    net: hns: fix wrong head when modify the tx feature when sending packets

Daniil Maximov <daniil31415it@gmail.com>
    net: atlantic: Fix NULL dereference of skb pointer in

Shigeru Yoshida <syoshida@redhat.com>
    ipv4: ip_gre: Avoid skb_pull() failure in ipgre_xmit()

Brett Creeley <brett.creeley@amd.com>
    ionic: Fix dim work handling in split interrupt mode

Shannon Nelson <shannon.nelson@amd.com>
    ionic: fix snprintf format length warning

Paolo Abeni <pabeni@redhat.com>
    tcp: fix mid stream window clamp.

Dinghao Liu <dinghao.liu@zju.edu.cn>
    net: bnxt: fix a potential use-after-free in bnxt_init_tc

Jacob Keller <jacob.e.keller@intel.com>
    iavf: validate tx_coalesce_usecs even if rx_coalesce_usecs is zero

Ivan Vecera <ivecera@redhat.com>
    i40e: Fix unexpected MFS warning message

Marcin Szycik <marcin.szycik@linux.intel.com>
    ice: Restore fix disabling RX VLAN filtering

Zhipeng Lu <alexious@zju.edu.cn>
    octeontx2-af: fix a use-after-free in rvu_npa_register_reporters

Yewon Choi <woni9911@gmail.com>
    xsk: Skip polling event check for unbound socket

Jianheng Zhang <Jianheng.Zhang@synopsys.com>
    net: stmmac: fix FPE events losing

Naveen Mamindlapalli <naveenm@marvell.com>
    octeontx2-pf: consider both Rx and Tx packet stats for adaptive interrupt coalescing

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
    r8152: Hold the rtnl_lock for all of reset

Randy Dunlap <rdunlap@infradead.org>
    hv_netvsc: rndis_filter needs to select NLS

Yonghong Song <yonghong.song@linux.dev>
    bpf: Fix a verifier bug due to incorrect branch offset comparison with cpu=v4

Subbaraya Sundeep <sbhatta@marvell.com>
    octeontx2-af: Check return value of nix_get_nixlf before using nixlf

Subbaraya Sundeep <sbhatta@marvell.com>
    octeontx2-pf: Add missing mutex lock in otx2_get_pauseparam

Eric Dumazet <edumazet@google.com>
    ipv6: fix potential NULL deref in fib6_add()

Armin Wolf <W_Armin@gmx.de>
    platform/x86: wmi: Skip blocks with zero instances

Luca Ceresoli <luca.ceresoli@bootlin.com>
    of: dynamic: Fix of_reconfig_get_state_change() return value documentation

Hans de Goede <hdegoede@redhat.com>
    platform/x86: asus-wmi: Move i8042 filter install to shared asus-wmi code

Nícolas F. R. A. Prado <nfraprado@collabora.com>
    dt: dt-extract-compatibles: Don't follow symlinks when walking tree

Nícolas F. R. A. Prado <nfraprado@collabora.com>
    dt: dt-extract-compatibles: Handle cfile arguments in generator function

Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
    x86/tdx: Allow 32-bit emulation by default

Thomas Gleixner <tglx@linutronix.de>
    x86/entry: Do not allow external 0x80 interrupts

Thomas Gleixner <tglx@linutronix.de>
    x86/entry: Convert INT 0x80 emulation to IDTENTRY

Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
    x86/coco: Disable 32-bit emulation by default on TDX and SEV

Nikolay Borisov <nik.borisov@suse.com>
    x86: Introduce ia32_enabled()

Mikulas Patocka <mpatocka@redhat.com>
    dm-crypt: start allocating with MAX_ORDER

YuanShang <YuanShang.Mao@amd.com>
    drm/amdgpu: correct chunk_ptr to a pointer to chunk.

Le Ma <le.ma@amd.com>
    drm/amdgpu: finalizing mem_partitions at the end of GMC v9 sw_fini

Victor Lu <victorchengchi.lu@amd.com>
    drm/amdgpu: Do not program VF copy regs in mmhub v1.8 under SRIOV (v2)

Masahiro Yamada <masahiroy@kernel.org>
    kconfig: fix memory leak from range properties

Masahiro Yamada <masahiroy@kernel.org>
    modpost: fix section mismatch message for RELA

Alex Pakhunov <alexey.pakhunov@spacex.com>
    tg3: Increment tx_dropped in tg3_tso_bug()

Alex Pakhunov <alexey.pakhunov@spacex.com>
    tg3: Move the [rt]x_dropped counters to tg3_napi

Nick Terrell <terrelln@fb.com>
    zstd: Fix array-index-out-of-bounds UBSAN warning

Dave Airlie <airlied@redhat.com>
    nouveau: use an rwlock for the event lock.

Jozsef Kadlecsik <kadlec@netfilter.org>
    netfilter: ipset: fix race condition between swap/destroy and kernel side add/del/test

Samuel Holland <samuel.holland@sifive.com>
    i2c: ocores: Move system PM hooks to the NOIRQ phase

Jan Bottorff <janb@os.amperecomputing.com>
    i2c: designware: Fix corrupted memory seen in the ISR

Thomas Gleixner <tglx@linutronix.de>
    hrtimers: Push pending hrtimers away from outgoing CPU earlier

Mike Christie <michael.christie@oracle.com>
    scsi: sd: Fix sshdr use in sd_suspend_common()

Steve Sistare <steven.sistare@oracle.com>
    vdpa/mlx5: preserve CVQ vringh index


-------------

Diffstat:

 Documentation/ABI/testing/sysfs-bus-optee-devices  |   9 +
 .../bindings/interrupt-controller/qcom,mpm.yaml    |   4 +
 Makefile                                           |   4 +-
 arch/arm/boot/dts/broadcom/bcm2711-rpi-400.dts     |   4 +-
 .../dts/nxp/imx/imx6q-skov-reve-mi1010ait-1cp1.dts |   4 +-
 arch/arm/boot/dts/nxp/imx/imx6ul-pico.dtsi         |   2 +
 arch/arm/boot/dts/nxp/imx/imx7s.dtsi               |   8 +-
 arch/arm/boot/dts/nxp/mxs/imx28-xea.dts            |   1 +
 arch/arm/boot/dts/rockchip/rk3128.dtsi             |   2 +-
 arch/arm/include/asm/kexec.h                       |   4 -
 arch/arm/kernel/Makefile                           |   2 +-
 arch/arm/mach-imx/mmdc.c                           |   7 +-
 .../arm64/boot/dts/freescale/imx8-apalis-v1.1.dtsi |   5 +-
 arch/arm64/boot/dts/freescale/imx8-ss-lsio.dtsi    |  12 +-
 arch/arm64/boot/dts/freescale/imx8mp.dtsi          |   2 +
 arch/arm64/boot/dts/freescale/imx8mq.dtsi          |   2 +
 .../dts/freescale/imx93-tqma9352-mba93xxla.dts     |   2 +-
 arch/arm64/boot/dts/freescale/imx93.dtsi           |   2 +-
 .../boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts  |   2 +-
 arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts       |   2 +-
 .../boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts  |  12 +-
 arch/arm64/boot/dts/mediatek/mt7986a.dtsi          |  24 +-
 arch/arm64/boot/dts/mediatek/mt8173-evb.dts        |   4 +-
 arch/arm64/boot/dts/mediatek/mt8183-evb.dts        |  52 ++---
 .../boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi    |   8 +-
 arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi     |  96 ++++----
 arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts    |  12 +-
 arch/arm64/boot/dts/mediatek/mt8183.dtsi           | 242 ++++++++++-----------
 arch/arm64/boot/dts/mediatek/mt8186.dtsi           |  44 ++--
 arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi    |   2 +-
 arch/arm64/boot/dts/mediatek/mt8195.dtsi           |   6 +-
 arch/arm64/boot/dts/rockchip/rk3328.dtsi           |   2 +-
 arch/arm64/boot/dts/rockchip/rk3399.dtsi           |   6 +-
 arch/arm64/boot/dts/rockchip/rk3588s-pinctrl.dtsi  |   2 +-
 arch/loongarch/net/bpf_jit.c                       |  12 +-
 arch/mips/Kconfig                                  |   2 +
 arch/mips/include/asm/mach-loongson64/boot_param.h |   9 +-
 arch/mips/kernel/process.c                         |  25 ++-
 arch/mips/loongson64/env.c                         |  10 +-
 arch/mips/loongson64/init.c                        |  47 ++--
 arch/parisc/Kconfig                                |   7 +-
 arch/parisc/include/asm/bug.h                      |  36 +--
 arch/powerpc/kernel/trace/ftrace_entry.S           |   4 +-
 arch/riscv/Kconfig.socs                            |   1 +
 arch/riscv/errata/andes/errata.c                   |  20 +-
 arch/riscv/kernel/traps_misaligned.c               |   6 +-
 arch/s390/mm/pgtable.c                             |   2 +-
 arch/x86/coco/tdx/tdx.c                            |   1 +
 arch/x86/entry/common.c                            |  97 ++++++++-
 arch/x86/entry/entry_64_compat.S                   |  77 -------
 arch/x86/include/asm/ia32.h                        |  23 +-
 arch/x86/include/asm/idtentry.h                    |   4 +
 arch/x86/include/asm/proto.h                       |   4 -
 arch/x86/kernel/cpu/amd.c                          |   3 +
 arch/x86/kernel/idt.c                              |   2 +-
 arch/x86/kernel/sev.c                              |  11 +-
 arch/x86/kvm/svm/svm.c                             |   8 +-
 arch/x86/mm/mem_encrypt_amd.c                      |  11 +
 arch/x86/xen/enlighten_pv.c                        |   2 +-
 arch/x86/xen/xen-asm.S                             |   2 +-
 drivers/base/cpu.c                                 |   6 +-
 drivers/base/devcoredump.c                         |   3 +
 drivers/base/memory.c                              |  18 +-
 drivers/base/regmap/regcache.c                     |   3 +-
 drivers/firmware/arm_scmi/perf.c                   |  87 +++++---
 drivers/gpio/gpiolib-sysfs.c                       |  15 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c             |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |   4 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h       |   5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c   |  15 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c              |   5 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c            |   6 +-
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c             |  10 +-
 drivers/gpu/drm/amd/amdgpu/soc15.c                 |   3 +-
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  |   3 +-
 drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c          |  10 +-
 .../gpu/drm/amd/amdkfd/kfd_process_queue_manager.c |   3 +-
 drivers/gpu/drm/bridge/Kconfig                     |   1 +
 drivers/gpu/drm/drm_atomic_helper.c                |  78 ++++---
 drivers/gpu/drm/i915/display/icl_dsi.c             |   7 +
 drivers/gpu/drm/i915/display/intel_crt.c           |   5 +
 drivers/gpu/drm/i915/display/intel_display.c       |  12 +-
 drivers/gpu/drm/i915/display/intel_display.h       |   3 +
 drivers/gpu/drm/i915/display/intel_dp.c            |   4 +
 drivers/gpu/drm/i915/display/intel_dp_mst.c        |  20 +-
 drivers/gpu/drm/i915/display/intel_dvo.c           |   6 +
 drivers/gpu/drm/i915/display/intel_hdmi.c          |   4 +
 drivers/gpu/drm/i915/display/intel_lvds.c          |   5 +
 drivers/gpu/drm/i915/display/intel_sdvo.c          |   8 +-
 drivers/gpu/drm/i915/display/intel_tv.c            |   8 +-
 drivers/gpu/drm/i915/display/vlv_dsi.c             |  18 +-
 drivers/gpu/drm/nouveau/dispnv50/disp.c            |   2 +-
 drivers/gpu/drm/nouveau/include/nvkm/core/event.h  |   4 +-
 drivers/gpu/drm/nouveau/nvkm/core/event.c          |  12 +-
 drivers/hwmon/acpi_power_meter.c                   |   4 +
 drivers/hwmon/nzxt-kraken2.c                       |   4 +-
 drivers/hwtracing/coresight/coresight-etm-perf.c   |   4 +-
 drivers/hwtracing/coresight/coresight-etm4x-core.c |   6 +-
 drivers/hwtracing/coresight/ultrasoc-smb.c         |  58 ++---
 drivers/hwtracing/coresight/ultrasoc-smb.h         |   6 +-
 drivers/hwtracing/ptt/hisi_ptt.c                   |   5 +
 drivers/i2c/busses/i2c-designware-common.c         |  16 +-
 drivers/i2c/busses/i2c-ocores.c                    |   4 +-
 drivers/infiniband/core/umem.c                     |   6 -
 drivers/infiniband/core/verbs.c                    |   2 +-
 drivers/infiniband/hw/bnxt_re/main.c               |   2 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c         |  13 +-
 drivers/infiniband/hw/irdma/hw.c                   |  16 +-
 drivers/infiniband/hw/irdma/main.c                 |   2 +-
 drivers/infiniband/hw/irdma/main.h                 |   2 +-
 drivers/infiniband/hw/irdma/verbs.c                |  35 ++-
 drivers/infiniband/hw/irdma/verbs.h                |   1 +
 drivers/infiniband/ulp/rtrs/rtrs-clt.c             |   7 +-
 drivers/infiniband/ulp/rtrs/rtrs-srv.c             |  37 +++-
 drivers/leds/trigger/ledtrig-netdev.c              |  11 +-
 drivers/md/dm-crypt.c                              |   2 +-
 drivers/md/md.c                                    |  24 +-
 drivers/md/raid5.c                                 |   4 +-
 drivers/misc/mei/client.c                          |   4 +-
 drivers/net/arcnet/arcdevice.h                     |   2 +
 drivers/net/arcnet/com20020-pci.c                  |  89 ++++----
 drivers/net/dsa/microchip/ksz_common.c             |  16 +-
 drivers/net/dsa/mv88e6xxx/pcs-639x.c               |  31 ++-
 drivers/net/ethernet/aquantia/atlantic/aq_ptp.c    |  10 +-
 drivers/net/ethernet/aquantia/atlantic/aq_ptp.h    |   4 +-
 drivers/net/ethernet/aquantia/atlantic/aq_ring.c   |  18 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c       |   1 +
 drivers/net/ethernet/broadcom/tg3.c                |  42 +++-
 drivers/net/ethernet/broadcom/tg3.h                |   4 +-
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c  |  29 +++
 drivers/net/ethernet/hisilicon/hns/hns_enet.c      |  53 +++--
 drivers/net/ethernet/hisilicon/hns/hns_enet.h      |   3 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c        |   2 +-
 drivers/net/ethernet/intel/iavf/iavf_ethtool.c     |  12 +-
 drivers/net/ethernet/intel/iavf/iavf_txrx.h        |   1 -
 .../net/ethernet/intel/ice/ice_vf_vsi_vlan_ops.c   |  11 +-
 drivers/net/ethernet/marvell/octeontx2/af/mbox.h   |   2 +-
 drivers/net/ethernet/marvell/octeontx2/af/mcs.c    |  18 +-
 drivers/net/ethernet/marvell/octeontx2/af/mcs.h    |   2 +
 .../net/ethernet/marvell/octeontx2/af/mcs_reg.h    |  31 ++-
 drivers/net/ethernet/marvell/octeontx2/af/rvu.c    |   3 +
 drivers/net/ethernet/marvell/octeontx2/af/rvu.h    |   1 +
 .../ethernet/marvell/octeontx2/af/rvu_devlink.c    |   5 +-
 .../net/ethernet/marvell/octeontx2/af/rvu_nix.c    |   8 +
 .../net/ethernet/marvell/octeontx2/af/rvu_npc.c    |   8 +-
 .../net/ethernet/marvell/octeontx2/af/rvu_reg.c    |   4 +-
 .../net/ethernet/marvell/octeontx2/af/rvu_reg.h    |   1 +
 .../ethernet/marvell/octeontx2/nic/otx2_ethtool.c  |   6 +-
 .../net/ethernet/marvell/octeontx2/nic/otx2_pf.c   |   9 +
 .../net/ethernet/marvell/octeontx2/nic/otx2_txrx.c |  20 +-
 .../ethernet/netronome/nfp/flower/tunnel_conf.c    | 127 ++++++++---
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
 drivers/net/usb/r8152.c                            |  27 ++-
 drivers/nvme/host/nvme.h                           |   5 +
 drivers/nvme/host/pci.c                            |  16 +-
 drivers/nvmem/core.c                               |   6 +
 drivers/of/dynamic.c                               |   5 +-
 drivers/parport/parport_pc.c                       |  21 ++
 drivers/platform/mellanox/mlxbf-bootctl.c          |  39 ++--
 drivers/platform/mellanox/mlxbf-pmc.c              |  14 ++
 drivers/platform/surface/aggregator/core.c         |   5 +-
 drivers/platform/x86/Kconfig                       |   2 +-
 drivers/platform/x86/asus-nb-wmi.c                 |  11 -
 drivers/platform/x86/asus-wmi.c                    |   8 +
 drivers/platform/x86/wmi.c                         |   5 +
 drivers/powercap/dtpm_cpu.c                        |  17 +-
 drivers/scsi/be2iscsi/be_main.c                    |   1 +
 drivers/scsi/sd.c                                  |  53 ++---
 drivers/tee/optee/device.c                         |  17 +-
 drivers/tty/serial/8250/8250_dw.c                  |   1 +
 drivers/tty/serial/8250/8250_early.c               |   1 +
 drivers/tty/serial/8250/8250_omap.c                |  14 +-
 drivers/tty/serial/amba-pl011.c                    | 112 +++++-----
 drivers/tty/serial/ma35d1_serial.c                 |  10 +-
 drivers/tty/serial/sc16is7xx.c                     |  12 +
 drivers/usb/gadget/function/f_hid.c                |   7 +-
 drivers/usb/gadget/udc/core.c                      |   4 +-
 drivers/usb/host/xhci-pci.c                        |   2 -
 drivers/usb/typec/class.c                          |   5 +-
 drivers/vdpa/mlx5/net/mlx5_vnet.c                  |   7 +-
 fs/nilfs2/sufile.c                                 |  44 +++-
 fs/nilfs2/the_nilfs.c                              |   6 +-
 fs/smb/client/cifsfs.c                             | 174 +++++++++++++--
 fs/smb/client/smb2ops.c                            |   2 +
 include/drm/drm_atomic_helper.h                    |   2 +
 include/linux/cpuhotplug.h                         |   1 +
 include/linux/highmem.h                            |   2 +-
 include/linux/hrtimer.h                            |   4 +-
 include/linux/hugetlb.h                            |   5 +-
 include/linux/kprobes.h                            |  13 +-
 include/linux/rethook.h                            |   7 +-
 include/linux/scmi_protocol.h                      |  10 +
 include/linux/stmmac.h                             |   1 +
 include/net/genetlink.h                            |   2 +
 include/net/tcp.h                                  |   9 +-
 include/rdma/ib_umem.h                             |   9 +-
 include/rdma/ib_verbs.h                            |   1 +
 io_uring/io_uring.c                                |   9 +-
 io_uring/kbuf.c                                    |   8 +-
 io_uring/rsrc.h                                    |   7 -
 kernel/Kconfig.kexec                               |   1 -
 kernel/bpf/core.c                                  |  12 +-
 kernel/cgroup/legacy_freezer.c                     |   8 +-
 kernel/cpu.c                                       |   8 +-
 kernel/events/core.c                               |  61 ++++--
 kernel/kprobes.c                                   |   4 +-
 kernel/time/hrtimer.c                              |  33 +--
 kernel/trace/rethook.c                             |  23 +-
 kernel/trace/ring_buffer.c                         |  23 +-
 kernel/trace/trace.c                               | 200 +++++++----------
 kernel/workqueue.c                                 |  22 +-
 lib/group_cpus.c                                   |  22 +-
 lib/zstd/common/fse_decompress.c                   |   2 +-
 mm/damon/sysfs.c                                   |   2 +-
 mm/filemap.c                                       |   2 +-
 mm/hugetlb.c                                       |   7 +
 mm/memory_hotplug.c                                |  15 +-
 net/core/drop_monitor.c                            |   4 +-
 net/core/filter.c                                  |  19 ++
 net/core/scm.c                                     |   6 +
 net/ipv4/ip_gre.c                                  |  11 +-
 net/ipv4/tcp.c                                     |  22 +-
 net/ipv4/tcp_input.c                               |   6 +-
 net/ipv6/ip6_fib.c                                 |   6 +-
 net/netfilter/ipset/ip_set_core.c                  |  14 +-
 net/netfilter/nf_bpf_link.c                        |  10 +-
 net/netfilter/nf_tables_api.c                      |   5 +-
 net/netfilter/nft_dynset.c                         |  13 +-
 net/netfilter/nft_exthdr.c                         |   4 +-
 net/netfilter/nft_fib.c                            |   8 +-
 net/netfilter/nft_set_pipapo.c                     |   3 +
 net/netfilter/xt_owner.c                           |  16 +-
 net/netlink/genetlink.c                            |   3 +
 net/packet/af_packet.c                             |  16 +-
 net/packet/internal.h                              |   2 +-
 net/psample/psample.c                              |   3 +-
 net/smc/af_smc.c                                   |   4 +-
 net/smc/smc_clc.c                                  |   9 +-
 net/smc/smc_clc.h                                  |   4 +-
 net/tls/tls_sw.c                                   |   2 +
 net/xdp/xsk.c                                      |   5 +-
 scripts/checkstack.pl                              |   8 +-
 scripts/dtc/dt-extract-compatibles                 |  31 ++-
 scripts/gcc-plugins/randomize_layout_plugin.c      |   3 +-
 scripts/gdb/linux/device.py                        |  16 +-
 scripts/kconfig/symbol.c                           |  14 +-
 scripts/mod/modpost.c                              |   6 +-
 sound/core/pcm.c                                   |   1 +
 sound/pci/hda/patch_realtek.c                      |   6 +
 sound/soc/amd/yc/acp6x-mach.c                      |   7 +
 sound/soc/codecs/lpass-tx-macro.c                  |   5 +
 sound/soc/codecs/wm_adsp.c                         |   8 +-
 sound/soc/fsl/fsl_sai.c                            |  21 ++
 sound/soc/qcom/sc8280xp.c                          |  17 ++
 sound/soc/soc-ops.c                                |   2 +-
 sound/usb/mixer_quirks.c                           |  30 +++
 tools/perf/builtin-list.c                          |   6 +
 .../arch/arm64/ampere/ampereone/metrics.json       |   2 +
 tools/perf/util/metricgroup.c                      |   2 +-
 268 files changed, 2516 insertions(+), 1404 deletions(-)


