Return-Path: <linux-kernel+bounces-67692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF41856F36
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 22:22:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ACD41C21CB6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 21:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E16C13B7A2;
	Thu, 15 Feb 2024 21:22:16 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6CF12BF18
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 21:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708032136; cv=none; b=T/t2QPUuTbyYBv0eZVewSPzv0hocEdirkJbvKsr3hVOZlvpGQiGFyBK2pN4cPgXwI5VGjFWncNRwGvik9DgnSq0zcgvOiar4rHoc4lhIXYCVtWg++wNmbcj+07BXNYf3RactAF7kGQVsOsheKDYHYrmeq2fAZFmlAw/WvGr4L3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708032136; c=relaxed/simple;
	bh=DuC8hK9zbh/D/juV5SyJxhS/3z8OmGIgV44+aU22X9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WWgCl80r8V+U3rTUzCO4sCtp/TiSUaFDZo3WcNEHeL+Rj2DRqEy+/eiLua2KKbaizbmYB2le102qMdi76VBrIIPanToBz5SrBQ2k3D2Lv/zUQeZ4CGZKH95sZjdZjc7rhichQbJCfCXomFJlh0d0Nym3X64sDNFbFxMLPSt5s10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rajBK-0001dW-Sg; Thu, 15 Feb 2024 22:22:10 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rajBK-000xKR-0a; Thu, 15 Feb 2024 22:22:10 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rajBJ-005f1n-30;
	Thu, 15 Feb 2024 22:22:09 +0100
Date: Thu, 15 Feb 2024 22:22:09 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH 0/2] parport: Convert to platform remove callback
 returning void
Message-ID: <cf6vlgvbbtsofdladgeqenrf5bqpn2p3vhzu2llwuu4ee5tk6i@w4h6jjexeulj>
References: <cover.1702933181.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bjmimwzmmenef5ak"
Content-Disposition: inline
In-Reply-To: <cover.1702933181.git.u.kleine-koenig@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--bjmimwzmmenef5ak
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

[Cc +=3D gregkh]

On Mon, Dec 18, 2023 at 10:05:17PM +0100, Uwe Kleine-K=F6nig wrote:
> this series converts all drivers below drivers/parport to use
> .remove_new(). See commit 5c5a7680e67b ("platform: Provide a remove
> callback that returns no value") for an extended explanation and the
> eventual goal. The TL;DR; is to make it harder for driver authors to
> leak resources without noticing.
>=20
> This is merge window material. The two patches are independent of each
> other, so they could be applied individually.
>=20
> Best regards
> Uwe
>=20
> Uwe Kleine-K=F6nig (2):
>   parport: amiga: Convert to platform remove callback returning void
>   parport: sunbpp: Convert to platform remove callback returning void

I got no feedback for these patches since they were sent two months ago
:-\=20

Looking at the last patches to drivers/parport, they were merged by
Greg. Given the patches weren't sent to him, should I resend?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--bjmimwzmmenef5ak
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmXOgIAACgkQj4D7WH0S
/k7FoAf+Jml/2b/W7XAQV+I8UaEIg9uH0wnKpnVcPPGjkb097/ROLAe4MLItkTTJ
nvBZTkr3RfW3u3Eti2QY4qSl7nGxj/uktL/j1IVBYrjmBh6lZ25b1MLYDGgXE3l9
JfNRu/2agPFacn6GlGG7ty0E65b5CKftr4aMd7G20gtn/DTGj+Y7O1t44Pf2z/h4
0YIAelxKpaSrh+TzvtSwKjE1dc5kDnmguDjRudAhwjyWw1NNnq8HUKc9JojDNLx7
2uxVuIoPcRz65sf0JTNQvH1d1rXA6pu5q57R83U/XRF/DMCFo7+ieGDlDIlCEMSd
IuJ8GP30GOQvhSvXLIbXptHLJRkFLA==
=3b3C
-----END PGP SIGNATURE-----

--bjmimwzmmenef5ak--

