Return-Path: <linux-kernel+bounces-43132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9767840BF1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:43:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ACFC28817F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D4815702D;
	Mon, 29 Jan 2024 16:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xe2Ru7KI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F449664D2;
	Mon, 29 Jan 2024 16:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706546548; cv=none; b=g6c3Wtr3RfXWnAlH0wVIpkT0gwvqzkYhTHeLPrB2Nb4eMxQp7plg2tPuAjaoqvaHlzdHO+QvYGcwFYLheCVPUaL4qiOyohtHtv7uSMnXBH9RNtdEBBU6HI1sQAfzunuj1HAULM9pD6AelqwU/jo3cYdHpY+A8OUDcF+Sf54+9DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706546548; c=relaxed/simple;
	bh=g3GyVwVm9A2ORsU6HtbjS2gjCOf/orJ2eMhSmwsWz5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uee9VI0jtfJENcl8RtDxp6CwrTdDJnO7EQ3/v2W61XluLD9+N1p/jZWy1IF7DOL0HQe7mb7hLXcvP9fVlY8Wp3xwb3BqyL2RSJQGlgWe/8NjPwNVN0f8YvbVfIIqkOTEbW4CInATbNqIlWoItN0cVpLqKceiIkqybqmsbGTHd6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xe2Ru7KI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA5F0C433C7;
	Mon, 29 Jan 2024 16:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706546547;
	bh=g3GyVwVm9A2ORsU6HtbjS2gjCOf/orJ2eMhSmwsWz5Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xe2Ru7KIOUinWP3vGIcfmWHxSKIc8ljP+Bo10KK2EP+LOP+j/KpzGbkU2rKfYmKTJ
	 JNjralO0DsqImisealJ0UWoUZxEvmKGHJ4OdyITG2hjbkEGK8Hs4f12Qui2oNAGzIP
	 XDXF0xF7IvynwXTQet/C3LjS5tgDX1DBaTMox181pNbyudIAfJO8SrSZ8Xk5GnjrdV
	 yJ4QDN2Tf/IoQfmREozaubTVFcBhKmAy3+OY6oRXKteoNcMBXCV+T1MRihnq+WS/nc
	 RdHiNSu1acggs1ARXjOaRS00WpqbHWFuhqlUi41Z2nIJPhfYYsXedGCXomewS4ody2
	 ZX/PnZaJ8P05g==
Date: Mon, 29 Jan 2024 16:42:22 +0000
From: Mark Brown <broonie@kernel.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Sam Protsenko <semen.protsenko@linaro.org>, andi.shyti@kernel.org,
	krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com,
	jassi.brar@samsung.com, linux-spi@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	andre.draszik@linaro.org, peter.griffin@linaro.org,
	kernel-team@android.com, willmcvicker@google.com
Subject: Re: [PATCH v3 17/17] spi: s3c64xx: use bitfield access macros
Message-ID: <56f81e10-86b7-4bd6-938c-e2e9acd6a755@sirena.org.uk>
References: <20240126171546.1233172-1-tudor.ambarus@linaro.org>
 <20240126171546.1233172-18-tudor.ambarus@linaro.org>
 <CAPLW+4nL6D7R88Q_kJjAT-bWTFBk8a=FT0vL+fyRgxaDeSyhNw@mail.gmail.com>
 <b5ecacaa-8ccc-4588-b3be-4b5f85813909@linaro.org>
 <CAPLW+4nN--gG9XsOu6a-mo5vcM-GycRrhPQFOtNidfVTM=KonQ@mail.gmail.com>
 <facbcbf3-7dba-43a1-b4fe-ac77b5bef545@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DaUgeyoITWwGHbnv"
Content-Disposition: inline
In-Reply-To: <facbcbf3-7dba-43a1-b4fe-ac77b5bef545@linaro.org>
X-Cookie: Jenkinson's Law:


--DaUgeyoITWwGHbnv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 27, 2024 at 03:44:24AM +0000, Tudor Ambarus wrote:
> On 1/27/24 03:38, Sam Protsenko wrote:

> >>>> -               val |=3D S3C64XX_SPI_MODE_BUS_TSZ_HALFWORD;
> >>>> -               val |=3D S3C64XX_SPI_MODE_CH_TSZ_HALFWORD;
> >>>> +               val |=3D FIELD_PREP(S3C64XX_SPI_MODE_BUS_TSZ_MASK,
> >>>> +                                 S3C64XX_SPI_MODE_BUS_TSZ_HALFWORD)=
 |
> >>>> +                      FIELD_PREP(S3C64XX_SPI_MODE_CH_TSZ_MASK,
> >>>> +                                 S3C64XX_SPI_MODE_CH_TSZ_HALFWORD);

> >>> Two people complained it makes the code harder to read. Yet it's not
> >>> addressed in v3. Please see my comments for your previous submission
> >>> explaining what can be done, and also Andi's comment on that matter.

> >> I kept these intentionally. Please read my reply on that matter or the
> >> cover letter to this patch set.

> > I read it. But still don't like it =F0=9F=99=82 I'm sure it's possible =
to do
> > this modification, but at the same time keep the code clean an easy to
> > read. The code above -- I don't like at all, sorry. It was much better
> > before this patch, IMHO.

> Yeah, I guess Mark will tip the scale.

All other things being equal I tend to try not to get too involved with
minor coding style stuff in drivers.  People do seem to like
FIELD_PREP() but I have a hard time getting *too* excited.

--DaUgeyoITWwGHbnv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmW31W0ACgkQJNaLcl1U
h9D1sgf+LsNlBetwedyUQFVkLWeD2/eL+pfYu8FM0WZj/O6r4MV2XRHnCBXfL473
NLaB0yLgsgtPb86HqHYBS2btNVBJK4PFOcLChFITzvAUc/1VQGEeS7ZCcUF3BNA9
3wqAL3YScnNgFBDTT4Mr/jis+phwYukz8uC+ThBVRFUMQhe/ujrL6yJJAxFjf1Nd
gyAVOQvDDL6FmlGVrUg//dAddncv7HXiXDKv0cLqdtqYKMF7MTBRABw+Cc55NryM
aXw3zjIItX9v4bGy5YB0PcoB0QaOlQaM8UXZ9mxPItbY1AAw6IJzVarKCZUg66HG
9stVfnJhiRnXanRUk/YMGyVbYKT4Cg==
=GxVd
-----END PGP SIGNATURE-----

--DaUgeyoITWwGHbnv--

