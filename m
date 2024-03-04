Return-Path: <linux-kernel+bounces-90002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F355486F8CC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 04:12:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED93B1C20A2A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 03:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D57F3D6D;
	Mon,  4 Mar 2024 03:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="kCylxL24";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="JyIAgERM"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A75717CE
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 03:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709521921; cv=fail; b=eOEtYOoA8bty4GHsPGeoxlSi/FeL005ONMNfPVxtZ+7dFbgIF97h/fgq5xSF5i+XBkpYZBpcXQAVULYLdNdOwOWBlQZolD9UR+qpsfeXTzJAzHnUUiNQ1dM4kIaWUqca9VADM4/plnzW5EbFJ+/2ibyQOpYtdf51HpDutu63C+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709521921; c=relaxed/simple;
	bh=hwL8G06tOlRpSofJsElVOah1OrAGT0a7S8BVbH4m2EA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VadAMTR/QExvJxIXV8KAyqJODgDXM+SmQTShEjFYTQiKhMS7C5MvQPIbEm8EHgc28FVy/xH9WJI3wXKZYgYCtHDX+w/mhXtHDPwqD58sf6fLEerd9JSX3f5vmIz7B6e2IF2Tj2BXuAciIk7bAu4kRQfRnlu4ok1EwK5pPSrSrbo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=kCylxL24; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=JyIAgERM; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: f475dfd0d9d411ee935d6952f98a51a9-20240304
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=hwL8G06tOlRpSofJsElVOah1OrAGT0a7S8BVbH4m2EA=;
	b=kCylxL24zPOuzXhh35lZONYVHLZVP8Z4lIOnzggk0Rm8BHAitI5D2zWyet3hUzN9l2VNavQa5N1zRjeQNe998Mrxy9mumQ45csNk1iFQbiPRTH5wrU4ckNHfusjPiXpZ5pTevDOsd+ZDOQzxFF9H2fU1nAJzbJwIWi8r5uaH1OI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:b544c794-5a56-4a01-a876-675321d1760e,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:3b5a1181-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: f475dfd0d9d411ee935d6952f98a51a9-20240304
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 721066043; Mon, 04 Mar 2024 11:11:55 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 4 Mar 2024 11:11:53 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 4 Mar 2024 11:11:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g17GCmDsNY5IFDw9rMWxpT5etgqRDebC1zdZZSZKxpyGXJoTyabWFmCktjFSlW1FXZ3BQkSjy6vzx9ursYilj/jSCRXlBk8aiRTxKITTPxB6DDP1i3qGATaJ/wdlZGbXR7VZh0P9PVb4LyIz29wuIqU6liL+vIj8J8I6LC4jP6IP39/7ml1yToG8JKxHNRYE7lV/7DrqSZiFDxd7PIM29towDlfyGiAdmbZfDeqy7UgFHFw2i1jSjrnkD8ipzjM8YoqEhkGOKma/5Jz1wOl63Clx5JrgMCUDz/Xhp4ju5L6kBwJxDFkM4brY034PzU78xUxoJfVZvXoZilZAN+GFsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hwL8G06tOlRpSofJsElVOah1OrAGT0a7S8BVbH4m2EA=;
 b=RjfGq2FGACs2VeB4ajIbZc+drAkEI0ZdA8Q8aXbkhznCTpyCXdWjxg0JhbYAHrmt1NoCxklsx3dZk5AFl/+yaSrLDajqD8JKSjd7o9MIkuITX+VoZQaNkE5YOV7avXRPT7aIhA9jCWBzQuc5bWO8rZ9cXjGLR3IttkmbqnLnzcuyHeiu43QtoGqAGKesj/Zqv+f5ZrbGP+fKnp/qn4tyY2ixlyKc0uIc0fBEt8tfcxO+TwnJxadB3JexQ5XHB+gauFSfLDHmxJf4Csjnv2I7ybI3JZHLFTJF0oT8kO+XVCpLqqnRZQUAQmK738r60QLFVTrEj7/91UCIq+/xLcStvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hwL8G06tOlRpSofJsElVOah1OrAGT0a7S8BVbH4m2EA=;
 b=JyIAgERMyq8j4qUsRIdRWGWPUKsOtW2kP0sS8mcWnzmrH2vfPX/D2/aLsOIs4JPoslL6GAaeDU54vCrTa1+Ez26tLr3Osx3EcCfToMwfDhiq0TIn3dO/HjtQMz0MXvL59CJsOAhwUb4IrgtKzeU/0rLWT+cQ9VZK8fEOlCg7mA4=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TYZPR03MB7003.apcprd03.prod.outlook.com (2603:1096:400:26a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.34; Mon, 4 Mar
 2024 03:11:50 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::f3b6:91a7:e0fb:cb27]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::f3b6:91a7:e0fb:cb27%7]) with mapi id 15.20.7339.035; Mon, 4 Mar 2024
 03:11:50 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	=?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= <Singo.Chang@mediatek.com>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	=?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?=
	<Jason-ch.Chen@mediatek.com>, =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?=
	<Shawn.Sung@mediatek.com>, =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?=
	<Nancy.Lin@mediatek.com>, Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
Subject: Re: [RESEND, PATCH 3/5] soc: mediatek: mtk-cmdq: Add
 cmdq_pkt_poll_addr() function
Thread-Topic: [RESEND, PATCH 3/5] soc: mediatek: mtk-cmdq: Add
 cmdq_pkt_poll_addr() function
Thread-Index: AQHaa+ccRvkxaECXsEmGlXDC8fIiUbEm65cA
Date: Mon, 4 Mar 2024 03:11:50 +0000
Message-ID: <d33fc25f014785d21ff7bac3f00a48e7621b810e.camel@mediatek.com>
References: <20240301144403.2977-1-jason-jh.lin@mediatek.com>
	 <20240301144403.2977-4-jason-jh.lin@mediatek.com>
In-Reply-To: <20240301144403.2977-4-jason-jh.lin@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TYZPR03MB7003:EE_
x-ms-office365-filtering-correlation-id: af179012-b7f5-41cd-1ba4-08dc3bf8d601
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jvvigsmtvkL36KkYhRZrmASuDM/lyvXcp9K2RN0MzUe21Uj3mMv6cn3CUEi3jeGP0abbSY1m74g7AB4Y7Op+lTv5HhL8EKhUZqjBUyeMMVEXTXkQnVbE39+M+Xf9iRS6p/HC72VEWR3yVTmRx+9FMx/ifGAs1QQcnWPtd1bb4DTuM5DNOh1IqT45FlshwllnD4OPKXC08L+fjLojM9Z2E3ErWUZBY8MR77sPT/y1EOg2CSwxDD808iZmA1z4/4mpl896Dw4R2gIr0XK/usJ78cdvl/EkKI/5ddP/Unus5n+B71iEbj4LbyrUHDXjTNC2Nv6fJ3Uj/cU/jEKid5hDNMADVkMmUB0+DsH6br4eAQ2E7oncB/nGdcSCsWGmu6BMu4Z38cmsHSq2hnLcNcOtAbay6LbVtMdj/T5Bf/qzTLCmrKAqK6SSgb6Bmk2LgxhXqtXqOBf0vCPBKcD7phRcDT0Z6RfoN3exZ3aWgwCP4l+coo8bQPVOaRPji+naamwbUF+6VP6yA34iftSuzrfEhqXRcCn0I2yBzEr68WhbiEwGMULs/KuUPIZ4x9+vxQAxRJgn7zWG3GhyihiNFZhkXELE2cP3b98zrt0AN58+5eSSfvZKULKNnrgkyAEPt84tN5p4jJFIE5N+ntLzIuQuJrKU1CXsqDMAHQOp2+HN6LMgPj+WZdz8ADY4zJ2xCdpMrZVRNUKcwzky+JSTa6Qldg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QU5ja2JFZ3grSjhKR1lGNVkyQUJJN2Yrdjk0SERWa3BFQVNXWXBVWkwrYmJt?=
 =?utf-8?B?MVFaZkE1clhTVzVueXoyMFBGN0R0WS9kL2s4cldtQURBV3Rkbkp2UkNHZmRW?=
 =?utf-8?B?b0xGTElQQXN3OUcvdE5YN1QxeFlnSnk3S0RTa0kyUzd6V3VlcXNLMG1vbUpG?=
 =?utf-8?B?S2VJb3l0ZXBSWVpoQWNZQlVmYUFIcVU0UUhqTnpBeUt4dEd3SjdoSThSRkpH?=
 =?utf-8?B?cmVkcHBiQmt4M2JNNkxZWFZCY0RvWEVwdmoxWUFhTEtRREFMMWVrN214NTI2?=
 =?utf-8?B?Unhhczk1RnNzN3NHWDNJNWl0NWIvbXhVRHRkVXNpK252R2xjL0JlYmZ1WGpp?=
 =?utf-8?B?NlBybzZXWWRka256ODhqMVRnOGtsUGpaRGFnM1VDKzZUaHZKaTRxMVIvaGx0?=
 =?utf-8?B?RC9oZ1B3cTg0Rkc3WnMzZysvUnZjbUVTT3BWdDE5RUdtcjdGRFYvZVNtbldM?=
 =?utf-8?B?YnpjZUkrRW5OZjQrOHlXUFdwTEhHTUF3WjRsUlltNmRjUlNnbkYyemRaSkQr?=
 =?utf-8?B?WXQ0OXN2Wisxck1NV0JLQk5KY01VMUh1bm5uYTRQRlovTE1LRGZKUzhHN2dz?=
 =?utf-8?B?MjZWMUYrNHhNWUhlcG0zV3AzUkl4T29kQTZsYkNjUndQM3UxNUZqcytBUXhp?=
 =?utf-8?B?c2VYeUZNdGNMTDhYRWFTTWwvNWxUMkpPZW5EQnZFbjJ4SWZvVFFIcldUa0dK?=
 =?utf-8?B?Unp4THlZb2FyREV3QVJ0KzdzaUZucXRoVDQ2YmZSNENucUl5b3Fwa29FSmFW?=
 =?utf-8?B?Vm9Nd1RCbU83N0ZHU1R5QTNuWjErSnh6dDZnR1FFaWYxNHNDVGMremlLWmZu?=
 =?utf-8?B?OHpZS3FCYm53S0NNdTRockJndDdzaUhsZDFXc0ZXMnV2S2FlaWl4UTZrQ3dK?=
 =?utf-8?B?VUd4dDlqL1pWZ2w5Vjh2NmFKbWE0aVk2UTBid0ZVamVNRU5hUUYvWGlIdkI4?=
 =?utf-8?B?MWFTbnhXdmlUaU9ia3NZZGpYTENXdVJqUXVXWVNPMVdXbGRia2ZRcFRmZFUw?=
 =?utf-8?B?MjREcEVMZEVTWTRwSnhLZ0lxL2ZZNUN0YVN2aVpZbGd5alg4d3RSZmdFSHRk?=
 =?utf-8?B?TncybzQ4MVV0YnpueWFmaUNnMHhNZ09rdG43bW9VMjU0anUxVzAxZ08wNjFS?=
 =?utf-8?B?TTZCaWZhNTRRbUtJTFh3d1ZuZFExYVRmeFMvZWxPakh1dkZOcUhXM3VpY0E3?=
 =?utf-8?B?cjRTR0ZWeUx6eTMyMWNsT2JUQWhabTRVQXFncjdMbGxFVHhBVHlpZXlzN1Er?=
 =?utf-8?B?MWQ4dFdyNjRaNGhBU0R1Q1NBN1ZWSXA3bzd2bGhlak5DN2ZVUEVtZGJac1Nw?=
 =?utf-8?B?RGQyMGVMY1ZwWVVNb3Y4SEdyTTZhWUV2OHFNVm40Qi8xb0FYSkhkMHBIYloz?=
 =?utf-8?B?Zll2cEdGSGlzSXZCZGdpOXBtcUVrSkk2YTl0VDBEcnFoSlRyT3dpbzFmR01R?=
 =?utf-8?B?R0ZNc0treXI1UHJsNi9mUG1rOEZHcWFMclA4a2x1MDBqem1qS3V3VVV0bHlD?=
 =?utf-8?B?WFhvajhMNUYwOEwycHpoNWZQUStGMytXM0NiTS9NbElxcWlwT1lnd1B4eVVO?=
 =?utf-8?B?aDg1em4vaFY2YXVBTXFjVGRjM0VvbkhCSFRZZHQyZmkxZnphazhKNEozTjgy?=
 =?utf-8?B?alIxUGZoYjlaTTY5d2o4dmZlNEFkV2JBU3Z0Qk1tZjFBZTlCNGh6NU5DSEVQ?=
 =?utf-8?B?MDFWVkJ1UXYzYTl2VkU2OFplUTVNUWllcDFZUGxqUTl1citDeE1hRTU3ak1h?=
 =?utf-8?B?UHBIR3E5TjNPRTJUN3FqN3JjV212bXBzdnhxUUNJeFFMNFowUEdKenc2MGVW?=
 =?utf-8?B?MW42MndTSUFpd0ZaMlNOUHNzWkcwWEdCcTMvOFU2RDVDeUltcXh0UE5iVmhF?=
 =?utf-8?B?RWkrVkFteEVXRmhXbmt0ci9mdWhZcFVtMlRBTXJkK3hQRGJySUlhVHZoNUJE?=
 =?utf-8?B?Q2hzZWFzSS9PdVdjbCsrQmdxejRWbE1TbitFSURxSkFBMm91NmVVNmVEalBw?=
 =?utf-8?B?ay94TW5ieWRBWXVnbDRJdmZRWWRXZUFJSStZTnlNdHRNKzV1ck9RT0tiTW51?=
 =?utf-8?B?WkoxKytZNHhMMVQ0bVgyTXY0dCtrYlEvTVFkTTZuNUNxUXAyckNsdHpibWJH?=
 =?utf-8?Q?rR52+Mvlea+yJQokLkUuPorxw?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3A31A8C44C9AB44889631C121B2187D3@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af179012-b7f5-41cd-1ba4-08dc3bf8d601
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2024 03:11:50.8006
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E9btAzBveAreVQFrmXsXXPKDICUSLmY7Z85Bui8iMwi1Rt082dUc9QEQJ0UN41RCFYr5aezu/VWe/V++3l0AbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7003
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--8.583300-8.000000
X-TMASE-MatchedRID: QW5G6BKkLTroSitJVour/Sa1MaKuob8PC/ExpXrHizxcKZwALwMGs8lO
	14E7OluCCgyrVUAVlXbNe0fPRIWv1bM5yFdOCNfRydRP56yRRA/vJY9pBzgg1EYvSDWdWaRhcHj
	giTON9jIqegugNzsJfRgY0ztehnm8r4Tjl93LJlcmEURBmKrZlAhggJPN8raBaxKBbTWINAtASA
	ka3p+8QpeHWg5vQIGjV+y45I8VYVwpiQbfusdLxfOHbIp2eXtY9ISHwCrIdS+NTnqOMBIJ4UIW3
	Et0DwQO4vM1YF6AJbY9l7H+TFQgdbew1twePJJB3QfwsVk0UbsIoUKaF27lxTseTPH6263R7tDj
	auJpImRk62U8yTgY8hdHNu0inY0XwuClLuBsXNv+NfiFU1m6DVrZ+XTWI5YubmKSmeWC2EFoATN
	Y7PAIMrlnKKaUMzHIDnrGG5trZa5nzopjeg1PfMg7RKLZO56enqg/VrSZEiM=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--8.583300-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	A366E6A6763154CA91612129C397AF86B1FF551EF98643ABFADB92FF2C0C6AB02000:8

SGksIEphc29uOg0KDQpPbiBGcmksIDIwMjQtMDMtMDEgYXQgMjI6NDQgKzA4MDAsIEphc29uLUpI
LkxpbiB3cm90ZToNCj4gQWRkIGNtZHFfcGt0X3BvbGxfYWRkciBmdW5jdGlvbiB0byBzdXBwb3J0
IENNRFEgdXNlciBtYWtpbmcNCj4gYW4gaW5zdHJ1Y3Rpb24gZm9yIHBvbGxpbmcgYSBzcGVjaWZp
YyBhZGRyZXNzIG9mIGhhcmR3YXJlIHJpZ3N0ZXINCj4gdG8gY2hlY2sgdGhlIHZhbHVlIHdpdGgg
b3Igd2l0aG91dCBtYXNrLg0KPiANCj4gUE9MTCBpcyBhbiBvbGQgb3BlcmF0aW9uIGluIEdDRSwg
c28gaXQgZG9lcyBub3Qgc3VwcG9ydCBTUFIgYW5kDQo+IENNRFFfQ09ERV9MT0dJQy4gQ01EUSB1
c2VycyBuZWVkIHRvIHVzZSBHUFIgYW5kIENNRFFfQ09ERV9NQVNLDQo+IHRvIG1vdmUgcG9sbGlu
ZyByZWdpc3RlciBhZGRyZXNzIHRvIEdQUiB0byBtYWtlIGFuIGluc3RydWN0aW9uLg0KPiBUaGlz
IHdpbGwgYmUgZG9uZSBpbiBjbWRxX3BrdF9wb2xsX2FkZHIoKS4NCj4gDQo+IFNpZ25lZC1vZmYt
Ynk6IEphc29uLUpILkxpbiA8amFzb24tamgubGluQG1lZGlhdGVrLmNvbT4NCj4gLS0tDQo+ICBk
cml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYyB8IDM4DQo+ICsrKysrKysrKysr
KysrKysrKysrKysrKysrDQo+ICBpbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGstY21kcS5o
ICB8IDE2ICsrKysrKysrKysrDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDU0IGluc2VydGlvbnMoKykN
Cj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIu
Yw0KPiBiL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jDQo+IGluZGV4IDNh
MWU0N2FkOGE0MS4uMmU5ZmM5YmIxMTgzIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3NvYy9tZWRp
YXRlay9tdGstY21kcS1oZWxwZXIuYw0KPiArKysgYi9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGst
Y21kcS1oZWxwZXIuYw0KPiBAQCAtMTIsNiArMTIsNyBAQA0KPiAgDQo+ICAjZGVmaW5lIENNRFFf
V1JJVEVfRU5BQkxFX01BU0sJQklUKDApDQo+ICAjZGVmaW5lIENNRFFfUE9MTF9FTkFCTEVfTUFT
SwlCSVQoMCkNCj4gKyNkZWZpbmUgQ01EUV9QT0xMX0hJR0hfQUREUl9HUFIJKDE0KQ0KDQpJIHRo
aW5rIHRoZXJlIGFyZSBtdWx0aXBsZSBHUFIgYW5kIHlvdSB1c2UgIzE0IHRvIHN0b3JlIGhpZ2gg
YWRkci4gSQ0Kd291bGQgbGlrZSB5b3UgdG8gbGlzdCBhbGwgR1BSIGFuZCBkbyBub3QgbGltaXQg
dGhlIHVzYWdlIG9mIGVhY2ggR1BSLg0KVGhlIHF1ZXN0aW9uIGlzLCB3aHkgbGltaXQgIzE0IHRv
IGJlIGhpZ2ggYWRkcj8gSWYgdGhlIEdQUiBpcyBzaGFyZWQgYnkNCmFsbCB0aHJlYWRzLCB0aGVy
ZSBzaG91bGQgYmUgYSBtZWNoYW5pc20gdG8gbWFuYWdlIEdQUiB1c2FnZSBmb3IgY2xpZW50DQpk
cml2ZXIgdG8gYWxsb2NhdGUvZnJlZSBHUFIuDQoNCj4gICNkZWZpbmUgQ01EUV9FT0NfSVJRX0VO
CQlCSVQoMCkNCj4gICNkZWZpbmUgQ01EUV9SRUdfVFlQRQkJMQ0KPiAgI2RlZmluZSBDTURRX0pV
TVBfUkVMQVRJVkUJMQ0KPiBAQCAtNDA2LDYgKzQwNyw0MyBAQCBpbnQgY21kcV9wa3RfcG9sbF9t
YXNrKHN0cnVjdCBjbWRxX3BrdCAqcGt0LCB1OA0KPiBzdWJzeXMsDQo+ICB9DQo+ICBFWFBPUlRf
U1lNQk9MKGNtZHFfcGt0X3BvbGxfbWFzayk7DQo+ICANCj4gK2ludCBjbWRxX3BrdF9wb2xsX2Fk
ZHIoc3RydWN0IGNtZHFfcGt0ICpwa3QsIGRtYV9hZGRyX3QgYWRkciwgdTMyDQo+IHZhbHVlLCB1
MzIgbWFzaykNCj4gK3sNCj4gKwlzdHJ1Y3QgY21kcV9pbnN0cnVjdGlvbiBpbnN0ID0geyB7MH0g
fTsNCj4gKwlpbnQgZXJyOw0KPiArCXU4IHVzZV9tYXNrID0gMDsNCj4gKw0KPiArCWlmIChtYXNr
ICE9IFUzMl9NQVgpIHsNCj4gKwkJaW5zdC5vcCA9IENNRFFfQ09ERV9NQVNLOw0KPiArCQlpbnN0
Lm1hc2sgPSB+bWFzazsNCj4gKwkJZXJyID0gY21kcV9wa3RfYXBwZW5kX2NvbW1hbmQocGt0LCBp
bnN0KTsNCj4gKwkJaWYgKGVyciAhPSAwKQ0KPiArCQkJcmV0dXJuIGVycjsNCj4gKwkJdXNlX21h
c2sgPSBDTURRX1BPTExfRU5BQkxFX01BU0s7DQo+ICsJfQ0KPiArDQo+ICsJLyoNCj4gKwkgKiBQ
T0xMIGlzIGFuIG9sZCBvcGVyYXRpb24gaW4gR0NFIGFuZCBpdCBkb2VzIG5vdCBzdXBwb3J0IFNQ
Ug0KPiBhbmQgQ01EUV9DT0RFX0xPR0lDLA0KPiArCSAqIHNvIGl0IGNhbiBub3QgdXNlIGNtZHFf
cGt0X2Fzc2lnbiB0byBrZWVwIHBvbGxpbmcgcmVnaXN0ZXINCj4gYWRkcmVzcyB0byBTUFIuDQo+
ICsJICogSXQgbmVlZHMgdG8gdXNlIEdQUiBhbmQgQ01EUV9DT0RFX01BU0sgdG8gbW92ZSBwb2xs
aW5nDQo+IHJlZ2lzdGVyIGFkZHJlc3MgdG8gR1BSLg0KPiArCSAqLw0KPiArCWluc3Qub3AgPSBD
TURRX0NPREVfTUFTSzsNCj4gKwlpbnN0LmRzdF90ID0gQ01EUV9SRUdfVFlQRTsNCj4gKwlpbnN0
LnNvcCA9IENNRFFfUE9MTF9ISUdIX0FERFJfR1BSOw0KPiArCWluc3QubWFzayA9IGFkZHI7DQoN
ClRoaXMgaXMgZnVsbCBhZGRyZXNzLCBub3QgaGlnaCBhZGRyZXNzLiBXaHkgbmFtZSB0aGUgR1BS
IHRvDQpDTURRX1BPTExfSElHSF9BRERSX0dQUj8NCg0KVGhlIGFkZHIgaXMgbm90IG1hc2ssIHNv
IEkgd291bGQgbGlrZSBpbnN0LnZhbHVlID0gYWRkci4NCg0KUmVnYXJkcywNCkNLDQoNCj4gKwll
cnIgPSBjbWRxX3BrdF9hcHBlbmRfY29tbWFuZChwa3QsIGluc3QpOw0KPiArCWlmIChlcnIgPCAw
KQ0KPiArCQlyZXR1cm4gZXJyOw0KPiArDQo+ICsJaW5zdC5vcCA9IENNRFFfQ09ERV9QT0xMOw0K
PiArCWluc3QuZHN0X3QgPSBDTURRX1JFR19UWVBFOw0KPiArCWluc3Quc29wID0gQ01EUV9QT0xM
X0hJR0hfQUREUl9HUFI7DQo+ICsJaW5zdC5vZmZzZXQgPSB1c2VfbWFzazsNCj4gKwlpbnN0LnZh
bHVlID0gdmFsdWU7DQo+ICsJcmV0dXJuIGNtZHFfcGt0X2FwcGVuZF9jb21tYW5kKHBrdCwgaW5z
dCk7DQo+ICt9DQo+ICtFWFBPUlRfU1lNQk9MKGNtZHFfcGt0X3BvbGxfYWRkcik7DQo+ICsNCj4g
IGludCBjbWRxX3BrdF9hc3NpZ24oc3RydWN0IGNtZHFfcGt0ICpwa3QsIHUxNiByZWdfaWR4LCB1
MzIgdmFsdWUpDQo+ICB7DQo+ICAJc3RydWN0IGNtZHFfaW5zdHJ1Y3Rpb24gaW5zdCA9IHt9Ow0K
PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaA0KPiBi
L2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmgNCj4gaW5kZXggYjZkYmUyZDhm
MTZhLi4yZmU5YmUyNDBmYmMgMTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUvbGludXgvc29jL21lZGlh
dGVrL210ay1jbWRxLmgNCj4gKysrIGIvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNt
ZHEuaA0KPiBAQCAtMjUzLDYgKzI1MywyMiBAQCBpbnQgY21kcV9wa3RfcG9sbChzdHJ1Y3QgY21k
cV9wa3QgKnBrdCwgdTgNCj4gc3Vic3lzLA0KPiAgaW50IGNtZHFfcGt0X3BvbGxfbWFzayhzdHJ1
Y3QgY21kcV9wa3QgKnBrdCwgdTggc3Vic3lzLA0KPiAgCQkgICAgICAgdTE2IG9mZnNldCwgdTMy
IHZhbHVlLCB1MzIgbWFzayk7DQo+ICANCj4gKy8qKg0KPiArICogY21kcV9wa3RfcG9sbF9hZGRy
KCkgLSBBcHBlbmQgcG9sbGluZyBjb21tYW5kIHRvIHRoZSBDTURRIHBhY2tldCwNCj4gYXNrIEdD
RSB0bw0KPiArICoJCQkgZXhlY3V0ZSBhbiBpbnN0cnVjdGlvbiB0aGF0IHdhaXQgZm9yIGENCj4g
c3BlY2lmaWVkDQo+ICsgKgkJCSBhZGRyZXNzIG9mIGhhcmR3YXJlIHJlZ2lzdGVyIHRvIGNoZWNr
IGZvciB0aGUNCj4gdmFsdWUNCj4gKyAqCQkJIHcvIG9yIHcvbyBtYXNrLg0KPiArICoJCQkgQWxs
IEdDRSBoYXJkd2FyZSB0aHJlYWRzIHdpbGwgYmUgYmxvY2tlZCBieQ0KPiB0aGlzDQo+ICsgKgkJ
CSBpbnN0cnVjdGlvbi4NCj4gKyAqIEBwa3Q6CXRoZSBDTURRIHBhY2tldA0KPiArICogQGFkZHI6
CXRoZSBoYXJkd2FyZSByZWdpc3RlciBhZGRyZXNzDQo+ICsgKiBAdmFsdWU6CXRoZSBzcGVjaWZp
ZWQgdGFyZ2V0IHJlZ2lzdGVyIHZhbHVlDQo+ICsgKiBAbWFzazoJdGhlIHNwZWNpZmllZCB0YXJn
ZXQgcmVnaXN0ZXIgbWFzaw0KPiArICoNCj4gKyAqIFJldHVybjogMCBmb3Igc3VjY2VzczsgZWxz
ZSB0aGUgZXJyb3IgY29kZSBpcyByZXR1cm5lZA0KPiArICovDQo+ICtpbnQgY21kcV9wa3RfcG9s
bF9hZGRyKHN0cnVjdCBjbWRxX3BrdCAqcGt0LCBkbWFfYWRkcl90IGFkZHIsIHUzMg0KPiB2YWx1
ZSwgdTMyIG1hc2spOw0KPiArDQo+ICAvKioNCj4gICAqIGNtZHFfcGt0X2Fzc2lnbigpIC0gQXBw
ZW5kIGxvZ2ljIGFzc2lnbiBjb21tYW5kIHRvIHRoZSBDTURRDQo+IHBhY2tldCwgYXNrIEdDRQ0K
PiAgICoJCSAgICAgICB0byBleGVjdXRlIGFuIGluc3RydWN0aW9uIHRoYXQgc2V0IGEgY29uc3Rh
bnQNCj4gdmFsdWUgaW50bw0K

