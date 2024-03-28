Return-Path: <linux-kernel+bounces-122752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 678E288FC9D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 11:11:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E20529A607
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 10:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BB0F7CF06;
	Thu, 28 Mar 2024 10:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="FeY8g9rw"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F797BB19;
	Thu, 28 Mar 2024 10:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711620699; cv=fail; b=kJwDDn8pJvyrXYhqquL/gApS1qvmowxqG+PlxGneAar0TYD/istVHEcsQKGp6aj2l46zzjAhvu4mkSLnUoecBFbxrr+IyWB4hJEZEEdUsylGI8B6n3F2rEq34pcecJYTyZzQf5hMt/sB+ctJySWZJVA2iQ3RQwf2yLrCdLf5Sd4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711620699; c=relaxed/simple;
	bh=U+9xnppZIxRqcZXBb5r5IfN3yO69VeCscbe9F0B85Qg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=P0G81cwQx1pmI+3L2d8g0u+RoPB4ydm7GUQmsjvIg7nYeZtBEGT/pZirtQiHOOwLxXajH/wmKi1hIzN3EneuNMW3yd2d+J9PMD6WZvMZqlKMn1ixaUJFdrUXROENagc0Dz71VtmX1jQlsZsiZ31U8ZrEqUBPhpjvtrubApFwSmg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=FeY8g9rw; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42SA0rcY019727;
	Thu, 28 Mar 2024 03:10:47 -0700
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3x4v1u3ph9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 03:10:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ItZaSZiBe28Ois83CiXEr1quOUhWEP7Vnbk9nZTsLAJji8lP0e9ryhC730NJBfpCgLr00LHUM5iir133oOYQuIEahV3+h9aEmR2qOLeVXTcyqeSxrxQcWgXspxPco7dIpaieLcDGIBhLfybpq+gxMkNlkKnfWgXWIyjjYBozwcod6f/0qpOLQB5RNDZmqDS9ItUWWvYgKDhZw/hP1GXR9VOks7JSsXuCRajDOJaeTBuB0qTCYgtWmYb3G51m9GVAD6ZDjYzf6UtLCQOQzGwayvD8vZJyY5nl+DVbvk4CHC2POLjjcc0Qx5Qqd4DHgI0cfj39RE345c4E3B03l2iHNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FRadSvUUQIyAhT//rHDbll93rZu8ojT0HHH/scBXggY=;
 b=RWTwuB5BpRIU5Ef4sK4ruHmstUvRQMv9prqjfHNNCvG2iWGYL6A+Nlzd3egiuAFx20kNGMusIgRSqRCr82DjnA/KAs33IphyDIXcEYeC3NeGwjkty34Hs08coMPXckNvR6EmbhruXfGQi2XgtY/YRRw/s8PKfjalfUw7bgTpkBbsaovieIF02BqVgRmDuJzMUDmYAJIv+WL9YySWCTVViGDAB0WViod4PhQ7TgHRKB5KLa8z1yRmV/V6wioi+t0g0hCKxf5ReZHiBJ+Sb4n+87wfsR6bwlAtH2p0/ttYoQQ5SwtzHdyf8hqJa3FbDNrXjgxEMq4qleNAF5ok6BF4cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FRadSvUUQIyAhT//rHDbll93rZu8ojT0HHH/scBXggY=;
 b=FeY8g9rwY0lXEgNhuWAvL8nqmR4n+6HVu2OdyLhAsrZsOVMuhEM8ZFSGZ3F4U18khmh2o6G8IZZ/6Jf1/AREsfgCaMxnKtl5jHOYolZsa94XD7ON9BF1oYNa4SLd4cC/boxRGZRwaiPjfiOV206a4pGH+fm+TBRw60xJ2Z9rrpw=
Received: from PH0PR18MB4474.namprd18.prod.outlook.com (2603:10b6:510:ea::22)
 by SJ0PR18MB3945.namprd18.prod.outlook.com (2603:10b6:a03:2e1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 28 Mar
 2024 10:09:38 +0000
Received: from PH0PR18MB4474.namprd18.prod.outlook.com
 ([fe80::3e9:f0ca:e966:7e37]) by PH0PR18MB4474.namprd18.prod.outlook.com
 ([fe80::3e9:f0ca:e966:7e37%7]) with mapi id 15.20.7409.028; Thu, 28 Mar 2024
 10:09:37 +0000
From: Hariprasad Kelam <hkelam@marvell.com>
To: Aleksandr Mishin <amishin@t-argos.ru>,
        Sunil Kovvuri Goutham
	<sgoutham@marvell.com>
CC: Linu Cherian <lcherian@marvell.com>,
        Geethasowjanya Akula
	<gakula@marvell.com>,
        Jerin Jacob <jerinj@marvell.com>,
        Subbaraya Sundeep
 Bhatta <sbhatta@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Subject: [PATCH] octeontx2-af: Add array index check
Thread-Topic: [PATCH] octeontx2-af: Add array index check
Thread-Index: AQHagPgKsIiFHV07QkGSwCVqUVX2/A==
Date: Thu, 28 Mar 2024 10:09:37 +0000
Message-ID: 
 <PH0PR18MB4474F0C8213F4DC4E399AE47DE3B2@PH0PR18MB4474.namprd18.prod.outlook.com>
References: <20240328081648.13193-1-amishin@t-argos.ru>
In-Reply-To: <20240328081648.13193-1-amishin@t-argos.ru>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4474:EE_|SJ0PR18MB3945:EE_
x-ms-office365-filtering-correlation-id: 67efe4c6-f510-4553-96a3-08dc4f0f2cd2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 gkv0bie0VTqtrb0jAcnqaVV1ChTpLQBdbZZJWSgKLIKo9FEUlhvQswIac90K7IqEiG4LEEElYKagz1gZjwRJg1+rCIZLqWEykJXEmXgi/d/XyXM2zTBGv9UWGSTnXzajMwpgvPIAKLWUdAeU/TgWTkIdcRMVHA3wp93cIU8SwtnIGaU4lcyHFg8r4zu5GAMR0X/lfFSRCVMRteZA+EmFv+IYVCMaI6LLHHlhIGExvlKOELQ9tRCAYExdUqUSHneo6An+wCF4YmYAAB9mGr19Z2sJl9VmtzOp/VcphYEzfuvu5i6xoMtJscgX1VjiUFlk/+G9j9XDJvcIdbe2cF1UabLsaUGXVtM9Zy4TnjDsgXIj4wjuKER9Do6tRz/CwA459EzbfTrcQ6XeNo+ayAnhU6yVTbC77MWIUYQeZ0mogeGjtN2WfoHbRmaBcvMa+Am4MnRfPznMrzDgTz1NKiRYIlw4CyoYEs0ubsSvKmzclK6UBRyn+dJ+KNnJXvFHReLoKpIBTX9THJQYoAxgOuEQJqLO8Xt/J9ta/O0FHPB4iFsxX6hUD6MmNQqP4RArXeDSlCCO7I2k360FQabhJ8twFxZ27xEHeAmw8qaxyqou9ovCRplMSV3MVCd+ydN052ar//XAxgXSbHc4eLczqVJldMejKj1s7jWkQe8KkTVKkg+cAg8E8mrGcXJezAj/FlWZhiYma+2TNp4sn+OEktCp9Q==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR18MB4474.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?YRJMDu85EpGM35GL7020lr6i15QxASgRYcFqfJBBm6zfXbSdqywwYcOJVAEP?=
 =?us-ascii?Q?SW4MvgKuuhuaGVLLrUOHdla7F8VNbpHzh/HTVO0mVbsSoyeJgGdjFQaK3sLy?=
 =?us-ascii?Q?io+JDv4nWSgsZNaROChGCKse7BOsq/FSvcbpQag0UecjUdjfglYsZJcRxO/L?=
 =?us-ascii?Q?FrrTDtCPgLfsJ0792HqHND7jD8hyYkClEPrIv5i4lUyXRxJ5YUhHcz9KMqwW?=
 =?us-ascii?Q?rnjau65cB2SUAMOx/BHjfO0yafXFWPtd2C5NRPW1QhoX0H3t9WVYLQgBQ1ES?=
 =?us-ascii?Q?mmNlrYVd8RDn1J8wM3riEH2H6bv3FYzpLcDVq/jTm4eoh5hXqH0+GoyTw0Cy?=
 =?us-ascii?Q?0FlsrfqgaCpIPkfZ06xqaXgxalOmCRgtRgb8BB0CqtixfOdmcCz7dIXf88BV?=
 =?us-ascii?Q?sq911FMAWUijBOVfLNesjL5M/GBYdZr60ahF8HW3a2FzpLEbht1NoOh5gB5s?=
 =?us-ascii?Q?6VwRWa+iolfZ2RfnT6jx6cKP5IH7ghkXcDf5vv1Gu/2q1OavNQEI+e8jCEB8?=
 =?us-ascii?Q?gJMTH0PhF+U3EEjvKfmtuX8i5edNXjpBBL8F0803qlRklOJ0phpf6X8tivmq?=
 =?us-ascii?Q?7pfIkhBqe10TUMeQOsTatu68DwHO1qIu2g/J/+HV+Z47eqNvpE/SWFBI97aE?=
 =?us-ascii?Q?GqsxMr/ijLP+VMJQY4Kd6qhshKGgErP/UUKS0jTbFy6OVGP24XBye8pQkZQj?=
 =?us-ascii?Q?tDOHkAC94y9XunJ78p+w1HM3Lktnytvj2CcwsQvMbASqos1XSXhLgF1AOVK4?=
 =?us-ascii?Q?3XmdAY1ntDW091yWm2/BdsNt8fik8YbMBuMksXuvEXopmFGUzXArl0q+JcE5?=
 =?us-ascii?Q?MlFxtp4s/Fdwc813mRFj+gL4dLmp/s6tJsQp0/Opr2ZbN+6vVi6lEjh2VIY1?=
 =?us-ascii?Q?lksejW2r00NEHmR0ijeYNt+l3ekLzF0B7/mQLiFBnHXv+SSpbzsMWqWOJTuW?=
 =?us-ascii?Q?/VNV/UIRMEYQNt+Veg2IUypqMHkS99JO/95Dhwia7ODXeN6xi2B2npHB7EnQ?=
 =?us-ascii?Q?1+PtoKSb0y0RUq2X0NNFZXjo3/QCFJALpJu+6Hvr6Aj24Rh8xElb8DngaahB?=
 =?us-ascii?Q?G8Zs954/NxsgzI0OIUcQivhNKsZuWtBH4VeCIVZSXbNE3aor2Ity/yru9oR2?=
 =?us-ascii?Q?gFPU7tRqkKSNLYMxbNtpKjBR+CJgI0nuxAOMq316uOv5oscPQmm1oNS8Ve3k?=
 =?us-ascii?Q?33hU6Ro8VPsHrsJ7ysYv0ktfN6JPm28mWa+BS1NPd/q7i41INrTg9k37K7iX?=
 =?us-ascii?Q?38hKbx816E7PYzu3Ta9yQq9mgl5c3cOBkV3TSD7RCrUI3cDtOqD119PtZb0q?=
 =?us-ascii?Q?GEcPqblF5W6K1xyJPfp6Hf0CcxvXxIT+SZf3hWhadsMN+Oqb8vuU9fXZsNvC?=
 =?us-ascii?Q?BijbaZn/e+QyxQ/oFTeWROfCwBKL+APfxTBNTXGlLGdG9BCMu1Yweb3lMKzE?=
 =?us-ascii?Q?dwVn3guvRQ+Bi3VtP6RcOkKVrELqKBaS5+06jVF9TRsAZkhM+f9qPWNGKxkG?=
 =?us-ascii?Q?Y2LdO2wGZgFJe7dmjnja1gnDURNhLu+WCbNAKijZDdGFEJl7UQRO6Cr7lMEe?=
 =?us-ascii?Q?P8efjxEA23QvTlBjGHROHQU5ZGyL0zQjIKmub4V8?=
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
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB4474.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67efe4c6-f510-4553-96a3-08dc4f0f2cd2
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2024 10:09:37.4237
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yRoHNjFp3gGIw0aDk4FOiPNztoSqtNOgQRnWnsdWWCOXzAa78TQ98D7hIIRhuiqulzGM1ZyXrI76EJXhpp7m2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR18MB3945
X-Proofpoint-GUID: YEjKUNIFnjrGSaRDdy_LkimgwtIg-FXC
X-Proofpoint-ORIG-GUID: YEjKUNIFnjrGSaRDdy_LkimgwtIg-FXC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-28_10,2024-03-27_01,2023-05-22_02


Hi,

> In rvu_map_cgx_lmac_pf() the 'iter', which is used as an array index, can
> reach value (up to 14) that exceed the size (MAX_LMAC_COUNT =3D 8) of the
> array.
> Fix this bug by adding 'iter' value check.
>=20
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>=20

Since it is a fix, please add "net" to the subject.

Thanks,
Hariprasad k
> Fixes: 91c6945ea1f9 ("octeontx2-af: cn10k: Add RPM MAC support")
> Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
> ---
>  drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
> b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
> index 72e060cf6b61..e9bf9231b018 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
> @@ -160,6 +160,8 @@ static int rvu_map_cgx_lmac_pf(struct rvu *rvu)
>  			continue;
>  		lmac_bmap =3D cgx_get_lmac_bmap(rvu_cgx_pdata(cgx, rvu));
>  		for_each_set_bit(iter, &lmac_bmap, rvu->hw->lmac_per_cgx)
> {
> +			if (iter >=3D MAX_LMAC_COUNT)
> +				continue;
>  			lmac =3D cgx_get_lmacid(rvu_cgx_pdata(cgx, rvu),
>  					      iter);
>  			rvu->pf2cgxlmac_map[pf] =3D cgxlmac_id_to_bmap(cgx,
> lmac);
> --
> 2.30.2


