Return-Path: <linux-kernel+bounces-16641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 295E08241C1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 13:28:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83475B23AC0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 12:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C67219ED;
	Thu,  4 Jan 2024 12:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="IggMOMiB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2077.outbound.protection.outlook.com [40.107.14.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF8321373;
	Thu,  4 Jan 2024 12:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K8GHrHClKy8AInglKX8w5khuNFPGe1yk4QSec1Qyc6wVOJd9qJDs11emplrCuFw2hCnq1fvyZTuaL9UsFzTBFKQYX7XDg1df0NUpMx/L2rF53chewwQSS7qo2hWb5GIki5wwtBHfBkVgnTUaCQjiMoXbTvKC4b/kwiHuDdziv+iNp0DCeTI5g4MoFhNWjUymbIO6Pt8H5Y5Ff3jydzLggDZ5NoqZRTG+/+hR8eu66AJKjfJ9+pp51yfY6wt9+fhhXCtmxYrt0K0qmaAubgu0cZdj/OGy3p/fkG+q5dGymIc21YtV6X9CMK3H/beLr9xYxX6L6EAQ2k8kuHbBG/6xWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dswUDti2J2zGaV8ekq/K2F6vfHKQzKM/opaqG8LkzXQ=;
 b=gf2FEbZxPppaKzjH9fTOH1I7qv1RQjtWbEk31FtCVM4GIls1CvHupqH+k4089IimemovynqNiRvxWH1BDdA8ae+uoYbVVO4tx5GqH3aJ5pAStoHu93prbdMTX+ZXZKiO/RTQ2VQya7kKM8bSyYayfcsS8f1CGI8tdUoUwHohf5Bi9n2D3kHtrAPvSWiNU3YBAcuvN+tC6rrx7oboW1IZRxspfge2TcDaVH3jjhebIlPMfJ6F1U0vGD8q1LPUKT2bpoK0nVEDB5zlu9ZCUU8BxABAMoCkUhnsb7flRDUJiPSmZ4pWnTc+zAK/0hr0CTjVIGcXglSMDl3dk1BvaGQNAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dswUDti2J2zGaV8ekq/K2F6vfHKQzKM/opaqG8LkzXQ=;
 b=IggMOMiBu9/IUFF08IxCk8SXL0b8wh51loh/ny07ngSFHHBU5mS0+tZXCPRjOKZdwYJYCWv9lVaKZ2cG1kdmc02NT6hVhV0KH4TdnNlwYN4jOo6ZqApDdLtmGF7qVW4JhK0nj994S+zcHX009Kb5FTzKUNAACtpAK0mjiQgNYvg=
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com (2603:10a6:20b:42e::18)
 by PA4PR04MB7967.eurprd04.prod.outlook.com (2603:10a6:102:b8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.14; Thu, 4 Jan
 2024 12:28:15 +0000
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::daf2:8c54:d469:793d]) by AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::daf2:8c54:d469:793d%6]) with mapi id 15.20.7159.013; Thu, 4 Jan 2024
 12:28:15 +0000
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
Subject: Re: [PATCH v4 04/11] dt-bindings: marvell: a38x: add kobol helios-4
 board
Thread-Topic: [PATCH v4 04/11] dt-bindings: marvell: a38x: add kobol helios-4
 board
Thread-Index: AQHaOzcd7FwvfjKH2k64f3uwzWp19LDJXa0AgAA+3gA=
Date: Thu, 4 Jan 2024 12:28:14 +0000
Message-ID: <765ad049-685d-4ced-b984-06f177a56bac@solid-run.com>
References:
 <20231230-support-clearfog-gtr-l8-sfp-v4-0-1d7f0e2c7128@solid-run.com>
 <20231230-support-clearfog-gtr-l8-sfp-v4-4-1d7f0e2c7128@solid-run.com>
 <f463c8b6-5dcf-45f8-8650-e3b3bf542248@linaro.org>
In-Reply-To: <f463c8b6-5dcf-45f8-8650-e3b3bf542248@linaro.org>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8963:EE_|PA4PR04MB7967:EE_
x-ms-office365-filtering-correlation-id: e58e18c8-a54d-4284-9165-08dc0d209fcf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 P+3yqk3WRVWlxaLG36cVBr4eysK5p45A1fcCoQOdeTCa+P4KIPxyLSeebeLyX3i7cA7+BKOoSgmlGg06JMS8R5dYy4LNTLAK1D8c2GM/uRjWMDN99B/jHZ/tujDSD3GiWR1B1NCU/fBFXQ8tf1/RoSAMJVIhiemX7OjixRUUGReV7muvaJsdWztnmLnrUs3mdPonzAMTN+ONBVthBRnuNPsIufvoFaXhWR6a/szWes7Uw4nqWKuKn/6RnlwS4S4+fkJ6Qy1uk5aRmqCxDroFJViWtdprQ06ZtXLCsOjJGhvQF6YKgZtRRVlXhiJO9dCJxl5sY2JtksNaj7pfvRGe/TJ7T9uZWDtZiGY+48zXvY7t2ZhHCSFp6WvDetO0zQIxR4cphu3i9hnmC5rKUEIJ3QkZJ+J50zMpYE0quGxO1CL+KKdHM9ZK17NSf0f21QZPgI6SGaLJ8eso75VaqubMbdaX5VOesXWq20X1jtK/6tnPARlJ9xnz/v6BGr8D/J6tXTyIcqCXF4/UGu/XaWGVpb7F1nuSCpE0izYWdAZYV4TGUAULGbG40KLffYN40UJX7QmbHRmBGRz6LGX24fq0uc1juUAygWnrUNTIaDG2NFBtySkyk2Oztz7hjs4dXnOWcs8hb1STwg8RI7SUYyQP3w==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8963.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39840400004)(366004)(376002)(346002)(396003)(136003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(478600001)(6486002)(8676002)(6512007)(53546011)(71200400001)(6506007)(66476007)(4326008)(91956017)(8936002)(316002)(66556008)(76116006)(54906003)(66946007)(64756008)(66446008)(110136005)(122000001)(2616005)(26005)(5660300002)(7416002)(2906002)(41300700001)(38100700002)(36756003)(38070700009)(31696002)(86362001)(31686004)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ckNhbHluUjg0RVB1Sml3ZVY5R0luNW9TdmlzckY2aGFQWHJlTTZYT1B2a2Ru?=
 =?utf-8?B?d08yaXVrSWk1enh3VlZsUmYxZEl1a0FpTUNzUmRpRFJMcUd0T1V2V2Y1R1dG?=
 =?utf-8?B?S2pxQnllMldNSEFXdUhFbEVWOUdFb3dRUmd2RWVRN1JwT25ZVWhiOTNGM0FV?=
 =?utf-8?B?NG9kY0VoWWRyTXNpdW5uQzgxUzcyMU9HcnRuckk5aHJGbTBxamlJUzgvdU1m?=
 =?utf-8?B?RkU2czd2cGRLT0JNbXJhNWJnUGpJWkJDSmFoUWNBVFVKRjY0aDdSVUhReTRL?=
 =?utf-8?B?c1JQSFoxOXIxYXBnYnI1MEhJQ0VoUStlZVJETXFsNE83eldPMHlBcXl4SUhp?=
 =?utf-8?B?LzRHSkpWRG56aDdOUnJ4bEl2cnAvb1VHMC9DRDNoWjlTMGJjTW85V1IxSnhs?=
 =?utf-8?B?d0l1RUdiOElOb0U1NXVrWDc0Ly9CZTVuanZXUjBlaGJXK0hFenU0U0tjY1Vr?=
 =?utf-8?B?ejlQZ09RcGY2MVhOQmFScWhWamRZWlRGd0hOcFNCc3kwSFhzbEc3aXZFcDZH?=
 =?utf-8?B?aU03aHFjRW9ENmVUMFh4QncvRGVOS291M2ZtQXFEUGFqVkZwQk9SYmxXbDB5?=
 =?utf-8?B?WE9WN0haUWxMREdIb3h4WDFwaS9VRDJkT2RQa09aWkRPTGM0MHROa1E0WlJC?=
 =?utf-8?B?RndseWdVSG5OK0VpYlk1TzA1TDVNMnpSdkludEluWkYvNndsVTY2U1NkSit0?=
 =?utf-8?B?Y0MyeTJtbFArYVdBejJWU0VENzYrYmtwN2tLUGdwZ2pDMlREWUxxVjJJTEJj?=
 =?utf-8?B?cHVmSTNPU1ZvZUVLUWV3dHpMYVdZN2JpbTFIeGJobVdhMitPd0Y3Zk10anN4?=
 =?utf-8?B?cS80SkdVNFlpN2RqcGprRU1sL1dyRWlvMTdSaTJ2a0VhNWVtTklxbkhPLytV?=
 =?utf-8?B?QittdXgzb0hEVUUvOWl6RHFXeERkbjVRLzdqdmZHcDlKUmNMcTMrSHQ5OHhk?=
 =?utf-8?B?OUhkT1dtNUVNYzZZRE5iYzNnOUhqRlFCdkhQWjBMRjFGVEF1NjVwdEQ0V1Za?=
 =?utf-8?B?SmxIbDVDRmUwSGtEbVRzdkxYejJ5ZXI3TFpUTlJkOXI2RHZQV08wcHNCM0hH?=
 =?utf-8?B?Uk5HOTdmcUNYV1hGZTVHN0dBSlRBQk85YmhMS3oyVVZGVWh4RUxpa25xK1oy?=
 =?utf-8?B?a09nbjk1bVJxZTc3L0RIS2hHOU53ODFFS0V0SUlPeUJveFArcE9MYUZYK2o2?=
 =?utf-8?B?eXpZWlpOTTIzQzE1Qzh0YjE2aWU4bG50SHdlSVVUQzJrUSs4Nll1VHJNZm9J?=
 =?utf-8?B?Q0h4WDg4a05sZ1QvckY1YWxiUjdKeHp6RFpLZlNEQldaL1BVdmlaWDNxUEJN?=
 =?utf-8?B?ZFFtYzErckJZVFpLM2U2RVZqRkxvdHRGNVBpWGZvQ0RXY3F2Qi95bkRHai91?=
 =?utf-8?B?dHlLdytFQVU0SFE2cG52UWw1NWl0S1dac3k0akZzWkVxRmt5NHlIQzcySStB?=
 =?utf-8?B?cXoxSEMzaWFCNFp0UHR1bjlmSE5KYjdaZ1ZCd1RibFBuZUJyOFJVcWFIR0Vi?=
 =?utf-8?B?YVRkeG5ibTcyTmNocDhSaW1scFlyQmllZThOcnBVZmxIS2w2ZG1telRPMjVp?=
 =?utf-8?B?WHFXcjVaN1ZtRmkycElqN1ZaYXdJS25aQXV1V3ZDcjhGa3lZem5aUjl0bEZa?=
 =?utf-8?B?Q3VDVks5aTVGKzhmb3Z6L01PZ0ZEMk01MHpCQytTQUtFMkV4Z2NGL25pZGNn?=
 =?utf-8?B?cWRSTWJsWHYzRkFXMDBVMVZBbW1OOFlWaDFKU3N2anZMMzl0UDhoUzdwUnRN?=
 =?utf-8?B?NzlodFR1VlY4cG45NTgxc0k1T013Q003Nlc2TkR1UTlFWG1vU0szWGIrMThm?=
 =?utf-8?B?OUw4STNqSGtFd1JRbVorYVVZUHZxSTFYbWk0Q2xXOHBqMHlOY2YwWk1pdk8z?=
 =?utf-8?B?MmRZV2pZU2NiQ1hMY21INUVyYzFKZUJ1NmoxdElSK1dmclNrY3kyMUFUOHdm?=
 =?utf-8?B?VnR2SlFobHc3YlJzZWg5NDFiNTQvSXBpNlZVa1pSWElub3JpTTEramhMeGRz?=
 =?utf-8?B?cjlocGI4WjRDMWNzUWlGSEZQM0R1NkhoYUpyMUt0eXZrVUFYT3E0TDRpT0RG?=
 =?utf-8?B?WUkwZmNHWTl3Q3FZM213YXhSYmRrZ2Q4UXMyTUptek1jWVJNUlhTWFFnTVY3?=
 =?utf-8?Q?aA76GOsQPbXcqdqaUA48npo/X?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <60D339495F9E0F4A8D6AFE9A6BE81DE9@eurprd04.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e58e18c8-a54d-4284-9165-08dc0d209fcf
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2024 12:28:15.0453
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oee1E7E34s6WwqGLnmWp+wJLy1OEO/LpPlwMIb4SksGpO9KgMb6TVt31UjGr4fteNjgxdkZ0jHm/VKpzW+loRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7967

QW0gMDQuMDEuMjQgdW0gMDk6NDMgc2NocmllYiBLcnp5c3p0b2YgS296bG93c2tpOg0KPiBPbiAz
MC8xMi8yMDIzIDE2OjQ0LCBKb3N1YSBNYXllciB3cm90ZToNCj4+IEFkZCBEVCBjb21wYXRpYmxl
IGZvciB0aGUgaGVsaW9zLTQgbmFzIGJ5IEtvYm9sLCB3aGljaCBpcyBhbHJlYWR5IHVzZWQNCj4+
IGluLXRyZWUuDQo+Pg0KPj4gVGhpcyBwcm9kdWN0IHNoYXJlcyBhIGNvbW1vbiBzeXN0ZW0gb24g
bW9kdWxlIHdpdGggdGhlIHNvbGlkcnVuIGFybWFkYQ0KPj4gMzg4IGNsZWFyZm9nIGJvYXJkcywg
aG93ZXZlciBpdCBpcyBub3QgZWFzaWx5IGRlc2NyaWJlZCBpbiBhIHNpbmdsZQ0KPj4gbGlzdCBk
dWUgdG8gdGhlaXIgZXh0cmEgInNvbGlkcnVuLGNsZWFyZm9nLWExIiBjb21wYXRpYmxlIHN0cmlu
Zy4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBKb3N1YSBNYXllciA8am9zdWFAc29saWQtcnVuLmNv
bT4NCj4+IC0tLQ0KPj4gIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vbWFy
dmVsbC9hcm1hZGEtMzh4LnlhbWwgfCA5ICsrKysrKysrKw0KPj4gIDEgZmlsZSBjaGFuZ2VkLCA5
IGluc2VydGlvbnMoKykNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL2FybS9tYXJ2ZWxsL2FybWFkYS0zOHgueWFtbCBiL0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vbWFydmVsbC9hcm1hZGEtMzh4LnlhbWwNCj4+IGluZGV4
IDQ5NTBiODQwYmYxYy4uM2JhYmRhMGQ1NzVmIDEwMDY0NA0KPj4gLS0tIGEvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9tYXJ2ZWxsL2FybWFkYS0zOHgueWFtbA0KPj4gKysr
IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9tYXJ2ZWxsL2FybWFkYS0z
OHgueWFtbA0KPj4gQEAgLTE1LDYgKzE1LDE1IEBAIHByb3BlcnRpZXM6DQo+PiAgICBjb21wYXRp
YmxlOg0KPj4gICAgICBvbmVPZjoNCj4+ICANCj4+ICsgICAgICAtIGRlc2NyaXB0aW9uOg0KPj4g
KyAgICAgICAgICBLb2JvbCBBcm1hZGEgMzg4IGJhc2VkIGhlbGlvcyBuYXMuDQo+PiArDQo+IERy
b3AgYmxhbmsgbGluZQ0KQWNrLg0KPg0KPj4gKyAgICAgICAgaXRlbXM6DQo+PiArICAgICAgICAg
IC0gY29uc3Q6IGtvYm9sLGhlbGlvczQNCj4+ICsgICAgICAgICAgLSBjb25zdDogbWFydmVsbCxh
cm1hZGEzODgNCj4+ICsgICAgICAgICAgLSBjb25zdDogbWFydmVsbCxhcm1hZGEzODUNCj4+ICsg
ICAgICAgICAgLSBjb25zdDogbWFydmVsbCxhcm1hZGEzODANCj4+ICsNCj4+ICAgICAgICAtIGRl
c2NyaXB0aW9uOg0KPj4gICAgICAgICAgICBTb2xpZFJ1biBBcm1hZGEgMzg4IGNsZWFyZm9nIGZh
bWlseSBzaW5nbGUtYm9hcmQgY29tcHV0ZXJzLg0KPj4gIA0KPj4NCj4gQmVzdCByZWdhcmRzLA0K
PiBLcnp5c3p0b2YNCj4NCg==

