Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5137F1FF5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 23:07:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232398AbjKTWH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 17:07:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjKTWHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 17:07:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F4FC7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 14:07:22 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C49FBC433C7;
        Mon, 20 Nov 2023 22:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700518042;
        bh=VgevGQRE0DkW5gNXBJLRH1C9nvApnpFXwehmDOXU/q8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iU6FAGtPzvf4n9aM9W0QY4oudQh44SjSKBAI7GZnP37lx9b4Ur3Mj65H4PbTVlJe1
         K830TcCwVhF4na4SXXAjtuai+L+A4G0Z1VWcmlq7Rf5al1z2bgJiwIVL70UoAy60JP
         woqqwzLVJtmflPxfvt8pEjG9+CU6dhobQk6kSlU/BwIslM2g2r0yTlNK+lMPACTjuE
         SMPQGHtftu7E7I7YS2d/topBuO0JD4U+ptQ0vcLMCJUPTkZd4ECtI99oWD5qN1mrOF
         Em6PZDSrO8QmYMfZ0HBjZs5I19UKiw24kyVI9YIuY/WfdXmp8xYZmKtlBXOW1J85vA
         e4Go+Gv3eNASg==
Date:   Mon, 20 Nov 2023 22:07:15 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Chancel Liu <chancel.liu@nxp.com>
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
        nicoleotsuka@gmail.com, perex@perex.cz, tiwai@suse.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 2/2] ASoC: imx-rpmsg: Force codec power on in low
 power audio mode
Message-ID: <edd348ea-ef95-453a-9838-636769ab569f@sirena.org.uk>
References: <20231023020718.1276000-1-chancel.liu@nxp.com>
 <20231023020718.1276000-2-chancel.liu@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ys7+XtCcLmb6Czww"
Content-Disposition: inline
In-Reply-To: <20231023020718.1276000-2-chancel.liu@nxp.com>
X-Cookie: The meek don't want it.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ys7+XtCcLmb6Czww
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 23, 2023 at 10:07:18AM +0800, Chancel Liu wrote:
> Low power audio mode requires binding codec still power on while Acore
> enters into suspend so Mcore can continue playback music.
>=20
> ASoC machine driver acquires DAPM endpoints through reading
> "ignore-suspend-widgets" property from DT and then forces the path
> between these endpoints ignoring suspend.

This breaks an x86 allmodconfig build:

/build/stage/linux/sound/soc/fsl/imx-rpmsg.c: In function =E2=80=98imx_rpms=
g_late_probe=E2=80=99
:
/build/stage/linux/sound/soc/fsl/imx-rpmsg.c:60:46: error: implicit declara=
tion=20
of function =E2=80=98of_find_device_by_node=E2=80=99; did you mean =E2=80=
=98of_find_i2c_device_by_node=E2=80=99?
 [-Werror=3Dimplicit-function-declaration]
   60 |                                 codec_pdev =3D of_find_device_by_no=
de(code
c_np);
      |                                              ^~~~~~~~~~~~~~~~~~~~~~
      |                                              of_find_i2c_device_by_=
node
/build/stage/linux/sound/soc/fsl/imx-rpmsg.c:60:44: error: assignment to =
=E2=80=98struct
 platform_device *=E2=80=99 from =E2=80=98int=E2=80=99 makes pointer from i=
nteger without a cast [-Werro
r=3Dint-conversion]
   60 |                                 codec_pdev =3D of_find_device_by_no=
de(codec_np);
      |                                            ^
cc1: all warnings being treated as errors

--ys7+XtCcLmb6Czww
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVb2JIACgkQJNaLcl1U
h9D5Ygf/Ur0x116afGwToupSLPOlWheujkRjuYUrg95VQwQ3SkvnrgRzVCJ+GIst
9GzXEnzHorx+Vw4NzSNtzA5TF94TOOf+9GuRz5LQrl5hUJFhOnF0lz+0FGrXbXNE
yTD3a0tuYY7uSXyxFAZEszj3kHhUFZYg9SMAsJXVkpzej8rP7PiiJ2CyjnrkX0hY
lt6a8UmWNeNDaxS/8PMAXsraltapBbMjgxKYUCrbRXG8eRwZuKM1FBUyTkk5rER3
81ZfNxk2+8f5PDf9pX7mmjQXnPjDmumPU5HWn4Oz0cfEXeUG8xopxm50UwxLvhBk
Jj4TQkMAEWCmlRaVVi8MKepQqzhNig==
=sif7
-----END PGP SIGNATURE-----

--ys7+XtCcLmb6Czww--
