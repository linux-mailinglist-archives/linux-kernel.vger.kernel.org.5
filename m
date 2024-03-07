Return-Path: <linux-kernel+bounces-95041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1337D874883
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 08:14:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4534F1C20F88
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 07:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4BA1CFA9;
	Thu,  7 Mar 2024 07:14:02 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB841CD20
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 07:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709795642; cv=none; b=JXYeZTUTN5hcaBDNnKo8172cfkLgpqLtpej2x7OZB5avh9xz8xsCbyOo6alrbOTfBCB5JrXa6pKbvcIf8UIIXSwzv7nCh3KCc4ukvVnjo+3JfJWKJYVTXz0yYIsK3LxN2QuZLUaV98HmSx4kh+n2CJN2AEtS3WcqLBxhBuRq/Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709795642; c=relaxed/simple;
	bh=5zlwYFtWPKXZosDo2YhgUsXd+ljbLmv239/heo2OVEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DbN3atJg71P/J5fDgMQjImqKkYRJVVCwE86mqMVSM3v1SCO3ukodMXncg0OMr650EbZzm0mvOazuUJrpYwNRZwKjbBeTtnVh+OaEbZawPJM0eE0kXTLiioQGSQYqhJu5V7yFAXtWmy+UmZo40kZFh0uW2yjGrltyMjg/z3iBKTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1ri7wy-0003qH-RW; Thu, 07 Mar 2024 08:13:56 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1ri7wx-004tec-Sc; Thu, 07 Mar 2024 08:13:55 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1ri7wx-0016ag-2Z;
	Thu, 07 Mar 2024 08:13:55 +0100
Date: Thu, 7 Mar 2024 08:13:55 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thorsten Scherer <t.scherer@eckelmann.de>
Cc: linux-kernel@vger.kernel.org, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 2/4] siox: Provide a devm variant of siox_master_alloc()
Message-ID: <ftvih5huvc72a76s7fe4zisrqtaax5tcgoukqoi2bkz47zcrq2@4fixszonixgl>
References: <cover.1708328466.git.u.kleine-koenig@pengutronix.de>
 <ad141dd22c7d95ad0bd347f257ce586e1afb22a4.1708328466.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zki5axlgdtpejalp"
Content-Disposition: inline
In-Reply-To: <ad141dd22c7d95ad0bd347f257ce586e1afb22a4.1708328466.git.u.kleine-koenig@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--zki5axlgdtpejalp
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, Feb 19, 2024 at 08:46:30AM +0100, Uwe Kleine-K=F6nig wrote:
> +struct siox_master *devm_siox_master_alloc(struct device *dev,
> +					   size_t size)
> +{
> +	struct siox_master *smaster;
> +	int ret;
> +
> +	smaster =3D siox_master_alloc(dev, size);
> +	if (!smaster)
> +		return NULL;
> +
> +	ret =3D devm_add_action_or_reset(dev, devm_siox_master_put, smaster);
> +	if (ret)
> +		return NULL;
> +
> +	return smaster;
> +}

Here is missing an EXPORT_SYMBOL_GPL for devm_siox_master_alloc(). I
squashed this into to commit I created. Find the fixed commit at

	https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git siox/fo=
r-next

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--zki5axlgdtpejalp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmXpaTIACgkQj4D7WH0S
/k476Af/b+WPhxMkpceYzv70rfdFN/F6OQlH3fU4D08a+qbIi7ZxvTIhV+mR6P9u
bXbKQm6SJKMC3/eW0MAVftK8f/a2ZIEYMJBCYgsBhR7E96heXvsFroXpBO4gixRY
k1Vnvx+h71pX6O38MpF16yeA04t45htwU5YRxZwyYbSgwahu5KgTGXz3HBeiI1JO
yftmTNBO5di65/XrES3pHJGsCTRtCHhmPre3DbbwqAzNsW15jdBMx09qrA8rqkfS
xg1r/MUrWSGWeJoO5T4GcIow4KtrQbmiGF48diXY8Zc9LfSL88XE9pX4fxW2+i3G
DGBe3PvciT52CMpxkZ3xFykUaVfhsQ==
=jmv+
-----END PGP SIGNATURE-----

--zki5axlgdtpejalp--

