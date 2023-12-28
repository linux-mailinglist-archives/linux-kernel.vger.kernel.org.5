Return-Path: <linux-kernel+bounces-12428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8576181F4BB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 06:32:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D5CE282D2E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 05:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A556F256A;
	Thu, 28 Dec 2023 05:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="CRaOlAel";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="ARfuKcLg"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D491FB9;
	Thu, 28 Dec 2023 05:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 6145700ca54211ee9e680517dc993faa-20231228
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=GDk5oXX+13n7+c8AjnaLVD4lN9AG8J5886Z2Kv5Lw80=;
	b=CRaOlAeldA8mm6VXy/E2YvV7+JRrTHpY/zc1CF14bacEtsRuD+ktY0ii2L+CoJfwClcV2FQWvWGJTg/GKwo2KOahgZNomNetieOQrjQUqGqsvmXcBtq8O/T0mwpYyBhqD9kGNq/vJZqoOyulJrPk3K+d8q2vPsbA5r4dp6hGlq0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:82eb6248-eda4-475d-bafb-0c0a5f50cf17,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:47364082-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 6145700ca54211ee9e680517dc993faa-20231228
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1164309322; Thu, 28 Dec 2023 13:31:41 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 28 Dec 2023 13:31:40 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 28 Dec 2023 13:31:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P7ts4ocDT4yzhMZqWSbZx80ADKe8PYxgZyHYhbwVdONDLNFsrFxaHoG86ZduJ35Y/UpnrlTTljGEemiQWlZCOV1mke9MvBKMsAAdz1T5ENnnpJRVHeCOAVfZ+YdCn/sygULRlxE1jlSqAXjIrQYCRaLLmvtZaRkDNn26wRGQ4V5F+4DYiTdsj7XHOnX5PTwlXBgQfF42w6Nvf0IOb+eqfnPeSLHU87m4YVXGxDKoC6GjAdz1g/66t4QzEfi+iJlRbsVrYpNTGoWUzXGtVoj0v/Ryu9C+OZ8Ghi4AXpbwmYDrX1U5Do0esLbDKQnLjcLLp3SGkGW6ffnvLRQWhGNvVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GDk5oXX+13n7+c8AjnaLVD4lN9AG8J5886Z2Kv5Lw80=;
 b=Y6FDpURh3aLYJWOeZ/fyZVeqlrjnyc0zvZguXcSihwLOr2PV9Qzqt28kIVSGwpegcxpdRaZZa6bmjvixmlBXsEvjNXIEdSbX1t0dwN9yzjoLGsY9ZeZMQ8ZF3TDxy1QRzgT1ghJQo1X4rlxBw8zAOck3BjZJOL2Ju6YWZ/8nFrQnQUf5Fc8K/Xmkq6HPvfR3VTek10qW/VF9LOQNSrvaJ4Ky3oeKEdQLxmB0ALJdxL++b+im+xKQDSGdAe5G+R1enEXTY9IVSamwewavKrGyOepyGTY++zv1/pISxX/QhKrZ+zXgKgzpAKQJyzxIGUKgI4RSPnn4cXN5TNkAYMetpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GDk5oXX+13n7+c8AjnaLVD4lN9AG8J5886Z2Kv5Lw80=;
 b=ARfuKcLgvfhThCwdFkGXDSoXWYDMJsXoUIsQQ77MRC07neArKNQle5zNm0lXIvdfgFasld6/6MJ/hFkqQ8DTw+FIoXVLSaisMD5DTedNQTemQFZ6/5v02b0n0rw+2/YRxjfKw6XzQfNffxS3DG2O23rB8iqZKwLZ/B5Kv0gnuSc=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SEZPR03MB7840.apcprd03.prod.outlook.com (2603:1096:101:18a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.20; Thu, 28 Dec
 2023 05:31:37 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::eb43:57cb:edfd:3762]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::eb43:57cb:edfd:3762%7]) with mapi id 15.20.7113.027; Thu, 28 Dec 2023
 05:31:37 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	=?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>,
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
Subject: Re: [PATCH v3 8/9] mailbox: mediatek: Add CMDQ secure mailbox driver
Thread-Topic: [PATCH v3 8/9] mailbox: mediatek: Add CMDQ secure mailbox driver
Thread-Index: AQHaNJMHlgU6p3MSPUCi0pus2NsH47C+NRkA
Date: Thu, 28 Dec 2023 05:31:37 +0000
Message-ID: <0124eca6dfcd45af4c454ab1937590ca89a2a787.camel@mediatek.com>
References: <20231222045228.27826-1-jason-jh.lin@mediatek.com>
	 <20231222045228.27826-9-jason-jh.lin@mediatek.com>
In-Reply-To: <20231222045228.27826-9-jason-jh.lin@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SEZPR03MB7840:EE_
x-ms-office365-filtering-correlation-id: f6beda83-8961-4864-a5f8-08dc076642f9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 453DwFXXKtrfDzF98XVOEKFY/Z/WafIAtMBPT2QJaq1N0V27kP/o1JX+UnQ41Svx1tiQ3pKylMnOvwEPB3yBmTsKJ+lSF+K6mkdg9vtLa3GCA/lOlFJklqxumbRx2ewL+c2QybDaAIcPOioKNvI91uimfZ8agpLLyUBab4GCOOK7NdC7pQ8JtdVyYRq6Ktn8TNKM8X2iKyETA5qQuh+OPmgH0ihAdUsKv64sOJywt83H0o3eOZPTqr50pgD/q0z/UmyCUcOVQh8rgCp5pDcET1CIxbuZt3WfOvKXSj1IoMKgsiC7Fj3UOD9K3stR7VSj17z/25tnd3sSVH2pI0Cuhvfi+ub77KxIyPVWOeIjO7VbVT50NSvN27MZeNq3tJ2jRlCpS2tL/Sua9kyA4KS1UHNxQs83PT/9eKmKqDhMEHyinQfEoJNDT7Jm25+gJA1PbpuLdsc48BuAgkMKSnivXUqbw4KIoJBwU6phPzCBfZvRO2o3GM8OD+W1z/oggNbLeFaINfQY9lEO4nxW03cWTO0p7ymVsqNByvQBK6E9d9FriHkq3HiZMRQ8tQgd/OCfmVN0shElKsjCo1RWinFCpCRLJ7qsc0c5l1D/x9cfuiZvc6zPxun8Cgn26Alk8Ds9PGN5PD1AFEduT8a56MZaRQKIPWoMeHr9VZ+ELXx0vMo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(39860400002)(366004)(136003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(6486002)(71200400001)(478600001)(38070700009)(6506007)(41300700001)(2616005)(6512007)(36756003)(86362001)(85182001)(122000001)(38100700002)(83380400001)(26005)(15650500001)(4326008)(7416002)(5660300002)(4001150100001)(2906002)(8676002)(66946007)(8936002)(66476007)(76116006)(316002)(54906003)(64756008)(110136005)(66446008)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QWF1WnczWXZPaUFSYW9kMXRDMzVoTHpGKzhWZHpYRlozSEZNSWNsYUZNS1V4?=
 =?utf-8?B?cFJuVjdkMzZ4VUdjWFZlcFltdEJNc1RRcTJwaUZlL3VlRzI5R1hOZXJidjFo?=
 =?utf-8?B?Q216R2dqcnZ5MWlvSlJsR1BGNjhIYmVZaGtJNkFoRzRNM25IMmRJb0ovODFq?=
 =?utf-8?B?ZkRiRGlwNmp4cnZCeXBPS0IrVDZXYW9FVXMrd2theVg1NERYQ3dVSTY3MXk1?=
 =?utf-8?B?Z3NqZFltWFJCR2Evcm5PbmdnNi84NEJHdE5jR1lrdlVYdkcyczN1bUxvYzlm?=
 =?utf-8?B?Qk91K09sZWY0NHF3WmVSYlllMFhQcTdTNGtVWE9BUzlXRUhUbUgxVFYrdzh4?=
 =?utf-8?B?SzgzM2RUcGlIVThPQVcyMklsQjZXR2xtMjhJZkZYYXdINzdoeGN2eWwrR1Ux?=
 =?utf-8?B?eDJiOWtOMFlVK2tzcC9PbXhhY0VjMnFyUWZvSlpxZE5VYnFoRTh4NG5ZOElU?=
 =?utf-8?B?ZHR2eU9hVXpQcGZvUXJHUkh3OWh1MTAvdEhtaHhQemtFVWJoS1p5TVFQV3lk?=
 =?utf-8?B?UVpIN0NqckdHY3FmTzl4SzZIVEh1Q1ZvYUsrZnRJL1hwd2ZPOEJWSzVlZzNF?=
 =?utf-8?B?N1VQR1cvYmwvMlV1YWxtN2RQQUo5cmp2ZlhoMS9odWJyQXdSMEI1T29FK2M0?=
 =?utf-8?B?N2tvUEVyRDgycnRnS1lIR292bitCSFJWT3NjbGVsOXJCaVNrMzJhVklONndh?=
 =?utf-8?B?YlNKWlNJTXlJZHZzcXlxb3krSmR5RGxqNnpTd3pQMSt1MGdmRjJ6UTdUUEVP?=
 =?utf-8?B?Z2NWRnMzMnUycDFYdlBTeXYvNW1PM0ovV2cwaW1CSjM0YlI2bmEzMCtFVk9K?=
 =?utf-8?B?cVROd0lOOTZrQjhEK0pENUZxc0lDbFY2eDVFdmxsYlVvNE1YSDlLb2xpbnpq?=
 =?utf-8?B?eGttNU5XYkpNK1hqZ1N6ZEFQT21jTkhSb1djcm9WT3ZkdHlyS3BsTldINTJr?=
 =?utf-8?B?dWU2WDYveHp4dzUwSGN2ZGFPSUpwWEU5Ty80NEdqY0xyc3cyajl1QitPOTk3?=
 =?utf-8?B?OVVwUGRqbitKSHJ4dXpPV3V6bkFwNkN5bnFmWm91UlFZaTFtMHZyK1JjYng0?=
 =?utf-8?B?KzRuWWU0bERrRlRVdHlDTTNiUUVQbk5BbnlqMTEyRTlRK2EraHkwYnRWN0hn?=
 =?utf-8?B?Wm9vUi9YWE8zZnZWV24yQlRhY3BVZzFLbnRSSUxQWTdvaVVPa0FiT2JWVEJh?=
 =?utf-8?B?WUJPZ0dEbDNsa2c4c2VuL1VjV3FSZU05Q2RkcjN2UGVUT01tK0RtQmp6MkhH?=
 =?utf-8?B?dWlTY2M3bDRaM2g1c01MblhqZlFZTzNtbnczbWxDQ1RhckN3d0xIRldkVG9u?=
 =?utf-8?B?Vk9CWDFYdGt0ckdKRHhqVkRJZi83M21WQ2Q3S2hTZUdCdnFOVzdSNzFKaFZp?=
 =?utf-8?B?RGYvUWRFOWFQV00wOEcyMnZ6SW83MlZHYTlIQVRNTWFvNlpqTEw2ZjkzRkhY?=
 =?utf-8?B?a3JTZWEzWHhSWGRQRWFoNVhRNHhLejYvVTZhbkNJOUsxOEEvZUQ3WkdEMnZF?=
 =?utf-8?B?eEY2VERCZnBqNGFsMERWK1k0NHptRER0dERGaVFqR3RUZGMvRTk2d3VCcnJT?=
 =?utf-8?B?ak1UemVCRFZjZTVGU3FBaFNtWmx6QkU2TTVnRHVCeWFZZlBhdm1ySXY4OHo5?=
 =?utf-8?B?SEF5OW5DNTluWEZQNmNodjB4ZVB5b3kzcTFwa1JhZStUbU1yRkVNakNhQ0o5?=
 =?utf-8?B?OUVGd0ZpOWx0a2IvM25JRTRrSFhKeWFONVlDbEs3VHlXS05VU2thUUh4MENt?=
 =?utf-8?B?NFZkaVRiK2RWcVNkMnRwbGZrK1RVMGNDL09aOFVmMWxVbHE4NktXdGplSEVi?=
 =?utf-8?B?SnZtenhBWGFrQWVKbnRsenh3ZWJxWVRmc1dmV1JoZFRVUTQ2cTNUUGlRVjE0?=
 =?utf-8?B?Y1FzbVFwdDZyczFWTlh0MnNxNUk4ZzlnNmx1K0hWQTJDRGs3R3FUcFNaWnl2?=
 =?utf-8?B?NlVPZGIwR0JFZGlDMFQvaFZGWHFWeFVlOS9ERVBDYk1vSlFoN2V5Z0FERHBt?=
 =?utf-8?B?WUo2OUthZVowdktrWGpXVFNYVHpoYlNYK3JwVVdSZjVYUEV6SmQvR1E4MlVM?=
 =?utf-8?B?d3JoSVlHNC9XZVJvdEdDZGZJdTVjb29WRExtTTdzUnlieTFQMnhYWXlYQUl1?=
 =?utf-8?Q?kdTcIeIQvJxMFzQskZwe7BqcD?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9E0E9F6A8454F245BC595DF93F3B7CCE@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6beda83-8961-4864-a5f8-08dc076642f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Dec 2023 05:31:37.1251
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rhUcjjw0gnT2Afzi9i+lyiUJfrq6Dj5yELzwiCx1TGXx8G2NWwyZjNdgNE4cLh75Y9loTE1WFcaIREOGhjn2bQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7840

SGksIEphc29uOg0KDQpPbiBGcmksIDIwMjMtMTItMjIgYXQgMTI6NTIgKzA4MDAsIEphc29uLUpI
LkxpbiB3cm90ZToNCj4gVG8gc3VwcG9ydCBzZWN1cmUgdmlkZW8gcGF0aCBmZWF0dXJlLCBHQ0Ug
aGF2ZSB0byByZWFkL3dyaXRlDQo+IHJlZ2lzdGdlcnMNCj4gaW4gdGhlIHNlY3VyZSB3b3JsZC4g
R0NFIHdpbGwgZW5hYmxlIHRoZSBzZWN1cmUgYWNjZXNzIHBlcm1pc3Npb24gdG8NCj4gdGhlDQo+
IEhXIHdobyB3YW50cyB0byBhY2Nlc3MgdGhlIHNlY3VyZSBjb250ZW50IGJ1ZmZlci4NCj4gDQo+
IEFkZCBDTURRIHNlY3VyZSBtYWlsYm94IGRyaXZlciB0byBtYWtlIENNRFEgY2xpZW50IHVzZXIg
aXMgYWJsZSB0bw0KPiBzZW5kaW5nIHRoZWlyIEhXIHNldHRpbmdzIHRvIHRoZSBzZWN1cmUgd29y
bGQuIFNvIHRoYXQgR0NFIGNhbg0KPiBleGVjdXRlDQo+IGFsbCBpbnN0cnVjdGlvbnMgdG8gY29u
ZmlndXJlIEhXIGluIHRoZSBzZWN1cmUgd29ybGQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBKYXNv
bi1KSC5MaW4gPGphc29uLWpoLmxpbkBtZWRpYXRlay5jb20+DQo+IC0tLQ0KDQpbc25pcF0NCg0K
PiArDQo+ICtzdGF0aWMgc3RydWN0IG1ib3hfY2hhbiAqY21kcV9zZWNfbWJveF9vZl94bGF0ZShz
dHJ1Y3QNCj4gbWJveF9jb250cm9sbGVyICptYm94LA0KPiArCQkJCQkJY29uc3Qgc3RydWN0DQo+
IG9mX3BoYW5kbGVfYXJncyAqc3ApDQo+ICt7DQo+ICsJc3RydWN0IGNtZHFfdGhyZWFkICp0aHJl
YWQ7DQo+ICsJc3RydWN0IGNtZHFfc2VjX3RocmVhZCAqc2VjX3RocmVhZDsNCj4gKwlpbnQgaWR4
ID0gc3AtPmFyZ3NbMF07DQo+ICsNCj4gKwlpZiAobWJveC0+bnVtX2NoYW5zIDw9IGlkeCkgew0K
PiArCQlwcl9lcnIoImludmFsaWQgdGhyZC1pZHg6JXUiLCBpZHgpOw0KPiArCQlyZXR1cm4gRVJS
X1BUUigtRUlOVkFMKTsNCj4gKwl9DQo+ICsNCj4gKwl0aHJlYWQgPSAoc3RydWN0IGNtZHFfdGhy
ZWFkICopbWJveC0+Y2hhbnNbaWR4XS5jb25fcHJpdjsNCj4gKwl0aHJlYWQtPmNoYW4gPSAmbWJv
eC0+Y2hhbnNbaWR4XTsNCj4gKwl0aHJlYWQtPnByaW9yaXR5ID0gc3AtPmFyZ3NbMV07DQo+ICsJ
c2VjX3RocmVhZCA9IGNvbnRhaW5lcl9vZih0aHJlYWQsIHN0cnVjdCBjbWRxX3NlY190aHJlYWQs
DQo+IHRocmVhZCk7DQo+ICsJc2VjX3RocmVhZC0+dGltZW91dF9tcyA9IENNRFFfTk9fVElNRU9V
VDsNCg0KVGhlIHRpbWVvdXRfbXMgY291bGQgb25seSBiZSBDTURRX05PX1RJTUVPVVQsIHNvIHRo
aXMgZHJpdmVyIGp1c3QgaGFzDQpubyB0aW1lb3V0LiBTbyBkcm9wIHRpbWVvdXRfbXMuDQoNClJl
Z2FyZHMsDQpDSw0KDQo+ICsNCj4gKwlyZXR1cm4gJm1ib3gtPmNoYW5zW2lkeF07DQo+ICt9DQo+
IA0K

