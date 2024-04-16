Return-Path: <linux-kernel+bounces-146629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 293FB8A6874
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D58EE28385D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 10:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8DEE127E20;
	Tue, 16 Apr 2024 10:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="G5VZlvr3";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="S/3crQA7"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BEF3763F1;
	Tue, 16 Apr 2024 10:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713263498; cv=fail; b=pxRcuQKppdhUbfhav1mEFOaTKa9HRQ/U64Ofv/Y8XRCw5hQSYcRsOJZshoah7FLoHvyletzEAD9mHOoXG+48xodJR+VYbt72Y1S2i0rpvs9TuYYGooaZ1Obh23uYgZ/5evScXisKSDLFcxternwpey2TDZBqGEH3tHmy/1W02lU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713263498; c=relaxed/simple;
	bh=nwJI2hf856hHM4Zo5Br/XF+Kp9oCDPl//yJQ67k5kYU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=a2zfMzzFBgSVX9LhZ5+ZNcBiyZENjB4Nat8ikq4K54kkjBsDCV7/gnE0lPhxEC5BN7sRQKn6kDNr3lMJ45+gOZ1USkGl/rRAwSK7RXOCWvF+Fa3kUqDkA6KCS9CckCafJR6HabnvTX0hn8Fd/5XhyfftW1hPeQ165rNg9Qq1Xoo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=G5VZlvr3; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=S/3crQA7; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 7bef2376fbdc11eeb8927bc1f75efef4-20240416
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=nwJI2hf856hHM4Zo5Br/XF+Kp9oCDPl//yJQ67k5kYU=;
	b=G5VZlvr3L2bUV3WNTaoJu62q2EQmucY26U9uX332PC8rk1wj2dizZLI2uWgsaGwwq5j5NI+XUvaoC1wAHjQVixYFyvXxvptOFHLCEN6uIvVxxashVzGIQkzpG2JZXSvHA8J1BlFhiTzbPMIwhgfoDR0f5dzMPTzJQeZ9d9cUKAk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:10292c8b-ad61-48d4-bc35-e60e31e20e01,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:82c5f88,CLOUDID:f3973d86-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:817|102,TC:nil,Content:0|-5,EDM:-3,I
	P:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
	,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 1,FCT|NGT
X-CID-BAS: 1,FCT|NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 7bef2376fbdc11eeb8927bc1f75efef4-20240416
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <peter.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 272776082; Tue, 16 Apr 2024 18:31:28 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 16 Apr 2024 18:31:26 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 16 Apr 2024 18:31:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DZHnD7AxegOj2QutLhSwqainBCj4DStx9Kdg98aA88lg8/0OjukqV9XjAEH3TtS+5SokjPa68YOK3tnBy8xskkCTrd8whFc/5o0OKRMS0Be1gjEn7IyFpCIup0bcZMebJGiyPlCJSvAYk+Yk9Wdw7tIcyDavS7H/wVNk2PggTU+koVKRnDDSw7O7Z5AU1vB2YfVuoGpgfVaTRmeylV2tQvKOGx23MqBYGJZdvlJegyJNbkt89jpyPIN/yjs2TSqJjQMq2Kg6NCqILickat2lN732m0QuSesG1qqgibkxr5GsaJiwso3hB7mb+782TVg8nTADFOFjhDFHWno2nwUX+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nwJI2hf856hHM4Zo5Br/XF+Kp9oCDPl//yJQ67k5kYU=;
 b=F1AILf6r/GluxY8yyf8yQv96nSks1p7a/LR0cMVF7BI655JQgiLXrEzfykJ9EbQ87Wc6/jDnxY+fVo/q2agJKWeal+LU/VOlvAGRhm8wUEgVbzV0ocTdnn2nvYabCn8XzAL4jTyolx03zCj1qh6R3nkVcpCzSAhIRWBeBzllhXCRvmLwFQvRa8pT0ftwnbrzgt10LXezNspkecgOl7/XIDy42USZ9P1dXeLCZZVLMrUuz70vDxPQVrDfIoM+ScLnHGj87+Kq1I15DGZ9LTqHKe749qjxGtRBRbmATXoGGby6AH8aIjpre/juIHtd3J8/13jXp2knLedGymgnSyVGmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nwJI2hf856hHM4Zo5Br/XF+Kp9oCDPl//yJQ67k5kYU=;
 b=S/3crQA7J9FuOALFDA9iErgVNx2gS7SWCkFmx4ka0bDgnGPlSL405QG2xqm0UlJbGS2o2MmN1zWEyIwfQpXDvg3dxzci8eEbumhzRDbDwemzK6UPTCljT3vU1nj34KMmDRta53qe11q6OLJ6ve7YmpmKmPw4vPJWUyx3adtRodI=
Received: from PSAPR03MB5605.apcprd03.prod.outlook.com (2603:1096:301:66::6)
 by KL1PR03MB7743.apcprd03.prod.outlook.com (2603:1096:820:ea::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 10:31:25 +0000
Received: from PSAPR03MB5605.apcprd03.prod.outlook.com
 ([fe80::3945:7dbc:62bd:c31c]) by PSAPR03MB5605.apcprd03.prod.outlook.com
 ([fe80::3945:7dbc:62bd:c31c%7]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 10:31:25 +0000
From: =?utf-8?B?UGV0ZXIgV2FuZyAo546L5L+h5Y+LKQ==?= <peter.wang@mediatek.com>
To: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"jejb@linux.ibm.com" <jejb@linux.ibm.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "avri.altman@wdc.com" <avri.altman@wdc.com>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>,
	"bvanassche@acm.org" <bvanassche@acm.org>, "broonie@kernel.org"
	<broonie@kernel.org>, "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "robh@kernel.org"
	<robh@kernel.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>
Subject: Re: [PATCH v4 3/8] scsi: ufs: ufs-mediatek: Remove useless
 mediatek,ufs-boost-crypt property
Thread-Topic: [PATCH v4 3/8] scsi: ufs: ufs-mediatek: Remove useless
 mediatek,ufs-boost-crypt property
Thread-Index: AQHajyQsFRoxXt1vlE2SkQwxcZAltLFqegCAgAAOj4CAACueAA==
Date: Tue, 16 Apr 2024 10:31:25 +0000
Message-ID: <93db93aa7eb24a255f97a1a1e8e8d936dc908258.camel@mediatek.com>
References: <20240415110012.148871-1-angelogioacchino.delregno@collabora.com>
	 <20240415110012.148871-4-angelogioacchino.delregno@collabora.com>
	 <c9634a286fbdb4c98a7fe6703a4eb10d66dfcb9e.camel@mediatek.com>
	 <4d60e9e4-9eae-4b0a-abb2-b1ad3d278fc9@collabora.com>
In-Reply-To: <4d60e9e4-9eae-4b0a-abb2-b1ad3d278fc9@collabora.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR03MB5605:EE_|KL1PR03MB7743:EE_
x-ms-office365-filtering-correlation-id: 6615d92d-214a-44a3-3891-08dc5e005e0f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?utf-8?B?WlkrYzczRkRQNXUrMUNXRklwbm9EK1lwb3BrVjJPWkd6UWFJMURmL2VYdXB1?=
 =?utf-8?B?eW1XRThaNXUvRXJnQm90N3I5RkhkMmIrQWg5bjNlOW11YTFzdTBhcjlQalNr?=
 =?utf-8?B?NlNXTDhvTlg1eUhnNWlUSktXTktVbm03dUdWRTlmRkNNd2pCUFNwRHF1d2Uv?=
 =?utf-8?B?ckYwTlZHYmNIRHhlWHBxSGpqSVloemZDeGhDRVRVc0t2a0ZWaHdUNkN0ZEdm?=
 =?utf-8?B?ZUVRUDZFbytSUUh3a1loYWhtS0VTa052MkZXNmpURnNxUUNGeDFLWDNtYWta?=
 =?utf-8?B?ZVJ4cldOakJ0YWFsb01OMXcxb25FRVc3QXNJUldSdzZabTZGREhwUkVKUExI?=
 =?utf-8?B?eWRlT0tGeThhTmVvemtoRFZBR0ZEOVo2dW9vUlJCblJ5dXJUWktEblZuajln?=
 =?utf-8?B?U1NLV2k4c1dkUEdQVkJoaWZNdU1PeVowU1c0S3lKNXBSd0EvaVFuSi9OeCtE?=
 =?utf-8?B?RGpMMjZkWlVHWHh3SWw0c1FLRTMvbGFKR01VMnlrckZOQmo5dG9VWEgrOE0x?=
 =?utf-8?B?Y1ZSZCtIVzFFZi9VYTlxS0ZPQ2lTYUQ5Y2kvQnBHTjJEeEhYTjhCbUk1STdy?=
 =?utf-8?B?ajBxQ1JSc2NTQTJNUS8xdHk1WVdET2xBenNaMWFYYlQ3Si85clkwUW5ZOXFD?=
 =?utf-8?B?RGp5WVB5QmRlNmRIRVJpcE54MmZUTmpWWHhGUmxybCt2Ukp4THVDeXFpSWpT?=
 =?utf-8?B?Z2xtbnluOU1VMVN3eDNPb1NLMFNjQjh2dEhRQlAyOGVDZUZNaEJUZnNETGdF?=
 =?utf-8?B?M2VWK014dFNub25BNi9hOFdheDd2VHQwMXNKZ3dHa0RpV21ZcDRMYy95SzRU?=
 =?utf-8?B?L0tvTXdHQnRqbFhKSlZ3RmpvSWRCZ01jbnQ0RGw3WExSK2YwcW5pWnFhQis4?=
 =?utf-8?B?Q3IvYU5GRzNsQld0UjlYempyUFkxR0FQWTZjeHhhVmk1QmhRa0U0VitNWkxi?=
 =?utf-8?B?S0hrWU5UK0kyL3p3VUdwcElib3lRRkh6QW53eW1MY2g3bDhQVWR1TXJ6dUY0?=
 =?utf-8?B?Wnl0SVlSYlFlRmdwMlk2RTdNdC82dktzbUNDNUlaVXR3ZDl0dzZVRk1lWExu?=
 =?utf-8?B?ZGF5VG1BSyswZWZ6ZzU5QlVoTGVhYW5SY1BrUWMrTmlwbHd2ZGhZR0d4azB1?=
 =?utf-8?B?L29LSUNFbE8xSTl4MzdqZ3NNNytUWm16TlVaSkJMalp5bkJ6cHI3cjR6UjFt?=
 =?utf-8?B?cGdvTUdZdStFVVVjaHNndGJ4UkpBN2VSQnFRWXBtdzhxTHJIRFRwcjBtVXU4?=
 =?utf-8?B?WGc0S2R1d1BsV0cyblJFRjk2MUl1dTlmd0MrbTBzTkdtS0VTN2UzVWxHdDAz?=
 =?utf-8?B?NkRobHpnYXlDcWkwU3FIdEZheVNuOVEvSCtOL3dodW1YL0gvMVYwaW9DbzZw?=
 =?utf-8?B?S2Z6RGpCNStDaG94VlRQUDRIMTA1cVFBWUpkVG5ObllKNUhHT1FzbkJneDFW?=
 =?utf-8?B?UmtnZm9oRkp2UHhES2xidCtFMXcvOTBLYVoxREpDMzVsalJJbUJSM2tQNU1R?=
 =?utf-8?B?d2VLV0JMbzlIYlVuRHhHY2hOUThxOWJGYnZ1L3RZb0l3OWo4STJNTitlQWdu?=
 =?utf-8?B?c1k1eCtGS1hrQVVkTXl0djNIbERvS0F4cldDVnlyTFE4d3prTXNhek9Rd053?=
 =?utf-8?B?NHRxQVdqZTNJQlNSOU5qL09qTUVsdGljcXVyYjZwRlpwd01kNGtJMm43SXV5?=
 =?utf-8?B?QUYzSXd6eDhzRUhFSkVWTkZYeXpMYzNGSU1IcDJwbjQzRWsrNmNZTVpuLzVY?=
 =?utf-8?B?bUMyVElxMDNPTTNCcllNdHo5SjVMdWxUZjEwN2xhbFhKc1B0Vks1OE5ITlQx?=
 =?utf-8?B?SkdjU2ZwcHRyRS9CZjl4QT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB5605.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V0h1eWNmZG45ekdzMXZJZmw0YmhyLzFjaW5ScllYYVo2cEJPU3VzdlRsZEtG?=
 =?utf-8?B?UG5LRHFWYW83QnZYUDBmNXlxNzJ0NHljd1RCQUJWTU9ySEZtV2t1SEtLV1dZ?=
 =?utf-8?B?RmZVNGNrMTZIOG9kYjJjN3lCVWtYYjF0K1lsSG9nS0NHUG9TazNWQW1HdkVZ?=
 =?utf-8?B?WW1ud0RPNVNRSHo4WnJqWGVYbVE5cFpITVRzQ0lNbGV4T21ya1VZSXR3SUcx?=
 =?utf-8?B?Vnh1MzNLK1BNMjhhVHpqR3lEeWpQQXJZNkRMNG9jcFNIY2hYbENpOXNQSWJM?=
 =?utf-8?B?ZHI3SkVTM20xSSt4YjFOZUFlSEZySlhhNkw2OWE4NjhOVXRjczZBT2ltVkk2?=
 =?utf-8?B?UXlXYzN4Q1VhZm85UENCcVZHdGcyeUd3OHFQbXZlOXVMdHZmU1ZQUU1ESmUx?=
 =?utf-8?B?YkdhVlhLUitZaE1hblhVcUtsblJuOXAxQ3pYdlQ4R1JmcEdTbWZxNnV5dzY0?=
 =?utf-8?B?aStaQ2JiMnNONWdFd3hVdno4OWxDWUhYT0VLbTRsSkJGQlhQS3Uya3NyTmM3?=
 =?utf-8?B?QjNESG1nL0NoR0VWc0g1UU5RYnlMUnlxdWxDT2poaHdYNjhrNXZ1ekRGakRU?=
 =?utf-8?B?eWdGbEI4U0huWi9INXBhdDY5Y3NiTXNCQ0swd3I0VzNlV0JQNXBtSUs2a1M4?=
 =?utf-8?B?NWhKZXBlbkVpdHdtd0VPbDJVQmlLaEtEVnhvZFZMSXhvSHNQMHBCbDZzN3dO?=
 =?utf-8?B?UEJlWVIvS200Z0IyK2drVkVOQVQva2tWa1Rjc09sSkRUeTlRRElRTVZmU25z?=
 =?utf-8?B?bDFlZE5KZVdTdWE2NlRleWJYa2VlWXRBQXlnUDhUdE44N0tGaDhvUGVudmZQ?=
 =?utf-8?B?L2l3RzcrV2V5L2g3aXA4MUNHTVZnakpxOGdreEgyckhiaFcxaGZ3VENjWlRn?=
 =?utf-8?B?U25wbitjL21PRXd1RXJFZzc0RmNhVkZ4dzZpOTVWOFJZRXIwSG5nd1NwdkRS?=
 =?utf-8?B?NVFFMm4xV0VsZysxeWRLY0VoZVAvWkxCbXJSanJ1RWw2VERGYnRTck02RmFT?=
 =?utf-8?B?MWJiMmZFZ1F6VjlkakZCakxKaDNqb01xOFJpWURBRm0yZStlNTR6c2NvWEox?=
 =?utf-8?B?dEl3UkRUQXgzcDF6aHE3b05NUTVITmN2NlY2SzVFSUEwSXVNdzhtOTVZaEh6?=
 =?utf-8?B?dWdyQnlNY2pOWDZQaEZhbDdocVl4elZ4ZmNPeDliYm5jemV4cmFmTWloYWdF?=
 =?utf-8?B?RkVrYnY5TXFzR0tjZFV6U29XWGI3M1VhdG1GQ29neVNhWTY0a2dzRFVuaXVZ?=
 =?utf-8?B?SFJ3cXNnR3ZWTmRhV3AzWHZEdGNFTEJ3eWQ4TVBZL3htWCs1ZmQvNmRFWlRJ?=
 =?utf-8?B?cytaYzlRVjVxMFQ5ZzRKaXlYUHlwTkFwRktLbm5jMDZGZ0NKQ09pR1ErM1JR?=
 =?utf-8?B?M21nTXhPTkYrZUFqdlB5NTdkeHBKMFo1SUw2ZlVHdUszTlo1YVB5OUwwTlEr?=
 =?utf-8?B?TXFGTUdYK1Jzc25NWjRlUjFjS1NqUDBUQ1hsbXhpSzFYczNDblJlYmg5NG9E?=
 =?utf-8?B?NmIzNnppK0RCb3RUZlpPYmlMdThwdzBCNmYyMGJhZnFkTjB4MGRZcU1zd0xL?=
 =?utf-8?B?RlZFMkEva09TRjd6ZUN5ZFZzcUhyNHFieWNjVHczQjR0ZCt0N2FwdUxPa2dK?=
 =?utf-8?B?Ni9hVVVMbzBBNXFIMFQzZUdoYkg0aDQvZGJZNHEyRUVZQjFwUjhaRU02VEtC?=
 =?utf-8?B?c1d3MmEyVGNEOGtwUHpYRTU5VlQrRFRjSWZFQ1l4bFp1bjNLQS9Ea29lKzJZ?=
 =?utf-8?B?VnZxUlV3SnpyN25CVTg0bTRrWnFYYUZlajloblhuNHBwV3p5SjhiMGJmWlln?=
 =?utf-8?B?V05PZERXUTV6aE9EK1ZETFhWaEpZeEoyUmlLZWlPUkxIa05OTlo0TG5UNi85?=
 =?utf-8?B?Z2kvYjlSZFR1eng2MUtxWGIyZkV6U3kwQjkzei92cHZBTElycXNoQ1Q5TnpN?=
 =?utf-8?B?K3ZNR2orQjJlM1d5Q1RnU1RBaSs4MnFodnlIV014RDREMVRlbzFmbGhSS1Ir?=
 =?utf-8?B?Uk1mY2FJZDQ1WmNqdDFmS2xQMHFIY1lyc0Q3c0lwOHJQeUxUclNXVnVmeVdN?=
 =?utf-8?B?bU9yUXF0V2xyYUg5YmNSQ3owM1hBbFp2emd2REJJUG1NcDVEaGo1WC91QWtE?=
 =?utf-8?B?MXlXY3EvdkV6U0ZoMVJaWGhpUEFuZk9OS2RFU1lWNWRUelFJM2wybTNSMnJH?=
 =?utf-8?B?cGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6552E74EF6E77841978571EBF982E643@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB5605.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6615d92d-214a-44a3-3891-08dc5e005e0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2024 10:31:25.0355
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C/kNlS0JWsbQYPJail0RvLayaokRbAxeyR86EhWSS6aWYGlcdxGWCe0BA2GiKp5QhRefL5Epl08pYdunCAIS4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7743
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--12.686300-8.000000
X-TMASE-MatchedRID: h20DFeLkM8/UL3YCMmnG4vHkpkyUphL9lWXxvHK+rV5NiLnjZ6LqgzeM
	avhj0dcxICeUz6t+dWbOgXE6r4gNc6afMVZ75MEJ/LLJcbWWqyi2McZY43zJ427gWSfKrKyEiO9
	fzG806wtOfnMVTL/z/xANmH21X4jRfp2Eu6Qr7YeeAiCmPx4NwMFrpUbb72MUZYJ9vPJ1vSDefx
	4FmMaZTOTCMddcL/gjOwBXM346/+wojpWQQ89dszyz63eiMu4DyufSDW439+hHss20FGjgefdJe
	VhixefA
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--12.686300-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	03953FADA54D7DBAFAC6E583639C4E52C5CE95F014B41F7A400F2DC99092AF462000:8
X-MTK: N

DQo+IFllcyB0aGlzIGNhdXNlcyAtPiBsZXNzIHRoYW4gaGFsZiBvZiBhIG1pbGxpc2Vjb25kIDwt
IG9mIGFkZGl0aW9uYWwNCj4gYm9vdCB0aW1lDQo+IGlmIHRoZSBkdmZzcmMtc3VwcGx5IGlzIHBy
ZXNlbnQgYnV0IGJvb3N0LW1pY3Jvdm9sdCBpcyBub3QuDQo+IA0KPiBJIHJlYWxseSBkb24ndCBz
ZWUgdGhlIHByb2JsZW0gd2l0aCB0aGF0IDotKQ0KPiANCg0KQWRkaW5nIGEgbGl0dGxlIGJpdCBv
ZiBib290IHRpbWUgdG8gb25lIHNtYXJ0cGhvbmUgbWlnaHQgbm90IGJlIGENCnByb2JsZW0sIGJ1
dCB3aGVuIHlvdSBjb25zaWRlciBhIGJpbGxpb24gc21hcnRwaG9uZXMgZWFjaCBhZGRpbmcgYQ0K
bGl0dGxlIGJpdCwgdGhlIGN1bXVsYXRpdmUgZWZmZWN0IGJlY29tZXMgc2lnbmlmaWNhbnQuIFRo
ZSBwb3dlcg0KY29uc3VtcHRpb24gb2YgdGhlc2UgYWNjdW11bGF0ZWQgdGltZXMgd2lsbCBjb250
aW51ZSB0byBpbmNyZWFzZSwNCmNvbnRyaWJ1dGluZyB0byB0aGUgRWFydGgncyBjYXJib24gZW1p
c3Npb25zLiBNb3Jlb3ZlciwgcmVtb3ZpbmcgdGhlDQptYXN0ZXIgc3dpdGNoIGZvciB0aGlzIGZl
YXR1cmUgZG9lc24ndCBzZWVtIHRvIGhhdmUgYW55IGJlbmVmaXRzIG90aGVyDQp0aGFuIG5vdCBo
YXZpbmcgdG8gc2V0IGl0IGluIHRoZSBEVFMuIFNpbWlsYXJseSwgdGhlIG1hc3RlciBzd2l0Y2gg
Zm9yDQpWQTA5IHNlZW1zIHRvIGhhdmUgbW9yZSBkaXNhZHZhbnRhZ2UuDQoNCg0KPiBSZWdhcmRz
LA0KPiBBbmdlbG8NCj4gDQo+ID4gVGhhbmtzLg0KPiA+IFBldGVyDQo+ID4gDQo+ID4gDQo+ID4g
DQo+ID4gPiAgIAlyZXQgPSB1ZnNfbXRrX2luaXRfdmEwOV9wd3JfY3RybChoYmEpOw0KPiA+ID4g
ICAJaWYgKHJldCkNCj4gDQo+IA0K

