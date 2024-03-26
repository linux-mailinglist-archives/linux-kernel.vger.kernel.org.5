Return-Path: <linux-kernel+bounces-118414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E59ED88BA72
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 07:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CDBCB23C57
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 06:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF0B130AEC;
	Tue, 26 Mar 2024 06:29:48 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2108.outbound.protection.partner.outlook.cn [139.219.146.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690D112DDA4;
	Tue, 26 Mar 2024 06:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711434587; cv=fail; b=pJW9p6fj0E/gvXf+tsQ2K4SAc/9mtxOrro0zpgLydCiZbEiNYVvagvrN/mld+CGtjLSjYdo79elecZAMtrmeXk0cK07RJTumDaAcBnVlmh4dxehG7WLwoIl69+sbtoIQFhAQrPpo9/2jn3CRHy7OYxi9HVVZGbf0TnQNHQaxbjs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711434587; c=relaxed/simple;
	bh=6HnPBoNSN+s+R5SLPVm2G/8jY0jSkAAqo4rYTXj34Nw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GE+Kxcs41RCwOnTgKLR1l59C7NrSBwvSZ/OVaO4fQCa0GvFPsaYaTnV/7KbPXdIM8vopt4wlfoDX8XhESD5L/Vtr+cBRvtOB3Y454yJXiV/VhUCskNgMmyeT0A4sicraFajPP2OAiP3T5sZ/BL28a72Bbr4YmXnWQAXdDxbUT2U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eBHfPbR5dgTVFKkw47//B1rBSRGNPJU3ixMg5T9fQqp0CrFSShLaQSxgCeL3YD4soFjjpihJLtri5dHSvfzVuo6WbN3YysO4wY9AdKl5MtNUNW/3nevLTUbWxetSZsW8zm7vlKHMVI0xQnkvf4t7dlKc3BqKc6sFvrqNamqQy5aVpk+UoaclS5zBN4nsGetRcuZLryWya98aRMVzyeLasRAyrtzWjhBAUtW989YjP3KFFub/7yz8bvfn9x0CYlLkvChb+5R5qV43MKdAL0syx3nxzMHuJCTFwX026m6+TWrypP8TgqYApjbWAkTmCBfvQtuF/o//yoq13Y+vwIc9wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6HnPBoNSN+s+R5SLPVm2G/8jY0jSkAAqo4rYTXj34Nw=;
 b=iYAuZwgdgzPD3aaMUaxmAJhVXqMsaStYN0hwZNwIcutSm9n0WNVaNVsFsM54NmvUjR7O9xRa+Y1wAnIyCbzmosWLqgLjFOvw/ARtC1tDSeFqChI7RMvoDK/3h1WBveyS/Zc1DLevcQCyqmvaA1CbUxgAodpe3xvwTulqSDEiqKDzLna0yNynhe9XiWV9+tCFeZJIkvSBHY4Z2Bm73RtqB8l8zngt13iSc/9e9bU+hJDMs1nM0zZ+NS+ULbFQVVmDHrppKmy/faB5BQ1QQXVd9Xx8aNcrGEPG4GLCMxB8p1RyOUf0vewquMn3YDmzA3vpj3Kig/0u6tSfKROa8sX66w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:8::10) by NTZPR01MB0986.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:b::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13; Tue, 26 Mar
 2024 06:29:34 +0000
Received: from NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 ([fe80::9a50:2c82:c5d4:2b3d]) by
 NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn ([fe80::9a50:2c82:c5d4:2b3d%4])
 with mapi id 15.20.7409.028; Tue, 26 Mar 2024 06:29:34 +0000
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
 =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjIgMS8yXSBBU29DOiBkdC1iaW5kaW5nczogQWRk?=
 =?utf-8?Q?_bindings_for_Cadence_I2S-MC_controller?=
Thread-Topic: [PATCH v2 1/2] ASoC: dt-bindings: Add bindings for Cadence
 I2S-MC controller
Thread-Index: AQHaeqVg8Gitft8lDUSWv/hm2rXn9rFB3QUAgAeCKEA=
Date: Tue, 26 Mar 2024 06:29:33 +0000
Message-ID:
 <NTZPR01MB0956BD6189974378958562D99F35A@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
References: <20240320090239.168743-1-xingyu.wu@starfivetech.com>
 <20240320090239.168743-2-xingyu.wu@starfivetech.com>
 <9d9efb8a-0b3c-4e7a-8673-07cd3b1f5f87@linaro.org>
In-Reply-To: <9d9efb8a-0b3c-4e7a-8673-07cd3b1f5f87@linaro.org>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: NTZPR01MB0956:EE_|NTZPR01MB0986:EE_
x-ms-office365-filtering-correlation-id: 2af0a3bb-f5e7-4747-880e-08dc4d5e1a15
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 DtQLk643jEA8gmIMnEiMrqDQ9h94FpsK7Liv74toKsCG0OpX2BnNwPLe0lUPoXrgfJsnR/vk3XyD/EaTVziRe3q7rqU8842Wvg/bK2LbxMBOZRUy+/y/Y5MO6zHMAkRktw/elOT4ZJdv/qrYnMh1fg/QfR6HHNW1/8m3PdDsQe4Yj3RmZV5ajIJTGJKUXMZULTIOexzBJf+Qqd8WnTIWhinGO/sAkAYX/F1IqkPcndEMfJRVWgkpSviPYSevBDFD54snT773o6z6foVtVyEIqle5p7X1VI6g6rpr6K4XrVNNPpZytJ0EnAMsYtxuE8z+yRyx0iIYv5F+AtUk7zCqISRyeocWt50cFry+LxMgwRsYYgj4+Ux3VI5PjCYIbZEkhWEUo3Mz0S5RCzEylyN0hdp0Wfelo/sabhjslf1tkCr97mgrkEo8XShPnFLZfeP4cmARQhMF65BmrF0fAD8A4V/0lpspaiC0zk1TZU+F3vMIcCtsxkHK7b4e24lAESzvQPXY801qXIBWLJYNYB3QucHv/YEMDwkaB7aZro3ERAr/c49+vuC6bYHgWjQFc+gpF2EAEaDzKt7yU+kelyj4z6PZg5iQx1e6HWPMIb8hFFifRVr4DTE3gdHdgbpXh2GV
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(41320700004)(7416005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dEJQM3ZEYWNjd3Z2WW1SUXErN01BcFYvdFJHNHF2UXhPMTVWQjI0TTdqYVVV?=
 =?utf-8?B?YnpnNjR2L1JLY2pCYVg5N24vV1QvN01SSlFCWVJwSjZ4M0pha1BIdUFwUWIr?=
 =?utf-8?B?UTYxTlU2cDN0UDV1SHl1SlBpVTlNSjFEWjBQbGx5dTBVY1I2SW5pSWlxcEVZ?=
 =?utf-8?B?VVBDNjZTTDRNdy9yMDJGbFR2a3BWRE1nb0thZFJYU3lxWXFKRzJIZzJaSHlS?=
 =?utf-8?B?SUVsMDQ1RXRpTnRTNFNKZkhpQS9lNjVxdE1CMjBVUVR1YTkza2l1S3I0L3Yv?=
 =?utf-8?B?ZXBJcjlkaSsyNXdhTWltZHJTQTlPMlczQzlvZHBYM1M3ZDZRSDhXUnlzNnhw?=
 =?utf-8?B?SU9FTUJKbHV6azVJampGaUwwNjVhVkVBVkZIeUNxSXpZdTNHdjlzQ0xJNUpM?=
 =?utf-8?B?NlYyZEs2bjJ1R0xxRmN1UGhDNDVGeW9uUlIySjBSbVZMVGRTeUp2MUpVa09H?=
 =?utf-8?B?QndkODZvRWVGbnp6ejFyMzU4eVhBb0ltRjdsbkh5RGloQXJUaWRBa2twSm0z?=
 =?utf-8?B?VXhQUVF3VDJzc1dqU0FpU2ZSczJGSU0zK2lWeUcrS2N2eW1Xb3pmaXVqU2M1?=
 =?utf-8?B?eEZiZUNUVkF6RWNIQlVXa3pHVVVpR0w0QnRjR244T2k1STU2YmdNM1V3UnhB?=
 =?utf-8?B?d09GbDFqSXBhaEtjSVVESyttRWp6K0R6QU43L2FrZGE4dUR4YnRTcXNhdmVC?=
 =?utf-8?B?MHE5RzJkaml0akE2ZHJiUzR0WC9uSmppTXA1T0ZoeXgxS0ZFbXhwd3NETFRT?=
 =?utf-8?B?OG1sWWNTSmlKSmdJTlNHMXY1bGtCeVZZR2lKMTBuOUhITkZxZHlmditUVW0x?=
 =?utf-8?B?Vm15ajNVWTlEeXRaWDBmNUYvTkZBTnp0bmRlNTR0dmEwY3ZSU1lZTEozbHVJ?=
 =?utf-8?B?V1FGMW9xUTVlWFhDNWo2dHlLUnRUK0dtK1Z1dnJ1MWQwTzV0b0Zob1BuYUxB?=
 =?utf-8?B?ckZvQlovRGwrM2FvV2c3ZVNSRUczN2sxcEo0eFp1S29iNEFRSzZMejVkdUh1?=
 =?utf-8?B?NVI5bG9TSmpKQmFCcnBlTUlObjBJWFprcWp5TmhBd3BVUWdVOHBLeGJxWmhF?=
 =?utf-8?B?emllaGd2cFdOTTZ0c3drS0NRSGlXQkdZcEx2Tm1iUWkzNEY0eFlYd1Voamgy?=
 =?utf-8?B?ZUp0dWNsZDJQT1d5QTRza3djckFGMzVFeEk3MDhEYnJ5UFljV1FXNFUvaGpQ?=
 =?utf-8?B?SkM2bkZ4TzhQWmJKTkVUUkJCck5xRForVzBTaGRuYzJGeDhuTklXYVJqRDBz?=
 =?utf-8?B?ZG9iSDViSnZPT0Y2UFhEZlFTZlhrWUJ3NGlkdCtIeE1GMENoWGJYVEVFUkhC?=
 =?utf-8?B?WURtWHN4UUVPR0hSVXpWN2VKajVsNGtBa0h5bkIrN2hyTGdKdWlpb3MzVUxR?=
 =?utf-8?B?WXAwQjVZQmVCTzljNHRjbm9lY1d2RzMrbktQZUdJZnRmejRReGxic2dqaVJF?=
 =?utf-8?B?VThrUVhMWENjc3FvVHJEVEJCWWtWbWFYU0VqTEFFTlBuaXlHUFVzWVpJTG1n?=
 =?utf-8?B?dUdWTHh1MS9oaWE3d0NjYUZGdGpHOExxNkNDRlRVK0pZSVNjOWlGS0pQZlN0?=
 =?utf-8?B?VEk1bHdOMnBnYUlTSkZkeGVrd24xbExIN1EwUEs4TkZPdkZFYnJqdUowSFE3?=
 =?utf-8?B?VXQxZTYwWWVjTlRQS3ZsdVk2YXN6RWw3QnBJV1hMbmZHU05PbU8vSThIKzVq?=
 =?utf-8?B?VGtGWXlJWWNKa2VJcE9vQWJpWjg3K0Fra0d3TnlueVQrTXFDZHlnaU85MHcz?=
 =?utf-8?B?aitodVhlTHcyeGloRThjM1YzaUZDd0thT296MVNwenVLaDhVSWl5K09kdVpW?=
 =?utf-8?B?NWl6bnNFMHBBVFZKU0pkZXVnblJTaHMvWFl2UzFjMFhBK2RwSEEyK2Jnaytp?=
 =?utf-8?B?MnUzc1pESXh2VzlrM0tJZjNkbjdUdXJpV3dSODdxdDVuOUJ5dXo2azJsNlVC?=
 =?utf-8?B?RnNCdndtME9FQitKNVRjWUxrUmJmTTlURERKSXF6SzFOS21zdzNsTFNlcDBK?=
 =?utf-8?B?ZVMzcWlOeitCQ1FIbkUyaHlHc2RNNGk2SDZIL2VxbVJ3RnArS2x3bGxETlp3?=
 =?utf-8?B?NHFiUHRBZXBqNm05eDBkQkFSTUVnbTBZNHBmbTdac1RNMFpjNkRhK2xoWmM2?=
 =?utf-8?Q?jS9EA0f/Or6Q9qdMAndCyjNNO?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2af0a3bb-f5e7-4747-880e-08dc4d5e1a15
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2024 06:29:33.9633
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6JvsDI/TA3W4yOkDBCbHrruo8eh3S9EtG+j9m7nsbtbbU9UxKDVHNnX4m/dWPe56lSWv5W3teycuZJtV1o9reS2u2AqWAnodwiHat/aKETQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NTZPR01MB0986

PiANCj4gT24gMjAvMDMvMjAyNCAxMDowMiwgWGluZ3l1IFd1IHdyb3RlOg0KPiA+IEFkZCBiaW5k
aW5ncyBmb3IgdGhlIE11bHRpLUNoYW5uZWwgSTJTIGNvbnRyb2xsZXIgb2YgQ2FkZW5jZS4NCj4g
Pg0KPiA+IFRoZSBNdWx0aS1DaGFubmVsIEkyUyAoSTJTLU1DKSBpbXBsZW1lbnRzIGEgZnVuY3Rp
b24gb2YgdGhlIDgtY2hhbm5lbA0KPiA+IEkyUyBidXMgaW50ZXJmYXNjZS4gRWFjaCBjaGFubmVs
IGNhbiBiZWNvbWUgcmVjZWl2ZXIgb3IgdHJhbnNtaXR0ZXIuDQo+ID4gRm91ciBJMlMgaW5zdGFu
Y2VzIGFyZSB1c2VkIG9uIHRoZSBTdGFyRml2ZQ0KPiA+IEpIODEwMCBTb0MuIE9uZSBpbnN0YW5j
ZSBvZiB0aGVtIGlzIGxpbWl0ZWQgdG8gMiBjaGFubmVscywgdHdvDQo+ID4gaW5zdGFuY2UgYXJl
IGxpbWl0ZWQgdG8gNCBjaGFubmVscywgYW5kIHRoZSBvdGhlciBvbmUgY2FuIHVzZSBtb3N0IDgN
Cj4gPiBjaGFubmVscy4gQWRkIGEgdW5pcXVlIHByb3BlcnR5IGFib3V0ICdzdGFyZml2ZSxpMnMt
bWF4LWNoYW5uZWxzJyB0bw0KPiA+IGRpc3Rpbmd1aXNoIGVhY2ggaW5zdGFuY2UuDQo+ID4NCj4g
PiBTaWduZWQtb2ZmLWJ5OiBYaW5neXUgV3UgPHhpbmd5dS53dUBzdGFyZml2ZXRlY2guY29tPg0K
PiA+IC0tLQ0KPiA+ICAuLi4vYmluZGluZ3Mvc291bmQvY2RucyxpMnMtbWMueWFtbCAgICAgICAg
ICAgfCAxMTAgKysrKysrKysrKysrKysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxMTAgaW5z
ZXJ0aW9ucygrKQ0KPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQNCj4gPiBEb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3Mvc291bmQvY2RucyxpMnMtbWMueWFtbA0KPiA+DQo+ID4gZGlmZiAt
LWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb3VuZC9jZG5zLGkycy1t
Yy55YW1sDQo+ID4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc291bmQvY2Ru
cyxpMnMtbWMueWFtbA0KPiA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+ID4gaW5kZXggMDAwMDAw
MDAwMDAwLi4wYTFiMDEyMmEyNDYNCj4gPiAtLS0gL2Rldi9udWxsDQo+ID4gKysrIGIvRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvdW5kL2NkbnMsaTJzLW1jLnlhbWwNCj4gPiBA
QCAtMCwwICsxLDExMCBAQA0KPiA+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiAoR1BMLTIu
MCBPUiBCU0QtMi1DbGF1c2UpICVZQU1MIDEuMg0KPiA+ICstLS0NCj4gPiArJGlkOiBodHRwOi8v
ZGV2aWNldHJlZS5vcmcvc2NoZW1hcy9zb3VuZC9jZG5zLGkycy1tYy55YW1sIw0KPiA+ICskc2No
ZW1hOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvbWV0YS1zY2hlbWFzL2NvcmUueWFtbCMNCj4gPiAr
DQo+ID4gK3RpdGxlOiBDYWRlbmNlIG11bHRpLWNoYW5uZWwgSTJTIGNvbnRyb2xsZXINCj4gPiAr
DQo+ID4gK2Rlc2NyaXB0aW9uOg0KPiA+ICsgIFRoZSBDYWRlbmNlIEkyUyBDb250cm9sbGVyIGlt
cGxlbWVudHMgYSBmdW5jdGlvbiBvZiB0aGUNCj4gPiArbXVsdGktY2hhbm5lbA0KPiA+ICsgICh1
cCB0byA4LWNoYW5uZWwpIGJ1cy4gSXQgY29tYmluZXMgZnVuY3Rpb25zIG9mIGEgdHJhbnNtaXR0
ZXIgYW5kIGEgcmVjZWl2ZXIuDQo+ID4gKw0KPiA+ICttYWludGFpbmVyczoNCj4gPiArICAtIFhp
bmd5dSBXdSA8eGluZ3l1Lnd1QHN0YXJmaXZldGVjaC5jb20+DQo+ID4gKw0KPiA+ICtwcm9wZXJ0
aWVzOg0KPiA+ICsgIGNvbXBhdGlibGU6DQo+ID4gKyAgICBlbnVtOg0KPiA+ICsgICAgICAtIGNk
bnMsaTJzLW1jDQo+IA0KPiBXaHkgZGlkIHRoaXMgYXBwZWFyPyBXaG8gYXNrZWQgZm9yIHRoaXM/
IFVzdWFsbHkgdGhlc2UgYmxvY2tzIGFyZSBub3QgdXNhYmxlIG9uIHRoZWlyDQo+IG93bi4NCg0K
SSB3b25kZXIgaWYgSSBzaG91bGQga2VlcCB0aGUgb3JpZ2luYWwgSVAgY29tcGF0aWJsZS4gRG8g
SSBub3QgbmVlZCBpdD8NCg0KPiANCj4gPiArICAgICAgLSBzdGFyZml2ZSxqaDgxMDAtaTJzDQo+
ID4gKw0KPiA+ICsgIHJlZzoNCj4gPiArICAgIG1heEl0ZW1zOiAxDQo+ID4gKw0KPiA+ICsgIGlu
dGVycnVwdHM6DQo+ID4gKyAgICBkZXNjcmlwdGlvbjoNCj4gPiArICAgICAgVGhlIGludGVycnVw
dCBsaW5lIG51bWJlciBmb3IgdGhlIEkyUyBjb250cm9sbGVyLiBBZGQgdGhpcw0KPiA+ICsgICAg
ICBwYXJhbWV0ZXIgaWYgdGhlIEkyUyBjb250cm9sbGVyIHRoYXQgeW91IGFyZSB1c2luZyBkb2Vz
IG5vdA0KPiA+ICsgICAgICB1c2luZyBETUEuDQo+IA0KPiBUaGF0J3Mgc3RpbGwgd3JvbmcuIFlv
dSBhbHJlYWR5IGdvdCBjb21tZW50IG9uIHRoaXMuIEVpdGhlciB5b3UgaGF2ZSBpbnRlcnJ1cHQg
b3Igbm90Lg0KPiBZb3UgZG8gbm90IGFkZCBpbnRlcnJ1cHRzLCBiYXNlZCBvbiB5b3VyIGNob2lj
ZSBvciBub3Qgb2YgaGF2aW5nIERNQS4gRHJvcCB0aGUNCj4gY29tbWVudC4NCg0KRG8gSSBrZWVw
IHRoaXMgcHJvcGVydHkgYW5kIGRyb3AgdGhpcyBkZXNjcmlwdGlvbj8NCg0KPiANCj4gPiArICAg
IG1heEl0ZW1zOiAxDQo+ID4gKw0KPiA+ICsgIGNsb2NrczoNCj4gPiArICAgIGl0ZW1zOg0KPiA+
ICsgICAgICAtIGRlc2NyaXB0aW9uOiBCaXQgY2xvY2sNCj4gPiArICAgICAgLSBkZXNjcmlwdGlv
bjogTWFpbiBJQ0cgY2xvY2sNCj4gPiArICAgICAgLSBkZXNjcmlwdGlvbjogSW5uZXIgbWFzdGVy
IGNsb2NrDQo+ID4gKw0KPiA+ICsgIGNsb2NrLW5hbWVzOg0KPiA+ICsgICAgaXRlbXM6DQo+ID4g
KyAgICAgIC0gY29uc3Q6IGJjbGsNCj4gPiArICAgICAgLSBjb25zdDogaWNnDQo+ID4gKyAgICAg
IC0gY29uc3Q6IG1jbGtfaW5uZXINCj4gPiArDQo+ID4gKyAgcmVzZXRzOg0KPiA+ICsgICAgbWF4
SXRlbXM6IDENCj4gPiArDQo+ID4gKyAgZG1hczoNCj4gPiArICAgIGl0ZW1zOg0KPiA+ICsgICAg
ICAtIGRlc2NyaXB0aW9uOiBUWCBETUEgQ2hhbm5lbA0KPiA+ICsgICAgICAtIGRlc2NyaXB0aW9u
OiBSWCBETUEgQ2hhbm5lbA0KPiA+ICsgICAgbWluSXRlbXM6IDENCj4gPiArDQo+ID4gKyAgZG1h
LW5hbWVzOg0KPiA+ICsgICAgaXRlbXM6DQo+ID4gKyAgICAgIC0gY29uc3Q6IHR4DQo+ID4gKyAg
ICAgIC0gY29uc3Q6IHJ4DQo+ID4gKyAgICBtaW5JdGVtczogMQ0KPiA+ICsNCj4gPiArICAiI3Nv
dW5kLWRhaS1jZWxscyI6DQo+ID4gKyAgICBjb25zdDogMA0KPiA+ICsNCj4gPiArYWxsT2Y6DQo+
ID4gKyAgLSAkcmVmOiBkYWktY29tbW9uLnlhbWwjDQo+ID4gKyAgLSBpZjoNCj4gPiArICAgICAg
cHJvcGVydGllczoNCj4gPiArICAgICAgICBjb21wYXRpYmxlOg0KPiA+ICsgICAgICAgICAgY29u
dGFpbnM6DQo+ID4gKyAgICAgICAgICAgIGNvbnN0OiBzdGFyZml2ZSxqaDgxMDAtaTJzDQo+ID4g
KyAgICB0aGVuOg0KPiA+ICsgICAgICBwcm9wZXJ0aWVzOg0KPiA+ICsgICAgICAgIHN0YXJmaXZl
LGkycy1tYXgtY2hhbm5lbHM6DQo+ID4gKyAgICAgICAgICBkZXNjcmlwdGlvbjoNCj4gPiArICAg
ICAgICAgICAgTnVtYmVyIG9mIEkyUyBtYXggc3RlcmVvIGNoYW5uZWxzIHN1cHBvcnRlZCBvbiB0
aGUgU3RhckZpdmUNCj4gPiArICAgICAgICAgICAgSkg4MTAwIFNvQy4NCj4gPiArICAgICAgICAg
ICRyZWY6IC9zY2hlbWFzL3R5cGVzLnlhbWwjL2RlZmluaXRpb25zL3VpbnQzMg0KPiANCj4gUHJv
cGVydGllcyBtdXN0IGJlIGRlZmluZWQgaW4gdG9wLWxldmVsLiBZb3UgY2FuIGRpc2FsbG93IHRo
ZSBwcm9wZXJ0eSBmb3Igb3RoZXINCj4gdmFyaWFudHMsIGJ1dCBJIGNsYWltIHlvdSB3b24ndCBo
YXZlIGhlcmUgb3RoZXIgdmFyaWFudHMuDQo+IA0KPiBodHRwczovL2VsaXhpci5ib290bGluLmNv
bS9saW51eC92NS4xOS9zb3VyY2UvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2UN
Cj4geGFtcGxlLXNjaGVtYS55YW1sI0wyMTINCj4gDQoNCldpbGwgZml4Lg0KDQo+IA0KPiA+ICsg
ICAgICAgICAgZW51bTogWzIsIDQsIDhdDQo+ID4gKyAgICAgIHJlcXVpcmVkOg0KPiA+ICsgICAg
ICAgIC0gc3RhcmZpdmUsaTJzLW1heC1jaGFubmVscw0KPiA+ICsNCj4gPiArcmVxdWlyZWQ6DQo+
IA0KPiByZXF1aXJlZCBnb2VzIGFmdGVyIHByb3BlcnRpZXMuDQoNCldpbGwgZml4Lg0KDQo+IA0K
PiA+ICsgIC0gY29tcGF0aWJsZQ0KPiA+ICsgIC0gcmVnDQo+ID4gKyAgLSBjbG9ja3MNCj4gPiAr
ICAtIGNsb2NrLW5hbWVzDQo+ID4gKyAgLSByZXNldHMNCj4gPiArDQo+ID4gK29uZU9mOg0KPiA+
ICsgIC0gcmVxdWlyZWQ6DQo+ID4gKyAgICAgIC0gZG1hcw0KPiA+ICsgICAgICAtIGRtYS1uYW1l
cw0KPiA+ICsgIC0gcmVxdWlyZWQ6DQo+ID4gKyAgICAgIC0gaW50ZXJydXB0cw0KPiANCj4gVGhp
cyB3b24ndCB3b3JrLiBQcm92aWRlIGJvdGggaW50ZXJydXB0cyBhbmQgZG1hcywgYW5kIHRoZW4g
dGVzdCB5b3VyIERUUy4NCg0KSSBwcm92aWRlZCBib3RoIHByb3BlcnRpZXMgaW4gdGhlIERUUyBh
bmQgdGVzdCBieSBkdGJzX2NoZWNrLiBUaGVuIGl0IHByaW50ZWQgdGhhdDoNCidNb3JlIHRoYW4g
b25lIGNvbmRpdGlvbiB0cnVlIGluIG9uZSBvZiBzaGVtYTogLi4uJw0KDQo+IA0KPiA+ICsNCj4g
PiArdW5ldmFsdWF0ZWRQcm9wZXJ0aWVzOiBmYWxzZQ0KPiA+ICsNCj4gDQo+IEJlc3QgcmVnYXJk
cywNCj4gS3J6eXN6dG9mDQoNCg0KQmVzdCByZWdhcmRzLA0KWGluZ3l1IFd1DQo=

