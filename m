Return-Path: <linux-kernel+bounces-108319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C52880922
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 02:39:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15E8C1F245D9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 01:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D3BC79D0;
	Wed, 20 Mar 2024 01:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="OYKq4R5t";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="kFf8eQzX"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2F68F5C;
	Wed, 20 Mar 2024 01:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710898740; cv=fail; b=fX/hIWYU1QaYiPzDDSsMF6GQuGNFKKWL4LikCMuyVM+IjnYeI7XqT570Jnf6lzx7OCe2//Hzj0u5qXFJrHZhUpEK22p2Yea5hF6B05G9krQ+ZiQI8GUqgcmutVInVkybzbneM+wdn5LX/S5q/QvOzOomEpO6qNlcB1+IkUaEYlw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710898740; c=relaxed/simple;
	bh=BHxSuyVKv9wpM/x5gKryb779SYS+VHGtRWuTELOJk5M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DwF+MhEo0yTdGRz6AbLbexl8BGzWVLCmRy6VZh2yMT0P5eLvhGqsUl+/81e4+ngzmeIpiLmKNk48C1XmoddY+B1NlML+X2Y/2BF+hQvDWBGiA5MnVGk95jHzphWzPuJ1jt98wR+DLiQesXRUIJ+qg8Exz120BUzzJt5G2j5gen8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=OYKq4R5t; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=kFf8eQzX; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 9b7f9ce4e65a11eeb8927bc1f75efef4-20240320
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=BHxSuyVKv9wpM/x5gKryb779SYS+VHGtRWuTELOJk5M=;
	b=OYKq4R5tTxvJIBohLM+VFvhcvu1B++e4A/UzyjJxreggexZjc9NcXs7eJeAajiPEyqrqi3EU4eYDm1LCnoxYL8Mgshdi9BZ5Rmua64O4zhFyo0OJMi8uPhmnkkW1XDbFEYGli2drRgmrHtoJfcyXceA5l1tLXVKrhErk4UEz3YI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:ebd5b73b-890c-4e1a-8809-d6913d67711a,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:a181b281-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_ULN,TF_CID_SPAM_SNR
X-UUID: 9b7f9ce4e65a11eeb8927bc1f75efef4-20240320
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1182691365; Wed, 20 Mar 2024 09:38:52 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 20 Mar 2024 09:38:51 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 20 Mar 2024 09:38:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eWlJeTBf/ZSdNbG3qjy7avpal3laNpuWGyNbrZ73ib5UCdOW7+icjUjic1/g8J+S4sf2zXiBb2n05Ri1wVLIZtIm72H/wagsqLAMS2+t3iWIwqcydXjA+I1daE+uM6lHeI4hf6km1GlYLaT2rHxohVq/u4RLGZpPpFQfeiEa5lXPRKqgpmPwz0HCzCNvep3N+/Qt7VhPmsjwvDPo0TKcy6R9cpOeXVaCztO2g7LfvWZcaccGW7m/R940Sa3vkioEUGwoYod6MXBF5Qj5Z7GnKymXVQb+r8FU/8mX/52i/+Tc7vaYq8miPU3EwLaAwbFEWhWhYW/m8XKV/OGm/7t61g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BHxSuyVKv9wpM/x5gKryb779SYS+VHGtRWuTELOJk5M=;
 b=VfPnKr1sT/hdE82GdezmKDrnRrsIaDRK+AV1OV6a9kUqLpSTxyOyy7RyrK/5EktBx59NUbKQZCg6UHcLnbP/B0WCe6+5tWfE97fgXuJGk1WcPNC7vYwHA0L6xmMWn3WHf09tGcxAvvmBUaCN4f+MSYVMWaj+KMIeQqKILZL7YdC6Jzwu3iEDgegwxXRNdiH/bzGgj0sex4ulnB62svwn2VMRjN42sIFIas8dtvwkHmSmBfGqt/EceqtIg5aUZmUeIoP3yEK2Gb8nQmcqIca+ybSz5FCxzKGXdVqmG4+wT2ZeyBb1yydYzzARNcZxZ0VfCa6P6uj+QmrIhECiFG7byg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BHxSuyVKv9wpM/x5gKryb779SYS+VHGtRWuTELOJk5M=;
 b=kFf8eQzXgBuVdeQBaMb9Ib3mxzaKzTLcjVuD9ES9JT0kpZWtK98aF6iAd2TtaV+S9VzoKHx/PLqkQicqY6cV5NqXZtA6xmHm3ycQlcSyoOPdYIBvMvQJ+rw1vyY4V5wH2xcmlE7YEpXVePwKOXfg9FtR6FcOfKiuQY3f/heV4q8=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by JH0PR03MB8638.apcprd03.prod.outlook.com (2603:1096:990:90::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.23; Wed, 20 Mar
 2024 01:38:48 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::f3b6:91a7:e0fb:cb27]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::f3b6:91a7:e0fb:cb27%7]) with mapi id 15.20.7386.025; Wed, 20 Mar 2024
 01:38:48 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= <Shawn.Sung@mediatek.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
CC: "sumit.semwal@linaro.org" <sumit.semwal@linaro.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
	"christian.koenig@amd.com" <christian.koenig@amd.com>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	"daniel@ffwll.ch" <daniel@ffwll.ch>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>,
	"shawn.sung@mediatek.corp-partner.google.com"
	<shawn.sung@mediatek.corp-partner.google.com>, "airlied@gmail.com"
	<airlied@gmail.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>
Subject: Re: [PATCH v2 07/14] drm/mediatek: Rename files "mtk_drm_crtc.c" to
 "mtk_crtc.c"
Thread-Topic: [PATCH v2 07/14] drm/mediatek: Rename files "mtk_drm_crtc.c" to
 "mtk_crtc.c"
Thread-Index: AQHaecuwpYjArSGG4EG6vVFh+JpsHbE/2x0A
Date: Wed, 20 Mar 2024 01:38:48 +0000
Message-ID: <670e0d59d8cb49d4ed165e55b272fd33abd0d619.camel@mediatek.com>
References: <20240319070257.6443-1-shawn.sung@mediatek.com>
	 <20240319070257.6443-8-shawn.sung@mediatek.com>
In-Reply-To: <20240319070257.6443-8-shawn.sung@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|JH0PR03MB8638:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EO5V55zTZyz9VQkNfkSj8+fy7x5caQjRwiWuZPzRAmZd6P1UCCZUCSLir3+WPyqxOni8X7FpcIqrUaYrOnpmCamX3CC2UG5uO8403ExCaut/cdEXvk2uZwW07eVuwE1ZX/rR9a7u2f/YOlzXA2qRDvojYd/NDWIhiGpIMElemtT4GQ76Y5YOoI0LVGiNSLgvza2bHeKIvKkMvW4hgNX9ZV1sadZKCrQAOpU0gBIv07v6UJEHSo7fnD3qrfHWcZunDbC32FL1SBUWsRkROG5WKtiPoKGs2YrRBKlyRPwR2Fl8vdkQcTHmMdZaEEtvjRYs0/Cq/6DqNlJMoIJIwietMjqcrdGUxN7Rl2Yn8ntsXjFip4bflSrCkt0jeEPFZVXOQnAZd2I77GQKSF+eL82sobgsXCcLLy1Yk3ZSXi47vQppplO5T0AjEuURu65cY3vYQOfTHlODuMpcSX9fidF7Efur1lOQmP0e4w3xoon6ziul46W2wnyd7TZGW0/6Ok8wWRxFLtUgrsFCWp/pYUEYxPvh5dpxSp188mv4fsTTFA5RMWz+wTuMV7jGhj/HpwfjR1yH/g5szuv9dJj/xTXtGakFSrJ9JvpkLa8dagIazfL0XB6kIhyGn78epGKzbCLkuINQ/sBIgDc4OoviXkwYtHhqY6dT4WbMBXuVX8jEAJM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(7416005)(376005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?djdsRkJlRnRiLzEvMXJVaStmaXBDZUN2NEtsOElhMnBvTkpGRzFYa3RPZUJw?=
 =?utf-8?B?R2k2aUNJcmQyUnlsbWJUdTBQRjNoek1qWXB3NFdvaGx0bTF2WjNKbWduaWs5?=
 =?utf-8?B?ajJMWkJkbjdCa2Myd1c5WGhBdjVXZTNXMkFLWjI1U05RWXFrSWQxQWQ4Vlk1?=
 =?utf-8?B?eVpPcE5FRFRacVQrc3pNUkZKNU9BaGd1aFdCNHlrcmdJdkhKT3ozSTR2d0Vy?=
 =?utf-8?B?eDlLeXhHcmlxUlNibFdCSktRUFFqKzFjS2RsQmxXMGhuYTZYYVZTVVhLeGxn?=
 =?utf-8?B?NVZqT28rVm9mdVJSclZUckw5SU44NmQrbWE0YkNNZXovMkx0KzhXSi80TUwx?=
 =?utf-8?B?eXBDdStONmVjQU5SNllCUlRQSm5TaXJXUUhkSGhMQVlZSnFXQ0hFWTNJT2pi?=
 =?utf-8?B?RElsbEdUTk9sVCtST2ZJdHRFZXZnMytYbFRSb2drWk1VNzJGaWdyTUlJU1JC?=
 =?utf-8?B?Q3NQOEN1UWtwbkg0azdLeWVVaU5uNzhsdUREZ1BYVTRXdGhyVHV5QkxSSkY3?=
 =?utf-8?B?MmpvQjNZTG16UHVJM08vZElab3A5NmNIQzR3SzdYRGU5dkRvZzZjcmlzWVNO?=
 =?utf-8?B?dzN6OXNDci82a0ZXbjhQZzBKakJKMUNEcHFkVDFrajJtcXU1VlcycExjWlFL?=
 =?utf-8?B?MlNyek5yVDNjWjZSdXF3MXhyZDNERERCUHRibldoaTJNWExIU0wvTElmWEJZ?=
 =?utf-8?B?Y00rdnFmY1ZKQ3kxTlIyeThtWkpCWkN6ZzBnUmQxdjB5czUwQzFENFZjV1c2?=
 =?utf-8?B?aSt4a1VNZ0o2c0s1d0dkSTMvOUV1YTV5YWd3Szd6VXltNnlpSzFYMFczTUtG?=
 =?utf-8?B?bnh4WlRLeUZNMjlxd0VTRnNHQzRnUlVyc25qem5NQ3ZDWlNFalo0RHo0c3k3?=
 =?utf-8?B?TDN5MWpnUnJEL2lOeEFMQ2NiNUZ4UFp3ZmVxMmphOC9YR2gybHRYOGpqVEhU?=
 =?utf-8?B?aWJ6SE5jdE9nQjAyQ2NFQjBLOHRJUjBGOXpNRG5EdkE4ZmdxWDV4QVpNaEhO?=
 =?utf-8?B?azVPdjE2VDErYmNrRzh0Qk5LV2FJeTFFOU9WN3Nwd3NESlFJbUREbDczZHRS?=
 =?utf-8?B?UkVQMG1qMkl0WjdOR091K1g2aURjVHRRdDViOG5UL2tBR0MrNTV1QVpTWitI?=
 =?utf-8?B?TmwvWis0ZkRraDBPb2R5RDEyMEZrMjkvM2hSS0RTeHhnMHZxOFN0d0o5RHFt?=
 =?utf-8?B?d1RuMWMwcmFpRDRwM1A1Z3dRVWJuR1AzZlNOd2d5ME9TdUJOK3J5ZG8vZElG?=
 =?utf-8?B?T3UvSzVKcHhUSzZiK2FsZ3dlYXJ1SDd3VFJzOU9FYXVZUzZEWjRGRlhYUEQz?=
 =?utf-8?B?eWpQUDhWVHBzRE1NaHZmdlpaNHNtdjQrN085ejIzc1ZKSk9ybDNlSkZ4ajBS?=
 =?utf-8?B?clJCa2hleEhYc1BiRWVqQks4emU1REhGbXJaRjRIcDFHRzFKSFRZclI1YW5y?=
 =?utf-8?B?SUt4a2ZJQXFLRFVaTUhLU0dsRldvazBDZ0NwdXllK3h1VGVLVit6MXQ4aVU2?=
 =?utf-8?B?b0RQRVJLanZFMW5HUGQwZlJCbGxPQXdleUIveFlIZGV4a1RrUFAxSWhqYWQ3?=
 =?utf-8?B?aWVPQms0NHpXbHJ1MG9PbXQ2U0JKK0czcC9Rd2lrUVF2eC9KL2hDQ3ArYlI0?=
 =?utf-8?B?YWREbFcyalpMeEM3dkVlc0x5dERYRnJtbFRzUlllTVpTZER6V2ZDSXVVTUNN?=
 =?utf-8?B?Q3JOam84RWl6R2Q3Qm9TZk9IOFVsVzdtVkoxWjdjSEVtVG4vVjdMZy9wTkEz?=
 =?utf-8?B?dTU0a2ZKeHd1aUFCbVdnejFKVUFzNWEzbk91RXFJeXlpZUtTZGNIb1VXUE5S?=
 =?utf-8?B?RUx4NUMzTllFZEE5dDcxcnVOUEd4bXV4c21RQ3ZsSkFSdVh2emtzZWtSSnJF?=
 =?utf-8?B?V05ia2p4am5oeExBZEVUNnlmalppemd1Z1VRaXJKd0twMDJ4eFUwVHpIaWli?=
 =?utf-8?B?MFpQRTA4S2E1SXhaNmU5aE5Lc2NydGpmdk5kTkxiUERsVjZOTitac2tnVXRH?=
 =?utf-8?B?RGN1RWRMNStCM2V1ZzRjSGZwS3I0SFpGUzJGYTBPYTR4OEtDRXhFMWMrRFdN?=
 =?utf-8?B?TTZiRmpRNFM2WElhMy9tQjA0VGhwNU0zWWVONDAyK1NVYTFmYU9UcWtjUEFu?=
 =?utf-8?Q?jg/SMVCpeqws9mewqId2tJ3/f?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <39F45CE3DD583D409D2835FEE1B93D43@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01d91560-5770-4842-805e-08dc487e7d5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2024 01:38:48.5952
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O1bIemOTbAfNYZOutSM0bWFUAW0u7qUUuG2NYWt54jcfKOOqD5055jT13izD/yeRZHDpJEqalC3OBmm5nsquUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB8638
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--11.132500-8.000000
X-TMASE-MatchedRID: wQVy7q402w3+DXQl7XSOUia1MaKuob8PofZV/2Xa0cKSO6So6QGgysNq
	SYgiOmwd8cv4yT0rvGNUPHgTUudKRCUtdpGicV4RJO/EsSykoaBUENBIMyKD0cSiwizsgluQe6K
	2CVyTDuW7qpCSD8dpQpGTpe1iiCJq0u+wqOGzSV1WdFebWIc3VsRB0bsfrpPIfiAqrjYtFiRjdL
	qOPA8J9n+bRfUTypC4zt0fJNFVYCmPJlte8P00gn7cGd19dSFd
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--11.132500-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	BC218D1896DADD9D0C3E186E8883670C3EF741D71C340B61F4FD556DD24FF42B2000:8

SGksIFNoYXduOg0KDQpPbiBUdWUsIDIwMjQtMDMtMTkgYXQgMTU6MDIgKzA4MDAsIFNoYXduIFN1
bmcgd3JvdGU6DQo+IEZyb206IEhzaWFvIENoaWVuIFN1bmcgPHNoYXduLnN1bmdAbWVkaWF0ZWsu
Y29ycC1wYXJ0bmVyLmdvb2dsZS5jb20+DQo+IA0KPiBSZW5hbWUgZmlsZXMgbXRrX2RybV9jcnRj
LmMgdG8gbXRrX2NydGMuYyBhbmQNCj4gbW9kaWZ5IHRoZSBNYWtlZmlsZSBhY2NvcmRpbmdseS4N
Cg0KUmV2aWV3ZWQtYnk6IENLIEh1IDxjay5odUBtZWRpYXRlay5jb20+DQoNCj4gDQo+IFNpZ25l
ZC1vZmYtYnk6IEhzaWFvIENoaWVuIFN1bmcgPA0KPiBzaGF3bi5zdW5nQG1lZGlhdGVrLmNvcnAt
cGFydG5lci5nb29nbGUuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9N
YWtlZmlsZSAgICAgICAgICAgICAgICAgICAgICAgfCA0ICsrLS0NCj4gIGRyaXZlcnMvZ3B1L2Ry
bS9tZWRpYXRlay97bXRrX2RybV9jcnRjLmMgPT4gbXRrX2NydGMuY30gfCAwDQo+ICAyIGZpbGVz
IGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gIHJlbmFtZSBkcml2
ZXJzL2dwdS9kcm0vbWVkaWF0ZWsve210a19kcm1fY3J0Yy5jID0+IG10a19jcnRjLmN9DQo+ICgx
MDAlKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9NYWtlZmls
ZQ0KPiBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9NYWtlZmlsZQ0KPiBpbmRleCA1ZTQ0MzY0
MDNiOGQyLi4wMTk4YjUwODIwZDRjIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVk
aWF0ZWsvTWFrZWZpbGUNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL01ha2VmaWxl
DQo+IEBAIC0xLDYgKzEsNyBAQA0KPiAgIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIu
MA0KPiAgDQo+IC1tZWRpYXRlay1kcm0teSA6PSBtdGtfZGlzcF9hYWwubyBcDQo+ICttZWRpYXRl
ay1kcm0teSA6PSBtdGtfY3J0Yy5vIFwNCj4gKwkJICBtdGtfZGlzcF9hYWwubyBcDQo+ICAJCSAg
bXRrX2Rpc3BfY2NvcnIubyBcDQo+ICAJCSAgbXRrX2Rpc3BfY29sb3IubyBcDQo+ICAJCSAgbXRr
X2Rpc3BfZ2FtbWEubyBcDQo+IEBAIC04LDcgKzksNiBAQCBtZWRpYXRlay1kcm0teSA6PSBtdGtf
ZGlzcF9hYWwubyBcDQo+ICAJCSAgbXRrX2Rpc3Bfb3ZsLm8gXA0KPiAgCQkgIG10a19kaXNwX292
bF9hZGFwdG9yLm8gXA0KPiAgCQkgIG10a19kaXNwX3JkbWEubyBcDQo+IC0JCSAgbXRrX2RybV9j
cnRjLm8gXA0KPiAgCQkgIG10a19kcm1fZGRwX2NvbXAubyBcDQo+ICAJCSAgbXRrX2RybV9kcnYu
byBcDQo+ICAJCSAgbXRrX2RybV9nZW0ubyBcDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vbWVkaWF0ZWsvbXRrX2RybV9jcnRjLmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsv
bXRrX2NydGMuYw0KPiBzaW1pbGFyaXR5IGluZGV4IDEwMCUNCj4gcmVuYW1lIGZyb20gZHJpdmVy
cy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fY3J0Yy5jDQo+IHJlbmFtZSB0byBkcml2ZXJzL2dw
dS9kcm0vbWVkaWF0ZWsvbXRrX2NydGMuYw0K

