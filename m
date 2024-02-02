Return-Path: <linux-kernel+bounces-49669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0389E846DD6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 11:24:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68C41290865
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 10:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E21B7C09D;
	Fri,  2 Feb 2024 10:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=haloniitty.fi header.i=@haloniitty.fi header.b="0sLOgMKR"
Received: from whm50.louhi.net (whm50.louhi.net [77.240.19.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F6C67A15
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 10:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.240.19.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706869478; cv=none; b=HIVr12YL1JEIbr5U5h6CrJllyV8/a+RYcM1YG+7KqXVLrQnOxxLJmSleANDBSv7sPbbldWzDsUk7iAhlJzOWahcOC5pZ2QfaMWMdKG1eAYpA9c/yBxAF+grZfoGzdooG8xRy3hPLLeqvRb07mUiSKtl37HJA3ok0c/f2E4yFCes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706869478; c=relaxed/simple;
	bh=2AyEO3WjzbVYRCvsG0OGDmUQiyGmoZJElP711bb9acw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fsKnGQLa4kKLZDaSffxbsGrh1fF2eWGzXf3SSRo65/CrxP0XQQ1eK6O8f8am3T9vSw+krks/Cbk1IUwK+/0iB3/QF5EJ3Tr1jhmL+0xU+dqhjXa7AuftLmqEQh66FMlWzArWQwSaeC4b+HWtVGgFttIbHuDpAQ1kOXo0oWs9UVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=haloniitty.fi; spf=pass smtp.mailfrom=haloniitty.fi; dkim=pass (2048-bit key) header.d=haloniitty.fi header.i=@haloniitty.fi header.b=0sLOgMKR; arc=none smtp.client-ip=77.240.19.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=haloniitty.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=haloniitty.fi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=haloniitty.fi; s=default; h=Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=rJfzlH9sqfGonvEbSfcn4i+zKDQycMv9TpYXdRT+j8I=; b=0sLOgMKR7xzGA0Z+J499ti35bw
	KSTjEINrVyw6nbf7vwR2s4qPuiZd/C7cdv1Ej9Vs6UA0H8oz/R+9/y9uBZlD0vLvd1X3Fwg8aMmBd
	2RG9EHPC/ZRHxOl19D6a+TppxmYUQxeXTGNTHZXjMpqtCVOhzhL33ZLjHDBBryiOlRfmornhpWJdi
	3Cd/dv/zXXLKTEv+1b2K4vxTqR0KlGhYKVKlbYfkxE8FQXWjM1AyfEtJJ+Ss46DQWJ603e/4aGsKu
	bkAgZnwN/YRaEOwoClWWJWwZ7fGUjyyTifEEa2lw1yapXnCEQPikI13TJxBRTIEu3Wo0FBEVUczgJ
	aMw4dWCg==;
Received: from [194.136.85.206] (port=60700 helo=eldfell)
	by whm50.louhi.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <pekka.paalanen@haloniitty.fi>)
	id 1rVqil-00017f-0x;
	Fri, 02 Feb 2024 12:24:31 +0200
Date: Fri, 2 Feb 2024 12:24:29 +0200
From: Pekka Paalanen <pekka.paalanen@haloniitty.fi>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Louis Chauvet <louis.chauvet@bootlin.com>, Rodrigo Siqueira
 <rodrigosiqueiramelo@gmail.com>, Melissa Wen <melissa.srw@gmail.com>,
 =?UTF-8?B?TWHDrXJh?= Canal <mairacanal@riseup.net>, Haneen Mohammed
 <hamohammed.sa@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, marcheu@google.com, seanpaul@google.com,
 nicolejadeyee@google.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com
Subject: Re: [PATCH 2/2] drm/vkms: Use a simpler composition function
Message-ID: <20240202122429.35d967ea@eldfell>
In-Reply-To: <20240202102601.70b6d49c@xps-13>
References: <20240201-yuv-v1-0-3ca376f27632@bootlin.com>
	<20240201-yuv-v1-2-3ca376f27632@bootlin.com>
	<20240202105522.43128e19@eldfell>
	<20240202102601.70b6d49c@xps-13>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/9FTWNX99FO+yZfaEdPw2Slv";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - whm50.louhi.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - haloniitty.fi
X-Get-Message-Sender-Via: whm50.louhi.net: authenticated_id: pekka.paalanen@haloniitty.fi
X-Authenticated-Sender: whm50.louhi.net: pekka.paalanen@haloniitty.fi
X-Source: 
X-Source-Args: 
X-Source-Dir: 

--Sig_/9FTWNX99FO+yZfaEdPw2Slv
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 2 Feb 2024 10:26:01 +0100
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> Hi Pekka,
>=20
> pekka.paalanen@haloniitty.fi wrote on Fri, 2 Feb 2024 10:55:22 +0200:
>=20
> > On Thu, 01 Feb 2024 18:31:32 +0100
> > Louis Chauvet <louis.chauvet@bootlin.com> wrote:
> >  =20
> > > Change the composition algorithm to iterate over pixels instead of li=
nes.
> > > It allows a simpler management of rotation and pixel access for compl=
ex formats.
> > >=20
> > > This new algorithm allows read_pixel function to have access to x/y
> > > coordinates and make it possible to read the correct thing in a block
> > > when block_w and block_h are not 1.
> > > The iteration pixel-by-pixel in the same method also allows a simpler
> > > management of rotation with drm_rect_* helpers. This way it's not nee=
ded
> > > anymore to have misterious switch-case distributed in multiple places=
   =20
> >=20
> > Hi,
> >=20
> > there was a very good reason to write this code using lines:
> > performance. Before lines, it was indeed operating on individual pixels.
> >=20
> > Please, include performance measurements before and after this series
> > to quantify the impact on the previously already supported pixel
> > formats, particularly the 32-bit-per-pixel RGB variants.
> >=20
> > VKMS will be used more and more in CI for userspace projects, and
> > performance actually matters there.
> >=20
> > I'm worrying that this performance degradation here is significant. I
> > believe it is possible to keep blending with lines, if you add new line
> > getters for reading from rotated, sub-sampled etc. images. That way you
> > don't have to regress the most common formats' performance. =20
>=20
> While I understand performance is important and should be taken into
> account seriously, I cannot understand how broken testing could be
> considered better. Fast but inaccurate will always be significantly
> less attractive to my eyes.
>=20
> I am in favor of making this working first, and then improving the code
> for faster results. Maybe the line-driven approach can be dedicated to
> "simpler" formats where more complex corner cases do not happen. But
> for now I don't see the point in comparing performances between broken
> and (hopefully) non broken implementations.

Hi,

usually that is a good idea, but in this case you are changing the
fundamental design of the algorithm. That makes it easy to add new
things (e.g. YUV support) that will be even harder to make faster
later. If you then later improve performance, that is another
re-design. You would be making maintainers review two rewrites instead
of one or less.

I suspect it might be less effort for the author as well to not ditch
the line-based based algorithm as the first step.


Thanks,
pq

--Sig_/9FTWNX99FO+yZfaEdPw2Slv
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAmW8wt0ACgkQI1/ltBGq
qqdoBg/9H4Xbbb1kW3lGDIJ5Vtedt3vyvL7GA94zXv1ZSpMUKMmFbAb4F4ylIXb2
b19g0ek1b6bqREV5At7OvME7AoXlnjmrua5eTTiR8D/EjZWoZLxfGraobXEqi/Lb
hZYTRuQts8JNw+b+ZTBHRM3yjqJd1P3kdwipj8GYhP0oR/7QPG1WdqoKt60vb1dZ
BLJoDz6bfVfQz7Z7Kd6/cLHrwz0BjNwHmRMRa2yf+pv/nTr5t2xXn268QIQMMR6n
6FUqrnOGA9KwPlk171Q5aHGRaGirSr7rgNUbJE/elxxYjI5/5k4Xf3SfjpmGkKeg
SrB35DrBfMzcxNVkvGl87tWeS0AR70qCW/AD3n0a4Ya3BvVXp+tTtFyn4efzjVUX
MT0XZnZ0P0yMdZDQSmRo179OVZSNmoF9blWDx9kvuucmnneERunrKUDtZvohwGLg
lnYOruORG6LeTVMQEyjsuu34tgXW1s6y8lJxyZlISLEp9gi/YhzBkEbr0kiRokv9
dTX7m5bymwQxJwJDbt2zKS+B+5hZtbi1TDFWkaZA4Ei5ppogUJITlUIAd8/ar1mO
DAI1QAS1w9bmltwnWGnihUHZy4Q1WZ0wI41oX8MpUTYMRSnInbWTCHlx01pp/zAQ
c9n+6XosGhawlI1U+mYdOHsWTRns8MO0GVH1ER5MhW0eHnE909c=
=BpXx
-----END PGP SIGNATURE-----

--Sig_/9FTWNX99FO+yZfaEdPw2Slv--

