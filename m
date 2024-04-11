Return-Path: <linux-kernel+bounces-141240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D72BE8A1B31
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77C631F215A5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3C158231;
	Thu, 11 Apr 2024 15:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="riPvfi0l"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210FB5813B;
	Thu, 11 Apr 2024 15:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850954; cv=none; b=hHTEuCUdGFMvVOIKwslyU/i+A/F8vM2eIg/PFgvRYQwLZXWcN7fGi/veR266LQ0l3UOJ5mJay+zZO1xnppv+mmIk55xhPiGWthf2FdQdypGr5tsHbTfDvMd8W3mQtzwNJPxSRGqk1YIMtlZu2LFB4iv0KO5wmKZPcQJ/uUhm2ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850954; c=relaxed/simple;
	bh=0d1y9rY32N57eph8lfneQ9BlV1cLMrSb0BJ8cZM8V2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rJc2uFpz7W+hSJOu/C79L/D4wprjdU6VOPjWkiq8OFPuT6/rCpIKplvH1nb36sfZR0BSHd1KgsZayoZNT+x0ZBwNv9/C+rksl5B0imfRN2SkueH2Utxfak/zq8AmIUck1HvCML5WAouUQVARFuShuwsOyrRrljE2mAszWj/YdbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=riPvfi0l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94D39C072AA;
	Thu, 11 Apr 2024 15:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712850953;
	bh=0d1y9rY32N57eph8lfneQ9BlV1cLMrSb0BJ8cZM8V2w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=riPvfi0l+sGQSD2yaCU3Dh2aTEUg27SIxctHQg9IWQ5r1/OWt2KxG4KfJ2wDoM5WF
	 UWAn1O+DkIttQKY2r48vYT/q/TyO4ifV2UvrOFxVrHiBuGacBbdtLtoW1dZjs1oAYK
	 qiANAWnF1NBAzbLW4vZQ248ys3oRJo//LSOynWbtzMdMPesyfmOfJW/3EmdbiPRsng
	 kWO9fOo0YgCIqnf4uRkast+aVzWEE79npnS0pBXvIVUoBn9kwT0a8Xv7mFuVP6E50e
	 NxQIFqLB0pkfRAvO3o1I8bYMrOCHZFznxLVaLaV9Ox3meybsc1/qRo5Q71EXoDI4gn
	 D1rroa5C7drKg==
Date: Thu, 11 Apr 2024 16:55:48 +0100
From: Conor Dooley <conor@kernel.org>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	shengjiu.wang@gmail.com, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 2/2] ARM: dts: imx6: exchange fallback and specific
 compatible string
Message-ID: <20240411-shelter-overact-ad518e6e7003@spud>
References: <1712652644-28887-1-git-send-email-shengjiu.wang@nxp.com>
 <1712652644-28887-3-git-send-email-shengjiu.wang@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="G5/1QEQbSLLvAARd"
Content-Disposition: inline
In-Reply-To: <1712652644-28887-3-git-send-email-shengjiu.wang@nxp.com>


--G5/1QEQbSLLvAARd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 09, 2024 at 04:50:44PM +0800, Shengjiu Wang wrote:
> exchange fallback and specific compatible string for spdif sound card.
>=20
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--G5/1QEQbSLLvAARd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZhgIBAAKCRB4tDGHoIJi
0mDpAP9K2EBBVizbp4vQtZXUyf2uWZ8OGON9EkZngwASFNWFGgEA3ImnyynBo61d
ruuwXuqOjg13Kz+LlJ7nVIoY1Iy6EQg=
=dmOF
-----END PGP SIGNATURE-----

--G5/1QEQbSLLvAARd--

