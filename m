Return-Path: <linux-kernel+bounces-107153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C17687F835
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 08:16:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A37C528255A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 07:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D636524A2;
	Tue, 19 Mar 2024 07:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Ot8m4z3E";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="s7MV7r8n"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D4C50A80;
	Tue, 19 Mar 2024 07:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710832550; cv=fail; b=CleB0fgG1JCwJtYre+N60VRihkEcdgZAfv1ImnL/rok/uAcYjn58LGmPdZ7a1ltEkheh4aH5PNRzkkR8oA1VAFYwU4dG3YxgkQjn3df7BcGbsLSdifyD02RfyWjQB3uWh3oLALCl10rIazXxKTCYfBrLL+B0FklKNBFETTqljX8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710832550; c=relaxed/simple;
	bh=ZDpJn4/wUz6kNUQTo6gJvzuTZRoXwVypcMn0AJwtBI0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QEwOz7LYSUGhu1T/vUUaGEalvUbqAelhdz/R3OVQAIMgnFGYfOeYQXoPs6FxDmHI/nv9ADqyCctOwNPzkS0/MZ6whM8xykuCgPOBaUxJgpzEsz7kGOxcyx6It/KFgrfyeoWvoKgkQAjJNNn3a5ENANaT12v4Rcc/JcencdIifhY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Ot8m4z3E; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=s7MV7r8n; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 7d963340e5c011ee935d6952f98a51a9-20240319
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=ZDpJn4/wUz6kNUQTo6gJvzuTZRoXwVypcMn0AJwtBI0=;
	b=Ot8m4z3EfefxRH/luFQ36FMxxFCVlq3e05Pu/EYZnFc4UL5Q25+Sdy+ljuNSDpSsi5o+JK1tRB2oe+HX3B+7idRY5PBGNfGXQ0dO6LzGotL6rxWP9fSLntsjGR/9+UyIk7Agnuai5OuvEWdDNPR4NYcxcrfCOWEJBanyVQ2yVK0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:1eca7161-7e1f-468f-aa06-25aabbc94e04,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:73de9190-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 7d963340e5c011ee935d6952f98a51a9-20240319
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1414190577; Tue, 19 Mar 2024 15:15:39 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 19 Mar 2024 15:15:38 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 19 Mar 2024 15:15:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AHuVWp87zITsuXUdo/lv4NWZqlU5m/b17ad8lp/1gxu98p+w1vwOKqSiCr1Xgp3B3HKP1PueXu/1RL6I8dMqgDEcyzGZZsSiRttivAck4FzCjasUU9dC0576hkB91G28U/brR3t+gj8EjP7fXwmdlFHtQYRo3ArwtJBnaMTjXWkUiH42XqqKi78e7f3eBxLhdZd6Pp/adXY1wLA7HHGsu8WmRUJCq01pCkUf+OieCGl5Se4KldrY19QuiWFnHXPQ2QORFlEDRWrK6ezFG+J6eWkARMylZreq3CKojIVJ0vS9pKltDhVxROGv0ulA8PZmONnHFquoMuaViaCRY2BFJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZDpJn4/wUz6kNUQTo6gJvzuTZRoXwVypcMn0AJwtBI0=;
 b=hdZdk7tR5hw7WdKpkf6nGvalvUeFDfje5kY29FKHyVBnGviiJIiLAtbUCDdnNoKeh7YYebbycQkrdy0vN+VonAe1FWqgwJEqmamle5JFJcjbmlST1DFJSIYZCg1nL8rB7LSwPuw9O5OaofV+snS0SDXMjztjGE5rJvYGrnGkgBj//7FvjRTILa7LHDw2afzT3+uvQZL2EW7Cojr111Vm9Rjqt8JAg8tDu9nHRDSSmx0BGCDc9u0a/EfMuGVnPLlVkDHYxTS0OLECTCCDkghZgbRIgFjW1PIjjx/tvzEHM3zoZYxIarFjGqwhbCtTzLlFOQKs70zPIFn6C2DcPAiz0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZDpJn4/wUz6kNUQTo6gJvzuTZRoXwVypcMn0AJwtBI0=;
 b=s7MV7r8n7a9FCr0w4EcbnCuXeucknyAK/7X+pKFB1nHMAhuKCw0vfwz0p+11P/1BFUq5ydyZjHkTPk1aLD+L5UIWws/KMEcMZnOtNs32HwrHQxuXhzeDYjv/0202euu5rT83AhNqTajiwPpbjTVRBbu8gIaFql8scXSkmiYU+4w=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SEYPR03MB8126.apcprd03.prod.outlook.com (2603:1096:101:16c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Tue, 19 Mar
 2024 07:15:35 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::f3b6:91a7:e0fb:cb27]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::f3b6:91a7:e0fb:cb27%7]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 07:15:35 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	=?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= <Singo.Chang@mediatek.com>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	=?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?=
	<Jason-ch.Chen@mediatek.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?=
	<Shawn.Sung@mediatek.com>, =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?=
	<Nancy.Lin@mediatek.com>, =?utf-8?B?Sm9obnNvbiBXYW5nICjnjovogZbpkasp?=
	<Johnson.Wang@mediatek.com>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 1/3] dt-bindings: display: mediatek: gamma: Change
 MT8195 to single enum group
Thread-Topic: [PATCH v2 1/3] dt-bindings: display: mediatek: gamma: Change
 MT8195 to single enum group
Thread-Index: AQHaax5/UKesKLKEQUmJ8zwbWTCki7E+xDuA
Date: Tue, 19 Mar 2024 07:15:35 +0000
Message-ID: <8b87bfe4e3d9cb8a7d142f5dad72eff0e0df47de.camel@mediatek.com>
References: <20240229144844.1688-1-jason-jh.lin@mediatek.com>
	 <20240229144844.1688-2-jason-jh.lin@mediatek.com>
In-Reply-To: <20240229144844.1688-2-jason-jh.lin@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SEYPR03MB8126:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O6Sui934beuLVykFJxSHtZdckvoyinuTPqnXhtqWJNJUl0M8cs5WKAZBvqm/iFOKNhNDC8GqRYZ4X+H6fuqgWANg9Uk44IFGCN7/lSqTRh2mgAzow4H2hvOnTBWb9Tju8IiTRHWgbuSMXUrCjCWYVsL2G9/g/9JhvcxUTDKjH3fpUI4QfNbvNFv+iuKTh1F5BgAP3UHwgp2OzyOmj4B/CqvZcal23gtaBH4r8eGsU4DwxmmedNHoHz/B7f1F76+9z/3zAeOBIwMG1OZ9mypdGgdUG4L9tqpGjxXZ3ATRIAUXkX4UBEMRggId8jpH3186BttoMSIC53iyaAlFvfQJ125PtMsxU7cyE8KllWyFEGd9ogNikqKDC5FEsrmp+XzoXynNqttD3ZUCY+nTzys4yT6AUuFIOB9b4Ig6SFaGo08dyMKIRW4mFMyDQT0GLhOvfKiSZjyNNDE5Nu8BY/kjCHxwcS5rHx4XgZygoOC4YsD0PqBIdfyHTtgzWoPC+c0fWsTb7U9YVLVggESVfAGBv49I21XOJ490yWui6oA6lq2guCnBMDQgpDlT+0kyLZMlw7cuiK2t65oF/Dg4rbo42RQ+TuIhKOysnSn/Yp3eE/AGa9uCKoYLZ5aOtkKkuKmKl1JqXgrqA3Mm8hlTWK56kFphcyGS4rw6l04sAOAgY+s=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y2lCMG1Lcmx3dm95dUhjRXZ3dkxwSmlMbUYwWWptbjRvOFlucGl0Q3NqblBK?=
 =?utf-8?B?WW8vWjFFTCtnYUcrRVRFV2xBRFlrZVM3V1FKRGtmaG14NnFrRGgxVWNwRUg1?=
 =?utf-8?B?Z3cwOTdseVUvNnJhNTVIazVQa0hmeEpxSG9ySlpMY0xxUjBjaEZvNm1XbXY5?=
 =?utf-8?B?VVhvZDQxcVk1bVBGdVF4WmdYMEZJQnVMRnhWaUx1ZDN3b2RmeE1ZNmNxZU50?=
 =?utf-8?B?ZkdLaTJ0Mk1zMi8rNWF6azJaR1JWTXBRQlVpcitVKzNuWmM2TjZoa25KeTZv?=
 =?utf-8?B?U3lDY0Jzb2paTTh3TEpFc004ZUpkQUlCYSt4dGRQeTNKcFl1L0VUcHg3WWRY?=
 =?utf-8?B?a1FYN2YrNnU0MENvUFNaVTZvWUFmQjVTNWhzRThYTUJxdyt5S0R5MkNKT1Vm?=
 =?utf-8?B?Q0Vsb1c2bWhDc0d3Vms3WkV5b0QzL0M0ZzNDak1NVDJESG1GOGtwTytTNnY4?=
 =?utf-8?B?RC9SRzhUVmJIRzkxL0dvMkVTSHVNK0hUaGxWa0tDTXN6RWgzL0c4VmIyQVNv?=
 =?utf-8?B?VDdjWjh1dUJtUG9Wa3hMMkRFWm1pRjB1NEp3eGdYWWRiYThINk1DQ2Y5VmQv?=
 =?utf-8?B?QWV4bVJ3WmREWVc2NCtWL1JxNjZuQ1ZHeGhKaytIUHNuQXhXVkxnc3doeWVp?=
 =?utf-8?B?SFZkZmU1M1BLTkxwVHFubHpDbzRXcU90dWhlWTh2YUxHbEdHdmk3NFVMV1lh?=
 =?utf-8?B?aFRPWnNLV2FESThpRXQ2YVo4YXA3TjdtMGV2SzVsNEVZVjlTQXlYdWlxY0U3?=
 =?utf-8?B?MjdKNmZDQm1mclBKWmpRZXR4a1p1ZktCa3ZYeXpINUlKL2NxQzZ6eUY5R3hk?=
 =?utf-8?B?KzRLMXdVdUNGQ0Y2azVxZDlIT0xmejlvRk01T3pta3JkMEJ1dm9RTmtHWFN3?=
 =?utf-8?B?OU5IRHNwUjl1TElzT2R5ckMxUjRXUkJQdmJsbG1jcWJmY0cxNGF2a2g3dmJJ?=
 =?utf-8?B?SDNLb1dCODMvZG9teWcrU0FubHViQnJKNU1ZOU9ZbUdZYVpIN0JCR0xCTGkx?=
 =?utf-8?B?ZExUVGxRL2hpQ1RzTjFQRUhWS0dVWWtzdENLTTd6czdpakY2cDJRT25KWm5M?=
 =?utf-8?B?MXJ2QStBWlVaQStOMzVxMER2dmtSZk1YYUY5dGNMQitQQXFkcm1GaHlsSm5n?=
 =?utf-8?B?RTJxc3hOeWFYWFJsMVY3UVo5b1ViNEJodGVsZk5ZTHg5aGxCVjlwL2tSZ1JJ?=
 =?utf-8?B?SU83WElQdDZOVk5iRHp3cDY1YlU2aExnMG9IdFJuVWxoWXQrZFg3UU5YMzd3?=
 =?utf-8?B?QTdQZ3JHQTA0YlVYOXYzRTU5N2NQMDh0ekZNbFp2UzU0U3dyRU1XZi93Y3lY?=
 =?utf-8?B?T3RBV21MVG00aklOZXdwUUlZTkg5YjE3aE1JOEp0MTJGWHF5bmNhNExXTHRy?=
 =?utf-8?B?Lyt3OUVlVHBHRE15QnBiK082ZmRBaU5WcWRsVVJvbzVIUmt5Tm44TTRHTDNP?=
 =?utf-8?B?ZHpVWHNSeVZEVTd4dmlzNVhWV2srRDZsNkYySXF0NmIvZ3lqQzZmZ3RQczZW?=
 =?utf-8?B?ellSNDJMMEhDZkpyVlpPc0FsSFh1NGsza09ua1YrMUhLeTYybldkcWJMS3pV?=
 =?utf-8?B?b1pMaitNbHZNbzFac2ZvWnFTRkZkZUsvQ3hISlFBVExNNWlRWCt2YTc3cDJ3?=
 =?utf-8?B?VnpMbEVvQnNtZEFnL3lKbVorZG1sajYxT3RvZkZoQVYvbXJRb2VXTk4xVzRn?=
 =?utf-8?B?VUJJR04wRSsrUEVDbjJWaWVVOFpCckhPYncvblZTczVheEFlZFEzNzdsQzNS?=
 =?utf-8?B?b1dvellEdWpNWklXOU01TklRWWVRcmlVdzFyYWV4cVFnR1cxL3MxOVhCMVZm?=
 =?utf-8?B?ZFJYOWlpV1UyU3dRRVlKNG5xZHpSU1U3T1RVbEI1b3FBOGwweHM2eklxeTN6?=
 =?utf-8?B?V0dyeFZKbXNmT29JMjZucnV1MGdLTjRnMHg0OFBEbUhlS3ozR1FyTkhRSk51?=
 =?utf-8?B?SWhRMTZqME5IUWVhVkdSb3AzQU5BakE2ZTZ4YWVjNWZHL3l5MUplTWRxY0xr?=
 =?utf-8?B?MkI4ZDd6OXlGQnpMQ3JGUkhYTjMzNVYzcnRFM0YzTFRxKzg2NjJFME01eGh0?=
 =?utf-8?B?dENvQi9NeHVsNmRPU0o1MGIwUmlIcnBsRm0veUZFM2Nxeldld0M3Y2lKZTJJ?=
 =?utf-8?Q?uisGtE9DhZkBy3vMHjHbugl2P?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F09835063F627148990113E81F579C99@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16d27284-e801-44c4-8705-08dc47e45f38
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2024 07:15:35.4916
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e8olUZWaFMSJznffTPoyAkCO3LqoJc2pXmKZzrliQkvmu00Ziopu5vWuTsdMftCM0Ft/X2zTPJqLV6uJPNVU8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB8126

SGksIEphc29uOg0KDQpPbiBUaHUsIDIwMjQtMDItMjkgYXQgMjI6NDggKzA4MDAsIEphc29uLUpI
LkxpbiB3cm90ZToNCj4gU2luY2UgTVQ4MTk1IGdhbW1hIGhhcyBtdWx0aXBsZSBiYW5rIGZvciAx
MiBiaXRzIExVVCBhbmQgaXQgaXMNCj4gZGlmZmVyZW50IGZyb20gYW55IG90aGVyIFNvQyBMVVQg
c2V0dGluZy4NCj4gDQo+IFNvIHdlIGFkZCBNVDgxOTUgY29tcGF0aWJsZSB0byB0aGUgc2luZ2xl
IGVudW0gZ3JvdXAgdG8gbWFrZSBpdHMNCj4gZHJpdmVyIGRhdGEgc2V0dGluZ3MgY2FuIGJlIHJl
dXNlZCBieSBvdGhlciBTb0MuDQoNClJldmlld2VkLWJ5OiBDSyBIdSA8Y2suaHVAbWVkaWF0ZWsu
Y29tPg0KDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBKYXNvbi1KSC5MaW4gPGphc29uLWpoLmxpbkBt
ZWRpYXRlay5jb20+DQo+IEFja2VkLWJ5OiBLcnp5c3p0b2YgS296bG93c2tpIDxrcnp5c3p0b2Yu
a296bG93c2tpQGxpbmFyby5vcmc+DQo+IC0tLQ0KPiAgLi4uL2RldmljZXRyZWUvYmluZGluZ3Mv
ZGlzcGxheS9tZWRpYXRlay9tZWRpYXRlayxnYW1tYS55YW1sICAgICB8IDENCj4gKw0KPiAgMSBm
aWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+IA0KPiBkaWZmIC0tZ2l0DQo+IGEvRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvbWVkaWF0ZWsvbWVkaWF0ZWssZ2Ft
bWEueQ0KPiBhbWwNCj4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZGlzcGxh
eS9tZWRpYXRlay9tZWRpYXRlayxnYW1tYS55DQo+IGFtbA0KPiBpbmRleCBjNjY0MWFjZDc1ZDYu
LmVmMWY1NzU3NTdmNiAxMDA2NDQNCj4gLS0tDQo+IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL2Rpc3BsYXkvbWVkaWF0ZWsvbWVkaWF0ZWssZ2FtbWEueQ0KPiBhbWwNCj4gKysr
DQo+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvbWVkaWF0ZWsv
bWVkaWF0ZWssZ2FtbWEueQ0KPiBhbWwNCj4gQEAgLTI0LDYgKzI0LDcgQEAgcHJvcGVydGllczoN
Cj4gICAgICAgIC0gZW51bToNCj4gICAgICAgICAgICAtIG1lZGlhdGVrLG10ODE3My1kaXNwLWdh
bW1hDQo+ICAgICAgICAgICAgLSBtZWRpYXRlayxtdDgxODMtZGlzcC1nYW1tYQ0KPiArICAgICAg
ICAgIC0gbWVkaWF0ZWssbXQ4MTk1LWRpc3AtZ2FtbWENCj4gICAgICAgIC0gaXRlbXM6DQo+ICAg
ICAgICAgICAgLSBlbnVtOg0KPiAgICAgICAgICAgICAgICAtIG1lZGlhdGVrLG10Njc5NS1kaXNw
LWdhbW1hDQo=

