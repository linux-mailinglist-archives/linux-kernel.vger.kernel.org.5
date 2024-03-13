Return-Path: <linux-kernel+bounces-101547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7577987A893
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 14:39:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC62C1F24873
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 13:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527BD41757;
	Wed, 13 Mar 2024 13:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="UGZkqgQj"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DB740BE1;
	Wed, 13 Mar 2024 13:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710337158; cv=none; b=VqcnjVk4QqPM1j4rCQ6XdLmNTvIcGfOmopIgnL97DxqU3U7NCUsfA+E/CcDTJh3+96rqk/yCjJtRF+SwrcPOX/iuIf1ipVz7UX89RERLW5B6jKlJWueJ7Zw2Qax436TJWsTtbl0wVv92rOpcv/z/YZYvx5Ov8AO7nEhryH1Vtbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710337158; c=relaxed/simple;
	bh=vK73uYI8Vxy7OroeXl4DurknrQfBeM/0gM/pIFpXnz0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U4GYLkZRquokEnCedUmaIKHDyvinkIR9k/Q4EyEmKly3dbDW9YPpUAx/mi50XvxeFaGsCx1dSNKBS6gtpxwPB7lwnaAmLMfvUFuX+ODzr0tOr0zmurMLwNz7J0af1RC2FiB1r5CNYm6/VS1QB4OFoC0a04cPzFJq1kv3DnbVOlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=UGZkqgQj; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 13F651BF203;
	Wed, 13 Mar 2024 13:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1710337147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=0Bicd0MobasMR69S0J0ZR+LESgqwadmjj5jzewTxOFc=;
	b=UGZkqgQjBuQWRDSbsBJcj9tSbHmSSMqrrXGdSrV1lJakRo5Nw8r0HtMpq9VOIlFDARoY5d
	dPuT/HoGEHXHC1tC6sRTUELctEwG0Od+JbwVkc3EdpaG0ol0SagF/UP3P8cbuPoN5lCyZ9
	P2YjyZDketjsISPfMJdH8Y6cDdnQyW4TvZgYVVADEVGawQqxRe1bRJPRBto54I2mmTEy+f
	f7WDHvLk5Uq2oh7mb+EJR33edrVrw0IZl+K0AiK7meN7l4x69/MDePS93fjCb7drmFy9ko
	LG2Bxjd//mzqO5+Htz9zggoDh+u+jSvWvqCutClznq5K1eNelgTVjoTJ/1tUKw==
Message-ID: <21ec269340a83f436bbf7a23a2be4289c88b70dd.camel@bootlin.com>
Subject: Re: [PATCH net v3] net: macb: remove change_mtu callback
From: Thomas Perrot <thomas.perrot@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>, Claudiu Beznea
 <claudiu.beznea@tuxon.dev>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org,  linux-kernel@vger.kernel.org
Date: Wed, 13 Mar 2024 14:39:05 +0100
In-Reply-To: <20240311161727.629c0bab@kernel.org>
References: <20240311154315.2575297-1-thomas.perrot@bootlin.com>
	 <20240311161727.629c0bab@kernel.org>
Autocrypt: addr=thomas.perrot@bootlin.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-ejHT/lGTQBdmCNEHSl5Q"
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GND-Sasl: thomas.perrot@bootlin.com


--=-ejHT/lGTQBdmCNEHSl5Q
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, 2024-03-11 at 16:17 -0700, Jakub Kicinski wrote:
> On Mon, 11 Mar 2024 16:43:15 +0100 thomas.perrot@bootlin.com=C2=A0wrote:
> > Because it doesn't allow MTU changes when the interface is up,
> > although
> > it is not necessary.
> >=20
> > This callback has been added to add in a first implementation of
> > the Jumbo
> > support [1],since it has been reworked and moved to the probe [2].
> >=20
> > With this patch the core will set the MTU, regardless of if the
> > interface
> > is up or not.
> >=20
> > [1] commit a5898ea09aad ("net: macb: Add change_mtu callback with
> > =C2=A0=C2=A0=C2=A0 jumbo support")
> > [2] commit 44770e1180de ("ethernet: use core min/max MTU checking")
> >=20
> > Fixes: 44770e1180de ("ethernet: use core min/max MTU checking")
>=20
> static void macb_init_rx_buffer_size(struct macb *bp, size_t size)
> {
> 	if (!macb_is_gem(bp)) {
> 		bp->rx_buffer_size =3D MACB_RX_BUFFER_SIZE;
> 	} else {
> 		bp->rx_buffer_size =3D size;
>=20
> where size is:
>=20
> 	size_t bufsz =3D dev->mtu + ETH_HLEN + ETH_FCS_LEN +
> NET_IP_ALIGN;
>=20
> I guess you tested this on a platform where !macb_is_gem(bp) ?

Thank you for your review, indeed that won=E2=80=99t be correct on GEM in w=
hen
the MTU used to initialize the RX buffer is lower than the new MTU.

So, I will suggest another patch with an acceptable solution.

Kind regards,
Thomas Perrot

> Otherwise the buffer size seems to be based on MTU and the proposed
> change won't be correct.

--=20
Thomas Perrot, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com


--=-ejHT/lGTQBdmCNEHSl5Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQGzBAABCAAdFiEEh0B3xqajCiMDqBIhn8ALBXH+Cu0FAmXxrHkACgkQn8ALBXH+
Cu0e2wv6A0yb8620vWwKOceSKAQ9PGXx6VVDpiEBk1S7Ga6L1FXgL6bYeXleE/t4
MhfEXjGpeQEjIgCc0UPtWs3il9LsWiGla6sAJAs9wNCcckQiOkHUFPJdA/jM5OM3
+03DqH3ybJ0prSZYKPmwiDp/I7UivzsIY/TtY8wLabeyV7kSZTVNWRrxUB0Eo2ST
zo156o/RINOH1uyo/M6v+3au3gpaag+mUUr9YTumTTMwusEo/sbVDaBnCrRIjz+r
xSKdSyKnbvLoHp5ImCCBtWXAV4boNVrbKImnX/U056YYqgcMe9Fi+Uik0F7HZWgV
m4ePL0F1X+eqcgET017IYuWhgMoZZe7hRSaRojJZiu4bLt/DGcaa/mAzyrA+Ry7r
u+veh3PNbG9StWGhcDJ91TlOkEtVemFwoEaGfLAYbyjOxdZnCbKLDRJtzFQ79vyt
VB3AKmtfvCNosRtOqOdYfCiJdK1tmzTJeUROYaphdJ7KvhRG4+qbpr0gEo9F2D9c
RYDgFzPj
=8JL7
-----END PGP SIGNATURE-----

--=-ejHT/lGTQBdmCNEHSl5Q--

