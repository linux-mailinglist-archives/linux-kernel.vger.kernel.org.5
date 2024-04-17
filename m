Return-Path: <linux-kernel+bounces-148156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D57EE8A7E6E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17905B224D9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 08:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A894127B45;
	Wed, 17 Apr 2024 08:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Wq4Lp3uH";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="CcIOvKPF"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58ECB139F;
	Wed, 17 Apr 2024 08:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713343032; cv=fail; b=lCqUG9SwwQ+GPope/qFAGTk8wCpKaFjN3NLT6J6SFFITDlvrynQw8YFQP4JqeOvnkgMzKAQCIPoOX0CJb+CbcJf0WWJdBRFvTxfU/eo1VLql48UkvazbhC3QDIR3ojKcACWnwahtgk1JWj8F0PJQRFAKjPBKqyNff7Q53yy272s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713343032; c=relaxed/simple;
	bh=KCbqX4QlZ/OcpJaWB0jvClKS/rG7urBif+eHYa3M1fg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=psdzqSeD5G13F8WthFEBaY5DGh7Ee5GHNhzYESyewf1LYQ2/vxORTkSMdsCR16Q75DePEcGXMGELJnxT/9OOFq70/0ETZ6X4YvR/ZGkUGa0jgHPd5JNXMFhxpbOxf5WeXuWwTrF2QUcsStEh+oITHlUd5ntbmt4kKNrmW6DnXgc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Wq4Lp3uH; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=CcIOvKPF; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: a73beef6fc9511eeb8927bc1f75efef4-20240417
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=KCbqX4QlZ/OcpJaWB0jvClKS/rG7urBif+eHYa3M1fg=;
	b=Wq4Lp3uHyrh9MI2eJo1Xd08kQEFsaDCJTT21ft+UyH5rBK6LzDICMZ6jiELToGBBSethgO6XXnEbAPxQnqM5QgsV5uW7+2jrIVndYRvpnjEsCEWcXVMrcshapzImed2r9QeWZO0tBlUK8LUbR9JBf9BH1fptrBJI0yQuDLRKoDI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:bbc04720-cdcc-4b0a-a85e-85fe1f5da23d,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:82c5f88,CLOUDID:33c2ae91-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: a73beef6fc9511eeb8927bc1f75efef4-20240417
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2043938491; Wed, 17 Apr 2024 16:36:58 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 17 Apr 2024 16:36:57 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 17 Apr 2024 16:36:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cNpNfmGyZcAdJR8Lp/bs67txU0x0GcxvfbOGuqCv4u3TrvAJHG3a3buzfdFDcaUnA5b6L+/8DdZmODU9oiC7hgQiZKd1p1rUObWdgAI1uVK7h/YKDBZ+EbY57P4MRE00svmxaRW6KpfdBPsYhsvsQrONCTaHUxzHUKBpOZpPwCdk15HIQfw1io13O7ZbHVEzGB2WfpuwrB5Gg/jDggX2MVjVzGwlEmGBsCELEFc2aSGvh2cLQrBWhH9Im6FIFsMlu0aaQGD+WSmfSidwDqUghIvPXGomcfKsj/HL7G2iwBKzxk0zrTvH33NjpPUSobaZW48kwXhyMczKNeaVbJUbEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KCbqX4QlZ/OcpJaWB0jvClKS/rG7urBif+eHYa3M1fg=;
 b=bbMJvLkwL3mZENJnfU50N0HrjVcv9HsYjchz1KjfQzTljG7Q9t8WOqWdliQhjtWCIXbADwD7/rLPeQ5l278S6vbcEzHkWDBc5OJVVr7cO8e1NzmGW8YVGiaMnFIG8MW032+d5Rqufh2mfSaX7uTOddQkAL23Lq7EgGXCoN+++zm0DlKj8uz+4qlbNLHFwEg9+0PbRw7s7K+xA5fDEsKvA1T5taBesGEPbwsIIFyi/j3GHk97dVHqvwwJVCajgoY7GWYwf+mUnwTtI5kLGxZV0wVcCWjOQtSbulOtb9a4Paz+JiQEhMSlBoqifTZNuZvUdrN7+JL22y6KvIIB6unzsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KCbqX4QlZ/OcpJaWB0jvClKS/rG7urBif+eHYa3M1fg=;
 b=CcIOvKPFIm56KHvdHUA2tEX34qr1SuorYQXgP7Tw2m8rPdNnnQ7BAw8bHLr5T/U4gYc5sThKllEHmnXLMDT7v+JAF/22ihjKe/3WuP4AHA6xvMyal1idUYfxXIYEdaqUezSsiNQ5BFK90cQf1qJixq4X0gJw4ZwDRvP8KCzXsi4=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by SI4PR03MB9114.apcprd03.prod.outlook.com (2603:1096:4:26e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Wed, 17 Apr
 2024 08:36:54 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::bc7c:deed:ae:ed4c]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::bc7c:deed:ae:ed4c%4]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 08:36:54 +0000
From: =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>
To: =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= <Shawn.Sung@mediatek.com>,
	"mripard@kernel.org" <mripard@kernel.org>
CC: "sumit.semwal@linaro.org" <sumit.semwal@linaro.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
	"christian.koenig@amd.com" <christian.koenig@amd.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>, "tzimmermann@suse.de"
	<tzimmermann@suse.de>, "linux-media@vger.kernel.org"
	<linux-media@vger.kernel.org>, "daniel@ffwll.ch" <daniel@ffwll.ch>,
	"p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	"maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"airlied@gmail.com" <airlied@gmail.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v5 1/9] drm/mediatek/uapi: Add
 DRM_MTK_GEM_CREATE_ENCRYPTED flag
Thread-Topic: [PATCH v5 1/9] drm/mediatek/uapi: Add
 DRM_MTK_GEM_CREATE_ENCRYPTED flag
Thread-Index: AQHahbGbJAQJP2BTyUuB60+FvPVWmLFpJFcAgAMVEYA=
Date: Wed, 17 Apr 2024 08:36:54 +0000
Message-ID: <b1d0112d5f988acade7c925405ba1abea5623cb0.camel@mediatek.com>
References: <20240403102701.369-1-shawn.sung@mediatek.com>
	 <20240403102701.369-2-shawn.sung@mediatek.com>
	 <20240415-ultramarine-oxpecker-of-completion-8a2298@houat>
In-Reply-To: <20240415-ultramarine-oxpecker-of-completion-8a2298@houat>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|SI4PR03MB9114:EE_
x-ms-office365-filtering-correlation-id: 8eb39e39-1b08-45a0-844d-08dc5eb9890e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?utf-8?B?SXFacnE1WTFMVlo4MFlwSHJESGpXY2RZb3N4MEc4L1lVRXlWak54amNNZ3du?=
 =?utf-8?B?Yld1SVVaVk9JL3k5MmdWamNCWUtOcldVeWxnY2l2clljSDRGaGJZeG5VYmdK?=
 =?utf-8?B?ODN5RGFMZkdUQVdIaDlNSSs2aUZwWTM1N1ovL29Eek1yRk4vTG50SlVJZTJZ?=
 =?utf-8?B?SEpKWktQUk5rd0dEb0lsRW5HL0ZtdnJORmRqdWVKY005NXhnejBIVWMzTmpv?=
 =?utf-8?B?ZGlmZmExdU9JOUprNktGWjQ3VmJPeUUxNUlSanM0dFYxNXArMzhCY3hzUHdl?=
 =?utf-8?B?TnVheTdENVVEMVZyUDdzQUQ4ZEVXbGplTm1Ta2J1S2ZvZ0lKcUdHQ1lZZ25h?=
 =?utf-8?B?Z2VvbElIdEYrVDltZW1XbFJGbnhybWZzTk5VZS9id09pN3pacC9tSDl5M1pn?=
 =?utf-8?B?Z0dvbVBVV0lTbFJmRFpsOG9QUlU1VU93cHp3bGNlZEdmZmJHem1hOGFMWTZT?=
 =?utf-8?B?aHYrSFN4aStlejU0VDZTeFllVnIzVVZXdVJqcGhFRnk3SnROZ1dEcWhUK3lt?=
 =?utf-8?B?NnRrdzBkWTlHakFnYTlqV0R5ZnJFeHpUL3YrS3FhcHdCcThBRHlOZ3dzcXVm?=
 =?utf-8?B?cE43cTg0RUEwQURtUjFwbDY1TFp0T2sxeDJGZWd3ZjR5WmxGWUh3MU9tYzJK?=
 =?utf-8?B?V3QvbktvaEtTWUE3bGxwZnhLZDZVR25RcXJCemZVeTV6RDdsOG9PaU5mU3pJ?=
 =?utf-8?B?Ym9YaGx0THlrWENtOGRzUk51Y3IwZDJXVWZZOUdnMSt4Wi80Vmk3YlVScXdo?=
 =?utf-8?B?N0dtQ3RpdkZoRWsyQlREc0lvRVZ3eVJ3c2N5T1hFQTVacHFaMCtlZXlaNnFM?=
 =?utf-8?B?VlNGbHFsOGkrbVQzSVpGZGQ1NEhwT3VYUUdDMS9kKzJjeFVvWlp5V1Uybkh5?=
 =?utf-8?B?SmVVTUFCV0Ewek1HN3J5ODB0czZzY3ZnWmxkSExXcTlVMW85eDhCbzVsUFFt?=
 =?utf-8?B?dDZKVXJMR0pjT0xaN0R3dzgzSEdHZkhIZTI4cGkwdzZjNWY4OVJKdHQwS1Ux?=
 =?utf-8?B?Sm5ZZktpQ1pBTFlIWTIrRFlBWUhxZU5zWWEwaEx1RDlWZ0haTzFPT2V0NXh1?=
 =?utf-8?B?b0hkNW5IMlY5azJjRGUyYmJHeWxZUU03TkxwWVdCdDVaVWJUaVVpenV2Z2dZ?=
 =?utf-8?B?cVNaVndXN1hvNzZNZ2cwUU5TTHEwYzZ6aGFLYytYbmZXdm9YUmdOZ2ZtWWxB?=
 =?utf-8?B?djNnaUJObXU1ZkhwR2NxM2ZmVXFIY0R6NnhZUDlvUm83WGhjMER2OHg2Rmd6?=
 =?utf-8?B?OFNPUU94aW5ia3Y3UldlZVBGQkxnbTBKNTdHYmRJZnZieWRudmVKWG5uU0hF?=
 =?utf-8?B?Mm93cjdra0IwMDFCMDR0ZWNadWx4UFhKVUUrUWc5OUhjZGd0OCtMYWhmdllE?=
 =?utf-8?B?M1NnSm83WEhidnA1RHFzeWlZTDFJUC9hMWdObStyMmI3Y2ZSakVwa0I1bUV1?=
 =?utf-8?B?dzF0WllBVGtoeExDc3JUYXIrL25PdlJRQ2Z5eXVCWG5DLzRZM2E0RGE5azUz?=
 =?utf-8?B?UXh5VEJLSUJkdlJsY3FKOFZnVlhpcFJKakxXOS9vT0o4N1ZVRkFMeWlmc2wx?=
 =?utf-8?B?QUxLL3VWUUVtMGYvakd4RjlBaGtHVlNvM3NkTXdXNWlNZWgvNkIwMWVHQmVD?=
 =?utf-8?B?Z1U5TnIzcEtadERQYkNXaTBnWEFTQ0dYUmhab2NtV1NORWRoY2swbWtGRDVJ?=
 =?utf-8?B?Y216N1I2b3RhcDJ5bEdqcUFoZGlOSUJXN25oaUNDT2pnLzZ4VXRqdnF6c0NH?=
 =?utf-8?B?M2owMnY2bkNTZjR0SlphcFBiQjk4RmVLZVgySjA3cHFxK0RUOUd3dWFncnhv?=
 =?utf-8?B?NFZFQ21jNFltY012NjBNdz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NVFiQVpaTC82bzdKUDlYaW9YZll5TTFHemczYm84Z1V2Sm1uUENIVVZtSmFG?=
 =?utf-8?B?TzYzZFZBNjduTTlSbVY5OE0rQkUyaHFoWEE5N01GdTRJZ00wblp1WnpkblM2?=
 =?utf-8?B?dHVBRWYxMGZZWEtRQ1BFZ1M2RjYwejU5Q0VhdHIzUDJmaFhkbVVoUEFaTG1Z?=
 =?utf-8?B?V2pBVzNwY0NUby83YnpKMGxjaDhXeTl6dCtYS0ExY0pQRDRZVU0yT05sMzIy?=
 =?utf-8?B?ejJqZDRETjNzK2hRb0pGS1dxY1hrZWFpN3cwTHdGbEo1U3B1UzNMM1FxeEp4?=
 =?utf-8?B?Q2ZWR1JYdEQzUlc3aXg0S0RZeUtEM213cWNaNk1vMnZtTHpCT3BzQ3NlTG5L?=
 =?utf-8?B?b0haT09BcVJsb1BsMVM2SzhBUVdrSE00YXdpUGpKVVZnNHpsS3o2cHlrcDdM?=
 =?utf-8?B?ODJFYVlZRm8zOUNvUDlMTVM4cGtMU0phVGxBUHZ3Qmp5RGZZTXpDTFgwS1Zm?=
 =?utf-8?B?OE9YL0t4RmJkQVdlNHN0RVRRZURtcTViT2JQUkdYYlZPckFXSUxiNWlPT2M0?=
 =?utf-8?B?NzhYdWV3MXdUKzJNUSs3cGxlQ05nWmUzbnFmNmt0N1JOWTVUR1IzVGJCQWQ3?=
 =?utf-8?B?SUMySWowUjBEV2JOYy91Skt2TW9BdWJYV3djcXJkR2xGZll4Y1llc3EwaHJC?=
 =?utf-8?B?RWk5VFljTzJKVDVJcmgrZk0yRXpkcWVuUEJFeFJXbFpIOTA5SkxpMlJHQXJ3?=
 =?utf-8?B?bS9VakZZdk9VVGhHYTVJaHhYdjFJSllra3Ywb0FWVVhDeXFsTWlaRUV3bXlr?=
 =?utf-8?B?aEtuUzhUSWg2cm1VVlBoTjl1L0p1UXBUa2IyUWg1QWVBY1dYVFF6b3BMYTBO?=
 =?utf-8?B?OHBjTGM1anJyV1BwbFZTMHlPMkdJcjA4K2JWZWdxRVFQbDdDOWZrTm5Mc2N6?=
 =?utf-8?B?MllPQmRRUmcrbVhKUklITHNqT0ZWTTV6eVp6RlBuM2N3cjdqMFljWDJmWjRz?=
 =?utf-8?B?WlN0Z3JUUUgzeUgzaElWTngxQ0lyNU9WQXk1L2xVZVBla0Eyckg5aEhGU3hD?=
 =?utf-8?B?Qkh6SzFqTk15aUFkcHgrNHRqb21NQ096SXNlbldlKzJnYTM3ZG9MZXl6ZjZu?=
 =?utf-8?B?azc3bkZ3VTNGT2FYaGR5REhna1FnWmQ1STEvM0lJUFhVVmp2T2dpOGZFbFp0?=
 =?utf-8?B?eHVQNW41UU41SE9hcUVLR2t6enNlN0J1aEZhak1lcnZTY1dFcXJaQk9PdHNn?=
 =?utf-8?B?UnVCNDlSV24xUzFVbmVXSW8rUWV4K2tjOGFnOGhoMEt6Y0FIWFdPaHg2RlF5?=
 =?utf-8?B?ZkFqWmxOdU0zcWRGQTJUK21YNVBFcEY1My85UmdoTC9wUUZNSDdTZmp1VFUz?=
 =?utf-8?B?K25CaHpuM3JtNkZQZ1VibVJpNk1zQU1sNEhxY0IvbVdDRi9uMmtrekp4Wm1P?=
 =?utf-8?B?ekkzeUZUbFgyRWVUUkZnUGhxemlVOHNiVWVnUzlIeDUwU2oyTVFkVTdYdGRa?=
 =?utf-8?B?cktCcDVtWGlYdi8zdzlnaU1CZXJzKzJ5dXlJOFRVZlpVRGY4QS84RTBFYlhS?=
 =?utf-8?B?bDllOUQvczdjWkJFNENScVo4N2xpMnMwdm1NeEt1T05KWTZkYk9MeGttWHRJ?=
 =?utf-8?B?aW4rYTdiZXhFcFVyZXVXQmtZWGFyUFBwa1Y1WEQ1V21DOUxRRjNIdHFBRmZr?=
 =?utf-8?B?ZmhlVjVxc3JKYmR3Y2ZObmRMSlVxbU8xWnhEY2Z6S0JKSXUwUlh5T2tTMURy?=
 =?utf-8?B?SHNubTBoWUFDQXE4NFdobDF4YVZOanY0ODA0U2EyN1BSdDBhakRtZExhZzQy?=
 =?utf-8?B?ZkpCUjJOeS9lZDNsd3g5bG92SlBBV2t1MUQ5NllGQklTcVZkRVVsVy9Fb2Zx?=
 =?utf-8?B?SXFtZ20zQk15anNWUklNaFFEdFpkRFR0d05Pbk1hVjkvNFY3YXJXRG1jQnp3?=
 =?utf-8?B?UGl0L0hicG4xK0hRSUpjQ00vNjlOdmZhbjFXZVg5U2x3bXhsSUZGMWxiSDI0?=
 =?utf-8?B?T2FveXFqVEhGVXNZaWdKMDZBUW9jWUJVbW1VeWtJbTJsdG1kTWhNNU5yekpN?=
 =?utf-8?B?cE1seXBlNEs5U1Y2R21RNTd3UndZMnNqT1ZURE1BYzkvR3F1WjBDY3RoY1lN?=
 =?utf-8?B?RzUrZ3UwTjBhTGhzYkhMbmt2NEdabVZwZS9IeS9TbEJzbTdKMHl3Slp5RytL?=
 =?utf-8?B?RXdIeE4zcmRYWEhmYjIySk0xUXphTHFZUjdscGxaODMvbnZnekF1cTA4ejFI?=
 =?utf-8?B?blE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C2C8D8505A3D114684883BCA04081C4C@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eb39e39-1b08-45a0-844d-08dc5eb9890e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2024 08:36:54.0923
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bB1m4sOl/IE2JTktjPpRlqvYrH+kWUEwJwoisTMrPB46/Q2308N1AIRoXfzcaH6lK4FWngJ/lwda0RoE7avI/nZrCnMm2fYmpCsPiNpyLdw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI4PR03MB9114

T24gTW9uLCAyMDI0LTA0LTE1IGF0IDExOjMyICswMjAwLCBNYXhpbWUgUmlwYXJkIHdyb3RlOg0K
PiBIaSwNCj4gDQo+IE9uIFdlZCwgQXByIDAzLCAyMDI0IGF0IDA2OjI2OjUzUE0gKzA4MDAsIFNo
YXduIFN1bmcgd3JvdGU6DQo+ID4gRnJvbTogIkphc29uLUpILkxpbiIgPGphc29uLWpoLmxpbkBt
ZWRpYXRlay5jb20+DQo+ID4gDQo+ID4gQWRkIERSTV9NVEtfR0VNX0NSRUFURV9FTkNSWVBURUQg
ZmxhZyB0byBhbGxvdyB1c2VyIHRvIGFsbG9jYXRlDQo+ID4gYSBzZWN1cmUgYnVmZmVyIHRvIHN1
cHBvcnQgc2VjdXJlIHZpZGVvIHBhdGggZmVhdHVyZS4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5
OiBKYXNvbi1KSC5MaW4gPGphc29uLWpoLmxpbkBtZWRpYXRlay5jb20+DQo+ID4gU2lnbmVkLW9m
Zi1ieTogSHNpYW8gQ2hpZW4gU3VuZyA8c2hhd24uc3VuZ0BtZWRpYXRlay5jb20+DQo+ID4gLS0t
DQo+ID4gIGluY2x1ZGUvdWFwaS9kcm0vbWVkaWF0ZWtfZHJtLmggfCAxICsNCj4gPiAgMSBmaWxl
IGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUv
dWFwaS9kcm0vbWVkaWF0ZWtfZHJtLmgNCj4gPiBiL2luY2x1ZGUvdWFwaS9kcm0vbWVkaWF0ZWtf
ZHJtLmgNCj4gPiBpbmRleCBiMGRlYTAwYmFjYmM0Li5lOTEyNWRlM2EyNGFkIDEwMDY0NA0KPiA+
IC0tLSBhL2luY2x1ZGUvdWFwaS9kcm0vbWVkaWF0ZWtfZHJtLmgNCj4gPiArKysgYi9pbmNsdWRl
L3VhcGkvZHJtL21lZGlhdGVrX2RybS5oDQo+ID4gQEAgLTU0LDYgKzU0LDcgQEAgc3RydWN0IGRy
bV9tdGtfZ2VtX21hcF9vZmYgew0KPiA+ICANCj4gPiAgI2RlZmluZSBEUk1fTVRLX0dFTV9DUkVB
VEUJCTB4MDANCj4gPiAgI2RlZmluZSBEUk1fTVRLX0dFTV9NQVBfT0ZGU0VUCQkweDAxDQo+ID4g
KyNkZWZpbmUgRFJNX01US19HRU1fQ1JFQVRFX0VOQ1JZUFRFRAkweDAyDQo+ID4gIA0KPiA+ICAj
ZGVmaW5lIERSTV9JT0NUTF9NVEtfR0VNX0NSRUFURQlEUk1fSU9XUihEUk1fQ09NTUFORF9CQVNF
ICsgXA0KPiA+ICAJCURSTV9NVEtfR0VNX0NSRUFURSwgc3RydWN0IGRybV9tdGtfZ2VtX2NyZWF0
ZSkNCj4gDQo+IFRoYXQgZmxhZyBkb2Vzbid0IGV4aXN0IGluIGRybS1taXNjLW5leHQsIHdoaWNo
IHRyZWUgaXMgdGhpcyBiYXNlZA0KPiBvbj8NCj4gDQpJIHRoaW5rIHdlIG1pc3NlZCB0aGUgcGF0
Y2ggWzFdIGluIHRoaXMgc2VyaWVzLg0KWzFdIA0KaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9y
Zy9wcm9qZWN0L2xpbnV4LW1lZGlhdGVrL3BhdGNoLzIwMjQwNDAzMTAyNjAyLjMyMTU1LTExLXNo
YXduLnN1bmdAbWVkaWF0ZWsuY29tLw0KDQpJJ2xsIGFkZCBpdCBiYWNrIGF0IHRoZSBuZXh0IHZl
cnNpb24uDQoNClJlZ2FyZHMsDQpKYXNvbi1KSC5MaW4NCg0KPiBNYXhpbWUNCg==

