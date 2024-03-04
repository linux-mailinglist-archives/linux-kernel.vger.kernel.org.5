Return-Path: <linux-kernel+bounces-89952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE9B86F805
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 01:45:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11609B20B00
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 00:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A321378;
	Mon,  4 Mar 2024 00:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="qGQGCxOa"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C34399
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 00:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709513124; cv=none; b=jws5R/RX2hOcCG+ix4zlyb/Hk1qsk3BYT2Va9d79kiQ4IkTEMSJFHI+t4Bkx3PDjQGFzwvRxkZ0jkqN3OcKjGPeZnGm82dU6RqM08Wbu0V4fkC82AwDV7/XFl1EeGQ9/xNif6M0CY9F0kTUvMiMajW2qZ0MApyXffdEs4jkYw3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709513124; c=relaxed/simple;
	bh=drxWLVlGFquplC+ZwDRQPLCYajTjKR6JlYEOaGcydF0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IX1und+EH8EwyJNagQSBVsA/moJgGcL/rgpk34lLpKtYZrAYeWMHEdjBUpn8edXV8Bg3tx72SF8xxqUS9Qd6Wtj/PlTbV4eLJhLudVa1SpJBi8K0iVHVwNYpAZzHMTlDMEwjMBXUJqME/T6aXHcjUc/B1uyeZUI3/2nuHK8zCdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=qGQGCxOa; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 95EEC2C061F;
	Mon,  4 Mar 2024 13:45:19 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1709513119;
	bh=drxWLVlGFquplC+ZwDRQPLCYajTjKR6JlYEOaGcydF0=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=qGQGCxOa68ptNhLnU1QpJ77N0Wr669gqo2IhCT2GzJJcqsEkFO6pgiHME+KXzqpBE
	 l2EohDSDxYFw4srv6YJIKuI4fWrTFKU2S7TW7jq2/G6/pHrqCpGIjb3WwlEYpmM5bL
	 naumd+Sp6U5BuaREl8FELtD6YOAut68E9KPOpDaaOBO5hNKTVrvqjBoF04RMwXP4iI
	 wdZHpaEAVa+nCkLWS1WXCWeIQKvH7sisr9Zn25KuhLV6VQJWC2k4a/Z3mOI5LMc7uR
	 4s3F00Yy7z7AnVJMCTiYb+nYwPT/h/L281rNyqEybyY/wsFpTjx4YKTP5vOXWuqH9r
	 OPi+4F+1xYqyw==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B65e5199f0001>; Mon, 04 Mar 2024 13:45:19 +1300
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 4 Mar 2024 13:45:19 +1300
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1118.040; Mon, 4 Mar 2024 13:45:19 +1300
From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To: Andy Shevchenko <andy@kernel.org>
CC: "geert@linux-m68k.org" <geert@linux-m68k.org>, "robh+dt@kernel.org"
	<robh+dt@kernel.org>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "andrew@lunn.ch" <andrew@lunn.ch>,
	"gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
	"sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>,
	"pavel@ucw.cz" <pavel@ucw.cz>, "lee@kernel.org" <lee@kernel.org>,
	"linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 1/4] auxdisplay: Add 7-segment LED display driver
Thread-Topic: [PATCH v3 1/4] auxdisplay: Add 7-segment LED display driver
Thread-Index: AQHaa3mtvfhJncEIXkulWlzHVNRh9LEiWOCAgAOQswA=
Date: Mon, 4 Mar 2024 00:45:19 +0000
Message-ID: <bee159a7-b125-4773-b6b2-867e02f11345@alliedtelesis.co.nz>
References: <20240301014203.2033844-1-chris.packham@alliedtelesis.co.nz>
 <20240301014203.2033844-2-chris.packham@alliedtelesis.co.nz>
 <ZeIb_TaKK1DE6l6U@smile.fi.intel.com>
In-Reply-To: <ZeIb_TaKK1DE6l6U@smile.fi.intel.com>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <F171F89AF9C8B24A87A3205B7930AC93@atlnz.lc>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=BKkQr0QG c=1 sm=1 tr=0 ts=65e5199f a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=75chYTbOgJ0A:10 a=IkcTkHD0fZMA:10 a=K6JAEmCyrfEA:10 a=Mb4ELdBMygkE4JPZpvgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0

DQpPbiAyLzAzLzI0IDA3OjE4LCBBbmR5IFNoZXZjaGVua28gd3JvdGU6DQo+IEkgd291bGQgZHJv
cCB0aGlzIGFzIGl0J3MgYXZhaWxhYmxlIGluIFVBUEkgaGVhZGVyLi4uDQo+DQo+IC4uLg0KPg0K
Pj4gKyNpbmNsdWRlIDxsaW51eC9iaXRtYXAuaD4NCj4+ICsjaW5jbHVkZSA8bGludXgvY29udGFp
bmVyX29mLmg+DQo+PiArI2luY2x1ZGUgPGxpbnV4L2Vycm5vLmg+DQo+PiArI2luY2x1ZGUgPGxp
bnV4L2dwaW8vY29uc3VtZXIuaD4NCj4+ICsjaW5jbHVkZSA8bGludXgvbW9kX2RldmljZXRhYmxl
Lmg+DQo+PiArI2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPg0KPj4gKyNpbmNsdWRlIDxsaW51eC9w
bGF0Zm9ybV9kZXZpY2UuaD4NCj4+ICsjaW5jbHVkZSA8bGludXgvdHlwZXMuaD4NCj4+ICsjaW5j
bHVkZSA8bGludXgvd29ya3F1ZXVlLmg+DQo+IC4uLndoaWNoIHlvdSBmb3Jnb3QgdG8gaW5jbHVk
ZSBoZXJlLg0KPg0KPiAuLi4NCkFjdHVhbGx5IGRvIEkgbmVlZCB0bz8gSSdtIG5vdCB1c2luZyBh
bnl0aGluZyBpbiBtYXBfdG9fN3NlZ21lbnQuaCwgDQp0aGF0J3MgYWxsIHRha2VuIGNhcmUgb2Yg
aW4gdGhlIGxpbmUtZGlzcGxheSBjb2RlLg==

