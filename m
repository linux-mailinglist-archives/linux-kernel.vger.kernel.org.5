Return-Path: <linux-kernel+bounces-102912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D982B87B84E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 08:10:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90ECA2830D7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 07:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F78EED5;
	Thu, 14 Mar 2024 07:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ECLeDMfS";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="JyFKj05g"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B496610940;
	Thu, 14 Mar 2024 07:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710400198; cv=fail; b=VhQd72o5yX6LdzK+h/sPeA9NQIridHJ7A/zlWhtxOjdtXqb28EP3zmB9VfxbbO1Ko2hqN0ompzWgZYTloaDffKDBNoU4qZtZM9ZoZUkl+GUrpDP66yI1BP7Oo1+ZQZpSRAOFxcq4KlE/vvJ2V6CAhVD7qnU7exLN5sOliO4jHZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710400198; c=relaxed/simple;
	bh=X9/opmN62PyEvJiS55LMc67VyBqn4hJVL9DjHm+XhYg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=t4tUVqLsSiGZEEr0SRnwZAcfD9YrBlgPB3lMFt9H52xI2dYdXas4WBvFh4CLC31UHLXcPo2N7powOWFyBB9Kv8wC7eXn3iMEsWxLGfnZZYN/DJt8JpAr7KbG2ET+mjHNyIXc0pQ86cQloaONTCgLMgYd4VbQoCPtxp6I8J2bw+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=ECLeDMfS; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=JyFKj05g; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: d7ac7b20e1d111eeb8927bc1f75efef4-20240314
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=X9/opmN62PyEvJiS55LMc67VyBqn4hJVL9DjHm+XhYg=;
	b=ECLeDMfSzRs7ls2eq++HIInh56SGL7MmwtHTYW5vXGC0zmBO0dol7yvYUmVSS0U7D/0nMQTnh66mVE1JeaYp1+XjWL9pcXkI8lQ15n3E6V6KR/N0jIgqyJXO66CbsV1DRMkVIbvTsrb0x4VbITdI8zoC6jETw05vx0hUc3SyHmE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:e28e79df-6bd1-4b1d-ab78-bf98ec21f08a,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:cd3ae2ff-c16b-4159-a099-3b9d0558e447,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: d7ac7b20e1d111eeb8927bc1f75efef4-20240314
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2126084868; Thu, 14 Mar 2024 15:09:47 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 14 Mar 2024 15:09:46 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 14 Mar 2024 15:09:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R9YyF+BkDsMQf1fBJg39i5zdLWI7QGWf8FTrCvSMa+YCaL+pXCT9tVsW3vxiuypovYR9UcVLnM9wlax8s0dTT99xhbFAoGtV+qxZTIRN4loBfPq9IlvXwIE2SriMLdjGHUtcNfnyd8Lz8l2dU/a0q++pqg7oATscYVePlGTQMNDwz4AYmjM/33Q/bbaXLqqTYE/HK/gF/TKc+BmziCDakodXGixTru6LiQnArVOKl3OdqujnfS1xMeqGFMsKjGa/ADyT7NUs3NTnsYAHKvK5EhsGEpxCQXroz2d8cBhVDzZxtQKskuNWpRWJTwYb/JkaEdg/riyE7eYNS639629M8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X9/opmN62PyEvJiS55LMc67VyBqn4hJVL9DjHm+XhYg=;
 b=W4u4+ABomj2VPfUjrxC93s6NLOA61+fvvRh+cqoeWkD/ZLhvkxy4Jp4aITklCxikqugP24l3g7FQCw0XJEV7s1oV/2H5HxCOFcNAuCphBlFmeVfpBoROcW2SrtKLlmTKfsS8r7pKsUsXQgQ4fo88+meam5Io+8wJY5Eke5UgCrw4GdbKyIQTeL4vMc5NloC5W54YoetXAtOhyJTP0dAtuOhKPUrBH/11kUIQs5CWvsQQXZti6f2xwj/0QSEKSLpHOENzfr2scXH5LEjU+UU0FJzy1RusYgQMiJkTzKivS4NF1BS/hZjyGe2FNM1ul+PnKq8UseVGAp3pLZ8E2RXBxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X9/opmN62PyEvJiS55LMc67VyBqn4hJVL9DjHm+XhYg=;
 b=JyFKj05gdJa7ehQTKjNrU0Q2RjQYvnOgf/Y00DCI2Ax6t0lYszNEzbNWoFUKpnxObM0cIyVRGv+/6Ohbd2RLxmp841O/4Yt+fGme8y04j2GtabPt5RND5Ylwrza15Djkqk5938L2Z44KveDv/ik1UScciZsMUHHiljaJPuww11k=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SI2PR03MB6509.apcprd03.prod.outlook.com (2603:1096:4:1a5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.21; Thu, 14 Mar
 2024 07:09:44 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::f3b6:91a7:e0fb:cb27]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::f3b6:91a7:e0fb:cb27%7]) with mapi id 15.20.7362.031; Thu, 14 Mar 2024
 07:09:44 +0000
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
Subject: Re: [PATCH 10/11] drm/mediatek: Rename mtk_ddp_comp functions
Thread-Topic: [PATCH 10/11] drm/mediatek: Rename mtk_ddp_comp functions
Thread-Index: AQHaaJEiUenNelPrlUuNb7KwPRpevLE27AqA
Date: Thu, 14 Mar 2024 07:09:44 +0000
Message-ID: <1497bc29a540de194751b2f7202f0ab0b8669787.camel@mediatek.com>
References: <20240226085059.26850-1-shawn.sung@mediatek.com>
	 <20240226085059.26850-11-shawn.sung@mediatek.com>
In-Reply-To: <20240226085059.26850-11-shawn.sung@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SI2PR03MB6509:EE_
x-ms-office365-filtering-correlation-id: 64c58667-e6dc-49bc-e5fd-08dc43f5b9ed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wrnqxyrRTVv1GltXl5ngDpGij6y24TBQDKxYLc7MWczm8+7kikXVVXogfOOYdZQe12I6ogbO9+FGFzVWMMQabWSG88Wb6Fzb30TEtKSmotwgFEA1mHyKNE3CdThv+qdzo/bx+rR7x0lTv+/gMLl0a4f6Bp1UwqlrARDLUK4N/xEQTao39zQxiWL8IULPFnmRlT+g97aFqvtTM+SoPPEdn1AeYl0n4BZ2p0uhzRSwS/DTLFHu5YP7Ss34ag5JjzvSgB31BzV7lxLtnnw2KiTitHXKesQg3tznuBHQqU8qBvYLAuRH66p2yfrD2AVu/qXrcU3A0Jcdsht6FD11X4Gog77Qg78pbU6/pkPLAOUb8ee2pmxtxdAokE2PwuP0HZgl3ELyLofiUQNifcVuAq/xARGr6+Qs3Zwb9r4Lsu8uBENc2m2f/ILbxlTnxlumX2jx7a/D/58WWyL77QYp7IRHmzLZhyHqQOzS/b3k1VYKe1Tsslyg9nROmESFxfdUNup5Cjvu/VgtwX9K7/NJne0dqp42sDM+e/ZjX1GBF9MoohXOFBwUtrBX6UErhwNm48fpj6TSU/pPslPXIIjbg355wAfsHyPaUSwF7T5vyztOYDjjU4xkgJpY6GLMTBvQbmTaG8zQ2qxP9ADNEDn/5m5IC1OSUQieVv+5BGZqNt79IZKmZz36UUs0DXDTy+mq0U8FvWNua2HOq94YZBZbVWekEw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WXNpZmw1UTdUbHhtUFV2SDJKR2t5RThaVnRjSEd3TVlQWTg5UERjNWYza0wr?=
 =?utf-8?B?c2JKV2lqY0huTVVzcUkwcUZDVFNmeVFqQ3dUdVRLdWRJc3RDZThHQ2c5ek16?=
 =?utf-8?B?SzZJYm1VNHJxaVlrcmtNblE5NjRmQzVsTUJRcW01U3NQNjY0bDFZQVlQUVJ1?=
 =?utf-8?B?NUtJSVBmTC8wQ3Y0ZVVpTDdlOG5GZWJNaGdZYkpqQmxhRzBzYkZTbmJkUUY1?=
 =?utf-8?B?YUM1SmVrQ2lWMkIvejY5MmZMcW8vRStKWXozSDVSU1lISnlsblVDb0RBSzlk?=
 =?utf-8?B?bmVoU0w0dDhwUlpBVlMrUTNZTUtpVEV3MFhNMS9xaXphR2gvSHdyUmZkb0U0?=
 =?utf-8?B?ZkFCUFhxbFBJWkhpT1dBcGoyemRBdEpseGxZSWNkbENLOTJTMXZxU25ZdG5Z?=
 =?utf-8?B?Z2lOQk5qdTFsTkJ1WU9mcm52WlY4cUY2L2RIbTd3enEyUjRNdlhUaHZwZFg1?=
 =?utf-8?B?WUxtRzg5VTBqaXdPRUkrd1FJQUwyOXAyMXVkVnV4c3hYeCtIVDB4YTBlZDRZ?=
 =?utf-8?B?Vm5ValFhNEJ5Z3BRa0JNSG00NGZzU201VEVFa3BoYlF2dzVpclFrV0FxRW9s?=
 =?utf-8?B?bVdIVnZTNGZUQmk0TXpDR1FwZHI5T0hCRWhtZzlzKytHdTZjNXYxVVZGeFZH?=
 =?utf-8?B?R0gwZjQzQnl5SEozS251THA4MjJKVUEvZ3l0SnYyMXNuclBEUFVVNG93Ujg5?=
 =?utf-8?B?a3ZnRXhHWUtab3FkaTNEQlgzZk9CdWw1aWl6ZjY5VXZiS2Nzb1lDZFhhUEIw?=
 =?utf-8?B?VGJib2dxa2J5US9VK0loakVoRDRrb1QyUVRESzVHSEg4akFIRS9jNTNSZ2J5?=
 =?utf-8?B?SzJDQnMrZ0EvVkg5NUVSZk5CY2V6NzlmeEo2VkNnYXFEMWE0bzNIN1Rzekh3?=
 =?utf-8?B?ZXpuSTh6amRDTk5DeDFYaGdnNlFlSnltZVE4V3pzR3lKOHF0aXIrcHA0dVc3?=
 =?utf-8?B?RHViUkF6WCsyVUtTS0dqZk50aUhqcXZ0b05mb3FPeCsxMEtpamcxWmFueFlw?=
 =?utf-8?B?Y0hsZ2lQa0swODV6MG1zb1pDVnBKMUdVVW5NczU2bnZRTGpIeFc4c0lyeStm?=
 =?utf-8?B?b1J5TXU1TXRkRVZxUVZ3RE90WTd2aUk2ZFExYitHUjJabVVSTTQvVWl2YUJN?=
 =?utf-8?B?b0R2VUdTK2hIMU9qOXdLbUE4aU5EMzVEdFJEc1AzclRkZkJrc0M3dkhTRU5l?=
 =?utf-8?B?alA4VEx3bkJVaUE5dVlhTTdSRUpFaGtWM3VWR003eklyQyt6US9tbUVvUkRN?=
 =?utf-8?B?aFVtN0ViRnhDTXZESGFIaTZhdHRVMCtNcTJpVWVFMzRrNjhicDJQN0YwclVD?=
 =?utf-8?B?TDMwTUhpSE5USjFVSnQ3c2k5MWZMRkJqNUV5MklrOGxrQ3RwdW1rODlNRWdH?=
 =?utf-8?B?bi9ZbUxiNDVYZHJwdFpMTzQxVkZvcDJoWk9oay9ORnJWZzFRR2VlZ1puSEJw?=
 =?utf-8?B?V1VCWVpoZU5ISHJtblhHS0VkVUdDcm0xQ2wzRGNiRDZ4WEh4a1YwM1FLM1FK?=
 =?utf-8?B?dUY2OHlYQTdtN0gwd084ZFdHZHFmbzVNMHVXT0h6R2lvdWxUNVFRa2NMUXU1?=
 =?utf-8?B?RGlKa1greEpCbU9SRzhWbC9zNUVENUJWM0pFMW9VN3YxSEU4NXlxSXpYZ25m?=
 =?utf-8?B?N2FPN0ovc0MvQUs1VFlMVmhxSm0rQ2Zia0E3cjNsMVE4QUk2aXZnb2ZEdXVx?=
 =?utf-8?B?VG52ZkowSlAyVmVOc2h3ZTI5RzA5MW9qNGNzZTlrZG13TkdwcWtGTWtSVDZi?=
 =?utf-8?B?T0FCczk2cFZibC9DRm5RdDJDVUpQVTVZMXN3Q3JqMDFsUndsUndicHFLanBi?=
 =?utf-8?B?OENHaUV1ZGN6aDVsNGN6ZHBXM2N6aUE2eEdXSWhsMmNqTWN0QWc2bGtNTlg1?=
 =?utf-8?B?M2R1RUVHa3ZBSG05Um5FcnZBU01RUE1MS1BuaEJZVS83Uisyam55MVpXQ3VV?=
 =?utf-8?B?dXA0a0ZxTjR2NHV3dUFWOGNINUNrQ0wwSGt3bFAzWFhxSXRRSWJ1TjUrNmM2?=
 =?utf-8?B?Nk9NNEMzQVdPR1R1aDZoeTA2RTMrUVhoOUhQbWhFQVhRc2UwYWRPckFPMitJ?=
 =?utf-8?B?bk1JU1VpMitiVC90VHUxSm9XNndYWkl2Wk9jY3ZrQkdLR3U0SE1XZ01zZHJh?=
 =?utf-8?B?K0ErYjA1b1MrdjBzVC82UCtHQXBURjk1d1poVVZVUlNHZkE0RS8wUDYxS0tB?=
 =?utf-8?B?Wnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2391CC393EDF174286949E388D8528FF@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64c58667-e6dc-49bc-e5fd-08dc43f5b9ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2024 07:09:44.4817
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nB+Z3cOCD+zPSZxXo7XcMU/dLcf1eIId73jaDVe0zPwoPL358QM6x7OBb8FIyde8j3dOfvTpipEpBBNsMTHx4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB6509

SGksIFNoYXduOg0KDQpPbiBNb24sIDIwMjQtMDItMjYgYXQgMTY6NTAgKzA4MDAsIFNoYXduIFN1
bmcgd3JvdGU6DQo+IEZyb206IEhzaWFvIENoaWVuIFN1bmcgPHNoYXduLnN1bmdAbWVkaWF0ZWsu
Y29ycC1wYXJ0bmVyLmdvb2dsZS5jb20+DQo+IA0KPiBSZW5hbWUgZnVuY3Rpb25zIG9mIG10a19k
ZHBfY29tcDoNCj4gLSBUbyBhbGlnbiB0aGUgbmFtaW5nIHJ1bGUNCj4gLSBUbyByZWR1Y2UgdGhl
IGNvZGUgc2l6ZQ0KDQpSZXZpZXdlZC1ieTogQ0sgSHUgPGNrLmh1QG1lZGlhdGVrLmNvbT4NCg0K
PiANCj4gU2lnbmVkLW9mZi1ieTogSHNpYW8gQ2hpZW4gU3VuZyA8DQo+IHNoYXduLnN1bmdAbWVk
aWF0ZWsuY29ycC1wYXJ0bmVyLmdvb2dsZS5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJt
L21lZGlhdGVrL210a19kZHBfY29tcC5jIHwgNDUgKysrKysrKysrKysrKystLS0tLS0tLS0NCj4g
LS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGRwX2NvbXAuaCB8ICAzICstDQo+
ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RwaS5jICAgICAgfCAgMiArLQ0KPiAgZHJp
dmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kc2kuYyAgICAgIHwgIDIgKy0NCj4gIDQgZmlsZXMg
Y2hhbmdlZCwgMjggaW5zZXJ0aW9ucygrKSwgMjQgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kZHBfY29tcC5jDQo+IGIvZHJpdmVy
cy9ncHUvZHJtL21lZGlhdGVrL210a19kZHBfY29tcC5jDQo+IGluZGV4IGFiODQ2YTlmOThjNS4u
ZjZkNDgyZDI3YzYzIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRr
X2RkcF9jb21wLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kZHBfY29t
cC5jDQo+IEBAIC00OTcsMTAgKzQ5NywxMCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG10a19kZHBf
Y29tcF9tYXRjaA0KPiBtdGtfZGRwX21hdGNoZXNbRERQX0NPTVBPTkVOVF9EUk1fSURfTUFYXQ0K
PiAgCVtERFBfQ09NUE9ORU5UX1dETUExXQkJPSB7IE1US19ESVNQX1dETUEsCQkNCj4gMSwgTlVM
TCB9LA0KPiAgfTsNCj4gIA0KPiAtc3RhdGljIGJvb2wgbXRrX2RybV9maW5kX2NvbXBfaW5fZGRw
KHN0cnVjdCBkZXZpY2UgKmRldiwNCj4gLQkJCQkgICAgIGNvbnN0IHVuc2lnbmVkIGludCAqcGF0
aCwNCj4gLQkJCQkgICAgIHVuc2lnbmVkIGludCBwYXRoX2xlbiwNCj4gLQkJCQkgICAgIHN0cnVj
dCBtdGtfZGRwX2NvbXAgKmRkcF9jb21wKQ0KPiArc3RhdGljIGJvb2wgbXRrX2RkcF9jb21wX2Zp
bmQoc3RydWN0IGRldmljZSAqZGV2LA0KPiArCQkJICAgICAgY29uc3QgdW5zaWduZWQgaW50ICpw
YXRoLA0KPiArCQkJICAgICAgdW5zaWduZWQgaW50IHBhdGhfbGVuLA0KPiArCQkJICAgICAgc3Ry
dWN0IG10a19kZHBfY29tcCAqZGRwX2NvbXApDQo+ICB7DQo+ICAJdW5zaWduZWQgaW50IGk7DQo+
ICANCj4gQEAgLTUxNCwxMCArNTE0LDEwIEBAIHN0YXRpYyBib29sIG10a19kcm1fZmluZF9jb21w
X2luX2RkcChzdHJ1Y3QNCj4gZGV2aWNlICpkZXYsDQo+ICAJcmV0dXJuIGZhbHNlOw0KPiAgfQ0K
PiAgDQo+IC1zdGF0aWMgdW5zaWduZWQgaW50IG10a19kcm1fZmluZF9jb21wX2luX2RkcF9jb25u
X3BhdGgoc3RydWN0IGRldmljZQ0KPiAqZGV2LA0KPiAtCQkJCQkJICAgICAgIGNvbnN0IHN0cnVj
dA0KPiBtdGtfZHJtX3JvdXRlICpyb3V0ZXMsDQo+IC0JCQkJCQkgICAgICAgdW5zaWduZWQgaW50
DQo+IG51bV9yb3V0ZXMsDQo+IC0JCQkJCQkgICAgICAgc3RydWN0DQo+IG10a19kZHBfY29tcCAq
ZGRwX2NvbXApDQo+ICtzdGF0aWMgdW5zaWduZWQgaW50IG10a19kZHBfY29tcF9maW5kX2luX3Jv
dXRlKHN0cnVjdCBkZXZpY2UgKmRldiwNCj4gKwkJCQkJICAgICAgIGNvbnN0IHN0cnVjdA0KPiBt
dGtfZHJtX3JvdXRlICpyb3V0ZXMsDQo+ICsJCQkJCSAgICAgICB1bnNpZ25lZCBpbnQgbnVtX3Jv
dXRlcywNCj4gKwkJCQkJICAgICAgIHN0cnVjdCBtdGtfZGRwX2NvbXANCj4gKmRkcF9jb21wKQ0K
PiAgew0KPiAgCWludCByZXQ7DQo+ICAJdW5zaWduZWQgaW50IGk7DQo+IEBAIC01NTQsMjYgKzU1
NCwzMSBAQCBpbnQgbXRrX2RkcF9jb21wX2dldF9pZChzdHJ1Y3QgZGV2aWNlX25vZGUNCj4gKm5v
ZGUsDQo+ICAJcmV0dXJuIC1FSU5WQUw7DQo+ICB9DQo+ICANCj4gLXVuc2lnbmVkIGludCBtdGtf
ZHJtX2ZpbmRfcG9zc2libGVfY3J0Y19ieV9jb21wKHN0cnVjdCBkcm1fZGV2aWNlDQo+ICpkcm0s
DQo+IC0JCQkJCQlzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ICt1bnNpZ25lZCBpbnQgbXRrX2ZpbmRf
cG9zc2libGVfY3J0Y3Moc3RydWN0IGRybV9kZXZpY2UgKmRybSwgc3RydWN0DQo+IGRldmljZSAq
ZGV2KQ0KPiAgew0KPiAgCXN0cnVjdCBtdGtfZHJtX3ByaXZhdGUgKnByaXZhdGUgPSBkcm0tPmRl
dl9wcml2YXRlOw0KPiAgCXVuc2lnbmVkIGludCByZXQgPSAwOw0KPiAgDQo+IC0JaWYgKG10a19k
cm1fZmluZF9jb21wX2luX2RkcChkZXYsIHByaXZhdGUtPmRhdGEtPm1haW5fcGF0aCwNCj4gcHJp
dmF0ZS0+ZGF0YS0+bWFpbl9sZW4sDQo+IC0JCQkJICAgICBwcml2YXRlLT5kZHBfY29tcCkpDQo+
ICsJaWYgKG10a19kZHBfY29tcF9maW5kKGRldiwNCj4gKwkJCSAgICAgIHByaXZhdGUtPmRhdGEt
Pm1haW5fcGF0aCwNCj4gKwkJCSAgICAgIHByaXZhdGUtPmRhdGEtPm1haW5fbGVuLA0KPiArCQkJ
ICAgICAgcHJpdmF0ZS0+ZGRwX2NvbXApKQ0KPiAgCQlyZXQgPSBCSVQoMCk7DQo+IC0JZWxzZSBp
ZiAobXRrX2RybV9maW5kX2NvbXBfaW5fZGRwKGRldiwgcHJpdmF0ZS0+ZGF0YS0+ZXh0X3BhdGgs
DQo+IC0JCQkJCSAgcHJpdmF0ZS0+ZGF0YS0+ZXh0X2xlbiwNCj4gcHJpdmF0ZS0+ZGRwX2NvbXAp
KQ0KPiArCWVsc2UgaWYgKG10a19kZHBfY29tcF9maW5kKGRldiwNCj4gKwkJCQkgICBwcml2YXRl
LT5kYXRhLT5leHRfcGF0aCwNCj4gKwkJCQkgICBwcml2YXRlLT5kYXRhLT5leHRfbGVuLA0KPiAr
CQkJCSAgIHByaXZhdGUtPmRkcF9jb21wKSkNCj4gIAkJcmV0ID0gQklUKDEpOw0KPiAtCWVsc2Ug
aWYgKG10a19kcm1fZmluZF9jb21wX2luX2RkcChkZXYsIHByaXZhdGUtPmRhdGEtDQo+ID50aGly
ZF9wYXRoLA0KPiAtCQkJCQkgIHByaXZhdGUtPmRhdGEtPnRoaXJkX2xlbiwNCj4gcHJpdmF0ZS0+
ZGRwX2NvbXApKQ0KPiArCWVsc2UgaWYgKG10a19kZHBfY29tcF9maW5kKGRldiwNCj4gKwkJCQkg
ICBwcml2YXRlLT5kYXRhLT50aGlyZF9wYXRoLA0KPiArCQkJCSAgIHByaXZhdGUtPmRhdGEtPnRo
aXJkX2xlbiwNCj4gKwkJCQkgICBwcml2YXRlLT5kZHBfY29tcCkpDQo+ICAJCXJldCA9IEJJVCgy
KTsNCj4gIAllbHNlDQo+IC0JCXJldCA9IG10a19kcm1fZmluZF9jb21wX2luX2RkcF9jb25uX3Bh
dGgoZGV2LA0KPiAtCQkJCQkJCSBwcml2YXRlLT5kYXRhLQ0KPiA+Y29ubl9yb3V0ZXMsDQo+IC0J
CQkJCQkJIHByaXZhdGUtPmRhdGEtDQo+ID5udW1fY29ubl9yb3V0ZXMsDQo+IC0JCQkJCQkJIHBy
aXZhdGUtDQo+ID5kZHBfY29tcCk7DQo+ICsJCXJldCA9IG10a19kZHBfY29tcF9maW5kX2luX3Jv
dXRlKGRldiwNCj4gKwkJCQkJCSBwcml2YXRlLT5kYXRhLQ0KPiA+Y29ubl9yb3V0ZXMsDQo+ICsJ
CQkJCQkgcHJpdmF0ZS0+ZGF0YS0NCj4gPm51bV9jb25uX3JvdXRlcywNCj4gKwkJCQkJCSBwcml2
YXRlLT5kZHBfY29tcCk7DQo+ICANCj4gIAlyZXR1cm4gcmV0Ow0KPiAgfQ0KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kZHBfY29tcC5oDQo+IGIvZHJpdmVycy9n
cHUvZHJtL21lZGlhdGVrL210a19kZHBfY29tcC5oDQo+IGluZGV4IGJhOTg1MjA2ZmRkMi4uMjYy
MzY2OTFjZTRjIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rk
cF9jb21wLmgNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kZHBfY29tcC5o
DQo+IEBAIC0zMjYsOCArMzI2LDcgQEAgc3RhdGljIGlubGluZSB2b2lkDQo+IG10a19kZHBfY29t
cF9lbmNvZGVyX2luZGV4X3NldChzdHJ1Y3QgbXRrX2RkcF9jb21wICpjb21wKQ0KPiAgDQo+ICBp
bnQgbXRrX2RkcF9jb21wX2dldF9pZChzdHJ1Y3QgZGV2aWNlX25vZGUgKm5vZGUsDQo+ICAJCQll
bnVtIG10a19kZHBfY29tcF90eXBlIGNvbXBfdHlwZSk7DQo+IC11bnNpZ25lZCBpbnQgbXRrX2Ry
bV9maW5kX3Bvc3NpYmxlX2NydGNfYnlfY29tcChzdHJ1Y3QgZHJtX2RldmljZQ0KPiAqZHJtLA0K
PiAtCQkJCQkJc3RydWN0IGRldmljZSAqZGV2KTsNCj4gK3Vuc2lnbmVkIGludCBtdGtfZmluZF9w
b3NzaWJsZV9jcnRjcyhzdHJ1Y3QgZHJtX2RldmljZSAqZHJtLCBzdHJ1Y3QNCj4gZGV2aWNlICpk
ZXYpOw0KPiAgaW50IG10a19kZHBfY29tcF9pbml0KHN0cnVjdCBkZXZpY2Vfbm9kZSAqY29tcF9u
b2RlLCBzdHJ1Y3QNCj4gbXRrX2RkcF9jb21wICpjb21wLA0KPiAgCQkgICAgICB1bnNpZ25lZCBp
bnQgY29tcF9pZCk7DQo+ICBlbnVtIG10a19kZHBfY29tcF90eXBlIG10a19kZHBfY29tcF9nZXRf
dHlwZSh1bnNpZ25lZCBpbnQgY29tcF9pZCk7DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vbWVkaWF0ZWsvbXRrX2RwaS5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19k
cGkuYw0KPiBpbmRleCA4NDc0NWVjOWRkN2MuLjBjODNhNDQwMDA4OCAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcGkuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9k
cm0vbWVkaWF0ZWsvbXRrX2RwaS5jDQo+IEBAIC04MDUsNyArODA1LDcgQEAgc3RhdGljIGludCBt
dGtfZHBpX2JpbmQoc3RydWN0IGRldmljZSAqZGV2LA0KPiBzdHJ1Y3QgZGV2aWNlICptYXN0ZXIs
IHZvaWQgKmRhdGEpDQo+ICAJCXJldHVybiByZXQ7DQo+ICAJfQ0KPiAgDQo+IC0JZHBpLT5lbmNv
ZGVyLnBvc3NpYmxlX2NydGNzID0NCj4gbXRrX2RybV9maW5kX3Bvc3NpYmxlX2NydGNfYnlfY29t
cChkcm1fZGV2LCBkcGktPmRldik7DQo+ICsJZHBpLT5lbmNvZGVyLnBvc3NpYmxlX2NydGNzID0g
bXRrX2ZpbmRfcG9zc2libGVfY3J0Y3MoZHJtX2RldiwNCj4gZHBpLT5kZXYpOw0KPiAgDQo+ICAJ
cmV0ID0gZHJtX2JyaWRnZV9hdHRhY2goJmRwaS0+ZW5jb2RlciwgJmRwaS0+YnJpZGdlLCBOVUxM
LA0KPiAgCQkJCURSTV9CUklER0VfQVRUQUNIX05PX0NPTk5FQ1RPUik7DQo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RzaS5jDQo+IGIvZHJpdmVycy9ncHUvZHJt
L21lZGlhdGVrL210a19kc2kuYw0KPiBpbmRleCBhOTA3MWM0ZGNlMGUuLjgxMWI3MzA1NjY4ZiAx
MDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kc2kuYw0KPiArKysg
Yi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RzaS5jDQo+IEBAIC04MzYsNyArODM2LDcg
QEAgc3RhdGljIGludCBtdGtfZHNpX2VuY29kZXJfaW5pdChzdHJ1Y3QgZHJtX2RldmljZQ0KPiAq
ZHJtLCBzdHJ1Y3QgbXRrX2RzaSAqZHNpKQ0KPiAgCQlyZXR1cm4gcmV0Ow0KPiAgCX0NCj4gIA0K
PiAtCWRzaS0+ZW5jb2Rlci5wb3NzaWJsZV9jcnRjcyA9DQo+IG10a19kcm1fZmluZF9wb3NzaWJs
ZV9jcnRjX2J5X2NvbXAoZHJtLCBkc2ktPmhvc3QuZGV2KTsNCj4gKwlkc2ktPmVuY29kZXIucG9z
c2libGVfY3J0Y3MgPSBtdGtfZmluZF9wb3NzaWJsZV9jcnRjcyhkcm0sIGRzaS0NCj4gPmhvc3Qu
ZGV2KTsNCj4gIA0KPiAgCXJldCA9IGRybV9icmlkZ2VfYXR0YWNoKCZkc2ktPmVuY29kZXIsICZk
c2ktPmJyaWRnZSwgTlVMTCwNCj4gIAkJCQlEUk1fQlJJREdFX0FUVEFDSF9OT19DT05ORUNUT1Ip
Ow0K

