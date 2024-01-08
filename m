Return-Path: <linux-kernel+bounces-19854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6FB9827563
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 17:38:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4578E281094
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 16:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37DB453E32;
	Mon,  8 Jan 2024 16:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lenze.com header.i=@lenze.com header.b="eFLu83xM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2050.outbound.protection.outlook.com [40.107.15.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4923D537FE
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 16:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=lenze.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lenze.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HLZjxpOnAL9NVfF3psYRs88w14cOp7ZzmlxrLHM+O6eJKN+1JBKPHNipAHVrQbhe7OUV4iSZALKTbrk0PqulTT1vpLznWT7BJRz9KPIIUIyuOxogdOBuiHmpc5tizro4D/RyTQKaTkuBfiY7NskESPFAwZRUUSxCrKwXyzem4iS0OEB8y1vep7f6Y5YyOKvbxrjT8JrWD72RK61OqzQUMtttyJHDflf5/unVya+s9QhdRSpIUYNiWnE0eIKFnHly0LWnIopxrYU2i00cZBzLg/a/8ArbBZU1NBWc3berltxTMW5SZEMYFSSgGEdArAwCy+oHlGPwyIds+qeZWasIjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yHE5zfrDZtj6MOmsM0D9ABl/GCPiBDPD+3CN+uK+vh4=;
 b=kEXJwHd0r/oEsH/brEnszPYbnE7K3rfr7OOSudsuSl5ev1kZnYqU/1Pye6lxTsfSB+rAzpKthMV2fS5xB/klMFzTK7tSGP2bEfFJf0fljlBK58KwW15OY4xj9QZKOXZxrOH5lP+ihcTX2fQ35fWNcAnnWNOD1jX7tKfrsR2zLfQpEwTpaOySK+XGKIwy2kJLlO/PTSqfYZrzK4yi2tU94N2lHjOvpF3pwKKpxMn0fxhAI7N3v3kJr6XFaSctqoM+x1iyTAybcrApbkxh+LYQOKmqJm/slVZwMWFihoyBTMSXfa0BBTsujKkEadEsBE0H0X5NnIO0abAFN3swsqZRVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lenze.com; dmarc=pass action=none header.from=lenze.com;
 dkim=pass header.d=lenze.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lenze.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yHE5zfrDZtj6MOmsM0D9ABl/GCPiBDPD+3CN+uK+vh4=;
 b=eFLu83xMmFBsAfBQcTf/Ka+UZRH0nFhU1ItjCLH1D/kTQ1jzahqnQ/6Q5h8guZA32eTTnC2ZSjtRftiQ3EiXNnsWeiWIYQ7qXRcqXCRW6qAz+hYtCdKLf1xDSvDXYjNmnDh/6rqeM/NcMZNZ9LSOAilHrIw4eYhv2HaxkvzSgepSf0wOR4pKNBNIfop+jx/8kJiySNtFpum7mvOaoMxLAVCRZKvjJjta3RcGYmreeTtJOmThMtsZ+YRdILpBUIam/AqzwL3GwavRY6fIHaLPMIUk/XFi9Q71Pndx/cisVKsYUm7Y9RCFP5EREZCLXKV7S7tGigpuZjS+fSa8JkS+dA==
Received: from DB8P194MB0806.EURP194.PROD.OUTLOOK.COM (2603:10a6:10:162::23)
 by AM8P194MB1172.EURP194.PROD.OUTLOOK.COM (2603:10a6:20b:249::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.14; Mon, 8 Jan
 2024 16:37:37 +0000
Received: from DB8P194MB0806.EURP194.PROD.OUTLOOK.COM
 ([fe80::5d13:7cb5:9ade:602d]) by DB8P194MB0806.EURP194.PROD.OUTLOOK.COM
 ([fe80::5d13:7cb5:9ade:602d%7]) with mapi id 15.20.7181.014; Mon, 8 Jan 2024
 16:37:37 +0000
From: "Brandt, Oliver - Lenze" <oliver.brandt@lenze.com>
To: "mark.rutland@arm.com" <mark.rutland@arm.com>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "will@kernel.org" <will@kernel.org>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: mm: disable PAN during caches_clean_inval_user_pou
Thread-Topic: [PATCH] arm64: mm: disable PAN during
 caches_clean_inval_user_pou
Thread-Index: AQHaQjKt20xeAz7LS0mwiFLj8Z0q9rDQEaoAgAAL6QA=
Date: Mon, 8 Jan 2024 16:37:37 +0000
Message-ID: <15b92eff2767926aa345e159964e342e3b7192ca.camel@lenze.com>
References: <e6dc8a44a140d1e54bc1408c36704b581433ec10.camel@lenze.com>
	 <ZZwa0msD9KSJg54-@FVFF77S0Q05N>
In-Reply-To: <ZZwa0msD9KSJg54-@FVFF77S0Q05N>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=lenze.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB8P194MB0806:EE_|AM8P194MB1172:EE_
x-ms-office365-filtering-correlation-id: 8f9cbfdc-f42d-4a0d-0c7f-08dc10681fb8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Mrm8K+N0OlZNmmK0pmrQ3lV7fdtWmskL7sMGr6B9s7QqOYT3HOHdpYtsuvBETKyfLvvULcnffRFznaj4LLSmIP0qi07I+8gRlQ2UaJ2Fwh1Yd4Y5hfslxumHY+XtfbT+xhDLJGPWefO4cnenxScrQT1QLC/AwHfqPbOBbLJ/DMJ5WpG8FPU5pLPELPfbODWuVC3pWfTgBbNKrNl3fceP8HEgX62bGMgEdm9TQd4cMt/+Ni7nR2QkwmV8fJk5p0t8GgTWtWbd3iJCgLU/ch4tuBAq4EAKDK4r7QcWm2ofiJc908koXSK0/aENQT0U6Dr+i0/vKOmT3dgEHW8hEfFNG2cYH+AFpx9vGmbGyY8C1HgklGROWEZ3EwI4IMfyDRkkIYrYMXiIZm+VKQM7dMUZaLpaHqv0lXjEX80kUobHWFWWem6QLgxuDQeXW1HRSmNxptLIlNOcwx1/ch6JAGUxd7AAepM6uIDWVUV710a1+Zsqop9plwFJfowuZCn8kp5PtAVNWWOHjXyNEI+OUcMwEBp75Hui3EPfi+v1NSIeN4tSP8HW0AurW59stfCuiNy3YFRxgr3toiB2dHgvlWDqHVQZ4aaBNmvnNoRoCKsMlTDRg54aPLsReqfqRXxhpCNZ
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8P194MB0806.EURP194.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(346002)(376002)(396003)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(38100700002)(122000001)(41300700001)(4326008)(2906002)(6916009)(5660300002)(38070700009)(54906003)(6486002)(36756003)(86362001)(6512007)(6506007)(316002)(8676002)(8936002)(66946007)(66556008)(66476007)(91956017)(76116006)(66446008)(64756008)(83380400001)(71200400001)(26005)(478600001)(2616005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dml5UVdSRVQ5amRVejdyUWppSy9vWVkvcUd0YUowZlBxK0V0UjZ6SENLVGJO?=
 =?utf-8?B?N2k1dWl2Yzk1TUxOWW9HRnl6U2kwNFJsUVErYnF4WTQ3SHdWNWhiNm5FZUl1?=
 =?utf-8?B?M0VjQlVva05zZkNGYjI4d01HUnBDdFpWV2I5czZDR09tTVNRTnI0RWF0aEtR?=
 =?utf-8?B?cGtpeEx3azdMbkFwejlzWGJMNnBYOTRVK2svTmhxcGZnSEk5Uk9RYTI0cUp2?=
 =?utf-8?B?aUZSUnJEVkxjNGtLSzBtMEplbWRaRGtqc0ZvbGJQQ2paT21VeUtrOHVTUGNj?=
 =?utf-8?B?RFEybHBMckpmMXhjaVY5eWczUFBMdnE2V0xiS0FoNWFDWEFPZ00xTzRRZXEr?=
 =?utf-8?B?elBGeDkrOE96MkQwL0Vhb29OcTd1emZaTGVDZFJBV0t1eWJaQUhwT0t4ZUVu?=
 =?utf-8?B?UjBTM2hGaTkyWGxoS0hxSWgzb0VaMWRuYVdwWTdNcFROOVFjWVRWajdxSkZE?=
 =?utf-8?B?cDlXSDR6aW1oTGFnS0pTZFVrcmpIbSt4V1hSeG5pNVF5Nkx4aUdRNnZFQnNU?=
 =?utf-8?B?ZFBldUxHREVzQ2dTdEZaYTJxakd4RFdiU0d0enJtU083NnRzaFVlVFVVVGZL?=
 =?utf-8?B?SlhNcmVzQ08xTTZPWkxOWVluUjlVeEFqMVRFUWhSWHZpcFcxendCMDdIRllW?=
 =?utf-8?B?RklWWDRQVDRXYkVQb083S2dhTnZKaDBIVm91RXc4VzZYTGdNWjZpQUE1eUpy?=
 =?utf-8?B?SytOaVpCVUxiWWJQK20vb1E2V3ZodS9QQUNsanMxM1pzWndKcXpKR3o1U3g3?=
 =?utf-8?B?TllYREVibER3c0JmSXJuanRYNWZKYndXd0lJL0RMbE8xbFBmYkJ0T1RSVE9w?=
 =?utf-8?B?NVl6NG85TjdQMjFiNTZHTnNadlZwanlqRjZOWlBpQm94bStMUFZldXc4VFJS?=
 =?utf-8?B?VXhRa1FKUTQyajNuSE8yZnZQUnVUaHNMUFVSRHQ0cU5WWS9KbHpkWi83S2tM?=
 =?utf-8?B?c1dEaDNFeTBzNnBkOUk5eU1iaVBHWWJlNWYvK3Zra0pNTUlMK3JzWGR2OW95?=
 =?utf-8?B?WEtUMkxraGlxMlp2K2NoM0JDUEwxekZRL2pkNWNkUERGSE1kSHNTWTlTeGVk?=
 =?utf-8?B?Skd1bFBiVWlEQS8yVjVCcWUxSGVxdzV2d3pNZklqS1hEOERZVGE1YzJlcWJ1?=
 =?utf-8?B?MWRKZTl4c1NycEVnRCtLbDh5ajhpZkIxbksxQ0N0WFEvVVNCMTBqQjc0Vlp1?=
 =?utf-8?B?YXNpMnZDWU9kdVBZK2lyd3JFSHFLc2Z4bXdOVVZaa2t0ZzVsMVBvdnUvM2pP?=
 =?utf-8?B?WndhNEtnWW9tTjJOVHdyTjR6bEJKYnNQbFl0bUdOVFJHM0NuaUVqaUNjclJK?=
 =?utf-8?B?ei9Fc3N2b1JUejhkMDNWaldhSHo4NGI2Qks1UWxzZUcvU3dtRzhpQmtUeHpj?=
 =?utf-8?B?NjBsNlJDbHpXM25nWjU0ZlpUblcyd0tQdjY5dFlnaXJkZWJmSjR5TU9haDBl?=
 =?utf-8?B?SENPb0NvdS9ndFRmbnB0OW1jSkErS0djSUNGSlo5enF4WSs0S2VqY3VnaFYw?=
 =?utf-8?B?a0RjekZwWnpzVWIrbE5QczYrVzFCY1dCZlBPemg0ZFp5bGY4N2dUMU1BMSt5?=
 =?utf-8?B?ZkllMlBKbjRVRS9HUDZibUNOTlVCUS9TOHExM0xhZDVQampCM1grTStySm1X?=
 =?utf-8?B?cUExNnZzSTE4dzRlOVZyNUo0dUNnVHhYK3l6aTRKVzZyYnAwbFFpM2R2WDMz?=
 =?utf-8?B?NXJNWENUa3p4NTI1cVVtdjlFNHVUV2liY0dPLzhoNUxTZzJlTEs1blB2OW40?=
 =?utf-8?B?RzltY1FpZkI0RzcrNEQrWDgyYiszYURITGYzZFRvV0ZvOFJ0QXdQM3JTZEFh?=
 =?utf-8?B?UnlnUXNBTW9ENG0yYk9DdnhESlZ1Sk1ldldFSE16TXVjNm5IaGgyYlpMWDJx?=
 =?utf-8?B?QkZ2R0paNTk3UWU1ZWRWNm9ndWVMbXZXODIrZ0tPbE5xc1VnOHUvOENkR0dr?=
 =?utf-8?B?c0pZMEMxNUxMVUljVEhFWkc0UldRaHVJNWFlT0NHSmVZdUlHdkpnc2ZqNk1u?=
 =?utf-8?B?eGhmMkx1WHk4VzF1KzYvQlRhcGZjcERGdzJieGZXQlJSZ3FseWM0QTZ0eGtI?=
 =?utf-8?B?NzJUbC9FT0pxeWFDdVdSQzA5M251VC9LT1l5a2hJRDNjSGt1MVVvNHRCQkxo?=
 =?utf-8?Q?/Om7SQ55QiHXDP/UBQ9cbAWgV?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F7C57F3A7D255C44AA2F883A7FC82101@EURP194.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: lenze.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8P194MB0806.EURP194.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f9cbfdc-f42d-4a0d-0c7f-08dc10681fb8
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2024 16:37:37.4430
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 37cf0ce8-ac09-4e7d-9ff2-f1da44914b3e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hoj+WK59NiorPyz4nQLwfMcKLDXTNaHugBpe6NAJchXPDBLFJv0x5eX8539uTvQiWmgqBIqO9HSFQFdkeIwHrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P194MB1172

SGkgTWFyaywNCg0KPiANCj4gSGkgT2xpdmVyLA0KPiANCj4gT24gTW9uLCBKYW4gMDgsIDIwMjQg
YXQgMDE6MDA6MzlQTSArMDAwMCwgQnJhbmR0LCBPbGl2ZXIgLSBMZW56ZSB3cm90ZToNCj4gPiBV
c2luZyB0aGUgY2FjaGVmbHVzaCgpIHN5c2NhbGwgZnJvbSBhbiAzMi1iaXQgdXNlci1zcGFjZSBm
YWlscyB3aGVuDQo+ID4gQVJNNjRfUEFOIGlzIHVzZWQuIFdlICdsbCBnZXQgYW4gZW5kbGVzcyBs
b29wOg0KPiA+IA0KPiA+ICAgICAgIDEuIGV4ZWN1dGluZyAiZGMgY3ZhdSwgeDIiIHJlc3VsdHMg
aW4gcmFpc2luZyBhbiBhYm9ydA0KPiA+ICAgICAgIDIuIGFib3J0IGhhbmRsZXIgZG9lcyBub3Qg
Zml4IHRoZSByZWFzb24gZm9yIHRoZSBhYm9ydCBhbmQNCj4gPiAgICAgICAgICByZXR1cm5zIHRv
IDEuDQo+ID4gDQo+ID4gRGlzYWJsaW5nIFBBTiBmb3IgdGhlIHRpbWUgb2YgdGhlIGNhY2hlIG1h
aW50ZW5hbmNlIGZpeGVzIHRoaXMuDQo+IA0KPiBIbW0uLi4gdGhlIEFSTSBBUk0gc2F5cyBQU1RB
VEUuUEFOIGlzIG5vdCBzdXBwb3NlZCB0byBhZmZlY3QgREMgQ1ZBVS4NCj4gDQo+IExvb2tpbmcg
YXQgdGhlIGxhdGVzdCBBUk0gQVJNIChBUk0gRERJIDA0ODdKLmEpLCBSX1BNVFdCIHN0YXRlczoN
Cj4gDQo+ID4gVGhlIFBTVEFURS5QQU4gYml0IGhhcyBubyBlZmZlY3Qgb24gYWxsIG9mIHRoZSBm
b2xsb3dpbmc6DQo+ID4gDQo+ID4gbyBJbnN0cnVjdGlvbiBmZXRjaGVzLg0KPiA+IG8gRGF0YSBj
YWNoZSBpbnN0cnVjdGlvbnMsIGV4Y2VwdCBEQyBaVkEuDQo+ID4gbyBJZiBGRUFUX1BBTjIgaXMg
bm90IGltcGxlbWVudGVkLCB0aGVuIGFkZHJlc3MgdHJhbnNsYXRpb24gaW5zdHJ1Y3Rpb25zLg0K
PiA+IG8gSWYgRkVBVF9QQU4yIGlzIGltcGxlbWVudGVkLCB0aGVuIHRoZSBhZGRyZXNzIHRyYW5z
bGF0aW9uIGluc3RydWN0aW9ucw0KPiA+ICAgb3RoZXIgdGhhbiBBVCBTMUUxUlAgYW5kIEFUIFMx
RTFXUC4NCj4gDQo+IFNvIElJVUMsIERDIENWQVUgc2hvdWxkbid0IGJlIGFmZmVjdGVkIGJ5IFBB
Ti4NCg0KVXBzLi4uIFNvcnJ5LCBkaWRuJ3Qgbm90aWNlZCB0aGlzLg0KDQo+IFRoaXMgY291bGQg
YmUgYSBDUFUgYnVnOyB3aGljaCBDUFUgYXJlIHlvdSBzZWVpbmcgdGhpcyB3aXRoPw0KDQpJJ3Zl
IHN0dW1ibGVkIGFib3V0IHRoaXMgd2hpbGUgdXNpbmcgSW50ZWwncyBzaW11bGF0b3IgIlNpbWlj
cyIgd2l0aCBhDQptb2RlbCBvZiB0aGUgdXBjb21pbmcgIkFnaWxleDUgc29jZnBnYSIuIFRoZSAi
QWdpbGV4NSIgaXMgYSBTb0MNCmNvbnRhaW5pbmcgdHdvIENvcnRleCBBNzYgYW5kIHR3byBDb3J0
ZXggQTU1Lg0KDQpXZSBhcmUgZXhwZWN0aW5nIHRoZSByZWFsIHNpbGljb24gaW4gYSBjb3VwbGUg
b2Ygd2Vla3MuIFNlZW1zIHRvIGJlIGENCmdvb2QgaWRlYSB0byBjaGVjayB0aGUgc2lsaWNvbiBm
aXJzdC4gU29ycnkgdG8gYm90aGVyIHlvdSB3aXRoIHRoaXMuDQoNCk1hbnkgdGhhbmtzIGZvciB0
aGUgcXVpY2sgcmVwbHkhDQoNCj4gDQo+IE1hcmsuDQoNCk9saXZlcg0KDQo+IA0KPiA+IEZpeGVz
OiAzMzhkNGY0OWQ2ZjcgKCJhcm02NDoga2VybmVsOiBBZGQgc3VwcG9ydCBmb3IgUHJpdmlsZWdl
ZCBBY2Nlc3MgTmV2ZXIiKQ0KPiA+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+ID4gU2ln
bmVkLW9mZi1ieTogT2xpdmVyIEJyYW5kdCA8b2xpdmVyLmJyYW5kdEBsZW56ZS5jb20+DQo+ID4g
LS0tDQo+ID4gIGFyY2gvYXJtNjQvbW0vY2FjaGUuUyB8IDIgKysNCj4gPiAgMSBmaWxlIGNoYW5n
ZWQsIDIgaW5zZXJ0aW9ucygrKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L21t
L2NhY2hlLlMgYi9hcmNoL2FybTY0L21tL2NhY2hlLlMNCj4gPiBpbmRleCA1MDM1NjdjODY0ZmRl
Li4zMzNjNGMyYmFhNTY4IDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gvYXJtNjQvbW0vY2FjaGUuUw0K
PiA+ICsrKyBiL2FyY2gvYXJtNjQvbW0vY2FjaGUuUw0KPiA+IEBAIC03MCwxMCArNzAsMTIgQEAg
U1lNX0ZVTkNfQUxJQVMoX19waV9jYWNoZXNfY2xlYW5faW52YWxfcG91LCBjYWNoZXNfY2xlYW5f
aW52YWxfcG91KQ0KPiA+ICAgKi8NCj4gPiAgU1lNX0ZVTkNfU1RBUlQoY2FjaGVzX2NsZWFuX2lu
dmFsX3VzZXJfcG91KQ0KPiA+ICAgICAgIHVhY2Nlc3NfdHRicjBfZW5hYmxlIHgyLCB4MywgeDQN
Cj4gPiArICAgICBBTFRFUk5BVElWRSgibm9wIiwgU0VUX1BTVEFURV9QQU4oMCksIEFSTTY0X0hB
U19QQU4sIENPTkZJR19BUk02NF9QQU4pDQo+ID4gDQo+ID4gICAgICAgY2FjaGVzX2NsZWFuX2lu
dmFsX3BvdV9tYWNybyAyZg0KPiA+ICAgICAgIG1vdiAgICAgeDAsIHh6cg0KPiA+ICAxOg0KPiA+
ICsgICAgIEFMVEVSTkFUSVZFKCJub3AiLCBTRVRfUFNUQVRFX1BBTigxKSwgQVJNNjRfSEFTX1BB
TiwgQ09ORklHX0FSTTY0X1BBTikNCj4gPiAgICAgICB1YWNjZXNzX3R0YnIwX2Rpc2FibGUgeDEs
IHgyDQo+ID4gICAgICAgcmV0DQo+ID4gIDI6DQo+ID4gLS0NCj4gPiAyLjQzLjANCg0K

