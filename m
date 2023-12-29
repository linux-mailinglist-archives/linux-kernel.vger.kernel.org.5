Return-Path: <linux-kernel+bounces-12967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4D581FD6D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 08:11:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCD101F21C40
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 07:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D0D568F;
	Fri, 29 Dec 2023 07:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MyMvE/Qw"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCCC23B8;
	Fri, 29 Dec 2023 07:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JQoHAbfS2wWFH3j0/aeYs1f6AFBPsm4Mg1qVIAPrN2UIgCfBHbkQqpuTpiOsnJ+/rHmbJmecvBgPTjclx986E0Mb5CxhRNiqFKIY/4EXfZkBSbjlb+c6Ho8UhInBSWN9nDOvVSwzH0hXGAme8E2pwuvyc8CJdWHmyIc+lUxPPbHhqp6eiPzV7eW5If1iWmCWWZEphiMrDrcj5V9BOQQdBcHeXntJhLXr/ep2JvHFtY/p71UzgIrHFsiedwSo7Ho4aPFr+JgvR5Iz5WiRMXPMe8H8YRb3KJH78Py1zM1DdEKwuNp8eSssVwyu5bP8GVZWZIDwtiH0vcj812nSPR8xWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zBIUz8cFswFHWQWXdVvE6u8Paq1ZGIctxR4LcCydwQ8=;
 b=c3keGP55M+Dm06AcGaB/rfRiBrVHqHCDVlfG0D++0Ys3HaYJzcJTkJWhJ3azwe6IFVpziH3hHqX8AmcI/V2bCwa6/FQfOk1coboJyud4i97v0zry+u9CeWUhux8N6BqnCvTug2yyCpRJtJHJJf0mNBbx4CyRW9mtBK3GGxr2XYmjVj/8xMq7Sr9pQBmsStvFooeSaVkc51pGI1NtcsM6BIHxT2JpiNlwSoq9RrN+gwXvjpB115ar8AaBH6UK0VYJujb46S3e30rxlZ7VS5fKrZQuCQ43mzRRu//fGsR1wPpMX4gNVnonczdJCW547Wyc4KR5MDw+q6c6CyUeGuiNQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zBIUz8cFswFHWQWXdVvE6u8Paq1ZGIctxR4LcCydwQ8=;
 b=MyMvE/QwcMngf99C0HpImTxWw8WkRSfKHyUZJjAKewbjdIvwhTQM0Da0d4jknATYoarWn+aawkhg5Kwm8I/T+o+IrUDxfcezFNoS6MwOJAbc0SAY6N9ZrkYDVx2GRmfiYNhfCAVoZzCxZoH9wCtB1EzkzaaxJZDhOaWiRy2fc6omfXThpc3/V5txEFLgCsEXHUdSoYihG9+4j0oc81Th/yXA9cXaTN0RD1HYMJ9g5MP5+6/Xoy7dygW0LlUyrJ+WLptLrcWg4vMyHq0c7EhK0xGoCUtnmcFxd61tAgt1FnAPw9MquZ2wOrWLH2Xh2iuT1w9eswLhMoKStn0iw7+qHw==
Received: from SJ1PR12MB6339.namprd12.prod.outlook.com (2603:10b6:a03:454::10)
 by DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.29; Fri, 29 Dec
 2023 07:11:32 +0000
Received: from SJ1PR12MB6339.namprd12.prod.outlook.com
 ([fe80::d18b:57e8:ee01:bd48]) by SJ1PR12MB6339.namprd12.prod.outlook.com
 ([fe80::d18b:57e8:ee01:bd48%6]) with mapi id 15.20.7113.027; Fri, 29 Dec 2023
 07:11:31 +0000
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
Subject: RE: [PATCH v2 1/5] dt-bindings: crypto: Add Tegra Security Engine
Thread-Topic: [PATCH v2 1/5] dt-bindings: crypto: Add Tegra Security Engine
Thread-Index: AQHaMnrYj4FV6eNlVUSo6pNY1YZjfLCyUfWAgAvyqLCAAEfxAIABUE+A
Date: Fri, 29 Dec 2023 07:11:31 +0000
Message-ID:
 <SJ1PR12MB6339008197C4E7F8FEA3C783C09DA@SJ1PR12MB6339.namprd12.prod.outlook.com>
References: <20231219125614.33062-1-akhilrajeev@nvidia.com>
 <20231219125614.33062-2-akhilrajeev@nvidia.com>
 <fe87e220-560b-4d47-bc7f-cc7104d40921@linaro.org>
 <SJ1PR12MB63397127C6E6D1289FA7E464C09EA@SJ1PR12MB6339.namprd12.prod.outlook.com>
 <662833e4-fd2a-481c-9d40-5e691d9a0cfa@linaro.org>
In-Reply-To: <662833e4-fd2a-481c-9d40-5e691d9a0cfa@linaro.org>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR12MB6339:EE_|DS7PR12MB5744:EE_
x-ms-office365-filtering-correlation-id: 50db0447-c8cf-45a2-e49c-08dc083d6266
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 XPR19tuuotLSTGqvpRBGHXDxv0ozRen7RkGNKgYJxEXxIrHjAX4w/pctoibeWOLMpF0AW5X4oXMrpzRuv6mnrF1eR0Hbd6WkoBDp9o/lskPTUAwvKvaXpvyridairz550JdhHu1YSA7GG+TkEhnSb1EH0Jz+LdUCLu9cGlhBGInmOytuuJUmBGRzk0lfLU4lBvBXmnvDMolZL4/3VcGtwtDyN8U1uWjOhV6y8F06WE0XvZuqGgKtDeCGwgc9SDNfkGwTSTkoqsuWSgZ8zvs8DKSn4fKcgLQftyWIq8M4G7C8MQAdJUTkn2a4dxXcojzYZytDFELf9DboQBZRMx3k3sap6FgU6OQAEK7p+oIdlvhsENPb8sX1w/D81ftuzB932OtXCqjAf/LBulADkoS9iGkrKcYde10STcKJVKExb2jaB6CIFZWzDPcaXheshpiG1s/kER7WT7HWvqlXPd8fhY1+VWihtIaJsSlOMBuvV6V8X2KTtvcI8K+AA6vLjbHR634D1GgJhkuzTayYuqQ7vE2L2IrmPJdimHz4KyAKlE1vCk2biVP2s3nTvvb7QMRRFlIqqeLAoOP3PHh4SLT8qRdqJjJ4MtBejD6qrYYcV3yZTZ3VFS/KLIe9qPDhL48H6rZLoFNCN3fO0E7ZS/R9lQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6339.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(346002)(366004)(39860400002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(316002)(8676002)(110136005)(8936002)(478600001)(7696005)(33656002)(71200400001)(9686003)(6506007)(86362001)(53546011)(38070700009)(38100700002)(122000001)(41300700001)(66556008)(66476007)(66446008)(76116006)(66946007)(5660300002)(7416002)(921011)(2906002)(64756008)(55016003)(4744005)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?V1dodlFVQ2RFRWFQSlZhNHg2SzJDd0VZdDNvU1pnRlJjKy83aEo0dXpidkNE?=
 =?utf-8?B?enhOaXhHbUhwSWNnTHBzZkYxbjlyWld1Q0NIVThGa0Y1VXJyVTdvRzJmam1y?=
 =?utf-8?B?UmdaTXc5QnVIOEhEZmFIVytIdXg1bWRVUWpQWUxHbVRmY3hOL0FkNlFQS1A1?=
 =?utf-8?B?LzYxMHR6MCtHWmlQcUU3ZU5UQWp6TE5RbEZqcEVvSnYvVHBTb0ZMbGhrV1NJ?=
 =?utf-8?B?djEyNm5Yd0tmR0thNFpEVmV4WFBTNk1OU0FURTNUc1VuZWxrTFpFNkhOVy81?=
 =?utf-8?B?dWlvbENSTEpOQ3p3bXMrdW1YVGRDSzdmTjRlK3ZPZ3JKYzBlN3R6T3A3THVH?=
 =?utf-8?B?T3dkUUUwQjc4Q25TaWpvYWNyUzJzck9yQXJsRXhXTnBtMm1DVXZIc3FiUlpt?=
 =?utf-8?B?TnZQdXNham4yaGZqYUhQZ1pQby9vMWZOd3RiSmwwcWxQUWRVMHkzNHAwcDNS?=
 =?utf-8?B?cExZdDU4VnYyMFBYQzdKWUR6UHBSR3JsZG5lVWhVc2JWUEdvcU9Ld3ZxK0NC?=
 =?utf-8?B?UzRnUWtrdG94OTU5aGpWM1dFUE0rQ0R4WU4wMHJTUWk2OUhaVnVubkNjVFRo?=
 =?utf-8?B?OWxUbDZEYXR4Mklxc1RVU1NkczlkM296TlNlNllwMnhYV0Rkek1KZUdZMVNt?=
 =?utf-8?B?eGNTaVdoYUJxNjc3Ulh3SVFHdlI5dUx3YU1NNTNCbncyZTc0ZkFRbGliSW91?=
 =?utf-8?B?a3dFVDBRTjJzVTVjTHZMMW5jN0toeWJSbG1UamN4ZEpSMXNUaTlEQnhzcGhh?=
 =?utf-8?B?Z2swcVRFN2RxOE1xRFA2M0RSOVZlbDlhdVlOc29rS1pIb1hreW05Z0lDemN2?=
 =?utf-8?B?ZUlXQWRMVy81RS9zd0lhdmQzVTJHM0s4dWtldlltSHpCbGRNQmRuU2l2Ylgw?=
 =?utf-8?B?STN2d3NPM244OWRGZ2hMSVRaL2kvR2RaaXM0ZjJ1OGpOV2FCY3N3OFdjMnU1?=
 =?utf-8?B?aDl2cW53SndxWSttUmUrR2RzNjc2VDIzbEdxUy9Pd05MdDVCcDVFRmhqQVdq?=
 =?utf-8?B?V2JoZVRpWDVzbUlCMC84cUhab2NUVDh0aHZGTC9VTmpVSWpjOHlFMGRCVUZt?=
 =?utf-8?B?Y1hTbks0bGNsUTVHOFozSGE4Q29KNlRMTW5TWDczaTFsbUMvQitzeXRlRjBT?=
 =?utf-8?B?ZnRZTXRhM3I1aHZkRzRJWExtSFBaU01VaUhkMVhNWXdTZmF2a2lzNmdEYWhK?=
 =?utf-8?B?L0NlVWhaNGJ6NGtGcG4wSHdLc2FSSG9NWWxyNnhOT01YcU44Q0ZKaDVEbXVF?=
 =?utf-8?B?Ym5IL3IrQmF1Vm96YThMbzNpWXVHeDVleENCd3NkMHdGZjZiRS9OL0Y3WUFw?=
 =?utf-8?B?c1dtaVFMTGtiS1Y4L2RJNW5XL0RPQWJESVZ3OUJwb3R2M2FNRjZEWVNqbUgx?=
 =?utf-8?B?aDRxZnp4UXlSZFpSeFVNSDMvT3p6K3RUNmVmWkRteWx5SUUzN2taMzlybndr?=
 =?utf-8?B?R0l2NkZJdmlqYWpzN1hUZDR0YndpVE5BNGQzQVZxcEVGVkNVYUtNMDJGS3Zs?=
 =?utf-8?B?bFZDZW0xUGQxWjF0SktCbm9XeGlPUXhLK0FJVnV0VWozbUVSQWxlTlg0MVhk?=
 =?utf-8?B?VzJlY3Y4U0xnb3JYUzJMUUI5eTdpR3Z6T1FFRFhJVHg3N2hRZmRZaGFEbDhE?=
 =?utf-8?B?VE5xVHh1cmlIRG1TQTFTa0JiYkgzYUJSSmREOXAxMHdSb2pJdGxwcEwvVi9W?=
 =?utf-8?B?ZXU1bkZ5dURFRUlpOXRaazFlajdFR1JOZUgzL0Y5RFJHZk1XVUhwNk1hbFYw?=
 =?utf-8?B?YlVMbWFsemJUUVZvMWgyQWVZZkdSeC9vam00WU1Oa1RGekdoWUdFOTBQVWVj?=
 =?utf-8?B?MExCbjBpNDh6bHp1RnJKM0ZpS3JRZFViNU1nd21WSUJhcFBxWmliWno0Q0o1?=
 =?utf-8?B?OHlMaFJMRmQwV3BBNnladkhXZUFLdWQrSTRLSHVvSUpVeUcyeDBZenlRaHZq?=
 =?utf-8?B?cjdHUzVBWG1GWVo1SXI4Ui9VWjJwTGdxUW9EZEM3V0hBRS80cnl1c2FZOHR1?=
 =?utf-8?B?by9SMm04WVI0NXFEVW5yVzNsQVMzVFF3SngyWGkwMXpMcURaa3NGSU9xWERo?=
 =?utf-8?B?QnR5bmhNcDBiajFKMXJJdUgvUUkyZ0ozMmxSQTRvamtjWnNrQWovMW9WQjNI?=
 =?utf-8?B?dlRFTWxkMCtGbUlNZEYyNFd4RW5jeEdabW9JcE9EQ2dqMHMxcXI3Z0lib3dR?=
 =?utf-8?Q?i1hlSdpp/9TX9qnggxKOym9UT9yglb3l2S1xYTRWO1gu?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 50db0447-c8cf-45a2-e49c-08dc083d6266
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Dec 2023 07:11:31.6075
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L59uMHTRWb82S7iJa7Cioon59vlmaLjZl7G5HgIqjv3ybj4jYjgvgK4uk/OnMdXvlzxUpUODkKYSF53XG57wEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5744

PiBPbiAyOC8xMi8yMDIzIDEwOjMzLCBBa2hpbCBSIHdyb3RlOg0KPiA+Pj4gK3Byb3BlcnRpZXM6
DQo+ID4+PiArICBjb21wYXRpYmxlOg0KPiA+Pj4gKyAgICBjb25zdDogbnZpZGlhLHRlZ3JhMjM0
LXNlNC1oYXNoDQo+ID4+DQo+ID4+IFdoYXQgaXMgc2U0Pw0KPiA+Pg0KPiA+PiBBbnl3YXksIGZp
bGVuYW1lIGxpa2UgY29tcGF0aWJsZS4NCj4gPiBTaW1pbGFyIHRvIHRoZSBhYm92ZSwgdGhlIGhh
cmR3YXJlIG5hbWUgaXMgU0U0Lg0KPiA+DQo+ID4gbnZpZGlhLHRlZ3JhMjM0LXNlLWFlcyBhbmQg
bnZpZGlhLHRlZ3JhMjM0LXNlLWhhc2ggZG9lcyBsb29rIGdvb2QgdG8NCj4gPiBtZS4gQnV0IEkg
YW0gYSBiaXQgY29uY2VybmVkIGFib3V0IHRoZSBBQkkgYnJlYWthZ2UgaW4gY2FzZSwgd2UgbmVl
ZCBhDQo+IGRpZmZlcmVudCBjb21wYXRpYmxlIGZvciB0aGUgcmVtYWluaW5nIGluc3RhbmNlLg0K
PiANCj4gSXNuJ3QgdGhpcyBhIG5ldyBkZXZpY2U/IFdoYXQgQUJJIGJyZWFrYWdlPyBXaGF0IHdv
dWxkIGJlIGFmZmVjdGVkPw0KDQpJIG1lYW50IGEgc2NlbmFyaW8gd2hlcmUgd2UgbmVlZCB0byBz
dXBwb3J0IFNFMSBpbnN0YW5jZSBhcyB3ZWxsLg0KDQpUaGVyZSBpcyBvbmUgbW9yZSBTRSBpbnN0
YW5jZSBpbiBUZWdyYSwgd2hpY2ggaXMgdmVyeSBzaW1pbGFyIHRvIFNFMiBBRVMgRW5naW5lLg0K
QnV0IHJpZ2h0IG5vdywgaXQgZG9lcyBub3QgaGF2ZSBhIGdvb2QgdXNlIGNhc2UgaW4gTGludXgu
IE5vdyBpZiB3ZSBhZGQgDQpudmlkaWEsdGVncmEyMzQtc2UtYWVzIGFuZCBudmlkaWEsdGVncmEy
MzQtc2UtaGFzaCwgd2hlbiBTRTEgbmVlZHMgdG8gYmUNCnN1cHBvcnRlZCwgSSBndWVzcyBpdCB3
b3VsZCBiZSBjb25mdXNpbmcgdG8gZmluZCB0aGUgcmlnaHQgY29tcGF0aWJsZSBmb3IgaXQuDQoN
ClJlZ2FyZHMsDQpBa2hpbA0K

