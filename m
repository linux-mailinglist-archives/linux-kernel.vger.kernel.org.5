Return-Path: <linux-kernel+bounces-60881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45945850A8E
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 18:28:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 780071C211F5
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 17:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C825E5CDF5;
	Sun, 11 Feb 2024 17:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CTdfnmJv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103875A102;
	Sun, 11 Feb 2024 17:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707672481; cv=none; b=Lir6B3ZiaYeQq7y+SNAbSdvpzms2UyMdpTK7lY0ro2xBGUa97L+LpDW5nCp2Ht0bZpMV0vTJqHC+DaE2A1ITw20ds7HotbEAcZem0VM3mgMqkLjNQT4VHpQ9aaextefho8hZXtosKJIAqxjMGFOGceXOaW6jHAt+oTdJGHeuaXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707672481; c=relaxed/simple;
	bh=y3Ubh8Tiy/3GXFRMEO7G2rV3CZjY88WuRV3Wp5PzzDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bclQq24yziix2rVBGHXLqznvLAG4PS+9GsTxbPSniWCPNqsurtoqhrtwCJYXj3QkbPwLACn6GWyFZ6l8GevRYxDjq0vZt4zXUBqNti7xPk2P/bSeQRpxj1BmtKqnOtlTNKr6yOPnINoy8nqOHDJqZBavQYiKkb++o4Eux4eGVn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CTdfnmJv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE375C433C7;
	Sun, 11 Feb 2024 17:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707672480;
	bh=y3Ubh8Tiy/3GXFRMEO7G2rV3CZjY88WuRV3Wp5PzzDI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CTdfnmJvnCiNQvdHkps0Ks2HdAvbzApLljwwnm3gbxYR0ZQLXhKCZCPTZVLUrhUYh
	 nvju9BcIbLtpUJ7TBD3vWey6DaXZUjJUEDIHOXmNKqk808gsS60eEFx4FCw1JK2nCB
	 WjVN4P9M92Y4PJwIR/JTE/rOTQkKACMYaSsUFo1lhmoRdwnS+BfYNzuoKElXV8kUJA
	 8QplHqD42dU54ydjPQXGSR27zsae7cKdwf2f8lBLmCK1G437M3zfV1RgLUahLlrxGM
	 UiFoKpIVhSg4xdGBV5Iy09ifOuHirbL8swqGIulfaYLL959DhzujemjWkrIQdvDQ3F
	 soNAy+Ov+GkiA==
Date: Sun, 11 Feb 2024 17:27:55 +0000
From: Conor Dooley <conor@kernel.org>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Heiko Stuebner <heiko@sntech.de>, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-rockchip@lists.infradead.org, linux-phy@lists.infradead.org,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Frank Wang <frank.wang@rock-chips.com>,
	Kever Yang <kever.yang@rock-chips.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH v1 01/10] dt-bindings: soc: rockchip: add clock to RK3588
 VO grf
Message-ID: <20240211-overexert-balcony-4b4f723f379b@spud>
References: <20240209181831.104687-1-sebastian.reichel@collabora.com>
 <20240209181831.104687-2-sebastian.reichel@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5y37wf+p5Z3zLdFR"
Content-Disposition: inline
In-Reply-To: <20240209181831.104687-2-sebastian.reichel@collabora.com>


--5y37wf+p5Z3zLdFR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 09, 2024 at 07:17:17PM +0100, Sebastian Reichel wrote:
> The RK3588 VO GRF needs a clock. This adds the clock to the allowed
> properties, makes it mandatory for the RK3588 VO grf and disallows it
> for any other Rockchip grf.
>=20
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--5y37wf+p5Z3zLdFR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZckDmwAKCRB4tDGHoIJi
0tewAQDkk7fL2nq9A6z8MR0y3mv1cBi3+NjU+Pdb7KteJlol+wEAo6K+1cPFIeat
2QXq/2f/kFWrRLjib7eqeWWVp8cs8A0=
=w+EU
-----END PGP SIGNATURE-----

--5y37wf+p5Z3zLdFR--

