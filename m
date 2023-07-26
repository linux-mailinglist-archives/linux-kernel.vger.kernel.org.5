Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF037627B4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 02:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbjGZAVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 20:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjGZAVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 20:21:13 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2082.outbound.protection.outlook.com [40.107.20.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E6FDB6;
        Tue, 25 Jul 2023 17:21:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JNYkFW13z+1sSNKj3DX6MyfpOrLOD470VgGPUUcsXRZWakNN9WD9bMrIYr/drvCppht01DQ7OWl2Qrd3GcsIEFT90gO08rYLBX2kpRID4+yJb7qRAyFbfISkTrjwEpW5XMsY5youQNiGD8zxKD4DOhq7usIgzzXHitxw/BQ6SnGbQ0rjr1Eo0jT1QJxKfPsBvxi2J1kqQ2smX+ahx08kcM/Tt7MpgSzShrZ9w3Rwb5bGtDDNKld8LsYd+1uaRo4SAvQkBbRmE3kDWqY5pNBtB+dhe1YJploY3eYRfXKUzx6/8AsC6iL5hJGEct9KWimO0S6a+f/0PbQdMtFj/Ach+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dxXCamVjdwu25b3It1lwKKQDO21J11jt91gklcLKPx8=;
 b=fwQmcNOIfNqQIpIEIa8DaJYZkt6amkr4rqpr85cJWdfqLhjg6j2l0Rok7csGSuiYpbskOG6/lEiTnQ8jr326VLuhiz51WUsJ1OgwS9jldUauCyHlHcZlW8id78pJiksJzGjAgLrPPooGZPetXBqIprWeZTucKXwUXp7pUHms5g9uy7oMrvpoXbcPy6FxdXalZCAqbMgoKwmgnJlksTzfve5kDHmrvhYvso52StY1XMkLLRS0QUwE32XYzl1ICdTuunJSvqHF+hSRWU97YkCAFQ+OjihOJ02M/8Ro4l9QyCx68yPj8KhlvOC2fLESVU+l+ppNPf81lBKV8AZLaTPVAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dxXCamVjdwu25b3It1lwKKQDO21J11jt91gklcLKPx8=;
 b=Sbmmn97D8r1pbyJRKzZ3nPI5YSOaRl0ns078raS/Qo+W5AhKAXajnCLpD0efgx7pHz6bnyJazlIcUOXC6cdYOsBgKUiS0f4zCEYuouhehgW6nVw2Mfjjt/nqXhjJ3L+9+2gFDyw7znUOOOmSbg9tZjhNOXDxBKgBe5Ddfu6qAoo=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PR3PR04MB7388.eurprd04.prod.outlook.com (2603:10a6:102:84::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Wed, 26 Jul
 2023 00:21:10 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97%6]) with mapi id 15.20.6609.032; Wed, 26 Jul 2023
 00:21:10 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Conor Dooley <conor@kernel.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: RE: [PATCH] dt-bindings: power: fsl,scu-pd: separate out fsl,scu-pd
Thread-Topic: [PATCH] dt-bindings: power: fsl,scu-pd: separate out fsl,scu-pd
Thread-Index: AQHZvuIo+RWSoLABrUiHrp6dtY69Sa/K0C+AgABgB2A=
Date:   Wed, 26 Jul 2023 00:21:10 +0000
Message-ID: <DU0PR04MB94171BDFA6FF61A644138F688800A@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20230725102900.225262-1-peng.fan@oss.nxp.com>
 <20230725-excretory-speed-003064040657@spud>
In-Reply-To: <20230725-excretory-speed-003064040657@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|PR3PR04MB7388:EE_
x-ms-office365-filtering-correlation-id: 0af12edd-7e7b-49b0-de9f-08db8d6e366a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3PH+avHIBmjATrvd0MrFnZuEjYJvzpRXFMzRXixLvwTElx6lZrO7as0YxxgyZ92NTW1gljOGj090QnRg5VDdAFWhODsLHHZGWXr8Hx5133vbEpdid+uf01MPYDUTUo/+EJFhAUnQsZke6isA8IK6/rgYsW+TFhqJTzhONrWzweg2DA2ebGHKqALzUjnFyuWBMWLwDGOtoO8OG5zCUtXukyrvJ0DG/Xo/0/1ljUddsKoVrFEobLLJHO5soD3xaSH9FLRec6EdjLNRiQzXV3O0qREnPLOmoxkKDwWbnAx+CTYU+Z/QEJdrWangvhggEbL+ajlAL36GClCs+FqEBzw9pZ10XBnBeL8RcZWb1NJu1HdLd3knXpN+ug+I/K5m4tuE3oBXMRGbt5aRyAhJ4nrZfZPc8h0heX/bYEXUf0sDApvcuzmPXqRKW3BX5JpzntOJ8Qui7sNjCGRMy0wh9nwI0wGUl9Hw86aaUHeMRRlxG6i7A9p3EfKHo069CrvFys0E87DpEjeSZyrw0gKUgvDLGEv5IgwcT29O9hov6iPwPq7k4VGxBcV5p2SF7rTqb+VEiX+ecnvI+27yTCwELgCzxp+M5cG1h4Q3p2RVnTErZ0xIFy8xnN/4+Kc+YcitH0+8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(376002)(346002)(366004)(39860400002)(451199021)(2906002)(54906003)(66556008)(66476007)(64756008)(66446008)(76116006)(66946007)(33656002)(83380400001)(38070700005)(86362001)(55016003)(38100700002)(122000001)(110136005)(7696005)(186003)(6506007)(9686003)(478600001)(71200400001)(26005)(41300700001)(5660300002)(316002)(4326008)(52536014)(44832011)(8936002)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?N2z6IekH9zkIf6HzJKXKKQYv+BrWhZO79ZssRyN1m3WZ6mOz33p3hCjImHep?=
 =?us-ascii?Q?q8n7zlUYr+3WZM1zYvADI2MwRANySPKMDBk40oa7pid+vWACDU6fl67sJdhb?=
 =?us-ascii?Q?xpvHS4963kFfzElbrco9ByqS+T/yKTV/Bi30kbf/7gaALJUfOIBjWDOwCSeH?=
 =?us-ascii?Q?GOgaiibdWxqCiD121TYl3hfxNs5QkQ17RShSmgo45hxfDKl7VrDAxuOQtM5r?=
 =?us-ascii?Q?CgxNA2JR62Y8SF8GY11R1Ce1EfWb8boywdgFWSV/I/+vXVEvrDMTb70edzu7?=
 =?us-ascii?Q?Pw6qJsSAg3TnjxGC8Jiok3MWmPwR2IkEi0X3tVUvshxzTFj7vzVavHRzC+hm?=
 =?us-ascii?Q?rDLhqMkPd57lhNQGGr1yzN+zssVuswr2fVJWa2SC4U1s0lUNIU+UhvEG+5B8?=
 =?us-ascii?Q?umDpSlDHnEdvASnFkM2Uds3fNn/s55XQBr7pBRTF028cjRcSH0GEwIVWYODp?=
 =?us-ascii?Q?xQKBdRY9NvkJ60vrIqO8ImHTrRaJLMxf76eF7anckBQ0P948h7HhOBzs2Izh?=
 =?us-ascii?Q?DIOsruKvexkYO2cFF73AEHWl+A729uLB6BoPjetzWmL9D8PP2cNAmt68BxPZ?=
 =?us-ascii?Q?BMLlVSoqb6hI7GoEcTsE/eB49ZMPtjoafkI+xPTtQmvcS6vLGSoCpJKONmhz?=
 =?us-ascii?Q?Yglt4SMk0JBcl/gKkFfZTIaVDZMQneNU3V3dEo5SV+GKVdhg9iLHsll9DFUM?=
 =?us-ascii?Q?tWsmPY4qeiPWBhGsKUfrv9y8ZyFzC4umVDBYeJnXpHT4/ox2WYExIhFu84D/?=
 =?us-ascii?Q?TokScl6caiCUvMkCocfpDo48ip/DMqtn+aMP0i/sK2vA5rJ7FA8ucMEkiOl3?=
 =?us-ascii?Q?hO21999zRMdfwkegvAWpRHnBOXtFW7m67H9oVZUzmAxNYvzOV5DK9imGmuVG?=
 =?us-ascii?Q?roG3xLZnNU8zTF7DVu883NU6RWMTdQ7BtILeowIKOX041PLEufWriJG+d8XO?=
 =?us-ascii?Q?Zum3zyoLFbHkJYix5RM2dkuINwdUIpg+79MJw+XcXeI0ggeoeQtMS7Qw1MdA?=
 =?us-ascii?Q?aaeAiZnstAhiQQ3npaArZgLONiL2rj6VZWDKPhdvs0Ucfn8i8asc/fVaPP8B?=
 =?us-ascii?Q?9CfzKzewENiipaRBAVCmEVLEBiqrxpOvhWaMDY+6+VrMj1SUIXiP2wEjXaSD?=
 =?us-ascii?Q?02S+JEEGrMxaurCCJdoH3rXD9f4WQlUTSxsG8fFOHsJ7ALgeO9QcYiw+uq2v?=
 =?us-ascii?Q?sTThIAFRNY8oiv8ydxBEto9Q67JFcjDqvGRgFH8BOgrjol+AM3wpX8P0/ffO?=
 =?us-ascii?Q?EaO5hDajID4Bpp+qj5MbeHIyeClqKzpd2nhrlndpIQ2T3CFGL3e9LaqKwWA9?=
 =?us-ascii?Q?rPzydqMBP1EzoQIUQ5PgAucyhbRnZUh/hitQaAhKmMTiiiELM04C9qD/3IGM?=
 =?us-ascii?Q?+/e5mR3z0QayW9ip3kiN8Oqr+jxnTKA1rgwjs9w7xsCQShJAAbb9ROqykOI6?=
 =?us-ascii?Q?3r5B6Qc5GeEtJ2mCqZCP/5J4BGIDwbdYjSCrHnBgWhy6dT8MOdR/YAFF69Af?=
 =?us-ascii?Q?MtBV4GgcGXico2s0Jnm2nfIOKMkvLe+JFbYqlWvzV97pUettCfVBEx09xmK1?=
 =?us-ascii?Q?rRljvTrYzjIA38iIlc4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0af12edd-7e7b-49b0-de9f-08db8d6e366a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2023 00:21:10.1459
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eqzqQnsKWDzovRTqDQ4dvfIAex2vJWU9LpKyGeEknnkQsmdOZardYzQBfVlmHH1FC1dH/vDNq5eBq+c/UZS3zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7388
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH] dt-bindings: power: fsl,scu-pd: separate out fsl,scu=
-pd
>=20
> On Tue, Jul 25, 2023 at 06:29:00PM +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > Add an entry dedicated for fsl,scu-pd which could serve i.MX8DXL
>=20
> Why not just add a soc-specific compatible for the i.MX8DXL?
> The current form of this does not look right to me.

I could add one dedicated for i.MX8DXL.

Thanks,
Peng.

>=20
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  .../devicetree/bindings/power/fsl,scu-pd.yaml         | 11 +++++++----
> >  1 file changed, 7 insertions(+), 4 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/power/fsl,scu-pd.yaml
> b/Documentation/devicetree/bindings/power/fsl,scu-pd.yaml
> > index 407b7cfec783..3a92e4fef7ae 100644
> > --- a/Documentation/devicetree/bindings/power/fsl,scu-pd.yaml
> > +++ b/Documentation/devicetree/bindings/power/fsl,scu-pd.yaml
> > @@ -18,11 +18,14 @@ allOf:
> >
> >  properties:
> >    compatible:
> > -    items:
> > +    oneOf:
> >        - enum:
> > -          - fsl,imx8qm-scu-pd
> > -          - fsl,imx8qxp-scu-pd
> > -      - const: fsl,scu-pd
> > +          - fsl,scu-pd
> > +      - items:
> > +          - enum:
> > +              - fsl,imx8qm-scu-pd
> > +              - fsl,imx8qxp-scu-pd
> > +          - const: fsl,scu-pd
> >
> >    '#power-domain-cells':
> >      const: 1
> > --
> > 2.37.1
> >
