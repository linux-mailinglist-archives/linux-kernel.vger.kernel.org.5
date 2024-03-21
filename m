Return-Path: <linux-kernel+bounces-110551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3BB886078
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 19:24:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 394BCB21015
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 18:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA9D133413;
	Thu, 21 Mar 2024 18:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l0EQyOKG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D66379C3;
	Thu, 21 Mar 2024 18:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711045473; cv=none; b=XXhyxR25tQ6TV6/E73Vr2FLQa9nfzt1kFomoKLXLWRlVLSg5iZ2gG0gW52enFO3Kg/i3+MBHz8x9E+pdv3iqPnGqBmd+j/sIMapfZWD8m7C9+SlDQwzU4KkQ9Jmdax3jc1FpN0PnPl+8JKjJ49ApqpMR1IHlQYgL1w43tTFtIks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711045473; c=relaxed/simple;
	bh=6XDm0H7ukgWK62f8uLvS2K0zAt4z5bHjRTxNVSBu7FU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=giDvePGzZcjP7GJUHhYmxnLi25gryZotNusl4ynlbi1AdIDweeTldlUxhbFa7UZOckdT/Rqc0yBhtzr/iNq+GjvcKWhJTQ685GrcQPcU/D3kVhH4b7te8UNX2ZcXyqizOZHETDvH8qw/EDF3QOwFqE0TEOUFEVWrAEX57TByBy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l0EQyOKG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E949C433F1;
	Thu, 21 Mar 2024 18:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711045472;
	bh=6XDm0H7ukgWK62f8uLvS2K0zAt4z5bHjRTxNVSBu7FU=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=l0EQyOKGlSqTAnbBIdyevJIWPpZnrVnPa3Y0y3Z5RlyshAt52oVRZPMfLjqK+PcfD
	 7sHFf4AyhqH+80XW6vhex7Zav9GuzAIaD1aPG7NGNNobWOx7BpZl+OtMmVFXL4kk4l
	 YZOM0VbcOrraIPYwN+JfmfS4w8bnuyAB7UnEcJzvDpzEiJVUKk+T9XywBSogUjxgUl
	 +VSCZC+YLqL/rkaF2rhhnNkIUGbmC3nqkcI8zkDRmuadYe52u33ZXLsgCxHI7dSxwl
	 mCtqtWCvm4rCktdJ97xjRo0qTvTNUdPqF2YHsBTiHeYvw0rs4o8pIIuvK1DMej6x2a
	 Z8RbdXpTWjRnA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 21 Mar 2024 20:24:28 +0200
Message-Id: <CZZMZWQE3AKZ.3O07JH2ZNJC9V@kernel.org>
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
 <CZZLKGMM0B9E.7J1CGE8EIGQX@kernel.org>
 <58166047-b339-4234-832b-a1aad6bf49de@linux.ibm.com>
In-Reply-To: <58166047-b339-4234-832b-a1aad6bf49de@linux.ibm.com>

On Thu Mar 21, 2024 at 7:42 PM EET, Stefan Berger wrote:
>
>
> On 3/21/24 13:17, Jarkko Sakkinen wrote:
> > On Wed Mar 20, 2024 at 1:47 PM EET, Stefan Berger wrote:
> >> Add the number of bits a curve has to the ecc_curve definition to be a=
ble
> >> to derive the number of bytes a curve requires for its coordinates fro=
m it.
> >> It also allows one to identify a curve by its particular size. Set the
> >> number of bits on all curve definitions.
> >>
> >> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> >> Tested-by: Lukas Wunner <lukas@wunner.de>
> >> ---
>
> >>   		.y =3D tc512b_g_y,
> >> diff --git a/include/crypto/ecc_curve.h b/include/crypto/ecc_curve.h
> >> index 70964781eb68..63d5754e7614 100644
> >> --- a/include/crypto/ecc_curve.h
> >> +++ b/include/crypto/ecc_curve.h
> >> @@ -23,6 +23,7 @@ struct ecc_point {
> >>    * struct ecc_curve - definition of elliptic curve
> >>    *
> >>    * @name:	Short name of the curve.
> >> + * @nbits:	The number of bits of a curve.
> >>    * @g:		Generator point of the curve.
> >>    * @p:		Prime number, if Barrett's reduction is used for this curve
> >>    *		pre-calculated value 'mu' is appended to the @p after ndigits.
> >> @@ -34,6 +35,7 @@ struct ecc_point {
> >>    */
> >>   struct ecc_curve {
> >>   	char *name;
> >> +	unsigned int nbits;
> >=20
> > Nit:
> >=20
> > Hmm not strongly opionated here but wouldn't it be more consistent to
> > use u32 here as the types below are also exact bitsize types?
>
> I will change this for v8. I will probably delay v8 until this patch=20
> here has been queued for upstreaming because 11/13 will need a similar=20
> module alias.
>
> https://lore.kernel.org/linux-crypto/20240321144433.1671394-1-stefanb@lin=
ux.ibm.com/T/#u

Right for this:

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

.. given that I don't have strong opinion on the choice :-)

BR, Jarkko

