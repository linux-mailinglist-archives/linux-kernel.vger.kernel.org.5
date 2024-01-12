Return-Path: <linux-kernel+bounces-24333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3C282BB27
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 07:13:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E85E5B2474F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 06:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC405C8EA;
	Fri, 12 Jan 2024 06:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="s91hg7Qj";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="AqsigEFp"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10DE2BE42;
	Fri, 12 Jan 2024 06:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: aac8efa8b11111ee9e680517dc993faa-20240112
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=QVC5XEs7Y1p3rT5ZgwS4FNz/GYcmSjuw1rFcLndEpg8=;
	b=s91hg7Qj9o5RRB7dSzsQjqnZkS0A+8ca/3D9OR3vlXaM9viKpjvNTC9guWuZH0DSDq31NtnFoatiTZYNRTpGWv0nZX7z/yEB16HdF2EhSfsMEEtPnojAgeT1Z7q62J+4+bWQRzYaPB94VOV1/UUIIM6AbTOyLTHEsdxYyG6gD/s=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:041d8455-a155-4830-9bfb-0c287dc26750,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:ea262c8e-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: aac8efa8b11111ee9e680517dc993faa-20240112
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <trevor.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 390019286; Fri, 12 Jan 2024 14:13:13 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 12 Jan 2024 14:13:12 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 12 Jan 2024 14:13:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N11LDX3o0zY4ICDK/NlgAYBsDghwnDgwBdkzuF1VZ2ktbnrs5cE10XbPF8dbk8UiNVfwXSJB5aSw8baOt0CbdDqaJzFift8BBjY3PVwqBuNGvoKo0cGWKQJx7KmofGbnj22Y+pK+gFeX3ARh6NW1at71y1mWiCzwVVMEJ1pJZkBq4RHeGUjmgTXzLdpRHw8D22rkxlk+cnq4unClbu2YpBalxFIo7Q4rRD9iHIQ1N8biFhSROz6dh689NerJCt6/xWxtF00PTV4aDiRIM33hWgMgTyGnpWfurTZNpjKAMmYBSEPuW2aDLbi3T8sAf2nVKILpt/x2ybXrLDNbobhFOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QVC5XEs7Y1p3rT5ZgwS4FNz/GYcmSjuw1rFcLndEpg8=;
 b=bjXYlKflUwxejdZjajNODVy5iwhLdPQvr/4VR3f0Yk5a0KwoR389pH+MYfaLhDiG4r366V9umav9tpBSuRygKHEg0vaW2NCqskjMGlPkVz6EZVQUOZUws35rL5ZixQmgKhzpvFqP0s+EKGfgLSWgaJk94onW3KPgHBQ52oG4gx5DrMWrmi/go1mGqr4mYxCFjxG3LScoXs2OIdsL7d7fkI51DSw1xXORSJBFr0ZfxpdF7PqhP47wYkOvYqcCVY/gMW9i1F1TpKm5DoclbOnOjoOXLwZA0m7DEkDDa6N4+L/gWozHr0P1kPtxwRzkNMC2s4dBFIuvYbM4BFK5qLntLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QVC5XEs7Y1p3rT5ZgwS4FNz/GYcmSjuw1rFcLndEpg8=;
 b=AqsigEFpTrmhayRW8mBZh8ufsiq382UZjIPAw1cbJ9qiQs+y4xu1twUQ1TyPAHVGG10WVFp8pKv0UPmPG5MlhGR6Te84KWfI1kacbF+2taKfWD3u6NvvrRkFui/bP13XKmmViRU/m8SBKyWSvHY28fGJsFFuxGpL46KzkZQ7kJU=
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com (2603:1096:4:1e9::14)
 by TYZPR03MB8804.apcprd03.prod.outlook.com (2603:1096:405:a6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Fri, 12 Jan
 2024 06:13:10 +0000
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::f107:999e:3d3:df8c]) by SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::f107:999e:3d3:df8c%4]) with mapi id 15.20.7181.019; Fri, 12 Jan 2024
 06:13:10 +0000
From: =?utf-8?B?VHJldm9yIFd1ICjlkLPmlofoia8p?= <Trevor.Wu@mediatek.com>
To: "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"ribalda@chromium.org" <ribalda@chromium.org>,
	"u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
	"linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
	"broonie@kernel.org" <broonie@kernel.org>, "tiwai@suse.com" <tiwai@suse.com>,
	"kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "perex@perex.cz" <perex@perex.cz>,
	"alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
	"nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
	"nfraprado@collabora.com" <nfraprado@collabora.com>
Subject: Re: [PATCH 7/7] ASoC: mediatek: mt8195-afe-pcm: Drop .remove_new()
 callback
Thread-Topic: [PATCH 7/7] ASoC: mediatek: mt8195-afe-pcm: Drop .remove_new()
 callback
Thread-Index: AQHaRHx93uFWbTjCi0KiaJzz86soEbDVs9qA
Date: Fri, 12 Jan 2024 06:13:10 +0000
Message-ID: <0f21493732370dcf344ca5f1e417f79e27a74f3c.camel@mediatek.com>
References: <20240111105247.117766-1-angelogioacchino.delregno@collabora.com>
	 <20240111105247.117766-8-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240111105247.117766-8-angelogioacchino.delregno@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB6686:EE_|TYZPR03MB8804:EE_
x-ms-office365-filtering-correlation-id: 3222344b-e5b1-4f01-e644-08dc13358d1a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JzTORKGFafdyU05dqQdAUp5UrIjNnm+bDwPuu958i+0boLf3NUZAcr4DT6rhXBSWHjcb1KTIME0a1wA2wkUDuXbNFHjr5Oe3lB2dYlYwMo6wJdPO5jyoaMsdHnG8bTeb2I96jVjTc4USwGiGUJqnPDfiuzF0+/COZm8ivPukEGlRC5Hzn9NLkKli4soM55zjPHUmA6wvV1AXfyoWV9w7bB2kQo2nddQDpadYyyji0LjuGu7GQVSYObvY2kwCHe1gQskl9LE3v91v9YzXoywG+u2tP5iclMqkzjuMwPpQ+F/ZCRZH8Gmbl0kh3i21iBgdW3So07fUYrTg1EfOEPhb16euUjusDw5fp/bWDKrieYFpdCd7fRR1hXeE1s82nHA1rqwDCFvOcVDw3KtirFZNsQIHA2nAC6HP4SflHgY529AEheq2V3XPqdsk6o19IKQZuw8AzkH+YJyEUN8sr3ICi/7heMkFPyOEnIu1brFeJnDjyQHWaMGC1VLv1DCJaZ+mDTFt95d5Miw83kfbM34NFGsXw/UxeSVCqj16sG+9whyHBoeXm97PObiKW7BzGwIcpucNQVMm6WjD3rjcxbcnnKQ28i+1EkTd0Geii5eYewqX5+R/LtS6qSXKFbcmTRaO9SfhJz/mIB4V67p9w6ZXWxU1SR6nkTpHiEHqtRLsq44=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB6686.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(366004)(346002)(39860400002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(8936002)(8676002)(478600001)(54906003)(6512007)(4744005)(6506007)(91956017)(110136005)(64756008)(66946007)(66476007)(76116006)(66556008)(316002)(66446008)(71200400001)(83380400001)(6486002)(7416002)(4326008)(26005)(5660300002)(36756003)(85182001)(2906002)(38100700002)(2616005)(122000001)(41300700001)(38070700009)(86362001)(99106002)(142923001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aGZRM3RFS3pYTnE4MGZTaXhoSVY0cWpKbzFKT3pIUDhrcUlGV2hVemwwVUpG?=
 =?utf-8?B?MU1LYXp0cmNHS0Z3Q1QxWWtGYWdCdytuck1aM2NsQVMxaXNUQ3hqUmltdkZF?=
 =?utf-8?B?SG1SY01nY1g1OE9icEtPN1dwQmsyL1JDRFJzRERLaFJVaVI4ZldFdFNBeVVJ?=
 =?utf-8?B?VkxraVVUdGlYdmJBUkdReW9JQ1VVbm9oSmRqVVFvMENkdERjWlVMVzZnWm44?=
 =?utf-8?B?clJkUHZpTUFoRTQ0TFRrMXdaRGFxRjgzSmx1dVdSZ2d3UWZJZm9xM25RbDJn?=
 =?utf-8?B?Ri91WSt1Q25oUXFSeHp5dnppV3EvcGlwbWQxWWhMVWk3a3ZlTjhHQlRsMkcw?=
 =?utf-8?B?TXI3NE95TDArR2FvNDNBMTJPR3p3TjBGZ1FzZXVmTXd2Smk3TEQrOHorTFF4?=
 =?utf-8?B?UFZEOVhmUzd1ck9YWW14dVFkTnR5ZWlpN2xHSGZ5eFU4OW1vS0Y3VzgxVGJC?=
 =?utf-8?B?R1dvUTc2TEVTRjdxNnVXQzYvdmxQbFA0UUZZekwwejFydWFRclAwSlpMZHhD?=
 =?utf-8?B?c05YSTJwWFpteERhclo2alFCMkNXdE1UWURVUEN6WkloMU9QK1dFYUszcElE?=
 =?utf-8?B?ZklXR0w4MzhnTnI4eGVPNUhkanBXeFIvM2hRSWJqZTdqcy95VmNuRFB2RkZT?=
 =?utf-8?B?bUdPQ09DVmFPbHdKZ0pUSkVwNURQa3dIWXpsWUhFWllVSzQzVWhHK2pHZkNp?=
 =?utf-8?B?VWdmRE9ZY1FjTE9vdDluVFJlajNSWWFCZXFaeTdOWWt3bUt4REI1R01PMmxv?=
 =?utf-8?B?bGozNVUyQjZxTEF2V295UFQzUVB5YXk1VlJCbFNkallXOWpXeEhrcFVGbHNC?=
 =?utf-8?B?TFpTUWtFd1pqK1pUZnpQYnJwZ0lMejNSVWpjZjhQTUZrNnB3c0RrWmE4a2lt?=
 =?utf-8?B?RHBUclZ4a1d0eDRPYjgwb2pTN0VHSWRZZGp4YVhmZGFVc05pazVqemNuRlJu?=
 =?utf-8?B?bWRlZ3hPNHo3djRERjlJTk8xU1RBMFBaUmxEUU9Qb1A1RWJmdU9IbDdTeXdw?=
 =?utf-8?B?cUpMQVFPOTVpQWsyOE9QUWpydmNMb1ppMFRhMERHbVF6VUkySGtJTk5OQksy?=
 =?utf-8?B?NUFUc0xvN3NoQTNybEZjeVBPSnpoS2JZeWk5MUtBU3BEKzJaVUlPa0dzaHE4?=
 =?utf-8?B?Zi9oRHQ3eDRYK3JnMzJROTlxdmFXNFdBTmFQNG5FVXFqVHNHVExJbEJjc0Uz?=
 =?utf-8?B?RjduT1ppUDA1RXlIQXNTVGhYbkJ3eXZ2MlN3L2RsT3N2REtwSVZzUEw1YTg2?=
 =?utf-8?B?VEtYQS9YanRWek9KVlE5UjRuRVNYTFdqVWpJaW94d1BWZ3Y5WU5WWEJ6S1lv?=
 =?utf-8?B?NEFSa0NiZ0p4b0FDcGw4Z2lhcmIrbWJqTUhqcnJvdEhnNDhYZCtOQy9aUGc0?=
 =?utf-8?B?ZytkOTFSck9JeXJrTjJnT0lpTC9uTjZXZHhmRkhOU05yVmh6cTNUamF3bmVC?=
 =?utf-8?B?K2pjWS90L1U2ZW4yS0FNYXZLeTNHbElyNVBzUVlDQ0hrYjBDMS8rSkJ0ODd4?=
 =?utf-8?B?WG9wY21hRmhyZGxtL2t6VTFPcjZaOVdlWVFBaDV0RVRjYjA4L2hpOFpPUU5X?=
 =?utf-8?B?TzFIUERXWDZCR0pGOVE5MW0wd0xWbmVzQ1I3RWEyNVhvRWcyYTRIVWFJTFp3?=
 =?utf-8?B?WkNKbWpyZE53dG5PbHF1b3ZuTHJiMmo0cnBFd1EyTU4zL0ZUNE1qVWw4Sjl5?=
 =?utf-8?B?bUNRbzVPVzZCcWhVaXVqNUFGUWNSRlVCT3d1UGpaZnlSaGhMeHdkWmlpSmN3?=
 =?utf-8?B?UHRJWW5TckszV0NXaWRWMmExSU9UcXFDdlB3dG04RG1CZnRQbzk1a004NGdj?=
 =?utf-8?B?STRsTWJzQzdlVzhBWHo3R01lbW5DNm9mUkNSVmVyWlM1L1RmOFEyTVBxVU4v?=
 =?utf-8?B?RmRmYzZSZUhoeldNUGh3dzhhdm5VaFdNbG5VbnZ3ZGs4S1VYVldRZUc0Qm12?=
 =?utf-8?B?NUw1K1ZreFJSY3BsYVRKcVU5cEJBNWhMWUxTd0s1S2Uwc01kTnFlNkpiWmlB?=
 =?utf-8?B?c1BYdGV1UFNXMTNyTDJvOHRicDVtdW5RUzRIVTZGLzBnVVNYbmN6NnpBRVRN?=
 =?utf-8?B?bnNrMDJ1eEg2SFNDRFhFVlhOZWZkZzBMalVjRUlDVXhWRTkrbm1IeUoyNVZq?=
 =?utf-8?B?dS82bHdlbmJlaFVSK1psVmhSdUpObm9lUlpYNGFnS3hickpvVGNNMGE2cjcy?=
 =?utf-8?B?QkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1A9307DFC2047F44B47DA1DE1B0FB947@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB6686.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3222344b-e5b1-4f01-e644-08dc13358d1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2024 06:13:10.0709
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OusB3lsgHekhLTMlq+dxzue+3+HSAKFRGtbdjQCB25fY1gdQtiTfgL/HULusnFC+KLdIuptfV/2Erg7ocuCVPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB8804
X-MTK: N

T24gVGh1LCAyMDI0LTAxLTExIGF0IDExOjUyICswMTAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gQXMgd2UncmUgY2FsbGluZyBkZXZtX3BtX3J1bnRpbWVfZW5hYmxlKCkg
aW4gdGhlIHByb2JlIGZ1bmN0aW9uIG9mDQo+IHRoaXMNCj4gZHJpdmVyIHdlIGRvbid0IG5lZWQg
dG8gZGlzYWJsZSBpdCBvbiByZW1vdmUgYXMgdGhhdCdzIGRldm0gbWFuYWdlZDoNCj4gZHJvcCB0
aGUgLnJlbW92ZV9uZXcoKSBjYWxsYmFjayBlbnRpcmVseS4NCj4gDQo+IFdoaWxlIGF0IGl0LCBh
bHNvIGFkZCB0aGUgc2VudGluZWwgY29tbWVudCB0byB0aGUgbGFzdCBvZl9kZXZpY2VfaWQNCj4g
ZW50cnkuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBBbmdlbG9HaW9hY2NoaW5vIERlbCBSZWdubyA8
DQo+IGFuZ2Vsb2dpb2FjY2hpbm8uZGVscmVnbm9AY29sbGFib3JhLmNvbT4NCj4gLS0tDQo+ICBz
b3VuZC9zb2MvbWVkaWF0ZWsvbXQ4MTk1L210ODE5NS1hZmUtcGNtLmMgfCAxMiArKy0tLS0tLS0t
LS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEwIGRlbGV0aW9ucygtKQ0K
DQpSZXZpZXdlZC1ieTogVHJldm9yIFd1IDx0cmV2b3Iud3VAbWVkaWF0ZWsuY29tPg0K

