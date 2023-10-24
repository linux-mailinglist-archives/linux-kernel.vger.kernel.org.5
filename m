Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73F2E7D539D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 16:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343557AbjJXOFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 10:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234898AbjJXOEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 10:04:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECBC619AE
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 06:57:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6496CC433C8;
        Tue, 24 Oct 2023 13:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698155835;
        bh=Oyeshsu+3nlIQS5tap59rxnoqILKp80Kfvs4IZctQV8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d5N1S6c9YyOAV0iwXf6CX/0DsLAIne/tc7jISV3tbnn1Xg7BKibB8yah3532yZbYl
         LVP0884kUs5wV3VpfhmAE57jaykHRCLfmidjdDvu3S00VmJcymG2h5PECNrCeEgBCK
         t6KUcPYoTGAEr+x2l988NFVZ7HYVwsV6u76zjcG+AHDaO7HEJSjkd8JiBpNuN+nd3L
         9C6tsjtwpz4kP9yTUbjOS4qq7qzJ2maIYOpxkLyUn9NYAptAXWbegzRggyfpUO+6AN
         Pd/uEzLHSH3PO5D4tQmkyYYP68Bf/jsAFTOGiQrPKhUZz86hJAivWJMc9aq5qHWV53
         k2OzL9x53xXQQ==
Date:   Tue, 24 Oct 2023 14:57:03 +0100
From:   Mark Brown <broonie@kernel.org>
To:     wangweidong.a@awinic.com
Cc:     13916275206@139.com, ajye_huang@compal.corp-partner.google.com,
        alsa-devel@alsa-project.org, arnd@arndb.de,
        ckeepax@opensource.cirrus.com, colin.i.king@gmail.com,
        conor+dt@kernel.org, dan.carpenter@linaro.org,
        devicetree@vger.kernel.org, harshit.m.mogalapalli@oracle.com,
        herve.codina@bootlin.com, krzysztof.kozlowski+dt@linaro.org,
        lgirdwood@gmail.com, linus.walleij@linaro.org,
        linux-kernel@vger.kernel.org, liweilei@awinic.com, perex@perex.cz,
        rf@opensource.cirrus.com, robh+dt@kernel.org, ryans.lee@analog.com,
        sebastian.reichel@collabora.com, shumingf@realtek.com,
        tiwai@suse.com, trix@redhat.com, yijiangtao@awinic.com
Subject: Re: [PATCH V2 3/4] ASoC: codecs: Add code for bin parsing compatible
 with aw88399
Message-ID: <06c14b04-28df-4374-80e3-91e40bc53a84@sirena.org.uk>
References: <21bfa0bb-d936-402d-9ca9-6bcf181a0f35@sirena.org.uk>
 <20231024071929.88898-1-wangweidong.a@awinic.com>
 <27dd3dfb-7a40-4e26-b8c2-e432c30a0eea@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8pwjO5vU2sNKk1cW"
Content-Disposition: inline
In-Reply-To: <27dd3dfb-7a40-4e26-b8c2-e432c30a0eea@sirena.org.uk>
X-Cookie: 1 bulls, 3 cows.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8pwjO5vU2sNKk1cW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 24, 2023 at 01:42:13PM +0100, Mark Brown wrote:
> On Tue, Oct 24, 2023 at 03:19:28PM +0800, wangweidong.a@awinic.com wrote:
>=20
> > I generated the patch based on the mainline branch,=20
> > Why would there be a conflict? I know that I made a change to
> > this file when I committed aw87390 and that=20
> > the change was in the Linux-next branch, but the two=20
> > changes are in different parts of the file.
>=20
> I don't know off hand, I didn't check in detail.  It's possible someone
> else sent a fix that's been applied and is causing the issue - if you
> check out my branch and try to apply the patches hopefully you can
> figure out what the problem was.

diff --cc sound/soc/codecs/aw88395/aw88395_lib.c
index a0a429ca9768,bc72a7487048..000000000000
--- a/sound/soc/codecs/aw88395/aw88395_lib.c
+++ b/sound/soc/codecs/aw88395/aw88395_lib.c
@@@ -705,7 -703,8 +705,12 @@@ static int aw_dev_load_cfg_by_hdr(struc
 =20
  	switch (aw_dev->chip_id) {
  	case AW88395_CHIP_ID:
++<<<<<<< HEAD
 +		ret =3D aw88395_dev_cfg_get_valid_prof(aw_dev, all_prof_info);
++=3D=3D=3D=3D=3D=3D=3D
+ 	case AW88399_CHIP_ID:
+ 		ret =3D aw88395_dev_cfg_get_valid_prof(aw_dev, *all_prof_info);
++>>>>>>> ASoC: codecs: Add code for bin parsing compatible with aw88399
  		if (ret < 0)
  			goto exit;
  		break;

--8pwjO5vU2sNKk1cW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmU3zS4ACgkQJNaLcl1U
h9C84wf6A8/ybskNPO37rh5jdOHSRnk16Rpxur8QRnJuK/ZiwFJ5FNqhiV4xzTPQ
Smyf3ybs1qAdjjoOU9s5uE7t12mM1WToJKbLTh6zTK7C2spMskJ6kOE6504rIPsO
ENa1bBT0j82fhcr/5HlE0mEV+vC/OkO6QweaT49fKNZZvSeWBpWoarb1uek8BMQV
9tHl/F6wv69njL9oOpQebGK3Gi5HtU1B1RTou/5uYVjvS04z1tvsxhAxc50r9VsH
Czq/YM2o88Mu1CDZhFDdZLWpk+AZ9VoeywXrHs3K1VAmH2ybtf1v3TcW+kl1eLDE
sa2vbi1HvYROcxJqiCVJTOSMHL1g4A==
=gAPs
-----END PGP SIGNATURE-----

--8pwjO5vU2sNKk1cW--
