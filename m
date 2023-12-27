Return-Path: <linux-kernel+bounces-11805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA64681EBE6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 04:36:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42138B222D3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 03:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2B03C15;
	Wed, 27 Dec 2023 03:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="JphZRoXq";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="fC6UVpv2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D533C0C;
	Wed, 27 Dec 2023 03:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 00f13062a46911ee9e680517dc993faa-20231227
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=Xt3YPWKjXwaJSO6EEDryrVc3lTeuLr0wCHEUM8fSbxg=;
	b=JphZRoXqKw3v4iZbUrc5usYtn1mxcvPJUo4d86OSHIum0eyRQNpzT2TnKdhzEXlpv7toO4YyahIoWFxbEf4UALln9yl7XW0E9o9DHvZ36HdF5/8zSjwv4Pef3vLbTwOYDqAD6+2B5bVpwB6Zp7e1JLx/zqzGqItaOMV2XIy7N4s=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:9f75f8fd-d613-4e48-a9fe-e70e75248a37,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:080d3582-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 00f13062a46911ee9e680517dc993faa-20231227
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 808599887; Wed, 27 Dec 2023 11:35:38 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 27 Dec 2023 11:35:37 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 27 Dec 2023 11:35:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DLe2Z01lgh1WbBDZk9UDoerEX4HWCM74Olo8D9wZnPiqpY42Bsv7+CoZs6igal+VnGT3Wjt1oa/WScqojV5jAC7J7TUrfoZkoSHt5iVShzAF1W+hKcdTKcsmS97eAQZgfzij2nu3i9TouPtfyaGRKMnR2OQqWYd2jpRzjNoTl0wMtcH9Rl+sQ7dzYQaxBH96X/WLVenkTuQuvvsHVpERRb0iXxE5RwsvgQHjaYiw2LbSPIPeylWbbQ5vVlglzmUaBhphYwS8mxfncd3Ix5DjyTMSTD2p15YW15kkWb2Ug0+grLdWI1qHOOsmP+CVFJknjxg/z3Ruc4qCqnUkhQZrUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xt3YPWKjXwaJSO6EEDryrVc3lTeuLr0wCHEUM8fSbxg=;
 b=U7PTUeZ73FReXfDvHS0nAFU6h5ph7AqKYnRzAXI0nJmrWVxGrNbYof/w1vtw4Rh07RHHtwiCKxmt4AasljP0MVIkoKHV0D98WCzKquri4yw1bQuEGWUX/m9+u48NOi11oL2D7wlOB/ehTI7INcYseJ61Tx+K8+2XJYsKGenoYxxTWKW/RyvRWAh5KKysuyB/7ferpJI8QkUDreZOGGjLaj9Vx9Xp0tPoJNJgI5dFJHJkXHHXwj/7PVqCoQR4Zl+yU55RmpYzR71AnVUN3jV6SeNNSRsTG33B8nCbeVvMRncYTdwN2nqZqTSjXVV438Lvx/ufikJIa3R5TyvOlqDG7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xt3YPWKjXwaJSO6EEDryrVc3lTeuLr0wCHEUM8fSbxg=;
 b=fC6UVpv2oOwoX+8iTbYyHd1qkjtkj3XjOsTIKcqzhZKvBsBVqicSWCtS7l4i/3suKsHlR3wkJJ3J2lx/nfqen4J2bi0jxUGcvneoeQQkEcGQNojXekTXfiEiIShCMsHVd5g8qkjF/YSHwE1e/v0GUoEyAw52l3JdoFkNWqrIJto=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by TY0PR03MB8224.apcprd03.prod.outlook.com (2603:1096:405:14::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27; Wed, 27 Dec
 2023 03:35:34 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::ebb9:e872:cb84:4a88]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::ebb9:e872:cb84:4a88%5]) with mapi id 15.20.7113.027; Wed, 27 Dec 2023
 03:35:34 +0000
From: =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>
To: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "chunkuang.hu@kernel.org"
	<chunkuang.hu@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	=?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= <Singo.Chang@mediatek.com>,
	=?utf-8?B?Sm9obnNvbiBXYW5nICjnjovogZbpkasp?= <Johnson.Wang@mediatek.com>,
	"linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	=?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?=
	<Jason-ch.Chen@mediatek.com>, =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?=
	<Shawn.Sung@mediatek.com>, =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?=
	<Nancy.Lin@mediatek.com>, "jkardatzke@google.com" <jkardatzke@google.com>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 08/11] drm/mediatek: Add secure layer config support
 for ovl_adaptor
Thread-Topic: [PATCH v3 08/11] drm/mediatek: Add secure layer config support
 for ovl_adaptor
Thread-Index: AQHaNc4C7Arpt4W5lEi0EWjH/QL0ObC66V6AgAGWhIA=
Date: Wed, 27 Dec 2023 03:35:34 +0000
Message-ID: <6d03f325f3ad25a96c143c0c7ac52b580c69814f.camel@mediatek.com>
References: <20231223182932.27683-1-jason-jh.lin@mediatek.com>
	 <20231223182932.27683-9-jason-jh.lin@mediatek.com>
	 <2d045768bb3f1da3e2ea77f9f94050b194627e5b.camel@mediatek.com>
In-Reply-To: <2d045768bb3f1da3e2ea77f9f94050b194627e5b.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|TY0PR03MB8224:EE_
x-ms-office365-filtering-correlation-id: fd87141c-3846-44d2-96a2-08dc068ce26a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x4X+rytz3T83Eb8x1M5Dj9daX/qgxJEKBINXjCX4O7UZNJMX5eUH2CFL5NzWm8twRZGhezloV51zE94+es1wbl75TLZrCFSlImMwW4M0V5Wxvz4j4oxyb0RKQx79Tm+N2+2g61JG1Ab3M9cEOUK6/wnl7ElfFUh6ZOAgLzq8Pd8mz+I+UnNF7o6XiBmhqCGj6Ie+u0gHsmqWZA4yQ20M5lSJjRrwOmtZ5ZhOEa+MzwQ+p//q5ebZVkyibo20zQ4R8Du4m+0VivwqutgZYe0uA5pHDkqmv4rJDKaFKAfO6QNhds89m6KYZFZc3I5R5CTtZfYiTrTNvqPHG/+Qrye81kzLOtAQUkO0wA20/C78hwuogSk9i07A4ieTfR8917ukoH7oqcLd3flDMtt8cldby8OxYmP9Sp3eztTtQNfPmJqLhebBwvNxBMyvyYXaf49nUH1LiXPzXBGmxP6ssqYV5cyhA7aRU6e4BWS6CMtXXdUgzdhTIXUGQtXmU0EemE3OhprGHqAUaC1cCkmmMyUk6LhhwW7kiIDMGADDzO2/ASbOzdQmtP1dfwIzqEH1gDXKQmIDAzpBCCtkAc+D+lw7JTQzk5qgYSviPtkeLKRftfpGUPO57OG1wJUsbU513xFWZTE83q0FjMJmXL/MfM6Xa5zpTXpHrWTBw/lDTDH2CUM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(376002)(366004)(346002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(26005)(86362001)(38070700009)(6506007)(38100700002)(85182001)(36756003)(122000001)(83380400001)(7416002)(4326008)(5660300002)(6512007)(2616005)(71200400001)(478600001)(316002)(6486002)(110136005)(91956017)(66476007)(54906003)(66946007)(64756008)(76116006)(66556008)(66446008)(4001150100001)(2906002)(8676002)(41300700001)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WldTajFUUUtTVEhBVENvRUZyOHhNdWlyWVdaZG85QmJQMlFJaTQrb25aaVNP?=
 =?utf-8?B?WkNsMkwxZ2JqU0pNdnlWK041Zm1mSnhHWlRkUVpTTGx6d21mRmRQU1VTVmJa?=
 =?utf-8?B?NFo4dHg4eUFhaGJSY2RRL0VyVjJDVHNDQkhNTzZCTVhuemEybDdaR1pIOStY?=
 =?utf-8?B?TFN0SkRhZ3FNaVF4d1BLd1Vlb0lEYVdzU0pmRnAxQjlZd2NhRHpjc3N2Z1NO?=
 =?utf-8?B?Q0VaQ3FqbEJlU3JRVjc2TlRQSTdFNUhNd0dKYkhqKzZ0b2UreEVPL1didEI0?=
 =?utf-8?B?UHl1ZUd5b1N1VkRMQ3JlZE9qNFMzWVpDbkQvOElXZUFKU1N4YXVuVndlZWZG?=
 =?utf-8?B?Wi8yUHdCWTYyQmVHcjhBUlBCUHh1cHZtZ2pycjVDUDUzKzdpMk5tTnZpRFZV?=
 =?utf-8?B?SnhnV1p3bGY5SlZSSUF3MzF3L0dzVEVoRmFxODVXdW1VVHIyNUdGbzFCSnhu?=
 =?utf-8?B?VGY2Q0Z6NEpJejZBalk2eU9BVlplb1FYTmgxelZDL1hGbGdKeExBMzIxcVNa?=
 =?utf-8?B?blVQNlBPU0c3U2xSY3U4Z0RSNlZFZGFZUmp1L29CckVaa0VEVVhXbTZIUFIw?=
 =?utf-8?B?VHpjUytPT295NHpCMVZ5MWVMQ1NsYldXVEZYOFBhZWNPQmdyU3lLWUJVRm9H?=
 =?utf-8?B?WTV6V3hHYXJnNUN2MGIxSFYzRkhTWlJLK1paZ3dIcWhSWFVXd1EyVGlFak1k?=
 =?utf-8?B?SzNHd25sWStkWTNXT1JKcHdoQTY0Zi9hb0JQaHpiT1M5eHJpK2pMNnMya0kx?=
 =?utf-8?B?VzR6R014M3dQcG5kTWFySXlCV1BVLzhLRXpVTWZwRUZPczFTZlNnKzZKWlFx?=
 =?utf-8?B?dC85TUlJakdSQzQ5cTdacFJTR3pVdW80ZmMvNHU2RjZFWDRLTkFlWHhEYkw4?=
 =?utf-8?B?UnFCMk1xUHF0Ty9TeG12VHNBRTNRUXlaalVtUlpLaUdBVGcwb0dRZzVKT0ky?=
 =?utf-8?B?d2wvM09SY0tTVGErRllZNW9vRHJXcHBnZk5HTktCMVdHa1R5N1d5TWxUMWNu?=
 =?utf-8?B?OUluQWlRSytPZThTNloxUkQzaTdmejFHenpSU0RYaFUxUWdSTHduMC8weEMw?=
 =?utf-8?B?QTE4Rlh3ckY1VkY1TUU3dTR4bWF2Zkg5SytSMVVhUWVZNGcwc2pFVHkwYm43?=
 =?utf-8?B?RTVRcTBaamQzTWlMUzdTWGJ1Y0srZGNkc0hJekJ6N09Hd050a1BKWHZ2UjRl?=
 =?utf-8?B?STFsa0Zmdy9QdnpzVzYvVHhOYVhuM3J4NWtIdnB1Y3phRlpOUXh4TXFoMVFP?=
 =?utf-8?B?MG95K1hZdytPc0xoM05vbWprNDJWZjdkTHVjWHBhUWQ5SFU4SnNFMVFpaGZh?=
 =?utf-8?B?TENiN3JDQVQxdEJIUW9qM1QvdWl1NlZKazRQbzY1YjBSZFRTRmhnZEtsa3F3?=
 =?utf-8?B?YnZ1ZURxRVRZbEdpMlpMY0tZYmVYVlFaVFllZjRtZmdxWG9ZL0p4NENseDhO?=
 =?utf-8?B?Z1BpeGYxckhHU3ZUbmFOYWpzNnF0Z1ZBcTlITmNqOW1ORzY2VjB6cXg1Q0N2?=
 =?utf-8?B?NTdZdWgzaDJOanppZGZad2d0NUJEbGp1V0pyTlEyMklkNGpKNkpxOFpIdmo3?=
 =?utf-8?B?MG4yb2hpR0EzM0wxcExsUGpFZ3dGVENJdVU2djJzdy8rTzdFc091by9QVUJG?=
 =?utf-8?B?Mzk5RFpFNDIvSnBPaXdzUndiVUFLblhaK1hCL0RxS3hrZmpQK3Q3Nng5Vmoy?=
 =?utf-8?B?eFZRQVZKMjRHNVJIQU5HNG85ckNRWEpPM2hna1R3enVmd3NLNTloSWkzTUti?=
 =?utf-8?B?YkdwZVgzNFpsR3ZFY0RMb09SODduQUpLOWpLMFR2WXBocUFIL2RESGZ0TDlm?=
 =?utf-8?B?YmxBQWZhQ3dSajlQeEgxdWlaZXNCMDlKZWEvUEliOUkrOW9Qa29pSHJ4L0VC?=
 =?utf-8?B?dHNEOEdIREMwWklwemxuMDZFeEpIV3V5bm5zZlRCTFE5M05LWFlvN3NyMGc1?=
 =?utf-8?B?ZzlqMTBFT1gwdUNhd0VadTdPT2FRU2tyNWRTdlJDUWdEbzFFUFo5Nk9mOWZM?=
 =?utf-8?B?Z1N1citmaHd0WUp4RXc5bEVFMVl3NXRwUld2c1d4bkVZcXEwZmJPYml4SU9R?=
 =?utf-8?B?UmsxZjJMNnNSMHJ3MmF6eU9haGpuVU1nVzc0bExIN0Njbll4bU5GV1FwcUEz?=
 =?utf-8?B?Rml3d3lsa0paRzJHdEFxQmJxeXVsOWpIb3JyZ2hCNVJEclVaM2NDZ0dVVW43?=
 =?utf-8?B?eWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9ECB7FA63BFE2743AE1BAC0211792A7B@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd87141c-3846-44d2-96a2-08dc068ce26a
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Dec 2023 03:35:34.3074
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fzxt2WYJGZTAFcc06M8DJItDlETsvuvLeLmGtlJUbb2yZmaSaHJLXrbaRczgYT+za0LlPeFF35p7XzYBm3VUiPkDpcKUuiUjLoqELj+IOL8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB8224

SGkgQ0ssDQoNClRoYW5rcyBmb3IgdGhlIHJlaXZld3MuDQoNCk9uIFR1ZSwgMjAyMy0xMi0yNiBh
dCAwMzoyMCArMDAwMCwgQ0sgSHUgKOiDoeS/iuWFiSkgd3JvdGU6DQo+IEhpLCBKYXNvbjoNCj4g
DQo+IE9uIFN1biwgMjAyMy0xMi0yNCBhdCAwMjoyOSArMDgwMCwgSmFzb24tSkguTGluIHdyb3Rl
Og0KPiA+IEFkZCBzZWN1cmUgbGF5ZXIgY29uZmlnIHN1cHBvcnQgZm9yIG92bF9hZGFwdG9yIGFu
ZCBzdWIgZHJpdmVyDQo+ID4gbWRwX3JkbWEuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogSmFz
b24tSkguTGluIDxqYXNvbi1qaC5saW5AbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2
ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfZHJ2LmggICAgICAgICB8ICAxICsNCj4gPiAg
ZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX292bF9hZGFwdG9yLmMgfCAxNQ0KPiA+
ICsrKysrKysrKysrKysrKw0KPiA+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9k
ZHBfY29tcC5jICAgICB8ICAxICsNCj4gPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19t
ZHBfcmRtYS5jICAgICAgICAgfCAxMSArKysrKysrKy0tLQ0KPiA+ICBkcml2ZXJzL2dwdS9kcm0v
bWVkaWF0ZWsvbXRrX21kcF9yZG1hLmggICAgICAgICB8ICAyICsrDQo+ID4gIDUgZmlsZXMgY2hh
bmdlZCwgMjcgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX2Rydi5oDQo+ID4gYi9kcml2
ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfZHJ2LmgNCj4gPiBpbmRleCA3NzA1NGFkY2Q5
Y2YuLmVjOTc0Njc2NzQ2OCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0
ZWsvbXRrX2Rpc3BfZHJ2LmgNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRr
X2Rpc3BfZHJ2LmgNCj4gPiBAQCAtMTE3LDYgKzExNyw3IEBAIHZvaWQgbXRrX292bF9hZGFwdG9y
X2Nsa19kaXNhYmxlKHN0cnVjdCBkZXZpY2UNCj4gPiAqZGV2KTsNCj4gPiAgdm9pZCBtdGtfb3Zs
X2FkYXB0b3JfY29uZmlnKHN0cnVjdCBkZXZpY2UgKmRldiwgdW5zaWduZWQgaW50IHcsDQo+ID4g
IAkJCSAgICB1bnNpZ25lZCBpbnQgaCwgdW5zaWduZWQgaW50IHZyZWZyZXNoLA0KPiA+ICAJCQkg
ICAgdW5zaWduZWQgaW50IGJwYywgc3RydWN0IGNtZHFfcGt0DQo+ID4gKmNtZHFfcGt0KTsNCj4g
PiArdTY0IG10a19vdmxfYWRhcHRvcl9nZXRfc2VjX3BvcnQoc3RydWN0IG10a19kZHBfY29tcCAq
Y29tcCwNCj4gPiB1bnNpZ25lZA0KPiA+IGludCBpZHgpOw0KPiA+ICB2b2lkIG10a19vdmxfYWRh
cHRvcl9sYXllcl9jb25maWcoc3RydWN0IGRldmljZSAqZGV2LCB1bnNpZ25lZCBpbnQNCj4gPiBp
ZHgsDQo+ID4gIAkJCQkgIHN0cnVjdCBtdGtfcGxhbmVfc3RhdGUgKnN0YXRlLA0KPiA+ICAJCQkJ
ICBzdHJ1Y3QgY21kcV9wa3QgKmNtZHFfcGt0KTsNCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL21lZGlhdGVrL210a19kaXNwX292bF9hZGFwdG9yLmMNCj4gPiBiL2RyaXZlcnMvZ3B1
L2RybS9tZWRpYXRlay9tdGtfZGlzcF9vdmxfYWRhcHRvci5jDQo+ID4gaW5kZXggNmJmNjM2Nzg1
M2ZiLi5mNDE5YzJlNzBiYTMgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlh
dGVrL210a19kaXNwX292bF9hZGFwdG9yLmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVk
aWF0ZWsvbXRrX2Rpc3Bfb3ZsX2FkYXB0b3IuYw0KPiA+IEBAIC04Myw2ICs4MywxOCBAQCBzdGF0
aWMgY29uc3Qgc3RydWN0IG92bF9hZGFwdG9yX2NvbXBfbWF0Y2gNCj4gPiBjb21wX21hdGNoZXNb
T1ZMX0FEQVBUT1JfSURfTUFYXSA9IHsNCj4gPiAgCVtPVkxfQURBUFRPUl9FVEhEUjBdCT0geyBP
VkxfQURBUFRPUl9UWVBFX0VUSERSLCAwIH0sDQo+ID4gIH07DQo+ID4gIA0KPiA+ICtzdGF0aWMg
Y29uc3QgdTY0IG92bF9hZGFwdG9yX3NlY19wb3J0W10gPSB7DQo+ID4gKwlCSVRfVUxMKENNRFFf
U0VDX1ZETzFfRElTUF9SRE1BX0wwKSwNCj4gPiArCUJJVF9VTEwoQ01EUV9TRUNfVkRPMV9ESVNQ
X1JETUFfTDEpLA0KPiA+ICsJQklUX1VMTChDTURRX1NFQ19WRE8xX0RJU1BfUkRNQV9MMiksDQo+
ID4gKwlCSVRfVUxMKENNRFFfU0VDX1ZETzFfRElTUF9SRE1BX0wzKSwNCj4gPiArfTsNCj4gPiAr
DQo+ID4gK3U2NCBtdGtfb3ZsX2FkYXB0b3JfZ2V0X3NlY19wb3J0KHN0cnVjdCBtdGtfZGRwX2Nv
bXAgKmNvbXAsDQo+ID4gdW5zaWduZWQNCj4gPiBpbnQgaWR4KQ0KPiA+ICt7DQo+ID4gKwlyZXR1
cm4gb3ZsX2FkYXB0b3Jfc2VjX3BvcnRbaWR4XTsNCj4gPiArfQ0KPiA+ICsNCj4gPiAgdm9pZCBt
dGtfb3ZsX2FkYXB0b3JfbGF5ZXJfY29uZmlnKHN0cnVjdCBkZXZpY2UgKmRldiwgdW5zaWduZWQg
aW50DQo+ID4gaWR4LA0KPiA+ICAJCQkJICBzdHJ1Y3QgbXRrX3BsYW5lX3N0YXRlICpzdGF0ZSwN
Cj4gPiAgCQkJCSAgc3RydWN0IGNtZHFfcGt0ICpjbWRxX3BrdCkNCj4gPiBAQCAtMTQxLDYgKzE1
Myw5IEBAIHZvaWQgbXRrX292bF9hZGFwdG9yX2xheWVyX2NvbmZpZyhzdHJ1Y3QgZGV2aWNlDQo+
ID4gKmRldiwgdW5zaWduZWQgaW50IGlkeCwNCj4gPiAgCXJkbWFfY29uZmlnLnBpdGNoID0gcGVu
ZGluZy0+cGl0Y2g7DQo+ID4gIAlyZG1hX2NvbmZpZy5mbXQgPSBwZW5kaW5nLT5mb3JtYXQ7DQo+
ID4gIAlyZG1hX2NvbmZpZy5jb2xvcl9lbmNvZGluZyA9IHBlbmRpbmctPmNvbG9yX2VuY29kaW5n
Ow0KPiA+ICsJcmRtYV9jb25maWcuc291cmNlX3NpemUgPSAocGVuZGluZy0+aGVpZ2h0IC0gMSkg
KiBwZW5kaW5nLQ0KPiA+ID4gcGl0Y2ggKw0KPiA+IA0KPiA+ICsJCQkJICBwZW5kaW5nLT53aWR0
aCAqIGZtdF9pbmZvLT5jcHBbMF07DQo+ID4gKwlyZG1hX2NvbmZpZy5pc19zZWN1cmUgPSBzdGF0
ZS0+cGVuZGluZy5pc19zZWN1cmU7DQo+ID4gIAltdGtfbWRwX3JkbWFfY29uZmlnKHJkbWFfbCwg
JnJkbWFfY29uZmlnLCBjbWRxX3BrdCk7DQo+ID4gIA0KPiA+ICAJaWYgKHVzZV9kdWFsX3BpcGUp
IHsNCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZGRw
X2NvbXAuYw0KPiA+IGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZGRwX2NvbXAu
Yw0KPiA+IGluZGV4IDZhZWQ3NjQ3ZGZjMC4uOWI3ZmUzNGRmOWE2IDEwMDY0NA0KPiA+IC0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2RkcF9jb21wLmMNCj4gPiArKysgYi9k
cml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHBfY29tcC5jDQo+ID4gQEAgLTQ0NSw2
ICs0NDUsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG10a19kZHBfY29tcF9mdW5jcw0KPiA+IGRk
cF9vdmxfYWRhcHRvciA9IHsNCj4gPiAgCS5yZW1vdmUgPSBtdGtfb3ZsX2FkYXB0b3JfcmVtb3Zl
X2NvbXAsDQo+ID4gIAkuZ2V0X2Zvcm1hdHMgPSBtdGtfb3ZsX2FkYXB0b3JfZ2V0X2Zvcm1hdHMs
DQo+ID4gIAkuZ2V0X251bV9mb3JtYXRzID0gbXRrX292bF9hZGFwdG9yX2dldF9udW1fZm9ybWF0
cywNCj4gPiArCS5nZXRfc2VjX3BvcnQgPSBtdGtfb3ZsX2FkYXB0b3JfZ2V0X3NlY19wb3J0LA0K
PiA+ICB9Ow0KPiA+ICANCj4gPiAgc3RhdGljIGNvbnN0IGNoYXIgKiBjb25zdCBtdGtfZGRwX2Nv
bXBfc3RlbVtNVEtfRERQX0NPTVBfVFlQRV9NQVhdDQo+ID4gPQ0KPiA+IHsNCj4gPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19tZHBfcmRtYS5jDQo+ID4gYi9kcml2
ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX21kcF9yZG1hLmMNCj4gPiBpbmRleCBjM2FkYWVlZmQ1
NTEuLmExNjRiYTgyZDAyMiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0
ZWsvbXRrX21kcF9yZG1hLmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRr
X21kcF9yZG1hLmMNCj4gPiBAQCAtOTQsNiArOTQsNyBAQCBzdHJ1Y3QgbXRrX21kcF9yZG1hIHsN
Cj4gPiAgCXZvaWQgX19pb21lbQkJKnJlZ3M7DQo+ID4gIAlzdHJ1Y3QgY2xrCQkqY2xrOw0KPiA+
ICAJc3RydWN0IGNtZHFfY2xpZW50X3JlZwljbWRxX3JlZzsNCj4gPiArCXJlc291cmNlX3NpemVf
dAkJcmVnc19wYTsNCj4gPiAgfTsNCj4gPiAgDQo+ID4gIHN0YXRpYyB1bnNpZ25lZCBpbnQgcmRt
YV9mbXRfY29udmVydCh1bnNpZ25lZCBpbnQgZm10KQ0KPiA+IEBAIC0xOTgsOSArMTk5LDEyIEBA
IHZvaWQgbXRrX21kcF9yZG1hX2NvbmZpZyhzdHJ1Y3QgZGV2aWNlICpkZXYsDQo+ID4gc3RydWN0
IG10a19tZHBfcmRtYV9jZmcgKmNmZywNCj4gPiAgCWVsc2UNCj4gPiAgCQltdGtfZGRwX3dyaXRl
X21hc2soY21kcV9wa3QsIDAsICZwcml2LT5jbWRxX3JlZywgcHJpdi0NCj4gPiA+IHJlZ3MsDQo+
ID4gDQo+ID4gIAkJCQkgICBNRFBfUkRNQV9TUkNfQ09OLCBGTERfT1VUUFVUX0FSR0IpOw0KPiA+
IC0NCj4gPiAtCW10a19kZHBfd3JpdGVfbWFzayhjbWRxX3BrdCwgY2ZnLT5hZGRyMCwgJnByaXYt
PmNtZHFfcmVnLCBwcml2LQ0KPiA+ID4gcmVncywNCj4gPiANCj4gPiAtCQkJICAgTURQX1JETUFf
U1JDX0JBU0VfMCwgRkxEX1NSQ19CQVNFXzApOw0KPiA+ICsJaWYgKGNmZy0+aXNfc2VjdXJlKQ0K
PiA+ICsJCW10a19kZHBfc2VjX3dyaXRlKGNtZHFfcGt0LCBwcml2LT5yZWdzX3BhICsNCj4gPiBN
RFBfUkRNQV9TUkNfQkFTRV8wLA0KPiA+ICsJCQkJICBjZmctPmFkZHIwLCBDTURRX0lXQ19IXzJf
TVZBLCAwLCBjZmctDQo+ID4gPiBzb3VyY2Vfc2l6ZSwgMCk7DQo+IA0KPiBJbiBPVkwsIHRoZXJl
IGlzIG9uZSBiaXQgdGhhdCBjb250cm9sIE9WTCBoYXJkd2FyZSBjb3VsZCBhY2Nlc3MNCj4gc2Vj
dXJlDQo+IGJ1ZmZlciBvciBub3QuIFdoeSBtZHAgcmRtYSBoYXMgbm8gdGhpcyBiaXQ/DQo+IA0K
PiBSZWdhcmRzLA0KPiBDSw0KPiANClllcywgdGhhdCdzIGRpZmZlcmVudCBIVyBkZXNpZ24gZm9y
IE9WTC4NCg0KQmVjYXVzZSBPVkwgaGFzIDQgbGF5ZXJzLCB3ZSBjYW4ndCB3aXRjaCB0aGUgd2hv
bGUgbGFyYiBwb3J0IHRvIHNlY3VyZQ0KbGlrZSBNRFBfUkRNQS4gU28gdGhhdCBPVkwgY2FuIHN1
cHBvcnQgbm9ybWFsIGJ1ZmZlciBpbnB1dCBhbmQgc2VjdXJlDQpidWZmZXIgaW5wdXQgYXQgdGhl
IHNhbWUgdGltZS4NCg0KUmVnYXJkcywNCkphc29uLUpILkxpbg0KDQo=

