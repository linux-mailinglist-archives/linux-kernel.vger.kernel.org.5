Return-Path: <linux-kernel+bounces-89120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C7D86EAB3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 21:50:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 618211C25419
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 20:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04F055C04;
	Fri,  1 Mar 2024 20:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BGuF872W"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E434778B;
	Fri,  1 Mar 2024 20:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709326234; cv=none; b=k7ygv6fQQRK2/ts9fj0KuxTiXwXp3N9FQkDiXjJXp+6L+nis78+fcKBlUNdaahlwS3IC678y+pGEV34CGsvXOcIg28GA5BglD4dJWdY0VWBcNjglxFbUrnL2a/f7kEkbKNHcin4UtW2oV5NMIW6dy30Zd+EKNx3OmCJXeN2YqcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709326234; c=relaxed/simple;
	bh=xiRQIQKWzL8HL+E4B306OoPqqut4uAJB06QRhmBx0Xg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=ZlAVUzd7RaGW6xp23lwNsFP1Th/IkApfaGy0e1kAjPg4xp1lDS4ubzZ5BiO91nRU5q9fwcdSPUmOrivVL0YPE9Q1PJuXEJ0r0rQ6/T4+JyMW768CvYZdSmIKGTnUZpu1dc/R2Zd+skYTgyVLwfuo+13ItweX2iVJGH3j4fDwa5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BGuF872W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16FF3C43394;
	Fri,  1 Mar 2024 20:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709326233;
	bh=xiRQIQKWzL8HL+E4B306OoPqqut4uAJB06QRhmBx0Xg=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=BGuF872WTUt6SdMMWkfMzQAWp44BAozagiJDNIoUR+2q+898RRu71HaF4LrquvJEz
	 PLzU8WVLr9s4TeWZeImZmF3J24B+3VuJhAaSGiJ3MvGDd0bhTyWKledaKF3LmJMI6F
	 4gCOfGNT8p50dhLjIbvp2vu2B3ucnf+qH6OHUm8jImBoodVlqUzpWj/wJ3OfgPGsfY
	 vWt7vonqVCAYwK16iCXQO7C7bUua8QHXqpmEiDYK7RmMua/y/5K7cNv3vyP54JOkoP
	 ZayfIZzJW6zyFUn8IxY8dHqnO0qysliap3XZlUSO0zfka8Ir2qC3VUTKLOQTVTS4Io
	 Yk88IxNNuXIRA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 01 Mar 2024 22:50:30 +0200
Message-Id: <CZIPKTL42F1Z.2U4Q28IIQ159K@suppilovahvero>
Cc: <linux-kernel@vger.kernel.org>, <saulo.alessandre@tse.jus.br>,
 <lukas@wunner.de>
Subject: Re: [PATCH v4 09/12] crypto: ecdsa - Rename keylen to bufsize where
 necessary
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Stefan Berger" <stefanb@linux.ibm.com>, <keyrings@vger.kernel.org>,
 <linux-crypto@vger.kernel.org>, <herbert@gondor.apana.org.au>,
 <davem@davemloft.net>
X-Mailer: aerc 0.15.2
References: <20240301022007.344948-1-stefanb@linux.ibm.com>
 <20240301022007.344948-10-stefanb@linux.ibm.com>
 <CZIPDP0W9TOP.3CCT8QUB0R4L3@suppilovahvero>
 <90606a3c-1384-407b-8270-dd76dccc700b@linux.ibm.com>
In-Reply-To: <90606a3c-1384-407b-8270-dd76dccc700b@linux.ibm.com>

On Fri Mar 1, 2024 at 10:47 PM EET, Stefan Berger wrote:
>
>
> On 3/1/24 15:41, Jarkko Sakkinen wrote:
> > On Fri Mar 1, 2024 at 4:20 AM EET, Stefan Berger wrote:
> >> In some cases the name keylen does not reflect the purpose of the vari=
able
> >> anymore once NIST P521 is used but it is the size of the buffer. There=
-
> >> for, rename keylen to bufsize where appropriate.
> >>
> >> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> >> ---
> >>   crypto/ecdsa.c | 12 ++++++------
> >>   1 file changed, 6 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/crypto/ecdsa.c b/crypto/ecdsa.c
> >> index 4daefb40c37a..4e847b59622a 100644
> >> --- a/crypto/ecdsa.c
> >> +++ b/crypto/ecdsa.c
> >> @@ -35,8 +35,8 @@ struct ecdsa_signature_ctx {
> >>   static int ecdsa_get_signature_rs(u64 *dest, size_t hdrlen, unsigned=
 char tag,
> >>   				  const void *value, size_t vlen, unsigned int ndigits)
> >>   {
> >> -	size_t keylen =3D ndigits * sizeof(u64);
> >> -	ssize_t diff =3D vlen - keylen;
> >> +	size_t bufsize =3D ndigits * sizeof(u64);
> >=20
> > why not just "* 8"? using sizeof here makes this function only unreadab=
le.
>
> 'unreadable' is a 'strong' word ...

so what is the gain when writing sizeof(u64)?

BR, Jarkko

