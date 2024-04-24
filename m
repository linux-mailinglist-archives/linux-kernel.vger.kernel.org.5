Return-Path: <linux-kernel+bounces-156124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 773668AFE36
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 04:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBCDB1F23393
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 02:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F93134AC;
	Wed, 24 Apr 2024 02:12:45 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2118.outbound.protection.partner.outlook.cn [139.219.17.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F6E568A;
	Wed, 24 Apr 2024 02:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713924764; cv=fail; b=pzSPrGpMvyCDAE+OyYKyJoEloR4ktVrfu/gZNCTs5iulZf2iTRNVz3a+ODkjjIh2ZC565MIiWQa0JeKMBpXKVoIss9ZuXtamcj3KhbKs4Iz0Of1RW/Qf7Vq68keTguMCP3qwucl7ak+5gmN0D9idKcsRGx3B4K2GM0LiLQ4BUyw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713924764; c=relaxed/simple;
	bh=4WkCkTy8Z2u0nbmuuoLAI4WdL13klQMv3lwCHyD/PhI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=o9YxJHtCkPTMMqSvGRjZIExHPSZx7qXca5kv/DgsOqEj34zSDIHQ6veugj1lyeYB3aFgiAH2DDqsT/r3SN2pL5AH8uuBwtjfdOSLyEMhTgiQKvAqMlezKQAyQElghregqgflMM6stGkh4ULmXTp+XIHfyDooO6n5SChbeVjMg7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FrcSUIu9+PJVYgNmfGFCyPF7ks0O0luGdt0QbPqRarIO0f1tu2pKknCOCwOsIhpbBSyepk5lZh5+I+fkEPmDAFiBMw1AJPD0HXd06cVyVgOhEA80kHghJuIquYlFq17ZC7V3OE248xFNhImF47VnQIbWeZdg+vSGQ3jhtcGU47RAOyREsB7khozwoKFeAECZqM55RK4UqeVaw5lRtDQg8s6bTqEViUfxA1AKME0WNKcY6Kd4aAcfpQoivjc7HwWKCUe6prPFstEMaLCnTD8qntemgjVFz1OBB8aBWOVFXEuH7YkNosOrm3KG7YlkiO6YR4oci0SW2OEoHHZyo1eGWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4WkCkTy8Z2u0nbmuuoLAI4WdL13klQMv3lwCHyD/PhI=;
 b=PmISNVIDhVW1yhaorYiagJH/8d4j1XbolteIB3nyhLymZSBMb2nNea/X64DofXizVA70dCWaELZCFIyHGpF9YxOPF6JMw8I47bbQ5qfGThqiQSo+A05twSnAirVqbbKO3ZSqwftd6CUXa2vOYLMWlimRb9S1dFuwn6cJmjUVn3u3AlDe8/gEaorG3vVk5MPN/C0cTXaKcCJoP2/Vencrm/E2it7Dsr2CUzjPJ4AspG5CEl0rthd2RRnk341t6ItTfneF7QSC2aK1rM5AxX2aU/04qFLNWu9hV75YiS3uZxXUtOP2JRfzP+/N7gRi3ynKCdTC+uF1Z3FLsT1GpCrrjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:8::10) by NTZPR01MB1129.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:a::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 24 Apr
 2024 02:12:37 +0000
Received: from NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 ([fe80::e903:99a6:10b7:304d]) by
 NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn ([fe80::e903:99a6:10b7:304d%6])
 with mapi id 15.20.7472.044; Wed, 24 Apr 2024 02:12:37 +0000
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
Subject: RE: [PATCH v2 1/2] ASoC: dt-bindings: Add PDM controller for the
 StarFive JH8100 SoC
Thread-Topic: [PATCH v2 1/2] ASoC: dt-bindings: Add PDM controller for the
 StarFive JH8100 SoC
Thread-Index: AQHalVkH07xuCGa5y0qrTe+ETpKiv7F1nF4AgAEPpvA=
Date: Wed, 24 Apr 2024 02:12:36 +0000
Message-ID:
 <NTZPR01MB09562FCBC2D9F5CB4C5729A79F10A@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
References: <20240423083405.263912-1-xingyu.wu@starfivetech.com>
 <20240423083405.263912-2-xingyu.wu@starfivetech.com>
 <a5f8746f-14f8-4e56-9ac7-30c7ba6fad30@linaro.org>
In-Reply-To: <a5f8746f-14f8-4e56-9ac7-30c7ba6fad30@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: NTZPR01MB0956:EE_|NTZPR01MB1129:EE_
x-ms-office365-filtering-correlation-id: 4182fe87-69b1-4acd-5783-08dc640402da
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 xWWuS3PYnuLHnaKxbsmv97v7+zbFsLpOD/FrES2h/gUu4+9qr06ZrJZl6G80aucv27u3l9c0tQ3emlsO8ul+HywI/7VvuDFdFwKLqsLyfbiMQIkKk42G8guMA6kt9SQ9GQW+087TqIV4UsMu0F6pKQeBJAR/coi+EWrmgxmja8GlmkuivZeJHr980qrdonkU5V4KYgxaKyoPDJKNvwr2YHAt6G0usYibLdRjEu63+mqsGH10HKLb6oRs6ynAwdwXToKh5/IwEU/KTx2a+8JQayUUL2EOEw9+sTLwTcym+hG6VlXCdK8AyJpG/0LPQwk7E0psPRsb8ua3UWnDkemYFHDy9z3v+CFs7+wvp+xnHjtqUH6Bf8mfjOBSgnWuUUkruY5Jy3yWDHsF0/o+j7rIVKaWKBMWfa0gnIwmMna5EnGXmXPkuneSlJznF11t0EWLNPyAeCQXT8fCrF5uSwsWb4UgsYeXPq1ygWsXy/v3S6aUQiEPKgrghiojnRV71gP6CKJbD7bp/h8IGOwBPXmAzUxs+zlskC4AgZT3thxTWNXXay4oS90aICJUwg3Wp/ykeLxogERPdb2cM7GTIzitkVNtEzy8r3fL+Xt8wb6JdpT8vUPJNkmLQrJYSrdZB9o7
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(7416005)(41320700004)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZkpNQjFTelhTTjVwVlBjRmJSYWkwbFpDcm1pbnJlVlBMbzdsR0k2ZVhTbTVp?=
 =?utf-8?B?em5oSkZxNWdDdmhPaWZHVFNvYlJzTkdKbUFVc1FueXFQaU05ZnNPVlVuOVhG?=
 =?utf-8?B?a29Dc0JWU1ovS2NaS21iSS93U09lNmdYWE9NZ3Foc2d5UHVpWXdTRDJlMUt1?=
 =?utf-8?B?Y2g2bFZ2OHBRSWJQZ2FVOW44U2tjNENJekVlUGhyUVNtUXdsN01RVGpSa1l5?=
 =?utf-8?B?ajh1ZlRLM3VBK3VWUHJWeDB3VHl5MWxNN0JNZDNSNmZJZGx0N2hrNjZCVDBx?=
 =?utf-8?B?TlVXTVhJeFUrUDlWZnJDclZUVWNZZUdYekFGTEZTVEtpQkY2YmplUldZTkRx?=
 =?utf-8?B?T2JIeTYvd2ZJYUo0UEZIakI1eFA3aFNxZklOYmNpclordU1hSkdTdkRRZlBU?=
 =?utf-8?B?YzFIZWJPeUZXRGJVdWFqR0tPQUhTZlhNSW54bXFrR3hLRENFbi9mMFJ3eEVx?=
 =?utf-8?B?YWRnZU1maUxuSlR3Vy9wWkFmY3Y1K0hZWHNMSzU4eUNValhPUUJWUWJFdG4v?=
 =?utf-8?B?TTQ4aUFHaDNuVXh6QkhYRWtFdVNpeWltd3FlOGtIcnlobmhLSWFnN3hrTlZu?=
 =?utf-8?B?a0E0ekRSR2NNNWRCNkJWSWh4dUdjdHZ6LytoSVBUZGxFa1JGYU5BZWFQem9p?=
 =?utf-8?B?WlNKREp3TFlhNldKQ0hGeHczeFlhY3AwSGxPTFZOZFp0OXRuQWxFR0x3TGpy?=
 =?utf-8?B?VTNvVnN0VS8rMFJpZkMxSDQ1enJWWXRhR2VTcmZJRGZIOFlDVVFrS3NyQjhp?=
 =?utf-8?B?TVJpbDhaRm9hVk5CZUZFc2UveEg4TDhPeUxjR0ZmaUZjWHArSVk0RWN3Q29a?=
 =?utf-8?B?Z3FaY1Z2MmNCVm4vSU1tMzY2djVCU1l0M2NOYkgzYUt1MmUySXZDQlpDS04v?=
 =?utf-8?B?UExtKzFhUVFzaTA0SlVVb3I3QXdzVHJIaEdJdE9MVEV1RTJFc2RIRVhCcndp?=
 =?utf-8?B?cmV1UExxZE8veis4RjFKeFJwcFlNVU5UZDZBNldaQWZ1UEpENGR3cXlRU211?=
 =?utf-8?B?OWludVVKNTFXdDZHZ1I5MTFzQjUya01FRjRaZ3dPcVRtMUlyMUY2TzFFZU5p?=
 =?utf-8?B?N2VjVXpHd1Z5NyswTGxKSHVmQmE1N1BTc2pEcm9OdGxvTmFhL2NtVVUwdDBQ?=
 =?utf-8?B?eDAyZVl2dUE3T2dma3AyZ0YvK0syT3lUVXJKSHlhUTV5eDVtbUQ3d050ZnJS?=
 =?utf-8?B?amV4M05SZkdFVFdscVhOOW9GUTNHRjBMUnE3dVpkWDA1TDhOa2Roa21SWkZn?=
 =?utf-8?B?WnZOY2pDUHQ5VDhNMjB2WnI0bkZaVEZSd1M3QTNIMmFTMHMrdXU4R2FRT2ox?=
 =?utf-8?B?QVVFQktBVkJEMllzRXVKVW9vM2t6NnUyVnpHRXAvL2pTeTNGaklLdW9XTVE4?=
 =?utf-8?B?anZGdk5TSjY3anNQbU5sMUtOWXI3MzM4cnRwMTBMd29nVjZtUmhkbHl3Wk02?=
 =?utf-8?B?MEpXb0twbDJzTmdib2wwSW5VdHptUDBBNDdzVnlIWWk2VlVreVJHZHhhNjc1?=
 =?utf-8?B?d05QZ0dwOXlseWI2bkU1My93bkcydm1PeEl5SnVDWHJCcVZCdm9ucHNPdGFV?=
 =?utf-8?B?cVh1QVppVGtRN0ZlQTM0eHVCU2lMQUp3NmF4WFhmWUxkR0JVK3RSTGJ3SXZM?=
 =?utf-8?B?K3REdkxQY1ZKb2NTMUxoQjVFdE9kZTA5T2h0am9YNDZXaXBSQ3htY0EyVDBQ?=
 =?utf-8?B?UHhUeHRoWVFJZzBSZU5FTjNHSG83VytnMzdFUDVuMVM5Y09MTml3MGI5bE5r?=
 =?utf-8?B?RjFxSWZmZnZqMnR6Slc2LzBhb3gwalpYaHRucWNHUFNiMEdQakEvM0FYeitt?=
 =?utf-8?B?THExV0o5UnJlWDF1UURGM1JhTytlSFdDUGNqR2RLYTh0c29oV0dXYlh3Z3VY?=
 =?utf-8?B?LzlJaDl4OFUrNitiWCtMcFpoYmMzTW51TlVIT3N2Tm5JeklvQ3ZLY1Y4OFFS?=
 =?utf-8?B?MGI2MllKZURYMFU2VzFQeHF0eWZMZmpkRTY2ODlHd0NjeTVBUlZUYzJ4UGpv?=
 =?utf-8?B?Qi8rSVFNWTd3K2Y2aElraWd5ZTB0ZnAvNTJUK3VLN1VPVTNVQzdTaCt0Ty9D?=
 =?utf-8?B?cm9UZnMxMGZBcFhhamhIakxwVjdCcDNzM1RsaFduUW1JZHJORUZwNTdOcUJJ?=
 =?utf-8?Q?NTGZ8o6GiryR/OUVHKdiby0F/?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4182fe87-69b1-4acd-5783-08dc640402da
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2024 02:12:36.9711
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mBTzlUHLP9ohjay8CnyZpEwZMKqL75neQHB1nv1/ke9tc32w103bYMxnEX+1/Awc8hur05THBAUNC80hGoWHyxHQ6Tk78SnqyV5YJZTXDgo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NTZPR01MB1129

T24gMjMvMDQvMjAyNCAxNzo0OSwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gDQo+IE9u
IDIzLzA0LzIwMjQgMTA6MzQsIFhpbmd5dSBXdSB3cm90ZToNCj4gPiBBZGQgYmluZGluZ3MgYWJv
dXQgdGhlIFBETSBjb250cm9sbGVyIGZvciB0aGUgU3RhckZpdmUgSkg4MTAwIFNvQy4NCj4gPg0K
PiA+IFNpZ25lZC1vZmYtYnk6IFhpbmd5dSBXdSA8eGluZ3l1Lnd1QHN0YXJmaXZldGVjaC5jb20+
DQo+IA0KPiBJZiB0aGVyZSBpcyBnb2luZyB0byBiZSByZXNlbmQvbmV3IHZlcnNpb24sIHRocmVl
IG5pdHMuIEFueXdheToNCj4gDQo+IFJldmlld2VkLWJ5OiBLcnp5c3p0b2YgS296bG93c2tpIDxr
cnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5vcmc+DQo+IA0KDQpUaGFua3MuDQoNCj4gLi4uDQo+
IA0KPiA+ICsNCj4gPiArdGl0bGU6IFN0YXJGaXZlIEpIODEwMCBQRE0gY29udHJvbGxlcg0KPiA+
ICsNCj4gPiArZGVzY3JpcHRpb246IHwNCj4gDQo+IERvIG5vdCBuZWVkICd8JyB1bmxlc3MgeW91
IG5lZWQgdG8gcHJlc2VydmUgZm9ybWF0dGluZy4NCg0KV2lsbCBkcm9wLg0KDQo+IA0KPiA+ICsg
IFRoZSBQdWxzZSBEZW5zaXR5IE1vZHVsYXRpb24gKFBETSkgY29udHJvbGxlciBpcyBhIGRpZ2l0
YWwgUERNIG91dA0KPiA+ICsgbWljcm9waG9uZSBpbnRlcmZhY2UgY29udHJvbGxlciBhbmQgZGVj
b2RlciB0aGF0IHN1cHBvcnRzIGJvdGggdXAgdG8NCj4gPiArIDQgIGNoYW5uZWxzLCBhbmQgYW4g
SW50ZXItSUMgU291bmQgKEkyUykgdHJhbnNtaXR0ZXIgdGhhdCBvdXRwdXRzDQo+ID4gKyBzdGFu
ZGFyZCAgc3RlcmVvIGF1ZGlvIGRhdGEgdG8gYW5vdGhlciBkZXZpY2UuIFRoZSBJMlMgdHJhbnNt
aXR0ZXINCj4gPiArIGNhbiBiZSAgY29uZmlndXJlZCB0byBvcGVyYXRlIGVpdGhlciBhIG1hc3Rl
ciBvciBhIHNsYXZlIChkZWZhdWx0DQo+ID4gKyBtb2RlKS4gVGhlIFBETSAgY29udHJvbGxlciBp
bmNsdWRlcyB0d28gUERNIGJsb2NrcywgZWFjaCBQRE0gYmxvY2sNCj4gPiArIGNhbiBkcml2ZSBv
bmUgIGJpdHN0cmVhbSBzYW1wbGluZyBjbG9jayBhbmQgdHdvIGJpdHN0cmVhbSBjb21pbmcNCj4g
PiArIGRhdGEgKG1vbm8vc3RlcmVvKSAgd2l0aCBzYW1wbGluZyBjbG9jayByaXNpbmcgYW5kIGZh
bGxpbmcgZWRnZS4NCj4gPiArDQo+ID4gK21haW50YWluZXJzOg0KPiA+ICsgIC0gWGluZ3l1IFd1
IDx4aW5neXUud3VAc3RhcmZpdmV0ZWNoLmNvbT4NCj4gPiArICAtIFdhbGtlciBDaGVuIDx3YWxr
ZXIuY2hlbkBzdGFyZml2ZXRlY2guY29tPg0KPiA+ICsNCj4gPiArYWxsT2Y6DQo+ID4gKyAgLSAk
cmVmOiBkYWktY29tbW9uLnlhbWwjDQo+ID4gKw0KPiA+ICtwcm9wZXJ0aWVzOg0KPiA+ICsgIGNv
bXBhdGlibGU6DQo+ID4gKyAgICBjb25zdDogc3RhcmZpdmUsamg4MTAwLXBkbQ0KPiA+ICsNCj4g
PiArICByZWc6DQo+ID4gKyAgICBtYXhJdGVtczogMQ0KPiA+ICsNCj4gPiArICBjbG9ja3M6DQo+
ID4gKyAgICBpdGVtczoNCj4gPiArICAgICAgLSBkZXNjcmlwdGlvbjogRE1JQyBvdXRwdXQgY2xv
Y2sNCj4gPiArICAgICAgLSBkZXNjcmlwdGlvbjogTWFpbiBJQ0cgY2xvY2sNCj4gPiArDQo+ID4g
KyAgY2xvY2stbmFtZXM6DQo+ID4gKyAgICBpdGVtczoNCj4gPiArICAgICAgLSBjb25zdDogZG1p
Yw0KPiA+ICsgICAgICAtIGNvbnN0OiBpY2cNCj4gPiArDQo+ID4gKyAgcmVzZXRzOg0KPiA+ICsg
ICAgbWF4SXRlbXM6IDENCj4gPiArDQo+ID4gKyAgIiNzb3VuZC1kYWktY2VsbHMiOg0KPiA+ICsg
ICAgY29uc3Q6IDANCj4gPiArDQo+ID4gKyAgc3RhcmZpdmUsc3lzY29uOg0KPiA+ICsgICAgJHJl
ZjogL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvcGhhbmRsZS1hcnJheQ0KPiA+ICsg
ICAgaXRlbXM6DQo+ID4gKyAgICAgIC0gaXRlbXM6DQo+ID4gKyAgICAgICAgICAtIGRlc2NyaXB0
aW9uOiBwaGFuZGxlIHRvIFN5c3RlbSBSZWdpc3RlciBDb250cm9sbGVyIHN5c19zeXNjb25fbmUg
bm9kZS4NCj4gPiArICAgICAgICAgIC0gZGVzY3JpcHRpb246IFBETSBzb3VyY2UgZW5hYmxlZCBj
b250cm9sIG9mZnNldCBvZiBTWVNfU1lTQ09OX05FDQo+IHJlZ2lzdGVyLg0KPiA+ICsgICAgICAg
ICAgLSBkZXNjcmlwdGlvbjogUERNIHNvdXJjZSBlbmFibGVkIGNvbnRyb2wgbWFzaw0KPiA+ICsg
ICAgZGVzY3JpcHRpb246DQo+ID4gKyAgICAgIFRoZSBwaGFuZGxlIHRvIFN5c3RlbSBSZWdpc3Rl
ciBDb250cm9sbGVyIHN5c2NvbiBub2RlIGFuZCB0aGUgUERNDQo+IHNvdXJjZQ0KPiA+ICsgICAg
ICBmcm9tIEkyUyBlbmFibGVkIGNvbnRyb2wgb2Zmc2V0IGFuZCBtYXNrIG9mIFNZU19TWVNDT05f
TkUgcmVnaXN0ZXIuDQo+IA0KPiBUaGlzIGRlc2NyaXB0aW9uIGR1cGxpY2F0ZXMgaXRlbXMuIERy
b3AgcmVkdW5kYW50IHBhcnRzICh0aGVyZSBpcyByZWFsbHkgbmV2ZXIgYQ0KPiBuZWVkIHRvIHNh
eSBwaGFuZGxlIGlzIGEgcGhhbmRsZSBiZWNhdXNlIGl0IGNhbm5vdCBiZSBhbnl0aGluZyBlbHNl
KS4gSW5zdGVhZCBzYXkNCj4gd2hhdCBpcyBpdCB1c2VkIGZvci4NCg0KV2lsbCBmaXguDQoNCj4g
DQo+IA0KPiA+ICsNCj4gPiArcmVxdWlyZWQ6DQo+ID4gKyAgLSBjb21wYXRpYmxlDQo+ID4gKyAg
LSByZWcNCj4gPiArICAtIGNsb2Nrcw0KPiA+ICsgIC0gY2xvY2stbmFtZXMNCj4gPiArICAtIHJl
c2V0cw0KPiA+ICsgIC0gJyNzb3VuZC1kYWktY2VsbHMnDQo+IA0KPiBVc2UgY29uc2lzdGVudCBx
dW90ZXMsIGVpdGhlciAnIG9yICINCg0KTm90ZWQuDQoNCkJlc3QgcmVnYXJkcywNClhpbmd5dSBX
dQ0KDQo=

