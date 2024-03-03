Return-Path: <linux-kernel+bounces-89681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC29E86F41A
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 09:48:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70962282FDC
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 08:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A836FAD32;
	Sun,  3 Mar 2024 08:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="ZtIUucJH"
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F0D10E6;
	Sun,  3 Mar 2024 08:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709455690; cv=none; b=Oxt1sDs713I01w5XnsAKzize7tONQ8YzUgjL940uyvY5AIEVZCYnveOuH2mV7jj/2QfSwtkL38IV1OvtNGJAhXgcaeP0ehzEmexUNM/9G588zimTJyNRPYvL0bfzlPWApXqzzedL7x4IaT64K8NPI0JgHh2EfdGl3EfGOhdI5H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709455690; c=relaxed/simple;
	bh=Gv1iB9/klBsQcszgsagn4nngUZ9spriYr0Hq9I0tzrg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SlWM2RWLaKp4voZAUkDnwIRAJMNytKtcvOkG+vhsZ8qVYI6TvVdRhLXVDXBxHUypg6geBdrYLPaRVhmCaEbNlIzI/QN0K6BOXPuHs3c7gSv6s17xxXWL0UOOR5Uw7xaznqV6/JJ/Iju4iRDqysFkUlkM5gpXO97KFlG8NwJxVW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=ZtIUucJH; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1709455686;
	bh=Gv1iB9/klBsQcszgsagn4nngUZ9spriYr0Hq9I0tzrg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=ZtIUucJHPHIWN1FbeK3l5zBEN1OBLmLEjcmlrRBPBtGVdLB8Zo6oZLCNhBgReurbe
	 IO0A85mv8Re0QTITHPBXofwwesV/AHOL1WfNQ5OkTiJSvFkESirJtW1bHsfYOWa/JJ
	 2HRCuJ1dKFd6t8eH6tWR4yGUOJNNSnsRR6SaSA5o=
Received: from [127.0.0.1] (unknown [IPv6:2001:470:683e::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id CA38F66FDE;
	Sun,  3 Mar 2024 03:48:03 -0500 (EST)
Message-ID: <64b50846602e0c4474edee2f3aaafa107527c93e.camel@xry111.site>
Subject: Re: [PATCH v8 4/4] riscv: dts: thead: Enable LicheePi 4A eMMC and
 microSD
From: Xi Ruoyao <xry111@xry111.site>
To: Drew Fustini <dfustini@tenstorrent.com>
Cc: Drew Fustini <dfustini@baylibre.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Jisheng Zhang <jszhang@kernel.org>, Guo Ren
 <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, Conor Dooley
 <conor@kernel.org>,  Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Jason Kridner
 <jkridner@beagleboard.org>, Robert Nelson <robertcnelson@beagleboard.org>, 
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org
Date: Sun, 03 Mar 2024 16:48:02 +0800
In-Reply-To: <ZeNS/g97JetYgXny@x1>
References: <20231206-th1520_mmc_dts-v8-0-69220e373e8f@baylibre.com>
	 <20231206-th1520_mmc_dts-v8-4-69220e373e8f@baylibre.com>
	 <110fa8d6be78a26ca21cd97c55903f5d62776430.camel@xry111.site>
	 <ZeNS/g97JetYgXny@x1>
Autocrypt: addr=xry111@xry111.site; prefer-encrypt=mutual;
 keydata=mDMEYnkdPhYJKwYBBAHaRw8BAQdAsY+HvJs3EVKpwIu2gN89cQT/pnrbQtlvd6Yfq7egugi0HlhpIFJ1b3lhbyA8eHJ5MTExQHhyeTExMS5zaXRlPoiTBBMWCgA7FiEEkdD1djAfkk197dzorKrSDhnnEOMFAmJ5HT4CGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgkQrKrSDhnnEOPHFgD8D9vUToTd1MF5bng9uPJq5y3DfpcxDp+LD3joA3U2TmwA/jZtN9xLH7CGDHeClKZK/ZYELotWfJsqRcthOIGjsdAPuDgEYnkdPhIKKwYBBAGXVQEFAQEHQG+HnNiPZseiBkzYBHwq/nN638o0NPwgYwH70wlKMZhRAwEIB4h4BBgWCgAgFiEEkdD1djAfkk197dzorKrSDhnnEOMFAmJ5HT4CGwwACgkQrKrSDhnnEOPjXgD/euD64cxwqDIqckUaisT3VCst11RcnO5iRHm6meNIwj0BALLmWplyi7beKrOlqKfuZtCLbiAPywGfCNg8LOTt4iMD
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2024-03-02 at 08:25 -0800, Drew Fustini wrote:
> On Sat, Mar 02, 2024 at 10:13:55PM +0800, Xi Ruoyao wrote:
> > On Wed, 2023-12-06 at 00:09 -0800, Drew Fustini wrote:
> > > Add emmc node properties for the eMMC device and add sdio0 node
> > > properties for the microSD slot. Set the frequency for the sdhci
> > > reference clock.
> >=20
> > Hi Drew,
> >=20
> > I've been using the emmc on LicheePi 4A for a while without any problem=
,
> > but when I try the microSD slot I get:
> >=20
> > [=C2=A0=C2=A0=C2=A0 0.531804] mmc1: SDHCI controller on ffe7090000.mmc =
[ffe7090000.mmc] using ADMA 64-bit
> > [=C2=A0=C2=A0=C2=A0 0.842674] mmc1: Tuning failed, falling back to fixe=
d sampling clock
> > [=C2=A0=C2=A0=C2=A0 0.855139] mmc1: tuning execution failed: -5
> > [=C2=A0=C2=A0=C2=A0 0.859609] mmc1: error -5 whilst initialising SD car=
d
> > [=C2=A0=C2=A0 11.359879] mmc1: Timeout waiting for hardware cmd interru=
pt.
> > [=C2=A0=C2=A0 11.365661] mmc1: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D SDHCI REGISTER DUMP =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > [=C2=A0=C2=A0 11.372105] mmc1: sdhci: Sys addr:=C2=A0 0x00000001 | Vers=
ion:=C2=A0 0x00000005
> > [=C2=A0=C2=A0 11.378547] mmc1: sdhci: Blk size:=C2=A0 0x00007040 | Blk =
cnt:=C2=A0 0x00000000
> > [=C2=A0=C2=A0 11.384989] mmc1: sdhci: Argument:=C2=A0 0x00000000 | Trn =
mode: 0x00000010
> > [=C2=A0=C2=A0 11.391432] mmc1: sdhci: Present:=C2=A0=C2=A0 0x03ff0000 |=
 Host ctl: 0x00000017
> > [=C2=A0=C2=A0 11.397873] mmc1: sdhci: Power:=C2=A0=C2=A0=C2=A0=C2=A0 0x=
0000000f | Blk gap:=C2=A0 0x00000000
> > [=C2=A0=C2=A0 11.404312] mmc1: sdhci: Wake-up:=C2=A0=C2=A0 0x00000000 |=
 Clock:=C2=A0=C2=A0=C2=A0 0x0000000f
> > [=C2=A0=C2=A0 11.410753] mmc1: sdhci: Timeout:=C2=A0=C2=A0 0x00000004 |=
 Int stat: 0x00000000
> > [=C2=A0=C2=A0 11.417192] mmc1: sdhci: Int enab:=C2=A0 0x00000020 | Sig =
enab: 0x00000020
> > [=C2=A0=C2=A0 11.423633] mmc1: sdhci: ACmd stat: 0x00000000 | Slot int:=
 0x00000000
> > [=C2=A0=C2=A0 11.430073] mmc1: sdhci: Caps:=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 0x3f69c881 | Caps_1:=C2=A0=C2=A0 0x08008177
> > [=C2=A0=C2=A0 11.436513] mmc1: sdhci: Cmd:=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 0x00000102 | Max curr: 0x00191919
> > [=C2=A0=C2=A0 11.442954] mmc1: sdhci: Resp[0]:=C2=A0=C2=A0 0x00000900 |=
 Resp[1]:=C2=A0 0x07725f7f
> > [=C2=A0=C2=A0 11.449394] mmc1: sdhci: Resp[2]:=C2=A0=C2=A0 0x32db7900 |=
 Resp[3]:=C2=A0 0x00400e00
> > [=C2=A0=C2=A0 11.455835] mmc1: sdhci: Host ctl2: 0x0000300b
> > [=C2=A0=C2=A0 11.460280] mmc1: sdhci: ADMA Err:=C2=A0 0x00000000 | ADMA=
 Ptr: 0x0000000000882220
> > [=C2=A0=C2=A0 11.467416] mmc1: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> > [=C2=A0=C2=A0 11.563828] mmc1: Tuning failed, falling back to fixed sam=
pling clock
> > [=C2=A0=C2=A0 11.576053] mmc1: tuning execution failed: -5
> > [=C2=A0=C2=A0 11.646438] mmc1: new high speed SDXC card at address aaaa
> > [=C2=A0=C2=A0 11.653170] mmcblk1: mmc1:aaaa SR256 238 GiB
> >=20
> > I can write something into the SD card and read it back though.=C2=A0 B=
ut
> > this makes me reluctant to use the SD card for "some real thing" afraid
> > of a data loss.
> >=20
> > The SD card is a SanDisk Extreme Pro 256GB (rated "U3, A2, V30").
> >=20
> > Any idea how to debug this issue further?=C2=A0 (Maybe I should try cha=
nge
> > the SD card first but I'd like to discuss the issue before paying money
> > for another card.)
>=20
> Revy informed me that downclocking from 198 MHz to 100 MHz [1] has been
> observed to solve this problem. Could you try the following dts patch?

I'm still getting the same error.

> Also, I have noticed the T-Head's 5.10 vendor kernel does have some
> updates in sdhci-of-dwcmshc.c related to tuning. I'll look at porting
> those to the upstream driving.

Maybe to solve the problem we need both the downclocking and these
changes then...

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

