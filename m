Return-Path: <linux-kernel+bounces-94390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A38873E6F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 19:24:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7A8F1F225BC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 18:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E43EF13E7C4;
	Wed,  6 Mar 2024 18:24:47 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447B613D309
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 18:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709749487; cv=none; b=GPVpxIymIuf33eHIsq8LdJWWJ758GLwvQvPSuiE6NzoT1jbkV0i+Zli82v6v0FCfy1TtNFHxncN/xBtiKIRxenS6JiC6PnGum7hLe5Vky8KIngNrh5XtF4RvZ8wMYaR/3ykBXWdX/b+Y/bfqj6lSd3w9mVCO2jVN+ej33KsHmuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709749487; c=relaxed/simple;
	bh=S2ScsCozofQuFrawqTkDlwj7gQ9QVm172HhbV0jGMhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pZO9I2tyIFO9gqBHzz20OV0n1QlT9pLDmcF25AFxociHW9fME/y8RUNqmPpBSQag+WnYbjU4h9g+FKok/9h9HDGE1NRuaAVbKxYQQLLI4Fi2xMt4aAN6ywAZs2xwbds+ZIC7JZFfIBXW0bCv8cEWAAJCuQrH7STFCCEIjT8DReg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rhvwW-0002K1-8i; Wed, 06 Mar 2024 19:24:40 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rhvwU-004nUp-V5; Wed, 06 Mar 2024 19:24:38 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rhvwU-000opw-2m;
	Wed, 06 Mar 2024 19:24:38 +0100
Date: Wed, 6 Mar 2024 19:24:38 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Thorsten Scherer <T.Scherer@eckelmann.de>, 
	linux-kernel@vger.kernel.org, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	"Ricardo B. Marliere" <ricardo@marliere.net>
Subject: siox patches for next development cycle [Re: [PATCH 0/4] siox: Move
 some complexity into the core]
Message-ID: <vg5yex3wpnfeibgkwmi33yazdxdz2pbhn4w72mnffqm3qtvjf6@gv3syxj6gsk7>
References: <cover.1708328466.git.u.kleine-koenig@pengutronix.de>
 <lkgvr2t4wzw4jkfg523zcek6y2v5l7kj6onw77yffvvs7i2gfy@6ectsjpcg64t>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bpkv3rmlcupjeju3"
Content-Disposition: inline
In-Reply-To: <lkgvr2t4wzw4jkfg523zcek6y2v5l7kj6onw77yffvvs7i2gfy@6ectsjpcg64t>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--bpkv3rmlcupjeju3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, Feb 27, 2024 at 11:21:24AM +0100, Thorsten Scherer wrote:
> On Mon, Feb 19, 2024 at 08:46:28AM +0100, Uwe Kleine-K=F6nig wrote:
> The series looks sensible.
>=20
> Acked-by: Thorsten Scherer <t.scherer@eckelmann.de>
>=20
> @gregkh: Would you please pick up Uwe's series as well?

There are currently six patches for drivers/siox waiting to be applied.
(Two by Ricardo and four by me.) Thorsten asked Greg to do so. Greg
didn't pick these up yet though. So I collected them and put them to a
branch at:

	https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git siox/fo=
r-next

I'd like to get them in during the next development cycle.

Greg, what is easiest for you? Are they still on your list of open
patches and we (I) need just a bit more patience? Or should I send a PR
to Linus when the merge window opens?

Stephen: It would be nice to get this above branch into next, no matter
if the patches make it in via Greg or me. Could you please add this
branch to your list for next? If Greg will apply them, I'll empty this
branch to not get duplicates.

Thanks to all involved people,
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--bpkv3rmlcupjeju3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmXotOUACgkQj4D7WH0S
/k7Pbgf/doRkYwETs5np5EkPuAdEK52wwa+hbDmORvc3iZmbunxYERLfcM3UAPUn
BcOVc6THL097ZQAE/8V9zjJz8E9ghABQMztRj64jN4TaKhK7Yn1U7WWQ0WQxNw24
VtMIVnVZ8WSpvDU5my6ZU4Z7oh/raQHfaSI8aVowAAsrVkIAZWQ9fB7b3mLnrySH
3vQeEqyjI572sD3rJ8RJAdYfDgZT4GmAeombS2ny6431VFpJicImwq+bmZKM14XW
GnIFaVpwEbXjYS/1zkK4F9/8i67y4TsEXBeS8t93oIYg2q7cXNqcQG0hncDCvrI0
LY7s7gvDRpf9ZG4svNg9bRuGBTzGxg==
=Vuh3
-----END PGP SIGNATURE-----

--bpkv3rmlcupjeju3--

