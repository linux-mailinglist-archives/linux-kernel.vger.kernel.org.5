Return-Path: <linux-kernel+bounces-132781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34977899A12
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 11:57:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 640B0B21BA7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 09:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A6416C44D;
	Fri,  5 Apr 2024 09:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="pXq43Nyv"
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96AE616C43C;
	Fri,  5 Apr 2024 09:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712310908; cv=none; b=qhtI9Vejb0ryDdB2tvw6IOldglDdQ0TX/hB/CHbvmNy4PwRxh6E2ccwcE/3oKVIkaO4/HijVoICqhbpQxOrWYlOTkoEuPsKZfNfrxfWcHvVSst8rdzjtSamzTgZ5JJateB0S4kII4MW2byHVlTpVUez+jAhyrvQoiVUJbhKrFww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712310908; c=relaxed/simple;
	bh=NyWIdfoLw4+Om5494u2pahfJXuPCd1feRA04/HEmkhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dzbMP29pkhj1lpajurlplH9exkFPg4LSSx8UChlhN/bYFIHx5cIsxMpEaXRBPk17COOr+N5zDf9v5lD7W76VEH6AsykbMt/cs/ogSRwqYv9cl2hyuN5lMjFCjIL5BW204qCvm/TyOElxgEGNjf0BmhRInftAexiSg5AOMckEHeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=pXq43Nyv; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 5F22D1C0081; Fri,  5 Apr 2024 11:54:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1712310898;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KeeSzrV/c8t8t/nPYFpFifWuxbREJt0Oh2urSISuXnE=;
	b=pXq43Nyvr4+L+9FP3GWnql7Lv0CHkXyMhVFm+sfYi/+RkKZOMqxacu72RVctjOwMkTGq/N
	mpuQ1AAI+ydn4pdTIlAxuDEXo3+BWP8kIaifTqQilFiWuwefKA8DiJnRg3R/j7byKnvjIC
	xvU5oYJ2quDsoQNuzG1YjL3fitmsm70=
Date: Fri, 5 Apr 2024 11:54:57 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Luigi311 <git@luigi311.com>
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
Message-ID: <Zg/KcQ6OI5QhgMaI@duo.ucw.cz>
References: <20240403150355.189229-1-git@luigi311.com>
 <20240403150355.189229-13-git@luigi311.com>
 <Zg2kcI/1Gdgt0ilB@duo.ucw.cz>
 <6c15e492-411a-40aa-b02e-83b8a6d107da@luigi311.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="webUCHTtncLR1UEx"
Content-Disposition: inline
In-Reply-To: <6c15e492-411a-40aa-b02e-83b8a6d107da@luigi311.com>


--webUCHTtncLR1UEx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2024-04-04 16:29:11, Luigi311 wrote:
> On 4/3/24 12:48, Pavel Machek wrote:
> > Hi!
> >=20
> >> The sensor supports the clock lane either remaining in HS mode
> >> during frame blanking, or dropping to LP11.
> >>
> >> Add configuration of the mode via V4L2_MBUS_CSI2_NONCONTINUOUS_CLOCK.
> >=20
> >> +	ret =3D imx258_write_reg(imx258, IMX258_CLK_BLANK_STOP,
> >> +			       IMX258_REG_VALUE_08BIT,
> >> +			       imx258->csi2_flags & V4L2_MBUS_CSI2_NONCONTINUOUS_CLOCK ?
> >> +			       1 : 0);
> >=20
> > !! can be used to turn value into 1/0. I find it easier to read than ?
> > 1 : 0  combination, but possibly that's fine, too.
> >=20
> > Best regards,
> > 								Pavel
> >=20
>=20
> I assume you mean by using=20
>=20
> !!(imx258->csi2_flags & V4L2_MBUS_CSI2_NONCONTINUOUS_CLOCK)
>=20
> I can go ahead and use that instead

Yes, I'd do that.

Best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--webUCHTtncLR1UEx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZg/KcQAKCRAw5/Bqldv6
8mS+AKCFPh0X/iB6sA+t92hWIheMuvdPJgCgrDY5MXzkkvty0rnIgJpFyEfabBg=
=ZRF5
-----END PGP SIGNATURE-----

--webUCHTtncLR1UEx--

