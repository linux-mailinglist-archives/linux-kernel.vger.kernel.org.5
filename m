Return-Path: <linux-kernel+bounces-103166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8048087BBD3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 12:20:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 206771F235A6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 11:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB1846EB5F;
	Thu, 14 Mar 2024 11:20:24 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4F96E610
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 11:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710415224; cv=none; b=jrbQNVbp2ka2m0bOuR55vrJuUHeqsKBe3R9k0+mnqDQcfHZcaLjmG9UYiOtP/nwDPfqC36stuvNj5CTtI/UM4U+fs46O2V3XEJdAEJPTKMPYf3+tr3sOn5a9Q6+pi4CAIohOc/VcvAYqixFetNmiuX4rRrNPN9o1MyJ0cymn6Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710415224; c=relaxed/simple;
	bh=l2HLYYn4UeEUpgV+L5wQ37S45Vthf/ftyRXt+AAR1fA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bTS33x7NGdQ7eQ808XQXYfJk7AFl0iQE9EVJyx3MPYXAw/hYBQ5p5TkILbAFyBKbeiDI4ml5lNAQP9Od6le1mi7Ci8h0CowQehni3HiPmTz8l7gyzlbYtF+x3UrQV1Th9PbtrLD/Y11/3gCV5Zi5B0HUcyIQCo8WY5f+5+e7etI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1rkj89-0004J1-22; Thu, 14 Mar 2024 12:20:13 +0100
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1rkj87-006Ihj-Ay; Thu, 14 Mar 2024 12:20:11 +0100
Received: from pengutronix.de (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id EE8582A50C4;
	Thu, 14 Mar 2024 11:20:10 +0000 (UTC)
Date: Thu, 14 Mar 2024 12:20:10 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Francesco Valla <valla.francesco@gmail.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, fabio@redaril.me, 
	linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] Documentation: networking: document CAN ISO-TP
Message-ID: <20240314-nurture-apricot-d4707bc77a00-mkl@pengutronix.de>
References: <20240313223445.87170-1-valla.francesco@gmail.com>
 <20240313223445.87170-2-valla.francesco@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="23lpoqgne2axyrjj"
Content-Disposition: inline
In-Reply-To: <20240313223445.87170-2-valla.francesco@gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--23lpoqgne2axyrjj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Francesco,

thanks for your contribution! I've some remarks to make it a valid rst
file.

On 13.03.2024 23:34:31, Francesco Valla wrote:
> Document basic concepts, APIs and behaviour of the CAN ISO-TP (ISO
> 15765-2) stack.
>=20
> Signed-off-by: Francesco Valla <valla.francesco@gmail.com>
> ---
>  Documentation/networking/index.rst |   1 +
>  Documentation/networking/isotp.rst | 347 +++++++++++++++++++++++++++++
>  2 files changed, 348 insertions(+)
>  create mode 100644 Documentation/networking/isotp.rst
>=20
> diff --git a/Documentation/networking/index.rst b/Documentation/networkin=
g/index.rst
> index 473d72c36d61..ba22acfae389 100644
> --- a/Documentation/networking/index.rst
> +++ b/Documentation/networking/index.rst
> @@ -19,6 +19,7 @@ Contents:
>     caif/index
>     ethtool-netlink
>     ieee802154
> +   isotp
>     j1939
>     kapi
>     msg_zerocopy
> diff --git a/Documentation/networking/isotp.rst b/Documentation/networkin=
g/isotp.rst
> new file mode 100644
> index 000000000000..d0c49fd1f5c9
> --- /dev/null
> +++ b/Documentation/networking/isotp.rst
> @@ -0,0 +1,347 @@
> +.. SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +ISO-TP (ISO 15765-2) Transport Protocol
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Please make the "=3D" as long as the text it encloses.

> +
> +Overview
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D

Same here

[...]

> +Reception stmin
> +~~~~~~~~~~~~~~~
> +
> +The reception minimum separaton time (stmin) can be forced using the
> +``CAN_ISOTP_RX_STMIN`` optname and providing an stmin value in microseco=
nds as
> +a 32bit unsigned integer; received Consecutive Frames (CF) which timesta=
mps
> +differ less than this value will be ignored:
> +
> +.. code-block:: C
> +
> +    uint32_t stmin;
> +    ret =3D setsockopt(s, SOL_CAN_ISOTP, CAN_ISOTP_RX_STMIN, &stmin, siz=
eof(stmin));
> +
> +Multi-frame transport support
> +--------------------------

same here

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--23lpoqgne2axyrjj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmXy3WcACgkQKDiiPnot
vG8lzQgAjaKShUuD1SFxYlmma7i0p2rGshpvscLbncWKuBmBQN65xPJAYZ7JOFzC
szKLUoekrIZmvAu519OYEq9uEqAwPg2SLtgjferHxwSLs3h+ovhyvlrXkYVDXuor
vwXpM362eJOIGf8b/LkqkMtrTPmwvZ2QLewJbyf8MUVpCYlYjfkrywZS701hvdok
RetPkO0jKVV5x9+5KJ4F3APspGgZ/rXikZhV2XBMxTshg0OeS1o/+iiZIF1YspYB
xCgS1UmVtx/8nrJeAIwWd3DFOffbccWDM87hj4+egf2uIuBFe/91CxGsGavgpzBB
+qKs9Fw+bAslSu+U0wZ7a/QQUpEUmA==
=K/bN
-----END PGP SIGNATURE-----

--23lpoqgne2axyrjj--

