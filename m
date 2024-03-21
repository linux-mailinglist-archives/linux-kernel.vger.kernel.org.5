Return-Path: <linux-kernel+bounces-110484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D596B885F90
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 18:20:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05E641C23913
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA3C56B9E;
	Thu, 21 Mar 2024 17:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NNUPr/Li"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E40133413;
	Thu, 21 Mar 2024 17:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711041587; cv=none; b=mLjO/xm7CBDsBZSwUOUzpISAkk2iHKMORHdkSNMykzabstFuTvkHxP5SgiOZlfaJ01O6p3M6ZtJmDNvn2vjvWoNLAnEdVMhtAFPdyM8DNlt+BpvkWNmCYyR4y9urBoWjEgEAfvrTrldgubGbgDukXeRaJ3xr6jnQoeKlKhcPLnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711041587; c=relaxed/simple;
	bh=q5Ux1I1rh/WfHaHpnSuErVTSeCb6Au9flA++b+omwdA=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=iwc94ECD1SmgxXj+nfcbunrR1fYMw/6HwLcf3VVn/K8OGe037exkqqGF2FSWRrnwKTmIkWQWRDuI/p08hSyPQ75zaJM8VxpqCbFvhHpqZn+BeSGUjafEEm0iOAElyopbAA1R/ERDHxB/hup9ge1hF/eBgiOJjjHkZHoTJ/szbMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NNUPr/Li; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E985C433C7;
	Thu, 21 Mar 2024 17:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711041587;
	bh=q5Ux1I1rh/WfHaHpnSuErVTSeCb6Au9flA++b+omwdA=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=NNUPr/LiWrA6Ry3kVWBnVqEzBXSm+kP20MHO20hbPF1whkfJb47I04sNczYUTezxc
	 uuu0O+Kw3BtAke6EG2gzp1OhBGuzsDAd86XliztJVE0E5YqqjPYJRws13HvicYcray
	 cvPyz+n06iwnEZ8kkwDuxAfwGlnRs+csp4B1lqZNrjxkd0csJehD0l8gj3H4hkz4dj
	 rsVifdBtwnObaWKihuRApL+io1FIea25abQbevHYi4BDW91yQMuySHeUzAUBd5Q/bZ
	 1kbcYMo6CmB9Zzbj6f8r7bSN3ZbVDOKCp6jehQABEqOkdZIHUtmN/+fa0Nq1oJ0FJA
	 /QJQ/EkitE39g==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 21 Mar 2024 19:19:43 +0200
Message-Id: <CZZLMBXQ5DWK.3GZSP0HDMMUY7@kernel.org>
To: "Stefan Berger" <stefanb@linux.ibm.com>, <keyrings@vger.kernel.org>,
 <linux-crypto@vger.kernel.org>, <herbert@gondor.apana.org.au>,
 <davem@davemloft.net>
Cc: <linux-kernel@vger.kernel.org>, <saulo.alessandre@tse.jus.br>,
 <lukas@wunner.de>, <bbhushan2@marvell.com>
Subject: Re: [PATCH v7 10/13] crypto: ecdsa - Rename keylen to bufsize where
 necessary
From: "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.17.0
References: <20240320114725.1644921-1-stefanb@linux.ibm.com>
 <20240320114725.1644921-11-stefanb@linux.ibm.com>
In-Reply-To: <20240320114725.1644921-11-stefanb@linux.ibm.com>

On Wed Mar 20, 2024 at 1:47 PM EET, Stefan Berger wrote:
> In cases where 'keylen' was referring to the size of the buffer used by
> a curve's digits, it does not reflect the purpose of the variable anymore
> once NIST P521 is used. What it refers to then is the size of the buffer,
> which may be a few bytes larger than the size a coordinate of a key.
> Therefore, rename keylen to bufsize where appropriate.
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


Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

