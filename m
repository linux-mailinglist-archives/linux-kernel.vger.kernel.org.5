Return-Path: <linux-kernel+bounces-25508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6908D82D15C
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 16:56:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2B681F211DE
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 15:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23383D7A;
	Sun, 14 Jan 2024 15:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="fR2G6mzD"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2087.outbound.protection.outlook.com [40.107.20.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055787E;
	Sun, 14 Jan 2024 15:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BOQ3xgdqEcn5wQNyxa+PngZxAjUi1cI4dTneUwcFKETNBaeSc6vbo7DD+vsYaAuLE2tlE0EI7BseWz2ZaZ4IuQS33TG11+VSgLxto3BrvrzbbIvTH4dGj1QUuItCCjz681eaXLOnIMuQtLOAmB3r7mzQKkJnfpXrCLkhzx0c3AfCfOItVl4uTlmqdbBZx/YVYEk8gG2yrCI47XukoprrDzuX3TiUujMQSv5yNPuLg8hw2bOsefkSHP3zqDnhn4UR2+Vz42CU0lM/ZQEyr+52+tmQq0PPwKwIR6ss1OcEcbHNADicoz3NRHAKY0h5JVFClROpco3YwKFd80o2i42nxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FjRtPvTU8Oe1Uue9eJFjG4ba0xSYdqHvXgXbo8x5CR8=;
 b=D9nO8f0S6cPpa76KDf9W/fqFqipu+2Ww2FsaGbCfD13wITMQ3wg2xfI6PNG5BdrnR1bUB0cH1ITIM/6ZGUS9tD8X92VBv42Xffs7G1VLiPmXt0YI+/+bI9xMoBxT8tpcN+O7dlO3ES81jYPbMO9PY39WCnod1NtW7B+YQcmvEtf98ri1c5zhFLo9u2CMZMS+sTTIrdkMrkndErR0W/vz187+/28oKOkS/30W4iZYDOh9TXkaOlz4WFZCDn62mSGh5yrcpqoKfAuedsZ2NfXXkRSlid5HCopJyZFRhipJztj6XAtIq01grlrSK+Vtz/3OK7JOJjnxAS9MfUXcAt3Hmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FjRtPvTU8Oe1Uue9eJFjG4ba0xSYdqHvXgXbo8x5CR8=;
 b=fR2G6mzDfbBPiu5GjErRLhjjXRX0iQljuO+5dZcIFNxuJkPVuJ9ecFl7WjwpcmqUXAAbHzr+IA9FJ66axqL1O6oVNwbcwtxmd0HDdACfleU6IwjHcUTergZUFxqJ0x4TMNKtfrPN0jwNb4a/jRKU8SL5Px2XUAiu6rGLyDDHqQY=
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com (2603:10a6:20b:42e::18)
 by AS5PR04MB9800.eurprd04.prod.outlook.com (2603:10a6:20b:677::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18; Sun, 14 Jan
 2024 15:56:08 +0000
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::daf2:8c54:d469:793d]) by AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::daf2:8c54:d469:793d%7]) with mapi id 15.20.7181.020; Sun, 14 Jan 2024
 15:56:08 +0000
From: Josua Mayer <josua@solid-run.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Nishanth Menon
	<nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo
	<kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>
CC: Yazan Shhady <yazan.shhady@solid-run.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-rtc@vger.kernel.org"
	<linux-rtc@vger.kernel.org>
Subject: Re: [PATCH v2 2/5] dt-bindings: rtc: abx80x: convert to yaml
Thread-Topic: [PATCH v2 2/5] dt-bindings: rtc: abx80x: convert to yaml
Thread-Index: AQHaRXqM9m6egMxAy0iAmXaXPfibdLDWa+UAgAMNhQA=
Date: Sun, 14 Jan 2024 15:56:08 +0000
Message-ID: <fa954f30-22dc-4914-b037-c0ebb311637b@solid-run.com>
References: <20240112-add-am64-som-v2-0-1385246c428c@solid-run.com>
 <20240112-add-am64-som-v2-2-1385246c428c@solid-run.com>
 <7f45aaea-6520-41c7-8788-f6dd14c5fcb2@linaro.org>
In-Reply-To: <7f45aaea-6520-41c7-8788-f6dd14c5fcb2@linaro.org>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8963:EE_|AS5PR04MB9800:EE_
x-ms-office365-filtering-correlation-id: f38ea860-0934-4ead-ee47-08dc151952c9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 f5CISx0/AtI2qf760BN8V6cTieCIiZSf4ebZa7uPoSUREZf2KWiy6uGTpMc3dZFi/io4wJsWmC0J4tvXT1qOepZZeFNk6+LURxyde+TRt5clINphi50njP35Lrr87qt0oOZNi8SqyN1hAdKj342hOzPTT9FRZkfXWho1PNDO+CSwqTxIoJEQsj9E1WRi6DFrpmG2AylngWtFpGGUkQXfRHOn5egze+loV6fpDdx3Q60hq8ZQyoEaW7b6WWo4TluBGOI9xxVZveRs108MOlz7JYCAW1zAmIXaOgx9J1dVGfEdD6ylDAWvzUyWmeKikti0elbJKip8chxEO1MEAYIIMLgqWbfb7c1O1RMQG6HUsALBG7KH6gut/Zmuc0t7QO+ZDHlHQtqn53486Kk/6uBeSkRzwjA5u0f7QVwDQmN1m65qn6ep3bMXP2ClvdGD1ZgaeyJza4YhnZhxZGhXfODFKYU9+slgjuyOQ1ijC1SDkcY73agDh1/NutYzmJkr5JJWuZ9BdW72pI9yrYs8YvJfDI2myRqquMauXbFUT/3fgHwbv9pTxJzLGnBmFyMPG5CnNNLFDA/6hEsW+0n2zeFZbxi8gAkUHxWuojYlIoVfvavoGc9OwqQzbjfT5BS1Mmxn
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8963.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(136003)(39840400004)(396003)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(71200400001)(6506007)(2616005)(122000001)(478600001)(26005)(6512007)(966005)(53546011)(83380400001)(2906002)(7416002)(76116006)(91956017)(66446008)(110136005)(6486002)(66556008)(64756008)(54906003)(66476007)(8676002)(66946007)(316002)(4326008)(8936002)(31696002)(5660300002)(86362001)(38100700002)(38070700009)(36756003)(41300700001)(31686004)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cUxmMVlTd003RzVJcFdTa0t4OE13UXhEWjRIKzZMcU5nc0NOYTY4WTAzWkNK?=
 =?utf-8?B?ZUl5SzdzdWhEMW55MEJiNWF2b2N6NmhaMFhuQnlLN0JlZVBGaitDUlNVVEJ0?=
 =?utf-8?B?Vjh1U2NPTEladGhFZkJTQml5bzB6TENHd3ZyTysyNWxTaW9uQ2J2ZWd1bEk0?=
 =?utf-8?B?Nm9SMVlYazVHSkFaMUhpUlo3c2Z0QzM4aVordUhqa1RHbVBabjN1UU5UT2Na?=
 =?utf-8?B?YXJCY3NmQkVlWGN3L2VIM2M3SFJTYU0vME54WjZxMUorTUFLaSthSStGSXYy?=
 =?utf-8?B?NzFQM3NDZ29EWk9UczViMFhxTEo1ejc3M3k0MGtlV09KMGR3WTZiTFJiRi9h?=
 =?utf-8?B?WFU2TnNzK0duTjJtR096OTFGTTJmSjhPNlV2aGRXMWpaSE0yZVJvb21TU3lI?=
 =?utf-8?B?am1SRGdMbUxndytVeEJCeXdOMW1BUVRmclhBTkZ1UHVFaHpTWXpGWG1MMkNp?=
 =?utf-8?B?TFdXbzNQK1hiTkVRbkV0R1ZDaCtEcEZiOVVuKzFRY1J2Q0xhT2Q2ZWorczZx?=
 =?utf-8?B?WEViREVidW40cTNDUUw5UW5ad24rVGZjZEtkd3FhUkR0TS9SUWpsdjJXWElu?=
 =?utf-8?B?ZGRqTFpuVE4xclE4S2xaSXg2NzdWNVFsamwxRWlYZHVyUGRsbkFOT1AvS3I0?=
 =?utf-8?B?K1g2MFI0M3lKbVM1N3FTeVRrWWJtc0dCYXU5ZnpTcFZhY1B5RFkyUG0vVU94?=
 =?utf-8?B?cEJIaDUyL0xyN0pMbzM4ZzRabEs5Sk8vbFNXNG85Q1pRaDl1N1pneWlZZjlj?=
 =?utf-8?B?bmJUcXFkTXN2bkpIdTVsY21zbFBNQ0N1TkROdDlOL3V3Lzh6d05OamN4RkJB?=
 =?utf-8?B?bHkxSWJDUDFMZ05GYktDdklqYTZUK3BoRjkyS1VkeE96UVZZTTB0d3dZcmND?=
 =?utf-8?B?ZTI1VklvZ280N0R2Ti9xWkdqZmZRYmpHOFlnZk9VdWd0RWFnZGhUV3R6TU5r?=
 =?utf-8?B?VmRsMWplS2N0dHlYaXFYaE9aT1gvSVFqREg1M1VUeVdHOE0xYnBQNzViRnNa?=
 =?utf-8?B?bktKL3orQW9mTmpFWmZkckFIaEVpR3lmQy9QalJvWVVNWm9DanJ2aFliUnhY?=
 =?utf-8?B?YUdKRkh5aVNhQklnUEJSWDRiMjBiQ0owYjlsdWx3VHdkaUhvRDhYVkhzZ0pH?=
 =?utf-8?B?OVZSNmR2OWtuMG96ZWlOL2tHbUxzd2VBTXBjN0dTVHpDRGlrM0NrcVlKQ3hx?=
 =?utf-8?B?YWtSTGRMN0ZJMjBXMGVWcmsrQmFqa1FkOFZGa3kvRVVEclNscUtpdHFFNXVK?=
 =?utf-8?B?d0FIdExjalhCWDVkMWhGcUVxdEE5Y3pETzBMVW12djBKU1NiYkdCVWgrZnZZ?=
 =?utf-8?B?WXU5Sm03T1Nnc1ZBZnFNbTdwZ2NoNnVDSlliUG5CRFdrRkE2VGFXcEljK2k5?=
 =?utf-8?B?NDRuZFExb0RsL3JDRzEzSlNkRndSWWxDQThYWGVUY2NZWlV5WnQvNFJEdTZM?=
 =?utf-8?B?TDZUa3l3RWpMYUJjWTdaWHdDd25ZUUdLMWIzREw2ZUFaL2ZoVEVDZVhnTVYz?=
 =?utf-8?B?SzFIem5FZGZUakdHSWtsOHJ2NU5JNFMrQ0NxZEZtKzNEY2pNeTNlVWtrM1pj?=
 =?utf-8?B?dGx1VktyMkpQY0FGdVo0ZTRBVVdlVjhSa0FTNXB6TVBRSWdFd3d6UmtjRzMy?=
 =?utf-8?B?K0dTYlh5TGk3VlJtNldJb21PaVZUVU9CR3psVjUzQy9ybng4QWMyS2UxVnQ1?=
 =?utf-8?B?WFVwSkg0Z1lJOTRaaFJCRWNjd25sZGxHK21BSWZxTE5rejBiYyt5bG5FTHZF?=
 =?utf-8?B?ZnR3RVk5aDliK2NKWTRlZzJEaGp3QXZGaHB4S21kSTZKZ2NKWXJMaFViSEk5?=
 =?utf-8?B?YmlHeGRRNGgxTmtKZnhvRzVOaGgvd0xpdG9zR1NEQnBzUzFFQytSQ2Z5Z0d4?=
 =?utf-8?B?aXNJUHJOeFlmQWhURTEzN2xoUnlMWDYzZUo2MlpvaEtodHZDd3hHN3dYczgv?=
 =?utf-8?B?TjFtVjBxNmxJaDFzVU8vb0lqekNjU3NMUmVUek9BZUJuQkJkN2RORjBvNE4z?=
 =?utf-8?B?THVkYzlEVjlyMGdHc1o0Zk5QV1htN0ExeWhJSFlES0dkZkdVT0tJb3ZvT3pL?=
 =?utf-8?B?R0NBeHVRYi9NdHVZQXVnWEJkK1NpWENFNkZRdjJoekQwWFI1QWJFUUswVnd0?=
 =?utf-8?Q?4Uv90qXLmiksEQK2Cg00cNKIY?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <35C3485E7084FA4098C291DCDCB658AF@eurprd04.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f38ea860-0934-4ead-ee47-08dc151952c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2024 15:56:08.6559
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MavKROQM6mddNdHD3ntyP7HXkSPt280UbdF2Cl9bjT12DkIWSxfDD1eZYINB+1Nl0We79/XoVy2LOyG4J1EJAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9800

QW0gMTIuMDEuMjQgdW0gMTg6MTggc2NocmllYiBLcnp5c3p0b2YgS296bG93c2tpOg0KPiBPbiAx
Mi8wMS8yMDI0IDE4OjEyLCBKb3N1YSBNYXllciB3cm90ZToNCj4+ICsrKyBiL0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9ydGMvYWJyYWNvbixhYng4MHgueWFtbA0KPj4gQEAgLTAs
MCArMSw1NiBAQA0KPj4gKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IChHUEwtMi4wLW9ubHkg
T1IgQlNELTItQ2xhdXNlKQ0KPj4gKyVZQU1MIDEuMg0KPj4gKy0tLQ0KPj4gKyRpZDogaHR0cDov
L2RldmljZXRyZWUub3JnL3NjaGVtYXMvcnRjL2FicmFjb24sYWJ4ODB4LnlhbWwjDQo+PiArJHNj
aGVtYTogaHR0cDovL2RldmljZXRyZWUub3JnL21ldGEtc2NoZW1hcy9jb3JlLnlhbWwjDQo+PiAr
DQo+PiArdGl0bGU6IEFicmFjb24gQUJYODBYIEkyQyB1bHRyYSBsb3cgcG93ZXIgUlRDL0FsYXJt
IGNoaXANCj4+ICsNCj4+ICttYWludGFpbmVyczogW10NCj4gWW91IG5lZWQgYSBuYW1lIGhlcmUu
IElmIHRoZXJlIGlzIG5vIGRyaXZlciBtYWludGFpbmVyIG9yIGFueW9uZQ0KPiBpbnRlcmVzdGVk
LCBwdXQgZGV2aWNldHJlZSBsaXN0Lg0KQWNrLg0KPj4gKw0KPj4gK2FsbE9mOg0KPj4gKyAgLSAk
cmVmOiBydGMueWFtbCMNCj4+ICsNCj4+ICtwcm9wZXJ0aWVzOg0KPj4gKyAgY29tcGF0aWJsZToN
Cj4+ICsgICAgYW55T2Y6DQo+IFBsZWFzZSBkbyBub3QgaW52ZW50IHlvdXIgb3duIHNvbHV0aW9u
cywgYnV0IHVzZSBleGlzdGluZyBjb2RlIGFzDQo+IHRlbXBsYXRlLiBKdXN0IG9wZW4gZXhhbXBs
ZS1zY2hlbWEgb3IgYW55IG90aGVyIHJlY2VudCBSVEMgYmluZGluZy4NCg0KVGhpcyB3YXMgaW5z
cGlyZWQgYnkganNvbnNjaGVtYSAvIHN0YWNrb3ZlcmZsb3cuDQpXaWxsIGNoYW5nZSBpdCBhcyBy
ZXF1ZXN0ZWQuDQoNCj4+ICsgICAgICAtIGRlc2NyaXB0aW9uOiBhdXRvLWRldGVjdGlvbiBmcm9t
IGlkIHJlZ2lzdGVyDQo+PiArICAgICAgICBjb25zdDogYWJyYWNvbixhYng4MHgNCj4+ICsgICAg
ICAtIGNvbnN0OiBhYnJhY29uLCxhYjA4MDENCj4+ICsgICAgICAtIGNvbnN0OiBhYnJhY29uLCxh
YjA4MDMNCj4+ICsgICAgICAtIGNvbnN0OiBhYnJhY29uLCxhYjA4MDQNCj4+ICsgICAgICAtIGNv
bnN0OiBhYnJhY29uLCxhYjA4MDUNCj4+ICsgICAgICAtIGNvbnN0OiBhYnJhY29uLCxhYjE4MDEN
Cj4+ICsgICAgICAtIGNvbnN0OiBhYnJhY29uLCxhYjE4MDMNCj4+ICsgICAgICAtIGNvbnN0OiBh
YnJhY29uLCxhYjE4MDQNCj4+ICsgICAgICAtIGNvbnN0OiBhYnJhY29uLCxhYjE4MDUNCj4+ICsg
ICAgICAtIGNvbnN0OiBtaWNyb2NyeXN0YWwscnYxODA1DQo+PiArDQo+PiArICByZWc6DQo+PiAr
ICAgIG1heEl0ZW1zOiAxDQo+PiArDQo+PiArICBpbnRlcnJ1cHRzOg0KPj4gKyAgICBtYXhJdGVt
czogMQ0KPj4gKw0KPj4gKyAgYWJyYWNvbix0Yy1kaW9kZToNCj4gTWlzc2luZyB0eXBlIC0gc3Ry
aW5nLg0KJHJlZjogL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvc3RyaW5nID8NCklm
IHNvIC0gYWNrLg0KPj4gKyAgICBkZXNjcmlwdGlvbjoNCj4+ICsgICAgICBUcmlja2xlLWNoYXJn
ZSBkaW9kZSB0eXBlLg0KPj4gKyAgICAgIFJlcXVpcmVkIHRvIGVuYWJsZSBjaGFyZ2luZyBiYWNr
dXAgYmF0dGVyeS4NCj4+ICsgICAgYW55T2Y6DQo+IFVzZSBlbnVtIGFuZCBleHBsYWluIHRoZSBt
ZWFuaW5ncyBvZiB0aGUgdmFsdWVzIGluIGRlc2NydXB0aW9uLg0KPg0KPj4gKyAgICAgIC0gZGVz
Y3JpcHRpb246IHN0YW5kYXJkIGRpb2RlIHdpdGggMC42ViBkcm9wDQo+PiArICAgICAgICBjb25z
dDogc3RhbmRhcmQNCj4+ICsgICAgICAtIGRlc2NyaXB0aW9uOiBzY2hvdHRreSBkaW9kZSB3aXRo
IDAuM1YgZHJvcA0KPj4gKyAgICAgICAgY29uc3Q6IHNjaG90dGt5DQpIZXJlIHdhcyB0aGUgcmVh
bCBtb3RpdmF0aW9uIGZvciBkaWZmZXJlbnQgc29sdXRpb24uDQpXaWxsIGNoYW5nZSBpdCBhcyBy
ZXF1ZXN0ZWQuDQo+PiArDQo+PiArICBhYnJhY29uLHRjLXJlc2lzdG9yOg0KPj4gKyAgICBkZXNj
cmlwdGlvbjoNCj4+ICsgICAgICBUcmlja2xlLWNoYXJnZSByZXNpc3RvciB2YWx1ZSBpbiBrT2ht
Lg0KPj4gKyAgICAgIFJlcXVpcmVkIHRvIGVuYWJsZSBjaGFyZ2luZyBiYWNrdXAgYmF0dGVyeS4N
Cj4+ICsgICAgJHJlZjogL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvdWludDMyDQo+
PiArICAgIGVudW06IFswLCAzLCA2LCAxMV0NCj4+ICsNCj4+ICtyZXF1aXJlZDoNCj4+ICsgIC0g
Y29tcGF0aWJsZQ0KPj4gKyAgLSByZWcNCj4+ICsNCj4+ICt1bmV2YWx1YXRlZFByb3BlcnRpZXM6
IGZhbHNlDQo+IFByb3ZpZGUgZXhhbXBsZS4NCk9rYXkuDQoNCg0KVGhhbmtzLiBzaW5jZXJlbHks
DQpKb3N1YSBNYXllcg0KDQo=

