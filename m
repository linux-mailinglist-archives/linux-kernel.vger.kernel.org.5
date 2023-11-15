Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 367597ECB38
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 20:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233049AbjKOTU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 14:20:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232941AbjKOTUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 14:20:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BEF71A3;
        Wed, 15 Nov 2023 11:20:35 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59BDCC433CA;
        Wed, 15 Nov 2023 19:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076034;
        bh=7dQUfOo3m5k5vvQ11/FH7at8NO4m5139r8IA2bVP2Dc=;
        h=From:To:Cc:Subject:Date:From;
        b=sKHb+8POlZv6i9+dQs6IY7tcrMai35ieuOAIIhGddBKAVTmnOjsdA+NYBYi8xXDB6
         sRgOB1CDsdcv8Pb9HK/nu5W5ie993vrQC7buueQLxNydzrMmq5499k5Ct81G4wnfdN
         s9JlUHduXDxqxoV2JBZALzlHtACcCpi5t9flQvzY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: [PATCH 6.5 000/550] 6.5.12-rc1 review
Date:   Wed, 15 Nov 2023 14:09:44 -0500
Message-ID: <20231115191600.708733204@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.5.12-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.5.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.5.12-rc1
X-KernelTest-Deadline: 2023-11-17T19:16+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 6.5.12 release.
There are 550 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Fri, 17 Nov 2023 19:14:03 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.5.12-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.5.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 6.5.12-rc1

Qu Wenruo <wqu@suse.com>
    btrfs: make found_logical_ret parameter mandatory for function queue_scrub_stripe()

Filipe Manana <fdmanana@suse.com>
    btrfs: use u64 for buffer sizes in the tree search ioctls

Dominique Martinet <dominique.martinet@atmark-techno.com>
    Revert "mmc: core: Capture correct oemid-bits for eMMC cards"

Heiner Kallweit <hkallweit1@gmail.com>
    Revert "PCI/ASPM: Disable only ASPM_STATE_L1 when driver, disables L1"

Yazen Ghannam <yazen.ghannam@amd.com>
    x86/amd_nb: Use Family 19h Models 60h-7Fh Function 4 IDs

Jens Axboe <axboe@kernel.dk>
    io_uring/net: ensure socket is marked connected on connect retry

Geliang Tang <geliang.tang@suse.com>
    selftests: mptcp: fix wait_rm_addr/sf parameters

Sasha Levin <sashal@kernel.org>
    Revert "drm/ast: report connection status on Display Port."

Yujie Liu <yujie.liu@intel.com>
    tracing/kprobes: Fix the order of argument descriptions

Arnd Bergmann <arnd@arndb.de>
    fbdev: fsl-diu-fb: mark wr_reg_wa() static

Kailang Yang <kailang@realtek.com>
    ALSA: hda/realtek: Add support dual speaker for Dell

Dan Carpenter <dan.carpenter@linaro.org>
    fbdev: imsttfb: fix a resource leak in probe

Dan Carpenter <dan.carpenter@linaro.org>
    fbdev: imsttfb: fix double free in probe()

Ilkka Koskinen <ilkka@os.amperecomputing.com>
    arm64/arm: arm_pmuv3: perf: Don't truncate 64-bit registers

Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
    spi: spi-zynq-qspi: add spi-mem to driver kconfig dependencies

Jerome Brunet <jbrunet@baylibre.com>
    ASoC: dapm: fix clock get name

Jerome Brunet <jbrunet@baylibre.com>
    ASoC: hdmi-codec: register hpd callback on component probe

Eugen Hristev <eugen.hristev@collabora.com>
    ASoC: mediatek: mt8186_mt6366_rt1019_rt5682s: trivial: fix error messages

Erik Kurzinger <ekurzinger@nvidia.com>
    drm/syncobj: fix DRM_SYNCOBJ_WAIT_FLAGS_WAIT_AVAILABLE

Maxime Ripard <mripard@kernel.org>
    drm/vc4: tests: Fix UAF in the mock helpers

Andrea Righi <andrea.righi@canonical.com>
    module/decompress: use kvmalloc() consistently

Anup Patel <apatel@ventanamicro.com>
    RISC-V: Don't fail in riscv_of_parent_hartid() for disabled HARTs

Vlad Buslov <vladbu@nvidia.com>
    net/sched: act_ct: Always fill offloading tuple iifidx

Florian Westphal <fw@strlen.de>
    netfilter: nat: fix ipv6 nat redirect with mapped and scoped addresses

Maciej Żenczykowski <zenczykowski@gmail.com>
    netfilter: xt_recent: fix (increase) ipv6 literal buffer length

Roman Bacik <roman.bacik@broadcom.com>
    i2c: iproc: handle invalid slave state

Vladimir Oltean <vladimir.oltean@nxp.com>
    net: enetc: shorten enetc_setup_xdp_prog() error message to fit NETLINK_MAX_FMTMSG_LEN

Heiner Kallweit <hkallweit1@gmail.com>
    r8169: respect userspace disabling IFF_MULTICAST

Filippo Storniolo <f.storniolo95@gmail.com>
    vsock/virtio: remove socket from connected/bound list on shutdown

Yu Kuai <yukuai3@huawei.com>
    blk-core: use pr_warn_ratelimited() in bio_check_ro()

Li Lingfeng <lilingfeng3@huawei.com>
    nbd: fix uaf in nbd_open

George Shuklin <george.shuklin@gmail.com>
    tg3: power down device only on SYSTEM_POWER_OFF

Geert Uytterhoeven <geert+renesas@glider.be>
    riscv: boot: Fix creation of loader.bin

Anuj Gupta <anuj20.g@samsung.com>
    nvme: fix error-handling for io_uring nvme-passthrough

D. Wythe <alibuda@linux.alibaba.com>
    net/smc: put sk reference if close work was canceled

D. Wythe <alibuda@linux.alibaba.com>
    net/smc: allow cdc msg send rather than drop it with NULL sndbuf_desc

D. Wythe <alibuda@linux.alibaba.com>
    net/smc: fix dangling sock under state SMC_APPFINCLOSEWAIT

Geetha sowjanya <gakula@marvell.com>
    octeontx2-pf: Free pending and dropped SQEs

Hangbin Liu <liuhangbin@gmail.com>
    selftests: pmtu.sh: fix result checking

Furong Xu <0x1207@gmail.com>
    net: stmmac: xgmac: Enable support for multiple Flexible PPS outputs

NeilBrown <neilb@suse.de>
    Fix termination state for idr_for_each_entry_ul()

Patrick Thompson <ptf@google.com>
    net: r8169: Disable multicast filter for RTL8168H and RTL8107E

Kuniyuki Iwashima <kuniyu@amazon.com>
    dccp/tcp: Call security_inet_conn_request() after setting IPv6 addresses.

Kuniyuki Iwashima <kuniyu@amazon.com>
    dccp: Call security_inet_conn_request() after setting IPv4 addresses.

Jian Shen <shenjian15@huawei.com>
    net: page_pool: add missing free_percpu when page_pool_init fail

Ratheesh Kannoth <rkannoth@marvell.com>
    octeontx2-pf: Fix holes in error code

Ratheesh Kannoth <rkannoth@marvell.com>
    octeontx2-pf: Fix error codes

Eric Dumazet <edumazet@google.com>
    inet: shrink struct flowi_common

Hou Tao <houtao1@huawei.com>
    bpf: Check map->usercnt after timer->timer is assigned

David Howells <dhowells@redhat.com>
    rxrpc: Fix two connection reaping bugs

Shigeru Yoshida <syoshida@redhat.com>
    tipc: Change nla_policy for bearer-related names to NLA_NUL_STRING

Dan Carpenter <dan.carpenter@linaro.org>
    hsr: Prevent use after free in prp_create_tagged_frame()

Willem de Bruijn <willemb@google.com>
    llc: verify mac len before reading mac header

Linus Walleij <linus.walleij@linaro.org>
    watchdog: ixp4xx: Make sure restart always works

Dan Carpenter <dan.carpenter@linaro.org>
    Input: synaptics-rmi4 - fix use after free in rmi_unregister_function()

Florian Fainelli <florian.fainelli@broadcom.com>
    pwm: brcmstb: Utilize appropriate clock APIs in suspend/resume

Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    pwm: sti: Reduce number of allocations and drop usage of chip_data

Alex Deucher <alexander.deucher@amd.com>
    drm/amdgpu: don't put MQDs in VRAM on ARM | ARM64

Alex Deucher <alexander.deucher@amd.com>
    drm/amdgpu/gfx10,11: use memcpy_to/fromio for MQDs

Ben Wolsieffer <ben.wolsieffer@hefring.com>
    regmap: prevent noinc writes from clobbering cache

Vegard Nossum <vegard.nossum@oracle.com>
    cpupower: fix reference to nonexistent document

Marek Szyprowski <m.szyprowski@samsung.com>
    media: cec: meson: always include meson sub-directory in Makefile

Moudy Ho <moudy.ho@mediatek.com>
    media: platform: mtk-mdp3: fix uninitialized variable in mdp_path_config()

Ming Qian <ming.qian@nxp.com>
    media: imx-jpeg: notify source chagne event when the first picture parsed

Benjamin Gaignard <benjamin.gaignard@collabora.com>
    media: verisilicon: Fixes clock list for rk3588 av1 decoder

Hans Verkuil <hverkuil-cisco@xs4all.nl>
    media: dvb-usb-v2: af9035: fix missing unlock

Pratyush Yadav <p.yadav@ti.com>
    media: cadence: csi2rx: Unregister v4l2 async notifier

Jernej Skrabec <jernej.skrabec@gmail.com>
    media: cedrus: Fix clock/reset sequence

Jiasheng Jiang <jiasheng@iscas.ac.cn>
    media: vidtv: mux: Add check and kfree for kstrdup

Jiasheng Jiang <jiasheng@iscas.ac.cn>
    media: vidtv: psi: Add check for kstrdup

Katya Orlova <e.orlova@ispras.ru>
    media: s3c-camif: Avoid inappropriate kfree()

Fei Shao <fshao@chromium.org>
    media: mtk-jpegenc: Fix bug in JPEG encode quality selection

Ming Qian <ming.qian@nxp.com>
    media: amphion: handle firmware debug message

Zheng Wang <zyytlz.wz@163.com>
    media: bttv: fix use after free error due to btv->timeout timer

Xiaolei Wang <xiaolei.wang@windriver.com>
    media: ov5640: Fix a memory leak when ov5640_probe fails

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    media: i2c: max9286: Fix some redundant of_node_put() calls

Guoniu.zhou <guoniu.zhou@nxp.com>
    media: ov5640: fix vblank unchange issue when work at dvp mode

Marek Vasut <marex@denx.de>
    media: verisilicon: Do not enable G2 postproc downscale if source is narrower than destination

Marek Vasut <marex@denx.de>
    media: hantro: Check whether reset op is defined before use

Ming Qian <ming.qian@nxp.com>
    media: imx-jpeg: initiate a drain of the capture queue in dynamic resolution change

Yang Yingliang <yangyingliang@huawei.com>
    pcmcia: ds: fix possible name leak in error path in pcmcia_device_add()

Yang Yingliang <yangyingliang@huawei.com>
    pcmcia: ds: fix refcount leak in pcmcia_device_add()

Yang Yingliang <yangyingliang@huawei.com>
    pcmcia: cs: fix possible hung task and memory leak pccardd()

Dan Williams <dan.j.williams@intel.com>
    cxl/hdm: Remove broken error path

Dan Williams <dan.j.williams@intel.com>
    cxl/port: Fix @host confusion in cxl_dport_setup_regs()

Robert Richter <rrichter@amd.com>
    cxl/core/regs: Rename @dev to @host in struct cxl_register_map

Li Zhijian <lizhijian@fujitsu.com>
    cxl/region: Fix cxl_region_rwsem lock held when returning to user space

Alison Schofield <alison.schofield@intel.com>
    cxl/region: Use cxl_calc_interleave_pos() for auto-discovery

Alison Schofield <alison.schofield@intel.com>
    cxl/region: Calculate a target position in a region interleave

Alison Schofield <alison.schofield@intel.com>
    cxl/region: Prepare the decoder match range helper for reuse

Javier Carrasco <javier.carrasco.cruz@gmail.com>
    rtc: pcf85363: fix wrong mask/val parameters in regmap_update_bits call

Mike Looijmans <mike.looijmans@topic.nl>
    rtc: pcf85363: Allow to wake up system without IRQ

Dan Williams <dan.j.williams@intel.com>
    virt: sevguest: Fix passing a stack buffer as a scatterlist target

Dan Williams <dan.j.williams@intel.com>
    cxl/mem: Fix shutdown order

Dan Williams <dan.j.williams@intel.com>
    cxl/memdev: Fix sanitize vs decoder setup locking

Dan Williams <dan.j.williams@intel.com>
    cxl/pci: Fix sanitize notifier setup

Dan Williams <dan.j.williams@intel.com>
    cxl/pci: Clarify devm host for memdev relative setup

Dan Williams <dan.j.williams@intel.com>
    cxl/pci: Remove inconsistent usage of dev_err_probe()

Dan Williams <dan.j.williams@intel.com>
    cxl/pci: Cleanup 'sanitize' to always poll

Dan Williams <dan.j.williams@intel.com>
    cxl/pci: Remove unnecessary device reference management in sanitize work

Doug Berger <opendmb@gmail.com>
    rtc: brcmstb-waketimer: support level alarm_irq

Dinghao Liu <dinghao.liu@zju.edu.cn>
    i3c: Fix potential refcount leak in i3c_master_register_new_i3c_devs

Colin Ian King <colin.i.king@gmail.com>
    rtla: Fix uninitialized variable found

Hangyu Hua <hbh25y@gmail.com>
    9p/net: fix possible memory leak in p9_check_errors()

Ian Rogers <irogers@google.com>
    perf vendor events intel: Add broadwellde two metrics

Ian Rogers <irogers@google.com>
    perf vendor events intel: Fix broadwellde tma_info_system_dram_bw_use metric

Ian Rogers <irogers@google.com>
    perf hist: Add missing puts to hist__account_cycles

Ian Rogers <irogers@google.com>
    libperf rc_check: Make implicit enabling work for GCC

Ian Rogers <irogers@google.com>
    perf machine: Avoid out of bounds LBR memory read

Sergey Shtylyov <s.shtylyov@omp.ru>
    usb: host: xhci-plat: fix possible kernel oops while resuming

Basavaraj Natikar <Basavaraj.Natikar@amd.com>
    xhci: Loosen RPM as default policy to cover for AMD xHC 1.1

Kajol Jain <kjain@linux.ibm.com>
    perf vendor events: Update PMC used in PM_RUN_INST_CMPL event for power10 platform

Wang Yufen <wangyufen@huawei.com>
    powerpc/pseries: fix potential memory leak in init_cpu_associativity()

Sebastian Andrzej Siewior <bigeasy@linutronix.de>
    powerpc/imc-pmu: Use the correct spinlock initializer.

Haren Myneni <haren@linux.ibm.com>
    powerpc/vas: Limit open window failure messages in log bufffer

Thomas Richter <tmricht@linux.ibm.com>
    perf trace: Use the right bpf_probe_read(_str) variant for reading user data

Michael Ellerman <mpe@ellerman.id.au>
    powerpc: Hide empty pt_regs at base of the stack

Benjamin Gray <bgray@linux.ibm.com>
    powerpc/xive: Fix endian conversion size

Christophe Leroy <christophe.leroy@csgroup.eu>
    powerpc/40x: Remove stale PTE_ATOMIC_UPDATES macro

Namhyung Kim <namhyung@kernel.org>
    perf tools: Do not ignore the default vmlinux.h

Masahiro Yamada <masahiroy@kernel.org>
    modpost: fix ishtp MODULE_DEVICE_TABLE built on big-endian host

Masahiro Yamada <masahiroy@kernel.org>
    modpost: fix tee MODULE_DEVICE_TABLE built on big-endian host

Harald Freudenberger <freude@linux.ibm.com>
    s390/ap: re-init AP queues on config on

Ian Rogers <irogers@google.com>
    perf mem-events: Avoid uninitialized read

Ian Rogers <irogers@google.com>
    perf pmu: Remove logic for PMU name being NULL

Ian Rogers <irogers@google.com>
    perf parse-events: Fix for term values that are raw events

Arnaldo Carvalho de Melo <acme@redhat.com>
    perf build: Add missing comment about NO_LIBTRACEEVENT=1

Yang Yingliang <yangyingliang@huawei.com>
    interconnect: fix error handling in qnoc_probe()

Christophe Leroy <christophe.leroy@csgroup.eu>
    powerpc: Only define __parse_fpscr() when required

Konrad Dybcio <konrad.dybcio@linaro.org>
    interconnect: qcom: sm8350: Set ACV enable_mask

Konrad Dybcio <konrad.dybcio@linaro.org>
    interconnect: qcom: sm8350: Retire DEFINE_QBCM

Konrad Dybcio <konrad.dybcio@linaro.org>
    interconnect: qcom: sm8150: Set ACV enable_mask

Konrad Dybcio <konrad.dybcio@linaro.org>
    interconnect: qcom: sm8150: Retire DEFINE_QBCM

Konrad Dybcio <konrad.dybcio@linaro.org>
    interconnect: qcom: sm6350: Set ACV enable_mask

Konrad Dybcio <konrad.dybcio@linaro.org>
    interconnect: qcom: sm6350: Retire DEFINE_QBCM

Konrad Dybcio <konrad.dybcio@linaro.org>
    interconnect: qcom: sdm845: Set ACV enable_mask

Konrad Dybcio <konrad.dybcio@linaro.org>
    interconnect: qcom: sdm845: Retire DEFINE_QBCM

Konrad Dybcio <konrad.dybcio@linaro.org>
    interconnect: qcom: sdm670: Set ACV enable_mask

Konrad Dybcio <konrad.dybcio@linaro.org>
    interconnect: qcom: sdm670: Retire DEFINE_QBCM

Konrad Dybcio <konrad.dybcio@linaro.org>
    interconnect: qcom: sc8280xp: Set ACV enable_mask

Konrad Dybcio <konrad.dybcio@linaro.org>
    interconnect: qcom: sc8180x: Set ACV enable_mask

Konrad Dybcio <konrad.dybcio@linaro.org>
    interconnect: qcom: sc7280: Set ACV enable_mask

Konrad Dybcio <konrad.dybcio@linaro.org>
    interconnect: qcom: sc7180: Set ACV enable_mask

Konrad Dybcio <konrad.dybcio@linaro.org>
    interconnect: qcom: sc7180: Retire DEFINE_QBCM

Konrad Dybcio <konrad.dybcio@linaro.org>
    interconnect: qcom: qdu1000: Set ACV enable_mask

Chao Yu <chao@kernel.org>
    f2fs: fix to initialize map.m_pblk in f2fs_precache_extents()

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    dmaengine: pxa_dma: Remove an erroneous BUG_ON() in pxad_free_desc()

Jonas Blixt <jonas.blixt@actia.se>
    USB: usbip: fix stub_dev hub disconnect

Matti Vaittinen <mazziesaccount@gmail.com>
    tools: iio: iio_generic_buffer ensure alignment

Jinjie Ruan <ruanjinjie@huawei.com>
    misc: st_core: Do not call kfree_skb() under spin_lock_irqsave()

Kajol Jain <kjain@linux.ibm.com>
    tools/perf: Update call stack check in builtin-lock.c

Dan Carpenter <dan.carpenter@linaro.org>
    dmaengine: ti: edma: handle irq_of_parse_and_map() errors

Michał Mirosław <mirq-linux@rere.qmqm.pl>
    usb: chipidea: Simplify Tegra DMA alignment code

Michał Mirosław <mirq-linux@rere.qmqm.pl>
    usb: chipidea: Fix DMA overwrite for Tegra

Jia-Ju Bai <baijiaju@buaa.edu.cn>
    usb: dwc2: fix possible NULL pointer dereference caused by driver concurrency

Fenghua Yu <fenghua.yu@intel.com>
    dmaengine: idxd: Register dsa_bus_type before registering idxd sub-drivers

Namhyung Kim <namhyung@kernel.org>
    perf record: Fix BTF type checks in the off-cpu profiling

Biju Das <biju.das.jz@bp.renesas.com>
    pinctrl: renesas: rzg2l: Make reverse order of enable() for disable()

Zheng Yejian <zhengyejian1@huawei.com>
    livepatch: Fix missing newline character in klp_resolve_symbols()

Ian Rogers <irogers@google.com>
    perf parse-events: Fix tracepoint name memory leak

Ian Rogers <irogers@google.com>
    perf tools: Revert enable indices setting syntax for BPF map

Ian Rogers <irogers@google.com>
    perf parse-events: Remove ABORT_ON

Ian Rogers <irogers@google.com>
    perf parse-events: Remove unused PE_KERNEL_PMU_EVENT token

Ian Rogers <irogers@google.com>
    perf parse-events: Remove unused PE_PMU_EVENT_FAKE token

Yi Yang <yiyang13@huawei.com>
    tty: tty_jobctrl: fix pid memleak in disassociate_ctty()

Chao Yu <chao@kernel.org>
    f2fs: fix to drop meta_inode's page cache in f2fs_put_super()

Chao Yu <chao@kernel.org>
    f2fs: compress: fix to avoid redundant compress extension

Chao Yu <chao@kernel.org>
    f2fs: compress: fix to avoid use-after-free on dic

Chao Yu <chao@kernel.org>
    f2fs: compress: fix deadloop in f2fs_write_cache_pages()

Yang Jihong <yangjihong1@huawei.com>
    perf kwork: Set ordered_events to true in 'struct perf_tool'

Yang Jihong <yangjihong1@huawei.com>
    perf kwork: Add the supported subcommands to the document

Yang Jihong <yangjihong1@huawei.com>
    perf kwork: Fix incorrect and missing free atom in work_push_atom()

Jinjie Ruan <ruanjinjie@huawei.com>
    iio: frequency: adf4350: Use device managed functions and fix power down issue.

Ian Rogers <irogers@google.com>
    perf stat: Fix aggr mode initialization

Georgia Garcia <georgia.garcia@canonical.com>
    apparmor: fix invalid reference on profile->disconnected

Clément Léger <cleger@rivosinc.com>
    scripts/gdb: fix usage of MOD_TEXT not defined when CONFIG_MODULES=n

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    leds: trigger: ledtrig-cpu:: Fix 'output may be truncated' issue for 'cpu'

Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    leds: pwm: Don't disable the PWM when the LED should be off

Marek Behún <kabel@kernel.org>
    leds: turris-omnia: Do not use SMBUS calls

Marek Behún <kabel@kernel.org>
    leds: turris-omnia: Drop unnecessary mutex locking

Hans de Goede <hdegoede@redhat.com>
    mfd: arizona-spi: Set pdata.hpdet_channel for ACPI enumerated devs

Chen-Yu Tsai <wenst@chromium.org>
    dt-bindings: mfd: mt6397: Split out compatible for MediaTek MT6366 PMIC

Dinghao Liu <dinghao.liu@zju.edu.cn>
    mfd: dln2: Fix double put in dln2_probe

Herve Codina <herve.codina@bootlin.com>
    mfd: core: Ensure disabled devices are skipped without aborting

Michał Mirosław <mirq-linux@rere.qmqm.pl>
    mfd: core: Un-constify mfd_cell.of_reg

George Kennedy <george.kennedy@oracle.com>
    IB/mlx5: Fix init stage error handling to avoid double free of same QP and UAF

Gao Xiang <xiang@kernel.org>
    erofs: fix erofs_insert_workgroup() lockref usage

Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
    ASoC: ams-delta.c: use component after check

Giovanni Cabiddu <giovanni.cabiddu@intel.com>
    crypto: qat - fix deadlock in backlog processing

Herbert Xu <herbert@gondor.apana.org.au>
    certs: Break circular dependency when selftest is modular

WangJinchao <wangjinchao@xfusion.com>
    padata: Fix refcnt handling in padata_free_shell()

Dan Carpenter <dan.carpenter@linaro.org>
    PCI: endpoint: Fix double free in __pci_epc_create()

Cezary Rojewski <cezary.rojewski@intel.com>
    ASoC: Intel: Skylake: Fix mem leak when parsing UUIDs fails

Hans de Goede <hdegoede@redhat.com>
    HID: logitech-hidpp: Move get_wireless_feature_index() check to hidpp_connect_event()

Hans de Goede <hdegoede@redhat.com>
    HID: logitech-hidpp: Revert "Don't restart communication if not necessary"

Hans de Goede <hdegoede@redhat.com>
    HID: logitech-hidpp: Don't restart IO, instead defer hid_connect() only

Geert Uytterhoeven <geert+renesas@glider.be>
    sh: bios: Revive earlyprintk support

Jinjie Ruan <ruanjinjie@huawei.com>
    HID: uclogic: Fix a work->entry not empty bug in __queue_work()

Jinjie Ruan <ruanjinjie@huawei.com>
    HID: uclogic: Fix user-memory-access bug in uclogic_params_ugee_v2_init_event_hooks()

Danny Kaehn <danny.kaehn@plexus.com>
    hid: cp2112: Fix IRQ shutdown stopping polling for all IRQs on chip

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    HID: cp2112: Make irq_chip immutable

Leon Romanovsky <leon@kernel.org>
    RDMA/hfi1: Workaround truncation compilation error

Daniel Mentz <danielmentz@google.com>
    scsi: ufs: core: Leave space for '\0' in utf8 desc string

Zhang Shurong <zhang_shurong@foxmail.com>
    ASoC: fsl: Fix PM disable depth imbalance in fsl_easrc_probe

Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
    ASoC: SOF: core: Ensure sof_ops_free() is still called when probe never ran.

Luoyouming <luoyouming@huawei.com>
    RDMA/hns: The UD mode can only be configured with DCQCN

Luoyouming <luoyouming@huawei.com>
    RDMA/hns: Add check for SL

Chengchang Tang <tangchengchang@huawei.com>
    RDMA/hns: Fix signed-unsigned mixed comparisons

Chengchang Tang <tangchengchang@huawei.com>
    RDMA/hns: Fix uninitialized ucmd in hns_roce_create_qp_common()

Chengchang Tang <tangchengchang@huawei.com>
    RDMA/hns: Fix printing level of asynchronous events

Patrisious Haddad <phaddad@nvidia.com>
    IB/mlx5: Fix rdma counter binding for RAW QP

Alexander Aring <aahringo@redhat.com>
    dlm: fix no ack after final message

Hui Wang <hui.wang@canonical.com>
    ASoC: fsl-asoc-card: Add comment for mclk in the codec_priv

Bard Liao <yung-chuan.liao@linux.intel.com>
    ASoC: Intel: sof_sdw_rt_sdca_jack_common: add rt713 support

Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    backlight: pwm_bl: Disable PWM on shutdown, suspend and remove

Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
    ASoC: fsl: mpc5200_dma.c: Fix warning of Function parameter or member not described

Florent Revest <revest@chromium.org>
    kselftest: vm: fix mdwe's mmap_FIXED test case

Gou Hao <gouhao@uniontech.com>
    ext4: move 'ix' sanity check to corrent position

wahrenst <wahrenst@gmx.net>
    ARM: 9323/1: mm: Fix ARCH_LOW_ADDRESS_LIMIT when CONFIG_ZONE_DMA

Kursad Oney <kursad.oney@broadcom.com>
    ARM: 9321/1: memset: cast the constant byte to unsigned char

Longfang Liu <liulongfang@huawei.com>
    crypto: hisilicon/qm - fix PF queue parameter issue

Danny Kaehn <danny.kaehn@plexus.com>
    hid: cp2112: Fix duplicate workqueue initialization

Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
    PCI: vmd: Correct PCI Header Type Register's multi-function check

Gustavo A. R. Silva <gustavoars@kernel.org>
    ASoC: SOF: ipc4-topology: Use size_add() in call to struct_size()

Giovanni Cabiddu <giovanni.cabiddu@intel.com>
    crypto: qat - increase size of buffers

Gaurav Jain <gaurav.jain@nxp.com>
    crypto: caam/jr - fix Chacha20 + Poly1305 self test failure

Gaurav Jain <gaurav.jain@nxp.com>
    crypto: caam/qi2 - fix Chacha20 + Poly1305 self test failure

Tomas Glozar <tglozar@redhat.com>
    nd_btt: Make BTT lanes preemptible

Chen Ni <nichen@iscas.ac.cn>
    libnvdimm/of_pmem: Use devm_kstrdup instead of kstrdup and check its return value

Chancel Liu <chancel.liu@nxp.com>
    ASoC: soc-pcm.c: Make sure DAI parameters cleared if the DAI becomes inactive

Tyrel Datwyler <tyreld@linux.ibm.com>
    scsi: ibmvfc: Fix erroneous use of rtas_busy_delay with hcall return code

Giovanni Cabiddu <giovanni.cabiddu@intel.com>
    crypto: qat - fix unregistration of compression algorithms

Giovanni Cabiddu <giovanni.cabiddu@intel.com>
    crypto: qat - fix unregistration of crypto algorithms

Giovanni Cabiddu <giovanni.cabiddu@intel.com>
    crypto: qat - ignore subsequent state up commands

Giovanni Cabiddu <giovanni.cabiddu@intel.com>
    crypto: qat - fix state machines cleanup paths

Gustavo A. R. Silva <gustavoars@kernel.org>
    RDMA/core: Use size_{add,sub,mul}() in calls to struct_size()

Jonas Gorski <jonas.gorski@gmail.com>
    hwrng: geode - fix accessing registers

Stefan Wahren <wahrenst@gmx.net>
    hwrng: bcm2835 - Fix hwrng throughput regression

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    crypto: hisilicon/hpre - Fix a erroneous check after snprintf()

Herbert Xu <herbert@gondor.apana.org.au>
    KEYS: Include linux/errno.h in linux/verification.h

Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
    ALSA: hda: cs35l41: Undo runtime PM changes at driver exit time

Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
    ALSA: hda: cs35l41: Fix unbalanced pm_runtime_get()

Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
    ASoC: cs35l41: Undo runtime PM changes at driver exit time

Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
    ASoC: cs35l41: Verify PM runtime resume errors in IRQ handler

Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
    ASoC: cs35l41: Initialize completion object before requesting IRQ

Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
    ASoC: cs35l41: Handle mdsync_down reg write errors

Andrea Righi <andrea.righi@canonical.com>
    module/decompress: use vmalloc() for gzip decompression workspace

Jason Gunthorpe <jgg@ziepe.ca>
    iommufd: Add iopt_area_alloc()

Rafał Miłecki <rafal@milecki.pl>
    ARM: dts: BCM5301X: Explicitly disable unused switch CPU ports

Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
    soc: qcom: pmic_glink: fix connector type to be DisplayPort

Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
    selftests/resctrl: Ensure the benchmark commands fits to its array

Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
    selftests/pidfd: Fix ksft print formats

Thierry Reding <treding@nvidia.com>
    arm64: tegra: Use correct interrupts for Tegra234 TKE

Thierry Reding <treding@nvidia.com>
    memory: tegra: Set BPMP msg flags to reset IPC channels

Sumit Gupta <sumitg@nvidia.com>
    firmware: tegra: Add suspend hook and reset BPMP IPC early on resume

Brad Griffis <bgriffis@nvidia.com>
    arm64: tegra: Fix P3767 QSPI speed

Brad Griffis <bgriffis@nvidia.com>
    arm64: tegra: Fix P3767 card detect polarity

Adam Ford <aford173@gmail.com>
    arm64: dts: imx8mn: Add sound-dai-cells to micfil node

Adam Ford <aford173@gmail.com>
    arm64: dts: imx8mm: Add sound-dai-cells to micfil node

Fabio Estevam <festevam@denx.de>
    arm64: dts: imx8mp-debix-model-a: Remove USB hub reset-gpios

Fabio Estevam <festevam@denx.de>
    arm64: dts: imx8qm-ss-img: Fix jpegenc compatible entry

Sudeep Holla <sudeep.holla@arm.com>
    clk: scmi: Free scmi_clk allocated when the clocks with invalid info are skipped

Adam Ford <aford173@gmail.com>
    ARM: dts: am3517-evm: Fix LED3/4 pinmux

Sudeep Holla <sudeep.holla@arm.com>
    firmware: arm_ffa: Allow the FF-A drivers to use 32bit mode of messaging

Sudeep Holla <sudeep.holla@arm.com>
    firmware: arm_ffa: Assign the missing IDR allocation ID to the FFA device

Jai Luthra <j-luthra@ti.com>
    arm64: dts: ti: k3-am62a7-sk: Drop i2c-1 to 100Khz

Wadim Egorov <w.egorov@phytec.de>
    arm64: dts: ti: k3-am625-beagleplay: Fix typo in ramoops reg

Dhruva Gole <d-gole@ti.com>
    firmware: ti_sci: Mark driver as non removable

Jinjie Ruan <ruanjinjie@huawei.com>
    kunit: test: Fix the possible memory leak in executor_test

Jinjie Ruan <ruanjinjie@huawei.com>
    kunit: Fix missed memory release in kunit_free_suite_set()

Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    soc: qcom: llcc: Handle a second device without data corruption

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    ARM: dts: qcom: mdm9615: populate vsdcc fixed regulator

Matti Lehtimäki <matti.lehtimaki@gmail.com>
    ARM: dts: qcom: apq8026-samsung-matisse-wifi: Fix inverted hall sensor

Stephan Gerhold <stephan@gerhold.net>
    arm64: dts: qcom: apq8016-sbc: Add missing ADV7533 regulators

Conor Dooley <conor.dooley@microchip.com>
    riscv: dts: allwinner: remove address-cells from intc node

Gaurav Kohli <quic_gkohli@quicinc.com>
    arm64: dts: qcom: msm8939: Fix iommu local address range

Adam Skladowski <a39.skl@gmail.com>
    arm64: dts: qcom: msm8976: Fix ipc bit shifts

Chris Packham <chris.packham@alliedtelesis.co.nz>
    ARM64: dts: marvell: cn9310: Use appropriate label for spi1 pins

Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
    arm64: dts: qcom: sdm845-mtp: fix WiFi configuration

Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
    arm64: dts: qcom: sm8350: fix pinctrl for UART18

Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
    arm64: dts: qcom: sm8150: add ref clock to PCIe PHYs

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    arm64: dts: qcom: sc7280: drop incorrect EUD port on SoC side

Konrad Dybcio <konrad.dybcio@linaro.org>
    arm64: dts: qcom: qrb2210-rb1: Swap UART index

Konrad Dybcio <konrad.dybcio@linaro.org>
    arm64: dts: qcom: sc7280: Add missing LMH interrupts

Marijn Suijten <marijn.suijten@somainline.org>
    arm64: dts: qcom: sm6125: Pad APPS IOMMU address to 8 characters

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    arm64: dts: qcom: msm8992-libra: drop duplicated reserved memory

Gaurav Kohli <quic_gkohli@quicinc.com>
    arm64: dts: qcom: msm8916: Fix iommu local address range

Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
    arm64: dts: qcom: sc7280: link usb3_phy_wrapper_gcc_usb30_pipe_clk

David Heidelberg <david@ixit.cz>
    arm64: dts: qcom: sdm845: cheza doesn't support LMh node

David Heidelberg <david@ixit.cz>
    arm64: dts: qcom: sdm845: Fix PSCI power domain names

Geert Uytterhoeven <geert+renesas@glider.be>
    ARM: dts: renesas: blanche: Fix typo in GP_11_2 pin name

Junhao He <hejunhao3@huawei.com>
    perf: hisi: Fix use-after-free when register pmu fails

Yicong Yang <yangyicong@hisilicon.com>
    drivers/perf: hisi_pcie: Check the type first in pmu::event_init()

Robin Murphy <robin.murphy@arm.com>
    perf/arm-cmn: Fix DTC domain detection

Kunwu.Chan <chentao@kylinos.cn>
    drm/amd/pm: Fix a memory leak on an error path

Hao Chen <chenhao418@huawei.com>
    drivers/perf: hisi: use cpuhp_state_remove_instance_nocalls() for hisi_hns3_pmu uninit process

AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
    drm: mediatek: mtk_dsi: Fix NO_EOT_PACKET settings/handling

Andre Przywara <andre.przywara@arm.com>
    clocksource/drivers/arm_arch_timer: limit XGene-1 workaround

Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
    drm/msm/dsi: free TX buffer in unbind

Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
    drm/msm/dsi: use msm_gem_kernel_put to free TX buffer

Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>
    xen-pciback: Consider INTx disabled when MSI/MSI-X is enabled

Juergen Gross <jgross@suse.com>
    xenbus: fix error exit in xenbus_init()

Dan Carpenter <dan.carpenter@linaro.org>
    drm/rockchip: Fix type promotion bug in rockchip_gem_iommu_map()

Mark Rutland <mark.rutland@arm.com>
    arm64/arm: xen: enlighten: Fix KPTI checks

Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
    drm/bridge: lt9611uxc: fix the race in the error path

Johnny Liu <johnliu@nvidia.com>
    gpu: host1x: Correct allocated size for contexts

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    drm/rockchip: cdn-dp: Fix some error handling paths in cdn_dp_probe()

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    accel/habanalabs/gaudi2: Fix incorrect string length computation in gaudi2_psoc_razwi_get_engines()

Jason-JH.Lin <jason-jh.lin@mediatek.com>
    drm/mediatek: Fix iommu fault during crtc enabling

Jason-JH.Lin <jason-jh.lin@mediatek.com>
    drm/mediatek: Fix iommu fault by swapping FBs after updating plane state

Jason-JH.Lin <jason-jh.lin@mediatek.com>
    drm/mediatek: Add mmsys_dev_num to mt8188 vdosys0 driver data

Gabriel Krisman Bertazi <krisman@suse.de>
    io_uring/kbuf: Allow the full buffer id space for provided buffers

Gabriel Krisman Bertazi <krisman@suse.de>
    io_uring/kbuf: Fix check of BID wrapping in provided buffers

Michel Dänzer <mdaenzer@redhat.com>
    drm/amd/display: Bail from dm_check_crtc_cursor if no relevant change

Michel Dänzer <mdaenzer@redhat.com>
    drm/amd/display: Refactor dm_get_plane_scale helper

Michel Dänzer <mdaenzer@redhat.com>
    drm/amd/display: Check all enabled planes in dm_check_crtc_cursor

Cong Liu <liucong2@kylinos.cn>
    drm/amd/display: Fix null pointer dereference in error message

Philip Yang <Philip.Yang@amd.com>
    drm/amdkfd: Handle errors from svm validate and map

Philip Yang <Philip.Yang@amd.com>
    drm/amdkfd: Remove svm range validated_once flag

Alex Sierra <alex.sierra@amd.com>
    drm/amdkfd: retry after EBUSY is returned from hmm_ranges_get_pages

Xiaogang Chen <xiaogang.chen@amd.com>
    drm/amdkfd: fix some race conditions in vram buffer alloc/free of svm code

Philip Yang <Philip.Yang@amd.com>
    drm/amdgpu: Increase IH soft ring size for GFX v9.4.3 dGPU

Douglas Anderson <dianders@chromium.org>
    drm: Call drm_atomic_helper_shutdown() at shutdown/remove time for misc drivers

Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    drm/tve200: Convert to platform remove callback returning void

Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    drm/stm: Convert to platform remove callback returning void

Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    drm/aspeed: Convert to platform remove callback returning void

Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
    drm/bridge: tc358768: Fix tc358768_ns_to_cnt()

Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
    drm/bridge: tc358768: Clean up clock period code

Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
    drm/bridge: tc358768: Rename dsibclk to hsbyteclk

Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
    drm/bridge: tc358768: Use dev for dbg prints, not priv->dev

Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
    drm/bridge: tc358768: Print logical values, not raw register values

Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
    drm/bridge: tc358768: Use struct videomode

Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
    drm/bridge: tc358768: Fix bit updates

Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
    drm/bridge: tc358768: Fix use of uninitialized variable

Kai Huang <kai.huang@intel.com>
    x86/tdx: Zero out the missing RSI in TDX_HYPERCALL macro

Jason-JH.Lin <jason-jh.lin@mediatek.com>
    drm/mediatek: Fix coverity issue with unintentional integer overflow

Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
    drm/bridge: lt8912b: Add missing drm_bridge_attach call

Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
    drm/bridge: lt8912b: Manually disable HPD only if it was enabled

Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
    drm/bridge: lt8912b: Fix crash on bridge detach

Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
    drm/bridge: lt8912b: Fix bridge_detach

Jai Luthra <j-luthra@ti.com>
    drm: bridge: it66121: Fix invalid connector dereference

Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
    drm/radeon: possible buffer overflow

Jonas Karlman <jonas@kwiboo.se>
    drm/rockchip: vop2: Add missing call to crtc reset helper

Jonas Karlman <jonas@kwiboo.se>
    drm/rockchip: vop2: Don't crash for invalid duplicate_state

Jonas Karlman <jonas@kwiboo.se>
    drm/rockchip: vop: Fix call to crtc reset helper

Jonas Karlman <jonas@kwiboo.se>
    drm/rockchip: vop: Fix reset of state in duplicate state crtc funcs

Marek Szyprowski <m.szyprowski@samsung.com>
    drm: bridge: samsung-dsim: Fix waiting for empty cmd transfer FIFO on older Exynos

Randy Dunlap <rdunlap@infradead.org>
    drm: bridge: for GENERIC_PHY_MIPI_DPHY also select GENERIC_PHY

Marek Vasut <marex@denx.de>
    drm: bridge: samsung-dsim: Initialize ULPS EXIT for i.MX8M DSIM

Vaishnav Achath <vaishnav.a@ti.com>
    spi: omap2-mcspi: Fix hardcoded reference clock

Yang Yingliang <yangyingliang@huawei.com>
    spi: omap2-mcspi: switch to use modern name

Zhu Wang <wangzhu9@huawei.com>
    spi: omap2-mcspi: remove redundant dev_err_probe()

Lalith Rajendran <lalithkraj@chromium.org>
    platform/chrome: cros_ec_lpc: Separate host command and irq disable

Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
    hte: tegra: Fix missing error code in tegra_hte_test_probe()

Armin Wolf <W_Armin@gmx.de>
    hwmon: (sch5627) Disallow write access if virtual registers are locked

Armin Wolf <W_Armin@gmx.de>
    hwmon: (sch5627) Use bit macros when accessing the control register

Guenter Roeck <linux@roeck-us.net>
    Revert "hwmon: (sch56xx-common) Add automatic module loading on supported devices"

Guenter Roeck <linux@roeck-us.net>
    Revert "hwmon: (sch56xx-common) Add DMI override table"

Zhang Rui <rui.zhang@intel.com>
    hwmon: (coretemp) Fix potentially truncated sysfs attribute name

Dragos Bogdan <dragos.bogdan@analog.com>
    hwmon: (axi-fan-control) Fix possible NULL pointer dereference

Abel Vesa <abel.vesa@linaro.org>
    regulator: qcom-rpmh: Fix smps4 regulator for pm8550ve

Armin Wolf <W_Armin@gmx.de>
    platform/x86: wmi: Fix opening of char device

Armin Wolf <W_Armin@gmx.de>
    platform/x86: wmi: Fix probe failure when failing to register WMI devices

Dan Carpenter <dan.carpenter@linaro.org>
    clk: mediatek: fix double free in mtk_clk_register_pllfh()

Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
    clk: qcom: ipq5332: drop the CLK_SET_RATE_PARENT flag from GPLL clocks

Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
    clk: qcom: ipq9574: drop the CLK_SET_RATE_PARENT flag from GPLL clocks

Varadarajan Narayanan <quic_varada@quicinc.com>
    clk: qcom: apss-ipq-pll: Fix 'l' value for ipq5332_pll_config

Varadarajan Narayanan <quic_varada@quicinc.com>
    clk: qcom: apss-ipq-pll: Use stromer plus ops for stromer plus pll

Varadarajan Narayanan <quic_varada@quicinc.com>
    clk: qcom: clk-alpha-pll: introduce stromer plus ops

Varadarajan Narayanan <quic_varada@quicinc.com>
    clk: qcom: config IPQ_APSS_6018 should depend on QCOM_SMEM

Jiasheng Jiang <jiasheng@iscas.ac.cn>
    clk: mediatek: clk-mt2701: Add check for mtk_alloc_clk_data

Jiasheng Jiang <jiasheng@iscas.ac.cn>
    clk: mediatek: clk-mt7629: Add check for mtk_alloc_clk_data

Jiasheng Jiang <jiasheng@iscas.ac.cn>
    clk: mediatek: clk-mt7629-eth: Add check for mtk_alloc_clk_data

Jiasheng Jiang <jiasheng@iscas.ac.cn>
    clk: mediatek: clk-mt6797: Add check for mtk_alloc_clk_data

Jiasheng Jiang <jiasheng@iscas.ac.cn>
    clk: mediatek: clk-mt6779: Add check for mtk_alloc_clk_data

Jiasheng Jiang <jiasheng@iscas.ac.cn>
    clk: mediatek: clk-mt6765: Add check for mtk_alloc_clk_data

Jonathan Neuschäfer <j.neuschaefer@gmx.net>
    clk: npcm7xx: Fix incorrect kfree

Dan Carpenter <dan.carpenter@linaro.org>
    clk: ti: fix double free in of_ti_divider_clk_setup()

Dan Carpenter <dan.carpenter@linaro.org>
    clk: keystone: pll: fix a couple NULL vs IS_ERR() checks

Sergio Paracuellos <sergio.paracuellos@gmail.com>
    clk: ralink: mtmips: quiet unused variable warning

Han Xu <han.xu@nxp.com>
    spi: nxp-fspi: use the correct ioremap function

Randy Dunlap <rdunlap@infradead.org>
    clk: linux/clk-provider.h: fix kernel-doc warnings and typos

Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
    clk: renesas: rzg2l: Fix computation formula

Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
    clk: renesas: rzg2l: Use FIELD_GET() for PLL register fields

Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
    clk: renesas: rzg2l: Trust value returned by hardware

Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
    clk: renesas: rzg2l: Lock around writes to mux register

Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
    clk: renesas: rzg2l: Wait for status bit of SD mux before continuing

Dirk Behme <dirk.behme@de.bosch.com>
    clk: renesas: rcar-gen3: Extend SDnH divider table

Robert Chiras <robert.chiras@nxp.com>
    clk: imx: imx8qxp: Fix elcdif_pll clock

Peng Fan <peng.fan@nxp.com>
    clk: imx: imx8mq: correct error handling path

Abel Vesa <abel.vesa@linaro.org>
    clk: imx: Select MXC_CLK for CLK_IMX8QXP

Chen-Yu Tsai <wenst@chromium.org>
    regulator: mt6358: Fail probe on unknown chip ID

Danila Tikhonov <danila@jiaxyga.com>
    clk: qcom: gcc-sm8150: Fix gcc_sdcc2_apps_clk_src

Konrad Dybcio <konrad.dybcio@linaro.org>
    clk: qcom: mmcc-msm8998: Fix the SMMU GDSC

Konrad Dybcio <konrad.dybcio@linaro.org>
    clk: qcom: mmcc-msm8998: Don't check halt bit on some branch clks

Devi Priya <quic_devipriy@quicinc.com>
    clk: qcom: clk-rcg2: Fix clock rate overflow for high parent frequencies

Konrad Dybcio <konrad.dybcio@linaro.org>
    clk: qcom: gcc-msm8996: Remove RPM bus clocks

Varadarajan Narayanan <quic_varada@quicinc.com>
    clk: qcom: ipq5332: Drop set rate parent from gpll0 dependent clocks

Zhang Shurong <zhang_shurong@foxmail.com>
    spi: tegra: Fix missing IRQ check in tegra_slink_probe()

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    regmap: debugfs: Fix a erroneous check after snprintf()

Eric Dumazet <edumazet@google.com>
    ipvlan: properly track tx_errors

Eric Dumazet <edumazet@google.com>
    net: add DEV_STATS_READ() helper

Eric Dumazet <edumazet@google.com>
    virtio_net: use u64_stats_t infra to avoid data-races

Yan Zhai <yan@cloudflare.com>
    ipv6: avoid atomic fragment on GSO packets

Paolo Abeni <pabeni@redhat.com>
    mptcp: properly account fastopen data

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    ACPI: sysfs: Fix create_pnp_modalias() and create_of_modalias()

Song Liu <song@kernel.org>
    bpf: Fix unnecessary -EBUSY from htab_lock_bucket

Marcel Ziswiler <marcel.ziswiler@toradex.com>
    Bluetooth: hci_sync: Fix Opcode prints in bt_dev_dbg/err

Ziyang Xuan <william.xuanziyang@huawei.com>
    Bluetooth: Make handle of hci_conn be unique

Iulia Tanasescu <iulia.tanasescu@nxp.com>
    Bluetooth: ISO: Pass BIG encryption info through QoS

Iulia Tanasescu <iulia.tanasescu@nxp.com>
    Bluetooth: ISO: Use defer setup to separate PA sync and BIG sync

Miri Korenblit <miriam.rachel.korenblit@intel.com>
    wifi: iwlwifi: empty overflow queue during flush

Yedidya Benshimol <yedidya.ben.shimol@intel.com>
    wifi: iwlwifi: mvm: update IGTK in mvmvif upon D3 resume

Johannes Berg <johannes.berg@intel.com>
    wifi: iwlwifi: pcie: synchronize IRQs before NAPI

Johannes Berg <johannes.berg@intel.com>
    wifi: iwlwifi: mvm: fix netif csum flags

Johannes Berg <johannes.berg@intel.com>
    wifi: iwlwifi: increase number of RX buffers for EHT devices

Johannes Berg <johannes.berg@intel.com>
    wifi: iwlwifi: mvm: remove TDLS stations from FW

Johannes Berg <johannes.berg@intel.com>
    wifi: iwlwifi: mvm: fix iwl_mvm_mac_flush_sta()

Johannes Berg <johannes.berg@intel.com>
    wifi: iwlwifi: mvm: change iwl_mvm_flush_sta() API

Ilan Peer <ilan.peer@intel.com>
    wifi: iwlwifi: mvm: Don't always bind/link the P2P Device interface

Ilan Peer <ilan.peer@intel.com>
    wifi: iwlwifi: mvm: Fix key flags for IGTK on AP interface

Ilan Peer <ilan.peer@intel.com>
    wifi: iwlwifi: mvm: Correctly set link configuration

Rotem Saado <rotem.saado@intel.com>
    wifi: iwlwifi: yoyo: swap cdb and jacket bits values

Ilan Peer <ilan.peer@intel.com>
    wifi: mac80211: Fix setting vif links

Johannes Berg <johannes.berg@intel.com>
    wifi: mac80211: don't recreate driver link debugfs in reconfig

Johannes Berg <johannes.berg@intel.com>
    wifi: iwlwifi: mvm: use correct sta ID for IGTK/BIGTK

Avraham Stern <avraham.stern@intel.com>
    wifi: iwlwifi: mvm: fix removing pasn station for responder

Avraham Stern <avraham.stern@intel.com>
    wifi: iwlwifi: mvm: update station's MFP flag after association

Eric Dumazet <edumazet@google.com>
    tcp: fix cookie_init_timestamp() overflows

Eric Dumazet <edumazet@google.com>
    chtls: fix tp->rcv_tstamp initialization

Nícolas F. R. A. Prado <nfraprado@collabora.com>
    thermal: core: Don't update trip points inside the hysteresis range

Phil Sutter <phil@nwl.cc>
    net: skb_find_text: Ignore patterns extending past 'to'

Xin Long <lucien.xin@gmail.com>
    selftests: netfilter: test for sctp collision processing in nf_conntrack

Yafang Shao <laoar.shao@gmail.com>
    bpf: Fix missed rcu read lock in bpf_task_under_cgroup()

Markus Schneider-Pargmann <msp@baylibre.com>
    thermal/drivers/mediatek: Fix probe for THERMAL_V2

Heiner Kallweit <hkallweit1@gmail.com>
    r8169: fix rare issue with broken rx after link-down on RTL8125

Dan Carpenter <dan.carpenter@linaro.org>
    thermal: core: prevent potential string overflow

Jinjie Ruan <ruanjinjie@huawei.com>
    wifi: rtw88: Remove duplicate NULL check before calling usb_kill/free_urb()

Phil Sutter <phil@nwl.cc>
    netfilter: nf_tables: Drop pointless memset when dumping rules

Felipe Negrelli Wolter <felipe.negrelliwolter@silabs.com>
    wifi: wfx: fix case where rates are out of order

Sascha Hauer <s.hauer@pengutronix.de>
    PM / devfreq: rockchip-dfi: Make pmu regmap mandatory

Marc Kleine-Budde <mkl@pengutronix.de>
    can: dev: can_put_echo_skb(): don't crash kernel if can_priv::echo_skb is accessed out of bounds

Marc Kleine-Budde <mkl@pengutronix.de>
    can: dev: can_restart(): fix race condition between controller restart and netif_carrier_on()

Marc Kleine-Budde <mkl@pengutronix.de>
    can: dev: can_restart(): don't crash kernel if carrier is OK

Aditya Kumar Singh <quic_adisi@quicinc.com>
    wifi: ath11k: fix Tx power value during active CAC

Vincent Mailhol <mailhol.vincent@wanadoo.fr>
    can: etas_es58x: add missing a blank line after declaration

Vincent Mailhol <mailhol.vincent@wanadoo.fr>
    can: etas_es58x: rework the version check logic to silence -Wformat-truncation

Ondrej Zary <linux@zary.sk>
    ACPI: video: Add acpi_backlight=vendor quirk for Toshiba Portégé R100

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    ACPI: property: Allow _DSD buffer data only for byte accessors

Dmitry Antipov <dmantipov@yandex.ru>
    wifi: rtlwifi: fix EDCA limit set by BT coexistence

Eric Dumazet <edumazet@google.com>
    tcp_metrics: do not create an entry from tcp_init_metrics()

Eric Dumazet <edumazet@google.com>
    tcp_metrics: properly set tp->snd_ssthresh in tcp_init_metrics()

Eric Dumazet <edumazet@google.com>
    tcp_metrics: add missing barriers on delete

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    wifi: ath: dfs_pattern_detector: Fix a memory initialization issue

MeiChia Chiu <meichia.chiu@mediatek.com>
    wifi: mt76: mt7915: fix beamforming availability check

Shayne Chen <shayne.chen@mediatek.com>
    wifi: mt76: fix per-band IEEE80211_CONF_MONITOR flag comparison

StanleyYP Wang <StanleyYP.Wang@mediatek.com>
    wifi: mt76: get rid of false alamrs of tx emission issues

Bo Jiao <Bo.Jiao@mediatek.com>
    wifi: mt76: fix potential memory leak of beacon commands

MeiChia Chiu <meichia.chiu@mediatek.com>
    wifi: mt76: update beacon size limitation

Peter Chiu <chui-hao.chiu@mediatek.com>
    wifi: mt76: mt7996: fix TWT command format

Peter Chiu <chui-hao.chiu@mediatek.com>
    wifi: mt76: mt7996: fix rx rate report for CBW320-2

Peter Chiu <chui-hao.chiu@mediatek.com>
    wifi: mt76: mt7996: fix wmm queue mapping

Howard Hsu <howard-yh.hsu@mediatek.com>
    wifi: mt76: mt7996: fix beamformee ss subfield in EHT PHY cap

Howard Hsu <howard-yh.hsu@mediatek.com>
    wifi: mt76: mt7996: fix beamform mcu cmd configuration

Peter Chiu <chui-hao.chiu@mediatek.com>
    wifi: mt76: mt7996: set correct wcid in txp

Felix Fietkau <nbd@nbd.name>
    wifi: mt76: remove unused error path in mt76_connac_tx_complete_skb

Lorenzo Bianconi <lorenzo@kernel.org>
    wifi: mt76: connac: move connac3 definitions in mt76_connac3_mac.h

Felix Fietkau <nbd@nbd.name>
    wifi: mt76: mt7603: improve stuck beacon handling

Felix Fietkau <nbd@nbd.name>
    wifi: mt76: mt7603: improve watchdog reset reliablity

Felix Fietkau <nbd@nbd.name>
    wifi: mt76: mt7603: rework/fix rx pse hang check

Sumit Gupta <sumitg@nvidia.com>
    cpufreq: tegra194: fix warning due to missing opp_put

Raag Jadav <raag.jadav@intel.com>
    PM: sleep: Fix symbol export for _SIMPLE_ variants of _PM_OPS()

Johannes Berg <johannes.berg@intel.com>
    wifi: mac80211: fix check for unusable RX result

Baochen Qiang <quic_bqiang@quicinc.com>
    wifi: ath11k: fix boot failure with one MSI vector

Baochen Qiang <quic_bqiang@quicinc.com>
    wifi: ath12k: fix DMA unmap warning on NULL DMA address

Jinjie Ruan <ruanjinjie@huawei.com>
    wifi: rtw88: debug: Fix the NULL vs IS_ERR() bug for debugfs_create_file()

Lorenzo Bianconi <lorenzo@kernel.org>
    net: ethernet: mtk_wed: fix EXT_INT_STATUS_RX_FBUF definitions for MT7986 SoC

Gustavo A. R. Silva <gustavoars@kernel.org>
    net: spider_net: Use size_add() in call to struct_size()

Gustavo A. R. Silva <gustavoars@kernel.org>
    tipc: Use size_add() in calls to struct_size()

Gustavo A. R. Silva <gustavoars@kernel.org>
    tls: Use size_add() in call to struct_size()

Gustavo A. R. Silva <gustavoars@kernel.org>
    mlxsw: Use size_mul() in call to struct_size()

Gustavo A. R. Silva <gustavoars@kernel.org>
    gve: Use size_add() in call to struct_size()

Kumar Kartikeya Dwivedi <memxor@gmail.com>
    bpf: Fix kfunc callback register type handling

Aananth V <aananthv@google.com>
    tcp: call tcp_try_undo_recovery when an RTOd TFO SYNACK is ACKed

Artem Savkov <asavkov@redhat.com>
    selftests/bpf: Skip module_fentry_shadow test when bpf_testmod is not available

Eric Dumazet <edumazet@google.com>
    udplite: fix various data-races

Eric Dumazet <edumazet@google.com>
    udplite: remove UDPLITE_BIT

Eric Dumazet <edumazet@google.com>
    udp: annotate data-races around udp->encap_type

Eric Dumazet <edumazet@google.com>
    udp: lockless UDP_ENCAP_L2TPINUDP / UDP_GRO

Eric Dumazet <edumazet@google.com>
    udp: move udp->accept_udp_{l4|fraglist} to udp->udp_flags

Eric Dumazet <edumazet@google.com>
    udp: add missing WRITE_ONCE() around up->encap_rcv

Eric Dumazet <edumazet@google.com>
    udp: move udp->gro_enabled to udp->udp_flags

Eric Dumazet <edumazet@google.com>
    udp: move udp->no_check6_rx to udp->udp_flags

Eric Dumazet <edumazet@google.com>
    udp: move udp->no_check6_tx to udp->udp_flags

Eric Dumazet <edumazet@google.com>
    udp: introduce udp->udp_flags

Miri Korenblit <miriam.rachel.korenblit@intel.com>
    wifi: iwlwifi: Use FW rate for non-data frames

Johannes Berg <johannes.berg@intel.com>
    wifi: cfg80211: fix kernel-doc for wiphy_delayed_work_flush()

Leon Hwang <hffilwlqm@gmail.com>
    bpf, x64: Fix tailcall infinite loop

Menglong Dong <imagedong@tencent.com>
    bpf, x86: allow function arguments up to 12 for TRACING

Menglong Dong <imagedong@tencent.com>
    bpf, x86: save/restore regs with BPF_DW size

Leon Hwang <hffilwlqm@gmail.com>
    selftests/bpf: Correct map_fd to data_fd in tailcalls

Brett Creeley <brett.creeley@intel.com>
    iavf: Fix promiscuous mode configuration flow messages

Andrii Staikov <andrii.staikov@intel.com>
    i40e: fix potential memory leaks in i40e_remove()

Miri Korenblit <miriam.rachel.korenblit@intel.com>
    wifi: iwlwifi: don't use an uninitialized variable

Emmanuel Grumbach <emmanuel.grumbach@intel.com>
    wifi: iwlwifi: honor the enable_ini value

Johannes Berg <johannes.berg@intel.com>
    wifi: mac80211: fix # of MSDU in A-MSDU calculation

Johannes Berg <johannes.berg@intel.com>
    wifi: cfg80211: fix off-by-one in element defrag

Johannes Berg <johannes.berg@intel.com>
    wifi: mac80211: fix RCU usage warning in mesh fast-xmit

Johannes Berg <johannes.berg@intel.com>
    wifi: mac80211: move sched-scan stop work to wiphy work

Johannes Berg <johannes.berg@intel.com>
    wifi: mac80211: move offchannel works to wiphy work

Johannes Berg <johannes.berg@intel.com>
    wifi: mac80211: move scan work to wiphy work

Johannes Berg <johannes.berg@intel.com>
    wifi: mac80211: move radar detect work to wiphy work

Johannes Berg <johannes.berg@intel.com>
    wifi: cfg80211: add flush functions for wiphy work

Harshitha Prem <quic_hprem@quicinc.com>
    wifi: ath12k: fix undefined behavior with __fls in dp

Anup Patel <apatel@ventanamicro.com>
    irqchip/sifive-plic: Fix syscore registration for multi-socket systems

Chen Yu <yu.c.chen@intel.com>
    genirq/matrix: Exclude managed interrupts in irq_matrix_allocated()

Kees Cook <keescook@chromium.org>
    string: Adjust strtomem() logic to allow for smaller sources

Reinette Chatre <reinette.chatre@intel.com>
    PCI/MSI: Provide stubs for IMS functions

Binbin Wu <binbin.wu@linux.intel.com>
    selftests/x86/lam: Zero out buffer for readlink()

Peter Zijlstra <peterz@infradead.org>
    perf: Optimize perf_cgroup_switch()

Jiasheng Jiang <jiasheng@iscas.ac.cn>
    pstore/platform: Add check for kstrdup

Paul E. McKenney <paulmck@kernel.org>
    x86/nmi: Fix out-of-order NMI nesting checks & false positive warning

Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
    drivers/clocksource/timer-ti-dm: Don't call clk_get_rate() in stop function

Frederic Weisbecker <frederic@kernel.org>
    srcu: Fix callbacks acceleration mishandling

Thomas Gleixner <tglx@linutronix.de>
    x86/apic: Fake primary thread mask for XEN/PV

Thomas Gleixner <tglx@linutronix.de>
    cpu/SMT: Make SMT control more robust against enumeration failures

Michael Ellerman <mpe@ellerman.id.au>
    cpu/SMT: Create topology_smt_thread_allowed()

Laurent Dufour <ldufour@linux.ibm.com>
    cpu/hotplug: Remove dependancy against cpu_primary_thread_mask

Yuntao Wang <ytcoode@gmail.com>
    x86/boot: Fix incorrect startup_gdt_descr.size

Adam Dunlap <acdunlap@google.com>
    x86/sev-es: Allow copy_from_kernel_nofault() in earlier boot

Alison Schofield <alison.schofield@intel.com>
    ACPI/NUMA: Apply SRAT proximity domain to entire CFMWS window

Alison Schofield <alison.schofield@intel.com>
    x86/numa: Introduce numa_fill_memblks()

Ben Wolsieffer <ben.wolsieffer@hefring.com>
    futex: Don't include process MM in futex key on no-MMU

Josh Poimboeuf <jpoimboe@kernel.org>
    x86/srso: Fix unret validation dependencies

Josh Poimboeuf <jpoimboe@kernel.org>
    x86/srso: Fix vulnerability reporting for missing microcode

Josh Poimboeuf <jpoimboe@kernel.org>
    x86/srso: Print mitigation for retbleed IBPB case

Josh Poimboeuf <jpoimboe@kernel.org>
    x86/srso: Fix SBPB enablement for (possible) future fixed HW

Jingbo Xu <jefflexu@linux.alibaba.com>
    writeback, cgroup: switch inodes with dirty timestamps to release dying cgwbs

Reuben Hawkins <reubenhwk@gmail.com>
    vfs: fix readahead(2) on block devices

Trond Myklebust <trond.myklebust@hammerspace.com>
    nfsd: Handle EOPENSTALE correctly in the filecache

Peter Zijlstra <peterz@infradead.org>
    sched: Fix stop_one_cpu_nowait() vs hotplug

Aaron Plattner <aplattner@nvidia.com>
    objtool: Propagate early errors

Qais Yousef <qyousef@layalina.io>
    sched/uclamp: Ignore (util == 0) optimization in feec() when p_util_max = 0

Qais Yousef <qyousef@layalina.io>
    sched/uclamp: Set max_spare_cap_cpu even if max_spare_cap is 0

David Howells <dhowells@redhat.com>
    iov_iter, x86: Be consistent about the __user tag on copy_mc_to_user()

Chengming Zhou <zhouchengming@bytedance.com>
    sched/fair: Fix cfs_rq_is_decayed() on !SMP

Yury Norov <yury.norov@gmail.com>
    sched/topology: Fix sched_numa_find_nth_cpu() in non-NUMA case

Yury Norov <yury.norov@gmail.com>
    sched/topology: Fix sched_numa_find_nth_cpu() in CPU-less case

Yury Norov <yury.norov@gmail.com>
    numa: Generalize numa_map_to_online_node()

Zev Weiss <zev@bewilderbeest.net>
    hwmon: (nct6775) Fix incorrect variable reuse in fan_div calculation


-------------

Diffstat:

 Documentation/admin-guide/hw-vuln/srso.rst         |  24 +-
 Documentation/devicetree/bindings/mfd/mt6397.txt   |   4 +-
 Makefile                                           |   4 +-
 arch/Kconfig                                       |   3 +
 .../bcm4708-buffalo-wzr-1166dhp-common.dtsi        |   8 +
 .../boot/dts/broadcom/bcm4708-luxul-xap-1510.dts   |   8 +
 .../boot/dts/broadcom/bcm4708-luxul-xwc-1000.dts   |   8 +
 .../boot/dts/broadcom/bcm4708-netgear-r6250.dts    |   8 +
 .../boot/dts/broadcom/bcm4708-smartrg-sr400ac.dts  |   8 +
 .../dts/broadcom/bcm47081-buffalo-wzr-600dhp2.dts  |   8 +
 .../boot/dts/broadcom/bcm47081-luxul-xap-1410.dts  |   8 +
 .../boot/dts/broadcom/bcm47081-luxul-xwr-1200.dts  |   8 +
 .../boot/dts/broadcom/bcm4709-netgear-r8000.dts    |   8 +
 .../boot/dts/broadcom/bcm47094-dlink-dir-885l.dts  |   8 +
 .../boot/dts/broadcom/bcm47094-dlink-dir-890l.dts  |   8 +
 .../boot/dts/broadcom/bcm47094-luxul-abr-4500.dts  |   8 +
 .../boot/dts/broadcom/bcm47094-luxul-xap-1610.dts  |   8 +
 .../boot/dts/broadcom/bcm47094-luxul-xbr-4500.dts  |   8 +
 .../boot/dts/broadcom/bcm47094-luxul-xwc-2000.dts  |   8 +
 .../boot/dts/broadcom/bcm47094-luxul-xwr-3100.dts  |   8 +
 .../dts/broadcom/bcm47094-luxul-xwr-3150-v1.dts    |   8 +
 .../arm/boot/dts/broadcom/bcm53015-meraki-mr26.dts |   8 +
 .../arm/boot/dts/broadcom/bcm53016-meraki-mr32.dts |   8 +
 arch/arm/boot/dts/broadcom/bcm953012er.dts         |   8 +
 .../dts/qcom/qcom-apq8026-samsung-matisse-wifi.dts |   4 +-
 arch/arm/boot/dts/qcom/qcom-mdm9615.dtsi           |  14 +-
 arch/arm/boot/dts/renesas/r8a7792-blanche.dts      |   2 +-
 arch/arm/boot/dts/ti/omap/am3517-evm.dts           |  16 +-
 arch/arm/include/asm/arm_pmuv3.h                   |  48 ++-
 arch/arm/include/asm/dma.h                         |   3 +
 arch/arm/lib/memset.S                              |   1 +
 arch/arm/xen/enlighten.c                           |  25 +-
 arch/arm64/boot/dts/freescale/imx8mm.dtsi          |   1 +
 arch/arm64/boot/dts/freescale/imx8mn.dtsi          |   1 +
 .../boot/dts/freescale/imx8mp-debix-model-a.dts    |   3 -
 arch/arm64/boot/dts/freescale/imx8qm-ss-img.dtsi   |   2 +-
 arch/arm64/boot/dts/marvell/cn9130-crb.dtsi        |   4 +-
 arch/arm64/boot/dts/marvell/cn9130-db.dtsi         |   4 +-
 arch/arm64/boot/dts/nvidia/tegra234-p3767.dtsi     |   4 +-
 arch/arm64/boot/dts/nvidia/tegra234.dtsi           |  12 +-
 arch/arm64/boot/dts/qcom/apq8016-sbc.dts           |   3 +
 arch/arm64/boot/dts/qcom/msm8916.dtsi              |   2 +-
 arch/arm64/boot/dts/qcom/msm8939.dtsi              |   2 +-
 arch/arm64/boot/dts/qcom/msm8976.dtsi              |   8 +-
 arch/arm64/boot/dts/qcom/msm8992-xiaomi-libra.dts  |   5 -
 arch/arm64/boot/dts/qcom/qrb2210-rb1.dts           |   4 +-
 arch/arm64/boot/dts/qcom/sc7280.dtsi               |  32 +-
 arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi         |  32 +-
 arch/arm64/boot/dts/qcom/sdm845-mtp.dts            |   2 +
 arch/arm64/boot/dts/qcom/sm6125.dtsi               |   2 +-
 arch/arm64/boot/dts/qcom/sm8150.dtsi               |  12 +-
 arch/arm64/boot/dts/qcom/sm8350.dtsi               |   2 +-
 arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts     |   2 +-
 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts            |   2 +-
 arch/arm64/include/asm/arm_pmuv3.h                 |  25 +-
 arch/arm64/include/asm/cputype.h                   |   3 +-
 arch/arm64/kvm/guest.c                             |   2 +-
 arch/powerpc/include/asm/nohash/32/pte-40x.h       |   3 -
 arch/powerpc/kernel/process.c                      |  26 +-
 arch/powerpc/kernel/traps.c                        |   2 +
 arch/powerpc/perf/imc-pmu.c                        |   2 +-
 arch/powerpc/platforms/book3s/vas-api.c            |  34 +--
 arch/powerpc/platforms/pseries/lpar.c              |   4 +-
 arch/powerpc/platforms/pseries/vas.c               |   4 +-
 arch/powerpc/sysdev/xive/native.c                  |   2 +-
 arch/riscv/boot/Makefile                           |   1 +
 arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi      |   1 -
 arch/riscv/kernel/cpu.c                            |  11 +-
 arch/sh/Kconfig.debug                              |  11 +
 arch/x86/coco/tdx/tdcall.S                         |   1 +
 arch/x86/include/asm/nospec-branch.h               |   4 +-
 arch/x86/include/asm/sparsemem.h                   |   2 +
 arch/x86/include/asm/uaccess.h                     |   2 +-
 arch/x86/kernel/amd_nb.c                           |   3 +
 arch/x86/kernel/apic/apic.c                        |  11 +
 arch/x86/kernel/cpu/bugs.c                         |  42 +--
 arch/x86/kernel/head64.c                           |   2 +-
 arch/x86/kernel/nmi.c                              |  13 +-
 arch/x86/lib/copy_mc.c                             |   8 +-
 arch/x86/mm/maccess.c                              |  19 +-
 arch/x86/mm/numa.c                                 |  80 +++++
 arch/x86/net/bpf_jit_comp.c                        | 274 ++++++++++++++---
 block/blk-core.c                                   |   4 +-
 crypto/asymmetric_keys/Kconfig                     |   3 +-
 crypto/asymmetric_keys/Makefile                    |   3 +-
 crypto/asymmetric_keys/selftest.c                  |  13 +-
 crypto/asymmetric_keys/x509_parser.h               |   9 -
 crypto/asymmetric_keys/x509_public_key.c           |   8 +-
 drivers/accel/habanalabs/gaudi2/gaudi2.c           |   4 +-
 drivers/acpi/device_sysfs.c                        |  10 +-
 drivers/acpi/numa/srat.c                           |  11 +-
 drivers/acpi/property.c                            |  19 +-
 drivers/acpi/video_detect.c                        |  26 ++
 drivers/base/regmap/regmap-debugfs.c               |   2 +-
 drivers/base/regmap/regmap.c                       |  16 +-
 drivers/block/nbd.c                                |  11 +-
 drivers/char/hw_random/bcm2835-rng.c               |   2 +-
 drivers/char/hw_random/core.c                      |   6 +
 drivers/char/hw_random/geode-rng.c                 |   6 +-
 drivers/clk/clk-npcm7xx.c                          |   2 +-
 drivers/clk/clk-scmi.c                             |   1 +
 drivers/clk/imx/Kconfig                            |   1 +
 drivers/clk/imx/clk-imx8mq.c                       |  17 +-
 drivers/clk/imx/clk-imx8qxp.c                      |   2 +-
 drivers/clk/keystone/pll.c                         |  15 +-
 drivers/clk/mediatek/clk-mt2701.c                  |   8 +
 drivers/clk/mediatek/clk-mt6765.c                  |   6 +
 drivers/clk/mediatek/clk-mt6779.c                  |   4 +
 drivers/clk/mediatek/clk-mt6797.c                  |   6 +
 drivers/clk/mediatek/clk-mt7629-eth.c              |   4 +
 drivers/clk/mediatek/clk-mt7629.c                  |   6 +
 drivers/clk/mediatek/clk-pll.c                     |   6 +-
 drivers/clk/qcom/Kconfig                           |   1 +
 drivers/clk/qcom/apss-ipq-pll.c                    |   4 +-
 drivers/clk/qcom/clk-alpha-pll.c                   |  63 ++++
 drivers/clk/qcom/clk-alpha-pll.h                   |   1 +
 drivers/clk/qcom/clk-rcg2.c                        |  14 +-
 drivers/clk/qcom/gcc-ipq5332.c                     |   4 -
 drivers/clk/qcom/gcc-ipq9574.c                     |   4 -
 drivers/clk/qcom/gcc-msm8996.c                     | 237 +--------------
 drivers/clk/qcom/gcc-sm8150.c                      |   2 +-
 drivers/clk/qcom/mmcc-msm8998.c                    |   7 +-
 drivers/clk/ralink/clk-mtmips.c                    |  20 +-
 drivers/clk/renesas/rcar-cpg-lib.c                 |  15 +-
 drivers/clk/renesas/rzg2l-cpg.c                    |  62 ++--
 drivers/clk/renesas/rzg2l-cpg.h                    |   2 +-
 drivers/clk/ti/divider.c                           |   8 +-
 drivers/clocksource/arm_arch_timer.c               |   5 +-
 drivers/clocksource/timer-ti-dm.c                  |  36 ++-
 drivers/cpufreq/tegra194-cpufreq.c                 |   2 +
 drivers/crypto/caam/caamalg.c                      |   3 +-
 drivers/crypto/caam/caamalg_qi2.c                  |   3 +-
 drivers/crypto/hisilicon/hpre/hpre_main.c          |   7 +-
 drivers/crypto/hisilicon/qm.c                      |  18 +-
 drivers/crypto/hisilicon/qm_common.h               |   1 -
 drivers/crypto/hisilicon/sec2/sec_main.c           |   5 +
 drivers/crypto/hisilicon/zip/zip_main.c            |   5 +
 .../intel/qat/qat_common/adf_accel_devices.h       |   2 +-
 .../crypto/intel/qat/qat_common/adf_common_drv.h   |   2 +
 drivers/crypto/intel/qat/qat_common/adf_init.c     |  17 +-
 drivers/crypto/intel/qat/qat_common/adf_sysfs.c    |  11 +-
 .../intel/qat/qat_common/adf_transport_debug.c     |   4 +-
 .../crypto/intel/qat/qat_common/qat_algs_send.c    |  46 +--
 drivers/cxl/core/core.h                            |   1 +
 drivers/cxl/core/hdm.c                             |  40 +--
 drivers/cxl/core/mbox.c                            |  55 +++-
 drivers/cxl/core/memdev.c                          | 157 +++++-----
 drivers/cxl/core/port.c                            |  53 +++-
 drivers/cxl/core/region.c                          | 241 ++++++++-------
 drivers/cxl/core/regs.c                            |  28 +-
 drivers/cxl/cxl.h                                  |   4 +-
 drivers/cxl/cxlmem.h                               |  13 +-
 drivers/cxl/pci.c                                  |  80 +++--
 drivers/devfreq/event/rockchip-dfi.c               |  15 +-
 drivers/dma/idxd/Makefile                          |   6 +-
 drivers/dma/pxa_dma.c                              |   1 -
 drivers/dma/ti/edma.c                              |   4 +-
 drivers/firmware/arm_ffa/bus.c                     |   1 +
 drivers/firmware/arm_ffa/driver.c                  |  12 +-
 drivers/firmware/tegra/bpmp.c                      |  30 ++
 drivers/firmware/ti_sci.c                          |  46 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c            |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h             |   2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c             |  12 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c             |  12 +-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c               |  90 +++---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h               |   2 -
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  73 ++++-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c   |   4 +-
 drivers/gpu/drm/aspeed/aspeed_gfx_drv.c            |  11 +-
 drivers/gpu/drm/ast/ast_dp.c                       |  11 -
 drivers/gpu/drm/ast/ast_dp501.c                    |  37 +--
 drivers/gpu/drm/ast/ast_drv.h                      |   2 -
 drivers/gpu/drm/ast/ast_mode.c                     |  30 +-
 drivers/gpu/drm/bridge/Kconfig                     |   2 +
 drivers/gpu/drm/bridge/cadence/Kconfig             |   1 +
 drivers/gpu/drm/bridge/ite-it66121.c               |  12 +-
 drivers/gpu/drm/bridge/lontium-lt8912b.c           |  22 +-
 drivers/gpu/drm/bridge/lontium-lt9611uxc.c         |  10 +-
 drivers/gpu/drm/bridge/samsung-dsim.c              |  20 +-
 drivers/gpu/drm/bridge/tc358768.c                  | 166 ++++++-----
 drivers/gpu/drm/drm_syncobj.c                      |   3 +-
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c            |   3 +
 drivers/gpu/drm/mediatek/mtk_drm_drv.c             |   1 +
 drivers/gpu/drm/mediatek/mtk_drm_gem.c             |   9 +-
 drivers/gpu/drm/mediatek/mtk_drm_plane.c           |  41 ++-
 drivers/gpu/drm/mediatek/mtk_dsi.c                 |   4 +-
 drivers/gpu/drm/mgag200/mgag200_drv.c              |   8 +
 drivers/gpu/drm/msm/dsi/dsi.c                      |   1 +
 drivers/gpu/drm/msm/dsi/dsi.h                      |   1 +
 drivers/gpu/drm/msm/dsi/dsi_host.c                 |  16 +-
 drivers/gpu/drm/pl111/pl111_drv.c                  |   7 +
 drivers/gpu/drm/radeon/evergreen.c                 |   7 +-
 drivers/gpu/drm/rockchip/cdn-dp-core.c             |  15 +-
 drivers/gpu/drm/rockchip/rockchip_drm_gem.c        |   2 +-
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c        |   8 +-
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c       |  39 ++-
 drivers/gpu/drm/stm/drv.c                          |  11 +-
 drivers/gpu/drm/stm/dw_mipi_dsi-stm.c              |   6 +-
 drivers/gpu/drm/tilcdc/tilcdc_drv.c                |  11 +-
 drivers/gpu/drm/tve200/tve200_drv.c                |  11 +-
 drivers/gpu/drm/vboxvideo/vbox_drv.c               |  10 +
 drivers/gpu/drm/vc4/tests/vc4_mock_crtc.c          |   2 +-
 drivers/gpu/drm/vc4/tests/vc4_mock_output.c        |   2 +-
 drivers/gpu/host1x/context.c                       |   4 +-
 drivers/hid/hid-cp2112.c                           |  43 ++-
 drivers/hid/hid-logitech-hidpp.c                   |  60 ++--
 drivers/hid/hid-uclogic-core-test.c                |   7 +
 drivers/hid/hid-uclogic-params-test.c              |  16 +-
 drivers/hte/hte-tegra194-test.c                    |   4 +-
 drivers/hwmon/axi-fan-control.c                    |  29 +-
 drivers/hwmon/coretemp.c                           |   2 +-
 drivers/hwmon/nct6775-core.c                       |  12 +-
 drivers/hwmon/sch5627.c                            |  21 +-
 drivers/hwmon/sch56xx-common.c                     |  64 +---
 drivers/i2c/busses/i2c-bcm-iproc.c                 | 133 +++++----
 drivers/i3c/master.c                               |   4 +-
 drivers/iio/frequency/adf4350.c                    |  75 ++---
 drivers/infiniband/core/device.c                   |   2 +-
 drivers/infiniband/core/sa_query.c                 |   4 +-
 drivers/infiniband/core/sysfs.c                    |  10 +-
 drivers/infiniband/core/user_mad.c                 |   4 +-
 drivers/infiniband/hw/hfi1/efivar.c                |   2 +-
 drivers/infiniband/hw/hns/hns_roce_ah.c            |  13 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c         |  34 ++-
 drivers/infiniband/hw/hns/hns_roce_qp.c            |   2 +-
 drivers/infiniband/hw/mlx5/main.c                  |   4 +-
 drivers/infiniband/hw/mlx5/qp.c                    |  27 ++
 drivers/input/rmi4/rmi_bus.c                       |   2 +-
 drivers/interconnect/qcom/icc-rpm.c                |  14 +-
 drivers/interconnect/qcom/qdu1000.c                |   1 +
 drivers/interconnect/qcom/sc7180.c                 | 256 ++++++++++++++--
 drivers/interconnect/qcom/sc7280.c                 |   1 +
 drivers/interconnect/qcom/sc8180x.c                |   1 +
 drivers/interconnect/qcom/sc8280xp.c               |   1 +
 drivers/interconnect/qcom/sdm670.c                 | 240 +++++++++++++--
 drivers/interconnect/qcom/sdm845.c                 | 278 ++++++++++++++++--
 drivers/interconnect/qcom/sm6350.c                 | 252 ++++++++++++++--
 drivers/interconnect/qcom/sm8150.c                 | 284 ++++++++++++++++--
 drivers/interconnect/qcom/sm8350.c                 | 309 +++++++++++++++++--
 drivers/iommu/iommufd/io_pagetable.c               |  18 +-
 drivers/iommu/iommufd/pages.c                      |   2 +
 drivers/irqchip/irq-sifive-plic.c                  |   7 +-
 drivers/leds/leds-pwm.c                            |   2 +-
 drivers/leds/leds-turris-omnia.c                   |  65 ++--
 drivers/leds/trigger/ledtrig-cpu.c                 |   4 +-
 drivers/media/cec/platform/Makefile                |   2 +-
 drivers/media/i2c/max9286.c                        |   2 -
 drivers/media/i2c/ov5640.c                         |  24 +-
 drivers/media/pci/bt8xx/bttv-driver.c              |   1 +
 drivers/media/platform/amphion/vpu_defs.h          |   1 +
 drivers/media/platform/amphion/vpu_helpers.c       |   1 +
 drivers/media/platform/amphion/vpu_malone.c        |   1 +
 drivers/media/platform/amphion/vpu_msgs.c          |  31 +-
 drivers/media/platform/cadence/cdns-csi2rx.c       |   7 +-
 .../media/platform/mediatek/jpeg/mtk_jpeg_enc_hw.c |   5 +-
 .../media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c   |   2 +-
 drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c     |  34 ++-
 drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h     |   1 +
 .../platform/samsung/s3c-camif/camif-capture.c     |   6 +-
 drivers/media/platform/verisilicon/hantro_drv.c    |   3 +-
 .../media/platform/verisilicon/hantro_postproc.c   |   2 +-
 .../media/platform/verisilicon/rockchip_vpu_hw.c   |   2 +-
 drivers/media/test-drivers/vidtv/vidtv_mux.c       |   7 +-
 drivers/media/test-drivers/vidtv/vidtv_psi.c       |  45 ++-
 drivers/media/usb/dvb-usb-v2/af9035.c              |  13 +-
 drivers/memory/tegra/tegra234.c                    |   4 +
 drivers/mfd/arizona-spi.c                          |   3 +
 drivers/mfd/dln2.c                                 |   1 -
 drivers/mfd/mfd-core.c                             |  17 +-
 drivers/misc/ti-st/st_core.c                       |   7 +-
 drivers/mmc/core/mmc.c                             |   2 +-
 drivers/net/can/dev/dev.c                          |  10 +-
 drivers/net/can/dev/skb.c                          |   6 +-
 drivers/net/can/usb/etas_es58x/es58x_core.c        |   1 +
 drivers/net/can/usb/etas_es58x/es58x_core.h        |   6 +-
 drivers/net/can/usb/etas_es58x/es58x_devlink.c     |  57 ++--
 drivers/net/ethernet/broadcom/tg3.c                |   3 +-
 .../chelsio/inline_crypto/chtls/chtls_cm.c         |   2 +-
 drivers/net/ethernet/freescale/enetc/enetc.c       |   2 +-
 drivers/net/ethernet/google/gve/gve_main.c         |   2 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c        |  10 +-
 drivers/net/ethernet/intel/iavf/iavf.h             |  16 +-
 drivers/net/ethernet/intel/iavf/iavf_main.c        |  43 ++-
 drivers/net/ethernet/intel/iavf/iavf_virtchnl.c    |  75 +++--
 .../ethernet/marvell/octeontx2/nic/otx2_common.c   |  15 +-
 .../ethernet/marvell/octeontx2/nic/otx2_common.h   |   1 +
 .../net/ethernet/marvell/octeontx2/nic/otx2_pf.c   |  81 ++---
 .../ethernet/marvell/octeontx2/nic/otx2_struct.h   |  34 +--
 .../net/ethernet/marvell/octeontx2/nic/otx2_txrx.c |  42 +++
 drivers/net/ethernet/mediatek/mtk_wed_regs.h       |   4 +-
 .../mellanox/mlxsw/spectrum_acl_bloom_filter.c     |   2 +-
 drivers/net/ethernet/realtek/r8169_main.c          |  10 +-
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h     |   2 +-
 .../net/ethernet/stmicro/stmmac/dwxgmac2_core.c    |  14 +-
 drivers/net/ethernet/toshiba/spider_net.c          |   2 +-
 drivers/net/gtp.c                                  |   4 +-
 drivers/net/ipvlan/ipvlan_core.c                   |   8 +-
 drivers/net/ipvlan/ipvlan_main.c                   |   1 +
 drivers/net/macsec.c                               |   6 +-
 drivers/net/virtio_net.c                           | 124 ++++----
 drivers/net/wireless/ath/ath11k/mac.c              |   8 +
 drivers/net/wireless/ath/ath11k/pci.c              |  24 +-
 drivers/net/wireless/ath/ath12k/dp_rx.c            |   2 +-
 drivers/net/wireless/ath/ath12k/dp_tx.c            |   7 +-
 drivers/net/wireless/ath/dfs_pattern_detector.c    |   2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c        |  14 +-
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c        |  10 +-
 drivers/net/wireless/intel/iwlwifi/dvm/tx.c        |   5 +-
 .../net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h    |   1 +
 drivers/net/wireless/intel/iwlwifi/iwl-config.h    |   5 +-
 drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.h   |   5 +-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c       |  51 ++--
 drivers/net/wireless/intel/iwlwifi/iwl-prph.h      |   4 +-
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h     |  11 +-
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c        |  10 +
 .../net/wireless/intel/iwlwifi/mvm/ftm-responder.c |   9 +-
 drivers/net/wireless/intel/iwlwifi/mvm/link.c      |  22 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c  |   8 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c  | 182 +++++-------
 drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c   |  16 +-
 .../net/wireless/intel/iwlwifi/mvm/mld-mac80211.c  | 105 +++----
 drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c   |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h       |   9 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c       |  12 +-
 .../net/wireless/intel/iwlwifi/mvm/time-event.c    |  31 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c        |  36 +--
 .../net/wireless/intel/iwlwifi/pcie/trans-gen2.c   |   1 +
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c    |   1 +
 drivers/net/wireless/intel/iwlwifi/queue/tx.c      |   9 +-
 drivers/net/wireless/intel/iwlwifi/queue/tx.h      |   2 +-
 drivers/net/wireless/mediatek/mt76/dma.c           |   3 -
 drivers/net/wireless/mediatek/mt76/mt7603/beacon.c |  76 +++--
 drivers/net/wireless/mediatek/mt76/mt7603/core.c   |   2 +
 drivers/net/wireless/mediatek/mt76/mt7603/mac.c    |  52 ++--
 drivers/net/wireless/mediatek/mt76/mt7603/regs.h   |   5 +
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c    |   2 +-
 .../net/wireless/mediatek/mt76/mt7615/pci_mac.c    |   2 +-
 .../net/wireless/mediatek/mt76/mt76_connac3_mac.h  | 327 +++++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt76_connac_mac.c   |  17 --
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c    |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7915/main.c   |   8 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c    |  69 +++--
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.h    |  18 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h |   2 +
 .../net/wireless/mediatek/mt76/mt7921/pci_mac.c    |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7996/init.c   |   9 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c    |  12 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mac.h    | 315 +-------------------
 drivers/net/wireless/mediatek/mt76/mt7996/main.c   |  16 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c    |  67 +++--
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.h    |  11 +-
 .../net/wireless/realtek/rtlwifi/rtl8188ee/dm.c    |   2 +-
 .../wireless/realtek/rtlwifi/rtl8192c/dm_common.c  |   2 +-
 .../net/wireless/realtek/rtlwifi/rtl8723ae/dm.c    |   2 +-
 drivers/net/wireless/realtek/rtw88/debug.c         |   4 +-
 drivers/net/wireless/realtek/rtw88/usb.c           |   9 +-
 drivers/net/wireless/silabs/wfx/data_tx.c          |  71 ++---
 drivers/nvdimm/of_pmem.c                           |   8 +-
 drivers/nvdimm/region_devs.c                       |   8 +-
 drivers/nvme/host/ioctl.c                          |   7 +-
 drivers/pci/controller/vmd.c                       |   3 +-
 drivers/pci/endpoint/pci-epc-core.c                |   1 -
 drivers/pci/pcie/aspm.c                            |   3 +-
 drivers/pcmcia/cs.c                                |   1 +
 drivers/pcmcia/ds.c                                |  14 +-
 drivers/perf/arm-cmn.c                             |  16 +-
 drivers/perf/arm_pmuv3.c                           |   6 +-
 drivers/perf/hisilicon/hisi_pcie_pmu.c             |   7 +-
 drivers/perf/hisilicon/hisi_uncore_pa_pmu.c        |   4 +-
 drivers/perf/hisilicon/hisi_uncore_sllc_pmu.c      |   4 +-
 drivers/perf/hisilicon/hns3_pmu.c                  |   8 +-
 drivers/pinctrl/renesas/pinctrl-rzg2l.c            |   3 +-
 drivers/platform/chrome/cros_ec.c                  | 116 ++++++--
 drivers/platform/chrome/cros_ec.h                  |   4 +
 drivers/platform/chrome/cros_ec_lpc.c              |  22 +-
 drivers/platform/x86/wmi.c                         |  36 +--
 drivers/pwm/pwm-brcmstb.c                          |   4 +-
 drivers/pwm/pwm-sti.c                              |  29 +-
 drivers/regulator/mt6358-regulator.c               |  14 +-
 drivers/regulator/qcom-rpmh-regulator.c            |   2 +-
 drivers/rtc/rtc-brcmstb-waketimer.c                |  47 ++-
 drivers/rtc/rtc-pcf85363.c                         |  30 +-
 drivers/s390/crypto/ap_bus.c                       |  21 +-
 drivers/s390/crypto/ap_bus.h                       |   1 +
 drivers/s390/crypto/ap_queue.c                     |   9 +-
 drivers/scsi/ibmvscsi/ibmvfc.c                     |   3 +-
 drivers/soc/qcom/llcc-qcom.c                       |   3 +
 drivers/soc/qcom/pmic_glink_altmode.c              |   2 +-
 drivers/spi/Kconfig                                |   1 +
 drivers/spi/spi-nxp-fspi.c                         |   2 +-
 drivers/spi/spi-omap2-mcspi.c                      | 267 +++++++++--------
 drivers/spi/spi-tegra20-slink.c                    |   2 +
 drivers/staging/media/sunxi/cedrus/cedrus_hw.c     |  24 +-
 drivers/thermal/mediatek/auxadc_thermal.c          |   2 +-
 drivers/thermal/thermal_core.c                     |   6 +-
 drivers/thermal/thermal_trip.c                     |  19 +-
 drivers/tty/tty_jobctrl.c                          |  17 +-
 drivers/ufs/core/ufshcd.c                          |   2 +-
 drivers/usb/chipidea/host.c                        |  48 ++-
 drivers/usb/dwc2/hcd.c                             |   2 +-
 drivers/usb/host/xhci-pci.c                        |   2 +
 drivers/usb/host/xhci-plat.c                       |  23 +-
 drivers/usb/usbip/stub_dev.c                       |   9 +-
 drivers/video/backlight/pwm_bl.c                   |  22 ++
 drivers/video/fbdev/fsl-diu-fb.c                   |   2 +-
 drivers/video/fbdev/imsttfb.c                      |  35 ++-
 drivers/virt/coco/sev-guest/sev-guest.c            |  45 +--
 drivers/watchdog/ixp4xx_wdt.c                      |  28 +-
 drivers/xen/xen-pciback/conf_space.c               |  19 +-
 drivers/xen/xen-pciback/conf_space_capability.c    |   8 +-
 drivers/xen/xen-pciback/conf_space_header.c        |  21 +-
 drivers/xen/xenbus/xenbus_probe.c                  |   2 +-
 fs/btrfs/ioctl.c                                   |  10 +-
 fs/btrfs/scrub.c                                   |  10 +-
 fs/dlm/midcomms.c                                  |   6 +-
 fs/erofs/utils.c                                   |   8 +-
 fs/erofs/zdata.c                                   |   1 +
 fs/ext4/extents.c                                  |  10 +-
 fs/f2fs/data.c                                     |  24 +-
 fs/f2fs/file.c                                     |   1 +
 fs/f2fs/super.c                                    |  35 ++-
 fs/fs-writeback.c                                  |  41 ++-
 fs/nfsd/filecache.c                                |  27 +-
 fs/nfsd/vfs.c                                      |  28 +-
 fs/nfsd/vfs.h                                      |   4 +-
 fs/pstore/platform.c                               |   9 +-
 include/drm/bridge/samsung-dsim.h                  |   1 +
 include/linux/bpf.h                                |   5 +
 include/linux/clk-provider.h                       |  15 +-
 include/linux/cpuhotplug.h                         |   1 +
 include/linux/hisi_acc_qm.h                        |   7 +
 include/linux/hw_random.h                          |   1 +
 include/linux/idr.h                                |   6 +-
 include/linux/mfd/core.h                           |   2 +-
 include/linux/netdevice.h                          |   1 +
 include/linux/numa.h                               |  14 +-
 include/linux/objtool.h                            |   3 +-
 include/linux/pci.h                                |  34 ++-
 include/linux/perf_event.h                         |   1 +
 include/linux/pm.h                                 |  43 ++-
 include/linux/string.h                             |   7 +-
 include/linux/topology.h                           |   2 +-
 include/linux/udp.h                                |  66 +++--
 include/linux/verification.h                       |   1 +
 include/net/bluetooth/hci.h                        |   3 +
 include/net/bluetooth/hci_core.h                   |  59 +++-
 include/net/cfg80211.h                             |  21 ++
 include/net/flow.h                                 |   2 +-
 include/net/netfilter/nf_conntrack_act_ct.h        |  30 +-
 include/net/tcp.h                                  |   2 +-
 include/net/udp_tunnel.h                           |   9 +-
 include/net/udplite.h                              |  14 +-
 include/soc/tegra/bpmp.h                           |   6 +
 io_uring/kbuf.c                                    |  11 +-
 io_uring/net.c                                     |  24 +-
 kernel/bpf/hashtab.c                               |   7 +-
 kernel/bpf/helpers.c                               |  32 +-
 kernel/bpf/trampoline.c                            |   4 +-
 kernel/bpf/verifier.c                              |   7 +
 kernel/cpu.c                                       |  66 +++--
 kernel/events/core.c                               | 115 ++++----
 kernel/futex/core.c                                |  12 +-
 kernel/irq/matrix.c                                |   6 +-
 kernel/livepatch/core.c                            |   2 +-
 kernel/module/decompress.c                         |   8 +-
 kernel/padata.c                                    |   6 +-
 kernel/rcu/srcutree.c                              |  31 +-
 kernel/sched/core.c                                |  10 +-
 kernel/sched/deadline.c                            |   2 +
 kernel/sched/fair.c                                |  35 +--
 kernel/sched/rt.c                                  |   4 +
 kernel/sched/topology.c                            |   6 +-
 kernel/trace/trace_kprobe.c                        |   2 +-
 lib/kunit/executor.c                               |   4 +-
 lib/kunit/executor_test.c                          |  30 +-
 mm/mempolicy.c                                     |  18 +-
 mm/readahead.c                                     |   3 +-
 net/9p/client.c                                    |   6 +-
 net/bluetooth/amp.c                                |   3 +-
 net/bluetooth/hci_conn.c                           |  71 +++--
 net/bluetooth/hci_core.c                           |   3 +
 net/bluetooth/hci_event.c                          |  99 +++++--
 net/bluetooth/hci_sync.c                           |  19 +-
 net/bluetooth/iso.c                                | 169 ++++++++---
 net/core/page_pool.c                               |   6 +-
 net/core/skbuff.c                                  |   3 +-
 net/dccp/ipv4.c                                    |   6 +-
 net/dccp/ipv6.c                                    |   6 +-
 net/hsr/hsr_forward.c                              |   4 +-
 net/ipv4/syncookies.c                              |  20 +-
 net/ipv4/tcp_input.c                               |   9 +-
 net/ipv4/tcp_metrics.c                             |  15 +-
 net/ipv4/udp.c                                     |  74 ++---
 net/ipv4/udp_offload.c                             |   4 +-
 net/ipv4/udp_tunnel_core.c                         |   2 +-
 net/ipv4/udplite.c                                 |   1 -
 net/ipv4/xfrm4_input.c                             |   4 +-
 net/ipv6/ip6_output.c                              |   8 +-
 net/ipv6/syncookies.c                              |   7 +-
 net/ipv6/udp.c                                     |  34 ++-
 net/ipv6/udplite.c                                 |   1 -
 net/ipv6/xfrm6_input.c                             |   4 +-
 net/l2tp/l2tp_core.c                               |   6 +-
 net/llc/llc_input.c                                |  10 +-
 net/llc/llc_s_ac.c                                 |   3 +
 net/llc/llc_station.c                              |   3 +
 net/mac80211/driver-ops.c                          |   9 +-
 net/mac80211/drop.h                                |   3 +
 net/mac80211/ieee80211_i.h                         |  18 +-
 net/mac80211/iface.c                               |   2 +-
 net/mac80211/link.c                                |   2 +-
 net/mac80211/main.c                                |  25 +-
 net/mac80211/mesh_pathtbl.c                        |   2 +-
 net/mac80211/offchannel.c                          |  36 +--
 net/mac80211/rx.c                                  |   2 +-
 net/mac80211/scan.c                                |  36 +--
 net/mac80211/sta_info.c                            |   2 +-
 net/mac80211/util.c                                |  11 +-
 net/mptcp/fastopen.c                               |   1 +
 net/netfilter/nf_nat_redirect.c                    |  27 +-
 net/netfilter/nf_tables_api.c                      |   4 -
 net/netfilter/xt_recent.c                          |   2 +-
 net/openvswitch/conntrack.c                        |   2 +-
 net/rxrpc/conn_object.c                            |   2 +-
 net/rxrpc/local_object.c                           |   2 +-
 net/sched/act_ct.c                                 |  15 +-
 net/smc/af_smc.c                                   |   4 +-
 net/smc/smc.h                                      |   5 +
 net/smc/smc_cdc.c                                  |  11 +-
 net/smc/smc_close.c                                |   5 +-
 net/tipc/link.c                                    |   4 +-
 net/tipc/netlink.c                                 |   4 +-
 net/tls/tls_sw.c                                   |   2 +-
 net/vmw_vsock/virtio_transport_common.c            |  16 +-
 net/wireless/core.c                                |  34 ++-
 net/wireless/core.h                                |   3 +-
 net/wireless/scan.c                                |   4 +-
 net/wireless/sysfs.c                               |   4 +-
 scripts/Makefile.vmlinux_o                         |   3 +-
 scripts/gdb/linux/constants.py.in                  |   9 +-
 scripts/mod/file2alias.c                           |  14 +-
 security/apparmor/policy.c                         |   1 +
 security/apparmor/policy_unpack.c                  |   5 +-
 sound/pci/hda/cs35l41_hda.c                        |   5 +-
 sound/pci/hda/patch_realtek.c                      |  40 ++-
 sound/soc/codecs/cs35l41-lib.c                     |   2 +-
 sound/soc/codecs/cs35l41.c                         |  18 +-
 sound/soc/codecs/hdmi-codec.c                      |  27 +-
 sound/soc/fsl/fsl-asoc-card.c                      |   1 +
 sound/soc/fsl/fsl_easrc.c                          |   8 +-
 sound/soc/fsl/mpc5200_dma.c                        |   3 +
 .../soc/intel/boards/sof_sdw_rt_sdca_jack_common.c |   8 +
 sound/soc/intel/skylake/skl-sst-utils.c            |   1 +
 .../mediatek/mt8186/mt8186-mt6366-rt1019-rt5682s.c |   4 +-
 sound/soc/soc-dapm.c                               |   2 +-
 sound/soc/soc-pcm.c                                |  21 +-
 sound/soc/sof/core.c                               |   6 +-
 sound/soc/sof/ipc4-topology.c                      |   3 +-
 sound/soc/ti/ams-delta.c                           |   4 +-
 tools/iio/iio_generic_buffer.c                     |  13 +-
 tools/lib/perf/include/internal/rc_check.h         |   6 +-
 tools/objtool/objtool.c                            |   4 +-
 tools/perf/Documentation/perf-kwork.txt            |   2 +-
 tools/perf/Makefile.perf                           |   4 +
 tools/perf/arch/arm64/util/mem-events.c            |   2 +-
 tools/perf/arch/powerpc/util/mem-events.c          |   6 +-
 tools/perf/arch/x86/util/mem-events.c              |   8 +-
 tools/perf/arch/x86/util/pmu.c                     |  10 +-
 tools/perf/builtin-kwork.c                         |  13 +-
 tools/perf/builtin-list.c                          |   2 +-
 tools/perf/builtin-lock.c                          |  17 +-
 tools/perf/builtin-stat.c                          |   2 +-
 tools/perf/examples/bpf/augmented_raw_syscalls.c   |  16 +-
 .../perf/pmu-events/arch/powerpc/power10/pmc.json  |   2 +-
 .../arch/x86/broadwellde/bdwde-metrics.json        |  14 +-
 tools/perf/tests/pmu-events.c                      |  16 +-
 tools/perf/util/bpf_off_cpu.c                      |   5 +-
 tools/perf/util/bpf_skel/vmlinux/.gitignore        |   1 +
 tools/perf/util/env.c                              |   8 +-
 tools/perf/util/header.c                           |   8 +-
 tools/perf/util/hist.c                             |  10 +-
 tools/perf/util/machine.c                          |  22 +-
 tools/perf/util/mem-events.c                       |  19 +-
 tools/perf/util/mem-events.h                       |   2 +-
 tools/perf/util/parse-events.c                     |  15 +-
 tools/perf/util/parse-events.h                     |   2 +-
 tools/perf/util/parse-events.l                     |  11 -
 tools/perf/util/parse-events.y                     | 196 +-----------
 tools/perf/util/pmu.c                              |  16 +-
 tools/perf/util/pmu.h                              |   8 +-
 tools/power/cpupower/man/cpupower-powercap-info.1  |   2 +-
 tools/testing/cxl/test/mem.c                       |   4 +-
 .../bpf/prog_tests/module_fentry_shadow.c          |   5 +
 tools/testing/selftests/bpf/prog_tests/tailcalls.c |  32 +-
 tools/testing/selftests/mm/mdwe_test.c             |   9 +-
 tools/testing/selftests/net/mptcp/mptcp_join.sh    |  14 +-
 tools/testing/selftests/net/pmtu.sh                |   2 +-
 tools/testing/selftests/netfilter/Makefile         |   5 +-
 .../netfilter/conntrack_sctp_collision.sh          |  89 ++++++
 tools/testing/selftests/netfilter/sctp_collision.c |  99 +++++++
 tools/testing/selftests/netfilter/xt_string.sh     | 128 ++++++++
 tools/testing/selftests/pidfd/pidfd_fdinfo_test.c  |   2 +-
 tools/testing/selftests/pidfd/pidfd_test.c         |  12 +-
 tools/testing/selftests/resctrl/resctrl_tests.c    |   5 +
 tools/testing/selftests/x86/lam.c                  |   6 +-
 tools/tracing/rtla/src/utils.c                     |   2 +-
 607 files changed, 7847 insertions(+), 4412 deletions(-)


