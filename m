Return-Path: <linux-kernel+bounces-10207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9895481D13C
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 03:14:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCD2E1C213D2
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 02:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28BF1ECB;
	Sat, 23 Dec 2023 02:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="maBecNVL"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2075.outbound.protection.outlook.com [40.107.7.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ABDE7FD;
	Sat, 23 Dec 2023 02:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HSMPgM7GMyxCVQE9wxB2ygd8D1PaSSkyQ9DxBCShtRmZfss1IEuFEp9BqqayCeRoWxWw7Nsuz8VBAjVNxYikMTidm3K2JTKrNteRfWpRlCR2hmQ4Ad2uj7pA2buEBhvP0HnidwRNjlK4GpdijRJQwFmIl6kHnJnXdUsqSbNLgkx68zTcGlZHnVbRAKwjw9v/J76MPp9UU/gOtqmaQZLpOah9AUyk2kXwRhNt6+p3hT0UN1LZDQ0XEmqC0TOBvMFfq5NyLzwQj6QaLWOzAq9qyN70OmxE7vcpuAn1pvjaOxZ09IY6hgymYmFA9OA49VX4NH1pjyfWISifrdh8bfxTUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=16yP7fIoNfnkX3rtksY3QsGXdRHX9nmPbCQqIRF7zNI=;
 b=H9Zo76+vbNi2/FS4whDaGTB93rD0xt/xWrm9H8IX9Ne4Pt8WZ3yp742yT6FlPdo+EzV5ENBeAJ7uWaMfRlKxQl+ixo+yUHhfqPaD05gI9fuKkYgnT1xNJY/6vT0hQki9Jm4IoUcFKTVO6BSrVPJwNql8PY38VC2fS22bA9f9ZILdV5JiIqJlRQ6vraa1l6WEvHM0cfw/tDtdX4Mta2zkgWWPA/51vV+zVRSte+658Q6jeR0P/NZsKa9y+FQmMUkAjUrZhZl3X3byVQ0CAo83iYoJ7f5PxsTPZl9uRpI1EAxUVlyV1sE1LbWR1qYLHHfQfdros3g+dpnO2zKHp8OUNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=16yP7fIoNfnkX3rtksY3QsGXdRHX9nmPbCQqIRF7zNI=;
 b=maBecNVLMY20PjJ3UNLS0v9CUJGcSsE+M+NsPugRMgByoSoAb8ih7UtzyJ20N9KMa5idXzL7Vpu+9NOIu4GyTrD0UDR6P7TBBJBU7r63Uid9upBcFAU2rr64Z9UDDyQ7oO5CV7P6yNBatYscuq3/zkyxsN0+FMT1XD9/MHCtAGk=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA4PR04MB7901.eurprd04.prod.outlook.com (2603:10a6:102:ca::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21; Sat, 23 Dec
 2023 02:14:08 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ff06:bbb2:c068:5fb3]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ff06:bbb2:c068:5fb3%7]) with mapi id 15.20.7113.019; Sat, 23 Dec 2023
 02:14:08 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Cristian Marussi <cristian.marussi@arm.com>, "Peng Fan (OSS)"
	<peng.fan@oss.nxp.com>
CC: Sudeep Holla <sudeep.holla@arm.com>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, Oleksii Moisieiev <oleksii_moisieiev@epam.com>, Linus
 Walleij <linus.walleij@linaro.org>, Shawn Guo <shawnguo@kernel.org>, Sascha
 Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, dl-linux-imx
	<linux-imx@nxp.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-gpio@vger.kernel.org"
	<linux-gpio@vger.kernel.org>
Subject: RE: [PATCH 7/7] pinctrl: scmi: implement
 pinctrl_scmi_imx_dt_node_to_map
Thread-Topic: [PATCH 7/7] pinctrl: scmi: implement
 pinctrl_scmi_imx_dt_node_to_map
Thread-Index: AQHaL005G5A4WDbzdEGBX+SfV+Qe/bC1nkGAgACMwSA=
Date: Sat, 23 Dec 2023 02:14:08 +0000
Message-ID:
 <DU0PR04MB9417FAE597ACB2B72DC446F6889BA@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20231215-pinctrl-scmi-v1-0-0fe35e4611f7@nxp.com>
 <20231215-pinctrl-scmi-v1-7-0fe35e4611f7@nxp.com> <ZYXK2YVJ1nnETSuI@pluto>
In-Reply-To: <ZYXK2YVJ1nnETSuI@pluto>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|PA4PR04MB7901:EE_
x-ms-office365-filtering-correlation-id: 43717e48-10d0-4114-0db7-08dc035cd885
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 X0RFeQFJepz/XgMhN48QjmZKXU7ZZXlE6JDMPHKQ3bUR8MOFmeNGY9PppL0w0KssbYzuNGpQCajwWXY5swrK6qAjPBH3/cXQB+Wz7QCyzn6y7GwJVpJsDwdgWCZppWJUlXMYX9xeJOXr24H4cL/z95kHqZa9Py81hYhk64U5Dvq6Xfg8hE3YrAVBTKRt7x1qeAjpbhqxLR/X9Mpr2fJeuVJT9/0k5sjHAHlZadJWU/yowQmzioX/7YXSwi7dUy4RkGH5BAKmFcywuUlYh9bAYGGXyWjgUjEBaJm3VmbJVqew/w4nERzA+d1Z8QVd6qSEaLvZElrEQ3PznBxoANQVI4xuiqncWZiRHaP+h3wuitz1kgynV7TR76ULd1on0ApWW+OZabHiKRQARplWVp7kEXkS8f1K6jYHAwiD/r0UCwxeaslaQDiZr9Dd9UK3jP23VZPfyrPs2+y5nbRDl1zt30OKK6hA5u9BJgj6ZHSihc9tl7TZpPN4MvtGAjA5IBbmSccFjgIaB0kT3lrMFn4uuN0KFWazAistcdleE7GwetDK9fI5LFW86YXTs6895Szlgz0S3f7zVa5ppVa12mWExF7tx+e33VwoLAx5g+L/zML+7MkA4maYcpcxQ9hpLJnHsMVBcIhQbb3+KD9A9Ve7LQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(376002)(39860400002)(346002)(396003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(71200400001)(5660300002)(966005)(44832011)(6506007)(7696005)(478600001)(9686003)(26005)(55016003)(66899024)(8676002)(4326008)(76116006)(122000001)(8936002)(52536014)(316002)(41300700001)(38070700009)(2906002)(86362001)(33656002)(38100700002)(66556008)(64756008)(66946007)(66446008)(66476007)(110136005)(54906003)(7416002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?oDTimgUUnngydXhqKDfJS31vF6eljfQLsbNENp+WWgzOv2/cyVAnSZoJ9Tkt?=
 =?us-ascii?Q?s05MHZDTavkiKVhvYxmk2pHzf7j74UCQ92QMA4OKdPfFKCh2mVagwyf53eGK?=
 =?us-ascii?Q?tUa1H4nmFmoR91S0ho8qcEs2Kkj05BFgoHN1Yd5xT4fHOkm2HmML0KGaoQ8m?=
 =?us-ascii?Q?0feOa89SlthQ3DGreP8IDS2Y+NGDmAxfULjbFMAXFLq5C9ophPMeF+6Puvz7?=
 =?us-ascii?Q?qbiJRLegQvpgLh3EDYSQo1eLd8ukxZ4xn8ntCHIBmZ3xrkGRbryboCGi0ZkO?=
 =?us-ascii?Q?AoQYrpyHgqY4U63Kv83ygMX48BIW44iRI3rOQAVOWyWZ+g2rtyrSADwBUm55?=
 =?us-ascii?Q?YfIVrEDLhAfsZRHw64TFyz6rVQxLulb+k0ZLGd1FFfqfsMW9zEHuVWGx0tA5?=
 =?us-ascii?Q?xixPe1FCvenbRWiYW4i71zf9tRPjmxxqtgy1LyTEpN20m0WHSutqNcX4Qtot?=
 =?us-ascii?Q?eSKvW4bldxhkfJ645FebJlIaSwp4qO2shgNenMdJ5c3RufCpuILKtrS/5aoe?=
 =?us-ascii?Q?BU2vjigiv0heIrK7494S7JMkMZm/LRoXf+OCbKqzSQu63APwzF5A4sj71o7t?=
 =?us-ascii?Q?X6yKA0IZ/GXpHf7uX8OiRp0zSy5a+Y0Wz5GD0B2N6IoJxx8QKx4XsPzHM20s?=
 =?us-ascii?Q?pkYMTyBufTjv7Qa4AEQZBL7WL+5djhUG8REL0jHzyfbsbJaOKdxsVZu3Rqak?=
 =?us-ascii?Q?fyevzsmIFN/cRZm9ag8GqgNzxbNrhDHiwtRR4DDI69EeBbYgm0WrNOh/2ZiJ?=
 =?us-ascii?Q?1YOa9KpB4F78oy5GzwogBMY29dT1VrjnhlziXIEiNKhywmFjVYiiIeGhFVs3?=
 =?us-ascii?Q?whnoGpL4/lfFDSdsnUEB6eUt7ptoqNMH+2c2oxX4HawqpbqzbE+IqPhtB/z8?=
 =?us-ascii?Q?uAKIUE7k8tpZ45pp/Fjm180ziIUfdYZAjv46FWHXVxxfJbmW0yFPpLMQStqM?=
 =?us-ascii?Q?dAPAajeL2dB8DEUxb4cwmEVkMwwbEG2cNFD7CuZX2HUClUrc1PLiekNllJBL?=
 =?us-ascii?Q?UWWS9hR5uC74krgjhqoU4VqMKEh7I/2q7DYM9Wb9DHJvYDR1Y9oF8ABElKzV?=
 =?us-ascii?Q?WJFAaE+Tsya/XKgK6Lw7nwOX2zVy8st5MqXa+E7E1UlTdUwvFhiWqcSuAzy1?=
 =?us-ascii?Q?dL/IjuCNUtAQVtgAUjFvr5zKF6/4C862TZCPnzGdzw4OY41GK3P97Zcp8WfQ?=
 =?us-ascii?Q?HNyru8hyROyLvRlHI6Jbx7G0P+eJ7pdd5T4LOk7QZ0+FJ1cVxm1yn74wiA8q?=
 =?us-ascii?Q?F6sa36Qq/OL8Rw4SLUSVWVXYd2axNl7zcQKmI4pLzLmNJIDUBwoaKA7uG8p+?=
 =?us-ascii?Q?XguytKKTiqLp4I5mws7yNeACwoy7/469VAxEt2mfOFzBDHqSRqfXjYyr7zcd?=
 =?us-ascii?Q?Z5Ft2P9wkzgdph4CTEKRdbrftz8H0q+Al2WqaBmuFxH3sA9G93cuLro4UXHF?=
 =?us-ascii?Q?ycDvsVR2BUDR/OksbtYbgJW2ABwsaTyhhGbbqaOD3zpyoyoXp2TqaqZQgTA/?=
 =?us-ascii?Q?vt74DvgaoTqrK52oaYXZxA/0f3dyPayXsYyX9RSXayoHJF0bIjZpU5WTkXbb?=
 =?us-ascii?Q?FNZnePAxN6g5Wu1yiU8=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 43717e48-10d0-4114-0db7-08dc035cd885
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2023 02:14:08.4106
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4FOpqglr0whxKIClDDaiyjeF2pVODrzCq6oM4DZCTOsryLuQSNDL0PhskF1Jhgw16N0m+AhzDAcLZYf0hiRsZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7901

> Subject: Re: [PATCH 7/7] pinctrl: scmi: implement
> pinctrl_scmi_imx_dt_node_to_map
>=20
> On Fri, Dec 15, 2023 at 07:56:35PM +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > i.MX95 System Manager FW supports SCMI PINCTRL protocol, but uses
> OEM
> > Pin Configuration type, so need i.MX specific dt_node_to_map.
> >
>=20
> This does not even compile for me, as of now, when configuring the Pinctr=
l
> SCMI driver as a module with your IMX custom additions. (I think the
> Makefile with the additional pinctrl-imx is wrong in how describes the ob=
jects
> composing the pinctrl-scmi module with IMX addons...)
>=20
> ERROR: modpost: "pinctrl_scmi_imx_dt_node_to_map"
> [drivers/pinctrl/pinctrl-scmi.ko] undefined!
> make[3]: *** [dev/src/linux/scripts/Makefile.modpost:145: Module.symvers]
> Error 1
> make[2]: *** [dev/src/linux/Makefile:1863: modpost] Error 2
> make[1]: *** [dev/src/linux/Makefile:234: __sub-make] Error 2
> make[1]: Leaving directory dev/out_linux
> make: *** [Makefile:234: __sub-make] Error 2

Oh, sorry for this. I could post a new version if you require. But before
that we may better align on the approach on how to support i.MX.

>=20
> More in general, I think that this NXP OEM specific additions, which are =
in
> general welcome (and indeed as you know part of the spec was modified to
> allow for OEM specific needs), do NOT belong to this generic SCMI Pinctrl
> driver, because the driver from Oleksii/EPAM was born as a generic SCMI
> driver and it fits perfectly with the Generic Pinctrl Linux subsystem and
> related generic bindings parsing: now with this you are trying to stick a
> custom OEM slight varied behaviour (and related binding) on top of a gene=
ric
> thing.
>=20
> And this choice leads to a number of additional changes in the SCMI core =
to
> support an even more complex handling of SCMI devices, which is already t=
oo
> complex IMO..
>=20
> IOW...I dont think that the whole idea of the per-protocol optional
> compatible to be able to select slightly different behaviours/parsing wou=
ld
> have a great chance to fly sincerely...
>=20
> I know there is an issue with having a completely distinct SCMI IMX pinct=
rl
> driver that uses the same protocol node @19 (without the need for the
> compatible trick) due to the way in which the Pinctrl subsystem searches =
for
> devices (by of_node)...I'll think about an alternative way to allow this =
but I am
> not sure (as you saw) that would be so easily doable...

For all protocols supports VENDOR extension attributes, we need a way
to handle I think.=20

As Linus wrote in
https://lore.kernel.org/all/CACRpkdaRY+rU+md-r5gVyFH5ATt3Pqp9=3DM4=3D+WArYk=
fVLAFdpw@mail.gmail.com/:

We may need:
protocol@19 {
    compatible =3D "vendor,soc-scmi-pinctrl";
(...)

>=20
> Also, I am wondering if this is really a problem in reality since I would=
 NOT
> expect you to load/ship both the OEM/NXP custom specific SCMI pinctrl
> driver AND the generic one on the same platform (after having made them
> distinct I mean...) am I wrong ?

You are right, but that means the upstream ARM64 defconfig will not=20
able to support both i.MX9 and others.

Thanks,
Peng.

> (so you could even made them exclude each other at compile time...far fro=
m
> being the best option I agree...)
>=20
> Thanks,
> Cristian

