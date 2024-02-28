Return-Path: <linux-kernel+bounces-85276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FABB86B354
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 16:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF4651F29B13
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 15:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9C115CD5C;
	Wed, 28 Feb 2024 15:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="USpv8WmN";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="BZ4kkfcY"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6F41487DC;
	Wed, 28 Feb 2024 15:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709134756; cv=fail; b=Ic8wt5LBLRJ2DWt8JJr59vBTxGnimwLCEjvVkgvj2jEXZo929Npr5M0R7yTlNLeFp/fp4CQkDwlZwnABZORQ0QVBSXIgUoP7T8ZBzCuNMs3A7EV2E/6NdDrMpt3Pk94VcPfJxgPk4llP9QPGnCsWVIFyepM+DFcDYwUvYcvs7xc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709134756; c=relaxed/simple;
	bh=UXxUNaLGSROf2xTrnRKTB5pxoI6VbYtFN8L6JrOJBRQ=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=hOLd11eYWyvSIme0TQuIHaQm+KdGsYq8OfeiAgyvYOBKHY2XElkp7cMg0/tNey3z6CXfQgA+DxRpY+7zxvs2HX+MtXgc2qxg5+EyDFrGykPOfKJ0fB9bNMCprtIIFHS+jzFwuvl4akMmq1bml9qNrerSIYf2DPF7CvROySWcEs0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=USpv8WmN; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=BZ4kkfcY; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 7e4db054d64f11eeb8927bc1f75efef4-20240228
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:Message-ID:Date:Subject:CC:To:From; bh=UXxUNaLGSROf2xTrnRKTB5pxoI6VbYtFN8L6JrOJBRQ=;
	b=USpv8WmNhC9TrSt6Cn7uWhg6XjLaOBKo+LBFS55bq6KyyhHHCQyavwUKwY+pnWY4MzFU57fxGkm5t7V0QW7286TlTHiorEFA9bd49CYOGa6aJl98CuAo2fADBuk9fdSN9/Rmq/7mdoc4KbrTWV6l1eSp2K7XUiEOWgge3VvmYBs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:797efcf4-94ec-40f7-ba8c-04804dcad735,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:c06cd08f-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 7e4db054d64f11eeb8927bc1f75efef4-20240228
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
	(envelope-from <lena.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2061893283; Wed, 28 Feb 2024 23:39:00 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 28 Feb 2024 23:38:59 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 28 Feb 2024 23:38:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UDLcarmWxEFsxI/qlR1FgCfk2DxzjanqU1ImdT2Kf1hwu8J7LmkSLVEn3cKrGW9jGT4JcIjoFQW8QavZ8El11twdx0oZdXrcwqGqb1yHKntRRK+iTBB49lx0nmmq/hirQ6r23SRsRFw3yoI9XZyHPnaiOLPkmvUoEJjO7s62eS+nSQRakkt/FpiE+/tAhOvsf6J7ZH0XLjC1JvJauso93C9fNAJLwGvZTcFJ1+5RXPv/ES/XTKXFisVoUqnYtS7Syl5g81wXAyjvdMs/LeXrABaWtjylDivGCTxuKCIMr8mJCmve6LWIBaY1GezCHMmCeLqr6CFHny85i8t9oM9fwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UXxUNaLGSROf2xTrnRKTB5pxoI6VbYtFN8L6JrOJBRQ=;
 b=U2U6DezO5iggoSzYt6IjRLIkY1mstTM6PB2+lEcVfyoGUnSHOF6aJfUfBqhGziNGqNfXIV+yK3vQat5fmBTiCyhmaWpsaDb0mW5xDi8Hr1YsdP8PQiUXibWhGjSr08S5w9I88OxRnTNebcGJ8dh/N2/PT5z1+Z2dplRKSAV9pv9fM68oo4X9d7NdBdLNwisYkY9IoxdgBrgcEvFHuCl4o6+c1J2xt5brV9Io03CBCEp/FSA846U7nbGwWW0hXSc+e6sDBB5tTFStW24pf8EjK8lTEzaKFXFd7YB4pKc6HTF0TlEEgvEYrdOI3WBYcyULcwUFJgjCFDaQO2PivCsT8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UXxUNaLGSROf2xTrnRKTB5pxoI6VbYtFN8L6JrOJBRQ=;
 b=BZ4kkfcYtzeiTeXhy9u0swawq/uMhpldeMtCW7x9tSJrNk3j7RITuPUILnw9PxBjW0zhvAgaIo0Qs3Ca6Mf1soMBb9dtRQH7gX3YDUdklxxjtpEo+CpgxBEaSLxqNelav3V7m3E1polULWYqoTrwmckDOoAPyEkh/6/Bp1MTKRU=
Received: from SEZPR03MB6466.apcprd03.prod.outlook.com (2603:1096:101:4a::8)
 by TYZPR03MB8560.apcprd03.prod.outlook.com (2603:1096:405:68::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Wed, 28 Feb
 2024 15:38:57 +0000
Received: from SEZPR03MB6466.apcprd03.prod.outlook.com
 ([fe80::8814:cbff:5bbb:98ea]) by SEZPR03MB6466.apcprd03.prod.outlook.com
 ([fe80::8814:cbff:5bbb:98ea%2]) with mapi id 15.20.7316.035; Wed, 28 Feb 2024
 15:38:56 +0000
From: =?utf-8?B?TGVuYSBXYW5nICjnjovlqJwp?= <Lena.Wang@mediatek.com>
To: "davem@davemloft.net" <davem@davemloft.net>, "kuba@kernel.org"
	<kuba@kernel.org>, "edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "jiri@resnulli.us"
	<jiri@resnulli.us>, "dsahern@kernel.org" <dsahern@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	=?utf-8?B?U2hpbWluZyBDaGVuZyAo5oiQ6K+X5piOKQ==?= <Shiming.Cheng@mediatek.com>
Subject: [PATCH net v3] ipv6:flush ipv6 route cache when rule is changed
Thread-Topic: [PATCH net v3] ipv6:flush ipv6 route cache when rule is changed
Thread-Index: AQHaalw91Rv7H6OFS0Wr4eaCYscTYA==
Date: Wed, 28 Feb 2024 15:38:56 +0000
Message-ID: <c9fe5b133393efd179c54f3d7bed78d16b14e4ab.camel@mediatek.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB6466:EE_|TYZPR03MB8560:EE_
x-ms-office365-filtering-correlation-id: 26519958-9382-48f1-5b5a-08dc3873602a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hR7IFUn/zvhxk5bkyslFWpRVeEiLVoLYZwVQNSYhynPMApSlj2bcYVPgrYIOoSliUqS0E8S28YL9t3nWgvglVYBuUPYkMaNUXv15nXsvRiNIMiV+S51NdOnMZZgiKaukfgCG36I44yrnFBOSEAAUj3nHnje5DvfsA0az78DkQLeip2JKC87bQRVcyjqzUjMqmGkuddP4CIzMQiRjqHkqDSPXpdmZxKVLyjaWj8DuJSB8ZspiISs4rbAUSL/ixf92oTYYaDiwU5N5gTj/TwqyMGGCmsgRzovxl1CaeeyeT1vDdsPcXNjVPVZNviX51bFDiqC3OIElHAY4gjmYGOVB2Jas5XE7FUyk7vVtDKMAUGF/xr/nYdi1DlFRcCEAXsnj0OfdxB39txx+qkBrJy6izkuJggVD7131R3KcfXD2qrC2By1zAAX1ZuQ/wk7O2QnBb30sYEB4+JC0bt3DOaLdLI+u1CIPCuZ1FBsoWwnhuNzUMAjG1gv2uFbYzffGCz4owUft6fMZL5FIfCB/vQCH/n22XmPuaGveHYp7eJFh0QIqxT904ZN8DwSuFFvaviSPFRvb7k+F6ahpTe9JpKbIt6OmrMP4k00RWHdV8Q1bxl9L6SQL2nfHHGWDLlusZ/5HsFniasMQDgLcJdZT9+/WWY0cRBrR3Q4m3CSRkWOpw0QF0BDH+rBxG1Msu52E5AGveTlv3Qm9E/foKMJF/syvVwBaMCFSwfFTNiXLFB1yoAg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB6466.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T08zbTlkRHZ5MWdqeHN4ay94KzliVGtncWlUcEVNWWsxbnJsMGpaVGN5Z0I0?=
 =?utf-8?B?V3RlbHhuL1hYd2x4ek1mUGhsdkRwNWZCNG1OekVaSS9rdVVHVHA4dFNBUTY3?=
 =?utf-8?B?KzFaVjdlL2VLOGh5MDNnZlZvenhycjlUeXppS3orblVCZ0lNc0RENExkUGNY?=
 =?utf-8?B?bnl1NktiV2RFbms2TkVTZkp3cTZWTnJySStKYUxkZTVxSUIyTW1tS2FoS2NM?=
 =?utf-8?B?QmxSb0xKWUtxQlVJRVV1V2d2M3FpY05TSWpNcWxGSGF3amlkVjczSWt1OWho?=
 =?utf-8?B?NWpuVXRrK09TTmoyaVNkUDdra3Y0SkZ0eUNtWEdmY0VZREpGZDNacUpndXJG?=
 =?utf-8?B?UEdlZHkvZG9xeW9vMlB3di9Yeno4a29DLzZ5bklad3hmOC9jWUZnTnhia1pN?=
 =?utf-8?B?QnBBZW9kbDBJMjJ1QmJuL0RVa0dmSXNZejdxK2t5MjE0MnNtMWZrZGUwSjlK?=
 =?utf-8?B?YndZMlRkMEY0TWNqSUtESlorMkRlVncwbi9XaFlZZlZuU1ZXWUJUZURTM1pq?=
 =?utf-8?B?cWdJd0xPMzhvWEJLeXJERmt4YlBjTWFBN1JqYmdrUjJRWXNCYkVWdjJ0SlE2?=
 =?utf-8?B?UFQzOWI0VWhBUnVpR0NETzViclFRTzR4RmJKOGhvRUxrMERDREhrQ1BTMHdL?=
 =?utf-8?B?YVh0T01kNWQvK1ZKRTZGTVlYRzVSSlcreDJvT3JYdDh3MlZCazRRU0FtSU92?=
 =?utf-8?B?djBUTkluZkZBS09PVjIzeGlDUFo2dDlGeWJJMGtSd0hKZHFPYWppS0xlbDAr?=
 =?utf-8?B?cUx4TjZsV1diemlUOGU5TXRDN3VGTzFXWk9hWE5mR3o4ekxEcUg3eGltbEwv?=
 =?utf-8?B?ZzlDdm5iVU9ZS3ZadzJ3d1U1OHRnL3ZUNW9yd01HajdSTDZyUVpPZm0wWms5?=
 =?utf-8?B?ZW95OUZsZ2VBSVllOGtFRVFDZm5qYzBabVpwWXZpTS9IK29VV2Y1OTE2VHFn?=
 =?utf-8?B?OUY3NC9mVFhlU1F5VlM2RjM5K0NDNFVHR3pvcE9XZlBHYlErVTZyVmRzSjhD?=
 =?utf-8?B?TU15WTdhUGJHL1J3elI4TXhJTXVONUczb2Q4MDVjdjdYbTFwcGd6TXBnU1o4?=
 =?utf-8?B?bTIyYzd6aURUK0lVNkJDdzNPamx0TDZRUFNyOGVLN1Q3Zi95bGE3bkhhY2ZD?=
 =?utf-8?B?b1JTbXdENmRUMGhiVzlWcjNiZDlUMzNOR0JCOWkzV29vYUIvVG5Ra0Ywb2x3?=
 =?utf-8?B?SHlldkVXQnRYL2Z2UnM5M3pIa0tEektJU01FMlo1NkJMN0RsRkFDK3J4NmJH?=
 =?utf-8?B?R0RURmFEdnhNaStmcG5USEVNYkRhVjEwNnQ0NVVqZ00yZWVsb2JzNzNDVE01?=
 =?utf-8?B?eXQxQTVSekxPSnJqTjlELzNvWlhBZ2pYeGJib0cxOFpMeUFSZUk0SGxWdisv?=
 =?utf-8?B?UzRmZkZlL05uelphS2RVOGNib3ROYlVja0lhV2JEQzUvV0REcXRFRmxtSVJY?=
 =?utf-8?B?ZXFJaHlnSFh0OWRnT2dORlB2aWx3Tlh6QzVqY2lLallmYldGNE1ZMExvZzJj?=
 =?utf-8?B?a3dlWHlDcnBHSHhaU3Y3QTlmU1hVTkdRaWVHWUtNZ1dTSUZGM1czcXEyY1dy?=
 =?utf-8?B?WHg2NExRbDNsWTAraEhEamxoYWsrbGsvQkQ5STl6WEhhaitTaGhnTjRQeXFK?=
 =?utf-8?B?QlVXTlVZZUpyelJKK3FLMTdVVWRHWnRrWGZDYUtIRkhsTmgxOUR2VmpDMk9y?=
 =?utf-8?B?OFM5V1BOSWZmYVFMb2lPYnhLUkNKeFJFSHdHSmxuQ2lnVTRNN1pBZTlNd0Zr?=
 =?utf-8?B?cHdzSm90eERLcVBMUWZqaU9rUFBrbjZtaFpGZWtkYjVEN08weDR6STd4VkQ0?=
 =?utf-8?B?S2c2RytXYlZSZXAwQm4rcEhkMVBzdnRhRy9KQUVJMVFGVThmUVd5b0tqeEdq?=
 =?utf-8?B?RFFWREVKVkxQTjR6Mm9WOVhvVG43anZhWGkvbkhPOU5RZy9SN0IvYjJaczJU?=
 =?utf-8?B?UUFPTzZDd1RkVExtbEc3TDVzT0srMWZ2bGEzVVdTUWo0cXMwVWRnZ25uWnhC?=
 =?utf-8?B?RnpnSkcwRm9aUzhieHU0QTBSYTcyY1BSTEdrUlBuMER1TTVkWm55anVqV3hs?=
 =?utf-8?B?Wklwb2JUY2dPViticVp0YndleXpNemtDanJUL1NzYUlldE56eDZUa0E3VDJx?=
 =?utf-8?B?eGVSMXpOTWZzRmU5MVlxcUM1cmhpTVc4dk45RUlyVFY2YmZMdXk3UjI4OXNG?=
 =?utf-8?B?RFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9EC294021F721A4795BFD46FB476917E@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB6466.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26519958-9382-48f1-5b5a-08dc3873602a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2024 15:38:56.5292
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pANkv+HxqMlmJSR+vbvPsmN7Qmz8OAHD25N1IurM6OwlhomH8BvW25YosGcEE8516dz+38Njj8kvSv/WuNUr0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB8560

RnJvbTogU2hpbWluZyBDaGVuZyA8c2hpbWluZy5jaGVuZ0BtZWRpYXRlay5jb20+DQoNCldoZW4g
cnVsZSBwb2xpY3kgaXMgY2hhbmdlZCwgaXB2NiBzb2NrZXQgY2FjaGUgaXMgbm90IHJlZnJlc2hl
ZC4NClRoZSBzb2NrJ3Mgc2tiIHN0aWxsIHVzZXMgYSBvdXRkYXRlZCByb3V0ZSBjYWNoZSBhbmQg
d2FzIHNlbnQgdG8NCmEgd3JvbmcgaW50ZXJmYWNlLg0KDQpUbyBhdm9pZCB0aGlzIGVycm9yIHdl
IHNob3VsZCB1cGRhdGUgZmliIG5vZGUncyB2ZXJzaW9uIHdoZW4NCnJ1bGUgaXMgY2hhbmdlZC4g
VGhlbiBza2IncyByb3V0ZSB3aWxsIGJlIHJlcm91dGUgY2hlY2tlZCBhcw0Kcm91dGUgY2FjaGUg
dmVyc2lvbiBpcyBhbHJlYWR5IGRpZmZlcmVudCB3aXRoIGZpYiBub2RlIHZlcnNpb24uDQpUaGUg
cm91dGUgY2FjaGUgaXMgcmVmcmVzaGVkIHRvIG1hdGNoIHRoZSBsYXRlc3QgcnVsZS4NCg0KU2ln
bmVkLW9mZi1ieTogU2hpbWluZyBDaGVuZyA8c2hpbWluZy5jaGVuZ0BtZWRpYXRlay5jb20+DQpT
aWduZWQtb2ZmLWJ5OiBMZW5hIFdhbmcgPGxlbmEud2FuZ0BtZWRpYXRlay5jb20+DQotLS0NCnYz
OiBDaGFuZ2VzIGFjY29yZGluZyB0byBKaXJpJ3Mgc3VnZ2VzdGlvbnMsIHVwZGF0ZSBwYXRjaA0K
ZGVzY3JpcHRpb24gYW5kIG5hbWUgZm9ybWF0IGluIGNvbW1pdCBtZXNzYWdlLg0KDQp2MjogQ2hh
bmdlcyBhY2NvcmRpbmcgdG8gRGF2aWQgQWhlcm4ncyBzdWdnZXN0aW9ucywgbW9kaWZ5DQpmbHVz
aCBmdW5jdGlvbiBzYW1lIHdheSBhcyBpcHY0IGZsdXNoIGNhY2hlIGFuZCB1c2UgdGFicw0KdG8g
YWxpZ2ggd2l0aCBleGlzdGluZyBjb2RlLg0KLS0tDQotLS0NCiBuZXQvaXB2Ni9maWI2X3J1bGVz
LmMgfCA2ICsrKysrKw0KIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKykNCg0KZGlmZiAt
LWdpdCBhL25ldC9pcHY2L2ZpYjZfcnVsZXMuYyBiL25ldC9pcHY2L2ZpYjZfcnVsZXMuYw0KaW5k
ZXggNzUyM2M0YmFlZjM1Li41MmMwNGYwYWM0OTggMTAwNjQ0DQotLS0gYS9uZXQvaXB2Ni9maWI2
X3J1bGVzLmMNCisrKyBiL25ldC9pcHY2L2ZpYjZfcnVsZXMuYw0KQEAgLTQ0OSw2ICs0NDksMTEg
QEAgc3RhdGljIHNpemVfdCBmaWI2X3J1bGVfbmxtc2dfcGF5bG9hZChzdHJ1Y3QNCmZpYl9ydWxl
ICpydWxlKQ0KIAkgICAgICAgKyBubGFfdG90YWxfc2l6ZSgxNik7IC8qIHNyYyAqLw0KIH0NCiAN
CitzdGF0aWMgdm9pZCBmaWI2X3J1bGVfZmx1c2hfY2FjaGUoc3RydWN0IGZpYl9ydWxlc19vcHMg
Km9wcykNCit7DQorCXJ0X2dlbmlkX2J1bXBfaXB2NihvcHMtPmZyb19uZXQpOw0KK30NCisNCiBz
dGF0aWMgY29uc3Qgc3RydWN0IGZpYl9ydWxlc19vcHMgX19uZXRfaW5pdGNvbnN0DQpmaWI2X3J1
bGVzX29wc190ZW1wbGF0ZSA9IHsNCiAJLmZhbWlseQkJCT0gQUZfSU5FVDYsDQogCS5ydWxlX3Np
emUJCT0gc2l6ZW9mKHN0cnVjdCBmaWI2X3J1bGUpLA0KQEAgLTQ2MSw2ICs0NjYsNyBAQCBzdGF0
aWMgY29uc3Qgc3RydWN0IGZpYl9ydWxlc19vcHMgX19uZXRfaW5pdGNvbnN0DQpmaWI2X3J1bGVz
X29wc190ZW1wbGF0ZSA9IHsNCiAJLmNvbXBhcmUJCT0gZmliNl9ydWxlX2NvbXBhcmUsDQogCS5m
aWxsCQkJPSBmaWI2X3J1bGVfZmlsbCwNCiAJLm5sbXNnX3BheWxvYWQJCT0gZmliNl9ydWxlX25s
bXNnX3BheWxvYWQsDQorCS5mbHVzaF9jYWNoZQkJPSBmaWI2X3J1bGVfZmx1c2hfY2FjaGUsDQog
CS5ubGdyb3VwCQk9IFJUTkxHUlBfSVBWNl9SVUxFLA0KIAkub3duZXIJCQk9IFRISVNfTU9EVUxF
LA0KIAkuZnJvX25ldAkJPSAmaW5pdF9uZXQsDQotLSANCjIuMTguMA0K

