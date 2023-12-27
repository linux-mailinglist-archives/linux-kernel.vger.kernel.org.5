Return-Path: <linux-kernel+bounces-11771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB9881EB73
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 03:09:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C1141F21A6F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 02:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B240F2113;
	Wed, 27 Dec 2023 02:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Orq6y4e3";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="vR2lm48G"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB6C3C0D;
	Wed, 27 Dec 2023 02:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: dc0cb87ca45c11ee9e680517dc993faa-20231227
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=6WK9HgArYEMoQxetRx2AbrJeYzQhcY6QbtbF5M2X3Xw=;
	b=Orq6y4e3Ff+2YCtwovzyxLS9rlrGhy+guDJ/eQqOOK/NCvPovv74CEZz7TTkCkIzcsthDrnPZ07MePmtosL0meSEtXxvZNGs9jYWpOfgFmI8ag3FC5H7bROWQl79red5fYSqL5nm1oYQNAX6kMadpTfEi3VmS74s9h8/cHWa/gw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:4c6dcb19-9684-49be-aa8b-c031c2d60ee5,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:7ff8b37e-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
	NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: dc0cb87ca45c11ee9e680517dc993faa-20231227
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
	(envelope-from <chunfeng.yun@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1521348455; Wed, 27 Dec 2023 10:08:43 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 27 Dec 2023 10:08:41 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 27 Dec 2023 10:08:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YJAvg5AOivvmDDE+NjV0HY7xftPeTN5iJOgilH3X+1pJRgg/4OpHyNj98AX7cfA+P/4fyTRtB+Hto6T0TnwD/fng+xrdCDvVwIexMwJWOpRYU3U0U/SnfGlsxO4o9IzxymsRDS4tXFM9KgLbldWY9mFed8sh2xofOaD1/ambV/UVhrQ8ZY0ALeA83RxAg8kYBgjqSexVuCRiYJYrDsVTwLsJk7R3c3+9PWHLqSzlASZCpuWoeBvT6CilaMcRnUXKYVUGkDrQilpzTOGrzY6S6N/mqqhtzIP9r0VBuBaW73OUO4eXN5+R37Cr7aavXb2af7wQHkkeiIa3hAf6E4XJOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6WK9HgArYEMoQxetRx2AbrJeYzQhcY6QbtbF5M2X3Xw=;
 b=WrIBLbA0j+YbblnfHxTkVIqZmqJw8qYOEmoxvhVlRm+nEOoquDd4rfXjC3erqXJIUtw6cnpZVLaZXzGrIYmLR7wjsnnEX/1PvymtldfL2xMwS0B94IlrZztr6A0x/v9CllWfCO9FIuHLukFrGHtHnY5pnE4svnS1QEfkXsHYGS0/9md4beT6AFMHBKf/OcV3BZRcuu0LuqX71Lnb3+U8KZgEnahTnWY1H/8KMiVlB7HA2dUWUZwGjG2zXyRpF4GzjlalpfQW/Jfsaq9Ysbn3PJ8ZelBv/I/ZqxHEeXj1L7V+U4M5gokufmZW3LW7RS9v1d0+8QAxloztMEkmthLQxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6WK9HgArYEMoQxetRx2AbrJeYzQhcY6QbtbF5M2X3Xw=;
 b=vR2lm48GmhDRoZe9OPEynpBXmE5TweUmTAjpohIwgihJsxCb4JU/Iez6KEXjh4lS0fClWZFv1ZkOtK7WpyFdBSfbPryD4qmwgrCOeBmaJ4E+7wJn3R5B5cd5pBCw2FqY0kF0dp8G9Z+g1OVO0QR8J+cPn3vlUH7ySRfZ68Ct0ag=
Received: from TYZPR03MB7153.apcprd03.prod.outlook.com (2603:1096:400:33c::6)
 by JH0PR03MB7976.apcprd03.prod.outlook.com (2603:1096:990:2f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.18; Wed, 27 Dec
 2023 02:08:39 +0000
Received: from TYZPR03MB7153.apcprd03.prod.outlook.com
 ([fe80::75b5:9f6d:dc01:9946]) by TYZPR03MB7153.apcprd03.prod.outlook.com
 ([fe80::75b5:9f6d:dc01:9946%6]) with mapi id 15.20.7113.027; Wed, 27 Dec 2023
 02:08:39 +0000
From: =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= <Chunfeng.Yun@mediatek.com>
To: "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>
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
Subject: Re: [PATCH v3 1/3] dt-bindings: usb: mtk-xhci: add a property for
 Gen1 isoc-in transfer issue
Thread-Topic: [PATCH v3 1/3] dt-bindings: usb: mtk-xhci: add a property for
 Gen1 isoc-in transfer issue
Thread-Index: AQHaMvB01EmIj/BXvUeSxpJjUV7Ik7CxyRGAgAAzEQCACnEyAA==
Date: Wed, 27 Dec 2023 02:08:39 +0000
Message-ID: <6510fb531ffb109c05b3ccd270ee516831209bd7.camel@mediatek.com>
References: <20231220025842.7082-1-chunfeng.yun@mediatek.com>
	 <c3d372f0-3d21-4500-96cd-9c88aaf5ce89@linaro.org>
	 <4117de24-75fd-4355-9ffb-7d1bc0167295@collabora.com>
In-Reply-To: <4117de24-75fd-4355-9ffb-7d1bc0167295@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB7153:EE_|JH0PR03MB7976:EE_
x-ms-office365-filtering-correlation-id: 002c08c8-3d8c-43f6-507d-08dc0680bde9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZyJd1m3v6Qsyez038WaQHc5+MLH9DTAsK7olklACx+gP6MOS6iIwrNQWtM+W+Mu3QNUzh1n22bdGJmaIheddS1lYK2+7fz8otBiWx8KSnjyUpEXghKdL3bU/lXZg+V903ud2InW7PIgkVYXJbMlQ6GpPfYkaau2Han55Yjid8MZpUh1NZN62IoPcqkj37hwD7admeZV6hPH332gPrXK7/h+Yc3oA82mjj2tEhFS3dy3d4XHu7fK9EGSSHirlzbbMkWydGY9Lnl3P9Dr0es298sK3tIyWLIAkcxUxsiHbLgb6pyQzFR5tEOVE2YUktN6N+venvXKO51t9XtvnEbgDmVeZwNBbfY6AiymF1sNHZyt4k7eScaDFn+OSZvCwueuEHJDsMHCSyf6CVOS8SE8Kw2tOjk/zq71TJbRzrplRZjrmfnhUJnA0Qu5TxMcsMro1nC+x/7eFE3Ht5NMxufRyxG/0q2dxje1zp5kPPJINMsy6VEb2IJYVQfFwPKWSCA54SAi15lGlTtBOQ3oQS0cOKj3J/toZBFYkLih/CX4+ZuuyTnZSw1Yv/P2J5FuMhAzq4hpC1jKooiFRtVLUWf5ZuR6Hm1dzP2VYbVj6ox/UNu/laEN5EsGXkdeuksQShiGC23kEg62f/XTDUE1MsSvpaQHZtZagrNZ7I3qvqxGMel0Od0ROB4fiNKUaZsC84Mhq
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7153.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(366004)(346002)(376002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(83380400001)(41300700001)(2616005)(38100700002)(26005)(122000001)(4326008)(110136005)(54906003)(316002)(8936002)(8676002)(7416002)(2906002)(5660300002)(4001150100001)(478600001)(71200400001)(53546011)(6506007)(91956017)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(6486002)(6512007)(38070700009)(86362001)(36756003)(85182001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b1hVMjZjb3loZkcyM3Q0NW42Z2R4a042R3FhZlV6eHZLMndDNHVGUTJHdEJE?=
 =?utf-8?B?MGFZNE8xUUxNN09SUDZtYU1qUHFEQkR2a1AvbUFnZ1FoMXlSQlY2c0s2VWRj?=
 =?utf-8?B?Njh6dmxOdU5sS0VEWlNvQnJ0NXd3cmZ2UUREWTNXd2c3R3ZwSVBDUjFyUk5v?=
 =?utf-8?B?ZFgyN0l1KzZuZDJ4TEdBa0VPY0IwS1Z2RGxJV1ZieW00VGtJa1plYVpCOTJk?=
 =?utf-8?B?NlRFSnF2YU1yV2llektkdGJJWDBBSnJoWHNXMDBTTk5aMkxWYkVUaVY4VVN5?=
 =?utf-8?B?TEhRVHU4cHh2NDFrSTFobGZLUEdFTnR0b2xkY0ZkWUI1bVZGMkhkeE4rSkpv?=
 =?utf-8?B?ZXVvcHI4K2lTaUV3a3Y4OEI5bFdyc2dYSjByUkRweG1vU3lURm5qOGhNOExR?=
 =?utf-8?B?T2Yvc21DRVRrbFR2S1NCbTY5N2xkN2JlQVhSamxqa1JNazJ5T1ZwQlR2aXFR?=
 =?utf-8?B?YWN6eUc4cjZrZy9wQU1CUkVtUWJaK0o3RnVwRFhtUGxQeE9ISExZdWNyVTV3?=
 =?utf-8?B?Sy9wb09kNFpXRENHa3dMcGJjVTEwMnNTYlkyUGNuK3JOQ1I1MVBjd3BGdWlE?=
 =?utf-8?B?SXRUWVk1N0s1QjVqaDI4ODFVVzdGeGlwKzRUY29EKzgrZzVIa1hvNHZaMkVL?=
 =?utf-8?B?T0Z0b0dqV1hTMENHbWU1UHE5S1pZMUF6STh3bjdZZDV4KzFLVzd5N2h6SlBQ?=
 =?utf-8?B?VHU2RjUxV0dPYWlpVjdiV0xyaTJ2NFdrSzBRajlrVi9uUkZNdHl1ZnVGYStl?=
 =?utf-8?B?UE1FQzB0WTQvZk5kVnNaMGdmK3RWNFdLRUJrdE9EcjFqd3RSSVBXaGlpTmpZ?=
 =?utf-8?B?aGk2RVk5Q0FpS3NIVmVPK3Vaek4zZnljREh5TmFLWjg4WTNOVXNncE9kT01a?=
 =?utf-8?B?WG9RTE4wYTBvTzhEK3NDUkJHNkNKNEtVWEo5aGQwQzZJREZnZDdENE1PU0hH?=
 =?utf-8?B?ZmpjeTY5R1UvR2FpWUpONmhTZUdiNFVYY2pqUlZkb2NSeWNRajFLNEpWRTZt?=
 =?utf-8?B?bm0rYTlxeGNOYWpDV1BrZjZyaG9Udjc3dzhIa25GNUo4blpqZVc2eGM0Vksw?=
 =?utf-8?B?SFZsckhSOTZWN0ZQVzZFd3VJV3Nzb04zT0pxemhZZ3hVakg5VksvNlFWY2NI?=
 =?utf-8?B?Q2srcnBMMW52TTVrUlhLaFR3OVdkcXF1VVdaUkwvL0E4RDhTM1BKK2Z1ME5q?=
 =?utf-8?B?V1VYU2tUOGFTR0pQMmU4M0J4RnhhUk9OTUN0YXd3dGZzZGg4VFBCeUtLblhu?=
 =?utf-8?B?RFgwaTJBTmhsWm1oUVJTMXQxay9KUVU4dXVUVjQxUGFCa2tOYXAxMHhsS2wr?=
 =?utf-8?B?M1loUzVCYTJRWjlFcFdtNzljcTkrckRFRkdhaDhsQTlOR0pZL2tQSXhUdWh4?=
 =?utf-8?B?UU9XaE4yTDdtZVZWRnBzVFNDOHBPUFFPelN4V0FnSmVRL1hUejBiT3JPb1hW?=
 =?utf-8?B?WEtLU0VGQzVHeFQvdkdnZ1R0SDdrc2pTVmExd0duajlTQ1pmOEpJZld5Nmlw?=
 =?utf-8?B?dy9wcmRucXRWdlhzZ0hzZjZCS2dTRUpHcjJPdy9TbGRGOUZnZDJWdjJNYTdF?=
 =?utf-8?B?SXkzM3pPand2TFJpdE40V2NiRzJNR1VvZnRxOW5sUVBNUzU0cC8zdWlXRlNn?=
 =?utf-8?B?SDNlZml2UEY0ZVBNN3RyY0dEdWJwTGljZjNFOU5OK2hzVGVGWVJjTCt3cUVv?=
 =?utf-8?B?QzZFWFJKZnZIaGdxYTZ1eGJUWFlJcVAxN1RwWDVpczc3MjBDS1hmOGRiZ0dk?=
 =?utf-8?B?QklJald6VjR3RXA1YXdoNTJUbU9yVTBWT2t5TWN6YjBpNVlYVmZCNkFraDJU?=
 =?utf-8?B?ME93MkM2R0VrU201a1E2b3U1OGRSYTF4T01IR2E5aWoyTkNTczRiMUR3cjNw?=
 =?utf-8?B?bFMxa3VBNUYwdE1WWW9IOXU0bCttWnFiVUJHY3M5SVZ6eE9mcTMzMktFUktw?=
 =?utf-8?B?VXhscyt5UW1IT2ZiWEVyNTVnN0Y5NnBhRUtWZzc0M3J0UW5zNDRqSndRdUZC?=
 =?utf-8?B?c1FGWE1wV0QrcDRWc3FCQU1VRkk3WjBob3B4TWFCczNIQjI2WXRLU2t1V2wx?=
 =?utf-8?B?aGw5SE1YU3cxSGY2OXIvMjdYa2tFbG5CY0JoenlKWUM2VUk4ZXIwL2VkalFI?=
 =?utf-8?B?S3NGUDh6dVZKRTh1UVhublp1MTNlZ0JuRCtaN3NnYStObHBlQVlveWRINHF2?=
 =?utf-8?B?b3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9F6AB19A5F66CF4097FAB4B99105A8A0@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7153.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 002c08c8-3d8c-43f6-507d-08dc0680bde9
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Dec 2023 02:08:39.1465
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4SubFIY1JzNsPFmHgk/h9/vWkGM3Lqx61WHS1CUpT5LM0eJd+7E5EX8xdIF/fQFcOLTDyLPROnIZDo4NAQdP4kb7XfYvCWGvcRI3qwCcL4Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7976
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--16.545700-8.000000
X-TMASE-MatchedRID: UWn79NfEZzbUL3YCMmnG4kD6z8N1m1ALjLOy13Cgb49qSjxROy+AU2yd
	bY7xfgXYfzQXZjDd1s9EfZEG9zzVQzbwsrznmJSKyn0GCvk40qFfFPlyDwr+135h6y4KCSJcouw
	Z1gh7SgRYHxG6vTRI6nH8e/oG52cCoH/hlIfJ3aWzI1v7J4hECnyzymMiw5QH31GU/N5W5BCorZ
	pcV2Ae+pcuRfduDXagLSlQoQOAxL3GUecy8W1eagOa3TYC1j5CD4xHNmkZEuEaUFNX+UFygC4su
	uEQr3gGT+hKVrbnxsU1iMjPzurJ6Zya2tEru0x7SDkh6bW+bcf54F/2i/DwjUUNHQAoZf5c69fs
	JVKUTsXNMonmPoyMtQI0mW3vzqeQ5UcZtwNsCrrSBVVc2BozSnJnzNw42kCxxEHRux+uk8jpP8t
	MOyYmaA==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--16.545700-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	AD99FEF9251FF2D682602BA7077D14DDF461BCCEEDCFEF28AC1B13A32CBC5FE92000:8
X-MTK: N

T24gV2VkLCAyMDIzLTEyLTIwIGF0IDExOjQwICswMTAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gSWwgMjAvMTIvMjMgMDg6MzgsIEtyenlzenRvZiBLb3psb3dza2kgaGEg
c2NyaXR0bzoNCj4gPiBPbiAyMC8xMi8yMDIzIDAzOjU4LCBDaHVuZmVuZyBZdW4gd3JvdGU6DQo+
ID4gPiBGb3IgR2VuMSBpc29jLWluIGVuZHBvaW50IG9uIGNvbnRyb2xsZXIgYmVmb3JlIGFib3V0
IFNTVVNCIElQTQ0KPiA+ID4gdjEuNi4wLCBpdA0KPiA+ID4gc3RpbGwgc2VuZCBvdXQgdW5leHBl
Y3RlZCBBQ0sgYWZ0ZXIgcmVjZWl2aW5nIGEgc2hvcnQgcGFja2V0IGluDQo+ID4gPiBidXJzdA0K
PiA+ID4gdHJhbnNmZXIsIHRoaXMgd2lsbCBjYXVzZSBhbiBleGNlcHRpb24gb24gY29ubmVjdGVk
IGRldmljZSwNCj4gPiA+IHNwZWNpYWxseSBmb3INCj4gPiA+IGEgNGsgY2FtZXJhLg0KPiA+ID4g
QWRkIGEgcXVpcmsgcHJvcGVydHkgInJ4LWZpZm8tZGVwdGgiIHRvIHdvcmsgYXJvdW5kIHRoaXMg
aGFyZHdhcmUNCj4gPiA+IGlzc3VlLA0KPiA+ID4gcHJlZmVyIHRvIHVzZSAzayBieXRlczsNCj4g
PiA+IFRoZSBzaWRlLWVmZmVjdCBpcyB0aGF0IG1heSBjYXVzZSBwZXJmb3JtYW5jZSBkcm9wIGFi
b3V0IDEwJSwNCj4gPiA+IGluY2x1ZGluZw0KPiA+ID4gYnVsayB0cmFuc2Zlci4NCj4gPiA+IA0K
PiA+ID4gU2lnbmVkLW9mZi1ieTogQ2h1bmZlbmcgWXVuIDxjaHVuZmVuZy55dW5AbWVkaWF0ZWsu
Y29tPg0KPiA+ID4gLS0tDQo+ID4gPiB2MzogYWRkIGZpZm8gZGVwdGggdW5pdCwgY2hhbmdlIHRo
ZSB2YWx1ZSByYW5nZSBmcm9tIDAtMyB0byAxLTQNCj4gPiA+IHYyOiBjaGFuZ2UgJ21lZGlhdGVr
LHJ4Zmlmby1kZXB0aCcgdG8gJ3J4LWZpZm8tZGVwdGgnDQo+ID4gPiAtLS0NCj4gPiA+ICAgLi4u
L2RldmljZXRyZWUvYmluZGluZ3MvdXNiL21lZGlhdGVrLG10ay14aGNpLnlhbWwgICB8IDEyDQo+
ID4gPiArKysrKysrKysrKysNCj4gPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDEyIGluc2VydGlvbnMo
KykNCj4gPiA+IA0KPiA+ID4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy91c2IvbWVkaWF0ZWssbXRrLQ0KPiA+ID4geGhjaS55YW1sIGIvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL3VzYi9tZWRpYXRlayxtdGstDQo+ID4gPiB4aGNpLnlhbWwN
Cj4gPiA+IGluZGV4IGU5NjQ0ZTMzM2Q3OC4uOTQ3OGI3MDMxNzk2IDEwMDY0NA0KPiA+ID4gLS0t
IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3VzYi9tZWRpYXRlayxtdGstDQo+
ID4gPiB4aGNpLnlhbWwNCj4gPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy91c2IvbWVkaWF0ZWssbXRrLQ0KPiA+ID4geGhjaS55YW1sDQo+ID4gPiBAQCAtMTI0LDYg
KzEyNCwxOCBAQCBwcm9wZXJ0aWVzOg0KPiA+ID4gICAgICAgICBkZWZpbmVkIGluIHRoZSB4SENJ
IHNwZWMgb24gTVRLJ3MgY29udHJvbGxlci4NCj4gPiA+ICAgICAgIGRlZmF1bHQ6IDUwMDANCj4g
PiA+ICAgDQo+ID4gPiArICByeC1maWZvLWRlcHRoOg0KPiA+ID4gKyAgICAkcmVmOiAvc2NoZW1h
cy90eXBlcy55YW1sIy9kZWZpbml0aW9ucy91aW50MzINCj4gPiA+ICsgICAgZGVzY3JpcHRpb246
DQo+ID4gPiArICAgICAgSXQgaXMgYSBxdWlyayB1c2VkIHRvIHdvcmsgYXJvdW5kIEdlbjEgaXNv
Yy1pbiBlbmRwb2ludA0KPiA+ID4gdHJhbnNmZXIgaXNzdWUNCj4gPiA+ICsgICAgICB0aGF0IHN0
aWxsIHNlbmQgb3V0IHVuZXhwZWN0ZWQgQUNLIGFmdGVyIGRldmljZSBmaW5pc2ggdGhlDQo+ID4g
PiBidXJzdCB0cmFuc2Zlcg0KPiA+ID4gKyAgICAgIHdpdGggYSBzaG9ydCBwYWNrZXQgYW5kIGNh
dXNlIGFuIGV4Y2VwdGlvbiwgc3BlY2lhbGx5IG9uIGENCj4gPiA+IDRLIGNhbWVyYQ0KPiA+ID4g
KyAgICAgIGRldmljZSwgaXQgaGFwcGVucyBvbiBjb250cm9sbGVyIGJlZm9yZSBhYm91dCBJUE0g
djEuNi4wOw0KPiA+ID4gdGhlIHNpZGUtZWZmZWN0DQo+ID4gPiArICAgICAgaXMgdGhhdCBtYXkg
Y2F1c2UgcGVyZm9ybWFuY2UgZHJvcCBhYm91dCAxMCUsIGluY2x1ZGUgYnVsaw0KPiA+ID4gdHJh
bnNmZXIsDQo+ID4gPiArICAgICAgcHJlZmVyIHRvIHVzZSAzIGhlcmUuIFRoZSB1bml0IGlzIDFL
IGJ5dGVzLg0KPiA+IA0KPiA+IE5BSy4gUmVhZCBjb21tZW50cyBvbiBwcmV2aW91cyBzdWJtaXNz
aW9uLg0KPiA+IA0KPiA+IEJlc3QgcmVnYXJkcywNCj4gPiBLcnp5c3p0b2YNCj4gPiANCj4gDQo+
IENodW5mZW5nLCBJIHRoaW5rIHRoZSBkaXNjdXNzaW9uIHdhcyBub3QgY2xlYXIgZm9yIHlvdSwg
c28gSSB3aWxsIHRyeQ0KPiB0byBnaXZlDQo+IHlvdSBhIGRpZmZlcmVudCBleHBsYW5hdGlvbjog
dGhpcyBzaG91bGQgYmUgZXhwcmVzc2VkIGluIGJ5dGVzLCBzbw0KPiAxMDAwLCBvciAxMDI0LA0K
PiAyMDQ4LCA0MDk2LCBldGMsIGFuZCBub3QgMS8yLzMvNC81L24uDQo+IA0KPiBUaGUgZHJpdmVy
IHNoYWxsIHRoZW4gdmFsaWRhdGUgYW5kIG1hcCB5b3VyIGJ5dGVzIG51bWJlciB0byBoYXJkd2Fy
ZQ0KPiByZWdpc3Rlcg0KPiB2YWx1ZSBhbmQgc3Vic2VxdWVudGx5IHdyaXRlIHRvIHRoZSByZWdp
c3RlcnMuDQpHb3QgaXQsIEkgbGVmdCBvdXQgS3J6eXN6dG9mJ3MgY29tbWVudHMgd2hlbiBzZW50
IHYzIHNlcmllcywNCg0KVGhhbmtzIGEgbG90DQoNCj4gDQo+IENoZWVycywNCj4gQW5nbGVvDQo=

