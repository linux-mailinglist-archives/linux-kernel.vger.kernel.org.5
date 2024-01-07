Return-Path: <linux-kernel+bounces-18852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 655F4826401
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 13:11:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C4672823B3
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 12:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA90012E72;
	Sun,  7 Jan 2024 12:11:47 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1B512E57
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jan 2024 12:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-241-7jv6gjUqPeS-9lWp4G32ww-1; Sun, 07 Jan 2024 12:11:39 +0000
X-MC-Unique: 7jv6gjUqPeS-9lWp4G32ww-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 7 Jan
 2024 12:11:18 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 7 Jan 2024 12:11:18 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Eric Dumazet' <edumazet@google.com>, Linus Torvalds
	<torvalds@linux-foundation.org>
CC: Noah Goldstein <goldstein.w.n@gmail.com>, kernel test robot
	<lkp@intel.com>, "x86@kernel.org" <x86@kernel.org>,
	"oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "hpa@zytor.com"
	<hpa@zytor.com>
Subject: RE: x86/csum: Remove unnecessary odd handling
Thread-Topic: x86/csum: Remove unnecessary odd handling
Thread-Index: AQHZ7ib2fs4a8+P0bkWBCjHsrqR0abAo6HRAgKIYy6qAAJmVUIAAjHgAgABZ3tCAALgJL4ABrVJQ
Date: Sun, 7 Jan 2024 12:11:18 +0000
Message-ID: <003465d588004802b2ce88db40cfd1dc@AcuMS.aculab.com>
References: <20230920192300.3772199-1-goldstein.w.n@gmail.com>
 <202309231130.ZI5MdlDc-lkp@intel.com>
 <CAFUsyfKDRiX9kKOhHcA4PLqqT6Q5faHF0eRGiKN+9NSbvrUfDw@mail.gmail.com>
 <d02bd4f823534a00ae4915ead3d92773@AcuMS.aculab.com>
 <CAFUsyfL0M5P4+4s_b1kvJ_fE-ax8YBK0ammbKfoy7yKs1obzrA@mail.gmail.com>
 <CAFUsyfJduB29c6=BNmTtgoWcHAWA1AZ-sdbhyp02JVhvA6Gp0w@mail.gmail.com>
 <CAFUsyfLuo0_Sm91mqbM8Sbo-ncwnM4RaRq=GxQXDmkAN-nQ3uw@mail.gmail.com>
 <CAHk-=wgv6h4ru=z8UR5XyutoRKveOetNpwovHburvRgG9NSa3g@mail.gmail.com>
 <CAHk-=wiNUucmvTKGmveWzXXe99SpOwU65nFtH-A2_aUpPsAPJQ@mail.gmail.com>
 <5354eeec562345f6a1de84f0b2081b75@AcuMS.aculab.com>
 <CAHk-=wg8vssPVO68_qH_BHBCj6_DDawKQHBOgZh4gw5YFmpCKA@mail.gmail.com>
 <204bf145e6ad47219c005e9a4407ebdc@AcuMS.aculab.com>
 <CAHk-=wjGaH6oA47WkphTweMiy15Zjfuk-aVcXSasMX=aX9rFLQ@mail.gmail.com>
 <CANn89iKjUZjw-9ACNWrEd_H+o79Uwkw9NVuujQ3w=c2pGRFotg@mail.gmail.com>
In-Reply-To: <CANn89iKjUZjw-9ACNWrEd_H+o79Uwkw9NVuujQ3w=c2pGRFotg@mail.gmail.com>
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

RnJvbTogRXJpYyBEdW1hemV0DQo+IFNlbnQ6IDA2IEphbnVhcnkgMjAyNCAxMDoyNg0KLi4uDQo+
IE9uIGEgcmVsYXRlZCBub3RlLCBhdCBsZWFzdCB3aXRoIGNsYW5nLCBJIGZvdW5kIHRoYXQgY3N1
bV9pcHY2X21hZ2ljKCkNCj4gaXMgbmVlZGxlc3NseSB1c2luZyB0ZW1wb3Jhcnkgb24tc3RhY2sg
c3RvcmFnZSwNCj4gc2hvd2luZyBhIHN0YWxsIG9uIENhc2NhZGUgTGFrZSB1bmxlc3MgSSBhbSBw
YXRjaGluZyBhZGQzMl93aXRoX2NhcnJ5KCkgOg0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2
L2luY2x1ZGUvYXNtL2NoZWNrc3VtXzY0LmgNCj4gYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9jaGVj
a3N1bV82NC5oDQo+IGluZGV4IDQwN2JlZWJhZGFmNDVhNzQ4ZjkxYTM2Yjc4YmQxZDAyMzQ0OWIx
MzIuLmMzZDZmNDc2MjZjNzBkODFmMGMyYmE0MDFkODUwNTBiMDlhMzk5MjINCj4gMTAwNjQ0DQo+
IC0tLSBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL2NoZWNrc3VtXzY0LmgNCj4gKysrIGIvYXJjaC94
ODYvaW5jbHVkZS9hc20vY2hlY2tzdW1fNjQuaA0KPiBAQCAtMTcxLDcgKzE3MSw3IEBAIHN0YXRp
YyBpbmxpbmUgdW5zaWduZWQgYWRkMzJfd2l0aF9jYXJyeSh1bnNpZ25lZA0KPiBhLCB1bnNpZ25l
ZCBiKQ0KPiAgICAgICAgIGFzbSgiYWRkbCAlMiwlMFxuXHQiDQo+ICAgICAgICAgICAgICJhZGNs
ICQwLCUwIg0KPiAgICAgICAgICAgICA6ICI9ciIgKGEpDQo+IC0gICAgICAgICAgIDogIjAiIChh
KSwgInJtIiAoYikpOw0KPiArICAgICAgICAgICA6ICIwIiAoYSksICJyIiAoYikpOw0KPiAgICAg
ICAgIHJldHVybiBhOw0KPiAgfQ0KDQpUcnkgcmVwbGFjaW5nOg0KCXJldHVybiBjc3VtX2ZvbGQo
DQoJICAgICAgIChfX2ZvcmNlIF9fd3N1bSlhZGQzMl93aXRoX2NhcnJ5KHN1bTY0ICYgMHhmZmZm
ZmZmZiwgc3VtNjQ+PjMyKSk7DQp3aXRoOg0KCXJldHVybiBjc3VtX2ZvbGQoKF9fZm9yY2UgX193
c3VtKSgoc3VtNjQgKyByb3I2NChzdW02NCwgMzIpKSA+PiAzMikpOw0KDQpTaG91bGQgYmUgbGVz
cyBpbnN0cnVjdGlvbnMgYXMgd2VsbC4NCihzaGlmdCwgYWRkLCBzaGlmdCB2IHNoaWZ0LCBtb3Ys
IGFuZCwgYWRkLCBhZGQpDQpBbHRob3VnaCBib3RoIG1pZ2h0IGJlIDMgY2xvY2tzLg0KDQpUaGUg
YmVzdCBDIHZlcnNpb24gb2YgY3N1bV9mb2xkIChmcm9tIElJUkMgYXJjKSBpcyBhbHNvIGxpa2Vs
eSB0byBiZQ0KYmV0dGVyIHRoYW4gdGhlIHg4NiBhc20gb25lIC0gY2VydGFpbmx5IG5vIHdvcnNl
Lg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJv
YWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24g
Tm86IDEzOTczODYgKFdhbGVzKQ0K


