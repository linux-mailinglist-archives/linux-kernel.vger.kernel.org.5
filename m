Return-Path: <linux-kernel+bounces-99892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ABD3878EDB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 07:36:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE3E52818B1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 06:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2511F44393;
	Tue, 12 Mar 2024 06:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="BvGihSw4"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2051.outbound.protection.outlook.com [40.107.6.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF031C3D;
	Tue, 12 Mar 2024 06:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710225395; cv=fail; b=OkBEZ5fm95cYsyLv7poYphG0axxMi9xvdO11bq43rJVBrDGczzEz572MJSUgX5NIMS3GB2YCK6jdiRNb0GJPIo2Us1+gwKZzNhV7b+AhhZtRYR4Fiq/d4aRgmKhxLcUqYeGyoleTnzNRS7mKunjSinYtsksolEnlVETaNbh3PR4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710225395; c=relaxed/simple;
	bh=2wYQWrO0or8Z+cPXcQ41wHo0lRsZwpqqr1MK/1UVuw4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=POVFSSoUFm6uX+QBdTgEQ4a0cxf8Vm3Mx78uZK/J3MrfhMXBOIZGhghmKjpw8+GTF0t9vFpLWXnZJLqxHHzTpl0KXkAC7rBLVgDeDiUNVplpsPm64KTwSqUrOV8D+U1Sgd/OOaTuNVmNaviF/UkwcmqYXO0N3r4Obz3J5iJsDlg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=BvGihSw4; arc=fail smtp.client-ip=40.107.6.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cARYEVKDZ/Xi0U0Zm8x2F8VObzK2pBaIFvGreNrzrL6zHiv5I2WJ1zw/wEa7U1h47Ktm5GLvEL0zM6uO4Q7bYnUO8svN7w61PkuZuwoCItuw5G4VfWRNcLEzAlqg6otYM6rgqNj7Cb+txDgVRWSYwpNx7wvqMUzCMhZMGRJJhH6H91KeUZZa3AXu2XcFTeCQaB+rqqxsci1/sbeZhF4nrXiTOI5H2hrsknmKM63Ps1XgBdPviNVT3bSFah8BQciYXO/7Vq3Fv9c6ZyuJByG4UU/5OCzBus0tDyIMZUFo9EF8DPt+v+keyRpjPartXRi6Z8wiqh21YDHNWbPjXLdHRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2wYQWrO0or8Z+cPXcQ41wHo0lRsZwpqqr1MK/1UVuw4=;
 b=M6aIbxGuw7I1e7WhlDBCfi6ZvuydEe+Akg3MOs74HLDsS2CyRe0ZXHu1+dOtDyVss2TPHRG6y4BY1knjFd4uJo4cTnbaPDJNHlOQwfR7wBH6YSK1jIy+cLvMg+68+OSTcNDOWPgb0AXwRaecrdnGDrm2tUonCr5OZVTweA764xPVeGoy4atQ1vqDtmHvIfsQQUJdYDUpZKYUCyr+7NuvUwjBIwacFD4jKmVZdWKCX8AoQ7MuPlKRTDgBltzMnZ22r085T6PiGy7vbvXy0oBva19KCfYgzMAlKaaoOzk92ABOWHqxDU1rUadr7taDaVhULD6uhobtG3mCpc/oiIoQIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2wYQWrO0or8Z+cPXcQ41wHo0lRsZwpqqr1MK/1UVuw4=;
 b=BvGihSw4zKyWMzmbL5sjARNQautiFuDsPVHiFcTyxCuHOyd545l+Rl80ORz5gu8qWeVl6imTCNARbDTNW4Or2CwpBlxTpnxZZ1CJn67QDv3quWFCP7ShlLIv47Cpol+9KsFIJh+ob7ZLaUWr3MvysDCIYpxvb+RXjr4YsmAW/KE=
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by DU2PR04MB8934.eurprd04.prod.outlook.com (2603:10a6:10:2e1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Tue, 12 Mar
 2024 06:36:30 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0%7]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 06:36:30 +0000
From: Xu Yang <xu.yang_2@nxp.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>
CC: "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>,
	dl-linux-imx <linux-imx@nxp.com>, "peter.chen@kernel.org"
	<peter.chen@kernel.org>, Jun Li <jun.li@nxp.com>, "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH v7 06/11] dt-bindings: usb: ci-hdrc-usb2-imx:
 add compatible and clock-names restriction for imx93
Thread-Topic: [EXT] Re: [PATCH v7 06/11] dt-bindings: usb: ci-hdrc-usb2-imx:
 add compatible and clock-names restriction for imx93
Thread-Index: AQHaajmImwEvcpnfqkKL5HVLVABoP7Ehb3SAgBJK+1A=
Date: Tue, 12 Mar 2024 06:36:30 +0000
Message-ID:
 <DU2PR04MB8822BEF2D12EB9DB9E862B8B8C2B2@DU2PR04MB8822.eurprd04.prod.outlook.com>
References: <20240228113004.918205-1-xu.yang_2@nxp.com>
 <20240228113004.918205-6-xu.yang_2@nxp.com>
 <4a34f281-156f-4631-ad1b-40140180f76b@linaro.org>
In-Reply-To: <4a34f281-156f-4631-ad1b-40140180f76b@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8822:EE_|DU2PR04MB8934:EE_
x-ms-office365-filtering-correlation-id: a0a182a8-4768-4f6d-b7c5-08dc425ec061
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 iZUW0hnE6pRVoYzZ4U5Pk1AvxeBPE0RbnCt+8ynccMP+jy5LQNXag/lzmi4cziqAACyKwdI0tUMYA9wdjXnnoO6YmNay2djvpoB2Ffau0ByXZxIICwjWMFBSmVdmKWmAIR08urX6jwpdhFI5NiCFUpJEUen6w37JL7f1tYAWBTc1BKXQEyOwTyZ76sQAbE/JQUWpCJiolRENfpke4lj32or5XS0bcJLREvSkU4J81I57GIeRdRtre+vwcD20L3fc42lUURU8OtuUesBtyrSgwx/xtU0UJ7pr5ANz6E7KsAQG6GdpGYAM5EkLXsXYT1v3K9EU51wciDvu0AyiHqTsQOxl6ETYzgRjBh5ugqZqajhhxHrvq8tJgmRobc0gwwQSga8TDktbDV7COkvM+KVSj9GuQ7QzmktfB1mejeC1HTzyHSRvzpp4YBHSCHWW00+KOZRh4Bk6AmzcoECLBl/Anuy/tjQCwvffllbemFN9QmcXx5ZEYm/DQk6SaQq2dXTJlilYAVfxHxiSM97HhsgzHqct2Ivpw1aXtNXATkX9S9av3yCNwow4MstT+L2WkU1NYbraG6BMSnp0dyfBLbVbxEU5aUpfBmINzaGpXP3GUK/hIZvn4eZWgEGwD0dl6OKW7FYSKeRkbXP88YeIlRxVqAsJ9RmJ5/I9ASdGbrGmc5itnHA7PoTrAo59Di+xRcH2FxsWEVI5ZiXDWDJoSL1d3qp2M1f0PFOl6jCBfHX67oU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eGIxUHlMUXI5ZTJJNUFsMWJkVmQ0cnhqZ3ZiNkxEa0h6MkR2d3RPZUVLV3JY?=
 =?utf-8?B?bFNaUVdmemt1WDFWbnRjZ0VLUUkvaFFveUp5Uy9zclBZdUdaZnpQZ3BtZjky?=
 =?utf-8?B?SlEva2JtRGRSVmpqNzJHZmtuOFBmZkJXZFpCR1dNZ25Zcm1odFlaVzAzcGFa?=
 =?utf-8?B?VW8yeDN3VklIL1BidnpWWCtQWk9RS1BlbnJydXd2ejBaeDF0Q1poSG9qRWlU?=
 =?utf-8?B?YVRmVTBGZVJ5cFNUMUJzUDRBNDcydkpac3pxRHpLQ2p4WWVoZ05FSEJ0dmtD?=
 =?utf-8?B?WDd3RzhmS3phck5nMSsvbTZ5TlpEMnU1Zm5Sa3o1eUFkSWlad0VrV0pvSTM3?=
 =?utf-8?B?anY1UGg2MHUvRkZBUkFKQVJQdDgwR3B5VitjbXVsOEluRmlMRGxnMDdSWnNI?=
 =?utf-8?B?bm5Dd0Q1VjBmZWxiWlBuc09ySm9LdGVFKytWcG1yWm4xSC8vU0pUcFc2SkF4?=
 =?utf-8?B?K3AxRWtnNWRVRzY0cUQ5WUtReE5HMC9rdDBpL1I1MHdEQ3JPemVjL3U1TEwz?=
 =?utf-8?B?M2FNSFZqaHVUdkdJSXAyeitENzRSckNpTnRZUnRJS0hHUG5uY2FSeE56RVBM?=
 =?utf-8?B?MHdqY0ZkRm03cG5lM1gxVXZSQzlZTFR2cnRCWGkvS0ZJVzQxSGlOQlV6cEJE?=
 =?utf-8?B?aEtZQ2VnMS91dlZJTVQvRWhVcURIWGZ0RUhPc2J5Tlo5NGt4ZW8xV29mNmd0?=
 =?utf-8?B?RjAxZkc5bk9leG9Vc2M5dUErekpkMVhtWGNUNk5oUlFHOThqa0RJb0JkNEVM?=
 =?utf-8?B?U3JpRVZTemI2ZE9hVjNLS2dITnQyeHJ4R2tNdDlWWE51UlNIZmUwYmZheUhX?=
 =?utf-8?B?dFhkVHJmaUJiZFMwQUlPOEJ5OCt5bkNRdmpLTXZYUmE2SG01cjM0cDN3SnE3?=
 =?utf-8?B?WEJ0VVZldzY4QUdxMTh6OXRNblZGWGEzcjhXeEpzVGszT01TUzV0TlJyV1RV?=
 =?utf-8?B?RUhUQmJ2US9hRC9lZmo2QlBGUWc3VG9WWjVydmg3UkZqT3NFNEwvejBIY3Rs?=
 =?utf-8?B?ZzZHeCtaNG5Jc0trMkxFVUd2bXpESllma3NFazJERGdscndOc0R2a0ZwWDRl?=
 =?utf-8?B?ZlIvSDA3TUx2WGVWK2JWNVhVR2tlY3d1cWVPbm11cEdETjRxZUlzVGg3c3Aw?=
 =?utf-8?B?QWI0UTZZSnQwT0RnMDlVKy8vUWZ5ckt3enJ2MWJIT2VSamJhNGhEaWZRajVS?=
 =?utf-8?B?eEhwKytqeTRQZHJwMFlsQm1YbTE1T2ljRXMzY281dFgram1WTVRrOFRmNHJu?=
 =?utf-8?B?SWpUYTRGdUFwK29HZmJna2VJOVI3ODRWdGxPTmlNTG1wL05OdWFZZXpoNzlo?=
 =?utf-8?B?WXBZanNKVm1OVWU0bW40TnZiblhpUEIraGNRR1FrMUU2cEtaMitReERTa1ZC?=
 =?utf-8?B?MkhydDc0S0FaMURjUHpLVmxKR1ViOEJObmdhZ01mNFBkcWd2WTc2S1NSQVpJ?=
 =?utf-8?B?dEhuUy9BZUxKR3liQjVNQjQ5WHhRdWYvWnVzNWJ3d2NuTytERDZpWmpkZWZt?=
 =?utf-8?B?ZllaSHlSZDRvZ294SWZ3ZzBRZDltcWowUkFTWmRuWnRSVlM4THVYR2czbWJM?=
 =?utf-8?B?MU9Edk8wd3FJa3QxR1piYXBtZVcwNFVpekhnQkVFbHd6bzlxaWRiMTJyTk8y?=
 =?utf-8?B?ZDVNZ2Z6dkNZLzg5Yk9HZWQ2d215STdvWDNOcWtTRDZoYXk4SzJqcEVoYlBQ?=
 =?utf-8?B?R0RHY3I3aHk2cVg5Z1lVM09wTGpQVTdOOFZtS1lNWGVSVWF0aytLVkpGbGtu?=
 =?utf-8?B?aStibGZiL0tvaWdqTjBZdEVLUUNaeG9yVG4rWm1uTkdRSnZzL0s4Vkl6Z1NS?=
 =?utf-8?B?c3ZlK3phN0VPT2NUTTFCMjJNQTVFYllqQUhrTGt3cjNKSTdZV0RZaHhZYWYr?=
 =?utf-8?B?a0RDSVNscUdaZGZlNnY2dDhWYmx1MlVBcFVyOTY5V3V6dXMxemt4V0pHWXZr?=
 =?utf-8?B?RU5mdEhKS3lqSlJpSUd0d20ycmxyNXh5aFJoYXNYd0dqOXhCcE1HeUd1NWVE?=
 =?utf-8?B?a24zME1JbENnTmQzSkZkZ0lRbXlMbTZ5VFBaZlRiVExnVkFYd29oTEdWbjds?=
 =?utf-8?B?bXZ2Z0ZqcW1WT09aVzhPUGMrbjJRaTdHZThLSkpiaFZsRGZHY0Nkck1FRGts?=
 =?utf-8?Q?jnQs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0a182a8-4768-4f6d-b7c5-08dc425ec061
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2024 06:36:30.1233
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cjN9UHtx1a5HzyVWr3bnvOECyOvFgVAdmMgYhN1dYWbdJ1iDeLC1rtblxf2mSVWnOBCbHW2qrgLqvFMR9NR5/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8934

DQo+IA0KPiBPbiAyOC8wMi8yMDI0IDEyOjI5LCBYdSBZYW5nIHdyb3RlOg0KPiA+IFRoZSBpLk1Y
OTMgbmVlZHMgYSB3YWt1cCBjbG9jayB0byB3b3JrIHByb3Blcmx5LiBUaGlzIHdpbGwgYWRkIGNv
bXBhdGlibGUNCj4gPiBhbmQgcmVzdHJpY3Rpb24gZm9yIGkuTVg5MyBwbGF0Zm9ybS4NCj4gPg0K
PiA+IFNpZ25lZC1vZmYtYnk6IFh1IFlhbmcgPHh1LnlhbmdfMkBueHAuY29tPg0KPiA+DQo+ID4g
LS0tDQo+ID4gQ2hhbmdlcyBpbiB2MjoNCj4gPiAgLSBubyBjaGFuZ2VzDQo+ID4gQ2hhbmdlcyBp
biB2MzoNCj4gPiAgLSBhZGQgY2xvY2tzIHJlc3RyaWN0aW9uDQo+ID4gQ2hhbmdlcyBpbiB2NDoN
Cj4gPiAgLSB1c2UgJ2NvbnRhaW5zJyByYXRoZXIgJ2l0ZW1zJw0KPiA+IENoYW5nZXMgaW4gdjU6
DQo+ID4gIC0gcmVuYW1lIGNsb2NrIG5hbWUNCj4gPiBDaGFuZ2VzIGluIHY2Og0KPiA+ICAtIG5l
dyBwYXRjaCBiYXNlZCBvbiBjaS1oZHJjLXVzYjItaW14LnlhbWwNCj4gPiBDaGFuZ2VzIGluIHY3
Og0KPiA+ICAtIG5vIGNoYW5nZXMNCj4gPiAtLS0NCj4gPiAgLi4uL2JpbmRpbmdzL3VzYi9jaS1o
ZHJjLXVzYjItaW14LnlhbWwgICAgICAgIHwgMzQgKysrKysrKysrKysrKystLS0tLQ0KPiA+ICAx
IGZpbGUgY2hhbmdlZCwgMjYgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkNCj4gPg0KPiA+
IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdXNiL2NpLWhk
cmMtdXNiMi1pbXgueWFtbA0KPiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy91
c2IvY2ktaGRyYy11c2IyLWlteC55YW1sDQo+ID4gaW5kZXggYTQ3MzBhMjM5M2U2Li5hMjkzMmFm
MmMwOWIgMTAwNjQ0DQo+ID4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L3VzYi9jaS1oZHJjLXVzYjItaW14LnlhbWwNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvdXNiL2NpLWhkcmMtdXNiMi1pbXgueWFtbA0KPiA+IEBAIC00MCw2ICs0
MCw3IEBAIHByb3BlcnRpZXM6DQo+ID4gICAgICAgICAgICAtIGVudW06DQo+ID4gICAgICAgICAg
ICAgICAgLSBmc2wsaW14OG1tLXVzYg0KPiA+ICAgICAgICAgICAgICAgIC0gZnNsLGlteDhtbi11
c2INCj4gPiArICAgICAgICAgICAgICAtIGZzbCxpbXg5My11c2INCj4gPiAgICAgICAgICAgIC0g
Y29uc3Q6IGZzbCxpbXg3ZC11c2INCj4gPiAgICAgICAgICAgIC0gY29uc3Q6IGZzbCxpbXgyNy11
c2INCj4gPiAgICAgICAgLSBpdGVtczoNCj4gPiBAQCAtMTg2LDE0ICsxODcsMzEgQEAgYWxsT2Y6
DQo+ID4gICAgICAgICAgICAgICAgLSBjb25zdDogYWhiDQo+ID4gICAgICAgICAgICAgICAgLSBj
b25zdDogcGVyDQo+ID4gICAgICAgIGVsc2U6DQo+ID4gLSAgICAgICAgIyBvdGhlciBpbXggU29j
cyBvbmx5IG5lZWQgb25lIGNsb2NrDQo+ID4gLSAgICAgICAgcHJvcGVydGllczoNCj4gPiAtICAg
ICAgICAgIGNsb2NrczoNCj4gPiAtICAgICAgICAgICAgbWluSXRlbXM6IDENCj4gPiAtICAgICAg
ICAgICAgbWF4SXRlbXM6IDENCj4gPiAtICAgICAgICAgIGNsb2NrLW5hbWVzOg0KPiA+IC0gICAg
ICAgICAgICBtaW5JdGVtczogMQ0KPiA+IC0gICAgICAgICAgICBtYXhJdGVtczogMQ0KPiANCj4g
SnVzdCBtYWtlIHRoZSBsaXN0IGV4cGxpY2l0IGluIHRoZSBmaXJzdCBwbGFjZS4gRG9uJ3QgYWRk
IGxpbmVzIGluIG9uZQ0KPiBwYXRjaCB3aGljaCBpcyBpbW1lZGlhdGVseSBmaXhlZC9kcm9wcGVk
L3JlcGxhY2VkLg0KDQpPa2F5Lg0KDQo+IA0KPiA+ICsgICAgICAgICMgaW14OTMgU29jIG5lZWRz
IHR3byBjbG9ja3MNCj4gPiArICAgICAgICBpZjoNCj4gDQo+IE5vLCBuby4gTm8gaWY6ZWxzZTpp
ZjplbHNlOmlmOmVsc2UuIFVucmVhZGFibGUgYW5kIHVubWFpbnRhaW5hYmxlLg0KDQpPa2F5LiAg
SSdsbCByZXdyaXRlIGl0Lg0KDQpUaGFua3MsDQpYdSBZYW5nDQoNCj4gDQo+IA0KPiBCZXN0IHJl
Z2FyZHMsDQo+IEtyenlzenRvZg0KDQo=

