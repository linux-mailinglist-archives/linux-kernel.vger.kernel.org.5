Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B157580D86D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 19:45:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345441AbjLKSpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 13:45:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345374AbjLKSp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 13:45:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93256AC
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 10:45:31 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ED3BC433C8;
        Mon, 11 Dec 2023 18:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1702320331;
        bh=rNbgAAfVhd/H8l8CVqCXWdnKv0mffVlOFp2ij5q31ec=;
        h=From:To:Cc:Subject:Date:From;
        b=GitOaQblXxq62k/djQZ9uAEDe58lBEieV3DUA1xRInmTV3jDQinsXxTUjAF5pLDaN
         s3cG7n4/qoMihAIdBBo5iOZjqFhRDRsS2lMSqejgpICWUR/Wtm7woPyM8LZMd2VT8Y
         YD17EyB0PngCmHJFb1TIuz2YRAKkmoglLnwihxLw=
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
Subject: [PATCH 6.1 000/194] 6.1.68-rc1 review
Date:   Mon, 11 Dec 2023 19:19:50 +0100
Message-ID: <20231211182036.606660304@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.68-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.1.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.1.68-rc1
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

This is the start of the stable review cycle for the 6.1.68 release.
There are 194 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed, 13 Dec 2023 18:19:59 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.68-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 6.1.68-rc1

Ville Syrjälä <ville.syrjala@linux.intel.com>
    drm/i915: Skip some timing checks on BXT/GLK DSI transcoders

Jani Nikula <jani.nikula@intel.com>
    drm/i915/sdvo: stop caching has_hdmi_monitor in struct intel_sdvo

Ville Syrjälä <ville.syrjala@linux.intel.com>
    drm/i915/lvds: Use REG_BIT() & co.

Ankit Nautiyal <ankit.k.nautiyal@intel.com>
    drm/i915/display: Drop check for doublescan mode in modevalid

Jia Jie Ho <jiajie.ho@starfivetech.com>
    riscv: Kconfig: Add select ARM_AMBA to SOC_STARFIVE

Florian Westphal <fw@strlen.de>
    netfilter: nft_set_pipapo: skip inactive elements during set walk

Jiaxun Yang <jiaxun.yang@flygoat.com>
    MIPS: Loongson64: Enable DMA noncoherent support

Jiaxun Yang <jiaxun.yang@flygoat.com>
    MIPS: Loongson64: Handle more memory types passed from firmware

Jiaxun Yang <jiaxun.yang@flygoat.com>
    MIPS: Loongson64: Reserve vgabios memory on boot

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

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    serial: 8250_dw: Add ACPI ID for Granite Rapids-D UART

Konstantin Aladyshev <aladyshev22@gmail.com>
    usb: gadget: f_hid: fix report descriptor allocation

Candice Li <candice.li@amd.com>
    drm/amdgpu: Update EEPROM I2C address for smu v13_0_0

Candice Li <candice.li@amd.com>
    drm/amdgpu: Add I2C EEPROM support on smu v13_0_6

Alex Deucher <alexander.deucher@amd.com>
    drm/amdgpu: simplify amdgpu_ras_eeprom.c

Luben Tuikov <luben.tuikov@amd.com>
    drm/amdgpu: Return from switch early for EEPROM I2C address

Luben Tuikov <luben.tuikov@amd.com>
    drm/amdgpu: Remove second moot switch to set EEPROM I2C address

Luben Tuikov <luben.tuikov@amd.com>
    drm/amdgpu: Add support for RAS table at 0x40000

Luben Tuikov <luben.tuikov@amd.com>
    drm/amdgpu: Decouple RAS EEPROM addresses from chips

Luben Tuikov <luben.tuikov@amd.com>
    drm/amdgpu: Remove redundant I2C EEPROM address

Candice Li <candice.li@amd.com>
    drm/amdgpu: Add EEPROM I2C address support for ip discovery

Candice Li <candice.li@amd.com>
    drm/amdgpu: Update ras eeprom support for smu v13_0_0 and v13_0_10

Prike Liang <Prike.Liang@amd.com>
    drm/amdgpu: correct the amdgpu runtime dereference usage count

Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
    drm/amd/amdgpu: Fix warnings in amdgpu/amdgpu_display.c

Tim Huang <Tim.Huang@amd.com>
    drm/amdgpu: fix memory overflow in the IB test

Boerge Struempfel <boerge.struempfel@gmail.com>
    gpiolib: sysfs: Fix error handling on failed export

Ashwin Dayanand Kamat <ashwin.kamat@broadcom.com>
    x86/sev: Fix kernel crash due to late update to read-only ghcb_version

Peter Zijlstra <peterz@infradead.org>
    perf: Fix perf_event_validate_size()

Hsin-Yi Wang <hsinyi@chromium.org>
    arm64: dts: mt8183: kukui: Fix underscores in node names

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    arm64: dts: mediatek: add missing space before {

Helge Deller <deller@gmx.de>
    parisc: Fix asm operand number out of range build error in bug table

Helge Deller <deller@gmx.de>
    parisc: Reduce size of the bug_table on 64-bit kernel by half

Steven Rostedt (Google) <rostedt@goodmis.org>
    tracing: Stop current tracer when resizing buffer

Zheng Yejian <zhengyejian1@huawei.com>
    tracing: Set actual size after ring buffer resize

Steven Rostedt (Google) <rostedt@goodmis.org>
    ring-buffer: Force absolute timestamp on discard of event

Hengqi Chen <hengqi.chen@gmail.com>
    LoongArch: BPF: Don't sign extend function return value

Hengqi Chen <hengqi.chen@gmail.com>
    LoongArch: BPF: Don't sign extend memory load operand

Su Hui <suhui@nfschina.com>
    misc: mei: client.c: fix problem of return '-EOVERFLOW' in mei_cl_write

Su Hui <suhui@nfschina.com>
    misc: mei: client.c: return negative error code in mei_cl_write

Junhao He <hejunhao3@huawei.com>
    hwtracing: hisi_ptt: Add dummy callback pmu::read()

Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    coresight: etm4x: Remove bogous __exit annotation for some functions

Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    coresight: etm4x: Make etm4_remove_dev() return void

Carlos Llamas <cmllamas@google.com>
    binder: fix memory leaks of spam and pending work

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

David Jeffery <djeffery@redhat.com>
    md/raid6: use valid sector values to determine if an I/O should wait on the reshape

Lukasz Luba <lukasz.luba@arm.com>
    powercap: DTPM: Fix missing cpufreq_cpu_put() calls

Hugh Dickins <hughd@google.com>
    mm: fix oops when filemap_map_pmd() without prealloc_pte

Mike Kravetz <mike.kravetz@oracle.com>
    hugetlb: fix null-ptr-deref in hugetlb_vma_lock_write

Francesco Dolcini <francesco.dolcini@toradex.com>
    platform/surface: aggregator: fix recv_buf() return value

Matthias Reichl <hias@horus.com>
    regmap: fix bogus error on regcache_sync success

ChunHao Lin <hau@realtek.com>
    r8169: fix rtl8125b PAUSE frames blasting when suspended

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

Tim Van Patten <timvp@google.com>
    cgroup_freezer: cgroup_freezing: Check if not frozen

Ryusuke Konishi <konishi.ryusuke@gmail.com>
    nilfs2: prevent WARNING in nilfs_sufile_set_segment_usage()

Ryusuke Konishi <konishi.ryusuke@gmail.com>
    nilfs2: fix missing error check for sb_set_blocksize call

Steven Rostedt (Google) <rostedt@goodmis.org>
    ring-buffer: Test last update in 32bit version of __rb_time_read()

Mario Limonciello <mario.limonciello@amd.com>
    ALSA: hda/realtek: Add Framework laptop 16 to quirks

Tim Bosse <flinn@timbos.se>
    ALSA: hda/realtek: add new Framework laptop to quirks

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

Pavel Begunkov <asml.silence@gmail.com>
    io_uring/af_unix: disable sending io_uring over sockets

Malcolm Hart <malcolm@5harts.com>
    ASoC: amd: yc: Fix non-functional mic on ASUS E1504FA

JP Kobryn <inwardvessel@gmail.com>
    kprobes: consistent rcu api usage for kretprobe holder

Masami Hiramatsu (Google) <mhiramat@kernel.org>
    rethook: Use __rcu pointer for rethook::handler

Robin Murphy <robin.murphy@arm.com>
    iommu: Avoid more races around device probe

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

Arnd Bergmann <arnd@arndb.de>
    drm/bridge: tc358768: select CONFIG_VIDEOMODE_HELPERS

Shifeng Li <lishifeng@sangfor.com.cn>
    RDMA/irdma: Avoid free the non-cqp_request scratch

Mike Marciniszyn <mike.marciniszyn@intel.com>
    RDMA/core: Fix umem iterator when PAGE_SIZE is greater then HCA pgsz

Dinghao Liu <dinghao.liu@zju.edu.cn>
    ASoC: wm_adsp: fix memleak in wm_adsp_buffer_populate

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    hwmon: (nzxt-kraken2) Fix error handling path in kraken2_probe()

Neil Armstrong <neil.armstrong@linaro.org>
    ASoC: codecs: lpass-tx-macro: set active_decimator correct default value

Armin Wolf <W_Armin@gmx.de>
    hwmon: (acpi_power_meter) Fix 4.29 MW bug

Shifeng Li <lishifeng1992@126.com>
    RDMA/irdma: Fix UAF in irdma_sc_ccq_get_cqe_info()

Sindhu Devale <sindhu.devale@intel.com>
    RDMA/irdma: Refactor error handling in create CQP

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

Sumit Garg <sumit.garg@linaro.org>
    tee: optee: Fix supplicant based device enumeration

Dan Carpenter <dan.carpenter@linaro.org>
    mm/damon/sysfs: eliminate potential uninitialized variable warning

Ido Schimmel <idosch@nvidia.com>
    drop_monitor: Require 'CAP_SYS_ADMIN' when joining "events" group

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

Florian Westphal <fw@strlen.de>
    netfilter: nf_tables: fix 'exist' matching on bigendian arches

Jeremy Sowden <jeremy@azazel.net>
    netfilter: nft_exthdr: add boolean DCCP option matching

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

YuanShang <YuanShang.Mao@amd.com>
    drm/amdgpu: correct chunk_ptr to a pointer to chunk.

Masahiro Yamada <masahiroy@kernel.org>
    kconfig: fix memory leak from range properties

Alex Pakhunov <alexey.pakhunov@spacex.com>
    tg3: Increment tx_dropped in tg3_tso_bug()

Alex Pakhunov <alexey.pakhunov@spacex.com>
    tg3: Move the [rt]x_dropped counters to tg3_napi

Nick Terrell <terrelln@fb.com>
    zstd: Fix array-index-out-of-bounds UBSAN warning

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
 .../bindings/interrupt-controller/qcom,mpm.yaml    |   4 +
 Makefile                                           |   4 +-
 arch/arm/boot/dts/imx28-xea.dts                    |   1 +
 arch/arm/boot/dts/imx6ul-pico.dtsi                 |   2 +
 arch/arm/boot/dts/imx7s.dtsi                       |   8 +-
 arch/arm/mach-imx/mmdc.c                           |   7 +-
 arch/arm64/boot/dts/freescale/imx8mp.dtsi          |   2 +
 arch/arm64/boot/dts/freescale/imx8mq.dtsi          |   4 +-
 .../boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts  |   2 +-
 arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts       |   2 +-
 arch/arm64/boot/dts/mediatek/mt8173-evb.dts        |   4 +-
 arch/arm64/boot/dts/mediatek/mt8183-evb.dts        |  52 ++---
 .../boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi    |   8 +-
 arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi     |  96 ++++----
 arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts    |  12 +-
 arch/arm64/boot/dts/mediatek/mt8183.dtsi           | 242 ++++++++++-----------
 arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi    |   2 +-
 arch/arm64/boot/dts/mediatek/mt8195.dtsi           |   6 +-
 arch/arm64/boot/dts/rockchip/rk3328.dtsi           |   2 +-
 arch/arm64/boot/dts/rockchip/rk3399.dtsi           |   6 +-
 arch/loongarch/net/bpf_jit.c                       |  12 +-
 arch/mips/Kconfig                                  |   2 +
 arch/mips/include/asm/mach-loongson64/boot_param.h |   9 +-
 arch/mips/kernel/process.c                         |  25 ++-
 arch/mips/loongson64/env.c                         |  10 +-
 arch/mips/loongson64/init.c                        |  47 ++--
 arch/parisc/Kconfig                                |   7 +-
 arch/parisc/include/asm/bug.h                      |  36 +--
 arch/riscv/Kconfig.socs                            |   1 +
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
 drivers/acpi/scan.c                                |   7 +-
 drivers/android/binder.c                           |   1 +
 drivers/base/devcoredump.c                         |   3 +
 drivers/base/regmap/regcache.c                     |   3 +-
 drivers/gpio/gpiolib-sysfs.c                       |  15 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c             |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c        |  49 +++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c         |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c     | 121 ++++++-----
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c             |   2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c              |   4 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c              |   4 +-
 drivers/gpu/drm/bridge/Kconfig                     |   1 +
 drivers/gpu/drm/i915/display/icl_dsi.c             |   7 +
 drivers/gpu/drm/i915/display/intel_crt.c           |   5 +
 drivers/gpu/drm/i915/display/intel_display.c       |  10 +
 drivers/gpu/drm/i915/display/intel_display.h       |   3 +
 drivers/gpu/drm/i915/display/intel_dp.c            |   5 +-
 drivers/gpu/drm/i915/display/intel_dp_mst.c        |   4 +
 drivers/gpu/drm/i915/display/intel_dvo.c           |   6 +
 drivers/gpu/drm/i915/display/intel_hdmi.c          |   5 +-
 drivers/gpu/drm/i915/display/intel_lvds.c          |   9 +-
 drivers/gpu/drm/i915/display/intel_sdvo.c          |  22 +-
 drivers/gpu/drm/i915/display/intel_tv.c            |   8 +-
 drivers/gpu/drm/i915/display/vlv_dsi.c             |  18 +-
 drivers/gpu/drm/i915/i915_reg.h                    |  46 ++--
 drivers/hwmon/acpi_power_meter.c                   |   4 +
 drivers/hwmon/nzxt-kraken2.c                       |   4 +-
 drivers/hwtracing/coresight/coresight-etm4x-core.c |  12 +-
 drivers/hwtracing/ptt/hisi_ptt.c                   |   5 +
 drivers/i2c/busses/i2c-designware-common.c         |  16 +-
 drivers/infiniband/core/umem.c                     |   6 -
 drivers/infiniband/hw/bnxt_re/main.c               |   2 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c         |  13 +-
 drivers/infiniband/hw/irdma/hw.c                   |  49 +++--
 drivers/infiniband/hw/irdma/main.c                 |   2 +-
 drivers/infiniband/hw/irdma/main.h                 |   2 +-
 drivers/infiniband/hw/irdma/verbs.c                |  28 ++-
 drivers/infiniband/hw/irdma/verbs.h                |   1 +
 drivers/infiniband/ulp/rtrs/rtrs-clt.c             |   7 +-
 drivers/infiniband/ulp/rtrs/rtrs-srv.c             |  37 +++-
 drivers/iommu/iommu.c                              |  19 +-
 drivers/iommu/of_iommu.c                           |  12 +-
 drivers/md/md.c                                    | 174 ++++++++-------
 drivers/md/raid5.c                                 |   4 +-
 drivers/misc/mei/client.c                          |   4 +-
 drivers/net/arcnet/arcdevice.h                     |   2 +
 drivers/net/arcnet/com20020-pci.c                  |  89 ++++----
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
 drivers/platform/x86/asus-nb-wmi.c                 |  11 -
 drivers/platform/x86/asus-wmi.c                    |   8 +
 drivers/platform/x86/wmi.c                         |   5 +
 drivers/powercap/dtpm_cpu.c                        |  17 +-
 drivers/scsi/be2iscsi/be_main.c                    |   1 +
 drivers/tee/optee/device.c                         |  17 +-
 drivers/tty/serial/8250/8250_dw.c                  |   1 +
 drivers/tty/serial/8250/8250_early.c               |   1 +
 drivers/tty/serial/8250/8250_omap.c                |  14 +-
 drivers/tty/serial/amba-pl011.c                    | 112 +++++-----
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
 include/linux/cpuhotplug.h                         |   1 +
 include/linux/hrtimer.h                            |   4 +-
 include/linux/hugetlb.h                            |   5 +-
 include/linux/iommu.h                              |   1 +
 include/linux/kprobes.h                            |  13 +-
 include/linux/rethook.h                            |   7 +-
 include/linux/stmmac.h                             |   1 +
 include/net/genetlink.h                            |   2 +
 include/net/tcp.h                                  |   9 +-
 include/rdma/ib_umem.h                             |   9 +-
 include/rdma/ib_verbs.h                            |   1 +
 include/uapi/linux/netfilter/nf_tables.h           |   2 +
 io_uring/io_uring.c                                |   9 +-
 io_uring/rsrc.h                                    |   7 -
 kernel/cgroup/legacy_freezer.c                     |   8 +-
 kernel/cpu.c                                       |   8 +-
 kernel/events/core.c                               |  61 ++++--
 kernel/kprobes.c                                   |   4 +-
 kernel/time/hrtimer.c                              |  33 +--
 kernel/trace/rethook.c                             |  23 +-
 kernel/trace/ring_buffer.c                         |  23 +-
 kernel/trace/trace.c                               | 219 ++++++++-----------
 lib/zstd/common/fse_decompress.c                   |   2 +-
 mm/damon/sysfs.c                                   |   2 +-
 mm/filemap.c                                       |   2 +-
 mm/hugetlb.c                                       |   7 +
 net/core/drop_monitor.c                            |   4 +-
 net/core/filter.c                                  |  19 ++
 net/core/scm.c                                     |   6 +
 net/ipv4/ip_gre.c                                  |  11 +-
 net/ipv4/tcp.c                                     |  22 +-
 net/ipv4/tcp_input.c                               |   6 +-
 net/ipv6/ip6_fib.c                                 |   6 +-
 net/netfilter/ipset/ip_set_core.c                  |  14 +-
 net/netfilter/nf_tables_api.c                      |   5 +-
 net/netfilter/nft_dynset.c                         |  13 +-
 net/netfilter/nft_exthdr.c                         | 108 ++++++++-
 net/netfilter/nft_fib.c                            |   8 +-
 net/netfilter/nft_set_pipapo.c                     |   3 +
 net/netfilter/xt_owner.c                           |  16 +-
 net/netlink/genetlink.c                            |   3 +
 net/packet/af_packet.c                             |  16 +-
 net/packet/internal.h                              |   2 +-
 net/psample/psample.c                              |   3 +-
 net/xdp/xsk.c                                      |   5 +-
 scripts/checkstack.pl                              |   8 +-
 scripts/dtc/dt-extract-compatibles                 |  31 ++-
 scripts/kconfig/symbol.c                           |  14 +-
 sound/core/pcm.c                                   |   1 +
 sound/pci/hda/patch_realtek.c                      |   3 +
 sound/soc/amd/yc/acp6x-mach.c                      |   7 +
 sound/soc/codecs/lpass-tx-macro.c                  |   5 +
 sound/soc/codecs/wm_adsp.c                         |   8 +-
 sound/soc/fsl/fsl_sai.c                            |  21 ++
 sound/usb/mixer_quirks.c                           |  30 +++
 213 files changed, 2316 insertions(+), 1331 deletions(-)


