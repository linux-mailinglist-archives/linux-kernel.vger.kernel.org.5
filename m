Return-Path: <linux-kernel+bounces-7346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B26881A642
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 18:25:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE7281F24FB0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 17:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0509847A67;
	Wed, 20 Dec 2023 17:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="LAiFO9Ms"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.subdimension.ro (skycaves.subdimension.ro [172.104.132.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA74D47A48;
	Wed, 20 Dec 2023 17:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from sunspire (unknown [188.24.94.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 7DCC028B50B;
	Wed, 20 Dec 2023 17:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=subdimension.ro;
	s=skycaves; t=1703093127;
	bh=y5vShnC08AKzTQTcRg4gInuuznDW1Uhrzwdu10+dvQw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LAiFO9MsEhzkYDFMwKcQf8wB8L61698RXerZe5mkKVqD7q7L6+KpiDJ36UiVpPXNQ
	 eL2NBJvAHSqynMCmNd5fG4bQO75+c2zIhHKG9VMTBwZc6chzs4ymLOORwUz3kLoX7U
	 vxV6VFMJQKEEQaTMaTQJnx8a8FGvOTs7jWipV4qo=
Date: Wed, 20 Dec 2023 19:25:25 +0200
From: Petre Rodan <petre.rodan@subdimension.ro>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: pressure: honeywell,mprls0025pa
Message-ID: <ZYMjhfAbWfw9vUdd@sunspire>
References: <20231219130230.32584-1-petre.rodan@subdimension.ro>
 <20231219130230.32584-2-petre.rodan@subdimension.ro>
 <20231220151645.16ada807@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Yqw49bkJ6dzp0cuL"
Content-Disposition: inline
In-Reply-To: <20231220151645.16ada807@jic23-huawei>


--Yqw49bkJ6dzp0cuL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


hi Jonathan,

On Wed, Dec 20, 2023 at 03:16:45PM +0000, Jonathan Cameron wrote:
> On Tue, 19 Dec 2023 15:02:20 +0200
> Petre Rodan <petre.rodan@subdimension.ro> wrote:
> >    honeywell,pmin-pascal:
> >      description:
> >        Minimum pressure value the sensor can measure in pascal.
> > +      To be specified only if honeywell,pressure-triplet is set to "NA".
> That just added a backwards compatibility break.  It would be fine
> if there was a default: NA for honeywell,pressure-triplet or a check that either
> one or the other was supplied (which I'd prefer).  Thus old bindings will work
> and new ones also supported.

ok, I see your reasoning. but in this second scenario that you prefer how can we
propery define the 'required:' block? an equivalent to

required:
  - compatible
  - reg
  - (honeywell,pmin-pascal && honeywell,pmax-pascal) || honeywell,pressure-triplet
  - honeywell,transfer-function


thanks,
peter

--Yqw49bkJ6dzp0cuL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE2Ap/wXYVGTXsPl+pzyaZmYROfzAFAmWDI4AACgkQzyaZmYRO
fzB5ZA/8CeVKGy6zmv8F+NAtQkXHE+1XinZxdiHRwHo49Uj2sWnJnTCGg6JwocsQ
ULmY/Kv81xgNGVbSC/MxDEnrwfKQ755pq/vLqLZAeUeRVKXLAQEfwYMXpLflFKYI
Ct2YUPMacqOY+VyIuRCH619LAjcd25s1QfgrkqHJFvzv2cZh/Fcf89Sqc+hFSuPi
0BGzR55VvW1D2TXcjycKD/DbUOUeVDcBbYqmu7wlnHo02w9N+KD2BXwbkgqhI22Z
Jsgh+b0pufCdFmKuXAoWFnwgw/tB1+pvqNnVDiic8VxOzjKEvYpkyQwrbtGv/Osa
7rG6NFtfgqEnLPOmO5S3rYhnfe8o69yMkWB3tfO2thf/7Z4v88jIPzFhqTMsyQTg
eyqCBIzr/9fnDXyak3hdjSqpZKhiEg1DU2XBWT2wmL7baNCF+Yn7IRQ70tPEf8yp
R83Hmp67TykKFBsBXU7HW7fBK1BGc+SQLlY/d1wJ1BOKlEplPBqCm5af1I9do5lP
YIBnV54sReWPHb7TpcW9b+4ajmy8ACDXL7jNTZ2X2LdA40VehV1i9Qzep4E2ypph
PjrrVnsBIIn1JgeI7PmPdyd6ybH4wDkdOuWE1IqC2S7/+2FBce6gCv7Y44jYjrkF
ad0dhJAPciHBmNteBujC/qbCBz8j1ebGNyxHIokRLMA/Z6uesEg=
=Ho9j
-----END PGP SIGNATURE-----

--Yqw49bkJ6dzp0cuL--

