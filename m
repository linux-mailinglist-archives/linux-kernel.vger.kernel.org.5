Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B39A37B53BE
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 15:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237186AbjJBNE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 09:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236163AbjJBNEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 09:04:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11440B0;
        Mon,  2 Oct 2023 06:04:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B56B2C433C7;
        Mon,  2 Oct 2023 13:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696251861;
        bh=AFn+gVXbUD0U4Y6bUXqTweEbLHVA0KrcQKlngrIzbJ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m3xKYy6amE4sejsfFYH8X2/F22UfVwfhG3qQDtBSK2Sk9lu9vm3DA9+PiIMuDkVIA
         6x8JSfOzNGbU/scZWI3UbLrrG5R7/sp2z8XbYRJBCetpMRwID/jZR92vJHnwdeuQLf
         h7ZGaPS4qfsMzcO0bV9IAJHjD7QrbPZy0l5ON0Q+mtw2fPYP1zjHIGtQAbRt/XiVuq
         1HBp+KOnq6EuJtASfW5G4IxzxtypXIgEJ2Z422Etd7kGHwccAVkAV9ZXoCE6GSjASj
         9dNj2Tvz9G3cWQxAZv52eUtdF+doS2I4oImit/a0NvNFw1+Epyky0yG5W9ub5STiTv
         +eysXJ9BIWcLQ==
Date:   Mon, 2 Oct 2023 14:04:15 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Sven Frotscher <sven.frotscher@gmail.com>
Cc:     Linux regressions mailing list <regressions@lists.linux.dev>,
        mario.limonciello@amd.com, git@augustwikerfors.se,
        alsa-devel@alsa-project.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH v4] ASoC: amd: yc: Fix non-functional mic on Lenovo 82YM
Message-ID: <89698b5f-a616-4f49-802a-21326a868c7f@sirena.org.uk>
References: <20230927223758.18870-1-sven.frotscher@gmail.com>
 <46560887-0b6e-42ac-96c3-b4dbc1d7cb61@leemhuis.info>
 <4fa7d39d-dc34-4550-97fa-2b089f364cca@sirena.org.uk>
 <541ac45b-8de7-4fa2-85ee-456d34e60aa9@leemhuis.info>
 <64c78944-4d62-4eda-b92b-3b415fea3333@sirena.org.uk>
 <65KW1S.A6C8VBV29YCM@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="T3pA0U+bnE9JGR4j"
Content-Disposition: inline
In-Reply-To: <65KW1S.A6C8VBV29YCM@gmail.com>
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


--T3pA0U+bnE9JGR4j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 02, 2023 at 03:00:42PM +0200, Sven Frotscher wrote:
> Am Mo, 2. Okt 2023 um 13:54:59 +01:00:00 schrieb Mark Brown

> > Until someone tests or otherwise provides specific information on a
> > given machine we're just guessing about how it's wired up.

> What specific information are we talking about here? I have the 82YM in
> front of me and could help investigate.

We need to know what magic set of quirks makes the thing work.  Are you
saying that your patch doesn't actually do that?

--T3pA0U+bnE9JGR4j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUav84ACgkQJNaLcl1U
h9Cz6Qf9H7niacF30Y0k3OYJeoCcMMTuQYXuwjRZLJuCVOI/Uq8KIC/E3ovi+GX8
CEcICKguhEX6gtzClAEOWWdRRmLubWi4kHEfZAaMMmKdNxa3xMEqazvbKLK1gidP
1Mq4xx7BmNDoK1CSVInPoPl1Q5S9CEUOr9T855Mio0rY+4SjjOcTKjCmw9+SSkPr
mpMTIdixcEm235K5rOh8KNcGtYqXmDvSHE0VFtkPu9iTC5Ik3Rh/CF4iC5Yl7u8u
wkjKg+LSPqSTuf+FNJjqYARLOLFsTYhcbKQIcweBRHSxLDz9XHZSni20mX3V4Zlt
t6c9FH0ejAjo0hZbJ9p8VRqOJJHHnA==
=SH/+
-----END PGP SIGNATURE-----

--T3pA0U+bnE9JGR4j--
