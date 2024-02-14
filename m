Return-Path: <linux-kernel+bounces-64936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 756AC8544DA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:17:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 999541C214CE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 09:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E5B125B3;
	Wed, 14 Feb 2024 09:17:30 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C5A12B66;
	Wed, 14 Feb 2024 09:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707902249; cv=none; b=iprdf0dz2a+OzvWoRiTyjpi8FoifFTZkGvpHADtwZCss/FM20Ax8TWEoH9Tr3b1P463l3ALHLbjF7kEURn9lJWhqzsqHQWwugShPOMxvkQLBMqx46USR1cMbRGlv31aJh28vx38BizgZ88jrsmPG8zbkr8vldI0lB7VeL8sA3mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707902249; c=relaxed/simple;
	bh=h5MT1T78Otnx2JnlA80Aj9JTvc6oirJwHBV1yEoNJ/Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o5d4Hx4snfYzgnU1NVgkbm6eAa4CuaBbNzS5H5vrkxlNSVF2FVWg4JpI5bA0a4lQPJ6mRI/8qgIq7axAD7VAgvkZkaV62dKV4dBJqX/ifjXmmQDLeeZCXzOSn45CzYKc6aWnDBF22CJcIEnnQCfg5q3NI7ivwomthltlOpFwIko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.06,159,1705330800"; 
   d="asc'?scan'208";a="193904112"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 14 Feb 2024 18:17:24 +0900
Received: from [10.226.93.95] (unknown [10.226.93.95])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id D02E54004186;
	Wed, 14 Feb 2024 18:17:20 +0900 (JST)
Message-ID: <07f5d7e7-ca09-4779-836d-c6d1146ea5b8@bp.renesas.com>
Date: Wed, 14 Feb 2024 09:17:15 +0000
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
 <99a883c8-ccf2-4e52-9c34-ead59cd84117@bp.renesas.com>
 <4bf96e67-d35b-813c-ac9b-f2094903ac55@omp.ru>
From: Paul Barker <paul.barker.ct@bp.renesas.com>
Organization: Renesas Electronics Corporation
In-Reply-To: <4bf96e67-d35b-813c-ac9b-f2094903ac55@omp.ru>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------n3L43mLyNqMndilp0MDSgaYI"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------n3L43mLyNqMndilp0MDSgaYI
Content-Type: multipart/mixed; boundary="------------Zyhfm3p7uJssOfP2CQb7Vvxi";
 protected-headers="v1"
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Sergey Shtylyov <s.shtylyov@omp.ru>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>, netdev@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <07f5d7e7-ca09-4779-836d-c6d1146ea5b8@bp.renesas.com>
Subject: Re: [RFC PATCH net-next v2 0/7] Improve GbEth performance on Renesas
 RZ/G2L and related SoCs
References: <20240206091909.3191-1-paul.barker.ct@bp.renesas.com>
 <29d9d3cb-4ac2-32e2-51b8-475d34216b07@omp.ru>
 <99a883c8-ccf2-4e52-9c34-ead59cd84117@bp.renesas.com>
 <4bf96e67-d35b-813c-ac9b-f2094903ac55@omp.ru>
In-Reply-To: <4bf96e67-d35b-813c-ac9b-f2094903ac55@omp.ru>

--------------Zyhfm3p7uJssOfP2CQb7Vvxi
Content-Type: multipart/mixed; boundary="------------f6SjzoA1tBP0Vu0wdlu1Se4P"

--------------f6SjzoA1tBP0Vu0wdlu1Se4P
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 12/02/2024 20:53, Sergey Shtylyov wrote:
> On 2/12/24 2:52 PM, Paul Barker wrote:
> [...]
>=20
>>>> This series aims to improve peformance of the GbEth IP in the Renesa=
s
>>>
>>>    You didn't fix the typo in "peformance"... :-/
>>>
>>>> RZ/G2L SoC family and the RZ/G3S SoC, which use the ravb driver. Alo=
ng
>>>> the way, we do some refactoring and ensure that napi_complete_done()=
 is
>>>> used in accordance with the NAPI documentation for both GbEth and R-=
Car
>>>> code paths.
>>>>
>>>> Performance improvment mainly comes from enabling SW IRQ Coalescing =
for
>>>
>>>    And in "improvment" too... :-/
>>
>> I'll fix this and the above type in v3.
>=20
>    TIA! Chances are this will end up in the merge commit...
>=20
>>>> all SoCs using the GbEth IP, and NAPI Threaded mode for single core =
SoCs
>>>> using the GbEth IP. These can be enabled/disabled at runtime via sys=
fs,
>>>> but our goal is to set sensible defaults which get good performance =
on
>>>> the affected SoCs.
>>>>
>>>> The performance impact of this series on iperf3 testing is as follow=
s:
>>>>   * RZ/G2L Ethernet throughput is unchanged, but CPU usage drops:
>>>>       * Bidirectional and TCP RX: 6.5% less CPU usage
>>>>       * UDP RX: 10% less CPU usage
>>>>
>>>>   * RZ/G2UL and RZ/G3S Ethernet throughput is increased for all test=

>>>>     cases except UDP TX, which suffers a slight loss:
>>>>       * TCP TX: 32% more throughput
>>>>       * TCP RX: 11% more throughput
>>>>       * UDP TX: 10% less throughput
>>>>       * UDP RX: 10183% more throughput - the previous throughput of
>>>
>>>    So this is a real figure? I thought you forgot to erase 10... :-)
>>
>> Yes, throughput went from 1.06Mbps to 109Mbps for the RZ/G2UL with the=
se
>> changes.
>=20
>    Hm, that gives me even 10283%! :-)
>=20
>> Initial testing shows that goes up again to 485Mbps with the next patc=
h
>> series I'm working on to reduce RX buffer sizes.
>=20
>    Oh, wow! :-)
>=20
>> Biju's work on checksum offload also helps a lot with these numbers, I=

>> can't take all the credit.
>=20
>    Took 5 versions to merge, unfortunately... :-/
>=20
> [...]
>=20
>>>> Work in this area will continue, in particular we expect to improve
>>>> TCP/UDP RX performance further with future changes to RX buffer
>>>> handling.
>>>>
>>>> Changes v1->v2:
>>>>   * Marked as RFC as the series depends on unmerged patches.
>>>>   * Refactored R-Car code paths as well as GbEth code paths.
>>>>   * Updated references to the patches this series depends on.
>>>>
>>>> Paul Barker (7):
>>>>   net: ravb: Simplify poll & receive functions
>>>
>>>    The below 3 commits fix issues in the GbEth code, so should
>>> be redone against net.git and posted separately from this series...
>>>
>>>>   net: ravb: Count packets instead of descriptors in RX path
>>>>   net: ravb: Always process TX descriptor ring
>>>>   net: ravb: Always update error counters
>>
>> I'll split out and re-submit these as bug fixes. "net: ravb: Count
>> packets instead of descriptors in RX path" will require a bit of rewor=
k
>> so it doesn't depend on the first patch of the series ("net: ravb:
>> Simplify poll & receive functions") so you'll probably want to re-revi=
ew
>> when I send it.
>=20
>    Yes, I figured that at least the 1st patch would need to be reworked=
=2E..
>=20
>> Then I'll re-send the rest as a non-RFC series.
>=20
>    Won't they need to be rebased against 3 fixes?

Yes, the rest will need rebasing.

We need to test gPTP on an RZ/G2N board with these changes first. We're
working on it and I'll let you know the status soon. I should be able to
send at least one bugfix in a way that doesn't affect RZ/G2N & R-Car
boards though...

Thanks,

--=20
Paul Barker
--------------f6SjzoA1tBP0Vu0wdlu1Se4P
Content-Type: application/pgp-keys; name="OpenPGP_0x27F4B3459F002257.asc"
Content-Disposition: attachment; filename="OpenPGP_0x27F4B3459F002257.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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3D
=3DsIIN
-----END PGP PUBLIC KEY BLOCK-----

--------------f6SjzoA1tBP0Vu0wdlu1Se4P--

--------------Zyhfm3p7uJssOfP2CQb7Vvxi--

--------------n3L43mLyNqMndilp0MDSgaYI
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQSiu8gv1Xr0fIw/aoLbaV4Vf/JGvQUCZcyFGwUDAAAAAAAKCRDbaV4Vf/JGvdFt
AQCbE8pRdIeSIXsrWN94oVKFQMnCY+sH9l2fuQD6zVGKdgD+NfYB1PtVCdjcR3Z4DR4QkHaZbTfb
E8pTJ465/QCQ3ws=
=jbyW
-----END PGP SIGNATURE-----

--------------n3L43mLyNqMndilp0MDSgaYI--

