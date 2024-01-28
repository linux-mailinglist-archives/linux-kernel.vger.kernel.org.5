Return-Path: <linux-kernel+bounces-41480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8224B83F28B
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 01:28:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A51FA1C22229
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 00:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0441BECF;
	Sun, 28 Jan 2024 00:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UCXyD3r8"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2074.outbound.protection.outlook.com [40.107.104.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9921A7FD;
	Sun, 28 Jan 2024 00:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706401729; cv=fail; b=MjteTAQhwYcHCPlm0RUFn0PvIeAKdn1I5Y/d5Ul5aN9VBpgzVYwzrbRiz5rCazwYzkIsFC8ixk3O4unxYrMHg3ZEfFrJ5pbhmFvm8WMMSIyvEEI6VOtT4XW0KbJMDD/p9ArWIixUgpFyIfmePZV+iKDuRUxN5YXlA/erLrvataU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706401729; c=relaxed/simple;
	bh=0o7cNvxSzoZqEKbUqsMoViyQmoWcaa/ED/899AysGHc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Y1fq6K9xsnjdQGqrS7SiGUXXk4zLdjPqIkFgDZMzNseymcQsw8ANWWOxWBRhVyofZgOCf19/TGD/QuDCdqsv01fcUMdhMXRUaYBkS5Lz4J34Nv/lwFVoEkw97OwAJtvYMGopu3t3piyneCHObtuNF9RSHLf2S+6VWXlwjcJVrtk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=UCXyD3r8; arc=fail smtp.client-ip=40.107.104.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bmOLI8DOnZlCN4fPTyDxlVBGM4sML4DsUT41N7Uq+zkDXmrQ7Nt0VGg5RyGZTQKLO1qHpjA7cIU0BKnKhIpZUXMLHsRI1rlbS+up+1g6ix6SnaSmHHwWF3wjpwbYnHDTvbFNtGWS4bYuqkKGmdTmkU1tNaS5VprGYrAg7Y14j3KcS+0rKVTP5XU1bmo9DJxtV+lMfqWsG++YPFITleX2+gY5jj/QFyfqvvhCXAyhR6WqLMfml6JPG+uhyggpXoFxRowsOjTh636el5Ao/kdO/0dh3RtTdcJbDObdVRxofKj0/24P6e+Jh3/+vQnII6I3DEBKTX8Kf5xawpY0plIYoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0o7cNvxSzoZqEKbUqsMoViyQmoWcaa/ED/899AysGHc=;
 b=Ntgn8CzOaCJGnHYsLAvvzBeC7FRDM4olJJ7cKekaFmkxNyq/1EyXJw/U3WoOSBatfrE0hI6XYCoZnSPebu42P/OOXj35NoiAbbVbY9LXDuKBwJw0sOnqYN0bcLEUBR/2d47n2WvhEQ+aO0ltuSkY2JJnuBcmocTf1xkg8/gGgU8u8+JvvviGdCbnOhktFiVuYzxtDt3wmXt9Rpxb0gMEebSE7PDffdiqy3UsNT2aH6kMmeIwgl/kLuWvo8vxCV1Tnc5Vkb2ItG30LLmYtzGHIZaPCtMhh8zD+CqaIYC6Ayhnfl5/eDSxqGlNryCwNBSrhSYf9Iiv4yI7VteDkyzRjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0o7cNvxSzoZqEKbUqsMoViyQmoWcaa/ED/899AysGHc=;
 b=UCXyD3r8rSrV8zHdLcRQf3IXEYq2dQR+DCUTImb+oD2uRZDFFb8FacIMLPgGN4RlTxiqlnS9i43k7ZxZIGar9MVKGZIgMUJn0cBMDsWyqOEXXT7AQhm6t+DxEzDhEszwMtP1ob+tUSgoKcbcrN2QwkD2xowECa6s+8Ssxo1R1Xk=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS4PR04MB9387.eurprd04.prod.outlook.com (2603:10a6:20b:4ea::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.31; Sun, 28 Jan
 2024 00:28:43 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6%3]) with mapi id 15.20.7228.029; Sun, 28 Jan 2024
 00:28:42 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Linus Walleij <linus.walleij@linaro.org>, "Peng Fan (OSS)"
	<peng.fan@oss.nxp.com>
CC: Sudeep Holla <sudeep.holla@arm.com>, Cristian Marussi
	<cristian.marussi@arm.com>, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, Oleksii Moisieiev <oleksii_moisieiev@epam.com>, Shawn
 Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
	dl-linux-imx <linux-imx@nxp.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-gpio@vger.kernel.org"
	<linux-gpio@vger.kernel.org>, AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: RE: [PATCH v2 4/6] pinctrl: Implementation of the generic
 scmi-pinctrl driver
Thread-Topic: [PATCH v2 4/6] pinctrl: Implementation of the generic
 scmi-pinctrl driver
Thread-Index: AQHaPvsVxbGGDG6YNUWeEYoOJH+I+bDufbcAgAAFCXA=
Date: Sun, 28 Jan 2024 00:28:42 +0000
Message-ID:
 <DU0PR04MB9417E697C5AF094C449C851D887F2@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240104-pinctrl-scmi-v2-0-a9bd86ab5a84@nxp.com>
 <20240104-pinctrl-scmi-v2-4-a9bd86ab5a84@nxp.com>
 <CACRpkdbOVu4A0JdwvBaxvgvoT5u3VbjTyQi0mgqknCixR2vzYw@mail.gmail.com>
In-Reply-To:
 <CACRpkdbOVu4A0JdwvBaxvgvoT5u3VbjTyQi0mgqknCixR2vzYw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AS4PR04MB9387:EE_
x-ms-office365-filtering-correlation-id: 8c169376-e142-4fa9-3a1a-08dc1f98150a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 HT7IanabquMlRpa0LTkBZmOtqTZbP14piR8Gs8E/2UCb0kZ8ZBa7Y19BiekltarP6e1WPe1mwN7d8bcg97J2pD9PHVQm0L8wMbWxVSOo+qKcNebLMCG4bS1YGLRuBhAwk5becKjLR9jS9bRnh9TjEs3P1UlDP0XYGzI2DbZX1Twm5jqL9epCWnSH8PYTe5I7zqSLxOgvHsphRU38cmRCHYX/Jz+cisdlb41rjlAbtGi7TqOZWaM2qwEPFBzh3xngws3UtZOZlJX/vRemkc0G1oNk0N0KRHMdPid3boNXsLScnl2ooY/sdETyNKA4c4qdbKgdQ+NalSNwQzUiLNV/N0C6ayh7zXYa+aw/0/u3GEe43WvHF04grIzrVy44bpA/vvnvSzW8DwQqMkfKXL2vRkxKPsPUYCE216tLv+zMKmD51bx9+IXBOvGXEMfZVixsww+1LM8k1fyBRxsEbG6su9keO7Cfg+rz3c2we7BcFsYi3zB2peQrx39TS3m04/BMHTAMZjqO11iAEZWQnvgMGbNz+Mh1qUsARTyLwVfsgXRtUgQVm5cgBJPk+T1TG66lYxGJsYffJyS894KDzZjTut3x3+Cq5ucX94y7/MDJARqSq+xs+Bba2Eoq/XwLK1ce
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(136003)(346002)(366004)(396003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(83380400001)(26005)(53546011)(6506007)(7696005)(9686003)(38100700002)(122000001)(5660300002)(7416002)(8936002)(8676002)(4326008)(52536014)(41300700001)(44832011)(2906002)(71200400001)(966005)(478600001)(316002)(66476007)(110136005)(54906003)(64756008)(66446008)(66556008)(66946007)(76116006)(33656002)(86362001)(38070700009)(55016003)(41533002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WStNUzBIMWdXR1pKUEVKSTdsd1hSaEx4SDlGNjZIVHJOa3ZESE1pY2RGaXRR?=
 =?utf-8?B?ZVhpczV3RWpORXVTNHZ5RGhjU2MrQ1JVWDArRTE0b2JLUkMrc0V0eTJVYjkr?=
 =?utf-8?B?RU9nRzFXRjBWelhxL2cyaG1KYWI5eG9JeThudWthbmd5dVJZNEVVRnJrRHNp?=
 =?utf-8?B?MmswVkk4MXBDNUloamZkRVMyZ2MxNXo0S2lSU3RmZ3FvdVNHQnFkcW04QUZD?=
 =?utf-8?B?MCt1akJsaXNKbVJCWDIxNUQ5VFNvQ0VFRVVVNjVId3hYcTRqOU5BMzN2Ymp1?=
 =?utf-8?B?a2RWdUJSRHkreGYzYldSS1pHdHJmYmxtTVRkb1NnWHNZaUpSVE40YjBscTJK?=
 =?utf-8?B?TTc4QkZ0bmd6MlFLWngxVEFvbWZaa1ZDZDhIQm9SZ3RHVHU4SUlqSmkyS2cy?=
 =?utf-8?B?dDZiV2xVUWcxeEljQmlKTVVhZzdJbHUxbG5xdkg4MEVIWm9QZGpVam9yT2Ru?=
 =?utf-8?B?VXlIWXUrckdUaml4TDA2R0VPdTEyNFFvbDJVV2ZRclg0OVNyWWVmbEErYlRx?=
 =?utf-8?B?MFJsYUU4aHNzcHBqbUw2LzA2TnZLRUZoN29hUlZyWG9UakVrczFDdVN1VENY?=
 =?utf-8?B?UlZxQkVnREpoUVhmSHJmdVN0ZGlicVBNR1NSRjRueUprWmNWcWd5bnl6WkM2?=
 =?utf-8?B?RXpuS01TZURzVWJVNHJUMFBsMG1YNnJlaUY1b1dKczgrakhYelBZalk3OGNK?=
 =?utf-8?B?TkNzL0JtTFRlQ3hYTGJDcjRCbVJxUE90amFYRkZQbHhZR1JtTEovcmgwRklS?=
 =?utf-8?B?UDdyNnNUNm5uTlFlYUxBTGpWUER5aXZ3dmp0eVkwYjdkVno0M3gyTHUzZFhU?=
 =?utf-8?B?MWR1ZitZcXRnNHJ4MThCem5jMnZSZFJHNkRDYW1qNmtocytZbk12Q3FYWDZ4?=
 =?utf-8?B?MEhkWUpLVTZhdGhROVFwRDhINkFLeWtUNkZFT3Q4WlYvMlRjM1A1bXNVQUxv?=
 =?utf-8?B?VytkWU5NQUhCcDBMUyt2YlZubEJaczYwbHMzRE5zZjREOHpLbGdQWWJQaTB6?=
 =?utf-8?B?dlYyQ0hHeDlpeFc0cm82ZkhJWHBkcVQrWjRLem5rRzIwZVFhRy9PYjBMRTVp?=
 =?utf-8?B?SXNlYUY0NW41TnYyWGJVVlBmRXNQSlNtQzY1Nm1kcHFhL0J4TWdkUzJyZmkz?=
 =?utf-8?B?anh3WGVFNHdweThMNEtUK05ScEFZUVdacXNHaTEyUjJZSjBSdjlTdXRvd1lq?=
 =?utf-8?B?NWFTK0YrMUNBeU0wRkxYcC9MWjl2Snc0SkdmTm1qekRaL0h6UXJwVmtETEhS?=
 =?utf-8?B?NSt6akIyWHZPY1VGcDE3d0UxVmV1RmMxaE9pODBUOE14UWpUakhJRWJ0bmJw?=
 =?utf-8?B?dk5mZXg5dXdFMndVWHdRRHdWeXlpRFZTYUE3dnRuWkpBWHU1eDgweEd1dytC?=
 =?utf-8?B?dDVLMWsySHRzNmhaYXQ2eUR1MUlad3Q0ajdlQ2tybk5Rei9DcHFTOW9Oekhw?=
 =?utf-8?B?N242emlKRWVGdnhPcWNsT3JVajdYcTJlQ2tTQkREekJvZlV6cklqSUg3Rjl5?=
 =?utf-8?B?ajF1eEt1ZWhhMlBYVW1JZkkrNHR6T1hJdjZSRUZVK1BlTGxwVjF3MnBqRkJT?=
 =?utf-8?B?STA0K3pmTlJaUzlZZXc3T1lzV1N3T0RJQkxLL2dTbjE5bVZxdjRZZ0JEQkZz?=
 =?utf-8?B?Y3hhcVR3Sk1LTlNwR3N1MUZMbUdpOFptWVF6VTVCeHZtS0FaZUU0M09CMFdP?=
 =?utf-8?B?Uk12UmMvZEZweU1sYTJsOSs1TkZ2V20zMXlBRTk5UDRPSmVtVWhsbDd5b2JH?=
 =?utf-8?B?ZDlMcVZVWnZPZ1NucUVWVVpFWU5FeUtnMVlQMENJcjBma0NuMDhyMXlIVTZX?=
 =?utf-8?B?c0pmbkFCNmFEVTVQczdzOStSTi94NndWNVNLc0FseFhiOHVsUWdFTXNmYjFU?=
 =?utf-8?B?UHhnQm1LRnVWN0RCUWlMZkJGZnVncER5VmlTZEtCYlZiUnllRm9TS2V1NS8z?=
 =?utf-8?B?TGRCRVJza2ExeWc4WnprenYwMCtQbTVuNkQvWmFRUTZDaDMybnUxMC9FYzdH?=
 =?utf-8?B?b3I0TGtid1VqMVc4R291YkVHd2lPNHJ6S09oTlZKcDdJMjFJSHZSYSs0ZWIy?=
 =?utf-8?B?aDFzcFlydGdVSnBUZDlyaTRWQVpiVWMwTnhoUTlZKzVvODl3cE1ITnFQaTdN?=
 =?utf-8?Q?8T6Q=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c169376-e142-4fa9-3a1a-08dc1f98150a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2024 00:28:42.8024
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v7nZmLSX8cHozjLvgK3OS+RBdVPWSc17258Dn1GXVPLPfbZh0226sWC9qoO3CzIRSGgVwIxH0cQevrT52yhCxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9387

SGkgTGludXMsDQoNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiA0LzZdIHBpbmN0cmw6IEltcGxl
bWVudGF0aW9uIG9mIHRoZSBnZW5lcmljIHNjbWktDQo+IHBpbmN0cmwgZHJpdmVyDQo+IA0KPiBI
aSBQZW5nLA0KPiANCj4gdGhhbmtzIGZvciB5b3VyIHBhdGNoIQ0KPiANCj4gT24gVGh1LCBKYW4g
NCwgMjAyNCBhdCAxMTo0NeKAr0FNIFBlbmcgRmFuIChPU1MpIDxwZW5nLmZhbkBvc3MubnhwLmNv
bT4NCj4gd3JvdGU6DQo+IA0KPiA+IEZyb206IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0K
PiA+DQo+ID4gc2NtaS1waW5jdHJsIGRyaXZlciBpbXBsZW1lbnRzIHBpbmN0cmwgZHJpdmVyIGlu
dGVyZmFjZSBhbmQgdXNpbmcgU0NNSQ0KPiA+IHByb3RvY29sIHRvIHJlZGlyZWN0IG1lc3NhZ2Vz
IGZyb20gcGluY3RybCBzdWJzeXN0ZW0gU0RLIHRvIFNDTUkNCj4gPiBwbGF0Zm9ybSBmaXJtd2Fy
ZSwgd2hpY2ggZG9lcyB0aGUgY2hhbmdlcyBpbiBIVy4NCj4gPg0KPiA+IENvLWRldmVsb3BlZC1i
eTogT2xla3NpaSBNb2lzaWVpZXYgPG9sZWtzaWlfbW9pc2llaWV2QGVwYW0uY29tPg0KPiA+IFNp
Z25lZC1vZmYtYnk6IE9sZWtzaWkgTW9pc2llaWV2IDxvbGVrc2lpX21vaXNpZWlldkBlcGFtLmNv
bT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCj4gKC4u
LikNCj4gPiArI2lmZGVmIENPTkZJR19PRg0KPiA+ICsgICAgICAgLmR0X25vZGVfdG9fbWFwID0g
cGluY29uZl9nZW5lcmljX2R0X25vZGVfdG9fbWFwX2FsbCwNCj4gPiArICAgICAgIC5kdF9mcmVl
X21hcCA9IHBpbmNvbmZfZ2VuZXJpY19kdF9mcmVlX21hcCwgI2VuZGlmDQo+IA0KPiBUaGlzIGxv
b2tzIGxpa2Ugd2l0aCAhT0YgdGhlIGRyaXZlciBiZWNvbWVzIHByZXR0eSB1bnVzYWJsZSBkb2Vz
bid0IGl0Pw0KPiANCj4gU2hvdWxkIHdlIGp1c3QgZGVwZW5kIG9uIE9GIGluIEtjb25maWcgb3Ig
YXJlIHRoZXJlIGFscmVhZHkgcGxhbnMgZm9yIEFDUEkgb3INCj4gc2ltaWxhcj8NCg0KSSBub3Qg
aGF2ZSBwbGF0Zm9ybXMgdGhhdCBoYXMgQUNQSSBzdXBwb3J0LiBDcmlzdGlhbiwgU3VkZWVwIGRv
IHlvdSBoYXZlDQpwbGFucz8NCg0KSSBjb3VsZCBhZGQgZGVwZW5kcyBvbiBPRiBpbiBWNCwgc2lu
Y2UgY3VycmVudCBwYXRjaCB2ZXJzaW9uIGlzDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwv
MjAyNDAxMjEtcGluY3RybC1zY21pLXYzLTQtOGQ5NGJhNzlkY2E4QG54cC5jb20vDQoNCm9yIEkg
Y291bGQgdXNlIGEgZm9sbG93IHVwIHBhdGNoIGFmdGVyIFY0IHBhdGNoIDEtNCBhcHBsaWVkLg0K
DQpXb3VsZCB5b3UgQUNLIHRoZSBjdXJyZW50IFYzIHBhdGNoIG9yIHdhaXQgSSBhZGQgT0YgZGVw
ZW5kZW5jeT8NCg0KVGhhbmtzLA0KUGVuZy4NCg0KPiANCj4gWW91cnMsDQo+IExpbnVzIFdhbGxl
aWoNCg==

