Return-Path: <linux-kernel+bounces-160887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56EFF8B440C
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 06:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD6701F225EC
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 04:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8833C6BA;
	Sat, 27 Apr 2024 04:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="WbB+5zsh"
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B473BBEC
	for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 04:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714191217; cv=none; b=F5pTPGSmaAUnvuxFgdkXuoxoMw99xrKM+OUzIV3lOaFa5OBXElyuwym+SanbXUsBfqbBlF2tKSJFJ1BQi16eqbBnJPFsYqumpG3IiVIDn2H6nIkuYHjyZ+73JAmzWXViQsrK8OB6T2VbDr/BSmQ3moGqeGgvqq0Gn6M9UOTlSQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714191217; c=relaxed/simple;
	bh=L/SdhhR7cp15PtzHTJRI4OjluANgzw2oKI5pziWzQwU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BRyIhOVvPnidVGjsHdIb2zSTA9jhPsPpP5NPl+AR/dXnPIS+EL+7bqfpdNzRCiI7neZQ2dHz5fvcTyqibkc045TZID3h5HPRPpBR+YSzDPcZOU0PMv8rmPDQTnLzi73ZC0ZrG4G+BXM9eNN9LQ+eiyn6gocZo/CKrcrns6sPXYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=WbB+5zsh; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1714191213;
	bh=L/SdhhR7cp15PtzHTJRI4OjluANgzw2oKI5pziWzQwU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=WbB+5zshh8lGx3TUlvTH9+9y9sU+Jcqd0LicWcF2Zpd54kH+mbNdq6nUBO9yFsMnd
	 Jsf49g3V88xpeA4ZRCB33YjyMiFR2heDNs3usP7nqB91ka4LZYHBrsdGkkqL8FR960
	 o+6eEvEpB2hodKlX2i2ZXOjSi9WtkjLghPytUNAE=
Received: from [IPv6:240e:358:1198:0:dc73:854d:832e:4] (unknown [IPv6:240e:358:1198:0:dc73:854d:832e:4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 77B946591C;
	Sat, 27 Apr 2024 00:13:31 -0400 (EDT)
Message-ID: <56414029e179d219442bde9b8eae81fa3e3ceec4.camel@xry111.site>
Subject: Re: [PATCH] LoongArch: Provide __lshrti3, __ashrti3, and __ashrti3
From: Xi Ruoyao <xry111@xry111.site>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Tiezhu Yang <yangtiezhu@loongson.cn>
Date: Sat, 27 Apr 2024 12:13:25 +0800
In-Reply-To: <dfdc9823a0b89c8582587fa75448bba5c3a7e15e.camel@xry111.site>
References: <20240426121442.882029-1-xry111@xry111.site>
	 <CAAhV-H74cQ4XdDez5PipCxUZTpfS=CA6azL5qob=jGGebobD6g@mail.gmail.com>
	 <dfdc9823a0b89c8582587fa75448bba5c3a7e15e.camel@xry111.site>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2024-04-27 at 12:00 +0800, Xi Ruoyao wrote:
> On Sat, 2024-04-27 at 10:50 +0800, Huacai Chen wrote:
> > Hi, Ruoyao,
> >=20
> > I don't think #ifdef CONFIG_ARCH_SUPPORTS_INT128 is needed here.
> > S390/ARM64/RISCV all built it unconditionally.
>=20
> The problem here is RISCV and ARM64 are using an incorrect prototype for
> these functions in asm-prototypes.h:
>=20
> long long __lshrti3(long long a, int b);=20
> long long __ashrti3(long long a, int b);=20
> long long __ashlti3(long long a, int b);=20
>=20
> where "long long" is not 128-bit.=C2=A0 Despite this seems working for RI=
SC-V
> and ARM64 I really dislike it.
>=20
> S390 seems assuming CONFIG_ARCH_SUPPORTS_INT128 is always true, but I
> don't think we can assume it too (at least it'll likely to be false for
> LA32, so doing so will cause trouble when we add LA32 support).
>=20
> So if we don't want to check CONFIG_ARCH_SUPPORTS_INT128 and still use a
> correct prototype, we'll do:
>=20
> diff --git a/arch/loongarch/include/asm/asm-prototypes.h b/arch/loongarch=
/include/asm/asm-prototypes.h
> index 51f224bcfc65..0a57db01116d 100644
> --- a/arch/loongarch/include/asm/asm-prototypes.h
> +++ b/arch/loongarch/include/asm/asm-prototypes.h
> @@ -7,8 +7,6 @@
> =C2=A0#include <asm/ftrace.h>
> =C2=A0#include <asm-generic/asm-prototypes.h>
> =C2=A0
> -#ifdef CONFIG_ARCH_SUPPORTS_INT128
> -__int128_t __ashlti3(__int128_t a, int b);
> -__int128_t __ashrti3(__int128_t a, int b);
> -__int128_t __lshrti3(__int128_t a, int b);
> -#endif
> +struct { u64 lo, hi; } __ashlti3(u64 lo, u64 hi, int b);
> +struct { u64 lo, hi; } __ashrti3(u64 lo, u64 hi, int b);
> +struct { u64 lo, hi; } __lshrti3(u64 lo, u64 hi, int b);

Whoops.  This is still incorrect for LA32.  On LA32 an "int128" (if it
ever exists) should be passed as a pointer, but this is passing it in 4
GPRs.  So if we want to keep the prototype correct we need to either use
"struct { u64 lo, hi; }" in the parameter list too, or guard it with
#ifdef CONFIG_64BIT.

So to me checking CONFIG_ARCH_SUPPORTS_INT128 is just easier.

If you insists on not checking CONFIG_ARCH_SUPPORTS_INT128 I'll just use
an incorrect prototype like RISC-V but put a comment here, like:

/* The prototypes are incorrect but this file is only used by
   modpost which does not care.  */
long long __ashlti3(long long a, int b);
long long __ashrti3(long long a, int b);
long long __lshrti3(long long a, int b);

How do you think?

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

