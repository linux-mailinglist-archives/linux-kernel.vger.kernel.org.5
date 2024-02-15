Return-Path: <linux-kernel+bounces-67555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1161B856D68
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 20:12:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB25528B39A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 19:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12A9213957C;
	Thu, 15 Feb 2024 19:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="iuoD1yCq"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA513D6D;
	Thu, 15 Feb 2024 19:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708024350; cv=fail; b=nAL+51w9tlUwDJGQ/jrFMFHSpV6kU6aWO2FJJ+4gHmUxQP4n1dLYhkjoon3qbRoXXSi9RNgQuRJbyyyNOV0ZvmjIwjHz60+Wpmg7pTj8qk4U99m3pmWxWRVkGB1uhTFq73ONs24xLLp498k3QRnqiZ+jtP1q4tl+qUstpR3WLs4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708024350; c=relaxed/simple;
	bh=oAaeuPZVB5lQRutKcJCX7W1uiJabRPXzCVns8lPMl+I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=o97cklQL4++SSh75f+PerQ7TdvIIyN82viMTMOJYU+230bDG64/eq0/8UUAq14ftcI5THnqTYQ0nRJd/p3yb2Ou/EsbxoYDkBz5RG5AOg4uj18ZX1b52Rnzi2cNYQp9hAiDlW+V5hynpbq7UW1j6xDqDoI0twMtAXi2dgihtFYQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=iuoD1yCq; arc=fail smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41FEej6s004619;
	Thu, 15 Feb 2024 19:12:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	qcppdkim1; bh=zuneUZzDvc4D+vtUHkzi7jdTpJCeWqlakNONJFBV8bA=; b=iu
	oD1yCqOhNks0Lgeh+JdELwEwKp/6uCEJ6ruVPxD5rersBg7DsKml6lPTWKCTNiI4
	uYnd0hJG+D2r3ZxfbE85nAKvjA0/CGSbOAhfNH9oeqjKkvrl6GWSHR3o26m3CLm+
	W2HkiwHBJTi7TkHnBFtI4j2Zr3ucK6swmjykcyOook7MTGSc+wE4ePHQnQ/oCfhu
	PF9U2sPNObUjImjxTSIJT7SIZzSt8WsRV3YBZUtNWknsC31TMqV32shCrwjm2NSH
	fl//Zfp3hxqCIm6cjGa4Ofm31VEqbnjEesL56vUeXXlhsD8n6UbNzkNpKxT43gAg
	3AgvSm/k5lmvcrPG/gpw==
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w974j2han-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 19:12:25 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YXh/jbSjt9Q9tGk3LcCS/F8n0aZ7PBt58tvjUgFVFGalo53oS43gsPuC56qh4Rb0O9K4QO+xfuhgApBE6/g/rdNPEkeadgZH2IxkjvtQJSipHFUDJE3KOSj91a4j7VNMEwEzQsx/IdW4c1YZLnqRBRIHxaNyHswag1dc64f8gM9hujROF0OcVJ+AeTM8AEcRC+ol8TH4pRW2MPWphiNPg8ZKpRSyj6wpIfnC+C87Te7qoARkd8yfKvIpv9vx9iWp2VuPYvpTUGOYkCQ2KQiQ4j1fExNPsVUIpFyO/wMJsHk/s/WkWZWUw6lP02eJRSgGZ6Ce6MVzu0c+ClS96ajwjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zuneUZzDvc4D+vtUHkzi7jdTpJCeWqlakNONJFBV8bA=;
 b=jDp38kJ2wD3YPqyekrrl+3OH59ebkVG3Saajcs7T0jtY+YCauMnniJaa7ShqHhcme8WVx/xka/5nelNRQi7/jLBOfyjNUKoEADySW0ON5ikic9G9+l34CyVGv69aTqGnaSKf7ZHKmhdo+qWw5yabUY8LnvVh7hxkVgJRv2CJrHOs2z6AIiaczT1m6I3bG5x2/RWNrndG7JBxlijSBqxWbU6U3aoVRtyHyL97qRqVaC8cWLyjcdbFgYK9mJTWyPfATznios3FUeibxd0twJRSG1RQJPX4pyCkOhFO4GW2jLo+RlYMsAmWjC+i0dDezTfnm0gw5rNrWd13eYvTR4MooA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from CH3PR02MB10247.namprd02.prod.outlook.com
 (2603:10b6:610:1c2::10) by CH3PR02MB9212.namprd02.prod.outlook.com
 (2603:10b6:610:14f::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Thu, 15 Feb
 2024 19:12:22 +0000
Received: from CH3PR02MB10247.namprd02.prod.outlook.com
 ([fe80::aeb8:113f:f7ec:f9b2]) by CH3PR02MB10247.namprd02.prod.outlook.com
 ([fe80::aeb8:113f:f7ec:f9b2%7]) with mapi id 15.20.7292.029; Thu, 15 Feb 2024
 19:12:22 +0000
From: Brian Cain <bcain@quicinc.com>
To: Masahiro Yamada <masahiroy@kernel.org>,
        "linux-kbuild@vger.kernel.org"
	<linux-kbuild@vger.kernel.org>
CC: "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] hexagon: select GENERIC_IRQ_PROBE instead of redefining
 it
Thread-Topic: [PATCH] hexagon: select GENERIC_IRQ_PROBE instead of redefining
 it
Thread-Index: AQHaYBiR3moIwjn6cE2a45AAryyJVLELxYUA
Date: Thu, 15 Feb 2024 19:12:21 +0000
Message-ID: 
 <CH3PR02MB1024753D597A02B754FEE1D85B84D2@CH3PR02MB10247.namprd02.prod.outlook.com>
References: <20240215140819.1910705-1-masahiroy@kernel.org>
In-Reply-To: <20240215140819.1910705-1-masahiroy@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR02MB10247:EE_|CH3PR02MB9212:EE_
x-ms-office365-filtering-correlation-id: d75be160-f12c-4d0b-025a-08dc2e5a096f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 YAM0lgeAbHexXkkRDDCmh0fstKU7wh5xIHfIYtysxWHahsZO+9YJcoanFjzkV7F/gSjU3ER0t//YsBxQfTEdtY7WxhZnGWPniwCV0ia38sOADXZNaodvSkazEDIMoZyIOVFYJidrqkAsl8yiLvVHj4YYnaBeCkkB7wm0YJeXzQtGC9eqrR8jrn29N+N6SOQaT1gDn5huoZR/Z9xUg/9WI5hdAXwWaSi+hbh8Fls21vDTz935ZYWTDVXQJX32yzO1PZ9oLgLI5QJwlWPY3IzxGWbbRZcemFpF1LJG47q1wOrwkz1sGbkZAkZO4dNiIwe9e2dRp0e9ANi6uG4RCcuuMZSMBx4oFS8+r2nIJlImRIQIiJVdU+de9dIAyghTgpAr/OR6qE8AfefSuFMyGApNCNegKku6VkFQToCj6aZwKcVloUDqmHYLMBdUPAZCJbsVs+p9ZodM1ulzyHzwGqudENB+YPWjhCvZl8/L9Tqm8SoSh3XLrkRn0ogHWsrisDHb3F3hXHQkEjkmwp0ONmlb1KwBvivX2NsfVcfj6rOJwV4yXsotdPtiJsHzhdW5y4oPNbQy++0NOZNtKE9FjxBUQU9l4sAnmuzxv6bTtxJOqzwXDHTEtKwZAJOH3RedHnrY
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR02MB10247.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(396003)(346002)(366004)(230922051799003)(230273577357003)(1800799012)(451199024)(64100799003)(186009)(53546011)(52536014)(2906002)(8936002)(4326008)(5660300002)(8676002)(7696005)(76116006)(66476007)(33656002)(83380400001)(122000001)(86362001)(38100700002)(6506007)(71200400001)(38070700009)(110136005)(66446008)(316002)(64756008)(66556008)(66946007)(54906003)(478600001)(9686003)(41300700001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?k6m+AqSg05wnjVb6/ETZe41dI/mXcFFVeBRd5k6TT/6qWRc9ceyZAkGtkYjn?=
 =?us-ascii?Q?U48pp2j3ZxzkA9CONzuO+HSMCqGGpkmbMN7RJ+lXy9FnL9xXwatvH5xRhmHG?=
 =?us-ascii?Q?lq54x5TgDLSK1vi3bGsQTyI19iytLT6/lAa5z7OMntA5B47zkTPCdPp+SG52?=
 =?us-ascii?Q?kEMxs32NnX9UQZ/+4fuFzw2B2mL4PAzx43PFC8JJuRYLzM2gOpFMLDgN4iot?=
 =?us-ascii?Q?IYt4Rw6g15EUkrLSj3GqbGcgfGoIhIUIfu8LUZ983xvN7ls6sjwjljk9jdBu?=
 =?us-ascii?Q?6aMVpX8Cg5fB5JR0KG6I0oo48KdGHhNdgh93yRiWKlhtrsrt+8b1vYvrOEF+?=
 =?us-ascii?Q?H0uAAH8Ss2EsNSRH8LtszSWMF1Kl9KylEYo8ahydIiVcqxaTVimoW3x5nG7F?=
 =?us-ascii?Q?iVxcb1w/CqvWSyXd2wJcSFwPRjKF7hfPCdYNEy8Gq511O8fqNl2cndsPJBqk?=
 =?us-ascii?Q?xukpF8SExqjAcCQlxlSeOdCi5Aphxg2rcJcbGODs2LLnuJWKZ0Z+NjLIPcvQ?=
 =?us-ascii?Q?E6EToXL6Q8/ow9vX/Xc/ugKwHakgUSHkz/tys0ugc678Xrtqm4CPrc1kw/WT?=
 =?us-ascii?Q?sKlFycB0T2rMqHXgDFvkCG0BD+PRvQv2glyy8IFPGwm2IvM2uk/ye2UqBRb8?=
 =?us-ascii?Q?NzRL6/nujHbO6q+0On9V9xoQRrriy7dzO5+cmGqM7qeeYl2EHhKfIOJjP2VS?=
 =?us-ascii?Q?ZggTcUGmIiUzT4LTnm/w3OWRhUvxndKLQxL0tKfljwnE6+6myfIjbOHGVBfg?=
 =?us-ascii?Q?AHpVL0130hOJMMBaE0YP9orQvcwhhKnufzIg+oTu4Je7eRx8XC7jhSH2WHZN?=
 =?us-ascii?Q?bGy2rE1c3Pt0Bd6DjeGVCtpqwGDK8ZjaGq4tK52tKRvAjh3BKGlsz4uwRvZH?=
 =?us-ascii?Q?rznhIuhL4C72mFZJlVUTmcmReRpWyB/iervSm9/+BjSMBUxh1GRVtoS+at8b?=
 =?us-ascii?Q?ap5iy5D7F1+BtvqeY4zJLQfzMovcYlScbrLf5Lwt4PRC+eOrZgJ4C1TUqSfO?=
 =?us-ascii?Q?6iZbwpJsrADcpwnDau53dOQLygCJcsuzxMxTVkIvmXhyslZe6f0KDK3HPXDw?=
 =?us-ascii?Q?zwaHhKm1Vs8YXnvuPYmQpnNPuEb2o/XajBF7C/pVVScGT5fP3MuOLqF/2wXG?=
 =?us-ascii?Q?oMrcwAwVNRsO3PE/VuPW8oTyax30UYo3UNW5+JisAjZoBs51laqgCzzotJpy?=
 =?us-ascii?Q?eJzTchBYxhhfuCjnGtwaH8UQD0dQezcnsgVi4MvOWRO1mQoM6VrpLILm6Xzr?=
 =?us-ascii?Q?+WVoqnTKGRkwIdMIrAkejugDUmSexynO+EaUMrddpaFtOx+ImvnOQ7KpoKrs?=
 =?us-ascii?Q?rEYVx+agoCLO6XpRbkzfKA/zVPT1RNxvAo+THoaJ1wrI2O6lyzVYEXyqEYJO?=
 =?us-ascii?Q?rdpN8z69EVs7ndNeo8SguzRSJhqjR4d5N8kzToAxR2MBUpR6qXHCjvLqRD4W?=
 =?us-ascii?Q?dx8UqIwSl2WOvn/JcVzhQncS+nU5hzgtev2rTIBqXL24ZxdxOvuKuXbiOhiw?=
 =?us-ascii?Q?Q4S84WISpZsZqiYO7ECz4VGqv+nYr3sTWyLWYtJsE0FqMSXT76i4aHey3Po8?=
 =?us-ascii?Q?E0s9ppLjIgg7ed78H+crvD3XRY+lW5OU0PzPX6Q4ESKI1Oq39K0rFslyO97Z?=
 =?us-ascii?Q?I9ieFHOuEEdqlwBkZgR4tmY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ubOvLlw9xPEu+Vhr9L9B4dV+B9d03W/PE4Us86upLi1TPOjZccaOW/Bx+D+5R9EJoyy45Yba5caFACFg3Tn0WWxUrkwiu5H6Mv+ZiJ9RCoEqohU64WnvP5py5FHJhUfds9mapsIT9LcgH19/dLmOQF42v3w0spF0hyb/fJX+rVC70oJLu/cyK1zFWj7fIahdjO3cL8fPm7av3eOwDpgEpwUv44pN7K7cuVactzWX0tzbOFJlZG7b3K3+PTWJzaXubNVBn36FtCHRkUqrK3bqYLk2BdyWC1ZIaq1YB/PZkfDQq1kZxUzBoZopvNLp89XhauGAHQ/HrFCxO5r4YvXSlQ0Ul8A4iFa1tIzedve6hZ2OKGjDMBKf6+TBYevwgCl8imWY0tQkyF2LU5cMG7WAOCmpn/6Pt3WNoOYWnQ/Es6joUlCKdQw+Qz0XDkceWpfWQN5N0kyXdt4OiDXxWTO849RwvZZzVNDrWAkEut2zO4kOnYtjkLfnbMsogKIl5fgvgZN2cKHyE5cZch3BrIf1yLcKROwCeVqw6HGcBZeDAxLOEWDNgNO+Bfny1bZ2VP7nFB3HOLLK9jAp9Rm/VcVxNEp14R6YrPMcvBnPynPznxbQ/EW0SPx+sfhn5x+bKTOG
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR02MB10247.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d75be160-f12c-4d0b-025a-08dc2e5a096f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2024 19:12:21.9401
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k4OxxkXamRiyTHGY8kw4OEKG1sfqdLBs1Zx/vijJgmGFL3OCbT2Lg4hUVmoK+FgGl5XPFBYjdN1C5ZbOzjegGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB9212
X-Proofpoint-GUID: Pqvg8H9qYTQG05XfcB0Wkd6pdyjBLU0g
X-Proofpoint-ORIG-GUID: Pqvg8H9qYTQG05XfcB0Wkd6pdyjBLU0g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_18,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 mlxlogscore=359 lowpriorityscore=0 impostorscore=0 malwarescore=0
 bulkscore=0 clxscore=1011 spamscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402150154



> -----Original Message-----
> From: Masahiro Yamada <masahiroy@kernel.org>
> Sent: Thursday, February 15, 2024 8:08 AM
> To: linux-kbuild@vger.kernel.org
> Cc: Masahiro Yamada <masahiroy@kernel.org>; Brian Cain
> <bcain@quicinc.com>; linux-hexagon@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: [PATCH] hexagon: select GENERIC_IRQ_PROBE instead of redefining =
it
>=20
> WARNING: This email originated from outside of Qualcomm. Please be wary o=
f
> any links or attachments, and do not enable macros.
>=20
> Select GENERIC_IRQ_PROBE, as the other architectures do.
>=20
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>=20
>  arch/hexagon/Kconfig | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/arch/hexagon/Kconfig b/arch/hexagon/Kconfig
> index e922026fef09..a8dd2501f39f 100644
> --- a/arch/hexagon/Kconfig
> +++ b/arch/hexagon/Kconfig
> @@ -21,6 +21,7 @@ config HEXAGON
>         select HAVE_PERF_EVENTS
>         # GENERIC_ALLOCATOR is used by dma_alloc_coherent()
>         select GENERIC_ALLOCATOR
> +       select GENERIC_IRQ_PROBE
>         select GENERIC_IRQ_SHOW
>         select HAVE_ARCH_KGDB
>         select HAVE_ARCH_TRACEHOOK
> @@ -60,9 +61,6 @@ config GENERIC_CSUM
>  #
>  # Use the generic interrupt handling code in kernel/irq/:
>  #
> -config GENERIC_IRQ_PROBE
> -       def_bool y
> -
>  config GENERIC_HWEIGHT
>         def_bool y
>=20
> --
> 2.40.1

Acked-by: Brian Cain <bcain@quicinc.com>


