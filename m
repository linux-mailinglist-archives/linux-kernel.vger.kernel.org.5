Return-Path: <linux-kernel+bounces-165260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 945F88B8A30
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 14:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B616C1C21A0B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 12:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B903F535B8;
	Wed,  1 May 2024 12:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Y4clWtdo"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2065.outbound.protection.outlook.com [40.107.249.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21EC43178;
	Wed,  1 May 2024 12:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714567336; cv=fail; b=GmnWKEGi5GBA7+2a5EE6x1NFf5cfMGBcXa4aTan45wPVyjijJ9v80G0v6j5yfArccxO+d7m/Mww0IAVCFTCViF+jCrQgHdryRmOeFcZIWsWA9PSkGlrZPQljztH6TP4hvLevjEe516i+FQBtmcXrDw6srSYz6Ngv7ZoR0ScSs0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714567336; c=relaxed/simple;
	bh=wAPU1rH4p4LBRKeytfzhyXKBLLRKo0d4Evx/2OJcTSc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uJqy1Pw1yRtQAKJrblRMgf4AVi9tOFHPPbDbPg0m8LrStnQ6d/FJe7x3bUtj+y9nCGVy3Ar0j2n1mOIJC+dNa717i/AkIEnyusWUVDwWTFTy+1pc69mq7y/lcponSg405+YBTKTRb8NDr2CVvNw0OGvZDHMzmYhFqmhe9fD3Edc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Y4clWtdo; arc=fail smtp.client-ip=40.107.249.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jkxIVN8VDIOcJMjKrUJN5AnhQ1o54bmr1l1wfiGA7BO9+PKaAs7NI6WW/L1Qhxv2Z3jjYCp8RaRqvzTeINUKVjkeB+wsVP52rzfOS7a8vxB9URlUqrVYqoM9UppSPhZKtpHt6RD8fXRhtCtTydKoRsD5j8BYJ534PfI/L/Dl2YdkhDLUO5Shos7oY3fc52lJBIgzq/wJXkFfZYDp0+glK+V4HapqyUqP1apbKySabmr3+FA1NeQhegYqJx36T/LyhN4Vy7rPN15EK/GE4VmeUKPOqzN7O5hFg64g1ibqxIEHJCe5dAv8NA3/laaDex+fTk5i0whoNVoQsQhRlDdBog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wAPU1rH4p4LBRKeytfzhyXKBLLRKo0d4Evx/2OJcTSc=;
 b=AMokFdMaizwyochtuS1VvGWwrV8tjeab5Xe02A4q+RB4dbmI6Cc3fO+VgPJZBnDFgU6Hxfd680ZaksroolqrWDFTLifwvOZHczl+1p4FmR2KDS6A5K1KHBcrCvZ8zI0b0dHlIFSfwS3mQIPYn07y+9BRtZlJ6rQh6tH/DEvC66wN+2yRB/zqjMNzSvUdSu2s8KF+BWRvgLsQhHV8Aj8Xl8X2u4agXR7o1fvyV5YrWYHbE+Z9uCAgRempjEBgUpQJgppQjmrJAF7KgFwqS5u6Th4tfK48EY2kENO54bs1dQxlB+cm9qw5eC13pISKKipx8aer/ddmDX7p3xFQzWyCvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wAPU1rH4p4LBRKeytfzhyXKBLLRKo0d4Evx/2OJcTSc=;
 b=Y4clWtdoEhWchYLjfNUYoLYDaQTNrTivz7sZDAMFN4Voy5sTlR1DVyOJTYVB5ebxChQO95sr0eDmgVCvMtt1pR6VH3ssH4f7f/hB3yPKmqT1/LrYlfrFhn6sgSChRIDR19K3Y7ms5ZIZHrHXu5+LT5x1z2Z3hO72cglDa6xnQpQ=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB9PR04MB9284.eurprd04.prod.outlook.com (2603:10a6:10:36c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36; Wed, 1 May
 2024 12:42:12 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7519.031; Wed, 1 May 2024
 12:42:12 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Cristian Marussi <cristian.marussi@arm.com>, "Peng Fan (OSS)"
	<peng.fan@oss.nxp.com>
CC: Sudeep Holla <sudeep.holla@arm.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam
	<festevam@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Aisheng Dong
	<aisheng.dong@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Subject: RE: [PATCH v3 4/6] pinctrl: scmi: export pinctrl_scmi_get_pins
Thread-Topic: [PATCH v3 4/6] pinctrl: scmi: export pinctrl_scmi_get_pins
Thread-Index: AQHamSj4tA0oEn/LJ0GAeG40RoRvxrGCVjCAgAAAbEA=
Date: Wed, 1 May 2024 12:42:11 +0000
Message-ID:
 <DU0PR04MB9417FD3BBDB9C37E34EF4B8388192@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240428-pinctrl-scmi-oem-v3-v3-0-eda341eb47ed@nxp.com>
 <20240428-pinctrl-scmi-oem-v3-v3-4-eda341eb47ed@nxp.com>
 <ZjI3abJUIgo4xgRu@pluto>
In-Reply-To: <ZjI3abJUIgo4xgRu@pluto>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|DB9PR04MB9284:EE_
x-ms-office365-filtering-correlation-id: e757e81b-a310-4468-3588-08dc69dc1f64
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|1800799015|376005|7416005|366007|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?NolM75K713U/8NIeE+N20HttvfYiuuPixV8SFXAW4i+acAFAV6XUlbVR5VSr?=
 =?us-ascii?Q?tbMFGZKzGLkEwX32Qqa/b655w42Vzt0E7Ks8ePgm1KzpQ/lKlBaZWHFkero2?=
 =?us-ascii?Q?tDnPwCBrtG2f0BG+YvoduB3CgSE0fO8aQxQF7IOjjXDvk0DOtu6BW3xt1UXX?=
 =?us-ascii?Q?UtKhglSQRC5Ds2PfWJE/6ZvzzWBCK/v+nzaR3U2dYI7mBr6ZvRvHwYngqv7O?=
 =?us-ascii?Q?mOjahFh9w1JNYWMPbhdE5yTbmWDcrvHUyL9oLVxn01joc3QZ6mqQO8zEkv9M?=
 =?us-ascii?Q?g76HiCOBJkkml6LSXCD75SiDDwrFPXxzysrQ621b/quI/r1clYy7pfp5HRYb?=
 =?us-ascii?Q?LvgXTXM6GrHKKa4OrPAyK42FM6908mxu1S+5swIRxUx/HsxcwmwYOHJMq8Xn?=
 =?us-ascii?Q?+0Nxv75TUb+4ro9pUKZsnsxu9AoLxa+mV7Gl0iw1Ibbuy03aHQkBbxPa59bp?=
 =?us-ascii?Q?WUZSL56uNRm/x1r8Fs30a+unINCg01kHY4Ld1amYnwyh8/LPq10Y69Gr9OpD?=
 =?us-ascii?Q?qY+jKXy5ETNetw4+MgBhsO+sJeP5jBaAtURopj7oFz0CMbru5GZd6ON1+JDS?=
 =?us-ascii?Q?ehwbL37L2NjW+Fg8LSirwXRHGEqu6MA4/bYDzKIDlXS80Nu0/aejnHdDuvhA?=
 =?us-ascii?Q?v2GfSnQ2LTOEf1wotb/CnZD3GDeNmX81nKfrlphMOrCWlpJwyUIJSUI1FNRw?=
 =?us-ascii?Q?MGvTDHJ6RGRou4kKiy9F9GxKQoFOBWODomwnfGl+a5fFm3nPtZFeEuTn/pj0?=
 =?us-ascii?Q?UIbzFrXZKfr31GQuPZk0uknupOZEP0bm0R1izyA76TXJA3arUnZIVcRa6R10?=
 =?us-ascii?Q?Q2Z4LEJSkJ/vUSccKanO9M+yzjARoVfaDm128V7wVqyubY3VkZE1vwWXYg/D?=
 =?us-ascii?Q?6+OJvzikkxrOKKIkMV8K24CI9IfE0uSTX4PnjOhSNmGtk2qtwNyAaXkPOwkf?=
 =?us-ascii?Q?ASobM6NOxY8gbR9sS4+muOwBMUsQoH53WTMLXEtG1kM1tjKhf7D+7GpDN6NV?=
 =?us-ascii?Q?5xTUUDEbYrkku9f/chvZUWPuI5/BKa/ygtF517zSgmfK8C+Q+4Kzhic2qbIg?=
 =?us-ascii?Q?y1EctJuQA17pgyw9lhb57Opc8UXgU3inSrwuXzxXR3XOY5fuANpJC1kdrMgE?=
 =?us-ascii?Q?S6G0MEush3ZranZMlk3zp+ASj8CGqJ3gDMZXkMPKfnAmhZbJG8HfN30Tjf62?=
 =?us-ascii?Q?aGUp/Ryrid0zK8MzCIZPMcNwrlLsrSKLq+Fj0EZg1kiDxxAvN7Pe2miGa6Y6?=
 =?us-ascii?Q?niDHaGx/z/uA+dmOq4q9eEO0SWXn9o33e9nh3kzixXhmr15k6JwQE7sNMTp4?=
 =?us-ascii?Q?1qVXV6w/wc7JUwn8a/omXxxpieznMf6UKTBEfeZH+Oq3Gg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?6VnV5vleNpgoA3+OUscKMcsgVFYwlVnPGvUo14aJtLSG5qMHgOupTOAh0lTH?=
 =?us-ascii?Q?EEQJ+dZPSW8bZnhPLb/ZW+nyqhwIrTQX9Evhw6XmqdMuL00UmE4wy6fgR/46?=
 =?us-ascii?Q?WFAbgKuFqUeHILS1lYLfCP70/7wBjctB/ROQNCRhkMg7+p0+b5xOIjOSczyw?=
 =?us-ascii?Q?0keNcUjvbx2J0JHZarbN3RRQAVpm97175ZKfsaDfsq1O1L6R0lIJXVUiKw8t?=
 =?us-ascii?Q?Ft2R5qq3t3ZZIkYAAWH/Zcr0NmcNjRjPuEW5/iN/3n72c2lNkyf79J/ife9B?=
 =?us-ascii?Q?bE0WIlmGvB8KZF0+D3VoVB9xzbjpPfEFupnezeh5Z/RprVLAHZalTWOEJaAR?=
 =?us-ascii?Q?hlGyZmudCcAP7FV2ci3e0ZbC6UVa5NX8VlxnQiokmQqlNT1syyCpcR8iI+xZ?=
 =?us-ascii?Q?uhW4Lxz/97bRdeQg0q+u1TeU9yUTazoe8q7Mhvb5k5YIBiJGNPQ6x+iuO9vO?=
 =?us-ascii?Q?2dX8q2E6FqE0gXcnoLSjvq97wdJXJ38qJd20VGStil5lZVbfkHBWHV2op4ij?=
 =?us-ascii?Q?ZloNVlO5JbpSYuBWWpiKMHo9IsgXHDoTWyKjygHr0TOcPEtcuWSsH8rLJAQt?=
 =?us-ascii?Q?A8WNs3Qg3tjzPlRNZhnjbDQdq4NW7Qc7FjSncd8s9O67Z0DIRGBhN+9LpJj1?=
 =?us-ascii?Q?AuPivlT9VWs23PfaJoDA4EnLl1obJO1H/AglNX4d5zO8l4jd1sQIkCsc4Jth?=
 =?us-ascii?Q?trUjJEZ/sYOIAE1i4e/BLqIqCTgXlK9GpswrpN6N2s739KKEmUJjaePsuNFr?=
 =?us-ascii?Q?Yn1IoZ9fPKL1GeORVQSxQ+jv28qSzJ2ZNncVmdkIhqnGyCk8yiwCMp2IqhHS?=
 =?us-ascii?Q?BThknS97CMTon7rsCF7uDXU0Tl/Jeu6UE31VKksA0eodBC/O5HyT3rMVJiqx?=
 =?us-ascii?Q?yo240llCtwIpiNZy7hPn8X3ZQQRQlP5aF3XMLw0fny6EZ2DBpZzKQ/pDpSm9?=
 =?us-ascii?Q?5DZLuS3JZT1nBAHUSEm7dTpX9q5kD3Ak2FO7Uy4nD5w4gN5AVtgkYlKhT1JL?=
 =?us-ascii?Q?Zaf4w5/CeBLiKmnyP88AGnsxJxgs/D/2xQQ8zdGdHdZP01S0LGt0Kwo8bEQf?=
 =?us-ascii?Q?uQBz31AEBrMjxywZ2BDcsStRduz6q0qFT/kuKf7k2x7iTvxtHjIRZCokyK3g?=
 =?us-ascii?Q?4JPCIS1UUPV6ZfsNDcBRxgSp+VzS84DdccLJRS4fKwOXFF8KU7YMSJQ+DA2/?=
 =?us-ascii?Q?ljzh2FAzpeCiFjdArF3PE7a7ZhuRNhofEAbXFIDsOBBIN2yQjwWbzroDA9HN?=
 =?us-ascii?Q?Z8jm2qNzEWwx0uI1ouZ4Qwd1G5rvqdzKsdIKDgswKr09PTn+KPSASya2wPqG?=
 =?us-ascii?Q?wu2O0cqEDMaUmmxKtzgSBKNUUda0wYOiFQQKxIb7obLgH8cDNFFPRs6rvKiQ?=
 =?us-ascii?Q?wDjrMbQpyJw0r1K0DG+wgoLjogUGYHEpc2JRPBCj/3UiYEvcITAZK/3S5GN5?=
 =?us-ascii?Q?a7YDgPQMTdf9RQTT9L3Px8/K2U2lmfVRzJ4hcjgP8HldDrOIkZ8+XKj7RvpT?=
 =?us-ascii?Q?lrTaYVEGYoxGv1sQWLv0fWv9Hs5WUx4JZJW7kYWvm/pJlQin11NqbnWZP+Id?=
 =?us-ascii?Q?1sMG90zEmuQNNbLKgpM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e757e81b-a310-4468-3588-08dc69dc1f64
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2024 12:42:11.9904
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ERVKL2jgMKjgBIrzeUfqeAskrEQhBDgJsmk3ZTGwbL/1UtxJyAHWzpNG95l7NNMVASqCqpQA+30UzLLM/Soipw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9284

> Subject: Re: [PATCH v3 4/6] pinctrl: scmi: export pinctrl_scmi_get_pins
>=20
> On Sun, Apr 28, 2024 at 01:07:50PM +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > Add pinctrl-scmi.h to include the function prototype and 'struct
> > scmi_pinctrl' to export pinctrl_scmi_get_pins, so other drivers could
> > use it.
> >
>=20
> Hi Peng,
>=20
> so you wrote a new alternative SCMI driver using Pinctrl protocol@0x19 so
> that you can just parse you custom DT bindings and then use the SCMI
> pinctrl_ops to set the OEM extensions to configure your platform...
> ...since your firmware cannot cope with the all SCMI stack footprint....
>=20
> ... you seemed to have solved the issue of having 2 Pinctrl drivers coexi=
sting
> under the Linux Pinctrl subsystem while attached to the same
> protocol@19 node with patch 5/6 blocklist (if I get that right..)

Yes, right. With blocklist and allowlist, two drivers could coexist.

>=20
> I think this approach of a standalone SCMI alternative Pinctrl driver tha=
t
> handles distinctly NXP OEM extensions and DT-parsing is certainly more
> preferable than the original series you posted months ago where custom NX=
P
> stuff were simply stuck on top of the Generic SCMI Pinctrl driver...
>=20
> ...what I still dont understand is why you exported data and structure fr=
om
> pincttl-scmi.c to use it here; when NXP pinctrl is active the standard Li=
nux
> generic Pinctrl driver wont be alive, so not probed, so no data can be sh=
ared,
> the only thing I can imagine is that you are just trying to avoid duplica=
ting a
> dozen lines from the logic of
> scmi_pinctrl_get_pins() into your new NXP driver.

Yes, you are right, I just wanna avoid duplicating scmi_pinctrl_get_pins.

>=20
> In this way, though, you are creating a dependency between 2 drivers, tha=
t
> are not even allowed to cohexist at runtime really (due to the blocklist =
trick).
>=20
> Am I missing something ?

No, your understanding is correct.

>=20
> If not, I think it will be much better to just rewrite that few lines of
> scmi_pincrtrl_pins_get trivial logic into your NXP driver and keep the 2
> drivers fully distinct at all times.

ok. I could write the pinctrl-scmi-imx.c local get pins logic, not using
pinctrl-scmi.c to decouple the two drivers.

Thanks,
Peng
>=20
> Thanks,
> Cristian


