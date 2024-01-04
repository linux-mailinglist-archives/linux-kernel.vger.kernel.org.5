Return-Path: <linux-kernel+bounces-16319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 784E7823CBB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 08:26:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8ECDF1C212C5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 07:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C554200AA;
	Thu,  4 Jan 2024 07:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="OMGLCvKL";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="NttmYTNe"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0395C1F927;
	Thu,  4 Jan 2024 07:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 5c5cc352aad211ee9e680517dc993faa-20240104
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=K1m8JPDTWsOj0H971qZJrk16jbhVavgCbGuZIyMq8FI=;
	b=OMGLCvKLXQDSnAY5LaS+NPBeE7qBSzRdJvXPlnTxvoJG1EuT3FJpgqjzDmlhs7PXXBNsY+9rwPBwBnjDsxpuvX0GRV8xFYO/QYUc0X14Bnms7tKJi2/ClL3uNhgNsRRit63ovR8vEEtqEEcTzZKFuXVx8FTgdNCUiqRxaNmR25c=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:7c60cd0d-0ce9-46bc-916a-3d2233af5888,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:5d5fe18d-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
	NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 5c5cc352aad211ee9e680517dc993faa-20240104
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <chunfeng.yun@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1455005972; Thu, 04 Jan 2024 15:24:56 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 4 Jan 2024 15:24:55 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 4 Jan 2024 15:24:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PbFBaDxLbGvQF368yalbLGVfwTF/imbLwgr4f9A5bacEqQEydVMU2u/UIA/yH5/KmakInOZAAtkH6szO8Q0eR+RrKGKtHakknld98SQKPrOgyCtzNf1KS7S4abndVwiqwK9RfMNOtPxVkqWylz8mcM7aFZGS0YBAJUO0DFYiFFREIHRGZEjAHy4MKhTNsVoSNiuStUnqpgKlQCdMl4bF87Ke9jsD0X5RjirY31nETf6mlI9CpnxPAekWn9z17xm9SZp95Jf7F2O3rkIR3TOGDNJk4z7VkxgMVv2b5ETFccYMWxaKyzxQ2Wr54W5ePyeh6cS2WLlnefTa9fKziBBxFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K1m8JPDTWsOj0H971qZJrk16jbhVavgCbGuZIyMq8FI=;
 b=eLook0PlQkY9fKPD8miH/x5Ycu19UxCbVYn+RIx7d65r6A8DpL9SkwIB/7IkyRQ5mQc5tY4zHrpS/26s4obHbwxxDPJ4yYiCTosrQeZNOrx8m/yZpG6LRAIlfFlj7Hdbf9KUpreO8/Nwh6xbxOUrnjO+ESGynv3jEIbOPRiLMaVViIXq3OJivlQi976wSkhfqDkv7Q934YPNuY1INsW/MBRK6Zp0gYuZslt58BZjugCEI4UrwyZRXORdWGlasbsD5BwviJGWJ4w7gidfujiLTwj49ebuzIQ8HhcLD3WOT5IXA5qR2LEk7jenkbv/+ZaotCeWQ1dl7SVDO3QeEGmkNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K1m8JPDTWsOj0H971qZJrk16jbhVavgCbGuZIyMq8FI=;
 b=NttmYTNe9UOZDHlZRfP34iZsumhJ9UZ6LyyWhsPX6C1ggVTCfmltENgljoDJ88wVOCIP+ttwPGErRG/8SQ0Xf0IIC/xaYrvT7aV6mAh5zTyeTtRK8PvWYvMtLtQPS978r5J8gCUvAiY8+k2Y11kbZP6eyV2/YiIVCHIFp/NmwFA=
Received: from TYZPR03MB7153.apcprd03.prod.outlook.com (2603:1096:400:33c::6)
 by SI2PR03MB6638.apcprd03.prod.outlook.com (2603:1096:4:1e6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Thu, 4 Jan
 2024 07:24:52 +0000
Received: from TYZPR03MB7153.apcprd03.prod.outlook.com
 ([fe80::75b5:9f6d:dc01:9946]) by TYZPR03MB7153.apcprd03.prod.outlook.com
 ([fe80::75b5:9f6d:dc01:9946%6]) with mapi id 15.20.7159.013; Thu, 4 Jan 2024
 07:24:52 +0000
From: =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= <Chunfeng.Yun@mediatek.com>
To: "s.shtylyov@omp.ru" <s.shtylyov@omp.ru>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
CC: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"mathias.nyman@intel.com" <mathias.nyman@intel.com>,
	=?utf-8?B?RWRkaWUgSHVuZyAo5rSq5q2j6ZGrKQ==?= <Eddie.Hung@mediatek.com>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	=?utf-8?B?TWFjcGF1bCBMaW4gKOael+aZuuaWjCk=?= <Macpaul.Lin@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>
Subject: Re: [PATCH v4 1/3] dt-bindings: usb: mtk-xhci: add a property for
 Gen1 isoc-in transfer issue
Thread-Topic: [PATCH v4 1/3] dt-bindings: usb: mtk-xhci: add a property for
 Gen1 isoc-in transfer issue
Thread-Index: AQHaOIpkcdKDXzmoj0eSssQ68oUiA7C82pEAgAxyjYA=
Date: Thu, 4 Jan 2024 07:24:52 +0000
Message-ID: <97bb8db3cf03d23f92ea67afc83f2303bccbe561.camel@mediatek.com>
References: <20231227060316.8539-1-chunfeng.yun@mediatek.com>
	 <1e5772b3-2e71-069c-5794-ded2ee72222f@omp.ru>
In-Reply-To: <1e5772b3-2e71-069c-5794-ded2ee72222f@omp.ru>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB7153:EE_|SI2PR03MB6638:EE_
x-ms-office365-filtering-correlation-id: 0a092917-a74d-4f4f-0972-08dc0cf63e28
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4IYm1okLQAgSzpnhkYWoTWQnHxkuYbDFPm3oLY6/9GMcF+QKygd2Z4lFuqjJ5j7JBQMuixJCQIhh9pZXxqlaHWqTK2rkrzSE2cdWPCFWpXVA3aodHoCZ5Lz+lh61QYaT1bCLjp+DxIDFeDklOxfgYldoSKpMEXue1Z0cXVEerKNoKT6jFBVCP1P4p5DTyrIGibX9IiKw8j2XnSPOLst0aYnAX2in5zQkKaqQES0lF6UnDnTtcnTDKsuA1z+zLvCUufJopWGMO9UNEvSRVDCRFbLVVyM6uWaeHlHVpvX9qIDr1AB5f95bVllNMf/eXHijpFkqyGymf/mPBPUfz/oQ99i6uKo7nl7rOskaDcc3UoZB18pxOnqK4tIq52ARt4w+FULdTY8MKKXHuINYCxJ9zx38L5IJJh/uv3gWv7GS0c6gfAtp009wbslb/t9RMihGUn0sO7EpiFXUv6PPgLgzh5S5MswtwkYEHz26NODL9ulWwyVKRyLP6w6sAIZ186HQdk2vJ2i0WftXuclmOPJLSx/ETWicrZjMr6x8F+0XHV+KkoDG8qJgm2z4/xMdlJ9/ZWM8ffAihwpCQRDq+lBDuSl1lyc6ogSl6aEkRJ9HSHoAjaS1VmhMBPMy9iZqtLd7wi7HtahKobjRwrLLdaTRtvHf8U5rpEzKdWLBr6VUijCqM68tJtwOLvPzVf4q2T0RL12mcd8gjsyB97vMFfa8mS+nOt3UPayt4Z9PFTQoyYo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7153.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(136003)(346002)(39860400002)(366004)(230273577357003)(230173577357003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(6512007)(6506007)(71200400001)(53546011)(6486002)(478600001)(2616005)(41300700001)(76116006)(83380400001)(26005)(7416002)(2906002)(91956017)(5660300002)(8676002)(66946007)(54906003)(4326008)(66556008)(66446008)(64756008)(4001150100001)(8936002)(110136005)(316002)(66476007)(38100700002)(38070700009)(86362001)(36756003)(122000001)(85182001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QTBIZHhCbXcxdHVHd1NyMGt3R25LaXY1Ly94aldJT2ZWbnFXd3lhYjZIeVZt?=
 =?utf-8?B?VjZ1SzgwM1ZTeEpRZ29tWnE5NHAwMSszVSt4QlhsWDMwZlg1TUtvYUY4Szhv?=
 =?utf-8?B?ZFB6R2MvZk5aYWRuYWM2ZGZoaG11NEdYVUhoaXM3dXdrZW9qL2ZNQWtsRHJi?=
 =?utf-8?B?OXZiczlieU83RnIyTzJzY3R5YVJnTUUwZ2xoWUxwa0VRK015NmJmOTJKRjJP?=
 =?utf-8?B?Q0U2SDM5cVhhejhxVzMxcGhuNzJ3NXFIU1RsWGhaKzN2SU4vVFI2azRXQ09p?=
 =?utf-8?B?Zm1Xd1JDUGNyN1dteEphMkVyTzNSKzdhRUYvbXhZTUZhYytJd3duMzgwZzlr?=
 =?utf-8?B?Q2dGR1dkTEg5cnpJUlpzVWVXMm0wZkF1Z05hLzVDY2ZKRWxIMmwyOTdJazBF?=
 =?utf-8?B?SHEraDRiMit3RWIrUUZaR2JzVFAzWEIyMldyMnhCeStJUSttN25zOGVPR1p3?=
 =?utf-8?B?QTl6b0Z3TkRhejQ3VDc1ZGxMV0U5NW5qN0xLMnRISUZLaG93RVpmYUd5RU40?=
 =?utf-8?B?K3hNbjNGUGZ6V3hSZ25pYk93VUlsbGkxTVZkZmd1VEdTOHJUbE5CakZVc09o?=
 =?utf-8?B?MTFyd251cXhCRnhYSjBIVERBdzVodG1MN00ra0Rnakc1ZDh1NTdDdE1kTnI5?=
 =?utf-8?B?Qkdld1N5d0FPT25zTFRMMEtCUEQ0eWVUdDNTeFhyb0NuTFpPMlVZaHJIMi9F?=
 =?utf-8?B?OExWcUo3dFZZNFNadmcycERVRG0yWmlZWFViVVhPZjBlQXBhV3RRNytkQU51?=
 =?utf-8?B?MFZUMGFPOE0wVlJyaTc0ZmRQcXZlTmd3TVdiTmk0SFZjYmQ4ZUdCZWZXbyt4?=
 =?utf-8?B?RmNUMGsyTFk3QW1wZlBiQUJodzNWWi9weCs5cDdmQndmUVlQMUdhcVhxSGRD?=
 =?utf-8?B?cnJ1blYvM0NnY2VxaXNuUnd2aFM4Z3F3UVU5WVlWdS9nVHlvTmlhS29OM2J0?=
 =?utf-8?B?dXE3VlpiKzhxdStIZ0lIaWtKNzBkdnErWEU5SHJjcEpEUENLYVZnT3pqNEpF?=
 =?utf-8?B?VVA5N1lNc0x4cHlXOWlGRndoR0xOS0JVejBMN2VoeXZWSmNmZHBmQmppSXdo?=
 =?utf-8?B?SExrdW5CNjBOM2NmdzVKb0wxOXpDNnlQZEZFY0VhZGN2MUZWN2F4REY5aTBP?=
 =?utf-8?B?MEFmeFV2VERud2I3S013aklkQm1na1BNc2ZNZzluR2h2V0Zkeit6U2I2TGxI?=
 =?utf-8?B?ZEVnSWJteEVMUHlRaytieGRpMjlOM05jQ2gzRDk4a3A5UnJyZ0V3RDFON3pU?=
 =?utf-8?B?bVVPa3BCdEoxZnFjTlJZWSs2R28xMlhiUjdDUUJ5NThjKy9xcmljZllzU0tS?=
 =?utf-8?B?QlBHVGZYelFIQkpMQyt0Q0VOVk9wMzlSODFQMjVTUzMyTXVEaVoycHdVUmFS?=
 =?utf-8?B?ZFVEYm11L01IQWNhR1ZPNE5rTm5vT01FVHgyd3V1N2xtMHFSdzBaZTdMM1o4?=
 =?utf-8?B?QzdVZDFqMXlhdW9aaWZjTzFjYUdpV2VOWVdlK0ljNnVqeW1sRGYvKzU2VzBR?=
 =?utf-8?B?VGhvaDlJUmhjZU5ZRFZDTml1L1ZtRWxocUhUaUdvaVdWVHlvcVY0S1FFbmF0?=
 =?utf-8?B?MmZRZWMwRkd5eFBZV3p5b3RpOTR5SWllRVB6VW9OVnh1QTdDWlloZDJpbVFV?=
 =?utf-8?B?U3BTTGtES2lDOXczTi9xa2pVRmZUY25OUkorZkxxcElDNi8vSjYyaXloZFY0?=
 =?utf-8?B?blpWZEhpc21RNVdLWWtnL1BsUE5TZ2hmK0l1ZzBsMFhBNmk1YTFKQjZBb24y?=
 =?utf-8?B?V2dUYk9ncjFjLzR3VjFtV2w4R05VOUg5TEhRTlh6Qk5PNlpaUHZpY3kzK2lI?=
 =?utf-8?B?b0wxc0pWeml1T0pCb1BNdmR6QWVmNSthUThXZUhtNVBONGc5dGJHVjhyaVMz?=
 =?utf-8?B?MzQxV3lVdjg4bkJMbDh0cXF4STd6dHZ1NW5sMjJJdTEwMFdiM3BTa0JKcTQv?=
 =?utf-8?B?eWNUNzltdUFFQ0E0S2NoRmNEM1FZdkxST253WlRNZzVQbG5zUUFtcHhxalJH?=
 =?utf-8?B?MGE3YmJDQXlIdXdpajlCc0w2R3pXMmg3d2dhUG1KdHlZenBLZHZiaVM0VkV0?=
 =?utf-8?B?QUFFazcvTnAxNDYwRWtBOGR6S2hmTHVqaTV2WnpDOWYxamFFSExVSEN1SkNW?=
 =?utf-8?B?NWJjSk9pRE5zbTN5djVwRVlmSDdKVU1pOFBCQVBEY2ZhUFcxTjNHUHJGRGVj?=
 =?utf-8?B?ekE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7EA07054050724419CC56F54E15D7C10@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7153.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a092917-a74d-4f4f-0972-08dc0cf63e28
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2024 07:24:52.3659
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P3sx3AoJleBTv7XuFJ7IebC3pTTw5nS4WcDkx44rBws3kTC7VnA/LuCvuAHnZfA4V1YLgH74fhM6wzcMLaGtLNRWH9oUs7uruZpDmbfBxCc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB6638
X-MTK: N

T24gV2VkLCAyMDIzLTEyLTI3IGF0IDEyOjE5ICswMzAwLCBTZXJnZXkgU2h0eWx5b3Ygd3JvdGU6
DQo+ICAJIA0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Ig
b3BlbiBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9y
IHRoZSBjb250ZW50Lg0KPiAgT24gMTIvMjcvMjMgOTowMyBBTSwgQ2h1bmZlbmcgWXVuIHdyb3Rl
Og0KPiANCj4gPiBGb3IgR2VuMSBpc29jLWluIGVuZHBvaW50IG9uIGNvbnRyb2xsZXIgYmVmb3Jl
IGFib3V0IFNTVVNCIElQTQ0KPiB2MS42LjAsIGl0DQo+ID4gc3RpbGwgc2VuZCBvdXQgdW5leHBl
Y3RlZCBBQ0sgYWZ0ZXIgcmVjZWl2aW5nIGEgc2hvcnQgcGFja2V0IGluDQo+IGJ1cnN0DQo+ID4g
dHJhbnNmZXIsIHRoaXMgd2lsbCBjYXVzZSBhbiBleGNlcHRpb24gb24gY29ubmVjdGVkIGRldmlj
ZSwNCj4gc3BlY2lhbGx5IGZvcg0KPiA+IGEgNGsgY2FtZXJhLg0KPiA+IEFkZCBhIHF1aXJrIHBy
b3BlcnR5ICJyeC1maWZvLWRlcHRoIiB0byB3b3JrIGFyb3VuZCB0aGlzIGhhcmR3YXJlDQo+IGlz
c3VlLA0KPiA+IHByZWZlciB0byB1c2UgM2sgYnl0ZXM7DQo+ID4gVGhlIHNpZGUtZWZmZWN0IGlz
IHRoYXQgbWF5IGNhdXNlIHBlcmZvcm1hbmNlIGRyb3AgYWJvdXQgMTAlLA0KPiBpbmNsdWRpbmcN
Cj4gDQo+ICAgIFRoYXQgaXQgbWF5IGNhdXNlPw0KPiANCj4gPiBidWxrIHRyYW5zZmVyLg0KPiA+
IA0KPiA+IFNpZ25lZC1vZmYtYnk6IENodW5mZW5nIFl1biA8Y2h1bmZlbmcueXVuQG1lZGlhdGVr
LmNvbT4NCj4gPiAtLS0NCj4gPiB2NDogY2hhbmdlIHJ4LWZpZm8gc2l6ZSBpbiBieXRlcw0KPiA+
IHYzOiBhZGQgZmlmbyBkZXB0aCB1bml0LCBjaGFuZ2UgdGhlIHZhbHVlIHJhbmdlIGZyb20gMC0z
IHRvIDEtNA0KPiA+IHYyOiBjaGFuZ2UgJ21lZGlhdGVrLHJ4Zmlmby1kZXB0aCcgdG8gJ3J4LWZp
Zm8tZGVwdGgnDQo+ID4gLS0tDQo+ID4gIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL3VzYi9tZWRp
YXRlayxtdGsteGhjaS55YW1sICAgIHwgMTENCj4gKysrKysrKysrKysNCj4gPiAgMSBmaWxlIGNo
YW5nZWQsIDExIGluc2VydGlvbnMoKykNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3VzYi9tZWRpYXRlayxtdGstDQo+IHhoY2kueWFtbCBi
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy91c2IvbWVkaWF0ZWssbXRrLQ0KPiB4
aGNpLnlhbWwNCj4gPiBpbmRleCBlOTY0NGUzMzNkNzguLjlmNjIxZjIyMDlkZiAxMDA2NDQNCj4g
PiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdXNiL21lZGlhdGVrLG10
ay14aGNpLnlhbWwNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
dXNiL21lZGlhdGVrLG10ay14aGNpLnlhbWwNCj4gPiBAQCAtMTI0LDYgKzEyNCwxNyBAQCBwcm9w
ZXJ0aWVzOg0KPiA+ICAgICAgICBkZWZpbmVkIGluIHRoZSB4SENJIHNwZWMgb24gTVRLJ3MgY29u
dHJvbGxlci4NCj4gPiAgICAgIGRlZmF1bHQ6IDUwMDANCj4gPiAgDQo+ID4gKyAgcngtZmlmby1k
ZXB0aDoNCj4gPiArICAgICRyZWY6IC9zY2hlbWFzL3R5cGVzLnlhbWwjL2RlZmluaXRpb25zL3Vp
bnQzMg0KPiA+ICsgICAgZGVzY3JpcHRpb246DQo+ID4gKyAgICAgIEl0IGlzIGEgcXVpcmsgdXNl
ZCB0byB3b3JrIGFyb3VuZCBHZW4xIGlzb2MtaW4gZW5kcG9pbnQNCj4gdHJhbnNmZXIgaXNzdWUN
Cj4gPiArICAgICAgdGhhdCBzdGlsbCBzZW5kIG91dCB1bmV4cGVjdGVkIEFDSyBhZnRlciBkZXZp
Y2UgZmluaXNoIHRoZQ0KPiBidXJzdCB0cmFuc2Zlcg0KPiANCj4gICAgRmluaXNoZXMuDQo+IA0K
PiA+ICsgICAgICB3aXRoIGEgc2hvcnQgcGFja2V0IGFuZCBjYXVzZSBhbiBleGNlcHRpb24sIHNw
ZWNpYWxseSBvbiBhDQo+IDRLIGNhbWVyYQ0KPiA+ICsgICAgICBkZXZpY2UsIGl0IGhhcHBlbnMg
b24gY29udHJvbGxlciBiZWZvcmUgYWJvdXQgSVBNIHYxLjYuMDsNCj4gdGhlIHNpZGUtZWZmZWN0
DQo+ID4gKyAgICAgIGlzIHRoYXQgbWF5IGNhdXNlIHBlcmZvcm1hbmNlIGRyb3AgYWJvdXQgMTAl
LCBpbmNsdWRlIGJ1bGsNCj4gdHJhbnNmZXIsDQo+IA0KPiAgICBUaGF0IGl0IG1heSBjYXVzZT8g
QW5kIGluY2x1ZGluZz8NCk9rLCBJJ2xsIGZpeCB0aGVzZSB0eXBvcywgDQoNClJlcGx5IGFnYWlu
LCBwcmV2aW91cyBvbmUgY29udGFpbnMgSFRNTCBwYXJ0Ow0KDQpUaGFua3MNCj4gDQoNCg0KPiBb
Li4uXQ0KPiANCj4gTUJSLCBTZXJnZXkNCg==

