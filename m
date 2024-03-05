Return-Path: <linux-kernel+bounces-92403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9ED871FBC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 14:01:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E48C1C222F2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 13:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9F485931;
	Tue,  5 Mar 2024 13:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="uLF+udo+";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="t+ahMdEc"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8D25381E;
	Tue,  5 Mar 2024 13:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709643696; cv=fail; b=RXoQPBzQrVTMA242lyGZXllj0wrU8XHTTQPssFzah7pHfcaQOsBFrPMb0+NYQHKiKdRx25djaZgtZygFfiZi3no/U5d1X8FuSBLM8zzHwSVoTzmZBSs+w4atcV6LqRFRqzkwgGa9lf+V55gc/nen44Mn+cvQwQ1vKBzOk7/cN5I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709643696; c=relaxed/simple;
	bh=mp52M7NLovcmbXTEd2yPqvd2sC1LKWNnrqSsxS7DvjA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AlvI1eABKlRtCdqFRKAB+Iu2gzylZ4B0HDpATORhBAXY1x4FkF9qpR9Y2SbUMh/S6P7pZ1wXxIsqge4sJpcHbqjREYDJGmv5qwJKBo+N4/YOB3YuGMUG/52ER9Ze8gB/LHA9UV775M6/kXtEoVn61He7hSBqek+JLlSrlpEoRSM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=uLF+udo+; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=t+ahMdEc; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 7a3679ecdaf011eeb8927bc1f75efef4-20240305
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=mp52M7NLovcmbXTEd2yPqvd2sC1LKWNnrqSsxS7DvjA=;
	b=uLF+udo++jaLC+E9M20WYiDM9i1kb84SobZu4mQ22CYzhBT0aE93tI4bWo3A4QAubsmTBnDKU/khnS8TIM1/2bKPybhzR/ZhM+tIbJ9FLkv+4+fGf98GKgkzymtkfzV9aDVTsbD8KMgx5F3IOF/XrfPXFsfrgMf0AjvsIeXDY1s=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:c1ad0d50-63cd-42f3-b576-86c9fa5a6dd3,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:efe70a90-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 7a3679ecdaf011eeb8927bc1f75efef4-20240305
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <lena.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 545521436; Tue, 05 Mar 2024 21:01:27 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 5 Mar 2024 21:01:26 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 5 Mar 2024 21:01:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NyOCKYg+8szxFpnE8mrvDhH6kL9QehHjOLB7LzErCvRFjSiXBk67n4wy7iLojcEUmprsx32TLxGKA6I/9zKIN2AuAQOlOQTj+vOiOruhpUcphmP7XWGT0f2LxhHQdVS1B90X1WtsFUuCaNfCgGX6p1Un4zyM3ki0PfBZPDOeUz3RQpV878AHf1gJb8O2gmEadexIDW0lRbRE+9WFou+mZdlTbxSympXh8RqwuO9Lhw06h+pZprDL3QvuS22lvwjtcBo0SUgKrTglF2q/xOczSWu8Nq3HU0CIIdnjocgBBUR/qh9vtrbbk9P0UQhlFDGDhG7tm7ykirJe53K4S2FH8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mp52M7NLovcmbXTEd2yPqvd2sC1LKWNnrqSsxS7DvjA=;
 b=RqpaL2JAPI9S5k8XrIa2oGeSWLeLPH9voNy5vClslc6LdQ/kj71fneCp2HXxztCIOqVUn0kp/xDxkUSGNyKMsYNXBBqx7zoeUDo2Smkbsy2mbhtpz9GE2Dt4xIKlgB4wfY+BfCmrSMLkx6CuRaK+Zsr1UdQ2XjXtx0FSF/mm581NZH00UYbitN4wevIOXYBwoCScwtChWotghKVs0xXnbARTBMyCQqa7CLXO7gxi4tkFxZg8Sw4dzzFA7Ag+xX36jMUFoCXWm7yB8qEa/UNbDf5VFlc+QzzzTj1mOal50IpewEAT2rR+LlSC5QoV10jJeVBhvesyUaq+ZxdXb00h7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mp52M7NLovcmbXTEd2yPqvd2sC1LKWNnrqSsxS7DvjA=;
 b=t+ahMdEcNoxZWJU4OUWkQxGWyGgh75HDz9LOQDNMLp7nwa1jLLVxcf7Nd5XST6VpLSd/dFMIDko5LlsR9kG2NcyQ1wUIzRYPV/sU7Nx1SF2pxGFGtyf45K7mka+ydB4WWc2ipuBDwo9z2kin6ecOxL6dHVe72wdTawZCgS88xrU=
Received: from SEZPR03MB6466.apcprd03.prod.outlook.com (2603:1096:101:4a::8)
 by SG2PR03MB6431.apcprd03.prod.outlook.com (2603:1096:4:1c2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.37; Tue, 5 Mar
 2024 13:01:24 +0000
Received: from SEZPR03MB6466.apcprd03.prod.outlook.com
 ([fe80::3b7d:ad2c:b2cf:def7]) by SEZPR03MB6466.apcprd03.prod.outlook.com
 ([fe80::3b7d:ad2c:b2cf:def7%6]) with mapi id 15.20.7362.019; Tue, 5 Mar 2024
 13:01:24 +0000
From: =?utf-8?B?TGVuYSBXYW5nICjnjovlqJwp?= <Lena.Wang@mediatek.com>
To: "kuba@kernel.org" <kuba@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"dsahern@kernel.org" <dsahern@kernel.org>, "jiri@resnulli.us"
	<jiri@resnulli.us>, =?utf-8?B?U2hpbWluZyBDaGVuZyAo5oiQ6K+X5piOKQ==?=
	<Shiming.Cheng@mediatek.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "davem@davemloft.net" <davem@davemloft.net>
Subject: Re: [PATCH net v4] ipv6: fib6_rules: flush route cache when rule is
 changed
Thread-Topic: [PATCH net v4] ipv6: fib6_rules: flush route cache when rule is
 changed
Thread-Index: AQHaa+ZOlmtrqOmtQEu54Vg0yp9zebEomAOAgACG1wA=
Date: Tue, 5 Mar 2024 13:01:24 +0000
Message-ID: <d0621b969918ef41412b26d7e9a4918aaf4023d4.camel@mediatek.com>
References: <09f2ab1b7946339da5092e10aa216e07c579c60b.camel@mediatek.com>
	 <20240304204511.2026a56b@kernel.org>
In-Reply-To: <20240304204511.2026a56b@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB6466:EE_|SG2PR03MB6431:EE_
x-ms-office365-filtering-correlation-id: 6ce47d99-de97-4700-c01e-08dc3d145c84
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SNzjIZnisxcy3zlf0Pm3Y7yc3VQpg/BMPYPWFGcvQJXem9koTY/sZk88sGnpF65bQ4s7yAtFGS1dieS8o4RYWYPAmXJjPMUe1Gu1L8sJ4GdjvSy5/xYyt2jrW/xbftShQn2Ob3XLTeoK0CqEUx5EvKLud8sloITAnG34yFgGyLfQm7nRjXFmf3MB1xg/Kb8FEMYZXV/LK3kCPNmKdPRbzYR2w4VEo7BDAipGayVj//XomE0OetmBlfdk+2N2PZ+kzTa9tPldyGNuiI4l9Etp8gXjaSupT2ERwLWfT5iCnFdiVTHFvwikub8RBy7+hIUb5LP1O9hfxdMHX0X+D9SGvqmbgJnAeRX+3i+D35w2p8hVpTrdoM2ABkitVpFezZYWN6We4tpNUQ8mtmDeaYiLikVV7BVhp5leb721e8rfhw7IAbgVRXC8QcYvm5AkJkKbaALEkuUAo6y37kD4svtzxWYVpipkNOnfdN4zcWP0apKvjGsw4Pp6FQiwiASj7XZvN1weKbGyKs4ZDM6u/WggZB/FG3MhvEeK/0mpTTAI4iTZhrF9RbyAPVuYmE6YKZLz2H9BTVfbP8uzUEx0k3mY37KUhy3szkTwrFCyxfT0JSIFzlg0sy7IGEQeYawNjhO+XtaXhk2IjSGh9O0Enay+pokRgqchjL7dADk2EGEkvqJ1JgOSI3IFcBBsgd1TjEnIdUbSchkDK+3F4AawyGMmaC6eTXrTjofrIus1YhRS+tc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB6466.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?alF3aGl5dVp0VjkvUkFHMFdiS1Era0g5b0s4ZXRpQ1Nma2JFVFVhTzE3QXZJ?=
 =?utf-8?B?SVZMbkZCYWxpNktTaUhETnM2cTJMbnErZEtTUGxYdDdOMC9QS1NOd0g4aDI0?=
 =?utf-8?B?SjNJb1F3UDNUSGtNVGk5VHFON3BUTG1ONXY2UmN3YmJYSkI2MGVCL2pBNFNu?=
 =?utf-8?B?TzF5QTYwMDVwT0QxWWI4aTY3MTJ2S3hET3Vjb3RCT1dzVkg3cERkTnQyOHM0?=
 =?utf-8?B?aXdqdW5PNDU1ZS9sQUh4b3JWTDhOVE9EeExGdnM5SWZ5aXVDNU5LTklwY0Zo?=
 =?utf-8?B?LzJNR2k5ME4yODlyVTFvTUtEUi9VZFlOMVJLQTFlc2JXQXlvaGlUSXJWRkMy?=
 =?utf-8?B?V0FxWm9vaklIQ3owU2h5UHNSSlpvbG96VURGRmRwQVU0NkhQQlNTNEw0aHdw?=
 =?utf-8?B?L3NqcXkrdzBudGtNT0xCVkxBUEJpd0NETk9OL24wWFVBL3JJaFdnbTNJTDVE?=
 =?utf-8?B?bmNsaXN2bjM2R0ZJQ1V6SFFhN0ZNSGJpRXVxbDNTUkp5d2gwYVpjMUxycHdP?=
 =?utf-8?B?dldTWWdNcEsvS0NEMkpHWmhxNENyUEhFZDhEbnkxdHlXUm5NTWV1cE4zQ0lW?=
 =?utf-8?B?MmZIbUdmQ2szbnNGczk5aTBqb1laQ242QnU2MDJCbFora2E0VW9SOUtubUd1?=
 =?utf-8?B?UU1xYVVGZ2ttQXdhY2UyK1grdzB3bDlrdlBrMURvdk91cWpmckdzNWIramE0?=
 =?utf-8?B?ZnlrZTNrTlNJZlk1Vm4yTFA3L1QxOGw3M0s1Rk1NTUtFWVY1S2JTWWY0ZDRB?=
 =?utf-8?B?UFBkTGpyWlptdFhCYnpvem5DRnkreGprN3h2Kzd6djF0bndKVXdvUVc1bjc4?=
 =?utf-8?B?MVl3UVNtZHJ4RXQvZVVNMWs3ZlNBWEtlYkZ3L2U4SFBKS0JyaXVic0pnS1FV?=
 =?utf-8?B?alNvQldwWDVwN29EMEhPKzVXR3NDcUZ4T0lYZW41S2NFNGF6QVd1UVhobERq?=
 =?utf-8?B?alZiRVBSODBXcDhTLzkzTy9obGp0dnBGWDRBQXg3ZVFZbTdIVy9GZmQyYllq?=
 =?utf-8?B?bTU5VU9uNXFpZzgycjBaS1RPWGFXK1FkeXYvRUNzVzRHa1g0L21zKzMwRUR1?=
 =?utf-8?B?WFp5OE01czcwNkhBTmM0bVpyZlJFZDFMMW1NU1J6WStLWGswTHZmNWFTbUxN?=
 =?utf-8?B?ZnVrbTlGVDFZTXRPUDQwc3dlTkhiVG5rdjIzdklWZjRMQU9TWG5IV3UzTzRo?=
 =?utf-8?B?bWVCVG9Xdm5IeTNpdStlampPU3BCVEs3Qk1xekJacHpocEkva1EzMVFGT25o?=
 =?utf-8?B?dU1zTmFTUjEyNUJ6a0U1c0JVV01tb0Uwdnc5Und2RU4wbHZtK1Ryc21NdGRX?=
 =?utf-8?B?aGRNV2I1dkhuOTVpWWw2bkhFUkpvL2VZNTIwRUdVTklWM1drQ2JIZ3VYNDZU?=
 =?utf-8?B?SjRXQ2hWQU04Z0ZROCtyUmNPOUpuMWE1SFZkak1DOWhWVjhQY0p3dldNWkFl?=
 =?utf-8?B?bHR2Z3oyTWM1eGZMZVowcHR3VUZ6QlhDTFVwZEZ6NG5vcjFveEVuVVpRQXBz?=
 =?utf-8?B?VFpneG5UL0NVNUhjeGZpenBmeDJSRHJ2NElZU081UmhIUGxOcEx6QllWYlZZ?=
 =?utf-8?B?K285eWJ4QjF5amdjYUJYRkQ0Ulg0Q3ExREczWnJTOE5sUW5JakxiZ3pDaXVa?=
 =?utf-8?B?ZzBYTXR3c3RQUlc1VkR5QkJDVWl5bHoxTjFjYXRQSE1RejhSZlpDemFVU3pw?=
 =?utf-8?B?SG5pVmxXcW8wVHBpM3Yza3BJSDhxUy9JL2lLQmpmZklva09SckR0Q0pLdUk4?=
 =?utf-8?B?SWNKSkdqUmYyWGVFL0VBbHltOTZWcTdTbmFaZDJFaWpqcDZ1SHRBbW41V2NJ?=
 =?utf-8?B?RDdxUXR6VFYvMU9vZmpMdThwTUhWSXBuYTJnRXd3cE1SNmNIbHlBMVFWKzJG?=
 =?utf-8?B?MEJqeUIvMEl1SnEyRFlxYmdUa05UeENKZ2MyK1VzQ1VSa2ZTUUJuTEtoZmE3?=
 =?utf-8?B?ZGxKaCtDT0ZleGZSMzBDL2d3akxlbGxueUh6VUVCYjhzY1NSeThrV0ZPcUZB?=
 =?utf-8?B?QXZSUnhhb0o2TTkrOUpjblFHaEZrOXpiTlNPNzJ0VXdHbkxzSFF0MHorMHVU?=
 =?utf-8?B?dEdVSzVhaGMvUGYwMURuWHJ5SnlwRWxKQi96VVRHRVhReEdxa2QrY09UVTI4?=
 =?utf-8?B?TEhlVkV0VUh2SEdNb3V4U3pTOTdZdkdwcU1xR205ditldzlxNUd0Q05kcXdu?=
 =?utf-8?B?ZkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5FE85BB62A7543428BCF507E62007FB0@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB6466.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ce47d99-de97-4700-c01e-08dc3d145c84
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2024 13:01:24.0239
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4pkTU2nC+mUm3wFkfjkwf89z8HBuGrpgifZEDRzXb+dLiLKPNR2AMMr0WkLKAVd+GD3jv2mzwzqy9fOgsk9LtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR03MB6431

T24gTW9uLCAyMDI0LTAzLTA0IGF0IDIwOjQ1IC0wODAwLCBKYWt1YiBLaWNpbnNraSB3cm90ZToN
Cj4gIAkgDQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBv
cGVuIGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3Ig
dGhlIGNvbnRlbnQuDQo+ICBPbiBGcmksIDEgTWFyIDIwMjQgMTQ6Mzk6NDYgKzAwMDAgTGVuYSBX
YW5nICjnjovlqJwpIHdyb3RlOg0KPiA+IEZyb206IFNoaW1pbmcgQ2hlbmcgPHNoaW1pbmcuY2hl
bmdAbWVkaWF0ZWsuY29tPg0KPiA+IA0KPiA+IFdoZW4gcnVsZSBwb2xpY3kgaXMgY2hhbmdlZCwg
aXB2NiBzb2NrZXQgY2FjaGUgaXMgbm90IHJlZnJlc2hlZC4NCj4gPiBUaGUgc29jaydzIHNrYiBz
dGlsbCB1c2VzIGEgb3V0ZGF0ZWQgcm91dGUgY2FjaGUgYW5kIHdhcyBzZW50IHRvDQo+ID4gYSB3
cm9uZyBpbnRlcmZhY2UuDQo+ID4gDQo+ID4gVG8gYXZvaWQgdGhpcyBlcnJvciB3ZSBzaG91bGQg
dXBkYXRlIGZpYiBub2RlJ3MgdmVyc2lvbiB3aGVuDQo+ID4gcnVsZSBpcyBjaGFuZ2VkLiBUaGVu
IHNrYidzIHJvdXRlIHdpbGwgYmUgcmVyb3V0ZSBjaGVja2VkIGFzDQo+ID4gcm91dGUgY2FjaGUg
dmVyc2lvbiBpcyBhbHJlYWR5IGRpZmZlcmVudCB3aXRoIGZpYiBub2RlIHZlcnNpb24uDQo+ID4g
VGhlIHJvdXRlIGNhY2hlIGlzIHJlZnJlc2hlZCB0byBtYXRjaCB0aGUgbGF0ZXN0IHJ1bGUuDQo+
IA0KPiBEb2Vzbid0IGFwcGx5LCBwbGVhc2UgcmViYXNlIG9uIHRvcCBvZiBsYXRlc3QgbmV0L21h
aW4uDQpIaSBKYWt1YiwNCkkgdXNlIG1hc3RlciBicmFuY2ggdG8gbWFrZSB0aGlzIHBhdGNoLiBB
bmQgaXQgc2VlbXMgc2FtZSB3aXRoDQptYWluIGJyYW5jaCBvZiBrZXJuZWwvZ2l0L25ldGRldi9u
ZXQuZ2l0Lg0KDQpDb3VsZCB5b3UgdGVsbCBtZSB3aGljaCBicmFuY2ggc2hvdWxkIGJlIHVzZWQ/
DQoNClRoYW5rcw0KTGVuYQ0K

