Return-Path: <linux-kernel+bounces-6527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 746438199F9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 09:03:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 030561F2572A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 08:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D761D6AB;
	Wed, 20 Dec 2023 08:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="X7V0cluu";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="fb45GeYk"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59A61CA9A;
	Wed, 20 Dec 2023 08:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 0ff0236c9f0e11eeba30773df0976c77-20231220
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=H3W5eMwKIuK0Pz4oevCA0aBRwPb1Ge53yVDx7VgdDA8=;
	b=X7V0cluuNGaUrU4+hJ4V3dbN2emC+bgt7VjytCw5GUEIt4VMh476yKL/Kt60aTXMGNhlmSL5nF74Mqz5o1Q7R9gXLzhUCzp62aLZDsox0hwblB0b2YSX5iu/QzbyIIB+FPVX3KsfD1nh8O12Odp2IdBYmMWvGHUVQOnbCwtExbU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:98c7398a-1c3e-4b7d-ae28-4f4e88686a5b,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:69fa5f8d-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 0ff0236c9f0e11eeba30773df0976c77-20231220
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1107856666; Wed, 20 Dec 2023 16:02:04 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 20 Dec 2023 16:02:02 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 20 Dec 2023 16:02:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R1t4hBWmljGZTSNfzwdP4Hervk6RS7mYtgs0HFZ6dOO/VP3vDs8QAFK/AX3l6YVjqvHKWMAnGW3y6SWeSf/0ema9UPMn+t1nxTXeiyXSrVpHUx7ssCqsdNPvYcNqNOibPbPZo3mLwDMW6kUiWhTkIkbbTIHR3jNPhferkvpu5k/TCOSb7W/UJ6nw8SvLqNDWmrUXQ+ztS4zINzUnmgFXaP1PR6a1DSPXAG+sXPi5hAExYnQTZlPxXyViKFUOF5TN7ZYQ14d2sNs/I3YQoZXelt7fmma8adLWW1qo8LLfb3ox+lqQhd9QUg9+XeB3khsjjqUXwp+T/tqNn22j6STCYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H3W5eMwKIuK0Pz4oevCA0aBRwPb1Ge53yVDx7VgdDA8=;
 b=GEPwrgXactZT6hR5sv01kmkyZAH9b1oYMEJwQbvtboy2ly5HGwIUf2cSWG7d7NKDyhRST/PQxzQkS1uUxemI6hqJjzLmEVYppnou9rTeWsYxqDaKQEHedIwEs/WWHfDfcF76bsZSqpU8R+MFLVfx5h7kFYP34gWr24p+n0Fc8zA2iq/0hg5GbM1NXjcXXnq1k0qFAQi9dXNxj2cnlfQuzkjKqlx9KUw5A1MNCkqcsD9JoyeRJEkqqpOUixS+/BvCZCb3vjH8dFvxzv4zrzajYqwfgiDR8uguV9GC1441QecmHkGGtYDBPklV2AvEsh7TEoBzPZkdWKwv6dW/pbzoXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H3W5eMwKIuK0Pz4oevCA0aBRwPb1Ge53yVDx7VgdDA8=;
 b=fb45GeYk+y8f6CCMmtBUAg+IVzqcJ4FyA7bUa2LjG+RYk9y0+Q5yrAIvbXVGtEtMnjlDKA+jw0LQ0LzbYC793HSKLfNqoCRGnzBkgfg2vfXtEpSGNjfUY5ERi8WfClo+NXPzAxfyc9hVOgx8U/EyGtP/XwThUBZfPdawHpX/zx8=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by SI2PR03MB5722.apcprd03.prod.outlook.com (2603:1096:4:153::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Wed, 20 Dec
 2023 07:59:58 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::ebb9:e872:cb84:4a88]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::ebb9:e872:cb84:4a88%5]) with mapi id 15.20.7113.016; Wed, 20 Dec 2023
 07:59:58 +0000
From: =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>
To: "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "robh+dt@kernel.org"
	<robh+dt@kernel.org>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "chunkuang.hu@kernel.org"
	<chunkuang.hu@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	=?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= <Singo.Chang@mediatek.com>,
	=?utf-8?B?Sm9obnNvbiBXYW5nICjnjovogZbpkasp?= <Johnson.Wang@mediatek.com>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	=?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?=
	<Jason-ch.Chen@mediatek.com>, =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?=
	<Shawn.Sung@mediatek.com>, "mchehab@kernel.org" <mchehab@kernel.org>,
	=?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 2/3] dt-bindings: media: mediatek-mdp: Change the
 description of gce-events
Thread-Topic: [PATCH 2/3] dt-bindings: media: mediatek-mdp: Change the
 description of gce-events
Thread-Index: AQHaMY16BaK9KJXqAUq1Ek97hTWLVLCxwv6AgAAO8oA=
Date: Wed, 20 Dec 2023 07:59:58 +0000
Message-ID: <5d92db1abf4cc52e8520caad5776b7f0719fc9a6.camel@mediatek.com>
References: <20231218083604.7327-1-jason-jh.lin@mediatek.com>
	 <20231218083604.7327-3-jason-jh.lin@mediatek.com>
	 <e645a032-67d7-4669-9487-585635a1702e@linaro.org>
In-Reply-To: <e645a032-67d7-4669-9487-585635a1702e@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|SI2PR03MB5722:EE_
x-ms-office365-filtering-correlation-id: 67afcddf-6591-41f5-bb48-08dc0131a902
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9zSdlKQq28Bek39uEjrkjsAwELg/3A0ztb8mAWnpgvcdyiQOio6AZu1UC7N3asVmfeblUqVKGSvA80ABLA/SSWo+KuohGdRCxi/qybv9lMucgkUh1KJzGQvqtvbivDZkQt0T6V10MPrVhVlaLKcHCQ8cKy+iz/Z9LRGvydEGcjCONd1TlxWCI9gkeoR44CHMXHfbyXgmjKZnm432y9sbDyc6xhbEWRU1zh8Ph2c+Niyb8OXISYVm/5q9vGIi7xXg/yHouudxDaEvk927fvxalrQAi9x176G1sbTAyx00E3YhU+msOF87i+LGka/MYlQ5kdrNc5qCgD+nAeszTzKKnpq3CT+5VXpnxs4dvoEXBFly5mOLj9rHZlb98ksuABNBxxinC70maVr/XDoN7H0iEG3p+0f/FPUCfTjtZuktGR1S+7eVuCT77q922BpV6Rv2Cw/1E++mFKlKuQBtGtV0weeS9RSGi1OVJHVSFe0tu2qFgsi/r/LZfcN5Jktk6D+BBUtut4W8pmuG8H/H0bUduttRHWfCFIqCtP0tIxMhRAUFA6zcpHt4qtqrfCrpUp/cLJdFNZ71VSKE6Z1G1paLGRvCscb+kXqllTCWBUb8HE1/IqcGjfoTxg0ooVqzOpjOlKlfKsXmwPsxmiVRkY4s4oJH90Yx2MEC1DUzqhvPj1waKHt0XK1jWAipSUuLOqarR2xdt6JspTgDPLcgTH1nSA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(396003)(366004)(39860400002)(230273577357003)(230173577357003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(2906002)(4001150100001)(41300700001)(86362001)(85182001)(36756003)(38100700002)(122000001)(71200400001)(316002)(478600001)(54906003)(110136005)(6506007)(6512007)(66476007)(8936002)(8676002)(6486002)(66446008)(76116006)(66946007)(66556008)(64756008)(91956017)(7416002)(5660300002)(26005)(4326008)(83380400001)(53546011)(2616005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QllvMklsbTFBcDFxbXpvK2x5WVhqTkN5eFFmczg3Wmk5OWM3b2Y3bjBpYTJK?=
 =?utf-8?B?K0laREIybGxwMmdkQkY4NytXVDZjT1lLUjdsTUY0WTBsNEpyc3h4dVZUV0cx?=
 =?utf-8?B?U09ZMHJKaHZCWnF5MHVGeXFidnJQMnBPU3BubnY2cFBYWE5FVkVZeWNjOEdq?=
 =?utf-8?B?VitoOVR1N3RIL2NUZFhEUCtzaVl2VUYrTHVoT1RuY2x4U3BDd1BTSU4vQlEv?=
 =?utf-8?B?ZWxSV3RLVUVuMFhOYnBFeVpFMnFTYmJhZEpJNnduWnFUTk1USXhXVGtYWnlo?=
 =?utf-8?B?alViT3diYnRJQklyT0dTc3ZOUTBIb0FUZWYySi84eU1FcGtxSTkxbGllVU5y?=
 =?utf-8?B?U3V4MnBQekxlN1ozWnNGSjNzRkZ2V1dEYUl5djNHSEZmMFl4MzZNL05pbDZI?=
 =?utf-8?B?Qy9idjZLdFFiVk1lV2FPZ2hZdGhPakNxU2w2amdLc0cyRWg3b3Axdm9GZHJx?=
 =?utf-8?B?alNnd0ZCV0xhTXJVTWZtdDBtTFZWbXY3TFJlcElzQUdNSUZ6K1lMZ2ZpTkVH?=
 =?utf-8?B?dkR2a2VaZlB1MW5TZzNyeDgvMEtaWUhzemdjUldvUmlaTXNBazF4Y0ZDcG9q?=
 =?utf-8?B?YkxlM3NrczdBMHkzVUhhTGFRalhVZGFaMENwdy9IYmNLWERVblVpRFZ1SjEw?=
 =?utf-8?B?V2s0NXpEMEdGNmpUTkNWd212cXo2NkdWY3RpNGYza2tjNVJqTTlOUDFaZ0Nn?=
 =?utf-8?B?TlpUUDZLd3BTb0U2QUtKZnZXTndKMzNHbmtLTEpFRFU2WXlzUFd6OFZ6ZEhL?=
 =?utf-8?B?WFd0cG1FUlVkRjRHTXFmNjRrKzc0NUYyaS81V3RVMkNVbXpUSkVwS1l6RkMw?=
 =?utf-8?B?MEJYbGt5dGRuQ0JHWFRhNHBYY1JxSlR0c2RWbERYUTBZb2JIZlNjc2JJZUdS?=
 =?utf-8?B?RktjUFNKcG9pY2JBNU10Wmtwcm9XbWUvbHlrbVYrSXMzcjRicmpyYk52ckZR?=
 =?utf-8?B?OTZHVHk2ZlppRGxwaXFwN1hURk54MXduQkZvNENGajZ4RGxNSko0VDBQRi8v?=
 =?utf-8?B?Wkd4QXJiYmRSK1NnbittSHl2Qk5KV1V3ZnFweDZ0cENISGJPRnNRUTFyY2dQ?=
 =?utf-8?B?OE8wakpCTzRYVXJwTlJaNWtsa05LVXRnOGloVUFDZVdndkIvQXJBRzN5MU1G?=
 =?utf-8?B?M3MrTFR5OVlHRXJ6M0V2c3M4UkllTis5V0hkSkVic2FHdjM1a2cvSmRmeGhX?=
 =?utf-8?B?ZDJFb2ZnSGJNaVFHU2tBYXA2aUViQ1JMa2FzUUJ2bzNMdHRiRmozNFFtNkp3?=
 =?utf-8?B?RGs5REtXOUVFL1NYU05ISkR5cENZU2NDaUE0ZXk5TW5IeCtDU012UVU4QzJK?=
 =?utf-8?B?NmFtbW91cEw5WWFQaGd5Q2habXg5cFpLdS95ZGxJcG43U21UNzFvc25WUmsr?=
 =?utf-8?B?MXVhZjg0dnBlT2FoYjFpT0lFRjZDK2poUmJITlFjc3g2Z2J5d3JFak1YNjAz?=
 =?utf-8?B?VzdVbkJwaC9SaTNvdDhUUjRDaXlvRFdLMkkzamV3dU1SYktuRktWd240Nnpn?=
 =?utf-8?B?MVkrenU0SmpSOGRzNEtabVl2Q2I3TFlKOVZFU1VGWUZwWmo2QktiK1RpZVVD?=
 =?utf-8?B?RENpRURUMHFQem1iL2lXSkVraU4rV2xSek4rWTJDNkVWSjBBalNzQ3MxMHNh?=
 =?utf-8?B?S2Y1L1RkUTZzR1dwWHhndEYybTVFWmp5MTBRc1ZWbCtEeHFlUFVWRzduR2xl?=
 =?utf-8?B?WldLQmxMZk0vZ052UUdzQXRVODdxNkU1N1Y3WnVGbmtEbDBHdG5CRGRkWWRm?=
 =?utf-8?B?RU1JeUZRRGVpK0dmZC8vTldUR3M1WXhhNG5jVnVFNERGL2czYUNHMnZSdHdk?=
 =?utf-8?B?RTQzc1h1OUVXWHhVZmVRVE9zQzNmWkhRN05oRndkeW1DUDdhQVdGRHZNSVpU?=
 =?utf-8?B?MzBzaGgyMnVZNThlR1Fud1VoeDdBZzNOWnI4UGhTU2ltYWhXdU0zSEJPazRY?=
 =?utf-8?B?TkNDUkluSW9VZWZXbHNnS0lvZVdKUFE0eHhqSWRuV3FVQTAxWnExZjRUcjZz?=
 =?utf-8?B?OUlQTG9WaDlNNFVjNUhDMnN5VU0yU3ZCcU4zYnllczdQbjFMRzVuTW5zS2VT?=
 =?utf-8?B?QmJYTlViREVZa3NRb1Y0dTgyR0lFaTZNM3gvMHhwUG9zUERROGNTeU5UZmtp?=
 =?utf-8?B?aUh1M2QzdzNFcUNrUGk4eHNydGJXcVVoS21OaStNOENPK1B3Q3Azc2E5RThk?=
 =?utf-8?B?YXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C2F7D81A7FB7E448B32DCA99107766C9@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67afcddf-6591-41f5-bb48-08dc0131a902
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2023 07:59:58.0164
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8NNo2104P4oOghuKEjS37AJ4jjMVw4twj40HfYv90KYr/YQnk4LLPNMeQmCyvlTnMT8Y9GAU4F+Oj9aTXa7Q2muEDWFHZUHbiTJrPCiOCjQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB5722

SGkgDQoNClRoYW5rcyBmb3IgdGhlIHJldmlld3MuDQoNCk9uIFdlZCwgMjAyMy0xMi0yMCBhdCAw
ODowNiArMDEwMCwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gIAkgDQo+IEV4dGVybmFs
IGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVu
dGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRlbnQuDQo+ICBP
biAxOC8xMi8yMDIzIDA5OjM2LCBKYXNvbi1KSC5MaW4gd3JvdGU6DQo+ID4gQ2hhbmdlIHRoZSBk
ZXNjcmlwdGlvbiBvZiBtZWRpYXRlayxnY2UtZXZlbnRzIHByb3BlcnR5IHRvIHJlZmVyZW5jZQ0K
PiA+IG1lZGlhdGVrLGdjZS1tYWlsYm94LnlhbWwuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTog
SmFzb24tSkguTGluIDxqYXNvbi1qaC5saW5AbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+ICAu
Li4vZGV2aWNldHJlZS9iaW5kaW5ncy9tZWRpYS9tZWRpYXRlayxtZHAzLXJkbWEueWFtbCAgICAg
ICAgfCA1DQo+ICstLS0tDQo+ID4gIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL21lZGlhL21lZGlh
dGVrLG1kcDMtcnN6LnlhbWwgICAgICAgICB8IDUNCj4gKy0tLS0NCj4gPiAgLi4uL2RldmljZXRy
ZWUvYmluZGluZ3MvbWVkaWEvbWVkaWF0ZWssbWRwMy13cm90LnlhbWwgICAgICAgIHwgNQ0KPiAr
LS0tLQ0KPiA+ICAzIGZpbGVzIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMTIgZGVsZXRpb25z
KC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9tZWRpYS9tZWRpYXRlayxtZHAzLQ0KPiByZG1hLnlhbWwgYi9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvbWVkaWEvbWVkaWF0ZWssbWRwMy0NCj4gcmRtYS55YW1sDQo+ID4g
aW5kZXggNzAzMmM3ZTE1MDM5Li5hZGIzZGY0NzMxZjYgMTAwNjQ0DQo+ID4gLS0tIGEvRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21lZGlhL21lZGlhdGVrLG1kcDMtDQo+IHJkbWEu
eWFtbA0KPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZWRpYS9t
ZWRpYXRlayxtZHAzLQ0KPiByZG1hLnlhbWwNCj4gPiBAQCAtNDAsMTAgKzQwLDcgQEAgcHJvcGVy
dGllczoNCj4gPiAgDQo+ID4gICAgbWVkaWF0ZWssZ2NlLWV2ZW50czoNCj4gPiAgICAgIGRlc2Ny
aXB0aW9uOg0KPiA+IC0gICAgICBUaGUgZXZlbnQgaWQgd2hpY2ggaXMgbWFwcGluZyB0byB0aGUg
c3BlY2lmaWMgaGFyZHdhcmUgZXZlbnQNCj4gc2lnbmFsDQo+ID4gLSAgICAgIHRvIGdjZS4gVGhl
IGV2ZW50IGlkIGlzIGRlZmluZWQgaW4gdGhlIGdjZSBoZWFkZXINCj4gPiAtICAgICAgaW5jbHVk
ZS9kdC1iaW5kaW5ncy9nY2UvPGNoaXA+LWdjZS5oIG9mIGVhY2ggY2hpcHMuDQo+ID4gLSAgICAk
cmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9ucy91aW50MzItYXJyYXkNCj4gPiAr
ICAgICAgUmVmZXJlbmNlIHRvDQo+IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9t
YWlsYm94L21lZGlhdGVrLGdjZS1tYWlsYm94LnlhbWwuDQo+IA0KPiBUaGVyZSBpcyBubyByZWZl
cmVuY2UgaGVyZS4gWW91IGFsbG93IG5vdyBhbnkgdHlwZS4gVGhpcyBkb2VzIG5vdA0KPiBtYWtl
DQo+IGFueSBzZW5zZS4NCg0KU2luY2UgdGhpcyBwcm9wZXJ0eSBmb3IgdGhlIEdDRSBIVyBhcmUg
TWVkaWFUZWsgc3BlY2lmaWMsIEkgd2lsbCB0cnkNCnRvIHJlZmVyIHRvIG52aWRpYSx0ZWdyYTIx
MC1xdWFkLXBlcmlwaGVyYWwtcHJvcHMueWFtbCBhbmQgc2VuZCBhDQpzZXJpZXMgZm9yIGNyZWF0
aW5nIGEgbWVkaWF0ZWssZ2NlLXByb3BzLnlhbWwgdG8gbGlzdCBhbGwgdGhlc2UNCnByb3BlcnRp
ZXMgcmVsYXRlZCB0byBHQ0UuIEFuZCBjaGFuZ2UgYWxsIHRoZXNlIHByb3BlcnRpZXMgaW4gbWFp
bGJveA0KY29uc3VtZXJzIHRvIHJlZmVyZW5jZSBtZWRpYXRlayxnY2UtcHJvcHMueWFtbC4NCg0K
YWxsT2Y6DQogIC0gJHJlZjogbWVkaWF0ZWssZ2NlLXByb3BzLnlhbWwNCg0KDQpSZWdhcmRzLA0K
SmFzb24tSkguTGluDQoNCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQo+IA0K

