Return-Path: <linux-kernel+bounces-5484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A96B818B35
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 16:26:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57FA2283C7F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D8F81CA82;
	Tue, 19 Dec 2023 15:26:42 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E9A1CF8A
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 15:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-63--MssvIPyP6awiriq4uC_pg-1; Tue, 19 Dec 2023 15:26:27 +0000
X-MC-Unique: -MssvIPyP6awiriq4uC_pg-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 19 Dec
 2023 15:26:11 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Tue, 19 Dec 2023 15:26:11 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Jacob Keller' <jacob.e.keller@intel.com>, Suman Ghosh
	<sumang@marvell.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"sgoutham@marvell.com" <sgoutham@marvell.com>, "sbhatta@marvell.com"
	<sbhatta@marvell.com>, "jerinj@marvell.com" <jerinj@marvell.com>,
	"gakula@marvell.com" <gakula@marvell.com>, "hkelam@marvell.com"
	<hkelam@marvell.com>, "lcherian@marvell.com" <lcherian@marvell.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [net PATCH] octeontx2-af: Fix marking couple of structure as
 __packed
Thread-Topic: [net PATCH] octeontx2-af: Fix marking couple of structure as
 __packed
Thread-Index: AQHaMfL5LSuKUocy/Uq8m0SZmFOeabCwuX2Q
Date: Tue, 19 Dec 2023 15:26:11 +0000
Message-ID: <35751ffb2c4d436baaa93230c1430a03@AcuMS.aculab.com>
References: <20231218082758.247831-1-sumang@marvell.com>
 <c48b24d9-f05f-4c66-a0ca-5cd6f59bea0c@intel.com>
In-Reply-To: <c48b24d9-f05f-4c66-a0ca-5cd6f59bea0c@intel.com>
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

RnJvbTogSmFjb2IgS2VsbGVyDQo+IFNlbnQ6IDE4IERlY2VtYmVyIDIwMjMgMjA6NDQNCj4gDQo+
IE9uIDEyLzE4LzIwMjMgMTI6MjcgQU0sIFN1bWFuIEdob3NoIHdyb3RlOg0KPiA+IENvdXBsZSBv
ZiBzdHJ1Y3R1cmVzIHdhcyBub3QgbWFya2VkIGFzIF9fcGFja2VkIHdoaWNoIG1heSBoYXZlIHNv
bWUNCj4gPiBwZXJmb3JtYW5jZSBpbXBsaWNhdGlvbi4gVGhpcyBwYXRjaCBmaXhlcyB0aGUgc2Ft
ZSBhbmQgbWFyayB0aGVtIGFzDQo+ID4gX19wYWNrZWQuDQo+IA0KPiBOb3Qgc3VyZSBJIGZvbGxv
dyB3aHkgbGFjayBvZiBfX3BhY2tlZCB3b3VsZCBoYXZlIHBlcmZvcm1hbmNlDQo+IGltcGxpY2F0
aW9ucz8gSSBnZXQgdGhhdCBfX3BhY2tlZCBpcyBpbXBvcnRhbnQgdG8gZW5zdXJlIGxheW91dCBp
cw0KPiBjb3JyZWN0IG9yIHRvIGVuc3VyZSB0aGUgd2hvbGUgc3RydWN0dXJlIGhhcyB0aGUgcmln
aHQgc2l6ZSByYXRoZXIgdGhhbg0KPiB1bmV4cGVjdGVkIGdhcHMuIEknZCBndWVzcyBtYXliZSBi
ZWNhdXNlIHRoZSBzdHJ1Y3R1cmVzIHNpemUgd291bGQNCj4gaW5jbHVkZSBwYWRkaW5nIHdpdGhv
dXQgX19wYWNrZWQsIGxlYWRpbmcgdG8gYSBsb3Qgb2YgZ2FwcyB3aGVuDQo+IGNvbWJpbmluZyBz
ZXZlcmFsIHN0cnVjdHVyZXMgdG9nZXRoZXIuLi4NCj4gDQo+IEkgZGlkIHRlc3Qgb24gbXkgc3lz
dGVtIHdpdGggcGFob2xlLCBhbmQgZXZlbiB3aXRob3V0IF9fcGFja2VkLCBJIGRvbid0DQo+IGdl
dCBhbnkgZ2FwcyBpbiB0aGUgbnBjX2x0X2RlZl9jZmcgc3RydWN0dXJlOg0KPiANCj4gDQo+ID4g
c3RydWN0IG5wY19sdF9kZWZfY2ZnIHsNCj4gPiAgICAgICAgIHN0cnVjdCBucGNfbHRfZGVmICAg
ICAgICAgIHJ4X29sMjsgICAgICAgICAgICAgICAvKiAgICAgMCAgICAgMyAqLw0KPiA+ICAgICAg
ICAgc3RydWN0IG5wY19sdF9kZWYgICAgICAgICAgcnhfb2lwNDsgICAgICAgICAgICAgIC8qICAg
ICAzICAgICAzICovDQo+ID4gICAgICAgICBzdHJ1Y3QgbnBjX2x0X2RlZiAgICAgICAgICByeF9p
aXA0OyAgICAgICAgICAgICAgLyogICAgIDYgICAgIDMgKi8NCj4gPiAgICAgICAgIHN0cnVjdCBu
cGNfbHRfZGVmICAgICAgICAgIHJ4X29pcDY7ICAgICAgICAgICAgICAvKiAgICAgOSAgICAgMyAq
Lw0KPiA+ICAgICAgICAgc3RydWN0IG5wY19sdF9kZWYgICAgICAgICAgcnhfaWlwNjsgICAgICAg
ICAgICAgIC8qICAgIDEyICAgICAzICovDQo+ID4gICAgICAgICBzdHJ1Y3QgbnBjX2x0X2RlZiAg
ICAgICAgICByeF9vdGNwOyAgICAgICAgICAgICAgLyogICAgMTUgICAgIDMgKi8NCj4gPiAgICAg
ICAgIHN0cnVjdCBucGNfbHRfZGVmICAgICAgICAgIHJ4X2l0Y3A7ICAgICAgICAgICAgICAvKiAg
ICAxOCAgICAgMyAqLw0KPiA+ICAgICAgICAgc3RydWN0IG5wY19sdF9kZWYgICAgICAgICAgcnhf
b3VkcDsgICAgICAgICAgICAgIC8qICAgIDIxICAgICAzICovDQo+ID4gICAgICAgICBzdHJ1Y3Qg
bnBjX2x0X2RlZiAgICAgICAgICByeF9pdWRwOyAgICAgICAgICAgICAgLyogICAgMjQgICAgIDMg
Ki8NCj4gPiAgICAgICAgIHN0cnVjdCBucGNfbHRfZGVmICAgICAgICAgIHJ4X29zY3RwOyAgICAg
ICAgICAgICAvKiAgICAyNyAgICAgMyAqLw0KPiA+ICAgICAgICAgc3RydWN0IG5wY19sdF9kZWYg
ICAgICAgICAgcnhfaXNjdHA7ICAgICAgICAgICAgIC8qICAgIDMwICAgICAzICovDQo+ID4gICAg
ICAgICBzdHJ1Y3QgbnBjX2x0X2RlZl9pcHNlYyAgICByeF9pcHNlY1syXTsgICAgICAgICAgLyog
ICAgMzMgICAgMTAgKi8NCj4gPiAgICAgICAgIHN0cnVjdCBucGNfbHRfZGVmICAgICAgICAgIHBj
a19vbDI7ICAgICAgICAgICAgICAvKiAgICA0MyAgICAgMyAqLw0KPiA+ICAgICAgICAgc3RydWN0
IG5wY19sdF9kZWYgICAgICAgICAgcGNrX29pcDQ7ICAgICAgICAgICAgIC8qICAgIDQ2ICAgICAz
ICovDQo+ID4gICAgICAgICBzdHJ1Y3QgbnBjX2x0X2RlZiAgICAgICAgICBwY2tfb2lwNjsgICAg
ICAgICAgICAgLyogICAgNDkgICAgIDMgKi8NCj4gPiAgICAgICAgIHN0cnVjdCBucGNfbHRfZGVm
ICAgICAgICAgIHBja19paXA0OyAgICAgICAgICAgICAvKiAgICA1MiAgICAgMyAqLw0KPiA+ICAg
ICAgICAgc3RydWN0IG5wY19sdF9kZWZfYXBhZCAgICAgcnhfYXBhZDA7ICAgICAgICAgICAgIC8q
ICAgIDU1ICAgICA0ICovDQo+ID4gICAgICAgICBzdHJ1Y3QgbnBjX2x0X2RlZl9hcGFkICAgICBy
eF9hcGFkMTsgICAgICAgICAgICAgLyogICAgNTkgICAgIDQgKi8NCj4gPiAgICAgICAgIHN0cnVj
dCBucGNfbHRfZGVmX2NvbG9yICAgIG92bGFuOyAgICAgICAgICAgICAgICAvKiAgICA2MyAgICAg
NSAqLw0KPiA+ICAgICAgICAgLyogLS0tIGNhY2hlbGluZSAxIGJvdW5kYXJ5ICg2NCBieXRlcykg
d2FzIDQgYnl0ZXMgYWdvIC0tLSAqLw0KPiA+ICAgICAgICAgc3RydWN0IG5wY19sdF9kZWZfY29s
b3IgICAgaXZsYW47ICAgICAgICAgICAgICAgIC8qICAgIDY4ICAgICA1ICovDQo+ID4gICAgICAg
ICBzdHJ1Y3QgbnBjX2x0X2RlZl9jb2xvciAgICByeF9nZW4wX2NvbG9yOyAgICAgICAgLyogICAg
NzMgICAgIDUgKi8NCj4gPiAgICAgICAgIHN0cnVjdCBucGNfbHRfZGVmX2NvbG9yICAgIHJ4X2dl
bjFfY29sb3I7ICAgICAgICAvKiAgICA3OCAgICAgNSAqLw0KPiA+ICAgICAgICAgc3RydWN0IG5w
Y19sdF9kZWZfZXQgICAgICAgcnhfZXRbMl07ICAgICAgICAgICAgIC8qICAgIDgzICAgIDEwICov
DQo+ID4NCj4gPiAgICAgICAgIC8qIHNpemU6IDkzLCBjYWNoZWxpbmVzOiAyLCBtZW1iZXJzOiAy
MyAqLw0KPiA+ICAgICAgICAgLyogbGFzdCBjYWNoZWxpbmU6IDI5IGJ5dGVzICovDQo+ID4gfTsN
Cj4gDQo+IA0KPiBIb3dldmVyIHRoYXQgbWF5IG5vdCBiZSB0cnVlIGFjcm9zcyBhbGwgY29tcGls
ZXJzIGV0Yy4gQWxzbyBhbGwgdGhlDQo+IG90aGVyIHN0cnVjdHVyZXMgYXJlIF9fcGFja2VkLiBN
YWtlcyBzZW5zZS4NCg0KT3Igbm90IC0gbWF5YmUgYWxsIHRoZSBfX3BhY2tlZCBzaG91bGQgYmUg
cmVtb3ZlZCBpbnN0ZWFkIQ0KDQpVbmxlc3MgdGhlc2Ugc3RydWN0dXJlcyAob3IgYW55IG90aGVy
cykgYXBwZWFyIGluICdtZXNzYWdlcycgd2hpY2gNCmdldCB0cmFuc2ZlcnJlZCBiZXR3ZWVuIHN5
c3RlbXMgdGhleSByZWFsbHkgc2hvdWxkbid0IGJlIF9fcGFja2VkLg0KQW5kIGEgOTMgYnl0ZSAn
bWVzc2FnZScgd2l0aCBhbGwgdGhvc2UgZmllbGRzIHNlZW1zIHJhdGhlciBvZGQuDQoNClRoZSBh
Ym92ZSBicmVha2Rvd24gc2VlbXMgdG8gaW1wbHkgZXZlcnl0aGluZyBpcyAndW5zaWduZWQgY2hh
cicNCnNvIHRoZSBfX3BhY2tlZCBtYWtlcyBubyBkaWZmZXJlbmNlLg0KDQpVc2luZyBfX3BhY2tl
ZCByZXF1aXJlcyB0aGUgY29tcGlsZXIgZ2VuZXJhdGUgYnl0ZSBsb2Fkcy9zdG9yZQ0Kd2l0aCBz
aGlmdHMgKGV0Yykgb24gbWFueSBhcmNoaXRlY3R1cmVzIGFuZCBzaG91bGQgcmVhbGx5IGJlIGF2
b2lkZWQNCnVubGVzcyBpdCBpcyBhYnNvbHV0ZWx5IG5lZWRlZCBmb3IgYmluYXJ5IGNvbXBhdGli
aWxpdHkuDQoNCkV2ZW4gdGhlbiBpZiB0aGUgcHJvYmxlbSBpcyBhIDY0Yml0IGZpZWxkIHRoYXQg
b25seSBuZWVkcyB0byBiZQ0KMzJiaXQgYWxpZ25lZCAoYXMgaXMgY29tbW9uIGZvciBzb21lIGNv
bXBhdDMyIGNvZGUpIHRoZW4gdGhlIDY0Yml0DQpmaWVsZHMgc2hvdWxkIGJlIG1hcmtlZCBhcyBi
ZWluZyAzMmJpdCBhbGlnbmVkLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExh
a2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQs
IFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K


