Return-Path: <linux-kernel+bounces-92300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFAB7871E19
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:39:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9644D28789A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6980958208;
	Tue,  5 Mar 2024 11:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="UKXprX7Z";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="I152sv8Q"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2304756B65;
	Tue,  5 Mar 2024 11:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709638747; cv=fail; b=Y/KPfK/0z4R6fWUoZ1v8nEXfpTW0VoJQXRw3rJirjG9MyoBdzWhKpMeYDEuLVvRpLoRI4tKq0FNLcB281pa+eG87HqVzGp0h+lOpZ8i4cquCOhHHQEJT4pjAPnaOxFPEcT/eVqVITtIcsoGRCaR4GwSN52cnFLee8zKPHflbIXg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709638747; c=relaxed/simple;
	bh=GhmyErUtKQjrkCv7COBc2gBPAYQsRYE0OpNH1vfo0f8=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=G+VtSi3pFlJ0RJtrbXzJMdyWHq5u0z7b7IRrqrJpM3LO9bDIuJcqMz+67Pj+NqTD3V/SuS2VYq5qgc6uQDHzQvLPbfhb4NfdMHOHzqRfmmwyeQpop35HlJbawkkTAUdT9KjTDnbF0NBtV0I/tXHKCpOJdmd2yL7M9crdxY427TA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=UKXprX7Z; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=I152sv8Q; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: f47a5478dae411ee935d6952f98a51a9-20240305
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:Message-ID:Date:Subject:CC:To:From; bh=GhmyErUtKQjrkCv7COBc2gBPAYQsRYE0OpNH1vfo0f8=;
	b=UKXprX7ZNSOCV7iQ8Hn8TpEVyc/K3Eb1MHA0ywMmdcQjAb7vu0hu+kfnUvYAE7POybCj2AwtrMvBydqvIoOzdmjZbcDLSPP54BrV/c06NvKTjbo+PdpjpnxZFvIL3PN9+ProeZAH25hB1j9ZDGrFuEgiltdhQetgUUXPcGbsp4E=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:099cecb6-a5c2-46fe-aec7-6f820df4ddf7,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:744b2381-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: f47a5478dae411ee935d6952f98a51a9-20240305
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
	(envelope-from <lena.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 565357655; Tue, 05 Mar 2024 19:38:58 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 5 Mar 2024 19:38:56 +0800
Received: from HK2PR02CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 5 Mar 2024 19:38:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bJNVjgbYc7nfbRl0qvZveAzhbN/pcltjaoB7KtwmDCeji1HEcjmmTC9KxaSLAR1fvu2y8E2vbPAKXnXTsl8Pms5xe+AfBnpsaSwYcBelUxlA3PZf2TxrcZ5VtFGTdRd42H+EUSc0VS6JJbQJcSgIcKZICjko6/TqmNRe1Gf/zomyNcSiDb4dqt7cZ/PdE5SpcatJe1cQMBZ9tkWapdxoEjR8AEBbyXsW0Fx+sXeNyfAB4qTwdlNtXFIX+O9tlT2SVAqxS6U9oM92uM2Whiq6H69jtRjpOFe9oI8VKDcLcF6AyVej7WLPs+wZ+tphOZ1OWw3Rm6Qz3WXgkxpj2n1TXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GhmyErUtKQjrkCv7COBc2gBPAYQsRYE0OpNH1vfo0f8=;
 b=m+i985ecti1woX03YMAdNmiP2R/kyu55y8s9+uIQyJOVA9wqBvDQ6Me9K9oBLEN6OBYR9olxEvzqEDCvIw2zUGacw0NT4yqJzUZhWFOD1DJC/XFJPfw+TMM4nGJkShscGdNdpIEcSlVFyRmTyzrFY8BYUhMdMUWZSu7XP6bGTeMaiGf+9DGZdkw9Yb+8GMVD6ChR1hOsh4XcEkyIqrPsxZgBkH8ZB9mejlYQ5Bu0zw6x6X7aPHMzopoZmkMxN9iJHOOApMR5p363I0C2QA9PQBzDk/6EyJZeP+oAeHIFfFnbzAw0+7JPvwvWiFE0NolzBq0hDq0KpKOYjwb1tTFNTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GhmyErUtKQjrkCv7COBc2gBPAYQsRYE0OpNH1vfo0f8=;
 b=I152sv8QhrZSVXryIzmEizBwP6ZetdDSzy0k9K+OlzVcL3d6hEHsEFv91yTn1KuDky8Zw4kzsrRe4h/YWB5ODRt5WmWBaACIl5gIb/tHLVxkRzsOENuh8rC8jQF287pTb6l/eI68GuYetKpHqLVUtGlHtp+zmPj3i2PDOZ/WekQ=
Received: from SEZPR03MB6466.apcprd03.prod.outlook.com (2603:1096:101:4a::8)
 by TYZPR03MB8241.apcprd03.prod.outlook.com (2603:1096:405:1f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Tue, 5 Mar
 2024 11:38:55 +0000
Received: from SEZPR03MB6466.apcprd03.prod.outlook.com
 ([fe80::3b7d:ad2c:b2cf:def7]) by SEZPR03MB6466.apcprd03.prod.outlook.com
 ([fe80::3b7d:ad2c:b2cf:def7%6]) with mapi id 15.20.7362.019; Tue, 5 Mar 2024
 11:38:55 +0000
From: =?utf-8?B?TGVuYSBXYW5nICjnjovlqJwp?= <Lena.Wang@mediatek.com>
To: "fw@strlen.de" <fw@strlen.de>, "davem@davemloft.net"
	<davem@davemloft.net>, "pablo@netfilter.org" <pablo@netfilter.org>,
	"kadlec@netfilter.org" <kadlec@netfilter.org>, "jiri@resnulli.us"
	<jiri@resnulli.us>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"netfilter-devel@vger.kernel.org" <netfilter-devel@vger.kernel.org>
Subject: [PATCH net v3] netfilter: Add protection for bmp length out of range
Thread-Topic: [PATCH net v3] netfilter: Add protection for bmp length out of
 range
Thread-Index: AQHabvG0DZxC9eczF0uTSH6BuJVdSw==
Date: Tue, 5 Mar 2024 11:38:55 +0000
Message-ID: <571b3e3f7191b5f67792d1090fc537bf4045c522.camel@mediatek.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB6466:EE_|TYZPR03MB8241:EE_
x-ms-office365-filtering-correlation-id: 17b3de55-8e0b-479f-aa56-08dc3d08d6ec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qp1Xzx6p4lXfsc/E4BjV8u/jLI0Rbje3/Xt7V0MZaZ+F4FgP/tAJDyjazW5hQe52EVfy1h2LV6FSugnx2XMwLPS2W+lN+adzuRhKoj4R5+zrQLslqahhYGv6/SiTfrG0EzTrZOCXJuuyFBG2rijC4V7HoCAeO+OeVG3cpr/7WeINxROYBNjMF7ZZWf+QafufDHSg5N55w/6QqEL3UqsUgw9UymuemmH6+1Gag7RbfZ2LGxYLrS/bTzn1O7B0qSuvbCJSlKYGYNQGZdjkLUUpROivkd6zMcysztD7hIUqPngRxWflnNE0te2hR4TW1OTTRs/dNNK6qVsswSl6hFaH+LbMeFqlQgZN1hykNOIJZZIuVV/jjqOIBWqQHYmimU1MjXt19S3HIw/QSBm+Y++gLBvsd0xHxQNDEjZ6cCIu+A02+9tLGmfuP+XI0+DZ644/lXPxkDgIoIJxnox+JSU4xB9/QA9gcqjzaoPkzEzxXX1CmF7bBAd/0SV8t879Gb3jwpwpHgqGkVMZJW98zfzNhbKg74AZtxHRqH+bs087KPf8Dpx6CS67fEZ8bTUm+hCFmsygNu33BO+BA8qNATWqCj/8b9p7/z3yIPgDXXz5wXngw6H8AxmVmO/J2Ob5DF+Jq+XxbMs57tap4wgxyGNN/UzTqRLOm8MxCIhV7r2VUdsl8gk2gye7AZtfQB+5l3NM4sF83EQ6X1tsOd3IBLjDJyGCirPoWXO1+FSjwOdcGTA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB6466.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V1ZCYy9zb3lmSXQxcGREd3ZPdkwwMXdZQU9YS3MwcWdtUHY4OHZmRkhtazVX?=
 =?utf-8?B?bTFWbWpqNzkxSFc0dnZVSUJ3c21LeUlldWQ3RjR4bGRkdDVrNWZuNUxoUWla?=
 =?utf-8?B?Tm4rZjRmd3V6a3VVZDdpYVgwcHhiMU52MXdaNW01YktXd2hsNHpxSjRxM0M3?=
 =?utf-8?B?SFJLTmFCanJVMFYxZTVXeFpMd3FCOC9pYUxyajFIelprYytxWUpqNjJ2YjAx?=
 =?utf-8?B?bmNkNXN2RStVNjJHbWpHM1N3dnZPb3l4VmtOZzFURktiU3RXOGVXamlKOU9S?=
 =?utf-8?B?WlExWk1Zb1JEM09vMnRuazk1RVg4SGpWQ0VHeW9LUTlOTnhZSjVkWUdTNzBS?=
 =?utf-8?B?TEhsRU5ZRjJ4STBORVFLRG1XeTZZU1luNGlIZGxiMTZFRFIzejM2QmlUYlNI?=
 =?utf-8?B?clBkZEdCWFVaOTRFZngweU5lSG43K2lSQU9SRjhFK0lqVXcwUFdVWlE0S20v?=
 =?utf-8?B?Y01oKzVOUitwUjlOTDNIcFlkUEJINVIvWDJkRXY5ZjJ4YUcvQWtJZ1NLNG4w?=
 =?utf-8?B?T0xpeklhaVVpN0pUVkU4YmlHcTVnVE1leU44Snl1TXVoYlV2N01CVDhwN0VH?=
 =?utf-8?B?V2hyNnBWL2g0UDBrWTM1anN0VWZRQjlwd3BUN0hFK2pWSk43UWZDa3Zudmlw?=
 =?utf-8?B?YlBzbzJORHRHSGZFSU1UY2RoU2hXK0ZFaGpOc1VGLzMwT0wybGprNFNINGJM?=
 =?utf-8?B?c01tVzEzOEJJZy9wYVBFTFo2STc2MUJtTWxXNWIyRzMwVEhISWtuUmNuc2Zm?=
 =?utf-8?B?d3BsQUMwVkZ5ZnZyWm1tVVQwdDBQTDdiMURDbVBGUy9YMUxPNndzZVRWN0tq?=
 =?utf-8?B?UFBtMzhDTnZHNEV0clR5K2NZelJiVmQxdCtPZnZaMzhjQ2Z3Wi8wckpnL2JG?=
 =?utf-8?B?R0JrQ2crTnJoZ3dFdkNYMGhPSU9iYlVhenViUlJhTzhMaldGL0l2d3RYR0Zz?=
 =?utf-8?B?NHZLOXM2RWwrYXpvVWxnVitvcUpvVVNDUGpYU2x0YzFwcmo4NmNHbDBWNC9H?=
 =?utf-8?B?ckM5QzQzNzRNUk53TGh5NkZ5ckozNm53ck5WakdmeDU2a0F2VW9uNE53YTQw?=
 =?utf-8?B?eFpScjNONHA2SGc1cW5WTUxkeSs1U2J0bE9udVB2RTZDRUExS21Jc1dQbjMz?=
 =?utf-8?B?OFFiNVBjSk9LdGJpeFkyU1RENmxrMjFPUnBVZ2hob1Q4OFoxNXNEdWlpV2dD?=
 =?utf-8?B?SSs1K05HaDNxOHpIS0s5ekJXNFhpMEpTc29pZGkvcTltQUFFRnBQYjBwMnJC?=
 =?utf-8?B?SU9xTjJiR1lGdUwzQk5vblpCT3RDTlBRSDNTdm5uWU05eWk3TVRTeUxITDQ4?=
 =?utf-8?B?M3E1MGk3YUx5Qm01WWowd1dlR3MyS3drTUswU2FPaGhZZVVnUjByNmpLdlNn?=
 =?utf-8?B?U1MwRENENEhYNmE0Y0JFS0JjU1hubzdMMGVMazlMT1poRU5xQnR0WXhPWmVP?=
 =?utf-8?B?U0UvMzg5TkVVWWUrV2RLTzU5aDFDaVBoeTN1T2ZBeXVGaFh0dE5wRnFzZEQ1?=
 =?utf-8?B?YjV4SUdLbkUwS3liSzRpTCtqL1pGOHFPVktUVzlzQk9Ja1VWYUNJOW9xZTdX?=
 =?utf-8?B?aHo1QXltRDZidWs3OEVVdTRVVmdwcFEvdE4rWFpndS9nV3M3dnRPNTNncUJF?=
 =?utf-8?B?NUZIdGE5TEFMY3ZOVG4xZkI0VWV1Yjc1M1JIUWlKUUdTaWF0NXY1TGlHZ2tw?=
 =?utf-8?B?cDNYSkhLVmcxU2doNEVnVGZxaVFpMnB3eFNaM0R0bk5RS1AvQ3pXdG9oejh6?=
 =?utf-8?B?SjF6UzdWcXZMSWlpQ0t2S1RHYUNEQlkrZlRVZGVqa0x1aWNIU3dOc2VBT29W?=
 =?utf-8?B?dytVT3RrUGFCSHBDVjJYSlpJa0hDRkIzYnhwYzdjL2dmQ28yOFY3VG8wQ0lY?=
 =?utf-8?B?cjdDdHF6UC9icDBCMmhIZlpBR2lyWGJ3Mmk5Tk9Tb1JUZ0RGSFlxeUdReTkr?=
 =?utf-8?B?Q2Nla0JmOTBVSG5oYnEyNTA5Ny9IMDI5d1crWWdyRnlUN2RFYmdFM0JvL1BO?=
 =?utf-8?B?SHFJN1lUai9IWFBjeDhlVTUzcGJmSitLeWRwYXNSdXhZNmZZdXBQNDRnVlJJ?=
 =?utf-8?B?NlVxQTdGOU56ajN3VkpoQ0Y4V2g4c2JaSlY3QTBQNXlCM2dSUGxxQlpHek9u?=
 =?utf-8?B?UUs3cXFTbjNwN0l4RVlNeks0bnROVGVjU29FOTA3QU5ySVUwV1YrRTQxb3lw?=
 =?utf-8?B?NFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4EC778444DD99240B2C58934C2B3AE2A@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB6466.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17b3de55-8e0b-479f-aa56-08dc3d08d6ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2024 11:38:55.4509
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: edDBOdg+G83pfOSXtbjEdDBiIMdiw/FEE6RYkXP+CwekS9ee3GG98MU5IpT4l9lDM66ocucaZc3yr397/HqeeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB8241
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--5.079800-8.000000
X-TMASE-MatchedRID: cWqVi5YGo5wIAPmAuSvJ8Yzb2GR6Ttd3X5TqQagR07dLBxm1Vv3RsJ93
	TfvULFt2/5f0y/6L/68GwOiwlwYHMkeBpfM21lfTmsge4JmkzOX/wK4D5v9hhLIPyqeQTeKk0nE
	XIG9RfVfgRfDXjOa2sgN6C4LgNZr9EJHpQ2Y9lUQD2WXLXdz+Ae3+iQEtoSj4hj0Um3z4RXl18v
	vd24eboroaAxIVVU84kZOl7WKIImrS77Co4bNJXQtuKBGekqUpbGVEmIfjf3sFMj8NKMkqKl44y
	EOFrp9nmQ5RXNVHbGRn02g81P1KqLbzH9ZONZH6
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--5.079800-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	A12FA8A0B5AFF5B02558641BC3C19504AB95CCD2DA286652A433AC26057DFEA22000:8

RnJvbTogTGVuYSBXYW5nIDxsZW5hLndhbmdAbWVkaWF0ZWsuY29tPg0KDQpVQlNBTiBsb2FkIHJl
cG9ydHMgYW4gZXhjZXB0aW9uIG9mIEJSSyM1NTE1IFNISUZUX0lTU1VFOkJpdHdpc2Ugc2hpZnRz
DQp0aGF0IGFyZSBvdXQgb2YgYm91bmRzIGZvciB0aGVpciBkYXRhIHR5cGUuDQoNCnZtbGludXgg
ICBnZXRfYml0bWFwKGI9NzUpICsgNzEyDQo8bmV0L25ldGZpbHRlci9uZl9jb25udHJhY2tfaDMy
M19hc24xLmM6MD4NCnZtbGludXggICBkZWNvZGVfc2VxKGJzPTB4RkZGRkZGRDAwODAzNzAwMCwg
Zj0weEZGRkZGRkQwMDgwMzcwMTgsDQpsZXZlbD0xMzQ0NDMxMDApICsgMTk1Ng0KPG5ldC9uZXRm
aWx0ZXIvbmZfY29ubnRyYWNrX2gzMjNfYXNuMS5jOjU5Mj4NCnZtbGludXggICBkZWNvZGVfY2hv
aWNlKGJhc2U9MHhGRkZGRkZEMDA4MDM3MEYwLCBsZXZlbD0yMzg0MzYzNikgKyAxMjE2DQo8bmV0
L25ldGZpbHRlci9uZl9jb25udHJhY2tfaDMyM19hc24xLmM6ODE0Pg0Kdm1saW51eCAgIGRlY29k
ZV9zZXEoZj0weEZGRkZGRkQwMDgwMzcxQTgsIGxldmVsPTEzNDQ0MzUwMCkgKyA4MTINCjxuZXQv
bmV0ZmlsdGVyL25mX2Nvbm50cmFja19oMzIzX2FzbjEuYzo1NzY+DQp2bWxpbnV4ICAgZGVjb2Rl
X2Nob2ljZShiYXNlPTB4RkZGRkZGRDAwODAzNzI4MCwgbGV2ZWw9MCkgKyAxMjE2DQo8bmV0L25l
dGZpbHRlci9uZl9jb25udHJhY2tfaDMyM19hc24xLmM6ODE0Pg0Kdm1saW51eCAgIERlY29kZVJh
c01lc3NhZ2UoKSArIDMwNA0KPG5ldC9uZXRmaWx0ZXIvbmZfY29ubnRyYWNrX2gzMjNfYXNuMS5j
OjgzMz4NCnZtbGludXggICByYXNfaGVscCgpICsgNjg0DQo8bmV0L25ldGZpbHRlci9uZl9jb25u
dHJhY2tfaDMyM19tYWluLmM6MTcyOD4NCnZtbGludXggICBuZl9jb25maXJtKCkgKyAxODgNCjxu
ZXQvbmV0ZmlsdGVyL25mX2Nvbm50cmFja19wcm90by5jOjEzNz4NCg0KRHVlIHRvIGFibm9ybWFs
IGRhdGEgaW4gc2tiLT5kYXRhLCB0aGUgZXh0ZW5zaW9uIGJpdG1hcCBsZW5ndGgNCmV4Y2VlZHMg
MzIgd2hlbiBkZWNvZGluZyByYXMgbWVzc2FnZSB0aGVuIHVzZXMgdGhlIGxlbmd0aCB0byBtYWtl
DQphIHNoaWZ0IG9wZXJhdGlvbi4gSXQgd2lsbCBjaGFuZ2UgaW50byBuZWdhdGl2ZSBhZnRlciBz
ZXZlcmFsIGxvb3AuDQpVQlNBTiBsb2FkIGNvdWxkIGRldGVjdCBhIG5lZ2F0aXZlIHNoaWZ0IGFz
IGFuIHVuZGVmaW5lZCBiZWhhdmlvdXINCmFuZCByZXBvcnRzIGV4Y2VwdGlvbi4NClNvIHdlIGFk
ZCB0aGUgcHJvdGVjdGlvbiB0byBhdm9pZCB0aGUgbGVuZ3RoIGV4Y2VlZGluZyAzMi4gT3IgZWxz
ZQ0KaXQgd2lsbCByZXR1cm4gb3V0IG9mIHJhbmdlIGVycm9yIGFuZCBzdG9wIGRlY29kaW5nLg0K
DQpGaXhlczogNWUzNTk0MWQ5OTAxICgiW05FVEZJTFRFUl06IEFkZCBILjMyMyBjb25udHJhY2sv
TkFUIGhlbHBlciIpDQpTaWduZWQtb2ZmLWJ5OiBMZW5hIFdhbmcgPGxlbmEud2FuZ0BtZWRpYXRl
ay5jb20+DQotLS0NCnYzOg0KICAtIGFkZCAiRml4ZXM6IiB0YWcuDQp2MjoNCiAgLSBhZGQgbGVu
Z3RoIHByb3RlY3RvbiBmb3IgYW5vdGhlciBnZXRfYml0bWFwIGNhbGwuDQogIC0gdXBkYXRlIGNv
bW1pdCBtZXNzYWdlIHRvIHRyaW0gc3RhY2t0cmFjZS4NCi0tLQ0KLS0tDQogbmV0L25ldGZpbHRl
ci9uZl9jb25udHJhY2tfaDMyM19hc24xLmMgfCA0ICsrKysNCiAxIGZpbGUgY2hhbmdlZCwgNCBp
bnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9uZXQvbmV0ZmlsdGVyL25mX2Nvbm50cmFja19o
MzIzX2FzbjEuYw0KYi9uZXQvbmV0ZmlsdGVyL25mX2Nvbm50cmFja19oMzIzX2FzbjEuYw0KaW5k
ZXggZTY5N2E4MjRiMDAxLi41NDBkOTc3MTViZDIgMTAwNjQ0DQotLS0gYS9uZXQvbmV0ZmlsdGVy
L25mX2Nvbm50cmFja19oMzIzX2FzbjEuYw0KKysrIGIvbmV0L25ldGZpbHRlci9uZl9jb25udHJh
Y2tfaDMyM19hc24xLmMNCkBAIC01MzMsNiArNTMzLDggQEAgc3RhdGljIGludCBkZWNvZGVfc2Vx
KHN0cnVjdCBiaXRzdHIgKmJzLCBjb25zdA0Kc3RydWN0IGZpZWxkX3QgKmYsDQogCS8qIEdldCBm
aWVsZHMgYml0bWFwICovDQogCWlmIChuZl9oMzIzX2Vycm9yX2JvdW5kYXJ5KGJzLCAwLCBmLT5z
eikpDQogCQlyZXR1cm4gSDMyM19FUlJPUl9CT1VORDsNCisJaWYgKGYtPnN6ID4gMzIpDQorCQly
ZXR1cm4gSDMyM19FUlJPUl9SQU5HRTsNCiAJYm1wID0gZ2V0X2JpdG1hcChicywgZi0+c3opOw0K
IAlpZiAoYmFzZSkNCiAJCSoodW5zaWduZWQgaW50ICopYmFzZSA9IGJtcDsNCkBAIC01ODksNiAr
NTkxLDggQEAgc3RhdGljIGludCBkZWNvZGVfc2VxKHN0cnVjdCBiaXRzdHIgKmJzLCBjb25zdA0K
c3RydWN0IGZpZWxkX3QgKmYsDQogCWJtcDJfbGVuID0gZ2V0X2JpdHMoYnMsIDcpICsgMTsNCiAJ
aWYgKG5mX2gzMjNfZXJyb3JfYm91bmRhcnkoYnMsIDAsIGJtcDJfbGVuKSkNCiAJCXJldHVybiBI
MzIzX0VSUk9SX0JPVU5EOw0KKwlpZiAoYm1wMl9sZW4gPiAzMikNCisJCXJldHVybiBIMzIzX0VS
Uk9SX1JBTkdFOw0KIAlibXAyID0gZ2V0X2JpdG1hcChicywgYm1wMl9sZW4pOw0KIAlibXAgfD0g
Ym1wMiA+PiBmLT5zejsNCiAJaWYgKGJhc2UpDQotLSANCjIuMTguMA0K

