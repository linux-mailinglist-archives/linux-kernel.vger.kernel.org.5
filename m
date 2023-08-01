Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE5676C0C8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 01:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbjHAXVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 19:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbjHAXVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 19:21:32 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2066.outbound.protection.outlook.com [40.107.105.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06DD4212C;
        Tue,  1 Aug 2023 16:21:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q0ijentL0TuC/4+7gBqamd2Vteqk3jzXibzOa1Lul/fFOjjf8aeK2DuSq1AKtzzbTFlv6NEMfVAEOBbSn2Sz65Bkc9Y2OVEVabFydeGcS7SlG4RAC8AwBlwehgKJgxrayDeLYb04PX675dXvhVxVmO1WwRMISBq1uR1DvxBlYXuqgjoNo1KJfq+4gbiFz/4n7O4UmFEVpLKxOOHjJ3fJbLtzRKzd5ypGvWETlDazpUyUE3o+bczKJ7CsSreb+A+eO6cIkng0ukdmg0L0tjNhBB5zlI7Tk5oBWm+IGAod/ADWMhHD2XpY6ZKGvpzqqETyO7mHyxMhQfg/nPEKN431JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DdMbuOVPfc8BK1LppT/mhraduXRrGEr7HP6U1FFj1T8=;
 b=IZUch03gdNJd3E5u8DmHrbypt0mgyfreycET9zk92CN7WtcCvDVwQuVNIeU2eZ2lPusnmwhDHam/O5T9av7fINWLO5SA6xPmz48VPfRwDKuGSgapTobzrN2eLyCDgw/WqDi4AxkAKRTRWWKee1PtJuaMjpZE0KkOe47JQ2emMhNwTUJXD9Cb/XMSWDGevAGOEyVlCusoIB4JvDnqI6bvM3wd6Yoh1wIIZxMX+h3J3j5ALGLTsANTAQxbX2qIYpxbOXsDf4uk2+/UP18aywDG30RW0LGK8lhYgPmX1h5gwtF633jwzbWFfhWr4PAH1SByEvHh/tNNu3CQVZs4KULAyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DdMbuOVPfc8BK1LppT/mhraduXRrGEr7HP6U1FFj1T8=;
 b=QHR0e3ugYCpeTaFmV5D6Rxzjs5CdfOJQhYglsIGAOpXyxCENHLG7DGiosRZASGlgi5nN/qSARpXH1ajH//0BcXPR9JAp1yPe6MsQ8bySkkDl0w+wIySCZVBLo0rPV/2gpDZ/w7sGaRBQGam0O8dmUCIi1Fup2bXpVtPMkRE1CUk=
Received: from AS1PR04MB9358.eurprd04.prod.outlook.com (2603:10a6:20b:4dc::19)
 by PAXPR04MB9490.eurprd04.prod.outlook.com (2603:10a6:102:2c2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44; Tue, 1 Aug
 2023 23:21:28 +0000
Received: from AS1PR04MB9358.eurprd04.prod.outlook.com
 ([fe80::4381:3512:5b7b:6bf]) by AS1PR04MB9358.eurprd04.prod.outlook.com
 ([fe80::4381:3512:5b7b:6bf%7]) with mapi id 15.20.6631.045; Tue, 1 Aug 2023
 23:21:27 +0000
From:   Vabhav Sharma <vabhav.sharma@nxp.com>
To:     Rob Herring <robh@kernel.org>
CC:     Horia Geanta <horia.geanta@nxp.com>,
        Gaurav Jain <gaurav.jain@nxp.com>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Silvano Di Ninno <silvano.dininno@nxp.com>,
        Varun Sethi <V.Sethi@nxp.com>
Subject: RE: [EXT] Re: [PATCH 1/3] dt-bindings: crypto: fsl: add entropy delay
 property
Thread-Topic: [EXT] Re: [PATCH 1/3] dt-bindings: crypto: fsl: add entropy
 delay property
Thread-Index: AQHYdFB1/6ZPLK3UVkiqfeFtvvLa6a1BW74AgBELlRCAFK2ygIJxmDvQ
Date:   Tue, 1 Aug 2023 23:21:27 +0000
Message-ID: <AS1PR04MB93588FD670415DF85B1A2F6AF30AA@AS1PR04MB9358.eurprd04.prod.outlook.com>
References: <20220530180924.1792399-1-vabhav.sharma@nxp.com>
 <20220530180924.1792399-2-vabhav.sharma@nxp.com>
 <20220605212114.GA3528129-robh@kernel.org>
 <AS1PR04MB9358BCBEBDC7EBAC6E5DD6A9F3AC9@AS1PR04MB9358.eurprd04.prod.outlook.com>
 <20220629212559.GA843061-robh@kernel.org>
In-Reply-To: <20220629212559.GA843061-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS1PR04MB9358:EE_|PAXPR04MB9490:EE_
x-ms-office365-filtering-correlation-id: 8d4cbd66-0efb-4136-e71b-08db92e607fe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wyTIMEQh+qXNNXQcfWU99hp+pgxvv1LjM8suhHlFQHB9f7CZvLznSDzXM7l/drSLhHACI3I6bxXWNPRfoDjfmnQiwVlePn1RDoiK8gOJbj1oPumknVIrQoyvhFHaPq3UIKCrPhw63iQGfJZ3u//oUNMa3JNjlgOyBIzXwJub1R3WBej6PQPphjF6Nao3B2ccMyBBRLdvNJ+V+CT2SITVZDNXc4WRFZjPSZa2FYfPBGV38541mE15KEXX40ICOzqcKzQ7Cod1/jZJ6+zadBuij8dyFWfestLMBgrFy6edMS9dBIcnQjKeb7mly7kdpVNCqYlxzvF286vVsm+tIVc+g35keur3CAL2+wUKWMQtE3HB+5ZpfdpLEaqRYcoLts9Y2UprWXvuvaRwnpd9c4NJj2Q63LcbEQaHf3iTPurQtTx7gX7e4HT8xCPMmZoDB+BKwlPQL+VptuXy1jqWs8rptEPdEC13tijc5KksMAUHjdrJOKeKBQHuqaUgwvJldWifel53vw5oWqKw5VsFdT98yfKbl8FkchKLlMKDUJaEbopJvDqAcfKN1YBGqIi3YH9p6Zwp5swMlxEzBifGiYaFKmS39o97S/icjcjMDFRTgJA4hDum7mH0pYvPp5cmg5pF
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR04MB9358.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(366004)(136003)(346002)(39860400002)(451199021)(33656002)(38100700002)(6506007)(5660300002)(76116006)(53546011)(6916009)(4326008)(55016003)(66446008)(64756008)(71200400001)(66476007)(66946007)(66556008)(54906003)(9686003)(122000001)(52536014)(478600001)(2906002)(8936002)(8676002)(38070700005)(41300700001)(7696005)(186003)(316002)(86362001)(26005)(44832011)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KYd5DHyHQz5Nvnjy5tS79gAicdewE1kYPNdO2ChtshVDlyw6pSLGk7OsPHxV?=
 =?us-ascii?Q?o42hfrcyQshBd9wpnOJzPXx7QjOBoyxDxqfJtX5nwa2x0Nb8JC2xFFJmqljo?=
 =?us-ascii?Q?A6sq/gYQUf3UN+jTjjz+Hv+z9+EB9c1wt4wuCRsM1fBatXjSQ1wfez+beb9t?=
 =?us-ascii?Q?uW2vaI0HUGpmoHBebmljF7/OZVQqkoO8IlOD5U2iUSL2jf5EXSp1cngsm1Ul?=
 =?us-ascii?Q?XWrCZpS0ftAkwB6xx9KRK1gWV4onRbHM68MHNG4i3F+v1pnbo5FVphxAvAOW?=
 =?us-ascii?Q?aN7f57Y7xV5SUY3IIUaX+IiNAtRCPtT8vKWNfhMXnhqlML5NNe9YxZ2YXJdz?=
 =?us-ascii?Q?vpxxQRfZ9TrtaBmArycEN90xGdLO8FcULAm21vrIxrnmLJTagLcD49DONYTN?=
 =?us-ascii?Q?mo3rwHbaLdLtM69XhGsjgF54b80kurvmRQjSx8bC81yUaoFU9szA65wdp7Rq?=
 =?us-ascii?Q?sxywEwVkAFyCBKQq8gMoxojX5Q4wYD46W9ET4es9RNQTDLK2aiBSW19gQyCq?=
 =?us-ascii?Q?fwj5/4THMPcW9ULkGSyx6do8Hl6n906W+4d9hYKpszv2Faprz242yw5NaNu4?=
 =?us-ascii?Q?xrF8lcpOW7f97wFbaBVPTkChXXnMgsPIYs2BYJpFPDDQkysLG5X+OKKZmPnt?=
 =?us-ascii?Q?+9/IL2TT7yYwcyHzd8tDdI5Dy4m4x1z+DiYnUpZOpvpulU/Kjiey5uTq3Fij?=
 =?us-ascii?Q?TTo02libvRxkHbrBFjjH0w3tGcQANrcBvUaSqd3mVzkIi0NQtK4I9lLT6BVE?=
 =?us-ascii?Q?XWYmB0dwI/eCIu/1/YxxXIiSenBXCQeABmxMPdAZj45SRiy62ub3NfGN6BEK?=
 =?us-ascii?Q?oxz/XYJmfhS4NZSmxT8PgsLEPsoq12qMdbK8Tqo1oWecvZ1XLYPIUkGMlu4e?=
 =?us-ascii?Q?YYVhuD1JkDTbg6kyFe3hSnNOmtp+33V+14Tt1jfUGVfkAQOLtO+u2PUak8n2?=
 =?us-ascii?Q?nnM+wVKRuVRWW7lHWTC9pVYPPa0PpWSn8he7mA5iFHscsyG84X30oi7hLaMI?=
 =?us-ascii?Q?2KaaWpjOG/+M7TZ/F8I3GALKRpPJITBb0CcwpDKr06vHTgScM4Ib8NuYzVd2?=
 =?us-ascii?Q?sbpEud+Xu2aqfpdl7vM8Nh07ExrwDl+FXAVzSG0ElPEfjLE68oM/i1nkjzBS?=
 =?us-ascii?Q?rkPz143BZ3VQcV0VxR6KjfJFPju7yHni+WVvUlr2WFkNb2njZxLjjNNdMsJW?=
 =?us-ascii?Q?TmHOPgnUig8pbggopCcI02N6nZCFXmjTbyGDDvTMqaZmvR8rso89tj8OUHLK?=
 =?us-ascii?Q?LYKOW1mQnQNVeGpGUpir1ppE1CP59+DOrwUESsC9vUnrzP/Xp9nDziKOuvD8?=
 =?us-ascii?Q?OIyqp2DlwdCH4p8PkWUjKbOdYZylT3gX9M/X0wrh4hFmMu3rjsMbS2PRTgA4?=
 =?us-ascii?Q?MiksY5S4pENirAUIJfoMRG/ICYDiS1SSblpC9vLCczsGfIltNOuuDjpZwjN5?=
 =?us-ascii?Q?HZfIN/l7glmg/o1K+qOF9/j0vPifcWw6dQboVhYrnS3usyp0fhsdtYXfb/3n?=
 =?us-ascii?Q?osK7h1kDMhw2rGR0KElAB8hxQLS4g+KbAFGn9MSKBMgENjSgCFNeCuR5G83f?=
 =?us-ascii?Q?Y61triwORy0qBza+DnklFfyFcX4eqTHEDCPePHi4?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS1PR04MB9358.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d4cbd66-0efb-4136-e71b-08db92e607fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2023 23:21:27.6971
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zeAxOcsM0h6V+UKDTSt9nGGTTw2SuxSI0OPY8v/z9w8xuASG9ma0uIvGs6qSBfZua2hIyXkGRUEXGFfG/mcJCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9490
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Rob,

> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Thursday, June 30, 2022 2:56 AM
> To: Vabhav Sharma <vabhav.sharma@nxp.com>
> Cc: Horia Geanta <horia.geanta@nxp.com>; Gaurav Jain
> <gaurav.jain@nxp.com>; Pankaj Gupta <pankaj.gupta@nxp.com>;
> herbert@gondor.apana.org.au; davem@davemloft.net;
> shawnguo@kernel.org; linux-crypto@vger.kernel.org; linux-
> kernel@vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>;
> devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org; Silvano=
 Di
> Ninno <silvano.dininno@nxp.com>; Varun Sethi <V.Sethi@nxp.com>
> Subject: Re: [EXT] Re: [PATCH 1/3] dt-bindings: crypto: fsl: add entropy =
delay
> property
>=20
> Caution: EXT Email
>=20
> On Thu, Jun 16, 2022 at 05:49:30PM +0000, Vabhav Sharma wrote:
> > Hello Rob,
> >
> > > -----Original Message-----
> > > From: Rob Herring <robh@kernel.org>
> > > Sent: Monday, June 6, 2022 2:51 AM
> > > To: Vabhav Sharma <vabhav.sharma@nxp.com>
> > > Cc: Horia Geanta <horia.geanta@nxp.com>; Gaurav Jain
> > > <gaurav.jain@nxp.com>; Pankaj Gupta <pankaj.gupta@nxp.com>;
> > > herbert@gondor.apana.org.au; davem@davemloft.net;
> > > shawnguo@kernel.org; linux-crypto@vger.kernel.org; linux-
> > > kernel@vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>;
> > > devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> > > Silvano Di Ninno <silvano.dininno@nxp.com>; Varun Sethi
> > > <V.Sethi@nxp.com>
> > > Subject: [EXT] Re: [PATCH 1/3] dt-bindings: crypto: fsl: add entropy
> > > delay property
> > >
> > > Caution: EXT Email
> > >
> > > On Mon, May 30, 2022 at 11:39:22PM +0530, Vabhav Sharma wrote:
> > > > Add entropy delay property which defines the length (in system
> > > > clocks) of each Entropy sample taken for TRNG configuration.
> > > >
> > > > Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
> > > > Reviewed-by: Horia Geanta <horia.geanta@nxp.com>
> > > > Reviewed-by: Varun Sethi <v.sethi@nxp.com>
> > > > ---
> > > >  Documentation/devicetree/bindings/crypto/fsl-sec4.txt | 6 ++++++
> > > >  1 file changed, 6 insertions(+)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/crypto/fsl-sec4.txt
> > > > b/Documentation/devicetree/bindings/crypto/fsl-sec4.txt
> > > > index 8f359f473ada..1477294eda38 100644
> > > > --- a/Documentation/devicetree/bindings/crypto/fsl-sec4.txt
> > > > +++ b/Documentation/devicetree/bindings/crypto/fsl-sec4.txt
> > > > @@ -62,6 +62,12 @@ PROPERTIES
> > > >        Definition: A standard property. Define the 'ERA' of the SEC
> > > >            device.
> > > >
> > > > +   - entropy-delay
> > > > +      Usage: optional
> > > > +      Value type: <u32>
> > > > +      Definition: A property which specifies the length (in system=
 clocks)
> > > > +          of each Entropy sample taken.
> > > > +
> > >
> > > Seems like this could be common, but should be a time value (with
> > > unit
> > > suffix) rather than clocks. If not common, then needs a vendor prefix=
.
> > > Is this time to read a value or time between values produced? Not
> > > really clear from the description.
> > CAAM TRNG Configuration includes 16-bit field entropy-delay. This field
> specifies how long the oscillator is given to freely oscillate and genera=
te a
> single bit of entropy.
> > It is specified as number of system clock cycles and this u32 type fiel=
d
> already exist in the caam driver code with default value of 3200. However=
, on
> some platform this value can vary and support is added to read the value
> from device tree in order to override default value, Hope this helps to c=
larify.
> =09
> So that is how often a sample can be read? Or what happens if you read a
> sample too quick (in less than this delay time)?
This is the fixed value that will work always profiled while offline per So=
C or SoC family.
Value will work during initialization and run time.

Apologize to miss the email and delayed reply.
>=20
> Look at other h/w and drivers see if something common makes sense here.
>=20
> Rob
