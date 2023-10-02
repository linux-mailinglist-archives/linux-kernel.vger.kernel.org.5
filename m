Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDD937B543D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 15:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237505AbjJBNsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 09:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237479AbjJBNsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 09:48:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36E50B7;
        Mon,  2 Oct 2023 06:48:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D613C433C7;
        Mon,  2 Oct 2023 13:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696254479;
        bh=bbYKXZTl9YSdySAEA++jPVV9QQyRDBWMWVktu8dI+gA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qDxkhaSil/n9GhT+RwXlX5YqDYkw46UgUqPMJIvq+FlwnKpxAFAQ56hCrrVZfaNX1
         FznHYoFC87kGxr0xhsr96G/aM9IwqjSzCmurcSJ3mbx8Lpb4MMuT9G7D8gXT04VEgN
         w3oOGTWrA1DxfF2+VXijB9iLu7dhuFI1mwu771sYMKmpib3ewEtfNfFGmYfiKQ3CIW
         PiIgVRA9akXzzz0oIpcmaaKcZbyTckf6XCWhWK4A0VnxWyuTsMosbwsPKmhZvqWIZ8
         Uquy4WIbZVCdUye+eFhRJ7/AemMnYXaIKpA82G5/Oltud8ey6Ht1dt8gjslzGyVAll
         Cgb+dGCruwoFg==
Date:   Mon, 2 Oct 2023 14:47:54 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Sven Frotscher <sven.frotscher@gmail.com>
Cc:     Linux regressions mailing list <regressions@lists.linux.dev>,
        mario.limonciello@amd.com, git@augustwikerfors.se,
        alsa-devel@alsa-project.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH v4] ASoC: amd: yc: Fix non-functional mic on Lenovo 82YM
Message-ID: <37101767-9bca-419c-9ce5-92c4c1360c81@sirena.org.uk>
References: <20230927223758.18870-1-sven.frotscher@gmail.com>
 <46560887-0b6e-42ac-96c3-b4dbc1d7cb61@leemhuis.info>
 <4fa7d39d-dc34-4550-97fa-2b089f364cca@sirena.org.uk>
 <541ac45b-8de7-4fa2-85ee-456d34e60aa9@leemhuis.info>
 <64c78944-4d62-4eda-b92b-3b415fea3333@sirena.org.uk>
 <65KW1S.A6C8VBV29YCM@gmail.com>
 <89698b5f-a616-4f49-802a-21326a868c7f@sirena.org.uk>
 <9XKW1S.IRRCIDM08XWX1@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rV9cXJVA+sC7cXdh"
Content-Disposition: inline
In-Reply-To: <9XKW1S.IRRCIDM08XWX1@gmail.com>
X-Cookie: Postage will be paid by addressee.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rV9cXJVA+sC7cXdh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 02, 2023 at 03:17:33PM +0200, Sven Frotscher wrote:

> > We need to know what magic set of quirks makes the thing work.  Are you
> > saying that your patch doesn't actually do that?

> It does.

> Maybe the non-quirk check (ll. 395-403, seems to be using ACPI) is too
> specific? But I'm a bit out of my depth here, so I can't investigate that by
> myself.

Like I say it's all just guesses without someone providing information.

--rV9cXJVA+sC7cXdh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUaygkACgkQJNaLcl1U
h9CGmQf/Vc1+y1dKGunpBhuliT2pZe10C87on6X9xclHZuRaeHgIR0yc9BkNFk+c
CYPJbCQnlKHIFMGijfyRVPuxZ31YhpjpDgCPn7i4fUVAvpN5n/AJm2TuDP1mZJk3
TrbnQO5ye2tPA3XPgdRCgtX8B/PrhD5c0mp38mwOqlYRGq2b5/FdGGOpe47snler
L2l2AHSX64vLBi/PxUyHSIIok2M1QpJSCobqdU9sUIYOTMWm3QXpxO9DfLcpFyXi
k55bVdm4PEOPxqOnP1QmmSWEUjjjHTHWEZ9vTHUrB1zb/tCYgHpuEnFPs5zKKp/5
eUFQoE/I/ymdnkka2oDtQmmFjeAZBA==
=MCug
-----END PGP SIGNATURE-----

--rV9cXJVA+sC7cXdh--
