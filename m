Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4D3F7F0FBD
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 11:04:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232853AbjKTKE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 05:04:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232809AbjKTKEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 05:04:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D05CFED;
        Mon, 20 Nov 2023 02:04:16 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 202BBC433C8;
        Mon, 20 Nov 2023 10:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700474656;
        bh=8efgpM/8TUmmMz7wyA0Y4fcrIg6uHqcSVmjzFwn0PxM=;
        h=From:To:Cc:Subject:Date:From;
        b=XPZXu8+QyWaKZGAKPbYIET340/JTi0u8cfAnaFZLfxyriIhpAj8bJT1kec0kCAHJ5
         BNhw9Ub/wGDsfQ5L6BswQKpeNmj3tMEZupTij9FvocHfblqJsfdmgMdt0aQodN56HP
         zpdc4APf/zSM05rFQ3B5GqEjt+01c/M/t80OMQes=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 4.19.299
Date:   Mon, 20 Nov 2023 11:04:08 +0100
Message-ID: <2023112009-overbite-slimy-421d@gregkh>
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

I'm announcing the release of the 4.19.299 kernel.

All users of the 4.19 kernel series must upgrade.

The updated 4.19.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-4.19.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                  |    2 
 arch/arm/boot/dts/qcom-mdm9615.dtsi                       |   14 
 arch/arm/lib/memset.S                                     |    1 
 arch/sh/Kconfig.debug                                     |   11 
 drivers/acpi/device_sysfs.c                               |   10 
 drivers/base/regmap/regmap-debugfs.c                      |    2 
 drivers/char/hw_random/geode-rng.c                        |    6 
 drivers/clk/clk-npcm7xx.c                                 |    2 
 drivers/clk/clk-scmi.c                                    |    1 
 drivers/clk/keystone/pll.c                                |   15 
 drivers/clk/mediatek/clk-mt2701.c                         |    8 
 drivers/clk/mediatek/clk-mt6797.c                         |    6 
 drivers/clk/qcom/clk-rcg2.c                               |   14 
 drivers/crypto/chelsio/chtls/chtls_cm.c                   |    2 
 drivers/dma/pxa_dma.c                                     |    1 
 drivers/dma/ti/edma.c                                     |    4 
 drivers/firmware/ti_sci.c                                 |   46 
 drivers/gpu/drm/radeon/evergreen.c                        |    7 
 drivers/gpu/drm/rockchip/cdn-dp-core.c                    |   15 
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c               |    3 
 drivers/hid/hid-cp2112.c                                  |   23 
 drivers/hwmon/coretemp.c                                  |    2 
 drivers/infiniband/hw/hfi1/efivar.c                       |    2 
 drivers/input/rmi4/rmi_bus.c                              |    2 
 drivers/leds/leds-pwm.c                                   |   41 
 drivers/leds/trigger/ledtrig-cpu.c                        |   17 
 drivers/media/pci/bt8xx/bttv-driver.c                     |    1 
 drivers/media/platform/s3c-camif/camif-capture.c          |    6 
 drivers/media/usb/dvb-usb-v2/af9035.c                     |   13 
 drivers/mfd/dln2.c                                        |    1 
 drivers/misc/ti-st/st_core.c                              |    7 
 drivers/mmc/core/mmc.c                                    |    2 
 drivers/net/can/Makefile                                  |    7 
 drivers/net/can/dev.c                                     | 1324 -------------
 drivers/net/can/dev/Makefile                              |    7 
 drivers/net/can/dev/dev.c                                 | 1326 ++++++++++++++
 drivers/net/can/dev/rx-offload.c                          |  404 ++++
 drivers/net/can/rx-offload.c                              |  404 ----
 drivers/net/ethernet/broadcom/tg3.c                       |    3 
 drivers/net/ethernet/intel/i40e/i40e_main.c               |   10 
 drivers/net/ethernet/realtek/r8169_main.c                 |   56 
 drivers/net/ipvlan/ipvlan_core.c                          |    8 
 drivers/net/ipvlan/ipvlan_main.c                          |    1 
 drivers/net/macsec.c                                      |   70 
 drivers/net/wireless/realtek/rtlwifi/rtl8188ee/dm.c       |    2 
 drivers/net/wireless/realtek/rtlwifi/rtl8192c/dm_common.c |    2 
 drivers/net/wireless/realtek/rtlwifi/rtl8723ae/dm.c       |    2 
 drivers/nvdimm/region_devs.c                              |    8 
 drivers/pcmcia/cs.c                                       |    1 
 drivers/pcmcia/ds.c                                       |   14 
 drivers/platform/x86/wmi.c                                |   50 
 drivers/pwm/pwm-brcmstb.c                                 |    4 
 drivers/pwm/pwm-sti.c                                     |   75 
 drivers/thermal/thermal_core.c                            |    6 
 drivers/tty/tty_jobctrl.c                                 |   17 
 drivers/usb/dwc2/hcd.c                                    |    2 
 drivers/usb/usbip/stub_dev.c                              |    9 
 drivers/video/fbdev/fsl-diu-fb.c                          |    2 
 drivers/video/fbdev/imsttfb.c                             |   33 
 fs/btrfs/ioctl.c                                          |   10 
 fs/ext4/extents.c                                         |   10 
 fs/f2fs/file.c                                            |    1 
 include/linux/netdevice.h                                 |    1 
 include/linux/preempt.h                                   |   30 
 kernel/irq/matrix.c                                       |    6 
 mm/readahead.c                                            |    3 
 net/dccp/ipv4.c                                           |    6 
 net/dccp/ipv6.c                                           |    6 
 net/ipv4/tcp_metrics.c                                    |   15 
 net/ipv6/ip6_output.c                                     |    8 
 net/ipv6/syncookies.c                                     |    7 
 net/llc/llc_input.c                                       |   10 
 net/llc/llc_s_ac.c                                        |    3 
 net/llc/llc_station.c                                     |    3 
 net/netfilter/xt_recent.c                                 |    2 
 net/smc/af_smc.c                                          |   43 
 net/smc/smc.h                                             |    5 
 net/smc/smc_cdc.c                                         |    2 
 net/smc/smc_close.c                                       |   26 
 net/smc/smc_close.h                                       |    1 
 net/tipc/netlink.c                                        |    4 
 sound/soc/intel/skylake/skl-sst-utils.c                   |    1 
 sound/soc/omap/ams-delta.c                                |    4 
 tools/iio/iio_generic_buffer.c                            |   59 
 84 files changed, 2271 insertions(+), 2129 deletions(-)

Alexandru Ardelean (1):
      tools: iio: privatize globals and functions in iio_generic_buffer.c file

Andrii Staikov (1):
      i40e: fix potential memory leaks in i40e_remove()

Armin Wolf (2):
      platform/x86: wmi: Fix probe failure when failing to register WMI devices
      platform/x86: wmi: Fix opening of char device

Arnd Bergmann (1):
      fbdev: fsl-diu-fb: mark wr_reg_wa() static

Barnabás Pőcze (1):
      platform/x86: wmi: remove unnecessary initializations

Cezary Rojewski (1):
      ASoC: Intel: Skylake: Fix mem leak when parsing UUIDs fails

Chao Yu (1):
      f2fs: fix to initialize map.m_pblk in f2fs_precache_extents()

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

Clayton Yager (1):
      macsec: Fix traffic counters/statistics

D. Wythe (1):
      net/smc: fix dangling sock under state SMC_APPFINCLOSEWAIT

Dan Carpenter (5):
      thermal: core: prevent potential string overflow
      clk: keystone: pll: fix a couple NULL vs IS_ERR() checks
      dmaengine: ti: edma: handle irq_of_parse_and_map() errors
      Input: synaptics-rmi4 - fix use after free in rmi_unregister_function()
      fbdev: imsttfb: fix a resource leak in probe

Danny Kaehn (1):
      hid: cp2112: Fix duplicate workqueue initialization

Devi Priya (1):
      clk: qcom: clk-rcg2: Fix clock rate overflow for high parent frequencies

Dhruva Gole (1):
      firmware: ti_sci: Mark driver as non removable

Dinghao Liu (1):
      mfd: dln2: Fix double put in dln2_probe

Dmitry Antipov (1):
      wifi: rtlwifi: fix EDCA limit set by BT coexistence

Dominique Martinet (1):
      Revert "mmc: core: Capture correct oemid-bits for eMMC cards"

Eric Dumazet (7):
      tcp_metrics: add missing barriers on delete
      tcp_metrics: properly set tp->snd_ssthresh in tcp_init_metrics()
      tcp_metrics: do not create an entry from tcp_init_metrics()
      chtls: fix tp->rcv_tstamp initialization
      macsec: use DEV_STATS_INC()
      net: add DEV_STATS_READ() helper
      ipvlan: properly track tx_errors

Filipe Manana (1):
      btrfs: use u64 for buffer sizes in the tree search ioctls

Florian Fainelli (1):
      pwm: brcmstb: Utilize appropriate clock APIs in suspend/resume

Geert Uytterhoeven (1):
      sh: bios: Revive earlyprintk support

George Shuklin (1):
      tg3: power down device only on SYSTEM_POWER_OFF

Gou Hao (1):
      ext4: move 'ix' sanity check to corrent position

Greg Kroah-Hartman (1):
      Linux 4.19.299

Hans Verkuil (1):
      media: dvb-usb-v2: af9035: fix missing unlock

Heiner Kallweit (2):
      r8169: improve rtl_set_rx_mode
      r8169: respect userspace disabling IFF_MULTICAST

Helge Deller (1):
      fbdev: imsttfb: Fix error path of imsttfb_probe()

Jia-Ju Bai (1):
      usb: dwc2: fix possible NULL pointer dereference caused by driver concurrency

Jiasheng Jiang (2):
      clk: mediatek: clk-mt6797: Add check for mtk_alloc_clk_data
      clk: mediatek: clk-mt2701: Add check for mtk_alloc_clk_data

Jinjie Ruan (1):
      misc: st_core: Do not call kfree_skb() under spin_lock_irqsave()

Jonas Blixt (1):
      USB: usbip: fix stub_dev hub disconnect

Jonas Gorski (1):
      hwrng: geode - fix accessing registers

Jonas Karlman (1):
      drm/rockchip: vop: Fix reset of state in duplicate state crtc funcs

Jonathan Neuschäfer (1):
      clk: npcm7xx: Fix incorrect kfree

Karsten Graul (1):
      net/smc: wait for pending work before clcsock release_sock

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

Marc Kleine-Budde (3):
      can: dev: move driver related infrastructure into separate subdir
      can: dev: can_restart(): don't crash kernel if carrier is OK
      can: dev: can_restart(): fix race condition between controller restart and netif_carrier_on()

Matti Vaittinen (1):
      tools: iio: iio_generic_buffer ensure alignment

Patrick Thompson (1):
      net: r8169: Disable multicast filter for RTL8168H and RTL8107E

Pavel Machek (1):
      ledtrig-cpu: Limit to 8 CPUs

Reuben Hawkins (1):
      vfs: fix readahead(2) on block devices

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

Ursula Braun (1):
      net/smc: postpone release of clcsock

Uwe Kleine-König (4):
      leds: pwm: simplify if condition
      leds: pwm: convert to atomic PWM API
      leds: pwm: Don't disable the PWM when the LED should be off
      pwm: sti: Reduce number of allocations and drop usage of chip_data

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

