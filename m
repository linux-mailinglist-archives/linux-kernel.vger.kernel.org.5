Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FBEA7ED6AE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 23:02:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343741AbjKOWCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 17:02:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235633AbjKOWCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 17:02:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67734197;
        Wed, 15 Nov 2023 14:02:46 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C98E3C433C8;
        Wed, 15 Nov 2023 22:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700085766;
        bh=kGNVoJ15JyKnUE4MRcVtjyvPmo1eSia+XFi4yV7SeVY=;
        h=From:To:Cc:Subject:Date:From;
        b=QIt/DFdUkR92tswyxPQmggXFt5uvVlef97IGL13HquHyYHw/l2IZR2XLSNmGEIr5y
         gPcEyRTbGRzkmWbUu+DLOJx7eSJ8tApnR2Jo8/iK7kiWXuMtm5vphJNskt8eBrTmaZ
         9+n5W06d+NGRPF+TWk2YASw01DxM6l7Lho2rr7jY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: [PATCH 5.4 000/119] 5.4.261-rc1 review
Date:   Wed, 15 Nov 2023 16:59:50 -0500
Message-ID: <20231115220132.607437515@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.261-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.4.261-rc1
X-KernelTest-Deadline: 2023-11-17T22:01+00:00
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

This is the start of the stable review cycle for the 5.4.261 release.
There are 119 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Fri, 17 Nov 2023 22:01:17 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.261-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 5.4.261-rc1

Filipe Manana <fdmanana@suse.com>
    btrfs: use u64 for buffer sizes in the tree search ioctls

Dominique Martinet <dominique.martinet@atmark-techno.com>
    Revert "mmc: core: Capture correct oemid-bits for eMMC cards"

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

Katya Orlova <e.orlova@ispras.ru>
    media: s3c-camif: Avoid inappropriate kfree()

Zheng Wang <zyytlz.wz@163.com>
    media: bttv: fix use after free error due to btv->timeout timer

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

Wang Yufen <wangyufen@huawei.com>
    powerpc/pseries: fix potential memory leak in init_cpu_associativity()

Sebastian Andrzej Siewior <bigeasy@linutronix.de>
    powerpc/imc-pmu: Use the correct spinlock initializer.

Benjamin Gray <bgray@linux.ibm.com>
    powerpc/xive: Fix endian conversion size

Masahiro Yamada <masahiroy@kernel.org>
    modpost: fix tee MODULE_DEVICE_TABLE built on big-endian host

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

Yi Yang <yiyang13@huawei.com>
    tty: tty_jobctrl: fix pid memleak in disassociate_ctty()

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    leds: trigger: ledtrig-cpu:: Fix 'output may be truncated' issue for 'cpu'

Pavel Machek <pavel@ucw.cz>
    ledtrig-cpu: Limit to 8 CPUs

Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    leds: pwm: Don't disable the PWM when the LED should be off

Uwe Kleine-König <uwe@kleine-koenig.org>
    leds: pwm: convert to atomic PWM API

Uwe Kleine-König <uwe@kleine-koenig.org>
    leds: pwm: simplify if condition

Dinghao Liu <dinghao.liu@zju.edu.cn>
    mfd: dln2: Fix double put in dln2_probe

Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
    ASoC: ams-delta.c: use component after check

Cezary Rojewski <cezary.rojewski@intel.com>
    ASoC: Intel: Skylake: Fix mem leak when parsing UUIDs fails

Geert Uytterhoeven <geert+renesas@glider.be>
    sh: bios: Revive earlyprintk support

Leon Romanovsky <leonro@nvidia.com>
    RDMA/hfi1: Workaround truncation compilation error

Daniel Mentz <danielmentz@google.com>
    scsi: ufs: core: Leave space for '\0' in utf8 desc string

Gou Hao <gouhao@uniontech.com>
    ext4: move 'ix' sanity check to corrent position

Kursad Oney <kursad.oney@broadcom.com>
    ARM: 9321/1: memset: cast the constant byte to unsigned char

Danny Kaehn <danny.kaehn@plexus.com>
    hid: cp2112: Fix duplicate workqueue initialization

Linus Walleij <linus.walleij@linaro.org>
    HID: cp2112: Use irqchip template

Gaurav Jain <gaurav.jain@nxp.com>
    crypto: caam/jr - fix Chacha20 + Poly1305 self test failure

Gaurav Jain <gaurav.jain@nxp.com>
    crypto: caam/qi2 - fix Chacha20 + Poly1305 self test failure

Tomas Glozar <tglozar@redhat.com>
    nd_btt: Make BTT lanes preemptible

Thomas Gleixner <tglx@linutronix.de>
    sched/rt: Provide migrate_disable/enable() inlines

Chen Ni <nichen@iscas.ac.cn>
    libnvdimm/of_pmem: Use devm_kstrdup instead of kstrdup and check its return value

Jonas Gorski <jonas.gorski@gmail.com>
    hwrng: geode - fix accessing registers

Sudeep Holla <sudeep.holla@arm.com>
    clk: scmi: Free scmi_clk allocated when the clocks with invalid info are skipped

Dhruva Gole <d-gole@ti.com>
    firmware: ti_sci: Mark driver as non removable

Alexander A. Klimov <grandmaster@al2klimov.de>
    firmware: ti_sci: Replace HTTP links with HTTPS ones

Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    soc: qcom: llcc: Handle a second device without data corruption

Vivek Gautam <vivek.gautam@codeaurora.org>
    soc: qcom: Rename llcc-slice to llcc-qcom

Vivek Gautam <vivek.gautam@codeaurora.org>
    soc: qcom: llcc cleanup to get rid of sdm845 specific driver file

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    ARM: dts: qcom: mdm9615: populate vsdcc fixed regulator

Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
    arm64: dts: qcom: sdm845-mtp: fix WiFi configuration

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    drm/rockchip: cdn-dp: Fix some error handling paths in cdn_dp_probe()

Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
    drm/radeon: possible buffer overflow

Jonas Karlman <jonas@kwiboo.se>
    drm/rockchip: vop: Fix call to crtc reset helper

Jonas Karlman <jonas@kwiboo.se>
    drm/rockchip: vop: Fix reset of state in duplicate state crtc funcs

Zhang Rui <rui.zhang@intel.com>
    hwmon: (coretemp) Fix potentially truncated sysfs attribute name

Armin Wolf <W_Armin@gmx.de>
    platform/x86: wmi: Fix opening of char device

Barnabás Pőcze <pobrn@protonmail.com>
    platform/x86: wmi: remove unnecessary initializations

Armin Wolf <W_Armin@gmx.de>
    platform/x86: wmi: Fix probe failure when failing to register WMI devices

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

Jonathan Neuschäfer <j.neuschaefer@gmx.net>
    clk: npcm7xx: Fix incorrect kfree

Dan Carpenter <dan.carpenter@linaro.org>
    clk: keystone: pll: fix a couple NULL vs IS_ERR() checks

Abel Vesa <abel.vesa@linaro.org>
    clk: imx: Select MXC_CLK for CLK_IMX8QXP

Danila Tikhonov <danila@jiaxyga.com>
    clk: qcom: gcc-sm8150: Fix gcc_sdcc2_apps_clk_src

Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
    clk: qcom: gcc-sm8150: use ARRAY_SIZE instead of specifying num_parents

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
    tcp: Remove one extra ktime_get_ns() from cookie_init_timestamp

Eric Dumazet <edumazet@google.com>
    chtls: fix tp->rcv_tstamp initialization

Heiner Kallweit <hkallweit1@gmail.com>
    r8169: fix rare issue with broken rx after link-down on RTL8125

Juhee Kang <claudiajkang@gmail.com>
    r8169: use tp_to_dev instead of open code

Dan Carpenter <dan.carpenter@linaro.org>
    thermal: core: prevent potential string overflow

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

Aananth V <aananthv@google.com>
    tcp: call tcp_try_undo_recovery when an RTOd TFO SYNACK is ACKed

Andrii Staikov <andrii.staikov@intel.com>
    i40e: fix potential memory leaks in i40e_remove()

Chen Yu <yu.c.chen@intel.com>
    genirq/matrix: Exclude managed interrupts in irq_matrix_allocated()

Reuben Hawkins <reubenhwk@gmail.com>
    vfs: fix readahead(2) on block devices


-------------

Diffstat:

 .../bindings/interrupt-controller/ti,sci-intr.txt  |   2 +-
 Makefile                                           |   4 +-
 arch/arm/boot/dts/qcom-mdm9615.dtsi                |  14 ++-
 arch/arm/lib/memset.S                              |   1 +
 arch/arm64/boot/dts/qcom/sdm845-mtp.dts            |   2 +
 arch/powerpc/perf/imc-pmu.c                        |   2 +-
 arch/powerpc/platforms/pseries/lpar.c              |   4 +-
 arch/powerpc/sysdev/xive/native.c                  |   2 +-
 arch/sh/Kconfig.debug                              |  11 +++
 drivers/acpi/device_sysfs.c                        |  10 ++-
 drivers/base/regmap/regmap-debugfs.c               |   2 +-
 drivers/base/regmap/regmap.c                       |  16 ++--
 drivers/char/hw_random/geode-rng.c                 |   6 +-
 drivers/clk/clk-npcm7xx.c                          |   2 +-
 drivers/clk/clk-scmi.c                             |   1 +
 drivers/clk/imx/Kconfig                            |   1 +
 drivers/clk/keystone/pll.c                         |  15 ++--
 drivers/clk/mediatek/clk-mt2701.c                  |   8 ++
 drivers/clk/mediatek/clk-mt6779.c                  |   4 +
 drivers/clk/mediatek/clk-mt6797.c                  |   6 ++
 drivers/clk/mediatek/clk-mt7629-eth.c              |   4 +
 drivers/clk/mediatek/clk-mt7629.c                  |   6 ++
 drivers/clk/qcom/clk-rcg2.c                        |  14 +--
 drivers/clk/qcom/gcc-sm8150.c                      |  98 ++++++++++----------
 drivers/crypto/caam/caamalg.c                      |   3 +-
 drivers/crypto/caam/caamalg_qi2.c                  |   3 +-
 drivers/crypto/chelsio/chtls/chtls_cm.c            |   2 +-
 drivers/dma/pxa_dma.c                              |   1 -
 drivers/dma/ti/edma.c                              |   4 +-
 drivers/firmware/ti_sci.c                          |  48 +---------
 drivers/firmware/ti_sci.h                          |   2 +-
 drivers/gpu/drm/drm_syncobj.c                      |   3 +-
 drivers/gpu/drm/radeon/evergreen.c                 |   7 +-
 drivers/gpu/drm/rockchip/cdn-dp-core.c             |  15 +++-
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c        |   8 +-
 drivers/hid/hid-cp2112.c                           |  23 ++---
 drivers/hwmon/coretemp.c                           |   2 +-
 drivers/i3c/master.c                               |   4 +-
 drivers/infiniband/hw/hfi1/efivar.c                |   2 +-
 drivers/input/rmi4/rmi_bus.c                       |   2 +-
 drivers/irqchip/irq-ti-sci-inta.c                  |   2 +-
 drivers/irqchip/irq-ti-sci-intr.c                  |   2 +-
 drivers/leds/leds-pwm.c                            |  41 ++-------
 drivers/leds/trigger/ledtrig-cpu.c                 |  17 ++--
 drivers/media/pci/bt8xx/bttv-driver.c              |   1 +
 drivers/media/platform/s3c-camif/camif-capture.c   |   6 +-
 drivers/media/usb/dvb-usb-v2/af9035.c              |  13 ++-
 drivers/mfd/dln2.c                                 |   1 -
 drivers/misc/ti-st/st_core.c                       |   7 +-
 drivers/mmc/core/mmc.c                             |   2 +-
 drivers/net/can/dev/dev.c                          |  10 ++-
 drivers/net/ethernet/broadcom/tg3.c                |   3 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c        |  10 ++-
 drivers/net/ethernet/realtek/r8169_main.c          |  15 +++-
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h     |   2 +-
 .../net/ethernet/stmicro/stmmac/dwxgmac2_core.c    |  14 ++-
 drivers/net/ipvlan/ipvlan_core.c                   |   8 +-
 drivers/net/ipvlan/ipvlan_main.c                   |   1 +
 drivers/net/macsec.c                               |   6 +-
 drivers/net/wireless/mediatek/mt76/mt7603/core.c   |   2 +
 drivers/net/wireless/mediatek/mt76/mt7603/mac.c    |  23 +++--
 .../net/wireless/realtek/rtlwifi/rtl8188ee/dm.c    |   2 +-
 .../wireless/realtek/rtlwifi/rtl8192c/dm_common.c  |   2 +-
 .../net/wireless/realtek/rtlwifi/rtl8723ae/dm.c    |   2 +-
 drivers/net/wireless/realtek/rtw88/debug.c         |   4 +-
 drivers/nvdimm/of_pmem.c                           |   8 +-
 drivers/nvdimm/region_devs.c                       |   8 +-
 drivers/pcmcia/cs.c                                |   1 +
 drivers/pcmcia/ds.c                                |  14 +--
 drivers/platform/x86/wmi.c                         |  50 +++++------
 drivers/pwm/pwm-brcmstb.c                          |   4 +-
 drivers/pwm/pwm-sti.c                              |  75 ++++++++--------
 drivers/reset/reset-ti-sci.c                       |   2 +-
 drivers/rtc/rtc-pcf85363.c                         |   2 +-
 drivers/scsi/ufs/ufshcd.c                          |   2 +-
 drivers/soc/qcom/Kconfig                           |  14 +--
 drivers/soc/qcom/Makefile                          |   3 +-
 drivers/soc/qcom/{llcc-slice.c => llcc-qcom.c}     |  63 +++++++++++--
 drivers/soc/qcom/llcc-sdm845.c                     | 100 ---------------------
 drivers/spi/Kconfig                                |   1 +
 drivers/thermal/thermal_core.c                     |   6 +-
 drivers/tty/tty_jobctrl.c                          |  17 ++--
 drivers/usb/dwc2/hcd.c                             |   2 +-
 drivers/usb/usbip/stub_dev.c                       |   9 +-
 drivers/video/fbdev/fsl-diu-fb.c                   |   2 +-
 drivers/video/fbdev/imsttfb.c                      |  33 ++++---
 fs/btrfs/ioctl.c                                   |  10 +--
 fs/ext4/extents.c                                  |  10 +--
 fs/f2fs/file.c                                     |   1 +
 include/linux/idr.h                                |   6 +-
 include/linux/netdevice.h                          |   1 +
 include/linux/preempt.h                            |  30 +++++++
 include/linux/soc/qcom/llcc-qcom.h                 |  57 +++++-------
 include/linux/soc/ti/ti_sci_inta_msi.h             |   2 +-
 include/linux/soc/ti/ti_sci_protocol.h             |   2 +-
 include/net/flow.h                                 |   2 +-
 include/net/netfilter/nf_nat_redirect.h            |   3 +-
 include/net/tcp.h                                  |  12 ++-
 kernel/irq/matrix.c                                |   6 +-
 mm/readahead.c                                     |   3 +-
 net/dccp/ipv4.c                                    |   6 +-
 net/dccp/ipv6.c                                    |   6 +-
 net/ipv4/syncookies.c                              |  22 ++---
 net/ipv4/tcp_input.c                               |   9 +-
 net/ipv4/tcp_metrics.c                             |  15 ++--
 net/ipv4/tcp_output.c                              |   2 +-
 net/ipv6/ip6_output.c                              |   8 +-
 net/ipv6/syncookies.c                              |   7 +-
 net/llc/llc_input.c                                |  10 ++-
 net/llc/llc_s_ac.c                                 |   3 +
 net/llc/llc_station.c                              |   3 +
 net/netfilter/nf_nat_redirect.c                    |  98 +++++++++++---------
 net/netfilter/nft_redir.c                          |  84 +++++++----------
 net/netfilter/xt_REDIRECT.c                        |  10 ++-
 net/netfilter/xt_recent.c                          |   2 +-
 net/smc/af_smc.c                                   |   4 +-
 net/smc/smc.h                                      |   5 ++
 net/smc/smc_cdc.c                                  |   2 +-
 net/smc/smc_close.c                                |   2 +-
 net/tipc/netlink.c                                 |   4 +-
 scripts/mod/file2alias.c                           |  10 +--
 sound/soc/intel/skylake/skl-sst-utils.c            |   1 +
 sound/soc/ti/ams-delta.c                           |   4 +-
 tools/iio/iio_generic_buffer.c                     |  59 +++++++-----
 124 files changed, 786 insertions(+), 711 deletions(-)


