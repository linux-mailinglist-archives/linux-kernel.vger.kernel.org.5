Return-Path: <linux-kernel+bounces-98832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF89878007
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 13:32:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E2FC1F20F59
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 12:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A30438F87;
	Mon, 11 Mar 2024 12:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jVDZNQCN"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D2B8460;
	Mon, 11 Mar 2024 12:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710160333; cv=none; b=Wuu63WuDzTiGyVICwABW8Eh9xWU1cB1QJbs/fpPp/VzH5ta1TJc82UPye6en7FQmJia4YtS8OYt88AO7+fEwtmu0HpR8zQ9QsKlSWDNkZTFiMJEzbXUTAyYbsroBlyUBDLfvd00Xid97Tnd/ekD7EkeKYroQdMK9X92kandpp48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710160333; c=relaxed/simple;
	bh=/0WQn3Xzj1W+6e43Qm7hKpyx5ObMVgEupUwIuuTLVZg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ll3MX8qi9z0lL0eFXk1i5HaXeOGYE24pTwHGDYbdsrm6d7qwJspWPp9W0mNfMUkCiCliIvdYVZp6fS7ogScr5n/G0Cue6y5V6XNsBHtYSZmsrpSNn7H3HVfr0wyKC9zbK5kAydP1YeCGzlUaUabme/z54vhwyga7FymExAP3n7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jVDZNQCN; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4132ab0eea9so4297975e9.1;
        Mon, 11 Mar 2024 05:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710160330; x=1710765130; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/0WQn3Xzj1W+6e43Qm7hKpyx5ObMVgEupUwIuuTLVZg=;
        b=jVDZNQCNND8Jb1mHqtChtYVC5DEbfHJ7WG1jAIQPdrddLDmQ5wks35k9nftR17VwJ9
         veD11PKT6NFSzoAHDyKsmBUFO4CVYlL3C7eiaz0fsND2UP/uYme4fWPBm02K8DsSzdiA
         iNMCQ2UveSftIYu9J56GM7Y6sEIcn5Jkr+naD8igA2Iwa1QDtPEmKBGgng2c9IWHXWUa
         NqmZuXUdUUZrcP47e0neT21J2H3LuBTsSf7fKWIRyDacIkB/fDnQD4fPOfCevdhoY1N3
         Zj5G3noO6a4peJoNsjUPtp5VvYa/4yuIFdZhFVd/AFimjWdqaNBQ641z3R/OkL+mpKv/
         x9cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710160330; x=1710765130;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/0WQn3Xzj1W+6e43Qm7hKpyx5ObMVgEupUwIuuTLVZg=;
        b=rX+waiMX/eWMJq7c/eE/UPdg7FqRzIOY7tIsKwyt+FaKgDcA/DkK30Uwy70za2UsGa
         1C5/HFawo6SFWkLNjH6jCSj0h0VxGVAM3i4oc/ULSXhyeYQm9VQA8BZEi/ECGzNqiSA1
         PPtvmq/8kNkV/GeyQHlgARdLZEBqZcJIBmDWmwsM6KIM2zhdH+KteUXx14SlCJiOnUU0
         hMav0YDd1FwBjBl5sKemX1LiMOchiZ+40SCJW6RHRZq1WA1vIqsvuO/MaqhTWbIhCnpX
         eR8DqHKEK0StFCd8Ck3FAtsd3wAGYxcs8mwgep/A3oHVbyerP1YTQHJvexNSdC1bZSJm
         yBUw==
X-Forwarded-Encrypted: i=1; AJvYcCXJPNXsCem+Zlyl+QilZxVau81wxKfobCOanUWPayGfRl2ZVwEW4xaVkI5lUmvc7pedrE0qU0AS3/mkVmiZAG2ArtVnyHH78/XPS5Ayon31zjf5Bola4ar2NtIobLGPHEl9UaWFJ+T7msckL4SQwWLTsQF0eCOFlqpz1AZVkn1UKS+holXVNpLVyGz3WnIurlY57fS2uJx/
X-Gm-Message-State: AOJu0Yw16kqIY8e01h4GurgM/cE9HOYtLRGMFDwUoV3NzyTgGwnU81BY
	6e3WUl75uKYa8wEupf3/K+PYWXuVVvEgdlp5RSsNCXTnt+T5IoKX
X-Google-Smtp-Source: AGHT+IH6PCLAEtZR5QCAsvTMNU/43O7KfXp4UD3hd/JnfpATbo6PKsgu2hsQTls2sxCyoZ7umOQvDg==
X-Received: by 2002:a05:600c:1d12:b0:413:2ea4:1731 with SMTP id l18-20020a05600c1d1200b004132ea41731mr667775wms.15.1710160329804;
        Mon, 11 Mar 2024 05:32:09 -0700 (PDT)
Received: from ?IPv6:2001:8a0:e60f:3100:f272:bc42:d450:41d1? ([2001:8a0:e60f:3100:f272:bc42:d450:41d1])
        by smtp.gmail.com with ESMTPSA id n4-20020a05600c4f8400b00412ff941abasm15498701wmq.21.2024.03.11.05.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 05:32:09 -0700 (PDT)
Message-ID: <f29d9e045dab0b22d51d87f0ee44999c6a12f874.camel@gmail.com>
Subject: Re: [PATCH v3] can: mcp251xfd: fix infinite loop when xmit fails
From: vitor <ivitro@gmail.com>
To: mkl@pengutronix.de, Manivannan Sadhasivam
 <manivannan.sadhasivam@linaro.org>,  Thomas Kopp
 <thomas.kopp@microchip.com>, Wolfgang Grandegger <wg@grandegger.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>
Cc: Vitor Soares <vitor.soares@toradex.com>, linux-can@vger.kernel.org, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Mon, 11 Mar 2024 12:32:08 +0000
In-Reply-To: <20240311121143.306403-1-ivitro@gmail.com>
References: <20240311121143.306403-1-ivitro@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

VGhlIHByZXZpb3VzIGVtYWlsIG1pc3NlcyB0aGUgdjMgb24gdGhlIHN1YmplY3QsIGFkZGVkIG9u
IHRoaXMgb25lLgoKT24gTW9uLCAyMDI0LTAzLTExIGF0IDEyOjExICswMDAwLCBWaXRvciBTb2Fy
ZXMgd3JvdGU6Cj4gRnJvbTogVml0b3IgU29hcmVzIDx2aXRvci5zb2FyZXNAdG9yYWRleC5jb20+
Cj4gCj4gV2hlbiB0aGUgbWNwMjUxeGZkX3N0YXJ0X3htaXQoKSBmdW5jdGlvbiBmYWlscywgdGhl
IGRyaXZlciBzdG9wcwo+IHByb2Nlc3NpbmcgbWVzc2FnZXMsIGFuZCB0aGUgaW50ZXJydXB0IHJv
dXRpbmUgZG9lcyBub3QgcmV0dXJuLAo+IHJ1bm5pbmcgaW5kZWZpbml0ZWx5IGV2ZW4gYWZ0ZXIg
a2lsbGluZyB0aGUgcnVubmluZyBhcHBsaWNhdGlvbi4KPiAKPiBFcnJvciBtZXNzYWdlczoKPiBb
wqAgNDQxLjI5ODgxOV0gbWNwMjUxeGZkIHNwaTIuMCBjYW4wOiBFUlJPUiBpbiBtY3AyNTF4ZmRf
c3RhcnRfeG1pdDoKPiAtMTYKPiBbwqAgNDQxLjMwNjQ5OF0gbWNwMjUxeGZkIHNwaTIuMCBjYW4w
OiBUcmFuc21pdCBFdmVudCBGSUZPIGJ1ZmZlciBub3QKPiBlbXB0eS4gKHNlcT0weDAwMDAxN2M3
LCB0ZWZfdGFpbD0weDAwMDAxN2NmLCB0ZWZfaGVhZD0weDAwMDAxN2QwLAo+IHR4X2hlYWQ9MHgw
MDAwMTdkMykuCj4gLi4uIGFuZCByZXBlYXQgZm9yZXZlci4KPiAKPiBUaGUgaXNzdWUgY2FuIGJl
IHRyaWdnZXJlZCB3aGVuIG11bHRpcGxlIGRldmljZXMgc2hhcmUgdGhlIHNhbWUKPiBTUEkgaW50
ZXJmYWNlLiBBbmQgdGhlcmUgaXMgY29uY3VycmVudCBhY2Nlc3MgdG8gdGhlIGJ1cy4KPiAKPiBU
aGUgcHJvYmxlbSBvY2N1cnMgYmVjYXVzZSB0eF9yaW5nLT5oZWFkIGluY3JlbWVudHMgZXZlbiBp
Zgo+IG1jcDI1MXhmZF9zdGFydF94bWl0KCkgZmFpbHMuIENvbnNlcXVlbnRseSwgdGhlIGRyaXZl
ciBza2lwcyBvbmUKPiBUWCBwYWNrYWdlIHdoaWxlIHN0aWxsIGV4cGVjdGluZyBhIHJlc3BvbnNl
IGluCj4gbWNwMjUxeGZkX2hhbmRsZV90ZWZpZl9vbmUoKS4KPiAKPiBUaGlzIHBhdGNoIHJlc29s
dmVzIHRoZSBpc3N1ZSBieSBkZWNyZWFzaW5nIHR4X3JpbmctPmhlYWQgaWYKPiBtY3AyNTF4ZmRf
c3RhcnRfeG1pdCgpIGZhaWxzLiBXaXRoIHRoZSBmaXgsIGlmIHdlIHRyaWdnZXIgdGhlIGlzc3Vl
Cj4gYW5kCj4gdGhlIGVyciA9IC1FQlVTWSwgdGhlIGRyaXZlciByZXR1cm5zIE5FVERFVl9UWF9C
VVNZLiBUaGUgbmV0d29yawo+IHN0YWNrCj4gcmV0cmllcyB0byB0cmFuc21pdCB0aGUgbWVzc2Fn
ZS4KPiBPdGhlcndpc2UsIGl0IHByaW50cyBhbiBlcnJvciBhbmQgZGlzY2FyZHMgdGhlIG1lc3Nh
Z2UuCj4gCj4gRml4ZXM6IDU1ZTViOTdmMDAzZSAoImNhbjogbWNwMjV4eGZkOiBhZGQgZHJpdmVy
IGZvciBNaWNyb2NoaXAKPiBNQ1AyNXh4RkQgU1BJIENBTiIpCj4gQ2M6IHN0YWJsZUB2Z2VyLmtl
cm5lbC5vcmcKPiBTaWduZWQtb2ZmLWJ5OiBWaXRvciBTb2FyZXMgPHZpdG9yLnNvYXJlc0B0b3Jh
ZGV4LmNvbT4KPiAtLS0KPiAKPiBWMi0+VjM6Cj4gwqAgLSBBZGQgdHhfZHJvcHBlZCBzdGF0cy4K
PiDCoCAtIG5ldGRldl9zZW50X3F1ZXVlKCkgb25seSBpZiBjYW5fcHV0X2VjaG9fc2tiKCkgc3Vj
Y2VlZC4KPiAKPiBWMS0+VjI6Cj4gwqAgLSBSZXR1cm4gTkVUREVWX1RYX0JVU1kgaWYgbWNwMjUx
eGZkX3R4X29ial93cml0ZSgpID09IC1FQlVTWS4KPiDCoCAtIFJld29yayB0aGUgY29tbWl0IG1l
c3NhZ2UgdG8gYWRkcmVzcyB0aGUgY2hhbmdlIGFib3ZlLgo+IMKgIC0gQ2hhbmdlIGNhbl9wdXRf
ZWNob19za2IoKSB0byBiZSBjYWxsZWQgYWZ0ZXIKPiBtY3AyNTF4ZmRfdHhfb2JqX3dyaXRlKCkg
c3VjY2VlZC4KPiDCoMKgwqAgT3RoZXJ3aXNlLCB3ZSBnZXQgS2VybmVsIE5VTEwgcG9pbnRlciBk
ZXJlZmVyZW5jZSBlcnJvci4KPiAKPiDCoGRyaXZlcnMvbmV0L2Nhbi9zcGkvbWNwMjUxeGZkL21j
cDI1MXhmZC10eC5jIHwgMzQgKysrKysrKysrKysrLS0tLS0tCj4gLS0KPiDCoDEgZmlsZSBjaGFu
Z2VkLCAyMSBpbnNlcnRpb25zKCspLCAxMyBkZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9uZXQvY2FuL3NwaS9tY3AyNTF4ZmQvbWNwMjUxeGZkLXR4LmMKPiBiL2RyaXZlcnMv
bmV0L2Nhbi9zcGkvbWNwMjUxeGZkL21jcDI1MXhmZC10eC5jCj4gaW5kZXggMTYwNTI4ZDNjYzI2
Li4xNDZjNDRlNDdjNjAgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9uZXQvY2FuL3NwaS9tY3AyNTF4
ZmQvbWNwMjUxeGZkLXR4LmMKPiArKysgYi9kcml2ZXJzL25ldC9jYW4vc3BpL21jcDI1MXhmZC9t
Y3AyNTF4ZmQtdHguYwo+IEBAIC0xNjYsNiArMTY2LDcgQEAgbmV0ZGV2X3R4X3QgbWNwMjUxeGZk
X3N0YXJ0X3htaXQoc3RydWN0IHNrX2J1ZmYKPiAqc2tiLAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IG5ldF9k
ZXZpY2UgKm5kZXYpCj4gwqB7Cj4gwqDCoMKgwqDCoMKgwqDCoHN0cnVjdCBtY3AyNTF4ZmRfcHJp
diAqcHJpdiA9IG5ldGRldl9wcml2KG5kZXYpOwo+ICvCoMKgwqDCoMKgwqDCoHN0cnVjdCBuZXRf
ZGV2aWNlX3N0YXRzICpzdGF0cyA9ICZuZGV2LT5zdGF0czsKPiDCoMKgwqDCoMKgwqDCoMKgc3Ry
dWN0IG1jcDI1MXhmZF90eF9yaW5nICp0eF9yaW5nID0gcHJpdi0+dHg7Cj4gwqDCoMKgwqDCoMKg
wqDCoHN0cnVjdCBtY3AyNTF4ZmRfdHhfb2JqICp0eF9vYmo7Cj4gwqDCoMKgwqDCoMKgwqDCoHVu
c2lnbmVkIGludCBmcmFtZV9sZW47Cj4gQEAgLTE4MSwyNSArMTgyLDMyIEBAIG5ldGRldl90eF90
IG1jcDI1MXhmZF9zdGFydF94bWl0KHN0cnVjdCBza19idWZmCj4gKnNrYiwKPiDCoMKgwqDCoMKg
wqDCoMKgdHhfb2JqID0gbWNwMjUxeGZkX2dldF90eF9vYmpfbmV4dCh0eF9yaW5nKTsKPiDCoMKg
wqDCoMKgwqDCoMKgbWNwMjUxeGZkX3R4X29ial9mcm9tX3NrYihwcml2LCB0eF9vYmosIHNrYiwg
dHhfcmluZy0+aGVhZCk7Cj4gwqAKPiAtwqDCoMKgwqDCoMKgwqAvKiBTdG9wIHF1ZXVlIGlmIHdl
IG9jY3VweSB0aGUgY29tcGxldGUgVFggRklGTyAqLwo+IMKgwqDCoMKgwqDCoMKgwqB0eF9oZWFk
ID0gbWNwMjUxeGZkX2dldF90eF9oZWFkKHR4X3JpbmcpOwo+IC3CoMKgwqDCoMKgwqDCoHR4X3Jp
bmctPmhlYWQrKzsKPiAtwqDCoMKgwqDCoMKgwqBpZiAobWNwMjUxeGZkX2dldF90eF9mcmVlKHR4
X3JpbmcpID09IDApCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoG5ldGlmX3N0b3Bf
cXVldWUobmRldik7Cj4gLQo+IMKgwqDCoMKgwqDCoMKgwqBmcmFtZV9sZW4gPSBjYW5fc2tiX2dl
dF9mcmFtZV9sZW4oc2tiKTsKPiAtwqDCoMKgwqDCoMKgwqBlcnIgPSBjYW5fcHV0X2VjaG9fc2ti
KHNrYiwgbmRldiwgdHhfaGVhZCwgZnJhbWVfbGVuKTsKPiAtwqDCoMKgwqDCoMKgwqBpZiAoIWVy
cikKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgbmV0ZGV2X3NlbnRfcXVldWUocHJp
di0+bmRldiwgZnJhbWVfbGVuKTsKPiArCj4gK8KgwqDCoMKgwqDCoMKgdHhfcmluZy0+aGVhZCsr
Owo+IMKgCj4gwqDCoMKgwqDCoMKgwqDCoGVyciA9IG1jcDI1MXhmZF90eF9vYmpfd3JpdGUocHJp
diwgdHhfb2JqKTsKPiAtwqDCoMKgwqDCoMKgwqBpZiAoZXJyKQo+IC3CoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqBnb3RvIG91dF9lcnI7Cj4gK8KgwqDCoMKgwqDCoMKgaWYgKGVycikgewo+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB0eF9yaW5nLT5oZWFkLS07Cj4gwqAKPiAt
wqDCoMKgwqDCoMKgwqByZXR1cm4gTkVUREVWX1RYX09LOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqBpZiAoZXJyID09IC1FQlVTWSkKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiBORVRERVZfVFhfQlVTWTsKPiDCoAo+IC0gb3V0
X2VycjoKPiAtwqDCoMKgwqDCoMKgwqBuZXRkZXZfZXJyKHByaXYtPm5kZXYsICJFUlJPUiBpbiAl
czogJWRcbiIsIF9fZnVuY19fLCBlcnIpOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqBzdGF0cy0+dHhfZHJvcHBlZCsrOwo+ICsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgaWYgKG5ldF9yYXRlbGltaXQoKSkKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoG5ldGRldl9lcnIocHJpdi0+bmRldiwKPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICJFUlJP
UiBpbiAlczogJWRcbiIsIF9fZnVuY19fLAo+IGVycik7Cj4gK8KgwqDCoMKgwqDCoMKgfSBlbHNl
IHsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZXJyID0gY2FuX3B1dF9lY2hvX3Nr
Yihza2IsIG5kZXYsIHR4X2hlYWQsCj4gZnJhbWVfbGVuKTsKPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgaWYgKCFlcnIpCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqBuZXRkZXZfc2VudF9xdWV1ZShwcml2LT5uZGV2LCBmcmFtZV9sZW4pOwo+
ICsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLyogU3RvcCBxdWV1ZSBpZiB3ZSBv
Y2N1cHkgdGhlIGNvbXBsZXRlIFRYIEZJRk8gKi8KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgaWYgKG1jcDI1MXhmZF9nZXRfdHhfZnJlZSh0eF9yaW5nKSA9PSAwKQo+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgbmV0aWZfc3RvcF9xdWV1ZShu
ZGV2KTsKPiArwqDCoMKgwqDCoMKgwqB9Cj4gwqAKPiDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIE5F
VERFVl9UWF9PSzsKPiDCoH0KCg==


