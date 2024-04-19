Return-Path: <linux-kernel+bounces-151027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 250AE8AA81D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 07:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7C05B21B8C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 05:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A12D26D;
	Fri, 19 Apr 2024 05:56:24 +0000 (UTC)
Received: from h3cspam02-ex.h3c.com (smtp.h3c.com [60.191.123.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34BEBE65;
	Fri, 19 Apr 2024 05:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.191.123.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713506184; cv=none; b=tz/ZqutAtds66u2CI5ClH4wg1c7UVrxJqHFUhd/jTwCMZ4JzFqygKzv6gcEx+oKv2ApLcgNn+jUnaR7MJUjzcT5zp9apc/cGTynnvARgoozS/Qnn/xhXG4JsMnLWUecAKXpBJZ46pobTVos5kUpYTYY2AOcVgvAchekZoOodo5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713506184; c=relaxed/simple;
	bh=6yzIPDNpMLVX9Xz8Pzth7r6bTTRxdck5HIFzebwGR88=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=F7OexKVfms5z9nRgMeXVMxTrXXev8gMuK7SBBM9Ci1AGInaCQrKF1/za1jT1loN337V6Vzc1hK94RUVGzVH2sYmJQYKMFx9fAQB0f3Zy4QAKi5RGKMI2Ea5nCEHx/ARyqRe1KHp8HJj27DqRpSuamOPOCNhYyuO3/v8Qdmvojrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com; spf=pass smtp.mailfrom=h3c.com; arc=none smtp.client-ip=60.191.123.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h3c.com
Received: from mail.maildlp.com ([172.25.15.154])
	by h3cspam02-ex.h3c.com with ESMTP id 43J5svZE030934;
	Fri, 19 Apr 2024 13:54:57 +0800 (GMT-8)
	(envelope-from liu.yeC@h3c.com)
Received: from DAG6EX10-BJD.srv.huawei-3com.com (unknown [10.153.34.12])
	by mail.maildlp.com (Postfix) with ESMTP id 59B962004BD6;
	Fri, 19 Apr 2024 13:57:19 +0800 (CST)
Received: from DAG6EX02-IMDC.srv.huawei-3com.com (10.62.14.11) by
 DAG6EX10-BJD.srv.huawei-3com.com (10.153.34.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.27; Fri, 19 Apr 2024 13:54:58 +0800
Received: from DAG6EX02-IMDC.srv.huawei-3com.com ([fe80::4c21:7c89:4f9d:e4c4])
 by DAG6EX02-IMDC.srv.huawei-3com.com ([fe80::4c21:7c89:4f9d:e4c4%16]) with
 mapi id 15.02.1258.027; Fri, 19 Apr 2024 13:54:58 +0800
From: Liuye <liu.yeC@h3c.com>
To: Greg KH <gregkh@linuxfoundation.org>,
        "daniel.thompson@linaro.org"
	<daniel.thompson@linaro.org>
CC: "dianders@chromium.org" <dianders@chromium.org>,
        "jason.wessel@windriver.com" <jason.wessel@windriver.com>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "kgdb-bugreport@lists.sourceforge.net"
	<kgdb-bugreport@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-serial@vger.kernel.org"
	<linux-serial@vger.kernel.org>,
        "andy.shevchenko@gmail.com"
	<andy.shevchenko@gmail.com>
Subject: =?utf-8?B?UmU6IFJlOiBSZe+8mltQQVRDSCBWMTFdIGtkYjogRml4IHRoZSBkZWFkbG9j?=
 =?utf-8?Q?k_issue_in_KDB_debugging.?=
Thread-Topic: =?utf-8?B?UmU6IFJl77yaW1BBVENIIFYxMV0ga2RiOiBGaXggdGhlIGRlYWRsb2NrIGlz?=
 =?utf-8?Q?sue_in_KDB_debugging.?=
Thread-Index: AdqSHaw21DgRgJC5RcSP9pEIk8krFg==
Date: Fri, 19 Apr 2024 05:54:58 +0000
Message-ID: <ac27269989394d8dac859763bc7578d6@h3c.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-sender-location: DAG2
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:h3cspam02-ex.h3c.com 43J5svZE030934

Pk9uIFdlZCwgQXByIDE3LCAyMDI0IGF0IDExOjAxOjU2QU0gKzAwMDAsIExpdXllIHdyb3RlOg0K
Pj4gPi0tLQ0KPj4gPlYxMCAtPiBWMTE6IFJldmVydCB0byBWOQ0KPj4gPlY5IC0+IFYxMCA6IEFk
ZCBTaWduZWQtb2ZmLWJ5IG9mIEdyZWcgS0ggYW5kIEFuZHkgU2hldmNoZW5rbywgQWNrZWQNCj4+
ID4gICAgICAgICAgICBieSBvZiBEYW5pZWwgVGhvbXBzb24NCj4+ID5WOCAtPiBWOTogTW9kaWZ5
IGNhbGwgdHJhY2UgZm9ybWF0IGFuZCBtb3ZlIGlycV93b3JrLmggYmVmb3JlIG1vZHVsZS5oDQo+
PiA+VjcgLT4gVjg6IFVwZGF0ZSB0aGUgZGVzY3JpcHRpb24gaW5mb3JtYXRpb24gYW5kIGNvbW1l
bnRzIGluIHRoZSBjb2RlLg0KPj4gPgkgICA6IFN1Ym1pdCB0aGlzIHBhdGNoIGJhc2VkIG9uIHZl
cnNpb24gbGludXgtNi45LXJjMi4NCj4+ID5WNiAtPiBWNzogQWRkIGNvbW1lbnRzIGluIHRoZSBj
b2RlLg0KPj4gPlY1IC0+IFY2OiBSZXBsYWNlIHdpdGggYSBtb3JlIHByb2Zlc3Npb25hbCBhbmQg
YWNjdXJhdGUgYW5zd2VyLg0KPj4gPlY0IC0+IFY1OiBBbnN3ZXIgd2h5IHNjaGVkdWxlIGFub3Ro
ZXIgd29yayBpbiB0aGUgaXJxX3dvcmsgYW5kIG5vdCBkbw0KPj4gPiAgICAgICAgICB0aGUgam9i
IGRpcmVjdGx5Lg0KPj4gPlYzIC0+IFY0OiBBZGQgY2hhbmdlbG9ncw0KPj4gPlYyIC0+IFYzOiBB
ZGQgZGVzY3JpcHRpb24gaW5mb3JtYXRpb24NCj4+ID5WMSAtPiBWMjogdXNpbmcgaXJxX3dvcmsg
dG8gc29sdmUgdGhpcyBwcm9wZXJseS4NCj4+ID4tLS0NCj4+DQo+PiBXaGF0IGlzIHRoZSBjdXJy
ZW50IHN0YXR1cyBvZiBQQVRDSCBWMTE/IEFyZSB0aGVyZSBhbnkgYWRkaXRpb25hbA0KPj4gbW9k
aWZpY2F0aW9ucyBuZWVkZWQ/DQo+DQo+SSB1bmRlcnN0b29kIHRoYXQgaXMgYmxvY2tlZCBwZW5k
aW5nIG91dGNvbWUgb2YgdGhlIGxlZ2FsIG1hdHRlcnMNCj5yYWlzZWQgYnkgdjEwLi4uICBhbmQg
dGhhdCB0aGlzIGlzIHdoeSB5b3Ugd2VyZSBhc2tlZCBub3QgdG8gcG9zdA0KPnYxMSB1bnRpbCB0
aGV5IGhhZCBiZWVuIHJlc29sdmVkLg0KPg0KPlRvIGJlIGhvbmVzdCBnaXZlbiB0aGF0IFtJIHdy
b3RlIGFsbCBvZiB0aGUgQyBjb2RlXVsxXSBmb3IgdGhlIG1vc3QNCj5yZWNlbnQgdmVyc2lvbiBv
ZiB0aGUgcGF0Y2ggYW5kIHRoYXQgSSdkIGxpa2UgdG8gc2VlIHRoZSBidWcgZml4ZWQsDQo+dGhl
biBJIHdpbGwgcHJvYmFibHkgaGF2ZSB0byBnaXZlIHVwIG9uIGNvLWF1dGhvcnNoaXAuIEluc3Rl
YWQgSSBjYW4NCj5wb3N0IG15IGNvZGUgd2l0aCBhIG5ldyBjb21tZW50IGFuZCBwYXRjaCBkZXNj
cmlwdGlvbiBhbmQgY3JlZGl0IHlvdQ0KPndpdGggYSBSZXBvcnRlZC1ieTouIFRoYXQgc2hvdWxk
IHRha2UgdGhlIHByZXNzdXJlIG9mZiBpbiB0ZXJtcyBvZg0KPmxhbmRpbmcgdGhpcyBidWcgZml4
Lg0KDQpARGFuaWVsDQoNClllcywgeW91IGNhbiBkbyBpdCB0aGlzIHdheS4gVG8gZml4IHRoaXMg
YnVnIGFzIHNvb24gYXMgcG9zc2libGUsIGZvbGxvdyB3aGF0IHlvdSBzYWlkLiBJIGFncmVlLg0K
DQo+SG93ZXZlciwgdGhlIGxlZ2FsIGlzc3VlcyBkbyBzdGlsbCBuZWVkIHRvIGJlIHJlc29sdmVk
IG9yIHRoZXJlIGlzIGENCj5yaXNrIHRoYXQgb3RoZXIgdXBzdHJlYW0gY29udHJpYnV0aW9ucyBm
cm9tIHlvdXIgY29tcGFueSB3aWxsIGJlDQo+ZGVsYXllZC4NCg0KQEdyZWcgS0gNCg0KVGhpcyBp
c3N1ZSBzdGlsbCBuZWVkcyB0byBiZSByZXNvbHZlZCwgYnV0IEkgZG9uJ3Qga25vdyBob3cgdG8g
ZG8gaXQuIA0KUGxlYXNlIHRlbGwgbWUgYW4gZWZmZWN0aXZlIHN0cmF0ZWd5LiBIb3cgc2hvdWxk
IGZlZWRiYWNrIGJlIGdpdmVuIHRvIG1ha2UgaXQgZWZmZWN0aXZlIGZvciB5b3U/IA0KVGhlcmUg
aXMgYWxyZWFkeSBhbiBhcHByb3ZhbCBwcm9jZXNzIGZvciBleHRlcm5hbCBlbWFpbHMgaW4gdGhl
IGN1cnJlbnQgY29tcGFueS4gDQpBbmQgYSByZXZpZXcgbWVjaGFuaXNtIGhhcyBiZWVuIGFkZGVk
IHdpdGhpbiB0aGUgdGVhbS4gQW5kIGludGVybmFsIHRyYWluaW5nIGlzIHByb3ZpZGVkLg0KVGhl
IHByZXZpb3VzIG1lbnRpb25lZCBoYXMgYmVlbiBjb21wbGV0ZWQuIFdoYXQgZWxzZSBuZWVkcyB0
byBiZSBkb25lPw0KDQpUaGFua3MNCkxpdSBZZQ0K

