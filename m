Return-Path: <linux-kernel+bounces-86285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB16586C366
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:25:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F5461F23811
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 08:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A787B4F1F5;
	Thu, 29 Feb 2024 08:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="iTPAtm6A";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="W5kLH6vm"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27EE446B7;
	Thu, 29 Feb 2024 08:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709195105; cv=fail; b=MvhesM26+VCIRB4iJcoLbiGbnXixumZjKLFRGRvOg3EYuhD4cf/M6Ye+PZlw9q9hNzYGzEBs4IzHx7Yc+9KserPZNcIx3fhiY4VWJiVvrOt5ijI/X+QT8lI7V4THejvlsHLO8WvrdTvOyYlrH6BW/vEhstc2OHlT9/5VNuf6EAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709195105; c=relaxed/simple;
	bh=3iqs4DzH/IUyrVNW8g85B1IxUbGS+83neKRuYObOuMc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pynsO+YD2AiymGQUwU7VbohVlMrRSW8nMN+X4VQyiER2G+2Xy2vXtDVNL8KI3FxCllhCTPieQoXbrNQvSzWHIB7Tqy30lkHtYgUpha+xHFs2gMoPrtD+z5sGYQThiVuY1bYXOUrjPKzAVKuQpFszShIUWfkB+aK6jOq9k6q9i1o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=iTPAtm6A; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=W5kLH6vm; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 069c2a44d6dc11ee935d6952f98a51a9-20240229
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=3iqs4DzH/IUyrVNW8g85B1IxUbGS+83neKRuYObOuMc=;
	b=iTPAtm6AzPv/Pll7Log5HswH2v2pnvX/dB9MBtzmYt/FIwWZD40cFzYudLjuli+c7dveOW3czGAXzFHXy0ZC857q+Ulv9jRbA4dwVMKEitmZAjEEPMm0XYxH+sD4hxeTWunEcL9z5Lnz5YHLwajbivlhyzRbpmJvCKL0/XHTmd8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:4347a8e6-81a5-41b9-85a0-85b88f07fb24,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:0302d98f-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 069c2a44d6dc11ee935d6952f98a51a9-20240229
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
	(envelope-from <lena.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 551452141; Thu, 29 Feb 2024 16:24:58 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 29 Feb 2024 16:24:57 +0800
Received: from SG2PR03CU006.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 29 Feb 2024 16:24:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DJALUY8APN3LiCTK94sBpb5PEMAXru/PEw+FFvgNSEteR2oNMWDaMKIGSgDXN1qnGdTijIx+ghotjo6n/P+uazNjHN0sLpV1vibgWvTKKzsaD7Ld8TYKE5DiolWH3avuQ9xLaV5xAhvRRTGxFlH6jJLHPiG8Eo4ZRzpLEeVcjyCaVtLZxql4cn7+IQdWZPONVPDJDp/mI3Hc/1swhof+jCfjD9fYrrpMRDqd8cGjYjpscjmSK3nfJ6UOweeNGYEorWWfHWrTqrFoDZJewuTqwFRC13XKFKQEubf/20cP+PEm2G3R3+Zkr2Q59ZLpsgOXmc5s5xPsEhDe43PuObm2oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3iqs4DzH/IUyrVNW8g85B1IxUbGS+83neKRuYObOuMc=;
 b=i0x1VSUCXuo+VCADuZvuGgMN1aEBPOm9X7W8zksEB958apO9dV6tTMSGFOf6qz+tyod3EnDvil5vCsHw1yZ6wJzseNw6xhTrOBR70oxfdzvQZQSx+e8o+o91BBhaFmAH/hyQPCBIgpRLo9txedDZMdPGFuNK1gKHuxJed/DZv9AuIVW5JfB0NFaR/t6h2i7dg9vRRPR7TlkPuCLH0eCDPhQJ+2ri9W/8RHHn1mkKaRM9oTlfLdw3DLfq12ls0hr/yAgNqLjSHhf/OeNox7YoNd9MLNZc5LOZyIvBKVYwP/kOVSZWu1xqLWImmuVJye1Bt1i8t/lUf0m5ZSNpJoQ3HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3iqs4DzH/IUyrVNW8g85B1IxUbGS+83neKRuYObOuMc=;
 b=W5kLH6vm3oCtR3rUae42X50iwwdS3eUR5AE3EoVNy4ZfMeH1FEr4gFE3xF7QAvEU9NcdhwLp2/jvimeIBMC50044vks7hugRp6lYFuHqFuw/kfzdI6/2/QYfMv0AAEcf8NmmBdRhevXepTA3eCiuNtDmn5pYYgo4IEJOmapyJdY=
Received: from SEZPR03MB6466.apcprd03.prod.outlook.com (2603:1096:101:4a::8)
 by SEZPR03MB8680.apcprd03.prod.outlook.com (2603:1096:101:233::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Thu, 29 Feb
 2024 08:24:54 +0000
Received: from SEZPR03MB6466.apcprd03.prod.outlook.com
 ([fe80::8814:cbff:5bbb:98ea]) by SEZPR03MB6466.apcprd03.prod.outlook.com
 ([fe80::8814:cbff:5bbb:98ea%2]) with mapi id 15.20.7316.035; Thu, 29 Feb 2024
 08:24:54 +0000
From: =?utf-8?B?TGVuYSBXYW5nICjnjovlqJwp?= <Lena.Wang@mediatek.com>
To: "jiri@resnulli.us" <jiri@resnulli.us>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"dsahern@kernel.org" <dsahern@kernel.org>, "kuba@kernel.org"
	<kuba@kernel.org>, =?utf-8?B?U2hpbWluZyBDaGVuZyAo5oiQ6K+X5piOKQ==?=
	<Shiming.Cheng@mediatek.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "davem@davemloft.net" <davem@davemloft.net>
Subject: Re: [PATCH net v3] ipv6:flush ipv6 route cache when rule is changed
Thread-Topic: [PATCH net v3] ipv6:flush ipv6 route cache when rule is changed
Thread-Index: AQHaalw91Rv7H6OFS0Wr4eaCYscTYLEf5w2AgAESBAA=
Date: Thu, 29 Feb 2024 08:24:54 +0000
Message-ID: <5a422630db12a06a4e8d064d9dd2c7402a4bbe07.camel@mediatek.com>
References: <c9fe5b133393efd179c54f3d7bed78d16b14e4ab.camel@mediatek.com>
	 <Zd9WU1bpoOlR9de7@nanopsycho>
In-Reply-To: <Zd9WU1bpoOlR9de7@nanopsycho>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB6466:EE_|SEZPR03MB8680:EE_
x-ms-office365-filtering-correlation-id: 9c674bd5-41c1-414e-a375-08dc38ffe838
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: f82YPxEPTsqEmXVVy86R13pLxB+MuOyNWJpRT8wCanOsXlluFFVDoYDl3vaQTAXWyS7ahdwRdJuUUJ88Fqi2WHbXszFpy400ubnJC88clur7k8WZJMWn5X1Y0s9az2ejpMTYulxNF3XFHoz9ItBVnVehtDMm0Ap2pCqTWHYNUHTzmStjGtb2iYkfO21Prw4/iCC5f4emv/ceWBNOCT8Ud4RGbFmt/I9lV0p/LCM422nF30H9yg7PMHBSpli1ITBM2hTkAH/NzcePI1ncBym8zvx/tMaJzyteXuhMzR/+pABU8+rXwoYRU3yYNzkpiZ8zxrJcARGbsodn/7E27o3kPG/MeQSJNeCS3Ux86ajKdW0fXq+lxIYBSrG3t3NUT43kkkeq57R+8jl6pb4xeuZy2e2Z07K7yAqNeQtAAK/oMUPtvigwlOEkiLe9bQQRXW7BxXV7UTVG7E0xh8nclAMhMLvkXZu3UByHZudKrYgMhtlI5i5q2fZ6oaK46u2PxK8ZzeF5WXm2VcXJ20+kR3zEDV2OPCjxqiTHkmYdJ3akXaQeK1t99tDOytY8wG3N3t222Z6XbSAKGuLemGN1t9id+LIIinv2lIGrxB1h0lKtXlYb+8GuLxsm9qTpIdtYsUBpU4BQD7ZJ/CQHXDkmDdzGZ+9gYvRKik1FVWPxF4xfQuY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB6466.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MFI5ZlNGYm96V2NwZFh0ejF6cmU2SEJpWm8xNkZGdlBrVC9hNTRNZzZKb1pv?=
 =?utf-8?B?ZEIxYmFXVzh6MlhhUFRrS21mKzJ1SUNNOUJnUUhKQ3VRVGVtQ2FTZHZzaFJj?=
 =?utf-8?B?VTNKeWNDbUZFci90NVRrWUJ0dUtyK0Y0MHZTRWhGbWd0Y0Q4MHFLUGhKbFdn?=
 =?utf-8?B?SkpiN3RZVDRNR3MvalVzeUtnVzdZTGRRUlQ3UHZjdVUvY1JhbHdMc25UckVU?=
 =?utf-8?B?aWZlRE1ubngzMGFraTlsQTdicGNEQyt1d3l1SmFhNDhBeVBBb1N4eSswQjZG?=
 =?utf-8?B?YXE4dFdtbFBubnZFWmExUytNb1lodkRiaFcwdVNUYmgrZzlqTWNNelNsYjEy?=
 =?utf-8?B?ckRURHE3bFJCYVZnM0lUVmh5aU5OQW1IV2puaFZrenR0ODBPKzF4bWZwN0Nn?=
 =?utf-8?B?SE9rT0twWVVEaVF1L0ZDZG1HRThwTks1bEtTQWlyeE9uenY3d0FKVlRFODJE?=
 =?utf-8?B?Qjh3cWNaOE52Skh5OEpxMU5QeHd1M1NqQW12YWF4cW05UnFPN0NySkJvWWhy?=
 =?utf-8?B?L3Bocnc2ejFmTFhUVHhhVEYxdDJyRnZuYVVwMlYrMDV2M2g1ZHlIM1NqZUdD?=
 =?utf-8?B?aHlwM3d2M2QxQnFobENsejUrcVgwV2JZV0swMG9NZURhSjJ5ZzF3VE1vMW9Q?=
 =?utf-8?B?Zm9JNzIwR2hxV1ZoRjh6TklMM0xWZThsWHdFT0Q2YjBubzFTYm9Ebi9zeXd1?=
 =?utf-8?B?ZUJ3TC9RZXZGNFJGbjBoNVcxQlV3VXRIQmhNWmh2NFA3dml6THpuTXo3WmRt?=
 =?utf-8?B?RzladTZaaTVPZVpYaWFUSzA1Nk9FTXgzMW8wWGxBa0RCQ29KSjQ1a2J2cnVq?=
 =?utf-8?B?V0lWbllnUXNoYVI2V05YMW9ZWHVJV3I1eTZjU0t0aTFrWWJsTVRtRThpbE1v?=
 =?utf-8?B?WlVvNDBjZXVTcTkvQzNGK0gyRWxVVXFrWU9ZTnVpbG9GN04raE12a3pxVDlr?=
 =?utf-8?B?TUx5dW1pS1AwOURBOE8zSUFTUEEvMGxiOUZiQndlckp6MW9FM1VxMDdYamZk?=
 =?utf-8?B?TWJXQU5GVDVhSXdscUd6d3B6K0JxSVQ5NUhveTBVcURSaFlLYksxRFVualJB?=
 =?utf-8?B?dWp6MWhKSHJRUkhaK1J1clgxV2R5cU5ybnZ4NjJBTjRvM0RSSGp4U2g3bmlo?=
 =?utf-8?B?SHFGaXFlQmpFU2FPVktBUVU0Q3paZU1hVkNQQnpjNXNCK3pnYVpLSUFMWlJK?=
 =?utf-8?B?UStwcE9NSXE2WlZ0TE5RU0daRjM0WnMrY2lzRG42Q2Jobk9hakYyemZVR0Fh?=
 =?utf-8?B?Nm5zMldtSG85dmM5bDBidnI5eEJIdm05SnlEbHRQOVB1V2F6T05XVDlZejk3?=
 =?utf-8?B?V1phVm4xSjdzaUZJY3Qwa1Z6Q0R4RVdMM2xUYzZwMnIxWkxwbkRZNlViRml4?=
 =?utf-8?B?R0xwNVh1S0JTcmNhaUQzYlJSZ2FQWmtvdFIxYitHK3VHcVpLRlYzaUoxeEdk?=
 =?utf-8?B?NmlnenVQODFBVFlqWnN6TnNkRjIvK0JOM3Z2NmF0OCtpNmRGRUpyejREb2c5?=
 =?utf-8?B?b2RVcjhub0lMTkM0SHJEL05nNkR2aDNTQ24vaGYxYkRtbVRiQWdPSEJIUGhT?=
 =?utf-8?B?SzZGMlFiZHZBblFPcTVhZHRDWllydUpGMEtHOUY2a2RzazVKbmYxOXlhc05v?=
 =?utf-8?B?bXdnRkJRN0xPRXRRNDhDekthdzRMZTBZdzQvVThtSW5GQjBuek9Rdk1qQ3JP?=
 =?utf-8?B?Z2p2TmhBcFRtNkx1RFZlcXdnbm1rZGRpZ0pqbDZFWEtSanY4UW1ydTExcjg5?=
 =?utf-8?B?NDA2UWIvbzFoZjYwUzB6QlkwSXFncnl2R0pCaktBbXBTZHZ6UFFKMllyWlJM?=
 =?utf-8?B?RmJ3N3pMY2dQZkNYeWtsUHdCSkNudWpRNURIOXdHK25CNU8xL2owb0pjTnUv?=
 =?utf-8?B?RHZFdW9hZE9DNytBQ0oxblFMYmdqdmEyZC9BZEpiYlhtSm1BK0ZVbnZyZXJT?=
 =?utf-8?B?WmdPcnhmdDZKbm1UMW81MExrUnJLd1pwT2dkSEd1WnNLME9wSUJaRUo2UnFo?=
 =?utf-8?B?OW41RTg4eFBsZlpnajMvVG04czVvVXB5SC9KNFloWUpjUUU4Q0hCUVpFRkdX?=
 =?utf-8?B?T3ZKZjVRREpvSWIrQ3RtMFIvMWV3NWZNM2h1Y3QzVUpDVDZoM2lodUxPZHIy?=
 =?utf-8?B?bzdndHdaMkRKUUh0OVp6aWc5Y0xnWm5VWlRXRFRtbWx5OHF5VTJ5eTFUMDdu?=
 =?utf-8?B?WkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1E8412B5DBDBB4418FE62FFE863A4C0D@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB6466.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c674bd5-41c1-414e-a375-08dc38ffe838
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Feb 2024 08:24:54.3375
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ar5Oq94H0fCCG4X0cSlQQAq6fdLzIsS//ydRjP1ZkgyrKyMyNO7sEpe3uUCAUh9z6PoTGMtZJN/WqD92wsQH6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB8680
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--23.679900-8.000000
X-TMASE-MatchedRID: QW5G6BKkLToOwH4pD14DsPHkpkyUphL9meN8m2FdGic3xO2R3boBWFbu
	qIY+/skQkABPgKBt/0pYZsyDjZDkNUF8Z0jCZWN8mlaAItiONP0dD7MjKedDjtKyif3uAutMj0T
	9QlDgJSZ/h/ruYRfcOTj6VxPoPKVgAya39voTToXAJnGRMfFxyTul9KNGwPY6NEJplIoT86xOj5
	3mRhXD8buVJYuWH/a7DmIE4Tvg5l/MKw4IHEOndbU+IyHhkXf1QZXZg2I8JaZh2fnHe1cilxTnl
	glZ+1FX4vM1YF6AJbY9l7H+TFQgdbew1twePJJB3QfwsVk0UbslCGssfkpInQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--23.679900-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	48BED001437152B3880A910986B5BC1262FAFEC276ABA507506F7D6A5C7356192000:8

T24gV2VkLCAyMDI0LTAyLTI4IGF0IDE2OjUwICswMTAwLCBKaXJpIFBpcmtvIHdyb3RlOg0KPiAg
CSANCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4g
YXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUg
Y29udGVudC4NCj4gIFdlZCwgRmViIDI4LCAyMDI0IGF0IDA0OjM4OjU2UE0gQ0VULCBMZW5hLldh
bmdAbWVkaWF0ZWsuY29tIHdyb3RlOg0KPiA+RnJvbTogU2hpbWluZyBDaGVuZyA8c2hpbWluZy5j
aGVuZ0BtZWRpYXRlay5jb20+DQo+ID4NCj4gPldoZW4gcnVsZSBwb2xpY3kgaXMgY2hhbmdlZCwg
aXB2NiBzb2NrZXQgY2FjaGUgaXMgbm90IHJlZnJlc2hlZC4NCj4gPlRoZSBzb2NrJ3Mgc2tiIHN0
aWxsIHVzZXMgYSBvdXRkYXRlZCByb3V0ZSBjYWNoZSBhbmQgd2FzIHNlbnQgdG8NCj4gPmEgd3Jv
bmcgaW50ZXJmYWNlLg0KPiA+DQo+ID5UbyBhdm9pZCB0aGlzIGVycm9yIHdlIHNob3VsZCB1cGRh
dGUgZmliIG5vZGUncyB2ZXJzaW9uIHdoZW4NCj4gPnJ1bGUgaXMgY2hhbmdlZC4gVGhlbiBza2In
cyByb3V0ZSB3aWxsIGJlIHJlcm91dGUgY2hlY2tlZCBhcw0KPiA+cm91dGUgY2FjaGUgdmVyc2lv
biBpcyBhbHJlYWR5IGRpZmZlcmVudCB3aXRoIGZpYiBub2RlIHZlcnNpb24uDQo+ID5UaGUgcm91
dGUgY2FjaGUgaXMgcmVmcmVzaGVkIHRvIG1hdGNoIHRoZSBsYXRlc3QgcnVsZS4NCj4gPg0KPiA+
U2lnbmVkLW9mZi1ieTogU2hpbWluZyBDaGVuZyA8c2hpbWluZy5jaGVuZ0BtZWRpYXRlay5jb20+
DQo+ID5TaWduZWQtb2ZmLWJ5OiBMZW5hIFdhbmcgPGxlbmEud2FuZ0BtZWRpYXRlay5jb20+DQo+
IA0KPiAxKSBZb3UgYXJlIHN0aWxsIG1pc3NpbmcgRml4ZXMgdGFncywgSSBkb24ndCBrbm93IHdo
YXQgdG8gc2F5Lg0KSSBhbSBzb3JyeSBmb3IgdGhlIGNvbmZ1c2UuIE15IHByZXZpb3VzIGNoYW5n
ZSBsb2cgb2YgZml4IHRhZyBpcyBhDQp3cm9uZyBkZXNjcmlwdGlvbiBmb3IgIlBBVENIIG5ldCB2
MiIuDQoNCkN1cnJlbnQgcGF0Y2ggZG9lc24ndCBmaXggcHJldmlvdXMgY29tbWl0LiBJdCBpcyBt
b3JlIGxpa2UgbWlzc2luZw0KZmx1c2ggc2luY2UgdGhlIGZpcnN0IGNvbW1pdCAxMDEzNjdjMmY4
YzQgb2YgY3JlYXRpbmcgZmliNl9ydWxlcy5jLiBJcw0KaXQgT0sgdG8gYWRkIHRoaXMgZml4IG9y
IG9taXQgZml4IHRhZz8NCg0KPiAyKSBSZSBwYXRjaCBzdWJqZWN0Og0KPiAgICAiaXB2NjpmbHVz
aCBpcHY2IHJvdXRlIGNhY2hlIHdoZW4gcnVsZSBpcyBjaGFuZ2VkIg0KPiAgICBDb3VsZCBpdCBi
ZToNCj4gICAgImlwdjY6IGZpYjZfcnVsZXM6IGZsdXNoIHJvdXRlIGNhY2hlIHdoZW4gcnVsZSBp
cyBjaGFuZ2VkIg0KPiAgICA/IHBsZWFzZS4NClllcywgSSB3aWxsIHVwZGF0ZSBsYXRlciBpbiB2
NC4NCg0KPiAzKSBDb3VsZCB5b3UgcGxlYXNlIGhvbm9yIHRoZSAyNGggaG91cnMgcmVzdWJtaXNz
aW9uIHJ1bGU6DQo+IA0KaHR0cHM6Ly93d3cua2VybmVsLm9yZy9kb2MvaHRtbC92Ni42L3Byb2Nl
c3MvbWFpbnRhaW5lci1uZXRkZXYuaHRtbCN0bC1kcg0KPiANCk9LLiBJIHdpbGwgZm9sbG93IHRo
ZSBydWxlIGxhdGVyLg0KDQo+IHB3LWJvdDogY3INCg==

