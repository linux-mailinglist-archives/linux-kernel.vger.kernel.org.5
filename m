Return-Path: <linux-kernel+bounces-20682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E9EE82836B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 10:42:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D2261C24C44
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 09:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 305B234566;
	Tue,  9 Jan 2024 09:42:16 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D9F3715E
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 09:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-222-7qGqVj9MMUGHG0OrdWfGpQ-1; Tue, 09 Jan 2024 09:42:11 +0000
X-MC-Unique: 7qGqVj9MMUGHG0OrdWfGpQ-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 9 Jan
 2024 09:41:51 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Tue, 9 Jan 2024 09:41:51 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Linus Torvalds' <torvalds@linux-foundation.org>, Jiri Slaby
	<jirislaby@gmail.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Andy
 Shevchenko" <andriy.shevchenko@linux.intel.com>, Andrew Morton
	<akpm@linux-foundation.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Christoph Hellwig <hch@infradead.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: RE: [PATCH next v4 0/5] minmax: Relax type checks in min() and max().
Thread-Topic: [PATCH next v4 0/5] minmax: Relax type checks in min() and
 max().
Thread-Index: AdnqB/CwAvMQ3gkdSO607JUF4aSKdhYVzf6gACAPrDA=
Date: Tue, 9 Jan 2024 09:41:51 +0000
Message-ID: <c3798bd6c2a644e9b871d6c6956c475e@AcuMS.aculab.com>
References: <b97faef60ad24922b530241c5d7c933c@AcuMS.aculab.com>
 <18c6df0d-45ed-450c-9eda-95160a2bbb8e@gmail.com>
 <CAHk-=wjvM5KiQFpbPMPXH-DcvheNcPGj+ThNEJVm+QL6n05A8A@mail.gmail.com>
In-Reply-To: <CAHk-=wjvM5KiQFpbPMPXH-DcvheNcPGj+ThNEJVm+QL6n05A8A@mail.gmail.com>
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

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMDggSmFudWFyeSAyMDI0IDE4OjE5DQouLi4N
Cj4gVGhhdCBzYWlkLCBJJ20gc3VyZSB0aGlzIHRoaW5nIGV4aXN0cyB0byBhIHNtYWxsZXIgZGVn
cmVlIGVsc2V3aGVyZS4gSQ0KPiB3b25kZXIgaWYgd2UgY291bGQgc2ltcGxpZnkgb3VyIG1pbi9t
YXggdHlwZSB0ZXN0cy4uDQoNCkNvdWxkIHRoZSB0eXBlLWNoZWNrIGJlIG1vdmVkIGludG8gb25l
IG9mIHRoZSBkZWJ1ZyBidWlsZHM/DQpUaGF0IHdvdWxkIGdpdmUgdGhlIGNvdmVyYWdlIHdpdGhv
dXQgc2xvd2luZyBkb3duIGFsbCBidWlsZHM/DQoNCkFkZGluZyAtV3NpZ24tY29tcGFyZSBpcyBh
IFBJVEEgdW50aWwgZ2NjIGFkZHMgdmFsdWUgdHJhY2tpbmcNCnRvIGl0LCBub3QganVzdCBhIHR5
cGUgY2hlY2suDQpPdGhlcndpc2UgaXQgYmxlYXRzIGFib3V0Og0KCWludCBydmFsID0gZm4oKTsN
CglpZiAocnZhbCA8IDApDQoJCXJldHVybiBydmFsOw0KCWlmIChydmFsID4gdW5zaWduZWRfdmFs
dWUpDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkg
Um9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlv
biBObzogMTM5NzM4NiAoV2FsZXMpDQo=


