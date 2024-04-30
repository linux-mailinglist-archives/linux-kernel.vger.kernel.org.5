Return-Path: <linux-kernel+bounces-164201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A82CD8B7A97
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D26B1F218DA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 14:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F143770FC;
	Tue, 30 Apr 2024 14:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j8Epojar"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3E01527B9;
	Tue, 30 Apr 2024 14:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714488737; cv=none; b=AYe6RhT0xJjN6lQxh1bnKQJauaO2InxuEAX71OemCm6tEW+tkUub1kUtaXWq6pac6GKkdgn9j9Q74QdXCh6mg73XscbTA3gWoTKka3V6fZMEa/a6/OhUo1/ROA089NFY9UABkUySBn37Ul/cuPCTK0Ck4w7or2bl8NRL3HX/3Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714488737; c=relaxed/simple;
	bh=53TYS050ekFY+hCRJgoRydEbdy9KAeSVM7IKbSuCNm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IHUPowBgoZh+qA37mdfJ+HdEVGWpLOhesulJT6eZY7drCon3kEWrn0OXJrB1k+Iw+eMoMqeLnMTywIMwkaf9hvXp5Wz5HdyQlzit9x+Tm0IYUtbOJAFo8Gnx0BK14GCPaxLtnM59aTuStY+pPWAjpFixo0Qr4pnDeesibcaJLj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j8Epojar; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE075C2BBFC;
	Tue, 30 Apr 2024 14:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714488737;
	bh=53TYS050ekFY+hCRJgoRydEbdy9KAeSVM7IKbSuCNm0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j8EpojarNlsedEwjtCKTA3iSWhwIXd1JliB+DGEha/dE/3eOHpABarJ3X6CsV34oh
	 R6XeCaqV9rb7U1+yOJlq91YEse8pLKIC23K0OM/P4fkwLlQ/pz2Jk02BcYOPKFC8GR
	 12gKzm7gdPWZy6VWSrzFFLC2OZFte3RCATIjoUPFDNzE7j+6vj8EYlHQqFcjTucrrT
	 4RLrx+O+oXVYrbqfckBnv2YirNQBq4mBezBK3+cb2ILpQh8h0uOlI/AGpQKmuvNtMc
	 nZHpHinrEbMLEJFEgjKio8xHNJjV54Nml8e7VTqLa6RY0x1NRm4YdEgYdPqhYmywzb
	 VfNe3d1e0lhNg==
Date: Tue, 30 Apr 2024 23:52:15 +0900
From: Mark Brown <broonie@kernel.org>
To: Bhargav Raviprakash <bhargav.r@ltts.com>
Cc: dan.carpenter@linaro.org, arnd@arndb.de, conor+dt@kernel.org,
	devicetree@vger.kernel.org, eblanc@baylibre.com,
	gregkh@linuxfoundation.org, jpanis@baylibre.com, kristo@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
	lgirdwood@gmail.com, linus.walleij@linaro.org,
	linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, m.nirmaladevi@ltts.com, nm@ti.com,
	robh+dt@kernel.org, vigneshr@ti.com
Subject: Re: [PATCH v7 08/10] regulator: tps6594-regulator: Add TI TPS65224
 PMIC regulators
Message-ID: <ZjEFn43dNf1UFn3f@finisterre.sirena.org.uk>
References: <54eca1ac-288c-4f88-8c06-f5859bfa715c@moroto.mountain>
 <0109018f2f1bd112-3d9df5c2-8ed6-47dd-97fe-d724da6d2bed-000000@ap-south-1.amazonses.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3y5hQ7/3IW5AFlAE"
Content-Disposition: inline
In-Reply-To: <0109018f2f1bd112-3d9df5c2-8ed6-47dd-97fe-d724da6d2bed-000000@ap-south-1.amazonses.com>
X-Cookie: lisp, v.:


--3y5hQ7/3IW5AFlAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 01:05:03PM +0000, Bhargav Raviprakash wrote:
> Hello,
>=20
> On Thu, 25 Apr 2024 10:59:22 +0300, Dan Carpenter wrote:
> > On Wed, Apr 17, 2024 at 11:49:59AM +0000, Bhargav Raviprakash wrote:
> > > From: Nirmala Devi Mal Nadar <m.nirmaladevi@ltts.com>
> > >=20
> > > Add support for TPS65224 regulators (bucks and LDOs) to TPS6594 drive=
r as
> > > they have significant functional overlap. TPS65224 PMIC has 4 buck

Please delete unneeded context from mails when replying.  Doing this
makes it much easier to find your reply in the message, helping ensure
it won't be missed by people scrolling through the irrelevant quoted
material.

--3y5hQ7/3IW5AFlAE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYxBZ4ACgkQJNaLcl1U
h9DXMwf+PKODDwDeqON9VM4u0juqL+7Z/SE5lYR5NQ1gvMYOMKzPTld8bz/PB2kf
gC8pX8P1Y4oKkxn8V3Cnr+eVnkvo6i5bvj7rOmZErI9gSmAEihBztBT9PLUyrhH5
5EMosMXHlpPoN8GOC8isaz3MkASPD1fRa84BaIx0UxwH7ELiV0cmFsTzoU/nk1Vj
T2cqzZG0so1FqOQlJqyDsUzUOqSphIbZt8SPQ9CmgC3d//RJt8bBA6HX2+F5tAiV
3DuTuQOOaEV8XN2zJGJIUra5ZS3ye1Xq/qmEO0giCur0fNf9LnkUPLiiXbhm/qFu
w0yBjxzDbztR1l/3YBiBdL8QZUOqlA==
=HFcV
-----END PGP SIGNATURE-----

--3y5hQ7/3IW5AFlAE--

