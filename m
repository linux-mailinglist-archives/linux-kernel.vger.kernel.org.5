Return-Path: <linux-kernel+bounces-136809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A84B189D881
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4864D1F23696
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 11:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9C0129E6B;
	Tue,  9 Apr 2024 11:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=maquefel.me header.i=@maquefel.me header.b="VfSfNf7+"
Received: from forward502a.mail.yandex.net (forward502a.mail.yandex.net [178.154.239.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCFE1EB46;
	Tue,  9 Apr 2024 11:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712663355; cv=none; b=KsWq+pKu0Ofm/PArDyAgsVMhjVHOKuqSqSNHMRMSmzm7o7OKdwotUZi5vvvLvKHW6a+RmOwIax65dOYXxTVPQfCWeDRK8xS6PTpLyq3xx/jUamGzVDzIxuWLxJQNR+p8K86rHuLgbdQJO/lEfdJebczPwpNZJhBXVI5ir6F1sII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712663355; c=relaxed/simple;
	bh=52WWkfu86gx/lo2vjZGO8fMdXa5Yi4Sl7Fgw/vzyE6Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KSYk0aoRWzuwwkcuhVF3pbFVH/90JZCbsHsmqG7/oDqGjhv6cwp0EOlvjeFbOLvjKMIikVloWs5OiwLmqz/T9QaXTOhpVOvpOL4Yk3Y12J83O0zHVHKAGoE8NyedG48D8dOv/vmPBOx9x4ehUf5CLG9S9QPwXXHbgW3qOqedB60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maquefel.me; spf=pass smtp.mailfrom=maquefel.me; dkim=pass (1024-bit key) header.d=maquefel.me header.i=@maquefel.me header.b=VfSfNf7+; arc=none smtp.client-ip=178.154.239.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maquefel.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maquefel.me
Received: from mail-nwsmtp-smtp-production-main-49.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-49.vla.yp-c.yandex.net [IPv6:2a02:6b8:c18:1423:0:640:9497:0])
	by forward502a.mail.yandex.net (Yandex) with ESMTPS id D0E9961134;
	Tue,  9 Apr 2024 14:49:00 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-49.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id xmXmkMrkE4Y0-j6ONsW4b;
	Tue, 09 Apr 2024 14:49:00 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail;
	t=1712663340; bh=52WWkfu86gx/lo2vjZGO8fMdXa5Yi4Sl7Fgw/vzyE6Q=;
	h=References:Date:In-Reply-To:Cc:To:From:Subject:Message-ID;
	b=VfSfNf7+PRsyy9vPYLE8SV3uDU3QNbUDNfaQCuD9W12qq29836yZS3bVUoH/dXf6U
	 s6hRvReWV9XkVk7wjIFpYQjGgtpGzwi+A68eho3l/ofBv8t/Tz142aIJksy6bCux9t
	 GM3DNkCNuwkgy8KmejeTKynArydt4kI1o/4hebSY=
Authentication-Results: mail-nwsmtp-smtp-production-main-49.vla.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
Message-ID: <42f9da044fdc11e2495f6845c061afefa796f7cf.camel@maquefel.me>
Subject: Re: [PATCH 0/4] DONOTMERGE: ep93xx-clk from ep93xx device tree
 conversion
From: Nikita Shubin <nikita.shubin@maquefel.me>
To: Conor Dooley <conor@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>,  Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Linus Walleij
 <linus.walleij@linaro.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski@linaro.org>
Date: Tue, 09 Apr 2024 14:48:59 +0300
In-Reply-To: <20240408-friction-mosaic-ba48bc27788d@spud>
References: <20240408-ep93xx-clk-v1-0-1d0f4c324647@maquefel.me>
	 <20240408-friction-mosaic-ba48bc27788d@spud>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.48.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

SGVsbG8gQ29ub3IhCgpPbiBNb24sIDIwMjQtMDQtMDggYXQgMTg6MDMgKzAxMDAsIENvbm9yIERv
b2xleSB3cm90ZToKPiBPbiBNb24sIEFwciAwOCwgMjAyNCBhdCAxMTowOTo1MkFNICswMzAwLCBO
aWtpdGEgU2h1YmluIHZpYSBCNCBSZWxheQo+IHdyb3RlOgo+ID4gVGhlIGdvYWwgaXMgdG8gcmVj
aWV2ZSBBQ0tzLgo+IAo+IEkgZG9udCBzZWUgYSBtYWludGFpbmVycyBlbnRyeSBpbiAtcmMxIGZv
ciB0aGUgZHJpdmVycy9zb2MvY2lycnVzCj4gcG9ydGlvbi4gV2hvIGlzIGdvbm5hIGdpdmUgeW91
IGFuIEFjayBmb3IgdGhhdCBwb3J0aW9uPyBJZiB5b3UKPiBpbnRlbmRlZAo+IG1haW50YWluaW5n
IHRoYXQgZHJpdmVyLCBzaG91bGQgeW91IG5vdCBhZGQgYSBNQUlOVEFJTkVSUyBlbnRyeSBmb3IK
PiBpdD8KCmRyaXZlcnMvc29jL2NpcnJ1cyBnb3QgaXQncyBBQ0sgZnJvbSBlcDkzeHggTUFJTlRB
SU5FUiAtIEFsZXhhbmRlcgpTdmVyZGxpbi4KCkFybmQsIEFsZXhhbmRlciAtIHNob3VsZCB3ZSBh
ZGQgaXQgbm93ID8KCkJ1dCBpIHN0aWxsIHJlcXVpcmUgQUNLIGZvciAiY2xrOiBlcDkzeHg6IGFk
ZCBEVCBzdXBwb3J0IGZvciBDaXJydXMKRVA5M3h4IiB3aGljaCBpcyBjbGsgc3Vic3lzdGVtcy4K
Cgo+IAo+IFRoYW5rcywKPiBDb25vci4KPiAKPiA+IAo+ID4gVGhpcyBpcyBhIGZyYWN0aW9uIG9m
IHY5ICJlcDkzeHggZGV2aWNlIHRyZWUgY29udmVyc2lvbiIgc2VyaWVzOgo+ID4gCj4gPiBodHRw
czovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyNDAzMjYtZXA5M3h4LXY5LTAtMTU2ZTJhZTVkZmM4
QG1hcXVlZmVsLm1lLwo+ID4gCj4gPiBUaGUgY2xrIGRyaXZlciBmb3IgZXA5M3h4IHdhcyBjb252
ZXJ0ZWQgdG8gQVVYIGRldmljZSwgYXMgc3VnZ2VzdGVkCj4gPiBvcmlnaW5hbGx5IGJ5IFN0ZXBo
ZW4gQm95ZC4KPiA+IAo+ID4gU2lnbmVkLW9mZi1ieTogTmlraXRhIFNodWJpbiA8bmlraXRhLnNo
dWJpbkBtYXF1ZWZlbC5tZT4KPiA+IC0tLQo+ID4gTmlraXRhIFNodWJpbiAoNCk6Cj4gPiDCoMKg
wqDCoMKgIEFSTTogZXA5M3h4OiBhZGQgcmVnbWFwIGF1eF9kZXYKPiA+IMKgwqDCoMKgwqAgY2xr
OiBlcDkzeHg6IGFkZCBEVCBzdXBwb3J0IGZvciBDaXJydXMgRVA5M3h4Cj4gPiDCoMKgwqDCoMKg
IGR0LWJpbmRpbmdzOiBzb2M6IEFkZCBDaXJydXMgRVA5M3h4Cj4gPiDCoMKgwqDCoMKgIHNvYzog
QWRkIFNvQyBkcml2ZXIgZm9yIENpcnJ1cyBlcDkzeHgKPiA+IAo+ID4gwqAuLi4vYmluZGluZ3Mv
YXJtL2NpcnJ1cy9jaXJydXMsZXA5MzAxLnlhbWzCoMKgwqDCoMKgwqDCoMKgIHzCoCAzOCArCj4g
PiDCoC4uLi9iaW5kaW5ncy9zb2MvY2lycnVzL2NpcnJ1cyxlcDkzMDEtc3lzY29uLnlhbWzCoCB8
wqAgOTQgKysrCj4gPiDCoGRyaXZlcnMvY2xrL0tjb25maWfCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoCA4ICsKPiA+IMKg
ZHJpdmVycy9jbGsvTWFrZWZpbGXCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgMSArCj4gPiDCoGRyaXZlcnMvY2xrL2Nsay1l
cDkzeHguY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgfCA4NDAKPiA+ICsrKysrKysrKysrKysrKysrKysrKwo+ID4gwqBkcml2ZXJzL3NvYy9LY29u
ZmlnwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgfMKgwqAgMSArCj4gPiDCoGRyaXZlcnMvc29jL01ha2VmaWxlwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgIDEg
Kwo+ID4gwqBkcml2ZXJzL3NvYy9jaXJydXMvS2NvbmZpZ8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgMTMgKwo+ID4gwqBkcml2ZXJzL3NvYy9jaXJy
dXMvTWFrZWZpbGXCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHzCoMKgIDIgKwo+ID4gwqBkcml2ZXJzL3NvYy9jaXJydXMvc29jLWVwOTN4eC5jwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCAyNDAgKysrKysrCj4gPiDCoGluY2x1ZGUv
ZHQtYmluZGluZ3MvY2xvY2svY2lycnVzLGVwOTMwMS1zeXNjb24uaMKgwqAgfMKgIDQ2ICsrCj4g
PiDCoGluY2x1ZGUvbGludXgvc29jL2NpcnJ1cy9lcDkzeHguaMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgfMKgIDI2ICsKPiA+IMKgMTIgZmlsZXMgY2hhbmdlZCwgMTMxMCBpbnNl
cnRpb25zKCspCj4gPiAtLS0KPiA+IGJhc2UtY29tbWl0OiBmZWM1MGRiNzAzM2VhNDc4NzczYjE1
OWUwZTJlZmIxMzUyNzBlM2I3Cj4gPiBjaGFuZ2UtaWQ6IDIwMjQwNDA4LWVwOTN4eC1jbGstNjU3
YTEzNTdkZTY3Cj4gPiAKPiA+IEJlc3QgcmVnYXJkcywKPiA+IC0tIAo+ID4gTmlraXRhIFNodWJp
biA8bmlraXRhLnNodWJpbkBtYXF1ZWZlbC5tZT4KPiA+IAo+ID4gCgo=


