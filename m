Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6214C776B44
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 23:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232661AbjHIVwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 17:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjHIVwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 17:52:22 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2075.outbound.protection.outlook.com [40.107.22.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A09EE7F;
        Wed,  9 Aug 2023 14:52:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eWk7WKsdfh/IctSk3lwuW3lZlZWK9gyvkZB65MVGTTuMJHBRt/2LywncOlAyaSRXh4pXrpjiTwhj5jY7DiAUfLlgdlP7ZlvVlyZJksE9M7tmEEjK5zHjwb87pzP/W5iO/QB1ZWCmg1W86zzDDamR0aw6dxvaQ3IJ7KEAjtQuW9MbMXacJ8SiwnNpRBC8z+HM0KhUUkTZZIRYXXZyKqtx/OP6Z95j4AV2QypdpxMPVlm8Lr9OfvouKdOIhJfbg5IOFYBFRBQUmNkGdDVeAja6wJbV7hvI/+cuxTkUsq2L6Oc0fRK0/GA7r5DqixPtCAPyWgjZZflatG9dYbUFVLn28A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mkN/a+YxarwblJwYo0TBXAxEhdvFsSGWxqR8J9IGVhw=;
 b=bMc4Uco1SRegg+swx6nde9osH2ijmJIa+10Hgu8HeELgJzccjOqwweaiGSAFI7+T+B5eXT1WLMJ/LfTVgvNKbXUyqQx/3S86cAEFqrig1VMS8tobXVG7jQN6Uwwmh6bKCx1LQIlaWrSGQHuJqnUCgjw1RLdxhAr//CTBSkqs3d6vMcedO9HEt2w7Topiet9bEc90AX73+XZ+wrWqhfGgEz02METubZ5j47IOgUtBDxgUriKYo4G5TG+ALSggi4Y3OWSAu2YOtUuSyKrWgtMxXM0BkUno+HnInqNJ2mB4NZBgZD8SrSeJnHc4zXJMlwhJG+WlUABRQr1fz84jst86+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mkN/a+YxarwblJwYo0TBXAxEhdvFsSGWxqR8J9IGVhw=;
 b=dKSeUF3Tb+gyHkExxBamLIiVCQkDY8/8eUl0WF506q7FaU5TwyEGrSDHWmbc52iXAw+LKNom7NvtfamUg4tJpKQQn111Lq8+m3lNQ+ln4BlNlnTx8RKI+ImuhG2ZpF4/gZNa04JYwNfmNt9VBU20iMI0Mf2GDP3tZNRfjXyfr9c=
Received: from AS4PR04MB9244.eurprd04.prod.outlook.com (2603:10a6:20b:4e3::9)
 by AM9PR04MB8729.eurprd04.prod.outlook.com (2603:10a6:20b:43c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Wed, 9 Aug
 2023 21:52:18 +0000
Received: from AS4PR04MB9244.eurprd04.prod.outlook.com
 ([fe80::64f5:2270:18e4:883a]) by AS4PR04MB9244.eurprd04.prod.outlook.com
 ([fe80::64f5:2270:18e4:883a%6]) with mapi id 15.20.6652.029; Wed, 9 Aug 2023
 21:52:18 +0000
From:   Mirela Rabulea <mirela.rabulea@nxp.com>
To:     Ruan Jinjie <ruanjinjie@huawei.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "laurent.pinchart@ideasonboard.com" 
        <laurent.pinchart@ideasonboard.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH -next] media: nxp: Remove redundant dev_err()
Thread-Topic: [PATCH -next] media: nxp: Remove redundant dev_err()
Thread-Index: AQHZywvETLV+48yXl0S/EZQMbgYN9A==
Date:   Wed, 9 Aug 2023 21:52:18 +0000
Message-ID: <AS4PR04MB92440C79E652C986413E88888F12A@AS4PR04MB9244.eurprd04.prod.outlook.com>
References: <20230727102154.2757410-1-ruanjinjie@huawei.com>
In-Reply-To: <20230727102154.2757410-1-ruanjinjie@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9244:EE_|AM9PR04MB8729:EE_
x-ms-office365-filtering-correlation-id: 3457a962-5f5b-4206-bb90-08db9922e6b8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EsUxunhWjYdZg6/+zWSczwr0p+gZSh+XQ9zuYEdNm5JWFuENE5rmHacGfPlkZF94BPPe6nnXCGlhqqIUUgiyo+qlZbWehD9KL9zx+kyZdutRXKMC8ceJxndEI/PqClEVo8q3sktCPJfIiwQ7U9nKG1lc7XeSlt2rO8aD4IL+9LxIPiOmYTfcl/ldrhzVDliAtG/dnun6vV+DqTQYwceSsbISs7VJeKxCEQq/oLSV7Zl83846JFk2dkHeHhvEWEsdBlxtbEt+Ujphve/tWPl4JR+fVPXLJsmy3+bUGbQRZRf2XcsSSo023md+fY6Tm3Ljn146uq5OMu51wwMtmKldcjP9YoS6QTh5x1XEmgsIw1F+7bpr3iU+bXV29GO+VE5wgbWD5Bsnw7UoUfyjoXDUmRRV1zR62tPG+dYZMRPJ+qdL2IOsBFsPCTjZRC1jIp36ZumZ7NkGKEOOXd+PmU3GLvJxUnPdXhiCOFcTT8ymttW/OCqYHVUICgnIWfmtRiUUATEY4g3RugBt7BEj/ZIH0pDZ5fkesTTMCdzx5Gth8mzIPDaPRC/oXWeQaCdKqN5uB/iV3d7ItLQnviT4KWTByoKUKAZd9ozZ5L5lx9QnJMcuHpo6SVNbV7FjvbNAnwliEVTVbhvkRS9g9pO2i0BOLQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9244.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(376002)(39860400002)(346002)(366004)(451199021)(1800799006)(186006)(921005)(7696005)(86362001)(478600001)(33656002)(110136005)(38100700002)(76116006)(66556008)(66946007)(64756008)(66446008)(66476007)(9686003)(122000001)(2906002)(52536014)(26005)(316002)(41300700001)(55236004)(6506007)(53546011)(55016003)(7416002)(83380400001)(71200400001)(5660300002)(8676002)(44832011)(38070700005)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tqpfWWZRBH1J8zDg8A6UT4KPWTQ0PesgR6LXL8Xc8hKiiMS4vlhiJz6ZiPsn?=
 =?us-ascii?Q?S8SfWamkIA8MbQxTYuJqIT1WWce3aKITJm3PWhW8lg46nEc22HhFd/6GO5qo?=
 =?us-ascii?Q?OcZdakIeacC81FN6BX7boNCfr0iDuzSDFo7kkljeCMboBAFzO8KAqJioLnRd?=
 =?us-ascii?Q?VHfMP3U0ASdkn8+MLb6+q6Ojmn8zBHc1OY9D5Hue5RVNDg2ey+wQ2wGJu+/8?=
 =?us-ascii?Q?MScKZr8Gbxuc8cu5HCQyAC7mT4/5y0O3UblyNru/lk+iefso+RO/TQrEEJdt?=
 =?us-ascii?Q?GjNIgZTmTzu5AGZApOm7k4D6Zw26RDKQdXzNhcz3YKizSQ15TzKEPbltrvp8?=
 =?us-ascii?Q?rWUsoaJ0c4qIsWsNuZLyIDQdsLBddu+Nt7BRrgQWJqXunhu4cyWRTL4TrmdJ?=
 =?us-ascii?Q?bBiFTxAOjLtQjDKyfoX50tC+XT+HrI31QsxsMR17r+worC33PrxkrH4Wker4?=
 =?us-ascii?Q?NJ5NioyvxmMmg+xQZOjRPV2qN9JInjDSBVoKBpFRSsH7LrUpOLXvjRgFk354?=
 =?us-ascii?Q?XfUnD3Ip3mVhscD9DP1pZQxpnKUep0i2alp1FJ0mfxfkUWihOvTTFHcjzxG7?=
 =?us-ascii?Q?9uYvvIJqDr0zGh/xTFEdXMzbiYESJBU7TgQ9kgp1YoTWmLu8e5wG8dBRLyXl?=
 =?us-ascii?Q?Ve+gGpZMrxoHBA+1YshBnZFoMTN6miups5iPDeQTnUhMJErhJSehOXdxLecX?=
 =?us-ascii?Q?JaIN1G2iumaFAQJQFbVSkv3QIpqzcffAg/0B+8H+UuElygNrQKotWCK9z/l8?=
 =?us-ascii?Q?G/xqixt1aHkBkVo4fUwhcXYLXU+X2zELeL7TV5fxItQG+hve4Ce4HsDM1OnZ?=
 =?us-ascii?Q?izuz2t+wwmMamH3MOfacntZppPseNWNomSHhHgmLYZq8kL7Bj5Yoxft/2Y7K?=
 =?us-ascii?Q?XCOgxLvWH4l9nN+o+mMVjSk5Nu0H7P0jVgrHV+rUhJQzxKs8ayH7Y+F/oUuD?=
 =?us-ascii?Q?kg4OeLMtmDaMsL48XkKxh5cRLYLLEJLVN+0YODtS3Xj7TRfLDH3veLqyBnzM?=
 =?us-ascii?Q?8aXSt24vc9cua3pKS9a39mrVpziBUmzfk0Yv5Y5dTChb5IlzOfF9yBJRRiZi?=
 =?us-ascii?Q?cBN8Bi0MKRlZR/tQ2zgFBZZEpy7IsQcr/KB4ANHTN4QkqtyqKBCdkdmbxuEt?=
 =?us-ascii?Q?0+MdmBVnBwtCzQi3mVrw1ogOdJrIpFhaC/lPQgK1t4x8noxp1GGG+wmiweI7?=
 =?us-ascii?Q?Pm+m9Cb7Pd0lq3uIiPd4ei2EOLKJ5CiOEOczVPt7c24Qp/+BdGTi7mx7mvj4?=
 =?us-ascii?Q?8kjhVq9HOqVqZlS4qRRUMwFRJTeHEYtVgd9PCNrUEbWT5MzSyq4Xq39ZnDyM?=
 =?us-ascii?Q?RZN3kRPj4ltL7RA0lqa0kSyxMCs1/ZXOloOEEC+a4+xdMW1COAYKhsaGJu0g?=
 =?us-ascii?Q?hZ1nG7xNS+ZkHsMCzN4S7Coyu6JUwyyUtLJZcVnZMGRQyTmkSPvClIgvdZqo?=
 =?us-ascii?Q?+jrxHA7M4oXNzi0pZc+A3ytWzN9Mv6YLRJrcF2AYTADvQkSF+KFSexrVEJJL?=
 =?us-ascii?Q?BIm4a+Xon+LgBNRkV8GAfH2SsdtsYi2TXcW0Gk6o7vQm2EbCg2uOg/HhJAjK?=
 =?us-ascii?Q?ZU7uKh593dUotZYC64WHft9JbKLOAUxJ9Du5W5mT?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9244.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3457a962-5f5b-4206-bb90-08db9922e6b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2023 21:52:18.1590
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mUz9mK6aEm1fsSqNd/68SqKDlMjQc2xSh2DltakKvREwxSQHNqVPLlQEEaZ0BkvMdgHnE9YHR5uQOt3gZwwD8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8729
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Ruan Jinjie <ruanjinjie@huawei.com>
> Sent: Thursday, July 27, 2023 1:22 PM
> To: Mirela Rabulea <mirela.rabulea@nxp.com>; dl-linux-imx <linux-
> imx@nxp.com>; mchehab@kernel.org; shawnguo@kernel.org;
> s.hauer@pengutronix.de; kernel@pengutronix.de; festevam@gmail.com;
> laurent.pinchart@ideasonboard.com; linux-arm-kernel@lists.infradead.org;
> linux-media@vger.kernel.org; linux-kernel@vger.kernel.org
> Cc: ruanjinjie@huawei.com
> Subject: [PATCH -next] media: nxp: Remove redundant dev_err()
>=20
> There is no need to call the dev_err() function directly to print a custo=
m message
> when handling an error from platform_get_irq() function as it is going to=
 display
> an appropriate error message in case of a failure.
>=20
> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>

Hi,
We have been using "media: imx-jpeg:" in the subject.
Other than that,
Reviewed-by: Mirela Rabulea <mirela.rabulea@nxp.com>

Regards,
Mirela

> ---
>  drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c      | 1 -
>  drivers/media/platform/nxp/imx8-isi/imx8-isi-pipe.c | 1 -
>  2 files changed, 2 deletions(-)
>=20
> diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
> b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
> index 9512c0a61966..b7a720198ce5 100644
> --- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
> +++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
> @@ -2742,7 +2742,6 @@ static int mxc_jpeg_probe(struct platform_device
> *pdev)
>         dev_info(&pdev->dev, "choose slot %d\n", jpeg->slot_data.slot);
>         dec_irq =3D platform_get_irq(pdev, 0);
>         if (dec_irq < 0) {
> -               dev_err(&pdev->dev, "Failed to get irq %d\n", dec_irq);
>                 ret =3D dec_irq;
>                 goto err_irq;
>         }
> diff --git a/drivers/media/platform/nxp/imx8-isi/imx8-isi-pipe.c
> b/drivers/media/platform/nxp/imx8-isi/imx8-isi-pipe.c
> index c4454aa1cb34..65d20e9bae69 100644
> --- a/drivers/media/platform/nxp/imx8-isi/imx8-isi-pipe.c
> +++ b/drivers/media/platform/nxp/imx8-isi/imx8-isi-pipe.c
> @@ -791,7 +791,6 @@ int mxc_isi_pipe_init(struct mxc_isi_dev *isi, unsign=
ed
> int id)
>=20
>         irq =3D platform_get_irq(to_platform_device(isi->dev), id);
>         if (irq < 0) {
> -               dev_err(pipe->isi->dev, "Failed to get IRQ (%d)\n", irq);
>                 ret =3D irq;
>                 goto error;
>         }
> --
> 2.34.1

