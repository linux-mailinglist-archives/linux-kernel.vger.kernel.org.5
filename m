Return-Path: <linux-kernel+bounces-144642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD688A48BE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 09:12:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAABF1C219D9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 07:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCCE6224D4;
	Mon, 15 Apr 2024 07:12:20 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532BB1EB30;
	Mon, 15 Apr 2024 07:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713165140; cv=none; b=CKeCv8zjoecjvI2m+DsBSc9CwrQY5AxDzc1xZuscSyxfbXhtkl3HQQ6KTeZ2JO4pJqfplJQ+Nd4HgUP/1qGzWCpKnDj8Ow9kfHYSKJZh3UTb4BkPLGwUagxO58fiblB++P7qWiR5V1DJzH4WeJsBoPJ3VLETbGluXrtMT+ZvPWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713165140; c=relaxed/simple;
	bh=MEgv07aPr6/Olwpa4+i/ZsU3BY52tL/1i7Hb+2G55W4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aBiJ9PqjUP6KHqo+SGxO+55KPxGkWV4GX/Q05evcZpKfYii+0cTKT8Mis2VGeoGEHlx3uH9ufuZDeg1eNEVJYdugVlYb81SMTrjAjQcIWOV+ChPFK2isaQ1UHDTzkZr8lUpOTRMNBarePVW9CLXQzKZYd8PPzYPnmqDu0xesB5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.07,202,1708354800"; 
   d="asc'?scan'208";a="201459648"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 15 Apr 2024 16:12:10 +0900
Received: from [10.226.93.74] (unknown [10.226.93.74])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 5325A4156C74;
	Mon, 15 Apr 2024 16:12:07 +0900 (JST)
Message-ID: <d1ec92db-eefe-465a-9eb5-3a57c22b86c3@bp.renesas.com>
Date: Mon, 15 Apr 2024 08:12:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/4] net: ravb: Allow RX loop to move past DMA mapping
 errors
Content-Language: en-GB
To: =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Cc: Sergey Shtylyov <s.shtylyov@omp.ru>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>, netdev@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240411114434.26186-1-paul.barker.ct@bp.renesas.com>
 <20240411114434.26186-3-paul.barker.ct@bp.renesas.com>
 <20240414121719.GB2860391@ragnatech.se>
From: Paul Barker <paul.barker.ct@bp.renesas.com>
Organization: Renesas Electronics Corporation
In-Reply-To: <20240414121719.GB2860391@ragnatech.se>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------C3uv1LR80ijuoFSXv1F6YSxo"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------C3uv1LR80ijuoFSXv1F6YSxo
Content-Type: multipart/mixed; boundary="------------Lj0KIDovzsKqov1BU7JUg3JG";
 protected-headers="v1"
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Cc: Sergey Shtylyov <s.shtylyov@omp.ru>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>, netdev@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <d1ec92db-eefe-465a-9eb5-3a57c22b86c3@bp.renesas.com>
Subject: Re: [PATCH net 2/4] net: ravb: Allow RX loop to move past DMA mapping
 errors
References: <20240411114434.26186-1-paul.barker.ct@bp.renesas.com>
 <20240411114434.26186-3-paul.barker.ct@bp.renesas.com>
 <20240414121719.GB2860391@ragnatech.se>
In-Reply-To: <20240414121719.GB2860391@ragnatech.se>

--------------Lj0KIDovzsKqov1BU7JUg3JG
Content-Type: multipart/mixed; boundary="------------nZ6ZwuzGQLany2vGXAZuVnqa"

--------------nZ6ZwuzGQLany2vGXAZuVnqa
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 14/04/2024 13:17, Niklas S=C3=B6derlund wrote:
> Hi Paul,
>=20
> Thanks for your patch.
>=20
> On 2024-04-11 12:44:31 +0100, Paul Barker wrote:
>> The RX loops in ravb_rx_gbeth() and ravb_rx_rcar() skip to the next lo=
op
>> interation if a zero-length descriptor is seen (indicating a DMA mappi=
ng
>> error). However, the current rx descriptor index `priv->cur_rx[q]` was=

>> incremented at the end of the loop and so would not be incremented whe=
n
>> we skip to the next loop iteration. This would cause the loop to keep
>> seeing the same zero-length descriptor instead of moving on to the nex=
t
>> descriptor.
>>
>> As the loop counter `i` still increments, the loop would eventually
>> terminate so there is no risk of being stuck here forever - but we
>> should still fix this to avoid wasting cycles.
>>
>> To fix this, the rx descriptor index is incremented at the top of the
>> loop, in the for statement itself. The assignments of `entry` and `des=
c`
>> are brought into the loop to avoid the need for duplication.
>>
>> Fixes: d8b48911fd24 ("ravb: fix ring memory allocation")
>> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
>> ---
>>  drivers/net/ethernet/renesas/ravb_main.c | 25 ++++++++++++-----------=
-
>>  1 file changed, 13 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/et=
hernet/renesas/ravb_main.c
>> index 70f2900648d4..028ab5c6aaf7 100644
>> --- a/drivers/net/ethernet/renesas/ravb_main.c
>> +++ b/drivers/net/ethernet/renesas/ravb_main.c
>> @@ -775,12 +775,15 @@ static bool ravb_rx_gbeth(struct net_device *nde=
v, int *quota, int q)
>>  	int limit;
>>  	int i;
>> =20
>> -	entry =3D priv->cur_rx[q] % priv->num_rx_ring[q];
>>  	limit =3D priv->dirty_rx[q] + priv->num_rx_ring[q] - priv->cur_rx[q]=
;
>>  	stats =3D &priv->stats[q];
>> =20
>> -	desc =3D &priv->rx_ring[q].desc[entry];
>> -	for (i =3D 0; i < limit && rx_packets < *quota && desc->die_dt !=3D =
DT_FEMPTY; i++) {
>> +	for (i =3D 0; i < limit && rx_packets < *quota; i++, priv->cur_rx[q]=
++) {
>> +		entry =3D priv->cur_rx[q] % priv->num_rx_ring[q];
>> +		desc =3D &priv->rx_ring[q].desc[entry];
>> +		if (desc->die_dt =3D=3D DT_FEMPTY)
>> +			break;
>> +
>>  		/* Descriptor type must be checked before all other reads */
>>  		dma_rmb();
>>  		desc_status =3D desc->msc;
>> @@ -848,9 +851,6 @@ static bool ravb_rx_gbeth(struct net_device *ndev,=
 int *quota, int q)
>>  				break;
>>  			}
>>  		}
>> -
>> -		entry =3D (++priv->cur_rx[q]) % priv->num_rx_ring[q];
>> -		desc =3D &priv->rx_ring[q].desc[entry];
>>  	}
>> =20
>>  	/* Refill the RX ring buffers. */
>> @@ -891,7 +891,6 @@ static bool ravb_rx_rcar(struct net_device *ndev, =
int *quota, int q)
>>  {
>>  	struct ravb_private *priv =3D netdev_priv(ndev);
>>  	const struct ravb_hw_info *info =3D priv->info;
>> -	int entry =3D priv->cur_rx[q] % priv->num_rx_ring[q];
>>  	struct net_device_stats *stats =3D &priv->stats[q];
>>  	struct ravb_ex_rx_desc *desc;
>>  	struct sk_buff *skb;
>> @@ -900,12 +899,17 @@ static bool ravb_rx_rcar(struct net_device *ndev=
, int *quota, int q)
>>  	int rx_packets =3D 0;
>>  	u8  desc_status;
>>  	u16 pkt_len;
>> +	int entry;
>>  	int limit;
>>  	int i;
>> =20
>>  	limit =3D priv->dirty_rx[q] + priv->num_rx_ring[q] - priv->cur_rx[q]=
;
>> -	desc =3D &priv->rx_ring[q].ex_desc[entry];
>> -	for (i =3D 0; i < limit && rx_packets < *quota && desc->die_dt !=3D =
DT_FEMPTY; i++) {
>> +	for (i =3D 0; i < limit && rx_packets < *quota; i++, priv->cur_rx[q]=
++) {
>> +		entry =3D priv->cur_rx[q] % priv->num_rx_ring[q];
>> +		desc =3D &priv->rx_ring[q].ex_desc[entry];
>> +		if (desc->die_dt =3D=3D DT_FEMPTY)
>> +			break;
>=20
> I really like moving the assignment of entry and desc to the top of the=
=20
> loop. But I don't like the loop limits as it's hard, at least for me, t=
o=20
> immediately see what's going on. How about,
>=20
>     limit =3D min(priv->dirty_rx[q] + priv->num_rx_ring[q] - priv->cur_=
rx[q], *quota);
>=20
>     for (i =3D 0; i < limit; i++) {
>         entry =3D priv->cur_rx[q] % priv->num_rx_ring[q];
>         desc =3D &priv->rx_ring[q].ex_desc[entry];
>=20
>         /* There are no more valid descriptors after an empty one. */
>         if (desc->die_dt =3D=3D DT_FEMPTY)
>                 break;
>=20
>         ...
>     }

We need to count received packets separately from the number of
descriptors processed, as done in the previous commit in this series,
so we can't just have a single check against limit.

We also need to increment priv->cur_rx[q]. If we put `priv->cur_rx[q]++`
at the end of the loop then we're back to having to worry about it when
we have a continue statement.

We could move the `rx_packets < *quota` check inside the loop itself,
but I don't see that as any clearer myself.

Thanks,

--=20
Paul Barker
--------------nZ6ZwuzGQLany2vGXAZuVnqa
Content-Type: application/pgp-keys; name="OpenPGP_0x27F4B3459F002257.asc"
Content-Disposition: attachment; filename="OpenPGP_0x27F4B3459F002257.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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3D
=3DsIIN
-----END PGP PUBLIC KEY BLOCK-----

--------------nZ6ZwuzGQLany2vGXAZuVnqa--

--------------Lj0KIDovzsKqov1BU7JUg3JG--

--------------C3uv1LR80ijuoFSXv1F6YSxo
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQSiu8gv1Xr0fIw/aoLbaV4Vf/JGvQUCZhzTRgUDAAAAAAAKCRDbaV4Vf/JGvSGC
AP9/fQru+ck1Df4X+puju9/bEwPqSZ9dhN+T3BMS8C79gAEAk0G8GgkrXd/rT8qvqiprr97gJzB/
pzhAipECYGwEDwg=
=ESr7
-----END PGP SIGNATURE-----

--------------C3uv1LR80ijuoFSXv1F6YSxo--

