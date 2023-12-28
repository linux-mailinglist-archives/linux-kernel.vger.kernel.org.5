Return-Path: <linux-kernel+bounces-12686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E1C181F8E1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 14:37:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9E222849BD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 13:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7438D8829;
	Thu, 28 Dec 2023 13:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MHGc5m9w"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE235D2F5;
	Thu, 28 Dec 2023 13:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZwBOjP0yobdQsS5d9ajFVJ4a0BPUE3mjJn1uBfCDC9bFak2VvpZXchDCM+LuNryTVXmtrUq5iUywB7WZdD7i6lvi3y6/nPQgNlrvgLDAk2eeooIQM/QfEh9Pk0Jv9wAJ+7TbxqxiHlzdoBVIo2Epur8hG9rDZaPFIUlRWrHeK0jqJh9Hc5ncbJbA1ryLiKZs7C2C54YweeNsqiQ1oMMZ4Bbq99ezHvwRY7SXUvXGv4c3T1PzR1nJgcxLGyanoLVELIlxiHydtHDA7YdbHZVOdQQtIzrR3jWtWVVdHvAwsgYE5MAMIBPY+9xNU6h19jF9JFQVAOerd//+a7FfHtQEVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pptrrlQlpKq2fsVvyUWwbEwlfbNqjTTS/Z7aGNget4c=;
 b=F3hwWhHA2f8YaeCtIrq360woG3r4Q/ay/XpVxTRl1cB83Z71C0sUb1JmCn0ucDgiyw+JjXETRQ/Ed3p5FJtM/mbYcWPKwDOGuMm2k1uqqfYiGopIzWhclDHiYabGcjSqXQ95PyrOZwJ86WfqPOBzigN/fWxz/voNQuqMYfz932444qWcvmFHMQgO/Lmrgw+pcWaV6Mk8vq721DMh6kEw/gjlURWp5VOkTuDf5HJ88gMlEJB+nQqfCLt0ANpH8Jzr8kVB/H13cKNBrie7yISm8sm/MSjwiPgf78kxVAM9KMldKOWyG73oGijrFOZZ2BFJB73dTffsTHDurrAwMgbiTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pptrrlQlpKq2fsVvyUWwbEwlfbNqjTTS/Z7aGNget4c=;
 b=MHGc5m9wz1s+8eixGLSX4/KKY1zA/6muqwGC0elqyR9QUQMwk7WFgRkIKGT9WufSNVySFpOVsJDxbVAzFMkxw+WoDvuuErjfC9xOY9Ko3L7W9VZhdpoT1vxXPHv6y6xi+dHjONDTzJ6XFO/VGkVZU8O0xGP6BhTHN1F4sls4iZo2x6hHk726qUtyRVAOK/A26RNn/zmiuJ4U0DVU8zrkvPugKVvPJNfts638SA7yep2x/hFVqi56vc+1Wwe7BXD8GXkx1EmCDy3y1N2hN2tKLW0MrLQS7JIflw0e8HzxNgxfqFGHmCCEGkmqBM+qLFlqD1CzlEVkLVAG/yiHrZ+ZLg==
Received: from CH2PR12MB3895.namprd12.prod.outlook.com (2603:10b6:610:2a::13)
 by CH3PR12MB8484.namprd12.prod.outlook.com (2603:10b6:610:158::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.20; Thu, 28 Dec
 2023 13:37:21 +0000
Received: from CH2PR12MB3895.namprd12.prod.outlook.com
 ([fe80::7cf:41d8:783:8fb8]) by CH2PR12MB3895.namprd12.prod.outlook.com
 ([fe80::7cf:41d8:783:8fb8%7]) with mapi id 15.20.7113.028; Thu, 28 Dec 2023
 13:37:21 +0000
From: Asmaa Mnebhi <asmaa@nvidia.com>
To: Florian Fainelli <f.fainelli@gmail.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "marek.mojik@nic.cz" <marek.mojik@nic.cz>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: David Thompson <davthompson@nvidia.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/1] net: phy: micrel: Add workaround for incomplete
 autonegotiation
Thread-Topic: [PATCH v2 1/1] net: phy: micrel: Add workaround for incomplete
 autonegotiation
Thread-Index: AQHaORrPcVnOjvvSoUWtGDvnSlK8Z7C+YcOAgABRUsA=
Date: Thu, 28 Dec 2023 13:37:21 +0000
Message-ID:
 <CH2PR12MB38952DAF6D1BD4CE6831EED1D79EA@CH2PR12MB3895.namprd12.prod.outlook.com>
References: <20231227231657.15152-1-asmaa@nvidia.com>
 <0cdb0461-ece3-4bfb-b058-9bf75c1f6fd3@gmail.com>
In-Reply-To: <0cdb0461-ece3-4bfb-b058-9bf75c1f6fd3@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB3895:EE_|CH3PR12MB8484:EE_
x-ms-office365-filtering-correlation-id: 2a5d51a1-da0c-4e62-a64e-08dc07aa1e3f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 8ooHriWkQQD+ER3L7ST0/4vMLapUUI7jX7mISyY7zP5h7N+w9oSDgUHdn4N9zu9mvMxozz5J6KFDgcoSxnEWFyAWAW7zKAuBRqR6eL+rlxGuZImKRMWNAly1x2TrsHOiLeAfLCqd3lurO4JO2yZ4POL2Ep2bGtfum/4f9fkN48k6DVEAv5UK77VlslH4uhyJePg6diR07mBFwMS7bowzxG6yaDNBgEWS4zHalwqPhNa7ooFW0HQ+vIyXmAI2ZlYTrgXkv/MVzpX4Nw5HWJJtwV4x3fV1a9Q8EKYlQRXFPRrVnW9HKo9jPsfbN44SDloLPQ/14G7v0G9raQiNG36N3Jg4CwF1YNioehYge8JB4OrYi5yhFlgzcGvrNmF0J2bXlcGjReVYYAZw2jCuRF8/GtIZfwziw0H8Kk+5ECAD6eSv+WZwI/0pYy7tGHy1TVr6X7GtdPIMzLL4XMCQz/MWkpOcEF2ZuDAZEJVLHVe5VfgrPMbhFqXgsmetnS9AQidWzWLbkTiEA9JufrFoFL6pNvT/Q+v4hq+oJdFl8iU91gGa4Cy6s6Ed4xtZJuFQ7gSkLyxmDs+P6ml0a4TH4G5M271LhpM8C9xr1LJ2NJqdhxN1N5+nHtEUgzq7HbGz/lyP
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3895.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(396003)(376002)(39860400002)(136003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(66446008)(66556008)(76116006)(66946007)(66476007)(5660300002)(55016003)(2906002)(52536014)(4744005)(4326008)(8676002)(8936002)(316002)(110136005)(54906003)(64756008)(71200400001)(38070700009)(53546011)(9686003)(7696005)(478600001)(33656002)(6506007)(26005)(122000001)(86362001)(41300700001)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dVlBd2s0TmNpTGNtQ00wVTlCSlFTWEdnUXBHaVltYU9PaVZCbWV2MnRuTGJ2?=
 =?utf-8?B?S3c5cVE4eG1QVnBKZFBUQ0Y0UmVjR3N6eFVRRU9SVnJUV0wwU0xNWTllMzdZ?=
 =?utf-8?B?b0lZdlAxUWsxbW11MWx2OVlPWkxMd016dHR0aHlLeVYxTjZxUmU3cEJkb00r?=
 =?utf-8?B?WjQ1YSt5NnJ1RGZuSk0xNTlrTCtvR3JDczFXMi81T0ZYSGlNTnc4cXFVSnBh?=
 =?utf-8?B?WDFVei9pZHFGdWVITkhIYzFQV3Z2emx1b2w0U21JdE9nSjlwU0JRd0xCMlVy?=
 =?utf-8?B?M21Yc1JVa0FHSWlFaVZzVWtiazBPWHFBSVMvVHN4WTlITnhMelZJWlZKSE5Q?=
 =?utf-8?B?d3VzUndMd3MxZjhGM1N6ZTlNTVRpbnJ5NjMvWTdIUjVReEMzNjhCR2drOWVK?=
 =?utf-8?B?UXZRakRBSWI0MVZuQXRsdFlZVEY1d0p4VzhQVElCdDNsclZPQXpLRmRtdlpG?=
 =?utf-8?B?M05jNGlhZEJQbUVxUlhadGVOam5xS0hOVnBWOXBKK0J5NGo2MVdOeGRZSW5Y?=
 =?utf-8?B?MTJEeUZxemtJQWtwbHdCeGpnWXpRcUxMSmt0WVZpUXpvOW5nekdtdUtzQlpB?=
 =?utf-8?B?L01ZSUZHRjZ6ZXU3cXVwdFBpT2lKazEzKzdSbHFVRnNQSldnUG5HaUJGR1JB?=
 =?utf-8?B?dVlsMlRRK0J0TlZ6RC9sV3hid0g0cWVjMEZQb2IvK2pQTEFtemRCbFlkS2ha?=
 =?utf-8?B?RG9yVWNSR3RTMlI0anluMFdaWURhSldMT1ZFRiswSzAvaFg2R1VWZks5L3U5?=
 =?utf-8?B?UmhKOWd1cngrOWo0SHdBNjJyQmdVVEYyS3F6K2FpaWt4QjIzd0tvczN3ajFE?=
 =?utf-8?B?UXU1bWI4VXBERTJib1FnMDRDTWpURm8rOGdXcGE5NVIrSi9FVDkzTDExWkF0?=
 =?utf-8?B?REQwRk9FejhNVXVjc0hsajlPaWpNczU0Uks1aU42UE5hWTVocVRHOUhTNmpt?=
 =?utf-8?B?bm1BOVVUTStDc2RTVEUzZldleThGNlJmZ2VrRXFOWXQrYUE5ZXlOdm0ySXBl?=
 =?utf-8?B?c21RR2N5Y1dCMHRlekpSaC8yK3BDMyttMmFZZ0UwU0VSOCtjYi9uZys5ZWJ5?=
 =?utf-8?B?d1JLbzJPM2Nyb2JtWmtlWGZjQkZhNXBUTE56b1JEeHRlT1BBd3lucHRjNHJn?=
 =?utf-8?B?RmhlODVoa2d6N25jUEhsZ0laY2E5eXl1Sk9TWlQxRWljVUlXOXAxT2piYzBX?=
 =?utf-8?B?NUdjN1JKOHIvc295Y2NyampieHk4MTRqWnRZS3BMdkVmYlE4dXYzUGJBU1lq?=
 =?utf-8?B?cHBuRVV1TE82Y3loWGl6b3o1NFBDNUdna0JMYTByTExHV1lQMHU3dG1QSnUw?=
 =?utf-8?B?czJHcTZLbVZpY04vREkxeWw0VGh1NjhBOG1henhIbmJhUENBYTNCTjJtcmJU?=
 =?utf-8?B?a3JYWkU3bkI3dndLV1JuRjFSbGZSb3RNc25JeFQ2K0ZHTnBMZ1oxQkN0YytQ?=
 =?utf-8?B?ZC9teHk5R1BDM01uMEMvckpnVU5jVnkwSmZaM2ZYM1phbUYvQ2pQNmt5SXJw?=
 =?utf-8?B?SXBlMzFMTkFQL1pUSEdMcUdmcHY2QUVWazQ0U0hoRVI5Yklra08wUndVR2Jp?=
 =?utf-8?B?OG1DYjhja0lmZW4zNE9YdzRneFBpb3ppT1liTkFuSEZlVVRkaHMvblZzM2h3?=
 =?utf-8?B?T1ZKTUcrc0gyUWpMZGRnQWtoZ1FTU1ZvWDdvZXM1Wk5QaWc3TFdJT0wweGo1?=
 =?utf-8?B?MVZqcXBVVGNyVytZbVk1c2Z1MGJmam9tYXpJZjQrWGVIQk1Yd0lLQkx0dWdT?=
 =?utf-8?B?YVhBcUY4RnNmUkxTWVZYYWdmbWxKdnZMT3hjTkI4c0xDbEdPWkFtZkRHTFh1?=
 =?utf-8?B?Sk1vUk1wT05yTlFMS3pWeS9nSytSTThUZXNlZmhxVUM4TDFqSmp5RUVNU3RQ?=
 =?utf-8?B?VmtuVE5BS2FLRUJnZFJKWUNUbUR6c2tZT2EzN09MQmFqSlNXN3RDRXRhZHhI?=
 =?utf-8?B?UTUrdHlETGVrWWZoTkoxZE1Nb2dOVXIyMDF4NXFPM0Q3WGlJSVcwSGZvTjRk?=
 =?utf-8?B?b0p5TFowOWNSSTkzV2RqWlM1YlJ1U29sbXZEVnFzWGxtTFRTbUdpSnRqbWRC?=
 =?utf-8?B?Vk9UZmJIdW93YmpIcWRNWE45SlI1WHFON3RtYlNIK3dBOXdTRUJUaXM5djR6?=
 =?utf-8?Q?yGEk=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3895.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a5d51a1-da0c-4e62-a64e-08dc07aa1e3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Dec 2023 13:37:21.2459
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Rjbf9Q+Epf7hPF9Cd5pN1f+ByZ41DCAEu3U0MfKOvh9D+K4QvoTTnZeLb47l9WDoPfTC5AMV6fVjs30L+5A0Hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8484

ID4gT24gMTIvMjgvMjAyMyAxMjoxNiBBTSwgQXNtYWEgTW5lYmhpIHdyb3RlOg0KPiA+IFZlcnkg
cmFyZWx5LCB0aGUgS1NaOTAzMSBmYWlscyB0byBjb21wbGV0ZSBhdXRvbmVnb3RpYXRpb24gYWx0
aG91Z2ggaXQNCj4gPiB3YXMgaW5pdGlhdGVkIHZpYSBwaHlfc3RhcnQoKS4gQXMgYSByZXN1bHQs
IHRoZSBsaW5rIHN0YXlzIGRvd24uDQo+ID4gUmVzdGFydGluZyBhdXRvbmVnb3RpYXRpb24gd2hl
biBpbiB0aGlzIHN0YXRlIHNvbHZlcyB0aGUgaXNzdWUuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5
OiBBc21hYSBNbmViaGkgPGFzbWFhQG52aWRpYS5jb20+DQo+IA0KPiBJcyB0aGVyZSBhIE1pY3Jl
bCBlcnJhdGEgYXNzb2NpYXRlZCB3aXRoIHRoaXMgd29yayBhcm91bmQgdGhhdCBjb3VsZCBiZQ0K
PiByZWZlcmVuY2VkIGhlcmU/DQoNCkhpIEZsb3JpYW4sDQoNCk5vIHRoZXJlIGlzbuKAmXQuIFRo
aXMgaXMgYmFzZWQgb24gb2JzZXJ2YXRpb25zIGFuZCBjb21wYXJpc29uIHdpdGggdGhlIGJlaGF2
aW9yIGFuZCB0ZXN0aW5nIG9mIG90aGVyIFBIWXMuIEZvciBleGFtcGxlLCB3ZSBkb27igJl0IHNl
ZSB0aGlzIGlzc3VlIHdpdGggdGhlIFZpdGVzc2UgUEhZLg0KDQpUaGFua3MuDQpBc21hYQ0K

