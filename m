Return-Path: <linux-kernel+bounces-27410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6796482EF9A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 14:17:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C949F285CD2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 13:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 195771BC50;
	Tue, 16 Jan 2024 13:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Y3xsVgOn"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2058.outbound.protection.outlook.com [40.107.7.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EEAB1BC40;
	Tue, 16 Jan 2024 13:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eCao0mzV3RTVVuy/frHJ2KuGAAQj0ljibiisLwfSOrT4SVpWa+fWzvcqGkk21tOfWhCu2rD6akxaor9lN2NQyx+JH76yKmzeA0rjX5WFZkGg/ENGkTW4HQw/nd6mQuZI992748Euib1rejxZNoAOYY2KXtwvqJjyx1DDdkLeqilSeYuBVeOBmLBRPtAV76Ikll1bBlKh2uPrHtpzqisEGfwOzzvcszIpCCj7jY50P93QM8XFGjCAgs5QmWLP8f6hRivB4YWHXzs+YE+rQY2Fo1X0ZGpNxZKZwb7VIxLnMpQ0xPLMTjmfNvBw3fHvulqLKtAXqMAIaa92UlPzKNWq4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6WJ/lYblU/QZD4lWtsg7vGq9vldKGcJhER80ZEjSg74=;
 b=jPjCktqry7Ch4uV+tdjS/JFie6zC3cl+sScZbPYYCHLQoesJ1nIherSqUAOs1zv7KZ4zsA+nSku2VNyzo488ucPcvJX/5eq1jlZBbKK/FpABYkJSMm4Tr0k7CcWD1kI6O6O2e5mBreZEYR7+OIEVRnmaRqj/Dr2sJAaFB9eXMr/WskrHeS5rxbs8W+r3psmWCI5r5Za0mpnQZRpRdhrIPuBog/pYS2YKTPAhTUzSRpyVEH/pQ29iOofYqJ3YHf/JxjlKIj8cXp2RulppxvVeKPGj4xhp/8gXy50VKCODB561OltTvWe1aXXwtzyLohVQC1EsDHGWZMEsv+Oudn2U7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6WJ/lYblU/QZD4lWtsg7vGq9vldKGcJhER80ZEjSg74=;
 b=Y3xsVgOnPPFJOEIyXvCWwayV1+IL979ZwAj0wTxYt/Ujbj98peqgH9p30rB7ab96WpnU782fd6RJOgI3S7d1kpAEmEdVKMx83xqOmab/E15ekrl8V8V5b6uxgD4f7NEP3KyJVlADuQGuFylXJUx94l0Jqs+k5EToBufN90d0V3I=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by GVXPR04MB9877.eurprd04.prod.outlook.com (2603:10a6:150:113::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19; Tue, 16 Jan
 2024 13:17:34 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6%3]) with mapi id 15.20.7181.022; Tue, 16 Jan 2024
 13:17:33 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Martin Kaiser <martin@kaiser.cx>, Linus Walleij
	<linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>
CC: "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] gpio: vf610: allow disabling the vf610 driver
Thread-Topic: [PATCH v2] gpio: vf610: allow disabling the vf610 driver
Thread-Index: AQHaSGKiX8R/XBAo+UO+5hOIoYrpR7Dca6LQ
Date: Tue, 16 Jan 2024 13:17:33 +0000
Message-ID:
 <DU0PR04MB9417E14E02B3DD7E836AAF5788732@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240116095845.47458-1-martin@kaiser.cx>
In-Reply-To: <20240116095845.47458-1-martin@kaiser.cx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|GVXPR04MB9877:EE_
x-ms-office365-filtering-correlation-id: a463dc56-a47a-4676-876d-08dc16958058
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 e+GUpUWMpi50JyimeCiANCS4tgw3WSHF1rE+f/UFLdCuOROfVWgE0VtX9OYCc0kJu20OAYkwrGLCQh1wgEwCqEV80F9XXNj+/h/J1thY9pOEcRm+q9hPJjutiGIhZ7jHX+JO2qelhYxZvV32dqd1da2sBSllZ3dNqEP93go5XwMkqa8kwoPdmtBjZ9XsSH3By0/L6OtCqvrY2B9wTZRXva0r5cKjUEB55hpawS+VFaDLulFdcak/vDfJkHj1R0rCWxH3/iXZAjEz0S/XaBGDOYItP4tyIBx5thOYhAjjpYvD8/yrj3LTIHY0N+gIKLV6sP+h9YkWmhEfRY7bsCsSnYFTh1XGnvh1gA0tSVYK0VCZdExtyOEgW77km/k38WY6HWnjiOVRLiBdTvzjs9chjnzaoU7QnHqkGxjdSPeSWvyeSa+qf2KJTnNIacgSVVfkFSj3S1HZ2pwLC83iSFX5WHidMkEmld0dMQEadrEPmfOqB1K/MAZaxxtjtRuT6R6v2XIXafZ/tQcgnuYTyQpruvtJBpqdoI+MyK3HgiG2QyDsm853tKK8ycHtiEM213JnZWBfkT07bQ7NMfoCBEdZ+Xk4m9TJWbQBJAb+Kt9YFcJEVUnlhvD0OY/moK+MI5Rm
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(346002)(136003)(376002)(396003)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(83380400001)(33656002)(38070700009)(86362001)(41300700001)(122000001)(64756008)(38100700002)(54906003)(66476007)(8936002)(8676002)(66446008)(6506007)(5660300002)(7696005)(9686003)(316002)(52536014)(110136005)(44832011)(478600001)(4326008)(26005)(55016003)(66946007)(76116006)(2906002)(71200400001)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?+r72BWtnPkopKlCJ5baYJwgkAcb1ukLr1kaWEEcgzz+j3PbLlGs0OoaWxKR2?=
 =?us-ascii?Q?Qz56RVyjWW8LIK2xrPL2+miTWxa7DP/LaKJKsj0y/Ct9QK122hamlmHDKD6u?=
 =?us-ascii?Q?9SPJ1+PtnyYsGObihka7fWWG6t+SC2ScCorv6QCVB6HsAO2woiy0WqjffPKm?=
 =?us-ascii?Q?LRtKCR/QizZjXNnmaScyoeISXRh/5E59a7YwOXCQkw4NJ0eFB4bZ5SDzF2TI?=
 =?us-ascii?Q?pi0zFnsdNZYwxfpude8t8+R0iBeW2A6YO3z/5hUU0l0oVoc7WppvXZi0753N?=
 =?us-ascii?Q?UiFfoQbhO8yVyM9PinBTC3ELkZ+gUd+XBUi9JsXmKOqI9WV2IE6NmFmmK8JG?=
 =?us-ascii?Q?jfhwlzGtppWReoLI5cvi9quWhk1TUb7UG69LLtBpUMULanlhhVwx/SsLzrpj?=
 =?us-ascii?Q?g6Tpv8l0XmOiCYgbA3QRRmyNML814hhI3eVhC5tRTrBoVkTzMVN8+FbgEsRf?=
 =?us-ascii?Q?ygL2ob3Riw8LFZ7Oh9lfLnlcOLGUkMEzOBLXotoGBO2iaJ/Hza75ioZj40tg?=
 =?us-ascii?Q?eJrjseysXwnbsEHrdaPD5am079CTATNSwF291tmAUUrYV50e2oPJHJ89b+1m?=
 =?us-ascii?Q?1EweZ7U/xpWMI3so/twAgDpzZB67NyRyYIyx6qPU5LRF+q1q2mdW1sJ7PjJ5?=
 =?us-ascii?Q?S8ZL9RocGw0eggslrXR3kZxZEajifYesI/aguGv/obwd0GtwS6hSEY3ZEX1Z?=
 =?us-ascii?Q?bRTnDDAlZkzU7KMtjZDHmQsEVCS/09ZJLF+r4a8oiWdM2mqVLFjkVmO1Okbo?=
 =?us-ascii?Q?CNRGH2c3x1INcclfRU0qu0lnox1UJiHJMjL9mbPiTnTX14TItGIFKsSYsnN6?=
 =?us-ascii?Q?81cejZ7Rrvm4PQMT8i8o6j3wmevim/HEg5IPn6PFOjurn0SXOXrXxOdsGFPr?=
 =?us-ascii?Q?XAfi/VEZn4wLjqDuJx+evR2Vl2gWOg341f+ZP4U0GmwGj6yyjZVFM0ShJes7?=
 =?us-ascii?Q?ejiEYmiwzUlS+y9QTWfaVdwU6b5w6oj3fJlWoHSiGqY/AGZe259l2LcOtwGE?=
 =?us-ascii?Q?pPlIsXrJaqR4anD2V0PFB+xyJEjqjYeizl7oItpB3M6funYsDj5Sp7czPLjc?=
 =?us-ascii?Q?IXWgcn1/flrN8ydYznjavuFoeyQCZaGtJLiWLKaNRGsYO+AQRI2NeEJrTGrH?=
 =?us-ascii?Q?oZEvSrZNZnu7rklSy5Kutl2IzPcsokl/+DPFR3gMQ8vMuLtj1tisewWVZsB+?=
 =?us-ascii?Q?aPGBoxv7M2/Mj57R3+NxzqxlL/IGHcPfyqquXXAVToWBhwULXnr4dOLynHDe?=
 =?us-ascii?Q?2KgEOe2WbawKLJBuyaphS26mLlQzLaz6qCX1cULrc00TJySNmDSqLGCCuU5Q?=
 =?us-ascii?Q?4a0/V8W/RsAWZMUBDuS09V9wb7WAhtr2cobOM1FztPYL+fCx+QWrVX7jRF1e?=
 =?us-ascii?Q?SqQwmRxRV4myyH05KTEC9kGvH/EW6nYTszEaXCQfEN2av+r3XS/iRlfQSwjy?=
 =?us-ascii?Q?prE0VRVZO4qyDGF2Q/iFUuLoAc+vGUoGH//jmB1ejCtfRLbDQ6NqOQrrZrlv?=
 =?us-ascii?Q?7DO4W9FuFpDUHe5+0EcqbYMtxH9PEYyPPMOSUxIxJhDxbP6cfWBOq5Va8gR5?=
 =?us-ascii?Q?ZFT5qOoO445JMLV1sgU=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a463dc56-a47a-4676-876d-08dc16958058
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2024 13:17:33.8838
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1F9GigJ+C4kPW+/WVjGX4hlSCazmXp+Wruf6Aw57Fk1c5oUhPT1bYbdHVMaKkzpqjqaILApJivKDUpjFw+iqZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9877

> Subject: [PATCH v2] gpio: vf610: allow disabling the vf610 driver
>=20
> The vf610 gpio driver is enabled by default for all i.MX machines, withou=
t any
> option to disable it in a board-specific config file.
>=20
> Most i.MX chipsets have no hardware for this driver. Change the default t=
o
> enable GPIO_VF610 for SOC_VF610 and disable it otherwise.
>=20
> Add a text description after the bool type, this makes the driver selecta=
ble by
> make config etc. Enable the driver in arm64's default config and in
> imx_v6_v7_defconfig to support chips like i.MX7ULP, i.MX8QM, DXL, ULP
> and i.MX93.
>=20
> Fixes: 30a35c07d9e9 ("gpio: vf610: drop the SOC_VF610 dependency for
> GPIO_VF610")
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
> v2:
>  - enable the vf610 gpio driver in the defconfig files for arm_v7
>    (i.MX7ULP) and arm64 (i.MX8QM, DXL, ULP and i.MX93)
>=20
>  arch/arm/configs/imx_v6_v7_defconfig | 1 +
>  arch/arm64/configs/defconfig         | 1 +
>  drivers/gpio/Kconfig                 | 3 ++-

This should be in three patches:
1. gpio/Kconfig
2. imx_v6_v7_defconfig
3. arm64 defconfig

Regards,
Peng.

>  3 files changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/arm/configs/imx_v6_v7_defconfig
> b/arch/arm/configs/imx_v6_v7_defconfig
> index 0a90583f9f01..3cdcb786f33f 100644
> --- a/arch/arm/configs/imx_v6_v7_defconfig
> +++ b/arch/arm/configs/imx_v6_v7_defconfig
> @@ -208,6 +208,7 @@ CONFIG_PINCTRL_IMX8MQ=3Dy
> CONFIG_GPIO_SYSFS=3Dy  CONFIG_GPIO_MXC=3Dy  CONFIG_GPIO_SIOX=3Dm
> +CONFIG_GPIO_VF610=3Dy
>  CONFIG_GPIO_MAX732X=3Dy
>  CONFIG_GPIO_PCA953X=3Dy
>  CONFIG_GPIO_PCF857X=3Dy
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index e6cf3e5d63c3..915c7c8fd13f 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -632,6 +632,7 @@ CONFIG_GPIO_SYSCON=3Dy
> CONFIG_GPIO_UNIPHIER=3Dy  CONFIG_GPIO_VISCONTI=3Dy
> CONFIG_GPIO_WCD934X=3Dm
> +CONFIG_GPIO_VF610=3Dy
>  CONFIG_GPIO_XGENE=3Dy
>  CONFIG_GPIO_XGENE_SB=3Dy
>  CONFIG_GPIO_MAX732X=3Dy
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig index
> 1301cec94f12..353af1a4d0ac 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -711,7 +711,8 @@ config GPIO_UNIPHIER
>  	  Say yes here to support UniPhier GPIOs.
>=20
>  config GPIO_VF610
> -	def_bool y
> +	bool "VF610 GPIO support"
> +	default y if SOC_VF610
>  	depends on ARCH_MXC
>  	select GPIOLIB_IRQCHIP
>  	help
> --
> 2.39.2


