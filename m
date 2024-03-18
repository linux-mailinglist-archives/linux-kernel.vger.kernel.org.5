Return-Path: <linux-kernel+bounces-106677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 339F587F1D5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 22:12:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C68281F2218B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 21:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF5BA5823D;
	Mon, 18 Mar 2024 21:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rOGltg6g"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0277E58201;
	Mon, 18 Mar 2024 21:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710796335; cv=none; b=iRiCNZ+waB5ygLGZdtU7eBlLsvEbkPB+MSrX2seg3gGwCcxaMAbS2eSm7a2bjEdavE8Ve3p2GMg8EWse+9igiu/kO5HZQryPZasNBxwa0NFfO2Cmy547bhy+LeWtShpRCIS+2GfZ1TuRKqPxViLuUEyqdwIfSa+C43YOvm4HroU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710796335; c=relaxed/simple;
	bh=IpWgAIlYMtwsgxa7z0026r/3WZ0p2pmm5d57vMXFbGs=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=IyTzqSHenv7mYLw9OFw7iNLVQyhYtJPpJbiPoJ+Mm51F0GigFtZkU5ZnEJyZOP1XXrDin+KzV0ZhmD7AWP8z9eSMs5zvKwe+Fm93sIRNZb2jLe+/LltmBhZmS3RIGnqS/XaVX8+jPOiwbeSLNp3n+nsznD6GhFuSSMmVdq7c5To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rOGltg6g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8976AC433C7;
	Mon, 18 Mar 2024 21:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710796334;
	bh=IpWgAIlYMtwsgxa7z0026r/3WZ0p2pmm5d57vMXFbGs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rOGltg6gRUKyGmmBylZR6O0qD4vDTvUpynfI9Lpr+j+iFw9v4uH6qDQyNZnMs1Kwu
	 oi0ZYO8TXw/dCzTFzZc+7hliq42bfKtVWsQS9SfJGimsU2UlM05c7Q6IhAUJDsDy8/
	 kdjkGwBXHDzjMTRw/8ZnisRSeV9WmHbmpeZV+t4rUR3ic01QYMTYx6CDkEfdER6P1b
	 Kmy8EJb6qU/vW3z61+vrLt1BcI2qL5Lw6zqFoQk5lCg6a6Iif3o7eJN81Cq8QnTqdf
	 dLy8MXTmv8J3JR0gkRVOucxsv2iP4duE96sJncPdtSw86oeBNjOKURmaHT+g3YdnSH
	 lzgnYy5yW4jkw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 18 Mar 2024 23:12:10 +0200
Message-Id: <CZX6OOKP5RQD.3BN0EDSAF7QXR@kernel.org>
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Stefan Berger" <stefanb@linux.vnet.ibm.com>,
 <keyrings@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
 <herbert@gondor.apana.org.au>, <davem@davemloft.net>
Cc: <linux-kernel@vger.kernel.org>, <saulo.alessandre@tse.jus.br>,
 <lukas@wunner.de>, <bbhushan2@marvell.com>, "Stefan Berger"
 <stefanb@linux.ibm.com>
Subject: Re: [PATCH v6 12/13] crypto: asymmetric_keys - Adjust signature
 size calculation for NIST P521
X-Mailer: aerc 0.15.2
References: <20240312183618.1211745-1-stefanb@linux.vnet.ibm.com>
 <20240312183618.1211745-13-stefanb@linux.vnet.ibm.com>
In-Reply-To: <20240312183618.1211745-13-stefanb@linux.vnet.ibm.com>

On Tue Mar 12, 2024 at 8:36 PM EET, Stefan Berger wrote:
> From: Stefan Berger <stefanb@linux.ibm.com>
>
> Adjust the calculation of the maximum signature size for support of
> NIST P521. While existing curves may prepend a 0 byte to their coordinate=
s
> (to make the number positive), NIST P521 will not do this since only the
> first bit in the most significant byte is used.
>
> If the encoding of the x & y coordinates requires at least 128 bytes then
> an additional byte is needed for the encoding of the length. Take this in=
to
> account when calculating the maximum signature size.
>
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> Reviewed-by: Lukas Wunner <lukas@wunner.de>
> Tested-by: Lukas Wunner <lukas@wunner.de>
> ---
>  crypto/asymmetric_keys/public_key.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/crypto/asymmetric_keys/public_key.c b/crypto/asymmetric_keys=
/public_key.c
> index e5f22691febd..16cc0be28929 100644
> --- a/crypto/asymmetric_keys/public_key.c
> +++ b/crypto/asymmetric_keys/public_key.c
> @@ -233,6 +233,7 @@ static int software_key_query(const struct kernel_pke=
y_params *params,
>  	info->key_size =3D len * 8;
> =20
>  	if (strncmp(pkey->pkey_algo, "ecdsa", 5) =3D=3D 0) {
> +		int slen =3D len;
>  		/*
>  		 * ECDSA key sizes are much smaller than RSA, and thus could
>  		 * operate on (hashed) inputs that are larger than key size.
> @@ -246,8 +247,19 @@ static int software_key_query(const struct kernel_pk=
ey_params *params,
>  		 * Verify takes ECDSA-Sig (described in RFC 5480) as input,
>  		 * which is actually 2 'key_size'-bit integers encoded in
>  		 * ASN.1.  Account for the ASN.1 encoding overhead here.
> +		 *
> +		 * NIST P192/256/384 may prepend a '0' to a coordinate to
> +		 * indicate a positive integer. NIST P521 never needs it.
>  		 */
> -		info->max_sig_size =3D 2 * (len + 3) + 2;
> +		if (strcmp(pkey->pkey_algo, "ecdsa-nist-p521") !=3D 0)
> +			slen +=3D 1;

Just wondering the logic of picking between these:

1. "strncmp"
2. "strcmp"

Now the "ecdsa" is matched with strncmp and "ecdsa-nist-p521" is
compared with strcmp.

So is there a good reason to use different function in these
cases?

I'd guess both could be using strcmp since comparing against
constant...

> +		/* Length of encoding the x & y coordinates */
> +		slen =3D 2 * (slen + 2);
> +		/*
> +		 * If coordinate encoding takes at least 128 bytes then an
> +		 * additional byte for length encoding is needed.
> +		 */
> +		info->max_sig_size =3D 1 + (slen >=3D 128) + 1 + slen;
>  	} else {
>  		info->max_data_size =3D len;
>  		info->max_sig_size =3D len;


BR, Jarkko

