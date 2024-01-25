Return-Path: <linux-kernel+bounces-39287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 253E683CE2D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 22:09:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D10A428C227
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 21:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540D113A242;
	Thu, 25 Jan 2024 21:09:12 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CCA1386BA
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 21:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706216951; cv=none; b=PTf4HtVW6lr2HGFC6oE4r+aI+4yIAhQfHttz10k2WeApmGsku8bA6gP0RC30mtq3TGt7p/YNia2jEGclEAS4ZqpDigB9nu/Lih5+XvIXOUNvnV2w9wacCgJ4IapXYOysOOCilcAdCguH/rEKXLdbZB8uAAWxZCpYbuEFwt5aeuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706216951; c=relaxed/simple;
	bh=IcnWFbFeltV8HxWW9c1zLGegMfKUJf5PpnCb80B3nwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D+38kkF2DJcN+RADGyWFzIPA6Ly95eyB/XjZZtg6w4A9/8RmCwRgUY9FSNH//LKv3EI7BxE45tyfqMNGKWmuvQd/oCUr5vPbJvPmuUNHjaPBDIg/21s/iPsq9YuQeW+7tiJFzYEBYeTuc1l//OOv9Ks7tPM3lN7cGvkBtOgOwBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rT6y5-0002Le-8r; Thu, 25 Jan 2024 22:09:01 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rT6y0-002N2T-8t; Thu, 25 Jan 2024 22:08:56 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rT6y0-0088tu-0Z;
	Thu, 25 Jan 2024 22:08:56 +0100
Date: Thu, 25 Jan 2024 22:08:55 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Wenhua Lin <Wenhua.Lin@unisoc.com>
Cc: Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Chunyan Zhang <zhang.lyra@gmail.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, wenhua lin <wenhua.lin1994@gmail.com>, 
	Xiongpeng Wu <xiongpeng.wu@unisoc.com>, zhaochen su <zhaochen.su29@gmail.com>, 
	Zhaochen Su <Zhaochen.Su@unisoc.com>, Xiaolong Wang <Xiaolong.Wang@unisoc.com>
Subject: Re: [PATCH V2 5/6] pwm: sprd: Add sprd,ums9620-pwm compatible
Message-ID: <fbozdjum4mhtke5jzku3uosaewnlct2pvhicytmnnilnsd62xw@amqjhr5p7a7a>
References: <20240125025533.10315-1-Wenhua.Lin@unisoc.com>
 <20240125025533.10315-6-Wenhua.Lin@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="znfqepqked6co25z"
Content-Disposition: inline
In-Reply-To: <20240125025533.10315-6-Wenhua.Lin@unisoc.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--znfqepqked6co25z
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, Jan 25, 2024 at 10:55:32AM +0800, Wenhua Lin wrote:
> Add sprd,ums9620-pwm compatible string to binding document.
>=20
> Signed-off-by: Wenhua Lin <Wenhua.Lin@unisoc.com>
> ---
>  Documentation/devicetree/bindings/pwm/pwm-sprd.yaml | 1 +
>  1 file changed, 1 insertion(+)

Please use a Subject prefix that makes the dt maintainers spot this
patch in their inbox. The right one here would be:

	dt-bindings: pwm: sprd: ...

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--znfqepqked6co25z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmWyzecACgkQj4D7WH0S
/k6OKAf9H9T1EY8/elPmqzxmhRb4r9KAT7To4xPfRqYiHdurc1a00NqM9WQs3Zh/
t8gGND6qE7YvH7TweKt3SvSzyILGuZyEwt6HDJxHd81HHuYca6FgxCfKO0hI58OQ
qfJMVmw8WleNiZNpBZqbIvYb8cD0q0Kk6oe8PnMVjf9mb1UtwbvN2uWI/8vDm/66
HoT5HsJjbhW2j6klkR1zRpfpxdhRhGHk9uTAT44xp+x9zqc0JNCAoBLZdwj/MI7e
wYl+JoGrutN7cbHIztX2J8guc5FAn4v+YLk+dGJTA9BxXdB19sYGlb4/ynEp9iL3
NmwmTgIN2+gO/eKxiFrMcqpSyQz4PA==
=tI7r
-----END PGP SIGNATURE-----

--znfqepqked6co25z--

