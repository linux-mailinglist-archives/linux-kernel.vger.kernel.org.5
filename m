Return-Path: <linux-kernel+bounces-132956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A41899C76
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91909283326
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 12:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345BC16C85A;
	Fri,  5 Apr 2024 12:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="eat3qmIr"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB9B16C848;
	Fri,  5 Apr 2024 12:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712319067; cv=none; b=QYPM5fFoPaAhHmKQUbC69ahrx6KV99uS3jvEKp8s/gibumUnzo6qTyNIa8taLioOGmFOjMh4BFs7dfAoFMQiBf7VPH9q9m/y/a7SoN7tqVshdaFeNZFcB9WDJbi4/F4lMLmWRH+yR3fFnKdRs4CH7+Np1jqtTUrXAbUz+Wc+HhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712319067; c=relaxed/simple;
	bh=2y3FPyV6HSvnZaoGXs2ERFJRCnrD7omEs8OKzeD/qwE=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j9/p/bPZuRzZhUWFgBusvsV4c5NZjOu4ikdeRcqLoSt1asrFUIDXqJ2j/m6lSPkhK2bvlRvLCr84rW8s92bCjhnMCGEPhsRFxPyoSS3TuWafs0MOLCQTmAe0cgA2sG0CCgDitL5tklPmChE85pQ4Hh+kO4Yh8fPD/yjaCmiF08o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=eat3qmIr; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1712319062; x=1743855062;
  h=message-id:subject:from:to:date:in-reply-to:references:
   content-transfer-encoding:mime-version;
  bh=2y3FPyV6HSvnZaoGXs2ERFJRCnrD7omEs8OKzeD/qwE=;
  b=eat3qmIrYMfRAw6gTAvFvFOidF+ncBycTPNtabu3vv8SwG9lrfc5/JRU
   0T3RXAXrhfUoLp5rBy0WfHjg9q/D/4u6JvrnyJ9/U4OkoIbh+DxiaUKqn
   lUTcL/WOAsIlGMjy4Gmn2Gse2tEh0aam15BdVz8DNW3uyHeZUU8QmB5iR
   SksdfEfG67B3xCmWaKUucbakQgg72kf+qN3z3FpZY3mZVyUnHV6YghAm2
   J/767Hkm9qynsL5t+kgkGT/I2pC7H2mNIdB8LQCh6kOlaYdT4/q+15SLo
   HARK6od8fx26+Pr5UamDDBKepp9MO2/TzdwwQdaSL2lJzGe/YikLPk28g
   Q==;
X-CSE-ConnectionGUID: SXg+XRrSS0KpY0LY8rrGYQ==
X-CSE-MsgGUID: UaI54ZyIRLuNLKJH3MuHWg==
X-IronPort-AV: E=Sophos;i="6.07,181,1708412400"; 
   d="scan'208";a="19593931"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Apr 2024 05:11:01 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 5 Apr 2024 05:10:33 -0700
Received: from den-her-m31857h.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 5 Apr 2024 05:10:30 -0700
Message-ID: <67f29fa86207a68b148b826b71b1349d3552453d.camel@microchip.com>
Subject: Re: [PATCH RFT 09/10] arm64: dts: microchip: sparx5_pcb134: drop
 duplicated NOR flash
From: Steen Hegelund <steen.hegelund@microchip.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Conor Dooley <conor@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>, Claudiu Beznea
	<claudiu.beznea@tuxon.dev>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>, Lars Povlsen
	<lars.povlsen@microchip.com>, Daniel Machon <daniel.machon@microchip.com>,
	<UNGLinuxDriver@microchip.com>, "David S. Miller" <davem@davemloft.net>,
	Bjarni Jonasson <bjarni.jonasson@microchip.com>,
	<linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Date: Fri, 5 Apr 2024 14:10:30 +0200
In-Reply-To: <20240401153740.123978-9-krzk@kernel.org>
References: <20240401153740.123978-1-krzk@kernel.org>
	 <20240401153740.123978-9-krzk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

SGkgS3J6eXN6dG9mLAoKT24gTW9uLCAyMDI0LTA0LTAxIGF0IDE3OjM3ICswMjAwLCBLcnp5c3p0
b2YgS296bG93c2tpIHdyb3RlOgo+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mg
b3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQo+
IAo+IFNpbmNlIGJlZ2lubmluZyB0aGUgRFRTIGV4dGVuZGVkIHRoZSBTUEkwIGluIHR3byBwbGFj
ZXMgYWRkaW5nIHR3byBTUEkKPiBtdXhlcywgZWFjaCB3aXRoIHNhbWUgU1BJIE5PUiBmbGFzaC7C
oCBCb3RoIHVzZWQgZXhhY3RseSB0aGUgc2FtZQo+IGNoaXAtc2VsZWN0cywgc28gdGhpcyB3YXMg
Y2xlYXJseSBidWdneSBjb2RlLsKgIFdpdGhvdXQgY2hlY2tpbmcgaW4KPiBkYXRhc2hlZXQsIGFz
c3VtZSBkZXZpY2UgaGFzIG9ubHkgb25lIFNQSSBOT1IgZmxhc2gsIHNvIGNvZGUgd2FzCj4gZHVw
bGljYXRlZC4KPiAKPiBGaXhlcyBkdGMgVz0xIHdhcm5pbmdzOgo+IAo+IMKgIHNwYXJ4NV9wY2Ix
MzRfYm9hcmQuZHRzaToyNzcuMTAtMjgxLjQ6IFdhcm5pbmcgKHVuaXF1ZV91bml0X2FkZHJlc3Nf
aWZfZW5hYmxlZCk6Cj4gL2F4aUA2MDAwMDAwMDAvc3BpQDYwMDEwNDAwMC9mbGFzaEAwOiBkdXBs
aWNhdGUgdW5pdC1hZGRyZXNzIChhbHNvIHVzZWQgaW4gbm9kZQo+IC9heGlANjAwMDAwMDAwL3Nw
aUA2MDAxMDQwMDAvc3BpQDApCj4gCj4gU2lnbmVkLW9mZi1ieTogS3J6eXN6dG9mIEtvemxvd3Nr
aSA8a3J6a0BrZXJuZWwub3JnPgo+IAo+IC0tLQo+IAo+IE5vdCB0ZXN0ZWQgb24gaGFyZHdhcmUK
PiAtLS0KPiDCoC4uLi9ib290L2R0cy9taWNyb2NoaXAvc3Bhcng1X3BjYjEzNF9ib2FyZC5kdHNp
wqAgfCAxNiAtLS0tLS0tLS0tLS0tLS0tCj4gwqAxIGZpbGUgY2hhbmdlZCwgMTYgZGVsZXRpb25z
KC0pCj4gCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWljcm9jaGlwL3NwYXJ4
NV9wY2IxMzRfYm9hcmQuZHRzaQo+IGIvYXJjaC9hcm02NC9ib290L2R0cy9taWNyb2NoaXAvc3Bh
cng1X3BjYjEzNF9ib2FyZC5kdHNpCj4gaW5kZXggZjE2NWE0MDliYzFkLi5kYzdiNTlkZmNiNDAg
MTAwNjQ0Cj4gLS0tIGEvYXJjaC9hcm02NC9ib290L2R0cy9taWNyb2NoaXAvc3Bhcng1X3BjYjEz
NF9ib2FyZC5kdHNpCj4gKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9taWNyb2NoaXAvc3Bhcng1
X3BjYjEzNF9ib2FyZC5kdHNpCj4gQEAgLTI4MSwyMiArMjgxLDYgQEAgZmxhc2hAMCB7Cj4gwqDC
oMKgwqDCoMKgwqAgfTsKPiDCoH07Cj4gCj4gLSZzcGkwIHsKPiAtwqDCoMKgwqDCoMKgIHN0YXR1
cyA9ICJva2F5IjsKPiAtwqDCoMKgwqDCoMKgIHNwaUAwIHsKPiAtwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBjb21wYXRpYmxlID0gInNwaS1tdXgiOwo+IC3CoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIG11eC1jb250cm9scyA9IDwmbXV4PjsKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCAjYWRkcmVzcy1jZWxscyA9IDwxPjsKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCAjc2l6ZS1jZWxscyA9IDwwPjsKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBy
ZWcgPSA8MD47wqDCoMKgwqDCoCAvKiBDUzAgKi8KPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBmbGFzaEA5IHsKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgY29tcGF0aWJsZSA9ICJqZWRlYyxzcGktbm9yIjsKPiAtwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3BpLW1heC1mcmVxdWVuY3kgPSA8ODAwMDAwMD47
Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJlZyA9IDww
eDk+O8KgwqDCoCAvKiBTUEkgKi8KPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9Owo+
IC3CoMKgwqDCoMKgwqAgfTsKPiAtfTsKPiAtCgpXaGVuIHRlc3RpbmcgdGhpcyBvbiBhY3R1YWwg
SFcgdGhlIFNQSSBOT1IgaXMgbm8gbG9uZ2VyIGFjY2Vzc2libGUuClRoZSByZWFzb24gaXMgdGhh
dCBpdCBzaXRzIGJlaGluZCBhIFNQSS1NVVggYW5kIHRoYXQgbmVlZHMgdG8gYmUgcHJlc2VudCBp
biB0aGUgRGV2aWNlIFRyZWUuCgpTbyBpZiB5b3UgZG8gdGhlICJyZXZlcnNlIiBjbGVhbi11cCBp
dCB3b3JrcyBmaW5lOiBSZW1vdmUgdGhlIHNpbXBsZSBzcGkwIG5vZGUgYW5kIGtlZXAgdGhlIG9u
ZSB0aGF0CmhhcyB0aGUgc3BpLW11eCByZWZlcmVuY2UuCgo+IMKgJnNncGlvMCB7Cj4gwqDCoMKg
wqDCoMKgwqAgc3RhdHVzID0gIm9rYXkiOwo+IMKgwqDCoMKgwqDCoMKgIG1pY3JvY2hpcCxzZ3Bp
by1wb3J0LXJhbmdlcyA9IDw4IDE1PjsKPiAtLQo+IDIuMzQuMQo+IAoKVGhhbmtzIGZvciB0aGUg
Y2xlYW51cCBvZiB0aGUgRFQgZmlsZXMhCgpCZXN0IFJlZ2FyZHMKU3RlZW4K


