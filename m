Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46ABA778E47
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 13:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234418AbjHKLzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 07:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233652AbjHKLzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 07:55:20 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2047.outbound.protection.outlook.com [40.107.6.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8678011F;
        Fri, 11 Aug 2023 04:55:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K7Yhce3wszQaZGaSesAFz88SWuOtCijuqJPJXwKoRp5WwDd4WN21GLzbosJPZWPmAjSx1cwv1V7JIaYibluTnNgpi7n3c4m/JJ+bikdbcYfQU+we3vLdRDnXaMhmO0R4kmBNqRSLZ8pviLLNvnq8bJHkNJa9jXocoOl/XjNvMp/jFbV3TFxz5YrcDDwLGf1+gJkA2uXBa8fL6iPY/SZGRXrZtFYqAWAfkw5XzMoQ6792FoXxgTZ+brzCTxyVSPKdywPJ9C4qPTpO1mU4Ik6E6P2/7dR/8MdjfzIjXgz/z66oigRHRbvS3CR3JCDSBHStfxAj+D9Z3SDHh2H3whJlmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R0hYWoQjbv8V77mdBk/C0PRPY8ESHYGNLk2PadmbwjM=;
 b=EKjvhIvvKehqCHc+uw7hxRaHpRwawbukuywSFMDNSVTVjnlk50b4Vao6wuX7g2t3ci4+rtIHz7D3vx7UP9ds1UJmzyC4V+fwChjR7ilx2GPpgnIWBnlSwqNfyDjJYaurRUPuHZl365NFXgnpjjKVmcKXjJMtW7UjN5cV0xvVPxWfjCD2atviCASLHjROK3Ufcv5xekMA/aHcEBSJKQ/an2KieZMT+Gxf7sa70SWnk8FkltiGVcoWb1dUGu4NP30KIcF98biYH73kx15mQs7PtkalVrKvFHR46XIz1koagxsGM5W0uvX/uRrnkoNf0x5iR6xHchbj7kCglQTkrKVnaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R0hYWoQjbv8V77mdBk/C0PRPY8ESHYGNLk2PadmbwjM=;
 b=GaAauLkrLtIdw8G8xn8i1jCrkJtcDkLKrUyCavmxr7L1hazA+GZcYkztHCoowcxY+DzyvgLUvYDGTP8GJxjd1OMXcBdxPqdVLaIKQ6o0+9mp+4ySFOLRocUbA+5EgYYRyWYqIDccPKMEzW9uDsrd7ryRDXtUwpL+lfzjrGXKUhg=
Received: from DU0PR04MB9563.eurprd04.prod.outlook.com (2603:10a6:10:314::7)
 by DB8PR04MB7081.eurprd04.prod.outlook.com (2603:10a6:10:fe::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 11:55:17 +0000
Received: from DU0PR04MB9563.eurprd04.prod.outlook.com
 ([fe80::15ed:8451:b0a2:ec64]) by DU0PR04MB9563.eurprd04.prod.outlook.com
 ([fe80::15ed:8451:b0a2:ec64%4]) with mapi id 15.20.6652.029; Fri, 11 Aug 2023
 11:55:17 +0000
From:   Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
To:     Linux regressions mailing list <regressions@lists.linux.dev>,
        Gaurav Jain <gaurav.jain@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
CC:     Bastian Krause <bst@pengutronix.de>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dan Douglass <dan.douglass@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Horia Geanta <horia.geanta@nxp.com>,
        Varun Sethi <V.Sethi@nxp.com>,
        Pankaj Gupta <pankaj.gupta@nxp.com>
Subject: RE: RE: [EXT] Re: [PATCH] crypto: caam - adjust RNG timing to support
 more devices
Thread-Topic: RE: [EXT] Re: [PATCH] crypto: caam - adjust RNG timing to
 support more devices
Thread-Index: AQHZnQeck2v36DTv3UmJ9e2grSaJgq++HokAgAFf5ACAAWGXIIAHwLJggBGNPoCAAC8BgIAKyfWAgAAvDSA=
Date:   Fri, 11 Aug 2023 11:55:17 +0000
Message-ID: <DU0PR04MB95639E903580457856250C008E10A@DU0PR04MB9563.eurprd04.prod.outlook.com>
References: <20230612082615.1255357-1-meenakshi.aggarwal@nxp.com>
 <e1f3f073-9d5e-1bae-f4f8-08dc48adad62@pengutronix.de>
 <f673a09e-e212-ee7b-15c3-78afe8c70916@pengutronix.de>
 <DU0PR04MB9563E31E69F93B63EE83DD378E39A@DU0PR04MB9563.eurprd04.prod.outlook.com>
 <DU0PR04MB95637D86F0134DC26EF955DB8E02A@DU0PR04MB9563.eurprd04.prod.outlook.com>
 <ZMzBWXpvdW5YB8bt@gondor.apana.org.au>
 <AM0PR04MB60046B045B5965A61BA1CA91E709A@AM0PR04MB6004.eurprd04.prod.outlook.com>
 <f9e34f8a-5a7b-8223-c672-4fcb2bb23c0a@leemhuis.info>
In-Reply-To: <f9e34f8a-5a7b-8223-c672-4fcb2bb23c0a@leemhuis.info>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9563:EE_|DB8PR04MB7081:EE_
x-ms-office365-filtering-correlation-id: 31c34dd0-9c5a-4e31-f350-08db9a61d48a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9gHcFm16SQ+fG41jRHeuzt29A9CEVMdn+YdxPfOyul6aqi04jueInvSyE0pQ4U2M7qEGjezEuaglZVnYaXBl7/0RM/yTVyfCtYTNxmwNBiDasIFjs8T7bdWgyLegp7EWToYSudyqGCh3qnzmq2OGS2gQROOdJpCqdbpJq9WvnBl8ue37EUwLBLELFue93aDbdXyJ+SZ79n3GZTPA++LmIauULl2NKheB33+zN/aoZrp7uCaGUduA6XPjAgOqOBhjZsdDjoJNXx2cuTXMO/lKxUQtHdpfM6v6q9wEqM9hQW999DEN7EzXWefvMuhTTNxTx59FgUJ6+VsmV6ZiEQLxCRNZKAT+B3AhocFx7CWZEP4Rbq64S798hnzZ51W7iFhpoI0S7RUnigzZ8bhwSLht9BF7bUrEcDhfNiE41zNYCZN7ZwWaDwH2L0PtVe641ku/Eoon6BMS0zJfVjnbSOwgnuzAnBbTlC98nXZRQ5HXq0HqFNM9dLPP21rganho5QULPcX8BsW54c0XoBEqnWAQN7vDhubiFeK0tgQEp+ofcfUaiabEFZ9KtToMQJG30RL0a/BLyufpA1n3xdQ5G/XDT2DjXvtLMl0CabcPHPDnnKM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9563.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(136003)(376002)(39860400002)(346002)(451199021)(186006)(1800799006)(38070700005)(478600001)(7696005)(45080400002)(54906003)(71200400001)(86362001)(53546011)(316002)(110136005)(122000001)(6506007)(26005)(38100700002)(66556008)(966005)(64756008)(4326008)(66446008)(66476007)(33656002)(9686003)(66946007)(41300700001)(83380400001)(5660300002)(2906002)(76116006)(8676002)(8936002)(52536014)(55016003)(44832011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SrFYzq40hlZiFcaY/cuFWUijI9hNMLARcQONBo5twr9D+AlU03HoyHec6mGB?=
 =?us-ascii?Q?PcsSRMgvaXXygKfkyAuLBUCgaxZ1dYDJfdJpl0SuB/Sb6PRWRVIOOjAhG9Jf?=
 =?us-ascii?Q?eNJqjkTE7VaTyHbC4sHtI2lwroaCwOtMnm252x31nAtyMcL/mi7aaOGUJ4xM?=
 =?us-ascii?Q?d4BAkNFdvCkThyqi0Jr+AfEfs1fTtqpumoVVuHqOnC3feLJcBA3XsVCNvgGP?=
 =?us-ascii?Q?yaLE5ETozekDWMtwMFvg5J9wg2o//nbtnjUhqwXt/IWiI8dG3uvuRzOpA+yR?=
 =?us-ascii?Q?MDNogJDiyoJMUdxzwDlRkjURaF7uGkKSsquA2laKfPjP+a6e/iSACYvBdx1J?=
 =?us-ascii?Q?UhRCFsbJjw4LXE3+Et/QIYwG5/vIQwGc9g21ZmG7Q6R0LDJhBKfkWiEZxIOZ?=
 =?us-ascii?Q?q+bKsT30L1OeqR3iYgVFV49P4A2MlqlGWninQpmdN3xXaZUlRCB7xlzAQBLH?=
 =?us-ascii?Q?JT7+JiShkMxdsQLZAgyLDBSM2KTzwNJjK9L68B3cWE8vMAEnYGNyE2ZvI7+g?=
 =?us-ascii?Q?8dT4D85LVJKBCN9fUEo4KxxOl925u12K/WrbLRTIIspJnafFM9rxHtvXJQ28?=
 =?us-ascii?Q?M7Zwgn7KF3fwT7om34nwymxlKFA5KvQhvjoxYjp+qzg3GQ8NCL2CdUFWIGP+?=
 =?us-ascii?Q?f4sjMBhXrNqdyzMdk2y+XYgtwoNEb4teWJxxcW754st7TKeOI5knJDwcGpGP?=
 =?us-ascii?Q?P6mEShHxsiEXmgrDHJFYrHk9cO6QyEwS3KfuQ76XkQMsG8rDUYxXQZ+Bmpwj?=
 =?us-ascii?Q?G5Y/ZFQFvqGMC5G4o29YYqpnQ1aiu9aJWjxKSNDpKdQiUEfgJedpava4k/Yk?=
 =?us-ascii?Q?gZVjmhH9UMMYlLAj1Zwnw0ckzqaTutHyHxFIarS1SrMzw3xcz0q5wnt0MN2k?=
 =?us-ascii?Q?zXH/4BvWccGqEyBOojTlGkSLl/5aX7dGlzEec9AplF8GP/IjN7KBW+VS5eNj?=
 =?us-ascii?Q?HmGYxb6apG+7rwTfUGl12QxgiaghL+AIa04PVR/VZi2TZB0+/udcsAgULvCH?=
 =?us-ascii?Q?prAwCyCbA1dSdp+3Ev0+J/sXAw+ztKDfaglSCXXWyx0TSF5mfJyeFrAyCAVi?=
 =?us-ascii?Q?SmH1Nu2PDn3FrXYXHA/UwDXAl+PcwtODRnQMTXaOcsqRRM1Ore8xil3sQnAb?=
 =?us-ascii?Q?GFDte8rbpqauGNGf2mEamk08ILgOOUB1i4/r1pmzziBYqjP7ycpUlO3QY71Q?=
 =?us-ascii?Q?rz132kQP926djRG9d1ED+6MzSt6rGnGknP534tLDE2DRzOaexshObFMxl8rB?=
 =?us-ascii?Q?VI06DyXWGWL8KeKyQy2GyPylQR+RDGSBEtVfHnmyg/olfQ2c/xAW4nOnj7g9?=
 =?us-ascii?Q?HHuDHRH7prunhWMIWj7d3jFgeUvu3isV3dEtz/eCb7yPIUgZihQgRfP5vf2s?=
 =?us-ascii?Q?pxIGzBzaKNuC1TUOf76us+j4aOs04ipNTNxNGJqxBk4cW8fmuL0OXS2DMhxr?=
 =?us-ascii?Q?t7iDe6t5b5qoMVtjjbiv60Jf3CremLf554wvJ1cL2Swx13LvrMaetI8V9jGi?=
 =?us-ascii?Q?F5zhlM0UEnQnwBbWCuasU+/fImVC6w6aFLjvuCtmMhJqdAr/S0BsJW82Rtaa?=
 =?us-ascii?Q?BPv1SqkSxsdJxUj64Gc4hDA/9O3LeB53/rsN9jj5/UYmNYOjlF1lU3g0Xw3Q?=
 =?us-ascii?Q?+g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9563.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31c34dd0-9c5a-4e31-f350-08db9a61d48a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2023 11:55:17.1328
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UXKMqdKs67baV6djN/OR3aMmjs32fpEq0LmVzFLvp+l76PkpppS58YOj+9gxQ1vHtw8AMmL1dHkd7ScNSZX3ZcSdikTA6inUUNwV5okzf/Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7081
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

we have tested this patch on multiple variants of imx board and it is worki=
ng fine.

We are actively debugging the issue, it is taking time as we are not able t=
o reproduce it at our end.

Thanks,
Meenakshi

> -----Original Message-----
> From: Linux regression tracking (Thorsten Leemhuis)
> <regressions@leemhuis.info>
> Sent: Friday, August 11, 2023 2:18 PM
> To: Gaurav Jain <gaurav.jain@nxp.com>; Herbert Xu
> <herbert@gondor.apana.org.au>; Meenakshi Aggarwal
> <meenakshi.aggarwal@nxp.com>
> Cc: Bastian Krause <bst@pengutronix.de>; davem@davemloft.net; linux-
> crypto@vger.kernel.org; linux-kernel@vger.kernel.org; Dan Douglass
> <dan.douglass@nxp.com>; kernel@pengutronix.de; Horia Geanta
> <horia.geanta@nxp.com>; Varun Sethi <V.Sethi@nxp.com>; Pankaj Gupta
> <pankaj.gupta@nxp.com>; Linux kernel regressions list
> <regressions@lists.linux.dev>
> Subject: Re: RE: [EXT] Re: [PATCH] crypto: caam - adjust RNG timing to su=
pport
> more devices
>
> [CCing the regression list, as it should be in the loop for regressions:
> https://docs.ker/
> nel.org%2Fadmin-guide%2Freporting-
> regressions.html&data=3D05%7C01%7Cmeenakshi.aggarwal%40nxp.com%7Cfde9
> ceeb9e0d40d4f77d08db9a47a5e1%7C686ea1d3bc2b4c6fa92cd99c5c301635%7
> C0%7C0%7C638273404742560069%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC
> 4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C
> %7C%7C&sdata=3Dlt7nphOXYXc3GRfOquvM5jmqNszQkDd%2BuSRdAbJd8Ec%3D&r
> eserved=3D0]
>
> On 04.08.23 14:02, Gaurav Jain wrote:
> > From: Herbert Xu <herbert@gondor.apana.org.au>
> >> On Mon, Jul 24, 2023 at 05:13:23AM +0000, Meenakshi Aggarwal wrote:
> >>> Please share the required information.
> >> Any progress on this?
> >>
> >> Should we revert the offending patch?
> >
> > Debugging is in progress. There should be some mismatch in TRNG
> configuration in customer board.
> > Will be sharing a patch to dump the same.
>
> Any progress on this? Afaics would be good to have either the fix or the =
revert in
> by -rc7 to ensure things get at least one week of proper testing before t=
he final
> release.
>
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> --
> Everything you wanna know about Linux kernel regression tracking:
> https://linux-/
> regtracking.leemhuis.info%2Fabout%2F%23tldr&data=3D05%7C01%7Cmeenakshi.
> aggarwal%40nxp.com%7Cfde9ceeb9e0d40d4f77d08db9a47a5e1%7C686ea1d3b
> c2b4c6fa92cd99c5c301635%7C0%7C0%7C638273404742560069%7CUnknown
> %7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwi
> LCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3DXg3ZCWObptmF6xLKO7dpaIYB
> A17eKK5wNhlPZ6FR2XA%3D&reserved=3D0
> If I did something stupid, please tell me, as explained on that page.
>
> #regzbot poke
