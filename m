Return-Path: <linux-kernel+bounces-12534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 885D381F654
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 10:34:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D496283890
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 09:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB206AA3;
	Thu, 28 Dec 2023 09:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pQTOicDp"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304E363A8;
	Thu, 28 Dec 2023 09:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TLpYjUY77DOhMDP8kf+RYTpWNQBaspvakp0y5qcgGzICn/XLSpXWFBGtSJVED1sj8KYq+dezJiq8NtyGOL3hUZZrlJjN6H0OPJ291QNjMSrjdr7/hf1cqMIJ4u7sddPkjM1NCa77MaIsAkrKbniKCT+zBB7HYJOaQfXYDYWG1I/OH/PLm0ASYjcJGv9KvpRml3ScgKkOutu0kfNFR/J7fIP0W52/D5bbCXmNUg+W4IebVW9jr3OpfVoAYmUgeqlXA/rJ5K6rHAjfAr2UkSSC58+SNwsoNiIHROc9iZycyWJfgUukYNULLjnQq3tHJrt6mjthxcndRdvf4IbJqhMxCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BQEwAflc6j3QVxOzrcBHumE3B5Zn6vBhsaeVWU2HjGo=;
 b=AdKPsvA+OqXfr1vbmGXv9WohKoShjWhz9fTNH3dXZNHANKDwQYkPPYqqfNNqjMwLWp1KEFzImis4evt0lVJq9hXPfRL1uT89tMUBEbBa8t2BWjUHHTVBrlnPY0kFVYSptqKrPixjGDsJ0XLz49jsjFBjlBzsnhzc3fjQkBG41z9uBuJQCwv4UgFADiIINFc8mRlrBwBiwJfunHvBAaKKzZCSAUAbYBInATnQMQWOwTqZQxAWaB+xCmvWRbogfJzG4Y1dCXzQCHXWV6eWITPAJbLFwwUvkHscC4CP86tFTG65iFLJMmCyqW+4YC5kcDmhwCAg44cz37R8nYja9uawrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BQEwAflc6j3QVxOzrcBHumE3B5Zn6vBhsaeVWU2HjGo=;
 b=pQTOicDplP7TNnqLuigGuNEIK8hDS6gJh5CtVzqSFZ16MUYFi498oaqDdbHLfxmKOkvLljbz1FxmGCKYzq/5dKT1QBZn2wHhVRSl7drCSVSIN1HlHWcj/LkibAflg5Ai5RmDdXn9CIVIZ6emF+YyyefzFVRvr1WByyKVGLXHwsuw0JxIu8+du6Tu2yRUsaeQdLSPihnkCGrCvgUxZ1pF6KYtRYkW52RMFmTW92mqtbho1Md391n+vAhE5VK7mRj1MAvniwSuMICs35YBqOi5BmAWTm7hr/ast4qyxpSU0PUwqiE5tVCljtHo24wjPYf1iZh+ZbUh64MwyRo5wmhc3Q==
Received: from SJ1PR12MB6339.namprd12.prod.outlook.com (2603:10b6:a03:454::10)
 by MW6PR12MB9000.namprd12.prod.outlook.com (2603:10b6:303:24b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.28; Thu, 28 Dec
 2023 09:33:57 +0000
Received: from SJ1PR12MB6339.namprd12.prod.outlook.com
 ([fe80::d18b:57e8:ee01:bd48]) by SJ1PR12MB6339.namprd12.prod.outlook.com
 ([fe80::d18b:57e8:ee01:bd48%6]) with mapi id 15.20.7113.027; Thu, 28 Dec 2023
 09:33:57 +0000
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
Thread-Index: AQHaMnrYj4FV6eNlVUSo6pNY1YZjfLCyUfWAgAvyqLA=
Date: Thu, 28 Dec 2023 09:33:57 +0000
Message-ID:
 <SJ1PR12MB63397127C6E6D1289FA7E464C09EA@SJ1PR12MB6339.namprd12.prod.outlook.com>
References: <20231219125614.33062-1-akhilrajeev@nvidia.com>
 <20231219125614.33062-2-akhilrajeev@nvidia.com>
 <fe87e220-560b-4d47-bc7f-cc7104d40921@linaro.org>
In-Reply-To: <fe87e220-560b-4d47-bc7f-cc7104d40921@linaro.org>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR12MB6339:EE_|MW6PR12MB9000:EE_
x-ms-office365-filtering-correlation-id: da552a74-ae0d-4fe1-1be6-08dc07881d7f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 hWF8SCUI6nFF+O6RP0FRcN8UdK0ny5LC5lpXo3R/cps+OTMuKaLz1RBcyb5nph42NRvW6qNt+q9OwUG7V2dless2OU369ot0ixZpLoQ1Q2qW7LwoCBG9o3xbLLxBQdVp43aOUnm76CCNeXap1JBXL4XA54dKzhLBWDBj5uhPkEVgGISCLEplBZEQZR+pOVu3siXT3F7Pn5upKgjxQ+efPPL9HIrf61g2CUqU+UJ6yE6Bmo858eEV+HwQEKFbmApP3/jPvFbtXEW8pBWXi8gWyuRPhtZLsqC/sjGVmMoneUhvIn3gnWIEqvYnWJmW2fLFngYdjcf8X3TetMEML16RBPrAGE3Aq9z2zuELCVZasdcGBHs2HHGB+2MkHpeOQk9hv2VPR8nVeR8BndKN/oIvOw7SIMQnzMJQL4bchO36x3uQVpo1qEgXvR58q/WCjRCujKMoM+lOmAe7BURaJb8x00ObAUYP9JitmW5OQEcQQmdLYf7l4sYMFipDUqpjxkVECmTmrYGe7VukKPAAdp9PyW97zzGXoWTNo4FoHjOazwLZbY1LJza01003QiJHzHg2sRDkJPyeQvn7HpLgV3YwIlxp5MA7nPw2SrSk0u+9X/P3WrDgKulTyOvCssRdW/Uzwa0gfwIppZFWpWIfp9VaG6qEvee6Sb1HdpD674p6gnVGbfhUTFduOuljP9wZ/U+g
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6339.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(396003)(136003)(39860400002)(346002)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(52536014)(2906002)(122000001)(8676002)(8936002)(921011)(38100700002)(83380400001)(7416002)(26005)(5660300002)(15650500001)(38070700009)(33656002)(966005)(478600001)(71200400001)(55016003)(86362001)(6506007)(66476007)(53546011)(110136005)(64756008)(9686003)(316002)(66946007)(66556008)(66446008)(41300700001)(7696005)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bG5wQi90TlNnaDRMUGEvYmpaNVhYLzZnYWplRy9wMGxXNDcyRllDQW8zZGk3?=
 =?utf-8?B?SlFOay9OWEFJVGx1UW5zM3VHRTFLQTM0K2oreUo0RW9DRUw4Y0tleE9QOGRD?=
 =?utf-8?B?MlFDRDIwazN1aFlVWFRJUGdHK0Q0cExVUWVPK04raGFMR2VIRzFKbTFyajkx?=
 =?utf-8?B?SC8zS01rTms3eHRiSXhHaEowbXo1YVUybXVzZUY0WjFjRnlrUzVsSi96WXZQ?=
 =?utf-8?B?WkZ5WHcyY1p6Si91aGZRWnFFYVRpVlo4cStqblU2Nk5XeDZ4TFM4ZE95VGd6?=
 =?utf-8?B?UHVCQ1NiTnhGeGg4MWU3VWpCK3RrRER2ZjBBaUNKVUQzM0NjcW1TU0gwNE93?=
 =?utf-8?B?cXhrL0REOXJOc1FUMnlSS1l6YWRVaWFJNEprL2F2UllueS8xdGR1czhOZGw0?=
 =?utf-8?B?SUl4eERXR3dheUlNWmFVUlZIRmM5YW9adGJOZjN3ZStpbXQ2bU15UkVoRjhK?=
 =?utf-8?B?am1OT1pKcjY5SVYxdzY2OGN0alVFRXF2bDFKZVFFelRITWRKMEF4WE1MS2tu?=
 =?utf-8?B?dk5GSGZCQ0NGVDloc0FPWXN6OWMwdlgzQnc1RFh4RWFZREdmRGFiMnFwdWY1?=
 =?utf-8?B?OXFNWGhEYXR3M1NQVm9qMTdvNlZYdzQ4bmFkQUdObHN0SlE3b21tSU1pdGxx?=
 =?utf-8?B?ejlRRytKTFJVaDJUeVJSYzloTTVWR2MySkVVNE15bDFvYnVhbElnMjFnVU1L?=
 =?utf-8?B?SGg2WEY4K0xOalp5OWN1R0g2Q0c1NVBrempSUVoxNExTZGFBakRJallURGRZ?=
 =?utf-8?B?ZnVXQ2VqcmZwYjhZb0ZUWGlMdTNSMU9uZEgwWklqU203QlZtV1E5SjBZT1VL?=
 =?utf-8?B?K3MrK1ovMnpLT1o3SG9CYnppVGJCYUdmNkxjS2VGWk1CamFoQXI4alRBRmg2?=
 =?utf-8?B?RXhDZUh1em56eTllS3NnK2Yvakt0cnM5Qng0VUhtWXhFM3YvT2xUQk1QN0Rm?=
 =?utf-8?B?d0poc3hETm41OGpVUEtWY0dqOG01Y3dvNUFKZEtSNG9Xc3FGQVY2RkxNZHcy?=
 =?utf-8?B?TEdldFBUb0lNNlN2dGE4b2duUTMydjlDdVMzM0ZkbDRzaExWSFhNZmRoSncx?=
 =?utf-8?B?Y2JYOVlFbkcrRUlGemZNRDhEWjU5dUdET0txVXQ0TTJwSXp6Y0xMYUwwMnFY?=
 =?utf-8?B?dSt4emZnQjJqc0c3d2s0aStHZnhja1lEaFByeXpvY3VDTjFhK0NteTZSZ1hz?=
 =?utf-8?B?R3laT0N1bTAwVzFPbkd5R3VyampDYW5Db2wvK3FxRXVHUngzY0svbnlYN2Ft?=
 =?utf-8?B?VDZxSndPYUxVV3ptR1JZRUN0emZBUFRPL2xMVlRFUTlFWmFSOTJXSG5ZUDd0?=
 =?utf-8?B?dzN3N00yOE9OYXNzK2ZFUGZlUnlDMFlqNSt4ZTJScnR1OWpnVVhrb1YwZG5S?=
 =?utf-8?B?VlNNVzBrWUVQNEQvZVBJOXlJaklOTkpCeGVpWXhPRStWTFN0NFlZUzdkQjhP?=
 =?utf-8?B?b0VTczE4a3ZwdFZBQTZtTzlKakYwU0RtbGNMVVBYV1hQdjVwbWVHeXpBMXRu?=
 =?utf-8?B?T25NbVZoS0ZXcDVSK0RoV2ZJSU84YmpSVGxlcTNLUGF2aEt3aWZFQjUyZXJq?=
 =?utf-8?B?OS9LbW90TVJlUlUrdzQ5eEpkMHBuU2JycEV1cnB3cm9rNkhWaWV2UmN1TWxU?=
 =?utf-8?B?YVpkZ2lyb0x4MUxtQ0RDeHVrZEo1eUFhc0RxRkFyTFhacU1QUFpXZWV3Nkpn?=
 =?utf-8?B?N056M3ZaY3pwRnVLTEduWnQ3S0hueWdYYTlBSnFnQ0VIbnNVcGNxNlFseHQ0?=
 =?utf-8?B?T3o1eVRUekdmYkJNRzNzdjFqNDhRRFVaMGxUdlAyenhFU1RrTUlhRzdKbWFn?=
 =?utf-8?B?TkxTTmJITTRNMm9udzBPcGVpc2ZjdzZ6WWtob3dNb2pMUXptZGtRYVdKcGJC?=
 =?utf-8?B?SzYybFBuT0h0WTJ5MlllejBJWldzcm4wUGpJRWRIb29ncWNUZDFRSC9QajJQ?=
 =?utf-8?B?VGl2V25BZk40WmR0d3pqTWcvU21zOUx1Qk9HV0hYMUxsc2h2QjB3T2phOTQz?=
 =?utf-8?B?MTVIaCtWNVZhNjBwNS9QOUhvaUthSC9CbWRZQ2hvbFFTQmhsYTZvM2dwbXZE?=
 =?utf-8?B?ZnlxZGVCWEZvUkRYcnNkcG5rRWRCbWJqWWV1a1Z2WVMxSE0ya1FLeEVoVy9S?=
 =?utf-8?Q?7aLck8bnaobNf0D+ZXGxQXkuf?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: da552a74-ae0d-4fe1-1be6-08dc07881d7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Dec 2023 09:33:57.1100
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N+ej/eBIAVKbe70Wt+yOC6xghIw18J9z/fBqOcoZYNieoLaM21uhletS0K8KS3XFEi1s+9dG4eVdwr2Ws0nAbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB9000

PiBPbiAxOS8xMi8yMDIzIDEzOjU2LCBBa2hpbCBSIHdyb3RlOg0KPiA+IEFkZCBEVCBiaW5kaW5n
IGRvY3VtZW50IGZvciBUZWdyYSBTZWN1cml0eSBFbmdpbmUuDQo+ID4gVGhlIEFFUyBhbmQgSEFT
SCBhbGdvcml0aG1zIGFyZSBoYW5kbGVkIGluZGVwZW5kZW50bHkgYnkgc2VwYXJhdGUNCj4gPiBl
bmdpbmVzIHdpdGhpbiB0aGUgU2VjdXJpdHkgRW5naW5lLiBUaGVzZSBlbmdpbmVzIGFyZSByZWdp
c3RlcmVkDQo+ID4gYXMgdHdvIHNlcGFyYXRlIGNyeXB0byBlbmdpbmUgZHJpdmVycy4NCj4gPg0K
PiA+IFNpZ25lZC1vZmYtYnk6IEFraGlsIFIgPGFraGlscmFqZWV2QG52aWRpYS5jb20+DQo+ID4g
LS0tDQo+ID4gIC4uLi9jcnlwdG8vbnZpZGlhLHRlZ3JhMjM0LXNlLWFlcy55YW1sICAgICAgICB8
IDUzICsrKysrKysrKysrKysrKysrKysNCj4gPiAgLi4uL2NyeXB0by9udmlkaWEsdGVncmEyMzQt
c2UtaGFzaC55YW1sICAgICAgIHwgNTMgKysrKysrKysrKysrKysrKysrKw0KPiA+ICAyIGZpbGVz
IGNoYW5nZWQsIDEwNiBpbnNlcnRpb25zKCspDQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NA0KPiBE
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvY3J5cHRvL252aWRpYSx0ZWdyYTIzNC1z
ZS1hZXMueWFtbA0KPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQNCj4gRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL2NyeXB0by9udmlkaWEsdGVncmEyMzQtc2UtaGFzaC55YW1sDQo+ID4N
Cj4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2NyeXB0
by9udmlkaWEsdGVncmEyMzQtc2UtDQo+IGFlcy55YW1sIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL2NyeXB0by9udmlkaWEsdGVncmEyMzQtc2UtDQo+IGFlcy55YW1sDQo+ID4g
bmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gPiBpbmRleCAwMDAwMDAwMDAwMDAuLjM1YzJlNzAxYmQ0
Mg0KPiA+IC0tLSAvZGV2L251bGwNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvY3J5cHRvL252aWRpYSx0ZWdyYTIzNC1zZS1hZXMueWFtbA0KPiA+IEBAIC0wLDAg
KzEsNTMgQEANCj4gPiArIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogKEdQTC0yLjAtb25seSBP
UiBCU0QtMi1DbGF1c2UpDQo+ID4gKyVZQU1MIDEuMg0KPiA+ICstLS0NCj4gPiArJGlkOiBodHRw
Oi8vZGV2aWNldHJlZS5vcmcvc2NoZW1hcy9jcnlwdG8vbnZpZGlhLHRlZ3JhMjM0LXNlLWFlcy55
YW1sIw0KPiA+ICskc2NoZW1hOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvbWV0YS1zY2hlbWFzL2Nv
cmUueWFtbCMNCj4gPiArDQo+ID4gK3RpdGxlOiBOVklESUEgVGVncmEgU2VjdXJpdHkgRW5naW5l
IGZvciBBRVMgYWxnb3JpdGhtcw0KPiA+ICsNCj4gPiArZGVzY3JpcHRpb246IHwNCj4gDQo+IERv
IG5vdCBuZWVkICd8JyB1bmxlc3MgeW91IG5lZWQgdG8gcHJlc2VydmUgZm9ybWF0dGluZy4NCk9r
YXkuDQoNCj4gDQo+ID4gKyAgVGhlIFRlZ3JhIFNlY3VyaXR5IEVuZ2luZSBhY2NlbGVyYXRlcyB0
aGUgZm9sbG93aW5nIEFFUw0KPiBlbmNyeXB0aW9uL2RlY3J5cHRpb24NCj4gPiArICBhbGdvcml0
aG1zLg0KPiANCj4gcy8uLzovIGFuZCBqb2luIGxpbmVzPyBXYXNuJ3QgdGhhdCB5b3VyIGludGVu
dGlvbiBoZXJlPw0KWWVzLiBDb3JyZWN0LiANCg0KPiANCj4gPiArICBBRVMtRUNCLCBBRVMtQ0JD
LCBBRVMtT0ZCLCBBRVMtWFRTLCBBRVMtQ1RSLCBBRVMtR0NNLCBBRVMtQ0NNLCBBRVMtDQo+IENN
QUMNCj4gPiArDQo+ID4gK21haW50YWluZXJzOg0KPiA+ICsgIC0gQWtoaWwgUiA8YWtoaWxyYWpl
ZXZAbnZpZGlhLmNvbT4NCj4gPiArDQo+ID4gK3Byb3BlcnRpZXM6DQo+ID4gKyAgY29tcGF0aWJs
ZToNCj4gPiArICAgIGNvbnN0OiBudmlkaWEsdGVncmEyMzQtc2UyLWFlcw0KPiANCj4gV2h5ICJz
ZTIiPw0KPiANCj4gQW55d2F5LCBmaWxlbmFtZSBsaWtlIGNvbXBhdGlibGUuDQpUaGUgaW5zdGFu
Y2UgaXMgbmFtZWQgU0UyIGluIHRoZSBoYXJkd2FyZS4gVGhvdWdodCB0byBhbGlnbiB0aGUgY29t
cGF0aWJsZSBhcyB3ZWxsLg0KDQpUaGVyZSBpcyBvbmUgbW9yZSBpbnN0YW5jZSB3aXRoIGEgc2xp
Z2h0bHkgZGlmZmVyZW50IGNhcGFiaWxpdHksIHdoaWNoIHdlIGFyZW4ndCB1c2luZyBjdXJyZW50
bHkuDQpJbiBjYXNlIGl0IG5lZWRzIHRvIGJlIHN1cHBvcnRlZCwgd2Ugd291bGQgbmVlZCBhIGRp
ZmZlcmVudCBjb21wYXRpYmxlLCBidXQgdGhlIGRyaXZlciB3aWxsIG5lZWQNCm9ubHkgbWlub3Ig
Y2hhbmdlcy4gSSBzdXBwb3NlIHRoZSBjdXJyZW50IGNvbXBhdGlibGUgY2FuIGhlbHAgdG8gbWFp
bnRhaW4gdGhlIEFCSSB3aXRoIERUIHRoZW4uDQoNCj4gDQo+IA0KPiA+ICsNCj4gPiArICByZWc6
DQo+ID4gKyAgICBtYXhJdGVtczogMQ0KPiA+ICsNCj4gPiArICBjbG9ja3M6DQo+ID4gKyAgICBt
YXhJdGVtczogMQ0KPiA+ICsNCj4gPiArICBpb21tdXM6DQo+ID4gKyAgICBtYXhJdGVtczogMQ0K
PiA+ICsNCj4gPiArICBkbWEtY29oZXJlbnQ6IHRydWUNCj4gPiArDQo+ID4gK3JlcXVpcmVkOg0K
PiA+ICsgIC0gY29tcGF0aWJsZQ0KPiA+ICsgIC0gcmVnDQo+ID4gKyAgLSBjbG9ja3MNCj4gPiAr
ICAtIGlvbW11cw0KPiA+ICsNCj4gPiArYWRkaXRpb25hbFByb3BlcnRpZXM6IGZhbHNlDQo+ID4g
Kw0KPiA+ICtleGFtcGxlczoNCj4gPiArICAtIHwNCj4gPiArICAgICNpbmNsdWRlIDxkdC1iaW5k
aW5ncy9pbnRlcnJ1cHQtY29udHJvbGxlci9hcm0tZ2ljLmg+DQo+ID4gKyAgICAjaW5jbHVkZSA8
ZHQtYmluZGluZ3MvbWVtb3J5L3RlZ3JhMjM0LW1jLmg+DQo+ID4gKyAgICAjaW5jbHVkZSA8ZHQt
YmluZGluZ3MvY2xvY2svdGVncmEyMzQtY2xvY2suaD4NCj4gPiArDQo+ID4gKyAgICBjcnlwdG9A
MTU4MjAwMDAgew0KPiA+ICsgICAgICAgIGNvbXBhdGlibGUgPSAibnZpZGlhLHRlZ3JhMjM0LXNl
Mi1hZXMiOw0KPiA+ICsgICAgICAgIHJlZyA9IDwweDE1ODIwMDAwIDB4MTAwMDA+Ow0KPiA+ICsg
ICAgICAgIGNsb2NrcyA9IDwmYnBtcCBURUdSQTIzNF9DTEtfU0U+Ow0KPiA+ICsgICAgICAgIGlv
bW11cyA9IDwmc21tdSBURUdSQTIzNF9TSURfU0VTX1NFMT47DQo+ID4gKyAgICAgICAgZG1hLWNv
aGVyZW50Ow0KPiA+ICsgICAgfTsNCj4gPiArLi4uDQo+ID4gZGlmZiAtLWdpdCBhL0RvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9jcnlwdG8vbnZpZGlhLHRlZ3JhMjM0LXNlLQ0KPiBo
YXNoLnlhbWwgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvY3J5cHRvL252aWRp
YSx0ZWdyYTIzNC1zZS0NCj4gaGFzaC55YW1sDQo+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4g
PiBpbmRleCAwMDAwMDAwMDAwMDAuLmUzODQ4ZTlhNTNiNQ0KPiA+IC0tLSAvZGV2L251bGwNCj4g
PiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvY3J5cHRvL252aWRpYSx0
ZWdyYTIzNC1zZS0NCj4gaGFzaC55YW1sDQo+ID4gQEAgLTAsMCArMSw1MyBAQA0KPiA+ICsjIFNQ
RFgtTGljZW5zZS1JZGVudGlmaWVyOiAoR1BMLTIuMC1vbmx5IE9SIEJTRC0yLUNsYXVzZSkNCj4g
PiArJVlBTUwgMS4yDQo+ID4gKy0tLQ0KPiA+ICskaWQ6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9z
Y2hlbWFzL2NyeXB0by9udmlkaWEsdGVncmEyMzQtc2UtaGFzaC55YW1sIw0KPiA+ICskc2NoZW1h
OiBodHRwOi8vZGV2aWNldHJlZS5vcmcvbWV0YS1zY2hlbWFzL2NvcmUueWFtbCMNCj4gPiArDQo+
ID4gK3RpdGxlOiBOVklESUEgVGVncmEgU2VjdXJpdHkgRW5naW5lIGZvciBIQVNIIGFsZ29yaXRo
bXMNCj4gPiArDQo+ID4gK2Rlc2NyaXB0aW9uOiB8DQo+ID4gKyAgVGhlIFRlZ3JhIFNlY3VyaXR5
IEhBU0ggRW5naW5lIGFjY2VsZXJhdGVzIHRoZSBmb2xsb3dpbmcgSEFTSCBmdW5jdGlvbnMuDQo+
IA0KPiBTaW1pbGFyIGNvbW1lbnQNCj4gDQo+ID4gKyAgU0hBMSwgU0hBMjI0LCBTSEEyNTYsIFNI
QTM4NCwgU0hBNTEyLCBTSEEzLTIyNCwgU0hBMy0yNTYsIFNIQTMtMzg0LA0KPiBTSEEzLTUxMg0K
PiA+ICsgIEhNQUMoU0hBMjI0KSwgSE1BQyhTSEEyNTYpLCBITUFDKFNIQTM4NCksIEhNQUMoU0hB
NTEyKQ0KPiA+ICsNCj4gDQo+ID4gK21haW50YWluZXJzOg0KPiA+ICsgIC0gQWtoaWwgUiA8YWto
aWxyYWplZXZAbnZpZGlhLmNvbT4NCj4gPiArDQo+ID4gK3Byb3BlcnRpZXM6DQo+ID4gKyAgY29t
cGF0aWJsZToNCj4gPiArICAgIGNvbnN0OiBudmlkaWEsdGVncmEyMzQtc2U0LWhhc2gNCj4gDQo+
IFdoYXQgaXMgc2U0Pw0KPiANCj4gQW55d2F5LCBmaWxlbmFtZSBsaWtlIGNvbXBhdGlibGUuDQpT
aW1pbGFyIHRvIHRoZSBhYm92ZSwgdGhlIGhhcmR3YXJlIG5hbWUgaXMgU0U0Lg0KDQpudmlkaWEs
dGVncmEyMzQtc2UtYWVzIGFuZCBudmlkaWEsdGVncmEyMzQtc2UtaGFzaCBkb2VzIGxvb2sgZ29v
ZCB0byBtZS4gQnV0IEkgYW0gYSBiaXQgY29uY2VybmVkDQphYm91dCB0aGUgQUJJIGJyZWFrYWdl
IGluIGNhc2UsIHdlIG5lZWQgYSBkaWZmZXJlbnQgY29tcGF0aWJsZSBmb3IgdGhlIHJlbWFpbmlu
ZyBpbnN0YW5jZS4NCg0KVGhhbmtzIGFuZCBSZWdhcmRzLA0KQWtoaWwNCg==

