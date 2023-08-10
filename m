Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7B1B7777D1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 14:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbjHJMFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 08:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbjHJMFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 08:05:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC44B1BD;
        Thu, 10 Aug 2023 05:05:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7269863311;
        Thu, 10 Aug 2023 12:05:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F8A8C433C9;
        Thu, 10 Aug 2023 12:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691669116;
        bh=/Yp0RxfjDZDzPjmWN8BaXr837Qy8tfsgM+K13EUnPEE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LINr0XkPaKjSRqA9E1IGuDPCh64O3YCC4bLVfqFG4ASRfzI9yxUUf3vGlq/AjXx3A
         hytGNKJ24tgA/rs3LRqW4fJgL90f9orC456alCu7B/gmDoIGtZKkELuNxcBfTdbs89
         Fxuwp1qWGpmCEGJZY5bfmyA9zP5YEccKQCz3OmSy2UOd5FVy49g0iGPkm6bePKMYDn
         E0yMtXo4/lUL9Ax4qicJuPU3UTm9+A9vtw+laExOBh91ODrDl79cVk8oTOLebF6Vmc
         54PqNVbdWlD22u+/HxLnpnDm5RuFRpUWp0kEa+7UEejUTod7Yi056iL21VS4kGwIrM
         +Uod3oDgZCw7w==
Date:   Thu, 10 Aug 2023 13:05:08 +0100
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
Subject: Re: [PATCH 17/36] tty: use u8 for flags
Message-ID: <59aa7909-3fa8-4ceb-94d7-7727a4c7e904@sirena.org.uk>
References: <20230810091510.13006-1-jirislaby@kernel.org>
 <20230810091510.13006-18-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="g88Z0hAJlY8W0zZ1"
Content-Disposition: inline
In-Reply-To: <20230810091510.13006-18-jirislaby@kernel.org>
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


--g88Z0hAJlY8W0zZ1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 10, 2023 at 11:14:51AM +0200, Jiri Slaby (SUSE) wrote:
> This makes all those 'char's an explicit 'u8'. This is part of the
> continuing unification of chars and flags to be consistent u8.
>=20
> This approaches tty_port_default_receive_buf().

Acked-by: Mark Brown <broonie@kernel.org>

--g88Z0hAJlY8W0zZ1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTU0nMACgkQJNaLcl1U
h9D9egf8DkTW2F5YRiMYN+RgrSLiQ9MxhFvQiSoC1XAsTB0VFy87VO7XbEjJB/7B
EdH/5O2MMUWXjVRZvMGdUKWGe6CNB3IzlrZIzOH2uY8y6ww8P37fiP3IqU8TXz2D
ynvppz1bt85Ketg9I43F2GmPn5g4WinKAhpi1TL0L/nfHH9EXACuWiMfEySH+M7l
k+L+EZnRHTKncqCW07miHHqQNybJKF7+GH4Eyss2NePK9q8Z1zj93rKA1zkbJoH4
uot9JoyDkweLapR3GrOxdtcQefookp3jAy6DfvizvQpC2D0H8hsV8JZHJjWwGXKB
dwSTsErcmEjhl4Yh0gQy4/eZ4OqnnQ==
=8+tC
-----END PGP SIGNATURE-----

--g88Z0hAJlY8W0zZ1--
