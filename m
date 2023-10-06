Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BDF67BC0C3
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 22:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233609AbjJFUx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 16:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233634AbjJFUx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 16:53:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A54FBD
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 13:53:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DF79C433C7;
        Fri,  6 Oct 2023 20:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696625635;
        bh=oauOVFT+PrZQ4LbhFiEvzNY1S0t5n89QX4XT55V6IgI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qykK950dTH96BIMrlSxNk8F7VgVWrjQ0wm/EHPGYwP5AOi5ayH7AvATp2Jboup2WN
         axuuvRZOQBYLh+2+I9jQgJha4Zf+IeSiNhyq+NK4ucPmIkE+VkrIzU8fqG2Z8zZoe9
         IJp/cG6FvEdOrZFJ5oeN7J3ZL1EUesyalkvY19j+lDFGS1HFG4T+eezRSDgLGhTf0v
         yVYjdpujB0aRzaD6bzgIiLF6qRYP8j6i+n6hTeUeNqnuHG3KvPYO+c5RSFwfmB4Rbb
         QPAeXKkDWm8gDryJqedpgaWo3Y0nqLR+AkKYWIKEgr3kNdQ7LdCG1hpT6cEDbbuYW4
         92aS+GaFg3bdg==
Date:   Fri, 6 Oct 2023 21:53:49 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, asahi@lists.linux.dev,
        alsa-devel@alsa-project.org, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] ASoC: apple: mca: Annotate struct mca_data with
 __counted_by
Message-ID: <6c7db067-78f2-4637-8064-3dc7c0489b90@sirena.org.uk>
References: <20230922175050.work.819-kees@kernel.org>
 <202310061321.E7247C52B@keescook>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xBZ5y17+t2QN5UsW"
Content-Disposition: inline
In-Reply-To: <202310061321.E7247C52B@keescook>
X-Cookie: Rome wasn't burnt in a day.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xBZ5y17+t2QN5UsW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 06, 2023 at 01:22:55PM -0700, Kees Cook wrote:
> On Fri, Sep 22, 2023 at 10:50:50AM -0700, Kees Cook wrote:

> > Prepare for the coming implementation by GCC and Clang of the __counted=
_by
> > attribute. Flexible array members annotated with __counted_by can have
> > their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOU=
NDS
> > (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> > functions).
> >=20
> > As found with Coccinelle[1], add __counted_by for struct mca_data.
>=20
> Friendly ping. Mark, can you pick this up please?

Please don't send content free pings and please allow a reasonable time
for review.  People get busy, go on holiday, attend conferences and so=20
on so unless there is some reason for urgency (like critical bug fixes)
please allow at least a couple of weeks for review.  If there have been
review comments then people may be waiting for those to be addressed.

Sending content free pings adds to the mail volume (if they are seen at
all) which is often the problem and since they can't be reviewed
directly if something has gone wrong you'll have to resend the patches
anyway, so sending again is generally a better approach though there are
some other maintainers who like them - if in doubt look at how patches
for the subsystem are normally handled.

--xBZ5y17+t2QN5UsW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUgc9wACgkQJNaLcl1U
h9AThAf/TVx58WnyibTJozFRT7p4/Ow/TjcP0UNKN4akoSmOUCmaCr8FAebKU1+t
wj1hcUXFXVIQP/EWLB2hf0pPGxzF0pIcx0gGGl46bSCFO0jXks35z0iGcMniCiNA
kSZf/TswG7Guf6j2vwKiwa5eDnnbjtRMzHsW0WZ5UQxslZwRORs/Uvhj80RsfPQ2
NeWrMXwVNs7kmVPS9+12eYUG62+dyFwMKqDhsFraoKIyzUZkIlM+EWi0P9oRm87V
1PyWUzk/CjTMyZpeWWBoj+Q3vtlPIpcFePRpM+LfCN7muZyWQbAvqJqyJgqhW3Iv
mx+Kp3meL06isrlLlnnkOBAXrvPRkQ==
=9Vt7
-----END PGP SIGNATURE-----

--xBZ5y17+t2QN5UsW--
