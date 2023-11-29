Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 501E17FD25E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 10:23:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbjK2JW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 04:22:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjK2JWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 04:22:53 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC0A19BF
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 01:23:00 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63D3AC433C7;
        Wed, 29 Nov 2023 09:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701249779;
        bh=EzFjw7idQptv1qfyUwLm9/Zx/1lzbs/31vkDl/YdmpM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G41YjMqsqEVdWf++jrJ1PV3Reea5PMr5GlgKCi8FKDp+njIin/DvJUlCRNqnQIXVt
         7pelXS1MLbgUeFUjjFBwxfB+FOlcEpoiO/qzzG0YUV1jHPX1Yto9UYhr4C/+TeKivx
         Al5GOghL/Yj4whPJamcEfIRqLqintvGYKEIwNimq/n21ySUBj00sdRwMOs56Ucnwv0
         OOevlMvntIM138/v73SPTAbhxHbuTnsuhEk/74QbhRiq5aKkmSeyb1BVrAzWpIT4WM
         gJU0P1qiHu2EEAYmctKMQcUhsYgFhNVO6h5XwXyBgDj4zul8LisgQeCPTukmnGLign
         Uzi0hrs3SFuQg==
Date:   Wed, 29 Nov 2023 10:22:57 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Frank Binns <frank.binns@imgtec.com>,
        Donald Robson <donald.robson@imgtec.com>,
        Matt Coster <matt.coster@imgtec.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sarah Walker <sarah.walker@imgtec.com>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] drm/imagination: DRM_POWERVR should depend on ARCH_K3
Message-ID: <sw5e3mdtbmywbeo6sok4ul5qe72bb5ltsg5ago2vliqxlahvpl@rcivlupw77a5>
References: <b9360c2044a1001b9a5bcb5914611711d040d4fe.1701196029.git.geert+renesas@glider.be>
 <87o7fdbszs.fsf@minerva.mail-host-address-is-not-set>
 <CAMuHMdUhuO++ZSxh+_TX_6DHHxjPYY20jTppbNZ4FnuBvxxinQ@mail.gmail.com>
 <7hee65pmdl5pajm2kgqld22xfi4iox4s2psswu2mdlfk6u6f7x@w4ecogdx6uj6>
 <CAMuHMdVTZ8LT1yU3e1bbJODecy96TaMX1hq_swqmT6L+mbH3aQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="r3qnhn4k5yvcspbm"
Content-Disposition: inline
In-Reply-To: <CAMuHMdVTZ8LT1yU3e1bbJODecy96TaMX1hq_swqmT6L+mbH3aQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--r3qnhn4k5yvcspbm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 09:58:12AM +0100, Geert Uytterhoeven wrote:
> Hi Maxime,
>=20
> On Wed, Nov 29, 2023 at 9:35=E2=80=AFAM Maxime Ripard <mripard@kernel.org=
> wrote:
> > On Tue, Nov 28, 2023 at 08:16:18PM +0100, Geert Uytterhoeven wrote:
> > > On Tue, Nov 28, 2023 at 8:03=E2=80=AFPM Javier Martinez Canillas
> > > <javierm@redhat.com> wrote:
> > > > Geert Uytterhoeven <geert+renesas@glider.be> writes:
> > > > > The Imagination Technologies PowerVR Series 6 GPU is currently on=
ly
> > > > > supported on Texas Instruments K3 AM62x SoCs.  Hence add a depend=
ency on
> > > > > ARCH_K3, to prevent asking the user about this driver when config=
uring a
> > > > > kernel without Texas Instruments K3 Multicore SoC support.
> > > > >
> > > > > Fixes: 4babef0708656c54 ("drm/imagination: Add skeleton PowerVR d=
river")
> > > > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>=20
> > > > In any case, I agree with you that restricting to only K3 makes sen=
se.
> > >
> > > I am looking forward to adding || SOC_AM33XX || ARCH_RENESAS || ...,
> > > eventually ;-)
> >
> > I disagree. This is to handle a generic IP, just like panfrost, lima, or
> > etnaviv, and we certaintly don't want to maintain the Kconfig list of
> > every possible architecture and SoC family it might or might not be
> > found.
>=20
> While PowerVR is a generic IP, I believe it needs a non-generic
> firmware, which is currently only available for AM62x SoCs.

I'm not sure it's actually true, but let's consider it is. Then what? If
the firmware isn't there and/or the DT bits too, then nothing will
happen. We would have wasted a couple of 100kB on a system that is
taking somewhere in the 100MB-10GB range, and that's pretty much it.

If you have we take that patch in though, we have:

  - To keep merging patches as firmwares become available.

  - If we update linux-firmware only, then the driver is still not
    loading even though it could.

  - If we have gotten our firmware through some other mean, then the
    driver is still not loading even though it could.

It makes life harder for everyone: maintainers, users, devs, based on
the state of some external project that might or might not be updated in
sync.

> Once it becomes truly generic, I'm happy to drop all platform
> dependencies.  Until then, there is no point in asking everyone who
> configures an arm64 kernel about this driver, unless they also enabled
> K3 support.

Whether it's truly generic, whatever that means, is irrelevant here.

Maxime

--r3qnhn4k5yvcspbm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZWcC8AAKCRDj7w1vZxhR
xZTtAP47Cg/+oHf3QN6f+1dfblO7GrIo9jYf5v/2E2Td43d4yQD+KlTDLfp7k2TU
+LBGSzyfqu7qT7Lo//1XyokUzh5SZQY=
=BGY8
-----END PGP SIGNATURE-----

--r3qnhn4k5yvcspbm--
