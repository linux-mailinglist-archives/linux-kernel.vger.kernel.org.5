Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D177377B1A9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 08:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233775AbjHNGfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 02:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233454AbjHNGeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 02:34:36 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2086.outbound.protection.outlook.com [40.107.21.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA61CE58;
        Sun, 13 Aug 2023 23:34:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DPJE61Gce8koqHckj1jUuztiNebnck1yFKV+3cnO6hW+TQRhkVMELJrLmzu62bkyBo2eSVG0SbPh0mJ+diYCqbgVOlQOZaRYNIyZyyrcBWWkuch5Jt9FxSQp7CoMJ25k0Xps5D38Ag0j9jvJqK2hBfeK95onnrMWxFhRBkXi8tbRtGxisTznZoWrXwDLZ4sU2M15Xl9Qy8PM1AicPk/aKZU84cpy/1wDzP4gJ2NIqJv4yCjK8sscaPVH5zuVTMnUFj2LdzDHQrq8PXqkCLDDYaVc3oADvLzG4uuLzfF4RGXeACGywZYahz2MqDtxaA8im4s90m1FOMfM2yb1uTT1GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mf5ecAregnzDfLcRKJ2XfqG5khE980tRx9IBzrxSOec=;
 b=QKluAovytH7Q9E876zrpxR+Seinf17sfsXtPFZK+AqAMoUOdfsIxD6cDXlp+JqRwhi8zrxLCKqoHfXOUgvWcWBGMv0iyqrJEJXkgISWGw3iHWYbUPhuSPxbvrG6ZtsIKJ/xppXSsNNmzJsWD2eaXljdoIxLHySiMcGBUy6vvhwWLXN52V/9JCGKOeIz/UGxH3JEVFUpEAieYLAe5CKImGXI7rr3AergmoIfbAlbu6ogo1QNDl3cX7i/NGzaBAOXNUG5udIO/7iEJ4xSpfkMJ2vJwzATzy2ypB6Lw6SvbUoBBZLH3WyUwiyeDdI3cQfiojN59x6OkShjapA7T+m7ogg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mf5ecAregnzDfLcRKJ2XfqG5khE980tRx9IBzrxSOec=;
 b=lZIxShJZegNhJCoTm5X3OeK0Ij3t6k5ABmGbdUBGgIOwUlj9EqFGaM0W+d11CEDr2c4Tq/ssE6Sw+CfIUiaTkHZ8UFzzvRxxpD0ellN+b7nwTa+2f5HZTCv9XxWCDMFoCUXuOJjzcpbcAux3H5uBE3JGbiOer7R+yEPNoOtMgTQ=
Received: from AM0PR04MB6004.eurprd04.prod.outlook.com (2603:10a6:208:11a::11)
 by PAWPR04MB9912.eurprd04.prod.outlook.com (2603:10a6:102:387::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 06:34:31 +0000
Received: from AM0PR04MB6004.eurprd04.prod.outlook.com
 ([fe80::1392:7c78:1b43:769f]) by AM0PR04MB6004.eurprd04.prod.outlook.com
 ([fe80::1392:7c78:1b43:769f%4]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 06:34:31 +0000
From:   Gaurav Jain <gaurav.jain@nxp.com>
To:     Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
        Horia Geanta <horia.geanta@nxp.com>,
        Varun Sethi <V.Sethi@nxp.com>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] Revert "crypto: caam - optimize RNG sample size"
Thread-Topic: [PATCH] Revert "crypto: caam - optimize RNG sample size"
Thread-Index: AQHZznDIBwSjEcRofEak6+5SfWvbza/pVdOQ
Date:   Mon, 14 Aug 2023 06:34:30 +0000
Message-ID: <AM0PR04MB60046EC7FF56D13625223BC4E717A@AM0PR04MB6004.eurprd04.prod.outlook.com>
References: <20230814053239.608702-1-meenakshi.aggarwal@nxp.com>
In-Reply-To: <20230814053239.608702-1-meenakshi.aggarwal@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR04MB6004:EE_|PAWPR04MB9912:EE_
x-ms-office365-filtering-correlation-id: a7ab66ed-3f28-4d4a-3dad-08db9c908439
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1Ly8h7+CR1YO2XJn8nzpBhcm5DfgJ4vEUaTc9fQoYpxgANjcr/9GMQ/EzoWxEPnfrCBzPrBDAbhxuyD24nnyyHAfKL+EZpKLQFjS3gjJGa84BY3i8Yg9asmvQx5+D8nZzlbWc+FK1j5mIVMgryf10XOfLchRgb3y93HEwFYQj37tBjNmFs/zxQZGU48uOKzBKPZhD2ysZslwBg/TCIBrrBeAAyIq8jAFIbbZMqvpFy5qwFiHVFSbqw10DKiv6gIkXjS7tUFsP9fPitZIQmxwt/9QbNayYagbAWMsiqen/eD2Pg3t7voWCTY3Of5HqqNEH95gdvvxNnL79ANNYRFCETaVIBJPfFgjXWbRV8TC6fXy8W8VOzt+6Fh4lTltIzX2Kv7c2IwiZgU64wI+iqXLPpDG+3wd9BIGxAMX5qKDeNQ4+zjAYFHh4YLasY3qqcuj8g/Mb7g8Ges9mb7NAOUjyqSLIDA0J/9vPELUmE/tAMHsFd/DWlpq6t7KVrPEDlCZhWYnEBZ2UkfJgE+icGpmZ/OzjaL1yiQzrv/qYkOSTJDHkLUCQqiUfj7p0A9ctMsdXremoJHV8BsQul511aqFKNVa7ihwZghF7jLtU2XKliQzWM97zY1gnoFmS3G8LMOn
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6004.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(376002)(346002)(39860400002)(366004)(1800799006)(186006)(451199021)(478600001)(71200400001)(110136005)(76116006)(6506007)(7696005)(26005)(55236004)(53546011)(9686003)(66946007)(2906002)(55016003)(8936002)(8676002)(66446008)(66476007)(66556008)(64756008)(316002)(41300700001)(44832011)(52536014)(5660300002)(38100700002)(38070700005)(122000001)(86362001)(33656002)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?y6e1IQ7Fdc0Tg15O1ZCp8m4yF53ON7a90jlYhx1jbrokBdEENTpnCXo3K3TA?=
 =?us-ascii?Q?5Ffej51Dd9gtaL3pxRkPDm+8Venzbjn9gxZunfiqCmzzY+0HcuKHYJVabof5?=
 =?us-ascii?Q?WX6bGVY2QS41w6SHacAtNE8ZwhUPf1si3kQnEXoIaGguGEDFnW0ShzYv05ca?=
 =?us-ascii?Q?g+rcf3LreTDGmlwZdhbaoiFpiPbGybwpp1gUYKXP+cOie1XtZ1IcGgoHXog8?=
 =?us-ascii?Q?OBucbNc0nd3tg1XrilHo6c2M+iO+M87/WyClbu+O2kkSbJ9dEOGPfErn0vez?=
 =?us-ascii?Q?hd0LBFa4wAx6yCet+bcD2bebVCajYE5WgtpwHnhhstL5bL9rFfUZT784sqJD?=
 =?us-ascii?Q?xmjC2CwbR3J2kaaTYPLQW0kh8bajad/fuaogaOmx7WC6rzXB609bes7hfSDJ?=
 =?us-ascii?Q?JZIrDM7tlGb9iHAGyE1QwYu9tuBrSNt+RNl0SM9p7kFZJHE8RMU4f74P//QY?=
 =?us-ascii?Q?D6X93qL2DKNGO8ysKUDK68J+cchmJbU6TpBBkwT2qTD251aMDC7y8ZazQE8p?=
 =?us-ascii?Q?Sn/8c6GzP5KcmfUXCYL2eYZCLMu1AJj7QvrJgHM5qK1OBbbkEBM4u441HKGB?=
 =?us-ascii?Q?U/Xt//GwdNXHFngdKLw7lAuMd7sbgZSIN20vnuBJ7HLa9u9NihaXiq1zh/j3?=
 =?us-ascii?Q?VwDBeANnkakZc26f6K+/Cv9Pf/zHzm/4bYVJ7uyAmR5GP95CHKHykiORuf2I?=
 =?us-ascii?Q?/21qzUFc9jf14W+t/Ar+7S84b1MBxRmh0dYWxwbnAt89XA0vUIVMYQxYUx11?=
 =?us-ascii?Q?ko1iviPJ0Vu7z97FKRnYhJOpgGp5vG5h+02iN3FFwssUbb5RLFJTJC/qWUeO?=
 =?us-ascii?Q?3DQsLhBFd9JKN8R9EyfT3OZgmKMSe8x1XdMSjnqR5iJPeygTlLG+DGMiPEuZ?=
 =?us-ascii?Q?2qUmdJNsT8eQM7rMhJLciRJqoUGv30e/tODyKSY8kENFj38m8nECps/bishG?=
 =?us-ascii?Q?5KDU6JvbWp2UHMj2i231VdU/0Qdgy6TDXFv2LCMNXQ4xwnswDJTNwwEHDuoZ?=
 =?us-ascii?Q?Qm/zwQB831uTxJpJyocbxUK33ALl0UCuomoEB/G14CmgWYWx/706Ef0XZk5u?=
 =?us-ascii?Q?1yArDNERDDJLeS6Wj+Pg0q4+x+WyyhAWJ8GsnkV1jUdbGmT81Y9nwcc7dyzC?=
 =?us-ascii?Q?GcZm2YPsFFGIgo3UJVeXKuiAmalmk1RGoGQPemKCx1zW6wASSWWgn9bmt4+S?=
 =?us-ascii?Q?Uw+pSGtKNAIFI1GGhU2FpNXj3jkJtHZwsR5QppMuIzgBwHH8MGZ1DOTrH/XT?=
 =?us-ascii?Q?evXh+W0Fg30TEO2MitpwkYXqpZOr1NCVifpS/+ly1Y5tIUB6KGtN0hGlYlc2?=
 =?us-ascii?Q?78YRB1/EBVE4lNi8ktnoKl+Fpy1g7sfcSM9ViS0dlefJXBg/VRH3EGs4/Bfp?=
 =?us-ascii?Q?a9FsncRi9BctCt8hlNRzEvw7rj5LD/hyTuEm6IOxHAqpLVuZXcRM0UVcx6E5?=
 =?us-ascii?Q?79dy8Kxz1oPXnr/D9xhHoXbtsLwwt7YyYUcyOvKVzBH/pPEOqaShaKAyrwWm?=
 =?us-ascii?Q?nyfxJclh4d48QWxWod3UI2kqX3J8IMQ21G0HSNNovRVMPshZ6AxdmjwaU0Qe?=
 =?us-ascii?Q?w2DO5vKmG+h3YL/RBmemWAfVElQjHrhV1k/JSLzI?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6004.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7ab66ed-3f28-4d4a-3dad-08db9c908439
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2023 06:34:31.0032
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vaL7scf69r6cBkOnjlQdO9W/Y3AttirPvLK1LI+kZMBlNZwYcUqeuDH4HTK9+Uirly1EtzLuhfbGIDnkSKrWdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9912
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Gaurav Jain <gaurav.jain@nxp.com>

> -----Original Message-----
> From: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
> Sent: Monday, August 14, 2023 11:03 AM
> To: Horia Geanta <horia.geanta@nxp.com>; Varun Sethi <V.Sethi@nxp.com>;
> Pankaj Gupta <pankaj.gupta@nxp.com>; Gaurav Jain <gaurav.jain@nxp.com>;
> herbert@gondor.apana.org.au; davem@davemloft.net; linux-
> crypto@vger.kernel.org; linux-kernel@vger.kernel.org
> Cc: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
> Subject: [PATCH] Revert "crypto: caam - optimize RNG sample size"
>=20
> From: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
>=20
> This reverts commit 1abc89661ad3cd18d8c6af5c2584bcc63df43bf2.
>=20
> Reverting the commit because of RNG instantiation failure observed on imx=
8mm
> board.
>=20
> Signed-off-by: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
> ---
>  drivers/crypto/caam/ctrl.c | 52 +++++++++++++++-----------------------
>  drivers/crypto/caam/regs.h | 14 ++--------
>  2 files changed, 22 insertions(+), 44 deletions(-)
>=20
> diff --git a/drivers/crypto/caam/ctrl.c b/drivers/crypto/caam/ctrl.c inde=
x
> ff9ddbbca377..ee6478eea933 100644
> --- a/drivers/crypto/caam/ctrl.c
> +++ b/drivers/crypto/caam/ctrl.c
> @@ -358,7 +358,7 @@ static void kick_trng(struct device *dev, int ent_del=
ay)
>  	struct caam_drv_private *ctrlpriv =3D dev_get_drvdata(dev);
>  	struct caam_ctrl __iomem *ctrl;
>  	struct rng4tst __iomem *r4tst;
> -	u32 val, rtsdctl;
> +	u32 val;
>=20
>  	ctrl =3D (struct caam_ctrl __iomem *)ctrlpriv->ctrl;
>  	r4tst =3D &ctrl->r4tst[0];
> @@ -374,38 +374,26 @@ static void kick_trng(struct device *dev, int ent_d=
elay)
>  	 * Performance-wise, it does not make sense to
>  	 * set the delay to a value that is lower
>  	 * than the last one that worked (i.e. the state handles
> -	 * were instantiated properly).
> +	 * were instantiated properly. Thus, instead of wasting
> +	 * time trying to set the values controlling the sample
> +	 * frequency, the function simply returns.
>  	 */
> -	rtsdctl =3D rd_reg32(&r4tst->rtsdctl);
> -	val =3D (rtsdctl & RTSDCTL_ENT_DLY_MASK) >> RTSDCTL_ENT_DLY_SHIFT;
> -	if (ent_delay > val) {
> -		val =3D ent_delay;
> -		/* min. freq. count, equal to 1/4 of the entropy sample length
> */
> -		wr_reg32(&r4tst->rtfrqmin, val >> 2);
> -		/* max. freq. count, equal to 16 times the entropy sample
> length */
> -		wr_reg32(&r4tst->rtfrqmax, val << 4);
> -	}
> -
> -	wr_reg32(&r4tst->rtsdctl, (val << RTSDCTL_ENT_DLY_SHIFT) |
> -		 RTSDCTL_SAMP_SIZE_VAL);
> -
> -	/*
> -	 * To avoid reprogramming the self-test parameters over and over again,
> -	 * use RTSDCTL[SAMP_SIZE] as an indicator.
> -	 */
> -	if ((rtsdctl & RTSDCTL_SAMP_SIZE_MASK) !=3D RTSDCTL_SAMP_SIZE_VAL)
> {
> -		wr_reg32(&r4tst->rtscmisc, (2 << 16) | 32);
> -		wr_reg32(&r4tst->rtpkrrng, 570);
> -		wr_reg32(&r4tst->rtpkrmax, 1600);
> -		wr_reg32(&r4tst->rtscml, (122 << 16) | 317);
> -		wr_reg32(&r4tst->rtscrl[0], (80 << 16) | 107);
> -		wr_reg32(&r4tst->rtscrl[1], (57 << 16) | 62);
> -		wr_reg32(&r4tst->rtscrl[2], (39 << 16) | 39);
> -		wr_reg32(&r4tst->rtscrl[3], (27 << 16) | 26);
> -		wr_reg32(&r4tst->rtscrl[4], (19 << 16) | 18);
> -		wr_reg32(&r4tst->rtscrl[5], (18 << 16) | 17);
> -	}
> -
> +	val =3D (rd_reg32(&r4tst->rtsdctl) & RTSDCTL_ENT_DLY_MASK)
> +	      >> RTSDCTL_ENT_DLY_SHIFT;
> +	if (ent_delay <=3D val)
> +		goto start_rng;
> +
> +	val =3D rd_reg32(&r4tst->rtsdctl);
> +	val =3D (val & ~RTSDCTL_ENT_DLY_MASK) |
> +	      (ent_delay << RTSDCTL_ENT_DLY_SHIFT);
> +	wr_reg32(&r4tst->rtsdctl, val);
> +	/* min. freq. count, equal to 1/4 of the entropy sample length */
> +	wr_reg32(&r4tst->rtfrqmin, ent_delay >> 2);
> +	/* max. freq. count, equal to 16 times the entropy sample length */
> +	wr_reg32(&r4tst->rtfrqmax, ent_delay << 4);
> +	/* read the control register */
> +	val =3D rd_reg32(&r4tst->rtmctl);
> +start_rng:
>  	/*
>  	 * select raw sampling in both entropy shifter
>  	 * and statistical checker; ; put RNG4 into run mode diff --git
> a/drivers/crypto/caam/regs.h b/drivers/crypto/caam/regs.h index
> 189e74c21f0c..66928f8a0c4b 100644
> --- a/drivers/crypto/caam/regs.h
> +++ b/drivers/crypto/caam/regs.h
> @@ -3,7 +3,7 @@
>   * CAAM hardware register-level view
>   *
>   * Copyright 2008-2011 Freescale Semiconductor, Inc.
> - * Copyright 2018, 2023 NXP
> + * Copyright 2018 NXP
>   */
>=20
>  #ifndef REGS_H
> @@ -523,8 +523,6 @@ struct rng4tst {
>  #define RTSDCTL_ENT_DLY_MASK (0xffff << RTSDCTL_ENT_DLY_SHIFT)
> #define RTSDCTL_ENT_DLY_MIN 3200  #define RTSDCTL_ENT_DLY_MAX 12800
> -#define RTSDCTL_SAMP_SIZE_MASK 0xffff -#define RTSDCTL_SAMP_SIZE_VAL
> 512
>  	u32 rtsdctl;		/* seed control register */
>  	union {
>  		u32 rtsblim;	/* PRGM=3D1: sparse bit limit register */
> @@ -536,15 +534,7 @@ struct rng4tst {
>  		u32 rtfrqmax;	/* PRGM=3D1: freq. count max. limit register */
>  		u32 rtfrqcnt;	/* PRGM=3D0: freq. count register */
>  	};
> -	union {
> -		u32 rtscmc;	/* statistical check run monobit count */
> -		u32 rtscml;	/* statistical check run monobit limit */
> -	};
> -	union {
> -		u32 rtscrc[6];	/* statistical check run length count */
> -		u32 rtscrl[6];	/* statistical check run length limit */
> -	};
> -	u32 rsvd1[33];
> +	u32 rsvd1[40];
>  #define RDSTA_SKVT 0x80000000
>  #define RDSTA_SKVN 0x40000000
>  #define RDSTA_PR0 BIT(4)
> --
> 2.25.1

