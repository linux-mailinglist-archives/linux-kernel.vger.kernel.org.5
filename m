Return-Path: <linux-kernel+bounces-108351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C64FE88097E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 03:14:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE11BB22B67
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 02:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C32846F;
	Wed, 20 Mar 2024 02:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="RIgLd5xK";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="fbBb6U09"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2297464;
	Wed, 20 Mar 2024 02:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710900883; cv=fail; b=gQxrwL15K0hRf/OTuaQnSRgKDxi6xNbZ646/x9ic1rxEveKP8Go2AbMIVXgS2jv9TMbYe1BE8tD+6OG96nauJdwXxpViAESEmoEdR07/4x6TagEEtOT7/2PnsCz1ZBFTMzqy74SyuYlalr0v5rTZ+66JcOjelp96ePvwfABqQn0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710900883; c=relaxed/simple;
	bh=kxEj6AOM/hXRU5BQl5D9tP538FqN1ZRCtQDV0KQ0yOg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=K0/7/hgEk17OxV25NhdU+j7jd31UQPPdrc9sX1auyHHUc+inOZYy0UjdvT8kYL5iYuofgPv8G3BTUFBjIeYEkOdk4/2fS8MOKQTmnJXach8lc+BqvtS1Xu7/Y+eGxMjYIainV1PJBgLcGwtRHJJYBzD1dVdRa0udUN3xpncqG9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=RIgLd5xK; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=fbBb6U09; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 98167b68e65f11eeb8927bc1f75efef4-20240320
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=kxEj6AOM/hXRU5BQl5D9tP538FqN1ZRCtQDV0KQ0yOg=;
	b=RIgLd5xKKUgB2bAC5xzk8gx9EmvAmTiqpP3sCiyCaqWLjff4SzUBaN1gi7uvu9uGOsXILT07GlnL5UIisePKMh9pWh8fBz4xa0GBceAl4hDdqqU0lNenf2SdZIKxClUtnF1mtYkB1LbnuzJVjNdb/MCLDedkqzJDqvV1LBBHevE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:c776f9f6-f48d-412a-bbeb-15ed16f5eeef,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:675e3385-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 98167b68e65f11eeb8927bc1f75efef4-20240320
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1363683418; Wed, 20 Mar 2024 10:14:34 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 20 Mar 2024 10:14:33 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 20 Mar 2024 10:14:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j4gzWyrPZn1sEtI52nsq3iKfviDAN3HrLmUEFaGrXAWnYDeHumdlcSep2DXNxt2ca9h1m653cL5Wj/9lKF3CU+1GUowJBchGFeBa2dbegaTiNoIsqzBC3zXkzVUQT4Z6EU0HMeY19Zat2phYHEaLS3CmZY5EyQgCxeH/6IjvVH1Nj/Gh2OSI8K0F1/e//yaDZi6UzBZ6gwCPZpF3ZvsNonQxvC2fTr/1ghL3sXDgz+rj3H1QoZNeG2beC0P5xvKHDtXPSz0Gi6ZDU07fXdMOAGwybgwcieKuh6+TL41a1gRhwzel5XJpM4thuCp8YE4tLGnd0eeQjSXonZyZunJytw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kxEj6AOM/hXRU5BQl5D9tP538FqN1ZRCtQDV0KQ0yOg=;
 b=aIRJqIm3fyVJCHS62aoZMmruiwIbaHoYWt4RQX+VLlJFxd8cLEi12McSAwL4fsQI466sKdCNAAQlvQXWD++KBwtlH43+ItQJL4/QKmC4nQwSLO86qPHomlHlF1chcDAnV2aeV9hm7wu9GMak/daXZTl1QtE/1lTTPRRQm2aKI+cawdkowyMm9nxU+yB6iKZpWajljjqlyGt94+XqFzMtMGDKxgA4uWG35hcrpphF9X4PskwdOrJqGsEmQAjTqT1TtsaCou+9mmQa7KECUzF+oZmjsV73oYm5Idt5Eetsf0ZdURh724DIuqz5xgziGqdLiGX7p3u/NFGC1/I+9G7xJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kxEj6AOM/hXRU5BQl5D9tP538FqN1ZRCtQDV0KQ0yOg=;
 b=fbBb6U09VEB9bivJLFnC22t7l1CgZr9heioSYsZ8tgmDM4p0xyFUpLc0/1cU3lmUb1zcO4EHuWXNpurbtn8SDr4QPLwWg05nxmTsO8vG5eBmiXrR8LhSM34xLySRucR3E2v8lGjr6YgpGO0sCdMXPoEk3Ib4GwbV5JZXj9DlrF0=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TYZPR03MB8167.apcprd03.prod.outlook.com (2603:1096:400:453::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.28; Wed, 20 Mar
 2024 02:14:30 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::f3b6:91a7:e0fb:cb27]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::f3b6:91a7:e0fb:cb27%7]) with mapi id 15.20.7386.025; Wed, 20 Mar 2024
 02:14:29 +0000
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
Subject: Re: [PATCH v2 12/14] drm/mediatek: Rename files "mtk_drm_gem.h" to
 "mtk_gem.h"
Thread-Topic: [PATCH v2 12/14] drm/mediatek: Rename files "mtk_drm_gem.h" to
 "mtk_gem.h"
Thread-Index: AQHaecu87RFDyRknmUebZdNYqMq4FrE/5RWA
Date: Wed, 20 Mar 2024 02:14:29 +0000
Message-ID: <6183bc80584eeb9a72b53f1c3ed3046a2541c0e2.camel@mediatek.com>
References: <20240319070257.6443-1-shawn.sung@mediatek.com>
	 <20240319070257.6443-13-shawn.sung@mediatek.com>
In-Reply-To: <20240319070257.6443-13-shawn.sung@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TYZPR03MB8167:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /eNtN/x3I8iBR6Gf7ZxKEGIICyGib0ippgzybqoow3suwtIOChXX2GuVw9zXgrdJKbnSHamkwpXK7Qrvo9GwdlWXuiGueKUHF9vl2MDhdeZLMo4he4nVHnzZUlGpLOlk5S3f5D33unS5U6tAv6r5HR/4UYC1sK/EIt8MFu0IyZp3RcDKpmKpPmqfHxRcbsFWHFfEZI+5BSDsgnZLLLUGL2m8NAKY7nJ2zB+F8cXkxWS+/eZzTY1u3hA74Qn9EsozdkoDfZzNG5iMeJ/RYoRxW1W+TMGS61oFTPT/QKoy3S9SqXtU81XbDT+Ni+YzF5aZuAAVBaZHXEafBzF7vrihUOtKPXrxHnoRWKcljXJtv2HOkNUOOcFSuurvoLNkG5v/Nl0jvEENlYb0HRwp/cHeXEPk4ke2nvu+LrIc4fE0PQVi8de6HZFPrph/jDTU8noXMUQFAvcHjfnlSGZmdcGIw5golXHYXICL4/ZenGLidSinzHsAS0HDFNLmguInKFS3hQU8giiNOWYjfSskemBmgjxOL3r1aR8fCjqLluzJyOwffO9l+guosnjEKBy79k6kw8CpHYzgf4iDcWrvwuE98yIWxd7oYxPfGV9T2kAUMQXeH2pP6Xk+EBuuaRHhKgfIaV2vm0+0UAnLiVBSxqggsBF+yaXshDhyQn0iWk+sccU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(366007)(376005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bWtKK0ljeTJtTUVTOWpsZnQ0bDZ6ckFiaForREJ4dXBZSUV4eTJjWDNjeVJs?=
 =?utf-8?B?bGFZQ0lHY1RyV3Y0cG9aRFJuL25JUk5mcThyM1VLMGpxQVZIc3NHVE45WGs1?=
 =?utf-8?B?WFBIYnkwc2lrN1RTL1BySjRnZTJHMnZBYTZyY3p2Y1MyNE56Y0ZOVk4za0lk?=
 =?utf-8?B?VkQxbmxibDd2TTdKeDYwblNMOS90dHNMeTVxWlVKcmJkb2xxVzZyYVNUdnVo?=
 =?utf-8?B?YmtieVpzWUxMVllwM2JNR1ExQWdMT2JTb3hmZXI4ejFZZENVU0Q0c3RLYS8x?=
 =?utf-8?B?OFRUN3JhMG83RzhTOTY4amNpREs4end0aEdoRUFGb0J4ZTZGbDJCZitydS92?=
 =?utf-8?B?SWJvSVBMTm5qOTZKMkdYNE84aWRhMFh0MG1UZnNTam50d3A2enpzSnFJVHlJ?=
 =?utf-8?B?NXR2ODAzSzU4ZGRtR2lkeU5RNVNUTldjMndFdllFZTZmWUJGSWVRLzE3V2Ri?=
 =?utf-8?B?aVh4alJUSFVuUWZ4TkdhNHJSUkVYdmxhZGh1NzBNenBINmNaN2tyL2tUZEJY?=
 =?utf-8?B?VVp0ejlyOHp1SlZrdjIwZGFSYjIwVloxUXVjZFQwR0F0ZWZ4My95cFJWcll3?=
 =?utf-8?B?U09uMGRYczFUQVh2OEFXWm5CUUtVM2FqcVUzODUwY3NoeGwzbFY4RDdvYXJm?=
 =?utf-8?B?SzJUSk5lZkducms2aTlPbVErbklST2ZjTldOS0RBVGJZY3hnZ3QyVWNpTy9R?=
 =?utf-8?B?VmV6SEZqYk83WEhwYkpUL2VtNVcxaTBDZ1N6czUxaGlFdDkyeVV0Qkx3N28w?=
 =?utf-8?B?bCtOQ2RvYzQvNDFhYXFSaFR5N09wUzA0UTh6VVRyZU1aZ0R2dXBtUXgxaWda?=
 =?utf-8?B?VGJ2emdyM1JvMTZuMVRMOC9yMzJ3TUFBc2RiTmJzMlQ3NnA3WkREUEF5OUow?=
 =?utf-8?B?bEdmMXN0ZzQ5ZWlmbkx5MU9TWm1WL1BuZDZ4SElQYkovRjVKWVd0U0VVeXcv?=
 =?utf-8?B?blJlV29yV2NBQklqYWlXdHE5YWh3TTFtV2JVVG1QRWVCWXp2VmFNcWxsVVhJ?=
 =?utf-8?B?RzZiUXdsSWF1M3R3QnMvQWRJU245SWlTRXdZT1lpQVZyelF1NVdUQnRlZ01F?=
 =?utf-8?B?b0FWaGJJUzZXbFNMMHBiSCtnL1ZncFd1NmIyejNkR3pYNlVJeWpFajlBWXVM?=
 =?utf-8?B?VUJhRjQ1dXlhK3VmNEpGeWgyclkveWRQalNEbjNUL1NvdWwxV2E0WDBDYTBa?=
 =?utf-8?B?ZXNmbFdYNDRQcUFtMmtkWXZKV0U3bXQvdEdONEtIRDM3Snhtbld4cHcrNDFj?=
 =?utf-8?B?ZFlET0M1V1FWdDkyZWMrWTV2azQ5M0hkZFNOWDBGcTVZbW5kUW1WSXA2b3ox?=
 =?utf-8?B?cjN3UW8wQ2NLMVU1TmErYlRTR2lSZlBxbThoR3ovVVQ3ZmF4OUt2VmNUTys1?=
 =?utf-8?B?RVYxYWxaU21jTjUxT2ZLOHBKcjM0ajJnVDZRU3lRVUlXZldIRHNQMjl0NGhC?=
 =?utf-8?B?T05ERGdVSHFWZ2EzekFtVlpHaGNvQTRweHZkNC8zcHBoZ3hnTnhzOWhOS09h?=
 =?utf-8?B?V1pLWVdDSUdHL0F5UitVOHVPVTF1ZDJUeklEY2N3SFdtdlNpTkRHUHR0MlNS?=
 =?utf-8?B?V093YVlnN1BmbEdYalJrNVZ6bWdtVmhrSjRKaXFvaG95MWZLNXJVa3JlRmE3?=
 =?utf-8?B?YjdmWFhuV2xKL29ibXJxeGQxUFF3S1hmRk5rSGUvZXB1YU15L0tFWEFsOFVz?=
 =?utf-8?B?WkpRZzlDdTExL1BicFVpZkU4SHVWeFdPSTh1aDVHZStPbGR2bExmbHZFeU0x?=
 =?utf-8?B?YWVtT2wvU3AxclJVUlk5RHgxZ2lPaG5zS2dsRGl6WGdrcHgvaWFMRWNCU2Vl?=
 =?utf-8?B?MzgvZXIrWklkV2gwY2hybWgrTzdnMzg0MkFISDhpU0tldlRsbTFTS1BQNk1L?=
 =?utf-8?B?a0hPcURXQkV4dWNGejFvQmhCYjZhNDNGb0JSZ3VsbHdGMVdsazEya1hwbnpZ?=
 =?utf-8?B?R2FvUDBFbVZWS3JJSk1UL3lnajIvT0Q4dmMzRUVNdE92ZTlSMGpYbTFEN3Mx?=
 =?utf-8?B?TkttWkdSSXZPN25scHVKdWZxbE5pbit0WE1tWGx5ZTNyYk9BSVRjWXVkZTFj?=
 =?utf-8?B?bGxFZXByQVYrZkNYL3dlR3RYUmFlNWlXUis1R1U4QjlZU1hycHFiZmFxSXFo?=
 =?utf-8?Q?bbSuqmKtxRD538UYNyS7tvvQq?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A636DE4408C42C47A699F0C5BA819A09@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 413d69f2-3ebc-4c82-4151-08dc488379af
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2024 02:14:29.9104
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PEySsdxs6/mxz0/kSRO1qT9SiP3y4a/ampXwBS0i8hF/kFl7bdo1999hVUcsFIwFCzCaaWOHC5IJomFD3sUZ8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB8167

SGksIFNoYXduOg0KDQpPbiBUdWUsIDIwMjQtMDMtMTkgYXQgMTU6MDIgKzA4MDAsIFNoYXduIFN1
bmcgd3JvdGU6DQo+IEZyb206IEhzaWFvIENoaWVuIFN1bmcgPHNoYXduLnN1bmdAbWVkaWF0ZWsu
Y29ycC1wYXJ0bmVyLmdvb2dsZS5jb20+DQo+IA0KPiBSZW5hbWUgZmlsZXMgbXRrX2RybV9nZW0u
aCB0byBtdGtfZ2VtLmguDQoNCkFmdGVyIG1vdmluZyByZXN0IHBhcnQgdG8gdGhpcyBwYXRjaCwN
Cg0KUmV2aWV3ZWQtYnk6IENLIEh1IDxjay5odUBtZWRpYXRlay5jb20+DQoNCj4gDQo+IFJldmll
d2VkLWJ5OiBBbmdlbG9HaWFvY2NoaW5vIERlbCBSZWdubyA8DQo+IGFuZ2Vsb2dpb2FjY2hpbm8u
ZGVscmVnbm9AY29sbGFib3JhLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogSHNpYW8gQ2hpZW4gU3Vu
ZyA8DQo+IHNoYXduLnN1bmdAbWVkaWF0ZWsuY29ycC1wYXJ0bmVyLmdvb2dsZS5jb20+DQo+IC0t
LQ0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19jcnRjLmMgICAgICAgICAgICAgICAg
ICAgfCAyICstDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kcnYuYyAgICAg
ICAgICAgICAgICB8IDIgKy0NCj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2dl
bS5jICAgICAgICAgICAgICAgIHwgMiArLQ0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL3tt
dGtfZHJtX2dlbS5oID0+IG10a19nZW0uaH0gfCAwDQo+ICA0IGZpbGVzIGNoYW5nZWQsIDMgaW5z
ZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4gIHJlbmFtZSBkcml2ZXJzL2dwdS9kcm0vbWVk
aWF0ZWsve210a19kcm1fZ2VtLmggPT4gbXRrX2dlbS5ofSAoMTAwJSkNCj4gDQo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2NydGMuYw0KPiBiL2RyaXZlcnMvZ3B1
L2RybS9tZWRpYXRlay9tdGtfY3J0Yy5jDQo+IGluZGV4IDFiYTQ3ZTY1YTMyZGEuLmQ1OTc0ZmMx
YTcyOWEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfY3J0Yy5j
DQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfY3J0Yy5jDQo+IEBAIC0yMiw3
ICsyMiw3IEBADQo+ICAjaW5jbHVkZSAibXRrX2NydGMuaCINCj4gICNpbmNsdWRlICJtdGtfZGRw
X2NvbXAuaCINCj4gICNpbmNsdWRlICJtdGtfZHJtX2Rydi5oIg0KPiAtI2luY2x1ZGUgIm10a19k
cm1fZ2VtLmgiDQo+ICsjaW5jbHVkZSAibXRrX2dlbS5oIg0KPiAgI2luY2x1ZGUgIm10a19wbGFu
ZS5oIg0KPiAgDQo+ICAvKg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVr
L210a19kcm1fZHJ2LmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kcnYu
Yw0KPiBpbmRleCAxMTNmZGJhYWM1YTE0Li5iNjIzMjBmNjQ4ODI1IDEwMDY0NA0KPiAtLS0gYS9k
cml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kcnYuYw0KPiArKysgYi9kcml2ZXJzL2dw
dS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kcnYuYw0KPiBAQCAtMjcsNyArMjcsNyBAQA0KPiAgI2lu
Y2x1ZGUgIm10a19jcnRjLmgiDQo+ICAjaW5jbHVkZSAibXRrX2RkcF9jb21wLmgiDQo+ICAjaW5j
bHVkZSAibXRrX2RybV9kcnYuaCINCj4gLSNpbmNsdWRlICJtdGtfZHJtX2dlbS5oIg0KPiArI2lu
Y2x1ZGUgIm10a19nZW0uaCINCj4gIA0KPiAgI2RlZmluZSBEUklWRVJfTkFNRSAibWVkaWF0ZWsi
DQo+ICAjZGVmaW5lIERSSVZFUl9ERVNDICJNZWRpYXRlayBTb0MgRFJNIg0KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZ2VtLmMNCj4gYi9kcml2ZXJzL2dw
dS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9nZW0uYw0KPiBpbmRleCA0NDVmZDhhOGI4OTg4Li4xNjZh
NzFkYzQwODYwIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Ry
bV9nZW0uYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9nZW0uYw0K
PiBAQCAtMTIsNyArMTIsNyBAQA0KPiAgI2luY2x1ZGUgPGRybS9kcm1fcHJpbWUuaD4NCj4gIA0K
PiAgI2luY2x1ZGUgIm10a19kcm1fZHJ2LmgiDQo+IC0jaW5jbHVkZSAibXRrX2RybV9nZW0uaCIN
Cj4gKyNpbmNsdWRlICJtdGtfZ2VtLmgiDQo+ICANCj4gIHN0YXRpYyBpbnQgbXRrX2dlbV9vYmpl
Y3RfbW1hcChzdHJ1Y3QgZHJtX2dlbV9vYmplY3QgKm9iaiwgc3RydWN0DQo+IHZtX2FyZWFfc3Ry
dWN0ICp2bWEpOw0KPiAgDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsv
bXRrX2RybV9nZW0uaA0KPiBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZ2VtLmgNCj4g
c2ltaWxhcml0eSBpbmRleCAxMDAlDQo+IHJlbmFtZSBmcm9tIGRyaXZlcnMvZ3B1L2RybS9tZWRp
YXRlay9tdGtfZHJtX2dlbS5oDQo+IHJlbmFtZSB0byBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsv
bXRrX2dlbS5oDQo=

