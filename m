Return-Path: <linux-kernel+bounces-96777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B086876151
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 10:53:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 201472840D5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 09:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67EDB54661;
	Fri,  8 Mar 2024 09:53:34 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2105.outbound.protection.partner.outlook.cn [139.219.17.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7F71EB5E;
	Fri,  8 Mar 2024 09:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709891613; cv=fail; b=hw9EnknHEAl7lv0f2AznPy0JJSaBFrRXivj6zzARh4AjWBpsubdBFrGy4W+HS3cQcs3FGuKXAwzdCn13ZFk3Uj+NkJKXxaQmge/6SouvHZ8ESnZIfC7dSERlUHRhQ1f6xLGhj6+/xZU0wObT6gXvnVP1tNYHFeXzwdYlO0ULv2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709891613; c=relaxed/simple;
	bh=SZq3FxVCPrnq8pQATRKRtPZo+owna8yzJejEEjmdSj4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IFLYtz+rN17kfp6EkmwFplk3xo8PosNn0nu2bKMRYWaYibwvG1Qn+0gomasg3QwmLF/DMPvfmvIM1/jVd9678O6w9y/RjmWJLx356J7/JZ6aqERumv/uzJGMkudIFwxQLsQ0TI3QdARLso7I4C50QDoJu0BFVxnJo2fznyNoARM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eqpR9Gifkl7qSkeJJ0Bd38xhjOil2I+T4iXvtcxEjDZX42/0qkpdDdghB5okkYfrj+aG4IBBcE3MsVaBAG5mNtt1pJorE23nV3ZeKp9XI1hN3X/7Bdu92hsUY5qy/Y7T0mCQzsbJDrUEoVxHHV1jjodquRfEFdMyyQOpILCsSyLSG8VcwCtMlj1ZHFTzs+7P3SvGj+/sK9SukarcyTH+EYAwNDB7ub7dUslT/cQcHKbFVfXIjK9iEXTcmoXgKEBXu+RUYwl+kceU1TuII57uq7r7kZ1xxFCekYxXbxY8Iv33adNaU4+2HilJk9ROTS6r+oJo4bvvX+kATHFXkWoBFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SZq3FxVCPrnq8pQATRKRtPZo+owna8yzJejEEjmdSj4=;
 b=hk52MRbk8aYaRvkGT2XWOmw1US3jK5BCt/vCBl/GkFUYsfBEB9DpN0VRa0baI8Fhoo62KHpibp+qH1JbKxzhB0qieeuSUIf+LAdbAElfGda/RwJpid5zc/C/Sc9uxCVFmfAr4evfu5cuuXrWGJKmotLmzUGgxmZjSUuswzHmkDXWC0jebr6CQpzFzqjL4pw95h9VBcNxgvBEZZMgxc6IzWD59TeZcuxZmkMDPATW5C+uxsg8sz4PzpuW+w+/GzWQyUnieBrRQAFQ1NuQMzMK2VChy8cSD/eio0GM3Tei24S3b6rMg/JreWbuhr5VVkwd4A1Ea7ctWRLcq//+rzBTkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:8::10) by NTZPR01MB1052.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:9::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Fri, 8 Mar
 2024 09:19:32 +0000
Received: from NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 ([fe80::20e3:6cc0:b982:ae95]) by
 NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn ([fe80::20e3:6cc0:b982:ae95%3])
 with mapi id 15.20.7316.039; Fri, 8 Mar 2024 09:19:32 +0000
From: Xingyu Wu <xingyu.wu@starfivetech.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Liam Girdwood
	<lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Takashi Iwai
	<tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>, Rob Herring
	<robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor.dooley@microchip.com>
CC: Walker Chen <walker.chen@starfivetech.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "alsa-devel@alsa-project.org"
	<alsa-devel@alsa-project.org>, "linux-sound@vger.kernel.org"
	<linux-sound@vger.kernel.org>
Subject:
 =?utf-8?B?5Zue5aSNOiDlm57lpI06IFtQQVRDSCB2MSAxLzJdIGR0LWJpbmRpbmdzOiBB?=
 =?utf-8?B?U29DOiBBZGQgUERNIGNvbnRyb2xsZXIgZm9yIHRoZSBTdGFyRml2ZSBKSDgx?=
 =?utf-8?Q?00_SoC?=
Thread-Topic:
 =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjEgMS8yXSBkdC1iaW5kaW5nczogQVNvQzogQWRk?=
 =?utf-8?Q?_PDM_controller_for_the_StarFive_JH8100_SoC?=
Thread-Index: AQHacEDAGfG0pG/sOEqzgeaavlmQAbEr6kOAgAGEjICAAAt9AIAADlpw
Date: Fri, 8 Mar 2024 09:19:32 +0000
Message-ID:
 <NTZPR01MB0956A8DCFEF13E4905D97B479F27A@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
References: <20240307033708.139535-1-xingyu.wu@starfivetech.com>
 <20240307033708.139535-2-xingyu.wu@starfivetech.com>
 <0b92700a-cf79-4f1c-986a-d18fe0151bb8@linaro.org>
 <NTZPR01MB095618FAFF22BDC301F69A0C9F27A@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
 <740b1f29-ab80-488b-b40d-3b8d95bc6c23@linaro.org>
In-Reply-To: <740b1f29-ab80-488b-b40d-3b8d95bc6c23@linaro.org>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: NTZPR01MB0956:EE_|NTZPR01MB1052:EE_
x-ms-office365-filtering-correlation-id: aaa8c501-9c48-4485-72f6-08dc3f50dd95
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 GJMeyrK+PLIjOqHC5kHr3o1UgAIXNeArzz4rpfCQrNvfzNfNz7gwjnbdTLxcZMYLx3mPAjK5L9W5I2xwv7PXsdb/d8UBafvYA3WciB7J3AocywmsXW+UfzE0ie0EcweIvf3RJ/nRLv1W+gCX9PCTDKcop/2e4joUC+b7robLshzBDL4zJVdGXv6r0cXEY23/nAPZKebZN6tz2jIW0tRW+0u3gger0Y+R6owSn1SkU0UmQ4de3x/RW8U76K7NHHNpdCF6eZJ8tf4rs0ip7ceHOr4ORBbpOPXfRbGQcpNwntPuyoefJIHZ4DeL3Qdigdv1XNXGTuG0SLarSIaDuBuqdValdKMKmTAEbiUr8raME5Vcn53H4+53lnKf8C4UlF5PL9Nwi3Mk2ouRcBzzq+qzAm6DNDpqF8rYNJYkGLQGXy5f3BEMQ6nK4Izi4SrM33e0xRHOI0kFVIa/jqGswGkBavQGsidy8fM1J4ccZibe3pqESAKxE59riMscK4LasxN2PEXbSrPmMW8QP9dvZiHvgjDMdp4gl9G5ev5d/T1N7JCMA/0rHuH+DtlX8/+KmXIOhOOCyrvXoGLUrD/9ZJ64uCMBUmqJ09LbPgNBQahr4eDngMFrwNpGD3gyufC9rDsI
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(41320700004)(1800799015)(7416005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ejJ2M1pTOHFSSGdYWGNodzEvT28yN2tsWjFHSmU0L0JKa0NRT0tYYzdrT1hp?=
 =?utf-8?B?aUplSXJLT1hCMEZSVW5RbFJWek9wbEdLSXZ3R1IwWEpSeHdPK0EwZmFscTc2?=
 =?utf-8?B?dHVhZklsV1dWYWh5TlJWa1ZZMzlPWWpuNytmanpoWGRiOWIzWUlhTnpLb21Z?=
 =?utf-8?B?U3dRakNrQVBoZHg2UXNMaEo3aWIxb0FLRnJ2T1NkYU5MaGFCQVBHcitBbzkx?=
 =?utf-8?B?VFFHUnQwQ0REQXVhRkF0aU9LWlIyT3N3QW80MHpoOFoyK1ZmNE1vMEZMUE5Y?=
 =?utf-8?B?ZnFNRVhzNnI5RnA4ZzN5Z2IvVzhORTBqOG5VNktKVWQwY2RLN1BaOW9MK0xn?=
 =?utf-8?B?ZHhUdFBPRzN5THJ3LytUZlE3QU9ETTViZXpwVzd3V2hBUndqRHR4SlFvd2dM?=
 =?utf-8?B?RFNkekN1QzhXZjdBRU5rV05DVi9sL0VOQXY2TDl0dkhiTDJ0a0ZVOFdCY0xB?=
 =?utf-8?B?aEtxTlk4NUphL1FBeTRBRFh2a3VKcnh2NzRPU1dGV3BCZ0hOdjVDSmpGOVRD?=
 =?utf-8?B?RHZoRGN6VXAzUlNIaWhMbmNNZnZzQVBIM1hheUVSbjlMYXlrUjNvZGF0cmlh?=
 =?utf-8?B?VysyVlFoTFhQQ1Z0YWR2aHl5WGdpYWxHV3BzTU5MbnIzczVIblpzVmx0VjQ3?=
 =?utf-8?B?NDBFS1dqTnBWZjFqV0hwcWNXYVFsWHR5NHU2V0dxNjd2RE40d3YyTlhDR09F?=
 =?utf-8?B?SnlmamJvRHJMUjY3bjZRNkRqUkJzVFlveElzODRxZDZyT2NKV3FTY0lVM1Ay?=
 =?utf-8?B?dWZsWHdWNk0vSmFJMXZqTUFtSm96L3EvN212TnJIektmVDZoUzJoZFVCWndu?=
 =?utf-8?B?aVY1YTlESSttb1pzbzFpOG96dkVhTjYxOEl2QTZBYlJ5K2syNkpJcGtYeUlJ?=
 =?utf-8?B?MDZtejZueU9GekRGWTRTWjBqeFUxcThuc0JUNzZZOTFmcFgwRiswUW13QnlS?=
 =?utf-8?B?NldscUwwcnQ0UlB5bTFpMDZlb25ZSUxEdlJyUEJPcEdoU0o3Y1VoU1lNaHVS?=
 =?utf-8?B?Zk5kdjBvV2ZoYWkyOXJDblRBdGZudTJGVy9hY1ArV1Z5aVdYa051ZGtZSVIy?=
 =?utf-8?B?MDJwbzFZWkFDajUxMGszbnBUdzZOR2RKN3dHbjgxa1BsQ3dyWDVaLzZoUHh2?=
 =?utf-8?B?eGdEVTFUTXgyd2grUHJwZDQyYzZWOHNCL1ZEY2s4Ujk0U2N6bVFONGVjSmRU?=
 =?utf-8?B?bzc2aHNoZjg5V3lWQzB3OFNLWk9FeGI4TkYwYU9rUEFMOGlCazlJbmI0a1RW?=
 =?utf-8?B?bmtqQmk0UW1ERlNzVSswRjg5OXpIbDVIL2VHa3d4aEFBMFFDTytnNWpQcnBm?=
 =?utf-8?B?WklqelQ0N0pDWStDcDNHdnFaMXk2TldIVFZPSHhSRzRjenIrRjloTjRTVkdi?=
 =?utf-8?B?ZWlJWGMzc3VjUTBxMjJ1a21vcmhkdElmZFVwTUt0M2VMa2cyWlQvRUtpWGtK?=
 =?utf-8?B?V1ovbmZmaHdyV2grK1pDcFpheDRXZHZtWGxYaWE3bXAvTEp0bkc1Z0pqbzBi?=
 =?utf-8?B?bjNtUVk3TWpKQmpjcTVPbjJWVWxaL2pMYzVuOVR3SnI1czJHRUFxUmdjQ2tS?=
 =?utf-8?B?N3VXdnR5d3c3Uk8vQ0RVYXZrK3owUzFmOTRqeldqM0xqdW44V0ZMRFhldHZk?=
 =?utf-8?B?YlAzTkRSbGlqQjFqS213bWcrekxBNTR4ZFZhQmg4Tm9CZE93aXJxdEpTdTZS?=
 =?utf-8?B?NVBobE9reFllRTFDdzB3UEt4SjFobXhKT2pmS0dORXQ2RUNWVFZuNHZkamFR?=
 =?utf-8?B?ejlxSXR3ZzIyU1o1b3dVZ1N1VVFsZjNVSVdxMEJuN1lodEw5bmhVU3dPN2JR?=
 =?utf-8?B?alB4ZytuanlpVENvaDFoVmEzVFBabWFIUWRwbEJWdUpIZmI0UTV2bC8xMVNn?=
 =?utf-8?B?UW5DV1QwN0oxVUVNaGFHV0VBbSs0Mm1xNWVkd3V1Y29xOGdHR0QvcTZ1U2Zx?=
 =?utf-8?B?ZU1lQWtDVXdKZ1VwSHJTMENJOTJNaGkzRUVnRlhESG5CVkNBNUFDQllLTjZZ?=
 =?utf-8?B?NVdJSjFZMDNvNnlWVHNLbnowT01iWEFVN0hFZ2E3Qk5oNUpSY29QazhOeEhT?=
 =?utf-8?B?U1Juc1ZZckRCMTRzNTNXSjRyWC8yMkpUWXBKQWVOM1UzYzJJWVVDNzkrTW9S?=
 =?utf-8?Q?rXYXrmvVa4CWljZRANbgZ/f97?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: aaa8c501-9c48-4485-72f6-08dc3f50dd95
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2024 09:19:32.7024
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wYL2PoWCZJpiOal0jHyV2yxFzo4hcnGsef24xjP7vznzyQIOOL1ZvoUi1y4LFshVdo1mFVKtJMfEkRR762Epf0je+W7QjmqkueRYCTuj/Uk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NTZPR01MB1052

PiBPbiAwOC8wMy8yMDI0IDA4OjQ5LCBYaW5neXUgV3Ugd3JvdGU6DQo+ID4+PiArDQo+ID4+PiAr
ICBzdGFyZml2ZSxwZG0tbW9kdWxleDoNCj4gPj4+ICsgICAgJHJlZjogL3NjaGVtYXMvdHlwZXMu
eWFtbCMvZGVmaW5pdGlvbnMvdWludDMyDQo+ID4+PiArICAgIGVudW06IFswLCAxXQ0KPiA+Pj4g
KyAgICBkZXNjcmlwdGlvbjoNCj4gPj4+ICsgICAgICBUaGUgbW9kdWxlIHggd2lsbCBiZSB1c2lu
ZyBpbiBQRE0gY29udHJvbGxlci4gRGVmYXVsdCB1c2UgbW9kdWxlIDAuDQo+ID4+DQo+ID4+IFRo
aXMgaXMgYW4gaW5kZXggb2YgdGhlIGJsb2NrIGluc3RhbmNlPyBJZiBzbywgdGhlbiBpdCdzIG5v
dCBhbGxvd2VkLg0KPiA+PiBPdGhlcndpc2UgSSBkb24ndCB1bmRlcnN0YW5kIHRoZSBkZXNjcmlw
dGlvbi4NCj4gPj4NCj4gPg0KPiA+IE5vLCB0aGlzIGlzIGp1c3Qgb25lIGluc3RhbmNlLiBUaGUg
UERNIGhhdmUgdHdvIGludGVybmFsIGFuZCBpbmRlcGVuZGVudA0KPiBtb2R1bGVzIG9yIGNhbGxl
ZCBjaGFubmVscy4NCj4gPiBUaGV5IGNhbiBiZSBjb25maWd1cmVkIGFuZCB1c2VkIHNlcGFyYXRl
bHksIGFuZCB0aGUgdXNlciBjYW4gY2hvb3NlIHdoaWNoDQo+IGNoYW5uZWwgdG8gdXNlLg0KPiA+
DQo+IA0KPiBEbyB0aGUgbW9kdWxleCBkaWZmZXI/IFdoeSBkaWZmZXJlbnQgYm9hcmRzIHdvdWxk
IGNob29zZSBvbmUgb3ZlciBhbm90aGVyPw0KPiANCg0KVGhleSBhcmUgc2FtZS4gVGhlIGNob2lj
ZSBiZXR3ZWVuIHRoZW0gaXMgYmFzZSBvbiB0aGUgbWF0Y2ggd2l0aCBJMlMuDQpUaGUgRE1BIGRh
dGEgY2hhbm5lbCBvZiBoYXJkd2FyZSBiZXR3ZWVuIHRoZW0gaXMgZml4ZWQgbGlua2VkOg0KUERN
IG1vZHVsZSAwIC0tPiBJMlMgY2hhbm5lbCAwLA0KUERNIG1vZHVsZSAxIC0tPiBJMlMgY2hhbm5l
bCAxDQpJMlMgdXNlcyBoaWdoZXItbnVtYmVyIGNoYW5uZWxzIGZpcnN0IGZvciBjYXB0dXJlIChs
aWtlIGNoYW5uZWwgMSksIHNvIFBETSBzaG91bGQgc2tpcHMgbW9kdWxlIDAgYW5kIHVzZXMgbW9k
dWxlIDEuDQpPaCwgSSBqdXN0IHRob3VnaHQgb2YgYSB3YXkgdG8gZml4IHRoZW0gdGhhdCBjaGFu
Z2UgdGhlIHByaW9yaXR5IG9mIEkyUyBjaGFubmVsIHRvIHVzZSBsb3dlci1udW1iZXIgY2hhbm5l
bHMgZmlyc3QgYW5kIFBETSBuZWVkIG5vdCBza2lwIG1vZHVsZTAuDQoNCkJlc3QgcmVnYXJkcywN
Clhpbmd5dSBXdQ0K

