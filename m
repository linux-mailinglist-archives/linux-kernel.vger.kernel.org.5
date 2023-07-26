Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BFD0762D27
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 09:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbjGZHXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 03:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231484AbjGZHWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 03:22:37 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2082.outbound.protection.outlook.com [40.107.8.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F1602727;
        Wed, 26 Jul 2023 00:19:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bEmURD2mT0Z8i7CXTf+d9oxoAHn/KobNbZYHsOX5RmAzCOaLHuePgauM+10j198Qv9m2QkrEZrNomCclQtfn+fpcmcZxRR6r6Zp8PORHSXJV7xsRRLLZaNdZGe7zu88sP3ZukCCTupiWUNEPZK3mMJVcFnixXquyvypS+n/mxcY1acWaC7YzK1OB+DhWsDA6Nu15gsbEAnGvircVVPtrNNbY+v4+n73klpw8rpNQbr/RQZCLWfw8KDoYANhJvkpj7KHOD5ZPkNT3ENhnvFypNh96PlFlUzoYkA2rH+BYKyjcHx9A8Ks6P+CiPgp5ZWqkDPRhdJlw+GecESXigW7Buw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=37Btt6RTl7YGouJFZDYWJCN5NardLeu+QJRq0qWtCW8=;
 b=njhnKfDU7R0t3wKHI2wTkzqekoPvrokDH1HysNNcxsU6Zk4cqba97kvOQZRwyj+7UmkgbF7SMbZmCOBCL9bSxC9l5zUxxh+aowbRzjasks1hKKRiJ6bDHrEHz1Jt7y8UgfCSfMic/gml0zn7xIUPvvWCVzp2buUw498gzp0lHk5y0ejBLrP5tihrlXmRlhmGuAWAk7mJ5lUwaKDhVmItph9/HtZGXP4aSLd8bX6TnDdfY1NCMK7HbuqCEWvQqXuMwT7fUcULEuuwkX4krkGXNiq+f59MJFoYkpKxscUtEefzh+TDzs16E/xdsCcBKVM2MYPF2TJYTQXG9jfG45/irw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=37Btt6RTl7YGouJFZDYWJCN5NardLeu+QJRq0qWtCW8=;
 b=VyR48OZnDxgtN4nEGTnSA7Zu1DrZ3l6CxLlAwi8EWox+TLIa/4G5z/43EixLCjl9qUSBX0S6L+DQtJO3I6+PSJ4qNJ0SDgKXjt8Ms4Sgm8Avi74c59A5Z10hAPWOXOAgfrwcacJvWbPWe4VggwMDFNxxGZSi6FfFXJEuOtUEQD0=
Received: from AM0PR04MB6004.eurprd04.prod.outlook.com (2603:10a6:208:11a::11)
 by DB9PR04MB9332.eurprd04.prod.outlook.com (2603:10a6:10:36c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Wed, 26 Jul
 2023 07:19:22 +0000
Received: from AM0PR04MB6004.eurprd04.prod.outlook.com
 ([fe80::1f66:d471:b7c7:d5fa]) by AM0PR04MB6004.eurprd04.prod.outlook.com
 ([fe80::1f66:d471:b7c7:d5fa%4]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 07:19:22 +0000
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
Subject: RE: [EXT] [PATCH 2/2] crypto: caam - Remove messages related to
 memory allocation failure
Thread-Topic: [EXT] [PATCH 2/2] crypto: caam - Remove messages related to
 memory allocation failure
Thread-Index: AQHZvKxjNhox0V1lRkKXpMFNJ3jt0q/LqZMQ
Date:   Wed, 26 Jul 2023 07:19:22 +0000
Message-ID: <AM0PR04MB600469044CFEBDB31D730859E700A@AM0PR04MB6004.eurprd04.prod.outlook.com>
References: <0fc02b533bd3c3422bec5856bc65bbb66ebf7b58.1690037578.git.christophe.jaillet@wanadoo.fr>
 <b8859de12248852f661cb051ffad79166e8dfa47.1690037578.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <b8859de12248852f661cb051ffad79166e8dfa47.1690037578.git.christophe.jaillet@wanadoo.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR04MB6004:EE_|DB9PR04MB9332:EE_
x-ms-office365-filtering-correlation-id: 95d8b480-20ef-4e1c-ead5-08db8da8a265
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aWjuAP6j6KMtUwk+Pe0v6FvJd9ot/IPOgvH6wgd2A8LFGnwfOwyiMjGzGDYd/XxLhZkxuAPK6LbE/awsDx+SyZ/7QL2SH21sRtEXNtnlEDvNK97fBZ/b52UtzPrXq/wmNsm4dDosejz9kN60IwK7B0jShPGLBlZOk6yTe0nQFkfWKwz32OQaATk0VV1f/IF8Nr29Ow5t4oAP4RK4vTkD3kWZcq/x9NgUCRCPeSkwinZO2BkDtVrgwqWTWs/t/3wcwmvn3wciP5WwjK8oGHH3OspWQxeaCmIeC0agVoKyydJ0jPox5WHwk1DtVpMnO6Vv4CuuOcvDylg8MhHLJfy+FiyDdx9ne2uGPzBggZGPY9y11y2xrQoPbmm/8LXyoBZhMOUWbMnSCa65G8d9SjfPZdbSQG9SB9GdYLZ9GgK3mChV8APWug7ln0yKhm5j1wVl2hQFNGh/4QcYTcYEJtHtaXXZBRbrn4lXyEzq88uH24zMgdG22njp+GAJnfEV+vlQ74182r8Qy8v6Ceop0FhkQR61vfmj6+V6k8ZKhJHwFR5NemUagFPg4VCVMXRRLIfhaLbk7cjHMouEuOdFxsSuq3Of7m4otL+tiSqJcchP8d6bluJuKggidFc026Bw9DNu
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6004.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(39860400002)(366004)(396003)(136003)(451199021)(478600001)(110136005)(54906003)(86362001)(38100700002)(66476007)(66556008)(66946007)(76116006)(4326008)(316002)(122000001)(66446008)(64756008)(71200400001)(6506007)(38070700005)(26005)(186003)(55236004)(7696005)(9686003)(53546011)(5660300002)(52536014)(44832011)(8676002)(8936002)(33656002)(41300700001)(2906002)(55016003)(15650500001)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OZRUPaQytISCDZyZMfhjW8SRjjbgmddCLjBvpQk4jhkq+I8kP6yOh7ynyAL4?=
 =?us-ascii?Q?caV9a1X+uXcgylAWYeDk1w9AfBXvUqeO6rKOw7fqgBr2wE/Cc8wUxIYCBCkF?=
 =?us-ascii?Q?LRxOSKxd2t1/6QkaY6COBimbGvuK0cdeuL/335h8EzStu+xngB3GX1LtLMWO?=
 =?us-ascii?Q?/EtMBvh/ZnGe7cZNY4ZTYOr2JsTaL/QLMeNzFqu5eBrjGn0bej7nlZHz4qwC?=
 =?us-ascii?Q?7IqahIiHeEIXOW5+pTSsGxZKp9HIIx56k2z3q4O7eC79vb4A+ova8Kfj4Mbw?=
 =?us-ascii?Q?jWFLOEhtjAmTB+L2mLUBHbGOTs9dH8F999bJyW0hgFuqoZgK0ZxQ5vXVGwEN?=
 =?us-ascii?Q?jhs5LfC8df3jK2RQZFMH17a29prYoybM/xPGQXZz3Yx/+9zCVnHnpHBKWdDN?=
 =?us-ascii?Q?QChEPCqmEIdTbZK08hWTGdFe7h4v+QJMO7zkagyUYjSLAio6+t4nKj6Thwdr?=
 =?us-ascii?Q?xyDc0wbE3VWllZhYxIwpNSi+jozr6xOnfvW9YZUOohfkn5DCMKTF7OUMxnQa?=
 =?us-ascii?Q?HTKRjdT9IuF9tgdQUup6P5t8dvi3X1f+oUx/kKJvY3PeTjmH2tVZVdWHIOf9?=
 =?us-ascii?Q?hWXMdGLR4fsNH1yZNWTvTsKlDhvBjYi2NJajq0g+bEvQjdS/loIacIO2JM8+?=
 =?us-ascii?Q?eVPxNYCFh5xFh7F8XoHe4yKiJfa76p9VYYTO77dDoTkPcqcpWN4a80GK/6Sk?=
 =?us-ascii?Q?s61+sA+zklJaHw9Ftn/SSs/ELiZlCbXKhJiSJ9AfIbU5/Z0ci6DjFNgekb3D?=
 =?us-ascii?Q?TFkfSbkAwzthAtYBLsRNCqHdgaxzxiHXueqJi0Qsqd9HjVPzRf/N/TBMp72u?=
 =?us-ascii?Q?n5CY32upsXrBvtqRnB5y4RVBAUfscrYKgX8aEmLjc4Xid8xu4j3urIGDrqP7?=
 =?us-ascii?Q?An5sVlvfX++K4zccyAtrNeelj3dkBiDQ9qcbz7qy65o3Pr01iPGJcoeudHWc?=
 =?us-ascii?Q?MyueW4Cj7WXV2wqQ0NErPg8Wd6yjVLuKy2GJfGsD6mOLB3RwLXNr/O5hgZe/?=
 =?us-ascii?Q?GISlOko9bdwimyjYvPgHlBXlNsUBbXzFO3rZv+pAI+D9DjovQXDOV9ljTeNn?=
 =?us-ascii?Q?0yKwRLPibF+4U0vx8o4e1kQQttRAiAcDaJ7LJ56PblAPVF6SVngQiMFviKUV?=
 =?us-ascii?Q?ezpkJGR0LBB6dqqP4gnh5CNi8/BrjybDkfexAN7bi5YjlEXxhI3gyz8jCOxi?=
 =?us-ascii?Q?+qLRCqPUbJaFC98FeENEjVgDJeGBd4RL3YDN9rQqrjljg9EeNTbQS85+o2gG?=
 =?us-ascii?Q?yYQOMF8FUMuEkbHcaJFfuzj5xG5bmEEgY4TxZ2hVx6A8N2PSLyyB726X0pNh?=
 =?us-ascii?Q?X642LGZSJPsRdERA3rZu05+OJGlxXRLAKY+uZXKI1roVX2JqmKYWSIutRYvz?=
 =?us-ascii?Q?bLs2bnce5giDdL7e4by9PXN270Ng47lnCw0AiG3ITn3AGw4WAq8Fjf8vsGYI?=
 =?us-ascii?Q?Ue/t74WJipBMdg2QlWWILfhhBMdO5VNJdofjT7JSvs8uCq7u+fVRihqeQz2z?=
 =?us-ascii?Q?EDyDBg/WCGu2fwXXu0/m+81jHuE5UR90RaLvQLykmiK2K9BP6+6W+cPFpT5T?=
 =?us-ascii?Q?kFrDl1Sn20aokml9tAIlWUH724xYcDafRCZU707L?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6004.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95d8b480-20ef-4e1c-ead5-08db8da8a265
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2023 07:19:22.1526
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M8JA7TIt8PQRbei75fUWy9RP7GGTrciNGFX8KVUs1xdqYd+3OeX9p9rjUeO+Yko9p1cTj/vUJzZnt/3tc0+u/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9332
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
> Subject: [EXT] [PATCH 2/2] crypto: caam - Remove messages related to memo=
ry
> allocation failure
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report =
this
> email' button
>=20
>=20
> On memory allocation failure, the function calling stack is already logge=
d.
> So there is no need to explicitly log an extra message.
>=20
> Remove them, ans simplify some code accordingly.
>=20
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/crypto/caam/caamhash.c | 14 +++-----------
>  1 file changed, 3 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/crypto/caam/caamhash.c b/drivers/crypto/caam/caamhas=
h.c
> index 9e5924e24f2e..641c3afd59ca 100644
> --- a/drivers/crypto/caam/caamhash.c
> +++ b/drivers/crypto/caam/caamhash.c
> @@ -368,10 +368,8 @@ static int hash_digest_key(struct caam_hash_ctx *ctx=
,
> u32 *keylen, u8 *key,
>         int ret;
>=20
>         desc =3D kmalloc(CAAM_CMD_SZ * 8 + CAAM_PTR_SZ * 2, GFP_KERNEL);
> -       if (!desc) {
> -               dev_err(jrdev, "unable to allocate key input memory\n");
> +       if (!desc)
>                 return -ENOMEM;
> -       }
>=20
>         init_job_desc(desc, 0);
>=20
> @@ -702,18 +700,14 @@ static struct ahash_edesc *ahash_edesc_alloc(struct
> ahash_request *req,
>                                              int sg_num, u32 *sh_desc,
>                                              dma_addr_t sh_desc_dma)  {
> -       struct crypto_ahash *ahash =3D crypto_ahash_reqtfm(req);
> -       struct caam_hash_ctx *ctx =3D crypto_ahash_ctx_dma(ahash);
>         struct caam_hash_state *state =3D ahash_request_ctx_dma(req);
>         gfp_t flags =3D (req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP) ?
>                        GFP_KERNEL : GFP_ATOMIC;
>         struct ahash_edesc *edesc;
>=20
>         edesc =3D kzalloc(struct_size(edesc, sec4_sg, sg_num), flags);
> -       if (!edesc) {
> -               dev_err(ctx->jrdev, "could not allocate extended descript=
or\n");
> +       if (!edesc)
>                 return NULL;
> -       }
>=20
>         state->edesc =3D edesc;
>=20
> @@ -1908,10 +1902,8 @@ caam_hash_alloc(struct caam_hash_template
> *template,
>         struct crypto_alg *alg;
>=20
>         t_alg =3D kzalloc(sizeof(*t_alg), GFP_KERNEL);
> -       if (!t_alg) {
> -               pr_err("failed to allocate t_alg\n");
> +       if (!t_alg)
>                 return ERR_PTR(-ENOMEM);
> -       }
>=20
>         t_alg->ahash_alg =3D template->template_ahash;
>         halg =3D &t_alg->ahash_alg;
> --
> 2.34.1

