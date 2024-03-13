Return-Path: <linux-kernel+bounces-101362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C8E87A5F9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 11:38:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DA50282A24
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 10:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2AF3D39B;
	Wed, 13 Mar 2024 10:38:00 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61B53D0BA
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 10:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710326280; cv=none; b=c9VKaTygEzr3u48bVeeWDE4be1By9Y5dsX5lpchHjrEX57xjFQhcTDpupDUzC8206kzvKyU3/a2RVFQN4bf/w4cB51XP0lbLHmMJny7513q2rJaATP0qGq/CQCRXLTK6DQk+pXyy/t6DIjnQNtubhPcKcfXBbKtky+GuhGGb51A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710326280; c=relaxed/simple;
	bh=0Crvk+O/NT+NwUth/g+9ObKAqtKIfm1Zjikec2AEkw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PewTslnokgdnqjp4PABne3yPCKAnwxuLUOCTx18OKcKh4DFXVTKXBHhCSEBnijLmlhgwPoX9H7nNAdI0WCvXVU7zZ3F7o7PjsWx2/FOWQuGAuV0jHcXBCecxIXRd6wGGbq8cUMxvEmx9/FfSDbWJSfscm92VIRr3akKSW96XPPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1rkLzU-0002kY-5D; Wed, 13 Mar 2024 11:37:44 +0100
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1rkLzT-0065xh-AV; Wed, 13 Mar 2024 11:37:43 +0100
Received: from pengutronix.de (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 671E12A4015;
	Wed, 13 Mar 2024 10:35:02 +0000 (UTC)
Date: Wed, 13 Mar 2024 11:35:01 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: 
	"Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Daniel Smolik <smolik@mydatex.cz>, Linux regressions mailing list <regressions@lists.linux.dev>, 
	linux-can@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Regressions can bus with MCP2515 on sama5d3 connected over SPI
 stop working on kernel > 5.4.271
Message-ID: <20240313-polio-jinx-bc5fd5df7c06-mkl@pengutronix.de>
References: <2ede8f49-41f8-4d9a-83e4-ea5d4d1677fe@mydatex.cz>
 <a2e64be0-e07d-4c55-aba7-87c7e4c876e0@leemhuis.info>
 <734cf096-3769-4610-b72f-394c31a8d942@mydatex.cz>
 <91d8a6b6-6186-4aa0-8462-56b4751854e9@leemhuis.info>
 <6918321b-038d-40b9-8149-d535bf9d3d52@mydatex.cz>
 <5f69d6ee-a07a-42a9-a238-7dbe1f82cc3f@mydatex.cz>
 <3e46d70b-196d-45c7-bfdf-869c78cdc81f@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="otfnytk53yd4iw6q"
Content-Disposition: inline
In-Reply-To: <3e46d70b-196d-45c7-bfdf-869c78cdc81f@leemhuis.info>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--otfnytk53yd4iw6q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 13.03.2024 10:16:47, Linux regression tracking (Thorsten Leemhuis) wrote:
> Hi! Mark and Manivannan, do you by chance have an idea what might be
> wrong with Daniel's system or can point us in the direction of people
> that might be able to help? See
> https://lore.kernel.org/all/2ede8f49-41f8-4d9a-83e4-ea5d4d1677fe@mydatex.=
cz/
> for the initial report (but it is in the quote below, too).

At the first glance the mcp251x.c changes between v5.4 and v5.5 look
unrelated.

I try to find some time to setup bisecting on an imx6.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--otfnytk53yd4iw6q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmXxgVIACgkQKDiiPnot
vG+IeAf7Bhelumk2xhV4IKqc9flR1ST6KJhEvGywz0if2PM24w1u+zcZPwMbvs/0
cEMJDpt52QdZ9Dzv7tutW8A45vp7g4YyGNS1WfSURw0/Hr41avRaSWyDMLU67W9M
SNMI7tnGtE2AZ/rxWBiK+ZIx7PTLAnO9Oun5hbAKJCL17adIg3omBedMF2czvWQB
BqbrgqmOA8tv3GJ456VZHCgmrjAxN9d8JHrlzNfHAKTn0YdUDMsdXQfVwNKQFA7s
0K5PzTrgXkwBXJUOQsLDEJrlnD1REFrBVfhxbuE1XRVPOGsPWMOU9XWw1loWZrTb
khCWcTc1WnzX9GoqhTWZQLbqm59JJg==
=z8Cr
-----END PGP SIGNATURE-----

--otfnytk53yd4iw6q--

