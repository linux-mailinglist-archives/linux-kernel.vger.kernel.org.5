Return-Path: <linux-kernel+bounces-71940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7CA85ACC9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 21:08:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09CA81C219C9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 20:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0076524CF;
	Mon, 19 Feb 2024 20:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="d7rrEy4f"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F17251C3B
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 20:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708373313; cv=none; b=ZjkkZTnFWwBgKBdLVZ3pSm9eVntvCvcO935KbHWf4TQi7QavH+1K1Hj5FesTkdbPFTvrW/L/vqoJUxpbKasNZECtvihUXiUWBO7h+hvQ+c8VYLH36oE8WBmlekwNhMC1DLNpNwn2VXOiOTIaNI3oso7SV6v1EJw/uE/ARzI0PUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708373313; c=relaxed/simple;
	bh=81oK5AvAbNIDN7cCUseasX8iGPbSF2LlWxBKfIONdIQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=g+ZyDd5Yu3Iz+2/cWN9e7DWYkvLQ0dngyldfMeOhnC6Ykr2anBpEeoaxvQwQroE3rlr4UnWGv2T+pTY9tRxJroeLMPUC66zSJoo8GNMJ3zRL2s8KAvESMjBRITUXagDhYEz5PTBburz4gznd+dVSJ4qoQOXKVDbg1L6qkt3rx4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=d7rrEy4f; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 95A032C03CF;
	Tue, 20 Feb 2024 09:08:27 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1708373307;
	bh=81oK5AvAbNIDN7cCUseasX8iGPbSF2LlWxBKfIONdIQ=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=d7rrEy4fHkNTXD3D8cc58tShkSIS4TzJF26NC7DYF/zb5cyveeUzy/SictLffnhtb
	 hSKmKKqiPWf6OmqBdMFInkabNECwkq4adhF2hS1aJd4jrmNtT697NCS5Mb6R1xxDl4
	 hRzn5lFMfOYX0MfcP2X6u78Xmy70buMpfjNJCGCzfdSeAHgoL2LMt9lXEv86fyLHuJ
	 LmSkR7BsJsFD4vo/i4/HWEV9P1FS8TK/zRe8o1Nf07R90wJ9IlzxsryB6J8XoSrC0f
	 0t1isop7nKMwkXbmsC5DHKatHSxO9tG2zu23c4hl1WqG7geOFb7hnhbC567+EnSSMf
	 bqEhzC3uGWfUQ==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B65d3b53b0001>; Tue, 20 Feb 2024 09:08:27 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1118.40; Tue, 20 Feb 2024 09:08:27 +1300
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with Microsoft
 SMTP Server (TLS) id 15.0.1497.48; Tue, 20 Feb 2024 09:08:27 +1300
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1118.040; Tue, 20 Feb 2024 09:08:27 +1300
From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To: Pavel Machek <pavel@ucw.cz>
CC: "lee@kernel.org" <lee@kernel.org>, "linux-leds@vger.kernel.org"
	<linux-leds@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: Linux support for a 7 segment LED display
Thread-Topic: Linux support for a 7 segment LED display
Thread-Index: AQHaXStZfYl8Vw6dm0yz1EAjpP4fVbEQ/haAgABMcAA=
Date: Mon, 19 Feb 2024 20:08:27 +0000
Message-ID: <344e00f9-a175-41d5-97dc-f60e771fea8d@alliedtelesis.co.nz>
References: <1f598a72-dd9f-4c6c-af7f-29751f84bd23@alliedtelesis.co.nz>
 <ZdN1G6PfCK9/vUol@duo.ucw.cz>
In-Reply-To: <ZdN1G6PfCK9/vUol@duo.ucw.cz>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <621EC9190373AF4A84CB0C8E756C9831@atlnz.lc>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=BKkQr0QG c=1 sm=1 tr=0 ts=65d3b53b a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=75chYTbOgJ0A:10 a=IkcTkHD0fZMA:10 a=k7vzHIieQBIA:10 a=yxPRVJ__m6dQz3HKPZUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0

DQpPbiAyMC8wMi8yNCAwNDozNCwgUGF2ZWwgTWFjaGVrIHdyb3RlOg0KPiBIaSENCj4NCj4+IEkn
bSBsb29raW5nIGZvciBzb21ldGhpbmcgdGhhdCBJIGZpZ3VyZWQgbXVzdCBleGlzdHMgYnV0IG1h
eWJlIGl0J3Mgc28NCj4+IG5pY2hlIHRoYXQgbm8tb25lIGhhcyBib3RoZXJlZCB0byB1cHN0cmVh
bSBhIGRyaXZlciBmb3IgaXQuDQo+Pg0KPj4gSSBoYXZlIGEgcmVxdWlyZW1lbnQgdG8gc3VwcG9y
dCBhIDctc2VnbWVudCBMRUQgZGlzcGxheVsxXSAob25lIHRoYXQgY2FuDQo+PiBkaXNwbGF5IGEg
c2luZ2xlIGRpZ2l0IGZyb20gMC05KS4gSGFyZHdhcmUgd2lzZSBpdCdzIGp1c3QgYSBidW5jaCBv
Zg0KPj4gaW5kaXZpZHVhbCBHUElPcyBjb25uZWN0ZWQgdG8gZWFjaCBzZWdtZW50IChwbHVzIGFu
IGV4dHJhIG9uZSBmb3IgYQ0KPj4gZG90KS4gSSBjYW4ndCBzZWUgYW55dGhpbmcgb2J2aW91cyBp
biBkcml2ZXJzL2xlZHMgYnV0IG1heWJlIEknbSBsb29raW5nDQo+PiBpbiB0aGUgd3JvbmcgcGxh
Y2UuIE9yIG1heWJlIGl0J3MgdGhlIGtpbmQgb2YgdGhpbmcgb24gUEMgaGFyZHdhcmUgdGhhdA0K
Pj4gaXMganVzdCBkcml2ZW4gYnkgdGhlIEJJT1Mgd2l0aG91dCB0aGUgb3BlcmF0aW5nIHN5c3Rl
bSBrbm93aW5nIGFib3V0IGl0Lg0KPiBMb29rIGF0IGRyaXZlcnMvYXV4ZGlzcGxheS4gSSBiZWxp
ZXZlIHdlIGhhdmUgc2VnbWVudCBkaXNwbGF5cyB0aGVyZS4NCg0KVGhhbmtzIGZvciB0aGUgcG9p
bnRlci4gSSBmb3VuZCBodDE2azMzLmMgKGFuZCANCmRyaXZlcnMvaW5wdXQvbWlzYy95ZWFsaW5r
LmMpIHdoaWNoIGhhdmUgc3VwcG9ydCBmb3IgNyBzZWdtZW50IGRpc3BsYXlzLiANClN0aWxsIG5v
dCBxdWl0ZSB3aGF0IEknZCBuZWVkIHRvIGdsdWUgaXQgdG9nZXRoZXIgd2l0aCBHUElPcyBidXQg
SSBjYW4gDQpzZWUgdGhlIGRpcmVjdGlvbiBvbmUgbWlnaHQgaGVhZC4NCg==

