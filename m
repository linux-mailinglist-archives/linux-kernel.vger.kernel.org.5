Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CFEB7FD5CD
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 12:34:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232908AbjK2Leh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 06:34:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231922AbjK2Leg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 06:34:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39FB1AF
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 03:34:42 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5986AC433C7;
        Wed, 29 Nov 2023 11:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701257681;
        bh=mMRbTqSRjry27OZzSlJAoNjsdNzC39AmCY+m+oQr4gc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VpB32sqNW0ZtA4L2yZOPMG26ppig0sEA1px0EX6eQm+3/RhyNhgVKYJG31gFn//qh
         2BCCJuDmC6jV9q3V9YvHZY3L8evCSvqFyz1dCpoWs43itGw/PSTCjfM/JXO6jFPRFe
         eHs1z8tqv3gmy4sWdl06Ic1lGrmKIC9+5k6NRZVv9CKJBMqUlvbtgQjw+qrRpHfK6H
         w4tkQs3NMBzHbVqSa2m6HkQsgjOxWmamNWf/ZQMrkwGc8iqpHtwihKDGX3F6Kk4EKM
         sl8+WVx5z4/xiop1rtFlRvEfWqSQOoIoZMCvOJt62hOQ2JYNaRAB3F5hLPmIr6vO23
         zvNYZUMDyVuEg==
Date:   Wed, 29 Nov 2023 12:34:39 +0100
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
Message-ID: <mqi7tvvtkgeqxbdyas7cjzzssfjcskfdiigv4owztsuz6a2nrn@sgmkhj4ljefq>
References: <b9360c2044a1001b9a5bcb5914611711d040d4fe.1701196029.git.geert+renesas@glider.be>
 <87o7fdbszs.fsf@minerva.mail-host-address-is-not-set>
 <CAMuHMdUhuO++ZSxh+_TX_6DHHxjPYY20jTppbNZ4FnuBvxxinQ@mail.gmail.com>
 <7hee65pmdl5pajm2kgqld22xfi4iox4s2psswu2mdlfk6u6f7x@w4ecogdx6uj6>
 <CAMuHMdVTZ8LT1yU3e1bbJODecy96TaMX1hq_swqmT6L+mbH3aQ@mail.gmail.com>
 <sw5e3mdtbmywbeo6sok4ul5qe72bb5ltsg5ago2vliqxlahvpl@rcivlupw77a5>
 <CAMuHMdVVb2VfEAgh+59juyTH28EvRMPHEsxT-MUiEQcmJHTD+Q@mail.gmail.com>
 <u42osuikwzf372mb5xkhiyaycxpmduc5ntyanjlauqca6roeh4@i7zqwu36lzko>
 <CAMuHMdW2wCeHU+4HRoT_CM6noMzQjanmvMk5=Wg0t98tg9o1Qw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fed6eofzqbwoj437"
Content-Disposition: inline
In-Reply-To: <CAMuHMdW2wCeHU+4HRoT_CM6noMzQjanmvMk5=Wg0t98tg9o1Qw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fed6eofzqbwoj437
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 12:08:17PM +0100, Geert Uytterhoeven wrote:
> Hi Maxime,
>=20
> On Wed, Nov 29, 2023 at 11:50=E2=80=AFAM Maxime Ripard <mripard@kernel.or=
g> wrote:
> > On Wed, Nov 29, 2023 at 11:10:51AM +0100, Geert Uytterhoeven wrote:
> > > On Wed, Nov 29, 2023 at 10:23=E2=80=AFAM Maxime Ripard <mripard@kerne=
l.org> wrote:
> > > > On Wed, Nov 29, 2023 at 09:58:12AM +0100, Geert Uytterhoeven wrote:
> > > > > On Wed, Nov 29, 2023 at 9:35=E2=80=AFAM Maxime Ripard <mripard@ke=
rnel.org> wrote:
> > > > > > On Tue, Nov 28, 2023 at 08:16:18PM +0100, Geert Uytterhoeven wr=
ote:
> > > > > > > On Tue, Nov 28, 2023 at 8:03=E2=80=AFPM Javier Martinez Canil=
las
> > > > > > > <javierm@redhat.com> wrote:
> > > > > > > > Geert Uytterhoeven <geert+renesas@glider.be> writes:
> > > > > > > > > The Imagination Technologies PowerVR Series 6 GPU is curr=
ently only
> > > > > > > > > supported on Texas Instruments K3 AM62x SoCs.  Hence add =
a dependency on
> > > > > > > > > ARCH_K3, to prevent asking the user about this driver whe=
n configuring a
> > > > > > > > > kernel without Texas Instruments K3 Multicore SoC support.
> > > > > > > > >
> > > > > > > > > Fixes: 4babef0708656c54 ("drm/imagination: Add skeleton P=
owerVR driver")
> > > > > > > > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.b=
e>
> > > > >
> > > > > > > > In any case, I agree with you that restricting to only K3 m=
akes sense.
> > > > > > >
> > > > > > > I am looking forward to adding || SOC_AM33XX || ARCH_RENESAS =
|| ...,
> > > > > > > eventually ;-)
> > > > > >
> > > > > > I disagree. This is to handle a generic IP, just like panfrost,=
 lima, or
> > > > > > etnaviv, and we certaintly don't want to maintain the Kconfig l=
ist of
> > > > > > every possible architecture and SoC family it might or might no=
t be
> > > > > > found.
> > > > >
> > > > > While PowerVR is a generic IP, I believe it needs a non-generic
> > > > > firmware, which is currently only available for AM62x SoCs.
> >
> > I just asked, it's not true in most cases. There's some exceptions
> > (GX6250 for example) that could require different firmwares depending on
> > the SoC it's used in, but it's not the case here.
>=20
> OK, please tell me how to use it on e.g. R-Car Gen3.

I'm not very familiar with the R-Car family of SoCs.

However, if I'm to trust that page: https://www.renesas.com/us/en/products/=
automotive-products/automotive-system-chips-socs

None of them feature the same GPU than the AM62x, so that question is
completely different?

> > > > I'm not sure it's actually true, but let's consider it is. Then wha=
t? If
> > > > the firmware isn't there and/or the DT bits too, then nothing will
> > > > happen. We would have wasted a couple of 100kB on a system that is
> > > > taking somewhere in the 100MB-10GB range, and that's pretty much it.
> > >
> > > I am talking about posing the question to the user to enable the driv=
er
> > > or not.  Which applies to everyone who configures a kernel.
> >
> > If that user doesn't use a defconfig, doesn't use any variant of
> > *defconfig make target. Plus, the driver still isn't enabled by default.
> >
> > > > If you have we take that patch in though, we have:
> > > >
> > > >   - To keep merging patches as firmwares become available.
> > >
> > > You need to keep merging patches to update DT bindings, DTS,
> > > SoC-specific drivers, the DRM driver itself, ... too.
> >
> > The DT binding and DRM driver is already there, the SoC specific drivers
>=20
> The DT binding only lists "ti,am62-gpu" with "img,img-axe" as a fallback.

Sure. And the driver matches on img,img-axe, so it would probe fine even
with a different first compatible.

> > are probably already there by the time you reach GPU enablement, and the
> > DT doesn't have to be upstream.
>=20
> And getting it upstream requires updating the bindings...

Right. And you still don't have to put it upstream, so the binding isn't
a requirement either.

> > > >   - If we update linux-firmware only, then the driver is still not
> > > >     loading even though it could.
> > > >
> > > >   - If we have gotten our firmware through some other mean, then the
> > > >     driver is still not loading even though it could.
> > >
> > > You will still need to update parts of the kernel, too.
> >
> > Not really, no. We can use the AM62x as an example. The only thing that
> > was required to enable the driver (excluding the driver itself of
> > course) was a single DT patch, without anything you've mentioned so far.
>=20
> Who added:
>=20
> Documentation/devicetree/bindings/gpu/img,powervr.yaml-          - ti,am6=
2-gpu
> Documentation/devicetree/bindings/gpu/img,powervr.yaml:      - const:
> img,img-axe # IMG AXE GPU model/revision is fully discoverable
>=20
> ?

Which is a formality, part of the upstreaming process, but not required
at all from a technical point of view to make a driver probe.

> > > As long as none of that has happened, asking about the PowerVR driver
> > > on non-AM62x hardware is futile...
> >
> > Maybe. Just like asking whether you want to enable the UMS driver on
> > platforms that don't have a USB controller. Or, closer to us, whether
> > you want to enable AMDGPU on platforms without a PCIe bus.
> >
> > We *never* do that.
>=20
> Thanks for not checking ;-)
>=20
>     if USB
>     [...]
>     source "drivers/usb/storage/Kconfig"
>=20
>     config DRM_AMDGPU
>             tristate "AMD GPU"
>             depends on DRM && PCI && MMU

I'm not seeing any platform Kconfig option there.

Most importantly, you were arguing that the GPU should be enabled only
on systems where the GPU is in the SoC, with a firmware in
linux-firmware, and the DT bits in.

And you're now making it equivalent to "the framework handling that
device is compiled in", which I fully agree with: of course a USB device
driver should only be compiled if the USB framework is there.

But "having the framework compiled" and "a controller is functional on a
platform" is completely different, and you know that very well otherwise
you wouldn't have sent that patch in the first place.

> > If only because we can't. We don't have a per-SoC Kconfig option, so
> > even if we were to merge your patch, we would still ask about the
> > PowerVR driver on, let's say, the AM69 that isn't an AM62x and is just
> > as futile according to you. Or for the TDA4VM, or...
>=20
> That's why we use per-family options.  It's the next best thing we have.
>=20
> > The other reason is that it's just impossible to maintain. You wouldn't
> > expect everyone, once they got their USB support in, to amend the
> > Kconfig dependencies for every USB driver out there, would you?
>=20
> USB devices are (usually) truly generic, and can be plugged in
> everywhere you see a USB port.
>=20
> > > > It makes life harder for everyone: maintainers, users, devs, based =
on
> > > > the state of some external project that might or might not be updat=
ed in
> > > > sync.
> > > >
> > > > > Once it becomes truly generic, I'm happy to drop all platform
> > > > > dependencies.  Until then, there is no point in asking everyone w=
ho
> > > > > configures an arm64 kernel about this driver, unless they also en=
abled
> > > > > K3 support.
> > > >
> > > > Whether it's truly generic, whatever that means, is irrelevant here.
> > >
> > > It is.
> > >
> > > BTW, playing the devil's advocate: why is there a dependency on ARM64?
> > > PowerVR GPUs are also present on (at least) arm32 and Intel?
> >
> > I would welcome any patch extending that requirement, or droping that
> > requirement.
> >
> > > Oh, dropping that would expose this question to Linus, causing his
> > > wrath to come down on you... ;-)
> >
> > Don't threaten me with a good time.
> >
> > Also, it's already the case for AMDGPU or etnaviv, so I'm not sure what
> > Linus would have to say about it exactly.
>=20
> AMDGPU is a PCI device, and can be plugged everywhere you see a PCI
> slot.  Etnaviv could indeed use some dependencies...

It might be plugged in any PCIe slot. It will not work with any PCIe
controller.

Anyway, there's no point in discussing it further. We're at the point of
sending blank threats so it's not super productive anyway.

As far as I'm concerned, and if there's no new actual technical
argument,

NAK.

Maxime

--fed6eofzqbwoj437
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZWchzgAKCRDj7w1vZxhR
xfe+AQDAyI5LhJvTB+kK8baNCUxM061urbuCKhPG9XEwpGdMFQEA8x6djUM2dozz
t1VDKHthZnyEvfxZOT00SqTtRniaiw0=
=PeKO
-----END PGP SIGNATURE-----

--fed6eofzqbwoj437--
