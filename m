Return-Path: <linux-kernel+bounces-24094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D456682B6BB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 22:38:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 861871F25056
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 21:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 240D858208;
	Thu, 11 Jan 2024 21:38:05 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8DD58200
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 21:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-249-giLU8WSZOkejN2ml79qOBA-1; Thu, 11 Jan 2024 21:37:21 +0000
X-MC-Unique: giLU8WSZOkejN2ml79qOBA-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 11 Jan
 2024 21:37:03 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 11 Jan 2024 21:37:03 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Dave Airlie' <airlied@gmail.com>, John Hubbard <jhubbard@nvidia.com>
CC: "H. Peter Anvin" <hpa@zytor.com>, David Howells <dhowells@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"pinskia@gmail.com" <pinskia@gmail.com>
Subject: RE: [PATCH 00/45] C++: Convert the kernel to C++
Thread-Topic: [PATCH 00/45] C++: Convert the kernel to C++
Thread-Index: AQHaRExSc9FLgAcqI0yr2FdA/3WpwbDVBAHg
Date: Thu, 11 Jan 2024 21:37:02 +0000
Message-ID: <271fe5f98088419488caefefea16e736@AcuMS.aculab.com>
References: <152261521484.30503.16131389653845029164.stgit@warthog.procyon.org.uk>
 <3465e0c6-f5b2-4c42-95eb-29361481f805@zytor.com>
 <de221edb-6d12-4bef-97a7-4ab4c2381bfc@nvidia.com>
 <CAPM=9tzNEbJxVtusYLQqvzo14-CW_Nbo65L7Jfb4dF_JM1PBTQ@mail.gmail.com>
In-Reply-To: <CAPM=9tzNEbJxVtusYLQqvzo14-CW_Nbo65L7Jfb4dF_JM1PBTQ@mail.gmail.com>
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

PiBDYW4gd2UgZ2V0IG1lbW9yeSBzYWZldHkgd2l0aCBDKysgbm93PyBhbmQgYWxzbyBzdG9wIHBl
b3BsZSBjb2RpbmcgQysrDQo+IGxpa2UgaXQncyAxOTk0Pw0KDQpXaGF0IGlzIHRoZSBydW4tdGlt
ZSBjb3N0Pw0KVGhpbmdzIGxpa2UgJ3NtYXJ0IHBvaW50ZXJzJyBhcmUgZHVtYiENCkNTVFJJTkcg
aXMgYW4gYWJvbWluYXRpb24uDQoNCkkgc3VzcGVjdCB5b3UgbmVlZCB0byBwYXNzIGFycmF5X3Bv
aW50ZXI6bGVuZ3RoIHBhaXJzIGFib3V0IGluDQpvcmRlciB0byBnZXQgcmVhc29uYWJseSBhcnJh
eSBib3VuZCBjaGVja2luZy4NClNvIHNwbGl0dGluZyBDJ3MgcG9pbnRlci1hcnJheSBlcXVpdmFs
ZW5jZS4NCg0KQnV0IHlvdSB0aGVuIG5lZWQgdG8gZWZmaWNpZW50bHkgcmV0dXJuIHRoZW0gZnJv
bSBmdW5jdGlvbnMuDQpUaGF0IHJlYWxseSBuZWVkcyBhIHJlZ2lzdGVyIHBhaXIgYmUgdXNlZC4N
ClR5cGljYWxseSB0d28gcmVnaXN0ZXJzIGFyZSByZXNlcnZlZCBmb3IgZnVuY3Rpb24gcmV0dXJu
cywNCmJ1dCBhcmUgb25seSBldmVyIHVzZWQgZm9yIGRvdWJsZS1zaXplZCBpbnRlZ2Vycy4NCkRv
aW5nIHRoYXQgd2l0aG91dCBjb21waWxlciBzdXBwb3J0IHdvdWxkIGJlIGhhcmQgd29yay4NCg0K
VGhlIG90aGVyIGVsZXBoYW50IGluIHRoZSByb29tIGlzIGNvbXBpbGF0aW9uIHNwZWVkLg0KDQoJ
RGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1v
dW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEz
OTczODYgKFdhbGVzKQ0K


