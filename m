Return-Path: <linux-kernel+bounces-84616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC2E86A90B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 08:35:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 004A5B22DF3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 07:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B7825611;
	Wed, 28 Feb 2024 07:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Ki4FR1UO";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="eyzAeFAc"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842F625602
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 07:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709105714; cv=fail; b=FLBupWwUjcbzNzJXsnl0t5RadQs8WVUU7iiO2tjDlSSIiHrwmORnByz2GZRjnanNtO4aVHFGUbNQ3CjTnqjBslOX/ARSE3UHTagDN0VvPIhub1Wfb8+IaCkxOyaB9uYZrG8BcmF0lPKBJ4mWoeMQQiJppJgxNytTSxRzQYMKDew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709105714; c=relaxed/simple;
	bh=46B/osF48vqozFVysVJma4Ab4656LlANZgkGG2NCUZ8=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=UZhHVhbEsqaxhWIsY9dskiWgB0kDciqaXQNTPYsuSkGoE4p2ldR23bXNXJ5LYOAetShJeieDNDAqVJ7tr60sSJC9eR4HzB8uPSB40QGvdH8X2QBFuEjnUivxG6jHdMqlPdxENOAkIVUglkjOJSyhM4GH6E7b9wa+zqTWPZuM9rY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Ki4FR1UO; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=eyzAeFAc; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: e312ebe2d60b11ee935d6952f98a51a9-20240228
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-Type:Message-ID:Date:Subject:CC:To:From; bh=46B/osF48vqozFVysVJma4Ab4656LlANZgkGG2NCUZ8=;
	b=Ki4FR1UOUXK9ykr1zy/esbOXiqdkg/pa88s1BCIFGxiIsAQc85B8OepggY5yR7wlGPvKrPJLb7+1Fwofi2PTkLNSVIvQ1uEN0P+7IGLmRHNiGfJ0CR/OkDPbwNXRhVCjh/g2s4KET5lJ1q/GdJpJB527Yd9+haI2o0F7tXHkcAs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:5eb7e6cd-4fbd-4238-aaa9-0546a8970791,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:3ea6e680-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: e312ebe2d60b11ee935d6952f98a51a9-20240228
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
	(envelope-from <lena.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 536694341; Wed, 28 Feb 2024 15:35:03 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 28 Feb 2024 15:35:02 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 28 Feb 2024 15:35:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bdbGJt2cHXjK2MAPqLG5bXHhTYZ2FUlcItEeFO7GrskxvODU3sj+yFvcpqzV3JotWyPNfCQdw8280UNZnXE3fzaXcxIMpUkymR3AlOu0bFJzlWqNnT55HaEnIBGPkGsRFbm5oLkv/W8YnCnVRvd1y6mm/HmTv+08HaYXyBdOw9/QWNnf3GpQF6ISNZ3JU89Wi53N9d0kops+oGnQV1HlPhUh1aENWUxTh4FVzOOO0IIfvgZvVbux6SWfAuVHIsxUGk51bUHUtUq0adGr60YyT0DW/avukkUMrAd/4y+mwik91+eU2D/X9iCaXpETZvk7Ij3p34lvOdyQCsZ1Oq36Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=46B/osF48vqozFVysVJma4Ab4656LlANZgkGG2NCUZ8=;
 b=L66nBNFbAanZAw02aSBVxD9/9X1Th6Ys4XSfrWJO7B/fZzTO06H9umcWVwBQwzu0k55UruPc4xQZAAMsDf5wh3Hz5TX+jI0rR0/BiTkv14rIS2NiAnggh/JGcmPwhDqTCrgqdbkUHVp/2J2WiP9COvq4k3sxrYwQ4rnkcMu0CbLTx2LZlhTKi1FsKZZBzw4ZgbmP/eDUkeaMtqcEeYFRo4Fsey8c9BJ+VfxIRcHbhsSElbl/xYn+H8FQDajM8kxoQnDzYE2n+84yple+WarW1CotfkIC6h/ZeYb7o14MWyDMGSkVZphxPW4NsZNEbjK1FmJDURE0QcCYNW46uKGKRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=46B/osF48vqozFVysVJma4Ab4656LlANZgkGG2NCUZ8=;
 b=eyzAeFAc+SVh6N0WGiC5jIeBdPFaOg/M//vYn3XTeqp9eJM5lgON4V7r9JxucSefzfDo1pK6b8pARm6FNfXpSXq8+QUOnCplCdAdhLDWdWfQTs0gm91SnwOX/NIvceiYC33LDH2svuTEvxyJs51pYfp/xgxf1gvCR0cVfLEQ5A0=
Received: from SEZPR03MB6466.apcprd03.prod.outlook.com (2603:1096:101:4a::8)
 by TYZPR03MB8726.apcprd03.prod.outlook.com (2603:1096:405:65::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.33; Wed, 28 Feb
 2024 07:35:00 +0000
Received: from SEZPR03MB6466.apcprd03.prod.outlook.com
 ([fe80::8814:cbff:5bbb:98ea]) by SEZPR03MB6466.apcprd03.prod.outlook.com
 ([fe80::8814:cbff:5bbb:98ea%2]) with mapi id 15.20.7316.035; Wed, 28 Feb 2024
 07:35:00 +0000
From: =?gb2312?B?TGVuYSBXYW5nICjN9cTIKQ==?= <Lena.Wang@mediatek.com>
To: "davem@davemloft.net" <davem@davemloft.net>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"dsahern@kernel.org" <dsahern@kernel.org>, "edumazet@google.com"
	<edumazet@google.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?gb2312?B?U2hpbWluZyBDaGVuZyAos8nKq8P3KQ==?= <Shiming.Cheng@mediatek.com>
Subject: =?gb2312?B?s7e72DogW1BBVENIXSBOZXQ6Y2FjaGUgZGlkbid0IGZsdXNoIHdoZW4gaXB2?=
 =?gb2312?Q?6_rule_changed?=
Thread-Topic: [PATCH] Net:cache didn't flush when ipv6 rule changed
Thread-Index: AQHaahiiDbAo8QCNvk22D0aZ15eYqw==
X-CallingTelephoneNumber: IPM.Note
X-VoiceMessageDuration: 1
X-FaxNumberOfPages: 0
Date: Wed, 28 Feb 2024 07:35:00 +0000
Message-ID: <SEZPR03MB6466B3AFC60423B4EE263AF39C582@SEZPR03MB6466.apcprd03.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB6466:EE_|TYZPR03MB8726:EE_
x-ms-office365-filtering-correlation-id: e467d483-3616-4643-24f5-08dc382fc52e
x-ms-exchange-recallreportgenerated: true
x-ms-exchange-recallreportcfmgenerated: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mpyqtLpELPhDPHODNdiZhtPpHeRUg+FjQvtscqkco80GXB3cSgW/Rox/FuLWSM6GnUhWxMin0G66y5ICYheweJytaB3ytFgkpTVLtKfi6h27/rH9ZPmfy4KG01vBgcsppgckm8NSKa3/JqOIf/b1DO14WHmZmFxxREJcBOr5tebSKSCmp8Mhl/SW542KbztvJbcLotmS+TWaN9Yqmw6OL796upjeKllmA0nLpkWIs7M257lCqirLnNFdiiWGmIUyc2xtZDsigFJBz4HnzeY6t+I5QaX/2J9/BsnlQxslHNFAmss1jn1UcvK+LKMG18Z+avr1zQLEdprD6fFjZY2SP78e2MZBy8h9eBWr+zP6sx4tzL9H+htTjZplSzDEddeHbWRS+gYP3LjhFkrxG1ytBk82zgDEyKgh2NifhKN6z5U0LlOTzzADJzROgKye2RCJixs7RPQeoEy28TYXfCPeg9reOmiLcFVFT1xVxA3Y8SxB2cSE/3PXnQQGV6pTRZzsJ92hZeNK868r3KJJZGJU/k6est+ZkAgFG40381BTqU71KHii3FSyn2qH9pi99slun9KZMmoOZscntQ+UzGnkysWYdG0Ncarm/tk2fsS3Cr392oWBFV8lF1eBXBgqB5IXDrMq6eLF3TQ9LbHhvaEN2cXlye2GI1tEwYXHGtwniXCfABzyeaxdIHG2kWDsHUhV8ttd8KmMsKVrt21Awc4fZijq2YAjIpiqYUx0D1DnHBs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB6466.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?aFdmeWlxc3BOdnQwMTN0Z1lzSU54NmpwSE9OdE43amg5ZTNiV2x4dW0vb296?=
 =?gb2312?B?amJ0S01nWVhCN0dwc3U2czFVK3c2NUJ5Mm83b3VPUGJFQnhWNXd3bGZxc0Fl?=
 =?gb2312?B?Y1ozQjFqRFBkNlNMSVBabmxtQU9xbFh5NFBISEZBL0ZxMmJISVhzbUVDdFpN?=
 =?gb2312?B?Sy9KRnA5Uy85WGg0WmRWeldmWURqTlYxK0lIWDhYVnFBcE1aZ3YyUlM3MFNT?=
 =?gb2312?B?bHh6STExWnB0aFk0WDJQOUQxbXFaL0FDaXg3c2ZTMVBSSElxeVA5enY5M3ZN?=
 =?gb2312?B?eDR1RlQ1Q3RWYW40bXhlUFVwOTYrOUNhMS9Wa3YxaUFzZjhNVDYrT0h0SFZH?=
 =?gb2312?B?UUxHZGJkTjdMS2NKQW90cHJWUkVrWlZCejRVZERlQ2ZmMzZ3SzNTaWl5L0d5?=
 =?gb2312?B?TmxnTnFEdmZyQ2kveEQrYlE1d1QzdTd2OVJWb2lFVGdCNmdUQzJZZkVZaVRM?=
 =?gb2312?B?TUh1NWpnL3BndDRreWQ5aHd5UXgxdmdCL0k2YUsvZytMbDVxNnBNYWhXYjVB?=
 =?gb2312?B?VW4wcFFiL001N3oyNHRuNE1zWC80ZWlJUW84UGZpNnR3QWVSVm1hblpDKytW?=
 =?gb2312?B?V2JrUzRiVUFLdmI3ditBcWVJQ2hmTSs1SzdjbC9SVnZuVXVRMFRyc1ZEUUtI?=
 =?gb2312?B?TmIxM1FDRGswRllFOWJicDg1V2pzUG9WbGZJODl5TmMvL2EzYUxyS3NKNFp0?=
 =?gb2312?B?MVZTb2dCMXZBN3NMM2ZLYmR2cUprekJXUTF3dVFJYXU0dTc3TE11c1ozQ0t5?=
 =?gb2312?B?RkNrNG41SEpHR3h2NW5zKzFPc25oNEJCUTU4MThMWmpSRjIxMWFaaHBTTkx0?=
 =?gb2312?B?dHlTbEhTWEllM1Y4cWhFNmhzU1dheGswcUlZZHJ2b1l5T1UrMmNTekRIU0ZN?=
 =?gb2312?B?cG9NUGpqUnRSTWgxUWRiN3ZmbFJqbEFhTW01Vk0yNU1aZ2l3WjU2RHRhUmFi?=
 =?gb2312?B?UlcrYTk2Y1gycHNZOHE4aCthRTIwS0ZtWVBxMXBmSnhQdk9McHhXZ0lONWRR?=
 =?gb2312?B?d01SM21YenBoR1RKM1g4VURDSW01VjF6Z2hBYk40YnFTZ0VIdFJJTUdldHRY?=
 =?gb2312?B?ak1vTXRocXBoYmJMYkhtMjV5QStkR3BtWFF0VWZJVG5lOHhMMTcrU29WT1lr?=
 =?gb2312?B?K1hsT2RWNUNNWEFuenRvUVlUT3FnMjB5Q0daRHlZWGUvZGZnL0wwZHVyOGtN?=
 =?gb2312?B?TUZsay9kR1RBWmQvSVFRejJmN0xQczBoZXViTGJ1WUtyQTJ2MDUwSDU4T1FY?=
 =?gb2312?B?NWNURlBDcDdxd1NCbmRjUGw0ZHBVaitBQWtDay9GVTR4R1hIYVhLOXgzWm5a?=
 =?gb2312?B?YnZGWFlLQUJITDFtWTBCWEtlMDRSRFNTT3Y3OGFHangxVE5rcDl4MGtnb21Q?=
 =?gb2312?B?c0ZDR1VOZnhiOHpRRk4yeklJUGViRndYendTVGZBTVhORlUvSXZhTUpIQ3BY?=
 =?gb2312?B?ZkJjKzcyeUpZMXRjUEpaQU8rZXhxK1VtenlvM2dsNDFHNm9JMnJyY0lXczly?=
 =?gb2312?B?NmR5bVBVYmJxTS9YT1ZENHJCZGg2K0NrTEJOcHlUcFpaQ1JoYTJhUjlrTllV?=
 =?gb2312?B?YVN5ZHAraXlURW1nTXdoZHJYRm02WTBHcXR1YTV1UDRuU1hoblpSMit1cWVS?=
 =?gb2312?B?a3VZWUJYbzA2UVZ1ditjei9QTGh0ajBuRFU0cGxrcU9Sb0dYZUswOEJHTUxl?=
 =?gb2312?B?dWRaRUpaUjJGemFDMXJSQzU0czhXQlR5eDhyUTArS0RmYm1IdnNNdTJjaFpK?=
 =?gb2312?B?RVc3LzJKRzJlTnVxYmhPNVBvTTdaV0NDNXY4bWJXMnArYWprU0hLdlVmbXpO?=
 =?gb2312?B?emh1QzJCc0JRbE1qQ2hrVkU2Y3U3dWN4VkpzYUFjS0QrQ2ZEVWx4dHJ3YXJr?=
 =?gb2312?B?TXVXb25KWXpyYVpvQVI5elJjYXhEd3NzZzkvRG5ncys1QW9aWHhvaTNwOEFM?=
 =?gb2312?B?NGNUV0Z1TDZBLytZRUN4K3FFK2JNR2ZhaGhJMzdKakZxTUJBYlo4a1FpNHFW?=
 =?gb2312?B?SFA4MGlhZ21YdGNsN3VkWE5ZcGxUMlkxM3p2NHVTUEpPc2lTVDFJRnBkeXRt?=
 =?gb2312?B?eVN4ZWlXaFBjRks0d1hXNjBDK2E1TG9KNy9wd0ZSU0xSMEU2SjV2TGswQnFS?=
 =?gb2312?Q?qyCv6niVZs6Qh9D4J52mOHiZI?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB6466.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e467d483-3616-4643-24f5-08dc382fc52e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2024 07:35:00.1984
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RxP/ZEFQQld5+36ZEGiZiPf6LAHL4xQ+mBPWnxruu6jccvdm+wiDwS2lwnZ5sUukFcWZSRV2zckZJWZOJOQJyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB8726

TGVuYSBXYW5nICjN9cTIKSC9q7O3u9jTyrz+obBbUEFUQ0hdIE5ldDpjYWNoZSBkaWRuJ3QgZmx1
c2ggd2hlbiBpcHY2IHJ1bGUgY2hhbmdlZKGxoaM=

