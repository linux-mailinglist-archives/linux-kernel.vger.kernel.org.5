Return-Path: <linux-kernel+bounces-106612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A2C087F0ED
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 21:08:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99E4D1C222D4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 20:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 596955786E;
	Mon, 18 Mar 2024 20:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qobDbtZD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9246C54FB2;
	Mon, 18 Mar 2024 20:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710792531; cv=none; b=tTj4+jJlVG376KHwHj13K7r9RNf8Kq74cE9SBMFGATkhTkAyt2qV2YCDJMQzuNyhWgie1KRmReyHeNtxLMPoHhRIztTKgpfbnqXPFEUbQTc659AjzIcm8uT2svBURd6qZs7M2NcLLGDtoaG+wHkhLhqOxeiHxxOD5t29U4EhaXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710792531; c=relaxed/simple;
	bh=lXbA6Cw/jIb0AJ8sGuWBB8R2dMM8wLsC6IfTQqFBW+k=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=mEum13cJI5q2oyCb6mfwVGSR+KL/HiJYahzLUEQLVr8HqzkPESnNzwvVzFtYPEeqCKklMbOdpBwdG0X+MXNqXCRxTMuLS6d40aSeJTMdsE9BdJ6BTRSGsmUkcNgpitIwd9FTxFifnJkKPdujQqXP0X4pQiShosmVXkk8RMx/rUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qobDbtZD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 262E3C433C7;
	Mon, 18 Mar 2024 20:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710792531;
	bh=lXbA6Cw/jIb0AJ8sGuWBB8R2dMM8wLsC6IfTQqFBW+k=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=qobDbtZDNS+Xmhwu7RQXNl1kVNog+OaNtBdtfExvlMOqn4EqENxkY3PbHsJl9xZwz
	 FKKeUqgDbEbHmPYo7YKh1pzhAZfNlBunRUuZN3RuJfw0rhKXD72M7xmWNmlmkyJ6Li
	 6EWPQ2E8fqsf/Hd+K/6W4Sh2ydqQtsHDJQ8WFkra56I1dTgg6rC/vI1EmQd2dhxExQ
	 jMqoy523rSub5ZkIQ5Aw6W1EvzBmjNsjGbOP23vvQWM0bpfcEDH17vrwj8fMJyXqI5
	 9guWqq8DGXbeqTxX9qrx5IBhi19T5KFCYox+NmByeeMCUoTo6FkZxYKQ7vN6Bd6BZS
	 Nd7pQ5j3XILpg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 18 Mar 2024 22:08:47 +0200
Message-Id: <CZX5C52SJOU6.1NX669PI73TRJ@kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <saulo.alessandre@tse.jus.br>,
 <lukas@wunner.de>, <bbhushan2@marvell.com>, "Stefan Berger"
 <stefanb@linux.ibm.com>
Subject: Re: [PATCH v6 01/13] crypto: ecc - Use
 ECC_CURVE_NIST_P192/256/384_DIGITS where possible
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Stefan Berger" <stefanb@linux.vnet.ibm.com>,
 <keyrings@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
 <herbert@gondor.apana.org.au>, <davem@davemloft.net>
X-Mailer: aerc 0.15.2
References: <20240312183618.1211745-1-stefanb@linux.vnet.ibm.com>
 <20240312183618.1211745-2-stefanb@linux.vnet.ibm.com>
In-Reply-To: <20240312183618.1211745-2-stefanb@linux.vnet.ibm.com>

On Tue Mar 12, 2024 at 8:36 PM EET, Stefan Berger wrote:
> From: Stefan Berger <stefanb@linux.ibm.com>
>
> Replace hard-coded numbers with ECC_CURVE_NIST_P192/256/384_DIGITS where
> possible.
>
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>  crypto/ecc.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/crypto/ecc.c b/crypto/ecc.c
> index f53fb4d6af99..415a2f4e7291 100644
> --- a/crypto/ecc.c
> +++ b/crypto/ecc.c
> @@ -689,7 +689,7 @@ static void vli_mmod_barrett(u64 *result, u64 *produc=
t, const u64 *mod,
>  static void vli_mmod_fast_192(u64 *result, const u64 *product,
>  			      const u64 *curve_prime, u64 *tmp)
>  {
> -	const unsigned int ndigits =3D 3;
> +	const unsigned int ndigits =3D ECC_CURVE_NIST_P192_DIGITS;
>  	int carry;
> =20
>  	vli_set(result, product, ndigits);
> @@ -717,7 +717,7 @@ static void vli_mmod_fast_256(u64 *result, const u64 =
*product,
>  			      const u64 *curve_prime, u64 *tmp)
>  {
>  	int carry;
> -	const unsigned int ndigits =3D 4;
> +	const unsigned int ndigits =3D ECC_CURVE_NIST_P256_DIGITS;
> =20
>  	/* t */
>  	vli_set(result, product, ndigits);
> @@ -800,7 +800,7 @@ static void vli_mmod_fast_384(u64 *result, const u64 =
*product,
>  				const u64 *curve_prime, u64 *tmp)
>  {
>  	int carry;
> -	const unsigned int ndigits =3D 6;
> +	const unsigned int ndigits =3D ECC_CURVE_NIST_P384_DIGITS;
> =20
>  	/* t */
>  	vli_set(result, product, ndigits);
> @@ -932,13 +932,13 @@ static bool vli_mmod_fast(u64 *result, u64 *product=
,
>  	}
> =20
>  	switch (ndigits) {
> -	case 3:
> +	case ECC_CURVE_NIST_P192_DIGITS:
>  		vli_mmod_fast_192(result, product, curve_prime, tmp);
>  		break;
> -	case 4:
> +	case ECC_CURVE_NIST_P256_DIGITS:
>  		vli_mmod_fast_256(result, product, curve_prime, tmp);
>  		break;
> -	case 6:
> +	case ECC_CURVE_NIST_P384_DIGITS:
>  		vli_mmod_fast_384(result, product, curve_prime, tmp);
>  		break;
>  	default:

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

