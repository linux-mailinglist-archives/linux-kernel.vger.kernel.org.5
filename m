Return-Path: <linux-kernel+bounces-108514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4AE880B8F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 07:58:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E2F31C224D8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 06:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FFF6210FE;
	Wed, 20 Mar 2024 06:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gRv6hpMc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B7520DCB;
	Wed, 20 Mar 2024 06:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710917920; cv=none; b=UTIb77U7QWbMzB2FTBT1xe2cmUVhCn/Ix3HofM9TXW2J5gvQd+ji8BMRVQac3BsiwaSLF4u+bf4E+RTriVIAaR0b0dNj+GNkv6URFI8BPJmHWd49sIh/Wqw/8xTATpwtfUBGhUOhwFYJnFZ/yqPebejKFV22oeJTeNtLwUtL20E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710917920; c=relaxed/simple;
	bh=/l40gwACVXquNWBAB7Di2rMY3ywShw0tYIXalaq3he8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ICQp7zrr/jgHgd7r6X17e1nWpn+YZmOE9DvehfJuj4bVqjFkgjcaa3gDXtM/+ojx6HuT0kNQkalRBpxNUZpv9bwiJ5IlBmiEkow4Rdmk4GxDY3EA6lo2xaLxPuph+CjpUNeT4gOJyvskU6Q+RSdfWYqZpbYbKWqsyN0HhjMK7Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gRv6hpMc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E7EBC433F1;
	Wed, 20 Mar 2024 06:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710917920;
	bh=/l40gwACVXquNWBAB7Di2rMY3ywShw0tYIXalaq3he8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gRv6hpMcb+f2Wol+bhzIQHPO4X3O22MKar3HhwW9AmnVBbUnh24e8rwLv/b6PyIJ3
	 w6DIGhrxUpXPmlo9SUyzskZcWGH2PZUA/PfYZhHS2J9l91+Vwv25tr+1Bw1z7jZpRo
	 u6ILAqX2WfRR/4Jwb7DWmCwap3G+ijeR/S3vlWWyNBpVWHYZMGAT7VN6EHKIMP5AK7
	 Umze6voKkWYq9wxIv9/xIpIj+5NfjYgLhP8Ka3jKnCdvdC5lnK9dlbkZvgxE4E+C0R
	 pSr0hRjQ2vkQChLhMiG5/PfZsh4o+chVwAtQB7TD3UBcVEM4lU1lBpBSyOjFlskzZG
	 zHkmdo4IF8F2w==
Date: Wed, 20 Mar 2024 07:58:36 +0100
From: Wolfram Sang <wsa@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
	Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: timer: renesas,tmu: Add RZ/G1 support
Message-ID: <ZfqJHItAf-Y7oSAJ@ninjato>
Mail-Followup-To: Wolfram Sang <wsa@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
	Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <cover.1710862701.git.geert+renesas@glider.be>
 <aee943078c91e6c627f33a62c7cd2b73320a1dc5.1710862701.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="x/SPWOCtepvxrAgi"
Content-Disposition: inline
In-Reply-To: <aee943078c91e6c627f33a62c7cd2b73320a1dc5.1710862701.git.geert+renesas@glider.be>


--x/SPWOCtepvxrAgi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 04:46:04PM +0100, Geert Uytterhoeven wrote:
> Document support for the Timer Unit (TMU) on RZ/G1 SoCs.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--x/SPWOCtepvxrAgi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmX6iRwACgkQFA3kzBSg
KbbFXA//aSffp8EXfIDG+ieqBTPcT50pECG3IbxdTV5HN8VpUKXVgBYlCrvveKZu
tWEXyWvPPkNcuOp0Thx8CvWo3NvAmbZ6qUkL7W+Z2InysS9Gn+CMgmkKanA1LjW1
XsK2F2Iy7NV1fc2fJLx2E/FPVDliZDb1hXu39EG8jHUPLU4V9bGlbgQCcUuAPfnx
v2FMzfCMfp61Ehun0+cSSmmfuPdkN7f4e8sL4/8fkz3qXYA8idIVGbTOEcmobndS
/WeyPSPARfDII6YGL4dVPe5x4vCgVfIGJdh+PrmzeMssRzoBGBeCFuvL0B/vxe9h
5BmeoHkJ/8/fX3ivJNcdpdou73uhZgKmtiy8NcWSvKhsPTCVX2cx2gLf3W7Ojm9U
CQIwXJYSI9bQ1JCtnBAivMk8RdArp6y9+zx2n0gnDNLYjwuzFa904zdCwN8/+cEn
cvxilCfTMZDMss70IGauLkyzEfejQzqH5YB2beEDs5OVKyv14wmtOXrYcPOcR4yw
XZnKZEYOWWq4mzhbpPKC11qD1neRJalKBtS2/+etc+Ki1Zw7AYBVauWgdey+E4AB
OwZZLyx1loBAirjdr0+m/LspOtX2kgbtIbAgighw8upz6vnrxCq51KWCKTO1tDaz
lXAJ42jCYnc3J+5pMkvizMakZpWdfd51lXU0jaARjjZbQ2zHdFE=
=kWRS
-----END PGP SIGNATURE-----

--x/SPWOCtepvxrAgi--

