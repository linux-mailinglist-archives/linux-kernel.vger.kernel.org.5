Return-Path: <linux-kernel+bounces-139646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F84D8A05BD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 04:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2E461C221CE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 02:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2781069944;
	Thu, 11 Apr 2024 02:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="KN86aZT1";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="idr30Yur"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A86604DD;
	Thu, 11 Apr 2024 02:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712801068; cv=fail; b=EBR42vYDv8+0zuvf6JJkH5+8JWqhD/LM8H958DgRN7U15bX2AmfCd3i2G+sVfEBaO5sOZiMg86uJBzw9L/Q/c3TWzVXRFHCqcb5MINKiLtom3TJPqNXmbjkE9u8jJJNoit+co5F42xiMNy3L0W+ZOzLZkfaTEpMEkrgw8OcKSrs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712801068; c=relaxed/simple;
	bh=WY0eGef1gVSLcQlfNQ5McHR1wJYYXJK9xKnK/YHWPZA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uFCUTHQgVe9049lMz97elijPPZZzBwAeOvJIxiQoK7sMJtw0HmId7+Vr922ABEC21UVzfF/JV+JchAWHPYAkXbm3oW2I/+FFCwmx5GBXNcqc5qd2vFGUindr5a2NMGyGF56gn/aDXbk6i2cWn0Jkf8m9MR8uWtEO5K78V+mtVIM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=KN86aZT1; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=idr30Yur; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: d10de844f7a711ee935d6952f98a51a9-20240411
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=WY0eGef1gVSLcQlfNQ5McHR1wJYYXJK9xKnK/YHWPZA=;
	b=KN86aZT1Xb9Jc/Hzm1QixeEDSWNR/dzpXz6XT8Y0A99fQtoch6p/iJkbDvn8YVg29F9XpMffsS5VUIOQWtyxpDGaxb5zQzv+BbFsu3kqmvs7LM/PjmQj2GjQRnhL2C2SuiJxTFA7UjYeaCeIBSr/qjCcuLsvTrQSDRNVRZSTTmo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:3aa8a961-8c5e-455a-8a6d-45b588e6a599,IP:0,U
	RL:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:6f543d0,CLOUDID:808b8882-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: d10de844f7a711ee935d6952f98a51a9-20240411
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
	(envelope-from <zhi.mao@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 907897119; Thu, 11 Apr 2024 10:04:23 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 11 Apr 2024 10:04:20 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 11 Apr 2024 10:04:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cbOntaHiFlW53GFhgZ0ullcM+7cQOO+mGOgh33i7BdlvIzgKahtoHi6QXHU8dSbU5XM9dEMxDloKs48lgTNod7F4eLhdJ5DJ1XWE6FJkTcXHFQPFEzYsKaQxiHrBJz8aYlEpb/ZLualsb/j2Q84ajwZmRFRzNhUmCw20hagQ+0HyWXPBMlWyWP1Y+EsTUZp34UyTnvS+usMsht7XEgG9GuuVkiZYug5dVW7cxe4vvLwD2QAKeEurATven9wf/LRjQEIw8avi02eqhymUTpET4OmzsQmDoWMmlHNrOa0KeflI5StI+wHyaqRvaGhTghX0kR4xfhg1/HaB1AWh/lf+Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WY0eGef1gVSLcQlfNQ5McHR1wJYYXJK9xKnK/YHWPZA=;
 b=B/kAjzeEjsJsFupCLC+5qNP67YV2l6jhGzPSs/8MpN008oyEioMFCZEko8SQEaw0E0ZpBnxDbyV2m6/5UCPVEHYvOmWE13mMtEsz1Cl8ZoQOx2HtwuDV8Ura92dBci6AzyYZRBWvibfPKu2Fvy2QZyo3sptLqJ3QnpQ77a87xOIuKwahSlp5aflPZQdBtvggMTcXc96b1z5PEvVXKwGg/gWoiDzsVq//Z/VQxnkvZWnNnOnP3f3hukTwr6uysj5zpas+AK+4Wl0pWKi2o88Msq7SL5sz5gaROfuTLqfKQG1pu0L2OeHuvglnJhggnIWNDl4rqEso7kqbBvbyEmdcwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WY0eGef1gVSLcQlfNQ5McHR1wJYYXJK9xKnK/YHWPZA=;
 b=idr30YurKQ1H8iPdXgLs6qVaucFRorpGy57WvvFUa8WaSBia+czX5J5yPqAfWzJYc9H2cGJDQVwYPEnuCfW4zJ1ZSzoL0VSBmju56MMbMtqA3NlM9xsp1K/V0t6Qy2iMIq+koN0Znqs8sjZnJ2Igcg6Qw0eorI9fw19THQbwYDA=
Received: from TYZPR03MB5566.apcprd03.prod.outlook.com (2603:1096:400:53::7)
 by TYZPR03MB8509.apcprd03.prod.outlook.com (2603:1096:405:65::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 11 Apr
 2024 02:04:17 +0000
Received: from TYZPR03MB5566.apcprd03.prod.outlook.com
 ([fe80::6b1b:cceb:5ca3:2907]) by TYZPR03MB5566.apcprd03.prod.outlook.com
 ([fe80::6b1b:cceb:5ca3:2907%5]) with mapi id 15.20.7409.053; Thu, 11 Apr 2024
 02:04:17 +0000
From: =?utf-8?B?WmhpIE1hbyAo5q+b5pm6KQ==?= <zhi.mao@mediatek.com>
To: "conor@kernel.org" <conor@kernel.org>
CC: "heiko@sntech.de" <heiko@sntech.de>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "laurent.pinchart+renesas@ideasonboard.com"
	<laurent.pinchart+renesas@ideasonboard.com>, "yunkec@chromium.org"
	<yunkec@chromium.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "linux-media@vger.kernel.org"
	<linux-media@vger.kernel.org>, "hdegoede@redhat.com" <hdegoede@redhat.com>,
	"bingbu.cao@intel.com" <bingbu.cao@intel.com>, "paul.elder@ideasonboard.com"
	<paul.elder@ideasonboard.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "andy.shevchenko@gmail.com"
	<andy.shevchenko@gmail.com>, "mchehab@kernel.org" <mchehab@kernel.org>,
	=?utf-8?B?U2hlbmduYW4gV2FuZyAo546L5Zyj55S3KQ==?=
	<shengnan.wang@mediatek.com>, =?utf-8?B?WWF5YSBDaGFuZyAo5by16ZuF5riFKQ==?=
	<Yaya.Chang@mediatek.com>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	"alain.volmat@foss.st.com" <alain.volmat@foss.st.com>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "sakari.ailus@linux.intel.com"
	<sakari.ailus@linux.intel.com>, "robh@kernel.org" <robh@kernel.org>,
	"hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>,
	"tomi.valkeinen@ideasonboard.com" <tomi.valkeinen@ideasonboard.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "mehdi.djait@bootlin.com"
	<mehdi.djait@bootlin.com>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "10572168@qq.com"
	<10572168@qq.com>
Subject: Re: [PATCH 1/2] media: dt-bindings: i2c: add Giantec GT97xx VCM
 driver
Thread-Topic: [PATCH 1/2] media: dt-bindings: i2c: add Giantec GT97xx VCM
 driver
Thread-Index: AQHaizOVmNciTxukzECyMSrvfdPK77FhXaKAgAD1EwA=
Date: Thu, 11 Apr 2024 02:04:17 +0000
Message-ID: <5317cb9b01cf5668837ad7ccdcb9eb72b95d98d6.camel@mediatek.com>
References: <20240410104002.1197-1-zhi.mao@mediatek.com>
	 <20240410104002.1197-2-zhi.mao@mediatek.com>
	 <20240410-rice-fringe-4ae992217a2f@spud>
In-Reply-To: <20240410-rice-fringe-4ae992217a2f@spud>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB5566:EE_|TYZPR03MB8509:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZJnH0ZgN4WdcRgwJQwTQp/hoXlGnBm4ikXcFha6tYm7q4BUOT7iIbGquVNfKAlahYE75Y2eY7xb5PY3kxQEvFhu4oyiHW2ELCXwpxL0f63GSFa2CsdoWEMK3fB0LZcySN2of+0taxNkrwxh+Hotb3kDxilu74LugDIPD9DOxG9CG++KZ3VM/XtNjIJzFn8UbPAde/KLRqt7IBR/OLfWgFu1H3kIGDwrxURSzfbLPsj4d80rs38UcKmvTYHGDOR6vb4NP2FJTZw4zLCiQ+j3b3lv7qSbJMvuQ/XzcniuAerQx9D1GftsbNCBl6emp7j0UeXZCpXTjTxDZ0xTntBPz41Z1PE+SO2zDWY90OZd/CK+JEvWvF4CrRRzkkvY7W5/qmDhx443KncJiPKKjLE6wmluEBfXKI5XxQlaq//aTChzxBcdPpuCvfZYZxml/F+u7yfpRWhuIlDTzQ6yacPg9wruldLcM9MyRfEyqbA95VgnayzwU1C1aeJqIWSdGV61NImbM+72UV0DtHFb/e72Du6Zatrhn2K/ml6Iq68umHFIUu4y91OOrToohFhFsoi8PGJgpaGCDhMpHzcvCaiV6HB/8r+5/mkcKmk88VMCWMrU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB5566.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dzBRUUxMbkVaNlFuaUVDUVdTSk9vQVljQUxrcmlldjUzYWgwTFQ4WFRwL2lU?=
 =?utf-8?B?YTh4VDFXa0UvWEpnMlpJdlVSR3I2UHo0TXQvTmlRSUIya292TDdvbE9MNjkw?=
 =?utf-8?B?NVpVb0Y0SmZJaE5HYVE0eGR2UkFxOWtIczNSNFp0OGZ5dWtiOTZDNUlqWlJx?=
 =?utf-8?B?RXdPeld6YkpSRmQwb2JFblI5cjJhb01DYWhnL001UEdDdUFGd1JlT2ZaeWhM?=
 =?utf-8?B?T2xlYnVzZEJMWVNoK2E3TVFvSEVOWVd1SFpBOTdmRnRjbGFDU2RYNzdpWUZE?=
 =?utf-8?B?aEplZUZ5MERpdG9Pc3M3V1JDS25LaDltNU80bnplU1dyaHJOSlJ5eTlCSXFw?=
 =?utf-8?B?clQyQ3Q4RlYySlA2TmNJK0pMckNIZEdJMVI3aUZ6UGhwM2lmZVpnNzVIcXpT?=
 =?utf-8?B?YldDdUtOSXpkY1MyblExSW84NHk2M3ordi9PNFY2Mml0ZWovN0NGTDl5VmN3?=
 =?utf-8?B?NzZYV2RQMnZLNXlabkRpekQxR2lCWHBIQXVMUjZnZ1Jta1BSQVNkSy9taHRJ?=
 =?utf-8?B?SllSWDhPUVV2TEw5clljcUQyd2x2QnQvYURjdmFpdGxDYWRwL3hxU1lqTWZy?=
 =?utf-8?B?MWNnQzdZdnNVM2dacTJ3VDFBN0c0R0cwSUlZOWFXZkV3bmNGNmJubGdON2x3?=
 =?utf-8?B?V1FyV3A5cUZDZzMzZEJBZ1czbWJDUWs1eWxrU0xhTE1IZnRWdUV5YXp2L0ht?=
 =?utf-8?B?S2N1ZjJRSXAwc0dveGJDWVh0VXhkZXAwRVhmb2VqWEJFcWNBdDJya1ZyMGFx?=
 =?utf-8?B?L3JEenJnRzFBdDltTk1tWk93ODRGWkt1RDNoRCtwYURyTlZxOUx6ald4UHhT?=
 =?utf-8?B?SDB6NlV0N1hRZHlyWnRCVGRjRkV0dk1FTG83K2ErbEZBOUpzNUpOWTF3ZWtM?=
 =?utf-8?B?NmdFY1lRUkxxNm4wZUhmcGdrV1BYSWZOVkYzUXc3cHlCQXdTbXJzdmxwYWpC?=
 =?utf-8?B?cXNSVENDQmxsU2ZjcU1SWGZoR2U0OGsvQTg0YndhanZoRmdXUG5taVNIb0dN?=
 =?utf-8?B?Smttek04cGFjbjNUbUJPZFVBOEIweDdxcHlJQ0pyZkE5OTVhdWlVT0ZnYmc3?=
 =?utf-8?B?QUtpa25jUEpHR3Y0Q0dXVHlJaG5RRnpsNVZtVnZzcFpIcEJzQm5RYUVvb0R4?=
 =?utf-8?B?NVRpVGhFdXViWk43NE9qd2NwQUw5MWlCcVk5S3kyMmE0L3JkOWo0N1hURGtM?=
 =?utf-8?B?ZGtFNHdzNm9zVjEwY0NnWWYraUttTmQ5ZjRqTFlwaVZaSTI5bTZyQW56U1Yx?=
 =?utf-8?B?RmYyZWN2UGdHVzBLWExQQ21uc1BLajdXVlZoTDhpWGJ1SkN2b243bS9TcXda?=
 =?utf-8?B?RVhIRjFHekhheHl0MXVNMWZ2T3pSelBva3NvYVRtSXVBa1NDYzdYVHhaMW9O?=
 =?utf-8?B?VkRUeGNXYlVHcjY0UTJDd204ZlZ0aVZ1NHQ4bXAzbHNTcHJETnYwdFdXZWdo?=
 =?utf-8?B?OW4rU0l5aEI3ZUorVEtGcGlhL3RJRm9oNzRQU0tmdEtrSVgxdS9UT1FBdFNR?=
 =?utf-8?B?MGdjU2pPTkt4QitUb2l6ZlVScGtXdEhiQkEzTXRNMkZrTXpYTUduUGN0SnNx?=
 =?utf-8?B?cG9BVmcyME9HZlk4UzkrT1VCUXNZc1Y3WjdOOFV6OFhaVHpRZDFGZDhiVXUz?=
 =?utf-8?B?S1RuSTY2cklhajlCcStaK29FbGxXS1BVbFdQRmFUdGEzQ2R0N2hoM21GcFdJ?=
 =?utf-8?B?T3BsU1lvTVhwSHphNW9FaVRYckgyNkRwNlgyazJWVDJEQmxHZFViTk9XeDE3?=
 =?utf-8?B?VGkrSkYxNk1IK29zL243ZGF6U25hd3ZtQzNRT1p5RG94d2NQckNxWSsrUGth?=
 =?utf-8?B?Vm1jRit3WWNSNmdrODQ1QkcvQ1ZVbHduMjFPbHUycU94aUJTbHMwdFJJN3Zq?=
 =?utf-8?B?QTRUNjlCa29zZGtVMVFSeTJOQ3c5QitGM1pRUmJhdkJ2Wk93dlYzUnFjUGYz?=
 =?utf-8?B?a1UwRG02QklZZWUzU3JhdG5qOHZUZ0x1c0NRU1NaVVdWT0lOS1BVNHJFNnpP?=
 =?utf-8?B?MWg4SkFmc1VuL3hRMC9nemNwSEVMd0k5dXNBNDg5VFdZUUxqU2l1RFZLR2dM?=
 =?utf-8?B?UTRHaHNQVzBmVmxrbDRuRkNUZk1xQnJPMXJmODRCb3BKNldmUjJKSm1lQXVH?=
 =?utf-8?B?RlkxSWhuL281WGtRR3hmSmtuUmxjSGc5T0w2U1E5aUNBc1F3Nm1STytZZWZy?=
 =?utf-8?B?NFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F0CE0E8FB7D8304A94306B2E9BA0BF32@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB5566.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3efe85f-03b6-4691-815c-08dc59cbb1d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2024 02:04:17.6416
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I6a5h/G0jLiBic1Xe5hIr8ZW04g+TxCHnu5qf/suYI04ONQ1hLTttZ9lO+f5DurE7NYt85oUKpaIxfd3FxVLsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB8509
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--13.069300-8.000000
X-TMASE-MatchedRID: c/HXCguHooHUL3YCMmnG4uYAh37ZsBDC1kqyrcMalqWKlJ71TX9+gzv3
	/JKoTaAEwQTqbLJ40jtzXOcOrZSuYxhzK7qAlTSLvHKClHGjjr3Zph2fCfuodyG8WMGwsRk0R3R
	HPHTssNX8RUjCzTCsqGhbKaGV9QhaZndN15Svp2/J1E/nrJFED4+YVJqrrEz4kKeDAQWPwjGtJ8
	Ep5i5THRE43fgAXB3ML+LXWGdFPtoMeUy96gk4BLMjW/sniEQKXcpmQXLhhkT7efdnqtsaE/Jog
	WdYvsFrXhXt6OwHIvaRk6XtYogiatLvsKjhs0lda9+JVKonO7f6APa9i04WGCq2rl3dzGQ1i2sO
	TYAPkyX6WvSjFRHdKUFL47VjHNVH+bsSc+0J4jtU4Gyg1cbVxw==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--13.069300-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	A72B8DFE00BE61D0F5A726E5F89699D9AA964736E59AF966FD8AD9DC0FED852B2000:8

SGkgQ29ub3IsDQoNClRoYW5rcyBmb3IgeW91ciByZXZpZXcuDQoNCk9uIFdlZCwgMjAyNC0wNC0x
MCBhdCAxMjoyNyArMDEwMCwgQ29ub3IgRG9vbGV5IHdyb3RlOg0KPiA+IA0KPiA+IA0KPiBIZXks
DQo+IA0KPiBPbiBXZWQsIEFwciAxMCwgMjAyNCBhdCAwNjo0MDowMVBNICswODAwLCBaaGkgTWFv
IHdyb3RlOg0KPiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21lZGlhL2ky
Yy9naWFudGVjLGd0OTd4eC55YW1sDQo+ID4gQEAgLTAsMCArMSw5MSBAQA0KPiA+ICsjIFNQRFgt
TGljZW5zZS1JZGVudGlmaWVyOiAoR1BMLTIuMCBPUiBCU0QtMi1DbGF1c2UpDQo+ID4gKyMgQ29w
eXJpZ2h0IChjKSAyMDIwIE1lZGlhVGVrIEluYy4NCj4gPiArJVlBTUwgMS4yDQo+ID4gKy0tLQ0K
PiA+ICskaWQ6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9zY2hlbWFzL21lZGlhL2kyYy9naWFudGVj
LGd0OTd4eC55YW1sIw0KPiANCj4gRmlsZW5hbWUgcGF0Y2hpbmcgY29tcGF0aWJsZSBwbGVhc2Uu
DQo+IA0KPiANClNvcnJ5LCBJIGRvbid0IGNhdGNoIHRoaXMgcG9pbnQuIA0KQ2FuIHlvdSBleHBs
YWluIG1vcmUgZGV0YWlscz8gDQo+ID4gDQo+ID4gDQo+ID4gKw0KPiA+ICsgIGdpYW50ZWMsYWFj
LW1vZGU6DQo+ID4gKyAgICBkZXNjcmlwdGlvbjoNCj4gPiArICAgICAgSW5kaWNhdGlvbiBvZiBB
QUMgbW9kZSBzZWxlY3QuDQo+ID4gKyAgICAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZp
bml0aW9ucy91aW50MzINCj4gPiArICAgIGVudW06DQo+ID4gKyAgICAgIC0gMSAgICAjICBBQUMy
IG1vZGUob3BlcmF0aW9uIHRpbWUjIDAuNDggeCBUdmliKQ0KPiA+ICsgICAgICAtIDIgICAgIyAg
QUFDMyBtb2RlKG9wZXJhdGlvbiB0aW1lIyAwLjcwIHggVHZpYikNCj4gPiArICAgICAgLSAzICAg
ICMgIEFBQzQgbW9kZShvcGVyYXRpb24gdGltZSMgMC43NSB4IFR2aWIpDQo+ID4gKyAgICAgIC0g
NSAgICAjICBBQUM4IG1vZGUob3BlcmF0aW9uIHRpbWUjIDEuMTMgeCBUdmliKQ0KPiANCj4gSSBk
aXNsaWtlIHRoZXNlIGVudW0gYmFzZWQgcHJvcGVydGllcyBhbmQgSSB3b3VsZCByYXRoZXIgdGhp
cyBlaXRoZXINCj4gYmUNCj4gdGhlIHZhbHVlcyB0aGVtc2VsdmVzICgwLjQ4LCAwLjcwIGV0Yyku
DQo+IA0KPiA+ICsNCj4gPiArICBnaWFudGVjLGFhYy10aW1pbmc6DQo+ID4gKyAgICBkZXNjcmlw
dGlvbjoNCj4gPiArICAgICAgTnVtYmVyIG9mIEFBQyBUaW1pbmcgY291bnQgdGhhdCBjb250cm9s
bGVkIGJ5IG9uZSA2LWJpdA0KPiA+IHBlcmlvZCBvZg0KPiA+ICsgICAgICB2aWJyYXRpb24gcmVn
aXN0ZXIgQUFDVFs1OjBdLCB0aGUgdW5pdCBvZiB3aGljaCBpcyAxMDAgdXMuDQo+IA0KPiBUaGVu
IHRoZSBwcm9wZXJ0eSBzaG91bGQgYmUgaW4gYSBzdGFuZGFyZCB1bml0IG9mIHRpbWUsIG5vdCAi
cmFuZG9tIg0KPiBoZXgNCj4gbnVtYmVycyB0aGF0IGNvcnJlc3BvbmQgdG8gcmVnaXN0ZXIgdmFs
dWVzLg0KPiANCj4gPiANCj4gPiArICBnaWFudGVjLGNsb2NrLXByZXNjOg0KPiA+ICsgICAgZGVz
Y3JpcHRpb246DQo+ID4gKyAgICAgIEluZGljYXRpb24gb2YgVkNNIGludGVybmFsIGNsb2NrIGRp
dmlkaW5nIHJhdGUgc2VsZWN0LCBhcw0KPiA+IG9uZSBtdWx0aXBsZQ0KPiA+ICsgICAgICBmYWN0
b3IgdG8gY2FsY3VsYXRlIFZDTSByaW5nIHBlcmlvZGljIHRpbWUgVHZpYi4NCj4gPiArICAgICRy
ZWY6IC9zY2hlbWFzL3R5cGVzLnlhbWwjL2RlZmluaXRpb25zL3VpbnQzMg0KPiA+ICsgICAgZW51
bToNCj4gPiArICAgICAgLSAwICAgICMgIERpdmlkaW5nIFJhdGUgLSAgMg0KPiA+ICsgICAgICAt
IDEgICAgIyAgRGl2aWRpbmcgUmF0ZSAtICAxDQo+ID4gKyAgICAgIC0gMiAgICAjICBEaXZpZGlu
ZyBSYXRlIC0gIDEvMg0KPiA+ICsgICAgICAtIDMgICAgIyAgRGl2aWRpbmcgUmF0ZSAtICAxLzQN
Cj4gPiArICAgICAgLSA0ICAgICMgIERpdmlkaW5nIFJhdGUgLSAgOA0KPiA+ICsgICAgICAtIDUg
ICAgIyAgRGl2aWRpbmcgUmF0ZSAtICA0DQo+IA0KPiBTYW1lIGhlcmUsIHlvdSBzaG91bGQgbm90
IG5lZWQgdGhlc2UgY29tbWVudHMgZXhwbGFpbmluZyB0aGUgdmFsdWVzLA0KPiB1c2UNCj4gYW4g
ZW51bSB3aXRoIG1lYW5pbmdmdWwgdmFsdWVzIHBsZWFzZS4gDQo+IA0KQWJvdXQgImFhYy1tb2Rl
L2FhYy10aW1pbmcvY2xvY2stcHJlc2MiLCB3ZSB0ZXN0IHRoaXMgZHJpdmVyIHdpdGgNCmRlZmF1
bHQgc2V0dGluZ3MgYWNjcm9kaW5nIHRvIFNQRUMgYW5kIFZDTSB3b3JrcyB3ZWxsLCBzbyBJIHdp
bGwgbm90DQpleHBvcnQgdGhlc2UgcHJvcGVydHkgaW4gWU1BTCBhbmQgbGV0IGRyaXZlciB1c2Ug
ZGVmYXVsdCBzZXR0aW5ncy4NCkhvdyBkbyB5b3UgdGhpbmsgYWJvdXQgaXQ/DQogIA0KDQo+IFRo
YW5rcywNCj4gQ29ub3IuDQo+IA0KPiA+IA0KPiA+IA0K

