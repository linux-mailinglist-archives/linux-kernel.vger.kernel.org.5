Return-Path: <linux-kernel+bounces-146376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D36368A6474
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 09:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02F081C213A0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 07:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B81BB7580E;
	Tue, 16 Apr 2024 07:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ovVX41XR";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="B7uBmTHG"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822636DCE8;
	Tue, 16 Apr 2024 07:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713251013; cv=fail; b=XkvGJXt1LWslmmQeAdlBIBC8S1s/GsBhpJkN6ghipg1zyaIHVjfe4/nGWj9ITd56mdB9I5TnmaAlDFiwfhpWrMvQANW9EthLHSqWAbjFOKha1yEj8lRK/nqVJYHuh540s+Mlky3A7MvyrONGeuaIIzFelOSlO6Tdlw3y4MuiWio=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713251013; c=relaxed/simple;
	bh=s3OdwgS0tBf1B5SsriamF0uETDJic+KRgO9K7OxrSVw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=o0ia1j4SmulIhw9z2hK/DSVGMx1LIv371HK5nmgqNwtKLQVI1OPpiVTWsCgV9T539RY8nGfzH4yEs5XU3kH9vKJeDWetha45t5k+krXZCbr/j39Qyuc8ki3RTFnBNY+sNeRd1Ft6uWafd/dYDWixEJ0KJM+gfhqS/m7oyIvvHAE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=ovVX41XR; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=B7uBmTHG; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 65d4971efbbf11eeb8927bc1f75efef4-20240416
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=s3OdwgS0tBf1B5SsriamF0uETDJic+KRgO9K7OxrSVw=;
	b=ovVX41XRLwQ2XP8ukPbXWl8lik23i+pZTQ3b2G4uRDzBHsVvehF6uVLzKBiJ5RYqjnOQxLx99ER09kOLx0csHEcyqjAI32tVCABfctw6+XFy4wZ63sMBbNctdU21MOebtudkirtfhT45oH8vE8GIL4LY33DhlL7oA4NdyFZaiiY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:bf21cf61-89e8-45e2-9626-a20dc1299b90,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:82c5f88,CLOUDID:46aaa191-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 65d4971efbbf11eeb8927bc1f75efef4-20240416
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <peter.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2057170238; Tue, 16 Apr 2024 15:03:16 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 16 Apr 2024 00:03:14 -0700
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 16 Apr 2024 15:03:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XdeY49y948BHLNi7P8JsUVZlkTVaKlWkyhM6bzb8ugk8ulPrZQwjHb8G3C0+OKI2I1Ty/0YjUvFFS2xl3uNH4nbk3L0kg24ihF+Fi4KFYY+7F6C/Jbv6dsUmhyooiJaSL1+VgxjdGJ1HuhvSfhTy9PLRtqHKP6orWdWEzADtgmKvdejkDcwcCIkTX9FqaVWKUMvqdKawv9rnZFhlVDDKnMBPebGD8dGhJ9GrlFInRKotcXM5xIJgzMMD5LAY+lR6R6v9tpRgZaKmtHyfdap75c25URGCYE/4FSnJgW54M8s9AzjcX/SyzBDclCG7Uz5mapyE8VVlGX+lLriOcc5o6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s3OdwgS0tBf1B5SsriamF0uETDJic+KRgO9K7OxrSVw=;
 b=VlvClkVDjmLUE6OAob0fana7SQlwMDD0aXc6xlwStuzRRSgVST/VpmfTV6gBWHOREyfLmFgLmdc6Tk0JqiKkM98i4WdnKUC5TlHxVRVBNbyhkSakOSW6HLnN2GXBYNp2IyAmSjBzWVOsJR1JJCze/h71nI8tkNAPFsFKL5RyoCTAc9mcrlD+Po8i8bImaf8M4CfbZDo+uD+yO+8G/qpd2YFEhaPMZ5HBQuDsBkXX/kDt52erQ5ea6RkiPl/ygkAUG0o8YJhK4qhgCMUrxChAZBof6u345OOtySeWningRK7BoQYQr4x0ljS3/3wrcT/2XnbhOZWurPOES+FqH7fkrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s3OdwgS0tBf1B5SsriamF0uETDJic+KRgO9K7OxrSVw=;
 b=B7uBmTHGuR4AuyyiNd12HxkiNRGza7dn5Ru3j5h/l48DtG8ygk5gbOo59RQFvSqp3tIg+PHaXUx71PjmcneCpMY64fIxm3P/uJG3eNygB7RGmHS5R1sh89+ZO8B3LerccQVXYkoyxyHGghFVObob4+1hN0WSdwMmsPfnXxaof1Y=
Received: from PSAPR03MB5605.apcprd03.prod.outlook.com (2603:1096:301:66::6)
 by TY0PR03MB6452.apcprd03.prod.outlook.com (2603:1096:400:1bf::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 07:03:12 +0000
Received: from PSAPR03MB5605.apcprd03.prod.outlook.com
 ([fe80::3945:7dbc:62bd:c31c]) by PSAPR03MB5605.apcprd03.prod.outlook.com
 ([fe80::3945:7dbc:62bd:c31c%7]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 07:03:12 +0000
From: =?utf-8?B?UGV0ZXIgV2FuZyAo546L5L+h5Y+LKQ==?= <peter.wang@mediatek.com>
To: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"jejb@linux.ibm.com" <jejb@linux.ibm.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "avri.altman@wdc.com" <avri.altman@wdc.com>,
	"bvanassche@acm.org" <bvanassche@acm.org>, "martin.petersen@oracle.com"
	<martin.petersen@oracle.com>, "broonie@kernel.org" <broonie@kernel.org>,
	"alim.akhtar@samsung.com" <alim.akhtar@samsung.com>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"lgirdwood@gmail.com" <lgirdwood@gmail.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>
Subject: Re: [PATCH v4 3/8] scsi: ufs: ufs-mediatek: Remove useless
 mediatek,ufs-boost-crypt property
Thread-Topic: [PATCH v4 3/8] scsi: ufs: ufs-mediatek: Remove useless
 mediatek,ufs-boost-crypt property
Thread-Index: AQHajyQsFRoxXt1vlE2SkQwxcZAltLFqegCA
Date: Tue, 16 Apr 2024 07:03:11 +0000
Message-ID: <c9634a286fbdb4c98a7fe6703a4eb10d66dfcb9e.camel@mediatek.com>
References: <20240415110012.148871-1-angelogioacchino.delregno@collabora.com>
	 <20240415110012.148871-4-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240415110012.148871-4-angelogioacchino.delregno@collabora.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR03MB5605:EE_|TY0PR03MB6452:EE_
x-ms-office365-filtering-correlation-id: 7b7f0a9c-9101-415b-f351-08dc5de34792
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?utf-8?B?QVpXand4Nk9PZHZhZUJNOWkreHZva1Q4VTlyazNDeE96RnNWaHA0Z1lzUXgx?=
 =?utf-8?B?dE1EcVNFeTNhWlltTjJTczc1cEJyUGx5T2ZNWFZ4dmpGUWdhbHRwM0FRWjd6?=
 =?utf-8?B?MU1CN09hSlVNWlB3UmZQY2FqQkVTK1hTSG9lOVREcGMxZnpMaXBRQWU5VmtG?=
 =?utf-8?B?V05CelBSNUpncEtobmRiSDYrK0V3ZjBzdUprcHFUMm5WMmJSWVB2TFU1MkVY?=
 =?utf-8?B?VVUrcVVuRWxPZy9meEE0UTdFWUt6UGVDNTdWbHZyNWRpbWdmT0tBQTBqek1i?=
 =?utf-8?B?NHlqZzNKRWw0Nm9UZDBHWVFPbFYrYUN6YVE1eGNMT1lxK1RGTW5TUnMrQkxl?=
 =?utf-8?B?WDgvK0pWNzhHa0Y0RmtGSXlWUEcvWkJSQmVuZDFtSXBSRFNZTnBVK3BUcUVn?=
 =?utf-8?B?bDIxZTBYRlBiQjlLeThPcTJpdEEySXZqZHVDZmpCWk9XZXZUSXE1NlBseE5N?=
 =?utf-8?B?dXovZkNuTlluK3g0SnVCdUNIUXRxbG9OeHNNeVJwRkNSNXJleVJ2SmRpR2tJ?=
 =?utf-8?B?eUUvRGRHa2JtaXBmRnBobjRlQTFmWG54dXc3MDJxd2dYS2JiOE5ZbmtSeFRI?=
 =?utf-8?B?Z2FCcjVGbnRqMXFUVjAzSlFCWmIzbGptRjEzN0tsYzFKS2JWekU0SHB0SWZo?=
 =?utf-8?B?Ly8zVC94Tk9yVVNPQjFzMkZFOC8yQXBtcDhJVDZiK1hwSUN6MUsxMzd0c2lx?=
 =?utf-8?B?cDhEZnZweDZmam5hZFY3aUhZbGFPZDN2NW5MaFFzOHh0U1oxbjVqUkx0YkJU?=
 =?utf-8?B?NTZ6dWMzcnplTDhMSkducFd6N1JpMytFVHJ5L3ZOU0I1ait1a3lhZ2xiRlFl?=
 =?utf-8?B?NTV4ZkRMVmlMQmEwSU9iY2MvMDNqZ3dQTG94WGppZmhPRWdqT05odTFncEJZ?=
 =?utf-8?B?SW9ZQ3p0WlBuemI3TitTczlEYWdPeGVQcVZGTnk5RnJ5ZllZTW95c2VHdUFF?=
 =?utf-8?B?eXZzaWdsQm0wTHQ0dXVtQ1c2UXlqVlcvb1RpVTZwUkt0aWdNeko4aXhlZzc4?=
 =?utf-8?B?UXhYMGJDK3RVemlxYUNKMTJFd0xNQXQ4dmZPYzUxWm15VUJoV1VtMndQaHZh?=
 =?utf-8?B?dWRpRlZIN1ZkQmFKbG5aQ3BwRlBENTdETlVCTWpVdjdhM0JRRzc5SU1zMk81?=
 =?utf-8?B?OFhzOXNLSGUrekZTK0cyVWpaTnNvb3VyN0pDeGZjci9TQWN0SjB5bm55dXBp?=
 =?utf-8?B?MExBMnl6b3NXQWVpd3lRSWVkUXNMbFJOeWhzR3pYMjNGenZqSUF3Z3M4emd1?=
 =?utf-8?B?MXZZamQ4K1Iyc0V5ZWk0S3RWZXZ5ai9DU3R1T0c0V29oQmU2T0RocS9KQzVF?=
 =?utf-8?B?azFrWE02cnluOGNpYUFwRlN0QTRtYUN1UUR0bi8veU00WjJMNXMxUWUzQnJP?=
 =?utf-8?B?dXo4Yk52a1JkUXUwK3JVK1ZQK2JXWk4vdmRscFN4VHdTSGRCTUY0SUZrSEph?=
 =?utf-8?B?NHNHejg1RVBUdEJ1MU13MkxkbmsxVE1RY2hqcGdXQ1hJUE16SXEySGhQdTZL?=
 =?utf-8?B?cFR4QTk0Rkx3Tjc0SjdhMDl1N1RJdmVYTFBETDdVL1dzRUxCS0NLNk8rYjd5?=
 =?utf-8?B?NlJ5SlFTL0RVOGx0L1RhRDJoSGp1TFZnbjRqUWxQM1l0SDFYMEdEZnlCRHhw?=
 =?utf-8?B?K1J3UFg2VE5DUHN0a3lSb0FPbEdKaUxnSUJBcE1pVmlOVHlDOWR0Y280QW44?=
 =?utf-8?B?cFRIYUJxamtJL2Q2ZTY5b0o1VVVidkJmNVVQc05PUzFuZTdDOHlJYkoxU1lJ?=
 =?utf-8?B?RGFuV0lUeDVqVFAxUUpoVGF5Sld0WHVDbUFuZFJyVU5qdzc3OGNreVppaUFn?=
 =?utf-8?B?cW92S2xMdzI5bThuU3RJQT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB5605.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bjcwWnV6RmtUZC90QXNGKzIyeGlLWVNVbEM1akovVFhRTzN4RndCZzF3QU5M?=
 =?utf-8?B?aGpMM25sUXJyTEFYTjh2bjljdFRGTkg2SGdDb2MyR0E0RUh0VU5pK0dFWUdz?=
 =?utf-8?B?MVBLNGdJSnFMUXE1elRPeGp4WllsWjVhU2pFRUwwTGlPZHdsRTNDajljTFRa?=
 =?utf-8?B?UlYyN2hDOEJXRFQ4QjJyUHNnY2ZKZE1VNlFtVmo5djJPSEVsRkVmTW9YbXdP?=
 =?utf-8?B?RzZmaCs2dUdla3c5ZTN4Njh6OFJndzQ2eGVYcGNmK3ZLSmZWTUNmcmtDNCtl?=
 =?utf-8?B?U1F3UENta3p1M0FlQlZraTZRZ3RKQ0pQbGU3Wk1EYUlpR3J4aWZWcWJSR2Z6?=
 =?utf-8?B?S2NSS0ptYnBlL3h1NG5DWjU3aDZ6OEIzc1oybTEzZkpyOXJrM2VpaUN3SnhL?=
 =?utf-8?B?U0k3UGovTWJzT2Vqc2g1bDI1dmxpdGVENUU2SzlSeWJvQ2RxN0VCaEZuMGgy?=
 =?utf-8?B?MWNqSWxnUHd2Uk94Nk5MUkFFYzdZUHlwL0NPaUhWTWo2Nmsyb3hUWW9YS3Z0?=
 =?utf-8?B?SEw0QzRwcHpxQXpzTytSVXAvZFIrNEpoNzBvaER3SEVTUU5NTDlEMmtVejNk?=
 =?utf-8?B?QWlXTmxERDNOdmMyVXBqYVY5amlVUDJraVIzNEc1L2toREIxVHFqeDIzWENQ?=
 =?utf-8?B?dlpvU01wcFQ0M1pIdEc1QW9KWXRkSFBiNjIwQTVSMXM2QlZKMmFTYTZaOXBK?=
 =?utf-8?B?WXhtR0c0YkRxSEdjWmR3UWc4UlZ1cHkvZG0xaStidU5MU0w5LzZWYUVjYUk1?=
 =?utf-8?B?NFY2a1J1Q3FDeExhRDQyUWtRWDBXajRmalFRZ0xUM2hPSlZZbHZneWk0UEdp?=
 =?utf-8?B?dTVqMWljd1VwOGJDTVJ2dXMwdVNUY2plb3VaK2U3RU9HaWdqWHVsUUVQWkJt?=
 =?utf-8?B?U08rTjM0WnZjRGZUQ1ZrNlVGSU11MlZjKy9heDNzbU9lRncyQlFxaGRPU0hQ?=
 =?utf-8?B?NzBXVnRpSFFFZXZBMytSc0UyUFRrY1BNSEVkZTVyOTNFN3lxQXE5RkhsS1dG?=
 =?utf-8?B?QlBIZHVuY2Jhc0dmRWlJRys3MCtYSVp3ZE85OW5QakhQd0RlNnFMQk1yUlFX?=
 =?utf-8?B?c1pCcHd4Wk5GUURSQWNJVVdvVEIwMUQ1dGMrM3c4djZYNllweEdnNGZBVzdx?=
 =?utf-8?B?NFNZeEIyMWNSNGFISlFOUnNTN2RIbklOK1ZIeFg4RFVlbzNYZ3lmZDk2YnJD?=
 =?utf-8?B?NUVMclh4TnVWdy9VdVl0dFJzSFc3dHRLdzJROUVyM0t6QXRRcDJjbG4rVTlR?=
 =?utf-8?B?R1YzbEY1TkEreVdNUzF2em9sQUlYd0FKYjIydlV6SEt2VG51OGNvcUhHMHF0?=
 =?utf-8?B?a09KU2JQT21tSDUxN1hZdnJlVXhMZmczRkdOZ2FQNVBza0prNDFNdmtDNEh0?=
 =?utf-8?B?dlpuQnNhUENKV1B1QmNKaVY4WjFrR215UkNmcnFDS0VwT0Y2NWllUnorR0xw?=
 =?utf-8?B?bU1LT2VNUHdQajA1ZXRrZUdxS25SZnNleG5Ebk9KWk1RVmIyTjdmR3FXbkZF?=
 =?utf-8?B?N29jTW81Z2d6aXNxVjlNd1ViRDhISEwreGsrV3ExczhTRVgzMXNSNVRxektB?=
 =?utf-8?B?bTJaUVhIWlVYaGp3eWFDb3dEYXJZRzVJcXFJYXIwaFQ5QlVBVnQzZXdhY3kx?=
 =?utf-8?B?NUxid3g1TWUyaHR5U3RONll3TWZoMUNtWmdjcFNabk9KTlJDVnpscnNVSnFJ?=
 =?utf-8?B?aVRxKzdwN1lvZzFCNUlWM2ZtYmp1bHVtN1JUaWROTnBZd2F5MEZ1SVVnMFpy?=
 =?utf-8?B?ZkVFQjEyUFRXbUowQ3dlSEVrQ1Q0a0gyeDZBbWVYMkw1ZWZQUWVPVUcwbHF5?=
 =?utf-8?B?NWt2UXNpOTRMeit5RGJqYVVCVGd0Y2tqMlhuR0tNTVFDZU5wUEhaN3JXdWlw?=
 =?utf-8?B?OU4zL3VnTjNoOTR6V09aRGZLbFd0ZTRaaHVmM24vVTRSSTBvakMwYnVKVmti?=
 =?utf-8?B?TDg4dWFFb01MYmhwbEl3Y2srWEJjUDRobVpoYlRleVNETlh1SlRrQnBtbzJS?=
 =?utf-8?B?bWp4MWVNOUh6U012U2dsOGttQTJ6Z1Z6TXBFK2NUaHNiQTYwN0tNOTNxbU16?=
 =?utf-8?B?RndLQTAyK0hSZVVwOXhtM1hFNnFlZUhIUmV5NlJkaTlOK1lWYldUclpESlV0?=
 =?utf-8?B?R2ZhNmF5V2cvQkZobVE5eGp6MFMyTFZyYml5MDBWK2pkL2RXajdTMnI5Zm9D?=
 =?utf-8?B?ZWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <828E864B9647C445B6DA8D619EA2F0B5@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB5605.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b7f0a9c-9101-415b-f351-08dc5de34792
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2024 07:03:11.9279
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZDOGsURNkbpQ2JoLAjB58QK2pPnr895axuBNoXWm41lhZ5yfKaKjXgzylaGW3gg0l457q/7i7+bgspS66vUG2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB6452
X-MTK: N

T24gTW9uLCAyMDI0LTA0LTE1IGF0IDEzOjAwICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gVGhlcmUgaXMgbm8gbmVlZCB0byBoYXZlIGEgcHJvcGVydHkgdGhhdCBh
Y3RpdmF0ZXMgdGhlIGlubGluZSBjcnlwdG8NCj4gYm9vc3QgZmVhdHVyZSwgYXMgdGhpcyBuZWVk
cyBtYW55IHRoaW5nczogYSByZWd1bGF0b3IsIHRocmVlIGNsb2NrcywNCj4gYW5kIHRoZSBtZWRp
YXRlayxib29zdC1jcnlwdC1taWNyb3ZvbHQgcHJvcGVydHkgdG8gYmUgc2V0Lg0KPiANCj4gSWYg
YW55IG9uZSBvZiB0aGVzZSBpcyBtaXNzaW5nLCB0aGUgZmVhdHVyZSB3b24ndCBiZSBhY3RpdmF0
ZWQsDQo+IGhlbmNlLCBpdCBpcyB1c2VsZXNzIHRvIGhhdmUgeWV0IG9uZSBtb3JlIHByb3BlcnR5
IHRvIGVuYWJsZSB0aGF0Lg0KPiANCj4gV2hpbGUgYXQgaXQsIGFsc28gYWRkcmVzcyBhbm90aGVy
IHR3byBpc3N1ZXM6DQo+IDEuIEdpdmUgYmFjayB0aGUgcmV0dXJuIHZhbHVlIHRvIHRoZSBjYWxs
ZXIgYW5kIG1ha2Ugc3VyZSB0byBmYWlsDQo+ICAgIHByb2JpbmcgaWYgd2UgZ2V0IGFuIC1FUFJP
QkVfREVGRVIgb3IgLUVOT01FTTsgYW5kDQo+IDIuIEZyZWUgdGhlIHVmc19tdGtfY3J5cHRfY2Zn
IHN0cnVjdHVyZSBhbGxvY2F0ZWQgaW4gdGhlIGNyeXB0bw0KPiAgICBib29zdCBmdW5jdGlvbiBp
ZiBzYWlkIGZ1bmN0aW9uYWxpdHkgY291bGQgbm90IGJlIGVuYWJsZWQgYmVjYXVzZQ0KPiAgICBp
dCdzIG5vdCBzdXBwb3J0ZWQsIGFzIHRoYXQnZCBiZSBvbmx5IHdhc3RlZCBtZW1vcnkuDQo+IA0K
PiBMYXN0IGJ1dCBub3QgbGVhc3QsIG1vdmUgdGhlIGRldm1fa3phbGxvYygpIGNhbGwgZm9yDQo+
IHVmc19tdGtfY3J5cHRfY2ZnDQo+IHRvIGFmdGVyIGdldHRpbmcgdGhlIGR2ZnNyYy12Y29yZSBy
ZWd1bGF0b3IgYW5kIHRoZSBib29zdCBtaWNyb3ZvbHQNCj4gcHJvcGVydHksIGFzIGlmIHRob3Nl
IGZhaWwgdGhlcmUncyBubyByZWFzb24gdG8gZXZlbiBhbGxvY2F0ZSB0aGF0Lg0KPiANCj4gRml4
ZXM6IGFjOGMyNDU5MDkxYyAoInNjc2k6IHVmcy1tZWRpYXRlazogRGVjb3VwbGUgZmVhdHVyZXMg
ZnJvbQ0KPiBwbGF0Zm9ybSBiaW5kaW5ncyIpDQo+IFNpZ25lZC1vZmYtYnk6IEFuZ2Vsb0dpb2Fj
Y2hpbm8gRGVsIFJlZ25vIDwNCj4gYW5nZWxvZ2lvYWNjaGluby5kZWxyZWdub0Bjb2xsYWJvcmEu
Y29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvdWZzL2hvc3QvdWZzLW1lZGlhdGVrLmMgfCA1NSArKysr
KysrKysrKysrKysrKystLS0tLS0tLS0tLS0tDQo+IC0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMzAg
aW5zZXJ0aW9ucygrKSwgMjUgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy91ZnMvaG9zdC91ZnMtbWVkaWF0ZWsuYyBiL2RyaXZlcnMvdWZzL2hvc3QvdWZzLQ0KPiBtZWRp
YXRlay5jDQo+IGluZGV4IDY4OGQ4NTkwOWFkNi4uNDdmMTZlNjcyMGY0IDEwMDY0NA0KPiAtLS0g
YS9kcml2ZXJzL3Vmcy9ob3N0L3Vmcy1tZWRpYXRlay5jDQo+ICsrKyBiL2RyaXZlcnMvdWZzL2hv
c3QvdWZzLW1lZGlhdGVrLmMNCj4gQEAgLTU3NSw1MSArNTc1LDU1IEBAIHN0YXRpYyBpbnQgdWZz
X210a19pbml0X2hvc3RfY2xrKHN0cnVjdCB1ZnNfaGJhDQo+ICpoYmEsIGNvbnN0IGNoYXIgKm5h
bWUsDQo+ICAJcmV0dXJuIHJldDsNCj4gIH0NCj4gIA0KPiAtc3RhdGljIHZvaWQgdWZzX210a19p
bml0X2Jvb3N0X2NyeXB0KHN0cnVjdCB1ZnNfaGJhICpoYmEpDQo+ICtzdGF0aWMgaW50IHVmc19t
dGtfaW5pdF9ib29zdF9jcnlwdChzdHJ1Y3QgdWZzX2hiYSAqaGJhKQ0KPiAgew0KPiAgCXN0cnVj
dCB1ZnNfbXRrX2hvc3QgKmhvc3QgPSB1ZnNoY2RfZ2V0X3ZhcmlhbnQoaGJhKTsNCj4gIAlzdHJ1
Y3QgdWZzX210a19jcnlwdF9jZmcgKmNmZzsNCj4gIAlzdHJ1Y3QgZGV2aWNlICpkZXYgPSBoYmEt
PmRldjsNCj4gIAlzdHJ1Y3QgcmVndWxhdG9yICpyZWc7DQo+ICAJdTMyIHZvbHQ7DQo+IC0NCj4g
LQlob3N0LT5jcnlwdCA9IGRldm1fa3phbGxvYyhkZXYsIHNpemVvZigqKGhvc3QtPmNyeXB0KSks
DQo+IC0JCQkJICAgR0ZQX0tFUk5FTCk7DQo+IC0JaWYgKCFob3N0LT5jcnlwdCkNCj4gLQkJZ290
byBkaXNhYmxlX2NhcHM7DQo+ICsJaW50IHJldDsNCj4gIA0KPiAgCXJlZyA9IGRldm1fcmVndWxh
dG9yX2dldF9vcHRpb25hbChkZXYsICJkdmZzcmMtdmNvcmUiKTsNCj4gIAlpZiAoSVNfRVJSKHJl
ZykpIHsNCj4gLQkJZGV2X2luZm8oZGV2LCAiZmFpbGVkIHRvIGdldCBkdmZzcmMtdmNvcmU6ICVs
ZCIsDQo+IC0JCQkgUFRSX0VSUihyZWcpKTsNCj4gLQkJZ290byBkaXNhYmxlX2NhcHM7DQo+ICsJ
CXJldCA9IFBUUl9FUlIocmVnKTsNCj4gKwkJaWYgKHJldCA9PSAtRVBST0JFX0RFRkVSKQ0KPiAr
CQkJcmV0dXJuIHJldDsNCj4gKw0KPiArCQlyZXR1cm4gMDsNCj4gIAl9DQo+ICANCj4gLQlpZiAo
b2ZfcHJvcGVydHlfcmVhZF91MzIoZGV2LT5vZl9ub2RlLCAibWVkaWF0ZWssYm9vc3QtY3J5cHQt
DQo+IG1pY3Jvdm9sdCIsDQo+IC0JCQkJICZ2b2x0KSkgew0KPiArCXJldCA9IG9mX3Byb3BlcnR5
X3JlYWRfdTMyKGRldi0+b2Zfbm9kZSwgIm1lZGlhdGVrLGJvb3N0LWNyeXB0LQ0KPiBtaWNyb3Zv
bHQiLCAmdm9sdCk7DQo+ICsJaWYgKHJldCkgew0KPiAgCQlkZXZfaW5mbyhkZXYsICJmYWlsZWQg
dG8gZ2V0IG1lZGlhdGVrLGJvb3N0LWNyeXB0LQ0KPiBtaWNyb3ZvbHQiKTsNCj4gLQkJZ290byBk
aXNhYmxlX2NhcHM7DQo+ICsJCXJldHVybiAwOw0KPiAgCX0NCj4gIA0KPiArCWhvc3QtPmNyeXB0
ID0gZGV2bV9remFsbG9jKGRldiwgc2l6ZW9mKCpob3N0LT5jcnlwdCksDQo+IEdGUF9LRVJORUwp
Ow0KPiArCWlmICghaG9zdC0+Y3J5cHQpDQo+ICsJCXJldHVybiAtRU5PTUVNOw0KPiArDQo+IA0K
DQpIaSBBbmdlbG8sDQoNCklmIHJldHJ1biAtRU5PTUVOLCBob3N0IHdpbGwgaW5pdCBmYWlsLg0K
QnV0IHByZXZpb3VzIGlzIHNraXAgYm9vc3QgY3J5cHQgZmVhdHVyZSBvbmx5Lg0KSXQgY2hhbmdl
IHRoZSBkcml2ZXIgYmVoYXZpb3IuDQoNCg0KDQoNCj4gIAljZmcgPSBob3N0LT5jcnlwdDsNCj4g
LQlpZiAodWZzX210a19pbml0X2hvc3RfY2xrKGhiYSwgImNyeXB0X211eCIsDQo+IC0JCQkJICAm
Y2ZnLT5jbGtfY3J5cHRfbXV4KSkNCj4gLQkJZ290byBkaXNhYmxlX2NhcHM7DQo+ICsJcmV0ID0g
dWZzX210a19pbml0X2hvc3RfY2xrKGhiYSwgImNyeXB0X211eCIsICZjZmctDQo+ID5jbGtfY3J5
cHRfbXV4KTsNCj4gKwlpZiAocmV0KQ0KPiArCQlnb3RvIG91dDsNCj4gIA0KPiAtCWlmICh1ZnNf
bXRrX2luaXRfaG9zdF9jbGsoaGJhLCAiY3J5cHRfbHAiLA0KPiAtCQkJCSAgJmNmZy0+Y2xrX2Ny
eXB0X2xwKSkNCj4gLQkJZ290byBkaXNhYmxlX2NhcHM7DQo+ICsJcmV0ID0gdWZzX210a19pbml0
X2hvc3RfY2xrKGhiYSwgImNyeXB0X2xwIiwgJmNmZy0NCj4gPmNsa19jcnlwdF9scCk7DQo+ICsJ
aWYgKHJldCkNCj4gKwkJZ290byBvdXQ7DQo+ICANCj4gLQlpZiAodWZzX210a19pbml0X2hvc3Rf
Y2xrKGhiYSwgImNyeXB0X3BlcmYiLA0KPiAtCQkJCSAgJmNmZy0+Y2xrX2NyeXB0X3BlcmYpKQ0K
PiAtCQlnb3RvIGRpc2FibGVfY2FwczsNCj4gKwlyZXQgPSB1ZnNfbXRrX2luaXRfaG9zdF9jbGso
aGJhLCAiY3J5cHRfcGVyZiIsICZjZmctDQo+ID5jbGtfY3J5cHRfcGVyZik7DQo+ICsJaWYgKHJl
dCkNCj4gKwkJZ290byBvdXQ7DQo+ICANCj4gIAljZmctPnJlZ192Y29yZSA9IHJlZzsNCj4gIAlj
ZmctPnZjb3JlX3ZvbHQgPSB2b2x0Ow0KPiAgCWhvc3QtPmNhcHMgfD0gVUZTX01US19DQVBfQk9P
U1RfQ1JZUFRfRU5HSU5FOw0KPiAgDQo+IC1kaXNhYmxlX2NhcHM6DQo+IC0JcmV0dXJuOw0KPiAr
b3V0Og0KPiArCWlmIChyZXQpDQo+ICsJCWRldm1fa2ZyZWUoZGV2LCBob3N0LT5jcnlwdCk7DQo+
ICsJcmV0dXJuIDA7DQo+ICB9DQo+ICANCj4gIHN0YXRpYyBpbnQgdWZzX210a19pbml0X3ZhMDlf
cHdyX2N0cmwoc3RydWN0IHVmc19oYmEgKmhiYSkNCj4gQEAgLTY0OCw4ICs2NTIsOSBAQCBzdGF0
aWMgaW50IHVmc19tdGtfaW5pdF9ob3N0X2NhcHMoc3RydWN0IHVmc19oYmENCj4gKmhiYSkNCj4g
IAlzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wID0gaGJhLT5kZXYtPm9mX25vZGU7DQo+ICAJaW50IHJl
dDsNCj4gIA0KPiAtCWlmIChvZl9wcm9wZXJ0eV9yZWFkX2Jvb2wobnAsICJtZWRpYXRlayx1ZnMt
Ym9vc3QtY3J5cHQiKSkNCj4gLQkJdWZzX210a19pbml0X2Jvb3N0X2NyeXB0KGhiYSk7DQo+ICsJ
cmV0ID0gdWZzX210a19pbml0X2Jvb3N0X2NyeXB0KGhiYSk7DQo+ICsJaWYgKHJldCkNCj4gKwkJ
cmV0dXJuIHJldDsNCj4gIA0KDQpNb3N0IHVmcy1tZWRpYXRlayBwbGF0Zm9ybSBkb3Nlbid0IG5l
ZWQgIm1lZGlhdGVrLHVmcy1ib29zdC1jcnlwdCINClJlbW92ZSB0aGlzIHByb3BlcnR5IHdpbGwg
Y2FzdWUgbW9zdCBwbGF0Zm9ybSB0cnkgZXJyb3IgYW5kIGFkZCBpbml0DQpsYXRlbmN5Lg0KDQpU
aGFua3MuDQpQZXRlcg0KDQoNCg0KPiAgCXJldCA9IHVmc19tdGtfaW5pdF92YTA5X3B3cl9jdHJs
KGhiYSk7DQo+ICAJaWYgKHJldCkNCg==

