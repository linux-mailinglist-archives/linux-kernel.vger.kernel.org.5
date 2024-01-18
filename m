Return-Path: <linux-kernel+bounces-30593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD58832160
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 23:07:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7C42B21DAD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 22:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D5E31A7E;
	Thu, 18 Jan 2024 22:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f6NCM36u"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590122E848;
	Thu, 18 Jan 2024 22:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705615627; cv=none; b=dzUmWikykFz3Us46h16OW1GUADna+bXJed/u9XdVjrz6nQzQ+fzlHROID0iamIM8k/MPoe6unBv/R0l9mTC5Lo0c7cujVYhPwCrVIyJH5jxV03aBszgNVals6mzd+MJZhHOyFmKyCXtf5FUQcb3rYkWyQRODZaHas1F4pj0iSOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705615627; c=relaxed/simple;
	bh=iseU8jQdo5TbasDTsLDq2FqVB/V3B0OwmtPqZ4AdvHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f4J63nFtowQhI4lXfXEcNvnqpZVe+P1TtXEnhdlMAx5sj71WlMPncXRDofiPfvcb3WR/V/uZ9L08CqFR5f8BfwkIPo5rtiU8ml9PoySes8J7hd9jIfo4E10frsROMj3/gDtdoHzWcCojPrzKobO9R83eX0Hu6BXpuLRV7r3R6Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f6NCM36u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 596ECC433F1;
	Thu, 18 Jan 2024 22:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705615626;
	bh=iseU8jQdo5TbasDTsLDq2FqVB/V3B0OwmtPqZ4AdvHM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f6NCM36uAeF0IfTRbUH03Lri3cCsoKdvkLTwbchpoXLnitcPpd2hQvJji/o3GJod9
	 FVsOKYovvKJDaYreDsXBWTluZtFP5GoI6bAR+GGtV7JHSdpUd303Qj0bmzYzNX0V1s
	 +wSwD8JbKfT/moIH/rGvb2peKnPGeoeRhrPa57Qho/NdTgQpG/TyPa4+HuQ3k6BA4O
	 9RK6KXgdBsb9Mtu0RrVHfyNQjAm8BEKErTj6Q9H38l9ubDqPgFndwYsRpcKVBMXorN
	 j1gY6KZB3CaOyOabqW28lhoKZxU/V0KufzcJ9hlvOLMTIDS6WMWXJvCYEYYVDspYy3
	 W8yfgeaCBxdhg==
Date: Thu, 18 Jan 2024 22:07:00 +0000
From: Mark Brown <broonie@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>, lee@kernel.org,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, linus.walleij@linaro.org, vkoul@kernel.org,
	lgirdwood@gmail.com, yung-chuan.liao@linux.intel.com,
	sanyog.r.kale@intel.com, pierre-louis.bossart@linux.intel.com,
	alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 6/6] ASoC: cs42l43: Add support for the cs42l43
Message-ID: <b1889bb0-2b9f-477c-80d3-a636b9017ea4@sirena.org.uk>
References: <20230804104602.395892-1-ckeepax@opensource.cirrus.com>
 <20230804104602.395892-7-ckeepax@opensource.cirrus.com>
 <Zali4qxdegY7H6eY@surfacebook.localdomain>
 <aec96f5a-b759-48c7-a5ec-bafe3bfa5357@sirena.org.uk>
 <CAHp75Vd6JtW4ddbSPXUp6WgEdBJizjwnS-XZzwLcXWWLxFWp-w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="71ujX23WTb2DYuTK"
Content-Disposition: inline
In-Reply-To: <CAHp75Vd6JtW4ddbSPXUp6WgEdBJizjwnS-XZzwLcXWWLxFWp-w@mail.gmail.com>
X-Cookie: FEELINGS are cascading over me!!!


--71ujX23WTb2DYuTK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 10:46:28PM +0200, Andy Shevchenko wrote:
> On Thu, Jan 18, 2024 at 8:11=E2=80=AFPM Mark Brown <broonie@kernel.org> w=
rote:
> > On Thu, Jan 18, 2024 at 07:41:54PM +0200, andy.shevchenko@gmail.com wro=
te:
> > > Fri, Aug 04, 2023 at 11:46:02AM +0100, Charles Keepax kirjoitti:

> > > > +   unsigned int hs2 =3D 0x2 << CS42L43_HSDET_MODE_SHIFT;

> > > BIT(1) ?

> > Given that this is writing a value into a register field called "MODE"
> > it seems very likely that it's an enumeration value rather than a
> > bitmask (and similarly for all the other places where you're making
> > similar comments).  Please think a bit more about the code being
> > commented on when making these minor stylistic comments.

> I read a bit further and have given a comment about this as you put it
> above that they are plain values.
> Please, read my comments in full.

I did eventually find that while going through the other comments but
given that the earlier ones hadn't been revised and it was all a bunch
of different fields it still seemed useful to highlight, if nothing else
it was a little unclear that your later comment applied to all the
fields you were asking for updates to.

In general in a case like this where the code is already in tree it does
seem like it'd be better to just write patche for the stylistic issues.

--71ujX23WTb2DYuTK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWpoQMACgkQJNaLcl1U
h9CCeQf+I21xMOQThraPXK85uU2p913UhGWbaP7HY9FD+DAulq1voxw9sDv5OoFD
ciLzUlxTW5AGYUk1xAKqSHaxLf7PYAztwmpSXO3NBY9khrbEbBTNpcylDRzKgrQx
ZhQAbiD54n6wKFCn6efN+Rh+8xXxP+XvRd2Dh8CVeWydMoRQaKs8GB0SnXr32F3M
irPxz+pFuUEi6uYVqn4FPY3nowFTSqTiL3AzjtfXsK1MTl2MDlwcJdld0jr6bCk3
GzrjYt+MDyyjj2Gk7LzEvNrZfgggAOH3KCNttfwRL9yO/bV7981VyOmdbzA7wxPL
yQVLQLMim55rdMKYjPcsaLFGmCTEfA==
=A+RS
-----END PGP SIGNATURE-----

--71ujX23WTb2DYuTK--

