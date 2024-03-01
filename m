Return-Path: <linux-kernel+bounces-88563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5086286E376
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 15:39:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D238A1F2283A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 14:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF60C38DC3;
	Fri,  1 Mar 2024 14:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="OAjzj4cs"
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8011F95F;
	Fri,  1 Mar 2024 14:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709303928; cv=none; b=nvsImUtgsv+rRq20pxdvhUEx1N1JlwEjWd3VpIw5birkZ8cFUamoQDb7fKPRQ4WGthNsSXcz2jxOYIRXCXbi+FqZF8kXH9omzx6oUE8v6iPMug179aaQLkyVieJ58XtR+b92ymknz2mhWy1hUgZjhAfBOFZR69lUCZcS8UT9wbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709303928; c=relaxed/simple;
	bh=15DiaVZmWQ5lkOk5yiyj7mODdqrJ813l7zkAfz6n24c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K9VY29TCG83mzt9WJ5SnWXfIPQoS1aEIR6iJQ0sbKNse+4a2q66VRsNWQY0w+vUupQvc7UQE8lPOQYUbagEZlu5hlMK7s5vF4efKPhsO0UE/J8T0Gk3C+oG1CM2spOmUqkfeZoWKu28InAgYRz3lGtGEVYjq5yc/DfymQWD4L6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=OAjzj4cs; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Bbd1F8GZfxauwRffXe1ckbLd3IotHJxaRzc9bB9mM4A=; t=1709303924; x=1709908724; 
	b=OAjzj4csyBV7wNKs/XQTXo0n8id6U1Nx+f4hTcJYThExAXNTw3gxL3Yjqg6Wt6c9BMSt5R113Fd
	kuXqlsnxH79yrENZCEcgNQnOMoctNMaFkQhEKi9KUdUZEnQnwjrxMmSAcdJ4LEjfwSspk6BZ52jX5
	+BKEzf+dcLbPUje8oGnDcwldksIk6GW41EcmlSmvdqyyvrnQAPX3YMpZEcda8aVu+Z/+Vf3kMEpov
	CAz8PMi6iQWVJLFV4FhLnVrhwwHBhrXKn3UZGSbAVxYJK4SNlnjdoXBFTVAEjYRG0aRbEEL867srF
	Y6Om4nymaIKXaPnJ0ubnq1adfySfvz4Y5dGg==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.97)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1rg425-00000000w7u-0gXm; Fri, 01 Mar 2024 15:38:41 +0100
Received: from dynamic-077-188-054-101.77.188.pool.telefonica.de ([77.188.54.101] helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.97)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1rg424-00000002oNJ-3r7I; Fri, 01 Mar 2024 15:38:41 +0100
Message-ID: <f8bef08f5acf6ea9f153a07351c5b06bcc64c763.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] sh: Fix build with CONFIG_UBSAN=y
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: "Liu, Yujie" <yujie.liu@intel.com>
Cc: lkp <lkp@intel.com>, "masahiroy@kernel.org" <masahiroy@kernel.org>, 
 "dalias@libc.org" <dalias@libc.org>, "linux-sh@vger.kernel.org"
 <linux-sh@vger.kernel.org>,  "keescook@chromium.org"
 <keescook@chromium.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "ysato@users.osdn.me"
 <ysato@users.osdn.me>,  "linux-hardening@vger.kernel.org"
 <linux-hardening@vger.kernel.org>, "Schier, Nicolas" <n.schier@avm.de>
Date: Fri, 01 Mar 2024 15:38:40 +0100
In-Reply-To: <e7a80eeafa9b916108ee53f2fe60524554ab0fa6.camel@intel.com>
References: <20240130232717.work.088-kees@kernel.org>
	 <494586ed5a0871cf7cfd005f513577952306a0bc.camel@physik.fu-berlin.de>
	 <fe057f57aba0f8a9040d4700d27f5bd478032925.camel@physik.fu-berlin.de>
	 <202402020228.BBEF7DAC@keescook>
	 <9fda57fc1b1ba6ad9bd6f7df3fb12674d0f4f940.camel@physik.fu-berlin.de>
	 <cd1a36a234c8fc61c5febe646ae0f05ed20ae32a.camel@physik.fu-berlin.de>
	 <202402121025.B0B6E47@keescook>
	 <178e0bebb1a85efebce1f504122ee190c068e0c9.camel@physik.fu-berlin.de>
	 <93572a771cb3a0b36a9213f18dd43c034c84cf6d.camel@physik.fu-berlin.de>
	 <e7a80eeafa9b916108ee53f2fe60524554ab0fa6.camel@intel.com>
Autocrypt: addr=glaubitz@physik.fu-berlin.de; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Yujie,

On Fri, 2024-03-01 at 05:46 +0000, Liu, Yujie wrote:
> On Wed, 2024-02-14 at 13:52 +0100, John Paul Adrian Glaubitz wrote:
> > Hi Kees,
> >=20
> > On Mon, 2024-02-12 at 19:45 +0100, John Paul Adrian Glaubitz wrote:
> > > On Mon, 2024-02-12 at 10:26 -0800, Kees Cook wrote:
> > > > > I just wanted to try reproduce the problem again with the reprodu=
cer in [1] as well
> > > > > as with gcc-13.2.0, but your branch devel/overflow/ubsan-only no =
longer exists.
> > > > >=20
> > > > > Can you tell me where to find the patches now?
> > > >=20
> > > > Sure, they're in -next, but for an -rc2 based tree, see:
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/log/=
?h=3Dfor-next/kspp
> > >=20
> > > OK, thanks. I will give it a try with gcc-13.
> >=20
> > I'm still unable to reproduce the error that the kernel test robot repo=
rted.
> >=20
> > I'm using gcc-13:
> >=20
> > glaubitz@node54:/data/home/glaubitz/linux-kees> sh4-linux-gcc
> > sh4-linux-gcc: fatal error: no input files
> > compilation terminated.
> > glaubitz@node54:/data/home/glaubitz/linux-kees> sh4-linux-gcc --version
> > sh4-linux-gcc (GCC) 13.2.0
> > Copyright (C) 2023 Free Software Foundation, Inc.
> > This is free software; see the source for copying conditions.=C2=A0 The=
re is NO
> > warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURP=
OSE.
> >=20
> > glaubitz@node54:/data/home/glaubitz/linux-kees>
> >=20
> > I checked out your tree and the for-next/kspp branch.
> >=20
> > Then fetched the config that triggered the bug like this:
> >=20
> > $ wget https://download.01.org/0day-ci/archive/20240131/202401310416.s8=
HLiLnC-lkp@intel.com/config=C2=A0-O .config
> >=20
> > Building the kernel with "make -j32 uImage" works fine. No errors excep=
t for
> > some unreleated warnings that still need to be fixed.
>=20
> Sorry for late reply. Seems like the warnings can be reproduced by
> "make zImage" which is the default make target, but cannot be
> reproduced by "make uImage".
>=20
> HEAD is now at 918327e9b7ffb ubsan: Remove CONFIG_UBSAN_SANITIZE_ALL
>=20
> $ wget https://download.01.org/0day-ci/archive/20240131/202401310416.s8HL=
iLnC-lkp@intel.com/config -O .config
> $ sh4-linux-gcc --version
> sh4-linux-gcc (GCC) 13.2.0
>=20
> $ make -j72 CROSS_COMPILE=3Dsh4-linux- ARCH=3Dsh olddefconfig
> $ make -j72 CROSS_COMPILE=3Dsh4-linux- ARCH=3Dsh
> ...
>   LD      arch/sh/boot/compressed/vmlinux
> sh4-linux-ld: arch/sh/boot/compressed/misc.o: in function `zlib_inflate_t=
able':
> misc.c:(.text+0x670): undefined reference to `__ubsan_handle_shift_out_of=
_bounds'
> sh4-linux-ld: arch/sh/boot/compressed/misc.o: in function `inflate_fast':
> misc.c:(.text+0xc5c): undefined reference to `__ubsan_handle_shift_out_of=
_bounds'
> sh4-linux-ld: arch/sh/boot/compressed/misc.o: in function `zlib_inflateRe=
set':
> misc.c:(.text+0xd00): undefined reference to `__ubsan_handle_shift_out_of=
_bounds'
> sh4-linux-ld: arch/sh/boot/compressed/misc.o: in function `zlib_inflate':
> misc.c:(.text+0x23fc): undefined reference to `__ubsan_handle_shift_out_o=
f_bounds'
> sh4-linux-ld: arch/sh/boot/compressed/ashldi3.o: in function `__ashldi3':
> ashldi3.c:(.text+0xc8): undefined reference to `__ubsan_handle_shift_out_=
of_bounds'
> make[3]: *** [arch/sh/boot/compressed/Makefile:38: arch/sh/boot/compresse=
d/vmlinux] Error 1
> make[2]: *** [arch/sh/boot/Makefile:40: arch/sh/boot/compressed/vmlinux] =
Error 2
> make[1]: *** [arch/sh/Makefile:170: zImage] Error 2
> make: *** [Makefile:240: __sub-make] Error 2
>=20
> $ make -j72 CROSS_COMPILE=3Dsh4-linux- ARCH=3Dsh uImage
> ...
>   OBJCOPY arch/sh/boot/vmlinux.bin
>   GZIP    arch/sh/boot/vmlinux.bin.gz
>   UIMAGE  arch/sh/boot/uImage.gz
> Image Name:   Linux-6.8.0-rc2+
> Created:      Fri Mar  1 13:31:36 2024
> Image Type:   SuperH Linux Kernel Image (gzip compressed)
> Data Size:    9297141 Bytes =3D 9079.24 KiB =3D 8.87 MiB
> Load Address: 08001000
> Entry Point:  08002000
>   Image arch/sh/boot/uImage is ready

Thanks a lot for pointing this out. This explains the problem.

I will have another look over the weekend and acknowledge the patch if Kees=
 wants
to pick it up through his own tree.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

