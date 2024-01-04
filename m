Return-Path: <linux-kernel+bounces-16287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE50F823C4B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 07:33:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 670A7286883
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 06:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A101CFAF;
	Thu,  4 Jan 2024 06:32:51 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from zg8tmtu5ljg5lje1ms4xmtka.icoremail.net (zg8tmtu5ljg5lje1ms4xmtka.icoremail.net [159.89.151.119])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B9C1DFE3;
	Thu,  4 Jan 2024 06:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from linma$zju.edu.cn ( [42.120.103.48] ) by
 ajax-webmail-mail-app4 (Coremail) ; Thu, 4 Jan 2024 14:32:29 +0800
 (GMT+08:00)
Date: Thu, 4 Jan 2024 14:32:29 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: "Lin Ma" <linma@zju.edu.cn>
To: "Jakub Kicinski" <kuba@kernel.org>
Cc: jk@codeconstruct.com.au, matt@codeconstruct.com.au, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v1] net: mctp: use deprecated parser in
 mctp_set_link_af
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.2-cmXT5 build
 20230825(e13b6a3b) Copyright (c) 2002-2024 www.mailtech.cn
 mispb-4df6dc2c-e274-4d1c-b502-72c5c3dfa9ce-zj.edu.cn
In-Reply-To: <20240103174719.2b2c1565@kernel.org>
References: <20231228070258.3052422-1-linma@zju.edu.cn>
 <20240103174719.2b2c1565@kernel.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <7cbc3044.688a7.18cd32c5f14.Coremail.linma@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:cS_KCgCHWJ3+UJZlqQU8AA--.9603W
X-CM-SenderInfo: qtrwiiyqvtljo62m3hxhgxhubq/1tbiAwIKEmWVL-wSTQAAsl
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

SGVsbG8gSmFrdWIsCgo+ID4gCj4gPiBGb3Igb3RoZXIgc2V0X2xpbmtfYWYgdXNlcnMgSVBWNCBh
bmQgSVBWNiBib3RoIG1ha2UgYSB0cmljayBoZXJlIGJ5Cj4gPiB1c2luZyBubGFfcGFyc2VfbmVz
dGVkX2RlcHJlY2F0ZWQsIHdoaWNoIHdpbGwgY2hlY2sgdGhlIE5MQV9GX05FU1RFRAo+ID4gdGhl
biBhYmxlIHRvIHVzZSB0aGlzIHR5cGUgZmllbGQgYXMgZmFtaWx5IHZhbHVlLiBUaGlzIHBhdGNo
IHNpbXBseSBwb3J0Cj4gPiB0aGUgTUNUUCBjb2RlIGFsc28gdG8gZGVwcmVjYXRlZCBwYXJzZXIg
dG8gbWFrZSBpdCB3b3JrLgo+IAo+IERpZCB5b3UgdGVzdCB0aGlzPyBJdCdzIGEgc3VzcGljaW91
c2x5IGRldGFpbGVkIGFuZCB5ZXQgc2VlbWluZ2x5Cj4gaW5jb3JyZWN0IGV4cGxhbmF0aW9uLi4K
ClllcywgSSBoYWNrZWQgdGhlIGlwcm91dGUgdG9vbCBhbmQgYWRkIGJlbG93IGNvZGUKCmh0dHBz
Oi8vZ2l0aHViLmNvbS9pcHJvdXRlMi9pcHJvdXRlMi9ibG9iL21haW4vaXAvaXBsaW5rLmMjTDgw
MQoKODUzYTg1NCw4NjEKPiAJCX0gZWxzZSBpZiAobWF0Y2hlcygqYXJndiwgIm1jdHB0ZXN0Iikg
PT0gMCkgewo+IAkJCXN0cnVjdCBydGF0dHIgKmFmcywgKmFmc21jdHA7Cj4gCQkJYWZzID0gYWRk
YXR0cl9uZXN0KCZyZXEtPm4sIHNpemVvZigqcmVxKSwgSUZMQV9BRl9TUEVDKTsKPiAJCQlhZnNt
Y3RwID0gYWRkYXR0cl9uZXN0KCZyZXEtPm4sIHNpemVvZigqcmVxKSwgQUZfTUNUUCk7Cj4gCQkJ
YWRkYXR0cjMyKCZyZXEtPm4sIHNpemVvZigqcmVxKSwKPiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBJRkxBX01DVFBfTkVULCAwKTsKPiAJCQlhZGRhdHRyX25lc3RfZW5kKCZyZXEt
Pm4sIGFmc21jdHApOwo+IAkJCWFkZGF0dHJfbmVzdF9lbmQoJnJlcS0+biwgYWZzKTsKCmFjY29y
ZGluZyB0byB0aGUgaW1wbGVtZW50YXRpb24gb2YgdGhlIGBhZGRyZ2VubW9kZWAuCgpJbiBzaG9y
dCwgdGhlIHBhY2thZ2UgZm9ybWF0IHNob3VsZCBiZSBsaWtlCiAgICAgCiAgTCAgICAgICAgIFQg
ICAgICAgIEwgICAgICBUICAKKy0tLSstLS0tLS0tLS0tLS0tLSstLS0rLS0tLS0tLS0tKy0tLS0t
LS0tLS0tLS0KfCAgIHwgSUZMQV9BRl9TUEVDIHwgICB8IEFGX01DVFAgfCAuLi4uLgorLS0tKy0t
LS0tLS0tLS0tLS0tKy0tLSstLS0tLS0tLS0rLS0tLS0tLS0tLS0tLQogICAgICAgICAgICAgICAg
ICAgXgogICAgICAgICAgICAgICAgICAgfAogICAgICAgICAgICAgICAgICAgYWYKClRoZXJlZm9y
ZSwgdGhlIGNvZGUKCiAgbmxhX2Zvcl9lYWNoX25lc3RlZChhZiwgdGJbSUZMQV9BRl9TUEVDXSwg
cmVtKSB7CiAgICBjb25zdCBzdHJ1Y3QgcnRubF9hZl9vcHMgKmFmX29wczsKICAgIEJVR19PTigh
KGFmX29wcyA9IHJ0bmxfYWZfbG9va3VwKG5sYV90eXBlKGFmKSkpKTsgPD0gKDEpCiAgICBlcnIg
PSBhZl9vcHMtPnNldF9saW5rX2FmKGRldiwgYWYsIGV4dGFjayk7ICAgICAgIDw9ICgyKQoKKDEp
IHdpbGwgZ2V0IEFGX01DVFAgd2l0aCBubGFfdHlwZSguLi4pIGNhbGwsIGFuZCAoMikgd2lsbCB0
aGVuIHBhc3NpbmcgYGFmYCB0bwpgbWN0cF9zZXRfbGlua19hZmAsIHdoaWNoIHdpbGwgZXhwZWN0
IHRoZSBgTkxBX0ZfTkVTVEVEYCBmbGFnLgoKV2l0aCB0aGUgaGFja2VkIGlwcm91dGUgdG9vbHMs
IHNpbXBsZSB0eXBlIGNvbW1hbmQgbGlrZQoKYGlwIGxpbmsgc2V0IGV0aDAgbXR1IDEwMjQgbWN0
cHRlc3RgIHdpbGwgaGl0IHRoZSBmdW5jdGlvbiBtY3RwX3NldF9saW5rX2FmIGFuZAp3aXRoIG15
IGRlYnVnZ2VyLCBJIGZvdW5kIHRoYXQgdGhlIG5sYV9wYXJzZV9uZXN0ZWQgYWx3YXlzIHJldHVy
biBlcnJvci4KCkFub3RoZXIgZWxlZ2FudCBzb2x1dGlvbiBpcyB0byBjaGFuZ2UgaG93ICgxKSBj
YWxscyBydG5sX2FmX2xvb2t1cCwgd2UgY2FuIGludHJvZHVjZQphbm90aGVyIGZhbWlseSBhdHRy
aWJ1dGUgYW5kIGF2b2lkIHRvIHVzZSBubGFfdHlwZSguLikgd2hpY2ggaXMgc28gc3VzcGljaW91
cy4KQnV0IHRoaXMgd2lsbCBoYXZlIHRvIGNoYW5nZSBhbHNvIG90aGVyIHNldF9saW5rX2FmIGlt
cGxlbWVudGF0aW9ucyAoaXB2NCwgaXB2NikuCgo+IC0tIAo+IHB2LWJvdDogcwo+IHB3LWJvdDog
Y3IKClJlZ2FyZHMKTGlu

