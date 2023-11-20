Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6FC17F0FC2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 11:04:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232920AbjKTKEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 05:04:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232877AbjKTKEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 05:04:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CDA5ED;
        Mon, 20 Nov 2023 02:04:25 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 476A9C433C9;
        Mon, 20 Nov 2023 10:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700474664;
        bh=3zHdGQt4Pf0svmC1ZTNtBXlcOUShXoOc/24efSIFSc4=;
        h=From:To:Cc:Subject:Date:From;
        b=Kw9ribhMa+ROUcw3/NvaVu0jnvYvFGqNK0tarR4QKRobIrSMfYmfENf8IXL2ahh79
         eQKyjwvvpWnxGlNLZskVtjiAAms5rP0mMIPKdiYTDYLaKRsfN5i/EYKSDNjjm5oi+E
         mvVGb9dyREt4V/p05Q6tc3X+QPLRZvNrx4sWnOdo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.4.261
Date:   Mon, 20 Nov 2023 11:04:16 +0100
Message-ID: <2023112017-umbrella-defective-234c@gregkh>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
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

I'm announcing the release of the 5.4.261 kernel.

All users of the 5.4 kernel series must upgrade.

The updated 5.4.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.4.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt |    2 
 Makefile                                                               |    2 
 arch/arm/boot/dts/qcom-mdm9615.dtsi                                    |   14 
 arch/arm/lib/memset.S                                                  |    1 
 arch/arm64/boot/dts/qcom/sdm845-mtp.dts                                |    2 
 arch/powerpc/perf/imc-pmu.c                                            |    2 
 arch/powerpc/platforms/pseries/lpar.c                                  |    4 
 arch/powerpc/sysdev/xive/native.c                                      |    2 
 arch/sh/Kconfig.debug                                                  |   11 
 drivers/acpi/device_sysfs.c                                            |   10 
 drivers/base/regmap/regmap-debugfs.c                                   |    2 
 drivers/base/regmap/regmap.c                                           |   16 
 drivers/char/hw_random/geode-rng.c                                     |    6 
 drivers/clk/clk-npcm7xx.c                                              |    2 
 drivers/clk/clk-scmi.c                                                 |    1 
 drivers/clk/imx/Kconfig                                                |    1 
 drivers/clk/keystone/pll.c                                             |   15 
 drivers/clk/mediatek/clk-mt2701.c                                      |    8 
 drivers/clk/mediatek/clk-mt6779.c                                      |    4 
 drivers/clk/mediatek/clk-mt6797.c                                      |    6 
 drivers/clk/mediatek/clk-mt7629-eth.c                                  |    4 
 drivers/clk/mediatek/clk-mt7629.c                                      |    6 
 drivers/clk/qcom/clk-rcg2.c                                            |   14 
 drivers/clk/qcom/gcc-sm8150.c                                          |   98 +-
 drivers/crypto/caam/caamalg.c                                          |    3 
 drivers/crypto/caam/caamalg_qi2.c                                      |    3 
 drivers/crypto/chelsio/chtls/chtls_cm.c                                |    2 
 drivers/dma/pxa_dma.c                                                  |    1 
 drivers/dma/ti/edma.c                                                  |    4 
 drivers/firmware/ti_sci.c                                              |   48 -
 drivers/firmware/ti_sci.h                                              |    2 
 drivers/gpu/drm/drm_syncobj.c                                          |    3 
 drivers/gpu/drm/radeon/evergreen.c                                     |    7 
 drivers/gpu/drm/rockchip/cdn-dp-core.c                                 |   15 
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c                            |    8 
 drivers/hid/hid-cp2112.c                                               |   23 
 drivers/hwmon/coretemp.c                                               |    2 
 drivers/i3c/master.c                                                   |    4 
 drivers/infiniband/hw/hfi1/efivar.c                                    |    2 
 drivers/input/rmi4/rmi_bus.c                                           |    2 
 drivers/irqchip/irq-ti-sci-inta.c                                      |    2 
 drivers/irqchip/irq-ti-sci-intr.c                                      |    2 
 drivers/leds/leds-pwm.c                                                |   41 
 drivers/leds/trigger/ledtrig-cpu.c                                     |   17 
 drivers/media/pci/bt8xx/bttv-driver.c                                  |    1 
 drivers/media/platform/s3c-camif/camif-capture.c                       |    6 
 drivers/media/usb/dvb-usb-v2/af9035.c                                  |   13 
 drivers/mfd/dln2.c                                                     |    1 
 drivers/misc/ti-st/st_core.c                                           |    7 
 drivers/mmc/core/mmc.c                                                 |    2 
 drivers/net/can/dev/dev.c                                              |   10 
 drivers/net/ethernet/broadcom/tg3.c                                    |    3 
 drivers/net/ethernet/intel/i40e/i40e_main.c                            |   10 
 drivers/net/ethernet/realtek/r8169_main.c                              |   15 
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h                         |    2 
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c                    |   14 
 drivers/net/ipvlan/ipvlan_core.c                                       |    8 
 drivers/net/ipvlan/ipvlan_main.c                                       |    1 
 drivers/net/macsec.c                                                   |    6 
 drivers/net/wireless/mediatek/mt76/mt7603/core.c                       |    2 
 drivers/net/wireless/mediatek/mt76/mt7603/mac.c                        |   23 
 drivers/net/wireless/realtek/rtlwifi/rtl8188ee/dm.c                    |    2 
 drivers/net/wireless/realtek/rtlwifi/rtl8192c/dm_common.c              |    2 
 drivers/net/wireless/realtek/rtlwifi/rtl8723ae/dm.c                    |    2 
 drivers/net/wireless/realtek/rtw88/debug.c                             |    4 
 drivers/nvdimm/of_pmem.c                                               |    8 
 drivers/nvdimm/region_devs.c                                           |    8 
 drivers/pcmcia/cs.c                                                    |    1 
 drivers/pcmcia/ds.c                                                    |   14 
 drivers/platform/x86/wmi.c                                             |   50 -
 drivers/pwm/pwm-brcmstb.c                                              |    4 
 drivers/pwm/pwm-sti.c                                                  |   75 -
 drivers/reset/reset-ti-sci.c                                           |    2 
 drivers/rtc/rtc-pcf85363.c                                             |    2 
 drivers/scsi/ufs/ufshcd.c                                              |    2 
 drivers/soc/qcom/Kconfig                                               |   14 
 drivers/soc/qcom/Makefile                                              |    3 
 drivers/soc/qcom/llcc-qcom.c                                           |  462 ++++++++++
 drivers/soc/qcom/llcc-sdm845.c                                         |  100 --
 drivers/soc/qcom/llcc-slice.c                                          |  413 --------
 drivers/spi/Kconfig                                                    |    1 
 drivers/thermal/thermal_core.c                                         |    6 
 drivers/tty/tty_jobctrl.c                                              |   17 
 drivers/usb/dwc2/hcd.c                                                 |    2 
 drivers/usb/usbip/stub_dev.c                                           |    9 
 drivers/video/fbdev/fsl-diu-fb.c                                       |    2 
 drivers/video/fbdev/imsttfb.c                                          |   33 
 fs/btrfs/ioctl.c                                                       |   10 
 fs/ext4/extents.c                                                      |   10 
 fs/f2fs/file.c                                                         |    1 
 include/linux/idr.h                                                    |    6 
 include/linux/netdevice.h                                              |    1 
 include/linux/preempt.h                                                |   30 
 include/linux/soc/qcom/llcc-qcom.h                                     |   57 -
 include/linux/soc/ti/ti_sci_inta_msi.h                                 |    2 
 include/linux/soc/ti/ti_sci_protocol.h                                 |    2 
 include/net/flow.h                                                     |    2 
 include/net/netfilter/nf_nat_redirect.h                                |    3 
 include/net/tcp.h                                                      |   12 
 kernel/irq/matrix.c                                                    |    6 
 mm/readahead.c                                                         |    3 
 net/dccp/ipv4.c                                                        |    6 
 net/dccp/ipv6.c                                                        |    6 
 net/ipv4/syncookies.c                                                  |   22 
 net/ipv4/tcp_input.c                                                   |    9 
 net/ipv4/tcp_metrics.c                                                 |   15 
 net/ipv4/tcp_output.c                                                  |    2 
 net/ipv6/ip6_output.c                                                  |    8 
 net/ipv6/syncookies.c                                                  |    7 
 net/llc/llc_input.c                                                    |   10 
 net/llc/llc_s_ac.c                                                     |    3 
 net/llc/llc_station.c                                                  |    3 
 net/netfilter/nf_nat_redirect.c                                        |   98 +-
 net/netfilter/nft_redir.c                                              |   84 -
 net/netfilter/xt_REDIRECT.c                                            |   10 
 net/netfilter/xt_recent.c                                              |    2 
 net/smc/af_smc.c                                                       |    4 
 net/smc/smc.h                                                          |    5 
 net/smc/smc_cdc.c                                                      |    2 
 net/smc/smc_close.c                                                    |    2 
 net/tipc/netlink.c                                                     |    4 
 scripts/mod/file2alias.c                                               |   10 
 sound/soc/intel/skylake/skl-sst-utils.c                                |    1 
 sound/soc/ti/ams-delta.c                                               |    4 
 tools/iio/iio_generic_buffer.c                                         |   59 -
 125 files changed, 1191 insertions(+), 1116 deletions(-)

Aananth V (1):
      tcp: call tcp_try_undo_recovery when an RTOd TFO SYNACK is ACKed

Abel Vesa (1):
      clk: imx: Select MXC_CLK for CLK_IMX8QXP

Alexander A. Klimov (1):
      firmware: ti_sci: Replace HTTP links with HTTPS ones

Alexandru Ardelean (1):
      tools: iio: privatize globals and functions in iio_generic_buffer.c file

Amit Kumar Mahapatra (1):
      spi: spi-zynq-qspi: add spi-mem to driver kconfig dependencies

Andrii Staikov (1):
      i40e: fix potential memory leaks in i40e_remove()

Armin Wolf (2):
      platform/x86: wmi: Fix probe failure when failing to register WMI devices
      platform/x86: wmi: Fix opening of char device

Arnd Bergmann (1):
      fbdev: fsl-diu-fb: mark wr_reg_wa() static

Barnabás Pőcze (1):
      platform/x86: wmi: remove unnecessary initializations

Ben Wolsieffer (1):
      regmap: prevent noinc writes from clobbering cache

Benjamin Gray (1):
      powerpc/xive: Fix endian conversion size

Cezary Rojewski (1):
      ASoC: Intel: Skylake: Fix mem leak when parsing UUIDs fails

Chao Yu (1):
      f2fs: fix to initialize map.m_pblk in f2fs_precache_extents()

Chen Ni (1):
      libnvdimm/of_pmem: Use devm_kstrdup instead of kstrdup and check its return value

Chen Yu (1):
      genirq/matrix: Exclude managed interrupts in irq_matrix_allocated()

Chenyuan Mi (1):
      tools: iio: iio_generic_buffer: Fix some integer type and calculation

Christophe JAILLET (5):
      ACPI: sysfs: Fix create_pnp_modalias() and create_of_modalias()
      regmap: debugfs: Fix a erroneous check after snprintf()
      drm/rockchip: cdn-dp: Fix some error handling paths in cdn_dp_probe()
      leds: trigger: ledtrig-cpu:: Fix 'output may be truncated' issue for 'cpu'
      dmaengine: pxa_dma: Remove an erroneous BUG_ON() in pxad_free_desc()

D. Wythe (1):
      net/smc: fix dangling sock under state SMC_APPFINCLOSEWAIT

Dan Carpenter (5):
      thermal: core: prevent potential string overflow
      clk: keystone: pll: fix a couple NULL vs IS_ERR() checks
      dmaengine: ti: edma: handle irq_of_parse_and_map() errors
      Input: synaptics-rmi4 - fix use after free in rmi_unregister_function()
      fbdev: imsttfb: fix a resource leak in probe

Daniel Mentz (1):
      scsi: ufs: core: Leave space for '\0' in utf8 desc string

Danila Tikhonov (1):
      clk: qcom: gcc-sm8150: Fix gcc_sdcc2_apps_clk_src

Danny Kaehn (1):
      hid: cp2112: Fix duplicate workqueue initialization

Devi Priya (1):
      clk: qcom: clk-rcg2: Fix clock rate overflow for high parent frequencies

Dhruva Gole (1):
      firmware: ti_sci: Mark driver as non removable

Dinghao Liu (2):
      mfd: dln2: Fix double put in dln2_probe
      i3c: Fix potential refcount leak in i3c_master_register_new_i3c_devs

Dmitry Antipov (1):
      wifi: rtlwifi: fix EDCA limit set by BT coexistence

Dmitry Baryshkov (2):
      clk: qcom: gcc-sm8150: use ARRAY_SIZE instead of specifying num_parents
      arm64: dts: qcom: sdm845-mtp: fix WiFi configuration

Dominique Martinet (1):
      Revert "mmc: core: Capture correct oemid-bits for eMMC cards"

Eric Dumazet (9):
      tcp_metrics: add missing barriers on delete
      tcp_metrics: properly set tp->snd_ssthresh in tcp_init_metrics()
      tcp_metrics: do not create an entry from tcp_init_metrics()
      chtls: fix tp->rcv_tstamp initialization
      tcp: Remove one extra ktime_get_ns() from cookie_init_timestamp
      tcp: fix cookie_init_timestamp() overflows
      net: add DEV_STATS_READ() helper
      ipvlan: properly track tx_errors
      inet: shrink struct flowi_common

Erik Kurzinger (1):
      drm/syncobj: fix DRM_SYNCOBJ_WAIT_FLAGS_WAIT_AVAILABLE

Felix Fietkau (1):
      wifi: mt76: mt7603: rework/fix rx pse hang check

Filipe Manana (1):
      btrfs: use u64 for buffer sizes in the tree search ioctls

Florian Fainelli (1):
      pwm: brcmstb: Utilize appropriate clock APIs in suspend/resume

Florian Westphal (1):
      netfilter: nat: fix ipv6 nat redirect with mapped and scoped addresses

Furong Xu (1):
      net: stmmac: xgmac: Enable support for multiple Flexible PPS outputs

Gaurav Jain (2):
      crypto: caam/qi2 - fix Chacha20 + Poly1305 self test failure
      crypto: caam/jr - fix Chacha20 + Poly1305 self test failure

Geert Uytterhoeven (1):
      sh: bios: Revive earlyprintk support

George Shuklin (1):
      tg3: power down device only on SYSTEM_POWER_OFF

Gou Hao (1):
      ext4: move 'ix' sanity check to corrent position

Greg Kroah-Hartman (1):
      Linux 5.4.261

Hans Verkuil (1):
      media: dvb-usb-v2: af9035: fix missing unlock

Heiner Kallweit (2):
      r8169: fix rare issue with broken rx after link-down on RTL8125
      r8169: respect userspace disabling IFF_MULTICAST

Helge Deller (1):
      fbdev: imsttfb: Fix error path of imsttfb_probe()

Javier Carrasco (1):
      rtc: pcf85363: fix wrong mask/val parameters in regmap_update_bits call

Jeremy Sowden (1):
      netfilter: nft_redir: use `struct nf_nat_range2` throughout and deduplicate eval call-backs

Jia-Ju Bai (1):
      usb: dwc2: fix possible NULL pointer dereference caused by driver concurrency

Jiasheng Jiang (5):
      clk: mediatek: clk-mt6779: Add check for mtk_alloc_clk_data
      clk: mediatek: clk-mt6797: Add check for mtk_alloc_clk_data
      clk: mediatek: clk-mt7629-eth: Add check for mtk_alloc_clk_data
      clk: mediatek: clk-mt7629: Add check for mtk_alloc_clk_data
      clk: mediatek: clk-mt2701: Add check for mtk_alloc_clk_data

Jinjie Ruan (2):
      wifi: rtw88: debug: Fix the NULL vs IS_ERR() bug for debugfs_create_file()
      misc: st_core: Do not call kfree_skb() under spin_lock_irqsave()

Jonas Blixt (1):
      USB: usbip: fix stub_dev hub disconnect

Jonas Gorski (1):
      hwrng: geode - fix accessing registers

Jonas Karlman (2):
      drm/rockchip: vop: Fix reset of state in duplicate state crtc funcs
      drm/rockchip: vop: Fix call to crtc reset helper

Jonathan Neuschäfer (1):
      clk: npcm7xx: Fix incorrect kfree

Juhee Kang (1):
      r8169: use tp_to_dev instead of open code

Katya Orlova (1):
      media: s3c-camif: Avoid inappropriate kfree()

Konstantin Meskhidze (1):
      drm/radeon: possible buffer overflow

Krzysztof Kozlowski (1):
      ARM: dts: qcom: mdm9615: populate vsdcc fixed regulator

Kuninori Morimoto (1):
      ASoC: ams-delta.c: use component after check

Kuniyuki Iwashima (2):
      dccp: Call security_inet_conn_request() after setting IPv4 addresses.
      dccp/tcp: Call security_inet_conn_request() after setting IPv6 addresses.

Kursad Oney (1):
      ARM: 9321/1: memset: cast the constant byte to unsigned char

Leon Romanovsky (1):
      RDMA/hfi1: Workaround truncation compilation error

Linus Walleij (1):
      HID: cp2112: Use irqchip template

Maciej Żenczykowski (1):
      netfilter: xt_recent: fix (increase) ipv6 literal buffer length

Marc Kleine-Budde (2):
      can: dev: can_restart(): don't crash kernel if carrier is OK
      can: dev: can_restart(): fix race condition between controller restart and netif_carrier_on()

Masahiro Yamada (1):
      modpost: fix tee MODULE_DEVICE_TABLE built on big-endian host

Matti Vaittinen (1):
      tools: iio: iio_generic_buffer ensure alignment

NeilBrown (1):
      Fix termination state for idr_for_each_entry_ul()

Patrick Thompson (1):
      net: r8169: Disable multicast filter for RTL8168H and RTL8107E

Pavel Machek (1):
      ledtrig-cpu: Limit to 8 CPUs

Reuben Hawkins (1):
      vfs: fix readahead(2) on block devices

Sebastian Andrzej Siewior (1):
      powerpc/imc-pmu: Use the correct spinlock initializer.

Shigeru Yoshida (1):
      tipc: Change nla_policy for bearer-related names to NLA_NUL_STRING

Sudeep Holla (1):
      clk: scmi: Free scmi_clk allocated when the clocks with invalid info are skipped

Thierry Reding (1):
      pwm: sti: Avoid conditional gotos

Thomas Gleixner (1):
      sched/rt: Provide migrate_disable/enable() inlines

Tomas Glozar (1):
      nd_btt: Make BTT lanes preemptible

Uwe Kleine-König (5):
      soc: qcom: llcc: Handle a second device without data corruption
      leds: pwm: simplify if condition
      leds: pwm: convert to atomic PWM API
      leds: pwm: Don't disable the PWM when the LED should be off
      pwm: sti: Reduce number of allocations and drop usage of chip_data

Vivek Gautam (2):
      soc: qcom: llcc cleanup to get rid of sdm845 specific driver file
      soc: qcom: Rename llcc-slice to llcc-qcom

Wang Yufen (1):
      powerpc/pseries: fix potential memory leak in init_cpu_associativity()

Willem de Bruijn (1):
      llc: verify mac len before reading mac header

Yan Zhai (1):
      ipv6: avoid atomic fragment on GSO packets

Yang Yingliang (3):
      pcmcia: cs: fix possible hung task and memory leak pccardd()
      pcmcia: ds: fix refcount leak in pcmcia_device_add()
      pcmcia: ds: fix possible name leak in error path in pcmcia_device_add()

Yi Yang (1):
      tty: tty_jobctrl: fix pid memleak in disassociate_ctty()

Zhang Rui (1):
      hwmon: (coretemp) Fix potentially truncated sysfs attribute name

Zheng Wang (1):
      media: bttv: fix use after free error due to btv->timeout timer

