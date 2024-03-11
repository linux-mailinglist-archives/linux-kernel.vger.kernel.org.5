Return-Path: <linux-kernel+bounces-99553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 412A98789E4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 22:12:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72AED1C20FDF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 21:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3AD56B77;
	Mon, 11 Mar 2024 21:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="kInH08S0"
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A6356B6A;
	Mon, 11 Mar 2024 21:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710191528; cv=none; b=YHFgplJgrbHJYOd7GQ5S9pfIS62hwthUxGnHQkcPvH3+2fIdfYYO1j9pCEbuoQs0ytLfHO9QWxOX+7aLP8N9q8IFo8zpMG4OntsWtTjazvqgIF6c+dIxct6lhUZEDqxSxSwDR5wKErd1NaC+0pEvqomy9UkeTiqYirSwIFKV+PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710191528; c=relaxed/simple;
	bh=iemc9BTvqpWfP6M7W2cS/ZtgzbQgKVdjsex36dyysc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rxOrajjum7dqfhEwOPoqyoF5JSD6MrVu9QKEqBHX4K0x1SLf+nZoAQLqZeqcq5rQ5VQ/xXknocW18rVEm19FBt1843y8cICc+XeCzkQ571DBq3PzKv+jXi9IQaTPsnc6VrM7v0Ke8O2my9+EyxJAUZR5OWjhNXB0u3KqOzr4wy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=kInH08S0; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id CB43C1C006B; Mon, 11 Mar 2024 22:12:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1710191522;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=suhwUbS3La/q9vF4wC7Q3GDRSJw09sPh4CSFxcpujg0=;
	b=kInH08S0Pt8uBvMxcP2uhk8fWfeAb1okNTMDd6vuBWEt3dAOcKwqxJJ1cpPZAK1WLVFiQh
	CFoWxwsObpDqARMRm0n+908kBVZpGjO6ZqsBFx9BD8evC2Fje4b1W6e3H/IydCt/yV2+iN
	J+tUvKlRjhMj0hOuS/9ufn4Dg+oHkvE=
Date: Mon, 11 Mar 2024 22:12:02 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Hou Tao <houtao1@huawei.com>, Sohil Mehta <sohil.mehta@intel.com>,
	Alexei Starovoitov <ast@kernel.org>, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org
Subject: Re: [PATCH AUTOSEL 4.19 1/4] x86/mm: Move is_vsyscall_vaddr() into
 asm/vsyscall.h
Message-ID: <Ze9zol7kZucywfOy@duo.ucw.cz>
References: <20240229204208.2862333-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J1nK2iNWXPRkPHfT"
Content-Disposition: inline
In-Reply-To: <20240229204208.2862333-1-sashal@kernel.org>


--J1nK2iNWXPRkPHfT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Move is_vsyscall_vaddr() into asm/vsyscall.h to make it available for
> copy_from_kernel_nofault_allowed() in arch/x86/mm/maccess.c.

This seems to be just part of a patch -- it does not move anything --
and we should not really need it for 4.19, as we don't have those
copy_from_kernel_nofault_allowed changes.

Best regards,
								Pavel
							=09

> +++ b/arch/x86/include/asm/vsyscall.h
> @@ -4,6 +4,7 @@
> =20
>  #include <linux/seqlock.h>
>  #include <uapi/asm/vsyscall.h>
> +#include <asm/page_types.h>
> =20
>  #ifdef CONFIG_X86_VSYSCALL_EMULATION
>  extern void map_vsyscall(void);
> @@ -22,4 +23,13 @@ static inline bool emulate_vsyscall(struct pt_regs *re=
gs, unsigned long address)
>  }
>  #endif
> =20
> +/*
> + * The (legacy) vsyscall page is the long page in the kernel portion
> + * of the address space that has user-accessible permissions.
> + */
> +static inline bool is_vsyscall_vaddr(unsigned long vaddr)
> +{
> +	return unlikely((vaddr & PAGE_MASK) =3D=3D VSYSCALL_ADDR);
> +}
> +
>  #endif /* _ASM_X86_VSYSCALL_H */

--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--J1nK2iNWXPRkPHfT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZe9zogAKCRAw5/Bqldv6
8hbCAJ90bmk+FFZg/PTzuaLCwvZ7uaouHACfSIPDNgnMYXrB2dTvZ2dSQb5mO4g=
=OE+O
-----END PGP SIGNATURE-----

--J1nK2iNWXPRkPHfT--

