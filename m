Return-Path: <linux-kernel+bounces-94922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA518746CB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 04:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9820B216A1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 03:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60332FC1D;
	Thu,  7 Mar 2024 03:30:49 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2094.outbound.protection.partner.outlook.cn [139.219.146.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415D4CA6B;
	Thu,  7 Mar 2024 03:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709782248; cv=fail; b=guwFZ+TPA0K/7dehVPjnYJdZrwnu+0hRQjw5dCMiFxvjE5LrWGfWtCoKzgCfvMmKjOU64eWugzQKh9bD+2lW0Vc4GNZfIBfylynEhz2HxJR+bHZZxuXYfZp7N6tTgPGREJyw4SMkWzr9xR424nr7wRk3aA1RZv6rMYAcxxYZRic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709782248; c=relaxed/simple;
	bh=0ivLiNy9DzgKauzmAzCwqfusRJU5sbfk0bUR7+5lDhI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DVLJocrGQ9LBATblx+eiZsyB/mF/wCL6s4/RyALXNborfSqQybO+Pg5ACjOOiQBuUijx0feazFzVTC6VXLQCL+0jM8AlipLP4rS3HpETdvbdUY1aODksrSQUo5doIYLuo4K2xCjgwCglL6gMkO1NtKmOwnX62SWU2iFOJaAuQhQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MwH7Lu0kPB0MIs1aBp/lXdeVx6OBm3znKd6QdJObSF9VjYQavnI3rwz1J3deyWWEgeFrX7GOadOGyRPPCglF6T0j/Yz4sDKIPEOurAq60j3kOSATN9OMfo3r9EWAfd4qRuR+ba+33bc1FRfCnICjcmIEQBqhpTMBeTGfGsod0QxOQuglti+5MozvhvEZduhhu6bhsHV5rLfmxehtgrwdr//caMGHBoyKWGBzkTsac+1R6Wo3OieuFrjG8XnfmAOe/pK6a7dOiPuYPvhcKiHDGi9YK4cwI1NIdtUkcnz6zaU01kYfrQ/fYG+v4o7BECAqrO5Z3yFXuRu7f3mfHA4iEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ivLiNy9DzgKauzmAzCwqfusRJU5sbfk0bUR7+5lDhI=;
 b=UChmQlPo94rYZ6No8H7L753b7KeCpuHVKavTjg8Sno21bJ9uCLOMIxCArQmJdXbIurDvLFfwIfvHVCHL7v019raA6hCCxFRk7mK5oPAnROUT2injfGMzwfbCHn1xgGjW0X7PqDJ4pohQYjk5u3aT7FE+npJ0mpijeVxzzh89YBHyHaSXReyNBd83VMtK9z37jEusLMZke52fhG6B9oXl9QeU8I8/d0VQeVxhGzKs/7QBmCEmhZi0vXlyuZoJmnD6PORAJ6LigtorAn2bhwXJTXbONiULJAkAmo2G/9h/tBs/e6QJ0SbCKVFWTMcWEgzWmsWQBH5ZsPetTdbrDxltCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1b::8) by ZQ0PR01MB1045.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Thu, 7 Mar
 2024 03:30:35 +0000
Received: from ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn
 ([fe80::4f3f:f537:9330:dbdd]) by
 ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn ([fe80::4f3f:f537:9330:dbdd%6])
 with mapi id 15.20.7316.051; Thu, 7 Mar 2024 03:30:35 +0000
From: William Qiu <william.qiu@starfivetech.com>
To: =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <u.kleine-koenig@pengutronix.de>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, Hal Feng
	<hal.feng@starfivetech.com>, Philipp Zabel <p.zabel@pengutronix.de>
Subject: RE: [PATCH v11] pwm: opencores: Add PWM driver support
Thread-Topic: [PATCH v11] pwm: opencores: Add PWM driver support
Thread-Index: AQHaZjRluR0OUQ++EEaNcaFVmtHuy7Eot2EwgABPA4CAAqxoIA==
Date: Thu, 7 Mar 2024 03:30:35 +0000
Message-ID:
 <ZQ0PR01MB1253AC8EA69055DDBD8EECF29F20A@ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn>
References: <20240223084332.100410-1-william.qiu@starfivetech.com>
 <ZQ0PR01MB12534DB9109EA8AEA33A221B9F22A@ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn>
 <isbszrmgdsipmlolzbhf2wlcen7hq4yre3titcrmzea7rvty3s@ugp6hsodvm4k>
In-Reply-To: <isbszrmgdsipmlolzbhf2wlcen7hq4yre3titcrmzea7rvty3s@ugp6hsodvm4k>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ0PR01MB1253:EE_|ZQ0PR01MB1045:EE_
x-ms-office365-filtering-correlation-id: 4cf9811d-5940-4841-816b-08dc3e56f370
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 +lu2/RchdA7uTmffsi+S4tiB6+DA0mNnUZ3rw2KkTeaxRa7L3PKVDyD8/ZerDsGF9WiX/SFOF0enwhceqTEv4AoWEFh7xN8WU17TGNdGCZ3A+0rjX4ZRnuFSEwQ8kNYgxwQLHg/SOwvcvOy7e4U5eRZmt6KGQdM0EB7lxkSM581rauK7ff2qIsX3n4abZqO8ywJDPDsb9tStmO2bnfQjp9SgOCtkJNJEEt4Ax2fptdv0z78KQqYQbMk+EGoN1LCo6Sc37TuwrhBTPmuiTyU1Jw1EMAWDRA7fd98berif1Wp0ZEI+MkNX1802DN6mR3nk1Km7fHrwQlWWtwQ6TUN/MZ88PYxR2ZJOGf9pKdwVaxn9ZdORutHHexUfOqabR8ikCa2i1Pg8iUq7y0UUFVngrBxyAravluk7J3VIeGC2d+RGD+rFL1uNSIzoVgb1dQK+w9iSG85oHky2CDHZ9EnEXiIY0cEGRzNXo/OGWnxNjK5nu2pjPrPTk86fF48AI7HtYFJOYPuk6GHfuX3ipldH4fNV/fllnfehLwo80kpnVnxy3Syf25VoJJaEdIFh5X12F0DgIetW2opKdXao5YbkcY3H8ijQDZj5FZXzllZLC/0vD8E54IJLvRdr9g8HL8LK
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(41320700004)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VytOVlpNL29pRml4RkxUOTBJWTN0djFOQnU0UU53NFlla2tObC9yZXNYOWZp?=
 =?utf-8?B?TGRuT0lKOTE1QU9QWXRqTkFKT2poQVFheVBXdE00am9FSUt4TmpmOC9MTmky?=
 =?utf-8?B?Sk04Z3EwblhzcWtuNG0xTFU5RzhTdWp3azR3a01WamY2M1RyVWVmWWppOGFk?=
 =?utf-8?B?RzU3OWtrdUZqb2pLd1MrMHRjWUUvMWk3MzFhNTlLbHJOOTdadnh1QmZKODZE?=
 =?utf-8?B?dTZBaXQrUlVVRjN5UXlDTWVNN2prNzEwR0hESDhzckRYaTZROUNxR3pJZ2JZ?=
 =?utf-8?B?SUVoV1BDaWU2UThCS0puT2RvRjBmOGpUV1czMjNHbHJhRUFOTWJ6T25Cb3Uy?=
 =?utf-8?B?ZFFHOXRmcTBqeG9XRU1OUFg2WWhabDExMEpMZ05PVytkcWVQaE5kcUVyeEU0?=
 =?utf-8?B?bUJnZUovR3dPb2hLOEVRSkxaeVduQ3ZsQnBsUmplN3BtTlpNeXNOY0x0aFlz?=
 =?utf-8?B?b0FqVjhmZG9BZWtvcDNzaFNGLzAxcVZyeW5uSDhtb2lDUklqZ0I3WTVRU2xK?=
 =?utf-8?B?YldZNU9GM0F5bUJzMXAya25iM0s4MVBhSm5SczIxbmh2UmdyOU4zRW5Pa1Vy?=
 =?utf-8?B?YlJjbStvOXZnd1MwQnhFM1JKV3JYdForbUpuU2t1OHFqZGJzVE9TVVorYVli?=
 =?utf-8?B?d3d4WVVtbzNJVDRwWmYyZzN6UjUxYVlSUnhnaGhaYXgyU2JmcVpnODh5SWxh?=
 =?utf-8?B?MzBzUmRTYWhSS25MYi9pZUUwMFQwK3Bsclh4MUxOam5tR1FWcllsOUNINksx?=
 =?utf-8?B?TS9XNDVRYldhN3U5V2RURy9KeFdLMG1YQUNjd0lOOFdVaWtwZEEyazFLN0VE?=
 =?utf-8?B?d0JOZEZWVS9jek01T1Z0Mm9XZzNPTEQ2UFMwVVlaMFpmTXJCOVpNdzRMc3Z6?=
 =?utf-8?B?NVdEUVd3dExYWi9wUHRtOGZJZFFtVjYrY1RYMmpINnRMeUl1ZVdFZzFLemc4?=
 =?utf-8?B?MEp3bmF1NUNoWGhWazJIS1dMcVBON2ZsSTA2ODZQdkErcTRjT2FKK0JMeVVV?=
 =?utf-8?B?V2RTZFlaT01PTWd3L3RDS0ZmNFNVU2dQT1lnN1FPb3lRMlVwbFdNVVJuc0dt?=
 =?utf-8?B?NGxkdEVYK3B6T01RNHc3dFQ5R0p6L0FpR1dTTURYK3lJTnBZa2NOUHRZNG1w?=
 =?utf-8?B?NFdmY2Ftd1BmbzRRNXRPL0lXU1N4RHNqcDhVLzBPWWVqYjVYTEtvTEREb1Bj?=
 =?utf-8?B?eXhQbmYzbWdZRTZCc0FNeGVPZURMQklTcG1uN2hoUDhZMHNZRzc2ZmcxUVgr?=
 =?utf-8?B?dFBTcHlyTERpOGw2OXRML25oK0FNelV3MWNHMnl1MVJBcjlnS29ZRTUreTV5?=
 =?utf-8?B?REU3SHo2d2MveW8ySVNyMmNsUlZOYjdPeFJyd0NueHUzK0ZTVURjSDF2U0pN?=
 =?utf-8?B?VFdhRW82YmtybDIzZlNVZE80UTFiY2xUOGVRTHFtU0JhOVhncE5EKzhyc2c0?=
 =?utf-8?B?ZjRGbGI0VlVvVllZSmVtc3pPNmdySWIxNWlrZEtESGFTOVZabklLQlNWUmpK?=
 =?utf-8?B?QUVIY2hNeWtKbXlnZkxQTm9CT2xEcGlSSy80QWxsMEhYaUx6T3JZUjJmUlJw?=
 =?utf-8?B?bUZhQ0dKRm9HbDBtaHpPc0FCRDZQcFAremp5NEs4V2lURDY4aWZxdTdkZmZ4?=
 =?utf-8?B?cnFGUUUvM3F4c2h4TGlKZFhrbUsxNmt1bCtSUVk0YjFYVkVYbEE5Tm9DVGE1?=
 =?utf-8?B?bGZsS1RyZUp1ZjR6SGVEMXFEYVFwNWJrVURNSHNQbzNzc0lza0ErZVVMREtp?=
 =?utf-8?B?SjBIZGhlYlhUUEthd3g3Qkl6ODlJSlBERXMzY3UySWp0SGlkcE1RaUxEaXlP?=
 =?utf-8?B?eGlOai9acTBtRHpVM1pyL1VveENmellCTFRKZXV1c2c5M0xGRDlqc3p3cWxo?=
 =?utf-8?B?cGhlK25SaS9vVTZGZ09zekFTbDFLTWpKcW1makFDWVVnc25BZ08rLzJLOC9S?=
 =?utf-8?B?Y3plQlpzZloxL3A3Z0NDK2J2bTMxbGFZWDBQUFZyUVZsb1ovcXVNeHE0QWFx?=
 =?utf-8?B?WTZSOHRQbUpqeEVKK1VXelFzeENINDQyWUhpdDUyOURzNUNLbllIc3R6djNQ?=
 =?utf-8?B?d005a2JlaWlFQUw5emhocEtUdFBxUXZ4aUlZVUVzWXc5Qk9XZ0x6QWVUQzJH?=
 =?utf-8?B?QUVxT2VOa2FPZldLMS9Sb3QzR1ZPZFFEcTdLNmdJSC80SHF5bFJ3SS9YaE50?=
 =?utf-8?B?VWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cf9811d-5940-4841-816b-08dc3e56f370
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2024 03:30:35.1609
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: buV9OC+ieh7D5tcfItgC51uNqEiFU/HU4DGqxSW5xCG5LP2KIkm85ygipeU4kFyHl6bdOkxGOQyrz0idPMiCLOHRt/oP6PmMdkbTX2snWX8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1045

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBVd2UgS2xlaW5lLUvDtm5pZyA8
dS5rbGVpbmUta29lbmlnQHBlbmd1dHJvbml4LmRlPg0KPiBTZW50OiAyMDI05bm0M+aciDXml6Ug
MTg6MzkNCj4gVG86IFdpbGxpYW0gUWl1IDx3aWxsaWFtLnFpdUBzdGFyZml2ZXRlY2guY29tPg0K
PiBDYzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtcHdtQHZnZXIua2VybmVs
Lm9yZzsgSGFsIEZlbmcNCj4gPGhhbC5mZW5nQHN0YXJmaXZldGVjaC5jb20+OyBQaGlsaXBwIFph
YmVsIDxwLnphYmVsQHBlbmd1dHJvbml4LmRlPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYxMV0g
cHdtOiBvcGVuY29yZXM6IEFkZCBQV00gZHJpdmVyIHN1cHBvcnQNCj4gDQo+IE9uIFR1ZSwgTWFy
IDA1LCAyMDI0IGF0IDA2OjEyOjIzQU0gKzAwMDAsIFdpbGxpYW0gUWl1IHdyb3RlOg0KPiA+IENv
dWxkIHlvdSBwbGVhc2UgaGVscCBtZSByZXZpZXcgdGhpcyBwYXRjaCBzZXJpZXMgdG8gc2VlIGlm
IHRoZXJlIGlzDQo+ID4gYW55dGhpbmcgdGhhdCBuZWVkcyB0byBiZSBtb2RpZmllZD8gSWYgbm90
LCBjb3VsZCB5b3UgaGVscCBtZQ0KPiA+IGludGVncmF0ZSB0aGlzIHBhdGNoIGludG8gdGhlIG1h
aW5saW5lPyBUaGFua3MuDQo+IA0KPiBJIGtub3cgSSdtIGJlaGluZCBvbiByZXZpZXdpbmcgdGhp
cyBkcml2ZXIuIFRoZXJlIGFyZSBhIGZldyBtb3JlIGFuZCBJIHN0aWxsIGhhdmUNCj4geW91ciBw
YXRjaCBvbiBteSByYWRhci4gTmV3IGRyaXZlcnMgcmVxdWlyZSBhIGJpZyBlZmZvcnQgb24gbXkg
c2lkZSBmb3INCj4gcmV2aWV3LS0tZWFjaCByZXZpc2lvbiB0YWtlcyBlYXNpbHkgPjFoIGZvciBt
ZSB0byBjb21tZW50Lg0KPiBXaGVuIEkgZmluZCB0aW1lIHRvIHJldmlldywgSSB1c3VhbGx5IHBp
Y2sgdGhlIG9sZGVzdCBvbg0KPiBodHRwczovL3BhdGNod29yay5vemxhYnMub3JnL3Byb2plY3Qv
bGludXgtcHdtL2xpc3QvIHRvIHJlcGx5LiBTbyBhcyBsb25nIGFzIHlvdXINCj4gcGF0Y2ggYXBw
ZWFycyB0aGVyZSwgaXQncyBub3QgbG9zdC4NCj4gDQo+IFNvIEkgYXNrIHlvdSBmb3Igc29tZSBt
b3JlIHBhdGllbmNlLg0KPiANCj4gQmVzdCByZWdhcmRzDQo+IFV3ZQ0KPiANCj4gLS0NCj4gUGVu
Z3V0cm9uaXggZS5LLiAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgVXdlIEtsZWluZS1Lw7Zu
aWcNCj4gfA0KPiBJbmR1c3RyaWFsIExpbnV4IFNvbHV0aW9ucyAgICAgICAgICAgICAgICAgfCBo
dHRwczovL3d3dy5wZW5ndXRyb25peC5kZS8gfA0KDQpIaSBVd2UsDQoNClNvcnJ5IGZvciB0aGF0
LiBJIHdpbGwgd2FpdCBzbyBwYXRpZW50bHkuDQpUaGFua3MgZm9yIHRha2luZyB0aW1lLg0KDQpC
ZXN0IFJlZ2FyZHMsDQpXaWxsaWFtDQo=

