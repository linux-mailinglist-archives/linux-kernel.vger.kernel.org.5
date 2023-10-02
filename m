Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D391E7B5B7D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 21:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238900AbjJBTgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 15:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238881AbjJBTgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 15:36:20 -0400
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA890AC
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 12:36:15 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:5b9d:c703:a536:8d7b])
        by michel.telenet-ops.be with bizsmtp
        id t7cC2A00G0Gl2EY067cCtG; Mon, 02 Oct 2023 21:36:12 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qnOhn-00565P-AV
        for linux-kernel@vger.kernel.org;
        Mon, 02 Oct 2023 21:36:12 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qnOiC-00FUnr-9G
        for linux-kernel@vger.kernel.org;
        Mon, 02 Oct 2023 21:36:12 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-kernel@vger.kernel.org
Subject: Build regressions/improvements in v6.6-rc4
Date:   Mon,  2 Oct 2023 21:36:12 +0200
Message-Id: <20231002193612.3693319-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAHk-=wia2-4DRvD-aXz70AV64yrt+Vr50MxHiDunZ71dHATv-Q@mail.gmail.com>
References: <CAHk-=wia2-4DRvD-aXz70AV64yrt+Vr50MxHiDunZ71dHATv-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Below is the list of build error/warning regressions/improvements in
v6.6-rc4[1] compared to v6.5[2].

Summarized:
  - build errors: +4/-5
  - build warnings: +33/-6

JFYI, when comparing v6.6-rc4[1] to v6.6-rc3[3], the summaries are:
  - build errors: +0/-0
  - build warnings: +0/-3

Note that there may be false regressions, as some logs are incomplete.
Still, they're build errors/warnings.

Happy fixing! ;-)

Thanks to the linux-next team for providing the build service.

[1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/8a749fd1a8720d4619c91c8b6e7528c0a355c0aa/ (all 239 configs)
[2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/2dde18cd1d8fac735875f2e4987f11817cc0bc2c/ (234 out of 239 configs)
[3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/6465e260f48790807eef06b583b38ca9789b6072/ (all 239 configs)


*** ERRORS ***

4 error regressions:
  + error: modpost: ".L872" [drivers/mtd/nand/raw/nand.ko] undefined!:  => N/A
  + {standard input}: Error: expected comma after name `xpcs_co' in .size directive:  => 1100
  + {standard input}: Error: expected symbol name:  => 1095
  + {standard input}: Error: pcrel too far:  => 940, 932, 939

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
  + {standard input}: Warning: end of file not at end of a line; newline inserted:  => 1094

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
