Return-Path: <linux-kernel+bounces-74327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D801685D2D7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 09:50:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E5C0284BB3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 08:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074213CF52;
	Wed, 21 Feb 2024 08:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="CG+0dCSB";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="wcTOQZH0"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3153C46A;
	Wed, 21 Feb 2024 08:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708505424; cv=fail; b=YI1p4OisRRNGl9fHP8psiNaSa3bgdt3V/9DZqJ+iakGtMFXkdWsz3T8jznsRIbPsdcziFOTqatmZY91sona9St5CxO3pIku6i0Z15i2M7Vbsr497tWtE8Js5EU5TV5DOGxYy8NcTpnO8d0nfO0vW9PRYvfZJ/sHCophsA2pApjg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708505424; c=relaxed/simple;
	bh=ys8rBxMU5+GFRsR2gUFLXw45gTWMM1opx1fo78mc6X0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=D54Qsl8iRWfGypRdiuZwQUXC3X70diHcfdch3iu0P3s16XYxQkkJZzPEyIk8NUivm2lrlUGemJoMKIYdyvF/nrlC6EGq7e7+1w2jaN/YcXzflxOH6ipkY9dxwZ9KCGo+Gld/CaAsDEEJvzaebNDLReG2J8dMaPNhNwysxHwyByw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=CG+0dCSB; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=wcTOQZH0; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 3bb8e920d09611eea2298b7352fd921d-20240221
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=ys8rBxMU5+GFRsR2gUFLXw45gTWMM1opx1fo78mc6X0=;
	b=CG+0dCSBdY3P+GW+wP67OfXiF0Cde4tfv3wewQziZ36AHL9ub/XCrGrwCCE/VW6mEQ06vONJ6W9ulqlQf4yoXuBR0/SUw5XUUCnnAuKMbmqzYqWoLg94OXcTbE0UVF7tif0v4bDLcfbBG7GuzLGpXXi3I4GHMKhXVPZUTXceXEI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:b8d7a82d-5633-457a-90d7-d9d1b63bdbb1,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:ab33a480-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 3bb8e920d09611eea2298b7352fd921d-20240221
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <peter.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1893132544; Wed, 21 Feb 2024 16:50:16 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 21 Feb 2024 16:50:14 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 21 Feb 2024 16:50:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RM2zs7iT8yIVrUwHywqVbL01V3sgRPz3OqR8432nHeyH1ie9ftGAicqy5hIdbbvG1khxys3MES5zhGoMcnzUmjNCFTjp12U/GlGK2FAt1r/fubRf3hj4janrglqHNgbaLwBFFkIzwJZvvoY5MAQ+/EFc4XOx+nY0ZoiYZ8bCkSct6S0Q1vSlKTyx1OCxFPf0v4DtuUY2+t1ssFu2FZROwp1r0GDu8qkkVI4jmoYxHAvpEF7vi0kRoQCDXnzdB95UOjlrvR5JrytObrXts81cBZOEFBTGHmMYolau05zFXFaZ9W0RTaMzQAyJnEpLyynPvYhLYyyPxyrwyN4lfzDLXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ys8rBxMU5+GFRsR2gUFLXw45gTWMM1opx1fo78mc6X0=;
 b=iuMp1BUaoHwDqEfIFR+xkDbGCinfHDgBg3U/69giEr9oU0SMJgvEz8KXY66Dm0kA1NAVRrR+tuRWvvm2mlCgcV3Hjezkgln2Mdx3kqCwuUCJt1c/AEpSrXolLwprNJhftLuHfQJuEBIa5qA2mniKZNKJ33EkVwinAthwkLSgirKKOFxW4q/kqUuPDQ3ZjH4BjZk3DT5nBfZnvdt+7ZApKQOgyj0GIaMHRWvtOv2Gd8QvVZuqTL3LOR+OWSexjNItdHflzDAnyrKGn4hJ/pMZw0lfvaOnO4DjaHG3Z/Fz6Igc+FsjsWIWc18lOBR9zG8DOTE0QuW/w7mHD4Cc2eCE1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ys8rBxMU5+GFRsR2gUFLXw45gTWMM1opx1fo78mc6X0=;
 b=wcTOQZH0CBAKin4Dlv4zXUzySfxoHA7sGQH391Hzo8LbjJSXFH9ptGcxK26c7SguTBMbH5j+H9Zn3jWd3sPXEcbDKhIJakp0Mqlc80I+HTo13R+TCmcP2mc8UHyZjty+akvYH9f8Px3rqR3C4E0yGL0H+dcmA3XMqGndp9MIaeI=
Received: from PSAPR03MB5605.apcprd03.prod.outlook.com (2603:1096:301:66::6)
 by PUZPR03MB7061.apcprd03.prod.outlook.com (2603:1096:301:114::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38; Wed, 21 Feb
 2024 08:50:12 +0000
Received: from PSAPR03MB5605.apcprd03.prod.outlook.com
 ([fe80::b3e8:3d9c:baa1:fe29]) by PSAPR03MB5605.apcprd03.prod.outlook.com
 ([fe80::b3e8:3d9c:baa1:fe29%5]) with mapi id 15.20.7316.018; Wed, 21 Feb 2024
 08:50:12 +0000
From: =?utf-8?B?UGV0ZXIgV2FuZyAo546L5L+h5Y+LKQ==?= <peter.wang@mediatek.com>
To: "quic_cang@quicinc.com" <quic_cang@quicinc.com>, "beanhuo@micron.com"
	<beanhuo@micron.com>, "rohitner@google.com" <rohitner@google.com>,
	"bvanassche@acm.org" <bvanassche@acm.org>, "martin.petersen@oracle.com"
	<martin.petersen@oracle.com>
CC: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"avri.altman@wdc.com" <avri.altman@wdc.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "quic_nguyenb@quicinc.com"
	<quic_nguyenb@quicinc.com>, =?utf-8?B?Q0MgQ2hvdSAo5ZGo5b+X5p2wKQ==?=
	<cc.chou@mediatek.com>, =?utf-8?B?RWQgVHNhaSAo6JSh5a6X6LuSKQ==?=
	<Ed.Tsai@mediatek.com>, =?utf-8?B?Q2h1bi1IdW5nIFd1ICjlt6vpp7/lro8p?=
	<Chun-hung.Wu@mediatek.com>
Subject: Re: [PATCH] scsi: ufs: core: Fix mcq mac configuration
Thread-Topic: [PATCH] scsi: ufs: core: Fix mcq mac configuration
Thread-Index: AQHaZKL7SE+FRSJBVkmu3nDoj2Tl9g==
Date: Wed, 21 Feb 2024 08:50:12 +0000
Message-ID: <2e21a0fb608858b2492808ee35da2c335ce4c0c0.camel@mediatek.com>
References: <20240220095637.2900067-1-rohitner@google.com>
In-Reply-To: <20240220095637.2900067-1-rohitner@google.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR03MB5605:EE_|PUZPR03MB7061:EE_
x-ms-office365-filtering-correlation-id: d71fbfdd-d4d5-47f4-4977-08dc32ba1d97
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B5t6CrsN2Q+Fkwjj0M8AZE+AGvod343d0CARRdiezgV7zzMHrzpVI4/kD5UiQaQkJ8LW/kqet6rVFVRQoNEIcw1sFo9jalQgb5AVhw7U1CuLQ5E2co1VayT7NlSgsOKZYKRh5YDCOTt1mZ0XseTk56pgxyYbi4V95H7lJlVr8XHzZSL7bdIDLZ7LdXmmlsoo6Ym4XQgY/oLWAufJclXbAlS0SQTgCgc98VwgOKHkPaafIQNsbRX1NoqDHNE7UKrsLD22FTgvJWx4DCMS6pI7i780Y6eH+IlMFhw+UgmdjF+r9Ko44KIBDA+lNkfuePTtiW6qlvo0BHJscfA+5EzdfYe42n1AKmVHOUnILIrF7/BoacN+JteQtoBWpSv8+mjy2lswDVcMwx1/hD4IoGVDz4RCu5lMhWQhDHHWzwXmasMoXNX4tTW93SGVx4tgHh21jXem7l1R2eB9PDloSD7bkR1SOuG2NWAOdNyBWOUUpr3t1rGSUd0T7QCMwfPIbzVgTKlVM3eidtHqjQDCBPQ0d6NKAJhQEXZ2mpDu/Ev45KZtAdPw9KtIzQxFvfeSVf/Fn0puYANxkmiL3Cl5AIMoqDNagIZab5Oz+OGQhUm6HNYUC0Fer91TgNniFsDmNW9M
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB5605.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T0JRTU15WWFKY3JyOWIwZGhTWmIrQk4zaVcyamlhZmJpV0JJejNKQ1llWWNP?=
 =?utf-8?B?dVRCWFB5OXZRczdHWWJ4M0tGTlRzbHNnOU1YQkoyUzZVYkRKZGVjb3dBRENH?=
 =?utf-8?B?OWhaODdndzhnb2NmTHRlNEFXWG9oZncyOWhjalEvM1NDVDZtYUVFZWtRR2Zq?=
 =?utf-8?B?NEd1YVFDRWdTMnZKdUNjUDZwOVlQaDA0NHMyL0VsVUZxUSt2M3FKMHBWS1BJ?=
 =?utf-8?B?UjRiaHNnWENMRUJFa21hWnhYNlVjTE4yMXdUTk5jd0pVc3BvVUtOTnFOVTcy?=
 =?utf-8?B?RFdGdHlFQmpCQXZlTVh4LzJvNG9VUzhuRnh0aGlTK21XYktlYTlmNy8xMExp?=
 =?utf-8?B?eFJDWTdwUFhTUEtaZXAyZThJT3AvZmtNQy9iQkpXWUdUd3VhY1Z3UjZGM3Jq?=
 =?utf-8?B?SkJ4K3lHSHRYWk4wUnhNYkdGaUZ4UlpQZGlVcUUxYU1XdjdIcDFJdjVPQU9J?=
 =?utf-8?B?cWtOdUJHdWpTeTE5d05PTTJ0cHc2MnAvZ1ZJYkxpUGZQV3dqU0dmNDhlZks4?=
 =?utf-8?B?VUpLZURFeVBya0NicjdxSXhxRllaRTdnMmdaT2M5bHRtK2FwbzJaYWdZUmZH?=
 =?utf-8?B?S2tBdFJqcW9KOUk1WFo2MGV2eDViRng5eDZtR09HdWc0Q2FOUGhZeDZFdUxk?=
 =?utf-8?B?ZjhRNHowV0NuYWVmOEtMTEF1TXJMSDZGSkZjNHZmYXhxbmszU0hPRWt3UXhz?=
 =?utf-8?B?eWhaaktMbk4rOWcrUHFTNnJZQU1EMXJrRjl2c0crczBwTmVaY2tSTE5iR3Np?=
 =?utf-8?B?bTI5VEprV1JheVlma0RQWWJ5N2ZNLzNnamdPdTBSK1dXTi93RnNFM0l6dWxK?=
 =?utf-8?B?aGowUGNleDNIcHVuWGovbjlpeUxVd0xDcmc2ekM5YVhXbjgybVpDT0U1OExX?=
 =?utf-8?B?d3lvemhRSm5OMk9jRVAvRDBHSUpGUzJrUWdXS09pZHUrc2lyU0N5YTVEMUw3?=
 =?utf-8?B?aEtJcnFwOVlUWlJKMHFhT1NQQ2c4cWJPZzhhejNvNWliTXJFN1d1WTJ3Vm1V?=
 =?utf-8?B?K2NIQVRid2Y3TG1TYXk5S3FXblJIc21qMUNDS01EMUp2OUxPbmVKRVFOaE92?=
 =?utf-8?B?NkdvYmlrNDJ1bzgyQ3RQOThrQ045VFh3ZkdZZ29seGRoL1M1TXJSWHhJa0Ns?=
 =?utf-8?B?YzNpWlBabjNBemFBVUVSSWdINGRJR3dDbnhlQWwvNjZubUg0YmVQbWhRY2NI?=
 =?utf-8?B?a01kUy9KckxlV2hPKzlBazBXenFlQnJLdkFrWGw2SG1rNTJOY0hvaFE3cXdK?=
 =?utf-8?B?TDRRcW5LcFByd1NIMm9INXZsNEQ0K2d1VWkxRFZCTjdCd29CVm5tZ0pLUlNy?=
 =?utf-8?B?K2RJNTVkbXB0SUdTTEZZbFhoaXlLb2dJa0tOQkhQUDhpVlQvdm1keEsvUGlK?=
 =?utf-8?B?Sk1PVXFuMHV1Mk5BQVNVSHdaMWtWU0IzQW9CZG42U3ZLU3BmWURxMVFQZElF?=
 =?utf-8?B?S0ZUUEo3RGphMitEei9lLzZoMmFvKzZmNW84SWc4dnp1WENMWFBMTzJETm00?=
 =?utf-8?B?c3d5MjVobGFzWXVUMk1TNUVGWi9oaTh1R09jZ3dnVm1iREpsemVTcmpLODl6?=
 =?utf-8?B?dldScU02VHhES2FudVB4blNHTWJKbGNRWjR0bUt3YjNIRnN1ckltOWxMN0E0?=
 =?utf-8?B?TUJxTkQyanVKYXhPRlBBZ3FVZW1tUXB4M1ZBWWhsMXE2cWI3aStEQnVJOFAx?=
 =?utf-8?B?VEZpWVA0T3ZkL0FQc0NQVVNpTTdqWDl3eUdNUEFRSHpqc0trQ25GU3ZJSlIw?=
 =?utf-8?B?SUpwQU52ejl6b3ByRlIxN1FHa2s1cXdUOXBrWlh6enBKUWw4YVFIdTFvTzRZ?=
 =?utf-8?B?THFIRktobGFuS2Z1UG81bXlURTM5eU01UUVSNG8wUHZ3a2ZON1Y3ZnhMNE9Q?=
 =?utf-8?B?NVplenoxeW5tcVc1R0RVbG0yd212SkR4L0YvZ3FWSW9rNzRjajhQTkhBZjBu?=
 =?utf-8?B?UmYxbnVMNXRGRkZ1b2ZLdG50MEJuWmd2LytxWFV0UEFjbmtUQXJUdnpsZVBm?=
 =?utf-8?B?aTM0L0FhUHhOQVhpVWVLMldOV2Z6Qzd1T3FqTWtIY2xjMUdQYjdpMWdMUzJ0?=
 =?utf-8?B?SlBzS21ORnF3TWhhNTgxcUtMK2taSnk5VFZSODNPM0dJQ0t6ci90MTl2YmVq?=
 =?utf-8?B?S3dSdi9xM3M5KzVLelN0U1hKNm0zcC9oeTFRT3RrbjhDNzlkT0pmUklVOVA1?=
 =?utf-8?B?L3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DC4B2E7D86AE2849ABF84DEE9635A216@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB5605.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d71fbfdd-d4d5-47f4-4977-08dc32ba1d97
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2024 08:50:12.1404
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8YXaNLPWlQ3PD8K0sP3d4yz/r2PxlRTAPfd1b0yeDWCbe1W0EChiR2Ca2IQPy20sjzLs+KcByL5KfC9EanwEvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR03MB7061
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--8.357000-8.000000
X-TMASE-MatchedRID: zdfKSpJbRLjUL3YCMmnG4ia1MaKuob8PC/ExpXrHizxY/2pi7PK0EsMp
	IZACY/bBlXot2Ppma3HbCHv011Gy9TZ4EzKAlFUUEgwM8US/pTHzWEMQjooUzThgoAzehG32XRy
	9DgTwN1RlRmj8RWICF5GTpe1iiCJq0u+wqOGzSV1WdFebWIc3VsRB0bsfrpPIcSqbxBgG0w6cX0
	3J2z6hlSnIwu0iRHvq9tHECSgZ2STduz/BNvPfvFfdr6q3hrL2Kxixdz/JGvsWU/P7GafmTo4ke
	DeY6p4QO7iWuyXBMvRWabE4FpgZhROONBgNbV8r1KFk+1yFQ8L2cSiCb/O0tA==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--8.357000-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	71382F645F9E5C0E463C34D02D05D800DA38255FD6BCB6F2C76690E12980D0962000:8
X-MTK: N

T24gVHVlLCAyMDI0LTAyLTIwIGF0IDAxOjU2IC0wODAwLCBSb2hpdCBOZXIgd3JvdGU6DQo+IEFz
IHBlciBKRURFQyBTdGFuZGFyZCBOby4gMjIzRSBTZWN0aW9uIDUuOS4yLA0KPiB0aGUgbWF4ICMg
YWN0aXZlIGNvbW1hbmRzIHZhbHVlIHByb2dyYW1tZWQgYnkgdGhlIGhvc3Qgc3cNCj4gaW4gTUNR
Q29uZmlnLk1BQyBzaG91bGQgYmUgb25lIGxlc3MgdGhhbiB0aGUgYWN0dWFsIHZhbHVlLg0KPiAN
Cj4gU2lnbmVkLW9mZi1ieTogUm9oaXQgTmVyIDxyb2hpdG5lckBnb29nbGUuY29tPg0KPiAtLS0N
Cj4gIGRyaXZlcnMvdWZzL2NvcmUvdWZzLW1jcS5jIHwgMiArLQ0KPiAgMSBmaWxlIGNoYW5nZWQs
IDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy91ZnMvY29yZS91ZnMtbWNxLmMgYi9kcml2ZXJzL3Vmcy9jb3JlL3Vmcy1tY3EuYw0KPiBpbmRl
eCAwNzg3NDU2YzJiODkuLmM4NzNmZDgyMzk0MiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91ZnMv
Y29yZS91ZnMtbWNxLmMNCj4gKysrIGIvZHJpdmVycy91ZnMvY29yZS91ZnMtbWNxLmMNCj4gQEAg
LTk0LDcgKzk0LDcgQEAgdm9pZCB1ZnNoY2RfbWNxX2NvbmZpZ19tYWMoc3RydWN0IHVmc19oYmEg
KmhiYSwgdTMyDQo+IG1heF9hY3RpdmVfY21kcykNCj4gIA0KPiAgCXZhbCA9IHVmc2hjZF9yZWFk
bChoYmEsIFJFR19VRlNfTUNRX0NGRyk7DQo+ICAJdmFsICY9IH5NQ1FfQ0ZHX01BQ19NQVNLOw0K
PiAtCXZhbCB8PSBGSUVMRF9QUkVQKE1DUV9DRkdfTUFDX01BU0ssIG1heF9hY3RpdmVfY21kcyk7
DQo+ICsJdmFsIHw9IEZJRUxEX1BSRVAoTUNRX0NGR19NQUNfTUFTSywgbWF4X2FjdGl2ZV9jbWRz
IC0gMSk7DQo+ICAJdWZzaGNkX3dyaXRlbChoYmEsIHZhbCwgUkVHX1VGU19NQ1FfQ0ZHKTsNCj4g
IH0NCj4gIEVYUE9SVF9TWU1CT0xfR1BMKHVmc2hjZF9tY3FfY29uZmlnX21hYyk7DQoNCg0KTWVp
ZGF0ZWsgaG9zdCBjb250cm9sbGVyIE1BQ19TVVBQX01BQyBzZXR0aW5nIGlzIDY0LCB3aGljaCAN
CnNob3VsZCBjb25maWcgdG8gMHgzRi4NCg0KDQpSZXZpZXdlZC1ieTogUGV0ZXIgV2FuZyA8cGV0
ZXIud2FuZ0BtZWRpYXRlay5jb20+DQo=

