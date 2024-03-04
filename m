Return-Path: <linux-kernel+bounces-89969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31DE286F859
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 03:01:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B329828121F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 02:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EEA21864;
	Mon,  4 Mar 2024 02:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="MQY4Y/0V";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="M93tufB3"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F291362;
	Mon,  4 Mar 2024 02:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709517667; cv=fail; b=XQ7FU/7J4xlTY2xSF2RxOCGxdjfWlgiNRPFVVJewhDqYUDU8760mnnHl8SJEDJpjl/SdmePzpBakotQJXcGvfCQdhwIUmEGwlLz8b8mhdPO2Me+Fm3+YSoeagNxapJ3Pm/WLs8Xw7BOCGX7CoGgY146TBEgmCNeYV8N78x4/TnA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709517667; c=relaxed/simple;
	bh=N4iq/lY8IL0QxCGPGeWsnGWr2I1h3Wvq9gIt8mWQFHU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iZNlNSfPiRO8umGjF4+PUvFWRvcbaRTWLDVLt0rPK2Gq6u+SI/0uoRniViNgyPXwT4t1t2Nm2oB1cZYgZCFl6QQjF/EO12gg0LpDpSqucfKRxMSMjsZEzXMTWD54ju6mHWAalIWas4QLQwaiLlC1W+L7rXHHjq137In+2+XA7Lc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=MQY4Y/0V; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=M93tufB3; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 087bb96ed9cb11eeb8927bc1f75efef4-20240304
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=N4iq/lY8IL0QxCGPGeWsnGWr2I1h3Wvq9gIt8mWQFHU=;
	b=MQY4Y/0VZV1e3qPkivr63iYP+480Eq6/34nU85CFkwg/caHZs2M8Vm1KgEdV/jK4KVSnk118KwLVZEky3C1xKf4UtFKNuDE393Izf1wruIwC0uA3dtTF924hQzBfNZ/JSmMFHQQXh4ccbUoQz7GwA9fvMOhC5a0NF2FPkJ8QZ9s=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:eac8677e-3a95-41cc-a084-a8b596c02c57,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6f543d0,CLOUDID:5865f78f-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 087bb96ed9cb11eeb8927bc1f75efef4-20240304
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <irui.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1778555684; Mon, 04 Mar 2024 10:00:53 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 4 Mar 2024 10:00:52 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 4 Mar 2024 10:00:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=coPfzeRb0/tFHIUNvR2djFVIKCIfXNubUoBj8AEoABZ9QbwcUWKJVfmOgA2r3va+MGs4XDi7l6Nlwu4ZcQSXAx0FB9GcPJZyfx123NLqcHePoIz3yNUP8fnLYUsNocPQkSupwJaeKIonh9oqM7kZB6bnYlilP+1nuuejuYqZrtEWvlStfj5LU2skn/yKZkfyaJlk0CImKQ3Q6Ofx09ic1qM//gf0L6cHqsQ83276pJcVY608ZjcFpkF2tOTjK1iyzScntI10g7mFFEjtNmecTcDRp+MbbgueWmntCNhaLGLiuHghayLF1V463y9vHXp5JYoULVTTmJs+ZeKEnnr/4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N4iq/lY8IL0QxCGPGeWsnGWr2I1h3Wvq9gIt8mWQFHU=;
 b=LA/IewBkXdSMMlbtkSWwtfru3FyYj/HXM04lS/Lkoz1QZXW4/NPUqil4qEdZ2NE+gX0ox8ddSIW2tm15S0q2kVt+Tkc4fc0z7aEaAIrs+DLt34FM+e+wLDlPKT93AwYDMjVMGFI015S8bKotQPOtO2vBLcBpTojDshWvKZG0VUkaz0gKos1D3T2CHWV6aGNkQh7AGF1ivQOBy5rRv1598EGWWWggfIATgn5/vrE3gTCFaSrafuTTV8U9f4Nx24/orUyok3keNVVmd9BnqdRM0J+CwIOQKzxF5E/eHgwRW90R1loYY77W4fFFvBxbH/cSINAfT/wpBCggPX6ndIdzjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N4iq/lY8IL0QxCGPGeWsnGWr2I1h3Wvq9gIt8mWQFHU=;
 b=M93tufB3x1NPMfo2DF2Sg+8si3ANjvEoZIIcRsd8ZzH7fPoWmGn3Hd1zv8gpKKI/a3F2nFXfoOQqu1nldJld11IDscSUsCXOqvgTrrlcQ09jbUKplNrqV9reG2dYkcVjVzPp14hIqkq6bjKcheS3riIsMLhrAh4gF5cmMj8DYxk=
Received: from SEZPR03MB7947.apcprd03.prod.outlook.com (2603:1096:101:187::6)
 by TYZPR03MB7710.apcprd03.prod.outlook.com (2603:1096:400:3ca::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Mon, 4 Mar
 2024 02:00:49 +0000
Received: from SEZPR03MB7947.apcprd03.prod.outlook.com
 ([fe80::e4f9:968e:f97:59ab]) by SEZPR03MB7947.apcprd03.prod.outlook.com
 ([fe80::e4f9:968e:f97:59ab%7]) with mapi id 15.20.7339.035; Mon, 4 Mar 2024
 02:00:49 +0000
From: =?utf-8?B?SXJ1aSBXYW5nICjnjovnkZ4p?= <Irui.Wang@mediatek.com>
To: "sebastian.fricke@collabora.com" <sebastian.fricke@collabora.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?utf-8?B?TG9uZ2ZlaSBXYW5nICjnjovpvpnpo54p?= <Longfei.Wang@mediatek.com>,
	=?utf-8?B?VGlmZmFueSBMaW4gKOael+aFp+ePiik=?= <tiffany.lin@mediatek.com>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	=?utf-8?B?TWFvZ3VhbmcgTWVuZyAo5a2f5q+b5bm/KQ==?=
	<Maoguang.Meng@mediatek.com>, "mchehab@kernel.org" <mchehab@kernel.org>,
	"nicolas.dufresne@collabora.com" <nicolas.dufresne@collabora.com>,
	=?utf-8?B?WXVuZmVpIERvbmcgKOiRo+S6kemjnik=?= <Yunfei.Dong@mediatek.com>,
	Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v2] media: mediatek: vcodec: Handle VP9 superframe
 bitstream with 8 sub-frames
Thread-Topic: [PATCH v2] media: mediatek: vcodec: Handle VP9 superframe
 bitstream with 8 sub-frames
Thread-Index: AQHaarvgeM7Dv/Xo60GhVwrxh2nPCbEjAKIAgAPZcoA=
Date: Mon, 4 Mar 2024 02:00:49 +0000
Message-ID: <14c9dea999efc16f2f1753a9524f558cf066a244.camel@mediatek.com>
References: <20240229030249.3404-1-irui.wang@mediatek.com>
	 <20240301151344.o7khwhbasnncw2cc@basti-XPS-13-9310>
In-Reply-To: <20240301151344.o7khwhbasnncw2cc@basti-XPS-13-9310>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB7947:EE_|TYZPR03MB7710:EE_
x-ms-office365-filtering-correlation-id: 76da7dab-a397-4fcd-0d6d-08dc3beee9dd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OPFGNjKOUs1pQnspHYdbKRVjRzBuBIfOmT4Gps3Cuw/h6VY9d2VJCNs7X3PJ2lxeYLjcwp7GytWvLtNjh96835mmutDheRLQH7Ex7XbkSVr9/FcXa0v9lhvhGMPTMwhGdhlYX3WvThR5dvUHHV0eKA1vxIRN+TCo+V6nUChubBeP4OWz2Xxi7O65DCmLvdEWzTglXfiih8DwtIR66p3MfLpZdVZB6T+gx9gCYgfwx0uFJ5DmYU034MVT3Xz0qk5HvOvZh/OwMc0g3AXMZq3DdB2sHJYzuXn3Mzqfkf1MuKkZk+QCedHA/nlDGxgjSR/KKGvMHyYlpCc0a09pU/SA7975Xit3+C7X0heJ8k4Wn+YGAcoWxiRT8AGPfi+1Pmu9vsbjJ5Xng6OqKDEhvMHtl99DzspZXTuNsB47hin/X4mDk0mWVXwD1xXUdrHNPt/W05VXzbIYdrreBWrNhl1UVrUSVpAHsOdJ0tvdro+Klebnd2VJTKVHX5p/PuvwBxToF/MFbrf0xZ9WszEwxWX3+4rIYYvKL2/4gtkYeWve9a1VGwHY5ZKVkEJsme7gwm41zYN3Cv/JWq0UHUumf2MEvfZ+r7iIUDoJaKgYX3VOVvrDoQmmgSQT9tQdpHXdzgrWJlKN4usNFsEjhEXWNH35LxC01Qrs0eETjIRTq6xPfoN5Q2cDf7/jA4ykc12iBO0UGMvXzKHkXGbhrflsSr7Tnm5uemwI+Wvdr13Vf5NhAgA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB7947.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b3pxclQ4eFRseGZha2o2eC9xN28vb0ZWeEEzcUFJUkk5SlpCYStLUFZUUnFZ?=
 =?utf-8?B?NDl0c25YUDR1NUd2T0lQNENhZERGc2hEZTU5WDBnVk5KY0xmK252elR3NldY?=
 =?utf-8?B?L3crVGRkWjRibE0zZDUxZW1UeFhlb2FobE5HOVZRSitzQ251SWpMcW55SmhO?=
 =?utf-8?B?OXgxMDNSRDllRHlTeVRVbTlBU1psRlp6UVlKQ21ZWlo4REZ4VTh2UWNhUm5W?=
 =?utf-8?B?RnRqcFdJY0t0V3JoUEdnQ2FLam5yc3lWTGcwRHR4YVpPcDkvOCs3dU42Yytq?=
 =?utf-8?B?UWN2eHZBcjJUZFVraEpXOFRRVkdZZ3VDay80S1dCeWJ0UEdSZ1pHdnVIYWdP?=
 =?utf-8?B?eWJXbWxtbGs0L2ZPTFhKSlZsR29OV2J3cmRQOHlJOUllZmplZGZNWThzdHJL?=
 =?utf-8?B?OVZrYkpxRTRaQ2JRZjVVOGFCcjBuV2orRHFURWZFMHhRcERQRStxOVBuNFIx?=
 =?utf-8?B?NXJrTis3YllFQ1MvbFdjUGtXYk5CNjhBTzZKNlBmcWhTdWt1ay9YeDMwNDdH?=
 =?utf-8?B?NXRkOElQb283cEEvd0t5Kzc4Nld3OVFMOTRUSDZwajJvamh2dEg1OUhqR1lr?=
 =?utf-8?B?dk9wVWVqc0tKSm9za0NBWWZjdTZVMzArd2FkRDJmd0NMMUNaZjRDYXBOSFhm?=
 =?utf-8?B?ZFcyNmx5Y0FnY2JWZ3craXZxYlRTRkoxUVJtRnFBRVJwVy8yS1FGd3BWTTI0?=
 =?utf-8?B?OUVzRW1jWnJlZlp0bFdIaUFieWw2UzZCb2VuS0pxeVZQYWhjN0c5TU5ZTUg0?=
 =?utf-8?B?cFhydUprTXFTZVhmQTRySzVYczhZT2QzRWZRc3l3ZEllSVFSMSt5ck1JLzcz?=
 =?utf-8?B?TG5oRU9kT2RjN2VNeDFoWWVBY01zcmZSc3FXSFVHbVl1YmZGWVgva1V1ZW14?=
 =?utf-8?B?SlFLVTRpM2toUHBKaDlta21QRm90TjZId1pFVFBHenQwZUtpUExsNnk3Vk1t?=
 =?utf-8?B?RFI0UUlrOVRGOVR4S2czd2xoNkdFOG1kcEZON2U5UHVyaWJQempjUThNeHJI?=
 =?utf-8?B?eDRIRmZpdXZ5V0pDWEhFQmtXVDcvY0NRTmh5OUxPSzlvMzBkZXJCUUQxZStK?=
 =?utf-8?B?YnRoTytiNXUxWE9BaFRqNk1rUklrYk9PSnQ1ZXhJcVpVTEd1aVRCWWc1c0lM?=
 =?utf-8?B?cmZ2Q1FuSnpqdk5JMThDZkpOWktUYURKcGpqOU1wQldNbkhyTTZHK29GRjk0?=
 =?utf-8?B?Ny9CeHNlS1VTWENnUVcvck96em1hQUowZlF6bDdLRGZBTFo3ZjJVQmVWblZY?=
 =?utf-8?B?ZzhJTGt4M2trQXRlS3FyeTQyM1o0ZVBZbUVQdVhFbmI2azMydDZZa0xKNTUv?=
 =?utf-8?B?Rlh6UmFIQ1FJeG0xZUMyMHJzUVJwdy9WOVluZTVJQklvNUZ4Y1l0ZTlOQjBh?=
 =?utf-8?B?VXE4Q0ZPbWJ5OFJ1MTF6U1FGejhvdlY5dXdCeC9CT2Y4ZElQbDFOazBMRzhh?=
 =?utf-8?B?VU9kZVhpd25nK01sVUZNdXhYQ1MyVFlxVllTbFl0cjZFTTlTeEZuT3NjYXU4?=
 =?utf-8?B?cXBxS0xUV251RlJqSGdvWWJNZ2JPRFUvc3U5Rnh2NzNnbmZTYnJaQXVFWStI?=
 =?utf-8?B?YjFkNk5iT3Z1d0lGWWtJRy9wSSs5eE10dTlocGw4SXc1bTIwYmQwRURBaVZI?=
 =?utf-8?B?VWxuY3RtcGdpbkdFdVk2YXFyUDRVem0rR21pQyt3S3FIVlE4dUdxZk0ydlZh?=
 =?utf-8?B?Vm1kSVEyWVI4emM3eDc1Tm0rMisrSzM2REhSWkJGd0pDNnNvcEYvOU1RNzNs?=
 =?utf-8?B?T2lOUG9Fd1RodnkwbHg0NFcrTGdtb0JuMm1ZM0swSHRrczNMQkloUWtOZlVm?=
 =?utf-8?B?RGtqczFkemlXeHpsS2o1dnN2eUNMdjl3dkV4aFNUMzRWTzBObnFBc2t0dktJ?=
 =?utf-8?B?VGc0eTlMeVo0ZCtsbG45cUIvbTJBdFV0V0ppcmpldFQyWWE3UlJ2aHRHOXhV?=
 =?utf-8?B?U2VkTEZBMXRKbVVOMSthVmMyRUU4cmsxMWFDU3NCMFZZVUFQdXpqdmt6Tnpr?=
 =?utf-8?B?dVJnbEwwT0VVdisyTytKSy9VYjVYa2VxRStQajAzaWVVUG45cW8xdmhMeHll?=
 =?utf-8?B?MTJzZzBpV3luVjVGUGdPRnV2c1ZKMUM4T01aazNQN3hYcjJGdXdtSmtBZkF1?=
 =?utf-8?B?U1R2VC9OUlJ6bi9KSiswSVlHQWNkTVllOTh1UnNOMERWM09UR3IvK1BwcHFX?=
 =?utf-8?B?Tmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <16CA559DE01676459637A041A7D78792@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7947.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76da7dab-a397-4fcd-0d6d-08dc3beee9dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2024 02:00:49.1385
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AXpmvSh5f3sgpZ6njM2qXQ8NRvvd7HngT40oOMoEwrwVKF9TwkqYyXrrsc4iQUzjIcAxty3GOjkiRrgMsQ/lcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7710
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--17.449700-8.000000
X-TMASE-MatchedRID: gIwa0kWWszLUL3YCMmnG4qwOh3D3JSTGQ2+afbhb/Sq5Alb2pliJYKgF
	8LHYfOYGQpy1XVcFhh6zLCnUz3MHYy4UUq9htJ32JrUxoq6hvw8L8TGleseLPKuZoybwHAwkYqk
	wmiKYFxtgc1NQL93aukhGhVq1hSzQX+AaUzfp3hOG/X7YnfJAXJLXhHlWou03tefEfbIMlYv4eY
	E/JF5KDK4Jhlx7vdJerQtuqHwCYj4Z7Eu9TqPx8MV1CHtMfzqg2yk8ad/lrSDfUZT83lbkEJW3Z
	GXw3kr5F8u8dQXnFzkSJVWAqoVeTkL9tcyTZdAsgxsfzkNRlfLdB/CxWTRRuyUIayx+Skid
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--17.449700-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	215D548022C08896C7B80EC55F8AFED940A97E7510E9A63484AF723500058F562000:8

RGVhciBTZWJhc3RpYW4gU2lyLA0KDQpUaGFua3MgZm9yIHlvdXIgcmV2aWV3aW5nLg0KDQpJIHdp
bGwgcmV3b3JkIHRoZSBjb21taXQgbWVzc2FnZSBhY2NvcmRpbmcgdG8geW91ciBzdWdnZXN0aW9u
LCBhbmQgc2VuZA0KYSBuZXcgcGF0Y2ggdjMuIFRoYW5rIHlvdSB2ZXJ5IG11Y2guDQoNClRoYW5r
cw0KQmVzdCBSZWdhcmRzDQoNCk9uIEZyaSwgMjAyNC0wMy0wMSBhdCAxNjoxMyArMDEwMCwgU2Vi
YXN0aWFuIEZyaWNrZSB3cm90ZToNCj4gSGV5IElydWksDQo+IA0KPiBPbiAyOS4wMi4yMDI0IDEx
OjAyLCBJcnVpIFdhbmcgd3JvdGU6DQo+ID4gVGhlIFZQOSBiaXRzdHJlYW0gaGFzIDggc3ViLWZy
YW1lcyBpbnRvIG9uZSBzdXBlcmZyYW1lLCB0aGUNCj4gPiBzdXBlcmZyYW1lDQo+ID4gaW5kZXgg
dmFsaWRhdGUgZmFpbGVkIHdoZW4gcmVhY2ggOCwgbW9kaWZ5IHRoZSBpbmRleCBjaGVja2luZyBz
bw0KPiA+IHRoYXQgdGhlDQo+ID4gbGFzdCBzdWItZnJhbWUgY2FuIGJlIGRlY29kZWQgbm9ybWFs
bHkgd2l0aCBzdGF0ZWZ1bCB2cDkgZGVjb2Rlci4NCj4gDQo+IEkgZmluZCB0aGlzIGNvbW1pdCBt
ZXNzYWdlIGEgYml0IGNvbmZ1c2luZywgeW91IHNheSB0aGF0IHlvdSBjb3VsZG4ndA0KPiBpbmRl
eCB0aGUgbGFzdCBzdXBlcmZyYW1lLCBidXQgdGhlbiB5b3Ugc2F5IHRoYXQgeW91IG1vZGlmeSB0
aGUgaW5kZXgNCj4gY2hlY2tpbmcgc28gdGhhdCB5b3UgY2FuIGFjY2VzcyB0aGUgbGFzdCBzdWIt
ZnJhbWUuDQo+IA0KPiBJIHdvdWxkIHJld29yZCB0aGlzIHNlY3Rpb24sIGhlcmUgaXMgbXkgc3Vn
Z2VzdGlvbjoNCj4gDQo+IFRoZSBWUDkgYml0c3RyZWFtIHVzZXMgc3VwZXJmcmFtZXMsIHdoaWNo
IGVhY2ggY29udGFpbiA4IHN1Yi1mcmFtZXMsDQo+IGVuYWJsZSBhY2Nlc3NpbmcgdGhlIGxhc3Qg
c3VwZXJmcmFtZSBieSBpbmNyZWFzaW5nIHRoZSByYW5nZSBvZiB0aGUNCj4gaW5kZXggdmFsaWRh
dGlvbiBhcyB0aGUgbWF4aW11bSBudW1iZXIgb2Ygc3VwZXJmcmFtZXMgaXMgOCBhbmQgbm90IDcu
DQo+IA0KPiBUaGUgcmVzdCBsb29rcyBnb29kIGFzIGFscmVhZHkgbWVudGlvbmVkIGJ5IE5pY29s
YXMuDQo+IA0KPiBHcmVldGluZ3MsDQo+IFNlYmFzdGlhbg0KPiANCj4gPiANCj4gPiBTaWduZWQt
b2ZmLWJ5OiBJcnVpIFdhbmcgPGlydWkud2FuZ0BtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+ID4g
Y2hhbmdlZCB3aXRoIHYxOg0KPiA+IC0gYWRkIGEgbmV3IGRlZmluZSAnVlA5X01BWF9TVVBFUl9G
UkFNRVNfTlVNJyBmb3Igc3VwZXJmcmFtZXMuDQo+ID4gLS0tDQo+ID4gLi4uL21lZGlhdGVrL3Zj
b2RlYy9kZWNvZGVyL3ZkZWMvdmRlY192cDlfaWYuYyAgICAgICAgfCAxMSArKysrKysNCj4gPiAt
LS0tLQ0KPiA+IDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0p
DQo+ID4gDQo+ID4gZGlmZiAtLWdpdA0KPiA+IGEvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9tZWRp
YXRlay92Y29kZWMvZGVjb2Rlci92ZGVjL3ZkZWNfdnA5X2lmLmMNCj4gPiBiL2RyaXZlcnMvbWVk
aWEvcGxhdGZvcm0vbWVkaWF0ZWsvdmNvZGVjL2RlY29kZXIvdmRlYy92ZGVjX3ZwOV9pZi5jDQo+
ID4gaW5kZXggNTUzNTVmYTcwMDkwLi4wMzkwODJmNjAwYzggMTAwNjQ0DQo+ID4gLS0tDQo+ID4g
YS9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL21lZGlhdGVrL3Zjb2RlYy9kZWNvZGVyL3ZkZWMvdmRl
Y192cDlfaWYuYw0KPiA+ICsrKw0KPiA+IGIvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9tZWRpYXRl
ay92Y29kZWMvZGVjb2Rlci92ZGVjL3ZkZWNfdnA5X2lmLmMNCj4gPiBAQCAtMTYsNiArMTYsNyBA
QA0KPiA+ICNpbmNsdWRlICIuLi92ZGVjX2Rydl9iYXNlLmgiDQo+ID4gI2luY2x1ZGUgIi4uL3Zk
ZWNfdnB1X2lmLmgiDQo+ID4gDQo+ID4gKyNkZWZpbmUgVlA5X01BWF9TVVBFUl9GUkFNRVNfTlVN
IDgNCj4gPiAjZGVmaW5lIFZQOV9TVVBFUl9GUkFNRV9CU19TWiA2NA0KPiA+ICNkZWZpbmUgTUFY
X1ZQOV9EUEJfU0laRQk5DQo+ID4gDQo+ID4gQEAgLTEzMywxMSArMTM0LDExIEBAIHN0cnVjdCB2
cDlfc2ZfcmVmX2ZiIHsNCj4gPiAgKi8NCj4gPiBzdHJ1Y3QgdmRlY192cDlfdnNpIHsNCj4gPiAJ
dW5zaWduZWQgY2hhciBzZl9ic19idWZbVlA5X1NVUEVSX0ZSQU1FX0JTX1NaXTsNCj4gPiAtCXN0
cnVjdCB2cDlfc2ZfcmVmX2ZiIHNmX3JlZl9mYltWUDlfTUFYX0ZSTV9CVUZfTlVNLTFdOw0KPiA+
ICsJc3RydWN0IHZwOV9zZl9yZWZfZmIgc2ZfcmVmX2ZiW1ZQOV9NQVhfU1VQRVJfRlJBTUVTX05V
TV07DQo+ID4gCWludCBzZl9uZXh0X3JlZl9mYl9pZHg7DQo+ID4gCXVuc2lnbmVkIGludCBzZl9m
cm1fY250Ow0KPiA+IC0JdW5zaWduZWQgaW50IHNmX2ZybV9vZmZzZXRbVlA5X01BWF9GUk1fQlVG
X05VTS0xXTsNCj4gPiAtCXVuc2lnbmVkIGludCBzZl9mcm1fc3pbVlA5X01BWF9GUk1fQlVGX05V
TS0xXTsNCj4gPiArCXVuc2lnbmVkIGludCBzZl9mcm1fb2Zmc2V0W1ZQOV9NQVhfU1VQRVJfRlJB
TUVTX05VTV07DQo+ID4gKwl1bnNpZ25lZCBpbnQgc2ZfZnJtX3N6W1ZQOV9NQVhfU1VQRVJfRlJB
TUVTX05VTV07DQo+ID4gCXVuc2lnbmVkIGludCBzZl9mcm1faWR4Ow0KPiA+IAl1bnNpZ25lZCBp
bnQgc2ZfaW5pdDsNCj4gPiAJc3RydWN0IHZkZWNfZmIgZmI7DQo+ID4gQEAgLTUyNiw3ICs1Mjcs
NyBAQCBzdGF0aWMgdm9pZCB2cDlfc3dhcF9mcm1fYnVmcyhzdHJ1Y3QNCj4gPiB2ZGVjX3ZwOV9p
bnN0ICppbnN0KQ0KPiA+IAkvKiBpZiB0aGlzIHN1cGVyIGZyYW1lIGFuZCBpdCBpcyBub3QgbGFz
dCBzdWItZnJhbWUsIGdldCBuZXh0DQo+ID4gZmIgZm9yDQo+ID4gCSAqIHN1Yi1mcmFtZSBkZWNv
ZGUNCj4gPiAJICovDQo+ID4gLQlpZiAodnNpLT5zZl9mcm1fY250ID4gMCAmJiB2c2ktPnNmX2Zy
bV9pZHggIT0gdnNpLT5zZl9mcm1fY250IC0NCj4gPiAxKQ0KPiA+ICsJaWYgKHZzaS0+c2ZfZnJt
X2NudCA+IDAgJiYgdnNpLT5zZl9mcm1faWR4ICE9IHZzaS0+c2ZfZnJtX2NudCkNCj4gPiAJCXZz
aS0+c2ZfbmV4dF9yZWZfZmJfaWR4ID0gdnA5X2dldF9zZl9yZWZfZmIoaW5zdCk7DQo+ID4gfQ0K
PiA+IA0KPiA+IEBAIC03MzUsNyArNzM2LDcgQEAgc3RhdGljIHZvaWQgZ2V0X2ZyZWVfZmIoc3Ry
dWN0IHZkZWNfdnA5X2luc3QNCj4gPiAqaW5zdCwgc3RydWN0IHZkZWNfZmIgKipvdXRfZmIpDQo+
ID4gDQo+ID4gc3RhdGljIGludCB2YWxpZGF0ZV92c2lfYXJyYXlfaW5kZXhlcyhzdHJ1Y3QgdmRl
Y192cDlfaW5zdCAqaW5zdCwNCj4gPiAJCXN0cnVjdCB2ZGVjX3ZwOV92c2kgKnZzaSkgew0KPiA+
IC0JaWYgKHZzaS0+c2ZfZnJtX2lkeCA+PSBWUDlfTUFYX0ZSTV9CVUZfTlVNIC0gMSkgew0KPiA+
ICsJaWYgKHZzaS0+c2ZfZnJtX2lkeCA+IFZQOV9NQVhfU1VQRVJfRlJBTUVTX05VTSkgew0KPiA+
IAkJbXRrX3ZkZWNfZXJyKGluc3QtPmN0eCwgIkludmFsaWQgdnNpLT5zZl9mcm1faWR4PSV1LiIs
DQo+ID4gdnNpLT5zZl9mcm1faWR4KTsNCj4gPiAJCXJldHVybiAtRUlPOw0KPiA+IAl9DQo+ID4g
LS0gDQo+ID4gMi4xOC4wDQo+ID4gDQo+ID4gDQo=

