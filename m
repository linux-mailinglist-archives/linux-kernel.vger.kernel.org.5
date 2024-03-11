Return-Path: <linux-kernel+bounces-99490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2FF7878924
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 20:54:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 210331C210CB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 19:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50FA85674D;
	Mon, 11 Mar 2024 19:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="ouCT6rfu"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132034206B
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 19:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710186862; cv=none; b=iy9UDYOk3Mp8M60Ek1pwObvfD17SSSx575PiiezexoitGqdjynbdrjj2eY11qvOG3hnd+QWcAF/jYZiITeCa6j+/XCxQLBv/fzNbbNJAV8alhadHV/83jAcwbIxghK+uS/mbdst9GQvHFGvSff45+yZNFXVmHMxlJ4xs5uDZr3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710186862; c=relaxed/simple;
	bh=I80kmniNaJNpW7w8bqB75g71TWFOq8gFFWvyljKYL0I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ul0QEixjWlOzN54EoQr+ojG/gkJc6piv5ZUk6Tjq9M+Y4xcO1VCOo6k82um48jwQ+T3+mTqrRA1/g5bnkV5vMgWeBCFXnzLSC5AFPCovm16xb/qo4dyieSW399KFN6sF+hgcvQwGr4aJiCiWqtFU/ti7vH8nt8WlXRL5jP3mfeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=ouCT6rfu; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 66BD72C0480;
	Tue, 12 Mar 2024 08:54:17 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1710186857;
	bh=I80kmniNaJNpW7w8bqB75g71TWFOq8gFFWvyljKYL0I=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=ouCT6rfuhAwy46/GC7cuoDbMuhNBhadJQtzGc0L+Uv5Qt7OmnrbgaD6eFH2LpWvYK
	 YviBS17oura5382vXkY2/LRpwiOaT7R7oad7PhB/yZuUzPBUc6bIS/U9h6xc7bS85w
	 FSza3SN0sj7tNNKomJc3nfDsfVcBGG9u3vUW0PqHafyqdD32Zs4ZMwh+R5tpxjHXaD
	 XdvlIE78oQq+Eb9LvsXThsalXxTtuz7tvJgOCi8SQlfneGo2tqsponyNI388N5nlZa
	 Vgwhvu5UZ+iSFJPmiCxILuSpaC7MbrkLwZonr/ETt8Nj89OYPYonWcBN4eeCUfng9q
	 EI2Qo4UvGB7Fg==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B65ef61690001>; Tue, 12 Mar 2024 08:54:17 +1300
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 12 Mar 2024 08:54:16 +1300
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1118.040; Tue, 12 Mar 2024 08:54:16 +1300
From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To: Arnd Bergmann <arnd@kernel.org>, Andy Shevchenko
	<andy.shevchenko@gmail.com>
CC: Gregory Clement <gregory.clement@bootlin.com>, Andy Shevchenko
	<andy@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Rob Herring
	<robh+dt@kernel.org>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth
	<sebastian.hesselbarth@gmail.com>, Lee Jones <lee@kernel.org>,
	"linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v5 3/3] ARM: dts: marvell: Add 7-segment LED display on
 x530
Thread-Topic: [PATCH v5 3/3] ARM: dts: marvell: Add 7-segment LED display on
 x530
Thread-Index: AQHacCEP50uDUqyXjk+YznxFpDHUm7EsnIcAgAAm+YCAAAZbAIAABFUAgAPI1gCAAKI2gIAA6F8A
Date: Mon, 11 Mar 2024 19:54:16 +0000
Message-ID: <df9e5c40-7b82-4038-93cc-3c454bf75b7a@alliedtelesis.co.nz>
References: <20240306235021.976083-1-chris.packham@alliedtelesis.co.nz>
 <20240306235021.976083-4-chris.packham@alliedtelesis.co.nz>
 <87edclgoon.fsf@BL-laptop>
 <CAHp75VfmSWH3FWEHU+bGYDuo-nt1DJhY5Fvs83A-RGrtrsgWTw@mail.gmail.com>
 <8177b94d-82c9-42b6-85eb-728dec762162@app.fastmail.com>
 <CAHp75VfiaWFricM4Or771P0LJVoFoEmQtoJo1hySo=BRS-59DQ@mail.gmail.com>
 <6c3451ed-6346-45e2-940e-851cb99a1b63@alliedtelesis.co.nz>
 <e90c2e69-17ea-4875-bb36-8a6d846f05e6@app.fastmail.com>
In-Reply-To: <e90c2e69-17ea-4875-bb36-8a6d846f05e6@app.fastmail.com>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <A9ED38D725C7F444854F1D2D79C8E5E0@atlnz.lc>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=BKkQr0QG c=1 sm=1 tr=0 ts=65ef6169 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=75chYTbOgJ0A:10 a=IkcTkHD0fZMA:10 a=K6JAEmCyrfEA:10 a=VwQbUJbxAAAA:8 a=P-IC7800AAAA:8 a=_VaukpeC9nYuBFLc3MMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=d3PnA9EDa4IxuAV0gXij:22
X-SEG-SpamProfiler-Score: 0

DQpPbiAxMS8wMy8yNCAxOTowMiwgQXJuZCBCZXJnbWFubiB3cm90ZToNCj4gT24gU3VuLCBNYXIg
MTAsIDIwMjQsIGF0IDIxOjIyLCBDaHJpcyBQYWNraGFtIHdyb3RlOg0KPj4gT24gOC8wMy8yNCAy
MzozNCwgQW5keSBTaGV2Y2hlbmtvIHdyb3RlOg0KPj4+IE9uIEZyaSwgTWFyIDgsIDIwMjQgYXQg
MTI6MTnigK9QTSBBcm5kIEJlcmdtYW5uIDxhcm5kQGtlcm5lbC5vcmc+IHdyb3RlOg0KPj4+PiBP
biBGcmksIE1hciA4LCAyMDI0LCBhdCAxMDo1NiwgQW5keSBTaGV2Y2hlbmtvIHdyb3RlOg0KPj4+
Pj4gT24gRnJpLCBNYXIgOCwgMjAyNCBhdCA5OjM24oCvQU0gR3JlZ29yeSBDTEVNRU5UIDxncmVn
b3J5LmNsZW1lbnRAYm9vdGxpbi5jb20+IHdyb3RlOg0KPj4+Pj4+IE5vcm1hbGx5LCB0aGlzIHBh
dGNoIHNob3VsZCBiZSB0YWtlbiBpbiBtdmVidSBhbmQgdGhlbiBtZXJnZWQgYnkNCj4+Pj4+PiBh
cm0tc29jLiBIb3dldmVyLCBJIGhhdmVuJ3Qgc2VlbiBhbnkgb3RoZXIgcGF0Y2ggdG91Y2hpbmcg
dGhpcyBmaWxlIChzbw0KPj4+Pj4+IG5vIHJpc2sgb2YgbWVyZ2UgY29uZmxpY3QpIGFuZCBJIHRo
aW5rIGl0J3MgdG9vIGxhdGUgZm9yIG1lIHRvIG1ha2UgYQ0KPj4+Pj4+IG5ldyBwdWxsIHJlcXVl
c3QgdG8gYXJtLXNvYy4gU28gSSdtIG5vdCBhZ2FpbnN0IGl0IGJlaW5nIHRha2VuIHdpdGggdGhl
DQo+Pj4+Pj4gcmVzdCBvZiB0aGUgcGF0Y2hlcy4gSG93ZXZlciwgSSB0aGluayBpdCB3b3VsZCBi
ZSBhIGdvb2QgaWRlYSB0byBzZWUNCj4+Pj4+PiB3aGF0IEFybmQgdGhpbmtzIGFib3V0IGl0Lg0K
Pj4gRllJIC4vc2NyaXB0cy9nZXRfbWFpbnRhaW5lci5wbCAtZiBhcmNoL2FybS9ib290L2R0cy9t
YXJ2ZWxsIGlzbid0DQo+PiBwaWNraW5nIHVwIEFybmQgc2hvdWxkIGl0Pw0KPiBObywgYXMgR3Jl
Z29yeSB3cml0ZXMsIHRoZSBpbnRlbmRlZCB3YXkgZm9yIHBsYXRmb3JtIHNwZWNpZmljDQo+IHBh
dGNoZXMgaXMgdG8gZ28gdGhyb3VnaCB0aGUgbWFpbnRhaW5lciBmb3IgdGhhdCBwbGF0Zm9ybSwN
Cj4gaW4gdGhpcyBjYXNlIGhpbSwgd2hvIHRoZW4gc2VuZHMgcHVsbCByZXF1ZXN0cyB0byBtZS4N
Cj4NCj4gU2luY2UgaXQgd2FzIGxhdGUgaW4gdGhlIG1lcmdlIHdpbmRvdywgaGUgc3VnZ2VzdGVk
IHNraXBwaW5nDQo+IHRoaXMgc3RlcCBhcyBhbiBleGNlcHRpb24sIHdoaWNoIGlzIHNvbWV0aGlu
ZyB3ZSBjYW4gYWx3YXlzIGRvDQo+IGlmIHRoZXJlIGlzIGFuIGltcG9ydGFudCByZWFzb24sIGp1
c3QgbGlrZSB5b3Ugc2tpcCBjYW4gYWxsDQo+IG1haW50YWluZXJzIGFuZCBnbyBkaXJlY3RseSB0
byBMaW51cyBpZiBuZWNlc3NhcnksIGJ1dCB0aGUNCj4gbWFpbnRhaW5lcnMgZmlsZSBvbmx5IGRv
Y3VtZW50cyB0aGUgbm9ybWFsIGNhc2UuDQoNCk9LIHRoYW5rcyBmb3IgdGhlIGNsYXJpZmljYXRp
b24uDQoNCkkgZG9uJ3QgdGhpbmsgdGhlcmUgaXMgYW55IHJlYXNvbiB0byBydXNoIHRoaXMuIEkn
bGwgc2VuZCBhIG5ldyBzZXJpZXMgDQpmb3IgdGhpcyBEVFMgY2hhbmdlIGFuZCBvbmUgb3RoZXIg
dGhhdCBJIGhhdmUgZm9yIHRoZSB4NTMwIHZpYSBHcmVnb3J5IA0KYW5kIGl0IGNhbiBjb21lIHRo
cm91Z2ggZm9yIGVpdGhlciA2Ljkgb3IgNi4xMC4NCg==

