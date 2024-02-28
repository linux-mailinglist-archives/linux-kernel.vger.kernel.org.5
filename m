Return-Path: <linux-kernel+bounces-84388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA45586A62B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 02:54:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 170B21C242A2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 01:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A253FD4;
	Wed, 28 Feb 2024 01:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="SiknfvdY"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6960114F6C
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 01:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709085193; cv=none; b=ptyBBAuR+VpuKJpgKZC+6zEuiIDQkrFw5/YNA8CJB4LRv0TEFfzDfbTih2hqR+KMS7PhtPqRcO5uBgYt4G8/kfdEOuVg5ChDbjrB/dSauFB5mum/GxW1RI3S7nfRL6syTzcbSDdoO1dzRERsTCfcgAaakEFGh1z2bzx4IfVBYn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709085193; c=relaxed/simple;
	bh=TcywyovHDqARhOOSIHaoQ+K8F6mR03bJrOqRVihdDSQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tF4VRlzM80bgwZJS8peKwtQQ4zCNmLjt8SJrdx3eRHVP2FnFgcKCOEj8g2LTiz9YyajXRjSTzTmFAA+LpegQwLcqnoWiHA484MmMzkcz/mfsDiDwPTu2bI0tzdnHl8O1CzzAvoy8TQIhnbdzQ0Vwcdjr1bBkUlDiOK5XM3J+Low=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=SiknfvdY; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 1A3552C0E9D;
	Wed, 28 Feb 2024 14:53:09 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1709085189;
	bh=TcywyovHDqARhOOSIHaoQ+K8F6mR03bJrOqRVihdDSQ=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=SiknfvdYu5kYONKlJ+jLUpMnTBqPewUTD+6A+vx7cTFrakz+9/VM1NIopOUQm8C/Z
	 0ihqxb6X8BoUQCCzPkyQk+NXuuhq7Zi62EPCahptinZbyR8WBM+IvoYyqUZkCFEUIG
	 tZbtLB+210ImOaemVo+KHwSlAstZYSvZRclU6TUore3Ul3W8DSozf3qDRi6iYzBfb/
	 dXX1EcY3rJQew9uB0hkCHEe99rPxy+F05aYyjwqCrwckhynwVVlYWXN0fkh9xSj5kP
	 cushJTpN1/lvo2NZimQJEmUH0ut7e3gMekqVqj0OGcEiTd/zc3KZ+zjJklr2IRXn8c
	 wj3ndcWnjtFAA==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B65de92040001>; Wed, 28 Feb 2024 14:53:08 +1300
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 28 Feb 2024 14:53:08 +1300
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1118.040; Wed, 28 Feb 2024 14:53:08 +1300
From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
CC: "andy@kernel.org" <andy@kernel.org>, "geert@linux-m68k.org"
	<geert@linux-m68k.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "andrew@lunn.ch"
	<andrew@lunn.ch>, "gregory.clement@bootlin.com"
	<gregory.clement@bootlin.com>, "sebastian.hesselbarth@gmail.com"
	<sebastian.hesselbarth@gmail.com>, "ojeda@kernel.org" <ojeda@kernel.org>,
	"tzimmermann@suse.de" <tzimmermann@suse.de>, "javierm@redhat.com"
	<javierm@redhat.com>, "robin@protonic.nl" <robin@protonic.nl>,
	"lee@kernel.org" <lee@kernel.org>, "pavel@ucw.cz" <pavel@ucw.cz>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 2/4] dt-bindings: auxdisplay: Add bindings for generic
 7 segment LED
Thread-Topic: [PATCH v2 2/4] dt-bindings: auxdisplay: Add bindings for generic
 7 segment LED
Thread-Index: AQHaacMcPIjrgF/Em0WhkdYBGa6MPrEeBc2AgAAefwA=
Date: Wed, 28 Feb 2024 01:53:08 +0000
Message-ID: <34b89a56-ab43-4d44-86f3-604e5be29db3@alliedtelesis.co.nz>
References: <20240227212244.262710-1-chris.packham@alliedtelesis.co.nz>
 <20240227212244.262710-3-chris.packham@alliedtelesis.co.nz>
 <CAHp75Vdi2c=s_z9wwxWzVcL+4tx5ZnXymbiN4O1FS+D3kz5vqw@mail.gmail.com>
In-Reply-To: <CAHp75Vdi2c=s_z9wwxWzVcL+4tx5ZnXymbiN4O1FS+D3kz5vqw@mail.gmail.com>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <3FCCFAB5F88E584FBA9C38B45B42185B@atlnz.lc>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=BKkQr0QG c=1 sm=1 tr=0 ts=65de9204 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=75chYTbOgJ0A:10 a=IkcTkHD0fZMA:10 a=k7vzHIieQBIA:10 a=PfnGLi71HrvahYDWBasA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0

T24gMjgvMDIvMjQgMTM6MDMsIEFuZHkgU2hldmNoZW5rbyB3cm90ZToNCj4gT24gVHVlLCBGZWIg
MjcsIDIwMjQgYXQgMTE6MjLigK9QTSBDaHJpcyBQYWNraGFtDQo+IDxjaHJpcy5wYWNraGFtQGFs
bGllZHRlbGVzaXMuY28ubno+IHdyb3RlOg0KPg0KPiAuLi4NCj4NCj4+ICsgIHNlZ21lbnQtZ3Bp
b3M6DQo+PiArICAgIGRlc2NyaXB0aW9uOg0KPj4gKyAgICAgIEFuIGFycmF5IG9mIEdQSU9zIG9u
ZSBwZXIgc2VnbWVudC4NCj4gVGhpcyBpcyBhIHZhZ3VlIGRlc2NyaXB0aW9uLiBQbGVhc2UgZXhw
bGFpbiB0aGUgb3JkZXIgKGUuZy4sIExTQiA9DQo+ICdhJywgTVNCID0gJ2cnKSwgdXNlIG9mIERQ
IChvcHRpb25hbD8pLCBldGMuDQo+DQo+PiArICAgIG1pbkl0ZW1zOiA3DQo+IG1heEl0ZW1zPw0K
Pg0KPiAuLi4NCg0KSSBwbGFuIG9uIHNheWluZyBtYXhJdGVtczogNyAobW9yZSBkaXNjdXNzaW9u
IGJlbG93KQ0KDQo+DQo+PiArICAgIGxlZC03c2VnIHsNCj4gUHJvYmFibHkgaXQgc2hvdWxkIGJl
IG1vcmUgaHVtYW4gcmVhZGFibGUuIERUIHBlb3BsZSBtaWdodCBzdWdnZXN0DQo+IHNvbWV0aGlu
ZyBiZXR0ZXIuDQo+DQo+PiArICAgICAgICBjb21wYXRpYmxlID0gImdlbmVyaWMtZ3Bpby03c2Vn
IjsNCj4+ICsgICAgICAgIHNlZ21lbnQtZ3Bpb3MgPSA8JmdwaW8gMCBHUElPX0FDVElWRV9MT1cN
Cj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgJmdwaW8gMSBHUElPX0FDVElWRV9MT1cNCj4+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgJmdwaW8gMiBHUElPX0FDVElWRV9MT1cNCj4+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgJmdwaW8gMyBHUElPX0FDVElWRV9MT1cNCj4+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgJmdwaW8gNCBHUElPX0FDVElWRV9MT1cNCj4+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgJmdwaW8gNSBHUElPX0FDVElWRV9MT1cNCj4+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgJmdwaW8gNiBHUElPX0FDVElWRV9MT1c+Ow0KPiBEdW5ubyBob3cgdG8g
aGFuZGxlIERQLiBFaXRoZXIgd2UgYWx3YXlzIGV4cGVjdCBpdCB0byBiZSBoZXJlIChhcw0KPiBw
bGFjZWhvbGRlcikgb3Igd2l0aCBhZGRpdGlvbmFsIHByb3BlcnR5Lg0KDQpNeSBjdXJyZW50IHBs
YW4gd2FzIHRvIGlnbm9yZSBpdC4gQXMgeW91IHNlZSBpdCBteSBsYXRlciBwYXRjaCBJJ20gDQoo
YWIpdXNpbmcgRFAgYXMgYSBkaXNjcmV0ZSBncGlvLWxlZCB3aXRoIGEgZGlmZmVyZW50IGZ1bmN0
aW9uLg0KDQpXZSBjb3VsZCBlaXRoZXIgYSBzZXBhcmF0ZSBkcC1ncGlvcyBwcm9wZXJ0eSBvciBz
ZXQgbWF4SXRlbXMgdG8gOC4gUmlnaHQgDQpub3cgdGhlIGRyaXZlciB3b24ndCBkbyBhbnl0aGlu
ZyB3aXRoIGVpdGhlciBvcHRpb24uVG8gYWN0dWFsbHkgZG8gDQpzb21ldGhpbmcgaW4gdGhlIGxp
bmVkaXNwIGRyaXZlciB3ZSdkIG5lZWQgdG8gaGF2ZSBhIG5ldyBjaGFyYWN0ZXIgbWFwIA0KdGhh
dCBpbmNsdWRlcyB0aGUgZXh0cmEgTEVELg0KDQo+PiArICAgIH07

