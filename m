Return-Path: <linux-kernel+bounces-74265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4881985D1D1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 08:53:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA19D28798A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 07:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA013BB20;
	Wed, 21 Feb 2024 07:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="S8YZPIz4"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2070.outbound.protection.outlook.com [40.107.6.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E643AC24;
	Wed, 21 Feb 2024 07:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708502013; cv=fail; b=If+9SaB0d8i3tugaCkAFZnixZZwZj8/8vS1GRIAG4Li/MzwsT8JG1hiffDtXx7Qca3aeSc991a5He9QVvkbjpuJN/LIPnzqFt2rRJpTuoqZrqePT65JRIvhA5R8PLbMuxDJ7Eeo6HVJujl9T6OT6wdJVBxuKO/u4dboRsS4Kck4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708502013; c=relaxed/simple;
	bh=23eVCG9afhN42V/1s1DwQHWeIQQ8JNjI9yTUEJdYZ3I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QRHmLCghVtKPGhwdRIGmwS2crbhWU5wu/0G5/XUlKS+aaI4sY9Y5CxxdttCaM2vL9sZ4lTvi5iaLvPOh/OLHKjApI6am4ACPcjUfXeM+U32ohURSG3hQbQmYlmH/mToNy8UUG6yvMjcvX4iGAIpFl/2D4f4QiYWtl0SER0ELVNY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=S8YZPIz4; arc=fail smtp.client-ip=40.107.6.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QM0310SxoA3O8cBCFa3VIfS21Z9jX6TGWSS1nPwWfOXcuiP+L+FAv0t+Vm906wFZGk8lJKQ3Os5NZOH/4PmaHqnShel6SN86YMLcy0hqG87gevSDmauS/U9wKXzDDgqX3Ds/0rw1Y9K8ZZReSJKWOi7y05fTwNbocDTe42xNF5kogQ+Pw4vXc1iz1eux3LfzvzsTi77DV4HbUl1LIwYGf+J3dAkFjZXOdRjYAzK7Gbwfyp+xFsy0kZ5dqStEINOgPjXP7PzHJGUZEhnCXvoHnGr8UfHNU9MTK8g/+RsSZWvwFUhFwc2pIOCNXQOnhUPQqeVBGGuNAoXsOEomf1Byvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=23eVCG9afhN42V/1s1DwQHWeIQQ8JNjI9yTUEJdYZ3I=;
 b=UG6L4qAOvQh2Pc5+Q9gpVb8/BwcsVGj6q06ahcada5/0EozF2aaEuEV6jnGLkeQeHFLiPRz+nkMKRdvv9SPnr+Bpr/u6OOdDCI5bzKs24vjT7TUvz8CLmPkFKz6Ud5K43Kv9aWud+jbul2PPOKXuU8vfsr1Ntw6beJs65O+75Q7aZF2Nvf7IRYBD6cikH/00vBDj8ONcgdlU6d2797dI5Bwq31kiO2lbr64Mf8FZRT28HLIpl93rHSQzdnC4Dcyb4rqSpsnuBmZrcQiHAVu42PC2yHS3FIkmy82rDYNgzklAr9CCxzjLXXSWce8MY+Sas9/UqcK3bHEFc4EEBdJeTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=23eVCG9afhN42V/1s1DwQHWeIQQ8JNjI9yTUEJdYZ3I=;
 b=S8YZPIz44fPp5DuQb/dMK1nxdBkBv31SCN5w2zmY1JDmW1zzu2v06Xiu5YyioZRgxEqTTveDkX5o3BfHiVGuZTQ1cwhe4jNWnQWQqsbl6KYOkXCH4nL/PYJRJSnuEE9yGM+5pQIckRdWNPGv6PICVACg01jPTcP7jz8n7txUm08=
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by PAXPR04MB8111.eurprd04.prod.outlook.com (2603:10a6:102:1c7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38; Wed, 21 Feb
 2024 07:53:28 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0%7]) with mapi id 15.20.7292.029; Wed, 21 Feb 2024
 07:53:28 +0000
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
Subject: RE: [EXT] Re: [PATCH v6 1/9] dt-bindings: usb: usbmisc-imx: add
 fsl,imx8ulp-usbmisc compatible
Thread-Topic: [EXT] Re: [PATCH v6 1/9] dt-bindings: usb: usbmisc-imx: add
 fsl,imx8ulp-usbmisc compatible
Thread-Index: AQHaZJJpPKAscrea5Uu9VJoOg9C5drEUZhGAgAAGKXA=
Date: Wed, 21 Feb 2024 07:53:28 +0000
Message-ID:
 <DU2PR04MB8822148AA2FE199AF64527738C572@DU2PR04MB8822.eurprd04.prod.outlook.com>
References: <20240221145846.1611627-1-xu.yang_2@nxp.com>
 <214c03b8-7c5d-45db-8f14-c144751dd819@linaro.org>
In-Reply-To: <214c03b8-7c5d-45db-8f14-c144751dd819@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8822:EE_|PAXPR04MB8111:EE_
x-ms-office365-filtering-correlation-id: aa72f1cb-2bb1-4e56-b0da-08dc32b23105
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 HStdBsp7oiK8PKztFl1Wn9F4559CLjz9pcgBI1vUcdWQVMK1o5KQHqala4mIR8zPncROvj2Vp4Ng2OlvwCsv60cnw/5A2xGnrWmCKKy4eyeNwCc7O2jEXbGX2ZxqyHqfxFt3EV1QSk9nf7V9wAZwEfiHfJZMkBlPOqNQMpY/+bk2IewVktgWunODWFy9O5KfhwpCM15UB59nkmqTauAvNqtpz7PFSMvV1je7zma0VyE7MXstuNe2D/Lt7V2KT89xJRy7hKiV6ukvHmxikZTvtruA/c31Gp1JWiQxjF08N/Ll3xfwrg/v+s4rIi7w8rBMnBN4Hx8DXc/59sCIdsGF8h/dQ93zXNd7y2M86BkL+l9UVv9qAmvP8JuGSZ/4AtQtj+P+g0bcwnyODTNX2g81LBcKfqEEmN0RVyp4SuDEBhrAkCon+dV/ipdi2CQ3phJw84GK2DmydwvnFyTujdCSxOhzWcM2CZn+K3vUVHWk98gV3rFlWtkT/t32o7oR1Mn7K0uxD4/rF+gpTqzJhk/7ALFfJQ43O37mBzK5bWj8wnS/JWW+Gl6Jf5WoOgXFeBQ3C4g6rRmspBJn27sS7J/+ifePrZzdq2jzQH0OlU++Ki+Yan4Jvi+e9qUh8roQYkwh
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Mm9Ic1RCdHRuNmF6dmFSTDZNeGIyRTZtR0tIaVI3Qkl5NWZmR2N2REV2RlVl?=
 =?utf-8?B?dUVxalRvK2JFOVBxOW90d3JYSWd1NFoyNXcyWWRvSXFlb3pPaFI0cjB2Z0t5?=
 =?utf-8?B?dktOcGtjVDBMejRialArTnZvdjhhS0V1UDh6Q0FteVpGbmRxRitoa1NkZDRU?=
 =?utf-8?B?YThvVGg0RlVjRXFMYTB1WGdCSGtxUHAvbTJTRmUyQ3FVQkc0QVNLQjNmdzUw?=
 =?utf-8?B?ZHZXVk5xTUF6MTFGcEExdmd4bTJDdW4wUEx6VlZLaHRTNmV1Sm1KamltM2hh?=
 =?utf-8?B?SzIyUkhaVVNXK3htM21BM0lUSTBwNHFwR1BlWkdpZ0czWkt3U1Q2L2xoQWhN?=
 =?utf-8?B?K3FCd3JBa1o0K1NtYnNDS1p4Qk8zMWhRNEdrU0RrT0VVUUNGbDFVd01PWXpY?=
 =?utf-8?B?d2svMnhzdVhEYU1jQlF5UjdwYXF4UzNuc1dGdUJRU3hiNGo3SHJlUldBcURU?=
 =?utf-8?B?MExrUUVJYUpMblpTcnBSQWxvRWFEK1N1cFdOSnRQUkJHd0JaS29GZ3p5aFZY?=
 =?utf-8?B?cEZ2TVJ5cU5mNlhjQVFMdzJWeTBTMjJNampReDV5QjgwMGN3WVJvcnlvZTl3?=
 =?utf-8?B?VDZmRGxsemd3bG1IQnJvcC9DVnZhUjZCVnk4bWVYV05Kb3F1b0M2b0hOV3hH?=
 =?utf-8?B?cHpsa01TSVl4dG9kOWpEWnc1Q0xnV1kxaVZiUlV3bStacTZDdzE0aGhoM2NX?=
 =?utf-8?B?a0x0eHlBaFJwck14K056bHAzNE1ieTFjL2c0SWdqOTJNZTF5ZUFuWm8wcHc0?=
 =?utf-8?B?VGNoV0JrT1BLVDIvRGlXYjRQd0xBaUNiWTdBS24yemc0SHR2Z2hVait2N1pR?=
 =?utf-8?B?UEY3a0p4eHJmYndhTHZFcjk4RmIxOEtIWUZmNnJZOVZBNmlya0kxVnMxOW4v?=
 =?utf-8?B?SlVwWTFUQzJLaGxWaCtKMmYvZWhRL1hZL24xV0VuS0UwakdpOUpRUThDdERI?=
 =?utf-8?B?cmFKSTJEQ01wL2xGZ09uVEVYQ1ptMElNWlNJMkJ2dXQzUnlnaUpLWVBNSXhq?=
 =?utf-8?B?ZE10QTd3eDNpRUoyOHA2K0VIUjBlaDFzZEFBQnZYeVlCd2hQamd4L0FvdlZn?=
 =?utf-8?B?V1JlbVF3TGdZcU9MYUNrRkkrNzZsWnA5S01HMWp5aVFJYmFkMko5T3RXQXNY?=
 =?utf-8?B?Yk1WYzFsYTEyS0thbUtUUERUa2hNY2ZtT0VaekRMSGR3Z3ZJNXZSTi9ua3lV?=
 =?utf-8?B?elE0cUF4bFg4eXJYMGtKRGtRaXFCVldCUlBpUlNHNHUrNG5RZjh4cmVibzFm?=
 =?utf-8?B?cDhKOEljZUY3cmhJblhKVTZzdjVHMVd5bkk2eGpuM21GNXY5Y0lXTFlpVlFy?=
 =?utf-8?B?WWw0OVZmU3pGWFY4UUxpSFRLV3VJOUpqdzZhSmFCcDJJeVo5c294TnRFeGc0?=
 =?utf-8?B?ZHlLU2JOK05Lbk4wL3RUSmZxRUpmOW1saldmb01uQVpaWC95anhxMDhwMmUy?=
 =?utf-8?B?bUFYN1VpREVKZXNrSzNWYTV3d1hhNjlYUms3Rzd2S2lrcVJTb1pRWWNjWUZs?=
 =?utf-8?B?QWZGRTI2N2NpZmMvOGc0ZFJVeWJxR253cVI2V2FydVdodUdGV05IU3J6NDZ6?=
 =?utf-8?B?MStkaUhuTEFhVU9xUWM5clVrQ3RRREFHWG5tN2Y5QmUwNHdoSnQyM2luQVlv?=
 =?utf-8?B?WHd0dkRxemxLZjV1akNIdUpsbUVYZ2NSUUhIUlRLMm5tZGxFRnd5ZEJHams0?=
 =?utf-8?B?WlRLMjA1bnJTWU52WjV6WXRIdGVhUVlrT0s0bS9qWGYyV2FUaEVzeW1lZC9Q?=
 =?utf-8?B?ZDJGQWV2eTdMV05ZVDltRGtxQXY5U3lWcnloMG5xZmZyaG5GQkJNK3Jtejly?=
 =?utf-8?B?azBhQjNxa2dhNW9SZU5jU1Vubm8wNnpCSVRJL3JQcDNWRnlaTktVY0UzWlIv?=
 =?utf-8?B?QWNQS3B0VmJ5V0VsZEUyRU05dHI2eFVuOHlyNTU5R1dZZm9DSkZ5OXJoMGYv?=
 =?utf-8?B?YktRVnkzNS94WWo5UmxEYjhGclFEY1lvaUV5VHVTVXhsTjVZbS9ndmdER3c5?=
 =?utf-8?B?YWxiOXBUU25hRnRaeDd3SXZmKytjZW91elBmdTNxOWY2SjhZSnVIOXJsQTVj?=
 =?utf-8?B?ZmpUREo5REFaSDRvR0VtekZ2UHN2ck1iTlorY05IT2RrbjJHQi9MSkdUSHEw?=
 =?utf-8?Q?e1Ok=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: aa72f1cb-2bb1-4e56-b0da-08dc32b23105
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2024 07:53:28.7333
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GDRjRfvFtq06J0WRQ+OzjC6gBz64f6qc+ycqpalvcmX9BfOzjZFZXYXyHhD31XrJSZF5JQUpRr4C2VOa5HJzpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8111

DQo+IA0KPiBPbiAyMS8wMi8yMDI0IDE1OjU4LCBYdSBZYW5nIHdyb3RlOg0KPiA+IEFkZCAiZnNs
LGlteDh1bHAtdXNibWlzYyIgY29tcGF0aWJsZS4NCj4gPg0KPiA+IEFja2VkLWJ5OiBLcnp5c3p0
b2YgS296bG93c2tpIDxrcnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5vcmc+DQo+ID4gU2lnbmVk
LW9mZi1ieTogWHUgWWFuZyA8eHUueWFuZ18yQG54cC5jb20+DQo+ID4NCj4gDQo+IFBsZWFzZSBm
aXggeW91ciBtYWNoaW5lIHRpbWUsIHNvIHRoaXMgZG9lcyBub3QgYXBwZWFyIGluICs4IGhvdXJz
IGluIHRoZQ0KPiBmdXR1cmUuIEl0IHVubmVjZXNzYXJpbHkgZ29lcyB0byB0aGUgdG9wIG9mIG15
IGluYm94LCBzbyBJIHdpbGwgaWdub3JlDQo+IHRoZSBwYXRjaHNldC4NCg0KVGhhbmtzIGZvciBy
ZW1pbmRlciBvZiB0aGUgdGltZSBvZmZzZXQuIEknbGwgcmVzZW5kIHRoZSBwYXRjaHNldCBsYXRl
ci4NCg0KVGhhbmtzLA0KWHUgWWFuZw0KDQo=

