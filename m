Return-Path: <linux-kernel+bounces-35038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4F2838AE6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 10:51:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08C741C21FA4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 09:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED58D5BAF1;
	Tue, 23 Jan 2024 09:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OZXjLuQ5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D925BAE4;
	Tue, 23 Jan 2024 09:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706003362; cv=none; b=iqY0PJZZ6Y3rPs5cAVm2fPakljCoA+Nk9Eqi4ZlcBl+4FRMgozyVDe0HxlFwvXzkF+OGxd2NnGeE0iW6rUyyVOE3GEAeshhUuSJwms+4nqqjP53lOSy6wuDGESkYXGQcuHAa/+KMIaXPP+9X/rnvbCiWYLDbEgJbpLwDpkmrcFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706003362; c=relaxed/simple;
	bh=Yyl10QeXOzcO2yPsrFasVOzjgjXW3jTi7cHjO/Nx44I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mXPYbQ7WRLaAG6NtbH5q4CB8EAldrPSNlKFHbBPKoZBRHGAL3H01H0bjn1/GcDCw4taVL5bDZXYDDWwmzQeeZvnmEVrJ1V+0mH0x+vfdHujrVnoYd80robFzPFPIcpUgvvyobyDbnGXYDCyy+i/gWmUa3d5KZ1ruKJ7jmSDwsik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OZXjLuQ5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37B7CC43390;
	Tue, 23 Jan 2024 09:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706003361;
	bh=Yyl10QeXOzcO2yPsrFasVOzjgjXW3jTi7cHjO/Nx44I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OZXjLuQ5TZBtkVv2svdnuxPaRNevJr98sN46NrGgEwEs7OSvRonzS+QZJEY+CNeRt
	 uYhrkNa54MkZxamLfGcm5+0UZhZ7s9d/UNE8MOunq/depls1M0jwz9xBXfERjEv4tf
	 k6WjtRBacRVqVHw8OrWRNh/eyK71Bps1+dDIjZvfXz3YEdq8o7RxzsLy9Zd11vlQFO
	 fzdFv7ohj1FVp78BclzSw1FWz12iG44EHHEBySH2Gkmjqu8G6e0CczQJG2pWX3uzdi
	 V6JAFJGp1aM9upX4BRci48skKYkYtwtkrQod8Mnyk5pwEUQ27urxLJs0otZ2OPelX6
	 +2yXX07X3nsPg==
Date: Tue, 23 Jan 2024 10:49:17 +0100
From: Wolfram Sang <wsa@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Magnus Damm <magnus.damm@gmail.com>, linux-staging@lists.linux.dev,
	linux-usb@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] staging: board: Remove Armadillo-800-EVA board
 staging code
Message-ID: <Za-LnZGnIdrHYAVT@ninjato>
Mail-Followup-To: Wolfram Sang <wsa@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Magnus Damm <magnus.damm@gmail.com>, linux-staging@lists.linux.dev,
	linux-usb@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <cover.1705932585.git.geert+renesas@glider.be>
 <6d51e06a8586997b31eecead55a369f01c5696a7.1705932585.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ChcK38yFOv9NM2k9"
Content-Disposition: inline
In-Reply-To: <6d51e06a8586997b31eecead55a369f01c5696a7.1705932585.git.geert+renesas@glider.be>


--ChcK38yFOv9NM2k9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 03:24:32PM +0100, Geert Uytterhoeven wrote:
> Since commits 1399ebacbf590dfb ("drm: renesas: shmobile: Add DT
> support"), 138588e9fa237f97 ("ARM: dts: renesas: r8a7740: Add LCDC
> nodes"), and c9a0ed13382660c9 ("ARM: dts: renesas: armadillo800eva: Add
> LCD panel"), there is no longer any use for the Atmark Techno
> Armadillo-800-EVA board staging code.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v2:
>   - New.

Hooray! \o/

Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--ChcK38yFOv9NM2k9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmWvi5oACgkQFA3kzBSg
KbZlsA//du3JHsrTv86wiZZv0IkU+X77svn+qDSIWUfKSJGoyd459WgYjNZiVJiU
YtYkldgxyVrtjdSKqQLcv3GTap783IZegoyTzKc5SyMovXFzN8ZFSs/LS94UAIXw
XYH/3XdJ+aLXq6P34HqcbLZUof6OEIyT0BkyWt5wR9CrvLRXLmKwcnEKsFq8Ihyu
h/v49ceQ03o6h64UXzSdS+ZFOoJAnnpYiKEvl2UD2sw31a2/fjsZYoT1By1dD2/n
Nfv5ti5V6CCFseKi/Zb0/R7+Okmwksh7Xct5iYCOvU/yyfuUCuECA1CfwjibgsnD
mvG9JgPz/FAQEkg2ILF4xCwar0qaALrTag3KbD90RxmIoQa2lRlmPhuQ/nU40LLr
g5/38FO6rKVj+C7KZvKmrUHSSZ85Sl3K2baarhQAJCQRvTNxd5JTmLtEhyPmEUUO
vtES/mIFji7c9ViDXgqrsH+zaGzzzFa8R12o3HP1XoRlC69uV5ZUAbiAQnK3s6Iw
Jg12TN+b4k+rtiZlr8vShxdeByvq3agiFEsCJL8zh9GTHUwPIiiTIFmAIsoCtf2O
+CTaok3azBCsTjUxyp4gGFK09NHasr24q3JdmlsJXoJKiLW6cZzPgD+273iotdUK
LqdGhPb19p6ZMSq8CR83zCISP0BPMf47eAme2pC7O+X6DBXNLzY=
=llvY
-----END PGP SIGNATURE-----

--ChcK38yFOv9NM2k9--

