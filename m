Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2EC7AA921
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 08:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbjIVGea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 02:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjIVGe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 02:34:27 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2065.outbound.protection.outlook.com [40.107.21.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A01183;
        Thu, 21 Sep 2023 23:34:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S0FWTyyWuYve8iR61ruA+EoF9RybdDPwN0OczOGwhD/yIVVXaKIMF33IjSnoJbdm31x4jlBz4nTfGKZRn8XwjXm0ziUAWXyoPyQv1TeQcvsduPR0AiazL+0UnXATzRwd6bOHEQ82k9OPh1iYf0CPNlXl43OUnhn9t+pdB4G3FU6vv2bufWAtNOEFUUO/sUAnNI9TvPmfLlbC1kJwYbSKuHq9YD9Xs5I80x0PWbJoVtoQPKS8taVYneNbXoCetC7IaGSHKXcHzZLHO+bxGIR1FVK1JFJJ1KEf7bfSRZVyPPmTAQgoGEzIE5WbBigsxlWGf4d2MJ+5nV4MmIlafkLcGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1TRGbImo/22/MhIdJjXADlkEg77gGiozhW467XjOPl8=;
 b=NJMERplmsrxi29jR3hqHeLW41y1Ke+nBaMkdT2Xre9xnkqrn4cnGgue6JLP1exE9Yybi2Z/lQWD0ywD5p5dKJMGkNxzk19idtcNVg2bFJcQIGHbHvAHNTf98BYPtnpoEb40eza4ZF+50pUCO6QxsHhR0XNnyimtF4rdoD/IUWSRsI79UDZaeB9IGmjCmVqO78QzURE3ETr8QuzipwuyAeWdeRugjuRHwtysKUWDq8PAFv+hAHZXBiD/Tzw7UMSC1azfKmwTZ1iDgYyRt36NBGvChvUBKDBjIg1dQY4pzGOgIlAXgqLgUqOz8qK1jA5KbiXazHSpjppMgXf1Yt+XJAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1TRGbImo/22/MhIdJjXADlkEg77gGiozhW467XjOPl8=;
 b=kHm842UcppFaaoBHvrn7GCo+vf/q4/g7ke/uBMAIpW6rwz9XNFgjrXEU391BFj047QOQpnrFJfTxcz+T10HdbdAIGPderS031a7blbKc0lMTYUq+gUwzAY2e1YNjclQZTw9qMMZ56Wvw1dA0uk6M6ZK6eTwsdpfni4dRs5uYJr0=
Received: from AM0PR04MB6004.eurprd04.prod.outlook.com (2603:10a6:208:11a::11)
 by VI1PR04MB6815.eurprd04.prod.outlook.com (2603:10a6:803:130::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Fri, 22 Sep
 2023 06:34:17 +0000
Received: from AM0PR04MB6004.eurprd04.prod.outlook.com
 ([fe80::86b7:e0cc:dd24:12c0]) by AM0PR04MB6004.eurprd04.prod.outlook.com
 ([fe80::86b7:e0cc:dd24:12c0%7]) with mapi id 15.20.6813.017; Fri, 22 Sep 2023
 06:34:17 +0000
From:   Gaurav Jain <gaurav.jain@nxp.com>
To:     Eric Biggers <ebiggers@kernel.org>
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
Subject: RE: [EXT] Re: [PATCH] crypto: caam/jr - fix Chacha20 + Poly1305 self
 test failure
Thread-Topic: [EXT] Re: [PATCH] crypto: caam/jr - fix Chacha20 + Poly1305 self
 test failure
Thread-Index: AQHZ7Ikn5EtLvx/uSE+ZWTGko+Cjx7AmI14AgAA/4tA=
Date:   Fri, 22 Sep 2023 06:34:17 +0000
Message-ID: <AM0PR04MB60043F6A9B0BCED6BC1827CDE7FFA@AM0PR04MB6004.eurprd04.prod.outlook.com>
References: <20230921124237.2364827-1-gaurav.jain@nxp.com>
 <20230922024100.GA935@sol.localdomain>
In-Reply-To: <20230922024100.GA935@sol.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR04MB6004:EE_|VI1PR04MB6815:EE_
x-ms-office365-filtering-correlation-id: 5f877989-dce1-4dbf-170e-08dbbb35f20d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pVEe+zoa/e3iUVxVGdctCMwZIX9bwi34g1DFNRaWcfdbubJW51VV7q6GtvgweEmJdeC4GcMPHRkZJ2kTCR/FFmo6OzdksRP8zAX8pDBfYZuuU4LTdlUEQrRKz8oAyRW+P4YK5xNl4fnRPFy0lBLrlym/hrKLDb2jPL1EI9h8pwXjBLXeNhpd+wBKGtsP/7UYDNLsKlWJwaO3wWg8tNqSmRxoOlG4UgOUUJqKE45wvUyGVdnDbyFEG3BXZlhX2ymN7DsVoT8sUd9yQwOmngv9WqEhuExZX77BxkRebk8ZqV+1HFmeBEkBxavmoY4Tc1/IDE339t/hmKl9/vbXAHo2LKxtiJkurtTyVjZI50+9g0uGzZzq3ZgUQeLxfgAT1Spx+zLAi5cnF/2pHVlYiXgCDz9IPyvq1R0LzCqXgEiC7Y4sjlBDmjG3b1B37ByBDQ7wSSChW4xp94nSiJrm+AhxFNWNb7oLzFVM3X4BNLkS33FR7MzZpESyL5e5o1EnHF/lOK79ZHjn64jJzctyeX0SoSCHPAqfL/Mz3sfjaAs8zDO0QSyxrrMzAj8T/JGmn2gysOwFitDbP5eiqJGq3IOX/bGrVSDTLqfQekYB0HA7/gAm+DQ5H1pYUiK0KoXBuzJC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6004.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(366004)(39860400002)(136003)(376002)(186009)(1800799009)(451199024)(8936002)(4326008)(8676002)(44832011)(52536014)(5660300002)(316002)(83380400001)(26005)(55236004)(6506007)(7696005)(53546011)(9686003)(55016003)(66946007)(66556008)(6916009)(66476007)(66446008)(54906003)(64756008)(76116006)(38070700005)(38100700002)(122000001)(71200400001)(41300700001)(86362001)(2906002)(33656002)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Jo3ORqhyUz9UKb+Wl73i02yXkprJ5lZHFiqEwGkB3PfeQ+XiBg9wPByg+qyO?=
 =?us-ascii?Q?t+cGTNs9jScGh6b27Hw9ygCrqdJeu0wTtcR1K+im8qgmZGiQe8JXJYzPZG6L?=
 =?us-ascii?Q?D8IpnN3Zp2PN37Rs7nSDxspMNFJrCle/S9rFkK2LqvaTSuIKAkPAhoGxO4Rk?=
 =?us-ascii?Q?+3VxsH8mYkiidftBRrUU7NgUhveS2NaabCtEUeSwScfgeUo8t6J4tkC1+X6L?=
 =?us-ascii?Q?Rn47AC6+fdSDAHx3RoimBR9LTYLXUP81p6Ns0aEewFRhyGTBsRlt7y2Ecux0?=
 =?us-ascii?Q?EmDyh7mDggyRpUZ0mpXHBVeAPB/oK6EyQQGYfsv4cykxT705wa6yKwb338vP?=
 =?us-ascii?Q?UHUe7oevKY3izrJ2LYDO+Bs68EsuUgj9g3bP4ni6jw/hLUIRFQODOuYdXfK9?=
 =?us-ascii?Q?Zk+xLSZzW2Ms0q5LsTUqDHXHo+aeKOxqVMCf3fWM2tJ3+9Z+ChWNawQvU44c?=
 =?us-ascii?Q?9umiwbEysPYr+zqjQkGnuZme+KoBWHAQWcDp0AMC75+1NnKK0FAkkKrZOFlI?=
 =?us-ascii?Q?8SRhR4U5yctLOWDEsvH/dxCbbr0l+Uy/WF/l6Huaqt6AG9+uNJDWFreikD79?=
 =?us-ascii?Q?h2FhOV8rxF7MLb+vS3HSGEOYxx0sKnBfa0cTHLde+NqMrUABYLgsXisGV0z/?=
 =?us-ascii?Q?ZuE/GzsgGT4fyXY2xkrR/iNtIwK5le0ex0d1sOQhsu8vUcHz+G0zeSl3fgzD?=
 =?us-ascii?Q?j8xTpygP+m3CdbJIvYj9SKAm+SVN7qtZA9t6oWKrUJnGknoXIZtqac7zTJ3X?=
 =?us-ascii?Q?TPAk2wmCDaGJ7XH4liXcGFKvK0vD9f8jOnwmz4UtZbTR0YDVhofGIJ70wgsV?=
 =?us-ascii?Q?LPjlAsvKrvI6FZ2/oQcue/RmOUaqp6tBtA4DYl91YNgvCdAvrOLhI+bTWr7D?=
 =?us-ascii?Q?tZCgxzhFQq3BaT9fQGCz/6bvc92127kJqNXBrso+Jipk0snxgqu5/0XZ5g6W?=
 =?us-ascii?Q?7ImzMUjsi4rm5iC/scNJjm/2Kf/GX7uH+qe8yedvOLdIlfa/eeA9Zjvlx90B?=
 =?us-ascii?Q?rI0rx0tcGY6RJGisFVu2snVwCvH/IB9oxmM6t5PBpZGjEcieft3zRSuFUyya?=
 =?us-ascii?Q?Tz4rmqM+/9NBtXqZaeHH7XPr/3rJUB6CYATpyNyJhKxWor7+DBvfTR12fvQx?=
 =?us-ascii?Q?zE7CU/vR25NDJCqPNNE5BfxpVuSEyQTiR1fzW2D3zHx1bWebRYuUroiqCgku?=
 =?us-ascii?Q?87sUaqEdHSoW0AvOXrOa/SMOhuy/v6bpjr/lN0fsLLjR4AUMlz5otywyiOC1?=
 =?us-ascii?Q?S4K+AILNQjV4oOHS0yI+F5Y+ahx3JYQ6zXPijz3zBA3mM7mYA+vBklBGmDah?=
 =?us-ascii?Q?AIkzmHSVdmj1wVZdn7jrxD3v5wJeY0zsKEj5BchmvpLe6ql/Qc0x2oYPzjZE?=
 =?us-ascii?Q?3W0AKZfPk15NFOPRHpQk2N2fr+XGdBN8MtyIT7u3aK6lNgQBR4hhdnEXGclf?=
 =?us-ascii?Q?RtchKTelhOZkpXSuV2FrOOzesOSSpfvhBlin6fvoX5KMApqnE2wCVRvrxONt?=
 =?us-ascii?Q?Ecyq8KZNKtlouL7h2IAyU9fjNlGvt3VJNwwAXs5X93VE8aEes7SI77ImQ28P?=
 =?us-ascii?Q?oKILqLwUdyAvtIPxipGYzfO8A/yHyGVs46GE9wI7?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6004.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f877989-dce1-4dbf-170e-08dbbb35f20d
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2023 06:34:17.1221
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gOFEBn7lniW04GuJ59KEckR9gsJvYgRVd7DuNgcb5nS4UXRR/NreTF/K6Eo+R/BBCEOTqWY3WO8BF4xSNq2lZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6815
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric

> -----Original Message-----
> From: Eric Biggers <ebiggers@kernel.org>
> Sent: Friday, September 22, 2023 8:11 AM
> To: Gaurav Jain <gaurav.jain@nxp.com>
> Cc: Horia Geanta <horia.geanta@nxp.com>; Pankaj Gupta
> <pankaj.gupta@nxp.com>; Varun Sethi <V.Sethi@nxp.com>; Meenakshi
> Aggarwal <meenakshi.aggarwal@nxp.com>; Herbert Xu
> <herbert@gondor.apana.org.au>; David S . Miller <davem@davemloft.net>;
> Aisheng Dong <aisheng.dong@nxp.com>; Silvano Di Ninno
> <silvano.dininno@nxp.com>; linux-crypto@vger.kernel.org; linux-
> kernel@vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>
> Subject: [EXT] Re: [PATCH] crypto: caam/jr - fix Chacha20 + Poly1305 self=
 test
> failure
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report =
this
> email' button
>=20
>=20
> On Thu, Sep 21, 2023 at 06:12:37PM +0530, Gaurav Jain wrote:
> > key buffer is not copied in chachapoly_setkey function, results in
> > wrong output for encryption/decryption operation.
> >
> > fix this by memcpy the key in caam_ctx key arrary
> >
> > Fixes: d6bbd4eea243 ("crypto: caam/jr - add support for Chacha20 +
> > Poly1305")
> > Signed-off-by: Gaurav Jain <gaurav.jain@nxp.com>
> > ---
> >  drivers/crypto/caam/caamalg.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/crypto/caam/caamalg.c
> > b/drivers/crypto/caam/caamalg.c index eba2d750c3b0..066f08a3a040
> > 100644
> > --- a/drivers/crypto/caam/caamalg.c
> > +++ b/drivers/crypto/caam/caamalg.c
> > @@ -575,7 +575,8 @@ static int chachapoly_setkey(struct crypto_aead *ae=
ad,
> const u8 *key,
> >       if (keylen !=3D CHACHA_KEY_SIZE + saltlen)
> >               return -EINVAL;
> >
> > -     ctx->cdata.key_virt =3D key;
> > +     memcpy(ctx->key, key, keylen);
> > +     ctx->cdata.key_virt =3D ctx->key;
> >       ctx->cdata.keylen =3D keylen - saltlen;
> >
>=20
> Huh, so this driver just ignored the key?  Is anyone using the ChaCha20Po=
ly1305
> support in this driver?  Based on this bug existing, that seems unlikely.=
  If that's
> the case, wouldn't it be better just to remove the ChaCha20Poly1305 suppo=
rt
> from this driver so that the code doesn't need to be maintained?

This algorithm is used in IPSEC and we are also going to use ChaCha20Poly13=
05 support for Kernel TLS.
Gaurav
>=20
> - Eric
