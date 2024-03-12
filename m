Return-Path: <linux-kernel+bounces-99755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67CA9878CC0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 03:09:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C563B21993
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 02:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5AD5CB5;
	Tue, 12 Mar 2024 02:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="THzlY49V"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2058.outbound.protection.outlook.com [40.107.7.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6051C17;
	Tue, 12 Mar 2024 02:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710209328; cv=fail; b=hCrqtgP1QYMg2vdch9D5LmqHUkGVNDQk9bVMC72BhkD+VMbmvuVVASYNw7NBascVUo/CwsPJuQLOrylCau4Tv+dyyxE1wEsW+j35O4/3LMxIa+RMEsOPOEXbUYJYQWoOYI4ynFoM02ZrFTlQLOJ/0G1c5An+iBfEDB8OAGFCHPI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710209328; c=relaxed/simple;
	bh=cPlM6RRfTArcZr3iwxTo/BHW8iYYy/5n+k8siOPcnGU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EY2DJ4WZ1fymZP9xz72Rxu0sNo0j/mDZ/SNg0TCrUpDfFCSgILqQas/Lxadcrg+8/T9E5u/a2K7pMH8B7nJFZ6ujP3kjJWItc6e1rTsJaYtpnLcuaerq1zyKfPVFB7BpWr9sjd3RrRgIfGYvSsDmJYPD7nuJFiEGhcxN+6pIGWE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=THzlY49V; arc=fail smtp.client-ip=40.107.7.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Moy1I1zh3+ksQbCYyEst9hhE+m+nWV+WKHpoROhW3Ly7RNOTStXYNV0xo1G2jyD6ZX/ifJTzdW2VF6NlLAnqjPU3deQw4DP9btBAUoh5ZI4JB6LxPoLjfeYGs0OsJ/N+U22E2pcvYKkLe9i6DkYx/nHouQHEPz8Kjgup0IYpGNTi0hvv3i1As0AObI3EpZ6acCYNMZHXmqzd+NP5JdjXjC5ZzxGJWzGvj9RAPsEXkVtY8E7nTaxyhDXSTezRYz3e99kh4oR9tGsGQJ+VOhAoRkKmwxxswKJSl6EgSsmANOyr71pYX0FM0fTvVt3t/VcGm5mjWq6nNE6tfMPVmYUj3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cPlM6RRfTArcZr3iwxTo/BHW8iYYy/5n+k8siOPcnGU=;
 b=S05fsuKWR34MsyOlw2gN8L++heEQu049/Hy5vKVYAm24My9v0/qtLnsCeuMYSrBoEqsKfsXbQn8xTKUSgFyOV0vr4MLrAJ325ug4j3woxM6jjZ5ND/gNClt5eYgmereKSpBso9gx941UcCgWAs6P/sNmAtkFEeHPkTbNizp5vASe8Wnzbg7UltFen6ece4YM9uXCYGLoBgwnObF/Cm4/phqALAbT6EwtFt9cU6a1liwsMrmuSYE17XYMXjJ0jxkeB9qOkZRFugYZKYRfvFN8s98a7BUyRRC1LseB7vYGsT4JkT/oW1U1x+1rqEXKlLsloDkbH83Cdw/abqZoYK6IYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cPlM6RRfTArcZr3iwxTo/BHW8iYYy/5n+k8siOPcnGU=;
 b=THzlY49VAMLqxtstweRoDjU9FJDAWisJVgBGGCdBEdH3uY5Sgp5lIbNKzCFMdTuejPA4IGi9WYnJ0khc/V9LvmsE1LB+uAXUNO2FnY4U2hfb7Te98jtmGlIbzlKldyDYSBMz9xNFftv7ahttZ8G77TXVSLNqY3GBUZMwa0nN8qQ=
Received: from DB9PR04MB9377.eurprd04.prod.outlook.com (2603:10a6:10:36b::13)
 by DU2PR04MB8709.eurprd04.prod.outlook.com (2603:10a6:10:2dc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Tue, 12 Mar
 2024 02:08:41 +0000
Received: from DB9PR04MB9377.eurprd04.prod.outlook.com
 ([fe80::b3d4:17c4:91b7:101d]) by DB9PR04MB9377.eurprd04.prod.outlook.com
 ([fe80::b3d4:17c4:91b7:101d%5]) with mapi id 15.20.7362.024; Tue, 12 Mar 2024
 02:08:41 +0000
From: Joy Zou <joy.zou@nxp.com>
To: Mark Brown <broonie@kernel.org>, Alexander Stein
	<alexander.stein@ew.tq-group.com>
CC: Jacky Bai <ping.bai@nxp.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "shawnguo@kernel.org"
	<shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>,
	dl-linux-imx <linux-imx@nxp.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [EXT] Re: [PATCH v2 2/3] regulator: pca9450: add pca9451a support
Thread-Topic: [EXT] Re: [PATCH v2 2/3] regulator: pca9450: add pca9451a
 support
Thread-Index: AQHac4+7u0hmWzGzAUKgnbLEggIvnLEyQHEAgABIawCAANLeUA==
Date: Tue, 12 Mar 2024 02:08:41 +0000
Message-ID:
 <DB9PR04MB937723C4354245735A9B8FA3E12B2@DB9PR04MB9377.eurprd04.prod.outlook.com>
References: <20240311084758.377889-1-joy.zou@nxp.com>
 <20240311084758.377889-3-joy.zou@nxp.com> <6027895.lOV4Wx5bFT@steina-w>
 <5b257caf-5a14-4c82-9999-061a0093a831@sirena.org.uk>
In-Reply-To: <5b257caf-5a14-4c82-9999-061a0093a831@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB9377:EE_|DU2PR04MB8709:EE_
x-ms-office365-filtering-correlation-id: 73284e0b-0598-42ed-c4a0-08dc423956e2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Qn+XRP13/AahS5oHwA3JYo/8OPtuE/iWlNVkgUyiqLRTv/dFXJjO3AHUzAx3xW2lo/K+gq8qPsoJWN7z3EUaakb5KNzKvTqSw/WdbAFluyqezbMjGVFJ+3UN4DeYanjOwDOqtALW054UyxfwUGfW73Necc/ugc3qeErAJXiAqGH8gNAxKr0ntu/htTlX6h5yasC+Gg/sPqWwbWxlzeXyecKl9A9mX9miZn5vCRlEyqd9A31Z1UktI8TjrHLtrbgr5fbx9T7Lz7oJ3/CtilIKM9+lN2d/uVxNoULeNacmLXscuBOo7bpYfjsc1n6t0rJR/QhvISj1CLztXU6gocwrYOdFVJLm0p+mU8CkUTMHozqwnM7ISPujiZVZx9vag+2RalVOF4jAvDf6rp9SKzIfgHjlYM0FEGG8x35Vz/rZc1jgNiwnA2PrfluXomii/dSJuMIIxW09iYgaxQtHPNH0F9wPxWtJUY6dn+97AiOQiKx2xtnNjIWCdUf4IRTvNcyJCCICpjEUbEtfzAp3VjzlRJUlX7mWGh1JKb8hgiL07fE5+wzsc5UskNw5i8gfaEZoEVoC/1NzAffK/miaQJJ56EcuMmnE4V7NlZyUqr4gkEnn/vecUVmiC4tMlUX3qIdFHV2nEw1xLm6x+kVLhyhIuoIxC9ZvbhSCus1bPo4cZUrTciS7s+zWdTRTLgBrr8SAgKtaUbD0Srl4E2f/kVH7oYGf5SU0d5j67lAxiYsLerk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9377.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?TUdXa3ZuSjFnQzVlcUtsSHNhZCs3c0pwOFlsYVVJeEp1TGdRNGljQ1dxeG9j?=
 =?gb2312?B?UFI4MnRIQkpYSWZUUGZYSWhlL1phZEtvcDFGV0dxU1VvbnhjV3Uydysra3JR?=
 =?gb2312?B?OUlNQ255WFdJeXV0NE1QMXpTWFB3UGRNZ0Mxd1NqSnM0S0VUa21DZUtPWlJF?=
 =?gb2312?B?U0FkWXhyZWp6TWJDcE9BdExQdmxlcmtkYkhQRTJCcGpBUXlpVmR5bERhM29j?=
 =?gb2312?B?bVVTTk5ZeVJxNEF6TU9Pd2VsT2YwSjJFWEFJbmdSeWYwZ25jMVNNTFdReHV6?=
 =?gb2312?B?UWplTzczVlBOWGQ4dklhS0crQ1pROUY1elloTnNsRzUrc1VXS2lSODM0Z1Rh?=
 =?gb2312?B?TjZ3S01GeEwzcUFOd2RKRUVRNUxLM2x3UndVSFZwQldqYk5UL2ZsVzR4Ymtu?=
 =?gb2312?B?b2NlMnY3SHg1bi81NWZyek1SRDE5bWVoTmVvVEtmbU16WlVyVkhaYzZVRVZM?=
 =?gb2312?B?M0g0WDlhc1YxOVppZWJrUTNBMGErTDk3bW1yNUtMNmVENUFrZHc5RVNENFpF?=
 =?gb2312?B?WUlZT0hZZHhjZ3BMa0NIei90dmtJSWdkTzhySi9aOWdKZlFFV2J2STkzOHpJ?=
 =?gb2312?B?K0hzaGgyZG1qZnRtUGFkbEtqUm1SYWNLR05oR1hZRTVlUmNtOVhMSGw3MVhV?=
 =?gb2312?B?eVZHTVdrNkE0T0VIV2RPSDlQbVlzaUhUc0Z6b2N3RWE5eHZOQllXY1BMeG5m?=
 =?gb2312?B?UHUvYmlmdjVQN1dVc1VjVE1HTi9Ha1BveGZvSmhHYnN4b0NqUEFXejZJYmJF?=
 =?gb2312?B?YTFOaHlnNUYxbVRnV0xkbHBpd0pXWjdDTExrOWs0Nm5BK3VHMmJBUnUydHJm?=
 =?gb2312?B?Ni93UjRHU08wY0krTldsbXVwWXMzY2NJbkM0VlE3VXg2L1VDMmx4ZDhpRDBs?=
 =?gb2312?B?ZU8vR1lZMFR0YThoa1BjUURpM1l4S0NqV3dUdzdjbDl0dWQrZ0J5R20yNGVU?=
 =?gb2312?B?eWtiMGc0aDBpUm4zZGNkWHdWMjVqMnVITlFTNzFtTjRnbmFSSEZlTEhCL3cy?=
 =?gb2312?B?dWFjKytOdTluK2lyVWQwL0tLbVlIQVVaTUcwVmZIRHFOMWxOMUkyWGNLVlhQ?=
 =?gb2312?B?OUIrUngvcXVMRE81QlBOSXIzMG93QjdJN2F4OWhDa1lQa2hqL1hMQ2hkRjRi?=
 =?gb2312?B?Zlk1ano2VVJ4eFZWMUVITTN2WU1kTXBvVW03b0Y2Y1pmMjUrbFR1Z1crRmd3?=
 =?gb2312?B?ZFJEcFdGTWNZVG1kMHUwYm85OEVFZGxXeTJsT2JFSjVvMDFsWWVUSXZPc0Jw?=
 =?gb2312?B?S2JYS2lNcnhyYlVxUHpqb25wV1ptazlMM1BndWVHZ3I4dXJ2SUd0dDhTK2Na?=
 =?gb2312?B?dlplY1ZFemhESkJ3QzJuSW52Ni8yUnQvM2QrTDFPZ0ptdWpHbW55Vy8yc1pm?=
 =?gb2312?B?WmZLK094K2NicDZTWXdvVEZMVTY3SExVRWRDbGlmZmpERnN4bkxObkVxNmNy?=
 =?gb2312?B?L3dicytybkRyNEc1bUxPSWJnZGkvZGgxa3crNFVzeTBlTkdNQi9DL0p2Q1A3?=
 =?gb2312?B?dFFHRlFrRFhvbDBZTTZ5S1BMWjFtWklSbEtmaEJCQkJQUkZiaWVleE94UTZr?=
 =?gb2312?B?ZGw1Y2NBMzhpNXNsZXNYZ2JoRG5lanVZYXoxdWhSeU5jZktTRUNTZmVhSHNl?=
 =?gb2312?B?V1U0clM3bThXZEkzOGMzWThtV3J2cUFTeG1peU83djhZL2VIOXZsTlViSVBt?=
 =?gb2312?B?dnFZVmR1bHp0VzkwdjI5QVFMVllmOUZxSENQTVpVOVpYMDFhS3NGcFNtU2FN?=
 =?gb2312?B?cWJ0R2x0YU5rYVVNVzlvQWRFSTBQUmlrNEtrdWhGbFpDQXNiTmYxSkhIUjUy?=
 =?gb2312?B?SEYxdy9GMGZDS1FCVTlCQnBxZG5qT3hqd2hXV0p0Y1d4c0Y2a0ZaanZUQlRG?=
 =?gb2312?B?aXhYS0NVdlhHaGgyT1ZITjB6MkNNR2NPV3dIMGNSdTJ5MGlJWUdlMkZuaytV?=
 =?gb2312?B?UVNuSUNXU3NoNExjU3B6YkxqbUw0dEpqK1VsNFAzeVMwbklncGFYQ3IwQ0Js?=
 =?gb2312?B?ay9URmg3TUJLS0VUZXpGQW44VDNEbzR5WFlsUGhsZ3VLUk5yZGNCRVJWdHpC?=
 =?gb2312?B?emppWEloUFNDZG1rWm90LzFSemFES0RVVnJlRmlCMzdsNHpXVDkyYXhyL2tP?=
 =?gb2312?Q?aIW8=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9377.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73284e0b-0598-42ed-c4a0-08dc423956e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2024 02:08:41.7828
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2VH+Kfm3ec9A8MMsJwe4Wrs8ObPqCtqZLrzDqNUxOwyrqjPS27IEUlNGZ4WQaMax
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8709

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE1hcmsgQnJvd24gPGJyb29u
aWVAa2VybmVsLm9yZz4NCj4gU2VudDogMjAyNMTqM9TCMTHI1SAyMToyOA0KPiBUbzogQWxleGFu
ZGVyIFN0ZWluIDxhbGV4YW5kZXIuc3RlaW5AZXcudHEtZ3JvdXAuY29tPg0KPiBDYzogSmFja3kg
QmFpIDxwaW5nLmJhaUBueHAuY29tPjsgbGdpcmR3b29kQGdtYWlsLmNvbTsNCj4gcm9iaCtkdEBr
ZXJuZWwub3JnOyBrcnp5c3p0b2Yua296bG93c2tpK2R0QGxpbmFyby5vcmc7DQo+IGNvbm9yK2R0
QGtlcm5lbC5vcmc7IHNoYXduZ3VvQGtlcm5lbC5vcmc7IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7
DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsga2VybmVsQHBlbmd1dHJv
bml4LmRlOw0KPiBmZXN0ZXZhbUBnbWFpbC5jb207IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54
cC5jb20+Ow0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZzsgaW14QGxpc3RzLmxpbnV4LmRldjsNCj4gSm95IFpvdSA8am95LnpvdUBueHAu
Y29tPg0KPiBTdWJqZWN0OiBbRVhUXSBSZTogW1BBVENIIHYyIDIvM10gcmVndWxhdG9yOiBwY2E5
NDUwOiBhZGQgcGNhOTQ1MWEgc3VwcG9ydA0KPiANCj4gT24gTW9uLCBNYXIgMTEsIDIwMjQgYXQg
MTA6MDk6MTJBTSArMDEwMCwgQWxleGFuZGVyIFN0ZWluIHdyb3RlOg0KPiA+ID4gKwkJCS5vZl9t
YXRjaCA9IG9mX21hdGNoX3B0cigiQlVDSzEiKSwNCj4gPiA+ICsJCQkucmVndWxhdG9yc19ub2Rl
ID0gb2ZfbWF0Y2hfcHRyKCJyZWd1bGF0b3JzIiksDQo+ID4gPiArCQkJLmlkID0gUENBOTQ1MF9C
VUNLMSwNCj4gPiA+ICsJCQkub3BzID0gJnBjYTk0NTBfZHZzX2J1Y2tfcmVndWxhdG9yX29wcywN
Cj4gPiA+ICsJCQkudHlwZSA9IFJFR1VMQVRPUl9WT0xUQUdFLA0KPiANCj4gUGxlYXNlIGRlbGV0
ZSB1bm5lZWRlZCBjb250ZXh0IGZyb20gbWFpbHMgd2hlbiByZXBseWluZy4gIERvaW5nIHRoaXMN
Cj4gbWFrZXMgaXQgbXVjaCBlYXNpZXIgdG8gZmluZCB5b3VyIHJlcGx5IGluIHRoZSBtZXNzYWdl
LCBoZWxwaW5nIGVuc3VyZSBpdA0KPiB3b24ndCBiZSBtaXNzZWQgYnkgcGVvcGxlIHNjcm9sbGlu
ZyB0aHJvdWdoIHRoZSBpcnJlbGV2YW50IHF1b3RlZCBtYXRlcmlhbC4NClRoYW5rcyBmb3IgeW91
ciByZW1pbmRlciENCkkgd2lsbCBkZWxldGUgdW5uZWVkZWQgY29udGV4dCBmcm9tIG1haWxzIHdo
ZW4gcmVwbHlpbmcuDQpCUg0KSm95IFpvdQ0K

