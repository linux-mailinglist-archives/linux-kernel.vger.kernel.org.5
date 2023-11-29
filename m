Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 797D47FD4AE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 11:50:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjK2Ktz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 05:49:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjK2Kty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 05:49:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B7A310CE
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 02:50:01 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F4C6C433C8;
        Wed, 29 Nov 2023 10:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701255000;
        bh=FrNAcwg/8bjiAPz/eSYCESKcNWmbd0LQldJWLX7qG5o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T4tSTzMWkYPpuNpE7/MfdQLHeEPCwSykWBYttORCRo7zFgD+VvmYcBVIQG7ETI6rT
         qWPOwcQkBp/75gdvAmeggNw+TLE2Gejew+yRA1RAz6vUjrQz7AQnNMZHauwZH+cRLK
         f6Xte5V7kVc4YySqlw7rtZEMwCBTgAjSXWa6JViOPh1DNN+MMIl0VZjtCAYLEpSonw
         Tm2wfp3Tjj1Yl6TrkbtQ834kfANHvTLzHOVYQjU76go1yZDmnfiRCqAWtZoyXj6K3V
         BIWH+ZiKt5JD6jWI5/1FIQbJh8TzR+fscSekAhpewjliPhrmolHXJCaEhR10KjEU0J
         Siaa/26o1bxKw==
Date:   Wed, 29 Nov 2023 11:49:57 +0100
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
Message-ID: <u42osuikwzf372mb5xkhiyaycxpmduc5ntyanjlauqca6roeh4@i7zqwu36lzko>
References: <b9360c2044a1001b9a5bcb5914611711d040d4fe.1701196029.git.geert+renesas@glider.be>
 <87o7fdbszs.fsf@minerva.mail-host-address-is-not-set>
 <CAMuHMdUhuO++ZSxh+_TX_6DHHxjPYY20jTppbNZ4FnuBvxxinQ@mail.gmail.com>
 <7hee65pmdl5pajm2kgqld22xfi4iox4s2psswu2mdlfk6u6f7x@w4ecogdx6uj6>
 <CAMuHMdVTZ8LT1yU3e1bbJODecy96TaMX1hq_swqmT6L+mbH3aQ@mail.gmail.com>
 <sw5e3mdtbmywbeo6sok4ul5qe72bb5ltsg5ago2vliqxlahvpl@rcivlupw77a5>
 <CAMuHMdVVb2VfEAgh+59juyTH28EvRMPHEsxT-MUiEQcmJHTD+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yx7wzbz23427lvci"
Content-Disposition: inline
In-Reply-To: <CAMuHMdVVb2VfEAgh+59juyTH28EvRMPHEsxT-MUiEQcmJHTD+Q@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yx7wzbz23427lvci
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 11:10:51AM +0100, Geert Uytterhoeven wrote:
> On Wed, Nov 29, 2023 at 10:23=E2=80=AFAM Maxime Ripard <mripard@kernel.or=
g> wrote:
> > On Wed, Nov 29, 2023 at 09:58:12AM +0100, Geert Uytterhoeven wrote:
> > > On Wed, Nov 29, 2023 at 9:35=E2=80=AFAM Maxime Ripard <mripard@kernel=
=2Eorg> wrote:
> > > > On Tue, Nov 28, 2023 at 08:16:18PM +0100, Geert Uytterhoeven wrote:
> > > > > On Tue, Nov 28, 2023 at 8:03=E2=80=AFPM Javier Martinez Canillas
> > > > > <javierm@redhat.com> wrote:
> > > > > > Geert Uytterhoeven <geert+renesas@glider.be> writes:
> > > > > > > The Imagination Technologies PowerVR Series 6 GPU is currentl=
y only
> > > > > > > supported on Texas Instruments K3 AM62x SoCs.  Hence add a de=
pendency on
> > > > > > > ARCH_K3, to prevent asking the user about this driver when co=
nfiguring a
> > > > > > > kernel without Texas Instruments K3 Multicore SoC support.
> > > > > > >
> > > > > > > Fixes: 4babef0708656c54 ("drm/imagination: Add skeleton Power=
VR driver")
> > > > > > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > >
> > > > > > In any case, I agree with you that restricting to only K3 makes=
 sense.
> > > > >
> > > > > I am looking forward to adding || SOC_AM33XX || ARCH_RENESAS || .=
=2E.,
> > > > > eventually ;-)
> > > >
> > > > I disagree. This is to handle a generic IP, just like panfrost, lim=
a, or
> > > > etnaviv, and we certaintly don't want to maintain the Kconfig list =
of
> > > > every possible architecture and SoC family it might or might not be
> > > > found.
> > >
> > > While PowerVR is a generic IP, I believe it needs a non-generic
> > > firmware, which is currently only available for AM62x SoCs.

I just asked, it's not true in most cases. There's some exceptions
(GX6250 for example) that could require different firmwares depending on
the SoC it's used in, but it's not the case here.

> > I'm not sure it's actually true, but let's consider it is. Then what? If
> > the firmware isn't there and/or the DT bits too, then nothing will
> > happen. We would have wasted a couple of 100kB on a system that is
> > taking somewhere in the 100MB-10GB range, and that's pretty much it.
>=20
> I am talking about posing the question to the user to enable the driver
> or not.  Which applies to everyone who configures a kernel.

If that user doesn't use a defconfig, doesn't use any variant of
*defconfig make target. Plus, the driver still isn't enabled by default.

> > If you have we take that patch in though, we have:
> >
> >   - To keep merging patches as firmwares become available.
>=20
> You need to keep merging patches to update DT bindings, DTS,
> SoC-specific drivers, the DRM driver itself, ... too.

The DT binding and DRM driver is already there, the SoC specific drivers
are probably already there by the time you reach GPU enablement, and the
DT doesn't have to be upstream.

> >   - If we update linux-firmware only, then the driver is still not
> >     loading even though it could.
> >
> >   - If we have gotten our firmware through some other mean, then the
> >     driver is still not loading even though it could.
>=20
> You will still need to update parts of the kernel, too.

Not really, no. We can use the AM62x as an example. The only thing that
was required to enable the driver (excluding the driver itself of
course) was a single DT patch, without anything you've mentioned so far.

> As long as none of that has happened, asking about the PowerVR driver
> on non-AM62x hardware is futile...

Maybe. Just like asking whether you want to enable the UMS driver on
platforms that don't have a USB controller. Or, closer to us, whether
you want to enable AMDGPU on platforms without a PCIe bus.

We *never* do that.

If only because we can't. We don't have a per-SoC Kconfig option, so
even if we were to merge your patch, we would still ask about the
PowerVR driver on, let's say, the AM69 that isn't an AM62x and is just
as futile according to you. Or for the TDA4VM, or...

The other reason is that it's just impossible to maintain. You wouldn't
expect everyone, once they got their USB support in, to amend the
Kconfig dependencies for every USB driver out there, would you?

> > It makes life harder for everyone: maintainers, users, devs, based on
> > the state of some external project that might or might not be updated in
> > sync.
> >
> > > Once it becomes truly generic, I'm happy to drop all platform
> > > dependencies.  Until then, there is no point in asking everyone who
> > > configures an arm64 kernel about this driver, unless they also enabled
> > > K3 support.
> >
> > Whether it's truly generic, whatever that means, is irrelevant here.
>=20
> It is.
>=20
> BTW, playing the devil's advocate: why is there a dependency on ARM64?
> PowerVR GPUs are also present on (at least) arm32 and Intel?

I would welcome any patch extending that requirement, or droping that
requirement.

> Oh, dropping that would expose this question to Linus, causing his
> wrath to come down on you... ;-)

Don't threaten me with a good time.

Also, it's already the case for AMDGPU or etnaviv, so I'm not sure what
Linus would have to say about it exactly.

Maxime

--yx7wzbz23427lvci
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZWcXVQAKCRDj7w1vZxhR
xe4iAP0S8WUtCdEHdQaJxR3zaKr/rzw0303I3Yl5JmXICbRBewD+N4wMbPUxk5VL
ksYWrqfbRmLdl9IYAysuz9gws84lSA0=
=avTD
-----END PGP SIGNATURE-----

--yx7wzbz23427lvci--
