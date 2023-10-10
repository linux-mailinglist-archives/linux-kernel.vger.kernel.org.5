Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF6177BF408
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 09:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442450AbjJJHWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 03:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442394AbjJJHWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 03:22:48 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C00299
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 00:22:47 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qq74Y-0004Vx-Lb; Tue, 10 Oct 2023 09:22:30 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qq74W-000baT-4n; Tue, 10 Oct 2023 09:22:28 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qq74V-00CuZz-RW; Tue, 10 Oct 2023 09:22:27 +0200
Date:   Tue, 10 Oct 2023 09:22:27 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Rob Clark <robdclark@gmail.com>, Sean Paul <seanpaul@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Airlie <airlied@redhat.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Rob Clark <robdclark@chromium.org>,
        DRI <dri-devel@lists.freedesktop.org>
Subject: Re: linux-next: manual merge of the drm-msm tree with the mm, drm
 trees
Message-ID: <20231010072227.xgn3ks33t3jb34fi@pengutronix.de>
References: <20231010123345.12bfda28@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xkltfvwkholwnjix"
Content-Disposition: inline
In-Reply-To: <20231010123345.12bfda28@canb.auug.org.au>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xkltfvwkholwnjix
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Stephen,

On Tue, Oct 10, 2023 at 12:33:45PM +1100, Stephen Rothwell wrote:
> Today's linux-next merge of the drm-msm tree got conflicts in:
>=20
>   drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
>   drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c
>   drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
>   drivers/gpu/drm/msm/msm_drv.c
>=20
> between commits:
>=20
>   01790d5e372f ("drm/msm: Convert to platform remove callback returning v=
oid")
>   cd61a76c210a ("drm/msm: dynamically allocate the drm-msm_gem shrinker")
>=20
> from the mm, drm trees and commits:
>=20
>   283add3e6405 ("drm/msm: remove shutdown callback from msm_platform_driv=
er")
>   506efcba3129 ("drm/msm: carve out KMS code from msm_drv.c")
>=20
> from the drm-msm tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

FTR: The conflict resolution looks right to me. Thanks!

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--xkltfvwkholwnjix
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmUk+60ACgkQj4D7WH0S
/k7XKQf/YLUwwnZwhtvl+liyuolmjo8vXDx8jO3UyBcjIbuXoIs+/vnlS6j2AKPb
ref+vEdgEFLZnFlT5gzW/giWqhZa7qw8s5X9XnjZe/7pkNKon+IEdmlHWDm6ZZwg
pNbhusJHDg/M/XYh3QGBPaAWRbSE2P1S1MLbN2+mCsm1tyQx+m7v0LSg6aDP2PNB
W/06+fbGPPu5h8eIs6eXVl0DS8584bkIArn7m5M1CHkKxMe71Oda21WU0ll2SU/k
GSC2h5vxevBV+hIT9TdawssFs/AlRS9hN7rPhp5z8DCssRG3UIVzFm1jAR8VLPWS
PU9RKkokfna3YsxQ7sabDmvqXFjHzQ==
=RtTU
-----END PGP SIGNATURE-----

--xkltfvwkholwnjix--
