Return-Path: <linux-kernel+bounces-101446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4E587A72B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 12:43:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1E2EB22F96
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 11:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ADF13F8FF;
	Wed, 13 Mar 2024 11:43:20 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4533F8E2
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 11:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710330200; cv=none; b=djvdvBRqeGO8FsQkMRdr/ikdvHfLm4kaICRu8qdafsqZOP9rNlxq4ykHFWCKy/W4EH7b/HIwwUNfVhAHRF9/AyKSiucdi0rflHQn2tOdDcC+PGfVv75O74L7upf3Pl/q9tLv/KGrWNT3gy3dkVsSL0exewmfQJG0glxVTwBetKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710330200; c=relaxed/simple;
	bh=ad8rTVaHct8urLSLHqtatS9UKpznhESWblE/bc49dsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cS1nPOp9HnA7a0lTAlLBfsyr8We/7ZoKDUsKFmSo3ofgn4zajwdiYkLFNjhJNVBwfoUsUmx1DvCIfU/YSbEWy0RPdyCjpOXsxzYLLTfl59mP/tptlXfQpRypWTbLLr017ncmerVe6ilcGJvDMHEHZCpLi52KykNgg9nwMJTNzFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1rkN0m-00052U-PD; Wed, 13 Mar 2024 12:43:08 +0100
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1rkN0l-0066XC-Ph; Wed, 13 Mar 2024 12:43:07 +0100
Received: from pengutronix.de (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 7371E2A4103;
	Wed, 13 Mar 2024 11:43:07 +0000 (UTC)
Date: Wed, 13 Mar 2024 12:43:06 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Daniel Smolik <smolik@mydatex.cz>
Cc: 
	"Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Linux regressions mailing list <regressions@lists.linux.dev>, linux-can@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Regressions can bus with MCP2515 on sama5d3 connected over SPI
 stop working on kernel > 5.4.271
Message-ID: <20240313-overload-eloquence-3e504ee0d00b-mkl@pengutronix.de>
References: <2ede8f49-41f8-4d9a-83e4-ea5d4d1677fe@mydatex.cz>
 <a2e64be0-e07d-4c55-aba7-87c7e4c876e0@leemhuis.info>
 <734cf096-3769-4610-b72f-394c31a8d942@mydatex.cz>
 <91d8a6b6-6186-4aa0-8462-56b4751854e9@leemhuis.info>
 <6918321b-038d-40b9-8149-d535bf9d3d52@mydatex.cz>
 <5f69d6ee-a07a-42a9-a238-7dbe1f82cc3f@mydatex.cz>
 <3e46d70b-196d-45c7-bfdf-869c78cdc81f@leemhuis.info>
 <20240313-polio-jinx-bc5fd5df7c06-mkl@pengutronix.de>
 <b6c9b015-86bc-475b-a190-e35fa76c1ceb@mydatex.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="e3a7udsf47bt22ng"
Content-Disposition: inline
In-Reply-To: <b6c9b015-86bc-475b-a190-e35fa76c1ceb@mydatex.cz>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--e3a7udsf47bt22ng
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 13.03.2024 12:22:25, Daniel Smolik wrote:
> this is my first bisection please be lenient :-) Threse is a result:
>=20
> marvin@marvin:/usr/src/linux$ git bisect good
> Bisecting: 0 revisions left to test after this (roughly 0 steps)
> [52f96cd135b160d44db4cb62a5b614b3bca20fbc] net: stmmac: xgmac: Remove
> uneeded computation for RFA/RFD

I think you still miss a bisection step.

The commit 52f96cd135b1 ("net: stmmac: xgmac: Remove uneeded computation
for RFA/RFD") is unrelated to CAN problem you described. It's in the
stmmac Ethernet driver.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--e3a7udsf47bt22ng
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmXxkUgACgkQKDiiPnot
vG8JGAf+LdzIqEkeVo4hYrxhHNp/mqLZ9kikzdmydSKIQdZjQT0MNca5MVLa/Uan
hcGTGeiSQoOa2MUYAZsUdUY/G4mSddDjNzJ5J/FtGrrrfnPcaYzu+OUeR5Rk+iAu
JzUSd15Bf9NLaTTs9D8+rw50WJq4Irqc9rmek54lOx2QiCveBEbH9H7KLsXpdkVW
jG31+k/0VICxHJQbnBtnE6t2ZJMNP9VKqx7YwM1/ue3e29X+DNIXpj+BB8rRrGtg
mawWyA+wyartjJYuMnTbUiwopp55QeQfhRppJ/hKjKUmcIQPFbYOMtxOYl5ktSPT
3oeQfU2ngbn1qQA2sO5xmI29es8j/w==
=Dqj4
-----END PGP SIGNATURE-----

--e3a7udsf47bt22ng--

