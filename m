Return-Path: <linux-kernel+bounces-95382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D75ED874D0A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 12:10:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBAFB1C22D23
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94DA9128379;
	Thu,  7 Mar 2024 11:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="K9D1v0tA"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D909DDC9;
	Thu,  7 Mar 2024 11:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709809798; cv=fail; b=JefDGpY0KtoEBFGQN7uW/l61aWJg4gClwhAakNUYmYTpY+d61yO/ioLrme0ECpJ5vYoqHjcQsfNEQLWxdYA6dEkmlWXTMnblIqQWh1t8YuBx6xZahgdokiI1hd/LY2qoEkbfcr9+l9Z0xYafBxupco3DvczmW+rsBWUsW4AtZjg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709809798; c=relaxed/simple;
	bh=X1uB62Iarnij7sg30LUSbApES93AqYLIXF2IvbDCF48=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=p1GcSipGLOClcWHPYJ1d2bmlNc9cEfUJgPkHZBXyZ6yw2kFF3hXaXnB5QNJ5qtoVC6FohgYxdS86Dol2hWe7i69bpO8JgrO5RsWCW/pL4mCnChThW/N+rIgMXZMNHVED8RznhzUmC7F12Mi2F3wkJZtDe/xMjQzaj4bJ269FNGY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=K9D1v0tA; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4275jvFl008425;
	Thu, 7 Mar 2024 03:09:42 -0800
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3wq7q8rw5r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Mar 2024 03:09:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bjfx0hiI8cldxv+RS8yIE10Oh5bVrbZaN5tf2OUOOtLp+3OtfRNqyKoxWDe27rSNIojuX55iP6olqF3WV1WzNc3pH2RV5qPSUALquk9UjiPnvrav5fSxl1yebspdhGCrmyitudro1+a0t4+iSNB4uC7aswppSY7xULdiS2V/jBZKlnv4qBhUj1aHXFINclrU3zD/hhoD0ZuqtRTHYFKU9ceRvFdjSRel9SMXDZH3KrfwTZ0L8Zy0PN5iBvBSL0EBBi6KFcJQg6DFQL4vOd+zosiBLWwbEfuH+v2KpTmK+jbK/rRuzxYCG7lqkcAEbP5c2n6wNkeGqgGD+plOSYWW6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YZA+nrHgi8ZJWbpMwPnU1PCwp+7nK1nNE81dnoAQb4s=;
 b=nW0sawY6Ty3iBPNIxTa0Yy0z6x70E/3ZzcPD4GZSQYwM4MvbsyeXpscsxnNZHF6XVCUvny+gsXJ6kaopwIViGZkbpRxDlDAxo5fUSI2TJSJAcV8ZewXvzN02d7FGQWxcuSGJTJv0Yy8NXhbZyLM209yaIb0K6x7Q5jlkN/ad5MwBQyffgeyZgFhRYj8rwSfmi3Bdx7RF7gt+KtrBhr2K0qjD5fvKCfvfTm55otBg0rjGfJclGyh4c+hsyoGRGTEkx3E/V+v7nwhojNJU9qY1nHDfiNnvgb6m3jdpu7gumFqQpUuvLOWrMFUBXj7Cj9QJF7iPTtGRqJlRjd34tDAG7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YZA+nrHgi8ZJWbpMwPnU1PCwp+7nK1nNE81dnoAQb4s=;
 b=K9D1v0tAcl+oBfFUr/MjWLAtoN4RVNiREq89DZJSAaJ0cdpEQneEsvZ+xl8nn97ZAsnGkeluVwpRr5P7yN/IAcyZ+ZEdaH6hQscL3LP56dIA2UPVErv3RP6mgV1kxH58fJe6BhDfEZyYpxB9ZxdlUPDMArNP+48ZJyxtrgXicVw=
Received: from BY3PR18MB4737.namprd18.prod.outlook.com (2603:10b6:a03:3c8::7)
 by IA2PR18MB5852.namprd18.prod.outlook.com (2603:10b6:208:4ad::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26; Thu, 7 Mar
 2024 11:09:39 +0000
Received: from BY3PR18MB4737.namprd18.prod.outlook.com
 ([fe80::4c91:458c:d14d:2fa6]) by BY3PR18MB4737.namprd18.prod.outlook.com
 ([fe80::4c91:458c:d14d:2fa6%6]) with mapi id 15.20.7362.019; Thu, 7 Mar 2024
 11:09:39 +0000
From: Sunil Kovvuri Goutham <sgoutham@marvell.com>
To: Jijie Shao <shaojijie@huawei.com>,
        "yisen.zhuang@huawei.com"
	<yisen.zhuang@huawei.com>,
        "salil.mehta@huawei.com" <salil.mehta@huawei.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>
CC: "shenjian15@huawei.com" <shenjian15@huawei.com>,
        "wangjie125@huawei.com"
	<wangjie125@huawei.com>,
        "liuyonglong@huawei.com" <liuyonglong@huawei.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net 8/8] net: hns3: add checking for vf id of mailbox
Thread-Topic: [PATCH net 8/8] net: hns3: add checking for vf id of mailbox
Thread-Index: AQHacH/yNUXaOHAlAkWKtgnV1KsXZw==
Date: Thu, 7 Mar 2024 11:09:39 +0000
Message-ID: 
 <BY3PR18MB473795159A7766BFE321B424C6202@BY3PR18MB4737.namprd18.prod.outlook.com>
References: <20240307010115.3054770-1-shaojijie@huawei.com>
 <20240307010115.3054770-9-shaojijie@huawei.com>
In-Reply-To: <20240307010115.3054770-9-shaojijie@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4737:EE_|IA2PR18MB5852:EE_
x-ms-office365-filtering-correlation-id: 65962d4b-1357-47b6-ced7-08dc3e9714ea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 rgx8rKQ1M/utXs4kdYk117O7JsPswuavxGq8T5Yh2sRPWkk0pYsmAnBNp3OcQ9j9ka4Y5gzjMgqXfPBojGdATaBNVGoYvbr/wPI84nJ6ID2z7VzCE+P44tuJ8Abjgp51G1G83R+lx1lChQSsIXMgR4Ahh9E6CI6LLwy2NgJtO97hdkcDKvtr2kzFLFROxDPE6eJATiG3Tiq0VyLEjt0a+MAmWrRl1nYZ6Iio0MGb6DQ+ehRw1CugKPW5YihkeE37Mg4MojKNwd1ntJcDbx/gI9XYWQ5dZJySXvzoFGoucDPD/CiL1JheL8s3CvvYEYkHNS2hXkSk/LXwEEUU9J7PAmszijO9O1CBTHCfQJ93BZOIhGzI4xSqZQ82vTTQGTj3kubav6j4vV/2tx83FDXpzkOsOS4ayQM8DS0xV/MW2FPlfofgizemQtpN9JuV/Wkc4kiiDQLZ/kZVBNdbbryDV8HWnVZj2wCEjOwReQ/CNkdB8v84yAnY284CE7A4bzyUFFxyE3i0SborZA2G2nnZEJOGJXGO8toAX9ln2kODvW6kPQw9fo8W4qogfQ/hq354Lu3896pmLmmqsyj/74IAjQo/O9mCzkItxlew5ps7wHBmzv1LY1eur+axsYWBJcDX7dzetRPFnsn9YAKzaf7npa5J+KJxJI9PJz/P6OfC5qo0QGgnUOXyeMdIF4M+37TepSRoMoWIiGF5Sky+dBOQI51CWGMARQbM9dkKLDk09HE=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR18MB4737.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?zDpmn0ipZHzvnJcEuTS8Y2GkM+vBN7shZ6bM5STmwNijBdWGGVyg0qccwzgj?=
 =?us-ascii?Q?2ILXG4qjnHed73kQslmjZFsneGV1WPf1qot31Ocur7DaAXYdLFJqsKofXChb?=
 =?us-ascii?Q?JzLLJx6OVyuXGA08kVM0ZtYjq9ncd3CQ0Z1BvbOttefrmdEnlXOLHsyB1KNu?=
 =?us-ascii?Q?bQcMKuNQlDM+rIRKprGlUJJE+zrzryLqNMeehZPE8/OsQFivx7kh9rUFI8h2?=
 =?us-ascii?Q?ngskVhqKvw9FPUOWjhw26kUu+mKV3kS8D65YtAij/uRc2zY2qqvPt6KY+47G?=
 =?us-ascii?Q?fMMxvdKRCVKYTZuneZpkvpYtqTA1gyJNLbGkNIUEfNNjWINOXnVoZfKAJs6+?=
 =?us-ascii?Q?CD48qzWfceGh7zZkOw/4tO+WmlY5lXL0bHFftzY12Z+f+o+o+VBoNwwLRlpH?=
 =?us-ascii?Q?KB8qW+phN0uR7IH2GIbKZnLp5XEW+ZeHP/z0UzsqcAmC/SWkkiTN6jcz9p0L?=
 =?us-ascii?Q?mYVRxqW43g+Z+dwgHrLme+YJn2fGpnRhtQxOeA/KyFF9WQpBYsP6ofHSZ/I7?=
 =?us-ascii?Q?gk1DjSp0OJkDTE/0W6CrmMH8qBt0vq//V27jO4v/9eVrvhgESBe1q884b3bu?=
 =?us-ascii?Q?0ihc3KIomUKOqE+9A/O4+8rzt2Nz+16vg/XxaB4Bf6skeqLMBbq2aqqL4/MA?=
 =?us-ascii?Q?9E7zAr+BfXvSU5eLde1gr9ADR+vojD4BDK0GKM3yq9Z7abkp8HunFRmaPjO3?=
 =?us-ascii?Q?NA772SiYG1OdJ82/cbRCPx70hjcmm1FoUxZ9ji1hFHbM/oItAy08fjin9UIK?=
 =?us-ascii?Q?fAAxzgSJ/DK/12t3g/eDOHNQHScrnL74x3yMZwKUojMElm1CwSoiSFneQLYL?=
 =?us-ascii?Q?TRrM8wakT21kYDwrLP4h80+zHZm8ICasoxqKckkUsKnv7bd4GsU98fNcYOmd?=
 =?us-ascii?Q?Q2Dp2KApmfhJd3xYtaCDPD3UAGD7FE7kX4Os3AtrzZS5dTmBSVWLdC0M8cnY?=
 =?us-ascii?Q?IPIU05F5xfLmpZ/nx9h8Mi9I6KxPNBJiZCrBG3dtBQ5BmQ0q1io524YrqDpc?=
 =?us-ascii?Q?VcAA5NIeWSsKlr7CirMiVOiDPBMleTIdM+1qrey3ZukPUYBUxcjyx++2m/9l?=
 =?us-ascii?Q?6r0+mPCmQclDIrLsAktgKffZ/74g7s/USN5s58FYRyLp3Uj99m0nmZo60QJO?=
 =?us-ascii?Q?3sNDnKOTW90CdsHDtpL76GuVptlEkG4IbYQiRK50zH+jZDHtEjcqHDXiKoCd?=
 =?us-ascii?Q?RfzRiTivZpAy6DAOeFatgatsRz6NrXCGCKAntf7OYJ/eE4rdDireH9hLUKNI?=
 =?us-ascii?Q?rpLIIGOmaEhHwSMqRZnR3TChwQwf4j5uNxP7wuJS8+o68VFkj6g6kmpkyoRY?=
 =?us-ascii?Q?W9Nhd5gkjyCnBKxZL3Y2nLINN40T5YRFgY4B++cjn4d7mZsheO+REEXGbUgz?=
 =?us-ascii?Q?KLJRIGGgiuPdjmopM0UqjeO6PylOdQw0U6Es8AtFUOd+GM9xhYydsitWqyzo?=
 =?us-ascii?Q?KZ74KVUkp0J9nyXRp/kwSItOEKKC4VAUJlquZV6Tpu9U8VlHvUwrlsz/eWeR?=
 =?us-ascii?Q?Jz46cP8IJ5kwT1ze200a0rj3U5dOIoN4iHQkMgfqVlLvcGtGbe9IxhxLUd3k?=
 =?us-ascii?Q?7f6qjLbw1y/ZWjv/R/i9GeUkZhxF79G6S9b8vgtT?=
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
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4737.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65962d4b-1357-47b6-ced7-08dc3e9714ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2024 11:09:39.1564
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /+0XiEtzy0KhSEA+9YwaSfhku1Gyd2z1xIPVp3v2wM7z7foN9RmUv3+r6mY7WjVVHW9PplBl5scLT0YEcXo/sA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA2PR18MB5852
X-Proofpoint-ORIG-GUID: 8OALq4WKtgRU5YdeFiliB9LIHwcOE-Am
X-Proofpoint-GUID: 8OALq4WKtgRU5YdeFiliB9LIHwcOE-Am
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-07_07,2024-03-06_01,2023-05-22_02



> -----Original Message-----
> From: Jijie Shao <shaojijie@huawei.com>
> Sent: Thursday, March 7, 2024 6:31 AM
> To: yisen.zhuang@huawei.com; salil.mehta@huawei.com;
> davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com
> Cc: shenjian15@huawei.com; wangjie125@huawei.com;
> liuyonglong@huawei.com; shaojijie@huawei.com; netdev@vger.kernel.org;
> linux-kernel@vger.kernel.org
> Subject: [EXTERNAL] [PATCH net 8/8] net: hns3: add checking for vf id of
> mailbox
>=20
> From: Jian Shen <shenjian15@huawei.com>
>=20
> Add checking for vf id of mailbox, in order to avoid array out-of-bounds =
risk.
>=20
> Signed-off-by: Jian Shen <shenjian15@huawei.com>
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> ---
>  drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
> b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
> index 4b0d07ca2505..d4a0e0be7a72 100644
> --- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
> @@ -1123,10 +1123,11 @@ void hclge_mbx_handler(struct hclge_dev
> *hdev)
>  		req =3D (struct hclge_mbx_vf_to_pf_cmd *)desc->data;
>=20
>  		flag =3D le16_to_cpu(crq->desc[crq->next_to_use].flag);
> -		if (unlikely(!hnae3_get_bit(flag,
> HCLGE_CMDQ_RX_OUTVLD_B))) {
> +		if (unlikely(!hnae3_get_bit(flag,
> HCLGE_CMDQ_RX_OUTVLD_B) ||
> +			     req->mbx_src_vfid > hdev->num_req_vfs)) {
>  			dev_warn(&hdev->pdev->dev,
> -				 "dropped invalid mailbox message, code =3D
> %u\n",
> -				 req->msg.code);
> +				 "dropped invalid mailbox message, code =3D
> %u, vfid =3D %u\n",
> +				 req->msg.code, req->mbx_src_vfid);
>=20
>  			/* dropping/not processing this invalid message */
>  			crq->desc[crq->next_to_use].flag =3D 0;
> --
> 2.30.0
>=20

Reviewed-by: Sunil Goutham <sgoutham@marvell.com>

