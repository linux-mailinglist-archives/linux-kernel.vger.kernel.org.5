Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E15A37ED3AF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 21:54:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235036AbjKOUyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 15:54:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234999AbjKOUyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 15:54:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D6EC130;
        Wed, 15 Nov 2023 12:53:53 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABC10C4E778;
        Wed, 15 Nov 2023 20:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700081633;
        bh=2iC7WZSOPR/eTSXFup+1wEqNeiBOmnRq7Qwju/Qn7Z4=;
        h=From:To:Cc:Subject:Date:From;
        b=pwr5omtunSmHMT4YwYxUt1vWXOWOLZkXNEGX2viy2zuiP4hF+O3l/u5y9ggTo4ZaN
         zEtoIXWYJEDx+T02afwYf6Sjy0oeLHppmNZiYwdz5uOEYePd80T8m6BIPaJH0jqNOt
         iwRl04g485oBk0YKxtinFd0XbIQAA99me4mXzqT0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: [PATCH 5.10 000/191] 5.10.201-rc1 review
Date:   Wed, 15 Nov 2023 15:44:35 -0500
Message-ID: <20231115204644.490636297@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.201-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.10.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.10.201-rc1
X-KernelTest-Deadline: 2023-11-17T20:46+00:00
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

This is the start of the stable review cycle for the 5.10.201 release.
There are 191 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Fri, 17 Nov 2023 20:46:03 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.201-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 5.10.201-rc1

Filipe Manana <fdmanana@suse.com>
    btrfs: use u64 for buffer sizes in the tree search ioctls

Dominique Martinet <dominique.martinet@atmark-techno.com>
    Revert "mmc: core: Capture correct oemid-bits for eMMC cards"

Yujie Liu <yujie.liu@intel.com>
    tracing/kprobes: Fix the order of argument descriptions

Arnd Bergmann <arnd@arndb.de>
    fbdev: fsl-diu-fb: mark wr_reg_wa() static

Dan Carpenter <dan.carpenter@linaro.org>
    fbdev: imsttfb: fix a resource leak in probe

Helge Deller <deller@gmx.de>
    fbdev: imsttfb: Fix error path of imsttfb_probe()

Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
    spi: spi-zynq-qspi: add spi-mem to driver kconfig dependencies

Erik Kurzinger <ekurzinger@nvidia.com>
    drm/syncobj: fix DRM_SYNCOBJ_WAIT_FLAGS_WAIT_AVAILABLE

Adam Dunlap <acdunlap@google.com>
    x86/sev-es: Allow copy_from_kernel_nofault() in earlier boot

Adrian Hunter <adrian.hunter@intel.com>
    x86: Share definition of __is_canonical_address()

Florian Westphal <fw@strlen.de>
    netfilter: nat: fix ipv6 nat redirect with mapped and scoped addresses

Jeremy Sowden <jeremy@azazel.net>
    netfilter: nft_redir: use `struct nf_nat_range2` throughout and deduplicate eval call-backs

Maciej Żenczykowski <zenczykowski@gmail.com>
    netfilter: xt_recent: fix (increase) ipv6 literal buffer length

Heiner Kallweit <hkallweit1@gmail.com>
    r8169: respect userspace disabling IFF_MULTICAST

George Shuklin <george.shuklin@gmail.com>
    tg3: power down device only on SYSTEM_POWER_OFF

D. Wythe <alibuda@linux.alibaba.com>
    net/smc: put sk reference if close work was canceled

D. Wythe <alibuda@linux.alibaba.com>
    net/smc: allow cdc msg send rather than drop it with NULL sndbuf_desc

D. Wythe <alibuda@linux.alibaba.com>
    net/smc: fix dangling sock under state SMC_APPFINCLOSEWAIT

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

Eric Dumazet <edumazet@google.com>
    inet: shrink struct flowi_common

Shigeru Yoshida <syoshida@redhat.com>
    tipc: Change nla_policy for bearer-related names to NLA_NUL_STRING

Dan Carpenter <dan.carpenter@linaro.org>
    hsr: Prevent use after free in prp_create_tagged_frame()

Willem de Bruijn <willemb@google.com>
    llc: verify mac len before reading mac header

Dan Carpenter <dan.carpenter@linaro.org>
    Input: synaptics-rmi4 - fix use after free in rmi_unregister_function()

Florian Fainelli <florian.fainelli@broadcom.com>
    pwm: brcmstb: Utilize appropriate clock APIs in suspend/resume

Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    pwm: sti: Reduce number of allocations and drop usage of chip_data

Thierry Reding <thierry.reding@gmail.com>
    pwm: sti: Avoid conditional gotos

Ben Wolsieffer <ben.wolsieffer@hefring.com>
    regmap: prevent noinc writes from clobbering cache

Hans Verkuil <hverkuil-cisco@xs4all.nl>
    media: dvb-usb-v2: af9035: fix missing unlock

Jernej Skrabec <jernej.skrabec@gmail.com>
    media: cedrus: Fix clock/reset sequence

Jiasheng Jiang <jiasheng@iscas.ac.cn>
    media: vidtv: mux: Add check and kfree for kstrdup

Jiasheng Jiang <jiasheng@iscas.ac.cn>
    media: vidtv: psi: Add check for kstrdup

Katya Orlova <e.orlova@ispras.ru>
    media: s3c-camif: Avoid inappropriate kfree()

Zheng Wang <zyytlz.wz@163.com>
    media: bttv: fix use after free error due to btv->timeout timer

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    media: i2c: max9286: Fix some redundant of_node_put() calls

Yang Yingliang <yangyingliang@huawei.com>
    pcmcia: ds: fix possible name leak in error path in pcmcia_device_add()

Yang Yingliang <yangyingliang@huawei.com>
    pcmcia: ds: fix refcount leak in pcmcia_device_add()

Yang Yingliang <yangyingliang@huawei.com>
    pcmcia: cs: fix possible hung task and memory leak pccardd()

Javier Carrasco <javier.carrasco.cruz@gmail.com>
    rtc: pcf85363: fix wrong mask/val parameters in regmap_update_bits call

Dinghao Liu <dinghao.liu@zju.edu.cn>
    i3c: Fix potential refcount leak in i3c_master_register_new_i3c_devs

Ian Rogers <irogers@google.com>
    perf hist: Add missing puts to hist__account_cycles

Ian Rogers <irogers@google.com>
    perf machine: Avoid out of bounds LBR memory read

Sergey Shtylyov <s.shtylyov@omp.ru>
    usb: host: xhci-plat: fix possible kernel oops while resuming

Basavaraj Natikar <Basavaraj.Natikar@amd.com>
    xhci: Loosen RPM as default policy to cover for AMD xHC 1.1

Wang Yufen <wangyufen@huawei.com>
    powerpc/pseries: fix potential memory leak in init_cpu_associativity()

Sebastian Andrzej Siewior <bigeasy@linutronix.de>
    powerpc/imc-pmu: Use the correct spinlock initializer.

Benjamin Gray <bgray@linux.ibm.com>
    powerpc/xive: Fix endian conversion size

Christophe Leroy <christophe.leroy@csgroup.eu>
    powerpc/40x: Remove stale PTE_ATOMIC_UPDATES macro

Masahiro Yamada <masahiroy@kernel.org>
    modpost: fix tee MODULE_DEVICE_TABLE built on big-endian host

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    interconnect: qcom: osm-l3: Replace custom implementation of COUNT_ARGS()

Konrad Dybcio <konrad.dybcio@linaro.org>
    interconnect: qcom: sc7180: Set ACV enable_mask

Konrad Dybcio <konrad.dybcio@linaro.org>
    interconnect: qcom: sc7180: Retire DEFINE_QBCM

Chao Yu <chao@kernel.org>
    f2fs: fix to initialize map.m_pblk in f2fs_precache_extents()

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    dmaengine: pxa_dma: Remove an erroneous BUG_ON() in pxad_free_desc()

Jonas Blixt <jonas.blixt@actia.se>
    USB: usbip: fix stub_dev hub disconnect

Matti Vaittinen <mazziesaccount@gmail.com>
    tools: iio: iio_generic_buffer ensure alignment

Chenyuan Mi <michenyuan@huawei.com>
    tools: iio: iio_generic_buffer: Fix some integer type and calculation

Alexandru Ardelean <alexandru.ardelean@analog.com>
    tools: iio: privatize globals and functions in iio_generic_buffer.c file

Jinjie Ruan <ruanjinjie@huawei.com>
    misc: st_core: Do not call kfree_skb() under spin_lock_irqsave()

Dan Carpenter <dan.carpenter@linaro.org>
    dmaengine: ti: edma: handle irq_of_parse_and_map() errors

Jia-Ju Bai <baijiaju@buaa.edu.cn>
    usb: dwc2: fix possible NULL pointer dereference caused by driver concurrency

Ian Rogers <irogers@google.com>
    perf evlist: Avoid frequency mode for the dummy event

Namhyung Kim <namhyung@kernel.org>
    perf tools: Get rid of evlist__add_on_all_cpus()

Adrian Hunter <adrian.hunter@intel.com>
    perf evlist: Add evlist__add_dummy_on_all_cpus()

Zheng Yejian <zhengyejian1@huawei.com>
    livepatch: Fix missing newline character in klp_resolve_symbols()

Yi Yang <yiyang13@huawei.com>
    tty: tty_jobctrl: fix pid memleak in disassociate_ctty()

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    leds: trigger: ledtrig-cpu:: Fix 'output may be truncated' issue for 'cpu'

Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    leds: pwm: Don't disable the PWM when the LED should be off

Dinghao Liu <dinghao.liu@zju.edu.cn>
    mfd: dln2: Fix double put in dln2_probe

Herve Codina <herve.codina@bootlin.com>
    mfd: core: Ensure disabled devices are skipped without aborting

Michał Mirosław <mirq-linux@rere.qmqm.pl>
    mfd: core: Un-constify mfd_cell.of_reg

Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
    ASoC: ams-delta.c: use component after check

WangJinchao <wangjinchao@xfusion.com>
    padata: Fix refcnt handling in padata_free_shell()

Xiyu Yang <xiyuyang19@fudan.edu.cn>
    padata: Convert from atomic_t to refcount_t on parallel_data->refcnt

Cezary Rojewski <cezary.rojewski@intel.com>
    ASoC: Intel: Skylake: Fix mem leak when parsing UUIDs fails

Hans de Goede <hdegoede@redhat.com>
    HID: logitech-hidpp: Move get_wireless_feature_index() check to hidpp_connect_event()

Hans de Goede <hdegoede@redhat.com>
    HID: logitech-hidpp: Revert "Don't restart communication if not necessary"

Hans de Goede <hdegoede@redhat.com>
    HID: logitech-hidpp: Don't restart IO, instead defer hid_connect() only

Bastien Nocera <hadess@hadess.net>
    HID: logitech-hidpp: Remove HIDPP_QUIRK_NO_HIDINPUT quirk

Bastien Nocera <hadess@hadess.net>
    Revert "HID: logitech-hidpp: add a module parameter to keep firmware gestures"

Geert Uytterhoeven <geert+renesas@glider.be>
    sh: bios: Revive earlyprintk support

Danny Kaehn <danny.kaehn@plexus.com>
    hid: cp2112: Fix IRQ shutdown stopping polling for all IRQs on chip

Leon Romanovsky <leon@kernel.org>
    RDMA/hfi1: Workaround truncation compilation error

Daniel Mentz <danielmentz@google.com>
    scsi: ufs: core: Leave space for '\0' in utf8 desc string

Zhang Shurong <zhang_shurong@foxmail.com>
    ASoC: fsl: Fix PM disable depth imbalance in fsl_easrc_probe

Chengchang Tang <tangchengchang@huawei.com>
    RDMA/hns: Fix signed-unsigned mixed comparisons

Chengchang Tang <tangchengchang@huawei.com>
    RDMA/hns: Fix uninitialized ucmd in hns_roce_create_qp_common()

Patrisious Haddad <phaddad@nvidia.com>
    IB/mlx5: Fix rdma counter binding for RAW QP

Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
    ASoC: fsl: mpc5200_dma.c: Fix warning of Function parameter or member not described

Gou Hao <gouhao@uniontech.com>
    ext4: move 'ix' sanity check to corrent position

Kursad Oney <kursad.oney@broadcom.com>
    ARM: 9321/1: memset: cast the constant byte to unsigned char

Danny Kaehn <danny.kaehn@plexus.com>
    hid: cp2112: Fix duplicate workqueue initialization

Giovanni Cabiddu <giovanni.cabiddu@intel.com>
    crypto: qat - increase size of buffers

Giovanni Cabiddu <giovanni.cabiddu@intel.com>
    crypto: qat - mask device capabilities with soft straps

Gaurav Jain <gaurav.jain@nxp.com>
    crypto: caam/jr - fix Chacha20 + Poly1305 self test failure

Gaurav Jain <gaurav.jain@nxp.com>
    crypto: caam/qi2 - fix Chacha20 + Poly1305 self test failure

Tomas Glozar <tglozar@redhat.com>
    nd_btt: Make BTT lanes preemptible

Chen Ni <nichen@iscas.ac.cn>
    libnvdimm/of_pmem: Use devm_kstrdup instead of kstrdup and check its return value

Jonas Gorski <jonas.gorski@gmail.com>
    hwrng: geode - fix accessing registers

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    crypto: hisilicon/hpre - Fix a erroneous check after snprintf()

Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
    selftests/resctrl: Ensure the benchmark commands fits to its array

Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
    selftests/pidfd: Fix ksft print formats

Sudeep Holla <sudeep.holla@arm.com>
    clk: scmi: Free scmi_clk allocated when the clocks with invalid info are skipped

Dhruva Gole <d-gole@ti.com>
    firmware: ti_sci: Mark driver as non removable

Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    soc: qcom: llcc: Handle a second device without data corruption

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    ARM: dts: qcom: mdm9615: populate vsdcc fixed regulator

Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
    arm64: dts: qcom: sdm845-mtp: fix WiFi configuration

Gaurav Kohli <quic_gkohli@quicinc.com>
    arm64: dts: qcom: msm8916: Fix iommu local address range

Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>
    xen-pciback: Consider INTx disabled when MSI/MSI-X is enabled

Dan Carpenter <dan.carpenter@linaro.org>
    drm/rockchip: Fix type promotion bug in rockchip_gem_iommu_map()

Mark Rutland <mark.rutland@arm.com>
    arm64/arm: xen: enlighten: Fix KPTI checks

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    drm/rockchip: cdn-dp: Fix some error handling paths in cdn_dp_probe()

Jason-JH.Lin <jason-jh.lin@mediatek.com>
    drm/mediatek: Fix iommu fault during crtc enabling

Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
    drm/bridge: tc358768: Fix bit updates

Dmitry Osipenko <digetx@gmail.com>
    drm/bridge: tc358768: Disable non-continuous clock mode

Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
    drm/bridge: tc358768: Fix use of uninitialized variable

Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
    drm/radeon: possible buffer overflow

Jonas Karlman <jonas@kwiboo.se>
    drm/rockchip: vop: Fix call to crtc reset helper

Jonas Karlman <jonas@kwiboo.se>
    drm/rockchip: vop: Fix reset of state in duplicate state crtc funcs

Zhang Rui <rui.zhang@intel.com>
    hwmon: (coretemp) Fix potentially truncated sysfs attribute name

Dragos Bogdan <dragos.bogdan@analog.com>
    hwmon: (axi-fan-control) Fix possible NULL pointer dereference

Nuno Sá <nuno.sa@analog.com>
    hwmon: (axi-fan-control) Support temperature vs pwm points

Armin Wolf <W_Armin@gmx.de>
    platform/x86: wmi: Fix opening of char device

Barnabás Pőcze <pobrn@protonmail.com>
    platform/x86: wmi: remove unnecessary initializations

Armin Wolf <W_Armin@gmx.de>
    platform/x86: wmi: Fix probe failure when failing to register WMI devices

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

Dario Binacchi <dario.binacchi@amarulasolutions.com>
    clk: ti: change ti_clk_register[_omap_hw]() API

Tony Lindgren <tony@atomide.com>
    clk: ti: Update component clocks to use ti_dt_clk_name()

Tony Lindgren <tony@atomide.com>
    clk: ti: Update pll and clockdomain clocks to use ti_dt_clk_name()

Tony Lindgren <tony@atomide.com>
    clk: ti: Add ti_dt_clk_name() helper to use clock-output-names

Dan Carpenter <dan.carpenter@linaro.org>
    clk: keystone: pll: fix a couple NULL vs IS_ERR() checks

Han Xu <han.xu@nxp.com>
    spi: nxp-fspi: use the correct ioremap function

Randy Dunlap <rdunlap@infradead.org>
    clk: linux/clk-provider.h: fix kernel-doc warnings and typos

Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
    clk: asm9260: use parent index to link the reference clock

Peng Fan <peng.fan@nxp.com>
    clk: imx: imx8mq: correct error handling path

Abel Vesa <abel.vesa@linaro.org>
    clk: imx: Select MXC_CLK for CLK_IMX8QXP

Danila Tikhonov <danila@jiaxyga.com>
    clk: qcom: gcc-sm8150: Fix gcc_sdcc2_apps_clk_src

Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
    clk: qcom: gcc-sm8150: use ARRAY_SIZE instead of specifying num_parents

Konrad Dybcio <konrad.dybcio@linaro.org>
    clk: qcom: mmcc-msm8998: Fix the SMMU GDSC

AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
    clk: qcom: mmcc-msm8998: Set bimc_smmu_gdsc always on

Konrad Dybcio <konrad.dybcio@linaro.org>
    clk: qcom: mmcc-msm8998: Don't check halt bit on some branch clks

AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
    clk: qcom: mmcc-msm8998: Add hardware clockgating registers to some clks

Devi Priya <quic_devipriy@quicinc.com>
    clk: qcom: clk-rcg2: Fix clock rate overflow for high parent frequencies

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    regmap: debugfs: Fix a erroneous check after snprintf()

Eric Dumazet <edumazet@google.com>
    ipvlan: properly track tx_errors

Eric Dumazet <edumazet@google.com>
    net: add DEV_STATS_READ() helper

Yan Zhai <yan@cloudflare.com>
    ipv6: avoid atomic fragment on GSO packets

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    ACPI: sysfs: Fix create_pnp_modalias() and create_of_modalias()

Eric Dumazet <edumazet@google.com>
    tcp: fix cookie_init_timestamp() overflows

Eric Dumazet <edumazet@google.com>
    chtls: fix tp->rcv_tstamp initialization

Heiner Kallweit <hkallweit1@gmail.com>
    r8169: fix rare issue with broken rx after link-down on RTL8125

Juhee Kang <claudiajkang@gmail.com>
    r8169: use tp_to_dev instead of open code

Dan Carpenter <dan.carpenter@linaro.org>
    thermal: core: prevent potential string overflow

Sascha Hauer <s.hauer@pengutronix.de>
    PM / devfreq: rockchip-dfi: Make pmu regmap mandatory

Marc Kleine-Budde <mkl@pengutronix.de>
    can: dev: can_restart(): fix race condition between controller restart and netif_carrier_on()

Marc Kleine-Budde <mkl@pengutronix.de>
    can: dev: can_restart(): don't crash kernel if carrier is OK

Dmitry Antipov <dmantipov@yandex.ru>
    wifi: rtlwifi: fix EDCA limit set by BT coexistence

Eric Dumazet <edumazet@google.com>
    tcp_metrics: do not create an entry from tcp_init_metrics()

Eric Dumazet <edumazet@google.com>
    tcp_metrics: properly set tp->snd_ssthresh in tcp_init_metrics()

Eric Dumazet <edumazet@google.com>
    tcp_metrics: add missing barriers on delete

Felix Fietkau <nbd@nbd.name>
    wifi: mt76: mt7603: rework/fix rx pse hang check

Jinjie Ruan <ruanjinjie@huawei.com>
    wifi: rtw88: debug: Fix the NULL vs IS_ERR() bug for debugfs_create_file()

Gustavo A. R. Silva <gustavoars@kernel.org>
    net: spider_net: Use size_add() in call to struct_size()

Gustavo A. R. Silva <gustavoars@kernel.org>
    tipc: Use size_add() in calls to struct_size()

Gustavo A. R. Silva <gustavoars@kernel.org>
    mlxsw: Use size_mul() in call to struct_size()

Gustavo A. R. Silva <gustavoars@kernel.org>
    gve: Use size_add() in call to struct_size()

Kees Cook <keescook@chromium.org>
    overflow: Implement size_t saturating arithmetic helpers

Aananth V <aananthv@google.com>
    tcp: call tcp_try_undo_recovery when an RTOd TFO SYNACK is ACKed

Eric Dumazet <edumazet@google.com>
    udp: add missing WRITE_ONCE() around up->encap_rcv

Miri Korenblit <miriam.rachel.korenblit@intel.com>
    wifi: iwlwifi: Use FW rate for non-data frames

Andrii Staikov <andrii.staikov@intel.com>
    i40e: fix potential memory leaks in i40e_remove()

Chen Yu <yu.c.chen@intel.com>
    genirq/matrix: Exclude managed interrupts in irq_matrix_allocated()

Jiasheng Jiang <jiasheng@iscas.ac.cn>
    pstore/platform: Add check for kstrdup

Yuntao Wang <ytcoode@gmail.com>
    x86/boot: Fix incorrect startup_gdt_descr.size

Ben Wolsieffer <ben.wolsieffer@hefring.com>
    futex: Don't include process MM in futex key on no-MMU

Josh Poimboeuf <jpoimboe@kernel.org>
    x86/srso: Fix SBPB enablement for (possible) future fixed HW

Reuben Hawkins <reubenhwk@gmail.com>
    vfs: fix readahead(2) on block devices

Qais Yousef <qyousef@layalina.io>
    sched/uclamp: Ignore (util == 0) optimization in feec() when p_util_max = 0

David Howells <dhowells@redhat.com>
    iov_iter, x86: Be consistent about the __user tag on copy_mc_to_user()


-------------

Diffstat:

 Documentation/process/deprecated.rst               |  20 +-
 Makefile                                           |   4 +-
 arch/arm/boot/dts/qcom-mdm9615.dtsi                |  14 +-
 arch/arm/lib/memset.S                              |   1 +
 arch/arm/xen/enlighten.c                           |  25 +-
 arch/arm64/boot/dts/qcom/msm8916.dtsi              |   2 +-
 arch/arm64/boot/dts/qcom/sdm845-mtp.dts            |   2 +
 arch/powerpc/include/asm/nohash/32/pte-40x.h       |   3 -
 arch/powerpc/perf/imc-pmu.c                        |   2 +-
 arch/powerpc/platforms/pseries/lpar.c              |   4 +-
 arch/powerpc/sysdev/xive/native.c                  |   2 +-
 arch/sh/Kconfig.debug                              |  11 +
 arch/x86/events/intel/pt.c                         |  14 +-
 arch/x86/include/asm/page.h                        |  10 +
 arch/x86/include/asm/uaccess.h                     |   2 +-
 arch/x86/kernel/cpu/bugs.c                         |   2 +-
 arch/x86/kernel/head64.c                           |   2 +-
 arch/x86/kvm/emulate.c                             |   4 +-
 arch/x86/kvm/x86.c                                 |   2 +-
 arch/x86/kvm/x86.h                                 |   7 +-
 arch/x86/lib/copy_mc.c                             |   8 +-
 arch/x86/mm/maccess.c                              |  24 +-
 drivers/acpi/device_sysfs.c                        |  10 +-
 drivers/base/regmap/regmap-debugfs.c               |   2 +-
 drivers/base/regmap/regmap.c                       |  16 +-
 drivers/char/hw_random/geode-rng.c                 |   6 +-
 drivers/clk/clk-asm9260.c                          |  29 +--
 drivers/clk/clk-npcm7xx.c                          |   2 +-
 drivers/clk/clk-scmi.c                             |   1 +
 drivers/clk/imx/Kconfig                            |   1 +
 drivers/clk/imx/clk-imx8mq.c                       |  17 +-
 drivers/clk/keystone/pll.c                         |  15 +-
 drivers/clk/mediatek/clk-mt2701.c                  |   8 +
 drivers/clk/mediatek/clk-mt6765.c                  |   6 +
 drivers/clk/mediatek/clk-mt6779.c                  |   4 +
 drivers/clk/mediatek/clk-mt6797.c                  |   6 +
 drivers/clk/mediatek/clk-mt7629-eth.c              |   4 +
 drivers/clk/mediatek/clk-mt7629.c                  |   6 +
 drivers/clk/qcom/Kconfig                           |   1 +
 drivers/clk/qcom/clk-rcg2.c                        |  14 +-
 drivers/clk/qcom/gcc-sm8150.c                      |  98 ++++----
 drivers/clk/qcom/mmcc-msm8998.c                    |  17 +-
 drivers/clk/ti/apll.c                              |  13 +-
 drivers/clk/ti/autoidle.c                          |   2 +-
 drivers/clk/ti/clk-dra7-atl.c                      |   6 +-
 drivers/clk/ti/clk.c                               |  52 +++--
 drivers/clk/ti/clkctrl.c                           |   4 +-
 drivers/clk/ti/clock.h                             |  11 +-
 drivers/clk/ti/clockdomain.c                       |   2 +-
 drivers/clk/ti/composite.c                         |   6 +-
 drivers/clk/ti/divider.c                           |  12 +-
 drivers/clk/ti/dpll.c                              |  10 +-
 drivers/clk/ti/fapll.c                             |  11 +-
 drivers/clk/ti/fixed-factor.c                      |   4 +-
 drivers/clk/ti/gate.c                              |   8 +-
 drivers/clk/ti/interface.c                         |   9 +-
 drivers/clk/ti/mux.c                               |   8 +-
 drivers/crypto/caam/caamalg.c                      |   3 +-
 drivers/crypto/caam/caamalg_qi2.c                  |   3 +-
 drivers/crypto/hisilicon/hpre/hpre_main.c          |   2 +-
 drivers/crypto/qat/qat_c3xxx/adf_c3xxx_hw_data.c   |  34 ++-
 drivers/crypto/qat/qat_c3xxx/adf_c3xxx_hw_data.h   |   1 +
 drivers/crypto/qat/qat_c3xxx/adf_drv.c             |   6 +-
 .../crypto/qat/qat_c3xxxvf/adf_c3xxxvf_hw_data.c   |   4 +-
 drivers/crypto/qat/qat_c3xxxvf/adf_drv.c           |   4 +-
 drivers/crypto/qat/qat_c62x/adf_c62x_hw_data.c     |  34 ++-
 drivers/crypto/qat/qat_c62x/adf_c62x_hw_data.h     |   1 +
 drivers/crypto/qat/qat_c62x/adf_drv.c              |   6 +-
 drivers/crypto/qat/qat_c62xvf/adf_c62xvf_hw_data.c |   4 +-
 drivers/crypto/qat/qat_c62xvf/adf_drv.c            |   4 +-
 drivers/crypto/qat/qat_common/adf_accel_devices.h  |   7 +-
 .../crypto/qat/qat_common/adf_transport_debug.c    |   4 +-
 drivers/crypto/qat/qat_common/qat_hal.c            |  27 ++-
 .../crypto/qat/qat_dh895xcc/adf_dh895xcc_hw_data.c |  20 +-
 drivers/crypto/qat/qat_dh895xcc/adf_drv.c          |   4 +-
 .../qat/qat_dh895xccvf/adf_dh895xccvf_hw_data.c    |   4 +-
 drivers/crypto/qat/qat_dh895xccvf/adf_drv.c        |   4 +-
 drivers/devfreq/event/rockchip-dfi.c               |  15 +-
 drivers/dma/pxa_dma.c                              |   1 -
 drivers/dma/ti/edma.c                              |   4 +-
 drivers/firmware/ti_sci.c                          |  46 +---
 drivers/gpu/drm/bridge/tc358768.c                  |  25 +-
 drivers/gpu/drm/drm_syncobj.c                      |   3 +-
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c            |   3 +
 drivers/gpu/drm/radeon/evergreen.c                 |   7 +-
 drivers/gpu/drm/rockchip/cdn-dp-core.c             |  15 +-
 drivers/gpu/drm/rockchip/rockchip_drm_gem.c        |   2 +-
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c        |   8 +-
 drivers/hid/hid-cp2112.c                           |   9 +-
 drivers/hid/hid-logitech-hidpp.c                   |  76 +++---
 drivers/hwmon/axi-fan-control.c                    | 101 ++++++--
 drivers/hwmon/coretemp.c                           |   2 +-
 drivers/i3c/master.c                               |   4 +-
 drivers/infiniband/hw/hfi1/efivar.c                |   2 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c         |   2 +-
 drivers/infiniband/hw/hns/hns_roce_qp.c            |   2 +-
 drivers/infiniband/hw/mlx5/qp.c                    |  27 +++
 drivers/input/rmi4/rmi_bus.c                       |   2 +-
 drivers/interconnect/qcom/osm-l3.c                 |   3 +-
 drivers/interconnect/qcom/sc7180.c                 | 256 +++++++++++++++++++--
 drivers/leds/leds-pwm.c                            |   2 +-
 drivers/leds/trigger/ledtrig-cpu.c                 |   4 +-
 drivers/media/i2c/max9286.c                        |   2 -
 drivers/media/pci/bt8xx/bttv-driver.c              |   1 +
 drivers/media/platform/s3c-camif/camif-capture.c   |   6 +-
 drivers/media/test-drivers/vidtv/vidtv_mux.c       |   7 +-
 drivers/media/test-drivers/vidtv/vidtv_psi.c       |  45 +++-
 drivers/media/usb/dvb-usb-v2/af9035.c              |  13 +-
 drivers/mfd/dln2.c                                 |   1 -
 drivers/mfd/mfd-core.c                             |  17 +-
 drivers/misc/ti-st/st_core.c                       |   7 +-
 drivers/mmc/core/mmc.c                             |   2 +-
 drivers/net/can/dev/dev.c                          |  10 +-
 drivers/net/ethernet/broadcom/tg3.c                |   3 +-
 .../chelsio/inline_crypto/chtls/chtls_cm.c         |   2 +-
 drivers/net/ethernet/google/gve/gve_main.c         |   2 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c        |  10 +-
 .../mellanox/mlxsw/spectrum_acl_bloom_filter.c     |   2 +-
 drivers/net/ethernet/realtek/r8169_main.c          |  15 +-
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h     |   2 +-
 .../net/ethernet/stmicro/stmmac/dwxgmac2_core.c    |  14 +-
 drivers/net/ethernet/toshiba/spider_net.c          |   2 +-
 drivers/net/ipvlan/ipvlan_core.c                   |   8 +-
 drivers/net/ipvlan/ipvlan_main.c                   |   1 +
 drivers/net/macsec.c                               |   6 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c        |  14 +-
 drivers/net/wireless/mediatek/mt76/mt7603/core.c   |   2 +
 drivers/net/wireless/mediatek/mt76/mt7603/mac.c    |  23 +-
 .../net/wireless/realtek/rtlwifi/rtl8188ee/dm.c    |   2 +-
 .../wireless/realtek/rtlwifi/rtl8192c/dm_common.c  |   2 +-
 .../net/wireless/realtek/rtlwifi/rtl8723ae/dm.c    |   2 +-
 drivers/net/wireless/realtek/rtw88/debug.c         |   4 +-
 drivers/nvdimm/of_pmem.c                           |   8 +-
 drivers/nvdimm/region_devs.c                       |   8 +-
 drivers/pcmcia/cs.c                                |   1 +
 drivers/pcmcia/ds.c                                |  14 +-
 drivers/platform/x86/wmi.c                         |  50 ++--
 drivers/pwm/pwm-brcmstb.c                          |   4 +-
 drivers/pwm/pwm-sti.c                              |  75 +++---
 drivers/rtc/rtc-pcf85363.c                         |   2 +-
 drivers/scsi/ufs/ufshcd.c                          |   2 +-
 drivers/soc/qcom/llcc-qcom.c                       |   3 +
 drivers/spi/Kconfig                                |   1 +
 drivers/spi/spi-nxp-fspi.c                         |   2 +-
 drivers/staging/media/sunxi/cedrus/cedrus_hw.c     |  24 +-
 drivers/thermal/thermal_core.c                     |   6 +-
 drivers/tty/tty_jobctrl.c                          |  17 +-
 drivers/usb/dwc2/hcd.c                             |   2 +-
 drivers/usb/host/xhci-pci.c                        |   2 +
 drivers/usb/host/xhci-plat.c                       |  23 +-
 drivers/usb/usbip/stub_dev.c                       |   9 +-
 drivers/video/fbdev/fsl-diu-fb.c                   |   2 +-
 drivers/video/fbdev/imsttfb.c                      |  33 +--
 drivers/xen/xen-pciback/conf_space.c               |  19 +-
 drivers/xen/xen-pciback/conf_space_capability.c    |   8 +-
 drivers/xen/xen-pciback/conf_space_header.c        |  21 +-
 fs/btrfs/ioctl.c                                   |  10 +-
 fs/ext4/extents.c                                  |  10 +-
 fs/f2fs/file.c                                     |   1 +
 fs/pstore/platform.c                               |   9 +-
 include/linux/clk-provider.h                       |  34 ++-
 include/linux/cpuhotplug.h                         |   1 +
 include/linux/idr.h                                |   6 +-
 include/linux/mfd/core.h                           |   2 +-
 include/linux/netdevice.h                          |   1 +
 include/linux/overflow.h                           | 110 +++++----
 include/linux/padata.h                             |   3 +-
 include/net/flow.h                                 |   2 +-
 include/net/netfilter/nf_nat_redirect.h            |   3 +-
 include/net/tcp.h                                  |   2 +-
 kernel/futex/core.c                                |  12 +-
 kernel/irq/matrix.c                                |   6 +-
 kernel/livepatch/core.c                            |   2 +-
 kernel/padata.c                                    |  14 +-
 kernel/sched/fair.c                                |  18 +-
 kernel/trace/trace_kprobe.c                        |   2 +-
 lib/test_overflow.c                                |  98 ++++++++
 mm/readahead.c                                     |   3 +-
 net/dccp/ipv4.c                                    |   6 +-
 net/dccp/ipv6.c                                    |   6 +-
 net/hsr/hsr_forward.c                              |   4 +-
 net/ipv4/syncookies.c                              |  20 +-
 net/ipv4/tcp_input.c                               |   9 +-
 net/ipv4/tcp_metrics.c                             |  15 +-
 net/ipv4/udp.c                                     |   6 +-
 net/ipv6/ip6_output.c                              |   8 +-
 net/ipv6/syncookies.c                              |   7 +-
 net/llc/llc_input.c                                |  10 +-
 net/llc/llc_s_ac.c                                 |   3 +
 net/llc/llc_station.c                              |   3 +
 net/netfilter/nf_nat_redirect.c                    |  98 ++++----
 net/netfilter/nft_redir.c                          |  84 +++----
 net/netfilter/xt_REDIRECT.c                        |  10 +-
 net/netfilter/xt_recent.c                          |   2 +-
 net/smc/af_smc.c                                   |   4 +-
 net/smc/smc.h                                      |   5 +
 net/smc/smc_cdc.c                                  |  11 +-
 net/smc/smc_close.c                                |   5 +-
 net/tipc/link.c                                    |   4 +-
 net/tipc/netlink.c                                 |   4 +-
 scripts/mod/file2alias.c                           |  10 +-
 sound/soc/fsl/fsl_easrc.c                          |   8 +-
 sound/soc/fsl/mpc5200_dma.c                        |   3 +
 sound/soc/intel/skylake/skl-sst-utils.c            |   1 +
 sound/soc/ti/ams-delta.c                           |   4 +-
 tools/iio/iio_generic_buffer.c                     |  59 +++--
 tools/perf/util/evlist.c                           |  21 ++
 tools/perf/util/evlist.h                           |   5 +
 tools/perf/util/hist.c                             |  10 +-
 tools/perf/util/machine.c                          |  22 +-
 tools/testing/selftests/pidfd/pidfd_fdinfo_test.c  |   2 +-
 tools/testing/selftests/pidfd/pidfd_test.c         |  12 +-
 tools/testing/selftests/resctrl/resctrl_tests.c    |   5 +
 213 files changed, 1806 insertions(+), 975 deletions(-)


