Return-Path: <linux-kernel+bounces-12862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B2881FB56
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 22:22:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45AB71C21FF5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 21:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B069D1094F;
	Thu, 28 Dec 2023 21:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qYy+I7Fc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671B810947;
	Thu, 28 Dec 2023 21:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BY59AM7x0vi9o379NNZBk5Oc7AEgPGzukGtsRJlElhl0MB1YnBVEQHn7CukWovpi9D+KCXC2lomvPzFdz2AtpUQbWlSswMZguctiPF+bF/D7XUzCBS1ta4ZZy3i4LDihjjRuHNAOMPfn3lOAwmGP+h1RHUiytl1+iLZi2v3qxOGCwZJ2gILqfoDDSJQh0XRVE2GoiwUd/YtCfSVoWekH1BfXThLDK3K49Dwdo/ZALovzQZL67qGiQa7N0A+xrpT2Ppu5zIiyKbAS7Ec0YCpcwKg7lIAVEqn5MJhDo6vyC9PoXOjs3zZ6iqJm9CQSKnGEDImjyQ16+Rk7WUAGMX82hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o3C9n6yospurie3qO6R+pqTFTlZ2mxbKo2dikFol0Bg=;
 b=LzLQ5rvaDLXtgXSJbDa8ZXLDz1Hjwl7JBudtaaVZu4HfjcFDh1yOXs3L/gxrxz09lQxZYSXtJlgBwM6KBsYCaqFwdGMz7OBGqf69yD10fKObNbPI+VlA5EaJSVdev2a13a0nvmDEEeR6erSLDSows3UPA6WHy0rQflpdiC3AAgWQeB1RAkQD7xR2Ej7zYsjz2QtiOjDf00RzW4ILJa1cGxNiIaIkEsXYoXdtq+QI8NertXt9AuDyfYStbnp1YPKlrasDjBFJslTYqSKdF69MjG6gqGpD8H4QscQseGTkA8itb9O8xbwoYdXP3a7jU4P+S9DET86N646FETTB5hjGPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o3C9n6yospurie3qO6R+pqTFTlZ2mxbKo2dikFol0Bg=;
 b=qYy+I7Fc+CyMvk3E1gbXazoJXkzAUjY+OvsxJW1x0Ono6ARaIaYA8V7VhHzkznPWYsuxLbbmbtVCZ0dTaR8a69v9WBZBE+WEWMXmEKxckv+ezmn6TnWYHPrBqLZ/pSzQAZKDhbPvoj/SAjqpyD4//lKW4VamBHx8Hgg+7Kn3GS88GncCx2jWBl2Vwj+UfE7wjAN806uS6Ran7875gEHhTX+4BjauGe+z1kPjS4cKw1HDc7w3m6NxETUS5dcJeBD0KvENHrWQ76/X6UEP38rBpRYn7L06i+dYHrFEIcxkmU0hyI1E9f4mbfVUvjlAwDsRrwT79oUPABcAbJM0S0xBJA==
Received: from CH2PR12MB3895.namprd12.prod.outlook.com (2603:10b6:610:2a::13)
 by SJ0PR12MB5406.namprd12.prod.outlook.com (2603:10b6:a03:3ae::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.19; Thu, 28 Dec
 2023 21:21:55 +0000
Received: from CH2PR12MB3895.namprd12.prod.outlook.com
 ([fe80::7cf:41d8:783:8fb8]) by CH2PR12MB3895.namprd12.prod.outlook.com
 ([fe80::7cf:41d8:783:8fb8%7]) with mapi id 15.20.7113.028; Thu, 28 Dec 2023
 21:21:55 +0000
From: Asmaa Mnebhi <asmaa@nvidia.com>
To: Heiner Kallweit <hkallweit1@gmail.com>, Florian Fainelli
	<f.fainelli@gmail.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"marek.mojik@nic.cz" <marek.mojik@nic.cz>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: David Thompson <davthompson@nvidia.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/1] net: phy: micrel: Add workaround for incomplete
 autonegotiation
Thread-Topic: [PATCH v2 1/1] net: phy: micrel: Add workaround for incomplete
 autonegotiation
Thread-Index: AQHaORrPcVnOjvvSoUWtGDvnSlK8Z7C+YcOAgABRUsCAAAnIgIAABJIA
Date: Thu, 28 Dec 2023 21:21:54 +0000
Message-ID:
 <CH2PR12MB38950311B3A3D338B813763DD79EA@CH2PR12MB3895.namprd12.prod.outlook.com>
References: <20231227231657.15152-1-asmaa@nvidia.com>
 <0cdb0461-ece3-4bfb-b058-9bf75c1f6fd3@gmail.com>
 <CH2PR12MB38952DAF6D1BD4CE6831EED1D79EA@CH2PR12MB3895.namprd12.prod.outlook.com>
 <2f1e9892-261d-4b5f-9fdd-b0f852e90ea6@gmail.com>
In-Reply-To: <2f1e9892-261d-4b5f-9fdd-b0f852e90ea6@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB3895:EE_|SJ0PR12MB5406:EE_
x-ms-office365-filtering-correlation-id: 9acd0ceb-a7a8-4e70-6adf-08dc07eb0444
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 s8Zu8BB7848T+ya07Ky4jhVqz4uZmxXxXuMNXNRdFpK3SRl/f9Scv/7GsuHj1VCu7HZUgvtZkeVR7I/guLWEjZ/L2nD/Qv+pd2zqLI3fUHvWD0m98DKY+zW+u2qdCCW2mjRoVeeugFgNpuNWZQ+Yj+XyYjzp5j10PdedZXygkiZT/j5R1z+g7LbZ3vK5RkJ/qihq5oyqkbGrc55gur2Y4VG9/cy1PZ5blY2FrX14EICnKxXrn2eKbyvWtY8g3YWDXB2QdXayY4cXA/93hTZL9rucxdEMq07iGoWJ/w6rfrf85aSOCARuj/aVxnz+VmTFgJrGjPe+5+hA5AfGcUsCBGhaSyJtHQV5peCUcJMv4ZHbhpeQdBMM1DEtVX1EOJHK0DbVrRO06neK4jsEph5C8/DxqoboE7wHY9IBfCaTTGxUdqVcp3SxRPt4kPDwTrJ2xe0uIhWC4GBRA0gmggO6GRnWjDHyT8kEQym/+G+g7gHYdfNRyQJCy3EKN+F+BliuR4y7e5G6i4z12WeAvnfW3+c0rIMUGUJx6GA6myiNfSIT56QPk+ilWzdoSZoQsHkGLa9KNv21tCa9rDPWvuYAZPywuh/YAEKPt0iCdbEg0kDyakNFJHKA8DY7IbaLmyPL
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3895.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(136003)(366004)(39860400002)(346002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(316002)(110136005)(8676002)(8936002)(478600001)(71200400001)(33656002)(86362001)(7696005)(26005)(6506007)(9686003)(122000001)(83380400001)(38100700002)(38070700009)(41300700001)(54906003)(66556008)(66476007)(66446008)(76116006)(66946007)(5660300002)(64756008)(2906002)(55016003)(4326008)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?STF0SzlKWmRzMWVBbzlsaGNlbmdlSko4bGNGQnA1cjM2VjcvSzF2b3d0VllM?=
 =?utf-8?B?N0k1T1B4UGsvSkVJMnZDZGtRMTl3aWMvRXBEa0I4UGk1VU8wSm02MGRiNHFB?=
 =?utf-8?B?dUFnaFR3THd0QmxzbHBrbWhsWXJYc29jMGxwMVY5K2hKRjh0UCswZ2FkOW9D?=
 =?utf-8?B?WXA4eE5aWnAvVkRiR3JHMHo2OWt2VW5OVjVkcFYwb2U5SVF6Z0huZlYybUYr?=
 =?utf-8?B?Q1NhOFNjRlk4L2ZPVzlUb1JnM0JKQms5WG9qTW9vdlFJUGVBekwxbUtES1ZP?=
 =?utf-8?B?TVlQUHhRL0x0OTNwU1ZuWEZYbE5hbU5pbnFOMnVMaTYyMGMyQ25GSGVZZkxo?=
 =?utf-8?B?YStKZmFGNFJFenFWMTBhakljWFZVUzJzZTliaGtBNDhLVStWL2QyWGp1QXZs?=
 =?utf-8?B?L3BIc242cXBqMU9IQzkvOUYzOEw0dGVENkMyZUs3RGZCdDlGdWo4cE00enl0?=
 =?utf-8?B?WUZoVkNMdTVLVVJpTjcyOHVXZU4zR0FieDZiTVhVNGthQ3l3ZzhHa28yTTEz?=
 =?utf-8?B?bCtEeTBPNWhRYjY2RVh5NTZEVmtMa3FLMEZRR290YTh3UEt5VDM3d2hGb0I4?=
 =?utf-8?B?NHF3ZWJuZEZZRXNKTUxUNVFZcFQxMHZKRUU2c1lyUVJqSzFpZjdSa2RWL25E?=
 =?utf-8?B?ak55bWpaZlYvVEQ5YzFFcFNDcy9QMkFsbHpYa0JhTXJZUHp4cjdLa2xSQUlE?=
 =?utf-8?B?aDZCMHBBSUFCamVvdWgrTzArUWRoVEIxaFJNaWVpQURweVRqdEJJOXVWRU1r?=
 =?utf-8?B?TDhETEgxRXBGaGRYa2hxczZmQld4a25IVVBBd3BQNGQ1VHZabkVhZUJnRXBx?=
 =?utf-8?B?RXVuU0U2Rk8xdHQ4L3h6WEp5aHR5M2VGbnNBY1ExaVlML3JBRG9SREErYitu?=
 =?utf-8?B?cGxmMUJEditkMEhDZmxFdDBrQlU2NTdySTZVUWIrMWdjTktQelNYYk9DdUxG?=
 =?utf-8?B?TGUvOVNlZC9nQms1dWd0aTM1YjBCMld6RE9QQXVkcWVHYXJTUkRpRFRnSlQ3?=
 =?utf-8?B?c3ZqbndQZEFMRStLWi85RmNGTlc4VWh0VVNFOTgzdk1NNzg2VG5uYTNzcVlK?=
 =?utf-8?B?Rjh4ams2T3ZnYnBiUEg1b2R2andPenAxSzBPN0kvZnhuNUxwbFZkdGdoV0FL?=
 =?utf-8?B?Z3Y0Yjh2VGs1blBNSTJYbjJ1bFFIem1aQ0tWVXNjbjk5TTEwejhQYm15bXRR?=
 =?utf-8?B?NXY5NW54VnYwZU9rVVJWUVhnRGlpS3JTcnNXMmE5NmJFdFlpbG1tRjhPSFhl?=
 =?utf-8?B?U2RSN0RraDFUVUxRVy9FR3QxRllZZlZmeGVMSjhadmc1Ly8vZkFtK3ZZNCtZ?=
 =?utf-8?B?RSszai9GbVdYOW9LR0VkdVRFQ3hlYUdyRzVqMm5RNVpJNGVQN0diMWhHYXpt?=
 =?utf-8?B?aTUwWWlDeUtUS1JZMUc5M1EweWgybmlJV2pOQ1kzWjhMZG92dlg5L01oVStM?=
 =?utf-8?B?aVZ5Qk91d0wxL1E0aDdNRitxd1B3d0RkZjA3Qkw1b1ZjeW5UUG9Od01wMk5V?=
 =?utf-8?B?UnpUT1BqNGkzM3NEZHRZSjRUSis2R3AyTzhVQ21rYitmOWlVL04zMnljUzRy?=
 =?utf-8?B?MmF2aldWTTgxWmtLR3NaQU9VMjNKblhwM1M2SkxHNGhHWHRTSHpoZjVndCtN?=
 =?utf-8?B?QzFrMnJWN0tFbmN0UkZFQlcrcVc2ZGhPWWRvRGJ3aU5kWkVZVExJL1ZWM0dh?=
 =?utf-8?B?UXdEd3UrRTJMS2lYaUxwT2JhNW5rTmh6OSt6OE5UOUx2bDNCNXAwUmFnaWFR?=
 =?utf-8?B?UUNNc0Z4a0tUa2k3TUZHUXFicFgrOC9CbUtndXVDQjZJbmpSbU5rRkhxV0dW?=
 =?utf-8?B?ZXp0MVdBV2xjS2J1YkU4QjZYcWJRVDFETTdrYzBQamhMc004STVCeHpqMS9S?=
 =?utf-8?B?R3lwMGlDelRVdjl0MEcrdlUxSEVjUzJ3Nk92WW5kdzJWZm1TLzdmUXNaMll1?=
 =?utf-8?B?SXVCVzl5QlE2ODErazBPaEVTTXVCUFgwZm5sVU56azZJYkpKVW1DM0tHUzhq?=
 =?utf-8?B?ODVEOVJYWlBWejN1WG5FamJXbEdaK2daWkJjSUd3VkczMmNPMm5GR2FZVUpN?=
 =?utf-8?B?SXZMM2p3Y3F3ZHFVd29IU1B2RUJvcjRPZXREcng2b0NES3g4MUVFTmJ3amRt?=
 =?utf-8?Q?B7Bg=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9acd0ceb-a7a8-4e70-6adf-08dc07eb0444
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Dec 2023 21:21:54.9788
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WZUJTMsVcpvmjxU1TDfFxr+BxVPV43ZLgipaNsQu68fvDpjWjGyrNnpKwNp56hQyyI8uCEt/quxu48ZeUPBuXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5406

PiA+PiBJcyB0aGVyZSBhIE1pY3JlbCBlcnJhdGEgYXNzb2NpYXRlZCB3aXRoIHRoaXMgd29yayBh
cm91bmQgdGhhdCBjb3VsZA0KPiA+PiBiZSByZWZlcmVuY2VkIGhlcmU/DQo+ID4NCj4gPiBIaSBG
bG9yaWFuLA0KPiA+DQo+ID4gTm8gdGhlcmUgaXNu4oCZdC4gVGhpcyBpcyBiYXNlZCBvbiBvYnNl
cnZhdGlvbnMgYW5kIGNvbXBhcmlzb24gd2l0aCB0aGUNCj4gYmVoYXZpb3IgYW5kIHRlc3Rpbmcg
b2Ygb3RoZXIgUEhZcy4gRm9yIGV4YW1wbGUsIHdlIGRvbuKAmXQgc2VlIHRoaXMgaXNzdWUgd2l0
aA0KPiB0aGUgVml0ZXNzZSBQSFkuDQo+ID4NCj4gVGhlIE1pY3JvY2hpcCBLU1o5MDMxIGVycmF0
YSBkb2N1bWVudGF0aW9uIGxpc3RzIGZldyBsaW5rLXJlbGF0ZWQgZXJyYXRhLg0KPiBNYXkgYW55
IG9mIHRoZXNlIGJlIHJlbGV2YW50IGluIHlvdXIgY2FzZT8gSWYgbm90LCBwbGVhc2UgY2hlY2sg
d2l0aCBNaWNyb2NoaXAuDQo+IEtTWjkwMzEgaXNuJ3QgbmV3LCBhbmQgbW9zdCBsaWtlbHkgd2Ug
d291bGQgaGF2ZSBzZWVuIHN1Y2ggcmVwb3J0cyBiZWZvcmUsIGlmDQo+IHRoZXJlJ3MgYW4gYWN0
dWFsIGlzc3VlLg0KPiBJJ2QgbGlrZSB0byBhdm9pZCB0aGF0IHdlIGFkZCBjb2RlIHRvIHdvcmsg
YXJvdW5kIGFuIGlzc3VlIHRoYXQgaXMgc3BlY2lmaWMgdG8NCj4geW91ciBzZXR1cC4NCj4gDQpU
aGFua3MgSGVpbmVyLiBJIHdlbnQgb3ZlciB0aGUgZXJyYXRhIGFuZCB0aGVyZSBhcmUgY291cGxl
IG9mIGlzc3VlcyB3aGljaCBjb3VsZCByZXN1bHQgaW4gdGhlIGxpbmsgbm90IGNvbWluZyB1cDoN
Cg0KMSkgTW9kdWxlIDE6IERldmljZSBmYWlscyB0byBsaW5rIGFmdGVyIEFzeW1tZXRyaWMgUGF1
c2UgY2FwYWJpbGl0eSBpcyBzZXQNClRoZSBtaWNyZWwuYyBkcml2ZXIgYWxyZWFkeSBoYXMgYSB3
b3JrYXJvdW5kIGZvciB0aGlzIGFuZCBJIGhhdmUgdmVyaWZpZWQgdGhhdCB3aGVuIG91ciBpc3N1
ZSByZXByb2R1Y2VzLCBvbmx5IHN5bW1ldHJpYyBwYXVzZSBpcyBlbmFibGVkLg0KDQoyKSBNb2R1
bGUgNTogQXV0by1OZWdvdGlhdGlvbiBsaW5rLXVwIGZhaWx1cmUgLyBsb25nIGxpbmstdXAgdGlt
ZSBkdWUgdG8gZGVmYXVsdCBGTFAgaW50ZXJ2YWwgc2V0dGluZw0KVGhlIG1pY3JlbC5jIGRyaXZl
ciBhbHNvIGFscmVhZHkgaGFzIGEgd29ya2Fyb3VuZCBmb3IgdGhpcy4gDQoNCkFwYXJ0IGZyb20g
dGhlIGVycmF0YXMsIEkgc2VlIHRoYXQgdGhlcmUgd2VyZSBvdGhlciBLU1o5MDMxIGlzc3VlcyBm
b3Igd2hpY2ggd29ya2Fyb3VuZHMgd2VyZSBuZWVkZWQgaW4gdGhlIGtlcm5lbDoNCjEpIGNvbW1p
dCBkMmZkNzE5YmNiMGU4M2NiMzljZmVlMjJlZTgwMGY5OGE1NmVjZWIzDQpuZXQvcGh5OiBtaWNy
ZWw6IEFkZCB3b3JrYXJvdW5kIGZvciBiYWQgYXV0b25lZw0KDQoyKSBjb21taXQgYzFhOGQwYTNh
Y2NmNjRhMDE0ZDYwNWU2ODA2Y2UwNWQxYzE3YWRmMQ0KbmV0OiBwaHk6IG1pY3JlbDoga3N6OTAz
MTogcmVjb25maWd1cmUgYXV0b25lZyBhZnRlciBwaHkgYXV0b25lZyB3b3JrYXJvdW5kDQoNCmlu
IG91ciBjYXNlLCBJIGhhdmUgdmVyaWZpZWQgdGhhdCB3ZSBkb27igJl0IHN0dW1ibGUgdXBvbiB0
aGUgYWJvdmUgMiBidWdzIChpZGxlIGVycm9yIGNvdW50IGlzIDB4MCkuDQoNCk91ciBRQSBzZWVz
IHRoYXQgYXV0b25lZ290aWF0aW9uIGZhaWxzIHRvIGNvbXBsZXRlIGFmdGVyIHJlYm9vdGluZyB0
aGUgc3lzdGVtID4gMjAwMCB0aW1lcy4gU28gaXQgaXMgaGFyZCB0byByZXByb2R1Y2UuDQpPdXIg
T09CIE1BQyBpcyBjb25uZWN0ZWQgdG8gdGhlIE1pY3JlbCBLU1o5MDMxLCB3aGljaCBpcyBjb25u
ZWN0ZWQgdG8gYSBzd2l0Y2guDQpJIGhhdmUgY2hlY2tlZCB0aGF0IHBoeV9zdGFydCgpIGNhbGxz
IHBoeV9zdGFydF9hbmVnKCkgYW5kIHRoYXQgdGhlIGdlbnBoeV9yZXN0YXJ0X2FuZWcoKSBzZXRz
IHRoZSBCTUNSX0FOUkVTVEFSVCBiaXQuIEFmdGVyIHRoYXQsIGl0IGRvZXNu4oCZdCBtYXR0ZXIg
aG93IGxvbmcgd2Ugd2FpdCwgdGhlIFBIWSBhdXRvbmVnb3RpYXRpb24gZG9lc27igJl0IGNvbXBs
ZXRlIGFuZCB0aGUgbGluayBpcyBkb3duLiBSZXN0YXJ0aW5nIGF1dG9uZWdvdGlhdGlvbiBhIHNl
Y29uZCB0aW1lIHNvbHZlcyB0aGUgaXNzdWUuIA0KDQpJIHdpbGwgc2hhcmUgdGhpcyBpbmZvcm1h
dGlvbiB3aXRoIE1pY3JvY2hpcC4gSSBob3BlIHRoZXkgY2FuIGhlbHAuDQoNClRoYW5rcy4NCkFz
bWFhDQoNCg==

