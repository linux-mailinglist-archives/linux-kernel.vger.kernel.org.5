Return-Path: <linux-kernel+bounces-68632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2FF857D8A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 206951F24D61
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 13:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38423129A99;
	Fri, 16 Feb 2024 13:20:25 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4433E1E4A0
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 13:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708089624; cv=none; b=K3LOyXN2aGwW/pVG60SL0BlsN9udLiQQMaiIbz7HRIHpHCF/fRl746zXT9xwEtbEWnpYdQNkjGOkqklOUzvHovMUS/39t4TWWdsv9rYGP5d+Kcft5PWyVl6GVo9j6WhmM4KVBtoAb3qThHCtAUQk6j4/lUsf2Us3Urg/4Vk3rEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708089624; c=relaxed/simple;
	bh=LfHmheaX1gxHX3QcScZ7NgVdpG8pZqo68GDkffkktKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WS9kYBhUp8NflRBqehfxYAitclOCqZlHEMu9iwegsh92KAMcQ9bghU9rXFyyEYIAVwCea0q4Gxg/J/w2aNHXpLh9mnL+VjriyyeoXowmDj57Tv//jwVWFG3s6vKIGwqCA22+W+vwWkPOyoogJ2YRR4jnd4f5ApcwtyeK3GfaVWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1ray8H-0001hG-1V; Fri, 16 Feb 2024 14:20:01 +0100
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1ray8E-0015MK-Us; Fri, 16 Feb 2024 14:19:58 +0100
Received: from pengutronix.de (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 7DF97290405;
	Fri, 16 Feb 2024 13:19:58 +0000 (UTC)
Date: Fri, 16 Feb 2024 14:19:57 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: "Goud, Srinivas" <srinivas.goud@amd.com>
Cc: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>, 
	Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>, Wolfgang Grandegger <wg@grandegger.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, "Simek, Michal" <michal.simek@amd.com>, 
	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: RE: [PATCH v8 0/3] Add ECC feature support to Tx and Rx FIFOs
 for Xilinx CAN Controller.
Message-ID: <20240216-grapple-unwind-ee92af7b4b1d-mkl@pengutronix.de>
References: <20240213-xilinx_ecc-v8-0-8d75f8b80771@pengutronix.de>
 <PH8PR12MB6675AAAC5D7A86D2CAA382D6E14D2@PH8PR12MB6675.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vnqlg3uvjn2uzdnc"
Content-Disposition: inline
In-Reply-To: <PH8PR12MB6675AAAC5D7A86D2CAA382D6E14D2@PH8PR12MB6675.namprd12.prod.outlook.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--vnqlg3uvjn2uzdnc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 15.02.2024 13:59:33, Goud, Srinivas wrote:
> Thanks, tested with v8 changes, it is working fine.

Thanks for testing,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--vnqlg3uvjn2uzdnc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmXPYPsACgkQKDiiPnot
vG8xrggAlIv4YXPwzJA/DC6whBfwx82iIe0vk+luYLVA0uU0cbq4EdorElh0G0lr
HUY/IaeZ8f3tMbKUozl9YKOmhdZNEtRvmej8XV/vNUT++lc1J//tVmgXOBNl+6F0
SR1zS9a3xBQ0h7ouuLkfHLDcybxZK4ImEcBmj0s7oRnvTruZ5ZpfoxJZmv1toGb5
YFk1r7KCh7IzvW3D/u+/lgIYkEA3Gk5ie9D5s/TuhmGmeiEd5u+LmoIOg/F4zPY+
ISMoTWfEZniC6Y9QR3Rsb+XDvammBVCPglFX8Okz3fkLko8s8Cik/GbF17BLNMic
MqWJu8mCGml9zQDFbhWqb78FQFY+sQ==
=v4VS
-----END PGP SIGNATURE-----

--vnqlg3uvjn2uzdnc--

