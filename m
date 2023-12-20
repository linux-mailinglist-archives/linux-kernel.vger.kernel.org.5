Return-Path: <linux-kernel+bounces-6278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E5E8196AD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 03:05:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E27D72883EB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 02:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D59A8813;
	Wed, 20 Dec 2023 02:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="gO3Z6ZkO";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="t+qZ6oHZ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B927472;
	Wed, 20 Dec 2023 02:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 40642d869edc11eeba30773df0976c77-20231220
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=hRPeu5FhZbeIwYYBxRSK/avsOzclUblVkkI2GelQfqk=;
	b=gO3Z6ZkOoKUjEz640HLMhP4mMkDQEB/tjk9inYgCV+RiWYqHAFFMxCFYFVZ0kafpOTX35XP2OFyHgFjV8yrXLWMYahtV9600/j1UK39S9F7m6/bmNB7If+VKjvm0tnhInYFAgR+ybUyr9pL7TD3t7u4JyVs5VU2Vct50QFLZQnI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:42f7dcf3-f7a8-43b8-9055-beaaa4284fba,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:d7b2e017-1474-414b-9c9f-6d23a122e796,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
	NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 40642d869edc11eeba30773df0976c77-20231220
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
	(envelope-from <chunfeng.yun@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1801284252; Wed, 20 Dec 2023 10:05:30 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 20 Dec 2023 10:05:28 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 20 Dec 2023 10:05:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BJkO55j/InBBv3AodkziPBnU/paEob7To6ssgvgBlbkJHDIf6yn3iXiqDKuZtuRCLcdG9ZUqZTsUm0exy8gBh3R9+hhMPupVjmBrUGIviCrmZBwAk4Qfm3rG0doulGwOCPPevyq556scO70U3PJ++JuRpO916R58UT63A2YD9wG9pYvdVELUM/R8VHN3g6PGyLgA9g6pYX2wmM/syQMTQyf/D6ZxVeLj7N65lPx8d569a/UYf9HSTZMmqvJFcNolT1bMajlTyp3PfqYEcoAlcapI630dXg/WjUglvke+LQ0LCenLVR6f7Ztp1KHB40qmVMrgcFVgMyxs2DiIwq4lsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hRPeu5FhZbeIwYYBxRSK/avsOzclUblVkkI2GelQfqk=;
 b=e3GH5/m4DUJLFijSRfnKYsqiiAnikgfxilS7JfwQBh+IaRxwHKu08h7l+q5KaVc0AveAUS+rS7LXNLs5nnuqHp1TAlSXSXDaoHTyTQNjr9IwEG4NJKox5R2FotQ3Uz1V31eaXJ1PjVP2pJ2m06nMMUS1P/Vtsao4mBYjEZWgrynFXzPFkQG9JX5esOTDcZIqg/Wr9pMhCaTJpzUg5MUhhbgK7w/fkOiwJFEcli3OiC5bFYaWLw9XqgYWiW+fSLnh78Sl3U32GtDiQZ1KCdgbclTcXyQ/AGt0tI477ElARYOT7Aw6vbhK+uJCRoavvTZjiG7eJN9v7Tyy1ZROCC2ODg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hRPeu5FhZbeIwYYBxRSK/avsOzclUblVkkI2GelQfqk=;
 b=t+qZ6oHZ1+RfJw4z4YLF/uL2+gutwJVWdkpqZwx2cHPh+zr6Yy7siTkl0beHN/oH4AzS8yNDPxd0Urw7wrKmhgeTDGDWHNLy2iOnyH6RMIzoc94b9hpGPe/i30Mcd6j1gttlSAYl6hLjZKjdwEI0E5el/b1Kjmoe5yKQ5AWBSew=
Received: from TYZPR03MB7153.apcprd03.prod.outlook.com (2603:1096:400:33c::6)
 by TYZPR03MB7003.apcprd03.prod.outlook.com (2603:1096:400:26a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Wed, 20 Dec
 2023 02:05:26 +0000
Received: from TYZPR03MB7153.apcprd03.prod.outlook.com
 ([fe80::75b5:9f6d:dc01:9946]) by TYZPR03MB7153.apcprd03.prod.outlook.com
 ([fe80::75b5:9f6d:dc01:9946%6]) with mapi id 15.20.7091.034; Wed, 20 Dec 2023
 02:05:26 +0000
From: =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= <Chunfeng.Yun@mediatek.com>
To: "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
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
Subject: Re: [PATCH v2 1/3] dt-bindings: usb: mtk-xhci: add a property for
 Gen1 isoc-in transfer issue
Thread-Topic: [PATCH v2 1/3] dt-bindings: usb: mtk-xhci: add a property for
 Gen1 isoc-in transfer issue
Thread-Index: AQHaLykpK4Euf9aonkW1wfynk3w/xbCp9JaAgAd/FAA=
Date: Wed, 20 Dec 2023 02:05:25 +0000
Message-ID: <2f38caeb95fe9b2d01f158fd91ed0cedafa5d2fa.camel@mediatek.com>
References: <20231215073431.8512-1-chunfeng.yun@mediatek.com>
	 <d50abf1a-1ee7-4f84-9f53-69dfe9aad103@linaro.org>
In-Reply-To: <d50abf1a-1ee7-4f84-9f53-69dfe9aad103@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB7153:EE_|TYZPR03MB7003:EE_
x-ms-office365-filtering-correlation-id: 969b9a25-1983-4cdd-2fa3-08dc010021e6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JGLjylgdFYY/nI9lGANNf0SPWCrQzOLvyJspLIC3pL9dvJYZM9u6FcVfcxUWfD1naYzsLgBMwX0lNVt+IdQi5riF/y8HfLRYZweAZ5P+3cb3T8Ssb7c8bm0Sp5F45dpsmNoDdka2BRdjklzTUnV6wstK2wZb5/+StuogzCrMC8cbmGQ2lnEDRhlKnJfe1w/zVlf2eJyS2cZBh5eScv/PEPzIHTBmKoKqbtAYP8tAQ5wSviAKbcpgrLQVfjwnXIzZAJgLJsSXdfR06Dk7S5IMqibQvgMtCv30BnFkvqRJexlRh4VsFNki2xne5/TeABnEFQnPcnw35s6RNuZXiW4UrJr77bz4RSjnkclleOWghP0kgou1OBnOEZ9gQ4ZAK+0l/INJLApxJ1SDUaEnfsdzpGLGKZ1y6TlK0miLOIVSfCj+KSts2ILXeabgzkbMfR60nVLjMDoQHu/8xFU4f6L6Thr6xrAZdyL1r0wKss/bqQqMV4haOF1EC1a/xiKJwN6qdvwFu50yvVBKt1P2siFW6onOl0cQLwdDPYRRxlBoM6SINz+ZcLbn4D9Mm40qGjwJOiuKIzhtzXIqlV7NTGAAF1nyMAuvkdzaOl+2JsC29Oym4LKRvFaCZJJTs+MzAQy1IAZfPDUpfYQPpWIBJUB7P137ItE3cDq1YkomnK+IjX4Lwix71EgrIceo5ZyhPgHswBTVK7sYMAaJ08y98gQnySQP3B2RSP3KK9XbiiuDOuk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7153.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(136003)(346002)(376002)(230922051799003)(230273577357003)(230173577357003)(451199024)(1800799012)(186009)(64100799003)(2616005)(26005)(38070700009)(122000001)(38100700002)(86362001)(41300700001)(4001150100001)(36756003)(85182001)(2906002)(5660300002)(7416002)(83380400001)(54906003)(316002)(71200400001)(91956017)(478600001)(110136005)(66946007)(76116006)(66556008)(66476007)(64756008)(66446008)(8676002)(8936002)(6486002)(6512007)(6506007)(53546011)(4326008)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cTR5VW10aUhPMDZKam9yemdDbGdJdTNrRkZhQzlFZkowQzF3azZoYkFKSVc1?=
 =?utf-8?B?b1l4SjYyNklxM25PVGxTbW1GamVUQnZ0TGZyRU5GT2xNTmMxSi9QU3BXTFA2?=
 =?utf-8?B?aXBpU2czTHUzVS9idzZ4Nm9ZUEs4ZUN0UFNXSXdQVExlczlicU9sMkF0NTBZ?=
 =?utf-8?B?RjhwejlBVHlCNHlTNnRTYmdOVWVibW9mTXV0ZjJpcGtDRHQrYzlPTndFYU5R?=
 =?utf-8?B?Znl2Z0dYWEJSbnJkL2ZmRUhTbGdZYUlndTFrOExDTWg3dzYxNlpWaGRJMmN0?=
 =?utf-8?B?Yi8vTW5iZ1BzSmZVc0FiVUszMWFPa0ttRFRWcm9lQVhHSHhyaGwzT3ZmczRm?=
 =?utf-8?B?enBXcEFrYlZKVFcwQTcyK1Y4dXdBc0o1MmZmQi9pc20xMVpaWmxSSEJvVG1Y?=
 =?utf-8?B?OGFQT0hPSFBLaGk4OCtqdHFLU0pTcm9HQ3JmVTlxQ000ZEdseVM1ZlNDWG9w?=
 =?utf-8?B?Skh6ZStkWlJyd201OW9sQkY4cm9lZEJkUUNkTVdIUjZDMkxuRW5za2FDYWhI?=
 =?utf-8?B?ZjIwZzRFSWhRWlJ6RWhqSkdFVTRpZGdYdkhyTnRZeFdWSldYZHVYaXRKOEhQ?=
 =?utf-8?B?WDBYNWZ3aHpjK05xS2dwUkRJUW81andpMWl2bzM0Qk5lS29ENEdURml5Ly9p?=
 =?utf-8?B?NmhTUUYzajVHcjRldlhPNnBOUkc2STRTSk9Tbm1UeDFIcTBzWWlXUElMZ3dP?=
 =?utf-8?B?SDU2eWd4cGRuWmlUV2lwRzJ3VHByNGtsRzVUM1ExZmpEcEhHS0JEMmdTRlpm?=
 =?utf-8?B?SitqSG1NZDFJUUVRcGIvRDRucUh2MDZzeVVXYUNTaXliRjh3dlBkYVByM3NF?=
 =?utf-8?B?UzNwa1dHZzBXemo1bnFkS2N3cGlubGtCS2NoZVNIUGp5L1cvTmlyY1R5eEt2?=
 =?utf-8?B?TDlwYlQ2OXMzNzY0UTY2aUhHcFVmQ1NmeWovbDFNZmlOWkJWNTB5RHpWdjYw?=
 =?utf-8?B?UEFGYm1ZbVhFR3h5MXV0cGJTSzl2ajZ5UVNQN2swZ29wckN2UHNjN3dvbzRx?=
 =?utf-8?B?OWpSSVVUb29RT21Rai9pbFJPTW9Zc0lmTzdhSzNPREdkZzFHc0pONFJxdWRk?=
 =?utf-8?B?VGRKd0hOekEzd29KbDJmNXBkY2F3eW9OMWlMSGpBMGlHdHZSWmdKYXZCY3Vx?=
 =?utf-8?B?SWYwRDN0dG1FMGd1azBvQkFob3JVdXFLUXErWDgwTE04SUhWZE9RekwranlR?=
 =?utf-8?B?RlVMcEtzV0tJaVVPQ2pWTEdXNzRCL3lBYjgwdmorZkRkd2tSakl1RjdDeUZz?=
 =?utf-8?B?SDNRbEgyb0RuTGJwaHROaFBHV0x3bXI4dEZPdzdQSGxhSUp5YUw0d2dSNDNP?=
 =?utf-8?B?dXgvMWY0bkpPdHJvMFlNSXJDK0ZpTlA2Y1ZQSVdJZEE3dUtzaFRNQlE3TVl4?=
 =?utf-8?B?VUFtZ2NVc0Qyc0JITjVBa3FJbGZIQytIUTczR0xPKzJOMWwrZXQzeU8rV0hH?=
 =?utf-8?B?cC9icXVCdnkvWlVpdm5acUFTL3RzZlhWWktKQ2oxb1hObXVNeFlnRXo5cVF3?=
 =?utf-8?B?UFU1Sy9VMDlibWJUUzdhazZTbm1sSTBQeTBWd2NtQTAwQlQvbTM5MGVwOFlr?=
 =?utf-8?B?dnQ3YXZ1UGRqaVpRTUVYTEl0eHFCRjB1MGhodHA5QzVjb2dpeWl2cE5mL1hr?=
 =?utf-8?B?NzJHc3drZ0FnYWR4Z3drSFczdm5HQjRiSkEwN3kzeWJ0eXFRMC9BbTd4b3ZD?=
 =?utf-8?B?bkIzelhBTkVUMnFyQXF6dFRUa2gxZ3djZi9ZUjQzNzk5dXBiNmIrRmpqeVBx?=
 =?utf-8?B?L1Myc1N1Tmh6YlVCRnUzUkJWOTd4R3RWeUR1ZVlaamRlQkxIM2JPN0RYOCtE?=
 =?utf-8?B?QzFjeW9DZytvcld5TThlV1FsbXJBUksxZmUrN1kzdE1CTnhjUVlGNTVXZG5Z?=
 =?utf-8?B?V053M0ZsL05oVEt0dnoxa0dLQXlBRWU0UVJjcGxsNGJlbk1RUUhkQ1NIZDRV?=
 =?utf-8?B?eGJqOWVjajJMMHpUa2RPaWl2L0NwUWdCbm82Z3JMM05nemdhOThocGdabjNa?=
 =?utf-8?B?blRNRUo1NXRUNGdKZjl1dlIwUS9LYmhIdDRzcXlVSE9DZ0FHYVJTcDR3UFFD?=
 =?utf-8?B?dnc4YVNZQVRDaGJ0T0p6Z0xqcHEyNnB6S1JhbDd2QkFFcnRJRHpNWTg5c1h5?=
 =?utf-8?B?aElpai9VdlBMYnk2WkI1VjFCWkIvYkxxeVNyWXR1TjV0V1ViUFUxcThsU2tZ?=
 =?utf-8?B?cFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2F0551E68DE32E47B5007608597DCDB6@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7153.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 969b9a25-1983-4cdd-2fa3-08dc010021e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2023 02:05:26.0026
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UiNLiiXRtGlXZvzI8Rxl0Kbtfs32+/UHdPSky8GxS/x061dCuO5IXE3urk5Vo5kWWhzN8EUXR8FgMgArY+o/+S/5zxM3zQT8H4yySqSw+Hk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7003
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--24.588000-8.000000
X-TMASE-MatchedRID: dc8Jy61QoRrUL3YCMmnG4ia1MaKuob8PCJpCCsn6HCHBnyal/eRn3gzR
	CsGHURLuwpcJm2NYlPAF6GY0Fb6yCs4D9nSCoJCSmlaAItiONP0mOHJ0aBcO1LVhTD1Udgq8Q4m
	03/V++Q7aFEofExIUPLYkV2Ealq/rHzoyklNKQhFbuDP8ZuCmXgXXmzqmsIi76h3Xfd5VY/hWFs
	MQfbcNE131CKM8iApFkII+BsKkYBDLIr1irshncrMsPmSZxbpkWwKGivsEuI2/7bplhbPCQmZ8j
	nf7oly6h+/RZ/qlKOfkMRMQ02DCHwzyMxeMEX6w0gVVXNgaM0pZDL1gLmoa/PoA9r2LThYYKrau
	Xd3MZDUD/dHyT/Xh7Q==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--24.588000-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	BC1640BF32BFAA19A284B87D56915675B7AC3DC167C8E19C2D5A7CBA3D4A9FFA2000:8
X-MTK: N

T24gRnJpLCAyMDIzLTEyLTE1IGF0IDA4OjM2ICswMTAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiAgCSANCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRl
ciBvciB0aGUgY29udGVudC4NCj4gIE9uIDE1LzEyLzIwMjMgMDg6MzQsIENodW5mZW5nIFl1biB3
cm90ZToNCj4gPiBGb3IgR2VuMSBpc29jLWluIGVuZHBvaW50IG9uIGNvbnRyb2xsZXIgYmVmb3Jl
IGFib3V0IFNTVVNCIElQTQ0KPiB2MS42LjAsIGl0DQo+ID4gc3RpbGwgc2VuZCBvdXQgdW5leHBl
Y3RlZCBBQ0sgYWZ0ZXIgcmVjZWl2aW5nIGEgc2hvcnQgcGFja2V0IGluDQo+IGJ1cnN0DQo+ID4g
dHJhbnNmZXIsIHRoaXMgd2lsbCBjYXVzZSBhbiBleGNlcHRpb24gb24gY29ubmVjdGVkIGRldmlj
ZSwNCj4gc3BlY2lhbGx5IGZvcg0KPiA+IGEgNGsgY2FtZXJhLg0KPiA+IEFkZCBhIHF1aXJrIHBy
b3BlcnR5ICJyeC1maWZvLWRlcHRoIiB0byB3b3JrIGFyb3VuZCB0aGlzIGhhcmR3YXJlDQo+IGlz
c3VlLA0KPiA+IHByZWZlciB0byB1c2UgMjsNCj4gPiBUaGUgc2lkZS1lZmZlY3QgaXMgdGhhdCBt
YXkgY2F1c2UgcGVyZm9ybWFuY2UgZHJvcCBhYm91dCAxMCUsDQo+IGluY2x1ZGluZw0KPiA+IGJ1
bGsgdHJhbnNmZXIuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogQ2h1bmZlbmcgWXVuIDxjaHVu
ZmVuZy55dW5AbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+IHYyOiBjaGFuZ2UgJ21lZGlhdGVr
LHJ4Zmlmby1kZXB0aCcgdG8gJ3J4LWZpZm8tZGVwdGgnDQo+ID4gLS0tDQo+ID4gIC4uLi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL3VzYi9tZWRpYXRlayxtdGsteGhjaS55YW1sICAgfCAxMg0KPiArKysr
KysrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKykNCj4gPiANCj4g
PiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3VzYi9tZWRp
YXRlayxtdGstDQo+IHhoY2kueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy91c2IvbWVkaWF0ZWssbXRrLQ0KPiB4aGNpLnlhbWwNCj4gPiBpbmRleCBlOTY0NGUzMzNkNzgu
LmU0NGE3MWFjYjVjMCAxMDA2NDQNCj4gPiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvdXNiL21lZGlhdGVrLG10ay14aGNpLnlhbWwNCj4gPiArKysgYi9Eb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdXNiL21lZGlhdGVrLG10ay14aGNpLnlhbWwNCj4gPiBA
QCAtMTI0LDYgKzEyNCwxOCBAQCBwcm9wZXJ0aWVzOg0KPiA+ICAgICAgICBkZWZpbmVkIGluIHRo
ZSB4SENJIHNwZWMgb24gTVRLJ3MgY29udHJvbGxlci4NCj4gPiAgICAgIGRlZmF1bHQ6IDUwMDAN
Cj4gPiAgDQo+ID4gKyAgcngtZmlmby1kZXB0aDoNCj4gPiArICAgICRyZWY6IC9zY2hlbWFzL3R5
cGVzLnlhbWwjL2RlZmluaXRpb25zL3VpbnQzMg0KPiA+ICsgICAgZGVzY3JpcHRpb246DQo+ID4g
KyAgICAgIEl0IGlzIGEgcXVpcmsgdXNlZCB0byB3b3JrIGFyb3VuZCBHZW4xIGlzb2MtaW4gZW5k
cG9pbnQNCj4gdHJhbnNmZXIgaXNzdWUNCj4gPiArICAgICAgdGhhdCBzdGlsbCBzZW5kIG91dCB1
bmV4cGVjdGVkIEFDSyBhZnRlciBkZXZpY2UgZmluaXNoIHRoZQ0KPiBidXJzdCB0cmFuc2Zlcg0K
PiA+ICsgICAgICB3aXRoIGEgc2hvcnQgcGFja2V0IGFuZCBjYXVzZSBhbiBleGNlcHRpb24sIHNw
ZWNpYWxseSBvbiBhDQo+IDRLIGNhbWVyYQ0KPiA+ICsgICAgICBkZXZpY2UsIGl0IGhhcHBlbnMg
b24gY29udHJvbGxlciBiZWZvcmUgYWJvdXQgSVBNIHYxLjYuMDsNCj4gdGhlIHNpZGUtZWZmZWN0
DQo+ID4gKyAgICAgIGlzIHRoYXQgbWF5IGNhdXNlIHBlcmZvcm1hbmNlIGRyb3AgYWJvdXQgMTAl
LCBpbmNsdWRlIGJ1bGsNCj4gdHJhbnNmZXIsDQo+ID4gKyAgICAgIHByZWZlciB0byB1c2UgMiBo
ZXJlLg0KPiANCj4gV2hhdCBpcyB0aGUgbWVhbmluZyBvZiAwLTM/IGJ5dGVzPyB3b3Jkcz8NCjAg
LSAxSyBieXRlczsNCjMgLSA0SyBieXRlczsNCkkgd2lsbCBhZGQgdGhpcyBpbiBkZXNjcmlwdGlv
bg0KDQo+IA0KPiA+ICsgICAgbWluaW11bTogMA0KPiA+ICsgICAgbWF4aW11bTogMw0KPiANCj4g
DQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQo+IA0KPiANCg==

