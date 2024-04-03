Return-Path: <linux-kernel+bounces-129265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6786A8967F3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22D0D28CD9C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 08:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361E473510;
	Wed,  3 Apr 2024 08:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nmYdqFEB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740EA5FB85;
	Wed,  3 Apr 2024 08:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712131616; cv=none; b=HMSgZ5FxpOyIjTt0uGsN/KARILAu9+CBCklveBiH3fNE3Eqib1cxWDZ8qHlZs5WRmX4uBE82weNklX10dP2SZ2quHGPMsrexLCustnewHMLnD8DN04ABMYoj4g/LKIS7q3xWjyBupVeBvEl4m0NwqVb2ZMZq5IseYsVztAV9yUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712131616; c=relaxed/simple;
	bh=D1fnKXGmnMmng2XJnWn0RD1OcALCWsnaPJw6jX/2oJk=;
	h=Content-Type:Date:Message-Id:Cc:From:To:Subject:References:
	 In-Reply-To; b=MXwQcbred8r/zC+5pYK2RkHrq05tUbrkoug8Nll+Cv52+vUBqQ1f4oRpOzSEfv5wF/YPV6jBmm4h3Y47ExqQhjJGRNfKzIepqeZ/3zA9u9ek4dAHP9/dEOVXafOxl+AolUsbdzbSwdnJZi0Z9bcn1+aboEuNr5YMvm3XZXub+Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nmYdqFEB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A036C433F1;
	Wed,  3 Apr 2024 08:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712131615;
	bh=D1fnKXGmnMmng2XJnWn0RD1OcALCWsnaPJw6jX/2oJk=;
	h=Date:Cc:From:To:Subject:References:In-Reply-To:From;
	b=nmYdqFEB6hMbmmMq1HTnQD9AKOwTHn4LdeG9WSL5+bA6ISFiyoReQ48mynf1bfrtm
	 2cxWDzfq6Kwpw8GDirG4YQfjKe9KXPN3fenEZdrTPLR0RX8tnu5I2qCpjZp0rqR9qA
	 l1NmFCpNYaJo426dTMZF+vqvRLeLqUhe2717vOit18YdAHTHdpTU4O56dacq4W8Cz+
	 w1AAimDEt1D/jUbc/YXGSz3OCtM8fU7dyfmtiff26M6BgOrILchaYd5HgbVe2vj1Zx
	 2levQjXnuaDyq7+IL74gDHVRHz1fcFJ7E5HY3oHaaTTOkV/Qw9kb7b/ijgKPY4d9vz
	 IX/6EqidI7a+w==
Content-Type: multipart/signed;
 boundary=4bd2cb084b6d1bc3a4d2b6f2223a5fc8229f83965193b4e69adc10d305a3;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Wed, 03 Apr 2024 10:06:51 +0200
Message-Id: <D0AC0465UQUJ.26171T9KETMCW@kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
 <netdev@vger.kernel.org>
From: "Michael Walle" <mwalle@kernel.org>
To: "Christophe JAILLET" <christophe.jaillet@wanadoo.fr>, "Vladimir Oltean"
 <olteanv@gmail.com>, "Andrew Lunn" <andrew@lunn.ch>, "Florian Fainelli"
 <f.fainelli@gmail.com>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
Subject: Re: [PATCH net] net: dsa: sja1105: Fix parameters order in
 sja1110_pcs_mdio_write_c45()
X-Mailer: aerc 0.16.0
References: <ff2a5af67361988b3581831f7bd1eddebfb4c48f.1712082763.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <ff2a5af67361988b3581831f7bd1eddebfb4c48f.1712082763.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

--4bd2cb084b6d1bc3a4d2b6f2223a5fc8229f83965193b4e69adc10d305a3
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Tue Apr 2, 2024 at 8:33 PM CEST, Christophe JAILLET wrote:
> The definition and declaration of sja1110_pcs_mdio_write_c45() don't have
> parameters in the same order.
>
> Knowing that sja1110_pcs_mdio_write_c45() is used as a function pointer
> in 'sja1105_info' structure with .pcs_mdio_write_c45, and that we have:
>
>    int (*pcs_mdio_write_c45)(struct mii_bus *bus, int phy, int mmd,
> 				  int reg, u16 val);
>
> it is likely that the definition is the one to change.

See also "struct mii_bus":

	/** @write_c45: Perform a C45 write transfer on the bus */
	int (*write_c45)(struct mii_bus *bus, int addr, int devnum,
			 int regnum, u16 val);

>
> Found with cppcheck, funcArgOrderDifferent.
>
> Fixes: ae271547bba6 ("net: dsa: sja1105: C45 only transactions for PCS")

> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Compile tested only.
> ---
>  drivers/net/dsa/sja1105/sja1105_mdio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/dsa/sja1105/sja1105_mdio.c b/drivers/net/dsa/sja=
1105/sja1105_mdio.c
> index 833e55e4b961..52ddb4ef259e 100644
> --- a/drivers/net/dsa/sja1105/sja1105_mdio.c
> +++ b/drivers/net/dsa/sja1105/sja1105_mdio.c
> @@ -94,7 +94,7 @@ int sja1110_pcs_mdio_read_c45(struct mii_bus *bus, int =
phy, int mmd, int reg)
>  	return tmp & 0xffff;
>  }
> =20
> -int sja1110_pcs_mdio_write_c45(struct mii_bus *bus, int phy, int reg, in=
t mmd,
> +int sja1110_pcs_mdio_write_c45(struct mii_bus *bus, int phy, int mmd, in=
t reg,
>  			       u16 val)

Reviewed-by: Michael Walle <mwalle@kernel.org>

Vladimir, do you happen to know if some of your boards will use this
function? Just wondering because it was never noticed.

-michael

>  {
>  	struct sja1105_mdio_private *mdio_priv =3D bus->priv;


--4bd2cb084b6d1bc3a4d2b6f2223a5fc8229f83965193b4e69adc10d305a3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCZg0OHBIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/hg0wF/RTzwJEa5sk8GegngsX3YXJNsapFGBssA
1yi4ssEWgnZ6MhuJioHlBvvAGMyORvVSAYDbILAPiVw0FfyfNp47+kanvUqhvG78
pxSroqUKdQMTmg56f1PDbdoUyTwYihmBgHw=
=ICMO
-----END PGP SIGNATURE-----

--4bd2cb084b6d1bc3a4d2b6f2223a5fc8229f83965193b4e69adc10d305a3--

