Return-Path: <linux-kernel+bounces-23554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E160682AE60
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 13:07:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FC311F250BE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 12:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF0E15AF6;
	Thu, 11 Jan 2024 12:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gZ2N/PCr"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2072.outbound.protection.outlook.com [40.107.243.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECAD156C1;
	Thu, 11 Jan 2024 12:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NgOi6VRj8aF7+PvDociB2i+K1/sVdAd3pW/FVesTzp7KRgLFdMYc83SuN2XiariBvpX2JJLXZZ+6Ek9t1qpIwdcjlZe922s5l6r4eKOvh4WgLRrXqMEvCWU1sM6j5O7FpvCjoIl3pFp4cBPiyiT8cADQpx2kcBrC+Pk7Ll2vuaVWBIIGQ0DdqRbqRxTFOG7BWlOsO5mkHFwJVgA3BsaroXmS+GR+0DhnWwVLIGtdN09KlxK+UOakB2HFO1ShiR6untW/lsun5S4eGAfKT58k8UdNzXHIc91xyr2iquU27pfvnc3ddlhAyw9whLCPAkpiiLlZihdY2aPaAwSYDfMiMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=haBQFeI960uq9/zuPCpyLs6G7axIW/yoS9TNYU1Whvo=;
 b=O2TPxX5VDFZGC8gDSWhAjIX8QPAsvv90757UW+5vO1UHyx0UKsgCGf3z+VApoF33e3B9QXFqeARzdJHAohwEsnRvj7tBUcvoh5SHf6AN5e/pdPp0aHxFhKFrEZwwEhIQZCVAF8LY4ax8dUxoiBw1I74fZ5AxjqFBHhyiLqApaguCKWizojCox54bO5/T5LAoJcJNCsJQizkOp86ah1flvlhsQaLa8fV6o3AUi95KHgtbkVUA2JF/RfzT7+uwddK7p4JgJ5sj8IDkoMqY5zK8cIIkP2pYjo+zj2JNE85fYdz98SZKAVtBrmknfeHKwdb7O/XOvwmwIbKmZiknJJfslw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=haBQFeI960uq9/zuPCpyLs6G7axIW/yoS9TNYU1Whvo=;
 b=gZ2N/PCrgfy2Mu1ucI7/Ha9Jcdveip2bBxsoodmwNG7F5bNKxNtm0JElBZbQ0zB2OQNLhBKhCHAMKJ+r57qkoAldP7T7ef+EyjGkRFtldkLgE0QP17qdt36ITxW1btqAvcsRhie0F5XizjQSj6hENe8dtJedaCTcAe9ZE6LxjkaZ27T8l+dY87IcOpx1NNnM7fpNpIlbQ9EmkF3CbdOkIMQMBAyZ9UNAtdrhtau912jX50sA1tY9a4F3x5RU0qIJmkW1ZEaKA8ew6qLhaaqsxq1vvsC4iR2nJeDrQ0rJpPTzu+qiOyj/kCVs2QS1aNqBiCoB+dvTAWat7GWoV4VAOg==
Received: from SJ1PR12MB6339.namprd12.prod.outlook.com (2603:10b6:a03:454::10)
 by CH3PR12MB8711.namprd12.prod.outlook.com (2603:10b6:610:176::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Thu, 11 Jan
 2024 12:03:44 +0000
Received: from SJ1PR12MB6339.namprd12.prod.outlook.com
 ([fe80::f013:4a74:215f:1127]) by SJ1PR12MB6339.namprd12.prod.outlook.com
 ([fe80::f013:4a74:215f:1127%5]) with mapi id 15.20.7159.020; Thu, 11 Jan 2024
 12:03:44 +0000
From: Akhil R <akhilrajeev@nvidia.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	"herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
	"davem@davemloft.net" <davem@davemloft.net>, "robh+dt@kernel.org"
	<robh+dt@kernel.org>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>, "catalin.marinas@arm.com"
	<catalin.marinas@arm.com>, "will@kernel.org" <will@kernel.org>, Mikko
 Perttunen <mperttunen@nvidia.com>, "linux-crypto@vger.kernel.org"
	<linux-crypto@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "krzk@kernel.org" <krzk@kernel.org>
Subject: RE: [PATCH v3 1/5] dt-bindings: crypto: Add Tegra Security Engine
Thread-Topic: [PATCH v3 1/5] dt-bindings: crypto: Add Tegra Security Engine
Thread-Index: AQHaQty8WUOo2fm6nUaPedKENGTHjLDRmWYAgALs+cA=
Date: Thu, 11 Jan 2024 12:03:43 +0000
Message-ID:
 <SJ1PR12MB6339FB3D45FE00C7D8F3B997C0682@SJ1PR12MB6339.namprd12.prod.outlook.com>
References: <20240109091708.66977-1-akhilrajeev@nvidia.com>
 <20240109091708.66977-2-akhilrajeev@nvidia.com>
 <d9a1695a-3747-4fb9-b76e-c2599266a3c1@linaro.org>
In-Reply-To: <d9a1695a-3747-4fb9-b76e-c2599266a3c1@linaro.org>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR12MB6339:EE_|CH3PR12MB8711:EE_
x-ms-office365-filtering-correlation-id: 1817d071-07bb-4980-471c-08dc129d5bdf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Zos/r/ggOY7NP/O96z14jNmO0E+/vd4NSx3JaG+B3sCqsb8l2TXFVXJdw1YwA9biyCAea/CBpJAdp/6bJ+VW0hLn1MX45AhTfds/G6DZW1efkCriZLpDQhqHrncBNOvaXEJQhFr1XpaPrc+YLC2ScmVpmrGXIMYn43AmMshqrrke+gFzXwZWLtEkt+NlvGROhJgMoBnbZ82NqK+o1z/o/rsXcs0jNW9C/ISY7VmYq7iYE9cgCDz/L9/Eb3+oZTnNQdLmZTYybXRiEprUV6wHBFcwxV9e5VN161I8soE9BTjVyZtgAIAJArwkI+L1OyzDXAs6X1i+bTd6Dp8OOJN0iKt85c5lE8eEUAYbS23LafPhMfUQe821+ds38AgS/KLGTvySKWYH42dCFrKf387V2tGYt+O4MHbbnt30XMRbMBPvlBKccQI/FEVzuPJN4kBVUIr+au+FWfjMc+7rMXp13UnwUnUbIHFJaefHz8SxaT+DTJK4Poe8XD/dAW2KbDxGQwelaIUTko0q40QEZH5sYjtTuLyLJ4ejOYsOCLiN5FonBQD7/BNngtPYIOQCh09tLYddnLW1mU6Z1EbOqH0A1yDqZu0W40hYNZepZ7Pb+tLuywFu09n1rfKU8QjmNf8/uuqs123CNugR3MRHgdS7Z4FfMLpBo6KSUMYuu63V6ECnzzjp0Dg9bE+U/R6982Cv
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6339.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(376002)(346002)(136003)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(55016003)(9686003)(83380400001)(86362001)(33656002)(38070700009)(921011)(38100700002)(71200400001)(5660300002)(15650500001)(7416002)(52536014)(7696005)(53546011)(6506007)(122000001)(8936002)(66476007)(110136005)(64756008)(316002)(8676002)(966005)(76116006)(66446008)(2906002)(41300700001)(478600001)(66556008)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?S2plL3RHSWVaOVBtQ2FLeTJpREtiZFdZMENUcVlON0M3ZzFEQjE1MDN4RFNS?=
 =?utf-8?B?cUVENm8rMmh6Vm5idmhiN3NBbkRUWmFOSEw5REpFbVB5UjBOMEFpSUVaUmdD?=
 =?utf-8?B?MUV0TmxJL0JDRGIwVlI1OGZHMXBGNGRqWFpUSzNVNThYS0Zoa2VqVWZBUThJ?=
 =?utf-8?B?emlkV0ZxdnlMR2xncWowOU4wQWxSdWswR2xremJKWWpKTW5Rd3NYNzM4b3J0?=
 =?utf-8?B?TzdwMCtLdnJPNTVtUm9MenM3VFZKcWMxdDBxMlJ6U2dBUGJoUEQ1UG1NSGQw?=
 =?utf-8?B?RFo3bDI4eEtONFB4VFQ3N2xlTWd1YjBMaExDYkZOVWFVUkoxZ0txZjJGcG90?=
 =?utf-8?B?WXVkWjV5Q0NQTzF3R3NoUGNUYUxpOXpnS2daYzBqS2dXNFpXWmk4Q1RmTUxV?=
 =?utf-8?B?TGhwbDRHb0cvMGRLbkN5RVhKWFFsaXFuTkJ3VmY5SzVtWDZiNHFkY0phcEZn?=
 =?utf-8?B?MFN5L0N4OEpBS3o0L1pGZHVoWUpOOGVJNm44M0dLcEdVU09NdGJ4dU40c1dy?=
 =?utf-8?B?VVl2WHRtemNJNWMwN1FHT1ZqRG92UjdaeVk2alNOTUJZaVR3cENQczlVbzNm?=
 =?utf-8?B?SUF5aDFYWTFUSCswdU5ld2dscWZrUU9uemVIdzZSZkwxNWk5TnhqVDY1NUd1?=
 =?utf-8?B?NGY5bkMyN056dTRzcDJ3RFgyWnI1dmFDNWhIZkwxSGNtdUpvOU1WQTdoSGV1?=
 =?utf-8?B?a2dSdVpZNFVoNk9MYWc1d0NyaW9ac25MU1RvVzVZeVNaaVdmQTZzM2NzZlFw?=
 =?utf-8?B?WnZ0MWk3dC9Zd2VNNzhhWXlnVGVKbGdjZFN5d28xN1J2T3ZhcmZaYjN3bUs1?=
 =?utf-8?B?VkVQNXhEZnV5R09YVHNxRGNhRUFFQUlhV3o3bjNJbVNtNzFzU1B4OWlEb2Nl?=
 =?utf-8?B?bUlZVEI1QU9raXVtUUxpUEhjb2w0UmlvajBPcVF0dlhtcmFaY1dJMUhBOHZE?=
 =?utf-8?B?ZFZhUG1MclZuM3F6T1Q1U3lGSDVoUmlOYzZsWkptcU50RlF1VURnbTJmbVlK?=
 =?utf-8?B?cGRkRzNTL0E4TGZCL2NncWhQUkowYkJvMXpwbkp0SWg3empYMFU2UFRESDhL?=
 =?utf-8?B?UEFuK1JRTG9LRGVHZTZJeXo1NXU5WW1CNkluUlMrNGNDYzhUVmNFdnl4SjJC?=
 =?utf-8?B?Mk9qRFBOZlNPS2ZaK0NwTXl3c0tQTlFxOWF0OHQ2Q2oxYitlM3VtdGVLRmVl?=
 =?utf-8?B?RTgxY0NiY0xGWlFISkFIOTZsK3gxNEF3UFNZaWVocDkyeENSQW1McHV3VlhW?=
 =?utf-8?B?cHhyZXVKTkNzMlduRldNSmJCdUpqcy9DVDV5QjEvS0tqckM3V3VmczZadlc2?=
 =?utf-8?B?VmRXM1ptR1dtZ205WDYrVGtBaGpndWh6c0RzaHZBM0FZR1g5bUhyblJuTCto?=
 =?utf-8?B?SFVRZXB1SUlpeExndXNEUGxMYXRpeFJqMWM1eWJKcEdlZEZhaXJQOWZWb2ps?=
 =?utf-8?B?Z1RmL3EwbStIUVd6L1VEUXFwSFRtNkM3YWxXMW5hUjNWN1N1TFlMZEJJUUhK?=
 =?utf-8?B?aEtHZDVicVFObVZYSThpS2pVVndJdE0vdFpPbUdUcGZkS2JRUjVzMHFmQTRY?=
 =?utf-8?B?TmhNWVpaaXdYMGpQR2JHV05MRDJYeXBmQit2QWRGSDNmeEwyMFpocG5vaDhj?=
 =?utf-8?B?c1NFbDByaTJYWXV2TE8rOUQyaHZ1RDNHUEtraSsvaTJQdW9qbDBkSUoyWURl?=
 =?utf-8?B?TDFraGo5TGNXd0JpWW9MdFJJYU5WVnlrQ2o3bUxhaTdNaUFxQ3FvTXR5RVBV?=
 =?utf-8?B?V3VSV3pYV0ZZL09RVWRsTDVwc0F4R0dWVmRPQVFpWGNFeU1tdUlmbk5Pcndu?=
 =?utf-8?B?QUhybVNQdC9OTGJEVG9mblRQY2RHTCtJeHlpYlZHNTYzWjFCbjFCcWtPcUZU?=
 =?utf-8?B?RENRZGRKUjlPNSs0N2ZFMW1pekEwblNuRlJsTWtGbGZYaGREbFZaazBHVDcr?=
 =?utf-8?B?VjdVMzczUlhna1hidTRGTit4bFhIazhOUjdFZUIzdFN4NlphMDZIamhCR2I5?=
 =?utf-8?B?R3BMVUpCbVBhSUdZL3ZGbzFUSVpiUG5PT2VQeVFEVVd0VVJ3NWltdm1Ncnpm?=
 =?utf-8?B?bFV2WDhMWEJOOEhZOFE1WmdkWjZnNUtUN25XTjN2MUNtcU5PYUFCMlZ2QUxr?=
 =?utf-8?B?NFhJZ0EyVzJnZ2JvbnM3NURuY0Y4N3FNUWlyQnE3RWg2M2ovdHJoaHdqaVpz?=
 =?utf-8?Q?mxxzkUUIbBPGvgTzvCqefObP3e148VJqGQlhwOEl/OfA?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6339.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1817d071-07bb-4980-471c-08dc129d5bdf
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2024 12:03:44.0034
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3N68vMaHtxsXo7/FHwNNXMeFnI2xvaHxpJR0HtungtQQBMCy5o3UZnwtsLYk/qfcbNI3W8o0zz4CDSbNg33MIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8711

PiBPbiAwOS8wMS8yMDI0IDEwOjE3LCBBa2hpbCBSIHdyb3RlOg0KPiA+IEFkZCBEVCBiaW5kaW5n
IGRvY3VtZW50IGZvciBUZWdyYSBTZWN1cml0eSBFbmdpbmUuDQo+ID4gVGhlIEFFUyBhbmQgSEFT
SCBhbGdvcml0aG1zIGFyZSBoYW5kbGVkIGluZGVwZW5kZW50bHkgYnkgc2VwYXJhdGUNCj4gPiBl
bmdpbmVzIHdpdGhpbiB0aGUgU2VjdXJpdHkgRW5naW5lLiBUaGVzZSBlbmdpbmVzIGFyZSByZWdp
c3RlcmVkDQo+ID4gYXMgdHdvIHNlcGFyYXRlIGNyeXB0byBlbmdpbmUgZHJpdmVycy4NCj4gPg0K
PiANCj4gLi4uDQo+IA0KPiA+ICtyZXF1aXJlZDoNCj4gPiArICAtIGNvbXBhdGlibGUNCj4gPiAr
ICAtIHJlZw0KPiA+ICsgIC0gY2xvY2tzDQo+ID4gKyAgLSBpb21tdXMNCj4gPiArDQo+ID4gK2Fk
ZGl0aW9uYWxQcm9wZXJ0aWVzOiBmYWxzZQ0KPiA+ICsNCj4gPiArZXhhbXBsZXM6DQo+ID4gKyAg
LSB8DQo+ID4gKyAgICAjaW5jbHVkZSA8ZHQtYmluZGluZ3MvaW50ZXJydXB0LWNvbnRyb2xsZXIv
YXJtLWdpYy5oPg0KPiANCj4gVGhpcyBkb2VzIG5vdCBsb29rIHVzZWQuDQo+IA0KPiA+ICsgICAg
I2luY2x1ZGUgPGR0LWJpbmRpbmdzL21lbW9yeS90ZWdyYTIzNC1tYy5oPg0KPiA+ICsgICAgI2lu
Y2x1ZGUgPGR0LWJpbmRpbmdzL2Nsb2NrL3RlZ3JhMjM0LWNsb2NrLmg+DQo+ID4gKw0KPiA+ICsg
ICAgY3J5cHRvQDE1ODIwMDAwIHsNCj4gPiArICAgICAgICBjb21wYXRpYmxlID0gIm52aWRpYSx0
ZWdyYTIzNC1zZS1hZXMiOw0KPiA+ICsgICAgICAgIHJlZyA9IDwweDE1ODIwMDAwIDB4MTAwMDA+
Ow0KPiA+ICsgICAgICAgIGNsb2NrcyA9IDwmYnBtcCBURUdSQTIzNF9DTEtfU0U+Ow0KPiA+ICsg
ICAgICAgIGlvbW11cyA9IDwmc21tdSBURUdSQTIzNF9TSURfU0VTX1NFMT47DQo+ID4gKyAgICAg
ICAgZG1hLWNvaGVyZW50Ow0KPiA+ICsgICAgfTsNCj4gPiArLi4uDQo+ID4gZGlmZiAtLWdpdCBh
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9jcnlwdG8vbnZpZGlhLHRlZ3JhMjM0
LXNlLQ0KPiBoYXNoLnlhbWwgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvY3J5
cHRvL252aWRpYSx0ZWdyYTIzNC1zZS0NCj4gaGFzaC55YW1sDQo+ID4gbmV3IGZpbGUgbW9kZSAx
MDA2NDQNCj4gPiBpbmRleCAwMDAwMDAwMDAwMDAuLjdmYjMyNTY4NzU2ZA0KPiA+IC0tLSAvZGV2
L251bGwNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvY3J5cHRv
L252aWRpYSx0ZWdyYTIzNC1zZS0NCj4gaGFzaC55YW1sDQo+ID4gQEAgLTAsMCArMSw1MyBAQA0K
PiA+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiAoR1BMLTIuMC1vbmx5IE9SIEJTRC0yLUNs
YXVzZSkNCj4gPiArJVlBTUwgMS4yDQo+ID4gKy0tLQ0KPiA+ICskaWQ6IGh0dHA6Ly9kZXZpY2V0
cmVlLm9yZy9zY2hlbWFzL2NyeXB0by9udmlkaWEsdGVncmEyMzQtc2UtaGFzaC55YW1sIw0KPiA+
ICskc2NoZW1hOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvbWV0YS1zY2hlbWFzL2NvcmUueWFtbCMN
Cj4gPiArDQo+ID4gK3RpdGxlOiBOVklESUEgVGVncmEgU2VjdXJpdHkgRW5naW5lIGZvciBIQVNI
IGFsZ29yaXRobXMNCj4gPiArDQo+ID4gK2Rlc2NyaXB0aW9uOg0KPiA+ICsgIFRoZSBUZWdyYSBT
ZWN1cml0eSBIQVNIIEVuZ2luZSBhY2NlbGVyYXRlcyB0aGUgZm9sbG93aW5nIEhBU0ggZnVuY3Rp
b25zIC0NCj4gPiArICBTSEExLCBTSEEyMjQsIFNIQTI1NiwgU0hBMzg0LCBTSEE1MTIsIFNIQTMt
MjI0LCBTSEEzLTI1NiwgU0hBMy0zODQsDQo+IFNIQTMtNTEyDQo+ID4gKyAgSE1BQyhTSEEyMjQp
LCBITUFDKFNIQTI1NiksIEhNQUMoU0hBMzg0KSwgSE1BQyhTSEE1MTIpDQo+ID4gKw0KPiA+ICtt
YWludGFpbmVyczoNCj4gPiArICAtIEFraGlsIFIgPGFraGlscmFqZWV2QG52aWRpYS5jb20+DQo+
ID4gKw0KPiA+ICtwcm9wZXJ0aWVzOg0KPiA+ICsgIGNvbXBhdGlibGU6DQo+ID4gKyAgICBjb25z
dDogbnZpZGlhLHRlZ3JhMjM0LXNlLWhhc2gNCj4gPiArDQo+ID4gKyAgcmVnOg0KPiA+ICsgICAg
bWF4SXRlbXM6IDENCj4gPiArDQo+ID4gKyAgY2xvY2tzOg0KPiA+ICsgICAgbWF4SXRlbXM6IDEN
Cj4gPiArDQo+ID4gKyAgaW9tbXVzOg0KPiA+ICsgICAgbWF4SXRlbXM6IDENCj4gPiArDQo+ID4g
KyAgZG1hLWNvaGVyZW50OiB0cnVlDQo+ID4gKw0KPiA+ICtyZXF1aXJlZDoNCj4gPiArICAtIGNv
bXBhdGlibGUNCj4gPiArICAtIHJlZw0KPiA+ICsgIC0gY2xvY2tzDQo+ID4gKyAgLSBpb21tdXMN
Cj4gPiArDQo+ID4gK2FkZGl0aW9uYWxQcm9wZXJ0aWVzOiBmYWxzZQ0KPiA+ICsNCj4gPiArZXhh
bXBsZXM6DQo+ID4gKyAgLSB8DQo+ID4gKyAgICAjaW5jbHVkZSA8ZHQtYmluZGluZ3MvaW50ZXJy
dXB0LWNvbnRyb2xsZXIvYXJtLWdpYy5oPg0KPiANCj4gVGhpcyBkb2VzIG5vdCBsb29rIHVzZWQu
DQo+IA0KPiA+ICsgICAgI2luY2x1ZGUgPGR0LWJpbmRpbmdzL21lbW9yeS90ZWdyYTIzNC1tYy5o
Pg0KPiA+ICsgICAgI2luY2x1ZGUgPGR0LWJpbmRpbmdzL2Nsb2NrL3RlZ3JhMjM0LWNsb2NrLmg+
DQo+ID4gKw0KPiANCj4gV2l0aCBib3RoIGFib3ZlIGZpeGVkOg0KPiANCj4gUmV2aWV3ZWQtYnk6
IEtyenlzenRvZiBLb3psb3dza2kgPGtyenlzenRvZi5rb3psb3dza2lAbGluYXJvLm9yZz4NCj4g
DQo+IA0KPiAtLS0NCj4gDQo+IFRoaXMgaXMgYW4gYXV0b21hdGVkIGluc3RydWN0aW9uLCBqdXN0
IGluIGNhc2UsIGJlY2F1c2UgbWFueSByZXZpZXcgdGFncw0KPiBhcmUgYmVpbmcgaWdub3JlZC4g
SWYgeW91IGtub3cgdGhlIHByb2Nlc3MsIHlvdSBjYW4gc2tpcCBpdCAocGxlYXNlIGRvDQo+IG5v
dCBmZWVsIG9mZmVuZGVkIGJ5IG1lIHBvc3RpbmcgaXQgaGVyZSAtIG5vIGJhZCBpbnRlbnRpb25z
IGludGVuZGVkKS4NCj4gSWYgeW91IGRvIG5vdCBrbm93IHRoZSBwcm9jZXNzLCBoZXJlIGlzIGEg
c2hvcnQgZXhwbGFuYXRpb246DQo+IA0KPiBQbGVhc2UgYWRkIEFja2VkLWJ5L1Jldmlld2VkLWJ5
L1Rlc3RlZC1ieSB0YWdzIHdoZW4gcG9zdGluZyBuZXcNCj4gdmVyc2lvbnMsIHVuZGVyIG9yIGFi
b3ZlIHlvdXIgU2lnbmVkLW9mZi1ieSB0YWcuIFRhZyBpcyAicmVjZWl2ZWQiLCB3aGVuDQo+IHBy
b3ZpZGVkIGluIGEgbWVzc2FnZSByZXBsaWVkIHRvIHlvdSBvbiB0aGUgbWFpbGluZyBsaXN0LiBU
b29scyBsaWtlIGI0DQo+IGNhbiBoZWxwIGhlcmUuIEhvd2V2ZXIsIHRoZXJlJ3Mgbm8gbmVlZCB0
byByZXBvc3QgcGF0Y2hlcyAqb25seSogdG8gYWRkDQo+IHRoZSB0YWdzLiBUaGUgdXBzdHJlYW0g
bWFpbnRhaW5lciB3aWxsIGRvIHRoYXQgZm9yIHRhZ3MgcmVjZWl2ZWQgb24gdGhlDQo+IHZlcnNp
b24gdGhleSBhcHBseS4NCj4gDQo+IGh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4L3Y2
LjUtDQo+IHJjMy9zb3VyY2UvRG9jdW1lbnRhdGlvbi9wcm9jZXNzL3N1Ym1pdHRpbmctcGF0Y2hl
cy5yc3QjTDU3Nw0KPiANCg0KVGhhbmtzLiBOb3RlZC4gV2lsbCB1cGRhdGUgdGhlbS4NCg0KQmVz
dCBSZWdhcmRzLA0KQWtoaWwNCg==

