Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 764767777BB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 14:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232883AbjHJMCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 08:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjHJMCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 08:02:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E7B9E4B;
        Thu, 10 Aug 2023 05:02:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 22C6C65A36;
        Thu, 10 Aug 2023 12:02:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12FC5C433C8;
        Thu, 10 Aug 2023 12:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691668952;
        bh=Flb314E8+XpMsWMNCL0KF8esyb6pnDbUg3vUW0fim3c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sQuo5oNtx5gCDoVT4B+DHqgnxpzCZVFEUXvlYPEK/8mnc95hPofleyhVYQJcyidfV
         z710g80hO9qV1esvF039guna7p44V2/op+zkSswPOAzvSE33jNuCPVEZZrMFqxe3/g
         xH/0yNxTJFVnXH+AS2iwmimbgodnJhr0+DulL/B65B2YtTWB9vBNEKxv75YFoyxTvr
         f6z+9gI/CPkdcF5AYr/WTfGQ/ImRm8AI/fDAHhZN3sBOsG5bCncmHqujCPyxCddm/x
         IgcFQLmFUVDXBk2yYmUpfjhwcEvBNsT1YWwfy+CsPiNTuiFf30L1Vf3cF4qL3IzgWc
         M1iHR+bFosP/A==
Date:   Thu, 10 Aug 2023 13:02:24 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, William Hubbs <w.d.hubbs@gmail.com>,
        Chris Brannon <chris@the-brannons.com>,
        Kirk Reiser <kirk@reisers.ca>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Max Staudt <max@enpas.org>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Andreas Koensgen <ajk@comnets.uni-bremen.de>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        Matt Johnston <matt@codeconstruct.com.au>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH 15/36] tty: make tty_ldisc_ops::*buf*() hooks operate on
 size_t
Message-ID: <a0bc988b-b466-45d6-a383-46dd67c9a922@sirena.org.uk>
References: <20230810091510.13006-1-jirislaby@kernel.org>
 <20230810091510.13006-16-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YR7hXufDv/FOrPRU"
Content-Disposition: inline
In-Reply-To: <20230810091510.13006-16-jirislaby@kernel.org>
X-Cookie: Reunite Gondwondaland!
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YR7hXufDv/FOrPRU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 10, 2023 at 11:14:49AM +0200, Jiri Slaby (SUSE) wrote:
> Count passed to tty_ldisc_ops::receive_buf*(), ::lookahead_buf(), and
> returned from ::receive_buf2() is expected to be size_t. So set it to
> size_t to unify with the rest of the code.

Acked-by: Mark Brown <broonie@kernel.org>

--YR7hXufDv/FOrPRU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTU0c8ACgkQJNaLcl1U
h9B//gf/QQsLvV/Zh45033FGzk9nfHoFDvJoH7d8FRPLx6yuxl6LFzYEuYfQPyM2
eltADh3CpOxMHHaL2wE4gTLpRHiXobRzrDQmD5o07ysG4QpoeujKDkgvAtKd3vn6
krU69BeXiEPdv8Yp2GlTFDhCKwKOLqVcuE9iIBOjzYnFeG9P+Y2YZGcDla3Tedf8
bSIAZ3fzDlWdApM4WkmoIuzqY1W+VDD73ROSqXTrKYfO9tyNMpYCBRJ0IYgnN3P6
9hrI/W5QdIyL5jshqWmmBt4Og2ji2vFL5ZtVE7n5pzQrseW9Hk1cMc35GfcvTXaN
5cCJ7gibH06DZNeY8sX2jT23h6a+nw==
=00Rv
-----END PGP SIGNATURE-----

--YR7hXufDv/FOrPRU--
