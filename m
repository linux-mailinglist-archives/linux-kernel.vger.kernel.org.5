Return-Path: <linux-kernel+bounces-156977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD2A8B0B12
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 262E61F25F19
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 13:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861D415ECF9;
	Wed, 24 Apr 2024 13:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=BLAIZE.COM header.i=@BLAIZE.COM header.b="fbSgUVCP"
Received: from mx07-0063e101.pphosted.com (mx07-0063e101.pphosted.com [205.220.184.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065EB1649DB
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 13:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.184.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713965600; cv=fail; b=reSKmR5P9gBKdo1BOzYrrKwH91R0KuEWU1fE/ubDYOMyihF3UF4i5wsp56IMLJISs/5vF0UKlp66Mi/SAXXRTQBd3IdV8uH9y5dq8QRJbrOmnPIZPHg2xKcd5VyBxlxRhETZhkfqBpYNBQ7/sAS84Bl4Cpa6aqoJDfcsrg4L/wc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713965600; c=relaxed/simple;
	bh=XQuemze18hL5WJYul/UFirwwpMQBlraJyUm2g7AQnf8=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=WjavKq1lA7ZanJQSEmVuDnEUm5zFPtoybziSeL03yTG0nB0Z2G9jl1n122/XKlRO8tvC432KSXRHKXlZofRW08YJO+u1IQa52hHMBlfK62B/o42rrg9xtYQxiD7N+ktexsjNcPsTLu+yXcuvNqQdVBuwq30iO8OOBkDmT9fef4o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=blaize.com; spf=pass smtp.mailfrom=blaize.com; dkim=pass (1024-bit key) header.d=BLAIZE.COM header.i=@BLAIZE.COM header.b=fbSgUVCP; arc=fail smtp.client-ip=205.220.184.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=blaize.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blaize.com
Received: from pps.filterd (m0247495.ppops.net [127.0.0.1])
	by mx08-0063e101.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43ODK2Z9012433;
	Wed, 24 Apr 2024 14:33:09 +0100
Received: from pnzpr01cu001.outbound.protection.outlook.com (mail-centralindiaazlp17011004.outbound.protection.outlook.com [40.93.132.4])
	by mx08-0063e101.pphosted.com (PPS) with ESMTPS id 3xny4n8uyq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 14:33:09 +0100 (BST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nFGU6dxqnTiuNm42oLKtivym9lhPiTGuVfaKSDxwKTsh7ZxWnMwe1B/shJzAzfhKkMc5ifR1YGAMHH5PMGE/TU72bAWHfAlwA0ZvEdmCSLQefIaTH3RCSlVxxSFETvvdkba9JvP8lW4aHmDYCKkmPYKWxDpBWiu7f59IPLr4LsKy5bxty+DrgBJrdwlP7dEJuwCqwpwTUqGMGODRlH2fP6lFfy763Oa5ApmFkzOf8YF2p+trBGrmHKS2faFTkx2KDMrZrfCETVYqLiE5bde7B8hPf2nxBGBFHCQAa/+A3YetO9a4zFp2t4CyK6qp0w3FpWl/0T9xASaDfLXda9I6sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aF0WyQ4JYjWoLDkS4wCJY4/YhZqIeP4Tad4yCLMjZrI=;
 b=OWFCtAhJ9G1lPzgnUQl9H37VT9+vKY8fiJ7lPw3cOgdL3dWVL4MoZj0Q4oBf0zyTXOYKVrX8GmWRRN6F6FIY9plkmsSCiCPRo+/GF1BC3alOhmuZtpAn6Ewtk6N/9Ngyc56CAArKrzUAy135456EjcSArSQhmRMw/o524km7ZzlOxom7pYCPAyajn1eTexq04sjcWj5JxI3XQ0RdxyfPKBzh8XF3sej73uSDtb3d7C5YUKtV5XI/Jyb5eSbp6Dfaq6AlEMTIjWhnDvlC9dRmsPtQ1R6Vu2lDx0QjwrtB2RSuahYUgOV9UAqxHPmhZhFH/NFoqJtYsSFBP/XiXd9CkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=blaize.com; dmarc=pass action=none header.from=blaize.com;
 dkim=pass header.d=blaize.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=BLAIZE.COM;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aF0WyQ4JYjWoLDkS4wCJY4/YhZqIeP4Tad4yCLMjZrI=;
 b=fbSgUVCP6clQ3SHl22ERSBFuqa4LDf2zn3b1PgC2nf0JI5R6/Geg26bRBP0oGYvYC/AHFbUr8tpaqjta4jhVLwAFepN0EluSLTvMfzF2R1bqpyCHRXQ7FoIPO7d56cPDFhvKLiDQq1uKLU+j8hzGvPhI88dcTqvO+xH35mV9xos=
Received: from MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:12a::5)
 by MA0PR01MB6106.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:7a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Wed, 24 Apr
 2024 13:33:06 +0000
Received: from MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::309a:12cf:74a4:5655]) by MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::309a:12cf:74a4:5655%3]) with mapi id 15.20.7472.044; Wed, 24 Apr 2024
 13:33:06 +0000
From: Niko Pasaloukos <nikolaos.pasaloukos@blaize.com>
To: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Niko Pasaloukos <nikolaos.pasaloukos@blaize.com>,
        James Cowgill
	<james.cowgill@blaize.com>,
        Matt Redfearn <matthew.redfearn@blaize.com>,
        Neil
 Jones <neil.jones@blaize.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Subject: [PATCH v2 5/7] arm64: Add Blaize BLZP1600 SoC family
Thread-Topic: [PATCH v2 5/7] arm64: Add Blaize BLZP1600 SoC family
Thread-Index: AQHalkvwD4tD9Lm2K0+1pUmXOMgbVQ==
Date: Wed, 24 Apr 2024 13:33:06 +0000
Message-ID: <20240424133253.19240-1-nikolaos.pasaloukos@blaize.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0PR01MB10184:EE_|MA0PR01MB6106:EE_
x-ms-office365-filtering-correlation-id: 23f5dcf6-4d43-4328-0a65-08dc6463131f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?iso-8859-1?Q?kAN6myDtiMOSEZvWiDW634xt1TJyuTPmwHrPddXaRV+CUDx5R8d2AbcjH+?=
 =?iso-8859-1?Q?ugEfuURzlbjLvN+7jG0zlpreY0uJKzMoSn4c4Ne0Ar96mkjv7gVk0KL/TK?=
 =?iso-8859-1?Q?MQk1+ioJBcYcyJGCNpzKyezjoGwiZ6AcS0OaMjHRujilkR/2AGPrOs5JfM?=
 =?iso-8859-1?Q?+GiQvLKOTWPabYIZu9C/Q8cWFjVzC1ZFMa+W6mcQ8N2piSd+7RjwS8EL8R?=
 =?iso-8859-1?Q?wMJZ004gQI2ZQFv0HBeYpzGhzSlLP8CV3oNKzp7GVUEYYbPUNI2AC8NsrF?=
 =?iso-8859-1?Q?hTwkUE/Qg9LtkVM50nqCCTckRa8sRwFIqJ9tJy3bt6DL+be59vbOcRyVN4?=
 =?iso-8859-1?Q?f8g28aFbv/P/k9Un5c5Ymg9KSRv9GWLh+td8MA86WbN6Rs4KoKvpk5loue?=
 =?iso-8859-1?Q?djpN/zzOQ47b9QaiaiGf20TjlWtrHhne/iBJcrZA9a6yIWErKGl4kd+sCe?=
 =?iso-8859-1?Q?Vxd90BhDCYMHsPgXUh4YSqLMCdNsOxqoReKFvJRv9/ROd4Ts6qx1BSVcTx?=
 =?iso-8859-1?Q?TYAjB4G5N7TKQhxkxiIURWEOF44v2GuQXGuxIo0gdfK6+PYXLNumOKxj4K?=
 =?iso-8859-1?Q?v0Qteg0p/8XT9tjQXhAdSUopJP+i1eYUotrSOLXPL63L9J/599qux/sPeh?=
 =?iso-8859-1?Q?UQ0/+8uxGrhM0fqndW0SyL+jC/OUYOUuSSvt+kD3bOcjjoIFgMYsDwT3pY?=
 =?iso-8859-1?Q?NFghMCjWW8GcPhGs3T+JoazRSFDhGjLmioOHOpQ38XWBdwNknvyavYQ2Wt?=
 =?iso-8859-1?Q?S342BCffvYBtHkP87l1K9TFL7T7wFEiZsxBILzm4nT783rII5kUoYJ5pDt?=
 =?iso-8859-1?Q?7HiHLcSETMzNtSsIdMIZxLMphMglbOVfTZf3dcFSZg8RWbRof4uZd6O1wQ?=
 =?iso-8859-1?Q?i8oQ6kWWBBidwCKxPeJXFhqhudn1FBgWf3kOsar7x0McvRIQBV9J30H1Cy?=
 =?iso-8859-1?Q?SBwyzQd61G/abxxPa/FwO616OVLrfYn6JUjSdUljdbnZWP0+te2F9M6ybh?=
 =?iso-8859-1?Q?m3di/vUHLrhBM3TSIQNasR81U99zQTQWG918RWQHZh3JGegKicwKtmVb0T?=
 =?iso-8859-1?Q?d1fv2ys4sY2TYHHGCBAhIoEnEQwBDZcBH/UWqb6DTjiCB2N5Wu62tApZGU?=
 =?iso-8859-1?Q?xiWOuS08niIfgG/XwqtcSkLTIdKNICpgIcYQQW4RRD0UvZaTir4WT43pnL?=
 =?iso-8859-1?Q?lTIXHKWgPjEy7xq/HsLpazG7nYcoB7fZ8T6XvRkO9YTqzdxwjdsDcR+Zf0?=
 =?iso-8859-1?Q?riDWT5rH5CH45CmHMhvZhJTsxjFR0hzbmo5/s+1ZtIezBWCjTh6LkQAwEr?=
 =?iso-8859-1?Q?GWSKkaW2J0JOw8WhsYOTbsOXK/x/G/CLzp5pGAHk/KIuRah+rb45PZEiLJ?=
 =?iso-8859-1?Q?hmXLo9L7uo+KblRnBQTom19GCYfxEItg=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?AQtcvZeMG4oaIbhHlSQ3wkUAsRjHMURHJHCsRNOrPEoOdGZi6ZqSg510yF?=
 =?iso-8859-1?Q?3VzHhkUC2J24kM4wYrKi/R4u+7XW6JIDndjaGNgPGvoEdnVXo8uzkDquqL?=
 =?iso-8859-1?Q?SvUxXOnv2Jo9V7OJVRYloMuFFuk+NUpYmRUlhyg3cE3bsiszAO2k9EdEon?=
 =?iso-8859-1?Q?QTkg/R5GHmKRL8nI05hrxhgRCATpKJkmmG0Z7pPEBjKCtPJKRKBRy/HyPX?=
 =?iso-8859-1?Q?wad5XlfPVN9GKSg5H97yQZfkH75fqHsD3GkP5Q4F86/Nnlh2ZX60Wl5mMB?=
 =?iso-8859-1?Q?nUq+ITxPjcMONipKczR13rnK2xy6ItLKU0mN2FxDoOgFgkSwnyUdD3eh/Y?=
 =?iso-8859-1?Q?h3JVDSx3ZiF+DhEnZNWwi6kYurXDK+5+kMRz1H8jc6Tlu2Q9m52nrR/d5G?=
 =?iso-8859-1?Q?f4qDMXRi+zY83LJWQ6Pm+IjUOenIs+B7tBHcLh/ebau61/yf9PqSKLz0qh?=
 =?iso-8859-1?Q?rEvBC2fYQ9hxPQbcZpVYrtLyPOxTtxQ0pVuDzKhEUCeWHZpbB1ZD3ZGKEM?=
 =?iso-8859-1?Q?Wh0UzWksMHMXE+bR0ra9Pv3CWI+0FbHBL24BCDgKfycvvjbBZsh8FqF28p?=
 =?iso-8859-1?Q?SX5+M9gBlEQx+w9yccMgHT/J1cgpg+DiG5+VpKkw3/jGhHPnqh3GbpzmYu?=
 =?iso-8859-1?Q?vXs3rMe2AGWyc4BaDlVs58PkKdegRMwJ8SDfzCTSfNHfvSG09xz64GYTp1?=
 =?iso-8859-1?Q?hgm/XtxumyYjFRRYMKJ2WwpJVOFz3OBmVJ/Q+4dMVtgUq28kh2BnDFO1Nj?=
 =?iso-8859-1?Q?ZXgCXN/AmwJZ2KTcZQ0YeKBy7KUJi0SoV2yc/NOXwe4uKbxOOde/4vneQq?=
 =?iso-8859-1?Q?HGaYXl9t04ORo0YG7E77bUxO9gu2o3CRyFxCmSRabt/KzGOQRhh0i3JkrA?=
 =?iso-8859-1?Q?o2a4MIOEA+rxMZKukLYdbs4P3Gn+AMRasecaZYq/iNk3ug0cFiPSsS6Xg4?=
 =?iso-8859-1?Q?egPkBt55MAxm2y0aO9Snc/UDV91PCakeicf/XeNkgV1ZuZ9tc9L7tO3w1X?=
 =?iso-8859-1?Q?96u1hZb8IRE5OTRaX4Noxc70yrKKcmJTwDODEet9lQNDPKuYCPy6GCmR3X?=
 =?iso-8859-1?Q?AR+gbDm3SDnqqAi/j3Y/ZIi+yCnJFyg3de9EmAP1DN4kiwJBt95Gbm+oP8?=
 =?iso-8859-1?Q?4TK2eRB5zCm+y8IfUOZDD3INlbSAKAEMyEavplxCu1+qCRIN0vMfQfj02a?=
 =?iso-8859-1?Q?U/nq0c1NpK24laatqUYvxCThaoSpE8HnSRLE59q/gLt0BFo7SZZuUd5Ce6?=
 =?iso-8859-1?Q?B1y9amwBZn1xNb53c/cFViK9kL6WIje2fyOmiRzC4KV4gbpwz8dninycjh?=
 =?iso-8859-1?Q?YhNPGNv7ddqx3XNCr4PtS52Ozg5SMkDuMODmoFxXILLOGoaYC2ssXM/xiK?=
 =?iso-8859-1?Q?p5xgKRcwHdUgnCgL2hsnN7xdlcjlbHM069s4z4ODEsjWYfEloPRXvo1NhZ?=
 =?iso-8859-1?Q?We5XenETqMEcWZeP/4O71mYH5BxMZslr7dgpvnFlATgZvtuGs+VM1OpGLd?=
 =?iso-8859-1?Q?aePdjDxlnuBMR+3jSELyndRv5IlmVLAV9xEYpp+mNVJH8KFZj1cbuU4EJw?=
 =?iso-8859-1?Q?Iaxk1w8cxJfBKeZ6Sirxk6oVu1Vy688x8DlQeVf/PwkOAvBVfOJJLRIKSF?=
 =?iso-8859-1?Q?nSEBQxD2VEyn67+cJBy2r0jb7X2muWOI2yXkbCoCaIvXWFS0BoqjgcMg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: blaize.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 23f5dcf6-4d43-4328-0a65-08dc6463131f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2024 13:33:06.4509
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9d1c3c89-8615-4064-88a7-bb1a8537c779
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5lBTGYCSuCmIC3LUKlIo+Ef1YFDoW9o4uxBAmc04UjcbIBTqWCPVaApTBaRa56dQYyQ6WAr0534LqsSZgRGSjaV/QO8fTgT/dloGsKDgKG8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB6106
X-Proofpoint-GUID: nLJ87KsmPbd9TnfCJz7poxZ_JhyRAWa6
X-Proofpoint-ORIG-GUID: nLJ87KsmPbd9TnfCJz7poxZ_JhyRAWa6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_11,2024-04-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1011 bulkscore=0 mlxscore=0 impostorscore=0
 priorityscore=1501 mlxlogscore=843 phishscore=0 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.21.0-2404010002
 definitions=main-2404240046

Add ARCH_BLAIZE_BLZP1600 SoC family to the arm64 architecture.

Reviewed-by: James Cowgill <james.cowgill@blaize.com>
Reviewed-by: Matt Redfearn <matt.redfearn@blaize.com>
Reviewed-by: Neil Jones <neil.jones@blaize.com>
Signed-off-by: Nikolaos Pasaloukos <nikolaos.pasaloukos@blaize.com>
---
 arch/arm64/Kconfig.platforms | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 24335565bad5..c2a523637b23 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -94,6 +94,11 @@ config ARCH_BITMAIN
 	help
 	  This enables support for the Bitmain SoC Family.
=20
+config ARCH_BLAIZE_BLZP1600
+	bool "Blaize BLZP1600 SoC Platforms"
+	help
+	  This enables support for the Blaize BLZP1600 SoC family
+
 config ARCH_EXYNOS
 	bool "Samsung Exynos SoC family"
 	select COMMON_CLK_SAMSUNG
--=20
2.34.1


