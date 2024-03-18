Return-Path: <linux-kernel+bounces-106651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57AC387F18D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 21:50:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 119B3281172
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 20:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827A956742;
	Mon, 18 Mar 2024 20:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D3cbXI8b"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5BB1D522;
	Mon, 18 Mar 2024 20:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710795015; cv=none; b=b/YKgXbTtKWKrxDDlkB0NrqaGThYzz1WWwi+zXALYu08GS1aw9MhZSKsX2OsmcP+PfI630F05xjPe5ylZrQ8y7DfLvTFYJEGMMjKs7uLkNKMcqyN20bQc0RzwtYpVodViu9Nqwb+tj2YbtcMv6Ia++SJbXPgp8Mp+goekmkEuhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710795015; c=relaxed/simple;
	bh=Zc1WjtlFTfAsrllaRd9Ez5SET5TGpRk/zbEJymc5OIA=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=pNMdBW2n/DksbVQ+R7GKzyUCibar6uzdbuiZBkmgZvurgYzec1+i8eXqTY37Px9PJg4nAeGr9Pe9x5HpRMN5bwrj6vnu3Iwe5U+70bJMIM6zjrcG2QFnnmflfUoa1QVf5Ifam3QZ/IxUvJIDmE87E31losCitM3s/m9KU8MnP9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D3cbXI8b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 461A6C43390;
	Mon, 18 Mar 2024 20:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710795015;
	bh=Zc1WjtlFTfAsrllaRd9Ez5SET5TGpRk/zbEJymc5OIA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D3cbXI8bNThdVUUiphewIgIeqsf8m44UfngAnENZzNoWiHdlKf7YOB9VswZ5E22Kw
	 IKKtpYP4j8f8+TR3bEDgwhbIjzynMWJcZoY8q3fDF9F753J+VWxvB19tYygqFv/9TJ
	 JTFmnklJFajLlhCIqHPQnkJkZf8JXfP/77jWxe2P/F5aHncIOOnBgvNIdBkYFWQz7C
	 rgXFP8+T72WyBRyAkjor4rFzQdww3QlVWAOlHZUBnV1C7Fu7mGfsu4HqYSG96FwKOZ
	 THTmVX6jZMjKdiQ7TgBz3so5Kt3WfIZxHRq78oMcqMNXmUVneaWm3aUFVb43RdU+Kc
	 fo4OigEY2yTZg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 18 Mar 2024 22:50:11 +0200
Message-Id: <CZX67UDST7WU.1LNVWGY9DM999@kernel.org>
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Stefan Berger" <stefanb@linux.vnet.ibm.com>,
 <keyrings@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
 <herbert@gondor.apana.org.au>, <davem@davemloft.net>
Cc: <linux-kernel@vger.kernel.org>, <saulo.alessandre@tse.jus.br>,
 <lukas@wunner.de>, <bbhushan2@marvell.com>, "Stefan Berger"
 <stefanb@linux.ibm.com>
Subject: Re: [PATCH v6 07/13] crypto: ecc - Add special case for NIST P521
 in ecc_point_mult
X-Mailer: aerc 0.15.2
References: <20240312183618.1211745-1-stefanb@linux.vnet.ibm.com>
 <20240312183618.1211745-8-stefanb@linux.vnet.ibm.com>
In-Reply-To: <20240312183618.1211745-8-stefanb@linux.vnet.ibm.com>

On Tue Mar 12, 2024 at 8:36 PM EET, Stefan Berger wrote:
> From: Stefan Berger <stefanb@linux.ibm.com>
>
> In ecc_point_mult use the number of bits of the NIST P521 curve + 2. The
> change is required specifically for NIST P521 to pass mathematical tests
> on the public key.
>
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> Tested-by: Lukas Wunner <lukas@wunner.de>
> ---
>  crypto/ecc.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/crypto/ecc.c b/crypto/ecc.c
> index 99d41887c005..ead40b5ebb46 100644
> --- a/crypto/ecc.c
> +++ b/crypto/ecc.c
> @@ -1320,7 +1320,10 @@ static void ecc_point_mult(struct ecc_point *resul=
t,
>  	carry =3D vli_add(sk[0], scalar, curve->n, ndigits);
>  	vli_add(sk[1], sk[0], curve->n, ndigits);
>  	scalar =3D sk[!carry];
> -	num_bits =3D sizeof(u64) * ndigits * 8 + 1;
> +	if (curve->nbits =3D=3D 521)	/* NIST P521 */
> +		num_bits =3D curve->nbits + 2;
> +	else
> +		num_bits =3D sizeof(u64) * ndigits * 8 + 1;
> =20
>  	vli_set(rx[1], point->x, ndigits);
>  	vli_set(ry[1], point->y, ndigits);


Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

