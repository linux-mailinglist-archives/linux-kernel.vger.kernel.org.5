Return-Path: <linux-kernel+bounces-22869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F4182A464
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 23:58:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3503D28908F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 22:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E2B04F897;
	Wed, 10 Jan 2024 22:58:44 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C00F4F895
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 22:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-73-_8yABj-UMTaFugOIAJqOdg-1; Wed, 10 Jan 2024 22:58:39 +0000
X-MC-Unique: _8yABj-UMTaFugOIAJqOdg-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 10 Jan
 2024 22:58:23 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 10 Jan 2024 22:58:23 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Linus Torvalds' <torvalds@linux-foundation.org>, Stephen Rothwell
	<sfr@canb.auug.org.au>
CC: Jiri Slaby <jirislaby@gmail.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, Andrew Morton
	<akpm@linux-foundation.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Christoph Hellwig <hch@infradead.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: RE: [PATCH next v4 0/5] minmax: Relax type checks in min() and max().
Thread-Topic: [PATCH next v4 0/5] minmax: Relax type checks in min() and
 max().
Thread-Index: AdnqB/CwAvMQ3gkdSO607JUF4aSKdhZ9C6k7AAacz4A=
Date: Wed, 10 Jan 2024 22:58:23 +0000
Message-ID: <ad3a9cf720cd4e1ebe942cdc84a6a670@AcuMS.aculab.com>
References: <b97faef60ad24922b530241c5d7c933c@AcuMS.aculab.com>
 <18c6df0d-45ed-450c-9eda-95160a2bbb8e@gmail.com>
 <CAHk-=wjvM5KiQFpbPMPXH-DcvheNcPGj+ThNEJVm+QL6n05A8A@mail.gmail.com>
 <CAHk-=wjE1eLMtkKqTt0XqNSnKAeDagV=WQU+vxHL_wsLuO8Gag@mail.gmail.com>
 <CAHk-=whkGHOmpM_1kNgzX1UDAs10+UuALcpeEWN29EE0m-my=w@mail.gmail.com>
 <20240110171739.2e2d9de0@canb.auug.org.au>
 <CAHk-=wj1uqgU7hS=WqDSwEvc6=CwuWYBUmjSJAT6zx86CF=QBQ@mail.gmail.com>
In-Reply-To: <CAHk-=wj1uqgU7hS=WqDSwEvc6=CwuWYBUmjSJAT6zx86CF=QBQ@mail.gmail.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMTAgSmFudWFyeSAyMDI0IDE5OjM1DQo+IA0K
PiBPbiBUdWUsIDkgSmFuIDIwMjQgYXQgMjI6MTcsIFN0ZXBoZW4gUm90aHdlbGwgPHNmckBjYW5i
LmF1dWcub3JnLmF1PiB3cm90ZToNCj4gPg0KPiA+ID4gQ2FuIHNvbWVib2R5IGVsc2UgY29uZmly
bSBzaW1pbGFyIHRpbWUgZGlmZmVyZW5jZXM/IE9yIGlzIGl0IGp1c3QgbWU/DQo+ID4NCj4gPiBJ
IHdhcyBob3BlZnVsLCBidXQ6DQo+IA0KPiBZZWFoLCBteSBidWlsZCB0aW1lcyBzZWVtIHRvIGJl
IHZlcnkgdW5zdGFibGUgZm9yIHNvbWUgcmVhc29uLCBhbmQNCj4gc2VlbSB0byBmbHVjdHVhdGUg
ZmFpcmx5IHdpZGVseS4gSSdtIG5vdCBzdXJlIHdoYXQgdHJpZ2dlcnMgaXQuDQo+IA0KPiBUaGUg
bWluL21heCBzaW1wbGlmaWNhdGlvbiBoZWxwcywNCg0KVGhlIGZpcnN0IGNoZWNrIGluIF9fdHlw
ZXNfb2soKSBjYW4gZ28sIHRoZSBzZWNvbmQgb25lICh3aXRoIHRoZSAnKyAwJykNCihhZGRlZCB0
byBwcm9tb3RlIGNoYXIgdG8gaW50KSBpbmNsdWRlcyB0aGUgZmlyc3Qgb25lLg0KDQotV3NpZ24t
Y29tcGFyZSB3aWxsIG5lZWQgd29yayBmcm9tIHRoZSBjb21waWxlciBwZW9wbGUuDQpJIHN1c3Bl
Y3QgdGhhdCB3aGVuIG1pbih1bnNpZ25lZF92YXIsIDQpIGVmZmVjdGl2ZWx5IGRvZXMNCglpbnQg
Zm91ciA9IDQ7DQoJaWYgKHVuc2lnbmVkX3ZhciA+IGZvdXIpDQppdCBpcyBnb2luZyB0byB0cmlw
IHRoZSB3YXJuaW5nIHVudGlsIGdjYyB1c2VzIGl0cyB2YWx1ZSB0cmFja2luZw0KZm9yIHRoYXQg
d2FybmluZy4NCg0KSGF2ZSB5b3UgbG9va2VkIGF0IGhvdyBtdWNoIHRoZSBjb21waWxlLXRpbWUg
c3RyaW5nIGxlbmd0aA0Kc3R1ZmYgY29zdHM/IFRoYXQgbWlnaHQgYWxzbyBiZSBtZWFzdXJhYmxl
Lg0KQW5kIHRoZSBjb21waWxlLXRpbWUgdXNlcmNvcHkgdGVzdHMuDQpUaGUgcnVuLXRpbWUgY29z
dHMgb2YgdGhlIGxhdHRlciBjYW4gYmUgaG9ycmlkLi4uDQoNCj4gYnV0IEkgdGhpbmsgbXkgImJp
ZyBjaGFuZ2UiIHRoaW5nDQo+IHdhcyBtb3N0bHkgZHVlIHRvIG90aGVyIGZsdWN0dWF0aW9ucy4N
Cj4gDQo+IEl0IHdvdWxkIGJlIGxvdmVseSB0byBoYXZlIHNvbWUgcGVyZm9ybWFuY2UgYXV0b21h
dGlvbiB0byBmaW5kIGJ1aWxkDQo+IHRpbWUgcmVncmVzc2lvbnMsIGFsdGhvdWdoIGF0IGxlYXN0
IGZvciBtZSwgb25lIHNvdXJjZSBvZiByZWdyZXNzaW9ucw0KPiB0ZW5kcyB0byBiZSBzeXN0ZW0g
dXBkYXRlcyB3aXRoIG5ldyBjb21waWxlcnMgOygNCg0KQ2FuIHdlIGdvIGJhY2sgdG8gZ2NjIDIu
OTUgb3IgMi45NyAtIHRoYXQgd291bGQgYmUgcXVpY2sgb24gYSBtb2Rlcm4gY3B1IDotKQ0KDQoJ
RGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1v
dW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEz
OTczODYgKFdhbGVzKQ0K


