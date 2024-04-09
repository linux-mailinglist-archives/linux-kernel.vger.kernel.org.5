Return-Path: <linux-kernel+bounces-136790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B461F89D82E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68C14287B5A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 11:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95CA3129E86;
	Tue,  9 Apr 2024 11:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b="kGF2QAJT"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2113.outbound.protection.outlook.com [40.107.94.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9E981AA5;
	Tue,  9 Apr 2024 11:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712662545; cv=fail; b=NMLo5UOIv5EDVvJKzSxPY2h//ooHP/YkHGivp0lpZyHV6Fw5/oh0oKjZ5E7jvs05tzuhYQevREW8zq0KoIGOo+WidQ8Zxh++vdaRzlpGhsh3qF4oI9/lgYxiFNbqs8jRnsSkCWs5OMzFjQM/8aui/0fbBJ3USvUbXfrjiEmupLo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712662545; c=relaxed/simple;
	bh=lEVAnW3ZUu0bLR3ljtAYU5vCsGtmAfErLIOuOOEjtDM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VEj8pDCcMXH3DCOQaD+v4ORFI8+1erOGStPCF10MT9sNgDCNMFjFhy6oVdfWFqCeze7rKw8xrvVJWxkpJAQCuEbA2G1LweVRcTYkSjrsHu2rjHjHv36I/bb2vWrNizwjnwb9At1zKxl3yxZW8C6xUNDDArCnOTl8T6RRMOo78A0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com; spf=pass smtp.mailfrom=corigine.com; dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b=kGF2QAJT; arc=fail smtp.client-ip=40.107.94.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=corigine.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bzSD7yfT0lQagykT03N3TB+Tx8wKsi/omJLjuMODJmfd8oc6JLs60nlLvoR1BWXjaIqHeWrY+rfFkaOaoTayajwqTQLo0NRJjl16nDs5Tnq5SwggJe8F86RB8iFsOwESbFOI14SQuuvHR0aD93PzgawOCDiGCGvtVFM61INhBpOmHptLYgYTOeT+RQCO/xRNz0qUgnU+Q8JC2D36eZ4yDlcU5ZbZCDmYuZ0wm9EK0kFljCoOwTfSkEVhuJbvEU+Uax54ppEdrSL2aMU8FVVz/QQgqVyTYcqr3pgLh9VtA1QkEda4Hp31YwQKkEZT7xHezxeat333XcsCuOZ7M9o8bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lEVAnW3ZUu0bLR3ljtAYU5vCsGtmAfErLIOuOOEjtDM=;
 b=ii/1cjgtQePFavAdJo5KHrPu5tJR43NQ0l8SshR0Nk31z/kXnzNQlfvKARnPwHs4EZJf/cfuaMtAzeJYBOci/b5wT6ZzpuWFpvbjSZDqEU12pD9IPzeYp4S0N0qnZDyITxW1bb5H0vHI2miLTyRxnXjyFtjmjuzZIixrmtBG78W/9UmCcVRnUx6MQ8VuWTO1oJ8nDI4ixG9umbQQLlFVrjUJPiRZ809MDQpOrFs6I74WYt2UFIwjLsQpsH5gsKbOHwWxMrNPwSULtOwbloPDhmBtXQ/4QcVdbnkY06OugF1HmuEOpUoZeyEoeucrpbR0shMc0R7YYtQcx0blWtqbFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lEVAnW3ZUu0bLR3ljtAYU5vCsGtmAfErLIOuOOEjtDM=;
 b=kGF2QAJTE1EZ1qWfHPun9Agq0LXc13BILIIhTw+6MpgXvuRbVMZOGJq7KOGXFOpAQscL5LLRv2fnD8ndFVsNMAlgXzvWhWMozoh3MCt2jqAw16UrP8gxJ77kYP0lXgXZtORcMjuJLctBw8t/M4yBLAH3kq9+bQJeZvoICVushNk=
Received: from DM4PR13MB5882.namprd13.prod.outlook.com (2603:10b6:8:4d::13) by
 BY3PR13MB4883.namprd13.prod.outlook.com (2603:10b6:a03:357::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.55; Tue, 9 Apr 2024 11:35:40 +0000
Received: from DM4PR13MB5882.namprd13.prod.outlook.com
 ([fe80::5e89:b434:88dd:50a]) by DM4PR13MB5882.namprd13.prod.outlook.com
 ([fe80::5e89:b434:88dd:50a%3]) with mapi id 15.20.7409.042; Tue, 9 Apr 2024
 11:35:38 +0000
From: Baowen Zheng <baowen.zheng@corigine.com>
To: =?utf-8?B?QXNiasO4cm4gU2xvdGggVMO4bm5lc2Vu?= <ast@fiberby.net>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Louis Peens
	<louis.peens@corigine.com>, Taras Chornyi <taras.chornyi@plvision.eu>,
	Woojung Huh <woojung.huh@microchip.com>, "UNGLinuxDriver@microchip.com"
	<UNGLinuxDriver@microchip.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Yanguo Li
	<yanguo.li@nephogine.com>, oss-drivers <oss-drivers@corigine.com>, Andrew
 Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Vladimir
 Oltean <olteanv@gmail.com>, Edward Cree <ecree.xilinx@gmail.com>, Jamal Hadi
 Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko
	<jiri@resnulli.us>
Subject: RE: [PATCH net-next 3/6] flow_offload: add
 flow_rule_no_control_flags()
Thread-Topic: [PATCH net-next 3/6] flow_offload: add
 flow_rule_no_control_flags()
Thread-Index: AQHaibYqUkANcoVW1USfxXSIZ4S0d7FfMjAAgACdQICAAADEEA==
Date: Tue, 9 Apr 2024 11:35:38 +0000
Message-ID:
 <DM4PR13MB5882EFAFDD6ADBEEB19B1BA4E7072@DM4PR13MB5882.namprd13.prod.outlook.com>
References: <20240408130927.78594-1-ast@fiberby.net>
 <20240408130927.78594-4-ast@fiberby.net>
 <DM4PR13MB5882C0B494203376530F33E6E7072@DM4PR13MB5882.namprd13.prod.outlook.com>
 <bfb88a63-c3be-4d05-9868-877570e9eea5@fiberby.net>
In-Reply-To: <bfb88a63-c3be-4d05-9868-877570e9eea5@fiberby.net>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR13MB5882:EE_|BY3PR13MB4883:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 /R8W2CA7/OmULumMz5eb2+fWaZkLfuXY2R5d/jCMSM6+QM3uPKxMbF9y1UI3J1iJeQ+1UlNKmoF7KYh30ARmKB7ooy64XUil4j0V0HB9xlZpVClPwe+bbPXX1UUFMmc4haNMKqXC4wD4GvBO+v/Goau8RqqXlCQ3v1m8Dos4LEJAA6M7/BkXTwc0aJcY44tbfTc9sjFZhswgW+LrzTOPUqvdhUMOgjvRHMwb0A+b2y+Exr4rvIrTu7hzGiqLt55ze29dt5QvwJmSZn/dn/fRcvPp2EDJAkQZEpZC1Zxd87MA+Izzrycxm8zZV3IEJIF3hQFFMOJoqonBOH+I1m3cSFxiw2/2url0SEDIJxXqpvw5NPm/OhTdRUO79lWoR1h/La48j3beXL+rnlwthPDddCBhq0E6QGqQ4tTswCIJKc4cusmUIUh6kXxNzDvnBr5tVYjlsSLdJHys3KvtHowt4G+34pp3HEvurnrr6Dua93j8EiAC2lyQmZfb8kjJQrZ89UvWa3uo36tS6jFzxdFFrWs+C9DzxpzJTTKvTO1rhfJriyqKRip19MdhC/INnOVtrKq83JwJcf1SsYI7/ORW8gRDHJNpfBPXtn3StEdw1pSsR2dhlKK6nfYXU8o3u/PoqoI6v4Cw5TpcyXj7d6TqaCg5mTL3SW7dWYXMYJ7Ib+c=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR13MB5882.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MlBROWljOWJlTW1qOHpZWlBBM25na3dZVEhSMVE4ZmxwNXF3UFNPM0dCdUFl?=
 =?utf-8?B?M2dLemMvU1RFRGNsVVFFcnY5aG02Yk43T2dOeXduODc0aUl1cG1iSTlyMzFO?=
 =?utf-8?B?elBuSE4vTE9YUTV1YkFDOERacTZodG1MMGpyQ1BFeFRKaEdyM1ViRzBRM2xZ?=
 =?utf-8?B?TnJ0S2RuSnU3cy9zbmU3c2dmU2ZWMFhiUFprT2lyRFJKSFhSVlBoQkwvREt3?=
 =?utf-8?B?Z0MyNUdzWTBKNU9HN0crMStuM3pFZ0pHMWtqdnB0U1U1d0lLdVZtVkRRb2to?=
 =?utf-8?B?Y05xbmovYW1kZWNuaGNKZkF2TlBtNnl6MGszTCtpS0g5Y0YySTJhT1ByTjVq?=
 =?utf-8?B?RzZuUjBneFZYb1dhc3cxbHNCTkFTWnBBNjNUYXZRMVNRa2M3bjRJeFo5b3F1?=
 =?utf-8?B?a3ZDTUhlam9SRmtTSTdheVpnVTc1YW5qcTRiaGlJRmZHQXlhb0ZCZnc5OVNa?=
 =?utf-8?B?QVlmb29OMU9SRVNmTWFXK1BlUnpKNk5IZkxmQ2NZUHl4WjlNbk4zQVFHN0ZU?=
 =?utf-8?B?Sjc1RWtZZWdCWHRsQVd4d2JVK1o5b0QxL3VsMFBGSlgwSTBoVTkramhmN0NE?=
 =?utf-8?B?NEg1dmNYckhodWtKT0w1MXhONDEvMWt3eDVnNkZRNnBxRDhyRHltTFhLQ0s2?=
 =?utf-8?B?cGZ2TUttVFdUcXBIdlliMklQTTZGMVBwdmQyMm1QZVlpT3pkR3V0VCt2QzFl?=
 =?utf-8?B?a0VqRktka0RRMXpvbTRIWkpMckk1Tmw5U2dnSmhqM0M5dVVCdzZZc1hzRzUr?=
 =?utf-8?B?UTR3anBnU1BQTHJ5V0ZjbEROZVkrNGZPWWZaOHJ5V2VMMW5IajhHbC9kam9V?=
 =?utf-8?B?VHJUNHg4V05rT0RQR0VJVVUvRElGd2dLVkNpSEY2RTlCRCtKUU5jNkZLMEpp?=
 =?utf-8?B?WEQyTTVYMHBGV2ZkbllSdXp1SEgxbjd2aExNQXVRbmJVNkx1SE1qMXkxdDNQ?=
 =?utf-8?B?YUF3d24xWlJYN0xXYXM1R1hDMGhQVERkektTV3lDYkhwN0NPbEtqUFduNHBH?=
 =?utf-8?B?czlSZ044cUZkYi9Da0hCTVpncGw0UytzMFdxY1ZqVzBIMDJ5bzRvSC9McjJN?=
 =?utf-8?B?SzhaejZYb0RkcjJUMnJSdGhDb1A2Z284Y1lYZjZLQWpEWnkxbE5HQWZMbUll?=
 =?utf-8?B?cUEzRHRGODlodGZvbWtvSUdYS2VPOFV3MkFJcDdIMHBwNEo4dGM4aVl5ajFO?=
 =?utf-8?B?TTIwcGhwaGVwV0lPUXo0cVdIL05NM3VvcEhGbXJtT01rTWloc0JWblpLWjdD?=
 =?utf-8?B?bXJ2WUJJMXJzajlOSVQyQ2dFdlFSMnZqSE5tUTFkMFdDV3lOMFdwcnJRbTRz?=
 =?utf-8?B?ZnlxUm13S0JDZHZrY2NKcnVMWUtkU2FlSUhQL2pYM09EWStxTm9laHFDRUZH?=
 =?utf-8?B?TytaS3hBM0V1cmtRV2lnaVlBOVJyL0EzR3dHNTY0YkZaYmsxVklMcDZzcmI5?=
 =?utf-8?B?c1djWUpwa3JUNWd2elM3YkpONDd4dU52bjJzZitFeEJoR25DTiswNDBSVm5z?=
 =?utf-8?B?bWV5SmRzSC95QzRmRTlrUjd1aE8wQ0VSL2ZOaFR2b3AwSXFyU1Z1bUdoYUtE?=
 =?utf-8?B?QzJ6SUJLVk9BZlRXdGxpQ3NhbkQvL3BPdWpYa1hXOHBVc3pOaTlLZm1HZ0pG?=
 =?utf-8?B?b3RyenkyZG93TnZ1QXhxMTRSTTIzbmVGQmpJNklnb09TRTNsbmt6dGxGUkZX?=
 =?utf-8?B?SEJDMkNMV0owKzhWRE9ObVJBeHNtOHlVUHdqL1A5a3dSNDZXNWdQbGcvT3Jy?=
 =?utf-8?B?TnZSUndEZUtSRDR2WG1PaVlSWit5UjNrRE0rcTBxc3lIbkJLM0R6bWxRL291?=
 =?utf-8?B?U0RUazRrYnJycVdlTGo5YzJUdmV2VlR5TnZPRU9uK01jOTFvTUJvS0ZMbGxP?=
 =?utf-8?B?cUY0TzhkNzZYWDFETjFsZGtiK0FqQXpmUklKVmxMb1pBd3c2WGxFaDhENEV5?=
 =?utf-8?B?WjZNODU3aU1QTWZWZ1pHTUIrSFdieC9HelVVQlhXOW0waW9vaTNBYnUzOHlh?=
 =?utf-8?B?a1JHUzlsZ0NiVEpDUmNBMDdxMkZMQ2hTZjNVU2gweW16eS9NeG9DSHQzZktZ?=
 =?utf-8?B?Tkg2YldWRExMcjRCT1d5aTNWYUFDeFd2UmR4ckttVmtWay9mZTJlSFRPZGs0?=
 =?utf-8?Q?b/KojGkqolJqFFO/B/3YvdGIA?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR13MB5882.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fe93d4e-4f65-45c5-c780-08dc58892de9
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2024 11:35:38.3406
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PISasCe8TIAehCh86EajlkZuU5VJRRLl3QomQw/623Pjbv7t58BizeIuGYSSQHxBF1x7mAtAVpN6mAKM+9AQchUcnL9IJw7sV+8c3N6Xbvg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR13MB4883

Pj4gT24gQXByaWwgOCwgMjAyNCA5OjA5IFBNLCBBc2Jqw7hybiB3cm90ZToNCj4+DQo+Pj4gVGhp
cyBoZWxwZXIgY2FuIGJlIHVzZWQgYnkgZHJpdmVycywgdGhhdCBkb2Vzbid0IHN1cHBvcnQgYW55
IGNvbnRyb2wNCj4+PiBmbGFncywgdG8gcmVqZWN0IGFueSBhdHRlbXB0IHRvIGluc3RhbGwgcnVs
ZXMgd2l0aCBjb250cm9sIGZsYWdzLg0KPj4+DQo+Pj4gVGhpcyBpcyBhaW1lZCBhdCBkcml2ZXJz
LCB3aGljaCB1c2VzIGZsb3dfcnVsZV9tYXRjaF9jb250cm9sKCksIGJ1dA0KPj4+IGRvZXNuJ3Qg
aW1wbGVtZW50IGFueSBjb250cm9sIGZsYWdzLg0KPj4+DQo+Pj4gT25seSBjb21waWxlLXRlc3Rl
ZC4NCj4+Pg0KPj4+IFNpZ25lZC1vZmYtYnk6IEFzYmrDuHJuIFNsb3RoIFTDuG5uZXNlbiA8YXN0
QGZpYmVyYnkubmV0Pg0KPj4+IC0tLQ0KPj4+IGluY2x1ZGUvbmV0L2Zsb3dfb2ZmbG9hZC5oIHwg
MTMgKysrKysrKysrKysrKw0KPj4+IDEgZmlsZSBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspDQo+
Pj4NCj4+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9uZXQvZmxvd19vZmZsb2FkLmggYi9pbmNsdWRl
L25ldC9mbG93X29mZmxvYWQuaA0KPj4+IGluZGV4IGMxMzE3YjE0ZGEwOGMuLjQxNWQyMjUyMDRh
MWYgMTAwNjQ0DQo+Pj4gLS0tIGEvaW5jbHVkZS9uZXQvZmxvd19vZmZsb2FkLmgNCj4+PiArKysg
Yi9pbmNsdWRlL25ldC9mbG93X29mZmxvYWQuaA0KPj4+IEBAIC00NzEsNiArNDcxLDE5IEBAIHN0
YXRpYyBpbmxpbmUgYm9vbA0KPj4+IGZsb3dfcnVsZV9ub191bnN1cHBfY29udHJvbF9mbGFncyhj
b25zdCB1MzIgc3VwcF9mbGFncywNCj4+PiAJcmV0dXJuIGZhbHNlOw0KPj4+IH0NCj4+Pg0KPj4+
ICsvKioNCj4+PiArICogZmxvd19ydWxlX25vX2NvbnRyb2xfZmxhZ3MoKSAtIGNoZWNrIGZvciBw
cmVzZW5jZSBvZiBhbnkgY29udHJvbA0KPj4+ICtmbGFncw0KPj4+ICsgKiBAZmxhZ3M6IGZsYWdz
IHByZXNlbnQgaW4gcnVsZQ0KPj4+ICsgKiBAZXh0YWNrOiBUaGUgbmV0bGluayBleHRlbmRlZCBB
Q0sgZm9yIHJlcG9ydGluZyBlcnJvcnMuDQo+Pj4gKyAqDQo+Pj4gKyAqIFJldHVybnMgdHJ1ZSBp
ZiBubyBjb250cm9sIGZsYWdzIGFyZSBzZXQsIGZhbHNlIG90aGVyd2lzZS4NCj4+PiArICovDQo+
Pj4gK3N0YXRpYyBpbmxpbmUgYm9vbCBmbG93X3J1bGVfbm9fY29udHJvbF9mbGFncyhjb25zdCB1
MzIgZmxhZ3MsDQo+Pj4gKwkJCQkJICAgICAgc3RydWN0IG5ldGxpbmtfZXh0X2FjayAqZXh0YWNr
KSB7DQo+Pj4gKwlyZXR1cm4gZmxvd19ydWxlX25vX3Vuc3VwcF9jb250cm9sX2ZsYWdzKDAsIGZs
YWdzLCBleHRhY2spOyB9DQo+Pj4gKw0KPj4gSG93IGFib3V0IHRvIHNxdWFzaCB0aGlzIGNoYW5n
ZSB3aXRoIHNlcmllcyBJIHBhdGNoIHNpbmNlIHRoZXkgaGF2ZSBzaW1pbGFyDQo+ZnVuY3Rpb25z
IGZvciBkcml2ZXIgdG8gdXNlLg0KPg0KPkRvIHlvdSBoYXZlIGEgbGluayB0byB0aGUgc2VyaWVz
LCBjb3VsZG4ndCBmaW5kIGl0IG9uIHRoZSBuZXRkZXYgbGlzdC4NClNvcnJ5IGZvciBjb25mdXNp
bmcgeW91LiBJIG1lYW4gaWYgeW91IGNhbiBzcXVhc2ggdGhpcyBjaGFuZ2Ugd2l0aCB5b3VyIGZp
cnN0IHBhdGNoIHdoaWNoIGludHJvZHVjZSB0aGUgZnVuY3Rpb24gb2YgZmxvd19ydWxlX25vX3Vu
c3VwcF9jb250cm9sX2ZsYWdzLg0KPg0KPi0tDQo+QmVzdCByZWdhcmRzDQo+QXNiasO4cm4gU2xv
dGggVMO4bm5lc2VuDQo+TmV0d29yayBFbmdpbmVlcg0KPkZpYmVyYnkgLSBBUzQyNTQxDQo=

