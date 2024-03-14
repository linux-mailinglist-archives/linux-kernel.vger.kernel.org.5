Return-Path: <linux-kernel+bounces-102723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E5D87B682
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 03:46:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BE9D1C2115A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 02:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDCC24A1B;
	Thu, 14 Mar 2024 02:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="TSH/jjOp"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B087E1;
	Thu, 14 Mar 2024 02:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710384382; cv=fail; b=Sa1DBIn8LO/ZFMGxsWOa/Eza1Qvg8+tSH47NocjY6pfkqHO8D0ydDbRVqHvtBoZd+h+NLI9EK3/EfvRtOj82o1C1bc9OLhC9xO2r9gjmJ3qF5gL8bViCGYL4fcqYucDzKBjLEM6OpGQYSLM8P2s4f8u+O9KiSNK6I2xe5utihYU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710384382; c=relaxed/simple;
	bh=lk/cuaRa5bjxLGt5eJYfYUe4g2Vx4xLHa8vrMgvnAsk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ER5n/U3lmXoZGXXN2e6rcJy2hqeJCsfB1TZBJXyrLleJlkAYwUpkiUnQqn2Qoq0xKMiJv0Rhe3CkmywmRj3vWt3puoTxyuRyV6gaQNipuNiGTHz3xkIJjL76gVztzSbC/HPGqNLY9fHlF4T6AuOMYC3lzGcSLt40jsu5jWjjofE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=TSH/jjOp; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42DJa8Ti022020;
	Wed, 13 Mar 2024 19:46:09 -0700
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3wu9kvuj2h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Mar 2024 19:46:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CwilnrNqGhm50xKUEicNozAv3dR5IPNdzjCQg5SRZXwtbtu7NZSyN5tBJKdS3bJml1e4UIUTRVmaGxGXEvt4nsqLZ/5L1mwvAwwZ4iTuADVZmH6zL4gxFg5et6bhtGixnaUUzTJ28OY7ceSqncbExIjm9Ad65QgVlTmwyEewxUTY9B1Whe1h4Dtynk+fBFxMqWQJMfXHoV/RHxzkr8O5uMroFIwPytJZY+M062fzRYoav3rp8HOK8TWWKOi3lMAm0pctHLForNd/SzPt1XD+0P7hPuuOMl6IKsUNkFQrxJFSS3ORk/p0EWYi2Te9l71dSigXdyygBwCML5UpPRRUnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lk/cuaRa5bjxLGt5eJYfYUe4g2Vx4xLHa8vrMgvnAsk=;
 b=XzNh1xIsiGxN6dExcs8slDJpPz3BZypbfWRmwTxrQ3ARxGkuM3WVqE97umWf8YoHrGNrNmbO+kwm7XkCM3xiyOHXNKwzFlzFYGJctZvDHfyvh2vKce7Vj7nTSMWQSQt8d1I3iFbDLndhRIxadIXv04SouZ/+1MEGMUmkSFxDOyeM+YShKrZJe8YcW7GwU7/AgH42Xv7On3DBFffdQIYwUDO/ECuSOYcAO0HNsIPal7HL6Ud9IJBi6Swv/OrI9DRoGfQ9BF1W9c+7LY5kw2hkFP4HFDmVM/uY4dJFyKdRsooJOTjJY8oxljNhaGCa/PXwE5KDdO+/GQvLfHmfDMtA/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lk/cuaRa5bjxLGt5eJYfYUe4g2Vx4xLHa8vrMgvnAsk=;
 b=TSH/jjOpZxyMjRtR9UuC8NhD2qKEC3IdCGywyDe9jarzyelJ/GlUvonx8JG8M/F8YjcVKpZP9CNNthI9feEk4TQtQBsRw71ekPs2s9G8P8Jxpq6ENMid6DGnxCzR9NKSvUZZ28EIQi1Xzf0PcXjXS1C3KYeCbarT/dmf07aMjcI=
Received: from MWHPR1801MB1918.namprd18.prod.outlook.com
 (2603:10b6:301:68::33) by PH7PR18MB5283.namprd18.prod.outlook.com
 (2603:10b6:510:243::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Thu, 14 Mar
 2024 02:46:07 +0000
Received: from MWHPR1801MB1918.namprd18.prod.outlook.com
 ([fe80::89ce:35b4:c4b0:c7ad]) by MWHPR1801MB1918.namprd18.prod.outlook.com
 ([fe80::89ce:35b4:c4b0:c7ad%7]) with mapi id 15.20.7386.017; Thu, 14 Mar 2024
 02:46:06 +0000
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Mark <mark@yotsuba.nl>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Hans de Goede
	<hdegoede@redhat.com>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Breno Leitao <leitao@debian.org>, Ingo Molnar
	<mingo@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Paolo Abeni
	<pabeni@redhat.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH] netpoll: support sending over raw IP
 interfaces
Thread-Topic: [EXTERNAL] Re: [PATCH] netpoll: support sending over raw IP
 interfaces
Thread-Index: AQHadU3g5YSI4ZMVGEaLlCke/4aQhrE2hTzQ
Date: Thu, 14 Mar 2024 02:46:06 +0000
Message-ID: 
 <MWHPR1801MB1918F15413BA4766F29A8581D3292@MWHPR1801MB1918.namprd18.prod.outlook.com>
References: <20240313124613.51399-1-mark@yotsuba.nl>
 <20240313133602.GA1263314@maili.marvell.com>
 <7C42FC4B-D803-4194-8FBB-19A432D37124@yotsuba.nl>
In-Reply-To: <7C42FC4B-D803-4194-8FBB-19A432D37124@yotsuba.nl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR1801MB1918:EE_|PH7PR18MB5283:EE_
x-ms-office365-filtering-correlation-id: e83099c6-e4ff-4cb6-9c10-08dc43d0e5d6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 iWFrCBqefni13xBija90ZXYtgHl5OhA+CuYjL0UMoSILe4a5mT4LIes3zb30e319eVWW++S+8KkouRx7+WnsbXNG5wqzYQcp4S87yHPA+rqw2GHsOGgVF1yg+oZ6Ih7ibBns+7pLln4A55Cxg+WBeOsAg7SeWLgWTgzX3cC31d/8+wxqdRnuImAmiZfdegob6hJXSNI/SFeJxD3m02ln0xxeu4MS4ZwcVJCrGGUczdYNkg9vbnG/7VZQAb+vIFArxwCEClRscjVap7ZcyODsELRZ76cfK5RhjkvwVvdiz4VjodKbQLNfG4DG9MkWewvtc4KoCusSD/nAPUCoUid5s0OtTuajHbPK1EdCJBkaD0HjFPNdj7LJoFyLpDd/4E+WUXvaSg0h6gd31XXu85CAqtdzlxplwfCWleWN67Dt1+f9T2mPuauixcc1+Kj1IU21Nl8F7n46RYAbNlxG362K3wOYrAwpHebMJc5Hqp7YOKAiGABcQMh0MHjvWu9Pb7q7UrRJcuMGfzpkHA8oHIIsR0qE3522/i6Xl+ZMyMdkOQp3UyJMgfPA+4PO7kodKTvVRa1fkCyMXIaJ6qF7adzn6tmwCxxNUvPUsqPDCC4W9M4/WCcbBKQlZ0n6JsQ6RBcDbceAbK0p26xYDkALgLPrHTOOa+ePrFdkU2b1Ddko+DYJmhZcHDliPTFaA1tSvvQNU2QCA+rOo49cysWm8nxm2w==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1801MB1918.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?ak5YYVNtZ1k5Rlk1TzZ0UmtsZVdwYmJFL29FaTl3UDNmeWRsd0FhOVQ3bUxQ?=
 =?utf-8?B?Ri9Ld29YUVN2RWFLZ2M5QjRDNWRmeCthekFmWGRnck5PVHI4K0NrNzNhKy9j?=
 =?utf-8?B?Y1RiWmVjMmVvNXRoQWdGQklWQW1va2FVZWl5dU9majVWMkNxMjQxcXU3SXJ6?=
 =?utf-8?B?TDJmTExYdXJqY2NHQkY1MGRGL0xPbUpZRW5mWGJhckxJMExxSlBEangxUmNG?=
 =?utf-8?B?OEdPWWNRczh6bnd4d0RnMzF0WTdWL1NNLzdwNGVmUkJRUUExNUZHNTc1SGk0?=
 =?utf-8?B?K3RsUEJINy9sZ2tnOTd6SHhVTDlQa0piYTllYVBTYW01M2hJaHVHSjlJRXlj?=
 =?utf-8?B?Mi9vVDJZdGR4UkN6VFhCbHZ0YzJWL1NZZytHYkp3M3hxZ254bFBlRWU2SCtJ?=
 =?utf-8?B?N0RxeXpvYW94MVJvcHdZcEM2ck1Cc2s2YnJVSXJUdUhCM0NYV3Y0amVqQ21n?=
 =?utf-8?B?TmJoelZ1MDZOeXFJVXJHQkczYmYwZlJRRmJoOG4yM2Y0c0VNZjF4bmxpV096?=
 =?utf-8?B?bkVySk92Q1JpVityL25JekQzdUZ5cHR6Vkc2ODdVNUxvdncyejUxa0JtZE5Q?=
 =?utf-8?B?QlhCcDB5MWJaOVVVYWNpcVhjbnA0Vm1oRXBVN1dWYXRBVnBDU0hkNWh0Mk1W?=
 =?utf-8?B?MGE5MHlTcmYyeVk5eHlrdkN3aVpPRTluSHNrZDRPZWRGTHJJQ3Jmd1VuUXFS?=
 =?utf-8?B?TlZRMWxZWVFQK1I0UFR6cmdFU2lwaG1tTGY3bCtzQzNOYjYrMXV1b2FWY1lD?=
 =?utf-8?B?UlFENHJGZjFrZUFId3JVQ2ZmSGZXaHZyT1BRQUpJTFRQL2lWMS81VDFDb3hh?=
 =?utf-8?B?MEF3TUFSMUdNZDBmSG5mL2k0eUplRVdmcnZad2M4N0FFYTc5cE84UE5GOUkx?=
 =?utf-8?B?RVltYkUvdWZWQmZPTWx1T1Nrb1k0clFWbmFSTVpUVWlQZ05yWUdDa2tucGpr?=
 =?utf-8?B?U3FHNDg4WTl4b0N6Q1Rjc1QwdTNuK293bXBiZ3MwZG5xajdSUEFHYjc2Y2VY?=
 =?utf-8?B?bXd0SnhJcnFpdmVpdnk1RE5kL3c5ME0rSVMzallvMDJZU3EzTktPVGhFWHA5?=
 =?utf-8?B?RmZ5UFQ4TVRGNXMwSE1GZ0ZNOUdJcEhLbGhZWDZtQlVTanI1bjhmb3VHVE9L?=
 =?utf-8?B?cjBwa0RkYWQ0SC9XSXNrUEt1MHEzSE5VWlpEem5rZjJPaGNmNlRXYWxjcEM3?=
 =?utf-8?B?NUplTk9DTGpKamxIeU8zeGl5V0Z3QzB1VzZBL3JOZWN1cER2M2NaeE1sbnEy?=
 =?utf-8?B?dDBaQTB3TVEvZlZyb0lHaWFHc0NOcE1BQXBwSVhMK2xDaFpGVGcyMkQ5ZytN?=
 =?utf-8?B?VDRoVTdObUlXOUlmb0R3L243MWdmK1o4SW1uallkMS9mUUJ0RHNKdk5rT0ZG?=
 =?utf-8?B?dzdjU1ptMHF5NnMwTEdEZ1pwYUQyUXVFS2FmcjU1bzlHcFR1a3U2QzROSjVo?=
 =?utf-8?B?RmtuS2lsOGVsNHZYZWdxdEg3Ryt4V0xXMmUvd2R0cU4zYjF0amdMc3YzTGU2?=
 =?utf-8?B?UXFvMmFBamY1TzdqbXZlWUtXOHNkaW5XQmVBTGlUZFpJRW5sbVZZeU9PbkNZ?=
 =?utf-8?B?Rnc1U2NCTDVTZ0FnUDlsd1hUR0lVZnIwQkZSNi8vTml4c0hZYjhDSzB6MUFh?=
 =?utf-8?B?WjVya0REblZ1eFdHd0ZSbDRRTHV1VUN6OVJkSS9RYkpyUWpRK2RnalBySGZ6?=
 =?utf-8?B?emlMOWZlL0tlMnVjRkxjdGZtN3Q0YnhMdE1ycHpNMFdoaDdxZHlhNmZQNDNL?=
 =?utf-8?B?Y1B1b1JFejh2aXZVY2ZnbjZ4SDlEeW90MXRLUk5xRUJPdFZEZXhJWXRQZmQy?=
 =?utf-8?B?ZVJCNTJLVVVPOXplV05WQlpMWXEyTW9PcXJoN0VJWGFydUM0d3QxTVdaa3V4?=
 =?utf-8?B?eWllNHdtZHYzYUE4cVZubUdtaGpFOUMvcmlTcFZ0QUhtc3FMOWF6VnlsNWtF?=
 =?utf-8?B?aGtuWFlsWDRFaTFkZnBkSGZ3dCtqYkdlendGdTFZTjg3bXhJbm9mN3B2eWhU?=
 =?utf-8?B?NEhnNkROK2dmMGV5MklDSG1wMDRiSTIwd2RPZzNrZVFSQllvL1VSQmF3ck1B?=
 =?utf-8?B?YmFTcXZtYkdxRG8vL3NDUHVSclZzZmlXdi9pYkJzWHd6d3A3eXZMODRId1Vh?=
 =?utf-8?Q?20c/FsAH2NX7iok5yE+65tAjM?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1801MB1918.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e83099c6-e4ff-4cb6-9c10-08dc43d0e5d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2024 02:46:06.7597
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IzUPqryCICDwzeGqvsgBYLpPAthFU/Bz7mDAQrFbbb7jNeWFwMVFhLlzIgzSv++0/mXE/edc28nnPudnY0zYXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR18MB5283
X-Proofpoint-GUID: c1H1u3-i3h1b2aWFLBrCr6xrH9lFpHT2
X-Proofpoint-ORIG-GUID: c1H1u3-i3h1b2aWFLBrCr6xrH9lFpHT2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-13_11,2024-03-13_01,2023-05-22_02

PiBGcm9tOiBNYXJrIDxtYXJrQHlvdHN1YmEubmw+DQo+IFNlbnQ6IFdlZG5lc2RheSwgTWFyY2gg
MTMsIDIwMjQgNzoyMyBQTQ0KPiBUbzogUmF0aGVlc2ggS2Fubm90aCA8cmthbm5vdGhAbWFydmVs
bC5jb20+DQo+ID4gT24gMjAyNC0wMy0xMyBhdCAxODoxNjoxMywgTWFyayBDaWxpc3NlbiAobWFy
a0B5b3RzdWJhLm5sKSB3cm90ZToNCj4gPj4gW+KApl0NCj4gPiBUYWtpbmcgYW4gYXNzdW1wdGlv
biBiYXNlZCBvbiBkZXbigJlzIGxvd2VyIGxheWVyIGRvZXMgbm90IGxvb2sgdG8gYmUgZ29vZC4N
Cj4gPiB3aHkgbm90IHRyYW5zbWl0IHBhY2tldCBmcm9tIHNrYl9uZXR3b3JrX2hlYWRlcigpIGlu
IHlvdXIgZHJpdmVyIChieQ0KPiA+IG1ha2luZyBjaGFuZ2VzIGluIHlvdXIgZHJpdmVyKQ0KPiAN
Cj4gVGhlcmXigJlzIHR3byBhc3N1bXB0aW9ucyBhdCBwbGF5IGhlcmU6DQo+IC0gVGhlIGxvd2Vy
IGxheWVyIGlzIGV0aGVybmV0OiB0aGlzIGhhcyBhbHdheXMgYmVlbiBwcmVzZW50IGluIG5ldHBv
bGwsIGFuZCBpcw0KPiBldmVuDQo+ICAgZG9jdW1lbnRlZCBpbiBuZXRjb25zb2xlLnJzdC4gVGhp
cyBjb21tZW50IGp1c3QgbWVudGlvbnMgaXQgYmVjYXVzZSB3ZQ0KPiBhZGQgYSB3YXkNCj4gICB0
byBieXBhc3MgdGhlIGFzc3VtcHRpb247IGl0IGlzIG5vdCBhbiBhc3N1bXB0aW9uIHRoaXMgcGF0
Y2ggYWRkcyB0byB0aGUNCj4gY29kZS4NCj4gLSBoYXJkX2hlYWRlcl9sZW49PTAgbWVhbnMgdGhh
dCB0aGVyZSBpcyBubyBleHBvc2VkIGxpbmsgbGF5ZXI6IHRoaXMgaXMgYSByYXRoZXINCj4gICBj
b25zZXJ2YXRpdmUgYXNzdW1wdGlvbiBpbiBteSBvcGluaW9uLCBhbmQgaXMgYWxzbyBtZW50aW9u
ZWQgaW4gdGhlDQo+IGRlZmluaXRpb24NCg0KSG1tLiAgVGhhdCBpcyBub3QgbXkgcXVlc3Rpb24u
ICAgTGV0IG1lIGV4cGxhaW4gaXQgaW4gZGV0YWlsLiBOZXRjb25zb2xlIGlzIHVzaW5nIG5ldHBv
bGxfc2VuZF91ZHAoKSB0byBlbmNhcHN1bGF0ZSB0aGUgbXNnIG92ZXIgDQpVRFAvSVAvIE1BQyBo
ZWFkZXJzLiBKb2Igd2VsbCBkb25lLiBOb3cgaXQgY2FsbHMgbmV0ZGV2LT5vcHMtPm5kb19zdGFy
dF94bWl0KHNrYiwgZGV2KS4gIElmIHlvdXIgZHJpdmVyIGlzIHdlbGwgYXdhcmUgdGhhdCB5b3Ug
Y2FuDQpUcmFuc21pdCBvbmx5IGZyb20gbmV0d29yayBoZWFkZXIsIHdoeSBkb27igJl0IHlvdSBk
bWEgbWFwIGZyb20gbmV0d29yayBoZWFkZXIgPyAgDQoNCj4gICBvZiBMTF9SRVNFUlZFRF9TUEFD
RToNCj4gDQo+ID4gKiBBbHRlcm5hdGl2ZSBpczoNCj4gPiAqICAgZGV2LT5oYXJkX2hlYWRlcl9s
ZW4gPyAoZGV2LT5oYXJkX2hlYWRlcl9sZW4gKw0KPiA+ICogICAgICAgICAgICAgICAgICAgICAg
ICAgICAgKEhIX0RBVEFfTU9EIC0gMSkpICYgfihISF9EQVRBX01PRCAtIDEpIDogMA0KPiANCj4g
ICBUaGUgc2FtZSBhc3N1bXB0aW9uIGlzIGFsc28gbWFkZSBpbiBtb3JlIHBsYWNlcyBpbiB0aGUg
Y29yZSBuZXR3b3JrIGNvZGUsDQo+IGxpa2UgYWZfcGFja2V0Og0KPiANCj4gPiAgIC0gSWYgdGhl
IGRldmljZSBoYXMgbm8gZGV2LT5oZWFkZXJfb3BzLT5jcmVhdGUsIHRoZXJlIGlzIG5vIExMIGhl
YWRlcg0KPiA+ICAgICB2aXNpYmxlIGFib3ZlIHRoZSBkZXZpY2UuIEluIHRoaXMgY2FzZSwgaXRz
IGhhcmRfaGVhZGVyX2xlbiBzaG91bGQgYmUgMC4NCj4gPiAgICAgVGhlIGRldmljZSBtYXkgcHJl
cGVuZCBpdHMgb3duIGhlYWRlciBpbnRlcm5hbGx5LiBJbiB0aGlzIGNhc2UsIGl0cw0KPiA+ICAg
ICBuZWVkZWRfaGVhZHJvb20gc2hvdWxkIGJlIHNldCB0byB0aGUgc3BhY2UgbmVlZGVkIGZvciBp
dCB0byBhZGQgaXRzDQo+ID4gICAgIGludGVybmFsIGhlYWRlci4NCj4gDQpBQ0suIA0KDQoNCg==

