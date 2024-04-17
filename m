Return-Path: <linux-kernel+bounces-148983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B06B48A8A16
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 19:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD1BC1C232FA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E23171E50;
	Wed, 17 Apr 2024 17:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="Hbs4ddXc"
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E74A16FF48;
	Wed, 17 Apr 2024 17:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713374320; cv=none; b=Cwgan0qKbYEj3JbnCPtU+VrPLB+2cONKbfps7VVxH2IUtVeIFUSq/860i6qghoJ+/Z3dgrQTXz2EL0ep/5/LPGYuwPfb8R+fBjqxN5qgsXP56ji22q1ENmdmqZVHdzJewflxQ6rbfaY3s/30A4rwbnT6OrshIiqqCjAN4xdfq8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713374320; c=relaxed/simple;
	bh=I6YvfZGeTV+ci2hm0heuo2oHR/afRNCFA0+6CMHKekk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mHNis0IIErcF3QQq8xBLwfHNhiR/T8rKyUSL+L/jMmqsty88a4iNgjS0Kj9rMz69Vc6o1dG84igD99AWccByXY4wfkiyYr/ggDQVbE4WH28Gl9r58IBV1b2/xflG8qZjLvdP5iM5O/HiDvJJwOeRtNurpAtUx1aaDMFjsWIFswE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=Hbs4ddXc; arc=none smtp.client-ip=212.227.17.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1713374296; x=1713979096; i=christian@heusel.eu;
	bh=I6YvfZGeTV+ci2hm0heuo2oHR/afRNCFA0+6CMHKekk=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Hbs4ddXcpA+IYmc9vMzDplG1V547gDJGuwRjhwz21VH0lOT39yiaWIjZjTzqk0zA
	 BF9fOMCnuHN0WZfNh/SwtfeB9g8dmaGr18N08eeOnN6UTVP/ENowThQW8mZjsuu6o
	 ehV7VOACXzi0txzBWYCHPsRu66xLUoa4i1pYj6m3CDKD9a4rEMRvyezKjA5AzVcdg
	 0FCAKLxHreGpQhParqsklwRe2ffPN5ax4pG8pP7lz2skWUeolhEnCs8mcs6PxK3Q1
	 AjOZSP4be3We+ed8TxvStv2KsrrwIqqiMfF7pHkUm4tJvWnrl5D+XJKUiUD0Dmcwd
	 SzxjwHBVPkocm09IIg==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([141.70.80.5]) by mrelayeu.kundenserver.de (mreue108
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1N7zNt-1skcse3YV1-0154ti; Wed, 17
 Apr 2024 19:18:15 +0200
Date: Wed, 17 Apr 2024 19:18:14 +0200
From: Christian Heusel <christian@heusel.eu>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Chengming Zhou <chengming.zhou@linux.dev>, 
	Nhat Pham <nphamcs@gmail.com>, Seth Jennings <sjenning@redhat.com>, 
	Dan Streetman <ddstreet@ieee.org>, Vitaly Wool <vitaly.wool@konsulko.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	David Runge <dave@sleepmap.de>, "Richard W.M. Jones" <rjones@redhat.com>, 
	Mark W <instruform@gmail.com>, regressions@lists.linux.dev, Yosry Ahmed <yosryahmed@google.com>
Subject: Re: [REGRESSION] Null pointer dereference while shrinking zswap
Message-ID: <4c3ppfjxnrqx6g52qvvhqzcc4pated2q5g4mi32l22nwtrkqfq@a4lk6s5zcwvb>
References: <3iccc6vjl5gminut3lvpl4va2lbnsgku5ei2d7ylftoofy3n2v@gcfdvtsq6dx2>
 <CAKEwX=MZ3jTVpN4g-qrhTn2b0i0C6_M=8BtKt9KEPyFHb+4W2w@mail.gmail.com>
 <CAKEwX=NM1y-K1-Yw=CH3cM-8odER1PZBVoWo-rs7_OdjFG_puw@mail.gmail.com>
 <CAKEwX=MWPUf1NMGdn+1AkRdOUf25ifAbPyoP9zppPTx3U3Tv2Q@mail.gmail.com>
 <246c1f4d-af13-40fa-b968-fbaf36b8f91f@linux.dev>
 <20240417143324.GA1055428@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mhle3o7wggiemwna"
Content-Disposition: inline
In-Reply-To: <20240417143324.GA1055428@cmpxchg.org>
X-Provags-ID: V03:K1:Hu6ARFsvvVHgCkcwEkS9dXvP2UmstGEy2G9caQYE9YebRql4Ioi
 N7LDq1Yi0B+vKFg6TUC+HnqNoStiFDWhQ0aSP9KKOCC+t7e9okgOcramfuLyMNric1ngQOC
 EDFRZdBTy6G4a0a7OCuNQ3blKaPXdGd2hHy6td15wwnlO5YjXHrEFqSf8M6vcd0pFMpze9J
 PSy4lUQwsoY2cjzDsADBQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:KftjsT67wLs=;cYmqR3MuM/YVoPw5qeslynROzWr
 tn09wZkFB1HdkJglMFSSINo64c4U37AxnR7c2/QTJN6VKWXi0t0wc5JU/x8XnyTOvssrndZ5B
 QliJu5O6E0gl9N+I6qo5tr3z5L0D/Im8WkCN4YAwP83yKRQNDOtFJ2RDh9U8U2ElG60FPInod
 fFbPZuRzTJQF672qgMk7BgP+FTalyKayMlIpAeyWiUNAMttZPC89jr2Bufcc3KoIhjWl0HoK/
 b12VPUHFKH36yhaL8D/1r1krTusoDYgcGlWnNdAj2e+cL8h/+xVVQdH/Prn7M+C6FsZgGrDmP
 polU0gmCo2NSQowUGCvge+KCZY5Fovua38Aoj28ldPalCG6JXyyu3Wh1ZSxbTYtT2N/o2p8Dg
 QJhPmSfPrwYG0GD1S5K8B7PfJ9lGDf/8/rSuwI72AzhnqFVy+9BLsxVOJa5s4pettAb23iSsr
 gztsflrO7B0+NkUfZeRZO9ebH4iuvnBPoRPpLC1P74EO5XDDTve/dH1L87vnCW8p6fcKyVeOJ
 9vhn2QN4vceIuzsy7vmiKH8CbkwIvnjzgAm+OrvFh/Ngf3POc1t10iBrPyKzf9ui8hzm/Vacg
 2d69VOUUNDwz5ADqkbU06RlyvkTM9AA2JCVTLqhAVBo+cEJTg/74DV2JScGZSo7YbePashWTm
 7FUKmBLAXkC+gSeorAN0Js+R9u92pyNZCc+GMQvLmpZKVjFzxKHAf/gcJUf5NAgzARRCCUMDC
 ZT+g1PXnHeGZMkmhUQ4ifm8In4Az9OznrDwx6Y5iS/5EOOydQ7h5z8=


--mhle3o7wggiemwna
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 24/04/17 10:33AM, Johannes Weiner wrote:
>
> Christian, can you please test the below patch on top of current
> upstream?
>

Hey Johannes,

I have applied your patch on top of 6.9-rc4 and it did solve the crash for
me, thanks for hacking together a fix so quickly! =F0=9F=A4=97

Tested-By: Christian Heusel <christian@heusel.eu>

Cheers,
Christian

--mhle3o7wggiemwna
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb3ea3iR6a4oPcswTwEfU8yi1JYUFAmYgBFYACgkQwEfU8yi1
JYUKdBAA4Fyzs10M1Ur29NG5u2SyE4mvONWC/sTTbVYJq/8EZgEunaQPmb7adXxl
xo1uqgxGFpGHSKzSqobkPnBWiVdabsHyWvOEZjtZ+r4IdF5dvPk5YNsgIK+I5JsZ
ulfwgtnAoDwF8AbgvELX4+SHm0Cm2fnzuZxW60AgNGVPXae7/TOoCE2Ex0Eu+gFq
k8grFw8zzvziyFEGcB7p5UQ+XSZZfb4LnHAcP88fqKSLON+nKfjTO8qze2cOzR3Y
ziv5IrhXLnjl/aXzood4pNsLJgR3p2FzpMTwBsXHvtUevYw6+gNYOE+3qtyjftfP
9nt12VSJUgTDDrLhQv4XPQDyHS8cqehPW75YmCnSktjpeGjmrTbKXmbQ4bh0bYRl
9df/G4yGefcCeLnt6eD8l4KgfRmyLepIS2BxwVnIVlK35Bj93kbey0LXrsFRL784
PCS/2FskmbC6DwDyfhcYrzt0OvUxcQWUJxgvD0qumE+WvyJcF6DmfN3yy3nSL6en
WHb68SYfB4edj6dNwVE0KtcR7EZFBi5/ETgBeHUTM99B6lcTElmCtG29qvj/nBYs
y9mUHFm8fFk1NWOcSFJYEadA/Zf4sw5e8JY4fAF4WbLMkpkKUm7bz1V/vfdyriaJ
vycgvzV9Q8nD2ccTY/3WYX5ePaiSLFdxbswqFnbDs09tcjHx/ro=
=ryG3
-----END PGP SIGNATURE-----

--mhle3o7wggiemwna--

