Return-Path: <linux-kernel+bounces-102905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFDF87B83B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 08:04:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB8B01F22003
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 07:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF6BDF59;
	Thu, 14 Mar 2024 07:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="MJQmH3Qv";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="q+J2UfYp"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D9310788;
	Thu, 14 Mar 2024 07:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710399836; cv=fail; b=IkZ2OwQNwEcQtYoQHGE464jJolA+48v776YAet+jfowevrggAdj2vpJCa1WLwzxitrKiSu0UvhOrgpefLi8ngAWOS2WSYgr+HFtGUCcsyiOhgcA/NslACaBRCfhdLx2me45CwBLtZJ+ro08lCdNKE9Wa5u/iV/g0YbMJ5olfS50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710399836; c=relaxed/simple;
	bh=eIyZQ+RkMkuvUdkzbRP/FxjGjDamiPuTfzKkDjpLSJA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=d4SgFYBelEz1/l/VFnfn0hN9hAEoliNNGHiFIDYLwQ7g6a56S64fSsTSQaiFdTvoTPiBGWXsQZKXKLAS7UAoK1vEM9tDsUuTrq2DA4nL5zkcZAPGHyrbUkFyT2HM/YDlPVZ0n46VHqP4ZY9r2fJPehr6zphWfwE7Vf9UVNYVyPs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=MJQmH3Qv; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=q+J2UfYp; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 0178d40ee1d111ee935d6952f98a51a9-20240314
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=eIyZQ+RkMkuvUdkzbRP/FxjGjDamiPuTfzKkDjpLSJA=;
	b=MJQmH3QvcK+3Y1VUCoXlOgp8+3xHyIql2lSoSm/BBw3pIASaP2aNniqUpqL2f10NFFy2/JFvqBltgyQyLsVGy+KwYp6AK1kt5em02YK/j/Nvsd3jW2TvsvKPGyYhLt5f70UZrmbkzQsz19ZqRshOQIJ35JGnWrytaVHmcwerFLE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:fe3303ea-6a6e-4e8c-a2a3-f5282a6811fd,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:c6596490-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 0178d40ee1d111ee935d6952f98a51a9-20240314
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2136730632; Thu, 14 Mar 2024 15:03:48 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 14 Mar 2024 15:03:46 +0800
Received: from HK2PR02CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 14 Mar 2024 15:03:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BUxBlSUnDrA+t/P2sGfMTazBhebvlixsC4BZTNsghf9j5aIh7BU8Nx3BKmg8RbE4/ZTNkuoJiLnZtAfJ+xwsotaTlcvnxh+yyan7zCkkGAERI8Q7a2d8lyVRsnnJt4Pz8IwYESCvw9TT4vcUYESwl+J3wdenpPSoDNxgr++27n2EaI5td1qLoQRumZreNEXudKVf2xelNQD8jPHSPO/EsPByDRAVeJ3uo53glSEVXb3125dXVyIFiMVVHcNcgbWyT+Kte7GCPEJtZBqXzvabXFrD3JUtt+Fy9xulhaTbWwCQxtE9TaacXMmOiC2vvx71S/Srsc+F8dywa+Q8NeNzRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eIyZQ+RkMkuvUdkzbRP/FxjGjDamiPuTfzKkDjpLSJA=;
 b=Xx1L56Hev4lv/HKYmi5Hi/H5SRMsAI87G56KkefZEQYzMOxz48vzGT2a+Nrnjyntc34SBY+2Vec+5DYt2YSK+kt9tumhwNm/yf7TR6LQJEl6sB17J8M4V2wyuXR+k+rhA+kjRv5M8F9/e0zl28WukyHDLF3dpFspkI8jVh01swkvOrzny4S5ffFh4s3ppUofhEozMeNssY8NHS7h1KtwlXaoqRszem1Cli7BFKhc4aZfCrdXAb98D+hxOBSznr63SdqikosBfAEl+PkeRbQgv2WzqrnAdYJRxcg2J5d0IIV1ksz25PLaebnsSz4yBZ8ArBteI4gsD/kDeMVuCLtQJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eIyZQ+RkMkuvUdkzbRP/FxjGjDamiPuTfzKkDjpLSJA=;
 b=q+J2UfYpVUBuzxSnauyDbowH/BCvjIdYDk0i3/H5yLNyxr+gHOfLRdV5C1hvbNWcDtFJXkwOJxVlbdn9bvKHszLZ4PPTW5yUeA1Q7sWf2N8bWtbGH1h2rtd9cE2bqyHJKDaSIMuNFQMybgQwQxKi9jF5S/pIofkoF67alYoQ9nQ=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by KL1PR03MB7489.apcprd03.prod.outlook.com (2603:1096:820:e6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.21; Thu, 14 Mar
 2024 07:03:45 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::f3b6:91a7:e0fb:cb27]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::f3b6:91a7:e0fb:cb27%7]) with mapi id 15.20.7362.031; Thu, 14 Mar 2024
 07:03:44 +0000
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
Subject: Re: [PATCH 09/11] drm/mediatek: Rename files "mtk_drm_gem.*" to
 "mtk_gem.*"
Thread-Topic: [PATCH 09/11] drm/mediatek: Rename files "mtk_drm_gem.*" to
 "mtk_gem.*"
Thread-Index: AQHaaJEEIKbIGjiYyU+fqN9rgTjRKLE26l8A
Date: Thu, 14 Mar 2024 07:03:44 +0000
Message-ID: <1cf41780ba18d665576c60659c83880cbd4c93fd.camel@mediatek.com>
References: <20240226085059.26850-1-shawn.sung@mediatek.com>
	 <20240226085059.26850-10-shawn.sung@mediatek.com>
In-Reply-To: <20240226085059.26850-10-shawn.sung@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|KL1PR03MB7489:EE_
x-ms-office365-filtering-correlation-id: 05e37d5a-4d4f-4123-6b8b-08dc43f4e397
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xGLT9bQNqGo2VSxq7/26kkhMn8p5WdOILEArbdHycFnHfA6t82YW27larDtCjCekv1CVjVqDOXgY1zqOdAGG8s+ySm4Cwv+bBKAj7EHBlqgGdewwoZhNAMX/y0Y76e1h+yQCA3d4AM7HudS+8HG4hN2OHNnIILS+3ELDTpxhrD2vnnLiuJVUbIekC7/QmM3oMUpfJOWrNM18F0FofoOes5sN4xBcZgzCOowV/geQFVMzqzVqbtTQHaOTb6R+s+kzp9HwvXsWnVE/KMHRPkKZBx9qGnkAj2jqGlady6h08wI2Af+xoO2gt3x+ZaPkGI748N1ZJ/RcJrRKcnwWEJpd5t9iRfX4y6Sq3KaQZYKlWUvjR5YCxx6A3ZrYODu1/JNMBN48IRWaAUzvPKvEY7GxjmdEmb9SAXo+gnO7VI+fHpOptr3aEKO2oR9keYYb1DqIR9LbZVpPZVEutGzK55I+AupQvzVH6jrkRaFY3Rnazu/E+Vsp2q7wU/FMhAtGbA8feLSCdwmzb48xB2b6Mp4cDwD5rdhIC30lQzp/N+N8PhN/QAWebsYl6mz0TYN9xIq44mvuEgyNyEmRYtpdnozqGg69aIgolTHtBHOlmqvKlIPTR1Wb/WA/o29GSTiWIoxJnSDMVdZ01eKP9ECmA28e1+tUDARL54CMSt46oy9fREXfHg3/adPC7Gnd2NKMbToi/AlYeYMLR+X4mWsiElAm1AyLWXIRjhd8gTaP3HGy93E=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VEFLbjM1RVhJMUFGMDZwMmY2MXdNT3BENDVUTzY5aGp5SGQrUDBaK0pjbDVj?=
 =?utf-8?B?SDRVREZONTZ3cFo2cnpjaUZrMkxveXBqUkIzVXhLWVA0Y0VRNERNNDFRR2Fx?=
 =?utf-8?B?S0FKc0M2V3hqaUZwOTdkUElPQk1NYXkrbmVLSEJqV1hNL2hHV2JQNWxnZEJO?=
 =?utf-8?B?T2hGN2E2NXUyWitjeVhtVlRIcmE5VjBSTFpsVFAzY05SekVSVElnREFLWEU3?=
 =?utf-8?B?REVKb0NGOWx6dFhFZndiMUtYL1JFaGZYd3Y2c2dzMHE5QlBZdmlVeXdsMlQ1?=
 =?utf-8?B?dTNHSDVObEZJbUtML0o1MDNTb1B1OEFnOTYySjh3c1ZVNWFyTGMrUHE2U0Y1?=
 =?utf-8?B?UE5hZ0IyQ0hwdnFGNVhRWlFzKzM0WDgrNVI0TjM2MnBxRGNDQTBSVUZleW1a?=
 =?utf-8?B?UmJvNituUitNUG0rWnVIeFhRejk1dm10MjV4Umk4eXZGdUw0QzdHaVVsdVBC?=
 =?utf-8?B?N3kyTUpScnlzVlZNZE9VYkd3Sk1zekNRYU9zREZnS2VvYmdENjR4MkhTSjc2?=
 =?utf-8?B?VFNQN2l5Q0VQbWkyem5RVGlua0JjYUw2Z3d5enVSakVWc2hORDV1VUlsWmpS?=
 =?utf-8?B?c1c2c3ZSUXUyRjU3NmdJbXBla1ZKWERXWUxKU2hFSGhuclJHQmxXU1JrVmo4?=
 =?utf-8?B?SkJSQjBvdUpONTBORjlBZ0ZIVjZsTDk0N0V4V2MrN0JyS2xuYmdDLzV2R3JF?=
 =?utf-8?B?Z3pWKy9sY2VENnBEVWtrMmgyVWd6YkhCWktFU1NZN2ZSSlMzTU05anRrOHZW?=
 =?utf-8?B?VWduVjlDK0YvM3ExWHo1VWViNzg5RmR2ckZ0TGR5WnNJQ0pjbVNqWkxWeFZR?=
 =?utf-8?B?U0E4RDdlcDZJTVhmd3BBQ25ibGRTVUFUblROYUk0c1gwU25xT3BlRXlGbGRV?=
 =?utf-8?B?OUtnVFJsWjJJaVlIb2FrWXcvU0IvNmhqajZveW9JaHpJN0I2cmpHQXAvU3Bj?=
 =?utf-8?B?VUNmaWx1bDc2YVRIdm40MjVnUWN3OVRtK1U3MXNGMnIvd2RaVENpeTIxZkoz?=
 =?utf-8?B?ZXFUY29RN25KdUlkOFpwbDFFNkhXNmthR1NwWmN0WHFCekNRb1dCc2o2Q1A4?=
 =?utf-8?B?RWd3ZG04NDJPSE9iSnd4b2U2Q0hzSDNDYUVJd25sTDczQjNMb2daL0pIQllx?=
 =?utf-8?B?bElUOThhaWtPUHQzVmE1ckY3cEtOMDBOVUk0M2l2SlJvMEsycHVFSWM5MzZS?=
 =?utf-8?B?cFNPSVU3WjVWeUpNTXpuMGEyVG43MUZKcW1pd3JMMFJ0R2xBcTJkQkZVczBw?=
 =?utf-8?B?SEljNHI1ZjFGWmpoekJ5WUVMNk9IY0RFdUU5QXUwR0diZkFkNWVPL2ovSVl2?=
 =?utf-8?B?elQxWmo2RU9tSXE1K013S2ttNEpwRHBXK1pxNjZPcktGSWxxUUZNVVc0YXhm?=
 =?utf-8?B?TXdtNHZDZEtPbDNncUFxenhoUzlaeWdOOG1MNm1naUJHanE1aUJLcnBnRlN1?=
 =?utf-8?B?aUtiU29oZGplNmlGdkpSTzd0ZTNHWEljZFowYlZlcmczL005S25ucm9FWEtB?=
 =?utf-8?B?SmJkalNPbEdDWWxTc0swR2FRNzdVNExBRTVEVkpiSkRzWG9yRmJNMkVRazBr?=
 =?utf-8?B?ZmVST1hucm9Ld1ZhK04vRlJiYmRzM2xDa0lpRUFmWDNhWE5ZRkdBcm4ydVdG?=
 =?utf-8?B?b2FYYkFoRkpVME80Uno3bitHczZoWmFMdWxwWEVuNnV1cUtUd050N2pScGZn?=
 =?utf-8?B?b1ZWbkZJdmUyemN0ZmgvczFxK1NYdTJxdjNaV08zN0ZUcFB6NGgzRURmS2tt?=
 =?utf-8?B?dWZkWFJEUkxyekwzaFEzZ1FST212eDdqYmVHY2Z2Wi81ZUZlOHJQUC9qZkQ5?=
 =?utf-8?B?RlFkaHpKbVRpVDA3TFRyVS9RSEdlcVVLOHIrODFtRFpTNk5EWkZGUGU1NGJI?=
 =?utf-8?B?Mi9MWDQzNFlQZUFQNlFFdGh4UkJrYW94YmhzaklTd3BHakdJZVNSdU91dXVC?=
 =?utf-8?B?NUZDZmI0VXR1UjRFa1hKejBzUFpKQXJHTVRpSGcwbCs1U2ZFWEtRY2M2U2RI?=
 =?utf-8?B?QXp1VEFrdkFRS09BeE9pVWFWK0gwOEFqS3p1WDF4YVdabVdjd0NLZU42N3pu?=
 =?utf-8?B?cC9kVnAxbm1LdU4yWm1OeTQ5a1lYcW9tcmFMakdBY2FaVjRzN2l2WHk5amhL?=
 =?utf-8?Q?cVtNgwUaqOZgwrSYJkjtBA6H8?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8CBD2F48935A324A9EE17F53A1534FBE@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05e37d5a-4d4f-4123-6b8b-08dc43f4e397
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2024 07:03:44.9066
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZZaX/i4ucd51YWGwODmW2RWf24fqwqhjFwj2ddsHxyPAXa84tPLzjIBeSskh1Pns45mh4vXJ1z33YBxkMo/Erg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7489
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--15.565400-8.000000
X-TMASE-MatchedRID: 7ySqCuYCpfjoSitJVour/d7SWiiWSV/1jLOy13Cgb49qSjxROy+AU3a2
	v7MgC776yAUgFH8TZu5isDrIDgWLgCkos4L2dgO+Y1bQMCMvmn6eEP0DdJrulr/XDMnRl2Jl2ft
	v/5jXki+vAA8UiHn3/t2txaDV7L2dkfRhdidsajPSBVVc2BozSlkMvWAuahr8+gD2vYtOFhgqtq
	5d3cxkNevkniXtUAR8XQ+oNkupkd3wsMvVe+v/aQv2c/+hWAj0XWUTsIj1P40=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--15.565400-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	B930FDED1E8C850FD4AABC71A644ED341C57B32A5AD98B14C3D74B98D58CDB9B2000:8

SGksIFNoYXduOg0KDQpPbiBNb24sIDIwMjQtMDItMjYgYXQgMTY6NTAgKzA4MDAsIFNoYXduIFN1
bmcgd3JvdGU6DQo+IEZyb206IEhzaWFvIENoaWVuIFN1bmcgPHNoYXduLnN1bmdAbWVkaWF0ZWsu
Y29ycC1wYXJ0bmVyLmdvb2dsZS5jb20+DQo+IA0KPiBSZW5hbWUgZmlsZXMgbXRrX2RybV9nZW0u
KiB0byBtdGtfZ2VtLiouDQoNClJldmlld2VkLWJ5OiBDSyBIdSA8Y2suaHVAbWVkaWF0ZWsuY29t
Pg0KDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBIc2lhbyBDaGllbiBTdW5nIDwNCj4gc2hhd24uc3Vu
Z0BtZWRpYXRlay5jb3JwLXBhcnRuZXIuZ29vZ2xlLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2dw
dS9kcm0vbWVkaWF0ZWsvTWFrZWZpbGUgICAgICAgICAgICAgICAgICAgICB8IDIgKy0NCj4gIGRy
aXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfY3J0Yy5jICAgICAgICAgICAgICAgICAgIHwgMiAr
LQ0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZHJ2LmMgICAgICAgICAgICAg
ICAgfCAyICstDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsve210a19kcm1fZ2VtLmMgPT4g
bXRrX2dlbS5jfSB8IDIgKy0NCj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay97bXRrX2RybV9n
ZW0uaCA9PiBtdGtfZ2VtLmh9IHwgMA0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19w
bGFuZS5jICAgICAgICAgICAgICAgICAgfCAyICstDQo+ICA2IGZpbGVzIGNoYW5nZWQsIDUgaW5z
ZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4gIHJlbmFtZSBkcml2ZXJzL2dwdS9kcm0vbWVk
aWF0ZWsve210a19kcm1fZ2VtLmMgPT4gbXRrX2dlbS5jfSAoOTklKQ0KPiAgcmVuYW1lIGRyaXZl
cnMvZ3B1L2RybS9tZWRpYXRlay97bXRrX2RybV9nZW0uaCA9PiBtdGtfZ2VtLmh9ICgxMDAlKQ0K
PiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9NYWtlZmlsZQ0KPiBi
L2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9NYWtlZmlsZQ0KPiBpbmRleCAwZTE5OGMwMGM2ZjIu
LjdlNmQ0YjJmYWRiZiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL01h
a2VmaWxlDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9NYWtlZmlsZQ0KPiBAQCAt
MTEsNyArMTEsNyBAQCBtZWRpYXRlay1kcm0teSA6PSBtdGtfZGlzcF9hYWwubyBcDQo+ICAJCSAg
bXRrX2NydGMubyBcDQo+ICAJCSAgbXRrX2RkcF9jb21wLm8gXA0KPiAgCQkgIG10a19kcm1fZHJ2
Lm8gXA0KPiAtCQkgIG10a19kcm1fZ2VtLm8gXA0KPiArCQkgIG10a19nZW0ubyBcDQo+ICAJCSAg
bXRrX3BsYW5lLm8gXA0KPiAgCQkgIG10a19kc2kubyBcDQo+ICAJCSAgbXRrX2RwaS5vIFwNCj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfY3J0Yy5jDQo+IGIvZHJp
dmVycy9ncHUvZHJtL21lZGlhdGVrL210a19jcnRjLmMNCj4gaW5kZXggOTZhZjE5NGQwZDQ5Li43
ZmUyMzRkZTgzYTMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtf
Y3J0Yy5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfY3J0Yy5jDQo+IEBA
IC0yMiw3ICsyMiw3IEBADQo+ICAjaW5jbHVkZSAibXRrX2RybV9kcnYuaCINCj4gICNpbmNsdWRl
ICJtdGtfY3J0Yy5oIg0KPiAgI2luY2x1ZGUgIm10a19kZHBfY29tcC5oIg0KPiAtI2luY2x1ZGUg
Im10a19kcm1fZ2VtLmgiDQo+ICsjaW5jbHVkZSAibXRrX2dlbS5oIg0KPiAgI2luY2x1ZGUgIm10
a19wbGFuZS5oIg0KPiAgDQo+ICAvKg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21l
ZGlhdGVrL210a19kcm1fZHJ2LmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Ry
bV9kcnYuYw0KPiBpbmRleCAxMTNmZGJhYWM1YTEuLmI2MjMyMGY2NDg4MiAxMDA2NDQNCj4gLS0t
IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZHJ2LmMNCj4gKysrIGIvZHJpdmVy
cy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZHJ2LmMNCj4gQEAgLTI3LDcgKzI3LDcgQEANCj4g
ICNpbmNsdWRlICJtdGtfY3J0Yy5oIg0KPiAgI2luY2x1ZGUgIm10a19kZHBfY29tcC5oIg0KPiAg
I2luY2x1ZGUgIm10a19kcm1fZHJ2LmgiDQo+IC0jaW5jbHVkZSAibXRrX2RybV9nZW0uaCINCj4g
KyNpbmNsdWRlICJtdGtfZ2VtLmgiDQo+ICANCj4gICNkZWZpbmUgRFJJVkVSX05BTUUgIm1lZGlh
dGVrIg0KPiAgI2RlZmluZSBEUklWRVJfREVTQyAiTWVkaWF0ZWsgU29DIERSTSINCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2dlbS5jDQo+IGIvZHJpdmVy
cy9ncHUvZHJtL21lZGlhdGVrL210a19nZW0uYw0KPiBzaW1pbGFyaXR5IGluZGV4IDk5JQ0KPiBy
ZW5hbWUgZnJvbSBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9nZW0uYw0KPiByZW5h
bWUgdG8gZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19nZW0uYw0KPiBpbmRleCAzYWUxZjEy
YmZiNDYuLjBmZDU1MTE3ZWJmNyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlh
dGVrL210a19kcm1fZ2VtLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19n
ZW0uYw0KPiBAQCAtMTIsNyArMTIsNyBAQA0KPiAgI2luY2x1ZGUgPGRybS9kcm1fcHJpbWUuaD4N
Cj4gIA0KPiAgI2luY2x1ZGUgIm10a19kcm1fZHJ2LmgiDQo+IC0jaW5jbHVkZSAibXRrX2RybV9n
ZW0uaCINCj4gKyNpbmNsdWRlICJtdGtfZ2VtLmgiDQo+ICANCj4gIHN0YXRpYyBpbnQgbXRrX2dl
bV9vYmplY3RfbW1hcChzdHJ1Y3QgZHJtX2dlbV9vYmplY3QgKm9iaiwgc3RydWN0DQo+IHZtX2Fy
ZWFfc3RydWN0ICp2bWEpOw0KPiAgDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVk
aWF0ZWsvbXRrX2RybV9nZW0uaA0KPiBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZ2Vt
LmgNCj4gc2ltaWxhcml0eSBpbmRleCAxMDAlDQo+IHJlbmFtZSBmcm9tIGRyaXZlcnMvZ3B1L2Ry
bS9tZWRpYXRlay9tdGtfZHJtX2dlbS5oDQo+IHJlbmFtZSB0byBkcml2ZXJzL2dwdS9kcm0vbWVk
aWF0ZWsvbXRrX2dlbS5oDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsv
bXRrX3BsYW5lLmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX3BsYW5lLmMNCj4g
aW5kZXggOTVhNDMyOGE5YjBiLi40NjI1ZGViMjFkNDAgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9tZWRpYXRlay9tdGtfcGxhbmUuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVk
aWF0ZWsvbXRrX3BsYW5lLmMNCj4gQEAgLTE2LDcgKzE2LDcgQEANCj4gICNpbmNsdWRlICJtdGtf
Y3J0Yy5oIg0KPiAgI2luY2x1ZGUgIm10a19kZHBfY29tcC5oIg0KPiAgI2luY2x1ZGUgIm10a19k
cm1fZHJ2LmgiDQo+IC0jaW5jbHVkZSAibXRrX2RybV9nZW0uaCINCj4gKyNpbmNsdWRlICJtdGtf
Z2VtLmgiDQo+ICAjaW5jbHVkZSAibXRrX3BsYW5lLmgiDQo+ICANCj4gIHN0YXRpYyBjb25zdCB1
NjQgbW9kaWZpZXJzW10gPSB7DQo=

