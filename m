Return-Path: <linux-kernel+bounces-15222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B2BF8228A1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 07:54:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E5F71C22F5C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 06:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C5218042;
	Wed,  3 Jan 2024 06:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="kN0wQLjD";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="RzUR72k8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF42218035;
	Wed,  3 Jan 2024 06:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: d12247eeaa0411eea2298b7352fd921d-20240103
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=fkq9TWdAoIXsXJ0Ziv8doEZteQoEShT2hwrHwKdmueo=;
	b=kN0wQLjDh+nAL8ANp76LMqa2Qt8wff3JcvWDMgRGrvtw9xtOvOyopV0pcbcudnSf2wHGsX2u92rHBkILCwlJ9ZfZLdeu/6Cev9Txogq8jCozMtdj8BeWiEMF6DWUjdvQzhwCtJHgSXawPKEO7b0buxp4knv2nu0DYaLvGXFbZ3E=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:0afa1719-1545-4fce-b72c-e657d15a279e,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:6755d68d-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: d12247eeaa0411eea2298b7352fd921d-20240103
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1498339442; Wed, 03 Jan 2024 14:53:36 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 3 Jan 2024 14:53:34 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 3 Jan 2024 14:53:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aWvGbtI/tZ+f4JARVKG4BRcjTpOq/wTjdkH8x2/2VfNXSVP1jLYl7k6pflYLHvj0VJmQTDgw9n3rHQER1f4SWPX6DfVqKhvvwI3eFOdi/+AUpKacSUyUnCy+mdVLkRFbBuJ4smo9VY0GG+Glz+RKs0X4oBLZVwwmUR7VnpQXROYwQ5SA3B0HiW3Y0v55CnsoSJakBLHkTsaU5guiLlXqBQt1Uy34aQUg/EUORxd5sGUTwbw24LKYhwqqH0jjyi6GaViwzALGQQdXyZvtrRFlPr2oEJoepi4GPfCQJNwIZY3bFKKRM1Av0umMZzEr5o/XK7VUQWDy2V9MlpqH4MKbsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fkq9TWdAoIXsXJ0Ziv8doEZteQoEShT2hwrHwKdmueo=;
 b=Pn0lJ30duk8/mwRhv9ZJuUIYbbHn4DLeheHrPp84Qd+V6M0fpKTqgEhhiniCsAEUypvNTKYqhyrnWwg56MIItAksaPo7SEL2g9okPfIgJoSJ9Vn6lQIzkAJP8TeJnFoyXGuTatxr1Rv4Bm44VEn2R9YyQGAxjYZCYwcQW3Mkp3IyoiTbXyCdpN3Yacu5bQAXqJGwyWcSuPrI1KERXj/3x6H5vXJ0dbNLCbtSgzo8/sdb0dwsaalXcb0MRXoZTxgeFF6k3PDTiCvjG3jeA7qMH7fhABux6of4+40yHrQKyobGqCbCPcTz3xFBD6xXH7gESjtckRykjU6w8XK6kf+sLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fkq9TWdAoIXsXJ0Ziv8doEZteQoEShT2hwrHwKdmueo=;
 b=RzUR72k8rzIPkxFKodta0VFS426LoQ0JTAmojFKBE5Suu+SulvZmf60ob+xIVVUb1Ni0+SQXWNE05gpschI2PYnHjQjvbqnHarzC30O37K09DXJxykKDu9aSa1zAhUNCrB/xu6b4WTid2hpYKkLYBB3NYw2UwG/cE6OfC+BNtxA=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by PSAPR03MB5605.apcprd03.prod.outlook.com (2603:1096:301:66::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Wed, 3 Jan
 2024 06:53:32 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::d006:ec9c:ff42:ff60]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::d006:ec9c:ff42:ff60%4]) with mapi id 15.20.7159.013; Wed, 3 Jan 2024
 06:53:32 +0000
From: =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>
To: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
	"jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
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
Thread-Index: AQHaNJLdXM09BYKw50qe8M+Tbg/FILC7SlCAgAF4JgCAATFxgIAJxhOA
Date: Wed, 3 Jan 2024 06:53:32 +0000
Message-ID: <bc36dae538ccbf9b6e3532e768e859f8e9545f85.camel@mediatek.com>
References: <20231222045228.27826-1-jason-jh.lin@mediatek.com>
	 <20231222045228.27826-9-jason-jh.lin@mediatek.com>
	 <f338215fb8f7ff1e0ebeb0f1e21a8b4dec5f0c61.camel@mediatek.com>
	 <83db5f669a6404ba3bf65ecd7b024af2509c19dc.camel@mediatek.com>
	 <f3a8c0cbdcf5da0381eaee5e0595319cd1970dde.camel@mediatek.com>
In-Reply-To: <f3a8c0cbdcf5da0381eaee5e0595319cd1970dde.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|PSAPR03MB5605:EE_
x-ms-office365-filtering-correlation-id: db7971ea-1525-4c28-d920-08dc0c28b368
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EHmBV4aNDFSV7UYCX0XUa3Vger4kZSSDFUW4m97Vx5G1oW+6a21sm6Q2C5bymhNqbBHAnxRI5YIx7CYZBdh5XB/P09c0F6G+V7wBvNy72RVK5XWB0iE5uRylXd+RUf4SNWjNOLdwV4idFxMez1CnatOJY7/EPzvoKdFXyxZGCmPCoz+gONH/DcbQZ/8ZMnXEb7QSI25mlYz+sOkOHJGVerbNMMrMQxYMgg3S9DgaDlO2+DqK4lcdF2H2Ms/NpexfnkftcewSHhN712BAi/DAUnwmFQd4RasI7+4iACAwgR22pEd7ghkyFm51Vz39egSRJYFw2wpfSw98ke5UmdT10zCejmBbLVu5u2vgubuuqYeh4qZ4Y+4zy7SVSV0hS5U4+RQF2TdrsCxBnNiMMTulUD0LOcHOpoTUel5nd/NUj3irwmJtbH7Re91gUh2qHQA76fh+MzQbIStKVsE4/6YBdC1OF9obcTXQeb8bt/IoDY479lBswxV6qf+Q0i+DwuNn52mVqkcOA9pXY43pIcZWi0znqVTJIfkihLlC8n6tcD5x2VZqMOahr/1zbew9nLgyaMbH4zQU6TiNaU6qnxx5OdeKIUeBk2fcDuJ56Oc4HcQF42yAWg+SIx3oeuf4L3tZKB4hwzwGARAuDSpkjXPemt1Pg/CtMmLaEJWU7nEc/KM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(39860400002)(366004)(376002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(26005)(2616005)(83380400001)(4001150100001)(38100700002)(122000001)(110136005)(41300700001)(54906003)(8936002)(316002)(15650500001)(8676002)(5660300002)(7416002)(71200400001)(2906002)(4326008)(478600001)(66446008)(6486002)(66946007)(6506007)(64756008)(91956017)(76116006)(66556008)(6512007)(66476007)(38070700009)(86362001)(85182001)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MGNtamUzeW14c3kxZmVmTWdYVDBrb2MwT3BnandKbWFqMksrYlI0Z3FLVVZN?=
 =?utf-8?B?KzB6Q1JKc2xmRGt3QkZJdGE1YUc0OU9yS2RWVm44Zm5YMFVmL3JXNmwyY0pj?=
 =?utf-8?B?NE84aFZsakZ1U25BVFJIQUZuTlB6NCtjWGljbThlTWt1MFpITThpb1owb2tB?=
 =?utf-8?B?eW5kMUtFRjgyOUVlemo2QlhFSVZIZFpyY2pvT0VGdXl0VWxyZXowU1pCMnBN?=
 =?utf-8?B?Z3NrTmJWQUVLL09CZTlqK04waW54TGg5RlZ4bGdnMGk3K0h6dGtaa0VuOVFu?=
 =?utf-8?B?QnVHWmJxbXE1NXVSamdTVzJHRVkycVorUHBBVEwxbGk1MFlqeDdEdFFDQWdp?=
 =?utf-8?B?TURtbW9hOHNHMFBxOGN1anl1QjlLUEo4UVYvY0JVT1I4Q2R3c3RrNDIrendh?=
 =?utf-8?B?Njg3cUVtZndhL1BlUDh1UFVJUDY5ejNzUE1JM0U0MHVJbWtPRFVpc3prc05o?=
 =?utf-8?B?Znh0bVk5MzZEUzM2aXIzOGhkcVpJNG5IVDl1K01Zc0dBaUJoMU05VkYyS09a?=
 =?utf-8?B?Ky9IZ2dOUlJsUGdLZDc0bFpmemdNVzh1QUhFMThyWncwdVYrZ2g3bWwzeDlD?=
 =?utf-8?B?d2FVL3Z1aHZjZ0IxZzBOK0d3WGd0Qjg2bkxDcW9CQmRUWHpCQUVLVGx0K2J6?=
 =?utf-8?B?M09EUzFZcTAwYlNrdjRseEx2Y1ZrcHBHam5aV1ljUmNnU2dmcUc3OHFoWTIv?=
 =?utf-8?B?WnFtczZpa2QzZDMzK2N1bHJrTHVVL0UreW1SYmJJVml0LzNBSzE1V3VzR2lS?=
 =?utf-8?B?UEpDSTRJdEtQSWxJQlpSM2R3U0FxUnM5M0FVbUIwMFFOcXM1QzR3UEhiWEFZ?=
 =?utf-8?B?MzA2QW15dkFiSWExMlJxRjdPS0d2dEc5c250VmpDcDBoUnI5OVM4bzUwUnU3?=
 =?utf-8?B?ZWZmWThSNUNoc0wyanFOdzh1dFQ3Y1NsVElnZndkaXl2Q1ZjR2FTYng1TWxI?=
 =?utf-8?B?aFdWWVptTk5QUERmaTZhNDdQZktwQ0gyWTUySWZDWXBrZmpjRllnUHF0UGkw?=
 =?utf-8?B?Q0I5alUweklZMFZNS0dPcnI5YXZUcWRyblNpQ0pZTitpMVJIVXYyazZ6Unhi?=
 =?utf-8?B?UCtjZ0RVQUluRkJ2SiswOUszdWptdzYrcWVRNWxUci9CL2w2MkdKS2VWUFA2?=
 =?utf-8?B?dkxjaUVMNE0zK3NLQWZlY2lNallGRlZyRVpQS1l4VUM1VXZyYms0TFZVaGpC?=
 =?utf-8?B?UE5iNFZJVjEwQ0E1QncwR003TEtITCtNSmtlWGpKN3hEayt2ZXkrTTM3SEti?=
 =?utf-8?B?V2tpOE1KdFVvaitvOHF3L3ZXYWVOby9PN0tPNFBUcTNuRk5LdFZ2cDJTYkJX?=
 =?utf-8?B?TStJQmU3dFpOV2k1L1dEQVpYSy9DNTQwWHRhWlhsdFlvalhsalY1L2U0azdo?=
 =?utf-8?B?aTBwTVp6S0tJY3BWNHJ1czNaQjFHMmFpemZxSlpyU0pQUlA3ZXpEZ0crY3Rx?=
 =?utf-8?B?cVZmTGpMaVZ1U2JRMTBERFZRa00xb21LWTFGLy9UZ3dhMlNsQVQwMHFUT2xX?=
 =?utf-8?B?OC9uSUZWWDdwTG5tQzdBUDlCR2hibXlyNmV0N3ZqNzZualNuMWJVSlVDMnlN?=
 =?utf-8?B?ZHVrTE1JQkxzajNLdmdyYk1JLzBKcjJRKzhxSEJTcHNyTHYwTEJOaWt3SXRu?=
 =?utf-8?B?b3Z0cGdhTU1FYy82RFljVGlGeWJwZ0NXeVh2UGdwaWJ4bUhRMU9KZGdCOUUy?=
 =?utf-8?B?OEhDemdXS2ZNVkJDRUg2SzY3Zk1BSkxyVUpCM3hCbjdYSW1EWVFCZGhWTC83?=
 =?utf-8?B?VXBaWEpFZm12S1BBRm5NNHFlRTNJNGRnV0hHdUpDbkdlZ3RtaEZqaklwSGhP?=
 =?utf-8?B?cXN3RDAwK1FwWGpHVGZlUGV2TGRMdm1SN0VwQ09TSDVZNjdhay8zRFQ5d3RK?=
 =?utf-8?B?Q2NnUFhvekJKMTNYYzhJMTJmcEhSb3dTNFhSeXZrRFdrS0NscTBTWWNHOUpn?=
 =?utf-8?B?My9rOTU0eTdNSXRjTkJ2ZnJmMzRveTVkM3ZLQmJuWlM4ZE1QS21FZHZTc2Zk?=
 =?utf-8?B?emVSOUxQZFNWVlVaYjR5Q1VFZzBVQWduYkF6VjZpOHRMeklEY251d1R0Qjl3?=
 =?utf-8?B?c2pmNXRUbDk3Wm9VSkJUZEZXaVV4K2s1bVhSNFQrRlI4dXMxUitrQkdTek9K?=
 =?utf-8?B?SHhuYnorSzFpTXh4MElMNkorYWRqeWRjZytxeWRaek9TazlDT05NK0lzbncy?=
 =?utf-8?B?Y2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <03D86D168ACCD84C948443DE7EB40E16@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db7971ea-1525-4c28-d920-08dc0c28b368
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2024 06:53:32.7855
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fetKR5JoA/z9TFGVINaY4fbKSDu6dzmyLWiS4eD+vPJ6DA3WBgZH5Oq8MzpF0nLLJFa11NhfXK0NNycypAiF4g3yqGOPK2IJl/ew0Q1nrCc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR03MB5605
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--17.616700-8.000000
X-TMASE-MatchedRID: oTBA/+sdKaYOwH4pD14DsPHkpkyUphL9fjJOgArMOCao+b+yOP0oGEsi
	or6Czv3H3gb7k6xpVN4a/3L93pcprQTsy5Ctk/ajdAg4yd14qAQxmbT6wQT2a/t592eq2xoTHye
	T8VIiNb6ykaH8ZceX1bWrjxGHjCv1l7ynh5jrXh9PuMJi/ZAk8eWNJG9IamrcFLXUWU5hGiEzvr
	CMQwONijSP6iSZJa+vmLU5UzDdkUehdhOr/xScIU0jzafXv7tTfS0Ip2eEHnylPA9G9KhcvZkw8
	KdMzN86KrauXd3MZDUD/dHyT/Xh7Q==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--17.616700-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	EA66BD0EE2D09EBD0B83EB20A12E2D687DA8BE73980DBAF6F31B13833CF16D512000:8

T24gVGh1LCAyMDIzLTEyLTI4IGF0IDAxOjM4ICswMDAwLCBDSyBIdSAo6IOh5L+K5YWJKSB3cm90
ZToNCj4gT24gV2VkLCAyMDIzLTEyLTI3IGF0IDA3OjI1ICswMDAwLCBKYXNvbi1KSCBMaW4gKOae
l+edv+elpSkgd3JvdGU6DQo+ID4gSGkgQ0ssDQo+ID4gDQo+ID4gVGhhbmtzIGZvciB0aGUgcmV2
aWV3cy4NCj4gPiANCj4gPiBPbiBUdWUsIDIwMjMtMTItMjYgYXQgMDg6NTggKzAwMDAsIENLIEh1
ICjog6Hkv4rlhYkpIHdyb3RlOg0KPiA+ID4gSGksIEphc29uOg0KPiA+ID4gDQo+ID4gPiBPbiBG
cmksIDIwMjMtMTItMjIgYXQgMTI6NTIgKzA4MDAsIEphc29uLUpILkxpbiB3cm90ZToNCj4gPiA+
ID4gVG8gc3VwcG9ydCBzZWN1cmUgdmlkZW8gcGF0aCBmZWF0dXJlLCBHQ0UgaGF2ZSB0byByZWFk
L3dyaXRlDQo+ID4gPiA+IHJlZ2lzdGdlcnMNCj4gPiA+ID4gaW4gdGhlIHNlY3VyZSB3b3JsZC4g
R0NFIHdpbGwgZW5hYmxlIHRoZSBzZWN1cmUgYWNjZXNzDQo+ID4gPiA+IHBlcm1pc3Npb24NCj4g
PiA+ID4gdG8NCj4gPiA+ID4gdGhlDQo+ID4gPiA+IEhXIHdobyB3YW50cyB0byBhY2Nlc3MgdGhl
IHNlY3VyZSBjb250ZW50IGJ1ZmZlci4NCj4gPiA+ID4gDQo+ID4gPiA+IEFkZCBDTURRIHNlY3Vy
ZSBtYWlsYm94IGRyaXZlciB0byBtYWtlIENNRFEgY2xpZW50IHVzZXIgaXMgYWJsZQ0KPiA+ID4g
PiB0bw0KPiA+ID4gPiBzZW5kaW5nIHRoZWlyIEhXIHNldHRpbmdzIHRvIHRoZSBzZWN1cmUgd29y
bGQuIFNvIHRoYXQgR0NFIGNhbg0KPiA+ID4gPiBleGVjdXRlDQo+ID4gPiA+IGFsbCBpbnN0cnVj
dGlvbnMgdG8gY29uZmlndXJlIEhXIGluIHRoZSBzZWN1cmUgd29ybGQuDQo+ID4gPiA+IA0KPiA+
ID4gPiBTaWduZWQtb2ZmLWJ5OiBKYXNvbi1KSC5MaW4gPGphc29uLWpoLmxpbkBtZWRpYXRlay5j
b20+DQo+ID4gPiA+IC0tLQ0KPiA+ID4gDQo+ID4gPiBbc25pcF0NCj4gPiA+IA0KPiA+ID4gPiAr
DQo+ID4gPiA+ICtzdGF0aWMgaW50IGNtZHFfc2VjX2ZpbGxfaXdjX21zZyhzdHJ1Y3QgY21kcV9z
ZWNfY29udGV4dA0KPiA+ID4gPiAqY29udGV4dCwNCj4gPiA+ID4gKwkJCQkgc3RydWN0IGNtZHFf
c2VjX3Rhc2sNCj4gPiA+ID4gKnNlY190YXNrLCB1MzINCj4gPiA+ID4gdGhyZF9pZHgpDQo+ID4g
PiA+ICt7DQo+ID4gPiA+ICsJc3RydWN0IGl3Y19jbWRxX21lc3NhZ2VfdCAqaXdjX21zZyA9IE5V
TEw7DQo+ID4gPiA+ICsJc3RydWN0IGNtZHFfc2VjX2RhdGEgKmRhdGEgPSAoc3RydWN0IGNtZHFf
c2VjX2RhdGENCj4gPiA+ID4gKilzZWNfdGFzay0NCj4gPiA+ID4gPiB0YXNrLnBrdC0+c2VjX2Rh
dGE7DQo+ID4gPiA+IA0KPiA+ID4gPiArCXUzMiBzaXplID0gMCwgb2Zmc2V0ID0gMCwgKmluc3Ry
Ow0KPiA+ID4gPiArDQo+ID4gPiA+ICsJaXdjX21zZyA9IChzdHJ1Y3QgaXdjX2NtZHFfbWVzc2Fn
ZV90ICopY29udGV4dC0NCj4gPiA+ID4gPml3Y19tc2c7DQo+ID4gPiA+ICsNCj4gPiA+ID4gKwlp
ZiAoc2VjX3Rhc2stPnRhc2sucGt0LT5jbWRfYnVmX3NpemUgKyA0ICoNCj4gPiA+ID4gQ01EUV9J
TlNUX1NJWkUgPg0KPiA+ID4gPiBDTURRX1RaX0NNRF9CTE9DS19TSVpFKSB7DQo+ID4gPiA+ICsJ
CXByX2Vycigic2VjX3Rhc2s6JXAgc2l6ZTolenUgPiAldSIsDQo+ID4gPiA+ICsJCSAgICAgICBz
ZWNfdGFzaywgc2VjX3Rhc2stPnRhc2sucGt0LQ0KPiA+ID4gPiA+Y21kX2J1Zl9zaXplLA0KPiA+
ID4gPiBDTURRX1RaX0NNRF9CTE9DS19TSVpFKTsNCj4gPiA+ID4gKwkJcmV0dXJuIC1FRkFVTFQ7
DQo+ID4gPiA+ICsJfQ0KPiA+ID4gPiArDQo+ID4gPiA+ICsJaWYgKHRocmRfaWR4ID09IENNRFFf
SU5WQUxJRF9USFJFQUQpIHsNCj4gPiA+ID4gKwkJaXdjX21zZy0+Y29tbWFuZC5jbWRfc2l6ZSA9
IDA7DQo+ID4gPiA+ICsJCWl3Y19tc2ctPmNvbW1hbmQubWV0YWRhdGEuYWRkcl9saXN0X2xlbmd0
aCA9IDA7DQo+ID4gPiA+ICsJCXJldHVybiAtRUlOVkFMOw0KPiA+ID4gPiArCX0NCj4gPiA+ID4g
Kw0KPiA+ID4gPiArCWl3Y19tc2ctPmNvbW1hbmQudGhyZWFkID0gdGhyZF9pZHg7DQo+ID4gPiA+
ICsJaXdjX21zZy0+Y29tbWFuZC5zY2VuYXJpbyA9IHNlY190YXNrLT5zY2VuYXJpbzsNCj4gPiA+
ID4gKwlpd2NfbXNnLT5jb21tYW5kLmVuZ19mbGFnID0gc2VjX3Rhc2stPmVuZ2luZV9mbGFnOw0K
PiA+ID4gPiArCXNpemUgPSBzZWNfdGFzay0+dGFzay5wa3QtPmNtZF9idWZfc2l6ZTsNCj4gPiA+
ID4gKwltZW1jcHkoaXdjX21zZy0+Y29tbWFuZC52YV9iYXNlICsgb2Zmc2V0LCBzZWNfdGFzay0N
Cj4gPiA+ID4gPnRhc2sucGt0LQ0KPiA+ID4gPiA+IHZhX2Jhc2UsIHNpemUpOw0KPiA+ID4gDQo+
ID4gPiBJIHRoaW5rIGl0J3Mgbm90IG5lY2Vzc2FyeSB0byBjb3B5IGZyb20gbm9ybWFsIGNvbW1h
bmQgYnVmZmVyIHRvDQo+ID4gPiBub3JtYWwNCj4gPiA+IGNvbW1hbmQgYnVmZmVyLiBKdXN0DQo+
ID4gPiANCj4gPiA+IGl3Y19tc2ctPmNvbW1hbmQudmFfYmFzZSA9IHNlY190YXNrLT50YXNrLnBr
dC0+dmFfYmFzZTsNCj4gPiA+IA0KPiA+ID4gWW91IGhhdmUgYSBzZWN1cmUgY29tbWFuZCBidWZm
ZXIgZm9yIHNlY3VyZSBnY2UgdG8gZXhlY3V0ZQ0KPiA+ID4gY29tbWFuZC4NCj4gPiA+IElmDQo+
ID4gPiB5b3Ugd2FudCB0byBtb2RpZnkgY29tbWFuZCBidWZmZXIsIGNvcHkgZnJvbSBub3JtYWwg
Y29tbWFuZA0KPiA+ID4gYnVmZmVyDQo+ID4gPiB0bw0KPiA+ID4gc2VjdXJlIGNvbW1hbmQgYnVm
ZmVyLCBhbmQgbW9kaWZ5IHRoZSBzZWN1cmUgY29tbWFuZCBidWZmZXIuDQo+ID4gPiANCj4gPiA+
IFJlZ2FyZHMsDQo+ID4gPiBDSw0KPiA+ID4gDQo+ID4gPiANCj4gPiANCj4gPiBJIHRoaW5rIHNl
Y3VyZSB3b3JsZCB3b24ndCByZWNvZ25pemUgbm9ybWFsIHdvcmxkJ3MgdmEsIHNvIHdlIG5lZQ0K
PiA+IHRvDQo+ID4gY29weSB0byBpd2NfbXNnLT5jb21tYW5kLnZhX2Jhc2UsIHdoaWNoIGlzIGEg
d29ybGQgc2hhcmUgbWVtb3J5DQo+ID4gZmlyc3QuDQo+IA0KPiBSZWZlcnJpbmcgdG8gY21kcV9z
ZWNfYWxsb2NhdGVfd3NtKCksIGFueSBrZXJuZWwgYnVmZmVyIGNvdWxkIHVzZQ0KPiB0ZWVfc2ht
X3JlZ2lzdGVyX2tlcm5lbF9idWYoKSB0byBiZWNvbWUgc2hhcmUgYnVmZmVyIGJldHdlZW4gbm9y
bWFsDQo+IHdvcmxkIGFuZCBzZWN1cmUgd29ybGQuIEluIGNsaWVudCBkcml2ZXIsIHVzZQ0KPiB0
ZWVfY2xpZW50X29wZW5fY29udGV4dCgpDQo+IHRvIGNyZWF0ZSB0ZWUgY29udGV4dCBhbmQgcmVn
aXN0ZXIgbm9ybWFsIGNvbW1hbmQgYnVmZmVyIHRvIGJlIHNoYXJlDQo+IGJ1ZmZlci4gVGhpcyB3
b3VsZCByZWR1Y2UgdGhlIHJlZHVuZGFudCBtZW1vcnkgY29weS4NCj4gDQo+IFJlZ2FyZHMsDQo+
IENLDQo+IA0KDQpPSywgSSdsbCB0cnkgdG8gcmVnaXN0ZXIgbm9ybWFsIGNtZCBidWZmZXIgdG8g
c2hhcmUgbWVtb3J5Lg0KDQpSZWdhcmRzLA0KSmFzb24tSkguTGluDQoNCj4gPiANCj4gPiBSZWdh
cmRzLA0KPiA+IEphc29uLUpILkxpbg0K

