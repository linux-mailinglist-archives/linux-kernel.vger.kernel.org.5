Return-Path: <linux-kernel+bounces-167137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A74EC8BA4DB
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 03:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E3941F22E9B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 01:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC00D8F47;
	Fri,  3 May 2024 01:20:54 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2097.outbound.protection.partner.outlook.cn [139.219.17.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53912A31;
	Fri,  3 May 2024 01:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714699254; cv=fail; b=NU2BLf/VHT8ZjA2A0UEdYQLYIJF3l+mM8oLxM4BFhUKJBgrWkuBrfpUjq0hnRb/33K5kYpnZq+b9HhLc9ndJuMBAUrWfGLXiaZ1zqmNjuA4lEuVBqZWQhWdmpKclXHotZ9iWnawEW3G1J4ONdli8k3v1wNUNdJ9FJyfnyGjoU/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714699254; c=relaxed/simple;
	bh=msSzXoyUeddi2IcswFmc164OFAcDtPMX6sNhy3K7LDw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=s95aRxf9uCmmLb9dOFkOUhzchVbcw+BQ3je1xKXX2cZx0gqUuU031egehs/NHUvO17TDcMYMOsllrNsgTRqWwDEEQswbOLtM32OmC4Uzg2lOyLOx4l8Gq0auQsjlW89egwbgtnGcNrG0Zg5ijsU5WtuR/f7zn7pwBYIGkx9NuXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c9qiiIeoKnMcjcsREWCkh1Z+RFnKlhn6VZMyEm70i2P6qaGRr3WyLxI0Sr/qwMxwxZlNwJDUevOIxi2eE1IscdrimCi+gpBzAIW+7RdUjfxRcLQtGmykiDjrsFku8kzkW9Gvys03eEJQXxx2DT/ve/ravIBeCCfhzyr714nUuU/ft15beZgjF7lp+4rfoHP87FQhH5cIPEUAm4Se8jUVRq2oV66COfexmwuE6gC1anJCGDR/KgzruDa12kSTdyJH2qliw5EGPWQTMsNQGRTtcVRosJJJzaCg3qLJm1TljoPMpaiy8AXpIsi9d7/5AJdIsPFyMwaBuT57k84GyF49Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=msSzXoyUeddi2IcswFmc164OFAcDtPMX6sNhy3K7LDw=;
 b=ce8F+8QY3owuA9DZM1hxJ2LGly8jFA9U904FBhonrn5QgVD/hrpGs5YhzfWeAseDCd9dDMOo1ZQztEIBwBAN/z3+41aZusu8x5Z71jB3lzhF0SZEa4ge7cVfmy0TjM5ENp6w0MgDhMo3WMRB+vIfXwuIDH64NT0VtGqTSmwKD7CiHSFsRcZ6xkLb0sidSPF8JGMYd4gxaqWFI/i17MDHN710gqbCVLL5K/Bm3xaaf2md+smM93xURtqXY5svwjBDUYXd2/zFi2zH0sg4a9NSSsul2GqWPnjVyg+jKp6NcLRPVsHJSj7Mx2jRcoZ1lNMv0A9RLWme4rwINhf+V0hA0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ4PR01MB1154.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::9) by ZQ4PR01MB1283.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:15::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Fri, 3 May
 2024 01:20:46 +0000
Received: from ZQ4PR01MB1154.CHNPR01.prod.partner.outlook.cn
 ([fe80::301e:ec80:4356:8b14]) by
 ZQ4PR01MB1154.CHNPR01.prod.partner.outlook.cn ([fe80::301e:ec80:4356:8b14%6])
 with mapi id 15.20.7472.044; Fri, 3 May 2024 01:20:46 +0000
From: JiSheng Teoh <jisheng.teoh@starfivetech.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
	Michal Simek <michal.simek@amd.com>, Lars-Peter Clausen <lars@metafoo.de>
CC: Leyfoon Tan <leyfoon.tan@starfivetech.com>, "linux-spi@vger.kernel.org"
	<linux-spi@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, EngLee Teh <englee.teh@starfivetech.com>
Subject: RE: [PATCH v2 1/2] spi: spi-cadence: Add optional reset control
 support
Thread-Topic: [PATCH v2 1/2] spi: spi-cadence: Add optional reset control
 support
Thread-Index: AQHanH5HH1BLD8AfE0SAO/KorZoVM7GD/biAgAC4nbA=
Date: Fri, 3 May 2024 01:20:46 +0000
Message-ID:
 <ZQ4PR01MB11549D971962995878D9593EEB1FA@ZQ4PR01MB1154.CHNPR01.prod.partner.outlook.cn>
References: <20240502104800.3030486-1-jisheng.teoh@starfivetech.com>
 <20240502104800.3030486-2-jisheng.teoh@starfivetech.com>
 <b0c9aa87-ae84-4979-b26b-8fd0579c5f08@kernel.org>
In-Reply-To: <b0c9aa87-ae84-4979-b26b-8fd0579c5f08@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ4PR01MB1154:EE_|ZQ4PR01MB1283:EE_
x-ms-office365-filtering-correlation-id: 19c93834-b7a0-4963-4533-08dc6b0f4258
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 bgY5ZfrQrH7Dy57hf318f8eu0QWdA0cFFu2alahbnIw6YcEOMfvjwVXKYcglr2j/GPA3TOPTqoCxxsMSg1QsStzSzRi4fA/MMZ2w3u84buC7CQUL6x0KgtYBP7sPwFS0JTBrmCK4XJzM2/bje85H6X1mq+jml+Eig1ssHELqpvtVz/Jd5JY0kxYuXTPdaAgUOKu31hg5NJDS8rQekC7aRDHSbVH9oKSpY7lpXUJkUGeuQ75GwA7JzJI2AoTFP1lTB3/9gecpa4ZEMy5BWJZqo1DoCOcxgSaE4Y2XjHDTwwclUlvhkuA25NFz2XhmXkMDI6Nj/ZvUYtLj3hJuAh0bA0qrZ+cvz2ButITY6igFgMlNTUQ/37NDxUaVLVqTuZgs/DFpr7k43niJRYo6bR151iVlgqyzOff5gTWkLr9t9OklJjUQM221Vb8nSxMBiAgwSHTDFVgE48my8euckdpxyqMIJXeJmIeA9R3ToYNC4VoNSziLhR1N5UxUpq1gWDw8fx0buzSkxhwrDjyGflwDoqGc2hQUzt03cG1jZ7wYm2sG73iXyKmnRBOt9uZLV+OvTJRaU1YmKKTu8L/cYQ7/4WRFe3EVkxfEpjhRvqOwceLRBF8S6E0ZOKkLuN2zZIOC
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1154.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(41320700004)(1800799015)(7416005)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?U2xOTm15WnRiK1BHb1FuYnFId29PNE1JUGxoLzBHLzZFN29QOUdtNzdlem9z?=
 =?utf-8?B?WXovZEk3SHZNTzQzc1RtbmxvckU5ekloR3pBclFqL3B4WnJnQUU3NTVUOWFo?=
 =?utf-8?B?REtuWTVnOHF4TVR2bm1kc1piSUpKdEtZeTN4bWFRc2pGbnFncTE2aCtnVUh1?=
 =?utf-8?B?K1BVS1JaczdmNHhBU29mbDFSckY2TnBwN2N3eWluSGpwSUhZL1NOVFd3UkFC?=
 =?utf-8?B?em9GdksraGk4UEtBdWM3dnJZQnJhZU1PMkpjbzRpN2tob1VXamRMdGpLMnd1?=
 =?utf-8?B?TGdYb3RZQ0hWaEY0Umg5cnZRTzJWWXRQSWhIWHgyVzR3STF1NXppUWliY0FY?=
 =?utf-8?B?REVEdGxINGY0QnVwYTFZOXVoYnBVSUVidzFHbWlWZHRPRkQ5eEJZUjF6Q2t0?=
 =?utf-8?B?RlV3R2VSb3pBNFJJTFJ5VHR2UndIakNwMXRNMUl6Um5oV2I4RWpYalN1NkNt?=
 =?utf-8?B?MU1tYVBZN2ZsQTVqbWdKZVFqSkRYbUxhY2R2VzFlUU5zNDhCQlVzeEluRGxE?=
 =?utf-8?B?RklJaU83K05WV1d6UVBDR1dmQzRpcWFCZFlCc25xUHowUWdpUkR2M3RyNi9n?=
 =?utf-8?B?Qlg0NStXSTdYZGRuNHErWTdKdTdnS0toMXRSMXAzZDNBcmErVHQ2MDFmMlFG?=
 =?utf-8?B?WVVRajBteitRNEZKczlPT3M3TG9BQlloNU1ZM2NDc2w5NUVIelpMZkRPM2FH?=
 =?utf-8?B?ejdJVmxDaFlMdTVkNm5JVW1MMm9MVTlUZFVVQ2h0RUJsUExVQnFiUGdWc3B5?=
 =?utf-8?B?dHBhN3B6RW5BdEVSM1phN2xBc3R4MTl5d296OTRnT0ZtUmtWcUZUMDh4Unlh?=
 =?utf-8?B?UlhucDJBOXJicVQ5VjQyTjlleVA5blhIckY3T1RRN0VwRXlTaDJCV0x2b3hh?=
 =?utf-8?B?ZGNBRU9ZZ2d2Q29NaytXYnRGaWZOU0xtU2FLeXdVeUlWSEM1Z2FFOFdMMWN5?=
 =?utf-8?B?K2hoclZsZVIzbTF5YlNUL2g2V0xHTU8yMWt2VmlhVWlvanlMbDE2bDg3WWpw?=
 =?utf-8?B?VTJNVzAyZDN0V1ZRbGczNFBCaUJIdElsV0FrTmRiQnpKdU5OVDljRWNKVU1r?=
 =?utf-8?B?dlYrdVFoNmMrRlVLSmhrZll2dVZWWERxUmhFRTNHbU1CL3dGMGRpR2d6M25K?=
 =?utf-8?B?SllSUHEzU1VOaGIvWVhsL3AvdUJPbS9RRmdTdTdCV09sSFREOE91MDlWWHJP?=
 =?utf-8?B?Q3J1ZmNFUmtSVWR0eGVjNlBVdEZPcjdBSEZhdlIrbExSQjVzYk9hVzZBNXlJ?=
 =?utf-8?B?elhpRTFVbVFpYlVMUWZ4NEloRzJBM0MwclRrQnV0TVY4YmE3WjB0UmkzdG52?=
 =?utf-8?B?b2VjOFFGdkg1cGNzN2U1anZoMXVVSzIyUThWMlVGeE0xUDd5MmVCdEdPWGZo?=
 =?utf-8?B?VHgvbHllRXVpbURWWDk1K0VJQTdYaFVraG5FSU9kZkdvQXlZZ2lXMTkvblA2?=
 =?utf-8?B?b2pVcUpQTVBHNkJIQXVxQWFDTW15Z2hKSFMya1kzUnNFYW80clNNNE5DWFIr?=
 =?utf-8?B?WUJsYTh1dkViVEo1ZHNlLzI3MHh6eWpDc0I1QnVRQmtNTDRBZUdYYTZlK2lM?=
 =?utf-8?B?dnVKbkFhREcwS25yNGZRNU4wOGx1bFEwem11b1JNZTl1OW9OVWM3UnhQc1pk?=
 =?utf-8?B?L3ZDZ3lKY29BSGxXcnQ0RngzR05LaWp3SXhZZ3ZTZ3VwT1dkTjBONDl0aGlr?=
 =?utf-8?B?Vjh1SVozejBSdmVYL25aT0RuTW94TW9Ydnp5NnFPVjliZmJPYjYxOFhmSitx?=
 =?utf-8?B?ekxYRE9NUTlZTWc5andvbGpMWTRaRkdHTVVndFlrYlA4T1hHSHRneWRBWmxn?=
 =?utf-8?B?cGt0TXE2VW54elFhb2M4VDJRYk8yTEVBb2lCcWI0SkdOWmZLVzV3QWdMVDJJ?=
 =?utf-8?B?K1RWMlN1OExqM1FlWDBBN0V1L3EwbEJRcDJLbkNHM3ZJUzNaK0RFUDh4WlRt?=
 =?utf-8?B?a2NuT3VoWnNzbEZKa3BiRWc5TERMUi8zaG1SLzI3Skh2Yk83Z1FVT0lJZlVv?=
 =?utf-8?B?N04yMmliallRM1JPc2JlZ0dqeW9KZ25xN0l1anFteE9HOHJFSlpwMmF1SGVD?=
 =?utf-8?B?b3gxWVE5Um92TzlLbXFIcEIxR3hxTm10aW1pdnFhWlFaSExSMVRmV1BZYmVi?=
 =?utf-8?B?TkdMRG1keDRQbW1aSTJqQWlnM2lmQzRlOE53dk5jNzJPTm15NVhWVXhnS2pG?=
 =?utf-8?B?T2c9PQ==?=
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
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1154.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 19c93834-b7a0-4963-4533-08dc6b0f4258
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2024 01:20:46.1037
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S3N/tpM9j/FK/Ox2rv+7Zp9Asq+qTjoM3SSQxHk41goMgROdiMB7vAl2PCHy0yd2ybC+Y0gVwrIv4Z0Iw0/dK6OS/y/XWmF1FrHAxdC4m+Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1283

PiBPbiAwMi8wNS8yMDI0IDEyOjQ3LCBKaSBTaGVuZyBUZW9oIHdyb3RlOg0KPiA+DQo+ID4gIC8q
IE1hY3JvcyBmb3IgdGhlIFNQSSBjb250cm9sbGVyIHJlYWQvd3JpdGUgKi8gQEAgLTU4OCw2ICs1
OTEsMTYgQEANCj4gPiBzdGF0aWMgaW50IGNkbnNfc3BpX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9k
ZXZpY2UgKnBkZXYpDQo+ID4gIAkJZ290byByZW1vdmVfY3RscjsNCj4gPiAgCX0NCj4gPg0KPiA+
ICsJeHNwaS0+cnN0YyA9IGRldm1fcmVzZXRfY29udHJvbF9nZXRfb3B0aW9uYWxfZXhjbHVzaXZl
KCZwZGV2LT5kZXYsICJzcGkiKTsNCj4gPiArCWlmIChJU19FUlIoeHNwaS0+cnN0YykpIHsNCj4g
PiArCQlyZXQgPSBQVFJfRVJSKHhzcGktPnJzdGMpOw0KPiA+ICsJCWRldl9lcnIoJnBkZXYtPmRl
diwgIkNhbm5vdCBnZXQgU1BJIHJlc2V0LlxuIik7DQo+IA0KPiBQbGVhc2Ugc3dpdGNoIHRvOg0K
PiByZXQgPSBkZXZfZXJyX3Byb2JlKCkNCg0KT2ssIHdpbGwgc3dpdGNoIHRvIHRoYXQuIFRoYW5r
cy4NCg==

