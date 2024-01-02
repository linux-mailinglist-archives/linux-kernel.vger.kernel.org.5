Return-Path: <linux-kernel+bounces-14142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D48CC821850
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 09:26:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FBB01F21D43
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 08:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0144646BC;
	Tue,  2 Jan 2024 08:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Ns61RSis";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="J/3ubEQS"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52AA0468E;
	Tue,  2 Jan 2024 08:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 93f8e11ea94811ee9e680517dc993faa-20240102
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=IQPWnM3n4hAzrH3tsrDEvo6suXoJsA7mNXzz3NyzuFk=;
	b=Ns61RSiskUA2VHjESRAcc7LZGcvahcOzDoMZMlFUsOBF+wSjxfHGI/YeA6+9Oe+JZKLrxoProcByheAZAu+VhAKIM7eFA8OCJzVWoz+M5jDMplucrVDwm/UUdS5TYrWm9PO+aWTv5ltvguvjgRZHGxd33ovi7zWFdacBm0YiGNk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:363f2fc2-5ba9-4cf7-8a6d-03a483e7603f,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:4da1cc8d-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 93f8e11ea94811ee9e680517dc993faa-20240102
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1996536352; Tue, 02 Jan 2024 16:26:08 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 2 Jan 2024 16:26:06 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 2 Jan 2024 16:26:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RZVc133p1rakvqmQraYYDILt9wcOhr9oLnP5wT1Ny1yvIeYy1wGSxGcp610veYkqMuOoExUiAk7Rrybbk3Qq8ExyxjKae1VNhswD8cD+4YncVG3DvokYTFWNHsXddLkao4xJm2HQDhb4RTFWVdEfIZ9zFFQk9NnsCQgDBrLNqquZQyqKuJSwKIQhSH1E3CKNgdvgkhx+8uj72Yo0R560rKkGGsXhSgy1l18ms4taZ03pPKHuZjmngz3jYmOq9/ZC+2Bfgm454e40D6Z9EFdxQlYmOlOrHPrd/izKYLCUi3helKSw6EDXTaDkAu2MWnE6iLmlHvZaWS5D/2TbeGOjeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IQPWnM3n4hAzrH3tsrDEvo6suXoJsA7mNXzz3NyzuFk=;
 b=FCSfQtG15rheMu+WYe3hxSChaG29iDx9+AVkwQy8/hIIOQHQYu2wUX7yy/qHXQyqx1uXgCAEfiaMlJWAahJPbpJmOUZW5eJgU5bHQpaZdQMKJzyx4G1Iymz0XZee3ZUyDn0kVWDRjQeR5xNaoFi8aJ9VJfzIZHRJFXbEWDhXy78crGlnlJikkf6O+g7rrY4pU78p2UBBcAANtPMlj/Dn8j99vJnKOFxjJ6f8rxGXCP07O2jo0UTRDcFefaISAFqCyFsLycq3D/QIek69MQ6Xn2bomh+Rfmd+MAs4ePf/X8zBH+PGao5aADfv7nm+eb9oZq1mGVI700TefdIVWf+ZnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IQPWnM3n4hAzrH3tsrDEvo6suXoJsA7mNXzz3NyzuFk=;
 b=J/3ubEQSm3MgkVePPSafu1Vh0ACXvbqCMXTOA4j/cSZFElVT/cyDUYMe0PCwMMFpJY77wbGWQMftCAfeQqLPQ+KdDdDYs+ONKpaNHjWaJ9ogNl/jcMgqdsI+Ksxd1hgmlDQDUbzlL2bcDDJTSz6TW9eLQwikU+XCQlMR749EiMA=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TY0PR03MB7000.apcprd03.prod.outlook.com (2603:1096:400:27e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 08:26:03 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::eb43:57cb:edfd:3762]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::eb43:57cb:edfd:3762%7]) with mapi id 15.20.7135.023; Tue, 2 Jan 2024
 08:26:03 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= <Shawn.Sung@mediatek.com>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "chunkuang.hu@kernel.org"
	<chunkuang.hu@kernel.org>
CC: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "wenst@chromium.org" <wenst@chromium.org>,
	=?utf-8?B?QmliYnkgSHNpZWggKOisnea/n+mBoCk=?= <Bibby.Hsieh@mediatek.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "daniel@ffwll.ch"
	<daniel@ffwll.ch>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"airlied@gmail.com" <airlied@gmail.com>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "sean@poorly.run" <sean@poorly.run>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, "fshao@chromium.org"
	<fshao@chromium.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v4 16/17] drm/mediatek: Fix errors when reporting rotation
 capability
Thread-Topic: [PATCH v4 16/17] drm/mediatek: Fix errors when reporting
 rotation capability
Thread-Index: AQHaLPWZwjDA6QrbXki1E+NyllZnIbDGULkA
Date: Tue, 2 Jan 2024 08:26:03 +0000
Message-ID: <2022d3d5de21167355929590cb5d6687aa1b4d29.camel@mediatek.com>
References: <20231212121957.19231-1-shawn.sung@mediatek.com>
	 <20231212121957.19231-17-shawn.sung@mediatek.com>
In-Reply-To: <20231212121957.19231-17-shawn.sung@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TY0PR03MB7000:EE_
x-ms-office365-filtering-correlation-id: 6e954c73-4ec8-427a-b153-08dc0b6c7592
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q2qHfdmPga4Y6fAfBo1jokFWemMR16/Lxohc3PmAEZUlvisu6p/yZflq0gVdvCy2sf9XRpHEr1UhQjwqVsAFjp67lLJs8d92cbJFFkUGzhF87P6ERkWDIIWH9w83mmyxIIIquiQ7H5J3/5wkTB+SBQsHfhBuo4z69OP+ojE4Kl5nL7SEjQRS7RVBdDoN+lC77pYNGxxoWlHJoRNOjZvLG5Erd5/X9O8x63+xi3qeWlSnHBA+B7XLv5NhGgRRFbzCcBSpQwmV61jr8n6Hvq7XgvPbuEb4KPLJPGaiUzjQfUbbVqT1WqJV0pfIuFjIIrcxAEMPIaiv4fKyso77ax/WgqJMapj2fIAly73TXBYO4T/qjmU4XgsEhRxRMChAbMoNRHUZk0AmzjKPMLRODTmM1qTv4C65xa+0uxuSSBeZnlYSYiC9CTo1Wc71Ptn80U1RL4UgXRqH94cPsuNXZ81wPWIFInnSmDt5vAYdPeUh15Qmqbw//ZD0ElMlCIQiLysOlpfSzr9ELcqYICqqDoRtVHRu2umRTnOBT3ghZZttMZw1NE/0q7cr8bbqtbj90XbjRaFfPhvTVKzHbjShVO35PUzk+7sTWmMj7QF++4bidCHGBa5JN1o7XUC54fhs6/qe/lNWov0fPc4KbhU1GIhrQ4s7KYgKtsiDTjnlmhpxowM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(346002)(136003)(366004)(39860400002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(2616005)(26005)(83380400001)(71200400001)(6506007)(6512007)(7416002)(5660300002)(4326008)(2906002)(41300700001)(4001150100001)(66946007)(6486002)(478600001)(54906003)(316002)(76116006)(8676002)(8936002)(64756008)(66446008)(66476007)(66556008)(122000001)(110136005)(86362001)(38100700002)(36756003)(85182001)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RUVDTktpdmFUS08xNVpvN3dmekdOZVErcHpmQkt1Kzg3OGNoSC9KTE52VGg4?=
 =?utf-8?B?NzlUbWZrUWU5TVE0d0luS29ZZlRYYnhFTkJ1bXQwYnVyb2lCSm1BbDFCRzc3?=
 =?utf-8?B?Z2JFZFBKUktNbFNwQnJralZRdWlVODVjSENDSndVUmk1ajJkMVRrSHMxOWhF?=
 =?utf-8?B?dTRoOENrRlpDWTdBNy9mcUJmK2wzYUJsSXFheThGNktJNjZqUmlyRmx1bXhP?=
 =?utf-8?B?dEsvZ1Y0bW1ZdzJPY3ZuVGlHRXVHaU91Yk1qL2oxZjNFb1JpdjZ6U09EYXBR?=
 =?utf-8?B?UzV1UTY5amVJaVprcktiVm5Mc0V5V3MrTUIreEh3VWw0UGJUU3JHWU1sN044?=
 =?utf-8?B?SkwwajBWQVo5dXAyeERMUVFBeVdEelFHNWdBY1IvK2pra2Ivd3FycjI5Mm13?=
 =?utf-8?B?dzVXMHZJZUhqaWFsM0pPUUsvYXZWRGQ5TWNPYjJaQ3pDM2tWcWlDRHpsdUNK?=
 =?utf-8?B?a2JlMWhVWi9GRVFFbHhRU2ZrTUN6K1B2dEgzeHJ2MzNINFQzZkFOalJkcGVL?=
 =?utf-8?B?bjVsVGo4dWYxQm54bFFSZ1JkVmNUQ1FOV3UzV0luWldoYzZkTmRnaytrcEU2?=
 =?utf-8?B?OWIvNnNlTmloaHoyL2Ftcno1QUtoT2Y0WlRibXBZckRCKzJ3bzZUZ1hZZkJU?=
 =?utf-8?B?VGhhT1FGVk1PTldVSDNuTXQ5MTFpOXBtSENHdmxrdGhyV0JwS2RVZzRIbWRE?=
 =?utf-8?B?Y3MvNXQ3VUFWK0ZyNkhwWUlFOVdrS2dIczFUN0xDTHBCOVhQY0t4eHRuQnVa?=
 =?utf-8?B?ZUthaHVHLy9FR0ZhMkVsRDZPNjl2MWdKdXRCQWdSUDFSYnJudURkYWFNM3lx?=
 =?utf-8?B?cE5iMERnK3BxTE9hYjhRZmZUWnpqNHBTZlZYS2Z4dElJSDdiRm9tUUNiV2Zp?=
 =?utf-8?B?U0VLbW53K1A2WEFDSEQzZmpiSE9oQlZMcTBBTUZiMUdoV2ExTTQrMWpBNy80?=
 =?utf-8?B?NmpZdGd0MWxOZk0waU9LTGEvMjdHUCtsU2xwZnNNdHhNVGl5cEtaSGxZM3Vr?=
 =?utf-8?B?RkVvM2J5UUI0RHQzMFNISm11TU14WXQ2SHl2b1MvOFVFL2hSNWtaZXkzTlRW?=
 =?utf-8?B?TkRiRjllUnc2S1oxLzNZZ3M3UEduTzJkVEN6SFd0aUM5TGVhemlReTE2cU5v?=
 =?utf-8?B?TWpybG9HZWtoTkE3RG5WZGp1L2VGaDYrSzBya1FsejNJL2lJa2lQdEp6UDRX?=
 =?utf-8?B?M2xvQm13NlZEOXp2T2dEaUtFbDY4YmlsVGE3UkZRTlkwdTQ1dEE5V1RvM2Ix?=
 =?utf-8?B?bmkwbHVVeHFvZ1h5enRTNHFDSzgyamlvSWZHMFJCWFk5Ym9UeFZOcnNoWThL?=
 =?utf-8?B?bUdzdWxPY0NlREdGVEhMWU9kd25rU0p2aVJZVTRJU1VDUzlwb0NYYjE5aXVw?=
 =?utf-8?B?L1A4L1NhTWlCUUJzVkpGRURVSzV4M2tjZ2tPbXhESUJGMDdxOGFNZys3Z1Zr?=
 =?utf-8?B?bXIrV29xdlRVZVNKYzJGZEtCWVlhZEc2cVJxTWFweFdFdnF6L0NFbTFWcXhV?=
 =?utf-8?B?UnExSjAzRXUzbTBza2tvZHg1bDE4VDQ5WjZlTWdWVU5oQWZWaVd5MjdHbUJo?=
 =?utf-8?B?OGRORUVMc0sxdk5nWXhudEdyczdSRW9RcmFXYUZQQ1RaL0prdEFhWTc0MkJo?=
 =?utf-8?B?WEdvU0VWRHR6b3FURzhFdFdmUzRsR1dpQklkMnl3SERhTG1pZzFWZEVlOGxL?=
 =?utf-8?B?dXZzNU5ON3p3c2JQdks4czQ0STB4ZmR6S1IwSGFHdEJvUlowaFZ3c3dOQkRq?=
 =?utf-8?B?bWZDeTlpbmJzbVF3NkpscWVDeVdLYUhIVm9nWWlsc2VIOEI1OWtQbkRwYTVO?=
 =?utf-8?B?WHBLNEhTamNiUzdmbU1YRWJyeWZzSlpWSlUzdERZc2ZTeFBuak9WZVA5RS9T?=
 =?utf-8?B?M2xRMm9qNWVZL2p0alE5emRDK2E2ZytCdnhITjZmcEtlR2d2citxSmtiQWtu?=
 =?utf-8?B?YndHS2JReWNxSjNqdm0vWGdiQUMxUlNkRHJvVEU0MlpSZ1k4QzFoNjNmeDN1?=
 =?utf-8?B?bm9nR0J3SmUxWmlNN3ZrcnRScFVtWVJ5OGRCSFJXUkR3aWwwNThSOW5YSlBC?=
 =?utf-8?B?L3I3WXcyTFErcE5iTUR3UGEyUUFsQXNRQjBMQk5LN0F4QjVqb0dkVlAvNXBr?=
 =?utf-8?Q?7sRqvhuffDMA9NSP3996O1+M/?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8B2BF214E8F907488CDB22EA63AFD1E7@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e954c73-4ec8-427a-b153-08dc0b6c7592
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jan 2024 08:26:03.6213
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V4KdIewzzPEtZndlar6yji3Xwe9Jb7qhQJG3MtDU1ONLLPMXTyV6LGyg5+xwWfoWZ0EdPcsP2vu0EXVIDQeChw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB7000

SGksIEhzaWFvLWNoaWVuOg0KDQpPbiBUdWUsIDIwMjMtMTItMTIgYXQgMjA6MTkgKzA4MDAsIEhz
aWFvIENoaWVuIFN1bmcgd3JvdGU6DQo+IENyZWF0ZSByb3RhdGlvbiBwcm9wZXJ0eSBhY2NvcmRp
bmcgdG8gdGhlIGhhcmR3YXJlIGNhcGFiaWxpdHkuDQo+IFNpbmNlIGN1cnJlbnRseSBPVkwgb2Yg
YWxsIGNoaXBzIHN1cHBvcnQgc2FtZSByb3RhdGlvbiwNCj4gbm8gbmVlZCB0byBkZWZpbmUgaXQg
aW4gdGhlIGRyaXZlciBkYXRhLg0KPiANCj4gRml4ZXM6IDg0ZDgwNTc1Mzk4MyAoImRybS9tZWRp
YXRlazogU3VwcG9ydCByZWZsZWN0LXkgcGxhbmUNCj4gcm90YXRpb24iKQ0KPiANCj4gUmV2aWV3
ZWQtYnk6IEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vIDwNCj4gYW5nZWxvZ2lvYWNjaGluby5k
ZWxyZWdub0Bjb2xsYWJvcmEuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBIc2lhbyBDaGllbiBTdW5n
IDxzaGF3bi5zdW5nQG1lZGlhdGVrLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVk
aWF0ZWsvbXRrX2Rpc3BfZHJ2LmggICAgICAgIHwgIDEgKw0KPiAgZHJpdmVycy9ncHUvZHJtL21l
ZGlhdGVrL210a19kaXNwX292bC5jICAgICAgICB8IDE4ICsrKysrKy0tLS0tLS0tDQo+IC0tLS0N
Cj4gIC4uLi9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX292bF9hZGFwdG9yLmMgICAgfCAgOSAr
KysrKysrKysNCj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2RkcF9jb21wLmMg
ICAgfCAgMSArDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9wbGFuZS5jICAg
ICAgIHwgIDIgKy0NCj4gIDUgZmlsZXMgY2hhbmdlZCwgMTggaW5zZXJ0aW9ucygrKSwgMTMgZGVs
ZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210
a19kaXNwX2Rydi5oDQo+IGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX2Rydi5o
DQo+IGluZGV4IDRkNmU4YjY2N2JjMy4uYzVhZmViN2M1NTI3IDEwMDY0NA0KPiAtLS0gYS9kcml2
ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfZHJ2LmgNCj4gKysrIGIvZHJpdmVycy9ncHUv
ZHJtL21lZGlhdGVrL210a19kaXNwX2Rydi5oDQo+IEBAIC0xMjcsNiArMTI3LDcgQEAgdm9pZCBt
dGtfb3ZsX2FkYXB0b3JfcmVnaXN0ZXJfdmJsYW5rX2NiKHN0cnVjdA0KPiBkZXZpY2UgKmRldiwg
dm9pZCAoKnZibGFua19jYikodm8NCj4gIHZvaWQgbXRrX292bF9hZGFwdG9yX3VucmVnaXN0ZXJf
dmJsYW5rX2NiKHN0cnVjdCBkZXZpY2UgKmRldik7DQo+ICB2b2lkIG10a19vdmxfYWRhcHRvcl9l
bmFibGVfdmJsYW5rKHN0cnVjdCBkZXZpY2UgKmRldik7DQo+ICB2b2lkIG10a19vdmxfYWRhcHRv
cl9kaXNhYmxlX3ZibGFuayhzdHJ1Y3QgZGV2aWNlICpkZXYpOw0KPiArdW5zaWduZWQgaW50IG10
a19vdmxfYWRhcHRvcl9zdXBwb3J0ZWRfcm90YXRpb25zKHN0cnVjdCBkZXZpY2UNCj4gKmRldik7
DQo+ICB2b2lkIG10a19vdmxfYWRhcHRvcl9zdGFydChzdHJ1Y3QgZGV2aWNlICpkZXYpOw0KPiAg
dm9pZCBtdGtfb3ZsX2FkYXB0b3Jfc3RvcChzdHJ1Y3QgZGV2aWNlICpkZXYpOw0KPiAgdW5zaWdu
ZWQgaW50IG10a19vdmxfYWRhcHRvcl9sYXllcl9ucihzdHJ1Y3QgZGV2aWNlICpkZXYpOw0KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX292bC5jDQo+IGIv
ZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX292bC5jDQo+IGluZGV4IDc4NzQ5ZGFi
ZWI0My4uZjAxOTczNzA3OGY2IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0
ZWsvbXRrX2Rpc3Bfb3ZsLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19k
aXNwX292bC5jDQo+IEBAIC0zOTksNiArMzk5LDEwIEBAIHVuc2lnbmVkIGludCBtdGtfb3ZsX2xh
eWVyX25yKHN0cnVjdCBkZXZpY2UNCj4gKmRldikNCj4gIA0KPiAgdW5zaWduZWQgaW50IG10a19v
dmxfc3VwcG9ydGVkX3JvdGF0aW9ucyhzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ICB7DQo+ICsJLyoN
Cj4gKwkgKiBhbHRob3VnaCBjdXJyZW50bHkgT1ZMIGNhbiBvbmx5IGRvIHJlZmxlY3Rpb24sDQo+
ICsJICogcmVmbGVjdCB4ICsgcmVmbGVjdCB5ID0gcm90YXRlIDE4MA0KPiArCSAqLw0KPiAgCXJl
dHVybiBEUk1fTU9ERV9ST1RBVEVfMCB8IERSTV9NT0RFX1JPVEFURV8xODAgfA0KPiAgCSAgICAg
ICBEUk1fTU9ERV9SRUZMRUNUX1ggfCBEUk1fTU9ERV9SRUZMRUNUX1k7DQo+ICB9DQo+IEBAIC00
MDcsMjcgKzQxMSwxNyBAQCBpbnQgbXRrX292bF9sYXllcl9jaGVjayhzdHJ1Y3QgZGV2aWNlICpk
ZXYsDQo+IHVuc2lnbmVkIGludCBpZHgsDQo+ICAJCQlzdHJ1Y3QgbXRrX3BsYW5lX3N0YXRlICpt
dGtfc3RhdGUpDQo+ICB7DQo+ICAJc3RydWN0IGRybV9wbGFuZV9zdGF0ZSAqc3RhdGUgPSAmbXRr
X3N0YXRlLT5iYXNlOw0KPiAtCXVuc2lnbmVkIGludCByb3RhdGlvbiA9IDA7DQo+ICANCj4gLQly
b3RhdGlvbiA9IGRybV9yb3RhdGlvbl9zaW1wbGlmeShzdGF0ZS0+cm90YXRpb24sDQo+IC0JCQkJ
CSBEUk1fTU9ERV9ST1RBVEVfMCB8DQo+IC0JCQkJCSBEUk1fTU9ERV9SRUZMRUNUX1ggfA0KPiAt
CQkJCQkgRFJNX01PREVfUkVGTEVDVF9ZKTsNCj4gLQlyb3RhdGlvbiAmPSB+RFJNX01PREVfUk9U
QVRFXzA7DQo+IC0NCj4gLQkvKiBXZSBjYW4gb25seSBkbyByZWZsZWN0aW9uLCBub3Qgcm90YXRp
b24gKi8NCj4gLQlpZiAoKHJvdGF0aW9uICYgRFJNX01PREVfUk9UQVRFX01BU0spICE9IDApDQo+
ICsJaWYgKHN0YXRlLT5yb3RhdGlvbiAmIH5tdGtfb3ZsX3N1cHBvcnRlZF9yb3RhdGlvbnMoZGV2
KSkNCj4gIAkJcmV0dXJuIC1FSU5WQUw7DQo+ICANCj4gIAkvKg0KPiAgCSAqIFRPRE86IFJvdGF0
aW5nL3JlZmxlY3RpbmcgWVVWIGJ1ZmZlcnMgaXMgbm90IHN1cHBvcnRlZCBhdA0KPiB0aGlzIHRp
bWUuDQo+ICAJICoJIE9ubHkgUkdCW0FYXSB2YXJpYW50cyBhcmUgc3VwcG9ydGVkLg0KPiAgCSAq
Lw0KPiAtCWlmIChzdGF0ZS0+ZmItPmZvcm1hdC0+aXNfeXV2ICYmIHJvdGF0aW9uICE9IDApDQo+
ICsJaWYgKHN0YXRlLT5mYi0+Zm9ybWF0LT5pc195dXYgJiYgKHN0YXRlLT5yb3RhdGlvbiAmDQo+
IH5EUk1fTU9ERV9ST1RBVEVfMCkpDQoNCllvdSBzdGlsbCBubyBleHBsYWluIHdoYXQgeW91IGRv
IGhlcmUuDQoNCj4gIAkJcmV0dXJuIC1FSU5WQUw7DQo+ICANCj4gLQlzdGF0ZS0+cm90YXRpb24g
PSByb3RhdGlvbjsNCj4gLQ0KPiAgCXJldHVybiAwOw0KPiAgfQ0KPiAgDQo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bfb3ZsX2FkYXB0b3IuYw0KPiBiL2Ry
aXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9vdmxfYWRhcHRvci5jDQo+IGluZGV4IDQz
OThkYjlhNjI3Ni4uMjczYzc5ZDM3YmVmIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0v
bWVkaWF0ZWsvbXRrX2Rpc3Bfb3ZsX2FkYXB0b3IuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0v
bWVkaWF0ZWsvbXRrX2Rpc3Bfb3ZsX2FkYXB0b3IuYw0KPiBAQCAtMzgzLDYgKzM4MywxNSBAQCB2
b2lkIG10a19vdmxfYWRhcHRvcl9yZWdpc3Rlcl92YmxhbmtfY2Ioc3RydWN0DQo+IGRldmljZSAq
ZGV2LCB2b2lkICgqdmJsYW5rX2NiKSh2bw0KPiAgCQkJCSAgICAgdmJsYW5rX2NiLCB2Ymxhbmtf
Y2JfZGF0YSk7DQo+ICB9DQo+ICANCj4gK3Vuc2lnbmVkIGludCBtdGtfb3ZsX2FkYXB0b3Jfc3Vw
cG9ydGVkX3JvdGF0aW9ucyhzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ICt7DQo+ICsJLyoNCj4gKwkg
KiBzaG91bGQgc3RpbGwgcmV0dXJuIERSTV9NT0RFX1JPVEFURV8wIGlmIHJvdGF0aW9uIGlzIG5v
dA0KPiBzdXBwb3J0ZWQsDQo+ICsJICogb3IgSUdUIHdpbGwgZmFpbC4NCj4gKwkgKi8NCj4gKwly
ZXR1cm4gRFJNX01PREVfUk9UQVRFXzA7DQo+ICt9DQo+ICsNCj4gIHZvaWQgbXRrX292bF9hZGFw
dG9yX3VucmVnaXN0ZXJfdmJsYW5rX2NiKHN0cnVjdCBkZXZpY2UgKmRldikNCj4gIHsNCj4gIAlz
dHJ1Y3QgbXRrX2Rpc3Bfb3ZsX2FkYXB0b3IgKm92bF9hZGFwdG9yID0NCj4gZGV2X2dldF9kcnZk
YXRhKGRldik7DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Ry
bV9kZHBfY29tcC5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZGRwX2Nv
bXAuYw0KPiBpbmRleCBmZmE0ODY4YjEyMjIuLjIwNmRkNmY2Zjk5ZSAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZGRwX2NvbXAuYw0KPiArKysgYi9kcml2
ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHBfY29tcC5jDQo+IEBAIC00MjIsNiArNDIy
LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfZGRwX2NvbXBfZnVuY3MNCj4gZGRwX292bF9h
ZGFwdG9yID0gew0KPiAgCS5yZW1vdmUgPSBtdGtfb3ZsX2FkYXB0b3JfcmVtb3ZlX2NvbXAsDQo+
ICAJLmdldF9mb3JtYXRzID0gbXRrX292bF9hZGFwdG9yX2dldF9mb3JtYXRzLA0KPiAgCS5nZXRf
bnVtX2Zvcm1hdHMgPSBtdGtfb3ZsX2FkYXB0b3JfZ2V0X251bV9mb3JtYXRzLA0KPiArCS5zdXBw
b3J0ZWRfcm90YXRpb25zID0gbXRrX292bF9hZGFwdG9yX3N1cHBvcnRlZF9yb3RhdGlvbnMsDQo+
ICB9Ow0KPiAgDQo+ICBzdGF0aWMgY29uc3QgY2hhciAqIGNvbnN0IG10a19kZHBfY29tcF9zdGVt
W01US19ERFBfQ09NUF9UWVBFX01BWF0gPQ0KPiB7DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9wbGFuZS5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL21lZGlh
dGVrL210a19kcm1fcGxhbmUuYw0KPiBpbmRleCBmZjMwMDQyNmI1OTAuLmU3M2I5NzkzZGVlMiAx
MDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fcGxhbmUuYw0K
PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9wbGFuZS5jDQo+IEBAIC0z
NDMsNyArMzQzLDcgQEAgaW50IG10a19wbGFuZV9pbml0KHN0cnVjdCBkcm1fZGV2aWNlICpkZXYs
IHN0cnVjdA0KPiBkcm1fcGxhbmUgKnBsYW5lLA0KPiAgCQlyZXR1cm4gZXJyOw0KPiAgCX0NCj4g
IA0KPiAtCWlmIChzdXBwb3J0ZWRfcm90YXRpb25zICYgfkRSTV9NT0RFX1JPVEFURV8wKSB7DQo+
ICsJaWYgKHN1cHBvcnRlZF9yb3RhdGlvbnMpIHsNCg0KVHJ5IHJlcG9ydCBpc3N1ZSB0byBJR1Qg
dGVhbS4NCg0KUmVnYXJkcywNCkNLDQoNCj4gIAkJZXJyID0gZHJtX3BsYW5lX2NyZWF0ZV9yb3Rh
dGlvbl9wcm9wZXJ0eShwbGFuZSwNCj4gIAkJCQkJCQkgRFJNX01PREVfUk9UQVQNCj4gRV8wLA0K
PiAgCQkJCQkJCSBzdXBwb3J0ZWRfcm90YQ0KPiB0aW9ucyk7DQo=

