Return-Path: <linux-kernel+bounces-67372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52BD0856AB2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 18:15:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 554CCB2707F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 125F4136672;
	Thu, 15 Feb 2024 17:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L19myfkJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56529A41;
	Thu, 15 Feb 2024 17:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708016838; cv=none; b=c6jX04+KKGvPm8sOLkJTVx7q5cYu4+CaNRWlxJ2eZbAFV9DpMvoQNTvFXD+jk4zPylZBPKg5CHS7mVX9ZcsRVeHurUA4XxXltIDp+s4sW6TBZcyK9qS5dSG5bLGhZtoWKBkMOPUE4owH8oD8o6dMNy7NP9m49SmRttXGsmHdQeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708016838; c=relaxed/simple;
	bh=2asH+tFhAWjLqNzzIq56m1OL7FiVFPqmNlQQz3tdsas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eVbDvdwTFOR4iYSG7b70LySNotjaPNwA8uXmpQI1H8HDC5BmZgGnyviX3ZV+AAKyYk6Fvp3Mf0Agakc0RiOxClkNnqLYTEFyMx4QfZPWhpct3on3wd4RBFvEz22xt7lmt4B68B54bomLTDraPaoel+4JHijHW7Wx0L18ziOliM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L19myfkJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF322C433F1;
	Thu, 15 Feb 2024 17:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708016837;
	bh=2asH+tFhAWjLqNzzIq56m1OL7FiVFPqmNlQQz3tdsas=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L19myfkJ+7APjC59ZGBiIdknXGONeEzfarjoEkAg1oerdjcjq4l5UWIGWanIEGw2h
	 xdmX3tQE3k+jJiqINDy84QkFyzwq0JQ3i1dl9RNm9ao2BvaFDlYUn7ceTAS3FI+5Wi
	 +3arUmcDgX1crlAaobeq8X++sF91VWAGiDiliHfEPnbCzHb65WGqM19dxivq0HOcv3
	 pzNT5GCyNyrmtjMMgodD4ERd6RKsH+I8hdZGRS/PoJjGh2TEPlIefhinvYJBwJiaVZ
	 K5TrCc8OegbWt9N+P24FYqf9c7zrowuvNBZuJ4lrIGJnCCurhG+T6xqdKG0KyLO1lv
	 EJwmvXQWv7Ccw==
Date: Thu, 15 Feb 2024 17:07:12 +0000
From: Conor Dooley <conor@kernel.org>
To: Heiko Stuebner <heiko@sntech.de>
Cc: neil.armstrong@linaro.org, quic_jesszhan@quicinc.com, sam@ravnborg.org,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, quentin.schulz@theobroma-systems.com,
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: Re: [PATCH 2/2] dt-bindings: display: panel-lvds: Add compatible for
 admatec 9904370 panel
Message-ID: <20240215-deranged-winner-dc7fba991e59@spud>
References: <20240215090442.3513760-1-heiko@sntech.de>
 <20240215090442.3513760-2-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="oPeBBt0zBjLbBxGI"
Content-Disposition: inline
In-Reply-To: <20240215090442.3513760-2-heiko@sntech.de>


--oPeBBt0zBjLbBxGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 10:04:42AM +0100, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@cherry.de>
>=20
> The 9904379 is a 10.1" 1024x600 LVDS display using the standard
> lvds properties.
>=20
> Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> ---
>  Documentation/devicetree/bindings/display/panel/panel-lvds.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/display/panel/panel-lvds.y=
aml b/Documentation/devicetree/bindings/display/panel/panel-lvds.yaml
> index 3fb24393529cd..155d8ffa8f6ef 100644
> --- a/Documentation/devicetree/bindings/display/panel/panel-lvds.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/panel-lvds.yaml
> @@ -39,6 +39,8 @@ properties:
>    compatible:
>      items:
>        - enum:
> +          # Admatec 9904379 10.1" 1024x600 LVDS panel
> +          - admatec,9904379
>            - auo,b101ew05
>            # Chunghwa Picture Tubes Ltd. 7" WXGA (800x1280) TFT LCD LVDS =
panel
>            - chunghwa,claa070wp03xg
> --=20
> 2.39.2
>=20

--oPeBBt0zBjLbBxGI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZc5EwAAKCRB4tDGHoIJi
0sGhAQDf55K04Q4/h4RtJu3+GI/+RXj1YCV26C2tngBLGQOQegEA5azUXJRnv+Dl
9zRdCHLcNATb8sne3m0KN7J4cyLfig4=
=zE4Y
-----END PGP SIGNATURE-----

--oPeBBt0zBjLbBxGI--

