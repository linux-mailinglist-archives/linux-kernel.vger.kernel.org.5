Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6576A79980D
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 14:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238401AbjIIMmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 08:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233883AbjIIMmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 08:42:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1DBCD6
        for <linux-kernel@vger.kernel.org>; Sat,  9 Sep 2023 05:42:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59892C433C8;
        Sat,  9 Sep 2023 12:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694263336;
        bh=xr+HEKX4cCDTuOqKdyXJ1E/ji1CQkjaUauZpgB7DUUg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CfN5qCgqBJdm5dycCocctI74vqr0SYq4BhRPMVQIeL3mhqZvRLQOFSWGvbOGAq3+Z
         kYFwlv1lb0GUgIjJFpv7Sr66jWceiI385ydCDXSBBF18AvxYTKIh7S6tZYdehD1jrH
         RasEgJpNN9ZRewIezIett09FiWwbSxIpq7hV+ffyEvVo+lulRG6yuoDXzxpCkfX6rr
         WM3C0HIkwwVo9NuHcAT30H+iUjEQpValZYtJnf/jgMraInkAMVmMR/Srl0DgAk+LPF
         LongSAdtYXqdUiA6WaGxebExEfP5uRiaPHLxPqI7xNjX9GCXXnjubVZuEllVSN1P02
         /KOMmu1wUr5Xg==
Date:   Sat, 9 Sep 2023 13:42:09 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, patches@opensource.cirrus.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Fabio Estevam <festevam@denx.de>,
        Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: wm8960: Fix error handling in probe
Message-ID: <ZPxoIQ6ocTcDrmtM@finisterre.sirena.org.uk>
References: <20230909120237.2646275-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vjozxumgwjzG39lU"
Content-Disposition: inline
In-Reply-To: <20230909120237.2646275-1-linux@roeck-us.net>
X-Cookie: Save energy:  Drive a smaller shell.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vjozxumgwjzG39lU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 09, 2023 at 05:02:37AM -0700, Guenter Roeck wrote:
> Commit 422f10adc3eb ("ASoC: wm8960: Add support for the power supplies")
> added regulator support to the wm8960 driver, but neglected to update
> error handling in the probe function. This results in warning backtraces
> if the probe function fails.
>=20
> WARNING: CPU: 0 PID: 1 at drivers/regulator/core.c:2396 _regulator_put.pa=
rt.0+0x1b4/0x1d8
> Modules linked in:
> CPU: 0 PID: 1 Comm: swapper/0 Tainted: G                 N 6.5.0-11075-g9=
2901222f83d #1
> Hardware name: Freescale i.MX6 Ultralite (Device Tree)
>  unwind_backtrace from show_stack+0x10/0x14
>  show_stack from dump_stack_lvl+0x68/0x90
>  dump_stack_lvl from __warn+0x70/0x1a4

Please think hard before including complete backtraces in upstream
reports, they are very large and contain almost no useful information
relative to their size so often obscure the relevant content in your
message. If part of the backtrace is usefully illustrative (it often is
for search engines if nothing else) then it's usually better to pull out
the relevant sections.

--vjozxumgwjzG39lU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmT8aCAACgkQJNaLcl1U
h9Dxlwf+Ln5ZLsZt4L9GtAbAoAzBwg6k6EXI3wl9dsfKZL39RrU2usnPSRoWbgFP
1GHaYDHSOCXfI4SM+Y91nknankLLzeGQG8BlJZ2byDz2T/fwExZlvdWNQccQYJfW
BVQ/3u1byQhsA8BIxmmpejiwFtS5iAwh1280Y1AUiKlT9eQhXESAR0kxhKOaBK3v
gxenKi3LN1t1adtqK+0MRjPTUZofvymMY44PP0Rb2dRZgEkjEMa6EQ2iJqJ5BMhK
CVvlwZjAoUcA+yks821zKxlCx01bPjdn4JYqYjTXcyqL0vP/EBp49/F5tSIR+A2D
SnRPGvTCNGjjIA27bGCOib9cOJVZBA==
=H49g
-----END PGP SIGNATURE-----

--vjozxumgwjzG39lU--
