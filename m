Return-Path: <linux-kernel+bounces-147866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D58638A7ABA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 04:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F40601C20E7E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 02:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 301D5747F;
	Wed, 17 Apr 2024 02:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="HPiRJSJi";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="YF6f72xC"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10AC763CB
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 02:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713322204; cv=fail; b=KduRzSGoLgnQMKnVOq99N3vOZ/q/rh1RZUvbMDBIxMmcFahyBH6mRvrjrbedQJBHWERN3KMmG1LfO+njWok0WOXeP+dLSQAuX1hiWv0ZIUW1sEsCw3tsGBI+U1ZFCZDBXPXCwjOGlOSkhbPQ6xCpvMoaICyBcQeMO+7kSc7CMXk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713322204; c=relaxed/simple;
	bh=m+kRrGA3Fv8sJ5H0ex70ty3Jcdvadd8DwqN8a3nBsmw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=U3uhUHg9UJNUGPsBSjVtEo5e+z4xBWUXqiSlfO8QScaXHieOeN9cDOu3xa3sHcKg2Q09N/klujMXpg3dOTM8UYysj6vNUkfNJ5pzf0cKREeQv5QBk7r97Uj5T2rsU6ddYYwVhfHHhT3HXv05cI3wtrLZ17z2Q4fqcVaDjTUbNyM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=HPiRJSJi; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=YF6f72xC; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 2c499660fc6511eeb8927bc1f75efef4-20240417
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=m+kRrGA3Fv8sJ5H0ex70ty3Jcdvadd8DwqN8a3nBsmw=;
	b=HPiRJSJiNdrRKVvkCiWVxRu6nooWtrIScdWS7lyroQZ5septMnXxD37QVGJ2BEYzqVKx4jQx49JxVZbxOOuSldl8wByu1JyXl69TuamRVSbsRqOAnn3q7WdNMiufKMQYpORSSwAekx0se5TSur1ioFaHJtKuIgh5SEypkVexocY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:df5b5c19-c72e-475d-8dfb-3467a6e753c4,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:82c5f88,CLOUDID:5abaaa91-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 2c499660fc6511eeb8927bc1f75efef4-20240417
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 640780820; Wed, 17 Apr 2024 10:49:55 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 17 Apr 2024 10:49:54 +0800
Received: from HK3PR03CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 17 Apr 2024 10:49:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kDY/0RTfKObpRm4qdtvpTiAEV5WLIKZTYmbRc4vxSo9DSQqmqaw43tWhjueQut5BQd2LL0gsVbPmCCdH5OrCtAIdqyokHQS1qu1F3j59LsQ1QTsUfTxcbxB5g6ou1e5cNc72tXclNkBoeoLPbu7yqE3s6/grjgWb4PiphjiHO69gYtug3Mcu7cWlIoNyx+1NpEZYFUKc8Mx78HGhINslpdpvNHolUdpc55ilZ8oN2sPIi/dyo7fSqRNA5QmXh8TMU80j/MW6LZJDuzfi1BEJjAD4knuSsZHcx0wLcPgfcjvYIV7EF8XEwKHMwRcnqhQmv+sk6QjuHcuAyOhbKbhd8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m+kRrGA3Fv8sJ5H0ex70ty3Jcdvadd8DwqN8a3nBsmw=;
 b=Q6hOtBpRJJ1Eh4w7taUCl0sNILk6SHUdu/zseQBPqK8Rn/RzdQPQH8tpwgj1MNs0VitJIxue1V4cM0Ii7BY9Fl17QuUm1dxK11cIBbMxswJuyEyNnsUqk1d2C/XNDPs2Rlo4ckSjOcyEPXowhbgcVTnCYxb1t8WKaT/oZnmsEjQtZdsktsDLielefwdNaTntmI9/n8iC31W61O7mZT3WGmBGQ5wMoai2vHCl/CR2fyynHWdmgtJSFov6jq3sr7mW4YeKKMr5Z0vGbR06kWOrJ9E52iQqkTkhLKj1/RtuOA6tzyQFNI9HCXkYGclTHyqrOrfNdxohVZfkPliLzpctig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m+kRrGA3Fv8sJ5H0ex70ty3Jcdvadd8DwqN8a3nBsmw=;
 b=YF6f72xCPgYZfoTeLk63TqTVRyCfpYVZy8mpkHHgQ+/P/vuUIO1ARHu0yoB65tVVrZ5ZXKLi2JdDiNEvuvLV2FEvMOWmRwKhFmtgIx5U0kTKId5QUpmEB4EGvf/AmexhkEJibvhIq5HZIrEwFLEy0m1Fk5bTgq4uUvjvJmFcixo=
Received: from SEYPR03MB6626.apcprd03.prod.outlook.com (2603:1096:101:83::7)
 by KL1PR03MB8373.apcprd03.prod.outlook.com (2603:1096:820:13b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Wed, 17 Apr
 2024 02:49:53 +0000
Received: from SEYPR03MB6626.apcprd03.prod.outlook.com
 ([fe80::2e14:760e:174d:cc8c]) by SEYPR03MB6626.apcprd03.prod.outlook.com
 ([fe80::2e14:760e:174d:cc8c%6]) with mapi id 15.20.7409.046; Wed, 17 Apr 2024
 02:49:53 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "wmacek@chromium.org" <wmacek@chromium.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"chrome-platform@lists.linux.dev" <chrome-platform@lists.linux.dev>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>, "daniel@ffwll.ch"
	<daniel@ffwll.ch>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"airlied@gmail.com" <airlied@gmail.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
CC: "wmacek@chromium.com" <wmacek@chromium.com>
Subject: Re: [PATCH] drm/mediatek/dp: fix mtk_dp_aux_transfer return value
Thread-Topic: [PATCH] drm/mediatek/dp: fix mtk_dp_aux_transfer return value
Thread-Index: AQHahM0EB6xxNtQQFUu8VyiDpaK0/LFr2j0A
Date: Wed, 17 Apr 2024 02:49:53 +0000
Message-ID: <e829ef356d3e5e2ac68a86904973e4e88d2b3086.camel@mediatek.com>
References: <20240402071113.3135903-1-wmacek@chromium.org>
In-Reply-To: <20240402071113.3135903-1-wmacek@chromium.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB6626:EE_|KL1PR03MB8373:EE_
x-ms-office365-filtering-correlation-id: 5a4549bf-11d6-4c13-6955-08dc5e890ecb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?utf-8?B?WGRTZDVHbUMrcGYxcXdBelVZdU92MXhDTEMxRlVmekxCMjJxeW9HTldCL3pP?=
 =?utf-8?B?eHYwUE16SE1ZVjVnN0VDemNWZ3RQREFJNTdxZ29IZHJSaTNvSzUzem9HOFFD?=
 =?utf-8?B?OFA5ME5lOTFTK2VCSWczK3R3cGZmdWYvRnM5LzA0UXpKZ0tFb0VqSDBuSFBB?=
 =?utf-8?B?WUJZTWtFUHp6aWlwL04rcGlrb01hVExXZGtDUEFGbFVQdVVKS3pvSE5ieGlh?=
 =?utf-8?B?aDZtaGdGcml3Q1Y5VG0zbFV2UEZTN2x1bGxVV2xiZ1BHOFlSdk85WUVHUmQr?=
 =?utf-8?B?bytiVGY5THprYy9tbnJ0TC9uOXl0TE9OUkNLS3paamNTSVJiRVdjSFpOdUlk?=
 =?utf-8?B?czV0cDU0elIxZUlxTithTys4VHdJbFU2VFFmOVpBaDZueURvVHFuMjB5c2hl?=
 =?utf-8?B?cEw1NUo0Z1RFdkwvZFRGMWlmNWh5Y1NSRFg5MFZaVEZhdG11TDAxaHYwMklk?=
 =?utf-8?B?UW01MTV3emhMdnU3aHBNUG1kY25La1BZNkNTODhoSFRlZkZvY3JTVDJTcDJi?=
 =?utf-8?B?elk3OGdFMC93V3NnWFVIREVvYy8xSnBhU1JCMnhKR1Bjb2g2ZUZ1MWw1U1A0?=
 =?utf-8?B?STNmdXpKcXk1VERvTE1VR2w3WWpqRTMzTFZxS0V6ZXZMaVdzUjlPYy9ZQ1kx?=
 =?utf-8?B?S0swYXo4c2N3cTFvNWcyeWU0Sk5zNHNHZnZhTUVJbkJNaDdQcldRT1FFaGF4?=
 =?utf-8?B?S0VuU3JoOEY5U2hxZHpsM0xGbzR3SG80Z3BBdFdjVHMvOTg1RHdhd2dhRjUr?=
 =?utf-8?B?d0tKN25vTklTSERIdzBLZ1hGUGhVSnZQRStOWHBVUDh4d0kzWkNNOW9rQVZh?=
 =?utf-8?B?Tml4ZnJqZ2t6RThQQzVTRUExbFFwdjZVa2kvVk50QlFFZXl5ZXpWVll3eXlx?=
 =?utf-8?B?YjNPQlpmNW42YlpKMmJvNjJ4d2NIWHFuMDlFdGhTb2tlNkdJNlR1ZFp6bnIy?=
 =?utf-8?B?dEQ2VmVSYjlVM2dkbVJjeU5UM0hSNlFtYUlOQnFtL2puelJ4NzNHakl2ZitB?=
 =?utf-8?B?UGRueVR1ZnZVeVFzOWMvaEZlNUhsZG9hVW5OVlRpdExpQzFoRHpYcjQ5WkNR?=
 =?utf-8?B?ZkhBbGRqSnlIUGFYcVNDbXJZaTFxL0NzOTFMWDZ1QnNzQ0NmUkFyTjRGTUJN?=
 =?utf-8?B?R1dRcEZkeG5NcWxSeEtqTTA5Q1hGWDJzVDFVRW5SVFN0SnZhMDRCS1lpMHRp?=
 =?utf-8?B?MWZCQVFsMEdkeEt6bURxZTZoRkY5UUJVQ2FpbTY2Z2ltMGpHN2pXOW8xWUdz?=
 =?utf-8?B?dU4weHdhbXNpUFJEdXRtZzhibjVnaGxzWFVBemhqby9lTHNMbFU4T2duU2xO?=
 =?utf-8?B?cEkvOEVPaWNjMFFLakVrUmtSSEt3VTZTd2FhZVQyLzFkaTdJUThtN1NlY3Vs?=
 =?utf-8?B?QVJsM0FtUkI1WXgrZXVsY2ttVGVFTFluU244Q0w2eUNENExtSFhhTU15SWJ3?=
 =?utf-8?B?eEIwNytrSzlKVTU4eDFHNXpFMVdOUG9pYWdvMFh2bFJqdmtJWXVDRDRkWTRk?=
 =?utf-8?B?ckhpWDVQbFJuQ096SFJ0MS9UUnNUMDUreU8zMTc0UEVBYXNsV3FiYU90WHlj?=
 =?utf-8?B?d1E3WGcrSnNqQjNpY0FrcklUSWFiMDFIcWNXWGp2YkRqaWUxZmJTcnpGRENW?=
 =?utf-8?B?aFVYNUpUZU01VnBCYzJEa01MSEJuTTVzNVdsT1Q2V3VzeFpwTFU2U1RLVEVm?=
 =?utf-8?B?cUxWU1JvSm9WRE43d2lFdGFwL2tnb0Vkdi9DM2pDNWxWd1NVR0pHUXRlY0sx?=
 =?utf-8?B?TzRLNitNK2t3aDJBQnkybU45N1p5dXk1d1BTaTd2d2xyYWFyMzZUcEF4KzVk?=
 =?utf-8?B?cGZFcm5GVndUaWV3ZkNOdz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB6626.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(366007)(376005)(921011)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cTZ5Qk1CVmN0Y0txZDRpWUFieC9SeTI5ZkduMnMwK1dXVWRxV1UyVnNHTkVn?=
 =?utf-8?B?Zzd2TmN2QUYyWEhLNUpZYzg0bkI1UDlBQTY5a0tjOGY3SitZVTJ1MzZHU3pR?=
 =?utf-8?B?b3Nua1k4VVN5SU1OM0xhWXUzc2VBM2FIWS9kQzdXREpFL240WHEvbFZUU2xL?=
 =?utf-8?B?QW5mTjlrdUVIZnlJZHZEN3JTeXkvbHBqTFBlTDFXY2Z6NkFXT1orTUJCbldQ?=
 =?utf-8?B?WEQzbXNkR0hGV0ptNUgvQnFlOE1UN2pqL2FEQk40Q3lrNzBFdG5KSEN1dzA0?=
 =?utf-8?B?UHQyV2VsMHFEM1BsOHN6d1YvQmN5L2FZZEppK05GbnQvc0tteFI1TEVBZ0lx?=
 =?utf-8?B?ZG9Dc3ZDaW5YOUVkQWRUWldrS0hhQ0MrT0hEOUVBSHBmcEY1VDZuNG05UHVq?=
 =?utf-8?B?eTAxK011QlV0VS9CdW1RNzNkYXRBdVBvZmNNRlpvYllZNHIvb0g3OXRFdDlC?=
 =?utf-8?B?cXRNUXF0VjZYREwzd3BzL2RVdVRQN0t4STJBL1crQk1mSWk4b2ZDTzVkQXpT?=
 =?utf-8?B?MzB0em5CY3ljK20ySFRWanpCSS9GRVo0UXlndXpmd0JuN1FGTVJtd2s2a1B6?=
 =?utf-8?B?bGVKSkdwWTh0R1p2WlA1NFZIUEsxMXZQcGhUaFQrUmJNQTJBSmE1V3dOcEJk?=
 =?utf-8?B?RGZLRHN0VmFZbDgyUVQ0QzBVbkppYlB0QThQYnUydW5jM2ZRbFhBWTZwa3NT?=
 =?utf-8?B?QklYR3pBK3huaHoxams1eitOZE5LZlBOUEpHTlFLd0ZiMkp4czBIWUt0L3Iv?=
 =?utf-8?B?bitzcmtyL0U3N1U4bEVhT21TREZNRW1Oc1NCL1FmUm00VEJDV00yL1VUUkZi?=
 =?utf-8?B?NTNVd1hKcEFYUmVNbjdZanBVVFN1YXBDdzBVRkNjZXo5RThzeGdJN05EdEVv?=
 =?utf-8?B?YVlvVXNsMG44QzdVVC8veUFIdUx3Z0tuVEhOajZYazF5QlBvaFlWWUJCWHl5?=
 =?utf-8?B?aERmbkk0MU8rYmIvcGYvLyt4QXUwbXpKUlJ5M2phM0ZLL1NocnErdUlxODMr?=
 =?utf-8?B?amt6ZnRvU0JBSWZWeVpVUWdGNW90TVlQTnN5RFh5bUV4ZUIrUjM3dkNQZlhJ?=
 =?utf-8?B?a1hvWXNXcnhsUVh3WW9nZVhDZ1R1UFQ1d0psWkxpalhud3Evcm9KdS9xaXJQ?=
 =?utf-8?B?cm9DRDYxajN3Z1VEN0gzaFpTYjRWTk9mTUw1ZTVHYkxaOXFrR3Y2RkZWNnV4?=
 =?utf-8?B?aEhEcHNzTUxrTTBob1VQQStXZThrZGhxUHJGak11dmpreVZ1Z3NaUndUQ3Z1?=
 =?utf-8?B?YXgrNE0yN0xCQkI2MlJXYVdoUmZaWENhSkIwK1pvZFh5VDNIazJhL1hLczlq?=
 =?utf-8?B?Z3NQekk0aTBFdDgweEFJeG5sSlZsUGhsTUUyOUI5MnpjVzVETEdxZGRURWNp?=
 =?utf-8?B?WTRLY25XM3hJcDNGdk9ORDByR3pqYXJMaDJSNUlIMEJzY1R6WXlOSGhyWnV6?=
 =?utf-8?B?dU9rTWhkdVpzNHhVTEI2MkF1RTFpR01rOTQvTzJjbGYyWXg3WWlId2Z6Z0E1?=
 =?utf-8?B?RDRSQXVOZlJpaGFrT0VYZ3JYY21QcHB5bFVRQkFzaWo5V2pjcHJlMUdwWnRK?=
 =?utf-8?B?NFBzUnlMdmNndHBNa1RzSmtrTllwanU2TlgzZk9Gb0pQYUFYZUNUMXJPMVRp?=
 =?utf-8?B?RWJOSGt0ZU14TVFsZ2NNWDJ1VERnVTdiZzRYN3VGWnhVMmV3M3ovRVIwSVFu?=
 =?utf-8?B?Q0s0VTZJc3BSMjhrVkFyRmYwdmJZWDE5ZkphU0NpT3dSVDNXam4wSG5DcDYv?=
 =?utf-8?B?cWhZSW9STm5KcDVYc2w4b09DWGZqQmZ6WkxYNU9qYy9Sb1JxaVUzcTRVZWM3?=
 =?utf-8?B?ZW8yNmVRZnZPMlZ5MW5sa0xQRFMzdkhWTGdRMnFHZXl1a3JGSTNQUlhxdVZ2?=
 =?utf-8?B?L2FNQmF3OU5FaVVjSTZmRHdIWFUyZ3d2T0ZicTJodmRzdUIxL1JJOU92ZXhN?=
 =?utf-8?B?dVJJV2ZQQWdjK1JyVS9LNGx6VWJFaEErMWZ4Z21kSHJGYzRTNkVwa3AvQWpR?=
 =?utf-8?B?bWlsY0Z4U1VMakJxYkNxSEY0RU0zUlhZNXc3RFErYk1EaHlxVmREeUJqckRK?=
 =?utf-8?B?d2toYUwzVUlUY2tsTDNzQUJDbjFleUV6ZDFjek8xN3NlZ1JVMjcydmY5M1Np?=
 =?utf-8?Q?TxX4Q46BTlwbCxEh628mFGhze?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <85DC8192CC40C24E8AA9FF34E8CA4438@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB6626.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a4549bf-11d6-4c13-6955-08dc5e890ecb
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2024 02:49:53.0911
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l1UgvC9p5PRhn1TcN/8lYg12qf9ZszeAelEwZcOcRpU1QkdlpkxkrmT0cgumq+J8F/DNMZpWl0jSJsHhCZTErA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB8373

SGksIFdvamNpZWNoOg0KDQpPbiBUdWUsIDIwMjQtMDQtMDIgYXQgMDc6MTEgKzAwMDAsIFdvamNp
ZWNoIE1hY2VrIHdyb3RlOg0KPiAgCSANCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90
IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZp
ZWQgdGhlIHNlbmRlciBvciB0aGUgY29udGVudC4NCj4gIEZyb206IFdvamNpZWNoIE1hY2VrIDx3
bWFjZWtAY2hyb21pdW0uY29tPg0KPiANCj4gSW4gY2FzZSB0aGVyZSBpcyBubyBEUCBkZXZpY2Ug
YXR0YWNoZWQgdG8gdGhlIHBvcnQgdGhlDQo+IHRyYW5zZmVyIGZ1bmN0aW9uIHNob3VsZCByZXR1
cm4gSU8gZXJyb3IsIHNpbWlsYXIgdG8gd2hhdA0KPiBvdGhlciBkcml2ZXJzIGRvLg0KPiBJbiBj
YXNlIEVBR0FJTiBpcyByZXR1cm5lZCB0aGVuIGFueSByZWFkIGZyb20gL2Rldi9kcm1fZHBfYXV4
DQo+IGRldmljZSBlbmRzIHVwIGluIGFuIGluZmluaXRlIGxvb3AgYXMgdGhlIHVwcGVyIGxheWVy
cw0KPiBjb25zdGFudGx5IHJlcGVhdHMgdGhlIHRyYW5zZmVyIHJlcXVlc3QuDQoNClRoaXMgcGF0
Y2ggbG9va3MgZ29vZCB0byBtZSwgYnV0IG5lZWQgZml4ZXMgdGFnLCBwbGVhc2UgcmVmZXIgdG8g
WzFdIHRvDQphZGQgZml4ZXMgdGFnLg0KDQpbMV0gDQpodHRwczovL3d3dy5rZXJuZWwub3JnL2Rv
Yy9odG1sL3Y2LjgvcHJvY2Vzcy9zdWJtaXR0aW5nLXBhdGNoZXMuaHRtbA0KDQpSZWdhcmRzLA0K
Q0sNCg0KPiANCj4gU2lnbmVkLW9mZi1ieTogV29qY2llY2ggTWFjZWsgPHdtYWNla0BjaHJvbWl1
bS5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcC5jIHwgMiAr
LQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcC5jDQo+IGIvZHJp
dmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcC5jDQo+IGluZGV4IDBiYTcyMTAyNjM2YS4uNTM2
MzY2OTU2NDQ3IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rw
LmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcC5jDQo+IEBAIC0yMTA0
LDcgKzIxMDQsNyBAQCBzdGF0aWMgc3NpemVfdCBtdGtfZHBfYXV4X3RyYW5zZmVyKHN0cnVjdA0K
PiBkcm1fZHBfYXV4ICptdGtfYXV4LA0KPiAgDQo+ICAJaWYgKG10a19kcC0+YnJpZGdlLnR5cGUg
IT0gRFJNX01PREVfQ09OTkVDVE9SX2VEUCAmJg0KPiAgCSAgICAhbXRrX2RwLT50cmFpbl9pbmZv
LmNhYmxlX3BsdWdnZWRfaW4pIHsNCj4gLQkJcmV0ID0gLUVBR0FJTjsNCj4gKwkJcmV0ID0gLUVJ
TzsNCj4gIAkJZ290byBlcnI7DQo+ICAJfQ0KPiAgDQo+IC0tIA0KPiAyLjQ0LjAuNDc4LmdkOTI2
Mzk5ZWY5LWdvb2cNCj4gDQo=

