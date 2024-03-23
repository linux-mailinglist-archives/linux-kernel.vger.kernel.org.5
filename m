Return-Path: <linux-kernel+bounces-112195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B6398876CC
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 03:59:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64719283DAC
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 02:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A56946A2;
	Sat, 23 Mar 2024 02:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="nczgUXYe";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="uPLHLA2O"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273671362;
	Sat, 23 Mar 2024 02:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711162773; cv=fail; b=VtQDq28Os2BjcE6a33t3TWntz+SdFy+knL420ZTK8yNmUQ8ckpI5TVEn01NIfr8U7HWKe4AOtQ6oOSKc+M2VVzbdCudrakibJ59UQVhmxnNLdwPJXC1lHlCW8gbXobUjo7wxWT90AWyL8eq1ZeAlbygKtxwejWd/SXkMEnvjYU4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711162773; c=relaxed/simple;
	bh=3RbGqczdB5XQ6jfmBB7St2g7YSNFwgPJ+rTGkf8I4e8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fLP0Ct/MQ7jQh55UvsHJa5dH6fS8hSnHP4g+NtftSHIuQUPpsdbwjYskNQSPO88IwKe6XsZlO/SYTyaz/PbUCl7sDbLgDxgnw9nflSrw9XUQZlXHYXfVf5Yp5F2MLdwWSWANqmmESlYB8wtujz5StLngJfXEhobpUFlPw3Wy/oM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=nczgUXYe; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=uPLHLA2O; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 59eb14d4e8c111eeb8927bc1f75efef4-20240323
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=3RbGqczdB5XQ6jfmBB7St2g7YSNFwgPJ+rTGkf8I4e8=;
	b=nczgUXYeSzmDtBveVwij3DRdJHJqsu6br7XTnqQVAE9nzS4+rIasepN7htGeBI++muYBmom+375xu9NqqMipxB4mF5cZ6i14h43ibFq7fjA4n3NLaRJnQtGpzRby2upsqxjr7BAAy6Z2FeXZRAXpvP2KbE1TT75rQ5YZXyf2IcU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:4a2c88f3-fa08-4263-80bd-d88b8d4ba8fb,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:84983900-c26b-4159-a099-3b9d0558e447,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 59eb14d4e8c111eeb8927bc1f75efef4-20240323
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
	(envelope-from <zhi.mao@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 243909474; Sat, 23 Mar 2024 10:59:22 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sat, 23 Mar 2024 10:59:21 +0800
Received: from SG2PR03CU006.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Sat, 23 Mar 2024 10:59:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A4xU/EufbGBvyxsviQPglidrA4GnocXbbqzyAOFTzBe2RWso5bQ3p97uYhJ3VtAHapm86ZqwhkwyMl74dqmoa87piwMrllzW6k4DKX/B0fizFJxPsbWXq5GqAlzCDOjfGo930uaIu9CEUtAHVIEAgZ+eY6+BPmjrPLzHdc1IVaMf2VWKVGeczxWfOTAarkTFWUxQQhGginGp4KnFduvDNdJF6yiubYdaTWWVpF6Luy45CHHmCRrCsE//psaS1jQXGY/1V81ghSgpet+EPOddh2LzsK40iT0lAgxiM+s4JGnkt6i75vvYuIW9aimgCo86NhEpOd3HK0q6vOWV4IKNiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3RbGqczdB5XQ6jfmBB7St2g7YSNFwgPJ+rTGkf8I4e8=;
 b=fj7RzmKn7LLYAaXGOK8NmpbENXvT1UZjifAT84W+K4KQfhApzdsR8Ef7FCUlfxF5S8xY6wnx55PRn3hzqfE069SnWQli9eKDbBR9LDIUEY2OgmQOYclV0WhxxrRMvo8+7ADCUqtbKiHrbSbklPbYAq2R8KmNJciolNdXX26R2f3JdfBNn+jf0MWbylD8Hj0J77lJiZYwXLvz0VkXyr1JYgSFC0LEm2rDXLRo2coQXNksrDbx4C7cysXGAvdxH6ESa9m9t0JIWvSCK0XTFuZepSVozzk5X4SWCH/xy4tmMaf51efQo/FA+qGu4RmpVbdkwbZhWh5hyZSE6TspK3LDdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3RbGqczdB5XQ6jfmBB7St2g7YSNFwgPJ+rTGkf8I4e8=;
 b=uPLHLA2OFvI3QRR7bSDqPEl/jtNW3MHdy/57nhQi22fvy53Mai1lWAd15jXJ6nkO4GfMRlgiQVwF/BTZBD8qChqb7GCMPYVk72625kHQ40E84hu7YsJqyjOpnvBQ7BnVS4Rr3XtS3X3PMzqs6tB9yL7OCHU5LMGu4mp+S4/juRI=
Received: from TYZPR03MB5566.apcprd03.prod.outlook.com (2603:1096:400:53::7)
 by TY0PR03MB8297.apcprd03.prod.outlook.com (2603:1096:405:11::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.35; Sat, 23 Mar
 2024 02:59:18 +0000
Received: from TYZPR03MB5566.apcprd03.prod.outlook.com
 ([fe80::b39a:4ac4:5bf8:88d]) by TYZPR03MB5566.apcprd03.prod.outlook.com
 ([fe80::b39a:4ac4:5bf8:88d%5]) with mapi id 15.20.7409.023; Sat, 23 Mar 2024
 02:59:18 +0000
From: =?utf-8?B?WmhpIE1hbyAo5q+b5pm6KQ==?= <zhi.mao@mediatek.com>
To: "sakari.ailus@linux.intel.com" <sakari.ailus@linux.intel.com>
CC: "heiko@sntech.de" <heiko@sntech.de>, "gerald.loacker@wolfvision.net"
	<gerald.loacker@wolfvision.net>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
	"yunkec@chromium.org" <yunkec@chromium.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "dan.scally@ideasonboard.com"
	<dan.scally@ideasonboard.com>, "linux-media@vger.kernel.org"
	<linux-media@vger.kernel.org>,
	=?utf-8?B?U2hlbmduYW4gV2FuZyAo546L5Zyj55S3KQ==?=
	<shengnan.wang@mediatek.com>, "hdegoede@redhat.com" <hdegoede@redhat.com>,
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>,
	"andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
	=?utf-8?B?WWF5YSBDaGFuZyAo5by16ZuF5riFKQ==?= <Yaya.Chang@mediatek.com>,
	"mchehab@kernel.org" <mchehab@kernel.org>, "jacopo.mondi@ideasonboard.com"
	<jacopo.mondi@ideasonboard.com>, "jernej.skrabec@gmail.com"
	<jernej.skrabec@gmail.com>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "bingbu.cao@intel.com"
	<bingbu.cao@intel.com>, Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "10572168@qq.com" <10572168@qq.com>,
	"hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>,
	"tomi.valkeinen@ideasonboard.com" <tomi.valkeinen@ideasonboard.com>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "laurent.pinchart@ideasonboard.com"
	<laurent.pinchart@ideasonboard.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "macromorgan@hotmail.com"
	<macromorgan@hotmail.com>
Subject: Re: [PATCH v1 2/2] media: i2c: Add GC05A2 image sensor driver
Thread-Topic: [PATCH v1 2/2] media: i2c: Add GC05A2 image sensor driver
Thread-Index: AQHad00+IqkBATFIkUCM1xUJwrGHMrFAQfSAgARroYA=
Date: Sat, 23 Mar 2024 02:59:18 +0000
Message-ID: <8a6bbbdde57283b5bf8cab0ea7ecb0f201d437e7.camel@mediatek.com>
References: <20240316025253.2300-1-zhi.mao@mediatek.com>
	 <20240316025253.2300-3-zhi.mao@mediatek.com>
	 <ZfqQPTgqzOw7tATK@kekkonen.localdomain>
In-Reply-To: <ZfqQPTgqzOw7tATK@kekkonen.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB5566:EE_|TY0PR03MB8297:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fd9sqxeOwrkptuiFb6iUzuzVoQwLZvbqXTh8UpABznnbaV6qF/+9rPNDIoH9/9C1oRM+siG/E707GcZ7MeeUVFWJiPg+EAPlmvDXHxtCMGaKICPQbhkWtj2Ic5TcCM+LvmR53pKMA63yPDlHiDvu1HV3S8i27EXNuNdLA1mKGMJVdQdRhfU1IqE3pbbHTtuLmt8SUjjsToF96O3NWNiycWG10qkLkRE7+qcK8jr+Gj/p7lCkb7mhRdTbYi4PlUzu0tXT2sg3pMBgsLHAwZwHiEKdo9Tcc51MzSvovjOf2OPtHY1yxnRiv1pLV0rWAVRhMRD9f4qJQ+bWUt3Rkc56BeNwz9oUt6s/irescm2gATeZRZmEkdB8Y/of1NAGc+LI0dV3gmb1O79+6LcE/wPtA231APgk1O9T4tT5XHdSyrEfkQCd82Whd+9NwDT8JjtTySmeIpF4bruxvYkGs77yeJIfy/pQavL4u/pSRXBwBWdtiOz3a93uoqCm3VYXp3+SYTSEbC1NFi4JQE50FlaWWg1PSYamyZKdfKQchxJIYh263+hTASKHCi4HkW+te/7YTOlUdiq9rl1YV7i7ldJnhU2lF3FLFnwOldQmLnHUVZj9s5SgwmvOja3eiUQcI8iL
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB5566.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eC9sYkNDV2VMWXM3OEtIMFNjN3I2dTR0UTZuZERveVpnM3o4ZGpBMjB5a2Q1?=
 =?utf-8?B?RFIxazdqRDZ4QTFmWjFOTFQ4azExUFlPN1Y5cituUkVlalUzV1l5bkVJWTZY?=
 =?utf-8?B?aTVrRjhYaGpPVXJPYnFzZS81aWRaUVZCMGtaaEt6VWp6cGdrUXVmQkFVUzlK?=
 =?utf-8?B?QXhSVitHN2FZOGE1UzNSRHhwNmxQc0hHNGVocGphM1l5WUJSUEZ6MjJYUnk5?=
 =?utf-8?B?TVJvVUxmKy83Z1BtVEVZTTdBakoxVlVHbG5lY3VDN0EybytiRzYxWE9CeTdW?=
 =?utf-8?B?QzFyeVNCbUN3b1M0NzBDR1JuM0NKeTVLbkpSYXJSanpvTi9TTE9ZaDhHZEhF?=
 =?utf-8?B?UGlMYlZCOGJEeFhNdGdYWFZhMnd1VHFwREkzWEFMV21GQTBQamhWYkR4V2tl?=
 =?utf-8?B?cDdMdEFya25KdHRFbEc0QmxoUmJrV1FJbWVJQ2c1UGNVNXBBOVNJeHFqaTVw?=
 =?utf-8?B?MERvVCtZcXdnTGJpamlhdGkwdzF3MU5sdWhXcSsvOTJGNnp6N0VDUHpTb0pK?=
 =?utf-8?B?Ni9CN1QrdWxrc2QvT0dhOWhLeFpiVmo2alRsWkJQK2ZGd0pHT1NTbGUydXFu?=
 =?utf-8?B?WUlSNEtVWnBCeU5yVjU1d0NNK050OUZjb2FEeDFxenFUY0gzU204cmJiUXVl?=
 =?utf-8?B?L0pzMldRQzJLRnd5S3lsNWRVNDJIZEJobDB0bFpieklwOG5VcDMrWERZUWpp?=
 =?utf-8?B?ZjIzL2xXYlA5aHpLcXRMUFRrS3pacXFzeEp4ZFlaOWcySStVbjB0MVgvWk12?=
 =?utf-8?B?RHZSamlNaFRlZXY2N1lQTHF6V3ZLdHFHdGJGWlUrcHZ0MmxjS205T0YzUCtU?=
 =?utf-8?B?V0JKbUM2MVNoYWFwN05hNFhYUmpaYTV6aDNxaS9NWG5NbmNRQm82L3o0WVJn?=
 =?utf-8?B?dUlHNlVRTDMxU2dhRTk3ME5UbDg2L0VrY0FtU3hMRkFMNk1TWUxTREU2bGg1?=
 =?utf-8?B?T2I1cWUzSHFwRkErcndad3NDR3o3NkJJbGNaYmlYNnExVWdSemUvK05WdlVV?=
 =?utf-8?B?RXE0eG1FMUJNbnBCV3Q3VW9XMTFENk81OCtkQXVnY3p1R1RzdGhNMG15OWRV?=
 =?utf-8?B?dk9hTThNc0V2TTk0dHRROWpFdk1xQytzWGl5eCtHcU9SUS9YcGRTKzM0S3dY?=
 =?utf-8?B?QnNYNGhMNlBJRnVCbFFXckdzMitOL0QzL0t2dm1DL0dtRlRPNW94eGhwMlZK?=
 =?utf-8?B?SlkwOTFsa1c4U2FCcWhkSU14QVNEeXJoOVRYaWp2Q1paQk5QV2tBL3JOSTNM?=
 =?utf-8?B?RDdwM0pCYmw4T3VKTnplYTh6azY4Sm9SVnlPeHV1clVQMjEzNlRkNnl1K2cv?=
 =?utf-8?B?a2MvbHBzTDBuNFpmRHJyTVA0YzY2dHJnQUF2NjBaZDVRN1JPV3dTdUdFQ2V5?=
 =?utf-8?B?c1BPQ1lsSXp0eVRUaEp6SDM4L3UxWk9qYWI2VVRxWHJGVHpFa3oyckRLd2xV?=
 =?utf-8?B?VC9hV3ZmMTFDbGc1UmthR0NqL3BobDM4RzJLRXdrdDJsVCtiaXBQZzFFTzVJ?=
 =?utf-8?B?U2RuNU44Yk8rZEU0VXFIMHRZTVlxbm1sdTQzc2p5WHloT1FnYUk2TkZ3VEJY?=
 =?utf-8?B?R0dIc1c3WHI0RmZ3YVFpYjFpSTZtQzBEaHdNOEdlMmNVcEo5VHNRQmdvYytV?=
 =?utf-8?B?aTBSWDR5Z2ZaUlMyV0NiTURSRGovTW8zZnY1aGJmTFIwZnRFY2liMlF0VzI3?=
 =?utf-8?B?QjFSTHdnZDdOVjlmQzQ3M0k3K0hieS9ydEMzQ3JHci9FbHIyYTNxTzc5a2JU?=
 =?utf-8?B?SlAyYnNGWFRsTU1BY1NhbEx5UjNMSklaVC85dlp2NjBWTjlPcGpOYUpCa1NP?=
 =?utf-8?B?SWd0bERZb1plUW90Mk42LzdXTG9mcEJ1M00zdjUxbGEwVCtGemVQdVk1NmZG?=
 =?utf-8?B?UHlTbjFrU1dBM2c3ZElnWm15LzA1Ky9mUUEyanFZWkpwZlQrUU50SStEc3NQ?=
 =?utf-8?B?YjY2MUFndmNFV2JTUDk0NlA3WDFoNEM0dFRTWUYvcjBNYXdleEorMlNzNG94?=
 =?utf-8?B?ZXUzRWlvMUptV29rUTRsUlZmOFRua2RwZFZsbTcvTkFOT0pwNDYyN0NvREdo?=
 =?utf-8?B?dHdqcEc0NTRpNDVBZk9wYnBqdEkwWjRyM2RveFVaa04xSkx4V2E2cm5UdTFQ?=
 =?utf-8?B?ZDFrNFdCckZ6QTdlWjVjR0syejNSZ3dIekp0M2g2c2FMMHpLeEtrMnZRN0RV?=
 =?utf-8?B?NFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <97D4F5B358CBFE479AE355E6433E173C@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB5566.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4135597d-19a3-415c-ccd2-08dc4ae53b8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2024 02:59:18.6646
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f7V7kTXP44AnjjMbv8DFLL76urlj5GprazZGrpER6a9bpTvTGtglyUjA4UI/gdeXlLoCGql/cYXm/ByOnxCG4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB8297

SGkgU2FrYXJpLA0KDQpUaGFua3MgZm9yIHlvdXIgcmV2aWV3Lg0KDQpPbiBXZWQsIDIwMjQtMDMt
MjAgYXQgMDc6MjkgKzAwMDAsIFNha2FyaSBBaWx1cyB3cm90ZToNCj4gIAkgDQo+IEV4dGVybmFs
IGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVu
dGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRlbnQuDQo+ICBI
aSBaaGksDQo+IA0KPiBUaGFua3MgZm9yIHRoZSBzZXQuDQo+IA0KPiBPbiBTYXQsIE1hciAxNiwg
MjAyNCBhdCAxMDo1Mjo1M0FNICswODAwLCBaaGkgTWFvIHdyb3RlOg0KPiA+ICtzdGF0aWMgaW50
IGdjMDVhMl9zZXRfY3RybChzdHJ1Y3QgdjRsMl9jdHJsICpjdHJsKQ0KPiA+ICt7DQo+ID4gK3N0
cnVjdCBnYzA1YTIgKmdjMDVhMiA9DQo+ID4gK2NvbnRhaW5lcl9vZihjdHJsLT5oYW5kbGVyLCBz
dHJ1Y3QgZ2MwNWEyLCBjdHJscyk7DQo+ID4gK2ludCByZXQgPSAwOw0KPiA+ICtzNjQgZXhwb3N1
cmVfbWF4Ow0KPiA+ICtzdHJ1Y3QgdjRsMl9zdWJkZXZfc3RhdGUgKnN0YXRlOw0KPiA+ICtjb25z
dCBzdHJ1Y3QgdjRsMl9tYnVzX2ZyYW1lZm10ICpmb3JtYXQ7DQo+ID4gKw0KPiA+ICtzdGF0ZSA9
IHY0bDJfc3ViZGV2X2dldF9sb2NrZWRfYWN0aXZlX3N0YXRlKCZnYzA1YTItPnNkKTsNCj4gPiAr
Zm9ybWF0ID0gdjRsMl9zdWJkZXZfc3RhdGVfZ2V0X2Zvcm1hdChzdGF0ZSwgMCk7DQo+ID4gKw0K
PiA+ICtpZiAoY3RybC0+aWQgPT0gVjRMMl9DSURfVkJMQU5LKSB7DQo+ID4gKy8qIFVwZGF0ZSBt
YXggZXhwb3N1cmUgd2hpbGUgbWVldGluZyBleHBlY3RlZCB2YmxhbmtpbmcgKi8NCj4gPiArZXhw
b3N1cmVfbWF4ID0gZm9ybWF0LT5oZWlnaHQgKyBjdHJsLT52YWwgLSBHQzA1QTJfRVhQX01BUkdJ
TjsNCj4gPiArX192NGwyX2N0cmxfbW9kaWZ5X3JhbmdlKGdjMDVhMi0+ZXhwb3N1cmUsDQo+ID4g
KyBnYzA1YTItPmV4cG9zdXJlLT5taW5pbXVtLA0KPiA+ICsgZXhwb3N1cmVfbWF4LCBnYzA1YTIt
PmV4cG9zdXJlLT5zdGVwLA0KPiA+ICsgZXhwb3N1cmVfbWF4KTsNCj4gPiArfQ0KPiA+ICsNCj4g
PiArLyoNCj4gPiArICogQXBwbHlpbmcgVjRMMiBjb250cm9sIHZhbHVlIG9ubHkgaGFwcGVucw0K
PiA+ICsgKiB3aGVuIHBvd2VyIGlzIG9uIGZvciBzdHJlYW1pbmcuDQo+ID4gKyAqLw0KPiA+ICtp
ZiAoIXBtX3J1bnRpbWVfZ2V0X2lmX2luX3VzZShnYzA1YTItPmRldikpDQo+IA0KPiBUaGlzIHNo
b3VsZCBiZSBwbV9ydW50aW1lX2dldF9pZl9hY3RpdmUoKS4gUGxlYXNlIGFzc3VtZSBpdCB0YWtl
cyBhDQo+IHNpbmdsZQ0KPiBhcmd1bWVudCAodGhlIGRldmljZSktLS1zZWUgY29tbWl0DQo+IGMw
ZWYzZGY4ZGJhZWY1MWVlNGNmZDU4YTQ3MWFkZjJlYWVlNmY2YjMuDQo+IA0KPiBUaGUgc2FtZSBj
b21tZW50IGFwcGxpZXMgdG8gdGhlIEdDMDhBMyBpZiBpdCB1c2VzIGF1dG9zdXNwZW5kLCBwbGVh
c2UNCj4gcG9zdA0KPiBhIG5ldyBwYXRjaCBmb3IgdGhhdC4NCj4gDQpmaXhlZCwgcGF0Y2ggYXMg
YmVsb3c6IA0KZ2MwNWEgcGF0Y2g6djIgDQoNCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4
LW1lZGlhLzIwMjQwMzIzMDE0NzUxLjQ5ODktMS16aGkubWFvQG1lZGlhdGVrLmNvbS8NCg0KZ2Mw
OGEgcGF0Y2g6djgNCg0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtbWVkaWEvMjAyNDAz
MjMwMjM4NTEuNTUwMy0xLXpoaS5tYW9AbWVkaWF0ZWsuY29tLw0KDQo+IC0tIA0KPiBLaW5kIHJl
Z2FyZHMsDQo+IA0KPiBTYWthcmkgQWlsdXMNCg==

