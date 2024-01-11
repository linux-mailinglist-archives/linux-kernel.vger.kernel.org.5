Return-Path: <linux-kernel+bounces-23409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C874882AC69
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 11:47:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B60621C235E2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 10:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A371814F61;
	Thu, 11 Jan 2024 10:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="jlxKYbNp"
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2081.outbound.protection.outlook.com [40.107.15.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D501F125CA;
	Thu, 11 Jan 2024 10:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oIf+h6nS+pNAHRofrVFeK3yxBnPiuJi5XlHvk40HnFnbCOYJTyapSaTetQZ5T2dcf4fc//cg7tDNQl3M/0knTRXp6eIideRNWSzATdy5xIPOeq7NdXzQgilpFsS3ndt8rXSqieGT4RGO+mncUyFmcAHhotJJNy2HNKs78tLhb7UCj1NiTjehbFgNVLH/u3NLOjdKbiLQJn9frwNmbBT/twpLIg//7IPEzTlp995MtNeR1yTdP/MwmvExbAIS+8Q3BLCszGOKHsLitL88XBr9OJhFtoCP9QL0aeVvmDzrUaO5g2mYwmy2BUk/sPX0VCe5VQFAeSBkqKhvUBcBek7y9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uv5GElHf7WZhlNgo0rdf6fXmp46bvhAkVW4aRN868tk=;
 b=UvdUOmv5U7ReyHcSG8z3YujssSwTX3qLOqIRl7GkdHFvx0JEYxuIpjN+9XXLUdXMwYbki2bJmTJkTFeZRQNMYqLqpY4ZNlyRhASkcwio9ydRZR0mqRyrR0l99V/vQohEQCluV06CynuyXzGN4EUJEDQbtkezwwlwOtOcm8sglYVkfT+tR88i4z+ICro5AsTOuECFz1YOVqejiUF6sOcFTmjl7/IEimCttpoWTpVFkhbB2yU28v8+ZxrfXgqUVedWN2ixNfd2m7QC+HEsWrNtd777Rc5cBW6Q+KPNGrw7DzND/S8/LQwPpcL/XbZwPqmsr3m/AFIqkVDOUKcxdQIxPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uv5GElHf7WZhlNgo0rdf6fXmp46bvhAkVW4aRN868tk=;
 b=jlxKYbNpCEh3boUUs25x4j3pfVZt6ivM/rEhB86PVwpZrc2mOLkzdQdEgqTAPw+XcNldLjPybsRkhTbYMPPVEGiv5vvi8795z1G02Z+48uCfq9mzpc3JPgibrmcpWMHvEqvNEKwa7JzkpD5lZn/aF5QkRD0w5rer/9DXrVkW5lU=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8948.eurprd04.prod.outlook.com (2603:10a6:20b:42f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19; Thu, 11 Jan
 2024 10:47:12 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6%3]) with mapi id 15.20.7181.019; Thu, 11 Jan 2024
 10:47:12 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Sascha Hauer <s.hauer@pengutronix.de>, "Peng Fan (OSS)"
	<peng.fan@oss.nxp.com>
CC: "rafael@kernel.org" <rafael@kernel.org>, "daniel.lezcano@linaro.org"
	<daniel.lezcano@linaro.org>, "rui.zhang@intel.com" <rui.zhang@intel.com>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] thermal/drivers/qoriq: fix getting tmu range
Thread-Topic: [PATCH] thermal/drivers/qoriq: fix getting tmu range
Thread-Index: AQHaAyyxm4iPh0Sv7U243t/NmfenWrDU4peAgAANj2A=
Date: Thu, 11 Jan 2024 10:47:12 +0000
Message-ID:
 <DU0PR04MB9417DEC3852F9D6036B858D188682@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20231020081337.3141488-1-peng.fan@oss.nxp.com>
 <ZZ-7V2bGL3c1RuZw@pengutronix.de>
In-Reply-To: <ZZ-7V2bGL3c1RuZw@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AS8PR04MB8948:EE_
x-ms-office365-filtering-correlation-id: 40b4b7e6-7d1a-4f12-d15c-08dc1292ab1e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 FOd481L5FA5FJIcs+lYRlO0ksRPM2z+9e36cCQtlFgPHSGm4XPhwUl/lZU8YLEaee6JDf7MaMyZZ4FMAm/p9GSO87XnIpSZ2nlRK4MfHBN4V2u4c4SSQepm/J1YE5Gw/TR1uGryhwuzyX64qTkXh+FEcjDgkrK3yYFP8RGW+MBdVJpXWgAGKVZb2WsqOK+lyq/reCWqRyR1u36jN7aqCItsUQpMwWOKTcr60sHR0Q3JJpuSf1ktsfNLh4fHFMUaP4chkyctj/S/XEiLSeKRd2Ve8tvOwuWV3wPnjwl8epq4vpeEmrFUvgarYVYaRwMMoD7P4g0JDq5gzkFvAz130mfrade6qbW22Llu5CnHqQW3R9q0KrgZzyKcqVcy2GN6vgc2wFis9LSRC87sAqpeMvhBZmsnYPWOxQ/PWRvZM1mGlJrnSdiqGLDxbfhRwWqGea7zrrAffa/Opr2HpUYBo5xFpS70n00jE9vEBlKmAh8zZsUipDSjGD4tkZ5SxlZg+QUv3nr4+AK5wJI7L7BmviTE2u4/rFpCzZ97/9cmltESSD2XlnFDoAYSW9OtR2Bh5E6Jqb82Q3kBP2a/pnhlfxY1lz+0YxDWAKkZ8ipyd1Hw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(346002)(376002)(396003)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(44832011)(8936002)(8676002)(45080400002)(52536014)(5660300002)(4326008)(316002)(110136005)(66446008)(54906003)(64756008)(66476007)(66556008)(55016003)(2906002)(76116006)(66946007)(86362001)(38100700002)(966005)(122000001)(6506007)(33656002)(9686003)(7696005)(478600001)(41300700001)(26005)(38070700009)(83380400001)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?HR3EthmquQguiocOSfcbnq82sU1e7jxSsJ7kiRB0CxLSke/tH+F2SRSQ3Len?=
 =?us-ascii?Q?+6Id5Gvp8iYPmKzNvdo/y7A3ljdAWwUf0CTtYCjQeJ2lqsisuBs+oregCYvJ?=
 =?us-ascii?Q?0eSf4K1QOz3LCxFefg8722FKk0USIyr9DZ7HZ4X9AwKK8ZZ3aV/jN3HC6Ylu?=
 =?us-ascii?Q?OxQTzIO584Lo1gP1fzXKnBBxoAB7uPvnU9KWcmTZDkO+FZevJ6YlSPBIvP0p?=
 =?us-ascii?Q?yR1quyyT0/mLhiDxcQg5jBLnURfcsnLxBbp+hfv0qnMZer0N+QRNBkPYBvk5?=
 =?us-ascii?Q?lD/S7b1byd8pNmB9sRsXV7l4aAQxahzfSS/UJRPziJ9E01YlC2m0u+JGUzCP?=
 =?us-ascii?Q?1YhQkrk7UquEBap79XKm4nrxnU6PDRdMqjR1zOfJd3PpvIRa/5QzwT428c4g?=
 =?us-ascii?Q?Q8c8Xz7JJows8icc6z3ffc/Mm4U6tJNlal1uas/uKK9RGd+xYjLtVjOAzAhM?=
 =?us-ascii?Q?KrkOepK+SQmfy2WJ9FttzKd+M7FA3Jj4volcRgOhDyYoHw5fiHNzSPBqyXcQ?=
 =?us-ascii?Q?xqEMjl7B56tSKF9oOdUAOKfzM0+bPrLRGjJckIYpRvEnZ82UP0hpoPHu5Jzx?=
 =?us-ascii?Q?Ta/UUaxNHIuB+XCbAyaE7q6Vca26yjGSh6E3YiawMfr2GoCUJNuM6/tj7+Th?=
 =?us-ascii?Q?wr6vJkYLPKjmGxUwvHcJqEmVDCS5Qb9eGFqNI3E+0dyatJx6scbse9ha08r3?=
 =?us-ascii?Q?4cC7MtVwt26mvtcxPUG0rvWvNpqcsGF2D+7OjsQmjth/evBwxlgQdslmwSbz?=
 =?us-ascii?Q?yRh5U9JwPzZcVTZKpEuc3IpJAW/jHCdlfkMIXUuw4kqtnZQ9BKQiVsJ0HzSL?=
 =?us-ascii?Q?4MTY1Tie7NhtK/+uQrjtuCRpPHvxlpAYYJvkt2q8DlJzev63dYhYLNacphHA?=
 =?us-ascii?Q?hb41cTfd70d0s0qtaQP2xM2r7sJCN5qTJ8k0asfHpNdvpp5jYRBICvY6+Y5K?=
 =?us-ascii?Q?P6N1jmULJWt1mhT0Xe2csf+a6iHi5hNDGypjWrM1agB2yBXLJcK9AurRjTJo?=
 =?us-ascii?Q?jPi/E2M46W5UUs+6G06v9RCB5hLGamgJ7aP+i9AofUzs+raWi6GoL0cHaDRv?=
 =?us-ascii?Q?5ezdDnbpcIMTvlpoomidnMq7pPCb+ghHc8GxabvrXJMNffB5Z7X2tyVExxdB?=
 =?us-ascii?Q?MW3AVcY3XsSLUU5+LXduSuADytaiiHC/wcp80Aslt62ACk8Qobq8NvB7LN5h?=
 =?us-ascii?Q?mhra5unsTwjYHQMK8Bj3UCwtVBg1ARbkgUGuXeUn9eK7vYba+kYQltLe5rKg?=
 =?us-ascii?Q?WVnY06YOgZQqvu1HLcq6Bd40lhDIK8PBOQx70Gmc2CT2tylY1trmzoD8MBZx?=
 =?us-ascii?Q?mEiugJAC7g2uzttpHOdWrkLrq772chMGoZK+PpTNz4zxJBE2nDaY7eQ3EzR6?=
 =?us-ascii?Q?1788wk8faJGBQa+NENtetnoeLrfZJJrphJdHpuJtArPFs4ILZttnGwSKQsHi?=
 =?us-ascii?Q?Y+hbAzDlqalbxi7kkTSsKW7HOkrL21OzemVM+nTaN0/jQMWNKW6JQx54J3MC?=
 =?us-ascii?Q?KCZikaIp0jC2pbeB4EBgJgNG+Dmk3KXJnesu0e93lpoST/Hw0CvnetXKBFi2?=
 =?us-ascii?Q?LFx9EMmZPhFpdsQE6do=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 40b4b7e6-7d1a-4f12-d15c-08dc1292ab1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2024 10:47:12.4938
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F0G0d16H6SvG7Ul/ZL25SLOyDM1H626LvdV9b6/LhzcgfFI5Bs8qb4keyKJnLr4+EU1TaIYwq5v91J5/MRA1Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8948

Hi Sascha,

> Subject: Re: [PATCH] thermal/drivers/qoriq: fix getting tmu range
>
> Hi Peng,
>
> On Fri, Oct 20, 2023 at 04:13:37PM +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > TMU Version 1 has 4 TTRCRs, while TMU Version >=3D2 has 16 TTRCRs.
> > So limit the len to 4 will report "invalid range data" for i.MX93.
> >
> > This patch drop the local array with allocated ttrcr array and able to
> > support larger tmu ranges.
> >
> > Fixes: f12d60c81fce ("thermal/drivers/qoriq: Support version 2.1")
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  drivers/thermal/qoriq_thermal.c | 12 ++++++++----
> >  1 file changed, 8 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/thermal/qoriq_thermal.c
> > b/drivers/thermal/qoriq_thermal.c index ccc2eea7f9f5..404f01cca4da
> > 100644
> > --- a/drivers/thermal/qoriq_thermal.c
> > +++ b/drivers/thermal/qoriq_thermal.c
> > @@ -57,6 +57,9 @@
> >  #define REGS_TTRnCR(n)     (0xf10 + 4 * (n)) /* Temperature Range n
> >                                        * Control Register
> >                                        */
> > +#define NUM_TTRCR_V1       4
> > +#define NUM_TTRCR_MAX      16
> > +
> >  #define REGS_IPBRR(n)              (0xbf8 + 4 * (n)) /* IP Block Revis=
ion
> >                                                * Register n
> >                                                */
> > @@ -71,6 +74,7 @@ struct qoriq_sensor {
> >
> >  struct qoriq_tmu_data {
> >     int ver;
> > +   u32 ttrcr[NUM_TTRCR_MAX];
> >     struct regmap *regmap;
> >     struct clk *clk;
> >     struct qoriq_sensor     sensor[SITES_MAX];
> > @@ -182,17 +186,17 @@ static int qoriq_tmu_calibration(struct device
> *dev,
> >                              struct qoriq_tmu_data *data)
> >  {
> >     int i, val, len;
> > -   u32 range[4];
>
> Why don't you keep the array locally on the stack? Will it be needed
> elsewhere later?

Because max 16 as of now, it will consume 64bytes in stack, so I
move it out.

>
> Other than that:
>
> Tested-by: Sascha Hauer <s.hauer@pengutronix.de>
>

Thanks for testing this patch.

Thanks,
Peng.

> Would be great if this could be picked up anytime soon.
>
> Sascha
>
> --
> Pengutronix e.K.                           |                             =
|
> Steuerwalder Str. 21                       |
> http://www.p/
> engutronix.de%2F&data=3D05%7C02%7Cpeng.fan%40nxp.com%7C227277d8c0
> 20468aaf6e08dc128ba2ab%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%
> 7C0%7C638405638133353126%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC
> 4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%
> 7C%7C%7C&sdata=3DilwPz4Bs6f7CLf2snic7S%2FUsff0AYCgsFuZP9d2UExo%3D&
> reserved=3D0  |
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    =
|
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 =
|

