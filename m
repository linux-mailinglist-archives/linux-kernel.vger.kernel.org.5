Return-Path: <linux-kernel+bounces-14288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB99821AE8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 12:28:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E55D283196
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 11:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4193EAC0;
	Tue,  2 Jan 2024 11:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="Ma1AcYdF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B39DF6A;
	Tue,  2 Jan 2024 11:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1704194540;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IKJCpy+cXuzjprgjg+Of6HIRqe2chRqAQCoAEdEUmLc=;
	b=Ma1AcYdF6RGml4NMC2wYnGW8Vy7bjxkIzK37EUrf2SOtuanqn/FetHnrbA82SaaooQe92G
	Mhnjmwbsq85AfOHyz7iQ0XHuHmEeytkzWWUp4MladgBss0XUVBDLqt6+JL42CIWfs/dW8/
	/64eblXjavruLl8t+a/CvRTjviKw6ao=
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org,
 kernel-janitors@vger.kernel.org, Antonio Quartulli <a@unstable.cc>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Marek Lindner <mareklindner@neomailbox.ch>,
 Paolo Abeni <pabeni@redhat.com>, Simon Wunderlich <sw@simonwunderlich.de>,
 Markus Elfring <Markus.Elfring@web.de>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject:
 Re: [PATCH 1/2] batman-adv: Return directly after a failed
 batadv_dat_select_candidates() in batadv_dat_forward_data()
Date: Tue, 02 Jan 2024 12:22:16 +0100
Message-ID: <12355496.O9o76ZdvQC@sven-l14>
In-Reply-To: <54dc53f8-5f08-4f1d-938a-c845c8ec0d44@web.de>
References:
 <8588cafe-3c61-40a6-b071-0877632a2a1e@web.de>
 <54dc53f8-5f08-4f1d-938a-c845c8ec0d44@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5744289.DvuYhMxLoT";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart5744289.DvuYhMxLoT
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Date: Tue, 02 Jan 2024 12:22:16 +0100
Message-ID: <12355496.O9o76ZdvQC@sven-l14>
In-Reply-To: <54dc53f8-5f08-4f1d-938a-c845c8ec0d44@web.de>
MIME-Version: 1.0

On Tuesday, 2 January 2024 08:11:47 CET Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Tue, 2 Jan 2024 07:27:45 +0100
>=20
> The kfree() function was called in one case by
> the batadv_dat_forward_data() function during error handling
> even if the passed variable contained a null pointer.
> This issue was detected by using the Coccinelle software.
>=20
> * Thus return directly after a batadv_dat_select_candidates() call failed
>   at the beginning.
>=20
> * Delete the label =E2=80=9Cout=E2=80=9D which became unnecessary with th=
is refactoring.
>=20
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Acked-by: Sven Eckelmann <sven@narfation.org>

> ---
>  net/batman-adv/distributed-arp-table.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/dist=
ributed-arp-table.c
> index 28a939d56090..4c7e85534324 100644
> --- a/net/batman-adv/distributed-arp-table.c
> +++ b/net/batman-adv/distributed-arp-table.c
> @@ -684,7 +684,7 @@ static bool batadv_dat_forward_data(struct batadv_pri=
v *bat_priv,
>=20
>  	cand =3D batadv_dat_select_candidates(bat_priv, ip, vid);
>  	if (!cand)
> -		goto out;
> +		return ret;
>=20
>  	batadv_dbg(BATADV_DBG_DAT, bat_priv, "DHT_SEND for %pI4\n", &ip);
>=20
> @@ -728,7 +728,6 @@ static bool batadv_dat_forward_data(struct batadv_pri=
v *bat_priv,
>  		batadv_orig_node_put(cand[i].orig_node);
>  	}
>=20
> -out:
>  	kfree(cand);
>  	return ret;
>  }
> --
> 2.43.0
>=20
>=20


--nextPart5744289.DvuYhMxLoT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmWT8ekACgkQXYcKB8Em
e0Zezg/+P9PfejkVp+OoIyYjl/JOvoFqwplYaSBqhuTzvIVSx8fGZmzS0eBHploL
kIPHLR9UoxD4ghhd0JX1Vu/e2bWMQUFJGmzX92xFcXxMrx/FJ3DfMRM9rPSkd/FX
Z4QFQp5BkQuqWk1tICiOSP+GeGtiXY9UZnrYFEKmJG601RaziFMGXC8va/zmaBBD
7+YTYyJwPxO5jF+KLIEMJjCT1b4+o9fneoGdwpoyvk0JyC9FbYbiOPeeB+37PczD
X1YGGNnAmF8cPFU89J/8XXplraK8HAOaivzAsTDPnBOu4SP/spQKWefX/LgqkFWx
5c0l02CzZapL6szJEk1ZbqTfXrRbDjnqFxxIV7HBbtnx6hkSbPvNcubB+B1k56AA
l+2EY9gPnIUe/a5C11LUYc4zfNF5Z+k8ZgtrRiTiR+CstKtjBdiGytyRN4Lj/7ax
YmhnVkAKY/Dr79Frc76jP+sGNnCzHna9AhHUyHBtHRdr6/vx8ggEPtylrxjsVll0
VCZuKAM23pJ8fKdEiexVon9pX5UXq+nqIBc/iZvU0+i/QE8GK/DAd1lWVoDpFDvA
25O42/MbEUefcd4VHksZdNLOqxKwyFJunUZmS5piyt7VO2RhRUQQVCeWDvETpZ+/
oyV9q09FlZRIYbRioLqmv2jNV7WoUSw3DWOrh7GUe1vsWzYhzmM=
=QSP4
-----END PGP SIGNATURE-----

--nextPart5744289.DvuYhMxLoT--




