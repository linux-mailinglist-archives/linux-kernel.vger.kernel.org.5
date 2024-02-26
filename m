Return-Path: <linux-kernel+bounces-81451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 114CB867620
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:11:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33C271C2885C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BBDA80BFB;
	Mon, 26 Feb 2024 13:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="l2icFvlH";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="hhWgIdI9"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E65B80C05
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 13:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708953076; cv=fail; b=Rd2Oirx4pvpCEXYHqpM22fzZPs/cBG14jXH5PPVkJh6xEmkZy7QsLaWwwfazx9eb6CoyfqqQbIv6zpzVMlXZaOmhVXQQUasxxIfMhQ5ebdyDJnL6MTFKZ2K7/yt5FtHt4qvp6iSMuSuIILZ/xNLEzHX1xHN2nc1broeYUJPA+ug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708953076; c=relaxed/simple;
	bh=oPp0Y0GfEnx+IIq38q+jklNet/TygBb2nmWz5RORghA=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=OcojLOVXqX+i6Kz7BZOT/DTuAOW4CUVKEl55i+ZUAtmG4ok6M8xaAbLPWr0ikdXdKB5sYvjG+ry6XdVJ1mFza7FRI9po8Q/X8D38NJXoAdgAyVkUu3mZumafyp8DX92dRRbLAxroUe1aDaabj3aQau6jSmN01PNSV24O8WFoIVk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=l2icFvlH; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=hhWgIdI9; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 816f93ccd4a811eea4ad694c3f9da370-20240226
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:Message-ID:Date:Subject:CC:To:From; bh=oPp0Y0GfEnx+IIq38q+jklNet/TygBb2nmWz5RORghA=;
	b=l2icFvlH6Zp5P4r+0obf6uPAIQNSZZOudG5cqxCWpl8pCUScfYza+XAzZm0QaL7V4/ijo53i0fQUTXshmjjApEquABWGgKUfva7JI7lFDH2/G9K2NJv38JrhrJ3/sNsgQPt+eZadVpSKKq7Lse3rJkaxI1RQwngOqpGeNRCdtss=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:c5c1728b-b211-4f8a-a21e-602b62178ab0,IP:0,U
	RL:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:6f543d0,CLOUDID:dca05484-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:5,IP:nil,UR
	L:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,S
	PR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 816f93ccd4a811eea4ad694c3f9da370-20240226
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
	(envelope-from <lena.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1354361012; Mon, 26 Feb 2024 21:11:08 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 26 Feb 2024 21:11:07 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 26 Feb 2024 21:11:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K5idZ6uejDLWQqO3xnoUptiGebOZhO37jysROPKG4fj2KUbzoDrLA2gr0i6XWmDy8QyhZooDM/RW2iArYSU9NpUBGWNQccX0gFbP4Li9PXn9D2AqRBcpNc2NBduXTDY0h+uJc3MP6S01GiQp59iR5+K77LrYDNNLGdKETljU3s1Qowap49XYAUW0Y14wYQ6sYZsxzvxqB0Jf5/6wVNaytNQDBR0YgNzbJiEbbQow7wbZfk+7fRZP3aZoe5bTtcc/xeH5jeV3ZC9RXKN05ML6XcGlXO/mbUxumPhvNiKH+MRuAL10x+kPH4YEa/zr+pRIWfc7vLFLFDWYQxu/Pz6y0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oPp0Y0GfEnx+IIq38q+jklNet/TygBb2nmWz5RORghA=;
 b=gUvJE4Wa0yUOJcGV0xZvlnxN9IKwihplBfbIgAOBJ1wAAmMs8MegfNmurKttkH2fHRdm6NlsMrpdXZIgXVMsR4m5CWk0kAuoI4FVpz2iibyISM0YuRDnmPCfyBVrV11sZEUYt1nZyLUpQ3f2dOwss/l3umRHSeHsMgioYD9xoNkDd0PaQ4EW8Eosp9VDBeegb+TO4G3Q+JfijA3LKYINVbwZ3B01mHnQW1CWrxlhghoWK1wecZA8YvtWKAVhSiN+8DfwCFrfcEJ4FtSZP2nfRCJgwhPLBI7pkoi1NCcfbAapHMj5yn2r/kP4V4+SSeRBKOtUzOnWV8OCRLinhVqJFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oPp0Y0GfEnx+IIq38q+jklNet/TygBb2nmWz5RORghA=;
 b=hhWgIdI91qfJnGssTaxLRWZDOMc8flOwPa4NrzwxoOOsV1jnckQI/i1lXRVeBeArKAR04MtxKp9RiFscnSp7WhQLHIs52coubciN3GZW3wAgLYy+zjZs6MRf70ZesnLkWvnuN9KAewTpTSIzWKEaL9K2I3VTyGiiZl6W/9eMLOg=
Received: from SEZPR03MB6466.apcprd03.prod.outlook.com (2603:1096:101:4a::8)
 by TYZPR03MB7930.apcprd03.prod.outlook.com (2603:1096:400:465::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Mon, 26 Feb
 2024 13:11:01 +0000
Received: from SEZPR03MB6466.apcprd03.prod.outlook.com
 ([fe80::8814:cbff:5bbb:98ea]) by SEZPR03MB6466.apcprd03.prod.outlook.com
 ([fe80::8814:cbff:5bbb:98ea%2]) with mapi id 15.20.7316.023; Mon, 26 Feb 2024
 13:11:01 +0000
From: =?utf-8?B?TGVuYSBXYW5nICjnjovlqJwp?= <Lena.Wang@mediatek.com>
To: "davem@davemloft.net" <davem@davemloft.net>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"dsahern@kernel.org" <dsahern@kernel.org>, "edumazet@google.com"
	<edumazet@google.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?utf-8?B?U2hpbWluZyBDaGVuZyAo5oiQ6K+X5piOKQ==?= <Shiming.Cheng@mediatek.com>
Subject: [PATCH] Net:cache didn't flush when ipv6 rule changed
Thread-Topic: [PATCH] Net:cache didn't flush when ipv6 rule changed
Thread-Index: AQHaaLU+wJdSkCun6UW5mkHaGPp8Qg==
Date: Mon, 26 Feb 2024 13:11:01 +0000
Message-ID: <3efcbaf0872481d1a842eb9e18fa368b4b94d940.camel@mediatek.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB6466:EE_|TYZPR03MB7930:EE_
x-ms-office365-filtering-correlation-id: f9df6cb3-987a-4385-7a6b-08dc36cc614d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6NSuHzr5UbOWUuQcCcsey4u5blonZiu+Ese6omIkcfclsbJ9GtStIRhyoVpMp3FODbhjfqjUZZvLR+VApbFa5pZK0kX5tSYdNy9ZPWWJL5bdupBqJO/OZlIm0gJI5qqMTgZGgWGN1tSG9YcLENn2SxtWFsBhk+xbrz0+jQnZCqsCFR0QH4AMQhO1IZ5TjwnuAaAmHFSGnEO5LKGbk1oZ3YR01YTb3tQaQ6WxpHbHuurC48OWjifYhv//JRmHZ/v1n9LZNnhUNA7dmUyUxOvdjrnYEZtPwJ1ysxCHXQm71TlGK+doxptO9WjR+6GtksVliGkHDAVtZ6l9wedLYvSJd0jSsPHrEgb9lz7UjhY+2D1MwlccPUYeeKtJlxzWZkRhSRcQYba2/zOIjo0vSfCnYrcG2uoXSnpJdP2tjY1dBt4AbM29ZT4XUfXMY5W6cTJeDSrvbK7LYdi06rZQPt/y23VKCzd1L9kqnUJ3G/41nyxNCvJM7DKogZhGn5NduV5+B28SmHpHDnRY2MomoTaQBoO/Iv2zx+NBQmBEfp22VaRreFJiy5hh2k1UeVQonvfcs9KicPftDJecSyphwR9YnhgakP7fjpmnTNUffNnj/ObJsQ6UOvgH5766U3Dsb9YA5zbtgGrSPeUkTKTH1dRk6ndm9yjR3a4ZJFU13838l2mQguq+EJMiYEAaTMWWqva0FMAS9oDgVbysa36FelBEttabRgTRnYU12fg2UWagrco=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB6466.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T0U5eHY5QmN1a0V5Z1MzVm0xWTRFOGdIMFlOWVM0RklqcmlabjUvVTgyYi9I?=
 =?utf-8?B?R3NURyt2eGhwQ1RzTGtNVGUwaS8vNElubGVFcUFuOElydkcwQThRaVB5d3N0?=
 =?utf-8?B?K2FkZmt1L09rWkhUcm1UWHM3TVRMdkJJUE9TWHI1YUY2OVpNN0VmdnJXSmxE?=
 =?utf-8?B?OEN4QnBzY0JqTitFUEluaUlkREkvM3IzemRoM2hRdUZxVnJhQ0hFQ05hN2l5?=
 =?utf-8?B?Qi8remFyeEFEc2cwZGVHV1lwV1p3N3FNOS84cVkwaCtXVEdiNGRNNzlUUDRU?=
 =?utf-8?B?RSttTzd3dmFOd0VIMHRVWHJBc1ZadVkvR0E2TUU5aEhMSWJkWHRWenZPUmZp?=
 =?utf-8?B?QUlYOFpCOXRBZERRL0J2cFpCQ0NOck8yTEFWekVYUm9QaEc0NE9HOEdCSGRL?=
 =?utf-8?B?dEtxZUI1WWIybUlGSFdRNExTdVdMQURHM2NWVnFidUJhajVsMGlYSVNkQmp1?=
 =?utf-8?B?eVhUMUZFYVdxSFhLcE1HTjZadFFZNE5tZG9qMmtzQWR6eFBmYVJjUWRVejFB?=
 =?utf-8?B?QUpnQ2gxeDNoeXd5anhTRGRDc2ZCOStMZy9YbEVZRDJpbG1TZkVLYllyVWsw?=
 =?utf-8?B?dDJPcTlpL1N3cjMxRzdtM1Vvb1U2cVBrQ2RpcE40TEVDTjdhcm42eXRBWVVB?=
 =?utf-8?B?SGg4aE4zSEloY2pzUUVQRlNuQk5aUzMxcHBpMXAyWW5CSTUycjBsZ1R0VVBB?=
 =?utf-8?B?MC9zdG82WnNBNjdrRkJCeGRaQWR1RWRtREZCVXZhV295NEVVT0gyczRTSkdw?=
 =?utf-8?B?bnl3K0V5RHpVNjJLQ0cwaWU0VWY1cExuNEN2TzVwbTRQMWsvTWFDQ1pJRWZw?=
 =?utf-8?B?YUFiZGZKekFUWElpSm9FT0tYRnFzdFY2cWVVQ1JjbmJybGhiSHJxRHlvamY5?=
 =?utf-8?B?WG9QeTZ4ZHVlVTgwVGh2TE1pN0RMNG1qUnpaT0ZGRVBSRm5Mb2RqOW93eFlj?=
 =?utf-8?B?THRuWnlIOUVBdFU1aFNCcnc2S0xZTDRIaXhMWHZDRTVrN3hwSlNqNUJhMEVh?=
 =?utf-8?B?VGtuS1MwOGZvR0hQOW5udUF3TjhRM0dra0syektYUE04bE1laDhvNmx3cUNE?=
 =?utf-8?B?Q1VMLzIramVuam5tb1ZpaFVQaFUvcjEvWTZ1SUFtL0VqOHRpeW5MejFsZ09s?=
 =?utf-8?B?eUZkLzh2SFpha3AvRWxzb0lNVllCbi9QbU5seFB4dDN3WkVoM1A5WFcydWJM?=
 =?utf-8?B?WWFtb2ovWTJHaHNDd0lndmRWMHRhZXNTWitsc2FpMFMxZGlzMy82TnplbWZO?=
 =?utf-8?B?Q3czalFrWGtrQWxOM3lmS1duSTNkSlA5Y1NpUGlJalcyV2NpVDlBMDdTUHpx?=
 =?utf-8?B?dkJMNloyRjlidVFYZmlOWDg2eGFSamJFTTU1N2VFVENCM2Z3Zi81Zi90eWFQ?=
 =?utf-8?B?alFYZWk4MDBib2NCMkh0Q2llekVhcHlsVGZkQmtlR3VmQUNUbHd4NVpyR01N?=
 =?utf-8?B?b0hiZ2VRT2xBbU9MTTF5Mm5xc1ltTnVMZkRETytzTnk5YjR4akZyVkZGTFB6?=
 =?utf-8?B?TGd5dGJ5cHR6VTlsTnNVVVAvN2VBaVBycmlUMFFvS1FxMVkrNERDNllTWVdG?=
 =?utf-8?B?ME4zNHQzMU03bVEwR0RWcHRML1FrbFRLNXE1dkNoU3laS2VtWmRzcXRmWTBa?=
 =?utf-8?B?c1R5YkNiN2ZDOEIrcStML3ZHdDJGcUxJUXRxRkkxSmUxcTZ5T2Z2QkRzRVdN?=
 =?utf-8?B?WjEveXE4NjIrTXJtdmt2VnhWNVVKRjlTK2lmaWZxSkxka0pIQ1V6c1FZN09F?=
 =?utf-8?B?QWRQTVdZbXQyTWE1TTFrcGVOZld6S0doVzFtWHBvMkdkdEZUQ3d5OXFNaksy?=
 =?utf-8?B?SC9KUi9Tck9rZ29tci9CQTdEZ1JNSDFleWZtRlVqSlZEcFV2WVFjczZqR01L?=
 =?utf-8?B?RU5vQmJCZk5Hb0xra0ZSaWd5dS9QK0JycnVOSUlsMDR5WVZRbE5oN1lzMlZW?=
 =?utf-8?B?ZkViNmlZdVJybkJmM1Rpamw1VTVzU1JUVlhRSktEdjFWcitwcGxYcVpmVjkw?=
 =?utf-8?B?MWtwcUJSVkhSZDVDd2xGZWtTMEcrdnhrTTVNZUtXZXVyQm9SQ2lQaFFnb3ZZ?=
 =?utf-8?B?b2ZsaHp0d1pGOGw5VWY5bWdRMHVEeFJpK2NiWTlKSHJJbmNNT01QRFhrZXdv?=
 =?utf-8?B?U3dvckVzL3dtcWRnSFU0eDNneUpkQVgyRlNxVzhOOVdXMHJtL3d3M0JYcks1?=
 =?utf-8?B?MUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <794656711EC80E4C9C7B7EFBB3E302DD@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB6466.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9df6cb3-987a-4385-7a6b-08dc36cc614d
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2024 13:11:01.3217
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n/Vx5X3SiZH0tI9p+m8Pua51fJ2E3xSVYlEde+o9CXg6cbh9fFWpx+3koKXxKvG9AHcNd7+fQ8RVELQg5U3ehA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7930

RnJvbSBhNDE1YWJhZjRmYzkwYTI3ZGQ4NjM1N2VhOGJlNjJkMzI5NTZmN2Q4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQ0KRnJvbTogc2hpbWluZyBjaGVuZyA8c2hpbWluZy5jaGVuZ0BtZWRpYXRl
ay5jb20+DQpEYXRlOiBNb24sIDI2IEZlYiAyMDI0IDIwOjE3OjU4ICswODAwDQpTdWJqZWN0OiBb
UEFUQ0hdIE5ldDpjYWNoZSBkaWRuJ3QgZmx1c2ggd2hlbiBpcHY2IHJ1bGUgY2hhbmdlZA0KDQpX
aGVuIGNoYW5nZWQgZnJvbSBvbGQgcnVsZSZyb3V0ZSBjb25maWd1cmUgdG8gbmV3IG9uZSBhcyBi
ZWxvdywNCmlwdjYgY2FjaGUgZHN0X2VudHJ5IGRpZCBub3QgY2hhbmdlIHRvIG5ldyByb3V0ZSB0
YWJsZSBhcyBubw0KY2FjaGUgZmx1c2ggY2FsbGJhY2sgZnVuY3Rpb24sIHRoZW4gZm9yd2FyZCB0
byB3cm9uZyBvdXQgaW50ZXJmYWNlLg0KV2hlbiBmaWI2X2NoZWNrIGRzdF9lbnRyeSwgdGhlIGZp
YjZfbm9kZSB2ZXJzaW9uW2ZuX3Nlcm5tXSBpcw0KYWx3YXlzIHRoZSBzYW1lIHdpdGggc29ja2V0
IGRzdF9jb29raWUsIG9sZCBjYWNoZSBkc3RfZW50cnkgaXMNCmFsd2F5cyB1c2VkIGFuZCBubyBj
aGFuY2UgdG8gdXBkYXRlLg0KDQpTbyB3ZSBuZWVkIHRvIHVwZGF0ZSBmaWI2X25vZGUgdmVyc2lv
biB3aGVuIHJ1bGUgY2hhbmdlZCBhbmQNCmZsdXNoIGNhY2hlIHRvIGF2b2lkIGRpc3BhdGNoaW5n
IGEgd3JvbmcgaW50ZXJmYWNlLg0KDQpTaWduZWQtb2ZmLWJ5OiBzaGltaW5nIGNoZW5nIDxzaGlt
aW5nLmNoZW5nQG1lZGlhdGVrLmNvbT4NCi0tLQ0KIG5ldC9pcHY2L2ZpYjZfcnVsZXMuYyB8IDEw
ICsrKysrKysrKysNCiAxIGZpbGVzIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKykNCg0KZGlmZiAt
LWdpdCBhL25ldC9pcHY2L2ZpYjZfcnVsZXMuYyBiL25ldC9pcHY2L2ZpYjZfcnVsZXMuYw0KaW5k
ZXggNzUyM2M0YmFlZjM1Li5iZWMyY2Y0NDM2ZTEgMTAwNjQ0DQotLS0gYS9uZXQvaXB2Ni9maWI2
X3J1bGVzLmMNCisrKyBiL25ldC9pcHY2L2ZpYjZfcnVsZXMuYw0KQEAgLTQ0OSw2ICs0NDksMTUg
QEAgc3RhdGljIHNpemVfdCBmaWI2X3J1bGVfbmxtc2dfcGF5bG9hZChzdHJ1Y3QNCmZpYl9ydWxl
ICpydWxlKQ0KICAgICAgICAgICAgICAgKyBubGFfdG90YWxfc2l6ZSgxNik7IC8qIHNyYyAqLw0K
IH0NCg0KK3N0YXRpYyB2b2lkIGZpYjZfcnVsZV9mbHVzaF9jYWNoZShzdHJ1Y3QgZmliX3J1bGVz
X29wcyAqb3BzKQ0KK3sNCisgICAgICAgc3RydWN0IG5ldCAqbmV0ID0gb3BzLT5mcm9fbmV0Ow0K
KyAgICAgICBpZiAoIW5ldCkNCisgICAgICAgICAgICAgICByZXR1cm47DQorICAgICAgIHJ0X2dl
bmlkX2J1bXBfaXB2NihuZXQpOw0KKyAgICAgICByZXR1cm47DQorfQ0KKw0KIHN0YXRpYyBjb25z
dCBzdHJ1Y3QgZmliX3J1bGVzX29wcyBfX25ldF9pbml0Y29uc3QNCmZpYjZfcnVsZXNfb3BzX3Rl
bXBsYXRlID0gew0KICAgICAgICAuZmFtaWx5ICAgICAgICAgICAgICAgICA9IEFGX0lORVQ2LA0K
ICAgICAgICAucnVsZV9zaXplICAgICAgICAgICAgICA9IHNpemVvZihzdHJ1Y3QgZmliNl9ydWxl
KSwNCkBAIC00NjEsNiArNDcwLDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBmaWJfcnVsZXNfb3Bz
IF9fbmV0X2luaXRjb25zdA0KZmliNl9ydWxlc19vcHNfdGVtcGxhdGUgPSB7DQogICAgICAgIC5j
b21wYXJlICAgICAgICAgICAgICAgID0gZmliNl9ydWxlX2NvbXBhcmUsDQogICAgICAgIC5maWxs
ICAgICAgICAgICAgICAgICAgID0gZmliNl9ydWxlX2ZpbGwsDQogICAgICAgIC5ubG1zZ19wYXls
b2FkICAgICAgICAgID0gZmliNl9ydWxlX25sbXNnX3BheWxvYWQsDQorICAgICAgIC5mbHVzaF9j
YWNoZSAgICA9IGZpYjZfcnVsZV9mbHVzaF9jYWNoZSwNCiAgICAgICAgLm5sZ3JvdXAgICAgICAg
ICAgICAgICAgPSBSVE5MR1JQX0lQVjZfUlVMRSwNCiAgICAgICAgLm93bmVyICAgICAgICAgICAg
ICAgICAgPSBUSElTX01PRFVMRSwNCiAgICAgICAgLmZyb19uZXQgICAgICAgICAgICAgICAgPSAm
aW5pdF9uZXQsDQotLQ0KMi4xOC4wDQo=

