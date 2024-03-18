Return-Path: <linux-kernel+bounces-105713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 108FE87E351
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 06:43:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAC602827D5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 05:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 462582231A;
	Mon, 18 Mar 2024 05:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Z/669DvQ";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="vSApdKZo"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5607D21101;
	Mon, 18 Mar 2024 05:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710740570; cv=fail; b=sApRkl8w1trFg5zn2yK4FAg8t0b81bLxnwH/F86L3U3LpIMHzC0ol+6x6JskTz8DDaM5zb1MUv08NashVC6dp1fmaDGjqG1z8icloPNHxVmxMH5YCoVBGnkK5dphfavDllKV1U8MlvaFmVS8qyDOfnnuow5tGIZ6hEg6HqIbf6M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710740570; c=relaxed/simple;
	bh=8JjZNhpEPMr0TkXvxDYYb4+M0t8awwsG3YfjOKaoUUI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ogTG4t8qpg3SK9spBbcrP70w7RweHnUJzRa58d5oQqj4gyrnWIG5KeQaMt/UfN3hz+HG0LKdLKv6PpRprCfeYtGmf6LEwqmxHpSY0VUGQrw3YIe+0GB9oIn4dCBnyKnegX6wDJ9NX7VQNBBVxk2MgStuixxELvYG6lN/L1nQKeg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Z/669DvQ; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=vSApdKZo; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 57623cc2e4ea11eeb8927bc1f75efef4-20240318
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=8JjZNhpEPMr0TkXvxDYYb4+M0t8awwsG3YfjOKaoUUI=;
	b=Z/669DvQN7BYjWOpJ3FBzsJOqfxO75mXkHb2e0oSyiHLWfoTmI/ZzlRkNexrnzkwKp2SHzor0OMVtpuSF1ciQs8A1TqGVhOiaSex25j8Yw6u23uEbYxzTmNyliYtHB+gZX9UtCXLhVx/ZSA7WeMDGbL6VzJbkKhkZeSP2QsP7mI=;
X-CID-CACHE: Type:Local,Time:202403181318+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:f2c46091-f420-4f77-8ba2-aa98cf454813,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:13a50200-c26b-4159-a099-3b9d0558e447,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 57623cc2e4ea11eeb8927bc1f75efef4-20240318
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1366628572; Mon, 18 Mar 2024 13:42:43 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 18 Mar 2024 13:42:42 +0800
Received: from HK3PR03CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 18 Mar 2024 13:42:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ASGdrFtfSNG0ytR4pAb4qbObKXaCcNRFBnvBvSpROmZ2Ni+L7yX0D68chDcswXsYulgttn1dFv8aYjv5c4hVyPinjGsM5laKpFgA1+kkAHS/AuHFdevo5XuLmDBwWWO6Bj8KeCVKWhbw5nyhVWlQ6+gIfWY6ttpUUZeeqYhHMXjEaDehFLOMwdDL+I6oIvMtcE27rfBy9c41YY/K1IIpwxFT5MN5zETNXJsQxk6jdRQWBbN7QNH3IO/eUpwwc0uHjKp+1ObqA4AcJ0hl8s/CQ8Dtn3qUDFLTSuXzN5O4pUbczY99tCplEMXMIr+wITHoFkjEqlkS3VgE7+EctOiCew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8JjZNhpEPMr0TkXvxDYYb4+M0t8awwsG3YfjOKaoUUI=;
 b=N5OcnGB5ieKl7J59RIoTUB6eJHxftFb/vQ32HOfiDh6E5hRJsSXaFIbxztNRLrDKSLG9X/kLVXFj9FomVscm2/F5ez2OoKqyFkWn2TeJ6X527svZUaoPlGSlrBN/G1rhmQuM8CPMwXOzdJUkxu68R68BpoHuX/FsDvvvqitIlQXPqGA7plcvSqcwNhBKLhXC1M1Y/pJP0I/6xTah+QQOGFdN1wMBwdEUH7SlK9Ictk8aDYqCNNP8XR3aL7pIO0VEyboCxIekIBLsUJLS0JySQ2cRM/TtmQnCsNmcP3nE2q4873m9QQCchSgmJeDSoKz2jVRrXp+x1BSeuoKtGoIsGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8JjZNhpEPMr0TkXvxDYYb4+M0t8awwsG3YfjOKaoUUI=;
 b=vSApdKZotvsYsTjDkf7dA1EaqyuWpRNLMdiNgJwMow/GfMEDzqIYkWucVZ9ODaJz27R6aGofWCIy4vXMwIa0yAveWkPf9SAc1zJHL0zAeGB8RzYXWJPlRYtKelnBOd9ILovfQChYJIyOQtwj/4PlNc5wMKCxkxf9msPJxYFcZSY=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SEZPR03MB6849.apcprd03.prod.outlook.com (2603:1096:101:94::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 05:42:40 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::f3b6:91a7:e0fb:cb27]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::f3b6:91a7:e0fb:cb27%7]) with mapi id 15.20.7386.022; Mon, 18 Mar 2024
 05:42:40 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "jstephan@baylibre.com" <jstephan@baylibre.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>, "linux-media@vger.kernel.org"
	<linux-media@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "paul.elder@ideasonboard.com"
	<paul.elder@ideasonboard.com>, "mchehab@kernel.org" <mchehab@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	=?utf-8?B?QW5keSBIc2llaCAo6Kyd5pm655qTKQ==?= <Andy.Hsieh@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, =?utf-8?B?TG91aXMgS3VvICjpg63lvrflr6cp?=
	<louis.kuo@mediatek.com>, "laurent.pinchart@ideasonboard.com"
	<laurent.pinchart@ideasonboard.com>, "fsylvestre@baylibre.com"
	<fsylvestre@baylibre.com>, "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "pnguyen@baylibre.com"
	<pnguyen@baylibre.com>
Subject: Re: [PATCH v4 4/5] media: platform: mediatek: isp_30: add mediatek
 ISP3.0 camsv
Thread-Topic: [PATCH v4 4/5] media: platform: mediatek: isp_30: add mediatek
 ISP3.0 camsv
Thread-Index: AQHaQ8+pgBL6pTKEqkml+zYix0rfyLE9Zo2A
Date: Mon, 18 Mar 2024 05:42:40 +0000
Message-ID: <6bb941e9fedd1a40436fe75bf6641400e61495a1.camel@mediatek.com>
References: <20240110141443.364655-1-jstephan@baylibre.com>
	 <20240110141443.364655-5-jstephan@baylibre.com>
In-Reply-To: <20240110141443.364655-5-jstephan@baylibre.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SEZPR03MB6849:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UgmLG7wwKHfIl9sNv7bmM1d6uxq5psLIp+QZ8PhZXG3b3C2Y1+49rsXfSTt7CsS6f2d8TKTIbvK/c/gH42+PukNTklPIKLABlLby9B4cXuC9vXYm7jGxPfwY9ajKJY658llONb1muCiqCULzqD9qJoWeWz4/0bMG6B1xzBXLrx1kzYeQLmLIW2eA7E3HaB3dGgvkdRZ9zIi88q7BTS7lLIjAReXQFO5sZrFL2q0NcBBnoXvDwn646RvdczVj/HaMQJNca6cjdoSFKv+bd9+JGlrUEqHcPV58N328431Ws+sphyKf7WZvd3dEYDOpkSd4QmsdkLHOTFmRyIiPXO6/EhRe0gdU1XoXTxiBAG9MY7c/LXL+hYedSA8QE+wiXTKDG3DPUHqKZG4el89KU0g3FQs87I9frS/XH1YG6csPLdUHrCn3B6Le3GKC5LmJQV4EvxOI8I3JB/EL7PMd+oyBt4jg68RdzAQ0uSWuVxxadjKeK1aIetFYoYq1B187CfY5odUTt0fv/K21f7iXtJ8js7LGC4x/CgXFj08yTgJR6Ko9IBtBng5U9yMIsHiVpVgI+lIV9LcInqktt7rerSj1p3aErINVi0yGg8JSafRLV/rgAvi3E9XV3C0bkrIGJysOHBDj1w+IPhUgXfZB1C1OzKDnJi8rvydm2lnKjCx3bbE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(376005)(1800799015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NS9BYnFtaHJzQVBxVlFkeTExUUE0OW82TnhwWkNhVFJTQXo2aURheHZPUGZn?=
 =?utf-8?B?MU9MR3hxUFkzV2lxWjlnRUZQNno1VzhOSStVZjNKeHBNbHk5SnFPaG9DOE43?=
 =?utf-8?B?TW1iQU9IL3NWZzBQWW1VSUorK29OVmsrR083NDNHVzJZV0ozVk9FU0xteWFu?=
 =?utf-8?B?UDVJVkM0eStXa3IzVTI0bElvSEM1UHIwUVRtWkM4a1N1OXRFNjN3YkpCdUsx?=
 =?utf-8?B?Tm9rQjJJMGxUNm4vY1g0RXlwT2h6M2FpYklqSUR3ZXFKVkRacTc1bVViUGkv?=
 =?utf-8?B?bC80TkNOSjFUTUdPQXlieThxWWlkcEVCdTZKVmNLSHR5eFMvTEhUZVJHMjhq?=
 =?utf-8?B?a1RQK0JKUHQzYyttVUN2K1F0TnllN2o1YkpGSGVtTWlURXZyWlNmbWcyYzhP?=
 =?utf-8?B?WllTbE5GamgrenFIdjdCMmVMeUJCemJZSFJxSzVtN2JCZFlJNTcwT0l2TUll?=
 =?utf-8?B?VVI4dmNxQ2dHeG90aHhzQ3FWd1NSWklyd214NmRkNlBzdDNmdU1iNktFclFY?=
 =?utf-8?B?a2lkS0ZtTUx5MzBBa3ZWa1NvMzcvSGc4cDFBNzdybWQzS2UreDZUd1ArN3M5?=
 =?utf-8?B?ckpyNHh6N0U0dDZDd1o4M3hYS2puWHlBa1hsamdPTnV3WkJkUkh5Vm5ibmt3?=
 =?utf-8?B?MEtQMG56MEIxQzNsUWsxR2ZSRnJiNFZDWFhObTdlaDJZUU8yVUJ6VkczWDho?=
 =?utf-8?B?ZWpXb2NxVWg2WlI5NjhCSGJZb2V6TFdwZW1EZUhzTkRLeTAxTVZsaTRFT0dG?=
 =?utf-8?B?UTdhZnRFRU52TUVMaVZISWZYb2cyZm15WnNaSEpZVjcwWGtwNnAzZ2J1V29V?=
 =?utf-8?B?OExiS1dUeGxRRWtFVWM3ZHJHa0hVNUEzdDlXTDRES1dCY2VpTHo1U1NCQ1pv?=
 =?utf-8?B?QmtzTGhVOGMxL1NuNXNNallLTVQvNU1NSlZNZCswVFBuWE9QbnhZU1JoYkxM?=
 =?utf-8?B?L3hKdnVIbGdvOU1MTGUzTndKZElncW8wbDlnTWZ1eTV6dDlOM2EvM2ZQUm1p?=
 =?utf-8?B?VEdnalFtdlUwS3Z3OHRENEtobUMwbFdtSTJkUDQ0c2dxOGNCREZGM05Idzl4?=
 =?utf-8?B?VVc1cXIzcW1jcEJVblNBOEFnUmJwcjVNaTZvQlJlbU5SSmZYSmJiRkphZ1Z5?=
 =?utf-8?B?VHo3RlhMbUpYVXo4TlpPUmJzVmxVMk1QdjJmVlRtV0Y0SmdoZnJFYjB2cjRi?=
 =?utf-8?B?dVQ4dnJ6SUpvaW1PMkZQT1pPZ2xnL2ZIVVhHYldtZTZUUEJjblFRVVNmeFI2?=
 =?utf-8?B?MTFxS0VWaytNOGRoKzFnZzJNeUlSMVd4MnNLeUI2RURQZGpETWFVL0pCN2g1?=
 =?utf-8?B?V1poWDBuV1NkcmplSHZuRyt5WmFXalkvZkprTkZuODRySjF0OWNjL014QXZy?=
 =?utf-8?B?OVpuQkNWQzdWM05kdnlmUDM1aVgwY1UyQnVHWm5Uaitoa21ySXJlOGNCMXRv?=
 =?utf-8?B?TTBHWnZSV3dYdGhhbVc5UlRMeWRaMFRFb1hBSXhocVpZWlN5MlBMdjdqaW9q?=
 =?utf-8?B?b0ZlalZzRlFkbVJ0Z3Y2R2YwSGVnTk1OakRyRVVLUktqeTBscnZrRTVtanlT?=
 =?utf-8?B?cVlDN3ZweVV0clNxdXdWdUdlRElCYVh2TWlObjFTSXNRR05PUEUyMUg5M0xh?=
 =?utf-8?B?NkIxd1BMOFcxN1hmVDJvcWJrcm5uS3J3NmpqdjBzSFBFYk5mQUh1c0FpME5t?=
 =?utf-8?B?Q2FuT3JIcUZJa1BtKzczekR3MG9Bc2JSeDE4TmNvRW16VDllSTR4UXpnSmJU?=
 =?utf-8?B?ejN4bitSeGpyNnhqNGZXZUFVY0d0OXhqUklDOXZCVExZanlGV3pLbm1taVRY?=
 =?utf-8?B?Z251b25OTHBzRzNzZllraHlaU0xtTEZpQnlFV2J4ZzNLUFI3Z05Pd2FRVmwz?=
 =?utf-8?B?dUJxQnJYVmpxN0RXWDg4YnppdndqYldxK2h4czhpYVZZb2h5NGsxSGJlN09C?=
 =?utf-8?B?K2RnSThJQU8zV3c5Z1FtczNIejBBUENtQkxWUSs1M0VyRjFhVU8wbXh6MUt4?=
 =?utf-8?B?MVB2UmlzTE03NUVmYW9LYzJ2ZTF2eHZ4TkliK21NS2paQWV3ejRCWFl5Q0FX?=
 =?utf-8?B?V2N5Tyt5WXB4alg3YmwrVGExVFVkQzYzRlpVbENUN1V6ZTZVSnZJcForMU5t?=
 =?utf-8?Q?RpdCqYkJmJCr3cgBEta7oP1w6?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C1B8C2EA8081C24EB233524AE45DD0E0@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0822f7ff-1537-41c6-29b3-08dc470e39a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2024 05:42:40.1933
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 68Mx7PnqV6GEIM9Nm9gNUkPUTn6S3eoqrZNzZ0GWWdFI6p0wPb1yY1Q1d8ZOVWdq1tjAmFHw3BH0dVCG+9Y3uQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB6849

SGksIEp1bGllbjoNCg0KT24gV2VkLCAyMDI0LTAxLTEwIGF0IDE1OjE0ICswMTAwLCBKdWxpZW4g
U3RlcGhhbiB3cm90ZToNCj4gIAkgDQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBj
bGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVk
IHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRlbnQuDQo+ICBGcm9tOiBQaGktYmFuZyBOZ3V5ZW4gPHBu
Z3V5ZW5AYmF5bGlicmUuY29tPg0KPiANCj4gVGhpcyBkcml2ZXIgcHJvdmlkZXMgYSBwYXRoIHRv
IGJ5cGFzcyB0aGUgU29DIElTUCBzbyB0aGF0IGltYWdlIGRhdGENCj4gY29taW5nIGZyb20gdGhl
IFNFTklORiBjYW4gZ28gZGlyZWN0bHkgaW50byBtZW1vcnkgd2l0aG91dCBhbnkgaW1hZ2UNCj4g
cHJvY2Vzc2luZy4gVGhpcyBhbGxvd3MgdGhlIHVzZSBvZiBhbiBleHRlcm5hbCBJU1AuDQo+IA0K
PiBTaWduZWQtb2ZmLWJ5OiBQaGktYmFuZyBOZ3V5ZW4gPHBuZ3V5ZW5AYmF5bGlicmUuY29tPg0K
PiBTaWduZWQtb2ZmLWJ5OiBGbG9yaWFuIFN5bHZlc3RyZSA8ZnN5bHZlc3RyZUBiYXlsaWJyZS5j
b20+DQo+IFtQYXVsIEVsZGVyIGZpeCBpcnEgbG9ja2luZ10NCj4gU2lnbmVkLW9mZi1ieTogUGF1
bCBFbGRlciA8cGF1bC5lbGRlckBpZGVhc29uYm9hcmQuY29tPg0KPiBDby1kZXZlbG9wZWQtYnk6
IExhdXJlbnQgUGluY2hhcnQgPGxhdXJlbnQucGluY2hhcnRAaWRlYXNvbmJvYXJkLmNvbT4NCj4g
U2lnbmVkLW9mZi1ieTogTGF1cmVudCBQaW5jaGFydCA8bGF1cmVudC5waW5jaGFydEBpZGVhc29u
Ym9hcmQuY29tPg0KPiBDby1kZXZlbG9wZWQtYnk6IEp1bGllbiBTdGVwaGFuIDxqc3RlcGhhbkBi
YXlsaWJyZS5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IEp1bGllbiBTdGVwaGFuIDxqc3RlcGhhbkBi
YXlsaWJyZS5jb20+DQo+IC0tLQ0KDQpbc25pcF0NCg0KPiArDQo+ICtzdGF0aWMgY29uc3Qgc3Ry
dWN0IHY0bDJfc3ViZGV2X3BhZF9vcHMgbXRrX2NhbV9zdWJkZXZfcGFkX29wcyA9IHsNCj4gKwku
aW5pdF9jZmcgPSBtdGtfY2FtX2luaXRfY2ZnLA0KDQpJbiBrZXJuZWwgNi44LCBpbml0X2NmZyBo
YXMgYmVlbiByZW1vdmVkLiBQbGVhc2UgcmViYXNlIHRoaXMgc2VyaWVzDQpvbnRvIGxhdGVzdCBr
ZXJuZWwuDQoNClJlZ2FyZHMsDQpDSw0KDQo+ICsJLmVudW1fbWJ1c19jb2RlID0gbXRrX2NhbV9l
bnVtX21idXNfY29kZSwNCj4gKwkuc2V0X2ZtdCA9IG10a19jYW1fc2V0X2ZtdCwNCj4gKwkuZ2V0
X2ZtdCA9IG10a19jYW1fZ2V0X2ZtdCwNCj4gKwkubGlua192YWxpZGF0ZSA9IHY0bDJfc3ViZGV2
X2xpbmtfdmFsaWRhdGVfZGVmYXVsdCwNCj4gK307DQo+ICsNCj4gDQo=

