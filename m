Return-Path: <linux-kernel+bounces-107127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF3887F7D5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 07:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2AE428241B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 06:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A3150A93;
	Tue, 19 Mar 2024 06:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=Analogixsemi.onmicrosoft.com header.i=@Analogixsemi.onmicrosoft.com header.b="F8sF5G+f"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2126.outbound.protection.outlook.com [40.107.220.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7F14438A;
	Tue, 19 Mar 2024 06:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710831448; cv=fail; b=py1hAExdDQuRuOYhXLOwAEaytnG7tPwmbqLgxSnlXu34I1Lk9jhol72d09UIhMcyaIf6T4sFlyuvmuw75+9q5UbfpbQgOGMnRg8dohMSuz39ShD7dFvx/93wQRfYqaw1zM3mQ4unhYAShK9kGnJ7t/09/QRuKAyZjX/5/0XB+08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710831448; c=relaxed/simple;
	bh=YVpCYpw9t0YYGc+VFBWHD/rval8847H8gPJEUi5RyNo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GlsZR6+AQdSjsK7tbg2WBcU+VbeKOco77+eKP0Gn2T2VVHycgKmPo/YbByRihV3CKmGBaWQLpkSvjFxpPkWA9QjaQXfeg6QvbFstUP415t6lbpGExNeUP0grfECRHGLiOJGwngzBtic70XOo7fW8wz/8M4xUCRk7mG6L8Z14RVE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analogixsemi.com; spf=pass smtp.mailfrom=analogixsemi.com; dkim=pass (1024-bit key) header.d=Analogixsemi.onmicrosoft.com header.i=@Analogixsemi.onmicrosoft.com header.b=F8sF5G+f; arc=fail smtp.client-ip=40.107.220.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analogixsemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analogixsemi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qz8RM4YWi9uqj3rgJCZOQxTUCHpO3Neukf7mR6TtsO38NYZPTEkCW67UsW8M9yunLLCAGuHZDf3J61xggH2eBaIYjJqbYOHFVhnpoa8EmQZcipm+7m/wOFqfx56yaN9iaCJ83eKin8E8UCjVWrssP2SmAluTLKLOH8KPY4yaBhLkAyG8AFT0azs077QHZI/glEMLca6nMGvFq+nRbyXBuUi0+5lxZGR24goeXJ03yv/KO+9r78zTDmmcTInSDxD3LsRQh6g7Vn1z+6E9sFM+w5PYFg4EQ9CpfPO+nOR2qsY6F6dGGnDqtqUqmIBk24VW4aJZY3TGctDhKDehIz5r1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YVpCYpw9t0YYGc+VFBWHD/rval8847H8gPJEUi5RyNo=;
 b=W06r0OGPrK5tvkYJbSlwvnr6zlulrBii6ve+0++j4PCj2HikhICZCbUWHXP+6jowL3MdJZ+4rbyUkxr0GeF41TrD5oKg9QpqVl1MinoKFddZC6sLRZe66cv4GmhLTEvo/95x+8JYAsL2a1uiS3hDjBadYgVs0dfvwvcnQnxpcPetuzTqGPmDK+4ReQZ82j2hZRSi5IxRYx/NGOUa6/Wa+iCRfy/DsFVR3Am1+t9MTzOb+qtPjEl3r76gvLZ/bU1nHGRaAk05Ta8CMqsSEXBSS9XE0M2X/DVrVtvVgfmBtOhTOWX2hQfPTrTHFiKFgY3s/VKcl4ocsO86EybNZ3jDBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analogixsemi.com; dmarc=pass action=none
 header.from=analogixsemi.com; dkim=pass header.d=analogixsemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Analogixsemi.onmicrosoft.com; s=selector2-Analogixsemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YVpCYpw9t0YYGc+VFBWHD/rval8847H8gPJEUi5RyNo=;
 b=F8sF5G+fLcXI5GRxsJjUHmBxE/DhzE/xyAfyDXF1R3wvqRUpNuJyopUdqPl7q85nvpnPV9SqJ50AXLmj4m8zcTULkw1x8SER4VmWiBa04S+TNSb/dHrz5sXrPEK9pgjuiGeAN+Yso9g9ri5evDRfQT3R9citXsQiITaCgRAaXr8=
Received: from BY5PR04MB6739.namprd04.prod.outlook.com (2603:10b6:a03:229::8)
 by MN2PR04MB7023.namprd04.prod.outlook.com (2603:10b6:208:1e0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.28; Tue, 19 Mar
 2024 06:57:23 +0000
Received: from BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::f5c8:cfbd:fe41:f360]) by BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::f5c8:cfbd:fe41:f360%6]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 06:57:22 +0000
From: Xin Ji <xji@analogixsemi.com>
To: Grigory Bazilevich <bazilevich@sicamp.ru>, Heikki Krogerus
	<heikki.krogerus@linux.intel.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
CC: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Subject: RE: [PATCH] usb: typec: anx7411: Fix possible buffer overflow in
 anx7411_send_msg()
Thread-Topic: [PATCH] usb: typec: anx7411: Fix possible buffer overflow in
 anx7411_send_msg()
Thread-Index: AQHad+Fa+Dq+93EUhk6T5ohswC5w4LE+o0Jw
Date: Tue, 19 Mar 2024 06:57:22 +0000
Message-ID:
 <BY5PR04MB673917E3D0076B4DADDFC8A5C72C2@BY5PR04MB6739.namprd04.prod.outlook.com>
References: <20240316203354.81591-1-bazilevich@sicamp.ru>
In-Reply-To: <20240316203354.81591-1-bazilevich@sicamp.ru>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR04MB6739:EE_|MN2PR04MB7023:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 pB5TXTSiQxqLinC9IkekPIA4lxRsU032AG4XXF6AWhF5QXFXe292uP4EKOZUAxQPj6LyMQEEdgwQJr+P7+A+kJ5C2HOKrbMZxcb8+f2BkUyLqy20mHQbmtNMkCnuwS0bKRlveS4YM+UsTMAuyyovjbBLqzvDlQWpYx2CdQFJEyUPb1nOeGhc1yhmdhcKWCyjXyNsc+cJVCNtAs+8q1YNy48hUMtL3NY7Jb9Hb42Pub6muxZdUMUiagUhUtbE4uDS11L9026PUXAZnN1/43EPDeEb0mP/G5F7pIgkuaDMdVn8GOpvL9ITWTWyBfs8Ve3N5gDMe/vv5yDXPS8EzKHMeCxLcAv4ZjheuZmS18zRgmPdvx4QulUZb1JcR5O+WBeUAvgek+Rrt05j5LS43XunuqZwC1I/pVRWIbAQU5IIppBWxjvfmT9srGi0jHelFtJweELd5uahzqUidvhz9q4JFKdNS6VHTtY5t4dcGNK0ErAEnLmujLGikmz6ACW3HEtAo11kF6FIQEWNsmH5/BkjKlCnZmv5+WGo4aoezld4JdzKzJK27CpfrFs+N8Mo2nVEfN9ew6W6vaS+8mPq202oQdyQvtGXOduTUVYChg3/1X58hYhENyQQzAqIe/+DmJAN34HOx7gMrZfNmb3rU4PNov/ft6zSt5a0tYaSmLOWVU0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6739.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZE8vcjVIU3l6dGpyV040K3UxZmRLdTFRdm9lb012WmYxaC84YkVCMFBSOEZa?=
 =?utf-8?B?Z0JBeUZTVTFxSG1RK3dvZlVTclVFc0t0c09DemdndFhwWFpWamp6UDFBYita?=
 =?utf-8?B?ZHNUQnBHSWtrTmVTdWNBRTZSNjljZWJvaWVwUHVSNjU2M3ozNlNDOVJWMEJm?=
 =?utf-8?B?R05tZHpXN2lFMTI0d1hvdXBIcHFXcnhaR3NuNFBIdGxoZkd0bHhBMTgyODZG?=
 =?utf-8?B?ZVVta0RRbU15ZFRIS255MFhHMjRoclJ1NTJFN2puazI5azhaTllLWXc3VWNk?=
 =?utf-8?B?Z3hiODBjUFFGRkxKRVZHb2hlWWdUMFg2alNlQ0tLZ3NGZ21lYVhrU0ZHamo4?=
 =?utf-8?B?aDNYTWkrbi96Z3Q4R0VabndEaTExTDlxQnI3WHlKNWJwNmxTbnQ1Z2FPWk9m?=
 =?utf-8?B?dC9BZnZEVWRxR2EyLzNhVkJzZnJzSThMM1Ruc0NGY3NtSDRTSngrcWM0OUU4?=
 =?utf-8?B?NWZ4SHhoYmpMRVpmZktrdFFhQ0JJQW40R2ZwZDdra2tEMXlmd2dYN280N3FG?=
 =?utf-8?B?NXhFQVZCbzBhYTh5ZU4rVFFuS1o0dmRUckVHaWp6TEl4YnU4UnRRMkxZZHVL?=
 =?utf-8?B?RHdsRnUwalV1Q2hJNG1uT0kxZzdYUmhRd2JpU2ZDdTRTK2I1RWlTMjZLSUVi?=
 =?utf-8?B?VEh4VTBtWkloSWFCZlV0VzZFUWdaOUwvNWVYVHdqVERZMXFBd1FYZzdmYyt3?=
 =?utf-8?B?U3Z0dURQY3NNNHkzY0V0Qm9TMTd2SDZxc1BEWmNPcmJBOFJUS1gwaVF3blc4?=
 =?utf-8?B?L0hmZVNNNGlhV2NCcWJiV3IwNGpMV1FYcU1Id0p3RUNoYzAzeXVsdW8wTUl6?=
 =?utf-8?B?R0IvVVlTZUd6N2Qyc3dZK1k5RnpVRDJXQmpMRVBBRUtNK09EVC9RTXlzNE5W?=
 =?utf-8?B?WjJhS1p4U2lJRG1QQ1E4WnlHSjQ3VnVFdWRacjgrbWk2b3I1KzcybzFqZGlV?=
 =?utf-8?B?OHBIOGFRTFVFcThtRGhWb1FpaGJSOWF0WGxqRFlRMmFPVnIzR0hNVll6OEVk?=
 =?utf-8?B?MVJWVHY1dnNteXJWRUY4bDZLS2JNN2diUkM4bUVSZFhBMVoyVHQrRnlQNFdi?=
 =?utf-8?B?clU1MGREQ2FmWURXWG9yTmRtM092V1VpS0grczJ2dUlnVmNuSFpyeEV5WGxT?=
 =?utf-8?B?T1hJQVlCV3NuaW5FRDZIZHd1MjVlQmFzdDdsRTVoNWZRbXdJUEw1YWtCeUJM?=
 =?utf-8?B?SVVCTFRIMnZWV3RURmdmUVk0d1NpUnd6V1dwc0JHVThxa0xENExROWRSSjkr?=
 =?utf-8?B?OWpUZkY4MjZVLzlTcTA0MG43TFFRSjFQdzNPYmFZM1hkRVVlKzZTeDhldzRo?=
 =?utf-8?B?WVlTMlo3c01rVmRubHJQaXJ1Z1pteW83N0VXL2JsTXB0K3FWT28yT0tIYkxF?=
 =?utf-8?B?RnhlSllYYkFBajAzbWludnVEak91QVRvRngrRXA5b0pnUnYvbGNHdUltLzhY?=
 =?utf-8?B?anNhSW1aMWg0WVBqMUR3czF6RW5kR0ZJSnZSQjFMKzFMTGh1Q3JGaU04bWRh?=
 =?utf-8?B?bEhTUlMvMnAzb1Z4UWVJeG01Wi9NMVN3MXFDNWk2RTJlTjJPUXYzOHBPTGZw?=
 =?utf-8?B?Tmh2SmkyVGZ5VXA4N1h5d1FhY2hPNzRTNjJlMEY0akNwNUd5STcrcmpWVWUx?=
 =?utf-8?B?WmhNdUs5MjRZeituMGQxV0taZ2NJeGFrR3dac2cvZGQrLzdTa1RnOTlXOC81?=
 =?utf-8?B?UUlUK0ZnQnlJaFEvZHI1UXk5bWE4V01nZkE2YUluNldNc2hFYTNERS9sN2I3?=
 =?utf-8?B?TW9rblBNbUlaaTdBZm5OOENRZTJkRVRFRWJ0T1h5NGlaQU5KNkhCazFKVFh6?=
 =?utf-8?B?WmxOTGM4OXA3QkFEcnU4REtlUnJYb2Y1cXR6VFJFTHNJNWd4MERLTWxrSlY4?=
 =?utf-8?B?dmRVd3g5UWR1NEQ0d2FFYitNWnF5UEQ3U1M1SGoxSm1Vd2ZEL2NsZTdxQ0Jt?=
 =?utf-8?B?SmpVOHdyQXBFUEgwV01RQ2FPRStZU2U4TjJNOXgydXpMcURPWGQ5M0NTSmhZ?=
 =?utf-8?B?dy8rOGgwTjRiV1hVeGQ0U1lkS2RwZDVEazU1K0ZrQU1XK0ZrMDVRaHdJUGZr?=
 =?utf-8?B?dXE2NHRKdnhpSVI2YkNhWHNwbHZtQUVaRHh1TXdsWXBzT0ZGYi9vSjZpbmZm?=
 =?utf-8?Q?1BKu+W5onCY0GGllYTB4UKq1L?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: analogixsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6739.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b403598-7694-43c2-adfb-08dc47e1d39e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2024 06:57:22.2954
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b099b0b4-f26c-4cf5-9a0f-d5be9acab205
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sm8ewcyOOAR7N5KwddRlH/cHy/s2NNsrlULKkPlhZzhhVaadsx7rMALF43mr49ZDtdPgdUx/c540QzjXXw7ytQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB7023

SGkgbXJmb3h5Z21mciwgdGhhbmtzIGZvciB0aGUgZml4aW5nLg0KDQpSZXZpZXdlZC1ieTogWGlu
IEppIDx4amlAYW5hbG9naXhzZW1pLmNvbT4NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0t
LQ0KPiBGcm9tOiBtcmZveHlnbWZyQHNpY2FtcC5ydSA8bXJmb3h5Z21mckBzaWNhbXAucnU+IE9u
IEJlaGFsZiBPZiBHcmlnb3J5DQo+IEJhemlsZXZpY2gNCj4gU2VudDogU3VuZGF5LCBNYXJjaCAx
NywgMjAyNCA0OjM0IEFNDQo+IFRvOiBIZWlra2kgS3JvZ2VydXMgPGhlaWtraS5rcm9nZXJ1c0Bs
aW51eC5pbnRlbC5jb20+OyBHcmVnIEtyb2FoLUhhcnRtYW4NCj4gPGdyZWdraEBsaW51eGZvdW5k
YXRpb24ub3JnPjsgWGluIEppIDx4amlAYW5hbG9naXhzZW1pLmNvbT4NCj4gQ2M6IEdyaWdvcnkg
QmF6aWxldmljaCA8YmF6aWxldmljaEBzaWNhbXAucnU+OyBsaW51eC11c2JAdmdlci5rZXJuZWwu
b3JnOyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsgbHZjLXByb2plY3RAbGludXh0
ZXN0aW5nLm9yZw0KPiBTdWJqZWN0OiBbUEFUQ0hdIHVzYjogdHlwZWM6IGFueDc0MTE6IEZpeCBw
b3NzaWJsZSBidWZmZXIgb3ZlcmZsb3cgaW4NCj4gYW54NzQxMV9zZW5kX21zZygpDQo+IA0KPiBD
QVVUSU9OOiBUaGlzIGVtYWlsIG9yaWdpbmF0ZWQgZnJvbSBvdXRzaWRlIG9mIHRoZSBvcmdhbml6
YXRpb24uIFBsZWFzZSBkbyBub3QNCj4gY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1
bmxlc3MgeW91IHJlY29nbml6ZSB0aGUgc2VuZGVyLCBhbmQga25vdyB0aGUNCj4gY29udGVudCBp
cyBzYWZlLg0KPiANCj4gDQo+IFBhc3NpbmcgYSBzaXplIGFyZ3VtZW50IGdyZWF0ZXIgdGhhbiBv
ciBlcXVhbCB0byBNQVhfQlVGX0xFTiBjYXVzZXMgYSBidWZmZXINCj4gb3ZlcmZsb3cgd2hlbiB0
aGUgY2hlY2tzdW0gaXMgd3JpdHRlbi4NCj4gDQo+IEZvdW5kIGJ5IExpbnV4IFZlcmlmaWNhdGlv
biBDZW50ZXIgKGxpbnV4dGVzdGluZy5vcmcpIHdpdGggU1ZBQ0UuDQo+IA0KPiBGaXhlczogZmU2
ZDhhOWM4ZTY0ICgidXNiOiB0eXBlYzogYW54NzQxMTogQWRkIEFuYWxvZ2l4IFBEIEFOWDc0MTEg
c3VwcG9ydCIpDQo+IFNpZ25lZC1vZmYtYnk6IEdyaWdvcnkgQmF6aWxldmljaCA8YmF6aWxldmlj
aEBzaWNhbXAucnU+DQo+IC0tLQ0KPiAgZHJpdmVycy91c2IvdHlwZWMvYW54NzQxMS5jIHwgMiAr
LQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvdHlwZWMvYW54NzQxMS5jIGIvZHJpdmVycy91c2Iv
dHlwZWMvYW54NzQxMS5jIGluZGV4DQo+IGIxMmEwN2VkYzcxYi4uNzBiYTU2ZGZiMjJiIDEwMDY0
NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi90eXBlYy9hbng3NDExLmMNCj4gKysrIGIvZHJpdmVycy91
c2IvdHlwZWMvYW54NzQxMS5jDQo+IEBAIC03MzMsNyArNzMzLDcgQEAgc3RhdGljIGludCBhbng3
NDExX3NlbmRfbXNnKHN0cnVjdCBhbng3NDExX2RhdGEgKmN0eCwNCj4gdTggdHlwZSwgdTggKmJ1
ZiwgdTggc2l6ZSkNCj4gICAgICAgICB1OCBjcmM7DQo+ICAgICAgICAgaW50IHJldDsNCj4gDQo+
IC0gICAgICAgc2l6ZSA9IG1pbl90KHU4LCBzaXplLCAodTgpTUFYX0JVRl9MRU4pOw0KPiArICAg
ICAgIHNpemUgPSBtaW5fdCh1OCwgc2l6ZSwgKHU4KShNQVhfQlVGX0xFTiAtIDEpKTsNCj4gICAg
ICAgICBtZW1jcHkobXNnLT5idWYsIGJ1Ziwgc2l6ZSk7DQo+ICAgICAgICAgbXNnLT5tc2dfdHlw
ZSA9IHR5cGU7DQo+ICAgICAgICAgLyogbXNnIGxlbiBlcXVhbHMgYnVmZmVyIGxlbmd0aCArIG1z
Z190eXBlICovDQo+IC0tDQo+IDIuMzkuMg0KDQo=

