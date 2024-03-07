Return-Path: <linux-kernel+bounces-96079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C58638756D4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:13:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8059828360C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 19:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A89F136669;
	Thu,  7 Mar 2024 19:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pYiCp55t"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844D3136666;
	Thu,  7 Mar 2024 19:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709838817; cv=none; b=pXgnVNP1mvUGuR79BfuM2y2ywmUiNBDzMay4QE+OpHIChDv1DX/MBWZNPg0wZkHB/RGn0PsHelTIfXyCcpDgePIX4YnQxhFKKd3qK3AVd0wBeG0nqoyyMAE929udfJGlzY/eH5X6ItAufxKQcH/C2BUqMW9LrD/bbKT8n2IcI4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709838817; c=relaxed/simple;
	bh=9zJnmGMsLqUQsUEkdPNsU0n9rJJ1agrvxLcltIkf3ps=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=ji4EPlBBofVzLRJZZ82LEjl9DM0HhqexDitdp9VIZGPDbT3KglXPId1BqBTEeqfAwYYXChq13qyxqChXIsVCkbaNaybStwJQMoS2jzkhKFCUimravhOJ98KU2JF+OMDtcZjMa7X+h2By7UQhRIg7voj6Tv5nV4wRTRic6dwRWyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pYiCp55t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5197EC433F1;
	Thu,  7 Mar 2024 19:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709838817;
	bh=9zJnmGMsLqUQsUEkdPNsU0n9rJJ1agrvxLcltIkf3ps=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=pYiCp55t6UoXb1ucGc0PMkLkkWFX44KYJUbznnyx/c036BYLyLl/zv9GZwCp1AQKk
	 3dx05UcrloDd3FypVFDY0aag56FKHT3Eo0/Dr2+O7ygFY8O0LBBJ/UkhGbXLIlpkyT
	 fPaLjkUVLMo8U/VCXlsraOQyk+LqSYCHdXoo2RQ4zIyJ5wsYWNJCHCKeYbKlNnwV/Y
	 dQsgk3pBOPS/OJoo//upW/+67tXh8WVaDTOwr48nbbNA0voxoFFWy4Se+0rCNdE3fL
	 6CH/Gm8UcCcAa3Ef2swupuinGvX8++Feqlc023feGCOwH2BlRGYJjC2+rE3TWGX3st
	 e0hZFVXHHGEFQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 07 Mar 2024 21:13:33 +0200
Message-Id: <CZNR9UY8J7Q0.2R1YYTOO4Z92G@kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <saulo.alessandre@tse.jus.br>,
 <lukas@wunner.de>
Subject: Re: [PATCH v5 09/12] crypto: ecdsa - Rename keylen to bufsize where
 necessary
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Stefan Berger" <stefanb@linux.ibm.com>, <keyrings@vger.kernel.org>,
 <linux-crypto@vger.kernel.org>, <herbert@gondor.apana.org.au>,
 <davem@davemloft.net>
X-Mailer: aerc 0.17.0
References: <20240306222257.979304-1-stefanb@linux.ibm.com>
 <20240306222257.979304-10-stefanb@linux.ibm.com>
In-Reply-To: <20240306222257.979304-10-stefanb@linux.ibm.com>

On Thu Mar 7, 2024 at 12:22 AM EET, Stefan Berger wrote:
> In some cases the name keylen does not reflect the purpose of the variabl=
e
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

nit: still don't get why "* sizeof(u64)" would ever be more readable
thean "* 8".

BR, Jarkko

