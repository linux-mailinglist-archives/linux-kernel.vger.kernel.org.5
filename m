Return-Path: <linux-kernel+bounces-67947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8BB85737C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 02:36:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C21D41C2124D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 01:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B844DDDC;
	Fri, 16 Feb 2024 01:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="En3b8wYv";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="tv6vzpXS"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7505ED528;
	Fri, 16 Feb 2024 01:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708047395; cv=fail; b=tB0N69qm6gosLrtp1BpPibkLvD8QghAjWvt1smRPEt5jsgGHVObfwM+Ts0ZYF68W5RQL4Wzj5lsIBJl8wMi+3aMIBpJtFux5ezGGe0yarBU/5SiAFqTmNvGW4oBQ+cNIH/R8gbqH8Rjf1Lxod/n5/Hqb147mzQ+soIW1DB3g9D0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708047395; c=relaxed/simple;
	bh=ROypZY7tCfsNgEzpaCGtmxHORv+IGxDM3svEvM4T6VU=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZBBeVj/Sdm03+cCpRcweuYD/QeCogiWfCGVC+hAj+2MYzB81lJT5zp8nQA8qCF047TQUOLs0Rd3TrBo268zc8j9wNnNjWcm4j80s5WmfiO0pAjxuXis+ST8M3wvN1iKFF1hLmWkACzx1TusJ7t6HNCqegpa/qwxL15UH0+OYl/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=En3b8wYv; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=tv6vzpXS; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: cc92fe56cc6b11eea2298b7352fd921d-20240216
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:To:From; bh=ROypZY7tCfsNgEzpaCGtmxHORv+IGxDM3svEvM4T6VU=;
	b=En3b8wYvkS83TF7XPayur0MZCQojwguauRaO5RgR+GIISlRccBCy/GD+NuWLctlcdQ+/0FfNt+a8eY8ubVZlDkVbrZB2dCshom5cwmteONd9FDHbc0tVFM4PT70l4KAPSRSygrw81uSMVM5+GS5pmeu/291WFbEaePBD/024xpI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:228705d8-221c-43ad-9de3-9a47b6f5e0e1,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:dd8df083-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: cc92fe56cc6b11eea2298b7352fd921d-20240216
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 883645786; Fri, 16 Feb 2024 09:36:26 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 16 Feb 2024 09:36:24 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 16 Feb 2024 09:36:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dDb2BpkzJppUL9UE5dNWSFkqtBdQudlpTjMpy6l75Npm7KOWWWZbXmTN5+kxBnxUNo0OQ5ADlkUDupumFSkwHoZR36FU2ZE66cAPZqJ5z9rmcdYLwcDYJ1WMa/GOolQvJufNvEbXSRXiuFL46k4vh3xIpTfjVgCt/TVjyXsSCAQHK7mUvcInu/qHYPWMA4kKUIt0u6RCG/r9vVgCHSsdKtTZGI0c1LNfn4X5n1MExr9X9ddKtSeL9mnQ25hMKyHWZtZ27dVFesk2809hPsdRuLvi8khtozYwLoMKKJg6OSlG/4GfL9A4AJTTx+i2WugQZ6/SSTL93I+e3xdKRApDlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ROypZY7tCfsNgEzpaCGtmxHORv+IGxDM3svEvM4T6VU=;
 b=RtnEOoHdfQzNwSSIYQj7Spph+c11hV5odYDuRM207u5REHZU7GhuSa/rdpIPat2j/LrZ/cqNthGNEQOXCbzl3P6aiIKDvtsoRAQSS6gkdUc04jfhFoWoDCVPFGmIkge0B9Q0AycRSq9UYs2BuXuTR7BYvO1eFGLGBHV2o9CNLWKBHqp3XEIWfXS9IHJQEcqB18Ads7RuGVCWUqLyfVEoUpruqoqUT9ECwk2Zj6CUjy+RAKaoWt/7fp+iXrODYelYnkmCNX4e1LSB0ZqmOyYEyhQYoJhgOuDYyq467IRLefHW27cc2niwkmrL3F+3xUsT7ovc4YOfk+GWWJiJxFUz2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ROypZY7tCfsNgEzpaCGtmxHORv+IGxDM3svEvM4T6VU=;
 b=tv6vzpXSF+8WgNQ80Za7JNW3mio7cVd8JTSS3WEJdpOo9QVYF+8kdFQTxEgIb4GuC9d/+HxQ/DmXAisHZ1vfZp6zJerZZf4yzH+7KJBqrw1DXnAwb6UoKdHS/ozbpbtu1wF4x0JWOqlhntwZnOsKvs2mn1BOysJFTQuQF9jQoaU=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SI2PR03MB5530.apcprd03.prod.outlook.com (2603:1096:4:121::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.42; Fri, 16 Feb
 2024 01:36:21 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::b705:ea58:46d:e98d]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::b705:ea58:46d:e98d%4]) with mapi id 15.20.7270.036; Fri, 16 Feb 2024
 01:36:20 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>, "mchehab@kernel.org"
	<mchehab@kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH 2/9] soc: mediatek: cmdq: Add parameter shift_pa to
 cmdq_pkt_jump()
Thread-Topic: [PATCH 2/9] soc: mediatek: cmdq: Add parameter shift_pa to
 cmdq_pkt_jump()
Thread-Index: AQHaX6kOoT62qs9V1E67cINXMi1D5rELN5IAgAD6MQA=
Date: Fri, 16 Feb 2024 01:36:20 +0000
Message-ID: <6fd1a8684139d124b76743f267ad1bbb8406c56b.camel@mediatek.com>
References: <20240215004931.3808-1-chunkuang.hu@kernel.org>
	 <20240215004931.3808-3-chunkuang.hu@kernel.org>
	 <21d17701-e40b-49c5-bf16-5e70a6daa2c4@collabora.com>
In-Reply-To: <21d17701-e40b-49c5-bf16-5e70a6daa2c4@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SI2PR03MB5530:EE_
x-ms-office365-filtering-correlation-id: d04ab0d5-d136-4b4b-523c-08dc2e8fada7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zOhb+cL70SRSgzAPI8A5VGSLP14ZT5rpB0ylWnCJ73RxNDOoqHChOlsUKEbmYp/QvgsdIy8Dk7dPq4UlnMHZB+d1CVTB+r/P7MOeiRQTGFs9bJXb7tHVVSNZUpjtTpQa/X7KhlymhK3pZb4RNqpE2aikHKFmZJvjGn6NaJxYgPp8wkXQ6I5I8qr2li+pWVGXX9Rs1/O+k3Xq/tipnkb8Yy3NoyRuPRiWiqcK1ZKjBU35r07+ZSffL/alxKrDCFT3quOleZYejazzRW9qMSTNOrJdCTAubh0Enj4tLHND/GTxy3lNSa2uCcxCpbY7K/dTrSa2yoScI32N2dsxHnlHeTrvQlc1paAGPXufscJjSAhQSYltVn+Xs3tOqRUaKxUc2Ejax0cmFr51KXAU49jXWey1P+QRt4htRU5KZY/8wzFzrPLHb22KEcPs1kvaOmBytXl8FuKRHdKePK0aGGJOSlRr3+FSR4SzYG7upBIGavin8JBfRazAnQDon0EzJCCg97R8RYWnd2io6Ftv9Pv+nf7G458kGZ/u7rylsyws76cwpmpImOnoxjne4TlLtO4iOIya78uibg187HkIbMfhM2u/J5Ll7hA6jJwzL1EQVGCE5LkEUokSYS/jhkTJezg7
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(39860400002)(376002)(346002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(83380400001)(26005)(2616005)(122000001)(41300700001)(71200400001)(6506007)(6512007)(6486002)(316002)(110136005)(478600001)(85182001)(38070700009)(2906002)(66556008)(8676002)(66476007)(36756003)(66446008)(76116006)(5660300002)(8936002)(66946007)(64756008)(38100700002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SHlkOVZKTXR3SEhBdUhIWGVxRVpHR0pEZkNUQlF5d1hsMFUxTzNGeUhRWDc2?=
 =?utf-8?B?UjhUSkhkdTFMc3FPMENWT1VjeFgvOFlKbEpnKzBRdkRaelFOa2ZUTGRlNG9o?=
 =?utf-8?B?dVdZdTh5NWhQK3BDTGFHQ2x4TVhrUlNLUTJrMjZPNTF2Smk1cW1zcmNCZGI4?=
 =?utf-8?B?NUtpRGRveW9SS3dqRWRFbUpsazYyM0xRN2lnWThTNmZTYk5wVmpiVFVIaklH?=
 =?utf-8?B?TnR5eGVlam1kdEt6MVhQYXVQTXZUcVc0VmNnMHNoQ3Ztdy9QVjZVaXdRbUtE?=
 =?utf-8?B?dzJLUE1JY0lLU3BzcnpiZm9tbTBSMGdSTUNnalJWMzhONjFzVEJPeWxocExl?=
 =?utf-8?B?djFoVzZQRUU3VGpON05aMXNrVXM5ZHNMOTQvbFdpWjlQT0d3K09CWGZqWkZX?=
 =?utf-8?B?WVpQeVdkWm95dHVSUE93R2ZOQW83bjhCcWRDcEtwTk9YS2JCOFZSQVVON1hE?=
 =?utf-8?B?cC9FMHpkOW42Ym1kTkdNVUpoZnFkWmJEem5yc2Jqb0N3RGdGVW5ydDRROFdt?=
 =?utf-8?B?Q1AzSEJwQU45dHYramlLN28xQWZ2THdnenArZExqcVJrR2NsWHBjVFp0eGdo?=
 =?utf-8?B?WGE2emZ3K2t4N1lwZTgveW1jTzdPZU1mbVNYSzBwVDk2aUNqTDFjKytwaFY3?=
 =?utf-8?B?c3ptUkhyMHNPOWcwaHFHSWVzUkZKRUVISnpuZWxSVmpCQm5LemJxeDRkNkVl?=
 =?utf-8?B?a2tsVDF1U3J2U3dWVU1RUEVsRFByeWFlandJRXB2ZkI3T1lOd3dRQTMrQ251?=
 =?utf-8?B?M0E0cG5lOHVSMjB1TFNmdTdkT1BNY29RUEVSSjJGUEVST3A1dGRkbERKSHZN?=
 =?utf-8?B?OEg1N1g2ZUdFOGlUV1Q0WVhTTGxBSkloY3RLV2s5L01aT2IvaUZsUE1wMEtq?=
 =?utf-8?B?bU5kSDdpOUZBL2VrUTl0M0ZoaFAzTStTN01raW55WGRjTTZZQmVGQWxWUHp2?=
 =?utf-8?B?R0U4K2t6S05BZjBFQWd0WGNtMlRhVTVsRDhsQ1A2ZngrbTNhREUzandWblhT?=
 =?utf-8?B?ZC9jYXgzMWZvK2h1Y3lRUHdyeU02ZmxoUzQ3SExWb2x3blVPWWpvNndUeWpN?=
 =?utf-8?B?MXkybVVidXEyZ05CWDU3MzduYlNtZXRudEZSQ3ZNSTRsaHFBc0NrbkxLTjdx?=
 =?utf-8?B?cEcxL25lWk1vNnNTbmxpWW9mTThma2dtd0hORGZDdkM0bUc4a2pMcXJhNU4w?=
 =?utf-8?B?a1g3NnkrZU9ubGJlZHRYRUFuWFJxaEpKRmJRTFk0a0tqZ0hwME1TenRYck9O?=
 =?utf-8?B?WGZPQXQ0ZENTSnNXTWNlSUkvZnh6ZklJVmRBSm1xYWh3ekNvdlNYTUY1QlB6?=
 =?utf-8?B?UTdHZGt6ZkV6cldxVFBnZ0tWb2ZoS0pPWDBxSXh3UFpFMTQvaHlSVUhRMmdr?=
 =?utf-8?B?RHRRbW52cFcrbGVMdFBHbkMrcFgxMkNZbTJjSlc3ajAyaFhwRjl1VDVQN3Nq?=
 =?utf-8?B?d2syMklIRGJOWEZiUS9Ec1A4ZkR3VjhKdTBaRDN1TjBMYW02VjgwZHd4aVYv?=
 =?utf-8?B?MzhSQTJCSlcxdGtQSGpNZTZuYnlmNUowSVdoZHYrUkpJbU55TWRnNWRKS3NY?=
 =?utf-8?B?K1N0eFNHdE1sRkpMaUUwZmhLcERVOGE0VkpPbno4T2wvbmxqemZLYTIrZWox?=
 =?utf-8?B?c1pnYUdLdEtzM0VOMDBENDhCR3MwYmJkd0RrbGpXQ2ZtUFk0aDlWUklYNENI?=
 =?utf-8?B?Y25jOFdmYVRSVVdVR3NmeTRhcUIzZC9xZkxmSDVNT2xZZjVDbmpUSW9hYlBF?=
 =?utf-8?B?MTM0ak1uSU8vQUUvSFFrRExlRzN2TmxoNE95Y0JodS9MVUlaNGFiVG9ySk5T?=
 =?utf-8?B?a2ZHSTFiYy85bzBsbSswTmhZaHE0VThhM3UydFVLb0VISEY4V21qU2xjaE82?=
 =?utf-8?B?NE1EcGhvUlhHSWhnZ0QrRng4OHgzZVdVaVZEeWlQNGVqT3IyMkZoalRFUG1S?=
 =?utf-8?B?KzlId1VQNzE4OTU5V0NuS0xWaFY3cFlPUkJLT25FMEliZ3RwOFd1UU5wTS9U?=
 =?utf-8?B?dWxZLzArWGRUdHNKVysrbkNqVWlHQWVFcXJObitmVjVYaHFuRldkdGVhV0Mv?=
 =?utf-8?B?YVFKaGE4M1c5UWFubTZ1ZWZmRTk2TVdJMFVBWkFvZzRDdFFqMlBOVFVTYmd0?=
 =?utf-8?Q?xNKtmZ3SMBSiJNHOrgYaEa8GK?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <64934170FC1A0841A0CFA1218BA21DD2@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d04ab0d5-d136-4b4b-523c-08dc2e8fada7
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2024 01:36:20.8258
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8ohPX2bG1iT/sIjFHnhs/AJVPAdegOWPKh2HV77b5DFNRlD+QoZcCylSzGhID9qf2yGuQ4VuQA6h7cR9FPDpQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB5530
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--18.458100-8.000000
X-TMASE-MatchedRID: hls5oAVArl8NtKv7cnNXnSa1MaKuob8PofZV/2Xa0cIVgNy0ftNF+2yd
	bY7xfgXYe2cY6fLoAfnKb/mj2xYcvjJGiGi2yernQ1OcCEvT+beLKfr4l0eFz7tM0VOnl/Ahlqx
	8Dxj9EIWxRk3pXu/rKc6Cs9UOBoSoO6dIc6rKMTezI1v7J4hECjFcf92WG8u/NEJplIoT86yZiK
	kTLfbrWzWYCrl4C4KTWKNxvq78azVveCKWtaLcaBIMDPFEv6Uxc3ewuwbSaG5OCtCDJNptxpy8U
	G+qg0r741s1gODGdF2lEtDJyVR88kL9tcyTZdAsgxsfzkNRlfKx5amWK2anSPoLR4+zsDTtFAQv
	QYa7pINjR6eegP/5vTLrK9mzBKoFQP6Gqc9cOc8spbaXm4u2EQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--18.458100-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	77AECE59CEAFA30AF8F82F4B171F37274CE8E2790F2C00B0C1867C2C997F5EBC2000:8

SGksIEFuZ2VsbzoNCg0KT24gVGh1LCAyMDI0LTAyLTE1IGF0IDExOjQwICswMTAwLCBBbmdlbG9H
aW9hY2NoaW5vIERlbCBSZWdubyB3cm90ZToNCj4gSWwgMTUvMDIvMjQgMDE6NDksIENodW4tS3Vh
bmcgSHUgaGEgc2NyaXR0bzoNCj4gPiBJbiBvcmlnaW5hbCBkZXNpZ24sIGNtZHFfcGt0X2p1bXAo
KSBjYWxsIGNtZHFfZ2V0X3NoaWZ0X3BhKCkgZXZlcnkNCj4gPiB0aW1lIHRvIGdldCBzaGlmdF9w
YS4gQnV0IHRoZSBzaGlmdF9wYSBpcyBjb25zdGFudCB2YWx1ZSBmb3IgZWFjaA0KPiA+IFNvQywg
c28gY2xpZW50IGRyaXZlciBqdXN0IG5lZWQgdG8gY2FsbCBjbWRxX2dldF9zaGlmdF9wYSgpIG9u
Y2UNCj4gPiBhbmQgcGFzcyBzaGlmdF9wYSB0byBjbWRxX3BrdF9qdW1wKCkgdG8gcHJldmVudCBm
cmVxdWVudCBmdW5jdGlvbg0KPiA+IGNhbGwuDQo+ID4gDQo+IA0KPiBBcyBmYXIgYXMgSSB1bmRl
cnN0YW5kLCB0aGUgQ01EUSBzdXBwb3J0cyBib3RoIHJlbGF0aXZlIGFuZCBhYnNvbHV0ZQ0KPiBq
dW1wcywgcmlnaHQ/DQo+IA0KPiBIZXJlJ3MgbXkgcHJvcG9zYWw6DQo+ICAgLSBBZGQgYSBuZXcg
ZnVuY3Rpb24gY21kcV9wa3RfanVtcF9yZWwoKSBvcg0KPiBjbWRxX3BrdF9qdW1wX3JlbGF0aXZl
KCkNCj4gICAgICogbm90ZTogSSBwcmVmZXIgInJlbCIsIGFzIG1heWJlIGluIGEgZnV0dXJlIHdl
J2xsIGdldCBhIGp1bXBfYWJzDQo+IGZ1bmN0aW9uPyA6LSkNCj4gICAtIERvbid0IHRvdWNoIHRo
ZSBjbWRxX3BrdF9qdW1wKCkgZnVuY3Rpb24gZm9yIG9uZSBjeWNsZQ0KPiAgICAgLSBNaWdyYXRl
IG1lZGlhdGVrLWRybSB0byB1c2UgY21kcV9wa3RfanVtcF9yZWwoKQ0KPiAgIC0gUmVtb3ZlIGNt
ZHFfcGt0X2p1bXAoKSBpbiB0aGUgbmV4dCBjeWNsZS4NCj4gDQo+IFdoYXQgZG8geW91IHRoaW5r
Pw0KDQpHb29kIGlkZWEuIEkgd291bGQgY3JlYXRlIGNtZHFfcGt0X2p1bXBfYWJzKCkgdG8gcmVw
bGFjZQ0KY21kcV9wa3RfanVtcCgpIGFuZCBmaXggdGhlIHdyb25nIGRlZmluaXRpb24gb2YgQ01E
UV9KVU1QX1JFTEFUSVZFIGFzOg0KDQojZGVmaW5lIENNRFFfSlVNUF9SRUxBVElWRSAwDQojZGVm
aW5lIENNRFFfSlVNUF9BQlNPTFVURSAxDQoNClJlZ2FyZHMsDQpDSw0KDQo+IA0KPiBSZWdhcmRz
LA0KPiBBbmdlbG8NCj4gDQo+ID4gU2lnbmVkLW9mZi1ieTogQ2h1bi1LdWFuZyBIdSA8Y2h1bmt1
YW5nLmh1QGtlcm5lbC5vcmc+DQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL3NvYy9tZWRpYXRlay9t
dGstY21kcS1oZWxwZXIuYyB8IDUgKystLS0NCj4gPiAgIGluY2x1ZGUvbGludXgvc29jL21lZGlh
dGVrL210ay1jbWRxLmggIHwgNiArKysrLS0NCj4gPiAgIDIgZmlsZXMgY2hhbmdlZCwgNiBpbnNl
cnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYw0KPiA+IGIvZHJpdmVycy9zb2MvbWVkaWF0
ZWsvbXRrLWNtZHEtaGVscGVyLmMNCj4gPiBpbmRleCA2N2UxNzk3NGQxZTYuLmVkNGVmOTVhZGY1
YiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIu
Yw0KPiA+ICsrKyBiL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jDQo+ID4g
QEAgLTM0OCwxNCArMzQ4LDEzIEBAIGludCBjbWRxX3BrdF9hc3NpZ24oc3RydWN0IGNtZHFfcGt0
ICpwa3QsIHUxNg0KPiA+IHJlZ19pZHgsIHUzMiB2YWx1ZSkNCj4gPiAgIH0NCj4gPiAgIEVYUE9S
VF9TWU1CT0woY21kcV9wa3RfYXNzaWduKTsNCj4gPiAgIA0KPiA+IC1pbnQgY21kcV9wa3RfanVt
cChzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgZG1hX2FkZHJfdCBhZGRyKQ0KPiA+ICtpbnQgY21kcV9w
a3RfanVtcChzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgZG1hX2FkZHJfdCBhZGRyLCB1OA0KPiA+IHNo
aWZ0X3BhKQ0KPiA+ICAgew0KPiA+ICAgCXN0cnVjdCBjbWRxX2luc3RydWN0aW9uIGluc3QgPSB7
fTsNCj4gPiAgIA0KPiA+ICAgCWluc3Qub3AgPSBDTURRX0NPREVfSlVNUDsNCj4gPiAgIAlpbnN0
Lm9mZnNldCA9IENNRFFfSlVNUF9SRUxBVElWRTsNCj4gPiAtCWluc3QudmFsdWUgPSBhZGRyID4+
DQo+ID4gLQkJY21kcV9nZXRfc2hpZnRfcGEoKChzdHJ1Y3QgY21kcV9jbGllbnQgKilwa3QtPmNs
KS0NCj4gPiA+Y2hhbik7DQo+ID4gKwlpbnN0LnZhbHVlID0gYWRkciA+PiBzaGlmdF9wYTsNCj4g
PiAgIAlyZXR1cm4gY21kcV9wa3RfYXBwZW5kX2NvbW1hbmQocGt0LCBpbnN0KTsNCj4gPiAgIH0N
Cj4gPiAgIEVYUE9SVF9TWU1CT0woY21kcV9wa3RfanVtcCk7DQo+ID4gZGlmZiAtLWdpdCBhL2lu
Y2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmgNCj4gPiBiL2luY2x1ZGUvbGludXgv
c29jL21lZGlhdGVrL210ay1jbWRxLmgNCj4gPiBpbmRleCA2YzQyZDgxN2QzNjguLjYyMTUxOTFh
MzI4ZCAxMDA2NDQNCj4gPiAtLS0gYS9pbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGstY21k
cS5oDQo+ID4gKysrIGIvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaA0KPiA+
IEBAIC0yMzgsMTAgKzIzOCwxMiBAQCBpbnQgY21kcV9wa3RfYXNzaWduKHN0cnVjdCBjbWRxX3Br
dCAqcGt0LCB1MTYNCj4gPiByZWdfaWR4LCB1MzIgdmFsdWUpOw0KPiA+ICAgICoJCSAgICAgYSBw
aHlzaWNhbCBhZGRyZXNzIHdoaWNoIHNob3VsZCBjb250YWlucw0KPiA+IG1vcmUgaW5zdHJ1Y3Rp
b24uDQo+ID4gICAgKiBAcGt0OiAgICAgICAgdGhlIENNRFEgcGFja2V0DQo+ID4gICAgKiBAYWRk
cjogICAgICAgcGh5c2ljYWwgYWRkcmVzcyBvZiB0YXJnZXQgaW5zdHJ1Y3Rpb24gYnVmZmVyDQo+
ID4gKyAqIEBzaGlmdF9wYToJc2hpZnQgYml0cyBvZiBwaHlzaWNhbCBhZGRyZXNzIGluIENNRFEN
Cj4gPiBpbnN0cnVjdGlvbi4gVGhpcyB2YWx1ZQ0KPiA+ICsgKgkJaXMgZ290IGJ5IGNtZHFfZ2V0
X3NoaWZ0X3BhKCkuDQo+ID4gICAgKg0KPiA+ICAgICogUmV0dXJuOiAwIGZvciBzdWNjZXNzOyBl
bHNlIHRoZSBlcnJvciBjb2RlIGlzIHJldHVybmVkDQo+ID4gICAgKi8NCj4gPiAtaW50IGNtZHFf
cGt0X2p1bXAoc3RydWN0IGNtZHFfcGt0ICpwa3QsIGRtYV9hZGRyX3QgYWRkcik7DQo+ID4gK2lu
dCBjbWRxX3BrdF9qdW1wKHN0cnVjdCBjbWRxX3BrdCAqcGt0LCBkbWFfYWRkcl90IGFkZHIsIHU4
DQo+ID4gc2hpZnRfcGEpOw0KPiA+ICAgDQo+ID4gICAvKioNCj4gPiAgICAqIGNtZHFfcGt0X2Zp
bmFsaXplKCkgLSBBcHBlbmQgRU9DIGFuZCBqdW1wIGNvbW1hbmQgdG8gcGt0Lg0KPiA+IEBAIC0z
MzksNyArMzQxLDcgQEAgc3RhdGljIGlubGluZSBpbnQgY21kcV9wa3RfYXNzaWduKHN0cnVjdA0K
PiA+IGNtZHFfcGt0ICpwa3QsIHUxNiByZWdfaWR4LCB1MzIgdmFsdWUpDQo+ID4gICAJcmV0dXJu
IC1FSU5WQUw7DQo+ID4gICB9DQo+ID4gICANCj4gPiAtc3RhdGljIGlubGluZSBpbnQgY21kcV9w
a3RfanVtcChzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgZG1hX2FkZHJfdA0KPiA+IGFkZHIpDQo+ID4g
K3N0YXRpYyBpbmxpbmUgaW50IGNtZHFfcGt0X2p1bXAoc3RydWN0IGNtZHFfcGt0ICpwa3QsIGRt
YV9hZGRyX3QNCj4gPiBhZGRyLCB1OCBzaGlmdF9wYSkNCj4gPiAgIHsNCj4gPiAgIAlyZXR1cm4g
LUVJTlZBTDsNCj4gPiAgIH0NCj4gDQo+IA0KPiANCj4gDQo=

