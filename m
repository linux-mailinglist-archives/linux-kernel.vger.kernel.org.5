Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 744FE762BBD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 08:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231955AbjGZGnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 02:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbjGZGnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 02:43:15 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2050.outbound.protection.outlook.com [40.107.7.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45AB91990;
        Tue, 25 Jul 2023 23:43:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CTAJNiXdwjmwT4iZ4Y8G/4tRbAkjpESEqHYok+936p6rQ6WXWfDirUym2/vXMZc2fjMdT1vUr/8HeGRjye2buTdrGDuQQe5BgaMHXL8Up+qdLcPEp3FJEretjWcfAsK+Q1Iohfifj8s/Uot0chN2+RucIBs1Zy6dLYxtzm0jb/rBpDbkoKwvW9c5/LppbtUnOOw57+xrLdliHVVASnrvHKeNsljsaM0FneZBj3kccBSpBGOGVIExnKc7i7LgtXtZeJ6dIl0o8In9rJgUf7+o66zAxMtIH24e5o2DwQOgeDi6tptxsIJhdAoFUiOxnLC32EZMjxNthA3a4k1PwanuCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SFxZzerGWORnz+ejTZSGaoVASAbA/2WXkcjaMSjn0PI=;
 b=KKMpeP6Gbz13+Rk4G4oO+RIV9x3cCnRV5oeoMZ3FI7fkWtXc9qcP4P1Y+BovIsMTYU3uZqdx/C0PEt7ZO2D4I3ngDFpRJWaSuHghfXtFhXU0qDQ2UGR4TfLRsDqtgFKWppg/9oJITAVYpOOisNFfgJyIB3BxQnZU9W/QNucmOCq5dl5YZpCvfAJMJuL1ZVey9hbRwdSEJ1T1yxtbK0M+DCaFTQ7lWnBa7zbYECZkWlLQgkBLef8uGg/uMk1ExcsIq7y5DZhDhrYppxgclbFSoVzy6A8oAOM5QdKn+9N8PwX3PrizGDbTBCgAi+yIHhgEe4xBuNe5dCkC037LrjF7vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SFxZzerGWORnz+ejTZSGaoVASAbA/2WXkcjaMSjn0PI=;
 b=KL97YVfu3QZn1FsCDJ6BoiWxgXp4aD6AEvT7c0BG3GHDgNeWem2dsNy2qBug0nvW6hOzElGcGJbNTqfS4iux1s4mrXB0ZDRzKRBaNeRhvwxmzgKZJUDkMTVwTpwDip4wO3iH+4+cnV9jWlfpK0c4w/hr3XLaUW2in7UnEEdeclw=
Received: from AM0PR04MB6004.eurprd04.prod.outlook.com (2603:10a6:208:11a::11)
 by DBBPR04MB7690.eurprd04.prod.outlook.com (2603:10a6:10:200::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Wed, 26 Jul
 2023 06:43:11 +0000
Received: from AM0PR04MB6004.eurprd04.prod.outlook.com
 ([fe80::1f66:d471:b7c7:d5fa]) by AM0PR04MB6004.eurprd04.prod.outlook.com
 ([fe80::1f66:d471:b7c7:d5fa%4]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 06:43:11 +0000
From:   Gaurav Jain <gaurav.jain@nxp.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Horia Geanta <horia.geanta@nxp.com>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        Varun Sethi <V.Sethi@nxp.com>,
        Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
Subject: RE: [EXT] [PATCH 1/2] crypto: caam - Use struct_size()
Thread-Topic: [EXT] [PATCH 1/2] crypto: caam - Use struct_size()
Thread-Index: AQHZvKxg0y8V3lVpt0ucX8crmzCx6K/Ln29g
Date:   Wed, 26 Jul 2023 06:43:11 +0000
Message-ID: <AM0PR04MB6004DF37314E8BF3812BC99CE700A@AM0PR04MB6004.eurprd04.prod.outlook.com>
References: <0fc02b533bd3c3422bec5856bc65bbb66ebf7b58.1690037578.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <0fc02b533bd3c3422bec5856bc65bbb66ebf7b58.1690037578.git.christophe.jaillet@wanadoo.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR04MB6004:EE_|DBBPR04MB7690:EE_
x-ms-office365-filtering-correlation-id: ecb7202c-5c15-4465-29c0-08db8da39494
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uxTZpUjBhlHwFUZ4CT050E5JyQy9BoNWdiKAtf2HpemxQDpxbfg5HeUqOuZoo+aVAW+mqD3XisSV+BNnc014zpC2BqlgPw1N0esdOVuitt5r4PmutKORgqhPjwgmweVufUBwDN/00qHdLdAlC5tLJOKSOElARedom7fvXY48fE5T9oIYyog5XDh857hXoPCGmQZ8fzcTmdGZexWJ+HZG/esmuhm4oVQXE8x4sb1fab5+L4eTQhAfZq3SdcTbeabqZ+5pv4LZLrshPuBDvlEzlDFj8hZ6fyEjWMCEQzuF4Y6Kwhg7mREGRXSXqYrQbzbK6Up3K2PqOnwLzLyFltHVQgPuhZ0WL/d9cRl1x4N0JkGNwVW1SP3/19wNJ5EImVMoegzqJECjb4bI+HXoKZb2J7fqPMxhlMHaGDpSaOk3rBt15tRo40DbW9TcLc7YPB+1WHbWWMFHhvryjdz3CzUvP40NGomQR/B5IX6OADmisskekpIc8MgEqiEYddaJSMk0kU3+ZhVGWQ/9fq5GWwTE1ymREILBWGAXWNMe4euQcVhPP4KDlMBG+GR4nbTwZEw0wtmh7DJjcfhol69eHU+PtxWSvwK0tvp81MfKtlxHBo6KnBVQam3ZvZDoNH6vY9y/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6004.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(136003)(396003)(376002)(39860400002)(451199021)(2906002)(41300700001)(316002)(44832011)(38070700005)(52536014)(5660300002)(8676002)(8936002)(33656002)(55016003)(86362001)(9686003)(26005)(6506007)(53546011)(55236004)(478600001)(7696005)(71200400001)(83380400001)(186003)(38100700002)(4326008)(66946007)(64756008)(66446008)(66476007)(66556008)(76116006)(122000001)(110136005)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KbiVEK//p/wODcX6bdFS6jXfatL48mk6nbq4emU0I8AvFgHqWdGRRjTEWzZx?=
 =?us-ascii?Q?SzEtcOyjq7G0Sc4JuGD/7u9rhPrBVKdLWa7KJ686Ucsi/yY31ec9lTxcGZl7?=
 =?us-ascii?Q?ymEzvLtfL8LAyHaFPst4yuN+Gbd1O9BzVS/y3+EnOfKX42KF1WQ01xEVSzgg?=
 =?us-ascii?Q?byhCWuseI4MyVcfgby6XSy0Q+HU+pZ3/Z3DLr+bx90JMSnwvfQ1DCCnObcOg?=
 =?us-ascii?Q?Jt1MOX8kxge4TrGyzhI+e35JdNW6YrrR5RTcJWTFV/ZSSKY2ZQkxon7lgMP2?=
 =?us-ascii?Q?giYezSM02wv1Z4VQUEuMbt0u48QAcXhefwa5U9y83vmd+tZLzb1DlNq2/Ocd?=
 =?us-ascii?Q?1tNa0K65Wz4hI/HALaTCriCPmoQPu1jZZ10flZvUp7DkEQKBjWDNfkw1/e2l?=
 =?us-ascii?Q?eau+WweZ8SMKIQ2udHUBrfRwuL3RMO5Uf0/5NRY1H2m5XCUrb+uYPbX9f6Vd?=
 =?us-ascii?Q?EcKkQECvdGwY3Bu5m4eRCJXEedDBJM03/xCYmKSa7cNtEdS0pSkRp9A6wJNE?=
 =?us-ascii?Q?jdab95FBpC+eI0baJjbmieXuIznuPT6us41WEeYk51F7lG3xrTg2Swjb6ITK?=
 =?us-ascii?Q?dRPYfntteMajXlHDd8lAoXxJw8z8zHR3XyMwgVSEYdNNlEPNn0iutWoZxxeY?=
 =?us-ascii?Q?l1aKRJPeB079C/I1kQXUbz+/kB2VOt4CQPSc3EYKxwPquVWIkMNP0ZOF7t88?=
 =?us-ascii?Q?zbLqzpWNkqE13rrbwk5ewY8qmZUvDR2syVZ4qduE7IX5kCdN6f4zWQ88rZDg?=
 =?us-ascii?Q?pUM2zi88CwJFF7Hky6hGmuqsVCEOMtY4wh1U/xHQy1Iby0gS/tdsTNsbgcCT?=
 =?us-ascii?Q?nyQE6LomGQAp4jBs4hb+zPZvVoZBes7PRltF2K1yaU3VaovWMisU7Rzeg2oi?=
 =?us-ascii?Q?6NJ8EABfPHLVCm+CBaiPR8MiBs2EjJnTyBt3q2BTzmJAMBUhQWCq6Vvgd/2r?=
 =?us-ascii?Q?uy3ebcDTupxysLq3tqFkQA9I+RGQrw99Yche0rUfzL7bUsoZzH3yTZHBgPCz?=
 =?us-ascii?Q?IfcJcP3PnKv3N7ZjGi6dnv92UtW4eYkGNLDbXUGWX9DG13GORnbRiYnvJLvy?=
 =?us-ascii?Q?18YAGLRhbOgsYlTM3jDr3DNNNT+Cx2V320ETWYQhEDINTPdrr4t1E/FaGEZs?=
 =?us-ascii?Q?QO+loFJNCilC3iUksVPJOcRKf4EJijSrx9yvhVI+UtkVmcdtaGW84ps/EhU2?=
 =?us-ascii?Q?nM+5j5EXzqnI5UGouO3F2KFNQVnQsnaF5NLlShvR1BuOiXuPrl5/mli172hg?=
 =?us-ascii?Q?ZDOuNBD142pLntBTyGkO7o32GPom46RwcEtPECBA2iX6kGTITj2A2oqNaCGX?=
 =?us-ascii?Q?xGGaDo8zBFFt6BOJcBnFJV4rxctXEaE35zxly24lU3WdeeTZ3hLGTc4OjA75?=
 =?us-ascii?Q?HGhsrKnrjiHFT8rB+2J7UGzxuyp2vaFMxCsgs85lL67fgaJ2r5u3R0T/jTdu?=
 =?us-ascii?Q?FtGMfFxOE44Mu3dOxuRgCwIm3aUjBVbBpas3ObZGVCMUh8ANpJhHnMJk3SQf?=
 =?us-ascii?Q?u2SHu2gbHHZxyJ5h8TX8TwqWDK2RyfQeJoV+/UKLRADXz255d85ZIMmVryDA?=
 =?us-ascii?Q?ZQ0VQgPf4SYO0pB9/mSlJIgpIwO34KZSCeuMW7Ua?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6004.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecb7202c-5c15-4465-29c0-08db8da39494
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2023 06:43:11.4922
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YbzQKmdXl2aFjMK2se6nhbXhpDKmwKigYul1vnx/2vCQKjtDy4Fi4ZZ5MmHX8s3CYwMKwfd2ZFTqNUYT3fHt4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7690
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Gaurav Jain <gaurav.jain@nxp.com>

> -----Original Message-----
> From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Sent: Saturday, July 22, 2023 8:24 PM
> To: Horia Geanta <horia.geanta@nxp.com>; Pankaj Gupta
> <pankaj.gupta@nxp.com>; Gaurav Jain <gaurav.jain@nxp.com>; Herbert Xu
> <herbert@gondor.apana.org.au>; David S. Miller <davem@davemloft.net>
> Cc: linux-kernel@vger.kernel.org; kernel-janitors@vger.kernel.org; Christ=
ophe
> JAILLET <christophe.jaillet@wanadoo.fr>; linux-crypto@vger.kernel.org
> Subject: [EXT] [PATCH 1/2] crypto: caam - Use struct_size()
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report =
this
> email' button
>=20
>=20
> Use struct_size() instead of hand-writing it, when allocating a structure=
 with a
> flex array.
>=20
> This is less verbose, more robust and more informative.
>=20
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/crypto/caam/caamhash.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/crypto/caam/caamhash.c b/drivers/crypto/caam/caamhas=
h.c
> index 80deb003f0a5..9e5924e24f2e 100644
> --- a/drivers/crypto/caam/caamhash.c
> +++ b/drivers/crypto/caam/caamhash.c
> @@ -708,9 +708,8 @@ static struct ahash_edesc *ahash_edesc_alloc(struct
> ahash_request *req,
>         gfp_t flags =3D (req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP) ?
>                        GFP_KERNEL : GFP_ATOMIC;
>         struct ahash_edesc *edesc;
> -       unsigned int sg_size =3D sg_num * sizeof(struct sec4_sg_entry);
>=20
> -       edesc =3D kzalloc(sizeof(*edesc) + sg_size, flags);
> +       edesc =3D kzalloc(struct_size(edesc, sec4_sg, sg_num), flags);
>         if (!edesc) {
>                 dev_err(ctx->jrdev, "could not allocate extended descript=
or\n");
>                 return NULL;
> --
> 2.34.1

