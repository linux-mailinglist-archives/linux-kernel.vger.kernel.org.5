Return-Path: <linux-kernel+bounces-86053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 979E186BF0C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 03:36:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CA6328911C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 02:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF64E36AFE;
	Thu, 29 Feb 2024 02:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="IvJ0cF/H";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="PIrcVzM4"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85AFA22083;
	Thu, 29 Feb 2024 02:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709174158; cv=fail; b=CxZe56gMdRxuyEEGGcvhP0apBakyJuf9uSHXVnkg9aq65VDKDrrT2Z1dyr4zrRoDWT1SqDFzv0lD4sAoHzxrWCJc87qMvdt5sw7xW0wr7nitnr2zqVqiPypQt+cwPNgzJsQp/w5TPqDVKnvJ3vH54xdgNw6wkFdr1ZHSCVUjN+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709174158; c=relaxed/simple;
	bh=AkpE0ZCn2JGW7q5CviOsqwnCHrLo4hF76GAGC3wQI18=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sVxGd2FmM9jCHla/z7IBoXa8ikFu6FafJ9c1lCiDeiH0WnXrUc0cLtQ3HXSb//25rvNA6DBjUDcmWXtIhkdwDcOTa2V2RyUzUb94ZIkc1Rh/YhwyZv5JGWjnqDyiAVQbVxmmFzM3rctIAa6T/4+J7yWaB2a9n4v+2nVQJViOhDk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=IvJ0cF/H; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=PIrcVzM4; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 406be556d6ab11ee935d6952f98a51a9-20240229
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=AkpE0ZCn2JGW7q5CviOsqwnCHrLo4hF76GAGC3wQI18=;
	b=IvJ0cF/HbNPfXeQqdgAywSwkHQLFn3+VaUWikCzvWI4m+t3us+0IPLRW+rF1FBQXakCyleVX6StYdo1KymT8igZrcKzHwtVjTQGllXN6wIXI8So3eA7iFLgTebz84m4L5u/i2Tk8JC7RxthHVIiTBTevNHR0rplwlBtrfnFHm/c=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:2dcf149d-b930-4878-bca5-00126dc11dc6,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:7a036e84-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 406be556d6ab11ee935d6952f98a51a9-20240229
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <shawn.sung@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 446805824; Thu, 29 Feb 2024 10:35:50 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 29 Feb 2024 10:35:48 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 29 Feb 2024 10:35:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JCprWD6EKOtBhzJZocfxtCqk0SgWsV9b4a939yqTOu7BsGQQuVdApBmW3PLRkzVFCiZnLstTDg8mhDmbngKctXpgXqEmXLiFeK0wOZ13tNwwtVEgXw3FeY6SVUa1c/sNYf71cQ0rwXi1a5AbRLRV6y/puqGcVVAzKx9mcg8aZ5dPoYx4hBCVYMMvQhvyCiSkgsWn8ZMfiB6ZetR5BOKzQJw/uf45yDrc+82qhiL6Kc7phjcdUkDdXInoiq9OMFr4EEBFClUrBT4WgJmXl23c2Jrq16/7/8Yc8z4jCj6K8oL4QJz6P31xyiEckuPUIo28oJLlVxDsHujH/LrHqIqzGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AkpE0ZCn2JGW7q5CviOsqwnCHrLo4hF76GAGC3wQI18=;
 b=KsSc0GgkoXQ6cGooUKH+1lhrU4E4rMYm7jl+LyUAVoH+uOR8+R3QL4KoGbkFZ+i6JsQm8jywzAELtH3LPi6Rh6VbvvcVS49eqUw5oqiREP71KNVqzI2wxbaeXeoTJrrUeazaTCxanMapS80TvLH+LACsFf7LuS8p0XJd25wzxeCDE/khR8HBKvDKGQHuXIv9yVVDih4XxGnpoObeONNwpIcpAJ0pW0H0FH5KOIfkiQ0h45Kh1p8/EZO5SqWEm9zXbkNEVMSSLJCoyAB2BjtzPehSo8tMALlBp/sVw/a3EW6dTzCCqgHE3bjMRp+Va59dI/rSwuQQhc471NmU9Suf5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AkpE0ZCn2JGW7q5CviOsqwnCHrLo4hF76GAGC3wQI18=;
 b=PIrcVzM4+NNaJKAvwos6a5Tb4G5HGmqfpzCROGMGKCGQGz9ibHSh0x0SkS7sCJ1d+d3/O2mPBiAYlfzULg+N8ZQuJFco7avSX8+h/SiIN4GSllk6DrVb4+1FDFvRlue1cCbnMCDsI+puec+r29rGy12fjE+8stB360Ph4G+PCs4=
Received: from TYZPR03MB6623.apcprd03.prod.outlook.com (2603:1096:400:1f5::13)
 by SEYPR03MB8741.apcprd03.prod.outlook.com (2603:1096:101:20e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Thu, 29 Feb
 2024 02:35:46 +0000
Received: from TYZPR03MB6623.apcprd03.prod.outlook.com
 ([fe80::a93d:863e:c0fd:109b]) by TYZPR03MB6623.apcprd03.prod.outlook.com
 ([fe80::a93d:863e:c0fd:109b%6]) with mapi id 15.20.7316.039; Thu, 29 Feb 2024
 02:35:46 +0000
From: =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= <Shawn.Sung@mediatek.com>
To: "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "chunkuang.hu@kernel.org"
	<chunkuang.hu@kernel.org>
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
Subject: Re: [PATCH 11/11] drm/mediatek: Rename "pending_needs_vblank" to
 "needs_vblank"
Thread-Topic: [PATCH 11/11] drm/mediatek: Rename "pending_needs_vblank" to
 "needs_vblank"
Thread-Index: AQHaaLD4xeqFjc0jjU6FckQoqZSs6LEgnp0A
Date: Thu, 29 Feb 2024 02:35:46 +0000
Message-ID: <7ddb408b9491dfa38c3544f95453758378876652.camel@mediatek.com>
References: <20240226085059.26850-1-shawn.sung@mediatek.com>
	 <20240226085059.26850-12-shawn.sung@mediatek.com>
	 <e2f901aa-9d1b-4de9-ac18-7cfb57adb587@collabora.com>
In-Reply-To: <e2f901aa-9d1b-4de9-ac18-7cfb57adb587@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6623:EE_|SEYPR03MB8741:EE_
x-ms-office365-filtering-correlation-id: d7b55799-b813-4231-1dd2-08dc38cf227b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jRkf7IM9ziF50TLz0GYYDnpJZSMmFb1DX7pLO1b1NazwHooHDN+F/9d3MLE5D73uZrUAzKNkVoUH6CNCaEs208UjOLkXmkSZ5cTEt21V6YnlZ8EhFhIrDacwVRE6za9okFbJNC4w/sZzynP++sIyiBVPVCSqR4fEWEkYiy9/gV4/XPaxd6xlyFBU7LNFcCzejBE6j/CL7dcD83j2I0f4gscsdIzOLhUqxXgpCSpPyQWL/ayMlV6qmW09LLMR7mdkZvaaw5oJYICmn1mHifuv/dYShrlIlkBipLZMKIVZmB5k8FeON2ndwgjh+54W/iUu9lCJtuUxA3t2InCpPr2mehZxcdN8mn8L8/OxvTQn1KXcgwZPIKKmUx27CRJx/SJhGbc4o2pdSMt9YtNYIeD31eGKgHiPpekM5rRpDJ4oHHf0epAI88lRcpsGtGPVHCkE6r54eVHmQ/KojD+g6ShxVLt3cKfJ5RKFSqjjl0iPjmqv3nCnbpiL4r5wNFUsLmmFdOEccqF0BuUDHSKJ4uEQ0CiX5nfI3qo6ctiFi3ySBEhqdSSVavZkNxfbpoHjjT2PX150IB+PYgOC93E8qKCXLZNKm80QcQpwHV/xUnCc1Hktq9doAzzsxyB1DuhPfrQZbetlPJj1ohFaJIA6lOXY+arb8boHVEAwmt5vPjtll5IfiMDpFd3/umnmH4hVpPmUS44w4tLf8WeCCBWW21xhEw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6623.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Nk9KQjBmQ1B1YVlnQzhEOUZHWmV5dlU3UVZaTDArSk9OUUhmZDNrMnNYRkNC?=
 =?utf-8?B?RWRGVHVIK3RwZnYwS0pBSmtJUzI2c0JmTnlxVUptbFRpNjRFVGlNOVEzRjYw?=
 =?utf-8?B?cHFKZnFET0ZRb08zMklsdFBaNzlYa0pQTkkwejRGazBxUHh3RlBJRmZ5Wkdw?=
 =?utf-8?B?UytGTG4vanlnSlZoR05ZOUxLbm1vV1hKTno0WnhxU3g5eElFL2hBU3VDWjZw?=
 =?utf-8?B?ekJBeXJsOTNGOEhaWjVuY05VYXA1UjVpd1d6OUE5cVM5SjVHUUp2QlZCZUk3?=
 =?utf-8?B?d25iVFNjbkJDQVFEckNUdXR3c1lPWlhWdnMvNEpUeXdBeklSSm5CYXdqMEhw?=
 =?utf-8?B?cGdzU0FFODF1VUFab2hoODFzU2R0eGxMQ3lvZnlXdGNlYWJiY1gyWjZINUg1?=
 =?utf-8?B?MSs4N05tY3JmaFIvbmxqU2dMSSt4amNtUVpGdGRHaFJLN1hhYVZpNVdkYXJV?=
 =?utf-8?B?VlRDa2Z0MTJYNVY2Wk10V0Q1b3g0ZjdTRkQ0TVhHS0doK2tWQS80Tk1MTklj?=
 =?utf-8?B?SVBsWUdibHdrRDB6S3lDcktRL0tQWVNZZDk2UHlwVXF1L0xpbUlHNkFOTW1P?=
 =?utf-8?B?K1hHODYvTDhVeDNBZFFvMlVsakRtRHQwSjJPK25HaGtPNSs2WFR4TWFxWitv?=
 =?utf-8?B?YjRBaEVXWjlWcTk3MTg3Zi9XYjRPcy9FWGRwendoYllwbzV2MmdQWXpmM3M5?=
 =?utf-8?B?cGptV1hEVEVnMDJ2cFcvSmZXN3NyZGRzUHRESkNacHF0czBYOS8rRkFvRUht?=
 =?utf-8?B?TlFXbWg0WmRKUGlPQUl6WGlVOVA4REJxV3VVM3hZdytYNlJDeGJ2aEJ0RDlM?=
 =?utf-8?B?a242R3ZBS2kzVlJTVm9USTZQMFlJZmNKVWZsZzBTMUh0QkRxMmlGQjF1dUpi?=
 =?utf-8?B?dHRQRng1ZHRoY0l2cEtnamVuOXoxaUlRWnBhMkhyTEZuTjBiaWNSb2l4Rzd5?=
 =?utf-8?B?cU5GLzBUUHZJVW5CWGVyMnV4RXhrWDJRTCtDTWFtNmJrNnJxcGRMcGhKNmlh?=
 =?utf-8?B?TGFJMzRKenQrSmhXRmkvYThGeHlnNXhMYlVqZXZ0MHhWQnV4WlBVYTUyRlpp?=
 =?utf-8?B?R1pBb3M0bXNhbXpHNVBrV1hQaGkwTkNTS09YczZMSUlrZ3VCNU42eVAvZktv?=
 =?utf-8?B?YUZ0OWZNaTZxZVdhOVZpZE45TjJBYTFzdVF6ZnRjeDRFYkR1V09sL1RSVzJ5?=
 =?utf-8?B?WGE0eUZWM1hWZmU2NlBZVEw2RG1sVHhrT1R4NHZPRDJwSnI0elI4dVdiV1ZZ?=
 =?utf-8?B?azcrbnhmT2duRzNkeXNRdDhoYzVtVTJTWDlwYzFmWkhXdnVnM2UyNG93bnBM?=
 =?utf-8?B?SFpNblhoUkdoOExIbURZd2pDWmtyOG5LbUl6UWxjeGdpcHcyQVBxZGZsclBu?=
 =?utf-8?B?MWV2aHBsak9JamJQanhGVWZWcm4xNUF2KzEyd3VTTHMrM1I4bEhMYncxNWdW?=
 =?utf-8?B?N0Znd1lLZitOUzNHV0hHaTBrQXZnQWxid2RzWVlUaHZveTkyc1M0OUlhaUpa?=
 =?utf-8?B?RWYzQ3Q3TnFKcGNkdmtPZDAzWHlYSTRtZ1l5S2hIditwQWhld0s2QnNaRmJh?=
 =?utf-8?B?VVJQMUthUS9McGwvVWFEMTJVRUpkREpoemMwQkpnZ1ozZnQ5SWl0TEdnTzk1?=
 =?utf-8?B?TkZMaGI0QWttNk9kdWxGNnpkK3YzUEdXME8yYXhSLzBSSkJnclQ5UjUvL3lr?=
 =?utf-8?B?SXdvK2swMDNDdHJScVBFSDNTQVBvcUpCZU4xb3NFRDQ3ZHZRVHU3VThVUGEr?=
 =?utf-8?B?VEpzNjFqS0xzRzRTRWgvaVhvOUdvNnREbmt2WW9nZ2pQNXpONmloc1dlWUVk?=
 =?utf-8?B?M3V1ZlZiMVQvbDA5eXVKYkw2cnh2MERMZEVxcXJieEUwQUUveDA0UEtxQnFE?=
 =?utf-8?B?WWlNWGZ6Zks4emRZNHYzcjlsQUpqVFFCbmZTSEVINS92ZDdJcUdSY09vWTJL?=
 =?utf-8?B?eXVScno1cGRsVk5VVFdLcDh4RlFhTkJIcnRWZUtTWFd5S3ROWVZrakJmS3I2?=
 =?utf-8?B?K2Z1WWJhV0RNNlBiWTBnTVJzSzc3c2Ezb2NOemdDeXQ3d3I1b0FPb3ZDQ1Z3?=
 =?utf-8?B?VVNvUC9FajMxejhsczRYK2w5V1I0Q3dpNkdrblpTSzBTc0JIUUkvOTVnZGpN?=
 =?utf-8?B?SXlkVkxaUW1qU3h3UWpjME5CenhWbnJpaWhZdDFPRk56WHRORk9Xc1lDVHQv?=
 =?utf-8?B?L1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0C80C75499EBB442A93071499B715956@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6623.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7b55799-b813-4231-1dd2-08dc38cf227b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Feb 2024 02:35:46.7205
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s7BsjixPSui7UucYssu6x9Y8+Op3hQLMzERfq+eKXhhHN8AWLxDUgSEq1k95GffMOMxQuiS85cH41IShAXHhCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB8741
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--17.525600-8.000000
X-TMASE-MatchedRID: TDQWNTPftUDUL3YCMmnG4ir0r2wNA5jBI4bJHZSdxcuyrCkM9r1bWskU
	hKWc+gwPp2+PpVTz2PH89WDKQGB2Lkc58yUI8WvNOX8ug76mOgDVy4hHC3/gyAlbhF7ZTanLxsr
	6m7RljBEf0j67vOkvUOxNxR2T/za0Ily/lfs5uYnmAId+2bAQwn0tCKdnhB58pTwPRvSoXL1/Z2
	8OquhbSNq53H3pjszm0C1sQRfQzEHEQdG7H66TyOk/y0w7JiZo
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--17.525600-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	6B51FDF906AB65FCE5C8ADFB32EF1D6946E0C793B3810EF6C5637DD9C7DC178F2000:8

SGkgQW5nZWxvLA0KDQpPbiBNb24sIDIwMjQtMDItMjYgYXQgMTM6MzkgKzAxMDAsIEFuZ2Vsb0dp
b2FjY2hpbm8gRGVsIFJlZ25vIHdyb3RlOg0KPiBJbCAyNi8wMi8yNCAwOTo1MCwgU2hhd24gU3Vu
ZyBoYSBzY3JpdHRvOg0KPiA+IEZyb206IEhzaWFvIENoaWVuIFN1bmcgPHNoYXduLnN1bmdAbWVk
aWF0ZWsuY29ycC1wYXJ0bmVyLmdvb2dsZS5jb20NCj4gPiA+DQo+ID4gDQo+ID4gUmVuYW1lICJw
ZW5kaW5nX25lZWRzX3ZibGFuayIgdG8gIm5lZWRzX3ZibGFuayIgdG8gcmVkdWNlIHRoZSBjb2Rl
DQo+ID4gc2l6ZS4NCj4gPiANCj4gDQo+IFRoaXMgZGVjcmVhc2VzIGh1bWFuIHJlYWRhYmlsaXR5
IHRob3VnaCwgc28gSSB3b3VsZCBwcmVmZXIgdGhhdCB3ZQ0KPiBvbWl0IHRoaXMgb25lLg0KPiAN
Cg0KR290IGl0LiBXaWxsIGNoZWNrIGlmIHRoaXMgcGF0Y2ggc2hvdWxkIGJlIG9taXR0ZWQuDQoN
ClRoYW5rcywNClNoYXduDQo=

