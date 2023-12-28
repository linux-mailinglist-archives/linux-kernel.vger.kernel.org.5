Return-Path: <linux-kernel+bounces-12489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E0181F58A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 08:35:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B36EB2183F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 07:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E69D5232;
	Thu, 28 Dec 2023 07:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="No1HNv2C";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="nPprBM+u"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8EE4402;
	Thu, 28 Dec 2023 07:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: a65dfdbaa55311ee9e680517dc993faa-20231228
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=25wAr9yTrRU3731VQ9cG0zqBjHuTw8GRnbvObZG4d8I=;
	b=No1HNv2CGtNGbA+I58q0Gd7tkH86/MjPO5O3B4yYVH2TiTvtAMawCX7dWWX1sT1xoNDZQ0CpZLVxI0ZQsHV+wLqJhNTK4jZLigE2KICXq0hwzrMUnP+TPKpbmp2i1WMNsLrdGVAiXqfg/qDG/6LD30zg7UbYZSfk1x/40kBhhSg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:ff13570a-1dee-4de8-a479-77c7f7275e8e,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:108b4182-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: a65dfdbaa55311ee9e680517dc993faa-20231228
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1625623264; Thu, 28 Dec 2023 15:35:18 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 28 Dec 2023 15:35:18 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 28 Dec 2023 15:35:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fpgJn51SECvTOTDMy/WZTIZLMFODvjWRI73gRQ/iZV7lxHArtatRK+1RD/2P3DjaDi5N9Z1v7CNoj6OJaAgAPy/vi9rj6xauXRfIcx6SpKLjDsZ2yb8dTMyAVoLL3hdDlN9gXQ9WObSJnITqJaMkigMAGjsr768T3ZqWRc05hLUVuMRmVnS82Q3p399NYFgWm8wuTU15CndUSPwug3OhOuT/XxG2ybH0XDj9Dc0fgBTHOu6SeoU1WzaIPh6hZTByNV+HhnKGwr5GDu/6B2QVNjs9CWMaUMvxUUqIgw3VnYqPfh452yd4Wg1DfGCE+k6Uy+Jmw6abF0h31Y2amVVbLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=25wAr9yTrRU3731VQ9cG0zqBjHuTw8GRnbvObZG4d8I=;
 b=V5avGpUe/KzOFHuvBwfYQYcPLACyIjWaKRVjzfhiT4LcvwECtOXo1xTFE6HrJCgzuzoyey0P2RJaTXeM1cm7Les8IrGodFwDbvinQ7btNUNLn8o5GHt4QkRbSU5Da5EEezREYmCn2KPJU1Zh+urAfd0nFnDohV94GxJOkF9r5iceDWF0AJ+Fz64YkRzsiCMpDMkjrq6c7fdPlIZFuspGj6aVDhQV2WfNXtHEfx0E098pE5e90Fxf2S3DRTOdn/uWYFhhLg4t2/GNQHINDY5URC0FZSf5kjQ//5Mn0QObh+ndO4EgWGlowYswIr6vynTXfWpPaopdzaHMiu17O+f60w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=25wAr9yTrRU3731VQ9cG0zqBjHuTw8GRnbvObZG4d8I=;
 b=nPprBM+uiXnWILxGn8XqQYl0lJB9Ht/21dAieZ6/TXYl0cAhgs/6fBNTDg8k3avPn8CG9UYk1IZI681zdHUCQR5bTmCQS9i1w6NTtLZQQLetud5Jc7aTFJmypLjxaNv45jnroeEu+v2cXB3gWytKaBEWDisCK0JLS/CnzQFbtTQ=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by JH0PR03MB7836.apcprd03.prod.outlook.com (2603:1096:990:2c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.20; Thu, 28 Dec
 2023 07:35:16 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::eb43:57cb:edfd:3762]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::eb43:57cb:edfd:3762%7]) with mapi id 15.20.7113.027; Thu, 28 Dec 2023
 07:35:15 +0000
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
Thread-Index: AQHaNJMHlgU6p3MSPUCi0pus2NsH47C+V6WA
Date: Thu, 28 Dec 2023 07:35:15 +0000
Message-ID: <d4eb25a2affed65ed30a269e4b54e8d1a671abde.camel@mediatek.com>
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
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|JH0PR03MB7836:EE_
x-ms-office365-filtering-correlation-id: 428c0673-d028-4deb-9824-08dc077788e1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1LiPsYA0TEsYOtM/CWgdir+cIA9EeiVD28G7MRGngOu6bYjvBvSJmzqtWtJgPGZmjQXYzTH+lCrD7daSxUcNt+9Kpcdg1WXm1e6ngu1ltVOcfGMOSy+jktWAfqIusoLLjHLNilRAZDA5qaxs/myFyZQ9EoZzcLhFa7CEkO9a+0xhafbmo/gBvMFR0BMiPN8kIrNb3lCg8n9LnbgB6iwWK8slMd/zYrfGm8BFYtDmYM5gwAIqVJ2ECj/wcZ7xPeITXjItl5nMrViKMFt6Qx+Cjx94ZEg+yHt3MmskjaPUnY1ek+gDKUIr8DN46sbQJS9GlIINr2rqCu9IHsLU9oZLTpeCNsTCSAQtCmYNzzP1Vlly+Y0bsiW5weJa512FXnNq0sL8DMj+8ZEDP2H40xhe07MPSPm7WM8lJDJ/2xBIZm9V3IuodEcYNEFn1h3O/6qG3BzhtdGjo4wgFP7JNwA4X7SiNIJpstZtLSPmVRbmoaQg5J/bxJt6x+t1Ip21g+pOeoaH0o/2Nhkx/wxBAZ5lt0pgj0ddfc2uihz4wkGMOMCPbuqSLCFDqwu5112qLyGMxfXsbBomhEOBVvIROzdu3cxIHhNRp4d6JesC0xlpGi6oFJuIbDVnJIfX6PpXfuYJqo05Sk8UXYqGS1EAeXJ5Vt0dBRAzIeMDQuEPTzzPCPk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39860400002)(136003)(396003)(376002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(4001150100001)(38100700002)(2906002)(26005)(66446008)(64756008)(66946007)(66556008)(66476007)(6486002)(2616005)(76116006)(6512007)(71200400001)(6506007)(122000001)(86362001)(36756003)(85182001)(41300700001)(7416002)(8676002)(8936002)(54906003)(110136005)(316002)(478600001)(4326008)(5660300002)(15650500001)(83380400001)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RjczeHFwL0FUeldjRDhLcEtzbmNETDArMC9OVnBmaXVNNXA4SVNkOWs2NzM3?=
 =?utf-8?B?UjBVSkcxT3NtL05NMm1UUHdDbjRzQ0pQaml1OTNmTDN5ZFpkKzdFOFY5ZnBy?=
 =?utf-8?B?YzJVR1hpcWFOUVZPRmNlMFdKODZYMjVSMG1Xb2VKV1RuQzc0ZHNhUE1lNkdj?=
 =?utf-8?B?VGJLOVpmc3pvOEp3WFE3ZzdaM09qQWpTSEdVKzZMbTdXNlBaR05Ec3JpVEZW?=
 =?utf-8?B?RE1aRjBZM2dsODlEOGVuQXBWOXhDemQwR25WdWpraEN1UVZSaG5WK3hrbE8v?=
 =?utf-8?B?cFp4L2xSQjUyQzFqWmsxSms1ekZyb0pKKzRKclh6akszdWJQMTQxSmphT0xW?=
 =?utf-8?B?VkxhYVVWQVpmUjE1TFlHaDlqOGYvbSs5Ykh2bXduTFAwWTdpSyszQWFxcHZD?=
 =?utf-8?B?bFVyaTh5cms0Nm1ZYWwrOTFyTDB2akZnQ2lxck9xMlYrOVN1WlZKZWptSHJ2?=
 =?utf-8?B?ckh1NFFraU03MVBXbjR1K21XN3hSVEJFMytxYVVUYzBJSHBLWm9JVUZtQUt0?=
 =?utf-8?B?b3YrWTJKdlBpRXcvWTlJcm53RE1CN1J1TjAwNVIvbCt4bms3OHpVL3hXOGdP?=
 =?utf-8?B?SDJwS0xZNE94TWxVWC84alRaZGdMa3ViK2UyV2Q2aW1GNS8yZ0F4bTlJc04v?=
 =?utf-8?B?RFRuZ2VnVWFwMzhxRWFjVk81RERLUjJZYldoQWw0VWxsMDFWWUNVTEEzekJk?=
 =?utf-8?B?OFNwRStBYXRtQkU5WWJ3M2RwMFl2TnczTGdZeWFhbVBPWkMvd3FJd1I1bnFI?=
 =?utf-8?B?VG5obDF0ejdEMHg0eU85S09yR0oxVGQ3ZXZQZ0dzNFNka3kwZXYvckE1QXUv?=
 =?utf-8?B?L0d3bUUyV1dhYk5nY255cjQ2a05QTUcwNFJEUi9sRFVrdldMNnJNWGIxb3M5?=
 =?utf-8?B?SUhSbjFSbk9yRFVYQkVtdFQzQUNBeTJ0ZGIwbUZUQnlVWXpzdFcvVlU1eVZx?=
 =?utf-8?B?V0NhS21nWHhPV2FQWVBqeFJYTVVDQjFraU54ZUliU0lINDZ1dHQzSDQ5aDcv?=
 =?utf-8?B?bCsvY0kySWljbkR2Y2lJSXB2c091Z3dmMVpMZUxWS1VJcTJBYkRtb0dpcnBl?=
 =?utf-8?B?UG85S2IzWnYxRG4weHhpRTVweWszRGxYTUc0Qzd1UmVId2lhZWdaNzRrVE80?=
 =?utf-8?B?bFFESVJrY3hxbG54aGdYTzRINXpMdUtKQ0dETkhKMEVKcS9PZk1JWGlJbXc0?=
 =?utf-8?B?VURRaHQ1ZzJ0WmlhRWJRc1lGZ1haWnlPK3BkWVltRTdIcGo4dnJNZS9lNisv?=
 =?utf-8?B?cStJc0RqMlRjNlpkSGsvUXJ6VUVpUksyb285Rk1vbnRCa2dpQ1JZckQwL2tk?=
 =?utf-8?B?a2trbjlRM1RCQXRaNngwaDhqNHkwaU9vemlVVmNBRVh6SEhnSFlQc3dOTFlh?=
 =?utf-8?B?TmxHUkJvZmxaRzRxQXFhV0ZSU0NNVnhNbjNWQkpjdisvMnFQd2N6U0NieDRu?=
 =?utf-8?B?ekhFYW85ek9EeDNPZmYzWVFMeFFFcXAraXdJYytiVFBzMFA3ZTdaemVEZEVC?=
 =?utf-8?B?Qjd3VnhFT3dUTXhyMEZWU3RBaDZSYWs0NkVuL1FGNlFkcVNURFhlRXZHMTJp?=
 =?utf-8?B?ZEdQVVdNblFMcDlobXJrQUV0dUpONnNMNFAxYTNaT2w5KzhzYmk4bXF0aE9I?=
 =?utf-8?B?VnVyMVVBcUxmVHNjNnR2VXJIQWdxM2VMd3FZUlBXMEJRYTBXR2tJejVjc1Zy?=
 =?utf-8?B?VWlOb2J1WjZBQ3Mza3Nkcm05M0VxWVB5YlJKNVh5SmlvQjg4Vk5rZWdhTW5C?=
 =?utf-8?B?cUIrRTBEaG03ODE4Tlp2K1FhZnU3R2xETnJPaHZwVTROSWZoQ3BjeStmWlpE?=
 =?utf-8?B?MGxuRnFoUkxxajZINm5zNUJ2ZCtHUFphK2lYaWFBczBPWUc4N01LQTRHZ2tK?=
 =?utf-8?B?L0NQNndRczJWMVlDanpNZ3YvTk55NW0wSTVYcWNWem5OcERrRTljOUw1aCs2?=
 =?utf-8?B?M0JKK29ObkF6b0dxK3RHeVJ5Y25KL0txSEF4TGpzNTJtWnJEamNOVHZqOERO?=
 =?utf-8?B?Q2s1NzBoREJvb3NQRXh1UllpYWpvQUxTcDBpV0srSy9EZmsxeUY4aWZIYWFE?=
 =?utf-8?B?ejlrdUFKLzNuVmZMbzNNbGpzRXloUG56S1hUdXJlUVZUNS9jcFltb1VIeXhX?=
 =?utf-8?Q?xWi9iDIPDFUICzrbrlimlb/hn?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B99A5A14C394D14986FFC5A5FEE79A2B@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 428c0673-d028-4deb-9824-08dc077788e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Dec 2023 07:35:15.8394
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AANorL4uLG/tkXkQbdxmXEBxld8ckQls2AWUYXJaMjqJmE8MkQo2kP5Zf4Ain79bERAjyv4Ot6lyUr5ndVK0RA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7836

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
PiArc3RhdGljIGludCBjbWRxX3NlY19zZXNzaW9uX3JlcGx5KGNvbnN0IHUzMiBpd2NfY21kLCBz
dHJ1Y3QNCj4gaXdjX2NtZHFfbWVzc2FnZV90ICppd2NfbXNnLA0KPiArCQkJCSAgdm9pZCAqZGF0
YSwgc3RydWN0IGNtZHFfc2VjX3Rhc2sNCj4gKnNlY190YXNrKQ0KPiArew0KPiArCXN0cnVjdCBp
d2NfY21kcV9jYW5jZWxfdGFza190ICpjYW5jZWwgPSBkYXRhOw0KPiArCXN0cnVjdCBjbWRxX3Nl
Y19kYXRhICpzZWNfZGF0YSA9IHNlY190YXNrLT50YXNrLnBrdC0+c2VjX2RhdGE7DQo+ICsNCj4g
KwlpZiAoaXdjX2NtZCA9PSBDTURfQ01EUV9JV0NfU1VCTUlUX1RBU0sgJiYgaXdjX21zZy0+cnNw
IDwgMCkgew0KPiArCQkvKiBzdWJtaXQgZmFpbCBjYXNlIGNvcHkgc3RhdHVzICovDQo+ICsJCW1l
bWNweSgmc2VjX2RhdGEtPnNlY19zdGF0dXMsICZpd2NfbXNnLT5zZWNfc3RhdHVzLA0KPiArCQkg
ICAgICAgc2l6ZW9mKHNlY19kYXRhLT5zZWNfc3RhdHVzKSk7DQoNCnNlY19kYXRhLT5zZWNfc3Rh
dHVzIGlzIHVzZWxlc3MsIHNvIGRyb3AgaXQuDQoNCj4gKwkJc2VjX2RhdGEtPnJlc3BvbnNlID0g
aXdjX21zZy0+cnNwOw0KDQpzZWNfZGF0YS0+cmVzcG9uc2UgaXMgdXNlbGVzcywgc28gZHJvcCBp
dC4NCg0KUmVnYXJkcywNCkNLDQoNCj4gKwl9IGVsc2UgaWYgKGl3Y19jbWQgPT0gQ01EX0NNRFFf
SVdDX0NBTkNFTF9UQVNLICYmIGNhbmNlbCkgew0KPiArCQkvKiBjYW5jZWwgY2FzZSBvbmx5IGNv
cHkgY2FuY2VsIHJlc3VsdCAqLw0KPiArCQltZW1jcHkoY2FuY2VsLCAmaXdjX21zZy0+Y2FuY2Vs
X3Rhc2ssIHNpemVvZigqY2FuY2VsKSk7DQo+ICsJfQ0KPiArDQo+ICsJcmV0dXJuIGl3Y19tc2ct
PnJzcDsNCj4gK30NCj4gKw0K

