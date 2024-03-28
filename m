Return-Path: <linux-kernel+bounces-122350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA5488F585
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 03:51:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55B1F29B9A6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 02:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6AD225D0;
	Thu, 28 Mar 2024 02:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="M5d+zrZI";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="ITMaLuVK"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8892C19D
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 02:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711594251; cv=fail; b=UwG3hLlCQsIROnMTbHZX8iKUkUUCSKESmnA+DxBk1CCc2W26xRYO5n0YYh6WflSyH2iEZ5stcYV9WWsYqWqd3zyZz3IKtp7+dLtdEHTtSIEMp2cD6wM+8/+yi5RUztCv7z0/QmYAjGQcxWwlJ8aQqFJ6rqL+y5xur2s7u/odtwA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711594251; c=relaxed/simple;
	bh=ONaYJpUuiVeoCugAWNZdktL0PJNf20orxHDUh5X0TwE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=F9TpKbR6aGI9XOgVv93WjwC9YzAeg97Da8ohkI3UycEZlfSdzUDGj0SBMM35NXssKL8KPxMsZuVMVid0uCqZf7TpbozzYBaGBAbV4JxOyVh2c61k4gPe+pfKFxCpxpwdftBfpzp0VG+x/WPPWPgD1UEM90r1pN8SmcV8weK5LEs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=M5d+zrZI; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=ITMaLuVK; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: f443cdc4ecad11eeb8927bc1f75efef4-20240328
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=ONaYJpUuiVeoCugAWNZdktL0PJNf20orxHDUh5X0TwE=;
	b=M5d+zrZI/3e/uEy6FipcOnYYcLvOWPGxJgrWYFMVGT9q7J1tOcyKlyGcpZslSrtU34vM2spEqyEKTMVuOIIgsmM84ANpW41L3CSJ3cmC/Nm8rB0QPnX/uYq8PNSGR7XTr0mvLr0zwNnqkJ72crx8P3vmP0SLGCu4QIOzCTnCPvk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:2be81695-f03d-4029-8898-f873bb84cd3e,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:b0978585-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: f443cdc4ecad11eeb8927bc1f75efef4-20240328
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <shawn.sung@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1017585878; Thu, 28 Mar 2024 10:50:36 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 28 Mar 2024 10:50:35 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 28 Mar 2024 10:50:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IHUD5pCBbds3/XKZL34LqxGO2N/dPxBEHFOINu0EZvTjoRd3Dcavs96NeUXnlwl8Y+wyCjBZogIFUZ9fiKfINgiurxn4j53b8sU3SV8MXyr9MQK92eVi5EVbpnYCIs5FhCZSr76/U7t5mmoQDozxEsnSkmN+O2eDDbkfZjKIcNkpovwRMD7gtRGVmEizb9FerzpEmYVGd/+Tv4YLjbp45v8mKH9WDfgA0XxKbMZO/DQG4XFpFTJfPnPXOEfXhApOL9TK+NRrHYiB4CW2oRwmsTsPCuZqK2nMN5uAvkFxIFMEJ/zVanr+zQYagnLpVimbK8Kt98hQ6JWupz+kuP5Xnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ONaYJpUuiVeoCugAWNZdktL0PJNf20orxHDUh5X0TwE=;
 b=codxPtW41yrrkEbMKEtt7IF04QuHd5ZjaRuBud6V+5v1/F/OOXjn3vHkuNq/wmFdjRPvif3fg1U9rm6m6i8c0yoHq6nh1c+BQQkfJZTZ3FP/6OpRDekwnVApcLKhyHgUmREuAWRPBnB1izib4kxAJtmLXUv6SfhgqWmGjyez2JK8756Z95Vpzboa75G/YzRNeJRcYlH3KUWgCnVjUshCM3h45IFUz8LxxClplgMZQzUqbTdrD5CZEKPZ16ybwnf8JoBmcussUf4TMzd5WqL3/GziRuClV6C2k7Fhi4bzaLH/ITUkOFoPBaAqrXWJ2hL6/YnCAdiu6AJfkMa0R6PF7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ONaYJpUuiVeoCugAWNZdktL0PJNf20orxHDUh5X0TwE=;
 b=ITMaLuVKLTkDD80fkDutYpb7ylQN2r7qEhiDNPmkcqY4FENoHhbr4OMWJz8NYSDporlym9K7QO6aM6gdiGk+Bso23pFOZNPyV3nyOna1A4F4oqMHoR2ARR8tjGGt7VOJg0bAnex+/+BMX6JZ3LrucujPxPsvpsQM49qCQE35SUg=
Received: from TYZPR03MB6623.apcprd03.prod.outlook.com (2603:1096:400:1f5::13)
 by TYZPR03MB7674.apcprd03.prod.outlook.com (2603:1096:400:426::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 28 Mar
 2024 02:50:32 +0000
Received: from TYZPR03MB6623.apcprd03.prod.outlook.com
 ([fe80::8031:ae41:afdd:d0a4]) by TYZPR03MB6623.apcprd03.prod.outlook.com
 ([fe80::8031:ae41:afdd:d0a4%3]) with mapi id 15.20.7409.031; Thu, 28 Mar 2024
 02:50:32 +0000
From: =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= <Shawn.Sung@mediatek.com>
To: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
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
Subject: Re: [PATCH v6 04/14] drm/mediatek: Add DRM_MODE_ROTATE_0 to rotation
 property
Thread-Topic: [PATCH v6 04/14] drm/mediatek: Add DRM_MODE_ROTATE_0 to rotation
 property
Thread-Index: AQHafBnuu1kQzYpLEket6GkmzEiziLFDd0QAgAQ+tYCABMc4gA==
Date: Thu, 28 Mar 2024 02:50:32 +0000
Message-ID: <52ddd0871a6feaf8ec26080161c25c4475ca5965.camel@mediatek.com>
References: <20240322052829.9893-1-shawn.sung@mediatek.com>
	 <20240322052829.9893-5-shawn.sung@mediatek.com>
	 <a5b00d343b922e726476e4b3c1973d44a05aacb3.camel@mediatek.com>
	 <fd3beacfc59f466ab5e51276a3479c0501350a39.camel@mediatek.com>
In-Reply-To: <fd3beacfc59f466ab5e51276a3479c0501350a39.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6623:EE_|TYZPR03MB7674:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PHFL48mWg2Yt+UATRm0WOBQbVZQqclG5RHmr4UHujoKLgjdB0R+xRi+hwiN7javdO2oywDMKQNhsaSTRq3e/J/pXqdrgHVLgTLIhXMYRG1QpARRwuNAtH2LKNq9OLgBStbpzkiTcADR1kpOSUkCksWpyr4s5hN8iILNRlW11fxZhMqLacgkGNwCOK1jNy3fLpftIb/iU2M/yQeTOizZEGIBboNU3BOQNBu6yfzLLgBrfTBc0auQlVT3uWJTQM2mbUpT4zbv7d4YRxocUYRN/d+xbdkBxTFeialifW00OU2dJYitzKeyqhbev65jzqj6igiSNShpud/yQgTsZuC7o10u3h+a5YjXBMJusp9UqfDIrQxdc8ncntI3aEc7lNa7LfEML+evUEe+7cwwCLRjUzIBDWKCCc+V9Ni1HTen+4yZpygz99XqktzC3GQKGBT99nmmb+aJy9riPNch2/rot634Wkc+dAbIHjFoqH4bBpSPtCg6ZI5Yu6Vnt5/hqUOAZ7YKyGEqHTiILN/o/Rv+FOoK2U1rJZjnlUgDcoiDtARqV6b8LYjzdBR7d5whzElcLtW17Hf6sF29F8M1EEy7mgmddCzUvGQ0Ers4RASVV+CDSqGVSPTYoo8xb8ZfP8CgTwyJICKVrYKAbtpgvy4P/ewVTq9w1gS5DwRg6373WqAo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6623.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(366007)(1800799015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZUhYRmRndGNEU1lCWGhmc3ZGY3RRc3J6QmdrTU5obDdSampDbWloU1dQOEt4?=
 =?utf-8?B?S014S2tNMW5MdlhQZGtpcHFIRFdRS0NzZFlXRnRCeTdqUXYrcHVJNmFxbVpm?=
 =?utf-8?B?by9HUXFSSnRjL09BRkhzdnlGNHV6bVVJYmllS0ZGSjMxbmN0ZkxoK2dteTl5?=
 =?utf-8?B?ODZzZlZGZ1RybG8vME5YSENwR2R5NkRTb1RNT245dFlGQ0FtM0dETUtOc011?=
 =?utf-8?B?L1lFS0JnSWxKR21iZmpxeVkzT3ZsMHlxTWVBUzNzSjFmeXR3bUFkN1dPRjBE?=
 =?utf-8?B?ei9VSG1xVnRHWXU3SFh0bzg4UWpqa1NXcjVjbUV6OWFkVXY3V285RWtNOFdq?=
 =?utf-8?B?Mng2TE1KMW1ZTDQ5T1lteUFNYXZjNGwyNVdhYkRBVHVIbzJjdmUvWWZmcnFV?=
 =?utf-8?B?M05SYytpUHcrbVI4b3luQWVlZDZWeEVMUXM5NHpKbmphOHpmSFdiZXBkbGY4?=
 =?utf-8?B?c0JFRCs1V3A3UkFMYXZjNmVhOFo1N1MxL2dsckg0eTk2ZEp1amtTbUtmV0N5?=
 =?utf-8?B?OVl5WDJWRzljT1M4YndJVDdrRzIxZm5MYTJSd3FWdkpnM3BDMEtWSC9BQXZt?=
 =?utf-8?B?b0pMUTBUTjFDbEJUUjZjWEtKNzluS05kclk2QTNDWGJnZUxNdEF1dzg2Vnc0?=
 =?utf-8?B?VlVidXpvM1NZTm1vcG42MjBFYmFPOFc1Qk1ZQ1RQZ2JOSlpEb0tXeTZSUDhw?=
 =?utf-8?B?L3J1VDJQWVpFSk91cjlEbVoyTmxvejRVYThxcEs4UUlsbTBDMHc0ZkZMQmFG?=
 =?utf-8?B?clYvalQxYTl2OFpMUW1WSTV6UUYySlpSNWllaHhDTVZWR2FPOWNOU2lWcVZF?=
 =?utf-8?B?WWhmdlFQeURmZHErNVVSQVZEalNDb2F3dG9DdElQTFVoWmF3dURzdzBmWFRK?=
 =?utf-8?B?UHdVcDBxTzkwbjZmeWoxcExMZ3RydklpR0k4VTAvbm1DTmJVbU9xTTZqVEhj?=
 =?utf-8?B?ajBaVFVMOUdod3NpaHBMeVZmdDdwTFc5UThja0JGaWRCd3lQV0t0R3UraSt1?=
 =?utf-8?B?UmJKNHRrVmw0bmVtL1Zibnd2S0wzdWZWalVYNEtpQ3NQRm0zZTFxL2hmdFc0?=
 =?utf-8?B?SCtxbUpTd2NKZndZcms0bTc0Q0FWR3hON25zMHpSemR5OUcyUXhCSkFSSWg5?=
 =?utf-8?B?ZzlIMFBYZzBrdmtVYzkwaC9QTnhKanFvUTVvcEMvZVdLdTExNUttekN1U1ly?=
 =?utf-8?B?cHJKeHZXKzl1ZHFYa2pwUUd4L0R2SWs3STV3QnozMENOYTQ0RlNucHQxQy9B?=
 =?utf-8?B?YVMwN3Rsdk5VbFQ1K0Q5bFAzUnh3N3hZc00rMVZ3dERIMmQwRlI4NmlNRnF1?=
 =?utf-8?B?Q0RxcUdReGFrWXp3NGdDaE94N2szclNpQndlQWJmcS9NUHBzR01GWTFWdEhv?=
 =?utf-8?B?ZnZDTkdUWTV3eC90VUV4akxBUDFpa1FXckhzUXVRTFIzVVc4K3Q4U0oyUHFQ?=
 =?utf-8?B?VndDT0U4MTN3d1hXem44ZkNwdjBHa0l6MDB6N3pxYndFbGgxRnQ3V212dFNX?=
 =?utf-8?B?QXM0eXVubDF5RldoTmorek5JdUFNN1A2V1JNelk3WVRPMHVKZUZzaTNJK09R?=
 =?utf-8?B?QVFianBaZGozMkNFRmdKWkpDcUdoMnRwaVZ4bnY1RTV5RkdpcXRhWlBKY0JT?=
 =?utf-8?B?b3VCeGJOc0Fwb0x3S0MrZC8yV1REemNNM2tCRG1qV0pRSk9BbmdBNkxXc0JE?=
 =?utf-8?B?MlIrMk1JdThUT2xheXMvdE1JeWZNMzcweFN0Y0JMSHpqMGNkbWVGRlZJMzhD?=
 =?utf-8?B?RGpPaWtseDZjOUtqS2I2Z3lYdVFvT25jZ3BkelB1d2dROE1vM2FobCtBYmdn?=
 =?utf-8?B?VmUrM053azFRRDFFek9laFp3S0xyMy81Zy83OHJONlJ2SjVOTWFhVm9NSkZT?=
 =?utf-8?B?MUFLNmR3a2htNnFEaVJ1R1dwdHlNQlBxcHFrb3Z6Yyt2SXY5eGFTbXBXbU5C?=
 =?utf-8?B?UmJMZ1NmZEcxOGZ2YUwvUjFMZ0VlenN3QlI0RG5xWjhmcE0wNm9Qcy9oK2lj?=
 =?utf-8?B?bmE2MTRMZGdYMXlSSzkrT3U2Njh2QVpUQVZZdXBJaCtpVVpXSUdVbjR6U2Zv?=
 =?utf-8?B?UGpxdldSdzYzOWJQK1pDWEE3TnRDYndpSFdkZEo2bHI3RE1FWXJEQ0NmZUIz?=
 =?utf-8?B?YUx1b1pibElEQkdFWUpDcGJmeFZiTEYwMDBVbHhlZE1uTnpqSlVKbUo1ZHY1?=
 =?utf-8?B?MlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <786747D65FCDD34C88BBDC46190416A2@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6623.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6624645b-830f-4557-c5bd-08dc4ed1d5f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2024 02:50:32.4404
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eNGxLvxtaV8OwA6shNu510sspWy8KY3BPPLGfz0KmplyfihOAX8N7J16xBjdF/iP/nA7HsldW+NZXecdrRXFTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7674
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--16.084800-8.000000
X-TMASE-MatchedRID: xSJL/ht5SGDUL3YCMmnG4t7SWiiWSV/1jLOy13Cgb4/mNRhvDVinv2mb
	S2REgOw3o5qw/iFKtvbzrL9jlOCHAfQtY4IdDLpU7spMO3HwKCC1k3bRIdXVNG0CvxZ2Eh6fee+
	psuSMY7ohJ/ufappeEpGTpe1iiCJq0u+wqOGzSV2Wlioo2ZbGwdmzcdRxL+xwKrauXd3MZDUD/d
	HyT/Xh7Q==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--16.084800-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	982D1CB1E528121F68F77C2C0CB7D94554F0C5C486F43A0F06DE25D5304987182000:8

SGkgQ0ssDQoNCk9uIE1vbiwgMjAyNC0wMy0yNSBhdCAwMTo1MiArMDAwMCwgQ0sgSHUgKOiDoeS/
iuWFiSkgd3JvdGU6DQo+IA0KPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRp
YXRlay9tdGtfZGlzcF9vdmwuYw0KPiA+ID4gYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRr
X2Rpc3Bfb3ZsLmMNCj4gPiA+IGluZGV4IDBlYmVhZjk4MzBkODMuLjJhNzY3YTgyM2M4M2EgMTAw
NjQ0DQo+ID4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bfb3ZsLmMN
Cj4gPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9vdmwuYw0KPiA+
ID4gQEAgLTI4OCw2ICsyODgsMTAgQEAgdW5zaWduZWQgaW50IG10a19vdmxfbGF5ZXJfbnIoc3Ry
dWN0IGRldmljZQ0KPiA+ID4gKmRldikNCj4gPiA+ICANCj4gPiA+ICB1bnNpZ25lZCBpbnQgbXRr
X292bF9zdXBwb3J0ZWRfcm90YXRpb25zKHN0cnVjdCBkZXZpY2UgKmRldikNCj4gPiA+ICB7DQo+
ID4gPiArCS8qDQo+ID4gPiArCSAqIGFsdGhvdWdoIGN1cnJlbnRseSBPVkwgY2FuIG9ubHkgZG8g
cmVmbGVjdGlvbiwNCj4gPiA+ICsJICogcmVmbGVjdCB4ICsgcmVmbGVjdCB5ID0gcm90YXRlIDE4
MA0KPiA+ID4gKwkgKi8NCj4gDQo+IFNvcnJ5LCB0aGlzIGNvbW1lbnQgaXMgbm90IHJlbGF0ZWQg
dG8gRFJNX01PREVfUk9UQVRFXzAsIHNvIGFmdGVyDQo+IHJlbW92aW5nIHRoaXMgY29tbWVudCwN
Cj4gDQo+IFJldmlld2VkLWJ5OiBDSyBIdSA8Y2suaHVAbWVkaWF0ZWsuY29tPg0KPiANCg0KR290
IGl0LiBObyBwcm9ibGVtLiBXaWxsIHJlbW92ZSBpdCBmcm9tIHRoaXMgc2VyaWVzLg0KDQpUaGFu
a3MsDQpTaGF3bg0K

