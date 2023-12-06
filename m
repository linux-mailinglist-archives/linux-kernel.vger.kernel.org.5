Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82E978064CA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 03:12:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376583AbjLFBmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 20:42:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376535AbjLFBmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 20:42:49 -0500
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2083.outbound.protection.outlook.com [40.107.14.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E44A1B6;
        Tue,  5 Dec 2023 17:42:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JuKiqgEVKhnXmn2A772+3AENGs84p1TzQYoilEO1suQBkql7tcPPruzrkEYe0UARBa5xLL4P4+QwJzVMp7vpz0YTyDfcfK09wVAQhhm77lV16KnBuxoRMOYVyk2gN8eus0BsU/k/cvHgwbpxOiIOVj+z9HY9Hz8+xMJBoQ6LkcgTOo62Ya2FbGtIUntXTh7JaJV2At8f0ra/54DApkM+RH7e8jHEt2AABX0//xDKRORhp1zah0bJsE9hbI45QcjP3rZ91YtzvbKKqpbn2eGkAQ2YdgVwxVtvUcoR4osZh4w1inNa0XwZ42gucwZnYXtJmrvc5MWWq0wiKMoJvKm9mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PmaZoWkECdE4qw3rNMhDf+hFLMMDlqVY/id3odvXeUA=;
 b=Ck9hfE2IXwJcG0Fr2J9l8HjRkMHjRHeP8lEEs3y7+m5NZKjX74ZqXXVl36GkKJjmD6DKiK9BzBpRc1WaDg6tmXEIa6zRo+eaAgd70h048aSQ5SSu1211wuAvYiuZKE4yx7KJXaMl1u9hm72blNgqb6t3rrLpoNraoMbmgL4bDl/WqA4y6ZpYQ8Rm/h4Ytp7VoxRY8L+KDLUxacassMX4wB9eeGgJsOS9+B6UyS/Swnh511gjyJG4/1+p4VDj7aBVZPi7ZYHumYKXkCkqEXTy3JlE1r7+ZT6nqCiPwZFc0648WFWszZWh622hosCKgjADCm6DosHrqo0ylm7TO4OENg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PmaZoWkECdE4qw3rNMhDf+hFLMMDlqVY/id3odvXeUA=;
 b=r+JzJ8+goBjWytbezFtsCk0yWlIuLPhcyhBPU6ZYGp8jbsFwI2u+9+dtOK2u+Yv1iK8j6uUBJ97pEdtVDVGrlnWdLc3j96LJwadclHuwAlzwN/xdgFT2WN0n8AyQWtIOyuFpOjY2qSLIboQhQvKGeElaxTCUX9DGPrl4WsbCf8w=
Received: from DB7PR04MB5146.eurprd04.prod.outlook.com (2603:10a6:10:23::16)
 by AS8PR04MB8088.eurprd04.prod.outlook.com (2603:10a6:20b:3f7::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.24; Wed, 6 Dec
 2023 01:42:52 +0000
Received: from DB7PR04MB5146.eurprd04.prod.outlook.com
 ([fe80::709e:6876:7df0:fc30]) by DB7PR04MB5146.eurprd04.prod.outlook.com
 ([fe80::709e:6876:7df0:fc30%7]) with mapi id 15.20.7068.022; Wed, 6 Dec 2023
 01:42:51 +0000
From:   Xu Yang <xu.yang_2@nxp.com>
To:     Conor Dooley <conor@kernel.org>
CC:     Frank Li <frank.li@nxp.com>, "will@kernel.org" <will@kernel.org>,
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
        "john.g.garry@oracle.com" <john.g.garry@oracle.com>,
        "james.clark@arm.com" <james.clark@arm.com>,
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
Subject: RE: [EXT] Re: [PATCH 1/3] dt-bindings: perf: fsl-imx-ddr: Add i.MX95
 compatible
Thread-Topic: [EXT] Re: [PATCH 1/3] dt-bindings: perf: fsl-imx-ddr: Add i.MX95
 compatible
Thread-Index: AQHaIQMMDQEMyEli70eVevbnegWUKbCOblyAgAWSfjCAAKC+gIAG5sgA
Date:   Wed, 6 Dec 2023 01:42:51 +0000
Message-ID: <DB7PR04MB514668A8B172CD1A2187BC408C84A@DB7PR04MB5146.eurprd04.prod.outlook.com>
References: <20231127073208.1055466-1-xu.yang_2@nxp.com>
 <20231127-whoever-magical-5a7cf2b142e1@spud>
 <DB7PR04MB51460A715C6870642B6D7BBE8C81A@DB7PR04MB5146.eurprd04.prod.outlook.com>
 <20231201-pointer-statue-f30a42b8102e@spud>
In-Reply-To: <20231201-pointer-statue-f30a42b8102e@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB7PR04MB5146:EE_|AS8PR04MB8088:EE_
x-ms-office365-filtering-correlation-id: fffc5af3-117c-4621-d18c-08dbf5fca8fd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2R9aedd3HpN5a4VKwhCAQRZqW694I/w4h5P3WpX9MRKV7Q2XbVe4tZlD5HKqb1R6oRyR2rE0kMiynyPVUoAxXSeQvY/HRjqfZ5JCt+71nXH2DgBMm3cUshsxsSKUaYU0gH8TvB9rXqxHQudSRlMmBZ0hyzA3XV/tEDaNz9USg3V6RlL/o/jrifUBO1PfvKl5mam+VXN5ouGpXHPOiB0wLi8jhmHeqeBrVuzNYZjaCxhi8Inemz68zvFLG5Lk21UK55V3ZBkMdSXnfoChL1DLb5PJP7Bv0kyxlSWqJKiIQQ2W9uPNzNWtreNvRCTJjrQf9FwCL+2EswzxONDFB8zxcukppe+oZtYF2pE3baSFtJZMPY89o5ECRPWJdbP8jDBMujjJxmFyvqTVJuyXFypLw/Dzfn83J1QfjpYpq6nDLwjVHQ/hP5T2eexCwHYXK97J8WUGaOdxYonUsI+7jbDUwQ+Si5ng+/4p/2i2mL1oZ12rUwFKopYCGjtbfRmU8yuoOWNHWr/BvOY7hvf2l7wwQCEDLOi6esciTxxGtv4N5FBstanCjp43EytOzDgAj1fJX7lP/3KiG5bgQNpFo5zdgOT/iqYaQaPj4krHixuEpD6INZBCKoXm3haj+NQYEnyH
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB5146.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(396003)(376002)(366004)(346002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(9686003)(71200400001)(2906002)(38100700002)(7416002)(5660300002)(41300700001)(86362001)(33656002)(26005)(8676002)(7696005)(478600001)(4326008)(8936002)(52536014)(66476007)(316002)(66556008)(66446008)(64756008)(54906003)(6916009)(66946007)(76116006)(122000001)(6506007)(38070700009)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?U0Kf31ANKzbab1DF3BHYaBe+8wCXeWmFAQyFahJO5WV5eKNCaFuMDPNi7+D9?=
 =?us-ascii?Q?h4RCCrPHY+zD8niJvjPZV6zuRyC0cDIsQKh1J0EP6PFy8vsdg3xRsQVtb31N?=
 =?us-ascii?Q?CZ5C8GRhlt99p1Pt/IW4RutbPET7FCwM93EdyadxSJfda8WQ9+KpaEKkFlp4?=
 =?us-ascii?Q?AfjAG+P2xLwleaVpeg+Nq+xJvb7YnH5pcWGVOG/xY+PAFlkIgMm95ZFA/Z42?=
 =?us-ascii?Q?zbnWCJ1hPpfHuza+gU5RDm10gntoxtsi6xfBKTN3mxxqC0gWQL70ZFpzhRz8?=
 =?us-ascii?Q?EffV/sGs6U5LowfPmBjoFcIbj0dTyeaiMT+9UIu2vMikAE0MkhIxf4YPWI3D?=
 =?us-ascii?Q?a38JFbngiYuf2Ycy5adifp4atqqVFOigNWQVg65UeXoVHXoAHkXCFO/bo3Xy?=
 =?us-ascii?Q?/Xyiqj3WSS51N1pWD3l0trpuF6ggFOhRF2ZiPoHbdpRm2/0yZuIaWZ4+KoRC?=
 =?us-ascii?Q?ESVxgin6wqE4ZouehqbtYW6R8/VwqMkfHBrgjBe3zgojCEd5KNYewHnsUjO5?=
 =?us-ascii?Q?fLq5OXWM49r0UXXs7rZZCWLn8xf7uh23cqZd87XOo2E+1V62pSWfm57knO+n?=
 =?us-ascii?Q?1TVhOpNoIUp0S2Sa0o8ZBSZvpil510GXETliN/M1MkZiOFzzR13y6hiw2b42?=
 =?us-ascii?Q?5jAegyAMPeT+m5Ojqs+RCbdQdj+ETB9NlCN5L3kbQ3wQfv6L345WLOljnzD5?=
 =?us-ascii?Q?fG3WXE+yl0hcrr2U6ObVtFile37EFLtdicdFcG4p+UMJjJMlckr35s5uwGZI?=
 =?us-ascii?Q?/SkFLmu6/Z1ZWyqK/jhvO4jAIuTAfeZ5ZfRL0KN3InABYyUKd+99pLUY1CWC?=
 =?us-ascii?Q?Ee3JNF0RQEcg8Hh0y9cYaARhzBBvX8jmqJ++BGOqL0KZU92tQM2ZC+R+k3KC?=
 =?us-ascii?Q?1m/XLVNYXcBLEP0423NtpfXXt31safGSfX4SOt9noLZ0LjP4y9ImKp950fN/?=
 =?us-ascii?Q?xlxmAvNFYD+6glV0/ZiGRS2F9/pSNV58LSo9XXfwKEgWlKVZ+1fDIQ4DXDyR?=
 =?us-ascii?Q?gMaE9DaFCOGToloXT65LiK7mW8uBflgOKHcm1rK5tiOlJW1RqPSz5eXvW4md?=
 =?us-ascii?Q?9VAOrwQ8nSHVsUfLaqJqFHq2hSwBoOzNcevxqYsTyHrf34D0TL0wUi8D/LQf?=
 =?us-ascii?Q?2S6RuUE6DReBWoq6TTe8Fmu/qVfmcI24dBsa6qDJsZ5Wah4a6YoRpzOI8ukw?=
 =?us-ascii?Q?x3/mFInVgQKqWWhuydqXLk2fh0gGQpsYWsOfp+TRLh++wU0bieNMiwRxFGCj?=
 =?us-ascii?Q?RE2WOG+y4nVic8Mzm6Zq7itJ4OzwThU+UW1VDSTNBepBcSQOj5nMW0mr8xr+?=
 =?us-ascii?Q?5zOJ6Yk5d3OdyBkZZVCJvxD8NnIlYJACl74GaMnSCmnD/7B8BPgFHOrDg3WQ?=
 =?us-ascii?Q?UJv0TSpwSIU8Z8IEB6ORmahO+suGZ0RcQ11HpZuQYkXRpbdb6boCYcgVVd9t?=
 =?us-ascii?Q?hzDstj6GQ1NIG9Kqg6sz4UGyoqT5Jpk7jdZNff7YPmwVXtMlS0N2kPZX8JGT?=
 =?us-ascii?Q?RXi2UiHnYLR67qzHMDQDDFSlADKTUF1rYqXdQ2i+unP2pI6sCNEC8SS7izu5?=
 =?us-ascii?Q?HvM+lfhCrDxLjM/wHZc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB5146.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fffc5af3-117c-4621-d18c-08dbf5fca8fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2023 01:42:51.8208
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fISrMY92e9JiG69NxsNGv03PxXV9S1PvYV7DenXE3PoKx49vfpWM+QmQVZsmk0LRzjCXDgeAo3Z5z3esNjYY/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8088
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hi Conor,

>=20
> On Fri, Dec 01, 2023 at 06:41:59AM +0000, Xu Yang wrote:
> > Hi Conor,
> >
> > >
> > > On Mon, Nov 27, 2023 at 03:32:06PM +0800, Xu Yang wrote:
> > > > i.MX95 has a more precise counting capability than i.MX93. This wil=
l add
> > > > a compatible for it.
> > >
> > > It is hard to tell from this comment, but I figure this "more precise
> > > capability" is not an option you can enable, but instead makes the
> > > programming model of this device different to that of the imx93?
> >
> > Actually, imx95 is compatible with imx93 except AXI ID filter capabilit=
y.
> > But for AXI ID filter, imx95 is using different registers and bits from
> > imx93 for filter configuration.
>=20
> This sounds like it conflicts with...
>=20
> > To distinguish them, I need use different
> > compatible because programming model cannot recognize which device is
> > running.
> >
> > compatible =3D "fsl,imx95-ddr-pmu";
>=20
> > compatible =3D "fsl,imx95-ddr-pmu", "fsl,imx93-ddr-pmu";
>=20
> ...this. If drivers for the imx93 need changes to work on the imx95,
> then `compatible =3D "fsl,imx95-ddr-pmu", "fsl,imx93-ddr-pmu";` cannot be
> used. If they will work, with only the new imx95 features being
> non-functional, then you can use it.

Yes, it is. When compatible =3D "fsl,imx95-ddr-pmu", "fsl,imx93-ddr-pmu" is=
 used,
only the new imx95 features is not functional, other basic function works f=
or
both imx95 and imx93.

Thanks,
Xu Yang

>=20
> > Both above compatible is okay for me. Therefore, "fsl,imx95-ddr-pmu" is=
 needed.
