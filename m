Return-Path: <linux-kernel+bounces-39915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F6983D75C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 11:08:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF7E01C2F6B1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07A11CF8F;
	Fri, 26 Jan 2024 09:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="YttUgaxp"
Received: from mail.subdimension.ro (skycaves.subdimension.ro [172.104.132.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C310C1CA8D;
	Fri, 26 Jan 2024 09:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.104.132.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706261149; cv=none; b=AFWKf0Ptt1HJT5lj2Uv1/gCmKwt8zbOKJZqe70xQ9zH0YxK/t4Ua2R1T7X0S0DoqufsRuPlPQCjgAQYgSBPMV9CQNY9ZE6F0qVQ/YG86zz7R/iLYtDnOdwaefEJlxCoaAt0Zn29wFaiGaf+nUZsMRYHVh6XIRe9OxgNFXh56kW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706261149; c=relaxed/simple;
	bh=n1UBKAu2ZgXN3cWai6jMRx5pc8gubthvcwbKikKKg3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mmKjgfmg4CDINBkpMc8mrTRLx0lYuoJ3EBxIO+390DYunqfeSZbmAGeqtodbmqHAaOG1esdEsvUy7T4/1iP7+oWoZ58z/adcfuBdrq1Sy/H9+yhzjMdyAWR7IfbAW2zJLfzwyXjix96pfubMQ/JOvYVO835x3jBTpQjyBE88ScE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (1024-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=YttUgaxp; arc=none smtp.client-ip=172.104.132.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from sunspire (unknown [188.24.94.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 13D5928B531;
	Fri, 26 Jan 2024 09:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=subdimension.ro;
	s=skycaves; t=1706260710;
	bh=n1UBKAu2ZgXN3cWai6jMRx5pc8gubthvcwbKikKKg3o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YttUgaxpksQHLTeHn0Hb0BPTrat5FxykCUHJwI+qKvaTADWKd+3lNkZdI9UvnCQwG
	 hZ4aJ3ii1dpTVaU+sx7IljtS/h6lexJaEmOAr4rZ0P6F1Q4rH4byiQgKN+EEz+8d8p
	 uSr3392UmlC/IyQdWe6rZescC3cS1AOp+Eu3w5AE=
Date: Fri, 26 Jan 2024 11:18:28 +0200
From: Petre Rodan <petre.rodan@subdimension.ro>
To: Dumitru Ceclan <mitrutzceclan@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ceclan Dumitru <dumitru.ceclan@analog.com>
Subject: Re: [PATCH v4 5/5] iio: amplifiers: hmc425a: add support for LTC6373
 Instrumentation Amplifier
Message-ID: <ZbN45P3yAZxtb8jA@sunspire>
References: <20240117125124.8326-1-mitrutzceclan@gmail.com>
 <20240117125124.8326-6-mitrutzceclan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="W4yEtjcCTOC3q2WB"
Content-Disposition: inline
In-Reply-To: <20240117125124.8326-6-mitrutzceclan@gmail.com>


--W4yEtjcCTOC3q2WB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


hello Dumitru,

I know this is not part of your current patch, but you might also want to h=
ave
a look at ltc6373_write_powerdown():

hmc425a.c:239:2: warning: Value stored to 'ret' is never read [deadcode.Dea=
dStores]
  239 |         ret =3D hmc425a_write(indio_dev, code);

cheers,
peter

--=20
petre rodan

--W4yEtjcCTOC3q2WB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE2Ap/wXYVGTXsPl+pzyaZmYROfzAFAmWzeN8ACgkQzyaZmYRO
fzBf7RAAjWm86CjoHWJlT6gbM37H+Lb91tIr2zGAt8neIdjIv1TZNHv05LTbRLy5
LQ+RdDK6GGRI17aflYYpdeauAyKr+aHnf7o5E73e0p/R9cVN5MmvWgc0oUjcIFHf
r8IFvWpSrt9XWgUMBzoxqYkFmzKgVytqJtIUTXbpTGhFld1lZNFyEi+vRV/zSrxk
qmRZ7Ry7xZ+BTAJuKatIFsqmCPjnV7b/5myc4U4ekKm9/6x/jL6ZtTjywBFCeb5K
UKmQAeHQWWLdxeeUq1xGovEPLs2kgxUt5fEJcNyNiuELcfWkefXxy4xmzsieyPiB
galm9pXqxojORHaFB5zdH1fIoyid7p/YqtxsNrvNHT6avlhPjjCD8lepI/cCD5tT
4W/5GGwd0L0MJozkw5fR+yem4BqVFCsMlTMbB+oDU86KjpsFgWGYJ+4gUi/mAzaQ
xBtlrMmed6X21Np8AfpXd5528PXpU5Uk2QU9+acqKjp5RM4TB4Qx2cDVkD9/wfTn
ttCfD0cM/Q/PKViOEQlo9Iko4yVHYW9vjHupbmLAS5qgh7Pdgp5mwjqejC1qkXYc
6QsQJ67JG7VEFcbxjR8XpjAABKcgfFPGLKZwNMDq5/1NcAi8Kkg7o3FVAlB0iHN4
aJ7Cap9euRjp4ZXV+BYOa6vHwKegf4etzbB5BIaq9ubF4yIZ2Z8=
=N8Nm
-----END PGP SIGNATURE-----

--W4yEtjcCTOC3q2WB--

