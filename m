Return-Path: <linux-kernel+bounces-12004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB3B881EEBE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 13:05:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF0421C21941
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 12:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24860446D0;
	Wed, 27 Dec 2023 12:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="Cjffg9X+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2044.outbound.protection.outlook.com [40.107.105.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C8744369;
	Wed, 27 Dec 2023 12:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MuNJHnSRIbLj9DKTLV71FS/ATfpQa9s21UVrnJE9lSP/8/I8eP+LNp+LS6DNclb9odmFrhzu9Xe51rWbMmpyWQpR27XKocvql2CSlwBzzXh/HB/BY2D7rpV0rvMdd+vXh6VjBQ87yIF4ZiKt6pgP7iO0mAw8jl2Ma/mL1nvBir98/D/vtsJkm5yxzI66e0k8jV1w5kg/LpnNVh1TV5kYVxdaqfVN8fx++ebxMjjLYkZQhMT9C5Kbp/9QghxcMldL4raHWROs9CUtNOlU5s/HD8U+OWYTiSF/wBgfeUcYK9J7G2z3movkKFtF+4hKQvGgNBZq5Wgw2tVozh9kehk1Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0j9xPTS8H+B5J6hDvDrtOHxQim0V7wmutLcOcXAh5gM=;
 b=ivRwTrABuETk6dEg5rSjjIvnP7azMcf9zA+kq/ZaXx219Xi+1iK8NrTmF6OFzX+LtNYrNUHNT2f7d9O9e/jTOy2tCmOV+kNeJP/gnlOYe183dWXD6kEwxw55ix3YU9vNyxmD2eRc2mB4gCGL/MBJNXfv+7tKeE0Aro9g1jWgpNXdWWm99TEhJ13EAy/vHzVIHTzhqoZ8feNOySbWL+ZNVdKkjZ06AoaW338EkM4TRQJMPO1uBCGO+8PahF4oeDOK0sLxNG40mdhT7RQQBQR2U6iRK1eznY+YZDp0u1VZTwakn3WKsH1noaS4BhdM5KPoWvlBrSxtuaPeAmft0OJr5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0j9xPTS8H+B5J6hDvDrtOHxQim0V7wmutLcOcXAh5gM=;
 b=Cjffg9X+Js/7lD/7QzClqBRueqd6qSZkcrsnGIkp+sU4Qs0nlkiYePPESTDN8nvQX6BbDfmLDySTEdia7yyoJ1Zkpo9YNDGbk5dhp8UswQh9xwucHChdjVJpHS+zN79lTs98reqWEoScAsZ8oGKG/n1XitV6kp+3+auRV5lRFr4=
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com (2603:10a6:20b:42e::18)
 by PAWPR04MB9912.eurprd04.prod.outlook.com (2603:10a6:102:387::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27; Wed, 27 Dec
 2023 12:05:18 +0000
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::4db1:aae8:c643:2e73]) by AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::4db1:aae8:c643:2e73%6]) with mapi id 15.20.7135.019; Wed, 27 Dec 2023
 12:05:18 +0000
From: Josua Mayer <josua@solid-run.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Andrew Lunn
	<andrew@lunn.ch>, Gregory Clement <gregory.clement@bootlin.com>, Sebastian
 Hesselbarth <sebastian.hesselbarth@gmail.com>, Rob Herring
	<robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/8] dt-bindings: marvell: a38x: convert the soc
 compatibles description to yaml
Thread-Topic: [PATCH v3 1/8] dt-bindings: marvell: a38x: convert the soc
 compatibles description to yaml
Thread-Index: AQHaOCcAXf1XYp2s80mFsgOpfutnRrC9BRuAgAAEgQA=
Date: Wed, 27 Dec 2023 12:05:18 +0000
Message-ID: <202e7469-60a4-4d8f-87e6-8932c593a877@solid-run.com>
References:
 <20231226-support-clearfog-gtr-l8-sfp-v3-0-fd1ac2d6bf2e@solid-run.com>
 <20231226-support-clearfog-gtr-l8-sfp-v3-1-fd1ac2d6bf2e@solid-run.com>
 <d105c2c5-4d36-4489-b7ac-ae8da74fa9d3@linaro.org>
In-Reply-To: <d105c2c5-4d36-4489-b7ac-ae8da74fa9d3@linaro.org>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8963:EE_|PAWPR04MB9912:EE_
x-ms-office365-filtering-correlation-id: ec0262c7-46d3-40e8-303f-08dc06d417dc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 tZSQ3s7uINQMSMOaCUDqUP1mzHieQwaGfXoalUU8YIdTt9XGYsTJK5TfsYwbztty0u6IUMwm9c/GDi6HTZgfxEUgqWgUe40L8Didhk+7NxT9pP33x9Pk188F2LGXMdIWwMmBTL7OAsQHzoZVnB8FGbWykNcKzBm2OMyOYguhPEyZpwzkOQkF0+s/r9VJyEAZcLD+MG9LIZK3XteEztP+XvYpDdO0/Gm2BPfVW4U2dzw2aWRQrAFXExPowEcUll3zDlykVHL6e1gRAIgFK+xkjUsEms9bQMxqlghIfp+ITPgGyWxW8stMysjtDWSNEVIb0cXknUZRqPT91HGEScl9Na428uZDcYZS6kFFI38LDXX1e9z4z1+ywIxA2lBaSW7+xAzXpM5x0Nh32ayouG8DaUp9YpqsxAQVv3HiTD01g8rBWGDPjyaaF86vSmxSb10uq9AwlsTKGcWnuSmP3BdwRLTNnw9jyclSRd0teFk0hlasDk/UXX7gcMBBo1n7vpnLNEY9u4ARnLOFyrRdbqLNHHCp/N18xM5ZMkppp/8aCOm8VH5Q8FVWDwwafbrtoWkdHfCBAM8KxNcRC/adDOb/mcde6PwtWL2QTCeDSyQr70dZ2qB4nJJRHVORs9MyHPz5ndfVcH0LY0GAwgb0AtEkXg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8963.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39840400004)(136003)(346002)(396003)(366004)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(38070700009)(110136005)(91956017)(76116006)(66556008)(316002)(66476007)(66446008)(64756008)(54906003)(66946007)(8676002)(8936002)(4326008)(6506007)(71200400001)(6512007)(53546011)(478600001)(2616005)(966005)(26005)(6486002)(38100700002)(41300700001)(122000001)(5660300002)(7416002)(2906002)(31696002)(86362001)(36756003)(31686004)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NWZkUXZJQjJiVGlHMHExZ1BpYkRhbWxZY2p4QmtzaXQ5Sytoei85MEVrV2Vi?=
 =?utf-8?B?WElrc2lvWGJJY1hwa2ZHemVLbEh6RTVrODBiU3BFeFFidWNyT0lpTU9EQWYz?=
 =?utf-8?B?dEtqckYyU3BpVnJ5dG1RdUgrWWUvOXByM3I1RkNoZEt5SFhwLzB1M3Eyems0?=
 =?utf-8?B?WUxMSkFmZzJCSnJLWGFxTktiRHdXWTJLaGFjdjJOMDlTRDlzelVwWHZFSnNN?=
 =?utf-8?B?dWNxcDFoQUVGam1JM0F1eDk1ekRBR00vMS9LbTN2MmpvQWJBKzIwYVZzTGk5?=
 =?utf-8?B?TTVhYlpnZWxMc1BBbk0yTFhiN1Vield3RmxObGFjSFpxc2E0elVBOUVHbUxS?=
 =?utf-8?B?UUxhTUxUMnBvTTF3dGU5MGI0UWhJaEJ2YnhTcTlLb1l4R0gzdkhoUmo2aG96?=
 =?utf-8?B?REg2SnZXZWVLYWRPTVBkZzVlQUZCcjFMdnZkUEt1ZlA0Mk5pZVBITW54TnI5?=
 =?utf-8?B?MU80OWJOQzhtMzN4aW52blBBWGwwekFPdklBU0daQ0pKUncvVkdEVXZZV2Qz?=
 =?utf-8?B?TlNJT0xNRXhWQ1hBM1dIbFM4dkg4cERuR1pVUDdkelJ6U0hGY3Ayb09JQVJw?=
 =?utf-8?B?dk1QR081bTBwM3YwT1BscjhlQ1Z1azBWeW44MGV0cmRPbnZZRmx6SDlEQXNj?=
 =?utf-8?B?bE1OUzY1L0M5SktpTVB1OW1Pdk5EYnZSVkZpMGNmeTFCcUF2N2hIN0pMR0sw?=
 =?utf-8?B?cEFuREw4ZitlSW1MeFdOMVRGbzFFZ2dMQThyWGFxVFJOSytuVHMwK3ZObkJP?=
 =?utf-8?B?SXhPa21lRTRYVnprcnoyUXA5Sk9RZmhvU2ZlNXZqY2Y4SVBtYldCVHV0ek1C?=
 =?utf-8?B?TUs3N1FrM3pPbzVsWUlncGd2dG1PU0lBc3l1aEdJMGVsbzFoVnlVTGw0Zkdr?=
 =?utf-8?B?RXkxSHArUG8xdzBjYXp5bzB4OSttQmJSMzQyckhiNmRoL0RzcWFHSTR1cDZG?=
 =?utf-8?B?SUNhOHRCeVZiM3N2YlRzSUwxSm0wTHVFRWFLb2ZDd0VmTzlFUjQ2U3NzcnFF?=
 =?utf-8?B?TE0xcnZTNWtCNFE4REt6cEs2R2xOSGhaTFJ4bEdnQ0lKWnNFSkIyeFZ2UXZ4?=
 =?utf-8?B?bklvQ2p4aFNtWDRVVXkyZS9YSUVrV3ZqaGIwNFNBWXpUSmJDZmFRNGR2Y01V?=
 =?utf-8?B?dnpLQnNUZ2NudjAvekJKcEx3MXc1YmFscDhncHBXVlZFQTVWTFo0bm9RZTll?=
 =?utf-8?B?cTN3bU9XZTVnVUlZOVpsZEJQS3Y2VFc4VzJWa1pMd3FFUnE2UWdMdkorWlhx?=
 =?utf-8?B?TG83dS9aOHpPMnVibUVKV3BZWDJvNFVNN1JCSHBpanNhdGFjV2hJUFFmQ3VE?=
 =?utf-8?B?VE10WXlSLzZUeGVXM2k3bTRtMUFjRG5vT2Y4Q3MzNUFoRUpGdG11Q1I4d0to?=
 =?utf-8?B?a01FOTlKZWJiNk42NmVnVnp5MTZ2ZG1NRGl2OTNYNUFOV291Q1ZUUjJjZU0z?=
 =?utf-8?B?UlN0bWFOQjAvUzBZb05Ub3RMQXh3bXNnUmtQVG0wVlN0VTQvMlQxVm1tSkxX?=
 =?utf-8?B?K1FnV3ltOUxuY1FJVCt3dUxaeEJZNXl0NDdlWFdBSlpRSUl0U25HMGxjMm8v?=
 =?utf-8?B?TjcyQnBCd2UyYmhPMENrZ3UwWTliVy9ibWRWbXdQVDVtZFBNZ1V6ZUdOWTdZ?=
 =?utf-8?B?c2N3ZENnNEpXRk5LUyt4VUV6TEZIbFphUnhrRE9hcndYZUVleURmQXJ3ZGZM?=
 =?utf-8?B?dm5HWmNmY2svMzNkMStRZlljdElkSSt6dzR2L01Da2lYVlFpbktSWWp2b0Vp?=
 =?utf-8?B?T2U1WmJIbFozR01Wc0FKR3NiRnBKZFhMYkhQYnBMYXR2ODVRMDhWcFZ2d2tx?=
 =?utf-8?B?eGlCUThVM2NMNXdGb0QzUHVaM1hRcHY2R0tSRzBLdlJvamdnVm9VODdXVG1L?=
 =?utf-8?B?b1k5Y1Y3N3FBZ3Q3cHFIOFVHaC9LRS9DbndJdjJnd21HM3diZmd4U1FFM2Ny?=
 =?utf-8?B?cGtFcTNubFpNeExuYys4UExlbmE5RURaeEFRS095RGh0bW9LS3VXQzRNVFNN?=
 =?utf-8?B?QW0vYVFmSHUra0M4U0Q0UEZMbnRDOVBDQ0dOWHpYMXBvcmRqVFF2a3F4RWpJ?=
 =?utf-8?B?T3lvQnFObmJyWWRRN1Z1SVExRVNMdWNOWXJrQ0EzTWJoUjV5Z3NOU1k5MXFR?=
 =?utf-8?Q?rr0y4dUxQ5sG77nVDN82pDsyw?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <17FE8967CBDC4D48B38BAA88BF0C5C3D@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8963.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec0262c7-46d3-40e8-303f-08dc06d417dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Dec 2023 12:05:18.2515
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BR/s74YtUnnRhz7aaDi8ChCQd1xkYZq1Zyk8qNltVDH6q2HzAKKtKJ/D8iSQFA++ORaiRdVkZuTEeOtFWiuqxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9912

QW0gMjcuMTIuMjMgdW0gMTI6NDkgc2NocmllYiBLcnp5c3p0b2YgS296bG93c2tpOg0KPiBPbiAy
Ni8xMi8yMDIzIDE5OjExLCBKb3N1YSBNYXllciB3cm90ZToNCj4+IENvbnZlcnQgdGhlIGV4aXN0
aW5nIHR4dCBiaW5kaW5nIGZvciBhcm1hZGEtMzh4IHNvY3MgdG8gRFQgc2NoZW1hDQo+PiBmb3Jt
YXQuDQo+IC4uLg0KPg0KPj4gKy0tLQ0KPj4gKyRpZDogaHR0cDovL2RldmljZXRyZWUub3JnL3Nj
aGVtYXMvYXJtL21hcnZlbGwvYXJtYWRhLTM4eC55YW1sIw0KPj4gKyRzY2hlbWE6IGh0dHA6Ly9k
ZXZpY2V0cmVlLm9yZy9tZXRhLXNjaGVtYXMvY29yZS55YW1sIw0KPj4gKw0KPj4gK3RpdGxlOiBN
YXJ2ZWxsIEFybWFkYSAzOHggUGxhdGZvcm1zDQo+PiArDQo+PiArbWFpbnRhaW5lcnM6DQo+PiAr
ICAtIEdyZWdvcnkgQ0xFTUVOVCA8Z3JlZ29yeS5jbGVtZW50QGJvb3RsaW4uY29tPg0KPj4gKw0K
Pj4gK3Byb3BlcnRpZXM6DQo+PiArICAkbm9kZW5hbWU6DQo+PiArICAgIGNvbnN0OiAnLycNCj4+
ICsgIGNvbXBhdGlibGU6DQo+PiArICAgIG9uZU9mOg0KPj4gKw0KPj4gKyAgICAgIC0gZGVzY3Jp
cHRpb246IEFybWFkYSAzODAgU29DDQo+PiArICAgICAgICBpdGVtczoNCj4+ICsgICAgICAgICAg
LSBjb25zdDogbWFydmVsbCxhcm1hZGEzODANCj4+ICsNCj4gVGhhbmtzIGZvciB0aGUgY29udmVy
c2lvbi4gSSB0aGluayB0aGlzIGlzIHN0aWxsIG5vdCB3aGF0IHdlIHdhbnQuIFRoZQ0KPiBtYWlu
IHByb2JsZW0gaXMgb2YgY291cnNlIGluIHRoZSBvcmlnaW5hbCBiaW5kaW5nLCBub3QgeW91ciBj
b252ZXJzaW9uLg0KPiBDb21wYXRpYmxlIGFybWFkYTM4MCBhYm92ZSBhbG9uZSBpcyBub3QgY29y
cmVjdC4gVGhpcyBpcyBTb0MgYW5kIFNvQw0KPiBjb21wYXRpYmxlIGNhbm5vdCBiZSB1c2VkIGFs
b25lLCBiZWNhdXNlIGl0IGlzIG5vdCBzcGVjaWZpYyBlbm91Z2ggdG8NCj4gZGlmZmVyZW50aWF0
ZSBib2FyZHMuIFNhbWUgYXBwbGllcyBmb3IgZnVydGhlciBsaXN0cywgd2hpY2ggSSByZW1vdmVk
DQo+IGZyb20gdGhlIHF1b3RlLCBmb3IgdGhlIHNhbWUgcmVhc29ucy4NCj4NCj4gV2hhdCB3ZSBj
b3VsZCBkbyBoZXJlIGlzIHRvIGZpeCB0aGlzIGluc3RlYWQgb2YgcHVyZSBjb252ZXJzaW9uOg0K
PiAxLiBBZGQgdGhpcyBiaW5kaW5nIGZpbGUgd2l0aCBuZXcgY29tcGF0aWJsZXMgZm9yIGV4aXN0
aW5nIGJvYXJkcyBhbmQNCj4gZHJvcCB0aGUgVFhUIGZpbGUsIHdpdGggZXhwbGFuYXRpb24gdGhh
dCB5b3UgYWN0dWFsbHkgZG9jdW1lbnQgcHJvcGVybHkNCj4gYWxsIGV4aXN0aW5nIGJvYXJkIGNv
bXBhdGlibGVzLg0KU28gLSB3ZSBjb3VsZCBhZGQgYSBib2lsZXJwbGF0ZSB5YW1sIHdpdGggemVy
byBib2FyZHMgaW4gY29udmVyc2lvbiBjb21taXQsDQphbmQgdGhlbiBhZGQgbmV3IG9yIGV4aXN0
aW5nIGJvYXJkcyB0aHJvdWdoIHNlcGFyYXRlIGNvbW1pdHM/DQoNCkkgZmVlbCB0aGF0IGNvbGxl
Y3RpbmcgLyBmaXhpbmcgdGhlIGNvbXBhdGlibGVzIGZvciBhbGwgYTM4eCBiYXNlZCANCmJvYXJk
cyBtaWdodCBiZSBhIGxvdCBvZiBlZmZvcnQuDQpXb3VsZCBpdCBiZSBhY2NlcHRhYmxlIHRvIHN0
YXJ0IHdpdGggdGhlIGZldyB0aGF0IEkga25vdyAvIHVzZSBteXNlbGY/DQpJbiBhZGRpdGlvbiB0
byB0aG9zZSBhbHJlYWR5IHN1Ym1pdHRlZCBJIGNvdWxkIGluY2x1ZGUgDQphcm1hZGEtMzg4LWhl
bGlvczQuZHRzLg0KDQo+IDIuIEFkZCBjb21wYXRpYmxlcyB0byBleGlzdGluZyBEVFMuDQpGb3Ig
Ym9hcmRzIEkgZG8gbm90IGtub3cgLyB1c2luZyBjb2RlbmFtZXMgLSBpcyB0aGVyZSBhIHRlbXBs
YXRlIC8gDQpnZW5lcmljIGRlc2NyaXB0aW9uIHN0cmluZz8NCj4gMy4gQWRkIHlvdXIgbmV3IGJv
YXJkIGNvbXBhdGlibGVzLg0KPg0KPiBBdCBsZWFzdCB0aGlzIGlzIHdoYXQgSSB3b3VsZCBkbyBm
b3IgdHlwaWNhbCBjYXNlcywgYnV0IGFzIEkgc2FpZA0KPiBiZWZvcmUsIE1hcnZlbGwgaGVyZSBp
cyBpbiBzb21lIHN1cnByaXNpbmcgbGltYm8gc3RhdGUuDQoNClRoYW5rIHlvdSBmb3IgdGhlIGNv
bnN0cnVjdGl2ZSBub3RlcyENCg0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KPg0KDQo=

