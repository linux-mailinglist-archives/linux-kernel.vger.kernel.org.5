Return-Path: <linux-kernel+bounces-111208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA31388692E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 10:27:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1044E1F21B89
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 09:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F55E1CA8F;
	Fri, 22 Mar 2024 09:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="EPAxCihO";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="l2UFVdW7"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BB62233B
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 09:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711099635; cv=fail; b=OCtYR1N1xaiT47wzHPjx5avUKhs8tiAqMrjQWeyHUoD9NaZl2kuwMiWclRwk1yBGj2G6PjLkQO1BEEVJVv7MN6ZBEVuVolUAAW5bmDd8/BVv2+gn01rRcUUrpuMQXq+2gjaI5RIU6c1rWt2skaudtHb2EXmZ/Squllkr8MPJNcs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711099635; c=relaxed/simple;
	bh=N1uOw+gSjiXvN5Rei/CY+JW9yK7WDBu/Px5Lu4fzXjA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oFGGA7QYMKmqcK3uj0rvNE0jqLRBTumD/QPGx3MnB24SS2JZMkY4wewIm5MS/8s+aFQ7iP8MmOHYRLMtUGpzv+80FMIw7mXYU8NgZWUeSP98iaORLsYOzedTRyL6v8ClQEIBbrZvpZH9WQqxE8Szn9Z9tplvhhPTwvXX6jn00u0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=EPAxCihO; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=l2UFVdW7; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 58f00f64e82e11eeb8927bc1f75efef4-20240322
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=N1uOw+gSjiXvN5Rei/CY+JW9yK7WDBu/Px5Lu4fzXjA=;
	b=EPAxCihOSZbpW9tukqhcmXs9Tex+dehmx+EkoXCSplyQsb1Ywe951XCAbOF04WXAmxv+kJmGpTVrn1HOBkbnmnmu0JeibCS6FYF18COOJuFrt4SO0z1wziWwEB+JkYPhnQtIBUjqe7hK9YDK6P2oOPD70vtVTjA1c9pMD37cwj8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:e3523814-9fba-47bc-94cf-a1948f1496cd,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:85b94f85-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 58f00f64e82e11eeb8927bc1f75efef4-20240322
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 50323561; Fri, 22 Mar 2024 17:27:05 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 22 Mar 2024 17:27:03 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 22 Mar 2024 17:27:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y2zfd+1+jRb/IQJ5bIsBVOEao6as3A18nygHfO7XOVrHDXelFvKlsJn1HqOr5L+QP0pk+yajWvlC8B4YhMIE33NPl4iJA2lMTNvRzULTVG2SRb8015DDTC+MKNCNWC/FgfaPQTdTYSqMedCAxiVsElAblbD54A6JFDf5opfYmgtjaXBT1E0EMNDQLZZTEqlfmGrBHu193l87KpYRa5maNsFnliQp3IF8JHLBlwPMR9MEA97O0FkrHzFZ+V+QHdqDhj6P/UCRL0s1Ogbtwh7vxwkm1BQLFC9ufNPBLA+zyMVDKEo01HtyWRKlUuIpLF6er4WVTCqu296D9+UwcZ0CLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N1uOw+gSjiXvN5Rei/CY+JW9yK7WDBu/Px5Lu4fzXjA=;
 b=EcLiFGZxgS6OGYDfhsuR0N8jv5d3HAIm0rVF7LJF+CGIkpOzw7XALJZ9WZ+vDEZje7BGZj9DNmVeRkBDnFct2KyRgS+kgRekX+HAQ3aOzZTVp56NR41TzjNuFR+wMrmzySshCzgimEUBsf1bN2qXkVaB5OyMOcHCLs4dc+lzgEqgEjZSHvI0UmkD1B4F//jnKogZpKliXdj+FZTArBZ0O7b3dOd2gK3HL8hHTR+Do4jIZ3wyHS98C0v/btDsXi0tx5ZyTZeZzW/IRcLS/7hfnS65aBGnV1xAFvb7c0zgPktU3dxP/2b2qTYtKvxxWiR1E5QYvjrTsMuGESEyp8eGEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N1uOw+gSjiXvN5Rei/CY+JW9yK7WDBu/Px5Lu4fzXjA=;
 b=l2UFVdW7ZZ8Wq/MazA3txokoS3xg9Ckg/3k6kAMghSCa6jZcyRZ67htW24E9v6qr4dg0nja6oRUR6LMkWcUzn7y2y3CneeZmNcPk5l6a1dJD7LDs/Z4CrzZjjSbwYQuzx1hdp2gv+3EnhXDc46qGhkZ8F5hMYbGSsCbg79wUC0U=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SEZPR03MB8998.apcprd03.prod.outlook.com (2603:1096:101:23c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.30; Fri, 22 Mar
 2024 09:26:58 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::f3b6:91a7:e0fb:cb27]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::f3b6:91a7:e0fb:cb27%7]) with mapi id 15.20.7386.031; Fri, 22 Mar 2024
 09:26:58 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= <Shawn.Sung@mediatek.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
CC: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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
Subject: Re: [PATCH v6 09/14] drm/mediatek: Support "Pre-multiplied" alpha
 blending in Mixer
Thread-Topic: [PATCH v6 09/14] drm/mediatek: Support "Pre-multiplied" alpha
 blending in Mixer
Thread-Index: AQHafBnvaeIa27qwOE23+TyPufxl2bFDffeA
Date: Fri, 22 Mar 2024 09:26:58 +0000
Message-ID: <b58930f947f08b70cfb3c4a06482237ce71ba496.camel@mediatek.com>
References: <20240322052829.9893-1-shawn.sung@mediatek.com>
	 <20240322052829.9893-10-shawn.sung@mediatek.com>
In-Reply-To: <20240322052829.9893-10-shawn.sung@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SEZPR03MB8998:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rc2+xl5+b3xlQiwjflRoKjTpI0N2tw7g+Y6BrsKW89SDFWIOVw42wkwRqERONdfYklf0gd0ms4LFNBvLHQEu5CvLrlZRRFayDmsH4kZDok3ELEqKhc4/Mw+JuwAP8EQvb4Bv2UrI/rxXFYAx3Omv5QrRHR5UyX420cu4T74VUKgGbM6rOMCSBVooJVKRkLJuhz9hX9180YHZgmeNBxIWMmYkpg2NYZcDCEJSiSns+QqsNoLJrxErUPnyZK5gIB25bnNbL/RtK3xlBs8BLfOjOqmTRhVSiUkDBGsEWm0WUDSEY2uGK+ICF275EMvQuvew6LYv9fEZ3sGxOQPZE7X7Qpd8KOyNn/lhy6Mn4kEX+wwWEOv3zY3EWImR/qGx6cbGn4dy+VxmminczwJEt+QoNHD+Msih5ryuehQC+S6rSQcyS7tpCXl/3ir+3yy2DzD8hacI95lPyJc0FYBcZpltpOn2A9S3sFpaZ/pErWbaoI22geS1w003yxXtgU9KbNX4P5QqU+1GNOq/oeTNKJ61Z9TpIoxKL7efhdByCpVNA7wqEkD4HuM408e8hdJa1aG+IXK1jHhb3+QKa8iQMRSBY/XcI2Co4/skBudeEegeOaskbpfmkTFc4SbzD2juVvA95zw9X8OsSQYRNHYfyF3A0Oj+nMWtzTkRL2oh4T579oE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bkpiK2lmbWo2NkFxZXFOazN1N0NsNFV1UElieWFEYjNwbjZBMDAvRERKYnQ4?=
 =?utf-8?B?RkhobGpGU2lIQ25kUFMrNGJJSDN0QnZPNkdJVDA1ZVkyZTZwS3JGc1ZyUGRy?=
 =?utf-8?B?SjdzUEVHYm8yU3RZN1R2K3A3TWpaU3BNZjFxRkhTSGliOG1JUDU3SDNZQnc2?=
 =?utf-8?B?VjlFS2xnL2pBQlJ0YjQ1NXBXL01SUmJxVjlwalNISVQwWmNNSmwzbG5HZU51?=
 =?utf-8?B?RUFkdElVWmMwNExCdUFTbERCQjk2RDRoQndwcUZIazRYaFF0eC9JRXVRejh2?=
 =?utf-8?B?aDVKMFNTeE9IUHdiSXg5OUdRTXlqMEs4SzNSUWQ1Wm9CdGVJWFZUeklsYWF2?=
 =?utf-8?B?Y0tNSVVuMDU5cFcrQTd4WGVERmpsd3FFYlM5eDRUUjM3K2poVjdDWXRwWTFs?=
 =?utf-8?B?OTgvK0hjL1dRMitBUitXaUpNblJsM1ZyVjNCSFl5eko4MGVpb05Ia0xsUUNp?=
 =?utf-8?B?T3FoQURIU3lFcXlLNjhqdC93TmRBZzU3VUZEV3VKVzZyc1oxNjh0aEcxbkpp?=
 =?utf-8?B?OTNyUGFncnZhSGx5SXAwdE1YVUZKUk16QWxxWUx5SGZBWVQzeTdudElOTVlt?=
 =?utf-8?B?ZnozaE9TYU84M2UvSkRqODZnbWV6QnR5SGdPWkdVQXRvWHpYNGpDbTIwWjVI?=
 =?utf-8?B?WU5Wd0Q4LzBCTDIxMXJYK3lRb2JqY0MwWUVQQzRHVm5aRkFhRGk2TC9YV1Ns?=
 =?utf-8?B?bkM2NjRYQzVKd0Ird1JzUEIrVmp6S2pMMGRPNVpYODNnL25vNGxENXpqWmo0?=
 =?utf-8?B?NjNPZEptdDRYZVNUcCtmYVFTVEZwTlFrbVdra2ZrNUZlL3kvbUlwSjJLbU5C?=
 =?utf-8?B?YlRQWmpCSXdzcVZMWURSdG5CQ2ZJOWJPbnVsZVhHTG5YRmpCaG8vbnN6L3BQ?=
 =?utf-8?B?ZnNhL1NqYW1xWE9rdmtzK2luV3hEZW0vK0ZxaFBqL1ZXemdQTUFtZ21McjJ3?=
 =?utf-8?B?VTRzbG9IYms4bER6Y3FvS1FPWUQ2K1dJRXozQk1JSmRzWWFkbTVFbjR3ZFRi?=
 =?utf-8?B?YnJReGc4OGRFS3BXL3JuOXBiZGRYYS9DaU1VWmorRExPVThJWENiWDFBTXhD?=
 =?utf-8?B?QnlGbndPc0NwR3RPb3kycXEyZHdCZERYZlFENmFMVkNLSGYybWtESDVFU1BQ?=
 =?utf-8?B?T1BBODZpTGVqMmlYeDU3TnFJLzYxOFpnekZHS294TEFFR0Uwb1UzTkxqTU5C?=
 =?utf-8?B?SkZlRTgwV1lXbWdzL05UUEJJZjZTRWNlZU5SQ0tlRCthL2QybUxLdWwybXZq?=
 =?utf-8?B?Z3NWWUpOUEdQV3JRN1lRSFJ0RndKQXEydStybzZzWmlJaURhOVNqVHJCckVP?=
 =?utf-8?B?cTJCYkNtdGZCLzBWajRjbm1kTEtQeUdsYi9nRWtSZXVSWlJzMitzeEMvUVJP?=
 =?utf-8?B?QlpJQldNRWtWSkZwdElnbDNGU05Lckg0dlFvbWhOVUZub0hSSGdXQ2ovejVt?=
 =?utf-8?B?WFFOK01QeG9DendxQWo3bThzb1NONE9RZ0IvSVFZNHhyNW8ySDhKNWJCNlpF?=
 =?utf-8?B?SEJjSHhUK0IyRkZBVktVdXRFZXpwMldubjgzczdWWXVidGdtbzlqamR2Q25Y?=
 =?utf-8?B?TGF1aWd6TDZYN3cvSE43ZkkyTDdiejU3RmVqOERDTTRVcHZJNStRelA0dGQx?=
 =?utf-8?B?ZmFlanNKdHMrRVBMeUxZc1kzRFhhOVBIYTh4Z3c4Nm1ISHhSU0pHVHUyRlhu?=
 =?utf-8?B?YjNFWnlmUDE1Y1pzaDEvak9RaGptcytPK2NrTUR3aDA1NWg4MWZiQXdMSEdo?=
 =?utf-8?B?dGpIemxOWjE0clpFRW1CKzJCZm41NXlOTXM3UUl2cTNSSjhQZHNPeWEzWDNx?=
 =?utf-8?B?ZzlmT3pXVU56QUpVdGV2c1hNWU9HZVhwZVdJQnk2VFN6aTFIREtBVndxbVlz?=
 =?utf-8?B?ZDdlbHlBaURDaDdJdHFCODFId3RBdm1Ud2dpTksva0MwK3liWFZqT1grblF2?=
 =?utf-8?B?ekRQSmE4SWlMc1pXQis0aTRHdEg4YnpJelJNY0hxd01BVDhHam5sZEVFV0Z1?=
 =?utf-8?B?bTJrSUJlakVLVHFXekszYjNEVjN5QlJxUmpML1hCTE1XMEltMERsNmJSMVYy?=
 =?utf-8?B?SnZRWjVRQ2E3Z01Fa1BMM3Jvd1ZJaFlKTVZuVkJsTGN5cEV4aDZYb3Rocy9Z?=
 =?utf-8?Q?F1tPE2f1ineyuLAJ4yGMDvdNj?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7216E8000B9B9940AD4BAD3ECE7D39CB@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dae927a8-e49b-4433-7db3-08dc4a52391a
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2024 09:26:58.5540
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TH3oNTQmOuGJmZgxru6h8Avky3WGNL2W+FiRE4ysKZS3QBLipsfzRqbvXyHmuE4PX/IJXB99W9Ut6DNFdpIsPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB8998
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--13.355300-8.000000
X-TMASE-MatchedRID: QW5G6BKkLToOwH4pD14DsPHkpkyUphL9X4GSJGyYc34J5zM3dzkaQbJn
	Ph8w+R5oxpWxmut0txol6rr8933abhAq4jU0QZlBQ4srjeRbxTZMkOX0UoduuUYvSDWdWaRhNjy
	2tJcff+RuAR/Spdx9aZjXlVZ6P0cvwjNT2ImDeU2NzYJBKgDdEcnlJe2gk8vIV+MOvGRW7mI0oI
	W/6XAMMlwXT4SAXuOUkNSp2KM/ZRCQFHd0cGjNx7MsPmSZxbpkLAnNohUyMa34JyR+b5tvoI3tI
	4HHvrLy4vM1YF6AJbY9l7H+TFQgdbew1twePJJB3QfwsVk0UbtuRXh7bFKB7mpwLC488klrNavj
	95SxWIj30Ud7sUT0Jt39GR/gtuXbNkUSDDq742k=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--13.355300-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	D7FC89130FDDE23DE1F52ADD56B5F272D3D4DF0DF0327F0AFC48F91A330B819A2000:8

SGksIFNoYXduOg0KDQpPbiBGcmksIDIwMjQtMDMtMjIgYXQgMTM6MjggKzA4MDAsIFNoYXduIFN1
bmcgd3JvdGU6DQo+IEZyb206IEhzaWFvIENoaWVuIFN1bmcgPHNoYXduLnN1bmdAbWVkaWF0ZWsu
Y29tPg0KPiANCj4gU3VwcG9ydCAiUHJlLW11bHRpcGxpZWQiIGJsZW5kIG1vZGUgb24gTWVkaWFU
ZWsncyBjaGlwcy4NCj4gQmVmb3JlIHRoaXMgcGF0Y2gsIG9ubHkgdGhlICJDb3ZlcmFnZSIgbW9k
ZSBpcyBzdXBwb3J0ZWQuDQo+IA0KPiBQbGVhc2UgcmVmZXIgdG8gdGhlIGRlc2NyaXB0aW9uIG9m
IHRoZSBjb21taXQNCj4gImRybS9tZWRpYXRlazogU3VwcG9ydCBhbHBoYSBibGVuZGluZyBpbiBk
aXNwbGF5IGRyaXZlciINCj4gZm9yIG1vcmUgaW5mb3JtYXRpb24uDQo+IA0KPiBTaWduZWQtb2Zm
LWJ5OiBIc2lhbyBDaGllbiBTdW5nIDxzaGF3bi5zdW5nQG1lZGlhdGVrLmNvbT4NCj4gLS0tDQo+
ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2V0aGRyLmMgfCAyNSArKysrKysrKysrKysr
KysrKystLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMTggaW5zZXJ0aW9ucygrKSwgNyBkZWxl
dGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRr
X2V0aGRyLmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2V0aGRyLmMNCj4gaW5k
ZXggNmJmMzk4ODUwZTg1Zi4uNGIxMmNhMjg1ZTg0YiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9n
cHUvZHJtL21lZGlhdGVrL210a19ldGhkci5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRp
YXRlay9tdGtfZXRoZHIuYw0KPiBAQCAtNSw2ICs1LDcgQEANCj4gIA0KPiAgI2luY2x1ZGUgPGRy
bS9kcm1fZm91cmNjLmg+DQo+ICAjaW5jbHVkZSA8ZHJtL2RybV9mcmFtZWJ1ZmZlci5oPg0KPiAr
I2luY2x1ZGUgPGRybS9kcm1fYmxlbmQuaD4NCj4gICNpbmNsdWRlIDxsaW51eC9jbGsuaD4NCj4g
ICNpbmNsdWRlIDxsaW51eC9jb21wb25lbnQuaD4NCj4gICNpbmNsdWRlIDxsaW51eC9vZi5oPg0K
PiBAQCAtMzUsNiArMzYsNyBAQA0KPiAgI2RlZmluZSBNSVhfU1JDX0wwX0VOCQkJCUJJVCgwKQ0K
PiAgI2RlZmluZSBNSVhfTF9TUkNfQ09OKG4pCQkoMHgyOCArIDB4MTggKiAobikpDQo+ICAjZGVm
aW5lIE5PTl9QUkVNVUxUSV9TT1VSQ0UJCQkoMiA8PCAxMikNCj4gKyNkZWZpbmUgUFJFTVVMVElf
U09VUkNFCQkJCSgzIDw8IDEyKQ0KPiAgI2RlZmluZSBNSVhfTF9TUkNfU0laRShuKQkJKDB4MzAg
KyAweDE4ICogKG4pKQ0KPiAgI2RlZmluZSBNSVhfTF9TUkNfT0ZGU0VUKG4pCQkoMHgzNCArIDB4
MTggKiAobikpDQo+ICAjZGVmaW5lIE1JWF9GVU5DX0RDTTAJCQkweDEyMA0KPiBAQCAtMTUzLDcg
KzE1NSw4IEBAIHZvaWQgbXRrX2V0aGRyX2xheWVyX2NvbmZpZyhzdHJ1Y3QgZGV2aWNlICpkZXYs
DQo+IHVuc2lnbmVkIGludCBpZHgsDQo+ICAJc3RydWN0IG10a19wbGFuZV9wZW5kaW5nX3N0YXRl
ICpwZW5kaW5nID0gJnN0YXRlLT5wZW5kaW5nOw0KPiAgCXVuc2lnbmVkIGludCBvZmZzZXQgPSAo
cGVuZGluZy0+eCAmIDEpIDw8IDMxIHwgcGVuZGluZy0+eSA8PCAxNg0KPiB8IHBlbmRpbmctPng7
DQo+ICAJdW5zaWduZWQgaW50IGFsaWduX3dpZHRoID0gQUxJR05fRE9XTihwZW5kaW5nLT53aWR0
aCwgMik7DQo+IC0JdW5zaWduZWQgaW50IGFscGhhX2NvbiA9IDA7DQo+ICsJdW5zaWduZWQgaW50
IG1peF9jb24gPSBOT05fUFJFTVVMVElfU09VUkNFOw0KDQpJIHRoaW5rIHlvdSBzaG91bGQgbm90
IGFzc2lnbiBoZXJlLiBZb3Ugc2hvdWxkIGNob29zZSBvbmUgb2YNClBSRU1VTFRJX1NPVVJDRSBv
ciBOT05fUFJFTVVMVElfU09VUkNFIGxhdGVyLg0KDQo+ICsJYm9vbCByZXBsYWNlX3NyY19hID0g
ZmFsc2U7DQo+ICANCj4gIAlkZXZfZGJnKGRldiwgIiVzKyBpZHg6JWQiLCBfX2Z1bmNfXywgaWR4
KTsNCj4gIA0KPiBAQCAtMTcwLDE5ICsxNzMsMjcgQEAgdm9pZCBtdGtfZXRoZHJfbGF5ZXJfY29u
ZmlnKHN0cnVjdCBkZXZpY2UgKmRldiwNCj4gdW5zaWduZWQgaW50IGlkeCwNCj4gIAkJcmV0dXJu
Ow0KPiAgCX0NCj4gIA0KPiAtCWlmIChzdGF0ZS0+YmFzZS5mYiAmJiBzdGF0ZS0+YmFzZS5mYi0+
Zm9ybWF0LT5oYXNfYWxwaGEpDQo+IC0JCWFscGhhX2NvbiA9IE1JWEVSX0FMUEhBX0FFTiB8IE1J
WEVSX0FMUEhBOw0KPiArCW1peF9jb24gfD0gTUlYRVJfQUxQSEFfQUVOIHwgKHN0YXRlLT5iYXNl
LmFscGhhICYgTUlYRVJfQUxQSEEpOw0KDQpOb3cgc3VwcG9ydCBwaXhlbCBhbHBoYSwgYW5kIHRo
aXMgc2VlbXMgdG8gc3VwcG9ydCBwbGFuZSBhbHBoYS4NClNlcGFyYXRlIHRoaXMgdG8gYW5vdGhl
ciBwYXRjaC4NCg0KPiAgDQo+IC0JbXRrX21tc3lzX21peGVyX2luX2NvbmZpZyhwcml2LT5tbXN5
c19kZXYsIGlkeCArIDEsIGFscGhhX2NvbiA/DQo+IGZhbHNlIDogdHJ1ZSwNCj4gLQkJCQkgIERF
RkFVTFRfOUJJVF9BTFBIQSwNCj4gKwlpZiAoc3RhdGUtPmJhc2UucGl4ZWxfYmxlbmRfbW9kZSAh
PSBEUk1fTU9ERV9CTEVORF9DT1ZFUkFHRSkNCj4gKwkJbWl4X2NvbiB8PSBQUkVNVUxUSV9TT1VS
Q0U7DQo+ICsNCj4gKwlpZiAoc3RhdGUtPmJhc2UuZmIgJiYgIXN0YXRlLT5iYXNlLmZiLT5mb3Jt
YXQtPmhhc19hbHBoYSkgew0KPiArCQkvKg0KPiArCQkgKiBNaXhlciBkb2Vzbid0IHN1cHBvcnQg
Q09OU1RfQkxEIG1vZGUsDQo+ICsJCSAqIHVzZSBhIHRyaWNrIHRvIG1ha2UgdGhlIG91dHB1dCBl
cXVpdmFsZW50DQo+ICsJCSAqLw0KPiArCQlyZXBsYWNlX3NyY19hID0gdHJ1ZTsNCg0KRGl0dG8u
DQoNClJlZ2FyZHMsDQpDSw0KDQo+ICsJfQ0KPiArDQo+ICsJbXRrX21tc3lzX21peGVyX2luX2Nv
bmZpZyhwcml2LT5tbXN5c19kZXYsIGlkeCArIDEsDQo+IHJlcGxhY2Vfc3JjX2EsIE1JWEVSX0FM
UEhBLA0KPiAgCQkJCSAgcGVuZGluZy0+eCAmIDEgPw0KPiBNSVhFUl9JTlhfTU9ERV9FVkVOX0VY
VEVORCA6DQo+ICAJCQkJICBNSVhFUl9JTlhfTU9ERV9CWVBBU1MsIGFsaWduX3dpZHRoIC8NCj4g
MiAtIDEsIGNtZHFfcGt0KTsNCj4gIA0KPiAgCW10a19kZHBfd3JpdGUoY21kcV9wa3QsIHBlbmRp
bmctPmhlaWdodCA8PCAxNiB8IGFsaWduX3dpZHRoLA0KPiAmbWl4ZXItPmNtZHFfYmFzZSwNCj4g
IAkJICAgICAgbWl4ZXItPnJlZ3MsIE1JWF9MX1NSQ19TSVpFKGlkeCkpOw0KPiAgCW10a19kZHBf
d3JpdGUoY21kcV9wa3QsIG9mZnNldCwgJm1peGVyLT5jbWRxX2Jhc2UsIG1peGVyLT5yZWdzLCAN
Cj4gTUlYX0xfU1JDX09GRlNFVChpZHgpKTsNCj4gLQltdGtfZGRwX3dyaXRlX21hc2soY21kcV9w
a3QsIGFscGhhX2NvbiwgJm1peGVyLT5jbWRxX2Jhc2UsDQo+IG1peGVyLT5yZWdzLCBNSVhfTF9T
UkNfQ09OKGlkeCksDQo+IC0JCQkgICAweDFmZik7DQo+ICsJbXRrX2RkcF93cml0ZShjbWRxX3Br
dCwgbWl4X2NvbiwgJm1peGVyLT5jbWRxX2Jhc2UsIG1peGVyLQ0KPiA+cmVncywgTUlYX0xfU1JD
X0NPTihpZHgpKTsNCj4gIAltdGtfZGRwX3dyaXRlX21hc2soY21kcV9wa3QsIEJJVChpZHgpLCAm
bWl4ZXItPmNtZHFfYmFzZSwNCj4gbWl4ZXItPnJlZ3MsIE1JWF9TUkNfQ09OLA0KPiAgCQkJICAg
QklUKGlkeCkpOw0KPiAgfQ0K

