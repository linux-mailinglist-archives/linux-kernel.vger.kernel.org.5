Return-Path: <linux-kernel+bounces-122377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E47C88F5E3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 04:22:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 828301C24EA3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 03:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C9532C8C;
	Thu, 28 Mar 2024 03:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="WFQhKgCy";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="Ut7obdy3"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7CD249E5
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 03:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711596133; cv=fail; b=V1GDICBTLvWzOMFhtwIRWFTYonr6mUh5Bku4xt4cor2SDk2cMP4yFBZlg0l86ko/7WXaBXDH9Q7YjvVPJ5UN04r/AouWQ3Yv1A4rQybX1lEa4YfRFVxqFGZh2dtX4VNlnpvbQ/bZKiNhVkroJ6oBGA83+6QoDK/Zw05c/ndNinE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711596133; c=relaxed/simple;
	bh=bt9udtr2zDzzb51jIy8fpkSneJWFksysrvhi0sJPX8U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LSKy6VVEuTNP2/fnriPD/uaR5Dfdd3ZDrPEK2uLIplIWa0YHJLVD1ifcPFqRoZRUepzEOWH2W9e9rRFW4+wbxfOj16nB6icH4UcTsWxZhVxpi1Il0cSFz1Oli5rnyMDzdTovtLWXlIih1W0UrLbTxAm2wpVJSkwm7zScN600FeM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=WFQhKgCy; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=Ut7obdy3; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 5bf0178aecb211ee935d6952f98a51a9-20240328
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=bt9udtr2zDzzb51jIy8fpkSneJWFksysrvhi0sJPX8U=;
	b=WFQhKgCyizccpTZ78Wo7eQMlgZo3U5TZhd2PLgND83Qv9uULZdY+/2JXehgzDgHjHvM7gcqiAHr6aSbYxnhiiWGq6I0SOkZQy1fIf3VFUDdiAdlYual6DBIDJWTxcM2y8rYRPsTVH0gAcvHXREJhF3o6I+xlfUJ8lYhTEH1/cKI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:d35f8011-6a64-48cc-984b-558ac459a4e7,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:65826a00-c26b-4159-a099-3b9d0558e447,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 5bf0178aecb211ee935d6952f98a51a9-20240328
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <shawn.sung@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2107483430; Thu, 28 Mar 2024 11:22:08 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 28 Mar 2024 11:22:07 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 28 Mar 2024 11:22:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AG4zVFaAPwIBxkLQ1IASV6b/XskrfxQBSJO46+eNU8oSh09uBuakUAWGF9GHceElyC54xRf9j8xUDQ+wnnyP3/6CmmlepGMXrqirmAuprmV/TCHKx2e8ytY9sNU0N78tKffCU2cyLvVAPaD+n77rEnt4XhlFF36of0SN5O+mIwc+OuELMowzEIIIOQFM8ogBjEIJncgJHiYJ33LU3ngZvwBS6pzZcmRnvG2TqOtxxdO3TP5UDY5Ii1JnKRBPEF6BWbr2pQA7ykEKu38jDXkSpVzcrVvJAXo5q9QeIufJRlRs+ZPDHx8TS5OffFzQQWoCbjzfb4Sq11KxomfLI0lQ7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bt9udtr2zDzzb51jIy8fpkSneJWFksysrvhi0sJPX8U=;
 b=Hf/Zig/+z+0xo8EbgRFRK1hOGoS8niBgeiL6/2YmOwUaZtgJRtxpqcOd7HMMAP5fm6FGWadW2zp1LueUUsyPkSMLJNScAVQjHBdLutv/S9vgfwi9kzkcb6C2OaUgHUXXTeFR/UYajrQ2/6XWRPMv4zt/vwqCeK87Gu4JyJBIlGf22cNTBFbA0mlbAVDexHFhtqrjzusegMA5LN9CNguoihGamNh41BAGrlWWgERj5mso/TK0BJciNZK/oSk8u3v8Zg2rq553Qv0ZN+uECaZ5R1x4FzNe8Y0gAzV3ljuBIvRBBFwWkaBKpZ0jF6m/28P/b6oY1+peiJ/HYp5VulwHhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bt9udtr2zDzzb51jIy8fpkSneJWFksysrvhi0sJPX8U=;
 b=Ut7obdy3noAJEEt4LqMS6lhrEvJIN7tTf28k47ae4rUNqNKdJPtJJy7JQc5X2t79yJBByVGLricSvRjO1YO9gOsoq3CLL9eMO/fMbQwY3kCUOtX3Boc1PFsM47FqoTP9/2mtETUgDUS77Cq++2u+culKs7WbK3V9ZEseOPTQvkU=
Received: from TYZPR03MB6623.apcprd03.prod.outlook.com (2603:1096:400:1f5::13)
 by SEZPR03MB8382.apcprd03.prod.outlook.com (2603:1096:101:21f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 28 Mar
 2024 03:22:05 +0000
Received: from TYZPR03MB6623.apcprd03.prod.outlook.com
 ([fe80::8031:ae41:afdd:d0a4]) by TYZPR03MB6623.apcprd03.prod.outlook.com
 ([fe80::8031:ae41:afdd:d0a4%3]) with mapi id 15.20.7409.031; Thu, 28 Mar 2024
 03:22:05 +0000
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
Subject: Re: [PATCH v6 13/14] drm/mediatek: Support CRC in OVL
Thread-Topic: [PATCH v6 13/14] drm/mediatek: Support CRC in OVL
Thread-Index: AQHafBnuO4PNDjSVC0WyWj7wl6jxHrFJkM4AgAL1NAA=
Date: Thu, 28 Mar 2024 03:22:05 +0000
Message-ID: <aefd4d8dd456face2aaa69698e019345148c005d.camel@mediatek.com>
References: <20240322052829.9893-1-shawn.sung@mediatek.com>
	 <20240322052829.9893-14-shawn.sung@mediatek.com>
	 <10afc2842aea3700263c4accf0593b75e7209431.camel@mediatek.com>
In-Reply-To: <10afc2842aea3700263c4accf0593b75e7209431.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6623:EE_|SEZPR03MB8382:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NZzegJnkOnx1yOyOFan2lPf3nTm1cozQfHhyDh6z2Gtetfv33vklegqVaI2ZPkGXcmKvTKL7BYrS68SPuVhfZo9jAE1wxynf1Kxs1hRXUw0/fgKNUE5A5jAUtxUi38aAUtbgTCYSQwdvaeXhiEHDrk2D8F/DjAhfHAHa/CrDndfF9PKuMlQcz1m4yxRFnLCA1I/V9nRDfnNPQU4xA37njmvw2hmx4D4V5xMuzZ2ZBa2BElBEDF28DHl9v+Nn3AvRkDN6rCfAbxbuVlpI+CAUIoDwQYjdxGZ/hekapcskMEJq2N/jWH8YS/Q+AcfScVYAZjQJarVclQUjnywox6YBn3K4joP5bmF07Ita4jpNVspz39g1pcLOeH8nJXVMco/PzidJK2DB93y6KLmcch+++TAGMxlBxaWtNy4Odynh9eCPoxVEfKy9bSULzvqbhpojWHEjWJhkQlzRdjAAWqZN47PA/eTAk7+yItpO3Wt/JtGFZYy9VU1wP22HhyrPCXFjbqBuatm05juzlL1qNcMfPy2/iwvYAte6lWpmqTPOk2uYVk2hGgm0r6rzX+QyaXaqU8F1RnR35TOL8HVL6erkC/5jYET3PDI156Oz2HfvCveD6xJHeRjgVz5h24XcdLU9RBj0DNwih++WQugvG2OT1d3W+Hdjx1Lt2bQTw94z6mw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6623.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(366007)(1800799015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aHJXTStJdnBOTnV1MjVlN3ZGbzFoSXhuRllLeWxnUUJYWExISGhiOXVvOFFn?=
 =?utf-8?B?aFpLNHlwcDlqTDQ1dHRxSExCZDI1dkNIWGNJcFVCaHlQYXRFWFJsaWVYajg2?=
 =?utf-8?B?c3NFN1Q0M2pZbDZmMEFJdkkvYm56eG16RkhBT0ZONUgrZHhFWEpWVmhQNW1E?=
 =?utf-8?B?MFkxdStmbC9GcXlvWEdRWGM1VDQrWEIvaVM3WEhWeVc0MENiYlQyaEZZSFBM?=
 =?utf-8?B?NmNNU2xOK1BZNUxzL0FWbkYzK2hDMzArRzQvSzdFZkE2QXZWV0k1M3JZdnlV?=
 =?utf-8?B?RFluZTZkY1FQN1ZsUUdTZVRRYnFOamVKY2tuZnNJb2UwTnVxZk0xVUsxQk5V?=
 =?utf-8?B?L2N2VFBDcld2eVNSY0dNV0gwOExGWTJRWUp3a3A0ekdWOHE4R2gzWnFCbjN2?=
 =?utf-8?B?dEdPa1RhbkVWM1NmVzVlUWFLamM4SkFvSEJrcW54NCt4VzZJQ3ZSRXNTQ0Jx?=
 =?utf-8?B?TkpNYU8zR0VtTjNXVGQzNDBwNkRHRldGZWUyZXpvSDBObE9sZG5xQ1JFcGcy?=
 =?utf-8?B?YnJMWlJkTFlNeFlEUk5MQWVybVIweUNoQm9HUmZhMVdmKzNlY2hzdnh4MThi?=
 =?utf-8?B?UURuSzAvYk11WEl1THE4ZTE1WTc3bGNZQ3dQbkdhSW0vM3VsTUtuSTdrL3FF?=
 =?utf-8?B?TFZXMXJGTjg2bE52YllVVm9jUGg2c2lmZjNQaHFXQVNyOFY5SmoxeUFla1NV?=
 =?utf-8?B?dDhkeHJQRkU2UWJ5ekhlN2JwSWF0TVEyMEh6SVVaRnFqRkpIUHRBb3FEUmhH?=
 =?utf-8?B?MHVEZkp4TXVudVhFd1pCOGxpOS9qaTdDOWFFUVRiMTFSUjlqajVNUk42Z29y?=
 =?utf-8?B?Smk4aGR6REsrT1dJUGx5R1RQbGhmZjViZGxVM2lONk1oVnVRSktWaEF4YjJK?=
 =?utf-8?B?T2V4dXdURTlYR2JTanlaVUFYRGZuNk1xZnpJOGoxWVd1U0pzZlN4NVJuSmRs?=
 =?utf-8?B?VlhUN2NEalRhbWZFZ2pzaTFrOWs4UEJ0ZUpxVU5ibGl3R2dyTzhqQXpZY3RE?=
 =?utf-8?B?SVVSQkdzczlnMGFlNjgyUjRheDVSb1VzWXhpdHgyNDRFRmlCK21SVlVWTG5y?=
 =?utf-8?B?Z05XdGYzb2RzT0VuNnd2a3V0TENoaXhNU2h0b1FvOVFoMU5ZUFpqaUZqMGFt?=
 =?utf-8?B?K0JBUGd4ZE9SRE9nNmpwQW8xZEVxZ0Qxdko0UVJjVzRpd2pjRk1vdjR2Y2Jx?=
 =?utf-8?B?dmc0bHlqQzdDb1QzWmU2cDM4ZHBqU2JTSjBNbWNJakhQM2ErUEltUGlZOHdx?=
 =?utf-8?B?RVF2cGl2TTFoL3I1Q1lPbzhXOEEyRUp3Uk1RUGYybFlES1FmRjdCVGk3QW9m?=
 =?utf-8?B?dDUxdjAzS2Q5Yy9NTGU3NWtMYU5HV2JYelcxcGlZTmx0dytYL21ESUFEUlRW?=
 =?utf-8?B?UnFmem8xamRCVTR4dy9acnh0eGt3bjJIM3plK3cyRElUaUZtR2c1ekMrYUFm?=
 =?utf-8?B?R0U5bVpWVFJwZzR6TW9NV0dBbnF2S0Nia0tFYld3dmVlRFVycW14aHE1UXM1?=
 =?utf-8?B?ZlhtY1l2UEJCVlVOTWZ4Ym92ZlhVTzB2b0IxbTNrS0JUWkoyWUM0TXRxTTVG?=
 =?utf-8?B?a0NOS0k2eTNkOUNkS0tYZ08xaVErZUx1THZHY081QnU3cFpIanRGRkIxSmVt?=
 =?utf-8?B?bzZqV2Z3ZmRJUHlXcUR2bXFXKy80UmlnR2tlY2d4VjcyazNobWo1TUNNUm5q?=
 =?utf-8?B?dXpVNEtBSTk0SU9YbjBMWG9qMmJXOFFWSGhlT284TkhTUy9HeE1ud3o4LzZZ?=
 =?utf-8?B?RXJJb2hDbG5ZMzBZTVRSdUVoVHhBUzdhZnoxTVhhelhTM1Z3b0xQdWsyZWhB?=
 =?utf-8?B?dWtXdDdZdlkxSk1CKzJ0QjZqSGc3eHhKUDV6VUUvamFOWW9BdHd2VENTSHow?=
 =?utf-8?B?OUg4OUdrZTR0U2tsL2lVTnZJTC9heHM5dHJta0YrZndyUk13anlCRHFYajZU?=
 =?utf-8?B?K0FhOVJudFpaRTBDNHlpZXk3MDRMR2R1M0xJc3d2RGxTN0JNY3BlaGYvdUJm?=
 =?utf-8?B?ZnhuN3BteVplbWJnZ3VCNjdUWEEvcU5GemxBQ2I5WEZGa3RvRFI3UU9LdFBi?=
 =?utf-8?B?cEZ6N09aOThuc01xQ1VVK2lhMDl5eEFxell6UHRCL2laSUp4R0h1TWtDZTVo?=
 =?utf-8?B?OVFMK2JZL3dKK1VTMytDdG91eXdKeWtieWUxZ1VLcVRFbEZsUnE1SERQbjc2?=
 =?utf-8?B?c0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B949C712924B5E4F96A6710926743082@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6623.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6353828-e959-4a4a-514a-08dc4ed63e2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2024 03:22:05.2153
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: trSyerWfN01Kvuj7STdys7e9vHw1NSi6lnl/nMM9jrYkz1snKI7XtNvnBgM+SDtXNP2m/w4Jqy2QQT0DyO7xLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB8382

SGkgQ0ssDQoNCk9uIFR1ZSwgMjAyNC0wMy0yNiBhdCAwNjoxMSArMDAwMCwgQ0sgSHUgKOiDoeS/
iuWFiSkgd3JvdGU6DQo+ID4gQEAgLTQ4OCw2ICs1NjcsODMgQEAgdm9pZCBtdGtfb3ZsX2xheWVy
X2NvbmZpZyhzdHJ1Y3QgZGV2aWNlICpkZXYsDQo+ID4gdW5zaWduZWQgaW50IGlkeCwNCj4gPiAg
CSAgICAoc3RhdGUtPmJhc2UuZmIgJiYgIXN0YXRlLT5iYXNlLmZiLT5mb3JtYXQtPmhhc19hbHBo
YSkpDQo+ID4gIAkJaWdub3JlX3BpeGVsX2FscGhhID0gT1ZMX0NPTlNUX0JMRU5EOw0KPiA+ICAN
Cj4gPiArCS8qDQo+ID4gKwkgKiBPVkwgb25seSBzdXBwb3J0cyA4IGJpdHMgZGF0YSBpbiBDUkMg
Y2FsY3VsYXRpb24sIHRyYW5zZm9ybQ0KPiA+IDEwLWJpdA0KPiA+ICsJICogUkdCIHRvIDgtYml0
IFJHQiBieSBsZXZlcmFnaW5nIHRoZSBhYmlsaXR5IG9mIHRoZSBZMlIgKFlVVi0NCj4gPiB0by1S
R0IpDQo+ID4gKwkgKiBoYXJkd2FyZSB0byBtdWx0aXBseSBjb2VmZmljaWVudHMsIGFsdGhvdWdo
IHRoZXJlIGlzIG5vdGhpbmcNCj4gPiB0byBkbw0KPiA+ICsJICogd2l0aCB0aGUgWVVWIGZvcm1h
dC4NCj4gPiArCSAqLw0KPiA+ICsJaWYgKG92bC0+ZGF0YS0+c3VwcG9ydHNfY2xyZm10X2V4dCkg
ew0KPiA+ICsJCXUzMiB5MnJfY29lZiA9IDAsIHkycl9vZmZzZXQgPSAwLCByMnJfY29lZiA9IDAs
IGNzY19lbg0KPiA+ID0gMDsNCj4gPiArDQo+ID4gKwkJaWYgKGlzXzEwYml0X3JnYihmbXQpKSB7
DQo+ID4gKwkJCWNvbiB8PSBPVkxfQ09OX01UWF9BVVRPX0RJUyB8IE9WTF9DT05fTVRYX0VOIHwN
Cj4gPiBPVkxfQ09OX01UWF9QUk9HUkFNTUFCTEU7DQo+ID4gKw0KPiA+ICsJCQkvKg0KPiA+ICsJ
CQkgKiBZMlIgY29lZmZpY2llbnQgc2V0dGluZw0KPiA+ICsJCQkgKiBiaXQgMTMgaXMgMl4xLCBi
aXQgMTIgaXMgMl4wLCBiaXQgMTEgaXMgMl4tDQo+ID4gMSwNCj4gPiArCQkJICogYml0IDEwIGlz
IDJeLTIgPSAwLjI1DQo+ID4gKwkJCSAqLw0KPiA+ICsJCQl5MnJfY29lZiA9IEJJVCgxMCk7DQo+
ID4gKw0KPiA+ICsJCQkvKiAtMSBpbiAxMGJpdCAqLw0KPiA+ICsJCQl5MnJfb2Zmc2V0ID0gR0VO
TUFTSygxMCwgMCkgLSAxOw0KPiANCj4gSSBkb24ndCBrbm93IHdoeSBkbyB0aGlzPyBJZiBhbiBp
bnB1dCB2YWx1ZSBpcyAweDEwMCwgdGhlbg0KPiANCj4gMHgxMDAgcmlnaHQgc2hpdCAyIGJpdCBi
ZWNvbWUgMHg0MC4NCj4gMHg0MCAtIDEgPSAweDNmLg0KPiAweDNmIGxlZnQgc2hpZnQgMiBiaXQg
YmVjb21lIDB4ZmMuDQo+IA0KPiBTbyBpbnB1dCAweDEwMCBhbmQgb3V0cHV0IDB4ZmMuIFdoeT8N
Cj4gDQoNClRoZXJlIGlzIG5vIGlucHV0IGhlcmUsIGFsbCB0aGUgc2V0dGluZ3MgYXJlIGRpcmVj
dCBiaXQgYXNzaWdubWVudCwgYW5kDQphbGwgdGhlIHZhbHVlcyBhcmUgY2FsY3VsYXRlZCBieSB0
aGUgZGVzaWduZXIuIFRoZSBtYWluIHB1cnBvc2Ugb2YgaXQNCmlzIHRvIGNvbmZpZ3VyZSB0aGUg
WTJSIG1vZHVsZSB0byBiZSBhYmxlIHRvIHRyYW5zZm9ybSAxMGJpdCBSR0IgZm9ybWF0DQppbnRv
IDhiaXQgUkdCLCB3aGlsZSB0aGlzIGlzIG5vdCBZMlIgbW9kdWxlIGlzIG9yaWdpbmFsbHkgZGVz
aWduZWQgZm9yLg0KDQo+ID4gKw0KPiA+ICsJCQkvKg0KPiA+ICsJCQkgKiBSMlIgY29lZmZpY2ll
bnQgc2V0dGluZw0KPiA+ICsJCQkgKiBiaXQgMTkgaXMgMl4xLCBiaXQgMTggaXMgMl4wLCBiaXQg
MTcgaXMgMl4tDQo+ID4gMSwNCj4gPiArCQkJICogYml0IDIwIGlzIDJeMiA9IDQNCj4gPiArCQkJ
ICovDQo+ID4gKwkJCXIycl9jb2VmID0gQklUKDIwKTsNCj4gPiArDQo+ID4gKwkJCS8qIENTQ19F
TiBpcyBmb3IgUjJSICovDQo+ID4gKwkJCWNzY19lbiA9IE9WTF9DTFJGTVRfRVhUMV9DU0NfRU4o
aWR4KTsNCj4gPiArDQo+ID4gKwkJCS8qDQo+ID4gKwkJCSAqIDEuIFlVViBpbnB1dCBkYXRhIC0g
MSBhbmQgc2hpZnQgcmlnaHQgZm9yIDINCj4gPiBiaXRzIHRvIHJlbW92ZSBpdA0KPiA+ICsJCQkg
KiBbUiddICAgWzAuMjUgICAgMCAgICAwXSAgIFtZIGluIC0gMV0NCj4gPiArCQkJICogW0cnXSA9
IFsgICAwIDAuMjUgICAgMF0gKiBbVSBpbiAtIDFdDQo+ID4gKwkJCSAqIFtCJ10gICBbICAgMCAg
ICAwIDAuMjVdICAgW1YgaW4gLSAxXQ0KPiA+ICsJCQkgKg0KPiA+ICsJCQkgKiAyLiBzaGlmdCBs
ZWZ0IGZvciAyIGJpdCBsZXR0aW5nIHRoZSBsYXN0IDINCj4gPiBiaXRzIGJlY29tZSAwDQo+IA0K
PiBZb3UgdHJ1bmNhdGUgdGhlIGxhc3QgdHdvIGJpdCwgc28gc29tZSBxdWFsaXR5IGxvc3QuIEkg
dGhpbmsgdGhlDQo+IHF1YWxpdHkgaXMgbWFpbiBmdW5jdGlvbiBhbmQgQ1JDIGlzIGp1c3QgZm9y
IGRlYnVnLiBTbyBpdCdzIGJldHRlcg0KPiB0aGF0DQo+IGluIG5vcm1hbCBjYXNlIHdlIGtlZXAg
cXVhbGl0eSBhbmQgb25seSBmb3IgZGVidWcgdG8gbG9zdCB0aGUNCj4gcXVhbGl0eS4NCg0KR290
IGl0LiBXaWxsIG1vZGlmeSBpbiB0aGUgbmV4dCB2ZXJzaW9uIHRvIGVudGVyIHRoaXMgc2VjdGlv
biBvbmx5IGlmDQp3ZSBuZWVkIHRvIGNhbGN1bGF0ZSB0aGUgQ1JDLg0KDQo+IEkgaGF2ZSBhbm90
aGVyIHF1ZXN0aW9uLiBZb3UganVzdCB0cnVuY2F0ZSB0aGUgbGFzdCB0d28gYml0IGJ1dCBpdCBp
cw0KPiBzdGlsbCAxMCBiaXQgdmFsdWUsIHNvIENSQyBjb3VsZCBjYWxjdWxhdGUgdGhpcyAxMCBi
aXQgdmFsdWU/IEkgZG9uJ3QNCj4ga25vdyB3aHkgeW91IHNheSBDUkMganVzdCBmb3IgOCBiaXQ/
DQo+IA0KDQpZZXMsIGZvciBSR0IgZm9ybWF0LCBPVkwgY2FuIG9ubHkgaGFuZGxlIDhiaXQgcGVy
IGNoYW5uZWwgZm9yIENSQw0KY2FsY3VsYXRpb24sIHNvIEkgYXNzdW1lIHRoZXJlIG1heSBiZSBz
aW1pbGFyIGlzc3VlIGhhbmRsaW5nIDEwYml0IFlVVg0KZm9ybWF0cyAoUDAxMCkgaW4gdGhlIGZ1
dHVyZS4NCg0KVGhhbmtzLA0KU2hhd24NCg0K

