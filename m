Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4DE7C879B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 16:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232077AbjJMOOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 10:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232107AbjJMOON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 10:14:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846A3BD
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 07:14:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97711C433C7;
        Fri, 13 Oct 2023 14:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697206452;
        bh=xiakfY2yzTf4fr07QKBhbaZia1Xj2Zm55HyF6h2uAk8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eie1oeb/SCDdqnrwYuRPCFdXKakAcbC4fy0M9ybafZEXiNV3IeqYb1gvNpDVkEE3j
         Www067T/upZIUOG9A+eM9To7syVYOSs6IcdGRvfc3pKtEc+j59snOOmCI0aXOfNwKw
         ZyRFGRH2Z8mb5jpMOW6oJzHZleZmD+fm4o+YkilcRholE/pm/IaGdRlhdQHoR/QSGh
         4myH/6Swbjp/PL20e8IlsuI7TyX+d5aF2KwlopT/Ue3kCUFTPznyoj544KT6s34ZM3
         2ekxKjK+RXQ+xVdq5kSQPHxNAe7g+iiZT13j0YJ3iFWj2WkcArLg8Jlx4Xgw2TGh+X
         lrjqV830Nn2IA==
Date:   Fri, 13 Oct 2023 15:14:08 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     wangweidong.a@awinic.com, lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        perex@perex.cz, tiwai@suse.com, herve.codina@bootlin.com,
        shumingf@realtek.com, rf@opensource.cirrus.com, arnd@arndb.de,
        13916275206@139.com, ryans.lee@analog.com,
        linus.walleij@linaro.org, ckeepax@opensource.cirrus.com,
        fido_max@inbox.ru, sebastian.reichel@collabora.com,
        colin.i.king@gmail.com, liweilei@awinic.com, trix@redhat.com,
        dan.carpenter@linaro.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V1 3/3] ASoC: codecs: Add aw88399 amplifier driver
Message-ID: <ZSlQsDzNXqyRVXAf@finisterre.sirena.org.uk>
References: <20231013104220.279953-1-wangweidong.a@awinic.com>
 <20231013104220.279953-4-wangweidong.a@awinic.com>
 <37a2d2d1-5ede-4f88-b4e7-d9750336465d@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/Bt6tNOD8qhkOtxB"
Content-Disposition: inline
In-Reply-To: <37a2d2d1-5ede-4f88-b4e7-d9750336465d@linaro.org>
X-Cookie: Save energy:  Drive a smaller shell.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/Bt6tNOD8qhkOtxB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 13, 2023 at 01:50:41PM +0200, Krzysztof Kozlowski wrote:
> On 13/10/2023 12:42, wangweidong.a@awinic.com wrote:

> > +static void aw88399_hw_reset(struct aw88399 *aw88399)
> > +{
> > +	if (aw88399->reset_gpio) {
> > +		gpiod_set_value_cansleep(aw88399->reset_gpio, 0);
> > +		usleep_range(AW88399_1000_US, AW88399_1000_US + 10);
> > +		gpiod_set_value_cansleep(aw88399->reset_gpio, 1);

> Why do you leave the device in reset state? I think you wanted these
> reverted.

I imagine practical systems aren't using the inversion that gpiolib can
do via the bindings, this is already the case for the other drivers
sharing the binding.  TBH the use for things like reset lines has always
seemed like it causes more confusion and error than it solves.

--/Bt6tNOD8qhkOtxB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUpULAACgkQJNaLcl1U
h9D31wf+LSw0mI4Eah0LGJWQfl5PpXcpkbD6bVg/ql2yS7Exi2pm5cMxMf5Thmhw
7Js/Io7XmJ+vFRJsDXRuEWdoLwvhpR/Tnaokvf6XEyEh5FA/vbvkMQae1aA0s9xy
1muspCbfG18y4N+lkzSzBL34kfuMZvUimK8e8VxCQqUdQK9hwvPeEkcA+Ujij+Mn
yhjBAuyHcR7/Mz8SM9Y+CU0rmca4QEtZQfHZvU9jKoRnEYJvX9c1LVdGjXrABPIi
cTY7xj33xVXMn496S2fG1eBwZUm38r1FWKzLW4dT8Yv1ncwETMkTJPPgEATFqvEh
5kWjYdboiDHre3ELXVH43f/6tiRpfQ==
=POXu
-----END PGP SIGNATURE-----

--/Bt6tNOD8qhkOtxB--
