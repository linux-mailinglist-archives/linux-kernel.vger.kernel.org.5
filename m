Return-Path: <linux-kernel+bounces-144149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 284BB8A426B
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 15:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B80A7281A10
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 13:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C145B381B9;
	Sun, 14 Apr 2024 13:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="hcOD/iib"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2104.outbound.protection.outlook.com [40.107.249.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91DE1CD06;
	Sun, 14 Apr 2024 13:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713099737; cv=fail; b=N2MKjUL7WTVluLExrbTbPaQxUADA80uY6ALsgNp/Md1zumnJJJhdWbtD+Nxvhn8srWQ4NxlJes58DD0nROZMch4/zN6redaVBxbXawamh3Q8pDi8lSia9WxrWfoctvx6Q37NrLlUFn+x7l1v90/pOiWFsHDEj6+qzj4i9Hg9WD0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713099737; c=relaxed/simple;
	bh=u7sgTfvcdwkV8pEcfwnFnpEpOQ2qXZm+yECZsEn7/5g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VVV+DbIPaCqS8QOdUeJ6RlzRU2ilkk2uPJoQKRQdvM44Q+XB4zebbBX0ikT2fAzXW4TVegce4wQ7v5MUaasrlLwGPrdvie1ch3IOVZzwr+F8MM7TxyXWDTcRpbqXlTNJePri/dFZ/PVy4/pc7bE9BYfjbwvmbV35eaqhvYhCqLw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=hcOD/iib; arc=fail smtp.client-ip=40.107.249.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D89JbT2D992xMi21L0kd6AktKsX6gbokPWuoiZt/rv2grzIQJdXgMlA9/PSU6QK3SpEhohX7ia52iL5thqZynk+QC8b70HGN0CmuSzA4woa3y7WAHmyOHEjb5uqaXv26WnurOxbbuWdLJ7271TEARVJ5lyCvbHtSfr0IH9CCG/Brq5mdWsyOTNFUIaqClwuEDDSaU7GUH4rLX95Uzc6YQgYe0q2bwzn5ERMofO7wGsDXUrZy4RCPq8HJSh2DhxsAqsST8VJEf50zbCCtRw7gDk8nf7fpWR1xGjAr0My3iLOyT1XUa7ajvFv0cpP+i5D7lgjQC8w9/tn2sdocCCZ6Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u7sgTfvcdwkV8pEcfwnFnpEpOQ2qXZm+yECZsEn7/5g=;
 b=MEcPRXmaSZWnapiXrrAp8JY0qGzaAwrmAAlfdGm+aE27bTMLHMLEhY9i6cv3o6SFhQfGoHNmMd+GlJVaFzyiCBdKK0YAjtWtZ47jrw5c5IE/dOO4RJRQ4K4iPY5D1Znt3/6Ii2bscIoTAVbCamnvj1KlPg4XBWi9l8+Qpru8BW7kEVajb4F/GqTmebkD7cYdOXm8vfcamh9a6xdhHi1kwXXE/gK9rprMzRCgvIN/p+gU8g/VDYATfl0b/hFxQxgIeAzo9+0pozGoGEFq8BSo9BGe0fj/GJU6L3v4JC2Km8/SicJAJh/hH3ZlOfzKHnK8ADlttKnTmk5VfeuSZqYyVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u7sgTfvcdwkV8pEcfwnFnpEpOQ2qXZm+yECZsEn7/5g=;
 b=hcOD/iibvmMxSzR+Ss7UT4Wse/6hbLYX5qF5aQH9vmbyufIRwnDHShtyaUna2qpTIp2hN+Db4vJSB1G5s3hhLuaKSaCjXMa/P/1dKeHneHVQszf+OeNXKnUvgvOqGhRUxmHNkOr21wVfUKqhMUddELtLupDhy7E/QFMnZYR6Vfw=
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by DU2PR04MB8645.eurprd04.prod.outlook.com (2603:10a6:10:2dc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Sun, 14 Apr
 2024 13:02:13 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529%7]) with mapi id 15.20.7452.046; Sun, 14 Apr 2024
 13:02:13 +0000
From: Josua Mayer <josua@solid-run.com>
To: Andrew Lunn <andrew@lunn.ch>, Gregory Clement
	<gregory.clement@bootlin.com>, Sebastian Hesselbarth
	<sebastian.hesselbarth@gmail.com>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, Rob Herring <robh@kernel.org>
CC: Yazan Shhady <yazan.shhady@solid-run.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 3/4] arm64: dts: add description for solidrun cn9130
 som and clearfog boards
Thread-Topic: [PATCH v3 3/4] arm64: dts: add description for solidrun cn9130
 som and clearfog boards
Thread-Index: AQHajmt3TcSJzZq3kU6YWvE1xzrj+rFnuxiA
Date: Sun, 14 Apr 2024 13:02:13 +0000
Message-ID: <8d0cd34c-ca04-45db-a95b-3bf5e3800958@solid-run.com>
References: <20240414-cn9130-som-v3-0-350a67d44e0a@solid-run.com>
 <20240414-cn9130-som-v3-3-350a67d44e0a@solid-run.com>
In-Reply-To: <20240414-cn9130-som-v3-3-350a67d44e0a@solid-run.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB7586:EE_|DU2PR04MB8645:EE_
x-ms-office365-filtering-correlation-id: e8e0a132-cba3-41ad-db12-08dc5c831a84
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 pr45nigsoZpFXtRt7KTVJ73Hb8pJZswJzWTP5aYIM+qf6t+4Fdi/OGE6CQZQzvvvmrD5/Ah3Xab1nCAkOzvUPRkpaainNwNbAiy6YMifaePwtrH6wfVUX+p90kY6sa7o8uhgobvNJqbDuvySlpQK56lI7/+m1WbtvECQC2DDvtJZEFHyd3uHbqJp//u8zr1FK3PifmMxiBBWAhdPiuP/chbtTgDnbdFrE36NMfUkB/seoociehkX/KGa4zVsnXmUiXd7F5uVbWnSy8xdcvkDEjLMoUD+QNCi7V0dM/75wqRaezcagJMu+2bu4+0mDXX5++5DXrboz0sCC0/CxlxASupsngLXuIx/yr6dSRuAVIK5X1cRmVMM3CDYs1ZA0oJOxZf/p8zHfMBB0PGqNWl4C+xrKNvbnXnK/3ZKPP7r9zPG2/ZBTkPgVZo8DYOEumAe6+t2BpwC9MPba+ygIELVUlNSSPEjLfMTwkMw8qU0mfyp+GPKPhsn4acs3P4aV1uAs39DMDEONdXFlXz71vnXNeKGThFduARkgq4LCpil0ZYrJJiaFqgK/PtfR7MV9ydj+RyivyB+ICMor1sxRfSSf7PSk1q+3avMcLXk3TQ7rMI+gy53CzJyu3mZRmKzRbyhdqHpGBFhK52PFlv8DZvWp3b69m7E8jowe7z2lG+K/HFLoTHyF2UkDasV55UW/oYhRvgJKCVopsWCDf8tpMYbjNYAQJcOUk8mvJMpeJJhZVI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cXl3cmpDUkJjM04xS0tyTXhvcXd2ZG1KS01oZS84aldnbHpRZTBCTG1wM0tM?=
 =?utf-8?B?dk0vU1oycXVDRXhMaEZjdE8xSFJuOVhaYTZkeTA0UEgzRFlLU1RobzJEKzRq?=
 =?utf-8?B?WkJsKzhXVTlob05SY0xZaDJnV2F5ZjJjVmVZUU50eTl1V05keFlKb21yQTlY?=
 =?utf-8?B?d1g5b3JURTdCUmJkWkpyOEtHMGd3T2ltaUJ6VkZRK0cyTkExSWlNd2xNUmU5?=
 =?utf-8?B?VU9XQTNOS0tkZldxNVJqK2xOTUR6akhDbEltbGI1eThxME5zOU0rYXFqWlI3?=
 =?utf-8?B?L0pINkpOY1Z5NkVZL2FQd1d1b2I3bGcreVdjdnRGSzBsTDdKU3gxb2Jkd2xu?=
 =?utf-8?B?UnpDMGI5NG5UMVFQNzNsNndlR0QveWF1Mm04QjA1ZkhlK1U2dDN4V01VUTNY?=
 =?utf-8?B?WlNSWElKb2tkQ2pPeFVySEFvMkJBQ21yYXY3QWdFeGF4cVMyN2JFR0dLbmhI?=
 =?utf-8?B?bkxhcUN2cXlFSjBvVVEvdUJPUnVUZlpWNTFYeG5pY3FUU1JoNG54S2pLczly?=
 =?utf-8?B?U2xXWWVRdFI4aWptczlzZVk4eFo1ekcyNTVSRWlSQWhqWWRiallaVmN6M2dE?=
 =?utf-8?B?a080NHZ6ZExnTW16THFOUFRrdjZaVHExQ1FsTkhlZHNFMW1uRGI5YVVTVkRh?=
 =?utf-8?B?K2gzMVlIOVU5QVBXSWdEcHpncnhvSWc5amxleHBhMWkyWFBXeEE2WUtpeVB3?=
 =?utf-8?B?TEVIVDdSNFRjdTZwQ3V5THlHVVBza3BGNFZYYVlpakJmOU55czdJZTJtdGdU?=
 =?utf-8?B?UmU1SEo5N25VSENDZnkyblVNNGpkY2pHL3BITzFIMnN6bTdyTGM5R2hrc2kw?=
 =?utf-8?B?bUtBb1ZUNzBkT0ppbWtZWUxVdTBJa0NtNUpoaVJPNWtmWUUzejlhclFRRVNt?=
 =?utf-8?B?YzFWZjhzRG8vNDVEd1VSdVorYllyM3ptMGpPNzlQSWhjVzYraDR6MzMzMVFG?=
 =?utf-8?B?NHFYdHZhOWNiRVh4S1ZjcEdCQnFYTXZ3TWRUM2FZOXFjdHR1VDFRRzNmMGVP?=
 =?utf-8?B?NDNzbWlTOFNuSGI2aTZnUDB4YlViYmlsaGMxOXJHWlVTNEFrQkgweG41cHIy?=
 =?utf-8?B?MXJRNDdXcFBxV2NLckZFOXZtblp2bFNoQkcrYUg1WjYzS0lwd2xISjY5cC81?=
 =?utf-8?B?Ulk2QlNSbm1GZkI2dkxMTEd4MHh4bFZHbG4wYUVNOFFQTkxGN0NYK0ZKckJN?=
 =?utf-8?B?ZVlPczEyVGdlUVhOa0NTYVlveUxYVjAvTWRUcXNWQ0N4SVVEcHdaeGhJZXox?=
 =?utf-8?B?RW5tUlc5a0NScVlHVm84dy9HM29tRHY4YXhvTkFKRXNlbXptaVgyTjA1bDZQ?=
 =?utf-8?B?alI0ZHVMQUdld0NEa1NQaWViMHBFZjBMS0VMdDdYdzhETTk3UWNMcjhFUzB3?=
 =?utf-8?B?eTdJdTJUQTUrQ2ptWTVyUE1BbUF2WUFTVG15NCtONnZObmVNZDZLSzV3NFh5?=
 =?utf-8?B?cEl6SmY3NGNPSy9nYnh3YjV3cGg1RnhsZW9mOWFYWHhHZVpSZUdiVUFiNkNm?=
 =?utf-8?B?bmZnSks4V016WG5KSjgxcWlzRnZySU5EZGc2VDMvc3UvOXlwaVptOUdMMlFh?=
 =?utf-8?B?Um1iK2lJUVV2U1BLdmwwUnpBNWtESU5yZUZZMnBUQjVMQSs2Y3dWNVBEYjRI?=
 =?utf-8?B?c0hWWElzSGFGdTQ2cDlpVWE3VkkxeWwwakxoaTFCQkk5aWFPN1hQZ09iaWVS?=
 =?utf-8?B?R1ZJTHV5aVR3QWRxdWdROERlV0ZNWmxhTG1EQzJjaHhKa0llUkJnVStrdWhO?=
 =?utf-8?B?NitpWm5UZlNGT0J1TlV2SXE0Z1NQdVlrb3VtaTdNYlVac1QrRWdxb3JQaHdH?=
 =?utf-8?B?M0YwUnlWdmdBcFlBOXNBUzljS0kzWkQ5RWRHUjdMaVozRDBlWXFxVFJTM1ZD?=
 =?utf-8?B?dnc3d0lSTEhrcDBiU0k1YXZwK1loMEVWcHZuWFNlOUNOSjZZRWdjeko4cjNx?=
 =?utf-8?B?M0ZUaVFsdG9TUVBFSzBsYzdZdXhGdCtZaDB0OWxTWHNubnR0eVlJRWduSjRP?=
 =?utf-8?B?RmpEYko1TE5YTlEycTdHbisvb29OVzg0NkJ1NmRoMEMzU3BaOXljQUJpT01V?=
 =?utf-8?B?ek9zVnFHS2tSVUsyajBYbG52azh6akFQSVpXdFhtT1cxeE0wQVhNdTdtb1Uv?=
 =?utf-8?Q?XnXA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9F222DCFE0340B419505F83F72940A7A@eurprd04.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e8e0a132-cba3-41ad-db12-08dc5c831a84
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2024 13:02:13.4934
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HVVptNgkI5irZLIJvfubXeRRLJ30IWadVYHnZQV5nP4eMs1LBd/NzjN4L4gvfA3Ps95CZtS/E0E8LCiBw2KDsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8645

QW0gMTQuMDQuMjQgdW0gMTQ6NTggc2NocmllYiBKb3N1YSBNYXllcjoNCj4gQWRkIGRlc2NyaXB0
aW9uIGZvciB0aGUgU29saWRSdW4gQ045MTMwIFNvTSwgYW5kIENsZWFyZm9nIEJhc2UgLyBQcm8N
Cj4gcmVmZXJlbmNlIGJvYXJkcy4NCj4NCj4gVGhlIFNvTSBoYXMgYmVlbiBkZXNpZ25lZCBhcyBh
IHBpbi1jb21wYXRpYmxlIHJlcGxhY2VtZW50IGZvciB0aGUgb2xkZXINCj4gQXJtYWRhIDM4OCBi
YXNlZCBTb00uIFRoZXJlZm9yZSBpdCBzdXBwb3J0cyB0aGUgc2FtZSBib2FyZHMgYW5kIGENCj4g
c2ltaWxhciBmZWF0dXJlIHNldC4NCj4NCj4gTW9zdCBub3RhYmxlIHVwZ3JhZGVzOg0KPiAtIDR4
IENvcnRleC1BNzINCj4gLSAxMEdicHMgU0ZQDQo+IC0gQm90aCBlTU1DIGFuZCBTRCBzdXBwb3J0
ZWQgYXQgdGhlIHNhbWUgdGltZQ0KPg0KPiBUaGUgZGV2ZWxvcGVyIGZpcnN0IHN1cHBvcnRpbmcg
dGhpcyBwcm9kdWN0IGF0IFNvbGlkUnVuIGRlY2lkZWQgdG8gdXNlDQo+IGRpZmZlcmVudCBmaWxl
bmFtZXMgZm9yIHRoZSBEVEJzOiBBcm1hZGEgMzg4IHVzZXMgdGhlIGZ1bGwNCj4gImNsZWFyZm9n
IiBzdHJpbmcgd2hpbGUgY245MTMwIHVzZXMgdGhlIGFiYnJldmlhdGlvbiAiY2YiLg0KPiBUaGlz
IG5hbWUgaXMgYWxyZWFkeSBoYXJkLWNvZGVkIGluIHByZS1pbnN0YWxsZWQgdmVuZG9yIHUtYm9v
dCBhbmQgY2FuDQo+IG5vdCBiZSBjaGFuZ2VkIGVhc2lseS4NCj4NCj4gTk9USUNFIElOIENBU0Ug
QU5ZQk9EWSBXQU5UUyBUTyBTRUxGLVVQR1JBREU6DQo+IENOOTEzMCBTb00gaGFzIGEgZGlmZmVy
ZW50IGZvb3RwcmludCBmcm9tIEFybWFkYSAzODggU29NLg0KPiBDb21wb25lbnRzIG9uIHRoZSBj
YXJyaWVyIGJvYXJkIGJlbG93IHRoZSBTb00gbWF5IGNvbGxpZGUgY2F1c2luZw0KPiBkYW1hZ2Us
IHN1Y2ggYXMgb24gQ2xlYXJmb2cgQmFzZS4NCj4NCj4gU2lnbmVkLW9mZi1ieTogSm9zdWEgTWF5
ZXIgPGpvc3VhQHNvbGlkLXJ1bi5jb20+DQo+IC0tLQ0KDQpQcmV2aW91cyB2ZXJzaW9uIGhhZCBy
ZWNlaXZlZCBhbiBhY2sgZnJvbSBLcnp5c3p0b2YgS296bG93c2tpLA0Kd2hpY2ggSSBkcm9wcGVk
IGJlY2F1c2UgSSBtYWRlIGFkZGl0aW9uYWwgY2hhbmdlcy4NCg0KVG8gc2ltcGxpZnkgcmV2aWV3
LCBwbGVhc2UgZmluZCBiZWxvdw0KdGhlIGluY3JlbWVudGFsIGNoYW5nZXMgZnJvbSB2MiB0byB2
MzoNCg0KRnJvbSA4ZTMyZGIzZDViNGZlY2VkOThmMjY2OTU3ODBjNTI1M2I5MjhiYjE0IE1vbiBT
ZXAgMTcgMDA6MDA6MDAgMjAwMQ0KRnJvbTogSm9zdWEgTWF5ZXIgPGpvc3VhQHNvbGlkLXJ1bi5j
b20+DQpEYXRlOiBGcmksIDUgQXByIDIwMjQgMTc6MzU6NTIgKzAyMDANClN1YmplY3Q6IFtQQVRD
SF0gYXJtNjQ6IGR0czogY245MTMxLWNmLXNvbGlkd2FuOiBtaW5vciB0d2Vha3MNCg0KMS4gbW92
ZSBsZWdhY3kgYXJtYWRhLTM4OCBuZXRkZXYgYWxpYXNlcyB0byBjYXJyaWVyOg0KwqDCoCBMZWdh
Y3kgcG9ydCBudW1iZXJpbmcgaXMgb25seSB1c2VmdWwgZm9yIHBsYXRmb3JtcyBwcmV2aW91c2x5
IHVzaW5nDQrCoMKgIHRoZSBhcm1hZGEtMzg4IHNvbSwgYW5kIGNhbiBiZSBhY2hpZXZlZCBpbiBj
YXJyaWVyIGR0cy4NCsKgwqAgU29NIGR0cyBjYW4gZm9sbG93IHNvYyBwb3J0IG51bWJlcmluZy4N
Cg0KMi4gRml4IHR3byBzdGF0dXMgcHJvcGVydHkgbWlzdGFrZXM6IG9uZSBkdXBsaWNhdGUgYW5k
IG9uZSBub3QgbGFzdA0KwqDCoCBwcm9wZXJ0eS4NCg0KMy4gQWRkIHBpbmN0cmwgZm9yIHNwaSBj
aGlwLXNlbGVjdCAxLCB3aGljaCBpcyBleHBvc2VkIG9uIGNhcnJpZXINCsKgwqAgbWlrcm9idXMg
aGVhZGVyLg0KDQo0LiBTcGVjaWZ5IHNwaSBidXMgbWF4IGZyZXF1ZW5jaWVzIGJhc2VkIG9uIHNv
bSBsaW1pdGF0aW9ucy4NCg0KU2lnbmVkLW9mZi1ieTogSm9zdWEgTWF5ZXIgPGpvc3VhQHNvbGlk
LXJ1bi5jb20+DQotLS0NCsKgYXJjaC9hcm02NC9ib290L2R0cy9tYXJ2ZWxsL2NuOTEzMC1jZi1w
cm8uZHRzwqAgfCAxMCArKysrKysrKysrDQrCoGFyY2gvYXJtNjQvYm9vdC9kdHMvbWFydmVsbC9j
bjkxMzAtY2YuZHRzacKgwqDCoMKgIHzCoCA0ICsrKysNCsKgYXJjaC9hcm02NC9ib290L2R0cy9t
YXJ2ZWxsL2NuOTEzMC1zci1zb20uZHRzaSB8IDEzICsrKysrKystLS0tLS0NCsKgMyBmaWxlcyBj
aGFuZ2VkLCAyMSBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEv
YXJjaC9hcm02NC9ib290L2R0cy9tYXJ2ZWxsL2NuOTEzMC1jZi1wcm8uZHRzIGIvYXJjaC9hcm02
NC9ib290L2R0cy9tYXJ2ZWxsL2NuOTEzMC1jZi1wcm8uZHRzDQppbmRleCAwYjk1ZDVmN2FjZmQu
LjE1Yzc0ZDU4NGRiZCAxMDA2NDQNCi0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWFydmVsbC9j
bjkxMzAtY2YtcHJvLmR0cw0KKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9tYXJ2ZWxsL2NuOTEz
MC1jZi1wcm8uZHRzDQpAQCAtMzM2LDYgKzMzNiwxNiBAQCByZWFyX2J1dHRvbl9waW5zOiBjcDAt
cmVhci1idXR0b24tcGlucyB7DQrCoMKgwqDCoCDCoMKgwqAgbWFydmVsbCxwaW5zID0gIm1wcDMy
IjsNCsKgwqDCoMKgIMKgwqDCoCBtYXJ2ZWxsLGZ1bmN0aW9uID0gImdwaW8iOw0KwqDCoMKgwqAg
fTsNCisNCivCoMKgwqAgY3AwX3NwaTFfY3MxX3BpbnM6IGNwMC1zcGkxLWNzMS1waW5zIHsNCivC
oMKgwqAgwqDCoMKgIG1hcnZlbGwscGlucyA9ICJtcHAxMiI7DQorwqDCoMKgIMKgwqDCoCBtYXJ2
ZWxsLGZ1bmN0aW9uID0gInNwaTEiOw0KK8KgwqDCoCB9Ow0KK307DQorDQorJmNwMF9zcGkxIHsN
CivCoMKgwqAgLyogYWRkIHBpbiBmb3IgY2hpcC1zZWxlY3QgMSBvbiBtaWtyb2J1cyAqLw0KK8Kg
wqDCoCBwaW5jdHJsLTAgPSA8JmNwMF9zcGkxX3BpbnMgJmNwMF9zcGkxX2NzMV9waW5zPjsNCsKg
fTsNCsKgDQrCoC8qDQpkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9tYXJ2ZWxsL2Nu
OTEzMC1jZi5kdHNpIGIvYXJjaC9hcm02NC9ib290L2R0cy9tYXJ2ZWxsL2NuOTEzMC1jZi5kdHNp
DQppbmRleCA1M2FlZGRkZjBlMjYuLmRjYmJkYmI5YjI1YSAxMDA2NDQNCi0tLSBhL2FyY2gvYXJt
NjQvYm9vdC9kdHMvbWFydmVsbC9jbjkxMzAtY2YuZHRzaQ0KKysrIGIvYXJjaC9hcm02NC9ib290
L2R0cy9tYXJ2ZWxsL2NuOTEzMC1jZi5kdHNpDQpAQCAtOCw2ICs4LDEwIEBADQrCoA0KwqAvIHsN
CsKgwqDCoMKgIGFsaWFzZXMgew0KK8KgwqDCoCDCoMKgwqAgLyogbGFiZWwgbmljcyBzYW1lIG9y
ZGVyIGFzIGFybWFkYSAzODggY2xlYXJmb2cgKi8NCivCoMKgwqAgwqDCoMKgIGV0aGVybmV0MCA9
ICZjcDBfZXRoMjsNCivCoMKgwqAgwqDCoMKgIGV0aGVybmV0MSA9ICZjcDBfZXRoMTsNCivCoMKg
wqAgwqDCoMKgIGV0aGVybmV0MiA9ICZjcDBfZXRoMDsNCsKgwqDCoMKgIMKgwqDCoCBpMmMxID0g
JmNwMF9pMmMxOw0KwqDCoMKgwqAgwqDCoMKgIG1tYzEgPSAmY3AwX3NkaGNpMDsNCsKgwqDCoMKg
IH07DQpkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9tYXJ2ZWxsL2NuOTEzMC1zci1z
b20uZHRzaSBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWFydmVsbC9jbjkxMzAtc3Itc29tLmR0c2kN
CmluZGV4IGVjMDgwNjZmYjZlOC4uOGYwMjM4YTQ1YTU4IDEwMDY0NA0KLS0tIGEvYXJjaC9hcm02
NC9ib290L2R0cy9tYXJ2ZWxsL2NuOTEzMC1zci1zb20uZHRzaQ0KKysrIGIvYXJjaC9hcm02NC9i
b290L2R0cy9tYXJ2ZWxsL2NuOTEzMC1zci1zb20uZHRzaQ0KQEAgLTExLDEwICsxMSw5IEBAIC8g
ew0KwqDCoMKgwqAgY29tcGF0aWJsZSA9ICJzb2xpZHJ1bixjbjkxMzAtc3Itc29tIiwgIm1hcnZl
bGwsY245MTMwIjsNCsKgDQrCoMKgwqDCoCBhbGlhc2VzIHsNCi3CoMKgwqAgwqDCoMKgIC8qIGxh
YmVsIG5pY3MgbGlrZSBhcm1hZGEtMzg4IHNvbSAqLw0KLcKgwqDCoCDCoMKgwqAgZXRoZXJuZXQw
ID0gJmNwMF9ldGgyOw0KK8KgwqDCoCDCoMKgwqAgZXRoZXJuZXQwID0gJmNwMF9ldGgwOw0KwqDC
oMKgwqAgwqDCoMKgIGV0aGVybmV0MSA9ICZjcDBfZXRoMTsNCi3CoMKgwqAgwqDCoMKgIGV0aGVy
bmV0MiA9ICZjcDBfZXRoMDsNCivCoMKgwqAgwqDCoMKgIGV0aGVybmV0MiA9ICZjcDBfZXRoMjsN
CsKgwqDCoMKgIMKgwqDCoCBpMmMwID0gJmNwMF9pMmMwOw0KwqDCoMKgwqAgwqDCoMKgIG1tYzAg
PSAmYXBfc2RoY2kwOw0KwqDCoMKgwqAgwqDCoMKgIHJ0YzAgPSAmY3AwX3J0YzsNCkBAIC04Miw3
ICs4MSw2IEBAICZjcDBfZXRoMiB7DQrCoH07DQrCoA0KwqAmY3AwX2kyYzAgew0KLcKgwqDCoCBz
dGF0dXMgPSAib2theSI7DQrCoMKgwqDCoCBwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiOw0KwqDC
oMKgwqAgcGluY3RybC0wID0gPCZjcDBfaTJjMF9waW5zPjsNCsKgwqDCoMKgIGNsb2NrLWZyZXF1
ZW5jeSA9IDwxMDAwMDA+Ow0KQEAgLTk2LDggKzk0LDggQEAgc29tX2VlcHJvbTogZWVwcm9tQDUz
IHsNCsKgfTsNCsKgDQrCoCZjcDBfbWRpbyB7DQotwqDCoMKgIHN0YXR1cyA9ICJva2F5IjsNCsKg
wqDCoMKgIHBpbmN0cmwtMCA9IDwmY3AwX21kaW9fcGlucz47DQorwqDCoMKgIHN0YXR1cyA9ICJv
a2F5IjsNCsKgDQrCoMKgwqDCoCAvKiBhc3NlbWJseSBvcHRpb24gKi8NCsKgwqDCoMKgIGNwMF9l
dGgyX3BoeTogZXRoZXJuZXQtcGh5QDAgew0KQEAgLTEwOSwxMSArMTA3LDE0IEBAICZjcDBfc3Bp
MSB7DQrCoMKgwqDCoCBzdGF0dXMgPSAib2theSI7DQrCoMKgwqDCoCBwaW5jdHJsLW5hbWVzID0g
ImRlZmF1bHQiOw0KwqDCoMKgwqAgcGluY3RybC0wID0gPCZjcDBfc3BpMV9waW5zPjsNCivCoMKg
wqAgLyogbWF4IHNwZWVkIGxpbWl0ZWQgYnkgYSBtdXggKi8NCivCoMKgwqAgc3BpLW1heC1mcmVx
dWVuY3kgPSA8MTgwMDAwMDAwMD47DQrCoA0KwqDCoMKgwqAgZmxhc2hAMCB7DQrCoMKgwqDCoCDC
oMKgwqAgY29tcGF0aWJsZSA9ICJqZWRlYyxzcGktbm9yIjsNCsKgwqDCoMKgIMKgwqDCoCByZWcg
PSA8MD47DQotwqDCoMKgIMKgwqDCoCBzcGktbWF4LWZyZXF1ZW5jeSA9IDwxMDAwMDAwMD47DQor
wqDCoMKgIMKgwqDCoCAvKiByZWFkIGNvbW1hbmQgc3VwcG9ydHMgbWF4LiA1ME1IeiAqLw0KK8Kg
wqDCoCDCoMKgwqAgc3BpLW1heC1mcmVxdWVuY3kgPSA8NTAwMDAwMDA+Ow0KwqDCoMKgwqAgfTsN
CsKgfTsNCsKgDQotLSANCjIuMzUuMw0KDQo=

