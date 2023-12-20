Return-Path: <linux-kernel+bounces-6273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D47BA819698
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 02:58:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1A55B2278E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 01:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86EC779CD;
	Wed, 20 Dec 2023 01:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="mtFqUrjy"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2052.outbound.protection.outlook.com [40.107.104.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87FB32030B;
	Wed, 20 Dec 2023 01:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EqVsPo6o4nQ5b9yh8QYdBuLK8FxXDrrJNfZOlF1tTVg4HA0gcYxKTgeb3aoHYnkrl5xYuV2aAm/S0E4b4z7+VsrP1KOmWAZs2zs20xU0krQ4c6rfAE0WnsZvkC6Dpc16ysYFZQKyR4ZZVmfp+DMooi30/icURx7CAAVHbUxU9uMUlPdTZ0L3i6gj28T90UvpH28a9jCQ3u5IKOwRZTc5bdXOJs6IBHYTs9+g9zIyWadcsbv28XkQAoeZrqnoNu2maUintwBXsKoWBXyz8xOaSAzo9JWO2aiqDLiTYJRIhSBtdUL1GMk3ReclOouTVF5R5qxauSTGqB+Q1AcLUsMKMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nVkpvzcWjhcQOeuN59q1RDf5wmwCFuDuu6LBr8m0ZRQ=;
 b=PEIdE1FJkAq2DgrWCXGay6LG0WAJhEkx4xgK3WjlO8mixpPF0uD/7ouBKj6v73ave2cM4UnAGmp2dTd9aBx5slvUeSr7c8KM4Nple3iNpUItW4bAvkNvFFL2Cevc4VQCY2XMF2nYsy38VqeRHU5dUDUaEZ7G6UTBlBvRfkh5e+OA8Rip07XZV22/GTghO8kvivI1HVdxvZ+YtpMOW3+Km97Xf1DJKuM7eilwSMR3eDQgXSUfuPfiz/r21fK4cNzU3T48AWonyBI3pIKS7/RpvZKWKOlTtbwtEVq/flYnxxHd/u3m3HsBhWyK+2hQcBHF87OznnmQClNCDca+5eMlIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nVkpvzcWjhcQOeuN59q1RDf5wmwCFuDuu6LBr8m0ZRQ=;
 b=mtFqUrjyVkWxvQlrYb14y4pPJmI8biW5aGHDyTu0pLd8Vq8nTvhGpK5F5kgaMHOKQjMQTTlWDB81Y3FivJnj0GZWHJ6q2W2VQjn+lhKMyqN3uxyTJbmpiq/YfBLLSh4iqo4z0jZVWgUAPqlHo5dNbZuiaJRfC4vq7GcO2+VJ5+Y=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU0PR04MB9298.eurprd04.prod.outlook.com (2603:10a6:10:355::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Wed, 20 Dec
 2023 01:58:09 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ff06:bbb2:c068:5fb3]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ff06:bbb2:c068:5fb3%7]) with mapi id 15.20.7091.034; Wed, 20 Dec 2023
 01:58:09 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Marco Felsch <m.felsch@pengutronix.de>, "Peng Fan (OSS)"
	<peng.fan@oss.nxp.com>
CC: Sudeep Holla <sudeep.holla@arm.com>, Cristian Marussi
	<cristian.marussi@arm.com>, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, Oleksii Moisieiev <oleksii_moisieiev@epam.com>, Linus
 Walleij <linus.walleij@linaro.org>, Shawn Guo <shawnguo@kernel.org>, Sascha
 Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, dl-linux-imx
	<linux-imx@nxp.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-gpio@vger.kernel.org"
	<linux-gpio@vger.kernel.org>
Subject: RE: [PATCH 4/7] dt-bindings: firmware: arm,scmi: support pinctrl
 protocol
Thread-Topic: [PATCH 4/7] dt-bindings: firmware: arm,scmi: support pinctrl
 protocol
Thread-Index: AQHaL00vUsuXdEJTYUWYoB3T3FLKXbCxBK8AgABsGdA=
Date: Wed, 20 Dec 2023 01:58:09 +0000
Message-ID:
 <DU0PR04MB94170BCA413C2FD48A397B538896A@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20231215-pinctrl-scmi-v1-0-0fe35e4611f7@nxp.com>
 <20231215-pinctrl-scmi-v1-4-0fe35e4611f7@nxp.com>
 <20231219192912.yulmczvqbuh4jizg@pengutronix.de>
In-Reply-To: <20231219192912.yulmczvqbuh4jizg@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|DU0PR04MB9298:EE_
x-ms-office365-filtering-correlation-id: 2947aa0b-a5c9-4cab-ed24-08dc00ff1dda
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 lJN2JnxNeKHXs/Opn2863u8vhFDW9dY0caSn/guQIGZ36t4GaM9ueOY4TA3svq7WAPP26R8cLkOcOyj/dP+IHhvfAHdy6hyP0X3VyNGepCHi0hRO6DBBI+9N/6g7QAwA1VFGI0bJsIz7uK1qffbuAbOTSOAE2nEweoZmiIABlluvW9AyIoYtFq260dxKh12P4i9odqxEC8r+RePnqJb6yIIfX7rwKGLaWpKPgQlL5Y8INV15IUu0GckS6KEWwTQH/6U5+piD1/fgpAF+wBZAy7+gULO/bRYn2zaMUoS4zDgxeS9fPW3wzUWNCsjlfneNpVbGZUdqgUi3u+6XNBiZ9xkR3xAWzfnDauCm5qRbfSEW5aPLSjD7wPaUexjuen4BLfFe7uoqQqg3Ya0eztiSuDBQGSeL1PVE0sOjzMBXHwJyoG7HcRkI+/f9GWz299g+ZURsP9ANzmfa822IX40eQ8wu8kvykiSOJ12UlPp9arkIwHGfrf+MLK8EXb8pMGSmnd+Ol/1Yx7nxEi3CcDeSU48MjE6ahb+HPO6UYE9y7pEWrZaWLCFJTJD8ikNDEyQNV2X4W3VGn28TnDG49EEIXNB4vu9TEz616QLq65k9iIzf1xkqAj6Sm+vwOY9QPlTp
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(376002)(136003)(346002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(55016003)(8676002)(8936002)(4326008)(316002)(26005)(478600001)(2906002)(52536014)(44832011)(66946007)(66446008)(64756008)(66476007)(110136005)(66556008)(54906003)(71200400001)(76116006)(6506007)(7696005)(5660300002)(9686003)(86362001)(122000001)(38100700002)(33656002)(7416002)(38070700009)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?nYJRLd3phBkj0e0RGVdechtefdvmRCB3vqJbbwPdbGVpYrMOSsCw3iEOPMRX?=
 =?us-ascii?Q?0lmaiLwN+O7z3cwOWea0P5aRlrg+tvt77dupxUMBZvgPeI92T0BWenJzgucD?=
 =?us-ascii?Q?IMB9WZydv7+qVQO514NI7vINMCN2OsnjeKr6r99Ruz4RBUq1ct23mLPSOWnL?=
 =?us-ascii?Q?DOfdrndk7cNrKsagUdVQkeCA3qlFnaS4q8HYubBQG+ZyfHgSHWUFBJ4p+kRB?=
 =?us-ascii?Q?K7niBmtybVu0ZmXebhUbFEt7yr2NtakYjt3ppM2hIGsq1j3VPTLzI3oBCdPb?=
 =?us-ascii?Q?o+8SbYTinfN/YWcY/ENH59v1K5dsRkBH5BMLHpza74w7RUjFVjIWWzrc05RF?=
 =?us-ascii?Q?vpUPX2x5WhXAEdjiBzoUY44kkUEONMGCXvWyI/qIRYDe2z+p0l/eQGj19Hkk?=
 =?us-ascii?Q?1ZqnKObxs0fQCaksHIz9XvTAeWabwKpYKoQyEW33E5p0x4p7QMh6r1hsXajj?=
 =?us-ascii?Q?OqhdqQxvtFI2ovtykIfuUkTHknBdcWpYQgg5V+Vswx974QUKvVN4VLX7R4Cm?=
 =?us-ascii?Q?RoYz5mvd17uH3ydThXl6k9diQ4trnHN+Tcw6BdFDl1pWH046gozZFg5tQPwx?=
 =?us-ascii?Q?605wd6bsSnYNlSPRjdfB8ZsylOBuRVqZmiMUN2v7ZPkMm31MWdTHdtyyFsp5?=
 =?us-ascii?Q?rXtLdAlY1nz6q1v5Zng2N3/veEZMjBG9zX8tvhqpgJOsE/L3lthCpRynr3nX?=
 =?us-ascii?Q?zPG0ZSUSGs6WZtJT2QDYM1020YicMpf2WXrIAbpV2WZTK8rdWj6cVRSyROzA?=
 =?us-ascii?Q?HdiL78ftVPbmfMZkWt85Vr+afvnZ3i+eSAR2ddqPaX2MoMygNj+VxI/Z0cBn?=
 =?us-ascii?Q?hAPzSdNEf/ebitmtvxcsBZjv08NzNDRlQFezOZvGnk60FgOoPSOMB5kJZ0ZO?=
 =?us-ascii?Q?ZqsmhegvxPvyt7xF0WDE/OutO18mvdtxlGGYaa0GtZc/WJoj8HBpqbMeh3iW?=
 =?us-ascii?Q?9wOBYPizX6xuPY0xoTJjq/n87jOe8oGcyv3ut/5/b2sHh6x8a9rDLXY0fEIX?=
 =?us-ascii?Q?SU6DjQ6g342gONJ5VcIM29T7ESdELOAcpiuzeJk1qwt9PxXpxdzNxOYrjBkp?=
 =?us-ascii?Q?vfQuF75m58cgZ3a2Wp+qOKnpUev9VlBWHWACs+Eh1m4nz0GQX63nVSNyZQxl?=
 =?us-ascii?Q?rxL+oWvyf50bNFf4/Sq5KA18ggAT8bL90entRctQ9D9xYHrmrHgHj0t9tq6V?=
 =?us-ascii?Q?r8F4XqlCYyycH/MO1tE6aw7kwncU8AXb4ki+IpOXIOd+KXUouTSGY0XI4ey3?=
 =?us-ascii?Q?vSSDUVj/9A2iiqvf2MbfWtt/Le6N4xVjNU2ovHHHXCWvZOJiY9sg+RcPW2A2?=
 =?us-ascii?Q?SKPsLsvvu4innQdGhbSbFWh4AlULBPE6qOrnZv4RLvVNBv/Gc6iJBV2Jjnfg?=
 =?us-ascii?Q?fKq5oe111Gzsd0VZNXZdVjIM91jNXghdzcZh3K8EvYI+mBOQOAMxcYUUST64?=
 =?us-ascii?Q?41AFPC3vRe2af7TCarrWPE6tQb49hMHxBQbTESIXxWyx2KVGmyk4SFDmIkVm?=
 =?us-ascii?Q?QYED9jmdKgxs87uk6KUr3ZicsSB55FFcBpp8rl0fa6NtK/jgYPaLl96QnEp7?=
 =?us-ascii?Q?Wwccr8hWjrYuYjhTujU=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2947aa0b-a5c9-4cab-ed24-08dc00ff1dda
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2023 01:58:09.7224
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SyzRSk05k0ZVK7rgteYnMV5ATTj2bF41Oj6zGJhz0HO6K/k7+0/MQjyZws3sfC6mzFHG2P2YiAk8ncLPfTflEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9298

> Subject: Re: [PATCH 4/7] dt-bindings: firmware: arm,scmi: support pinctrl
> protocol
>=20
> Hi Peng,
>=20
> On 23-12-15, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > Add SCMI v3.2 pinctrl protocol bindings and example.
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  .../devicetree/bindings/firmware/arm,scmi.yaml     | 99
> ++++++++++++++++++++++
> >  1 file changed, 99 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> > b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> > index 4591523b51a0..bfd2b6a89979 100644
> > --- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> > +++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> > @@ -247,6 +247,85 @@ properties:
> >        reg:
> >          const: 0x18
> >
> > +  protocol@19:
>=20
> ...
>=20
> > @@ -401,6 +480,26 @@ examples:
> >              scmi_powercap: protocol@18 {
> >                  reg =3D <0x18>;
> >              };
> > +
> > +            scmi_pinctrl: protocol@19 {
> > +                reg =3D <0x19>;
> > +                #pinctrl-cells =3D <0>;
> > +
> > +                i2c2-pins {
> > +                    groups =3D "i2c2_a", "i2c2_b";
> > +                    function =3D "i2c2";
> > +                };
> > +
> > +                mdio-pins {
> > +                    groups =3D "avb_mdio";
> > +                    drive-strength =3D <24>;
> > +                };
> > +
> > +                keys_pins: keys-pins {
> > +                    pins =3D "GP_5_17", "GP_5_20", "GP_5_22", "GP_2_1"=
;
> > +                    bias-pull-up;
> > +                };
> > +            };
>=20
> This example is different to the one you mentioned within the cover-lette=
r. I
> didn't checked all patches just want to ask which API will be implemented=
 by
> this patchset?

I kept this change since it was tested by Oleksii, but anyway i.MX not use =
these.

The API, I suppose you are asking about this?
static const struct pinctrl_ops pinctrl_scmi_pinctrl_ops =3D {             =
                          =20
        .get_groups_count =3D pinctrl_scmi_get_groups_count,               =
                          =20
        .get_group_name =3D pinctrl_scmi_get_group_name,                   =
                          =20
        .get_group_pins =3D pinctrl_scmi_get_group_pins,                   =
                          =20
#ifdef CONFIG_OF                                                           =
                        =20
        .dt_node_to_map =3D pinconf_generic_dt_node_to_map_all,            =
                          =20
        .dt_free_map =3D pinconf_generic_dt_free_map,                      =
                          =20
#endif                                                                     =
                        =20
};

static const struct pinctrl_ops pinctrl_scmi_imx_pinctrl_ops =3D {         =
                          =20
        .get_groups_count =3D pinctrl_scmi_get_groups_count,               =
                          =20
        .get_group_name =3D pinctrl_scmi_get_group_name,                   =
                          =20
        .get_group_pins =3D pinctrl_scmi_get_group_pins,                   =
                          =20
#ifdef CONFIG_OF                                                           =
                        =20
        .dt_node_to_map =3D pinctrl_scmi_imx_dt_node_to_map,               =
                          =20
        .dt_free_map =3D pinconf_generic_dt_free_map,                      =
                          =20
#endif                                                                     =
                        =20
};

Thanks,
Peng.

>=20
> Regards,
>   Marco
>=20
> >          };
> >      };
> >
> >
> > --
> > 2.37.1
> >
> >
> >

