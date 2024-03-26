Return-Path: <linux-kernel+bounces-119805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D568A88CD28
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:26:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 052041C669B7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7541C13CF8A;
	Tue, 26 Mar 2024 19:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="WvU0raqR"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2129.outbound.protection.outlook.com [40.107.249.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2992313C3D8;
	Tue, 26 Mar 2024 19:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711481178; cv=fail; b=XRNtc3/JKB355to7dbcishMhShbDgawUUBs7vJg3PeYOQml7qKGvVH3lh0sLOnGlF9hD68Z+g9RqAJV7uALzis/ftfUoQ/Bo+hGd3qNe43XYLXgZ4kwxmfGlNj3Uhxgbc65a3HVaKTkkBbyuPZVAZzCjVo7B8F2p6e/m7PQuDtU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711481178; c=relaxed/simple;
	bh=uNhstf4VvkF6kfC391EZk1x1PJI5HFHV0jTjPX38mwA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Yp+kEQMoJE78U1L0ZGaOSmqpoEaZpbBnfdbauq9m+o6aXuSrNUsQOimrwOsAcslyrf79yP51JjyiXErHEjNxe6YtdbDs9ki0Qj5FyPC7ExWL7DENRQzBQL/PD2yKYKQn2hCYOR89ygLLlvZMIExfR7q74nP0q/JNfBJfIhxopCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=WvU0raqR; arc=fail smtp.client-ip=40.107.249.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H0IbeYGKDeSeXl8CiIAM9U04oBiRAl/VvVteDO8RJqhW9ADuwNKI0SnFAOQT1d4awlRB/+qY8CDZSvZt7T6172R4kOikV+rOBBDKmkNIp/VakK2bmkEmhxKEdEuyc1+1FdYpuXXaTNc3AdHe7liLj8pEQJ/CvKHVWSmWUlUqOyRSSXtQOCAtkSw6Rmsnp3US4lbCML83eX4PwORzN/2n+egiuzbRDjq896b7UipPTc1/faulpRHOiI8imrHulg+4bFB/XHsuka59tChTtDAoFQyV0YD5J9RJGataqUfGm35Oyon/Go6TzqRn2csz1+EskQtwuhIw27gdJiEOykhqJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uNhstf4VvkF6kfC391EZk1x1PJI5HFHV0jTjPX38mwA=;
 b=ZKRa+kdMTqQ5GhDxgnHBNLXcBuGXZuKsIc3wl/LpHdx5PwvjNaSnhyuXaFqSBeo7SSec7/OJxYXx+KQ7MJ+uXNn0jJkqfYb88clsbOPe6ZYnNDiYQkkLpF4gqqfAE7K2ks+CnewPVqIilWEAutXByhvEop+GcQOSO4eSC/3lxRLlr7FBTov+6LikdVr0mIb+Fqaw6jp0Q90UcWlJQOojelqwwT3OQLTZa1kQPLQfQj+onWxE0dgEV7Aj4Pkn5BXKaWQXU9d63TO1wjf+ZPgFpIb7xTCGNaoeJdal+zDOPlg01uxeUqqlmI0awrWC3875ppu9ZVfwUB1NWx/pXUYDWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uNhstf4VvkF6kfC391EZk1x1PJI5HFHV0jTjPX38mwA=;
 b=WvU0raqRFXs+uMjqOTOycY7vj+wq3pceXCB9/Gi552HpaTnO6Zws46ANN2BCWGmqYM/8YSCq///oRIxkHTA9jJowOgTY5Dyenp9LmiYBP4dGheoP5OkTxBiWRYLKXmAor3ze9yORv0kvqXC2WEYpY4aIyxOSNUvY7bms+ksheFY=
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by AS8PR04MB7958.eurprd04.prod.outlook.com (2603:10a6:20b:2a5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Tue, 26 Mar
 2024 19:26:13 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::57e1:e1cb:74e2:2e9d]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::57e1:e1cb:74e2:2e9d%5]) with mapi id 15.20.7409.031; Tue, 26 Mar 2024
 19:26:12 +0000
From: Josua Mayer <josua@solid-run.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Andrew Lunn
	<andrew@lunn.ch>, Gregory Clement <gregory.clement@bootlin.com>, Sebastian
 Hesselbarth <sebastian.hesselbarth@gmail.com>, Rob Herring
	<robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>
CC: Yazan Shhady <yazan.shhady@solid-run.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: arm64: marvell: add solidrun cn9130
 clearfog boards
Thread-Topic: [PATCH 1/2] dt-bindings: arm64: marvell: add solidrun cn9130
 clearfog boards
Thread-Index: AQHae9lZw/gIYk6zDE+73DiBF+lb+bFDiiAAgAVVLYCAAAp+AIAAr8GAgADVrQA=
Date: Tue, 26 Mar 2024 19:26:12 +0000
Message-ID: <6af08a38-5239-4f5f-9e87-108e3400a6e6@solid-run.com>
References: <20240321-cn9130-som-v1-0-711127a409ae@solid-run.com>
 <20240321-cn9130-som-v1-1-711127a409ae@solid-run.com>
 <0f7ca0ed-a1c1-41d2-a1fa-27431d14c056@solid-run.com>
 <e1836cb6-64cd-4866-9c0a-f0dda096aa18@linaro.org>
 <6a6e7c4d-d5fd-42ae-bc3d-a3978d65e8e4@solid-run.com>
 <b086a02c-624f-4225-a9fb-164095742ce9@linaro.org>
In-Reply-To: <b086a02c-624f-4225-a9fb-164095742ce9@linaro.org>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB7586:EE_|AS8PR04MB7958:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 ODrDcfKt1OK2zw/jX0a4o3iNpWvLtoE6dk86gf1yHif0+G9AdmOZrerZnYUxkv5KiBbPk90G8BIQxtGDYPPOuygSWxqZZltEpgpWPIfqwVmYyoF+8KqswsFz4X7cAvcus3W+2URVZje7yC+joeEO+GHuU0YnRXHHUKxzyR8GYU8sSb9sYvDcuOxZjNyS7H3jtrpF9yvS7NnBA5le25YM331witlJ4Z6OGomvbxHRykh4fTx+PyS0PM0goeeQd3kWAtNUnf5TUDn56OKDKH5lTafZn1RfgJ8ou6yi4RKx2CWArffqhxiJrSWjlIfBD+Mwi5TCbYaDh+3Xz9n+6EQ1FTMHY04rLVYj74LmU6D68iMxSbWQWmMlmUGlaGVmkipYIceTnqKaNNUV0ZZqoz5AvG3q34wtqyRfqomVa0JuEwdWFPJMMcUO5rEMG4ISOSOUUP7midkUJD8dPlCwwgljs4PMdok8proZdbYjRn3z3xTYqBhRb0BeRwZBtzOgNJV3IOoGL77oxEBHACED77bfbYKXH65Tc6tUreUIY1jjwtG8/zLL6CV15086Km/Z4H9vxVGwrhQGxuZ+7wiK3yPsNV4BRG18udXzdsgWU21uTt/hA63Xfk5wQbg+KP5Q17DyOM0qDbEuqSWRPIjn5UlqtizebGZ4ee0XrkMVd13jdOA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eUhia3JpS0hSK0NpZkF4eGFpNEpaREIvbm1ReW9JcEFibWNkQ0ZkTldlN2JP?=
 =?utf-8?B?alFQOVN3WVJESm9Gc2ZmM2o3WGhaUDhxbFA4MGNMRXRCYmI4RGRwcWZmdTlU?=
 =?utf-8?B?ME84WVhFTTBjMVZjaDliWkt1U0NUVnRJZERJYWJJRDVreUNnUDNCTi9jRkF4?=
 =?utf-8?B?dXZsL1VrNWZYelIwaEx1STdkNk1qeEV3c0xJU2dUSTVPdVB0d205bXpFWUZ1?=
 =?utf-8?B?WXo0ME5obk9yZWlNZzZMWnlsZVNINk9jMi9Eb3hkU1VyRUpDSnE0aHAxd0Vj?=
 =?utf-8?B?L3Mvejd6V25zU3VVbGJseWNlVGxkdStQVmRQckk2cjBQRzZpZnNZM2RncUhm?=
 =?utf-8?B?R2ppL3FSMGFHcUpyZXV5Y1cxZk5WWFdWNTNqSDZrN2xOZ1YyMkJZdGd2MXl3?=
 =?utf-8?B?VE1zRDFLTVVpd1FITmtLTWRJRXl1Q0xYdC9rT3oxbUxnUGpLZFkzMEZIWEw0?=
 =?utf-8?B?cEtrTUN4TDI2cGVIWWFmMmlWMFNwVlJ0Rmg4ejg4amplU1A0U2JvaER5WnhB?=
 =?utf-8?B?bU9vL1NHQndQNTdsR1hnZTM3UEpoSDdheFZBblhaRjcrOGd2S1Q2T0dMUkgy?=
 =?utf-8?B?VE1yVlB3ZHBnMlZxa1NWV3o5c0RVN3l4WDhsWVBIMytpODltUFZnVGFuSHhD?=
 =?utf-8?B?YlJnY0UzajJFbWttUG1sVVBvVGNFRDJkVUU2VEtsS1FsbmhIRTJLNzV1MExz?=
 =?utf-8?B?TWNydXp3czZ2NlpsMzMxMGMyU2tvMFJySWZhT3Izc1k2SG1OSWNXMmZTbk5r?=
 =?utf-8?B?dTQ4M2xoMGFGMitxVCs4MXdiZWRHU3VlZjFZOWI4WkcrYWNxODlHcmd4Tkdn?=
 =?utf-8?B?TzlvVUw1RmhIM1hsNVVJeVBzSlJRRExBam9QV2ZXWThJV3E3cWt1Z2swa1Q1?=
 =?utf-8?B?VFc1U1JNNUYzUWJmVk02TnFDOXhXY2JUOGk1MzdKcG9kYzlQVGdDVERqR05J?=
 =?utf-8?B?aysvZTJYVmJSSFZjTDU0QnVLRVNWUjRrVWFoWi9hYXZZMVpZNWo3YVhNanJ4?=
 =?utf-8?B?K044UVBGekE1SVdlSzBWa2xnYitTS2hxTzFpMG9YYzFrTlYyRFFTUzNUalA4?=
 =?utf-8?B?S3pSTm1UWVJuMUI2Mm1XWElIb2RZR0FXckFFM0gzZE94dStwNkhwWjVTNEQz?=
 =?utf-8?B?UkRmd0t3ek9pa1NzeFZncHlpQ0JDZVFJY3hNaW1LMGEzT3FFOGpMeGlTVnpD?=
 =?utf-8?B?eGRwaDdRSGdkRUFLaENZcC95eEIxc1lHWHB5V2xrOWZOdHFZR3NDMFZZQ0FU?=
 =?utf-8?B?dnZCVS8xVXNkZnpsK3UrenB5QUd1ZkNRdjlOTGtvSk5ySTZIMlVPMmpqeUNK?=
 =?utf-8?B?YkxEZGxjdmRGbVJpb1ZkSnJnWlU4Mjg1YWVHbUpRelZ3WUtvdDVDeG5HeGlm?=
 =?utf-8?B?RUREMjRTNExIQmhIbXVDSTR3WUo1V0pRN0NIVTZ4aDJLS1FZU2JsSHVGSzRY?=
 =?utf-8?B?MlgvT2Q4cnlCUWh1anQ1WER6TXJyM3huWmh0U0Rmb3NOM0plQ0FZc0dMaE96?=
 =?utf-8?B?S3FlSUFoYlJycC9yWGFNdGp6RDM5ZlVRNXJ0UHFYVGF1c1NQUllycXo4dFlZ?=
 =?utf-8?B?bFRyTkVUNTZsWkRwdzh3MnFTQnlnZ1FzN2xEc0dDSHJ5VzFjWjR4TSt5bjNY?=
 =?utf-8?B?UDJMSXkxSVcyN3c1S1V5S0wxYVlUMFNxNmM3OExsTWZmclF3ZC81MlFKZVcz?=
 =?utf-8?B?NEJwUSswL0JzUkw3aXE4bXFNNTAvc0oyaTczUGRQQWRCTUZNNlhHTjhIcFhZ?=
 =?utf-8?B?aDRmbmlwRmRsYlFTcWJkbkV2SThjMk9zK1ZNWUkvS1dRb3Y2ekMyTWdONkhF?=
 =?utf-8?B?WEVhdjdSUHJSK2cyM0pydHZHSXBEYm1lbzQwWUgrMTZBT2dIdi9jSnZMeUlj?=
 =?utf-8?B?MUJ1eW15M1dXeDltem5Tenc5S0lYUU1FQW9ON28xS3BLdk13SlpPVTdBYlFB?=
 =?utf-8?B?d1lobXNSNUl4SzgwUnVDZTVkdW0wY2JzeUVvR3hmK3pENWdCR1paU3JVQ1Bv?=
 =?utf-8?B?SDhkV2FDbXd2TUZuY2pBUjZQQzFldG4xc1ZuVHZZVm5qd2VDZnduSjhnbG5B?=
 =?utf-8?B?Mk5kdnhQeDJiZ3VIZi9IL01MMWF3UDRmUlRXeXFyMTl1MXpqQ25TN3daZnVQ?=
 =?utf-8?Q?gQ2E=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <744D7F36B3B6FE459D1A2B7B1B1E0A7F@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8305f923-83c6-47e5-d5d1-08dc4dca993b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2024 19:26:12.9045
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fa4M/IucsQN/ni5yidB398xNkrqfQfTczwYvj/MyPe3ptFFZyE4vUE0CJDe98h7HAYLQhAChz2he4PxegF+Cag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7958

QW0gMjYuMDMuMjQgdW0gMDc6NDEgc2NocmllYiBLcnp5c3p0b2YgS296bG93c2tpOg0KPiBPbiAy
NS8wMy8yMDI0IDIxOjEyLCBKb3N1YSBNYXllciB3cm90ZToNCj4+IEFtIDI1LjAzLjI0IHVtIDIw
OjM0IHNjaHJpZWIgS3J6eXN6dG9mIEtvemxvd3NraToNCj4+PiBPbiAyMi8wMy8yMDI0IDExOjA4
LCBKb3N1YSBNYXllciB3cm90ZToNCj4+Pj4gQW0gMjEuMDMuMjQgdW0gMjI6NDcgc2NocmllYiBK
b3N1YSBNYXllcjoNCj4+Pj4+IEFkZCBiaW5kaW5ncyBmb3IgU29saWRSdW4gQ2xlYXJmb2cgYm9h
cmRzLCB1c2luZyBhIG5ldyBTb00gYmFzZWQgb24NCj4+Pj4+IENOOTEzMCBTb0MuDQo+Pj4+PiBU
aGUgY2FycmllciBib2FyZHMgYXJlIGlkZW50aWNhbCB0byB0aGUgb2xkZXIgQXJtYWRhIDM4OCBi
YXNlZCBDbGVhcmZvZw0KPj4+Pj4gYm9hcmRzLiBGb3IgY29uc2lzdGVuY3kgdGhlIGNhcnJpZXIg
cGFydCBvZiBjb21wYXRpYmxlIHN0cmluZ3MgYXJlDQo+Pj4+PiBjb3BpZWQsIGluY2x1ZGluZyB0
aGUgZXN0YWJsaXNoZWQgIi1hMSIgc3VmZml4Lg0KPj4+Pj4NCj4+Pj4+IFNpZ25lZC1vZmYtYnk6
IEpvc3VhIE1heWVyIDxqb3N1YUBzb2xpZC1ydW4uY29tPg0KPj4+Pj4gLS0tDQo+Pj4+PiAgLi4u
L2RldmljZXRyZWUvYmluZGluZ3MvYXJtL21hcnZlbGwvYXJtYWRhLTdrLThrLnlhbWwgICAgICAg
IHwgMTIgKysrKysrKysrKysrDQo+Pj4+PiAgMSBmaWxlIGNoYW5nZWQsIDEyIGluc2VydGlvbnMo
KykNCj4+Pj4+DQo+Pj4+PiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL2FybS9tYXJ2ZWxsL2FybWFkYS03ay04ay55YW1sIGIvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL2FybS9tYXJ2ZWxsL2FybWFkYS03ay04ay55YW1sDQo+Pj4+PiBpbmRl
eCAxNmQyZTEzMmQzZDEuLjM2YmRmZDFiZWRkOSAxMDA2NDQNCj4+Pj4+IC0tLSBhL0RvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vbWFydmVsbC9hcm1hZGEtN2stOGsueWFtbA0K
Pj4+Pj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9tYXJ2ZWxs
L2FybWFkYS03ay04ay55YW1sDQo+Pj4+PiBAQCAtODIsNCArODIsMTYgQEAgcHJvcGVydGllczoN
Cj4+Pj4+ICAgICAgICAgICAgLSBjb25zdDogbWFydmVsbCxhcm1hZGEtYXA4MDctcXVhZA0KPj4+
Pj4gICAgICAgICAgICAtIGNvbnN0OiBtYXJ2ZWxsLGFybWFkYS1hcDgwNw0KPj4+Pj4gIA0KPj4+
Pj4gKyAgICAgIC0gZGVzY3JpcHRpb246DQo+Pj4+PiArICAgICAgICAgIFNvbGlkUnVuIENOOTEz
MCBjbGVhcmZvZyBmYW1pbHkgc2luZ2xlLWJvYXJkIGNvbXB1dGVycw0KPj4+Pj4gKyAgICAgICAg
aXRlbXM6DQo+Pj4+PiArICAgICAgICAgIC0gZW51bToNCj4+Pj4+ICsgICAgICAgICAgICAgIC0g
c29saWRydW4sY2xlYXJmb2ctYmFzZS1hMQ0KPj4+Pj4gKyAgICAgICAgICAgICAgLSBzb2xpZHJ1
bixjbGVhcmZvZy1wcm8tYTENCj4+Pj4+ICsgICAgICAgICAgLSBjb25zdDogc29saWRydW4sY2xl
YXJmb2ctYTENCj4+Pj4+ICsgICAgICAgICAgLSBjb25zdDogc29saWRydW4sY245MTMwLXNyLXNv
bQ0KPj4+Pj4gKyAgICAgICAgICAtIGNvbnN0OiBtYXJ2ZWxsLGNuOTEzMA0KPj4+Pj4gKyAgICAg
ICAgICAtIGNvbnN0OiBtYXJ2ZWxsLGFybWFkYS1hcDgwNy1xdWFkDQo+Pj4+PiArICAgICAgICAg
IC0gY29uc3Q6IG1hcnZlbGwsYXJtYWRhLWFwODA3DQo+Pj4+PiArDQo+Pj4+PiAgYWRkaXRpb25h
bFByb3BlcnRpZXM6IHRydWUNCj4+Pj4gQmVmb3JlIG1lcmdpbmcgSSB3b3VsZCBsaWtlIHNvbWUg
ZmVlZGJhY2sgYWJvdXQgYWRkaW5nDQo+Pj4+IGFub3RoZXIgcHJvZHVjdCBsYXRlciwgdG8gZW5z
dXJlIHRoZSBjb21wYXRpYmxlcyBhYm92ZQ0KPj4+PiBhcmUgYWRlcXVhdGU/IEluIHBhcnRpY3Vs
YXI6DQo+Pj4+IC0gc2VxdWVuY2Ugb2Ygc29jLCBjcCwgY2FycmllciBjb21wYXRpYmxlcw0KPj4+
PiAtIG5hbWUgb2Ygc29tIGNvbXBhdGlibGUNCj4+Pj4NCj4+Pj4gRHJhZnQgZm9yIGZ1dHVyZSBi
aW5kaW5nczoNCj4+Pj4gwqDCoMKgwqDCoCAtIGRlc2NyaXB0aW9uOg0KPj4+PiDCoMKgwqDCoMKg
wqDCoMKgwqAgU29saWRSdW4gQ045MTMwIFNvTSBiYXNlZCBzaW5nbGUtYm9hcmQgY29tcHV0ZXJz
DQo+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoCB3aXRoIDEgZXh0ZXJuYWwgQ1Agb24gdGhlIENhcnJp
ZXIuDQo+Pj4+IMKgwqDCoMKgwqDCoMKgIGl0ZW1zOg0KPj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAg
LSBlbnVtOg0KPj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAtIHNvbGlkcnVuLGNuOTEz
MS1zb2xpZHdhbg0KPj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgLSBjb25zdDogbWFydmVsbCxjbjkx
MzENCj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIC0gY29uc3Q6IHNvbGlkcnVuLGNuOTEzMC1zci1z
b20NCj4+PiBUaGlzIGRvZXMgbm90IGxvb2sgY29ycmVjdC4gY245MTMxIGlzIG5vdCBjb21wYXRp
YmxlIHdpdGggeW91ciBzb20uDQo+PiBUaGlzIGlzIHBhcnRpYWxseSBteSBxdWVzdGlvbi4NCj4+
IEkgY29uc2lkZXJlZCBjaGFuZ2luZyB0aGUgc29tIHRvICJjbjkxM3gtc3Itc29tIi4NCj4+DQo+
PiBUaGUgU29NIGl0c2VsZiBpcyBhbHdheXMgOTEzMCwgaXQgY29udGFpbnMgdGhlIGJhc2UgU29D
DQo+PiB3aXRoIDF4IEFQIGFuZCAxeCBDUCBpbiBhIHNpbmdsZSBjaGlwLg0KPj4gOTEzMSBhbmQg
OTEzMiA8aGFwcGVuPiBvbiB0aGUgY2FycmllciBib2FyZHMuDQo+IE5vIHdpbGRjYXJkcywgYnV0
IGlmIHRoZSBTb00gbmFtZSBpcyA5MTMwIHRoZW4gdXNlIDkxMzAuDQo+IFRoZSBwcm9ibGVtIGlz
IHRoYXQgeW91IHVzZSBjbjkxMzAgU29DIGFzIGZhbGxiYWNrLg0KPg0KPj4+PiDCoMKgwqDCoMKg
wqDCoMKgwqAgLSBjb25zdDogbWFydmVsbCxjbjkxMzANCj4+PiBTb0NzIGFyZSBjb21wYXRpYmxl
IG9ubHkgaW4gc29tZSBjYXNlcywgZS5nLiBvbmUgaXMgYSBzdWJzZXQgb2YgYW5vdGhlcg0KPj4+
IGxpa2Ugc3RyaXBwZWQgb3V0IG9mIG1vZGVtLiBBcmUgeW91IHN1cmUgdGhpcyBpcyB5b3VyIGNh
c2U/DQo+PiBUaGlzIGlzIG1vcmUgY29tcGxleCwgQ045MTMxIGFuZCBDTjkxMzIgYXJlIG5vdCBz
aW5nbGUgU29Dcy4NCj4+IEEgIjkxMzIiIGlzIGluc3RhbnRpYXRlZCBieSBjb25uZWN0aW5nIHR3
byBzb3V0aGJyaWRnZSBjaGlwcw0KPj4gdmlhIGEgTWFydmVsbCBkZWZpbmVkIGJ1cywgZWFjaCBw
cm92aWRpbmcgYWRkaXRpb25hbCBJTw0KPj4gc3VjaCBhcyBuZXR3b3JrLCBpMmMsIGdwaW8uDQo+
Pg0KPj4gTm90ZSB0aGF0IGV2ZW4gdGhlIGZpcnN0LCAiOTEzMCIsIHdoaWxlIGEgc2luZ2xlIGNo
aXAsIGNvbnRhaW5zIHR3byBkaWVzOg0KPj4gQW4gIkFQIiAoQXBwbGljYXRpb24gUHJvY2Vzc29y
IEkgYXNzdW1lKSB3aXRoIHZlcnkgbGltaXRlZCBJTyAoMXhzZGlvLCAxeGkyYyksDQo+PiBhbmQg
YSAiQ1AiIChDb21tdW5pY2F0aW9uIFByb2Nlc3NvciBJIGFzc3VtZSkgd2l0aCBsb3RzIG9mIElP
Lg0KPj4gVGhpcyBDUCBhcyBmYXIgYXMgSSBrbm93IHRvZGF5IGlzIGlkZW50aWNhbCB0byB0aGUg
c291dGhicmlkZ2VzDQo+PiBtZW50aW9uZWQgYWJvdmUuDQo+IE9LLCBidXQgaG93IGRvZXMgaXQg
YWZmZWN0IGNvbXBhdGliaWxpdHkgYmV0d2VlbiB0aGVtPyBXaGljaCBwYXJ0cyBhcmUNCj4gdGhl
IHNhbWU/IE9yIGhvdyBtdWNoIGlzIHNoYXJlZD8NCjkxMzAsIDkxMzEsIDkxMzIgYmVsb25nIHRv
Z2V0aGVyLg0KOTEzMCBpcyBzaW5nbGUgY2hpcCBpbmNsdWRpbmcgdHdvIGRpZXM6IEFQLCBDUC4N
ClRoZSBDUCBpcyBhdmFpbGFibGUgYXMgYW4gaW5kaXZpZHVhbCBjaGlwLA0KdXAgdG8gdHdvIGNh
biBiZSBjb25uZWN0ZWQgdG8gb25lIDkxMzAuDQoNCldoYXQgZG9lcyB0aGlzIG1lYW4gZm9yIGNv
bXBhdGliaWxpdHk/DQpXaGljaCBjb21wYXRpYmlsaXR5IHNwZWNpZmljYWxseT8NCklzIHRoZXJl
IGEgZGVmaW5pdGlvbiB3ZSBjYW4gcmVmZXIgdG8/DQoNCkZyb20gc29mdHdhcmUgcGVyc3BlY3Rp
dmUgd2UgY2FuIGFsd2F5cyBkb3duLWdyYWRlLA0KaS5lLiBydW4gc29mdHdhcmUgb25seSBhd2Fy
ZSBvZiB0aGUgQVAgb24gOTEzMCwgOTEzMSBvciA5MTMyLg0KQnV0IHdlIGNhbid0IHJ1biBzb2Z0
d2FyZSByZWZlcmVuY2luZyB0aGUgZXh0ZXJuYWwgQ1BzDQppZiB0aGV5IGFyZSBub3QgY29ubmVj
dGVkLg0KDQo+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoCAtIGNvbnN0OiBtYXJ2ZWxsLGFybWFkYS1h
cDgwNy1xdWFkDQo+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoCAtIGNvbnN0OiBtYXJ2ZWxsLGFybWFk
YS1hcDgwNw0KPj4+IEFueXdheSwgNiBjb21wYXRpYmxlcyBpcyBiZXlvbmQgdXNlZnVsIGFtb3Vu
dC4gV2hhdCBhcmUgeW91IGV4cHJlc3NpbmcNCj4+PiBoZXJlPw0KPj4gSSBjb3BpZWQgdGhpcyBw
YXJ0IGZyb20gdGhlIGV4YW1wbGVzIGVhcmxpZXIgaW4gdGhlIGZpbGUsIHN1Y2ggYXM6DQo+PiDC
oMKgwqDCoMKgIC0gZGVzY3JpcHRpb246IEFybWFkYSBDTjkxMzIgU29DIHdpdGggdHdvIGV4dGVy
bmFsIENQcw0KPj4gwqDCoMKgwqDCoMKgwqAgaXRlbXM6DQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAg
LSBjb25zdDogbWFydmVsbCxjbjkxMzINCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCAtIGNvbnN0OiBt
YXJ2ZWxsLGNuOTEzMQ0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgIC0gY29uc3Q6IG1hcnZlbGwsY245
MTMwDQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgLSBjb25zdDogbWFydmVsbCxhcm1hZGEtYXA4MDct
cXVhZA0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgIC0gY29uc3Q6IG1hcnZlbGwsYXJtYWRhLWFwODA3
DQo+Pj4gIFdoeSBpcyB0aGlzIGV2ZW4gYXJtYWRhIGFwODA3Pw0KPj4gV2Ugbm90aWNlZCBhcDgw
NyAhPSBhcDgwNiAoY245MTN4ICE9IDgwNDApLA0KPj4gYmVjYXVzZSB0aGUgdGhlcm1hbCBzZW5z
b3IgY29lZmZpY2llbnRzIGNvbnZlcnRpbmcNCj4+IHJhdyB2YWx1ZXMgdG8gY2Vsc2l1cyBkaWZm
ZXJlZC4NCj4gVGhhdCdzIGFsc28gbm90IHRoZSBiZXN0IGV4YW1wbGUuTWlnaHQgYmUgY29ycmVj
dCBidXQgYWxzbyBsb29rcw0KPiBvdmVyLWNvbXBsaWNhdGVkLiBUaGUgcG9pbnQgb2YgYm9hcmQt
bGV2ZWwgY29tcGF0aWJsZXMgaXMgdG8gaWRlbnRpZnkNCj4gbWFjaGluZSBhbmQgaXRzIGNvbW1v
biBwYXJ0cy4gSXQgaGFzIGxpdHRsZSBpbXBhY3QgaW5zaWRlIG9mIGtlcm5lbCAoYXQNCj4gbGVh
c3Qgc2hvdWxkIGJlIGFsbW9zdCBubyB1c2VycyBpbnNpZGUhKQ0KSW5kZWVkLCB0aGUgdGVtcGVy
YXR1cmUgY29lZmZpY2llbnRzIGFyZSBoYW5kbGVkIGJ5IHRoZSB0aGVybWFsIGRldmljZQ0KY29t
cGF0aWJsZSBzdHJpbmcsIG5vdCBib2FyZC1sZXZlbC4NCj4gLCBidXQgdGhlcmUgY2FuIGJlIHNv
bWUgdXNlcnMsDQo+IGUuZy4gZmlybXdhcmUgb3IgdXNlci1zcGFjZS4NCj4NCj4gVGhpcyBjbGFp
bXMgdGhhdCBjbjkxMzIgaXMgY29tcGF0aWJsZSB3aXRoIGFwODA3LCBzbyB5b3UgaGF2ZSBleGFj
dGx5DQo+IHRoZSBzYW1lIGJhc2UuIFRoZSBzYW1lIGJhc2UgaXMgbm90IENQVSEgSXQncyBhYm91
dCB0aGUgUyBpbiBTb0MsIHNvDQo+ICJTeXN0ZW0iLg0KSSB3b3VsZCB0aGluayBzaW5jZSB0aGUg
YmFzZSBpcyBhbHdheXMgYSBzaW5nbGUgY2hpcCBjb21iaW5pbmcgMXggQVArQ1AsDQp0aGUgInN5
c3RlbSIgaXMgbWFydmVsbCxjbjkxMzAuDQpGb3IgQXJtYWRhIDgwNDAsIHRoZSBzeXN0ZW0gd291
bGQgYmUgbWFydmVsbCxhcm1hZGE4MDQwIGJ5IHNhbWUNCmxvZ2ljIChhbHNvIGNvbWJpbmluZyAx
eCBBUCtDUCwgZGlmZmVyZW50IHZlcnNpb24sIG5vdCBleHRlbnNpYmxlKS4NCj4gQ291bGQgZmly
bXdhcmUgdXNlIG1hcnZlbGwsYXJtYWRhLWFwODA3IGNvbXBhdGlibGUgdG8gcHJvcGVybHkNCj4g
ZGV0ZWN0IHR5cGUgb2Ygc3lzdGVtIGFuZCB0cmVhdCBhbGwgdGhlc2UgYm9hcmRzIGFzIGFwODA3
Pw0KSSBoYXZlIG5vdCBsb29rZWQgaW50byBwcmVzZW5jZSBkZXRlY3Rpb24gZm9yIENQJ3MgZHVy
aW5nIGluaXRpYWxpemF0aW9uLg0KVS1Cb290IHN1cHBvcnQgd2l0aG91dCBzcGFnaGV0dGkgaXMg
YSBmdXR1cmUgTWUgdGFzay4NCkkgc3VzcGVjdCBpdCBpcyBwb3NzaWJsZSB3aXRoIGFzdGVyaXNr
ICosIGJlY2F1c2Ugc28gZmFyIEkgaGF2ZSBvbmx5IHNlZW4NCmNvbmZpZ3VyYXRpb24gd2l0aCBh
dCBsZWFzdCAxIENQLCBuZXZlciB3aXRoIDAuDQpQcmVzZW5jZSBvZiBhIGJvb3Qtcm9tIG9uIGVh
Y2ggZGllIGUuZy4gc3VwcG9ydHMgdGhpcyBpZGVhLg0KDQoNCnNpbmNlcmVseQ0KDQpKb3N1YSBN
YXllcg0K

