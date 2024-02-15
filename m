Return-Path: <linux-kernel+bounces-67674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 139CF856EF4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 21:55:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD6332893CE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 20:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E7813B787;
	Thu, 15 Feb 2024 20:55:23 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C323913B2AC
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 20:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708030523; cv=none; b=XA7sMlVurpgdhXcLmtltoXtbwEq2saDdtPDaLujAwTnR+s3qUzWzyWwBjI+OSKg5P7ehct/ySV5NRnSbSZ/BH+n3xW0MrJPa4i2jg6izMmKnfMgF4A8vjvw9Xv14BqEs21dyWG0B2QD7HOBGivNeU/aDJLsBhxuS3rKjFsxAIvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708030523; c=relaxed/simple;
	bh=Jl9hX0FFtbCx2pj+rrVhqbxd1csWLSPwL7wjsbkZyOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PfGCIdVp8yECWic+PXwjgBJc2BNqNPJHKjrPOOwX5Kf22fEQx51w2xVbwm3Hdjp5POtVQDkPUOd9DB7ZaBkc/TpwxnX/Padyk543eeI3PRJprYAcS2C5EX+lO2F9GDBN9+TtQLdbO4lz6dZ1qd8xp675Y5HVIQCpnN/CC2+7dP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1railD-0007mC-Jx; Thu, 15 Feb 2024 21:55:11 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1railC-000wwp-9Z; Thu, 15 Feb 2024 21:55:10 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1railC-005dsj-0g;
	Thu, 15 Feb 2024 21:55:10 +0100
Date: Thu, 15 Feb 2024 21:55:09 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Rob Herring <robh@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jean Delvare <jdelvare@suse.de>, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] macintosh: Convert to platform remove callback
 returning void
Message-ID: <mdq5k6lq54c5t5yffjotkovrvzfh4uvt4qt4n6rwddmo26neqr@au5s5u3mkoet>
References: <cover.1704900449.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zse4sep35aklq4pu"
Content-Disposition: inline
In-Reply-To: <cover.1704900449.git.u.kleine-koenig@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--zse4sep35aklq4pu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, Jan 10, 2024 at 04:42:47PM +0100, Uwe Kleine-K=F6nig wrote:
> Hello,
>=20
> this series converts all drivers below drivers/macintosh to use
> .remove_new(). See commit 5c5a7680e67b ("platform: Provide a remove
> callback that returns no value") for an extended explanation and the
> eventual goal. The TL;DR; is to make it harder for driver authors to
> leak resources without noticing.
>=20
> This is merge window material. All patches are pairwise independent of
> each other so they can be applied individually. There isn't a maintainer
> for drivers/macintosh, I'm still sending this as a series in the hope
> Michael feels repsonsible and applies it completely.

this didn't happen yet. Michael, is this still on your radar? Or is
there someone more suiteable to take these patches?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--zse4sep35aklq4pu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmXOei0ACgkQj4D7WH0S
/k7Fhwf+NuS2VaUpbMrqUXSluHIMtZYy5acc235Gl6RrOPhOFsQiQHrZ5IHA39XT
C9ZZBaMBqtLUn5jSFA14l6ykQfWLwrubXNh531f6kzXa10ybh5zfJAI4T/53jBt5
Swk8OOwOXE/tvhRZuzsTUwwswWPloKEz953KIxHLaNp05L4Qq7WpIW7OOlVsCjM+
w+t1bHBfHpmhM9Rsaf5JiPXd4PXzpPAH1KeU5m6QhPw47CxrrcLuGxkF+VEs65+5
YGoDrpsbvgWCqmkvfFGb45yFYQn/4KgZtLcWpGSxHu8MHlwMu3EBJidxZNxl+rr/
H7BA9zyVjn2EBo2khLNl6R/TdBe+1Q==
=bXaU
-----END PGP SIGNATURE-----

--zse4sep35aklq4pu--

