Return-Path: <linux-kernel+bounces-143867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C80888A3E80
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 22:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5EBD1C20D59
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 20:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E9B456446;
	Sat, 13 Apr 2024 20:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="FZdmWuaU"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2046.outbound.protection.outlook.com [40.107.21.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47FD55E4F;
	Sat, 13 Apr 2024 20:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713040017; cv=fail; b=lmjQ8lFZaLdPJcoFwBv9GISG2SsbYTrYFIw73Wm95oSLHM0X5kprxDQ2kd1P/5vcaY7XDggeiJvhA7Ck1Uf6Cd7nCWvRTzdd2cFN0fBtaGNMq2bnqwILfXmkcuKWflS+vT7/SEU6fnSqhgYoU/8hHNhCtDBh0XKzHecfLFvPsK0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713040017; c=relaxed/simple;
	bh=dRvXeDRYmOUBVqotgjdvW5Fb3YRGhzyiktjo7rKJ8ig=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YEP42dnsyn0RbEG3mhjLLzsppbpJk9KwkCyBKDso/MlgKRiOhsZOR//x0HvfZdIAMuyHZrCtbs6CdKubG8mkfFuFnufo1luHpHKaVlPfOvYpo+z4FpbVlGTjtQiATYDi2csJbotP8horTp8dhYEw0l+AR0XyvinDAGIstBnluZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=FZdmWuaU; arc=fail smtp.client-ip=40.107.21.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LXewc9AiEkJLkSo/EqmlYOgwTMzEyPMEDCP5SATAVVGvSWgKALYOIj7CITCRuKGRawKi7FM40Cb2TRVTuskFVidwLtUl123tSXpofQ6ueXLcDzxRWSUGmQ337sLYE1cSIvm9ZiAS9DseJAbMbEdS5mzcT57jczb8rsHzdhunqWkz12CZP2fT3ti+ayS/c1smofnMY1B9z5FaKjI71Xcrk+rDsGvK4eZLfoDt1xz12iDI1nINCRGxv+JOrYlqeqraBV4Nj0HGINiF1zt6idJVatar6MZfNlTVqPmzT6H3yB5iZ7W4e/QCBVOvDeZW+q9Tez8r98RYlR3SEP3+xltHGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dRvXeDRYmOUBVqotgjdvW5Fb3YRGhzyiktjo7rKJ8ig=;
 b=S6U4u2iOM7Mm1G4K6kTqNC327MpkCXUD7DP2a9keH/KiuJOSeFgeL9Vt5/M5U3MO94xHY0EgDqljA7vQ7FmUeccv/LFA9kku03y/gFxLhOCN9XqOmK2uGq4UZ4L5/Sx/1VzHmJaS0LXSzlBNIBqzE0ntpxETchLFmDTi1wH4NM216izeo92eKQ95LY2BHymyed4/w2KlQ4iiIHhIRzSsWT4iwsBSpq8jvhCQPe+z5K24n/pu6OmVXuWAlQTHc1Ck9wYhI9AuSE4YYaInBuMgld9/Xr8LJXJIe/LyZ8FL/n5IfYClXOnbGwT1/oXp44KgUXSowShqRYFPh/5YHRgbEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dRvXeDRYmOUBVqotgjdvW5Fb3YRGhzyiktjo7rKJ8ig=;
 b=FZdmWuaUq9xN88FTLQBmsijfBD5U7BTM7QTOcxDf8Al97stKc8qlBmQ3l30XMuM0bUGXyq2kcK2xGW/b81/VuQlEkypwsfPpc9r9GfiaEOaGsPEegU0QUKBR+P1PxqpUUmv3cmnw5a3cx356esovLRrEGgy0tZxMkF7FCbC0KKnykLhABfG3XIEwj3t7pqNCJG9CYu4BMJVNF53qfVeJ5FgbFcj8psvIdyedeXCUSl4pVBF6oCSt/FT2vLGBWHVUptbAAGUTGKXM54FwG6MB/aVYDejO7tjLwAAxXBQrZV+3fKXKR598Lfc73O42t4gRBKNc8Q3KrED1gJZOR26OBg==
Received: from DB7PR10MB2506.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:46::26)
 by AM7PR10MB3221.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:109::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.43; Sat, 13 Apr
 2024 20:26:50 +0000
Received: from DB7PR10MB2506.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f293:fe16:3e4c:18a]) by DB7PR10MB2506.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f293:fe16:3e4c:18a%7]) with mapi id 15.20.7409.055; Sat, 13 Apr 2024
 20:26:48 +0000
From: "Haener, Michael" <michael.haener@siemens.com>
To: "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
	"krzk@kernel.org" <krzk@kernel.org>
CC: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>,
	"jarkko@kernel.org" <jarkko@kernel.org>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	"peterhuewe@gmx.de" <peterhuewe@gmx.de>, "robh@kernel.org" <robh@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"lukas@wunner.de" <lukas@wunner.de>
Subject: Re: [PATCH 2/2] dt-bindings: tpm: Add st,st33ktpm2xi2c to TCG TIS
 binding
Thread-Topic: [PATCH 2/2] dt-bindings: tpm: Add st,st33ktpm2xi2c to TCG TIS
 binding
Thread-Index: AQHajXKMFk8mwsoMoUWVe+Co/8YqIrFl4RiAgADF0gA=
Date: Sat, 13 Apr 2024 20:26:48 +0000
Message-ID: <85fa06dfb9bb69443ce86e10b8c4619317cccb3e.camel@siemens.com>
References: <20240413071621.12509-1-michael.haener@siemens.com>
	 <20240413071621.12509-3-michael.haener@siemens.com>
	 <9634ac9e-23ad-4bb9-aecf-d46c875f8d2f@kernel.org>
In-Reply-To: <9634ac9e-23ad-4bb9-aecf-d46c875f8d2f@kernel.org>
Accept-Language: de-CH, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB7PR10MB2506:EE_|AM7PR10MB3221:EE_
x-ms-office365-filtering-correlation-id: 87a13c69-a33e-4ec7-93c5-08dc5bf80b99
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 oXAsiiRDap/94o5SHoE6wc3FlRS+rOaMg2d36lNdh4X6FuyOQdgjBkqrxKprCbg9MAFMEVwVWL+TAIKn+Ga7y1wfQ/a/2AqY9IHRm4GXKFM8p9eDHJQ2ACkAudcPOgrGIq2QTxxazKDAAQXaNDsvqee/1N5+iEmcJLQ1wsxBF1luSFGLvBKpOzaG3X7JHC5X917Sogmv0WsfmZTByMYjyIXPG+ogpldWGw8dGF+PzCRgtlOOJXP57TZdKcMeaDMzjFkADpeDc9VvitGolYOsG4xk/SYXg+9RztTVb68iZshcpEedgevlWdpV3ge1crO5qOK+70FUZeloGGT2C+7EQWDiEif+64Pt2MqC4lW7DVg0Yv4TgzntOBuJZ6oeQZj6yF0haj4baEnY/Etj5OMxHlrCyOVnVNX+f3+v/4W86wEedoJb65m4O84LeSDCg8i4JFYdKefrTV2ogz4Szq36AlOM420uZDASqTTKp0GlGVdRfIDT2drrbFdw2Bf8x5VIgQ5i6jWwM3FfPejT7KTbJ9v2BaquUgDVNk9fHFOXUxRaEdxoOxAgLtNA6sDVto4GrHUb+pYoibn2NCcVFS6G5u0Xk2tYo0KpXYy26dEeLIYKnWXERqb2uyGPmZiSmSUJ8+sH01woVYoa7e5c1wNgltEANx85Hg7BoIte2Dyatr4Ij+/ViTGbFs882h2p6ABB
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR10MB2506.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007)(1580799018)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QU1TZ1JCRW1xYlNSUkZZR2x5SkY5WFhscnVJTnJTMHNvYUMvbENBSU15L2la?=
 =?utf-8?B?ZU1FWE50amRqZ1hPaHp4bmJhUi9TdFpQWmlFYi91TUtLQzkzaDNzbzZXc20y?=
 =?utf-8?B?cVBMWVV5aEJ4YS9LQ3FrT29GTXBaOEQ4VFh5Rm1TMThBVm9YUkw4Wmo5bEVD?=
 =?utf-8?B?OTZrS3dmOWc4Tjlzc2hwVm8veGpUb3YzTEVMa1NJcVZITmkzaXhTNkl6YWlZ?=
 =?utf-8?B?WXppVXJ0LzNEc2Yvb0ZDWEZxbE5mWlZWQzdwaFdaT1I3MDdHYkY0MUJqTDVI?=
 =?utf-8?B?MU1zSTNjTjhHZElPd1RzL0Z5OUdTQUVuTTJUdEdjNmZxdjZxa0lEODJzOTE0?=
 =?utf-8?B?WTFjSW0zajVxbTFKSkJtRkxDTExXTVpacytrdXRMNUxVdHAxZlBJZVREZzlF?=
 =?utf-8?B?R2RyU3FRSkNnY1NOcDhxUTFXb0tzUGVsc3Y5OEh0RDVtOEhJWlBiSjdMbXdr?=
 =?utf-8?B?YW5jMlNVZ1plcUhidWFucmZ3ZDJGbjJWMWxkaC9ZTWRwWUdocU1zekhxVzRG?=
 =?utf-8?B?TFI3N2pGNHE4VTNuQzA0dnRxUWxvNFFxNDA4ZWw1QjliYnVEVU9xOUZSaUR6?=
 =?utf-8?B?OWZ3YWxLVjAvT2tqRkk0SnhmenltVG9wUkpGeEdsakY3MUVUSXN4Q1BhQSts?=
 =?utf-8?B?bjdYQ2xPQVRxeDV3cUljOUlORXNVQ0FxSEtsVzEwdjA4RXFqR3QvK3lyZGUv?=
 =?utf-8?B?dUZqN0x3Ri9YUUFCc2Njc2FKUnZIQ2NtbERTdnhyNmxnYkkxa3JnOGRab0Zm?=
 =?utf-8?B?VDZwdTNXQ2VycTNyWVN0V1owQWFmeTQ2YitiMS9FTWxkd3M2NldYU2FQY1dm?=
 =?utf-8?B?MWZLcGs5YXRzWlErdTg0VHdjcEJ1eXQwamRPeU9FNXhIdFRNYzlnbVZPZEh6?=
 =?utf-8?B?NjV3UzBRL0R6N2RGQnhDS3M5SDdjNzE5YWdPUjdTcTBDUW9uSlFrL0RyV3RW?=
 =?utf-8?B?MnFGVk9RekI4cmVpVU5Ma2V4UlMzNElYUjJweDA3OGFUeEs2d3VkYTk5MjND?=
 =?utf-8?B?RExoSVJpTWdmTUQzSHE0SVQyMHpkU0VRRWkrMHpTbG1SMkxDRGRqNVpBZ1VS?=
 =?utf-8?B?VUFGZ3dYWnVyd3JFODJUWHl4RFF6U1czWDBnZnphVDQ1ZG1rWlRVT3VRZENy?=
 =?utf-8?B?SlBkUXRWTkhvRC9GNUNDS2xhK1dNK3V1bi95R29hN3cvbDQ5QktyT2dmUmVn?=
 =?utf-8?B?dXVUUkJ0NmdncWk0Z1Ruc09YblFSVFpkdnNkN1h0TGNWRUNBaElDeGw3bUJs?=
 =?utf-8?B?cGQ2QTMvRms5TGNzTU5rUVNvOGtES2NpcUswRkhBL3RkNU11QTVzeU5YUEdV?=
 =?utf-8?B?K0I5NSszMXdRY2xrd1BkeHRNYU5PS3plMGQ3R0w1eFoxNE9oVkpxMHNtdzBh?=
 =?utf-8?B?R3R6RThEaXVxREFIRHhPZldYS1dJRi9BN3ZpRkhYWkxhUjJnd1dTeUlnWm1K?=
 =?utf-8?B?YWNnMmpjdHFFU0EwNitGOG5iQnFUall0eEtBdVpEeXE2emFkWlB5YjlyV1VT?=
 =?utf-8?B?VElZVnBISW1hWlpoS0NVVkw5MytnYzJ4VVFva3c2S2J3OEk5Yi8yM2pnb01u?=
 =?utf-8?B?bWNhcUlDNjI5S3BVVlp6UG1wend0RWo0UlJESlRGTnJjUTkyWDBuZHcrTGc5?=
 =?utf-8?B?YlFyQWp2TTgzeUxJMkZXSHF5ZUdOcHZYYUpDMFpjdWJTdGE0RmxwRHkzY1F5?=
 =?utf-8?B?bUpxSWZ4R1MyQXBFN1cxOWFyRU9tdEl4S2hMS0E0NjJpSHZQTkI1RDczb1NN?=
 =?utf-8?B?R2NSRlhNMnFrM2ZnT3BLeFlkMWRGeks1USt4dytzSkJxVkYzSDFZUXk1akd1?=
 =?utf-8?B?NWNYbXh3UmN0SjExUzJqak01S2t6ZXZZeFBGV1BXOFRjQUszcktBbzNNa2pR?=
 =?utf-8?B?bWFqSmN5VUhkVmV6QmVPNTYzV2xITUhhUzBCWFV0ZUhWYVFnQlNhbytqV2Q0?=
 =?utf-8?B?aDQxR1o3eTAyU0Y3Sk1BL0NySVJ6M1BIM01rMXN2cDMvNk1obmJkbWJMY3VH?=
 =?utf-8?B?bytPWThuMnZ4NkUxaWI3TTFKMkRKUFZZRXFzd1lCUUdWMHltTzgzdHhVMmEv?=
 =?utf-8?B?WmxjSDVwL0xNNUZTdEs5RGpYZVZwbWl6UnNTR2o3TzhpSkVJUnRrcmtiMFE1?=
 =?utf-8?B?eVRXc2JONXV5N3VnTUhJUDhDQnNTUzhsTWpSamNXODRreTNjaUlKVGtqSTZ1?=
 =?utf-8?B?OGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FC1B16A660AA104E91CD2E1310016F21@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR10MB2506.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 87a13c69-a33e-4ec7-93c5-08dc5bf80b99
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2024 20:26:48.4091
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 243RyOsRO7Dhg5HRCwwSZbS4lrW1zca03PBFQZKViGIptUWaUuk7+2Q3SFIRUFyR3pAuKV9XMCI0v7NfY1eu7k08lI90/Vaqepjp6D1Raeo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3221

T24gU2F0LCAyMDI0LTA0LTEzIGF0IDEwOjM4ICswMjAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiBPbiAxMy8wNC8yMDI0IDA5OjE1LCBNLiBIYWVuZXIgd3JvdGU6DQo+ID4gRnJvbTog
TWljaGFlbCBIYWVuZXIgPG1pY2hhZWwuaGFlbmVyQHNpZW1lbnMuY29tPg0KPiA+DQo+ID4gQWRk
IHRoZSBTVCBjaGlwIHN0MzNrdHBtMnhpMmMgdG8gdGhlIHN1cHBvcnRlZCBjb21wYXRpYmxlIHN0
cmluZ3MNCj4gPiBvZiB0aGUNCj4gPiBUUE0gVElTIEkyQyBzY2hlbWEuIFRoZSBDaGlwIGlzIGNv
bXBsaWFudCB3aXRoIHRoZSBUQ0cgUEMgQ2xpZW50DQo+ID4gVFBNDQo+ID4gUHJvZmlsZSBzcGVj
aWZpY2F0aW9uLg0KPiA+DQo+ID4gRm9yIHJlZmVyZW5jZSwgYSBkYXRhc2hlZXQgaXMgYXZhaWxh
YmxlIGF0Og0KPiA+IGh0dHBzOi8vd3d3LnN0LmNvbS9yZXNvdXJjZS9lbi9kYXRhX2JyaWVmL3N0
MzNrdHBtMnhpMmMucGRmDQo+ID4NCj4gPiBSZXZpZXdlZC1ieTogQWxleGFuZGVyIFN2ZXJkbGlu
IDxhbGV4YW5kZXIuc3ZlcmRsaW5Ac2llbWVucy5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogTWlj
aGFlbCBIYWVuZXIgPG1pY2hhZWwuaGFlbmVyQHNpZW1lbnMuY29tPg0KPiA+IC0tLQ0KPg0KPg0K
PiBOb3QgdGVzdGVkLi4uDQoNCkkgd2FzIG9ubHkgYWJsZSB0byB2ZXJpZnkgYW5kIHRlc3QgdGhl
IGNvbmZvcm1pdHkgb2YgdGhlIFNUIGNoaXANCnN0MzNrdHBtMnhpMmMgd2l0aCBrZXJuZWwgNi4x
LCBzbyBJIGxlZnQgb3V0IHRoZSB0ZXN0LWJ5IHRhZy4NClVuZm9ydHVuYXRlbHksIHRoZXJlIGlz
IG5vIG5ld2VyIGtlcm5lbCBmb3IgbXkgZW1iZWRkZWQgaGFyZHdhcmUuDQoNCj4NCj4gUGxlYXNl
IHVzZSBzY3JpcHRzL2dldF9tYWludGFpbmVycy5wbCB0byBnZXQgYSBsaXN0IG9mIG5lY2Vzc2Fy
eQ0KPiBwZW9wbGUNCj4gYW5kIGxpc3RzIHRvIENDLiBJdCBtaWdodCBoYXBwZW4sIHRoYXQgY29t
bWFuZCB3aGVuIHJ1biBvbiBhbiBvbGRlcg0KPiBrZXJuZWwsIGdpdmVzIHlvdSBvdXRkYXRlZCBl
bnRyaWVzLiBUaGVyZWZvcmUgcGxlYXNlIGJlIHN1cmUgeW91IGJhc2UNCj4geW91ciBwYXRjaGVz
IG9uIHJlY2VudCBMaW51eCBrZXJuZWwuDQo+DQo+IFRvb2xzIGxpa2UgYjQgb3Igc2NyaXB0cy9n
ZXRfbWFpbnRhaW5lci5wbCBwcm92aWRlIHlvdSBwcm9wZXIgbGlzdCBvZg0KPiBwZW9wbGUsIHNv
IGZpeCB5b3VyIHdvcmtmbG93LiBUb29scyBtaWdodCBhbHNvIGZhaWwgaWYgeW91IHdvcmsgb24N
Cj4gc29tZQ0KPiBhbmNpZW50IHRyZWUgKGRvbid0LCBpbnN0ZWFkIHVzZSBtYWlubGluZSksIHdv
cmsgb24gZm9yayBvZiBrZXJuZWwNCj4gKGRvbid0LCBpbnN0ZWFkIHVzZSBtYWlubGluZSkgb3Ig
eW91IGlnbm9yZSBzb21lIG1haW50YWluZXJzIChyZWFsbHkNCj4gZG9uJ3QpLiBKdXN0IHVzZSBi
NCBhbmQgZXZlcnl0aGluZyBzaG91bGQgYmUgZmluZSwgYWx0aG91Z2ggcmVtZW1iZXINCj4gYWJv
dXQgYGI0IHByZXAgLS1hdXRvLXRvLWNjYCBpZiB5b3UgYWRkZWQgbmV3IHBhdGNoZXMgdG8gdGhl
DQo+IHBhdGNoc2V0Lg0KPg0KPiBZb3UgbWlzc2VkIGF0IGxlYXN0IGRldmljZXRyZWUgbGlzdCAo
bWF5YmUgbW9yZSksIHNvIHRoaXMgd29uJ3QgYmUNCj4gdGVzdGVkIGJ5IGF1dG9tYXRlZCB0b29s
aW5nLg0KDQpJIGNhbGxlZCB0aGUgc2NyaXB0IHNjcmlwdHMvZ2V0X21haW50YWluZXIucGwgb24g
dGhlIGxhdGVzdCBrZXJuZWwNCnZlcnNpb24gZm9yIGVhY2ggb2YgdGhlIHR3byBwYXRjaGVzIGFu
ZCBhZGRlZCB0aGUgb3V0cHV0IGxpc3QgdG8gdGhlDQppbmRpdmlkdWFsIHBhdGNoZXMgYWNjb3Jk
aW5nbHkuIEFuZCBvbmx5IGZvciB0aGUgY292ZXItbGV0dGVyIEkgbGlua2VkDQp0aGUgdHdvIGxp
c3RzIHRvZ2V0aGVyLg0KSSB1bmRlcnN0YW5kIG5vdyB0aGF0IEkgc2hvdWxkIGhhdmUgc2VudCB0
aGUgd2hvbGUgc2VyaWVzIHRvIGJvdGgNCmxpc3RzLg0KDQo+DQo+IFBsZWFzZSBraW5kbHkgcmVz
ZW5kIGFuZCBpbmNsdWRlIGFsbCBuZWNlc3NhcnkgVG8vQ2MgZW50cmllcy4NCj4NCj4gQmVzdCBy
ZWdhcmRzLA0KPiBLcnp5c3p0b2YNCj4NCg0KQmVzdCByZWdhcmRzLA0KTWljaGFlbA0K

