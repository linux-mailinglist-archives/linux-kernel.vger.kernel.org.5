Return-Path: <linux-kernel+bounces-28586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B8583005D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 08:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7CFD1C23A92
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 07:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40108F59;
	Wed, 17 Jan 2024 07:10:51 +0000 (UTC)
Received: from zg8tmtu5ljg5lje1ms4xmtka.icoremail.net (zg8tmtu5ljg5lje1ms4xmtka.icoremail.net [159.89.151.119])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B475CB0
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 07:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.89.151.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705475451; cv=none; b=oWUSoHlCYw8cbTaqVy35Rh/t9oNvjF2jB8qwoRpSp6LuEsiaeh6tfU/3GDsBCBOMTzVOPlidhrTj1eGNzCR499ohfDJhRu1BbeZp3+HeVoW8Y1wrNjLZ8mimkX9GNFkDKhqi6SL4XX8h7wSsO237jt51tq3KJiPkuro6Yu+9Hqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705475451; c=relaxed/simple;
	bh=YkIm8CNeK30PQLyTJTvMvjL/91juIuAtd6vXq/Zu7yQ=;
	h=Received:X-Originating-IP:Date:X-CM-HeaderCharset:From:To:Cc:
	 Subject:X-Priority:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	 X-Coremail-Locale:X-CM-TRANSID:X-CM-SenderInfo:
	 X-Coremail-Antispam; b=DzSQmXL5/EqGWHNOQKbHkkyIOKV1wKaCCzj9mz/wXrBLo2aPFPIMl+QpQmeO/jCyrSXOMMJX4bVIZl1QyqSsPNGWitv8Ft+2UA/8aJFLzgRw4fT+AxwyeoTTUGcQi1qeijTMWW4BGMWqKcN6aTmqQOmvqSejrzc/DY0tTOdtLWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=159.89.151.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from alexious$zju.edu.cn ( [10.190.68.184] ) by
 ajax-webmail-mail-app3 (Coremail) ; Wed, 17 Jan 2024 15:10:19 +0800
 (GMT+08:00)
Date: Wed, 17 Jan 2024 15:10:19 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: alexious@zju.edu.cn
To: "Qiang Yu" <yuq825@gmail.com>
Cc: "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
	"Maxime Ripard" <mripard@kernel.org>,
	"Thomas Zimmermann" <tzimmermann@suse.de>,
	"David Airlie" <airlied@gmail.com>,
	"Daniel Vetter" <daniel@ffwll.ch>,
	"Vasily Khoruzhick" <anarsoul@gmail.com>,
	dri-devel@lists.freedesktop.org, lima@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] drm/lima: fix a memleak in lima_heap_alloc
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT5 build
 20231205(37e20f0e) Copyright (c) 2002-2024 www.mailtech.cn
 mispb-4df6dc2c-e274-4d1c-b502-72c5c3dfa9ce-zj.edu.cn
In-Reply-To: <CAKGbVbswTUYJsZDLWao58MTyt7yAYMMXA5zjeYVBTRvd9X3n0g@mail.gmail.com>
References: <20240112084750.3729837-1-alexious@zju.edu.cn>
 <CAKGbVbswTUYJsZDLWao58MTyt7yAYMMXA5zjeYVBTRvd9X3n0g@mail.gmail.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <397c98b.49eb.18d1641ad63.Coremail.alexious@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:cC_KCgA3XztcfadlY08uAA--.5780W
X-CM-SenderInfo: qrsrjiarszq6lmxovvfxof0/1tbiAg0DAGWmzmEUIgAEsS
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VW7Jw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

PiBUaGFua3MgZm9yIHRoZSBmaXguIEFzIHRoZSBlcnJvciBoYW5kbGluZyBnZXRzIGxvbmdlciBh
bmQgZHVwbGljYXRlZCwKPiBjb3VsZCB5b3UgcmVhcnJhbmdlIHRoZW0gbGlrZSB0aGUgbGltYV9n
ZW1fc3VibWl0KCk6Cj4gZXJyX291dDI6Cj4gICAgIGRtYV91bm1hcF9zZ3RhYmxlKGRldiwgJnNn
dCwgRE1BX0JJRElSRUNUSU9OQUwsIDApOwo+IGVycl9vdXQxOgo+ICAgICBrZnJlZShiby0+YmFz
ZS5zZ3QpOwo+ICAgICBiby0+YmFzZS5zZ3QgPSBOVUxMOwo+IGVycl9vdXQwOgo+ICAgICBzZ19m
cmVlX3RhYmxlKCZzZ3QpOwo+ICAgICByZXR1cm4gcmV0Lgo+IAo+IFJlZ2FyZHMsCj4gUWlhbmcK
PiAKClN1cmUsIEknbGwgc2VuZCBhIHYyIHZlcnNpb24gb2YgdGhpcyBwYXRjaCBsYXRlciBmb2xs
b3dpbmcgeW91ciBhZHZpc2UuCgpSZWdhcmRzLApaaGlwZW5nCgo+IE9uIEZyaSwgSmFuIDEyLCAy
MDI0IGF0IDQ6NDnigK9QTSBaaGlwZW5nIEx1IDxhbGV4aW91c0B6anUuZWR1LmNuPiB3cm90ZToK
PiA+Cj4gPiBXaGVuIGxpbWFfdm1fbWFwX2JvIGZhaWxzLCB0aGUgcmVzb3VyY2VzIG5lZWQgdG8g
YmUgZGVhbGxvY2F0ZWQsIG9yCj4gPiB0aGVyZSB3aWxsIGJlIG1lbWxlYWtzLgo+ID4KPiA+IEZp
eGVzOiA2YWViYzUxZDdhZWYgKCJkcm0vbGltYTogc3VwcG9ydCBoZWFwIGJ1ZmZlciBjcmVhdGlv
biIpCj4gPiBTaWduZWQtb2ZmLWJ5OiBaaGlwZW5nIEx1IDxhbGV4aW91c0B6anUuZWR1LmNuPgo+
ID4gLS0tCj4gPiAgZHJpdmVycy9ncHUvZHJtL2xpbWEvbGltYV9nZW0uYyB8IDcgKysrKysrLQo+
ID4gIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPiA+Cj4g
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2xpbWEvbGltYV9nZW0uYyBiL2RyaXZlcnMv
Z3B1L2RybS9saW1hL2xpbWFfZ2VtLmMKPiA+IGluZGV4IDRmOTczNmU1ZjkyOS4uODI0ZWQyMjE0
MWM3IDEwMDY0NAo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2xpbWEvbGltYV9nZW0uYwo+ID4g
KysrIGIvZHJpdmVycy9ncHUvZHJtL2xpbWEvbGltYV9nZW0uYwo+ID4gQEAgLTkyLDggKzkyLDEz
IEBAIGludCBsaW1hX2hlYXBfYWxsb2Moc3RydWN0IGxpbWFfYm8gKmJvLCBzdHJ1Y3QgbGltYV92
bSAqdm0pCj4gPgo+ID4gICAgICAgICBpZiAodm0pIHsKPiA+ICAgICAgICAgICAgICAgICByZXQg
PSBsaW1hX3ZtX21hcF9ibyh2bSwgYm8sIG9sZF9zaXplID4+IFBBR0VfU0hJRlQpOwo+ID4gLSAg
ICAgICAgICAgICAgIGlmIChyZXQpCj4gPiArICAgICAgICAgICAgICAgaWYgKHJldCkgewo+ID4g
KyAgICAgICAgICAgICAgICAgICAgICAgZG1hX3VubWFwX3NndGFibGUoZGV2LCAmc2d0LCBETUFf
QklESVJFQ1RJT05BTCwgMCk7Cj4gPiArICAgICAgICAgICAgICAgICAgICAgICBzZ19mcmVlX3Rh
YmxlKCZzZ3QpOwo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAga2ZyZWUoYm8tPmJhc2Uuc2d0
KTsKPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGJvLT5iYXNlLnNndCA9IE5VTEw7Cj4gPiAg
ICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gcmV0Owo+ID4gKyAgICAgICAgICAgICAgIH0K
PiA+ICAgICAgICAgfQo+ID4KPiA+ICAgICAgICAgYm8tPmhlYXBfc2l6ZSA9IG5ld19zaXplOwo+
ID4gLS0KPiA+IDIuMzQuMQo+ID4K

