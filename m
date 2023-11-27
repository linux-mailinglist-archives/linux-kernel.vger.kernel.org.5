Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 579797FA45B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 16:25:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233878AbjK0PZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 10:25:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233867AbjK0PZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 10:25:27 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2062.outbound.protection.outlook.com [40.107.20.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06CBFCC;
        Mon, 27 Nov 2023 07:25:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cqDSNpuDi0sVkpe4KeRtKFIzjQr0sSYcGPvc+YgSIkbEU0yG6AhGRJu7c8BSv6+p85tkWsJOhCG88O5fisSQuyYDrtQCi8PMpKy7icYo2ECfhsOXzdQ7UJy0Htn3H4DygrWPjxRyEi6NOAYPjhgeLbb38RmXLnRB18+cBGJZTqMm0oHu/gbgTPXLGxvVJXMPFMWLDk8/QJMQbd0TFlNiT3Evgc/rQV1ts84Y7hLPrZycUyY3+NiT4RVLOlWkHp05K9yxj+arz8WzDIWveZ4T3P3LZyZvEmruUixHRvkw3AupFDZReqZiyZHeF7OdxiL5NXMKU7m9OE0dr5oHi0AWxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=99m41PpWn2OGmcOd02OsdcAU9aISx9bi404b8qfzRtc=;
 b=Krn8FSGedRlNQ+wgNJw6xmvLS3VeRYa+7AX40N5TIVL67p+8ulrJwz/lmMJ0xVeoG/3RyOdHCCaiGme1s8qa5aJJ0htyWH2VWtkuRjQpx3mfuFUYD8pnGXVcGRe3NbfEKIplTioZ3ZoyjKuLrXxqyYMBczKcVWxN4oU14a2TK54sMCjF+LEPBXF9BZQQh3QHJkd+6bW9FCEIXW0aQD9dOnkjSWO9vAEyTNPlk7zFVZb+fbMTd7dtkf/oJGI29GvxTbK9Nuj9QzBEbWAjyF/lYOvjo/KA3Y6iJEy4IKLpXvdd6cAl9Nc/0wUJExwNGTqEXKdJi0UQXLYX+ZEgimSCgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=99m41PpWn2OGmcOd02OsdcAU9aISx9bi404b8qfzRtc=;
 b=nL8qHm4jz4HWsUH/YWhss8WIvjZlQXoRQOfAenUX+285KCPhBE3PkPDvsSJ1FSnfVfsqPdajNvN9YXSuIkl0QGnxLcAFlrXAuPS5eQIw5mphRszoLhkDIo/F8/f+BozBpj3m0rfUIWdtOih4rt0FFcBhx1bsnOpl+45bC0lAPlc=
Received: from VI1PR04MB4845.eurprd04.prod.outlook.com (2603:10a6:803:51::30)
 by DBBPR04MB7914.eurprd04.prod.outlook.com (2603:10a6:10:1f0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.19; Mon, 27 Nov
 2023 15:25:28 +0000
Received: from VI1PR04MB4845.eurprd04.prod.outlook.com
 ([fe80::6410:9a52:b833:5bc1]) by VI1PR04MB4845.eurprd04.prod.outlook.com
 ([fe80::6410:9a52:b833:5bc1%4]) with mapi id 15.20.7046.015; Mon, 27 Nov 2023
 15:25:28 +0000
From:   Frank Li <frank.li@nxp.com>
To:     Xu Yang <xu.yang_2@nxp.com>, "will@kernel.org" <will@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "irogers@google.com" <irogers@google.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "acme@kernel.org" <acme@kernel.org>,
        "john.g.garry@oracle.com" <john.g.garry@oracle.com>
CC:     "james.clark@arm.com" <james.clark@arm.com>,
        "mike.leach@linaro.org" <mike.leach@linaro.org>,
        "leo.yan@linaro.org" <leo.yan@linaro.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/3] perf: imx_perf: add support for i.MX95 platform
Thread-Topic: [PATCH 2/3] perf: imx_perf: add support for i.MX95 platform
Thread-Index: AQHaIQMR0o+ldvy6b0GCG+Knb+PktrCORwLg
Date:   Mon, 27 Nov 2023 15:25:28 +0000
Message-ID: <VI1PR04MB4845D4B4CB68648CB3C1081688BDA@VI1PR04MB4845.eurprd04.prod.outlook.com>
References: <20231127073208.1055466-1-xu.yang_2@nxp.com>
 <20231127073208.1055466-2-xu.yang_2@nxp.com>
In-Reply-To: <20231127073208.1055466-2-xu.yang_2@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR04MB4845:EE_|DBBPR04MB7914:EE_
x-ms-office365-filtering-correlation-id: 84cbf4cf-b6ad-4c65-ef1b-08dbef5d15ef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XxU1Jw+/IQyGAtT+NyJE2bZ2OOdwbetmGM8n+bYXpQ8vgS9uqGLP1vIHVVTOu2GDRYtluyYxBDS+GR5NNbwF0xRIRWJQD2WHiok3uSnxCl7PsW5DC4xTHzLWtc6N1/qCi/8hqFRqbNVdP1BxbgY57CH5iXPuMumG5phjH+eZtbJJNgBkvlHguDF8lu/+zWhTDu2xSdhhjVOyc/3avz1MutPBTZRHL65xCDEAqyBAL7oeG5wQWkDylxKPi4sypMJt1h+Y8gdoHAvE7FL94Vol9rzmR9uTtyz2QKD22gkaAQhrF421oq5oHQawZubEXzgrm9OBaN2PzC2+CpvyREypDeX5a2DEuQk1wFbLm7okVdhFFLTFAbdeeaAOn6lSBGj3N+37GA12XdR5/37P8BJkxd8ag56Y8USlC4iDsFWhJPQHs0Oqv/a0SF5eIlKgEWkBdsd6MaHO3dKVGYPA/ELyMtF5Mos1AgRAKgXp4jGI5RnTbz9Akl8S3xoHMHjxl3elTy2M0aAuPgro1AdMTSw1YRmkRaXqfjcuWyN4ZC3pqI1f0dvz9z43M4LLl0XgShFFh5O3WmDqdfr1zieqrs2Ef4Pfmp6t6P67aRPz9QpP+gbj6kq9/Ay+on85nSoZVg2WOhqwcilQySkkG8849P07cA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4845.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(396003)(366004)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(26005)(71200400001)(6506007)(9686003)(55236004)(53546011)(8676002)(55016003)(8936002)(4326008)(44832011)(86362001)(5660300002)(7696005)(52536014)(478600001)(54906003)(64756008)(316002)(66446008)(110136005)(66476007)(66556008)(66946007)(76116006)(38100700002)(83380400001)(122000001)(38070700009)(921008)(33656002)(7416002)(30864003)(2906002)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fE6uVxIWEe3n2dlVCTdi7oaTo0RElVMK7h11ojsAU6J4W3BlEiW9rypNHOUS?=
 =?us-ascii?Q?jRLOtq64kEE78eDOPpWa8xbpA3U4Epy1N+tN9CBwHEi+tZaLrQzUDneffDm/?=
 =?us-ascii?Q?oETe8HewOcxGutmlryUumpeurLiBVbKm4o0bPvZiGmLS8PtNXHgyi9QaqX8S?=
 =?us-ascii?Q?zPxuv7re3Xeo2FMVu+2m20++lRxhmo3Et+wDYKI/6hddHTP2z3L01sI0vwRB?=
 =?us-ascii?Q?Z35sET4Eyh82TXZSyKhPjblk9IISJGi2s6yytk2LuPizjc7Wp95qb7SzxgDI?=
 =?us-ascii?Q?VeU/ucZ9b7mdFegaIePNKS3EXKf53+9V3xZFabAF//woDE8U+LbLp6BLVKam?=
 =?us-ascii?Q?0NArYoUYwoahORH9dDnal3Uj8Kk9vmFNZwoXIyqRjDi+HGAeWw5hIf5sinjZ?=
 =?us-ascii?Q?2gwAUYa4TNmaI/bDTdHPxBz5zwuDX4ArRahntVZ+6y4LrKPflPLCwMY+eEjw?=
 =?us-ascii?Q?HsshQEp5x0QpC8vOUhrN4hflzP7gNQX68Lt/pgaIQfaShpeyxOFSzX+uE10I?=
 =?us-ascii?Q?MiHLORE6iU6C/AOEvQyTMKg//sO3sTt8HiG16wRA6vOOsYFV2p6L1F+jDTgw?=
 =?us-ascii?Q?QXv417i03J/jwdSk9TTiG3XeXh32MUUJRwb8STuxFc08kAVArRt8W1yLerOR?=
 =?us-ascii?Q?tkYFa59SMtpaEWc+xH2gPD4BEhmh80j0M5NDMcC3ajvltyeLioTDoPss3Vs3?=
 =?us-ascii?Q?QTGGuV+bSU6gf4/SEqdC0A1fmCoGZa8QJt8q4hftSW97LzLMIY3sW1VKRNrC?=
 =?us-ascii?Q?gTtKVV2i8N3nvjF4Rd6pQmZtr6zKvufxgpPQEmn4Kzhx4UzuF4bDq9q9M0Ux?=
 =?us-ascii?Q?npI7nDy6vDDbACeQ6pEPmY1F4SgHyReXarp0sml2yYiyYxIX8tyLalWh9Mf4?=
 =?us-ascii?Q?pBRy7SnW+/8eS+fXkawLCvsHdtgvnmKtlhfs/bYC8LLh6zcHzd/rnESRXOdk?=
 =?us-ascii?Q?kXSLN8t758nFRc6MaYh9jWfZdZ0wIO5poHP46IlpU0V2GcXch4ffPj30nL7C?=
 =?us-ascii?Q?MI7Z+mEieA3KQV4rKPPqNuypmZPUiJ6c6JaBiHdHSUjPoR8G6s+6y/X4WTas?=
 =?us-ascii?Q?7vVryb3LWSYrtoed45ySCb704qVyjsdhzFE9fag3jOrGY1URLWGHgsbbG4PV?=
 =?us-ascii?Q?t25ATvY6FG04tM/kDHAoTGNxRhRLPLL2u1nlQX/ouxu1lYc/cPStEz5mpPUZ?=
 =?us-ascii?Q?ISAIxLuDL0Jj1+3042nTm6YqI2WgqzyFFaxTAXCOGkaCnIEx3PpK/TmmOdwx?=
 =?us-ascii?Q?aE7FznkSi6oYpuEbK3/ZaEg3K6OmFa+9qOFPOWTRMospQrMMw1MCOOtlisd/?=
 =?us-ascii?Q?2mTBWj0dd3HTcf3gY19964kw5G3+zdZ7T8dXXDoriHwAASiN5pPsxZ7XjPjF?=
 =?us-ascii?Q?PpOVqloMT2PCQQ9oCuwqGWu/mPpYwIpuYSKkY+/G87o/N/YgVjW54BQGoH+z?=
 =?us-ascii?Q?KlvrIXioZL4cUfMIDDfC0uAoqej2/uKQws/WyuCZfp/Pdk+xTzDMrVOt1gFh?=
 =?us-ascii?Q?9inIddGVBSRLRTWj3lX0SQ2Lu0yp4HoUPTNUN1tBEskUWncE0oYsp047SVWg?=
 =?us-ascii?Q?41X05yH0bKRdH6d7zxE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4845.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84cbf4cf-b6ad-4c65-ef1b-08dbef5d15ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2023 15:25:28.2012
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3yQODYVn5MfZ20hKL4bCH7MTxApADBU4DcCyzZvBhT3hLJ/4rU5O6v3BgwjhsWRqQ0rkTXIaSLeYsmg3H2z9uQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7914
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Xu Yang <xu.yang_2@nxp.com>
> Sent: Monday, November 27, 2023 1:32 AM
> To: Frank Li <frank.li@nxp.com>; will@kernel.org; mark.rutland@arm.com;
> robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org;
> conor+dt@kernel.org; shawnguo@kernel.org; s.hauer@pengutronix.de;
> kernel@pengutronix.de; festevam@gmail.com; irogers@google.com;
> namhyung@kernel.org; acme@kernel.org; john.g.garry@oracle.com
> Cc: james.clark@arm.com; mike.leach@linaro.org; leo.yan@linaro.org;
> peterz@infradead.org; mingo@redhat.com;
> alexander.shishkin@linux.intel.com; linux-arm-kernel@lists.infradead.org;
> devicetree@vger.kernel.org; linux-perf-users@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: [PATCH 2/3] perf: imx_perf: add support for i.MX95 platform
>=20
> i.MX95 has a DDR PMU which is almostly same as i.MX93, it now supports
> read beat and write beat filter capabilities. This will add support for
> i.MX95 and enhance the driver to support specific filter handling for it.
>=20
> Usage:
>=20
> For read beat:
> ~# perf stat -a -I 1000 -e
> imx9_ddr0/eddrtq_pm_rd_beat_filt2,counter=3D3,axi_mask=3DID_MASK,axi_id
> =3DID/
> ~# perf stat -a -I 1000 -e
> imx9_ddr0/eddrtq_pm_rd_beat_filt1,counter=3D4,axi_mask=3DID_MASK,axi_id
> =3DID/
> ~# perf stat -a -I 1000 -e
> imx9_ddr0/eddrtq_pm_rd_beat_filt0,counter=3D5,axi_mask=3DID_MASK,axi_id
> =3DID/
> eg: For edma2: perf stat -a -I 1000 -e
> imx9_ddr0/eddrtq_pm_rd_beat_filt0,counter=3D5,axi_mask=3D0x00f,axi_id=3D0=
x0
> 0c/
>=20
> For write beat:
> ~# perf stat -a -I 1000 -e
> imx9_ddr0/eddrtq_pm_wr_beat_filt,counter=3D2,axi_mask=3DID_MASK,axi_id=3D
> ID/
> eg: For edma2: perf stat -a -I 1000 -e
> imx9_ddr0/eddrtq_pm_wr_beat_filt,counter=3D2,axi_mask=3D0x00f,axi_id=3D0x=
00
> c/
>=20
> Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
> ---
>  drivers/perf/fsl_imx9_ddr_perf.c | 187 +++++++++++++++++++++++++++--
> --
>  1 file changed, 164 insertions(+), 23 deletions(-)
>=20
> diff --git a/drivers/perf/fsl_imx9_ddr_perf.c
> b/drivers/perf/fsl_imx9_ddr_perf.c
> index 5cf770a1bc31..5e531d94cf3b 100644
> --- a/drivers/perf/fsl_imx9_ddr_perf.c
> +++ b/drivers/perf/fsl_imx9_ddr_perf.c
> @@ -11,14 +11,24 @@
>  #include <linux/perf_event.h>
>=20
>  /* Performance monitor configuration */
> -#define PMCFG1  			0x00
> -#define PMCFG1_RD_TRANS_FILT_EN 	BIT(31)
> -#define PMCFG1_WR_TRANS_FILT_EN 	BIT(30)
> -#define PMCFG1_RD_BT_FILT_EN 		BIT(29)
> -#define PMCFG1_ID_MASK  		GENMASK(17, 0)
> +#define PMCFG1				0x00
> +#define MX93_PMCFG1_RD_TRANS_FILT_EN	BIT(31)
> +#define MX93_PMCFG1_WR_TRANS_FILT_EN	BIT(30)
> +#define MX93_PMCFG1_RD_BT_FILT_EN	BIT(29)
> +#define MX93_PMCFG1_ID_MASK		GENMASK(17, 0)
>=20
> -#define PMCFG2  			0x04
> -#define PMCFG2_ID			GENMASK(17, 0)
> +#define MX95_PMCFG1_WR_BEAT_FILT_EN	BIT(31)
> +#define MX95_PMCFG1_RD_BEAT_FILT_EN	BIT(30)
> +
> +#define PMCFG2				0x04
> +#define MX93_PMCFG2_ID			GENMASK(17, 0)
> +
> +#define PMCFG3				0x08
> +#define PMCFG4				0x0C
> +#define PMCFG5				0x10
> +#define PMCFG6				0x14
> +#define MX95_PMCFG_ID_MASK		GENMASK(9, 0)
> +#define MX95_PMCFG_ID			GENMASK(25, 16)
>=20
>  /* Global control register affects all counters and takes priority over =
local
> control registers */
>  #define PMGC0		0x40
> @@ -71,12 +81,22 @@ static const struct imx_ddr_devtype_data
> imx93_devtype_data =3D {
>  	.identifier =3D "imx93",
>  };
>=20
> +static const struct imx_ddr_devtype_data imx95_devtype_data =3D {
> +	.identifier =3D "imx95",
> +};
> +
>  static const struct of_device_id imx_ddr_pmu_dt_ids[] =3D {
>  	{.compatible =3D "fsl,imx93-ddr-pmu", .data =3D &imx93_devtype_data},
> +	{.compatible =3D "fsl,imx95-ddr-pmu", .data =3D &imx95_devtype_data},
>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, imx_ddr_pmu_dt_ids);
>=20
> +static inline bool is_imx93(struct ddr_pmu *pmu)
> +{
> +	return pmu->devtype_data =3D=3D &imx93_devtype_data;
> +}
> +
>  static ssize_t ddr_perf_identifier_show(struct device *dev,
>  					struct device_attribute *attr,
>  					char *page)
> @@ -178,7 +198,6 @@ static struct attribute *ddr_perf_events_attrs[] =3D =
{
>  	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_6, 70),
>  	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_7, 71),
>  	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_empty, 72),
> -	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_trans_filt, 73),
>=20
>  	/* counter3 specific events */
>  	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_0, 64),
> @@ -190,7 +209,6 @@ static struct attribute *ddr_perf_events_attrs[] =3D =
{
>  	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_6, 70),
>  	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_7, 71),
>  	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_full, 72),
> -	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_wr_trans_filt, 73),
>=20
>  	/* counter4 specific events */
>  	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_0, 64),
> @@ -202,7 +220,6 @@ static struct attribute *ddr_perf_events_attrs[] =3D =
{
>  	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_6, 70),
>  	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_7, 71),
>  	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_ld_rdq2_rmw, 72),
> -	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_beat_filt, 73),
>=20
>  	/* counter5 specific events */
>  	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_0, 64),
> @@ -242,6 +259,26 @@ static const struct attribute_group
> ddr_perf_events_attr_group =3D {
>  	.attrs =3D ddr_perf_events_attrs,
>  };
>=20
> +static struct attribute *imx93_ddr_perf_events_attrs[] =3D {
> +	/* counter2 specific events */
> +	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_trans_filt, 73),
> +	/* counter3 specific events */
> +	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_wr_trans_filt, 73),
> +	/* counter4 specific events */
> +	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_beat_filt, 73),
> +};
> +
> +static struct attribute *imx95_ddr_perf_events_attrs[] =3D {
> +	/* counter2 specific events */
> +	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_wr_beat_filt, 73),
> +	/* counter3 specific events */
> +	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_beat_filt2, 73),
> +	/* counter4 specific events */
> +	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_beat_filt1, 73),
> +	/* counter5 specific events */
> +	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_beat_filt0, 73),
> +};
> +
>  PMU_FORMAT_ATTR(event, "config:0-7");
>  PMU_FORMAT_ATTR(counter, "config:8-15");
>  PMU_FORMAT_ATTR(axi_id, "config1:0-17");
> @@ -361,7 +398,7 @@ static void ddr_perf_counter_local_config(struct
> ddr_pmu *pmu, int config,
>  	}
>  }
>=20
> -static void ddr_perf_monitor_config(struct ddr_pmu *pmu, int cfg, int cf=
g1,
> int cfg2)
> +static void imx93_ddr_perf_monitor_config(struct ddr_pmu *pmu, int cfg,
> int cfg1, int cfg2)
>  {
>  	u32 pmcfg1, pmcfg2;
>  	int event, counter;
> @@ -372,30 +409,80 @@ static void ddr_perf_monitor_config(struct
> ddr_pmu *pmu, int cfg, int cfg1, int
>  	pmcfg1 =3D readl_relaxed(pmu->base + PMCFG1);
>=20
>  	if (counter =3D=3D 2 && event =3D=3D 73)
> -		pmcfg1 |=3D PMCFG1_RD_TRANS_FILT_EN;
> +		pmcfg1 |=3D MX93_PMCFG1_RD_TRANS_FILT_EN;
>  	else if (counter =3D=3D 2 && event !=3D 73)
> -		pmcfg1 &=3D ~PMCFG1_RD_TRANS_FILT_EN;
> +		pmcfg1 &=3D ~MX93_PMCFG1_RD_TRANS_FILT_EN;
>=20
>  	if (counter =3D=3D 3 && event =3D=3D 73)
> -		pmcfg1 |=3D PMCFG1_WR_TRANS_FILT_EN;
> +		pmcfg1 |=3D MX93_PMCFG1_WR_TRANS_FILT_EN;
>  	else if (counter =3D=3D 3 && event !=3D 73)
> -		pmcfg1 &=3D ~PMCFG1_WR_TRANS_FILT_EN;
> +		pmcfg1 &=3D ~MX93_PMCFG1_WR_TRANS_FILT_EN;
>=20
>  	if (counter =3D=3D 4 && event =3D=3D 73)
> -		pmcfg1 |=3D PMCFG1_RD_BT_FILT_EN;
> +		pmcfg1 |=3D MX93_PMCFG1_RD_BT_FILT_EN;
>  	else if (counter =3D=3D 4 && event !=3D 73)
> -		pmcfg1 &=3D ~PMCFG1_RD_BT_FILT_EN;
> +		pmcfg1 &=3D ~MX93_PMCFG1_RD_BT_FILT_EN;
>=20
> -	pmcfg1 &=3D ~FIELD_PREP(PMCFG1_ID_MASK, 0x3FFFF);
> -	pmcfg1 |=3D FIELD_PREP(PMCFG1_ID_MASK, cfg2);
> +	pmcfg1 &=3D ~FIELD_PREP(MX93_PMCFG1_ID_MASK, 0x3FFFF);
> +	pmcfg1 |=3D FIELD_PREP(MX93_PMCFG1_ID_MASK, cfg2);
>  	writel(pmcfg1, pmu->base + PMCFG1);
>=20
>  	pmcfg2 =3D readl_relaxed(pmu->base + PMCFG2);
> -	pmcfg2 &=3D ~FIELD_PREP(PMCFG2_ID, 0x3FFFF);
> -	pmcfg2 |=3D FIELD_PREP(PMCFG2_ID, cfg1);
> +	pmcfg2 &=3D ~FIELD_PREP(MX93_PMCFG2_ID, 0x3FFFF);
> +	pmcfg2 |=3D FIELD_PREP(MX93_PMCFG2_ID, cfg1);

Suggest created a sperate rename patch, which prepare for IMX95.

Frank

>  	writel(pmcfg2, pmu->base + PMCFG2);
>  }
>=20
> +static void imx95_ddr_perf_monitor_config(struct ddr_pmu *pmu, int cfg,
> int cfg1, int cfg2)
> +{
> +	u32 pmcfg1, pmcfg, offset =3D 0;
> +	int event, counter;
> +
> +	event =3D cfg & 0x000000FF;
> +	counter =3D (cfg & 0x0000FF00) >> 8;
> +
> +	pmcfg1 =3D readl_relaxed(pmu->base + PMCFG1);
> +
> +	if (counter =3D=3D 2 && event =3D=3D 73) {
> +		pmcfg1 |=3D MX95_PMCFG1_WR_BEAT_FILT_EN;
> +		offset =3D PMCFG3;
> +	} else if (counter =3D=3D 2 && event !=3D 73) {
> +		pmcfg1 &=3D ~MX95_PMCFG1_WR_BEAT_FILT_EN;
> +	}
> +
> +	if (counter =3D=3D 3 && event =3D=3D 73) {
> +		pmcfg1 |=3D MX95_PMCFG1_RD_BEAT_FILT_EN;
> +		offset =3D PMCFG4;
> +	} else if (counter =3D=3D 3 && event !=3D 73) {
> +		pmcfg1 &=3D ~MX95_PMCFG1_RD_BEAT_FILT_EN;
> +	}
> +
> +	if (counter =3D=3D 4 && event =3D=3D 73) {
> +		pmcfg1 |=3D MX95_PMCFG1_RD_BEAT_FILT_EN;
> +		offset =3D PMCFG5;
> +	} else if (counter =3D=3D 4 && event !=3D 73) {
> +		pmcfg1 &=3D ~MX95_PMCFG1_RD_BEAT_FILT_EN;
> +	}
> +
> +	if (counter =3D=3D 5 && event =3D=3D 73) {
> +		pmcfg1 |=3D MX95_PMCFG1_RD_BEAT_FILT_EN;
> +		offset =3D PMCFG6;
> +	} else if (counter =3D=3D 5 && event !=3D 73) {
> +		pmcfg1 &=3D ~MX95_PMCFG1_RD_BEAT_FILT_EN;
> +	}
> +
> +	writel(pmcfg1, pmu->base + PMCFG1);
> +
> +	if (offset) {
> +		pmcfg =3D readl_relaxed(pmu->base + offset);
> +		pmcfg &=3D ~FIELD_PREP(MX95_PMCFG_ID_MASK, 0x3FF);
> +		pmcfg |=3D FIELD_PREP(MX95_PMCFG_ID_MASK, cfg2);
> +		pmcfg &=3D ~FIELD_PREP(MX95_PMCFG_ID, 0x3FF);

It should be reductant.=20

> +		pmcfg |=3D FIELD_PREP(MX95_PMCFG_ID, cfg1);
> +		writel(pmcfg, pmu->base + offset);
> +	}
> +}
> +
>  static void ddr_perf_event_update(struct perf_event *event)
>  {
>  	struct ddr_pmu *pmu =3D to_ddr_pmu(event->pmu);
> @@ -479,8 +566,13 @@ static int ddr_perf_event_add(struct perf_event
> *event, int flags)
>  	if (flags & PERF_EF_START)
>  		ddr_perf_event_start(event, flags);
>=20
> -	/* read trans, write trans, read beat */
> -	ddr_perf_monitor_config(pmu, cfg, cfg1, cfg2);
> +	if (is_imx93(pmu)) {
> +		/* read trans, write trans, read beat */
> +		imx93_ddr_perf_monitor_config(pmu, cfg, cfg1, cfg2);
> +	} else {
> +		/* write beat, read beat2, read beat1, read beat */
> +		imx95_ddr_perf_monitor_config(pmu, cfg, cfg1, cfg2);
> +	}

Did you run checkpatch?  no "{" need?, not sure have comments case.
>=20
>  	return 0;
>  }
> @@ -596,6 +688,49 @@ static int ddr_perf_offline_cpu(unsigned int cpu,
> struct hlist_node *node)
>  	return 0;
>  }
>=20
> +static int ddr_perf_add_events(struct ddr_pmu *pmu)
> +{
> +	int i, ret, events;
> +	struct attribute **attrs;
> +	struct device *pmu_dev =3D pmu->pmu.dev;
> +
> +	if (is_imx93(pmu)) {
> +		events =3D sizeof(imx93_ddr_perf_events_attrs)/sizeof(struct
> attribute *);
> +		attrs =3D imx93_ddr_perf_events_attrs;
> +	} else {
> +		events =3D sizeof(imx95_ddr_perf_events_attrs)/sizeof(struct
> attribute *);
> +		attrs =3D imx95_ddr_perf_events_attrs;
> +	}

Can you put "attrs" and "events" into drvdata?

> +
> +	for (i =3D 0; i < events; i++) {
> +		ret =3D sysfs_add_file_to_group(&pmu_dev->kobj, attrs[i],
> "events");
> +		if (ret) {
> +			dev_warn(pmu->dev, "i.MX9 DDR Perf add events
> failed (%d)\n", ret);
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static void ddr_perf_remove_events(struct ddr_pmu *pmu)
> +{
> +	int i, events;
> +	struct attribute **attrs;
> +	struct device *pmu_dev =3D pmu->pmu.dev;
> +
> +	if (is_imx93(pmu)) {
> +		events =3D sizeof(imx93_ddr_perf_events_attrs)/sizeof(struct
> attribute *);
> +		attrs =3D imx93_ddr_perf_events_attrs;
> +	} else {
> +		events =3D sizeof(imx95_ddr_perf_events_attrs)/sizeof(struct
> attribute *);
> +		attrs =3D imx95_ddr_perf_events_attrs;
> +	}

Can you put "attrs" and "events" into drvdata?

> +
> +	for (i =3D 0; i < events; i++)
> +		sysfs_remove_file_from_group(&pmu_dev->kobj, attrs[i],
> "events");
> +}
> +
>  static int ddr_perf_probe(struct platform_device *pdev)
>  {
>  	struct ddr_pmu *pmu;
> @@ -666,6 +801,10 @@ static int ddr_perf_probe(struct platform_device
> *pdev)
>  	if (ret)
>  		goto ddr_perf_err;
>=20
> +	ret =3D ddr_perf_add_events(pmu);
> +	if (ret)
> +		dev_warn(&pdev->dev, "i.MX9 DDR Perf filter events are
> missing\n");
> +
>  	return 0;
>=20
>  ddr_perf_err:
> @@ -683,6 +822,8 @@ static int ddr_perf_remove(struct platform_device
> *pdev)
>  {
>  	struct ddr_pmu *pmu =3D platform_get_drvdata(pdev);
>=20
> +	ddr_perf_remove_events(pmu);
> +
>  	cpuhp_state_remove_instance_nocalls(pmu->cpuhp_state, &pmu-
> >node);
>  	cpuhp_remove_multi_state(pmu->cpuhp_state);
>=20
> --
> 2.34.1

