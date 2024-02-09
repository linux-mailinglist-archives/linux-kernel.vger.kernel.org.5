Return-Path: <linux-kernel+bounces-59733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D905E84FB07
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 18:30:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1651B1C219A8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 17:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096E37E116;
	Fri,  9 Feb 2024 17:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="WdVJRaxl"
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42AFB7BAF3
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 17:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707499813; cv=none; b=FxyyyBhqvVx2NC9Ez862gtQAtymDktwrcQ559gjDivwmEpv4QeRGLITnBOw0Mv1xBYmJ6wn2fGr4kyuMTnnXFF9po9B8s69jkn0f3cj2jibNOgZPn7Hwptr9Pj8hCO7T4zXYsA9CxTCayS1SJ86zr6HUZHpqPdEHR0FqjWuvAA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707499813; c=relaxed/simple;
	bh=vFwOGmGfP+oLKLyesAjgqn7JKbXU3kmJU7zTY1MjMjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AX9YVs1W1OB6NJjwHN+K0fygFBPGTRa5Bbzpu3pK5OLRLrH5c/qN7S0QyVvNRbH39kCS+E8MmBwEn6fNjakYycoteieDhjMmiDzr7ABFIyFLiQA/EZCe5NSEaA4/UZMHAQrs8EZMN+oj0X+i2mmA9p/A7ZA3ktYROo7xxu1iMZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=WdVJRaxl; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=vFwO
	GmGfP+oLKLyesAjgqn7JKbXU3kmJU7zTY1MjMjA=; b=WdVJRaxlztYjZ5d2tlr2
	4cIjNvwn8luhERoOdeDHrqYBwiO96LKYDBqTt2+xLo0+rU27QVghxDt2saMd2ppm
	dlFxmgPl2XbSY5iMjC+uAfMEG0htzt8Zi+Swah5kJELOb9/yT9YYClvJXdKFm16+
	ijCUKWH8bUEaRbalruBfOE9p3MSh9qIxu8uDemfltzevjZ1eHB6buo5aYr2HDJnW
	dqAXsbl9kca0Vc6B4vlBU1BD5lq3C3K1j7NETTr0RxzBmP9AoTBGzXbPvyQKjHMe
	a+ZZDxu02C3YxHFYI9rz77L2pQ4J5/QAgKfi4JLltLmx0gctet8XnNiFhNg8Ta0d
	LQ==
Received: (qmail 3183088 invoked from network); 9 Feb 2024 18:30:06 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 9 Feb 2024 18:30:06 +0100
X-UD-Smtp-Session: l3s3148p1@jAdkR/YQVMoujnsZ
Date: Fri, 9 Feb 2024 18:30:05 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-renesas-soc@vger.kernel.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: renesas: ulcb-kf: add regulators for PCIe ch1
Message-ID: <ZcZhHWn3QrouRigo@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-renesas-soc@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20240129135840.28988-1-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="CTWzMMyP9QGxJqqF"
Content-Disposition: inline
In-Reply-To: <20240129135840.28988-1-wsa+renesas@sang-engineering.com>


--CTWzMMyP9QGxJqqF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 02:58:40PM +0100, Wolfram Sang wrote:
> Without them, no power, so cards do not get recognized.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Can we have this one in 6.9, please?


--CTWzMMyP9QGxJqqF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmXGYRkACgkQFA3kzBSg
KbbGgg//RaN8OTsoqRl+WzXV2jiQ7IvmaKQtwKiaYjn8HzuBle6xFxcebBmke3F3
BUE2gAfF50gn78kg2WblShQYVB5h/0T0bv/+Kpkq3UsWsbMNOgQnvsOnhq3VodQ0
hzmr4AbyRN4EmpXThC7/Mn8SL8nPof06wSUFz3gZkVIpn1Soa4fkpdUNyJxDKPZh
Fz5GTanEomeOEo4PodgjVOa+3kQXK3OCqLKoWvT0s4sIkP1HEc0gOF25bFVe5Eag
aww1/5CCl4Kw1ncpW5sT0FV14YBvo4kQYI1y+DS4onOqFekFTh2UO5bxOcjrBOhu
n/R57Bs4tBI2LW4jVhabIrhJDP6l6S5PbnsLe+qo+6BAGX9kwhWTmKS5GhDIva9/
huv8fHxgcOMSSdV+MMbBByfB+51QScw59/CK1earFIolDDspasCX7R7Y5KFwjDwg
GexSpR362Snu1DnpXtc4xOBsWzVXqtL9W90agBfy570DvLR4AkXLMS0XXf5u2xkn
EmuoreBJWGMlUduoZWI6wWLdI3h9sjc6qrDaaH/IYyF6bAtf37cjVuF7lZwugCEp
k3vCEJAC3/SV6c+6z/4+FpmykDM96ndtH08mHrRLjRm4kV5KjT87RhH9QB+QcY/M
CV5E0qeaLJEkPwhTEDnG0bOVpioS1EA1pYJnjyWdBiiiHDB5mTU=
=kCrc
-----END PGP SIGNATURE-----

--CTWzMMyP9QGxJqqF--

