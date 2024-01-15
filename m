Return-Path: <linux-kernel+bounces-25648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BBD482D411
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 07:04:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A009FB20DB3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 06:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C923C0B;
	Mon, 15 Jan 2024 06:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="lMSXBYUf"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2044.outbound.protection.outlook.com [40.107.6.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0065232;
	Mon, 15 Jan 2024 06:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lGMHP4FAgFF4oFVyfkfhh9Eqa0XqVPOCP0kxW/XNV0U50jxZS1v/C87dRy2Ctur4mxvkCfTPmJ082flPxXmhAMNd+ae88W2cLe+hVLbOVUl8EOXQ6fze0LUZoGVhD4kKPyC89wfkUy08ylrakdTi/RfltwX3E7xA0kkZjScpDHjQT+Uxm5p9Fkn1MkF77c7i6ynye1D1eS79pcUT4pJ6CsyRdmSJw2v4wS6XPjbDYNpyNBlt91vBGn3f6XyWbo5OkSmvuu4AiLni81I7mHGu1MXasxVcKyygTMQtl1K5ogAbJHAUlEBDlP2YPONJaZB1BtTWYSzXTKgdUrbATl+XlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dZsaR9H4NFm7wIYZfpBfsqypA4qDzCXf43Hn2Kqr8Sc=;
 b=FnKo2ZRAjy++KFsDZei/5c50GMxAY3vyXF4CMXbOyIPxjKDTFTGoue9D+9HCKKCEeJHi9lX0DHckTtoWWysk+KwTY8tgXlqYQlOf7fwQkTadIwPuod37fdx+N1wP5Wl+Ij/eSENRX8v26HsoaBwRoeZ1AwqL/YzklavLyaf0L7fr4VRrnSuiG0O90df5fxRm68NRQyJlZbCfqV569UyfRL5h9WHRBu2OYLZCM8duH9ZwdqPaXs3RsvcUt2XdRwyjhyFXSgzIm7g38vfH75jGCK5Q1PLCVgZzUVG6pMQ2ptbI0u688BhIvHpirDZCmZ/RDKapy5CXrXncyk1CBMKHDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dZsaR9H4NFm7wIYZfpBfsqypA4qDzCXf43Hn2Kqr8Sc=;
 b=lMSXBYUf3G0wNwdTfs9MuRHIYi/pMSACz9ySdL2a+/kW+RbFRGifjNzN9Sj659ivEoQAphj/f7Flb9znWBqyORmTeYOb6SrD8o3fybZV63wI4ScHUxYGic4vbkxA6xxgTEQjeluWnLXwshBRxycbbS5fapABwScew5NuWEQcdX0=
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by AM9PR04MB8811.eurprd04.prod.outlook.com (2603:10a6:20b:40a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23; Mon, 15 Jan
 2024 06:03:58 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::efd8:23d4:18bf:630a]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::efd8:23d4:18bf:630a%4]) with mapi id 15.20.7181.026; Mon, 15 Jan 2024
 06:03:58 +0000
From: Xu Yang <xu.yang_2@nxp.com>
To: Frank Li <frank.li@nxp.com>, "will@kernel.org" <will@kernel.org>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>, "robh+dt@kernel.org"
	<robh+dt@kernel.org>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>,
	"john.g.garry@oracle.com" <john.g.garry@oracle.com>, "jolsa@kernel.org"
	<jolsa@kernel.org>, "namhyung@kernel.org" <namhyung@kernel.org>,
	"irogers@google.com" <irogers@google.com>
CC: dl-linux-imx <linux-imx@nxp.com>, "mike.leach@linaro.org"
	<mike.leach@linaro.org>, "leo.yan@linaro.org" <leo.yan@linaro.org>,
	"peterz@infradead.org" <peterz@infradead.org>, "mingo@redhat.com"
	<mingo@redhat.com>, "acme@kernel.org" <acme@kernel.org>,
	"alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"adrian.hunter@intel.com" <adrian.hunter@intel.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>
Subject: RE: [PATCH v2 2/4] perf: imx_perf: add support for i.MX95 platform
Thread-Topic: [PATCH v2 2/4] perf: imx_perf: add support for i.MX95 platform
Thread-Index: AQHaKbNPhaMMN4As3UmoLnemJFrF/rDancMA
Date: Mon, 15 Jan 2024 06:03:58 +0000
Message-ID:
 <DU2PR04MB88225F83DEBD3F15D18CE56B8C6C2@DU2PR04MB8822.eurprd04.prod.outlook.com>
References: <20231208085402.2106904-1-xu.yang_2@nxp.com>
 <20231208085402.2106904-2-xu.yang_2@nxp.com>
In-Reply-To: <20231208085402.2106904-2-xu.yang_2@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8822:EE_|AM9PR04MB8811:EE_
x-ms-office365-filtering-correlation-id: c708e457-0c7f-4f7d-902e-08dc158fc377
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 74bYMp1Wv4kq6Mc+DNfDtCz+9A2xSQGEa0pYRnoBU+/SSbckmQyo6kMz2cCK47za/YpN/5vTVtU2rSte3zVzDnjneszCjhZGsz2MAcBWogjw4ODde1AT3UnLeOz6SL1aOAEGRKZqdKjYu/nt3XYNSaWf+ekH0XFYP1xgZ9GufAtxXwFAgJT5qo4vgGdpyid+i0K0TnsXxuk2xEFb+9lrA7jcaC4NQkY/Dfi211blcumv8+0nwqrYRpnioTPWPdYX/+kCQuopCi3s/dGlIkBhpVkPaNjlPzJYvFAJCW1VyCmclMVUHGTeVdMd+ELBjGRugzkiidWeKX+96KOOuxn3goLNdDGn79tnErg1Gea0c4UwA3uC9XSsapL3+TgQoidHW5r1UVNm69QO6v5mih3l67TDnfehMJC2geMB1/7wAgQIcrrtmAI1iERwolzM5PGtGEOpb54HUn3BtQPz0qZujcHkJ11T8we0B3Hs4EKufD4pdry4loHGUhSBnFk1Tpem9Xh0w4vBd52XWLedBnYxYlsbPAubE2xj6ZjGti272a3YqE7qS32tr8fPuwAoAl7iHeqycIP8d14fhzEXJCVsDFBYLi/2Y4hAbupN078eDDeobT6Q4Xlv9j3DXFDWbrhGVEnnCLAgeuzWfxsJ46L3fw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(136003)(376002)(366004)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(55016003)(83380400001)(6506007)(9686003)(26005)(86362001)(33656002)(38070700009)(38100700002)(7696005)(5660300002)(4326008)(52536014)(30864003)(8936002)(921011)(54906003)(316002)(478600001)(66446008)(8676002)(76116006)(66476007)(64756008)(110136005)(66946007)(66556008)(122000001)(7416002)(41300700001)(71200400001)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?EOYollZXQQsirURY1HktaNfxaP23KJTSxABvBSsq/HgzLLlNwLczDvImknTv?=
 =?us-ascii?Q?9q+eERDS83IAU6DVnA4UreqoVpuLvBVreA/In2bskMwU0z9VvaIu1moZNtM+?=
 =?us-ascii?Q?6aQ5Aj8G+mDi9zMjzyojA8gXX3T8eRhOlgsBmiAg+IKKP+e+mZ+f7uBdEDI8?=
 =?us-ascii?Q?rtCX6J4X8Gdgspiqe5UBDzSxDCVCKMfR+i37vtCZ8MNLT1g2TVGTT2JgRebE?=
 =?us-ascii?Q?7w7NOd4ZZuYfXTt8hQ7sznizuUysPrS5Uf3cYxA9jRdL9y1uhpnuijirtakV?=
 =?us-ascii?Q?mWtQvd9PTzZAZB1C6SLTUWy8YJQj5sXPoa+cN4FKUAqnAu0yx9HdLTres1vD?=
 =?us-ascii?Q?HfQz58H/xyIDTJ3UkYUjAt1GlG6o59BXIbtFaUYa6OGPLAjBVMh3afB0yygw?=
 =?us-ascii?Q?0ZvFYaA/ajhyXial2Tlqqr6Poz5/Vlcs9vbJu/+gCM6cXhh46rykpSx4drgV?=
 =?us-ascii?Q?KH97GfgUwVhBqkxDiMwbmA9FjjYQ6cJewQyfQEn3lBm/ViQC9Bkqu7+LMJIr?=
 =?us-ascii?Q?b5MW2tfv5cXKOKTe+pJEHEAFX1bMsZd9hMpRlHX7EPXiILNy+McH5co3csw5?=
 =?us-ascii?Q?P1kTL+/KIHoDk4kV54Tp4J/wlugX0nDwwTUhIRf22BudVBBd+xcm3a3Gjirs?=
 =?us-ascii?Q?i3wcPGEXk8UQcNEGQVq5eMqyNaF+7PGCh0+zZTnySti0iqiWdvhWlvr0piHz?=
 =?us-ascii?Q?8p5ZQ0GxTJ/7fkhXYkbpbIcM2RuVK9+pqE32Sebl7nbaDy6ungEF5eigJchy?=
 =?us-ascii?Q?KuODtSQLYgc/VqHtfgY7Qcf73k3RfWNbT+s3WU1lAYF6DXqXZpz9Mxvgm58H?=
 =?us-ascii?Q?xq+5jZSa/bsdmh15FHtA+zEZd4lDgtefbLkUxWB/AMwoe6aCotCo9IyxcTy7?=
 =?us-ascii?Q?UOBAWwxlDtiyje1JkYvcVYXsFdh5pA7A5Dpy6yAaqn7fQxznD+LN504J9KKZ?=
 =?us-ascii?Q?o0Fnw6ltXZNfqpKUpOGI+wd02dFUNszhgO/oGKFPb3jcJnOeVqR7pFDbQsXU?=
 =?us-ascii?Q?9SW0391H/qWlwcKyvBZL7wykQUY70FkmGcLBDnsXCi/+a3EAxLOUkwSA4grF?=
 =?us-ascii?Q?D84vMA9wO1m0RYJJ4op3JVcK8Iyuo26i5oJfn1KMqgHEhmveI1CTLfTYDT+k?=
 =?us-ascii?Q?SQ9/t8Og+sMhcXHgufDYBGQBmpUANgUovtKwPcNfqvRcEF1gDPYLIw+4iJhk?=
 =?us-ascii?Q?uflB9opMAS3jFs/wnGQ+vRGjH5LztKB9QMf5h2gKBKr/IiUUkBoFyKP7ourC?=
 =?us-ascii?Q?KVtF7E6N5bQD9m1VN0KjX64TTF80la62V70vGrmrrpjvj0Cm+5+6OXIVxwK8?=
 =?us-ascii?Q?L0HcGonCImRDxk0QB4u3jlrc0swfUy+s4wzugTK8FpfTkMcNfbDLGg0rCv3I?=
 =?us-ascii?Q?XoM2Op+6nvfHVE24ynCmqoduXAVj14E3oNWGZtQ7jNaNiOlXjqjlb074QBNk?=
 =?us-ascii?Q?vRJd6AulKdJuIH4QEkIOzsXyD8JkMLKwmqUFRP/p1GwvZTYv9JAJd+UuyNKn?=
 =?us-ascii?Q?sQDwSImuzrB3D6EACIYEisNgKq/IpdVlukbW+db4HjeQ8QZOABVIet44NISj?=
 =?us-ascii?Q?th7/clRj5NWYwZ9ARAI=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c708e457-0c7f-4f7d-902e-08dc158fc377
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2024 06:03:58.3455
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1ATUHcnjo9sJGw7BbszlhxV7TJ+QEYfP9BRPwvn5BVhMiSkgCN9WQnQJcD7c2i1F+yxKD3yDUlI/mQWKcU2u9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8811


> Subject: [PATCH v2 2/4] perf: imx_perf: add support for i.MX95 platform
>=20
> i.MX95 has a DDR PMU which is almostly same as i.MX93, it now supports
> read beat and write beat filter capabilities. This will add support for
> i.MX95 and enhance the driver to support specific filter handling for it.
>=20
> Usage:
>=20
> For read beat:
> ~# perf stat -a -I 1000 -e imx9_ddr0/eddrtq_pm_rd_beat_filt2,counter=3D3,=
axi_mask=3DID_MASK,axi_id=3DID/
> ~# perf stat -a -I 1000 -e imx9_ddr0/eddrtq_pm_rd_beat_filt1,counter=3D4,=
axi_mask=3DID_MASK,axi_id=3DID/
> ~# perf stat -a -I 1000 -e imx9_ddr0/eddrtq_pm_rd_beat_filt0,counter=3D5,=
axi_mask=3DID_MASK,axi_id=3DID/
> eg: For edma2: perf stat -a -I 1000 -e imx9_ddr0/eddrtq_pm_rd_beat_filt0,=
counter=3D5,axi_mask=3D0x00f,axi_id=3D0x00c/
>=20
> For write beat:
> ~# perf stat -a -I 1000 -e imx9_ddr0/eddrtq_pm_wr_beat_filt,counter=3D2,a=
xi_mask=3DID_MASK,axi_id=3DID/
> eg: For edma2: perf stat -a -I 1000 -e imx9_ddr0/eddrtq_pm_wr_beat_filt,c=
ounter=3D2,axi_mask=3D0x00f,axi_id=3D0x00c/
>=20
> Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
>=20
> ---
> Changes in v2:
>  - put soc spefific axi filter events to drvdata according
>    to franks suggestions.
>  - adjust pmcfg axi_id and axi_mask config
> ---
>  drivers/perf/fsl_imx9_ddr_perf.c | 203 +++++++++++++++++++++++++------
>  1 file changed, 169 insertions(+), 34 deletions(-)
>=20
> diff --git a/drivers/perf/fsl_imx9_ddr_perf.c b/drivers/perf/fsl_imx9_ddr=
_perf.c
> index 5cf770a1bc31..261fa7d85753 100644
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
local control registers */
>  #define PMGC0		0x40
> @@ -51,6 +61,7 @@ static DEFINE_IDA(ddr_ida);
>=20
>  struct imx_ddr_devtype_data {
>  	const char *identifier;		/* system PMU identifier for userspace */
> +	struct attribute **attrs;	/* AXI filter attributes */
>  };
>=20
>  struct ddr_pmu {
> @@ -67,16 +78,6 @@ struct ddr_pmu {
>  	int id;
>  };
>=20
> -static const struct imx_ddr_devtype_data imx93_devtype_data =3D {
> -	.identifier =3D "imx93",
> -};
> -
> -static const struct of_device_id imx_ddr_pmu_dt_ids[] =3D {
> -	{.compatible =3D "fsl,imx93-ddr-pmu", .data =3D &imx93_devtype_data},
> -	{ /* sentinel */ }
> -};
> -MODULE_DEVICE_TABLE(of, imx_ddr_pmu_dt_ids);
> -
>  static ssize_t ddr_perf_identifier_show(struct device *dev,
>  					struct device_attribute *attr,
>  					char *page)
> @@ -178,7 +179,6 @@ static struct attribute *ddr_perf_events_attrs[] =3D =
{
>  	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_6, 70),
>  	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_7, 71),
>  	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_empty, 72),
> -	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_trans_filt, 73),
>=20
>  	/* counter3 specific events */
>  	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_0, 64),
> @@ -190,7 +190,6 @@ static struct attribute *ddr_perf_events_attrs[] =3D =
{
>  	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_6, 70),
>  	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_7, 71),
>  	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_full, 72),
> -	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_wr_trans_filt, 73),
>=20
>  	/* counter4 specific events */
>  	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_0, 64),
> @@ -202,7 +201,6 @@ static struct attribute *ddr_perf_events_attrs[] =3D =
{
>  	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_6, 70),
>  	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_7, 71),
>  	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_ld_rdq2_rmw, 72),
> -	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_beat_filt, 73),
>=20
>  	/* counter5 specific events */
>  	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_0, 64),
> @@ -242,6 +240,28 @@ static const struct attribute_group ddr_perf_events_=
attr_group =3D {
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
> +	NULL,
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
> +	NULL,
> +};
> +
>  PMU_FORMAT_ATTR(event, "config:0-7");
>  PMU_FORMAT_ATTR(counter, "config:8-15");
>  PMU_FORMAT_ATTR(axi_id, "config1:0-17");
> @@ -268,6 +288,28 @@ static const struct attribute_group *attr_groups[] =
=3D {
>  	NULL,
>  };
>=20
> +static const struct imx_ddr_devtype_data imx93_devtype_data =3D {
> +	.identifier =3D "imx93",
> +	.attrs =3D imx93_ddr_perf_events_attrs,
> +};
> +
> +static const struct imx_ddr_devtype_data imx95_devtype_data =3D {
> +	.identifier =3D "imx95",
> +	.attrs =3D imx95_ddr_perf_events_attrs,
> +};
> +
> +static const struct of_device_id imx_ddr_pmu_dt_ids[] =3D {
> +	{ .compatible =3D "fsl,imx93-ddr-pmu", .data =3D &imx93_devtype_data },
> +	{ .compatible =3D "fsl,imx95-ddr-pmu", .data =3D &imx95_devtype_data },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, imx_ddr_pmu_dt_ids);
> +
> +static inline bool is_imx93(struct ddr_pmu *pmu)
> +{
> +	return pmu->devtype_data =3D=3D &imx93_devtype_data;
> +}
> +
>  static void ddr_perf_clear_counter(struct ddr_pmu *pmu, int counter)
>  {
>  	if (counter =3D=3D CYCLES_COUNTER) {
> @@ -361,7 +403,7 @@ static void ddr_perf_counter_local_config(struct ddr_=
pmu *pmu, int config,
>  	}
>  }
>=20
> -static void ddr_perf_monitor_config(struct ddr_pmu *pmu, int cfg, int cf=
g1, int cfg2)
> +static void imx93_ddr_perf_monitor_config(struct ddr_pmu *pmu, int cfg, =
int cfg1, int cfg2)
>  {
>  	u32 pmcfg1, pmcfg2;
>  	int event, counter;
> @@ -372,30 +414,80 @@ static void ddr_perf_monitor_config(struct ddr_pmu =
*pmu, int cfg, int cfg1, int
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
>  	writel(pmcfg2, pmu->base + PMCFG2);
>  }
>=20
> +static void imx95_ddr_perf_monitor_config(struct ddr_pmu *pmu, int cfg, =
int cfg1, int cfg2)
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
> +		pmcfg &=3D ~(FIELD_PREP(MX95_PMCFG_ID_MASK, 0x3FF) |
> +				FIELD_PREP(MX95_PMCFG_ID, 0x3FF));
> +		pmcfg |=3D (FIELD_PREP(MX95_PMCFG_ID_MASK, cfg2) |
> +				FIELD_PREP(MX95_PMCFG_ID, cfg1));
> +		writel(pmcfg, pmu->base + offset);
> +	}
> +}
> +
>  static void ddr_perf_event_update(struct perf_event *event)
>  {
>  	struct ddr_pmu *pmu =3D to_ddr_pmu(event->pmu);
> @@ -476,12 +568,16 @@ static int ddr_perf_event_add(struct perf_event *ev=
ent, int flags)
>  	hwc->idx =3D counter;
>  	hwc->state |=3D PERF_HES_STOPPED;
>=20
> +	if (is_imx93(pmu))
> +		/* read trans, write trans, read beat */
> +		imx93_ddr_perf_monitor_config(pmu, cfg, cfg1, cfg2);
> +	else
> +		/* write beat, read beat2, read beat1, read beat */
> +		imx95_ddr_perf_monitor_config(pmu, cfg, cfg1, cfg2);
> +
>  	if (flags & PERF_EF_START)
>  		ddr_perf_event_start(event, flags);
>=20
> -	/* read trans, write trans, read beat */
> -	ddr_perf_monitor_config(pmu, cfg, cfg1, cfg2);
> -
>  	return 0;
>  }
>=20
> @@ -596,6 +692,39 @@ static int ddr_perf_offline_cpu(unsigned int cpu, st=
ruct hlist_node *node)
>  	return 0;
>  }
>=20
> +static int ddr_perf_add_events(struct ddr_pmu *pmu)
> +{
> +	int i, ret;
> +	struct attribute **attrs =3D pmu->devtype_data->attrs;
> +	struct device *pmu_dev =3D pmu->pmu.dev;
> +
> +	if (!attrs)
> +		return 0;
> +
> +	for (i =3D 0; attrs[i]; i++) {
> +		ret =3D sysfs_add_file_to_group(&pmu_dev->kobj, attrs[i], "events");
> +		if (ret) {
> +			dev_warn(pmu->dev, "i.MX9 DDR Perf add events failed (%d)\n", ret);
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static void ddr_perf_remove_events(struct ddr_pmu *pmu)
> +{
> +	int i;
> +	struct attribute **attrs =3D pmu->devtype_data->attrs;
> +	struct device *pmu_dev =3D pmu->pmu.dev;
> +
> +	if (!attrs)
> +		return;
> +
> +	for (i =3D 0; attrs[i]; i++)
> +		sysfs_remove_file_from_group(&pmu_dev->kobj, attrs[i], "events");
> +}
> +
>  static int ddr_perf_probe(struct platform_device *pdev)
>  {
>  	struct ddr_pmu *pmu;
> @@ -666,6 +795,10 @@ static int ddr_perf_probe(struct platform_device *pd=
ev)
>  	if (ret)
>  		goto ddr_perf_err;
>=20
> +	ret =3D ddr_perf_add_events(pmu);
> +	if (ret)
> +		dev_warn(&pdev->dev, "i.MX9 DDR Perf filter events are missing\n");
> +
>  	return 0;
>=20
>  ddr_perf_err:
> @@ -683,6 +816,8 @@ static int ddr_perf_remove(struct platform_device *pd=
ev)
>  {
>  	struct ddr_pmu *pmu =3D platform_get_drvdata(pdev);
>=20
> +	ddr_perf_remove_events(pmu);
> +
>  	cpuhp_state_remove_instance_nocalls(pmu->cpuhp_state, &pmu->node);
>  	cpuhp_remove_multi_state(pmu->cpuhp_state);
>=20
> --
> 2.34.1

A gentle ping.


