Return-Path: <linux-kernel+bounces-6545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 787B0819A2A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 09:11:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 285A91F23180
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 08:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47501D536;
	Wed, 20 Dec 2023 08:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b="hqtIw6KK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4201D528
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 08:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
	q=dns/txt; i=@phytec.de; t=1703058972; x=1705650972;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=6uuT1ejfRCFoiCRYbJ2OkaYUhy/VvQ76QdT7VhFOBjQ=;
	b=hqtIw6KKamLq+zdP0x2+fxgC2UQgoyXh5zFkk1sD5VTk/428Y9ABPmR2kCmK44f7
	O4JJHT0Qt8/qeJKOD/6kFsQh5Xct2AvEZrpr0lAqlktmLXsrsKLVISWPD2qZBWzz
	GF9BQWEEmSVfvQGOJ7eASOLdZsFTqLYg2uAWLsFQR5I=;
X-AuditID: ac14000a-fadff7000000290d-82-65829e1bf074
Received: from florix.phytec.de (Unknown_Domain [172.25.0.13])
	(using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 07.70.10509.B1E92856; Wed, 20 Dec 2023 08:56:11 +0100 (CET)
Received: from Berlix.phytec.de (172.25.0.12) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 20 Dec
 2023 08:56:11 +0100
Received: from Berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4]) by
 berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4%4]) with mapi id 15.01.2507.006;
 Wed, 20 Dec 2023 08:56:11 +0100
From: Yannic Moog <Y.Moog@phytec.de>
To: "lukas@wunner.de" <lukas@wunner.de>
CC: "upstream@lists.phytec.de" <upstream@lists.phytec.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "leoyang.li@nxp.com"
	<leoyang.li@nxp.com>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
	"linux-imx@nxp.com" <linux-imx@nxp.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>, Teresa Remmet <T.Remmet@phytec.de>
Subject: Re: [PATCH v2 2/2] arm64: dts: freescale: add phyGATE-Tauri i.MX 8M
 Mini Support
Thread-Topic: [PATCH v2 2/2] arm64: dts: freescale: add phyGATE-Tauri i.MX 8M
 Mini Support
Thread-Index: AQHaMxkSda9BK8mQGUeWhpcfSvCZ4LCxvQiA
Date: Wed, 20 Dec 2023 07:56:11 +0000
Message-ID: <ab45c82485fa272f74adf560cbb58ee60cc42689.camel@phytec.de>
References: <20230925-tauri_upstream_support-v2-0-62a6dfc48e31@phytec.de>
	 <20230925-tauri_upstream_support-v2-2-62a6dfc48e31@phytec.de>
	 <20231220074931.GA13382@wunner.de>
In-Reply-To: <20231220074931.GA13382@wunner.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <B4003917F20D11438A472951449BC850@phytec.de>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKIsWRmVeSWpSXmKPExsWyRpKBV1d6XlOqwaybNhZr9p5jsph/5Byr
	xcOr/harpu5kseh78ZDZ4lDzASaLTY+vsVp0/VrJbHF51xw2ixfPpS1a9x5ht/i7fROLxYst
	4hbd79Qd+Dx2zrrL7rFpVSebx51re9g8Ni+p9+jvbmH12PhuB5NH/18Dj8+b5DxmtG9jDeCM
	4rJJSc3JLEst0rdL4Mq4cnQiY8ECjooTd1YwNTC2cHQxcnJICJhIXP14jxHEFhJYzCTx7HNJ
	FyMXkH2fUeLV+0Y2CGcDo8SeltssIFVsAioSJ2dcAusQEVCXmHX5NStIEbPAa1aJhWvPs4Mk
	hAWiJS41twIlOICKYiQO7bWFqDeSaNm1lwnEZhFQlZja1whWzivgJjFp83NmuGXLG7eBFXEK
	6Eucvv2dFcRmFJCV2LDhPDOIzSwgLrHpGURcQkBAYskeiLiEgKjEy8f/oOLyEiduTWMCuYFZ
	QFNi/S59CNNCYtF3N4gpihJTuh9CnSAocXLmE5YJjOKzkCyYhdA8C6F5FpLmWUiaFzCyrmIU
	ys1Mzk4tyszWK8ioLElN1ktJ3cQISgoiDFw7GPvmeBxiZOJgPMQowcGsJMK7t7MpVYg3JbGy
	KrUoP76oNCe1+BCjNAeLkjjv6o7gVCGB9MSS1OzU1ILUIpgsEwenVANjd5lqgYaTyQZ3j/MV
	/97XJH10ZdtcOOmtdpWSWq/V/YZG2YkZj+03Hkq00Z3Uq9v8ln3CUubzBcu++u36/Gutx5lL
	LHObn3DcMoi3a9ustLysaP/ChgVlz588E4yLNf1ykGFDP1v8h5s/pDt6mM8fdNW+OWvWX9a1
	uvd6nUQOzmv9lpaSpVajxFKckWioxVxUnAgATS0FfPgCAAA=

SGVsbG8gTHVrYXMsDQoNCk9uIFdlZCwgMjAyMy0xMi0yMCBhdCAwODo0OSArMDEwMCwgTHVrYXMg
V3VubmVyIHdyb3RlOg0KPiBPbiBNb24sIFNlcCAyNSwgMjAyMyBhdCAwOToyNToxOUFNICswMjAw
LCBZYW5uaWMgTW9vZyB3cm90ZToNCj4gPiBwaHlHQVRFLVRhdXJpIHVzZXMgYSBwaHlDT1JFLWku
TVg4TU0gU29NLiBBZGQgZGV2aWNlIHRyZWUgZm9yIHRoZSBib2FyZC4NCj4gWy4uLl0NCj4gPiAr
CXRwbTogdHBtQDEgew0KPiA+ICsJCWNvbXBhdGlibGUgPSAidGNnLHRwbV90aXMtc3BpIjsNCj4g
DQo+IFdoYXQncyB0aGUgY2hpcCB1c2VkIG9uIHRoaXMgYm9hcmQ/wqAgR29pbmcgZm9yd2FyZCwg
dGhlIERUIHNjaGVtYSBmb3IgVFBNcw0KPiByZXF1aXJlcyB0aGUgZXhhY3QgY2hpcCBuYW1lIGlu
IGFkZGl0aW9uIHRvIHRoZSBnZW5lcmljICJ0Y2csdHBtX3Rpcy1zcGkiLg0KDQpUUE0gU0xCIDk2
NzAgaXMgdXNlZCBvbiB0aGUgYm9hcmQuIFRoYW5rIHlvdSBmb3IgaGlnaGxpZ2h0aW5nIHRoaXMu
DQoNCllhbm5pYw0KDQo+IA0KPiANCj4gPiArCQlpbnRlcnJ1cHRzID0gPDExIElSUV9UWVBFX0xF
VkVMX0xPVz47DQo+ID4gKwkJaW50ZXJydXB0LXBhcmVudCA9IDwmZ3BpbzI+Ow0KPiA+ICsJCXBp
bmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7DQo+ID4gKwkJcGluY3RybC0wID0gPCZwaW5jdHJsX3Rw
bT47DQo+ID4gKwkJcmVnID0gPDE+Ow0KPiA+ICsJCXNwaS1tYXgtZnJlcXVlbmN5ID0gPDM4MDAw
MDAwPjsNCj4gPiArCX07DQo+ID4gK307DQoNCg==

