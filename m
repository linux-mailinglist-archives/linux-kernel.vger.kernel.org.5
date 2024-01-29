Return-Path: <linux-kernel+bounces-42348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 555BF840008
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 09:26:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB9081F24204
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 08:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3D253805;
	Mon, 29 Jan 2024 08:26:27 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51EA9537F8
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 08:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706516787; cv=none; b=PvYTYW/GahXVO789SwLiMbxl8SylraEh5FNL4GiHLW7CVvEx4PsHFaL3Vzifg0DaemnufEou94ZJQDkHaaEpnaiWi9aZyqQUNluss/7zpawXvns4yif/cZmucKf5ehzSalckS6xcvQ7DEewU+/VSlDhiFXfN0jtM1WRDEkVfMeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706516787; c=relaxed/simple;
	bh=n5mYzt6CIUKIXRBaJM3scUctqvjLnQUCO48pzYRK6PA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m7t6KF4lmD4z3WYijfqr8oSC0kzWwqeveVpYX/lq5n7FhBT28zEP9HAuW5Qi1XAlTTAfNpmKVVdAsb6MTrWruXbtgRGJqaRpEb1xPYZ61GdivHo51WFwYX9GgYA5hofCbayOJXYzPw7GFXriYLPXzahSxEQIkiLxFxfYs5weIB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1rUMxz-00071K-Tv; Mon, 29 Jan 2024 09:26:07 +0100
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1rUMxx-0037so-TF; Mon, 29 Jan 2024 09:26:05 +0100
Received: from pengutronix.de (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 72691280715;
	Mon, 29 Jan 2024 08:26:05 +0000 (UTC)
Date: Mon, 29 Jan 2024 09:26:05 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: William Qiu <william.qiu@starfivetech.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-can@vger.kernel.org, 
	Emil Renner Berthing <kernel@esmil.dk>, Rob Herring <robh+dt@kernel.org>, 
	Wolfgang Grandegger <wg@grandegger.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: [PATCH v1 3/4] can: cast: add driver for CAST CAN controller
Message-ID: <20240129-zone-defame-c5580e596f72-mkl@pengutronix.de>
References: <20240129031239.17037-1-william.qiu@starfivetech.com>
 <20240129031239.17037-4-william.qiu@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zggniggrx7ssk34l"
Content-Disposition: inline
In-Reply-To: <20240129031239.17037-4-william.qiu@starfivetech.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--zggniggrx7ssk34l
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello William Qiu,

thank you for your contribution. I've some quick notes about your
driver.

On 29.01.2024 11:12:38, William Qiu wrote:
> Add driver for CAST CAN Controller. And add compatibility code which
> based on StarFive JH7110 SoC.

Please add yourself or someone else at starfivetech to the Maintainers
file.

Please use BIT() and/or GEN_MASK() to create the _MASK enums. Please use
FIELD_GET(), FIELD_PREP.

Please replace the ccan_ioread8() by a proper 32 bit read and use
FIELD_GET to access any non 32 bit value. Instead of ccan_iowrite8() use
FIELD_PREP and a proper 32 bit write.

The enum ccan_reg_bitchange looks very strange, why do you have OFF and
SET values?

The ccan_reigister_set_bit() and ccan_reigister_off_bit() functions
looks very strange, too. I suggest to use a 32 bit read, set, clear the
bits followed by a 32 bit write. Having set_bit() clear_bit() functions
may lead to more register accesses than needed, if not handled with care.

If you think the driver absolutely needs bit set/clear functions, please
follow the name and signature of the regmap_update_bits(),
regmap_set_bits() and regmap_clear_bits().

Please use can_put_echo_skb(), can_get_echo_skb().

Please implement proper TX-flow control. Stop the TX queue, if you HW
queue is full, start the TX queue once the HW queue has space again.

Consider using the rx_offload helper

You claim you IRQ handler works with shared interrupts, but you return
an error if there are no interrupts by your IP core.

Please enable the clocks during open() and disabled during close()

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--zggniggrx7ssk34l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmW3YRoACgkQvlAcSiqK
BOgKmgf8CP4DHYvozr25yPE/15GRtr4yDQDy5doYFxV8tAO2r1Y1iiU0mIz3aCLp
e3qWwbV9jcftKht75T5CgcurR8Ouc6P4O89HsGkpyRz0c4Pg4X/gswBJ29hTRFQw
JyaxQCaelQ5mbSAq0i2ZFCNiqBEzk6KyegUcmUabqOHmQTlpcXRYiJWRgKlKMoHr
xjkTF4HgTcViIXb/JislwP7q8C4F2/qEEtSLfqgOCzZjaPSRP6cTo8yy+YdITFhx
ntGdaMLEktRyMJVCcMfk5TXzea45E7yCa6cLL/4+VNzm/dsB1YF7Si9CC/nTXP9U
G5qmdcL6AIGzthY2poRxdC/oX7ppgw==
=HX7Y
-----END PGP SIGNATURE-----

--zggniggrx7ssk34l--

