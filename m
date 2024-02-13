Return-Path: <linux-kernel+bounces-64008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E328538EF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 18:49:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53A07B24DCE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 17:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB69604C4;
	Tue, 13 Feb 2024 17:49:07 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10221DFFC
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 17:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707846547; cv=none; b=rz26RhvLC063EiI8fpzbEdzX7qFqBrnVa5x6QBHwC/GNcCYZWR4do+wjGjnXMT7edHlfmJhkov4I9tyB9DJU5aJNGwgqmqDJ4mMfhpFWnLQmi9qv0Tl32yr68+OjxHCNoBauf0mQp52XRd915hnU535szXS/t178ZrakiGCaqW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707846547; c=relaxed/simple;
	bh=QWIuBAJ3e+TCWmBbhbpgT4PWb2RX18XR04uHZ6yIclw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fIPXGNJi1eETQBcogL0Hs8fE0kFWWbblk/szS2LXYLbMI3lOrWfrQADAuUZ5skbJKmBphyFEAlOASe6zz93O7ahgVfzw+43/jeFnRzcp5g+uGLuJiNlgWGXrCxVZUEhjE9SF6KGl2ydfk/Hv9SdCPIk6sDKwKxBO4l9oMpe+vA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rZwtm-0007eB-T1; Tue, 13 Feb 2024 18:48:50 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rZwtk-000Wtk-TI; Tue, 13 Feb 2024 18:48:48 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rZwtk-0046pb-2d;
	Tue, 13 Feb 2024 18:48:48 +0100
Date: Tue, 13 Feb 2024 18:48:48 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	John Crispin <john@phrozen.org>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH 1/2] dt-bindings: pwm: mediatek,mt2712: add compatible
 for MT7988
Message-ID: <onnokyq7ciza7i7jzc74cun2khpst5iocuccks2cm433ux3za3@dou4oacrvuxj>
References: <20240213164633.25447-1-zajec5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jhwaxkndpklwhxal"
Content-Disposition: inline
In-Reply-To: <20240213164633.25447-1-zajec5@gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--jhwaxkndpklwhxal
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Rafa=C5=82,

On Tue, Feb 13, 2024 at 05:46:32PM +0100, Rafa=C5=82 Mi=C5=82ecki wrote:
> From: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
>=20
> MT7988 has on-SoC controller that can control up to 8 PWMs.
>=20
> Signed-off-by: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>

please make sure that the email address used for sending the patch
matches the Signed-off-by line.

(It depends on the pickyness of the relevant maintainer if that is a
stopper or not.)

Assuming this patch will go in via a mediatek tree:

Acked-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--jhwaxkndpklwhxal
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmXLq38ACgkQj4D7WH0S
/k5Yxgf+MGDk4UWSSThMXzK6DjwTQdURT3za9jTq2ls/OQIHoQfyaw902waKPjVr
mPIVGTESq0AvIpQNcZQQH8WUjNfI7at0cWPaTA/iZD07h9nMOEztTp4wP3rYwBp5
yicKjx5McHb1nR5poDAXFudd+7v/gOgXBLPxABfx4FiOLWqnNuDJF2xwmge8mKHp
NKlYSZk+kiCbBwsZk3LBwLqKv45TnPI2yuayws+r1jYLnmXMyRUkVQqCpX2/CUGq
wESqm70l9ty5FmyiE86YbJkgx+b5o9Z/nJt223FluL3Ftnxfc0sABjdCI9IxmFCg
sWhDm4LJVkrMbtBmn8VK5huxt/BXmw==
=o3gj
-----END PGP SIGNATURE-----

--jhwaxkndpklwhxal--

