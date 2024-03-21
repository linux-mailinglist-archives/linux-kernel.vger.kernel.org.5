Return-Path: <linux-kernel+bounces-109934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 168A88857EC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 12:15:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4F6328275E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 11:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0027858ABC;
	Thu, 21 Mar 2024 11:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hJsfjmQM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B3057876;
	Thu, 21 Mar 2024 11:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711019725; cv=none; b=Ugyqc220A4wHKvHISFxyZwuYxV+0LPw1t+QdtssKZeeZ9s3/avzi4Buwi9UeFHPafGIDTPZ42C7OGrAo/s7WxCCjLUh9Jb0nngelbjbSWFnNyRTxrW+b2azImKpLxHzcx89UMeaWtdzu5vLwvwHPEpINx19+Im/Bqn5NSoXzwR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711019725; c=relaxed/simple;
	bh=fKCUlACMfauRrP+F9j+WWaw7J65ipX56Y+2OPskcuIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g5Wt7hXpLyg4AK7YrV7CF91KGYYl6PiwtdgSG5eXiebhmjKG4abgV+a7+dmk+TmPBaQc36+UhMxWu2txicZzCPS9i383v5NZWmThtBR1AI537ncnLmj3ywYJapJv14987+gcY3sQvKB/Vah1yPF9fJwNyGCRk5PcKxwyhyd/82Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hJsfjmQM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28672C433C7;
	Thu, 21 Mar 2024 11:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711019724;
	bh=fKCUlACMfauRrP+F9j+WWaw7J65ipX56Y+2OPskcuIU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hJsfjmQMYsqYM2STf6PHk9l9mwna+NQDtgI3v0Ibiskx4u7M1XEVLrhAkisLOeYjs
	 EL7WaCVymVCvjo8gmI8jDdD6307vPwQn1BR7njvrBS2lAsAkwUN2xkaNq70OPH7MPa
	 Ipecd8WnyZ946t1umDdKs0tNC9BSSLmikEYNvdCaMp91pvcoV6c3xbPfVRuSudCb38
	 X+Z4XT47rmt+HgjanyfjCNga03FnMgZWn63gTivoA6NR969jFi1gkjqD/S7L3pzIDV
	 MUsr2ZLGcC4zVFbcr5Yaqs04Ri8NFtriU6Lv444ddUbXB94xALaNCtfLoJdJKS4sG5
	 3ORzfIETF0y1A==
Date: Thu, 21 Mar 2024 11:15:18 +0000
From: Mark Brown <broonie@kernel.org>
To: Barry Song <21cnbao@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>, corbet@lwn.net,
	workflows@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>,
	Chris Zankel <chris@zankel.net>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Guenter Roeck <linux@roeck-us.net>,
	Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [PATCH] Documentation: coding-style: ask function-like macros to
 evaluate parameters
Message-ID: <fb744859-ba2a-41c9-bcfa-4ea1cb8c036a@sirena.org.uk>
References: <20240320001656.10075-1-21cnbao@gmail.com>
 <20240320124207.0c127947@canb.auug.org.au>
 <CAGsJ_4zpXwVEhsdffoZVBVWiwT4Lw2qEMrW-X92ib=kv=9Yx9g@mail.gmail.com>
 <20240320084919.8e18adb418347feed6bfc8ae@linux-foundation.org>
 <CAGsJ_4y+1HovQ52HPis8NBDqp4-fiGRwehX+NH0New0HoEU5GQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="TAcSmNRE4p6o+wUy"
Content-Disposition: inline
In-Reply-To: <CAGsJ_4y+1HovQ52HPis8NBDqp4-fiGRwehX+NH0New0HoEU5GQ@mail.gmail.com>
X-Cookie: MIT:


--TAcSmNRE4p6o+wUy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2024 at 07:48:36AM +1300, Barry Song wrote:
> On Thu, Mar 21, 2024 at 4:49=E2=80=AFAM Andrew Morton <akpm@linux-foundat=
ion.org> wrote:

> > Stronger than that please.  Just tell people not to use macros in such
> > situations.  Always code it in C.

> While I appreciate the consistency of always using "static inline"
> instead of macros,
> I've noticed numerous instances of (void) macros throughout the kernel.

=2E..

> I'm uncertain whether people would find it disconcerting if they complete=
ly
> deviate from the current approach.

> If you believe it won't pose an issue, I can proceed with v3 to eliminate
> the first option, casting to (void).

It might be worth adding a note somewhere in the file that talks about
how the coding style document is convering the current state of the art
but some files might older and not following the current style.  This
isn't going to be the only thing where there'll be issues like this.

--TAcSmNRE4p6o+wUy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmX8FsYACgkQJNaLcl1U
h9AMfwf9HeqraXnXYAw78tCMuY0c1TL2y4BWC0+oKGPXHbxTF9LV17xmodaBRTBp
LglMvk9nR02owGQSdhqz3csnWWQp2/Qg47UkSNOl//Vplk5wCBujNtA0+ojtD9oD
zf0VRykp1ifuYu5TMA12dAGZlJlYuKbjzWIlGRZiAJgCxsOTnfMSrzYHVjiQB7cH
gnUBrUCHyGCFikMLUOdPPERN+XrUxClfIQiv80gF7BM5iDoD8F1bqgNSbl/+7xpE
a8V5Kf98YMGCeGhCfc7hbnqJS58027LhgY5c/JbuavBZl8kL+HvkoMtdjyK0ZXoU
8VjGqD2egSNvzVZjxxI20l49UlaCoA==
=ic4b
-----END PGP SIGNATURE-----

--TAcSmNRE4p6o+wUy--

