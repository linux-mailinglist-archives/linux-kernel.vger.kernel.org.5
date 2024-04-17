Return-Path: <linux-kernel+bounces-148096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B948A7DA7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52A111F2371E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 08:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F07E971B24;
	Wed, 17 Apr 2024 08:02:13 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00D76F07B
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 08:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713340933; cv=none; b=p3Apic5ge0qrOpEm+448BDd+zukyValuBPJhujTpSNcm5PobCkOVzfa9Oub1DUcZTYLFmuGY5sztj3zcv63H9p5Sznl3jHcQLun2mbqZb9Vkiil6Axe6RNjhaFDDEzqk1IRfUF5YzbCUCv90QNNJC3u+SIAe23Ezlaw1/4KqCxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713340933; c=relaxed/simple;
	bh=xqgbBAr+qzpE6aT45CzHZDH1fguOizphFrZG7Cgilg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c5IvNtGP872PGB1uZXM3zR4Cn3s74Y0kdKxko3+eGMbps5S9TvyJe5aNM+GBnzpW5MVlTFN5jvm0hMw1Or60M2DDorQDFDolcl9UeiL2RLGl/65l18pc9wSUDib6T2cxYMOVFeJnDTtpFh2+tsyfq8VAppFKqFlbya7WErL7LYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rx0EY-0001q9-4l; Wed, 17 Apr 2024 10:01:34 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rx0EW-00CkmG-Qv; Wed, 17 Apr 2024 10:01:32 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rx0EW-002e73-2K;
	Wed, 17 Apr 2024 10:01:32 +0200
Date: Wed, 17 Apr 2024 10:01:32 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Alexandre Mergnat <amergnat@baylibre.com>
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Jitao Shi <jitao.shi@mediatek.com>, CK Hu <ck.hu@mediatek.com>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, dri-devel@lists.freedesktop.org, 
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 11/18] dt-bindings: pwm: mediatek,pwm-disp: add
 power-domains property
Message-ID: <22yeoik77sdhmg43odjftzjn2douq74zhxwy6qx3hsrvr53r5e@7w3f3zbgxult>
References: <20231023-display-support-v2-0-33ce8864b227@baylibre.com>
 <20231023-display-support-v2-11-33ce8864b227@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yebn7lkzwjt2edcd"
Content-Disposition: inline
In-Reply-To: <20231023-display-support-v2-11-33ce8864b227@baylibre.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--yebn7lkzwjt2edcd
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, Apr 16, 2024 at 05:53:12PM +0200, Alexandre Mergnat wrote:
> According to the Mediatek MT8365 datasheet, the display PWM block has
> a power domain.
>=20
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>

I already pointed that out in reply to the cover letter, so just to make
it more easily to spot for people considering to apply this patch:

This is already fixed in next.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--yebn7lkzwjt2edcd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmYfgdsACgkQj4D7WH0S
/k6aiQf8DDht8BJdwLA/chC/kqidSgtlv6qxFC1XbFLhIfSvyp8eqaLoaQk+lLDt
9WdQ2VOkHggnHje1S9Gj34fqnvGuJZcZkOnlXI7z6T19ngA1JzvAiKWtVuZbV6bC
Co9nKH9suzuEmBXk3SXdR2WILBaYxqP2UxfZ05BW26JCB+5JKxIMUH0c2tBKP5l3
3LmMOO36eJ95y3iHp8Q8I93qPZDYJhXDkFPehtepPzK30J3XeLct+6tQZUHAzyeP
BBLmoTFgotLZLsDeBpfMlGlgFKqibDM72G/Fh0vVgR1qCRUKFpiE6/xipzch5F3d
IbSttwKcXx3F0YSgQjx223hlA4c2yg==
=1L1v
-----END PGP SIGNATURE-----

--yebn7lkzwjt2edcd--

