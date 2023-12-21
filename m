Return-Path: <linux-kernel+bounces-7725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7313481AC3A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 02:31:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC3571F2433D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 01:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6DF4187E;
	Thu, 21 Dec 2023 01:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="secysEIG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2048.outbound.protection.outlook.com [40.107.8.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C04258B;
	Thu, 21 Dec 2023 01:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d/ncyb7poZ7+gN68z5PyDaME9PLZAnwuXo4OOA5Hph+DgHNoAeCi9COwVK0KfeFcsV8QD9evKOZB9pwSW9DzLH7m4LZ8sjsPQqCJqje6vQI4ySuHT0I3WtQ7zQ11TnV9Gqh3vgIr78/XKwJTOL27eCxPg+LIIOhXUT6L+Wl10MTkf90hiGNoROmaN+slIJsHpt2hDoRyNFQJCIO5ofnq95JqsVRyv9v01T5t0LKFlsPvLY8Rr/Pi1feoGdE0NIE3zXo/X4dqRUKq4OCNF/X8qrj1N4LsNd7vwCJsAmB0XV+FhJFJVvJp1K+pCWQuKBMJclXK/YzG+hU7FSoUQa/7wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WnQ5kXKMflYLhB9jobiuP9wisvfAEBXPKwiknV58/ks=;
 b=cpDwwXO3efsCcfABlfdokk9w7+hcuFFLNJT9MjeghaxvoBLlPAx8MOraWwIZ4SJAz/0Mb0Hx4BsUq1eRjMbcukArlOc/oshkqD1xUDHfwRuyWDh7Lgxk9VfretqereW1RXjS1A8AkTT5BGsrYCnc/dFH//JJWLZeokdrs7t58i+0QpknToVxz1YqNkZDz2VbFcXm5Fz0A1qnMSr4fVMDqlgEVt64UTq6eWdR93mTliP4Pt6D9Du0V1bpWf32AMHdffpIMSdvkgoTnhiC6BpI/hGgb0DbowugxytsAJdWdtGQfPlG7XlrJfXMpl2ZQGJUNOiIK6NVPtyQQbvSm0MJbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WnQ5kXKMflYLhB9jobiuP9wisvfAEBXPKwiknV58/ks=;
 b=secysEIGYvXLXsdVSuoeTzPLuhrsYGFdekMmhaKSK1bbN5uS6W0URUAeiuVNPa+Z2n8/2CVklsFAxn/pMXUIbRdjefFGf/7+0CxllO24lUX4UQWKvTC5e/ELx2ZUvkClb3ogdMCxlcWVzqrDqlf1V09NQMpFO7HL7tiGnVQ0MEw=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBAPR04MB7415.eurprd04.prod.outlook.com (2603:10a6:10:1aa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.20; Thu, 21 Dec
 2023 01:31:27 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ff06:bbb2:c068:5fb3]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ff06:bbb2:c068:5fb3%7]) with mapi id 15.20.7091.034; Thu, 21 Dec 2023
 01:31:27 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Marco Felsch <m.felsch@pengutronix.de>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Cristian Marussi <cristian.marussi@arm.com>, "Peng Fan
 (OSS)" <peng.fan@oss.nxp.com>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Shawn Guo <shawnguo@kernel.org>, Linus
 Walleij <linus.walleij@linaro.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org"
	<linux-gpio@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Oleksii
 Moisieiev <oleksii_moisieiev@epam.com>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Sudeep Holla <sudeep.holla@arm.com>, Fabio Estevam
	<festevam@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 4/7] dt-bindings: firmware: arm,scmi: support pinctrl
 protocol
Thread-Topic: [PATCH 4/7] dt-bindings: firmware: arm,scmi: support pinctrl
 protocol
Thread-Index:
 AQHaL00vUsuXdEJTYUWYoB3T3FLKXbCxBK8AgABsGdCAALFEgIAAAH0ggAABhoCAANgEsA==
Date: Thu, 21 Dec 2023 01:31:27 +0000
Message-ID:
 <DU0PR04MB941736A1EEE3A98F188A59488895A@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20231215-pinctrl-scmi-v1-0-0fe35e4611f7@nxp.com>
 <20231215-pinctrl-scmi-v1-4-0fe35e4611f7@nxp.com>
 <20231219192912.yulmczvqbuh4jizg@pengutronix.de>
 <DU0PR04MB94170BCA413C2FD48A397B538896A@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <20231220123033.nrbperhbr4jifuvh@pengutronix.de>
 <DU0PR04MB9417E926CBD95BD7298B64D28896A@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <20231220123745.ksdumfymu4xruufa@pengutronix.de>
In-Reply-To: <20231220123745.ksdumfymu4xruufa@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|DBAPR04MB7415:EE_
x-ms-office365-filtering-correlation-id: 988d9df1-5604-4071-71e5-08dc01c48d55
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 KrPh5rS3/ScxrkNCicDcoQNmvrzLpp0MmqFTFHlkwV51HSmS5uwn0lvEZoTB6b7PXr9hI77Dxh2XVYotmMBkq4oUHM3FakfujXagG7BYXj7DLPt4CpM4Bxabjzbm4yQkocwZSzY2ziHD9t0sJs0SfdQGfVDrO2OkJvKOz698esQhAc+K4s5HSWBrDiOM7JYPz3AjN0//GgzZtOIPFd4phwZuIi8DpQDGFMeLas4EgvX2FwD2ZsSyZhXeHr9wZOuJvktUnO+hSaYjx6xZzy5JtIpp2cdYNa6Mv1jWIC4ofszQfjqWMYuIHaNFjBnNsqGg3v/mKuq4qkLT1BqQ4RyIptJbd3OP2ZHhwaRErH456A66d01YrAaUUWf/FUpsUZwAqA0j03ID5DRyJnZf6ke9fQMBdvlYLxst4097uFK8Qgk9pG9pN8Mu4kvH1TDIeezk8NQsViKJTMBRoA9vcOQwyjfBeVOQOJLIEmVhnE8fKlYlgxputdTxR10YRK1GUumR66zPnbWmDRa1sX92T+CKTq6QM6SKLt+FWAcnTxax1zXIpML1WN3Ftzi1V3XdGtHr1lSfJEGYbRibASok4WCTnpT5eCblxb2LO6lYKX+6hgs=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(376002)(346002)(136003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(76116006)(33656002)(66946007)(66556008)(6916009)(26005)(54906003)(66476007)(66446008)(64756008)(966005)(478600001)(55016003)(8676002)(83380400001)(4326008)(8936002)(52536014)(38070700009)(71200400001)(316002)(7696005)(9686003)(6506007)(44832011)(7416002)(5660300002)(2906002)(38100700002)(41300700001)(86362001)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?CyKOASUHnmeROaHzDne9GtFuJlxymWKhaLLJMc3+8v2AnqbOtXgyGZsZPqSr?=
 =?us-ascii?Q?DC1mGoxZvsZnsT4RUH9t6V8O9CHbtU5lxC54YcpW1OwaTh2p6WA0ePsIRW83?=
 =?us-ascii?Q?/KXq3/RPGfDbqHQUQNIAOAH8yHXmrlu0v8Xx0Y1FpEheLgX4GehSr0hyHVsZ?=
 =?us-ascii?Q?KOgNq4rMokteQAeI+QPDw2QfUJ4kYvAwbMm4CT9X/8KGgq9GW67p3VLTe0n+?=
 =?us-ascii?Q?m4DEqMPiwfPPfPrmKhcni84YFWtYOI3kZ1eY9dMzWYmX2ko24Bqk7xWIkITy?=
 =?us-ascii?Q?LniqD/HQ4ZjYxiYgGtmsbYIa+PJtK6T2kMXkH6Ab59+9IWUGkPPt4ZO1TmI3?=
 =?us-ascii?Q?KE8G7mK+E+XbnRngehI9ZfXYMnyPsHYXHxYy+z8wc4vQXaFnD8KIX1lV9waR?=
 =?us-ascii?Q?T4mnPqLeKXjlkc1SkKX8zjh3M4he9fn6RL9rIS8k6yHe/M7fuuiUexiIvMAw?=
 =?us-ascii?Q?eQyFkFCreWpNFjLqo+Ad89LB6foxguk04SoziRr1rwZOMn835sz8Y+Y9zE+/?=
 =?us-ascii?Q?p0+Zp4J/xMzTgei119NRaM9o13hx6bfKqVI8K4vdi1XttwTQVbTHsANqZfts?=
 =?us-ascii?Q?4ohIIKbB8K27BOqf/m9dvfMSEikHS9rsNkJPvR0dDHcNTFBLJANqE8mgW13l?=
 =?us-ascii?Q?3uDtapupTsDXrcXVAjTWiSR1ZiBlkdOFJPiCC83NI5yyAfRrMOYgG1bggU1f?=
 =?us-ascii?Q?dP4gyBqi4LCr3tA0O0DdyFCT6V9z1aT4y2fr+rxNeBEcgfdjM1L/RnKx0cY4?=
 =?us-ascii?Q?MePH3qlZWTU8Vt/2V1p6cq0awKopaj6Z+Ibvd5es8JoOdEVJDMZ4h635jlTb?=
 =?us-ascii?Q?oYRQrFH0Mg5oJ4YEBr5PEmW1ysPwy2wsmegFB/vW7IxeX7l+p08qZHEe3pjs?=
 =?us-ascii?Q?Jfbb5F1oO9cv7EQNeM14+wdjeynzsZxBq+LGRFRMLQ6QBNN6ujMv/27eq57x?=
 =?us-ascii?Q?Way0q1JAgqY4WmfZxy9TFKLhPuljOnOFM0Djb1Rk1hAWlpRGasybIR5k3ph4?=
 =?us-ascii?Q?e3iHYbdz8SRBXJwCRcISYrNrImQzkALOZ3tcXePQdrL94W/CpRBGBLw8K3vx?=
 =?us-ascii?Q?3ldYsnr7v70+k4k/Qso5W/rEXiYxubJuCWqshyRJQbc282nzJhwU5J5kcezl?=
 =?us-ascii?Q?cPbCY2c5e8knRiGqkG6H7Q/udyATgcqEbfogd5pZ+WzuSBNpMVVAcU19p2UH?=
 =?us-ascii?Q?g2HWDbZj+iQqjOPkKLwcFE5WFc2dYW/kyZ26C6ljIHa6WAl98kksAwOKVM9K?=
 =?us-ascii?Q?j5Ni6WTlSl77W/y5HW4gPFQM3ckwmrkP1oxb8XB08Fm9xMPZQbdHnbvRCjyB?=
 =?us-ascii?Q?ioMU6k7sBwWr5HHRkSYn6NuRgt882K12R5RbM6R24pnaZa1rdzC2u7Ooeb4N?=
 =?us-ascii?Q?bIAuFs5W0xWEvMMCVmzgKYJ9WMZ3I62R3UMy5xFBkK587jsTZHn97lIxrSOM?=
 =?us-ascii?Q?nFmCK2aJLx2/3XXq1NJ2LylYxa5kbizApXqe7Q4tGVk+cDt+vd+lKvvcdCoN?=
 =?us-ascii?Q?vvRyaZe7wDIn4JBE8lYZLi7XiU5SHZA9MasC36Ska+t6CSpUo5Lu2oTMM0QE?=
 =?us-ascii?Q?HvtCY9aNTDDhcNFnSFc=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 988d9df1-5604-4071-71e5-08dc01c48d55
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2023 01:31:27.5927
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yU6ejnToMkv/hR+pnmHAlOaIKhRod315Xpg/0FE5IBakXnGHBQ/BRvLQF00gS4MoVk71INWOIIizG7zL+V1oEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7415

> Subject: Re: [PATCH 4/7] dt-bindings: firmware: arm,scmi: support pinctrl
> protocol
>=20
> On 23-12-20, Peng Fan wrote:
> > > Subject: Re: [PATCH 4/7] dt-bindings: firmware: arm,scmi: support
> > > pinctrl protocol
> > >
> > > On 23-12-20, Peng Fan wrote:
> > > > > Subject: Re: [PATCH 4/7] dt-bindings: firmware: arm,scmi:
> > > > > support pinctrl protocol
> > > > >
> > > > > Hi Peng,
> > > > >
> > > > > On 23-12-15, Peng Fan (OSS) wrote:
> > > > > > From: Peng Fan <peng.fan@nxp.com>
> > > > > >
> > > > > > Add SCMI v3.2 pinctrl protocol bindings and example.
> > > > > >
> > > > > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > > > > ---
> > > > > >  .../devicetree/bindings/firmware/arm,scmi.yaml     | 99
> > > > > ++++++++++++++++++++++
> > > > > >  1 file changed, 99 insertions(+)
> > > > > >
> > > > > > diff --git
> > > > > > a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> > > > > > b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> > > > > > index 4591523b51a0..bfd2b6a89979 100644
> > > > > > --- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> > > > > > +++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> > > > > > @@ -247,6 +247,85 @@ properties:
> > > > > >        reg:
> > > > > >          const: 0x18
> > > > > >
> > > > > > +  protocol@19:
> > > > >
> > > > > ...
> > > > >
> > > > > > @@ -401,6 +480,26 @@ examples:
> > > > > >              scmi_powercap: protocol@18 {
> > > > > >                  reg =3D <0x18>;
> > > > > >              };
> > > > > > +
> > > > > > +            scmi_pinctrl: protocol@19 {
> > > > > > +                reg =3D <0x19>;
> > > > > > +                #pinctrl-cells =3D <0>;
> > > > > > +
> > > > > > +                i2c2-pins {
> > > > > > +                    groups =3D "i2c2_a", "i2c2_b";
> > > > > > +                    function =3D "i2c2";
> > > > > > +                };
> > > > > > +
> > > > > > +                mdio-pins {
> > > > > > +                    groups =3D "avb_mdio";
> > > > > > +                    drive-strength =3D <24>;
> > > > > > +                };
> > > > > > +
> > > > > > +                keys_pins: keys-pins {
> > > > > > +                    pins =3D "GP_5_17", "GP_5_20", "GP_5_22", =
"GP_2_1";
> > > > > > +                    bias-pull-up;
> > > > > > +                };
> > > > > > +            };
> > > > >
> > > > > This example is different to the one you mentioned within the
> > > > > cover-letter. I didn't checked all patches just want to ask
> > > > > which API will be implemented by this patchset?
> > > >
> > > > I kept this change since it was tested by Oleksii, but anyway i.MX
> > > > not use
> > > these.
> > > >
> > > > The API, I suppose you are asking about this?
> > > > static const struct pinctrl_ops pinctrl_scmi_pinctrl_ops =3D {
> > > >         .get_groups_count =3D pinctrl_scmi_get_groups_count,
> > > >         .get_group_name =3D pinctrl_scmi_get_group_name,
> > > >         .get_group_pins =3D pinctrl_scmi_get_group_pins, #ifdef
> > > > CONFIG_OF
> > > >         .dt_node_to_map =3D pinconf_generic_dt_node_to_map_all,
> > > >         .dt_free_map =3D pinconf_generic_dt_free_map, #endif };
> > > >
> > > > static const struct pinctrl_ops pinctrl_scmi_imx_pinctrl_ops =3D {
> > > >         .get_groups_count =3D pinctrl_scmi_get_groups_count,
> > > >         .get_group_name =3D pinctrl_scmi_get_group_name,
> > > >         .get_group_pins =3D pinctrl_scmi_get_group_pins, #ifdef
> > > > CONFIG_OF
> > > >         .dt_node_to_map =3D pinctrl_scmi_imx_dt_node_to_map,
> > > >         .dt_free_map =3D pinconf_generic_dt_free_map, #endif };
> > >
> > > I see, thanks for the clarification. In short: the i.MX SMCI pinctrl
> > > DT-API is the same as the non-SCMI pinctrl API since the dt_node_to_m=
ap
> will convert it.
> >
> > Yes, the fsl,pins format is same whether SCMI or non-SCMI. But we need
> > to pack the data to a format that matches the i.MX OEM SCMI PINCTRL
> > protocol, so we need to dedicated dt_node_to_map here.
>=20
> Yes, I saw that you're using the enum values 192-255 for the OEM specific
> part and the packing. Does you have public access to the FW implementing
> the SCMI?
>=20
The system manager firmware:
https://github.com/nxp-imx/imx-sm

Regards,
Peng.

> Regards,
>   Marco
>=20
> >
> > Thanks,
> > Peng.
> >
> > >
> > > Regards,
> > >   Marco
> >
> >

