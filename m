Return-Path: <linux-kernel+bounces-94380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11CC2873E2A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 19:10:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 937411F215AD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 18:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE6F13E7C5;
	Wed,  6 Mar 2024 18:10:38 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2139.outbound.protection.partner.outlook.cn [139.219.17.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583DB13BAD4;
	Wed,  6 Mar 2024 18:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709748637; cv=fail; b=cqWZ61WnuS5fu/+zFmooODE+wHzGUICM+U9r7JLH4uoi/OxGCHIo6atVKuJ2lwPnEWQsgE+FQlRIHWAoXAOF751RIK8yksuj0OuV/nRYQuVVwZCnw7Gx+3owW4Mx/0pgXFHpffUGJRGuHsRCEMEnQxPvv/awhwjHvmaFLQWuVxA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709748637; c=relaxed/simple;
	bh=rX5eSPxE73B7JlfAZEh8VMrUCHEDd0skpGjbP8WkUFI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ftVwp4iHNqUGqkvOZ5jApk6vvYRwg6HUdr3JGD2GVCRONA/8a/1cnklOElLZQXuXfCnnxh1TBwnLbKKLcCKFSMEzfHfUA1/HJwMghacjbs4y/ki9/gvegYWYZvAtZw1f2mUfi9NhCQkFPNIpkfyxDwxs8J+gL1aDOprXgJwJ6Os=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nWxsXz6+3JHFwUTCVmwosNytHKKDcSqP3q3oJir18YGXZJkwr+y5mt9nOcM43HYV16Pul1l2JI6v2A98kAo1d2V9gGHYrWJimYz6x0WllzR86vqpRkgfrWbrEPlMhMkeDaXso+pda2MfGg+FBHgIvpM+qFN6LOvE1Ug0ONS6c2pJ2a9FLusP6kwoDhxKkBCP3BHCTcrC0uChuTP8MnFpacBg6+eRP3mtaCGiytI1udW/HixfmoRK8CAPmo6avVzYJWv3k1gq7hvBwgk4eK4IEJpKLh9nMsUbdBl1OLyspKgaOI2b9diIgtys0uGE5sFGC7ssBC9GKojiI/5TNLtlfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=33aXrXpJgkt+hCzwABzaPtN7NoSESvzO3QwLAu6mKfQ=;
 b=NDwnZvCc5a/se5D0t87xhygHHgxsgcy3BTdYK8qAP/JqYUj6aKfYj2OcmK5/J7VXRYiY/SPV/zOE3wmDvCT7fFrkiBA+PMlcaUp0ONGphG8iOSzA8ExjklB6dX9hmLd5uG0Uxd/b1ML5dc41WGa2rsiQpGv2OX8Srm+x/Ly401yoGlPZozwdeqa44V+cqskdbWdjb6rn+ZZ3q6SxfNzsYel/M7vRKi94F+0JsKZ6paeiKjgUjrt4o/WzMYkJnOmIsMpgSuuhl8tU2cclI535YRRQPL8t6UlvGSfs3mfjGUISV7J+NZxXQRrkLpmauQke0yhQg7N56QyPGmpxz2V6oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:20::14) by SH0PR01MB0682.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:22::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Wed, 6 Mar
 2024 18:10:30 +0000
Received: from SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
 ([fe80::f6ed:1a18:3fbf:788]) by SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
 ([fe80::f6ed:1a18:3fbf:788%6]) with mapi id 15.20.7316.050; Wed, 6 Mar 2024
 18:10:30 +0000
From: Joshua Yeong <joshua.yeong@starfivetech.com>
To: Frank Li <Frank.li@nxp.com>
CC: "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
	"conor.culhane@silvaco.com" <conor.culhane@silvaco.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "jirislaby@kernel.org"
	<jirislaby@kernel.org>, "joe@perches.com" <joe@perches.com>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
	"linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>, "robh@kernel.org"
	<robh@kernel.org>, "zbigniew.lukwinski@linux.intel.com"
	<zbigniew.lukwinski@linux.intel.com>
Subject: RE: [PATCH v7 5/8] i3c: target: add svc target controller support
Thread-Topic: [PATCH v7 5/8] i3c: target: add svc target controller support
Thread-Index: AQHaWIvaQw3YyHT02UKJrOMhyC7OnbErDKXQgAAeUgCAAABu8A==
Date: Wed, 6 Mar 2024 18:10:30 +0000
Message-ID:
 <SH0PR01MB0841C4D6B76DE99A789312BEF921A@SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn>
References: <20240205233326.552576-1-Frank.Li@nxp.com>
 <20240205233326.552576-6-Frank.Li@nxp.com>
 <SH0PR01MB08410A70ABB956DF9DD4DE25F921A@SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn>
 <ZeirpIpcsPuBAiIR@lizhi-Precision-Tower-5810>
In-Reply-To: <ZeirpIpcsPuBAiIR@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SH0PR01MB0841:EE_|SH0PR01MB0682:EE_
x-ms-office365-filtering-correlation-id: f7bd09d0-c87e-4e3f-538a-08dc3e08b568
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 e59/I/ZFI4kBNXxItPkJnyW+0Cu35ttFj8qjUalZMERVzQsQceO7mmMnRnCQOqOJEHY1hXyeo1j7fWwc0zUOlM1VnXKigQdqzet1/uFNwaHf5UQSSlQNoQB3t1s9+fYAJR7/wDUwlFMerFOqF3uUUl9b0LrMpbLH+sCkqKcIZwdQQDvutHI7hnMUUf2uhmpCVvFQdNlgxXQ/JhCGYCaaOfRThMvvK4//+McDGdrtEX60I2TU/pMxMTKdrzOP6aRpwYQIgu/IfmTkMROi73Vs/n966NAOK30ZZZJBtMAj0zk+ZWXvUes6iDnv/fR/H1z4lq+QptRPzOL1G0r1vJSfngIKKaNj+BNJhngP6qUhDb7bkRSrGQ9jqBMBZMt/7f4pbIb98VUyGQgCtuwltH0rbXhkqU5a0S4XCwD4IKSyc2pl5rJWVWre7uU5RP5xjseX7GmY5peEAOnTyEZXsGUI75w/x/i9W0ATxnGKfADRuCeOCjUuuascMOVFeazBdP/l0JqMwa+WMGJDN3/K178ujkhTuHJ0Dy5See7U6fcgneu6Qr74KYHCUUklv6KkGyf7FCpB8s0zMlAmxIirzmJXfaRS2YkZPeQZVOxD3OpnoNCqEruJmSNXsXwwdjc7NFzO
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(41320700004)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?wtRlVSZRu0W2pdLV4s3Mi4efjfJujLEjU5KRx5mbnT11SUdgvUjBvV4o/Xbh?=
 =?us-ascii?Q?Qum5ExNHL0/UBqJwFei26H+/InK7DD6DIOFpuDqzI33Sd7uNGcW3ZnlMCZMn?=
 =?us-ascii?Q?1HDmyaXs2uKaeuz9pihb4hG6ANfjOzOu/tFloJyjMaCli7Mc29VGZo837kgN?=
 =?us-ascii?Q?q5T0jrJ0a7uvUQ6SNzp/WnpNIgERG1+C8kBSRNMZbshc6I4UlTBM+LY74DR0?=
 =?us-ascii?Q?qpIRQTv8dAJpFFy84J/F9U8WK80zYzCsrzHsrnOqXgr/vOIbWNZRameBQNrO?=
 =?us-ascii?Q?rvB6w4lQPBR8tHuouFKxIingEFHQ7tLohGmVW5/UGubEJ6AkgcgT65+ymSwP?=
 =?us-ascii?Q?TwkdoubBLc1VXOrQUEMIAYEcYLXcD9gsJSBELxNBAU1ChvR4AwWepRGeXahD?=
 =?us-ascii?Q?yTKKlpE83c7qGEBmu6cLSQAd9tf4eNtIneTgyL8luWoAh8EuTcVORjMu8xSz?=
 =?us-ascii?Q?THmCOdrQJLFxQqdAd8WVqaXU5zxIzmrFbGgK8lZZ4HKV3n7ii6qbN2fpy9rh?=
 =?us-ascii?Q?NcehWgeqV6uZ6lO4u1pdUctTlkxnO2q7tqhXxV0aIu1Ov9rHwbiKIBOQ3X3F?=
 =?us-ascii?Q?7MJ20BJIiWOIvEsytQl4Boh1fgLJqmdvaa0IE909SlJM7e/iUwz6CEakqFhu?=
 =?us-ascii?Q?Y1TNyDdPCB/I4kfMeKGL/mD8OMcVyHDgmRomlP+tPWS6FxD5miHSH9MNxZTj?=
 =?us-ascii?Q?xuwCV6U70A+mESyfqHfdibQMrC6DK6LKQbIQJhGMekh9VLNhnTbPKbcqGfQH?=
 =?us-ascii?Q?5NPrI/mwAbmJ3GP7VSAQqF0AH06WBtlrLC7EOZJr1Rrc8TM1zaN7YXdeVCJw?=
 =?us-ascii?Q?gbtH50f3cW7YksDryURI5kigc5qEUe8TjtGKIvyrCqcHJd8QPO72N2sm/1is?=
 =?us-ascii?Q?CDGqlvRJTHG3P0E87lA+80xtUvO1npQgDM4ODT9hL8BTgzOl+ifFKlCJFK6c?=
 =?us-ascii?Q?8TGq7JfufI3B5/OprXMfrddlNoGD43kIx/LYSbvSKeCs45bNj2fyZk9mKxEp?=
 =?us-ascii?Q?TWrzLkZRivuBdU06Wg6qdEft0amx/GG/Jpl5v7uj+TUYeqD8GpN//IjtCNqq?=
 =?us-ascii?Q?nJccBJrYsNcyPsxFzBCCEcZyvxeeQVKC36vE1X8IowW6zd0TlAp/aHBH4Xl/?=
 =?us-ascii?Q?sxI+FonsSUVKpfqPkf9qAd9o3XwYpjnx1rEkMW81FVriRU1mKG7Fmvsyycri?=
 =?us-ascii?Q?FR/8wP5KzTGztkDITLGXD7n3iV7DD+UD9o2mvuPoEgqDVOJxJ9br4Y1P5tES?=
 =?us-ascii?Q?0Xl00ZlirDrarZqOzcGeCVGLBV9c77iVqNL9rWPnDXUw2A/Bq0DqtVhqJlTX?=
 =?us-ascii?Q?mvQNZ6NAbQ9BWHp7/xkDFEzQR0EN2zXSaiGasyowW2cTOrbVrPynfq9RPE1l?=
 =?us-ascii?Q?wxUf/PN/I0eWQKsqlmmpFJjHGSzgL0nkiD5DVeA/TbLlYtOeArbTsG1ScXZc?=
 =?us-ascii?Q?cLU3m256mbFgDmbBc3qqYXpc9V7/jdBolBJiOLbvANJJbDgA8l1OwDQCVxEH?=
 =?us-ascii?Q?eog9lTNy5Tw9/YnQ0CgqrK0Cn4iDfeYdJk2hT4mvuh7n4/yuYT4oHdIo9QAe?=
 =?us-ascii?Q?V5gEOD3HD3i2J3NDOuX0JcJIe9qPwJJv7qfV9rtcz3I/ultrD3Ygh7rqNvRp?=
 =?us-ascii?Q?JQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: f7bd09d0-c87e-4e3f-538a-08dc3e08b568
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2024 18:10:30.3797
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZhMgiynm4+7NZWYpfGmfd6vzKJa3Y/Oew1HL2a8wzF8PaFaI9z82NrhSiBn/2vzbODcwha+Hb6cm2AV+rvkQROg9ZTDar5Qr5rFEUg9n7KQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SH0PR01MB0682


> -----Original Message-----
> From: Frank Li <Frank.li@nxp.com>
> Sent: Thursday, March 7, 2024 1:45 AM
> To: Joshua Yeong <joshua.yeong@starfivetech.com>
> Cc: alexandre.belloni@bootlin.com; conor.culhane@silvaco.com;
> devicetree@vger.kernel.org; gregkh@linuxfoundation.org;
> ilpo.jarvinen@linux.intel.com; imx@lists.linux.dev; jirislaby@kernel.org;
> joe@perches.com; krzysztof.kozlowski+dt@linaro.org;
> krzysztof.kozlowski@linaro.org; linux-i3c@lists.infradead.org; linux-
> kernel@vger.kernel.org; linux-serial@vger.kernel.org;
> miquel.raynal@bootlin.com; robh@kernel.org;
> zbigniew.lukwinski@linux.intel.com
> Subject: Re: [PATCH v7 5/8] i3c: target: add svc target controller suppor=
t
>=20
> On Wed, Mar 06, 2024 at 04:01:17PM +0000, Joshua Yeong wrote:
> > Hi Frank,
> >
> > > -----Original Message-----
> > > From: linux-i3c <linux-i3c-bounces@lists.infradead.org> On Behalf Of
> > > Frank Li
> > > Sent: Tuesday, February 6, 2024 7:33 AM
> > > To: frank.li@nxp.com
> > > Cc: alexandre.belloni@bootlin.com; conor.culhane@silvaco.com;
> > > devicetree@vger.kernel.org; gregkh@linuxfoundation.org;
> > > ilpo.jarvinen@linux.intel.com; imx@lists.linux.dev;
> > > jirislaby@kernel.org; joe@perches.com;
> > > krzysztof.kozlowski+dt@linaro.org;
> > > krzysztof.kozlowski@linaro.org; linux-i3c@lists.infradead.org;
> > > linux- kernel@vger.kernel.org; linux-serial@vger.kernel.org;
> > > miquel.raynal@bootlin.com; robh@kernel.org;
> > > zbigniew.lukwinski@linux.intel.com
> > > Subject: [PATCH v7 5/8] i3c: target: add svc target controller
> > > support
> > >
> > > Add Silvaco I3C target controller support
> > >
> > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > ---
> > >
> > > Notes:
> > >     Change from v2 to v3
> > >     - fix build warning
> > >
> > >  drivers/i3c/master/Makefile         |   2 +-
> > >  drivers/i3c/master/svc-i3c-main.c   |  35 +-
> > >  drivers/i3c/master/svc-i3c-target.c | 776
> >
> > I think putting target mode files under "master" might not make sense.
> > We might have to consider that we may have a "secondary master" mode.
> > Some other ways of splitting or handling of target mode is needed here.
>=20
> I think name 'master' is not good here. Previously only support 'master'
> mode, it should be fine. Now many controller are dual mode.
>=20
> And I3C spec use 'controller/target' instead of 'master/slave'. I think
> 'controller' as master are quite confused. It can be master controller an=
d slave
> controller.
>=20
> Anyway, slave/master may share some code and resource, even only one file=
.
>=20
> So far, I think it is fine put under master now. we can rename 'master'
> later when more dual mode controller added.
>=20
> Frank

I am currently working on secondary-controller mode. I would like to explor=
e if=20
we can have a different way to implement various modes.

I am guessing that the current inspiration is coming from the existing i2c=
=20
framework.=20

However, I am thinking of having a more generic function to replace the way=
 how=20
we register the i3c driver. (existing 'i3c_master_register' or=20
'devm_i3c_target_ctrl_create' from yours) Maybe along the line where we can=
 have
all the modes set in a struct and return to the i3c framework. So we only n=
eed 1
API to register all the different modes instead of having one each.

>=20
> >
> > ...
> >
> > > +
> > > +#define I3C_SCONFIG	0x4
> > > +#define   I3C_SCONFIG_SLVENA_MASK	BIT(0)
> > > +#define	  I3C_SCONFIG_OFFLINE_MASK	BIT(9)
> > > +#define   I3C_SCONFIG_SADDR_MASK	GENMASK(31, 25)
> > > +
> > > +#define I3C_SSTATUS	0x8
> > > +#define	  I3C_SSTATUS_STNOTSTOP_MASK	BIT(0)
> > > +#define	  I3C_SSTATUS_STOP_MASK		BIT(10)
> > > +#define	  I3C_SSTATUS_RX_PEND_MASK	BIT(11)
> > > +#define   I3C_SSTATUS_TXNOTFULL_MASK	BIT(12)
> > > +#define	  I3C_SSTATUS_DACHG_MASK	BIT(13)
> > > +#define	  I3C_SSTATUS_EVDET_MASK	GENMASK(21, 20)
> > > +#define	  I3C_SSTATUS_EVDET_ACKED	0x3
> > > +#define	  I3C_SSTATUS_IBIDIS_MASK	BIT(24)
> > > +#define	  I3C_SSTATUS_HJDIS_MASK	BIT(27)
> > > +
> >
> > There is couple of space formatting here that requires to be fixed.
> >
> > Cheers,
> > Joshua

