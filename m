Return-Path: <linux-kernel+bounces-64865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2778854402
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 09:27:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54E771F279CB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 08:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6860C125B8;
	Wed, 14 Feb 2024 08:27:17 +0000 (UTC)
Received: from mail.actia.se (mail.actia.se [212.181.117.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8DF125A1;
	Wed, 14 Feb 2024 08:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.181.117.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707899237; cv=none; b=kfSGj7Y8WyiTFzCq4WqFRkF2CV3pTihvTNx0576U8B3rvs6zCU8YHokJr0n6W/R/k3dpKJfNW8IeOXIFsWTbG9dnVqCMl6KWTmh+nCvHbcGb2+kJhhBnPJ07m0UB1zpU0JbDKlpA5mXiN/5VRX7N3yBKmZduW5wRJarTv2gZgSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707899237; c=relaxed/simple;
	bh=9kL4bDsmym6/TBmi56MMnW3qQjBB3ZGR34Ritq59ir0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HfPkKFiKp4l2ovpw1kbc9vHuKYx0BVFN0HSXZxObLsSegeQJkBjvZwXLMERkDFl+/bt7TWqBUqDFm0WiD6YhCzzs74nKFDaMHosbZ049/BCOA89iQMeQ/xLtNgBtAboMKgKWLznErfp75SBQaKpUBGZ4BjY7pfxo8Pf9wv15n38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=actia.se; spf=pass smtp.mailfrom=actia.se; arc=none smtp.client-ip=212.181.117.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=actia.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=actia.se
Received: from S036ANL.actianordic.se (10.12.31.117) by S036ANL.actianordic.se
 (10.12.31.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 14 Feb
 2024 09:27:02 +0100
Received: from S036ANL.actianordic.se ([fe80::e13e:1feb:4ea6:ec69]) by
 S036ANL.actianordic.se ([fe80::e13e:1feb:4ea6:ec69%4]) with mapi id
 15.01.2507.035; Wed, 14 Feb 2024 09:27:02 +0100
From: John Ernberg <john.ernberg@actia.se>
To: Jakub Kicinski <kuba@kernel.org>
CC: Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, "Clark
 Wang" <xiaoning.wang@nxp.com>, NXP Linux Team <linux-imx@nxp.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Paolo
 Abeni" <pabeni@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: fec: Always call fec_restart() in resume
 path
Thread-Topic: [PATCH net-next] net: fec: Always call fec_restart() in resume
 path
Thread-Index: AQHaXaFLRIYd45z3UU+7Sl3MRdVj/bEJE22AgABftoA=
Date: Wed, 14 Feb 2024 08:27:02 +0000
Message-ID: <5aba2c2b-b712-4827-acb2-d586508a3bd6@actia.se>
References: <20240212105010.2258421-1-john.ernberg@actia.se>
 <20240213184427.5af2d7eb@kernel.org>
In-Reply-To: <20240213184427.5af2d7eb@kernel.org>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-esetresult: clean, is OK
x-esetid: 37303A2958D72955607460
Content-Type: text/plain; charset="utf-8"
Content-ID: <B96B0B6D7EE85944BD3DB2A46059C201@actia.se>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gMi8xNC8yNCAwMzo0NCwgSmFrdWIgS2ljaW5za2kgd3JvdGU6DQo+IE9uIE1vbiwgMTIgRmVi
IDIwMjQgMTA6NTA6MzAgKzAwMDAgSm9obiBFcm5iZXJnIHdyb3RlOg0KPj4gVGVzdGVkIG9uIDYu
MSBrZXJuZWwgYW5kIGZvcndhcmQgcG9ydGVkLiBJIGRpc2NvdmVyZWQgdGhpcyB3aGVuIHdlDQo+
PiB1cGdyYWRlZCBmcm9tIDUuMTAgdG8gNi4xLCBidXQgdGhlIHJlc3VtZSBwYXRoIGluIHRoZSBG
RUMgZHJpdmVyIGhhcyBoYWQNCj4+IHRoaXMgaW1iYWxhbmNlIHNpbmNlIGF0IGxlYXN0IDIwMDku
DQo+Pg0KPj4gVGhpcyBpcyBhbHNvIHdoeSBJIHRhcmdldCB0aGUgLW5leHQgdHJlZSwgSSBjYW4n
dCBpZGVudGlmeSBhIHByb3BlciBjb21taXQNCj4+IHRvIGJsYW1lIHdpdGggYSBGaXhlcy4gTGV0
IG1lIGtub3cgaWYgdGhpcyBzaG91bGQgYmUgdGhlIG5ldCB0cmVlIGFueXdheS4NCj4gDQo+IEkg
dGhvdWdodCB5b3UgYmlzZWN0ZWQgaXQgdG8gb25lIG9yIHR3byBzcGVjaWZpYyBjaGFuZ2VzPw0K
PiBJJ2QgcHV0IHRob3NlIGRvd24gYXMgRml4ZXMgdGFncyBhbmQgdGFyZ2V0IG5ldC4NCg0KSGkg
SmFrdWIsDQoNCllvdSBhcmUgY29ycmVjdCwgd2UgdGhvdWdodCBzbyB0b28gYXQgWzFdLCBidXQg
YmlzZWN0aW9uIGlzIHJlYWxseSBoYXJkIA0KYmVjYXVzZSB3ZSBuZWVkIGEgd2hvbGUgYnVuY2gg
b2YgcGF0Y2hlcyBvbiB0b3AgdG8gZXZlbiBib290IHRoZSBzeXN0ZW0gDQooaW14OHF4cCBzcGVj
aWZpYyBzdHVmZiBpbiB0aGUgTlhQIHZlbmRvciB0cmVlIHRoYXQncyBkaWZmaWN1bHQgdG8gDQpy
ZWJhc2UpLCB3ZSBsZWZ0IGl0IGEgYml0IG9wZW4gZW5kZWQuDQoNCk92ZXIgdGhlIGNvdXJzZSBv
ZiB0aGUgd2Vla2VuZCBJIGxvc3QgYWxsIGNvbmZpZGVuY2UgaW4gbXkgYmlzZWN0aW9uIA0KYWZ0
ZXIgYmVpbmcgY29uZmlkZW50IGZvciA0LTUgZGF5cywgYmVjYXVzZSB0aGUgbW9yZSBJIHRob3Vn
aHQgYWJvdXQgaXQgDQp0aGUgbGVzcyBpdCBtYWRlIHNlbnNlIGZvciB0aGF0IGNvbW1pdCB0byBi
ZSB0aGUgY3VscHJpdC4NCg0KSSBzaG91bGQgcHJvYmFibHkgaGF2ZSBib3RoIGZvbGxvd2VkIHVw
IG9uIHRoYXQgbWFpbCB3aXRoIHRoYXQsIGFuZCBiZWVuIA0KY2xlYXJlciBoZXJlLiBJIGFwb2xv
Z2l6ZSBmb3IgZmFpbGluZyB0aGF0Lg0KDQpCZXN0IHJlZ2FyZHMgLy8gSm9obiBFcm5iZXJnDQoN
ClsxXTogDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9uZXRkZXYvMWY0NWJkYmUtZWFiMS00ZTU5
LThmMjQtYWRkMTc3NTkwZDI3QGFjdGlhLnNlLw==

