Return-Path: <linux-kernel+bounces-3173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD784816855
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 09:40:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95B6F2820CC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 08:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239AC10971;
	Mon, 18 Dec 2023 08:39:50 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from riemann.telenet-ops.be (riemann.telenet-ops.be [195.130.137.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82D810950
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 08:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
	by riemann.telenet-ops.be (Postfix) with ESMTPS id 4SttY74fqzz4wx2D
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 09:39:39 +0100 (CET)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:1c58:2452:9c5e:ccf6])
	by andre.telenet-ops.be with bizsmtp
	id PkfX2B00U182r2K01kfXco; Mon, 18 Dec 2023 09:39:32 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rF99V-00CaMJ-E8
	for linux-kernel@vger.kernel.org;
	Mon, 18 Dec 2023 09:39:31 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rF99v-000L2f-Ol
	for linux-kernel@vger.kernel.org;
	Mon, 18 Dec 2023 09:39:31 +0100
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: linux-kernel@vger.kernel.org
Subject: Build regressions/improvements in v6.7-rc6
Date: Mon, 18 Dec 2023 09:39:31 +0100
Message-Id: <20231218083931.80857-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAHk-=wi17USyiO=G0yDXP62eqU3V6x3ck0HcnVMPKHNPsBP_ig@mail.gmail.com>
References: <CAHk-=wi17USyiO=G0yDXP62eqU3V6x3ck0HcnVMPKHNPsBP_ig@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Below is the list of build error/warning regressions/improvements in
v6.7-rc6[1] compared to v6.6[2].

Summarized:
  - build errors: +12/-9
  - build warnings: +24/-11

JFYI, when comparing v6.7-rc6[1] to v6.7-rc5[3], the summaries are:
  - build errors: +11/-1
  - build warnings: +0/-1

Note that there may be false regressions, as some logs are incomplete.
Still, they're build errors/warnings.

Happy fixing! ;-)

Thanks to the linux-next team for providing the build service.

[1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/ceb6a6f023fd3e8b07761ed900352ef574010bcb/ (237 out of 239 configs)
[2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/ffc253263a1375a65fa6c9f62a893e9767fbebfa/ (all 239 configs)
[3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/a39b6ac3781d46ba18193c9dbb2110f31e9bffe9/ (238 out of 239 configs)


*** ERRORS ***

12 error regressions:
  + {standard input}: Error: displacement to undefined symbol .L104 overflows 8-bit field :  => 588
  + {standard input}: Error: displacement to undefined symbol .L105 overflows 8-bit field :  => 590
  + {standard input}: Error: displacement to undefined symbol .L134 overflows 8-bit field :  => 598
  + {standard input}: Error: displacement to undefined symbol .L135 overflows 8-bit field :  => 603
  + {standard input}: Error: displacement to undefined symbol .L75 overflows 12-bit field:  => 589, 606, 586
  + {standard input}: Error: displacement to undefined symbol .L76 overflows 8-bit field :  => 580, 577
  + {standard input}: Error: displacement to undefined symbol .L80 overflows 8-bit field :  => 607, 601
  + {standard input}: Error: displacement to undefined symbol .L81 overflows 8-bit field : 606 => 606, 610, 604
  + {standard input}: Error: displacement to undefined symbol .L96 overflows 12-bit field:  => 602
  + {standard input}: Error: invalid operands for opcode:  => 612
  + {standard input}: Error: missing operand:  => 612
  + {standard input}: Error: pcrel too far: 595, 574, 598, 601, 577, 604 => 596, 599, 610, 569, 574, 601, 572, 595, 590, 593

9 error improvements:
  - error: modpost: ".L872" [drivers/mtd/nand/raw/nand.ko] undefined!: N/A => 
  - {standard input}: Error: displacement to undefined symbol .L101 overflows 12-bit field: 607 => 
  - {standard input}: Error: displacement to undefined symbol .L103 overflows 8-bit field : 593 => 
  - {standard input}: Error: displacement to undefined symbol .L107 overflows 8-bit field : 590 => 
  - {standard input}: Error: displacement to undefined symbol .L140 overflows 8-bit field : 603 => 
  - {standard input}: Error: displacement to undefined symbol .L149 overflows 8-bit field : 606 => 
  - {standard input}: Error: displacement to undefined symbol .L73 overflows 12-bit field: 594 => 
  - {standard input}: Error: displacement to undefined symbol .L74 overflows 8-bit field : 585 => 
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

11 warning improvements:
  - modpost: WARNING: modpost: "__ashldi3" [drivers/net/ethernet/mellanox/mlxsw/mlxsw_core.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "__lshrdi3" [drivers/net/ethernet/mellanox/mlxsw/mlxsw_core.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "__lshrdi3" [drivers/thunderbolt/thunderbolt.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "__udelay" [drivers/media/platform/cadence/cdns-csi2rx.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "__udelay" [drivers/phy/realtek/phy-rtk-usb2.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "__udelay" [drivers/phy/realtek/phy-rtk-usb3.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "__udelay" [drivers/staging/iio/resolver/ad2s1210.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "__udelay" [drivers/staging/qlge/qlge.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: "__udelay" [drivers/staging/rtl8192u/r8192u_usb.ko] has no CRC!: N/A => 
  - modpost: WARNING: modpost: vmlinux: section mismatch in reference: __trace_event_discard_commit+0x184 (section: .text.unlikely) -> initcall_level_names (section: .init.data): N/A => 
  - modpost: WARNING: modpost: vmlinux: section mismatch in reference: __trace_event_discard_commit+0xe0 (section: .text.unlikely) -> initcall_level_names (section: .init.data): N/A => 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

