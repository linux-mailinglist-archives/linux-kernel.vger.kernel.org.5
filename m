Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AFCF7F1D42
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 20:22:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbjKTTWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 14:22:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjKTTWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 14:22:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C6A6BB;
        Mon, 20 Nov 2023 11:22:11 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EF37C433C8;
        Mon, 20 Nov 2023 19:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700508131;
        bh=2aUp4hFQlLqMEsSFhngQ+sfVIS5arskcjqcdj3YPsdU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dcV4yGLWK2gd5PNmevD1kVTLVXpFfviSxckPidzOa2JWLOgko3w48x3HzKev+5iGp
         mItw7ctOvCPg27iwQPQuMfoz5uFZYhUBwH9ako5qQG+fqCFVUzXOwSpNqWtxMNhjGd
         pnABTOtCWMibZ0TGMKkho1hBWudgq7TMsLhKq3Dc1CDxTPOGvINoVe4/Qj/o9qPiKb
         B9anjKd61F9tv8VWGiPRyb8/TMmAQi1feX+UxyWP7f9WM14oPOS5u8Z2QzV3V6pLw+
         aN4H4Fjc2OM6h5fxhrUlCXzVdk01kjKKr0NfGo16JBiIra9n1NmFIDg8VslAmtQ0Xy
         RSn/936gkA3cQ==
Date:   Mon, 20 Nov 2023 19:22:06 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Maciej Strozek <mstrozek@opensource.cirrus.com>
Cc:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ASoC: cs43130: Allow driver to work without IRQ
 connection
Message-ID: <7429d3e8-ff23-41ae-8717-b7f6091b1995@sirena.org.uk>
References: <20231120141734.76679-1-mstrozek@opensource.cirrus.com>
 <170050793178.1294254.1258854570735859586.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sbwRwMg36TnlCFW1"
Content-Disposition: inline
In-Reply-To: <170050793178.1294254.1258854570735859586.b4-ty@kernel.org>
X-Cookie: I have become me without my consent.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sbwRwMg36TnlCFW1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 20, 2023 at 07:18:51PM +0000, Mark Brown wrote:
> On Mon, 20 Nov 2023 14:17:34 +0000, Maciej Strozek wrote:
> > Add a polling mechanism that will keep the driver operational even in
> > absence of physical IRQ connection. If IRQ line is detected, the driver
> > will continue working as usual, in case of missing IRQ line it will
> > fallback to the polling mechanism introduced in this change.
> > This will support users which choose not to connect an IRQ line as it
> > is not critical to part's operation.
> >=20
> > [...]
>=20
> Applied to
>=20
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-=
next
>=20
> Thanks!

Sorry, this was done in error - dropped it.  Sorry for the noise.

--sbwRwMg36TnlCFW1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVbsd0ACgkQJNaLcl1U
h9Cl8gf9GgraVzbnKi3XHA7coVE5UYqFfYsUnE3OGiGtVlcIDScqqrQ5yX+UO8RT
RI4wJi6DO0g2ts4d9YKg53I7AQrmn1ouyFqggijC50nM9UPWmEFBPNew9fe9qvRM
6w2eZJQcGt1XrcN5e9TuEf24Pj72NQClQnYiWLfGfWq0mLcBJlQj0J6bUXBsYeHN
pU1GhM6OFrxrg1uiEXg6WUupMfKMDEqUHpT1zvBvLhVNs6cwSLwZoQ26LxS2QXoS
ccxORza+wdqsBbg68+sdouidwQpGVbk/1Ghn8m+nTD5Nvt6RISP+h7xuiUo7ZAaK
msoVu0O2q9MTl1jCBy6GLaZolfcPqw==
=QH8Q
-----END PGP SIGNATURE-----

--sbwRwMg36TnlCFW1--
