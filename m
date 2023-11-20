Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7617F0FB5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 11:04:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232540AbjKTKEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 05:04:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232176AbjKTKEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 05:04:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E02195;
        Mon, 20 Nov 2023 02:04:08 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4C03C433C7;
        Mon, 20 Nov 2023 10:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700474648;
        bh=zUc2227xC6Yj5IuLNkrUnpjVgSB+VxRtCUyFCL/gBx4=;
        h=From:To:Cc:Subject:Date:From;
        b=n0iSPOijiNCcZ5+78ZdAMM6jk3/viMVGQNT3iscywNXf+uMG+/C/wEgCDQF2IHQWm
         g8YVzPsxUj7rJf45Hodyj1i2TunNToUR8qPWpcHL4Zms8dJmo9fpZjsD1ta2DFBnyp
         7lb2ufolhuXOmudHs503yWkrh6tffDdlPatLsePU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 4.14.330
Date:   Mon, 20 Nov 2023 11:04:03 +0100
Message-ID: <2023112004-stargazer-chuck-5b97@gregkh>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm announcing the release of the 4.14.330 kernel.

All users of the 4.14 kernel series must upgrade.

The updated 4.14.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-4.14.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                  |    2 
 arch/arm/boot/dts/qcom-mdm9615.dtsi                       |   14 +---
 arch/arm/lib/memset.S                                     |    1 
 arch/sh/Kconfig.debug                                     |   11 +++
 drivers/acpi/device_sysfs.c                               |   10 +--
 drivers/char/hw_random/geode-rng.c                        |    6 +
 drivers/clk/keystone/pll.c                                |   15 ++--
 drivers/clk/mediatek/clk-mt2701.c                         |    8 ++
 drivers/clk/mediatek/clk-mt6797.c                         |    6 +
 drivers/clk/qcom/clk-rcg2.c                               |   14 +---
 drivers/dma/edma.c                                        |    4 -
 drivers/dma/pxa_dma.c                                     |    1 
 drivers/firmware/ti_sci.c                                 |   46 --------------
 drivers/gpu/drm/radeon/evergreen.c                        |    7 +-
 drivers/gpu/drm/rockchip/cdn-dp-core.c                    |   15 +++-
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c               |    3 
 drivers/infiniband/hw/hfi1/efivar.c                       |    2 
 drivers/media/platform/s3c-camif/camif-capture.c          |    6 -
 drivers/media/usb/dvb-usb-v2/af9035.c                     |   13 ++-
 drivers/mfd/dln2.c                                        |    1 
 drivers/misc/ti-st/st_core.c                              |    7 +-
 drivers/mmc/core/mmc.c                                    |    2 
 drivers/net/ethernet/broadcom/tg3.c                       |    3 
 drivers/net/ethernet/intel/i40e/i40e_main.c               |   10 ++-
 drivers/net/wireless/realtek/rtlwifi/rtl8188ee/dm.c       |    2 
 drivers/net/wireless/realtek/rtlwifi/rtl8192c/dm_common.c |    2 
 drivers/net/wireless/realtek/rtlwifi/rtl8723ae/dm.c       |    2 
 drivers/pcmcia/cs.c                                       |    1 
 drivers/pcmcia/ds.c                                       |   14 ++--
 drivers/platform/x86/wmi.c                                |   16 ++--
 drivers/pwm/pwm-brcmstb.c                                 |    4 -
 drivers/thermal/thermal_core.c                            |    6 +
 drivers/tty/tty_jobctrl.c                                 |   17 +++--
 drivers/usb/dwc2/hcd.c                                    |    2 
 drivers/usb/usbip/stub_dev.c                              |    9 ++
 drivers/video/fbdev/fsl-diu-fb.c                          |    2 
 fs/btrfs/ioctl.c                                          |   10 +--
 fs/ext4/extents.c                                         |   10 +--
 net/dccp/ipv4.c                                           |    6 -
 net/dccp/ipv6.c                                           |    6 -
 net/ipv4/tcp_metrics.c                                    |   11 +--
 net/ipv6/ip6_output.c                                     |    8 ++
 net/ipv6/syncookies.c                                     |    7 +-
 net/llc/llc_input.c                                       |   10 ++-
 net/llc/llc_s_ac.c                                        |    3 
 net/llc/llc_station.c                                     |    3 
 net/netfilter/xt_recent.c                                 |    2 
 net/tipc/netlink.c                                        |    4 -
 sound/soc/intel/skylake/skl-sst-utils.c                   |    1 
 49 files changed, 201 insertions(+), 164 deletions(-)

Andrii Staikov (1):
      i40e: fix potential memory leaks in i40e_remove()

Armin Wolf (1):
      platform/x86: wmi: Fix probe failure when failing to register WMI devices

Arnd Bergmann (1):
      fbdev: fsl-diu-fb: mark wr_reg_wa() static

Cezary Rojewski (1):
      ASoC: Intel: Skylake: Fix mem leak when parsing UUIDs fails

Christophe JAILLET (3):
      ACPI: sysfs: Fix create_pnp_modalias() and create_of_modalias()
      drm/rockchip: cdn-dp: Fix some error handling paths in cdn_dp_probe()
      dmaengine: pxa_dma: Remove an erroneous BUG_ON() in pxad_free_desc()

Dan Carpenter (3):
      thermal: core: prevent potential string overflow
      clk: keystone: pll: fix a couple NULL vs IS_ERR() checks
      dmaengine: ti: edma: handle irq_of_parse_and_map() errors

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

Eric Dumazet (2):
      tcp_metrics: properly set tp->snd_ssthresh in tcp_init_metrics()
      tcp_metrics: do not create an entry from tcp_init_metrics()

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
      Linux 4.14.330

Hans Verkuil (1):
      media: dvb-usb-v2: af9035: fix missing unlock

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

Katya Orlova (1):
      media: s3c-camif: Avoid inappropriate kfree()

Konstantin Meskhidze (1):
      drm/radeon: possible buffer overflow

Krzysztof Kozlowski (1):
      ARM: dts: qcom: mdm9615: populate vsdcc fixed regulator

Kuniyuki Iwashima (2):
      dccp: Call security_inet_conn_request() after setting IPv4 addresses.
      dccp/tcp: Call security_inet_conn_request() after setting IPv6 addresses.

Kursad Oney (1):
      ARM: 9321/1: memset: cast the constant byte to unsigned char

Leon Romanovsky (1):
      RDMA/hfi1: Workaround truncation compilation error

Maciej Żenczykowski (1):
      netfilter: xt_recent: fix (increase) ipv6 literal buffer length

Shigeru Yoshida (1):
      tipc: Change nla_policy for bearer-related names to NLA_NUL_STRING

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

