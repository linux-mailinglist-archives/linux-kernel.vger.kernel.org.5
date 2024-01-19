Return-Path: <linux-kernel+bounces-31562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5115183301D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 22:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2CC3284EFF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 21:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803B058123;
	Fri, 19 Jan 2024 21:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jmmPcA50"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4EF857888;
	Fri, 19 Jan 2024 21:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705698782; cv=none; b=HkQxKsVlFWWu40uSUCACddfAN2Ftmtq2A4cAJGS4qI9UZgUOiKCTVSTfa83BB+9mpBdsD8cjV/3JK6eTH6xEnwOENTM+0UGfwYH2OAveeJtqASjIS+ttXKBAO439fdYc5Wqw8U0Zgn4A+Q2DmLejsvY1EAUmTPSSRuNLIwyxG7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705698782; c=relaxed/simple;
	bh=K5XRA4pHgspNItWgN06atRk3dlBp3RHa7wRvvR+DpcI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=BkNAGy8iGELReRS122n53hrWa3WTExiO23CVQ8fI5Wt8Ejfqkgqbb6qElVy1ms2DE4K/JIRlNcmNNihE0QGv5qKScAjvNqHFV7KnflBBDOS7djF5QHT8hw28F+x3rrd+m+p9vgF8vJMlYbNK3dhr0qrfN+0VD2szgAMbE50fd+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jmmPcA50; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79A4AC433C7;
	Fri, 19 Jan 2024 21:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705698782;
	bh=K5XRA4pHgspNItWgN06atRk3dlBp3RHa7wRvvR+DpcI=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=jmmPcA50gLbqSB8r+VHjTHJbVd2EdfI8cUj6CWJcZR+McJ6OYl/pezGaDfOWzqVZT
	 36nzUu3nIh1yAX5W74v9uT0P0SU3s8SsJbAMFf/IvlkKBaFEtvABuorRjdMDO/mTZp
	 ffTFoD5vtDwi9KbjHz1BNBqbgQDMqwH7m9pSK9VJ30aRKFAirf5RoF+LKZPywCvjAc
	 hRFVK8y/FK6qB4odZILqQIMTPHOZLwdfusTxCAbQ/Okwh6Dn3EMpI5AQxJDSQSLnaQ
	 IPsiFYIW2ed4l68VMhRKjguD7WEt7rG4VGlFCqdZzVEFk7mQPyRVKwcM/BKYXxoAjd
	 qVT17ntQRADJA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 19 Jan 2024 21:12:58 +0000
Message-Id: <CYIZR55BCZ5L.1DY4I65CDCLH8@seitikki>
Cc: <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][next] crypto: asymmetric_keys: remove redundant pointer
 secs
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Colin Ian King" <colin.i.king@gmail.com>, "David Howells"
 <dhowells@redhat.com>, "Herbert Xu" <herbert@gondor.apana.org.au>, "David S
 . Miller" <davem@davemloft.net>, <keyrings@vger.kernel.org>,
 <linux-crypto@vger.kernel.org>
X-Mailer: aerc 0.15.2
References: <20240118120745.2519762-1-colin.i.king@gmail.com>
In-Reply-To: <20240118120745.2519762-1-colin.i.king@gmail.com>

On Thu Jan 18, 2024 at 12:07 PM UTC, Colin Ian King wrote:
> The pointer secs is being assigned a value however secs is never
> read afterwards. The pointer secs is redundant and can be removed.
>
> Cleans up clang scan build warning:
> warning: Although the value stored to 'secs' is used in the enclosing
> expression, the value is never actually read from 'secs'
> [deadcode.DeadStores]
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  crypto/asymmetric_keys/verify_pefile.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/crypto/asymmetric_keys/verify_pefile.c b/crypto/asymmetric_k=
eys/verify_pefile.c
> index f440767bd727..2863984b6700 100644
> --- a/crypto/asymmetric_keys/verify_pefile.c
> +++ b/crypto/asymmetric_keys/verify_pefile.c
> @@ -28,7 +28,7 @@ static int pefile_parse_binary(const void *pebuf, unsig=
ned int pelen,
>  	const struct pe32plus_opt_hdr *pe64;
>  	const struct data_directory *ddir;
>  	const struct data_dirent *dde;
> -	const struct section_header *secs, *sec;
> +	const struct section_header *sec;
>  	size_t cursor, datalen =3D pelen;
> =20
>  	kenter("");
> @@ -110,7 +110,7 @@ static int pefile_parse_binary(const void *pebuf, uns=
igned int pelen,
>  	ctx->n_sections =3D pe->sections;
>  	if (ctx->n_sections > (ctx->header_size - cursor) / sizeof(*sec))
>  		return -ELIBBAD;
> -	ctx->secs =3D secs =3D pebuf + cursor;
> +	ctx->secs =3D pebuf + cursor;
> =20
>  	return 0;
>  }

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko


