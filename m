Return-Path: <linux-kernel+bounces-130468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E11FE89788A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 20:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AA222830B1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 18:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD5A154451;
	Wed,  3 Apr 2024 18:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="qMKKUSZV"
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6585B152E11;
	Wed,  3 Apr 2024 18:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712170099; cv=none; b=l0VVw0K700jWjKfHG9+fP98+SQZa/0gOEfbEm84x4Cw7UWhiAJbZuKEn6jXp96B+bbVJXHZq5oEtG/P9In911oN0A+B9O+RyceKDlgdOKLcOvCANvQdApWMn0a4Qw7hXO+1nRFX1WJ0mcL0Dnlgim5ngk9t9lYmlv48SNcAcnz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712170099; c=relaxed/simple;
	bh=K/mEWGGHah9AHjNaQJWc15nYOsNrbxisnfb/Qbn4y+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rh7R0+QZOjLpt9T72/LdBzzEcgm4oBd4Helkoyhd02lzcq5xlbkER3L8hyvZoE8prFgJD1lurexpqWje5d3xheySlei9Fejv/uW9VAQozNHBQ5tpKYF8AIj9bM1FztgG158BGFV9FBJeAyM4q/TSCi7ogXWXHpYAXtfe7XG8D1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=qMKKUSZV; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id E54841C0084; Wed,  3 Apr 2024 20:48:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1712170096;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=paT4YqJAMwkZlVJkVbExyZAdVySI9UAMlsKbRN2SBQE=;
	b=qMKKUSZVjKyIXhLKRbToX7OWbT98VFx0kPXAWcoqK8PBKk4Pt7/AbaMAspO/SfVBl69qHW
	GKJdrDjBMrFRe4wIuqTkmemGonOyf40YhJWegW5Zp1qDpql3h/X40M/Dgb9gkz0JmnQtXA
	f3vv5ZFlR47toYEpTGCZ/EzsoL17aKU=
Date: Wed, 3 Apr 2024 20:48:16 +0200
From: Pavel Machek <pavel@ucw.cz>
To: git@luigi311.com
Cc: linux-media@vger.kernel.org, dave.stevenson@raspberrypi.com,
	jacopo.mondi@ideasonboard.com, mchehab@kernel.org, robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, sakari.ailus@linux.intel.com,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	phone-devel@vger.kernel.org
Subject: Re: [PATCH v3 12/25] media: i2c: imx258: Allow configuration of
 clock lane behaviour
Message-ID: <Zg2kcI/1Gdgt0ilB@duo.ucw.cz>
References: <20240403150355.189229-1-git@luigi311.com>
 <20240403150355.189229-13-git@luigi311.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1OdbHON6Ov4LarD5"
Content-Disposition: inline
In-Reply-To: <20240403150355.189229-13-git@luigi311.com>


--1OdbHON6Ov4LarD5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> The sensor supports the clock lane either remaining in HS mode
> during frame blanking, or dropping to LP11.
>=20
> Add configuration of the mode via V4L2_MBUS_CSI2_NONCONTINUOUS_CLOCK.

> +	ret =3D imx258_write_reg(imx258, IMX258_CLK_BLANK_STOP,
> +			       IMX258_REG_VALUE_08BIT,
> +			       imx258->csi2_flags & V4L2_MBUS_CSI2_NONCONTINUOUS_CLOCK ?
> +			       1 : 0);

!! can be used to turn value into 1/0. I find it easier to read than ?
1 : 0  combination, but possibly that's fine, too.

Best regards,
								Pavel

--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--1OdbHON6Ov4LarD5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZg2kcAAKCRAw5/Bqldv6
8tkWAJ9GsEARZ8KugFSLPWIezuc14sMwlQCfTUh6JxGCkAI/h9MaZY6O+/OE3jM=
=uuSL
-----END PGP SIGNATURE-----

--1OdbHON6Ov4LarD5--

