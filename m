Return-Path: <linux-kernel+bounces-89462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA6F886F0A7
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 15:14:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EEA21F21A4B
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 14:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C4117BDF;
	Sat,  2 Mar 2024 14:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="lVTcx+js"
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1EC917573;
	Sat,  2 Mar 2024 14:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709388845; cv=none; b=uBOUqjQeXSfgBgtXk2L0CoyoBqw0YkEf35iwXTVoUPvCncd9UwfLjG3sBNie3i/k405ScI3e82lzpaGDisxGDQKkz7n7wZNvkI3x5wFqLckj14phMNwE8oI0/OmHd4qZBahpj+cDSkLBavXsMITSO0S8egMlF+kUPQMEA3+TMog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709388845; c=relaxed/simple;
	bh=rrs7FTnn5zBbVusszKQ43BrCp14rs9R6rlivEgH7f50=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K1l6FPeK+N5HeKok6Y5XO+pmGol9qHIrRGs4unCNOzT9qzPMA9uprhtABBwRcIRORaJTRLgqc4IMnN4aFhQa0wWJ9msm51aWEcYpZ8NWunqi2s1w8YdJyfTeR39/BCwKDWnN1P6hzS7Q3MNclSV6fNZnzSvMjxSVRxXWqQkPLlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=lVTcx+js; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1709388840;
	bh=rrs7FTnn5zBbVusszKQ43BrCp14rs9R6rlivEgH7f50=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=lVTcx+jsGLuJR11oql/QnfWS3jjbEP8a5/zlWwYoC+FHZnei9srvrgdW9IH1WkzQe
	 ppyNY4UBWnKZlEXNFuruHrQymD0WOnE3CxHu1kY7AeJ20LaEQXby6ND544Vi21k+6T
	 KFC42n6IiUbcLE073jvAa2FovXzOa4aHx5SXz11M=
Received: from [127.0.0.1] (unknown [IPv6:2001:470:683e::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id DDCBC66B29;
	Sat,  2 Mar 2024 09:13:57 -0500 (EST)
Message-ID: <110fa8d6be78a26ca21cd97c55903f5d62776430.camel@xry111.site>
Subject: Re: [PATCH v8 4/4] riscv: dts: thead: Enable LicheePi 4A eMMC and
 microSD
From: Xi Ruoyao <xry111@xry111.site>
To: Drew Fustini <dfustini@baylibre.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Jisheng Zhang <jszhang@kernel.org>, Guo Ren
 <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, Conor Dooley
 <conor@kernel.org>,  Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>
Cc: Jason Kridner <jkridner@beagleboard.org>, Robert Nelson
	 <robertcnelson@beagleboard.org>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Date: Sat, 02 Mar 2024 22:13:55 +0800
In-Reply-To: <20231206-th1520_mmc_dts-v8-4-69220e373e8f@baylibre.com>
References: <20231206-th1520_mmc_dts-v8-0-69220e373e8f@baylibre.com>
	 <20231206-th1520_mmc_dts-v8-4-69220e373e8f@baylibre.com>
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

On Wed, 2023-12-06 at 00:09 -0800, Drew Fustini wrote:
> Add emmc node properties for the eMMC device and add sdio0 node
> properties for the microSD slot. Set the frequency for the sdhci
> reference clock.

Hi Drew,

I've been using the emmc on LicheePi 4A for a while without any problem,
but when I try the microSD slot I get:

[    0.531804] mmc1: SDHCI controller on ffe7090000.mmc [ffe7090000.mmc] us=
ing ADMA 64-bit
[    0.842674] mmc1: Tuning failed, falling back to fixed sampling clock
[    0.855139] mmc1: tuning execution failed: -5
[    0.859609] mmc1: error -5 whilst initialising SD card
[   11.359879] mmc1: Timeout waiting for hardware cmd interrupt.
[   11.365661] mmc1: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D SDHCI REGI=
STER DUMP =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   11.372105] mmc1: sdhci: Sys addr:  0x00000001 | Version:  0x00000005
[   11.378547] mmc1: sdhci: Blk size:  0x00007040 | Blk cnt:  0x00000000
[   11.384989] mmc1: sdhci: Argument:  0x00000000 | Trn mode: 0x00000010
[   11.391432] mmc1: sdhci: Present:   0x03ff0000 | Host ctl: 0x00000017
[   11.397873] mmc1: sdhci: Power:     0x0000000f | Blk gap:  0x00000000
[   11.404312] mmc1: sdhci: Wake-up:   0x00000000 | Clock:    0x0000000f
[   11.410753] mmc1: sdhci: Timeout:   0x00000004 | Int stat: 0x00000000
[   11.417192] mmc1: sdhci: Int enab:  0x00000020 | Sig enab: 0x00000020
[   11.423633] mmc1: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000000
[   11.430073] mmc1: sdhci: Caps:      0x3f69c881 | Caps_1:   0x08008177
[   11.436513] mmc1: sdhci: Cmd:       0x00000102 | Max curr: 0x00191919
[   11.442954] mmc1: sdhci: Resp[0]:   0x00000900 | Resp[1]:  0x07725f7f
[   11.449394] mmc1: sdhci: Resp[2]:   0x32db7900 | Resp[3]:  0x00400e00
[   11.455835] mmc1: sdhci: Host ctl2: 0x0000300b
[   11.460280] mmc1: sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 0x00000000008=
82220
[   11.467416] mmc1: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
[   11.563828] mmc1: Tuning failed, falling back to fixed sampling clock
[   11.576053] mmc1: tuning execution failed: -5
[   11.646438] mmc1: new high speed SDXC card at address aaaa
[   11.653170] mmcblk1: mmc1:aaaa SR256 238 GiB

I can write something into the SD card and read it back though.  But
this makes me reluctant to use the SD card for "some real thing" afraid
of a data loss.

The SD card is a SanDisk Extreme Pro 256GB (rated "U3, A2, V30").

Any idea how to debug this issue further?  (Maybe I should try change
the SD card first but I'd like to discuss the issue before paying money
for another card.)

> Signed-off-by: Drew Fustini <dfustini@baylibre.com>
> ---
> =C2=A0.../boot/dts/thead/th1520-lichee-module-4a.dtsi=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 20 ++++++++++++++++++++
> =C2=A01 file changed, 20 insertions(+)
>=20
> diff --git a/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi b/arc=
h/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi
> index a802ab110429..1365d3a512a3 100644
> --- a/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi
> +++ b/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi
> @@ -29,6 +29,10 @@ &apb_clk {
> =C2=A0	clock-frequency =3D <62500000>;
> =C2=A0};
> =C2=A0
> +&sdhci_clk {
> +	clock-frequency =3D <198000000>;
> +};
> +
> =C2=A0&uart_sclk {
> =C2=A0	clock-frequency =3D <100000000>;
> =C2=A0};
> @@ -36,3 +40,19 @@ &uart_sclk {
> =C2=A0&dmac0 {
> =C2=A0	status =3D "okay";
> =C2=A0};
> +
> +&emmc {
> +	bus-width =3D <8>;
> +	max-frequency =3D <198000000>;
> +	mmc-hs400-1_8v;
> +	non-removable;
> +	no-sdio;
> +	no-sd;
> +	status =3D "okay";
> +};
> +
> +&sdio0 {
> +	bus-width =3D <4>;
> +	max-frequency =3D <198000000>;
> +	status =3D "okay";
> +};

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

