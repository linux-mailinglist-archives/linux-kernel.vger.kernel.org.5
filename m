Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35EEB7FA661
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 17:29:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234167AbjK0Q3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 11:29:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbjK0Q3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 11:29:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80864CE
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 08:29:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41BA3C433C7;
        Mon, 27 Nov 2023 16:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701102564;
        bh=c7UXKhyCEJLe4p8fNvCpJdR2nuw6fvls3719IBlx6wc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Df/pEzrS8cN4nviesAg8zjNi8LYuVLMtLlNKvDRQJLZNnxkhSzdk+19covWXKAwPw
         fi2NXKt+6eN3Z1N+FiB98tLcpblr0xkW8wIiw4E+mFh6PNnMez4ehd8YuuSXSvdFmv
         k58mGQzZd7TVkMAhA3TTjKoPCnnf3hYS4Oi2LhSAfXGTght1RqGqPD53ozyX9BLIxh
         vHzZUW43Oy35oO2otlJqQ5s1iWr6ZHcQpHnXpmcniieUeMZOWqjjcqe+kAPMl0vy50
         L+uLDC0xR/YDt5xJ6Abj1d37IbYpQNX/RbFoTL/zJL7naBDAJ3Nk2IBodmaSBCXFxo
         IPsNf4TKQjoOQ==
Date:   Mon, 27 Nov 2023 16:28:40 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Malcolm Hart <malcolm@5harts.com>
Cc:     Mario Limonciello <mario.limonciello@amd.com>,
        Sven Frotscher <sven.frotscher@gmail.com>,
        git@augustwikerfors.se, alsa-devel@alsa-project.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        regressions@lists.linux.dev, stable@vger.kernel.org
Subject: Re: ASoC: amd: yc: Fix non-functional mic on ASUS E1504FA
Message-ID: <ZWTDuKDj3v9ZSlFX@finisterre.sirena.org.uk>
References: <b9dd23931ee8709a63d884e4bd012723c9563f39.camel@5harts.com>
 <ZWSckMPyqJl4Ebib@finisterre.sirena.org.uk>
 <87leajgqz1.fsf@5harts.com>
 <08590a87-e10c-4d05-9c4f-39d170a17832@amd.com>
 <87h6l72o8f.fsf@5harts.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jZEA8hOLgvi+THE/"
Content-Disposition: inline
In-Reply-To: <87h6l72o8f.fsf@5harts.com>
X-Cookie: Slow day.  Practice crawling.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jZEA8hOLgvi+THE/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 27, 2023 at 03:44:37PM +0000, Malcolm Hart wrote:
>=20
>=20
> From da1e023a39987c1bc2d5b27ecf659d61d9a4724c Mon Sep 17 00:00:00 2001
> From: foolishhart <62256078+foolishhart@users.noreply.github.com>
> Date: Mon, 27 Nov 2023 11:51:04 +0000
> Subject: [PATCH] Update acp6x-mach.c
>=20
> Added 	ASUSTeK COMPUTER INC  "E1504FA" to quirks file to enable microphon=
e array on ASUS Vivobook GO 15.
> ---
>  sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
>  1 file changed, 7 insertions(+)

You've not provided a Signed-off-by for this so I can't do anything with
it, please see Documentation/process/submitting-patches.rst for details
on what this is and why it's important.

Please don't send new patches in reply to old patches or serieses, this
makes it harder for both people and tools to understand what is going
on - it can bury things in mailboxes and make it difficult to keep track
of what current patches are, both for the new patches and the old ones.

--jZEA8hOLgvi+THE/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVkw7cACgkQJNaLcl1U
h9BWSwf/bRWKgTTQMcjabBit1tuhBSBYvUALjvjAsJF9DJtrCMduzgvOBBM+De7d
ozxI4XNRZBnFfng00zan1sFrWTrSl7lpbydNW/GFySZtDhmodMk8C1sGnbeg/lE8
i+LroPK/tJOo0zJRF/5O8MExUgVuf7ZoMRCjUPhPAos22EDbtzntbEeudxpZzKGM
s7F0zrTriemx4w1pvSRGLv42ykDiujQXx0BxkLzE/31v668ULeOyMwXBBC+FLR/n
o9DaKXB/HODATBzpPPuwwAU1ubfI8gQlsE5Ha7utw1n2OpjYhL2zDPH5YmGKmbKD
gmGWY82OdFtKdgO7mZbTdTQCexiuww==
=6B4G
-----END PGP SIGNATURE-----

--jZEA8hOLgvi+THE/--
