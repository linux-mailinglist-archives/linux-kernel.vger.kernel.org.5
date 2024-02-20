Return-Path: <linux-kernel+bounces-72360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE48485B26C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 06:46:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 974A82838EB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 05:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0B657339;
	Tue, 20 Feb 2024 05:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="OmSo5Tb/";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="MU/NeoLh"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B65482D1;
	Tue, 20 Feb 2024 05:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708407969; cv=fail; b=b5GCVJpjTv69w4+khIcLCPLinbu92JKr+O5WfVffMelEhjPw7WbVgJ1s34GeZo/hR5xS/HczdsmwF08HzQ6w/jzUAX/6QqSbsD04EPJsn0Cjvgrdp3O+I5FOxYv9NYxCUhxIwyjr5SsF4ryv52GB+kkWhdx8TUJH0MLf10C3010=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708407969; c=relaxed/simple;
	bh=By+xJlkSqAYlPmiy1dVL+ush9+5QXdIRuSOfaxbpgow=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZRIuvW07R/V0bH9oY30nnxAqpChpmjqjqat8gKgKyzeqwrMXruclXq8CF/ukGc4KaXNYO8bq2iMrHvWoiHWddSzE4vERSOcLTuXl2yi6aosk5rUzJy82ZKKSPB+WGQL/yh4l6FCHiMGgppr5Y+X4XYT84elNN/2MPKm8tcCP9mM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=OmSo5Tb/; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=MU/NeoLh; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 52e5c05ccfb311ee9e680517dc993faa-20240220
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=By+xJlkSqAYlPmiy1dVL+ush9+5QXdIRuSOfaxbpgow=;
	b=OmSo5Tb/y0No2wdwvo12rRfgXecd1btPq4oFH+LYC8d45JcDq+snY44HVp5Hhtqb9tcVSFxW4+eKgxmzLBlJZ00iV89zy8rnSuoMCgthXsKpI0gBW0Jpwo4Ot95Ubn13VP89/ESlGuTqPp5JLrkMs/CUIeLO2WIZdAJFU1Iy618=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:262e9791-9524-4b96-90ba-ebc24968f2fe,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6f543d0,CLOUDID:278ffbfe-c16b-4159-a099-3b9d0558e447,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 52e5c05ccfb311ee9e680517dc993faa-20240220
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
	(envelope-from <zhi.mao@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 210544968; Tue, 20 Feb 2024 13:45:59 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 20 Feb 2024 13:45:57 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 20 Feb 2024 13:45:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MiTMKRZLWkWih/Kkfj61qIXB4QuidnAbCDrAN4pDPDNWp0nz6YXkhzkTXBDsCcw1o6Im14k9jNRdaSXaKHT5nEROr6sfh2r0jnQieVTVJ5qPI/b5AwwLPDI67K+pSOrvggQolMmyMJV2of+RLEM4OozUFWrs4GQk+2+e9BxS91ug0SFUDgAApIYLEFEaVog9Y1CO1k/ZR+8NrNWchn188t65lcymx7UmfyaXrC/bxFcOKcnZdGQZN+XPfTk1bx88CuVmc+cQo8pQ1levm1gIKD4Bw8UtJFQorHQWE8BjqD3NYxdTn9iE/uto8pSa9kK1As3NRsuomLwCn9N+4hesgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=By+xJlkSqAYlPmiy1dVL+ush9+5QXdIRuSOfaxbpgow=;
 b=QmvrSejDrVz8OeN+Yeah3PElcQjOrHBIak4LXwgHyVsEYlRpN3TKMAPA2Z8c2fAQHmen2CpA3hlXSp0WaOGUIAHZX7Te8y9lDus1M+xvXbKdjVgqsEZO1P9OZ5BveS/2E2ZwGTTjQzHCRcfYWqk9ZeEsjacAnN9j6VNf87nbdo2i3Nm3AttVB3O3gZJ7YbryFqcNG7w7WF4BhnZ4aXbk3Z0ZzGaHw/gXUzWAY5Lx0kJfx14pPaXQtjESAbQ9dLF6XgapkkAJfPDyuojpJ/vi7CX+3NyDmXXTdY4jI4I9XjvZAtguIaYR421BhpkiF03bJvMkSMQGrolojzePYkMuhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=By+xJlkSqAYlPmiy1dVL+ush9+5QXdIRuSOfaxbpgow=;
 b=MU/NeoLhp1lrwYvCzBokE81hOPmyxfCtkM4qGWMgkXsiui9jGO1Tk/fse/sMOtRevpWU/NEc8D5OgCMzxpfvoXGaIu2hFUIkTqWEqvWNC5b3n2FBxPFYmZ2QYvk5urmWwPuKaw31joZICfcL6DfJNR01bfPpQap7QO2liVrfBy0=
Received: from TYZPR03MB5566.apcprd03.prod.outlook.com (2603:1096:400:53::7)
 by TYSPR03MB7642.apcprd03.prod.outlook.com (2603:1096:400:42c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Tue, 20 Feb
 2024 05:45:55 +0000
Received: from TYZPR03MB5566.apcprd03.prod.outlook.com
 ([fe80::c435:bad8:87ad:994c]) by TYZPR03MB5566.apcprd03.prod.outlook.com
 ([fe80::c435:bad8:87ad:994c%5]) with mapi id 15.20.7292.036; Tue, 20 Feb 2024
 05:45:55 +0000
From: =?utf-8?B?WmhpIE1hbyAo5q+b5pm6KQ==?= <zhi.mao@mediatek.com>
To: "laurent.pinchart@ideasonboard.com" <laurent.pinchart@ideasonboard.com>
CC: "heiko@sntech.de" <heiko@sntech.de>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
	"yunkec@chromium.org" <yunkec@chromium.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"dan.scally@ideasonboard.com" <dan.scally@ideasonboard.com>,
	"gerald.loacker@wolfvision.net" <gerald.loacker@wolfvision.net>,
	=?utf-8?B?U2hlbmduYW4gV2FuZyAo546L5Zyj55S3KQ==?=
	<shengnan.wang@mediatek.com>, "hdegoede@redhat.com" <hdegoede@redhat.com>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>,
	"andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
	=?utf-8?B?WWF5YSBDaGFuZyAo5by16ZuF5riFKQ==?= <Yaya.Chang@mediatek.com>,
	"mchehab@kernel.org" <mchehab@kernel.org>, "jacopo.mondi@ideasonboard.com"
	<jacopo.mondi@ideasonboard.com>, "jernej.skrabec@gmail.com"
	<jernej.skrabec@gmail.com>, "bingbu.cao@intel.com" <bingbu.cao@intel.com>,
	"sakari.ailus@linux.intel.com" <sakari.ailus@linux.intel.com>,
	"tomi.valkeinen@ideasonboard.com" <tomi.valkeinen@ideasonboard.com>,
	"10572168@qq.com" <10572168@qq.com>, Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "macromorgan@hotmail.com"
	<macromorgan@hotmail.com>
Subject: Re: [PATCH v4 2/2] media: i2c: Add GC08A3 image sensor driver
Thread-Topic: [PATCH v4 2/2] media: i2c: Add GC08A3 image sensor driver
Thread-Index: AQHaVzH+Ve+4uX+wTUqBqQq2qHHPDrD9qvsAgBTrHQCAAA2ZAIAALgyA
Date: Tue, 20 Feb 2024 05:45:54 +0000
Message-ID: <115698c0c549e747026cc8841a3bd571533f8e6f.camel@mediatek.com>
References: <20240204061538.2105-1-zhi.mao@mediatek.com>
	 <20240204061538.2105-3-zhi.mao@mediatek.com>
	 <20240206184542.GE2827@pendragon.ideasonboard.com>
	 <598f62bbb55157eec1e23dd1dbc307fea3851b21.camel@mediatek.com>
	 <20240220030104.GF20376@pendragon.ideasonboard.com>
In-Reply-To: <20240220030104.GF20376@pendragon.ideasonboard.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB5566:EE_|TYSPR03MB7642:EE_
x-ms-office365-filtering-correlation-id: 0988b782-1017-4d0d-8687-08dc31d73494
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tudvUHSPahyb9SKy6SUWvT2v+O+XcCwU9Wx9dnSxdsTKK/0S+37RweTlMHJe6XeR+AfMJH27IPbO1+FlG8i82cpefAi6i29Pq77X6LR+9QHWAFq+BCKXQyYhsYPsuUAdIJF1+EIeKPOa13CqsAfkHvUeBeEt7yjYTk+XmOe4vECqflXlg2+CUmOSFeEMMBz5Z4T2KrMN/0CfEVR/9nkfUBE3qpRk6wPtOAaoXC6AdIHYfYX7vWq0BiYY2CPhnIFj6W53da5pCXvRdjXyjdRl0DTf4j2Zp6VDm2BAG7MB1i8qswjQMd0x5phnbf/yaR+W76ePNRzac71jdfjaSDi3cHye3oJgRlrFE6F+C6kK2KACSOptpszmWtzgKjVxDRX2qmvNTJeyDchYcDmfsJ3/3FazuRF0m9pRs3v27xlD9AjS9n6TTOK/Iafitx319DrBf7r+SlDXh/gbgc2r5NJ+iH+JaPHEdppBG1KfqPfn5eze0ZUIf5QJpm0JGkFVr/ZsjzVoohygt/qLApFn71RNY8utS1kQk7TLlpJVc5lF+EJ/m3+5MSk2TFpMeLKyE1zImuMFELIPVhfS1nIBN+OWevNC1KNKo7sekxHAxcu9xAditl1uAkhDOuf0CRUMnHy2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB5566.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230273577357003)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UENKK0xqU2JCSVA5UTFqZWk5bWVLT3BWaGIzM3V0aGFkaGExMUZoQ2V0YU9p?=
 =?utf-8?B?RzdWUmEvS3VnSGZnR0xSUFZYUnp5OWlIa2dya2tETlg0SmMrVW5ta0loUnh6?=
 =?utf-8?B?RFNwdVFZNDdRdHJIaVhUWGpBZHp4QW5UbS9SUFRpVFhPbUY5d0M1a29TQUNQ?=
 =?utf-8?B?eGdZeGNHc3NyWEVXWCtlNElvZ3Z6azNPdEJJU2tLYXlxdG5JVmVoWS9jNkRO?=
 =?utf-8?B?Qm4rai8zQVZJMitmampaOVZLWTdPMk1HWFpnZ1hHL1A2T1g0Z1grU0NhaTQ1?=
 =?utf-8?B?UXJXZ2ZJU1h5SVM1R0lxR1F5VVJnSHBUUERpb09FbHBoeTYvT0FYdEt6RXR0?=
 =?utf-8?B?REFhK3FmaS9VRVErUDZFSlVSTG45WmJlSk5xQkJqS3djbk4zbVRiRVAyeVVm?=
 =?utf-8?B?NWFIc3JFTGJFY3MxcGRnYXdIbjZTM1ZsL0t3WDliRmtZenkzNDZGWDh3a1RN?=
 =?utf-8?B?bFlOWFFWNk5rZkFyQ2JUZlE3YVhtSE1ub1Z4c003YlpIWHY3WWlTR0tGQ1pq?=
 =?utf-8?B?MzFTSS91c2RjUnIyeWZPRkdCY0dwazNwN253bXZDTlpPQkp4QVVXYVVKMnZI?=
 =?utf-8?B?NGp0VHdhei9WQ1BQNGhJYUZncExSamVFYjIzME5XUmxCNkxzVldwZk1BVE54?=
 =?utf-8?B?UzYwRGdRM0hRaU9MR0VsMnNWYm8zZ3FTUEdxYXcrL1QrRng5eTgrRU1hTUxu?=
 =?utf-8?B?TG1OdjRRSjNhVXBvWkd2YzcySGlScTFEY05TWWZNSEoyRm1oSWkyaFZDTDNK?=
 =?utf-8?B?VVJ5VVBXRFlRTzhETnQwMXJ0QkRuc2wrd3JKTythSCtpcmowNEtnLzJPMm5m?=
 =?utf-8?B?bXJlbHFwRG1pOU55TTl6VUdMU0RDOFBVRGdaOUNvbVhGcFRtcXBwNjNMVGtG?=
 =?utf-8?B?WDZRK2dhVnlwOWJYQ1RFRjJ2ZFh0M3dwYzRJNC9ueEpSVUhUYm8vZC85TU90?=
 =?utf-8?B?R3hvc2NiSzBxNU5pRFRnNE1yaTJOWElUZGQwNndjemFYRmR0emJaMkVBTStM?=
 =?utf-8?B?Q0gwTlFXZlVGVVdYNzhoWXRZYzgwV2ovMXRTS1BvWTA5dVo2Wm0vc2ZPMUM5?=
 =?utf-8?B?WXJXOHMyNC9sM0dnRHZtMnM3MEgxYUczNHplb0MzVFZLL3FzdHNXNDVTVWQ0?=
 =?utf-8?B?ek44dTd3WWx3V1k4MHRFU24wUytSYVR0bE11UjNRcGJXZ2Z2VVVBckVQTkF2?=
 =?utf-8?B?L2svZXg4VHhjU0NwTFUraVBjRUpmRzIreTc4WDQxa0pucnpqUlFGZzUvbC82?=
 =?utf-8?B?MmMvSng4amFIMExZaWpJd2R2aUN0MlZTNExyUFZBQVVqWS9yVWhNM1JzM055?=
 =?utf-8?B?WFVaaVNxTk1lRFZOQ2N5T0V6Y2RzWEdqL29OYTYrYmFuMDl3UjJSN0VURWpL?=
 =?utf-8?B?ckE3aHhiOEdaZDdsMVNqczl0ZEpPMHJBRzgzTWhBZUN0WU04RHk2WnluYTJq?=
 =?utf-8?B?bHlmT2JjOVNjQXNTSjlWd2xPVGZQMlB4cWkzbzJNY3g2RTZ1M3JXc2l1YXJy?=
 =?utf-8?B?MDVCeHFzMlREaytTajRieWtxcDQ1R3ZsMzVkZUZoZ1ZxaDRlelN6ZkcvUUw1?=
 =?utf-8?B?MWd4NU9sZFUrRjh3VjhTRnM3QlI5M2tqMmQ1UnVBQ3FzM2VjdWdPWVhwRFFw?=
 =?utf-8?B?bE5PaGdiSnA5eUhzR2phR0tydkFjaUhXRW8xOHJlY2N2YkU1Y0VEWmZDUFI2?=
 =?utf-8?B?OVA3V0VpbG5ZUmd1enFKMWhHb1RhTU42UHZaeTRmbmlQa3I5OW13UTdMWDBW?=
 =?utf-8?B?a2pGaEVLS3RhQW9oSDFXSzAwOWVmRjBCN25aL0FjUjdMcjR2WElmcXJuT1VR?=
 =?utf-8?B?UkljYlI3VnN1U05FZU8wL1dyaUFNZ0VxWnJadVdPTzM1K2xWT0lnR3hMT2lM?=
 =?utf-8?B?UHJpOThVRUNjc1lteWU2clFhcmFqemN3SzlPR1lsYmRTaTRxZFVsM1BjYjlX?=
 =?utf-8?B?RnQvSlRENEd5QnJacDMxaU9XNWcrVW9Ya0R4MzRmZHRmK1QreTRaRjlPRUxF?=
 =?utf-8?B?SHIySUF0UzhaekZkVmVHUS9GVnlwNGV5SFkzd0tFdkFJUmtESWtxVk5GUS8x?=
 =?utf-8?B?ZTI3NHp4c01NVkNpOVY1R0JWam1wbXJaYnlYbWRxendlS2EzQytuZWtsRHVw?=
 =?utf-8?B?YmtQVGtMVE5IS2t0OTZrWjhwWEpnbGFFWlprU203a0NHK1hoYXhsV0JlMkM0?=
 =?utf-8?B?UkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DA9F560F80C7D14E8A61F05D2167EA7A@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB5566.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0988b782-1017-4d0d-8687-08dc31d73494
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2024 05:45:54.9420
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vKxKUikMnKGhqrTJFlhPno+Hfu5BQ1S2p20yOM2Hrt4Y21fU+xp21x3ooQahY+X2EKbSMGxuWbSC6MkfaCvlpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB7642

SGkgTGF1cmVudCwNCg0KVGhhbmtzIGZvciB5b3UgcmVwbHkuDQpJJ2QgbGlrZSB0byBhc2sgZm9y
IGFkdmljZSBhYm91dCBob3cgdG8gY29udHJsICJyZXNldC1waW4iLCBwbGVhc2UNCmNoZWNrIHRo
ZSBiZWxvdyBjb21tZW50cy4NCg0KT24gVHVlLCAyMDI0LTAyLTIwIGF0IDA1OjAxICswMjAwLCBM
YXVyZW50IFBpbmNoYXJ0IHdyb3RlOg0KPiAgCSANCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2Ug
ZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUg
dmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUgY29udGVudC4NCj4gIEhpIFpoaSwNCj4gDQo+IE9u
IFR1ZSwgRmViIDIwLCAyMDI0IGF0IDAyOjEyOjI2QU0gKzAwMDAsIFpoaSBNYW8gKOavm+aZuikg
d3JvdGU6DQo+ID4gT24gVHVlLCAyMDI0LTAyLTA2IGF0IDIwOjQ1ICswMjAwLCBMYXVyZW50IFBp
bmNoYXJ0IHdyb3RlOg0KPiA+ID4gT24gU3VuLCBGZWIgMDQsIDIwMjQgYXQgMDI6MTU6MzhQTSAr
MDgwMCwgWmhpIE1hbyB3cm90ZToNCj4gPiA+ID4gQWRkIGEgVjRMMiBzdWItZGV2aWNlIGRyaXZl
ciBmb3IgR2FsYXh5Y29yZSBHQzA4QTMgaW1hZ2UNCj4gc2Vuc29yLg0KPiA+ID4gPg0KPiA+ID4g
PiBTaWduZWQtb2ZmLWJ5OiBaaGkgTWFvIDx6aGkubWFvQG1lZGlhdGVrLmNvbT4NCj4gPiA+ID4g
LS0tDQo+ID4gPiA+ICBkcml2ZXJzL21lZGlhL2kyYy9LY29uZmlnICB8ICAgMTAgKw0KPiA+ID4g
PiAgZHJpdmVycy9tZWRpYS9pMmMvTWFrZWZpbGUgfCAgICAxICsNCj4gPiA+ID4gIGRyaXZlcnMv
bWVkaWEvaTJjL2djMDhhMy5jIHwgMTQ0OA0KPiArKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysNCj4gPiA+ID4gIDMgZmlsZXMgY2hhbmdlZCwgMTQ1OSBpbnNlcnRpb25zKCspDQo+
ID4gPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9tZWRpYS9pMmMvZ2MwOGEzLmMNCj4g
DQo+IFtzbmlwXQ0KPiANCj4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWVkaWEvaTJjL2dj
MDhhMy5jDQo+IGIvZHJpdmVycy9tZWRpYS9pMmMvZ2MwOGEzLmMNCj4gPiA+ID4gbmV3IGZpbGUg
bW9kZSAxMDA2NDQNCj4gPiA+ID4gaW5kZXggMDAwMDAwMDAwMDAwLi4zZmM3ZmZmYjgxNWMNCj4g
PiA+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ID4gPiArKysgYi9kcml2ZXJzL21lZGlhL2kyYy9nYzA4
YTMuYw0KPiA+ID4gPiBAQCAtMCwwICsxLDE0NDggQEANCj4gDQo+IFtzbmlwXQ0KPiANCj4gPiA+
ID4gK3N0YXRpYyBpbnQgZ2MwOGEzX3Bvd2VyX29uKHN0cnVjdCBkZXZpY2UgKmRldikNCj4gPiA+
ID4gK3sNCj4gPiA+ID4gK3N0cnVjdCBpMmNfY2xpZW50ICpjbGllbnQgPSB0b19pMmNfY2xpZW50
KGRldik7DQo+ID4gPiA+ICtzdHJ1Y3QgdjRsMl9zdWJkZXYgKnNkID0gaTJjX2dldF9jbGllbnRk
YXRhKGNsaWVudCk7DQo+ID4gPiA+ICtzdHJ1Y3QgZ2MwOGEzICpnYzA4YTMgPSB0b19nYzA4YTMo
c2QpOw0KPiA+ID4gPiAraW50IHJldDsNCj4gPiA+ID4gKw0KPiA+ID4gPiArcmV0ID0gcmVndWxh
dG9yX2J1bGtfZW5hYmxlKEFSUkFZX1NJWkUoZ2MwOGEzX3N1cHBseV9uYW1lKSwNCj4gPiA+ID4g
KyAgICBnYzA4YTMtPnN1cHBsaWVzKTsNCj4gPiA+ID4gK2lmIChyZXQgPCAwKSB7DQo+ID4gPiA+
ICtkZXZfZXJyKGdjMDhhMy0+ZGV2LCAiZmFpbGVkIHRvIGVuYWJsZSByZWd1bGF0b3JzOiAlZFxu
IiwNCj4gcmV0KTsNCj4gPiA+ID4gK3JldHVybiByZXQ7DQo+ID4gPiA+ICt9DQo+ID4gPiA+ICsN
Cj4gPiA+ID4gK3JldCA9IGNsa19wcmVwYXJlX2VuYWJsZShnYzA4YTMtPnhjbGspOw0KPiA+ID4g
PiAraWYgKHJldCA8IDApIHsNCj4gPiA+ID4gK3JlZ3VsYXRvcl9idWxrX2Rpc2FibGUoQVJSQVlf
U0laRShnYzA4YTNfc3VwcGx5X25hbWUpLA0KPiA+ID4gPiArICAgICAgIGdjMDhhMy0+c3VwcGxp
ZXMpOw0KPiA+ID4gPiArZGV2X2VycihnYzA4YTMtPmRldiwgImNsayBwcmVwYXJlIGVuYWJsZSBm
YWlsZWRcbiIpOw0KPiA+ID4gPiArcmV0dXJuIHJldDsNCj4gPiA+ID4gK30NCj4gPiA+ID4gKw0K
PiA+ID4gPiArdXNsZWVwX3JhbmdlKEdDMDhBM19NSU5fU0xFRVBfVVMsIEdDMDhBM19NQVhfU0xF
RVBfVVMpOw0KPiA+ID4gPiArDQo+ID4gPiA+ICtncGlvZF9zZXRfdmFsdWVfY2Fuc2xlZXAoZ2Mw
OGEzLT5yZXNldF9ncGlvLCAxKTsNCj4gPiA+DQo+ID4gPiBBcmUgeW91IGFzc2VydGluZyByZXNl
dCB3aGVuIHBvd2VyaW5nIG9uID8gVGhhdCBzb3VuZHMgd3JvbmcsIHlvdQ0KPiBzaG91bGQNCj4g
PiA+IGRlLWFzc2VydCByZXNldCBoZXJlIChhbmQgYWNxdWlyZSB0aGUgcmVzZXQgZ3BpbyBpbiBw
cm9iZSgpIHdpdGgNCj4gPiA+IEdQSU9EX09VVF9ISUdIKS4gRHJpdmVycyBzaG91bGQgdXNlIGxv
Z2ljYWwgbGV2ZWxzIGZvciBHUElPcywNCj4gc2V0dGluZyBhDQo+ID4gPiBHUElPIG5hbWVkICJy
ZXNldCIgdG8gMSBzaG91bGQgYXNzZXJ0IHRoZSByZXNldCBzaWduYWwsIGV2ZW4gaWYNCj4gdGhl
DQo+ID4gPiBwaHlzaWNhbCBzaWduYWwgaXMgYWN0aXZlIGxvdy4gWW91IG1heSBoYXZlIHRoZSB3
cm9uZyBwb2xhcml0eSBpbg0KPiB0aGUNCj4gPiA+IGRldmljZSB0cmVlLg0KPiA+DQo+ID4gQWNj
b3JkaW5nIHRvIHRoZSBzZW5zb3IgcG93ZXIgc2VxdWVuY2Ugc2VwYywgInJlc2V0IiBwaW4gc2hv
dWxkIGJlDQo+IHB1bGwNCj4gPiBmcm9tIGxvdyB0byBoaWdoIGFmdGVyICJkb3ZkZC9kdmRkL2F2
ZGQiIHBvd2VyIG9uLCBzbyBJIGZvbGxvdyB0aGlzDQo+ID4gcG93ZXIgc2VxdWVjZSB0byBwdWxs
ICJyZXNldCIgcGluIGhpZ2ggaW4gc29mdHdhcmUgZmxvdy4NCj4gDQo+IEZyb20gYSBoYXJkd2Fy
ZSBwb2ludCBvZiB2aWV3IHRoYXQncyByaWdodCwgYnV0IHRoZSBMaW51eCBrZXJuZWwNCj4gaGFu
ZGxlcw0KPiBsb2dpY2FsIGxldmVsIG9mIEdQSU9zLiBJZiBhIEdQSU8gaXMgbmFtZWQgInJlc2V0
IiwgaXQgaXMgZXhwZWN0ZWQNCj4gdGhhdA0KPiBjYWxsaW5nDQo+IA0KPiBncGlvZF9zZXRfdmFs
dWVfY2Fuc2xlZXAoZ2MwOGEzLT5yZXNldF9ncGlvLCAxKTsNCj4gDQo+IHdpbGwgImFzc2VydCIg
dGhlIHJlc2V0IHNpZ25hbCwgc2V0dGluZyBpdCB0byBhIGxvZ2ljYWwgInJlc2V0ID0NCj4gdHJ1
ZSINCj4gbGV2ZWwuIFRoaXMgbWFwcyB0byB0aGUgaGFyZHdhcmUgMFYgb3V0cHV0IGxldmVsLCBh
cyB0aGUgc2lnbmFsIGlzDQo+IGFjdGl2ZS1sb3cuIFRvIGFjaGlldmUgdGhpcywgZGVmaW5lIHRo
ZSByZXNldCBHUElPIGFzIGFjdGl2ZSBsb3cgaW4NCj4gRFQsDQo+IGFuZCB0aGUgR1BJTyBmcmFt
ZXdvcmsgd2lsbCBpbnZlcnQgdGhlIHNpZ25hbCBmb3IgeW91LiBZb3Ugc2hvdWxkDQo+IHRoZW4N
Cj4gY2FsbA0KPiANCj4gZ3Bpb2Rfc2V0X3ZhbHVlX2NhbnNsZWVwKGdjMDhhMy0+cmVzZXRfZ3Bp
bywgMSk7DQo+IA0KPiBpbiB0aGUgZHJpdmVyIHdoZW4geW91IHdhbnQgdG8gYXNzZXJ0IHJlc2V0
IChzZXQgaXQgdG8gMFYpLCBhbmQNCj4gDQo+IGdwaW9kX3NldF92YWx1ZV9jYW5zbGVlcChnYzA4
YTMtPnJlc2V0X2dwaW8sIDApOw0KPiANCj4gd2hlbiB5b3Ugd2FudCB0byBkZWFzc2VydCBpdCAo
c2V0IGl0IHRvIDMuM1YsIG9yIHdoYXRldmVyIHRoZSBJL08NCj4gdm9sdGFnZSBmb3IgdGhlIHNp
Z25hbCBpcykuDQo+IA0KPiBUaGlzIHdheSBhbGwgZHJpdmVyIHVzZSBsb2dpY2FsIHN0YXRlcywg
YW5kIHRoZSBpbnZlcnNpb24gaXMgaGFuZGxlZA0KPiBpbg0KPiBEVC4NCj4gDQoNClNlbnNvciBw
b3dlciBzZXF1ZW5jZSBhcyBiZWxvdzoNCiAgICAgICAgICAgICAgICAgICAgICAtLS0tLS0tLS0t
LS0tLS0tLS0NCiAgICAgICAgICAgICAgICAgICAgIHwgfCB8DQogICAgICAgICAgICAgICAgICAg
ICB8IHwgfCANCmR2ZGQvYXZkZC9kb3ZkZCAgLS0tLS0tLS0NCiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAtLS0tLS0tLS0NCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwNCiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwNCnJlc2V0LXBpbiAgICAgICAgLS0tLS0tLS0t
LS0tLQ0KDQpJbiBvcmRlciB0byBtYXRjaCB0aGlzIHBvd2VyIHNlcXVlY2UsICJyZXNldC1waW4i
IGNvbnRybCBmbG93IGlzIGJlbG93Og0KMS4gY29uZmlnIHRoZSAicmVzZXQtcGluIiBpcyAiYWN0
aXZlLWhpZ2giIGluIERUUzoNCiAgICByZXNldC1ncGlvcyA9IDwmcGlvIDE5IEdQSU9fQUNUSVZF
X0hJR0g+Ow0KDQoyLiBpbWFnZSBzZW5zb3IgZHJpdmVyIHByb2JlIGZ1bmN0aW9uOg0KZ2MwOGEz
LT5yZXNldF9ncGlvID0gZGV2bV9ncGlvZF9nZXQoZGV2LCAicmVzZXQiLA0KR1BJT0RfT1VUX0xP
Vyk7ICAvL2luaXQgInJlc2V0LXBpbiIgaXMgbG93DQoNCjMuIGltYWdlIHNlbnNvciBkcml2ZXIg
cG93ZXJfb24gZnVuY3Rpb246DQpncGlvZF9zZXRfdmFsdWVfY2Fuc2xlZXAoZ2MwOGEzLT5yZXNl
dF9ncGlvLCAxKTsgLy9wdWxsICJyZXNldC1waW4iDQpoaWdoIA0KDQpzbywgdGhlIGV4cGVjdCBz
dGF0ZSBvZiAicmVzZXQtcGluIiBpcyBmcm9tIGxvdyB0byBoaWdoLg0KSWYgSSBhbSB3cm9uZywg
cGxlYXNlIGNvcnJlY3QgbWUuDQoNCj4gPiA+ID4gK3VzbGVlcF9yYW5nZShHQzA4QTNfTUlOX1NM
RUVQX1VTLCBHQzA4QTNfTUFYX1NMRUVQX1VTKTsNCj4gPiA+ID4gKw0KPiA+ID4gPiArcmV0dXJu
IDA7DQo+ID4gPiA+ICt9DQo+IA0KPiBbc25pcF0NCj4gDQo+IC0tIA0KPiBSZWdhcmRzLA0KPiAN
Cj4gTGF1cmVudCBQaW5jaGFydA0K

