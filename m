Return-Path: <linux-kernel+bounces-128743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B210895EE7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 23:46:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EDD01C241A7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C42015E80D;
	Tue,  2 Apr 2024 21:46:00 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C36115AAA7
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 21:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712094360; cv=none; b=THnXLf/k3el7mV4jYkicKRbzeEhiOapYV47hWnFq/y+kyJcQLvhZXga1mkS06AYb6/eLJdFRge2vlCfesSUuhZjYDuJP0eG/4H2DPsW6zD+Q87sY02GCF1ir16lu3RuF51F9Ie/Xb3NFNsd5ukJZaCj4HpPGoqhISV4W9Iw7r5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712094360; c=relaxed/simple;
	bh=ocxDqJuKRDai7rPDRIaTxB1XkMPaImpG6NfuIj5DBO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ro7wjNh37C/m3BQ3V2encEh7Wjt5W9cLfMaYUOexGAx72SEnn6OidxqUS/rmpO58Cpe0nH4LNZmAsbmKIweD2lMZb9gPMe6zSRLXfOwEOilHq3f/E5ptsfZgFELU9ezF2trB8YQBrRe2k8ux1rOsnLYfoojSl9GqvJMMDomjHDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mgr@pengutronix.de>)
	id 1rrlx1-00009Z-B1; Tue, 02 Apr 2024 23:45:51 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mgr@pengutronix.de>)
	id 1rrlx0-00A3Xa-3M; Tue, 02 Apr 2024 23:45:50 +0200
Received: from mgr by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mgr@pengutronix.de>)
	id 1rrlx0-00Aws9-04;
	Tue, 02 Apr 2024 23:45:50 +0200
Date: Tue, 2 Apr 2024 23:45:50 +0200
From: Michael Grzeschik <mgr@pengutronix.de>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] usb: dwc3: gadget: improve abbort transfer abort by
 adding more conditions
Message-ID: <Zgx8jh_Tz_dgmI1v@pengutronix.de>
References: <20240307-dwc3-gadget-complete-irq-v1-0-4fe9ac0ba2b7@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tWQpvqhZ3A9Ayrjv"
Content-Disposition: inline
In-Reply-To: <20240307-dwc3-gadget-complete-irq-v1-0-4fe9ac0ba2b7@pengutronix.de>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mgr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--tWQpvqhZ3A9Ayrjv
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 07, 2024 at 04:22:02PM +0100, Michael Grzeschik wrote:
>The dwc3 gadget driver is correctly checking the prepare and started
>request lists for potential underruns and will stop the running transfer
>in that case. However it is possible that the running pipeline will lead
>into more underrun scenarios, which can be avoided and be detected. This
>series is adding the corresponding code to ensure that an underrun
>transfer will be handled properly.
>
>Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
>---
>Michael Grzeschik (3):
>      usb: dwc3: gadget: reclaim the whole started list when request was m=
issed
>      usb: dwc3: gadget: check drained isoc ep
>      usb: dwc3: gadget: check the whole started queue for missed requests=
 in complete
>
> drivers/usb/dwc3/gadget.c | 38 ++++++++++++++++++++++++++++++++++++--
> 1 file changed, 36 insertions(+), 2 deletions(-)
>---
>base-commit: dfea18989aa7beb42c2cb6344fe8787de35d9471
>change-id: 20240307-dwc3-gadget-complete-irq-1a8ffa347fd1
>
>Best regards,

Since it is not right to fully stop the ep after one missed transfer was
detected, this series is not correct anymore. We solve the overall issue
in the upper layer now.

Besides the patch "usb: dwc3: gadget: check drained isoc ep" is not
completely wrong, I will resend that one in another veriant.

mgr

--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--tWQpvqhZ3A9Ayrjv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEElXvEUs6VPX6mDPT8C+njFXoeLGQFAmYMfIsACgkQC+njFXoe
LGTZFhAAv0rquu74k9lZ78qiepcQVo6Qoq8z3Awh2HIvs28vVvJ5GlRD19yeoWnF
FupjFur3kFfw+xAa1CU3zNJtDnlKiW+t9klJ/MipLhRPR9GpAjkCVXVriJGNEfpS
Y7hhB7iOZjr0nGJ/b/Wld4OZroDCjFPoF3BGxm/tISucusCuoswjLwewJF3tmAGf
q8yeOq6MQKHbbPpFQlNFEMibMWMqacgjWsKdC8ngrwcfUgF87pbxqdunF6TXwwYf
Xu+2iZUn87SiwlueUf21RjXMC498rh3hZ1qzbvDpNwjCRJIyypIK60YubHOasSsF
+uFkleYZpfJCZbENlsDBvvYpP6LqP47oFIjBsWDHYGTNuJVA+78iV26mw/Ayjdor
gY5QW79O8wnP0IjbYEuQE5w7KeMP09clWEM2s2k/hj17c3eIoqvp882iaCVXJBne
CRjNVy/WPIh4TV4jHY1vc4dk1ezX+2hJlaQtwHvoiiwMGiRv3vFSEga29ITywqpX
4zexzC05NR70ARWHrddKF32BhYgLIHuiksPUeWpnmRq3UCEfp1yFm2ka9D3HCUAL
fYpnebv/npQ0rWPmV+0r4QPPypPzSXBOLsyObeEj/AM83eonUNy+zY9YvWpIft+z
yjSNKZfc8gUSjhIQ/vsVEIKIXxY0UVVCYEB1bS/JeaGLk2IAmzc=
=P9jq
-----END PGP SIGNATURE-----

--tWQpvqhZ3A9Ayrjv--

