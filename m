Return-Path: <linux-kernel+bounces-129381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD2818969E0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 11:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 581651F27320
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 09:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83D2F6FE04;
	Wed,  3 Apr 2024 09:02:16 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9BC16CDDB;
	Wed,  3 Apr 2024 09:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712134935; cv=none; b=C58AIafQzsnYNd6MzNNQuJsvZmwKMANvu1fa+6b21CWFE8BIavCrp2mra/NA97ldjcrK3CdSn+2NPNedcGivol3cDPb30U9vm2vjO3wxnvO15oNktG7YRkoxCYA9A4qrUdS+zB/paODmr2TDqj0CVijGtJeghros2Rc27Du4j8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712134935; c=relaxed/simple;
	bh=JbsvBMoyFD8gk8jPhVq+6vWawp6Bogda8tQ+hv6S9GM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H+Dj8lp0HDtrFBEE+ky1a7bOlF2eXY7e6nvF+26nerh0O5BbhERCdgf5dKwO687OPGOkp0HP6NbjXm7QtnRPwvkbjGxqRjqr3wYgiA/AG6u0xXOEwJawG0DwHAFk27kjMSFSfGHCHUoqt/61ikr9N/hpRf64C2mUuCK/68RQQcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.07,177,1708354800"; 
   d="asc'?scan'208";a="200226792"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 03 Apr 2024 18:02:10 +0900
Received: from [10.226.92.147] (unknown [10.226.92.147])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id CC09541C1173;
	Wed,  3 Apr 2024 18:02:06 +0900 (JST)
Message-ID: <b683f659-23c6-42b2-b690-e3684f37cebf@bp.renesas.com>
Date: Wed, 3 Apr 2024 10:02:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] net: ravb: Always process TX descriptor ring
Content-Language: en-GB
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: Sergey Shtylyov <s.shtylyov@omp.ru>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
 netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240402145305.82148-1-paul.barker.ct@bp.renesas.com>
 <20240403033932.GA1652207@maili.marvell.com>
From: Paul Barker <paul.barker.ct@bp.renesas.com>
Organization: Renesas Electronics Corporation
In-Reply-To: <20240403033932.GA1652207@maili.marvell.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------bYB0gkSUt45Iix8pkQRussgN"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------bYB0gkSUt45Iix8pkQRussgN
Content-Type: multipart/mixed; boundary="------------mqf0Nm0K3JUoES7kBTlVMNP8";
 protected-headers="v1"
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: Sergey Shtylyov <s.shtylyov@omp.ru>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
 netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <b683f659-23c6-42b2-b690-e3684f37cebf@bp.renesas.com>
Subject: Re: [PATCH v2 1/2] net: ravb: Always process TX descriptor ring
References: <20240402145305.82148-1-paul.barker.ct@bp.renesas.com>
 <20240403033932.GA1652207@maili.marvell.com>
In-Reply-To: <20240403033932.GA1652207@maili.marvell.com>

--------------mqf0Nm0K3JUoES7kBTlVMNP8
Content-Type: multipart/mixed; boundary="------------vL1X90uttMqWEOS0SbZkK6bc"

--------------vL1X90uttMqWEOS0SbZkK6bc
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 03/04/2024 04:39, Ratheesh Kannoth wrote:
> On 2024-04-02 at 20:23:04, Paul Barker (paul.barker.ct@bp.renesas.com) =
wrote:
>> The TX queue should be serviced each time the poll function is called,=

>> even if the full RX work budget has been consumed. This prevents
>> starvation of the TX queue when RX bandwidth usage is high.
>>
>> Fixes: c156633f1353 ("Renesas Ethernet AVB driver proper")
>> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
>> ---
>> Changes from v1:
>>   * Use the correct 'Fixes' tag.
>>   * Call the new variable 'unmask' and drop the unnecessary initialize=
r,
>>     as requested by Sergey.
>>
>>  drivers/net/ethernet/renesas/ravb_main.c | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/et=
hernet/renesas/ravb_main.c
>> index d1be030c8848..48803050abdb 100644
>> --- a/drivers/net/ethernet/renesas/ravb_main.c
>> +++ b/drivers/net/ethernet/renesas/ravb_main.c
>> @@ -1324,12 +1324,12 @@ static int ravb_poll(struct napi_struct *napi,=
 int budget)
>>  	int q =3D napi - priv->napi;
>>  	int mask =3D BIT(q);
>>  	int quota =3D budget;
>> +	bool unmask;
>>
>>  	/* Processing RX Descriptor Ring */
>>  	/* Clear RX interrupt */
>>  	ravb_write(ndev, ~(mask | RIS0_RESERVED), RIS0);
>> -	if (ravb_rx(ndev, &quota, q))
>> -		goto out;
>> +	unmask =3D !ravb_rx(ndev, &quota, q);
>>
>>  	/* Processing TX Descriptor Ring */
> AFAIU, TX is processed without any budget. This wont result in rx work =
starvation if
> TX traffic is more ?

Quoting the docs in Documentation/networking/napi.rst:

    The method takes a ``budget`` argument - drivers can process
    completions for any number of Tx packets but should only process up
    to ``budget`` number of Rx packets.

    skb Tx processing should happen regardless of the ``budget``

I take that to mean that the RX work budget running out should not stop
processing of TX packets.

Other drivers with a combined TX/RX poll function follow the same
pattern of processing TX packets regardless of RX budget exhaustion, for
example see ixgbe_poll() which processes TX packets first (in
drivers/net/ethernet/intel/ixgbe/ixgbe_main.c).

Thanks,

--=20
Paul Barker
--------------vL1X90uttMqWEOS0SbZkK6bc
Content-Type: application/pgp-keys; name="OpenPGP_0x27F4B3459F002257.asc"
Content-Disposition: attachment; filename="OpenPGP_0x27F4B3459F002257.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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3D
=3DsIIN
-----END PGP PUBLIC KEY BLOCK-----

--------------vL1X90uttMqWEOS0SbZkK6bc--

--------------mqf0Nm0K3JUoES7kBTlVMNP8--

--------------bYB0gkSUt45Iix8pkQRussgN
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQSiu8gv1Xr0fIw/aoLbaV4Vf/JGvQUCZg0bDQUDAAAAAAAKCRDbaV4Vf/JGvcgi
AP4gcIFxx7+J1/ZrrkMZxv6WDjMqKN+ejHNPUQ+KvkTyoQEAvDN2aVFH+gwDgodXViUyjBtJRcKb
z9LDJmjyLH4pRAQ=
=obIs
-----END PGP SIGNATURE-----

--------------bYB0gkSUt45Iix8pkQRussgN--

