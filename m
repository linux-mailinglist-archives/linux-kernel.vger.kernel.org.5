Return-Path: <linux-kernel+bounces-132719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C779899942
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 11:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 501CE1C20AD1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 09:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC8A160782;
	Fri,  5 Apr 2024 09:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="WnESfnuw";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="k35olX4c"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A903415FD17;
	Fri,  5 Apr 2024 09:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712308539; cv=fail; b=ULDrJnhdO1q1EWSzNhGALCOP4GdOL0InLA+gt0Mu63G30SNR44G9Ipu3mFGAzWxwEg9F1yp2HhgmYYCiK202c4tZJwfydkVU+rdUUqWUC7xO89+bsyLQORFojCEJg3Eg5FseOcyBPLQ9rrqqt1m9xO+ThPfiLGSznjfN1n3mOFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712308539; c=relaxed/simple;
	bh=c5cLrvDjR5QDts85y0o3IRJUdnYWQNoeNr6UHXqlk8k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dPQbt0riyDR0/e6q3XpXJFxvhs/0tUPlW++JOHR5WUw+h0mFHxPIeVhadkGbOspjlPo9l6e860hNKMlosOO13v7isgWKBipofJui627B9TnkKUQ7kpdjZSf37+yTbuqmXetpRDS2/c9StzcYjPitgLibyzWIDhka+brh3hqOYp8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=WnESfnuw; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=k35olX4c; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 0990e650f32d11ee935d6952f98a51a9-20240405
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=c5cLrvDjR5QDts85y0o3IRJUdnYWQNoeNr6UHXqlk8k=;
	b=WnESfnuwhD1zpUjl9y+9sCcvCLOTg76TMfqdExe8GXj+sfxdeaLrRrtPlgmXgEyoPdo5G3RdDhyi7YL45eEiHR0oGSdyLLaysmyWA5T5mrrBHTGHPDZCh0ZlydTrFZnMc7lnPrpPrjYyMFcAdsw0V0rVzEUzY29el1cWvCHWIeM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:62a6acc3-8af1-47af-9767-d02d5eb49ba5,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6f543d0,CLOUDID:dab6d485-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 0990e650f32d11ee935d6952f98a51a9-20240405
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
	(envelope-from <deren.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 671367487; Fri, 05 Apr 2024 17:15:25 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 5 Apr 2024 17:15:24 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 5 Apr 2024 17:15:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jw8m3s8XM6MTgWo3XWk/Z3Ne2vqJ2AZP7OnIXAVXm33GRcphMaj4arF3czJh27i3XXMDnZKq9fwQz/uEISjltbNJWDbUZZTJjZVez/wVcUdjtXa3eDVhUPUZI0E9qIpQeg0wZ2nhcX/kBXQ9t31Gqww50S8pjSapPvjXwY+Qq0kxmabew2+ourrjhWBWZZZIBdrwVkGvAMNDBI1a62QoQzGUwTSbx+Afqhp9zUMEL2DumaL8p/yOYe/o+bsPeq+JlDLGAUIuq61kl0CfrXyxYrFnmexa17/95jXEDJmv8O2aG6KHutYtlCJl9YdR77rTaONmxxpWjKOYB/QQC6vsUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c5cLrvDjR5QDts85y0o3IRJUdnYWQNoeNr6UHXqlk8k=;
 b=W8OvJVSp5+KKdYX8DmTopfpu7ccrVLS7jbf6Zuev8R8L99xpo1oXFVyxo67t2olYflZ689WNE4uZ4D5ClLpPqJ9OB12XiSWjBoZTi23WtxAUpsvROvsYXAHS7mIKqTRv/kiqHNhbOdAJjd9vD9sTETAzIs2cWEU2SLDHHxfs834Jny960gvzTeKpsK/sAG4cPLn753pcoZhOWkCJkJj0h20xVLUgm9GFuPdxVg3e+abbvbjoyfUocxzVuUNIGKedwekqGoXtSRt+u8ZLa5u1te081evrMlA/8xkptAOhim2VwexF9jEfv0/e9t9pB6UBRop1auZI3u2n4jfUW2NU6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c5cLrvDjR5QDts85y0o3IRJUdnYWQNoeNr6UHXqlk8k=;
 b=k35olX4cM29r/0av9tClqb3wIYyf7fl8ImL6wTbIA15o8iNIO02I94TiVtpaArzryOQr05xcAfcS28Yrwoi+NC5HL992mVLIlvYQvw6fDS2JlcGctnAMgUp+KjScK7Zg1gvyUQOgpAiyU8bUPE9hRidkyQA+NZlrOx5ZNGgq2XQ=
Received: from SI2PR03MB6194.apcprd03.prod.outlook.com (2603:1096:4:14e::9) by
 SI6PR03MB9070.apcprd03.prod.outlook.com (2603:1096:4:21f::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.46; Fri, 5 Apr 2024 09:15:21 +0000
Received: from SI2PR03MB6194.apcprd03.prod.outlook.com
 ([fe80::f97f:3057:4105:8c9e]) by SI2PR03MB6194.apcprd03.prod.outlook.com
 ([fe80::f97f:3057:4105:8c9e%7]) with mapi id 15.20.7409.042; Fri, 5 Apr 2024
 09:15:20 +0000
From: =?utf-8?B?RGVyZW4gV3UgKOatpuW+t+S7gSk=?= <Deren.Wu@mediatek.com>
To: "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
	=?utf-8?B?UGV0ZXIgVHNhbyAo5pu554+G5b2wKQ==?= <Peter.Tsao@mediatek.com>,
	"mike@fireburn.co.uk" <mike@fireburn.co.uk>
CC: "marcel@holtmann.org" <marcel@holtmann.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?utf-8?B?Q2hyaXMgTHUgKOmZuOeomuazkyk=?= <Chris.Lu@mediatek.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"johan.hedberg@gmail.com" <johan.hedberg@gmail.com>,
	=?utf-8?B?U3RldmUgTGVlICjmnY7oppboqqAp?= <steve.lee@mediatek.com>, Sean Wang
	<Sean.Wang@mediatek.com>, =?utf-8?B?QWFyb24gSG91ICjkvq/kv4rku7Ap?=
	<Aaron.Hou@mediatek.com>, "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>
Subject: Re: [SPAM]Re: [PATCH] [PATCH] Bluetooth: btusb: Add support Mediatek
 MT7920
Thread-Topic: [SPAM]Re: [PATCH] [PATCH] Bluetooth: btusb: Add support Mediatek
 MT7920
Thread-Index: AQHahEhnJB3UFg9r+kiXuUvYNsr/FbFZX5EAgAALbgA=
Date: Fri, 5 Apr 2024 09:15:20 +0000
Message-ID: <11f098c7cc3a063fd20c02f1a66372e3444cb272.camel@mediatek.com>
References: <20240304144844.2042-1-peter.tsao@mediatek.com>
	 <20240401144424.1714-1-mike@fireburn.co.uk>
	 <CAHbf0-FqUqoDty81OH9_Et7MTWFikYYhEvP7SBVGyeXO-R94_A@mail.gmail.com>
	 <2d822b6c-8b55-443d-ad9e-03e97ce7b99b@leemhuis.info>
In-Reply-To: <2d822b6c-8b55-443d-ad9e-03e97ce7b99b@leemhuis.info>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB6194:EE_|SI6PR03MB9070:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZuHJJdM1s4Ob862BuMYaUs5YEKIx/f666wOUaGiM+WcZMis1nVT/O5bWuFeQPc7T2JCwFxxoUItkrwO1IHRB4+hFCykH/FGXDLCgDOjbhqOrEanpKlx4tW/5wwMybyA2cw9OYuAfQCOObMSeFNpYwD7VF/8YXvA2avRDhmWpadIVrPzSsh//grjZdo26h9RWhgC5JwhgMqeR/blbL5g9cgdsTrhahmWQuNxq25z4S9jAjLi4+5o38zRsnV8I+5haWe/DB60o0FdI1CrtX/I6p21DKF3ZLLp6nAXLqv8YhfODM8kU6GjUzBdaw832nhJd/9WXi8RajZHW/l1TJdKErJ7CYs7PBct5gn9MZ6cwoPjNeOcZu6yym+KLHZNblcsR6ftcVDJVEULEFGtYvl65Yd4CPG+EQO6V1QqC1JJjzTzesVR4aUOLLkrDB0M/LlupAqnmLCMl2K8PoqqMd+h3ZjS+0QvvhbLXSAsumvkvSDz3hnJgAfRGRg69wq7WOlRMN20wmbw9JRwyvck0JqI07I3hkqd4oOTL0KGWQL+J/obnptpBYvHpqXNCmlWPNdUCLjVT0e5Lgeb9V2hQkRcDdpkTbUEdjAy47AutvovgWGTyAZyw/EBvtr0BV8vm5knxZyEVOJuces1g9i7OZ2tlp0U//la8TE0+66vELsi3zAY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB6194.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(217643003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MDNYbm1nOTZmN1NNWWQ2TEVuNUNISVkrM3B4cERscDdITVJBWEVLTXZxYmc5?=
 =?utf-8?B?bDY4VUxleUlDZEIzckVxSlpVcGtsRFdPS1RwdzJDUy9WZnh2MG5HQ3VXMldz?=
 =?utf-8?B?czJFSFpiMHBKYlpWYkt6RWlnaWdxOTJHSDljZ0hXbk00YUtSSDlSTDd6WUd5?=
 =?utf-8?B?YmQxNHNOTHNzTzRUYUhCeGpCVGpJT0s4WHphOFdhUWY5MGFpYzF6T1ROc2l5?=
 =?utf-8?B?MlBlVFdkWFd4UzYvUUZiL3ltQ3NJM25EeTl4WmtUcTRmdC9sT0VVcENYbXNI?=
 =?utf-8?B?Sk1iQnBBenI1OXFieGlsdGUxamdJajBtYWUrZmFZRncxeEJ1bjZEd0N5S1Jh?=
 =?utf-8?B?dTBtUnZ3UTlsbUhnRTRkSTUxWW42ZU04V25sY3FaWCtza3QzK3NtdkZXdlJ4?=
 =?utf-8?B?OXBsUTdlVlYrVVFOS3h4bUIxcUM4MkRya3JVNGp0Sjk4eTA2MW82YWwvdkgr?=
 =?utf-8?B?L0p4b0tIR0FHLy8veEpBU1l2RG83amZtVkNVblM5WWVBQWlhU1FkUzdzUjl3?=
 =?utf-8?B?VWwvOEg0MllINVJ0Y2g3Ykw0dVhwL0ErVVhDRDlreXY4RmwvVFduT0lLZnhL?=
 =?utf-8?B?cVpBaDVmQ29UbUJPWUlTN0N5a05Ud1p4d1FRT0xLT3JUUFFMaTluYW5HcVpG?=
 =?utf-8?B?bTVXdmRURmpRNDNqK1ljN2ZyMEFTNjNMMTEyc0FKWkg1cGU2MCtZTE5GSm84?=
 =?utf-8?B?UFdCU00waEl1U1BXdFVtc240UnF0UVBwWlI1d1RIRzcvRG4vRFZYenhGL09F?=
 =?utf-8?B?a05PdWIzYlJqSFVZM2ZsNHFXRFZoMW1QNWM2T0dOdnkvMzNrSVdXWEZGa0J4?=
 =?utf-8?B?K2hmY3VjSjV6eFpsVFRoeVNaVElFdnlqYjI1M1NHU25SOXZHRU5xdjVnRjEz?=
 =?utf-8?B?aUhOaWhrdWxEUXpLbnE0c2xMR2x1RllQeUpabkFHVElaN2tWRlZWaVhteWor?=
 =?utf-8?B?cTFZOUF5NEEwTysxMVkwRVNZcmVhcmtqZTJuUFplejV6R2VESHNhRHBIRlpD?=
 =?utf-8?B?bVpKK2x2emhwMTI3SGdPbG5HM0J4RjBXaEpKMnlyK0J6VDhpd1ZlZWh3YVpO?=
 =?utf-8?B?Mk5Ga0Znak10eU1INW9tWUdobWk4U2tBa0tFT0J3ZmoxMjNTc3A0dm1tc2VF?=
 =?utf-8?B?S1Fac1ovNlNkTWtnWjRoTlVXa2N4WEdGcGpwa0RXT3ZJOVBwWVF5RDVPaDJZ?=
 =?utf-8?B?eFFCdDk4QVRJdjFXNUtlV0R3NGxwZUFtcDJyL1YxVGFWdVFSN0ZUeWZLeC90?=
 =?utf-8?B?YWVOT1lBeUtFT3l2YXhBRXp6cWdCNFcrRzR2dmE0YUI1aGk0V2kyR2dheWZE?=
 =?utf-8?B?aG02ckt2QmFKRW10dVJ6RnlReUpqdGdKMGROWmcrV0l2c1N0UzRSWjFjWmd6?=
 =?utf-8?B?dlZTKzNlMEM5UVlhTDRSeHBDRWZGeGVJcFlKbTFCQnZOdy9LSGUzVDB3N1VB?=
 =?utf-8?B?cGVVeDZjNFNoVnZWc016YzVHdmFiY0ZqeHAxMWRrMTh4aVNNWVFRdCtEUytt?=
 =?utf-8?B?bjRRcStuQ3I3ZitRNGNUQnpFQWR0NlZJSzhYV09PNHpsWWVHR1VDNllsbjZV?=
 =?utf-8?B?eDVZdWFyTXlqSSthNWlPd2dVSjlNOEU3ZEpKL1VDd0VFOVJkK09OMWRVNlZP?=
 =?utf-8?B?R1Y1K1FWRWs5KzMzaGg2dFNhWmJOcERkV25jRnFmSzdyaTdaZkxEU2Z0enFi?=
 =?utf-8?B?MHFoSkxjY08zZXZzOXFRcmpHdklzdkkzTjMyV2wzZlIwemx1ODRtUFhsaGhF?=
 =?utf-8?B?c3FNclVrbjhaR0hPNlpJMHAxNk1BSnA0YWtENHZaWm9RUnJINnhCRCtQdFNZ?=
 =?utf-8?B?aHNJemdsWCtEaWllZG91OGlXUWgyakVYQ0N4T1BCcGZuZ0RpS3pkYU0zaVdR?=
 =?utf-8?B?YkpaTm5ESkNCU1VnMmN6ZHY1UEpjV21wZnU1bWtnbXhnckdsRnIvWnB0dVdw?=
 =?utf-8?B?RnQ5cExZSytLMUlDWEZHTU1jM2V0QnU5WXBpTE9BeS9FalRMWG5FeE9lSU45?=
 =?utf-8?B?YUNBWVYrNUdsMTRJbzc1MVVHbjczci9YeTMrSktnM1pRbGJ3WG9MMnk3TjhG?=
 =?utf-8?B?VVlVeVJIekZ3N29IM1dWTCtCNTRtbk13VEs0bmlzbXQweUNSRm1xMXJoWElM?=
 =?utf-8?B?VUpHdk55ZGNGbitnSHZJRkZIQnNHWU1Sa2ZHWFZ4SzRRNmRJb2hVRTVjRjZ2?=
 =?utf-8?B?S0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8A6C0F8B16BECE4C96325407E781F639@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB6194.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb336dfe-1333-4238-88b4-08dc5550eb0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2024 09:15:20.8792
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wGDg1Xr/OQ7BziXlVy+nIei4nBhsnxLXLp9s4cl0fP8JaCujvfSdI0xXVoptV0xxkO55qNdDmindvRUR82lJQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI6PR03MB9070

SGkgVGhvcnN0ZW4sDQoNClRoYW5rcyBmb3IgdGhlIG5vdGUuIFdlIGFyZSBsb29raW5nIGZvciBz
b2x1dGlvbiBmb3IgdGhpcyBpc3N1ZS4gUGV0ZXINCndvdWxkIHBvc3QgdGhlIG5ldyBwYXRjaC4g
OikNCg0KUmVnYXJkcywNCkRlcmVuDQoNCk9uIEZyaSwgMjAyNC0wNC0wNSBhdCAxMDozNCArMDIw
MCwgTGludXggcmVncmVzc2lvbiB0cmFja2luZyAoVGhvcnN0ZW4NCkxlZW1odWlzKSB3cm90ZToN
Cj4gW0NDaW5nIHRoZSByZWdyZXNzaW9uIGxpc3QsIGFzIGl0IHNob3VsZCBiZSBpbiB0aGUgbG9v
cCBmb3INCj4gcmVncmVzc2lvbnM6DQo+IA0KaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0
dHBzOi8vZG9jcy5rZXJuZWwub3JnL2FkbWluLWd1aWRlL3JlcG9ydGluZy1yZWdyZXNzaW9ucy5o
dG1sX187ISFDVFJOS0E5d01nMEFSYnchbjlPUURRdGZNaVFkZGR6Tkx2TUVPTUxubkVIaHcxMktS
WTVXNVlQc2NRSlRpTlF0dUlWdUp1Zk5jMlVZcHktclVsUnRNVXdac0w1TkRFUklmMUNvR294OEoy
SSQNCj4gIF0NCj4gDQo+IE9uIDAxLjA0LjI0IDE3OjIwLCBNaWtlIExvdGhpYW4gd3JvdGU6DQo+
ID4gT24gTW9uLCAxIEFwciAyMDI0IGF0IDE1OjQ0LCBNaWtlIExvdGhpYW4gPG1pa2VAZmlyZWJ1
cm4uY28udWs+DQo+ID4gd3JvdGU6DQo+ID4gPiANCj4gPiA+IEkgdGhpbmsgdGhpcyBwYXRjaCBp
cyBjYXVzaW5nIGlzc3VlcyB3aXRoIG9sZGVyIGZpcm13YXJlDQo+ID4gPiANCj4gPiA+IEJ1cyAw
MDMgRGV2aWNlIDAwMjogSUQgMTNkMzozNTYzIElNQyBOZXR3b3JrcyBXaXJlbGVzc19EZXZpY2UN
Cj4gPiA+IA0KPiA+ID4gWyAgICAwLjMxNTA2NF0gQmx1ZXRvb3RoOiBDb3JlIHZlciAyLjIyDQo+
ID4gPiBbICAgIDAuMzE1MDY0XSBORVQ6IFJlZ2lzdGVyZWQgUEZfQkxVRVRPT1RIIHByb3RvY29s
IGZhbWlseQ0KPiA+ID4gWyAgICAwLjMxNTA2NF0gQmx1ZXRvb3RoOiBIQ0kgZGV2aWNlIGFuZCBj
b25uZWN0aW9uIG1hbmFnZXINCj4gPiA+IGluaXRpYWxpemVkDQo+ID4gPiBbICAgIDAuMzE1MDY0
XSBCbHVldG9vdGg6IEhDSSBzb2NrZXQgbGF5ZXIgaW5pdGlhbGl6ZWQNCj4gPiA+IFsgICAgMC4z
MTUwNjRdIEJsdWV0b290aDogTDJDQVAgc29ja2V0IGxheWVyIGluaXRpYWxpemVkDQo+ID4gPiBb
ICAgIDAuMzE1MDY0XSBCbHVldG9vdGg6IFNDTyBzb2NrZXQgbGF5ZXIgaW5pdGlhbGl6ZWQNCj4g
PiA+IFsgICAgNC42NzA4MTFdIEJsdWV0b290aDogUkZDT01NIFRUWSBsYXllciBpbml0aWFsaXpl
ZA0KPiA+ID4gWyAgICA0LjY3MTAyOV0gQmx1ZXRvb3RoOiBSRkNPTU0gc29ja2V0IGxheWVyIGlu
aXRpYWxpemVkDQo+ID4gPiBbICAgIDQuNjcxNzkwXSBCbHVldG9vdGg6IFJGQ09NTSB2ZXIgMS4x
MQ0KPiA+ID4gWyAgICA0LjY3MzQxNl0gQmx1ZXRvb3RoOiBCTkVQIChFdGhlcm5ldCBFbXVsYXRp
b24pIHZlciAxLjMNCj4gPiA+IFsgICAgNC42NzM2NTldIEJsdWV0b290aDogQk5FUCBmaWx0ZXJz
OiBwcm90b2NvbCBtdWx0aWNhc3QNCj4gPiA+IFsgICAgNC42NzM4OTVdIEJsdWV0b290aDogQk5F
UCBzb2NrZXQgbGF5ZXIgaW5pdGlhbGl6ZWQNCj4gPiA+IFsgICAgNC42NzQxMjVdIEJsdWV0b290
aDogSElEUCAoSHVtYW4gSW50ZXJmYWNlIEVtdWxhdGlvbikgdmVyDQo+ID4gPiAxLjINCj4gPiA+
IFsgICAgNC42NzQzNjBdIEJsdWV0b290aDogSElEUCBzb2NrZXQgbGF5ZXIgaW5pdGlhbGl6ZWQN
Cj4gPiA+IFsgICAgNS4wMTYzNjVdIGJsdWV0b290aCBoY2kwOiBEaXJlY3QgZmlybXdhcmUgbG9h
ZCBmb3INCj4gPiA+IG1lZGlhdGVrL0JUX1JBTV9DT0RFX01UNzk2MV8xYV8yX2hkci5iaW4gZmFp
bGVkIHdpdGggZXJyb3IgLTINCj4gPiA+IFsgICAgNS4wMTcxNjNdIEJsdWV0b290aDogaGNpMDog
RmFpbGVkIHRvIGxvYWQgZmlybXdhcmUgZmlsZSAoLTIpDQo+ID4gPiBbICAgIDUuMDE3NTU3XSBC
bHVldG9vdGg6IGhjaTA6IEZhaWxlZCB0byBzZXQgdXAgZmlybXdhcmUgKC0yKQ0KPiA+ID4gWyAg
ICA1LjAxODEyOV0gQmx1ZXRvb3RoOiBoY2kwOiBIQ0kgRW5oYW5jZWQgU2V0dXAgU3luY2hyb25v
dXMNCj4gPiA+IENvbm5lY3Rpb24gY29tbWFuZCBpcyBhZHZlcnRpc2VkLCBidXQgbm90IHN1cHBv
cnRlZC4NCj4gPiA+IA0KPiA+ID4gVGhlIGNvcnJlY3QgbmFtZSBzaG91bGQgYmUNCj4gPiA+IG1l
ZGlhdGVrL0JUX1JBTV9DT0RFX01UNzk2MV8xXzJfaGRyLmJpbg0KPiA+ID4gDQo+ID4gPiBSZXZl
cnRpbmcgdGhpcyBwYXRjaCBmaXhlcyB0aGluZ3MNCj4gPiANCj4gPiBJZiBpdCBoZWxwcywgdGhl
IGRldmljZSBJRCBpcyAweDc5NjEgYW5kIHRoZSBmd19mbGF2b3VyIGlzIDI0IG9yDQo+ID4gMHgx
OCBpbiBoZXgNCj4gDQo+IFRoYW5rcyBmb3IgdGhlIHJlcG9ydCENCj4gDQo+IFBldGVyLCBkaWQg
eW91IGxvb2sgaW50byB0aGlzPw0KPiANCj4gQW55d2F5OiBUbyBiZSBzdXJlIHRoZSBpc3N1ZSBk
b2Vzbid0IGZhbGwgdGhyb3VnaCB0aGUgY3JhY2tzDQo+IHVubm90aWNlZCwNCj4gSSdtIGFkZGlu
ZyBpdCB0byByZWd6Ym90LCB0aGUgTGludXgga2VybmVsIHJlZ3Jlc3Npb24gdHJhY2tpbmcgYm90
Og0KPiANCj4gI3JlZ3pib3QgcmVwb3J0Og0KPiANCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2Fs
bC8yMDI0MDQwMTE0NDQyNC4xNzE0LTEtbWlrZUBmaXJlYnVybi5jby51ay8NCj4gI3JlZ3pib3Qg
aW50cm9kdWNlZDogMWNiNjNkODBmZmY2YzQNCj4gI3JlZ3pib3QgdGl0bGU6IG5ldDogQmx1ZXRv
b3RoOiBmaXJtd2FyZSBsb2FkaW5nIHByb2JsZW1zIHdpdGggb2xkZXINCj4gZmlybXdhcmUNCj4g
I3JlZ3pib3QgaWdub3JlLWFjdGl2aXR5DQo+IA0KPiBDaWFvLCBUaG9yc3RlbiAod2VhcmluZyBo
aXMgJ3RoZSBMaW51eCBrZXJuZWwncyByZWdyZXNzaW9uIHRyYWNrZXInDQo+IGhhdCkNCj4gLS0N
Cj4gRXZlcnl0aGluZyB5b3Ugd2FubmEga25vdyBhYm91dCBMaW51eCBrZXJuZWwgcmVncmVzc2lv
biB0cmFja2luZzoNCj4gDQpodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9saW51
eC1yZWd0cmFja2luZy5sZWVtaHVpcy5pbmZvL2Fib3V0Lyp0bGRyX187SXchIUNUUk5LQTl3TWcw
QVJidyFuOU9RRFF0Zk1pUWRkZHpOTHZNRU9NTG5uRUhodzEyS1JZNVc1WVBzY1FKVGlOUXR1SVZ1
SnVmTmMyVVlweS1yVWxSdE1Vd1pzTDVOREVSSWYxQ29RY2FvbDBzJA0KPiAgDQo+IFRoYXQgcGFn
ZSBhbHNvIGV4cGxhaW5zIHdoYXQgdG8gZG8gaWYgbWFpbHMgbGlrZSB0aGlzIGFubm95IHlvdS4N
Cg==

