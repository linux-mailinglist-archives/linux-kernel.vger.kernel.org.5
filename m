Return-Path: <linux-kernel+bounces-95037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A0A874877
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 08:08:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7B451C215EA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 07:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B671CF8B;
	Thu,  7 Mar 2024 07:08:48 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E891CD1E
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 07:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709795327; cv=none; b=eUexk3PSnIXQQg94HoC9Q+DABH4iDtCCWbhVnBgsbI2C/60a2FnAvAFIkGBGSWcUYaAxQaW9P9QRNpGU+OZEcMfbDpC6fLrOgtgpI8SNCzHVvcObmq3wRmeev82DEQlNJT12JVXQT0KJ8VTNZdpJAYl2AC9o/U9b7JnSMdNgxBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709795327; c=relaxed/simple;
	bh=sMt28uQeUsJiCYuWfwPMwd6caxTuTqzewWN7hyu+GuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pMmYJ8UwJTaDzTb3zSgYLqJXOI1rEl3e5uS2CuwaQJ9bCxkzaEjhUpY+DTA6rHVrg2u4iGEG9AJjHBXsronv7h99guzSHkF2bAsI5eyRxjbkau/+oJ5OMQqP6ZOCcoMWL53MA9Td0pszLT3sZOSKdV4i+alsUT4DrYiq8qx97m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1ri7rm-0000zy-Pq; Thu, 07 Mar 2024 08:08:34 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1ri7rl-004tdh-8A; Thu, 07 Mar 2024 08:08:33 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1ri7rl-0016Ul-0W;
	Thu, 07 Mar 2024 08:08:33 +0100
Date: Thu, 7 Mar 2024 08:08:33 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, 
	"Ricardo B. Marliere" <ricardo@marliere.net>, Thorsten Scherer <T.Scherer@eckelmann.de>, 
	linux-kernel@vger.kernel.org, Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: siox patches for next development cycle [Re: [PATCH 0/4] siox:
 Move some complexity into the core]
Message-ID: <bdp3rbzcfvjvibyseqzwgmokj6hchwt6fxysjfg2vz5er67li4@ih6cpndluxlj>
References: <cover.1708328466.git.u.kleine-koenig@pengutronix.de>
 <lkgvr2t4wzw4jkfg523zcek6y2v5l7kj6onw77yffvvs7i2gfy@6ectsjpcg64t>
 <vg5yex3wpnfeibgkwmi33yazdxdz2pbhn4w72mnffqm3qtvjf6@gv3syxj6gsk7>
 <2024030655-sketch-conical-b506@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mnfzi4r4qfqk5vwt"
Content-Disposition: inline
In-Reply-To: <2024030655-sketch-conical-b506@gregkh>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--mnfzi4r4qfqk5vwt
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Greg,

On Wed, Mar 06, 2024 at 10:46:43PM +0000, Greg Kroah-Hartman wrote:
> On Wed, Mar 06, 2024 at 07:24:38PM +0100, Uwe Kleine-K=F6nig wrote:
> > On Tue, Feb 27, 2024 at 11:21:24AM +0100, Thorsten Scherer wrote:
> > > On Mon, Feb 19, 2024 at 08:46:28AM +0100, Uwe Kleine-K=F6nig wrote:
> > > The series looks sensible.
> > >=20
> > > Acked-by: Thorsten Scherer <t.scherer@eckelmann.de>
> > >=20
> > > @gregkh: Would you please pick up Uwe's series as well?
> >=20
> > There are currently six patches for drivers/siox waiting to be applied.
> > (Two by Ricardo and four by me.) Thorsten asked Greg to do so. Greg
> > didn't pick these up yet though. So I collected them and put them to a
> > branch at:
> >=20
> > 	https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git sio=
x/for-next
> >=20
> > I'd like to get them in during the next development cycle.
> >=20
> > Greg, what is easiest for you? Are they still on your list of open
> > patches and we (I) need just a bit more patience? Or should I send a PR
> > to Linus when the merge window opens?
>=20
> Yes, they are on my list, but I am way behind, sorry.  But hey, a pull
> request is faster, I'll go take this now, thanks!
>=20
> Oops, nope, I get the following build error with this tree:
> 	ERROR: modpost: "devm_siox_master_alloc" [drivers/siox/siox-bus-gpio.ko]=
 undefined!
>=20
> So are you sure you tested this?

Dang, Stephen notices that, too. TIL if I only do:

	make allmodconfig drivers/siox/

a missing EXPORT_SYMBOL doesn't make the build fail.

I squashed=20

diff --git a/drivers/siox/siox-core.c b/drivers/siox/siox-core.c
index ae103349c91a..24a45920a240 100644
--- a/drivers/siox/siox-core.c
+++ b/drivers/siox/siox-core.c
@@ -730,6 +730,7 @@ struct siox_master *devm_siox_master_alloc(struct devic=
e *dev,
=20
 	return smaster;
 }
+EXPORT_SYMBOL_GPL(devm_siox_master_alloc);
=20
 int siox_master_register(struct siox_master *smaster)
 {

into the offending commit in my above branch and did some more extensive
build testing.

Sorry
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--mnfzi4r4qfqk5vwt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmXpZ/AACgkQj4D7WH0S
/k6nMwf7BSoxxR2R7lVuowBHVHMkXUrDH7vvsFpfr1E2e4MpLHsic+XW2tUbS4xn
FGQ6P+4Ctg45WGuQydDxUI0xo6pfpKxMiv3VQXnSLThTkhb5iXhcNOxno49rUWtE
c4o3IHcZfdUHOMXN0TfUUpSCi1yoXwkoTpOu5f2CEON0Fl3Nn5A4hQ6sVUbrKz/j
Nh5qK3pfQPipxlZ0KYWYAB6tM7mZCs3RbA58DEvJY5spueCDtkj9d4IGzes8PbHd
EBecaIfU0rMCHggSf8uxhiZzSyDtTn0kYDKKSJfpHuoOC9rBSssj660v3efyWgft
vZkTym6yhKAdvsa6BOPufwFIcPHgVg==
=W5K8
-----END PGP SIGNATURE-----

--mnfzi4r4qfqk5vwt--

