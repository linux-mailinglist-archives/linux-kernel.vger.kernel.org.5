Return-Path: <linux-kernel+bounces-84687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1EB486AA26
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 09:36:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA78F1C2135A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 08:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B0C2D05D;
	Wed, 28 Feb 2024 08:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="QsNhvAeg";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="LmQlAabc"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98772C85D;
	Wed, 28 Feb 2024 08:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709109231; cv=fail; b=PbPHI/nMBghk+uKRABxTNl1/nFTDCLNO9BQvGZt5P9rWuuy1CztvsMmxgIbytWklz4b05tlO2Rx7Dbcxq6MzOffGKuUYQE1VDysnzAndSqaUbzN4ODtTD0DTaEbQpNCZIKy+fTqrUpj7zGKH5CHgHX4ZSw+vt9QCNinzw3OWGI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709109231; c=relaxed/simple;
	bh=Vxi1kkr3feifwi4H/88z9sm2LwZ7GzG31iCdfHxJ+ps=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ScAbVx/ghT6z6asbtRTocuFlMz2O6XOepHEWkAQlHMLSQi342+QaUKZcl4Aew67C1J3S9zPuXOSk/93i8L7eZpmsJ/EKij5AAO/N9vGFCfRefXgKs5lbkrgDOR8o5Z9Ed0WiuqavbR3XrROrEIVHQYCqXe5lVRe030al+7QLAkY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=QsNhvAeg; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=LmQlAabc; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 155ee94ad61411ee935d6952f98a51a9-20240228
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=Vxi1kkr3feifwi4H/88z9sm2LwZ7GzG31iCdfHxJ+ps=;
	b=QsNhvAeg8ZMPQVVGXuIgEj41v92zYTIWAFNV90sNLGnSE7W+lcunFnzCY0gq6FfPc33gYyDFhpV1dJcI90ne+ap09HYBCrB+NrG8VL01M21MWdFm3E46u88boING67o3YdgFU5sgy95YUJTvQknSLxTAtcVJ4//7mLG6FG+SAZo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:c4a5ed0e-a51c-438c-9964-012fc125c72a,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:9612e780-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 155ee94ad61411ee935d6952f98a51a9-20240228
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
	(envelope-from <qingliang.li@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1420536108; Wed, 28 Feb 2024 16:33:44 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 28 Feb 2024 16:33:42 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 28 Feb 2024 16:33:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i5ljX4fvWSV5z7NOYyK7NLaA+47UmvjfyOSaegukY6qNtFsHQKo+PgK3P76rHv2E/2lMOCZAY5q1mGjLWsXulseBd+oxLi46B5mwzPqZsNo2OS+l4RhTtbuUwqir8cmlc+hJiiDPg2qMckE29uZ+/t/ufCT2iCRkHd8NTHj6mZatYBygsi1a5aQpcoz2DEJhDYXvhq+c3zvShzkviYvT3oc5EC+SLiSpa0WTrZdUS3gXev/LjSt2jjC1DMHnuNcC1WJBv3uGr0H0hQvy7TTttFTNGyYL808Y8FLRK4Z/O0ENplPzol5O2JM9P9gcTlqfY4yG0SOASe9ZjqKxsLFItQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vxi1kkr3feifwi4H/88z9sm2LwZ7GzG31iCdfHxJ+ps=;
 b=lkA8jxLICdhkHvnXOwYOkJD0xqXfX8B2SNl8mkYLQ8oKyfmFHcZCmheRYXEAB6BQmZNfy3agNIvuMKV9uhLmuMeXLywwPwcjwfP2pYOX5+7jE3rTbbX/c4A8xVtMFQ5GkMptJiGpdxexyHnl4crsGE9kkfSj7XBgunm5mHTMdnqu+hpoj9wqaR1cDMjMvGyrtsax4YdM6wmghbXzRpdD7+O5CTUTYFeO+iELAq66DuHIjR2f1e0n1ZTqc8LL3LrOD1+D3SHTECD4Bdl/DRbqO7sLmxkbDKDwWdX/n+BfLW5Fv7TjyZJz5/gr2P6B0RU3+//yoT+EHJnj7rQeCSbqpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vxi1kkr3feifwi4H/88z9sm2LwZ7GzG31iCdfHxJ+ps=;
 b=LmQlAabcVm972Bm3bnqZXYQYTiDi9monmlMbCHeJg9RaZ4elbegqCGiDVZaMqs+e+Yod+xwwaIHL777nTXnYnjeJYSonuhHnG/cMeFNcIRIG7r7/Wp8N/WLxQJqhX0c7WeyK2HIZCkfbxSJxX/P+QA+/xo59E7/NnXs8+1wXI8o=
Received: from SEZPR03MB7830.apcprd03.prod.outlook.com (2603:1096:101:179::6)
 by KL1PR03MB7336.apcprd03.prod.outlook.com (2603:1096:820:ed::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.27; Wed, 28 Feb
 2024 08:33:40 +0000
Received: from SEZPR03MB7830.apcprd03.prod.outlook.com
 ([fe80::77ca:b7dd:820f:eb35]) by SEZPR03MB7830.apcprd03.prod.outlook.com
 ([fe80::77ca:b7dd:820f:eb35%4]) with mapi id 15.20.7316.035; Wed, 28 Feb 2024
 08:33:40 +0000
From: =?utf-8?B?UWluZ2xpYW5nIExpICjpu47mmbTkuq4p?= <Qingliang.Li@mediatek.com>
To: "johan+linaro@kernel.org" <johan+linaro@kernel.org>, "d-gole@ti.com"
	<d-gole@ti.com>, "pavel@ucw.cz" <pavel@ucw.cz>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "tony@atomide.com" <tony@atomide.com>,
	"len.brown@intel.com" <len.brown@intel.com>, "rafael@kernel.org"
	<rafael@kernel.org>, "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>,
	=?utf-8?B?QXhlIFlhbmcgKOadqOejiik=?= <Axe.Yang@mediatek.com>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>
Subject: Re: [PATCH] PM: wakeirq: fix wake irq warning in system suspend stage
Thread-Topic: [PATCH] PM: wakeirq: fix wake irq warning in system suspend
 stage
Thread-Index: AQHaaen0SRqNvMWL/Emzsq5tRAgVxrEfRB+AgAAptYA=
Date: Wed, 28 Feb 2024 08:33:40 +0000
Message-ID: <0c1e972cf506b22cb1de73c8509bf2b917c0806b.camel@mediatek.com>
References: <20240228020040.25815-1-qingliang.li@mediatek.com>
	 <1390e743-2216-4435-b2ef-7d92a55605b1@ti.com>
In-Reply-To: <1390e743-2216-4435-b2ef-7d92a55605b1@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB7830:EE_|KL1PR03MB7336:EE_
x-ms-office365-filtering-correlation-id: 10b30e72-fd06-4e7b-e77a-08dc3837f73c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NPVtvJYWTyjQXCh3W94CuJu9Shtaov5PueqSotez6i4ieMskXkn0nitKMRt8aMiqDMaFfsf07XQaZvKPIk1i9Q0UC4JCvrzhNeJwIaEZdm69dXCk71A6oLh9mehRemjowHHtwTP4zdSKZThQhl/TcDUJa1blFNCpGdv8f774snzxHf3TXKXxgkbprfxTfDvi40yLUTtdcpQu6it7ZTMYgOgfosvgEBs3BCCSv7BQwOp0Z5adPlNcFE6/qZCWmICeMQrIGKEN5dwY8b9ZsaCDTGfOYstGV8PHVIRRRoQQv2VMfPd14EuIlPGpZXQrMFxMyteFPue1KSLkknXWIgHu7GqbMBLamAp050WNnKAxRBVrZNhivnPT+wdngstWtRhTSgQhLl0hNGBY6MeRV8rPvKdFlrDssL8yo9GeYaksNSj22/uDOhUaWCUdrS6po+6mlqJ1huqtwp/o3UyaXvY55rFfOGY+K88hBdobdA3XCbZwzoqptNq4aiQpaN39YSolh8f36Up9WMVwXmpuk3fglfQYRSElsnymc6HKoOzFrP/LUgqlMuCPVydJ0KsM/zvffjo+1R6gb7eNscLwbJI/RBwdQAg00sIrR3wQnbTRXF4irCHq3tu4VMj5OrPSsWINnwivvOMaMCFB70gCrEf/WCQAPj1pw1vwWF6eUJyDbgKJvV9Z5GJ/D7H+eUor19EIvwVihgaY5rAj1P8HBuyno6A9GiEl1m6wxXNXag1tZK0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB7830.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230273577357003)(38070700009)(921011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cnlYVGZIbVVkTXdKOHc1QUhrSEhEemRlOUtPU3h6NzMxQ05MdlZxMlo4WDJX?=
 =?utf-8?B?dnpGQzc5dUczQ0NCbzFGMVNuUUhSVHNDVmhoUk83SWRIZTRzZmJoOENic2Nz?=
 =?utf-8?B?ajVwdUxMbGlyZVB3a2NqcE5OdzZMZVJoRldHTyt2bVIzU1l6YVd4RHkzcVVJ?=
 =?utf-8?B?ZUpteVpnd0c3T3Z6OGZPb28xNFNtU3dCazF2STJQVXhJSWV3R2NxSU42ay9O?=
 =?utf-8?B?MFhWVnRJMUVTc1JMNHJnRjhYZ21BVk5qUUZQWFpWakp6N3pWRGxvMFRrdFFi?=
 =?utf-8?B?cjRBTnhuTkdEOGNrMXZIcllUOGppSzRiemVZQ0I0ZElWV0g4NzVGeEVraXd0?=
 =?utf-8?B?UkEyUVN4RkdndHNMelhGZEMwK2EyVUxYOFNDM05vZ2t0LzY2VkIvVDBHN0pa?=
 =?utf-8?B?SkxoZlM3T2FmejNyUXRDVlhpTThTMG9INis4MVZ3QzgyL3N2cTlVRkt5dXBl?=
 =?utf-8?B?d1ZQYkx3WENhS1hBNmJ4YjloZTAvZHhCTEdWbFBLWWlQZ1FoRXBBSkxnL2JE?=
 =?utf-8?B?RWFiUGtsSkxwUHliSjlEU2VEL3ZZQnFQcnErbDBQWW1TZ3JDT0JTNld0bFZa?=
 =?utf-8?B?eHFRT1UremQzWWYzbEMxcXFVUnlDOC9kaDFYSGRvazFoTmwxK0RUdlVWdzlG?=
 =?utf-8?B?Y0JhTy9XMXdFYURyZ1FDWk53YXZlZFJUNHhUaUNnMVg5TUY5MEZlajhqbDV1?=
 =?utf-8?B?QjRxa1I2UFNsMzNpT1JrLyticVh5VWdwMGwrc0FaQlh6bnhQSFZxRVBTcW1B?=
 =?utf-8?B?WmR1Tzl0UFM2ZElSOTlnS0VpU1NJc29JOUxFTnVzSHlZUHRnQ0lYd041RnNJ?=
 =?utf-8?B?WEUzclFqNlUwYjAvRmZSQTZKVHl4N1JET2Y1VXFqU1BYSDF4QzFFeWRtVE14?=
 =?utf-8?B?UHVSeUh2ejNyQWpsM01XdzFMMHJzV1p5RjBsSlo5NFArZ0ZtS00wc2plS2VX?=
 =?utf-8?B?b0JhRmxJNEdad2hQNmFVSkVIenhadk9XeFhLc3NCTjhkRlNoV0pJMUtHcUxz?=
 =?utf-8?B?WGNpblFLRVc1QlVreWhxeHF5MXFRb0hmeGxuRFEySXJHeU5aUFFHVm5IOEp0?=
 =?utf-8?B?U0N2YTNJazF2TkFxZFY3Z0RUc1dwbWh6b1AyaEFVV2NLU3k4S2YyRUdaRDY1?=
 =?utf-8?B?cktjTmR2QjhFUkhEZGtIRUxZcUNXSW4rVkJQczlCZ2Q0UFpSOENrLy81VVJY?=
 =?utf-8?B?anJ1YVdjT0M1dHBneG9YMTVxM0tldXBRRnhnVzZGY0p2TmdnRlY1YkhTOGpP?=
 =?utf-8?B?dDR5MDNrTTM3b3JtaVBEbFVhazJOcXYvQTJxRi85QmNqaHZjSHB1QkcrOUIr?=
 =?utf-8?B?cFhyTkpuNTR2NlloVExSSWs2YXNReE1IcmEvZHZCQ0htcUZ6NFJ5cElDZ1RG?=
 =?utf-8?B?SUo2QWNZNllIWUJtU0QzSENTcVZKMjBLSTJaR2ZNWWQrNFlaTGh5c2FheGJN?=
 =?utf-8?B?dUxHMlZGd29RU1pSNUhiOGJKNDhYU29ueUJHRnd4TnJTZEhoL0RpYk5rVCtw?=
 =?utf-8?B?VGF2dlhNRjc1WEJPbVQvcE1zZmpaSFo3OVV2Y2NuTGlFVWlsU2NJQjdLZDFx?=
 =?utf-8?B?MUZ6M0w1MUJGcHVOVXpLTjNKNlpmRXZadzhoUEJsNkdJKzRPSUowd0JGbURt?=
 =?utf-8?B?aWtlN0F0ek94WitFMWwvaHFXOWo1MlNTL0FBd2dTRDc4WW5oU09waElqZTFM?=
 =?utf-8?B?a1RpU25GM0QxZ1VteFhPeVUwODNJWEE4OGlqWUgwdVpNT2VDcFdvMDE2UGMx?=
 =?utf-8?B?OEFodEJjcDdUbTF1bWREUTdpTWZTdStObk5jTVpVYkJZT3NtK0ZRb3VkdDAx?=
 =?utf-8?B?NXBHb1N4MG94TitnMnU3RU85ZWtlaysrdlYweDVCLzdLajVocDY3WS95V0FM?=
 =?utf-8?B?c3VVL1dzeGd3YkNoM2VoZlIyRGx4V25yUlFKRUhDMTBNbmZoQjVVNmNrOWsr?=
 =?utf-8?B?WkUyMGxSZWNFckhBTWJDSUVVOHdTQUF1MTNWc2U2b0ZwNnlMVWZ2Q0FqeWYy?=
 =?utf-8?B?M2JUeW5McXVaTmpiUWJUT2F2b2RLQnQvdG5LWFhQS0hKWEFacGZ2dE4weHpr?=
 =?utf-8?B?cEU1UUF5MmQ2MVVPeTJpRndteWMzZ2NrdkVUZCtUWjB2bmZwSGlmYkVzaVN1?=
 =?utf-8?B?NWJNWGxzYy82V3FraWZTWlJxdXpYSmVDd2xEeE9kSk5oRTREK3R4OVVUU3pk?=
 =?utf-8?B?TVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5397DC9D92E6CA43A956E5179F35744F@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7830.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10b30e72-fd06-4e7b-e77a-08dc3837f73c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2024 08:33:40.1884
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L4eHVEJ1O/IXbC9OGH8GrmYql9vh+ipOpyRMZ+45jMqSyp5QzvYtkB/i99lv1TRZ5/Hu1P5Nx+qIpE1Kua/5WusutDMv+gKnU7ZchJn8qhU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7336

T24gV2VkLCAyMDI0LTAyLTI4IGF0IDExOjM0ICswNTMwLCBEaHJ1dmEgR29sZSB3cm90ZToNCj4g
IAkgDQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVu
IGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhl
IGNvbnRlbnQuDQo+ICBIaSwNCj4gDQo+IE9uIDI4LzAyLzI0IDA3OjMwLCBRaW5nbGlhbmcgTGkg
d3JvdGU6DQo+ID4gV2hlbiBkcml2ZXIgcmVnaXN0ZXJzIHRoZSB3YWtlIGlycSB3aXRoIHJldmVy
c2UgZW5hYmxlIG9yZGVyaW5nLA0KPiA+IHRoZSB3YWtlIGlycSB3aWxsIGJlIHJlLWVuYWJsZWQg
d2hlbiBlbnRlcmluZyBzeXN0ZW0gc3VzcGVuZCwNCj4gdHJpZ2dlcmluZw0KPiA+IGFuICdVbmJh
bGFuY2VkIGVuYWJsZSBmb3IgSVJRIHh4eCcgd2FybmluZy4gVGhlIHdha2UgaXJxIHdpbGwgYmUN
Cj4gPiBlbmFibGVkIGluIGJvdGggZGV2X3BtX2VuYWJsZV93YWtlX2lycV9jb21wbGV0ZSgpIGFu
ZA0KPiBkZXZfcG1fYXJtX3dha2VfaXJxKCkNCj4gPiANCj4gPiBUbyBmaXggdGhpcyBpc3N1ZSwg
Y29tcGxldGUgdGhlIHNldHRpbmcgb2YNCj4gV0FLRV9JUlFfREVESUNBVEVEX0VOQUJMRUQgZmxh
Zw0KPiA+IGluIGRldl9wbV9lbmFibGVfd2FrZV9pcnFfY29tcGxldGUoKSB0byBhdm9pZCByZWR1
bmRhbnQgaXJxDQo+IGVuYWJsZW1lbnQuDQo+IA0KPiANCj4gSnVzdCB0cnlpbmcgdG8gdW5kZXJz
dGFuZCwgd2h5IG5vdCBpbiBkZXZfcG1fYXJtX3dha2VfaXJxID8NCj4gSXMgaXQgY3V6IGl0J3Mg
Y2FsbGVkIG11Y2ggYWZ0ZXIgZGV2X3BtX2VuYWJsZV93YWtlX2lycV9jb21wbGV0ZSA/DQo+IE5v
dCBzdXJlIHdoYXQncyB0aGUgZXhhY3QgY2FsbCBvcmRlciwgYnV0IEkgYW0gYXNzdW1pbmcNCj4g
ZGV2X3BtX2VuYWJsZV93YWtlX2lycV9jb21wbGV0ZSBpcyBtb3JlIG9mIGEgcnVudGltZSB0aGlu
ZyBhbmQNCj4gZGV2X3BtX2FybV93YWtlX2lycSBoYXBwZW5zIGZpbmFsbHkgYXQgc3lzdGVtIHN1
c3BlbmQ/DQoNCllvdSBhcmUgcmlnaHQsIHRoZSBpbnZvbHZlbWVudCBvZiAnZGV2X3BtX2VuYWJs
ZV93YWtlX2lycV9jb21wbGV0ZScgaXMNCmR1ZSB0byB0aGUgZHJpdmVyIHNlbGVjdGluZyAncG1f
cnVudGltZV9mb3JjZV9zdXNwZW5kJyBhcyB0aGUgY2FsbGJhY2sNCmZ1bmN0aW9uIGZvciBzeXN0
ZW0gc3VzcGVuZC4gSW4gdGhpcyBzY2VuYXJpbywgdGhlIGNhbGwgc2VxdWVuY2UgZHVyaW5nDQpz
eXN0ZW0gc3VzcGVuZCBpcyBhcyBmb2xsb3dzOg0KZHBtX3N1c3BlbmRfc3RhcnQgLT4gZHBtX3J1
bl9jYWxsYmFjayAtPiBwbV9ydW50aW1lX2ZvcmNlX3N1c3BlbmQgLT4NCmRldl9wbV9lbmFibGVf
d2FrZV9pcnFfY2hlY2svY29tcGxldGUNCnN1c3BlbmRfZW50ZXIgLT4gZHBtX3N1c3BlbmRfbm9p
cnEgLT4gZGV2X3BtX2FybV93YWtlX2lycQ0KDQpCYXNlZCBvbiB0aGUgYWJvdmUsIGlmIHRoZSBk
cml2ZXIgKGkpIGNob29zZXMgcG1fcnVudGltZV9mb3JjZV9zdXNwZW5kDQphcyB0aGUgc3lzdGVt
IHN1c3BlbmQgY2FsbGJhY2sgZnVuY3Rpb24gYW5kIChpaSkgcmVnaXN0ZXJzIHdha2UgaXJxDQp3
aXRoIHJldmVyc2UgZW5hYmxlIG9yZGVyaW5nLCB0aGUgd2FrZSBpcnEgd2lsbCBiZSBlbmFibGVk
IHR3aWNlIGR1cmluZw0Kc3lzdGVtIHN1c3BlbmQuDQoNCj4gDQo+ID4gDQo+ID4gRml4ZXM6IDg1
MjdiZWIxMjA4NyAoIlBNOiBzbGVlcDogd2FrZWlycTogZml4IHdha2UgaXJxIGFybWluZyIpDQo+
ID4gU2lnbmVkLW9mZi1ieTogUWluZ2xpYW5nIExpIDxxaW5nbGlhbmcubGlAbWVkaWF0ZWsuY29t
Pg0KPiA+IC0tLQ0KPiANCj4gJHN1YmplY3Q6IE1vc3QgcmVjZW50IGNvbnZlbnRpb24gdXNlZCBm
b3IgdGhpcyBmaWxlIGlzOg0KPiAiUE06IHNsZWVwOiB3YWtlaXJxOiAgLi4uIg0KDQpJJ20gc29y
cnksIGJ1dCB3aGF0IGlzIHRoZSBwcm9ibGVtIHdpdGggdGhlIGRlc2NyaXB0aW9uIG9mIHRoZSAi
Rml4ZWQiDQpmaWVsZD8gSSBkaWRuJ3QgZ2V0IHlvdXIgcG9pbnQgYW5kIEkgd3JvdGUgaXQgYWNj
b3JkaW5nIHRvIHRoZSBwcmV2aW91cw0KcGF0Y2hlcy4NCg0KPiANCj4gPiAgIGRyaXZlcnMvYmFz
ZS9wb3dlci93YWtlaXJxLmMgfCA0ICsrKy0NCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2Vy
dGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9i
YXNlL3Bvd2VyL3dha2VpcnEuYw0KPiBiL2RyaXZlcnMvYmFzZS9wb3dlci93YWtlaXJxLmMNCj4g
PiBpbmRleCA0MjE3MWY3NjZkY2IuLjVhNWE5ZTk3OGU4NSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2
ZXJzL2Jhc2UvcG93ZXIvd2FrZWlycS5jDQo+ID4gKysrIGIvZHJpdmVycy9iYXNlL3Bvd2VyL3dh
a2VpcnEuYw0KPiA+IEBAIC0zMTMsOCArMzEzLDEwIEBAIHZvaWQgZGV2X3BtX2VuYWJsZV93YWtl
X2lycV9jb21wbGV0ZShzdHJ1Y3QNCj4gZGV2aWNlICpkZXYpDQo+ID4gICByZXR1cm47DQo+ID4g
ICANCj4gPiAgIGlmICh3aXJxLT5zdGF0dXMgJiBXQUtFX0lSUV9ERURJQ0FURURfTUFOQUdFRCAm
Jg0KPiA+IC0gICAgd2lycS0+c3RhdHVzICYgV0FLRV9JUlFfREVESUNBVEVEX1JFVkVSU0UpDQo+
ID4gKyAgICB3aXJxLT5zdGF0dXMgJiBXQUtFX0lSUV9ERURJQ0FURURfUkVWRVJTRSkgew0KPiA+
ICAgZW5hYmxlX2lycSh3aXJxLT5pcnEpOw0KPiA+ICt3aXJxLT5zdGF0dXMgfD0gV0FLRV9JUlFf
REVESUNBVEVEX0VOQUJMRUQ7DQo+ID4gK30NCj4gDQo+IEJ1dCB0aGlzIGRvZXMgbWFrZSBzZW5z
ZSB0byBtYWtlIHN1cmUgc3RhdHVzIGlzIHVwZGF0ZWQsDQo+IFlvdSBjYW4gcGljayBteSBSLWJ5
Lg0KPiANCj4gUmV2aWV3ZWQtYnk6IERocnV2YSBHb2xlIDxkLWdvbGVAdGkuY29tPg0KPiANCj4g
LS0gDQo+IFRoYW5rcyBhbmQgUmVnYXJkcywNCj4gRGhydXZhIEdvbGUNCg==

