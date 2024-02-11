Return-Path: <linux-kernel+bounces-60808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F382F8509C4
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 15:58:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B1771F2199E
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 14:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377685B5D1;
	Sun, 11 Feb 2024 14:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="MX7EkDbU"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2115.outbound.protection.outlook.com [40.107.105.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB205A11F;
	Sun, 11 Feb 2024 14:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707663485; cv=fail; b=emlgNUEhUpKzKXbp5ph44vU7wtkivqG4Lxr1sSW7hBuAs4jS8dzXIdPYk0B7A3ODcn08XZZE8mUOR4bT6/sOi51qzK954C2depxGggKkLXF+k1a6kvYKirEgweC1Sm1oQAKTMAFRW/Hlub27HXpQ5BQz1/15Vjy5/6bnQ9wPFsQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707663485; c=relaxed/simple;
	bh=1Ze9AamJ8JfMfTzH5deJZ4wNGf4mdO60pEIYLXFMKtk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BVNlqzO3z2775VgqoNlpYzzAehB2OR0l7PboSCFQUkxPvLaO4MmMObCBsFj9tWpLClKiLjX9n21FYc/Qb71+2Rt/vTy2AKtxz7mL2DA9sOJZeZg9fPHPCX/7ZBTyqQavmou/LMPCgcIif6c4VTgJ0ig+xBf4vUutwqB/MTN2Hyk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=MX7EkDbU; arc=fail smtp.client-ip=40.107.105.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ft7EVVpELODGXs4YTejtsEZbY095IdW5GAoahAAxxH8/CKjmACXUoKesJ6JEFtdg3my2iRSDYPwwMZIK9zztIFG1K9lZcJ6ntJGsSYh+C9jwuq/ZuliMYwAnFyMie4ohddNg34COJNw1dVDbmn9nokOHhJvLiZ54uocSiQDMgFRc+wTL2FnmxerEKBWALP1ItrorPlaeq1hbJHu6100TIuf6oNmdc6V9dGSJPnyiWP+c56HyiVE1+SO1x0iGIIWhErxOHwfDb6Evuv7kfdGEsB3ktmjuXI9rxyNObThZuX1M7q4hFZ2I0mOnaOkbdsJk1cvG2pBlnCXxBW3eBdZB7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Ze9AamJ8JfMfTzH5deJZ4wNGf4mdO60pEIYLXFMKtk=;
 b=Y+qNCXyx7gdwztmKYna18d8MSWTdhSrrlVVfFQYi62SnrCo162WKjnEh/szknPXComPMkmgEJNZehSk2p0ITxLwCXEnWvdnvEaDRPcgqET+tpwkaFN8977gggZk3+Uc4HP27dx5Bg1Mc4biGl3OYY7cMVXj4XUZcIBg2LOhfehlCazk8+QRUfYr5KFzNlqdKYWaEdn/yiw3j9wzf++7TV6MFNHWcDHr4U7KiJOXZBsyovCydTy1Do2w2JXarJ0DDkRY7HT5SLikge9x5GUHk8pOEwEfpRFLgc9s8j2RVPL6AdFMDiE3oD1wuxXV2gBUK7fHbpm5aTgzK5uyR6AdKBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Ze9AamJ8JfMfTzH5deJZ4wNGf4mdO60pEIYLXFMKtk=;
 b=MX7EkDbUsX5MOxnu8eV4EqKZytXlJEgUIsGODF7XBN+KHbEY+XeQFQOVYPSVYDH7dWiEC76VS2TS8dRljbzjkuBFiLaMXQYbuRPjv94bWRXPwRjBS1J6+WwJJGxCjvEeLDGXKgsaD6bFl6eds995IzFVbneoA9NjvQUSwe275GE=
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by DU2PR04MB8966.eurprd04.prod.outlook.com (2603:10a6:10:2e1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.39; Sun, 11 Feb
 2024 14:57:59 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::3b94:f607:ebe1:7d6c]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::3b94:f607:ebe1:7d6c%7]) with mapi id 15.20.7249.039; Sun, 11 Feb 2024
 14:57:59 +0000
From: Josua Mayer <josua@solid-run.com>
To: Conor Dooley <conor@kernel.org>
CC: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, Alessandro Zummo <a.zummo@towertech.it>, Alexandre
 Belloni <alexandre.belloni@bootlin.com>, Yazan Shhady
	<yazan.shhady@solid-run.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-rtc@vger.kernel.org"
	<linux-rtc@vger.kernel.org>
Subject: Re: [PATCH v4 2/5] dt-bindings: rtc: abx80x: convert to yaml
Thread-Topic: [PATCH v4 2/5] dt-bindings: rtc: abx80x: convert to yaml
Thread-Index: AQHaVfJlZfbrK8KniEiJ3e3MRZt0PbD4ue+AgAyPk4A=
Date: Sun, 11 Feb 2024 14:57:59 +0000
Message-ID: <eae2e8ab-7561-4990-9e5c-de1b158fbdd7@solid-run.com>
References: <20240202-add-am64-som-v4-0-5f8b12af5e71@solid-run.com>
 <20240202-add-am64-som-v4-2-5f8b12af5e71@solid-run.com>
 <20240203-prolonged-backfield-c659e0016d70@spud>
In-Reply-To: <20240203-prolonged-backfield-c659e0016d70@spud>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB7586:EE_|DU2PR04MB8966:EE_
x-ms-office365-filtering-correlation-id: efa06d59-7599-4976-4e0e-08dc2b11d6b4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 zdWGw+pkYyLoDr3SCAQGj87C9YY5Jb07Eqv3cgi0ubVcKDWQsjsA7cv4VLp7DwValyVAsraIHbyXUB3FwG6PGBQrM+pB3Fox6wbdHomeQjSjyx4VlVjdasqlLKVXTIyf8YCVCCS2q57R6G3qzceJwz1MHwEV+DDg3z2z1u22jDuQqCwQAyF/WfXHWSIWcFUzhwkx4hYuESleuo1nBGli4C2QB/d1ePRdkmha9iUCPlKsKHS6MdcLiASsyBCIKmkyQINDxTeDnbl/JBs5WLGYxfZFLqTuOtN0jXZKb3tl2ugMbK4qFATnAgQgASQ2DkpkPVESNEv66JUYJciMlz5o2HNKng+zNpg0SITivGvt7RDi/3d+Zq8+UYfPELbyxiIkXP9PjtIjaSonUcM8WiOdMSfryJtfVCmL8ov69yJWhbdsAwGKiUV5pTtcKR7t1kRjwCRVZeNXyBOHfFTmVBgAcW+6Ruh6zKIYIpKqM7A97/eKsyc6Pp1R9kj/rSvJ3lbg3LZbXp/J7DU/bSzyaTOHivDXqm1PZCKmCrf242eBhk0o+RpfZj2va62Z/thzDgElDN892r63PuWXy/u/Eve7PqNgjBLwJYJUjOArD+jYsK0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(136003)(376002)(39830400003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(2906002)(4326008)(8676002)(8936002)(66899024)(5660300002)(2616005)(41300700001)(122000001)(38100700002)(76116006)(86362001)(36756003)(38070700009)(966005)(31696002)(66446008)(478600001)(91956017)(6486002)(26005)(66946007)(6916009)(54906003)(66476007)(66556008)(316002)(64756008)(6512007)(31686004)(6506007)(71200400001)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WU5mMm56M2ZLcFBaTGRzWmJ0anZ1ZGhkWlhnMHVHQnJPSWRwcWExajNDV29l?=
 =?utf-8?B?UHIwZGk4WGFKU2JibnZ6WmxnaHBqRWFKczB3WkRiS0NnbEt5SkhDeklHZzZn?=
 =?utf-8?B?MFhoOS84TEs1YWgyT2crSnN6SDgxczZTRW92YzNJa092M09ueWRqOUpKeXZY?=
 =?utf-8?B?QnEvR1AxNC9CeGVyV2h3SjlITEF4Y3p6bmNxRXN3S2ZRT0l0R29xeDlKMUhK?=
 =?utf-8?B?TU14Y0NFM0FmaTVoVzBrRThOZFRtTUZSVk5xY1lSSUxyUGlUeUpIb0NXeGhz?=
 =?utf-8?B?czJuQ2JiMW1IYjFVTWY3NTZ3WXpjSjQyN3JhaGJlWlZPR0ZDL2VVSkk0R1J0?=
 =?utf-8?B?eG1uRTBCZWU2TktJZEkxTXgyc0ZubVhEcmJGdm1NSnc5VFZFcEFwMUR4WjZi?=
 =?utf-8?B?K1hUVDlDTVUycmNmUCtrTWMzUTRLdFc5YTdSY1Q0U0NjWTJ4eGx3dGZHcHcv?=
 =?utf-8?B?SkJtMXErTVdzSVIvQnVlY1dmMTlnSldVUjBoa3p0SEVLNHFTU1hsR1Z4Wmti?=
 =?utf-8?B?V0dOdEp6OG1qVk85RHB3RUMxTUdLRkt1MVROWitmQTk1YktUM2tFeHY0Mit5?=
 =?utf-8?B?dkIvY3FYNDU4R3JPRy83VC9GZ1ZmdVNacW1Zbm5DaGpmS0w4L3J5bkQyMXkr?=
 =?utf-8?B?SnhMNHExbjhXaGpQMGdJWjFvdTJLNHF3YTJudW42dUVUbHNrRURJTGFwczdh?=
 =?utf-8?B?R0lCT2g3eTZPdVpvVFpLWGFNcUdVNjZCS283SW1hd3g4cWJBTWlCUVl2eUZu?=
 =?utf-8?B?U2I0aGR4Z0ZjSDgzeGNEVEhJMWQvdVBmdEMxajE3TENWUzdsRkdzV0UxNlVK?=
 =?utf-8?B?bGlHanRLSVFSeDJXRi9RRk1wa0pHd2l3Wmk4b1F1WTFkOXdwZitkeXdlbnRZ?=
 =?utf-8?B?K1BnSVo1MStnNW9rcjdCWlREQzcvczQ1blhMM2tsSkptWmFrN3pNNC9Dd0dB?=
 =?utf-8?B?S3QySW5Jb2dUSUZhZ3pLTVJCekxJNnZVSm93aDU2TFp3ZGtWTUd4Qzc0c2p0?=
 =?utf-8?B?bkdNRXhSMFBOUE9qRXZjVUVZS0FrVFhoMGYyc3VNdWw3ZjFuZ2ZkRmkybHpE?=
 =?utf-8?B?L0tRRjVuUHZ6S09ZQWYzMS9QRVNmY0VzZDB5dzRmSkZtZkdaVng0Mm95c0dV?=
 =?utf-8?B?aHZ2RitBc3huNkhvd0tMd25ZamVVZHFCeVlmMW9BQWRXSlNwUnI2bWJFaW91?=
 =?utf-8?B?YkZybVd5T2RGTUNWQVRJWU0xZ0k2eElZcTlvcjVOamdsWnB1TnE2OW50L2tq?=
 =?utf-8?B?OSt2V0hwbzFGQUJqaGYrK2NraVR2SXlVODFiNnEwOU4xRFlPNUxSQkRUcUpi?=
 =?utf-8?B?NXAxcDRQQmZ5MVZ6UVhxMFJaZFZKdW9Nek1aTG1Kc1paNHVNVHV1MnAvR25y?=
 =?utf-8?B?cFgvazVGQllKNWtUNmZOR1k4S01DS0NDbVdWWElYS3Myd3FJWEFmUFVHYWVT?=
 =?utf-8?B?ZVVTU0cydmxNWndWZHBZQTQ0a0VmOWw1T1lrK0pMKzRIS0ErSG8vWmEzM0VL?=
 =?utf-8?B?QWZOMkk3NVFMYzNpQ3M5bEFnVkpqdG9IRVlTU0ltakxZTCtBV09URDFsMUtp?=
 =?utf-8?B?TFNUZnk4NjJVSlcxRXVVQlZFTi9wTXU3b2tabWVxalZpRzVZZ0Z2ajZjM3dL?=
 =?utf-8?B?WXNNS2FzbzRVZCsrdFpyeVhraklzVUlGZ2EyRGVHYWw3WTJuU2RMSU9kcEVp?=
 =?utf-8?B?MHFlZHZMMEZxRUE1M1JnTHlUV0VtaEZ1WGFSZ2gyelBmdjJVT0ZZRndQQ0Uy?=
 =?utf-8?B?dElTRW1yekNiVTU4QXRrblpkYmxXOHowZ3FqSjFWMWJReEs2LzRBc2pQWWQy?=
 =?utf-8?B?cXBvZmh6cDZIT1dIQ1F3cDgrSzdBRnQvT25BazBrYnJLWE81bUJCWUFTQm1I?=
 =?utf-8?B?MDBQeVFneHplUjJxSkx0UXl1T1ZJQVRnamNpcUVWeWlTZ3JxWXZqQjNsdExm?=
 =?utf-8?B?cTdRaGtQa3M1Y2hQTVN6b3cxRUZmM0JNVGI3LzhhZ0xBUkVCR0F6NDNFQUVr?=
 =?utf-8?B?cGk1cGxnVDBtS1Bnd0hnTmlRK0t0RnJXYXloODdWRUp1Z1N5RGxINUJwc0xW?=
 =?utf-8?B?Tm1jMDNBSEpSa2xKdVF5U1pqc2NhNW9sQXNYckdMVWg2WFlyVXRVUDYwa2x6?=
 =?utf-8?Q?+CPAQmDGrtaTg6cCC7voCl97V?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <61F30DCC47F2314EBDB455EAAE4712F8@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efa06d59-7599-4976-4e0e-08dc2b11d6b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2024 14:57:59.5903
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ieEU8xIMVnsRUgIFKfZsvYXnxJfRpf2wl1S7MEDpU4m2DNgaTW4swiH0IQcnaniToB/dn/4D9hE4WAoJQ7ht9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8966

QW0gMDMuMDIuMjQgdW0gMTY6MDggc2NocmllYiBDb25vciBEb29sZXk6DQo+IEhleSwNCj4NCj4g
T24gRnJpLCBGZWIgMDIsIDIwMjQgYXQgMDU6MTA6NDlQTSArMDEwMCwgSm9zdWEgTWF5ZXIgd3Jv
dGU6DQo+PiBDb252ZXJ0IHRoZSBhYnJhY29uIGFieDgweCBydGMgdGV4dCBiaW5kaW5ncyB0byBk
dC1zY2hlbWEgZm9ybWF0Lg0KPj4NCj4+IEluIGFkZGl0aW9uIHRvIHRoZSB0ZXh0IGRlc2NyaXB0
aW9uIHJlZmVyZW5jZSBnZW5lcmljIGludGVycnVwdHMNCj4+IHByb3BlcnRpZXMgYW5kIGFkZCBh
biBleGFtcGxlLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IEpvc3VhIE1heWVyIDxqb3N1YUBzb2xp
ZC1ydW4uY29tPg0KPj4gLS0tDQouLi4NCj4+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvcnRjL2FicmFjb24sYWJ4ODB4LnlhbWwgYi9Eb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvcnRjL2FicmFjb24sYWJ4ODB4LnlhbWwNCj4+IG5ldyBmaWxl
IG1vZGUgMTAwNjQ0DQo+PiBpbmRleCAwMDAwMDAwMDAwMDAuLjQwNWIzODZhNTRiMA0KPj4gLS0t
IC9kZXYvbnVsbA0KPj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3J0
Yy9hYnJhY29uLGFieDgweC55YW1sDQo+PiBAQCAtMCwwICsxLDc0IEBADQo+PiArIyBTUERYLUxp
Y2Vuc2UtSWRlbnRpZmllcjogKEdQTC0yLjAtb25seSBPUiBCU0QtMi1DbGF1c2UpDQo+PiArJVlB
TUwgMS4yDQo+PiArLS0tDQo+PiArJGlkOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvc2NoZW1hcy9y
dGMvYWJyYWNvbixhYng4MHgueWFtbCMNCj4+ICskc2NoZW1hOiBodHRwOi8vZGV2aWNldHJlZS5v
cmcvbWV0YS1zY2hlbWFzL2NvcmUueWFtbCMNCj4+ICsNCj4+ICt0aXRsZTogQWJyYWNvbiBBQlg4
MFggSTJDIHVsdHJhIGxvdyBwb3dlciBSVEMvQWxhcm0gY2hpcA0KPj4gKw0KPj4gK21haW50YWlu
ZXJzOg0KPj4gKyAgLSBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZw0KPiBJZGVhbGx5IHlvdSBw
dXQgc29tZW9uZSBoZXJlLCBub3QgdGhlIERUIGxpc3QuIFVzdWFsbHkgdGhlIG9yaWdpbmFsDQo+
IGF1dGhvciBpcyBhIGdvb2QgY2hvaWNlLCB3aGljaCBJIHRoaW5rIGhhcHBlbnMgdG8gYmUgdGhl
IHN1YnN5c3RlbQ0KPiBtYWludGFpbmVyLi4uIEZhaWxpbmcgdGhhdCwgdGhlIHJ0YyBzdWJzeXN0
ZW0gbGlzdCBpcyBsaWtlbHkgYSBiZXR0ZXINCj4gY2hvaWNlIHRoYW4gdGhlIERUIG9uZS4NCnJ0
Yy1hYng4MHguYyBtZW50aW9uczoNCk1PRFVMRV9BVVRIT1IoIlBoaWxpcHBlIERlIE11eXRlciA8
cGhkbUBtYWNxZWwuYmU+Iik7DQpNT0RVTEVfQVVUSE9SKCJBbGV4YW5kcmUgQmVsbG9uaSA8YWxl
eGFuZHJlLmJlbGxvbmlAYm9vdGxpbi5jb20+Iik7DQoNCkkgcGVyc29uYWxseSBwcmVmZXIgdG8g
cHV0IGEgbGlzdCwgc2luY2UgSSBkb24ndCBrbm93IHN0YXR1cyBvZiBmaXJzdCBhdXRob3IsDQph
bmQgc2Vjb25kIGF1dGhvciAvIHJ0YyBzdWJzeXN0ZW0gbWFpbnRhaW5lciBpcyBhdXRvbWF0aWMu
DQoNClNvIHY1IHdpbGwgZmVhdHVyZSBsaW51eC1ydGNAdmdlci5rZXJuZWwub3JnLg0KDQo=

