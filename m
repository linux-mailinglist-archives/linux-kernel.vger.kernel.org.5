Return-Path: <linux-kernel+bounces-17766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6529825246
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 11:41:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 641161F223B8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 10:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 407F8250E5;
	Fri,  5 Jan 2024 10:41:46 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1062420A
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 10:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-227-JTt10EHAO72Sjjiu8P_e8g-1; Fri, 05 Jan 2024 10:41:41 +0000
X-MC-Unique: JTt10EHAO72Sjjiu8P_e8g-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 5 Jan
 2024 10:41:25 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 5 Jan 2024 10:41:25 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Linus Torvalds' <torvalds@linux-foundation.org>, Noah Goldstein
	<goldstein.w.n@gmail.com>
CC: kernel test robot <lkp@intel.com>, "x86@kernel.org" <x86@kernel.org>,
	"oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"edumazet@google.com" <edumazet@google.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de"
	<bp@alien8.de>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"hpa@zytor.com" <hpa@zytor.com>
Subject: RE: x86/csum: Remove unnecessary odd handling
Thread-Topic: x86/csum: Remove unnecessary odd handling
Thread-Index: AQHZ7ib2fs4a8+P0bkWBCjHsrqR0abAo6HRAgKIYy6qAAJmVUA==
Date: Fri, 5 Jan 2024 10:41:24 +0000
Message-ID: <5354eeec562345f6a1de84f0b2081b75@AcuMS.aculab.com>
References: <20230920192300.3772199-1-goldstein.w.n@gmail.com>
 <202309231130.ZI5MdlDc-lkp@intel.com>
 <CAFUsyfKDRiX9kKOhHcA4PLqqT6Q5faHF0eRGiKN+9NSbvrUfDw@mail.gmail.com>
 <d02bd4f823534a00ae4915ead3d92773@AcuMS.aculab.com>
 <CAFUsyfL0M5P4+4s_b1kvJ_fE-ax8YBK0ammbKfoy7yKs1obzrA@mail.gmail.com>
 <CAFUsyfJduB29c6=BNmTtgoWcHAWA1AZ-sdbhyp02JVhvA6Gp0w@mail.gmail.com>
 <CAFUsyfLuo0_Sm91mqbM8Sbo-ncwnM4RaRq=GxQXDmkAN-nQ3uw@mail.gmail.com>
 <CAHk-=wgv6h4ru=z8UR5XyutoRKveOetNpwovHburvRgG9NSa3g@mail.gmail.com>
 <CAHk-=wiNUucmvTKGmveWzXXe99SpOwU65nFtH-A2_aUpPsAPJQ@mail.gmail.com>
In-Reply-To: <CAHk-=wiNUucmvTKGmveWzXXe99SpOwU65nFtH-A2_aUpPsAPJQ@mail.gmail.com>
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

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMDUgSmFudWFyeSAyMDI0IDAwOjMzDQo+IA0K
PiBPbiBUaHUsIDQgSmFuIDIwMjQgYXQgMTU6MzYsIExpbnVzIFRvcnZhbGRzDQo+IDx0b3J2YWxk
c0BsaW51eC1mb3VuZGF0aW9uLm9yZz4gd3JvdGU6DQo+ID4NCj4gPiBBbnl3YXksIHNpbmNlIEkg
bG9va2VkIGF0IHRoZSB0aGluZyBvcmlnaW5hbGx5LCBhbmQgZmVlbCBsaWtlIEkga25vdw0KPiA+
IHRoZSB4ODYgc2lkZSBhbmQgdW5kZXJzdGFuZCB0aGUgc3RyYW5nZSBJUCBjc3VtIHRvbywgSSBq
dXN0IGFwcGxpZWQgaXQNCj4gPiBkaXJlY3RseS4NCj4gDQo+IEkgZW5kZWQgdXAganVzdCBhcHBs
eWluZyBteSA0MC1ieXRlIGNsZWFudXAgdGhpbmcgdG9vIHRoYXQgSSd2ZSBiZWVuDQo+IGtlZXBp
bmcgaW4gbXkgb3duIHRyZWUgc2luY2UgcG9zdGluZyBpdCAoYXMgdGhlICJTaWxseSBjc3VtDQo+
IGltcHJvdmVtZW50LiBNYXliZSIgcGF0Y2gpLg0KDQpJbnRlcmVzdGluZywgSSdtIHByZXR0eSBz
dXJlIHRyeWluZyB0byBnZXQgdHdvIGJsb2NrcyBvZg0KICdhZGMnIHNjaGVkdWxlZCBpbiBwYXJh
bGxlbCBsaWtlIHRoYXQgZG9lc24ndCB3b3JrLg0KDQpJIGdvdCBhbiBhZGMgZXZlcnkgY2xvY2sg
ZnJvbSB0aGlzICdiZWFzdCc6DQorICAgICAgIC8qDQorICAgICAgICAqIEFsaWduIHRoZSBieXRl
IGNvdW50IHRvIGEgbXVsdGlwbGUgb2YgMTYgdGhlbg0KKyAgICAgICAgKiBhZGQgNjQgYml0IHdv
cmRzIHRvIGFsdGVybmF0aW5nIHJlZ2lzdGVycy4NCisgICAgICAgICogRmluYWxseSByZWR1Y2Ug
dG8gNjQgYml0cy4NCisgICAgICAgICovDQorICAgICAgIGFzbSggICAgIiAgICAgICBidCAgICAk
NCwgJVtsZW5dXG4iDQorICAgICAgICAgICAgICAgIiAgICAgICBqbmMgICAxMGZcbiINCisgICAg
ICAgICAgICAgICAiICAgICAgIGFkZCAgICglW2J1ZmZdLCAlW2xlbl0pLCAlW3N1bV8wXVxuIg0K
KyAgICAgICAgICAgICAgICIgICAgICAgYWRjICAgOCglW2J1ZmZdLCAlW2xlbl0pLCAlW3N1bV8x
XVxuIg0KKyAgICAgICAgICAgICAgICIgICAgICAgbGVhICAgMTYoJVtsZW5dKSwgJVtsZW5dXG4i
DQorICAgICAgICAgICAgICAgIjEwOiAgICBqZWN4eiAyMGZcbiINCisgICAgICAgICAgICAgICAi
ICAgICAgIGFkYyAgICglW2J1ZmZdLCAlW2xlbl0pLCAlW3N1bV8wXVxuIg0KKyAgICAgICAgICAg
ICAgICIgICAgICAgYWRjICAgOCglW2J1ZmZdLCAlW2xlbl0pLCAlW3N1bV8xXVxuIg0KKyAgICAg
ICAgICAgICAgICIgICAgICAgbGVhICAgMzIoJVtsZW5dKSwgJVtsZW5fdG1wXVxuIg0KKyAgICAg
ICAgICAgICAgICIgICAgICAgYWRjICAgMTYoJVtidWZmXSwgJVtsZW5dKSwgJVtzdW1fMF1cbiIN
CisgICAgICAgICAgICAgICAiICAgICAgIGFkYyAgIDI0KCVbYnVmZl0sICVbbGVuXSksICVbc3Vt
XzFdXG4iDQorICAgICAgICAgICAgICAgIiAgICAgICBtb3YgICAlW2xlbl90bXBdLCAlW2xlbl1c
biINCisgICAgICAgICAgICAgICAiICAgICAgIGptcCAgIDEwYlxuIg0KKyAgICAgICAgICAgICAg
ICIyMDogICAgYWRjICAgJVtzdW1fMF0sICVbc3VtXVxuIg0KKyAgICAgICAgICAgICAgICIgICAg
ICAgYWRjICAgJVtzdW1fMV0sICVbc3VtXVxuIg0KKyAgICAgICAgICAgICAgICIgICAgICAgYWRj
ICAgJDAsICVbc3VtXVxuIg0KKyAgICAgICAgICAgOiBbc3VtXSAiKyZyIiAoc3VtKSwgW3N1bV8w
XSAiKyZyIiAoc3VtXzApLCBbc3VtXzFdICIrJnIiIChzdW1fMSksDQorICAgICAgICAgICAgICAg
W2xlbl0gIismYyIgKGxlbiksIFtsZW5fdG1wXSAiPSZyIiAobGVuX3RtcCkNCisgICAgICAgICAg
IDogW2J1ZmZdICJyIiAoYnVmZikNCisgICAgICAgICAgIDogIm1lbW9yeSIgKTsNCg0KRm9sbG93
ZWQgYnkgY29kZSB0byBzb3J0IG91dCBhbmQgdHJhaWxpbmcgMTUgYnl0ZXMuDQoNCkludGVsIGNw
dSAoZnJvbSBQLUlJIHVudGlsIEJyb2Fkd2VsbCA1dGgtZ2VuKSB0YWtlIHR3byBjbG9ja3MgZm9y
ICdhZGMnDQoocHJvYmFibHkgYmVjYXVzZSBpdCBuZWVkcyAzIGlucHV0cykuDQpTbyAnYWRjJyAg
Y2hhaW5zIHJhbiBhIGxvdCBzbG93ZXIgdGhhbiB5b3UgbWlnaHQgdGhpbmsuDQooQ2xlYXJseSBu
byBvbmUgZXZlciBhY3R1YWxseSBiZW5jaG1hcmtlZCB0aGUgb2xkIGNvZGUhKQ0KVGhlIGZpcnN0
IGZpeCBtYWRlIHRoZSBjYXJyeSBvdXRwdXQgYXZhaWxhYmxlIGVhcmx5IC0gc28gYWRkaW5nDQp0
byBhbHRlcm5hdGUgcmVnaXN0ZXJzIGhlbHBzLiBJSVJDIHRoaXMgaXMgaW4gSXZ5L1NhbmR5IGJy
aWRnZS4NCk1heWJlIG5vIG9uZSBjYXJlcyBhYm91dCBJdnkvU2FuZHkgYnJpZGdlIGFuZCBIYXN3
ZWxsIGFueSBtb3JlLg0KQU1EIGNwdSBkb24ndCBoYXZlIHRoaXMgcHJvYmxlbS4NCg0KSSdtIHBy
ZXR0eSBzdXJlIEkgbWVhc3VyZWQgdGhhdCBsb29wIHdpdGggYSBtaXNhbGlnbmVkIGJ1ZmZlci4N
Ck1lYXN1cmFibHkgc2xvd2VyLCBidXQgbGVzcyB0aGFuIG9uZSBjbG9jayBwZXIgY2FjaGUgbGlu
ZS4NCkkgZ3Vlc3MgdGhhdCB0aGUgY2FjaGUtbGluZSBjcm9zc2luZyByZWFkcyBnZXQgc3BsaXQs
IGJ1dCB5b3UNCmdhaW4gbW9zdCBiYWNrIGJlY2F1c2UgdGhlIGNwdSBjYW4gZG8gdHdvIHJlYWRz
L2Nsb2NrLg0KDQpNYXliZSBJJ2xsIHNvcnQgb3V0IGFub3RoZXIgcGF0Y2guLi4NCg0KSSBkaWQg
Z2V0IDE1LzE2IGJ5dGVzL2Nsb2NrIHdpdGggYSBzaW1pbGFyIGxvb3AgdGhhdCB1c2VkIGFkb3gv
YWRjeA0KYnV0IHRoYXQgbmVlZGVkIHVucm9sbGluZyBhZ2FpbiBhbmQgb25seSB3b3JrcyBvbiBh
IGZldyBjcHUuDQpJSVJDIGFtZCBoYXZlIHNvbWUgY3B1IHRoYXQgc3VwcG9ydCBhZG94IC0gYnV0
IGV4ZWN1dGUgaXQgc2xvd2x5IQ0KQW5ub3lpbmdseSB5b3UgY2FuJ3QgdXNlICdsb29wJyBldmVu
IG9uIGNwdSB0aGF0IHN1cHBvcnQgYWRveA0KYmVjYXVzZSBpdCBpcyBzdHVwaWRseSBzbG93IG9u
IGludGVsIGNwdSAob2sgb24gYW1kKS4NCg0KVGhhdCB2ZXJzaW9uIGlzIGEgbG90IG9mIHBhaW4g
c2luY2UgaXQgbmVlZHMgcnVuLXRpbWUgcGF0Y2hpbmcuDQoNCglEYXZpZA0KDQotDQpSZWdpc3Rl
cmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtl
eW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=


