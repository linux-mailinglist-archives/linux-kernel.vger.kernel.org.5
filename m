Return-Path: <linux-kernel+bounces-31755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF0A4833382
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 11:04:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E28611C21412
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 10:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD2F0D268;
	Sat, 20 Jan 2024 10:04:40 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65763222
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 10:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705745080; cv=none; b=nZLvJHEfyckO/nui71YgQZDbjsIwiOGXVS7c0sIZ633TpHmnBztjNjP0OrURLqDwa2rj/tX/QClAbdE1KN/p6fwcLcCas8El/gwG8I+G6z18N2A7659ScsvGF/sr+2KY8/tcy+ep5SU+9r0kbftQoQQHRgFMUVMECS3e0fxO05c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705745080; c=relaxed/simple;
	bh=pkuENZ4SIPfpvozPTXrY7v9vPtesecOlQ4AiQhqNgxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XtwsdQT3ukjb14C5EnVeSYdL+zM1asG1CUcdtspTnCDS0dvHkMfT0C4oFoogph9WswKUA6pRlEN9YVCmkVS7CWyQySYH2GATTpMLqU/fGsCxLctisQAPK3uZTTv0acRy2FTuQYF/RDlTm5rNusf2v5y3+HP26Ne7QAzlKNAVFqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rR8CU-0004RC-U0; Sat, 20 Jan 2024 11:03:42 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rR8CS-0017A8-2m; Sat, 20 Jan 2024 11:03:40 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rR8CR-003wrX-39;
	Sat, 20 Jan 2024 11:03:39 +0100
Date: Sat, 20 Jan 2024 11:03:39 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Dharma Balasubiramani <dharma.b@microchip.com>
Cc: conor.dooley@microchip.com, sam@ravnborg.org, bbrezillon@kernel.org, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, 
	daniel@ffwll.ch, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
	conor+dt@kernel.org, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, 
	claudiu.beznea@tuxon.dev, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, lee@kernel.org, 
	thierry.reding@gmail.com, linux-pwm@vger.kernel.org, linux4microchip@microchip.com
Subject: Re: [PATCH v3 2/3] dt-bindings: atmel,hlcdc: convert pwm bindings to
 json-schema
Message-ID: <xv5nv2tzenkuppfhcrhkfv3ntc5n5p5pt5mka33dwd26jkkdda@agskejqaabwk>
References: <20240118092612.117491-1-dharma.b@microchip.com>
 <20240118092612.117491-3-dharma.b@microchip.com>
 <kht2fxv2fbeod4pakk6q6m4gthftdr6asjqjojgb45kqlsrxpl@37umfctsorhs>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hn4duuuau4xew7c5"
Content-Disposition: inline
In-Reply-To: <kht2fxv2fbeod4pakk6q6m4gthftdr6asjqjojgb45kqlsrxpl@37umfctsorhs>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--hn4duuuau4xew7c5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, Jan 18, 2024 at 11:16:49AM +0100, Uwe Kleine-K=F6nig wrote:
> On Thu, Jan 18, 2024 at 02:56:11PM +0530, Dharma Balasubiramani wrote:
> > Convert device tree bindings for Atmel's HLCDC PWM controller to YAML
> > format.
> >=20
> > Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
> > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>=20
> Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
>=20
> I will update the short log to
>=20
> 	dt-bindings: pwm: atmel,hlcdc: Convert bindings to json-schema
>=20
> to match my preferences (unless you object) and apply for next after the
> merge window.

Dropped from my todo-list after Rob's feedback.

Best regards
Uwe


--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--hn4duuuau4xew7c5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmWrmnsACgkQj4D7WH0S
/k4Evwf+JZJx7peQB9ZNaNwVOaGScaRce7jQlkr6TZUH+fszttEseyB/tucPO6F1
wwQR5xcoJ3OTeAhwycSX5D8DTn6fvaT4Dj8CSxoHdVQ+VxilKSw93Pf0F7Bu/BJ5
+24zWaEiBkUj3LuAubJ6p2uvec+BLZ8iS+iD8s93fXsst0P4Rxn6D3NMawIZdRfY
pZlJLBFY1jG4oqulbJZkVHCKz+tm2D/Prn6M/156bqvhXmAdSL6nDSU8hWwUGgsR
KTwbMOAfYM97UTx6ejOmH/ZEeDwQioDl30OYLluBRCu0A0og5v7Rf7Tj2IBLjqfW
V3c4Jy3A6Uoy4+MMynVotSSuwwmlAw==
=P0ik
-----END PGP SIGNATURE-----

--hn4duuuau4xew7c5--

