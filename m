Return-Path: <linux-kernel+bounces-107892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B118880315
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 18:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C86D0283BF3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 17:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35718208D4;
	Tue, 19 Mar 2024 17:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iKjNIz9C"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B45E25601;
	Tue, 19 Mar 2024 17:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710868276; cv=none; b=Q6ZFrQAvMUXMRvrsIlOEDaanC8R6GwzfCsueHGsLmnsIhuleyXPFKtfjNs7Sk4Hs4lAuEnHIHNBWuvVFzM7XlpW2RSfy2/UOJ20FIwYAiDKI0tkRi+Y3XQb8Tk8w1f0/npPNWaq8TujYg7NiNOan6VYISEiR57T+EwXjgcpq3gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710868276; c=relaxed/simple;
	bh=AXUUA0MHhoFgs3p9tiIKZfmiVx6wFX8jEmLp/axwRCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sVS6mZOpOAwkcHuXezXPAHL0cIFMhfGMUiUFkPnLVcRqzEXfPYN7alO3BiawgAQkxBtj/UQQmlNIEQw2NSCaXeCa3q0JgIqn3QplKvfcuctf7xcjpw5cw2AIbug/2xbmcRUvd5EV8J3bYBDjSoApetsJB93ERgZLmjT3gie1GAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iKjNIz9C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54D4EC43399;
	Tue, 19 Mar 2024 17:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710868276;
	bh=AXUUA0MHhoFgs3p9tiIKZfmiVx6wFX8jEmLp/axwRCk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iKjNIz9CzHgRbmJYyn7RDFWoVSskgL7NJuYUxk7+cPb1m2hbGdUGbNLCyo802GB+G
	 D+Wwjk/3Vgq4c6G3DyxA22o/b2cu72riCCmXwmpc5jGiA5x9m3HZ0yqtdLqtOxHtSM
	 uFFhJGZq6KGYVnaYLumPzn8uhK5+LUflt8hAFOVKixSg5XtjGQrWQfj/jcOAxQ8bQF
	 mprDNKAQeCoGciQMSR4ivZxg2x9IdQbx5zUDssXZyGlg32gTZITWalFwKJuhqQV8y/
	 0Iz4vH8Dx5Hlp0I58QpOBbtJ4B485rdYhZHIhQ7x50AKPzFc7xeguWyGqfWPMpW2FD
	 o4saCxWUJ93qw==
Date: Tue, 19 Mar 2024 17:11:09 +0000
From: Mark Brown <broonie@kernel.org>
To: Harald Mommer <harald.mommer@opensynergy.com>
Cc: Haixu Cui <quic_haixcui@quicinc.com>,
	Viresh Kumar <viresh.kumar@linaro.org>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, quic_ztu@quicinc.com,
	Matti Moell <Matti.Moell@opensynergy.com>,
	Mikhail Golubev <Mikhail.Golubev@opensynergy.com>
Subject: Re: [PATCH v2 3/3] virtio-spi: Add virtio SPI driver.
Message-ID: <cfb5092b-ad8f-4364-8655-8f797c428b25@sirena.org.uk>
References: <20240304154342.44021-1-Harald.Mommer@opensynergy.com>
 <20240304154342.44021-4-Harald.Mommer@opensynergy.com>
 <99afc631-c02b-42da-a8d4-87c65087f390@quicinc.com>
 <5dedcd26-ed59-415f-b978-87a546a0816d@opensynergy.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="U3aj3hIp60dvMzZi"
Content-Disposition: inline
In-Reply-To: <5dedcd26-ed59-415f-b978-87a546a0816d@opensynergy.com>
X-Cookie: You were s'posed to laugh!


--U3aj3hIp60dvMzZi
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 04:05:55PM +0100, Harald Mommer wrote:
> On 18.03.24 10:39, Haixu Cui wrote:

> Looks in my setup like this:
>=20
> virtio_mmio@4b013000 {
> =A0 compatible =3D "virtio,mmio";
> =A0 reg =3D <0x0 0x4b013000 0x0 0x1000>;
> =A0 /* GIC_SPI =3D 0, IRQ_TYPE_LEVEL_HIGH =3D 4 */
> =A0 interrupts =3D <0 497 4>;
> =A0 spi,bus-num =3D <1234>; /* <<<=3D=3D=3D This here has been added */
> };
>=20
> The "spi,bus-num" is missing in your setup so you use the default of 0.

The default should be dynamic assignment, why would you need a fixed bus
number?

--U3aj3hIp60dvMzZi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmX5xywACgkQJNaLcl1U
h9CX2wf9H3E0UNXhWUm+l3tVXXnXvcmMdUJKkKmVSQoF3Lbu1dQkub2gIAgs1/QA
Yi248HgER2Ktt1S4ToKpr+8/jI8uraFmfCYobLjsyi2OqANMiOHdE371lyy608WN
x1e4BtDFk5rp4/w+LThE5BureH9ue/EVjM3ad2QFjDHJzj4pTgKIKxxbU2uZ41TD
ZOqnW6k75su7/4DSL03Mjwar/ahz8X/aO/pcXWLiZhbUUeYZKerSmvPxXzveKrXw
lA4f63tl8yx3v8uoM/g9R31wcdL/kTrxKPyaH/Cm73CoDiepNBKg2ZhQEKxFGdUc
/RCWNccSxPQnLOsn5h+rHgg5R1OGWg==
=5WeE
-----END PGP SIGNATURE-----

--U3aj3hIp60dvMzZi--

