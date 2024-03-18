Return-Path: <linux-kernel+bounces-106630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E97E87F130
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 21:34:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30876B22A74
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 20:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F7738DD0;
	Mon, 18 Mar 2024 20:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T2b6nWsG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4202C286BD;
	Mon, 18 Mar 2024 20:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710794072; cv=none; b=fOeg6+4r/Rucvpng6P3p4OQ33W468Q5LtZorZENFVMDBGyTgpvQ+t99Wk74yO8pDeW8YMauX0zqU7Sze7YoNtMhRkpr/9tU5HoA2N6pUoZZ/pk+ofYB6YNs6EiYeA6K7xLjCuV8NhIFMZcL+BGB5pjO+AcA+RYdD3MVKpk5TJ9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710794072; c=relaxed/simple;
	bh=yEwDNVf04XQIbt8HRPIBTKa4CBNvVnTfVbMs4K2yrYs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=HPk9+zp2LeQjFlltGGqxV+BNrAMAX59gvlFjUNGAaaRGh7KOmbHw0Scv9eN/wAmqA7fVyk7mPXrjGIcKyB3uldYqXRLq7+CQIYtZMURrNabF2Yfoql0PpzMFWIcslZ1EKcpdSQubrvFarcZJJXdFxWBqiul/dzvpmapHLkb9VzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T2b6nWsG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E48D5C433C7;
	Mon, 18 Mar 2024 20:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710794071;
	bh=yEwDNVf04XQIbt8HRPIBTKa4CBNvVnTfVbMs4K2yrYs=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=T2b6nWsGxwMWiYFYBMngC8OyUKvSTzfBYdPV/fc6W0JtWt6vQKCh4SuRb8uMksrHY
	 1Rri24ymh3WGZRO8nGQQnxrgR4D2T+AjkrIBBQm45EkhNT1+hKBePXC/kkcPK/OBar
	 wVjov9UT4u9+XE08EziIfIhQELp1Hih4Kh3xnPjB3sHRJNKmKRYvIp6+WBmwv4bgN4
	 s6G3AOn+HLGucNTrg3/9eq/5t2ueGjtFDN6yKkSDlATP3iwDfCws5RB5np+pI6aX9o
	 m1SZUrkHJVE2Csn3uv5cEKh3OMWdPadd2NX3ToR8Qs71LMxMxlaW+3LTc+vAgAKGZi
	 Pa6zjkwCIXOsg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 18 Mar 2024 22:34:28 +0200
Message-Id: <CZX5VSZNCMO7.2LCD7VBCL1157@kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <saulo.alessandre@tse.jus.br>,
 <lukas@wunner.de>, <bbhushan2@marvell.com>, "Stefan Berger"
 <stefanb@linux.ibm.com>
Subject: Re: [PATCH v6 05/13] crypto: ecc - Add nbits field to ecc_curve
 structure
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Stefan Berger" <stefanb@linux.vnet.ibm.com>,
 <keyrings@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
 <herbert@gondor.apana.org.au>, <davem@davemloft.net>
X-Mailer: aerc 0.15.2
References: <20240312183618.1211745-1-stefanb@linux.vnet.ibm.com>
 <20240312183618.1211745-6-stefanb@linux.vnet.ibm.com>
In-Reply-To: <20240312183618.1211745-6-stefanb@linux.vnet.ibm.com>

On Tue Mar 12, 2024 at 8:36 PM EET, Stefan Berger wrote:
> From: Stefan Berger <stefanb@linux.ibm.com>
>
> Add the number of bits a curve has to the ecc_curve definition and set it
> on all curve definitions.

"because" is missing.

>
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> Tested-by: Lukas Wunner <lukas@wunner.de>
> ---
>  crypto/ecc_curve_defs.h    | 4 ++++
>  crypto/ecrdsa_defs.h       | 5 +++++
>  include/crypto/ecc_curve.h | 2 ++
>  3 files changed, 11 insertions(+)
>
> diff --git a/crypto/ecc_curve_defs.h b/crypto/ecc_curve_defs.h
> index 9719934c9428..ab1ef3d94be5 100644
> --- a/crypto/ecc_curve_defs.h
> +++ b/crypto/ecc_curve_defs.h
> @@ -17,6 +17,7 @@ static u64 nist_p192_b[] =3D { 0xFEB8DEECC146B9B1ull, 0=
x0FA7E9AB72243049ull,
>  				0x64210519E59C80E7ull };
>  static struct ecc_curve nist_p192 =3D {
>  	.name =3D "nist_192",
> +	.nbits =3D 192,
>  	.g =3D {
>  		.x =3D nist_p192_g_x,
>  		.y =3D nist_p192_g_y,
> @@ -43,6 +44,7 @@ static u64 nist_p256_b[] =3D { 0x3BCE3C3E27D2604Bull, 0=
x651D06B0CC53B0F6ull,
>  				0xB3EBBD55769886BCull, 0x5AC635D8AA3A93E7ull };
>  static struct ecc_curve nist_p256 =3D {
>  	.name =3D "nist_256",
> +	.nbits =3D 256,
>  	.g =3D {
>  		.x =3D nist_p256_g_x,
>  		.y =3D nist_p256_g_y,
> @@ -75,6 +77,7 @@ static u64 nist_p384_b[] =3D { 0x2a85c8edd3ec2aefull, 0=
xc656398d8a2ed19dull,
>  				0x988e056be3f82d19ull, 0xb3312fa7e23ee7e4ull };
>  static struct ecc_curve nist_p384 =3D {
>  	.name =3D "nist_384",
> +	.nbits =3D 384,
>  	.g =3D {
>  		.x =3D nist_p384_g_x,
>  		.y =3D nist_p384_g_y,
> @@ -95,6 +98,7 @@ static u64 curve25519_a[] =3D { 0x000000000001DB41, 0x0=
000000000000000,
>  				0x0000000000000000, 0x0000000000000000 };
>  static const struct ecc_curve ecc_25519 =3D {
>  	.name =3D "curve25519",
> +	.nbits =3D 255,
>  	.g =3D {
>  		.x =3D curve25519_g_x,
>  		.ndigits =3D 4,
> diff --git a/crypto/ecrdsa_defs.h b/crypto/ecrdsa_defs.h
> index 0056335b9d03..1c2c2449e331 100644
> --- a/crypto/ecrdsa_defs.h
> +++ b/crypto/ecrdsa_defs.h
> @@ -47,6 +47,7 @@ static u64 cp256a_b[] =3D {
> =20
>  static struct ecc_curve gost_cp256a =3D {
>  	.name =3D "cp256a",
> +	.nbits =3D 256,
>  	.g =3D {
>  		.x =3D cp256a_g_x,
>  		.y =3D cp256a_g_y,
> @@ -80,6 +81,7 @@ static u64 cp256b_b[] =3D {
> =20
>  static struct ecc_curve gost_cp256b =3D {
>  	.name =3D "cp256b",
> +	.nbits =3D 256,
>  	.g =3D {
>  		.x =3D cp256b_g_x,
>  		.y =3D cp256b_g_y,
> @@ -117,6 +119,7 @@ static u64 cp256c_b[] =3D {
> =20
>  static struct ecc_curve gost_cp256c =3D {
>  	.name =3D "cp256c",
> +	.nbits =3D 256,
>  	.g =3D {
>  		.x =3D cp256c_g_x,
>  		.y =3D cp256c_g_y,
> @@ -166,6 +169,7 @@ static u64 tc512a_b[] =3D {
> =20
>  static struct ecc_curve gost_tc512a =3D {
>  	.name =3D "tc512a",
> +	.nbits =3D 512,
>  	.g =3D {
>  		.x =3D tc512a_g_x,
>  		.y =3D tc512a_g_y,
> @@ -211,6 +215,7 @@ static u64 tc512b_b[] =3D {
> =20
>  static struct ecc_curve gost_tc512b =3D {
>  	.name =3D "tc512b",
> +	.nbits =3D 512,
>  	.g =3D {
>  		.x =3D tc512b_g_x,
>  		.y =3D tc512b_g_y,
> diff --git a/include/crypto/ecc_curve.h b/include/crypto/ecc_curve.h
> index 70964781eb68..63d5754e7614 100644
> --- a/include/crypto/ecc_curve.h
> +++ b/include/crypto/ecc_curve.h
> @@ -23,6 +23,7 @@ struct ecc_point {
>   * struct ecc_curve - definition of elliptic curve
>   *
>   * @name:	Short name of the curve.
> + * @nbits:	The number of bits of a curve.
>   * @g:		Generator point of the curve.
>   * @p:		Prime number, if Barrett's reduction is used for this curve
>   *		pre-calculated value 'mu' is appended to the @p after ndigits.
> @@ -34,6 +35,7 @@ struct ecc_point {
>   */
>  struct ecc_curve {
>  	char *name;
> +	unsigned int nbits;
>  	struct ecc_point g;
>  	u64 *p;
>  	u64 *n;


BR, Jarkko

