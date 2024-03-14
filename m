Return-Path: <linux-kernel+bounces-102887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 170ED87B808
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 07:41:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73BAFB22642
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 06:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5B945664;
	Thu, 14 Mar 2024 06:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Hv07iIcY";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="kUicGrTb"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB9F3D75;
	Thu, 14 Mar 2024 06:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710398462; cv=fail; b=cWeSDgy9QVu7H8EoS4s3EKgmPMXPbvVsc0xzp/JzfGa2HNalircLBF6QGPUaHyQ+Fnt/uz6MnQ10Q67WBrW7C1miPH8FKGBTNjDnhG5YTFVz6AbczaQy45XL0o5Jg9nxs17A9SFH150fBq1fFTDMTzAaC6ajrv+oWHXV+0rwhSY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710398462; c=relaxed/simple;
	bh=4qKvDR98tG42aphtD6JD322NJDL9NvIV/OEahNfPaCk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OCxeoUy0IJgEp2p/DrSsqvJ+3t+hzUG9qSuOv27xqtUq/ZMJVdohJBl/q78z8t/9P7ujmdBB7dQe2ZBc2D3O5l3zSEUYRo0t+gYF8XUuWPVHPk6QkP+CaKxKPIkiNADBQrWj3fa/IBCGrf3xFlmysdPCdPDaAf8cWXfEDPYcQVk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Hv07iIcY; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=kUicGrTb; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: ce9d4810e1cd11eeb8927bc1f75efef4-20240314
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=4qKvDR98tG42aphtD6JD322NJDL9NvIV/OEahNfPaCk=;
	b=Hv07iIcYG6ZNqWgKrvMjcmdw5aC4LPpla3Mm8VxSBcwYYhB8/+shRvOk315NtFJPlJMCfhqYzNGTxLWEzGE/SUF6d+Nz/2C0tJV6pj4u+rksrRpLtIdCFpk+9O8XTzdZ0nHcNyiNankNYN0tYpkj+f0hOt1LqgNVPafkxmZy7ZA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:9c275326-b84d-48ed-91e5-3a6474a3b5ee,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:c54ffd84-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: ce9d4810e1cd11eeb8927bc1f75efef4-20240314
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1980651971; Thu, 14 Mar 2024 14:40:54 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 14 Mar 2024 14:40:53 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 14 Mar 2024 14:40:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=obhp4RUEcm4NpHgkOGoArtw/ILYjtabAHUOJz5pCRCcgtYURCsl1XGW3+Tq53SEsAUPaczT5Y8XqZsZ+Je2lZgT7vj9TQaYf82zhTevC6U2z17Xv+U3ao13AD7hQEfebWx7lVld6Ndqo8q0somwETSBu2yqKXn6C+KeIQBEqhkON4hNlTsZsMKwNV73x1JSf3EArXbjheu6ERKyo6Mb/bIefGjzohgsWID9w5EtdF70IdMWK5zleoKJTAvKxLS8p0ko300YND4k9cnq5y6oivHnb6tYeJ/IntonUH9nDAwNhwqL+3PPbvLCUpyrYWdfBXkIkykxas3XEV1GUzvCqEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4qKvDR98tG42aphtD6JD322NJDL9NvIV/OEahNfPaCk=;
 b=IvdEUa8n3r8s/navrPPKRxRgGXfncp6pJoNbdW00dzjXfQo9i4IqwiqleNBTUm8UOs9KUATcG73IUbwNsN7NA3p2eI3GXozyRArf/YNtSB1gKAOvZ3Skv0tqmT+hSthWvEk0gEWCvIa+W/8k0HPwRn+IrUWe94Ds8KgbgVTLRKW5ujSxfY+1WYULfUwVB/tmyTfnzfdfiFzzsU91yxiAeDeDSNKz2s/cOMU/VORnwl7A5uNHlnXFNUTKgPlV3A2QUpTCNZPVp8lq5Wd9R2P1rd5w2DOcxmXumfKLskCFSDbX/iI559LE1G8ymfUUHqWtUDBsfKypGeRolJkXbhVTuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4qKvDR98tG42aphtD6JD322NJDL9NvIV/OEahNfPaCk=;
 b=kUicGrTbaCHBJZywk+bC81fBdT3CbsLsbOk8sCGz0l5xjHdlxdMJZvbLscFWK4HGdpkQAEtfOhWaGRrkT/H+lM2LzFdqm/ENo+BYbxNvC1BOR1kibXugbjLUY71lbYNNm4yODXo8NIoV473LQrICxmfKt6/kbOX6/GAZdeLuiWo=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by KL1PR03MB7903.apcprd03.prod.outlook.com (2603:1096:820:f3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.21; Thu, 14 Mar
 2024 06:40:50 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::f3b6:91a7:e0fb:cb27]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::f3b6:91a7:e0fb:cb27%7]) with mapi id 15.20.7362.031; Thu, 14 Mar 2024
 06:40:50 +0000
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
Subject: Re: [PATCH 06/11] drm/mediatek: Rename files "mtk_drm_crtc.*" to
 "mtk_crtc.*"
Thread-Topic: [PATCH 06/11] drm/mediatek: Rename files "mtk_drm_crtc.*" to
 "mtk_crtc.*"
Thread-Index: AQHaaJE1wnA+cksXMkS0nKYBYtp7SrE24/eA
Date: Thu, 14 Mar 2024 06:40:49 +0000
Message-ID: <9245e76859c7e1035b4bc00f5fe1c8b13d4cb040.camel@mediatek.com>
References: <20240226085059.26850-1-shawn.sung@mediatek.com>
	 <20240226085059.26850-7-shawn.sung@mediatek.com>
In-Reply-To: <20240226085059.26850-7-shawn.sung@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|KL1PR03MB7903:EE_
x-ms-office365-filtering-correlation-id: fa740a78-7a44-4512-198a-08dc43f1b013
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gsvOVG84SG90aL/CmGr1SRC5QMpvFBTGXISll/L7F7t66lOUvq9BRlV4Ufj06mRTachN8qIImc/b9EZkYGslHvvFrxup4F8C71rwL82J6BTjYnPHGZW0UZlOVzyqYfapYw/80M7bkkAr8zVEJQqgzxrylYykok6YZgXaNSvfWaeHPg0yq8y8oMQb5SBZ4IHiXLaLonLR4AC6j0FCgJRoetq7vQjMk7RXG83UH8VgosAd0WjlI1ymRQefBIKs03hD6csNOFPSynWG/Uq25Od+xfAeYbWIl04jrc3SRwROEC9p1B0EsiQp9zwvOyVt7AHQZgrV4qWCfGMZhMp1cTMSiyB0o6JjELQFTxgabI+qNaBe/83V4KuUYk8y8jdMHRw7RzwrDqzu1Kciv1kLKrLQ/uQl5j2nF8FKL5RcH68kZo3DuEfyaFlg3uUFAUBzcqxRnPzXrOTPFWkcRjt17lDUP/rFmewJFSXihMAadDAblg0CFc04NUsl9QRFyICmWrmS3iV0WdjXJRO8hXknRQUp27vgrwiMZJvs/V1EjF89CfMOWZtNi3H9DuRntJ+7wc6CbUn91dQgGI0lpodOZ99dLt0fwhWk/hNzLDWUdmT8cdMtQXeC1cXeSQzmkEmvljcJMJv1gbKAyNF2Dr1T4XiO1ozRWihD9PdxIbx7LbjOxfoB9gSYf+FqTbj8gSJC+yuAFXJ3bSaAvgb8Umu0JK/8f87z2eGJPpU6uY7FGsUhPzQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cW5CeFNGVTM0M0t5V2s3OWNmY1ZUZnEvNUZ1OGRxRkNCMmxJRSsyWmthdDRU?=
 =?utf-8?B?aU0vWitUZGF4cThrSVNWelI1K0NEeUpHUUhDZ2lNKzZRUmxkRjJLc0ROODFN?=
 =?utf-8?B?L2RTSlVJYWtkUmdicUhOYU5kRnZsWTdtSGxUNmViNjA4MDBJVWVhZjZveTBV?=
 =?utf-8?B?UWlGUGwycXlmbG9BWVBLYUdJdUM5aVIzelpsL3NHZy9CZGdaeDdjM0p3TDFZ?=
 =?utf-8?B?MVU0ZHRkOGR4Kys3TmxoeFBwNFlmSUtUNVZpbC9vN0FBMnYrQ2t2WFcxMy9l?=
 =?utf-8?B?VC9QK1padnM5WmY2TC9IbEVxK05NRjFJVVREdWtTYmdxdWovRE9meTNzRUJT?=
 =?utf-8?B?UmcyTk9yZHJLY3p1TFlYOC92S1VOTWNhaGFBSE5ITmxsTERVbUxia1JwOHpy?=
 =?utf-8?B?NlhrNUVEOGw2akgzOGxOdWN5ZVV1M0hESTN6bE1oYnVLWURzZEFEbm45elFx?=
 =?utf-8?B?SldjUWlocXAzeTdGNWw1VXBEa1RoVm9lMFNpclkyZHR6MkcycGJFT3lLSko3?=
 =?utf-8?B?YWJSejRlU1cvNU9McEZoN2p0Mm5OMUxYTGxaK2MvN3lVUTRsQmQ1TDR3U2Vk?=
 =?utf-8?B?RXF0WmRGVlpoTktOZWV1NzRFZFQrRHk3RGM3ZzVQd1BaNVkzUzBLcTNzTGNt?=
 =?utf-8?B?RnRScFFFc3dTZ0VQUkM5NklISmoyWVMyTmtFczhkdklBL0ZvNDZzQnh3dWE4?=
 =?utf-8?B?V0xkcVIvK203eFRzTmNOSzFRRVVEQTJnankrODd0NW9MNkcyblQxVHY3Q2lZ?=
 =?utf-8?B?cEpZQW1TTXU1Mloxbk5rWEY1WWlVMzhIWDZ2WXp0TGk1b2lPNFl6QjZTMDht?=
 =?utf-8?B?WEVobHVLSU9wam5yRHFIMjdlazlEK0lYenRjbU1NZG9LaFp0cTFaZjdZMWNa?=
 =?utf-8?B?WXBqMUEwSlVqSjQ2eGRyMFlXVGF5cXV6WWhNVzhabll4ZG9yQjdQTGlFUGRX?=
 =?utf-8?B?dFFEU01CTlYvOWZIUzJ2cEtyNEgyMGdCTnlaVm80WXd2ZzNOcG9QK255dUIv?=
 =?utf-8?B?bXZqQjh4dDY2UnVhTWhwb0lSbGNUaGVmbC9ka3FXWTVNandkbVMyMS85QTlq?=
 =?utf-8?B?OTUwOHc0THhkYktkTCtUY3E2SHg4WHhiVlpwNEhvQ3Z0Qm5MaXN4NHNYd1pK?=
 =?utf-8?B?bFUrUUFkTi9lUS92Wmdia3NETzJ1ZDdHT0FtM3JDbWIxbTYvbzNtQVFnSzUw?=
 =?utf-8?B?VGU5dVBlNW5OOWZ3b1Zpb3llYU9xRGtmRjdNZTJJS3hUQjFpMnp3SW9XajZt?=
 =?utf-8?B?ekNlcjRVRmlXd2JpZEIyZGFEeUQ4Z1JKbEE1c3NkR09INVN6b1F0VVRWZHVZ?=
 =?utf-8?B?cmgyamU3c3FENWhWbVdlV1FjOWE0K2RPVHVKOXNOWmI1SlVocm5oQTBNc3RJ?=
 =?utf-8?B?WWxtcURLbzhWc3R3N2lkbWYvZ0JyME1BS25sSEFuWXdYZXF1cG5qUTJCZHJ4?=
 =?utf-8?B?NEVZZTh0bytzK2tyaWNmRHFZY0IydDllc2RwVEFnc2Npb1IySUpGUlB2MUhT?=
 =?utf-8?B?SjYzWGhZdEFkeWQzbTVJd0Y0N1QrcUdiSmhMc1U1U3pZeVdadWptbWR1b0px?=
 =?utf-8?B?Z3hiMXdHNVkxQlVTclVaV1pJNXRpS1BMcUR0UkhjanZEL3dyNnQrRXJBZXdu?=
 =?utf-8?B?b0REZ09IZlc2VnlBNkFtRFI4WkM3czhZWXlWc3BmVjBVVVRVY3lwd2NwWW93?=
 =?utf-8?B?aUFEaWVJbk1oNUhOKzQ0eGdRSDYwcXc3QjF4N0RmdXFlK0ZSVGdseDV3K3dK?=
 =?utf-8?B?Y0NXZHRRWTJLSmkxd1dMOXZCdTZkenM0bGlQUGNOTU5TTWtuYkU5MkFZRHc1?=
 =?utf-8?B?ODk2L2tWOVlRYUJaSHFEQWI0OU8rUWhIUkc5QzNDeHFTTk5Ia3RxSFQvNlZz?=
 =?utf-8?B?SllVdkhLcDZlZlpOeGdsQ3RFV0NSZUx6bzltVGdjUHdWZ0dkT0srRzFWSitN?=
 =?utf-8?B?MUtGWThnaEJMRElzTHZQb2kxVG9MQkNETnorZ3AwcDNkQ29DRndWMWZNanZS?=
 =?utf-8?B?cGduNDI1d0FRVXZIbEhrYU5yVVZnRWxnQkJlY0dzZkZYZW1xVUE0QWZjUkhw?=
 =?utf-8?B?TVY3TitoY0VCejh3VENnNFB4WUVudVVNNURuRzNKMWd0S0xWa1Jock81emdv?=
 =?utf-8?Q?oMkVe6bKDCzRSToxKzBQCDs2S?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0DB14A76A313A04CBF058D0A43DEDEB1@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa740a78-7a44-4512-198a-08dc43f1b013
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2024 06:40:49.9731
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UmcvNmh0Gs3CaVhQXWE5TdzcGZf9cXFXeYFBJ3A7ZxVn/Su0uC/YwPS0rCLaRBalrZtnaSO8eUo62siQedKIIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7903
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--12.046400-8.000000
X-TMASE-MatchedRID: nVQUmLJJeyboSitJVour/d7SWiiWSV/1jLOy13Cgb49qSjxROy+AU3a2
	v7MgC776yAUgFH8TZu5isDrIDgWLgAyJM1t3sBlJQ4srjeRbxTZ3Bf9JIqsoeL/XDMnRl2JlxGu
	+O8UpNrEDQU/rQijmtKvMY/aqkep6HrMyxzwkG/RAwvZYEy8IBX0tCKdnhB58pTwPRvSoXL2y5/
	tFZu9S3Ku6xVHLhqfxIAcCikR3vq9MsTqZ9oycYkdVe8gkMHn7MW2uiYsM3s9ShqcaneZMgTNUz
	q5rQJEW
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--12.046400-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	A185358A02A28BCB5A873F315C2D80BBF5BF27A5F0190566D3FF42D558859E162000:8

SGksIFNoYXduOg0KDQpPbiBNb24sIDIwMjQtMDItMjYgYXQgMTY6NTAgKzA4MDAsIFNoYXduIFN1
bmcgd3JvdGU6DQo+IEZyb206IEhzaWFvIENoaWVuIFN1bmcgPHNoYXduLnN1bmdAbWVkaWF0ZWsu
Y29ycC1wYXJ0bmVyLmdvb2dsZS5jb20+DQo+IA0KPiBSZW5hbWUgZmlsZXMgbXRrX2RybV9jcnRj
LiogdG8gbXRrX2NydGMuKi4NCg0KUmV2aWV3ZWQtYnk6IENLIEh1IDxjay5odUBtZWRpYXRlay5j
b20+DQoNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEhzaWFvIENoaWVuIFN1bmcgPA0KPiBzaGF3bi5z
dW5nQG1lZGlhdGVrLmNvcnAtcGFydG5lci5nb29nbGUuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMv
Z3B1L2RybS9tZWRpYXRlay9NYWtlZmlsZSAgICAgICAgICAgICAgICAgICAgICAgfCAyICstDQo+
ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsve210a19kcm1fY3J0Yy5jID0+IG10a19jcnRjLmN9
IHwgMiArLQ0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL3ttdGtfZHJtX2NydGMuaCA9PiBt
dGtfY3J0Yy5ofSB8IDANCj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9hYWwu
YyAgICAgICAgICAgICAgICAgfCAyICstDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRr
X2Rpc3BfY2NvcnIuYyAgICAgICAgICAgICAgIHwgMiArLQ0KPiAgZHJpdmVycy9ncHUvZHJtL21l
ZGlhdGVrL210a19kaXNwX2NvbG9yLmMgICAgICAgICAgICAgICB8IDIgKy0NCj4gIGRyaXZlcnMv
Z3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9nYW1tYS5jICAgICAgICAgICAgICAgfCAyICstDQo+
ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bfb3ZsLmMgICAgICAgICAgICAgICAg
IHwgMiArLQ0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX292bF9hZGFwdG9y
LmMgICAgICAgICB8IDIgKy0NCj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9y
ZG1hLmMgICAgICAgICAgICAgICAgfCAyICstDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsv
bXRrX2RybV9kZHBfY29tcC5jICAgICAgICAgICAgIHwgMiArLQ0KPiAgZHJpdmVycy9ncHUvZHJt
L21lZGlhdGVrL210a19kcm1fZHJ2LmMgICAgICAgICAgICAgICAgICB8IDIgKy0NCj4gIGRyaXZl
cnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX3BsYW5lLmMgICAgICAgICAgICAgICAgfCAyICst
DQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2V0aGRyLmMgICAgICAgICAgICAgICAg
ICAgIHwgMiArLQ0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19wYWRkaW5nLmMgICAg
ICAgICAgICAgICAgICB8IDIgKy0NCj4gIDE1IGZpbGVzIGNoYW5nZWQsIDE0IGluc2VydGlvbnMo
KyksIDE0IGRlbGV0aW9ucygtKQ0KPiAgcmVuYW1lIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay97
bXRrX2RybV9jcnRjLmMgPT4gbXRrX2NydGMuY30gKDk5JSkNCj4gIHJlbmFtZSBkcml2ZXJzL2dw
dS9kcm0vbWVkaWF0ZWsve210a19kcm1fY3J0Yy5oID0+IG10a19jcnRjLmh9DQo+ICgxMDAlKQ0K
PiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9NYWtlZmlsZQ0KPiBi
L2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9NYWtlZmlsZQ0KPiBpbmRleCA1ZTQ0MzY0MDNiOGQu
LmVkYWQ3MTgwODJhOSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL01h
a2VmaWxlDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9NYWtlZmlsZQ0KPiBAQCAt
OCw3ICs4LDcgQEAgbWVkaWF0ZWstZHJtLXkgOj0gbXRrX2Rpc3BfYWFsLm8gXA0KPiAgCQkgIG10
a19kaXNwX292bC5vIFwNCj4gIAkJICBtdGtfZGlzcF9vdmxfYWRhcHRvci5vIFwNCj4gIAkJICBt
dGtfZGlzcF9yZG1hLm8gXA0KPiAtCQkgIG10a19kcm1fY3J0Yy5vIFwNCj4gKwkJICBtdGtfY3J0
Yy5vIFwNCj4gIAkJICBtdGtfZHJtX2RkcF9jb21wLm8gXA0KPiAgCQkgIG10a19kcm1fZHJ2Lm8g
XA0KPiAgCQkgIG10a19kcm1fZ2VtLm8gXA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L21lZGlhdGVrL210a19kcm1fY3J0Yy5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210
a19jcnRjLmMNCj4gc2ltaWxhcml0eSBpbmRleCA5OSUNCj4gcmVuYW1lIGZyb20gZHJpdmVycy9n
cHUvZHJtL21lZGlhdGVrL210a19kcm1fY3J0Yy5jDQo+IHJlbmFtZSB0byBkcml2ZXJzL2dwdS9k
cm0vbWVkaWF0ZWsvbXRrX2NydGMuYw0KPiBpbmRleCBkOGI1OTFhZmYzYzIuLjUwM2JkY2Q3ZTU5
NiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fY3J0Yy5j
DQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfY3J0Yy5jDQo+IEBAIC0yMCw3
ICsyMCw3IEBADQo+ICAjaW5jbHVkZSA8ZHJtL2RybV92YmxhbmsuaD4NCj4gIA0KPiAgI2luY2x1
ZGUgIm10a19kcm1fZHJ2LmgiDQo+IC0jaW5jbHVkZSAibXRrX2RybV9jcnRjLmgiDQo+ICsjaW5j
bHVkZSAibXRrX2NydGMuaCINCj4gICNpbmNsdWRlICJtdGtfZHJtX2RkcF9jb21wLmgiDQo+ICAj
aW5jbHVkZSAibXRrX2RybV9nZW0uaCINCj4gICNpbmNsdWRlICJtdGtfZHJtX3BsYW5lLmgiDQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9jcnRjLmgNCj4g
Yi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2NydGMuaA0KPiBzaW1pbGFyaXR5IGluZGV4
IDEwMCUNCj4gcmVuYW1lIGZyb20gZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fY3J0
Yy5oDQo+IHJlbmFtZSB0byBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2NydGMuaA0KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX2FhbC5jDQo+IGIv
ZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX2FhbC5jDQo+IGluZGV4IDQwZmU0MDMw
ODZjMy4uMDA1ZmM5ZGUyZWU5IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0
ZWsvbXRrX2Rpc3BfYWFsLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19k
aXNwX2FhbC5jDQo+IEBAIC0xMiw3ICsxMiw3IEBADQo+ICAjaW5jbHVkZSA8bGludXgvc29jL21l
ZGlhdGVrL210ay1jbWRxLmg+DQo+ICANCj4gICNpbmNsdWRlICJtdGtfZGlzcF9kcnYuaCINCj4g
LSNpbmNsdWRlICJtdGtfZHJtX2NydGMuaCINCj4gKyNpbmNsdWRlICJtdGtfY3J0Yy5oIg0KPiAg
I2luY2x1ZGUgIm10a19kcm1fZGRwX2NvbXAuaCINCj4gICNpbmNsdWRlICJtdGtfZHJtX2Rydi5o
Ig0KPiAgDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bf
Y2NvcnIuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9jY29yci5jDQo+
IGluZGV4IDQ2NWNkZGNlMGQzMi4uY2JkZWUzOTg2MTIwIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJz
L2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfY2NvcnIuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9k
cm0vbWVkaWF0ZWsvbXRrX2Rpc3BfY2NvcnIuYw0KPiBAQCAtMTEsNyArMTEsNyBAQA0KPiAgI2lu
Y2x1ZGUgPGxpbnV4L3NvYy9tZWRpYXRlay9tdGstY21kcS5oPg0KPiAgDQo+ICAjaW5jbHVkZSAi
bXRrX2Rpc3BfZHJ2LmgiDQo+IC0jaW5jbHVkZSAibXRrX2RybV9jcnRjLmgiDQo+ICsjaW5jbHVk
ZSAibXRrX2NydGMuaCINCj4gICNpbmNsdWRlICJtdGtfZHJtX2RkcF9jb21wLmgiDQo+ICAjaW5j
bHVkZSAibXRrX2RybV9kcnYuaCINCj4gIA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L21lZGlhdGVrL210a19kaXNwX2NvbG9yLmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsv
bXRrX2Rpc3BfY29sb3IuYw0KPiBpbmRleCA3OGVhOTlmMTQ0NGYuLmUyMTI0YjQ0Nzc2NyAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX2NvbG9yLmMNCj4g
KysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX2NvbG9yLmMNCj4gQEAgLTEx
LDcgKzExLDcgQEANCj4gICNpbmNsdWRlIDxsaW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaD4N
Cj4gIA0KPiAgI2luY2x1ZGUgIm10a19kaXNwX2Rydi5oIg0KPiAtI2luY2x1ZGUgIm10a19kcm1f
Y3J0Yy5oIg0KPiArI2luY2x1ZGUgIm10a19jcnRjLmgiDQo+ICAjaW5jbHVkZSAibXRrX2RybV9k
ZHBfY29tcC5oIg0KPiAgI2luY2x1ZGUgIm10a19kcm1fZHJ2LmgiDQo+ICANCj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9nYW1tYS5jDQo+IGIvZHJpdmVy
cy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX2dhbW1hLmMNCj4gaW5kZXggYzFiYzhiMDBkOTM4
Li44NGIwMjA2NDgwOGIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9t
dGtfZGlzcF9nYW1tYS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlz
cF9nYW1tYS5jDQo+IEBAIC0xMiw3ICsxMiw3IEBADQo+ICAjaW5jbHVkZSA8bGludXgvc29jL21l
ZGlhdGVrL210ay1jbWRxLmg+DQo+ICANCj4gICNpbmNsdWRlICJtdGtfZGlzcF9kcnYuaCINCj4g
LSNpbmNsdWRlICJtdGtfZHJtX2NydGMuaCINCj4gKyNpbmNsdWRlICJtdGtfY3J0Yy5oIg0KPiAg
I2luY2x1ZGUgIm10a19kcm1fZGRwX2NvbXAuaCINCj4gICNpbmNsdWRlICJtdGtfZHJtX2Rydi5o
Ig0KPiAgDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bf
b3ZsLmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bfb3ZsLmMNCj4gaW5k
ZXggMmJmZmU0MjQ1NDY2Li4wYWI2ODBlMTE4NjIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9tZWRpYXRlay9tdGtfZGlzcF9vdmwuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVk
aWF0ZWsvbXRrX2Rpc3Bfb3ZsLmMNCj4gQEAgLTE2LDcgKzE2LDcgQEANCj4gICNpbmNsdWRlIDxs
aW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaD4NCj4gIA0KPiAgI2luY2x1ZGUgIm10a19kaXNw
X2Rydi5oIg0KPiAtI2luY2x1ZGUgIm10a19kcm1fY3J0Yy5oIg0KPiArI2luY2x1ZGUgIm10a19j
cnRjLmgiDQo+ICAjaW5jbHVkZSAibXRrX2RybV9kZHBfY29tcC5oIg0KPiAgI2luY2x1ZGUgIm10
a19kcm1fZHJ2LmgiDQo+ICANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRl
ay9tdGtfZGlzcF9vdmxfYWRhcHRvci5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210
a19kaXNwX292bF9hZGFwdG9yLmMNCj4gaW5kZXggMDM0ZDMxODI0ZDRkLi5mMmQ5YzM3Mjg3OWEg
MTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9vdmxfYWRh
cHRvci5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9vdmxfYWRh
cHRvci5jDQo+IEBAIC0xOCw3ICsxOCw3IEBADQo+ICAjaW5jbHVkZSA8bGludXgvc29jL21lZGlh
dGVrL210ay1tdXRleC5oPg0KPiAgDQo+ICAjaW5jbHVkZSAibXRrX2Rpc3BfZHJ2LmgiDQo+IC0j
aW5jbHVkZSAibXRrX2RybV9jcnRjLmgiDQo+ICsjaW5jbHVkZSAibXRrX2NydGMuaCINCj4gICNp
bmNsdWRlICJtdGtfZHJtX2RkcF9jb21wLmgiDQo+ICAjaW5jbHVkZSAibXRrX2RybV9kcnYuaCIN
Cj4gICNpbmNsdWRlICJtdGtfZXRoZHIuaCINCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9tZWRpYXRlay9tdGtfZGlzcF9yZG1hLmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsv
bXRrX2Rpc3BfcmRtYS5jDQo+IGluZGV4IGZhYTkwN2YyZjQ0My4uYWY3ODI0MDIyOWU4IDEwMDY0
NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfcmRtYS5jDQo+ICsr
KyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9yZG1hLmMNCj4gQEAgLTE0LDcg
KzE0LDcgQEANCj4gICNpbmNsdWRlIDxsaW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaD4NCj4g
IA0KPiAgI2luY2x1ZGUgIm10a19kaXNwX2Rydi5oIg0KPiAtI2luY2x1ZGUgIm10a19kcm1fY3J0
Yy5oIg0KPiArI2luY2x1ZGUgIm10a19jcnRjLmgiDQo+ICAjaW5jbHVkZSAibXRrX2RybV9kZHBf
Y29tcC5oIg0KPiAgI2luY2x1ZGUgIm10a19kcm1fZHJ2LmgiDQo+ICANCj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2RkcF9jb21wLmMNCj4gYi9kcml2ZXJz
L2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHBfY29tcC5jDQo+IGluZGV4IGE1MTVlOTZjZmVm
Yy4uYjJjMDY2NTg2N2QzIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsv
bXRrX2RybV9kZHBfY29tcC5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtf
ZHJtX2RkcF9jb21wLmMNCj4gQEAgLTE4LDcgKzE4LDcgQEANCj4gICNpbmNsdWRlICJtdGtfZHJt
X2Rydi5oIg0KPiAgI2luY2x1ZGUgIm10a19kcm1fcGxhbmUuaCINCj4gICNpbmNsdWRlICJtdGtf
ZHJtX2RkcF9jb21wLmgiDQo+IC0jaW5jbHVkZSAibXRrX2RybV9jcnRjLmgiDQo+ICsjaW5jbHVk
ZSAibXRrX2NydGMuaCINCj4gIA0KPiAgDQo+ICAjZGVmaW5lIERJU1BfUkVHX0RJVEhFUl9FTgkJ
CTB4MDAwMA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1f
ZHJ2LmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kcnYuYw0KPiBpbmRl
eCA4MWU4YWE2NWFiZDYuLjdiZTNiMDU0NmQzZCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL21lZGlhdGVrL210a19kcm1fZHJ2LmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlh
dGVrL210a19kcm1fZHJ2LmMNCj4gQEAgLTI0LDcgKzI0LDcgQEANCj4gICNpbmNsdWRlIDxkcm0v
ZHJtX3Byb2JlX2hlbHBlci5oPg0KPiAgI2luY2x1ZGUgPGRybS9kcm1fdmJsYW5rLmg+DQo+ICAN
Cj4gLSNpbmNsdWRlICJtdGtfZHJtX2NydGMuaCINCj4gKyNpbmNsdWRlICJtdGtfY3J0Yy5oIg0K
PiAgI2luY2x1ZGUgIm10a19kcm1fZGRwX2NvbXAuaCINCj4gICNpbmNsdWRlICJtdGtfZHJtX2Ry
di5oIg0KPiAgI2luY2x1ZGUgIm10a19kcm1fZ2VtLmgiDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9wbGFuZS5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL21l
ZGlhdGVrL210a19kcm1fcGxhbmUuYw0KPiBpbmRleCBkYjYzYTMyYzQwN2UuLjcyMGY2YjRiMDgy
MSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fcGxhbmUu
Yw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9wbGFuZS5jDQo+IEBA
IC0xMyw3ICsxMyw3IEBADQo+ICAjaW5jbHVkZSA8ZHJtL2RybV9nZW1fYXRvbWljX2hlbHBlci5o
Pg0KPiAgI2luY2x1ZGUgPGxpbnV4L2FsaWduLmg+DQo+ICANCj4gLSNpbmNsdWRlICJtdGtfZHJt
X2NydGMuaCINCj4gKyNpbmNsdWRlICJtdGtfY3J0Yy5oIg0KPiAgI2luY2x1ZGUgIm10a19kcm1f
ZGRwX2NvbXAuaCINCj4gICNpbmNsdWRlICJtdGtfZHJtX2Rydi5oIg0KPiAgI2luY2x1ZGUgIm10
a19kcm1fZ2VtLmgiDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRr
X2V0aGRyLmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2V0aGRyLmMNCj4gaW5k
ZXggNmE1ZDBjMzQ1YWFiLi40MWVmYWFmZTI2ZjEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9tZWRpYXRlay9tdGtfZXRoZHIuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0
ZWsvbXRrX2V0aGRyLmMNCj4gQEAgLTE0LDcgKzE0LDcgQEANCj4gICNpbmNsdWRlIDxsaW51eC9z
b2MvbWVkaWF0ZWsvbXRrLWNtZHEuaD4NCj4gICNpbmNsdWRlIDxsaW51eC9zb2MvbWVkaWF0ZWsv
bXRrLW1tc3lzLmg+DQo+ICANCj4gLSNpbmNsdWRlICJtdGtfZHJtX2NydGMuaCINCj4gKyNpbmNs
dWRlICJtdGtfY3J0Yy5oIg0KPiAgI2luY2x1ZGUgIm10a19kcm1fZGRwX2NvbXAuaCINCj4gICNp
bmNsdWRlICJtdGtfZHJtX2Rydi5oIg0KPiAgI2luY2x1ZGUgIm10a19ldGhkci5oIg0KPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19wYWRkaW5nLmMNCj4gYi9kcml2
ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX3BhZGRpbmcuYw0KPiBpbmRleCAwZDY0NTFjMTQ5YjYu
LmNmMjMzZTQzZjk1YyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210
a19wYWRkaW5nLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19wYWRkaW5n
LmMNCj4gQEAgLTEyLDcgKzEyLDcgQEANCj4gICNpbmNsdWRlIDxsaW51eC9zb2MvbWVkaWF0ZWsv
bXRrLWNtZHEuaD4NCj4gIA0KPiAgI2luY2x1ZGUgIm10a19kaXNwX2Rydi5oIg0KPiAtI2luY2x1
ZGUgIm10a19kcm1fY3J0Yy5oIg0KPiArI2luY2x1ZGUgIm10a19jcnRjLmgiDQo+ICAjaW5jbHVk
ZSAibXRrX2RybV9kZHBfY29tcC5oIg0KPiAgDQo+ICAjZGVmaW5lIFBBRERJTkdfQ09OVFJPTF9S
RUcJMHgwMA0K

