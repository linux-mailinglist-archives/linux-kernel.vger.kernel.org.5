Return-Path: <linux-kernel+bounces-61070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DFD8850CEA
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 03:44:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE3E7B214E2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 02:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E8441FBF;
	Mon, 12 Feb 2024 02:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fHnaFtDj"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4F6A35
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 02:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707705833; cv=none; b=sOW0quB3UGExXHohEJatlWC+N3z7DnNosQ7lbIraRu5hsiRwgGes9FerwYWY/UwGMdVechGFwYI0daQqxQLf8jw5r6eiBDJylCkIT00WpHTPeL3GpKLXQM5ahg5A2hpXmLH8E8H0r70O0YTiuTVF9vWVUnsdIKNmreutvUYut8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707705833; c=relaxed/simple;
	bh=D5bzXZBLFO6sKbydx+M1Qw4VeKUB+BlJZYnyeMnA2ew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gw7BMRLBETSRkf/3yomplEyZ/t12F6kHLamFwEA39n895A70kNpnTem377Utsb0NWvuZviT2fZZ1gD2zLQZW/HX54FmCcE8l3pnMSCToXBR83QkZEfL7+gSVyrNOVhEm295Y35LM02FOgi5ruFaEaAF2GrWP82e+s+VwoPYuNiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fHnaFtDj; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2906773c7e9so1415709a91.1
        for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 18:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707705829; x=1708310629; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RdlET1RbN9Q5CFRccyLJ2v5AE+ycfABA4EBCvkdvcHU=;
        b=fHnaFtDjWayhdxLeD1JclLtMLLJPsDpg9I2jOn+er8XvtDHS28KhdG0PxjKUOQ9S+r
         WMCuuNBTf+vuDwlmpZMPWYOZMaoHOxCpZu0o3AinRXApZ5rbf2gn7/ZdiX/1nXNgHe29
         xEvP6/g16KBS+G1nRP0bAwbLDCgscsEp3lDPpVZa+TK8m5wfAnGE61/aKEu6O3ZEDNoM
         2owc5Rpr+FDwiJSI26RbKNN7HDDH+iobn/G/sMWHekQOT685D4dEnHNmp4pba/cTQTcJ
         0VT7NuAY/YIvu+Vcp+5bbzk0PSWoORTaeaDoF5TfpgcnlX5s0UHVB9Fe6Alyfhe3wq+9
         dIPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707705829; x=1708310629;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RdlET1RbN9Q5CFRccyLJ2v5AE+ycfABA4EBCvkdvcHU=;
        b=bMzqi+f6gJAYwdU+00Mgu8OnwRATQ/4OoMFpSmyibBB7JXSvRhuXTte2yAN4ErDB67
         2tnGYdNHWLdWSRXLJxpQDOJ4Qs/GJ0xLtn72eW5tJNOd2AcbFvRnrlr19h7x24pLn3KV
         tqIcfhGm0KOzrFsLsFsgmw9K986E+zETtdVCGHiCM+w0sVdMLMfA62qzPJvUw9Lxfccx
         B0apEHUuuBJq0ladfz+i5R847MlQ+Y+lEc23jwjmAm/si8QcwlRqYe8iDh3+a/pEfNPK
         dWwAVvYAqW2MxIye+z0Vo8aeJBS7S2lerfhjWGdfGzieUYFzLHBVwbaw7fc3bGtCf+Xy
         DGuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdRewg5grH6++xZ1L+Yii+eUWaY320JH9NWiT95ApPh2spR+ViiT5h3+jahgT2ptOm5j0k4pAcg2p8qBD4RhyOJU+gaTuW2vXehbbx
X-Gm-Message-State: AOJu0Yy8/Fgdg+Ks4nfk0yvkqX/HtFHHmQJgW8BbkSE9w+Q9PQu78auz
	VqNIdxnBKLvefGkA0zXr4+dLPGkNSQuwJbFdQxJjyPLZl5h07haf
X-Google-Smtp-Source: AGHT+IEF/ksMVvmRQXrVf8Nyul7fY+wdWksXuKzAB3BucZ+oiXMqQRELoEzYhm/InaSW9VUonhLveg==
X-Received: by 2002:a17:90b:46d0:b0:296:4844:78c6 with SMTP id jx16-20020a17090b46d000b00296484478c6mr2759899pjb.7.1707705828998;
        Sun, 11 Feb 2024 18:43:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX+hfIOkuMqXYcMEWK/44OdMBMYTTDmRhScnzlsgB0xTfZJrM6kSeBdEN7xzp26piksh8udEyd28trV5czFNw8AniP8vq87VzZeraWaKFSHfVc0oBW2CUyg1y/hZ77tAQJ2IIikP50BMd7rdIuQbTGzihS4yAJZu2UbQJfbD7NmMnDIgAgO2ifZeYq55+YLGppRrpmxqKbOsbunAUyUREt6HDGAtvjBitBBbxB2pGss7l2O9VYo+eaur1M3p5TFtiwSZ5DISIcRA/q23WaYbzd5fKapvJod/msxKeD6bXrGPWe2AbotstBa/p5E
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id q13-20020a170902c74d00b001d8d04a4fa8sm4899330plq.300.2024.02.11.18.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 18:43:48 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 5C6E618468562; Mon, 12 Feb 2024 09:43:42 +0700 (WIB)
Date: Mon, 12 Feb 2024 09:43:41 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: hapter@420blaze.it, mingo@redhat.com
Cc: tglx@linutronix.de, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, Andi Kleen <ak@linux.intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: arch/x86/kernel/sys_x86_64.c: rationale for 0x40000000 for
 MAP_32BIT's start address?
Message-ID: <ZcmF3SrTACMULEPb@archie.me>
References: <a5c2f06ba401cdf13bc87749341b1605@420blaze.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2c971D/B6+W0Fc9t"
Content-Disposition: inline
In-Reply-To: <a5c2f06ba401cdf13bc87749341b1605@420blaze.it>


--2c971D/B6+W0Fc9t
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 11, 2024 at 08:52:45AM +0000, hapter@420blaze.it wrote:
> I've found that passing in MAP_32BIT for mmap() will always return an
> address above 0x40000000. The problem seems to lie in
=46rom one gigabyte up?
> arch/x86/kernek/sys_x86_64.c, where the following comment is the only thi=
ng
> close to a hint(Line 100):
>=20
> /* This is usually used needed to map code in small
>    model, so it needs to be in the first 31bit. Limit
>    it to that.  This means we need to move the
>    unmapped base down for this case. This can give
>    conflicts with the heap, but we assume that glibc
>    malloc knows how to fall back to mmap. Give it 1GB
>    of playground for now. -AK */
>=20
> Unfortunately this does not supply a rationale for starting from 0x400000=
00,
> which seems very arbitrary, and the git commit has been there since the
> beginning of time (i.e. as far the the git history goes), so the git blame
> has not helped much to clarify it. I was also not able to find who "AK" w=
as.

That was from commit 717db2f9f36805 ("[PATCH] x86-64 updates for 2.5.54")
in tglx/history.git repo [1], authored by Andi Kleen. Cc'ing him.

>=20
> I have found another operating system that provides MAP_32BIT, FreeBSD, to
> not exhibit the same behavior and not cause any execution problems for RWX
> pages allocated below 0x40000000, so it does not seem a technical rationa=
le
> exists either.
>=20
> mmap will happily return 0x10000 (which seems like the lowest address the
> kernel will map when you supply it as a hint, so I do not see any reason =
not
> to start the find from 0x10000, or something that isn't as big as
> 0x40000000, which is big enough to impose a significant handicap for
> applications using MAP_32BIT (e.g. JITs that want to use CALL rel32 at all
> times).
>=20

Confused...

--=20
An old man doll... just what I always wanted! - Clara

--2c971D/B6+W0Fc9t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZcmF2QAKCRD2uYlJVVFO
o7p7AQDotZUk2+8w94lDD76kOjenqqOj0C1G768ZPVy0xcjdlwD/SwXPgbpE2tgz
1CQF7SxKvFNIC6H0tcmFdmQYHF/9UA4=
=eg30
-----END PGP SIGNATURE-----

--2c971D/B6+W0Fc9t--

