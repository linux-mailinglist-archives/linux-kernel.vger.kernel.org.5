Return-Path: <linux-kernel+bounces-24697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E73FA82C0FD
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 14:41:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 554511F21F21
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 13:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE276D1BA;
	Fri, 12 Jan 2024 13:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b="czAuonYl"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2132.outbound.protection.outlook.com [40.107.8.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD31167E95;
	Fri, 12 Jan 2024 13:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=leica-geosystems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Njwj+kRCZOcNxUgVqOiG5PjeWZ3v1FG6kQ+F711gtstz3vICZB7GWSYSGUW1n1o+AhZvoFBjKnXBI8loNqXUghcMNqVe1EaTSzwCKYqfZ2hHujBAiL+JDLzhD+3mVSu94Ww83qtRzGIbLd1EFbYlZX3fQMpz3vUVd91vj+7qryDjc2Lg7vYEm5F9ZUyUebzfhcyv3myXcZRN+n3SxNND9otMkTB8y1lpnKWCAxSbHnVFahPMIFu4omyKVMfNQ5J7n5bDf80l3B5gwuDWGh8OIjknCo/fiCENyUKXiuJ3ZYrRhICvKruLYZFnW3iADoePPkdnj1ouZSpRzrE+S6mOwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WPRtsFQS5q4BSxHsctc/a0DAEKrpfoqx3TsqstxF3sA=;
 b=cqzJrNbMQ21cojR5qK7PTwu9UkPvtz+ZHWH7XJqkMqeniXsPGwymMKJl9o4+JSHgs0Q4LCdF0iZNfn177oX2pNRV2IepwsfDFUR8lJm+k1atoc5cJDkmHCOwVPKjlR1EOq8dSBAu/88pWV3BjAH66UNWEM1ycfCOFDQ0xvqYW83ex9onB7dTIO/OHX7NFPh3MDQdvFMT9eIQGhKOCT989Vf3sXmhY1FLz/80Je2+wKypgw+yQ7sFYrfLap14l9BBaCT7FJSU9v6U2P+QqlGwNvFFA2EZ0qWewkvH+kk0n8RFJwKYSchzoXGDy2zpCvHH+HHb4gvaNvFaqb6sfbXnMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=leica-geosystems.com; dmarc=pass action=none
 header.from=leica-geosystems.com; dkim=pass header.d=leica-geosystems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WPRtsFQS5q4BSxHsctc/a0DAEKrpfoqx3TsqstxF3sA=;
 b=czAuonYl0ghn2FE5YZ7p5rxg9U6wxGZo+gFXfRvX97fvpamVFUObi+DQ2Cpy6f0jzphMHh5BJ5Uwh9VoTNggry8Je2Bd3vxRcb0xAHzlfgzLkf1WPie3nyINIS5pDmeqAX8asOIASMU6Xd9pSRe5LtLd6cXbNRA/6nBT/SSDZzM=
Received: from DB8PR06MB6332.eurprd06.prod.outlook.com (2603:10a6:10:103::23)
 by VE1PR06MB6877.eurprd06.prod.outlook.com (2603:10a6:800:1b0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19; Fri, 12 Jan
 2024 13:41:08 +0000
Received: from DB8PR06MB6332.eurprd06.prod.outlook.com
 ([fe80::2ef6:99ac:4fcc:7039]) by DB8PR06MB6332.eurprd06.prod.outlook.com
 ([fe80::2ef6:99ac:4fcc:7039%5]) with mapi id 15.20.7181.019; Fri, 12 Jan 2024
 13:41:08 +0000
From: POPESCU Catalin <catalin.popescu@leica-geosystems.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, "Russell King
 (Oracle)" <linux@armlinux.org.uk>
CC: Andrew Lunn <andrew@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "afd@ti.com" <afd@ti.com>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, GEO-CHHER-bsp-development
	<bsp-development.geo@leica-geosystems.com>
Subject: Re: [PATCH 1/3] dt-bindings: net: dp83826: add ti,cfg-dac-minus
 binding
Thread-Topic: [PATCH 1/3] dt-bindings: net: dp83826: add ti,cfg-dac-minus
 binding
Thread-Index:
 AQHaRKoS6UQg1dt3TU+QGYO25gfEa7DUzvGAgAAC4gCAAAHngIAAAemAgAAGQoCAAVTDgA==
Date: Fri, 12 Jan 2024 13:41:08 +0000
Message-ID: <ca895fa2-df94-45f4-8472-336ff71e70f0@leica-geosystems.com>
References: <20240111161927.3689084-1-catalin.popescu@leica-geosystems.com>
 <c795aa28-b6a2-4db8-b941-05b51b44f1fe@lunn.ch>
 <a4af4a08-6eea-420b-b76f-47f4e836b476@leica-geosystems.com>
 <ZaAcvwWbNmSpw/xt@shell.armlinux.org.uk>
 <c5b4613a-261d-429b-b59c-c264bc53e315@leica-geosystems.com>
 <0da41018-eeae-4a15-a431-954da99261d0@linaro.org>
In-Reply-To: <0da41018-eeae-4a15-a431-954da99261d0@linaro.org>
Accept-Language: en-CH, en-US
Content-Language: aa
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=leica-geosystems.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB8PR06MB6332:EE_|VE1PR06MB6877:EE_
x-ms-office365-filtering-correlation-id: a6056cbc-7e10-48e6-3de9-08dc137421af
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 iM/ws6lBbUJizDgCUNfo7tmUIwrjVagO+eRF+m7eyvbM7ofaJGXDPDf5l3Xli2fxj2uks8uqXqvEpKXuyFvt++jiKRGYgAPMdHTrgtoYvkywhIcKDPD57JFFLjbceFltEwPlD6f/KhMSity9yrGxtpvY76sQX+/ZkzvqTm988ORJenshLuFjaBiWMkFdBRS9sPTAUG9kklip+8/R35L+MJHWFxkxUIarIK13bhaQtrZ1nFllGBto3as0QHnla2zCAKsiY67Y5U8oEVF03tMj0qQoJydYFygEhYoz55OffOaI1OEHYeI+v/jfXuFfT+U602FI/OiVc4rjOOdSL7mvYSE239SRoMf0vR+uSr1eUXXVyyJ/L0H5w0yzk2ALZKZ5Fx4Sf0msB+OZlcErHBREm3IhvALVURWWGNVsFCO0rF5w9P6dMmMUnWkc2ypIUrr8+VIf4yL6j+kMB9r09AtcaYg8nqpDiL1/cGsZuTy4dPsV1VThVUKTWjBPepuemu5LwJg4x0XRDIf2+oWbxOqs75LrIzx8w22G9BSAZlyIUp9vJbxdJ1o7Pcn7YaHHql/6grRfsN5SRm9Fxd+DAA+w0vfF7I++GJy3qAciGwjQ/TfVcD3zWm7joR7sSm7sXy6BCQ1ST+v4sCd3x5Q/jy8ati/YY0LjAREMeZo7BrDtIDHaMk3xr5gSV6A7tkZadACxBsK4E8o799zM9j0cdoD98cPnfoWGgZlmTUK6FaxdGzY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR06MB6332.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(396003)(366004)(136003)(346002)(230922051799003)(230373577357003)(230473577357003)(230273577357003)(230173577357003)(451199024)(1800799012)(64100799003)(186009)(38100700002)(2616005)(53546011)(107886003)(26005)(5660300002)(122000001)(71200400001)(8676002)(4326008)(64756008)(2906002)(41300700001)(8936002)(7416002)(66446008)(76116006)(966005)(66476007)(66946007)(54906003)(478600001)(45080400002)(6506007)(6512007)(316002)(66556008)(91956017)(6486002)(110136005)(86362001)(36756003)(38070700009)(31696002)(31686004)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NHpOb2JDS0lNMExHZmtpSHhQN04ySGdyY3Q0NjVidGpNM2ljeVpjN2Vqbkd5?=
 =?utf-8?B?cjNWY2c5VWZvS0ZEREtSQThSNGdsYmFXek5POTlXRTFkTWQ2MmhQekZaQ2Ux?=
 =?utf-8?B?WWJuTGZNaTBFYk5Xc2RLODFtNVZmYzBGRS9RRDVsSElhTTJMS1JIMEhxRVB6?=
 =?utf-8?B?YThFQ3N2MWRXaHR6NDJQYnN1Ylgya0xiaVBETHFkSE95WThhdGF2NEdXZ0JN?=
 =?utf-8?B?dDRxTjlMV3FKSjZxQm1FNjEwOW91bkZhREE4dVpabUpZMVJMbDMwYXN5YWpG?=
 =?utf-8?B?UzM1UmoyaWFqbFRnbWRqcHhFSmpRWU1SOC9zTDRuYmdPUWNCR01TWkYzaGtX?=
 =?utf-8?B?Tm0rSHFkSUwwSllKd3AwQ0NRUjhFNUoySFJmdkVDeVphaDB2N1RLdnQvcFA2?=
 =?utf-8?B?WW1xNm5ielZYZTJ4cmZQRk5GMHMzWjR1dzd1MG43c3dCS1JYVHBtSFo4cFJP?=
 =?utf-8?B?a3J0RlJPb0FTZ092dElhNG1LL1R5aFk0OUJ4T3lrbU9nOWEvaUtJNjk4UVdm?=
 =?utf-8?B?SFUyblB4Ym9zSitrdFE2b3FMVUQ5QnBpdlJjNEx6MGlTdXRrV2tEbHg0Tlpl?=
 =?utf-8?B?cXh1V1VZM3lSY05OaSs1VWtJQzlFMlNTMndGOVNKd0pHUE55V1RlNExYRU5s?=
 =?utf-8?B?TG9qMlNvaSt3Wm55bTZRMFhYWEZuNlBoaldQSzNkclJlNkJ4SXI1WUg4b01q?=
 =?utf-8?B?dGtURzlOWjkxNTIwZUVydCt3TitoVWRjbFhRWXVqekllZ0t6Z0RtKzRVbXhR?=
 =?utf-8?B?cDQ0ZEljd2ovbnpsVzFucFlZaUs4ZzBlZ3J3bTVsZ29jd1hlNDJQemp2M2hG?=
 =?utf-8?B?bVdZRHhjSWdJM2I2S1NLQmx5M3BpSHdkWSt0YWYxakZPSWVBa25MKzg2SWx4?=
 =?utf-8?B?RytCVTdNRCttZmhWdXhJVlpUcnhselRUM2VueHZSVWJndWFCaXo3MmJsUGVl?=
 =?utf-8?B?eXRFeXBHem5DeW5qWTdMRkV2TjNMU3E2UjZNeGxkQ1liR3VMSFc4K2ZSTjZI?=
 =?utf-8?B?SlNlQ090NjNqRlJ4MXcwcHpqOE96VHZWWTl5UjMxVEpBOXVvRTRxL3dmK1dR?=
 =?utf-8?B?ZnZXZi83NTZCVE1nL0RFRmY5TWFVR3MzQ0RabzdnVFlvSzlzVW54U0tLdGY0?=
 =?utf-8?B?UnZWMC9ZLzFGMHpyZFZFQ1pWV1dDSlY3em9DVHAzTWs3M3p2ZERZaTN2ZWUy?=
 =?utf-8?B?cnJaY3pxWkIxZHpFN2Z0b3l4Ukg4S0NTODhnZExYS0FMUWV1RHhsWlVYSGdL?=
 =?utf-8?B?WFpBK3laTzE5QWsvN0VGYnBzQjBaRUFkUFlqZmJqRjJqU3J1N1ozSkZLMXpJ?=
 =?utf-8?B?cTN0d0pBNStqak4rQU9YZUp6UlRTTDl5TlJOanI5UXdZdVJkb2c5cngrZlFu?=
 =?utf-8?B?ZDVNYjJjNW9wY0pOdmR2RDdmZEJxUTl0dWlxZmR3dkEwa0dtYzk2eWFBQ2t2?=
 =?utf-8?B?YnNaUHA5bG1vKzFaV2M1MUN5Z3hnRTkwbS95WVcxTjk5ZXppRHhVbVlIUkJx?=
 =?utf-8?B?K2FYRUdlNGkrUlh4YXg4UFN0TG1lVjdiSkh1MlVUSjlMSlQ3U2s5eHliRS9t?=
 =?utf-8?B?cWJzRDZCN3FoSjFqVEh0T1lScUorcStPb0tsQ1VtT2JIQVJuQTJwMEFmaVhM?=
 =?utf-8?B?ZjdKY0NYK1lMbE5QOW1vWjdwUnA4MzJEZ0Rwd0ZKTnorNWVhdWVEMkJpS2d4?=
 =?utf-8?B?WEk3YTJZbmUraktKV1FaaWJPcTBwSGR3VGxMMEJ1emdEc3FacTJiQ0QvUHhy?=
 =?utf-8?B?ZHRNdlZOQnFYRS9xTjFyMC9sYkJNRlZYdVRackoxRWdXaW56MXE1dG1XZDc2?=
 =?utf-8?B?Tkx2V1BpRjlscGFoejF6TFVXdWpFZmIwNm9rNmVpeUN5VkRsZmljZk9rQnFX?=
 =?utf-8?B?N3hqY29RYkJjMFd3SlIvdFhuT21Nd1lRaDZzLzdOYlJlUG9nWXdnSTg4eEFY?=
 =?utf-8?B?VzRxeGRJSy8rcnRpWTh0TDFZYW55WmhXTGtVdjZXV0VjcHgzbGlYUXRFc085?=
 =?utf-8?B?aTVzcEFIRVQzVGVJOFd2MlM2ZGkybE1XWmUrRnNGQzhuWVlJazQ4L1daYVR0?=
 =?utf-8?B?NG9yUkRaa0diZHVUVnlrNXBKaWZORlFTMGl1VjlJNFZmZloyM21CdnVWUitU?=
 =?utf-8?B?bmhFc1phZnJvSSswa2p1VlMrVDJhYkFWclp0RkFiMXVYWkRDR0ZmZldadENP?=
 =?utf-8?B?M3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <436FD1C35B98764190E036A085C7F380@eurprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR06MB6332.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6056cbc-7e10-48e6-3de9-08dc137421af
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2024 13:41:08.1734
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HhqiCFd28RX1bHZXqSZkaJ5cRxxK2lGeNUqSdxpbZMjLOS3JzuhWxPk5HI9V+/ahnSh5zNH0GfpYzDyQVdQ7ZMa2RVK8H786zA7gfr166R3RgxK4u/8S4V3+hX1n7z8z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR06MB6877

T24gMTEuMDEuMjQgMTg6MjEsIEtyenlzenRvZiBLb3psb3dza2kgd3JvdGU6DQo+IFtZb3UgZG9u
J3Qgb2Z0ZW4gZ2V0IGVtYWlsIGZyb20ga3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnLiBM
ZWFybiB3aHkgdGhpcyBpcyBpbXBvcnRhbnQgYXQgaHR0cHM6Ly9ha2EubXMvTGVhcm5BYm91dFNl
bmRlcklkZW50aWZpY2F0aW9uIF0NCj4NCj4gVGhpcyBlbWFpbCBpcyBub3QgZnJvbSBIZXhhZ29u
4oCZcyBPZmZpY2UgMzY1IGluc3RhbmNlLiBQbGVhc2UgYmUgY2FyZWZ1bCB3aGlsZSBjbGlja2lu
ZyBsaW5rcywgb3BlbmluZyBhdHRhY2htZW50cywgb3IgcmVwbHlpbmcgdG8gdGhpcyBlbWFpbC4N
Cj4NCj4NCj4gT24gMTEvMDEvMjAyNCAxNzo1OSwgUE9QRVNDVSBDYXRhbGluIHdyb3RlOg0KPj4g
T24gMTEuMDEuMjQgMTc6NTIsIFJ1c3NlbGwgS2luZyAoT3JhY2xlKSB3cm90ZToNCj4+PiBUaGlz
IGVtYWlsIGlzIG5vdCBmcm9tIEhleGFnb27igJlzIE9mZmljZSAzNjUgaW5zdGFuY2UuIFBsZWFz
ZSBiZSBjYXJlZnVsIHdoaWxlIGNsaWNraW5nIGxpbmtzLCBvcGVuaW5nIGF0dGFjaG1lbnRzLCBv
ciByZXBseWluZyB0byB0aGlzIGVtYWlsLg0KPj4+DQo+Pj4NCj4+PiBPbiBUaHUsIEphbiAxMSwg
MjAyNCBhdCAwNDo0NToyNlBNICswMDAwLCBQT1BFU0NVIENhdGFsaW4gd3JvdGU6DQo+Pj4+IE9u
IDExLjAxLjI0IDE3OjM1LCBBbmRyZXcgTHVubiB3cm90ZToNCj4+Pj4+IFtZb3UgZG9uJ3Qgb2Z0
ZW4gZ2V0IGVtYWlsIGZyb20gYW5kcmV3QGx1bm4uY2guIExlYXJuIHdoeSB0aGlzIGlzIGltcG9y
dGFudCBhdCBodHRwczovL2FrYS5tcy9MZWFybkFib3V0U2VuZGVySWRlbnRpZmljYXRpb24gXQ0K
Pj4+Pj4NCj4+Pj4+IFRoaXMgZW1haWwgaXMgbm90IGZyb20gSGV4YWdvbuKAmXMgT2ZmaWNlIDM2
NSBpbnN0YW5jZS4gUGxlYXNlIGJlIGNhcmVmdWwgd2hpbGUgY2xpY2tpbmcgbGlua3MsIG9wZW5p
bmcgYXR0YWNobWVudHMsIG9yIHJlcGx5aW5nIHRvIHRoaXMgZW1haWwuDQo+Pj4+Pg0KPj4+Pj4N
Cj4+Pj4+IE9uIFRodSwgSmFuIDExLCAyMDI0IGF0IDA1OjE5OjI1UE0gKzAxMDAsIENhdGFsaW4g
UG9wZXNjdSB3cm90ZToNCj4+Pj4+PiBBZGQgcHJvcGVydHkgdGksY2ZnLWRhYy1taW51cyB0byBh
bGxvdyBmb3Igdm9sdGFnZSB0dW5pbmcNCj4+Pj4+PiBvZiBsb2dpY2FsIGxldmVsIC0xIG9mIHRo
ZSBNTFQtMyBlbmNvZGVkIGRhdGEuDQo+Pj4+Pj4NCj4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBDYXRh
bGluIFBvcGVzY3UgPGNhdGFsaW4ucG9wZXNjdUBsZWljYS1nZW9zeXN0ZW1zLmNvbT4NCj4+Pj4+
PiAtLS0NCj4+Pj4+PiAgICAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC90
aSxkcDgzODIyLnlhbWwgfCA5ICsrKysrKysrKw0KPj4+Pj4+ICAgICAxIGZpbGUgY2hhbmdlZCwg
OSBpbnNlcnRpb25zKCspDQo+Pj4+Pj4NCj4+Pj4+PiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC90aSxkcDgzODIyLnlhbWwgYi9Eb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvbmV0L3RpLGRwODM4MjIueWFtbA0KPj4+Pj4+IGluZGV4IGRi
NzQ0NzQyMDdlZC4uMmYwMTAzMzNiZTQ5IDEwMDY0NA0KPj4+Pj4+IC0tLSBhL0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9uZXQvdGksZHA4MzgyMi55YW1sDQo+Pj4+Pj4gKysrIGIv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC90aSxkcDgzODIyLnlhbWwNCj4+
Pj4+PiBAQCAtNjIsNiArNjIsMTUgQEAgcHJvcGVydGllczoNCj4+Pj4+PiAgICAgICAgICAgIGZv
ciB0aGUgUEhZLiAgVGhlIGludGVybmFsIGRlbGF5IGZvciB0aGUgUEhZIGlzIGZpeGVkIHRvIDMu
NW5zIHJlbGF0aXZlDQo+Pj4+Pj4gICAgICAgICAgICB0byB0cmFuc21pdCBkYXRhLg0KPj4+Pj4+
DQo+Pj4+Pj4gKyAgdGksY2ZnLWRhYy1taW51czoNCj4+Pj4+PiArICAgIGRlc2NyaXB0aW9uOiB8
DQo+Pj4+Pj4gKyAgICAgICBEUDgzODI2IFBIWSBvbmx5Lg0KPj4+Pj4+ICsgICAgICAgU2V0cyB0
aGUgdm9sdGFnZSByYXRpbyBvZiB0aGUgbG9naWNhbCBsZXZlbCAtMSBmb3IgdGhlIE1MVC0zIGVu
Y29kZWQgZGF0YS4NCj4+Pj4+PiArICAgICAgIDAgPSA1MCUsIDEgPSA1Ni4yNSUsIDIgPSA2Mi41
MCUsIDMgPSA2OC43NSUsIDQgPSA3NSUsIDUgPSA4MS4yNSUsIDYgPSA4Ny41MCUsDQo+Pj4+Pj4g
KyAgICAgICA3ID0gOTMuNzUlLCA4ID0gMTAwJSwgOSA9IDEwNi4yNSUsIDEwID0gMTEyLjUwJSwg
MTEgPSAxMTguNzUlLCAxMiA9IDEyNSUsDQo+Pj4+Pj4gKyAgICAgICAxMyA9IDEzMS4yNSUsIDE0
ID0gMTM3LjUwJSwgMTUgPSAxNDMuNzUlLCAxNiA9IDE1MCUuDQo+Pj4+Pj4gKyAgICBlbnVtOiBb
MCwgMSwgMiwgMywgNCwgNSwgNiwgNywgOCwgOSwgMTAsIDExLCAxMiwgMTMsIDE0LCAxNSwgMTZd
DQo+Pj4+PiBXZSB0cnkgdG8gYXZvaWQgcmVnaXN0ZXIgdmFsdWVzIGluIERULiBXZSB1c2UgcmVh
bCB1bml0cy4gVGhpcyBpcyBhDQo+Pj4+PiB2b2x0YWdlIHlvdSBhcmUgY29uZmlndXJpbmcsIHNv
IGNhbiB5b3UgY2hhbmdlIHRoZSB1bml0IHRvIG1pbGxpdm9sdHM/DQo+Pj4+PiBIYXZlIHRoZSBk
cml2ZXIgZG8gdGhlIGNvbnZlcnNpb24gb2Ygdm9sdHMgdG8gcmVnaXN0ZXIgdmFsdWUuDQo+Pj4+
Pg0KPj4+Pj4gSXMgaXQgcG9zc2libGUgdG8gY29uZmlndXJlIGFueSBvZiB0aGUgb3RoZXIgbG9n
aWNhbCBsZXZlbHM/DQo+Pj4+IEhpIEFuZHJldywNCj4+Pj4gVGhlc2UgYXJlIG5vdCByYXcgcmVn
aXN0ZXIgdmFsdWVzIGFuZCB0aGVzZSBhcmUgbm90IHZvbHRhZ2UgdmFsdWVzIGJ1dA0KPj4+PiB2
b2x0YWdlIHJhdGlvcy4gSSdtIG1hcHBpbmcgdGhlIHZvbHRhZ2UgcmF0aW9zIHRvIGVudW0gdmFs
dWVzIFswLTE2XQ0KPj4+PiB3aGljaCBhcmUgY29udmVydGVkIHRvIHJlZ2lzdGVyIHJhdyB2YWx1
ZXMgYnkgdGhlIGRyaXZlci4gSSBkb24ndCBzZWUgYQ0KPj4+PiBiZXR0ZXIgd2F5IHRvIGRvIHRo
aXMuDQo+Pj4gICAgICAgICAgIGVudW06IFsgNTAwMCwgNTYyNSwgNjI1MCwgNjg3NSwgNzUwMCwg
ODEyNSwgODc1MCwgOTM3NSwgMTAwMDAsDQo+Pj4gICAgICAgICAgICAgICAgICAgMTA2MjUsIDEx
MjUwLCAxMTg3NSwgMTI1MDAgMTMxMjUsIDEzNzUwLCAxNDM3NSwgMTUwMDAgXQ0KPj4+DQo+Pj4g
Pw0KPj4gSSdtIG9rYXkgd2l0aCB0aGF0IGFwcHJvYWNoIGlmIHRoZXJlJ3Mgbm8gYmV0dGVyIG9u
ZS4gSSB3b3VsZCBuZWVkIHRvDQo+PiByZW1vdmUgdGhlIHJlZ2lzdGVyIHJhdyB2YWx1ZXMgdGFi
bGVzIGZyb20gdGhlIGRyaXZlciBhbmQgdXNlIGEgc3dpdGNoDQo+PiBzdGF0ZW1lbnQgdG8gbWFw
IHRob3NlIHZhbHVlcyB0byByYXcgdmFsdWVzLg0KPiBZb3UgY2FuIGFsc28gdXNlIC1icCBvciAt
cGVyY2VudDoNCj4gaHR0cHM6Ly9naXRodWIuY29tL2RldmljZXRyZWUtb3JnL2R0LXNjaGVtYS9i
bG9iL21haW4vZHRzY2hlbWEvc2NoZW1hcy9wcm9wZXJ0eS11bml0cy55YW1sDQoNCiAgIHRpLGNm
Zy1kYWMtbWludXMtcGVyY2VudDoNCiAgICAgZGVzY3JpcHRpb246IHwNCiAgICAgICAgRFA4Mzgy
NiBQSFkgb25seS4NCiAgICAgICAgU2V0cyB0aGUgdm9sdGFnZSByYXRpbyBvZiB0aGUgbG9naWNh
bCBsZXZlbCAtMSByZWxhdGl2ZSB0byB0aGUNCm5vbWluYWwgbGV2ZWwgZm9yIHRoZSBNTFQtMyBl
bmNvZGVkIFRYIGRhdGEuDQogICAgIGVudW06IFs1MCwgNTYsIDYyLCA2OCwgNzUsIDgxLCA4Nywg
OTMsIDEwMCwgMTA2LCAxMTIsIDExOCwgMTI1LA0KMTMxLCAxMzcsIDE0MywgMTUwXQ0KICAgICBk
ZWZhdWx0OiAxMDANCg0KDQp3b3VsZCB0aGlzIGJlIGFjY2VwdGFibGUgPz8NCg0KPiBCZXN0IHJl
Z2FyZHMsDQo+IEtyenlzenRvZg0KPg0KDQo=

