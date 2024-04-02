Return-Path: <linux-kernel+bounces-128651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF99895D83
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 22:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7066D1F22F3C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 20:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD6615D5C9;
	Tue,  2 Apr 2024 20:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="utKT8FIb"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11AED14AD2A
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 20:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712089483; cv=none; b=EpBRC+XfXvyOTfQ1BeAj0Ca7pooDd7qB5wWgCYqCZc87nko45ZslQQj9oTICR9h3O3Ft2NbvMBVnw/Kq1vSbPklpfRVl91cXHJ8dlkReyO8K/a4tqRZvbbGTVN3NiQQVzbk65LrRiyLgmUWrBzYnoDVw/gyQqRRUEEUgZ6zmjjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712089483; c=relaxed/simple;
	bh=R205FE43OH6rrOt4iwtgF3+kwicEz8ULkm/QpFGb2aY=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=cWxqw8qe6GuNP132fpnzXyft9xV3px4MHGulP5XZaTOIwbwU0jm1KV8+7mJv2+qduHxRiHZKtWxySUbBsIwLQd3YGyhBFt8sA5zO8HKzR9wcUyXBx9UWKlHJY9g1sCPAOEcT00aMZ2l5m9Bmz4c7BHn1E0bJzYsJpx62Y+HSsA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=utKT8FIb; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id B4D4E2C03B0;
	Wed,  3 Apr 2024 09:24:38 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1712089478;
	bh=R205FE43OH6rrOt4iwtgF3+kwicEz8ULkm/QpFGb2aY=;
	h=From:To:CC:Subject:Date:From;
	b=utKT8FIbmRzBwl1qsJ3QrpZ2uCOfTX/LTNj1gjg8R9+4+dHEfPnPf04oYC26rYOqI
	 +g5KPPL2lEQLJDpq/NDahcDR8MCe07YQDcroAmcy5P3xBiPpNKaPV0x0Rkj6d+Dnae
	 DIpzKt7mZhGR8EnY+S/T7lcvudYbwmAM9+8QhvqIlwAiM1rT/Z7u49xzogtjx0NQg6
	 8/RTI0p5o5toL2eFSmqDQbPbW3/IYkG48/AGOm8u4DI6OwayzvJOzbBNZT0zcTUsbs
	 sCnG/nT5boCGMoGDn7BQXTVjiMDdv/XfjwxewKS/LP+KkQOvv9vC0MDSSXmlxslLIZ
	 oPJxRN5t8UUWg==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B660c69860001>; Wed, 03 Apr 2024 09:24:38 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1544.9; Wed, 3 Apr 2024 09:24:38 +1300
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1497.48; Wed, 3 Apr 2024 09:24:38 +1300
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1544.009; Wed, 3 Apr 2024 09:24:38 +1300
From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To: Guenter Roeck <linux@roeck-us.net>, "jdelvare@suse.com"
	<jdelvare@suse.com>
CC: "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: hwmon: label vs temp%d_label
Thread-Topic: hwmon: label vs temp%d_label
Thread-Index: AQHahTvINn4/LiD+qEqZV7u6Rj72tg==
Date: Tue, 2 Apr 2024 20:24:37 +0000
Message-ID: <9a09bf46-d097-4e5b-bdb3-cc9dc6f5d01c@alliedtelesis.co.nz>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <55A81BE23C67E9428E7C391E9D84968D@atlnz.lc>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=KIH5D0Fo c=1 sm=1 tr=0 ts=660c6986 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=X1bIBW7fO_EA:10 a=75chYTbOgJ0A:10 a=IkcTkHD0fZMA:10 a=raytVjVEu-sA:10 a=HnSBbm6KEwkWcQZ2umYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0

SGkgR3VlbnRlciwgSmVhbiwNCg0KSSd2ZSBnb3QgYSByZXF1aXJlbWVudCB0byBhZGQgc29tZSBt
ZWFuaW5nZnVsIG5hbWVzIHRvIHNvbWUgaHdtb24gDQpzZW5zb3JzIChMTTc1IHNwZWNpZmljYWxs
eSkgc28gdGhhdCB3ZSBjYW4gcHJvdmlkZSBzb21lIGluZGljYXRpb24gb2YgDQp3aGVyZSBvbiBh
IGJvYXJkIHRoZSBzZW5zb3IgaXMgbG9jYXRlZCAoZS5nLiAiSW50YWtlIiB2cyAiRXhoYXVzdCIg
dnMgDQoiTmVhciB0aGF0IHJlYWxseSBob3QgY2hpcCIpLg0KDQpJIHNlZSB0aGF0IHRoZSBzeXNm
cyBBQkkgZG9jdW1lbnRzIGJvdGggImxhYmVsIiBmb3IgdGhlIGNoaXAgYW5kIA0KInRlbXBbMS0q
XV9sYWJlbCIgKGFzIHdlbGwgYXMgc2ltaWxhciBmYW4gYW5kIFZpbiBhdHRyaWJ1dGVzKS4gVGhl
IA0KbGF0dGVyIHNlZW0gdG8gYmUgc3VwcG9ydGVkIGJ5IHRoZSBod21vbiBjb3JlIGJ1dCBJIGRv
bid0IHNlZSBhbnl0aGluZyANCmZvciB0aGUgZm9ybWVyIChJJ20gc3RydWdnbGluZyB0byBmaW5k
IGFueSBkcml2ZXIgdGhhdCBzdXBwb3J0cyBhIA0KY2hpcC13aWRlIGxhYmVsKS4NCg0KQXNzdW1p
bmcgSSB3YW50IHRvIGhhdmUgYSBsYWJlbCBhZGRlZCBpbiB0aGUgZGV2aWNlIHRyZWUgdG8gYSBs
bTc1IHdvdWxkIA0Kc29tZXRoaW5nIGxpa2UgdGhlIGZvbGxvd2luZyBiZSBhY2NlcHRhYmxlDQoN
CiDCoMKgwqDCoMKgIHNlbnNvckA0OCB7DQogwqDCoMKgwqDCoMKgwqAgY29tcGF0aWJsZSA9ICJu
YXRpb25hbCxsbTc1IjsNCiDCoMKgwqDCoMKgwqDCoCByZWcgPSA8MHg0OD47DQogwqDCoMKgwqDC
oMKgwqAgbGFiZWwgPSAiSW50YWtlIjsNCiDCoMKgwqDCoMKgIH07DQoNCkknZCB0aGVuIHVwZGF0
ZSB0aGUgbG03NSBkcml2ZXIgdG8gZ3JhYiB0aGF0IGZyb20gdGhlIGRldmljZXRyZWUgYW5kIHVz
ZSANCml0IHRvIHByb3ZpZGUgdGhlIGh3bW9uX3RlbXBfbGFiZWwgYXR0cmlidXRlLg0KDQpUaGFu
a3MsDQpDaHJpcw0K

