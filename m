Return-Path: <linux-kernel+bounces-25499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A950882D12A
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 16:25:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11D9D1F21744
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 15:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B602582;
	Sun, 14 Jan 2024 15:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="UCILTuOU"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2040.outbound.protection.outlook.com [40.107.20.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD0E7E;
	Sun, 14 Jan 2024 15:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U9ERb5Tkn3pgKjRHKhqlxOvb0L+4KqAcJvSffxnV2+SXD8JTd8ooYPu+LeKWOHFvZDXguzckW/g/oh39aAHFidAAYJsypa3sHlXsg5WrGLw1uZYuLTdDQSedw1du9ga8YRH//IGmA+tc/167lk37X/9+xS8/TOj+ZX/iyKul6z/8shBSp6VYnE5mfvHBoR8JOfmUBuLpb2mRutV0De+UeTckycFztgEU/h8HZ8aTE6sswuPMh7JeK2UDv99atNRd1cny3k5RuJ6jhTZaaQ8zZFXvONLL8C62rSpm7u4be+k4mZ5CnNv6qMV5gUR9zUM5vU7cg9Rt6scZ82xHWw8/8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vzy5D7HrAjykWw9Oml7PuUd6sm2oMjiaBCRit2uMaeE=;
 b=gYyNarPJmXcd7TbbQVOsBA2JSsQ9EXRszp1WDJXRJw9bIaHrxOxSRSw59VAybYWrCLgpW+xg9nik8B2GSud+awCEfmCQl6Lvo1m+wwMEf0y9qQCutnT2g4ddCoRxZHqOmy4Pv1HwqoN8ecYA+UKQorpOI8JylkgrNGquviYOaWzdUiwzbJNX0LnLHZbj4Wltpu1WpDQcheO9fo0j12CZIP5y6vPf7Ba9dPQkf/mdTBb/evap5wY+bnoLkaKSs9Tx+OWuwSeyKNt0/TS6tPPx44QF2Cf2LP84chRXJ+HpfkzJoFliTSVFgQQ8/PmTZ9un/HodIwL4+LsxDc/8RhcvDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vzy5D7HrAjykWw9Oml7PuUd6sm2oMjiaBCRit2uMaeE=;
 b=UCILTuOUoTPwZ+XSn2uKuOwfzRCkknzNIpmjqDO0jtm+V4XkWtYBug8TORn+xzPKMfw0EcfeRsWuVHM6Dkk64Dvu9ouv4X0ypAaCV50mV+CzSQlYRG6E+opD9Px3ny6OJznw5iRORcUY7DLkJValLof2OBZjDWDsDmvZEiJVnlU=
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com (2603:10a6:20b:42e::18)
 by AM9PR04MB8275.eurprd04.prod.outlook.com (2603:10a6:20b:3ec::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.24; Sun, 14 Jan
 2024 15:25:14 +0000
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::daf2:8c54:d469:793d]) by AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::daf2:8c54:d469:793d%7]) with mapi id 15.20.7181.020; Sun, 14 Jan 2024
 15:25:13 +0000
From: Josua Mayer <josua@solid-run.com>
To: Andrew Davis <afd@ti.com>, Nishanth Menon <nm@ti.com>, Vignesh Raghavendra
	<vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>, Rob Herring
	<robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>
CC: Yazan Shhady <yazan.shhady@solid-run.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-rtc@vger.kernel.org"
	<linux-rtc@vger.kernel.org>
Subject: Re: [PATCH v2 5/5] arm64: dts: ti: hummingboard-t: add descriptions
 for m.2 pci-e and usb-3
Thread-Topic: [PATCH v2 5/5] arm64: dts: ti: hummingboard-t: add descriptions
 for m.2 pci-e and usb-3
Thread-Index: AQHaRXqNuxiGMT8hwU+/Nqu/DoZlNbDWdwIAgAL5xYA=
Date: Sun, 14 Jan 2024 15:25:13 +0000
Message-ID: <3f86b313-f8b7-45fb-a318-e1a633bdba1b@solid-run.com>
References: <20240112-add-am64-som-v2-0-1385246c428c@solid-run.com>
 <20240112-add-am64-som-v2-5-1385246c428c@solid-run.com>
 <c1ea65a6-4aad-4ca1-88cf-ac3fa130b0e4@ti.com>
In-Reply-To: <c1ea65a6-4aad-4ca1-88cf-ac3fa130b0e4@ti.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8963:EE_|AM9PR04MB8275:EE_
x-ms-office365-filtering-correlation-id: 8dfd2006-3b02-4207-7611-08dc1515013e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 rsl9BNrQKjVgrTkQsQfK3bfIFU8lkAQITJlYaomTSGxwoCIsz6UAmpjOr7st8XqDOvc8i9HxVRo+dXe5Rs1Maioq0wXWZUg80WAKNiu1agLR02aDoLWcXuucJFv8mhgZWIbVu0q+T/PIU6irXTsQoSzrR507Pc3IrFi49QIQxlggxkS+9Mn9X/bdgebgfKlxI3OxIIZsxqYhuwc6HS/mEU/B9KbqOULnmCIj6Lz7vcSYWil6GKAvTptdFsw9n4MvsC6LIUgH5yj/+4dk5hDy2YRZz6P3whgrAp774mQVL5Id82c4U0kNHcD9wfIaOxSJ7LVg5r2DQN79hS+cFc9n8+nfsC/SCBPL+CZxGjBRpZZxGyuPxNHKH+M0/5UqdrW247Sk7nwmN6287EBZPOz4WNRrYRSu9lkV+a42JVZQC7l0rCATULlZSrQr/eGQl8BbIQTcgZFEkO/OuuPKMJo2BjfRq7SbzYHRASvl1kXvaz6VKZim0fpg1sDF1MDQcurB9O0SkwZvLmXyii2JdO3yP8Cq3iTZ4LMXXKHMzi2Pm1VuNRiMCoGs2NnMYIIAEtsNYG1cmv39C1heXVC2ci4SPZi7SZFXIswLJNve+PTEdw9Y3SRV4ClzzKPEmb+xnc4tcsKyk3I2xxyN5SigPhbrgg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8963.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39840400004)(136003)(396003)(366004)(376002)(346002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(71200400001)(2616005)(26005)(478600001)(53546011)(6512007)(6506007)(2906002)(7416002)(4326008)(5660300002)(41300700001)(91956017)(110136005)(54906003)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(6486002)(8676002)(8936002)(316002)(38070700009)(38100700002)(122000001)(36756003)(31696002)(86362001)(31686004)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WVltY3RtM0JEVkdEaWxaL3lISDdTdHFWOWFLclo4KzR6NFUzUXR4aUJaaVVZ?=
 =?utf-8?B?LzFnNStwaTE3T2hhRkIwd25HdWpLRlBkS3FIRyszd1JUdXVEblZYZ3duYlhF?=
 =?utf-8?B?NTMxTkl3czYzcjFCK3ZTWmk1TnBhQ1VLSWJrK1lnb2dCSTZDMm92SmE4Rm1F?=
 =?utf-8?B?bXZaMEpEdnAxMDFmaFdlSWRyMGkwK1h0RVFXZVBrb2ZQaTZOOElXSEg5OE43?=
 =?utf-8?B?YXRMVElBanVmQkx6MEQvQk5LY2RhdmlLSDlaN0tWOFVnL25RdU1Hc2ZpTjhG?=
 =?utf-8?B?WmdpWldtR1ZTWXNsRmQ2UWE4NFZDa1pnM29KWVZBOXIxeTlaUGJUWE5BODF3?=
 =?utf-8?B?NmY3SG1PZTB2YlYrbTdIM01XZjllMGhYeW1SSk1NRmVhcS9QaFBzYTRnbnNM?=
 =?utf-8?B?SjJGc1hzUFhmaGg2clpWZHYxL0QwdTZUb2hMd2c0blE3VWVyekV0R1VqV1Zn?=
 =?utf-8?B?RnNMWGJNaU1SLzVKUzBJbFZMU05aTWtHbmV1dmpJTGdTYlJNWGJPNUFtYWp0?=
 =?utf-8?B?TmVHQllzN3drWTNaREFSOUN0NTR4L24yTFlrSnkwRTU4NnVVNTFtTHdHTS9h?=
 =?utf-8?B?VExkaDdMTE5JdEcySXUxeG1KNEMwNS82S3NYQVJLbkZKNTBkZTJOQ05OdEhJ?=
 =?utf-8?B?ZGN2bm1SbTlIV3c5M1pwUlNqaUIzbHVsU1BYM2pJN3Z1NUlVT3pPQ1BOZEYy?=
 =?utf-8?B?RWVUd1M2dXgwSnZGTVVaczFNTjgzTzVMaTV0eTBTUks5T1VORzVkTHBLWnBV?=
 =?utf-8?B?OC90WTAxZ2dHQWRQWTVTa3hGNlFiOUpQczkwNDRjK3VDZXB3WjErdmhxNWxP?=
 =?utf-8?B?emxJeEdWalVkREVRd0pCZk9ETExlWGYveStvckk4VEZ6aHp3TGRtdCtxVWNQ?=
 =?utf-8?B?eXd5SDVROEY0b0M5dVdjK2pmeXRzNjlWbGtpZTFYWG5pU2hQN0JIZnFpZlR3?=
 =?utf-8?B?M0NVMmRzcWllbURqLzNNUzRlNjJ1STZ1ZUlLb0tQWHZJYTlDTjRoMmowNHdY?=
 =?utf-8?B?ZkI5dmNnSVdSaWQ1Rml1R3hyck5LWUhvcm13ZjhURmtlaGs4UjRsL0dSZ2Iz?=
 =?utf-8?B?WVRvWnE5Tkt0NTEyYmVGbW04R2R0WHFNRHpKajZ0cjZxL1JQR0oySzR2Q01m?=
 =?utf-8?B?K1owL1BmRlBiVFg1Y0xGY1loMDJJeFFSR3Nqb1ZuNFdxbCtWL3ZNSjUxaVpa?=
 =?utf-8?B?WGRRc2RlOWl3SmJiUkdtalpoQzNVK3Y0R0IyWG5FRkZsTVZFcVN4ZklpY3Bv?=
 =?utf-8?B?Rkwrdks1RFNFUzliK2NnRXhsbnU3cS85dmc2ZGxZQ1FZYXM2M2xOd1J4ODJH?=
 =?utf-8?B?NXdvYnhBNFNUeWJsWHliNUk1VDB3UU11dnlSNjErWEdva1UweVVoVmtzMW5J?=
 =?utf-8?B?MUwyOE5EcGJrY3ZuVW5ER0Ftc3F6ZlNqeTgyQmNCUFNKRTNJYmc2NmZpa0tO?=
 =?utf-8?B?elRubVdXeTVMMDZBaVJGVzdCRHRZKzdQTTZVSnBRSEF1czYzMjRLbUNKWm50?=
 =?utf-8?B?aDhOQlMyVzI1VVlvbHpaUE9nMUZGcUhtaXByUk9Sa3IxaFdIS3ZmSWhXTCs0?=
 =?utf-8?B?VzNkMERqdmc4bElXWVRzQklvZFBDNnkraFZoSjc5NVBZaXQvOFRHUFE2aXBC?=
 =?utf-8?B?d2tEZGp5S1FPekJ6R3p2c3l2Z3QvZW5hL1RKNUIrU3k2emVud2NEN0dZMC95?=
 =?utf-8?B?cmNhZ0hZbU1wV2xFMjZlbG9mck91aHNmUm9RTDl2aVJXb2ZEOHRZRnNKQjFK?=
 =?utf-8?B?OEVOcityMS9CYXFYaVQ1VmhNL25zQ2NWSjh0b090aitwQmlkVVFpbDRDRnh2?=
 =?utf-8?B?WkoxRHhxWkd2K25adUd1dDhuVENsKytSUEZYa2hDZ1h5NVhVQmMvNnpHL2pl?=
 =?utf-8?B?QVY3Snp5Rk5GL2Z4VjlubjBIc2NRWFk5KzdrdDZjNEtncTkvRWlTNW1BTWxU?=
 =?utf-8?B?NktQTkZTSTdUUjF3VjNkc2pGc3VOQjc2WGZYeUE2anVya0tiQngySWw5UGxS?=
 =?utf-8?B?Sk1hQ0tMMWZoS0I3NkF2dEQrNnFzS0VpNEtaVnZPQTl0VmczdmpzVFd3ZVZY?=
 =?utf-8?B?ek8rRmVVM1crRDZ2N2dydjVrRWVDb1Mwek5pQUVpSGV1aUVjUDhpNHdjQVJJ?=
 =?utf-8?Q?2RDN+GD2hQ2C+AVGpPXEADEmM?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <03A51C77654ACA4EBDFCD1112CA1A040@eurprd04.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dfd2006-3b02-4207-7611-08dc1515013e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2024 15:25:13.8634
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8TBGE4NP0zkcYBWcLTHyzVncuTYdoZpdISSMpdkt7s1m9jtizFc826L3pk1GYUHz5WoS9erOmCZkl0Lrsesklw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8275

QW0gMTIuMDEuMjQgdW0gMTg6NTggc2NocmllYiBBbmRyZXcgRGF2aXM6DQo+IE9uIDEvMTIvMjQg
MTE6MTIgQU0sIEpvc3VhIE1heWVyIHdyb3RlOg0KPj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQv
Ym9vdC9kdHMvdGkvazMtYW02NDItaHVtbWluZ2JvYXJkLXQtcGNpZS5kdHMgYi9hcmNoL2FybTY0
L2Jvb3QvZHRzL3RpL2szLWFtNjQyLWh1bW1pbmdib2FyZC10LXBjaWUuZHRzDQo+PiBuZXcgZmls
ZSBtb2RlIDEwMDY0NA0KPj4gaW5kZXggMDAwMDAwMDAwMDAwLi41YmEwMDI5ZmNmYjkNCj4+IC0t
LSAvZGV2L251bGwNCj4+ICsrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvdGkvazMtYW02NDItaHVt
bWluZ2JvYXJkLXQtcGNpZS5kdHMNCj4+IEBAIC0wLDAgKzEsMzEgQEANCj4+ICsvLyBTUERYLUxp
Y2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMCsNCj4+ICsvKg0KPj4gKyAqIENvcHlyaWdodCAoQykg
MjAyMyBKb3N1YSBNYXllciA8am9zdWFAc29saWQtcnVuLmNvbT4NCj4+ICsgKg0KPj4gKyAqIERU
UyBmb3IgU29saWRSdW4gQU02NDIgSHVtbWluZ0JvYXJkLVQsDQo+PiArICogcnVubmluZyBvbiBD
b3J0ZXggQTUzLCB3aXRoIFBDSS1FLg0KPj4gKyAqDQo+PiArICovDQo+PiArDQo+PiArI2luY2x1
ZGUgImszLWFtNjQyLWh1bW1pbmdib2FyZC10LmR0cyINCj4NCj4gQXZvaWQgaW5jbHVkaW5nIC5k
dHMgZmlsZXMsIGlmIHRoaXMgZmlsZSBpcyBmb3IgYW4gb3B0aW9uIHRoYXQNCj4gY2FuIGJlIGNo
b3NlbiAoUENJZSB2cyBVU0IzKSwgdGhlbiBpdCBzaG91bGQgYmUgYSBEVCBvdmVybGF5Lg0KPg0K
Pj4gKyNpbmNsdWRlICJrMy1zZXJkZXMuaCINCj4+ICsNCj4+ICsvIHsNCj4+ICvCoMKgwqAgbW9k
ZWwgPSAiU29saWRSdW4gQU02NDIgSHVtbWluZ0JvYXJkLVQgd2l0aCBQQ0ktRSI7DQo+PiArfTsN
Cj4+ICsNCj4+ICsmcGNpZTBfcmMgew0KPj4gK8KgwqDCoCBzdGF0dXMgPSAib2theSI7DQo+DQo+
IElmIFBDSWUgaXMgb25seSBhdmFpbGFibGUgaGVyZSB3aGVuIHVzaW5nIHRoaXMgYWRkLW9uIHRo
ZW4NCj4gYWxsIG9mIHRoZSBub2RlIGRhdGEgc2hvdWxkIGJlIGluIHRoaXMgYWRkLW9uIGZpbGUu
DQpUaGF0IGlzIGNvcnJlY3QsIGFkZC1vbiBmaWxlIHNlZW1zIGFwcHJvcHJpYXRlLg0KDQpJdCBp
cyB0aGUgc2FtZSBoYXJkd2FyZSwgbWVyZWx5IGEgZGlmZmVyZW50IGNob2ljZSBmb3Igc2lnbmFs
IHJvdXRpbmcuDQoNClRoYW5rcyEgLSBzaW5jZXJlbHkNCkpvc3VhIE1heWVyDQo=

