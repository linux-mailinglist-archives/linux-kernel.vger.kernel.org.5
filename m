Return-Path: <linux-kernel+bounces-150342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D03168A9DA7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44B431F2324E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5977B168B1B;
	Thu, 18 Apr 2024 14:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZdRnTmnO"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2059.outbound.protection.outlook.com [40.107.22.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993A715E5C2;
	Thu, 18 Apr 2024 14:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713452035; cv=fail; b=UczWxaWVLwa5ALSDKROAJUkLmfbbQeudoXnmNjR9ebReu4ntbTTcAOsSdLl2/sLna7uFISBQ3G6B2ql7oWr1Q1GzNqVRVZJbfDwzK+kgrQgPb4TM+JYGNbJKKIFUA6TOXnzVIlF6tX3JmUTcCnbrQF+q4+j1TK11cq/ok54PAQ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713452035; c=relaxed/simple;
	bh=uSVsl+sL6NEcnkoBPV8Nl+2/RFqNRqKZJlPijrZLR4w=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cUnLOhG7UcnqgO/XAhKU+o8IbeRkX6gmECjp79PNhZF/9Y7yfQhh0KQgLr0DuUsDP+zytbJaDeG7RfihwLG38vIouGqKY+Igo9eB/xNEMkjY6fRwgjANQ91FmZylDDPa5mGBrb6vHHmB0VgJLTQNTmVFlfofNQSLchVZDp+62Xw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZdRnTmnO; arc=fail smtp.client-ip=40.107.22.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gHEcp67tuOtY/I3lssRiE5/OhznpcRyZP/s/Upw9h5SbigJ7XdYl/ejZ2yUGifX+GKC7zVqoYk3KoNayokW2HbQbNAEA9r3onBgT1QR5GHT/F2LpGX62PpGwAtEa8nw4UEB5WuL/FewEUPs+vJNIv2h9ZsdfXC1N5A4XHDKg2nVzza7QXH59DxxBZbhxfGDL4+s9bbL/HwdlHH+nqgqeIv0F3WDJV9nioMNWIDKN4cHE2cencu29GVcvDby+LKiN3gDW0YENbtrWnv59tT1lMGbiXSMNfJRqkYqXMvvl5xILXicWeOKTMbrraRhXIwPPz6gdh41OvUIIqXvyNcmyew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uSVsl+sL6NEcnkoBPV8Nl+2/RFqNRqKZJlPijrZLR4w=;
 b=kyxMD5uD9njcCCtUR//r7epu4b0g8JTUEF79WaLSzKaXtUAvvWxOW2zbeCuS+68uIiF7lD+lX4W5+uq7gyZec1zPnx0X6nh+xBuVnXsuTk9ehjI0bnQDg6DpYJJKWqW3/DBcGtEivqs4XMuUqntccVuF8ML9AOBMyufffhYEhHTACaojnu6FZg4uVL2Authh5lQK45DhcQ9J2vlUaf+bW7pY9oRZjJIEXWKI543W7cDvREz0U9pgtfAM9VtndhNLQcdu01gWcKpc5HYBg+WLwTPChNVXBUqbd4WuWyd1c+eTCJ4GryPcd9eNwtlVJJuln/9zyBaOdbfkeNO18ZUsOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uSVsl+sL6NEcnkoBPV8Nl+2/RFqNRqKZJlPijrZLR4w=;
 b=ZdRnTmnO/hLQiUAeA9psqCEan3VS9iuFUTfOVpU5fMrI9E21cM3jMzwwT7ZH4MnBQo72839KDTplj3yq/b0Q425YHIeGZFaqF547EKf4Vj3MBcjC2RPrx3dgJGk410V9QSJ/e3I7Jomzlc2bud6kl4CBJSRfjeTHb9tdD4Twqzc=
Received: from PA4PR04MB9709.eurprd04.prod.outlook.com (2603:10a6:102:26b::10)
 by DB9PR04MB9843.eurprd04.prod.outlook.com (2603:10a6:10:4c1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.39; Thu, 18 Apr
 2024 14:53:48 +0000
Received: from PA4PR04MB9709.eurprd04.prod.outlook.com
 ([fe80::ead1:809:aa83:c1e2]) by PA4PR04MB9709.eurprd04.prod.outlook.com
 ([fe80::ead1:809:aa83:c1e2%7]) with mapi id 15.20.7472.037; Thu, 18 Apr 2024
 14:53:48 +0000
From: Horia Geanta <horia.geanta@nxp.com>
To: Pankaj Gupta <pankaj.gupta@nxp.com>, Gaurav Jain <gaurav.jain@nxp.com>,
	Varun Sethi <V.Sethi@nxp.com>, "herbert@gondor.apana.org.au"
	<herbert@gondor.apana.org.au>, "davem@davemloft.net" <davem@davemloft.net>,
	Iuliana Prodan <iuliana.prodan@nxp.com>, "linux-crypto@vger.kernel.org"
	<linux-crypto@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH v3 2/2] drivers: crypto: caam: i.MX8ULP donot have CAAM
 page0 access
Thread-Topic: [PATCH v3 2/2] drivers: crypto: caam: i.MX8ULP donot have CAAM
 page0 access
Thread-Index: AQHaj7/lryOr574TskeWgxDoaaECkrFuIO6A
Date: Thu, 18 Apr 2024 14:53:47 +0000
Message-ID: <04756304-fc7c-4be1-b97a-dad12983994f@nxp.com>
References: <20240416053303.421259-1-pankaj.gupta@nxp.com>
 <20240416053303.421259-3-pankaj.gupta@nxp.com>
In-Reply-To: <20240416053303.421259-3-pankaj.gupta@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9709:EE_|DB9PR04MB9843:EE_
x-ms-office365-filtering-correlation-id: 9f7e9420-5911-4686-94d9-08dc5fb75a68
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 A4OUkrgMMH2y2by9GCQRlEgvFEusPAQ4huXDMz2GvYktdgj2i6vKHTMd/fRE5iPbZpKUIqWDg5Pf9eugF6OEENfCI+lLF9aOBOJNN5y5TZtV2/w73Qakys5U+Kkq3blMjPNCKaLoPdHRaege2Io5I+/sfOka6pRHBNOE7AiM3eQvvWd0ODXboDNI0t/DUdFod/lDjE4Xeioos/yvINXdQmsvfB3bV7XTOJ3LKTq+4sR9KBGRb03Oo3T9UbEksmPLLOl/JFU5QLRoaOAuX5+Toec9E7evJtPJrNeIh/ILQqHjoHxgniKJewswZ/T/609DJlfswsYDvxMmWIi/0jhSQrFVeGGmRGx8LR90fsB1B4cunw/zjgPQWSqn+bBiw1uWVS6fNZs01WaA/Fc9Jg28pjq6KoLLhgaujGc/DYTRzdag5BHB3/E+3KkS++Mvc5If+puw7AO74LOeKDsDsq9Ji56LHpkrkY3Pp/S+MoeFHALiPcvkKaqnaAS5rBXFANSC+bpsNVOMRqBtCNw0JigUnXKTjV9nCllQ44wBr1rCza8ThGURQwn1kDztbKzCZr+OKeDVzg25RXsvFadEBmcJak5sDoF9Xkyxyfy3w/1vAg218sjKINpkEZa43t2VNOAd0E40IhA6gdpzJYJBJqcsHo9hN/18qIm8U7asAqnkhacHvG248GTzFQNypGFlF3V1PA6WzoNvewxl2WZtMH6WmQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9709.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MnVmNlhSeFYySHBVK20xdVFVY1VSSS8vSU1oODYycFZ0OFZIMmxiUXpQRjBE?=
 =?utf-8?B?ZnRvNjZqdnlCYnYrRlR2eUg3NnE4em1TNEFVNzM3Uy8rMHd2dlpySVFyVEFy?=
 =?utf-8?B?R20venJpYmkrRlhIblVjTzQ2dEN2eXNOR1I5UXpLQU1TUElRWkJ5L2tESEV1?=
 =?utf-8?B?VnMxdytNeFdxeTcwNXVOY2t5R0FhTndDdU9MQ3RPNWUrUFVHSU82aTRWWGEv?=
 =?utf-8?B?S2dpMm0wSU9oTktGT2t1dmQ2NG9VT1NXZUhxak51bVFBSlJtWElDQUZLNGhO?=
 =?utf-8?B?T1JGUzU0cmFKU0t1WmNxN3pwdUg3elpFNGlDUWFmeUdWZW1Bc0RnVGpMV3Ur?=
 =?utf-8?B?Q2NPNm1MQlZ2V0t2RW5INmpvQXRONTBHNTlmWDRXaXluSnZTZ09FeUxqUjEz?=
 =?utf-8?B?UitDcjVXL3B2QTFWODdwYWRvUXE4eEZ0em9BR09STGZpRGRMaXZSWmNXbnVC?=
 =?utf-8?B?cWpMdEJtYWkzUVdLRHNtQW9GT3NBVW5FRm1ZLzIzL3QrcXV0Sm1HOVFkRWMz?=
 =?utf-8?B?ZldzYzVIS08yRklwSUN1NnpHSE5Wa0hiWXRBT21zYzVad09LMFByVG9rTGVx?=
 =?utf-8?B?dWFoSE5UOUtqam5FemVlTFNqdDBvVG5TcFlsTlBCVWdqTlFMYTFmRmoxYkxa?=
 =?utf-8?B?SFZnTmF4T3FyTHVNUFpudzNIb0k5L2pHaFFaenBQeFNFamZ4Um9WaWZxZzBp?=
 =?utf-8?B?MkFjZ3NrVTI0WlZXbnpyT0pqQXJ0MEZETWJrU3RlYi9wS0lIYjhLenhGaU04?=
 =?utf-8?B?ZGVMZnJKY2FjM3d3dVl2WDdlcGJ4eUlBQ05GcVB4STZmMDJSSEtVNXdraGRv?=
 =?utf-8?B?ZjFKZFdSM095N2dWREg0bnd2N1NqaW13bVFDVnQ5WndoVDBkYzFOZjlXdHls?=
 =?utf-8?B?VytaSEhNVlRHcDRIK1YzN1lzOGdHblVpd1djbzN1bWJFMHBxWUpKaWo1QWxP?=
 =?utf-8?B?cXQrSjZLVkQ5bE4vdytXKzB2YjZhMWhPUHRhQUdSWmtmUDUzVENhKzM5R0pM?=
 =?utf-8?B?cUtGdTMrUm5oRFFTQ0hxbGNWS205RWRFcGN4Z2VLaTBDeGQ2SE9acURZaHBh?=
 =?utf-8?B?alBKQUl6Qis3czJ4UDhJNTNraHU2cEtOSWNDaUF3aEJSOGhDN25ZejZUcXl4?=
 =?utf-8?B?dE1KTGIrNFl3bkl5azZuOW9NY3FlaGV4dGxPSUh0Q2x6cUY4WThqRnlQcXFS?=
 =?utf-8?B?L0NiL0oxeW1DclhOZ0QrM1dxNmh3QUgzamVKTlNNcDgvTTkvR21rNWRkZ3JN?=
 =?utf-8?B?U2VOVC9KV01BeFMvcVE0aG5OTVFacXpsUTdIaWZ5M0s2UitCN2w4NE9ZTGVt?=
 =?utf-8?B?Z0J3Z00yREhycnAvRDNPQVBaMnJqclI4ZGRBc0ZIZ1A2WnMvakFqcGNJcll6?=
 =?utf-8?B?OVkyZWs3YjJvd0xxZ2x4SkZlaUhYdTRTUGJaQXozaDZwZHBuUXBOb095eXc5?=
 =?utf-8?B?eWhjZEdraW5XZGZuODhEWFNZM3Z1U1AzaHR3K1ZIVTYvUzhXajNJZGk3Mm5X?=
 =?utf-8?B?QjB5ZG9jUTY1QmNrMTN6SVBBWUxGVFpCdGw3bzh2RDc2TVdTMWZZMkJmVUQv?=
 =?utf-8?B?WVhQTFVLdHU1NlEwRGdtUVVGTkFqOUp0eGxMaEE2d0ZQdE9EY1hseGlBWFZO?=
 =?utf-8?B?eUo1WXpYb3duUDAyRzRNVG9RVEhvVFNJV0xrVW43ZEoxQVdxS2RCeDlCdjVu?=
 =?utf-8?B?Uy9yZVlUbGYvTjQ1SzkzaTJzQ1IrYzlnYUhkYWlqS1J1TWpENmVnRzcyTmxW?=
 =?utf-8?B?aWhnL1NrY1pDOEVGZllCWWZwS0dJMkxRZ2lPNWx4bDM4NWdNTVVGNEtlcXlE?=
 =?utf-8?B?SG9lOGQ1K0JvdUl2bS9aTkVrR2hDT3Q4dkZMaWV5Wk5kL2RzZmliM2tWaXox?=
 =?utf-8?B?SEs3U1JyVFZvaUhRZXhIeHA4ZXVVdmI4bmxWRzErSkhhR0picnpkMU1TeHJG?=
 =?utf-8?B?aTY5b2ltU2ZUY0ZTU1ptSWR4MWFRY01Qa0w2eXdBRnBQRUp0WkU1R3d4TDd2?=
 =?utf-8?B?YlJmSTQ1L3BXelVQa1VuK2RDMHIxUnlEZTIxU2dOUEpLbTlBbXN4SldXQW1K?=
 =?utf-8?B?cnFva1dBNDFJQXR5V0ZXUVFLNStpMlVRMDJrNWJrbXJiSXVsZHA5VFZCbDBx?=
 =?utf-8?B?ZzhEVXNVSklzRUtIejlCY3JZYXBvdTByd3JqdTdjTTJzRVZEMDY5NFpqdmtC?=
 =?utf-8?B?Ymc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A6567AF70E7D484B81576BD21859E7FA@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9709.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f7e9420-5911-4686-94d9-08dc5fb75a68
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2024 14:53:48.0184
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aQQ/3bsa41pGjizF4SNNrL31sOYDqe3SS1lYL9/o9O9mM0ddOlNy293Td4XjKrOwQwrDKAiI8sdQv2BBgwLueQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9843

T24gNC8xNi8yMDI0IDg6MzUgQU0sIFBhbmthaiBHdXB0YSB3cm90ZToNCj4gaU1YOFVMUCBoYXZl
IGEgc2VjdXJlLWVuY2xhdmUgaGFyZHdhcmUgSVAgY2FsbGVkIEVkZ2VMb2NrIEVuY2xhdmUoRUxF
KSwNCj4gdGhhdCBjb250cm9sIGFjY2VzcyB0byBjYWFtIGNvbnRyb2xsZXIncyByZWdpc3RlciBw
YWdlLCBpLmUuLCBwYWdlMC4NCj4gDQo+IEF0IGFsbCwgaWYgdGhlIEVMRSByZWxlYXNlIGFjY2Vz
cyB0byBDQUFNIGNvbnRyb2xsZXIncyByZWdpc3RlciBwYWdlLA0KPiBpdCB3aWxsIHJlbGVhc2Ug
dG8gc2VjdXJlLXdvcmxkIG9ubHkuDQo+IA0KPiBDbG9ja3MgYXJlIHR1cm5lZCBvbiBhdXRvbWF0
aWNhbGx5IGZvciBpTVg4VUxQLiBUaGVyZSBleGlzdHMgdGhlIGNhYW0NCj4gY2xvY2sgZ2F0aW5n
IGJpdCwgYnV0IGl0IGlzIG5vdCBhZHZpc2VkIHRvIGdhdGUgdGhlIGNsb2NrIGF0IGxpbnV4LCBh
cw0KPiBvcHRlZS1vcyBvciBhbnkgb3RoZXIgZW50aXR5IG1pZ2h0IGJlIHVzaW5nIGl0Lg0KPiAN
Cj4gU2lnbmVkLW9mZi1ieTogUGFua2FqIEd1cHRhIDxwYW5rYWouZ3VwdGFAbnhwLmNvbT4NClJl
dmlld2VkLWJ5OiBIb3JpYSBHZWFudMSDIDxob3JpYS5nZWFudGFAbnhwLmNvbT4NCg0KVGhhbmtz
LA0KSG9yaWENCg0K

