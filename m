Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E54877CD1C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 15:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237351AbjHONEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 09:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237343AbjHONDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 09:03:39 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2075.outbound.protection.outlook.com [40.107.20.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0513B0;
        Tue, 15 Aug 2023 06:03:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=haPdl79MY8m0Tr5k1DOSctah1Vs3B4vDGPbbr5Jl8kkiS6RWu0pLkfep5vBK/hoArkgZfFMjwLUegQd7MuzlqMexQ//yiQi2Sj6NdwjpFt5EAL3e+lzRvAukh189bX8IBk7hUjhUxU0Jox9fqVOUksOci0QABtlfmapL1CEc9AwPWPZKbQTqX87VMqjW1kXqefeW9GkQelu9Osgd+0EytQvpK/RY+iLVEp0rJfBCwrDt6HSwwRjj+C8PSGJJpYudyPDV1GcYkZjZtwqfNS+GAYwyIk5V2tfCFxzpkBEWlGf945ITDjgVH6vRZg0AlfXYI1//vH7QJjy+3zndxnUiVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SwV+JXX2y0zJq30DtD2p5N1XWtlP9TfTpglGD2Cu5LE=;
 b=lZM3RkSjzrQH56XWd42doobofxie0H3kF0D8sbjKRWmKhxtSWR7U/fnLLWZgGHV4a9IhriQHUwI0h5vUDOe5JHc4RMiW8ILlvghaFrWoB7ca2aZtz/ONEoqsyTRXDPkgrBHcMpw0GQbA2Mq1ZKawtvaoeP9LFxm2qwpNZ47UvkmCt8YSaHFrndG4Rl1ynIOSmHMUhZTxQZ8DZXuVFwH18bRCsmsbAfkKE9eeHjJeXHNpyvYc6MGV4y60WQBLnBtQt60+vyJkSF+RO2PJ+jC4gk94RVB8DMJn91pWzutmeJM3zEQi0IG0t1HihwA+JHgsSdSyK1VkwaVTvgjSQKldhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SwV+JXX2y0zJq30DtD2p5N1XWtlP9TfTpglGD2Cu5LE=;
 b=ninby9EwqS6PjWzh5CRHHsxKbsDsT8OM/ZANhIKbvjBk3RvRd9C6WCNp2gbkclTdBZ5I6aDfMbwQgG+NuhrPe3YGiuiD8fJa9V/1/8Ejg0fL1lulJix/3MC24K75zINsseaUMXG4yyQL3YL+DtR4PFul+Qx/O3dStI5PrtgoEeg=
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
 by PAWPR04MB9718.eurprd04.prod.outlook.com (2603:10a6:102:381::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 13:03:34 +0000
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::175:d311:2cb4:7915]) by DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::175:d311:2cb4:7915%7]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 13:03:34 +0000
From:   Pankaj Gupta <pankaj.gupta@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "clin@suse.com" <clin@suse.com>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "pierre.gondois@arm.com" <pierre.gondois@arm.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Clark Wang <xiaoning.wang@nxp.com>,
        Wei Fang <wei.fang@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        Bough Chen <haibo.chen@nxp.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Gaurav Jain <gaurav.jain@nxp.com>,
        "alexander.stein@ew.tq-group.com" <alexander.stein@ew.tq-group.com>,
        Sahil Malhotra <sahil.malhotra@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Varun Sethi <V.Sethi@nxp.com>
Subject: RE: [EXT] Re: [PATCH v4 2/7] arm64: dts: imx8ulp-evk: added nxp
 secure enclave firmware
Thread-Topic: [EXT] Re: [PATCH v4 2/7] arm64: dts: imx8ulp-evk: added nxp
 secure enclave firmware
Thread-Index: AQHZtLo4vD63ufm320WJ9kJWTP24Za+2dl8AgBIVjdCAGBmKgIAK4p4Q
Date:   Tue, 15 Aug 2023 13:03:34 +0000
Message-ID: <DU2PR04MB8630E7B069A9F9CF2889636C9514A@DU2PR04MB8630.eurprd04.prod.outlook.com>
References: <20230712121219.2654234-1-pankaj.gupta@nxp.com>
 <20230712121219.2654234-3-pankaj.gupta@nxp.com>
 <1ac2fb68-02e0-ddfe-87aa-fcd093779009@linaro.org>
 <DU2PR04MB86306E154C195F69368D3AB8950DA@DU2PR04MB8630.eurprd04.prod.outlook.com>
 <701ad779-0d1e-e8e6-8eba-294452cfb0bc@linaro.org>
In-Reply-To: <701ad779-0d1e-e8e6-8eba-294452cfb0bc@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8630:EE_|PAWPR04MB9718:EE_
x-ms-office365-filtering-correlation-id: 637d0243-f9d7-4a75-18d4-08db9d900858
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XCUUnZoJ/qoildlTzr62qyU8QQlBaaNDnsssbgwFSnAaZ8xrgYHNNovna/ZSAFCu/73W7qc8gpWu3fh05LVinpGGyWT1Mp8qcLzh+vnlh6lSfh+RRkYjxCoyEQc6PvrdHlQh5zqwdFqJDnhxkcPfz3wsyasZW4VK7RqCR9NRDXpAr5hVxt6o4Pn6juiOt9rgi9CiWSUb3ejcvE4tD3F9GUm2z6DnsNMpvtls6D15CmT5+eDNRPsxgVituC4DGMj7a7q6XmIkJv02KTHCilPG9G9ZRT9NbUCbxnnNEx41VPhJJdqcN1JSUk+WT8wFvsrJSEpVXlxZg6WPINHhCa3c2/7TK43zlXUPBhwkx6d5cp/ZerB1i7Fb93+axqyUN4AeytF2Z1X0mq6IUh6uWbT2aN8HPQIceJWl/4Yo4Umkm/hcmoEHy2KAXyN9zNWe5RS5Aj/AY7smBj3Lug8r3LoFwYQbvnQEfPPUzQK+m3LojfnzlzOpYecZcvpO3PREUlTRrhPoAp212NxBMjy1BiSIjD/rSmR09b3tGZBD/eroe8IIohY4NWGKdcynPVSgne3DSmkfdCw50aVMn6+67YlwcACil0pCbguJbrWaaMf3bTWM/DcDdZhpaePz+fuwqsiYXsiHI/yoT0ZOjOw3WzAE0x8DxRceFy9GV9pXbuXUp7s=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(346002)(396003)(376002)(366004)(451199024)(1800799009)(186009)(478600001)(71200400001)(966005)(38100700002)(76116006)(55016003)(38070700005)(921005)(6506007)(66476007)(66556008)(6636002)(66946007)(316002)(5660300002)(41300700001)(26005)(53546011)(9686003)(122000001)(33656002)(45080400002)(86362001)(110136005)(83380400001)(64756008)(7696005)(66446008)(2906002)(8676002)(44832011)(7416002)(8936002)(52536014)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?afxE2c/9StKhZjdaTvVSNpKv2kqIWOzQ9UoQLMjU/9XRkKDxSedpGI6cckrX?=
 =?us-ascii?Q?v5HL5mC9rrdW5iHkMegSwrzx/FHadB1awqkLLrat2HmmPmv2RSkPdU3t9MbF?=
 =?us-ascii?Q?62tL0jB9/MwWqbdnGs+aocM02U4i3VOIce3ow0ocbQucOcg6wpEQz6K/SK0/?=
 =?us-ascii?Q?HDrF867uZaUgf1UVmdWwQD1cWDG6lZDRACvRKd6c0u02D/ufglfntU7t+/tj?=
 =?us-ascii?Q?5NRCFH9rSK0EhlOlnpcqPNzvYbAq8RfdralGyGCXyRtrTh92l3DBcEpGaUI9?=
 =?us-ascii?Q?pNtn32OVpQkji8EUeKkWD384eg8gfGqshaZJLJLAAepoa04rqgn4TXwLDf0a?=
 =?us-ascii?Q?jwMNQxjNHAO0fiZMhfch8H1A+I1RcXeW/rwaFNkOf0LigbfJjDRvB/O3TNsl?=
 =?us-ascii?Q?Y3sAoJNC7oFNjrhQ6v24QYUxaF9bWEeuKJ60hH5QApGL/gOMr/5vYE75Maph?=
 =?us-ascii?Q?xgmbaLfHjQHPrpbD42x7bB8YOmWGIJMnxAn6xh8pAUP1oW/Ad9KIiMNqSetw?=
 =?us-ascii?Q?OhzQW4HGtWBihW1VSu8rbV1t4g639Yomx6+w/MpNOhHwWB4ApaC6GxFF89g4?=
 =?us-ascii?Q?6hrfHqsXYMLfmuNDEl02lKnFe8B1n81q6ktsqzYAOIua8UXZUIGc1ULOL7jx?=
 =?us-ascii?Q?xKB10O8dYu5xqfBdgBLD1LIF9aeiUGREgUoVqCBQFxCsCF+J2pVB5CQGipy6?=
 =?us-ascii?Q?cJ45qUpq9ZRAxQouAp2zsJvKbDlOyo1xt6q6GnHHhuyCTZfFtLcH+U72q1SP?=
 =?us-ascii?Q?oqZXVUi5/5yKTNoyAeA2y7IB58geXwUlGBSNqxEanN0yA40vXjes/rejVcxQ?=
 =?us-ascii?Q?lklzOWI6uAMY7W8fp47KVABl58G1U/7HAcipQt/QzIS6v1XT6/PRQdy676Kb?=
 =?us-ascii?Q?S41lMg/6Km1c2l9l2zrg8JfGW8QQc1fFRcCXY1jKbRmx4gZUWISSQMKDKnry?=
 =?us-ascii?Q?d4KVb7HqUH8hZ98WXqvkd2STV/lTo9IjKTrFXSJXWxLGWJ+5JTjeswG3u+71?=
 =?us-ascii?Q?8iKLqs9QIzmcFDjyWtlMA7V/3ggtZPnDxHD9BAtrd4lhmTqTRmhS8Rm/Rc2o?=
 =?us-ascii?Q?CwXNVKckqIs4Lubw52v9/uoUUATN5IHWTscRvx+BkGSMXHyyxhvoC7KO22s6?=
 =?us-ascii?Q?PVtJgefbSfUNJC1DgWI2mK1P1YQCdybFfl5TsGeGQg8alDh5NoQiWBib7LNN?=
 =?us-ascii?Q?53Qf5vC+Y8JFDCLkGCMVF/YITg/FoGngPITf9V0jxxd5njVGjp1ACNLb6giz?=
 =?us-ascii?Q?1Gbngw8w39oUVu3372IZONo9cJBwiZB75+6SwdUxN08TTmuUj59MlilSMqOu?=
 =?us-ascii?Q?GcvolAvmeue8rBb5PGsizKUUI8i/06i20Yff73KFsYdzw57kvMs44zch+j0o?=
 =?us-ascii?Q?3RyXE1kcqKiVUwFt2Tgjn7M2TNOijv1h05tTmiz6t+5tQ1L7F1YQw7OmCkRZ?=
 =?us-ascii?Q?rbkNTKgiTDdlPUDifgZ3R3lvtHwY0bzLPv8RdlFQkMg9m6vFPR4BMV8ncIPn?=
 =?us-ascii?Q?Imo613mJpC/M3tHGvTT1DkgnIMLRsU76kRGVdkt3FUfSKlG2SpjAQWZfN4QX?=
 =?us-ascii?Q?jDSQKDcfRWsVT5VRH/aflkgpc1JlkJF590de+RQ0?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 637d0243-f9d7-4a75-18d4-08db9d900858
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2023 13:03:34.3330
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SqSRpYeoczIGVJ72jSoSizPootJBxPJw2A/2mzim2YGRQ62tAzkPNulGAJQNtrCmWhmp2AkKBOpXQSwVtCPpPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9718
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Sent: Tuesday, August 8, 2023 8:19 PM
> To: Pankaj Gupta <pankaj.gupta@nxp.com>; shawnguo@kernel.org;
> s.hauer@pengutronix.de; kernel@pengutronix.de; clin@suse.com;
> conor+dt@kernel.org; pierre.gondois@arm.com; Jacky Bai
> <ping.bai@nxp.com>; Clark Wang <xiaoning.wang@nxp.com>; Wei Fang
> <wei.fang@nxp.com>; Peng Fan <peng.fan@nxp.com>; Bough Chen
> <haibo.chen@nxp.com>; festevam@gmail.com; dl-linux-imx <linux-
> imx@nxp.com>; davem@davemloft.net; robh+dt@kernel.org;
> krzysztof.kozlowski+dt@linaro.org; linux-arm-kernel@lists.infradead.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; Gaurav Jain
> <gaurav.jain@nxp.com>; alexander.stein@ew.tq-group.com; Sahil Malhotra
> <sahil.malhotra@nxp.com>; Aisheng Dong <aisheng.dong@nxp.com>;
> Varun Sethi <V.Sethi@nxp.com>
> Subject: Re: [EXT] Re: [PATCH v4 2/7] arm64: dts: imx8ulp-evk: added nxp
> secure enclave firmware
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>=20
>=20
> On 08/08/2023 13:07, Pankaj Gupta wrote:
> >
> >
> >> -----Original Message-----
> >> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >> Sent: Thursday, July 13, 2023 12:08 AM
> >> To: Pankaj Gupta <pankaj.gupta@nxp.com>; shawnguo@kernel.org;
> >> s.hauer@pengutronix.de; kernel@pengutronix.de; clin@suse.com;
> >> conor+dt@kernel.org; pierre.gondois@arm.com; Jacky Bai
> >> <ping.bai@nxp.com>; Clark Wang <xiaoning.wang@nxp.com>; Wei Fang
> >> <wei.fang@nxp.com>; Peng Fan <peng.fan@nxp.com>; Bough Chen
> >> <haibo.chen@nxp.com>; festevam@gmail.com; dl-linux-imx <linux-
> >> imx@nxp.com>; davem@davemloft.net; robh+dt@kernel.org;
> >> krzysztof.kozlowski+dt@linaro.org;
> >> linux-arm-kernel@lists.infradead.org;
> >> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; Gaurav Jain
> >> <gaurav.jain@nxp.com>; alexander.stein@ew.tq-group.com; Sahil
> >> Malhotra <sahil.malhotra@nxp.com>; Aisheng Dong
> >> <aisheng.dong@nxp.com>; Varun Sethi <V.Sethi@nxp.com>
> >> Subject: [EXT] Re: [PATCH v4 2/7] arm64: dts: imx8ulp-evk: added nxp
> >> secure enclave firmware
> >>
> >> Caution: This is an external email. Please take care when clicking
> >> links or opening attachments. When in doubt, report the message using
> >> the 'Report this email' button
> >>
> >>
> >> On 12/07/2023 14:12, Pankaj Gupta wrote:
> >>> Added support for NXP secure enclave called EdgeLock Enclave
> >>> firmware
> >>> (se-fw) for imx8ulp-evk.
> >>>
> >>> Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
> >>> ---
> >>>  arch/arm64/boot/dts/freescale/imx8ulp.dtsi | 12 +++++++++++-
> >>>  1 file changed, 11 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
> >>> b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
> >>> index 3ddc0f3125b3..10ed31974a6f 100644
> >>> --- a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
> >>> +++ b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
> >>> @@ -114,7 +114,7 @@ sosc: clock-sosc {
> >>>               #clock-cells =3D <0>;
> >>>       };
> >>>
> >>> -     sram@2201f000 {
> >>> +     sram0: sram@2201f000 {
> >>>               compatible =3D "mmio-sram";
> >>>               reg =3D <0x0 0x2201f000 0x0 0x1000>;
> >>>
> >>> @@ -161,6 +161,16 @@ s4muap: mailbox@27020000 {
> >>>                       #mbox-cells =3D <2>;
> >>>               };
> >>>
> >>> +             ele_fw: se-fw {
> >>> +                     compatible =3D "fsl,imx-ele";
> >>> +                     mboxes =3D <&s4muap 0 0 &s4muap 1 0>;
> >>> +                     mbox-names =3D "tx", "rx";
> >>> +                     fsl,mu-did =3D <7>;
> >>> +                     fsl,mu-id =3D <2>;
> >>> +                     sram-pool =3D <&sram0>;
> >>
> >> It does not look like you tested the DTS against bindings. Please run
> >> `make dtbs_check` (see
> >> Documentation/devicetree/bindings/writing-schema.rst or
> >>

Following tests (1 &2) were performed:

1.  make -j32. Build the images and DTB to test the functionality.

2. make dt_binding_check DT_SCHEMA_FILES=3Dfreescale.

3. make CHECK_DTBS=3Dy freescale/imx8ulp-evk.dtb

Before sending the V4 patch for review, I have ran tests 1 &2. Both were pa=
ssing.
But after seeing the page shared by you, ran the 3rd test and I was able to=
 reproduce the issue, you might be referring to.

For V5, I will perform all the 3 tests.

> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fww
> w
> >> .li%2F&data=3D05%7C01%7Cpankaj.gupta%40nxp.com%7Cfce997832862
> 4056830408
> >>
> db981e9af6%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6382
> 710294401
> >>
> 41352%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2
> luMzIiLCJ
> >>
> BTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3DKi%2BHqff7
> rZbTAnAbJ
> >> ZgRiwxGUx0qJjYzxIjMHNoyM8s%3D&reserved=3D0
> >> naro.org%2Fblog%2Ftips-and-tricks-for-validating-devicetree-sources-w
> >> ith-
> >> the-devicetree-
> >>
> schema%2F&data=3D05%7C01%7Cpankaj.gupta%40nxp.com%7Cd13d0b68d0
> 1c
> >>
> 4d10d8cb08db83070ed2%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%
> >>
> 7C0%7C638247838553225400%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiM
> C
> >>
> 4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000
> %7
> >>
> C%7C%7C&sdata=3DpO6dnz4aPqVejRNDR0OU4n04hXebyqgrNKg4DPhahI0%3
> D
> >> &reserved=3D0
> >> for instructions).
> >
> > Tested. Before submitting the patch.
> > [Pankaj] Accepted.
>=20
> You really tested that patch? Before I waste my time on proving it was no=
t,
> are you 100% sure that you tested that patch and no new warnings are
> printed? Or are you just agreeing with me that this time you will test?
> >
>=20
> Best regards,
> Krzysztof

