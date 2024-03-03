Return-Path: <linux-kernel+bounces-89637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4294286F36D
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 03:47:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE05B281D22
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 02:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4D663A1;
	Sun,  3 Mar 2024 02:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="PJrPhpoP";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="ribFKx66"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639D033C7;
	Sun,  3 Mar 2024 02:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709434009; cv=fail; b=ACZtn7r4Qsi6L8KFBWwyfficMKxWVpCfp7iCyXLQxLwIRHUzjpTisGNC36ooXUnPZ1o8OMO3hJYEYCHypGjuscuBDyUsprp2HUaZfhH4ldAd3dn5Z2q3RPx+uCDCr5Ul+7Pk0rGDVuLATUhunGqxTzrsf7Q+qFcNCAgR5jgQ8Is=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709434009; c=relaxed/simple;
	bh=H5+kCAw5NQXxL1FJP4RV4+l0EaFfXtXFqA80L/tQhPo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kOE1Xt2dPHxzHqfxYcle3mi2Vu43mE++w+CBGmIc7C989EEYH1BVSfOtgJgo7zHnutmtn5J2td82YxTv2hUpdGOWC7EAHR9tAR2hwU8IszaUp+1pLgSkCyD8A2DDXgGI7mPkhMzLoU6bd/zH2yAaShuQVKTeUPaVVXs19rc9E60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=PJrPhpoP; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=ribFKx66; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 43986808d90811eeb8927bc1f75efef4-20240303
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=H5+kCAw5NQXxL1FJP4RV4+l0EaFfXtXFqA80L/tQhPo=;
	b=PJrPhpoPYZLtzWo6SqDiZ0oMZ8daL63NMnAbqq+8r50Rr207T08sUFNliXYaK43ZT1tgnold5bYrttZtyQP+Zxe63jq/QWsSA3z11RLaUqSbnoEcc/E4HYpm6Qq3NrBjVpDURVIgaEHGxbyKx++s/R8TT6gxcq7S24Y3RdLRdEg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:c2568f28-4b26-4335-8d96-59d1834ab0ab,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:1827f18f-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 43986808d90811eeb8927bc1f75efef4-20240303
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
	(envelope-from <zhi.mao@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 33296706; Sun, 03 Mar 2024 10:46:41 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sun, 3 Mar 2024 10:46:39 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Sun, 3 Mar 2024 10:46:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tq4d68GFUJLP0ezW8nfKSfIdhEo+vIv/RuVMdiEWuin0er2EdthzAYml0jANXG+Q+xb8bPCWQtBK6gamKkCcQGaVWjLyjb7EFL8rXnUNYocE1IG1x8fUTc8BnUQQLYkU0l4aDellpH15dxA+dk5jlaQc9a5ZL7hy89AtF8uNx1kUOOUGjT/iiM+46B/fni+3//A3qCEEYO7dZqxS11gN+Hj4GfLyIdCrcgf5AiuDUIyVHLNSozx7GIqwi557JHFl7VzUgus8kqOXhc3tLsKeUe9mj3saV+0VoKlhBt2N0lq0r0Vre/oFiOSk7SftN71QCSRjUjsfUCbyfWS+5YyInA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H5+kCAw5NQXxL1FJP4RV4+l0EaFfXtXFqA80L/tQhPo=;
 b=Xj/Guy6KEMeACsVDohZnRQBmIj69SI6dKM+RrgcqisLwo1mTVqhXVJOUzlLi8H8VMaXGLA4KxfYrWRuJmbTYMyG0p+CbLXeV6n9M68h+4vHeCSufqESQzpefupywc7nkxCpuw4PPqfJvsYoIEtWWKMwaBNOcwHuy5bFBrlvY6UBO/HljC+vuFm6AytBsdCc/wB51F2RAA3hS7/MsoRem/AQXZZTZxSB7h+ctgkiqf99VxF0IOmE7Yf+XkkZMWf7SyIVKEzQYV8Nj/JhEuiXcUN6vqSGwTl1GWROLZO/iwa2Rb2Z1GJyssi5NHH5bOb1rLIg59IxzfXWNqYbmUPVt8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H5+kCAw5NQXxL1FJP4RV4+l0EaFfXtXFqA80L/tQhPo=;
 b=ribFKx660iXXZpZYc1rt64FD+JQqOxwZw6O2F88AsXgRoQv0bS1RfzdGE1rqlUngovRvskm1X0wBoHyhqPDVRrsl3UJAgPbxLLrW/BvFwfs5TLEt6D/cfiu5/P91v2kxU1V8Rz1s4Zv8d+3wOgVkLvolorHzr1guAoxAf+V9LsE=
Received: from TYZPR03MB5566.apcprd03.prod.outlook.com (2603:1096:400:53::7)
 by SEZPR03MB7218.apcprd03.prod.outlook.com (2603:1096:101:e7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.32; Sun, 3 Mar
 2024 02:46:34 +0000
Received: from TYZPR03MB5566.apcprd03.prod.outlook.com
 ([fe80::ea44:b3b4:28a4:c731]) by TYZPR03MB5566.apcprd03.prod.outlook.com
 ([fe80::ea44:b3b4:28a4:c731%7]) with mapi id 15.20.7339.033; Sun, 3 Mar 2024
 02:46:34 +0000
From: =?utf-8?B?WmhpIE1hbyAo5q+b5pm6KQ==?= <zhi.mao@mediatek.com>
To: "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>
CC: "heiko@sntech.de" <heiko@sntech.de>, "tomi.valkeinen@ideasonboard.com"
	<tomi.valkeinen@ideasonboard.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
	"yunkec@chromium.org" <yunkec@chromium.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "dan.scally@ideasonboard.com"
	<dan.scally@ideasonboard.com>, "gerald.loacker@wolfvision.net"
	<gerald.loacker@wolfvision.net>,
	=?utf-8?B?U2hlbmduYW4gV2FuZyAo546L5Zyj55S3KQ==?=
	<shengnan.wang@mediatek.com>, "hdegoede@redhat.com" <hdegoede@redhat.com>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	=?utf-8?B?WWF5YSBDaGFuZyAo5by16ZuF5riFKQ==?= <Yaya.Chang@mediatek.com>,
	"mchehab@kernel.org" <mchehab@kernel.org>, "jacopo.mondi@ideasonboard.com"
	<jacopo.mondi@ideasonboard.com>, "jernej.skrabec@gmail.com"
	<jernej.skrabec@gmail.com>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "bingbu.cao@intel.com"
	<bingbu.cao@intel.com>, "sakari.ailus@linux.intel.com"
	<sakari.ailus@linux.intel.com>, Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, "10572168@qq.com"
	<10572168@qq.com>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"laurent.pinchart@ideasonboard.com" <laurent.pinchart@ideasonboard.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "macromorgan@hotmail.com"
	<macromorgan@hotmail.com>
Subject: Re: [PATCH v6 2/2] media: i2c: Add GC08A3 image sensor driver
Thread-Topic: [PATCH v6 2/2] media: i2c: Add GC08A3 image sensor driver
Thread-Index: AQHaaR0Dr2G8OwgcZUiafwf4WUg7y7EeI9sAgAcz6gA=
Date: Sun, 3 Mar 2024 02:46:33 +0000
Message-ID: <2c8ae94c1477a933ca78ac7b0f2c92f66ed029f7.camel@mediatek.com>
References: <20240227013221.21512-1-zhi.mao@mediatek.com>
	 <20240227013221.21512-3-zhi.mao@mediatek.com>
	 <CAHp75VciCJuoOwC8ozanWYqSCM=vWpiaqymJ2-gQfrSt5Ts6fQ@mail.gmail.com>
In-Reply-To: <CAHp75VciCJuoOwC8ozanWYqSCM=vWpiaqymJ2-gQfrSt5Ts6fQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB5566:EE_|SEZPR03MB7218:EE_
x-ms-office365-filtering-correlation-id: e952ed96-6fa0-450f-6e8b-08dc3b2c237f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: APBZrpjsHj4QgnAxISuVaJn+ummJhEtfW76PHXSvfUAp5sEeTMMu2JvGpS93ryriezhFjddNakTfi4FeHNFtlwhzkt5du/B/Eg0gLf9NE94N6ch/YOPkFdIta//+psnbtRYqE5OMElDv325hGdCxcTEHzTWa513alVYE9EGjMnNZbpL+rBM4T60X18egYtBihIDa2PA3DxX3klawoGRfYqZH6GDQl1P77hNtAus8kCLgEobZ+Q97HPSoISSsnCDEobNY864cqhhvU7aWcGGbW8tcLAjOw6Gywq9J/owyzLXiH7hUerC0m8PwCi7qy6KJBCyBTi/jANhIbLpaXGCPwdddP7ujuwlDYBiX2LE3WrXuin3Uc9NLfE3JiOM0Bbb3J9NaKvkqlnfaLMRPoZWYHjZdZaOJv6wY8RLTiSOIrDOD/NxQv1Oham5PRg7+S/Vz0h2ig6TfhZ4XU2JNORior3Pjvj/0W889cylh1LwwkUADxz5wnkKeI3OONIMZuv9aACiN1njCgzl1kdrfz09jxaMFqU4biKAWr+NgT4OLuADZH90kipX5UAlPA8fQ5LFFM2aWi5Jbf0ovbcX+MZV2MTcqe7ztI/tI7iSHQqymHpR/fqELAAQWmvHmO0iv7I0S3WYDJhk8S5IiuDrd5gYy09K5yWQMnDerBSOdjP5NKrh2D4Q3ZHh42MxXbDfgK+mtAUz1pQxXvV6v2Lg2Ep6b3gQkO8zhffN0z2wiltxDQfM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB5566.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b1hQRS96RmZXK09iVy80RC95MjZnNjN4UGxzY3ptR1FhUE1YTndSWTMvVTJx?=
 =?utf-8?B?SjdEVjQwaW5CbVVkTjFNaXVQN3FnNTdmUTBlQmk2M3ZZOGdDTWtIYjAxZDRV?=
 =?utf-8?B?OWtpdUtMc2NTTk1WVGh0WENsUzRwMHZlM3NNTThlUlBKL2NMcWovb2V2aVp6?=
 =?utf-8?B?QVR4dS9ZaFl0TEdzVHZCOTBhTzY1anJDNWRZWHFhM1g5UDhCNmQraXMwTTZF?=
 =?utf-8?B?bENSaTFCK3hJT096UFdmY3A2R2FWVFEzamFKL2FISitYM0NNaXNRRGpoTGxj?=
 =?utf-8?B?WmNFTVVuTnJPV21oc3BiTzJoVGdoMkZpOVk4WUo1YU45QnhTMEJSQi9iUmdS?=
 =?utf-8?B?T0pNT0lVQzdEOTlaZUY0dWNaWkpXVXB5WjQrNU1oQk8rTmRqSDd0N3FJSDBO?=
 =?utf-8?B?TWErVlQvU2hQalEzRzdmZmI2RzFFSzQ5ZWpBQWpRQnZRRy83cHNMSmJZWUtP?=
 =?utf-8?B?akVDTy8wT2lZL2gxMkhra2x6T1ozYWhkU21mcHBmOExPVW9ta3lqZEU0aVFj?=
 =?utf-8?B?bWE1K3hMZXRLWVJxbWcyYnByaXR3cE52dGppWC9wb3pIVnZNWmRlRlFwZ1NU?=
 =?utf-8?B?Q3Jqem1LQXNKYVFtcThTbWsxOVM0L0plZ3p6S1BsR1k1MlFjMG1jV3NtV3p3?=
 =?utf-8?B?Z2FDLy83MzU2SHlsS0ZJbm8yczVlOFRYSEQwSGpodkFKM3JCR0lOS2dnWTFQ?=
 =?utf-8?B?MzJacFR5Q3NzM1htOGRZZWJoMFExZ3VFWkVuU01CZHVwcmQxczQ1bUJXakFs?=
 =?utf-8?B?UllQVjhtdUVyNTBkbFR5bE1jWkplL29MUlZwRW9ONFdKK1I1UlNSdmRwN2l3?=
 =?utf-8?B?dW13ZElhWmVYR2wvUVpOTW1uSlRYSGgxNlJBbUNQUzNhMFBydS9ia1RQS3Nw?=
 =?utf-8?B?ME1VWTBnWm1hc3k2WVRTbHUzRzVoNkhuZ3dNWWJOMTJBSC9vb2JYL1Via0w0?=
 =?utf-8?B?ZzlNZFBvWk5LcWRrbnIxT1p4NlRaT21wY0J3akRSb0tqR2Vrd3VaKzRERW40?=
 =?utf-8?B?V2hiTC9Hc3JPWHA0c0VTWHRFQzlvL2o0Q1E0dnlxb0hnSnViNGYwZXdlbzJW?=
 =?utf-8?B?YnE2UENKcjVXTlZJODd4ZWNhS2RFREthQ1ZpUG1tWitVUkxOTlZURXgyTGVs?=
 =?utf-8?B?cUhSKzQza3BtbjJqRGI1K25pcVRqZDJYSEFkVnF3SjFNeld4T2hDcUY5Q3F4?=
 =?utf-8?B?SlRNbFBMbm5KZmQ5QlpXbUJtNEVUekdoRytYeGp6QkowZndXL0xscWRIVCtl?=
 =?utf-8?B?b09qbXBLS2g0c29nVkoyNjIwb2ovRDZDb3B1TkpNU0RBOXlubHBCUXRxMFNT?=
 =?utf-8?B?UnBZREN3U09hbE9CbTFPZ3NPcDR6MkdhdU9rNHRYRmxQajkzOHFhYVVvTWZz?=
 =?utf-8?B?UHE3VXNJMUc2VGlRT3hwMWkzOTk2OEpuOUtrNzdpUWNCblVFTWQxRjR0R2du?=
 =?utf-8?B?QnJHV0hQSGZYTFVQcUpCRE9XamxyRDBJenh4c1R0Z01wUWo2SE1McE85RWZ6?=
 =?utf-8?B?K201bTdvUGF1ZTRtRmtpdXByL3lRdjlicXZMVkt2OE5uVXFBK1Fqa2huZGh0?=
 =?utf-8?B?bE50cFdWZUZYcmhGMkhNc0hGVGR2QVduaGRXbkt6REJkekI4SjJUbjVZQXZK?=
 =?utf-8?B?YTBLa1hENmJFcmxDMkk2WkJBQVdLcnJyZlZoRGtGZHorZ3REaUZMVGFjWDJJ?=
 =?utf-8?B?QnhuM0NrQjNPaVR6MkhzRW43WXBEN2NUdWJYaGZBbGNxKzRxem01emJYMWtP?=
 =?utf-8?B?NjFPYVEwOVdWZGx0a0hUd2s2em5INjdLSGV1aExRZDVIUVZGTUljdFNYVmtv?=
 =?utf-8?B?OUtuK0pQREdNUkM5NWI1TlVqYWwvVWg1Z0hWTVhwYjczVXhWSmNVZDNNYU9y?=
 =?utf-8?B?VXpxUVZsMEh3ai8zREh6dDV1emJpbExmUmcvUFoyYkJxUTV6Sy9xcjZjcll5?=
 =?utf-8?B?TmZZMWVTUGNQWG5KN3ByNmxmRUwzd0lGL3l1V3NlMG9Fd3hKajM0MFZDdEZW?=
 =?utf-8?B?b3MrTmhPeW1rNzI4SHVnRUQ3VUpncmJpUmkwZEEzTGtrWXR5cVRHOXJCMXhv?=
 =?utf-8?B?YURvMHBDbE5zeWNNdkVVdmZVNVN2Smc4bTRXalNrYWw4SVltekhyYXQwZVRG?=
 =?utf-8?B?UWdSVUdRYStWZWc1aFhpZVMybEorVlk0ZUxvL3BqRnlJckdXY2Rqei9CUkFJ?=
 =?utf-8?B?Y2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F34586DD0B347D4EB24F23FC0309F02D@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB5566.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e952ed96-6fa0-450f-6e8b-08dc3b2c237f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2024 02:46:33.9773
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w9/VCLInHkqHGXgkqf9msGfdsaLMtcho0P2QbpYlMi9+qtTSfpHffdnEGXprkFxdDTvMQ4GmgKiBl360028Lzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7218

SGkgQW5keSwNCg0KVGhhbmtzIGZvciB5b3VyIHJldmlldy4NCg0KDQpPbiBUdWUsIDIwMjQtMDIt
MjcgYXQgMTQ6NDYgKzAyMDAsIEFuZHkgU2hldmNoZW5rbyB3cm90ZToNCj4gIAkgDQo+IEV4dGVy
bmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRz
IHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRlbnQuDQo+
ICBPbiBUdWUsIEZlYiAyNywgMjAyNCBhdCAzOjMz4oCvQU0gWmhpIE1hbyA8emhpLm1hb0BtZWRp
YXRlay5jb20+DQo+IHdyb3RlOg0KPiA+DQo+ID4gQWRkIGEgVjRMMiBzdWItZGV2aWNlIGRyaXZl
ciBmb3IgR2FsYXh5Y29yZSBHQzA4QTMgaW1hZ2Ugc2Vuc29yLg0KPiANCj4gLi4uDQo+IA0KPiA+
ICsvKg0KPiA+ICsgKiBnYzA4YTMuYyAtIGdjMDhhMyBzZW5zb3IgZHJpdmVyDQo+IA0KPiBEcm9w
IHRoZSBmaWxlbmFtZSBmcm9tIHRoZSBmaWxlLCBpdCdzIGltcHJhY3RpY2FsIChlc3AuIGlmIHRo
ZSBmaWxlDQo+IHdpbGwgYmUgcmVuYW1lZCBmb3Igc29tZSByZWFzb24gaW4gdGhlIGZ1dHVyZSku
DQo+IA0KZml4ZWQgaW4gcGF0Y2g6djcuDQoNCj4gPiArICoNCj4gPiArICogQ29weXJpZ2h0IDIw
MjMgTWVkaWFUZWsNCj4gPiArICoNCj4gPiArICogWmhpIE1hbyA8emhpLm1hb0BtZWRpYXRlay5j
b20+DQo+ID4gKyAqLw0KPiANCj4gLi4uDQo+IA0KPiA+ICsjaW5jbHVkZSA8bGludXgvY2xrLmg+
DQo+ID4gKyNpbmNsdWRlIDxsaW51eC9kZWxheS5oPg0KPiA+ICsjaW5jbHVkZSA8bGludXgvZ3Bp
by9jb25zdW1lci5oPg0KPiA+ICsjaW5jbHVkZSA8bGludXgvcG1fcnVudGltZS5oPg0KPiA+ICsj
aW5jbHVkZSA8bGludXgvcmVndWxhdG9yL2NvbnN1bWVyLmg+DQo+ID4gKyNpbmNsdWRlIDxsaW51
eC91bml0cy5oPg0KPiANCj4gVGhpcyBpcyBhIHNlbWktcmFuZG9tIGxpc3Qgb2YgaW5jbHVzaW9u
cy4gUGxlYXNlLCBmb2xsb3cgdGhlIElXWVUNCj4gKEluY2x1ZGUgV2hhdCBZb3UgVXNlKSBwcmlu
Y2lwbGUuICpBdCBsZWFzdCogdGhpcyBsaXN0IG1pc3NlcyB0aGUNCj4gZm9sbG93aW5nOiAgYXJy
YXlfc2l6ZS5oLCBiaXRzLmgsIGNvbnRhaW5lcl9vZi5oLCBkZXZpY2UuaCwgZXJyLmgsDQo+IGky
Yy5oLCBtYXRoNjQuaCwgbW9kdWxlLmgsIG1vZF9kZXZpY2V0YWJsZS5oLCBwcm9wZXJ0eS5oLCB0
eXBlcy5oLg0KPiANCmZpeGVkIGluIHBhdGNoOnY3Lg0KDQo+IC4uLg0KPiANCj4gPiArICAgICAg
IC8qdXBkYXRlIGNyb3AgaW5mbyB0byBzdWJkZXYgc3RhdGUqLw0KPiANCj4gTWlzc2luZyBzcGFj
ZXMuDQo+IA0KZml4ZWQgaW4gcGF0Y2g6djcuDQoNCj4gLi4uDQo+IA0KPiA+ICsgICAgICAgLyp1
cGRhdGUgZm10IGluZm8gdG8gc3ViZGV2IHN0YXRlKi8NCj4gDQo+IERpdHRvLg0KPiANCmZpeGVk
IGluIHBhdGNoOnY3Lg0KDQo+IC4uLg0KPiANCj4gPiArc3RhdGljIGludCBnYzA4YTNfdGVzdF9w
YXR0ZXJuKHN0cnVjdCBnYzA4YTMgKmdjMDhhMywgdTMyDQo+IHBhdHRlcm5fbWVudSkNCj4gPiAr
ew0KPiA+ICsgICAgICAgdTMyIHBhdHRlcm4gPSAwOw0KPiANCj4gTm8sIHBsZWFzZSB1c2UgdGhl
IGRlZmF1bHQgY2FzZSBmb3IgdGhpcyBhc3NpZ25tZW50Lg0KPiANCmZpeGVkIGluIHBhdGNoOnY3
Lg0KDQo+ID4gKyAgICAgICBpbnQgcmV0Ow0KPiA+ICsNCj4gPiArICAgICAgIGlmIChwYXR0ZXJu
X21lbnUpIHsNCj4gPiArICAgICAgICAgICAgICAgc3dpdGNoIChwYXR0ZXJuX21lbnUpIHsNCj4g
PiArICAgICAgICAgICAgICAgY2FzZSAxOg0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIHBh
dHRlcm4gPSAweDAwOw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGJyZWFrOw0KPiA+ICsg
ICAgICAgICAgICAgICBjYXNlIDI6DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgcGF0dGVy
biA9IDB4MTA7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgYnJlYWs7DQo+ID4gKyAgICAg
ICAgICAgICAgIGNhc2UgMzoNCj4gPiArICAgICAgICAgICAgICAgY2FzZSA0Og0KPiA+ICsgICAg
ICAgICAgICAgICBjYXNlIDU6DQo+ID4gKyAgICAgICAgICAgICAgIGNhc2UgNjoNCj4gPiArICAg
ICAgICAgICAgICAgY2FzZSA3Og0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIHBhdHRlcm4g
PSBwYXR0ZXJuX21lbnUgKyAxOw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGJyZWFrOw0K
PiA+ICsgICAgICAgICAgICAgICB9DQo+ID4gKw0KPiA+ICsgICAgICAgICAgICAgICByZXQgPSBj
Y2lfd3JpdGUoZ2MwOGEzLT5yZWdtYXAsDQo+IEdDMDhBM19SRUdfVEVTVF9QQVRURVJOX0lEWCwN
Cj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHBhdHRlcm4sIE5VTEwpOw0KPiA+
ICsgICAgICAgICAgICAgICBpZiAocmV0KQ0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIHJl
dHVybiByZXQ7DQo+ID4gKw0KPiANCj4gPiArICAgICAgICAgICAgICAgcmV0ID0gY2NpX3dyaXRl
KGdjMDhhMy0+cmVnbWFwLA0KPiBHQzA4QTNfUkVHX1RFU1RfUEFUVEVSTl9FTiwNCj4gPiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIEdDMDhBM19URVNUX1BBVFRFUk5fRU4sIE5VTEwp
Ow0KPiA+ICsgICAgICAgICAgICAgICBpZiAocmV0KQ0KPiA+ICsgICAgICAgICAgICAgICAgICAg
ICAgIHJldHVybiByZXQ7DQo+ID4gKyAgICAgICB9IGVsc2Ugew0KPiA+ICsgICAgICAgICAgICAg
ICByZXQgPSBjY2lfd3JpdGUoZ2MwOGEzLT5yZWdtYXAsDQo+IEdDMDhBM19SRUdfVEVTVF9QQVRU
RVJOX0VOLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgMHgwMCwgTlVMTCk7
DQo+ID4gKyAgICAgICAgICAgICAgIGlmIChyZXQpDQo+ID4gKyAgICAgICAgICAgICAgICAgICAg
ICAgcmV0dXJuIHJldDsNCj4gPiArICAgICAgIH0NCj4gPiArDQo+ID4gKyAgICAgICByZXR1cm4g
MDsNCj4gDQo+ICdlbHNlJyBpcyByZWR1bmRhbnQsIGJ1dCB5b3UgY2FuIGRlZHVwbGljYXRlIGNv
ZGUgYWJvdmUgd2l0aA0KPiANCj4gICByZXR1cm4gY2NpX3dyaXRlKC4uLik7DQo+IH0gZWxzZSB7
DQo+ICAgcmV0dXJuIGNjaV93cml0ZSguLi4pOw0KPiB9DQo+IA0KPiBPZiBjb3Vyc2UgeW91IGNh
biBnbyBldmVuIGZ1cnRoZXIsIGJ1dCBJIHRoaW5rIHdpdGggdGhlIGFib3ZlIGl0IHdpbGwNCj4g
YmUgYmFsYW5jZWQgdG8gdGhlIHdheSB0aGF0IGl0J3MgZWFzeSB0byB1bmRlcnN0YW5kIGhvdyBi
cmFuY2hlcw0KPiBiZWhhdmUgKCdlbHNlJyBpbiB0aGlzIGNhc2UgaGVscHMgdG8gaW5kZW50IHNl
bWFudGljYWxseSBjb3VwbGVkDQo+IGxpbmVzKS4NCj4gDQpmaXhlZCBpbiBwYXRjaDp2Ny4NCg0K
PiA+ICt9DQo+IA0KPiANCj4gPiArICAgICAgIC8qDQo+ID4gKyAgICAgICAgKiBBcHBseWluZyBW
NEwyIGNvbnRyb2wgdmFsdWUgb25seSBoYXBwZW5zDQo+ID4gKyAgICAgICAgKiB3aGVuIHBvd2Vy
IGlzIG9uIGZvciBzdHJlYW1pbmcNCj4gPiArICAgICAgICAqLw0KPiANCj4gUmVzcGVjdCBFbmds
aXNoIGdyYW1tYXIgYW5kIHB1bmN0dWF0aW9uLCBpLmUuIGRvbid0IGZvcmdldCBwZXJpb2RzIGF0
DQo+IHRoZSBlbmQgb2Ygc2VudGVuY2VzIGluIG11bHRpLWxpbmUgY29tbWVudHMuDQo+IA0KZml4
ZWQgaW4gcGF0Y2g6djcuDQoNCj4gLi4uDQo+IA0KPiA+ICsgICAgICAgZW5kcG9pbnQgPQ0KPiA+
ICsgICAgICAgICAgICAgICBmd25vZGVfZ3JhcGhfZ2V0X2VuZHBvaW50X2J5X2lkKGRldl9md25v
ZGUoZGV2KSwgMCwNCj4gMCwNCj4gPg0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBGV05PREVfR1JBUEhfRU5EUE9JTlQNCj4gX05FWFQpOw0KPiA+ICsg
ICAgICAgaWYgKCFlbmRwb2ludCkgew0KPiANCj4gU3RyaWN0bHkgc3BlYWtpbmcgZGV2X2Z3bm9k
ZShkZXYpIG1pZ2h0IGJlIE5VTEwgb3IgYW4gZXJyb3IgcG9pbnRlci4NCj4gSQ0KPiBkdW5ubyBo
b3cgdGhlIGdyYXBoIGlzIGltcGxlbWVudGVkIHRoZXJlIGFuZCBpZiBpdCdzIHBvc3NpYmxlIHRv
IGdldA0KPiBhbiBlcnJvciBwb2ludGVyIG91dCBvZiBpdC4gQXQgbGVhc3QgdGhpcyBwcm9iYWJs
eSBuZWVkcyB0byBiZQ0KPiBhbGlnbmVkDQo+IHRoZXJlIGF0IHNvbWUgcG9pbnQuDQo+IA0KTXIu
U2FrYXJpIGhhcyBleHBsYWluZWQgdGhpcyBjb21tZW50cy4NCiJUaGlzIGlzIGZpbmUtLS10aGUg
Zndub2RlIEFQSSByZXR1cm5zIGVycm9ycyAoZm9yIGZ1bmN0aW9ucyB0aGF0IGNhbikNCmZvciBO
VUxMIG9yIGVycm9yIHBvaW50ZXIgZndub2Rlcy4iDQoNCj4gPiArICAgICAgICAgICAgICAgZGV2
X2VycihkZXYsICJlbmRwb2ludCBub2RlIG5vdCBmb3VuZFxuIik7DQo+ID4gKyAgICAgICAgICAg
ICAgIHJldHVybiAtRUlOVkFMOw0KPiA+ICsgICAgICAgfQ0KPiANCj4gLi4uDQo+IA0KPiA+ICtz
dGF0aWMgY29uc3Qgc3RydWN0IGRldl9wbV9vcHMgZ2MwOGEzX3BtX29wcyA9IHsNCj4gPiArICAg
ICAgIFJVTlRJTUVfUE1fT1BTKGdjMDhhM19wb3dlcl9vZmYsIGdjMDhhM19wb3dlcl9vbiwgTlVM
TCkNCj4gPiArfTsNCj4gDQo+IFRoZXJlIGlzIGEgREVGSU5FXyogUE0gbWFjcm8sIHVzZSBpdC4N
Cj4gDQpmaXhlZCBpbiBwYXRjaDp2Ny4NCg0KPiAuLi4NCj4gDQo+ID4gKw0KPiANCj4gUmVkdW5k
YW50IGJsYW5rIGxpbmUuDQo+IA0KZml4ZWQgaW4gcGF0Y2g6djcuDQoNCj4gPiArbW9kdWxlX2ky
Y19kcml2ZXIoZ2MwOGEzX2kyY19kcml2ZXIpOw0KPiANCj4gLS0gDQo+IFdpdGggQmVzdCBSZWdh
cmRzLA0KPiBBbmR5IFNoZXZjaGVua28NCg==

