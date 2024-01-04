Return-Path: <linux-kernel+bounces-16627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1411A82416E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 13:14:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D03B281795
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 12:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939D72137D;
	Thu,  4 Jan 2024 12:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="HHD70EHj"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2072.outbound.protection.outlook.com [40.107.241.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E2321359;
	Thu,  4 Jan 2024 12:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FL5XzfSIcOqrVhu+WeP4LFhX63FW/yfLofnjBuIUK0C0MoiWYuYT8iniy/FOpfthHlzfqlawP73oXaZ3FDuxhxHIi9AMq9nGjjkq+3Oztfy0rfcdpXojEMtWim6nrG/UJNJwaydgWZamzywwsVlSYZwZvfBVK+M8hNOVbKQOQiE6RAVhceNMC8igHndT7nXmfw4FpD1pGdTEpROX9mStijLKyzcMt5BOpAlufTqbVLNA8if76BtmWGOJ3UjBoOb3gxzSkANy9fHTbQMgNxol5TsViGwLV3VWtAnC2G9SI053sFO1gPNS+WXNf4SXnqNEJyugKj7IQIxAKYANTXHTaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r1SNWbBFN6pPSbOJvXUXdffHLNbdnPVnsHHgrqfMycM=;
 b=JDmVAHRGCJJY5j7nA7dUpTXCI9c38CZd2VLM8f3e6GmyNtPxPAuj4i/dH108InYKFC1apnJOIHal89Xcrd8USkqzMo+i0CDaQ2cTZ5qbPg8CP5Gh0MWidbXwBBvN4B3daYy/Cz1x3v/mXve2VKI7bamCsi+xEm5vUjDTHzwl3rNEtZaNVIbKDHNu44Pdc7ZHfWBnqDjUK683wGzfmVBn9ZshU2quQkGkIsPAw0vfKcuUxRqUK3WYIBVRtNExQf3q/VK6tOo8SBMcmUFTZWxy7TX+F2WizYSClBEfEZn53OzuvtlXb237LJWXW+9RzO0jL92Fl55eYxqxYGRPeHkarw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r1SNWbBFN6pPSbOJvXUXdffHLNbdnPVnsHHgrqfMycM=;
 b=HHD70EHjK6vBqYHi/JLSvlbl/O2cQOAeyKfNY76rvB3rxkTyrhJ4cVs6OAtTmMzhkNf+PuJwqZLibdPJFTJP5FdH/OCdO7L1GpvMYTAFZFxe32h0SSm0wpDkFZ75EgelsdZ/YTj2HSWNXqJdCYhYUq1r7dEszeqhTBWMz85/lao=
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com (2603:10a6:20b:42e::18)
 by PR3PR04MB7243.eurprd04.prod.outlook.com (2603:10a6:102:8c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.15; Thu, 4 Jan
 2024 12:14:36 +0000
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::daf2:8c54:d469:793d]) by AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::daf2:8c54:d469:793d%6]) with mapi id 15.20.7159.013; Thu, 4 Jan 2024
 12:14:35 +0000
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
Subject: Re: [PATCH v4 02/11] dt-bindings: marvell: a38x: convert the soc
 compatibles description to yaml
Thread-Topic: [PATCH v4 02/11] dt-bindings: marvell: a38x: convert the soc
 compatibles description to yaml
Thread-Index: AQHaOzcdGKp3ZJxHNkKTLh4Co3gaYbDJXLgAgAA8AoA=
Date: Thu, 4 Jan 2024 12:14:35 +0000
Message-ID: <46a09dc9-f824-4a2a-a356-8c6eb773a2da@solid-run.com>
References:
 <20231230-support-clearfog-gtr-l8-sfp-v4-0-1d7f0e2c7128@solid-run.com>
 <20231230-support-clearfog-gtr-l8-sfp-v4-2-1d7f0e2c7128@solid-run.com>
 <3f463dbd-14f7-4c2d-a464-647060cf45b8@linaro.org>
In-Reply-To: <3f463dbd-14f7-4c2d-a464-647060cf45b8@linaro.org>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8963:EE_|PR3PR04MB7243:EE_
x-ms-office365-filtering-correlation-id: decf657e-8396-4087-e35d-08dc0d1eb77d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 x+vI2vFGt4The4FReYurhLcW0k0ok7cm/fHK36zmalWfBbb8foOBeUnMrDC15EauDsN4fnv/wAcgbWu9nndjMV+1JDAGtbBPRiWQVeWd5Wwi1dB7xPkyGdmEqCoMPzkei/c6n9tooD+twR1NLM52aGaZTN6hHXFitENwLVB7+h9cAYDvxj7hGg7AfbeBkBmNfiRGqcCkJ9TqUHNcA6woLGOdqhbo/oj6oVV8FbTwnV/DjadfqEWbG4Ji1Rb9IeHancn7P7RhrhDce7o05lBrX0yL2nk1EsnNejOoe5dKyDDvAGe+H/PZUPPWL3R0EOC4JTHCpfxn6k35TPMv9D+1aB/M3f4aWJ7OrhwpTztLXLBX9VD9ZnbMd76MoVvqiVx/Dm5/go9hRzxHWg7BA7bKxDVL2bU2df00e8iDofECVCnuQZEw52gSKGpUwHf9w40bBDvS/eUQ9dfybZAgTR49KvWpyiBjYERFBiaVnnLHAbazvUGPwcT/18ckgqzjA/mNdN/n4ACYs8h0/KMKv0Rf5cdPl6w81y8+IqPsdhqZQM7V6Fe5acJEKy6muqgArQ85SkzLdDthJFQq7o59RQZ8S0IwXqpaCBgEwnljZ6OJTaRG0mowaK+GP0ZFf41JDiDlu3+E+l/9G73rsqCsbja05A==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8963.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39840400004)(366004)(376002)(396003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(31686004)(53546011)(2616005)(6506007)(6486002)(6512007)(71200400001)(478600001)(26005)(38100700002)(122000001)(86362001)(31696002)(36756003)(4744005)(2906002)(7416002)(41300700001)(83380400001)(5660300002)(38070700009)(91956017)(8676002)(76116006)(66946007)(66556008)(66476007)(66446008)(54906003)(316002)(64756008)(110136005)(4326008)(8936002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Y3VXbVNGWTFoVHJQSU5hYWMzWVMwb0w1MmlGeDVlNVNxOS8rS3IzSFNFQ2pl?=
 =?utf-8?B?eVJ5c0NOU25RSGpqaTE1aHRTUWpVQjA5YVkxaTdTQUxkVjhpdTRGN1NhVm5V?=
 =?utf-8?B?VHQxN3AvLy9qUmhHYW5JdjUxOXdFcEpKRnlKMjlOZnZMTUpQVm5YeFhpdkxs?=
 =?utf-8?B?VEhrcE9qR042dUZyV0YybFBjWm1zQmpqVlpYK0F5cEViamhxd0F3WnpUK1Fi?=
 =?utf-8?B?TnI3TGNaQkIwY1duRmVKMkxXVG15MVRpZndCVHNCSkFLLzhSM1ZoeDM0eWM0?=
 =?utf-8?B?R2hySzJsQzZNelNMVUIzb0pRdGplSTl4Z3pENmVyOWhNdlRKU0pKK3FFbjY0?=
 =?utf-8?B?MGtGOERuT1NCSGF3SDVHelpBRUZRS3p3QVU5MjhOMUl5Z1BhanpnVmRRZ0lC?=
 =?utf-8?B?RzNTTDIreDM3TjFUeXZOeGJUMktnZklEZmo2LzljZWF6bkxVOGkxNlYzV3hR?=
 =?utf-8?B?Tlp6NldpWVpEM0NPckxyZXg1TnhPY1NCNVNBU3JkSmJ5cHJNUUNaV0NKVHQ0?=
 =?utf-8?B?Z0piU3ZRQVdXTkJ5WkhEMU5tdnZGcDdtRGlYYzZNTHJMZnhWbUdmUFA0Y0M3?=
 =?utf-8?B?VE9QS3NTS3pEbzlSUlZMSTJHQTlnK0I2d1pXelNrTzlBbmJPMzFEd0o2L0xp?=
 =?utf-8?B?aGdQaVRpUkh1ZHFDMlAvYU5iSTg2RE9WRGFWQzhGK1g1QlJjNm4rRG5QcDFy?=
 =?utf-8?B?R3dqdmd6blg0YlZPam9tSm5rK0F0ZlFLbEIyaG1rNW1tYW5kQlN6a0cwZWpR?=
 =?utf-8?B?bkhGVG12WXgzdCtoUlBKZHpHT0h1Ly9uOStPRDNlbXk1MklPVVdvWndaL2NB?=
 =?utf-8?B?VUxrb3NnZnE5L1hIVS82dm1iVHA2MHkwbGZLWGR5RUhYMDZKQUVreG9ZRkVr?=
 =?utf-8?B?U3R1Z3BaOUJhbUJKMFRqWXRJemp3dGpuWkp3WXdSTEVNS3gwWm9jNEErN0hI?=
 =?utf-8?B?Zy85WGlicDBOTklwNUJCUE5tUGR1T0lCVkdkUWR0WFFnTFRtZE1TQURraFpa?=
 =?utf-8?B?MXU1bmNrUnZkc29INDBTTnFtT0loTnRCejdlZEUvcmcrelhkeGM5aDh3bVBy?=
 =?utf-8?B?R2dRYktQYUZIU3lZZGJ5emRydlFlcmdrek14TjlhSlRKNlZHa1FjLy91SGRj?=
 =?utf-8?B?YjllQ1ZGZzdHMFdwbWtmbURtRG1TaHAxSGMrQk14SlBZMW5ocTl4bnplS05P?=
 =?utf-8?B?dE0yblEzd2FxKzJEMEhnTHZ4M3h1V0dSMkRqTWx4L21MMWJIREFsck1WcUtK?=
 =?utf-8?B?NE56ZzFGT1FkenU4MW9qL29rbGR5TE5OUnhrRURTOHdkZ0xJYVFUNmxYaFJ6?=
 =?utf-8?B?VFQwVmFFSlBEUEpXRVVydHFyaVg5dUs4V3dPNU9VK0VIOFUzYUhFOTB3c2pE?=
 =?utf-8?B?cDJWaHBTSlJySUhWVHFzbW5JWHV4WnJBbkN6WmNWU0cwQmJNbklJU1h4YkJ2?=
 =?utf-8?B?c3dNUkJrUTkrV2V3TnBpamo2T0h4OGFoTHd2OXRMNDkrUU1Mc0xMTFEwdVJp?=
 =?utf-8?B?UWtUOUh1dXdCKzJHMXg2MDc0Qk1Za2ZDVHRFNzg3dG9FUEZjSWpkZGU1RzdK?=
 =?utf-8?B?OGMySzVwN0tDV2wzaTlOMnJMcWMyZEhUNFZrVEJORlh0cnc3NU1WaGt1amsz?=
 =?utf-8?B?aTVqd05IdlVuWjIrUitWNUZXOS82elBJTVZrNDMxSkMyeWVKVWsvNmYrWnFK?=
 =?utf-8?B?di9FR1dtcHk0T1gzb1ZoaVR3MXVVUkVuME9NcyswRGxGWDFod2llLzZvS3Iv?=
 =?utf-8?B?dnpGelNZUEpsZGVCN01jMHRaaGcxOUVodnYzaVo2TmpYMTAwNkZrUDFidVIr?=
 =?utf-8?B?akRKbDUzVkt6Zy9BRG5oL1pscVZJNU5hZHFBd2R1K3NmdTJ0a2Z3NUREOXZC?=
 =?utf-8?B?WUFKakhLZUxIT0JnVHhSL1FqanVnTjRDeVpENlRQbzhlQ2M5RTl2amtJanhv?=
 =?utf-8?B?YlRiNDhOUk1OM2JMQTJsSXdXWGFSUTB0RnRQZnJLdDJobENRUE1HTVhicjdO?=
 =?utf-8?B?VjJiekwxdGRQaEtGaE9rNHpMOXRXV3JWOHNqMEJERWw5T3VLbmQyUEF3RVRi?=
 =?utf-8?B?YnhTdVNOVHNreFdCS1hWcVl2UzR0Wk4wUFhxbWRUdWdqaXgzQlJPd2xTVldX?=
 =?utf-8?Q?+lpdKGSacqCw10h3pH7Nk+SI7?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B3CA8F50B506454CA8C77E3E180341CB@eurprd04.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: decf657e-8396-4087-e35d-08dc0d1eb77d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2024 12:14:35.8082
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JtRGZRn5Ctagy0+yF0lgxrhtqwBSuvVOuqWlU5rKygkW2kmSqjdgU78CqbDQPp6YQDCne0tKJA8dYWUluQVNDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7243

DQpBbSAwNC4wMS4yNCB1bSAwOTozOSBzY2hyaWViIEtyenlzenRvZiBLb3psb3dza2k6DQo+IE9u
IDMwLzEyLzIwMjMgMTY6NDQsIEpvc3VhIE1heWVyIHdyb3RlOg0KPj4gQ29udmVydCB0aGUgZXhp
c3RpbmcgdHh0IGJpbmRpbmcgZm9yIGFybWFkYS0zOHggc29jcyB0byBEVCBzY2hlbWENCj4+IGZv
cm1hdC4NCj4+DQo+IFdoZXJlIGlzIHRoZSBjb252ZXJzaW9uPyBJIGRvbid0IHNlZS4gQ29udmVy
c2lvbiBtZWFucyAicmVtb3ZlIGFuZCBhZGQiDQo+IGluIGEgZGlmZi4gSSBzZWUgb25seSBzZWNv
bmQgcGFydC4NCj4NCj4gKyAgICAgIC0gZGVzY3JpcHRpb246IEFybWFkYSAzODUgU29DDQo+ICsg
ICAgICAgIGl0ZW1zOg0KPiArICAgICAgICAgIC0gY29uc3Q6IG1hcnZlbGwsYXJtYWRhMzg1DQo+
ICsgICAgICAgICAgLSBjb25zdDogbWFydmVsbCxhcm1hZGEzODANCj4gKw0KPiBObywgd2UgaGF2
ZSBiZWVuIGhlcmUuDQo+DQo+IE5BSy4NCkkgaGFkIGludGVuZGVkIHRvIGRyb3AgdGhpcyBwYXRj
aCwgSSBzaG91bGQgaGF2ZSBzZWVuIGl0IGxvb2tpbmcgYXQgZHJhZnQgYmVmb3JlIHNlbmRpbmcg
Li4uLiAuDQoNCkkgd2lsbCBkbyBhcyB5b3UgcmVxdWVzdGVkIGZpcnN0OiBjb252ZXJ0IGFuZCBh
ZGQgc29tZSB2YWxpZCBib2FyZHMgaW4gb25lIHN0ZXAuDQoNCg0KU2luY2VyZWx5DQpKb3N1YSBN
YXllcg0KDQo=

