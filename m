Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63A0677F81B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 15:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351591AbjHQNy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 09:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351601AbjHQNyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 09:54:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 282812D63
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 06:54:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B1CD163ABB
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 13:54:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 111D7C433C7;
        Thu, 17 Aug 2023 13:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692280446;
        bh=jiLZu3feVopBbHwTn3M6yEwELhDb/pqchb/mgvuOouw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F91766kaLlQMcDguhHpnnnYD3ZRpREuRJ8SWY6aZLz+3c1dqoiuwtJ/bBcYpb+5f4
         22dqtIuqw3PK+/XDt1gDyK7Zq1Hq1a/oVqa1K4fbPKgGFTWqJlBP5fiVVlqpk0z4QI
         GmQ2zPeN3YBK2JpS1YydEqHo0yycYaydhlkFDA0iXzykhpko5b9fIDVnf1z+nG1JPR
         YYg72bV+wd5v1sIKlGhSGxoLqZiBv2Vvs/o0WF10bKa8btkrxDEiXVSCpKzJBre5m0
         n45b6oGNsI0DjXdp7RXGSXe36OsO3qflwaWSSVshUkmmKz0bhnoIyHd2YJRRzAk+dd
         lEigZTnJs4V6A==
Date:   Thu, 17 Aug 2023 14:54:00 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] ASoC: rt5682: Convert to use GPIO descriptors
Message-ID: <ca058b1f-4214-4011-83ac-5fdacce5fb7c@sirena.org.uk>
References: <20230817-descriptors-asoc-rt-v1-0-434f5f177cee@linaro.org>
 <20230817-descriptors-asoc-rt-v1-4-434f5f177cee@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="h1sN1xmkFad5xBdi"
Content-Disposition: inline
In-Reply-To: <20230817-descriptors-asoc-rt-v1-4-434f5f177cee@linaro.org>
X-Cookie: Walk softly and carry a BFG-9000.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--h1sN1xmkFad5xBdi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 17, 2023 at 03:30:18PM +0200, Linus Walleij wrote:
> Convert the RT5682 to use GPIO descriptors and drop the
> legacy GPIO headers.
>=20
> We remove the global GPIO number from the platform data,
> but it is still possible to create board files using GPIO
> descriptor tables, if desired.
>=20
> Make sure to make sure SDW devices can associate with
> an LDO1 EN descriptor too, if they so desire by putting
> the lookup into the common code.

This doesn't apply against current code, please check and resend.

--h1sN1xmkFad5xBdi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTeJngACgkQJNaLcl1U
h9DMRAf9FpwmrzAd7ICNL8ubOoNSiAM+Ntxp7XqOjMD7ha9HiHgnSsqPm2FEUSCX
iIAX32PCu9Jd4MCqIgxEbC38giRVz0/K42AKLIFJARNE7iDGBZCeeful9TsIA6pS
GFnGmqPQVxBiJVuvuQ76mjGG0pLq8hm7n9IqZvzgqG4NO3I1ZEEkQ5ocfJ4b2dPy
ICRKm5d8QTY5tD+0AUrBbYuq/wxTHxSUoLmh+ew9dYnYZFfaztOmXezdU4l0EsDz
xjhhw13P6WCUiBTkgjKl36FfR674ZGoY7HWy/OLwJ9QyFI2d/6ATl+lZHHbb7ZOg
Vmu1wBqx1Cb2aip8X3JBh2u2YMGP/g==
=qzyf
-----END PGP SIGNATURE-----

--h1sN1xmkFad5xBdi--
