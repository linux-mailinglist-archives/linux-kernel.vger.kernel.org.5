Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18FF67AD41F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 11:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233172AbjIYJEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 05:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233113AbjIYJEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 05:04:02 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2087.outbound.protection.outlook.com [40.107.20.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D4929B;
        Mon, 25 Sep 2023 02:03:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MG3741ayEDz6d/uCBxTPLnDO5oYuZ2e/3TKUP2rSLwUn/Uj9sH7TJuEYzw5cZQWxrxfA15Mf6190Mp58fhO6+22wb/yUEHJQcxZDwFnW1O18HrFUuUdlqD1xTtSXeNS1WVfd5etjy9M1hru3gghDc11Wqg1tGWS29acw/egJ4vg27dS9qBmmFmO7rwRKO1cGwJZg09utIidbxZTj2XqMiEzsaEZFy+6e4XLHOxxw0wiMS7sQJZkFos5+Gg6C3Hax823M4MASfii0E2jjMbrBe13nUun78Rh65qnjnSv9Vtpook8tQM2xXkSin85ns5xCBJRp2JmX8KrJP5yNKn3UdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UKbd7Goi3DIrv1rqPd9ppu6qiTMZsX3rOsPY3efzJLI=;
 b=KCygRI+Eyz55CWARU2LDmNmlAmXabfjiJb/YgzNRSNb/1TUcf303P6XvLkeaAsqViSxmYewH/b4q2SA9AO6LzSXoH7ivmlySxuT1wO/NK1zFu1ez9N/vUlspPE9CDh06KD6EQ9bRx+BN/keuXjXpsMsebwH/K2J0O3aRhv//fRFT1ZZRGTGHzkbIk7z+BfU+wxdRX9tTmizThHMRYhHhghFgPVczxctgT8EZ+ma4KtUh10EJ8Z4lPZ8K0QUg9ww3I2M8wmppaPmd3OEg1RdhKVBVVaQeLa0KorfDVz3w2bPqYfyJBkuUskU9O13vnPtED9h0oLStIiKxM9ar3droFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UKbd7Goi3DIrv1rqPd9ppu6qiTMZsX3rOsPY3efzJLI=;
 b=hG2xNeHGedi81SiYKCLX/aoiHp9HDnfY85vDgkcPmnC8Hd5qHeI1inVtkb/8dmtZQV8BGZRUQ0hPnuNEaNjyYxgo2lpAvY642NB3fVfjbb0PuWDIKozuqStNUCH7oAUrs56r6bvuJmc+LulUeoqgNE/8SCM5gjlDdiP4xZvNQr4=
Received: from AM0PR04MB6004.eurprd04.prod.outlook.com (2603:10a6:208:11a::11)
 by DB9PR04MB9819.eurprd04.prod.outlook.com (2603:10a6:10:4c0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 09:03:52 +0000
Received: from AM0PR04MB6004.eurprd04.prod.outlook.com
 ([fe80::86b7:e0cc:dd24:12c0]) by AM0PR04MB6004.eurprd04.prod.outlook.com
 ([fe80::86b7:e0cc:dd24:12c0%7]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 09:03:52 +0000
From:   Gaurav Jain <gaurav.jain@nxp.com>
To:     Kamlesh Gurudasani <kamlesh@ti.com>,
        Eric Biggers <ebiggers@kernel.org>
CC:     Horia Geanta <horia.geanta@nxp.com>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        Varun Sethi <V.Sethi@nxp.com>,
        Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Silvano Di Ninno <silvano.dininno@nxp.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [EXTERNAL] RE: [EXT] Re: [PATCH] crypto: caam/jr - fix Chacha20 +
 Poly1305 self test failure
Thread-Topic: [EXTERNAL] RE: [EXT] Re: [PATCH] crypto: caam/jr - fix Chacha20
 + Poly1305 self test failure
Thread-Index: AQHZ7Ikn5EtLvx/uSE+ZWTGko+Cjx7AmI14AgAA/4tCAAA1egIAE0XnQ
Date:   Mon, 25 Sep 2023 09:03:52 +0000
Message-ID: <AM0PR04MB6004B49C47CA3E8F264812DCE7FCA@AM0PR04MB6004.eurprd04.prod.outlook.com>
References: <20230921124237.2364827-1-gaurav.jain@nxp.com>
 <20230922024100.GA935@sol.localdomain>
 <AM0PR04MB60043F6A9B0BCED6BC1827CDE7FFA@AM0PR04MB6004.eurprd04.prod.outlook.com>
 <875y42he2e.fsf@kamlesh.i-did-not-set--mail-host-address--so-tickle-me>
In-Reply-To: <875y42he2e.fsf@kamlesh.i-did-not-set--mail-host-address--so-tickle-me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR04MB6004:EE_|DB9PR04MB9819:EE_
x-ms-office365-filtering-correlation-id: ddfbb59a-607a-40fe-f133-08dbbda656fe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K1eH14oR/+imzEXlk58uAqazrX/hOotshdzau6zD4qKXZ9dsiQ3Mtqr2dL7PtTuhYJ4wjBv6HY1mTohjgVjcHLjiaBlqU6gARFE1m63z1FurDQzN1Hw6VgBq+p5VEe8zEpGy8K7mKFdC0+hBI6/SLffbGf8SMqdrAGR6JyFFHJVt1BLu8Er618rQcvlHlI2X7VNaA9iYe8j0o15FJVi4+xDEOQJ9QEdFt1gOuJiGoRO25rjOolXXLNZ+wPDknKxHaOXhScilTc7xXGD4902EAY9oc92iproUzLs4upjMMK3ThUuf6t/wDwzOKD2vDe9T9UUXh4juAcwV9wJYo0n3TLL3fdj1MJ5NxazLiL9DeN4YC2BhuGIuiHdDzdf1AKYwRAro8WC3+6AYqT/pRJPF/YMKHRNJy/aW9qbET/WlQiV1d92gI4j+7zu1NbZRL5knewoqfroXYOvnflD/wHe3EpjvXQkx2XHeyoI0x0jGPCeUV81OSHXYpLfKc0YnqxLzFWTfLR0VH3eKdlbbdqorA7QOpIeAyY5+L811BxNaMW+aea+yX0pCv0DD89/t/I1CTKzNXqI73CnfqOXUCHjuwy8MWpEFYKo7jelxOjFnB9g0PqBBKZZ019M5D4cBhKTS
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6004.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(366004)(136003)(396003)(230922051799003)(186009)(1800799009)(451199024)(71200400001)(478600001)(26005)(83380400001)(86362001)(38070700005)(38100700002)(33656002)(5660300002)(55016003)(53546011)(7696005)(6506007)(122000001)(9686003)(110136005)(2906002)(66556008)(66446008)(54906003)(66476007)(66946007)(76116006)(64756008)(316002)(52536014)(41300700001)(4326008)(8676002)(8936002)(44832011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EyKFzoGR19Qk+OFPt2OCRijVNJtDppNyhwp8bIDJqBwQfZNeHa+W2HwFlIhv?=
 =?us-ascii?Q?KYUm6G/Q2XFXdViDFI8kq0NqehrsGlj6MYczh30tguAKoQBfR8JezpCj/sib?=
 =?us-ascii?Q?ZV6h/Z/3kKPM1r/XnSewnBMeYdQa7+uSN/f2gZyU/eSxzoMths2URKgnjLwX?=
 =?us-ascii?Q?YHwDNTD9avWgxrdTQ5eVMCPcju8lgGn2k2vZy2leNQu4CaQB7u1TtzDhnrvE?=
 =?us-ascii?Q?11T9hjgsG8xj2tk5FwmzZWx3W4rwGbegQFnHVD2UKdpXzvzlAl06jSVf00ae?=
 =?us-ascii?Q?aakPOZGnj7RZOQzd1+UA5bW12n6pjHGx9bLErlYDY5hygQvbxn2UreTHS2br?=
 =?us-ascii?Q?ojyNBLbEmWA7FGHyUnOJShU4i6vsX9QznbmG3UtelwMOVhNzNEqvdudVek2m?=
 =?us-ascii?Q?GLFNsCmiLcH5YJihZ5c4/DMyIPradwRLyTypjzx8pEh2dz2uIKw1c1tyELo0?=
 =?us-ascii?Q?PaU3z5UFoRWz+8Do7+wtCRE59wsNklK00KnYewqHZfpsjbwI2tbiQku0VGLG?=
 =?us-ascii?Q?yq+SQhnFVyHpnlgonblTLgAyxyXSW48/UyYQXPEBC+PqRRk3zGvH8MKlsuar?=
 =?us-ascii?Q?nmwH5aXOSXGrJeZlvhYom1onxLKzEUHozzxB7Y40QwaLjQEAsJYPwr3i1ZJy?=
 =?us-ascii?Q?m1LPikMUEX1SCTrhOPKFLYceDx84ScrDcYHkXNj9HDgyGHShmkDIHdAH373N?=
 =?us-ascii?Q?FieLnpCfraC6Zdz+qOMusTDHT7ZcE15DW5+zyvV+9hv8rp+LkTzeF74Ei5uw?=
 =?us-ascii?Q?cqnBUaAh86xfYjOxnpB0qMPTvdW/PJr1KhCBiGqPxNlWF1XjlLg6eJo0ZYFA?=
 =?us-ascii?Q?IOzNOtO/otaTA2IZnBDltrlN4IBskeSJ0OoIIetRiS6m9D7xhdx358eB9RYw?=
 =?us-ascii?Q?UW4iokAJaRCJd7x0i8tfV7d37nwM+WQS4XNJ3unuOTcmsA+qwj96cUzqSTv5?=
 =?us-ascii?Q?Nr9gBrSkOfMWiNY15/iNudaf22SbDYBTmS+olTOUyTweM0egIfTmglrlc87c?=
 =?us-ascii?Q?rbqgncXFqksst2pyXAbeCKQGg10kYQXgN/7KGDMCQgmxtK8nNh3gexmt44if?=
 =?us-ascii?Q?cy4iF3/gPGDQsjpvv1yjfOOt/4Nx9wqxtCxMUJPv4ZiGZNax8yLosTEEFmM7?=
 =?us-ascii?Q?HrTvGNEIH2Dxtd64kBRx2JDiI/nx0n+u/4Qb4LcoQDOsKdytPmsfTwJ3YFGE?=
 =?us-ascii?Q?mdcoNRoyWrLDiFmKo/PnDRJ1oHxV7dir0ILQLk/yUX/tDyR9U3BV+n4w9R7X?=
 =?us-ascii?Q?yqQGH3kqpEQvTvUWOWzK6TxzlP4FMgH0eCR7QUwVR9kQVp1DWqfBagKo4nEu?=
 =?us-ascii?Q?f7WyNGRjCRJ6UdOsu90wL17cQxsX4GEGvXSxS3k3PieLZS2y5jvDJWklNcZR?=
 =?us-ascii?Q?YV6rP1LQWetZiyWNut+zIBWrylk6n57sY+zlugFGY0jwr6sIxyBFu+njcfND?=
 =?us-ascii?Q?zxhg1SNM7WPFQhs7gEBSQ8CulvWvmlu+sLw0s9Z12vICjtclY46oLl8MgGXW?=
 =?us-ascii?Q?zwr4POaN8u+r8s6KM+E9nhSLZ0jG0CLguyITWbNNV5eF15uuL23Tq3V0aREd?=
 =?us-ascii?Q?iZMUuAKt/E7KdcybqWfLNAJHxapK0BBHuANWNHq4?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6004.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddfbb59a-607a-40fe-f133-08dbbda656fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2023 09:03:52.4394
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7jYnRqdgOuw7JT/QVx1PCZ4dywh85IbfzZsukDMEk0ythHn6C0N3ayD1Ijd573oCL+n0rDJkHOJyX9nTsULVlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9819
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kamlesh

> -----Original Message-----
> From: Kamlesh Gurudasani <kamlesh@ti.com>
> Sent: Friday, September 22, 2023 12:47 PM
> To: Gaurav Jain <gaurav.jain@nxp.com>; Eric Biggers <ebiggers@kernel.org>
> Cc: Horia Geanta <horia.geanta@nxp.com>; Pankaj Gupta
> <pankaj.gupta@nxp.com>; Varun Sethi <V.Sethi@nxp.com>; Meenakshi
> Aggarwal <meenakshi.aggarwal@nxp.com>; Herbert Xu
> <herbert@gondor.apana.org.au>; David S . Miller <davem@davemloft.net>;
> Aisheng Dong <aisheng.dong@nxp.com>; Silvano Di Ninno
> <silvano.dininno@nxp.com>; linux-crypto@vger.kernel.org; linux-
> kernel@vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>
> Subject: Re: [EXTERNAL] RE: [EXT] Re: [PATCH] crypto: caam/jr - fix Chach=
a20 +
> Poly1305 self test failure
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report =
this
> email' button
>=20
>=20
> Gaurav Jain <gaurav.jain@nxp.com> writes:
>=20
> > Hi Eric
> >
> >> -----Original Message-----
> >> From: Eric Biggers <ebiggers@kernel.org>
> >> Sent: Friday, September 22, 2023 8:11 AM
> >> To: Gaurav Jain <gaurav.jain@nxp.com>
> >> Cc: Horia Geanta <horia.geanta@nxp.com>; Pankaj Gupta
> >> <pankaj.gupta@nxp.com>; Varun Sethi <V.Sethi@nxp.com>; Meenakshi
> >> Aggarwal <meenakshi.aggarwal@nxp.com>; Herbert Xu
> >> <herbert@gondor.apana.org.au>; David S . Miller
> >> <davem@davemloft.net>; Aisheng Dong <aisheng.dong@nxp.com>; Silvano
> >> Di Ninno <silvano.dininno@nxp.com>; linux-crypto@vger.kernel.org;
> >> linux- kernel@vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>
> >> Subject: [EXT] Re: [PATCH] crypto: caam/jr - fix Chacha20 + Poly1305
> >> self test failure
> >>
> >> Caution: This is an external email. Please take care when clicking
> >> links or opening attachments. When in doubt, report the message using
> >> the 'Report this email' button
> >>
> >>
> >> On Thu, Sep 21, 2023 at 06:12:37PM +0530, Gaurav Jain wrote:
> >> > key buffer is not copied in chachapoly_setkey function, results in
> >> > wrong output for encryption/decryption operation.
> >> >
> >> > fix this by memcpy the key in caam_ctx key arrary
> Not sure, but do you mean array*?
>=20
> >> >
> >> > Fixes: d6bbd4eea243 ("crypto: caam/jr - add support for Chacha20 +
> >> > Poly1305")
> >> > Signed-off-by: Gaurav Jain <gaurav.jain@nxp.com>
> >> > ---
> >> >  drivers/crypto/caam/caamalg.c | 3 ++-
> >> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >> >
> >> > diff --git a/drivers/crypto/caam/caamalg.c
> >> > b/drivers/crypto/caam/caamalg.c index eba2d750c3b0..066f08a3a040
> >> > 100644
> >> > --- a/drivers/crypto/caam/caamalg.c
> >> > +++ b/drivers/crypto/caam/caamalg.c
> >> > @@ -575,7 +575,8 @@ static int chachapoly_setkey(struct crypto_aead
> >> > *aead,
> >> const u8 *key,
> >> >       if (keylen !=3D CHACHA_KEY_SIZE + saltlen)
> >> >               return -EINVAL;
> >> >
> >> > -     ctx->cdata.key_virt =3D key;
> >> > +     memcpy(ctx->key, key, keylen);
> >> > +     ctx->cdata.key_virt =3D ctx->key;
> >> >       ctx->cdata.keylen =3D keylen - saltlen;
> >> >
> >>
> >> Huh, so this driver just ignored the key?  Is anyone using the
> >> ChaCha20Poly1305 support in this driver?  Based on this bug existing,
> >> that seems unlikely.  If that's the case, wouldn't it be better just
> >> to remove the ChaCha20Poly1305 support from this driver so that the co=
de
> doesn't need to be maintained?
> >
> > This algorithm is used in IPSEC and we are also going to use
> ChaCha20Poly1305 support for Kernel TLS.
> > Gaurav
> Does this mean IPSEC doesn't call setkey() or the key value was such that=
 it didn't
> affect even after failing to actually set the key?
Our test passed with older kernel versions, This issue was caught in testin=
g with the latest kernel version only.

Regards
Gaurav=20
>=20
> -Kamlesh
