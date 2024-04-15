Return-Path: <linux-kernel+bounces-144633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8BAF8A48A4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 09:04:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 754801F234E4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 07:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08FC622616;
	Mon, 15 Apr 2024 07:04:23 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54DF5208D4;
	Mon, 15 Apr 2024 07:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713164662; cv=none; b=MqdEr9yJyeYWumF4DOjbvLlhpd4n322YnWd0F3sMGfqSVEr6eEFugvHAxKybfLWc83wuzQHR06U2zotHnwBuqbprxHlc1RZG3v2hOETU8LG8sJO9VFKkCovrE9Az6UW4iajJXFLLmOz2d79bJ6IZLfpJAqHHZdpOPkT/7dPz1+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713164662; c=relaxed/simple;
	bh=rpDcJJsdf/Eq//NobJNfTfLV2gkVQLggG3kYjidJamE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vB3dy199rWIzZCRnfPGNt1ixx/cJVXeG4QoAhl2oRA/z9NIrcbfw2rDdHLbp1q1wMrJhqI1Oz11Pjxief1fAbGJ4JkUfJ7OfyZsGRcD88pDPNXVMa9f0TxdHiThVDvY8a05Lip7TTN5mAWsc21n4tM/Gs9Lphm0GqtIq5TD1f7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.07,202,1708354800"; 
   d="asc'?scan'208";a="205411633"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 15 Apr 2024 16:04:09 +0900
Received: from [10.226.93.74] (unknown [10.226.93.74])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 2713D4152EDB;
	Mon, 15 Apr 2024 16:04:05 +0900 (JST)
Message-ID: <e3e3c75f-9aee-40b6-b5b8-08260a8bac06@bp.renesas.com>
Date: Mon, 15 Apr 2024 08:04:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/4] net: ravb: Count packets instead of descriptors
 in R-Car RX path
Content-Language: en-GB
To: =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Cc: Sergey Shtylyov <s.shtylyov@omp.ru>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>, netdev@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240411114434.26186-1-paul.barker.ct@bp.renesas.com>
 <20240411114434.26186-2-paul.barker.ct@bp.renesas.com>
 <20240414120843.GA2860391@ragnatech.se>
From: Paul Barker <paul.barker.ct@bp.renesas.com>
Organization: Renesas Electronics Corporation
In-Reply-To: <20240414120843.GA2860391@ragnatech.se>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------N7OjoLjMXkYdnC3RzfR3Vku5"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------N7OjoLjMXkYdnC3RzfR3Vku5
Content-Type: multipart/mixed; boundary="------------5cJdu37HikjVed8jxrLfA18V";
 protected-headers="v1"
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Cc: Sergey Shtylyov <s.shtylyov@omp.ru>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>, netdev@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <e3e3c75f-9aee-40b6-b5b8-08260a8bac06@bp.renesas.com>
Subject: Re: [PATCH net 1/4] net: ravb: Count packets instead of descriptors
 in R-Car RX path
References: <20240411114434.26186-1-paul.barker.ct@bp.renesas.com>
 <20240411114434.26186-2-paul.barker.ct@bp.renesas.com>
 <20240414120843.GA2860391@ragnatech.se>
In-Reply-To: <20240414120843.GA2860391@ragnatech.se>

--------------5cJdu37HikjVed8jxrLfA18V
Content-Type: multipart/mixed; boundary="------------gmEemoc0LUPVlPiV0b6JebQ0"

--------------gmEemoc0LUPVlPiV0b6JebQ0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 14/04/2024 13:08, Niklas S=C3=B6derlund wrote:
> Hi Paul,
>=20
> Thanks for your patch.
>=20
> On 2024-04-11 12:44:30 +0100, Paul Barker wrote:
>> The units of "work done" in the RX path should be packets instead of
>> descriptors.
>>
>> Descriptors which are used by the hardware to record error conditions =
or
>> are empty in the case of a DMA mapping error should not count towards
>> our RX work budget.
>>
>> Fixes: c156633f1353 ("Renesas Ethernet AVB driver proper")
>> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
>> ---
>>  drivers/net/ethernet/renesas/ravb_main.c | 20 ++++++++------------
>>  1 file changed, 8 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/et=
hernet/renesas/ravb_main.c
>> index ba01c8cc3c90..70f2900648d4 100644
>> --- a/drivers/net/ethernet/renesas/ravb_main.c
>> +++ b/drivers/net/ethernet/renesas/ravb_main.c
>> @@ -892,29 +892,25 @@ static bool ravb_rx_rcar(struct net_device *ndev=
, int *quota, int q)
>>  	struct ravb_private *priv =3D netdev_priv(ndev);
>>  	const struct ravb_hw_info *info =3D priv->info;
>>  	int entry =3D priv->cur_rx[q] % priv->num_rx_ring[q];
>> -	int boguscnt =3D (priv->dirty_rx[q] + priv->num_rx_ring[q]) -
>> -			priv->cur_rx[q];
>>  	struct net_device_stats *stats =3D &priv->stats[q];
>>  	struct ravb_ex_rx_desc *desc;
>>  	struct sk_buff *skb;
>>  	dma_addr_t dma_addr;
>>  	struct timespec64 ts;
>> +	int rx_packets =3D 0;
>>  	u8  desc_status;
>>  	u16 pkt_len;
>>  	int limit;
>> +	int i;
>=20
> The loop variable can never be negative, use unsigned int.

I matched the type we're comparing against - should we also convert
limit to an unsigned int?

>=20
>> =20
>> -	boguscnt =3D min(boguscnt, *quota);
>> -	limit =3D boguscnt;
>> +	limit =3D priv->dirty_rx[q] + priv->num_rx_ring[q] - priv->cur_rx[q]=
;
>>  	desc =3D &priv->rx_ring[q].ex_desc[entry];
>> -	while (desc->die_dt !=3D DT_FEMPTY) {
>> +	for (i =3D 0; i < limit && rx_packets < *quota && desc->die_dt !=3D =
DT_FEMPTY; i++) {
>>  		/* Descriptor type must be checked before all other reads */
>>  		dma_rmb();
>>  		desc_status =3D desc->msc;
>>  		pkt_len =3D le16_to_cpu(desc->ds_cc) & RX_DS;
>> =20
>> -		if (--boguscnt < 0)
>> -			break;
>> -
>=20
> nit: It's a matter of taste, but I like this break condition in the cod=
e=20
> instead of modifying the loop as it's much clearer what's going on. But=
=20
> feel free to keep it as is as Sergey likes it.
>=20
>>  		/* We use 0-byte descriptors to mark the DMA mapping errors */
>>  		if (!pkt_len)
>>  			continue;
>> @@ -960,7 +956,7 @@ static bool ravb_rx_rcar(struct net_device *ndev, =
int *quota, int q)
>>  			if (ndev->features & NETIF_F_RXCSUM)
>>  				ravb_rx_csum(skb);
>>  			napi_gro_receive(&priv->napi[q], skb);
>> -			stats->rx_packets++;
>> +			rx_packets++;
>=20
> Why do you add this intermediary variable? Is it not confusing to treat=
=20
> rx_packets and rx_bytes differently? Why not instead decrement *quota=20
> here?

To me, it's simpler to count received packets once instead of twice
inside the loop (once by incrementing stats->rx_packets, a second time
by decrementing *quota). This also makes future refactoring simpler as
we already have the rx_packets count which we will need to be able to
return so that we can properly track work done in ravb_poll().

Thanks,

--=20
Paul Barker
--------------gmEemoc0LUPVlPiV0b6JebQ0
Content-Type: application/pgp-keys; name="OpenPGP_0x27F4B3459F002257.asc"
Content-Disposition: attachment; filename="OpenPGP_0x27F4B3459F002257.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

xsFNBGS4BNsBEADEc28TO+aryCgRIuhxWAviuJl+f2TcZ1JeeaMzRLgSXKuXzkiI
g6JIVfNvThjwJaBmb7+/5+D7kDLJuutu9MFfOzTS0QOQWppwIPgbfktvMvwwsq3m
7e9Qb+S1LVeV0/ldZfuzgzAzHFDwmzryfIyt2JEbsBsGTq/QE+7hvLAe8R9xofIn
z6/IndiiTYhNCNf06nFPR4Y5ZDZPGb9aw5Jisqh+OSxtc0BFHDSV8/35yWM/JLQ1
Ja8AOHw1kP9KO+iE9rHMt0+7lH3mN1GBabxH26EdgFfPShsi14qmziLOuUlGLuwO
ApIYqvdtCs+zlMA8PsiJIMuxizZ6qCLur3r2b+/YXoJjuFDcax9M+Pr0D7rZX0Hk
6PW3dtvDQHfspwLY0FIlXbbtCfCqGLe47VaS7lvG0XeMlo3dUEsf707Q2h0+G1tm
wyeuWSPEzZQq/KI7JIFlxr3N/3VCdGa9qVf/40QF0BXPfJdcwTEzmPlYetRgA11W
bglw8DxWBv24a2gWeUkwBWFScR3QV4FAwVjmlCqrkw9dy/JtrFf4pwDoqSFUcofB
95u6qlz/PC+ho9uvUo5uIwJyz3J5BIgfkMAPYcHNZZ5QrpI3mdwf66im1TOKKTuf
3Sz/GKc14qAIQhxuUWrgAKTexBJYJmzDT0Mj4ISjlr9K6VXrQwTuj2zC4QARAQAB
zStQYXVsIEJhcmtlciA8cGF1bC5iYXJrZXIuY3RAYnAucmVuZXNhcy5jb20+wsGU
BBMBCgA+FiEE9KKf333+FIzPGaxOJ/SzRZ8AIlcFAmS4BNsCGwEFCQPCZwAFCwkI
BwIGFQoJCAsCBBYCAwECHgECF4AACgkQJ/SzRZ8AIlfxaQ/8CM36qjfad7eBfwja
cI1LlH1NwbSJ239rE0X7hU/5yra72egr3T5AUuYTt9ECNQ8Ld03BYhbC6hPki5rb
OlFM2hEPUQYeohcJ4Na5iIFpTxoIuC49Hp2ce6ikvt9Hc4O2FAntabg+9hE8WA4f
QWW+Qo5ve5OJ0sGylzu0mRZ2I3mTaDsxuDkXOICF5ggSdjT+rcd/pRVOugImjpZv
/jzSgUfKV2wcZ8vVK0616K21tyPiRjYtDQjJAKff8gBY6ZvP5REPl+fYNvZm1y4l
hsVupGHL3aV+BKooMsKRZIMTiKJCIy6YFKHOcgWFG62cuRrFDf4r54MJuUGzyeoF
1XNFzbe1ySoRfU/HrEuBNqC+1CEBiduumh89BitfDNh6ecWVLw24fjsF1Ke6vYpU
lK9/yGLV26lXYEN4uEJ9i6PjgJ+Q8fubizCVXVDPxmWSZIoJg8EspZ+Max03Lk3e
flWQ0E3l6/VHmsFgkvqhjNlzFRrj/k86IKdOi0FOd0xtKh1p34rQ8S/4uUN9XCVj
KtmyLfQgqPVEC6MKv7yFbextPoDUrFAzEgi4OBdqDJjPbdU9wUjONxuWJRrzRFcr
nTIG7oC4dae0p1rs5uTlaSIKpB2yulaJLKjnNstAj9G9Evf4SE2PKH4l4Jlo/Hu1
wOUqmCLRo3vFbn7xvfr1u0Z+oMTOOARkuAhwEgorBgEEAZdVAQUBAQdAcuNbK3VT
WrRYypisnnzLAguqvKX3Vc1OpNE4f8pOcgMDAQgHwsF2BBgBCgAgFiEE9KKf333+
FIzPGaxOJ/SzRZ8AIlcFAmS4CHACGwwACgkQJ/SzRZ8AIlc90BAAr0hmx8XU9KCj
g4nJqfavlmKUZetoX5RB9g3hkpDlvjdQZX6lenw3yUzPj53eoiDKzsM03Tak/KFU
FXGeq7UtPOfXMyIh5UZVdHQRxC4sIBMLKumBfC7LM6XeSegtaGEX8vSzjQICIbaI
roF2qVUOTMGal2mvcYEvmObC08bUZuMd4nxLnHGiej2t85+9F3Y7GAKsA25EXbbm
ziUg8IVXw3TojPNrNoQ3if2Z9NfKBhv0/s7x/3WhhIzOht+rAyZaaW+31btDrX4+
Y1XLAzg9DAfuqkL6knHDMd9tEuK6m2xCOAeZazXaNeOTjQ/XqCHmZ+691VhmAHCI
7Z7EBPh++TjEqn4ZH+4KPn6XD52+ruWXGbJP29zc+3bwQ+ZADfUaL3ADj69ySxzm
bO24USHBAg+BhZAZMBkbkygbTen/umT6tBxG91krqbKlDdc8mhGonBN6i+nz8qv1
6MdC5P1rDbo834rxNLvoFMSLCcpjoafiprl9qk0wQLq48WGphs9DX7V75ZAU5Lt6
yA+je8i799EZJsVlB933Gpj688H4csaZqEMBjq7vMvI+a5MnLCGcjwRhsUfogpRb
AWTx9ddVau4MJgEHzB7UU/VFyP2vku7XPj6mgSfSHyNVf2hqxwISQ8eZLoyxauOD
Y61QMX6YFL170ylToSFjH627h6TzlUDOMwRkuAiAFgkrBgEEAdpHDwEBB0Bibkmu
Sf7yECzrkBmjD6VGWNVxTdiqb2RuAfGFY9RjRsLB7QQYAQoAIBYhBPSin999/hSM
zxmsTif0s0WfACJXBQJkuAiAAhsCAIEJECf0s0WfACJXdiAEGRYIAB0WIQSiu8gv
1Xr0fIw/aoLbaV4Vf/JGvQUCZLgIgAAKCRDbaV4Vf/JGvZP9AQCwV06n3DZvuce3
/BtzG5zqUuf6Kp2Esgr2FrD4fKVbogD/ZHpXfi9ELdH/JTSVyujaTqhuxQ5B7UzV
CUIb1qbg1APIEA/+IaLJIBySehy8dHDZQXit/XQYeROQLTT9PvyM35rZVMGH6VG8
Zb23BPCJ3N0ISOtVdG402lSP0ilP/zSyQAbJN6F0o2tiPd558lPerFd/KpbCIp8N
kYaLlHWIDiN2AE3c6sfCiCPMtXOR7HCeQapGQBS/IMh1qYHffuzuEy7tbrMvjdra
VN9Rqtp7PSuRTbO3jAhm0Oe4lDCAK4zyZfjwiZGxnj9s1dyEbxYB2GhTOgkiX/96
Nw+m/ShaKqTM7o3pNUEs9J3oHeGZFCCaZBv97ctqrYhnNB4kzCxAaZ6K9HAAmcKe
WT2q4JdYzwB6vEeHnvxl7M0Dj9pUTMujW77Qh5IkUQLYZ2XQYnKAV2WI90B0R1p9
bXP+jqqkaNCrxKHV1tYOB6037CziGcZmiDneiTlM765MTLJLlHNqlXxDCzRwEazU
y9dNzITjVT0qhc6th8/vqN9dqvQaAGa13u86Gbv4XPYdE+5MXPM/fTgkKaPBYcIV
QMvLfoZxyaTk4nzNbBxwwEEHrvTcWDdWxGNtkWRZw0+U5JpXCOi9kBCtFrJ701UG
UFs56zWndQUS/2xDyGk8GObGBSRLCwsXsKsF6hSX5aKXHyrAAxEUEscRaAmzd6O3
ZyZGVsEsOuGCLkekUMF/5dwOhEDXrY42VR/ZxdDTY99dznQkwTt4o7FOmkY=3D
=3DsIIN
-----END PGP PUBLIC KEY BLOCK-----

--------------gmEemoc0LUPVlPiV0b6JebQ0--

--------------5cJdu37HikjVed8jxrLfA18V--

--------------N7OjoLjMXkYdnC3RzfR3Vku5
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQSiu8gv1Xr0fIw/aoLbaV4Vf/JGvQUCZhzRZQUDAAAAAAAKCRDbaV4Vf/JGvb6T
AQDt0Sq7XAl2b0ADsg4UuWOttQvO752J9tW6SaWtB7zzuwD9Fk0qUyOTK4NM7w9nn/MCwfNjIyM2
qthDGJHJUweK4gQ=
=xmZQ
-----END PGP SIGNATURE-----

--------------N7OjoLjMXkYdnC3RzfR3Vku5--

