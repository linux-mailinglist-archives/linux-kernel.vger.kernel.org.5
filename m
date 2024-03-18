Return-Path: <linux-kernel+bounces-105714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD0B87E358
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 06:48:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E869E1C20DE3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 05:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 049BA2209B;
	Mon, 18 Mar 2024 05:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="PLAHcyR3"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3883219FD;
	Mon, 18 Mar 2024 05:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710740897; cv=fail; b=ZNQ8/TgyiFg5T4UjKGaXHE1gXRHHX+2TYIA0LXk90WrjdpV6nj2LEdokUZPaHU/KMsXor1LQcUWJoD50v1lJnwo1+a860+0yeC/HogD4SHMkQg5y7Q1WVPrGwri6loYCGmwVEeca9lY2C92dat96Dqky56Q9btc4RbBKIvLW2XQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710740897; c=relaxed/simple;
	bh=1SL6dYvJ+SiEZThpIuKUg5+XVkzewA1bEWLG6VuAniI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=B1AyLXeN7UuAFunSKM9A8HTIQ3gebH9O+76Z5Y1v96yp/S1Z804bUxZxBKGAcowNMxdI/9D0PTM+4T8s36Y/9BH0IcyeIYa7IhJlSivAQ7osPo0f4YXf19EwDs2/gGZQioQSIMn0tXThi5fdanMX8jmdqX4J+TYREF+8OPzAaq4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=PLAHcyR3; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42HN1L3A032363;
	Sun, 17 Mar 2024 22:48:00 -0700
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3ww8skm18u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 17 Mar 2024 22:48:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AIoU0KTgKBAyOPhORVeSDrNUvj2AHJdILB/p4eBPiZHjWjPHkpl4k5qP++6vWPW5VVnsvNbWGOo7FE7oEvXi8ZUsiXPzTK9lqb+nupRWdD4EQ6vf7MR0mc0OgOlbdxZwr4QQTu4ml5dZJwIfgRB5ExmnzpzamPIob2L61jeMkZ7XvnX8kHRFO5DpiQJ/C1sH+0WhzvNiOUf6dW82rfoP/oPbX6Sf46BHx69jzIFlWOCWP/l3IVM4uHnimalwIbrg/7P6nA3I9lU3TgZMxLGzhWfvRp+IT0068lwJVsqwmW84RdBdFParFQNpamCljVHzZ/tv0rSjqVYM8pVx7nKkIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Qjkf2rtVCsRvLPxj16IyiUHy8QtvawTUOmaxZRF35M=;
 b=Teb4E5wO8BdZV5/vtjIZlT4wJ0aZaDfyM9k4ew4sVNSQlg9IlLmm/XKTss/9EQD8YFPsMOI2MJnOZIKoS2E22MR9qg84KtlPaupfEOLVUW1o7sROgzbQxwMBSLbzcUQ1JQJ74n1IuwNs6ez0xhHaRfJnl7UelVHDyxjJZnyY5JejvhIUmnhLtz+Ac8J9ZlCMsfhIurC+lnFdCPvcIuD7iP8ylmlIbJ1M1kmBF546fcpEP0+oVLD2XxqEMP+RJBtbCrGcDwej+7pejnh/923iO8Ic44DRX7FaSpHNKoC8aV7Xmv4dybdi3eWxiS+xcfz5vub0GpaGQJeOPskcYjBLYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Qjkf2rtVCsRvLPxj16IyiUHy8QtvawTUOmaxZRF35M=;
 b=PLAHcyR3f8usFGV+AHvOfaTpVHFHklcN+b4bubXctILePe0e46Guw2z437dTNmXHR69TzOzMWY/U1n0eR416gZaPOd2b9oixddD8T5tBSCvOavi8jSn1fh7wiLk1Yc8D9yI20iCzOA8E8jmmAv8PbXX5bpRyX1hFuu6+HzLaJhg=
Received: from SN7PR18MB5314.namprd18.prod.outlook.com (2603:10b6:806:2ef::8)
 by CH3PR18MB5600.namprd18.prod.outlook.com (2603:10b6:610:199::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 05:47:55 +0000
Received: from SN7PR18MB5314.namprd18.prod.outlook.com
 ([fe80::926a:6eb8:6d4b:656a]) by SN7PR18MB5314.namprd18.prod.outlook.com
 ([fe80::926a:6eb8:6d4b:656a%7]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 05:47:54 +0000
From: Bharat Bhushan <bbhushan2@marvell.com>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>,
        "keyrings@vger.kernel.org"
	<keyrings@vger.kernel.org>,
        "linux-crypto@vger.kernel.org"
	<linux-crypto@vger.kernel.org>,
        "herbert@gondor.apana.org.au"
	<herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "saulo.alessandre@tse.jus.br" <saulo.alessandre@tse.jus.br>,
        "lukas@wunner.de" <lukas@wunner.de>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: RE: [EXTERNAL] [PATCH v6 06/13] crypto: ecc - Implement
 vli_mmod_fast_521 for NIST p521
Thread-Topic: [EXTERNAL] [PATCH v6 06/13] crypto: ecc - Implement
 vli_mmod_fast_521 for NIST p521
Thread-Index: AQHadKxnItlGMkulP0OOPNqggLqEwLE9BMsA
Date: Mon, 18 Mar 2024 05:47:54 +0000
Message-ID: 
 <SN7PR18MB5314CB6B4CF9678BDDF0D012E32D2@SN7PR18MB5314.namprd18.prod.outlook.com>
References: <20240312183618.1211745-1-stefanb@linux.vnet.ibm.com>
 <20240312183618.1211745-7-stefanb@linux.vnet.ibm.com>
In-Reply-To: <20240312183618.1211745-7-stefanb@linux.vnet.ibm.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR18MB5314:EE_|CH3PR18MB5600:EE_
x-ms-office365-filtering-correlation-id: b295589e-0e27-4967-b328-08dc470ef534
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 IK7XwKm/AMfNXL5TgbMZCOjI79keJR0wdRhfgXQKSmM1t5euFlnUdZJVB500cVpmwYlft6sIHCZR0XossudKKk7RpVyMqZY+L6tyJih6S05i+2nVz5PmB48yFaMt+iimOsedSkh7heq9EjcEbH7LYDDP8qLqxg3d1KccMph6ziLMjoaqfbpBYY3hRSQfl1S8AQhA8lWHwy/NDh3wE6x+rrV4qJnb3d4VHRhGGto2KE+ZuIlkFTkSy8J3v1f5CK74aLMqkOlvgfR5j76rRSum8PMsm5pfF7QA1p35sq9bu31PYLpuEKFMRGL6Dro8WvTdm0Y1fHdUJbvjcS6L8ljOXwA3K32lskTzRGpjo0UE2oOBNo7Y6LsubVmA6V1jfrqS0J6PieTGGsv+kWd/C5cjR89LPqV3ZZ+DD42f40hXSOaNMs4ry2U3pEMSPyXSFlzNJf27ImfyRwMdlm8w/c+N4apIw9CYV3wQfGP3MYkbjVmIeT4AyY4vTTuVyvjUA9OU4AcE/77MOF3PkgcOnP7NH7VuOE26g0/NjuFP+h1pICQ1BxjckseikMZOeHUeIJwsOAyf535G7ZLDFR85JFWIu4vfSRkzxzvCt70d5ScCtL0Ko7G3HQBXAcs5AzoA/uzmqt/4iviiIl4L5He5CXUC9O586YwEVupSibEF/XrYURJlD420Tn02azGW/y0HZeeGHOLC7N5OeVk5Rrpsjbd81mrZEOzBCeogs8efznepH+g=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR18MB5314.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(366007)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?Ocq4HdmnO3AWJUWVLhiMT1NpxfVDiAkd2mDpU+H9Yt41RfAQZZMuiUf/BrhO?=
 =?us-ascii?Q?fA4gH7ZTiJQMavl3OFjXcro7ZCy7nVEc0kxL7AHoUzjfGDrNjkUVu0iVbQAY?=
 =?us-ascii?Q?5+L/OQcthF0TlL55f3RqKm/evHR/R5UiFlaaKLGVgkO4P79D0nm0c2czngMS?=
 =?us-ascii?Q?1Q0HzI7Xv/T7xmJkYeJEpGyW7n4tY3wUDEcrAvAdl0DZYHTfk2J4afQcHIkf?=
 =?us-ascii?Q?Ztic3zxa+dT9LD5NU4x++xeiW8bw2cl6qqtG0dnqSBCij+sdw7WFreXjkOlr?=
 =?us-ascii?Q?zsmIckDseXMCo3+e9YwWDZpE0nxMg29ryZ8Y1dhXWfZ8UL16wNb7ouaC5jiw?=
 =?us-ascii?Q?U8jHt923TZwP4poZCfP4QxdAdRSCLlPAyreW6AiOXAgO8KMi1xcJn9Dog7hp?=
 =?us-ascii?Q?DkQPLsgTjFnc9Gn+2P6SMheCrniNawwi+l7QMnUgyG7mR6tKCg4jfQ3VoVot?=
 =?us-ascii?Q?opvTHqXIT4g6VRBB+6Hrk971RVO/6VLTI+O3BddoMNRdkX5BUOAdUjmKbIZt?=
 =?us-ascii?Q?g9x2w2c0oHF4oZFpfm0ckSveHufevSvPdF1KA6DXWFA39HohsZd8/7ZQJEF8?=
 =?us-ascii?Q?UQlHGzpKQjZyPhIdGeXlVlB2MzgKKqLPb793wEJbhbALolGjclKtJMYgyWwz?=
 =?us-ascii?Q?Do2sI1Jve4PPaxs/SZjM5nhflMzje+MAyGqCbLeM/Zwjzn73KE/BjZuC3D2C?=
 =?us-ascii?Q?vFLonOjnf/cFnCwrfc32YoQUuXMWTlHqhp5snNvN2Esc15NzVd685MQPm4dl?=
 =?us-ascii?Q?G2wOMIucBVtlCYrWA2i+l3oX2qdabMH4ou1HSsmZq3iN5HUfYuewdEPvoWwg?=
 =?us-ascii?Q?U/o48jXYJYli6Ju1s3U0+7+PGEoADjl7wphCEgZ7+XkMgV21kRiRq4h8/rqF?=
 =?us-ascii?Q?67xvdtNEJc6+6OUBIKW7t3qALcGd3WHUxs9ULGSQ2tD5up30NLH5puT/D225?=
 =?us-ascii?Q?ZZfOf0EIAmwe/6LVSlT4NMtH02B/yo7kaBS3BF4BNovLGSwsQbBHjOhh9UGo?=
 =?us-ascii?Q?9YPbr2QDxwTlYrsnp3YlpoaMmR58xu65h7Sub4GLaw8V1vNhX16jzxt4hOg/?=
 =?us-ascii?Q?t3vrxIllQtFTYqS5ksm5mL2yzx1OctJeiSHf3GZW44j2xZd8cZzHOezWznzE?=
 =?us-ascii?Q?6H4wkp0Qjjkrb6I+KhYTFto4QjRnPrmUic7hquMbdTb3qx5uMuC4t6GRoxqb?=
 =?us-ascii?Q?rUbqVXvVNHfB0emBtc0Z6nPmIzAnhbSsTl15ihO7cGiGj1btvIfE39Aw2clT?=
 =?us-ascii?Q?OocPmiMFqjyCPONfkQtOug93mRph6+u/JyNzFNJErZKptvwxjiQNYo6lqjIR?=
 =?us-ascii?Q?vQm9U+/gJFnaS1Dzwy3n0oNrIG9D7zY/8U15D2fICNeToJv+Q+1uYuxeO9E+?=
 =?us-ascii?Q?8DjGCdkt0MNTMySlhQJdk1pkd+Ry8UJvSBSiXCM9XIcjHpvilfHwjwMX1FW+?=
 =?us-ascii?Q?38kkX0tnM2N36SkBgw47im9jwIZ9hgEzPK2LNr95I9imOHwV6alCcpZUhAkT?=
 =?us-ascii?Q?Bh7t8eqmRrRs219D1an1VmE7dHyRflRoPNhycSa7u8ItyQQcjK5U5rx4lqak?=
 =?us-ascii?Q?DjyzGofF3qfRJ7CZKfOqQUUSDEkL8YPRyFd+bruQ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b295589e-0e27-4967-b328-08dc470ef534
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2024 05:47:54.8140
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 80y3OfRrBIlFWkEgzZWIBOW1eemHf3Oxbx8KY3VyJTKBS3ziFIVKUYV+nKqqbcwOA+8LaZqjy2garPgsp7e+TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR18MB5600
X-Proofpoint-ORIG-GUID: pMzwvcDGoADjVqXYFcGcP-Mm7mwtU8UV
X-Proofpoint-GUID: pMzwvcDGoADjVqXYFcGcP-Mm7mwtU8UV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-17_12,2024-03-15_01,2023-05-22_02



> -----Original Message-----
> From: Stefan Berger <stefanb@linux.vnet.ibm.com>
> Sent: Wednesday, March 13, 2024 12:06 AM
> To: keyrings@vger.kernel.org; linux-crypto@vger.kernel.org;
> herbert@gondor.apana.org.au; davem@davemloft.net
> Cc: linux-kernel@vger.kernel.org; saulo.alessandre@tse.jus.br;
> lukas@wunner.de; Bharat Bhushan <bbhushan2@marvell.com>;
> jarkko@kernel.org; Stefan Berger <stefanb@linux.ibm.com>
> Subject: [EXTERNAL] [PATCH v6 06/13] crypto: ecc - Implement
> vli_mmod_fast_521 for NIST p521
>=20
> Prioritize security for external emails: Confirm sender and content safet=
y
> before clicking links or opening attachments
>=20
> ----------------------------------------------------------------------
> From: Stefan Berger <stefanb@linux.ibm.com>
>=20
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
> ---
>  crypto/ecc.c                  | 25 +++++++++++++++++++++++++
>  include/crypto/internal/ecc.h |  3 ++-
>  2 files changed, 27 insertions(+), 1 deletion(-)
>=20
> diff --git a/crypto/ecc.c b/crypto/ecc.c index 415a2f4e7291..99d41887c005
> 100644
> --- a/crypto/ecc.c
> +++ b/crypto/ecc.c
> @@ -902,6 +902,28 @@ static void vli_mmod_fast_384(u64 *result, const
> u64 *product,  #undef AND64H  #undef AND64L
>=20
> +/*
> + * Computes result =3D product % curve_prime
> + * from "Recommendations for Discrete Logarithm-Based Cryptography:
> + *       Elliptic Curve Domain Parameters" section G.1.4
> + */
> +static void vli_mmod_fast_521(u64 *result, const u64 *product,
> +			      const u64 *curve_prime, u64 *tmp) {
> +	const unsigned int ndigits =3D ECC_CURVE_NIST_P521_DIGITS;
> +	size_t i;
> +
> +	/* Initialize result with lowest 521 bits from product */
> +	vli_set(result, product, ndigits);
> +	result[8] &=3D 0x1ff;
> +
> +	for (i =3D 0; i < ndigits; i++)
> +		tmp[i] =3D (product[8 + i] >> 9) | (product[9 + i] << 55);
> +	tmp[8] &=3D 0x1ff;

Can we get away from this hardcoding, like 9, 55, 0x1ff etc.
Or at least add comment about these.

> +
> +	vli_mod_add(result, result, tmp, curve_prime, ndigits); }
> +
>  /* Computes result =3D product % curve_prime for different curve_primes.
>   *
>   * Note that curve_primes are distinguished just by heuristic check and =
@@ -
> 941,6 +963,9 @@ static bool vli_mmod_fast(u64 *result, u64 *product,
>  	case ECC_CURVE_NIST_P384_DIGITS:
>  		vli_mmod_fast_384(result, product, curve_prime, tmp);
>  		break;
> +	case ECC_CURVE_NIST_P521_DIGITS:
> +		vli_mmod_fast_521(result, product, curve_prime, tmp);
> +		break;
>  	default:
>  		pr_err_ratelimited("ecc: unsupported digits size!\n");
>  		return false;
> diff --git a/include/crypto/internal/ecc.h b/include/crypto/internal/ecc.=
h index
> ab722a8986b7..4e2f5f938e91 100644
> --- a/include/crypto/internal/ecc.h
> +++ b/include/crypto/internal/ecc.h
> @@ -33,7 +33,8 @@
>  #define ECC_CURVE_NIST_P192_DIGITS  3
>  #define ECC_CURVE_NIST_P256_DIGITS  4
>  #define ECC_CURVE_NIST_P384_DIGITS  6
> -#define ECC_MAX_DIGITS              (512 / 64) /* due to ecrdsa */
> +#define ECC_CURVE_NIST_P521_DIGITS  9

Maybe these can be defined as:
#define ECC_CURVE_NIST_P521_DIGITS  (DIV_ROUND_UP(521, 64) /* NIST P521 */)

> +#define ECC_MAX_DIGITS              DIV_ROUND_UP(521, 64) /* NIST P521 *=
/

/* NIST_P521 is max digits */
#define ECC_MAX_DIGITS              ECC_CURVE_ _DIGITS

Thanks
-Bharat

>=20
>  #define ECC_DIGITS_TO_BYTES_SHIFT 3
>=20
> --
> 2.43.0


