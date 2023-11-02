Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 025A17DF65B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 16:27:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234859AbjKBP0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 11:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234194AbjKBP0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 11:26:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7B99121;
        Thu,  2 Nov 2023 08:26:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B019C433C9;
        Thu,  2 Nov 2023 15:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698938801;
        bh=CLu2jh9OlzM/sGA794f8ZsBB8L94ScdqfEUVqcrrVuY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JbwrF7amZPORQN6XEePLyXfiiZ8ycC5AP0VuVxJw9NDsMuXC8LQTkbBxCQY6r90nO
         Y+anNtIn/BjOUCJOXluLD5XHtZcNHtqL0nMw874GYI/GKuDFAI7dyJCxiTbWIZT09s
         zVD2KEkoT3mriuzjQCICRHzeKizPqwVcItVs71NcBLXPc6arxXaqfhWRpZyCVQpu6p
         bKa6n9rCnSVfhhbsmmrah+lRCyKqtmOOHtl1FDHQYv/Z0HBnN6eh+RXyd6Zae1CGfL
         HUtqS0EpBndyQy1GtXAvccj0WXis8wCarS/oJt9tUVRjxGDRisnaVa9qBoYPTw7Tp1
         fiNJ8wWO6pmlw==
Date:   Thu, 2 Nov 2023 15:26:31 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Duje =?utf-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Leo Yan <leoy@marvell.com>,
        Zhangfei Gao <zhangfei.gao@marvell.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-hardening@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Karel Balej <balejk@matfyz.cz>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v7 06/10] ASoC: pxa: Suppress SSPA on ARM64
Message-ID: <dc7aaff0-f767-494e-9a3a-40fcacc1674e@sirena.org.uk>
References: <20231102152033.5511-1-duje.mihanovic@skole.hr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qOq/Mx9vNp7JTaIV"
Content-Disposition: inline
In-Reply-To: <20231102152033.5511-1-duje.mihanovic@skole.hr>
X-Cookie: A is for Apple.
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qOq/Mx9vNp7JTaIV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 02, 2023 at 04:20:29PM +0100, Duje Mihanovi=C4=87 wrote:
> The SSPA driver currently seems to generate ARM32 assembly, which causes
> build errors when building a kernel for an ARM64 ARCH_MMP platform.
>=20
> Fixes: fa375d42f0e5 ("ASoC: mmp: add sspa support")
> Reported-by: kernel test robot <lkp@intel.com>

>  	tristate "SoC Audio via MMP SSPA ports"
> -	depends on ARCH_MMP
> +	depends on ARCH_MMP && ARM

This isn't a fix for the existing code, AFAICT the issue here is that
ARCH_MMP is currently only available for arm and presumably something in
the rest of your series makes it available for arm64.  This would be a
prerequisite for that patch.

Please don't just insert random fixes tags just because you can.

--qOq/Mx9vNp7JTaIV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVDv6YACgkQJNaLcl1U
h9AOwQf/T1o3MmUT/AHCyzC1ybmn9jdutGNuOKe8pi9O3wXGrNVyx5Fkp1SK4nbc
62A11OUzAZ0h9HETpVH8AdVGBkxF2J+yKKBX+JuqvzuzEKm03uXRhUElJmqfU+nK
jDKPeW4JH7ebL94RYoy4P0IFywZIaS+PjdREKi5j5zTTvDKLxEVqppJPz30+UXz7
QRoVMkJmqK4HrvzznNuiuhBuz96tooQLS1dIVzrBmNJ5YEbbjeVpXHcUEv+YanOL
Qd6s2Onh6sZigqrrZlb5F2CIKw+AuHnLNL9XEyT2ZXyDY8ZdCF7ZgZ64acZz+39b
21kilHuZZYaEZTKdul8WvivXsPffgA==
=zsGC
-----END PGP SIGNATURE-----

--qOq/Mx9vNp7JTaIV--
