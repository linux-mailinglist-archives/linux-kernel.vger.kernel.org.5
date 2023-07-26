Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D54E7763579
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 13:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234281AbjGZLmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 07:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234253AbjGZLlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 07:41:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5172526A6;
        Wed, 26 Jul 2023 04:41:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 31F5F61A82;
        Wed, 26 Jul 2023 11:41:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67CE1C433C8;
        Wed, 26 Jul 2023 11:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690371687;
        bh=VTDdGT3r9ibKW6CYrZ+3Bje3SsbXFVMe37SU5/r4En8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bGrrQiE6Ef5wQ0FMJEW0uUiimTk/QCui2R+5q/nPvm/MwBigVz1WJNVmzkOBad5le
         t8+dT5zVdcozA6AuQU4PB82jMH3hDsGA0FQvek0fMJYmGQV921ov/aufk1UoHwF7lG
         19Ag0ZMvrW9ZbqLdI8XeHWGb85rmEytQsOUgMuquYcOr4ffZvZ9h8s25+Sk4gKUODJ
         441M9Z153hAs30hICBbPEdhT2WZ5LT0cQVeHEYidUO3kvmjq+66rQ3Xh44SfPtOYqa
         RDqOFoylT6gWYnK3+z6qVmX4X1pJh0iFEAQ3oj/0rpAyMx2ecXdZu61l9oqdBLerm1
         uVX1XDJAfSmPQ==
Date:   Wed, 26 Jul 2023 12:41:22 +0100
From:   Mark Brown <broonie@kernel.org>
To:     like@awinic.com
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        liweilei@awinic.com, liangdong@awinic.com, wangweidong.a@awinic.com
Subject: Re: [PATCH V1 1/2] regulator: aw37503: add regulator driver for
 AWINIC AW37503
Message-ID: <812a3f8b-7d5d-42f2-aaf2-dcea18f6ffac@sirena.org.uk>
References: <20230726081612.586295-1-like@awinic.com>
 <20230726081612.586295-2-like@awinic.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kOJlPb1zijIUcQCJ"
Content-Disposition: inline
In-Reply-To: <20230726081612.586295-2-like@awinic.com>
X-Cookie: Life is the urge to ecstasy.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kOJlPb1zijIUcQCJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 26, 2023 at 08:16:11AM +0000, like@awinic.com wrote:

> @@ -191,5 +191,6 @@ obj-$(CONFIG_REGULATOR_WM831X) +=3D wm831x-ldo.o
>  obj-$(CONFIG_REGULATOR_WM8350) +=3D wm8350-regulator.o
>  obj-$(CONFIG_REGULATOR_WM8400) +=3D wm8400-regulator.o
>  obj-$(CONFIG_REGULATOR_WM8994) +=3D wm8994-regulator.o
> +obj-$(CONFIG_REGULATOR_AW37503) +=3D aw37503-regulator.o
> =20

Please keep the Kconfig and Makefile sorted.

> +static const struct regmap_config aw37503_regmap_config =3D {
> +	.reg_bits	=3D 8,
> +	.val_bits	=3D 8,
> +	.max_register	=3D AW37503_REG_WPRTEN,
> +	.cache_type	=3D REGCACHE_NONE,

No need to specify no cache, it's the default.

--kOJlPb1zijIUcQCJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTBBmEACgkQJNaLcl1U
h9CtHgf/XLvTa6zXGWT2G0meo/ozGbZMXVtzBEKx8AAPE3o1oo949mRWGv9C4MhH
u0lrb95b0/+pYWADuIJg0kdKZswPIBxNtb2lM5f1SCU/Eg5RDhr656wadQXKhNzt
IAjTHfPZeV8F9rOpN9gZlqmVvr/s496gyYFbM5aY8lMpPMRCyDoec6HR92lqd2bB
LQf4cnHP2BsfIq8BZy1PTGVnWO4t6FG0smOdpOn73EMAYF4/OPyM22/q8szcw1U6
xfjBKUS4NeIZlVsPPaA/yWWKuK+esEge+BkbFrPgDtQDyggJuuyiiQiVeJ4hPXbZ
RCd8+7Y5jjewFNofwhmtuvYUquASfg==
=RIjV
-----END PGP SIGNATURE-----

--kOJlPb1zijIUcQCJ--
