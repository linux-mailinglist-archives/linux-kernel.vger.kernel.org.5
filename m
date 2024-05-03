Return-Path: <linux-kernel+bounces-167194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7261A8BA57A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 04:59:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91E4B1C22690
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 02:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546711BC49;
	Fri,  3 May 2024 02:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="j9CzH7RC";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="JHAIfhlX"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5DE18641
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 02:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714705150; cv=fail; b=ZBDlfZ/Ps0bF48+c0fBqzCjsrZP3yiyQHyp5Q09k661qrOlk8ui/lEyFfjDOQGfcnTkZthsEoXHsmhA8vE1M+odBOEoeTsgyodsgQ6806/CMfl9ppF1fEcLYsWfJr6FCjPO6JIZNvtI0QAzezbVE5RjjbtV7Wcxz79hH0+otqiE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714705150; c=relaxed/simple;
	bh=ZGwA0Eho5KUWdbp63df3Db0Ytfab9M6VslEIiWd9kMw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Vw/uz+CT0pzjKDdXm/Z221fP3Drq2r3o6QmDjQ3VN/jIO7fSTCDqOW9VM2nnQn8m+pQZ2qpmg2ekHCm2dafrtZmHr0Z3ocwR9RVonZvJn5Yk3vNb9bnP8TztZ+bSZrom1ZbK4An+7NQ6Ct5bYAgvgcUo4sKySkKpDW62wdp9Aw8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=j9CzH7RC; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=JHAIfhlX; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 184be32a08f911ef8065b7b53f7091ad-20240503
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=ZGwA0Eho5KUWdbp63df3Db0Ytfab9M6VslEIiWd9kMw=;
	b=j9CzH7RC0qOvXLMpLAz96+gIpDZOGtprZjw7RW4z+eAdVYRvBGQhA2x0rpSn/IGFktDBNdQBE0+x/DFDuV+s43ZeaoyxnA+f8+/YS2tYANyRInewTaFGtoWJVmsCWBnk8DSdIf6wFuN1CUYxFxSuUzuyscdX+vfRVP2XmUQbhUw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:9255350b-ea2c-4f8f-9b95-a4ae8ec382b3,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:82c5f88,CLOUDID:580ae586-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 184be32a08f911ef8065b7b53f7091ad-20240503
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1162885051; Fri, 03 May 2024 10:59:01 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 3 May 2024 10:59:00 +0800
Received: from HK2PR02CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 3 May 2024 10:59:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CnToecYGxSVA2VUVkv/7ZLqGYPAH95LhwGpqJjP9LWC5SHEiAiunfFB5CklJhdEKoX5N+J4BjRu+jPeGx+YsM9dtOqVyPeQPDiulyXPp7S3D5dGsYzSWI5UInIlETxs1MwpGbg3KG51cmfPnOb2lyLBLvow4Lda/C3qaCBb0LTnXO3KYwjU0Fu2Vhhqfwvn+NfVTw9WmrBLFSrNegXYIj10V2E3gi4gn18GyJyOpPwfDm9610rYZ9rw/ZqepwEvqER3mABITrRx83JZnh7ZNsQCjBvCN5jRBwej1lpYMoZdXXnbnOA0nEr4AGrm5YPf6cC2Jq2ngbw4PxJvh5CCYmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZGwA0Eho5KUWdbp63df3Db0Ytfab9M6VslEIiWd9kMw=;
 b=Bs/l6WFnP0LEDALAVyZp1P3xf8VdZZT+U8hEbXTgXlcWkwNWzfEa9T7FBBf37Ib4SgCw6J+0AGWF0TvFNq7oh3UHpasTZ5XknZO4lrB42aN28+bsvk+DFgi8R1fvrUFcBZ9r0qvipEcVe6Ppz+xZOMu/2Pls9MycrRsEeNaFszIAtM3b1N/ecs2fmvwqCAPW+QjaHwczdlOOeQ692Hc3Xfc2hI3jcp8QtlbtJmx0BL4xTZsgks/0SmIrtxaEVOS7jefRDJf+u2am6/cAz2Bbd2iSrU0QVMItrUW3nbHP1G4ltLJlgNl1w25zATDEpyN6poSDTiP9Ij2blqM1wZrDVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZGwA0Eho5KUWdbp63df3Db0Ytfab9M6VslEIiWd9kMw=;
 b=JHAIfhlXVM63YkUMhMLL0dJKFl14aX6eT6DxsEW5cJseBbz7PT8aJehWMIfMNsjwzEOvX+tb5VqJLX9aS4JsgzM/6/zWAaXx2Oq/wU+/AF6K0INU7kJ6mgzjHN+3r3wZ2iR7VdBXpRnnfCa7mwcy2V3plUvrdH8RjwthVC3Uk4E=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SEYPR03MB6507.apcprd03.prod.outlook.com (2603:1096:101:54::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.30; Fri, 3 May
 2024 02:58:58 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%4]) with mapi id 15.20.7544.029; Fri, 3 May 2024
 02:58:58 +0000
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
Subject: Re: [PATCH v7 08/18] drm/mediatek: Support RGBA8888 and RGBX8888 in
 OVL
Thread-Topic: [PATCH v7 08/18] drm/mediatek: Support RGBA8888 and RGBX8888 in
 OVL
Thread-Index: AQHanHz0E24ffmyV80KDv17lEGqClbGE0rSA
Date: Fri, 3 May 2024 02:58:58 +0000
Message-ID: <3a7b3b92582db6cb7cfd049af7d4b28b43e22d75.camel@mediatek.com>
References: <20240502103848.5845-1-shawn.sung@mediatek.com>
	 <20240502103848.5845-9-shawn.sung@mediatek.com>
In-Reply-To: <20240502103848.5845-9-shawn.sung@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SEYPR03MB6507:EE_
x-ms-office365-filtering-correlation-id: 61429a12-7fcf-4be3-25d0-08dc6b1cfa54
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|7416005|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?TnA4bjdPN1BVVHhhM295QWwyS2s2aTRKWC90OVpQdTFlMVlUV2VvM1M2WmZh?=
 =?utf-8?B?TjBNODQzV3VSOUJpKzVVa09BeDRTVS9MemFkSEJqT1pLUzhJU08rQVY3VFZR?=
 =?utf-8?B?NXR5cVIwTnV3TWFRRVp3S3dIQVYyN0M0ems0MGFKMkRtc0U5Vy9DUWxXaXNI?=
 =?utf-8?B?Z2VqOW1mWHZxeE9kV0U5V0VxSlNpWjVDa2xtMURiQkpyNXMyQzZiaUR4UWpw?=
 =?utf-8?B?OUR0dGRNVTBVdVBGNzh1SHpUQVUwNVA4OU44MmVLbFZDdUFVcFRFTm1tWEtP?=
 =?utf-8?B?amZ3bFdLdU5TanFqUCs4NGlWYWRjaVBNa244cXo1NUxtbjBwVFNCL01BdHp0?=
 =?utf-8?B?UWpOYnVOc3B2N09jc0kwSjlFTjhCK3huaDUxaDhRNE5iUzlmcXRVWUpPYlh2?=
 =?utf-8?B?eW9wNXB0Q2ZwY1B6QmVBU0JYTmo3NVY4K2M1Q2JCTHNvZDl0Qzc1TWhpOVkv?=
 =?utf-8?B?cUx1eWF4SHZBMHhieWpPUEYrSW50OUhFcTJvQ3BjOGlkSC9KQjV6VllVanJO?=
 =?utf-8?B?dEhaR1lSazFISUZJMkV6aGdaank0YWgzVThtT01hd1dSUnNVcDltTEdlREdh?=
 =?utf-8?B?cDVMUG9Nc2RTdDh5dWRlWkFCaFhrOE9FZDBJQkdVNWxSWXJVT0RjQ2NJUlpL?=
 =?utf-8?B?bVFFejhMZGIwQmVjTmZ5N0xYK0pVRWhocXBnNmdvN1MvZ1RaZU11SkFpL3dt?=
 =?utf-8?B?SFBuYUhnNHZqemh5QWdFYURSQkVUT1ZBTERDdXBpb2VZaDJCdU8yUkdqa0JT?=
 =?utf-8?B?Tjcrb1ZtdzZ4NC8rRUlJcEJsQjBOL2R0NXlpZHA0c29yd3poRkVsRzdaNS9R?=
 =?utf-8?B?OGZGZlVxZnR3cmxBWjIyc2lzMGRuaWZIM2ZNM1AxblpDZDBsMkkxRTlPc0lr?=
 =?utf-8?B?ZkVUa1BOakRaR3BGeTMzUFg0TjczWTJsYldqQnF6UzMwQVduS0MrU0NTd094?=
 =?utf-8?B?RlVLVmRMWk5sNVlJOEY3SEtVTWNmRFgrdThLWDlwVmVCOEdSTTJJTkNQRGpC?=
 =?utf-8?B?akFDS0kyY282Z2t0VU1IVFFGYUwvRVoyVmNZSTlKWkYrMmJ5VE03MVRQZXlw?=
 =?utf-8?B?YW03ZUd2ejlQMzFYTmlVQmliY3pUb2ROdStJQlVIZU8zTDlYS3IxcGlyRTR3?=
 =?utf-8?B?b0lERlVTT1FqMmFVR0kzRGFQbHBSZUw0eHJJQm9Bb3E5c1BrQlVIcDNwMmFE?=
 =?utf-8?B?NWpTWUE1OWxFaHN1N3hlOHhVQWNaSXk4MVpiQnFvTndGdktRS0FtMC9jeTJY?=
 =?utf-8?B?MFFIdkhNVTVjQzd6UUs0RUZKSE9LY04rQXJGRTZ0cXhlbTk5ZVhwZUxJTGpy?=
 =?utf-8?B?Wno5ZzN6VkZuV2grd0l4WGo0eWRRK0dHeUEycTRwTVR6djdTeE1uK0xWZGkr?=
 =?utf-8?B?S0JaM2ZPVFhWQm5vZU9iTERySThDcHlZMytKbm02NE12L3AvUzFwVlVobDIw?=
 =?utf-8?B?bCtHRzd0NmdrcktpYkc2aUJuZXNyYkJQVlYvS3pLMlAvcXBScWpvTDNrYzFS?=
 =?utf-8?B?M00zT3dQaERKay9yQlZKNENCQkRvaXhtTjBTM3ZxajFyRyt5TXlHaUdIblVw?=
 =?utf-8?B?d2laYmZpSmk1Z3BZWDBWbk9QQVBHOEliOFU4N1FTSW50eHgyVHVUUXh1d2FV?=
 =?utf-8?B?aHRnM3pENjBKNlQ2S216SnVPa3JMNEVCWGdvaHRXNmFjUDBrK2pQMFgwMlY2?=
 =?utf-8?B?WVIySWRWalZWMDF3WFdsbXFNU3IxTE5ESURPc0wxZG5nSE55L0w3OVk5TU00?=
 =?utf-8?Q?cXr6hoDziVueqvmk4McXLNfkOnlchtfOyL6el2o?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NFQyR295ZzlvbndqS1NXdTNaMWhWb2RpSEZFdVNwaUZsMWhYMUdUbkxrRkZs?=
 =?utf-8?B?QmcrSUVJSHdVTlA0L0RLNDFta01XT1hDRGZXMHhjT0ZrdHViTHJ6azMxZFNy?=
 =?utf-8?B?SEFlUENhT3o5cHlnYUgvWHV1Mk9GMm5EU1JQVHhpeGRFRURCUDlNSTNxUFlo?=
 =?utf-8?B?RThMWmlXYlgvVXZjdVkwWmw0Y2RYSUMrSG9SRHEzZmwzbms0Q3E5b3FvOWhu?=
 =?utf-8?B?SmVpd05qT09pR3RNRlJIekcxYXJFWXNOU09ZQ3EwaFdDVUYzc2JLVEc3eE1o?=
 =?utf-8?B?dGo2WjUwdm0wbk9zN3JFMk9xNGhRL1NWY2ZzSDc4V3Q3aXRBeTBKeFBpNTRn?=
 =?utf-8?B?YmdFbEFKdjUrcG5NbXQvSm9EREp1c1hLbkE0QnlId1JSUi9MVE9CdDFkWTYx?=
 =?utf-8?B?REFmS1dBOHFrVWFVK0NKTVhQYS9jNDduMW9hSDB1TkJTdFhyVUtqSGtMV1Fx?=
 =?utf-8?B?RHBScXVlU3pXNCtUeHoyN3V0aXFDcEE0UGJiRWJSTXlxbHlkV0d3UUVPQVl2?=
 =?utf-8?B?cEFXdXNuaGVXSi9OT0pTcExSNm92N3ZaNjJjdS9MckpRd2I2VnExRUdiK0dw?=
 =?utf-8?B?L2N6ekR6TURPM05tSTBCcDQwVWdjQWlkd1NoQXJKcFREMUlvUzNpMHU5dHd2?=
 =?utf-8?B?blhwK1BDWVFsMGhPWnFLY2hLVEIvQ1M4ajdsZ3MrbkNSb3ptMFVOcWhKZ2tq?=
 =?utf-8?B?WFVTbGNnbmpJVFJJMlRqYy9QbXpRMCt5YVhEUVVIcG9WSUgranNCdHZ5THZB?=
 =?utf-8?B?bFM1VG12OG45a1M1Znp0ZVRSNXhNeEJPL1VMNzYzQzZGekFMZmVQVVJKb1lQ?=
 =?utf-8?B?WXBqbTRTZUx4bzBvd0phbHkvelk0cFRhNkJVc1BaZGZqSU8ybmovMENCd1BL?=
 =?utf-8?B?VHFkaE1kMEsxeEJNenBuSmRSV2Rud1JZV0krbi8zdDlzVmV1SUthVGg2dWw3?=
 =?utf-8?B?ZXROQmNRc1h2dUg0Yy84QnFtUkkxa1pNZnJiMkE3ZE9WdUxpZUkzcVBHaEFE?=
 =?utf-8?B?OWMvUVdHOEJKL0xGVVVoVEhBUmtrVG91QTJwMTYvSHZCak05OC9MUy9nSVQ2?=
 =?utf-8?B?cEIxNE5HMGZLdDBCbjhhNDI3eEdldldNejZYbGoxVGh6dCsvamJxM3d2eGJY?=
 =?utf-8?B?V3FQc05CZVUySW1YMDJRUDNtNXBNTVdSZW5kWE9rWnVXWGh4czgwRXQ0SURV?=
 =?utf-8?B?VmFGQ2FkK25KZ0lPUUFiK0NFTjQvZUdobnhLMEdOb09FVkxhMVpkUEYxaGhk?=
 =?utf-8?B?ZkpiNi9LdUwrYkxQcmpYQW92TExnMThzTHJYTTdIaHBLVWhOdlg0M201N0F4?=
 =?utf-8?B?ZG9ONitzVHlyakZDRGt6Q25US1hoVVREdnZZMzRldXdOWjhyNUdLdkVFSnpm?=
 =?utf-8?B?Mys5bmJ1QWJzZkgyZUl2NEdGUEF1SkZBeTMvbzB3c1JVcVIzbWNUQVV4SS85?=
 =?utf-8?B?Z2FZejRQbTJFN096ZU03ZGQ4dmpFUVpTQzN3ZVFPajd5Q2IvM3huK0hCYjdV?=
 =?utf-8?B?SnZqR2JobVRKK0tGZFVWTGZUSUhVRmtqMVBidjN5ME8xSmpINU5vdk42WWFr?=
 =?utf-8?B?L21BS1Z2NEdOUkNySm9XMFBPbDhJZnAydGd0MzVoU2hnWU1PZU5DRlN1Qkkw?=
 =?utf-8?B?WjU2MERiZ0lUWHdhK3V1WDA3eTc4dnZIQXpWRTBqVnFiZlBpSHVkTHo2RGtT?=
 =?utf-8?B?NVRZMG1XNG50c2pURlJ0aEVrdWtxdWVTUStYeWI4ZHJ6ODRYOW9qWkJZRmhW?=
 =?utf-8?B?bzF6THYwTmpZamx2WEtEUU44YlFqc1JqT2Z0eEhIS1o4M2VCcHJST2dPeUw4?=
 =?utf-8?B?OWVPSEtBaGFRYXV6YnhLQlhia3hoT2tVZXYrS2VSejVXZ3UveVBNeElvdTFs?=
 =?utf-8?B?NkRWdG5YTGhRQnZLWTZsblp4Q0x0bjZrTWNYUkx6dnZJa04xZ2xzRUUzQjRR?=
 =?utf-8?B?dmdZOWNJWDZTYmlaRXNpcGZmTFRyZzFWTE9NZzV2L09vc0tKTlVZWFBCYTBK?=
 =?utf-8?B?eS9YVTNRSVhxbUdRSE9aVmc0emVGRjRMMUlxT3J5ZzhXODJRcVY4OWZMOENw?=
 =?utf-8?B?bXhDYUczRytIMjhqMFlmSUdTb3VONVBVUW55TG52VWxsVEljNmRvVDVKejRi?=
 =?utf-8?Q?S4REDHuI/Wte8NU3jqz+npZzy?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E16B92236A5F8F4880242F87BEA28FD4@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61429a12-7fcf-4be3-25d0-08dc6b1cfa54
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2024 02:58:58.2301
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6YL7/iMsWrIn5RN99aTpv0ZT8mRrZ7VTcLskhoHz4kXVta/S+A4o/95GLiOUo76lqzz6KYJc0QCkvMlHvgFL/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB6507

SGksIFNoYXduOg0KDQpPVkwgZHJpdmVyIGFscmVhZHkgaW1wbGVtZW50IHNldHRpbmcgZm9yIHRo
ZXNlIGZvcm1hdC4gVGhpcyBwYXRjaCBpcyB0bw0Kc3VwcG9ydCB0aGVzZSBmb3JtYXQgZm9yIG10
ODE5NS4gU28gbWVudGlvbiB0aGUgbXQ4MTk1Lg0KDQpSZWdhcmRzLA0KQ0sNCg0KT24gVGh1LCAy
MDI0LTA1LTAyIGF0IDE4OjM4ICswODAwLCBTaGF3biBTdW5nIHdyb3RlOg0KPiBGcm9tOiBIc2lh
byBDaGllbiBTdW5nIDxzaGF3bi5zdW5nQG1lZGlhdGVrLmNvbT4NCj4gDQo+IFN1cHBvcnQgUkdC
QTg4ODggYW5kIFJHQlg4ODg4IGZvcm1hdHMgaW4gT1ZMLg0KPiANCj4gU2lnbmVkLW9mZi1ieTog
SHNpYW8gQ2hpZW4gU3VuZyA8c2hhd24uc3VuZ0BtZWRpYXRlay5jb20+DQo+IC0tLQ0KPiAgZHJp
dmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX292bC5jIHwgMiArKw0KPiAgMSBmaWxlIGNo
YW5nZWQsIDIgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9tZWRpYXRlay9tdGtfZGlzcF9vdmwuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9t
dGtfZGlzcF9vdmwuYw0KPiBpbmRleCBkOTcwY2RjZTA2YmM3Li43MzgyNDRhNjE2NGU4IDEwMDY0
NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bfb3ZsLmMNCj4gKysr
IGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX292bC5jDQo+IEBAIC0xMTQsNiAr
MTE0LDggQEAgc3RhdGljIGNvbnN0IHUzMiBtdDgxOTVfZm9ybWF0c1tdID0gew0KPiAgCURSTV9G
T1JNQVRfWEJHUjg4ODgsDQo+ICAJRFJNX0ZPUk1BVF9YQkdSMjEwMTAxMCwNCj4gIAlEUk1fRk9S
TUFUX0FCR1IyMTAxMDEwLA0KPiArCURSTV9GT1JNQVRfUkdCWDg4ODgsDQo+ICsJRFJNX0ZPUk1B
VF9SR0JBODg4OCwNCj4gIAlEUk1fRk9STUFUX1JHQlgxMDEwMTAyLA0KPiAgCURSTV9GT1JNQVRf
UkdCQTEwMTAxMDIsDQo+ICAJRFJNX0ZPUk1BVF9SR0I4ODgsDQo=

