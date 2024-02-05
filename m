Return-Path: <linux-kernel+bounces-52240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9622B8495D1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:03:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32E081F21248
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D437F11CBF;
	Mon,  5 Feb 2024 09:03:37 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BAED1173A
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 09:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707123817; cv=none; b=LS5wzNFviCXkXA5s8oYe/6GOm3hBTEcOJ6ZUkQOqBPE7+MutZQ++5lG/bGrQj8UONcGov9Rlexm2WvE9byEltlLkZXiFMzA7iSNn37M73e5edP46WLu43UXL37x52wufoNPHSm9NBg3/+irfcbDb47w/yGsfeOzvkeJ2U0aNyB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707123817; c=relaxed/simple;
	bh=pGJESLMO1IwzNYCOL2xCBZdT6xXtl1ti30ZNlzDvHm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tKaWd5tAYxXNMBO04OB9nsSVCDvuEQIM4n51rv/qTNiWvb9m/PLg8B1nMvdQd+mKyb36kBHUrS1Rs2KTLopBP85hS4XE4Lbpy737rmF31+yTg1p2M22/NshkDgKx+ff/m5/dorj07Q/XmJigaBTVnN4MuWnErg1XuDaKvsnwXKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rWut1-0007pG-Bc; Mon, 05 Feb 2024 10:03:31 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rWut0-004b25-Dh; Mon, 05 Feb 2024 10:03:30 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rWut0-00FKAQ-16;
	Mon, 05 Feb 2024 10:03:30 +0100
Date: Mon, 5 Feb 2024 10:03:30 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Thorsten Scherer <t.scherer@eckelmann.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] siox: make siox_bus_type const
Message-ID: <5zjixnsaylidn7t65thchwg5aa2igpwr34bmlfdtevvn4bgx2e@txzz36fi7rqz>
References: <20240204-bus_cleanup-siox-v2-1-3813a6a55dcc@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="e7n4nsuqdj5xioo3"
Content-Disposition: inline
In-Reply-To: <20240204-bus_cleanup-siox-v2-1-3813a6a55dcc@marliere.net>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--e7n4nsuqdj5xioo3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Ricardo,

On Sun, Feb 04, 2024 at 07:26:42PM -0300, Ricardo B. Marliere wrote:
> Since commit d492cc2573a0 ("driver core: device.h: make struct bus_type
> a const *"), the driver core can properly handle constant struct
> bus_type. Move the siox_bus_type variable to be a constant structure as
> well, placing it into read-only memory which can not be modified at
> runtime.
>=20
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

I currently have no setup to test this, but compilation is fine, and I
don't expect any surprises.

Acked-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Thanks for your patch,
Uwe

PS: b4 gave me:

  =E2=9C=97 [PATCH v2] siox: make siox_bus_type const
  =E2=9C=97 No key: openpgp/ricardo@marliere.net
  =E2=9C=97 BADSIG: DKIM/marliere.net

when applying your patch. I didn't check the details of the DKIM issue. I
quickly tried to find your pgp key, but failed (wks, kernel-pgpkeys
repo, keyserver).

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--e7n4nsuqdj5xioo3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmXApGEACgkQj4D7WH0S
/k7xxgf+LLjmbj64GabWDq+XrD+9ERrhY2sJzbZ3gpmKZQ+6LvwG96ZIIfR/6MqM
R7qv8VxSjK+IvBlBMU1OHM9bRVoB8ScL0RiI53cXiI2nN/dMx5/G2gz8AEXahTzI
0sIz/rE/n6V4LX4fPpOwU/K55Pzq1S9ZH+OVcW0iHWqUifJ9ZjyTfMOMZdMYEgdW
UJEYmDOQqmkWTd5p1u8tEx2U72GRVDBN0rdqrBhB2NWB0rK6J/d7nxLaKsOdXKqJ
GRFdME4fmDx6hIj7xTiiq/VWDGMg+3a84/qe01P0LxHbmJ//0HA9dnPI+VslULM9
DknbvdG5qbVdbvprlxj0QNYSHVKZwg==
=Zc7w
-----END PGP SIGNATURE-----

--e7n4nsuqdj5xioo3--

