Return-Path: <linux-kernel+bounces-66509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C4B855DA5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 10:17:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6ECB1F2EEF1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 09:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A836D175AA;
	Thu, 15 Feb 2024 09:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="RbkR+w2Z";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="QdALCmtW"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E730417580
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 09:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707988655; cv=fail; b=NRIRDD0aeHP06iIuCHd23pXgwLeqWrFyHQe9G8vh6cVr3zD1b1niwdBIEEvpR2udHN85SlFxYYpQ61gb99s52Z0W1liaEGmSzCcaUpOTjhmR4pTh34XlIrSG723a998DADgTSUalUeYWmDyZ+1j61Dpw1AHpaMRal6GJyYnhhBo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707988655; c=relaxed/simple;
	bh=eDCIiKrMrAA6ged3GKaS5MWMB9iFi0MW8Q7rRAlVmi8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tIxuxJXp+0Ib3l1hiX5UABOfSgZfw9GZbpX6pf9+wpTtlh33x7eDt/2vy9b8PqV6Q7D1olhnMu9oeKTHbc6jnBtoimo8ZhbqMcwVmu1Wk0EneBpJbIOMe+RR1un95ZTdcaDhjUIC+LCeWUEsGMrW3rC6wFT8i5eXo6U7kqIHreA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=RbkR+w2Z; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=QdALCmtW; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 08f6da90cbe311ee9e680517dc993faa-20240215
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=eDCIiKrMrAA6ged3GKaS5MWMB9iFi0MW8Q7rRAlVmi8=;
	b=RbkR+w2ZmKNhJrR7AjmC3QgQX3jL6et+OicOwFCacSpHzYSbxN74ERzuFVKQ/gUyqQaVH8bhy4qjcch6vbiHgitKWH2fqyDqIU4lsuLctrAdxbx8Iuc6n2zv/iX1c5OBn6wNwP+58JrV1itLFHr1Gdh24Rg14B+w/zfv/HO6Ohg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:950e6cab-0a60-445e-a3ea-c2b1e1be7816,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:91e96a80-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 08f6da90cbe311ee9e680517dc993faa-20240215
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 642306592; Thu, 15 Feb 2024 17:17:26 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 15 Feb 2024 17:17:25 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 15 Feb 2024 17:17:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZiWVX5sLqdwgOdswT5jJ4aATNT3CqH9OswqN2YcYc8avQ2WdMFQXqnBSvOaeuqBz9BYxvf8s2WC7YH4kbyFBaRcR4JXpo6ATBKJVRbUaKSeQJ9pkziEkp1OMy1Af+wgqnfHPm6AoNxNt9QNmDqvjz97uT46l4eKjFFQ31JU0Nl3TarKFzf8NdXvh3ueW6LEw74LpioI4MqiQEtZqSut4Di8RcjOe3RT3sXsgMeuChh8i6SdOjGsD/2f9P0bOHNVbIlpJ6pLzFGrgxD72qwxLKNMD09LSYgAT0LA+S9+05cZHSyR2tHYX5+B8tjfvMbrGRhgkTo8/YTH1gkEskOEqhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eDCIiKrMrAA6ged3GKaS5MWMB9iFi0MW8Q7rRAlVmi8=;
 b=Wscj+wEFN9lzKBh4n+wZkSCeKGHFTFD7C5UTE4YxZRGGNGnFQWHomhq1o8x3AdOwgPqzViUAgg4+MYFNaGqwID+iv22Z5ZOntbhR5RQX/ByxB+rWo0xd5fJgWTvGiBvVj+T9mK1k5fXzwWuBr+8lOEUfNbT4EQMwybzccsfH88Qj0VP/DUCfZ4U2oZmnAt5hwiVcA+nLevy1DnYdA+ShDHvNLGqcTUFw7FO6TbnyR97HtBr65akfWY76Dnn/RuxnSaPp5wluCNk+WVHScFR7RFkgIuQSTaPteDF4p3G2N/OMA9GNsXwKNNbWos3iKiiw4YWY24UmLLT3FmZfXCWmHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eDCIiKrMrAA6ged3GKaS5MWMB9iFi0MW8Q7rRAlVmi8=;
 b=QdALCmtWxc9/Pz5SiqnVC6b78s/PdDI5tSahlvusbksqbjcN9U90oskswT2fxQpaodwA3XeZk8OWQD8C/af8jomYH7tp/z688jX8LI1cqm82BF1Ikey+O4YNXawCMjL+4uew/Lzx2mFz2WT8NuKfqTi5sGUFqf9I80ipceTd5T8=
Received: from SEYPR03MB6626.apcprd03.prod.outlook.com (2603:1096:101:83::7)
 by TYUPR03MB7162.apcprd03.prod.outlook.com (2603:1096:400:346::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.29; Thu, 15 Feb
 2024 09:17:22 +0000
Received: from SEYPR03MB6626.apcprd03.prod.outlook.com
 ([fe80::afa5:be3f:bc79:48fe]) by SEYPR03MB6626.apcprd03.prod.outlook.com
 ([fe80::afa5:be3f:bc79:48fe%3]) with mapi id 15.20.7270.036; Thu, 15 Feb 2024
 09:17:21 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "chunkuang.hu@kernel.org"
	<chunkuang.hu@kernel.org>
CC: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel@collabora.com" <kernel@collabora.com>, "daniel@ffwll.ch"
	<daniel@ffwll.ch>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"amergnat@baylibre.com" <amergnat@baylibre.com>, "airlied@gmail.com"
	<airlied@gmail.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "fshao@chromium.org" <fshao@chromium.org>
Subject: Re: [PATCH v6 7/9] drm/mediatek: dsi: Simplify with dev_err_probe and
 remove gotos
Thread-Topic: [PATCH v6 7/9] drm/mediatek: dsi: Simplify with dev_err_probe
 and remove gotos
Thread-Index: AQHaX+yapHADVVHab0KJh+s4mE8d6bELH7QA
Date: Thu, 15 Feb 2024 09:17:21 +0000
Message-ID: <c18471671dbac2b9018950af105d39a15d8ea68d.camel@mediatek.com>
References: <20240215085316.56835-1-angelogioacchino.delregno@collabora.com>
	 <20240215085316.56835-8-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240215085316.56835-8-angelogioacchino.delregno@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB6626:EE_|TYUPR03MB7162:EE_
x-ms-office365-filtering-correlation-id: 9d7c4916-9d22-4e8b-9703-08dc2e06ea2e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OlV3daQkJYWRcK4xgp/zWTV6aemL0r6h22LpuoAN523Wh5pzUVhWZHPlYN1nL9BQfyU6U2tR+TABYW1xk8RrjtKFcErEqsSW5zs5W1vOE02PZiexhrh65Z2xLNRiS3uyuIv0FFWrDb8vw1ojZfwXCj7YyxEkwQSIA9CfLzhgdhJ1LBNETUE1JIlDvklCT1XXvSNygxuvGLNFRtTNIprYn9ZB9jgpORrxY2o67k8q42g1vA1uEI+SUyds+iAmVXNnT28/C1jxCB6FAvJWKJ5vgoLu7gD8J7/mqvai3dMe00Ga+7QJ5z5/FBLXG2/KdWQ+jWO6u9CV1V3R7cv1nDaEYzXGIvPGHcE5P9Y/2BfZaUv0jXg+ETvGhAXFEKrZBpsMxqBzaUv++gI6AjROGxqdCurozDBin3+S7In4djmCAWWuad7t1YK7wkEq9ksECstkexEuT84W2fv/YvHEb9a1grUi1ygYz7tTmg5R9jWYjDxoMcnprOT3CCO34Nyzvr5SpLBjST+mQDoA64x6V9oDEtonkZAWhIHbYfLUWIm+GYjQ/68u1/gwUHLvHCZwPUKe3QbgXPNcLTBAsjowSb4H8Z5Kl0vgrVzEMB8djwRRLhVYWievu2CvfVDfByw7+kwf
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB6626.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(136003)(396003)(366004)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(5660300002)(66946007)(7416002)(86362001)(2906002)(66476007)(76116006)(122000001)(64756008)(66446008)(66556008)(4326008)(8676002)(8936002)(38100700002)(2616005)(41300700001)(26005)(38070700009)(83380400001)(71200400001)(316002)(36756003)(110136005)(85182001)(54906003)(6512007)(6506007)(6486002)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OVU3bEJmWDl0anY3RXhWQ2tKR1FhVGYrTUNrcFlHTytZNjlUN0pGM01aNzFS?=
 =?utf-8?B?WTliUnR3Z3FjTC9ZYUZNVUlsbHczckVrNGlxWG42cVA5anBNY0VHS1JKT1Br?=
 =?utf-8?B?Uks2NjIyUXNRc0JNTjc5eGkwOG53M0U3aFQrS21oZTc3NCtLVGNIVk9RYSt6?=
 =?utf-8?B?VE5TbDduU2lOSnQ2N0hnUlp6M1k5UkpqVlpSUWd0OG1ZQnBrZmxCaU9PSVR5?=
 =?utf-8?B?TnlvTjE5VUVxZDNQeE1ldVgxL3Q3T0FTNTdjdzRjYVV1Y2dEUmp4TGMya2VT?=
 =?utf-8?B?TWtXR3VKQTlxNVdKRytKOGtjc3phcnhiZXYvSmFaMzlkUDMvdmxMOElheVUz?=
 =?utf-8?B?bnU1U0kxTmJmRXQxc1ZCMkNiWGV3bFZYbXlVenV0MXg0OGxTcGt0Sjgxcy85?=
 =?utf-8?B?QUU2aGpYM1pPSkpmdXNuelJ4YUhzczg0eXZ3c2IyaVlIMmNCSmN2WlE4QlBJ?=
 =?utf-8?B?TnI0OW50SndIT3dPcjhtZGlJYWRUZ2FLL1VWUGpJMStCVlVVZ1N0QTVWc29I?=
 =?utf-8?B?bkF1LytyVUpnRlRLVzVFNFllMmEvME9RRlRubTIzN0F5ZkcxMjhKU2ZDbnlj?=
 =?utf-8?B?SnNWcUhhVHE5NjI0Y25WZnVhclNLY1E0WEZBbUdBUUE5VEhoZGFtVXBKQTlW?=
 =?utf-8?B?ODdsT2h0YzdqS2xIc3NaSmw0dC8zekpybFpZVm1oakc5YWhOeGtaQUpDVG5h?=
 =?utf-8?B?dWpOR2dLdGFBOVNQK2xJWVJHSGhXc1RVNWZRT3hobDZjWFI5Nk14bk9JK0ZC?=
 =?utf-8?B?YTRNS1FtazI3cG54alRHdEIrU2NYekYvMFNUMlh2Qk1LaGoxdk1EYXc3TmlE?=
 =?utf-8?B?ZG9LV3hsaFY0enU4RUUwQzhMYnNyKzJ3MGxXcWpyUTQyejRlc21XZ3E2NEpj?=
 =?utf-8?B?OEY4K0V0aWRneHBlMm00cXFKUkR2MFpLeERGZVZwQysrR0dGRWduSno2K3k5?=
 =?utf-8?B?UkFwZ3greTVweXF4TVpvSTd4NDkwaE9nL1JuSFJuOWdpU3NWWUQzTHhTdmdT?=
 =?utf-8?B?aWpESHMwVmt2bXRORnhXTXBDTE5MUDNjZGQ3RjRPSXA3K3N4NG9lZmFtS2o0?=
 =?utf-8?B?Qy9sSlVnUHZYNEdJN3hlZFduV05id1F3UVBWSWdwVHpTT1NOdU1kaE96R1lp?=
 =?utf-8?B?NWI3ZXoxSFFIanVTOW5xUkVnOHJZNmxQTGwxUFF0WEVMSGxCRDhLZWJQRDZ5?=
 =?utf-8?B?WWRvS01nS1BNRXFCVDM1U01OQ2tuMmdTajFIUzZRQjBEdFhYYzRrandsR2JW?=
 =?utf-8?B?bWhuZTJta1dKaG1CbzdTQkR3OEd2TVdsa2tYU1JvQllPTFFRZG0zRll3dmFn?=
 =?utf-8?B?cytHSGUzclFzN3BCejVQNWlFL1pzQnVWVU9mVDJSMER3VEY5Z3hqbTVxTDFt?=
 =?utf-8?B?bnJLS0ZKS3dlVndOMjRHOWE3ZUUwbjVKMkVESzBaNXE2U3VXS2tWNTRUYThT?=
 =?utf-8?B?ZVhBRUQ2L3JwVVBqenBXc1B6c3ZLWVBzOGJhbWZ4L3hCRW5CbnM0WXlnNGJV?=
 =?utf-8?B?K1RhWFhTMys3ZnY0YUVqOE9LL3F6MDFwUTlZQ0Ixd0gwMFozOVlRWWNhZUtU?=
 =?utf-8?B?OVRDbHVabU1YWWpEQk5FdEZ5aHVpVC9Yby9KVFg4MFFLS0w5aUl4YW5DZVNt?=
 =?utf-8?B?cUc4ZG5kekxjaTN3Y21yU1pXdWxtdEhHUnBtU2ZMN2E3cmxJN1dRZ3l6WXlI?=
 =?utf-8?B?SnhzQUhZRHNSUm9FeE4wbHN2QzM3Slk1RS9XSkp0a2h2NURtOE5VQTIyQW1n?=
 =?utf-8?B?Q3hjU285WWlyNkIzU3BVMXRyYzdBZE9kajJxdCtZYkMxMWtlM0x0d2llQ01S?=
 =?utf-8?B?RVA1VGZ3RWJLYm1lS0g4Q3VWMmRSUmpxdVZSVmlEZlUwTy80SGYybGR1cUNL?=
 =?utf-8?B?dVhkSXk2Um9PcUhJOXZhTGIyanFqK3dUQU91QWZtakY3R0h0Q2hOY3J6MnhI?=
 =?utf-8?B?RHJ2NkU2eENRaEFadVk0OFl0b0E2K3ZoM3JURGt5eFFOOSsyblBXVVpKUGZ3?=
 =?utf-8?B?WnA3WE04KzYxWkF3QVFwdHRNL3haSFlSWmxFb3NrL3hMQUZ4cUJmdWtodVhN?=
 =?utf-8?B?eVVZR2xCSkRGVWpTREIzV1lDSHlLZWFRUFVHS05RTjlVTm1mSVZ2NHBoQzJk?=
 =?utf-8?Q?T4PqcC/2iCm6YR3YIu6KYzON9?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A10898C17D83A04CBAA8C2B095601D7D@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB6626.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d7c4916-9d22-4e8b-9703-08dc2e06ea2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2024 09:17:21.3205
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UI8imVumylNcpiH/R1kGZOB8G/EPTzLBYmR0E8ADDSuN8YxXOxZ4Ndy2DhoeAevfXDwnZip/IDWdkSImzONTCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR03MB7162

SGksIEFuZ2VsbzoNCg0KT24gVGh1LCAyMDI0LTAyLTE1IGF0IDA5OjUzICswMTAwLCBBbmdlbG9H
aW9hY2NoaW5vIERlbCBSZWdubyB3cm90ZToNCj4gTW9zdCBvZiB0aGUgZnVuY3Rpb25zIHRoYXQg
YXJlIGNhbGxlZCBpbiB0aGUgcHJvYmUgY2FsbGJhY2sgYXJlDQo+IGRldm0gbWFuYWdlZCwgb3Ig
YWxsIGJ1dCBtaXBpX2RzaV9ob3N0X3JlZ2lzdGVyKCk6IHNpbXBsaWZ5IHRoZSBwcm9iZQ0KPiBm
dW5jdGlvbidzIGVycm9yIHBhdGhzIHdpdGggZGV2X2Vycl9wcm9iZSgpIGFuZCByZW1vdmUgdGhl
IGxvbmVseQ0KPiBpbnN0YW5jZSBvZiBgZ290byBlcnJfdW5yZWdpc3Rlcl9ob3N0YCBieSBqdXN0
IGRpcmVjdGx5IGNhbGxpbmcgdGhlDQo+IG1pcGlfZHNpX2hvc3RfdW5yZWdpc3RlcigpIGZ1bmN0
aW9uIGluIHRoZSBkZXZtX3JlcXVlc3RfaXJxKCkgZXJyb3INCj4gcGF0aCwgYWxsb3dpbmcgdG8g
YWxzbyByZW1vdmUgdGhlIHNhbWUgbGFiZWwuDQoNClJldmlld2VkLWJ5OiBDSyBIdSA8Y2suaHVA
bWVkaWF0ZWsuY29tPg0KDQo+IA0KPiBSZXZpZXdlZC1ieTogQWxleGFuZHJlIE1lcmduYXQgPGFt
ZXJnbmF0QGJheWxpYnJlLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogQW5nZWxvR2lvYWNjaGlubyBE
ZWwgUmVnbm8gPA0KPiBhbmdlbG9naW9hY2NoaW5vLmRlbHJlZ25vQGNvbGxhYm9yYS5jb20+DQo+
IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kc2kuYyB8IDYwICsrKysrKysr
Ky0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxOCBpbnNlcnRp
b25zKCspLCA0MiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vbWVkaWF0ZWsvbXRrX2RzaS5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19k
c2kuYw0KPiBpbmRleCBiM2RkNjI1MWQ2MTEuLjE5NWZmNGRmYzNhMyAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kc2kuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9k
cm0vbWVkaWF0ZWsvbXRrX2RzaS5jDQo+IEBAIC0xMTE3LDY0ICsxMTE3LDQ0IEBAIHN0YXRpYyBp
bnQgbXRrX2RzaV9wcm9iZShzdHJ1Y3QNCj4gcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgCWRz
aS0+ZHJpdmVyX2RhdGEgPSBvZl9kZXZpY2VfZ2V0X21hdGNoX2RhdGEoZGV2KTsNCj4gIA0KPiAg
CWRzaS0+ZW5naW5lX2NsayA9IGRldm1fY2xrX2dldChkZXYsICJlbmdpbmUiKTsNCj4gLQlpZiAo
SVNfRVJSKGRzaS0+ZW5naW5lX2NsaykpIHsNCj4gLQkJcmV0ID0gUFRSX0VSUihkc2ktPmVuZ2lu
ZV9jbGspOw0KPiArCWlmIChJU19FUlIoZHNpLT5lbmdpbmVfY2xrKSkNCj4gKwkJcmV0dXJuIGRl
dl9lcnJfcHJvYmUoZGV2LCBQVFJfRVJSKGRzaS0+ZW5naW5lX2NsayksDQo+ICsJCQkJICAgICAi
RmFpbGVkIHRvIGdldCBlbmdpbmUgY2xvY2tcbiIpOw0KPiAgDQo+IC0JCWlmIChyZXQgIT0gLUVQ
Uk9CRV9ERUZFUikNCj4gLQkJCWRldl9lcnIoZGV2LCAiRmFpbGVkIHRvIGdldCBlbmdpbmUgY2xv
Y2s6DQo+ICVkXG4iLCByZXQpOw0KPiAtCQlyZXR1cm4gcmV0Ow0KPiAtCX0NCj4gIA0KPiAgCWRz
aS0+ZGlnaXRhbF9jbGsgPSBkZXZtX2Nsa19nZXQoZGV2LCAiZGlnaXRhbCIpOw0KPiAtCWlmIChJ
U19FUlIoZHNpLT5kaWdpdGFsX2NsaykpIHsNCj4gLQkJcmV0ID0gUFRSX0VSUihkc2ktPmRpZ2l0
YWxfY2xrKTsNCj4gLQ0KPiAtCQlpZiAocmV0ICE9IC1FUFJPQkVfREVGRVIpDQo+IC0JCQlkZXZf
ZXJyKGRldiwgIkZhaWxlZCB0byBnZXQgZGlnaXRhbCBjbG9jazoNCj4gJWRcbiIsIHJldCk7DQo+
IC0JCXJldHVybiByZXQ7DQo+IC0JfQ0KPiArCWlmIChJU19FUlIoZHNpLT5kaWdpdGFsX2Nsaykp
DQo+ICsJCXJldHVybiBkZXZfZXJyX3Byb2JlKGRldiwgUFRSX0VSUihkc2ktPmRpZ2l0YWxfY2xr
KSwNCj4gKwkJCQkgICAgICJGYWlsZWQgdG8gZ2V0IGRpZ2l0YWwgY2xvY2tcbiIpOw0KPiAgDQo+
ICAJZHNpLT5oc19jbGsgPSBkZXZtX2Nsa19nZXQoZGV2LCAiaHMiKTsNCj4gLQlpZiAoSVNfRVJS
KGRzaS0+aHNfY2xrKSkgew0KPiAtCQlyZXQgPSBQVFJfRVJSKGRzaS0+aHNfY2xrKTsNCj4gLQkJ
ZGV2X2VycihkZXYsICJGYWlsZWQgdG8gZ2V0IGhzIGNsb2NrOiAlZFxuIiwgcmV0KTsNCj4gLQkJ
cmV0dXJuIHJldDsNCj4gLQl9DQo+ICsJaWYgKElTX0VSUihkc2ktPmhzX2NsaykpDQo+ICsJCXJl
dHVybiBkZXZfZXJyX3Byb2JlKGRldiwgUFRSX0VSUihkc2ktPmhzX2NsayksICJGYWlsZWQNCj4g
dG8gZ2V0IGhzIGNsb2NrXG4iKTsNCj4gIA0KPiAgCXJlZ3MgPSBwbGF0Zm9ybV9nZXRfcmVzb3Vy
Y2UocGRldiwgSU9SRVNPVVJDRV9NRU0sIDApOw0KPiAgCWRzaS0+cmVncyA9IGRldm1faW9yZW1h
cF9yZXNvdXJjZShkZXYsIHJlZ3MpOw0KPiAtCWlmIChJU19FUlIoZHNpLT5yZWdzKSkgew0KPiAt
CQlyZXQgPSBQVFJfRVJSKGRzaS0+cmVncyk7DQo+IC0JCWRldl9lcnIoZGV2LCAiRmFpbGVkIHRv
IGlvcmVtYXAgbWVtb3J5OiAlZFxuIiwgcmV0KTsNCj4gLQkJcmV0dXJuIHJldDsNCj4gLQl9DQo+
ICsJaWYgKElTX0VSUihkc2ktPnJlZ3MpKQ0KPiArCQlyZXR1cm4gZGV2X2Vycl9wcm9iZShkZXYs
IFBUUl9FUlIoZHNpLT5yZWdzKSwgIkZhaWxlZA0KPiB0byBpb3JlbWFwIG1lbW9yeVxuIik7DQo+
ICANCj4gIAlkc2ktPnBoeSA9IGRldm1fcGh5X2dldChkZXYsICJkcGh5Iik7DQo+IC0JaWYgKElT
X0VSUihkc2ktPnBoeSkpIHsNCj4gLQkJcmV0ID0gUFRSX0VSUihkc2ktPnBoeSk7DQo+IC0JCWRl
dl9lcnIoZGV2LCAiRmFpbGVkIHRvIGdldCBNSVBJLURQSFk6ICVkXG4iLCByZXQpOw0KPiAtCQly
ZXR1cm4gcmV0Ow0KPiAtCX0NCj4gKwlpZiAoSVNfRVJSKGRzaS0+cGh5KSkNCj4gKwkJcmV0dXJu
IGRldl9lcnJfcHJvYmUoZGV2LCBQVFJfRVJSKGRzaS0+cGh5KSwgIkZhaWxlZCB0bw0KPiBnZXQg
TUlQSS1EUEhZXG4iKTsNCj4gIA0KPiAgCWlycV9udW0gPSBwbGF0Zm9ybV9nZXRfaXJxKHBkZXYs
IDApOw0KPiAtCWlmIChpcnFfbnVtIDwgMCkgew0KPiAtCQlyZXQgPSBpcnFfbnVtOw0KPiAtCQly
ZXR1cm4gcmV0Ow0KPiAtCX0NCj4gKwlpZiAoaXJxX251bSA8IDApDQo+ICsJCXJldHVybiBpcnFf
bnVtOw0KPiAgDQo+ICAJZHNpLT5ob3N0Lm9wcyA9ICZtdGtfZHNpX29wczsNCj4gIAlkc2ktPmhv
c3QuZGV2ID0gZGV2Ow0KPiAgCXJldCA9IG1pcGlfZHNpX2hvc3RfcmVnaXN0ZXIoJmRzaS0+aG9z
dCk7DQo+IC0JaWYgKHJldCA8IDApIHsNCj4gLQkJZGV2X2VycihkZXYsICJmYWlsZWQgdG8gcmVn
aXN0ZXIgRFNJIGhvc3Q6ICVkXG4iLCByZXQpOw0KPiAtCQlyZXR1cm4gcmV0Ow0KPiAtCX0NCj4g
KwlpZiAocmV0IDwgMCkNCj4gKwkJcmV0dXJuIGRldl9lcnJfcHJvYmUoZGV2LCByZXQsICJGYWls
ZWQgdG8gcmVnaXN0ZXIgRFNJDQo+IGhvc3RcbiIpOw0KPiAgDQo+ICAJcmV0ID0gZGV2bV9yZXF1
ZXN0X2lycSgmcGRldi0+ZGV2LCBpcnFfbnVtLCBtdGtfZHNpX2lycSwNCj4gIAkJCSAgICAgICBJ
UlFGX1RSSUdHRVJfTk9ORSwgZGV2X25hbWUoJnBkZXYtPmRldiksIA0KPiBkc2kpOw0KPiAgCWlm
IChyZXQpIHsNCj4gLQkJZGV2X2VycigmcGRldi0+ZGV2LCAiZmFpbGVkIHRvIHJlcXVlc3QgbWVk
aWF0ZWsgZHNpDQo+IGlycVxuIik7DQo+IC0JCWdvdG8gZXJyX3VucmVnaXN0ZXJfaG9zdDsNCj4g
KwkJbWlwaV9kc2lfaG9zdF91bnJlZ2lzdGVyKCZkc2ktPmhvc3QpOw0KPiArCQlyZXR1cm4gZGV2
X2Vycl9wcm9iZSgmcGRldi0+ZGV2LCByZXQsICJGYWlsZWQgdG8NCj4gcmVxdWVzdCBEU0kgaXJx
XG4iKTsNCj4gIAl9DQo+ICANCj4gIAlpbml0X3dhaXRxdWV1ZV9oZWFkKCZkc2ktPmlycV93YWl0
X3F1ZXVlKTsNCj4gQEAgLTExODYsMTAgKzExNjYsNiBAQCBzdGF0aWMgaW50IG10a19kc2lfcHJv
YmUoc3RydWN0DQo+IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gIAlkc2ktPmJyaWRnZS50eXBl
ID0gRFJNX01PREVfQ09OTkVDVE9SX0RTSTsNCj4gIA0KPiAgCXJldHVybiAwOw0KPiAtDQo+IC1l
cnJfdW5yZWdpc3Rlcl9ob3N0Og0KPiAtCW1pcGlfZHNpX2hvc3RfdW5yZWdpc3RlcigmZHNpLT5o
b3N0KTsNCj4gLQlyZXR1cm4gcmV0Ow0KPiAgfQ0KPiAgDQo+ICBzdGF0aWMgdm9pZCBtdGtfZHNp
X3JlbW92ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0K

