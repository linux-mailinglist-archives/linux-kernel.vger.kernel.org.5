Return-Path: <linux-kernel+bounces-82541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB63E86860B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 02:36:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AC4D1F25434
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 01:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1463EFBEA;
	Tue, 27 Feb 2024 01:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="aGvP5ZNH";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="UCETVs8M"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40F76AD7;
	Tue, 27 Feb 2024 01:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708997792; cv=fail; b=S56IUVfsaV3bCYpYYD95a97hhjNJQmpcuqzt/aKs3K5a9r0TZwPbGBVUxmgnQwZ0MSh5D2sDVzDESZFBHgwYojNP5GxZ400A5ZdCV6pbUbdRhzrZg/OUDUoJkMGqDmZsSE+LSRb8X91wyGyrisBVxy8kxNEkl6AZEzxrRtj4R8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708997792; c=relaxed/simple;
	bh=CRmUzy7IUSu+OfXMy3RljB/x0M0uASSLmp0POe3nsh0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DHQ33kfwm+qKmZ4fjZSO7sTaiHToprugkQVigfnrD4XV9aHqI247VsylPax1267IgLtNne1Ulrh1fHWMl53adypqD1W3NgWaR1yLwT6WoFgzAGdfUk4+ZU4MsjikU6O6aNjnmgNFk4+M41X520FYEz7rSUEQyzJHtYHBKCtx5gU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=aGvP5ZNH; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=UCETVs8M; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 9e4660e4d51011eea528b71b88a53856-20240227
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=CRmUzy7IUSu+OfXMy3RljB/x0M0uASSLmp0POe3nsh0=;
	b=aGvP5ZNHx5l4lfHcXLjDdLW4Kvu+N4++vP9GBBrNWTL+OsxBMc/b+dJUGdqRfgDCCpav5sJ8tcshwxL6tHqvP6iJFndyMv2guqbstwT8L0ZZuDQYwBbKFzFb2wVipeQawH794d/Z+WFAPnh8zLMPys2Nt4cBsxKUl13W7TbgeY4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:dd7cd407-85cc-4d90-ad86-cab5be3fe829,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6f543d0,CLOUDID:75eebf8f-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 9e4660e4d51011eea528b71b88a53856-20240227
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <zhi.mao@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 766669036; Tue, 27 Feb 2024 09:36:24 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 27 Feb 2024 09:36:23 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 27 Feb 2024 09:36:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mn7ViTW6A7qxI1LON7SGxMTv0DQPAgLzpTfJXjAOgKI55ptddl6imxGHFCyBIRtRgkOWZa2TFKJBzSze7Dvw3+j4kF2xGYU5XGcEkwNq/C0t33uCgE1SdoriMeHqv6BEv4sL2GEg1xBqO03kXhrcYe06WexudHSj9f83SVYjFWJzopFy6mHr65QZIzhvW7trksC66bmGEOlei1NVhYVqMvUv3xtVgPibhFw+a42A4f9YSG8ay9kAEaNs9imTrFNkz6lyFA4kcX/eVD6NvHCkjktfAFQZdn2HdCeRil9iug+Qoq9Fk1mGCEgEUVpRb278mdTA0qzqTYygAwpSJ3O1EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CRmUzy7IUSu+OfXMy3RljB/x0M0uASSLmp0POe3nsh0=;
 b=nS2H5KS+jObBtPinmmQ//KzAF2Ey2VJqYfgiasUFXq1PD6rkwLo5PKWtmKhVu8Brni9K/zlZyUD1Doeyxxt/X+TLArnZTOGOQZxp1qdFFPtrv0N/f3qj/nefj4tUYcliL2gP3CuanxWyohWkV2KiziBxjfAuIJUR1zsDhu/miDkN6m+Shybk9WpQ5DOrnpcOdVOpQ73nvlKTb7VTv3/AXyh25GGq87Apiupkh6/QC/mOOxLOXpKFAJKXN0phi1sWrhbWHZ1+OJQGQkBvpYfIUqNomkZom7adzRHP/scMdQScZ/5Vf8SuAaVFGO+mGE393QF3JyyHHLuJkyeRKyO0Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CRmUzy7IUSu+OfXMy3RljB/x0M0uASSLmp0POe3nsh0=;
 b=UCETVs8M4lBHGl74IYa/gTmKqsoE3qDyDp/220WDZ16fypkE8W5WW4LbKH3lV4KDyHH+jGM0x13wYMi7eBMZO13sPO4oOixm+P52jy+XbMuMrE8gx3XexnMKNiOrKpGRFxl+1zm8KGvc+DMAeapljf6Qa1GIQFlxBZlRPO5xUxw=
Received: from TYZPR03MB5566.apcprd03.prod.outlook.com (2603:1096:400:53::7)
 by KL1PR0302MB5379.apcprd03.prod.outlook.com (2603:1096:820:4a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Tue, 27 Feb
 2024 01:36:19 +0000
Received: from TYZPR03MB5566.apcprd03.prod.outlook.com
 ([fe80::f890:d417:7a30:6413]) by TYZPR03MB5566.apcprd03.prod.outlook.com
 ([fe80::f890:d417:7a30:6413%4]) with mapi id 15.20.7316.035; Tue, 27 Feb 2024
 01:36:19 +0000
From: =?utf-8?B?WmhpIE1hbyAo5q+b5pm6KQ==?= <zhi.mao@mediatek.com>
To: "sakari.ailus@linux.intel.com" <sakari.ailus@linux.intel.com>
CC: "heiko@sntech.de" <heiko@sntech.de>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "yunkec@chromium.org" <yunkec@chromium.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "dan.scally@ideasonboard.com"
	<dan.scally@ideasonboard.com>, "linux-media@vger.kernel.org"
	<linux-media@vger.kernel.org>, "hdegoede@redhat.com" <hdegoede@redhat.com>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	=?utf-8?B?U2hlbmduYW4gV2FuZyAo546L5Zyj55S3KQ==?=
	<shengnan.wang@mediatek.com>, "linus.walleij@linaro.org"
	<linus.walleij@linaro.org>, "andy.shevchenko@gmail.com"
	<andy.shevchenko@gmail.com>, =?utf-8?B?WWF5YSBDaGFuZyAo5by16ZuF5riFKQ==?=
	<Yaya.Chang@mediatek.com>, "jacopo.mondi@ideasonboard.com"
	<jacopo.mondi@ideasonboard.com>, "gerald.loacker@wolfvision.net"
	<gerald.loacker@wolfvision.net>, "jernej.skrabec@gmail.com"
	<jernej.skrabec@gmail.com>, "mchehab@kernel.org" <mchehab@kernel.org>,
	Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"tomi.valkeinen@ideasonboard.com" <tomi.valkeinen@ideasonboard.com>,
	"10572168@qq.com" <10572168@qq.com>, "hverkuil-cisco@xs4all.nl"
	<hverkuil-cisco@xs4all.nl>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"laurent.pinchart@ideasonboard.com" <laurent.pinchart@ideasonboard.com>,
	"bingbu.cao@intel.com" <bingbu.cao@intel.com>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "macromorgan@hotmail.com"
	<macromorgan@hotmail.com>
Subject: Re: [PATCH v4 2/2] media: i2c: Add GC08A3 image sensor driver
Thread-Topic: [PATCH v4 2/2] media: i2c: Add GC08A3 image sensor driver
Thread-Index: AQHaVzH+Ve+4uX+wTUqBqQq2qHHPDrD9qvsAgBTrHQCAAA2ZAIAALgyAgAAb+ICAAUG2AIAAVYWAgAkHZAA=
Date: Tue, 27 Feb 2024 01:36:19 +0000
Message-ID: <6be0e8d2e899bcc9505ec62ba59290f97a07d812.camel@mediatek.com>
References: <20240204061538.2105-1-zhi.mao@mediatek.com>
	 <20240204061538.2105-3-zhi.mao@mediatek.com>
	 <20240206184542.GE2827@pendragon.ideasonboard.com>
	 <598f62bbb55157eec1e23dd1dbc307fea3851b21.camel@mediatek.com>
	 <20240220030104.GF20376@pendragon.ideasonboard.com>
	 <115698c0c549e747026cc8841a3bd571533f8e6f.camel@mediatek.com>
	 <ZdRUB92gkbRGPyr_@kekkonen.localdomain>
	 <063fa9763efb1570295cfef385829714dd5e42cf.camel@mediatek.com>
	 <ZdWpow0JIM18Hc4u@kekkonen.localdomain>
In-Reply-To: <ZdWpow0JIM18Hc4u@kekkonen.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB5566:EE_|KL1PR0302MB5379:EE_
x-ms-office365-filtering-correlation-id: 883ccef1-d5be-4495-8da6-08dc37347f79
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: itEmI0aFbXGSIBI74o+5x1Q/nyxjwL2DLmc94GATPcuIJRjb4semTC1xlhuzqvYi3CkJ+2L9oZFPxfvc+8wG2UrI4tdv7s41wncSZ900dm65NvgbnlIPHkAGzxJMwYhie55ME+ARcVVMsIlsA1pb6rrP/7FQNLAFHxlr5j35fuKZx2VC+Rh2SehEmbMR/3UJQ3cMc1BISTcDBiUReiEvZ0LXbWmXnEi06H/lvQEiArA7qvw0sd3Wp0W94MARrsRHVm7D+RXb8A6gKclVuoE/ZIjLj4eFm4KgngYVQrwMEM8oE+NekOiFNwaWk+v5CK7g4Am9z18iK94cQhZbmWVEQEUj3yD2Fe6Ci5dcFC74eayfKh0s0mUgo4uM+PSYz9V7MhisdLnWXSqVrm3hxaVaxbXNcGj2NE3KgQSJzGhUwEDGpEHwAq0t/xgy9Ew24N7G3s5Pmw8KqI+Wr62tNmly6dWApG61hmXz/2DJgZ2wgyKXuNsruxLHh8KaXcgy5+pk3jkJ8AM6xxsqZeDEU+2DxCpHHkiC+PZdkZBGnunaf8mklxvXf5haIFcfgeL982cCicDgF9601HK+iO71Ddcy3z0WOY5U2/4xCvjfu8r6VHD7J8+QjKQ+KwWWagfF7ZydP5CGa/nrYXKyTkYFgvAQmrskmsoZJRrVlkx66lxpxokQXP2cwEnkr2GBOkAhZOVbvgkvhhEkCYDo97JScB+zmUuRJFw9gJqopHs5fEKivwU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB5566.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230273577357003)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YmRIRHY5UVp1SGlGSVczM2hOenVXdVJYN01uRVl2UzFQQWgzcUoxaktLYzlh?=
 =?utf-8?B?b24rZ2pTUWVSbk1CL2RuUkJWbHBXT0JYN3RENW1KQzRueXV6MTlDb1Z6TzNl?=
 =?utf-8?B?M3FsU3NWaEg5KzdpRXduNnlQbFd3RlRVN1V1Wk9GbTZJTEc1Q2YvK0xVMk9G?=
 =?utf-8?B?TUpiSEsrOXZGYzdFazg0bmxMMUNCTmJWcm9sOGdaWjd1Y0hqdmJKRTRSS1g4?=
 =?utf-8?B?enFMeGlYcEN6NnQ5bUozdVdQNnBjOThPTXRRZStsQUtsMTV3NHJIMExMdStL?=
 =?utf-8?B?VXFEVUJ2MUJ4NVRoZDRXakk2b2I4S2pEbE9NSFVHUTFXdGk1anZtb1VneDdQ?=
 =?utf-8?B?TmU0czVSMjBOTExmT0NpRTVZU2xZbzFYd01BSzUxWlZ0UkVhbXJ3QUovS0lL?=
 =?utf-8?B?OStSNlIvWTRGZXBnUGtNSVBhWTlvNzErV3poSHZOVFhCZWFwRU45ZVhTZy9p?=
 =?utf-8?B?VnBYcG8yQXNCZ3V1S1ozN3lLVUdtWGpldTN6UEpUVndEd0VzbEZRM2U3Tm1y?=
 =?utf-8?B?RjBhVDluMUh6U1daSmVJSWQ0QjR1bldkL1FOdTVnVCtIK055VVJHTmwzMlJv?=
 =?utf-8?B?dExwR1ZYME1UMU5wK0JPMks5QVp4d3gvRmZnc0o0Z1ZEdFBsc214Sm5pVHJa?=
 =?utf-8?B?ZTNZcHMxZW53TWVDMXVrc3BhK0hpOHg5L0s4bmNLSlhOZFo3QzI4T2ZpOGJs?=
 =?utf-8?B?U2I2bUVrZ011NmpJK2VWR2w2QjFxQjgrNDZ6L0lWRngya2IxVXEyUE5rekg1?=
 =?utf-8?B?ZmlDNnl1aWZpYlAzd1NOdTNXRW4rN0VmOUhRUDRMVW5TdllGaHd0MDUzeEhr?=
 =?utf-8?B?ZnZnOWNNMHMxZzVFYVlBcUpCUWlpQ2I2K2FoN2p2VjUyVmtQQzJ0YXZ6MkQ5?=
 =?utf-8?B?UjlobmpwZ1JSeDdIMG54ZlIzb1U1UWhRSWQrMlhCc3MxeWp5TG4vQ2NXNFFQ?=
 =?utf-8?B?cHRwbjB4N3VSbXljT3VQOGNQaDZBQlJ3MG04cjJUS0x1OWlUTnlsM04wWXVi?=
 =?utf-8?B?N1NsZFJBa3J1enI2dHp5T2pMcElkaUdKT3FPeWtRcE01RWVjS0h6VlNFNll3?=
 =?utf-8?B?U0wzNWgxdEpnZWRGcFZITnRzeWJ3YUJFZ0pGdmxVbnpJZE42a1JrdGtRNDhP?=
 =?utf-8?B?dFZpUVphUE4zVUxiQW9nYUl1ZkpqRmk2TVcwbzdTYlBrUjhuaXd1dDVESzh0?=
 =?utf-8?B?NDVXUEYxaUo3cXhQMFZ5bnRkM3RxSzZac1N4U3VBem1OdVZUb0lkaG1teUNm?=
 =?utf-8?B?N21DSGNmcU0xNWhpYzY1NzZzTkJPYXBselRmczBmNXpZenBtd2lUd3JrZlg3?=
 =?utf-8?B?Wm0wSnJKZTVWQTMxczZvbE5JdDhnallHbzFZdVF3ZVhVZXpUMjdOSzYwUUhL?=
 =?utf-8?B?RjhlQ1N0bEZGc2wzQnlpU3BWL2d5RkVTOWkxWUJqbGRFRFhhMTlCbFI4WUk3?=
 =?utf-8?B?VGR2ZGZhNE1hall0T0ZMZURJNEczSXMra3hqQ0tPWEY4UUtWYm9CY0I1ajdL?=
 =?utf-8?B?MHVDanAvVXRmM1ZlL3RPRzJORm52eTFUTkV6Y3ErMEgzRlRTbXc1a3N6U05L?=
 =?utf-8?B?elhMRGUvSkZvcldIWCtyT0FmRFAvcjhOU3RyakVzM2lzS1ZlNEtPWENQVk43?=
 =?utf-8?B?Lzg1NDAxNjBxc28rbGZnU3lsRTlXemNFeU9TdmRhbkttcTlnd3p3RVRmeUcr?=
 =?utf-8?B?YUZ4cllyK0UrVms3bVBpYUl0N1FOaHRoSnM2UTB0amVuY1ZqOFArWWdFWklJ?=
 =?utf-8?B?MlFxUDNQL212d3lwVWVYOWkxQkZsM08rYm44eXYvckY0aC9WVW9FYXNuSXF0?=
 =?utf-8?B?UzI3OFhQSG8ydFFGWDF2d3NyUVZPTkUxSldYSGJMU1pQbGxlK0VXcXkrUklv?=
 =?utf-8?B?eFlpbWlhTjNvUzMzYnZwMWFubHZUbDg5ZTFsNmYrV2ZsdHdSSWVsMVRJazNi?=
 =?utf-8?B?Q2dXbDdtL2FtdDNEMlNmbFlObStkdzMxWkdwQ05DOHNvZzVGeDZ1Y3lBL1p0?=
 =?utf-8?B?bXdOS1ExK0NjbUV6cEJEalhpM3cwc29rQ0MvUkl1TlR6WGtKTXp2VWtCdEpY?=
 =?utf-8?B?OG4vTmNsa2E2UVdMRTV2Vi94SytzdEhHZnpCUXJPQlpWQ2xkNnlwaTZlbGo4?=
 =?utf-8?B?anZwTG9XQ2pyelk0MDd2WWNmUzBMQUlGcUhzeUVCMWlNNGJJSUJleTZ2V3pp?=
 =?utf-8?B?K0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A0AD4177DB2E064B816DEA29514D1D8C@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB5566.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 883ccef1-d5be-4495-8da6-08dc37347f79
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2024 01:36:19.5982
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZQpP4UZ9ShhVeCBLRVCeV7JJPCisuY4WFHQd/X8RslU4aJw5QTj57V49TELr+EQFc2U6QNe7v92kXXmI4jrhBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0302MB5379

SGkgU2FrYXJpLA0KDQpUaGFua3MgZm9yIHlvdXIgZmVlZGJhY2suDQoNCk9uIFdlZCwgMjAyNC0w
Mi0yMSBhdCAwNzo0MyArMDAwMCwgc2FrYXJpLmFpbHVzQGxpbnV4LmludGVsLmNvbSB3cm90ZToN
Cj4gIAkgDQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBv
cGVuIGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3Ig
dGhlIGNvbnRlbnQuDQo+ICBIaSBaaGksDQo+IA0KPiBPbiBXZWQsIEZlYiAyMSwgMjAyNCBhdCAw
MjozNzoyN0FNICswMDAwLCBaaGkgTWFvICjmr5vmmbopIHdyb3RlOg0KPiA+IEhpIExhdXJlbnQg
JiBzYWthcmksDQo+ID4gDQo+ID4gVGhhbmtzIGZvciB5b3VyIGZlZWRiYWNrLg0KPiA+IA0KPiA+
IE9uIFR1ZSwgMjAyNC0wMi0yMCBhdCAwNzoyNSArMDAwMCwgc2FrYXJpLmFpbHVzQGxpbnV4Lmlu
dGVsLmNvbQ0KPiB3cm90ZToNCj4gPiA+ICAgDQo+ID4gPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFz
ZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cw0KPiB1bnRpbA0KPiA+ID4g
eW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUgY29udGVudC4NCj4gPiA+ICBIaSBa
aGksDQo+ID4gPiANCj4gPiA+IE9uIFR1ZSwgRmViIDIwLCAyMDI0IGF0IDA1OjQ1OjU0QU0gKzAw
MDAsIFpoaSBNYW8gKOavm+aZuikgd3JvdGU6DQo+ID4gPiA+IEhpIExhdXJlbnQsDQo+ID4gPiA+
IA0KPiA+ID4gPiBUaGFua3MgZm9yIHlvdSByZXBseS4NCj4gPiA+ID4gSSdkIGxpa2UgdG8gYXNr
IGZvciBhZHZpY2UgYWJvdXQgaG93IHRvIGNvbnRybCAicmVzZXQtcGluIiwNCj4gcGxlYXNlDQo+
ID4gPiA+IGNoZWNrIHRoZSBiZWxvdyBjb21tZW50cy4NCj4gPiA+ID4gDQo+ID4gPiA+IE9uIFR1
ZSwgMjAyNC0wMi0yMCBhdCAwNTowMSArMDIwMCwgTGF1cmVudCBQaW5jaGFydCB3cm90ZToNCj4g
PiA+ID4gPiAgIA0KPiA+ID4gPiA+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGlj
ayBsaW5rcyBvciBvcGVuDQo+IGF0dGFjaG1lbnRzDQo+ID4gPiB1bnRpbA0KPiA+ID4gPiA+IHlv
dSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRlbnQuDQo+ID4gPiA+ID4gIEhp
IFpoaSwNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBPbiBUdWUsIEZlYiAyMCwgMjAyNCBhdCAwMjox
MjoyNkFNICswMDAwLCBaaGkgTWFvICjmr5vmmbopIHdyb3RlOg0KPiA+ID4gPiA+ID4gT24gVHVl
LCAyMDI0LTAyLTA2IGF0IDIwOjQ1ICswMjAwLCBMYXVyZW50IFBpbmNoYXJ0IHdyb3RlOg0KPiA+
ID4gPiA+ID4gPiBPbiBTdW4sIEZlYiAwNCwgMjAyNCBhdCAwMjoxNTozOFBNICswODAwLCBaaGkg
TWFvIHdyb3RlOg0KPiA+ID4gPiA+ID4gPiA+IEFkZCBhIFY0TDIgc3ViLWRldmljZSBkcml2ZXIg
Zm9yIEdhbGF4eWNvcmUgR0MwOEEzDQo+IGltYWdlDQo+ID4gPiA+ID4gc2Vuc29yLg0KPiA+ID4g
PiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogWmhpIE1hbyA8emhpLm1h
b0BtZWRpYXRlay5jb20+DQo+ID4gPiA+ID4gPiA+ID4gLS0tDQo+ID4gPiA+ID4gPiA+ID4gIGRy
aXZlcnMvbWVkaWEvaTJjL0tjb25maWcgIHwgICAxMCArDQo+ID4gPiA+ID4gPiA+ID4gIGRyaXZl
cnMvbWVkaWEvaTJjL01ha2VmaWxlIHwgICAgMSArDQo+ID4gPiA+ID4gPiA+ID4gIGRyaXZlcnMv
bWVkaWEvaTJjL2djMDhhMy5jIHwgMTQ0OA0KPiA+ID4gPiA+ICsrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKw0KPiA+ID4gPiA+ID4gPiA+ICAzIGZpbGVzIGNoYW5nZWQsIDE0NTkg
aW5zZXJ0aW9ucygrKQ0KPiA+ID4gPiA+ID4gPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVy
cy9tZWRpYS9pMmMvZ2MwOGEzLmMNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBbc25pcF0NCj4gPiA+
ID4gPiANCj4gPiA+ID4gPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tZWRpYS9pMmMvZ2Mw
OGEzLmMNCj4gPiA+ID4gPiBiL2RyaXZlcnMvbWVkaWEvaTJjL2djMDhhMy5jDQo+ID4gPiA+ID4g
PiA+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gPiA+ID4gPiA+ID4gPiBpbmRleCAwMDAwMDAw
MDAwMDAuLjNmYzdmZmZiODE1Yw0KPiA+ID4gPiA+ID4gPiA+IC0tLSAvZGV2L251bGwNCj4gPiA+
ID4gPiA+ID4gPiArKysgYi9kcml2ZXJzL21lZGlhL2kyYy9nYzA4YTMuYw0KPiA+ID4gPiA+ID4g
PiA+IEBAIC0wLDAgKzEsMTQ0OCBAQA0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IFtzbmlwXQ0KPiA+
ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiA+ICtzdGF0aWMgaW50IGdjMDhhM19wb3dlcl9vbihzdHJ1
Y3QgZGV2aWNlICpkZXYpDQo+ID4gPiA+ID4gPiA+ID4gK3sNCj4gPiA+ID4gPiA+ID4gPiArc3Ry
dWN0IGkyY19jbGllbnQgKmNsaWVudCA9IHRvX2kyY19jbGllbnQoZGV2KTsNCj4gPiA+ID4gPiA+
ID4gPiArc3RydWN0IHY0bDJfc3ViZGV2ICpzZCA9IGkyY19nZXRfY2xpZW50ZGF0YShjbGllbnQp
Ow0KPiA+ID4gPiA+ID4gPiA+ICtzdHJ1Y3QgZ2MwOGEzICpnYzA4YTMgPSB0b19nYzA4YTMoc2Qp
Ow0KPiA+ID4gPiA+ID4gPiA+ICtpbnQgcmV0Ow0KPiA+ID4gPiA+ID4gPiA+ICsNCj4gPiA+ID4g
PiA+ID4gPiArcmV0ID0NCj4gPiA+IHJlZ3VsYXRvcl9idWxrX2VuYWJsZShBUlJBWV9TSVpFKGdj
MDhhM19zdXBwbHlfbmFtZSksDQo+ID4gPiA+ID4gPiA+ID4gKyAgICBnYzA4YTMtPnN1cHBsaWVz
KTsNCj4gPiA+ID4gPiA+ID4gPiAraWYgKHJldCA8IDApIHsNCj4gPiA+ID4gPiA+ID4gPiArZGV2
X2VycihnYzA4YTMtPmRldiwgImZhaWxlZCB0byBlbmFibGUgcmVndWxhdG9yczoNCj4gJWRcbiIs
DQo+ID4gPiA+ID4gcmV0KTsNCj4gPiA+ID4gPiA+ID4gPiArcmV0dXJuIHJldDsNCj4gPiA+ID4g
PiA+ID4gPiArfQ0KPiA+ID4gPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiA+ID4gPiArcmV0ID0gY2xr
X3ByZXBhcmVfZW5hYmxlKGdjMDhhMy0+eGNsayk7DQo+ID4gPiA+ID4gPiA+ID4gK2lmIChyZXQg
PCAwKSB7DQo+ID4gPiA+ID4gPiA+ID4gK3JlZ3VsYXRvcl9idWxrX2Rpc2FibGUoQVJSQVlfU0la
RShnYzA4YTNfc3VwcGx5X25hbWUpLA0KPiA+ID4gPiA+ID4gPiA+ICsgICAgICAgZ2MwOGEzLT5z
dXBwbGllcyk7DQo+ID4gPiA+ID4gPiA+ID4gK2Rldl9lcnIoZ2MwOGEzLT5kZXYsICJjbGsgcHJl
cGFyZSBlbmFibGUgZmFpbGVkXG4iKTsNCj4gPiA+ID4gPiA+ID4gPiArcmV0dXJuIHJldDsNCj4g
PiA+ID4gPiA+ID4gPiArfQ0KPiA+ID4gPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiA+ID4gPiArdXNs
ZWVwX3JhbmdlKEdDMDhBM19NSU5fU0xFRVBfVVMsDQo+IEdDMDhBM19NQVhfU0xFRVBfVVMpOw0K
PiA+ID4gPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiA+ID4gPiArZ3Bpb2Rfc2V0X3ZhbHVlX2NhbnNs
ZWVwKGdjMDhhMy0+cmVzZXRfZ3BpbywgMSk7DQo+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+
IEFyZSB5b3UgYXNzZXJ0aW5nIHJlc2V0IHdoZW4gcG93ZXJpbmcgb24gPyBUaGF0IHNvdW5kcw0K
PiB3cm9uZywNCj4gPiA+IHlvdQ0KPiA+ID4gPiA+IHNob3VsZA0KPiA+ID4gPiA+ID4gPiBkZS1h
c3NlcnQgcmVzZXQgaGVyZSAoYW5kIGFjcXVpcmUgdGhlIHJlc2V0IGdwaW8gaW4NCj4gcHJvYmUo
KQ0KPiA+ID4gd2l0aA0KPiA+ID4gPiA+ID4gPiBHUElPRF9PVVRfSElHSCkuIERyaXZlcnMgc2hv
dWxkIHVzZSBsb2dpY2FsIGxldmVscyBmb3INCj4gR1BJT3MsDQo+ID4gPiA+ID4gc2V0dGluZyBh
DQo+ID4gPiA+ID4gPiA+IEdQSU8gbmFtZWQgInJlc2V0IiB0byAxIHNob3VsZCBhc3NlcnQgdGhl
IHJlc2V0IHNpZ25hbCwNCj4gZXZlbg0KPiA+ID4gaWYNCj4gPiA+ID4gPiB0aGUNCj4gPiA+ID4g
PiA+ID4gcGh5c2ljYWwgc2lnbmFsIGlzIGFjdGl2ZSBsb3cuIFlvdSBtYXkgaGF2ZSB0aGUgd3Jv
bmcNCj4gPiA+IHBvbGFyaXR5IGluDQo+ID4gPiA+ID4gdGhlDQo+ID4gPiA+ID4gPiA+IGRldmlj
ZSB0cmVlLg0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IEFjY29yZGluZyB0byB0aGUgc2Vuc29y
IHBvd2VyIHNlcXVlbmNlIHNlcGMsICJyZXNldCIgcGluDQo+IHNob3VsZA0KPiA+ID4gYmUNCj4g
PiA+ID4gPiBwdWxsDQo+ID4gPiA+ID4gPiBmcm9tIGxvdyB0byBoaWdoIGFmdGVyICJkb3ZkZC9k
dmRkL2F2ZGQiIHBvd2VyIG9uLCBzbyBJDQo+IGZvbGxvdw0KPiA+ID4gdGhpcw0KPiA+ID4gPiA+
ID4gcG93ZXIgc2VxdWVjZSB0byBwdWxsICJyZXNldCIgcGluIGhpZ2ggaW4gc29mdHdhcmUgZmxv
dy4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBGcm9tIGEgaGFyZHdhcmUgcG9pbnQgb2YgdmlldyB0
aGF0J3MgcmlnaHQsIGJ1dCB0aGUgTGludXgNCj4ga2VybmVsDQo+ID4gPiA+ID4gaGFuZGxlcw0K
PiA+ID4gPiA+IGxvZ2ljYWwgbGV2ZWwgb2YgR1BJT3MuIElmIGEgR1BJTyBpcyBuYW1lZCAicmVz
ZXQiLCBpdCBpcw0KPiA+ID4gZXhwZWN0ZWQNCj4gPiA+ID4gPiB0aGF0DQo+ID4gPiA+ID4gY2Fs
bGluZw0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IGdwaW9kX3NldF92YWx1ZV9jYW5zbGVlcChnYzA4
YTMtPnJlc2V0X2dwaW8sIDEpOw0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IHdpbGwgImFzc2VydCIg
dGhlIHJlc2V0IHNpZ25hbCwgc2V0dGluZyBpdCB0byBhIGxvZ2ljYWwNCj4gInJlc2V0ID0NCj4g
PiA+ID4gPiB0cnVlIg0KPiA+ID4gPiA+IGxldmVsLiBUaGlzIG1hcHMgdG8gdGhlIGhhcmR3YXJl
IDBWIG91dHB1dCBsZXZlbCwgYXMgdGhlDQo+IHNpZ25hbA0KPiA+ID4gaXMNCj4gPiA+ID4gPiBh
Y3RpdmUtbG93LiBUbyBhY2hpZXZlIHRoaXMsIGRlZmluZSB0aGUgcmVzZXQgR1BJTyBhcyBhY3Rp
dmUNCj4gbG93DQo+ID4gPiBpbg0KPiA+ID4gPiA+IERULA0KPiA+ID4gPiA+IGFuZCB0aGUgR1BJ
TyBmcmFtZXdvcmsgd2lsbCBpbnZlcnQgdGhlIHNpZ25hbCBmb3IgeW91LiBZb3UNCj4gc2hvdWxk
DQo+ID4gPiA+ID4gdGhlbg0KPiA+ID4gPiA+IGNhbGwNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBn
cGlvZF9zZXRfdmFsdWVfY2Fuc2xlZXAoZ2MwOGEzLT5yZXNldF9ncGlvLCAxKTsNCj4gPiA+ID4g
PiANCj4gPiA+ID4gPiBpbiB0aGUgZHJpdmVyIHdoZW4geW91IHdhbnQgdG8gYXNzZXJ0IHJlc2V0
IChzZXQgaXQgdG8gMFYpLA0KPiBhbmQNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBncGlvZF9zZXRf
dmFsdWVfY2Fuc2xlZXAoZ2MwOGEzLT5yZXNldF9ncGlvLCAwKTsNCj4gPiA+ID4gPiANCj4gPiA+
ID4gPiB3aGVuIHlvdSB3YW50IHRvIGRlYXNzZXJ0IGl0IChzZXQgaXQgdG8gMy4zViwgb3Igd2hh
dGV2ZXIgdGhlDQo+IEkvTw0KPiA+ID4gPiA+IHZvbHRhZ2UgZm9yIHRoZSBzaWduYWwgaXMpLg0K
PiA+ID4gPiA+IA0KPiA+ID4gPiA+IFRoaXMgd2F5IGFsbCBkcml2ZXIgdXNlIGxvZ2ljYWwgc3Rh
dGVzLCBhbmQgdGhlIGludmVyc2lvbiBpcw0KPiA+ID4gaGFuZGxlZA0KPiA+ID4gPiA+IGluDQo+
ID4gPiA+ID4gRFQuDQo+ID4gPiA+ID4gDQo+ID4gPiA+IA0KPiA+ID4gPiBTZW5zb3IgcG93ZXIg
c2VxdWVuY2UgYXMgYmVsb3c6DQo+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAtLS0tLS0t
LS0tLS0tLS0tLS0NCj4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAgfCB8IHwNCj4gPiA+ID4g
ICAgICAgICAgICAgICAgICAgICAgfCB8IHwgDQo+ID4gPiA+IGR2ZGQvYXZkZC9kb3ZkZCAgLS0t
LS0tLS0NCj4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC0tLS0tLS0tLQ0K
PiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8DQo+ID4gPiA+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHwNCj4gPiA+ID4gcmVzZXQtcGluICAgICAgICAtLS0tLS0t
LS0tLS0tDQo+ID4gPiA+IA0KPiA+ID4gPiBJbiBvcmRlciB0byBtYXRjaCB0aGlzIHBvd2VyIHNl
cXVlY2UsICJyZXNldC1waW4iIGNvbnRybCBmbG93DQo+IGlzDQo+ID4gPiBiZWxvdzoNCj4gPiA+
ID4gMS4gY29uZmlnIHRoZSAicmVzZXQtcGluIiBpcyAiYWN0aXZlLWhpZ2giIGluIERUUzoNCj4g
PiA+ID4gICAgIHJlc2V0LWdwaW9zID0gPCZwaW8gMTkgR1BJT19BQ1RJVkVfSElHSD47DQo+ID4g
PiA+IA0KPiA+ID4gPiAyLiBpbWFnZSBzZW5zb3IgZHJpdmVyIHByb2JlIGZ1bmN0aW9uOg0KPiA+
ID4gPiBnYzA4YTMtPnJlc2V0X2dwaW8gPSBkZXZtX2dwaW9kX2dldChkZXYsICJyZXNldCIsDQo+
ID4gPiA+IEdQSU9EX09VVF9MT1cpOyAgLy9pbml0ICJyZXNldC1waW4iIGlzIGxvdw0KPiA+ID4g
PiANCj4gPiA+ID4gMy4gaW1hZ2Ugc2Vuc29yIGRyaXZlciBwb3dlcl9vbiBmdW5jdGlvbjoNCj4g
PiA+ID4gZ3Bpb2Rfc2V0X3ZhbHVlX2NhbnNsZWVwKGdjMDhhMy0+cmVzZXRfZ3BpbywgMSk7IC8v
cHVsbCAicmVzZXQtDQo+IHBpbiINCj4gPiA+ID4gaGlnaCANCj4gPiA+ID4gDQo+ID4gPiA+IHNv
LCB0aGUgZXhwZWN0IHN0YXRlIG9mICJyZXNldC1waW4iIGlzIGZyb20gbG93IHRvIGhpZ2guDQo+
ID4gPiA+IElmIEkgYW0gd3JvbmcsIHBsZWFzZSBjb3JyZWN0IG1lLg0KPiA+ID4gDQo+ID4gPiAN
Cj4gPiA+IEZyb20gRG9jdW1lbnRhdGlvbi9kcml2ZXItYXBpL2dwaW8vY29uc3VtZXIucnN0Og0K
PiA+ID4gDQo+ID4gPiBBcyBhIGNvbnN1bWVyIHNob3VsZCBub3QgaGF2ZSB0byBjYXJlIGFib3V0
IHRoZSBwaHlzaWNhbCBsaW5lDQo+ID4gPiBsZXZlbCwgYWxsIG9mIHRoZSBncGlvZF9zZXRfdmFs
dWVfeHh4KCkgb3INCj4gPiA+IGdwaW9kX3NldF9hcnJheV92YWx1ZV94eHgoKSBmdW5jdGlvbnMg
b3BlcmF0ZSB3aXRoIHRoZSAqbG9naWNhbCoNCj4gPiA+IHZhbHVlLiBXaXRoIHRoaXMgdGhleSB0
YWtlIHRoZSBhY3RpdmUgbG93IHByb3BlcnR5IGludG8gYWNjb3VudC4NCj4gPiA+IFRoaXMgbWVh
bnMgdGhhdCB0aGV5IGNoZWNrIHdoZXRoZXIgdGhlIEdQSU8gaXMgY29uZmlndXJlZCB0byBiZQ0K
PiA+ID4gYWN0aXZlIGxvdywgYW5kIGlmIHNvLCB0aGV5IG1hbmlwdWxhdGUgdGhlIHBhc3NlZCB2
YWx1ZSBiZWZvcmUNCj4gdGhlDQo+ID4gPiBwaHlzaWNhbCBsaW5lIGxldmVsIGlzIGRyaXZlbi4N
Cj4gPiA+IA0KPiA+ID4gSS5lLiB3aGVuIHlvdSB3YW50IHRvIGVuYWJsZSByZXNldCwgeW91IHNl
dCB0aGUgdmFsdWUgdG8gMSBpbiB0aGUNCj4gPiA+IGRyaXZlci4gSQ0KPiA+ID4gdGhpbmsgeW91
J3JlIG5vdyBzZXR0aW5nIHRoZSB2YWx1ZSB0byAwIGluIHRoYXQgY2FzZS4gVGhlDQo+IG9wcG9z
aXRlDQo+ID4gPiBmb3INCj4gPiA+IGRpc2FibGluZyBpdCBvZiBjb3Vyc2UuDQo+ID4gPiANCj4g
PiBBZnRlciBjaGVja2luZyAiRG9jdW1lbnRhdGlvbi9kcml2ZXItYXBpL2dwaW8vY29uc3VtZXIu
cnN0IjoNCj4gPiBUbyBzdW1tYXJpemU6Og0KPiA+ICAgRnVuY3Rpb24gKGV4YW1wbGUpICAgICAg
ICAgICAgICAgICBsaW5lDQo+IHByb3BlcnR5ICAgICAgICAgIHBoeXNpY2FsDQo+ID4gbGluZQ0K
PiA+IC4uLg0KPiA+ICAgZ3Bpb2Rfc2V0X3ZhbHVlKGRlc2MsIDEpOyAgICAgICAgICBkZWZhdWx0
IChhY3RpdmUgaGlnaCkgIGhpZ2gNCj4gPiAgIGdwaW9kX3NldF92YWx1ZShkZXNjLCAwKTsgICAg
ICAgICAgYWN0aXZlIGxvdyAgICAgICAgICAgICBoaWdoDQo+ID4gLi4uDQo+ID4gDQo+ID4gDQo+
ID4gRnJvbSBteSB1bmRlcnN0YW5kaW5nLCBpdCBzZWVtcyB0aGF0ICJyZXNldC1waW4iIGlzIHVz
aW5nIHRoZQ0KPiA+IGZvbGxvd2luZyhhY3RpdmVfaGlnaCkgY2FzZSBpbiBjdXJyZW50IGNvZGU6
IA0KPiA+ICJncGlvZF9zZXRfdmFsdWUoZGVzYywgMSk7ICAgICAgICAgIGRlZmF1bHQgKGFjdGl2
ZSBoaWdoKSAgaGlnaCIgDQo+ID4gDQo+ID4gRG8geW91IG1lYW4sIHdlIHNob3VsZCB1c2UgdGhl
ICJhY3RpdmVfbG93IiBjYXNlOg0KPiA+ICJncGlvZF9zZXRfdmFsdWUoZGVzYywgMCk7ICAgICAg
ICAgIGFjdGl2ZSBsb3cgICAgICAgICAgICAgaGlnaCINCj4gPiBDb2RlIHNob3VsZCBiZSBjaGFu
Z2VkIGFzIGJlbG93Og0KPiA+IDEuIGNvbmZpZyB0aGUgInJlc2V0LXBpbiIgaXMgImFjdGl2ZS1s
b3ciIGluIERUUzoNCj4gPiAgICAtIHJlc2V0LWdwaW9zID0gPCZwaW8gMTkgR1BJT19BQ1RJVkVf
TE9XPg0KPiA+IDIuIGltYWdlIHNlbnNvciBkcml2ZXIgcG93ZXJfb24gZnVuY3Rpb246DQo+ID4g
ICAgLSBncGlvZF9zZXRfdmFsdWVfY2Fuc2xlZXAoZ2MwOGEzLT5yZXNldF9ncGlvLCAwKTsgLy9w
dWxsIGhpZ2ggDQo+ID4gSXMgdGhhdCBzbz8NCj4gDQo+IENvcnJlY3QuDQo+IA0KZml4ZWQgaW4g
cGF0Y2g6djYNCg0KPiAtLSANCj4gUmVnYXJkcywNCj4gDQo+IFNha2FyaSBBaWx1cw0K

