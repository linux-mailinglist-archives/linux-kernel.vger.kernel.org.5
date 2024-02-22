Return-Path: <linux-kernel+bounces-75732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9CAA85EE25
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 01:37:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A9441F21CE5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 00:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B806A11CA0;
	Thu, 22 Feb 2024 00:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="CmmEc1xT"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBC32919;
	Thu, 22 Feb 2024 00:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708562238; cv=none; b=S3Jl15s4L4uajISXtCyNOYCwA/6rAnWW7ulWhvr9HOMklX2utFRIc7qm1s4YfCSkAkyscuzI8w7lAT3Kb6Jfx52dUN4Db9JgyoAn4h4Y+uc2HssG0Eh/qnUQMXQpDgxjxfbhpzE3glILWb9BpVSpDV/ho/npazzuxTgu9sUrwzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708562238; c=relaxed/simple;
	bh=72568EdCiYr/Ee53OvndWrLqSBEKVDxonZRvv5ly7cw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VMxA0w681aOYKKawmrIcJ87DOVmh/QVBp5QRpWHGZ1u3KbXEr/DmNO+Ui3D3OnEdPRSzBgh/eBqort9M1m+4q84412SsddxO1NgvX/0JyKbkmkpSlQL5EWJt/LBrNVIlogzVRrocv6DoP0l7AQYXh51Gts6apRZThmRDzbOx+HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=CmmEc1xT; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: from [192.168.68.112] (ppp118-210-142-230.adl-adc-lon-bras33.tpg.internode.on.net [118.210.142.230])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 6CD8920075;
	Thu, 22 Feb 2024 08:37:08 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1708562233;
	bh=Tp6DArOflTs0IxRQ/vtC4XqHHWEiEpMTXjecUx41ktE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=CmmEc1xTLF/47r0FbvgXVMfG/s0UF5gFIXu0OQi+0aGHqpxv9o4fLPpjZt7unPgk9
	 QjjYzFS9F9NpwaiyRJkfTCCRy0r3ebcPw2NdJ8midm71ShT/oFgQSugG5pHldiZrSs
	 448/E0cB5PG1P5uUYW1Pwnbi4NNBPIIb1675kLOttyiSU0tqQX9EUX8xLksNBpvRhH
	 5qzDXeTHTKEMj8zyLbfIqqCqFcp3m/NPW8611Gz89SxaUgJ88DWfSENa00b6U+CJg0
	 FUP3rEezZXwhY+mbtulKfbHhMULDahRTmP623sTfJ2br6vHr/7djx5soQ3xxdeAR+b
	 NVDF2j7A4rCsw==
Message-ID: <0a828f2c50de712940fb9a881702ac1678a35b7c.camel@codeconstruct.com.au>
Subject: Re: [PATCH v1 10/14] serial: 8250_of: Switch to use
 uart_read_port_properties()
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Greg Kroah-Hartman
	 <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-rpi-kernel@lists.infradead.org, linux-mips@vger.kernel.org, 
	linux-tegra@vger.kernel.org
Cc: Jiri Slaby <jirislaby@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui
 <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,  Broadcom
 internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Al
 Cooper <alcooperx@gmail.com>,  Ilpo =?ISO-8859-1?Q?J=E4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, Paul Cercueil <paul@crapouillou.net>, 
 Vladimir Zapolskiy <vz@mleia.com>, Thierry Reding
 <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,  Masami Hiramatsu
 <mhiramat@kernel.org>, Andi Shyti <andi.shyti@linux.intel.com>
Date: Thu, 22 Feb 2024 11:07:05 +1030
In-Reply-To: <20240221183442.4124354-11-andriy.shevchenko@linux.intel.com>
References: <20240221183442.4124354-1-andriy.shevchenko@linux.intel.com>
	 <20240221183442.4124354-11-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-02-21 at 20:31 +0200, Andy Shevchenko wrote:
> Since we have now a common helper to read port properties
> use it instead of sparse home grown solution.

I did some brief testing of the series for the Aspeed machines under
qemu, building them on top of v6.8-rc5:

export ARCH=3Darm
export CROSS_COMPILE=3Darm-linux-gnueabihf-
make aspeed_g5_defconfig
make -j$(nproc)
qemu-system-arm -M rainier-bmc -nographic -no-reboot -kernel arch/arm/boot/=
zImage -dtb arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dtb -initrd ...

I got an oops during boot, which bisected to this change:

[    0.314946] 8<--- cut here ---
[    0.315051] Unable to handle kernel paging request at virtual address fe=
e00000 when write
[    0.315201] [fee00000] *pgd=3D00000000
[    0.315593] Internal error: Oops: 805 [#1] SMP ARM
[    0.315847] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 6.8.0-rc5-00010-g8=
a2c8fe174cf #13
[    0.316071] Hardware name: Generic DT based system
[    0.316216] PC is at io_serial_out+0x18/0x20
[    0.316677] LR is at serial8250_do_set_mctrl+0x54/0x90
[    0.316781] pc : [<8060eea8>]    lr : [<806108b0>]    psr: 40000093
[    0.316891] sp : bf815b08  ip : 00000000  fp : 00000026
[    0.316987] r10: 81698240  r9 : 40000013  r8 : 81cae600
[    0.317087] r7 : 81d7d1a8  r6 : 81d7d110  r5 : 81008158  r4 : 00000000
[    0.317197] r3 : fee00000  r2 : 00000000  r1 : 00000004  r0 : 81008158
[    0.317350] Flags: nZcv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segmen=
t none
[    0.317471] Control: 10c5387d  Table: 8000406a  DAC: 00000051
[    0.317593] Register r0 information: non-slab/vmalloc memory
[    0.317892] Register r1 information: non-paged memory
[    0.317996] Register r2 information: NULL pointer
[    0.318080] Register r3 information: vmalloc memory
[    0.318176] Register r4 information: NULL pointer
[    0.318264] Register r5 information: non-slab/vmalloc memory
[    0.318362] Register r6 information: slab kmalloc-2k start 81d7d000 poin=
ter offset 272 size 2048
[    0.318701] Register r7 information: slab kmalloc-2k start 81d7d000 poin=
ter offset 424 size 2048
[    0.318860] Register r8 information: slab kmalloc-512 start 81cae600 poi=
nter offset 0 size 512
[    0.319095] Register r9 information: non-paged memory
[    0.319194] Register r10 information: slab kmalloc-64 start 81698240 poi=
nter offset 0 size 64
[    0.319266] Freeing initrd memory: 13684K
[    0.319384] Register r11 information: non-paged memory
[    0.319593] Register r12 information: NULL pointer
[    0.319703] Process swapper/0 (pid: 1, stack limit =3D 0x(ptrval))
[    0.320006] Stack: (0xbf815b08 to 0xbf816000)
[    0.320157] 5b00:                   81008158 80f85a88 81d7d110 8060cb78 =
bf815b34 00000026
[    0.320313] 5b20: 0016e360 80cba110 81e65e80 80cfcdf4 00000003 204f2f49 =
00307830 00000000
[    0.320457] 5b40: 00000000 00000000 00000000 00000000 00000000 00000000 =
00000000 00000000
[    0.320600] 5b60: 00000000 00000000 00000000 00000000 00000000 ed1677db =
81008158 81008158
[    0.320744] 5b80: bf815c00 81e5c5c0 81008304 81007f58 bf815d2c bf815dac =
00000000 8060e1f4
[    0.320890] 5ba0: 80cba4ec 8081e2c4 bf815dfc 00000001 00000000 81cf5400 =
81cf5410 81e65e00
[    0.321030] 5bc0: 00000004 00000000 00000001 80616538 00000000 00000000 =
00000000 00000000
[    0.321176] 5be0: 1e784000 1e784fff bd7c1a94 00000200 00000000 00000000 =
00000000 00000000
[    0.321325] 5c00: 00000000 00000000 00000000 00000000 00000000 00000000 =
00000000 00000000
[    0.321469] 5c20: 00000000 00000000 00000000 00000000 00000000 00000000 =
00000000 00000000
[    0.321624] 5c40: 00000000 00000000 8060fb34 00000000 00000000 00000000 =
00000026 00000000
[    0.321777] 5c60: 016e3600 00000000 00000200 00000000 00000000 00000000 =
00000000 00000000
[    0.321920] 5c80: 00000000 00000000 00000000 00000000 00000000 00000000 =
00000000 00000000
[    0.322063] 5ca0: 00000000 00000000 b9000040 00000000 00000000 00000000 =
00000000 00000000
[    0.322204] 5cc0: 00000004 00000000 00000000 00000004 00000000 1e784000 =
00001000 81cf5410
[    0.322347] 5ce0: 00000000 00000000 00000000 00000000 00000000 00000000 =
00000000 00000000
[    0.322492] 5d00: 00000000 00000000 00000000 00000000 00000000 00000000 =
00000000 00000037
[    0.322640] 5d20: 00000001 00000001 00000000 00000000 00000000 00000000 =
00000000 00000000
[    0.322800] 5d40: 00000000 00000000 00000000 00000000 00000000 00000000 =
00000000 00000000
[    0.322957] 5d60: 00000000 00000000 00000000 00000000 00000000 00000000 =
00000000 00000000
[    0.323114] 5d80: 00000000 00000000 00000000 00000000 00000000 00000000 =
00000000 00000000
[    0.323271] 5da0: 00000000 00000000 00000000 00000000 00000000 00000000 =
00000000 00000000
[    0.323422] 5dc0: 00000000 00000000 806111c8 80610eb4 00000000 00000000 =
00000000 00000000
[    0.323573] 5de0: 00000000 00000000 00000000 00000000 00000000 00000000 =
00000000 00000000
[    0.323723] 5e00: 00000000 ed1677db 00000000 81cf5410 80f85cf8 00000000 =
00000000 81e5c638
[    0.323878] 5e20: 80e66f48 8067f888 81cf5410 00000000 80f85cf8 00000000 =
00000000 8067ca08
[    0.324029] 5e40: 81cf5410 00000000 81cf5410 81cf5410 80f85cf8 81cf5454 =
81cf5410 8067cda8
[    0.324181] 5e60: 60000013 81e5c638 81008d4c 81008d54 81cf5454 81cf5410 =
00000000 8067cf3c
[    0.324337] 5e80: 81cf5410 80f85cf8 81cf5454 814cec00 00000000 8067d21c =
00000000 80f85cf8
[    0.324494] 5ea0: 8067d11c 8067aa04 814cec00 814cec58 816a4bb4 ed1677db =
814cec00 81e5c600
[    0.324646] 5ec0: 00000000 80f85cf8 814cec00 8067bc6c 80cba524 00000000 =
00000006 80f85cf8
[    0.324795] 5ee0: 8158b480 00000006 bf815f14 00000000 80d19438 8067e284 =
80e221c4 8158b480
[    0.324945] 5f00: 00000006 80e01414 80d2d3b0 000000db 8173ad17 00000000 =
00000000 00000000
[    0.325096] 5f20: 00000000 00000000 00000000 00000000 00000000 00000000 =
00000000 00000000
[    0.325247] 5f40: 00000000 00000000 00000000 00000000 00000000 ed1677db =
8173ad00 00000020
[    0.325403] 5f60: 00000006 80e3b83c 80e3b860 80e01750 00000006 00000006 =
00000000 80e004f8
[    0.325553] 5f80: 80f05cc0 80a50e18 00000000 00000000 00000000 00000000 =
00000000 80a50e34
[    0.325699] 5fa0: 00000000 80a50e18 00000000 8010016c 00000000 00000000 =
00000000 00000000
[    0.325848] 5fc0: 00000000 00000000 00000000 00000000 00000000 00000000 =
00000000 00000000
[    0.325995] 5fe0: 00000000 00000000 00000000 00000000 00000013 00000000 =
00000000 00000000
[    0.326531]  io_serial_out from serial8250_do_set_mctrl+0x54/0x90
[    0.326761]  serial8250_do_set_mctrl from serial_core_register_port+0x4c=
4/0x694
[    0.326917]  serial_core_register_port from serial8250_register_8250_por=
t+0x310/0x4bc
[    0.327063]  serial8250_register_8250_port from of_platform_serial_probe=
+0x300/0x45c
[    0.327242]  of_platform_serial_probe from platform_probe+0x60/0xb8
[    0.327367]  platform_probe from really_probe+0xd4/0x3e4
[    0.327471]  really_probe from __driver_probe_device+0x90/0x1ec
[    0.327568]  __driver_probe_device from driver_probe_device+0x38/0xd0
[    0.327674]  driver_probe_device from __driver_attach+0x100/0x1dc
[    0.327793]  __driver_attach from bus_for_each_dev+0x84/0xd4
[    0.327906]  bus_for_each_dev from bus_add_driver+0xec/0x1f0
[    0.328015]  bus_add_driver from driver_register+0x84/0x11c
[    0.328126]  driver_register from do_one_initcall+0x84/0x1c8
[    0.328297]  do_one_initcall from kernel_init_freeable+0x19c/0x22c
[    0.328419]  kernel_init_freeable from kernel_init+0x1c/0x138
[    0.328534]  kernel_init from ret_from_fork+0x14/0x28
[    0.328656] Exception stack(0xbf815fb0 to 0xbf815ff8)
[    0.328755] 5fa0:                                     00000000 00000000 =
00000000 00000000
[    0.328901] 5fc0: 00000000 00000000 00000000 00000000 00000000 00000000 =
00000000 00000000
[    0.329112] 5fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[    0.329413] Code: e3a03000 ee073f9a e2433612 e6ef2072 (e5c32000)
[    0.329824] ---[ end trace 0000000000000000 ]---
[    0.336692] Kernel panic - not syncing: Fatal exception

Andrew


