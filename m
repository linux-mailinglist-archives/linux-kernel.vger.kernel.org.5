Return-Path: <linux-kernel+bounces-11373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E26C81E547
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 06:44:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2DC0B215F9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 05:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B6A4BA90;
	Tue, 26 Dec 2023 05:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="KYW9avEk";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="q/60pj1x"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C938B4B5B3;
	Tue, 26 Dec 2023 05:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: ace742b6a3b111eea5db2bebc7c28f94-20231226
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=cNZb/6kxXdCfq7w1aKNjxpQzRnH6nerISSVBKGBz4yY=;
	b=KYW9avEkxVIeCChaQKV2LoVD8/6zGZl4DhIKQEAIl4s7NedPfTIImi7GhAmmnPZKp+d2JtoPsbtHwnsFs2PJni6j2w6gYGaxZWs8GUru1i7Z5OHi4ks0JnT9RD3Uyf3RsHYWToUvNj5ahqId/mWp6NSXXrlW7soLL/cnTM6g7Uw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:a250a9a6-ccfe-4265-8b3f-b24bd48bacdb,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:c4e02b82-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
	NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: ace742b6a3b111eea5db2bebc7c28f94-20231226
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1851462440; Tue, 26 Dec 2023 13:43:20 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 26 Dec 2023 13:43:18 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 26 Dec 2023 13:43:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QyZV/B5zKoGT2OW+x+l37cnc8CQ53IFc7dPFp3tjwfOYI/c+dhV0irTRaTgNmpz9h+txPvlf7EFjjZKu4SAwotp4/dfrkmNK4rMEz8NOhLlj71Y5Ivp/hnQT891cmU45AolHnrZviRojyIx4smVyi0DDWnZ09FxA4X9I7ApVYa+EfiuUBNZ7rxS5f/xLzjTYNwYWbo+EgvklpFeQOWeba8nB7Ew+dy6LqzJO6DKFF9aDbBrNK+kMPkjax9HS68neiVcFC8twKtnK/YKLLah6x5T1g3PkwbTjLk1PCJ54ziiV0corUz4F5qsy13mNh75DjOE31MXt2ZVsZHuGgpTJdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cNZb/6kxXdCfq7w1aKNjxpQzRnH6nerISSVBKGBz4yY=;
 b=Yu7J2yCqY8sM+PX7iktF231YDJEi21AWfoyTXfdXx2aZlHrEy8GwAT9VPmG6PT3CfvKUJteIhsBDpgsYV+w8Vj4anqbhP2ZGfcNEmD6LL76gm2GqPAxgmuwUdhb35z5980BxZ3kOeaqryRKBhQjz0E3myZLoq2w1uK27+AVJsUoD2htB36P0g6laxSGtQX5cPfy79MRSnFrsc7gSLjkj6L2gpZqk/EWwZSVUosc+QmLhHiWPgsnBuY1/ewN2uScyy5QNjmhqi8vUM2ZlXbbSPjIUAlbWYrwgfLYCTqZRFnMAMnseZ3d6QU5ikvKEhLAwghmOZMxjz+0Vau3cr24WWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cNZb/6kxXdCfq7w1aKNjxpQzRnH6nerISSVBKGBz4yY=;
 b=q/60pj1xdfOIANjn9QtfTwHojxmfkJDEtRSK98vGvQhrrG/6ZMHmuowEC2z7F+4elDfGwuIwiHqNDzaDVirjeeYqU4fdUGkYqpi4RGfOUbT/ZWyX8CuaCyOzcvcUEwAtkP3Qs7qJ6uBfckD8ftzde40v9jPJPSBNeEXdjs6YHdk=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by PSAPR03MB5510.apcprd03.prod.outlook.com (2603:1096:301:65::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27; Tue, 26 Dec
 2023 05:43:15 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::eb43:57cb:edfd:3762]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::eb43:57cb:edfd:3762%7]) with mapi id 15.20.7113.027; Tue, 26 Dec 2023
 05:43:15 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	=?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= <Singo.Chang@mediatek.com>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	=?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?=
	<Jason-ch.Chen@mediatek.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?=
	<Shawn.Sung@mediatek.com>, =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?=
	<Nancy.Lin@mediatek.com>, =?utf-8?B?Sm9obnNvbiBXYW5nICjnjovogZbpkasp?=
	<Johnson.Wang@mediatek.com>, "jkardatzke@google.com" <jkardatzke@google.com>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 09/11] drm/mediatek: Add secure flow support to
 mediatek-drm
Thread-Topic: [PATCH v3 09/11] drm/mediatek: Add secure flow support to
 mediatek-drm
Thread-Index: AQHaNc4y0hOLdywtD0+HCU7ZslayPbC7ETkA
Date: Tue, 26 Dec 2023 05:43:15 +0000
Message-ID: <63c24cda9e007ef2128e9350b6a6ed3bc61f3a85.camel@mediatek.com>
References: <20231223182932.27683-1-jason-jh.lin@mediatek.com>
	 <20231223182932.27683-10-jason-jh.lin@mediatek.com>
In-Reply-To: <20231223182932.27683-10-jason-jh.lin@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|PSAPR03MB5510:EE_
x-ms-office365-filtering-correlation-id: 604fc846-f83a-43a6-47a8-08dc05d58e6f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6P/3yUWmHNSlXLopp+7txFO1eH9Rd1siT9OhErNSoh0VhfvtGY95jWj0mV0SqAisGppS/ejBhNFgmm4IojwIIb7kgg3nVepx0BUMIj2ngfnkioiwARjxinLItosKxaY4Bm23Xk5J54DUd4K8o610+XRUuGYDAbv/IhI0TqMttIU99GqhfxYwMTgLx/FVCWRbsdMX2a5RGaKvUNUxiVUUHPMl/Y6z4hkGYqDUfHtWimTr0s0FAqLCG/bygnCiipBiwCLEfeA5vGHhJ2HsfVf8C2l7lvaF5Mfc1Rga2yPYyBLP87SC7K6jJ2Bn7nb9i/MgTUpfxrHn+J3ZIJ0w1UjYZ02iadl515a9AsfIw2dINFEz2k8jiC3HUblgZMQIWKNfYodVnf5femVqWQf5+Eqy6f7ItOroDrHZ1jdbg5onAoVZGaAug6ZPrBNAFJuG6EQzZei1PYwsYpKOQvq17FUkzPppgacytjdwp6vCMtjDnbeBr1vpRdQ4w1rbExlk6pK94PAC4WtOhsBSvyr4YQgdI5/vs+1ugAvLQGo9LDN2uhl1SVFSgIBqXeuy6MolK1xT6v4+mKwsfYwvyPTeKO0KBmHw+NjX9zLALZ68KsdyNoSk6w1yX0rNQBCJJkzJFg05VKtEozkPkSN8Mmd4KMVW4XCWJ4FRQcZj4T8nryt3ajk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(396003)(136003)(366004)(346002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(85182001)(36756003)(71200400001)(6512007)(6506007)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(6486002)(86362001)(38070700009)(26005)(38100700002)(122000001)(83380400001)(2616005)(41300700001)(2906002)(5660300002)(4001150100001)(8936002)(7416002)(8676002)(478600001)(316002)(54906003)(4326008)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cDJHdC9oQ1ZSRUFxSzFGZkJFRWdWTDBqV3FjNnJwYUMrQkswVkM4MWlneHlM?=
 =?utf-8?B?bEhxMXZWUDhoeTlQMkt6eVNDWTBkcGlEczVsYzN5RkRHQlhBLzFHK1l5MFlG?=
 =?utf-8?B?WGlOR3RXMVVTSkdmSEwvS0xFN1J2REJ0Q1dXNkphVDVxbFhBdE9FOUd6Q3Vi?=
 =?utf-8?B?TTArSXZUVXVsMTBKMS9oT3ZGRFR6dEl1VXN0a2N5bFRhTWZmNUtqWGdNVksx?=
 =?utf-8?B?RHJYL0tiVzI1L1E3ZHlwZ3cvRmdVYmU4UVVxNkd2aU9VN3pHRGNFUGtoaktI?=
 =?utf-8?B?d2czSExaK25vWDVlNFRScFkxZkthS21RanV2UDVxUEVwYXVGMUNVMGQ2Nmo3?=
 =?utf-8?B?Wmt2eWRVWDV1NmJ6dlA1NnNiakkzb05KbDM1RUZPN0VQNG9iOGpzVGlOdDMw?=
 =?utf-8?B?ZUowU003UndVWTBnT2t2Q0dZY21neUswWFVIN1dvTXZWS2JvaE9tWTB0TFg2?=
 =?utf-8?B?VGwxbFV0cnZrbVM3UXZtaUt1bUNSdUM0NTVGZzlkQnAzd0hLZnRnOTFEamRh?=
 =?utf-8?B?TURtOGtGaTM4azRxMEUyeWdXSmpzQkwxRFA4NzhGTzEyTWFZYVJ4SmhQSGpm?=
 =?utf-8?B?UTMrNThNdys3VEVmMjV3WUl4NHl5MnZVN1pMSUFGSktRbzdFdGQ3SUZUVGwx?=
 =?utf-8?B?MVV2QlpUN3dsSzJWamZudXBxMnZuRFN2L3greCtCV0tHa25NZkZVd2ZzOHli?=
 =?utf-8?B?dkxVUEFHRzU1cWdJUzd6VDA1TnJaSWZrd3Z3dDlCamxQZGF3bGpZckg5NThH?=
 =?utf-8?B?THpNcElVTFZ1dVZGYWNUdlQyOGlpenJDNThFaHBaenhzT2l1c2I2TTUvQVNy?=
 =?utf-8?B?cGZYb2hZT0I3ZGxaYTdmV1FoTWtzUUJNa2ZaeGh5eWwraWZRdVFGZUtwSTgx?=
 =?utf-8?B?SHlwTGZDR2dFYVczSUhvTElVakFIZEgxeFJBYm9uZkM2QktXY3RSYzdtaDN0?=
 =?utf-8?B?VHgvcGpmeW42aVpzV0lNM01KR084VHEzZmEzL21ma3NUaSsrdWsrMW9RaTBZ?=
 =?utf-8?B?bEhaLzJhTFdYNTZKMXZVejFTRHVLMEtFclFyT2hVT24yYWVvYnJiaml3bGh3?=
 =?utf-8?B?VDdQRUsyeHlRODI3TWUvTy9JREU1a3F6UEtESnRDbGQybGtoZkR5eFdXS2xI?=
 =?utf-8?B?dENzRncrM240WTNiMC80OCt6SzRRbDQzWXlqbGJzOHNiSll2NTBaODhWUzg5?=
 =?utf-8?B?WkpjaDVhVXpmUDN3Z2VDS3NrYVJlNVJZSjh5T1hUYXdML2lJaFAzYWRyVnc3?=
 =?utf-8?B?T3VMOThUWU5uQnpWUzRkT0VkSnZnMnNKc2dsQk5RWnpmZ2k1VlA4cFFaWk9F?=
 =?utf-8?B?QXVqakkvbllnMVNEREtYVFphMG5PUnBoelp3em9mak9PMUMycm5udUlJYklv?=
 =?utf-8?B?ZXpkSXhFUUwySGlINFczL0Z1Si9YQ3lCMVluZkYvZ2k2akNDd1B3dUpnSSsv?=
 =?utf-8?B?RzdtZDJmcDNhSmdZU1N1Uk4yK2dlWjhuTEhvcWREdi8rYi9tZzZMN3pNMzJx?=
 =?utf-8?B?c2tlK0RrRlNSZ3lpRFRHaFhLNVJtNGgwc2czeEhDQjhLZFgyL0tnRUdiOHgw?=
 =?utf-8?B?bkdOdFpyMmFwYWFjS2xoQkRWVE5xeDFsUktacWMyTUFKbmdEdHoxVEdUVnJX?=
 =?utf-8?B?TmxGTUFqNTFmSC9saG9ROGxrS05FOW40Zzh0eFRBVysxMTRLczlEVVRTMUxD?=
 =?utf-8?B?M0hPWGl0TmtjMTJycS9tbFpWVzdXYnZ1RlNxUUZqUVJ3OWhwazI3cHNKRFJs?=
 =?utf-8?B?dTNHelE3Z2hhRG9RUFFsT0FySHNhZHMrQ0Q4U1J6SE9aWnE4b0hlcEVKNkR5?=
 =?utf-8?B?U01GYUNKZkQ4TThmek1SNXRaSGlDbmFYWFBMWTFScTgvcDN0RXpzM1BKVlVa?=
 =?utf-8?B?SVZpajJXMWZDajhlZkk3bURPS2hzTkc3TW5od1RLaW5ucEhyMVU1N3QyRTJl?=
 =?utf-8?B?S0RWMy92WGhxQWU3ZWNhY0RZQVZaZHoydGM3aFkraFdacksrbnhaQkJ1OWdq?=
 =?utf-8?B?SDZuWm1RVzAySzRlQngvczE4TGpJWCsvbEMvSUlSdjVHdkxFU1dYQ3BUa21R?=
 =?utf-8?B?RTRvQ0tSY1ZOQ2tKRHJrSEFkVUc1K1QzV3Qza21EQ0hSNkdNWEEwOW9VWlZ0?=
 =?utf-8?Q?v1YfZhC7qK6daMPdei8jPOE9F?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <429280FDFD787041A4FCF3563346FE97@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 604fc846-f83a-43a6-47a8-08dc05d58e6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Dec 2023 05:43:15.5574
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +A/MnGlhSmTstGyfXEnqiIN0wzaFkyhRS6UkzI2BRnB1oQ8/+kHEELZe6FVxKUACeIh6k9fbGfws5xw6VwZB1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR03MB5510
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--16.847800-8.000000
X-TMASE-MatchedRID: 8+bhjh9TQnEOwH4pD14DsPHkpkyUphL9MZm0+sEE9mv3bBqxmjinTSac
	nbShnMCcT1Lpx45+MkWD1p+T3PkHcwZuQ+SK0t7OQsSgfTKe5lUzhiZx6LuON/vHmhh5NK3qee+
	psuSMY7psYKTXYEfqHqmN6Vg7c0C4PyFc0r7cUGHJ5W6OZe5hhXnUZqRb3abmw01zN1c0miJ8Fu
	xHNixhdol51QNH2W4wq1+0e0wXKb2HTNZBcJlnyDQlj13qze9pFAr+wPWe7jGTodx4qqDXkusu2
	jSWEv0Mo5qw/iFKtvYgSMwuGTMgiXrSP9RtGZYo4bl1FkKDELft/okBLaEo+A6QlBHhBZuw1LEl
	BafwPkri8zVgXoAltj2Xsf5MVCB1t7DW3B48kkHdB/CxWTRRu25FeHtsUoHusnz13Ch9Fz2iJzh
	Ydd/4E7Sn/8VwuZfpx0eBWbc78fxLhb8xGEnVfg==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--16.847800-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	830B51AE8EF138834BCD3CE143FE6DAA398048CE0F53677EB8A229F628AF217B2000:8

SGksIEphc29uOg0KDQpPbiBTdW4sIDIwMjMtMTItMjQgYXQgMDI6MjkgKzA4MDAsIEphc29uLUpI
LkxpbiB3cm90ZToNCj4gVG8gYWRkIHNlY3VyZSBmbG93IHN1cHBvcnQgZm9yIG1lZGlhdGVrLWRy
bSwgZWFjaCBjcnRjIGhhdmUgdG8NCj4gY3JlYXRlIGEgc2VjdXJlIGNtZHEgbWFpbGJveCBjaGFu
bmVsLiBUaGVuIGNtZHEgcGFja2V0cyB3aXRoDQo+IGRpc3BsYXkgSFcgY29uZmlndXJhdGlvbiB3
aWxsIGJlIHNlbnQgdG8gc2VjdXJlIGNtZHEgbWFpbGJveCBjaGFubmVsDQo+IGFuZCBjb25maWd1
cmVkIGluIHRoZSBzZWN1cmUgd29ybGQuDQo+IA0KPiBFYWNoIGNydGMgaGF2ZSB0byB1c2Ugc2Vj
dXJlIGNtZHEgaW50ZXJmYWNlIHRvIGNvbmZpZ3VyZSBzb21lIHNlY3VyZQ0KPiBzZXR0aW5ncyBm
b3IgZGlzcGxheSBIVyBiZWZvcmUgc2VuZGluZyBjbWRxIHBhY2tldHMgdG8gc2VjdXJlIGNtZHEN
Cj4gbWFpbGJveCBjaGFubmVsLg0KPiANCj4gSWYgYW55IG9mIGZiIGdldCBmcm9tIGN1cnJlbnQg
ZHJtX2F0b21pY19zdGF0ZSBpcyBzZWN1cmUsIHRoZW4gY3J0Yw0KPiB3aWxsIHN3aXRjaCB0byB0
aGUgc2VjdXJlIGZsb3cgdG8gY29uZmlndXJlIGRpc3BsYXkgSFcuDQo+IElmIGFsbCBmYnMgYXJl
IG5vdCBzZWN1cmUgaW4gY3VycmVudCBkcm1fYXRvbWljX3N0YXRlLCB0aGVuIGNydGMgd2lsbA0K
PiBzd2l0Y2ggdG8gdGhlIG5vcm1hbCBmbG93Lg0KPiANCj4gVE9ETzoNCj4gMS4gUmVtb3ZlIGdl
dCBzZWMgbGFyYiBwb3J0IGludGVyZmFjZSBpbiBkZHBfY29tcCwgb3ZsIGFuZA0KPiBvdmxfYWRh
cHRvci4NCj4gMi4gVmVyaWZ5IGluc3RydWN0aW9uIGZvciBlbmFibGluZy9kaXNhYmxpbmcgZGFw
YyBhbmQgbGFyYiBwb3J0IGluDQo+IFRFRQ0KPiAgICBkcm9wIHRoZSBzZWNfZW5naW5lIGZsYWdz
IGluIG5vcm1hbCB3b3JsZC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEphc29uLUpILkxpbiA8amFz
b24tamgubGluQG1lZGlhdGVrLmNvbT4NCj4gDQoNCltzbmlwXQ0KDQo+IEBAIC0xMDkxLDE0ICsx
MjkyLDYzIEBAIGludCBtdGtfZHJtX2NydGNfY3JlYXRlKHN0cnVjdCBkcm1fZGV2aWNlDQo+ICpk
cm1fZGV2LA0KPiAgCQkJaWYgKHJldCkgew0KPiAgCQkJCWRldl9kYmcoZGV2LCAibXRrX2NydGMg
JWQgZmFpbGVkIHRvDQo+IGNyZWF0ZSBjbWRxIHBhY2tldFxuIiwNCj4gIAkJCQkJZHJtX2NydGNf
aW5kZXgoJm10a19jcnRjLQ0KPiA+YmFzZSkpOw0KPiAtCQkJCW1ib3hfZnJlZV9jaGFubmVsKG10
a19jcnRjLQ0KPiA+Y21kcV9jbGllbnQuY2hhbik7DQo+IC0JCQkJbXRrX2NydGMtPmNtZHFfY2xp
ZW50LmNoYW4gPSBOVUxMOw0KPiArCQkJCWdvdG8gY21kcV9lcnI7DQo+ICAJCQl9DQo+ICAJCX0N
Cj4gIA0KPiAgCQkvKiBmb3Igc2VuZGluZyBibG9ja2luZyBjbWQgaW4gY3J0YyBkaXNhYmxlICov
DQo+ICAJCWluaXRfd2FpdHF1ZXVlX2hlYWQoJm10a19jcnRjLT5jYl9ibG9ja2luZ19xdWV1ZSk7
DQo+ICAJfQ0KPiArDQo+ICsJbXRrX2NydGMtPnNlY19jbWRxX2NsaWVudC5jbGllbnQuZGV2ID0g
bXRrX2NydGMtPm1tc3lzX2RldjsNCj4gKwltdGtfY3J0Yy0+c2VjX2NtZHFfY2xpZW50LmNsaWVu
dC50eF9ibG9jayA9IGZhbHNlOw0KPiArCW10a19jcnRjLT5zZWNfY21kcV9jbGllbnQuY2xpZW50
Lmtub3dzX3R4ZG9uZSA9IHRydWU7DQo+ICsJbXRrX2NydGMtPnNlY19jbWRxX2NsaWVudC5jbGll
bnQucnhfY2FsbGJhY2sgPSBkZHBfY21kcV9jYjsNCj4gKwltdGtfY3J0Yy0+c2VjX2NtZHFfY2xp
ZW50LmNoYW4gPQ0KPiArCQkJbWJveF9yZXF1ZXN0X2NoYW5uZWwoJm10a19jcnRjLQ0KPiA+c2Vj
X2NtZHFfY2xpZW50LmNsaWVudCwgaSArIDEpOw0KPiArCWlmIChJU19FUlIobXRrX2NydGMtPnNl
Y19jbWRxX2NsaWVudC5jaGFuKSkgew0KPiArCQlkZXZfZXJyKGRldiwgIm10a19jcnRjICVkIGZh
aWxlZCB0byBjcmVhdGUgc2VjIG1haWxib3gNCj4gY2xpZW50XG4iLA0KPiArCQkJZHJtX2NydGNf
aW5kZXgoJm10a19jcnRjLT5iYXNlKSk7DQo+ICsJCW10a19jcnRjLT5zZWNfY21kcV9jbGllbnQu
Y2hhbiA9IE5VTEw7DQo+ICsJfQ0KPiArDQo+ICsJaWYgKG10a19jcnRjLT5zZWNfY21kcV9jbGll
bnQuY2hhbikgew0KDQpJIHdvdWxkIGxpa2UgdXNlIHNlY3VyZSBjaGFubmVsIHRvIHJlcGxhY2Ug
bm9ybWFsIGNoYW5uZWwuIEl0IG1lYW5zDQp0aGF0IG5vIGV4dHJhIGNoYW5uZWwgaXMgcmVxdWly
ZWQgYW5kIGNoYW5nZSB0aGUgb3JpZ2luYWwgbm9ybWFsDQpjaGFubmVsIHRvIHNlY3VyZSBjaGFu
bmVsLiBUaGUgc2VjdXJlIGNoYW5uZWwgY291bGQgcHJvY2VzcyBib3RoIG5vcm1hbA0KYnVmZmVy
IGFuZCBzZWN1cmUgYnVmZmVyLCBzbyB5b3UgbmVlZCBub3QgdG8gc3dpdGNoIHRoZSBjaGFubmVs
Lg0KDQpSZWdhcmRzLA0KQ0sNCg0KPiArCQlzdHJ1Y3QgZGV2aWNlX2xpbmsgKmxpbms7DQo+ICsN
Cj4gKwkJLyogYWRkIGRldmxpbmsgdG8gY21kcSBkZXYgdG8gbWFrZSBzdXJlIHN1c3BlbmQvcmVz
dW1lDQo+IG9yZGVyIGlzIGNvcnJlY3QgKi8NCj4gKwkJbGluayA9IGRldmljZV9saW5rX2FkZChw
cml2LT5kZXYsIG10a19jcnRjLQ0KPiA+c2VjX2NtZHFfY2xpZW50LmNoYW4tPm1ib3gtPmRldiwN
Cj4gKwkJCQkgICAgICAgRExfRkxBR19QTV9SVU5USU1FIHwNCj4gRExfRkxBR19TVEFURUxFU1Mp
Ow0KPiArCQlpZiAoIWxpbmspIHsNCj4gKwkJCWRldl9lcnIocHJpdi0+ZGV2LCAiVW5hYmxlIHRv
IGxpbmsgZGV2PSVzXG4iLA0KPiArCQkJCWRldl9uYW1lKG10a19jcnRjLQ0KPiA+c2VjX2NtZHFf
Y2xpZW50LmNoYW4tPm1ib3gtPmRldikpOw0KPiArCQkJcmV0ID0gLUVOT0RFVjsNCj4gKwkJCWdv
dG8gY21kcV9lcnI7DQo+ICsJCX0NCj4gKw0KPiArCQlyZXQgPSBtdGtfZHJtX2NtZHFfcGt0X2Ny
ZWF0ZSgmbXRrX2NydGMtDQo+ID5zZWNfY21kcV9jbGllbnQsDQo+ICsJCQkJCSAgICAgICZtdGtf
Y3J0Yy0NCj4gPnNlY19jbWRxX2hhbmRsZSwNCj4gKwkJCQkJICAgICAgUEFHRV9TSVpFKTsNCj4g
KwkJaWYgKHJldCkgew0KPiArCQkJZGV2X2RiZyhkZXYsICJtdGtfY3J0YyAlZCBmYWlsZWQgdG8g
Y3JlYXRlIGNtZHENCj4gc2VjdXJlIHBhY2tldFxuIiwNCj4gKwkJCQlkcm1fY3J0Y19pbmRleCgm
bXRrX2NydGMtPmJhc2UpKTsNCj4gKwkJCWdvdG8gY21kcV9lcnI7DQo+ICsJCX0NCj4gKw0KPiAr
CQkvKiBmb3Igc2VuZGluZyBibG9ja2luZyBjbWQgaW4gY3J0YyBkaXNhYmxlICovDQo+ICsJCWlu
aXRfd2FpdHF1ZXVlX2hlYWQoJm10a19jcnRjLT5zZWNfY2JfYmxvY2tpbmdfcXVldWUpOw0KPiAr
CX0NCj4gKw0KPiArY21kcV9lcnI6DQo+ICsJaWYgKHJldCkgew0KPiArCQlpZiAobXRrX2NydGMt
PmNtZHFfY2xpZW50LmNoYW4pIHsNCj4gKwkJCW1ib3hfZnJlZV9jaGFubmVsKG10a19jcnRjLT5j
bWRxX2NsaWVudC5jaGFuKTsNCj4gKwkJCW10a19jcnRjLT5jbWRxX2NsaWVudC5jaGFuID0gTlVM
TDsNCj4gKwkJfQ0KPiArCQlpZiAobXRrX2NydGMtPnNlY19jbWRxX2NsaWVudC5jaGFuKSB7DQo+
ICsJCQltYm94X2ZyZWVfY2hhbm5lbChtdGtfY3J0Yy0NCj4gPnNlY19jbWRxX2NsaWVudC5jaGFu
KTsNCj4gKwkJCW10a19jcnRjLT5zZWNfY21kcV9jbGllbnQuY2hhbiA9IE5VTEw7DQo+ICsJCX0N
Cj4gKwl9DQo+ICAjZW5kaWYNCj4gIA0KPiAgCWlmIChjb25uX3JvdXRlcykgew0KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fY3J0Yy5oDQo+IGIvZHJpdmVy
cy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fY3J0Yy5oDQo+IGluZGV4IDFmOTg4ZmYxYmY5Zi4u
Y2Y4NDMzODQ2MTA4IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRr
X2RybV9jcnRjLmgNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fY3J0
Yy5oDQo+IEBAIC0yMSw2ICsyMSw3IEBAIGludCBtdGtfZHJtX2NydGNfY3JlYXRlKHN0cnVjdCBk
cm1fZGV2aWNlICpkcm1fZGV2LA0KPiAgCQkJaW50IHByaXZfZGF0YV9pbmRleCwNCj4gIAkJCWNv
bnN0IHN0cnVjdCBtdGtfZHJtX3JvdXRlICpjb25uX3JvdXRlcywNCj4gIAkJCXVuc2lnbmVkIGlu
dCBudW1fY29ubl9yb3V0ZXMpOw0KPiArdm9pZCBtdGtfY3J0Y19kaXNhYmxlX3NlY3VyZV9zdGF0
ZShzdHJ1Y3QgZHJtX2NydGMgKmNydGMpOw0KPiAgaW50IG10a19kcm1fY3J0Y19wbGFuZV9jaGVj
ayhzdHJ1Y3QgZHJtX2NydGMgKmNydGMsIHN0cnVjdCBkcm1fcGxhbmUNCj4gKnBsYW5lLA0KPiAg
CQkJICAgICBzdHJ1Y3QgbXRrX3BsYW5lX3N0YXRlICpzdGF0ZSk7DQo+ICB2b2lkIG10a19kcm1f
Y3J0Y19hc3luY191cGRhdGUoc3RydWN0IGRybV9jcnRjICpjcnRjLCBzdHJ1Y3QNCj4gZHJtX3Bs
YW5lICpwbGFuZSwNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtf
ZHJtX3BsYW5lLmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9wbGFuZS5j
DQo+IGluZGV4IGQ0ZDUxNTYyN2NhNC4uOTYyOTNjNjMyZDY3IDEwMDY0NA0KPiAtLS0gYS9kcml2
ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9wbGFuZS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1
L2RybS9tZWRpYXRlay9tdGtfZHJtX3BsYW5lLmMNCj4gQEAgLTI4Nyw2ICsyODcsMTMgQEAgc3Rh
dGljIHZvaWQgbXRrX3BsYW5lX2F0b21pY19kaXNhYmxlKHN0cnVjdA0KPiBkcm1fcGxhbmUgKnBs
YW5lLA0KPiAgCW10a19wbGFuZV9zdGF0ZS0+cGVuZGluZy5lbmFibGUgPSBmYWxzZTsNCj4gIAl3
bWIoKTsgLyogTWFrZSBzdXJlIHRoZSBhYm92ZSBwYXJhbWV0ZXIgaXMgc2V0IGJlZm9yZSB1cGRh
dGUgKi8NCj4gIAltdGtfcGxhbmVfc3RhdGUtPnBlbmRpbmcuZGlydHkgPSB0cnVlOw0KPiArDQo+
ICsJaWYgKG10a19wbGFuZV9zdGF0ZS0+cGVuZGluZy5pc19zZWN1cmUpIHsNCj4gKwkJc3RydWN0
IGRybV9wbGFuZV9zdGF0ZSAqb2xkX3N0YXRlID0NCj4gZHJtX2F0b21pY19nZXRfb2xkX3BsYW5l
X3N0YXRlKHN0YXRlLCBwbGFuZSk7DQo+ICsNCj4gKwkJaWYgKG9sZF9zdGF0ZS0+Y3J0YykNCj4g
KwkJCW10a19jcnRjX2Rpc2FibGVfc2VjdXJlX3N0YXRlKG9sZF9zdGF0ZS0+Y3J0Yyk7DQo+ICsJ
fQ0KPiAgfQ0KPiAgDQo+ICBzdGF0aWMgdm9pZCBtdGtfcGxhbmVfYXRvbWljX3VwZGF0ZShzdHJ1
Y3QgZHJtX3BsYW5lICpwbGFuZSwNCg==

