Return-Path: <linux-kernel+bounces-106668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C56F587F1C1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 22:08:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 658381F21E5D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 21:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 079A859B5B;
	Mon, 18 Mar 2024 21:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ir+4w8uN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4585E59B45;
	Mon, 18 Mar 2024 21:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710796077; cv=none; b=kpke9YXJewiV1tqNA8LHa0ndI9KP/R+LWarkpoIaLRufKcYGBkTYNJ5A81NC9tbqHizAefoJiqMZi+cNrhV9hdD6+jR+olvzGlnKr+dCB+ZNREWymTAXd5izB6wb6T2f6qw5UN/7KRIeXS9xwhU/M0Y2T9wmy21CfTKz8bSCvyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710796077; c=relaxed/simple;
	bh=fNkJrunN4jmHEM/sSp+SJAehc/d6LkiXUo89pk+3mYU=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=mcQYAvjH/MCG2YuvZ47q8jA0nvz6ZOf7Q7LiyGM/6BfTUrDd7IXNRDuE24ULCAoyQV3RVC2CFbl8pYZlOfpaIRJ3p0CVhNzAxoVlLVd3NBUFYnXYjwZX4GZMcT31iDmMztwiifLzehJPeOOYgurUALamK+z21JiSKBqb2TApIEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ir+4w8uN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9B74C433C7;
	Mon, 18 Mar 2024 21:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710796076;
	bh=fNkJrunN4jmHEM/sSp+SJAehc/d6LkiXUo89pk+3mYU=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=ir+4w8uNZ6Kx1cyM3outwYE0/CSkEm5nYNkl5RCze3o+iLM9pm7UODlGAlJ1A74Ub
	 RFb5zGABPb/affzWThLqFil0lW5eVeiqgseHe4K+z05WniweMZE4niKdsYlNee5tXA
	 UfCH8OaX3wSf7sx8usdYydXkyvn5K1mwE6eXyctBc3DiXU73ZxGs2/3Mv4yzy9vG8d
	 R8yNuXg3AI7GMIRaJxmHsIhK5VGJVGdQB8cdE44EnjfcGAdp83NBLU1qn9CAGQBX0x
	 //vn9niFbi23znEWh7kNifToODqtaC9dB9drPn8v8jipMTC5rOUkJxIBZXuRp/h25s
	 zUtqYVOfDXqVw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 18 Mar 2024 23:07:53 +0200
Message-Id: <CZX6LE75S4B2.309NKHKHALKFK@kernel.org>
To: "Stefan Berger" <stefanb@linux.vnet.ibm.com>,
 <keyrings@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
 <herbert@gondor.apana.org.au>, <davem@davemloft.net>
Cc: <linux-kernel@vger.kernel.org>, <saulo.alessandre@tse.jus.br>,
 <lukas@wunner.de>, <bbhushan2@marvell.com>, "Stefan Berger"
 <stefanb@linux.ibm.com>
Subject: Re: [PATCH v6 10/13] crypto: ecdsa - Rename keylen to bufsize where
 necessary
From: "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.15.2
References: <20240312183618.1211745-1-stefanb@linux.vnet.ibm.com>
 <20240312183618.1211745-11-stefanb@linux.vnet.ibm.com>
In-Reply-To: <20240312183618.1211745-11-stefanb@linux.vnet.ibm.com>

On Tue Mar 12, 2024 at 8:36 PM EET, Stefan Berger wrote:
> From: Stefan Berger <stefanb@linux.ibm.com>
>
> In some cases the name keylen does not reflect the purpose of the variabl=
e

What are "some cases"?

Just pointing out stuff that should be enumerated properly because this=20
requires the reader to complete the commit messages by open coding "some
cases".

> anymore once NIST P521 is used but it is the size of the buffer. There-
> for, rename keylen to bufsize where appropriate.
>
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> Tested-by: Lukas Wunner <lukas@wunner.de>
> ---
>  crypto/ecdsa.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/crypto/ecdsa.c b/crypto/ecdsa.c
> index 4daefb40c37a..4e847b59622a 100644
> --- a/crypto/ecdsa.c
> +++ b/crypto/ecdsa.c
> @@ -35,8 +35,8 @@ struct ecdsa_signature_ctx {
>  static int ecdsa_get_signature_rs(u64 *dest, size_t hdrlen, unsigned cha=
r tag,
>  				  const void *value, size_t vlen, unsigned int ndigits)
>  {
> -	size_t keylen =3D ndigits * sizeof(u64);
> -	ssize_t diff =3D vlen - keylen;
> +	size_t bufsize =3D ndigits * sizeof(u64);
> +	ssize_t diff =3D vlen - bufsize;
>  	const char *d =3D value;
>  	u8 rs[ECC_MAX_BYTES];
> =20
> @@ -58,7 +58,7 @@ static int ecdsa_get_signature_rs(u64 *dest, size_t hdr=
len, unsigned char tag,
>  		if (diff)
>  			return -EINVAL;
>  	}
> -	if (-diff >=3D keylen)
> +	if (-diff >=3D bufsize)
>  		return -EINVAL;
> =20
>  	if (diff) {
> @@ -138,7 +138,7 @@ static int ecdsa_verify(struct akcipher_request *req)
>  {
>  	struct crypto_akcipher *tfm =3D crypto_akcipher_reqtfm(req);
>  	struct ecc_ctx *ctx =3D akcipher_tfm_ctx(tfm);
> -	size_t keylen =3D ctx->curve->g.ndigits * sizeof(u64);
> +	size_t bufsize =3D ctx->curve->g.ndigits * sizeof(u64);
>  	struct ecdsa_signature_ctx sig_ctx =3D {
>  		.curve =3D ctx->curve,
>  	};
> @@ -165,14 +165,14 @@ static int ecdsa_verify(struct akcipher_request *re=
q)
>  		goto error;
> =20
>  	/* if the hash is shorter then we will add leading zeros to fit to ndig=
its */
> -	diff =3D keylen - req->dst_len;
> +	diff =3D bufsize - req->dst_len;
>  	if (diff >=3D 0) {
>  		if (diff)
>  			memset(rawhash, 0, diff);
>  		memcpy(&rawhash[diff], buffer + req->src_len, req->dst_len);
>  	} else if (diff < 0) {
>  		/* given hash is longer, we take the left-most bytes */
> -		memcpy(&rawhash, buffer + req->src_len, keylen);
> +		memcpy(&rawhash, buffer + req->src_len, bufsize);
>  	}
> =20
>  	ecc_swap_digits((u64 *)rawhash, hash, ctx->curve->g.ndigits);

BR, Jarkko

