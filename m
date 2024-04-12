Return-Path: <linux-kernel+bounces-143097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A81E58A342C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 18:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2169C1F23338
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 16:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A2814A09E;
	Fri, 12 Apr 2024 16:54:49 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDDC149E06
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 16:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712940889; cv=none; b=aWlhxgzcXyXLyW8bIJ6sY9MVVpOgRZVsl/Fk1WDLTm5GhYlRQa6a5Wn8AbQx0Qy1RQrldH9paRxFWp5HT2mLYTQ3FPKVIq8ABsZM9Y+w+Z2+k7RKWMM/G+2IN6mjmwGVrMSr1DYRindQgUn/wwEJBjJxFBRZ+7m5nrDJey+HvXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712940889; c=relaxed/simple;
	bh=JGZ/o7xPNMB3lQzZAI2x5qpzqU1J+HhzBFHlSDmtYjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qWjXtNK3NGdvJHyjA/E18lYcEMd5S3Gacnr6I0R4jjTFVCKESB4qw+j/zL23ozmSfd/jLfPtYh9L4snohm9BKg/h8rk4BWl85tZvWFyuQuj+RNn++EkiiCER5OHI8I/JUf/bKptH6iJgRv8WLKDAgz2yYVj+2Ebyi/ruV1IRcyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rvKAj-0002QA-Eb; Fri, 12 Apr 2024 18:54:41 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rvKAi-00BuVJ-5B; Fri, 12 Apr 2024 18:54:40 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rvKAi-000I6d-0F;
	Fri, 12 Apr 2024 18:54:40 +0200
Date: Fri, 12 Apr 2024 18:54:39 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Raag Jadav <raag.jadav@intel.com>, linux-kernel@vger.kernel.org, kernel@pengutronix.de, 
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] driver core: Make dev_err_probe() silent for -ENOMEM
Message-ID: <akweek3ripnc53nzramuj7px5itkz5mlwwlhrnljjzrwribtpb@g54o7dfof3wg>
References: <20240412164405.335657-2-u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="srxw4bviogidb4uk"
Content-Disposition: inline
In-Reply-To: <20240412164405.335657-2-u.kleine-koenig@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--srxw4bviogidb4uk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, Apr 12, 2024 at 06:44:05PM +0200, Uwe Kleine-K=F6nig wrote:
> base-commit: 4118d9533ff3a5d16efb476a0d00afceecd92cf5

That's today's next/master.

> prerequisite-patch-id: 950b86247f1ba5dfc0396d9777d83e641ff62c35
> prerequisite-patch-id: 59206f0661ac45767ecf89a11ee57a0f9ee26b3c
> prerequisite-patch-id: a3ca2b5359cf23a48ca505280d967f02d9ce356c
> prerequisite-patch-id: 2b7c70d39b660d374794bac26e7b5e9a7f26da8f
> prerequisite-patch-id: 569cb54f9b2390be8d51979045722462e0b63f2d
> prerequisite-patch-id: edc1f62b9d5c0e658c7283bd3353d2004a0c1fbf
> prerequisite-patch-id: 8201835ed22aa6956d219d84299f9226fb8254c1
> prerequisite-patch-id: 07772cf036deb3150560629bc287510901e90f24
> prerequisite-patch-id: d84360cad6a23ccbadc1205541ffb218fa589ba7
> prerequisite-patch-id: 79e7647450348ef0cca53af2bc5e5a0033dcec57
> prerequisite-patch-id: 45568b19e28a0cb3f46699ff945adc654eda07d2
> prerequisite-patch-id: 7daf4547e4b3785959e0c024ce95141cd1d936da
> prerequisite-patch-id: f3c1f5b72e3b503760d4b70bb661ceb8381c4822
> prerequisite-patch-id: 5e0cca8fff7c73448710f42e711eff5a863b8a31
> prerequisite-patch-id: 188bb3126861dc5027e5a0af78370ef8bb66fd8a
> prerequisite-patch-id: afaee9f242fa90b29a3b8e971d0cbfd00269ad2d
> prerequisite-patch-id: 5e815580f4d875d8720236fc016f6848d75b3cc9
> prerequisite-patch-id: 0fd48f45bc44d66c9ca01b03d570fea876fc4abb
> prerequisite-patch-id: b63f367f8354d56916d33c4236c79cf8e1c7d67a
> prerequisite-patch-id: ea68cb08a89ece1fb288f08d8c72ee7bdc378e79
> prerequisite-patch-id: 0fa92154ed986e765a41079f5aa441ae0ab4683b
> prerequisite-patch-id: 8eca4420a223355531ddfc5331729feb5fff9812
> prerequisite-patch-id: d72dbdaa1f3f12e970341277e7e5bbb8da15f228
> prerequisite-patch-id: 7699990bf345e9551251211ee798f3b93c257d24
> prerequisite-patch-id: 168172f0fec6fcf334cd6cc600749afd57ade8a1
> prerequisite-patch-id: 96a01bb6af22da23b4e7acb5897117db959e8a08
> prerequisite-patch-id: 82222b0c579003169bcc1f1d84bb34956655cfb0
> prerequisite-patch-id: 075db535154891b70ed4e659588e9294e06a5f38
> prerequisite-patch-id: 83c646c3aa4ef3578e0fcd86ffc395b51cc47763
> prerequisite-patch-id: 4b8d2995e96ae290599d752cf1c1d2537e47bfab
> prerequisite-patch-id: 5915e9d3dd78f832ab0017c81df770f443b32169
> prerequisite-patch-id: dba378294fcb0aa72ee6bbace049c3ecc2b97bcb
> prerequisite-patch-id: 712d0c765bdecbc60d72e62b10b329b525dfd16f
> prerequisite-patch-id: 85e037f468c34b7a904f926e0cc555d7863c2cc7
> prerequisite-patch-id: 4e475984306a28ba367a171a6450bcfb07d0eb3c
> prerequisite-patch-id: 40b6db6c8d4e5bcaab64ce1afd53a79586f3df0b
> prerequisite-patch-id: fd4da5ff37eba383f7de7dd219cfcb297155b654
> prerequisite-patch-id: b076059966b15d0bf1c8282f48502299987b628a
> prerequisite-patch-id: 6b4540ea605fc3feb59128abee429c870b506da5
> prerequisite-patch-id: b98d4896c4dbc26adb898815c3e10722796bc9ca
> prerequisite-patch-id: f82322e104e3194c77b66a2ab2e465dd2a162d65
> prerequisite-patch-id: 3c719132de0cc72d3e548b5f3623cccb28a74ab5
> prerequisite-patch-id: d23e9aef7476d7f0976a9d8919c8474a5f91c20c
> prerequisite-patch-id: e725b9cf221da371b19d5aef5d1b4a5e813a19ee
> prerequisite-patch-id: 932d88887d4028aee27a809eeb89d1dc7835acc8
> prerequisite-patch-id: 48554c57f1d06553af3ded861ebf9b88ee6b03c4
> prerequisite-patch-id: c26315d8be3a746b04dea921d41c903d054b774f
> prerequisite-patch-id: fc598d2febb873efbaf53d4abfba4fe9c27aee52
> prerequisite-patch-id: 77b58bda743a1fde9b0b040f7832ec3d5853ea75
> prerequisite-patch-id: a64b4850058cd9189ccca081847f8908dbf91ae3
> prerequisite-patch-id: 73a6bb8ed4e20eb90127f1c2e6361d52ae17791c

Dang, I applied that patch on one of my working branches based on next.
These other patches are orthogonal to this patch, which applies just
fine to next/master.

Best regards and sorry for the mess,
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--srxw4bviogidb4uk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmYZZ04ACgkQj4D7WH0S
/k5muAgAri4iqVlczJSdQQ1V7nqNFmjN+L7eBigBq77EExWMNg2t7XVAiDCJbBMt
Jr69sd+qwJasT5ac7HYFzF7sA7eIUuNOhpniPKJRu/MX4iianOVbxjdh2eglPgKR
cYhDnrDoPh5TmDN1vdhCIuSCYRNQUAbgtmMcnaN2mlHWxY7r5oB6uexwrutTuIg0
/h+v8N8PLsxH0IGkwsz3D//9HYS6lL6VghvddEf/tk08K7If9x3rW5pU1a/4haO/
HcULPdhyBmPcE/jITa9udr7xFriGgaUhSFvQnz9rPU2ZQ8bpOruLR4q8TOSbZzGt
VIVMxgWLyAV4042s531M8joMcxTQnA==
=K/02
-----END PGP SIGNATURE-----

--srxw4bviogidb4uk--

