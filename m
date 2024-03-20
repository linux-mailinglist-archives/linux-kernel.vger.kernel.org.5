Return-Path: <linux-kernel+bounces-108592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F3F880CB5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 09:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AC431F22E59
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 08:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A51C2C69A;
	Wed, 20 Mar 2024 08:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="hHH5DxSY"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9540936AE4;
	Wed, 20 Mar 2024 08:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710922055; cv=none; b=AwpomJLlI3y44aR68fmUeyAjXw9/NbfSeOMP5loJmvHg5SfN42PkoZjMdCfCXZ8ZklmAMfBxVFv8JvcDOtPloTF4yO2uV55FCFp2vb0WQWfVJBRCfPgeEp2cyNrYl9my2hMrYsrKkEtOW9Cm1PqGrUJbgJEInamP8hB4RlU7G5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710922055; c=relaxed/simple;
	bh=8s8XKGkGT4rwQeAawGzZEkGeS8AnzqsL4K//1R+zt5Q=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ah4pTubxMI3wIf5XoYR0a4LBB1wosag+zNUMJdvn5H3/IjtetmPIuKxQ2xyNwViNYSGNR+mXb1pibdpJ3bgDYDUzWbmUl8pIwL9TR88quXUEYHNthIdPJjlNrTyHJ5RMF0l1eyGrdnPJR2M3UbbDeoIL6NX67bvXzHOpA7m9Td8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=hHH5DxSY; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1710922054; x=1742458054;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8s8XKGkGT4rwQeAawGzZEkGeS8AnzqsL4K//1R+zt5Q=;
  b=hHH5DxSY/R/+5ju6Tu8yndEmtunuKsBNmB260zQ3AYGzWDXV/7XBbvHP
   Sy1oIN3vxCAEhRW/Nj1GWRpi/beHVw0bW3SHbvOzFtyUHxv3X/OjFvdff
   0ra9jz4Zq9TIjNFUjz/Wh1SKTv44ZjToDiLBFKAksqGu7par804adSnnZ
   FwcFP32gvuiGVgb0H7xHaRZ9vNcBABNHUZj9v+KuV417vuSTT8x2SQZvj
   mUKn7QBMF+zP+2haC5OaXnGifBPBYqDx8SKIy7twNO+mwGb1uByJWVIt/
   yz8fqyYXwU+Wd8p1LE2PlP6O5BctCQjYvpDjCB27AHQHTz0/ia9x5qBbF
   Q==;
X-CSE-ConnectionGUID: +2PKfpLTQGq2m0SEBNMVqQ==
X-CSE-MsgGUID: eSxs2JbuTmyaJCQMbacMkA==
X-IronPort-AV: E=Sophos;i="6.07,139,1708412400"; 
   d="asc'?scan'208";a="248659095"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Mar 2024 01:07:30 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 20 Mar 2024 01:07:10 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex04.mchp-main.com (10.10.85.152)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Wed, 20 Mar 2024 01:07:07 -0700
Date: Wed, 20 Mar 2024 08:06:20 +0000
From: Conor Dooley <conor.dooley@microchip.com>
To: Samuel Holland <samuel.holland@sifive.com>
CC: Deepak Gupta <debug@rivosinc.com>, Palmer Dabbelt <palmer@dabbelt.com>,
	<linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>, Catalin
 Marinas <catalin.marinas@arm.com>, <linux-kernel@vger.kernel.org>, Conor
 Dooley <conor@kernel.org>, <kasan-dev@googlegroups.com>, Evgenii Stepanov
	<eugenis@google.com>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Rob Herring <robh+dt@kernel.org>, Andrew
 Jones <ajones@ventanamicro.com>, Guo Ren <guoren@kernel.org>, Heiko Stuebner
	<heiko@sntech.de>, Paul Walmsley <paul.walmsley@sifive.com>
Subject: Re: [RISC-V] [tech-j-ext] [RFC PATCH 5/9] riscv: Split per-CPU and
 per-thread envcfg bits
Message-ID: <20240320-fanfare-flick-3b38dde081d8@wendy>
References: <20240319215915.832127-1-samuel.holland@sifive.com>
 <20240319215915.832127-6-samuel.holland@sifive.com>
 <CAKC1njSg9-hJo6hibcM9a-=FUmMWyR39QUYqQ1uwiWhpBZQb9A@mail.gmail.com>
 <40ab1ce5-8700-4a63-b182-1e864f6c9225@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZQuW/bL/DNtzlQCx"
Content-Disposition: inline
In-Reply-To: <40ab1ce5-8700-4a63-b182-1e864f6c9225@sifive.com>

--ZQuW/bL/DNtzlQCx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 09:20:59PM -0500, Samuel Holland wrote:
> On 2024-03-19 6:55 PM, Deepak Gupta wrote:
> > On Tue, Mar 19, 2024 at 2:59=E2=80=AFPM Samuel Holland via lists.riscv.=
org
> > <samuel.holland=3Dsifive.com@lists.riscv.org> wrote:
> >>
> >> Some envcfg bits need to be controlled on a per-thread basis, such as
> >> the pointer masking mode. However, the envcfg CSR value cannot simply =
be
> >> stored in struct thread_struct, because some hardware may implement a
> >> different subset of envcfg CSR bits is across CPUs. As a result, we ne=
ed
> >> to combine the per-CPU and per-thread bits whenever we switch threads.
> >>
> >=20
> > Why not do something like this
> >=20
> > diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
> > index b3400517b0a9..01ba87954da2 100644
> > --- a/arch/riscv/include/asm/csr.h
> > +++ b/arch/riscv/include/asm/csr.h
> > @@ -202,6 +202,8 @@
> >  #define ENVCFG_CBIE_FLUSH              _AC(0x1, UL)
> >  #define ENVCFG_CBIE_INV                        _AC(0x3, UL)
> >  #define ENVCFG_FIOM                    _AC(0x1, UL)
> > +/* by default all threads should be able to zero cache */
> > +#define ENVCFG_BASE                    ENVCFG_CBZE
>=20
> Linux does not assume Sstrict, so without Zicboz being present in DT/ACPI=
, we
> have no idea what the CBZE bit does--there's no guarantee it has the stan=
dard
> meaning--so it's not safe to set the bit unconditionally. If that policy
> changes, we could definitely simplify the code.

The wording for that "extension", if two lines in the profiles doc makes
something an extension is:
"No non-conforming extensions are present. Attempts to execute unimplemented
opcodes or access unimplemented CSRs in the standard or reserved encoding
spaces raises an illegal instruction exception that results in a contained
trap to the supervisor-mode trap handler."

I know we have had new extensions come along and mark previously fair
game interrupts for vendors as out of bounds. I wonder if there's a risk
of that happening with CSRs or opcodes too (or maybe it has happened and
I cannot recall).

Going back to the interrupts - is the Andes PMU non-conforming because
it uses an interrupt that was declared as vendor usable but is now part
of the standard space because of AIA? If it is, then the meaning of
Sstrict could vary wildly based on the set of extensions (and their
versions for specs). That sounds like a lot of fun.

--ZQuW/bL/DNtzlQCx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZfqY/AAKCRB4tDGHoIJi
0m4/AP0UYPz9RdNLmW6g7L1tf8w83wsWZfBkuwZqh3A3w0Jq9wEA7t8mWVQ1YVm2
D9FdG5Y2+4p6MzgZJDv6xF67VncJZAU=
=unOr
-----END PGP SIGNATURE-----

--ZQuW/bL/DNtzlQCx--

