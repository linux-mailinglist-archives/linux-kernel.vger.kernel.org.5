Return-Path: <linux-kernel+bounces-89890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B70C86F6F1
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 20:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F0AD281A4F
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 19:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD8679DB7;
	Sun,  3 Mar 2024 19:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="TxVP0ht0"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4678167A19
	for <linux-kernel@vger.kernel.org>; Sun,  3 Mar 2024 19:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709495897; cv=none; b=eJSe0pzGhAaH14dbD6S48wVJJ2gm2xFQt4f/ONiP7JDP6tAytfhLaAw+XeH/XzyMuCi24KQaRj7VawZYpFo2bU5AVnfPEL3EFQh2YKD4nSEqjJi95s0bR2iVWatD5WzefCaGfg7SSaq199cUuoHkMcO6PISu8yOevyTTCr1rM2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709495897; c=relaxed/simple;
	bh=YMjGJq4umtyd/ClNiZa0elGCMycPIwJQx4Epcs2kpG8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=It5VemH2DGwG7vo/NvWzZIRlNu+drNyewbg7EeBIJ3e3mDdATMj16YPvWgftID4NX0egsaKWf4+bM9eStdEoLCupy437xyPDS9bOeueQ33IMDg2doaIjk9qAK2JxOjez+Mr8BHWAMrCxRCGutxHgVwQYt9aEhAjiKxxuyhkMqn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=TxVP0ht0; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 600AB2C05EA;
	Mon,  4 Mar 2024 08:58:07 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1709495887;
	bh=YMjGJq4umtyd/ClNiZa0elGCMycPIwJQx4Epcs2kpG8=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=TxVP0ht0zTq714jFvRsf2+3s8wz6BZjd/L1eUYztGSU7sdy8uMIdw2nS4U4FERJUL
	 GyUkkW9mjgwhTpaCZx5FzIXEyEEn3bRMnW/VFtzaZJSL6oCOA9qFYVxEJVu3aoutkQ
	 sT84aToNkip9w1slWzHAX9/K5OS3rvfQMpTEeSeN9YHHgcG77wOTz/vLxFroHRUd6z
	 wfF6TdgVVthiZCEwxRJ0yJziF9mnsNCLhFiUA9WbpVIqj4BcASZXF762zMrkizAqnK
	 CyhKdFM4tfxm0aL1iSXrYSwhNZS4sfkt2hfkPFfuSIbungxxQ2ENLn1Zj+gZPB25xX
	 XfzHV+MziUyZQ==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B65e4d64f0001>; Mon, 04 Mar 2024 08:58:07 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1118.40; Mon, 4 Mar 2024 08:58:07 +1300
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with Microsoft
 SMTP Server (TLS) id 15.0.1497.48; Mon, 4 Mar 2024 08:58:06 +1300
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1118.040; Mon, 4 Mar 2024 08:58:06 +1300
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
Thread-Index: AQHaa3mtvfhJncEIXkulWlzHVNRh9LEiWOCAgANAdQA=
Date: Sun, 3 Mar 2024 19:58:06 +0000
Message-ID: <f17adc70-be85-4be2-bbe2-336866907d68@alliedtelesis.co.nz>
References: <20240301014203.2033844-1-chris.packham@alliedtelesis.co.nz>
 <20240301014203.2033844-2-chris.packham@alliedtelesis.co.nz>
 <ZeIb_TaKK1DE6l6U@smile.fi.intel.com>
In-Reply-To: <ZeIb_TaKK1DE6l6U@smile.fi.intel.com>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <EB777336AFC8B84A8882CF208885582F@atlnz.lc>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=BKkQr0QG c=1 sm=1 tr=0 ts=65e4d64f a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=75chYTbOgJ0A:10 a=IkcTkHD0fZMA:10 a=K6JAEmCyrfEA:10 a=62ntRvTiAAAA:8 a=1LykzZ4aAAAA:8 a=_24Lg-2B7_NxD4znq2UA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=pToNdpNmrtiFLRE6bQ9Z:22 a=bH51_Tnmb_xWNYlIng18:22
X-SEG-SpamProfiler-Score: 0

DQpPbiAyLzAzLzI0IDA3OjE4LCBBbmR5IFNoZXZjaGVua28gd3JvdGU6DQo+PiArc3RhdGljIHZv
aWQgc2VnX2xlZF91cGRhdGUoc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQ0KPj4gK3sNCj4+ICsJ
c3RydWN0IHNlZ19sZWRfcHJpdiAqcHJpdiA9IGNvbnRhaW5lcl9vZih3b3JrLCBzdHJ1Y3Qgc2Vn
X2xlZF9wcml2LGh0dHA6Ly9zY2FubWFpbC50cnVzdHdhdmUuY29tLz9jPTIwOTg4JmQ9aVp6aTVi
M1MtVFFDZnQ5aUVYREU2OVU5VXRZMC03R0FOazl0MVdrQ3hnJnU9aHR0cCUzYSUyZiUyZndvcmsl
MmV3b3JrJTI5JTNiDQo+PiArCXN0cnVjdCBsaW5lZGlzcCAqbGluZWRpc3AgPSAmcHJpdi0+bGlu
ZWRpc3A7DQo+PiArCXN0cnVjdCBsaW5lZGlzcF9tYXAgKm1hcCA9IGxpbmVkaXNwLT5tYXA7DQo+
PiArCURFQ0xBUkVfQklUTUFQKHZhbHVlcywgOCk7DQo+PiArCWJpdG1hcF96ZXJvKHZhbHVlcywg
OCk7DQo+IFdoeSBkbyB5b3UgbmVlZCB0aGlzIHplcm9pbmc/DQo+DQo+PiArCWJpdG1hcF9zZXRf
dmFsdWU4KHZhbHVlcywgbWFwX3RvX3NlZzcoJm1hcC0+bWFwLnNlZzcsIGxpbmVkaXNwLT5idWZb
MF0pLCAwKTsNCj4+ICsNCldpdGhvdXQgdGhlIHplcm9pbmcgYWJvdmUgR0NDIGNvbXBsYWlucyBh
Ym91dCB1c2XCoCBvZiBhIHBvdGVudGlhbGx5IA0KdW5pbml0aWFsaXplZCB2YXJpYWJsZSBoZXJl
LiBJIHRoaW5rIGJlY2F1c2UgYml0bWFwX3NldF92YWx1ZTgoKSBkb2VzICY9IA0KYW5kIHw9Lg0K
Pj4gKwlncGlvZF9zZXRfYXJyYXlfdmFsdWVfY2Fuc2xlZXAocHJpdi0+c2VnbWVudF9ncGlvcy0+
bmRlc2NzLCBwcml2LT5zZWdtZW50X2dwaW9zLT5kZXNjLA0KPj4gKwkJCQkgICAgICAgcHJpdi0+
c2VnbWVudF9ncGlvcy0+aW5mbywgdmFsdWVzKTsNCj4+ICt9

