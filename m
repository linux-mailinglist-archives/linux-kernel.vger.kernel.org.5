Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7074800416
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 07:42:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377623AbjLAGmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 01:42:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377614AbjLAGl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 01:41:58 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2050.outbound.protection.outlook.com [40.107.8.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38A0A1729;
        Thu, 30 Nov 2023 22:42:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ymb67aBNI7sHrtzLIxaBAMSLF+MndAdJmNP3xHAEegl7g3FEGEZETgnAI7he3M4M9ttqGXtrviyhY5Rln+bU2x/BZh64TGHxNXZUeop+DbtO0d75naUAaWec/JdWpCveWlNxSGU4tyFhdsH8fQWVuhrrfRi/qqDBAW14z7Z1UQapPThzxQnuiqLVCGfpQ3USWwKBjXQ6+3fNzi5Xc1jzzo65z24ZG3bMWHUdTxllga9BiRFlMgM2EAEgcam7apz7fHgKoobtppbzgKP22owU+XTpbMK/LroBxSUg0LBZkAuuZia5ydlHrHUo0hUgSxW19Sa1Sa5TOU1UW61HbAgCAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j2fKEp6XLkEBXSgUBvyAsZRzpoaChGxU/Eu24lfV2S0=;
 b=MDJYXUqGFVCk5pJUlN3+W4OqSf3TaMjwA5E4gB9YlBbe2V3knOi7WIMoR1IyEKVFnondffFsq8essRwpV2Pq7LNB4+PSYzA3gqhSRT7lSb2Jr/eWR3TitXvW/hnvNqMeUD12zLOJ1DRARZm+jGJlK9/38SFgf0gbf99SyJSanYeEVXhWkxh29uRpTPgia2tSAjtBQUpIe33jtRPNkK28OAfzBIkq6xJkkXjad9ej14RsNc+L720I46SY+kt0n05oNge4Qum83TjOw4zNRJKfIIu3bJfBJAbtwcpWQw3dloyXocnTXg57SMx1PJfe8QGSYaedyQXBKR5GjqKhOugWew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j2fKEp6XLkEBXSgUBvyAsZRzpoaChGxU/Eu24lfV2S0=;
 b=POKthm3/SSTCjqKWIz9CZYzLYfgmqpMXP8zQWY9513L9whwY327NYsQrFQL/+JTFRbPNgfdqVH+80O6C57a927Vd3YBaPJDgqkDw3bZJpof6B7xnE2KYEFdUGm/YYIxRtAe+lD9Nb04PuRhrPa0K6RZYEiBN0xM6f3epbIUj+xs=
Received: from DB7PR04MB5146.eurprd04.prod.outlook.com (2603:10a6:10:23::16)
 by AM9PR04MB7523.eurprd04.prod.outlook.com (2603:10a6:20b:2d6::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.11; Fri, 1 Dec
 2023 06:41:59 +0000
Received: from DB7PR04MB5146.eurprd04.prod.outlook.com
 ([fe80::709e:6876:7df0:fc30]) by DB7PR04MB5146.eurprd04.prod.outlook.com
 ([fe80::709e:6876:7df0:fc30%7]) with mapi id 15.20.7068.014; Fri, 1 Dec 2023
 06:41:59 +0000
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
Thread-Index: AQHaIQMMDQEMyEli70eVevbnegWUKbCOblyAgAWSfjA=
Date:   Fri, 1 Dec 2023 06:41:59 +0000
Message-ID: <DB7PR04MB51460A715C6870642B6D7BBE8C81A@DB7PR04MB5146.eurprd04.prod.outlook.com>
References: <20231127073208.1055466-1-xu.yang_2@nxp.com>
 <20231127-whoever-magical-5a7cf2b142e1@spud>
In-Reply-To: <20231127-whoever-magical-5a7cf2b142e1@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB7PR04MB5146:EE_|AM9PR04MB7523:EE_
x-ms-office365-filtering-correlation-id: e35a97ca-5c93-4227-34e2-08dbf2389e5e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3sN2lEq+YopqD8TctAO6ioc+BNH/NkDRdYFsAO+8Ti1XbmgHnGwB5yCHffAKVPJ2DE02kX7jLSwDw9hI/4OYAB/xbvmmkrSDV0DcyI5ee6yHlJsqpHtyLFz+u9WemnCbQi2VmDICmWrmTvQZwAqi4VUjCvhNuLfgxcIJE+7o6KkRKFPWJ1LLKcYwiBr1VzZuqftI6hGvaRovqFQqpQaptlBZXNwG709Nf6FprhYXz7AAzd5kiezL+7QOAqcdS5p83t01a1AcGMovjHO4FpfW8dAoZLdZfUh4uI5QsMpez8ELHcIi7CQQln4qIGYDw+gChetaCZavGOwZv31xA8gLTSFSpnLOqCuVX5BOgvKHIHlmcGfdJQS7lph5fyzou5FbPFfFPztcsOuQhG/qEE7Gdj+gmbyPXbfJsX4RrHxgb0LbQoj9nqpU3YzCAR++QblY4PmY/DouVNXkOgufwFD3EkClANTmNpjjl6L3UgiAjzQuuzfQdWfILa8LjLMy25Vkt62qvNXgLowzV8wDbdeZZmvOI3tNAvbrTF8rIIDLZbuD85xMDKh8QJoobsqdK2hGh2B9fQxo38ZRT2O9xoMyW1LpuzvGcOBt8U0VUXHIVLISUYdSp08DXM4oSVF5RXwI
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB5146.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(396003)(136003)(376002)(39860400002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(38070700009)(55016003)(122000001)(33656002)(7416002)(26005)(5660300002)(2906002)(71200400001)(86362001)(9686003)(6506007)(38100700002)(7696005)(41300700001)(6916009)(66556008)(76116006)(316002)(64756008)(52536014)(66946007)(66476007)(66446008)(478600001)(4326008)(8936002)(8676002)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TUKcQifUZQVqUrFyWWMd2y7PoA1B9rrmFNguw5iYheGfWgG3vxic5SvMS4DD?=
 =?us-ascii?Q?5jEMBgpvZrbMrHlAm0QkPRpegZlA4vqBfwZa3pbFuYEa12XpCkiiGFELs2xU?=
 =?us-ascii?Q?RLiSKnPHZJyhL/a41B/xGBZKNnB8kOkrpgyOKkWDYDcFE4mEt+ryPCk1fKsW?=
 =?us-ascii?Q?JkDXZqR/oWkD5Qv4NRxO5ZZWhat/Xa219pcZ+uu8QaUjnb59TlsWNdnlCcju?=
 =?us-ascii?Q?OzWazwqO9Zv9xREUDTgjrbNFT1kzFod/6Vv2Pa4JFIK7qnJrLDeQ9fKNR1UO?=
 =?us-ascii?Q?MlCovY0qwEbHGBdrA1GXqEnv5P56zn1UVg/GqGduVejuP4ZP8b3rsSsUX5IL?=
 =?us-ascii?Q?Ar09UNtUTMxTeVsUvhhmAPwLreW1pYiLQJMfQ1C74z8g3ecu6QD6pev08cfK?=
 =?us-ascii?Q?OHAA4OwvNi3IJLk0QupiohbfdxP+atgDsLrSeV+YfDWhNXl55M1NoQInef4H?=
 =?us-ascii?Q?sHJ4iCNUG/5TtCTQgGs7PoZ0z5xhNlrWuurGS+E+dTo5ukD7wXVW8GD8yBAJ?=
 =?us-ascii?Q?iUclte/9aDf+Lo4GgSxeU0a76sAQ7ZN6S9oHIsLr/b3u77UBcPdy2MO8Ugge?=
 =?us-ascii?Q?vTYa5duXObmWPBF160HjIfhiC6AckApD1EL9qKt29iBoz+RdPomjyPaUdBbX?=
 =?us-ascii?Q?nzgYjlN73Cb5EOq9K492LGToePknwsFZbGQ6yMwzudYzQplrv+hq+odoKHoy?=
 =?us-ascii?Q?VL+IHhToNbKoqUy8dIjng1awr7MBfCW9unNVwqBeDmT60GGTUMbbhQKqdGzC?=
 =?us-ascii?Q?IIub9XxIaam8BNZRXuhAhGm+gGxyg9Ap4vF7WGlSAS1sfdj1cLcEp+Pegp9s?=
 =?us-ascii?Q?5aXMyufBtM/jCT9Jy/LszJ2W40JmjzP8vcOUzMoMfLNDuRZ2LmkOZJi0U+lW?=
 =?us-ascii?Q?uETUbC+Xw6DhqivEHaEXURtxcv9auewNCPGGIb2PMfCiVUtqKvdjlUZ0ko9G?=
 =?us-ascii?Q?XacQnkeE81hoX9/x9zZlixuBUwDP+hNnJd7KXoPsPqRl6hkuLSlzIqJ4zeHA?=
 =?us-ascii?Q?YG+oQRFCg3SXND2w87aJqtsW98NxKgpT4S9nK8oiFAlUeS0kD1SOYdkKb5hR?=
 =?us-ascii?Q?skoAS8sd0NOHg8vkSb69cPfnX0gglp13OFP3Jlr21VX0cv0sGnMaEi0tgvpv?=
 =?us-ascii?Q?azWV2u2UUxVZkAA6BdPjKb6DcwoU/WpLfCfKB0jkwtR6MEhXXoepvUTXEqX2?=
 =?us-ascii?Q?P0fQMoNIRPpVCis/M++MjqDPre/imkadivhs7sUtBvzoFOaFx6codJfnSvId?=
 =?us-ascii?Q?g3CEhYQjio0F0IKdq49OJS6M/hKkJ+ntADKp15kFRCg/ao+IpkCj2w2DL4Er?=
 =?us-ascii?Q?KWp5Kd/ayRfeiwuQ4TsxwPYBjNoK4dpyFBRMAbBhQsYx6WWVtTfd7HF0I0gi?=
 =?us-ascii?Q?b5C8tSXjr/JJgDVCWcMciPVnxwhO6JDQ378bYcNbKC+ZxO1+lApKKjfnWhZB?=
 =?us-ascii?Q?snORAa95A3fHit69lDT+6zlg7h13xsHEzFeiZjwr/26sBmNa6bTiOYk8ubs1?=
 =?us-ascii?Q?XnTHtOInZVr5boTKspQLVCb9ubRMKOlCgjPNiDeG9kjUsngP4gPOLiHqEV8Y?=
 =?us-ascii?Q?E51uIiF/Kl1f8x/6i9I=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB5146.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e35a97ca-5c93-4227-34e2-08dbf2389e5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2023 06:41:59.1501
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UnrWlS/4nnSdUtV4QlP/lZ4gIcZCbng3hbqatLZkArBBpOlbMQHg+o6LvyCXNL9FzP9YY9CeQ56uqgOsYn3/gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7523
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conor,

>=20
> On Mon, Nov 27, 2023 at 03:32:06PM +0800, Xu Yang wrote:
> > i.MX95 has a more precise counting capability than i.MX93. This will ad=
d
> > a compatible for it.
>=20
> It is hard to tell from this comment, but I figure this "more precise
> capability" is not an option you can enable, but instead makes the
> programming model of this device different to that of the imx93?

Actually, imx95 is compatible with imx93 except AXI ID filter capability.
But for AXI ID filter, imx95 is using different registers and bits from
imx93 for filter configuration. To distinguish them, I need use different
compatible because programming model cannot recognize which device is
running.

compatible =3D "fsl,imx95-ddr-pmu";
compatible =3D "fsl,imx95-ddr-pmu", "fsl,imx93-ddr-pmu";

Both above compatible is okay for me. Therefore, "fsl,imx95-ddr-pmu" is nee=
ded.

Thanks,
Xu Yang

>=20
> Thanks,
> Conor.
>=20
> >
> > Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
> > ---
> >  Documentation/devicetree/bindings/perf/fsl-imx-ddr.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/Documentation/devicetree/bindings/perf/fsl-imx-ddr.yaml b/=
Documentation/devicetree/bindings/perf/fsl-
> imx-ddr.yaml
> > index e9fad4b3de68..1bc7bf1c8368 100644
> > --- a/Documentation/devicetree/bindings/perf/fsl-imx-ddr.yaml
> > +++ b/Documentation/devicetree/bindings/perf/fsl-imx-ddr.yaml
> > @@ -20,6 +20,7 @@ properties:
> >            - fsl,imx8mn-ddr-pmu
> >            - fsl,imx8mp-ddr-pmu
> >            - fsl,imx93-ddr-pmu
> > +          - fsl,imx95-ddr-pmu
> >        - items:
> >            - enum:
> >                - fsl,imx8mm-ddr-pmu
> > --
> > 2.34.1
> >
