Return-Path: <linux-kernel+bounces-159944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 351A68B369F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 13:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 684AE1C2273B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 11:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3957A145B11;
	Fri, 26 Apr 2024 11:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=maquefel.me header.i=@maquefel.me header.b="nKQZh/XK"
Received: from forward500c.mail.yandex.net (forward500c.mail.yandex.net [178.154.239.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CF5339A0;
	Fri, 26 Apr 2024 11:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714131706; cv=none; b=a3eMt0kg8Ld0f2sv94uWcx2gQCsdYswMkHNtZDJtE1fqpHx39d5YnBAudfvZD/bkCOo030F+2niALsVlOzRX1mdSZBGm8NuoUuxubhNeHucD5NMGuO2DW9Hvx2ZXnK1VzW059ubvIVu2y5zYZ+aj4GzDkv8efH/3CBXy+T3NLEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714131706; c=relaxed/simple;
	bh=zuhkMVswz3nX9ahbwxLQHhCv51dyDPVtxNyyq5Mwy7o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oA8unY184kUjQPI3HmDIIwXO56obCP0+enX9jm62g1AY0YYBtyGN3w7hsC6PZQJe8n733E2TFOTs8P8pPbU6p8bJ6qZ/NJ3nElkM8lWn89riCdWdSciZlLCiHezSG0bfMvMzZOg4Ws0ry5VBvCxZFch48Jp2hDaY8raamUMdVmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maquefel.me; spf=pass smtp.mailfrom=maquefel.me; dkim=pass (1024-bit key) header.d=maquefel.me header.i=@maquefel.me header.b=nKQZh/XK; arc=none smtp.client-ip=178.154.239.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maquefel.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maquefel.me
Received: from mail-nwsmtp-smtp-production-main-87.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-87.sas.yp-c.yandex.net [IPv6:2a02:6b8:c11:49a3:0:640:a0c5:0])
	by forward500c.mail.yandex.net (Yandex) with ESMTPS id F27FA613FE;
	Fri, 26 Apr 2024 14:41:36 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-87.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id ZfL6gG5Pna60-JEqgUJH4;
	Fri, 26 Apr 2024 14:41:36 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail;
	t=1714131696; bh=zuhkMVswz3nX9ahbwxLQHhCv51dyDPVtxNyyq5Mwy7o=;
	h=References:Date:In-Reply-To:Cc:To:From:Subject:Message-ID;
	b=nKQZh/XKsBbqRu2leMCnXvz3d+vPP3eFsIK9dNvvmTdRZSZCVb/JU06wJ6jRtXMVk
	 KiCYQpls8NcEma39p8zlOHcxHPtAT2wH7TAZnlL6MhvZH6N2knIApBvKgpIvakozGl
	 it2jLW2kjmAASp4El05dG35QTQaxhcq+BFYIT+zE=
Authentication-Results: mail-nwsmtp-smtp-production-main-87.sas.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
Message-ID: <65ded0d9629fa0922d58fe230cbfb9ec0c8673f5.camel@maquefel.me>
Subject: Re: [PATCH v2 0/4] DONOTMERGE: ep93xx-clk from ep93xx device tree
 conversion
From: Nikita Shubin <nikita.shubin@maquefel.me>
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>,  Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Linus Walleij
 <linus.walleij@linaro.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski@linaro.org>
Date: Fri, 26 Apr 2024 14:41:35 +0300
In-Reply-To: <20240408-ep93xx-clk-v2-0-9c5629dec2dd@maquefel.me>
References: <20240408-ep93xx-clk-v2-0-9c5629dec2dd@maquefel.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.48.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

SGkgU3RlcGhlbiwKCkNvdWxkIHlvdSBwbGVhc2UgbG9vayBpbnRvIHYyIHNlcmllcyA/CgpPbiBT
dW4sIDIwMjQtMDQtMTQgYXQgMTM6MDMgKzAzMDAsIE5pa2l0YSBTaHViaW4gdmlhIEI0IFJlbGF5
IHdyb3RlOgo+IFRoZSBnb2FsIGlzIHRvIHJlY2lldmUgQUNLcy4KPiAKPiBUaGlzIGlzIGEgZnJh
Y3Rpb24gb2YgdjkgImVwOTN4eCBkZXZpY2UgdHJlZSBjb252ZXJzaW9uIiBzZXJpZXM6Cj4gCj4g
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjQwMzI2LWVwOTN4eC12OS0wLTE1NmUyYWU1
ZGZjOEBtYXF1ZWZlbC5tZS8KPiAKPiBUaGUgY2xrIGRyaXZlciBmb3IgZXA5M3h4IHdhcyBjb252
ZXJ0ZWQgdG8gQVVYIGRldmljZSwgYXMgc3VnZ2VzdGVkCj4gb3JpZ2luYWxseSBieSBTdGVwaGVu
IEJveWQuCj4gCj4gU2lnbmVkLW9mZi1ieTogTmlraXRhIFNodWJpbiA8bmlraXRhLnNodWJpbkBt
YXF1ZWZlbC5tZT4KPiAtLS0KPiBDaGFuZ2VzIGluIHYyOgo+IC0gc29jOiBBZGQgU29DIGRyaXZl
ciBmb3IgQ2lycnVzIGVwOTN4eDoKPiDCoCAtIGFkZGVkIF9faW5pdCBmb3IgZXA5M3h4X2FkZXZf
YWxsb2MoKSwKPiBlcDkzeHhfY29udHJvbGxlcl9yZWdpc3RlcigpCj4gwqAgLSBhZGRlZCBzdGF0
aWMsIF9faW5pdGNvbnN0IGZvciBwaW5jdHJsX25hbWVzW10KPiDCoCAtIGNsayByZXZpc2lvbiBm
b3IgU1BJIGlzIG5vdyByZXNvbHZlZCBoZXJlIHRocm91Z2ggZGlmZmVyZW50bHkKPiBuYW1lZAo+
IMKgwqDCoCBjbGsgZGV2aWNlCj4gwqAgLSBtb3JlIHZlcmJvc2UgS2NvbmZpZyBkZXNjcmlwdGlv
bgo+IAo+IMKgIE5PVEU6ICJvZiIgaW5jbHVkZXMgYXJlIHJlcXVpcmVkIHVuZm9ydHVuYXRlbHku
Cj4gCj4gLSBjbGs6IGVwOTN4eDogYWRkIERUIHN1cHBvcnQgZm9yIENpcnJ1cyBFUDkzeHg6Cj4g
wqAgLSBkcm9wcGVkIGluY2x1ZGVzCj4gwqAgLSBkcm9wcGVkIGVwOTN4eF9zb2NfdGFibGVbXQo+
IMKgIC0gYWRkIGRpZmZlcmVudCBuYW1lZCBjbGsgYW5kIGRyb3BwZWQgaW52b2x2ZWQgaW5jbHVk
ZXMKPiDCoCAtIG1vdmVkIHBsbCdzIGFuZCBmY2xrLCBoY2xrLCBwY2xrIGluaXQgdG8gc2VwYXJh
dGUgZnVuY3Rpb24KPiDCoCAtIGZpeGVkIGVwOTN4eF9jbGtfaWRzW10gZXhwbGljaXQgbGluZXMK
PiDCoAo+IMKgIE5PVEU6IGNsa19od19yZWdpc3Rlcl9kaXYoKSBpcyBjbGstZXA5eHggaW50ZXJu
YWwgZnVuY3Rpb24gd2hpY2gKPiB1c2VzCj4gwqAgZGV2bS4KPiAKPiAtLS0KPiBOaWtpdGEgU2h1
YmluICg0KToKPiDCoMKgwqDCoMKgIEFSTTogZXA5M3h4OiBhZGQgcmVnbWFwIGF1eF9kZXYKPiDC
oMKgwqDCoMKgIGNsazogZXA5M3h4OiBhZGQgRFQgc3VwcG9ydCBmb3IgQ2lycnVzIEVQOTN4eAo+
IMKgwqDCoMKgwqAgZHQtYmluZGluZ3M6IHNvYzogQWRkIENpcnJ1cyBFUDkzeHgKPiDCoMKgwqDC
oMKgIHNvYzogQWRkIFNvQyBkcml2ZXIgZm9yIENpcnJ1cyBlcDkzeHgKPiAKPiDCoC4uLi9iaW5k
aW5ncy9hcm0vY2lycnVzL2NpcnJ1cyxlcDkzMDEueWFtbMKgwqDCoMKgwqDCoMKgwqAgfMKgIDM4
ICsKPiDCoC4uLi9iaW5kaW5ncy9zb2MvY2lycnVzL2NpcnJ1cyxlcDkzMDEtc3lzY29uLnlhbWzC
oCB8wqAgOTQgKysrCj4gwqBkcml2ZXJzL2Nsay9LY29uZmlnwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgOCArCj4gwqBk
cml2ZXJzL2Nsay9NYWtlZmlsZcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoCAxICsKPiDCoGRyaXZlcnMvY2xrL2Nsay1lcDkz
eHguY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
fCA4MzQKPiArKysrKysrKysrKysrKysrKysrKysKPiDCoGRyaXZlcnMvc29jL0tjb25maWfCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCB8wqDCoCAxICsKPiDCoGRyaXZlcnMvc29jL01ha2VmaWxlwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgIDEgKwo+IMKgZHJp
dmVycy9zb2MvY2lycnVzL0tjb25maWfCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgfMKgIDE3ICsKPiDCoGRyaXZlcnMvc29jL2NpcnJ1cy9NYWtlZmlsZcKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgMiArCj4g
wqBkcml2ZXJzL3NvYy9jaXJydXMvc29jLWVwOTN4eC5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgfCAyNTIgKysrKysrKwo+IMKgaW5jbHVkZS9kdC1iaW5kaW5ncy9jbG9j
ay9jaXJydXMsZXA5MzAxLXN5c2Nvbi5owqDCoCB8wqAgNDYgKysKPiDCoGluY2x1ZGUvbGludXgv
c29jL2NpcnJ1cy9lcDkzeHguaMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKg
IDI2ICsKPiDCoDEyIGZpbGVzIGNoYW5nZWQsIDEzMjAgaW5zZXJ0aW9ucygrKQo+IC0tLQo+IGJh
c2UtY29tbWl0OiBmZWM1MGRiNzAzM2VhNDc4NzczYjE1OWUwZTJlZmIxMzUyNzBlM2I3Cj4gY2hh
bmdlLWlkOiAyMDI0MDQwOC1lcDkzeHgtY2xrLTY1N2ExMzU3ZGU2Nwo+IAo+IEJlc3QgcmVnYXJk
cywKCg==


