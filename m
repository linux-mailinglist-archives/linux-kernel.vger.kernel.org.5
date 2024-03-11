Return-Path: <linux-kernel+bounces-98465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B33D877A81
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 06:07:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C414CB21435
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 05:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6196B8827;
	Mon, 11 Mar 2024 05:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="N+NOAHNL"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5DD79CB;
	Mon, 11 Mar 2024 05:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710133660; cv=fail; b=MW60O2PjXc6oBD7S/VmMzi1Jdda4A2Fio3kz6l8Sbsf/J0qeekrCUNFfS5C9cHS0Q8PYG4f0uP7LcDfVJ5wLttiyQQUFxXvkPkHMYoTt2xQ/W41mzoddh+hHoyxO/R12JQtCHWNaH9s74R9+5rQbdZbfYSBZUWNTQ1WZJ13zKh4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710133660; c=relaxed/simple;
	bh=8Vy9aShNXbwKYIbWJbHNsi6bK54UWfJu2rAuQDQL6w0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fB+29vmh22ZJUWjSi1r69OB2lo/tHo1E/DAo8sAB1gk6nx8EQ1d1yeilUncjn2UBx4K+k/SBNHF/9rqPFKEIQ1H+DotleDPmplYPucvNrjTNbgPnBZLMgQKJ+3ULDaNvtcCerJyzMyAqJDKEi34dHfKdIG/HqoHNJP+fXPXmZSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=N+NOAHNL; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42B4CkAW025613;
	Sun, 10 Mar 2024 22:07:29 -0700
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3wstqrr3g4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 10 Mar 2024 22:07:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cBAkZB/+iHnVtMNZMvQpx7gpqNL62G63MhHWFYSDthO4by6k8dd+EMWxlkB0hon3POMM66Bwh5U+EBMfN0j2Eu8peptOzt5nYjdBHrTGVPeFvBRDdTs8K5SMtHtVz1B8qz2SxY85Ao1zU+Z2fDSJQdIIF7cdJfAYEKOv8uOlo9gVKU9K6R/HRAXD0GHy/6gMmbW1p40Qeex85BEIOTuU5J3UFjUoIf9E/1z/pT8e++aHgiJGHqolhnEYiYUXLK3jXptIn7x/jYak1rPg1aWpsuRmKJAj6oc2Y2xTRz4NYprtlIfHIs/w64NYczwNYSdKvDdtzaucJsVL8cMVakVpeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x6CJOsq2snApezMcOD+q/kAoyBHWDF570CTD4L3K/XQ=;
 b=nbczQqjDYEhajserCn/oMXop2Mc5FKgqawGqBOGu98DBI125xKAPlUYD0twa5lTVOJhPlXQuWwWsc2Et10SLpg1m4JiuGWt4+PDpMjkWszU4JoRtKCpbtPUopKk0t8mhm/qp31LT339d7Mn/mZr/2HfYlow1LtD1IJzyXYDubAYSULLvTH7r4GGcW7NQYXf3slQ3Xj/tuef5oKP6zKV0VfJhR2gnWMbgkjckuhrTZiAdTppt+M1a822H+TBkBqIU1j+pPFf4JmEd9oBBmq35/hI9ZSVyzpCT6Q0++VG0XAPrghVc9F3aFtHxFbXRy57cnzwVVAfAHQ1/DLzp7bX2rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x6CJOsq2snApezMcOD+q/kAoyBHWDF570CTD4L3K/XQ=;
 b=N+NOAHNLv9Fo7kZBVtuwHLSPNMqNZBg2yBjyjGMw8CsGknVEh7ocwpBO44l6YQGbKjCOg5lw8vlJmEynEn9AUVE7DQhMKOUeEw0Y/U2nVGLcq6lAPX1KdBCQwHo2Er+HzwLhWEWhebZnmjCqtozuvdLW0414wRNj2OnSugacI+Y=
Received: from SN7PR18MB5314.namprd18.prod.outlook.com (2603:10b6:806:2ef::8)
 by PH0PR18MB3846.namprd18.prod.outlook.com (2603:10b6:510:49::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Mon, 11 Mar
 2024 05:07:26 +0000
Received: from SN7PR18MB5314.namprd18.prod.outlook.com
 ([fe80::926a:6eb8:6d4b:656a]) by SN7PR18MB5314.namprd18.prod.outlook.com
 ([fe80::926a:6eb8:6d4b:656a%7]) with mapi id 15.20.7362.035; Mon, 11 Mar 2024
 05:07:26 +0000
From: Bharat Bhushan <bbhushan2@marvell.com>
To: Stefan Berger <stefanb@linux.ibm.com>,
        "keyrings@vger.kernel.org"
	<keyrings@vger.kernel.org>,
        "linux-crypto@vger.kernel.org"
	<linux-crypto@vger.kernel.org>,
        "herbert@gondor.apana.org.au"
	<herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "saulo.alessandre@tse.jus.br" <saulo.alessandre@tse.jus.br>,
        "lukas@wunner.de" <lukas@wunner.de>
Subject: RE: [EXTERNAL] [PATCH v5 05/12] crypto: ecc - Implement
 vli_mmod_fast_521 for NIST p521
Thread-Topic: [EXTERNAL] [PATCH v5 05/12] crypto: ecc - Implement
 vli_mmod_fast_521 for NIST p521
Thread-Index: AQHacBTwzyZQGHUA+kyq0nvKrHgeD7EyAexg
Date: Mon, 11 Mar 2024 05:07:26 +0000
Message-ID: 
 <SN7PR18MB53143E3480E99EA90B9FEB88E3242@SN7PR18MB5314.namprd18.prod.outlook.com>
References: <20240306222257.979304-1-stefanb@linux.ibm.com>
 <20240306222257.979304-6-stefanb@linux.ibm.com>
In-Reply-To: <20240306222257.979304-6-stefanb@linux.ibm.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR18MB5314:EE_|PH0PR18MB3846:EE_
x-ms-office365-filtering-correlation-id: c022e5ac-83d6-4f87-b6f3-08dc418924d0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 AwmGeWeYvGXAUGaD9L2/RKzDispeGJKDO1GWSIUHnN8aZ5NpC1OUIx+v7yjJYu+xdU8ZkIAgneZcE52jaqasttDodbBC3TCCVEHkENvQPG+bahY9QO+9zOIvmUfE2k8wx4LkvkX97NzKJZtvLxjYiBGB5lmC+/Kfz4/8uf8CaM7drQrePQAWKy005zES0pn7n0zwxWHvoCaeyqzFExgmgXnRL7YLuoTG1QU13udUns7X/D8eek7zXKcQ75FIjzJ03n+GySpW64cLNxguuYvc8PsylL3gWVgCzPaWC2HeNQNetwyuVQFO1jJkZgm/1D10sdC0cmNFKmVXK0V8tdeP6BuWih4IwXuTCjPdVp4u6HJlTGKu7UHU5xy94fiR5qhb7S8FTmTkcp2GTFu8yBUW4ARQI2qywtVbmAKun5JwUkbhihn+88cbkc2vVqG4cGW/5bRH1rPhCtcdrNSpVDFGHl0cj2E7yGRRzJ3kvHUaAfRLeLDvQOhHfFnMl1rm/nfN/pQaIkwTIh+7VhgTfFvPi/2iTr0G2pS3FITdqSrAIR40LfNFCQw5bhtq95Ix9CRFpWVWEflcbqdJV/kACahM4bIbj0GsusVRYUP8TQ+1stonRKmHneIk1/zgfYsld+5vWoCuTJw/xUrh6ds1GyOJ9M5MJrJFqYF6dXwybL1RWPT5AyvRaXzhOu2SXy/a0+z5GiOTfqBpim+MhvNUewTaDIEY4Vn76oBS/uWIMKr4ztM=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR18MB5314.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?TMD1qKryTaaNZGTTBPLqccw2Ge8XfYiOVxEJk84GTMQLI1WwnI/kYsqv36hX?=
 =?us-ascii?Q?Yy/KnUmGo3LOlXzN9G1xRPUO8VG+fiPE5l2kZvA2BAx8A+xnR8Ox3XNEYI4Q?=
 =?us-ascii?Q?tWerPzXBFH7Hy5KEwv850r/h/nJHnlThhBdfnpx+7+UYyX+ps5xcBaf+Ra+9?=
 =?us-ascii?Q?qa2EqswZ87P8KoiPA5nltm8XsxURvsHUyATbPNcbkBwumFXtkJDF4stksT6C?=
 =?us-ascii?Q?lP/4DuRTf381EfoZPwNMPcOT5EsoQVWTSmneYqOl2OvhgwMDdMt+6HjC9wmE?=
 =?us-ascii?Q?hJw6FFBXoXuzNbiL34Pf7lpmUH+Nn0YVc8BJOkykBAFrw7HHRmNYNNRlZD2+?=
 =?us-ascii?Q?42Tb2ESzcDsuMD6Oxd1xPrT6+hHxnlfPc1mTkRGK5/5N3aOxmqTIUADu7aV4?=
 =?us-ascii?Q?Yj3K+klewo1Uz6pqgN+OIefUC4Ek4c2f8pdQlcKXxDVLNGGPf3Rnl8ZRxAWX?=
 =?us-ascii?Q?B0d0SQ9A3wJwkpefN3I78CdGL5Bk+WVBPF+RqkLyQD5b7DFdGdM1rY/7ydLb?=
 =?us-ascii?Q?11KwGXO/hej5RWnd4lAa8oGtk+wj0+GzFpFmC15WD540QTP36m27uGTgTuH1?=
 =?us-ascii?Q?aX7DTGEC1mJkWIV1+hhaWHPi7fB3PMKVyUIx5uB6rpJ2Qy4xcTsm55AumvQy?=
 =?us-ascii?Q?MkZnEprVA7SpW+xxL8QnJcun13D1i45dg7eYGjTb2mHZcliZxlbPFI+/Ry3Z?=
 =?us-ascii?Q?HzII6+QClMjja48i/geJC46KIfweJBDNcu/BlQlCMHxx2vhHLIDs9oInvRw+?=
 =?us-ascii?Q?iUXVafDvtedfBfK6wC9Uh6/rFd2e/dmYTqCZZczFZwN2gEBQJsU0hPdKIiEf?=
 =?us-ascii?Q?DioGENUeqQ4ag14YuDdky6DV+K3b5uMYWnQaEEqXYCRa+u65Tg9mGXgKc0+C?=
 =?us-ascii?Q?rc1IsR4ThIu9kukOnjjMhrU+wmJHNvEhDsR4nMPZIEjhLrwWYb3kB/+HVyCb?=
 =?us-ascii?Q?MBWxqTvCAZHPaVyNDjT1iq4ZgXpbFArARtaKxTYypNSQKtM+r9Jz9/NNwmii?=
 =?us-ascii?Q?hZ3ttyvTlTVyAyJZj8P4KCqIoUr45ynyVZVviOs7cmkNLPA8JYXXpm6wvW9Z?=
 =?us-ascii?Q?WZ2s28EjpQWx3IP+3Fy/HtPGYV3QKxwW8oPiDgGCH1BI0bZ/DZ6ipqH/Kyf4?=
 =?us-ascii?Q?fyOSgGYpdYO7UMfLa/YZdULXQUeTnoE/0hmd0lZ34yDIfM1fugmyYDugHCMT?=
 =?us-ascii?Q?g7RIspZJpzOGd1ZLxQF1g+DxFiz/satUULLx9BOqvT7x+1vymfjt+0ifarjX?=
 =?us-ascii?Q?BIX7pfNHPFE4DveQvTawrvkSUo9ntvwvBmxjhRNMGiKBnFq+B3W5bIM2ip+j?=
 =?us-ascii?Q?1kxMwsrjNI4dIATFfKIgdxlWjn6K0vc9swgOaRyc0PDOM7I6E3OSVDdMuvBX?=
 =?us-ascii?Q?JzzNIx8x6HJMXkPT7l/C5wo9kdB8fhVzl8PjoxZa/Ew1ewQcubpcP1wT8bUH?=
 =?us-ascii?Q?VastL5Xv8CPuGgzGiCx7msWekEd2L4ZlA3P6wMhO3ODw4M8fjx6flv+QSS7v?=
 =?us-ascii?Q?Dy/YUG4TPfJhGkVChaz1xGlKO6djbNqdehAtdWC84Pkj7+HJa0gWGKhqipuj?=
 =?us-ascii?Q?B0qWVvhpsUm+Nyz0IVSBqiMVoW/2U/TVvwD+1MdO?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR18MB5314.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c022e5ac-83d6-4f87-b6f3-08dc418924d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2024 05:07:26.3385
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zBGZxcRRAWQW9LB3PMqWmpxSvQtBWRGwjmOgg9ArYAPaFCwmS/b/A0oWZcj8I7Ay/hh8hFenQAztx8Xww8oGeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR18MB3846
X-Proofpoint-ORIG-GUID: TFcglRSCdfej4dL7QZmkqFRftBqBfg9Y
X-Proofpoint-GUID: TFcglRSCdfej4dL7QZmkqFRftBqBfg9Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_02,2024-03-06_01,2023-05-22_02

Minor nits

> -----Original Message-----
> From: Stefan Berger <stefanb@linux.ibm.com>
> Sent: Thursday, March 7, 2024 3:53 AM
> To: keyrings@vger.kernel.org; linux-crypto@vger.kernel.org;
> herbert@gondor.apana.org.au; davem@davemloft.net
> Cc: linux-kernel@vger.kernel.org; saulo.alessandre@tse.jus.br;
> lukas@wunner.de; Stefan Berger <stefanb@linux.ibm.com>
> Subject: [EXTERNAL] [PATCH v5 05/12] crypto: ecc - Implement
> vli_mmod_fast_521 for NIST p521
> =20
> ----------------------------------------------------------------------
> Implement vli_mmod_fast_521 following the description for how to calculat=
e
> the modulus for NIST P521 in the NIST publication "Recommendations for
> Discrete Logarithm-Based Cryptography: Elliptic Curve Domain Parameters"
> section G.1.4.
>=20
> NIST p521 requires 9 64bit digits, so increase the ECC_MAX_DIGITS so that
> arrays fit the larger numbers.
>=20
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> Tested-by: Lukas Wunner <lukas@wunner.de>
> ---
>  crypto/ecc.c                  | 31 +++++++++++++++++++++++++++++++
>  include/crypto/internal/ecc.h |  2 +-
>  2 files changed, 32 insertions(+), 1 deletion(-)
>=20
> diff --git a/crypto/ecc.c b/crypto/ecc.c index f53fb4d6af99..373660e7b19d
> 100644
> --- a/crypto/ecc.c
> +++ b/crypto/ecc.c
> @@ -902,6 +902,31 @@ static void vli_mmod_fast_384(u64 *result, const
> u64 *product,  #undef AND64H  #undef AND64L
>=20
> +/* Computes result =3D product % curve_prime
> + * from "Recommendations for Discrete Logarithm-Based Cryptography:
> + *       Elliptic Curve Domain Parameters" G.1.4
> + */
> +static void vli_mmod_fast_521(u64 *result, const u64 *product,
> +				const u64 *curve_prime, u64 *tmp)
> +{
> +	const unsigned int ndigits =3D 9;
> +	size_t i;
> +
> +	for (i =3D 0; i < ndigits; i++)
> +		tmp[i] =3D product[i];
> +	tmp[8] &=3D 0x1ff;
> +
> +	vli_set(result, tmp, ndigits);
> +
> +
> +	for (i =3D 0; i < ndigits; i++)
> +		tmp[i] =3D (product[8 + i] >> 9) | (product[9 + i] << 55);
> +	tmp[8] &=3D 0x1ff;
> +
> +	vli_mod_add(result, result, tmp, curve_prime, ndigits); }
> +
> +
>  /* Computes result =3D product % curve_prime for different curve_primes.
>   *
>   * Note that curve_primes are distinguished just by heuristic check and =
@@ -
> 941,6 +966,12 @@ static bool vli_mmod_fast(u64 *result, u64 *product,
>  	case 6:
>  		vli_mmod_fast_384(result, product, curve_prime, tmp);
>  		break;
> +	case 9:

Can we use ECC_CURVE_NIST_P384_DIGITS, ECC_CURVE_NIST_P256_DIGITS  in this =
function?
=20
And define ECC_CURVE_NIST_P521_DIGITS, which is same as ECC_MAX_DIGITS defi=
ned below in this patch?

> +		if (curve->nbits =3D=3D 521) {
> +			vli_mmod_fast_521(result, product, curve_prime,
> tmp);
> +			break;
> +		}
> +		fallthrough;
>  	default:
>  		pr_err_ratelimited("ecc: unsupported digits size!\n");
>  		return false;
> diff --git a/include/crypto/internal/ecc.h b/include/crypto/internal/ecc.=
h index
> 4a556b41873e..de17bcdeb53a 100644
> --- a/include/crypto/internal/ecc.h
> +++ b/include/crypto/internal/ecc.h
> @@ -33,7 +33,7 @@
>  #define ECC_CURVE_NIST_P192_DIGITS  3
>  #define ECC_CURVE_NIST_P256_DIGITS  4
>  #define ECC_CURVE_NIST_P384_DIGITS  6
> -#define ECC_MAX_DIGITS              (512 / 64) /* due to ecrdsa */
> +#define ECC_MAX_DIGITS              DIV_ROUND_UP(521, 64) /* NIST P521 *=
/
>=20
>  #define ECC_DIGITS_TO_BYTES_SHIFT 3
>=20
> --
> 2.43.0
>=20


