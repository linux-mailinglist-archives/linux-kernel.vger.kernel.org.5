Return-Path: <linux-kernel+bounces-32282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB8E835964
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 03:34:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91D591C21972
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 02:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295FB139E;
	Mon, 22 Jan 2024 02:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="RXPsIMsO"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2069.outbound.protection.outlook.com [40.107.6.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A3C5227;
	Mon, 22 Jan 2024 02:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705890860; cv=fail; b=hiErEo9UqCImLPQ1eNJSxfOUAVLAY9TPDVfszZ8QDuZ5BMTRWuTveWe3misiKhBSJxIe+G0vzLkuFYE1VKeF+54dljWtYqmdzrVNfaTyAfSXmjmJWpmpztFgGT5jkBll77cTfs7jR1wYhQiET/vukucBJQXG6+XDgjhzR9RmlU4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705890860; c=relaxed/simple;
	bh=dAJG9F6N+77EAhizwf9VVr01ZyQvIMWHjmeanTzVoHg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bSmhvpo0lEaUIpHm8DjMO3VG/JpdA1myzTckn+fAnLpwR4v3Lt0aRcXiK5fr/mSHYzebnkJaWkwqb25fnUqPa2tJVs3B/xX+KC9cQG+HpjxELrOkV7LVQJmlxaZ1KLNsL9uHqpqcDm+JrazcfXiLF1NMaXaKtz4S+AhYcfCYMq4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=RXPsIMsO; arc=fail smtp.client-ip=40.107.6.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iYWdPbUrECWFkG7RCu/mu7fZlIlrRMCNCaKCemQPR/fpy+4398D9UqGVx/0IsBdQpkF/cl5SIVxzSG1aOZ3EK6rUu86F1pOiUBX8HXWSzMgekbCUt21mR9lr8J7joiEsfX0rPFbfnQAkVBQN3+S2+JOMXcbxt91iEVog63chaDd6UB4KaI4wXI6yiirPzha0lQ2ZggZBCEfNQ+BIRUxvM3cJdkWReD2At+Y55Eyf6WsRfJNkwWHmQWDP4SuyD4TH9WhtaJfr2ttyKECuFiGTI2uzDQ5VKjVfFrysYFgX0ef/m3paGWc14aUMxDyhgkSBBfR0cKsIBna7jl9LzbevoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dAJG9F6N+77EAhizwf9VVr01ZyQvIMWHjmeanTzVoHg=;
 b=cHj/b1Kd4ZHlHF7m5A4ogDCkJjo2d7Bsf2A5CIlt80X72Qdy2GH/AS2tSOi+OMuE2e619wRBsS9Wu/D7AbrcdflKq5mS77XFAKeAO8i4c4X4+DzdiiEo3rinGDoeVrhRZE/1eUOz/BaEvuHcky1OS+JvYOsewHTnv78PtNFgZSObpTwIUlysF3Jst/N5sYNRR5SEwjKFGjjbMXEPw+PQcF4kupFdiBcEoSHIizRKO2Bl6iXoC7r43iEAuTDTDcpw5mpojXz/oQI57kw1uZF6BKQjnv+t0y1JfBm4jcGiBQ5Rp8sjsy8R+9egn1BgNvzYY8MI7F9EocSZ7PWCCJKKsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dAJG9F6N+77EAhizwf9VVr01ZyQvIMWHjmeanTzVoHg=;
 b=RXPsIMsOXt3zVkx+vzlZy5T09aI8FM6g650YrE+iZAgakJOLDeudk/JlCTrEZ/z/kmVQ7eRFJ0+xWmsFFA4+s7Ph4kEq/rFCTu6c5WXIYxcFxOLuc/WiW39Gcv3oiJabRwydlg8lSt4/hoj36UBVbGJoXRtq9mXpjshiWwhk8zg=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR04MB9955.eurprd04.prod.outlook.com (2603:10a6:800:1e1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Mon, 22 Jan
 2024 02:34:15 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6%3]) with mapi id 15.20.7202.031; Mon, 22 Jan 2024
 02:34:14 +0000
From: Peng Fan <peng.fan@nxp.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, Jassi Brar
	<jassisinghbrar@gmail.com>, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, Aisheng Dong <aisheng.dong@nxp.com>, Shawn Guo
	<shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
	dl-linux-imx <linux-imx@nxp.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH 0/3] mailbox: imx: support i.MX95 ELE/V2X MU
Thread-Topic: [PATCH 0/3] mailbox: imx: support i.MX95 ELE/V2X MU
Thread-Index: AQHaTNb9Pt135qhzREKqv0ivU64j2bDlHUvQ
Date: Mon, 22 Jan 2024 02:34:14 +0000
Message-ID:
 <DU0PR04MB9417D4029E750EC84582018888752@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240122-imx-mailbox-v1-0-81413f655210@nxp.com>
In-Reply-To: <20240122-imx-mailbox-v1-0-81413f655210@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|VI1PR04MB9955:EE_
x-ms-office365-filtering-correlation-id: 9c5af475-b1ac-4161-d062-08dc1af2a008
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 0Y8ngB0f3QgXO6wGBqrPYkcg4WnNHKKqX1XlEMIy2KjysakO0QEGXpAFvIJEu8S0QvGgSQ1YvrKFixQTq+laTasUEr0Spxu6D5GF7P2Q3S9IVm2J8AdTyPUuzl2uAgL4ihj7SwCyPh/O/Phb7cNrVow0/gSlWYju3DDQW2kgZhnSWcjvvMA2HmlI6KMjQs56Z9MV4+UeYn1gHYhFLbXQAUzT2qwxZiKO/nqInFG/oKsI12Q0clqflOUxFgWugYOVpLwd25B/kiLfmmJ5Ec0UbPsDar6KjcgjISqetAJkdG6/gMDCDtDOD0bkw2hoEHIZAJ2cB+1EPOxuMVhPpTER/0jKeUmLudZfe6yjS2e8+6aOO7f4QtgPYuN0GWj7L2gheMc/DBhpvRVxWgq0HSMBimL/QhdssGuDR7ILGIuKCjDso2kQiAnLm6XGrGDm/BnePImL0HF4eVygTKBJaTE5BCCXIaNjxjiGCNIaejcsecK/ypF/wvxI8V+jW2OICQ06pYyesmijUu9fIESeFszVG88aWRjaFhBtWU/SCZ5XLUuvcxYf4Aj6JKc9X84Q4VOa3GkBKXrp2lvnyn5HDKvjmXyVV0FzWJOvxo5oZOqyx29QuACDhgR23HfBf3rs/frlGXvkmeBuFLh4tmatYOWqMg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(396003)(136003)(39850400004)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(33656002)(55016003)(86362001)(921011)(38070700009)(38100700002)(122000001)(26005)(83380400001)(110136005)(8676002)(52536014)(76116006)(8936002)(316002)(71200400001)(6506007)(7696005)(9686003)(66556008)(64756008)(66446008)(66476007)(66946007)(6636002)(54906003)(478600001)(4326008)(44832011)(5660300002)(7416002)(4744005)(2906002)(15650500001)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YWdjVFJOd2pOcUJiWDVTY0Q5OVNBQ3RiTHBOTHV3SGdNeHB2MGp3enUwOHJz?=
 =?utf-8?B?L3NoSVpKL1J4ZmRNZlM5Znl5bk9IOUFIUjVNZDVvOFlHOWxZZGNCNUFvK1F3?=
 =?utf-8?B?eU1kd0NRSUVLWmNqMHo2WjBVcysrTGdYaXNmcU5oZjVjM2loNXRXU3gxOTIx?=
 =?utf-8?B?cmsxTGVzcHR1NGptblE1R0xrMEdXNmkzUmN6emJyWk1XWWxSTFFKaUdTdndU?=
 =?utf-8?B?Uis4cUdGYmY4Z09hR0plT1E3aTBhSHl5ZW5mb3dzcForbUZXMkNkeUtvTFJa?=
 =?utf-8?B?UEsxWW1UUERXZHJueFlkZ3dIZmVzVXduOFpkY2NxeEFybEtuMWxKak1Fa0NZ?=
 =?utf-8?B?UHNsb0tKYzJiNTVrb2VHYUtldlpvRjRCcnYzK3h4bitiYjRKelpHNGFxZCs3?=
 =?utf-8?B?eHpUcGlPaGRaQjR2akdwU1k4VS9nRndvWm8zajRzVm5FWHFJekZXQmlIREhr?=
 =?utf-8?B?SHJrOEMvUU5QcGVhUFlUb3I0bW1IOTQwcnJUb0E0U3VjcHFoSTJLM0R2RFgr?=
 =?utf-8?B?b2Y1RzVGUHU0N1UvbnpObU5HZ3ZWaHZVZGRDMUdFSE5zVzk3SVFIQ1A2QmJu?=
 =?utf-8?B?TGJLUGsvU043RjRteEFwMU9STFNhQ3hGa0dnbGVLdEZib0N0V3JodjRhZG42?=
 =?utf-8?B?K2pDajVueDRhWWExZ3FFbkQxTzhJWU5icjhvLzhwZlFWWlNlYnpNTEI2NlVs?=
 =?utf-8?B?b1FrUi80RzJpRTZOQ1dERWdTYWVDNlhJbHRQb0grTEhNbE5sZG1TNjQwUEdN?=
 =?utf-8?B?OHg3RHMyMDhTcVp5Vm5YcTFCaU9ZNWFUS20vWURCK2JaL2JweitjeXdnNGpo?=
 =?utf-8?B?M1pzZTlMU0hvd0pHTVpsclpjRitjRy9JTjQvUlJ3aVk4S0d3NzNMSzZHZlJs?=
 =?utf-8?B?R0VrUFkxK3NhYUFmTGt2aHJSVWpISzQ5T0tEQ0tVeEcvZnhLS2o5T1NRVDVp?=
 =?utf-8?B?V01ROFluREJVTThGR3ZRTFh4djJiNzA4bmRvSmlkRGJCMXI4RVdpNVMzRi9P?=
 =?utf-8?B?Q2g5MHQwR2lBbm14RkpXdnhUK2tQbUY1TjBKNjRhUVV1RjlkV29jOTlaREJD?=
 =?utf-8?B?VUFzd3lnTUNSdERod2tVNGFoVXBxbzJhaldEOElvVmRDaW4zQnFvUlFCdXlD?=
 =?utf-8?B?TnJKbm51TUNMeXZLdFlwZC9aZlhMR2h1a0dKRVJHYXk0aStqZFIwc3BxMCs5?=
 =?utf-8?B?MVoybmc2Z2Mvay9TdStkVm1vQmNMc3JhNkVBeFJXT1k0Q0FzdHIxWFlGZWdE?=
 =?utf-8?B?QW9Jb21UQlBSbkovR3pxSERXckdNbUNRTGJwZk1YODRUaVBkMk1sT3NELytY?=
 =?utf-8?B?NmprM0xXUi9JblNhazVpUGg3VXFnSG5uMlk1TCtDYm5xQ1UxcUNsYzBIdzJO?=
 =?utf-8?B?bzZYREZEZnFMbWs1YzE2VFQ0d01ZVlc1L0hIeHdFQjVWaytlMTVoUk5Ec2dE?=
 =?utf-8?B?MGdwZCs0TmhHWEtLS0VuaHBoTzVwZ3k5bllLL2ZuRUNXTkYrQ0syaDhNMWJR?=
 =?utf-8?B?MjZHNTF5WmtWVnhOUUt3WFJJbDc3VGkvN2p5S2FjV1Vpb1ZqdXkyVVNYZGhy?=
 =?utf-8?B?eFNIQTMxakl1MEJ2NFVKUzY1Q2pxMWp0QXEzV2ZMQnJWNmFWcXZ0aXFQK0lr?=
 =?utf-8?B?OEdVV3dJV2hiTUFGeWdrR1QwSVVXQXFwMG9EYW1ab3VORVVBL0xRaEQrQUgr?=
 =?utf-8?B?YTlHMy9ManAwbXNKaHFkMDRmMHNhQzJrcGFsZmJWZGMyYUFUTWt1aU41L1BK?=
 =?utf-8?B?SVpOdEZCOThIS0tSOThvMWZFWXYyeGVraytRVHhGZ0dGSmUwZTdCVk55MXIw?=
 =?utf-8?B?RlpWckxwUzVZc3V4TEZvR0Z6K1B0UXM0UkFHTTJWM2E3N3dzTUZCRTZJYXpE?=
 =?utf-8?B?c0tBYXZjd1lNTnNHNmg0bHNpWVFkTHN2TkdkdUZUMExjRjhMem5OcUNTM3dN?=
 =?utf-8?B?NEgwRDZjbGxHWnloNDNYTU9jUE1BeWVrL1dtQW1QbVo5T0tsaDhGdFRiK3Vq?=
 =?utf-8?B?QTE5Sk9RUlRPUmZnczdSbUpYWHNoSzRaQndhdUQ0NHZaMEVLZXBFRCtPRjVh?=
 =?utf-8?B?UVNBOVJwTDNoL1AyRXhhdUZCVE5OSnQ2Skw3NmlWdXlLcktUU2lseXZGOE53?=
 =?utf-8?Q?wZt8=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c5af475-b1ac-4161-d062-08dc1af2a008
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2024 02:34:14.8849
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oIzC70em8HIx7nnE1/ek7w2BqwhgjYT9awX7YrW3w2E27MJnLPEgtspmLLPvgQC5vTor1js0aAhnOh8R90hDqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9955

U29ycnksIHBsZWFzZSBpZ25vcmUgdGhpcyBwYXRjaHNldCwgYnV0dG9uIHB1c2hlZCBlYXJseS4N
Cg0KVGhhbmtzLA0KUGVuZy4NCg0KPiBTdWJqZWN0OiBbUEFUQ0ggMC8zXSBtYWlsYm94OiBpbXg6
IHN1cHBvcnQgaS5NWDk1IEVMRS9WMlggTVUNCj4gDQo+IC0gQWRkIGR0LWJpbmRpbmdzDQo+IC0g
aS5NWDk1IEVMRS9WMlggdXNlIHNhbWUgcmVnaXN0ZXIgbGF5b3V0IGFzIGkuTVg4VUxQIFM0IE1V
LCBidXQNCj4gICB0aGUgVFIvUlIgbnVtIGlzIGRpZmZlcmVudC4gVG8gbWFrZSBjb2RlIHJldXNh
YmxlIGFuZCBub3QgYWRkIHRvbyBtdWNoDQo+ICAgbWFjcm9zLCBhZGQgcnVudGltZSBkZXRlY3Qg
bnVtYmVyIG9mIFRSIGFuZCBSUiBieSByZWFkaW5nIFBBUl9PRkYNCj4gICByZWdpc3RlcnMuDQo+
IC0gQWRkIGkuTVg5NSBFTEUvVjJYIE1VIGVudHJ5IGluIGRyaXZlcg0KPiANCj4gU2lnbmVkLW9m
Zi1ieTogUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+DQo+IC0tLQ0KPiBQZW5nIEZhbiAoMyk6
DQo+ICAgICAgIGR0LWJpbmRpbmdzOiBtYWlsYm94OiBmc2wsbXU6IGFkZCBpLk1YOTUgR2VuZXJp
Yy9FTEUvVjJYIE1VIGNvbXBhdGlibGUNCj4gICAgICAgbWFpbGJveDogaW14OiBnZXQgUlIvVFIg
cmVnaXN0ZXJzIG51bSBmcm9tIFBhcmFtZXRlciByZWdpc3Rlcg0KPiAgICAgICBtYWlsYm94OiBp
bXg6IHN1cHBvcnQgaS5NWDk1IEVMRS9WMlggTVUNCj4gDQo+ICAuLi4vZGV2aWNldHJlZS9iaW5k
aW5ncy9tYWlsYm94L2ZzbCxtdS55YW1sICAgICAgICB8ICA4ICsrKy0NCj4gIGRyaXZlcnMvbWFp
bGJveC9pbXgtbWFpbGJveC5jICAgICAgICAgICAgICAgICAgICAgIHwgNDggKysrKysrKysrKysr
KysrKystLS0tLQ0KPiAgMiBmaWxlcyBjaGFuZ2VkLCA0MyBpbnNlcnRpb25zKCspLCAxMyBkZWxl
dGlvbnMoLSkNCj4gLS0tDQo+IGJhc2UtY29tbWl0OiBhZDVjNjBkNjYwMTZlNTQ0YzUxZWQ5ODYz
NWE3NDA3M2Y3NjFmNDVkDQo+IGNoYW5nZS1pZDogMjAyNDAxMjItaW14LW1haWxib3gtMjQzMDIx
ZDEyMDMwDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IC0tDQo+IFBlbmcgRmFuIDxwZW5nLmZhbkBu
eHAuY29tPg0KDQo=

