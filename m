Return-Path: <linux-kernel+bounces-124074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 393C98911D4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 04:05:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48C8DB222E8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 03:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BCC5381CC;
	Fri, 29 Mar 2024 03:05:49 +0000 (UTC)
Received: from mx10.didiglobal.com (mx10.didiglobal.com [111.202.70.125])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 1B9682AE68;
	Fri, 29 Mar 2024 03:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.202.70.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711681549; cv=none; b=G0xy9q9bgTzZ7B4Ht30Y8V0Iqll+JMC4rypdszP5iJHl6tRY4y/E2iANQ7dHmq2B/hoyLiIwJdp5Gg7FgUFkvPhfWw1deJa0d0Qr7BKnahZy5xYN4LEDEbzzfTUk6JOTAzB98pnOvPvmklRoQOOF3usDBsa0eiDfFVf0kSGCm3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711681549; c=relaxed/simple;
	bh=C5ysVHjz/Kiv76S2ZpjBwhHVFIv5+klc2cI/e85Ds+o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:Content-Type:
	 MIME-Version; b=gJeF9qv8brfVcUc3NwGRYnez5NB6LuO4btAj5p3uNuvA0BWAVUVpO0Jp6ESkwT6PfMFh59Gp+yyGav7OgKLCjY8ox5+mj9EJ2Yz5SXe8QmWXo/vgAXH6kYEpZ0YLLSUAUPv1bqTnpATf7ZpNX4fvrJFnmebTYIEE+CAJ/d+IXp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=didiglobal.com; spf=pass smtp.mailfrom=didiglobal.com; arc=none smtp.client-ip=111.202.70.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=didiglobal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=didiglobal.com
Received: from mail.didiglobal.com (unknown [10.79.71.31])
	by mx10.didiglobal.com (MailData Gateway V2.8.8) with ESMTPS id 1225118094767D;
	Fri, 29 Mar 2024 11:02:37 +0800 (CST)
Received: from ZJY02-ACTMBX-02.didichuxing.com (10.79.65.12) by
 ZJY03-ACTMBX-02.didichuxing.com (10.79.71.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 29 Mar 2024 11:02:36 +0800
Received: from ZJY02-ACTMBX-02.didichuxing.com ([fe80::98e9:1ba4:7aed:409f])
 by ZJY02-ACTMBX-02.didichuxing.com ([fe80::98e9:1ba4:7aed:409f%4]) with mapi
 id 15.01.2507.035; Fri, 29 Mar 2024 11:02:36 +0800
X-MD-Sfrom: tiozhang@didiglobal.com
X-MD-SrcIP: 10.79.71.31
From: =?utf-8?B?5byg5YWD54CaIFRpbyBaaGFuZw==?= <tiozhang@didiglobal.com>
To: Steven Rostedt <rostedt@goodmis.org>
CC: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
	<mathieu.desnoyers@efficios.com>, Ingo Molnar <mingo@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-trace-kernel@vger.kernel.org"
	<linux-trace-kernel@vger.kernel.org>, "zyhtheonly@yeah.net"
	<zyhtheonly@yeah.net>, "zyhtheonly@gmail.com" <zyhtheonly@gmail.com>
Subject: Re: [PATCH] trace/sched: add tgid for sched_wakeup_template
Thread-Topic: [PATCH] trace/sched: add tgid for sched_wakeup_template
Thread-Index: AQHagCPmy0rm9ybfXEWlsJ5DizJ/m7FLHyUAgALrrQA=
Date: Fri, 29 Mar 2024 03:02:36 +0000
Message-ID: <8246DBFF-ED09-4635-9DDA-D1DBB600B853@didiglobal.com>
In-Reply-To: <20240327102634.17013392@gandalf.local.home>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <E45D677039E36F4B8294E22AB1CA13D9@didichuxing.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

TWFrZSBzZW5zZSB0byBtZSwgdGhhbmsgeW91IGZvciB5b3VyIGV4cGxhbmF0aW9uLg0KDQrvu79P
biAzLzI3LzI0LCAxMDoyNCBQTSwgIlN0ZXZlbiBSb3N0ZWR0IiA8cm9zdGVkdEBnb29kbWlzLm9y
ZyA8bWFpbHRvOnJvc3RlZHRAZ29vZG1pcy5vcmc+PiB3cm90ZToNCg0KDQpPbiBXZWQsIDI3IE1h
ciAyMDI0IDE2OjUwOjU3ICswODAwDQpUaW8gWmhhbmcgPHRpb3poYW5nQGRpZGlnbG9iYWwuY29t
IDxtYWlsdG86dGlvemhhbmdAZGlkaWdsb2JhbC5jb20+PiB3cm90ZToNCg0KDQo+IEJ5IGRvaW5n
IHRoaXMsIHdlIGFyZSBhYmxlIHRvIGZpbHRlciB0YXNrcyBieSB0Z2lkIHdoaWxlIHdlIGFyZQ0K
PiB0cmFjaW5nIHdha2V1cCBldmVudHMgYnkgZWJwZiBvciBvdGhlciBtZXRob2RzLg0KPiANCj4g
Rm9yIGV4YW1wbGUsIHdoZW4gd2UgY2FyZSBhYm91dCB0cmFjaW5nIGEgdXNlciBzcGFjZSBwcm9j
ZXNzICh3aGljaCBoYXMNCj4gdW5jZXJ0YWluIG51bWJlciBvZiBMV1BzLCBpLmUsIHBpZHMpIHRv
IG1vbml0b3IgaXRzIHdha2V1cCBsYXRlbmN5LA0KPiB3aXRob3V0IHRnaWQgYXZhaWxhYmxlIGlu
IHNjaGVkX3dha2V1cCB0cmFjZXBvaW50cywgd2Ugd291bGQgc3RydWdnbGUNCj4gZmluZGluZyBv
dXQgYWxsIHBpZHMgdG8gdHJhY2UsIG9yIHdlIGNvdWxkIHVzZSBrcHJvYmUgdG8gYWNoaWV2ZSB0
Z2lkDQo+IHRyYWNpbmcsIHdoaWNoIGlzIGxlc3MgYWNjdXJhdGUgYW5kIG11Y2ggbGVzcyBlZmZp
Y2llbnQgdGhhbiB1c2luZw0KPiB0cmFjZXBvaW50Lg0KDQoNClRoaXMgaXMgYSB2ZXJ5IGNvbW1v
biB0cmFjZSBldmVudCwgYW5kIEkgcmVhbGx5IGRvIG5vdCB3YW50IHRvIGFkZCBtb3JlDQpkYXRh
IHRoYW4gbmVjZXNzYXJ5IHRvIGl0LCBhcyBpdCBpbmNyZWFzZXMgdGhlIHNpemUgb2YgdGhlIGV2
ZW50IHdoaWNoDQptZWFucyBsZXNzIGV2ZW50cyBjYW4gYmUgcmVjb3JkZWQgb24gYSBmaXhlZCBz
aXplIHRyYWNlIHJpbmcgYnVmZmVyLg0KDQoNCk5vdGUsIHlvdSBhcmUgbm90IG1vZGlmeWluZyB0
aGUgInRyYWNlcG9pbnQiLCBidXQgeW91IGFyZSBhY3R1YWxseQ0KbW9kaWZ5aW5nIGEgInRyYWNl
IGV2ZW50Ii4NCg0KDQoidHJhY2Vwb2ludCIgaXMgdGhlIGhvb2sgaW4gdGhlIGtlcm5lbCBjb2Rl
Og0KDQoNCnRyYWNlX3NjaGVkX3dha2V1cCgpDQoNCg0KInRyYWNlIGV2ZW50IiBpcyBkZWZpbmVk
IGJ5IFRSQUNFX0VWRU5UKCkgbWFjcm8gKGFuZCBmcmllbmRzKSB0aGF0IGRlZmluZXMNCndoYXQg
aXMgZXhwb3NlZCBpbiB0aGUgdHJhY2VmcyBmaWxlIHN5c3RlbS4NCg0KDQpJIHRob3VnaHQgZWJw
ZiBjb3VsZCBob29rIGRpcmVjdGx5IHRvIHRoZSB0cmFjZXBvaW50IHdoaWNoIGlzOg0KDQoNCnRy
YWNlX3NjaGVkX3dha2V1cChwKTsNCg0KDQpJIGJlbGlldmUgeW91IGNhbiBoYXZlIGRpcmVjdCBh
Y2Nlc3MgdG8gdGhlICdwJyBiZWZvcmUgaXQgaXMgcHJvY2Vzc2VkIGZyb20gZWJwZi4NCg0KDQpU
aGVyZSdzIGFsc28gInRyYWNlIHByb2JlcyIgKEkgdGhpbmsgd2UgYXJlIGxhY2tpbmcgZG9jdW1l
bnRhdGlvbiBvbiB0aGlzLA0KYXMgd2VsbCBhcyBldmVudCBwcm9iZXMgOi1wKToNCg0KDQokIGdk
YiB2bWxpbnV4DQooZ2RiKSBwICYoKHN0cnVjdCB0YXNrX3N0cnVjdCAqKTApLT50Z2lkDQokMSA9
IChwaWRfdCAqKSAweDU2Yw0KKGdkYikgcCAmKChzdHJ1Y3QgdGFza19zdHJ1Y3QgKikwKS0+cGlk
DQokMiA9IChwaWRfdCAqKSAweDU2OA0KDQoNCiMgZWNobyAndDp3YWtldXAgc2NoZWRfd2FraW5n
IHBpZD0rMHg1NjgoJGFyZzEpOnUzMiB0Z2lkPSsweDU2YygkYXJnMSk6dTMyJyA+IC9zeXMva2Vy
bmVsL3RyYWNpbmcvZHluYW1pY19ldmVudHMNCg0KDQojIHRyYWNlLWNtZCBzdGFydCAtZSB3YWtl
dXANCiMgdHJhY2UtY21kIHNob3cNCnRyYWNlLWNtZC03MzA3IFswMDNdIGQuLjYuIDU5OTQ4Ni40
ODU3NjI6IHdha2V1cDogKF9fcHJvYmVzdHViX3NjaGVkX3dha2luZysweDQvMHgxMCkgcGlkPTg0
NSB0Z2lkPTg0NQ0KYmFzaC04NDUgWzAwMV0gZC5zNC4gNTk5NDg2LjQ4NjEzNjogd2FrZXVwOiAo
X19wcm9iZXN0dWJfc2NoZWRfd2FraW5nKzB4NC8weDEwKSBwaWQ9MTcgdGdpZD0xNw0KYmFzaC04
NDUgWzAwMV0gZC4uNC4gNTk5NDg2LjQ4NjMzNjogd2FrZXVwOiAoX19wcm9iZXN0dWJfc2NoZWRf
d2FraW5nKzB4NC8weDEwKSBwaWQ9NTUxNiB0Z2lkPTU1MTYNCmt3b3JrZXIvdTE4OjItNTUxNiBb
MDAxXSBkLi40LiA1OTk0ODYuNDg2NDQ1OiB3YWtldXA6IChfX3Byb2Jlc3R1Yl9zY2hlZF93YWtp
bmcrMHg0LzB4MTApIHBpZD04MTggdGdpZD04MTgNCjxpZGxlPi0wIFswMDFdIGQuczQuIDU5OTQ4
Ni40OTEyMDY6IHdha2V1cDogKF9fcHJvYmVzdHViX3NjaGVkX3dha2luZysweDQvMHgxMCkgcGlk
PTE3IHRnaWQ9MTcNCjxpZGxlPi0wIFswMDFdIGQuczUuIDU5OTQ4Ni40OTMyMTg6IHdha2V1cDog
KF9fcHJvYmVzdHViX3NjaGVkX3dha2luZysweDQvMHgxMCkgcGlkPTE3IHRnaWQ9MTcNCjxpZGxl
Pi0wIFswMDFdIGQuczQuIDU5OTQ4Ni40OTcyMDA6IHdha2V1cDogKF9fcHJvYmVzdHViX3NjaGVk
X3dha2luZysweDQvMHgxMCkgcGlkPTE3IHRnaWQ9MTcNCjxpZGxlPi0wIFswMDNdIGQuczQuIDU5
OTQ4Ni44MjkyMDk6IHdha2V1cDogKF9fcHJvYmVzdHViX3NjaGVkX3dha2luZysweDQvMHgxMCkg
cGlkPTcwIHRnaWQ9NzANCg0KDQpUaGUgYWJvdmUgYXR0YWNoZXMgdG8gdGhlIHRyYWNlcG9pbnQg
YW5kICRhcmcxIGlzIHRoZSAnc3RydWN0IHRhc2tfc3RydWN0ICpwJy4NCg0KDQotLSBTdGV2ZQ0K
DQoNCg0KDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBUaW8gWmhhbmcgPHRpb3poYW5nQGRpZGlnbG9i
YWwuY29tIDxtYWlsdG86dGlvemhhbmdAZGlkaWdsb2JhbC5jb20+Pg0KPiBTaWduZWQtb2ZmLWJ5
OiBEeWxhbmUgQ2hlbiA8ZHlsYW5lY2hlbkBkaWRpZ2xvYmFsLmNvbSA8bWFpbHRvOmR5bGFuZWNo
ZW5AZGlkaWdsb2JhbC5jb20+Pg0KPiAtLS0NCj4gaW5jbHVkZS90cmFjZS9ldmVudHMvc2NoZWQu
aCB8IDYgKysrKy0tDQo+IDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDIgZGVsZXRp
b25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS90cmFjZS9ldmVudHMvc2NoZWQuaCBi
L2luY2x1ZGUvdHJhY2UvZXZlbnRzL3NjaGVkLmgNCj4gaW5kZXggZGJiMDFiNGI3NDUxLi5lYTdl
NTI1NjQ5ZTUgMTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUvdHJhY2UvZXZlbnRzL3NjaGVkLmgNCj4g
KysrIGIvaW5jbHVkZS90cmFjZS9ldmVudHMvc2NoZWQuaA0KPiBAQCAtMTQ5LDYgKzE0OSw3IEBA
IERFQ0xBUkVfRVZFTlRfQ0xBU1Moc2NoZWRfd2FrZXVwX3RlbXBsYXRlLA0KPiBfX2ZpZWxkKCBw
aWRfdCwgcGlkICkNCj4gX19maWVsZCggaW50LCBwcmlvICkNCj4gX19maWVsZCggaW50LCB0YXJn
ZXRfY3B1ICkNCj4gKyBfX2ZpZWxkKCBwaWRfdCwgdGdpZCApDQo+ICksDQo+IA0KPiBUUF9mYXN0
X2Fzc2lnbigNCj4gQEAgLTE1NiwxMSArMTU3LDEyIEBAIERFQ0xBUkVfRVZFTlRfQ0xBU1Moc2No
ZWRfd2FrZXVwX3RlbXBsYXRlLA0KPiBfX2VudHJ5LT5waWQgPSBwLT5waWQ7DQo+IF9fZW50cnkt
PnByaW8gPSBwLT5wcmlvOyAvKiBYWFggU0NIRURfREVBRExJTkUgKi8NCj4gX19lbnRyeS0+dGFy
Z2V0X2NwdSA9IHRhc2tfY3B1KHApOw0KPiArIF9fZW50cnktPnRnaWQgPSBwLT50Z2lkOw0KPiAp
LA0KPiANCj4gLSBUUF9wcmludGsoImNvbW09JXMgcGlkPSVkIHByaW89JWQgdGFyZ2V0X2NwdT0l
MDNkIiwNCj4gKyBUUF9wcmludGsoImNvbW09JXMgcGlkPSVkIHByaW89JWQgdGFyZ2V0X2NwdT0l
MDNkIHRnaWQ9JWQiLA0KPiBfX2VudHJ5LT5jb21tLCBfX2VudHJ5LT5waWQsIF9fZW50cnktPnBy
aW8sDQo+IC0gX19lbnRyeS0+dGFyZ2V0X2NwdSkNCj4gKyBfX2VudHJ5LT50YXJnZXRfY3B1LCBf
X2VudHJ5LT50Z2lkKQ0KPiApOw0KPiANCj4gLyoNCg0KDQoNCg0KDQo=

