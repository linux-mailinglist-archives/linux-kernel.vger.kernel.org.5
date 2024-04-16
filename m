Return-Path: <linux-kernel+bounces-146439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F18528A6549
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 09:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 715BB1F229D5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 07:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5E884D1C;
	Tue, 16 Apr 2024 07:39:44 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2126.outbound.protection.partner.outlook.cn [139.219.146.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6ABE386;
	Tue, 16 Apr 2024 07:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713253184; cv=fail; b=u0HltB8eNDWvKsm1Ke6yYpwWIwVMkxJQUuiYzxRUTm6YGBUs9x0WShwvBOEpnmm84X717hKlkTQiceJAMGaijyvPSfGwYPE9AXBo3X7+1GZyIjqC3Ra25rPSEVJrQ0YFELV30EapUpIYVKfCKwTiJbdoKIvjoIN2pUv98HW5Clw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713253184; c=relaxed/simple;
	bh=C7allhosknlQuNJc3cTnzImspOUMc+RrA+yz6RK/1BM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VyciXjEYwBLe+OoksjJAK2A4MPzOH45ebko7DYiCGUp4+pn3T7gnmfvj8j9hZ5X/16IoQf21MMBsDZguBGTx4oBI0TjWwBWbS9zArBNXV1cI+D/9nPZ/FIyZ1WkNUH4fXUwhMKI3ud+6WqUGBvOJPzHuD/3QFgrrxmCTC94RnpA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sm8gqiAS1vtgzG4PisY9RXzyNfwwxZRB+LS235rQhjt/lErpEQXw4IIpvTgMsJF4SleVrkRUOgq/ZI0zJO2XhW+QGIuZsPx3+Zox54jbUK/epD6+nf5jjnQEyMySdRthYuK3lOyDKaToB3pEs25hkfLa5YVoOZ0tXAV6PqD9vwbhJS4w+FTcRkYz6+0RvfDEYmuy5QEh5Pi+S38UysjgUXkFxAJ1+BdTGMHEgcfj5wyIKNTGOHw5bltDHKI6SQM8Tg8+wrLIqkFY+1LBmqMwJtErQ3k4CpOgeS0HAMyMpMezlgHeKYDWDvP49awD6QAWSfMXElAxOOrDA0I8CDsk2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C7allhosknlQuNJc3cTnzImspOUMc+RrA+yz6RK/1BM=;
 b=ngAcsuzLW7db0X0a0yek5NVDQlALeOTBZBGoHUIdSmjMkPMEprkD+etp+tJBxVHEQSrcVM5LoHTo3KLYK+ITpfVgMBDj6y07mSIDuy5jIXlEzkioaD4ALJewzhQuB6oVJY+aL6W1xuYiUQlFTgE1NRcFbSNz8QDY8HBLcy5swMZMwlR9ZRKuStv1RBCvbOT9mFT/dIo0bmPRIj8xzpsyKU4Kg8mtSeouy4XHAPPptCaghBk8bE6Gbkrih6gdzLL8mgsEX6sHLTsCpiMQjjTntBKOGMwnoP2dPpVBJ5QTxYr9RdNwsN/CJJA7SLfd42YXbyWsWBEUqGjnw7n+BqdQow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:8::10) by NTZPR01MB1036.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:8::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 16 Apr
 2024 07:23:57 +0000
Received: from NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 ([fe80::6174:711d:d93:87c9]) by NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 ([fe80::6174:711d:d93:87c9%4]) with mapi id 15.20.7409.053; Tue, 16 Apr 2024
 07:23:57 +0000
From: Xingyu Wu <xingyu.wu@starfivetech.com>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood
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
 =?utf-8?B?UkU6IOWbnuWkjTogW1BBVENIIHYyIDIvMl0gQVNvQzogY2RuczogQWRkIGRy?=
 =?utf-8?Q?ivers_of_Cadence_Multi-Channel_I2S_Controller?=
Thread-Topic:
 =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjIgMi8yXSBBU29DOiBjZG5zOiBBZGQgZHJpdmVy?=
 =?utf-8?Q?s_of_Cadence_Multi-Channel_I2S_Controller?=
Thread-Index: AQHaeqVhb5UxutBmeUyJ/qlePUaJGrFAuWEAgAJZ7cCAEgK7AIAUH6eA
Date: Tue, 16 Apr 2024 07:23:57 +0000
Message-ID:
 <NTZPR01MB09567BE742A91B8C9E02EF4F9F08A@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
References: <20240320090239.168743-1-xingyu.wu@starfivetech.com>
 <20240320090239.168743-3-xingyu.wu@starfivetech.com>
 <1d0399d2-684f-490e-8711-f636e987a0b8@linux.intel.com>
 <NTZPR01MB0956BFADB4B3DA507D938F669F35A@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
 <ef510647-c409-4da6-9cd4-ff4e54cbee74@linux.intel.com>
In-Reply-To: <ef510647-c409-4da6-9cd4-ff4e54cbee74@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: NTZPR01MB0956:EE_|NTZPR01MB1036:EE_
x-ms-office365-filtering-correlation-id: 37c538a9-c721-48ca-eb7c-08dc5de62de1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 7oXuMac3v5NV8hXSM5F3L8i2hUv/lcSHUd1B1rpNa+jYCf3shV2WR3AehZLkCTQBMtdM5TnHhkUNJBxjovC6KKxpcVpP5IIo1PNbXczMhruZN7FisHFLxDJwFwJmUH0QG9Lh6TgCrwxC4UdZOg7i7gyRgkQ+C5pr/Ac1FrWF19vt9226Twu6F2ls0572nLArFznJSO3W032I4vikir5Jki6pvSpYvyyJYFhzqTf6YhQIWtmUqv0gqmoDlzzMbe4j29DtSKO7Ge+g+b8NDAikHoRbwOhKcZvT16hksU2Tkkd+2d8nhTLeST9eW817mtKyf55gslgewDpciXBXQF05bSho9XRI8Mwnis1LqzNwXjAeg0ExRdOVmD02hHxojOrX9SEd/ar0P/gZwOfx/2Zv5NO0PuhiWqJci7rn4vwCQDIHoU65j1HM4UuPzrJhuZ+3pdYm/sFT6sklMFnJmRB/ETI3xFooKA0WukpbPvUmrHXzeekejBWSotc2/Y+x03Dl9uDMPrnUkIshNmW7bVdZNB7rWG8OOkpQ5rvkEuyq+43nuDKifVgqOfEGxIQ0U8yvOxD5rjtnk0T4aFUA2JmdxeNe/OFaUU9GlUNmWHiF0DeM9qHB10ZDVq5KwDbDxrC3
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(41320700004)(366007)(7416005)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cFlLMm4yQzEyWlF6QXZXdmw3OGhmWVVlY3RueEkrT1Vkd3FIOE0vN3BCWmhG?=
 =?utf-8?B?MHBuYjl6RUtjTS9Ob2FOTi9yUFdhTWMvVFlmYUZTd21EWDJ3YWxjRElSZVgz?=
 =?utf-8?B?bUp5eVNFbjM2WFVNRUxSL0pROWVOaUhhZ3hVOGFkZ0ZDVVhqbG00UVo3c1g4?=
 =?utf-8?B?QjBEMDRFUVUweDY5V3h1aVZFZjRFOSs0UnZyWTZSR1A1R2ZMQ08wZHhBTHEz?=
 =?utf-8?B?UGJVLzN0Z3QwOUlMWlV0TUZ3K3c2SUhXOUV4ZUNsUUN5VHRZMkpkbXVJeFY0?=
 =?utf-8?B?cXBMNjV1OVB2R041UUdHaFdZb28ybGdYV1gvbEFkb3E1YWNndSs0ejZ1eFhk?=
 =?utf-8?B?MGJsSWdLTGlrVldEMmYvTStWLzdlaEZEVWgzd3U1WndjdGRHUGlVWmJRZ3VV?=
 =?utf-8?B?N2pkZnNRclhyUzZVdTROUUVRZERqMnRPWlJhZTFzL3lKUUxGUHdkLytiOUpD?=
 =?utf-8?B?WHBSMEd5M21SVFFQQzhybld6SHlNQ0czdTIrL09aRDdrU3gyYlQrb0FjME9J?=
 =?utf-8?B?RFplNmdjeFBFcnBCR3JZeENxUjFseGs3R1l0M0RPQXlBdTJVMTVWSDJOWmJk?=
 =?utf-8?B?dnlreU5XcndVWmdXRTZiejBGNVYyRzVObVBWN3NBMDROUk1mT3JwaUlqNUds?=
 =?utf-8?B?emx5ZDJwVTRsWW9HQzRDSzdaVHNXNDhUQkpLQWcwczVEbjFyMDFBZDBCSXB6?=
 =?utf-8?B?aTJNcTJYQ1lwOEFzTFNmdmpkYjFqTWpQTXFxUVRMRy9zVGQxWGRVNlZKZ0tp?=
 =?utf-8?B?YW1mOW02OXdVNHJKOUhQS09VNFh2dzcxMmE1aDRiQmt0TDhOTis5K2ZtMjly?=
 =?utf-8?B?OWtvUmdxY2FLV3dTbjZPd3J0MmNUMzdqVW5xVlQ1bXh0dFFPY0tUYy9XQ040?=
 =?utf-8?B?TnYyTFJEM2RSOE1ZbTl2ZXdYVWxvL1h4TlZDbFdqaVY0QVFLNWVtdm81dGsx?=
 =?utf-8?B?ZEEzUVRtYzNVbzVXbTZyd0hLdlNualJkYThaSStLVUs2YklZbUF2c2k4M2l0?=
 =?utf-8?B?bmtlTlRVNHZNcisrUjRSSkxyV1E3WkpFVDl1ZTQ0eTJqZDVia2Y2K09HbERQ?=
 =?utf-8?B?ZkdjMkluNWVDVlViV3JpdEFrOE1PRjNFYjd0MXFBb0xlQTI4L2xWa2VKSklR?=
 =?utf-8?B?STd5THZmd1RQM0V5anUwYmtlMVhLQmRiUnZJTk4yYnE3VW1LdkZTdG9RbURq?=
 =?utf-8?B?WG1GeHFDMFZ3ZTN0d2JVL3FyakR5b01nSnFOSmZWRzNTQXRJamVTUHVicTlZ?=
 =?utf-8?B?ODkwZXJXdmFUYTBoNk9GeDVxWHlweDZBK096SW5KQWJjdk1KWTBERXF5Rnho?=
 =?utf-8?B?WmVVam9RakVseTQ3Vlh4RERZNHBma0ExN083RU9lUUw2M2JyZHVlNEhGWjJs?=
 =?utf-8?B?dzl5OWF3MCtUVEI4SDNmMDFmYjAza1hqWm9Tc3Z3cmhlQkJ3N3pLOGIxQUxL?=
 =?utf-8?B?OURrMG9KRDVIbVFtOG5GWGViYldzL2FhNnUwc09uLzFOa2ltQTJOeHBPYTQ0?=
 =?utf-8?B?ZjhxK0pCNWc4QzRZNEpCRzBjL2tidlV5UUdwOGxWYlU0SGxqL05aY0N6TExt?=
 =?utf-8?B?S0FwWVRLRkxpMUd6ZnprTXphRis4bTd6NkZmdWxORmlWSEtvS2tqVEtPT3hj?=
 =?utf-8?B?c0dtM09wUHNGVVh5cmpBdFRrRzhCNWlXNXM2YUZ1K2VJODllQVY0a1RHTFFp?=
 =?utf-8?B?VzJFNWRPaS9Db1dTUTVBQ3RwUE15NXVqSllpd3ZHenI4eWNReXFiNmx6Y1NL?=
 =?utf-8?B?cFlocHpmL1pYeWhUWW9GTkNIMmY5ajAxNzBmYkdJVFhzdnNKeUNRZE5DZnA2?=
 =?utf-8?B?U2dpY2NlZUk5R3N5bnMydERyK08yTFJEL1FVVGhKUW1xWWNQNWZic0laU0RU?=
 =?utf-8?B?d0NNSTc0T0VZalFCU0phZzlpRFFOVkxCc09sS3AwVVVhRDFqZkpuaDBBSVlz?=
 =?utf-8?B?L21UTk5lYXNxUWprd3YvVU9GVHNhWmtxWlgwMHdQNTdOWEE5c3dCMjJrb01V?=
 =?utf-8?B?NzRQZVgyQUplTG44Snhiemlkc0NtTG9oM09aMXZVSnpFTlBJaVJST0ZNUXJJ?=
 =?utf-8?B?Yzh1RXdlNnM1Y2tTVmI1UHlDYmgwN1orQVgxR1R3MjEvSDdJckdHcGZDdFh0?=
 =?utf-8?Q?lMJXn6GzaQsxenqVPmLQMK58D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 37c538a9-c721-48ca-eb7c-08dc5de62de1
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2024 07:23:57.3014
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aE0pEagYo+k7pwMLCVbFyOmFjL0ujx+Kh1rORi5FnNR7kU4vXk4p8tsJu7aLzhtmeDaJ6I8xyFNA4qv81TqngSAk4xgNMImhk0QoBxHz3ic=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NTZPR01MB1036

T24gMDIvMDQvMjAyNCAyMTo1NywgUGllcnJlLUxvdWlzIEJvc3NhcnQgd3JvdGU6DQo+IA0KPiAN
Cj4gPj4NCj4gPj4+ICsjZGVmaW5lIFBFUklPRFNfTUlOCQkyDQo+ID4+PiArDQo+ID4+PiArc3Rh
dGljIHVuc2lnbmVkIGludCBjZG5zX2kyc19wY21fdHgoc3RydWN0IGNkbnNfaTJzX2RldiAqZGV2
LA0KPiA+Pj4gKwkJCQkgICAgc3RydWN0IHNuZF9wY21fcnVudGltZSAqcnVudGltZSwNCj4gPj4+
ICsJCQkJICAgIHVuc2lnbmVkIGludCB0eF9wdHIsIGJvb2wgKnBlcmlvZF9lbGFwc2VkLA0KPiA+
Pj4gKwkJCQkgICAgc25kX3BjbV9mb3JtYXRfdCBmb3JtYXQpDQo+ID4+PiArew0KPiA+Pj4gKwl1
bnNpZ25lZCBpbnQgcGVyaW9kX3BvcyA9IHR4X3B0ciAlIHJ1bnRpbWUtPnBlcmlvZF9zaXplOw0K
PiA+Pg0KPiA+PiBub3QgZm9sbG93aW5nIHdoYXQgdGhlIG1vZHVsbyBpcyBmb3IsIHVzdWFsbHkg
aXQncyBtb2R1bG8gdGhlIGJ1ZmZlciBzaXplPw0KPiA+DQo+ID4gVGhpcyBpcyB0byBzZWUgaWYg
dGhlIG5ldyBkYXRhIGlzIGRpdmlzaWJsZSBieSBwZXJpb2Rfc2l6ZSBhbmQgdG8NCj4gPiBkZXRl
cm1pbmUgd2hldGhlciBpdCBpcyBlbm91Z2ggZm9yIGEgcGVyaW9kX3NpemUgaW4gdGhlIGxhdGVy
IGxvb3AuDQo+IA0KPiBUaGF0IGRpZG4ndCBhbnN3ZXIgdG8gbXkgcXVlc3Rpb24sIHRoZSBwb3Np
dGlvbiBpcyB1c3VhbGx5IGJldHdlZW4NCj4gMC4uYnVmZmVyX3NpemUuMS4NCg0KWWVzLCB0aGlz
IHBvc2l0aW9uIHdpbGwgYmUgdXNlZCBsYXRlciBpbiB0aGUgY2Ruc19pMnNfcGNtX3BvaW50ZXIo
KS4NCkJ1dCB0aGlzIGNkbnNfaTJzX3BjbV90eCgpIGlzIGNhbGxlZCBieSBJMlMgaGFyZHdhcmUg
aW50ZXJydXB0IHdoaWNoDQp3b3VsZCBiZSBmcmVxdWVudGx5IGNhbGxlZCBzZXZlcmFsIHRpbWVz
IGVhY2ggcGVyaW9kLiBUaGUgcGVyaW9kX3Bvcw0KaXMgdXNlZCB0byBkZXRlcm1pbmUgd2hldGhl
ciB0aGVyZSBpcyBlbm91Z2ggYSBwZXJpb2Rfc2l6ZSB0byBjYWxsDQpzbmRfcGNtX3BlcmlvZF9l
bGFwc2VkKCkuDQoNCj4gDQo+IERvaW5nIGluY3JlbWVudHMgb24gYSBtb2R1bG8gdmFsdWUgdGhl
biBjb21wYXJpc29ucyBhcyBkb25lIGJlbG93IHNlZW1zDQo+IHJhdGhlciBxdWVzdGlvbmFibGUu
DQo+IA0KPiA+Pj4gKw0KPiA+Pj4gKwkJaW93cml0ZTMyKGRhdGFbMF0sIGRldi0+YmFzZSArIENE
TlNfRklGT19NRU0pOw0KPiA+Pj4gKwkJaW93cml0ZTMyKGRhdGFbMV0sIGRldi0+YmFzZSArIENE
TlNfRklGT19NRU0pOw0KPiA+Pj4gKwkJcGVyaW9kX3BvcysrOw0KPiA+Pj4gKwkJaWYgKCsrdHhf
cHRyID49IHJ1bnRpbWUtPmJ1ZmZlcl9zaXplKQ0KPiA+Pj4gKwkJCXR4X3B0ciA9IDA7DQo+ID4+
PiArCX0NCj4gPj4+ICsNCj4gPj4+ICsJKnBlcmlvZF9lbGFwc2VkID0gcGVyaW9kX3BvcyA+PSBy
dW50aW1lLT5wZXJpb2Rfc2l6ZTsNCj4gPj4+ICsJcmV0dXJuIHR4X3B0cjsNCj4gPj4+ICt9DQo+
IA0KPiA+Pj4gKwlwbV9ydW50aW1lX2VuYWJsZSgmcGRldi0+ZGV2KTsNCj4gPj4+ICsJaWYgKHBt
X3J1bnRpbWVfZW5hYmxlZCgmcGRldi0+ZGV2KSkNCj4gPj4+ICsJCWNkbnNfaTJzX3J1bnRpbWVf
c3VzcGVuZCgmcGRldi0+ZGV2KTsNCj4gPj4NCj4gPj4gdGhhdCBzZXF1ZW5jZSBsb29rcyBzdXNw
aWNpb3VzLi4uLiBXaHkgd291bGQgeW91IHN1c3BlbmQgaW1tZWRpYXRlbHkNCj4gPj4gZHVyaW5n
IHRoZSBwcm9iZT8gWW91J3JlIHByb2JhYmx5IG1pc3NpbmcgYWxsIHRoZSBhdXRvc3VzcGVuZCBz
dHVmZj8NCj4gPg0KPiA+IFNpbmNlIEkgaGF2ZSBlbmFibGVkIGNsb2NrcyBiZWZvcmUsIGFuZCB0
aGUgZGV2aWNlIGlzIGluIHRoZSBzdXNwZW5kDQo+ID4gc3RhdGUgYWZ0ZXIgcG1fcnVudGltZV9l
bmFibGUoKSwgSSBuZWVkIHRvIGRpc2FibGUgY2xvY2tzIGluDQo+ID4gY2Ruc19pMnNfcnVudGlt
ZV9zdXNwZW5kKCkgdG8gbWF0Y2ggdGhlIHN1c3BlbmQgc3RhdGUuDQo+IA0KPiBUaGF0IGlzIHZl
cnkgb2RkIG9uIHR3byBjb3VudHMNCj4gYSkgaWYgeW91IGhhdmVuJ3QgZW5hYmxlZCB0aGUgY2xv
Y2tzLCB3aHkgZG8geW91IG5lZWQgdG8gZGlzYmFsZSB0aGVtPw0KPiBiKSBpZiB5b3UgZG8gYSBw
bV9ydW50aW1lX2VuYWJsZSgpLCB0aGVuIHRoZSBicmFuY2ggaWYNCj4gKHBtX3J1bnRpbWVfZW5h
YmxlZCkgaXMgYWx3YXlzIHRydWUuDQo+IA0KDQphKSBJdCBtdXN0IGVuYWJsZSBjbG9ja3MgZmly
c3QgdG8gcmVhZCBhbmQgd3JpdGUgcmVnaXN0ZXJzIHdoZW4gSTJTIHByb2JlLg0KVGhlbiBpdCBp
cyBkb25lIHRvIHByb2JlLCB0aGUgY2xvY2tzIGFyZSBzdGlsbCBlbmFibGVkIGFuZCB0aGUgc3Rh
dGUgb2YgcG0NCmlzIHN1c3BlbmQuIFNvIGl0IG5lZWQgdG8gYmUgZGlzYWJsZWQgdG8gbWF0Y2gg
dGhlIHN0YXRlIGFuZCB3aWxsIHJlc3VtZQ0KYW5kIGJlIGVuYWJsZWQgYnkgQUxTQS4NCg0KYikg
QmVjYXVzZSBDT05GSUdfUE0gd291bGQgYmUgZGlzYWJsZWQgYW5kIHBtX3J1bnRpbWVfZW5hYmxl
ZCgpDQpyZXR1cm4gZmFsc2UgLCB0aGVuIGl0IGlzIG5vIG5lZWQgdG8gZGlzYWJsZSBjbG9jayBh
bmQgSTJTIHN0aWxsIGNhbiB3b3JrLg0KDQo+IA0KPiA+DQo+ID4+DQo+ID4+PiArDQo+ID4+PiAr
CWRldl9kYmcoJnBkZXYtPmRldiwgIkkyUyBzdXBwb3J0cyAlZCBzdGVyZW8gY2hhbm5lbHMgd2l0
aCAlcy5cbiIsDQo+ID4+PiArCQlpMnMtPm1heF9jaGFubmVscywgKChpMnMtPmlycSA8IDApID8g
ImRtYSIgOiAiaW50ZXJydXB0IikpOw0KPiA+Pj4gKw0KPiA+Pj4gKwlyZXR1cm4gMDsNCj4gPj4+
ICsNCj4gPj4+ICtlcnI6DQo+ID4+PiArCXJldHVybiByZXQ7DQo+ID4+PiArfQ0KPiA+Pj4gKw0K
PiA+Pj4gK3N0YXRpYyBpbnQgY2Ruc19pMnNfcmVtb3ZlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2Ug
KnBkZXYpIHsNCj4gPj4+ICsJcG1fcnVudGltZV9kaXNhYmxlKCZwZGV2LT5kZXYpOw0KPiA+Pj4g
KwlpZiAoIXBtX3J1bnRpbWVfc3RhdHVzX3N1c3BlbmRlZCgmcGRldi0+ZGV2KSkNCj4gPj4+ICsJ
CWNkbnNfaTJzX3J1bnRpbWVfc3VzcGVuZCgmcGRldi0+ZGV2KTsNCj4gPj4NCj4gPj4gLi4uIGFu
ZCB0aGlzIG9uZSB0b28uIE9uY2UgeW91J3ZlIGRpc2FibGVkIHBtX3J1bnRpbWUsIGNoZWNraW5n
IHRoZQ0KPiA+PiBzdGF0dXMgaXMgaXJyZWxldmFudC4uLg0KPiA+DQo+ID4gSSB0aGluayB0aGUg
Y2xvY2tzIG5lZWQgdG8gYmUgYWx3YXlzIGVuYWJsZWQgYWZ0ZXIgcHJvYmUgaWYgZGlzYWJsZQ0K
PiA+IHBtX3J1bnRpbWUsIGFuZCBzaG91bGQgYmUgZGlzYWJsZWQgd2hlbiByZW1vdmUuIFRoaXMg
d2lsbCBkbyB0aGF0Lg0KPiANCj4gaWYgeW91IGFyZSBkaXNhYmxpbmcgcG1fcnVudGltZSwgdGhl
biB0aGUgcG1fcnVudGltZSBzdGF0ZSBiZWNhbWVzIGludmFsaWQuDQo+IFdoZW4gcG1fcnVudGlt
ZV9kaXNhYmxlKCkgaXMgYWRkZWQgaW4gcmVtb3ZlIG9wZXJhdGlvbnMsIGl0J3MgbWFpbmx5IHRv
DQo+IHByZXZlbnQgdGhlIGRldmljZSBmcm9tIHN1c3BlbmRpbmcuDQoNClNob3VsZCBJIHVzZSB0
aGUgcG1fcnVudGltZV9lbmFibGVkKCkgYmVmb3JlIHRoZSBwbV9ydW50aW1lX2Rpc2FibGUoKT8N
Cg0KQmVzdCByZWdhcmRzLA0KWGluZ3l1IFd1DQo=

