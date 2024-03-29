Return-Path: <linux-kernel+bounces-124099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1EE891238
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 04:56:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CEEEB23394
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 03:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1990239FFB;
	Fri, 29 Mar 2024 03:56:45 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2122.outbound.protection.partner.outlook.cn [139.219.146.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AEBE3A1AC;
	Fri, 29 Mar 2024 03:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711684604; cv=fail; b=LILZ+6IRHVsfEic/uFufL9HRhuCk++b4rBDMDmfu3cTcJSnB43WD8P1DbUq9WQ/6XzBhe/ePIUSUO3AvC12wZjNT8kYLvCZSCYQqxCmfoPkPzZaWeIo7cHuaQPvuAwgTPva9RjDVb67JmkcSr8ruP8+0PqCXpSOJaC/9darYvNU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711684604; c=relaxed/simple;
	bh=fSmzAzW/yhBfBrI/ZNtDmVcTkO4oJGV18hR43XtgW1M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Gcsr8fQZDq80T1ZVpZJxR0yVhg1n82hL0LZ7lvM5zEQI5LBa8PUkJvOwP0btoHSAZdGkyN41jz3AKOYKKj/YtrFBIu+tYJNGzySnRRoNWxwKHk+vmkzYqNTZfRhT/59ikunIMfQbZwHRxBtWC7oqPJOB8jaqVgkAjVVkw2E4BCk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IPoLKCWqT11y/8r33yaIJ9Ejb8sBF7RWNeMsn1ZaWQRR/3sWljhaO9tBmt5P/48aVcAnpn12lwLM+chOkRWWD2TFscKP9ZYzThHjy4BDIdElOho62J9ANP3Gol0rOSBodQsNCphURo3iSlZl9maOHmF1ukgByFfpmJXE1yTBwQCWc8rqeb4QzIkOb9adT1CK/pv6JmMwY3Oo2ad7RoSS8yyldZnjxJlEornkcFi6Z+1luMAylHAGBInbAxSPIULxs074wzTLHghD4pLHNUzHrAolvYmdWivaaw467rmjUaFcGZp7OaSNP0o++MFUTnNdJtfLIxiAuf5/5H5BLtf6BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fSmzAzW/yhBfBrI/ZNtDmVcTkO4oJGV18hR43XtgW1M=;
 b=PxeN6L7qBZ6y/r71sv3QrabPL77pIDJUngobvHPhAfnbnQtFqqMFNP8ofeqkWMf8fWORDsROTOAj5ytUPnvLSzFfTbxBuWgtamDy23FFnnTkDT8Z6ESXXnvGlDULhH4MXuCzS/g78G+kfHwgNR5qA50pwwOvEVGdGnTWuJOdpjFlZyMWwuUxAfeqXKmITtMf+JYsnzmPc2uagzeF9ITAclmxraTEWsskZFKa0D3Cc8GUG7rrXgB/+MCUJl+h1/4Y91QmodqXXHSON0SI6bxykI6JvgvgBFXvYXfannHcAA1qUUFy6NG4QparG4WjBfAZhx2xpi+yCIQLtwVGr7VkKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:8::10) by NTZPR01MB1049.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:a::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.24; Fri, 29 Mar
 2024 03:56:30 +0000
Received: from NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 ([fe80::9a50:2c82:c5d4:2b3d]) by
 NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn ([fe80::9a50:2c82:c5d4:2b3d%4])
 with mapi id 15.20.7409.028; Fri, 29 Mar 2024 03:56:30 +0000
From: Xingyu Wu <xingyu.wu@starfivetech.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Liam Girdwood
	<lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Claudiu Beznea
	<Claudiu.Beznea@microchip.com>, Jaroslav Kysela <perex@perex.cz>, Takashi
 Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor.dooley@microchip.com>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
	"linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>
Subject:
 =?utf-8?B?UkU6IOWbnuWkjTogW1BBVENIIHYyIDEvMl0gQVNvQzogZHQtYmluZGluZ3M6?=
 =?utf-8?Q?_Add_bindings_for_Cadence_I2S-MC_controller?=
Thread-Topic:
 =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjIgMS8yXSBBU29DOiBkdC1iaW5kaW5nczogQWRk?=
 =?utf-8?Q?_bindings_for_Cadence_I2S-MC_controller?=
Thread-Index:
 AQHaeqVg8Gitft8lDUSWv/hm2rXn9rFB3QUAgAeCKECAAD4OAIAAZEYQgAET4QCAAv1iEA==
Date: Fri, 29 Mar 2024 03:56:30 +0000
Message-ID:
 <NTZPR01MB09563633F5C3B5FBC95D61289F3AA@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
References: <20240320090239.168743-1-xingyu.wu@starfivetech.com>
 <20240320090239.168743-2-xingyu.wu@starfivetech.com>
 <9d9efb8a-0b3c-4e7a-8673-07cd3b1f5f87@linaro.org>
 <NTZPR01MB0956BD6189974378958562D99F35A@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
 <9b1a5100-8536-4b59-b2e7-d6ebd2ba9e66@linaro.org>
 <NTZPR01MB0956230296D881F112F92D119F35A@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
 <16f72b4a-2aa9-49d5-a4aa-ed94eea1f32a@linaro.org>
In-Reply-To: <16f72b4a-2aa9-49d5-a4aa-ed94eea1f32a@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: NTZPR01MB0956:EE_|NTZPR01MB1049:EE_
x-ms-office365-filtering-correlation-id: c3a6e74e-fb30-43cc-6fd5-08dc4fa437ad
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 3HuJ/m2bTGEAM5S+LLsw7wFtRnzEaltQJzU12YPm0/01OVdtBNBFSgBWn5h8ECyMTU4uTyWWENzAP7pyeFZbPh4aoz+4LIxPNF6Mb2TdOoJNnZUdh6G1pZNyvOd2BWS9sOb9jdS4f5OCUvfUoTWFjtOs+qGvpWDP/fj8ChbjhL1A3CrHPwOlFiUoCXAdL3XWgMqpaeOQjrYgAWyo+uwZ7Ott5rm7Z/sXjJH9sd3SkZEhmZ1u1JwmTW5M0MxOT3T2YrV3ybcejCv6fja9jEiPA+4EiPMjULX43srLowDRZ2NafFOwExvv/inN5VVz4U1fQksUxRquCSlb+iffF81G5Co3rUaZPyALgMAWc57weL3fGjiVz/y6E8QuZ61Tb1dUXYAGSx6vzTbPetj6XdlCd5tBbBnK4Lp5M0+EifsS1s2iPgFXNRsdQNc/1JzIfzO9R0EY0uVJLdZG9aIrfOGo+CnsRufauOJ5lWiKJ+3CJJlPF1HRshxWgl6nJEUTsDPZO4/iZjXlHRYupIeeH0PvCuRGTNxiYWDqk+yzfo7MWMf/oxgKi7AY68T6S10an2jYC4cbNJgBLzX2fZP+ioo9iHXhYqKs0Olrd2Y35TieoACxPGqBoQYKjJ3x1iAvX3qu
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(7416005)(41320700004)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TGdKZHk0bk1XS3J2V1YxZ3cyZWIvZzh3eEFhVXZuUVNnQlBIK1k0ZVA0aWts?=
 =?utf-8?B?emd2eHN5YXJMVExGMkJsdXdyTlNuOWxCNTI5ZHRaWmI1SnI5MEo5VThOMmcw?=
 =?utf-8?B?dEV6eDZUbVpqNFY0TU1aaFA5VXhmTUVEQ3RSY3FEZUp5djhYSEIra3phbmlJ?=
 =?utf-8?B?MWcwTlQybTVWZnlUb0M1MTFFQndWSVNlR0FUNTE0bTQ2RUdYSHVDemR2eGlM?=
 =?utf-8?B?Rm1ldGZaVDltdHduWlpmdUhGM1ZNR1FXaTlWZmNNUzEzb1VENWlNTFFKR0sx?=
 =?utf-8?B?NGNxODdaWFczSGM3cGU2RFJxdmVucUFjbmJNQWNxSWluTVk2YmdRMlN1Y0Z6?=
 =?utf-8?B?SENBbllFUDN6b2M2TVdwR0MyS2R3YUdCSS9mS2Z0ZFVCTUw3bkM3enBYTEo3?=
 =?utf-8?B?Nk1ITGhwUHhUM0Y2YXlUL2RadnkxYlVkMkNDT29hZGRHL2gwZDJnSXdWMzNU?=
 =?utf-8?B?b0hvWjc2eklXdDEvNzl0NXR3a0dmbFdPV2hXd3QvN2FyVmpMcTB5TktUdGpl?=
 =?utf-8?B?b3pIYU5nQ0hPWlp2SE9OK0RaaEhqTFpvWCtWdUV4NUpTQVJEeTFOaEptRDNK?=
 =?utf-8?B?cTg4cXB3QStIUkF0U0srZWtSbGJCT0JuRXJ6NUlnSW9rUHN6QkplZUtnUDhT?=
 =?utf-8?B?d29UZEgyMlM0a3hvU2lWNyt4MWUwc0kwdFVwK1V5M29ZZTFIN1UxaE5XV1FS?=
 =?utf-8?B?aW42L09WdlBGOGs4TXNGdzdjYnROaDZpeXdsR2NQRDllVHVKZFIxRnR2dGhI?=
 =?utf-8?B?YXJOdjB4UTVPc1l1bzdyZkdXYW9McHpqVmorV3M3L2hRd1FMenhac0tTbTEz?=
 =?utf-8?B?bEc1NUN1SDlOZWJVUjFuSFRvK3FiVWI1QkV1ZWEzMGc4UW1QN1dabURWUHZm?=
 =?utf-8?B?QVkxeWIwbzlBUUhUU0RhYlZ2VEpMS3JqczRxRUkwVGYxQkd2ak5sVDNXQXYy?=
 =?utf-8?B?Q1g0bkpwQk9QQ0F4NW1aYXU5YVd3SGtPQ0o2OE5LSkhqdkl0QytKQndZei9Z?=
 =?utf-8?B?RjY5SCtqeTYycEhDdldJZU04OXlYUUZabVY5WG51ZXd5MEZDb1F0MTQ5eXYw?=
 =?utf-8?B?VmJEVllENmsvVEFldERseTc0V29rUzQ0T1NDczJqa3VTUXovSXkvN0phZWxB?=
 =?utf-8?B?R3JVZWt5eW0xSXpEOHk0d3c4ZEpmOHB3NklrSEhzQlRka0YxTDk1eGtFNHR3?=
 =?utf-8?B?TWNpRFpsWHAzdUFTTDF2UG0rby9HYlZOei94cnROMW9mYW1EWlFYSE9Da0lY?=
 =?utf-8?B?WXRoWGFLZGlzZ1NhSWJneXlXNkFMOStibjM2ZXF0bzZTNDZZdStoREZUdnox?=
 =?utf-8?B?ZUI2N09KbTZ5dDY0Rm9QRWlKSU8rSXVzcVROTVA0dHBEN0ZWM3NWUWhXc3p5?=
 =?utf-8?B?Z1VoZzFtbGxVMDlZMit1OFV1MmZJdEJxTWhUTnBJbUhKbTc2b0hxNHhZbnBy?=
 =?utf-8?B?ZGRXcjdTZnE5QitSVFZsRGpnQjJLRER1ZzVOZTMzZzBzVld5VExLd0x2UjZG?=
 =?utf-8?B?Z2pubkQ3UnJaVTJWOVgvZkovOUdNUlJxaUVNdTFIbHlzdUVYMUlta0VHeTdh?=
 =?utf-8?B?cnFFVFc3L29NS2ZoYStGSG9JT0FQTjVtSzJDUUlLeEU1RVdQU2F6a1cyRzZm?=
 =?utf-8?B?NlR5Z0xXZU1FZFFvaEZNaVkrTjd0a2NZL3QzOHZIS1lGUmdkTUR3dlN3bVRT?=
 =?utf-8?B?aUw4M3RTSS84NVUvNVd0ejBJT3h3RnFKbDcxcE51WGlKc2FyT3BBTU1Na0FF?=
 =?utf-8?B?Y0hrSC8yTjFEZHRGWVFmcDNMSml6M3dEb2UremIwcHRreS8rSWpwb015VlY2?=
 =?utf-8?B?V1BGb2VuUE5oKzlSZHIrdzl2OVZad0lXbDczaHdRVUFHN0dVam5jSWR5cEJo?=
 =?utf-8?B?YTc1ZXRsekhWd2h0andaTCtMU3BnMU02TDNaVjFmdlUwanVNbERCUXE0RnRa?=
 =?utf-8?B?Qnd6YnZUbkdMMDJuRnJmekxONnFudFVlb3o1YUNGVUkxL2R4OWgrTXRsQ0pk?=
 =?utf-8?B?VWhvTzN3cDZXdnF2U3ZadzU1YzROWVVvaXRJZHQzeWVFcFlvNDQxNytyaCtr?=
 =?utf-8?B?eXBtZUl6RE5admc5QXFmcm8rNi9MZi9WZWpDajlFN3RpU0tHTTFjNWFOV0hs?=
 =?utf-8?Q?/J09SE87y01UF23yOIXxegr6Q?=
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
X-MS-Exchange-CrossTenant-AuthSource: NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: c3a6e74e-fb30-43cc-6fd5-08dc4fa437ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2024 03:56:30.7032
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x52/a4I+i8Hq2g2xhMTTEcaFL+i22nrgCpv+LENCWhc06iGdoRXATH7hC8c2ObSN+MuDhbPuLTHsNs6TKMgMMX4g9xSNFfbhZm4ndH0warw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NTZPR01MB1049

T24gMjcvMDMvMjAyNCAxMzoxMiwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCg0KPiBPbiAy
Ni8wMy8yMDI0IDE0OjQzLCBYaW5neXUgV3Ugd3JvdGU6DQo+ID4+Pj4+ICsNCj4gPj4+Pj4gK3By
b3BlcnRpZXM6DQo+ID4+Pj4+ICsgIGNvbXBhdGlibGU6DQo+ID4+Pj4+ICsgICAgZW51bToNCj4g
Pj4+Pj4gKyAgICAgIC0gY2RucyxpMnMtbWMNCj4gPj4+Pg0KPiA+Pj4+IFdoeSBkaWQgdGhpcyBh
cHBlYXI/IFdobyBhc2tlZCBmb3IgdGhpcz8gVXN1YWxseSB0aGVzZSBibG9ja3MgYXJlDQo+ID4+
Pj4gbm90IHVzYWJsZSBvbiB0aGVpciBvd24uDQo+ID4+Pg0KPiA+Pj4gSSB3b25kZXIgaWYgSSBz
aG91bGQga2VlcCB0aGUgb3JpZ2luYWwgSVAgY29tcGF0aWJsZS4gRG8gSSBub3QgbmVlZCBpdD8N
Cj4gPj4NCj4gPj4gQXMgSSBzYWlkLCBpdCBpcyBub3QgdXNhYmxlIG9uIGl0cyBvd24sIHNvIHVu
bGVzcyB5b3UgaGF2ZSBvdGhlciBhcmd1bWVudHMgdGhlbg0KPiBuby4NCj4gPj4gQnV0IG15IHBv
aW50IHdhcyB0aGF0IG5vIG9uZSBhc2tlZCBmb3IgdGhpcy4NCj4gPg0KPiA+IEkgd2FudCB0byBr
ZWVwIHRoZSBvcmlnaW5hbCBJUCBjb21wYXRpYmxlIHdoaWNoIGNhbiBkaXN0aW5ndWlzaCBmcm9t
IHRoZSBKSDgxMDANCj4gU29DLg0KPiA+IENhbiBJIHdyaXRlIGl0IGxpa2UgdGhpczoNCj4gPiBj
b21wYXRpYmxlOg0KPiA+ICAgIGVudW06DQo+ID4gICAgICAgICAgIC0gc3RhcmZpdmUsamg4MTAw
LWkycw0KPiA+ICAgIGNvbnN0OiBjZG5zLGkycy1tYw0KPiA+DQo+ID4gYW5kIEkgd3JpdGUgdGhp
cyBpbiB0aGUgRFRTOg0KPiA+IGNvbXBhdGlibGUgPSAic3RhcmZpdmUsamg4MTAwLWkycyIsICJj
ZG5zLGkycy1tYyI7DQo+IA0KPiBDYW4geW91IHByb3ZpZGUgYW55IHJhdGlvbmFsZSBmb3IgdGhp
cz8gSSBhc2tlZCAidW5sZXNzIHlvdSBoYXZlIG90aGVyDQo+IGFyZ3VtZW50cyIsIHNvIHdoZXJl
IGFyZSB0aGUgYXJndW1lbnRzPw0KPiANCj4gTm90aGluZyB3YXMgZXhwbGFpbmVkIGluIHBhdGNo
IGNoYW5nZWxvZy4gTm90aGluZyB3YXMgcHJvdmlkZWQgaW4gdGhpcyBlbWFpbA0KPiB0aHJlYWQu
DQoNCkkgZG9uJ3Qga25vdyBpZiBJIHVuZGVyc3Rvb2Qgd2hhdCBtYXJrIHNhaWRbMV0uIElzIGl0
IHRvIGtlZXAgdGhlIG9yaWdpbmFsIElQIGFuZA0KYWRkIG90aGVyIGNvbXBhdGlibGU/DQoNClsx
XSBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjcxNTUyODEtNTczYy00OTNkLTk2ZmUtMWYy
OGViYjBjZTVlQHNpcmVuYS5vcmcudWsvDQoNCk9yIHNob3VsZCBJIG9ubHkga2VlcCB0aGUgY29t
cGF0aWJsZSAnc3RhcmZpdmUsamg4MTEwLWkycycgYW5kIGNoYW5nZSB0aGUNCmJpbmRpbmdzIG5h
bWUgdG8gc2FtZSB0byB0aGlzIGNvbXBhdGlibGU/DQoNCj4gDQo+ID4NCj4gPj4NCj4gPj4+DQo+
ID4+Pj4NCj4gPj4+Pj4gKyAgICAgIC0gc3RhcmZpdmUsamg4MTAwLWkycw0KPiA+Pj4+PiArDQo+
ID4+Pj4+ICsgIHJlZzoNCj4gPj4+Pj4gKyAgICBtYXhJdGVtczogMQ0KPiA+Pj4+PiArDQo+ID4+
Pj4+ICsgIGludGVycnVwdHM6DQo+ID4+Pj4+ICsgICAgZGVzY3JpcHRpb246DQo+ID4+Pj4+ICsg
ICAgICBUaGUgaW50ZXJydXB0IGxpbmUgbnVtYmVyIGZvciB0aGUgSTJTIGNvbnRyb2xsZXIuIEFk
ZCB0aGlzDQo+ID4+Pj4+ICsgICAgICBwYXJhbWV0ZXIgaWYgdGhlIEkyUyBjb250cm9sbGVyIHRo
YXQgeW91IGFyZSB1c2luZyBkb2VzIG5vdA0KPiA+Pj4+PiArICAgICAgdXNpbmcgRE1BLg0KPiA+
Pj4+DQo+ID4+Pj4gVGhhdCdzIHN0aWxsIHdyb25nLiBZb3UgYWxyZWFkeSBnb3QgY29tbWVudCBv
biB0aGlzLiBFaXRoZXIgeW91DQo+ID4+Pj4gaGF2ZSBpbnRlcnJ1cHQNCj4gPj4gb3Igbm90Lg0K
PiA+Pj4+IFlvdSBkbyBub3QgYWRkIGludGVycnVwdHMsIGJhc2VkIG9uIHlvdXIgY2hvaWNlIG9y
IG5vdCBvZiBoYXZpbmcgRE1BLg0KPiA+Pj4+IERyb3AgdGhlIGNvbW1lbnQuDQo+ID4+Pg0KPiA+
Pj4gRG8gSSBrZWVwIHRoaXMgcHJvcGVydHkgYW5kIGRyb3AgdGhpcyBkZXNjcmlwdGlvbj8NCj4g
Pj4NCj4gPj4gRHJvcCBkZXNjcmlwdGlvbi4gS2VlcCBwcm9wZXJ0eSwgaWYgeW91ciBoYXJkd2Fy
ZSBoYXMgaW50ZXJydXB0cy4NCj4gPj4NCj4gPg0KPiA+IFdpbGwgZHJvcC4NCj4gPg0KPiA+PiAu
Li4NCj4gPj4NCj4gPj4+Pg0KPiA+Pj4+PiArICAtIGNvbXBhdGlibGUNCj4gPj4+Pj4gKyAgLSBy
ZWcNCj4gPj4+Pj4gKyAgLSBjbG9ja3MNCj4gPj4+Pj4gKyAgLSBjbG9jay1uYW1lcw0KPiA+Pj4+
PiArICAtIHJlc2V0cw0KPiA+Pj4+PiArDQo+ID4+Pj4+ICtvbmVPZjoNCj4gPj4+Pj4gKyAgLSBy
ZXF1aXJlZDoNCj4gPj4+Pj4gKyAgICAgIC0gZG1hcw0KPiA+Pj4+PiArICAgICAgLSBkbWEtbmFt
ZXMNCj4gPj4+Pj4gKyAgLSByZXF1aXJlZDoNCj4gPj4+Pj4gKyAgICAgIC0gaW50ZXJydXB0cw0K
PiA+Pj4+DQo+ID4+Pj4gVGhpcyB3b24ndCB3b3JrLiBQcm92aWRlIGJvdGggaW50ZXJydXB0cyBh
bmQgZG1hcywgYW5kIHRoZW4gdGVzdCB5b3VyIERUUy4NCj4gPj4+DQo+ID4+PiBJIHByb3ZpZGVk
IGJvdGggcHJvcGVydGllcyBpbiB0aGUgRFRTIGFuZCB0ZXN0IGJ5IGR0YnNfY2hlY2suIFRoZW4N
Cj4gPj4+IGl0IHByaW50ZWQNCj4gPj4gdGhhdDoNCj4gPj4+ICdNb3JlIHRoYW4gb25lIGNvbmRp
dGlvbiB0cnVlIGluIG9uZSBvZiBzaGVtYTogLi4uJw0KPiA+Pg0KPiA+PiBFeGFjdGx5LiBIYXZp
bmcgYm90aCBwcm9wZXJ0aWVzIGlzIGEgY29ycmVjdCBEVFMuIEludGVycnVwdHMgZG8gbm90DQo+
ID4+IGRpc2FwcGVhciBqdXN0IGJlY2F1c2UgeW91IGRlY2lkZSB0byBkZXNjcmliZSBETUEuIEl0
IGlzIE9TIGNob2ljZQ0KPiA+PiB3aGF0IHRvIHVzZSBpZiBib3RoIGFyZSBwcm92aWRlZC4NCj4g
Pj4NCj4gPg0KPiA+IEJ1dCB0aGlzIEkyUyBjYW4gb25seSB1c2UgZWl0aGVyIERNQSBvciBpbnRl
cnJ1cHRzLg0KPiANCj4gSnVzdCBsaWtlIG1hbnkgb3RoZXIgY29tcG9uZW50cy4gRFRTIHNob3Vs
ZCByZWZsZWN0IGhhcmR3YXJlLiBIYXJkd2FyZSBoYXMNCj4gaW50ZXJydXB0cyBhbmQgRE1BLCBy
aWdodD8NCg0KWWVzLiBUaGUgaGFyZHdhcmUgY2FuIHVzZSBpbnRlcnJ1cHRzIGFuZCBwcm92aWRl
IHRoZSBoYW5kc2hha2UgaW50ZXJmYWNlIG9mDQpETUEgdG8gRE1BIGNvbnRyb2xsZXIuIEluIHNv
ZnR3YXJlLCB3ZSBjYW4gY2hvb3NlIG9ubHkgb25lIGJldHdlZW4gdGhlbS4NCkRvIEkga2VlcCB0
aGVtIGJvdGggaW4gdGhlIGJpbmRpbmdzIGFuZCBwcm92aWRlIHRoZSBzZWxlY3Rpb24gaW4gdGhl
IGRyaXZlcj8NCg0KPiANCj4gPg0KPiA+IENhbiBJIHVzZSB0aGUgY29uZmlnIChsaWtlIFNORF9T
T0NfQ0FERU5DRV9JMlNfTUNfUENNKSAgdG8gY2hvb3NlIERNQQ0KPiA+IG9yIGludGVycnVwdCBp
ZiBoYXZpbmcgYm90aCB0aGVtIGluIERUUz8NCj4gDQo+IERvbid0IGtub3csIEkgdGVuZCB0byBm
b2N1cyBoZXJlIG9uIGJpbmRpbmdzLg0KPiANCg0KQmVzdCByZWdhcmRzLA0KWGluZ3l1IFd1DQo=

