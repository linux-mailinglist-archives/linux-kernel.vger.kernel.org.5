Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5F957BF47B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 09:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442523AbjJJHjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 03:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442488AbjJJHjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 03:39:02 -0400
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 829D8A4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 00:38:59 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:8cb2:eea1:154:22ce])
        by andre.telenet-ops.be with bizsmtp
        id w7ex2A00J1pyQdZ017exct; Tue, 10 Oct 2023 09:38:57 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qq7KR-005pRC-NO
        for linux-kernel@vger.kernel.org;
        Tue, 10 Oct 2023 09:38:57 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qq7KT-00El7i-AF
        for linux-kernel@vger.kernel.org;
        Tue, 10 Oct 2023 09:38:57 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-kernel@vger.kernel.org
Subject: Build regressions/improvements in v6.6-rc5
Date:   Tue, 10 Oct 2023 09:38:57 +0200
Message-Id: <20231010073857.3517727-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAHk-=wh7awamHE3ujoxZFcGMg3wvLTk8UZYSm3m7vUDhpmP2+A@mail.gmail.com>
References: <CAHk-=wh7awamHE3ujoxZFcGMg3wvLTk8UZYSm3m7vUDhpmP2+A@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Below is the list of build error/warning regressions/improvements in
v6.6-rc5[1] compared to v6.5[2].

Summarized:
  - build errors: +4/-5
  - build warnings: +33/-6

JFYI, when comparing v6.6-rc5[1] to v6.6-rc4[3], the summaries are:
  - build errors: +0/-1
  - build warnings: +1/-0

Note that there may be false regressions, as some logs are incomplete.
Still, they're build errors/warnings.

Happy fixing! ;-)

Thanks to the linux-next team for providing the build service.

[1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/94f6f0550c625fab1f373bb86a6669b45e9748b3/ (all 239 configs)
[2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/2dde18cd1d8fac735875f2e4987f11817cc0bc2c/ (234 out of 239 configs)
[3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/8a749fd1a8720d4619c91c8b6e7528c0a355c0aa/ (all 239 configs)


*** ERRORS ***

4 error regressions:
  + error: modpost: ".L872" [drivers/mtd/nand/raw/nand.ko] undefined!:  => N/A
  + {standard input}: Error: expected comma after name `xpcs_co' in .size directive:  => 1100
  + {standard input}: Error: expected symbol name:  => 1095
  + {standard input}: Error: pcrel too far:  => 933, 934

5 error improvements:
  - error: modpost: ".L856" [drivers/mtd/nand/raw/nand.ko] undefined!: N/A => 
  - {standard input}: Error: Missing symbol name in directive: 1096 => 
  - {standard input}: Error: unknown opcode: 1091 => 
  - {standard input}: Error: unknown pseudo-op: `.glo': 1097 => 
  - {standard input}: Error: unrecognized symbol type "": 1096 => 


*** WARNINGS ***

33 warning regressions:
  + modpost: WARNING: modpost: "__ashldi3" [fs/ext2/ext2.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__lshrdi3" [drivers/block/ublk_drv.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__ndelay" [drivers/mtd/nand/raw/qcom_nandc.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/char/hw_random/geode-rng.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/char/hw_random/ingenic-rng.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/char/hw_random/intel-rng.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/char/hw_random/mxc-rnga.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/char/hw_random/xgene-rng.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/comedi/drivers/adl_pci9118.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/comedi/drivers/amplc_pci230.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/comedi/drivers/cb_das16_cs.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/comedi/drivers/cb_pcidas.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/comedi/drivers/das800.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/comedi/drivers/mpc624.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/comedi/drivers/ni_atmio.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/comedi/drivers/ni_labpc_common.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/comedi/drivers/pcl812.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/comedi/drivers/pcl816.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/comedi/drivers/pcl818.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/comedi/drivers/rti800.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/hwmon/hs3001.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/mtd/nand/raw/qcom_nandc.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/net/ethernet/broadcom/asp2/bcm-asp.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/net/wireless/mediatek/mt76/mt792x-lib.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/phy/qualcomm/phy-qcom-m31.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/phy/realtek/phy-rtk-usb2.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/phy/realtek/phy-rtk-usb3.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/phy/rockchip/phy-rockchip-inno-usb2.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/pmdomain/amlogic/meson-ee-pwrc.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/pmdomain/amlogic/meson-gx-pwrc-vpu.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/watchdog/gxp-wdt.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/watchdog/smsc37b787_wdt.ko] has no CRC!:  => N/A
  + {standard input}: Warning: end of file not at end of a line; newline inserted:  => 943, 1094

6 warning improvements:
  - modpost: WARNING: modpost: "__udelay" [drivers/hwmon/smm665.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "__udelay" [drivers/net/wireless/mediatek/mt76/mt7921/mt7921-common.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "__udelay" [drivers/net/wireless/mediatek/mt76/mt7996/mt7996e.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "__udelay" [drivers/soc/amlogic/meson-ee-pwrc.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "__udelay" [drivers/soc/amlogic/meson-gx-pwrc-vpu.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "__udelay" [sound/soc/codecs/snd-soc-l3.ko] has no CRC!: N/A => 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
