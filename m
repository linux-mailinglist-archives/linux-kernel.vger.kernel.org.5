Return-Path: <linux-kernel+bounces-55677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA5084BFDE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 23:14:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7FF1B23463
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 22:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A41F1BDED;
	Tue,  6 Feb 2024 22:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="RaYhLVOQ"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610071BF24;
	Tue,  6 Feb 2024 22:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707257644; cv=none; b=esxp1pVRgwVopUsOgFKtWbrUIGtQQCGHI+GOb9MZv7JAl/tjB6BrQ1YvKWYk9N9sIBqdbO0LJ8i7eX8/pwfMsqJt2x+nXkv3BUx8/1f2u+iVzf2LQG3lc2jaf3FhBV0l8j6RSeHXSzbi815x3hAmmOkzzVsUbIHOhIa3j/kPwMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707257644; c=relaxed/simple;
	bh=8kC4nFc8jWCU8lz0w4ns6l3GkKaVW0JLOw8EaPHxltg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EpZ46t7TLzIr+rFfRUETS2thvB6oA0J2eHg8SUApbbWZVmbm+aggOgdh+YgeBfCg2Y6DCzBGTChq4HC/z4C2oamX8HvqcWn5WKLeW6VQFQhqB7P/Izl6KyI25mwsgzWVzMg465wZNhWKWyNhVRgMeloMMgJyGz186H3/zTKZEkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=RaYhLVOQ; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1707257639;
	bh=Hhm5lsGggZ/n0AiTj+cat/T+aIp+NC3/bl9hougzqP4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RaYhLVOQu44EMobqCnJ3Nzvv3xkt6iiRuX05hTKN//wTMqyWjfYyEITCpYzxqPB5t
	 fx9tGlhXXzUZntXkXKGeKDWHk6cQfslux9it55ViTbXNIurjv82VO3Uug+nTFDYc5M
	 6Wev79GYoZA1WMOTlTOy/xajPORD7UfHWqefeqyrsB5zNFOF9J3rk2ZAbe49hjvFDt
	 fx+TTKTpW10to3Ph+XbB1vU+1pljusZE/mnVKQzfSoL/MhgFlmnAifWcCdWjtVItO8
	 ZY5VcG4KKNd3p+uGQTPJfPSsCwD4l/e5ZmOQi8Q20gG5N6O3i8ILVbc6PfnjIRe/fU
	 5FR+NvAt0QkHg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TTyFZ4Nhkz4wcB;
	Wed,  7 Feb 2024 09:13:54 +1100 (AEDT)
Date: Wed, 7 Feb 2024 09:13:53 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jean Delvare <jdelvare@suse.de>
Cc: Linux Next Mailing List  <linux-next@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>, David Miller
 <davem@davemloft.net>, "Eric W. Biederman" <ebiederm@xmission.com>, Florian
 Fainelli <f.fainelli@gmail.com>, Hector Martin <marcan@marcan.st>, "Jason
 A. Donenfeld" <Jason@zx2c4.com>, Lee Jones <lee@kernel.org>, Micah Morton
 <mortonm@chromium.org>, Mike Marshall <hubcap@omnibond.com>, Pavel Machek
 <pavel@ucw.cz>, Theodore Ts'o <tytso@mit.edu>
Subject: Re: linux-next: trees being removed
Message-ID: <20240207091353.2d16ac11@canb.auug.org.au>
In-Reply-To: <d5e68f29d6c835848295c10bac964da7a57f1bfe.camel@suse.de>
References: <20240124130101.428c09a3@canb.auug.org.au>
 <d5e68f29d6c835848295c10bac964da7a57f1bfe.camel@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/8pK6Dh/8ND8BfyrbBsD2Dze";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/8pK6Dh/8ND8BfyrbBsD2Dze
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Jean,

On Tue, 06 Feb 2024 11:50:44 +0100 Jean Delvare <jdelvare@suse.de> wrote:
>
> On Wed, 2024-01-24 at 13:01 +1100, Stephen Rothwell wrote:
> >=20
> > Tree=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Last commit date
> > =C2=A0 URL
> > =C2=A0 commits (if any)
> > -----------------------------------------
> > (...)
> > dmi=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A02022-09-23 14:5=
3:14 +0200
> > =C2=A0 git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.g=
it#dmi-for-next =20
>=20
> This is still where I would put updates to the DMI subsystem, but it
> turns out there haven't been any for some time now, and I'm not aware
> of any pending issue.

I am happy to restore it if you want.

> Out of curiosity, why do inactive branches bother you?

It is mostly just a way to get rid of abandoned trees.  Also, one of
the checks I do requires me to reference all the commits between the
merge base of each tree and Linus' tree.  If the base (and top commit)
of a tree has not been updated for a year, that means checking 40,000+
commits which takes a noticeable amount of time.  Also just merging
such a tree has a noticeable delay.  An empty tree (relative to Linus'
tree) doesn't cost much, of course.

> I can certainly update that branch if it makes your life easier.

Yeah, even just resetting it to Linus' tree at each -rc1 will help.
=20

--=20
Cheers,
Stephen Rothwell

--Sig_/8pK6Dh/8ND8BfyrbBsD2Dze
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXCryEACgkQAVBC80lX
0Gxelwf/WKPa8NepgCNPji9dXgGKexHh8h2ZBiJE3R470JSdu4324afjcjMArriP
sCmGpDVr1mU0S8MvFQ3g1GMJ9Jquc6RfQvaY2UvRkDXyvmstMhIflyd2krCyFuWO
3Q6ZupO8/PUZOviYlf/lNH8YQpGzC1JhVPIikfFhAyxcRMHtfYF11VOcUEbVfdeK
xusohXgxQiQqsa7no/LF2L7nGlXAaXzjAX7BTJ0JrHxfNW4pOy6ZxjW9PMaMCY8H
imhK3yv9WQTSQ51q87nge5D3DD25Pe0vE4HNPEXItJgtGSud5VpR+/buKRR6L0dk
32Eoeer/8R9vZMXKUV/ABFeLnJmOUg==
=68Cp
-----END PGP SIGNATURE-----

--Sig_/8pK6Dh/8ND8BfyrbBsD2Dze--

