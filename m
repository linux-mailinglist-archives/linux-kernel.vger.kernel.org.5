Return-Path: <linux-kernel+bounces-110477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A07C1885F7A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 18:17:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F4991F2349C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ACF529CEA;
	Thu, 21 Mar 2024 17:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RBlmFhni"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17AAC2E9;
	Thu, 21 Mar 2024 17:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711041440; cv=none; b=Lj7cpLqHGy491RhbxWKQVfXRFKqen7EAULj2KJG6tooW0gCYpQe0KtG+nO6ZfeZMZcmp3MQK+z5SA0xchy0QwQoaqMjPGxQTeZ+VWCuNLDenT0loNq57ycfQ/0f7h+dBFuRz11rDBSQ+FQVpnGQVSV31v6aZybJgLE8bSXPZP00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711041440; c=relaxed/simple;
	bh=9ac2pFm45Vkb4zyIlPdYjwUY5c7XpoySPr8khkoLHbY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=fQwq6tEY4qMkigKB9PhqVbp22KlehFFTDz4AvCskrVELTk2g/WmE3qEDrGDGgqxOzhQiJk3FzggjO0/dDdmI4xEomMswYy5g1k1zKwlCMRjt67C5Ka0VDwhM+Iam4Gy/IZcvm2sed3eijNmUKI3z+QTPFHW1HbXpNTWktyaDAYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RBlmFhni; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 616D0C433F1;
	Thu, 21 Mar 2024 17:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711041440;
	bh=9ac2pFm45Vkb4zyIlPdYjwUY5c7XpoySPr8khkoLHbY=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=RBlmFhnivZexbInTZDJc+eICAX81KkmJawXjaNdXrtVnjPUjVqsp6kfe4fdNYXUzX
	 yFGOQux2Ncm1+jaBSKCQ7wwJWKYleWIf5qxy/iZsADTfjVDY9rVU1kXTmMQBcgEC63
	 Z1eyYHGwH6TBnKbzPgUcUAxotQjwIGldeB+5ed8bdcS4Ud6Y+GpqhxCwDNMRNxyavY
	 uuCQSABxCBPTb+DGGVOB0t/Uk4+7911qdL67fqAWOjL9jrMJsdjJfdF8BqrHYD7hd7
	 meIfWlby2JRU3OrdZgs97i7psq853pKXMrnmZQv+AxmN0QAOb2XUgjTWV9mU50gieZ
	 JRQJHrBJOTWxw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 21 Mar 2024 19:17:16 +0200
Message-Id: <CZZLKGMM0B9E.7J1CGE8EIGQX@kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <saulo.alessandre@tse.jus.br>,
 <lukas@wunner.de>, <bbhushan2@marvell.com>
Subject: Re: [PATCH v7 05/13] crypto: ecc - Add nbits field to ecc_curve
 structure
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Stefan Berger" <stefanb@linux.ibm.com>, <keyrings@vger.kernel.org>,
 <linux-crypto@vger.kernel.org>, <herbert@gondor.apana.org.au>,
 <davem@davemloft.net>
X-Mailer: aerc 0.17.0
References: <20240320114725.1644921-1-stefanb@linux.ibm.com>
 <20240320114725.1644921-6-stefanb@linux.ibm.com>
In-Reply-To: <20240320114725.1644921-6-stefanb@linux.ibm.com>

On Wed Mar 20, 2024 at 1:47 PM EET, Stefan Berger wrote:
> Add the number of bits a curve has to the ecc_curve definition to be able
> to derive the number of bytes a curve requires for its coordinates from i=
t.
> It also allows one to identify a curve by its particular size. Set the
> number of bits on all curve definitions.
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

Nit:

Hmm not strongly opionated here but wouldn't it be more consistent to
use u32 here as the types below are also exact bitsize types?

>  	struct ecc_point g;
>  	u64 *p;
>  	u64 *n;

BR, Jarkko

