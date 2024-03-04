Return-Path: <linux-kernel+bounces-91261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B9A870BE8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 21:55:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 631DE1C2247D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 20:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 049E610965;
	Mon,  4 Mar 2024 20:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="aduAZA22"
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BFDF9C1
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 20:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709585702; cv=none; b=mlKBQIdGzTjt9tyJ4zhW19al/I9Z3nEVSpt80PtOwVD+Duma3Yl+Ifh5msOSGCR3xW2WO9Sxs5e17tzximXoGEuNkRU79rF+LSKtbcr40FJXcrpP7t45Xt8y9ULyhyzWT+fiCW/LCreuNFB+WJlijkOd9lF7hHkEg+fp4V9yPI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709585702; c=relaxed/simple;
	bh=i1NxfXVwknX6nwJHYlrjnQJNGqbRSZIaN4tsxwRHf98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l44xeENMrK4s6omazfB6QoAA0kJ7zGEV2I2fG6L2y5iHWz7/FTzMndXhfN/7oywbV0oUUtUrZpJsaEvZ4tCPpxLXmBxbhHIA7wAX/Eq367ejU4N4Mo8o1SxO8GJKhA7b0y1BKNje4whF8zngUO7u/oAIdoer2lkJEqs6BeFfor0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=aduAZA22; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=21Zd
	vrWBN7+6IdtKG1ZTHcL0qqV9nuTD3P213oWlxQc=; b=aduAZA22NKnY9WJR9/V8
	Ts68UDEk+OzFgTc5uuLMT6Eb+aHEYRWuLJvzJMqWsaL8zr7IaY38g+QPu8YjzU2q
	9etvF7Zr9a9kENj2hdiYlw8AvwaTb/mFP8ivnFFRK3spxt/yXOOWs3NhjkJwSb8K
	AnrBrZjsahwMoQMnNTDhr8MrRmZFNf9YYv7IYH0wR2KXvS4g86IvMDYjfLPrGeuj
	ROJkOajLtOANB4avIDj7e0pa9HFF2Fna2wb0ZA8+WFin1qkclAaqYHSyJhCkPmpS
	ijNUf3wBkDHnuLbCVRJK3gIDZKHrvVwZsfC0Res7O4iD1w/99CErx0nYICfFC7mq
	0A==
Received: (qmail 3622885 invoked from network); 4 Mar 2024 21:54:53 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 4 Mar 2024 21:54:53 +0100
X-UD-Smtp-Session: l3s3148p1@5dny79sSnpcujnuA
Date: Mon, 4 Mar 2024 21:54:52 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: zoanana990 <harry021633@gmail.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: remove redundant condition
Message-ID: <ZeY1HMLVuDC1UUL4@ninjato>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	zoanana990 <harry021633@gmail.com>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20240224115050.3199-1-harry021633@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="y1yseQqP+F0ToDfD"
Content-Disposition: inline
In-Reply-To: <20240224115050.3199-1-harry021633@gmail.com>


--y1yseQqP+F0ToDfD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 24, 2024 at 07:50:50PM +0800, zoanana990 wrote:
> I2C_M_RD is defined as 1, "flag & I2C_M_RD" is 1 or 0
> One more condition does not need to be met to obtain the value
>=20
> Signed-off-by: zoanana990 <harry021633@gmail.com>

=46rom 'Documentation/process/1.Intro.rst':

It is imperative that all code contributed to the kernel be legitimately
free software.  For that reason, code from anonymous (or pseudonymous)
contributors will not be accepted.  All contributors are required to "sign
=2E..

Please sign off with your real name.


--y1yseQqP+F0ToDfD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmXmNRwACgkQFA3kzBSg
KbaZJA/+O37+CJyYlB1OiLtijUzVftGYhQ31wWYJHwN+eFhpU3eWNdLsK6DS1HKF
KbD47TKeFtkS2LkMxawWcOHnl3lSnJDszjs4hk/Udrwe3PqYzz9OXdIP2oR7vdsb
1lMobRT6R/yB3Jy9rDFn8nSorAnjIZ538w3w9rJ8RxFYfMghnpuTfauAY72sMN8U
I/pNc4cQrdPJnwnMu6br3vjux1y9UjYXpToTmrNKh2qDDqePJt2LTQnYZ6D+oZ+E
vt4+5y2sK5GkEktuvUAbqPVA8QbQgZnHTmRivVNSfNhJiCmYpgfqMXb9f5n/0yDF
7K7KsrFRKC2wewXk8kiIgKwXF+Sn0YNrsfypLytabvhtCNmPE8kLten9mRbu2Aur
3UkaRnYyK64IqJPH0TAkEyKp0aV/e/VYgELYYEy1J0K3oblf2HpmN3/vnd8769AV
sMq74gbCwx3KG9RE4bcu85mglXvlDi1EFJxWjxYyFLZaxqvt7tw22ALkzgkpnJTF
PA1pXD2u3h+/XBDggdldtrS2JWEoSCKsTa8ORXUnx4h94o2J8Bmk3wevibzB9zgL
/aoDuZjofPhgaqcW32SQ7hDn+TNHZt1IZ3dmrQiJ7rHVEl0s/2CApRoP3SDKcDwY
NAJ/JIPc13c6BozLQyLyd5meCazAoxam+fAtIQAO6B9jLTCchbo=
=1GLv
-----END PGP SIGNATURE-----

--y1yseQqP+F0ToDfD--

