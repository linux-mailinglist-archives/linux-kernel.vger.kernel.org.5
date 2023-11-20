Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DACC7F18C6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 17:39:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232148AbjKTQjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 11:39:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbjKTQjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 11:39:32 -0500
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B65C893
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 08:39:26 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:6bd9:a79:1d00:5285])
        by albert.telenet-ops.be with bizsmtp
        id CgfP2B00p0Wid3g06gfPqR; Mon, 20 Nov 2023 17:39:24 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1r57Il-009sdf-Hf
        for linux-kernel@vger.kernel.org;
        Mon, 20 Nov 2023 17:39:23 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1r57Ix-00Fqqe-Nq
        for linux-kernel@vger.kernel.org;
        Mon, 20 Nov 2023 17:39:23 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-kernel@vger.kernel.org
Subject: Build regressions/improvements in v6.7-rc2
Date:   Mon, 20 Nov 2023 17:39:23 +0100
Message-Id: <20231120163923.3778033-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAHk-=wj6j3U5r8ixVf_RQXwRYD03DuEqnX2ZsfYwvB-9YxQNLA@mail.gmail.com>
References: <CAHk-=wj6j3U5r8ixVf_RQXwRYD03DuEqnX2ZsfYwvB-9YxQNLA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Below is the list of build error/warning regressions/improvements in
v6.7-rc2[1] compared to v6.6[2].

Summarized:
  - build errors: +25/-5
  - build warnings: +24/-8

JFYI, when comparing v6.7-rc2[1] to v6.7-rc1[3], the summaries are:
  - build errors: +11/-0
  - build warnings: +0/-0

Note that there may be false regressions, as some logs are incomplete.
Still, they're build errors/warnings.

Happy fixing! ;-)

Thanks to the linux-next team for providing the build service.

[1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/98b1cc82c4affc16f5598d4fa14b1858671b2263/ (all 239 configs)
[2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/ffc253263a1375a65fa6c9f62a893e9767fbebfa/ (all 239 configs)
[3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/b85ea95d086471afb4ad062012a4d73cd328fa86/ (238 out of 239 configs)


*** ERRORS ***

25 error regressions:
  + /kisskb/src/include/linux/compiler_types.h: error: call to '__compiletime_assert_654' declared with attribute error: FIELD_PREP: value too large for the field:  => 435:38
  + {standard input}: Error: displacement to undefined symbol .L100 overflows 8-bit field :  => 588
  + {standard input}: Error: displacement to undefined symbol .L101 overflows 8-bit field :  => 593
  + {standard input}: Error: displacement to undefined symbol .L104 overflows 8-bit field :  => 588
  + {standard input}: Error: displacement to undefined symbol .L105 overflows 8-bit field :  => 593, 590
  + {standard input}: Error: displacement to undefined symbol .L134 overflows 8-bit field :  => 598
  + {standard input}: Error: displacement to undefined symbol .L135 overflows 8-bit field :  => 603
  + {standard input}: Error: displacement to undefined symbol .L139 overflows 8-bit field :  => 606
  + {standard input}: Error: displacement to undefined symbol .L72 overflows 12-bit field:  => 589
  + {standard input}: Error: displacement to undefined symbol .L73 overflows 8-bit field :  => 580
  + {standard input}: Error: displacement to undefined symbol .L75 overflows 12-bit field:  => 586, 589, 606
  + {standard input}: Error: displacement to undefined symbol .L76 overflows 12-bit field: 591 => 591, 594
  + {standard input}: Error: displacement to undefined symbol .L76 overflows 8-bit field :  => 580, 577
  + {standard input}: Error: displacement to undefined symbol .L77 overflows 8-bit field : 582 => 607, 585, 582
  + {standard input}: Error: displacement to undefined symbol .L78 overflows 8-bit field :  => 610
  + {standard input}: Error: displacement to undefined symbol .L80 overflows 8-bit field :  => 607, 601
  + {standard input}: Error: displacement to undefined symbol .L81 overflows 8-bit field : 606 => 604, 610, 606
  + {standard input}: Error: displacement to undefined symbol .L96 overflows 12-bit field:  => 602
  + {standard input}: Error: displacement to undefined symbol .L97 overflows 12-bit field:  => 607
  + {standard input}: Error: displacement to undefined symbol .L98 overflows 12-bit field:  => 602
  + {standard input}: Error: displacement to undefined symbol .L99 overflows 12-bit field:  => 607
  + {standard input}: Error: invalid operands for opcode:  => 612
  + {standard input}: Error: missing operand:  => 612
  + {standard input}: Error: pcrel too far: 577, 595, 604, 598, 574, 601 => 595, 596, 572, 593, 610, 574, 590, 604, 601, 599, 598, 577, 569
  + {standard input}: Error: unknown pseudo-op: `.l':  => 609

5 error improvements:
  - {standard input}: Error: displacement to undefined symbol .L101 overflows 12-bit field: 607 => 
  - {standard input}: Error: displacement to undefined symbol .L103 overflows 8-bit field : 593 => 
  - {standard input}: Error: displacement to undefined symbol .L107 overflows 8-bit field : 590 => 
  - {standard input}: Error: displacement to undefined symbol .L149 overflows 8-bit field : 606 => 
  - {standard input}: Error: unknown pseudo-op: `.': 609 => 


*** WARNINGS ***

24 warning regressions:
  + modpost: WARNING: modpost: "__ashldi3" [fs/bcachefs/bcachefs.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__lshrdi3" [fs/bcachefs/bcachefs.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__ndelay" [drivers/iio/resolver/ad2s1210.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/char/hw_random/meson-rng.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/clk/sifive/sifive-prci.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/extcon/extcon-rtk-type-c.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/iio/adc/mcp3564.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/media/i2c/mt9m114.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/media/platform/nuvoton/npcm-video.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/rtc/rtc-imxdi.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/rtc/rtc-ssd202d.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "__udelay" [drivers/usb/typec/tipd/tps6598x.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "empty_zero_page" [fs/bcachefs/bcachefs.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: drivers/net/ethernet/intel/ice/ice: section mismatch in reference: ice_adv_lnk_speed_maps+0x110 (section: .data) -> ice_adv_lnk_speed_200000 (section: .init.rodata):  => N/A
  + modpost: WARNING: modpost: drivers/net/ethernet/intel/ice/ice: section mismatch in reference: ice_adv_lnk_speed_maps+0x14 (section: .data) -> ice_adv_lnk_speed_200000 (section: .init.rodata):  => N/A
  + modpost: WARNING: modpost: drivers/net/ethernet/intel/ice/ice: section mismatch in reference: ice_adv_lnk_speed_maps+0x30 (section: .data) -> ice_adv_lnk_speed_200000 (section: .init.rodata):  => N/A
  + modpost: WARNING: modpost: drivers/net/ethernet/intel/ice/ice: section mismatch in reference: ice_adv_lnk_speed_maps+0x4c (section: .data) -> ice_adv_lnk_speed_200000 (section: .init.rodata):  => N/A
  + modpost: WARNING: modpost: drivers/net/ethernet/intel/ice/ice: section mismatch in reference: ice_adv_lnk_speed_maps+0x68 (section: .data) -> ice_adv_lnk_speed_200000 (section: .init.rodata):  => N/A
  + modpost: WARNING: modpost: drivers/net/ethernet/intel/ice/ice: section mismatch in reference: ice_adv_lnk_speed_maps+0x84 (section: .data) -> ice_adv_lnk_speed_200000 (section: .init.rodata):  => N/A
  + modpost: WARNING: modpost: drivers/net/ethernet/intel/ice/ice: section mismatch in reference: ice_adv_lnk_speed_maps+0xa0 (section: .data) -> ice_adv_lnk_speed_200000 (section: .init.rodata):  => N/A
  + modpost: WARNING: modpost: drivers/net/ethernet/intel/ice/ice: section mismatch in reference: ice_adv_lnk_speed_maps+0xbc (section: .data) -> ice_adv_lnk_speed_200000 (section: .init.rodata):  => N/A
  + modpost: WARNING: modpost: drivers/net/ethernet/intel/ice/ice: section mismatch in reference: ice_adv_lnk_speed_maps+0xd8 (section: .data) -> ice_adv_lnk_speed_200000 (section: .init.rodata):  => N/A
  + modpost: WARNING: modpost: drivers/net/ethernet/intel/ice/ice: section mismatch in reference: ice_adv_lnk_speed_maps+0xf4 (section: .data) -> ice_adv_lnk_speed_200000 (section: .init.rodata):  => N/A
  + modpost: WARNING: modpost: vmlinux: section mismatch in reference: __trace_event_discard_commit+0xe4 (section: .text.unlikely) -> initcall_level_names (section: .init.data):  => N/A

8 warning improvements:
  - modpost: WARNING: modpost: "__ashldi3" [drivers/net/ethernet/mellanox/mlxsw/mlxsw_core.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "__lshrdi3" [drivers/net/ethernet/mellanox/mlxsw/mlxsw_core.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "__lshrdi3" [drivers/thunderbolt/thunderbolt.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "__udelay" [drivers/media/platform/cadence/cdns-csi2rx.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "__udelay" [drivers/staging/iio/resolver/ad2s1210.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "__udelay" [drivers/staging/qlge/qlge.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "__udelay" [drivers/staging/rtl8192u/r8192u_usb.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: vmlinux: section mismatch in reference: __trace_event_discard_commit+0xe0 (section: .text.unlikely) -> initcall_level_names (section: .init.data): N/A => 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
