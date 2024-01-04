Return-Path: <linux-kernel+bounces-16325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61AE6823CDB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 08:42:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C50381F24F98
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 07:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA2A1F93C;
	Thu,  4 Jan 2024 07:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="U0ePSUVC";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="lFFgFUjr"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F3C1F610
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 07:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: d1cb500caad411eea2298b7352fd921d-20240104
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=pxFx03DqT7/9dXr2Po3hieDJ4FuxqZQBgfTlGJVBc4M=;
	b=U0ePSUVC44NQIEm4VWMaVIa0K9HcrvVsctaM4dGVnOEC21dCZKKfkaOdna0pT0pV+AcHqB4+T6C6hJe+GqZrErtOCM02+tsJmHx8Em/nVZNsWNFB7ArQhp6WbbjNgxP13fNn6Dm7I3y0j8j1TJ5mS4ur4fvhOdgfgEoYLTtBQfU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:3c1c1790-8390-4546-8e56-510e8e2ca44b,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:eaf8cb2e-1ab8-4133-9780-81938111c800,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: d1cb500caad411eea2298b7352fd921d-20240104
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1686251088; Thu, 04 Jan 2024 15:42:32 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 4 Jan 2024 15:42:30 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 4 Jan 2024 15:42:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gkse3/fNKFu62wuVPWmKSjkQ5859+qAeCdlYT5AC0Q1zt6GGtsYK8jwqVvYgDiiTjlTxJIyiET2c01+Cm22pAiytIfEScVRpXG6fXhoEVS55r104ZXL0XIjwjTwFB7nBzmkT839llw9Ue50SPREs7BpFJ7NklStKc3JrKL/CzHLTA8jAHGyYq8fE+DUKt8WMC/PK+ikuPDouGLs9qSP6ulRSh6y8Zoe4eBhWHjBByUjXI13sIvRhQU0vC8aiioGtD9sDAJlQ1Rxo78J6K3gQCAtOwSdauEaF4HWXWxkpu9fM/JjGqP/envVcTYVTzavnKeucyIeLM8savPMRP++HYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pxFx03DqT7/9dXr2Po3hieDJ4FuxqZQBgfTlGJVBc4M=;
 b=EyQgZwXmbYeuzjvx+E9hguuksMtMxhYSOSJcTJndUBgHv5WkRt3TGiv0TlPI5VnH+EmfVxGBNHPUZM0kHuVdocONMTnPYfGmx0VhtKyyygWpGcoZmdRZ5obCTjricjn20kksS8fc04P66wFW38iU98hXirVF6lkzK1K4qcKKc1YB4k29yVSgsrSC502sOwKE6sXei5/tnrC88zPYSNzYWzsJSWBFA8W2pXxgqRS+k1YmJ0XJNPuoJQYjPLoNIalMkVkKLuvSeQcYzfhrs8iPsS85l7Mz7u/8UgWTXrJYs8+hjWKJNxx8M/JAqf2914U1AWfOx1mA7vCQr3uSsHDpcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pxFx03DqT7/9dXr2Po3hieDJ4FuxqZQBgfTlGJVBc4M=;
 b=lFFgFUjrF8XtAnd1tdHvBPgm1kSUVYo83CDexDZcij8dq5p+l+091cxaCW4wGo8ip0oDUEzkbLnoNfKyEETDDHVYMpmFqCYnRMajG7JidS5h1w1p0B5a14dUDfEPe90dkALMiUa+Y66/6bOMfXrkjdGIYDVJ6bCr4zjrjMxzja0=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TYZPR03MB6105.apcprd03.prod.outlook.com (2603:1096:400:12c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.14; Thu, 4 Jan
 2024 07:42:28 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::eb43:57cb:edfd:3762]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::eb43:57cb:edfd:3762%7]) with mapi id 15.20.7159.013; Thu, 4 Jan 2024
 07:42:27 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: =?utf-8?B?TWFjIFNoZW4gKOayiOS/iik=?= <Mac.Shen@mediatek.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
	=?utf-8?B?Sml0YW8gU2hpICjnn7PorrDmtpsp?= <jitao.shi@mediatek.com>,
	"daniel@ffwll.ch" <daniel@ffwll.ch>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "airlied@gmail.com" <airlied@gmail.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	=?utf-8?B?U2h1aWppbmcgTGkgKOadjuawtOmdmSk=?= <Shuijing.Li@mediatek.com>
Subject: Re: [PATCH] drm/mediatek/dp: Add the HDCP feature for DisplayPort
Thread-Topic: [PATCH] drm/mediatek/dp: Add the HDCP feature for DisplayPort
Thread-Index: AQHaHrPjdunoffcOCEGmErF8vNrJIrDJhbiA
Date: Thu, 4 Jan 2024 07:42:27 +0000
Message-ID: <831f9d14e3f96ca95db01e2340553a1d83075373.camel@mediatek.com>
References: <20231124085346.26602-1-mac.shen@mediatek.com>
In-Reply-To: <20231124085346.26602-1-mac.shen@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TYZPR03MB6105:EE_
x-ms-office365-filtering-correlation-id: e289dfce-34b3-42ee-feb7-08dc0cf8b349
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yC5XR5yyhBRxfg+381babMsX1lZO+TBzuRIngsGVPUsmFt5n4Re/wIaFi3B8QR4QKUowrwB32F6XMtKAAvZ4xioB3xeF5cCG7w/rv5oor5KDpnzISM/xK7DLophGPFS5XiE1DPqZCun0c/c9JxkNKFo0FVbT2HKcZtFCMUodtQ2yevXSq05aTvV+S4sTmZZEYXIy2Okje78cSdJQyFFBJ9gLyl3KnK56l3kKji6X9E4mz80Vfs8K8gDFIkmeRCat/eekx1wJ8WJFXqPe4mOP/ZNsrjyrAbWWytjwuswjILKRxkR+boNGlj0rYsVqkgVvEaKCaNZ2Xwh+Ec63RrHxO2ydcndw5ofUAxHgwvSvHQ35rFQOEHo0UfFCbmkPIgtUhLrmCJPwDprJ8E9srbLJ69jdUd120SST6Fs+xQG9/iP6IRfUzrGYM/OhnMZltg1HpXUug3QJGzvcm3tdPFma0dZjVWNl5v9l+2Lr4Ur1dWctS9pZ2tG6epZ1rBmzJQBQpnT54expgN92znXqcEbO72Qd+dvijpZcye2HRqHooYvef1sIu5Ot2XWnPMSgvPrk/uQ+gADOSR8ifRadDIOWFhMBt8nY2BStFuikrN+rWW88HjFFfOAHEKP6f8U8YiDe2di68BfCXL9BtiRrHQromYEsSYIuHPRzg8/asxwU/I0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(136003)(39860400002)(396003)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(38100700002)(122000001)(38070700009)(85182001)(36756003)(86362001)(6512007)(71200400001)(6506007)(478600001)(6486002)(4326008)(2616005)(66446008)(26005)(66946007)(76116006)(64756008)(66476007)(54906003)(66556008)(110136005)(316002)(8676002)(8936002)(107886003)(41300700001)(7416002)(5660300002)(2906002)(4744005)(4001150100001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R0ovQ3ByV0Z4VkErVGt2c3JpbVd3ck5XMmlESlJwSFdzbjBLakdrTzhsRmxm?=
 =?utf-8?B?UFNXL2NsdmxHb05mMlE1NzBER2hzQUx0NkJaRDdycUttcGdrN2tKQ1VKSEZh?=
 =?utf-8?B?QXZQenhmV0N4bmhuU04reWVVUnVnZW1Xd2ZXU1hZVFNicVl5VlVsWk8rZG9z?=
 =?utf-8?B?ZVhGS3BZYTQxZzMwM2dnV21lY3pmN1JmamV3OXppSXJra2R4UjdSaWZIaUFs?=
 =?utf-8?B?R2k3YjFJdWpUYU5IbEFaSW8wbXJMdWdCQ1VibTJZYStmOHdoZFFrc0pYb1BI?=
 =?utf-8?B?SGV0OVRkbGUxVkgwZ0NyMFJIM2dvR2RpR1psSmExSUpLcW5lU0V0dnMrY1R3?=
 =?utf-8?B?cm9OdERkbDlOMzBDb3BhZjJVSWh1K2lIc2ZhdWtqVlBpS0xXc0pWaHFHTWR4?=
 =?utf-8?B?MWNlYWhsamFuYW1nVzdZczJpbHFlL1NDYzl2QzlDblZMaGxRaE1YMHB0ajI5?=
 =?utf-8?B?WFFxV1AycWMwZGlUM09DT1NLM2w4RlZsZ1RYZCt4enUzYmJuR3ZaRXI2b0pG?=
 =?utf-8?B?RitFRVZyZWY2L3R6M3VBaDY0Z2p4N3NUejVFUkdLYWxtNkNwQUJBMnFvdVZz?=
 =?utf-8?B?YlBVVXRNcVg1R2cycDBYTFVMZGZWUmFqRys5aVZEUFhtbkd2N09LY2NYOUFR?=
 =?utf-8?B?blpBU2hXUytsWHBOOGh0YUxWNk9IQWxINHVIaFo4T2E1TFQvMXZ1QlZsTlBr?=
 =?utf-8?B?QlkwdHNIenZhTHZsUUZ6UTY0bDRuczdHWjZ2OWJKZldoSSt1ZTJkQkFEdURn?=
 =?utf-8?B?Sy9nN0VZaTFzdXp5QUpqN3ROd3lsQmwzYkoxMVBlUks5TDlnWUVCRGVMcnFi?=
 =?utf-8?B?Tis2MkpuTGVKWnh3RHAvWUlPWFhxTzVoZEJwcFVuZGJIZTZHczZRRWx4c0xj?=
 =?utf-8?B?c05NRzcrU2VqbG1qZk04aFBQZzZFb0E5UUdVbnpOZnBYR08zdWU4SHEyYU12?=
 =?utf-8?B?ZlNmUFYyRFhoVmFHT1M3Q1JtVm9ZMitMYXRRSXN5UUE2b1JTRC9tb3Q0VlJm?=
 =?utf-8?B?aHBkUG83TDN6ejNrVnJOdm5WWFZ1eHhFYU9QYnFHQisvMUJqd2VEU2E4aWVx?=
 =?utf-8?B?Z0Z6TE9jMXAwZkV5M09zUHd1YzlRaFh5bmwxaThnY0wxZHNEODVwLzRodDk2?=
 =?utf-8?B?a24rU3VZazFUU1JGSTJSSytYRVR1SVgvcVBFbktmSWJQUG5pQUcyNGl4VkNN?=
 =?utf-8?B?Uk1MTURrRHVSZjRaS2dkVTNjL2ZReG9QZUZ5VFN1c3YyTyswM1Q0OStucXR4?=
 =?utf-8?B?bFREWVhmYkw3V0lLSXBIQ0FOZ0JzR0ljT3JnWEVpZDArZVNaNmw2alo3NHlN?=
 =?utf-8?B?U3VTTnM2K3ZBVWVXczArbFJRdFNWUExnUnRrdlpJV3Ria2xNZnZZSUl5b2g4?=
 =?utf-8?B?N01Lc3g3ZzRhaWdYaFRrUFVZcXdxdlk4ZDJCRGcwcGEvZXkyU3k4eEo3aGxO?=
 =?utf-8?B?Y1VCRlBSVkxSKzd0STV0QUV0bHhwTXc3S2g0aTdoei90TFpvMDJIQXB1R0sz?=
 =?utf-8?B?V3ZTRXFPd0F1L0lvQU0yS2IyVk45KzVMV0dLWGJsanhOa1BCRVNLcTMxUC9s?=
 =?utf-8?B?UUdWbjhZeWw4S2Z2Q0Z1MEVmdjVKdHQrTzVUNC90VDlFa0ZrQ1V6dXNsR1Z0?=
 =?utf-8?B?bjU2ak5WckttcHNuQ0gxTW1qVVJzZG1jSlpudXdHNXVQN3JuaGtGZGVlYjYx?=
 =?utf-8?B?VDZ5UTZFVlJpdzl3SCtNVHZUUEp5c0ExQmNqTDRkMlZaOUREWTh3aFUvWVhX?=
 =?utf-8?B?UDdEK0tmbjZJQWptNzVSYlNRZXFHcWR0NnJGVmJFRURhd0lNbGxiM1k2cGI3?=
 =?utf-8?B?NHoyUVJpdEtLTmhORUhWYVgrR0p5dUFyVEJCT0dtNkJRRG1JZVRZMzVlb1dk?=
 =?utf-8?B?NSs4UkV0SzZNY1NuR0xuN1lSQitKR3VUdkZCV0NkTmxkOEZhT24wd2RRZy9G?=
 =?utf-8?B?Z1ZHVVVJbmN2cTQ1TGZEVWR6QkM5SlZvQzJpbXVkZEN4cm8vLzYxMWZHUGZW?=
 =?utf-8?B?QUNiY2p4WXBhbGJ5bVJmZGVScGoyeDhHNFZlOGRtWk8zajY5VHJnWlAybEor?=
 =?utf-8?B?dWlQb3V6YjVaUDcxRXNseGZrWHQ0VS9mYlZTUUdwUWxGNXlVajZ3RGFqUWVI?=
 =?utf-8?Q?In/ssNjv21CaNoxgyc38M+LJA?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <128BBA51727D2D448324B55FBFAF639F@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e289dfce-34b3-42ee-feb7-08dc0cf8b349
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2024 07:42:27.8757
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lVwHn7ogPgEOCP4unE34/f+IrUeknPeliropBjYn/+N2YhxuGrffldhsCNVAqPoOqDe7WMlPtt1MUxkrLbZKtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB6105
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--3.885400-8.000000
X-TMASE-MatchedRID: lORh06tOiKjPaPH51LTU5Ca1MaKuob8PC/ExpXrHizxcKZwALwMGs8uj
	Rkt05a7cM2MQQW7DL3j9ZKymw+XXBFdI3z1FMme3ngIgpj8eDcDBa6VG2+9jFGWCfbzydb0g3n8
	eBZjGmUzkwjHXXC/4I66NVEWSRWybGTNwxnNtWCgmFh+mF4douDlcmlzx/3/cT3VXGyl6zjoM18
	OwnqphwnjDPE2419j1AUGRuCMy0tNrhTNl3gaC2mQJxhxqQrUTWv9VEbHQhHb5Sji9er6qbMiLN
	4KwjrADQtSaPIvcNlKofNwo1tlvaw==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--3.885400-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	FEC3B184A52DD07AE957342F637B101C3A61B98D1B24472831A87B42119D69792000:8

SGksIE1hYzoNCg0KT24gRnJpLCAyMDIzLTExLTI0IGF0IDE2OjUzICswODAwLCBtYWMuc2hlbiB3
cm90ZToNCj4gQWRkIHRlZSBjbGllbnQgYXBwbGljYXRpb24sIEhEQ1AgMS54IGFuZCAyLnggYXV0
aGVudGljYXRpb24gZm9yDQo+IERpc3BsYXlQb3J0DQo+IHRvIHN1cHBvcnQgdGhlIEhEQ1AgZmVh
dHVyZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IG1hYy5zaGVuIDxtYWMuc2hlbkBtZWRpYXRlay5j
b20+DQo+IC0tLQ0KDQpbc25pcF0NCg0KPiArI2RlZmluZSBBTl9MRU4gOA0KPiArI2RlZmluZSBB
S1NWX0xFTiA1DQoNCklzIHRoaXMgRFJNX0hEQ1BfS1NWX0xFTj8NCklmIGFsbCB0aGVzZSBsZW5n
dGggYXJlIGRlZmluZWQgaW4gSERDUCBzcGVjaWZpY2F0aW9uLCBtb3ZlIHRoZXNlDQpkZWZpbml0
aW9uIHRvIGluY2x1ZGUvZHJtL2RybV9oZGNwLmgNCg0KUmVnYXJkcywNCkNLDQoNCj4gKyNkZWZp
bmUgQktTVl9MRU4gNQ0KPiArI2RlZmluZSBDRVJUX0xFTiA1MjINCj4gKyNkZWZpbmUgRUtNX0xF
TiAxNg0KPiArI2RlZmluZSBNX0xFTiAxNg0KPiArI2RlZmluZSBFTkNfS01fTEVOIDEyOA0KPiAr
I2RlZmluZSBSWFhfTEVOIDgNCj4gKyNkZWZpbmUgQ0FQU19MRU4gMw0KPiArI2RlZmluZSBSTl9M
RU4gOA0KPiArI2RlZmluZSBSSVZfTEVOIDgNCj4gKw0K

