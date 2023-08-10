Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D13A7777CC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 14:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234184AbjHJMEt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 08:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234112AbjHJMEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 08:04:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52DB226AF;
        Thu, 10 Aug 2023 05:04:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C0C6265A99;
        Thu, 10 Aug 2023 12:04:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53BA3C433C9;
        Thu, 10 Aug 2023 12:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691669086;
        bh=yX9LvIvDDuUJq2cqD6pHq0+zJxDO0c3crG/Drl1iNl4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IBz0mDjxrNZvcJf168DBM0DteMNMz6lUattdfiWrPKrqFvFNFPcNQnwaPBGOoCXYl
         hX47wwW02lZSPqcJFAo83Z4vOePtOOqFt0M8MMp54QgTuqqkxVNrPjhvnsyHz7SEMF
         EGWdeIUND9btz0Y5/QINWRh88GFXasi7PPqIrKoDD2UtZkVbx+d2g5lFlDPZOm/yqW
         O8ijRQlH4EakduXbq/xvzpUTSGX9E9Tdj0r1NQc/1xBFMDGVLBICGiyhOtXORrjsNe
         N36b1L3530faqB8va6NVWepXjSQDZqwfGeuq/Ypf8mCLY7BvLJDNYbpjcxExPb0v3Z
         9ozJg2MMddg1w==
Date:   Thu, 10 Aug 2023 13:04:38 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, William Hubbs <w.d.hubbs@gmail.com>,
        Chris Brannon <chris@the-brannons.com>,
        Kirk Reiser <kirk@reisers.ca>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Max Staudt <max@enpas.org>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Andreas Koensgen <ajk@comnets.uni-bremen.de>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        Matt Johnston <matt@codeconstruct.com.au>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>
Subject: Re: [PATCH 16/36] tty: use u8 for chars
Message-ID: <6c3155af-987e-4e69-8e20-8e3c89f9ed9f@sirena.org.uk>
References: <20230810091510.13006-1-jirislaby@kernel.org>
 <20230810091510.13006-17-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2MGU0EMwzskEFRw0"
Content-Disposition: inline
In-Reply-To: <20230810091510.13006-17-jirislaby@kernel.org>
X-Cookie: Reunite Gondwondaland!
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2MGU0EMwzskEFRw0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 10, 2023 at 11:14:50AM +0200, Jiri Slaby (SUSE) wrote:
> This makes all those 'unsigned char's an explicit 'u8'. This is part of
> the continuing unification of chars and flags to be consistent u8.

Acked-by: Mark Brown <broonie@kernel.org>

--2MGU0EMwzskEFRw0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTU0lUACgkQJNaLcl1U
h9Dr9Qf9HgUCYAzHtPfLMePhfryUgEukIiJEqj9MayrfaRPFCGt6HByrclOMHWKT
Qc9SiKjEhrKM9ePm4bQE3ydbp/nxhOvvvz9xGNjNNXDqzlo/1d2gHmVnigdwCYzb
CbqwZaWtxYV5b5Lsvp3MDOxmcIoR5qHo2AU5QLLlyTqfDMUrRJibQG7lm0D8F8uW
7d15G9KocFk1fLOD1hDMvi8Ul40IOFxOCZMuQGksX4ItC/T8ZcC5BrzwE5H2KDpa
hYxr/2C4Ihj6Ssl3m6P2CZxnMTPHTpnGLjNHxpz7XXGCOOWnoYStCOVBCjjsPl3o
zJRdVLpt2yyAJpiHpj0vE4ppeUpfkg==
=eINv
-----END PGP SIGNATURE-----

--2MGU0EMwzskEFRw0--
