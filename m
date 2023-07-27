Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1DB764FCC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 11:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234346AbjG0JaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 05:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234335AbjG0J3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 05:29:54 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2075.outbound.protection.outlook.com [40.107.20.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC9C4C3;
        Thu, 27 Jul 2023 02:20:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l4t59smy9dabuDhHA+COr6zbfSLfXbIcQdj1JHZSbfA9HI9fbu243H3SEubh9HNttt8x8wAG7YGJLvI/NS8Isgj5OEY/nDKpoRZg2mxmLW8MGDtVW4LVchLyWHX4ovYPfqUy0cfIMDGC/nkBfm0n/6VVyA/EZC+Cse9OjqFPHGTqgbD2LH3yg0V2icp/Spia8gg0AEi3OlrkiS6F1B4p8IFPgfBP1jtk0FTM0krv3pPf/D0+l4pDWncOYsMb3/NLgUKzQSIk2uP1/pLV327O1YEv0o85clk6rueRlPPV6yi6zG2HlvDjfQPo61DFt6RRF0xdWPbq2IT9i35P2G1ZjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GkSsyUVTkuMebRtBJJmJrIpEo3gWmd4Fr4f8iR4OEh8=;
 b=OnaMyZxX6X7y49or0JMBw4oGFC5pDXEoQ9DF6v/oC2LOqGTolLVHN9cT34dEp327bu/Q9Gj0uDeBIr0bVwtg6XX/Y9UIPejdukTx8h6aY4yvDAfuig0Ppjj2PXjGCw6MHYF+i0hvrn+M/Jxpnqu5bB8JNo2X5wTvoR0qbRG7WPYsQ7MQaHq3K5SpN9uXnO8ML8dqqVNgc9TYnCxTdvmGhr2oxufu2zzedSzT7MTyKYVEn12tlKvs1Az0lnmu7BX5Llq0iJmV9IL2BlPe/MkcLm23wh5sULEDfB8idnunkWWXrF1zC96JQ2yg0spZXJ4kpdEHyKMLaLNAy+FvGO5YTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GkSsyUVTkuMebRtBJJmJrIpEo3gWmd4Fr4f8iR4OEh8=;
 b=c+ENul1X/YWCcwqmX+w85sA7nUWg21BSGdcwF9O02jDqHCiRpoflUJLnY7XAq3kCHjweIzUO3XHt2mEjSNdP4DOHTMO58QBcOcOgA/Yj4DKIEXaHjCEFiMnoByigNZBs9T+cNSmy7k+PnQJz87vqLF/e/gnA5usxRSeHaAP844M=
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
 by AM8PR04MB7810.eurprd04.prod.outlook.com (2603:10a6:20b:237::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 09:20:27 +0000
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::175:d311:2cb4:7915]) by DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::175:d311:2cb4:7915%7]) with mapi id 15.20.6609.032; Thu, 27 Jul 2023
 09:20:27 +0000
From:   Pankaj Gupta <pankaj.gupta@nxp.com>
To:     Conor Dooley <conor.dooley@microchip.com>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Conor Dooley <conor@kernel.org>,
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
Thread-Index: AQHZtLo09zXvz2nwA0eXBXtTWXN23a+2c2IAgAACQoCAEfalcIAAH9IAgAAAzEA=
Date:   Thu, 27 Jul 2023 09:20:27 +0000
Message-ID: <DU2PR04MB8630B7EF372E4B09E27666BC9501A@DU2PR04MB8630.eurprd04.prod.outlook.com>
References: <20230712121219.2654234-1-pankaj.gupta@nxp.com>
 <20230712121219.2654234-2-pankaj.gupta@nxp.com>
 <20230712-step-dimple-31746cd3a640@spud>
 <6e13acf6-3e23-f9bf-5c3f-368e79802a8d@linaro.org>
 <DU2PR04MB86307308661039043F9FF1C79502A@DU2PR04MB8630.eurprd04.prod.outlook.com>
 <20230724-grunge-flyover-b0720cf28082@wendy>
In-Reply-To: <20230724-grunge-flyover-b0720cf28082@wendy>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8630:EE_|AM8PR04MB7810:EE_
x-ms-office365-filtering-correlation-id: 58172172-1db2-47a1-7564-08db8e82b717
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b68D9J/eZajAeYNs+JXX7580uJJFQmywzsk+Id02KqbaW8M+REb+P7Ru79jY7Tg8dbHblw1G3gx/8+ROfUc2nZWVpYTM/3HhMoggD113XMPOx+1UvdGEEOvbPnOV1pA2+gpjilNnJ+pdvBJW46/PoiQSh7SywPMWWRgWOoGYvzwvbi8HI8Crk0Cus7W7ehOgyTT3V6PN9r9r3fPL+h/WreYi+ePZQHyB90FPdDqJlnM+FyofnW1lYVvorQIE6TLrekLp6aCUbYEcHRobgNwRFu6/rNhRERdC8rtvm2AVTSvCJEldeS+ZWlxVF7Csjm57lqnMjfU5C4a6N6LIJSL1D7R3fVgO+N9QwttsnXtsH7qSdgifxu7hYEdh4aVHu5HIdwinDJ5btL3c59+y6IDPrHFNk2kmeHL98uuWKbwOMEhzVzsJOOlBn5iT9YcUbSvv1zeCeF5BAguPt1E87+X8cPB038xmbJaUBImLzfgRkCPB5Kmw7dEP3mj04IY7FZpMuzlBIEj42P6PBG+kQLwcws4HZbY/e9D+H6wjHUrBQbpWu81Aor4fXNBdq5TsSiOw0HTew7cKJJsX+G3fmxiNr0nQGNGNUkaxYqMhRbTfbUdVt4eBtVSASGPcfmsZOxob
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(366004)(396003)(376002)(39860400002)(451199021)(83380400001)(478600001)(54906003)(5660300002)(8676002)(52536014)(8936002)(44832011)(7416002)(33656002)(55016003)(2906002)(41300700001)(6506007)(6916009)(38070700005)(64756008)(66476007)(76116006)(71200400001)(86362001)(66946007)(38100700002)(122000001)(66446008)(66556008)(316002)(4326008)(7696005)(53546011)(26005)(186003)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LHRbbiGfRC1iB451Q8siRJicCqh+OHof0dxPQ/rtv+xm6U0qTSimQEZUvOaO?=
 =?us-ascii?Q?56eqjVZa8m9NzZifSo3Vnqdr68G/i0FDruy6IDBLLVUjtmb2Vu4A7y5ZC/sY?=
 =?us-ascii?Q?tSxHxrDpnTu0u9UZmKn1mEy0bu5YnBREcLjHAgfphQhOWr9gJyMqDDspjpMF?=
 =?us-ascii?Q?tz+IgUFTWog0o+r6izXYBAykSz9sPnZVfHdc9prETytVu6ae+Fxcd3yDtp2H?=
 =?us-ascii?Q?AoUmlkpkSvQ0nrbX/OcMuQAaf4QARgfgc9hECiFAXsR8fVfu3jzIff+NwrJS?=
 =?us-ascii?Q?DFB14tYzaw2Iq7m+yWJl2++AlsJaUhPUTLno+lwdks7IBRDeANmBk+4VvBaL?=
 =?us-ascii?Q?m6MGmlcI5IV9nrhRnhIL71C730OlzCYGqCCfL2+hTSj0rTa03y8CAaD690y8?=
 =?us-ascii?Q?fqkzsCO7pLFiNXqzSntvsIp0QgHS6lymbcb25XnK7wG7aTZ4IW6XAaK5psvL?=
 =?us-ascii?Q?2pMLCd9LY8qC+SwWGFfSJ1VYmQCMy2Ek8xKY/J9U7W7PxGFay/NrP3WxedHw?=
 =?us-ascii?Q?6up8QAk08z3ybbbArt99Hn78wjqOLHGr11rEbuMmlxZMYho2Bg0tB8rVI3t4?=
 =?us-ascii?Q?oybghRHsFe5qTjtFwV04xX0sithwzJKJIjiBbEj/xiBGJ5OZ7ZNKRx7sTTA5?=
 =?us-ascii?Q?y18GfxH0FIACzbJFzV/WZIgsH4gOurz1S7JUt9qobhHJkfOEYSoSYoaHjCBL?=
 =?us-ascii?Q?IJgxKj0apAneQkOP7Xi3snRISc5e6oSSVfgDxasVAp+ahKXqcOel3dh32fKO?=
 =?us-ascii?Q?WWOS2slp55rbqqbeM2Or+Gq//+AXaBwlAehZlwgTPrNK2iYAi4TDBFcXggFi?=
 =?us-ascii?Q?c1Ru2I7GyxfnfbF23pR+JwKmrLbbK+W1xOBLOTF2aOH3FHb6XX8Wf00Etjcx?=
 =?us-ascii?Q?r7CtoOQUJLDa0rAtuFm1987Ma6CrZPvo/i966zliTb7J9D09gZlT6NHwVjUp?=
 =?us-ascii?Q?2Y29kKuyKmPTjhRY/ZYvuxpjiTajgeXV3VcSXvQ5o2ySwK8nohshKxJ2akum?=
 =?us-ascii?Q?UoLG2mjq3YjXbf173D7Y9z5HMao9G6RxqxZFgPKqGFWC3s+fbFUXdG7d+PGe?=
 =?us-ascii?Q?mHoXfU/PS1epg0Po9Jfg4mfOT+0rbLArtZN9pyStOwl60QC8vmtgfYeMU77T?=
 =?us-ascii?Q?akJOshn4G7dV6RCWMFFa+4LVeVqSzL2jn1e+aSqgehC7GSoOxbRXKalmmoaa?=
 =?us-ascii?Q?UBETCW1vXtjPQXo0h4lDzk6xdqweF/I02oGSPHlLieIHA4BdhfyHpQ6Zw/zb?=
 =?us-ascii?Q?yDsjPzY9kijuK+j0QoEQAeMGOVQL3abfDyqhkoJ8+HpMeqrQL9b6LlXZOtZM?=
 =?us-ascii?Q?5caiycP5w3HNwz6shcRjh4r9nKTtkqdBcNXbehsHDpjRs0EZN6/wwnwcg4Rp?=
 =?us-ascii?Q?Eyuzyk9GRNtJeaQ7rb8TaIQGvKnHhr4qpP1n+q2v7a6RMn5TXEg9cj9AXyvk?=
 =?us-ascii?Q?zzDFLN1mkfWvLhpUy34x3T7y2FofMyGmBdy+NfLEAES58nngWPTFCLdHuUDu?=
 =?us-ascii?Q?tN6sAlSmRrMFeMHjoVGrYFDDvCCHnx1V/+EXuCIUv2ZzG0Xo6x9qY5j+GLNV?=
 =?us-ascii?Q?rbj7Ea4U/ZOgaRtXLRI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58172172-1db2-47a1-7564-08db8e82b717
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2023 09:20:27.1552
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LBVCkfPirHogt4bpUKzTEt/eTKL2gTxfL4Ckd2XGwTfS4/MGkQusC+xc16Fpr2pEs7bHQ/5aoOEQ8dgYWaEogg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7810
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
> From: Conor Dooley <conor.dooley@microchip.com>
> Sent: Monday, July 24, 2023 12:18 PM
> To: Pankaj Gupta <pankaj.gupta@nxp.com>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>; Conor Dooley
> <conor@kernel.org>; shawnguo@kernel.org; s.hauer@pengutronix.de;
> kernel@pengutronix.de; clin@suse.com; conor+dt@kernel.org;
> pierre.gondois@arm.com; Jacky Bai <ping.bai@nxp.com>; Clark Wang
> <xiaoning.wang@nxp.com>; Wei Fang <wei.fang@nxp.com>; Peng Fan
> <peng.fan@nxp.com>; Bough Chen <haibo.chen@nxp.com>;
> festevam@gmail.com; dl-linux-imx <linux-imx@nxp.com>;
> davem@davemloft.net; robh+dt@kernel.org;
> krzysztof.kozlowski+dt@linaro.org; linux-arm-kernel@lists.infradead.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; Gaurav Jain
> <gaurav.jain@nxp.com>; alexander.stein@ew.tq-group.com; Sahil Malhotra
> <sahil.malhotra@nxp.com>; Aisheng Dong <aisheng.dong@nxp.com>; Varun
> Sethi <V.Sethi@nxp.com>
> Subject: Re: [EXT] Re: [PATCH v4 1/7] dt-bindings: arm: fsl: add se-fw bi=
nding
> doc
>=20
> On Mon, Jul 24, 2023 at 06:37:22AM +0000, Pankaj Gupta wrote:
> > > From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> On
> > > 12/07/2023 20:26, Conor Dooley wrote:
> > > > On Wed, Jul 12, 2023 at 05:42:13PM +0530, Pankaj Gupta wrote:
>=20
> > > >> +  value, i.e., supported SoC(s) are imx8ulp, imx93.
>=20
> > > >> +
> > > >> +properties:
> > > >> +  compatible:
> > > >> +    enum:
> > > >> +      - fsl,imx-ele
> > > >
> > > > This looks like a generic compatible, not a specific one, but you
> > > > use it on the imx8ulp. I would have expected that you would have
> > > > something like "fsl,imx8ulp-ele" for that.
> > >
> > > Yeah, this one looks generic, so not what we expect.
> >
> > This change left un-changed in V4. It is "fsl,se-fw", instead of "fsl,i=
mx8ulp-
> ele".
> > I will change in V5.

>=20
> That's a generic compatible too, so no different to "fsl,imx-ele".
> What is the reason for avoiding the SoC-specific "fsl,imx8ulp-ele"?

Sorry. I missed this point.
Not trying to avoid the SoC specific compatible. I will add the soc id to m=
ake the compatible =3D "fsl,se-8ulpfw", instead of "fsl,se-fw".

Thanks for pointing out here.

>=20
> > > >> +      - fsl,imx93-ele

