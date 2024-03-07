Return-Path: <linux-kernel+bounces-95152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE43C8749D9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 09:38:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BFA51C21402
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 08:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7002E82871;
	Thu,  7 Mar 2024 08:38:15 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81AA070CB6
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 08:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709800695; cv=none; b=SdEl7tIToRNukVvJW+vsXAfOam9mGLk0t8PIfebf/xmkqmpr5VPHAxPmgkN29Me2AqyWE2nTojIQKyg0eT1K0/FVvlLlVtgHOkBAgdwdOSAv4JhzLIwuz/KEIkzXs0QIBQaQyPwU/KKPz2Vr7OT8sHK2G7ChuoDnseZPAIQiKa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709800695; c=relaxed/simple;
	bh=bHjlpHWaEbmpZV+hZrKypfzaNKlhkvXJ8fl0dPqepsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mjO3rjdYeJuADkGt5v5DdiEFo2tzA9RM9DHXkHVXX450khtyUbASD8gt5jh/hz7gcsx4JotHvEiEuUStmBH8QMLnDpmu31zP7S/jxnw7+9eEwsoDP748uXDt0beLLcRZMzxju9rZqGaj1mJ4p/oXlzwf8Ydo0bhNtnJb1M9UK1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1ri9GS-0004ev-2K; Thu, 07 Mar 2024 09:38:08 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1ri9GR-004uDc-Eu; Thu, 07 Mar 2024 09:38:07 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1ri9GR-0018aK-1E;
	Thu, 07 Mar 2024 09:38:07 +0100
Date: Thu, 7 Mar 2024 09:38:07 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thorsten Scherer <t.scherer@eckelmann.de>, 
	linux-kernel@vger.kernel.org, Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH 2/4] siox: Provide a devm variant of siox_master_alloc()
Message-ID: <nuchb5aaywc5vr6cof4gqbavq4rkte3hvzgs6au3lbg6s6wlq4@bvbjevbum7kc>
References: <cover.1708328466.git.u.kleine-koenig@pengutronix.de>
 <ad141dd22c7d95ad0bd347f257ce586e1afb22a4.1708328466.git.u.kleine-koenig@pengutronix.de>
 <ftvih5huvc72a76s7fe4zisrqtaax5tcgoukqoi2bkz47zcrq2@4fixszonixgl>
 <2024030732-ocean-handbook-161f@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iexi2dbitxjecp32"
Content-Disposition: inline
In-Reply-To: <2024030732-ocean-handbook-161f@gregkh>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--iexi2dbitxjecp32
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Greg,

On Thu, Mar 07, 2024 at 07:29:59AM +0000, Greg Kroah-Hartman wrote:
> On Thu, Mar 07, 2024 at 08:13:55AM +0100, Uwe Kleine-K=F6nig wrote:
> > On Mon, Feb 19, 2024 at 08:46:30AM +0100, Uwe Kleine-K=F6nig wrote:
> > > +struct siox_master *devm_siox_master_alloc(struct device *dev,
> > > +					   size_t size)
> > > +{
> > > +	struct siox_master *smaster;
> > > +	int ret;
> > > +
> > > +	smaster =3D siox_master_alloc(dev, size);
> > > +	if (!smaster)
> > > +		return NULL;
> > > +
> > > +	ret =3D devm_add_action_or_reset(dev, devm_siox_master_put, smaster=
);
> > > +	if (ret)
> > > +		return NULL;
> > > +
> > > +	return smaster;
> > > +}
> >=20
> > Here is missing an EXPORT_SYMBOL_GPL for devm_siox_master_alloc(). I
> > squashed this into to commit I created. Find the fixed commit at
> >=20
> > 	https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git sio=
x/for-next
>=20
> Can you send me a "real" git pull request so that I can verify it is
> what you say it is (ideally with a signed tag)?

Sure, can do. I will do that tomorrow when (and if) my branch is in next
and so got a bit more exposure.

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--iexi2dbitxjecp32
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmXpfO4ACgkQj4D7WH0S
/k6dXAf+KjA5Y0yJ90tLksWs2HCiNUIFeyJgJalnzW3Xu+cmbdORk02LYObLQWMw
je2XXrIVcs4dFwAYVMi69UzVzya5OE+v65nPUQq4SWZF8QV4mn6mOeO4nUAJQe7c
vPGQo30cIxJI9V9AZGpoFOcJtwfvCMVpq4B3Rp8GN/t5l6nqRzmIG29ltWyZ8L2k
SsjF0dcDMMRxcu1pFp49A6Y27YCzaBvax1vOG++3llIFWkAVLKJqOBxYKSIFXXE8
1OygyudfOucmLGZTAeo33Od5gigiGOZ/U14kkqsEnVVMp4bIE9coFiSW4Xqo+7Vq
nzD53yNEjOoLN9XCzKxKJxB1p2ZFVQ==
=ikPF
-----END PGP SIGNATURE-----

--iexi2dbitxjecp32--

