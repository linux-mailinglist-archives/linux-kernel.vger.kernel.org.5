Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC457A3EC3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 01:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232719AbjIQXHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 19:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231491AbjIQXHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 19:07:31 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2081.outbound.protection.outlook.com [40.107.6.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A0011B;
        Sun, 17 Sep 2023 16:07:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W+Y2NVFTVIReeE5CwfX7x2GrSFICgL5+M8UZ3R8U0a2O2meupWoiFR6TJP+lLIAfiOFIC0NhIrHeW7Nr2OXUXGnJinsS3GLyZesQCER++COOEGoAwxG2HRJtnOVgfzfjcG3kU702ShefwZNbxpP9LDqRFzKqqYAdK9ro+IskRokMpZ5CTx/1/HlmM6k2Boqjk74HLJNgbTUCumaC5jtZZcoqZdE2uxtLX6qiLM3WQPjHdJHSYlgqArLEOG+wHOFRnMelWGXFRhHBNyYIvFZQVSuUbNhRBpQJeHFqPoRqs9uk3cWWpL0yYJoh4SKzhzqzC9R5KQiU3Yve1e7g0nKbzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qfw3+hX9ZWNORGcXFH0DuFQ+gQXSgFURlPn92mL21CM=;
 b=HPdGiuh5lEwn0HSudQjMc0r9CAeE1sClcysh6Tdlf2oX9nkkiqhja6pwceFJx4TseKk0P/+07wMZDRStgK8G+cBaladJD4g3wcf+IDqqliol7u5CQQiCJ4KakcxBSipddew6iB4RuupT0KxrsYa+lSu12qq67tZzxBp35CcaNGI61hgryd87G+i0WG4dEm8eui16JXhEmwyO8Hw6ARQ2VNc169UVtUJWrH18gmgnQ1OuchSZvoXIMDZueNKOU4uyKgrPOY1khP+2NfsI2UQbUMc5qeIhE/AMnLnVnJN9yS7ZQdxcP0cNGCOSKOK48XBeGfUBc9EehnWPBOjSVZ8j8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qfw3+hX9ZWNORGcXFH0DuFQ+gQXSgFURlPn92mL21CM=;
 b=U3/G7TPRPfEYYcSHpi2er8eQ9g6iYEQmOznK8b4dk+vuSZBnvm7LJCJJlDn1aiDMmhzx3u/cERovnrJXgkaku24m/kGf/y61khO34XFKXV1+HmfpnA9EfjBg409zGWphbJs4b+Ml63MGnPytmAWWcRiGsewc5ReDqfXGMLXDfIQ=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8491.eurprd04.prod.outlook.com (2603:10a6:102:1df::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.24; Sun, 17 Sep
 2023 23:07:23 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6792.026; Sun, 17 Sep 2023
 23:07:23 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v2 06/17] pmdomain: imx: Move Kconfig options to the
 pmdomain subsystem
Thread-Topic: [PATCH v2 06/17] pmdomain: imx: Move Kconfig options to the
 pmdomain subsystem
Thread-Index: AQHZ57X+Jz25/iukukmIB81H8dfIArAfp+Ig
Date:   Sun, 17 Sep 2023 23:07:23 +0000
Message-ID: <DU0PR04MB94179BEDE5FD9DA43582BD3B88F4A@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20230915092003.658361-1-ulf.hansson@linaro.org>
 <20230915092003.658361-7-ulf.hansson@linaro.org>
In-Reply-To: <20230915092003.658361-7-ulf.hansson@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|PAXPR04MB8491:EE_
x-ms-office365-filtering-correlation-id: 584b7349-cfd5-4490-18b5-08dbb7d2da21
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1epWtNNmH1hqR3X4jJImA6Bvz0XHV4jwv4royqYVYHU7tK/hx1T4tEVoIC9o1l79ksvz+ejtzzLJFPIofnM69YGApGOCK7oYnNZRRjwFxquCFloP+OQPWK2dCENyJg2jRuzNRbzv45iRIUKc9N54QMCepBpLZ5VonAZ3Ti7hdM3KBvWmssN8yjHKFMsdsh4Bn7v/N/LDsAZ/OEOGbcHiNhfv6Z4ra2m3x2W4V6cSmWnHRJYIbtSL69t3jw0nJKgHfBSMUHqY4Armnw4MWu6L288o33jaI6cjPxATpfm8T0itNSYKoofIQ7y4PrCcBRL8ZTiVWrozFkcbgd1o20myMiP6TYGFlriuF9r6WsZ/pXcy42YB8nHf1xNUNF9cJR5vbocdroj+e4TyL/LRXrpO8xJMz6BqSn5ob5nVCYDyc7Mw8zvNJVDvaHU2/c56HXsSnn/YfnQsGpFxIMxa29l4mVh/VIHpLIb6purpXyYLDzt9qX3jPYktMLPk4AGkhIIsohgpHWifk0Z8dEh9bweg4FlP1Lcu6qGTNhXKiO770OX61BGLFybzAGq5z+IdPttsP1gIrGLMtzzrnuXI1T9ukFu1XjFr3MrqK5WBuzfZZkeE7WJb0Vli2Zyj6aLL2MQI
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(39860400002)(376002)(346002)(1800799009)(186009)(451199024)(76116006)(66946007)(64756008)(66476007)(66446008)(316002)(8936002)(8676002)(122000001)(4326008)(41300700001)(52536014)(6506007)(7696005)(9686003)(478600001)(71200400001)(110136005)(83380400001)(26005)(38100700002)(7416002)(86362001)(33656002)(2906002)(44832011)(38070700005)(5660300002)(55016003)(66556008)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2LFuNzhVr3yCH7isMdlRyKpsXIIDPinjfshr70KOrio+AyCPwrjf0hQ9C9Pu?=
 =?us-ascii?Q?1Jt7uKYq84W9Htf/cgJXxj8p4NtjSbJO97GsKYSC2eMFCKQN4XHaCfwdJMzY?=
 =?us-ascii?Q?P0d1qX0KaLAR/KN47scOMF999YMqlNAxSdDMkNA2yE3bSIKaM1l9Q8YG/tck?=
 =?us-ascii?Q?rEn4qL6lMSt5++OZ8BNgs0HPAlUXlJtspQqX5Id+ZSvjFMTufXL7MKcoMEoF?=
 =?us-ascii?Q?iv/lpIy0UIgMXNEp4yiiMmkKN3fGydBrX2OtyHYlRCKTaUBq4wxVX50kWPm9?=
 =?us-ascii?Q?L7PfB08SSwGdt5o3A/Dvpmu4+Y5OKGFiz506OT7gpAS0MXaN+JNpFhwePuBw?=
 =?us-ascii?Q?Vvcx9Ryl1jAOdvid6UN4BMf//G1G2UEMMcTt2oJVKappxzwJyntmT5j3malF?=
 =?us-ascii?Q?ZmvD2NqazRejs+UX3ADQES7vgvbKiqgYpTU4CbrVyjeYAASg19oiqN8L10Pc?=
 =?us-ascii?Q?jdBgKuHwfsO4Yf13k1tDJfa0ZgJLvmad7qQYuaFHYFpCxqrYcKuGAw27OA1y?=
 =?us-ascii?Q?VmXSQdN8KCtfNYlujuFCVlD2jk/jniRLnX1xOEYsK5xamkTj+uAZLlgTCP1e?=
 =?us-ascii?Q?xdxnoWOCRl7hQl6riD9eSQTuBYPrHspDUcm4qm3vmCqTLo3QCptRn/i4DmH7?=
 =?us-ascii?Q?Vuvxx5LvSTyoUpai3XazS8z42FIBfrnHuulRmF+cJAaHtysLr07Pe6ckwwsy?=
 =?us-ascii?Q?2IfQvov7Cy43zL7MBsGRPSf8l0wM1g1oHy4EJdgVHrLS8tulXSx657RUzQ8J?=
 =?us-ascii?Q?k1x+XslW1XKJf/5EK6EW3vpWBRTzGJF4+R1RvStMaLIjNwkzEuhscwsWqnX7?=
 =?us-ascii?Q?+Sq7/hOQJof5y6smRpXVeZEo2g/0xj2XyucZvN5hvNEIax3305eB/jQVSeui?=
 =?us-ascii?Q?VdgCxTmEGemSBPbleSMnR3F2X+I9hp1x6W+yt41ZMBlhPZXQk/iYurpN3VCU?=
 =?us-ascii?Q?USpJJ6RBXjj3f5HVOgVzRkXLovNI9QwW8kRHNhoshjTFF0aR5cYMKgMYxfR8?=
 =?us-ascii?Q?JwH+3X4uFs4KoLFc7zrk30r5Qh2jcOTo0lCbYvrWXWKHyH89qwRilB/ZqTD0?=
 =?us-ascii?Q?hnWsiZecb2AZJzOK7w0+O89iTy2GVjlB/GoVIdEnAa1cozV5cHd8WFxYflJT?=
 =?us-ascii?Q?e79Z7ajgWkcoDg96wdr/MipQjOzqLKr1dAFRJ/XR6ziHry8YW1/9zz+gmOkJ?=
 =?us-ascii?Q?Si92sYHlAYe9IIhJk4s/QrORtSjzmuYAwaq2UIhN4+8Pk88XUyLqh7dT4u7I?=
 =?us-ascii?Q?2teOtpcQAvOkOkILtJSFH0t1DA6agfJSBTDW8QZ3FrWNNS3eMRIPjwKV1yAT?=
 =?us-ascii?Q?zIwPmFljYw9ti1uUeiHi9XBXnUJYrC2UvE9Jf2hGPWIAfA8tjMVb+SB0HPWL?=
 =?us-ascii?Q?wx1PMxq/qBLPHOeyAdHBud+wz+YckdUHZXVA8hAIxCJ+GT7gXIyFqYDdSpW/?=
 =?us-ascii?Q?Jypl4s//pVohVKaleT3jPautykNsNc90x4trLsD16mVP/OOguu/AayRonAvV?=
 =?us-ascii?Q?eAcCNcI7EVHzs1GMLCAjYoJNtpuATIA+RfNDfPe6ZZIxVCn7F0XP62dhxfKb?=
 =?us-ascii?Q?UP2JxnyuW0EdqIHDa4w=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 584b7349-cfd5-4490-18b5-08dbb7d2da21
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2023 23:07:23.3378
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kGoFxnw8xeMmul9OwgzV6HTb2b/ekl7ORECtmu0aHTSbI4TzfrYN1y7qk0wIdGGodoe5TbY7Mj7KmlrESGwyxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8491
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: [PATCH v2 06/17] pmdomain: imx: Move Kconfig options to the
> pmdomain subsystem
>=20
> The Kconfig options belongs closer to the corresponding implementations,
> hence let's move them from the soc- and firmware subsystem to the
> pmdomain subsystem.
>=20
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Peng Fan <peng.fan@nxp.com>
> Cc: <kernel@pengutronix.de>
> Cc: <linux-imx@nxp.com>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Acked-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/firmware/imx/Kconfig |  6 ------
>  drivers/pmdomain/Kconfig     |  1 +
>  drivers/pmdomain/imx/Kconfig | 29 +++++++++++++++++++++++++++++
>  drivers/soc/imx/Kconfig      | 19 -------------------
>  4 files changed, 30 insertions(+), 25 deletions(-)  create mode 100644
> drivers/pmdomain/imx/Kconfig
>=20
> diff --git a/drivers/firmware/imx/Kconfig b/drivers/firmware/imx/Kconfig
> index c027d99f2a59..183613f82a11 100644
> --- a/drivers/firmware/imx/Kconfig
> +++ b/drivers/firmware/imx/Kconfig
> @@ -22,9 +22,3 @@ config IMX_SCU
>=20
>  	  This driver manages the IPC interface between host CPU and the
>  	  SCU firmware running on M4.
> -
> -config IMX_SCU_PD
> -	bool "IMX SCU Power Domain driver"
> -	depends on IMX_SCU
> -	help
> -	  The System Controller Firmware (SCFW) based power domain driver.
> diff --git a/drivers/pmdomain/Kconfig b/drivers/pmdomain/Kconfig index
> ddc05d6af100..e2c85f20a0c3 100644
> --- a/drivers/pmdomain/Kconfig
> +++ b/drivers/pmdomain/Kconfig
> @@ -5,5 +5,6 @@ source "drivers/pmdomain/actions/Kconfig"
>  source "drivers/pmdomain/amlogic/Kconfig"
>  source "drivers/pmdomain/apple/Kconfig"
>  source "drivers/pmdomain/bcm/Kconfig"
> +source "drivers/pmdomain/imx/Kconfig"
>=20
>  endmenu
> diff --git a/drivers/pmdomain/imx/Kconfig b/drivers/pmdomain/imx/Kconfig
> new file mode 100644 index 000000000000..00203615c65e
> --- /dev/null
> +++ b/drivers/pmdomain/imx/Kconfig
> @@ -0,0 +1,29 @@
> +# SPDX-License-Identifier: GPL-2.0-only menu "i.MX PM Domains"
> +
> +config IMX_GPCV2_PM_DOMAINS
> +	bool "i.MX GPCv2 PM domains"
> +	depends on ARCH_MXC || (COMPILE_TEST && OF)
> +	depends on PM
> +	select PM_GENERIC_DOMAINS
> +	select REGMAP_MMIO
> +	default y if SOC_IMX7D
> +
> +config IMX8M_BLK_CTRL
> +	bool
> +	default SOC_IMX8M && IMX_GPCV2_PM_DOMAINS
> +	depends on PM_GENERIC_DOMAINS
> +	depends on COMMON_CLK
> +
> +config IMX9_BLK_CTRL
> +	bool
> +	default SOC_IMX9 && IMX_GPCV2_PM_DOMAINS
> +	depends on PM_GENERIC_DOMAINS
> +
> +config IMX_SCU_PD
> +	bool "IMX SCU Power Domain driver"
> +	depends on IMX_SCU
> +	help
> +	  The System Controller Firmware (SCFW) based power domain driver.
> +
> +endmenu
> diff --git a/drivers/soc/imx/Kconfig b/drivers/soc/imx/Kconfig index
> 76a4593baf0a..2a90ddd20104 100644
> --- a/drivers/soc/imx/Kconfig
> +++ b/drivers/soc/imx/Kconfig
> @@ -1,14 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0-only  menu "i.MX SoC drivers"
>=20
> -config IMX_GPCV2_PM_DOMAINS
> -	bool "i.MX GPCv2 PM domains"
> -	depends on ARCH_MXC || (COMPILE_TEST && OF)
> -	depends on PM
> -	select PM_GENERIC_DOMAINS
> -	select REGMAP_MMIO
> -	default y if SOC_IMX7D
> -
>  config SOC_IMX8M
>  	tristate "i.MX8M SoC family support"
>  	depends on ARCH_MXC || COMPILE_TEST
> @@ -28,15 +20,4 @@ config SOC_IMX9
>  	help
>  	  If you say yes here, you get support for the NXP i.MX9 family
>=20
> -config IMX8M_BLK_CTRL
> -	bool
> -	default SOC_IMX8M && IMX_GPCV2_PM_DOMAINS
> -	depends on PM_GENERIC_DOMAINS
> -	depends on COMMON_CLK
> -
> -config IMX9_BLK_CTRL
> -	bool
> -	default SOC_IMX9 && IMX_GPCV2_PM_DOMAINS
> -	depends on PM_GENERIC_DOMAINS
> -
>  endmenu
> --
> 2.34.1

