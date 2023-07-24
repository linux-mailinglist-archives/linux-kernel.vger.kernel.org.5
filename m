Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5717A75EABB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 07:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbjGXFNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 01:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjGXFN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 01:13:29 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2089.outbound.protection.outlook.com [40.107.8.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B754E6;
        Sun, 23 Jul 2023 22:13:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gQEGpqhoC9/R6p10oMsTDbwajVBN61ulNRBe1Imb2C3+jzOZo0f3d5bAf9PVOQDNiMm32moFWG+SYTuBe5NIqF/Xlhox4tMP9csB6+MPfQdkOAqXbuEXHVMxvyOhjI5/NzzT6gIv2Uyk4qXemk4jlq8TTAraZAuNFoKJgZwerIm0LXYPuvfP0hsaQToTiADOO2rtiaiQ4Pgyf40mfn6PiSdoI1mDGPQ6HuvAwgYHAFSo0E6B/pqKIvEWrLgnff540HRM2DEH930WIGqVBrPbV5MxUJDxmSfsi1DDQlg3F80FlB6JmQc6ZMDL8zxJ2YCa+pe9wfnlft69jCSn+ZuNdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b6SzSl+m8HOw8hSYJ4CsM+a65aGT8BSEnB2zOPssa94=;
 b=SZLRpmjIvFQ2jlzwofdLawvaMlc5YRjzCoxwXZBXKE7DLcLmHAqwoUZyHLpZJF64adU7yVkboB2x99pikpbb4mauJYiFLus5IEc70QuXZ4SIcORA9AIZcmFTgcc4UQAZGjm5Q0rpdkx2Ez+AzY1T531qCZcBlmofzixxMp+1HJ3ztAmOtNP8Eu0C7ZemuTxXu34YiHAafi11a5tVWF9dB0nLIm358Dk1JRwZLwYXtiAQ+wT/Uw/ySsxfjpOurRjCQdRs8EEv5H24U4Qjf9quYsIHBb2+8eYch9dzhLtcqB6bpN571DMUWXv72/n3x+NqbB30Ad1jgWl9Zm30wTySPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b6SzSl+m8HOw8hSYJ4CsM+a65aGT8BSEnB2zOPssa94=;
 b=m+dqdKkaBU5hkaVboxwuWjCf7Y1vlBg6s8NtFjuU92sCxwOLBbchLf2cXZkiezjCjhZ88Ee0EqqscqFFkNyfjdHETgZKAngjd2D3/6IItMcEjsHKZwZOygdCp7OM1d+gKWj4NF/7emUQNC0PugvOIVL7hQ8EeC3ifsUFyFaSxZs=
Received: from DU0PR04MB9563.eurprd04.prod.outlook.com (2603:10a6:10:314::7)
 by PAXPR04MB9422.eurprd04.prod.outlook.com (2603:10a6:102:2b4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Mon, 24 Jul
 2023 05:13:24 +0000
Received: from DU0PR04MB9563.eurprd04.prod.outlook.com
 ([fe80::15ed:8451:b0a2:ec64]) by DU0PR04MB9563.eurprd04.prod.outlook.com
 ([fe80::15ed:8451:b0a2:ec64%4]) with mapi id 15.20.6609.031; Mon, 24 Jul 2023
 05:13:24 +0000
From:   Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
To:     Bastian Krause <bst@pengutronix.de>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Dan Douglass <dan.douglass@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
        Horia Geanta <horia.geanta@nxp.com>,
        Varun Sethi <V.Sethi@nxp.com>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        Gaurav Jain <gaurav.jain@nxp.com>
Subject: RE: [PATCH] crypto: caam - adjust RNG timing to support more devices
Thread-Topic: [PATCH] crypto: caam - adjust RNG timing to support more devices
Thread-Index: AQHZnQeck2v36DTv3UmJ9e2grSaJgq++HokAgAFf5ACAAWGXIIAHwLJg
Date:   Mon, 24 Jul 2023 05:13:23 +0000
Message-ID: <DU0PR04MB95637D86F0134DC26EF955DB8E02A@DU0PR04MB9563.eurprd04.prod.outlook.com>
References: <20230612082615.1255357-1-meenakshi.aggarwal@nxp.com>
 <e1f3f073-9d5e-1bae-f4f8-08dc48adad62@pengutronix.de>
 <f673a09e-e212-ee7b-15c3-78afe8c70916@pengutronix.de>
 <DU0PR04MB9563E31E69F93B63EE83DD378E39A@DU0PR04MB9563.eurprd04.prod.outlook.com>
In-Reply-To: <DU0PR04MB9563E31E69F93B63EE83DD378E39A@DU0PR04MB9563.eurprd04.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9563:EE_|PAXPR04MB9422:EE_
x-ms-office365-filtering-correlation-id: 3e34b8c4-0cc8-4674-99c1-08db8c04b47b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xCWhCQds88nEP5EGfkRltcMdhofn9ir0Wn+HWH5ndEq73qswx2/sBMCEgJ/Zse/hrsPqWtqezqsgzx6SDRx9x95ze2u4g1Nxk2GXe2eTovqGDkGEnYvQ+twHtHtwfWKQHHJ3rc9+vJeNsnV2kFJvnCvugAZ4FEEu2IosiPc96rCXCmxR68RJ0QKjaLglkxMumWYLwJ9CKII+Xxk9SG86yob7heXqfRY9TJTplWG/rJpOyVIIQGiMoVoYGdXs1l9uakCteGJWutS/u3h9mepWtMAfBMmvLpehFBD1ZrmN2owH+E4ceGiUM4/BY8YwPb5LlLLfHN4D6RqUTQp11IX0GJzCOx1mPmQNQb7Wy3+md99vfSHrvOu9pMv0SCVCBX++gwurPSEBuWmF/ZRSBe/PFflk3t8zO9bDv681NJL9g3aKLT8yXVbxBw9QOx/bugUiUnBNYd5ZS0PulsmbNcAOpjGIlWJd7Ya1qS9/DfKOpK+anLkk3RR9UXcl0PQwzFol/R8FZXbMX4W+zanlSyOMCzKTsmwIlURE64tK3myKdYEoeCn7gepoiraEjcsQzlsfBY/9+Y4nijfEhyWXVaopBRvp+kXw5bvEGI6OwsjKK5E=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9563.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(39860400002)(376002)(136003)(396003)(451199021)(33656002)(86362001)(38100700002)(55016003)(122000001)(71200400001)(2906002)(7696005)(966005)(9686003)(53546011)(6506007)(186003)(38070700005)(26005)(110136005)(5660300002)(41300700001)(66556008)(66476007)(76116006)(66446008)(64756008)(66946007)(4326008)(316002)(45080400002)(478600001)(8936002)(44832011)(52536014)(54906003)(83380400001)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?wFYgkma1EBe+OhEgEMjUfHPJPHhljftSNt8OWNc203451yNCYD2ryvhqMY?=
 =?iso-8859-2?Q?93s2Qmb9H6Fo4GlesgFzdilR6pw3hTpqZ53fMlqzouZ9HUm/tCofi4pqCa?=
 =?iso-8859-2?Q?pKKzrtfKR3otJnqElc7ILfEEL0MDRLO4FIWLRYm8+QFkunQTF/FVgGa8P5?=
 =?iso-8859-2?Q?KpAVP4EDFlEuUh03z6gCI2vrBu/OHiJ8m5PuBxnQYzPwUpUC1SYDSzkQqk?=
 =?iso-8859-2?Q?z/gaD5nvSdFSn/qrKPu07lyjF1uCgZG85PIYwq0av5PeyPaMdc2+IVeJ0m?=
 =?iso-8859-2?Q?53QGDC21m9dp9bgmmvSxgxfra8nbZu4A6bVl7engm8ZFAJESFe4t008ndY?=
 =?iso-8859-2?Q?vIrOa7P49GaDURC51rgt30XFtS4g30Ednzq4pbemvO2s8K02xfv7wulxcM?=
 =?iso-8859-2?Q?gvd9vQ82yKkcMOsn1EcfU/QqOfWzbX1DiN1+827Ct2ECJ/ioqZJ9p2KWis?=
 =?iso-8859-2?Q?ZGxWvlyQVIRobYGTK5GGMI//+ShLYacK3jLCbjS9LYp0Aqcqki/9dlscGm?=
 =?iso-8859-2?Q?bOKOilIkUcGKwJi14nBjv6NxQ+BfphYTwS/CedoRcWQN6eKfZhctSbtmqw?=
 =?iso-8859-2?Q?+O3f0X9yLe4NRjFD+CZTmxOz0/qSC+mqNljGbQUftf6CZC9rA0Xn1k1F9Q?=
 =?iso-8859-2?Q?ZDJ492N1GGwxSPhOL+KrdbNY+YNNGOKSomP70+z6yehT1kMUR4woSUtrx0?=
 =?iso-8859-2?Q?pHfnLXk0lVYcuKnUaHpvTMiNDHtHHMcS99Rh9qnbpo9aTbl2hxvKWbjDoY?=
 =?iso-8859-2?Q?Yv0ja1RWhNGgBRI5BP4DXvdRac/UU2fHcIWk0UozPB92oNGoYkebcPiWj2?=
 =?iso-8859-2?Q?H1auFtqLXpluj9qXzWyqh4yzDNfcUGdUq5zXr/gvokpDCcrmFJeCprCVH1?=
 =?iso-8859-2?Q?cHO0AfM7jpLD1GEqh5BJyQJ3fyTsWg4lOD8v3BoDjd6K1dheUSyKKHO4SX?=
 =?iso-8859-2?Q?cN0OMVXNr3Ag1qHbrsJ7dRloM61HqbCPneOZ67Vj2SsXi47QKXJBfcyZTO?=
 =?iso-8859-2?Q?84ZMMnbCGaCy/sOmR8cR0Xfdt4S7uwPy2AzQUIRXLnwLJZo75HCRme3Bgz?=
 =?iso-8859-2?Q?94ZYZLAr6MeMIgOHOiietwzxlsRJCO5iu6E2sncHqjnVVP2DYywEW9jw8d?=
 =?iso-8859-2?Q?1KOZIDBwdwgfmLSHggbPCq3vQc7ypJxkD49v6Te0P2B/EDRvaNJBNxqUG3?=
 =?iso-8859-2?Q?bXSHWldpfc0a0UWDUcTDFP/RjUU/miTg2dQ1E+fxbUHMD4kTsPuYB+r9bC?=
 =?iso-8859-2?Q?ELsxGNL5C99Dbso2yY25Hg/CoDJGcaMhXcdhDB7MAM+dBfkK9UMYvpapzz?=
 =?iso-8859-2?Q?2/6csbYwKa8bJAk/OBGMzFATbifDSiAHDWPhuoCkjaiAxcXnXvtXQsHGUs?=
 =?iso-8859-2?Q?/2WiL4w+VVgyBhJEAiCveWY7vNqzMdUTVmWWpr+7lLYuIkvq34zZkbRFtH?=
 =?iso-8859-2?Q?UfuyvC5InF0e90CaSFCKMCd6ER9bNvKSB4kn9GJvcaU8E6KyB4t98hBxjp?=
 =?iso-8859-2?Q?JeWPZlIYuReOHYTFgMHIwfD1ihovrlUbRDKHcFeOMupWTatenwlBIHrugK?=
 =?iso-8859-2?Q?h+k73wtUlRLc9ziTbTrRqnDdZX5Y0JLkrzjiVnL4G+/3zWXXB5Mzf7rjr8?=
 =?iso-8859-2?Q?Zv1/fIs0RWbAH7oNWVc6M3vrzcGpXno8jrHfs44pualRP9kfkcWKtIJw?=
 =?iso-8859-2?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9563.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e34b8c4-0cc8-4674-99c1-08db8c04b47b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2023 05:13:23.8647
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ++By0QJC5v04ULrkLEXi0SpKo0Ud56RCac9lCAfE5fxU43/r9m5TYn79m9zH38/kvS0gCGzKThWva2mYu4KemjgF+N2TEg7dkDZQouXlIwg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9422
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bastian,

Please share the required information.

Thanks,
Meenakshi

> -----Original Message-----
> From: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
> Sent: Wednesday, July 19, 2023 12:31 PM
> To: Bastian Krause <bst@pengutronix.de>; Horia Geanta
> <horia.geanta@nxp.com>; Varun Sethi <V.Sethi@nxp.com>; Pankaj Gupta
> <pankaj.gupta@nxp.com>; Gaurav Jain <gaurav.jain@nxp.com>;
> herbert@gondor.apana.org.au; davem@davemloft.net; linux-
> crypto@vger.kernel.org; linux-kernel@vger.kernel.org
> Cc: Victoria Milhoan <vicki.milhoan@freescale.com>; Dan Douglass
> <dan.douglass@nxp.com>; Vipul Kumar <vipul_kumar@mentor.com>;
> kernel@pengutronix.de
> Subject: RE: [PATCH] crypto: caam - adjust RNG timing to support more dev=
ices
>
> Hi Bastian,
>
> We have tested the patch on i.mx8mm board and we did not face any issue w=
ith
> the patch.
>
> Please share your imx8mm board revision and complete logs (including
> bootloader logs), It will help in investigating the issue you are facing.
>
> Thanks,
> Meenakshi
>
> > -----Original Message-----
> > From: Bastian Krause <bst@pengutronix.de>
> > Sent: Tuesday, July 18, 2023 3:13 PM
> > To: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>; Horia Geanta
> > <horia.geanta@nxp.com>; Varun Sethi <V.Sethi@nxp.com>; Pankaj Gupta
> > <pankaj.gupta@nxp.com>; Gaurav Jain <gaurav.jain@nxp.com>;
> > herbert@gondor.apana.org.au; davem@davemloft.net; linux-
> > crypto@vger.kernel.org; linux-kernel@vger.kernel.org
> > Cc: Victoria Milhoan <vicki.milhoan@freescale.com>; Dan Douglass
> > <dan.douglass@nxp.com>; Vipul Kumar <vipul_kumar@mentor.com>;
> > kernel@pengutronix.de
> > Subject: Re: [PATCH] crypto: caam - adjust RNG timing to support more
> > devices
> >
> > On 7/17/23 14:43, Bastian Krause wrote:
> > > On 6/12/23 10:26, meenakshi.aggarwal@nxp.com wrote:
> > >> From: Victoria Milhoan <vicki.milhoan@freescale.com>
> > >>
> > >> Adjust RNG timing parameters to support more i.MX6 devices.
> > >>
> > >> Signed-off-by: Victoria Milhoan <vicki.milhoan@freescale.com>
> > >> Signed-off-by: Dan Douglass <dan.douglass@nxp.com>
> > >> Signed-off-by: Vipul Kumar <vipul_kumar@mentor.com>
> > >> Signed-off-by: Horia Geant=E3 <horia.geanta@nxp.com>
> > >> ---
> > >>   drivers/crypto/caam/ctrl.c | 4 ++--
> > >>   1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > This patch seems to breaks CAAM RNG instantiation on an i.MX8MM at my
> end:
> > >
> > > caam 30900000.crypto: Entropy delay =3D 3200 caam 30900000.crypto:
> > > Entropy delay =3D 3600 [...] caam 30900000.crypto: Entropy delay =3D
> > > 12400 caam 30900000.crypto: failed to instantiate RNG
> > > caam: probe of 30900000.crypto failed with error -11
> > >
> > > If I revert this patch or increase RTSDCTL_ENT_DLY_MAX to a value >
> > > 66800, it works again:
> > >
> > > caam 30900000.crypto: Entropy delay =3D 32800 caam 30900000.crypto:
> > > Entropy delay =3D 33200 [...] caam 30900000.crypto: Entropy delay =3D
> > > 66800 caam 30900000.crypto: Instantiated RNG4 SH0 caam
> > > 30900000.crypto: Instantiated RNG4 SH1 caam 30900000.crypto: device
> > > ID =3D 0x0a16040100000000 (Era 9) caam 30900000.crypto: job rings =3D=
 2,
> > > qi =3D
> > > 0 caam algorithms registered in /proc/crypto caam 30900000.crypto:
> > > caam pkc algorithms registered in /proc/crypto caam 30900000.crypto:
> > > registering rng-caam Executing RNG SELF-TEST with wait
> > > random: crng init done
> > > caam 30900000.crypto: rng crypto API alg registered prng-caam
> >
> > This ^ was the kernel log for..
> >
> >
> > --- a/drivers/crypto/caam/regs.h
> > +++ b/drivers/crypto/caam/regs.h
> > @@@ -522,7 -522,7 +522,7 @@@ struct rng4tst
> >    #define RTSDCTL_ENT_DLY_SHIFT 16
> >    #define RTSDCTL_ENT_DLY_MASK (0xffff << RTSDCTL_ENT_DLY_SHIFT)
> >    #define RTSDCTL_ENT_DLY_MIN 3200
> > --#define RTSDCTL_ENT_DLY_MAX 12800
> > ++#define RTSDCTL_ENT_DLY_MAX 70000
> >    #define RTSDCTL_SAMP_SIZE_MASK 0xffff
> >    #define RTSDCTL_SAMP_SIZE_VAL 512
> >          u32 rtsdctl;            /* seed control register */
> >
> >
> > For completion's sake: Reverting this patch..
> >
> >
> > --- a/drivers/crypto/caam/ctrl.c
> > +++ b/drivers/crypto/caam/ctrl.c
> > @@ -383,7 +383,7 @@ static void kick_trng(struct device *dev, int ent_d=
elay)
> >                  /* min. freq. count, equal to 1/4 of the entropy sampl=
e length */
> >                  wr_reg32(&r4tst->rtfrqmin, val >> 2);
> >                  /* max. freq. count, equal to 16 times the entropy sam=
ple length */
> > -               wr_reg32(&r4tst->rtfrqmax, val << 4);
> > +               wr_reg32(&r4tst->rtfrqmax, RTFRQMAX_DISABLE);
> >          }
> >
> >          wr_reg32(&r4tst->rtsdctl, (val << RTSDCTL_ENT_DLY_SHIFT) |
> >
> >
> > ..produces this kernel log (without RNG SELF-TEST):
> >
> > caam 30900000.crypto: Entropy delay =3D 3200 caam 30900000.crypto:
> > Entropy delay =3D 3600 caam 30900000.crypto: Instantiated RNG4 SH0 caam
> > 30900000.crypto: Instantiated RNG4 SH1 caam 30900000.crypto: device ID
> > =3D
> > 0x0a16040100000000 (Era 9) caam 30900000.crypto: job rings =3D 2, qi =
=3D 0
> > caam algorithms registered in /proc/crypto caam 30900000.crypto: caam
> > pkc algorithms registered in /proc/crypto caam 30900000.crypto:
> > registering rng- caam caam 30900000.crypto: rng crypto API alg
> > registered prng-caam
> > random: crng init done
> >
> > Regards,
> > Bastian
> >
> > >>
> > >> diff --git a/drivers/crypto/caam/ctrl.c
> > >> b/drivers/crypto/caam/ctrl.c index 5fed3cf354c0..62dd069942e4
> > >> 100644
> > >> --- a/drivers/crypto/caam/ctrl.c
> > >> +++ b/drivers/crypto/caam/ctrl.c
> > >> @@ -383,8 +383,8 @@ static void kick_trng(struct device *dev, int
> > >> ent_delay)
> > >>       wr_reg32(&r4tst->rtsdctl, val);
> > >>       /* min. freq. count, equal to 1/4 of the entropy sample
> > >> length */
> > >>       wr_reg32(&r4tst->rtfrqmin, ent_delay >> 2);
> > >> -    /* disable maximum frequency count */
> > >> -    wr_reg32(&r4tst->rtfrqmax, RTFRQMAX_DISABLE);
> > >> +    /* max. freq. count, equal to 16 times the entropy sample
> > >> +length */
> > >> +    wr_reg32(&r4tst->rtfrqmax, ent_delay << 4);
> > >>       /* read the control register */
> > >>       val =3D rd_reg32(&r4tst->rtmctl);
> > >>   start_rng:
> > >
> >
> > --
> > Pengutronix e.K.                           |                           =
  |
> > Steuerwalder Str. 21                       |
> > http://www.p/
> >
> en%2F&data=3D05%7C01%7Cmeenakshi.aggarwal%40nxp.com%7C3e036baed8c9
> 4cf104
> >
> 4008db8825e5ce%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6382
> 534685
> >
> 76971721%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2l
> uMzIiL
> >
> CJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3DvbtE1IciakfHjf
> JQiB
> > VxOGN%2Bm7JBlT%2B1obDRf0eyOuM%3D&reserved=3D0
> >
> gutronix.de%2F&data=3D05%7C01%7Cmeenakshi.aggarwal%40nxp.com%7C1f556
> >
> d6802434c00ef4f08db87736527%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C
> >
> 0%7C0%7C638252701909887583%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4
> >
> wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C
> > %7C%7C&sdata=3D2vCBBdo%2FAkyz%2BaLXcDyeursw3Gle%2FKosiO%2FdPysOd
> 3
> > Q%3D&reserved=3D0  |
> > 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0  =
  |
> > Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-555=
5 |

