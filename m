Return-Path: <linux-kernel+bounces-43300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F7F98411E4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 19:16:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21DA1B268A4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 18:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC936F06B;
	Mon, 29 Jan 2024 18:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P6KeVEXS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DA73F9FC
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 18:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706552177; cv=none; b=Rklgu5FGnZJQ3yIYCXABOLP57utNp2gk8ZldY6NRiJLJ/FrIgeB8MVxdqiaM5kUR6SVxLK5n+ImX6Xklp7t6z70tLoSRxSSrVHYy+YZJhJ/QacE7XLoOJfOeH4dxNW1wl2SzxYkVHxJX7SzxvpBQ7Q3YqhuEdWJE9vGi9QMBL5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706552177; c=relaxed/simple;
	bh=4eYLj/Lm5IOPUr7af+2C6a/UQ1OO1uxY23YBH7rnuMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tHGv59MlwtfbuaeAHDEvEtlZauyhVvcCMBH7I80Mqpqo7seG0/+DZyzV7hOrUHM9OVhM79k7tXP6WvdETJFSzy57gXDpfrr1MLEDiiFtCrurahnM6jDQFL33x+lfWTgY067pFEQuBWcwP1Glyfw+ugiBsbTG5gWXCJokc8SpubQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P6KeVEXS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DE0AC43390;
	Mon, 29 Jan 2024 18:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706552177;
	bh=4eYLj/Lm5IOPUr7af+2C6a/UQ1OO1uxY23YBH7rnuMQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P6KeVEXSToGyeem1pchNMajeFGtoD9G9sIiQiQEfXKACNlusnFQ+nElZ28J5l1dTf
	 2lHc6BUcIcO94lv0eiRCXRNh0PlwylRLi2AunxuduIesrx0mL3dkIJk6lK8Ve6bEu3
	 5MBuCN43X5Ny0/9blfPv5VhHJ+Tfi2JuTdxn/UpCS5yrXTcy70VDCmLzt0ONykvGWB
	 kGKs+4RzzGHSW+Vl8Y66WkEPa99kpss/UvoaBlITv7TiXCtcippQI836W5nadNMS4u
	 tDu+oKcjn7DlPvMBaJNzYGrlLGtpCvdWDh1Ena/LF8pHJAQHApmlpohzNX0zey340P
	 VBAHcZ7w/z/mA==
Date: Mon, 29 Jan 2024 18:16:13 +0000
From: Conor Dooley <conor@kernel.org>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] riscv: optimize memcpy/memmove/memset
Message-ID: <20240129-prelaw-tweet-ae59a90ded20@spud>
References: <20240128111013.2450-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="d1n2JiHAv+OvTEWE"
Content-Disposition: inline
In-Reply-To: <20240128111013.2450-1-jszhang@kernel.org>


--d1n2JiHAv+OvTEWE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 28, 2024 at 07:10:10PM +0800, Jisheng Zhang wrote:
> This series is to renew Matteo's "riscv: optimized mem* functions"
> sereies.
>=20
> Compared with Matteo's original series, Jisheng made below changes:
> 1. adopt Emil's change to fix boot failure when build with clang
> 2. add corresponding changes to purgatory
> 3. always build optimized string.c rather than only build when optimize
> for performance
> 4. implement unroll support when src & dst are both aligned to keep
> the same performance as assembly version. After disassembling, I found
> that the unroll version looks something like below, so it acchieves
> the "unroll" effect as asm version but in C programming language:
> 	ld	t2,0(a5)
> 	ld	t0,8(a5)
> 	ld	t6,16(a5)
> 	ld	t5,24(a5)
> 	ld	t4,32(a5)
> 	ld	t3,40(a5)
> 	ld	t1,48(a5)
> 	ld	a1,56(a5)
> 	sd	t2,0(a6)
> 	sd	t0,8(a6)
> 	sd	t6,16(a6)
> 	sd	t5,24(a6)
> 	sd	t4,32(a6)
> 	sd	t3,40(a6)
> 	sd	t1,48(a6)
> 	sd	a1,56(a6)
> And per my testing, unrolling more doesn't help performance, so
> the "c" version only unrolls by using 8 GP regs rather than 16
> ones as asm version.
> 5. Add proper __pi_memcpy and __pi___memcpy alias
> 6. more performance numbers.
>=20
> Per my benchmark with [1] on TH1520, CV1800B and JH7110 platforms,
> the unaligned medium memcpy performance is running about 3.5x ~ 8.6x
> speed of the unpatched versions's! Check patch1 for more details and
> performance numbers.
>=20
> Link:https://github.com/ARM-software/optimized-routines/blob/master/strin=
g/bench/memcpy.c [1]
>=20
> Here is the original cover letter msg from Matteo:
> Replace the assembly mem{cpy,move,set} with C equivalent.
>=20
> Try to access RAM with the largest bit width possible, but without
> doing unaligned accesses.
>=20
> A further improvement could be to use multiple read and writes as the
> assembly version was trying to do.
>=20
> Tested on a BeagleV Starlight with a SiFive U74 core, where the
> improvement is noticeable.

However, with allmodconfig it doesn't compile:
  Redirect to /build/tmp.zzMIlhgQQo and /build/tmp.vxnoxu8G5e
  Tree base:
  0c526539d432 ("riscv: optimized memcpy")
  Building the whole tree with the patch
  ../arch/riscv/lib/string.c:118:7: error: expected identifier or '('
  ../arch/riscv/lib/string.c:118:7: error: expected ')'
  ../arch/riscv/lib/string.c:143:7: error: expected identifier or '('
  ../arch/riscv/lib/string.c:143:7: error: expected ')'
  ../arch/riscv/lib/string.c:118:7: error: expected identifier or '('
  ../arch/riscv/lib/string.c:118:7: error: expected ')'
  ../arch/riscv/lib/string.c:143:7: error: expected identifier or '('
  ../arch/riscv/lib/string.c:143:7: error: expected ')'

Seems to be the case both with llvm and gcc.

Cheers,
Conor.


--d1n2JiHAv+OvTEWE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZbfrbQAKCRB4tDGHoIJi
0tfSAP9CXefieMdiPqbq7pdjY+14U99AxgMlsgdjf8Ba7tagMQD/bq4CepFhnrUJ
AmdXmVbmVEhI6YWXz3uuEssFY1Sg5A4=
=DP0s
-----END PGP SIGNATURE-----

--d1n2JiHAv+OvTEWE--

