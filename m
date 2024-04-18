Return-Path: <linux-kernel+bounces-150124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE938A9AC8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFE1B1F256DA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 13:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB06B165FCD;
	Thu, 18 Apr 2024 13:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="td7NRfGf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NTafIBCY"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A338B1465B1;
	Thu, 18 Apr 2024 13:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713445317; cv=none; b=mI4pCO4qpBQUX3CeCe2Jnoov9c9fK2VQdIuEiUcQUv8buSWSg7hOpF5HGEWyUpS/u8Z6oYVWgJzXV7BIi59IJzZcqsm1Qldi/Tj3OKamQpHqu0myjjq8qnmKLSjbZBGBe3tcVb3TAJotQz3x4/RXTEkxFz9H9jpMp7BTk+FJ/kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713445317; c=relaxed/simple;
	bh=/V9nJ3w6SVVFPJeLw5l/Mr1q879sKp9vUjziZRX9VjM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ss9U6aLsWCACHsw0ipMMN9uIaWnYvpp6jXxC5t/wHfkt29QTzZmHTj9gadQCv4GY876xDI9XkSZZdnDWrXFhwEp9Bfir4FBbxvbcU9bUQZSps+P7sNRl46F5qRdgPhjN0lcH/0qKyes1wKesBv/p7uqbtoyQpMG1RFNTwGm4gKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=td7NRfGf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NTafIBCY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 18 Apr 2024 15:01:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713445310;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0GJg4wo0VKLac1PG97GL83QKeqaA9szY5zPKromLH+A=;
	b=td7NRfGfcrv0MyyqY+R9o3SoF/k2jyFG+Hw7c1iUg6sGEx/jr18/rj4iS1DJnfvGCR68pw
	rPRsi11sW51RYh1zIYoVxRPbgMoAcCiEAMrRLR9nlGI5MXoHvXTg5w8haFnEipTHC8L2HL
	GWVwjcdQbvWzbsxenfbbEpLyISg/ZtzSzQqBBJIKiBRu1NpOfgm0acuuLOqhmM7RBrjlCv
	s1DWtTp64zduTiWs856+1dllq2b+ovcJwOPy67hRL8w+Lhx9oDOQqbijAjb1461hu1NJiM
	A0X0DzUjidKOd+p1q3gRJpZoCjKF40N02qN+mT8SxrMv/j+9pK+Fqj7LhvA3Yw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713445310;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0GJg4wo0VKLac1PG97GL83QKeqaA9szY5zPKromLH+A=;
	b=NTafIBCYsXh1Tdh3iOhsXmxdqRGVtfe43CHFbsPqgsih4/iAHkX8D+I5XsL1Gc1tYxHC6+
	BnB4ua0EWdlKKbCw==
From: Nam Cao <namcao@linutronix.de>
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>, Andreas Dilger <adilger@dilger.ca>,
 linux-riscv@lists.infradead.org, Thomas Gleixner <tglx@linutronix.de>,
 Andrew Morton <akpm@linux-foundation.org>, "ndesaulniers @ google . com"
 <ndesaulniers@google.com>, Luis Chamberlain <mcgrof@kernel.org>, Ingo
 Molnar <mingo@kernel.org>, Christophe Leroy <christophe.leroy@csgroup.eu>,
 Tejun Heo <tj@kernel.org>, Krister Johansen <kjlx@templeofstupid.com>,
 Changbin Du <changbin.du@huawei.com>, Arnd Bergmann <arnd@arndb.de>, Geert
 Uytterhoeven <geert+renesas@glider.be>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] init: fix allocated page overlapping with PTR_ERR
Message-ID: <20240418150148.6a0b4664@namcao>
In-Reply-To: <87edb2sv0d.fsf@all.your.base.are.belong.to.us>
References: <20240418102943.180510-1-namcao@linutronix.de>
	<20240418131238.636bee2c@namcao>
	<87edb2sv0d.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 2024-04-18 Bj=C3=B6rn T=C3=B6pel wrote:
> Nam Cao <namcao@linutronix.de> writes:
>=20
> > On 2024-04-18 Nam Cao wrote:
> >> There is nothing preventing kernel memory allocators from allocating a
> >> page that overlaps with PTR_ERR(), except for architecture-specific
> >> code that setup memblock.
> >>=20
> >> It was discovered that RISCV architecture doesn't setup memblock
> >> corectly, leading to a page overlapping with PTR_ERR() being allocated,
> >> and subsequently crashing the kernel (link in Close: )
> >>=20
> >> The reported crash has nothing to do with PTR_ERR(): the last page
> >> (at address 0xfffff000) being allocated leads to an unexpected
> >> arithmetic overflow in ext4; but still, this page shouldn't be
> >> allocated in the first place.
> >>=20
> >> Because PTR_ERR() is an architecture-independent thing, we shouldn't
> >> ask every single architecture to set this up. There may be other
> >> architectures beside RISCV that have the same problem.
> >>=20
> >> Fix this one and for all by reserving the physical memory page that
> >> may be mapped to the last virtual memory page as part of low memory.
> >>=20
> >> Unfortunately, this means if there is actual memory at this reserved
> >> location, that memory will become inaccessible. However, if this page
> >> is not reserved, it can only be accessed as high memory, so this
> >> doesn't matter if high memory is not supported. Even if high memory is
> >> supported, it is still only one page.
> >>=20
> >> Closes: https://lore.kernel.org/linux-riscv/878r1ibpdn.fsf@all.your.ba=
se.are.belong.to.us
> >> Signed-off-by: Nam Cao <namcao@linutronix.de>
> >> Cc: <stable@vger.kernel.org> # all versions
> >
> > Sorry, forgot to add:
> > Reported-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
>=20
> Hmm, can't we get rid of the whole check in arch/riscv/mm/init.c for
> 32b?

We can, but that depends on this patch. So my intention is to wait for
this patch to be applied first, because I don't want to bother the
maintainers with dependencies.

> --8<--
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index fe8e159394d8..1e91d5728887 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -196,7 +196,6 @@ early_param("mem", early_mem);
>  static void __init setup_bootmem(void)
>  {
>  	phys_addr_t vmlinux_end =3D __pa_symbol(&_end);
> -	phys_addr_t max_mapped_addr;
>  	phys_addr_t phys_ram_end, vmlinux_start;
> =20
>  	if (IS_ENABLED(CONFIG_XIP_KERNEL))
> @@ -234,21 +233,6 @@ static void __init setup_bootmem(void)
>  	if (IS_ENABLED(CONFIG_64BIT))
>  		kernel_map.va_pa_offset =3D PAGE_OFFSET - phys_ram_base;
> =20
> -	/*
> -	 * memblock allocator is not aware of the fact that last 4K bytes of
> -	 * the addressable memory can not be mapped because of IS_ERR_VALUE
> -	 * macro. Make sure that last 4k bytes are not usable by memblock
> -	 * if end of dram is equal to maximum addressable memory.  For 64-bit
> -	 * kernel, this problem can't happen here as the end of the virtual
> -	 * address space is occupied by the kernel mapping then this check must
> -	 * be done as soon as the kernel mapping base address is determined.
> -	 */
> -	if (!IS_ENABLED(CONFIG_64BIT)) {
> -		max_mapped_addr =3D __pa(~(ulong)0);
> -		if (max_mapped_addr =3D=3D (phys_ram_end - 1))
> -			memblock_set_current_limit(max_mapped_addr - 4096);
> -	}
> -

If you are going to send this, you can add:
Reviewed-by: Nam Cao <namcao@linutronix.de>

>  	min_low_pfn =3D PFN_UP(phys_ram_base);
>  	max_low_pfn =3D max_pfn =3D PFN_DOWN(phys_ram_end);
>  	high_memory =3D (void *)(__va(PFN_PHYS(max_low_pfn)));
> --8<--
>=20
> Mike hints that's *not* the case
> (https://lore.kernel.org/linux-riscv/ZiAkRMUfiPDUGPdL@kernel.org/).
> memblock_reserve() should disallow allocation as well, no?

He said it can't be removed if we set max_low_pfn instead of using
memblock_reserve()

If max_low_pfn() is used, then it can be removed:
https://lore.kernel.org/linux-riscv/Zh6n-nvnQbL-0xss@kernel.org

Best regards,
Nam


