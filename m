Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39C99773C41
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbjHHQDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjHHQBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:01:43 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2045.outbound.protection.outlook.com [40.107.7.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D42FF3;
        Tue,  8 Aug 2023 08:36:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J683Je7hWWBGY1axPvChQ1rTSc94+SorTB2iIoIuwn4eI9kPn6LY2a6nNbUFAI7PpxzI7rsMc/481UX9Tp60DPgB8qnbbYSngjnC+aWdlCC8tWxZ6wDhXzHQ/BjjmTYRyLNdga1m7EMSudSM1jhEr8virvJmmlauJprcVfPNj2aCGCye9NFplmut/xEwIKwIVBoxq/5AZDH4Rvaw9C5ouNbKbwksMHxnP+aqmd4O0GvZAWtrtpBCRK0XTazc0/oBTPS+WT2jtx8ybNfDioCmsZE+ijb9NlrwtfUKXRZv52qZxhTVaz9JnwmPCi/bValWUp6jG5bd97mJ6/OhtVpl4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GU1L5OJ30BXg8ywfxb7D1g9hVVjlCCK4t9banMVDPO8=;
 b=T80PboDTPivulFCvYzHgU6+V9yL47+4YU6FrnaglXUflAU1FC3C2KysLzPJ+Jq1/mx630DJiC6pcsInBT4hVxAvyeRdX5pMjC/1zD/9a8Du7KJlr/2NgrMJJ1AzPZbR3+826pRc/UnyuQF79orGwzAzKHzZQ3+4zZpowXDmMvWm/46ntbCSquLCQmKaol+K7il1rc6TOGZb+vNxtzHFekrCN2sQTf2GzSdBDrobna62DXC8PjOuQXc/6omxWvKC4XZ1WQUFSgfU8V0czn0J4iUzVP0u6TFIYJP4j6b7MWkbj4jc3SQ6q6r7wtS9o/VJQ/TwVXh+GyQpXxgBYGnFA9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GU1L5OJ30BXg8ywfxb7D1g9hVVjlCCK4t9banMVDPO8=;
 b=A790D60Z2VtZhSSCpdnKsHAXrInERzR5UvKxsf5EJtMH//tEhrxQBkZBd+6zI0yMy6JnJbJK8jfMb8+VH4uHmtPPoW8r4vZCNx62OINRi8FmEORv4aMrHrHB7TbLoiojzuJmvJmN4IkeJ8NPoOQHetM/xO3NjGk4ZmhQp2GlmYo=
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
 by AS8PR04MB8804.eurprd04.prod.outlook.com (2603:10a6:20b:42f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 11:07:55 +0000
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::175:d311:2cb4:7915]) by DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::175:d311:2cb4:7915%7]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 11:07:55 +0000
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
Thread-Index: AQHZtLo4vD63ufm320WJ9kJWTP24Za+2dl8AgBIVjdA=
Date:   Tue, 8 Aug 2023 11:07:55 +0000
Message-ID: <DU2PR04MB86306E154C195F69368D3AB8950DA@DU2PR04MB8630.eurprd04.prod.outlook.com>
References: <20230712121219.2654234-1-pankaj.gupta@nxp.com>
 <20230712121219.2654234-3-pankaj.gupta@nxp.com>
 <1ac2fb68-02e0-ddfe-87aa-fcd093779009@linaro.org>
In-Reply-To: <1ac2fb68-02e0-ddfe-87aa-fcd093779009@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8630:EE_|AS8PR04MB8804:EE_
x-ms-office365-filtering-correlation-id: 02d18e47-20a9-4c7f-0ada-08db97ffb788
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a56MJ4TTYklhFt94mq7n17jFyyUCAS5PUAgUYjl4WhZ1Oat6cCVUE3TX7o/xtL2UXOr5qjfmsSl4hj2eNgxh0GlRs9m5wG1Bige4P//slGm00j2tpuSZPALzAtWJdw292a7L5ykPU1eCj4sgT9dh/z3OzNpOnWbgNeFyNWIMjU04bMh7HtVAc16fQOlLjh8Dl5FUj3sGxLSKTSkxGkTCJlJ3yFamuSrkZ7aea5laN0zSw8cZempBnVoxpkziLbGbNwd4ZW3jFXmnZENauNsSOHgb3sxRz6Yn0sV9EN1vFWqEuX9+RPwCEU4Zt2wCzdLe7+wJHbG+X9pM1kww2ezWdu0rJmXCj+EKFIYYeq77Q4e5d7eLXSsN8AMXhjONC3cf7Ux+pBLSuY5WlQ/8XMchbK8THxg5Yk5eRtKKsJ4kqnMuUqqiTvOuVHJsmzFAik6zNId0LEtZMcgqVxneGMTvn65X1ZWhy2PZ9+uFpnW5U3hP9Wy6SwvlQqjeTyiWzBGK+PrBfb9ij+n0mL/x6xzm5T8RBW6OLR18ccb09ir8SPB5pz4KfxkPbqahKDORUVeBKiiz8ouqJeQKAP2JML4P+eXQAr8ZIIr0ZDbQETyDgtLqsqFr3lERjf+KcoWiEy9q4fWjrrjhD57v0AZxIramsw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(376002)(396003)(136003)(346002)(1800799003)(186006)(451199021)(122000001)(478600001)(45080400002)(921005)(83380400001)(66556008)(9686003)(966005)(53546011)(6506007)(55016003)(33656002)(64756008)(66476007)(41300700001)(76116006)(8676002)(316002)(8936002)(66946007)(66446008)(6636002)(2906002)(7696005)(71200400001)(110136005)(38100700002)(44832011)(52536014)(38070700005)(86362001)(5660300002)(7416002)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?H4jkCQcByrCdQtP++Qe4mMhyUiGBoOQ2DdIa8/Oh2H2SqV94bvbBSlX80cRC?=
 =?us-ascii?Q?D5FezZ6tn2k8MWIIJP52IF67CAvFsKNfKqBuSYHNUpIsFwiX92q84jFGQhqw?=
 =?us-ascii?Q?kX0TqilajoRB32WfnNvrjhu7FzU5CIxudQ287nv1/fJlzfxRRKxRcf+ZtvFr?=
 =?us-ascii?Q?/SVkQzsEQH1TtZ2vxdTo42/np0kJ8e05rHnzyrYYu5nF2ZYsQIh5eUDwu2Ps?=
 =?us-ascii?Q?yWjA7xLKkmZIYV8kY7p1h1ENiLaAbTddAc/HWXo0gGI6v4c5y0a57vz/sh7n?=
 =?us-ascii?Q?TxVlXqhjQPI+UmhBH3YU5SO2eTFAo6vlXGaxP6GwF+GU5bvj+NnUsVPxYKPZ?=
 =?us-ascii?Q?RPBCO7P/u1aXW9XUeovMbsHGYfYX2/oSpWqSrhizQg2fHN/SMwTui57u31Na?=
 =?us-ascii?Q?XNX1JbVpM/vjNay8DkmGvkjjHm+lh0uTOP80kTkip7+/aRPCzZtlaV0DHRer?=
 =?us-ascii?Q?KqmD56YLNNt8/XoqZB+J8dCujq1n1ICgReHvBRskHf9C8+gNvZSwAIYM5A8Q?=
 =?us-ascii?Q?paup72eTqsIgH+ZUDH2PpwtOAt3FXLCU9sa76Xjllp6PT1919d4zKR9ZFLpp?=
 =?us-ascii?Q?yZvTzh5j1jp8weVdlZ6geR60evqFtLl5ajByt9Wje8XQBBLSEW2gtjZxyWCT?=
 =?us-ascii?Q?y6iqwSt5mlrFBRLfz7XkCEicC40nPMJuFmuHxthUcikNuz1C2mxftuNvGKZz?=
 =?us-ascii?Q?0Qp60f7mbjR3S5QMNunHNri2+IjYy+b1+zR+LvBTL41zGbEAbfqODhRKbfCm?=
 =?us-ascii?Q?9Ad0DIvT6NOdzAQxiQAolan1mKGpJ/68ppWil+4O0YGyYj7h4/40t/4MhezA?=
 =?us-ascii?Q?bbRrTNJgcwwBMFFMCVUybks4rBg7zWwsxrtMeLLTR78ZHZNfaG4kewoDLz1a?=
 =?us-ascii?Q?qk1hJxmw/y326QkfA00rQtaO1H8XFe68bIl+f0n05LBujSlAXtl7wV+FD8iT?=
 =?us-ascii?Q?Ic8DjijHXNWblZwM654Q7gOlJlE/qUQOjaXwVcViNyNN1vDJS8nFu4aUObGM?=
 =?us-ascii?Q?61158Tq8UPelJWYU5/7SKCy6eiA5zK959E+3XDlSHN4bAi3Ul7iuk5zCo2T3?=
 =?us-ascii?Q?yvB01QK/8IfFMSERafXJcIO0aJZPPFuc8qTqJQQ8M57112kneXU50Uu1OC+g?=
 =?us-ascii?Q?q9DLrqoRKu2itfuDvka73K8FixIqc3cX2jMxDeQWj/wDjlHisjkydd6/F7Ou?=
 =?us-ascii?Q?BiZhcm9YrYVFd7Qb/0lGMW8KwxLfl8qFyQ+6v3M0FUWxgIEtnKH/ABj8SH0z?=
 =?us-ascii?Q?px+vdYkc56iXCm9+91FvfEV9XVezKAHw9GL+YU1B6wgSlJsE1JrGU1XO8dog?=
 =?us-ascii?Q?f6+BeardgIf9gbRj579TR5bVssGV/2Awjpkt/x4cjbVC/zMsjSb7rnxR3wgt?=
 =?us-ascii?Q?5ndjRdk+UrxO3SGASzpLVGJ1Oq5WsLCseqhpg7EUTeiHMyRkrpctWJN8xRdg?=
 =?us-ascii?Q?TVGTkOtc03x3Md8BM845zgB0AC4GQajQJPvlb6wzGxZTGqHeyFmfzWN094Oe?=
 =?us-ascii?Q?D02c9OPtrVn4eKEbCdntw0XIh6o4/BSQitm52+3w3Grh5Ddt94k0rSSSEw?=
 =?us-ascii?Q?=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02d18e47-20a9-4c7f-0ada-08db97ffb788
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2023 11:07:55.4399
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IRWR128qBvMYvzV5PjU7LhAqrVLz/0OhlyQhfzE8FFaL3Acb4GphEeebw+xhJeV9IIRrynwZ2jDKPxHbfv7EcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8804
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Sent: Thursday, July 13, 2023 12:08 AM
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
> Subject: [EXT] Re: [PATCH v4 2/7] arm64: dts: imx8ulp-evk: added nxp secu=
re
> enclave firmware
>
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>
>
> On 12/07/2023 14:12, Pankaj Gupta wrote:
> > Added support for NXP secure enclave called EdgeLock Enclave firmware
> > (se-fw) for imx8ulp-evk.
> >
> > Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
> > ---
> >  arch/arm64/boot/dts/freescale/imx8ulp.dtsi | 12 +++++++++++-
> >  1 file changed, 11 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
> > b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
> > index 3ddc0f3125b3..10ed31974a6f 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
> > @@ -114,7 +114,7 @@ sosc: clock-sosc {
> >               #clock-cells =3D <0>;
> >       };
> >
> > -     sram@2201f000 {
> > +     sram0: sram@2201f000 {
> >               compatible =3D "mmio-sram";
> >               reg =3D <0x0 0x2201f000 0x0 0x1000>;
> >
> > @@ -161,6 +161,16 @@ s4muap: mailbox@27020000 {
> >                       #mbox-cells =3D <2>;
> >               };
> >
> > +             ele_fw: se-fw {
> > +                     compatible =3D "fsl,imx-ele";
> > +                     mboxes =3D <&s4muap 0 0 &s4muap 1 0>;
> > +                     mbox-names =3D "tx", "rx";
> > +                     fsl,mu-did =3D <7>;
> > +                     fsl,mu-id =3D <2>;
> > +                     sram-pool =3D <&sram0>;
>
> It does not look like you tested the DTS against bindings. Please run `ma=
ke
> dtbs_check` (see Documentation/devicetree/bindings/writing-schema.rst or
> https://www.li/
> naro.org%2Fblog%2Ftips-and-tricks-for-validating-devicetree-sources-with-
> the-devicetree-
> schema%2F&data=3D05%7C01%7Cpankaj.gupta%40nxp.com%7Cd13d0b68d01c
> 4d10d8cb08db83070ed2%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%
> 7C0%7C638247838553225400%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC
> 4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7
> C%7C%7C&sdata=3DpO6dnz4aPqVejRNDR0OU4n04hXebyqgrNKg4DPhahI0%3D
> &reserved=3D0
> for instructions).

Tested. Before submitting the patch.
[Pankaj] Accepted.

>
> > +                     status =3D "okay";
>
> It's by default.
>
Will be removed from the V5.
> Best regards,
> Krzysztof

