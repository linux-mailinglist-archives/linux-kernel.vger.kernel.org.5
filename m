Return-Path: <linux-kernel+bounces-37920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E2483B7B5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 04:17:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA544B24B09
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 03:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18CCF63D1;
	Thu, 25 Jan 2024 03:16:49 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2063.outbound.protection.partner.outlook.cn [139.219.17.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3051967C6D;
	Thu, 25 Jan 2024 03:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706152608; cv=fail; b=o/PKd0WmHxZxvyYqx6LqCZF2iPL25mxVbQX8T7NUvBNsvOGXU9OXbAeWh/Sz0a0eKUTswHgCA5eZ4qPmc3HNY16bAeT9iRj5We5ZBwE7gLdcsiBvyuFYBKE+Plhi4Ijz2JUIsDZsdNulEWrmSzPgqszlYKO2AOw5CmXiRDgALHI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706152608; c=relaxed/simple;
	bh=832Vri6esHWltU8H7x6yyregQZ0J5zzn1VmITOrIfA4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uIxfe/SK8WQh/4dm3sUMS2/d9Uk7a5CZmMt3fcfWmJyr8ybDJEvEPqG8yewHiapTbryN6UwAX9PfAVDBxDVkuiiepz4cUfRIS565gwQz/KkcVh7QL2Y7eVWlfG4/2OdJLzD1qysUxFDhj8NK5qWwl0bAOV5vEIB8lm/EnpWgipU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YAWucE941lx3ChUiRfyBf45kheOPenK1Zk57LlO6igec3JJ+xiBonvGZZ2g9hsObBxlhwTvsnPrsq5LwaYAacWBiFVhPiyIXrXvSFfcgJlxexpJFF+6VAcgC43/90CS5tP344UW5nYkHSYa59SsL2y5E/VPcP9t9eJGoyJLfLUiWCANlINGncjhz2cJFyYHIxNqSgX7ol+ngX8NEmiAObC5lyNIqGODl4wR0dIUywFON9jpS5phwj9WNSRd0xMUGEjuJJOMXRr1JANRQ2lNmVHBe8R4IyXgBc58IOUHP1GSs3wxXlG/PDYUsUwbOn/WWo4PvozDWMLYn4enMegeuBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=832Vri6esHWltU8H7x6yyregQZ0J5zzn1VmITOrIfA4=;
 b=I2uRxIRiDTL5HjKd7mthXGAuXjC1HRgKXqLb7me8TpLdZlGVy+tryMdYV76Ek/HROISRgN5msCed0y6OE/6JMJT20SDQFoeFLFtrbFTeembIwDW6bQhKGSmf8N51Uuv1DN9EbzVPpsCSQzFMycN7Q5kU36GL7SWVsDxR+S7eVOIlTCn8KrNo5ZiYSWvoePL4YIbGKmWA7I7MVtyftqGzCTdw0kovwtG1i50DfehhzgPpNaOG/5BQAhX6w0SGeVEmqLB3XYODnlcQmXQAslKeTkp4Y9FyJl3dbiBo4GF3O/FK+78Lz337ZL7oJCOE/0sLyEtU8kK2Ch5MgU26Uv2l8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10) by SHXPR01MB0623.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1d::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Thu, 25 Jan
 2024 03:16:34 +0000
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 ([fe80::148c:e1dd:302a:196b]) by
 SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn ([fe80::148c:e1dd:302a:196b%6])
 with mapi id 15.20.7228.022; Thu, 25 Jan 2024 03:16:34 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Philipp Zabel <p.zabel@pengutronix.de>, Thomas Gleixner
	<tglx@linutronix.de>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>
CC: Leyfoon Tan <leyfoon.tan@starfivetech.com>, Jack Zhu
	<jack.zhu@starfivetech.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject:
 =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjEgMi8yXSBpcnFjaGlwOiBBZGQgU3RhckZpdmUg?=
 =?utf-8?Q?external_interrupt_controller?=
Thread-Topic: [PATCH v1 2/2] irqchip: Add StarFive external interrupt
 controller
Thread-Index: AQHaRDZh/2LWzWpaAU6mURTXzltpKLDozg2AgAEioCA=
Date: Thu, 25 Jan 2024 03:16:34 +0000
Message-ID:
 <SHXPR01MB0671DDBA9FE68873819BEECCF27AA@SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn>
References: <20240111023201.6187-1-changhuang.liang@starfivetech.com>
	 <20240111023201.6187-3-changhuang.liang@starfivetech.com>
 <31bbe5787708b7de770cab96a9072fe6db39347b.camel@pengutronix.de>
In-Reply-To: <31bbe5787708b7de770cab96a9072fe6db39347b.camel@pengutronix.de>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SHXPR01MB0671:EE_|SHXPR01MB0623:EE_
x-ms-office365-filtering-correlation-id: a59e1241-b298-4863-ea81-08dc1d5408d6
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 c3zG0fRao9l+bBB/Dpu/BiRjPHjT1EHAtct4lWn+yDEiHmKp7VULNxGnHxSlvTkJTyayCGuUKjwjyAgdzGS7zR2pS1T0Ho0NIDn/syR7h4TaWtEOphotlXv6GCzsR2LFfJ5DHSg/k5KnPZvsOt479bgcYI2RUUqDrF86Tpiu+dUfjrfXSyuUf/c8IjWTDrrpg/0+5X2rbSkqHJt2A1L6iYpayXWknXAL65gLzkNCC6kbmxUG4sa+y95qcD4cQyK3RTPiGyVwll6QXpTCXR6U0k3wiy1OR/qNu5NzOwNna+aEfSiYlCfhVUNEs9zoLjsUB1dD7P+Uv2pkMy0fHYHk3E3qnp79aPaBWSW70Rhok7jhdtO73Y24BXdloLa6svYb99IF91kgTHgbqCO923ZK57eaXVIuHA2hrtXXjQCHPPBVN6eLJOb1rSn+QP3hd5IThk4sbKkuPIIQl8P3Mr7seoErkm106NL2FCnC5xQStMCx+kGH4sOqIOBg+vFZxx1kFYSrM2W/TonQ9oGPNztpDUDJkABpB1EDGwKk2qjjhEoZMh7QufYEeMwV/DV7ylO+
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(346002)(39830400003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(86362001)(110136005)(64756008)(122000001)(54906003)(76116006)(508600001)(66476007)(71200400001)(66446008)(66556008)(66946007)(38100700002)(26005)(9686003)(7696005)(55016003)(4326008)(8936002)(44832011)(41300700001)(224303003)(4744005)(33656002)(2906002)(40180700001)(5660300002)(40160700002)(38070700009)(41320700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ck50NkwxNXY3dnovQTlIU2RIa0pHVSs4OU1JRUZlS1FBQzJ5ZlkrSlQ3bWxX?=
 =?utf-8?B?VlQweFJmQTI5RGIzZlJsQjNLMlRXZU44TDk1QnVYaytENkNEUHFOWERNSDNt?=
 =?utf-8?B?NkJtTVJxTUtuRWdGZlJNVmxTem14UHFXa0ZIdk9EK05hUksxVEZZOHNPZzhM?=
 =?utf-8?B?aVhxRXpTOWZ3R3JRTnJNTmtaek1nN1czN3EvYjdINmdWblVhUmF6WUkzbHNU?=
 =?utf-8?B?MjB0YStvU3FJTnRIMDA1cE0xd3lYSjdJaEsxeWY5NnhLcXpsZVlEMkl4UE13?=
 =?utf-8?B?bWhJcG9tZjNneUMyMnJYOGFmQXZ1ck4vdVQ5NEFjRnFadkxIVTJOdE1iQVhK?=
 =?utf-8?B?Zzd1R1BPV1BiUUZ2OC9MblN2OHR1YVA4VzI0MGJaV2lBRmFKRFZicGpXY3JV?=
 =?utf-8?B?cUR5akZWSEZibW43ODNVWUQ5Y1cxY1hJNmtlUXRyeVE0K3BMMU1mcWNQeitH?=
 =?utf-8?B?Qm4xYnNnRGFLUW9mTFdRWjMyckI3MWl5YzZYdkRQOW1BRTREYUNCWTk1TUFX?=
 =?utf-8?B?OUN2UENUcncyQlc1R1RzN3FZdnVLTVc0a0cxRWNqZ01YeTErQWZtUHA3eXJ3?=
 =?utf-8?B?MlJzbkhDbThJVGdSSkltSlBmdmR0QWl5Y3dXL2xSc0xSZG0wbXlabGxSRlFa?=
 =?utf-8?B?NmR1RWdEaUtvZWdnQWFnTkVMTkk4dFR3bmJkdU1JUUVjbHlDT0pCTTNyRGhO?=
 =?utf-8?B?TTZ1dER3dXdOTVpJS21ILysxUVB2RGlERHpkV3lCSFpaWng2N2NlRnhTUmN0?=
 =?utf-8?B?TVJFZ3RXMVlyVXRMVWdEU09FS3VyYkhwTUVLZDhPSlVVc0N1MGdBSXc2MUY4?=
 =?utf-8?B?SXQzWi9xQmVyT09nWjNscTI5RHpNVEpOVmZEaThPQVRwVG1TRkozakFvODZ4?=
 =?utf-8?B?cTMxRnpwdzJSM09LK04yUW1Ma1d4Tlc0VitqSFlIZXhJNWxTMHRadjMrUUlS?=
 =?utf-8?B?aTlSbmh1N05xcW1oeEx0UDRwRnFKWXZnVzZWelE0dDhwdjZja0VGOXRQRmw1?=
 =?utf-8?B?K0hPek1xN1dBa1lUdHlaTnM3VjR5czZ0QnBjNVRkblNMeE52TXhkUGtwOTRm?=
 =?utf-8?B?bVpRb3NKQmd5VEsyTmVoMEh1ejRLUExac1hRK3FDNCt0Vi9RQXo5ejRkUzVv?=
 =?utf-8?B?MDR6S21mckhEd2hpVkhibkRmWGxBYWlMVEZRczBzT21pNE1pQi9HOHZzZmZS?=
 =?utf-8?B?TGk1K3hub3pvQ2NNSG5RbjVFK21Db2xWbnNTcFRXUXg3TlY5b3FPWmo5bUxs?=
 =?utf-8?B?NFl3cVpxdjhUNzRsTFRTemdoRUR4TnhGQlN2OWs2RkxaOWJaTHZlaVVGMHZF?=
 =?utf-8?B?VmNON3dHR0RLQVQwRHBSeVRuS3lwZzQ0NmlLYk1vSWFCdi9OczZGcERPSlRS?=
 =?utf-8?B?ZDlKcVJiQWI2bVRWZjNycGxlQS82VFROTjFFWmY0T2FIdkNWLy8wQytHOVRE?=
 =?utf-8?B?ZFhiTlRrZ0E5a0habzJqREN4eUhqcm1kb0NaWmFLYnVVOWw3eXpXUFZPeEZu?=
 =?utf-8?B?bUJPWHl2ZkRiY1JXanZTMUhLVW0relFUaG8rMzg2MlhjaUNDOUVjclhhMm9t?=
 =?utf-8?B?VkdTU2hKUEkxeHRXUm9MRU1vcmllNDFvNEw5eEpnc2Izakc5OFp0ZVZBTmRC?=
 =?utf-8?B?YzZzeUswUGdqZG5GbHd2cnVOWlJwSUx0d0RZc24rV1lNbEgzdURyY3NQVXRX?=
 =?utf-8?B?eS8vSHA5TGlHbUZLOVhZOFBzZzlrWGs1ZVpKWERLSUpZVjQwSGwxR1gzaXFq?=
 =?utf-8?B?QzAvK0pWakhoVkptKzhJMk1paGxMd21RSXpIVHhseEhlcmZuR3YyTmdkc2xN?=
 =?utf-8?B?eXVDazlXanJzWVYwLzMrZlhFUEpDSVk4Z3RiVVFKejNpWkx3Nk13WXkwNkpj?=
 =?utf-8?B?S21EVUFZblVlemh6a1l3d1krTFVNUTVDaEl2UmpSM0twNDFCZ1NyWURzcjh1?=
 =?utf-8?B?NXN1WFZZcnVMOTZTR1Y4Q3R1ams5VncvU0YwM2d3dkc5MExydWY2UVd4ejJT?=
 =?utf-8?B?ODZpVFlrMmRFN1IrTzV6bUdWQUtVMGZhczFMZzJPSTR6YjczTkdRKzc4aWRG?=
 =?utf-8?B?SjRLb2ovRytXMGI1eVQzdVV5U1BGenpuZHRuQzd6S2s0blJCamtibmFjb2Zq?=
 =?utf-8?B?U1B5VFN6RmhiUTFtMWtDNDloZHRRWFdGT0x2VnNabHVCREtTZW5VeFQ2WUNK?=
 =?utf-8?B?M1E9PQ==?=
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
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: a59e1241-b298-4863-ea81-08dc1d5408d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2024 03:16:34.2344
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wefF95m9rPWM+QmsxL+Ze+qp1JI8idQmO2QNI/dJ+XW+vgxhMdKM1htWz4GcmWaz35F3f+N42VADLc8XOBSkOu2ggZLAb9JXC/t1hKToK8am60bNVDYavXuZMUuhqBL/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0623

SGkgUGhpbGlwcCwNCg0KPiBPbiBNaSwgMjAyNC0wMS0xMCBhdCAxODozMiAtMDgwMCwgQ2hhbmdo
dWFuZyBMaWFuZyB3cm90ZToNCj4gPlsuLi5dDQo+ID4gKwlpcnFjLT5yc3QgPSBvZl9yZXNldF9j
b250cm9sX2dldF9ieV9pbmRleChpbnRjLCAwKTsNCj4gDQo+IFBsZWFzZSB1c2Ugb2ZfcmVzZXRf
Y29udHJvbF9nZXRfZXhjbHVzaXZlKGludGMsIE5VTEwpIGluc3RlYWQuDQo+IA0KPiA+ICsJaWYg
KElTX0VSUihpcnFjLT5yc3QpKSB7DQo+ID4gKwkJcHJfZXJyKCJVbmFibGUgdG8gZ2V0IHJlc2V0
IGNvbnRyb2xcbiIpOw0KPiA+ICsJCXJldCA9IFBUUl9FUlIoaXJxYy0+cnN0KTsNCj4gDQo+IENv
bnNpZGVyIHByaW50aW5nIHRoZSBlcnJvciBjb2RlIHZpYSAlcGUuDQo+IA0KPiANCg0KVGhhbmtz
IGZvciB5b3VyIGNvbW1lbnRzLiBGb2xsb3cgeW91ciBhZHZpY2UsIHdpbGwgY2hhbmdlIGluIG5l
eHQgdmVyc2lvbi4NCg0KcmVnYXJkcw0KQ2hhbmdodWFuZw0KDQo=

