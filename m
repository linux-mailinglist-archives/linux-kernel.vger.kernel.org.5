Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38FFB75EBBF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 08:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbjGXGjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 02:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbjGXGi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 02:38:56 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2068.outbound.protection.outlook.com [40.107.21.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 080D8102;
        Sun, 23 Jul 2023 23:38:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hs9hVfJnayzB26QJTSvK1J0jI0ssFhZEs1lYgjV/xTb2fl0p9hy+946yGKoFgOQIoxX4gZEhEUXyyzOlOyRtJc3t60iCtV7bFarr4R1jIwZjM+yo2oHpPnXSmm/o83HFDUbSi0EePw/xIMK92AmJZzleUfooHv2JSvUJujukOMFRtHw25toFDEs5PHb4AVzJqubUKp0J6qj0nv/UtVc7t6muMrcphk/ozYxGGx9S47KH2AmJmsRrsrRzXWS3mJuLgYM9dTkZwTqgVyw/+ofYGQAKyhop35vFiu5Nisqfa2W/8X0dUEMUwdAJqiP5jc3AoU9BDKKXh3YFnY62S4t0Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=stN0jncUkRzdx+NKu3pR3iqYsUCujnnzPqRbE0R2eNM=;
 b=NFsO0iVMjgOEoxL8FMhKMK72DB34jbU89vJnhXy+4TSKnjPr7gxny/9jcneFuxqT2XBBf8ElvcalncMxKsBVL+TkNF3rYg0hBhcpNgKsRjscGHuW/iSU5X/8zfyW0GqA2ByDT/atHSrshfcizmFFW9LJSfamXn+Is2Xdp6Y7h1Co/GoK01Q4ZEoWFbRAHaAVJ6hUhaZsGuO3sVqfQOAYISTuQaxM9BncXHITrIcyeKJrixzCCFkfg/YdGVH/e2gAJ199zq6eznIcULcADwU4Sz/T+GInjxby4BECe7Dsu0+1xCecg+njAr9eqwv27SKH0f3kuvoInrFPp9ZEIX+snQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=stN0jncUkRzdx+NKu3pR3iqYsUCujnnzPqRbE0R2eNM=;
 b=T5t3ga7aGixkI7nFn20vc5lpP+1kFZ0zlGHCigQ43mWiq+xleuaA73gRm6g6xb1KCkAEPn9VM9AxV6piTfzR/G7CrwW9FSW+D6UG3jpHjMOD6JROO99ilFyXo4SJ/zH1mZothxKHdOOIA6H8gcOEN97r1OowYdqVMJ3blADm5xM=
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
 by AS1PR04MB9333.eurprd04.prod.outlook.com (2603:10a6:20b:4df::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Mon, 24 Jul
 2023 06:37:27 +0000
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::175:d311:2cb4:7915]) by DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::175:d311:2cb4:7915%7]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 06:37:27 +0000
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
Subject: RE: [EXT] Re: [PATCH v4 1/7] dt-bindings: arm: fsl: add se-fw binding
 doc
Thread-Topic: [EXT] Re: [PATCH v4 1/7] dt-bindings: arm: fsl: add se-fw
 binding doc
Thread-Index: AQHZtLo09zXvz2nwA0eXBXtTWXN23a+2draAgBH3AkA=
Date:   Mon, 24 Jul 2023 06:37:27 +0000
Message-ID: <DU2PR04MB863034F3609C9878D2DA5F029502A@DU2PR04MB8630.eurprd04.prod.outlook.com>
References: <20230712121219.2654234-1-pankaj.gupta@nxp.com>
 <20230712121219.2654234-2-pankaj.gupta@nxp.com>
 <f3965cf1-3f0a-15fe-7dd3-e83817a4ba3a@linaro.org>
In-Reply-To: <f3965cf1-3f0a-15fe-7dd3-e83817a4ba3a@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8630:EE_|AS1PR04MB9333:EE_
x-ms-office365-filtering-correlation-id: 101d9fab-3eaa-4a70-4ef1-08db8c1072bc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dfQMqBmRzQqgeW7UiP/F3yi9Zj6EAdBi11yXttYYjY3s4w+oTSXItfJupYmHw/Kr5Xqx5+CIYrcwItkVNgP53ewZmebJ1Q3xEU7B0ciMGtaH1sHSViQCIamVQCKGnCgG1RAP9T2N4nM44/tMZAFoWtXGEskGlfTcrVTdwCv8orrwQF045Jwy+DAEgEqC9AB3SN2CLk6wxnUCpl+9tnRuANTMhPtSG7Kz7DlI1pYf2IWlscWntmxDQ32qm/4xC6mNsuccRHnn4nCpEDtbI5xi4QqsHnoOxMz2rXVENet56S0VNtAJldpZt7lb2CFJ+KGIBmr6yrua9xuPm1flFQ5ph6fIdaueh/fnb/8PhYMX8BVCMik0r6gwQuB5QZH3FpP2AOgd4S95SnqBE5odQ+qQ1BRfOCEvSTQlRUBAe9Tr4wBp/q2qMXj2BtB0VziLQMr5AOmG8UcnuM8DQbaNge889O3t6C9IRJg8wyxGA+sFXijv+kYSRTgd3Na/aMmCdjJyDR76MzRVHAo7SOYCvWIHnfKYGwb8579dN11GlSCkDQdiIxFNhBGL4eySQ7Bf28TyatLWjZD+D0jbFrCi55TQGSF8QQ22yDZH/s/IySHJV9pE/h0m0xJjHwgMLQEiG/s2vMjiv3XCV5NakVKACLMcQw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(346002)(376002)(136003)(39860400002)(451199021)(33656002)(86362001)(38100700002)(921005)(55016003)(122000001)(71200400001)(2906002)(7696005)(9686003)(53546011)(186003)(6506007)(26005)(38070700005)(5660300002)(41300700001)(66476007)(76116006)(66946007)(66556008)(66446008)(64756008)(316002)(6636002)(45080400002)(478600001)(7416002)(8676002)(8936002)(52536014)(44832011)(110136005)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jDOQcOK9OCEd2df3Wmqzf+1WjYNIymIevkaLsEAapoEk7btSh4//Bq/pjRfF?=
 =?us-ascii?Q?LrUVbDQDutjIQHMa4DY0d2MRmOAuVyad/JOBXXIaGv+RJXwdzUan71tKA6Xo?=
 =?us-ascii?Q?zxVo4YDlRR3dzlzyrnEgu0uzadEPtlykU5GE9UUy15ZjHSeoLIoqOD015YK/?=
 =?us-ascii?Q?8Upag8RQsSpWz2/FI2bK+9bolDIio9yHHrdeyYYhB/aTAmNl4Y8VXahWPx7Q?=
 =?us-ascii?Q?wcSJowPvCD0Eo328vWP/b1jO1BbqezMyYNj6dPKvRu7RY0wuQ25x8qMk4Bva?=
 =?us-ascii?Q?jNbpoSprnCZoN8GlYlIR2rO70ojhacCQDASNN90fd+PtO0ePchZRu+H8CB07?=
 =?us-ascii?Q?roMbQzqw+fGhTTJL5KAeq9runz44ONHknSJDOd/DeirxRXSmmz+rvkQtRJ/9?=
 =?us-ascii?Q?bRB73Tx9KC4c/l07nqSYajdXNOxbfYAknQw8Uhw02BnyDhlfCGv2W/N8aEeq?=
 =?us-ascii?Q?/ic/uRIkIE/MnkgM05n3fiHd4OcVs9N4qGIr0ZzckAZoEZcsucMxbv9fpMA0?=
 =?us-ascii?Q?ZueJBTNFPt5JPUdkh7M/sVK5ggcD0l56opqK7069cdrYyPNFvf06kwhkffB/?=
 =?us-ascii?Q?Jh9LCEgQQesQHEeUlRoNie94miG9hGRSZOFNtU//zdbK3f34nJBxFX/hpzol?=
 =?us-ascii?Q?beDhvPTyaUA3BUvhJRkTOYqFqXdwLjsL84GGZhZ5c3ASp5RM9Zyrij6pqxMS?=
 =?us-ascii?Q?FChcbZA1q3AX86eg/0yAZkmgVFC16q4yeIJg+sAjkgtV0U/7AYRslBSSpi/e?=
 =?us-ascii?Q?oriNBmx2EG89PkSRZhNhtA0JzrY43CU9m4Y8KYU/Ie4kfkDu2QzoSX/gIC4v?=
 =?us-ascii?Q?y3HdKmjXUHLU6Ei9eLG8nKhYMdLSnf+2ySI9rlpAnuF5PCddcnbtlsVAcNMW?=
 =?us-ascii?Q?OV4o6p58pQvgJu+BsQqhpfmFxRPESAiDAPXLGvhnstcjrLtJOXxRl1XdIQtX?=
 =?us-ascii?Q?Owf5niJ8ThnmXv3isAF7on5uSFqka6u6t3G9PS5RIYoyXYz4KekdyXnijlHM?=
 =?us-ascii?Q?HXNOK87hk6p5pnePE0rNKnSfGwZeLDHNTfOE3VBIeFxgBbNZ0czy14xyiblk?=
 =?us-ascii?Q?r3Z2cNc7MKVEXXugXfLPIhreTmw/VFKt+CMBnvOEP9++1c87z0w7raJ83lmw?=
 =?us-ascii?Q?zWcRe0328q6svevnf/WGYztVOv2rzu3ETgfrfbw17jL3z07rdN46CvJCWWSW?=
 =?us-ascii?Q?xVyt/Wy20GdRVaxMwZNLAL1UICNV6/wgfc8Sn/iISaSUSnph2uBX8QuAPZNj?=
 =?us-ascii?Q?/KYLwuO3o1kfbGVmwd/MX5LHrKzpk/MFXwJIJDLR4zDMUHlBebzHbgfgaUY9?=
 =?us-ascii?Q?6zbwlWH0utvZ9Ceo8LGonXdKXe/ebLi1Ix8Dv+Hv6nybWy+xaWlAuGXevqH8?=
 =?us-ascii?Q?E+LeHQnCMHAk1VsMjN4AzJ9L65BVPKr2m0ljEVeD8LJctqjs48LU2pgtfPvq?=
 =?us-ascii?Q?TbG0kO8SKciJubV34zDmNeCwkNMt8tdkldZR478TQskKXUPZjmEuceTqKpeq?=
 =?us-ascii?Q?ew8ztoi5goIxmJ+LjFU7IeTIgVx4SkL7kyxAX0slMryR4CZ6VY9coXSl1rK9?=
 =?us-ascii?Q?6VjUPI0lr1FUqlE+/r3x7MXaS8+NFjCnyk0CmUZr?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 101d9fab-3eaa-4a70-4ef1-08db8c1072bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2023 06:37:27.5293
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h6boV3LTwfQx+F7C2Ko+/R+RsdrzJtcrdjMYAsLuZmlGD3Am5/saCmsCNZNoC9lP7ZHMGDFvIxCv5dRZjC4Y0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9333
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Sent: Thursday, July 13, 2023 12:09 AM
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
> <sahil.malhotra@nxp.com>; Aisheng Dong <aisheng.dong@nxp.com>; Varun
> Sethi <V.Sethi@nxp.com>
> Subject: [EXT] Re: [PATCH v4 1/7] dt-bindings: arm: fsl: add se-fw bindin=
g doc
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>=20
>=20
> On 12/07/2023 14:12, Pankaj Gupta wrote:
> > The NXP's i.MX EdgeLock Enclave, a HW IP creating an embedded secure
> > enclave within the SoC boundary to enable features like
> > - HSM
> > - SHE
> > - V2X
> >
> > Communicates via message unit with linux kernel. This driver is
> > enables communication ensuring well defined message sequence protocol
> > between Application Core and enclave's firmware.
> >
> > Driver configures multiple misc-device on the MU, for multiple
> > user-space applications can communicate on single MU.
> >
> > It exists on some i.MX processors. e.g. i.MX8ULP, i.MX93 etc.
> >
> > Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
> > ---
> >  .../bindings/arm/freescale/fsl,se-fw.yaml     | 121 ++++++++++++++++++
> >  1 file changed, 121 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/arm/freescale/fsl,se-fw.yaml
> >
> > diff --git
> > a/Documentation/devicetree/bindings/arm/freescale/fsl,se-fw.yaml
> > b/Documentation/devicetree/bindings/arm/freescale/fsl,se-fw.yaml
> > new file mode 100644
> > index 000000000000..7567da0b4c21
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/arm/freescale/fsl,se-fw.yaml
> > @@ -0,0 +1,121 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause) %YAML 1.2
> > +---
> > +$id:
> > +https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdev=
i
> > +cetree.org%2Fschemas%2Farm%2Ffreescale%2Ffsl%2Cse-
> fw.yaml%23&data=3D05%
> >
> +7C01%7Cpankaj.gupta%40nxp.com%7Cfd14adabdde046302b1908db83073
> a2d%7C68
> >
> +6ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638247839285279031
> %7CUnknown
> >
> +%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1ha
> WwiLC
> >
> +JXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3DvUn1TrC%2Fk2f%2B5do%2FoK
> OSu7cWDl3s
> > +6BddlvIIO%2FxZGMA%3D&reserved=3D0
> > +$schema:
> > +https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdev=
i
> > +cetree.org%2Fmeta-
> schemas%2Fcore.yaml%23&data=3D05%7C01%7Cpankaj.gupta%
> >
> +40nxp.com%7Cfd14adabdde046302b1908db83073a2d%7C686ea1d3bc2b4
> c6fa92cd9
> >
> +9c5c301635%7C0%7C0%7C638247839285279031%7CUnknown%7CTWFpb
> GZsb3d8eyJWI
> >
> +joiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3
> 000%
> >
> +7C%7C%7C&sdata=3D9sbFCHNNCHHsjLbZ%2BHQls3ZrXKF%2BhbpizZhIxfvytlo%
> 3D&res
> > +erved=3D0
> > +
> > +title: NXP i.MX EdgeLock Enclave Firmware (ELEFW)
> > +
> > +maintainers:
> > +  - Pankaj Gupta <pankaj.gupta@nxp.com>
> > +
> > +description: |
> > +
> > +  The NXP's i.MX EdgeLock Enclave, a HW IP creating an embedded
> > + secure enclave within the SoC boundary to enable features like
> > +  - HSM
> > +  - SHE
> > +  - V2X
> > +
> > +  It uses message unit to communicate and coordinate to pass messages
> > + (e.g., data,  status and control) through its interfaces.
> > +
> > +  This driver configures multiple misc-devices on the MU, to exchange
> > + messages from User-space application and NXP's Edgelocke Enclave
> firmware.
> > +  The driver ensures that the messages must follow the following
> > + protocol  defined.
> > +
> > +                                     Non-Secure           +   Secure
> > +                                                          |
> > +                                                          |
> > +                   +---------+      +-------------+       |
> > +                   | ele_mu.c+<---->+imx-mailbox.c|       |
> > +                   |         |      |  mailbox.c  +<-->+------+    +--=
----+
> > +                   +---+-----+      +-------------+    | MU X +<-->+ E=
LE |
> > +                       |                               +------+    +--=
----+
> > +                       +----------------+                 |
> > +                       |                |                 |
> > +                       v                v                 |
> > +                   logical           logical              |
> > +                   receiver          waiter               |
> > +                      +                 +                 |
> > +                      |                 |                 |
> > +                      |                 |                 |
> > +                      |            +----+------+          |
> > +                      |            |           |          |
> > +                      |            |           |          |
> > +               device_ctx     device_ctx     device_ctx   |
> > +                                                          |
> > +                 User 0        User 1       User Y        |
> > +                 +------+      +------+     +------+      |
> > +                 |misc.c|      |misc.c|     |misc.c|      |
> > +  kernel space   +------+      +------+     +------+      |
> > +                                                          |
> > +  +------------------------------------------------------ |
> > +                     |             |           |          |
> > +  userspace     /dev/ele_muXch0    |           |          |
> > +                           /dev/ele_muXch1     |          |
> > +                                         /dev/ele_muXchY  |
> > +                                                          |
> > +
> > +  When a user sends a command to the ELE, it registers its device_ctx
> > + as  waiter of a response from ELE.
> > +
> > +  A user can be registered as receiver of command from the ELE.
> > +  Create char devices in /dev as channels of the form /dev/ele_muXchY
> > + with X  the id of the driver and Y for each users. It allows to send
> > + and receive  messages to the NXP EdgeLock Enclave IP on NXP SoC,
> > + where current possible  value, i.e., supported SoC(s) are imx8ulp, im=
x93.
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - fsl,imx-ele
> > +      - fsl,imx93-ele
> > +
> > +  mboxes:
> > +    description:
> > +      A list of phandles of TX MU channels followed by a list of phand=
les of
> > +      RX MU channels. The number of expected tx and rx channels is 1 T=
X,
> and
> > +      1 RX channels. All MU channels must be within the same MU instan=
ce.
> > +      Cross instances are not allowed. The MU instance to be used is S=
4MUAP
> > +      for imx8ulp & imx93. Users need to ensure that used MU instance =
does
> not
> > +      conflict with other execution environments.
> > +    items:
> > +      - description: TX0 MU channel
> > +      - description: RX0 MU channel
> > +
> > +  mbox-names:
> > +    items:
> > +      - const: tx
> > +      - const: rx
> > +
> > +  fsl,mu-did:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description:
> > +      Owner of message-unit, is identified via Domain ID or did.
>=20
> What is Domain ID?

By design, Domain is a clean separated processing island with separate powe=
r,
      clocking and peripheral; but with a tightly integrated bus fabric for=
 efficient
      communication. The Domain to which this message-unit is associated, i=
s identified
      via Domain ID or did.

I will update this info in the YAML file too.

>=20
> > +
> > +  fsl,mu-id:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description:
> > +      Identifier to the message-unit among the multiple message-unit t=
hat
> exists on SoC.
> > +      It is used to create the channels, default to 2
>=20
> Do you expect then multiple ele nodes in the DTS? What are these two
> properties and why they are fixed per SoC, but still embedded in DTS?

Removed this line.

>=20
> > +
> > +
>=20
> Drop stray blank line.
>=20

Removed the blank line.

> > +required:
> > +  - compatible
> > +  - mboxes
> > +  - mbox-names
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    ele_mu: ele_mu {
>=20
> No underscores in node names, generic node names, e.g. firmware. Look at
> existing code.

Changed from:
-  ele_mu to ele-mu.
- "ele_mu {" to "se-fw {"

Name of yaml file, is se-fw.yaml.

>=20
> > +      compatible =3D "fsl,imx93-ele";
> > +      mbox-names =3D "tx", "rx";
> > +      mboxes =3D <&s4muap 2 0
> > +                &s4muap 3 0>;
>=20
> Two items, not one.

Corrected it to "mboxes=3D =3D <&s4muap 2 0 &s4muap 3 0>;"

>=20
> > +      fsl,mu-did =3D <1>;
> > +      fsl,mu-id =3D <1>;
> > +    };
>=20
> Plus you clearly did not test the binding and DTS. You said you did some
> internal review, so I assume this also includes some testing. How did you=
 test
> your DTS?
>=20

Each version is tested before sent for review here.
I have tested the DTS file by compiling it and loading the DTB to the board=
.
Executed test on the board.=20


> Best regards,
> Krzysztof

