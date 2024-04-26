Return-Path: <linux-kernel+bounces-159933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 628DE8B3675
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 13:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A14E6B22884
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 11:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E1B0145335;
	Fri, 26 Apr 2024 11:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="VtLQF/R0"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7910F13C9A7;
	Fri, 26 Apr 2024 11:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714130537; cv=fail; b=rnx5TP/iseMe1DUO5tSlxfgadlM+ymkRCZ+GrEcQVTQlBg5mMAxOPziaFdkFuOAmHDlhVr/SY0S+ulkWd65JtM48El8ESXbnzSlN2s/Oes3pgTUCOK37DoOG2LQt0DAFrNibfkhSh+fARv91pJlMjCOAmv6FQDkcJ9yW66mT5Xw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714130537; c=relaxed/simple;
	bh=GUoyaUW7yZD0c/JRGqmXlQvwSHywU6At9hYiUxh5aL4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Gx3JEYjbuX1Je5ExN5KEmN/l0h4EpdI9/uvgAAUg//mCXVFrTAfc/K2t5f8Mxo02MkOlji3gDtaGb62PHQq+8UR0v6lDXtqYbDUlTPsNpnOhkpafAs1LUqykdTSytWPk7mj/tEwUOFhxb9N1BMcHLX2IrpVrRMyxYHPqhW64eho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=VtLQF/R0; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43Q6DF31016504;
	Fri, 26 Apr 2024 04:21:52 -0700
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3xpxn1nhvy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Apr 2024 04:21:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WSBjOprKnRFh06ESG6hX9MCG3ooHUJqvIIv/NGqmI4z3VhrH15Cj4xT4LzB3kph5AQM59WVocGGNUO3Akpv4vRV9U6TnAUhN+nZvaYph94IM4FoR3Nwb+larWO5nWUNhLAt5c3wI4shYQzh2z12o1YIOzYTTtnk9WwTbWLocM2jAfSAOfPWEBnL7iFD93UGPk1/Q9GNLSJduzLurbDQ7i2KdNmm+c15Z1M42zt+EPhkAkyuMZFtFM2iLJQ/ALk5StGHoUW03Rb4H5Pzx58sT6OdC8yneTebC4DcAZ3TMcf4olLwOramEkl5duvDh8mYBbUyB//1uGOCTG8H+gfkLow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ngXRJ+uuzcZWc43RxpO358iWSOv9XNaS2x/bBMDOGcs=;
 b=P7PQxpAZ8poOi3ANbeEBI9fBGAjO31RaMEewcz0+QrL5bYzlJY9SZBf9Ju71hF/f/0wg1rqR79NcGQlpNBEDCusK+iNpZ3nieV1gvYqEdfASKiaPUIZ1JoHF2TyEFzGZhc2tsxCDMRX5+PhCiOl7YRFVFlIYsyAoytOa0CWcJn5eiInx9BZIb6NwyAqawZYsrezKmgC65NZeMPsuSqOs5PaGWMjok2Rtl86BcOoMvx0uAUEWDhSUJ31oeAP25uK+d9MJOU+XX+Qg8YGU6P9a/cul6PAPqBp4s3b7PXsfhkbJydiWVlidh5iIeGAJvb9KNUoZxNXOOofwxZtOilghZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ngXRJ+uuzcZWc43RxpO358iWSOv9XNaS2x/bBMDOGcs=;
 b=VtLQF/R0t3z1OibEhg7xeSjFM2LKhfcsl4jiOwtYzyZNPItF60WVDW6fIz3dz5xYIEzd+sd8LqLbrmEbfs/8ZauqUK8TylrOuX3oh6vH3Qz4C+ONDIAIhp1/fAKZZFrYlcFo6KAmgIC76X9VVBwkiXhCVuI7zHtaoFcWKGvIpas=
Received: from PH0PR18MB4474.namprd18.prod.outlook.com (2603:10b6:510:ea::22)
 by DM4PR18MB4271.namprd18.prod.outlook.com (2603:10b6:5:396::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.46; Fri, 26 Apr
 2024 11:21:49 +0000
Received: from PH0PR18MB4474.namprd18.prod.outlook.com
 ([fe80::eeed:4f:2561:f916]) by PH0PR18MB4474.namprd18.prod.outlook.com
 ([fe80::eeed:4f:2561:f916%5]) with mapi id 15.20.7452.049; Fri, 26 Apr 2024
 11:21:49 +0000
From: Hariprasad Kelam <hkelam@marvell.com>
To: Jijie Shao <shaojijie@huawei.com>,
        "yisen.zhuang@huawei.com"
	<yisen.zhuang@huawei.com>,
        "salil.mehta@huawei.com" <salil.mehta@huawei.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "jiri@resnulli.us"
	<jiri@resnulli.us>
CC: "shenjian15@huawei.com" <shenjian15@huawei.com>,
        "wangjie125@huawei.com"
	<wangjie125@huawei.com>,
        "liuyonglong@huawei.com" <liuyonglong@huawei.com>,
        "chenhao418@huawei.com" <chenhao418@huawei.com>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: [PATCH V2 net 3/7] net: hns3: release PTP resources if pf
 initialization failed
Thread-Topic: [PATCH V2 net 3/7] net: hns3: release PTP resources if pf
 initialization failed
Thread-Index: AQHal8vuaXc5OkjYgE2P3Y6eJHWDXQ==
Date: Fri, 26 Apr 2024 11:21:49 +0000
Message-ID: 
 <PH0PR18MB44740CF5F8A3DB7C992A3190DE162@PH0PR18MB4474.namprd18.prod.outlook.com>
References: <20240426100045.1631295-1-shaojijie@huawei.com>
 <20240426100045.1631295-4-shaojijie@huawei.com>
In-Reply-To: <20240426100045.1631295-4-shaojijie@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4474:EE_|DM4PR18MB4271:EE_
x-ms-office365-filtering-correlation-id: ba027c77-0fff-4b11-946c-08dc65e31117
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?U7p5yhGiYIavStubfQoQV6zy5HqLAX5q/bX5zMtbbAIb/fzQJEyTV3jB64gw?=
 =?us-ascii?Q?zAebfv5IQIkPVILiWOVH7JT9jMtsd4jfzb6fDEAujj2zE/SmvUwI32n0s+fl?=
 =?us-ascii?Q?g4jt/4tZDYR/q/n9nRPljf4fKbY7brpENRO8T6LRYwCBIES5CJwwSHfTAO+Y?=
 =?us-ascii?Q?7/DaIWSRQbhKbZ/zGAAHyhXIVESsAVz52x7tfFU9di99saXEVKS/hvLFN+Qm?=
 =?us-ascii?Q?7wfutFl6ZD2DfQhN5uZ4n0PtGJ2/Bg+omRLD6G9wa4yb60zChF16EE3eTLHO?=
 =?us-ascii?Q?SC/TvX9cIAxwlDdtzYmMxycE4e3EIJn1lUfka2ziS1zkCJqMggiAy+nAyDF7?=
 =?us-ascii?Q?nS7IdZMjnZxwqZZawdd/kwPTRCZOqMsw3ZlWDk7if9K2F2d6EVPL/2mUMzHy?=
 =?us-ascii?Q?VpIyQrcXiWnpJjaBMvgttmtP4UfoBbAMhu88VEBGHVKWbsvH7xL+KRIpmr1r?=
 =?us-ascii?Q?fTs7dJHZDSKeVBd+aeZf9huf/qn7QZd1h96aBSaVoSZyvcVR5z2tYMTnqFuL?=
 =?us-ascii?Q?fUf399wnS+rhO2JI+MNZF4M9ILS59xrnNws6MXvh/NyRKt5pWv2Xsz4hnqJJ?=
 =?us-ascii?Q?j+HRrMYU1U4H9Y2YcBWfQGFTd/qyMWCFvIZuHLCdWKM3PdqaiNsRLnGk3gVi?=
 =?us-ascii?Q?qyPt/cUVEbmFwG7sWUuyw7IMUSkfuL7BL/S/LmrcG9EGNOQ6Hk4wGogleiwO?=
 =?us-ascii?Q?4Sx0LpePiHLv4a1W8RqEoEuNVqIRf/GNVw2XaqC7JePjD2yaR1huZ/h6W9tB?=
 =?us-ascii?Q?0L9y6g/X2yDNN6sU1aYCBqk4pjqXhaRgIAqej8HlprL7TTHROAe+/KtWAIlS?=
 =?us-ascii?Q?a0Qq3HVeLFqU7HvSlOWnns5hdMIYbTA7VNtM3fQu44fTa9J0KdiuIscYS/iB?=
 =?us-ascii?Q?RjE0mzu4zvVvedAu93stCeCGb6cOiKdBQU8qV4I82HR+bYE9X+IfJJiGzkEt?=
 =?us-ascii?Q?t+w49osq37X2OHINhpJxqBso8U3ryZYXcJHK5hP6gCxJZmJ6AU5G5vRQ5KpF?=
 =?us-ascii?Q?tm456IUSiL/NPicLHUPA1NX9Hf5u7Y63R9G1W97pOQhBXvrgj/tWkZWfRvTE?=
 =?us-ascii?Q?qh+xXMTUxUV39RWLAcVuHFjZd1Sf186Uv+6z01CIOYc3FDeekEHdGhcLXHbF?=
 =?us-ascii?Q?9QL5dbp9nPTNkq72hIJNm6wVbrfRefg2EgccUw8AqMKw0ZHA25FzdlCNpome?=
 =?us-ascii?Q?JcfRah7f5uMLVKaIIXneaGT4n4LWXMEsHbl9UwOfhmP9TvzXaqYtpVM/b4Fx?=
 =?us-ascii?Q?QGpwrmAXQtaoUkDnbIamJSI2OeUeSuTTyJM74+3cdP+7ut7oDd27jVpJWIE6?=
 =?us-ascii?Q?VTJw8yWY5n8mO5i1nfS//fuMOhO1L3sdjV028Iw6eVOFXg=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR18MB4474.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?euTPLXY+CYaxBY101lrZT3Zh1yyq9mfqU5qGGAInQMwJDjMhDvdnnqzx0dGd?=
 =?us-ascii?Q?QpvSA8LE4JiaD0vu+fA6WNktqXoHk4Tbekmo9xhzjrGeRObTw7PP90laqOEt?=
 =?us-ascii?Q?RaXtzQheR1ycDFOQHsnwnpNB3YVVcFOdj/oSjzZSBSfJmOFWcx4WWYsUudDG?=
 =?us-ascii?Q?Qz/Jfbk/YgNXvBEs+dFLTBLzJBWhzJgwyhQJ063NnuKZjXRUjx4m4ArCPtXV?=
 =?us-ascii?Q?zw8cRT3AhV/qFBiVwH9V5c98vBi5rkt23VTiXaqspO1yQ771mrz6oZs+2OgB?=
 =?us-ascii?Q?d9LIIxJjAiHsDnnt+sBsHo7YiUZmgQ/BH46LjF3Th/SXJ5ru5843s2GU8vl1?=
 =?us-ascii?Q?4FNT4jPAFS7OC4CLj+DGimB7ORL2sI5qIRVHZ0fDA8zbOpaEr04kD8zW3n1Q?=
 =?us-ascii?Q?gi1HW1oKDip/WnzgX6Pu3UtxNllL1LhGElreqmhyqqNwWP+HCNtaQoqqS+1A?=
 =?us-ascii?Q?QhHIj3EwSnFxXqdqNXWlQde3HHV5PrfzosbCRaR6r4SljMuTBcT0Zno5NYvU?=
 =?us-ascii?Q?gJIm/i6E5+/LNrewinuLcmmoqVSQuslRPEIHXLyWHntbhlksLzXgngjBGk1w?=
 =?us-ascii?Q?d3EJ4z0ckCHvW5xzd0FQ8WLc8fCXqsaOXLgu1Tf72C2u3Zh3zAOYhuvq+jCO?=
 =?us-ascii?Q?RCq5rzh3nCIW5s/SC326Wqeh5Nl6hcdCXgbfUhIdespb/YhV0o7EfC75uqaS?=
 =?us-ascii?Q?DhzNI4PNSvPFWfaseGb/Y+3OphGk4M6fu8IbKmqZ0nbr/ZBA92YjRcNjcZxD?=
 =?us-ascii?Q?jMASgGYHTbNdN4GN6JF7HaP8JRVPzTkVP5O8UcPXHn2nSlDu41WQgBKgLmei?=
 =?us-ascii?Q?dn42f2P0aUDBdn3dc1yHOS0glWH0RD2GP3Jx2eQBKHuLcriSKcNHw8rzHVH9?=
 =?us-ascii?Q?BNmYmtSdl0PKzxdGG8+eThldBraifW9Etl4deIatwFv1ZIM8JY4wbqU/GxbB?=
 =?us-ascii?Q?p6AInXAvxvL5/QegN9xPZvGXn1bGi0ZURE6Z39ldR8d0hJxpLZ8J49CZd94k?=
 =?us-ascii?Q?NDdpt438l3dJgieTCJyuewer/sCfykzzAKMINGpsEnxcJ85G1W334cg9YGYz?=
 =?us-ascii?Q?JWSv/Eo+tHoaQ9pKGAc6nNrFg3JT2vdlo9PuRrIKn2ravX93v1lAb5ZySIrg?=
 =?us-ascii?Q?5zL23UQ1nx5ygeWfqXGaOUFFpjR9ZQQ4fXMMf3W7VJUK2Pi+dEmXzMqFEQ7L?=
 =?us-ascii?Q?HVjQi/acDiDtKPuGPKNrMQGhH59CZYwYj+y6fqoKvuumY+h4x16OsnGh5oaN?=
 =?us-ascii?Q?J6F0+N/ivNemgPWqz1O/ptFaQvcjo83MPysd9bVLQAzm3rYu3SPIdpMyGuVQ?=
 =?us-ascii?Q?pndT4ElEf78wpqKEEZ1km+YvM8qaO+bmfHOhZG+ODWlVD94MND+8mwvcwwq1?=
 =?us-ascii?Q?RHv/pl1yG9LMx2l2tSjjWkm3pxesgqzlxvx2527VWoXiGfyBlfYrGwMv0G6D?=
 =?us-ascii?Q?05V5KNNe+VWrnkkoVHMwsIFQBLZ1hlIGiUSS2FjtyaAEGiauj4uX6DRbuCwj?=
 =?us-ascii?Q?9OtOb7GSaUL8fh//I/k4BP2YH2fMgFeU9AUzzXs2wBM+3lok8XaR+CeQOF3z?=
 =?us-ascii?Q?wFDbmMaX9aYP0+k8mc0=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ba027c77-0fff-4b11-946c-08dc65e31117
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2024 11:21:49.8107
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R67R5YAPVi3o7KDPJrPWPiw6aNfNqToKFx5d9Pa4T4OyPDgBoQmdEyaPlF3evnzC3aj3xSadhX16pnKEgNZIjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR18MB4271
X-Proofpoint-GUID: MIAUoqGBIoAUfUXhgmgU1yOlf0EokhtM
X-Proofpoint-ORIG-GUID: MIAUoqGBIoAUfUXhgmgU1yOlf0EokhtM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-26_12,2024-04-26_02,2023-05-22_02

> From: Peiyang Wang <wangpeiyang1@huawei.com>
>=20
> During the PF initialization process, hclge_update_port_info may return a=
n
> error code for some reason. At this point,  the ptp initialization has be=
en
> completed. To void memory leaks, the resources that are applied by ptp
> should be released. Therefore, when hclge_update_port_info returns an err=
or
> code, hclge_ptp_uninit is called to release the corresponding resources.
>=20
> Fixes: eaf83ae59e18 ("net: hns3: add querying fec ability from firmware")
> Signed-off-by: Peiyang Wang <wangpeiyang1@huawei.com>
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> ---
>  drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
> b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
> index 62ddce05fa2b..a068cd745eb4 100644
> --- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
> @@ -11761,7 +11761,7 @@ static int hclge_init_ae_dev(struct hnae3_ae_dev
> *ae_dev)
>=20
>  	ret =3D hclge_update_port_info(hdev);
>  	if (ret)
> -		goto err_mdiobus_unreg;
> +		goto err_ptp_uninit;
>=20
>  	INIT_KFIFO(hdev->mac_tnl_log);
>=20
> @@ -11812,6 +11812,8 @@ static int hclge_init_ae_dev(struct hnae3_ae_dev
> *ae_dev)
>  	devl_unlock(hdev->devlink);
>  	return 0;
>=20
> +err_ptp_uninit:
> +	hclge_ptp_uninit(hdev);
>  err_mdiobus_unreg:
>  	if (hdev->hw.mac.phydev)
>  		mdiobus_unregister(hdev->hw.mac.mdio_bus);
> --
> 2.30.0
>=20
Reviewed-by: Hariprasad Kelam <hkelam@marvell.com>

