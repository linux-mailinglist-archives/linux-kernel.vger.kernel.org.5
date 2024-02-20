Return-Path: <linux-kernel+bounces-72699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C40785B784
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:31:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AC562886BB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D69BA604A9;
	Tue, 20 Feb 2024 09:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Q91zewUP";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="CSUAog8O"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17CC5FDC5
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 09:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708421438; cv=fail; b=XvkOehss916ccymAqEiiQquAYWPuYqBSwCjPwMJcxecLK/J35vw+s6IxlujjWff99m3li+aKgehmWmtpIlhNBtPATEM2Gla/7fHxdD0KZL4hXjfKVdAPVDz4FK/ajYyRFKmsbdMM8idlkldJUdKHp3/hAWbJxxQwiPx4BSBUwnE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708421438; c=relaxed/simple;
	bh=SmS2R2/xnNzkZ+l4nJwwVa0vHnWAUHSzNi1JWY6oJR4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=D4fZuSiXCYIMHTB5nrEc4ljOpEhaF3bXYG5bzcrMcmck996ja8m1eNzrBQhdsCaXYUIMX7oZM00XuElPIsrc5O0zP1J2Ez+AIWt2WwhTSegSo5HFS8MpImdHP+IXd4HEZLWzs+Mm2Um7Z1Gq3rYSTdptI4NaxmrMSoRcsmfztBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Q91zewUP; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=CSUAog8O; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: b16e2d66cfd211eea2298b7352fd921d-20240220
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=SmS2R2/xnNzkZ+l4nJwwVa0vHnWAUHSzNi1JWY6oJR4=;
	b=Q91zewUPq5/Vj0R0pn0k+tIrgrt5+AHQKh43PPwFQXLzFKziNdbC/KgkcyzC/Fm+1pvSx4ya22yP4NeU3ECDb+YSsjLPghTqsRZiNoQ9qmGGB7i26NmudiEAFyHmvU/FnDubmsLAz7wdX+BYcm9uxqmxenkpC8rDvpLMTdgZTIQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:0ed9aeb9-5a56-4fcd-b7dc-f88457328388,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:72579980-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: b16e2d66cfd211eea2298b7352fd921d-20240220
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 297780706; Tue, 20 Feb 2024 17:30:32 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 20 Feb 2024 17:30:30 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 20 Feb 2024 17:30:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YhnvIbaJivbB6GtHBmrI7b6LFTmxBPqEqa7w0jkXu+le5pmbYLbYrefXfRAtY0I2cDFJ+fCFBr5JuuZKvXs0c/8ctTLANpyyvzrKrXIvWbQdog73yXbIEm35KjST5PR6KB0b8gotOJuUdm5FxKyE4qeUh52L8B6taQqVG7M0zpzgCBFtoONlulB0bodd5Yyi//BnkJbM/C4d/Q3wT8EssrgWym1JR4aWk8eNbJuHxD4f4YKOQLAbpLdW+Ndan4VOdHX32hkjcUFTIsfxRdYQYj7sxvuHFWsXk+VH2Rrir4WOYzLPCrg4Xzuembq+liGmsXafsrPOji07xloROo9iGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SmS2R2/xnNzkZ+l4nJwwVa0vHnWAUHSzNi1JWY6oJR4=;
 b=SdBzCoCPAsvYUPU7QDcfyzQT85GRbMaVX+01A4mzlQJQ5s9guZrSkre4XJibEIJhW2L7KwkOIT2/77uJHKUav9160Rit4Zb8QlLvSem4A4HKA72eqwH454gKj02ZVtAZWXJ/V+g9QL4O5//r5XBxJEMY58bB0+pv3YXwd1zb4JScgKDsa3Xo8u6OIADLMk73G9VzulwPaAIVWPy8gKIl9GWOfBKP6bnC/APC0pT7liToHn8iuLnjvZLBWxOytPtuj98S85COzvF+MHIjXW8j6ZiXAn4dpYdYGNCkG/OheBYjqF7Dl2xjwC++Qee4ToIaIAcThp0pa/1yNXzd6MAt9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SmS2R2/xnNzkZ+l4nJwwVa0vHnWAUHSzNi1JWY6oJR4=;
 b=CSUAog8O5oLuyE0EuQWdYAobb/miSiP48T9uslTwbZhF3/2NZMgf6FPpnfTYdyXtYAc5wC+TBo8eJIIDHmAofbQpdzreLm2l1C2VdOvT+fAEqH8be2tj5ncuoE6pYNcWeugwRgDJo1PUqbqnevLmV6uHtp6Ugjnr8ybGzcgX1o4=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SEZPR03MB8313.apcprd03.prod.outlook.com (2603:1096:101:19c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Tue, 20 Feb
 2024 09:30:27 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::b705:ea58:46d:e98d]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::b705:ea58:46d:e98d%4]) with mapi id 15.20.7292.029; Tue, 20 Feb 2024
 09:30:27 +0000
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
Subject: Re: [PATCH v2 2/3] Subject: [PATCH] drm/mediatek/dp: Add HDCP2.x
 feature for DisplayPort
Thread-Topic: [PATCH v2 2/3] Subject: [PATCH] drm/mediatek/dp: Add HDCP2.x
 feature for DisplayPort
Thread-Index: AQHaV/eVzqRhxdMZlkypH21h174pubETDu6A
Date: Tue, 20 Feb 2024 09:30:27 +0000
Message-ID: <40e68d74c0bb0df15f610fde017116357b40560d.camel@mediatek.com>
References: <20240205055055.25340-1-mac.shen@mediatek.com>
	 <20240205055055.25340-3-mac.shen@mediatek.com>
In-Reply-To: <20240205055055.25340-3-mac.shen@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SEZPR03MB8313:EE_
x-ms-office365-filtering-correlation-id: e412ba42-e129-4ecf-9149-08dc31f692b0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FUNo8beYLdb0IcaSfmupKBtUsB8aj8Bca5K+dZn06NJ7lbiqPc+k96MVNDAngx5uyMS2cj/RomhjPbtaQknksrRcarHy3bjRm80yVd95E0ONydvP0ymVdbZSuTuqNHNoah24cwcyriObCwmczbk+FI37Wv3b/cycdfgkEa8QXKFNG+JumyBJvzP2PLaxkmgT8/ZCQBfpbkSPrVU8jlXXkb0J/2bhaazTHMc7rJHbQr9BATimJYuPfm3tVpHORjqQKYAVHdJhH3jOWbMLcVFkBiuVkJI2fhjDTKMx6tPp86LIx++YHalh6dtQMlXMgNUJE3qhznnKzVsenmsZWIdLVaRXLLdnKj1jJfQSs43vusFMxrFPbE4Z0goaJ3dKDiw0yBbppZq0KjmvJvJMB6WrG8yuMHlPgQZgBci0COPDcNRC8FMOGoprgvlY2g/+tz+EX8kBz1Pz8CwNCBcHLNib+kelL7OtevCegZcYcly8vpR6zNSbFJbqlj/iC0hNtSBys8ma9iGkfdrfX2d2edpYaHdfTnsjrEKzswu/RToIyeKpFlrmVsnLSTCPy/+q0Dm+8Bp6HNMGV3ZLMB6qeS16v4ICPeQTvgIEY5KTsE51U+s=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZzFpa1R1L3p5MTBiVXdzUG84Rkl6b0dLTUlnK2pWUDJqZEVmNG9sTkw5SGVq?=
 =?utf-8?B?ZmFCTFpIRVdjMEZpU21TaFAwNUUraXhKbnVrUzhpdHBtN3VOUGtRbUdIMGJL?=
 =?utf-8?B?MURpVHAxNERydkV4V0VHZmF6SGhZOE5YZTFYUzlmVXJOY1VtVElxK0xPS3Ry?=
 =?utf-8?B?ditUUkhDY1hGdVVZV09DaW9rT1BPMFdLSit5NXNDR0IrcnIyTXlLcjNkWXJo?=
 =?utf-8?B?K0g2NVlyd3NYVzVIY05tVjRRbUtJdUI5dnA2L3VrNytEY3V0azNjdGhtcXVQ?=
 =?utf-8?B?WDFRUDFLOVJJaEtZNlluNWRGaW1ROHE5WXRmUzJ0OXZKV1FpUG10dzJSdVc4?=
 =?utf-8?B?eklkVjBlMXEzdHQ3QUxEcEJMTXc2RWNoNjdlcVJLczRCd3dFQTJNRUJkVmdh?=
 =?utf-8?B?TnAzYkhBVXdiQm5DNGllcGN2UWdoQ2Yza253NytWdjF6M0gxMHlVM3pXSk9E?=
 =?utf-8?B?MTRFZ0plRWYyd0JjTFIyQThhbTM3a0dGRmZYcFpGL2EzUmVVTHArQnUzY1RK?=
 =?utf-8?B?ZVE4cTJsbkVseE0rMThLNXdZems0Nkx6ZXIvYTJWSUVPRndtRGd2cjloWFJw?=
 =?utf-8?B?TnoybzZkdnlIZi9yaVdhWDFwNnBKNGJtYldmbW95WklDSXZ2WEo5bTE5aU11?=
 =?utf-8?B?Sm9UL0F0Z281NldBWVhkS2VyT205QzlRZzVwbklTOHExNDNQOERLTFVyWE9n?=
 =?utf-8?B?ZGtWZ3FyQ2NQRnhjT0ErbXFDQis4OWZlbGFBSE1aVkxvOUdyUUh6djJ0U3pj?=
 =?utf-8?B?SDN1TkJLZHA0aVNoTmtsQTAwMGN3djJwbm9pQ3prRG1EMlFkeUNJSzF2QkhY?=
 =?utf-8?B?TWh4ZVJldUdveXFOOGMyMDJBQllrNGUxdktJOXo0L1lKdDI1dzhyS2xZODB5?=
 =?utf-8?B?S2VXU3VlRFkxTW1Ia3ZlTEk2SWpKeHdsQnhCSGZuc1dLNmFGYVV1Y0RHakJu?=
 =?utf-8?B?SXlua3VYeElpR256YS9CMXcrMGx5TXlhZkpJQXNuVGVsN3lJekYzSVlSN0FP?=
 =?utf-8?B?NEtLaTh0S1ZBQTNxQXVGRXFYQzN5Q3ltZi9ObFpTOUdLakJnbzZqK3JEQnNZ?=
 =?utf-8?B?Rjk0TmZQUTdsZ2wvQi9uR0RSU0pXejczUldQY1dkSUhncnBIK1MxSWVFeTdL?=
 =?utf-8?B?VTFac2tQcW9JQzQ4M0JkME9MRk5xMWRVTXh3bjVDcFBGVlp6T2J6MXNFTUVh?=
 =?utf-8?B?bXQwL1ZtQVFnR05Sdzg4VmZXcnlvY0xsYURvb1pDVk51UXpZK2dRdTRINTFG?=
 =?utf-8?B?WmZvK2RMSk1QTTV0UnRjYWxWdkpGc3Vod1dFWWdxci9IUHB5eU1TWGhROUw5?=
 =?utf-8?B?UFZmUGI4dGgrZlJsOXhFalJBQlo5S29GS1JXN3kwaE9JSDNOY3NxcjBKbVps?=
 =?utf-8?B?bGNSZExrVUV6Rm5YWW83bVQ4THZmUDNIdnR1UTZQSk9YQTZqZ1pwK25nM3k5?=
 =?utf-8?B?OTVvT3JJLzFRd2hGQzVpY3AydjY1eWdrQ1lIaXhaa0xtWHlHTzZUVko0YlFo?=
 =?utf-8?B?ejBaeHcwUmpKaVBUNkljc1B6bmVjbzRJZUtjQTZVdUpWYTh4MG1ZUU4rZUZN?=
 =?utf-8?B?cyttRGNoYVpEWE1uOXpCSmh5ODcxNlpSeHZhdk9PaTFseFNiYTJoUnQzbUhM?=
 =?utf-8?B?NVJJWW9Fb1RkdlRUZE1adHZDaXBDTE9IT20xcjVmVXNuSWlFNXZwTGJyYnp5?=
 =?utf-8?B?Y0hkYzVBaDhubno5OHdSWW0zaGdUa1JiRTNFWEptWmdnTE1ZWmord3pIMGxa?=
 =?utf-8?B?SDloSU5mWmtpeVp4ZXdjVmgvVStTa055VlJoeGJxNEtuRUIwdkY1d2RpSWpr?=
 =?utf-8?B?cEVUZDJrNFFNWHFya0Z3cXplWDdITVh1V3hmK0tGMklINjBuSlNSSWJzdENV?=
 =?utf-8?B?S0xiOFd6QmVWK2R5VFM1Mkd3bm1BaGg1c0E2TERld0dDZ1lPaWxQdEppcDV3?=
 =?utf-8?B?TzNQQ08vZkJDcDMxRDF2RTR4R2FzRmNxV2I4U3dpcXJrU3VhK2dUWUNWZkV5?=
 =?utf-8?B?TUdrQ0JpempXWWhlVEdpRHBtcDh0Y0ZzMzZ4UWFZdjlwcVNzL0o4bm5RS3hq?=
 =?utf-8?B?ZHpJMml4em5JUkFXc3MvTm5QS3l2Z21CUU53TjhVeVlIQmRBZnUwenZXeGpq?=
 =?utf-8?Q?C3UKe4LyfoTbPEtebii1Z8lfd?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9C2174EC44B74A4DA9C490BF9BF55C67@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e412ba42-e129-4ecf-9149-08dc31f692b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2024 09:30:27.2214
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cALnKKg6pF9dpkAYiGDwwYMRV6aQLP/+KaP5KnxHc8JWN9BQZv3bSatNDB3d3/8E2Pdx5mfR/twgqJ5WmXNQNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB8313
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--14.545800-8.000000
X-TMASE-MatchedRID: hls5oAVArl/4OiVTWoD8RNOdGz1/8ORmjLOy13Cgb4+qvcIF1TcLYPFN
	etD9U62QbRtsJGVmCs+NsQYXWuFqRHAvdl/gU+kW4T0EFRcNxxSP/EshoNKyEQKCOvtvTK0ZJD8
	PHc/p2HKxMJ5xZ0J5p43/d0NuPcI1YnWYuJfXlIaWLCkl1lq7B5l/lu28zzkB+Cckfm+bb6AAKi
	VXSMAOPZg52AtDX+UKWr10g8+tn8khpU+BT6ShURWCVBr+Ay98SoCG4sefl8RV1D0dmUzw/Gpmv
	Ls8NP1PKdA/AzTgJLIy2ii2lrm+D0L9tcyTZdAsgxsfzkNRlfKx5amWK2anSPoLR4+zsDTtX28x
	NpU0U3OlGgOhjRbnBxN3zSL68WzhmqXm/GSXhci+JzihxrEf9A==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--14.545800-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	5B590F293C9835E81AD84D31DC551F88E6740E8AB0F23A61DAB6D839B9AE8EDA2000:8

SGksIE1hYzoNCg0KT24gTW9uLCAyMDI0LTAyLTA1IGF0IDEzOjUwICswODAwLCBtYWMuc2hlbiB3
cm90ZToNCj4gQWRkIEhEQ1AyLnggZmVhdHVyZSBmb3IgRGlzcGxheVBvcnQuDQo+IFdoZW4gdXNl
cnNwYWNlIHJlcXVlc3QgdGhlIGtlcm5lbCBwcm90ZWN0IGZ1dHVyZSBjb250ZW50IGNvbW11bmlj
YXRlZA0KPiBvdmVyIHRoZSBsaW5rIHdpdGggQ29udGVudF9Qcm90ZWN0aW9uIHByb3BlcnR5LCB0
aGUgZmVhdHVyZSB3aWxsIGRvDQo+IEhEQ1AyLnggYXV0aGVudGljYXRpb24gaWYgdGhlIHNpbmsg
c3VwcG9ydCBIRENQMi5YLg0KPiANCj4gQ2hhbmdlcyBpbiB2MjoNCj4gLSByZW1vdmUgc3dpdGNo
IGNhc2UsIGFuZCByZWZpbmUgY29kZSB0byBtYWtlIG1vcmUgY2xlYXINCj4gLSByZW1vdmUgc29t
ZSBkZWZpbml0aW9ucywgYW5kIHVzZSB0aGUgZGVmaW5pdGlvbnMgaW4NCj4gICBpbmNsdWRlL2Ry
bS9kcm1faGRjcC5oDQo+IC0gdXNlIHRoZSBzdHJ1Y3Qgd2hpY2ggZGVmaW5lZCBpbiBpbmNsdWRl
L2RybS9kcm1faGRjcC5oDQo+IC0gZG8gSERDUDIueCBhdXRoZW50aWNhdGlvbiB3aGVuIHVzZXJz
cGFjZSByZXF1ZXN0IHRoZQ0KPiAgIGtlcm5lbCBwcm90ZWN0IGZ1dHVyZSBjb250ZW50IGNvbW11
bmljYXRlZA0KPiBwZXIgc3VnZ2VzdGlvbiBmcm9tIHRoZSBwcmV2aW91cyB0aHJlYWQ6DQo+IGh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC84ZmZmNTliNTU2NzQ0OWQ4MjAxZGQxMTM4YzhmYQ0K
PiA5MjE4YTU0NWM0Ni5jYW1lbEBtZWRpYXRlay5jb20vDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBt
YWMuc2hlbiA8bWFjLnNoZW5AbWVkaWF0ZWsuY29tPg0KPiAtLS0NCg0KW3NuaXBdDQoNCj4gIA0K
PiArdm9pZCBtdGtfZHBfY2hlY2tfaGRjcF92ZXJzaW9uKHN0cnVjdCBtdGtfZHAgKm10a19kcCwg
Ym9vbA0KPiBvbmx5X2hkY3AxeCkNCj4gK3sNCj4gKwlpZiAoIW9ubHlfaGRjcDF4ICYmIGRwX3R4
X2hkY3AyX3N1cHBvcnQoJm10a19kcC0+aGRjcF9pbmZvKSkNCj4gKwkJcmV0dXJuOw0KPiArDQo+
ICsJaWYgKHRlZV9hZGRfZGV2aWNlKCZtdGtfZHAtPmhkY3BfaW5mbywgSERDUF9OT05FKSAhPQ0K
PiBSRVRfU1VDQ0VTUykNCg0KRG9lcyB0aGlzIG1lYW4gdGhhdCBpZiByeCBkb2VzIG5vdCBzdXBw
b3J0IGhkY3AsIGRwIHR4IGRyaXZlciBzdGlsbA0KbmVlZCB0byBjcmVhdGUgdGVlIGRldmljZSB0
byB3b3JrIGZvciBubyBoZGNwPyBJZiBzbywgSSB0aGluayB0aGlzDQpzaG91bGQgYmUgc2VwYXJh
dGVkIHRvIGFuIGluZGVwZW5kZW50IHBhdGNoLiBJIGxpa2UgdGhlIHBhdGNoIHNlcXVlbmNlDQp0
byBiZToNCg0KMS4gU3VwcG9ydCBOTyBIRENQDQoyLiBTdXBwb3J0IEhEQ1AgMXgNCjMuIFN1cHBv
cnQgSERDUCAyeA0KDQpSZWdhcmRzLA0KQ0sNCg0KPiArCQltdGtfZHAtPmhkY3BfaW5mby5hdXRo
X3N0YXR1cyA9IEFVVEhfRkFJTDsNCj4gK30NCj4gKw0K

