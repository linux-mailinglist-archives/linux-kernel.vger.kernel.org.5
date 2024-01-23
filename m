Return-Path: <linux-kernel+bounces-35227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4CB838E23
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:05:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF8FEB21D28
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 12:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832375DF02;
	Tue, 23 Jan 2024 12:05:28 +0000 (UTC)
Received: from h3cspam02-ex.h3c.com (smtp.h3c.com [60.191.123.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E9F5C61A;
	Tue, 23 Jan 2024 12:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.191.123.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706011528; cv=none; b=bHiW2qlzqP0W+ARVnaNXkPvdQX1a/BCpxwiecJxltOooSgDJ6Ia1vmMI0IeAmJcb0JSV2h2zlouWP4qxEONJ47iWnNnOawiLng3btvCj+cR/YvwTbK8abbdeVPMsd/UaPssjRKvwv3CzNaGGzMyfmyHQ3Qyjq45tF/DHuvuFoQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706011528; c=relaxed/simple;
	bh=GiH+wOby5YduPA4k8m2yi3D59oBZ6oK+TLaCvK0X+d4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LNAdStLVlzb+2/QaP/xSt4Yok2YXsO3zlIKluayqMIzrl18DOg4eIUjtXieMq9AF0Bl3pxOPhScIWO7NpKI3m0Rc4Hyt6efRg0kgk49GFMFGWCLl10uMSZBuJbQtJcwJotsclvt4vCKCbE4FgB2FgLimjFSxdhaL/UqPo749lk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com; spf=pass smtp.mailfrom=h3c.com; arc=none smtp.client-ip=60.191.123.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h3c.com
Received: from mail.maildlp.com ([172.25.15.154])
	by h3cspam02-ex.h3c.com with ESMTP id 40NC4EU4014951;
	Tue, 23 Jan 2024 20:04:14 +0800 (GMT-8)
	(envelope-from hu.yadi@h3c.com)
Received: from DAG6EX14-BJD.srv.huawei-3com.com (unknown [10.153.34.16])
	by mail.maildlp.com (Postfix) with ESMTP id CDCEF22D4AC3;
	Tue, 23 Jan 2024 20:08:54 +0800 (CST)
Received: from DAG6EX02-IMDC.srv.huawei-3com.com (10.62.14.11) by
 DAG6EX14-BJD.srv.huawei-3com.com (10.153.34.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.27; Tue, 23 Jan 2024 20:04:17 +0800
Received: from DAG6EX02-IMDC.srv.huawei-3com.com ([fe80::4c21:7c89:4f9d:e4c4])
 by DAG6EX02-IMDC.srv.huawei-3com.com ([fe80::4c21:7c89:4f9d:e4c4%16]) with
 mapi id 15.02.1258.027; Tue, 23 Jan 2024 20:04:17 +0800
From: Huyadi <hu.yadi@h3c.com>
To: =?utf-8?B?J01pY2thw6tsIFNhbGHDvG4n?= <mic@digikod.net>
CC: "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com"
	<serge@hallyn.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
        "amir73il@gmail.com" <amir73il@gmail.com>,
        "brauner@kernel.org"
	<brauner@kernel.org>,
        "avagin@google.com" <avagin@google.com>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>,
        "514118380@qq.com" <514118380@qq.com>,
        "konstantin.meskhidze@huawei.com" <konstantin.meskhidze@huawei.com>
Subject: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjRdIHNlbGZ0ZXN0cy9sYW5kbG9jazpGaXggdHdv?=
 =?utf-8?Q?_build_issues?=
Thread-Topic: [PATCH v4] selftests/landlock:Fix two build issues
Thread-Index: AQHaR51Te/ejhd6BskWKYK0XmAmChrDgkaUAgAbFurA=
Date: Tue, 23 Jan 2024 12:04:17 +0000
Message-ID: <adec399e50c74b30b59480d92c431241@h3c.com>
References: <20240115102409.19799-1-hu.yadi@h3c.com>
 <20240119.Ugaehae2ze5b@digikod.net>
In-Reply-To: <20240119.Ugaehae2ze5b@digikod.net>
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
X-MAIL:h3cspam02-ex.h3c.com 40NC4EU4014951

DQo+PiBDaGFuZ2VzIHYzIC0+IHYyOg0KPj4gIC0gYWRkIGhlbHBlciBvZiBnZXR0aWQgaW5zdGVh
ZCBvZiBfX05SX2dldHRpZA0KPj4gIC0gYWRkIGdjYy9nbGliYyB2ZXJzaW9uIGluZm8gaW4gY29t
bWVudHMgQ2hhbmdlcyB2MSAtPiB2MjoNCj4+ICAtIGZpeCB3aGl0ZXNwYWNlIGVycm9yDQo+PiAg
LSByZXBsYWNlIFNZU19nZXR0aWQgd2l0aCBfTlJfZ2V0dGlkDQo+PiANCj4+ICB0b29scy90ZXN0
aW5nL3NlbGZ0ZXN0cy9sYW5kbG9jay9mc190ZXN0LmMgIHwgNSArKysrLSAgDQo+PiB0b29scy90
ZXN0aW5nL3NlbGZ0ZXN0cy9sYW5kbG9jay9uZXRfdGVzdC5jIHwgNyArKysrKystDQo+PiAgMiBm
aWxlcyBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPj4gDQo+PiBk
aWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvbGFuZGxvY2svZnNfdGVzdC5jIA0K
Pj4gYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9sYW5kbG9jay9mc190ZXN0LmMNCj4+IGluZGV4
IDE4ZTFmODZhNjIzNC4uYTk5MmNmN2MwYWQxIDEwMDY0NA0KPj4gLS0tIGEvdG9vbHMvdGVzdGlu
Zy9zZWxmdGVzdHMvbGFuZGxvY2svZnNfdGVzdC5jDQo+PiArKysgYi90b29scy90ZXN0aW5nL3Nl
bGZ0ZXN0cy9sYW5kbG9jay9mc190ZXN0LmMNCj4+IEBAIC00NTcyLDcgKzQ1NzIsMTAgQEAgRklY
VFVSRV9WQVJJQU5UKGxheW91dDNfZnMpDQo+PiAgLyogY2xhbmctZm9ybWF0IG9mZiAqLw0KPj4g
IEZJWFRVUkVfVkFSSUFOVF9BREQobGF5b3V0M19mcywgdG1wZnMpIHsNCj4+ICAJLyogY2xhbmct
Zm9ybWF0IG9uICovDQo+PiAtCS5tbnQgPSBtbnRfdG1wLA0KPj4gKwkubW50ID0gew0KPj4gKwkJ
LnR5cGUgPSAidG1wZnMiLA0KPj4gKwkJLmRhdGEgPSAic2l6ZT00bSxtb2RlPTcwMCIsDQo+PiAr
CX0sDQo+DQo+SSByZXF1ZXN0ZWQgc29tZSBjaGFuZ2VzIGhlcmUuDQo+DQoNCkNvdWxkIHlvdSBn
aXZlIG1lIHNvbWUgaW5zcGlyYXRpb24gaG93IHRvIGZpeCBpdD8gDQppdCBsb29rcyBmaW5lIHRv
IG1lIHRvIGFzc2lnbiB2YWx1ZSBhcyBhYm92ZSwgd2hpY2ggY29uc2lzdGVudCB3aXRoIG90aGVy
IHBzZXVkbyBGUyB0ZXN0cy4NClRoYW5rcyBpbiBhZHZhbmNlLg0KDQo+PiAgCS5maWxlX3BhdGgg
PSBmaWxlMV9zMWQxLA0KPj4gIH07DQo+PiANCiAgDQo=

