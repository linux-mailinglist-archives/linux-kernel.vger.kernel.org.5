Return-Path: <linux-kernel+bounces-111228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C312886967
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 10:37:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97D99B23A51
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 09:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F93922071;
	Fri, 22 Mar 2024 09:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="GLUcqvFi";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="ucJuRCq4"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC8420DDB
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 09:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711100233; cv=fail; b=R3+TTnPhz23JEZNM3aXVEIEWOk+3M9hi1OAGc34+GFGXGxTdvPoYdUZVFHDIXXvUfFha/77MXWpQeCGQaEzvl5HSPLRCCbm/OhSRldWrbWNAYYlHbXFyh2iPbVO+X79fIxsZLgNO7h+1C0eGOCY1pbUy5I5SOW+Q0skBqM+qaFY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711100233; c=relaxed/simple;
	bh=zyHezhkpdlJiPZAvS1pa7vbOh6vLBh3da+VV/Ribx64=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZEt46yu0z9UEULScFdbfggJX+EOxNl0127hhKDsKbdeFo4y/FDqVIwYEwXQ/xEK0WTSC/0FHifGUHf+Zi4SdWGm/tuwgGOyF4YG39Eef726+xxfDEISj0slEKj7roF2zH2bL7Vq2agdfCNCQK6Yv4DJlpOq6Tpwy/D63sLZIMKk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=GLUcqvFi; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=ucJuRCq4; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: c0ab13bee82f11ee935d6952f98a51a9-20240322
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=zyHezhkpdlJiPZAvS1pa7vbOh6vLBh3da+VV/Ribx64=;
	b=GLUcqvFi5e9mcQdm4DeCumItOVxB6cwQyRxZbe3sWmNnkYJwz+raMyAHo/+oOAXxCx1MP+002bg13h15Tl9poQor6X1XV7L6Pcmz7d5Ng8JmUjFvVl1jzrk8yaJqZOg1vPL0lJtYy39W9Qsay9uVHuKAcESUyTqgdJm3eXACNmA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:43ebda7e-c939-43d5-b344-e50066e0e2ed,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:b2653400-c26b-4159-a099-3b9d0558e447,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: c0ab13bee82f11ee935d6952f98a51a9-20240322
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1773152216; Fri, 22 Mar 2024 17:37:08 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 22 Mar 2024 17:37:07 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 22 Mar 2024 17:37:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ejd/2ffdrrG9VOcf92WuJgkYs2UngrIP4NcMHUtGhxPb43i5bOnIK6sfpkE7Nbr49aFdMoMYOClIRENlYhAO6/UafKQZzaU438dVTsDbAkfSDFYS/hoVvHQJtRss+k/qNTHPcMeFHDtPVTI5RI9KNMFGtx5sKBsrdxjw3Jf/7zHjyALiEDQX7YN3zIq4S4G2XGquFi6A1gd3GDHxqNYk1N/URdlkFNR+hhwG2WmmKwg7CQnijR0Dr9pnISQe/9DiCrX3Mci1tyxSgckxxKf7GMxnYE4sWPu4KDBN9In2QJwoXQKcL7wPYZq077bXqCuPLlRnR6qPBtFSIm7q6+E/vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zyHezhkpdlJiPZAvS1pa7vbOh6vLBh3da+VV/Ribx64=;
 b=HT9+JTpjJpcrb+od/yMfL42PDHEpuagsVFKg51BkaFjUjTk2+9+DwOkD2VDtGnpKj2cVFRgAkT4czJTC0zbVhZrFtvQIk266QnrayMvR3ZDFMvr8wmmLp4jzmWZdqKnA1TM35Hbd/8+IKy8U5u+9ZcczxxYwh5NYoQ2JqfxObMEny4mLy0tV+hDH7DxM1RzkbErukzFq2BdZTtNOIJQO8RLE3kuBZMMCUeQ/eR6JcX5ZcStV1DTajnT69hgCtE9cG57Xz7OlDl/6QfmpMBbL4Gs+4ifRrEGSqXxK7hA5R93i+z9NtVtuvgieLRE/ILLJ65nXEdUUAc113qBE7cUDLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zyHezhkpdlJiPZAvS1pa7vbOh6vLBh3da+VV/Ribx64=;
 b=ucJuRCq42IKQ7ubduNbMZjyBFGNSWf1lZftXdMgrMMz5T4FW4mcALwJtMJeVgAGHU6Ltrrsjb0/RlFD7KAFi+0nX15FARJPZkkzqTNbRPWyD0GZjhn68SO10IK0M9SUBa7/BalXHizTVq3UtTrHwi7TfcG6boZ3bYzmhS4wwEoc=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by KL1PR03MB7017.apcprd03.prod.outlook.com (2603:1096:820:b2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.24; Fri, 22 Mar
 2024 09:37:04 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::f3b6:91a7:e0fb:cb27]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::f3b6:91a7:e0fb:cb27%7]) with mapi id 15.20.7386.031; Fri, 22 Mar 2024
 09:37:04 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= <Shawn.Sung@mediatek.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
CC: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?utf-8?B?QmliYnkgSHNpZWggKOisnea/n+mBoCk=?= <Bibby.Hsieh@mediatek.com>,
	"jason-ch.chen@mediatek.corp-partner.google.com"
	<jason-ch.chen@mediatek.corp-partner.google.com>,
	=?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
	"daniel@ffwll.ch" <daniel@ffwll.ch>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, "airlied@gmail.com" <airlied@gmail.com>,
	"sean@poorly.run" <sean@poorly.run>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "fshao@chromium.org" <fshao@chromium.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v6 07/14] drm/mediatek: Support alpha blending in display
 driver
Thread-Topic: [PATCH v6 07/14] drm/mediatek: Support alpha blending in display
 driver
Thread-Index: AQHafBntK1eS3jUZ3EWvRQZqG5LfxbFDgMmA
Date: Fri, 22 Mar 2024 09:37:04 +0000
Message-ID: <d170ccc1b2e6275cfc6df32f90d2c1b11295f019.camel@mediatek.com>
References: <20240322052829.9893-1-shawn.sung@mediatek.com>
	 <20240322052829.9893-8-shawn.sung@mediatek.com>
In-Reply-To: <20240322052829.9893-8-shawn.sung@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|KL1PR03MB7017:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TUALLbmtT4uTNhdLB7vyx+TMY7Nj+45kLQBT4W8JbbAyL3RcRuLmY3BNbvIxErPl0nKf70Cy1Y9s6o2CSBJJb1O8T0gsjaS3km5kqD5rSLID6c6BcmUnJC8hKQwEFg+B+cuOP1RTn1y9P7kGzp06XFz8FQHYbOkOGOhgSKl+V1ssEwXmdBmmEjHkbRk3YzlLIzKzjI9tCJwXnJd0SQKiskqX1x9Ww2vj/LH/z18nanPrDWZziSWfTbYe8eCMuI9/wOSUXtBmxAUL5tW4pIScPeQN2zZhC8/o1iumE8AqN35j674TxDhAy0IfB4WPyS32btLZev+fiNz12ft2e9TzlJbhG+0Z/VQrofEPwAxQmLfCJy75wTvGmn+r2iFV6/T3uCT8wobz/nQmIooHjW18dQ3ZCTMFbvmSuocCguTfVxOtpPik9Q+NN0R6FCDine3o/zIDPtMEJGpo/bI+UKqN+fsLpElRkr15WrsmFs0ygsF84LMesMuIPa9crfuXA7pYhgWfxdEFNiBZR26QhaAmJC6UKTGxhWzwGfSDWJRh00DWCCr2RMlOveSm1H/4nG1ockdjfsUKvBkBxsYmcrZqWb9HEWAi1t+j9J47k6kn57VPHp/zEHU1JO6siTgyVCnSlrVeYKgfkTvKRmMT9991uMW33VtwDS4k897L94H4d80=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SVBkbnVncTVtTVVuZ0Zlb3FkTFNESDlEOUUwK083RTlIZ2xuQ21SNGVhWnhO?=
 =?utf-8?B?V3RLWG93cnFrK1REM0F5L2NaaEtGWmk5U0liZ0pFbWNWZTR6Z3dQQzJTbHJp?=
 =?utf-8?B?QXBBN1RYL0NOZ2xFT2FMVUNQU1RrZWtTa3B4dWlIck95NU82WGNHMmlCdkdm?=
 =?utf-8?B?Zit4N3NRZTUzOXQ2LzFXQ1N3UFRtV0FjUm92TERVbHAreUl2YmhFejMzbnI4?=
 =?utf-8?B?NW11ZTl1RE5ZTE1yYk5xaU1pNi9MZjVZNGw4T1JVNFhha3dqcGY3Yi9EUDFC?=
 =?utf-8?B?YVZ1N1RaTS85UCtUTUtiaFZBMjBUdkFjb1hIQlFXb1RWaml4Y2lxcEU2QXFG?=
 =?utf-8?B?Znl0WTdHRkJVdXZhUTlqdFV5OE1QWm0xZXEvcEJ0bTdnbEpLTTFReXZuVThU?=
 =?utf-8?B?eGl4bUFlM3F3WERlWjk0NzBQdFdyVVlmMUkrSmpjanQ3VEdWUHNxUzJwcVEr?=
 =?utf-8?B?dTNzZ2JZMjk0Y3ZhUWNJRGFqWFJEZHZObVZVTUFYSGgxSUJ1bXJsRGpDUG1i?=
 =?utf-8?B?bGZFZXUwMEpYdk1FQ3RMd2F2OFkvUU5vRVg3aGhRWW5KQmphUnU1MlRpb0ZH?=
 =?utf-8?B?SWU5RUY4THM0MTN1WU8xdHBXVzN0RWtGb0N0VHdSdXIvS1FaS01EM2Qxb3RS?=
 =?utf-8?B?N0M5Qm9WSGI1ZVlXS3UzUmxWOTlZQWxRVDdzLzRwOC9meHBlallzRXFqTDhR?=
 =?utf-8?B?Q1BaYlVzOWRzZjJXNGsvQ2tFQWpQWEx3bjhkWm1qK1pKTUMrZzhyRlZHWTk4?=
 =?utf-8?B?eStWTFZtaTBLSEdHLzZDYmhla0phYTFYdmZlWUUwRnFWdElObjNFcTV5TVk0?=
 =?utf-8?B?Rk5YNmVxUUF5TUhZREN0aFo5VjV0dEpOM2ZXRXg1alR3TzBRWWdybGhqSi9B?=
 =?utf-8?B?ZEhpa1VzMnppdlNySFpMQmxoYkhsWGlPNFdjL0owMm9GQlpqYjZranZMajU1?=
 =?utf-8?B?ZWtWcTR5WmMyYmxaR1lDaXJBZ0NXQ21kYXFsZVpVbTBrcG8wb0hWZVV2Kytr?=
 =?utf-8?B?MGhTTk9xWGt0WHhhUVY1NDV2M3RJbHpyNVFmdm5HMWlOM0Q2cmRLQ0VSNjkz?=
 =?utf-8?B?Z2dWT3ZLUENBMktycnRhdXU0OGFWaXN0QmYwK3VMY1FSNGlxUzBFckgwWm5n?=
 =?utf-8?B?NFFjdzkyQzliK0V1K2Q4ZWdHYzNFTHZNMWMvNnFDTlNuSU9mbnJEZnBvK1J3?=
 =?utf-8?B?ck9QY2VqSlI4V09KTURzUjl0SURNNkVGSkFnSFNGa1NVaWd5ZUxxUW5nNCtl?=
 =?utf-8?B?Zk5YamM4cVkyL2NickpJQVQ4cVFseEY2RHRqc0R5aTU3elhITDhoWkRZUjQ3?=
 =?utf-8?B?Skp6UG5UMVl1SGxQRk9ZTGxvV0d1dEVPRWQwd2lOdUwvWGhlMGF2KzZwN3Fo?=
 =?utf-8?B?TTV3RkFsRnhlMWh4ai9yQzR0bE91UVN0V1dGZCt1YjFYMlpCOHAwcnlBVWlM?=
 =?utf-8?B?eXNUQ3d0R3ViRmNDb2tWSXcvMHZaZUY0QUR4SVhVK0MzNUdOWlk1YmhjSmpq?=
 =?utf-8?B?UWVET05iTFMxbmdJdFp4c3BmbVZsbitzYzI3WFc5ejlYeEJMcDgycXI1SHNy?=
 =?utf-8?B?ekdSdnFRRTlCT3o3dVY3U3BMQWFuOTdNOTJFWkNuekJwMGUvSnZNbHEvSEdk?=
 =?utf-8?B?Rnk1WTlWbEg5V3pKN2EranUraGduYnNPUHhYWEZGTWhSV3ZTbG4rcFRUSXRE?=
 =?utf-8?B?WjRtNFpLeWNPYXlHS0VOaHlhcU5nUFpGSVBaemw5NTNHNkU5blJOTDZyMXIx?=
 =?utf-8?B?SWVKd1pFZS9IMi9yb0owQ1BFY2ZCYWdieHhSVWhMTVdqdjU3SEd1MWI0MUF1?=
 =?utf-8?B?QkFUNEJnTW5xMGpod1hxMjhYN1BDZGYxb0JETmJmc0Y0SWRGd1ZYVXMxbVFr?=
 =?utf-8?B?RzEydEJRQnJCWURIVzJOQW5UcERYa1R4T1dQSmZsQ1pIRU41UjU4ZkczWGty?=
 =?utf-8?B?cTU5b2szYk8yOFBqV2J1RU91TTRFL1BLaUpybHU5d2E2Qnh0SWJ6N1JZOEk5?=
 =?utf-8?B?UEd1M2cvQmtQdHJtNmVSZnNSNEtCN3BYNnZVNG9XWHJ0N3BOOVd1dXprMU5v?=
 =?utf-8?B?VmhkSGtBY2xxbEpMempQbEhGekI3cmd5QzRBRlkraTBYOE5qRTZyTGorS0tP?=
 =?utf-8?Q?XdIwyZY7A3iyRJk8kaYgcv/t0?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DEED464E4374C241BE12AF4F3C1C7EEC@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ea1392b-ac90-454c-bd56-08dc4a53a23c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2024 09:37:04.4155
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W7FIdvj0mXY126I+WmPhrIwaS9MzSpLDpCk2AV1SHdciETtmSQRT0fz0KtVYnqemZeCWYbUVeBXWhrm3syP27Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7017
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--13.991700-8.000000
X-TMASE-MatchedRID: HXSqh3WYKfsOwH4pD14DsPHkpkyUphL9X4GSJGyYc367qpOHKudqc3xm
	C/CenOgNzCI8XB2Ya3Maom150xxR/ZRho78T5P9DQ1OcCEvT+bc/FeJYf9wxdbghdDfPx2dqCWH
	b0xo/FuYoxJgcjYM0yJD+T+bb5XFJgR3NPmEJwgpjVtAwIy+aflqLeWdevru+2IKxg8LhSXbZ+2
	//mNeSL9mhOXLc8ZbgtIW3/9bx0+pP6qceA7YxiVz+axQLnAVBfS0Ip2eEHnylPA9G9KhcvbLn+
	0Vm71Lcq7rFUcuGp/EgBwKKRHe+r+Tx+qmvTAExfNzGY+0Yb5xSgpqCnB4lYsBKLBGqVNuTMEet
	BvZhfw0=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--13.991700-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	2BCB1BFD19BCA5C209E2FD7DC5BED1C52C0A3A133199E1DC3BAD33DA9AB000AF2000:8

SGksIFNoYXduOg0KDQpPbiBGcmksIDIwMjQtMDMtMjIgYXQgMTM6MjggKzA4MDAsIFNoYXduIFN1
bmcgd3JvdGU6DQo+IEZyb206IEhzaWFvIENoaWVuIFN1bmcgPHNoYXduLnN1bmdAbWVkaWF0ZWsu
Y29tPg0KPiANCj4gU3VwcG9ydCAiUHJlLW11bHRpcGxpZWQiIGFuZCAiTm9uZSIgYmxlbmQgbW9k
ZSBvbiBNZWRpYVRlaydzIGNoaXBzIGJ5DQo+IGFkZGluZyBjb3JyZWN0IGJsZW5kIG1vZGUgcHJv
cGVydHkgd2hlbiB0aGUgcGxhbmVzIGluaXQuDQo+IEJlZm9yZSB0aGlzIHBhdGNoLCBvbmx5IHRo
ZSAiQ292ZXJhZ2UiIG1vZGUgKGRlZmF1bHQpIGlzIHN1cHBvcnRlZC4NCj4gDQo+IEZvciBtb3Jl
IGluZm9ybWF0aW9uLCB0aGVyZSBhcmUgdGhyZWUgcGl4ZWwgYmxlbmQgbW9kZXMgaW4gRFJNDQo+
IGRyaXZlcjoNCj4gIk5vbmUiLCAiUHJlLW11bHRpcGxpZWQiLCBhbmQgIkNvdmVyYWdlIi4NCj4g
DQo+IFRvIHVuZGVyc3RhbmQgdGhlIGRpZmZlcmVuY2UgYmV0d2VlbiB0aGVzZSBtb2RlcywgbGV0
J3MgdGFrZSBhIGxvb2sNCj4gYXQNCj4gdGhlIGZvbGxvd2luZyB0d28gYXBwcm9hY2hlcyB0byBk
byBhbHBoYSBibGVuZGluZzoNCj4gDQo+IDEuIFN0cmFpZ2h0Og0KPiBkc3QuUkdCID0gc3JjLlJH
QiAqIHNyYy5BICsgZHN0LlJHQiAqICgxIC0gc3JjLkEpDQo+IFRoaXMgaXMgc3RyYWlnaHRmb3J3
YXJkIGFuZCBlYXN5IHRvIHVuZGVyc3RhbmQsIHdoZW4gdGhlIHNvdXJjZSBsYXllcg0KPiBpcw0K
PiBjb21wb3NpdGluZyB3aXRoIHRoZSBkZXN0aW5hdGlvbiBsYXllciwgaXQncyBhbHBoYSB3aWxs
IGFmZmVjdCB0aGUNCj4gcmVzdWx0LiBUaGlzIGlzIGFsc28ga25vd24gYXMgInBvc3QtbXVsdGlw
bGllZCIsIG9yICJDb3ZlcmFnZSIgbW9kZS4NCj4gDQo+IDIuIFByZS1tdWx0aXBsaWVkOg0KPiBk
c3QuUkdCID0gc3JjLlJHQiArIGRzdC5SR0IgKiAoMSAtIHNyYy5BKQ0KPiBTaW5jZSB0aGUgc291
cmNlIFJHQiBoYXZlIGFscmVhZHkgbXVsdGlwbGllZCBpdHMgYWxwaGEsIG9ubHkNCj4gZGVzdGlu
YXRpb24NCj4gUkdCIG5lZWQgdG8gbXVsdGlwbHkgaXQuIFRoaXMgaXMgdGhlICJQcmUtbXVsdGlw
bGllZCIgbW9kZSBpbiBEUk0uDQo+IA0KPiBGb3IgdGhlICJOb25lIiBibGVuZCBtb2RlIGluIERS
TSwgaXQgbWVhbnMgdGhlIHBpeGVsIGFscGhhIGlzIGlnbm9yZWQNCj4gd2hlbiBjb21wb3NpdGlu
ZyB0aGUgbGF5ZXJzLCBvbmx5IHRoZSBjb25zdGFudCBhbHBoYSBmb3IgdGhlDQo+IGNvbXBvc2l0
ZWQNCj4gbGF5ZXIgd2lsbCB0YWtlIGVmZmVjdHMuDQo+IA0KPiBSZXZpZXdlZC1ieTogQW5nZWxv
R2lvYWNjaGlubyBEZWwgUmVnbm8gPA0KPiBhbmdlbG9naW9hY2NoaW5vLmRlbHJlZ25vQGNvbGxh
Ym9yYS5jb20+DQo+IFJldmlld2VkLWJ5OiBDSyBIdSA8Y2suaHVAbWVkaWF0ZWsuY29tPg0KPiBT
aWduZWQtb2ZmLWJ5OiBIc2lhbyBDaGllbiBTdW5nIDxzaGF3bi5zdW5nQG1lZGlhdGVrLmNvbT4N
Cj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX3BsYW5lLmMgfCAxMSArKysr
KysrKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX3BsYW5lLmMNCj4gYi9kcml2ZXJz
L2dwdS9kcm0vbWVkaWF0ZWsvbXRrX3BsYW5lLmMNCj4gaW5kZXggMTcyM2Q0MzMzZjM3MS4uNWJm
NzU3YTNlZjIwMiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19w
bGFuZS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfcGxhbmUuYw0KPiBA
QCAtMzQ2LDYgKzM0NiwxNyBAQCBpbnQgbXRrX3BsYW5lX2luaXQoc3RydWN0IGRybV9kZXZpY2Ug
KmRldiwNCj4gc3RydWN0IGRybV9wbGFuZSAqcGxhbmUsDQo+ICAJCQlEUk1fSU5GTygiQ3JlYXRl
IHJvdGF0aW9uIHByb3BlcnR5IGZhaWxlZFxuIik7DQo+ICAJfQ0KPiAgDQo+ICsJZXJyID0gZHJt
X3BsYW5lX2NyZWF0ZV9hbHBoYV9wcm9wZXJ0eShwbGFuZSk7DQo+ICsJaWYgKGVycikNCj4gKwkJ
RFJNX0VSUk9SKCJmYWlsZWQgdG8gY3JlYXRlIHByb3BlcnR5OiBhbHBoYVxuIik7DQo+ICsNCj4g
KwllcnIgPSBkcm1fcGxhbmVfY3JlYXRlX2JsZW5kX21vZGVfcHJvcGVydHkocGxhbmUsDQo+ICsJ
CQkJCQkgICBCSVQoRFJNX01PREVfQkxFTkRfUA0KPiBSRU1VTFRJKSB8DQo+ICsJCQkJCQkgICBC
SVQoRFJNX01PREVfQkxFTkRfQw0KPiBPVkVSQUdFKSB8DQo+ICsJCQkJCQkgICBCSVQoRFJNX01P
REVfQkxFTkRfUA0KPiBJWEVMX05PTkUpKTsNCg0KQWZ0ZXIgYWxsIHN1YiBkcml2ZXIgc3VwcG9y
dCB0aGVzZSBmdW5jdGlvbiwgdGhlbiBjcmVhdGUgYmxlbmQNCnByb3BlcnR5LiBTbyBtb3ZlIHRo
aXMgcGF0Y2ggYWZ0ZXIgYWxsIHN1YiBkcml2ZXIgc3VwcG9ydCB0aGVzZSBibGVuZA0KbW9kZS4N
Cg0KUmVnYXJkcywNCkNLDQoNCj4gKwlpZiAoZXJyKQ0KPiArCQlEUk1fRVJST1IoImZhaWxlZCB0
byBjcmVhdGUgcHJvcGVydHk6IGJsZW5kX21vZGVcbiIpOw0KPiArDQo+ICAJZHJtX3BsYW5lX2hl
bHBlcl9hZGQocGxhbmUsICZtdGtfcGxhbmVfaGVscGVyX2Z1bmNzKTsNCj4gIA0KPiAgCXJldHVy
biAwOw0K

