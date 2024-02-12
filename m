Return-Path: <linux-kernel+bounces-61459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD8E8512AC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:52:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02904283D77
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC31B39AF4;
	Mon, 12 Feb 2024 11:52:18 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6536739FC6;
	Mon, 12 Feb 2024 11:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707738738; cv=none; b=ulCZ/owdDwj/zHoox5rIhPxMhLkNkPNj8T7l4VLbayMKoDBdkJmb592QsVQNYvQq2LI7SP/7K1K8vyYyy6wBCqnfHCnk//N2YecAHODrbpg27uAVXlz5PAIoa3xhkHPzmr0RSp0BLkgwvUWieh2tCt++CXs0K9j7BblH7HHcoEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707738738; c=relaxed/simple;
	bh=GpL07XAa/jm5FeLdjxYaphlLhPjYkUMyORseq7qEQyQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uF7higG8jcCK3sOx3DrCmbUswEnaw7LqInh1rdOW7XgxmAV8DY8RjAdhObEB+6Iwz24QyjDKmUzOgcAVvjAPxsPLRX/XrN1zx1amIShwa4ygjZPe0P8PU0eqRiTCfE5vRH3sWHIFedDRhg+b6vImslHb0cJuxwRXfn/JmCoQSAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.06,263,1705330800"; 
   d="asc'?scan'208";a="197569102"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 12 Feb 2024 20:52:14 +0900
Received: from [10.226.92.81] (unknown [10.226.92.81])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id E7BAC41AFAC9;
	Mon, 12 Feb 2024 20:52:10 +0900 (JST)
Message-ID: <99a883c8-ccf2-4e52-9c34-ead59cd84117@bp.renesas.com>
Date: Mon, 12 Feb 2024 11:52:09 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next v2 0/7] Improve GbEth performance on Renesas
 RZ/G2L and related SoCs
Content-Language: en-GB
To: Sergey Shtylyov <s.shtylyov@omp.ru>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>, netdev@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240206091909.3191-1-paul.barker.ct@bp.renesas.com>
 <29d9d3cb-4ac2-32e2-51b8-475d34216b07@omp.ru>
From: Paul Barker <paul.barker.ct@bp.renesas.com>
In-Reply-To: <29d9d3cb-4ac2-32e2-51b8-475d34216b07@omp.ru>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------gdYqQiIth7xEUoa2x4MlHboa"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------gdYqQiIth7xEUoa2x4MlHboa
Content-Type: multipart/mixed; boundary="------------YxdYTyxwde8Raj8xLdsTFczc";
 protected-headers="v1"
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Sergey Shtylyov <s.shtylyov@omp.ru>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>, netdev@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <99a883c8-ccf2-4e52-9c34-ead59cd84117@bp.renesas.com>
Subject: Re: [RFC PATCH net-next v2 0/7] Improve GbEth performance on Renesas
 RZ/G2L and related SoCs
References: <20240206091909.3191-1-paul.barker.ct@bp.renesas.com>
 <29d9d3cb-4ac2-32e2-51b8-475d34216b07@omp.ru>
In-Reply-To: <29d9d3cb-4ac2-32e2-51b8-475d34216b07@omp.ru>

--------------YxdYTyxwde8Raj8xLdsTFczc
Content-Type: multipart/mixed; boundary="------------kG6KqVt2nm7zk2pZF5LvPf2B"

--------------kG6KqVt2nm7zk2pZF5LvPf2B
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 10/02/2024 19:36, Sergey Shtylyov wrote:
> On 2/6/24 12:19 PM, Paul Barker wrote:
>=20
>> This series aims to improve peformance of the GbEth IP in the Renesas
>=20
>    You didn't fix the typo in "peformance"... :-/
>=20
>> RZ/G2L SoC family and the RZ/G3S SoC, which use the ravb driver. Along=

>> the way, we do some refactoring and ensure that napi_complete_done() i=
s
>> used in accordance with the NAPI documentation for both GbEth and R-Ca=
r
>> code paths.
>>
>> Performance improvment mainly comes from enabling SW IRQ Coalescing fo=
r
>=20
>    And in "improvment" too... :-/

I'll fix this and the above type in v3.

>=20
>> all SoCs using the GbEth IP, and NAPI Threaded mode for single core So=
Cs
>> using the GbEth IP. These can be enabled/disabled at runtime via sysfs=
,
>> but our goal is to set sensible defaults which get good performance on=

>> the affected SoCs.
>>
>> The performance impact of this series on iperf3 testing is as follows:=

>>   * RZ/G2L Ethernet throughput is unchanged, but CPU usage drops:
>>       * Bidirectional and TCP RX: 6.5% less CPU usage
>>       * UDP RX: 10% less CPU usage
>>
>>   * RZ/G2UL and RZ/G3S Ethernet throughput is increased for all test
>>     cases except UDP TX, which suffers a slight loss:
>>       * TCP TX: 32% more throughput
>>       * TCP RX: 11% more throughput
>>       * UDP TX: 10% less throughput
>>       * UDP RX: 10183% more throughput - the previous throughput of
>=20
>    So this is a real figure? I thought you forgot to erase 10... :-)

Yes, throughput went from 1.06Mbps to 109Mbps for the RZ/G2UL with these
changes.

Initial testing shows that goes up again to 485Mbps with the next patch
series I'm working on to reduce RX buffer sizes.

Biju's work on checksum offload also helps a lot with these numbers, I
can't take all the credit.

>=20
>>         1.06Mbps is what prompted this work.
>>
>>   * RZ/G2N CPU usage and Ethernet throughput is unchanged (tested as a=

>>     representative of the SoCs which use the R-Car based RAVB IP).
>>
>> This series depends on:
>>   * "net: ravb: Let IP-specific receive function to interrogate descri=
ptors" v6
>>     https://lore.kernel.org/all/20240202084136.3426492-2-claudiu.bezne=
a.uj@bp.renesas.com/
>=20
>    This one has been merged now, so you can drop RFC...
>=20
>> To get the results shown above, you'll also need:
>>   * "topology: Set capacity_freq_ref in all cases"
>>     https://lore.kernel.org/all/20240117190545.596057-1-vincent.guitto=
t@linaro.org/
>>
>>   * "ravb: Add Rx checksum offload support" v4
>>     https://lore.kernel.org/all/20240203142559.130466-2-biju.das.jz@bp=
=2Erenesas.com/
>>
>>   * "ravb: Add Tx checksum offload support" v4
>>     https://lore.kernel.org/all/20240203142559.130466-3-biju.das.jz@bp=
=2Erenesas.com/
>=20
>    These two have been merged too...
>=20
>> Work in this area will continue, in particular we expect to improve
>> TCP/UDP RX performance further with future changes to RX buffer
>> handling.
>>
>> Changes v1->v2:
>>   * Marked as RFC as the series depends on unmerged patches.
>>   * Refactored R-Car code paths as well as GbEth code paths.
>>   * Updated references to the patches this series depends on.
>>
>> Paul Barker (7):
>>   net: ravb: Simplify poll & receive functions
>=20
>    The below 3 commits fix issues in the GbEth code, so should
> be redone against net.git and posted separately from this series...
>=20
>>   net: ravb: Count packets instead of descriptors in RX path
>>   net: ravb: Always process TX descriptor ring
>>   net: ravb: Always update error counters

I'll split out and re-submit these as bug fixes. "net: ravb: Count
packets instead of descriptors in RX path" will require a bit of rework
so it doesn't depend on the first patch of the series ("net: ravb:
Simplify poll & receive functions") so you'll probably want to re-review
when I send it.

Then I'll re-send the rest as a non-RFC series.

>=20
> [...]
>=20
> MBR, Sergey

Thanks for the review!
Paul
--------------kG6KqVt2nm7zk2pZF5LvPf2B
Content-Type: application/pgp-keys; name="OpenPGP_0x27F4B3459F002257.asc"
Content-Disposition: attachment; filename="OpenPGP_0x27F4B3459F002257.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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3D
=3DsIIN
-----END PGP PUBLIC KEY BLOCK-----

--------------kG6KqVt2nm7zk2pZF5LvPf2B--

--------------YxdYTyxwde8Raj8xLdsTFczc--

--------------gdYqQiIth7xEUoa2x4MlHboa
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQSiu8gv1Xr0fIw/aoLbaV4Vf/JGvQUCZcoGaQUDAAAAAAAKCRDbaV4Vf/JGvWQv
AP99nq3e3tTCVG5AT5Ash4tBIc6HvHQJQ7jxGS0HWBZvswEA31lc75J5gyr6idRiOvRNRZKLqDKl
R4f7AbNdK0fYVg0=
=ha/M
-----END PGP SIGNATURE-----

--------------gdYqQiIth7xEUoa2x4MlHboa--

