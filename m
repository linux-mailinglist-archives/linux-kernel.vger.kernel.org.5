Return-Path: <linux-kernel+bounces-108034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C385288050E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 19:44:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51E5F28546F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 18:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD50139AE7;
	Tue, 19 Mar 2024 18:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dh2E4n8m"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187C839851;
	Tue, 19 Mar 2024 18:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710873878; cv=none; b=JfoSkVrjaoYM4Rg5rW7tpVo/QL76xBnXQuI841z1QPBEGUprQRTsOzXscvqTdzL1bL8krNrObMxyG9RUMA1jLYwq5UG0uJmOIfvlQzEe1AoNQ3Ma7a45H9syHgyi87SZ93hRoqHXXP0tNdhQ4we+HCPX76yiuTg3g5LV1tgpTkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710873878; c=relaxed/simple;
	bh=eykXbNBTzb7E9g6ClQ5jPgt/K6w/Fn3798hQhh4Yd7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dzS/SjulMlFBX9G26PaK5XrKqB5QxLGgYdVKSeDVbuVwPE2Gdu1sx7ltnwCT91JmfVn506FyQ3cxB992t7Nx4EdQCH2VCMJjh/RPE0P/Y1d7hRC+nA7BRyR1LWEELbVOi6Yx38mC7Nm4jx2KZ9XoJA4oAAwc7U6eYgwe6WdojuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dh2E4n8m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B17C4C433C7;
	Tue, 19 Mar 2024 18:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710873878;
	bh=eykXbNBTzb7E9g6ClQ5jPgt/K6w/Fn3798hQhh4Yd7Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dh2E4n8mbR3N79HKUSdlWi4Qgs2aJExgQj2SvN2v0PecZUsYQSJ9++sZ/odYw2IEk
	 daVJZuKWI0aRZPQmVwLnQbGms29ixbzqBm99hWp85wYImeecn/DDFgasg/xi14jifE
	 mxqAKVoZ6p0+Y1PDr8LZPb5NIScskv2DlUfHKRoboYiYrrhGN7s6gsTijDAQZqN3lv
	 90ffKduypJhhnuudbBrYZxyGaWtQM7SRu4rQ3oHHVIfRDSe3x5/Wsem6LHkg/+n++R
	 z4n+W1+nbgMYVeGaD5/rFFPardBuWG2+5UYKZZYx+t1A2EgFAucK+q+4y8PtLoSeP7
	 92nRCw5jQYX1w==
Date: Tue, 19 Mar 2024 18:44:33 +0000
From: Conor Dooley <conor@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
	Niklas =?iso-8859-1?Q?S=F6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] dt-bindings: timer: renesas,tmu: Add R-Car Gen2
 support
Message-ID: <20240319-subtract-mauve-328ab7d37c7b@spud>
References: <cover.1710862701.git.geert+renesas@glider.be>
 <dd77275fef23ef3dc335a43ffa9aeca0ff7c41c6.1710862701.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0PSrOh1DEvO6Yqy6"
Content-Disposition: inline
In-Reply-To: <dd77275fef23ef3dc335a43ffa9aeca0ff7c41c6.1710862701.git.geert+renesas@glider.be>


--0PSrOh1DEvO6Yqy6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 04:46:05PM +0100, Geert Uytterhoeven wrote:
> Document support for the Timer Unit (TMU) on R-Car Gen2 SoCs.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Conor Dooley <conor.dooley@microchip.com>

--0PSrOh1DEvO6Yqy6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZfndEQAKCRB4tDGHoIJi
0s5IAP9caQGqr8qYnXmZXd60dCFwwvKX3W+kbWOQAc1eyR4JngD/VKi96f86Ef3R
gmDz0ypPKSx7U4MscGA8fcBSUuXg9gc=
=T4VR
-----END PGP SIGNATURE-----

--0PSrOh1DEvO6Yqy6--

