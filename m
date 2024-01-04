Return-Path: <linux-kernel+bounces-16349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30987823D1E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 09:03:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91CFA286B56
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 08:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E80A920300;
	Thu,  4 Jan 2024 08:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="cLQ0v8bu";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="aeZCNbe/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B6B20309
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 08:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: bdce6000aad711ee9e680517dc993faa-20240104
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=BNZZmde0kHmucizTAmNRHAgLkscLyc53H1Da6I13hTw=;
	b=cLQ0v8bus3yHP3RSrr96Ygt3RcypODcYGfbcjzGiZHAnXYQvEXib1WMJoanm7gHMmQZ7l/tw+jetaZfpu0NQKDK8dkxhJUkJIQEI1O65l263nc3G3ubkVSLQyas2hAFyH0nTDf9ODSoHx5BWIzTI3QZTEGirkszJJ+7UJOCTdJM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:21e25550-4964-4165-aa70-c05c9ae139fc,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:8ee77a82-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: bdce6000aad711ee9e680517dc993faa-20240104
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 206416059; Thu, 04 Jan 2024 16:03:27 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 4 Jan 2024 16:03:25 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 4 Jan 2024 16:03:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m+RYTE6aYt8LASzoh63OqFoKzMVY+aHAG6LvnuZiIV2EPy+kjI4qTsPnwYyA4BFTz34x+FAN3nU+FfjE2RBCe2IQ8oZdYlfrIG/+FOVchPrZDTf1fA6g1OawYPrE0wtZz5zEnWOXgmsqz0mjDSp49mTJjYnWQvCIDjwinPpYzmN3aoZrzV2IbDiqdq9U1o2/vR2T0kyMq70XTF2h85ligeS4pYXSt/aJBGet8qejsfef33MKy0GpEpfLjzUIyuCDwTNBH1G2znMWbQF+xdskO+yg0MoRavg9KPtdUH0O9/dGsrd74B1A1ufIlt7GPDmSxGL0m3b2JA2htBKIf9od9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BNZZmde0kHmucizTAmNRHAgLkscLyc53H1Da6I13hTw=;
 b=AqS3OIMuizfJ+k7CYmYGdNJi+e5miJlHygbgy84C7/KKjXVXJc4cvJrnWJVE+veAmNHq0EjrB8D1AOdTasGYVD8Qj4Gh8V1exxx8SsVEkfzhEdj+M+Q/4YqDGI6uKgLOHHb4BXe1Mit8AeiR10msEAstGdheLRBgFj/qFH7CAlP9A30qk1pf7lSwVHc2Ha7jJzJ6mLaY51S1EPcmj96a8X8aWtQsm417ILo68Gah10LQYA27CFXJNfvzVSsd+VYvWzkkS5eHGEuSqDyQoEooCvbVhU1BYKdOMXjf1JjIoEqMuNNHETdCBGOLiuSB9laqSkBpanYmfm3Y6oso7f1dRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BNZZmde0kHmucizTAmNRHAgLkscLyc53H1Da6I13hTw=;
 b=aeZCNbe/g8pWWb/60gMkNVXBNPFRvfyUTPun0fF4AcET4jJTVfi2Djvaeg1vs4nvlL6Y2LV35aZJKFbBSex8MagHUSxHL8bTlCDRiHtnO0l5gVfXcTQURHqSf3iXlnqXnCbvrx5UfLmyWJaINExCEOnKq+qqCr05nKByZfq1zaA=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by PSAPR03MB5207.apcprd03.prod.outlook.com (2603:1096:301:16::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Thu, 4 Jan
 2024 08:01:21 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::eb43:57cb:edfd:3762]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::eb43:57cb:edfd:3762%7]) with mapi id 15.20.7159.013; Thu, 4 Jan 2024
 08:01:21 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: =?utf-8?B?TWFjIFNoZW4gKOayiOS/iik=?= <Mac.Shen@mediatek.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
	=?utf-8?B?Sml0YW8gU2hpICjnn7PorrDmtpsp?= <jitao.shi@mediatek.com>,
	"daniel@ffwll.ch" <daniel@ffwll.ch>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "airlied@gmail.com" <airlied@gmail.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	=?utf-8?B?U2h1aWppbmcgTGkgKOadjuawtOmdmSk=?= <Shuijing.Li@mediatek.com>
Subject: Re: [PATCH] drm/mediatek/dp: Add the HDCP feature for DisplayPort
Thread-Topic: [PATCH] drm/mediatek/dp: Add the HDCP feature for DisplayPort
Thread-Index: AQHaHrPjdunoffcOCEGmErF8vNrJIrDJivgA
Date: Thu, 4 Jan 2024 08:01:21 +0000
Message-ID: <b377c3e3c5419ce222d5d85ddf29abe3459cac73.camel@mediatek.com>
References: <20231124085346.26602-1-mac.shen@mediatek.com>
In-Reply-To: <20231124085346.26602-1-mac.shen@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|PSAPR03MB5207:EE_
x-ms-office365-filtering-correlation-id: 99b49954-8ab4-4821-52f2-08dc0cfb56c4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XSTAqq1BEo1NwMBT4vPvgwGVCPLOW/HmIQ5JAC9d+9PgV+sNObx30tozY6p6IGQI5hHRSR0nO7tvY5E/Tv3Hw2acMzAXNaw7DQxHuHmOYw+oMD5cW4YLtbPuVHcD2fmJadA8qvcA0U+4vPEL3bh3qw3DLjU51kXRiJBz+GNyJaMIkDt23rfyAiBBJd+uU7ZJqBW/5ZLpx4brEigqyYsXaiaOVv//FHOHtOhYfi3rSueZrw8j/HC6T11RTlnXv99ZCaF6B1u5KI64ThVpc2ACXW+u4vh+pg+vWBIyHM6QYj+zkta6Y2BwmURD//aYH1sEiOQns867N45b74LFyOFgArWNAe0MIp8QIpV610slqCgToIM0HElS6nXLbKJKTiuCE32x8sgAXIJVqD7YYC7oCliLsSc0KWdLNYncM36YYRvrjVpGZPa7IUgBRN/5nAtUFTmBWQVFRVLdjxEqwb0/gvRVN14c8yDXI+dTTVu8C53fPDM4k99Yx9diRyM7hUzRYjl/LjnzqatS5M2vTulTIOPWtKEdNinmW4mE6J5GgII5UWMNWaKodBvGrymppweRha0plLPavt5cQtIM204isA7apgb2kr15K30yYvaAzLO4347WG+AL9oi2C68KOUAy9vqkHJt+WNMuXB6JkeC7jig8deiIAuDbIIzZUmbdyG0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(39860400002)(396003)(366004)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(38100700002)(122000001)(38070700009)(85182001)(36756003)(86362001)(107886003)(2616005)(6506007)(71200400001)(6512007)(8936002)(8676002)(110136005)(54906003)(316002)(64756008)(6486002)(478600001)(4326008)(66476007)(66946007)(66446008)(66556008)(76116006)(91956017)(26005)(41300700001)(4001150100001)(2906002)(5660300002)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MFYrRUJ1WlBaVVdCcDVzb2MzWDR4cXUwaGdsRXdkZlRlMDdLWEhTelQ3cmFr?=
 =?utf-8?B?bUQ3Tzh6MTh2VTd1akRvcGV1VWJJOEZ1UE9PekxzTGJjODY4cHJwd0JBUCsr?=
 =?utf-8?B?SGVjVDMvYnJkSVFjU2dyOWw1ZURTak5hVFpEYXlURVViVkVkZHdKcm5rcHpq?=
 =?utf-8?B?RjNsLzVhTnJQYzg3eThpaUFwamZmMUtjYkxzeVlOWjRGbGxGWkVtWXBGVjBy?=
 =?utf-8?B?QWRnWVBvUG9PNWRVMHNtQWFwcnJPbWR4OWJvWWdGVThEWC9UazZkMDA1MXdk?=
 =?utf-8?B?Y0J3WmNuYncvZEtZa0hscE93VmpldXB5emVKdElzY2djMm9nVFdxL0JwMzJG?=
 =?utf-8?B?b0JVVkZ3SENvc1VjNnhCakcyTGNDb1hyTXJRekhjT3dNK2QwWlBqWjJNcFRJ?=
 =?utf-8?B?NXpSeUc2TE9xcHhVeksvSTNUYUM3M1FYRXRvSUQ3S0tQN1lLMkNqcDZ4N01q?=
 =?utf-8?B?VzJnM1kyNW9acWR1RG1PdE1FZEN2TSt4ZEV2WlM0dUY1R2xYSEJYRjFNd2ho?=
 =?utf-8?B?amV1cFk4a3BZbjVBUGZGMFJTMitwV3lhSTRnOGJNWVhQOEk4TGo0SzZhOUdk?=
 =?utf-8?B?YWtISUdiTVU4eHBSY0NzYWxZTEVmaWdQQWNHc3lWemVwWUwyLzBCVjhYTTRu?=
 =?utf-8?B?OUVHWUtDam8zYVRsVGhBUHJHOEh3TTZZSFdoMm14a0E3MFJ5bHBQL3V1SEQ4?=
 =?utf-8?B?aTB2NGttZ1Z2TmJaWjNnMDVndmtJN0t5cGlNM3B5U0Izb2ZQajNIM2xNb3ZF?=
 =?utf-8?B?NVF6dWMybVlrMUt3MWJMRXZmQjk3elVTaERrWmhyaHNlT2YzSE16eUZOOStC?=
 =?utf-8?B?eXJQeStIYzdvTVNWdjMwSzllbGpXQmlpblI5Ym91T0xvUFJiSHRXTFFvZTJt?=
 =?utf-8?B?cThZeEJGZVFERFJVcFkraHhzTThSQS9LTVJISlRpOXBnQVpIRHQ2Mkk2ZlRs?=
 =?utf-8?B?cTd4dXRhQ3NzRHViMndYalJqQ0J1SlovaVJ0WjFHNHA2UUhrcHF5TDdRNDJn?=
 =?utf-8?B?aVk2cnIwMFBZU0QyQlBCQlNkakZJeGhlL2JKbmwrZU9sR1owMXdETUVVeWYz?=
 =?utf-8?B?b1RUc0lGalpsQVU1NTJTKzQ0V2dqd2NGZ3dGTjNYM3NCejZpYUIySmhCUm5q?=
 =?utf-8?B?ajBlTnZXWlpzTlpEU1ZnQmliaVE0RTMvWWxJdmZJN2dncVZHYThGamxjRnFW?=
 =?utf-8?B?RVpwaytWZnFuZm4yUkJZV2RkNXZmaFdzTDJLbGZTSEJkTzIrOWNmUkZqZ1gx?=
 =?utf-8?B?SHY3U09pMmlPdTVmanpuK0tLMk5USzc5SHh3TEx2TVR1eW1LTHlzMkFzYVgy?=
 =?utf-8?B?ZHlqVS96MjlWRjN5VlJ1N1hHUVc0djNXbjRnNjJmT0Z4VkljYkdYNFFxSkJh?=
 =?utf-8?B?SVFVOXQ2ckg4Mjk3d3VRcnRPYlFRNk1ZWVc5NTE0WkN6YmFxNkt1eW50dWJL?=
 =?utf-8?B?NWNKN2MzdlZrNmN1cDUzZ01GUlZtOWtRcUhZZWxIT3lHbVd6NHBDRzlhTEdz?=
 =?utf-8?B?cENZSWtSeko5V3lPSHpPTTYzU2ZOc0MyN3orNThGcmN2TFhTSFMzazlOOUhu?=
 =?utf-8?B?RG9jaEZja2N3VENQcDJuWFAreEtqejNpUDMrWGJZRTVFR0pBY3A3NVNOV1V6?=
 =?utf-8?B?Z3JRUnZpOEh6UUp5SExaU3JuZnI5ZDN2TytQRWxDWjlBdTZFMSt3ZmNZUkdt?=
 =?utf-8?B?a2twMEt1REtFOGd4aFVKZHpGS3Z6R3VjbG4yOXZMVmlzbG9HYXZnRllucFNJ?=
 =?utf-8?B?QUE1OTdTSUJ0Uzh3TnlmalJFRE1kZFNONTBXU1RVOEhjS0wreG1aMVA2M3RM?=
 =?utf-8?B?VDJUblBmb3lOK3dUeXZON1ljaXRYQXVKYVlNMEFrY2J1anB3Y2k2YUlLRzk0?=
 =?utf-8?B?RlJmaVNYcVRqeFhOaTZwUGVYbHl2cVZOaE1VcE0zTXVzNlpTZ1RxWElaY2ta?=
 =?utf-8?B?K2VPaU1SWXorSU15T3RYMUR5SzFsV09nYlpxRk1NL1d5VCtObWtJdEovUDRv?=
 =?utf-8?B?K1llWndWWmtYTzJRYmQ0OFhqb3Z5bFBuYU80UEF1MU5RMWZyOERwVzJ0MkpV?=
 =?utf-8?B?dW51d010Z1VHamVzMnVkVlp5NFZndWROWU40dHlaZ1YycS9HRElIVzMwNUVh?=
 =?utf-8?Q?qR28F1bMMfvFywqV8nDz8TBW2?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F1FC0D954165FF43985D846E54853BA8@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99b49954-8ab4-4821-52f2-08dc0cfb56c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2024 08:01:21.1392
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HAJlZLzrrc2Re8yhnrEHe/uh9He8/sWU4QFgwrFxE6A6nAkC8Zc0iaeyCYPgfIbNnT1D+sbhfyxgXJYD36/iug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR03MB5207
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--8.866300-8.000000
X-TMASE-MatchedRID: nVQUmLJJeybPaPH51LTU5Ca1MaKuob8PC/ExpXrHizxcKZwALwMGs8uj
	Rkt05a7cM2MQQW7DL3iwwb1jpRrUynDDIwUUWGIcDB+ErBr0bAP3kggSw3p0A7lmMfLNiukabH5
	VkiNGGMelTdIFqSDtVrqJRTKOPd3TLZbtj42l31ELPVZHwod7gH0tCKdnhB58pTwPRvSoXL2y5/
	tFZu9S3Ku6xVHLhqfxWBd6ltyXuvtY9qwU613FGeMeZpMUaCGtLpmwt1zPlgHH4b0TtYTAe1yxG
	e0ZbTtkSje5qGQz/LdL3luTtL5K6TdvhXPtxbYZ4hwdAn+jRNP8DYAMxfNdesTcZRBQ3ORlx7TA
	T/418tn4dFDMTTdqtlRjIYeif4m6ftwZ3X11IV0=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--8.866300-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	CADBA381D6A357FAD93D59805FE8CE44DC5CB2D0AE925CCE623D2F0CA185C79E2000:8

SGksIE1hYzoNCg0KT24gRnJpLCAyMDIzLTExLTI0IGF0IDE2OjUzICswODAwLCBtYWMuc2hlbiB3
cm90ZToNCj4gQWRkIHRlZSBjbGllbnQgYXBwbGljYXRpb24sIEhEQ1AgMS54IGFuZCAyLnggYXV0
aGVudGljYXRpb24gZm9yDQo+IERpc3BsYXlQb3J0DQo+IHRvIHN1cHBvcnQgdGhlIEhEQ1AgZmVh
dHVyZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IG1hYy5zaGVuIDxtYWMuc2hlbkBtZWRpYXRlay5j
b20+DQo+IC0tLQ0KDQpbc25pcF0NCg0KPiBAQCAtMCwwICsxLDE1NCBAQA0KPiArLyogU1BEWC1M
aWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAgKi8NCj4gKy8qDQo+ICsgKiBDb3B5cmlnaHQgKGMp
IDIwMTktMjAyMyBNZWRpYVRlayBJbmMuDQo+ICsgKi8NCj4gKw0KPiArI2lmbmRlZiBfTVRLX0RQ
X0hEQ1BfSF8NCj4gKyNkZWZpbmUgX01US19EUF9IRENQX0hfDQo+ICsNCj4gKyNpbmNsdWRlIDxs
aW51eC90eXBlcy5oPg0KPiArI2luY2x1ZGUgPGRybS9kaXNwbGF5L2RybV9kcF9oZWxwZXIuaD4N
Cj4gKyNpbmNsdWRlIDxsaW51eC9zY2hlZC9jbG9jay5oPg0KPiArDQo+ICsjZGVmaW5lIEhEQ1Ay
X1JYU1RBVFVTX1NJWkUgICAgICAgICAgICAgIDENCj4gKyNkZWZpbmUgSERDUDJfUlRYX1NJWkUg
ICAgICAgICAgICAgICAgICAgOA0KPiArI2RlZmluZSBIRENQMl9SUlhfU0laRSAgICAgICAgICAg
ICAgICAgICA4DQo+ICsjZGVmaW5lIEhEQ1AyX1RYQ0FQU19TSVpFICAgICAgICAgICAgICAgIDMN
Cj4gKyNkZWZpbmUgSERDUDJfUlhDQVBTX1NJWkUgICAgICAgICAgICAgICAgMw0KPiArI2RlZmlu
ZSBIRENQMl9NX1NJWkUgICAgICAgICAgICAgICAgICAgICAxNg0KPiArI2RlZmluZSBIRENQMl9L
RF9TSVpFICAgICAgICAgICAgICAgICAgICAzMg0KPiArI2RlZmluZSBIRENQMl9DRVJUUlhfU0la
RSAgICAgICAgICAgICAgICA1MjINCj4gKyNkZWZpbmUgSERDUDJfRUtQVUJLTV9TSVpFICAgICAg
ICAgICAgICAgMTI4DQo+ICsjZGVmaW5lIEhEQ1AyX0VLSEtNX1NJWkUgICAgICAgICAgICAgICAg
IDE2DQo+ICsjZGVmaW5lIEhEQ1AyX0tNX1NJWkUgICAgICAgICAgICAgICAgICAgIDE2DQo+ICsj
ZGVmaW5lIEhEQ1AyX0tIX1NJWkUgICAgICAgICAgICAgICAgICAgIDE2DQo+ICsjZGVmaW5lIEhE
Q1AyX1JOX1NJWkUgICAgICAgICAgICAgICAgICAgIDgNCj4gKyNkZWZpbmUgSERDUDJfTFBSSU1F
X1NJWkUgICAgICAgICAgICAgICAgMzINCj4gKyNkZWZpbmUgSERDUDJfRURLRVlLU19TSVpFICAg
ICAgICAgICAgICAgMTYNCj4gKyNkZWZpbmUgSERDUDJfS1NfU0laRSAgICAgICAgICAgICAgICAg
ICAgMTYNCj4gKyNkZWZpbmUgSERDUDJfUklWX1NJWkUgICAgICAgICAgICAgICAgICAgOA0KPiAr
I2RlZmluZSBIRENQMl9SWElORk9fU0laRSAgICAgICAgICAgICAgICAyDQo+ICsjZGVmaW5lIEhE
Q1AyX1NFUV9OVU1fVl9TSVpFICAgICAgICAgICAgIDMNCj4gKyNkZWZpbmUgSERDUDJfUkVDVklE
X1NJWkUgICAgICAgICAgICAgICAgNQ0KDQpJcyB0aGlzIEhEQ1BfMl8yX1JFQ0VJVkVSSURfTEVO
PyBJZiB0aGlzIGlzIGRlZmluZWQgaW4gSERDUA0Kc3BlY2lmaWNhdGlvbiwgbW92ZSB0aGVzZSBk
ZWZpbml0aW9uIHRvIGluY2x1ZGUvZHJtL2RybV9oZGNwLmgNCg0KUmVnYXJkcywNCkNLDQoNCj4g
KyNkZWZpbmUgSERDUDJfVlBSSU1FX1NJWkUgICAgICAgICAgICAgICAgMTYNCj4gKyNkZWZpbmUg
SERDUDJfUkVDVl9JRF9MSVNUX1NJWkUgICAgICAgICAgMTU1DQo+ICsjZGVmaW5lIEhEQ1AyX1NF
UV9OVU1fTV9TSVpFICAgICAgICAgICAgIDMNCj4gKyNkZWZpbmUgSERDUDJfU1RSRUFNSURfVFlQ
RV9TSVpFICAgICAgICAgMg0KPiArI2RlZmluZSBIRENQMl9LX1NJWkUgICAgICAgICAgICAgICAg
ICAgICAyDQo+ICsjZGVmaW5lIEhEQ1AyX1JFUF9NUFJJTUVfU0laRSAgICAgICAgICAgIDMyDQo+
ICsjZGVmaW5lIEhEQ1AyX0hQUklNRV9TSVpFICAgICAgICAgICAgICAgIDMyDQo+ICsjZGVmaW5l
IEhEQ1AyX1JYX0VOQ0tFWV9TSVpFICAgICAgICAgICAgIDEwNA0KPiArI2RlZmluZSBIRENQMl9U
WF9FTkNLRVlfU0laRSAgICAgICAgICAgICA0NDgNCj4gKyNkZWZpbmUgSERDUDJfTEMxMjhfU0la
RSAgICAgICAgICAgICAgICAgMTYNCj4gKyNkZWZpbmUgSERDUDJfS1BVQlJYX01PRFVMVVNfU0la
RSAgICAgICAgMTI4DQo+ICsjZGVmaW5lIEhEQ1AyX0tQVUJSWF9FWFBPTkVOVF9TSVpFICAgICAg
IDMNCj4gKyNkZWZpbmUgSERDUDJfS1BVQlJYX1JFU0VSVkVEX1NJWkUgICAgICAgMg0KPiArI2Rl
ZmluZSBIRENQMl9NQVhfREVWSUNFX0NPVU5UICAgICAgICAgICAzMQ0KPiArI2RlZmluZSBIRENQ
Ml9NQVhfREVQVEhfTEVWRUwgICAgICAgICAgICA0DQo+ICsjZGVmaW5lIEhEQ1AyX0tQVUJfU0la
RSAgICAgICAgICAgICAgICAgIDM4NA0KPiArDQo=

