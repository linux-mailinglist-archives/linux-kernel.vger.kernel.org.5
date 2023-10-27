Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA2707D9DE8
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 18:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231690AbjJ0QXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 12:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbjJ0QXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 12:23:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81715E5
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 09:23:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76439C433C8;
        Fri, 27 Oct 2023 16:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698423820;
        bh=RV0fLu2/76u6vHIzDmwynMS7JHnsLAajtz19VSfeVOg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IU7qEilM3rjTamN9SMxER6aUSRpZdMoz/+fHY92Dt76/9ffAeHhbVhzh21bxT9Nhr
         TTivbhtISZ84ujdJapLPZSVjSRCFDPrm9A/Jwx7Unkblfk4P44BeJgEmdx6T4rM5TQ
         69AlxOyNjOFZ4Ke0feuowcdMXX3LZqvCUHjtKiG1VHg9bPhsqXTfcvqg2tgqP2X+Hz
         urnbYckxizt9/uwYeBanT+oaeLXWzbuZrnX2cPm+nKO0pl6/K9f4ga5fBmeh/Ypg9m
         atfZCvQLatkV0GDuEBZvO1jdwZkRwH6BXHmrE70tsSz2v696kmIjkIbZj0y2cC8C3g
         /RuBmNZxo0tVg==
Date:   Fri, 27 Oct 2023 17:23:36 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        alsa-devel@alsa-project.org, Vijendar.Mukunda@amd.com,
        Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
        venkataprasad.potturu@amd.com, arungopal.kondaveeti@amd.com,
        mastan.katragadda@amd.com, juan.martinez@amd.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Marian Postevca <posteuca@mutex.one>,
        Alper Nebi Yasak <alpernebiyasak@gmail.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        Jarkko Nikula <jarkko.nikula@bitmer.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 09/13] ASoC: amd: acp: add machine driver support for pdm
 use case
Message-ID: <ZTvkCAYsrS62/82u@finisterre.sirena.org.uk>
References: <20231021145110.478744-1-Syed.SabaKareem@amd.com>
 <20231021145110.478744-9-Syed.SabaKareem@amd.com>
 <4d5a4c67-2f4b-4111-b98b-ef575543fa6e@kernel.org>
 <3ec97548-1f91-49d0-adfb-4f8051ca9a97@amd.com>
 <f8f8017c-4e76-4d70-918f-d7cb45186184@kernel.org>
 <c0ea139c-9861-4ea1-b547-6e3c380301b3@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="F5X28b0ZPx7dDZpr"
Content-Disposition: inline
In-Reply-To: <c0ea139c-9861-4ea1-b547-6e3c380301b3@amd.com>
X-Cookie: Save energy:  Drive a smaller shell.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--F5X28b0ZPx7dDZpr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 27, 2023 at 10:54:47AM -0500, Mario Limonciello wrote:

> What would actually go into MODULE_DEVICE_TABLE?

> The platform devices created are contingent upon what was found during the
> top level ACP driver probe.  You don't want all the "child" platform drivers
> to load unless they're needed.

You want

	MODULE_DEVICE_TABLE(platform, board_ids);

which is effectively the same as all the MODULE_ALIAS items you have
there (which can be removed).

--F5X28b0ZPx7dDZpr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmU75AcACgkQJNaLcl1U
h9AMNgf+K4oW7ZrMTMIcX7t1TwQoWNyZMYtETdiOm7VKUfS7pub9BGO3pKJa3oFo
JgemoHmiM+XrK6SJtNr6+UstjZXH0S3LzN9fD5hu7Xlzn38slkvdv3gUd4J/pct/
6/MKQp/Is54DVkuMxYoMx7Pq1v+9R4bwI0RprFxfNtRWedJuDED4IHnGBJ/j3nfj
qWWoZHkKxuQM4A+AMSpo/O+KRohtvOwUAZTBxwUFXxaj3tGpJ4aNQwN7nxcsN5hl
t6jH5P0kzl2uGoy899M84AHyyI37vGxTDMrjobYDSXxNOojIIyAbHlRQbNSK2rf8
GN0aZEw0+VJBCdOtyXgnO+Vpkwjpsw==
=QVIL
-----END PGP SIGNATURE-----

--F5X28b0ZPx7dDZpr--
