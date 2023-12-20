Return-Path: <linux-kernel+bounces-6897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E940819F14
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 13:34:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B56B9B2473C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 12:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A00524A02;
	Wed, 20 Dec 2023 12:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DCCY2TK3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2044.outbound.protection.outlook.com [40.107.6.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC76249E1;
	Wed, 20 Dec 2023 12:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TRaGmdLCrI4PfVc4Q2rhObpEjIUKx530h7p0H0KjqzwzzBuI70em2yGlplkX8zOdciKbr5jg8ZwdYn1xKuo/iGUt0zzyGCwRwUgbLkWsDO1wTewNJEvSA6iWgpZdmJqysvAK4LeOexEYvsvXd24XaZkSpJD06H5ngYofVVHrDAD4ee5crbFsb1xkKWuwN/0AzxBFw66DaQx3SXaqKq1YGCkYfDHWyayzB775mtESaMJyMjz9I6r6Wd+GPDV04AulnVsbx8o0vAkqYqwF2JNI9opOs7JZkUQ37GXQ9GBHtWKZHfuMXhrVCB0yUTPsMartC6YMSofrMW5dkjwHWwaidw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DUylSDguv8fNELooANkSlKcaHVTBA8OmCoB+/tkCvnY=;
 b=mDCGBJzz+7ACxwIZdwHulPUkGChOsUgzscuH+D7smplMbNaCwWSJD3Zjz9WZqmtO4B99FXVrynp6UhROzg9HFNb9TpK5J1QbXqHkW8gkyUfCYiHQmHSCBP/8NvXii9CUCqjUJDGC1otj7CiUc16sM/33zFDffSafoNYoDNrcQz1L4Ab1ECBMxy/m+7CCLdr7Vqa4VwuF/2IeKuO1bHybzczzciZRDQH880r4wduVnhqaor/0yh87s9ZbfBI7OGCX5AF4+M4LOy7NwxJ5uq9m+2U8mlDyIbZ//phQAyW3f2Aq8c8q6GIoRo7AFvIPPJPe2mqc9fMY4RnkPB6twhvfow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DUylSDguv8fNELooANkSlKcaHVTBA8OmCoB+/tkCvnY=;
 b=DCCY2TK3OKXX9GNteYNgvjxGsPtm7cHu4szZbmuh+91z727F8xO0AKEii57IWRBeQK1wLU3BLWQ5CYTxxmUqBiZ9bu21yXi6o6V99ZaKCGKZ6tQOlSoJv1HGBN0EiQGlbCBi90ETJRbBfcalso36rMq+VLGEiB0JqGG02n0q6Ng=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB9PR04MB9452.eurprd04.prod.outlook.com (2603:10a6:10:367::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Wed, 20 Dec
 2023 12:33:57 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ff06:bbb2:c068:5fb3]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ff06:bbb2:c068:5fb3%7]) with mapi id 15.20.7091.034; Wed, 20 Dec 2023
 12:33:57 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Marco Felsch <m.felsch@pengutronix.de>
CC: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, Conor Dooley <conor+dt@kernel.org>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org"
	<linux-gpio@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Oleksii
 Moisieiev <oleksii_moisieiev@epam.com>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>,
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Cristian Marussi <cristian.marussi@arm.com>, dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 4/7] dt-bindings: firmware: arm,scmi: support pinctrl
 protocol
Thread-Topic: [PATCH 4/7] dt-bindings: firmware: arm,scmi: support pinctrl
 protocol
Thread-Index: AQHaL00vUsuXdEJTYUWYoB3T3FLKXbCxBK8AgABsGdCAALFEgIAAAH0g
Date: Wed, 20 Dec 2023 12:33:57 +0000
Message-ID:
 <DU0PR04MB9417E926CBD95BD7298B64D28896A@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20231215-pinctrl-scmi-v1-0-0fe35e4611f7@nxp.com>
 <20231215-pinctrl-scmi-v1-4-0fe35e4611f7@nxp.com>
 <20231219192912.yulmczvqbuh4jizg@pengutronix.de>
 <DU0PR04MB94170BCA413C2FD48A397B538896A@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <20231220123033.nrbperhbr4jifuvh@pengutronix.de>
In-Reply-To: <20231220123033.nrbperhbr4jifuvh@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|DB9PR04MB9452:EE_
x-ms-office365-filtering-correlation-id: d376f6b4-5580-4176-450e-08dc0157efa4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 7myG+GCBET3uNefXd5xV7Hf8Yj7S1ROGgxJigwh2yL1itpPH40ebaes8EUp4CyBr1ZQkOIKyMrjEQNiKHePCozl1/ngymvaGocvH272azTAsKt8XUQuBeiTXXEVCWkATcB72/moSRu31JSY804eUME6EEWmQ34q0lLDCY02R6mk1xm1jfy5XfPYPea0SuxWX0f8zrkvLuVK9hh3BUazlB9C7pEXtqf8auGGqROzCoXHAHeJnCE5e8tdAAIphnQnKmPVkdrRas1DrwvwGQRLWJsBfsORLrp3+tnegcMPgP8bM5NexkkFKnSlRLSfo2nuxJvaqo0Gp8/DCZQEjGepjTjURft4U7emZ61x4MoW+FxYZ010l+gQylfD9yY57v+ejDJaSAaEEbKc1XF1TjHJYe8ayCOx9zf1M59PHfUuUECAX4HjKJnrtiwwaRb0m6ggnYX71Qlcd6c4aAPoSffuXwvEJEPaMe/1W6aDAx55J6ATzYtnBiFD2d2LmmuhchvrfIOSZhUIntZid0/I9XMKuycCvWI41mglUB52F9eq5zm9U4TtUPlzH7Wk4rFksqWUn4zsY85GsbSTpawLtnv1Tnty3Pmwq79j0nKxvcoN8OmZwCRHWbH5mSdU3XQJMZEzE
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(396003)(346002)(39860400002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(55016003)(41300700001)(38100700002)(2906002)(7416002)(5660300002)(8936002)(4326008)(54906003)(6916009)(64756008)(66446008)(66946007)(8676002)(66556008)(66476007)(38070700009)(316002)(76116006)(86362001)(26005)(71200400001)(33656002)(122000001)(52536014)(44832011)(478600001)(6506007)(9686003)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ELUq2M3qLZrYMYdxOyeeUEHz1L/n/TSIwOwbq8Mq6j4f2DVCKATVyfSNaMrY?=
 =?us-ascii?Q?TvkGn2sssd1sGNHFJjeW7zfOHjQFtm3+QOoRlxLgGHLzEy8GZWa47KfntKhk?=
 =?us-ascii?Q?pO+5X4T/SFMh+VtYF3bZZvti44A/nnh22mihxXDvRB2pzPjB6/bHLRrSObhv?=
 =?us-ascii?Q?74l9ZNVtRSYtApX6lzy+TJmwrwBYPnIQrOrFVXRrAv0DkHuW9TMP29Fh1AZz?=
 =?us-ascii?Q?Dhkvow8VJtJctRq+NN94ZfAmDbBSCSqgOvMv+ttbB4nmH4nggosIPsp5kvmZ?=
 =?us-ascii?Q?TZDzomJGAK6sxb4wvE5AzWSaS4PVXBSmc3+3MsUIQBUbztq4oaWlQkWjHioA?=
 =?us-ascii?Q?ydcIPtwq/cLXfbMrwiqFM/TJC4SyxaUFB2K1EPUnVRt1IQ6pb+nTuzscJK0L?=
 =?us-ascii?Q?6TxVThy+9nls06niFJ4Epm8KEtSBis729KNNFZx7wXSlpWCY4KWBNdnkP7Fg?=
 =?us-ascii?Q?4daGGZqNasuA6evlPk4DL6iwAXRbSWls/A5+xdalIhxXE7S9+cuWgvNTTnEj?=
 =?us-ascii?Q?qncx0zCK1CjlALFzIMxp8rLxapZm2Our4nmptrVhs7XOhs7vFjA6scPq/5Li?=
 =?us-ascii?Q?a2DUPJ6tb96UhGekWEF+2mEyYSikAcuE9vknn3UfEVsGA2y0+bvohXCrZv9a?=
 =?us-ascii?Q?78FHCSlYLWe9MrhGUiO34S96eBstFgOAJqYNbhexK3PHKz75OTqkhfGq4npk?=
 =?us-ascii?Q?6+PqKBt3crloOv+TALNfNTGmQ4RjmLxZlX4VLKLYeLg6D9TTlQB5975UGgbW?=
 =?us-ascii?Q?3Ud61eyH5eH6yDRk7PTlvCREr+D3gKEcJS1frhnsZDSTidIG4olSc+b7CReX?=
 =?us-ascii?Q?S3bfS5czu2jEvaaFETcyCISzkZAhd4uQCD3HlBGLbkhkGJWFfku7b2odczzL?=
 =?us-ascii?Q?zAmCh2Jli7Pud8onWBU6CPFcVyyZ3aGSsjRv3yRubgnKFcH08y6WKfML62Tm?=
 =?us-ascii?Q?0i7iSwiHfRnCXqhW+5CdGpU9JZtOyiB1bpfi616GV6Ufxz5X/Uo0pmlkiqpL?=
 =?us-ascii?Q?XYjaczJ9kOzX4SNOOpKt4OTqcpWBxiaBALUAgc2Li4UMwpwKZOYBMl6KWdNL?=
 =?us-ascii?Q?PLiwKmnYkuioda13AFDI0WQ8+GQBxCu3QHGtRTkDm8Xef9PBpDsC4nUxHCyJ?=
 =?us-ascii?Q?tVoEc3M7a4491elTyJAbgBvINBb4b4yS+hSkDGhmwCBvY40uSaXHhkvj73AX?=
 =?us-ascii?Q?SvWGVN78OOyVInZW5EUZM0dB2oTFsHbIGB9u1ICBoYWqL2Obq2F44HQQuwsn?=
 =?us-ascii?Q?4pfHA3rEYi/g8A2+d8W7bJh+Oh3RixtInNU+PnrGF3Le7tyoXE6HdxILvSVv?=
 =?us-ascii?Q?eOgKqXlhCuwwX8iqK0olmDuMPHhM4MjmlBxPCS/jh0E30J+wS7JGEHYq5S5m?=
 =?us-ascii?Q?rrqegvWCaXOpEJIQVtuNACotMS2VhKEpLdAYqaC8guTGmpaOLR35YLc+pYS+?=
 =?us-ascii?Q?6zthL8heM8LNslfiRQZ5tG5ZXi+XFPihLFtATbqjX+Od92R2+WED+vMAX8qr?=
 =?us-ascii?Q?GGd+owtIkY7mUkyGpeVEuR6Pl4DcZ3MB38fFEtOHwfHDw9YTEkeWpcN9HOWF?=
 =?us-ascii?Q?RjDqe3MSHJUmmHo37AU=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d376f6b4-5580-4176-450e-08dc0157efa4
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2023 12:33:57.3453
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 97/VuPBAyi/3Dz81JsgRFDLvUhZdj1TGKS7w0rXZL7+d3PP6KgMAJtcfjUjlGvV76N94Cr99qBXwn3dE+wXjfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9452

> Subject: Re: [PATCH 4/7] dt-bindings: firmware: arm,scmi: support pinctrl
> protocol
>=20
> On 23-12-20, Peng Fan wrote:
> > > Subject: Re: [PATCH 4/7] dt-bindings: firmware: arm,scmi: support
> > > pinctrl protocol
> > >
> > > Hi Peng,
> > >
> > > On 23-12-15, Peng Fan (OSS) wrote:
> > > > From: Peng Fan <peng.fan@nxp.com>
> > > >
> > > > Add SCMI v3.2 pinctrl protocol bindings and example.
> > > >
> > > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > > ---
> > > >  .../devicetree/bindings/firmware/arm,scmi.yaml     | 99
> > > ++++++++++++++++++++++
> > > >  1 file changed, 99 insertions(+)
> > > >
> > > > diff --git
> > > > a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> > > > b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> > > > index 4591523b51a0..bfd2b6a89979 100644
> > > > --- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> > > > +++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> > > > @@ -247,6 +247,85 @@ properties:
> > > >        reg:
> > > >          const: 0x18
> > > >
> > > > +  protocol@19:
> > >
> > > ...
> > >
> > > > @@ -401,6 +480,26 @@ examples:
> > > >              scmi_powercap: protocol@18 {
> > > >                  reg =3D <0x18>;
> > > >              };
> > > > +
> > > > +            scmi_pinctrl: protocol@19 {
> > > > +                reg =3D <0x19>;
> > > > +                #pinctrl-cells =3D <0>;
> > > > +
> > > > +                i2c2-pins {
> > > > +                    groups =3D "i2c2_a", "i2c2_b";
> > > > +                    function =3D "i2c2";
> > > > +                };
> > > > +
> > > > +                mdio-pins {
> > > > +                    groups =3D "avb_mdio";
> > > > +                    drive-strength =3D <24>;
> > > > +                };
> > > > +
> > > > +                keys_pins: keys-pins {
> > > > +                    pins =3D "GP_5_17", "GP_5_20", "GP_5_22", "GP_=
2_1";
> > > > +                    bias-pull-up;
> > > > +                };
> > > > +            };
> > >
> > > This example is different to the one you mentioned within the
> > > cover-letter. I didn't checked all patches just want to ask which
> > > API will be implemented by this patchset?
> >
> > I kept this change since it was tested by Oleksii, but anyway i.MX not =
use
> these.
> >
> > The API, I suppose you are asking about this?
> > static const struct pinctrl_ops pinctrl_scmi_pinctrl_ops =3D {
> >         .get_groups_count =3D pinctrl_scmi_get_groups_count,
> >         .get_group_name =3D pinctrl_scmi_get_group_name,
> >         .get_group_pins =3D pinctrl_scmi_get_group_pins,
> > #ifdef CONFIG_OF
> >         .dt_node_to_map =3D pinconf_generic_dt_node_to_map_all,
> >         .dt_free_map =3D pinconf_generic_dt_free_map,
> > #endif
> > };
> >
> > static const struct pinctrl_ops pinctrl_scmi_imx_pinctrl_ops =3D {
> >         .get_groups_count =3D pinctrl_scmi_get_groups_count,
> >         .get_group_name =3D pinctrl_scmi_get_group_name,
> >         .get_group_pins =3D pinctrl_scmi_get_group_pins,
> > #ifdef CONFIG_OF
> >         .dt_node_to_map =3D pinctrl_scmi_imx_dt_node_to_map,
> >         .dt_free_map =3D pinconf_generic_dt_free_map,
> > #endif
> > };
>=20
> I see, thanks for the clarification. In short: the i.MX SMCI pinctrl DT-A=
PI is the
> same as the non-SCMI pinctrl API since the dt_node_to_map will convert it=
.

Yes, the fsl,pins format is same whether SCMI or non-SCMI. But we need
to pack the data to a format that matches the i.MX OEM SCMI PINCTRL
protocol, so we need to dedicated dt_node_to_map here.

Thanks,
Peng.

>=20
> Regards,
>   Marco

