Return-Path: <linux-kernel+bounces-163437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8F88B6ADE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 08:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 045501F2201E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 06:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ECA71BC59;
	Tue, 30 Apr 2024 06:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="S9p9f5Nr"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D459F14A9D;
	Tue, 30 Apr 2024 06:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714459827; cv=none; b=IX/GNxgcSgP7jhox+Hv+kfbhdyZI7EiCCnVgFundkkJZTCaqOKL6KIhFOnB9Nlh/iD5Gqsb34ozriLlaciRuUXZMsoQ1jTfiquPwrqIczz8R1QPzA6fh0s8Z2jyVay5LP08U1khwFXJ2025+NuwAYuAZvF2+ifz0MhOswquwT94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714459827; c=relaxed/simple;
	bh=oGIHD1luvTflcc36qacrfpmzkfE2+5KuMdDdue+4T2I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gQwzqRozlAUDW5rOiX7BKJwZz8aXnWHuRNwxGx7vucpGAJQKZ3yXzT84BrMt3zgSZ6IOHF6/GmcaHh55ZnSJ9sJ5ulIiADi04czpLTj8lLFpcIej6Gv4hFHvBxZhfSeJyS7QlLX2mEuyEINwuXm1b8EPB7dDsA93vGyeVYhmUcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=S9p9f5Nr; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1714459820;
	bh=cVUX0R3ZD3NmC7G2/3F3cA5Cf1m9rBcrHVtUteIyysk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=S9p9f5Nr/iJHETP4aP9Kju/Ne8JiuCpV+HIhAuXWrr+/oyarYGJItMBKe6CIvygz6
	 +365VW9vyUbldzkEEGVRUcb8bFJjUd6ofQakkmFFAB3w/iFELPANz7wS4zqbu02GoX
	 9lxtv+yffEs6q8Z71+e2WoYmOquOMo7zLWGnb6fPJbJWkq1vm+G821vgX5aVMK+nN+
	 EmdNtoWVVKCXQRqRpnG6JzLzz9E5FR7HULtMV/QIKwG37IBfiVRbamMpJUt1uY8KGo
	 VibWR1+lS8CyeOpaZ6JGx3cc6ytfzTYM9i7NCnRfiiMVQaj24vJBvzKXrB+O+ZXqrF
	 ElLqKnqIroLxQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VT9n82H9Cz4wcd;
	Tue, 30 Apr 2024 16:50:20 +1000 (AEST)
Date: Tue, 30 Apr 2024 16:50:17 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jean Delvare <jdelvare@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the dmi tree
Message-ID: <20240430165017.4fa14188@canb.auug.org.au>
In-Reply-To: <20240430114613.0cef65fc@canb.auug.org.au>
References: <20240430114613.0cef65fc@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/N_TempakDxPoxRpWF7vQ=KM";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/N_TempakDxPoxRpWF7vQ=KM
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 30 Apr 2024 11:46:13 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>=20
> After merging the dmi tree, today's linux-next build (arm
> multi_v7_defconfig) produced this warning:
>=20
> In file included from include/asm-generic/bug.h:22,
>                  from arch/arm/include/asm/bug.h:60,
>                  from include/linux/bug.h:5,
>                  from include/linux/thread_info.h:13,
>                  from include/asm-generic/preempt.h:5,
>                  from ./arch/arm/include/generated/asm/preempt.h:1,
>                  from include/linux/preempt.h:79,
>                  from include/linux/spinlock.h:56,
>                  from include/linux/mmzone.h:8,
>                  from include/linux/gfp.h:7,
>                  from include/linux/umh.h:4,
>                  from include/linux/kmod.h:9,
>                  from include/linux/module.h:17,
>                  from drivers/firmware/dmi_scan.c:5:
> drivers/firmware/dmi_scan.c: In function 'dmi_decode_table':
> include/linux/kern_levels.h:5:25: warning: format '%ld' expects argument =
of type 'long int', but argument 2 has type 'int' [-Wformat=3D]
>     5 | #define KERN_SOH        "\001"          /* ASCII Start Of Header =
*/
>       |                         ^~~~~~
> include/linux/printk.h:429:25: note: in definition of macro 'printk_index=
_wrap'
>   429 |                 _p_func(_fmt, ##__VA_ARGS__);                    =
       \
>       |                         ^~~~
> include/linux/printk.h:510:9: note: in expansion of macro 'printk'
>   510 |         printk(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
>       |         ^~~~~~
> include/linux/kern_levels.h:12:25: note: in expansion of macro 'KERN_SOH'
>    12 | #define KERN_WARNING    KERN_SOH "4"    /* warning conditions */
>       |                         ^~~~~~~~
> include/linux/printk.h:510:16: note: in expansion of macro 'KERN_WARNING'
>   510 |         printk(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
>       |                ^~~~~~~~~~~~
> drivers/firmware/dmi_scan.c:109:25: note: in expansion of macro 'pr_warn'
>   109 |                         pr_warn(FW_BUG
>       |                         ^~~~~~~
>=20
> Introduced by commit
>=20
>   868577e6bfe1 ("firmware: dmi: Stop decoding on broken entry")
>=20
> Include printk.h?

This caused i386 defconfig build fail, so I have reverted this commit
for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/N_TempakDxPoxRpWF7vQ=KM
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYwlKkACgkQAVBC80lX
0Gx7gwgAjcp5cKcL+Ihf4/edvKKLjfteag7VKVnR04oHRgZlKWqCIAAaFrHq0Cuh
KWg0pLbQoC2nmJsN8rzTpAHSDOa2lvelvV5w1SDlP585Yo2KUwu7AcBK9H0+wlXZ
6fGELHxKSrVho3AKfxBHtC9XYU2rslJaD2Yvr3H35LvGd9kNTZJ5ZEnUMGBxXl2u
7Wx53sG0hkhBYaMFd6zAzorp1yYQRGHB3suTBJvSOSeSDdoSZVHJnDmiXL3VxGh3
ADBaAuwPzSbgUTlSpjL8jpZZRvZrRxUjSo7Is+uihgTaySAMCF9U0x+mW9ZTuY6L
QTxXMSB6pW8j8IPIB2HtFjRzbBXL9w==
=O/eA
-----END PGP SIGNATURE-----

--Sig_/N_TempakDxPoxRpWF7vQ=KM--

