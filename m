Return-Path: <linux-kernel+bounces-88567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA98D86E389
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 15:40:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4B621C23359
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 14:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408016F53D;
	Fri,  1 Mar 2024 14:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="OBvXv7My";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="MRLEbWIo"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D1643AD8;
	Fri,  1 Mar 2024 14:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709304001; cv=fail; b=SdZkeE6Jm68Tkijskv6KaizWqbYUZIG/lLpWgjEC7hew0t36ID/zohUJ4/mMBFolrU54bAONtIFKiZeFccZ5rlzpVwsF38Hnm8X6QeYQI7Kk9DhB4xpC+SGcWfMJ4pQmWbAgK6ZelYZgHMGahZUgdZGlLEA4mbFwYThiLY7UbpE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709304001; c=relaxed/simple;
	bh=1wI/ZuIgWuldPl8BVCyreCquuC5I2HMyxkFNRZZXgdU=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=j1p7kryQcofiERKXH6UmrchgwuWgZdJAHns+1a+ZWuLbRfRsqVmPynANjb+KvCX7Ap8pPfa7jxlzeeXsKeu1wTe3FrfOaAgcIZPAnVKYOPWc3zmBgMPn+t+aZgymBvEIcY/7pKeIZYyFWgBgaAbKuqmABGsh9uJH+1hkreCheNs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=OBvXv7My; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=MRLEbWIo; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 9064396cd7d911ee935d6952f98a51a9-20240301
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:Message-ID:Date:Subject:CC:To:From; bh=1wI/ZuIgWuldPl8BVCyreCquuC5I2HMyxkFNRZZXgdU=;
	b=OBvXv7MyLKKkkHgb3rmCiCmCJtA0NHDf8vPALabz9g/gvF41R8MyTPb3zkiMg6Ygaa/6pVERe6DK+vtKRKkhDJV4HMNZaYp9lxOvRaiafONxHI7Ns+9Ba4OrcUAWBRFf+CC3U5DZOo8ijUW2Qto2LL7QcvqXl9iH+ooQXV08v8Q=;
X-CID-CACHE: Type:Local,Time:202403012239+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:07c51b4c-53ca-4201-b812-33a3e4d6e776,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:7b678184-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 9064396cd7d911ee935d6952f98a51a9-20240301
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
	(envelope-from <lena.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1953996615; Fri, 01 Mar 2024 22:39:52 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 1 Mar 2024 22:39:50 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 1 Mar 2024 22:39:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mZgMCDQtlS3bzNwvtP0VuP3FPNBXlYnsv7xSEEZ9oFPrrHqy7yvtkw4+eYvlSeWL7N3O9iK1etWiSjdddH9vSuE0HIMabJ3XScmRinSc09oMNZH07QfhEMIHtidd7LlX0l1z8jZGtM39W6fVegE17efNB6eJDBHuQm6X9nv29KXkVXupdEdsdl5rp+yprFDKa3sWZs1L/r5UIWC//5rJXAuVWOR57avRGtu47g97fLJAtO8eSk0+C9aKUNSYWDxV3NM7cvarbUvkSFbwHWVHcNodMiBRoKUFf18f3Kgnzuu1rqbw9AEubNmGZK4ugnkWeTIiGgwiDJHRnTj52NN03g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1wI/ZuIgWuldPl8BVCyreCquuC5I2HMyxkFNRZZXgdU=;
 b=adsONNBFu0D0iWTOvABQIc1TPODFEOtZp3y92Iq/4qomZpBOHfcxSj1Wl3pasYX4wFgsCCKJgym9Y3srKZkAmQ+OO/bouUSuq4PKk3CTT6cElHnMexnWbsvX3vow0qKMIHB0VFhiuuLJypLG02k2KOXdUK6ZQ6uj3mH/HrfaAbRc3kb9ond9MHI7Inmp4BiFY+xgmj1mnIPRoGDbXaJx6dWf6KlapWzgOC4XNR3CU1QJTimslMbjQpBwnIxQeho8xazHxga2vV/Sl9IMbdHe+uVR+TOO8qWYy11dDGIDm5JMsORncjdz+yYbDZM7UtC1ocoQafavEc/825QGeT2cVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1wI/ZuIgWuldPl8BVCyreCquuC5I2HMyxkFNRZZXgdU=;
 b=MRLEbWIoh65ku5AiHHSgbfNuZ0N1muF+/kfyRkcu2KGs5e7QHtTmyFfrDo2LO84eH/2vOnWntDtcFNVxZN0QNOr/JbGLEg4S0tIV2V82iuyr7bN4OJEruY1vWKp6Ynyf8+fHSKfPbdTv546LDTavzWeeTMbJA8V7Zi0pRkB4PqA=
Received: from SI2PR03MB6463.apcprd03.prod.outlook.com (2603:1096:4:1a3::9) by
 SEYPR03MB6904.apcprd03.prod.outlook.com (2603:1096:101:b1::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7316.41; Fri, 1 Mar 2024 14:39:46 +0000
Received: from SI2PR03MB6463.apcprd03.prod.outlook.com
 ([fe80::c74b:551:1197:a8c9]) by SI2PR03MB6463.apcprd03.prod.outlook.com
 ([fe80::c74b:551:1197:a8c9%5]) with mapi id 15.20.7316.039; Fri, 1 Mar 2024
 14:39:46 +0000
From: =?utf-8?B?TGVuYSBXYW5nICjnjovlqJwp?= <Lena.Wang@mediatek.com>
To: "kuba@kernel.org" <kuba@kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "jiri@resnulli.us"
	<jiri@resnulli.us>, "dsahern@kernel.org" <dsahern@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	=?utf-8?B?U2hpbWluZyBDaGVuZyAo5oiQ6K+X5piOKQ==?= <Shiming.Cheng@mediatek.com>
Subject: [PATCH net v4] ipv6: fib6_rules: flush route cache when rule is
 changed
Thread-Topic: [PATCH net v4] ipv6: fib6_rules: flush route cache when rule is
 changed
Thread-Index: AQHaa+ZOlmtrqOmtQEu54Vg0yp9zeQ==
Date: Fri, 1 Mar 2024 14:39:46 +0000
Message-ID: <09f2ab1b7946339da5092e10aa216e07c579c60b.camel@mediatek.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB6463:EE_|SEYPR03MB6904:EE_
x-ms-office365-filtering-correlation-id: fcf5b3e3-176f-40bc-9702-08dc39fd70d3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N4b+kuMGbZOc5+9+wvLlZ3M4xTOSY+pGiEq9euUOwzZjaUeUgpgA2jRUH5hjA7h6C9T7aDhX9jHIgm1xD6UD1i1zFnaW9VmqLbWwuxytOeHhG+IYZ5kbOZZBKV4PkIIe5pSGsxq6I6N1ey7IOGbQSuqjoOp+1C6/pY8SHTziMFERqEQaSsPkRAdBBv1H4Tx8ogs4FmdTXQYSHsOxKhrq0zcC/F+IrNiGBttcYR9zARhJTZqnNhqZN/ZyUW+GXVFK8ZKK6xmKPxgA0wBrINRruejmm+a6r4Vq5bQqaHAaH1vrj/LFwmIafhBuq1gAC8DwhlnplMMNur3nnmA+P9WFhMRO0DRUNOE9NZqnn1aiOsB5hG4K4Ji70j6aNvF097ZoI/ICBSf8tiETXtyGQHW4EVrYS8tPSzLcOK25NulwO3r++gsw7Zd5BpCe8f7bzyP1P5yinJt+GpEhby/rvC1GlVTuX84srI1x8Jp9WW0klZ2oiwGtjgNFdhKa8npHgwpbrfoTy9IqqeLsuV2Wuy4AKMSsCBRz25kpXYK9W4HeKI8w1JmWgWv7IR0S6fnRlDxLM27mkwG39Qsjz3izf35GhIe8HGx+a7n/ii2WkoPXdEUntnBrjf3TcxD/KrNSgkhdDQRz05213MsMemEOmkiS5r8LiG3Xykfe03CfWBZisrhkKz2bNoh9cBbQGBcAayluq5k+gH9YxcfvePVWRq7euxmjpSvox3SjpSYdv2sD/s8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB6463.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MkRKQjhHNmUzc2MwKzA0RHBqL1pNcVlvc2lCU2hJMURhUmdUazVraS9aMmZi?=
 =?utf-8?B?U1Q5MElQQjhLOXNPR2M3MHZyckZCSHIyRlp1V29aS2t5MmhBWkhPSGo1WE1H?=
 =?utf-8?B?Y0QvKy8rejhkaEZyUlJrTkxaeDJhL21uMFdOUDNCeCtDcXY2UmxFaXc3UG85?=
 =?utf-8?B?Uk05clg3eTFjZFA3T2M5dHg0NFRTVW9iT2NxeS9vdUltZTVMcFVwdlZjbmlt?=
 =?utf-8?B?NEJnRGloSXZMM29DUDJhaXVKTUdoSlR2VmlVZWRhWTlheThSeEx0WGE0bDBH?=
 =?utf-8?B?dExpUjlMTytFK2J0djk4Y0JzRzlseXYzUStUOTArY2RDNDNWZGxaUkZ2ZzU5?=
 =?utf-8?B?MVZRVTZOTnNRYllNRjFXd0w2WXNkYi9EajQ5Q2lVV2crSHdIUys3UFBwbXdX?=
 =?utf-8?B?NnlXRlk4bmdqY09oOUZoOVUxSjJNcmY4MksyUm02Vk5EZm9TMHBMd3Z2SnRI?=
 =?utf-8?B?NVV6Z3p2dEVwNk8rUXhQS3d5MjJFUnpEVDlyUWJwbC96UkczTTAwUkRDZDRx?=
 =?utf-8?B?Tk1xcHpyVFZibjEraGx5MXUrMDhpT0tYQWpaVDd6TGdLVTl4a2RQUElaakh1?=
 =?utf-8?B?Q0lRaDlCUnpJdTZhd1RMMGgyS1g1S3ByUFRlbTZZTlQyUzdOMDN3QkZZZndG?=
 =?utf-8?B?RytEcHpMVmJvcTBLZC80enZhNU1LTzdLL0M3NFdxUXRpSnJVZUFtL3JUYmpS?=
 =?utf-8?B?R3hhU2ZtSUFISTJmbmZMQ2ZwbXFWNHBLQnh4bzllOXBqUDZDV05HdzM2UUta?=
 =?utf-8?B?VWFNaXNiWk5qSUtjalBFK0NGRnYrVmZqOWhzNzBDQVVMcE1KQkxoQ21TRE9R?=
 =?utf-8?B?RlRpRnc5UUdBcVNZQXpJREgrZldlckpPMk93OTdWYXlLaGIyMjBEZW5OV0dO?=
 =?utf-8?B?dHN6UGU4K0xhWWI5a00ySzBmVURuREdZV2ZIMGlTMlVWdFljUDNrS05kenZy?=
 =?utf-8?B?blh3ZVpHRTZ0Q1VZVWhGWTdZZTZjVGZyeGduWmdKNEtURVNxNi9ad0hQNjBH?=
 =?utf-8?B?Q1hKK1VPeVVDK0h1QXdYOHgrSm5UdVB5TWpjODdzZkhKa2lJMngvQjc4bGpo?=
 =?utf-8?B?THU4Y0JGY0VZelBHOXhnRDZ5N2tZai9JRHZFTmFaTVdnSTNmZ2JWM1NQYWNq?=
 =?utf-8?B?UHd4eGxpREJqMmo2bFFONVFpM1NaWDNzWjFtd1BkZkFzUXozV2xzTWsyclpi?=
 =?utf-8?B?MkRoaXo5TDJFRGcxa0NwNkZFTGQrMDVJeWpFZFI0VFV3eEJuTSs4dFJkR2I5?=
 =?utf-8?B?czZkdHZVaTUwZkpBOXFLV1o1UndDTzVIMlZZRnpZQ0F3eFI4bTlaT2psSnVo?=
 =?utf-8?B?bFdKYWJ3V0YwTGorODdwOGdpMHd5Q0Yvai9WTEVxK3EyUGhlY2FPNGczSFpB?=
 =?utf-8?B?Sk5FWjEyVHZ2RGVHRXNTQ1NvcmVvQVBvQnduMUFuUitVZHFMQ2M4SzBic0gy?=
 =?utf-8?B?M2lta1VCNTNGWGpST2JyQWlmWGovYVlaSHVNTDNpWkp0K0FkZElqUzAyTlFs?=
 =?utf-8?B?Wjk2VVFjeVhSQVFwMis2bVJVaDhuSFdJM00xOVJoVXBwdlJMSit5dEF0REho?=
 =?utf-8?B?eEhveXFMdGlPcmpkRFBXdTB3Mm5nUlVZR0F1ckxkcXJNWHN3N2FLMGpEL2pl?=
 =?utf-8?B?S3BVUUdJYzJYZXIvQTVNKzdRYndyOGtPbXM5ODlXaTVhMzRsakROZEpqeG1M?=
 =?utf-8?B?clRrN1BSZnJBL3JlL2ZVeUhvRmpwb1NmOW5MUVlZTE5zRWNDNWFVenBudnBZ?=
 =?utf-8?B?bHRIeEx5VlNCUnVITStWV2JlSlFMSFRSS2FlQllUZjBZRlNORWV1S0JPdkh3?=
 =?utf-8?B?V2wraHlQSXBsNDZvYmtXZTN1N3EvNWZzZXZlaWhEOFZlQTFZSFFkRjdOTENF?=
 =?utf-8?B?VEFGaFlvZVhrb1B5UnNWZkYxQm9LY3JBTWt6NnUxanV2cEN2K2pZL0Fkcjdr?=
 =?utf-8?B?aExDTFBLRVM3MG4zSnZJVE1MVU15MGJqekd0TnRDRlJiNjkxNzVSTFJiV2hp?=
 =?utf-8?B?TlRqTXRWUVRoV01uRUQ5VFEzNk1ER3VHWkRLMWJ3K2V4cXpFYWZaVTdWZWlW?=
 =?utf-8?B?MmU5ZVd3OFRYLys0bngxbU1neWlvVlVja3VmSlY3RCtCTWhPR0pYUXUvVklZ?=
 =?utf-8?B?U1JaSGhURy9jVHo0RHJqNENjb2w4QzBaalV2L0xxSmFCdUJhamZqWmJYaDEv?=
 =?utf-8?B?TFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CD6E3755464C6F469DA48DC129FAB3F5@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB6463.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcf5b3e3-176f-40bc-9702-08dc39fd70d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2024 14:39:46.2130
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pb2Q3gIw/6uLuhAm4z09yOtG7C2vgM0fEM2lboblzqAvC67nyeBLk5BXbfsxjKrkeyJusgOPJ5SFvbBb4IL4AA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB6904
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--4.350300-8.000000
X-TMASE-MatchedRID: 0WNpcueVtr5KgFU/G9flJJD6BbDN9+jOYQXxsZnRwoIXdhT0BAdFzset
	ivb6XlQxK5BT0yfou/uGbUz6XveLzjRLrEWBxI92T7jCYv2QJPGBHKTJ+sfXGfgnJH5vm2+gxsr
	6m7RljBGi+5bTokBGbwG2ORx9Eyap0H/zLeBgX2+Sa1tNw2nFhPhs+N+bSEhBdow/ybqqTpJsKk
	k6TlZET7DVfJtjpo/VkZOl7WKIImrS77Co4bNJXbq9UFRTJ0kKxEHRux+uk8ifEzJ5hPndGabAl
	nVWE5jintGRmrM/4XxQhfyspTgOBueQr5hu0jq2aaRt/SWgFUy4iKxJ3a9x9ir8zqbLIYsuynnS
	/I7E9onn1Y0o3DUz8lZpsTgWmBmFE440GA1tXyvUoWT7XIVDwsFvg0QncNcfVlxr1FJij9s=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--4.350300-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	1DDF6867E5AF02883D6365977BDD687ABECDEC2D033356FA1B31C136D38D72532000:8

RnJvbTogU2hpbWluZyBDaGVuZyA8c2hpbWluZy5jaGVuZ0BtZWRpYXRlay5jb20+DQoNCldoZW4g
cnVsZSBwb2xpY3kgaXMgY2hhbmdlZCwgaXB2NiBzb2NrZXQgY2FjaGUgaXMgbm90IHJlZnJlc2hl
ZC4NClRoZSBzb2NrJ3Mgc2tiIHN0aWxsIHVzZXMgYSBvdXRkYXRlZCByb3V0ZSBjYWNoZSBhbmQg
d2FzIHNlbnQgdG8NCmEgd3JvbmcgaW50ZXJmYWNlLg0KDQpUbyBhdm9pZCB0aGlzIGVycm9yIHdl
IHNob3VsZCB1cGRhdGUgZmliIG5vZGUncyB2ZXJzaW9uIHdoZW4NCnJ1bGUgaXMgY2hhbmdlZC4g
VGhlbiBza2IncyByb3V0ZSB3aWxsIGJlIHJlcm91dGUgY2hlY2tlZCBhcw0Kcm91dGUgY2FjaGUg
dmVyc2lvbiBpcyBhbHJlYWR5IGRpZmZlcmVudCB3aXRoIGZpYiBub2RlIHZlcnNpb24uDQpUaGUg
cm91dGUgY2FjaGUgaXMgcmVmcmVzaGVkIHRvIG1hdGNoIHRoZSBsYXRlc3QgcnVsZS4NCg0KRml4
ZXM6IDEwMTM2N2MyZjhjNCAoIltJUFY2XTogUG9saWN5IFJvdXRpbmcgUnVsZXMiKQ0KU2lnbmVk
LW9mZi1ieTogU2hpbWluZyBDaGVuZyA8c2hpbWluZy5jaGVuZ0BtZWRpYXRlay5jb20+DQpTaWdu
ZWQtb2ZmLWJ5OiBMZW5hIFdhbmcgPGxlbmEud2FuZ0BtZWRpYXRlay5jb20+DQotLS0NCnY0OiAN
CiAgLSBhZGQgIkZpeGVzOiIgdGFnLg0KICAtIHVwZGF0ZSBzdWJqZWN0IGFzIHJlcXVlc3RlZC4g
DQp2MzogDQogIC0gdXBkYXRlIHBhdGNoIGRlc2NyaXB0aW9uIGFuZCBuYW1lIGZvcm1hdCBpbiBj
b21taXQgbWVzc2FnZS4NCnYyOiANCiAgLSBtb2RpZnkgZmx1c2ggZnVuY3Rpb24gc2FtZSB3YXkg
YXMgaXB2NCBmbHVzaCBjYWNoZS4NCiAgLSB1c2UgdGFicyB0byBhbGlnaCB3aXRoIGV4aXN0aW5n
IGNvZGUuDQotLS0NCi0tLQ0KIG5ldC9pcHY2L2ZpYjZfcnVsZXMuYyB8IDYgKysrKysrDQogMSBm
aWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvbmV0L2lwdjYvZmli
Nl9ydWxlcy5jIGIvbmV0L2lwdjYvZmliNl9ydWxlcy5jDQppbmRleCA3NTIzYzRiYWVmMzUuLjUy
YzA0ZjBhYzQ5OCAxMDA2NDQNCi0tLSBhL25ldC9pcHY2L2ZpYjZfcnVsZXMuYw0KKysrIGIvbmV0
L2lwdjYvZmliNl9ydWxlcy5jDQpAQCAtNDQ5LDYgKzQ0OSwxMSBAQCBzdGF0aWMgc2l6ZV90IGZp
YjZfcnVsZV9ubG1zZ19wYXlsb2FkKHN0cnVjdA0KZmliX3J1bGUgKnJ1bGUpDQogCSAgICAgICAr
IG5sYV90b3RhbF9zaXplKDE2KTsgLyogc3JjICovDQogfQ0KIA0KK3N0YXRpYyB2b2lkIGZpYjZf
cnVsZV9mbHVzaF9jYWNoZShzdHJ1Y3QgZmliX3J1bGVzX29wcyAqb3BzKQ0KK3sNCisJcnRfZ2Vu
aWRfYnVtcF9pcHY2KG9wcy0+ZnJvX25ldCk7DQorfQ0KKw0KIHN0YXRpYyBjb25zdCBzdHJ1Y3Qg
ZmliX3J1bGVzX29wcyBfX25ldF9pbml0Y29uc3QNCmZpYjZfcnVsZXNfb3BzX3RlbXBsYXRlID0g
ew0KIAkuZmFtaWx5CQkJPSBBRl9JTkVUNiwNCiAJLnJ1bGVfc2l6ZQkJPSBzaXplb2Yoc3RydWN0
IGZpYjZfcnVsZSksDQpAQCAtNDYxLDYgKzQ2Niw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZmli
X3J1bGVzX29wcyBfX25ldF9pbml0Y29uc3QNCmZpYjZfcnVsZXNfb3BzX3RlbXBsYXRlID0gew0K
IAkuY29tcGFyZQkJPSBmaWI2X3J1bGVfY29tcGFyZSwNCiAJLmZpbGwJCQk9IGZpYjZfcnVsZV9m
aWxsLA0KIAkubmxtc2dfcGF5bG9hZAkJPSBmaWI2X3J1bGVfbmxtc2dfcGF5bG9hZCwNCisJLmZs
dXNoX2NhY2hlCQk9IGZpYjZfcnVsZV9mbHVzaF9jYWNoZSwNCiAJLm5sZ3JvdXAJCT0gUlROTEdS
UF9JUFY2X1JVTEUsDQogCS5vd25lcgkJCT0gVEhJU19NT0RVTEUsDQogCS5mcm9fbmV0CQk9ICZp
bml0X25ldCwNCi0tIA0KMi4xOC4wDQo=

