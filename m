Return-Path: <linux-kernel+bounces-110468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A35C0885F57
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 18:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CFAFB253DB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 111901B599;
	Thu, 21 Mar 2024 17:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YX71/LRT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EEC8B66F;
	Thu, 21 Mar 2024 17:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711041094; cv=none; b=OTu/hIWO+Vni44ldXbv1atI0ZJd9HldDNnYxuLHFW30oiifShKEFF0C0FazZ9iOK4/YfVapRP2oGBhBtTlwwD3Kv6DbRjfnDDSoZ1Xh8qleYXT8MKfik3qbpHHTvnmqtXSRcXRme9gsr14LqsnmYgPb3HFvMnSGRemBEa4KH7SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711041094; c=relaxed/simple;
	bh=jXuFZJUV37rEmKZRIlm0kmXPV1xp3k387H2KoiGRfe0=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=hhriBFdyQpKrxUUyWz1xcDGlTBFRkeZoteLTwBk1JjLOQyolGsuj/wtVIRyQJ6yYu6/aXsZobPATy6G7C3T4u7RIVYLlm1CthOkeiWYRpwKIBD+A7EVmJd0NFOfVelIj8Uy+JApeEydJ5hElaY58fdYaz+Ef0YOjxlcFOcus1j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YX71/LRT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51A20C433F1;
	Thu, 21 Mar 2024 17:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711041094;
	bh=jXuFZJUV37rEmKZRIlm0kmXPV1xp3k387H2KoiGRfe0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YX71/LRTJ0i7MRMGXJRbm1DQd1lm7U8/7PHagZa4RN/zDetpvG+0/ER4mhFJhZqcb
	 k6n0PwOJFNHW4Lf5kQM/bHxZWvyQukProwiPGiOjD0IIqmXA2EIEf37PL86HB+6eqJ
	 F2irANB1GYiVickk1ra2hRjYuo1GTqGVcF9gqJlmoca37NsZKOk5pUJMyKRxYnmRXV
	 hqAtqDtGFe4LjE3IqOU76DIjTCATAmj+hd2V5pkWkwi46+CSix+/952pawQBFyRK/Y
	 pWcNQDZKcjLRic6BYChUbVrTMGp5FEJix70x1MIUpZcP2VL1MBOr3laH4AarebyjjD
	 Bqvq0rgkIcXig==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 21 Mar 2024 19:11:30 +0200
Message-Id: <CZZLG1NOKZED.3VQXFGK57IEEU@kernel.org>
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Stefan Berger" <stefanb@linux.ibm.com>, <keyrings@vger.kernel.org>,
 <linux-crypto@vger.kernel.org>, <herbert@gondor.apana.org.au>,
 <davem@davemloft.net>
Cc: <linux-kernel@vger.kernel.org>, <saulo.alessandre@tse.jus.br>,
 <lukas@wunner.de>, <bbhushan2@marvell.com>
Subject: Re: [PATCH v7 03/13] crypto: ecdsa - Adjust tests on length of key
 parameters
X-Mailer: aerc 0.17.0
References: <20240320114725.1644921-1-stefanb@linux.ibm.com>
 <20240320114725.1644921-4-stefanb@linux.ibm.com>
In-Reply-To: <20240320114725.1644921-4-stefanb@linux.ibm.com>

On Wed Mar 20, 2024 at 1:47 PM EET, Stefan Berger wrote:
> In preparation for support of NIST P521, adjust the basic tests on the
> length of the provided key parameters to only ensure that the length of t=
he
> x plus y coordinates parameter array is not an odd number and that each
> coordinate fits into an array of 'ndigits' digits. Mathematical tests on
> the key's parameters are then done in ecc_is_pubkey_valid_full rejecting
> invalid keys.
>
> The change is necessary since NIST P521 keys do not have keys with
> coordinates that each require 'full' digits (=3D all bits in u64 used).
> NIST P521 only requires 2 bytes (9 bits) in the most significant digit
> unlike NIST P192/256/384 that each require multiple 'full' digits.
>
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> Tested-by: Lukas Wunner <lukas@wunner.de>
> ---
>  crypto/ecdsa.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/crypto/ecdsa.c b/crypto/ecdsa.c
> index 6653dec17327..64e1e69d53ba 100644
> --- a/crypto/ecdsa.c
> +++ b/crypto/ecdsa.c
> @@ -230,7 +230,7 @@ static int ecdsa_set_pub_key(struct crypto_akcipher *=
tfm, const void *key, unsig
>  	if (ret < 0)
>  		return ret;
> =20
> -	if (keylen < 1 || (((keylen - 1) >> 1) % sizeof(u64)) !=3D 0)
> +	if (keylen < 1 || ((keylen - 1) & 1) !=3D 0)
>  		return -EINVAL;
>  	/* we only accept uncompressed format indicated by '4' */
>  	if (d[0] !=3D 4)

Had to write this down to the paper to fully get it but yeah makes
sense (especially since I just truncated 4 KiB blocks to 1 KiB
in my doc update :-)) but yeah seems to be correct:


Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

I guess that in this case I can give also tested-by since I actually
did test the formula (on paper):

Tested-by: Jarkko Sakkinen <jarkko@kernel.org>

As in general for tested-by's for patches I've sent or seen in
circulation there's bunch of convetions I've encountered so I do
agree that it is up to Herbert to decide the correct one.

BR, Jarkko

