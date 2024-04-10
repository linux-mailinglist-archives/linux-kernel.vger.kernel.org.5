Return-Path: <linux-kernel+bounces-138151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A328089ED59
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 10:13:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C645E1C20AD8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 08:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD4013D61D;
	Wed, 10 Apr 2024 08:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="psZ/+hsd"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2131.outbound.protection.outlook.com [40.107.247.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2B11C0DD9;
	Wed, 10 Apr 2024 08:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712736819; cv=fail; b=hPvRaD5KJUUmPdFFzWOI3FrrX49vOeYBu6hsrGO+bZR+HcxV7jYIeCvIb0cBgTrf7ECOUMK9i7+8jszHBAaL9dDf4B2wSUSOflrY/XS7m2OX2a0CmROwGpkE8Ayt+VBjyL0CfjACzKRD6h6F+PLYW7LMZgy6TRGD4+oNwIaRVQU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712736819; c=relaxed/simple;
	bh=XK5WXoaPGP6K9sAQP3FvjjXrY7VP83mrZTLLtbQjuBc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PpOXtMEpBMgagE6+CWFI+NxTByz5TCSL+pG2SfPpPF6YkH0J7Fzue0WstzSVzogfWfcPcaOnbGdD7YC2f3vCubpejWBhAsZEBjpcqWlGq69rWg1Ew5NFkqA4ot4UFLf5QYFA2RlgDKXB1sfhe+nRSUwNr24naQWnGyBHLYQjSVk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=psZ/+hsd; arc=fail smtp.client-ip=40.107.247.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jCIdRTBjeWosfqtsV/Bq+8d4+eJbX/+jsz1L/io7xTSAZODr/f1uBlAuDNb1y89Dbjuk664qcaT4V0eqLFqXv0l7+tL2nEWyh148pMOFKBdTJmwukSLAWKrotCCgf/A/5qjGK4GMchSrKJ518TT+P44Pkl9RzcS37SDCnpPnrSUVEcwiScXrhMvV8auYLnv1MPJ73j0ZXO/RsVWEBJpLJmrzVaFuyjRMjxhwDKfYzMit4R1RAfUl9m5dHJTVT/eq2yTfdpz08SkoWLX/fkzhjxEmRRjuX+67EewESoAEUdL2cgO6xFPiCr8EyFOIP2+L9tNYSHHnRqojR502xhBtdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XK5WXoaPGP6K9sAQP3FvjjXrY7VP83mrZTLLtbQjuBc=;
 b=Y8r8J3TjEivSq4yMJDxQMaKX0L9WhNfwPc3NlrsdPJ0xXRx0SN9XR6I1ClW7FfjI4zJXbC9wm5Lh9Am2fpRSC8ZpVBXU0oM8hAPQDsx3zgOWJltl5KwCXzrlLRegmQS1pBg3/uYL6k+kSkYcNnne+/D/HXCixdhMAXrNpjRzbALspIFV3f7A60C+g/SQLCxXhR8+kVCN74+WlSpB+N/QcommMgHU5vRjVsKhm1JgNhrW+ZycOo9Cl1uvOaUKSTuR5HzGGl9R00QTbIZvfeEKG7C7TE05y862MwsG2558jO6hRoUj+5VwOlzifucAyY8ZF1fUlujiQh1zjXb7+5l4hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XK5WXoaPGP6K9sAQP3FvjjXrY7VP83mrZTLLtbQjuBc=;
 b=psZ/+hsdhYjvPLhwPmHPLHMe3MKj33ZIImhdpakHoVDwOuiwHe1FryOeWGgYLEvnQIXUkRBFNKTWtdbQNgnKIbbP5LyAZrLqlRGTmDis4XZTo3O1xpr7ETt5hww3bv9gU3Dq6tZFWJ4VKVKqFZcIdvmvWmsOy2l+Je9Ri7tTbus=
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by DBBPR04MB7547.eurprd04.prod.outlook.com (2603:10a6:10:208::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.54; Wed, 10 Apr
 2024 08:13:34 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::e60b:413c:25cd:c03b]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::e60b:413c:25cd:c03b%5]) with mapi id 15.20.7409.053; Wed, 10 Apr 2024
 08:13:34 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	"marcel@holtmann.org" <marcel@holtmann.org>, "luiz.dentz@gmail.com"
	<luiz.dentz@gmail.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Amitkumar
 Karwar <amitkumar.karwar@nxp.com>, Rohit Fule <rohit.fule@nxp.com>, Sherry
 Sun <sherry.sun@nxp.com>, Luke Wang <ziniu.wang_1@nxp.com>, Bough Chen
	<haibo.chen@nxp.com>, LnxRevLi <LnxRevLi@nxp.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: net: bluetooth: btnxpuart: Add
 firmware-name property
Thread-Topic: [PATCH v2 1/2] dt-bindings: net: bluetooth: btnxpuart: Add
 firmware-name property
Thread-Index: AQHaix77rfrCBpdMREKddCJ7Ov/Jmg==
Date: Wed, 10 Apr 2024 08:13:34 +0000
Message-ID:
 <AS4PR04MB9692C8CEB08D7AE01CDDE789E7062@AS4PR04MB9692.eurprd04.prod.outlook.com>
References: <20240408132241.750792-1-neeraj.sanjaykale@nxp.com>
 <20240408132241.750792-2-neeraj.sanjaykale@nxp.com>
 <e9cef5dd-c4fc-43c0-839b-d311d87a28ca@linaro.org>
In-Reply-To: <e9cef5dd-c4fc-43c0-839b-d311d87a28ca@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9692:EE_|DBBPR04MB7547:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 8i1MLBTesIDKByMwBJvrKuftrbzBLSa3FpP9RTtRQQxHLzk4kClf5T3oB+MQghl4cqTFJrVYTXMWKGk5DtDcurIHys4NhmHex2rseeH+uO4760l1/zl5kEaO6/B7EduXTJhSxCa9x19rZJPzc+QRxn1Ri4fljkbs3+v1sXKXNX9CT8trLNfBM+pUmXud7EbL+N+z0sbZT/UEftVqwZSTgxdZ25xjmrD7SlaTrPb6U2GokouIo1VgvMAvsEZHHHu9umTKE4btyNwjN0SwbqJxckjt62us+QYJoHIN3vJJwll4heBTmvaAO1iUpKQpTZnsrZkqMLmhhXMEr+ojL9fDMmk1CcyienFvrVEpqeyxaYQaU6ie6PTGQe67+llAKdIgcSvaNYJO03QdGQ+2q5Wyn/xZ7NwV5u3cV8WWwVbUpHjTtJ7PiGfpYaw0RD0F6ugAXUYFC26oLvrJ+jR4/UpIemPn06dkPwoRipLMUjLk8PY+Y00zj/7DXYozdA1B0A/RHa22b2PPDsRBQlrH6xn/8kI+WN/hqGEzAQVQ+2fQPySnLLTuk5qqTs1S5C8+/kTMokWT+Z9YCLKaYKUPjs/OXfA1zPjw3tGkttNk/l6yBs1HUaXVbfurWrEk0xIWK41LnnpFbbZUbk7PL9FVfXZC7Wn5kiDcoPHd8uEp4+62URXR8LX/NpbIc7Bxu/5yJyxK1INmDGC1OPxix1JecdNkMw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005)(921011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QU9IOUJFMnBNbEpxY0dsVmVCSzd0WGdrc3FxcGNPTmtLakhacFJkUkJNZ2lo?=
 =?utf-8?B?MHJJUjB4WWVLakRaWWpTRUo5ZGlyZzZPRmxLKytvQXBQSVpWeDhlVEtlTVBB?=
 =?utf-8?B?MFNRSmVmWTQvcGQyb09Cem9MUHpPZnUwVWVES1hzU2l5V3RnZnF2NkNUeENa?=
 =?utf-8?B?b2xiOGQ2YXYySmZWYzA4eHAvRkRzWEp6VklPZHNrZkFnK2JRclBIQ2Nvb0JN?=
 =?utf-8?B?RERaNW8zbTY1dVo1ekRqZGVRbzFvdWVQUHlHaEtKTVBpejdwQVRXRHJRd2pY?=
 =?utf-8?B?MUJPenBKN2F3aUlsQktRVWhoMFMwcy92NnB4ek85YUpNRHFxMWtFS0prUkhX?=
 =?utf-8?B?WVdZeHJ5RXorUHJ5SE5oSGdmUzAwYlRaSGRwNE5Rcm1aOVpEWndBMXVHTFRs?=
 =?utf-8?B?VUErUWI4Q3lmaG9BUk5MU3RBOVd0Sk5McjM0emVTUXdPaXowOFM3SnVPNVpL?=
 =?utf-8?B?K3FTSFZSVkp1NHRNbWV0SEgwckY0ajkvYzZEQW1iRmE0L3MzRDAyYnJMNkRF?=
 =?utf-8?B?SWhpaXNFVkFQWCtMWE1mWFFSaDV6N0U1TnBpdVRzV3VKT3p5OC9ERWowWStY?=
 =?utf-8?B?QVhVMHRPOUM4VUwzZ2d2ZG9ZSTdpamFVa0NNN2ViZUx6Z2VrUWEvdFJLemhl?=
 =?utf-8?B?K2V6U0M4d2lleDRQSU1EemU3ZlRNV0lERjEvaFNnMmVpRjFUNEVsdGYyQU9F?=
 =?utf-8?B?RkhPK0x3aUxZOERvTmp3ekhBZnVISHdLeGl6bzUxbGU1Mm1STGY0QWhhMTlI?=
 =?utf-8?B?TmVwZVhxVC9uU2M3c0xkaWZuR24vMjNYRWJhNm5reE1hMnN1c1NDZnhyQ0Np?=
 =?utf-8?B?THZLckxVK1BJcnptSDUrL0NvWmVlQitVZ0gvaVRlS3pyMkphbm40RDdwaXUv?=
 =?utf-8?B?ZmFvK1RjTUtNbnFyZC90dWhyOVBnTkgydWRZdzV1bUZPSWgvRlhKSlA0aDNz?=
 =?utf-8?B?aThGaExVMVg5V3VPdDZoOUowY2dCU25WZlFjdTZOUG9NdWJYUHVGbEJUVDdF?=
 =?utf-8?B?UjVzTERHNGRGUnFleGRhUjBZTTJaS0JlNXVHU29hR3Y4R1NqRkhJUUowRVdK?=
 =?utf-8?B?NEFHRWVHYWEzVzcvdlpHanM2SE90YzlPRjdLS0MxWjlqNldxNS9ldUFVUFdV?=
 =?utf-8?B?bVJ2SFI2cWdZUDlYbUlMSUpCTnZwUkxCRTVHNVJka0VscU1PdEpJdDZYRjZ2?=
 =?utf-8?B?bEdjcFpMT2RzLy9PNitUaXJWR1E3Sm1aOFRZQlRsandGNU9CQ29LWjNnNW9a?=
 =?utf-8?B?V3RwVEdhQW5CME5Famk2RFU4Yi9LM2Q2dmk4VDlkOFVvU2M5UE1GZmZSam8r?=
 =?utf-8?B?N2oxUWl1bS9nTWo2OXhDNzNZSCtGQkdwWWRHOC93aVpZcVZUcENPTmhkeS9x?=
 =?utf-8?B?MUFDK21QNlJUeEVnRFA2WWJVNVZQd2tHcGhRWW4yYk9UU3ViOVFCeWlEblkz?=
 =?utf-8?B?bGxYaFV0bXk5citHUlhFTzJqNVRvUGU0Q2YrN2FUQVJsbTZscmV4RlFhWVE1?=
 =?utf-8?B?VWxoMHFwNStrTEJOdm4zdFRkQVNhTDYrdkdtb3UxOExWOHJ1SjBkckdEVGc4?=
 =?utf-8?B?VE1oOTBESFQ5dUtQNnpzdkdnMDlWd016dmp2bW4ydGtWS1lpcktvN0FRRU0r?=
 =?utf-8?B?T3JLU3ZqajV0WHJBbWlVY2IrNXRld2xsM2R3UVB1bFlHbm1Jbzg5a3NWeVgx?=
 =?utf-8?B?cWVjYnF4VDJab0x2UG1SZnlKV3lWWGlCNitFWWdxbUZVNnd0bUV1djFlYWo0?=
 =?utf-8?B?bnN2bGVRMTlFdTlOOGRGMmdKSTYxdDZsejA3RCtXalJjbWU2clBETGNidC96?=
 =?utf-8?B?dUNqUXMzMjZWL1h2ZmtzSFh4T2VRYndTTUk2L1E3akU4cTlxV1ZYOHliUkdP?=
 =?utf-8?B?QTg5citYczk2UERFOWQwTCt5bkFiQmErTXVnWVhvTk90WWlFRCtzWEQ1QzlE?=
 =?utf-8?B?MU11MVhLOFp6YVVia1c4WkUwcVlDZEU3N1kxb2NRaTIyQlY4WWNGSm1GM0Rk?=
 =?utf-8?B?Y0pYNENsMWFzUlBJT25wMWtIOTZ0UlZjTzdoWU1zMkVEeUhTSXNmR2NLT1l5?=
 =?utf-8?B?M0lhNktwak0rUzRIa1ByQVl2QktURGc3eHB1ajhKSlN0Ny9HQ3BEUUlzWEk2?=
 =?utf-8?Q?s4A5+m+OdZMNLp5O5Y1zqFjJA?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 232c3554-576e-4c39-fc75-08dc59361de8
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2024 08:13:34.4283
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v1CcVFftihtsTyoVlIjCuCq2Ss4gZjCU6M9V+q6oWBAJ2w7ju0xTCdwS4O2gjlum7g92N73m1sxLV5eGlP83/V4MbepojQK2dvpZbPd9qi4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7547

SGkgS3J6eXN6dG9mLA0KDQpUaGFuayB5b3UgZm9yIHRoZSByZXZpZXcuIEkgaGF2ZSBtYWRlIHRo
ZSBjaGFuZ2VzIHlvdSByZXF1ZXN0ZWQgYW5kIHNlbnQgb3V0IHRoZSB2MyBwYXRjaC4NCg0KVGhh
bmtzLA0KTmVlcmFqDQoNCj4gDQo+IE9uIDA4LzA0LzIwMjQgMTU6MjIsIE5lZXJhaiBTYW5qYXkg
S2FsZSB3cm90ZToNCj4gPiBUaGlzIGFkZHMgYSBuZXcgb3B0aW9uYWwgZGV2aWNlIHRyZWUgcHJv
cGVydHkgY2FsbGVkIGZpcndhcmUtbmFtZS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IE5lZXJh
aiBTYW5qYXkgS2FsZSA8bmVlcmFqLnNhbmpheWthbGVAbnhwLmNvbT4NCj4gDQo+IEJUVywgdGhl
cmUgaXMgbm8gc3VjaCBkZXZpY2UgYXMgYnRueHB1YXJ0LiBCaW5kaW5ncyBhcmUgZm9yIGhhcmR3
YXJlLg0KPiBXaXRoIGNvcnJlY3RlZCBzdWJqZWN0Og0KPiANCj4gUmV2aWV3ZWQtYnk6IEtyenlz
enRvZiBLb3psb3dza2kgPGtyenlzenRvZi5rb3psb3dza2lAbGluYXJvLm9yZz4NCj4gDQo+ID4g
LS0tDQo+ID4gdjI6IEFkZCBtYXhJdGVtcywgc2ltcGxpZnkgZGVzY3JpcHRpb24sIHJlbW92ZSAi
bnhwLyIuIChLcnp5c3p0b2YpDQo+ID4gLS0tDQo+ID4gIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdz
L25ldC9ibHVldG9vdGgvbnhwLDg4dzg5ODctYnQueWFtbCAgIHwgNiArKysrKysNCj4gPiAgMSBm
aWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdA0KPiA+IGEv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC9ibHVldG9vdGgvbnhwLDg4dzg5
ODctYnQueWFtbA0KPiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC9i
bHVldG9vdGgvbnhwLDg4dzg5ODctYnQueWFtbA0KPiA+IGluZGV4IGYwMWEzOTg4NTM4Yy4uNjc3
NGNjNGQ2YTllIDEwMDY0NA0KPiA+IC0tLQ0KPiA+IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL25ldC9ibHVldG9vdGgvbnhwLDg4dzg5ODctYnQueWFtbA0KPiA+ICsrKyBiL0Rv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9uZXQvYmx1ZXRvb3RoL254cCw4OHc4OTg3
LWJ0LnkNCj4gPiArKysgYW1sDQo+ID4gQEAgLTMxLDYgKzMxLDExIEBAIHByb3BlcnRpZXM6DQo+
ID4gICAgICAgIFRoaXMgcHJvcGVydHkgZGVwZW5kcyBvbiB0aGUgbW9kdWxlIHZlbmRvcidzDQo+
ID4gICAgICAgIGNvbmZpZ3VyYXRpb24uDQo+ID4NCj4gPiArICBmaXJtd2FyZS1uYW1lOg0KPiA+
ICsgICAgbWF4SXRlbXM6IDENCj4gPiArICAgIGRlc2NyaXB0aW9uOg0KPiA+ICsgICAgICBTcGVj
aWZ5IGZpcm13YXJlIGZpbGUgbmFtZS4NCj4gDQo+IERyb3AgZGVzY3JpcHRpb24sIHJlZHVuZGFu
dC4gWW91IGRpZCBub3Qgc2F5IGFueXRoaW5nIGRpZmZlcmVudCB0aGFuIHByb3BlcnR5DQo+IGlz
IHNheWluZyBhbHJlYWR5Lg0KDQo=

