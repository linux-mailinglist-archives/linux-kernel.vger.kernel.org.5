Return-Path: <linux-kernel+bounces-149720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE1788A94FA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 10:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 259FC1F21DD8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 08:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E78E13D8B7;
	Thu, 18 Apr 2024 08:29:26 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2132.outbound.protection.partner.outlook.cn [139.219.146.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2111136E23;
	Thu, 18 Apr 2024 08:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713428965; cv=fail; b=NjYfSYwHGfRymBNpHpo2Rf9tsE2Cd26OhWWA3yUAJTLeSmMZb0enbeord5vPnL6VxiInONm4wjjkG7kNnYDK8IFYauARnJBL/FH6Fy1H6R5UiPTGhco0RNxAC9qBBFl6j5MvgHKq1SO8l1W4GNMOrQfGl3uwcig9Zb5toWa1Yio=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713428965; c=relaxed/simple;
	bh=LMVVHPch07ssuTYSNjExilqgfX3GoxgNNtXRnxoxP/Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=o1S7OgyE6pf/O/vfZB1V+1yAOJhDIO+GGVJh6ZM4V3obz0jiFzZsHA7AMf9aTBSJ3efEep196r45eOTtWjEZg6Y9JGk1X5Av3MLHZ5r5cq9w4iudX/WlZyWq7Sn69lIy+5quRGsk5TWlKzfQX0qT9WKIkEkc6whfKxOeA6K2pvQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c+sctvQhq64tG4Hdbcr5MB1qr99Z63GvMuuEcR2j2UGIzVebX1iPruuVuOipqEKYxkqtg8Mube4w2MPoFEa04FM3OH6Zj3xlV+GNaTqxhaEa8qqu00kASeGj24U4ME8fur60xQCCBAgc5RkEnJrMIv/eyzELtyPabACijy717In3qXNJpFP+hrUJ8pUsdS5jnyAMxQaE2XH0fzesx1kdg6/JqvDGS/u0XftAEmByrf8bv++n0855ypvBRZseh7mZHRFwMLoHqYGvPa75mRUDelTber1N42lsULH4F9MA12Z9rbuzsew8kupHGwImIAOKmLQwCju24raC+0R+Iw6x9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LMVVHPch07ssuTYSNjExilqgfX3GoxgNNtXRnxoxP/Q=;
 b=EupdFpgaoeP7+Fh7la5aAxOt+AKWFQFig9CGb2xGQKYHdWK3HBbFrRQnVzVBE67F9VZJ/hqlm41K+niVw5tw8z84qcmP8xuk/ZKIUe71zZ+sAbmgiskLHbvbBbwgLMHGi3KgWBOH5GudDuV2f/ojLeetlutY2Eo8Gai0Mf3cjm9PzfD4Dh664HU4vhIpkCuCckyukbXIaarf/bgNR/q7y3GS5SZfW8OACiVOb1tFSDPzihw1rnfqPBw+dEOFSSlJ5q/uTQRQUsYk/Vql1Nrpodtto2V6K+ehjfFFhvOIDMrlN0DFxrgFEdJeN8P1X3n/dqEDkCQEcuHONKgs3OQWRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:8::10) by NTZPR01MB1084.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:9::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 18 Apr
 2024 06:54:43 +0000
Received: from NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 ([fe80::6174:711d:d93:87c9]) by NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 ([fe80::6174:711d:d93:87c9%4]) with mapi id 15.20.7409.053; Thu, 18 Apr 2024
 06:54:43 +0000
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
Thread-Index:
 AQHaeqVhb5UxutBmeUyJ/qlePUaJGrFAuWEAgAJZ7cCAEgK7AIAUH6eAgAHfR4CAApz5gA==
Date: Thu, 18 Apr 2024 06:54:43 +0000
Message-ID:
 <NTZPR01MB095663E132E51B10CED1EBEA9F0EA@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
References: <20240320090239.168743-1-xingyu.wu@starfivetech.com>
 <20240320090239.168743-3-xingyu.wu@starfivetech.com>
 <1d0399d2-684f-490e-8711-f636e987a0b8@linux.intel.com>
 <NTZPR01MB0956BFADB4B3DA507D938F669F35A@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
 <ef510647-c409-4da6-9cd4-ff4e54cbee74@linux.intel.com>
 <NTZPR01MB09567BE742A91B8C9E02EF4F9F08A@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
 <35d9f59e-3cc1-41a7-bb1d-f482c004d323@linux.intel.com>
In-Reply-To: <35d9f59e-3cc1-41a7-bb1d-f482c004d323@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: NTZPR01MB0956:EE_|NTZPR01MB1084:EE_
x-ms-office365-filtering-correlation-id: 0a288d8e-f043-4df6-e264-08dc5f746d35
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Dfkbghz9ptk0DQOa9dt/ahwOjTl3AiKYcaP8+GDWR9nXIlcIicBoNSiNdupVP1faXfpoSLnGIO4zHvwxpFhb1tm/scr7QEA0oPttTU19Ebql1dT258vG3kL4/z03GFGQzkcbdDyPY29smnPemEJymbwbYubn6Hs3HBUQtGTAvdy35udWAAegxH+w1UkwM4dWmTExzl4+U1LYYa4EAekvqEHb8xpQJdybGpqntvvqjLKSV1ehDDPxzRzAafrXOFiXS/tIfMBZpW2L7pCSE7eiGsx07ChZUT2PftzBg1px6lPCepJRZ13mYbNYR6skqmoyL+MPn2jqgY57sx7BzBkcxpCfxPUSgaRuORSPeslVYM3qrGIURftyq++oZQKkp4lZc5HGPpI9s7HpVyMzFfnpLq4GEk4SxMO4SR9rISiVpQS/cpXAOGKWpioPOTR1VmWDiHTt94885jKRjf/c6DnK5C5cjEzSfRazqfOA8EooiXZ2Ubo/ukQFY2tClQEpe/8jPaD0/gBMGCMfYzI5PLqNIRYqvcUI6F3nDuz7AJ/iApBG59RBwrj78/eIVfvcSyHPCngyFqaVnpGu0a5CUhastPx6+I6XuPcyil+IpTxxDIZsrE4Nhj3o45YgPtCLHG7B
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(41320700004)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MmNGbzR6ZTJJRGNKZFFOOFZtL0tJRWtQYWlLK3hCSmhjVmd6ZUJZRWR6U2xZ?=
 =?utf-8?B?ZUtucjZ4d1ltN1VVSmIrNjVZWVdTUy9hZE5aT3JyKytEQitucjNnTklTS21s?=
 =?utf-8?B?a3RkMWtnYU1vVm8wQ1VGWUhYU0J0eG9HUk96S2FiNXVjSkQ0WkJadzNPc0kz?=
 =?utf-8?B?ZDNwaHJOeTVZNkJJRmpmcmJjM0FVVWJlQ0F2Y3dsWERaVE5sUU5XaUgwaGhB?=
 =?utf-8?B?OFZhZG96RlhzZ2xnOGJhZ3l0WU5tdDFVR3gzNjFaQTlTVHNScGl2UGQwU0Zy?=
 =?utf-8?B?aElZakpVYWJRbjlNZHFEUnFFOFRQUzRyRjFxVHpZbjVFS0FmVm1OYUJ1NlF4?=
 =?utf-8?B?QjIzT3M1TUs2QzVUTkhQSVNGUzY5d2NYZHFGYkRvSWZnNFIzYU5zd0Q0ZTRS?=
 =?utf-8?B?VjZONDZWTi9XUDVoREFGTGY2bHdnMXFMRENtLzZpRXJuRnNCSFZuUUwyK1Ns?=
 =?utf-8?B?Y2d1djBadk1qUnpEQVJFS1ArTHQySUltWVUxc3hzTHZIYmN1YS9GZG13OElL?=
 =?utf-8?B?a3c4Y2pyMmoxeGFDQlFHUDJ2RWJCM2puY2pNYkw2YjVFT0VpNzNmbXVRN2wv?=
 =?utf-8?B?ckpaU2U4b0s4cmtRQy8yd3FzcDVlcDYzemVWUVhGZHpOa3QyZTRrcDB6TFNh?=
 =?utf-8?B?S0lCQWdzQXAxaFNadWdEQ0Q1a0V1bmE1UVNPa2Nvd3JrY3YwOGkxa3lPekQr?=
 =?utf-8?B?S3RJcFJ2dnI0VDU0Q0thODVvbGZObVZtZ2NadzZEaitDd0c2aFA0TlhLU0RB?=
 =?utf-8?B?Z2NNcWpMNFBtNzd2Q1RLSS9wdjFuejBWRHlpczNFZU5sbWtVNHVOVTFjSVVJ?=
 =?utf-8?B?VExTQmgzRG5vRzkwNlpRUHJOcGlrektMNE9PL1BBYTFIb1BDbFlvZWd0MFln?=
 =?utf-8?B?NDRRK0NlMndGZ3cwaTdGWmNtdWRJUTV5RTJpenlnd2Y0UEw0d0ZlZmtvYmRH?=
 =?utf-8?B?Sm5qOXlIS2VWL0FVR3BRamZVMXlQdXE4QXZ3c1ZZLzBHbGh4bUllRmRJbXdI?=
 =?utf-8?B?KzBuWUZqZ3F3anplWmdNNFdERDJlRytYTDM3aEhxZVEwRit5MHZhbTU5bndJ?=
 =?utf-8?B?UmtyOEJ4Nm14M01iQ2x2Z1FJRXNERXhTSW1VTkNDY1IwTmorcUJ1UmtlNFZ1?=
 =?utf-8?B?UWVVYmFIZjBMOTVITUFYMGVkTWhHdUtNZWw1Z0QvZWpXNGRqMlVQeEJMYzFi?=
 =?utf-8?B?TGdQWnllZ1I3Vmk4NEQvdE1od3pLYmVTM3ovcmp1L3gzb2xEL3EraFcraFdo?=
 =?utf-8?B?MjFmMXJrWFJWNmRra1hMelMwd3Q1QThHN093cVhvbnlxN1hSNGh4RENua1Aw?=
 =?utf-8?B?Zi9RMmxCRXc3V1c4ZnF3ZENpMHR5MlJmbFBHOU9NTTNxN1NWWWNZSnM0TkpD?=
 =?utf-8?B?VnZHaWw3V0pPa3JJMmdBZmZ5MEc3U0RmNVBJYzFrUDRTN1RmT0pKQldqc0hK?=
 =?utf-8?B?eWFNSThTd1R4UkpUOElKMW50QmhlK2JsMVIyL05jaU9aUmJBVzlnSnlFVFh3?=
 =?utf-8?B?WThiSnArUTd0bzFkbHBDZ2o5UjIrNHA2MkFVZ2tkT3hOVWpsSVR0NTlleVEy?=
 =?utf-8?B?SUZKK0lvUXoxTWE3TWUva1NvMnB3WEtBRVhHZ2kwcTVkcldMM3lxZzFMUFBy?=
 =?utf-8?B?ZE5KbndFUlFpNkNEOTU1SmtIbFNWMzhtQU9BdUpCRnpTNmdZOHkwMjhFR3Fn?=
 =?utf-8?B?YTJRSkRXNkNOdnlEYU9LRzRVWjUrSEpkTXp1bVM0eWxDSVBNWVFUb1Q3WEJY?=
 =?utf-8?B?YXlSaTNZbzBrbGlaNnZjcTgvd001MHpqRG1MVnZvLzV3RzVyTmd2VzdWcjg0?=
 =?utf-8?B?TStDcEZzUFNUcXI3NkNDcytUQittaGRQb2JtTlRBaVBvUE9LNjJoczNkMnE3?=
 =?utf-8?B?TFFDVmRsdnpncmNPV3pBTWZRU05DU3loMlI5a2F6MGtMdXkzZ1ROZ2FiQysx?=
 =?utf-8?B?cjU2YlZ5Ylp0MjVmcVFxYjJKOEN5S0sxd1FmQUsxbjNwNWtJbjYyQzRUWm9h?=
 =?utf-8?B?NzM4aTBCMzd6Z0t0R0MwRkdMQy9CK09tOGp5amoyNm5iRUNCdUdGZFdwWHlu?=
 =?utf-8?B?OWhNVTNzQnUzOTc0dFd5Yjh5NGhiRUppQllKcWtVQ01aSlRDV1ZTaW9QTjRX?=
 =?utf-8?Q?JvHN6ZnE5PMoaBU79h9snkHM1?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a288d8e-f043-4df6-e264-08dc5f746d35
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2024 06:54:43.2768
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8z7D4di4KO7dHd2lZzLEonaSEKpS6g+rN298r2lBHhQ2J+bEqc2cODCUrI37V5FNtnE47r7gsFfI4haGCexwzrB89N6obHs2vn8puPfIat4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NTZPR01MB1084

T24gMTYvMDQvMjAyNCAyMTo1MSwgUGllcnJlLUxvdWlzIEJvc3NhcnQgd3JvdGU6DQo+IA0KPiAN
Cj4gT24gNC8xNi8yNCAwMjoyMywgWGluZ3l1IFd1IHdyb3RlOg0KPiA+IE9uIDAyLzA0LzIwMjQg
MjE6NTcsIFBpZXJyZS1Mb3VpcyBCb3NzYXJ0IHdyb3RlOg0KPiA+Pg0KPiA+Pg0KPiA+Pj4+DQo+
ID4+Pj4+ICsjZGVmaW5lIFBFUklPRFNfTUlOCQkyDQo+ID4+Pj4+ICsNCj4gPj4+Pj4gK3N0YXRp
YyB1bnNpZ25lZCBpbnQgY2Ruc19pMnNfcGNtX3R4KHN0cnVjdCBjZG5zX2kyc19kZXYgKmRldiwN
Cj4gPj4+Pj4gKwkJCQkgICAgc3RydWN0IHNuZF9wY21fcnVudGltZSAqcnVudGltZSwNCj4gPj4+
Pj4gKwkJCQkgICAgdW5zaWduZWQgaW50IHR4X3B0ciwgYm9vbA0KPiAqcGVyaW9kX2VsYXBzZWQs
DQo+ID4+Pj4+ICsJCQkJICAgIHNuZF9wY21fZm9ybWF0X3QgZm9ybWF0KQ0KPiA+Pj4+PiArew0K
PiA+Pj4+PiArCXVuc2lnbmVkIGludCBwZXJpb2RfcG9zID0gdHhfcHRyICUgcnVudGltZS0+cGVy
aW9kX3NpemU7DQo+ID4+Pj4NCj4gPj4+PiBub3QgZm9sbG93aW5nIHdoYXQgdGhlIG1vZHVsbyBp
cyBmb3IsIHVzdWFsbHkgaXQncyBtb2R1bG8gdGhlIGJ1ZmZlciBzaXplPw0KPiA+Pj4NCj4gPj4+
IFRoaXMgaXMgdG8gc2VlIGlmIHRoZSBuZXcgZGF0YSBpcyBkaXZpc2libGUgYnkgcGVyaW9kX3Np
emUgYW5kIHRvDQo+ID4+PiBkZXRlcm1pbmUgd2hldGhlciBpdCBpcyBlbm91Z2ggZm9yIGEgcGVy
aW9kX3NpemUgaW4gdGhlIGxhdGVyIGxvb3AuDQo+ID4+DQo+ID4+IFRoYXQgZGlkbid0IGFuc3dl
ciB0byBteSBxdWVzdGlvbiwgdGhlIHBvc2l0aW9uIGlzIHVzdWFsbHkgYmV0d2Vlbg0KPiA+PiAw
Li5idWZmZXJfc2l6ZS4xLg0KPiA+DQo+ID4gWWVzLCB0aGlzIHBvc2l0aW9uIHdpbGwgYmUgdXNl
ZCBsYXRlciBpbiB0aGUgY2Ruc19pMnNfcGNtX3BvaW50ZXIoKS4NCj4gPiBCdXQgdGhpcyBjZG5z
X2kyc19wY21fdHgoKSBpcyBjYWxsZWQgYnkgSTJTIGhhcmR3YXJlIGludGVycnVwdCB3aGljaA0K
PiA+IHdvdWxkIGJlIGZyZXF1ZW50bHkgY2FsbGVkIHNldmVyYWwgdGltZXMgZWFjaCBwZXJpb2Qu
IFRoZSBwZXJpb2RfcG9zDQo+ID4gaXMgdXNlZCB0byBkZXRlcm1pbmUgd2hldGhlciB0aGVyZSBp
cyBlbm91Z2ggYSBwZXJpb2Rfc2l6ZSB0byBjYWxsDQo+ID4gc25kX3BjbV9wZXJpb2RfZWxhcHNl
ZCgpLg0KPiA+DQo+ID4+DQo+ID4+IERvaW5nIGluY3JlbWVudHMgb24gYSBtb2R1bG8gdmFsdWUg
dGhlbiBjb21wYXJpc29ucyBhcyBkb25lIGJlbG93DQo+ID4+IHNlZW1zIHJhdGhlciBxdWVzdGlv
bmFibGUuDQo+ID4+DQo+ID4+Pj4+ICsNCj4gPj4+Pj4gKwkJaW93cml0ZTMyKGRhdGFbMF0sIGRl
di0+YmFzZSArIENETlNfRklGT19NRU0pOw0KPiA+Pj4+PiArCQlpb3dyaXRlMzIoZGF0YVsxXSwg
ZGV2LT5iYXNlICsgQ0ROU19GSUZPX01FTSk7DQo+ID4+Pj4+ICsJCXBlcmlvZF9wb3MrKzsNCj4g
Pj4+Pj4gKwkJaWYgKCsrdHhfcHRyID49IHJ1bnRpbWUtPmJ1ZmZlcl9zaXplKQ0KPiA+Pj4+PiAr
CQkJdHhfcHRyID0gMDsNCj4gPj4+Pj4gKwl9DQo+ID4+Pj4+ICsNCj4gPj4+Pj4gKwkqcGVyaW9k
X2VsYXBzZWQgPSBwZXJpb2RfcG9zID49IHJ1bnRpbWUtPnBlcmlvZF9zaXplOw0KPiA+Pj4+PiAr
CXJldHVybiB0eF9wdHI7DQo+ID4+Pj4+ICt9DQo+ID4+DQo+ID4+Pj4+ICsJcG1fcnVudGltZV9l
bmFibGUoJnBkZXYtPmRldik7DQo+ID4+Pj4+ICsJaWYgKHBtX3J1bnRpbWVfZW5hYmxlZCgmcGRl
di0+ZGV2KSkNCj4gPj4+Pj4gKwkJY2Ruc19pMnNfcnVudGltZV9zdXNwZW5kKCZwZGV2LT5kZXYp
Ow0KPiA+Pj4+DQo+ID4+Pj4gdGhhdCBzZXF1ZW5jZSBsb29rcyBzdXNwaWNpb3VzLi4uLiBXaHkg
d291bGQgeW91IHN1c3BlbmQNCj4gPj4+PiBpbW1lZGlhdGVseSBkdXJpbmcgdGhlIHByb2JlPyBZ
b3UncmUgcHJvYmFibHkgbWlzc2luZyBhbGwgdGhlIGF1dG9zdXNwZW5kDQo+IHN0dWZmPw0KPiA+
Pj4NCj4gPj4+IFNpbmNlIEkgaGF2ZSBlbmFibGVkIGNsb2NrcyBiZWZvcmUsIGFuZCB0aGUgZGV2
aWNlIGlzIGluIHRoZSBzdXNwZW5kDQo+ID4+PiBzdGF0ZSBhZnRlciBwbV9ydW50aW1lX2VuYWJs
ZSgpLCBJIG5lZWQgdG8gZGlzYWJsZSBjbG9ja3MgaW4NCj4gPj4+IGNkbnNfaTJzX3J1bnRpbWVf
c3VzcGVuZCgpIHRvIG1hdGNoIHRoZSBzdXNwZW5kIHN0YXRlLg0KPiA+Pg0KPiA+PiBUaGF0IGlz
IHZlcnkgb2RkIG9uIHR3byBjb3VudHMNCj4gPj4gYSkgaWYgeW91IGhhdmVuJ3QgZW5hYmxlZCB0
aGUgY2xvY2tzLCB3aHkgZG8geW91IG5lZWQgdG8gZGlzYmFsZSB0aGVtPw0KPiA+PiBiKSBpZiB5
b3UgZG8gYSBwbV9ydW50aW1lX2VuYWJsZSgpLCB0aGVuIHRoZSBicmFuY2ggaWYNCj4gPj4gKHBt
X3J1bnRpbWVfZW5hYmxlZCkgaXMgYWx3YXlzIHRydWUuDQo+ID4+DQo+ID4NCj4gPiBhKSBJdCBt
dXN0IGVuYWJsZSBjbG9ja3MgZmlyc3QgdG8gcmVhZCBhbmQgd3JpdGUgcmVnaXN0ZXJzIHdoZW4g
STJTIHByb2JlLg0KPiA+IFRoZW4gaXQgaXMgZG9uZSB0byBwcm9iZSwgdGhlIGNsb2NrcyBhcmUg
c3RpbGwgZW5hYmxlZCBhbmQgdGhlIHN0YXRlDQo+ID4gb2YgcG0gaXMgc3VzcGVuZC4gU28gaXQg
bmVlZCB0byBiZSBkaXNhYmxlZCB0byBtYXRjaCB0aGUgc3RhdGUgYW5kDQo+ID4gd2lsbCByZXN1
bWUgYW5kIGJlIGVuYWJsZWQgYnkgQUxTQS4NCj4gDQo+IEkgdGhpbmsgeW91IGFyZSBtaXNzaW5n
IGEgcG1fcnVudGltZV9zZXRfYWN0aXZlKCkgdG8gcmVjb25jaWxlIHRoZSBwbSBzdGF0ZSB3aXRo
DQo+IHRoZSBoYXJkd2FyZSBzdGF0ZS4gVGhlIHByZW1pc2Ugb2YgcG1fcnVudGltZSBpcyB0aGF0
IG9uIHByb2JlIHlvdXIgZGV2aWNlIGlzDQo+IGFjdGl2ZSBhbmQgbGF0ZXIgb24gaXQgd2lsbCBz
dXNwZW5kLiBIYXZpbmcgcG1fcnVudGltZV9lbmFibGVkIHdpdGggYQ0KPiBzdXNwZW5kZWQgZGV2
aWNlIHdpdGhvdXQgdGhlIGZyYW1ld29yayBpbnZvbHZlZCB0byB0cmlnZ2VyIHRoZSB0cmFuc2l0
aW9uIHRvDQo+IHN1c3BlbmQgaXMgYXNraW5nIGZvciB0cm91YmxlLg0KDQpHcmVhdCwgSXQgaXMg
YmV0dGVyIHRvIHVzZSBwbV9ydW50aW1lX3NldF9hY3RpdmUoKS4gSSB3aWxsIG1vZGlmeSBpdCBp
biBuZXh0IHBhdGNoLg0KDQo+IA0KPiA+IGIpIEJlY2F1c2UgQ09ORklHX1BNIHdvdWxkIGJlIGRp
c2FibGVkIGFuZCBwbV9ydW50aW1lX2VuYWJsZWQoKSByZXR1cm4NCj4gPiBmYWxzZSAsIHRoZW4g
aXQgaXMgbm8gbmVlZCB0byBkaXNhYmxlIGNsb2NrIGFuZCBJMlMgc3RpbGwgY2FuIHdvcmsuDQo+
IA0KPiBBZ2FpbiB5b3UgYXJlIHRyeWluZyB0byBtYWtlIHRoaW5ncyBtb3JlIGNvbXBsaWNhdGVk
IHRoYW4gdGhleSBuZWVkIHRvIGJlLg0KPiBEb24ndCB0cnkgdG8gYWN0aXZlbHkgbWFuYWdlIGFu
ZCBxdWVyeSBzdGF0ZXMsIGxldCB0aGUgZnJhbWV3b3JrIGRvIGl0IGZvciB5b3UuDQo+IA0KPiBU
cnkgdG8gcHJvYmUgYW5kIGJyaW5nIHRoZSBkZXZpY2UgdG8gYW4gYWN0aXZlIHN0YXRlLiBUaGVu
IHVzZQ0KPiBwbV9ydW50aW1lX21hcmtfbGFzdF9idXN5KCksIHVzZSBwbV9ydW50aW1lX2VuYWJs
ZSBhbmQgbGV0IGF1dG9zdXNwZW5kDQo+IGRvIHRoZSB3b3JrIGZvciB5b3UuIElmIHBtX3J1bnRp
bWUgaXMgbm90IGVuYWJsZWQgdGhlIHN1c3BlbmQgd2lsbCBub3QgaGFwcGVuLg0KPiANCj4gQWxz
byBrZWVwIGluIG1pbmQgdGhhdCBwbV9ydW50aW1lX2VuYWJsZWQoKSB3aWxsIHJldHVybiBmYWxz
ZSBpZiB0aGUgdXNlciBtdWNrcw0KPiB3aXRoIHRoZSBwb3dlciBzdGF0ZSBpbiBzeXNmcywgaXQn
cyBub3Qgb25seSBhIGNhc2Ugb2YgQ09ORklHX1BNIGJlaW5nIHNlbGVjdGVkDQo+IG9yIG5vdC4N
Cg0KTm90ZWQuIFRoYW5rcy4NCg0KPiA+DQo+ID4+DQo+ID4+Pg0KPiA+Pj4+DQo+ID4+Pj4+ICsN
Cj4gPj4+Pj4gKwlkZXZfZGJnKCZwZGV2LT5kZXYsICJJMlMgc3VwcG9ydHMgJWQgc3RlcmVvIGNo
YW5uZWxzDQo+IHdpdGggJXMuXG4iLA0KPiA+Pj4+PiArCQlpMnMtPm1heF9jaGFubmVscywgKChp
MnMtPmlycSA8IDApID8gImRtYSIgOiAiaW50ZXJydXB0IikpOw0KPiA+Pj4+PiArDQo+ID4+Pj4+
ICsJcmV0dXJuIDA7DQo+ID4+Pj4+ICsNCj4gPj4+Pj4gK2VycjoNCj4gPj4+Pj4gKwlyZXR1cm4g
cmV0Ow0KPiA+Pj4+PiArfQ0KPiA+Pj4+PiArDQo+ID4+Pj4+ICtzdGF0aWMgaW50IGNkbnNfaTJz
X3JlbW92ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KSB7DQo+ID4+Pj4+ICsJcG1fcnVu
dGltZV9kaXNhYmxlKCZwZGV2LT5kZXYpOw0KPiA+Pj4+PiArCWlmICghcG1fcnVudGltZV9zdGF0
dXNfc3VzcGVuZGVkKCZwZGV2LT5kZXYpKQ0KPiA+Pj4+PiArCQljZG5zX2kyc19ydW50aW1lX3N1
c3BlbmQoJnBkZXYtPmRldik7DQo+ID4+Pj4NCj4gPj4+PiAuLi4gYW5kIHRoaXMgb25lIHRvby4g
T25jZSB5b3UndmUgZGlzYWJsZWQgcG1fcnVudGltZSwgY2hlY2tpbmcgdGhlDQo+ID4+Pj4gc3Rh
dHVzIGlzIGlycmVsZXZhbnQuLi4NCj4gPj4+DQo+ID4+PiBJIHRoaW5rIHRoZSBjbG9ja3MgbmVl
ZCB0byBiZSBhbHdheXMgZW5hYmxlZCBhZnRlciBwcm9iZSBpZiBkaXNhYmxlDQo+ID4+PiBwbV9y
dW50aW1lLCBhbmQgc2hvdWxkIGJlIGRpc2FibGVkIHdoZW4gcmVtb3ZlLiBUaGlzIHdpbGwgZG8g
dGhhdC4NCj4gPj4NCj4gPj4gaWYgeW91IGFyZSBkaXNhYmxpbmcgcG1fcnVudGltZSwgdGhlbiB0
aGUgcG1fcnVudGltZSBzdGF0ZSBiZWNhbWVzIGludmFsaWQuDQo+ID4+IFdoZW4gcG1fcnVudGlt
ZV9kaXNhYmxlKCkgaXMgYWRkZWQgaW4gcmVtb3ZlIG9wZXJhdGlvbnMsIGl0J3MgbWFpbmx5DQo+
ID4+IHRvIHByZXZlbnQgdGhlIGRldmljZSBmcm9tIHN1c3BlbmRpbmcuDQo+ID4NCj4gPiBTaG91
bGQgSSB1c2UgdGhlIHBtX3J1bnRpbWVfZW5hYmxlZCgpIGJlZm9yZSB0aGUgcG1fcnVudGltZV9k
aXNhYmxlKCk/DQo+IA0KPiBJdCBkb2Vzbid0IG1hdHRlciwgdGhlIHByb2JsZW0gaXMgdGhlIHNl
Y29uZCBwYXJ0IHdoZXJlIHlvdSB0cnkgdG8gY2hlY2sgdGhlDQo+IHN0YXR1cyBvZiBwbV9ydW50
aW1lICphZnRlciogZGlzYWJsaW5nIGl0Lg0KPiANCg0KV2lsbCBmaXguDQoNClRoYW5rcywNClhp
bmd5dSBXdQ0K

