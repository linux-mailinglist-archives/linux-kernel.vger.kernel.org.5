Return-Path: <linux-kernel+bounces-82854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2F8868AA3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 09:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF2B41C2116D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 08:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B465645E;
	Tue, 27 Feb 2024 08:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="nqa1fcZv";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="f236OqnW"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F651B28D
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 08:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709021660; cv=fail; b=JThx9gSaKOvYZnrrO11HrlktZXnJr/haWQy5swH0DHtPOac8vYkF3X7Af2XKrjedAHJ164OzpmfUixaoMK9G59v5z1TLDDJ88USvMOX1U2e1MWZY1cXl0yrA9ToM4h0HVJDvbN4pPEG1WmdU0uOmGxguQEnztvwvS+/P4Akk7mM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709021660; c=relaxed/simple;
	bh=AvBeWVSZLAkftZhTbGRVF1ZRK7mavGUe4JeYerb/K58=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sbBdl/ggxoDgkO8a5P+93WgoQAIAAxa432nu04L18VObCbem2et0H1vy7DQogK2T6umnV/7pOn3Pg6TrcwcLINORm9zolJmGyud4aYIvUV/e9LRHZjWfx8Xrt9/jM2VXWGkSpm+J/A9ivw3g7dJp8XQ/NaRWOGhCqBaLTrD3jso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=nqa1fcZv; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=f236OqnW; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 315b3814d54811eea528b71b88a53856-20240227
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=AvBeWVSZLAkftZhTbGRVF1ZRK7mavGUe4JeYerb/K58=;
	b=nqa1fcZvPqhUDJH24WoGowWWGoJibXZLJIbJqvtEW8U3Oyk1mZL1A7Zoq9PT7RYAWzd3OcNR4uMkNL4X6feGw7GjPxJFlnEgWBJkmALLhrDp/XAKVgefTwelgFisG39QOehLWm27aZxJlsa7XzRaiir5NFmfVVjuFnFP65eSZMU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:f76541b0-85fe-457e-9ab3-cf2b3128b631,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:ccbadd80-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 315b3814d54811eea528b71b88a53856-20240227
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 208036580; Tue, 27 Feb 2024 16:14:13 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 27 Feb 2024 16:14:11 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 27 Feb 2024 16:14:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PpO4SAKlUYDWzv2TqLGrxCaW4FNEx6qMYBrSe1lyIVfSuC4Tmb3s/HgFkQVZJ08EoPCG5Lt2CvTyCXqsHqMRWGpP/mmHZfxCDuv6pDZxm94n0OetdPFu62tC0fmJ4vh7D4Mdm2JR3Wy8pEBVhUmfxl+dnTs/JUzLJrI9e6W1neASfdbzi5e0ZHKMqw/o3i53DWWYIuXNPrIEuvBda5F7PwnP8PblCEMnJbAv4rmMouqyD67Nsc8dTeTYfxQnK0yqsikltjLI2cUJ1h/KkXVtsSv5QPJUp86RZEAX4l/+4lPweWiccBbptx/hVU5hTRzJQ8wb1keC1Owun1Zfyyml+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AvBeWVSZLAkftZhTbGRVF1ZRK7mavGUe4JeYerb/K58=;
 b=CaI1ZXhI8I9nfzVGwhho8mm8VESt3xGzN7LxRzU22zTaGM1EElWiKn/QmvRQdk7t5kxP9bgPz1pZciMW9vgV+uXEyr5fUX3gKAPN7pGN4aYDXmIrmUFyEJB5A5TgwBrc0r/R5glVmH4THQEXQOZlGxLkAYwIuB4gRIyL8Cjb5GkRhZLbbKcm5iQ39v21e05mNiM+95sTEIBP4aC/gMZLmioNI3tQiJeqBslMwogfTWqPYsYAcuipWU5U9zQJo3Ty2HB7BD5Yxz8eRxYHOlj25+MTLILBjaRhmDgt/wMFgj8v2pMo1jZFeARKXOWWxF1z4qnGLQOqDST40WISvmp5Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AvBeWVSZLAkftZhTbGRVF1ZRK7mavGUe4JeYerb/K58=;
 b=f236OqnWyDUEMLLGNX4AqmGrXbcY3JuOCF1ubNZXA+L7RHft5c8qKeXmbYcT8OzkC+UIzHgPwlY2kLRe9G8y7FyHyuWzGqS02AA7iQpULcC+mElSmfO0ZJ+fAy6/6sExHnzHcBLg6xHcuIMdFSVW1NH3Odgq9lYoNrDVchn97Ac=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SI6PR03MB9011.apcprd03.prod.outlook.com (2603:1096:4:235::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.33; Tue, 27 Feb
 2024 08:14:09 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::b705:ea58:46d:e98d]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::b705:ea58:46d:e98d%4]) with mapi id 15.20.7292.029; Tue, 27 Feb 2024
 08:14:09 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>, "hsinyi@chromium.org"
	<hsinyi@chromium.org>
CC: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"daniel@ffwll.ch" <daniel@ffwll.ch>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, "airlied@gmail.com" <airlied@gmail.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH] drm/mediatek: Fix a null pointer crash in
 mtk_drm_crtc_finish_page_flip
Thread-Topic: [PATCH] drm/mediatek: Fix a null pointer crash in
 mtk_drm_crtc_finish_page_flip
Thread-Index: AQHaZp6uCxX/Olds0UOo+3OyRrC7NbEd3KOA
Date: Tue, 27 Feb 2024 08:14:09 +0000
Message-ID: <082175a61ae84984120407e415b8858760e43763.camel@mediatek.com>
References: <20240223212404.3709690-1-hsinyi@chromium.org>
In-Reply-To: <20240223212404.3709690-1-hsinyi@chromium.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SI6PR03MB9011:EE_
x-ms-office365-filtering-correlation-id: a8d84d6c-c76b-44e2-cea9-08dc376c1332
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Sv/EvsuhNOUvgaRmyvZHVInswlT7qMjqCn72xORFfHP2+wxHvUpxNAa2i8tQ0XVnZOgJxKsguAjOMDkrgZY/x8Li/XZMZSi06YnQe7mQDGNhrKqHKHV9vIn5kqLnsiZcWz2Fq5MU2Oj04e72UO5Typ9CetTglir1Wid3FinqLE3iSdq1IaXYMbzqtDURjSrlaUDWHELxQhx3ILMnJhGVBvbRIkkajBfuz650u27bowG8EONuRChd1oJxfRRdy4Gt8uJs2aBigXL7ayGjRd4TEOlfbium8PR1e50nh0Pp5J9NaP/KFq9KkFpvIfjBmL0ni9hHBq4qD+1l+dJV7L7kVLxM7ZPUbTecCeeuZ4EDgkhJarH7u5ifr5P6ADpXSUNU6cnByH0LoBLFQQaL8G+uI5yCBLXYK6ZcSyNwJywD8k1b2hlYccumVFXp1e15J1agmmKpC14EoNXHw+oKEMgMWxEt6uk771F+4kRWDbxo96LRB1UcvkS92FUJvb9farPGZRs6AOJnbmwI/6xohllf4eZYdfccC6OmAK0p40uy0qmKk6ZLXaG9UEbRYtfKgiWq4tDCkk+zB8nnJBMtzDyRlY7lNk/evjm/RLIcENvRBAajhLr2xTUGFYPr13dAE+rX8m1CtkMpa3a1xCOClwy9R0jxJlhnLg987+m8wDOQ6TTldqOVf3htCVTNONS82tPOuKZZeXcgN2CE8eYJR4dt/nPXAoE6AwMm/E9rPXnNwsk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230273577357003)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TFcwcTBiV2ZoKy9KQ2xYS0k5eWtFQ1JHdHF1OTREUzIxejJrYWlGZUNtaThK?=
 =?utf-8?B?NGFMMktiQjFNTWhoL0JPK0V6N3AzS1Y0L2I3VjB4RnZhaVQwMGxaUDFmTVJ3?=
 =?utf-8?B?L0ZtQ2RUUXNxNDRCenliWDVhQUU5MzZtZFBIQS95RWJYOVZ0M1RQYWlPZXBt?=
 =?utf-8?B?NGpzeGhNclFDWi96ak12TE1ubVhnK2RHaTdPMzNwQjhSOHg2c3BjcU1Tb3Fu?=
 =?utf-8?B?b1J3VXU3K0V6Y2JkOXlkL2sxRWt2UUdlQUVtMDZkaTVGYm9TYXFEblZ3dDZu?=
 =?utf-8?B?a0Ywc1ZSVEV3Wk9WbjhVRkE5YnJUSlFNVWx3VytEYkpKZEVnbVR0V0tYb2VX?=
 =?utf-8?B?TTZIZUF0NTBsMjBZVUh6VUZKdjllc3BPSlR5ZVFlVjd2ZHJiV3I0OTIyeWlq?=
 =?utf-8?B?VWRSU2dFdHpLMzZLa1pCU2JWSStvTDlTdGpxcTIrYlpBMGl6ck5kK1dKcVJo?=
 =?utf-8?B?VjR1Qnl1WDBhcEQ1bVRxSnNseWdCTlY3R0Qva1kwekgvWTlnekRFNGJEbW0y?=
 =?utf-8?B?TFF3TFdtb3h1dlA5ZFFxdHlHdDFmaWgxb081SGtkK0R2UnBGa2VZZzM1b2V3?=
 =?utf-8?B?OVo0cGNORzlUSEF5eEtEN3ZmK2JKRG4yTldQNElzd2xYMFFBa2JqSEc1ZmQv?=
 =?utf-8?B?dGpNTGM3TW81NEZmdFBRc1lWYmhGN2RwRng0RDdvWW5TS1hRK1FqK2VsUXlv?=
 =?utf-8?B?V25leERSblhMNkk3aFMxNmJXd3RUYU9QNmM1SDkvVXZtNytXRXZud2U2NVlj?=
 =?utf-8?B?WU9abWZ1QkdYMklCQ2FGaDZsYysvN1lCVS9Deis1MkdYWTR4czI0Nkx0b3lz?=
 =?utf-8?B?VUVscGduT2k0M2RKQ1ZKRWpwN01qL0lPbEQ5MVltLzlBMmlRTW5Semx6WmZJ?=
 =?utf-8?B?RWhSZGMvMktCWEZRVnVGc0gxZ0k2OVZaRWZweUE0bjJPL1JBVUtEeS9McXhW?=
 =?utf-8?B?emhzRE1IeXpBZzVIU1p0OGhzN1BaZzRndmNseDh2ZlkzRlc4ODFWbHVyamxO?=
 =?utf-8?B?SVhOZWliWm9TWHAzSEFGWE5ROG4vMTdJeFpjT3IxaElXYktNM1FPTTZkY3NM?=
 =?utf-8?B?V3RBVmlWaE9zeXp5RnNXRGV5RThrUEhjZk5aRlJjVHlrNVd5K3pnSS9QRG1p?=
 =?utf-8?B?M2czU08rSXdpS09uZy9QaVkvNUpTVzhJZ3huQnFjM3dQN2ZreStxeS8yQ3Mw?=
 =?utf-8?B?MlVhdnlSUWk1aGdldExDaGx6SlVRbEk2MHBMVEp4bGxPeGVDaG5FR3FoNlZx?=
 =?utf-8?B?a3VJVUM1Q3JMNTQwTEh0a2JZcjg3a3c3M0F4Skd4VHIrMzlQK0Foc3lFYXJP?=
 =?utf-8?B?ZkhpYjdoRmNML0hsMVNlMUVIMHNOcDBhK3RiMG5sbjJWQ3lRNFcxQjdpQVZE?=
 =?utf-8?B?Y01XWi81VmZIK2V6b0tFeld5TkZkUGt1bGoxWUtTRWh4UGlBcmdkSHI2ZVpB?=
 =?utf-8?B?WXdrK1o4MXVTeVFHOTFBUWNrVnBWditQYnlGRVMvU2FJTittd2hjcDdEUms1?=
 =?utf-8?B?MGJFZGtxUlFlcnVWWEdWaUs5dVFHcGNPdEJ6NWNTa1FpTDNCb2FwRlpiNTVZ?=
 =?utf-8?B?UWNXeXB4Mk1JMWRINlZ3OGwzS3dId3hSZ21rWm1GaXg1MFNUbGhrbUt2blJX?=
 =?utf-8?B?RGdPRXZvOGNDTFdRaHNZVEFoRnJaVTBaeDVJa25rYnRsUnEySUhSZ3F1aUlY?=
 =?utf-8?B?SjZieHZCNzNXb095ZjV1N0JlU2cwNEg4TkN2NGlOTkhWZGp6bUJYM2htSXhS?=
 =?utf-8?B?dmRKSmdwZ0RLNyt5MjNzK3U0OVJxSHdGMWRkMlBDMDJmZVBCaUNERy95QTNX?=
 =?utf-8?B?Wm54ZjBOblNtY2JrUm8vSTN3MENvS1ZkQ1hjTlJjcEQwM2xuU1ptY2xrWDRT?=
 =?utf-8?B?dmk5ZW5pYTloSGRLOGVadUhiOHB3K1h2MERzODAvdXJsTkpzbjl1WVpabDUz?=
 =?utf-8?B?UzVhUEwyNFlURDdNMWxXcCtqRTNzYlFSb3dNb3FNT3pkNThlWXVaaER4ckxT?=
 =?utf-8?B?TG9pSCtxdldlYmdRTFkzQUtXOHRLK3lPejhDblBySDhFeWoyL1FrczRNODQ1?=
 =?utf-8?B?cC9FNktKTVQ5SlV5Z1d6QVQ3WndncjNoVm1sN2gra2VEY3JtMmI1VDUyOUkx?=
 =?utf-8?Q?RXAhtaOQ733bpafJptIfkTkOT?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4058CF381310D44695C53AFA870852A1@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8d84d6c-c76b-44e2-cea9-08dc376c1332
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2024 08:14:09.7419
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OZ2fk6XGbXG1HEx03Dh/x/L1XYMpXsE5M885VXBZeoT0/iGrbHAl+PHmrq0Oq6egwgUXwzfRMVzgiWF//L07gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI6PR03MB9011
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--16.461700-8.000000
X-TMASE-MatchedRID: QW5G6BKkLTpBfGdIwmVjfCa1MaKuob8PCJpCCsn6HCHBnyal/eRn3gzR
	CsGHURLuwpcJm2NYlPAF6GY0Fb6yCsEF95g58PMZyeVujmXuYYVaav/yaeMwbglbhF7ZTanLg1/
	MtS93eNKOpK41EOlzpXWQo9G3c0EkwrxsKoa/qe3huXUWQoMQt+OA/dVYgFAOv8D7QPW2jo/zmy
	QZlJGYkEDji1Vz/pS9CmjHXhV21s09S3IiQd+eNWNW0DAjL5p+EbxKVXd70tXfUZT83lbkEH3UO
	6dm0hoW4vM1YF6AJbY9l7H+TFQgdbew1twePJJB3QfwsVk0UbtuRXh7bFKB7qZUp7vkn1xhZPuT
	/Rx/pkhbwVkTQ6fuGBvyo5gGYud/aAZk0sEcY14=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--16.461700-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	1938535629E5B3FC1C415DE488F38E4AE25B5AC1C1E078F10235C58E9D8BBC712000:8

SGksIEhzaW4teWk6DQoNCk9uIEZyaSwgMjAyNC0wMi0yMyBhdCAxMzoyMyAtMDgwMCwgSHNpbi1Z
aSBXYW5nIHdyb3RlOg0KPiAgCSANCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNs
aWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQg
dGhlIHNlbmRlciBvciB0aGUgY29udGVudC4NCj4gIEl0J3MgcG9zc2libGUgdGhhdCBtdGtfY3J0
Yy0+ZXZlbnQgaXMgTlVMTCBpbg0KPiBtdGtfZHJtX2NydGNfZmluaXNoX3BhZ2VfZmxpcCgpLg0K
PiANCj4gcGVuZGluZ19uZWVkc192YmxhbmsgdmFsdWUgaXMgc2V0IGJ5IG10a19jcnRjLT5ldmVu
dCwgYnV0IGluDQo+IG10a19kcm1fY3J0Y19hdG9taWNfZmx1c2goKSwgaXQncyBpcyBub3QgZ3Vh
cmRlZCBieSB0aGUgc2FtZQ0KPiBsb2NrIGluIG10a19kcm1fZmluaXNoX3BhZ2VfZmxpcCgpLCB0
aHVzIGEgcmFjZSBjb25kaXRpb24gaGFwcGVucy4NCj4gDQo+IENvbnNpZGVyIHRoZSBmb2xsb3dp
bmcgY2FzZToNCj4gDQo+IENQVTEgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBDUFUyDQo+
IHN0ZXAgMToNCj4gbXRrX2RybV9jcnRjX2F0b21pY19iZWdpbigpDQo+IG10a19jcnRjLT5ldmVu
dCBpcyBub3QgbnVsbCwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0ZXAg
MToNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG10a19kcm1fY3J0Y19hdG9t
aWNfZmx1c2g6DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBtdGtfZHJtX2Ny
dGNfdXBkYXRlX2NvbmZpZygNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAhIW10a19jcnRjLT5ldmVudCkNCj4gc3RlcCAyOg0KPiBtdGtfY3J0Y19kZHBfaXJxIC0+DQo+
IG10a19kcm1fZmluaXNoX3BhZ2VfZmxpcDoNCj4gbG9jaw0KPiBtdGtfY3J0Yy0+ZXZlbnQgc2V0
IHRvIG51bGwsDQo+IHBlbmRpbmdfbmVlZHNfdmJsYW5rIHNldCB0byBmYWxzZQ0KPiB1bmxvY2sN
Cj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHBlbmRpbmdfbmVlZHNfdmJsYW5r
IHNldCB0byB0cnVlLA0KPiANCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0
ZXAgMjoNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG10a19jcnRjX2RkcF9p
cnEgLT4NCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG10a19kcm1fZmluaXNo
X3BhZ2VfZmxpcCBjYWxsZWQNCj4gYWdhaW4sDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBwZW5kaW5nX25lZWRzX3ZibGFuayBpcyBzdGlsbCB0cnVlDQo+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAvL251bGwgcG9pbnRlcg0KPiANCj4gSW5zdGVhZCBvZiBn
dWFyZGluZyB0aGUgZW50aXJlIG10a19kcm1fY3J0Y19hdG9taWNfZmx1c2goKSwgaXQncyBtb3Jl
DQo+IGVmZmljaWVudCB0byBqdXN0IGNoZWNrIGlmIG10a19jcnRjLT5ldmVudCBpcyBudWxsIGJl
Zm9yZSB1c2UuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBIc2luLVlpIFdhbmcgPGhzaW55aUBjaHJv
bWl1bS5vcmc+DQo+IEZpeGVzOiAxMTlmNTE3MzYyOGEgKCJkcm0vbWVkaWF0ZWs6IEFkZCBEUk0g
RHJpdmVyIGZvciBNZWRpYXRlayBTb0MNCj4gTVQ4MTczLiIpDQoNClJldmlld2VkLWJ5OiBDSyBI
dSA8Y2suaHVAbWVkaWF0ZWsuY29tPg0KDQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlh
dGVrL210a19kcm1fY3J0Yy5jIHwgMTIgKysrKysrKy0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwg
NyBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2NydGMuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9t
ZWRpYXRlay9tdGtfZHJtX2NydGMuYw0KPiBpbmRleCBkYjQzZjlkZmY5MTIuLmQ2NDViODVmOTcy
MSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fY3J0Yy5j
DQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2NydGMuYw0KPiBAQCAt
OTUsMTEgKzk1LDEzIEBAIHN0YXRpYyB2b2lkIG10a19kcm1fY3J0Y19maW5pc2hfcGFnZV9mbGlw
KHN0cnVjdA0KPiBtdGtfZHJtX2NydGMgKm10a19jcnRjKQ0KPiAgCXN0cnVjdCBkcm1fY3J0YyAq
Y3J0YyA9ICZtdGtfY3J0Yy0+YmFzZTsNCj4gIAl1bnNpZ25lZCBsb25nIGZsYWdzOw0KPiAgDQo+
IC0Jc3Bpbl9sb2NrX2lycXNhdmUoJmNydGMtPmRldi0+ZXZlbnRfbG9jaywgZmxhZ3MpOw0KPiAt
CWRybV9jcnRjX3NlbmRfdmJsYW5rX2V2ZW50KGNydGMsIG10a19jcnRjLT5ldmVudCk7DQo+IC0J
ZHJtX2NydGNfdmJsYW5rX3B1dChjcnRjKTsNCj4gLQltdGtfY3J0Yy0+ZXZlbnQgPSBOVUxMOw0K
PiAtCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJmNydGMtPmRldi0+ZXZlbnRfbG9jaywgZmxhZ3Mp
Ow0KPiArCWlmIChtdGtfY3J0Yy0+ZXZlbnQpIHsNCj4gKwkJc3Bpbl9sb2NrX2lycXNhdmUoJmNy
dGMtPmRldi0+ZXZlbnRfbG9jaywgZmxhZ3MpOw0KPiArCQlkcm1fY3J0Y19zZW5kX3ZibGFua19l
dmVudChjcnRjLCBtdGtfY3J0Yy0+ZXZlbnQpOw0KPiArCQlkcm1fY3J0Y192YmxhbmtfcHV0KGNy
dGMpOw0KPiArCQltdGtfY3J0Yy0+ZXZlbnQgPSBOVUxMOw0KPiArCQlzcGluX3VubG9ja19pcnFy
ZXN0b3JlKCZjcnRjLT5kZXYtPmV2ZW50X2xvY2ssIGZsYWdzKTsNCj4gKwl9DQo+ICB9DQo+ICAN
Cj4gIHN0YXRpYyB2b2lkIG10a19kcm1fZmluaXNoX3BhZ2VfZmxpcChzdHJ1Y3QgbXRrX2RybV9j
cnRjICptdGtfY3J0YykNCj4gLS0gDQo+IDIuNDQuMC5yYzAuMjU4Lmc3MzIwZTk1ODg2LWdvb2cN
Cg==

