Return-Path: <linux-kernel+bounces-144522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9668A475C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 06:01:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6A4A1F21ACA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 04:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B1A1CD23;
	Mon, 15 Apr 2024 04:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="clg3dzlT"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58B11C68F;
	Mon, 15 Apr 2024 04:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713153690; cv=fail; b=Zmh2ndKEBbusGQKFEi9KScIzc0JbWn7fbNkBOgmsOW8i+S/iZ8EZJA5+F5KNz7IXrJ9oqH4f+RFNAi/LcKBYdEZvNwo4AQysJfyAt4AK9STAhvMJfqU2FvPhA+wpJx9Gcj8F2zT5rfBOC9G7Vn0ejIWP1SZ88XTS7MxZy4jRo0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713153690; c=relaxed/simple;
	bh=xNf1L4VEe6JpSN/kAZgQGf0VYjwktJzaG92FyZTvQYI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UMiOkKPw5NW0OYnCmYaT/OYD8/ahTRcFbKlAp06dKbKPzEYKdFGa3Txg1w0WFssxrsoJQs89C0ItsYChESwwpwwKom1UfkwSDt1kR3JVQe+yqBgSkDrmdTjBhclMQdc8l1Ji8txgA8RVvltq2ILBWpmCbL7WH3RH2ZVh0umtZXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=clg3dzlT; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43EMuuWk024308;
	Sun, 14 Apr 2024 21:01:14 -0700
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3xfsjg36g6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 14 Apr 2024 21:01:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kFX/GuZPZ3coDBn2wWHLr0+Rc0azomuKjB3SDvvJKfvlF3wP6ihi91nfA386VjIV7uxEOaLli1ZuyyGIv6l9OxDwFSQrKHodNxMozkdVOW0OV9aBXk3l79fbG37gDqzoEgm1noCLi+PuHt2U3L2a6aWKodHZBbDoTyZAiHOvO3Te2iWr2YvPK0SZp0bUk8COWjRxuHSk6ai0Zh1Z9tOTtYIhopnEbrytJMuNqNczaT0eMN8pTunkyXqaAOM1Wu9Qnpj67CYmN+htlMd5bIoLXbZg31hqdutgy5L7hKj6aEn9cM4JMieB0eBVInVRLCXT/cgkO0z0i7RYFAfjjyl4iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xNf1L4VEe6JpSN/kAZgQGf0VYjwktJzaG92FyZTvQYI=;
 b=EAWOoiebIV3tZwzSHFq3nDC5srsn3Jk9+MzTJi/uUDy6BjnRkWwof0fYv32c83nOR6jjh0IkDxMFofDf0grZzYo9TKO9xfnYHbX8g1a/UCukPs461gskZP9AKJAmlnnvrDlHI9z+u46MXDtmHKpq0tnzxgcppLOkYV9O/2t+B3EtmS9hnzO3Yo5mkyAaTp1B3gN4g21Bwyi2ssN1mHUnCJZkcRbHIg+XjNO1gRwMHV2PNpZnlDEk3BgZf/pMswObahyOw8TbO5tCDlVTiaTIzBEIKc6KRDci82BrmdJVYZEAGgQHDsdMHm6Vdosak+RXHuBn3ZHKOwL7uzxLLL9YzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xNf1L4VEe6JpSN/kAZgQGf0VYjwktJzaG92FyZTvQYI=;
 b=clg3dzlTlQtwJaj6qV7PiTqxbT2Wk+GU5DnfRQQqAcYHKDlRf3NWywR1My6uy1vbTuPWlEt/vzLmbcoWMU35F9Az1jy+6zLY/IkubIIrckACrny447YIw/+B65vp1Q1rzHNV+5hs9GtD1wb1e+z/GeF4IzGCariQHr4KR5blXN0=
Received: from PH0PR18MB5002.namprd18.prod.outlook.com (2603:10b6:510:11d::12)
 by CO3PR18MB4864.namprd18.prod.outlook.com (2603:10b6:303:165::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 04:01:10 +0000
Received: from PH0PR18MB5002.namprd18.prod.outlook.com
 ([fe80::8bf7:91cd:866c:68b0]) by PH0PR18MB5002.namprd18.prod.outlook.com
 ([fe80::8bf7:91cd:866c:68b0%7]) with mapi id 15.20.7452.049; Mon, 15 Apr 2024
 04:01:10 +0000
From: Linu Cherian <lcherian@marvell.com>
To: James Clark <james.clark@arm.com>,
        Suzuki K Poulose
	<suzuki.poulose@arm.com>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "coresight@lists.linaro.org"
	<coresight@lists.linaro.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        George Cherian <gcherian@marvell.com>,
        Anil Kumar Reddy H
	<areddy3@marvell.com>,
        Tanmay Jagdale <tanmay@marvell.com>,
        "mike.leach@linaro.org" <mike.leach@linaro.org>,
        "leo.yan@linaro.org"
	<leo.yan@linaro.org>
Subject: RE: [EXTERNAL] Re: [PATCH v7 5/7] coresight: tmc: Add support for
 reading crash data
Thread-Topic: [EXTERNAL] Re: [PATCH v7 5/7] coresight: tmc: Add support for
 reading crash data
Thread-Index: AQHacEC6OTwMLw8mfE6FXAVitvdDBbFkoWWAgAMmnPA=
Date: Mon, 15 Apr 2024 04:01:10 +0000
Message-ID: 
 <PH0PR18MB5002D42E980EDF6317051B77CE092@PH0PR18MB5002.namprd18.prod.outlook.com>
References: <20240307033625.325058-1-lcherian@marvell.com>
 <20240307033625.325058-6-lcherian@marvell.com>
 <d707430f-00ee-4427-a9e4-6e42bc5b6aa9@arm.com>
In-Reply-To: <d707430f-00ee-4427-a9e4-6e42bc5b6aa9@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB5002:EE_|CO3PR18MB4864:EE_
x-ms-office365-filtering-correlation-id: 75023e62-4852-4191-b08e-08dc5d00af69
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 c0P3087Yl4lo8h2ImvvcCGZ6dQvTlKCs4c+rZTMIdkfXUBYJ010Lb+8M5V518UjhypxHnUJGUEH0SaxUaWCUtc4EUyLJHYx4trb4KLMnpPbYQVUYXolM8Uef4/hMTxbE2ZllT7KwQ2Xz9yWCpl4HN+Bc2GSv4hzF6UYtcMQvlxROanA8cuUds7OLfdS7EcO/1jyn8yNcuwSZSAgIqmYa5en28h+c/If5bDtz2N3L6FWK2Uabp+Ec2wlMD+ASG62JrFzY8wHnbW0bJ7BfeGH7CGHphG0IR2KOlYTuBIKjt+jWc+ySPO+l3xygClU6fJVMR3Bi7vIfkBebWa6aY9c1QKKwUyCskjlqJiZrTc4UDMf1YezVu/EKz6D+LZe/+mslUef5cDmO8SKFbzv9WaeeFgTwP6j60Nf50dxlqbSBBjrGq1yrgDsAGEZ6lZh+NDdGTj5mD7wJ81IN5aR1Mh2rpZdt1f4WPT6zHHhRZV2Qlphg01R3fXltpb7N5Xpo5y9q0goojpPZumCoYD36zFTerqKlMFqP73jPmN0xh/aKMM1axlyi6a5jvuChsAMoWqLJ2dnWAriSgjaku9LPzKL/HBPCbG+dRRO+tca2waZnXjSrlQNm5jTx6JM41RLZab2w/pEsFEizfeyYNpxbpoxkDD2sl8ydGJZXs2hm/qTXJiJyv7bKCg6iA6AaFQAlbt7dcclAxu6gdaoWmyi5l9UJBYJMy7lXU2cKz3/QPf4FPfw=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR18MB5002.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?VEVnR1NtK1JNa3dFTE1ST3dWSzl1a2ROaXNFNDRlajg1a3pZb0FYRlVLQUVC?=
 =?utf-8?B?MkNKZ1VZb1p4ZjhvSDZvam14VWtDSEZBVmhGSHhaRGpHUW54RUNFOXlJYWF4?=
 =?utf-8?B?aGQ1N0tLMXhGRkpuUXJDRGxRaFJmN1cvUGdaOVBhbys5aXpBTTBiZWNRWWV6?=
 =?utf-8?B?UWZPTlBldGpjU2FjckRZRk9lK2EvRDZoa3FGZTJPZ05iT2FBSFRkT2RZeita?=
 =?utf-8?B?aDdsbUhBWW00ZitqRE1DbENKbXYzNVBrMEY5c1dnaVZJNG1MKzRXd1dMUDVE?=
 =?utf-8?B?ZlA3S0YyTko0RVhhUUhzcnFHVklXK3BKRlZiVjhHN0R0YzMrOVJlWDh1ejlV?=
 =?utf-8?B?ZnpYcGwwMXFrN0dwQUJnd1B4ZjVUY2M5Z1l3Ui9lSFBnNkMxSUZ0N0k4K29o?=
 =?utf-8?B?UzlyWTZSL3lSQWt3c0lFL2tlemVOWXlNM0VjNlNyZXEwY3hVdjcxTXBpYUpy?=
 =?utf-8?B?MHhLamRvMHlVVkZLSUFkMkprcy9DaUVtaWlwMVFPTzE4SHJHVDJCV25maW1k?=
 =?utf-8?B?T1lQY3NmeFB4RW9ocCtOSFBJOXZZbEZLVFU4N0szb2pnV0drVG82bXVEL2VT?=
 =?utf-8?B?cXdpMThHTGFmajQxcWFKZXVFUHlyT3RuWDl6b0x0VE9XeUlTZDJjd1ZxMW9M?=
 =?utf-8?B?ZXZYNWtSR3BIbHl4VUxaSFNZcUpnamN1ZExYUXhLQmI1WUhxV285V2gyMXFM?=
 =?utf-8?B?NVFsUm9OWjhUR3RXSnROQ2tONFJwR0FjVUxUdlVYZDc0WjBQcWtucjlndk01?=
 =?utf-8?B?Wm5GNkt6NFYyQjIwMXJWT2x0TUpvL3R2QlhrTW1IMVNNRlNva2dOMFJ4cE9s?=
 =?utf-8?B?ODRHWkx5OWZEYm0zVEUzbnJGcWdkdExmWVgzQmN1TFFXMUpHVEVCRENtVC9k?=
 =?utf-8?B?VnpIaUVYMUwzdW9VVm5EQURmZkszblhtOWFETnBoWXkzZWZLZmFtUjBhZ1NI?=
 =?utf-8?B?c1hjektZeEhXcitFWlVxcFlCZFNJamx1VkV2WUlrVWpHbnFrM2pZUXR5dHhS?=
 =?utf-8?B?eHN6cHI2YnlYdGJYdHQvQWVHY2IwL2R4eTl0QVF1UU5CWTRmdTFGMzV5WXY5?=
 =?utf-8?B?Wmw4QmdWRUFDcEhCUU9PV3Nzemh3Z0xYVW9GUlorRFVtWFpPOHlGelp0bkZE?=
 =?utf-8?B?M0o4RTZoM2NLRENJek1vZ3RkUi9QbThzakVWdlJBdUVRQVVhbE5sNEk1ZmFQ?=
 =?utf-8?B?VzBWNXcvVm82MlpBSzVhTER4NG5XRlRDcnAyRWhzRDJEdktDb3ZtaXhyTE85?=
 =?utf-8?B?Z2o0Rk1qMHFSQ1lnak9jcCsxbDVaMmMzTGFHL1hkd1RaekIzRVNkMUxjVU9F?=
 =?utf-8?B?YzlhMS8zQ2VZWk1seFBjdnlnNnVLeHFxLzB2bitjbER2MWlkclltWXlwSGVl?=
 =?utf-8?B?R3o3Rm8wckx0QWlHMUZrem4xRHM4aWl3M3BleFRPcUlKdGlhbGtlSTFiSG9Q?=
 =?utf-8?B?eDR1YlVvaWtLM3NRclBqSGRCc3BFdDZaZXRvbVJUSFh3UWtKUVZOVTFHZmk5?=
 =?utf-8?B?WnFEVllaL0lteEFjTmJ1MHdSWlI0UzJKeWFWUCtPWE9YVmlMakFqOXJiLzFN?=
 =?utf-8?B?eEVnT01tYjRWamNTbmVwUWtJNlVGZmw1cTVTZzRUcHE5dWVUbzFMR2VvcmEz?=
 =?utf-8?B?VndJYmhMN3AwZjdnTmpRWCtvRDZoeGhTNkFuZVBOVW85b0p6bFVtMHhCMU9m?=
 =?utf-8?B?U0R1YXlkNFBjeHFjcDNaRG1DcDFJb2FyRTZwSCtZWmVteWlBZ0xTanNyUkU4?=
 =?utf-8?B?L2YxdlNoK0NJcldPKzloclJoUk9rN1BzdnRuTGVWdzdpS0xGb1I1NkZydndG?=
 =?utf-8?B?OFhFbWdhUkFuaTgwRHF6ME92alBMRjcxNUJwNkQ1ODZTTitYcFYweDR3cUUz?=
 =?utf-8?B?dmRUbFZXbEI4eFBFOGJhTS9qVUN0R3RaRFZJWHdydWFvYnYrWkhYTjBpU1NU?=
 =?utf-8?B?RGVqS0ZPNXU1L1pIYWJmalNHWW0xTFA3OHcxUUp5Smp0MGRlalFuRjE2Umh3?=
 =?utf-8?B?d3E0UXQ2TDAwbVFMM1ROVmpvSU5ESEdDY3Q0QWNDNGg4YU9EWHI2dWtERWxo?=
 =?utf-8?B?M1E1MVRpTkxQMFR2eXJTZWZRSjRHWGVvUzZqNDV0L25NZ3RLc2VYeEt0Rmdw?=
 =?utf-8?Q?gJGGW+ezeGlOVygdVFfL7oSvZ?=
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
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB5002.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75023e62-4852-4191-b08e-08dc5d00af69
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2024 04:01:10.3691
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7uh+egOdAaToLOAA2S1ubEZZR+9DCFOI0zrtnVBi4ZExJ51t5pkmppLQYOE1FDCnCbFpfP8mb2LM8mjXYZ/zvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO3PR18MB4864
X-Proofpoint-GUID: NtRO7d2RGiY0FcLFtktZx2Zc0XHwDPiq
X-Proofpoint-ORIG-GUID: NtRO7d2RGiY0FcLFtktZx2Zc0XHwDPiq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-15_03,2024-04-09_01,2023-05-22_02

SGkgSmFtZXMsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFtZXMg
Q2xhcmsgPGphbWVzLmNsYXJrQGFybS5jb20+DQo+IFNlbnQ6IEZyaWRheSwgQXByaWwgMTIsIDIw
MjQgMzozNiBQTQ0KPiBUbzogTGludSBDaGVyaWFuIDxsY2hlcmlhbkBtYXJ2ZWxsLmNvbT47IFN1
enVraSBLIFBvdWxvc2UNCj4gPHN1enVraS5wb3Vsb3NlQGFybS5jb20+DQo+IENjOiBsaW51eC1h
cm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGNvcmVzaWdodEBsaXN0cy5saW5hcm8ub3Jn
OyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsgcm9iaCtkdEBrZXJuZWwub3JnOw0K
PiBrcnp5c3p0b2Yua296bG93c2tpK2R0QGxpbmFyby5vcmc7IGNvbm9yK2R0QGtlcm5lbC5vcmc7
DQo+IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBTdW5pbCBLb3Z2dXJpIEdvdXRoYW0NCj4g
PHNnb3V0aGFtQG1hcnZlbGwuY29tPjsgR2VvcmdlIENoZXJpYW4gPGdjaGVyaWFuQG1hcnZlbGwu
Y29tPjsgQW5pbA0KPiBLdW1hciBSZWRkeSBIIDxhcmVkZHkzQG1hcnZlbGwuY29tPjsgVGFubWF5
IEphZ2RhbGUNCj4gPHRhbm1heUBtYXJ2ZWxsLmNvbT47IG1pa2UubGVhY2hAbGluYXJvLm9yZzsg
bGVvLnlhbkBsaW5hcm8ub3JnDQo+IFN1YmplY3Q6IFtFWFRFUk5BTF0gUmU6IFtQQVRDSCB2NyA1
LzddIGNvcmVzaWdodDogdG1jOiBBZGQgc3VwcG9ydCBmb3INCj4gcmVhZGluZyBjcmFzaCBkYXRh
DQo+IA0KPiBQcmlvcml0aXplIHNlY3VyaXR5IGZvciBleHRlcm5hbCBlbWFpbHM6IENvbmZpcm0g
c2VuZGVyIGFuZCBjb250ZW50IHNhZmV0eQ0KPiBiZWZvcmUgY2xpY2tpbmcgbGlua3Mgb3Igb3Bl
bmluZyBhdHRhY2htZW50cw0KPiANCj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiANCj4gDQo+IE9uIDA3LzAz
LzIwMjQgMDM6MzYsIExpbnUgQ2hlcmlhbiB3cm90ZToNCj4gPiAqIEludHJvZHVjZSBhIG5ldyBt
b2RlIENTX01PREVfUkVBRF9DUkFTSERBVEEgZm9yIHJlYWRpbmcgdHJhY2UNCj4gPiAgIGNhcHR1
cmVkIGluIHByZXZpb3VzIGNyYXNoL3dhdGNoZG9nIHJlc2V0Lg0KPiA+DQo+ID4gKiBBZGQgc3Bl
Y2lhbCBkZXZpY2UgZmlsZXMgZm9yIHJlYWRpbmcgRVRSL0VURiBjcmFzaCBkYXRhLg0KPiA+DQo+
ID4gKiBVc2VyIGNhbiByZWFkIHRoZSBjcmFzaCBkYXRhIGFzIGJlbG93DQo+ID4NCj4gPiAgIEZv
ciBleGFtcGxlLCBmb3IgcmVhZGluZyBjcmFzaCBkYXRhIGZyb20gdG1jX2V0ZiBzaW5rDQo+ID4N
Cj4gPiAgICNkZCBpZj0vZGV2L2NyYXNoX3RtY19ldGZYWCBvZj1+L2NzdHJhY2UuYmluDQo+ID4N
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBBbmlsIEt1bWFyIFJlZGR5IDxhcmVkZHkzQG1hcnZlbGwuY29t
Pg0KPiA+IFNpZ25lZC1vZmYtYnk6IFRhbm1heSBKYWdkYWxlIDx0YW5tYXlAbWFydmVsbC5jb20+
DQo+ID4gU2lnbmVkLW9mZi1ieTogTGludSBDaGVyaWFuIDxsY2hlcmlhbkBtYXJ2ZWxsLmNvbT4N
Cj4gPiAtLS0NCj4gPiBDaGFuZ2Vsb2cgZnJvbSB2NjoNCj4gPiAqIFJlbW92ZWQgcmVhZF9wcmV2
Ym9vdCBmbGFnIGluIHN5c2ZzDQo+ID4gKiBBZGRlZCBzcGVjaWFsIGRldmljZSBmaWxlcyBmb3Ig
cmVhZGluZyBjcmFzaGRhdGENCj4gPiAqIFJlbmFtZWQgQ1MgbW9kZSBSRUFEX1BSRVZCT09UIHRv
IFJFQURfQ1JBU0hEQVRBDQo+ID4gKiBTZXR0aW5nIHRoZSBSRUFEX0NSQVNIREFUQSBtb2RlIGlz
IGRvbmUgYXMgcGFydCBvZiBmaWxlIG9wZW4uDQo+ID4NCj4gDQo+IFsuLi5dDQo+IA0KPiA+IEBA
IC02MTksNiArNzQwLDE5IEBAIHN0YXRpYyBpbnQgdG1jX3Byb2JlKHN0cnVjdCBhbWJhX2Rldmlj
ZSAqYWRldiwNCj4gY29uc3Qgc3RydWN0IGFtYmFfaWQgKmlkKQ0KPiA+ICAJCWNvcmVzaWdodF91
bnJlZ2lzdGVyKGRydmRhdGEtPmNzZGV2KTsNCj4gPiAgCWVsc2UNCj4gPiAgCQlwbV9ydW50aW1l
X3B1dCgmYWRldi0+ZGV2KTsNCj4gPiArDQo+ID4gKwlpZiAoIWlzX3RtY19yZXNlcnZlZF9yZWdp
b25fdmFsaWQoZGV2KSkNCj4gPiArCQlnb3RvIG91dDsNCj4gPiArDQo+ID4gKwlkcnZkYXRhLT5j
cmFzaGRldi5uYW1lID0NCj4gPiArCQlkZXZtX2thc3ByaW50ZihkZXYsIEdGUF9LRVJORUwsICIl
c18lcyIsICJjcmFzaCIsDQo+IGRlc2MubmFtZSk7DQo+ID4gKwlkcnZkYXRhLT5jcmFzaGRldi5t
aW5vciA9IE1JU0NfRFlOQU1JQ19NSU5PUjsNCj4gPiArCWRydmRhdGEtPmNyYXNoZGV2LmZvcHMg
PSAmdG1jX2NyYXNoZGF0YV9mb3BzOw0KPiA+ICsJcmV0ID0gbWlzY19yZWdpc3RlcigmZHJ2ZGF0
YS0+Y3Jhc2hkZXYpOw0KPiA+ICsJaWYgKHJldCkNCj4gPiArCQlwcl9lcnIoIiVzOiBGYWlsZWQg
dG8gc2V0dXAgZGV2IGludGVyZmFjZSBmb3IgY3Jhc2hkYXRhXG4iLA0KPiA+ICsJCSAgICAgICBk
ZXNjLm5hbWUpOw0KPiA+ICsNCj4gDQo+IElzIHRoaXMgYWxsIG9wdGlvbmFsIGFmdGVyIHRoZSBp
c190bWNfcmVzZXJ2ZWRfcmVnaW9uX3ZhbGlkKCk/IFNraXBwaW5nIHRvIG91dA0KPiBzZWVtcyB0
byBiZSBtb3JlIGxpa2UgYW4gZXJyb3IgY29uZGl0aW9uLCBidXQgaW4gdGhpcyBjYXNlIGl0J3Mg
bm90PyBIYXZpbmcgaXQNCj4gbGlrZSB0aGlzIG1ha2VzIGl0IG1vcmUgZGlmZmljdWx0IHRvIGFk
ZCBleHRyYSBzdGVwcyB0byB0aGUgcHJvYmUgZnVuY3Rpb24uIFlvdQ0KPiBjb3VsZCBtb3ZlIGl0
IHRvIGEgZnVuY3Rpb24gYW5kIGZsaXAgdGhlIGNvbmRpdGlvbiB3aGljaCB3b3VsZCBiZSBjbGVh
cmVyOg0KPiANCg0KQWNrLg0KDQo+ICAgIGlmIChpc190bWNfcmVzZXJ2ZWRfcmVnaW9uX3ZhbGlk
KGRldikpDQo+ICAgICAgIHJlZ2lzdGVyX2NyYXNoX2Rldl9pbnRlcmZhY2UoZHJ2ZGF0YSk7DQo+
IA0KPiANCj4gPiAgb3V0Og0KPiA+ICAJcmV0dXJuIHJldDsNCj4gPiAgfQ0KPiANCj4gWy4uLl0N
Cj4gDQo+ID4NCj4gPiArc3RhdGljIGludCB0bWNfZXRyX3NldHVwX2NyYXNoZGF0YV9idWYoc3Ry
dWN0IHRtY19kcnZkYXRhICpkcnZkYXRhKSB7DQo+ID4gKwlpbnQgcmMgPSAwOw0KPiA+ICsJdTY0
IHRyYWNlX2FkZHI7DQo+ID4gKwlzdHJ1Y3QgZXRyX2J1ZiAqZXRyX2J1ZjsNCj4gPiArCXN0cnVj
dCBldHJfZmxhdF9idWYgKnJlc3J2X2J1ZjsNCj4gPiArCXN0cnVjdCB0bWNfY3Jhc2hfbWV0YWRh
dGEgKm1kYXRhOw0KPiA+ICsJc3RydWN0IGRldmljZSAqZGV2ID0gJmRydmRhdGEtPmNzZGV2LT5k
ZXY7DQo+ID4gKw0KPiA+ICsJbWRhdGEgPSBkcnZkYXRhLT5jcmFzaF9tZGF0YS52YWRkcjsNCj4g
PiArDQo+ID4gKwlldHJfYnVmID0ga3phbGxvYyhzaXplb2YoKmV0cl9idWYpLCBHRlBfQVRPTUlD
KTsNCj4gPiArCWlmICghZXRyX2J1Zikgew0KPiA+ICsJCXJjID0gLUVOT01FTTsNCj4gPiArCQln
b3RvIG91dDsNCj4gPiArCX0NCj4gPiArCWV0cl9idWYtPnNpemUgPSBkcnZkYXRhLT5jcmFzaF90
YnVmLnNpemU7DQo+ID4gKw0KPiA+ICsJcmVzcnZfYnVmID0ga3phbGxvYyhzaXplb2YoKnJlc3J2
X2J1ZiksIEdGUF9BVE9NSUMpOw0KPiA+ICsJaWYgKCFyZXNydl9idWYpIHsNCj4gPiArCQlyYyA9
IC1FTk9NRU07DQo+ID4gKwkJZ290byBybWVtX2VycjsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwkv
Kg0KPiA+ICsJICogQnVmZmVyIGFkZHJlc3MgZ2l2ZW4gYnkgbWV0YWRhdGEgZm9yIHJldHJpZXZh
bCBvZiB0cmFjZSBkYXRhDQo+ID4gKwkgKiBmcm9tIHByZXZpb3VzIGJvb3QgaXMgZXhwZWN0ZWQg
dG8gYmUgc2FtZSBhcyB0aGUgcmVzZXJ2ZWQNCj4gPiArCSAqIHRyYWNlIGJ1ZmZlciBtZW1vcnkg
cmVnaW9uIHByb3ZpZGVkIHRocm91Z2ggRFRTDQo+ID4gKwkgKi8NCj4gPiArCWlmIChpc190bWNf
cmVzZXJ2ZWRfcmVnaW9uX3ZhbGlkKGRldi0+cGFyZW50KQ0KPiA+ICsJICAgICYmIChkcnZkYXRh
LT5jcmFzaF90YnVmLnBhZGRyID09IG1kYXRhLT50cmNfcGFkZHIpKQ0KPiA+ICsJCXJlc3J2X2J1
Zi0+dmFkZHIgPSBkcnZkYXRhLT5jcmFzaF90YnVmLnZhZGRyOw0KPiA+ICsJZWxzZSB7DQo+ID4g
KwkJZGV2X2RiZyhkZXYsICJUcmFjZSBidWZmZXIgYWRkcmVzcyBvZiBwcmV2aW91cyBib290DQo+
IGludmFsaWRcbiIpOw0KPiA+ICsJCXJjID0gLUVJTlZBTDsNCj4gPiArCQlnb3RvIG1hcF9lcnI7
DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJcmVzcnZfYnVmLT5zaXplID0gZXRyX2J1Zi0+c2l6ZTsN
Cj4gPiArCXJlc3J2X2J1Zi0+ZGV2ID0gJmRydmRhdGEtPmNzZGV2LT5kZXY7DQo+ID4gKwlldHJf
YnVmLT5od2FkZHIgPSB0cmFjZV9hZGRyOw0KPiANCj4gdHJhY2VfYWRkciBpcyB1bmluaXRpYWxp
c2VkIGF0IHRoaXMgcG9pbnQuIElmIHlvdSBwdWxsIHRoZSBsYXRlc3QgY29yZXNpZ2h0IGJyYW5j
aA0KPiB3ZSBlbmFibGVkIHNvbWUgZXh0cmEgY29tcGlsZXIgd2FybmluZ3Mgd2hpY2ggY2F0Y2gg
dGhpcy4NCj4gDQo+IEkgYXNzdW1lIGl0J3Mgc3VwcG9zZWQgdG8gYmUgbWRhdGEtPnRyY19wYWRk
cj8NCg0KDQpTaW5jZSBubyBETUEgb3BlcmF0aW9uIGhhcHBlbnMgaGVyZSwgaXRzIHN1cHBvc2Vk
IHRvIGJlIGtlcHQgTlVMTC4NClNpbmNlIGl0IHdhcyByZWR1bmRhbnQgZm9yIGNyYXNoIGRhdGEg
cmVhZCBvcGVyYXRpb24sIG1pc3NlZCBjYXRjaGluZyB0aGlzLiBXaWxsIGZpeCB0aGlzLg0KDQo+
IA0KPiBJcyB0aGVyZSBzb21lIGtpbmQgb2YgdGVzdCB0aGF0IGNvdWxkIGJlIGFkZGVkIHRoYXQg
Y291bGQgaGF2ZSBjYXVnaHQgdGhpcz8NCj4gTWF5YmUgc2tpcCB0aGUgZnVsbCByZWJvb3QgZmxv
dyBidXQganVzdCBlbmFibGUgdGhlIGZlYXR1cmUgYW5kIHNlZSBpZiB3ZSBjYW4NCj4gcmVhZCBm
cm9tIHRoZSBidWZmZXIuDQoNCkFzIHBvaW50ZWQgYWJvdmUgdGhpcyBmaWVsZCBpcyByZWR1bmRh
bnQgZm9yIGNyYXNoZGF0YSByZWFkIG1vZGUuIFNvIGl0cyBub3QgYSBmdW5jdGlvbmFsaXR5IGJy
ZWFrYWdlIGFzIHN1Y2guDQoNCj4gDQo+IE9yIGV2ZW4ganVzdCB0b2dnbGluZyB0aGUgbW9kZSBv
biBhbmQgb2ZmIHZpYSBzeXNmcy4gV2UncmUgcnVubmluZyB0aGUgUGVyZg0KPiBhbmQga3NlbGZ0
ZXN0cyBvbiBKdW5vIGludGVybmFsbHkgc28gSSBjYW4gYWRkIGEgcmVzZXJ2ZWQgcmVnaW9uIHRv
IHRoZSBKdW5vIERUDQo+IGFuZCBtYWtlIHN1cmUgdGhpcyBzdGF5cyB3b3JraW5nLg0KDQpEaWQg
eW91IG1lYW50IGFkZGluZyBhIGtzZWxmdGVzdCBmb3IgdHJhY2luZyBhbmQgcmVhZGluZyBiYWNr
IHRyYWNlZGF0YSBpbiBzeXNmcyBtb2RlIHVzaW5nIHRoZSByZXNlcnZlZCByZWdpb24gPw0KDQpU
aGFua3MNCkxpbnUgQ2hlcmlhbi4gDQoNCg==

