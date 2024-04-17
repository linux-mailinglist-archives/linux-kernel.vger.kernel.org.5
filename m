Return-Path: <linux-kernel+bounces-148479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 537AA8A8333
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 14:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 746551C2148C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 12:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3884F13D53E;
	Wed, 17 Apr 2024 12:31:52 +0000 (UTC)
Received: from h3cspam02-ex.h3c.com (smtp.h3c.com [60.191.123.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF6E381C7;
	Wed, 17 Apr 2024 12:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.191.123.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713357111; cv=none; b=hM5U06r6l7Pg/ABmHgossXd3Iqg2SRwKgkEZEyPFAkM8Ykd3TdVGDjUHGQed0jcHNjzrqZvWPVamEYUboY5ZFT1VlfFFmch0MuKjIz8j1Q6mQ65pX3zrZxEFodRCELuxXak2msISxyiFxKYQNijpabBJJQTiehDCPlSTsQv9B2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713357111; c=relaxed/simple;
	bh=wHagZgJ1UrEYJuHzwZutWplINcdj15Jxx0feiVfHIvo=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=D/2N1mqQkFpZiywk2NMbf6CqdizlVEys/5FHPvJNnQOjbscgnhEVBtd8oNUpPIpR8VBVl6K199Y5LaMvZzCw9zr+v1WE3TQ6QRl4UXweWBDdndB5gZbjgcKFwK3UNyV71G0c9NIAQom3Tpz9JQzkvGoTbuLqili5HrfPj1C2YTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com; spf=pass smtp.mailfrom=h3c.com; arc=none smtp.client-ip=60.191.123.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h3c.com
Received: from h3cspam02-ex.h3c.com (localhost [127.0.0.2] (may be forged))
	by h3cspam02-ex.h3c.com with ESMTP id 43HB2wBl031742;
	Wed, 17 Apr 2024 19:02:58 +0800 (GMT-8)
	(envelope-from liu.yeC@h3c.com)
Received: from mail.maildlp.com ([172.25.15.154])
	by h3cspam02-ex.h3c.com with ESMTP id 43HB1rZL029440;
	Wed, 17 Apr 2024 19:01:53 +0800 (GMT-8)
	(envelope-from liu.yeC@h3c.com)
Received: from DAG6EX03-IMDC.srv.huawei-3com.com (unknown [10.62.14.12])
	by mail.maildlp.com (Postfix) with ESMTP id 2E5972004BB6;
	Wed, 17 Apr 2024 19:04:14 +0800 (CST)
Received: from DAG6EX02-IMDC.srv.huawei-3com.com (10.62.14.11) by
 DAG6EX03-IMDC.srv.huawei-3com.com (10.62.14.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.27; Wed, 17 Apr 2024 19:01:56 +0800
Received: from DAG6EX02-IMDC.srv.huawei-3com.com ([fe80::4c21:7c89:4f9d:e4c4])
 by DAG6EX02-IMDC.srv.huawei-3com.com ([fe80::4c21:7c89:4f9d:e4c4%16]) with
 mapi id 15.02.1258.027; Wed, 17 Apr 2024 19:01:56 +0800
From: Liuye <liu.yeC@h3c.com>
To: Greg KH <gregkh@linuxfoundation.org>,
        "daniel.thompson@linaro.org"
	<daniel.thompson@linaro.org>,
        "andy.shevchenko@gmail.com"
	<andy.shevchenko@gmail.com>
CC: "dianders@chromium.org" <dianders@chromium.org>,
        "jason.wessel@windriver.com" <jason.wessel@windriver.com>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "kgdb-bugreport@lists.sourceforge.net"
	<kgdb-bugreport@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-serial@vger.kernel.org"
	<linux-serial@vger.kernel.org>
Subject: =?utf-8?B?UmXvvJpbUEFUQ0ggVjExXSBrZGI6IEZpeCB0aGUgZGVhZGxvY2sgaXNzdWUg?=
 =?utf-8?Q?in_KDB_debugging.?=
Thread-Topic: =?utf-8?B?UmXvvJpbUEFUQ0ggVjExXSBrZGI6IEZpeCB0aGUgZGVhZGxvY2sgaXNzdWUg?=
 =?utf-8?Q?in_KDB_debugging.?=
Thread-Index: AdqQtooIBYtuhnKkS7qg1BKYvEtNZA==
Date: Wed, 17 Apr 2024 11:01:56 +0000
Message-ID: <186cdeea58094d06b351b07eefa2189d@h3c.com>
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
X-MAIL:h3cspam02-ex.h3c.com 43HB2wBl031742

PkZyb206IExpdVllIDxsaXUueWVDQGgzYy5jb20+DQo+DQo+Q3VycmVudGx5LCBpZiBDT05GSUdf
S0RCX0tFWUJPQVJEIGlzIGVuYWJsZWQsIHRoZW4ga2dkYm9jIHdpbGwNCj5hdHRlbXB0IHRvIHVz
ZSBzY2hlZHVsZV93b3JrKCkgdG8gcHJvdm9rZSBhIGtleWJvYXJkIHJlc2V0IHdoZW4NCj50cmFu
c2l0aW9uaW5nIG91dCBvZiB0aGUgZGVidWdnZXIgYW5kIGJhY2sgdG8gbm9ybWFsIG9wZXJhdGlv
bi4NCj5UaGlzIGNhbiBjYXVzZSBkZWFkbG9jayBiZWNhdXNlIHNjaGVkdWxlX3dvcmsoKSBpcyBu
b3QgTk1JLXNhZmUuDQo+DQo+VGhlIHN0YWNrIHRyYWNlIGJlbG93IHNob3dzIGFuIGV4YW1wbGUg
b2YgdGhlIHByb2JsZW0uIEluIHRoaXMNCj5jYXNlIHRoZSBtYXN0ZXIgY3B1IGlzIG5vdCBydW5u
aW5nIGZyb20gTk1JIGJ1dCBpdCBoYXMgcGFya2VkDQo+dGhlIHNsYXZlIENQVXMgdXNpbmcgYW4g
Tk1JIGFuZCB0aGUgcGFya2VkIENQVXMgaXMgaG9sZGluZw0KPnNwaW5sb2NrcyBuZWVkZWQgYnkg
c2NoZWR1bGVfd29yaygpLg0KPg0KPkV4YW1wbGU6DQo+QlVHOiBzcGlubG9jayBsb2NrdXAgc3Vz
cGVjdGVkIG9uIENQVSMwLiBvd25lcl9jcHU6IDENCj5DUFUxOiBDYWxsIFRyYWNlOg0KPl9fc2No
ZWR1bGUNCj5zY2hlZHVsZQ0KPnNjaGVkdWxlX2hydGltZW91dF9yYW5nZV9jbG9jaw0KPm11dGV4
X3VubG9jaw0KPmVwX3NjYW5fcmVhZHlfbGlzdA0KPnNjaGVkdWxlX2hydGltZW91dF9yYW5nZQ0K
PmVwX3BvbGwNCj53YWtlX3VwX3ENCj5TeVNfZXBvbGxfd2FpdA0KPmVudHJ5X1NZU0NBTExfNjRf
ZmFzdHBhdGgNCj4NCj5DUFUwOiBDYWxsIFRyYWNlOg0KPmR1bXBfc3RhY2sNCj5zcGluX2R1bXAN
Cj5kb19yYXdfc3Bpbl9sb2NrDQo+X3Jhd19zcGluX2xvY2sNCj50cnlfdG9fd2FrZV91cA0KPndh
a2VfdXBfcHJvY2Vzcw0KPmluc2VydF93b3JrDQo+X19xdWV1ZV93b3JrDQo+cXVldWVfd29ya19v
bg0KPmtnZGJvY19wb3N0X2V4cF9oYW5kbGVyDQo+a2dkYl9jcHVfZW50ZXINCj5rZ2RiX2hhbmRs
ZV9leGNlcHRpb24NCj5fX2tnZGJfbm90aWZ5DQo+a2dkYl9ub3RpZnkNCj5ub3RpZmllcl9jYWxs
X2NoYWluDQo+bm90aWZ5X2RpZQ0KPmRvX2ludDMNCj5pbnQzDQo+DQo+V2UgZml4IHRoZSBwcm9i
bGVtIGJ5IHVzaW5nIGlycV93b3JrIHRvIGNhbGwgc2NoZWR1bGVfd29yaygpDQo+aW5zdGVhZCBv
ZiBjYWxsaW5nIGl0IGRpcmVjdGx5LiBUaGlzIGlzIGJlY2F1c2Ugd2UgY2Fubm90DQo+cmVzeW5j
aHJvbml6ZSB0aGUga2V5Ym9hcmQgc3RhdGUgZnJvbSB0aGUgaGFyZGlycSBjb250ZXh0DQo+cHJv
dmlkZWQgYnkgaXJxX3dvcmsuIFRoaXMgbXVzdCBiZSBkb25lIGZyb20gdGhlIHRhc2sgY29udGV4
dA0KPmluIG9yZGVyIHRvIGNhbGwgdGhlIGlucHV0IHN1YnN5c3RlbS4NCj4NCj5UaGVyZWZvcmUs
IHdlIGhhdmUgdG8gZGVmZXIgdGhlIHdvcmsgdHdpY2UuIEZpcnN0LCBzYWZlbHkNCj5zd2l0Y2gg
ZnJvbSB0aGUgZGVidWcgdHJhcCBjb250ZXh0IChzaW1pbGFyIHRvIE5NSSkgdG8gdGhlDQo+aGFy
ZGlycSwgYW5kIHRoZW4gc3dpdGNoIGZyb20gdGhlIGhhcmRpcnEgdG8gdGhlIHN5c3RlbSB3b3Jr
IHF1ZXVlLg0KPg0KPlNpZ25lZC1vZmYtYnk6IExpdVllIDxsaXUueWVDQGgzYy5jb20+DQo+Q28t
ZGV2ZWxvcGVkLWJ5OiBEYW5pZWwgVGhvbXBzb24gPGRhbmllbC50aG9tcHNvbkBsaW5hcm8ub3Jn
Pg0KPlNpZ25lZC1vZmYtYnk6IERhbmllbCBUaG9tcHNvbiA8ZGFuaWVsLnRob21wc29uQGxpbmFy
by5vcmc+DQo+DQo+LS0tDQo+VjEwIC0+IFYxMTogUmV2ZXJ0IHRvIFY5DQo+VjkgLT4gVjEwIDog
QWRkIFNpZ25lZC1vZmYtYnkgb2YgR3JlZyBLSCBhbmQgQW5keSBTaGV2Y2hlbmtvLCBBY2tlZC1i
eSBvZiBEYW5pZWwgVGhvbXBzb24NCj5WOCAtPiBWOTogTW9kaWZ5IGNhbGwgdHJhY2UgZm9ybWF0
IGFuZCBtb3ZlIGlycV93b3JrLmggYmVmb3JlIG1vZHVsZS5oDQo+VjcgLT4gVjg6IFVwZGF0ZSB0
aGUgZGVzY3JpcHRpb24gaW5mb3JtYXRpb24gYW5kIGNvbW1lbnRzIGluIHRoZSBjb2RlLg0KPgk6
IFN1Ym1pdCB0aGlzIHBhdGNoIGJhc2VkIG9uIHZlcnNpb24gbGludXgtNi45LXJjMi4NCj5WNiAt
PiBWNzogQWRkIGNvbW1lbnRzIGluIHRoZSBjb2RlLg0KPlY1IC0+IFY2OiBSZXBsYWNlIHdpdGgg
YSBtb3JlIHByb2Zlc3Npb25hbCBhbmQgYWNjdXJhdGUgYW5zd2VyLg0KPlY0IC0+IFY1OiBBbnN3
ZXIgd2h5IHNjaGVkdWxlIGFub3RoZXIgd29yayBpbiB0aGUgaXJxX3dvcmsgYW5kIG5vdCBkbyB0
aGUgam9iIGRpcmVjdGx5Lg0KPlYzIC0+IFY0OiBBZGQgY2hhbmdlbG9ncw0KPlYyIC0+IFYzOiBB
ZGQgZGVzY3JpcHRpb24gaW5mb3JtYXRpb24NCj5WMSAtPiBWMjogdXNpbmcgaXJxX3dvcmsgdG8g
c29sdmUgdGhpcyBwcm9wZXJseS4NCj4tLS0NCj4tLS0NCj4gZHJpdmVycy90dHkvc2VyaWFsL2tn
ZGJvYy5jIHwgMjQgKysrKysrKysrKysrKysrKysrKysrKystDQo+IDEgZmlsZSBjaGFuZ2VkLCAy
MyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+DQo+ZGlmZiAtLWdpdCBhL2RyaXZlcnMv
dHR5L3NlcmlhbC9rZ2Rib2MuYyBiL2RyaXZlcnMvdHR5L3NlcmlhbC9rZ2Rib2MuYw0KPmluZGV4
IDdjZTdiYjE2NC4uMzI0MTBmZWM3IDEwMDY0NA0KPi0tLSBhL2RyaXZlcnMvdHR5L3NlcmlhbC9r
Z2Rib2MuYw0KPisrKyBiL2RyaXZlcnMvdHR5L3NlcmlhbC9rZ2Rib2MuYw0KPkBAIC0xOSw2ICsx
OSw3IEBADQo+ICNpbmNsdWRlIDxsaW51eC9jb25zb2xlLmg+DQo+ICNpbmNsdWRlIDxsaW51eC92
dF9rZXJuLmg+DQo+ICNpbmNsdWRlIDxsaW51eC9pbnB1dC5oPg0KPisjaW5jbHVkZSA8bGludXgv
aXJxX3dvcmsuaD4NCj4gI2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPg0KPiAjaW5jbHVkZSA8bGlu
dXgvcGxhdGZvcm1fZGV2aWNlLmg+DQo+ICNpbmNsdWRlIDxsaW51eC9zZXJpYWxfY29yZS5oPg0K
PkBAIC04Miw2ICs4MywxOSBAQCBzdGF0aWMgc3RydWN0IGlucHV0X2hhbmRsZXIga2dkYm9jX3Jl
c2V0X2hhbmRsZXIgPSB7DQo+IA0KPiBzdGF0aWMgREVGSU5FX01VVEVYKGtnZGJvY19yZXNldF9t
dXRleCk7DQo+IA0KPisvKg0KPisgKiBUaGlzIGNvZGUgZW5zdXJlcyB0aGF0IHRoZSBrZXlib2Fy
ZCBzdGF0ZSwgd2hpY2ggaXMgY2hhbmdlZCBkdXJpbmcga2RiDQo+KyAqIGV4ZWN1dGlvbiwgaXMg
cmVzeW5jaHJvbml6ZWQgd2hlbiB3ZSBsZWF2ZSB0aGUgZGVidWcgdHJhcC4gVGhlIHJlc3luYw0K
PisgKiBsb2dpYyBjYWxscyBpbnRvIHRoZSBpbnB1dCBzdWJzeXN0ZW0gdG8gZm9yY2UgYSByZXNl
dC4gVGhlIGNhbGxzIGludG8NCj4rICogdGhlIGlucHV0IHN1YnN5c3RlbSBtdXN0IGJlIGV4ZWN1
dGVkIGZyb20gbm9ybWFsIHRhc2sgY29udGV4dC4NCj4rICoNCj4rICogV2UgbmVlZCB0byB0cmln
Z2VyIHRoZSByZXN5bmMgZnJvbSB0aGUgZGVidWcgdHJhcCwgd2hpY2ggZXhlY3V0ZXMgaW4gYW4N
Cj4rICogTk1JIChvciBzaW1pbGFyKSBjb250ZXh0LiBUbyBtYWtlIGl0IHNhZmUgdG8gY2FsbCBp
bnRvIHRoZSBpbnB1dA0KPisgKiBzdWJzeXN0ZW0gd2UgZW5kIHVwIGhhdmluZyB1c2UgdHdvIGRl
ZmVycmVkIGV4ZWN1dGlvbiB0ZWNobmlxdWVzLg0KPisgKiBGaXJzdGx5LCB3ZSB1c2UgaXJxX3dv
cmssIHdoaWNoIGlzIE5NSS1zYWZlLCB0byBwcm92b2tlIGEgY2FsbGJhY2sgZnJvbQ0KPisgKiBo
YXJkaXJxIGNvbnRleHQuIFRoZW4sIGZyb20gdGhlIGhhcmRpcnEgY2FsbGJhY2sgd2UgdXNlIHRo
ZSBzeXN0ZW0NCj4rICogd29ya3F1ZXVlIHRvIHByb3Zva2UgdGhlIGNhbGxiYWNrIHRoYXQgYWN0
dWFsbHkgcGVyZm9ybXMgdGhlIHJlc3luYy4NCj4rICovDQo+IHN0YXRpYyB2b2lkIGtnZGJvY19y
ZXN0b3JlX2lucHV0X2hlbHBlcihzdHJ1Y3Qgd29ya19zdHJ1Y3QgKmR1bW15KQ0KPiB7DQo+IAkv
Kg0KPkBAIC05OSwxMCArMTEzLDE3IEBAIHN0YXRpYyB2b2lkIGtnZGJvY19yZXN0b3JlX2lucHV0
X2hlbHBlcihzdHJ1Y3Qgd29ya19zdHJ1Y3QgKmR1bW15KQ0KPiANCj4gc3RhdGljIERFQ0xBUkVf
V09SSyhrZ2Rib2NfcmVzdG9yZV9pbnB1dF93b3JrLCBrZ2Rib2NfcmVzdG9yZV9pbnB1dF9oZWxw
ZXIpOw0KPiANCj4rc3RhdGljIHZvaWQga2dkYm9jX3F1ZXVlX3Jlc3RvcmVfaW5wdXRfaGVscGVy
KHN0cnVjdCBpcnFfd29yayAqdW51c2VkKQ0KPit7DQo+KwlzY2hlZHVsZV93b3JrKCZrZ2Rib2Nf
cmVzdG9yZV9pbnB1dF93b3JrKTsNCj4rfQ0KPisNCj4rc3RhdGljIERFRklORV9JUlFfV09SSyhr
Z2Rib2NfcmVzdG9yZV9pbnB1dF9pcnFfd29yaywga2dkYm9jX3F1ZXVlX3Jlc3RvcmVfaW5wdXRf
aGVscGVyKTsNCj4rDQo+IHN0YXRpYyB2b2lkIGtnZGJvY19yZXN0b3JlX2lucHV0KHZvaWQpDQo+
IHsNCj4gCWlmIChsaWtlbHkoc3lzdGVtX3N0YXRlID09IFNZU1RFTV9SVU5OSU5HKSkNCj4tCQlz
Y2hlZHVsZV93b3JrKCZrZ2Rib2NfcmVzdG9yZV9pbnB1dF93b3JrKTsNCj4rCQlpcnFfd29ya19x
dWV1ZSgma2dkYm9jX3Jlc3RvcmVfaW5wdXRfaXJxX3dvcmspOw0KPiB9DQo+IA0KPiBzdGF0aWMg
aW50IGtnZGJvY19yZWdpc3Rlcl9rYmQoY2hhciAqKmNwdHIpDQo+QEAgLTEzMyw2ICsxNTQsNyBA
QCBzdGF0aWMgdm9pZCBrZ2Rib2NfdW5yZWdpc3Rlcl9rYmQodm9pZCkNCj4gCQkJaS0tOw0KPiAJ
CX0NCj4gCX0NCj4rCWlycV93b3JrX3N5bmMoJmtnZGJvY19yZXN0b3JlX2lucHV0X2lycV93b3Jr
KTsNCj4gCWZsdXNoX3dvcmsoJmtnZGJvY19yZXN0b3JlX2lucHV0X3dvcmspOw0KPiB9DQo+ICNl
bHNlIC8qICEgQ09ORklHX0tEQl9LRVlCT0FSRCAqLw0KPi0tIA0KPjIuMjUuMQ0KDQpXaGF0IGlz
IHRoZSBjdXJyZW50IHN0YXR1cyBvZiBQQVRDSCBWMTE/IEFyZSB0aGVyZSBhbnkgYWRkaXRpb25h
bCBtb2RpZmljYXRpb25zIG5lZWRlZD8NCg0K

