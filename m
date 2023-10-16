Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9787CA74D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 13:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbjJPL6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 07:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjJPL6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 07:58:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D7DCDC
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 04:58:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C462C433C7;
        Mon, 16 Oct 2023 11:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697457509;
        bh=EESOofAGoz0NJ85srEifh5w8COAeKPVtpl6yq3ANTCE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y31U7l5iU6fQUg3L0jXo9GwzTkJDEY+e2mdZcP5NqGiN1lrL/pVj6A2L/uNPuv0UO
         zbTU40Kt3ftbIJLn7L2xbKjOcnMj0k0p+nkZQhwnMSIWv7V2V2NK/zcO8gJt4j3daD
         wbpxUiMFsnD/AcQD4gszG99sEeXVRlzgE609wIHz3vo16LwRx55KJhS4gS4oJ+Mi4k
         2el9EK0gyKARui7sUQXrl60X10sfAxFR83haLmSbZOeksFMbDQVtd3Cx/q/mVmTQV7
         7G0u95GkvqOYaeC6oUCZCy+81zFMPF7n6i5rX82N5FRLr1TiOaPjW04mqEB3XevyIE
         JInxUqv450MXg==
Date:   Mon, 16 Oct 2023 12:58:21 +0100
From:   Mark Brown <broonie@kernel.org>
To:     wangweidong.a@awinic.com
Cc:     13916275206@139.com, alsa-devel@alsa-project.org, arnd@arndb.de,
        ckeepax@opensource.cirrus.com, colin.i.king@gmail.com,
        conor+dt@kernel.org, dan.carpenter@linaro.org,
        devicetree@vger.kernel.org, fido_max@inbox.ru,
        herve.codina@bootlin.com, krzysztof.kozlowski+dt@linaro.org,
        lgirdwood@gmail.com, linus.walleij@linaro.org,
        linux-kernel@vger.kernel.org, liweilei@awinic.com, perex@perex.cz,
        rf@opensource.cirrus.com, robh+dt@kernel.org, ryans.lee@analog.com,
        sebastian.reichel@collabora.com, shumingf@realtek.com,
        tiwai@suse.com, trix@redhat.com, yijiangtao@awinic.com
Subject: Re: [PATCH V1 3/3] ASoC: codecs: Add aw88399 amplifier driver
Message-ID: <38cab9a5-4fdf-4b50-b4e0-6a63beacab11@sirena.org.uk>
References: <ZSlP8GvTAOe35peC@finisterre.sirena.org.uk>
 <20231016081017.46963-1-wangweidong.a@awinic.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="I2KqOEZVLNH8WqF7"
Content-Disposition: inline
In-Reply-To: <20231016081017.46963-1-wangweidong.a@awinic.com>
X-Cookie: If you're happy, you're successful.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--I2KqOEZVLNH8WqF7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 16, 2023 at 04:10:17PM +0800, wangweidong.a@awinic.com wrote:
> On Fri, Oct 13, 2023 at 03:10:56 PM +0100, broonie@kernel.org wrote:

> >> +static int aw_dev_dsp_update_container(struct aw_device *aw_dev,
> >> +			unsigned char *data, unsigned int len, unsigned short base)
> >> +{
> >> +	int i, ret;
> >> +
> >> +#ifdef AW88399_DSP_I2C_WRITES
> >> +	u32 tmp_len;

> > This looks like debug code which can hopefully be removed in favour of
> > the regmap implementation?

> Thank you very much, but this is not a debugging statement, This is designed
> to be compatible with different platforms that may not support continuous
> writing.

If this is needed for platform comaptibility then it needs to be
something selected at runtime, ideally regmap would be able to hide
whatever's going on but perhaps the register address loading complicates
things there.

--I2KqOEZVLNH8WqF7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUtJVwACgkQJNaLcl1U
h9DeUAf9GxJLIrDPtoBWNfziL7xDN8MMHR4vboUOGd/9/eMsg6et0MCSu+5QzwaZ
oTvhMCnN1w5fQjm182eLWMKbnZ/NeuwVfsgyqaGEuP8JW/2+Tct7ag8LEZadlpcz
fnPjeDA5YMMTeVeNplkojJmFfaJjLuggt7o6xwKp36/ZV6AJlhj29y+LK+snV8eL
77jQR75a+ZU2OYdy8GAUaN8HS4cv8ln6U0YcGxlNjrF+VLOqfy7d2abbdBYPRkis
arUpxgW+qXYLpR53CyZGQnbWGXMpWyEZBiIGWNXuxq+IFstrOTyIUp/K4FWJ5t2A
YBUyyUaSuiFQNQGYb2V3IaV2khuftg==
=tkTS
-----END PGP SIGNATURE-----

--I2KqOEZVLNH8WqF7--
