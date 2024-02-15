Return-Path: <linux-kernel+bounces-66905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F84E856366
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:39:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0C9028141B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E790412CDA9;
	Thu, 15 Feb 2024 12:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b="sd11SsMk"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8066B12C53F;
	Thu, 15 Feb 2024 12:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708000762; cv=none; b=BppmrqlGhZw6WK+GRrJiH3gqP2gsrrdbd8WUoYQpY5nsKEz76FUDzcw5G1G2XBdCZWF16Sa8uT6yqxEH0uMzWKoALDH8LQZF0B+s1nn0y6N05cVqtcmGr9c1LsoieqNuFsm/uzbnIRHODTne8JhfvgrodrFLrrBtwSN9iO3Ay+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708000762; c=relaxed/simple;
	bh=0CrNpBu4yIiHyPyXquDCtohQJsa75tOaNepCV6CAu00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TbVPLP51TEAaZ03ExhoOuPNPi4yIa10xtrCtDNfgB9HzjmgR1mRF2Q1n9/Tj/5s8QE9WEaCbn6MljQtlpWqjDX9ZaO2ltxcXZNOPRIL/lJdvcxWrxwGyZw3M/lEUNAPn2/TUYtp1gw6Z6qCprMKl8nFfuj8e16VjuXXFxmi/ELg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fjasle.eu; spf=pass smtp.mailfrom=fjasle.eu; dkim=pass (2048-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b=sd11SsMk; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fjasle.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fjasle.eu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fjasle.eu;
	s=ds202307; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=0CrNpBu4yIiHyPyXquDCtohQJsa75tOaNepCV6CAu00=; b=sd11SsMkQ7iHgV+GJrN30/KviA
	Ulaemp9KMtn0zGIpbsKHlRcgGL+MuRyMF/fNH766IcBjNz+clfzEX/3xfZMmWBCipji5Ja7sld+V6
	Cwm853qVchFUeMqUQF3kEHFE6XLuz1dWZ/rNDIWV4HBWTRLDySwMmfcNOTEtuS6ZPrEibBiJiEsyJ
	wR6qal0PCvWcXs2bzBLUjW69kESa9SKVAvFUni36VuEFT7ZxlFhPvJRWoLRFCEazY0Hb9rCF+Xadu
	SFKO8+qAVrz2uZ3iRQaRDbx2BvTN0AwfzcuoQZIPs1cpo2DDGQmn7SD+kRlkvUCR/73Cr3rgABHb8
	6GS4VQZw==;
Received: from [2001:9e8:9e8:801:6f0:21ff:fe91:394] (port=48468 helo=bergen.fjasle.eu)
	by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <nicolas@fjasle.eu>)
	id 1rab10-00BKdV-Oh;
	Thu, 15 Feb 2024 13:38:58 +0100
Date: Thu, 15 Feb 2024 13:38:52 +0100
From: Nicolas Schier <nicolas@fjasle.eu>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Arnd Bergmann <arnd@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Arnd Bergmann <arnd@arndb.de>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	linux-kbuild@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] Documentation: kbuild: explain handling optional
 dependencies
Message-ID: <Zc4F3JttXSsBsw-P@bergen.fjasle.eu>
References: <20230917192009.254979-1-arnd@kernel.org>
 <CAK7LNASua5xkkg84s4o4GZ00hFRc10V9BmqyxfWfPi=JVFYC8g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="SLx/gfFA9UUD09BZ"
Content-Disposition: inline
In-Reply-To: <CAK7LNASua5xkkg84s4o4GZ00hFRc10V9BmqyxfWfPi=JVFYC8g@mail.gmail.com>
X-Operating-System: Debian GNU/Linux trixie/sid
Jabber-ID: nicolas@jabber.no


--SLx/gfFA9UUD09BZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 25 Sep 2023 16:06:41 GMT, Masahiro Yamada wrote:
> On Mon, Sep 18, 2023 at 4:20=E2=80=AFAM Arnd Bergmann <arnd@kernel.org>=
=20
> wrote:
> >
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > This problem frequently comes up in randconfig testing, with
> > drivers failing to link because of a dependency on an optional
> > feature.
> >
> > The Kconfig language for this is very confusing, so try to
> > document it in "Kconfig hints" section.
> >
> > Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
> > Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> > v2: fix typos pointed out by Nicolas Schier
>=20
>=20
> Applied to linux-kbuild. Thanks.

Hi Masahiro,

this patch seems to got lost, or did you intentionally removed it=20
again?

Kind regards,
Nicolas

--SLx/gfFA9UUD09BZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmXOBdcACgkQB1IKcBYm
EmmJNxAAkHRogwZILhoqFWK3tgngdLB7MkwI0nI7N136dpjW/zatqutnBvWxpBrz
boH70WhEOieibR17yLtVsvtC7AH4TOwhtSvsfENy/IsCOvZZTdox30+eFMfBORrA
SfcsROlP6AuXSjw42UdXvPneGL3rjX3VOQvMDtGgdI72GQm9xkUDmtCxVZC/bSU8
NEx785JyhiTOmsHHO6AWOoZoh3lRe844TSEtekxF+apXEWJF+pr6br0CR1TyNnNY
RG4Rsq4gJ7BLlb0ts8Cnld6mdyW6CikKlYkd2ru7aBEvyhLxSdF+oA7/I7agIQju
Rgg0DSsYgSCeA+WWEneK+BE8dBRG6yfZ7M+Tu2GOSNSGOykDZyUeYmBai0lLNU++
LoI/awE66lLgmAAfXtlXkOIO0anaEiE4t3i6vLRDKaPDXsFbeY25dM0sqwyzdAHS
6pESnrbxdwxUl63THX+9jrYkiu2ji0axErUTn3XwmMLGw88CNm+ZkeI2db48WgVf
sJNjhbfVpKOaJTaPQBcO+flFXWOlc2wFE1e8Q96wjJI5tOnlKthGdQ5xJTMTGF0x
G2TANEw4Neo7hRwOImrcXolFrdoI4/BcRe3qotDQeHLn61jpvBSN1BTog/iREcZh
i/gQQS4m1kmZOk0/quveFrKCBNtW57pP2jTP2tf3hhnjDZuQuQY=
=KLro
-----END PGP SIGNATURE-----

--SLx/gfFA9UUD09BZ--

