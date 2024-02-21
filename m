Return-Path: <linux-kernel+bounces-74056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A57C85CF67
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 06:07:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58B881C225A2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 05:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D046639AD3;
	Wed, 21 Feb 2024 05:07:32 +0000 (UTC)
Received: from zg8tndyumtaxlji0oc4xnzya.icoremail.net (zg8tndyumtaxlji0oc4xnzya.icoremail.net [46.101.248.176])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF0BA35;
	Wed, 21 Feb 2024 05:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.101.248.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708492052; cv=none; b=NiLlYGdbxcGaFpyWn4YISAWkSPNiYisYm/dZf7X4tQnLDo0DUyXGkwrndha9Klddxg/iTxrfO+LTB0E/yVgcQL04SKxH1PHrDA5vuylsSIwLq1Zb83h9hzR+iqXGok//9yp/7RWLM7aN1wrvRRDY0xyHrxOn1qWcjG6CZsDOyKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708492052; c=relaxed/simple;
	bh=1zk3WJHI7/VqdyRx6tLIAl7eIzOJo6ul2Sc03C7yXUw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=t8Oc9RHHo6QmNHcT5Jx7g3TCBumqY9z6mU83xoon0qt1zE8Ji15KUDRpDLCpVxYOpdnKWdPZ5bwwQbJNZi/YhipyMmJLt61S+nCcS0Ylr0+cx9yiTmpiOlfFOda33JsVytjwpAuolH4YACcc9kzQ+Euxt3gl9iPhLoqp/aWK8c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=46.101.248.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from alexious$zju.edu.cn ( [124.90.105.91] ) by
 ajax-webmail-mail-app4 (Coremail) ; Wed, 21 Feb 2024 13:07:06 +0800
 (GMT+08:00)
Date: Wed, 21 Feb 2024 13:07:06 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: alexious@zju.edu.cn
To: "Hans Verkuil" <hverkuil-cisco@xs4all.nl>
Cc: "Mauro Carvalho Chehab" <mchehab@kernel.org>,
	"Yu Zhe" <yuzhe@nfschina.com>, "Jakub Kicinski" <kuba@kernel.org>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: ttpci: fix two memleaks in budget_av_attach
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT5 build
 20231205(37e20f0e) Copyright (c) 2002-2024 www.mailtech.cn
 mispb-4df6dc2c-e274-4d1c-b502-72c5c3dfa9ce-zj.edu.cn
In-Reply-To: <fb4f6b74-8af4-43c6-9119-0c3ec2a3387b@xs4all.nl>
References: <20240206073719.3133481-1-alexious@zju.edu.cn>
 <fb4f6b74-8af4-43c6-9119-0c3ec2a3387b@xs4all.nl>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <77f4e75d.eff9.18dca0f7285.Coremail.alexious@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:cS_KCgD3NIX7hNVlcjh1AQ--.26028W
X-CM-SenderInfo: qrsrjiarszq6lmxovvfxof0/1tbiAgUHAGXGcmUNKgAwsj
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

PiBPbiAwNi8wMi8yMDI0IDA4OjM3LCBaaGlwZW5nIEx1IHdyb3RlOgo+ID4gV2hlbiBzYWE3MTQ2
X3JlZ2lzdGVyX2RldmljZSBhbmQgc2FhNzE0Nl92dl9pbml0IGZhaWxzLCBidWRnZXRfYXZfYXR0
YWNoCj4gPiBzaG91bGQgZnJlZSB0aGUgcmVzb3VyY2VzIGl0IGFsbG9jYXRlcywgbGlrZSB0aGUg
ZXJyb3ItaGFuZGxpbmcgb2YKPiA+IHR0cGNpX2J1ZGdldF9pbml0IGRvZXMuIEJlc2lkZXMsIHRo
ZXJlIGFyZSB0d28gZml4bWUgY29tbWVudCByZWZlcnMgdG8KPiA+IHN1Y2ggZGVhbGxvY2F0aW9u
cy4KPiA+IAo+ID4gRml4ZXM6IDFkYTE3N2U0YzNmNCAoIkxpbnV4LTIuNi4xMi1yYzIiKQo+ID4g
U2lnbmVkLW9mZi1ieTogWmhpcGVuZyBMdSA8YWxleGlvdXNAemp1LmVkdS5jbj4KPiA+IC0tLQo+
ID4gIGRyaXZlcnMvbWVkaWEvcGNpL3R0cGNpL2J1ZGdldC1hdi5jIHwgNiArKysrLS0KPiA+ICAx
IGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+ID4gCj4gPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9tZWRpYS9wY2kvdHRwY2kvYnVkZ2V0LWF2LmMgYi9kcml2ZXJz
L21lZGlhL3BjaS90dHBjaS9idWRnZXQtYXYuYwo+ID4gaW5kZXggMjMwYjEwNGE3Y2RmLi40Zjg5
N2Y4NDg1ODEgMTAwNjQ0Cj4gPiAtLS0gYS9kcml2ZXJzL21lZGlhL3BjaS90dHBjaS9idWRnZXQt
YXYuYwo+ID4gKysrIGIvZHJpdmVycy9tZWRpYS9wY2kvdHRwY2kvYnVkZ2V0LWF2LmMKPiA+IEBA
IC0xNDYzLDcgKzE0NjMsOCBAQCBzdGF0aWMgaW50IGJ1ZGdldF9hdl9hdHRhY2goc3RydWN0IHNh
YTcxNDZfZGV2ICpkZXYsIHN0cnVjdCBzYWE3MTQ2X3BjaV9leHRlbnNpbwo+ID4gIAkJYnVkZ2V0
X2F2LT5oYXNfc2FhNzExMyA9IDE7Cj4gPiAgCQllcnIgPSBzYWE3MTQ2X3Z2X2luaXQoZGV2LCAm
dnZfZGF0YSk7Cj4gPiAgCQlpZiAoZXJyICE9IDApIHsKPiA+IC0JCQkvKiBmaXhtZTogcHJvcGVy
IGNsZWFudXAgaGVyZSAqLwo+ID4gKwkJCXR0cGNpX2J1ZGdldF9kZWluaXQoJmJ1ZGdldF9hdi0+
YnVkZ2V0KTsKPiA+ICsJCQlrZnJlZShidWRnZXRfYXYpOwo+ID4gIAkJCUVSUigiY2Fubm90IGlu
aXQgdnYgc3Vic3lzdGVtXG4iKTsKPiA+ICAJCQlyZXR1cm4gZXJyOwo+ID4gIAkJfQo+ID4gQEAg
LTE0NzIsNyArMTQ3Myw4IEBAIHN0YXRpYyBpbnQgYnVkZ2V0X2F2X2F0dGFjaChzdHJ1Y3Qgc2Fh
NzE0Nl9kZXYgKmRldiwgc3RydWN0IHNhYTcxNDZfcGNpX2V4dGVuc2lvCj4gPiAgCQl2dl9kYXRh
LnZpZF9vcHMudmlkaW9jX3NfaW5wdXQgPSB2aWRpb2Nfc19pbnB1dDsKPiA+ICAKPiA+ICAJCWlm
ICgoZXJyID0gc2FhNzE0Nl9yZWdpc3Rlcl9kZXZpY2UoJmJ1ZGdldF9hdi0+dmQsIGRldiwgImtu
YzEiLCBWRkxfVFlQRV9WSURFTykpKSB7Cj4gPiAtCQkJLyogZml4bWU6IHByb3BlciBjbGVhbnVw
IGhlcmUgKi8KPiA+ICsJCQl0dHBjaV9idWRnZXRfZGVpbml0KCZidWRnZXRfYXYtPmJ1ZGdldCk7
Cj4gPiArCQkJa2ZyZWUoYnVkZ2V0X2F2KTsKPiBJIHRoaW5rIHRoaXMgc2hvdWxkIGdvIGFmdGVy
IHRoZSBzYWE3MTQ2X3Z2X3JlbGVhc2UoKSByZWxlYXNlIGJlbG93Lgo+IEp1c3QgaW4gY2FzZSBz
YWE3MTQ2X3Z2X3JlbGVhc2UoKSByZWxpZXMgb24gYnVkZ2V0X2F2IHNvbWV3aGVyZS4gQW5kCj4g
YmVzaWRlcywgaXQgaXMgZ29vZCBwcmFjdGljZSB0byByZWxlYXNlIHJlc291cmNlcyBpbiB0aGUg
cmV2ZXJzZSBvcmRlcgo+IHRoZXkgd2VyZSBhbGxvY2F0ZWQuCgpZZXMsIEkgbm90aWNlZCB0aGUg
b3JkZXIgb2YgYGtmcmVlKGJ1ZGdldF9hdilgIGFuZCBgdHRwY2lfYnVkZ2V0X2RlaW5pdGAsIApi
dXQgZGlkIGZvcmdvdCB0aGUgYHNhYTcxNDZfdnZfcmVsZWFzZWAuIEknbGwgc2VuZCBhIHYyIHZl
cnNpb24gb2YgdGhpcyAKcGF0Y2ggc29vbi4KClJlZ2FyZHMsClpoaXBlbmcKCj4gCj4gPiAgCQkJ
RVJSKCJjYW5ub3QgcmVnaXN0ZXIgY2FwdHVyZSB2NGwyIGRldmljZVxuIik7Cj4gPiAgCQkJc2Fh
NzE0Nl92dl9yZWxlYXNlKGRldik7Cj4gPiAgCQkJcmV0dXJuIGVycjsK

