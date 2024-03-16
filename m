Return-Path: <linux-kernel+bounces-105044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5423F87D825
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 04:19:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE02B1F21BE8
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 03:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CFA14C6D;
	Sat, 16 Mar 2024 03:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="UznDPQxq";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="TPAuKNOs"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5695E2F2D;
	Sat, 16 Mar 2024 03:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710559147; cv=fail; b=HOYfC7C7Az2L/DWc2Ydep22zN+JZSb/yJ0hQJjql4mqA96UABSADUWMkRBLMV2sKT5Qg0FGUcnqWkOjG+4DLfsBwCUttkLe82XkK7fxd8+dvDdTt4nXVbGj8/XFhkRCWwrT+wPWyWCk9+GTdwo0of+TKJ1hMNLmLiAGS8H9hlrA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710559147; c=relaxed/simple;
	bh=ndc2i3inLbYfYB9QHMmOiBYoVKLxmLo+VnpwbBLcu9Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dxm1rhccz0v2fGC26CCCENqowTZOhF78yIkiORd0IHjO8eAtKV9lRzA/+3nkZuhLznx3NEatcyvDq7Jf8Ztu9mksxP3EQByRD9CvyAcVT3fGWWfslOLDcBcLD3bzdPYbhfFX/9i6qZkJ9nP0gX1vwVx0tTudZ+/wcb5uwVDNXiI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=UznDPQxq; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=TPAuKNOs; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: d39f39b6e34111eeb8927bc1f75efef4-20240316
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=ndc2i3inLbYfYB9QHMmOiBYoVKLxmLo+VnpwbBLcu9Q=;
	b=UznDPQxqDwyoq6tQmIAZMbJI+vdS79cVkxPdTNsU37oGAp5zYzdh+iEgeHRP2lKFus/ez0Puw4p2b6Z/Vd645bl/mUi1PVW0VJ/z0/RdKgJur/LUB9m/IAiHBxTzHy7f/a4iQuLzUzps9NZse4JVEvE64n9O89Z57lGOlnTXLVQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:59d28c2b-5adc-46ed-a5ae-bba670aab613,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:ec401085-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: d39f39b6e34111eeb8927bc1f75efef4-20240316
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
	(envelope-from <zhi.mao@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 732655418; Sat, 16 Mar 2024 11:03:55 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sat, 16 Mar 2024 11:03:54 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Sat, 16 Mar 2024 11:03:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ULes5L7BuutPi8SVsCQ9H96cgtpDAcg7FaEBfO+yNXP9e4rwZs3ADRhcHi8kxybuW0i4qqW/jY8p2RPjK8v84yGkC4EIih4xkqA4VUcdsNTCALd5mVFmtRfgRghnFmlaIzEQcIB1MwMrhqYY66rrEvNGdqCcOSqd8fSqHac/tKR23I8SHIpuqHxhFzxS15KoZ1jIKmKQhNA44kL72zYiux2f2YVGruDIgXGPo/1LWTk/BXymWiigmkwUcyF/D6+UVIBMTJdTKM8qJw+yLJWKEk0SsXQ873EOnKNls6q/JRvWZzqrESV3nw1YmV9/PHV9oDwSgH4ydiu/DHaa6ohXdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ndc2i3inLbYfYB9QHMmOiBYoVKLxmLo+VnpwbBLcu9Q=;
 b=Jg+T3+wyE2OaMu3t0ngvqv/09DxdowLxSWkTF2xQU5j1jBd3u7ZS0MgLconvqP00XSLuZTIZx6iHCtLkXiIdRt3OZO93zCsR6dRVTeOagGE9o/h3naStJGzYBJOgEJ8L8sfs2sejtLsLDyXhsSPRCwiHVRvEITx07KPBRrcjhVsBdnomvajdn0w2XTUZGJeddlZHQhTD+Ki6a99xdnFC0RFX7km0tfedbao20cHkPB4L49HAanL9b7VSfFH5W81XsbQjrJlSq2qcrN/jsoMsRRSlwQ783iS1SxI17gFneKcOfgpSf2FQZWlmzKPg1lnGMe2/8legdd6jySZMEH3aRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ndc2i3inLbYfYB9QHMmOiBYoVKLxmLo+VnpwbBLcu9Q=;
 b=TPAuKNOsKBmoNu0eyuAcYIgdCkyXH+4/6Vp4qaey9Dei3KstsA5TtWkCx1djW791aw3IfHXPRJOYCntB6tv0qIETzYPEUpBo2CA9FW+/RyOb+hgGw6EqoeZkyQeucri6dm1qzi1DJ9xfbGRgkoPxt4PU5mtv10EYkDNzVX8wiWI=
Received: from TYZPR03MB5566.apcprd03.prod.outlook.com (2603:1096:400:53::7)
 by TYZPR03MB6645.apcprd03.prod.outlook.com (2603:1096:400:1ff::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.23; Sat, 16 Mar
 2024 03:03:51 +0000
Received: from TYZPR03MB5566.apcprd03.prod.outlook.com
 ([fe80::b39a:4ac4:5bf8:88d]) by TYZPR03MB5566.apcprd03.prod.outlook.com
 ([fe80::b39a:4ac4:5bf8:88d%5]) with mapi id 15.20.7386.022; Sat, 16 Mar 2024
 03:03:51 +0000
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
	<bingbu.cao@intel.com>, Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"sakari.ailus@linux.intel.com" <sakari.ailus@linux.intel.com>,
	"10572168@qq.com" <10572168@qq.com>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"laurent.pinchart@ideasonboard.com" <laurent.pinchart@ideasonboard.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "macromorgan@hotmail.com"
	<macromorgan@hotmail.com>
Subject: Re: [PATCH 0/2] media: i2c: Add support for GC05A2 sensor
Thread-Topic: [PATCH 0/2] media: i2c: Add support for GC05A2 sensor
Thread-Index: AQHadQmvsApuHB1Ko0+9GPY4QtPLxLE1XYeAgARViQA=
Date: Sat, 16 Mar 2024 03:03:51 +0000
Message-ID: <f4512301c8514bd758eebb166bbed44f2ac65e5f.camel@mediatek.com>
References: <20240313054409.8073-1-zhi.mao@mediatek.com>
	 <CAHp75VeHVJpiaCTdQHWQocE9PFLsGhu+a2TP7VSV34i02v-ksA@mail.gmail.com>
In-Reply-To: <CAHp75VeHVJpiaCTdQHWQocE9PFLsGhu+a2TP7VSV34i02v-ksA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB5566:EE_|TYZPR03MB6645:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xBk567gmN3XelV1nSw7NsZc+3jbASpj/+KG8djYy9Y60NJD8XpnkXx9Jl9Hg4JI/CVpSm4ukHfMUJU1fc769kFUqgZFqDT/3/oZidMMMI+FV49Mlnu1LC5kuTwMiWrXFYGGhCk7yG/jyhoLhqGinULRwo6lIvPRRHDHVQ4EodW+E0KszAe1xf56e3Iv9gM/Zc2vKEhCsefjnjLQVYDl5CMuhHt2S+GLdkqjDHk7B25JLGM0erksl6W2BIlgquaBIauyUtsd8jSfwBfThdHmGaLHhUUQlqux0vqhp/fL1s3hB+xJSvpp/vz30kHR55Nj5qR4rg8Ii3hfSxuQl0qilybzom80POzuYmiH4TqJVmpM+7UJ2TKUibr6vChqeTizGXZXtvIiDcJPRWkBYL3wlMgtxg28rqAMOjfvs7cOy1WZEfLkNkP8lZEJ5+rTyzcyHr8rXKhQFArfIRX0/8ut1ZNS4IVNht30kiGnMKte2RJ7zHMrYxtyVNVCSClgy0qNSznTn5HNmkex9N+mSb0CBAW64lx5YzjEaOGh+NpswATJrMaDZeW4QCs57/qZ6l8v6DZVk639tNT+9odAAtpmcybFshAM9ZniVMGvNchgft4s=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB5566.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y0JuRFZRSGN5am9qQnk1L1NUdXJ2YlRtdHQ5NmU2UHlZMEVSd1ZRL0Z1WWF0?=
 =?utf-8?B?MFNXLzlwaUxzNVk0QmsvN3FZT1JkYmUvQnJNTk1wNGc4R3V4OU92dXZuYjdu?=
 =?utf-8?B?djMwaGxpbXBFT3VnbEtPM25UczVWWXZ3QUd2T0VyYWxYQ2t1THF3emx5Z1l6?=
 =?utf-8?B?ZnZ5SDlKZStPSlBxSXMzWWFoMzVXK3F3ZC9GQzRhWFF2YmUrcTFwWmZxbjhT?=
 =?utf-8?B?My9TL3VNdHRYSGM2eFJLd0pzS04wQnlyeEtnaGFyODR0UnZheGROd3V6V0RH?=
 =?utf-8?B?SGZHd3VteG1lZWk0L0t2aE1EOXlTQ3lZU2J1UGlncGo5eHdiWjNCQjdIT2Zv?=
 =?utf-8?B?MGxscEFjUmE0RnQwTTJGM1c4ZzQxUlVlZ2cvNlp1TlptMm4rOVRFVStUazdB?=
 =?utf-8?B?Mkc3a1hTT2FzUld5MUlIcjBFeWx3NjBKUmFzMWE4ZmJ1eEtielZTaHZxU3l5?=
 =?utf-8?B?ZjFzZzRoYlIzUTBNZFVrZTBtZHUxMksyb1VOMWxmU0N0bFRDR3k2Nzg0MjlJ?=
 =?utf-8?B?SldBaUdZOTJ2UE1oZHNLQU1BWlFtOVRnWUpEZ2drY3dwTzkzYVZkV1lPaHda?=
 =?utf-8?B?dDgrNGhBQUpXVnRpd0FzZG8zVXN3NFZnb0VzQnlCRHdGWTJTL0J5a2VBVW9P?=
 =?utf-8?B?amljandZbnVxaWNzMHdYZmN6YTdSVGVHK1NMbUhibGpkQVNmY2pKeW9EQzhV?=
 =?utf-8?B?R0hma2dJVW5NcitiRGtWeFV1ZW9UT29rU1NSekRIWEpnUWFnSzlVUXBwNzNI?=
 =?utf-8?B?a29FNFlXRll0WElmV0RxazNneE96WU1SLzBwY2NRZlhjbEorM3JSUkg3TGhq?=
 =?utf-8?B?VFdKdXJkNEpPSVpKL1ZOa2pHNWZKY2FWUnYySGFPWlZ5OUh0SENrcU9aV1Vm?=
 =?utf-8?B?SlBVSzF2OGpJWkNHSlg2Mjl1Zk42RlhIcFFwTzAvTmp3ZERuQ2hNWk4yeDVW?=
 =?utf-8?B?a2ZWM1UzTkhieG5CVFN5QkRIWVBZak8vQjB1dFdoRnhNY3gxb1MyL2pZelFp?=
 =?utf-8?B?MXloWkRzblp4NCtEZkZOVjFGS1FjMEhraVI1bFh3WTg4OXJEc0EwSUtTTG4x?=
 =?utf-8?B?bmlWVG5NUmNMU005c0RDSmc2YStlMTV4bXZyK056MnZLUTVnUFFuZitRMGdq?=
 =?utf-8?B?ZGl5SXo1L3pLSHhFalZuRUFjMjVNNERtWVdSbFJHMXhacTJkYjZJMjhITGFj?=
 =?utf-8?B?K0QzNkRybFhJQVN4T1FRNkVVVGh2a1ZkMlZwQnlLVzlXOUZNSVNCVWxneE9M?=
 =?utf-8?B?NjZEcGFrcHdnQkJ2Q3dVcUJtOXJ4SmtoVmZiOWF5Zml2MkFIOTFxMVhrTHlo?=
 =?utf-8?B?N20wUmc1M2dmQzZ3UDhLZWlwNkZCWkFRVGRLTFZJc2ZFRWcrQ0EzNDZiN1hF?=
 =?utf-8?B?TnNVcGpaK21kUjdqdjErQVNXQzV2OHBIWjhrb20vSG1BQ2VTaFJpdnpuUitW?=
 =?utf-8?B?Snl2bzlBUjQvY1E5OW9CSzBrR3FPUlZjTXFJZENvd0lIMVQ1QVRwUnh1VEtY?=
 =?utf-8?B?V0w4YytIM1lmRUZsM1k5ZWF5aFlWclVodWxoNGVRU0pMZExlMm5vZVpyNHNU?=
 =?utf-8?B?R0ZOOWVaRG9XQ1BaZGJIOFQxaUN3QjUzMlkwdDBZV0lDMm5QZlBPRXRDQjI3?=
 =?utf-8?B?ci9nQ1c4bTU5cnY3K1JSU2pubU9VYTVXSTdzRmUwK1RJMEI1TTRBWGtRcnlJ?=
 =?utf-8?B?cmJLclZsSmRDSFkxMDBWNlVLU0FlRS9XYk1KaTkyNVhNUVg0OW55djhNdDMr?=
 =?utf-8?B?bUszNWllS29ITDUvMWZkbFdod2VMZnhuTjUzN3JKcXJMVldkVzhGVk02TWhv?=
 =?utf-8?B?QUlJeEZ2Z09TLzhDMnd0TEE2cythN0JaYlR5Ym01VWNHdXVLUG9pOEw4NWVT?=
 =?utf-8?B?eHRRNy9ZTFZ4RFR1d0IrNXMzRTZSWE5xMUdvUEE1UzRiSmlPMytPdlJiN2dz?=
 =?utf-8?B?UnRhV0dTSGY0VWZESlNsdFFjOXhnY3g3eEYvNWhBSEwrYmd0ZW0vd2p4dTNR?=
 =?utf-8?B?a1NLekVFeTlIWjBDaVVRSEkwTWZHYWZua083eksxT0svUjh2RXpSZzUzLy9S?=
 =?utf-8?B?NVFyTjNOT0RoNk9RcWlPcXYvT0p6amoybDJxVDZFUEY3akR2Z2VtZVBUQVRL?=
 =?utf-8?B?UmFmd2ZVR0pmMEtKOXN4aHNzbEljU3J2Tk5OTDUrMncvNU1GMHNHOFY2NTJh?=
 =?utf-8?B?b0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CD4D6194CE89694B80457A77436090B0@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB5566.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01e9be2c-abc5-4241-2db3-08dc4565b542
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2024 03:03:51.4366
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iDoZ9u44+k0eLWbsDwUSr4mVkxFpCce4HcQ4OQ+ri5DOSTbtFPbVn8PYQ8/iF6ryPlsu/+6smfUouwWPv1sJTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB6645

SGkgQW5keSwNCg0KVGhhbmtzIGZvciB5b3VyIHJldmlldy4NCg0KDQpPbiBXZWQsIDIwMjQtMDMt
MTMgYXQgMTA6NTIgKzAyMDAsIEFuZHkgU2hldmNoZW5rbyB3cm90ZToNCj4gIAkgDQo+IEV4dGVy
bmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRz
IHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRlbnQuDQo+
ICBPbiBXZWQsIE1hciAxMywgMjAyNCBhdCA3OjU04oCvQU0gWmhpIE1hbyA8emhpLm1hb0BtZWRp
YXRlay5jb20+DQo+IHdyb3RlOg0KPiA+DQo+ID4gVGhpcyBzZXJpZXMgYWRkcyBZQU1MIERUIGJp
bmRpbmcgYW5kIFY0TDIgc3ViLWRldmljZSBkcml2ZXIgZm9yDQo+IEdhbGF4eWNvcmUncw0KPiA+
IEdDMDVBMiA1LW1lZ2FwaXhlbCAxMC1iaXQgUkFXIENNT1MgMS81IiBzZW5zb3IsIHdpdGggYW4g
TUlQSSBDU0ktMg0KPiBpbWFnZSBkYXRhDQo+ID4gaW50ZXJmYWNlIGFuZCB0aGUgSTJDIGNvbnRy
b2wgYnVzLg0KPiA+DQo+ID4gVGhlIGRyaXZlciBpcyBpbXBsZW1lbnRlZCB3aXRoIFY0TDIgZnJh
bWV3b3JrLg0KPiA+ICAtIEFzeW5jIHJlZ2lzdGVyZWQgYXMgYSBWNEwyIHN1Yi1kZXZpY2UuDQo+
ID4gIC0gQXMgdGhlIGZpcnN0IGNvbXBvbmVudCBvZiBjYW1lcmEgc3lzdGVtIGluY2x1ZGluZyBT
ZW5pbmYsIElTUA0KPiBwaXBlbGluZS4NCj4gPiAgLSBBIG1lZGlhIGVudGl0eSB0aGF0IHByb3Zp
ZGVzIG9uZSBzb3VyY2UgcGFkIGluIGNvbW1vbi4NCj4gPiAgLSBVc2VkIGluIGNhbWVyYSBmZWF0
dXJlcyBvbiBDaHJvbWVPUyBhcHBsaWNhdGlvbi4NCj4gPg0KPiA+IEFsc28gdGhpcyBkcml2ZXIg
c3VwcG9ydHMgZm9sbG93aW5nIGZlYXR1cmVzOg0KPiA+ICAtIG1hbnVhbCBleHBvc3VyZSBhbmQg
YW5hbG9nIGdhaW4gY29udHJvbCBzdXBwb3J0DQo+ID4gIC0gdmVydGljYWwgYmxhbmtpbmcgY29u
dHJvbCBzdXBwb3J0DQo+ID4gIC0gdGVzdCBwYXR0ZXJuIHN1cHBvcnQNCj4gPiAgLSBtZWRpYSBj
b250cm9sbGVyIHN1cHBvcnQNCj4gPiAgLSBydW50aW1lIFBNIHN1cHBvcnQNCj4gPiAgLSBzdXBw
b3J0IHJlc29sdXRpb246IDI1OTJ4MTk0NEAzMGZwcywgMTI4MHg3MjBANjBmcHMNCj4gDQo+IE5v
dCBldmVuIGdvaW5nIHRvIGRvIGEgdGhvcm91Z2ggcmV2aWV3IGFzIG9uZSBzaG91bGQgbGVhcm4g
b24gdGhlDQo+IHByZXZpb3VzIHJldmlld3MuIE1vc3Qgb2YgdGhlIGNvbW1lbnRzIHRoYXQgSSBo
YWQgZ2l2ZW4gdG8gYW5vdGhlcg0KPiBkcml2ZXIgc3VibWlzc2lvbiBhcmUgYXBwbGljYWJsZSBo
ZXJlLiBTbywgd2FpdGluZyBmb3IgdjIgd2l0aCBhbGwNCj4gYXBwbGljYWJsZSBiZWluZyBhZGRy
ZXNzZWQuDQo+IA0KDQpUaGUgY29tbWVudHMgYXJlIGZpeGVkIGluIHBhdGNoOnYxDQoNCmh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LW1lZGlhLzIwMjQwMzE2MDI1MjUzLjIzMDAtMS16aGku
bWFvQG1lZGlhdGVrLmNvbS8NCj4gLS0gDQo+IFdpdGggQmVzdCBSZWdhcmRzLA0KPiBBbmR5IFNo
ZXZjaGVua28NCg==

