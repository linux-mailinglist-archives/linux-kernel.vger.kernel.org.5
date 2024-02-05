Return-Path: <linux-kernel+bounces-52267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EABB3849615
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:12:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D00B1F22CE7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4C7125B3;
	Mon,  5 Feb 2024 09:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="NYgcllhd"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2049.outbound.protection.outlook.com [40.107.105.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C66D125A4;
	Mon,  5 Feb 2024 09:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707124299; cv=fail; b=mlSxltihRrnueR1sX16skw/KJ32Im4VL8i+7p1Wfy8dXTUK9D1ultLVakqokJw3InqmYALcPahK7rnZkUUpsxeF8lo5IioB5Ty9aABYIifh3hI6X3WhqYBLWPGB9bT1GWRHHd9me4KZnm7TbZqcHRWL+myjzcBRJJ/eTGKOnEw4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707124299; c=relaxed/simple;
	bh=gta1oeVfZV4uUpx7R2YddSf5Fl57u7vbhrOWaTMM1iQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=W63W9/0YzIxhbDmU+qRgc7Jh4LaZ+QIyx6wU4ucdIs5dgDbcxlCX5/pf/Uiczqkru7Yv6qeKgR7hl/Z1/skgm/6lPreVmjmwjkYAR3U5+o/+hroACv+SVLK4kqWVEj2ZKJ26JSKYOy3+wjf0Km5vZIEH4kOTaycpHmsy4b6Uvb4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=NYgcllhd; arc=fail smtp.client-ip=40.107.105.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ifgwXt7qSxfAihwJQI1xMUgkLbcAA/X5/RmtQCgaSQFVxBdksIZdszTc1EYz2jLzsy+Xxniz9oHUHwlhyXP5zozktxv2Og6c5Jo8ArkEj0CMIcbN5eJ5qvsMc4xZScPDvHdG1uKzKsinvmaBQ0EDyivb1Gh1ykGxcBZEgFvBh8gZrryefjJdY6WwLvk7m+t6sPx/ahJ3EKZIQxc/F17Ydy9mDv0haBWLFajQuLGE8CPK6vO/VJ/s1gSRVK+oJEVTrvsL7rA2yUbWC0YNhjsqIifYKpyH3prDur65S+yy6OgP+0wlaVC+0k5SK9khzv2meLQfQyAf0L+b4QA8Fz+O3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gta1oeVfZV4uUpx7R2YddSf5Fl57u7vbhrOWaTMM1iQ=;
 b=jIulqm+0+P0Say/Gn13RovtjNl8/thvgaIPhecAdKt7FeJ7DCgbSdqCpzAYyUYG6RV3b6bF9AbhG7tWUNCEZIkK6e+e5JWLSv5jybUEtZkgOzHWO/lUMnqD0x8gHNMeTxrdgA4KG0fi19fBQMvlYEPZD1WBUec7/XniNPS8fRaGdWAbX+uX8p9ENi82dq7J8JbBN4kq+Zl1ncQUeWm3zDXH4HCh+rfjWSREYUQtrdBnrlUiesR2HYzfAlZF6qDth9Jcf4WoUM/FDmBSMab57X5GN7Ayi1payvedmvgjJqFCuOYLRSfBSvHHproHas+UFzlsiWlp/Sy3DjX2f2RtPIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gta1oeVfZV4uUpx7R2YddSf5Fl57u7vbhrOWaTMM1iQ=;
 b=NYgcllhdFzubDeLov9wPZa2D6yMfV9lqiME9pAUQT7/LA8jLF+2EVVJMfRwvUBliIcqGPVDHts0z8V0X2tncKBtujmbBlefhQCxGiMo9naXWmPQw6i1lvyPi0xbv87zLddaa82FOTXCs0lrJ680hkOh5JJy5eI3zZqi4UgAxERQ=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB9PR04MB9674.eurprd04.prod.outlook.com (2603:10a6:10:306::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34; Mon, 5 Feb
 2024 09:11:34 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6%3]) with mapi id 15.20.7249.032; Mon, 5 Feb 2024
 09:11:33 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Linus Walleij <linus.walleij@linaro.org>
CC: Cristian Marussi <cristian.marussi@arm.com>, Sudeep Holla
	<sudeep.holla@arm.com>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	"souvik.chakravarty@arm.com" <Souvik.Chakravarty@arm.com>, Rob Herring
	<robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Oleksii Moisieiev <oleksii_moisieiev@epam.com>, Shawn Guo
	<shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
	dl-linux-imx <linux-imx@nxp.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-gpio@vger.kernel.org"
	<linux-gpio@vger.kernel.org>, AKASHI Takahiro <takahiro.akashi@linaro.org>,
	Rob Herring <robh@kernel.org>, Nitin Garg <nitin.garg_3@nxp.com>
Subject: RE: [PATCH v3 0/6] firmware: arm_scmi: Add SCMI v3.2 pincontrol
 protocol basic support
Thread-Topic: [PATCH v3 0/6] firmware: arm_scmi: Add SCMI v3.2 pincontrol
 protocol basic support
Thread-Index:
 AQHaTFMXfSW/KLMkFECgD1P261LWWrDwxwIAgAAQxgCABEqJkIAARhUAgASMwWCAAKqegIAA6plQ
Date: Mon, 5 Feb 2024 09:11:33 +0000
Message-ID:
 <DU0PR04MB9417335A3A41BE4E373B915188472@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240121-pinctrl-scmi-v3-0-8d94ba79dca8@nxp.com>
 <f88d07ef-83b2-4d14-976a-6dbbd71e036f@oss.nxp.com>
 <CACRpkdYV=qYQ9qDUWYTLDAV1niay30gYH5S=zjfi31GpeY5o-A@mail.gmail.com>
 <DU0PR04MB9417A9074C5DC49AE689E65288432@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <Zbt-QkWhz5d9P-v6@pluto>
 <DU0PR04MB9417CA6CF089B264112C32A088402@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <CACRpkdYCrbNB8wu4rO3Yx0qomxR3kTt0P7YH7kc2HPCbrgt=tg@mail.gmail.com>
In-Reply-To:
 <CACRpkdYCrbNB8wu4rO3Yx0qomxR3kTt0P7YH7kc2HPCbrgt=tg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|DB9PR04MB9674:EE_
x-ms-office365-filtering-correlation-id: b9a17002-0945-4e16-1e83-08dc262a72f6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 i3T9vArM753OmasOdiL/S8pjeqFDASvLU48iBZB105JqtQoVJZmU2OMrOCDgRJ9hEouYS2/qHTJPBh1RkRCwILjdPJ4ugAKDX/DM1FuuRvis27FoA4Mp9THd1pBnSsoMMLQqbo8Z97gwq1Ennh4KmW1kBwQlVK8lctu+XtQqMMvwIp7mULthDEQfE2HgnVC8JloNBsVlQzA6v9fzJW2CgAoP5ZUpLeJZdiv27fjnatYBLzW0z7ldh5ssrHuyBEFh6qGBpzcxY2yKxThPGInJW4PVPh7+t0HGNMXYEyHPVn6fjiJ0v9etIvekWfCdp0N3H/454LzmNmYAhT/kO55pqnbx3cFrLqqy5xmILnUFRaxM0MoLkwUBLe3Q1TDYL8ZGzWdga4IUTrYddGvrxOtIQtKcLhZ9I8dA0afRfLaxh11BIbWjkxjDqPhuXq8klZEnyy7MmXQwc98jpV3zwe2xbRl76AgawAl3n//HXFmye4HHoZ4J3qmlhwxQ93ttjcJPUTi33oDyqhJGmgbUdwv9ypxoiXClCmvoe1Y1+hAgqVl4Wtq97pHDpnaoxGJVgn/QriUPCi0xXdlAu+FXzKIHTvRwTLQR0HyRHt+GV193tHg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(396003)(376002)(136003)(39860400002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(83380400001)(66556008)(38100700002)(8936002)(122000001)(4326008)(966005)(45080400002)(478600001)(8676002)(64756008)(66446008)(54906003)(66476007)(6916009)(66946007)(52536014)(76116006)(316002)(5660300002)(7416002)(2906002)(71200400001)(6506007)(44832011)(26005)(9686003)(53546011)(7696005)(38070700009)(33656002)(86362001)(41300700001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SVdSK3ZTb2VoNzNWZllFMzhnWkJrcU5ydCs3WWJ6NER1WXZiMHp2UDZZdGJE?=
 =?utf-8?B?eVpnUE00NllCKzF3ZW9md1lad3RLcVl2RitUcDNZT1JITlRDTzkrT0tsSUNw?=
 =?utf-8?B?Q0pFMEhCeE54RXZqWFUvUVJGdUpXZWs3bkR4Si9WNVFIVHBmYjZRMlIxZ21R?=
 =?utf-8?B?Sk56UlJ4cTU5ZVFyaSs0SFoyY2gzRWZjVkxKeXJnYm1STEcrVHdselNnQlVi?=
 =?utf-8?B?VTFIZWZmZXREN1RGQ00zYXdPL2FLeW14a0xQdTdWd1RoMDZldDRFZTRiUDBZ?=
 =?utf-8?B?d2pnRUFxOWE4YlVjcmZkb3UvelhrVEdCbnR2WTVJMStCc1VDeFJRNXBsT3cr?=
 =?utf-8?B?Mzkvb0wzN1hSM2Zyd3FkS1FRN05QdnRFQXcrc0dPNFZsb1hYWm4vZmxoYmJi?=
 =?utf-8?B?YU9XZ2lDU0RySUVrS0VOT0RLL3B4VzE3dStPRmdYSkp2dHhpZDdtdFlaRWJp?=
 =?utf-8?B?ci9uVVBzd1RzWjBjUTRVVk4yb2UxUWNSdGpHVTBIbFVYbWczbHZkSkI5b1JF?=
 =?utf-8?B?NW14NkZ0Rkt4T0RZZWZkZDlpTXhDaDBKZ0g5aUpCam9uYWthN29mck9FNFV1?=
 =?utf-8?B?WXRhYnRHNGY5alNJd0FJWnA5S1lsVlZOTlNKUmc0RllodS83bjZScmhtWG91?=
 =?utf-8?B?OXRsZGJoQWlXRU54RWNOZVZ1WjYxK2x4ZDJZeUZaMTVMSGp5eU9kWStTUGZw?=
 =?utf-8?B?RkhJUEtBQkhxR044MkZrZHVFNmJkaFhUSDdwdXU0T05PTkFhd2FvWVJVSGZC?=
 =?utf-8?B?MHJHc1BSZDJxUy9saERxRmFiTDNWWTBuMk8zSzlHZk9RcHJ3YjM3bE04VGFl?=
 =?utf-8?B?QXVKb2puV1JBcnBCNXVaUDRoT3RST2dxaVZxbk9QQ2oxdktPNlBMcjVHaVNC?=
 =?utf-8?B?dm9Gd3RJaXpsMFc3UU1qU09QT2FlaTJ5Skg0U21FbnhPT2dUYXBoZG1STnNC?=
 =?utf-8?B?d2JNemUzdUpsRVBoaWNsaHp1dzJPaFNEU3JKTjNYcXNyaE5iS01tU2k1Mldh?=
 =?utf-8?B?QkJKL0kvekJ1YzNSQjA0WkxyRkgzREFvaFdhendJdmpWMGJ5NGloQStwdCt6?=
 =?utf-8?B?b2NLbnN6Z1dJZGtqUkg3N3pQRjRsaDI3UzdhT3lvSWo3UUZzNmxKUW5pcVRL?=
 =?utf-8?B?OEhEc2pqOTM1bC8xcEZyTnptaVZoZDBxbGdyREw4NFJFbC9Hc0Rsd29MNWVS?=
 =?utf-8?B?TTU0VTNhNzZIM3dMTWoya0paOXFYSHppU2RRa1ZrS3lnT0NxY2tMdVpBKytV?=
 =?utf-8?B?K1JLL2F2QVkwZ0RDWnE4L0QyUVBkWDRPUW83RE5DZzRoZXhYYmVNUmg1aDEw?=
 =?utf-8?B?WW81dTdLb2xMUGV5WjRDVlpZSS8xaG1WTURZLzVyc1YrNXF0WThLN3dyZVJ1?=
 =?utf-8?B?REpYRFh4Yi90UE5uaW1zaCtGc1JJOXF1MXc2SHJxYkFYMHZWc0Zhak55SnZ6?=
 =?utf-8?B?cUZOWHgyVXp4RDRDejc1N245WjlGNHIyYlNIem9OU0NoNUxVYnVsRWNHNTRM?=
 =?utf-8?B?TThTdzUxYzFrVnVtMlNXMS9kZHpCOWtTcklCMTg2MHBKb3Jyd2RYM2hvTFNs?=
 =?utf-8?B?UHhRSTgyMkZaQzZ2YW1MWnkzQ1pjTHE3ZWs4WmEwQWpUekg1NXpzZzNDOU9W?=
 =?utf-8?B?dDF0V3RRbENOVS9qQjhzZ3NhcWR1bExDc2ZPSFlWbVkzQ2tIdG84QjFsR1hW?=
 =?utf-8?B?TVBhTnRjQ0djaUVhbjJvUUdwWHFFRERodzhPVEswWmdLMUV5eHhjb0RwaWNk?=
 =?utf-8?B?cUNsWTM2Ri84dmJSVnN6emh0RVVNYjVzNkVaSkJ0UVViTlFqcUpUK2VKeDAz?=
 =?utf-8?B?SVhIRWowaWZ0ZHZJSG1ibzJ0NXh0Skk4MU9uUHJsd2FKVkZDekUwSnVQKzd0?=
 =?utf-8?B?ME9uZ0RMeGxhT3ZDV2gwWmEzSi9kbGowc0IzMnp0eFU2b2lielZ2SWJKNll2?=
 =?utf-8?B?WGxINDJOTnJiNGVkWTZ4Si9JemFMdUsySExBVmhGRUtiYUZhWm9oaTlqNnk4?=
 =?utf-8?B?NFNvWUo0eE1ISTc0SVFRdXJoWmZwWU9zeXMwUmRsMVNFMDRpZTdldmpaZzRD?=
 =?utf-8?B?RmNhdXZmeUFJalVaanRSNG52SXA0VHZUbEp1RjBFck1CSGF4bnl4MTk3Uk43?=
 =?utf-8?Q?RRSA=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b9a17002-0945-4e16-1e83-08dc262a72f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2024 09:11:33.8409
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TV3slXMs+K3IOoasRqv+XPfm02KURapQTSeKmGi1hm+gDMyls6SsxxvJrli/uVT+rTFuo/YXXl3ZaUQDJbDe0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9674

PiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDAvNl0gZmlybXdhcmU6IGFybV9zY21pOiBBZGQgU0NN
SSB2My4yIHBpbmNvbnRyb2wNCj4gcHJvdG9jb2wgYmFzaWMgc3VwcG9ydA0KPg0KPiBPbiBTdW4s
IEZlYiA0LCAyMDI0IGF0IDEwOjI54oCvQU0gUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+IHdy
b3RlOg0KPg0KPiA+IFVzaW5nIGdlbmVyaWMgcGluY29uZiBtZWFucyB0aGUgZmlybXdhcmUgbmVl
ZHMgZXhwb3J0aW5nDQo+ID4gZ3JvdXBzL2Z1bmN0aW9ucy9waW5zIGFuZCBldGMsIHRoZSBmaXJt
d2FyZSBkZXNpZ24gd2lsbCBiZSBjb21wbGljYXRlZCBhbmQNCj4gY29kZSBzaXplIGVubGFyZ2Vk
Lg0KPg0KPiBUaGlzIGlzIHZlcnkgbXVjaCB0byB0aGUgY29yZSBvZiB0aGUgcHJvYmxlbSBpc24n
dCBpdD8NCg0KWWVzLiBDb2RlIHNpemUgc2hvdWxkIGJlIGFzIHNtYWxsIGFzIHBvc3NpYmxlLg0K
DQpBbmQgdXNpbmcgU0NNSSBnZW5lcmljIHBpbmNvbmYsIHRoZXJlIHdpbGwgYmUgbXVsdGlwbGUN
ClNDTUkgY2FsbHMobm90IE1NSU8gYWNjZXNzKSwgc3VjaCBhcyBzZXR0aW5nIG11eChvcHMtPnNl
dF9tdXgpDQpuZWVkcyBhbiBTQ01JIGNhbGwsIHBhZCBzZXR0aW5ncyhvcHMtPnBpbl9jb25maWdf
c2V0KSBuZWVkcyBhbiBTQ01JIGNhbGwuDQpBbmQgbWF5YmUgb3BzLT5nZXRfZnVuY3Rpb25fbmFt
ZSAgbmVlZHMgYW4gZXh0cmEgU0NNSSBjYWxsLg0KDQpXaXRoIGN1cnJlbnQgaS5NWCBkZXNpZ24s
IG9ubHkgb25lIFNDTUkgY2FsbCBpcyB1c2VkLCB3aGljaA0KdXNlIGxlc3MgdGltZS4NCg0KPg0K
PiBTbyB0aGUgYXJndW1lbnQgaXMgdG8gc2F2ZSBjb2RlIGVmZm9ydCBhbmQgc2l6ZSBpbiB0aGUg
ZmlybXdhcmUuDQo+DQo+IFRoaXMgcmVmbGVjdHMgc29tZSBvZiB0aGUgcmVhc29uaW5nIGJlaGlu
ZCB0aGUgZGV2aWNlIHRyZWUgYmluZGluZ3MgdGhhdA0KPiBlbmNvZGUgIm1hZ2ljIG51bWJlcnMi
IGluIHRoZSBEVCBub2RlcyB0byBtdXggYW5kIGNvbmZpZ3VyZSBwaW5zLiBPZnRlbg0KPiB0aGUg
YXJndW1lbnQgaXMgdGhhdCBpdCBzYXZlcyBzcGFjZSBhbmQgZWZmb3J0Lg0KPg0KPiBXaGVuIHRo
ZSBpLk1YIGRyaXZlciB3YXMgZmlyc3QgZGlzY3Vzc2VkIGl0IHVzZWQgdGhlIHN0YW5kYXJkIHNj
aGVtZSBhY3R1YWxseS4NCj4gTG9vayBhdCBpLk1YIDUzIGZvciBleGFtcGxlOg0KPiBodHRwczov
L2xvcmUua2UvDQo+IHJuZWwub3JnJTJGbGludXgta2VybmVsJTJGMTMyMjk5OTM4NC03ODg2LTIt
Z2l0LXNlbmQtZW1haWwtDQo+IGIyOTM5NiU0MGZyZWVzY2FsZS5jb20lMkYmZGF0YT0wNSU3QzAy
JTdDcGVuZy5mYW4lNDBueHAuY29tJTdDDQo+IGRiMDYwNGIxMzY2MzQ2YTBkYTExMDhkYzI1YjM2
MDdkJTdDNjg2ZWExZDNiYzJiNGM2ZmE5MmNkOTljNWMzDQo+IDAxNjM1JTdDMCU3QzAlN0M2Mzg0
MjY2OTk1NTE4NDgwNzYlN0NVbmtub3duJTdDVFdGcGJHWnNiMw0KPiBkOGV5SldJam9pTUM0d0xq
QXdNREFpTENKUUlqb2lWMmx1TXpJaUxDSkJUaUk2SWsxaGFXd2lMQ0pYVkNJNk1uMA0KPiAlM0Ql
N0MwJTdDJTdDJTdDJnNkYXRhPWolMkZBJTJCYWdvTDJFWFV6RFNrZzF3dFNFTlBrdXhiMFlMMQ0K
PiBuVFRCN3hDSUJURSUzRCZyZXNlcnZlZD0wDQo+DQo+IEdyb3VwcyBhbmQgZnVuY3Rpb25zISBB
cyBzdHJpbmdzIQ0KPg0KPiBUaGVuIHRoZSBEVCBiaW5kaW5ncyB3ZXJlIGRpc2N1c3NlZCBiYWNr
IGFuZCBmb3J0aCBiZXR3ZWVuIERvbmcgQWlzaGVuZw0KPiAodGhlIG9yaWdpbmFsIGRyaXZlciBh
dXRob3IpLCBTYXNoYSBIYXVlciBhbmQgU2hhd24gR3VvIGJlZm9yZSBhcnJpdmluZyBhdA0KPiB0
aGUgZnNsLHBpbnMgc2NoZW1lLg0KPg0KPiBCYWNrIGluIHRoZSBkYXkgSSB3YXMgcHJldHR5IG11
Y2ggY2x1ZWxlc3MgYWJvdXQgZGV2aWNlIHRyZWUgYW5kIHJlbGllZCBvbg0KPiBvdGhlcnMgdG8g
cmV2aWV3IHRoZSBiaW5kaW5ncywgd2hpY2ggZW5kZWQgdXAgbGlrZSB0aGlzOg0KPiBEb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGluY3RybC9mc2wsaW14LXBpbmN0cmwudHh0DQo+
DQo+IFRoaXMgd2FzIGluIDIwMTEvMjAxMiBzbyBtYW55IHRoaW5ncyB3ZXJlIG5vdCBjb25zaWRl
cmVkLiBJdCBpcyBjbGVhciB0aGF0DQo+IHRoaXMgc2NoZW1lIHdpdGggYSBudW1iZXIgb2YgaW50
ZWdlcnMgdGhhdCBnZXQgcG9rZWQgaW50byByZWdpc3RlcnMgaXMNCj4gY29udmVuaWVudCBmb3Ig
c29tZSBEVCBhdXRob3JzLCBhbHNvIHBpbmN0cmwtc2luZ2xlIHVzZXMgdGhpcyBhcyB3ZWxsIGFz
IEkgdGhpbmsNCj4gTWVkaWF0ZWsgYW5kIG1heWJlIGEgZmV3IG90aGVycy4NCj4NCj4gT3ZlciB0
aGUgeWVhcnMgSSBoYXZlIGNvbWUgdG8gcmVncmV0IGl0IGEgYml0LCBJIHRoaW5rIGluc2lzdGlu
ZyBvbiBncm91cHMgYW5kDQo+IGZ1bmN0aW9ucyBhcyBzdHJpbmdzIGlzIGJldHRlciBmb3IgYWJz
dHJhY3Rpb24uIEFuZCB0aGUgcG9pbnQgb2YgZmlybXdhcmUgaXMgdG8NCj4gYWJzdHJhY3QgdGhp
bmdzIHNvIHRoZXkgd29yayB0aGUgc2FtZSBvbiBhbGwgc3lzdGVtcy4NCg0KV2l0aCBjdXJyZW50
Og0KICAgICAgICBwaW5jdHJsX3VhcnQxOiB1YXJ0MWdycCB7DQogICAgICAgICAgICAgICAgZnNs
LHBpbnMgPSA8DQogICAgICAgICAgICAgICAgICAgICAgICBJTVg5NV9QQURfVUFSVDFfUlhEX19B
T05NSVhfVE9QX0xQVUFSVDFfUlggICAgICAweDMxZQ0KICAgICAgICAgICAgICAgICAgICAgICAg
SU1YOTVfUEFEX1VBUlQxX1RYRF9fQU9OTUlYX1RPUF9MUFVBUlQxX1RYICAgICAgMHgzMWUNCiAg
ICAgICAgICAgICAgICA+Ow0KICAgICAgICB9Ow0KDQpJdCBpcyB2ZXJ5IGVhc3kgZm9yIHBlb3Bs
ZSB0byBrbm93IHRoZSBtZWFuaW5nIGZyb20gcmVhZGluZyByZWZlcmVuY2UgbWFudWFsLg0KDQpJ
ZiB1c2luZyBnZW5lcmljIHBpbmNvbmYsIHRoZSBkdCBub2RlIHdpbGwgYmUgbGlrZQ0KVWFydGdy
cCB7DQogICAgICAgIHBpbnMgPSAidWFydDF0eGQiLCAidWFydDFyeGQiOw0KICAgICAgICBmdW5j
dGlvbnMgPSAidWFydDEiOw0KICAgICAgICBiaWFzLXh4DQogICAgICAgIGRyaXZlLXN0cmVuZ3Ro
ID0NCn07DQoNClRoZSBmaXJtd2FyZSBuZWVkcyBhZGQgbW9yZSBjb2RlIHRvIGV4cG9ydCBmdW5j
dGlvbnMsIHBhY2sgdGhlIGNvbmYgc2V0dGluZ3MsDQplYWNoIHBpbnMgbmVlZHMgYSBmdW5jdGlv
biBuYW1lIHBlciBjdXJyZW50IGkuTVggSFcgbG9naWMuDQoNCkFuZCBhcyBJIHNhaWQgYWJvdmUs
IG1vcmUgU0NNSSBjYWxscyBuZWVkZWQgZm9yIGNvbmZpZ3VyZSBhIHBpbi4NCg0KU28gaXQgaXMg
bm90IGEgZ29vZCBmaXQgZm9yIGkuTVggcGxhdGZvcm0gdXNpbmcgU0NQIHByb2Nlc3NvciB0byB1
c2UgZ2VuZXJpYw0KcGluY29uZiBmb3IgU0NNSSBhcyBJIHRoaW5rLg0KDQpUaGFua3MsDQpQZW5n
Lg0KDQo+DQo+IFlvdXJzLA0KPiBMaW51cyBXYWxsZWlqDQo=

