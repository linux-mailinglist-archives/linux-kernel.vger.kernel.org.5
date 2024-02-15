Return-Path: <linux-kernel+bounces-67025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C48F8856501
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:55:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ED31289D9F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9459E13343C;
	Thu, 15 Feb 2024 13:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b="Nu35k+5W"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C79B132473;
	Thu, 15 Feb 2024 13:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708005123; cv=none; b=AaWHYNu7qrboIp/t4ZhFi+6fag11E/FDJiStRCsZOAdxiAycKTP3WUL5gsA9j7V22XKwsi1s4NCWxXUmUxROz2WFJSqH9GZ2j45x9AgmrDT26LI64H3hjLsA77VdHHA10lcNcJ0/ukcn8gslF7Gd5gP4e+aOWyFdMLmwjQQLyxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708005123; c=relaxed/simple;
	bh=Xj7/ePQMSAZuVMrdrhvn2P2gF/x+SuLj2AglGIRI9WI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XJ/z4Vje7SNo6pc6R+9Ex6Lm+byU5M5fMGm9PX8mnMjNfILjwJ3ayR+KCROzRuvXX46UcPUgPh4tCldSwEnqP4qhbBax0TZ/jasA6gtS9aO7UrSQUW/2mHsazN3jPvC874f35oRd/nx+t93s5IIKWg50b0B2/EcGFR0JZZ0jwRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fjasle.eu; spf=pass smtp.mailfrom=fjasle.eu; dkim=pass (2048-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b=Nu35k+5W; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fjasle.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fjasle.eu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fjasle.eu;
	s=ds202307; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=gWyBhM0O3y8vCrBu0cOTgpF3vnKO+cg+gXXdGhoay7c=; b=Nu35k+5WU4Pif8FVs+wKGuMpKw
	CtlKHVXzcc14NsWYtCaxRKAhJYyP0siYCPxnLSJp2P3bq1qEAxnTBBfd98ftmJFiMeGeAhKy5RVib
	q/Sg8FjDyIOD2fyZphqk8x6GIV08XTyFLkd85hOmR8uIzFDesvqxcYhXzxx0WCFdfQ3mLco1ewCdS
	HAWgse2Pss4PK2IHIfpQm3RMUkby9PkgMrxnbMWNG1P5WYuvbjhf/H96rEOBrcKJKZA2wpgUx6nwJ
	n46dgG3hH81jy4KpNfkUCky9CGBidkPzYuo+MgS2vZMxU0WCPQe3dEWysVspZdymfX6NKFXrOi5Xi
	mIapPSAA==;
Received: from [2001:9e8:9e8:801:6f0:21ff:fe91:394] (port=48364 helo=bergen.fjasle.eu)
	by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <nicolas@fjasle.eu>)
	id 1rac92-00Bv06-Op;
	Thu, 15 Feb 2024 14:51:20 +0100
Date: Thu, 15 Feb 2024 14:51:14 +0100
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
Message-ID: <Zc4W0lXFq7xysTF4@bergen.fjasle.eu>
References: <20230917192009.254979-1-arnd@kernel.org>
 <CAK7LNASua5xkkg84s4o4GZ00hFRc10V9BmqyxfWfPi=JVFYC8g@mail.gmail.com>
 <Zc4F3JttXSsBsw-P@bergen.fjasle.eu>
 <CAK7LNAT2DNE3RMLdXhLbSRHz6nfuP825UK39sQHkJW4x+OyfVg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xJcRt8yPtLXSXZDZ"
Content-Disposition: inline
In-Reply-To: <CAK7LNAT2DNE3RMLdXhLbSRHz6nfuP825UK39sQHkJW4x+OyfVg@mail.gmail.com>
X-Operating-System: Debian GNU/Linux trixie/sid
Jabber-ID: nicolas@jabber.no


--xJcRt8yPtLXSXZDZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 15 Feb 2024 22:40:46 GMT, Masahiro Yamada wrote:
> On Thu, Feb 15, 2024 at 9:39=E2=80=AFPM Nicolas Schier <nicolas@fjasle.eu=
>=20
> wrote:
> >
> > On Mon 25 Sep 2023 16:06:41 GMT, Masahiro Yamada wrote:
> > > On Mon, Sep 18, 2023 at 4:20=E2=80=AFAM Arnd Bergmann <arnd@kernel.or=
g>
> > > wrote:
> > > >
> > > > From: Arnd Bergmann <arnd@arndb.de>
> > > >
> > > > This problem frequently comes up in randconfig testing, with
> > > > drivers failing to link because of a dependency on an optional
> > > > feature.
> > > >
> > > > The Kconfig language for this is very confusing, so try to
> > > > document it in "Kconfig hints" section.
> > > >
> > > > Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
> > > > Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > > > Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>
> > > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > > > ---
> > > > v2: fix typos pointed out by Nicolas Schier
> > >
> > >
> > > Applied to linux-kbuild. Thanks.
> >
> > Hi Masahiro,
> >
> > this patch seems to got lost, or did you intentionally removed it
> > again?
> >
> > Kind regards,
> > Nicolas
>=20
>=20
>=20
> Oh?
>=20
> I can see it in the mainline.

ups, I'm sorry for the noise.  You are right, I had an heavily=20
out-dated tree at hand and wasn't aware of it ...

Kind regards,
Nicolas

--xJcRt8yPtLXSXZDZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmXOFtEACgkQB1IKcBYm
EmnUEg/9FS2yYQTljduaQOeZmVNBNvD7aiFwEwzoR/X7UIhZA5CjlGBpdvH75EpZ
4t4C9zZeTTeqw/i9NjU4t5CC8I8ymlJOWsFgl+clgvPznLh+6WMcHypZhKTvEt8+
GcRmvXHXDYgVnDbGBBU4H7z/AHWKv5wlqEJsml7WRZMDakhqVoQ8wk8TGnLM9nvV
xpPBPfPRZwyvb8IkpvhgVGKPnlywrmu3ufvaNHVVxrdqawZ5qlT2S1y6OARyhQni
tBnQ+iFpvKwnYkAcfcnWUk2o2QmbTMzK4TDXuf0QxGV+0cjr/V6mycIicyqzLlnS
RwvLv0tScxCrM1lXVhkWR2iNfa2XZ3aU295XzoXOrLaSO0kI50DMzKKVUKS0jq2g
jdLR7xZS+GR/AUGguhNvD+xgg1Cy5HFm8WhJniOD02/c2bVl2uL+xmogp57TiRfw
f6B2MtEm7woaqZ0LUZUyLt1pD567x/U+VvQN1+Xg4Lg3IPU9+jh7XN71UATqv4+z
s2yWqCp0iGpwhc0lJgvVXTAVj0S9HsFzmxWlcSb+9WMahFsFEcoXClWQOl7Wc6ba
1MK8CqAr4FqPkjS5zbuL929OkcDQIAYNniBNCt6VZsv8YxOLBBgFw7a2oB1CQ/8z
y01vFJ+rNpcfkvcMEdHL44FOGAKeH984Py3c/um6YF562SYcLgo=
=qbJ+
-----END PGP SIGNATURE-----

--xJcRt8yPtLXSXZDZ--

