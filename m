Return-Path: <linux-kernel+bounces-66349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25105855B4D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 08:08:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA6AE295C03
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 07:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040B6D2E0;
	Thu, 15 Feb 2024 07:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Aajts5D7";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="hgA6f3T6"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47597DDDF
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 07:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707980884; cv=fail; b=kP1HVSzm9Sm90KQYtbJFUgDyxnaNmSiyKrsHvaZf5HCnLp9TWB5Dy7qeZSvyumn1TzYkLbrMw89Fz2m2tIQONArcdo5oVLs3up1doiqdK2cYFLbPZJsnBfm1ONUWDbxhezuN6XQIkubvXjrty229/U9pUGJ3NqbaHlO+nFqPCYE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707980884; c=relaxed/simple;
	bh=/M9thZhJUZ3qkNqCiCece//X0w6MMxzcQ/kZNwurtDk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iH2O81c31lwEistHiF1zB3UFYOZwQ7Sk5kERPn1P9LReK6P7yYugSu8DsLrqVB8IYnoyuy/Goc7rrEX/C6+VlJ1NYsy5+IT1t8i0vDwwLi1WM9qZYcz6FZGT3bbocvD+d5i7HcslwEBVOMXE2VhDHzYpoUcrW3ukIp3aWfJcDH8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Aajts5D7; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=hgA6f3T6; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: f1794022cbd011eea2298b7352fd921d-20240215
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=/M9thZhJUZ3qkNqCiCece//X0w6MMxzcQ/kZNwurtDk=;
	b=Aajts5D757ndWKTC0tSCzTCn5avMHU1kL/K0n2L6wbxUATj1ajudLb0Yt9bnbQywjBvOfIMH5YSB0XOWZ50R+j1Bw9tPOOEPoJjaKtXsQhmDBk0hmESJu+k2Gu/iJhDPeGYktgixInaCR1KqC9+hhmxzEScCNwQCmhHm93cAMnY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:ae3b388c-b75e-4398-ba16-b318418c4c63,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:af8c6980-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_ULN,TF_CID_SPAM_SNR
X-UUID: f1794022cbd011eea2298b7352fd921d-20240215
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 40405709; Thu, 15 Feb 2024 15:07:55 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 15 Feb 2024 15:07:55 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 15 Feb 2024 15:07:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nogpUZKSojzkSQdxaostfspporDsyjDYpyuB5dzVSh70FV5B3luzOPO1P6vKqrQ6Q9K0vRzVgRRUbPGIWxOF/YeIeJNheENfuqiL4cNnNrw3FT+DK0rbzYDMVBR205w4sijGpJybTWGU3jqo5LjgutXNMNij3cdVDX9IB3Zh88TedImUR+jX54YLU8jZSkNbldZPSuk/vWKGNgDEWSGfzryryTOuN4vQp2oiRKr4RsuMe9KaiJIoNqgrwxqB1xlJkSQUV+qZwzUlyHmCoebMXIFNnF/VqB1iTMZYmNjaJGCCkIQeQmKWz88+0DYI+y4zrXMqx5sovItk1PhGJ2p+Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/M9thZhJUZ3qkNqCiCece//X0w6MMxzcQ/kZNwurtDk=;
 b=hC6nlJdmopZXNanfl20zokgeC2VzZtAfurOPF+kbiZCJTrjxTIqLRhYt8o3tHgsULdI+RV9ilyt3VMlavHAeIZA7GoyMk00LFZN9FQ8ljQaONTBe3+amyefwr+nOt8WqR4ghGHmkh1Os4bz89W7E001hicR12RP5FlkkvM4fkVuBwnRj2dOgdYa9XBxVK/xdgOHFgqKcqF2gCpo9VtMWMXHWY4XoxQLDm68LhPMnLg7Z42Ebk3aQhDyoYZ9LtahBqKxf/Yj3fPULQ9ZCMBiE7qpJGYyOREiaVIPmEC7pOW2kIkegxbqa+l1JUyVBNFtf3Pg+wChntUWDQ1xcHcAVrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/M9thZhJUZ3qkNqCiCece//X0w6MMxzcQ/kZNwurtDk=;
 b=hgA6f3T6lgDO0K1YxL1BABExw30CVyHjxn5W9LJLrcAl2aANP8Tp2JbFPUOq74ZbOwUgZnrkfCmLq4gpLr9w9XT82sT3RNapNgiUHhpPNGd/PO1mzxc6Q4MTxuV7LNy/I9mYFvLjkIOev9cDvK0s7CI7v+e9XKkkNhPcZ/587Ck=
Received: from SEYPR03MB6626.apcprd03.prod.outlook.com (2603:1096:101:83::7)
 by SG2PR03MB6657.apcprd03.prod.outlook.com (2603:1096:4:1de::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Thu, 15 Feb
 2024 07:07:52 +0000
Received: from SEYPR03MB6626.apcprd03.prod.outlook.com
 ([fe80::afa5:be3f:bc79:48fe]) by SEYPR03MB6626.apcprd03.prod.outlook.com
 ([fe80::afa5:be3f:bc79:48fe%3]) with mapi id 15.20.7270.036; Thu, 15 Feb 2024
 07:07:52 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "chunkuang.hu@kernel.org"
	<chunkuang.hu@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"kernel@collabora.com" <kernel@collabora.com>, "daniel@ffwll.ch"
	<daniel@ffwll.ch>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"amergnat@baylibre.com" <amergnat@baylibre.com>, "airlied@gmail.com"
	<airlied@gmail.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>
Subject: Re: [PATCH v5 3/9] drm/mediatek: dsi: Cleanup functions
 mtk_dsi_ps_control{_vact}()
Thread-Topic: [PATCH v5 3/9] drm/mediatek: dsi: Cleanup functions
 mtk_dsi_ps_control{_vact}()
Thread-Index: AQHaWdV4hcuutFN6GEeiNy8qloqKWbELB7WA
Date: Thu, 15 Feb 2024 07:07:52 +0000
Message-ID: <5ad39702eb09a122e4302529dd4d9f12c37f7706.camel@mediatek.com>
References: <20240207145307.1626009-1-angelogioacchino.delregno@collabora.com>
	 <20240207145307.1626009-4-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240207145307.1626009-4-angelogioacchino.delregno@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB6626:EE_|SG2PR03MB6657:EE_
x-ms-office365-filtering-correlation-id: 6fea95a4-5915-447e-08c8-08dc2df4d385
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BUI9jx9eBW0TT8Q9LKxSO4ZDtgCod8LyxmFMGEN1snUQQAq3G7OqC5D+EQlCffLbz/jtgnzpbnpMdJdoMxrLi+zhrpPygAr0pVvzvEQ9CrYq050KtdVk0RkVFQXAia5Aq3PCWW7pGpXHFYFn0Vlb1XPMoYv4YNMVGBOsPkVnSEat14EE1TBokXKpEazGWAnejCTCA6rYLJmLnOeHC+ciRk3qcKDu0ZXlTzcdVYeX8X4RZ3VYuQ1d+LGN3laPhl2xi87IK1oCGDMyBq/LA06gj6Pl4FcclAQQAS1dsSIRuutBhX2hUbWMqEAjOH1Asu09No2kdIB9j3p9pzcQkQy4tIRzcwpiZ09QlpvIEIfYSJJNgn1HPo9tjfBp4uoNstof5i7aNhoY8SAeYqWzrxBXQik7zXRsgobk5bDKTwPx99nYXHOcAe9ZFQ8kUtmTCVeLa86SXRXnJXncxidWbiUoPLW/hnnmtluIxeYwxyRlkC509C22lfu75iZaKaL4cdhLxqZ8Qtgt4u3TbuIWANy5Pl3wPF49pqHr0I1mhO2F/aR/DfZ/d9pVGE10xPaFSx5T+p4GxhyE5drG1MZs6hWajD+0xfmt3Gui5+a2+MV5KNXCyYoOJugCQ9mX875ODf3Q
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB6626.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(366004)(346002)(39860400002)(376002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(76116006)(110136005)(41300700001)(6486002)(2906002)(7416002)(5660300002)(66946007)(64756008)(83380400001)(66476007)(54906003)(122000001)(8676002)(6506007)(8936002)(86362001)(316002)(66556008)(2616005)(478600001)(85182001)(36756003)(38100700002)(26005)(6512007)(66446008)(71200400001)(38070700009)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?THNNQnZ3bGZIRGFKbkFCQUM4UGM3NjIxMk4yS1ZtbTdrYjd3eTQ0MGYxZXd2?=
 =?utf-8?B?dUlzOHBIbXhNT3BjWHo5cUJXSU1YZVVPaGlaWVpGMWloM1ZiMG1UdnpqeWR4?=
 =?utf-8?B?S2JsbDlxbmJqZFBhdjFhQzlCTjdnY2ZwTlJWYUUwYU1kb0licllyeFJ1S3dS?=
 =?utf-8?B?NDRoa0VmZnVGZlB5aVVadUF2L3VhTVVQTnhwVXlrcUJJc2hGZDRDZVFvdUhK?=
 =?utf-8?B?VnJ1WVpWL3NQc0dlZEh6ZGxPNzhXTnMxNGpmMk9YMG4rMUtrekExUlhWY1B0?=
 =?utf-8?B?VkM1OW1kY1Y0RDQ2d0ZqZEVGdmY5bXU2RVBidi9TTEQ3SnlZWHVaNklVa3hF?=
 =?utf-8?B?akJZS25zcEJHeXhSS0RMYmkzVDlCbnhaWFY1aDVDSm5uMmFrdExrRzlmMzU0?=
 =?utf-8?B?ZWlMUWl5WHJ4TXlFRzF4bytpRUMxT0l5MTZIZTdlUHdMU1N0Q2FyRGpDb2dL?=
 =?utf-8?B?aHE5cUFCdy9zbU4vSTRpaXRXb2k3Q3plNjhEd2xlTlBGWlVkY1Z4cHJpaC9C?=
 =?utf-8?B?U3V2VDFkZEIrZUgrd24wWEo1RnpuNHdhS1UzNVlQRTBWby9rZXZzRVR4UDdD?=
 =?utf-8?B?Tm5ZdXRSREwwRkVkdExjc3ZTejJmVFQ1MGlHZloyVnR3ZVVUR25DZzEyMjFj?=
 =?utf-8?B?NS82aWROTmROU3lzL01MUHlEb1NwbTdmeGlHQWZuenVLYW0xc25EeHQ1Q1cx?=
 =?utf-8?B?UVc5Zytzb0QrTk12UkpvOUZjMUhiQ2NWN1c5WkxwQjRMSXlOekh3YkdhRkxJ?=
 =?utf-8?B?RmE5Z0hrWjNSaVAxcGtjMjhrRkY4YUxWMkV3V1B1WTJpV2l1dTJ1WEVodDFr?=
 =?utf-8?B?VDlZVTB3UXBDdmVaS3dxYXNaeElHKzlZcjNSaUFZU0t0cmxLVFFxdWhBSFRX?=
 =?utf-8?B?dlRXaHdJVmM4NCthQ3ZqSlpESGtIVXlqVStNQmRsTVNGV0xHWkRsOGlCSG5T?=
 =?utf-8?B?T1k4czRzbVkwN01iaEs3Vm1rZjVRYzNuZnpPd2dpL3dEVkxvdU9kVmNWL0pU?=
 =?utf-8?B?ZVJjb0s2eGEwemFXbTBBTjJSeTZqQitITGNjdzVFMEM5bDRjaDM2OE5reXhE?=
 =?utf-8?B?TWk1OTRJcXVkR1Z5dG9IdEhpU3JoVkNSZG4waW1ZZlhRTytycEdkdmlwYkhu?=
 =?utf-8?B?Y1NwNWJJUDZoVmpuTmZJcEpJNS83dUg5RGRPb045eGkvcDFLV1dlS2x2SENq?=
 =?utf-8?B?TkNtSTNyUWNOLzhSQVJuSE9GTWFLRjhjUHphUUxTaWEvVGNZNVNpQXFkK3BS?=
 =?utf-8?B?d1hUTlQvSVFaRWNkeGVrUm05STdFYzMvRkQ0VFowMW1ua2hKYysxL0FwN0ph?=
 =?utf-8?B?OENMbTNqaFRxODFGcHpnU2tkTUhKTFIrSFJiWjQ2dnFXU2NaMEtjZ0RnT1F2?=
 =?utf-8?B?MFp6OU81cjlablZhQjExWVlaMEJvdVhpSmJ5cndDMStjbldoYTJTM3BXSmpl?=
 =?utf-8?B?ak9yWTY2UW5zZysyc1ZrQUZ6VjMxLzFaWVY3R1lCZURiWFRMTEdQNjZsdXZq?=
 =?utf-8?B?dUF4bncyaE8yQzBKLytiT3NhYXdlVUdnS3FPQk9FL09zWk5OZDJKa2xFUy94?=
 =?utf-8?B?Mmt3ZG5mZVMxK1RWV2pkMEdobmNrRS9yOFNaSFBQU3M3aCtscGFqdWVUMUdM?=
 =?utf-8?B?NDVGMTVZZHoyNDNiYWJVUHBYQXNWb0swSzBWajhKR1cxb2cyaHQzeHZjS29t?=
 =?utf-8?B?K2JFNHUvY3hSWDdQSDhpdFNPWitSRkhKblpaNzZxYm1YSHk1NCszL1h5YUdt?=
 =?utf-8?B?a2xKT21yQTM5WHIyYnFpU202ZHFyWnYwdGY1YmJmU0F2R2pwNFdjUUp4V2Er?=
 =?utf-8?B?Sm9kbGNqR05mNVZzNGl6UWpKZHdScWlkNFJMUmFHLzdrdXhQRXQyOE1Ta2U1?=
 =?utf-8?B?WTBDcGc4NmQ5R2E3Nkx0dytMSW9MK0NKUFZjMHM2aVdrVklRWnUzQ214M0VG?=
 =?utf-8?B?Q01kNEpRdFplQ3ZxYThPMlhPWko0bkY4dG0xV2dRK0duVk5PSXIrMzFodmNU?=
 =?utf-8?B?cHRLemZaYnhrMWp1ZWVxZjZiS0JIUlRVNzB6LzdHc1RpK0ZUMGVidkNSWW5J?=
 =?utf-8?B?SXhCU1hEU1FQeEtybHNWMUd0V0gvQ2w3VmYzVWtrRE1YYlI5b1E0NnpzTUI5?=
 =?utf-8?Q?BuKMNJiJNTcZkV9XXq72sS2Q1?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B93ACA0A90226E40A8143539BE18B8AE@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB6626.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fea95a4-5915-447e-08c8-08dc2df4d385
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2024 07:07:52.3626
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1NZ6tTmgRB/Jr9oLa6gVrALpdB0gAUfbVdW9KgotucfCMz+t/jnxBm4a/xavmIhNue8NriHEQJktenDsUNkTvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR03MB6657

SGksIEFuZ2VsbzoNCg0KT24gV2VkLCAyMDI0LTAyLTA3IGF0IDE1OjUzICswMTAwLCBBbmdlbG9H
aW9hY2NoaW5vIERlbCBSZWdubyB3cm90ZToNCj4gRnVuY3Rpb24gbXRrX2RzaV9wc19jb250cm9s
KCkgaXMgYSBzdWJzZXQgb2YNCj4gbXRrX2RzaV9wc19jb250cm9sX3ZhY3QoKToNCj4gbWVyZ2Ug
dGhlIHR3byBpbiBvbmUgbXRrX2RzaV9wc19jb250cm9sKCkgZnVuY3Rpb24gYnkgYWRkaW5nIG9u
ZQ0KPiBmdW5jdGlvbiBwYXJhbWV0ZXIgYGNvbmZpZ192YWN0YCB3aGljaCwgd2hlbiB0cnVlLCB3
cml0ZXMgdGhlIFZBQ1QNCj4gcmVsYXRlZCByZWdpc3RlcnMuDQoNClJldmlld2VkLWJ5OiBDSyBI
dSA8Y2suaHVAbWVkaWF0ZWsuY29tPg0KDQo+IA0KPiBSZXZpZXdlZC1ieTogRmVpIFNoYW8gPGZz
aGFvQGNocm9taXVtLm9yZz4NCj4gUmV2aWV3ZWQtYnk6IEFsZXhhbmRyZSBNZXJnbmF0IDxhbWVy
Z25hdEBiYXlsaWJyZS5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IEFuZ2Vsb0dpb2FjY2hpbm8gRGVs
IFJlZ25vIDwNCj4gYW5nZWxvZ2lvYWNjaGluby5kZWxyZWdub0Bjb2xsYWJvcmEuY29tPg0KPiAt
LS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHNpLmMgfCA3NiArKysrKysrKyst
LS0tLS0tLS0tLS0tLS0tLS0tDQo+IC0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMjMgaW5zZXJ0aW9u
cygrKSwgNTMgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L21lZGlhdGVrL210a19kc2kuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHNp
LmMNCj4gaW5kZXggOGFmMGFmYmU5ZTNkLi43ZDM4ZTk1MDA3MDAgMTAwNjQ0DQo+IC0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHNpLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJt
L21lZGlhdGVrL210a19kc2kuYw0KPiBAQCAtMzUxLDQwICszNTEsNiBAQCBzdGF0aWMgdm9pZCBt
dGtfZHNpX3NldF92bV9jbWQoc3RydWN0IG10a19kc2kNCj4gKmRzaSkNCj4gIAltdGtfZHNpX21h
c2soZHNpLCBEU0lfVk1fQ01EX0NPTiwgVFNfVkZQX0VOLCBUU19WRlBfRU4pOw0KPiAgfQ0KPiAg
DQo+IC1zdGF0aWMgdm9pZCBtdGtfZHNpX3BzX2NvbnRyb2xfdmFjdChzdHJ1Y3QgbXRrX2RzaSAq
ZHNpKQ0KPiAtew0KPiAtCXN0cnVjdCB2aWRlb21vZGUgKnZtID0gJmRzaS0+dm07DQo+IC0JdTMy
IGRzaV9idWZfYnBwLCBwc193YzsNCj4gLQl1MzIgcHNfYnBwX21vZGU7DQo+IC0NCj4gLQlpZiAo
ZHNpLT5mb3JtYXQgPT0gTUlQSV9EU0lfRk1UX1JHQjU2NSkNCj4gLQkJZHNpX2J1Zl9icHAgPSAy
Ow0KPiAtCWVsc2UNCj4gLQkJZHNpX2J1Zl9icHAgPSAzOw0KPiAtDQo+IC0JcHNfd2MgPSB2bS0+
aGFjdGl2ZSAqIGRzaV9idWZfYnBwOw0KPiAtCXBzX2JwcF9tb2RlID0gcHNfd2M7DQo+IC0NCj4g
LQlzd2l0Y2ggKGRzaS0+Zm9ybWF0KSB7DQo+IC0JY2FzZSBNSVBJX0RTSV9GTVRfUkdCODg4Og0K
PiAtCQlwc19icHBfbW9kZSB8PSBQQUNLRURfUFNfMjRCSVRfUkdCODg4Ow0KPiAtCQlicmVhazsN
Cj4gLQljYXNlIE1JUElfRFNJX0ZNVF9SR0I2NjY6DQo+IC0JCXBzX2JwcF9tb2RlIHw9IExPT1NF
TFlfUFNfMjRCSVRfUkdCNjY2Ow0KPiAtCQlicmVhazsNCj4gLQljYXNlIE1JUElfRFNJX0ZNVF9S
R0I2NjZfUEFDS0VEOg0KPiAtCQlwc19icHBfbW9kZSB8PSBQQUNLRURfUFNfMThCSVRfUkdCNjY2
Ow0KPiAtCQlicmVhazsNCj4gLQljYXNlIE1JUElfRFNJX0ZNVF9SR0I1NjU6DQo+IC0JCXBzX2Jw
cF9tb2RlIHw9IFBBQ0tFRF9QU18xNkJJVF9SR0I1NjU7DQo+IC0JCWJyZWFrOw0KPiAtCX0NCj4g
LQ0KPiAtCXdyaXRlbCh2bS0+dmFjdGl2ZSwgZHNpLT5yZWdzICsgRFNJX1ZBQ1RfTkwpOw0KPiAt
CXdyaXRlbChwc19icHBfbW9kZSwgZHNpLT5yZWdzICsgRFNJX1BTQ1RSTCk7DQo+IC0Jd3JpdGVs
KHBzX3djLCBkc2ktPnJlZ3MgKyBEU0lfSFNUWF9DS0xfV0MpOw0KPiAtfQ0KPiAtDQo+ICBzdGF0
aWMgdm9pZCBtdGtfZHNpX3J4dHhfY29udHJvbChzdHJ1Y3QgbXRrX2RzaSAqZHNpKQ0KPiAgew0K
PiAgCXUzMiB0bXBfcmVnOw0KPiBAQCAtNDE2LDM2ICszODIsNDAgQEAgc3RhdGljIHZvaWQgbXRr
X2RzaV9yeHR4X2NvbnRyb2woc3RydWN0IG10a19kc2kNCj4gKmRzaSkNCj4gIAl3cml0ZWwodG1w
X3JlZywgZHNpLT5yZWdzICsgRFNJX1RYUlhfQ1RSTCk7DQo+ICB9DQo+ICANCj4gLXN0YXRpYyB2
b2lkIG10a19kc2lfcHNfY29udHJvbChzdHJ1Y3QgbXRrX2RzaSAqZHNpKQ0KPiArc3RhdGljIHZv
aWQgbXRrX2RzaV9wc19jb250cm9sKHN0cnVjdCBtdGtfZHNpICpkc2ksIGJvb2wNCj4gY29uZmln
X3ZhY3QpDQo+ICB7DQo+IC0JdTMyIGRzaV90bXBfYnVmX2JwcDsNCj4gLQl1MzIgdG1wX3JlZzsN
Cj4gKwlzdHJ1Y3QgdmlkZW9tb2RlICp2bSA9ICZkc2ktPnZtOw0KPiArCXUzMiBkc2lfYnVmX2Jw
cCwgcHNfd2M7DQo+ICsJdTMyIHBzX2JwcF9tb2RlOw0KPiArDQo+ICsJaWYgKGRzaS0+Zm9ybWF0
ID09IE1JUElfRFNJX0ZNVF9SR0I1NjUpDQo+ICsJCWRzaV9idWZfYnBwID0gMjsNCj4gKwllbHNl
DQo+ICsJCWRzaV9idWZfYnBwID0gMzsNCj4gKw0KPiArCXBzX3djID0gdm0tPmhhY3RpdmUgKiBk
c2lfYnVmX2JwcDsNCj4gKwlwc19icHBfbW9kZSA9IHBzX3djOw0KPiAgDQo+ICAJc3dpdGNoIChk
c2ktPmZvcm1hdCkgew0KPiAgCWNhc2UgTUlQSV9EU0lfRk1UX1JHQjg4ODoNCj4gLQkJdG1wX3Jl
ZyA9IFBBQ0tFRF9QU18yNEJJVF9SR0I4ODg7DQo+IC0JCWRzaV90bXBfYnVmX2JwcCA9IDM7DQo+
ICsJCXBzX2JwcF9tb2RlIHw9IFBBQ0tFRF9QU18yNEJJVF9SR0I4ODg7DQo+ICAJCWJyZWFrOw0K
PiAgCWNhc2UgTUlQSV9EU0lfRk1UX1JHQjY2NjoNCj4gLQkJdG1wX3JlZyA9IExPT1NFTFlfUFNf
MjRCSVRfUkdCNjY2Ow0KPiAtCQlkc2lfdG1wX2J1Zl9icHAgPSAzOw0KPiArCQlwc19icHBfbW9k
ZSB8PSBMT09TRUxZX1BTXzI0QklUX1JHQjY2NjsNCj4gIAkJYnJlYWs7DQo+ICAJY2FzZSBNSVBJ
X0RTSV9GTVRfUkdCNjY2X1BBQ0tFRDoNCj4gLQkJdG1wX3JlZyA9IFBBQ0tFRF9QU18xOEJJVF9S
R0I2NjY7DQo+IC0JCWRzaV90bXBfYnVmX2JwcCA9IDM7DQo+ICsJCXBzX2JwcF9tb2RlIHw9IFBB
Q0tFRF9QU18xOEJJVF9SR0I2NjY7DQo+ICAJCWJyZWFrOw0KPiAgCWNhc2UgTUlQSV9EU0lfRk1U
X1JHQjU2NToNCj4gLQkJdG1wX3JlZyA9IFBBQ0tFRF9QU18xNkJJVF9SR0I1NjU7DQo+IC0JCWRz
aV90bXBfYnVmX2JwcCA9IDI7DQo+IC0JCWJyZWFrOw0KPiAtCWRlZmF1bHQ6DQo+IC0JCXRtcF9y
ZWcgPSBQQUNLRURfUFNfMjRCSVRfUkdCODg4Ow0KPiAtCQlkc2lfdG1wX2J1Zl9icHAgPSAzOw0K
PiArCQlwc19icHBfbW9kZSB8PSBQQUNLRURfUFNfMTZCSVRfUkdCNTY1Ow0KPiAgCQlicmVhazsN
Cj4gIAl9DQo+ICANCj4gLQl0bXBfcmVnICs9IGRzaS0+dm0uaGFjdGl2ZSAqIGRzaV90bXBfYnVm
X2JwcCAmIERTSV9QU19XQzsNCj4gLQl3cml0ZWwodG1wX3JlZywgZHNpLT5yZWdzICsgRFNJX1BT
Q1RSTCk7DQo+ICsJaWYgKGNvbmZpZ192YWN0KSB7DQo+ICsJCXdyaXRlbCh2bS0+dmFjdGl2ZSwg
ZHNpLT5yZWdzICsgRFNJX1ZBQ1RfTkwpOw0KPiArCQl3cml0ZWwocHNfd2MsIGRzaS0+cmVncyAr
IERTSV9IU1RYX0NLTF9XQyk7DQo+ICsJfQ0KPiArCXdyaXRlbChwc19icHBfbW9kZSwgZHNpLT5y
ZWdzICsgRFNJX1BTQ1RSTCk7DQo+ICB9DQo+ICANCj4gIHN0YXRpYyB2b2lkIG10a19kc2lfY29u
ZmlnX3Zkb190aW1pbmcoc3RydWN0IG10a19kc2kgKmRzaSkNCj4gQEAgLTUyMSw3ICs0OTEsNyBA
QCBzdGF0aWMgdm9pZCBtdGtfZHNpX2NvbmZpZ192ZG9fdGltaW5nKHN0cnVjdA0KPiBtdGtfZHNp
ICpkc2kpDQo+ICAJd3JpdGVsKGhvcml6b250YWxfYmFja3BvcmNoX2J5dGUsIGRzaS0+cmVncyAr
IERTSV9IQlBfV0MpOw0KPiAgCXdyaXRlbChob3Jpem9udGFsX2Zyb250cG9yY2hfYnl0ZSwgZHNp
LT5yZWdzICsgRFNJX0hGUF9XQyk7DQo+ICANCj4gLQltdGtfZHNpX3BzX2NvbnRyb2woZHNpKTsN
Cj4gKwltdGtfZHNpX3BzX2NvbnRyb2woZHNpLCBmYWxzZSk7DQo+ICB9DQo+ICANCj4gIHN0YXRp
YyB2b2lkIG10a19kc2lfc3RhcnQoc3RydWN0IG10a19kc2kgKmRzaSkNCj4gQEAgLTY2Niw3ICs2
MzYsNyBAQCBzdGF0aWMgaW50IG10a19kc2lfcG93ZXJvbihzdHJ1Y3QgbXRrX2RzaSAqZHNpKQ0K
PiAgCW10a19kc2lfcmVzZXRfZW5naW5lKGRzaSk7DQo+ICAJbXRrX2RzaV9waHlfdGltY29uZmln
KGRzaSk7DQo+ICANCj4gLQltdGtfZHNpX3BzX2NvbnRyb2xfdmFjdChkc2kpOw0KPiArCW10a19k
c2lfcHNfY29udHJvbChkc2ksIHRydWUpOw0KPiAgCW10a19kc2lfc2V0X3ZtX2NtZChkc2kpOw0K
PiAgCW10a19kc2lfY29uZmlnX3Zkb190aW1pbmcoZHNpKTsNCj4gIAltdGtfZHNpX3NldF9pbnRl
cnJ1cHRfZW5hYmxlKGRzaSk7DQo=

