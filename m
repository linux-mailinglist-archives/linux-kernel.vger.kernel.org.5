Return-Path: <linux-kernel+bounces-35443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BEDE283913F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:21:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B26C31C25C90
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A915FBA6;
	Tue, 23 Jan 2024 14:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="PKayuLNr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iaeyMu9I"
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430415F858;
	Tue, 23 Jan 2024 14:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706019701; cv=none; b=OPJs9xME0cXRUlLLAhRFb+ARqA8Ewxpwat3jdiyIxavfu6qb2VoqovQZDpqg0syoqvvbb6gcrtpbm7L7w5wRrDeniihanq0vM0fsRmLlnDVKKJZyIsJgp69yzQi7NRVVC0l4+YSpMze1FzkqecV3LOxQDhvX+tkoH0kXemp5374=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706019701; c=relaxed/simple;
	bh=BWxFJ6f+lO7oLYsKbxzaJnDar3I13n2vm78DWeqz9IY=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=FGurJrD2FVc2LQPBukY/6oCCxfahRa/wu+ND5YE51PM39x/do822ysbdaIDpyaGZGCKCeQY2LlsLiAVZRqBJ4lFUV4SztbjbbyH2wBGyOqY26m6eoT3Lbm+PcLHTpVHLpjld4AZk/jh6iqfMOYDuouGM6byvOX+40+fXGMYrJLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=PKayuLNr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iaeyMu9I; arc=none smtp.client-ip=64.147.123.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id F2C013200A04;
	Tue, 23 Jan 2024 09:21:36 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 23 Jan 2024 09:21:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1706019696;
	 x=1706106096; bh=Wb2LadyDq3EncKOixdkKXF1xf+5ToI114DbbSpnU1nY=; b=
	PKayuLNrs/RNOnY9Pm3PTRTDtc1BuvHxlCD7DuFwY3X2d3w/3n1RTZ9LkQQmom3/
	w6idujhcC4sf3BbCM5+B3rKAeN6o49DZxzKkXiUHhjhwBc48BWX6QQG9FBbGrESz
	dY9isiD4klmX7hDZxIpR0XAo9bx2f3HmXbcXHrgnWu377wYBVGHNDJeydLYODUm3
	R2v4IQChjpBjq1THZkrhojBT62tPQZhhhJX7vhM3GS1LAQ5MUjk8AsVhFsBFrQgH
	doe9VBd2+6WHeaR4G96Yes5cYzvayqaI2fWvhDYf/ZZHo1Zb7cz6wduRTcnHpKrW
	6kE0Ci1RccWeYTA5fc/t/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1706019696; x=
	1706106096; bh=Wb2LadyDq3EncKOixdkKXF1xf+5ToI114DbbSpnU1nY=; b=i
	aeyMu9IQJm8viLVFcRG2+AfApl0inhRKl32d9bxe+ynOLxLBL2s/6xnBdR+sart7
	wAZAjiA4uL/DTaIWBboS2/YhhyDMgMYyxOQ4f604bM7uJzQt+e/9izTFd+xJifVo
	xQ50WHbYZD/V2ZAwYra6Pek4hm9CLQF0AsKq4BVdceSEFeVHgMY+a42IjHl2qdAC
	3tidNdDH6brWPgcA3qtQ97S9I8mHpThso03DUhwzCMsTMvIaulq1IZgWkWvjI17h
	qB/abhBsPAnPQnf0Ws70h0wwPbXzEqjR98NOYls5N0AIzgYtr4Y02V+Cwfh6GpX1
	RL81i2NKrtG69Wlsq/MXA==
X-ME-Sender: <xms:b8uvZZutZyYhjvm11xsbDHd-yctTohxrZ96EclPn7v7Uk295CAYxIA>
    <xme:b8uvZSdJ-DzXvh4tLWbWKsloyBAkMqIGhWu0zDscTRdh84QtuWV6_vntH6OGKUGWc
    o9tQr6gGnuPR811080>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdekkedgieduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpefgkeeuleegieeghfduudeltdekfeffjeeuleehleefudettddtgfevueef
    feeigeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:b8uvZcyHxEDFbucCwS_wdJTB7xZCjv4VpoI1kQNX4uuVdNYjj6sBQw>
    <xmx:b8uvZQOGooI-lZsO5yozfuK-_cjQpfLDCPfU0iE3UrR2Mn2j9dL4qQ>
    <xmx:b8uvZZ-FoQRRZFNwPBfm4zrKoG5PrhcOqTLtRYQnZkkS4F1E545I9g>
    <xmx:cMuvZdVu3pmkvuhw0wgTNHs20QG_zyCJ2SI5aNTi4b7I7-93_VGCkA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id C023DB6008D; Tue, 23 Jan 2024 09:21:35 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-119-ga8b98d1bd8-fm-20240108.001-ga8b98d1b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <0229fa60-2d87-4b1c-b9f0-6f04c6e4dbdd@app.fastmail.com>
In-Reply-To: <d03e90ca-8485-4d1b-5ec1-c3398e0e8da@linux-m68k.org>
References: 
 <CAHk-=wiB4iHTtfZKiy5pC24uOjun4fbj4kSX0=ZnGsOXadMf6g@mail.gmail.com>
 <20240123111235.3097079-1-geert@linux-m68k.org>
 <d03e90ca-8485-4d1b-5ec1-c3398e0e8da@linux-m68k.org>
Date: Tue, 23 Jan 2024 15:21:14 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Geert Uytterhoeven" <geert@linux-m68k.org>, linux-kernel@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-mtd@lists.infradead.org,
 mpi3mr-linuxdrv.pdl@broadcom.com, linux-scsi@vger.kernel.org,
 "Chris Zankel" <chris@zankel.net>, "Max Filippov" <jcmvbkbc@gmail.com>,
 linux-hardening@vger.kernel.org, qat-linux@intel.com,
 linux-crypto@vger.kernel.org,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 Netdev <netdev@vger.kernel.org>
Subject: Re: Build regressions/improvements in v6.8-rc1
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024, at 12:45, Geert Uytterhoeven wrote:

>> 68 error regressions:
>
>>  + /kisskb/src/arch/powerpc/sysdev/udbg_memcons.c: error: no previous=
 prototype for 'memcons_getc' [-Werror=3Dmissing-prototypes]:  =3D> 80:5
>>  + /kisskb/src/arch/powerpc/sysdev/udbg_memcons.c: error: no previous=
 prototype for 'memcons_getc_poll' [-Werror=3Dmissing-prototypes]:  =3D>=
 57:5
>>  + /kisskb/src/arch/powerpc/sysdev/udbg_memcons.c: error: no previous=
 prototype for 'memcons_putc' [-Werror=3Dmissing-prototypes]:  =3D> 44:6
>
> powerpc-gcc{5,12,13}/ppc64_book3e_allmodconfig

I now sent patches for powerpc booke warnings

>>  + /kisskb/src/arch/sh/kernel/cpu/init.c: error: no previous prototyp=
e for 'l2_cache_init' [-Werror=3Dmissing-prototypes]:  =3D> 99:29
>
> sh4-gcc1[123]/se7{619,750}_defconfig
> sh4-gcc1[123]/sh-{all{mod,no,yes},def}config
> sh4-gcc11/sh-allnoconfig

I assume the sh maintainers will eventually get to that

>>  + /kisskb/src/arch/sparc/include/asm/floppy_64.h: error: no previous=
 prototype for 'sparc_floppy_irq' [-Werror=3Dmissing-prototypes]:  =3D> =
200:13
>>  + /kisskb/src/arch/sparc/include/asm/floppy_64.h: error: no previous=
 prototype for 'sun_pci_fd_dma_callback' [-Werror=3Dmissing-prototypes]:=
  =3D> 437:6
>
> sparc64-gcc{5,11,12,13}/sparc64-allmodconfig

Andrew Morton did a patch for the sparc warnings, and Andreas Larsson
is joining as a maintainer, so hopefully he can pick that up soon.
> sparc64-gcc{5,1[123]}/sparc64-allmodconfig
>
>>  + /kisskb/src/arch/sparc/vdso/vclock_gettime.c: error: no previous p=
rototype for '__vdso_clock_gettime' [-Werror=3Dmissing-prototypes]:  =3D=
> 254:1
>>  + /kisskb/src/arch/sparc/vdso/vclock_gettime.c: error: no previous p=
rototype for '__vdso_clock_gettime_stick' [-Werror=3Dmissing-prototypes]=
:  =3D> 282:1
>>  + /kisskb/src/arch/sparc/vdso/vclock_gettime.c: error: no previous p=
rototype=20

There are prototypes in include/vdso/gettime.h that should be
used here, but unfortunately the sparc implementation does
not match the prototypes because sparc is missing the gettime64
support.

> sparc64-gcc{5,12,13}/sparc64-{allno,def}config
> sparc64-gcc11/sparc64-{all{mod,no},def}config
>
>>  + /kisskb/src/arch/x86/um/shared/sysdep/kernel-offsets.h: error: no =
previous prototype for =E2=80=98foo=E2=80=99 [-Werror=3Dmissing-prototyp=
es]:  =3D> 9:6
>
> um-x86_64-gcc12/um-{all{mod,yes},def}config

I made a patch for arch/um yesterday.

> sparc64-gcc1[12]/sparc64-allmodconfig
>
>>  + /kisskb/src/drivers/scsi/mpi3mr/mpi3mr_transport.c: error: the fra=
me size of 1680 bytes is larger than 1536 bytes [-Werror=3Dframe-larger-=
than=3D]:  =3D> 1818:1

I sent a patch in November when the regression started, missed
the reply about needing another change
https://lore.kernel.org/all/CAFdVvOxH4UQjww4124E2ttuTgknzkHoPxVSFOQgLfoV=
_dkANwQ@mail.gmail.com/

>>  + {standard input}: Error: displacement to undefined symbol .L105 ov=
erflows 8-bit field :  =3D> 590, 593
>>  + {standard input}: Error: displacement to undefined symbol .L135 ov=
erflows 8-bit field :  =3D> 603
>>  + {standard input}: Error: displacement to undefined symbol .L140 ov=
erflows 8-bit field :  =3D> 606
>>  + {standard input}: Error: displacement to undefined symbol .L76 ove=
rflows 12-bit field:  =3D> 591, 594
>>  + {standard input}: Error: displacement to undefined symbol .L77 ove=
rflows 8-bit field : 607 =3D> 607, 582, 585
>>  + {standard input}: Error: displacement to undefined symbol .L97 ove=
rflows 12-bit field:  =3D> 607
>>  + {standard input}: Error: pcrel too far: 604, 590, 577, 593, 572, 5=
69, 598, 599, 596, 610 =3D> 610, 574, 599, 569, 598, 596, 601, 590, 604,=
 595, 572, 577, 593
>
> SH ICE crickets

Linus did a patch for the syscall, and I sent another one for
arch/sh to prevent this from happening again:

https://lore.kernel.org/all/CAHk-=3Dwjh6Cypo8WC-McXgSzCaou3UXccxB+7PVeSu=
GR8AjCphg@mail.gmail.com/
https://lore.kernel.org/all/07d8877b-d933-46f4-8ca4-c10ed602f37e@app.fas=
tmail.com/

Resent mine now.

      Arnd

