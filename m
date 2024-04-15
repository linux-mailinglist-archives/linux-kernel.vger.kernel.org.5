Return-Path: <linux-kernel+bounces-144990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF2B8A4DBF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C2371C22538
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 11:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D75160B9D;
	Mon, 15 Apr 2024 11:31:13 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D6C5A0E3;
	Mon, 15 Apr 2024 11:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713180672; cv=none; b=LuXdzqTBo/+w0PZ24csWfBdhBswsFpn4lCS7fIIgonPHi6qgUDS44N7R8DGMfo1Mq1hJzhVBM+UbaRolWL7SF0Fvwg/V+kPAnGhjqKWYi1ZkUnAlHnhN4Oeqm7ur1L3ZhJJMOAoA+fqPKsu8CxxR3mU/h16hHuvZASCIGHq9fwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713180672; c=relaxed/simple;
	bh=HyIfm5Kh3GiW74LTkOn+VF3/HZMWwDPx1lWHH03RNU0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UnQHmt3v72a5JLijCnG0OiSs0YXjlpFYe7Cc6Va7TRSnv8O6JyNfpIcbTny9v8vFmI/vKg2FGh/rc2GAZLSk2KPXyZKjNShHD71oFZXlCRHFVdBsITVN3CFazdAqNb6nFMcq+Xe91L0Aa7zENIkd81hfRzZWPY6s2g0Edrk49SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.07,203,1708354800"; 
   d="asc'?scan'208";a="205442345"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 15 Apr 2024 20:31:08 +0900
Received: from [10.226.93.74] (unknown [10.226.93.74])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id C7CA0400BBF8;
	Mon, 15 Apr 2024 20:31:04 +0900 (JST)
Message-ID: <384a8388-f7ed-4cce-bd62-4a8b102ca8e8@bp.renesas.com>
Date: Mon, 15 Apr 2024 12:31:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next RFC v3 1/7] net: ravb: Simplify poll & receive
 functions
Content-Language: en-GB
To: =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Cc: Sergey Shtylyov <s.shtylyov@omp.ru>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>, netdev@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240415094804.8016-1-paul.barker.ct@bp.renesas.com>
 <20240415094804.8016-2-paul.barker.ct@bp.renesas.com>
 <20240415112301.GF3156415@ragnatech.se>
From: Paul Barker <paul.barker.ct@bp.renesas.com>
Organization: Renesas Electronics Corporation
In-Reply-To: <20240415112301.GF3156415@ragnatech.se>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------2Cub0xOSusxNdXIIuphEQ41Q"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------2Cub0xOSusxNdXIIuphEQ41Q
Content-Type: multipart/mixed; boundary="------------G38oSj705UEa1ZVKNaoCymUt";
 protected-headers="v1"
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Cc: Sergey Shtylyov <s.shtylyov@omp.ru>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>, netdev@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <384a8388-f7ed-4cce-bd62-4a8b102ca8e8@bp.renesas.com>
Subject: Re: [net-next RFC v3 1/7] net: ravb: Simplify poll & receive
 functions
References: <20240415094804.8016-1-paul.barker.ct@bp.renesas.com>
 <20240415094804.8016-2-paul.barker.ct@bp.renesas.com>
 <20240415112301.GF3156415@ragnatech.se>
In-Reply-To: <20240415112301.GF3156415@ragnatech.se>

--------------G38oSj705UEa1ZVKNaoCymUt
Content-Type: multipart/mixed; boundary="------------eBuVJ2XCN0gtrRmfxQRWAx9X"

--------------eBuVJ2XCN0gtrRmfxQRWAx9X
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 15/04/2024 12:23, Niklas S=C3=B6derlund wrote:
> Hi Paul,
>=20
> I really like this patch!
>=20
> One nit below.
>=20
> On 2024-04-15 10:47:58 +0100, Paul Barker wrote:
>> We don't need to pass the work budget to ravb_rx() by reference, it's
>> cleaner to pass this by value and return the amount of work done. This=

>> allows us to simplify the ravb_poll() function and use the common
>> `work_done` variable name seen in other network drivers for consistenc=
y
>> and ease of understanding.
>>
>> This is a pure refactor and should not affect behaviour.
>>
>> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
>> ---
>>  drivers/net/ethernet/renesas/ravb.h      |  2 +-
>>  drivers/net/ethernet/renesas/ravb_main.c | 29 ++++++++++-------------=
-
>>  2 files changed, 13 insertions(+), 18 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/renesas/ravb.h b/drivers/net/etherne=
t/renesas/ravb.h
>> index b48935ec7e28..71de2a7aa27c 100644
>> --- a/drivers/net/ethernet/renesas/ravb.h
>> +++ b/drivers/net/ethernet/renesas/ravb.h
>> @@ -1039,7 +1039,7 @@ struct ravb_ptp {
>>  };
>> =20
>>  struct ravb_hw_info {
>> -	bool (*receive)(struct net_device *ndev, int *quota, int q);
>> +	int (*receive)(struct net_device *ndev, int budget, int q);
>>  	void (*set_rate)(struct net_device *ndev);
>>  	int (*set_feature)(struct net_device *ndev, netdev_features_t featur=
es);
>>  	int (*dmac_init)(struct net_device *ndev);
>> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/et=
hernet/renesas/ravb_main.c
>> index fd2679ce4e3d..33f8043143c1 100644
>> --- a/drivers/net/ethernet/renesas/ravb_main.c
>> +++ b/drivers/net/ethernet/renesas/ravb_main.c
>> @@ -759,7 +759,7 @@ static struct sk_buff *ravb_get_skb_gbeth(struct n=
et_device *ndev, int entry,
>>  }
>> =20
>>  /* Packet receive function for Gigabit Ethernet */
>> -static bool ravb_rx_gbeth(struct net_device *ndev, int *quota, int q)=

>> +static int ravb_rx_gbeth(struct net_device *ndev, int budget, int q)
>>  {
>>  	struct ravb_private *priv =3D netdev_priv(ndev);
>>  	const struct ravb_hw_info *info =3D priv->info;
>> @@ -778,7 +778,7 @@ static bool ravb_rx_gbeth(struct net_device *ndev,=
 int *quota, int q)
>>  	limit =3D priv->dirty_rx[q] + priv->num_rx_ring[q] - priv->cur_rx[q]=
;
>>  	stats =3D &priv->stats[q];
>> =20
>> -	for (i =3D 0; i < limit && rx_packets < *quota; i++, priv->cur_rx[q]=
++) {
>> +	for (i =3D 0; i < limit && rx_packets < budget; i++, priv->cur_rx[q]=
++) {
>>  		entry =3D priv->cur_rx[q] % priv->num_rx_ring[q];
>>  		desc =3D &priv->rx_ring[q].desc[entry];
>>  		if (desc->die_dt =3D=3D DT_FEMPTY)
>> @@ -881,13 +881,11 @@ static bool ravb_rx_gbeth(struct net_device *nde=
v, int *quota, int q)
>>  		desc->die_dt =3D DT_FEMPTY;
>>  	}
>> =20
>> -	stats->rx_packets +=3D rx_packets;
>> -	*quota -=3D rx_packets;
>> -	return *quota =3D=3D 0;
>> +	return rx_packets;
>>  }
>> =20
>>  /* Packet receive function for Ethernet AVB */
>> -static bool ravb_rx_rcar(struct net_device *ndev, int *quota, int q)
>> +static int ravb_rx_rcar(struct net_device *ndev, int budget, int q)
>>  {
>>  	struct ravb_private *priv =3D netdev_priv(ndev);
>>  	const struct ravb_hw_info *info =3D priv->info;
>> @@ -904,7 +902,7 @@ static bool ravb_rx_rcar(struct net_device *ndev, =
int *quota, int q)
>>  	int i;
>> =20
>>  	limit =3D priv->dirty_rx[q] + priv->num_rx_ring[q] - priv->cur_rx[q]=
;
>> -	for (i =3D 0; i < limit && rx_packets < *quota; i++, priv->cur_rx[q]=
++) {
>> +	for (i =3D 0; i < limit && rx_packets < budget; i++, priv->cur_rx[q]=
++) {
>>  		entry =3D priv->cur_rx[q] % priv->num_rx_ring[q];
>>  		desc =3D &priv->rx_ring[q].ex_desc[entry];
>>  		if (desc->die_dt =3D=3D DT_FEMPTY)
>> @@ -992,18 +990,16 @@ static bool ravb_rx_rcar(struct net_device *ndev=
, int *quota, int q)
>>  		desc->die_dt =3D DT_FEMPTY;
>>  	}
>> =20
>> -	stats->rx_packets +=3D rx_packets;
>=20
> Don't we still need to update the statistics? Same for ravb_rx_gbeth().=


Good catch! This was present in the previous version of the series [1],
but I accidentally dropped it while splitting out the bugfix patches.
I'll add it back in for the next version.

[1]: https://lore.kernel.org/all/20240206091909.3191-3-paul.barker.ct@bp.=
renesas.com/

Thanks,

--=20
Paul Barker
--------------eBuVJ2XCN0gtrRmfxQRWAx9X
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

--------------eBuVJ2XCN0gtrRmfxQRWAx9X--

--------------G38oSj705UEa1ZVKNaoCymUt--

--------------2Cub0xOSusxNdXIIuphEQ41Q
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQSiu8gv1Xr0fIw/aoLbaV4Vf/JGvQUCZh0P9wUDAAAAAAAKCRDbaV4Vf/JGvTi+
APwN/T79MF+IhO4W+qQHlljL1FtIT7H06zEedvdwRVGqLQD/XLdNYUy1s6hs8G8zFioEXRBn8Era
aX6TSNiz5PgG0g0=
=cd15
-----END PGP SIGNATURE-----

--------------2Cub0xOSusxNdXIIuphEQ41Q--

