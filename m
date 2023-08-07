Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66E6B7718AA
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 05:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbjHGDAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 23:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjHGDAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 23:00:39 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2044.outbound.protection.outlook.com [40.107.7.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD12CBA
        for <linux-kernel@vger.kernel.org>; Sun,  6 Aug 2023 20:00:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VOX3zs55hWBBtBR7d+OJZWS79e9yk7JWIMlVovBtLluLcYqiZmgmOgvklP+xVb0bubhaxcpL4Yy0B7zGdDKCmpFkC+3hSRzODgE2h+kSHhclASVJ9q1RNlLjRL6v9jrvXMCMo7C9cpkDM+LmR44td/ShSDLQ+RWZkNqdijhPitm3Cqcxc2EtfTuotCN0RjPXK96cTQ0jqPjBnhdgVE3UDXibx3r2SWT+yyYDzsSC0jFC0Mz2zZaeu6p3V5hIKd1tdQaIbT5rWfwoP+DrFJocDu+zXaQw4OT+PlvUaQZmEVuDhXkAcLZGkXyiQ/EuNmDdzjFJK0SxTK583AKSlv+hpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5nQtE8ZmusW5SxTB9ImgvBJcirHY46YydngnSe9QJsA=;
 b=MEy1EJVIMALPFzc0bBoTERrD3flAIRrZxdYCahqdbWJfZ/dSuZm39BDH90hGYqqNPkLcARbs904qjB9SVOllBz/xrM5r7os66Vt+ydtgTxB+OPSK6/qYincW3ISlmMTWM3Lc7bppfPj3KWrmsgkeDkjNY3yeVrPSen2uWohsF0Hxfn4JjHpH4GwWLxtaHL4sx5XMQwoEK/m2XNxk3umx3GkHO59dXKiVHIlcBse6vydjajqkwWAGZWRJWpzFspkLtj3u20U/KWxQm7IvZfvenHZpoRUK/2IhJV815WK50WwlpONDkqQIxSVmdeSUDbKfrRarvmC75iUEMHuYRODwrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5nQtE8ZmusW5SxTB9ImgvBJcirHY46YydngnSe9QJsA=;
 b=bVxCUxtP2S0cv3QA8TlTuHuQ7MUWhGI4ndh3/w6+aqbZL0jLcwoow3YS+xHj1j7b+UCN4Pq3FtuuxyGBVQpBnOmHHFrckv8CqZZCi7/k8iCvPd/zVdVeaL8HNOfdtmhLGJlYAGWMM1REdQkjWtKXsNyoD4gU37MLESyWLyZl6/E=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBAPR04MB7320.eurprd04.prod.outlook.com (2603:10a6:10:1a8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Mon, 7 Aug
 2023 03:00:34 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97%6]) with mapi id 15.20.6652.025; Mon, 7 Aug 2023
 03:00:34 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC:     "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "alexander.stein@ew.tq-group.com" <alexander.stein@ew.tq-group.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V5 3/9] firmware: imx: scu: drop return value check
Thread-Topic: [PATCH V5 3/9] firmware: imx: scu: drop return value check
Thread-Index: AQHZw41rkzUbA5QleEG97uUNAOTX7a/eKBwAgAAHAPA=
Date:   Mon, 7 Aug 2023 03:00:34 +0000
Message-ID: <DU0PR04MB9417EFE75CFAD955BE2A873C880CA@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20230731090449.2845997-1-peng.fan@oss.nxp.com>
 <20230731090449.2845997-4-peng.fan@oss.nxp.com>
 <20230807023354.GL151430@dragon>
In-Reply-To: <20230807023354.GL151430@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|DBAPR04MB7320:EE_
x-ms-office365-filtering-correlation-id: 3ff6b1b1-b6ee-49e1-f791-08db96f27809
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e8Y3DL+njpB7nK61lZso82nBQAGE19r6SZMSJReFyHdDDdHQO3RgYcbcK/9NZsqS/FCq96dj84CsjeGMv0ppWC3PYr5TOPM2DwSJu4j3hyFF7ngxWSHwGRWxDOPo4IcndGCF5Jkz/OA0j2kF/Ppe5mf3EPR0nuixankYVnJTE/NMaFBqBPWE0/SToASPnkwpdSmpriUMolVKHNlDrG0g3k9/yUt8HHwircgqxbw3DyxF47e1B9XAdYTMEMJ7qrbSjAHQUV22CBueRCoOgZFOFsCS+Lw/3hyylmVOOKvZWu1wcgaUg6TdlDK2DPo59UFGntjLWH9n4fO8v2zy0neKEKzKdS2VxbncEeyPTy89Q/hzenhaQ+uC98dUFvv2Z1LVSqVmxPhWlbM7Gd5ibTXUMgUr0Iz4PNZqV6A9M4poaZDYczks0diGbm4js1bojNCZcJBNZhe2iUdnSbyrXnqAc9jd2CVLvAF2JinTOx9RVdpGaFsy3k25DKkU6ywD32qNdmpmMDmi3hKLC72aTbR+Jm0FDi7Tnqq4uomO3EnNUAPVACCN+ID139GMgsBsG47jka59cq2qEMSdehTHmkcBHQd+45NJqEhI9u4GKazbDh8LrPSvMJIJMgacSKt4Fgn1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(346002)(136003)(396003)(366004)(186006)(1800799003)(451199021)(52536014)(38070700005)(41300700001)(26005)(2906002)(44832011)(5660300002)(83380400001)(8936002)(8676002)(55016003)(478600001)(122000001)(86362001)(316002)(33656002)(6506007)(7696005)(38100700002)(110136005)(54906003)(76116006)(64756008)(66446008)(66476007)(66556008)(71200400001)(66946007)(4326008)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?l4vieS5mPB2zzvXydr5RF/JuOKDBA+lkCqfSJTlC+F/ixSh/VxMr7xyBV8xs?=
 =?us-ascii?Q?kut3f7+wvtgSuKr8vlcVGwkWXYSdmbXZmGQG4wcy6sAisJLb8SyXtBAmDFxF?=
 =?us-ascii?Q?2aSoCCSGlsePpufw1+ikJ4mt43gBESY1k58dOmNkyMxa0j/PODVoABNxncTH?=
 =?us-ascii?Q?OHG30tRDQztCfJOP+8/B9+xX+xzDbYXwyjAUfG7NWIUSJYzM9gKBC4Pb2nc6?=
 =?us-ascii?Q?2083Os1/fz1OOijtU/A1ep92PSJPBj6ugC18zFFioQyfha8tSGLLYWOVMifG?=
 =?us-ascii?Q?d0iDCGrBCzuGa6N5Bme9dvqpw18opSHOLhgyler4RGvk6EM3iVMGVwKNgEk3?=
 =?us-ascii?Q?1haC2e7ORqrlj7QKQI3cuTvNxdMhh5qJbSnGLtRO8qzpJcxHw65cWGu5LmkH?=
 =?us-ascii?Q?uIutt5rkiaT2tPF9fZvv9tZ4qINRJYmw8U0+36xS68ssvm4W9/R6uXOdjnQs?=
 =?us-ascii?Q?8YpU88ry/2UoUQ3nvtHTHqWOY5PU4DgkJ1qEKvc10KTB1pyHqbopl1M7FGem?=
 =?us-ascii?Q?j860UV/jPCrfb/PiW5ywP6gTNUSYQLOy5c1HPEC4g2BqIfYSnnL+7G+Zzvzy?=
 =?us-ascii?Q?wlDejfmYALFYXA1+R/HPNEht6NybVwgg5jf6ZgUBhSAKoZe1qF6A4Yy6xIer?=
 =?us-ascii?Q?cYY0d3P2/LSK0y/SSNUkWXh+AN9TQiLhRN5rKciKwGNkVt09XoASpUBuUxgb?=
 =?us-ascii?Q?v76tmTP7qHjeu0Pnuai6TnXZUiHVmPjUg0Lmg1Qh/E0Id+ha2XoN/FTQayWw?=
 =?us-ascii?Q?s0vuwO9UzyJEYNEv5CW0QmUPpjvr8H8PwP0CDsBxzgzCyYlsYmqV0LsksLMp?=
 =?us-ascii?Q?h5MJf9fG6dy1s0p/ysMgrnx0ECWsjF/8kyPYKxsJ9WeStjCVr6yxH/EjZwgL?=
 =?us-ascii?Q?piThRaI5CRK6d+Xt2VRk3RrcyL3FFrX3XNnCNyBNZn7+G9En6rElRgxrGPtV?=
 =?us-ascii?Q?3uOPb6NluGO8NE6Fd6dxipH4HhXn2NrTP/vFOehCFYQqvIiswcJJKor8vf/T?=
 =?us-ascii?Q?IOx9ciVSHx9i9oOkB9NfV4Mgi7Wsbijunh4vfebbuRxT86a+cp8e4BFAInww?=
 =?us-ascii?Q?dF/y+YcFydjOhMFYxlkWik9Bbfqxm72Z3MOtpst+wT4viWRHePnvE1cvsU4n?=
 =?us-ascii?Q?F92w6XflDOglFqPQiUYtBmV9tHERoYWoIKpSrs5H/sODM/Rsl69K6SqQx0sa?=
 =?us-ascii?Q?b6phBem8+qfju2XtM57Bjet6Rpevu3RJFqmmcOJN8by0DlsxChwL7285V0Lv?=
 =?us-ascii?Q?F/h/iQN0WGwkh/og6U4VGNuljPMbeRc2z+ORsCRwuIW25pZTVrWFFRbXmrua?=
 =?us-ascii?Q?hJJC0wjWsmHarGJwJHBPx9BTZ2oLy9tmLhnYAIH1c/0RahSlvwXZBPRd5w4B?=
 =?us-ascii?Q?iLTUP8bX5jKraMNL29AcOiUToRLXP/1dIqjg2ScR/vtm4u0LLU1zVcXn79wb?=
 =?us-ascii?Q?V2TlHSpEDvbpA0hNQqqM1TzmmYwYCs1or7V/XaPyIdExyPzPJB24IgyjFOmf?=
 =?us-ascii?Q?IMAYRRps5xQUZ4A0Z8MTduBdjFvGXqHE2WeYblIX2GqVDWI/9FoGRcW5vVFf?=
 =?us-ascii?Q?crY3n12Z+/z9l6t0MHM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ff6b1b1-b6ee-49e1-f791-08db96f27809
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2023 03:00:34.2657
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vdAys+oKa2dY4tWjjESfos2BZC+r2iE5YX0RUELQLcDW32Asx0aR19imyP/Pyr0cIQnHijCHDsxEG5ndx+/kQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7320
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shawn,

> Subject: Re: [PATCH V5 3/9] firmware: imx: scu: drop return value check
>=20
> On Mon, Jul 31, 2023 at 05:04:43PM +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > For IMX_SC_MISC_FUNC_UNIQUE_ID, the scfw has a return value, and the
> > imx-scu always return 0. So drop the return value check.
>=20
> imx_scu_call_rpc() could fail for a few reason.  Are we not want to check
> those possible failures?

Yes, I overlooked this, drop this patch.

Thanks,
Peng.

>=20
> Shawn
>=20
> >
> > BTW, also initialize msg to 0.
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  drivers/firmware/imx/imx-scu-soc.c | 9 ++-------
> >  1 file changed, 2 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/firmware/imx/imx-scu-soc.c
> > b/drivers/firmware/imx/imx-scu-soc.c
> > index 2f32353de2c9..ef9103987e76 100644
> > --- a/drivers/firmware/imx/imx-scu-soc.c
> > +++ b/drivers/firmware/imx/imx-scu-soc.c
> > @@ -33,20 +33,15 @@ struct imx_sc_msg_misc_get_soc_uid {
> >
> >  static int imx_scu_soc_uid(u64 *soc_uid)  {
> > -	struct imx_sc_msg_misc_get_soc_uid msg;
> > +	struct imx_sc_msg_misc_get_soc_uid msg =3D { 0 };
> >  	struct imx_sc_rpc_msg *hdr =3D &msg.hdr;
> > -	int ret;
> >
> >  	hdr->ver =3D IMX_SC_RPC_VERSION;
> >  	hdr->svc =3D IMX_SC_RPC_SVC_MISC;
> >  	hdr->func =3D IMX_SC_MISC_FUNC_UNIQUE_ID;
> >  	hdr->size =3D 1;
> >
> > -	ret =3D imx_scu_call_rpc(imx_sc_soc_ipc_handle, &msg, true);
> > -	if (ret) {
> > -		pr_err("%s: get soc uid failed, ret %d\n", __func__, ret);
> > -		return ret;
> > -	}
> > +	imx_scu_call_rpc(imx_sc_soc_ipc_handle, &msg, true);
> >
> >  	*soc_uid =3D msg.uid_high;
> >  	*soc_uid <<=3D 32;
> > --
> > 2.37.1
> >
