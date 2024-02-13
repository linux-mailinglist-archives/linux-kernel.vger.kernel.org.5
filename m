Return-Path: <linux-kernel+bounces-63351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 042B5852E05
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3F7A282752
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D66E249EA;
	Tue, 13 Feb 2024 10:36:32 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCD822EF5
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 10:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707820591; cv=none; b=PezYaczgqB0ihPbHxf3aYCLlQ6tSmuAwBrhRn6lPhCX5CTF7vvDoInppZKhqs8cveTfszEM9aZSEksmhJP5k6pTzVkvsUJylkO/qDctUpecw12w8NfrmlnF7Tsq7suUeBD1g/WOcox/CWoKakBBczTKQPYdLINKqLpodEloAsLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707820591; c=relaxed/simple;
	bh=66xjE2U2Ql8VIvoyivzz6wUUIufchSLiDAfQJgxs6kY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hH8OnTFOZRCk+JzmNyVF5rdOQgpUdVZZZNOvtn2PVvnxkeO6nYKSuXEDhTlNyKm8irNw5Eq90gm8tkTRfHppAWQnOc60ZZ4mN1WFkUS1LxnoySVPYr7WX9GQYNJ+18sCNipTJHs6dTnq/RHsHZvooJMqYUT2zuKtXtORlY90H/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1rZq8w-00037Y-VR; Tue, 13 Feb 2024 11:36:02 +0100
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1rZq8u-000SmI-Uv; Tue, 13 Feb 2024 11:36:00 +0100
Received: from pengutronix.de (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id EEF8528D3D6;
	Tue, 13 Feb 2024 10:22:49 +0000 (UTC)
Date: Tue, 13 Feb 2024 11:22:49 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Srinivas Goud <srinivas.goud@amd.com>
Cc: wg@grandegger.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, p.zabel@pengutronix.de, git@amd.com, 
	michal.simek@xilinx.com, linux-can@vger.kernel.org, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v7 0/3] can: xilinx_can: Add ECC feature support
Message-ID: <20240213-evasion-crevice-3faa375c1666-mkl@pengutronix.de>
References: <1705059453-29099-1-git-send-email-srinivas.goud@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gdjgd3yxfo6av4wq"
Content-Disposition: inline
In-Reply-To: <1705059453-29099-1-git-send-email-srinivas.goud@amd.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--gdjgd3yxfo6av4wq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 12.01.2024 17:07:30, Srinivas Goud wrote:
> Add ECC feature support to Tx and Rx FIFOs for Xilinx CAN Controller.
> ECC is an IP configuration option where counter registers are added in
> IP for 1bit/2bit ECC errors count and reset.
> Also driver reports 1bit/2bit ECC errors for FIFOs based on ECC error
> interrupts.
>=20
> Add xlnx,has-ecc optional property for Xilinx AXI CAN controller
> to support ECC if the ECC block is enabled in the HW.
>=20
> Add ethtool stats interface for getting all the ECC errors information.
>=20
> There is no public documentation for it available.

Lately I was using ethtool based stats, too and figured out, there's no
need for a spinlock, you can use a struct u64_stats_sync,
u64_stats_update_begin(), u64_stats_update_end(), and
u64_stats_fetch_retry() instead. These are no-ops on 64 bit systems and
sequential locks on 32 bit systems.

I'll send a v8.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--gdjgd3yxfo6av4wq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmXLQvYACgkQKDiiPnot
vG+qHQf/UZHyFLWV/VOz8X/KqbOqWwP/m96D8DaOwwA04EDyPmCvISlHmrj5hF5O
wDxmUFZ61KUxSOXG6MByDeRexI4FhZ3qcPH9PTgvMEBJy2PbgKfPS3g3JyBhHwgD
KNebyOcqEavo5NqiWU9pXQ6K8psAzKARfI4pwxuIrw2CZgmsDAQMdb3G5SkWTrcw
8eOR/dBSj+woJZc0OLe1dAbOt1lwZbC0AqhIGDPjjFnKxtyr0gQzr8JM+dR/0FQj
Xya5oBr1gMfcSfbmXc+bLrIAkry0xFsZjvoUuZT423Usd/N80Qd8RGpgH5E5g8s2
2o49spZNWnZ4AeBf/pkoU6TA8Wldew==
=kgLF
-----END PGP SIGNATURE-----

--gdjgd3yxfo6av4wq--

