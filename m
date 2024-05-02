Return-Path: <linux-kernel+bounces-166492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD438B9B64
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 15:13:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34EA1282C9F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 13:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A09584A3F;
	Thu,  2 May 2024 13:13:45 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2119.outbound.protection.partner.outlook.cn [139.219.17.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32994824AC;
	Thu,  2 May 2024 13:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714655624; cv=fail; b=d5dY2xxQ/a78IMKX1fI1msYXQZ4FzQTg7jDU2/K3tXVnb4QWdYHOdvhCf/P0N/B9SYHjI8Px94yHanD+nJSh1mNQt3gDATtpFcUYLju1cfs/O/Rf35jm/U99jNrqUhfyF1Fa3h1EKLPOGFZ6J0LUHgunGjCpSloZxfOJ+zqWVps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714655624; c=relaxed/simple;
	bh=Y+t4jh9ItlV5uG63DXPLk7KpWeg2fgmI3UZxxYPuXes=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ubwhmWI4TD+wvPLCWdlTwXqLoruJUJUfZTkqX25c1c6/KsUDrqMo5FC/HqRz9VSxaCcvQ1RloSD7AyEgrSzRBRC6phLM8IOH8wx1wRwm2+RsP05Rrk1wUfjBRY5LjDMwQi8heG7rwSjndMXUzw+IEK9A3w9n5DkkMq5/l50c3f4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j1lpFNapH0PKYfGa/lHFalqL0Flceh1eMXthgruSZ5elSQFjJvs0MGlQyq6EUaMPKw2bGM401QHfavUwblX0Qa3ZkCU7pKSGULEWaHAAHOk19EeVas3QeDzjeU5UhojOE3mgothSjNe1TO751SkC0QY+xGfr7Gx3xJ9BHiGJQySHnBIhJTNihDX+UksbSwmM4nPPnzXIZPxplUySk6W34+yIgI+wchBRvcFdmIedVmU2szxvnGc7LrVtPyZujB9FePYKf8w4OapfJvsljKyzMYavo9QYo8UgnG6Q4Qs8+JL+J3bFPuyqjix6lqGqd09COfeNZsSOgfCeoGr4Tp8l/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y+t4jh9ItlV5uG63DXPLk7KpWeg2fgmI3UZxxYPuXes=;
 b=QjyNMtqEpWv+Uz/0X7dk7dxdnv7E9FWMUtjITbU4w55YB9Jk/WcfRAGgFikWj3BdFkjHeO7QKf0o2H8whVf+paY8B9plQhBXI2uSPFtcYqU4zaAPCKwjTyydCQjZbGCnojQFXZ1oUgd4skrFWQb2gvsn08mNVLAkuBsE6PFudui7g/D55LXPlgHcfILmTsL6MPexNkqDGM/qwnxQJBl3e87RYdK1JvZ5n2zKvYbv1tLKMsHQ5p7Yz3RKeiWOGE8NIrquVCpGUT9MTFDfw30xGHwwdykavScudXZd2Tegxpk636AbTh7wlyj1j0PQn/SXxjYxGUqQe5q7vw+mn2uHxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ4PR01MB1154.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::9) by ZQ4PR01MB1235.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:15::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Thu, 2 May
 2024 12:58:13 +0000
Received: from ZQ4PR01MB1154.CHNPR01.prod.partner.outlook.cn
 ([fe80::301e:ec80:4356:8b14]) by
 ZQ4PR01MB1154.CHNPR01.prod.partner.outlook.cn ([fe80::301e:ec80:4356:8b14%6])
 with mapi id 15.20.7472.044; Thu, 2 May 2024 12:58:13 +0000
From: JiSheng Teoh <jisheng.teoh@starfivetech.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
	Michal Simek <michal.simek@amd.com>, Lars-Peter Clausen <lars@metafoo.de>
CC: Leyfoon Tan <leyfoon.tan@starfivetech.com>, "linux-spi@vger.kernel.org"
	<linux-spi@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, EngLee Teh <englee.teh@starfivetech.com>
Subject: RE: [PATCH v2 2/2] dt-bindings: spi: spi-cadence: Add optional reset
 control
Thread-Topic: [PATCH v2 2/2] dt-bindings: spi: spi-cadence: Add optional reset
 control
Thread-Index: AQHanH5J1xo3ta2QXkGkfo2fF/uLg7GD3ZcAgAADf9CAAAQVgIAAAXwQ
Date: Thu, 2 May 2024 12:58:13 +0000
Message-ID:
 <ZQ4PR01MB1154491D456521284B3BACFBEB18A@ZQ4PR01MB1154.CHNPR01.prod.partner.outlook.cn>
References: <20240502104800.3030486-1-jisheng.teoh@starfivetech.com>
 <20240502104800.3030486-3-jisheng.teoh@starfivetech.com>
 <89f96e06-1966-43c2-b4c4-17e1669c2566@kernel.org>
 <ZQ4PR01MB1154B6FBA361C503AC10E6B6EB18A@ZQ4PR01MB1154.CHNPR01.prod.partner.outlook.cn>
 <ea96eb15-2cd0-4f0a-8bba-8bd7f37cbbc2@kernel.org>
In-Reply-To: <ea96eb15-2cd0-4f0a-8bba-8bd7f37cbbc2@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ4PR01MB1154:EE_|ZQ4PR01MB1235:EE_
x-ms-office365-filtering-correlation-id: 60ba3ba4-991c-4b3e-17cd-08dc6aa786e7
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 e6e6ZNDmKCx5RyxCtrl1+saN3SEHZo7oL8PRHJCcKAXIcHrJT4o+9g1JiJs9LMyl5s3a3F37i8KYy7tiOsiSkGYYue1mNQY4NydoLb0B0Max7omNNHYRKjsPMTso6HT6HBo5S2AUYJt0GpX4HALrhHlYLzv4jSUzTb43cLjutBEyO2cj88g4Igu4nh+LuON8iEH38XkTLTKSIcU19ZjRCTUjT1RcSnZw0nLIqrKWtMMX/wgn4OXFTMiahlb2C2RClAiipO2Mvr0obsYB2XgqwFK07/lzP68bpWxqcWHUAaGiIkS5QaiAe3KkWobG3U5Po/kgZ95Lctgd61Z0LRoGIukQ8p2S7veixR0p1sK42Q++aYY8xzk9BCySnl0y0ty/o7P/2oshroMrTIL1tTMbuSt2BU1RMI500qPSt/1TC9geyVUpWzToMYtiibXNwjAOYb/+RVVcqqGxx517tQ0nNG0cqgn7QnfW407rFeUiWE7BlVVLvGU48qRRUk9rkpRLOlo+UScyJnuC5LNh/Q0X6OxBOcBcwExKDaQfP8pQrfrG/KkGV4DS9HuiEir68bbRq/QpVIyQHBlq1bGR9OUSesVG628MGdAlv9svQ/hPwTFpbDiFNOMnfPdzNsB/Jt9N
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1154.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(41320700004)(1800799015)(7416005)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WHRKc2NEZjMya1hub282TllnY2FZcTF0cmI4L3ovaDlDb3VtMXYxb0k5dHBq?=
 =?utf-8?B?VDdMMGZ6Y2M5S2pBVTJoMDg4ODJvWllCZFB0MG9Na0Y4YU56Q1pQcTlscnBh?=
 =?utf-8?B?Ym1oMGtkcWEwODAyVUh5K2JHSGRmVWVBMjA4UGpIMXJWVHZxOTZsSEsrZkVu?=
 =?utf-8?B?SERGNnBWQmlWWlprSDkxSGQ1U1lSeHppQVkraWFKWlRSSXdNY01UZ0JJdmZ5?=
 =?utf-8?B?SjlDeGRDRkdnd3Z6cm1keEYrWFBIbTdrbzhQb256K3NTVTJCNWJUQ2JVNWJt?=
 =?utf-8?B?TWZIeW5RakdQb05XaHFndUdMbjIzWnRVQ1NDMnlVOUZncjUxWTdycituUFo2?=
 =?utf-8?B?MmpRYkNiRmZvSzZXZ2V0NElISVo5VjREQzNCS3JwY1RKdjFtQllLQmtiaTcr?=
 =?utf-8?B?NGZHZXUxcm1zSVR4angwaXRLMUNieFgwZzA0bEdrdFpuR0toZnlVVEFhRElq?=
 =?utf-8?B?dXNPOWZRbUhMejlnQlJmN1dhdzd6M0ZrWVR0RE56c1ZRTTZDdFEwRTJhek55?=
 =?utf-8?B?QkJKSFFOU1dBT0ZBZ2tzMTcwN1JmOEs4RE5POXFGVis0WHp5QkdOcWRoRHJG?=
 =?utf-8?B?YzlzMWhZMldYOG4zaVd6MTJNOFlTTEw5OGFlSWFqN1NpcU5mQnkzZ0VoTWpC?=
 =?utf-8?B?VzdKNDZxMlp5WERzYUw2aFNLcEtiZGtwZW9GVk8yWDk5Vk1FanpJU3RVN1lQ?=
 =?utf-8?B?WEM2cVkzejc1eng4YUNuMXFIT05DSllhTWxLdVE4VkIvbWRBemlCTVNidjZ5?=
 =?utf-8?B?RnhvVnB4eGUwa05NK01OKzhJZ0FmT0N4SHJwMnA1TDVTYW15TFZTdktPMDl2?=
 =?utf-8?B?ZHNHemJFUzFRNkE4QTJlQnZKNHhIcm4rcFVmdkRyQ0g5Yjd0bklRbjJBc25i?=
 =?utf-8?B?ZFVxSXV0TUR6NzZwQk1hR0ZQU3RwRlhhNnk5VUgxQmxFTGo1bkg3Yk5UNitE?=
 =?utf-8?B?QmU4UUFDaWdEYStnemFlelE0Z1BZL3RVbjFGUmFqd2N2cW1RNUdkdHdnMWxJ?=
 =?utf-8?B?UXdnbThzYlh2bmcvWFBIdldXeEpZbWxLc1NteThPK1lOSWhVWXhNaE8rWlZw?=
 =?utf-8?B?WFZ0U1lHNUtuVW40dkRBQTc2VnI3YlBuc2NFT2FBYTRLL3NDbjA0K3lZN0dr?=
 =?utf-8?B?UGlZS3dpT0FwOWQ2Sml6dlljUmI4YXF6QzBnZm5LLzNhNXptUlNRY2Y3WDFJ?=
 =?utf-8?B?NFRZU2tzUW5sK3hNTjBINzRUQkFud3hJVHExSGhzQUNJSEV3ZURWcXowN1pa?=
 =?utf-8?B?eWg5T2pGeGNXQWNoeno5cjFOMGJFTGkvSlh6YithNEVXV3NTeFl0NWdyN1FS?=
 =?utf-8?B?YVZmWndZRHIwSjZSazZjQmhYQWdpTThCSk9vZWhUdmVXN2ZOZE5uMXg2WDBo?=
 =?utf-8?B?YkVRc1FkYUk1clJLWUxsclZUZ0lURkZ5Zkx5dXEwQWd5S3pxMjRmT0FtdDZX?=
 =?utf-8?B?VE9BODhJa3Ezd1F2bGEvL0c5VXg3OWVic3hjbkZRS1FKcFArYlVRd0xVQ2pJ?=
 =?utf-8?B?NkZQRi9nMnphelhNQWV5MjVRWjNyUElMZnZZZlNzaWF1ZWdYRytwKzFqUWh6?=
 =?utf-8?B?RGRQdVEyYUcvWTlDSURPWXA5U2MzalJDUTBJYTR0cWtEUUVpSVpucmI1UHA0?=
 =?utf-8?B?TFZiODhLK2FPeVdoOE4yUFhoWGR5U1JIaDBmVXpBc1c1M3poMnNJdzRjRDVq?=
 =?utf-8?B?M3AzL3kvSUw0UzdSMVBhdUtScXViczNMRFJnVTc0SVZTQkcyRHRUOUZqVUtW?=
 =?utf-8?B?VlpaSTJqb3E2d1FkbkZ1VXVPbmF4Rmo3RVhHdHppRkF4M3FObnpKUTFkbHds?=
 =?utf-8?B?dGFPc21QZ2MwMmFnSzNVbFJoMUJTclRqdUtuQlpJRGdiU1RMSlAxL1QzOTNM?=
 =?utf-8?B?QlJRTjYrTmVnK1pWYzNHK3pYQldCdnd2YUc0K3JYVEl4VUZvQ04xQVp4TERZ?=
 =?utf-8?B?azBrVFYwV2IvOXBlUnZWQWNsQVVtamE4blBkOHNvY2xlQVRsZHk1VmdFb040?=
 =?utf-8?B?ZnZETmxTVXFxVXBXc0UxUnJPcVRQR1ZpMUUvREF3MHZkNjNBUHUwT0JDU2xH?=
 =?utf-8?B?eG5Mb0tOdjU1czc1NEllOFRMa0h5Wk9mUnZsTTA0RWtJcjRyOEcwMkllQksy?=
 =?utf-8?B?cEdKYTFNd294S1h1Mm04dFBpNGdvMmdzK2JNZ0xrWEdITGNmeU5UTm9mNjVK?=
 =?utf-8?B?MVE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 60ba3ba4-991c-4b3e-17cd-08dc6aa786e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2024 12:58:13.4807
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WsqAAvMNrbtKCr5rS9opy3EfQDDRYTjHtSrz7kSNnmGlXE2F08dKCSf3KZO9El501AUykJjSWMT+eeP23NLXjoizn6C1Qrq2rwNrJmJSaTw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1235

PiBPbiAwMi8wNS8yMDI0IDE0OjQ1LCBKaVNoZW5nIFRlb2ggd3JvdGU6DQo+ID4+IE9uIDAyLzA1
LzIwMjQgMTI6NDgsIEppIFNoZW5nIFRlb2ggd3JvdGU6DQo+ID4+PiBEb2N1bWVudCB0aGUgb3B0
aW9uYWwgcmVzZXQgY29udHJvbCB0byBTUEkuDQo+ID4+Pg0KPiA+Pj4gU2lnbmVkLW9mZi1ieTog
RW5nIExlZSBUZWggPGVuZ2xlZS50ZWhAc3RhcmZpdmV0ZWNoLmNvbT4NCj4gPj4+IFNpZ25lZC1v
ZmYtYnk6IExleSBGb29uIFRhbiA8bGV5Zm9vbi50YW5Ac3RhcmZpdmV0ZWNoLmNvbT4NCj4gPj4+
IFNpZ25lZC1vZmYtYnk6IEppIFNoZW5nIFRlb2ggPGppc2hlbmcudGVvaEBzdGFyZml2ZXRlY2gu
Y29tPg0KPiA+Pg0KPiA+PiBXaG8gaXMgdGhlIGF1dGhvciBoZXJlPyBXaGF0IGFyZSB0aGVzZSB0
aHJlZSBTb0JzIGV4cHJlc3Npbmc/IFJvYiBhc2tlZCBmb3IgdGhpcyBsYXN0IHRpbWUuDQo+ID4N
Cj4gPiBGaXJzdCBTb0Igd2FzIHRoZSBvcmlnaW5hbCBhdXRob3IsIHRoZSBzdWJzZXF1ZW50IFNv
QiBtYWRlIGNoYW5nZXMgdG8gdGhlIG9yaWdpbmFsIHBhdGNoLg0KPiA+IElmIGludGVuZCB0byBv
bmx5IGtlZXAgdGhlIGF1dGhvciwgdGhlbiBwbGVhc2UgdGFrZSB0aGUgZmlyc3QgU29CLiBTb3Jy
eSBmb3IgdGhlIG5vaXNlLg0KPiANCj4gVGhlbiB5b3UgbWlzcyBDby1kZXZlbG9wZWQtYnkgdGFn
cy4NCg0KVGhhbmtzLCBJIHdpbGwgZml4IHRoZSB0YWdzIGluIHRoZSBuZXh0IHJldmlzaW9uLg0K

