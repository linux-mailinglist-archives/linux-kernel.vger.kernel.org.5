Return-Path: <linux-kernel+bounces-52847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8339B849D65
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:51:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A831F1C211B1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF8F2C68D;
	Mon,  5 Feb 2024 14:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="ZItH0I+L"
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4AC228DD5
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 14:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707144694; cv=none; b=JKQjGMLulrDJOY0NUWad/JELG8JbfK9sTdC5y60ZN7EO7gptEgPt0T7NYMdXcxufzNJMSowEYFfz/7lrh9sj8nQHtQ9zQ0lWd+8bfTEd/dCSkeax9CuVnIH24httv2w6gRtMAsawLf1clPT2ZBZyn9q4MMHVV1tH2I6LwBZQRpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707144694; c=relaxed/simple;
	bh=/evvuSLtY+5ZoydW8IlFA6frLXp7QJTRcPWzdwiRF8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ltVUEiwtg3RJzUd1zmDwCcFPoaq813m72q6mF5ovGua6SBRfbr7zsZBvKxiVGPY62xbVneVhJcFRSFfmslGEnH0e1rsMlYe32/Mg5YSu0MlL49h7WTx95iXf5HGudkEG9mROcbMkuXil7FjKGK08ZO9TV+BuTd+sq/9YdGfr2pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=ZItH0I+L; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=/evv
	uSLtY+5ZoydW8IlFA6frLXp7QJTRcPWzdwiRF8A=; b=ZItH0I+LEt56ufdr80j4
	by/IqZPXbenTlzRFQ8Iem04x/XIQnFibX/QdvokHp1MZngLjcgUOkrWAUsxlk9yK
	eHfeInVf121342z10nRmwqZu1DsnaVqSLPH2LDklpJYCKAKuW/A1v56odz3chvdz
	x90npaS6OMhVfDB45jr+I+VLnAsfuGfwIzWIeVJZsL671EVRKl/LSli4G5y9XYlb
	GcPw9I/IJsBp3i8Og7DNGDMcMFPXASqnkZIl3nsBX+Ek6Og7Lup54uLx+aDfTq5i
	78O4+r9sJaXjrxspv38RFEAQdkYTiVFnTTViAU9tA+e9ilGxKttmF/sXUgXJ2+gT
	fw==
Received: (qmail 855922 invoked from network); 5 Feb 2024 15:51:27 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 5 Feb 2024 15:51:27 +0100
X-UD-Smtp-Session: l3s3148p1@81qjmKMQyrcujnsZ
Date: Mon, 5 Feb 2024 15:51:26 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: claudiu beznea <claudiu.beznea@tuxon.dev>
Cc: ulf.hansson@linaro.org, yoshihiro.shimoda.uh@renesas.com,
	masaharu.hayakawa.ry@renesas.com, takeshi.saito.xv@renesas.com,
	linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH v3] mmc: renesas_sdhi: Fix change point of data handling
Message-ID: <ZcD17mTRnfIaueAW@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	claudiu beznea <claudiu.beznea@tuxon.dev>, ulf.hansson@linaro.org,
	yoshihiro.shimoda.uh@renesas.com, masaharu.hayakawa.ry@renesas.com,
	takeshi.saito.xv@renesas.com, linux-mmc@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20240205112702.213050-1-claudiu.beznea.uj@bp.renesas.com>
 <ZcDdn2AVz8FIXzak@shikoro>
 <237bd5c8-184d-4e46-ba66-253e3ef0c895@tuxon.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qEqW1x4AbDvxYxZ7"
Content-Disposition: inline
In-Reply-To: <237bd5c8-184d-4e46-ba66-253e3ef0c895@tuxon.dev>


--qEqW1x4AbDvxYxZ7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > According to my understanding, we should only mark this TAP good if it
> > is in the range 5-7. I need to double check with Renesas, though.
>=20
> OK, my understanding is that it should be in the middle (beginning being
> the tap that triggered change point of the input data, end being the next
> tap with the same ID). This is what I understand from this: "As the width
> of the input data is 1 (UI), select TAP6 or TAP7 which is
>=20
> *the median* of next TAP3 from TAP3."

Yes, I agree. With 0x0e, that means TAP1+2+3 are changing points and we
should be far away from them, like 5-7.

But: I am still waiting for Renesas to answer my questions regarding
SMPCMP. I'd like to get that first, so we have clear facts then.

> > Boot failure is one test. Read/write tests should be another, I think.
>=20
> OK, I'll try also read/write. Do you have in mind something particular?

Nope. Just consistency checks.

> > Because if we select a bad TAP, bad things might happen later. To reduce
> > the amount of testing, read/write testing could only be triggered if the
> > new code path was excecuted?
>=20
> I'm not sure how to trigger that (or maybe I haven't understood your
> statement...)

I thought something in the lines of:

- print out when you needed SMPCMP to select a TAP
- check the log for that printout
- if (printout) do read_write_tests

Dunno if that makes sense with your test setup.


--qEqW1x4AbDvxYxZ7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmXA9eoACgkQFA3kzBSg
KbZncQ//f/ax+lI9WQAUTFM3v2A9bA6nLjRcWJr9G/EpZeEtrNs4C0OakdRE8Gwi
CLENdlS9pUSVUrHyfjv1LXo/SD+xcj3tHL42yDJ3m1zStuh2Vu3mvvvhcnFX+qcq
5EUjvtHpGfSg5QokJ0AV0U22DXeJOHWOXJK/PS+OnR9He66Xm+PC9PxFea5rzVQw
0xBqz/uUKC1jSqIWMHniAKsHh4sWMi+hgKdfdG9n1AbW89ofU8A3wN7PyggZIQz+
vYJvQgVuhfcr7hgLVo3wrayWfZfPpolF2Sbe6ThIWTEm1ZmDUAmM8buJ6vWKZwbl
e8k0JknLSRfrI+e09x57IbHDqx8O4e6kgIwQ5H/jlel3q236bWaLszRetw86IW+K
t/2kiny7aPRM2msFGoaefXtwDNSTBzLS9HIjoWlZUAkEzNozv+PTsKAczXheI0bu
ouZOPam/L9V49PaSrijs2d4+SKHiuRrP/QDA993SCIRmQ8eFTkGfpVpRnTyM6+Gd
xqzBzWI/U89x5U0isr0lZDlfiFs3IyVIdnSa+thcdaaUzJOYnN6axGvR5vYhNujR
zv7ptO3ZpetT7IodiYyIxXDo+zuesne9yj4X3HWnFiyuivBqauedUqtKHtgQeRqL
kcav4NdwvzUdqRN/HxDgLu81KXlwibniQEK0edE/M26kCl4jMCs=
=5JaQ
-----END PGP SIGNATURE-----

--qEqW1x4AbDvxYxZ7--

