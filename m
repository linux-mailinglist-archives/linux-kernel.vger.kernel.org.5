Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06F0078B5AB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 18:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbjH1Qxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 12:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232786AbjH1QxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 12:53:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D6D499;
        Mon, 28 Aug 2023 09:53:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C58160C63;
        Mon, 28 Aug 2023 16:53:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B99E6C433C8;
        Mon, 28 Aug 2023 16:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693241600;
        bh=2xkAGTz0idZHpIs33vvC65PnBaJbc1Fr+Y/VfWwFyo8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ezf1wcTYRdVSt3bqr6xYHaNkTAxSMy/queeASNUVoCjXPHK3bx5auLzYQNARkEFjK
         VKxY3cIz9lqo7p+cEd3LN2TSS9HyS1XSjaTjEkCThzk0Wnug92MUlUIdoWaE3N++Nq
         LL0BtLLwlmsfW57FrQMX4AMUdN77d3VMHzwgPzic3o82P0c3p3/iGpj9DUw/8VFkZJ
         x2FpDg3p8TW77ZP371cyEKq/ljhpWA9mJ6avygtuAUzz4zrsK8xrLcUVwXfR6tZmAk
         wjQ6sHFOk71gZVqESI67GFjI56hcdFbKmFfhcxM3V/xFpmRiTn3NHnRHFlF4LFQSTA
         78PPqjVOC4nOg==
Date:   Mon, 28 Aug 2023 17:53:15 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Evan Green <evan@rivosinc.com>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Stuebner <heiko@sntech.de>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org,
        Andrew Jones <ajones@ventanamicro.com>
Subject: Re: [PATCH v5] RISC-V: Show accurate per-hart isa in /proc/cpuinfo
Message-ID: <20230828-dangling-decency-ededaa58d014@spud>
References: <20230825231139.1145522-1-evan@rivosinc.com>
 <20230826-anguished-tutu-81d63b3081a7@spud>
 <20230826-copper-suffocate-5f4f0e67f9a7@spud>
 <CALs-HsvwLpcUMPeKEs3ZW3tOwLGeGRQSe=grxE5L14Tj8b+XHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="aCAI2NXGHYe29Jnj"
Content-Disposition: inline
In-Reply-To: <CALs-HsvwLpcUMPeKEs3ZW3tOwLGeGRQSe=grxE5L14Tj8b+XHw@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--aCAI2NXGHYe29Jnj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 28, 2023 at 09:24:03AM -0700, Evan Green wrote:
> On Sat, Aug 26, 2023 at 2:56=E2=80=AFAM Conor Dooley <conor@kernel.org> w=
rote:
> >
> > On Sat, Aug 26, 2023 at 12:26:25AM +0100, Conor Dooley wrote:
> > > On Fri, Aug 25, 2023 at 04:11:38PM -0700, Evan Green wrote:
> > > > In /proc/cpuinfo, most of the information we show for each processo=
r is
> > > > specific to that hart: marchid, mvendorid, mimpid, processor, hart,
> > > > compatible, and the mmu size. But the ISA string gets filtered thro=
ugh a
> > > > lowest common denominator mask, so that if one CPU is missing an ISA
> > > > extension, no CPUs will show it.
> > > >
> > > > Now that we track the ISA extensions for each hart, let's report ISA
> > > > extension info accurately per-hart in /proc/cpuinfo. We cannot chan=
ge
> > > > the "isa:" line, as usermode may be relying on that line to show on=
ly
> > > > the common set of extensions supported across all harts. Add a new =
"hart
> > > > isa" line instead, which reports the true set of extensions for that
> > > > hart.
> > > >
> > > > Signed-off-by: Evan Green <evan@rivosinc.com>
> > > > Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> > >
> > > > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > >
> > > Can you drop this if you repost?
>=20
> Will do.
>=20
> > >
> > > > +"isa" vs "hart isa" lines in /proc/cpuinfo
> > > > +------------------------------------------
> > > > +
> > > > +The "isa" line in /proc/cpuinfo describes the lowest common denomi=
nator of
> > > > +RISC-V ISA extensions recognized by the kernel and implemented on =
all harts. The
> > > > +"hart isa" line, in contrast, describes the set of extensions reco=
gnized by the
> > > > +kernel on the particular hart being described, even if those exten=
sions may not
> > > > +be present on all harts in the system.
> > >
> > > > In both cases, the presence of a feature
> > > > +in these lines guarantees only that the hardware has the described=
 capability.
> > > > +Additional kernel support or policy control changes may be require=
d before a
> > > > +feature is fully usable by userspace programs.
> > >
> > > I do not think that "in both cases" matches the expectations of
> > > userspace for the existing line. It's too late at night for me to thi=
nk
> > > properly, but I think our existing implementation does work like you
> > > have documented for FD/V. I think I previously mentioned that it could
> > > misreport things for vector during the review of the vector series but
> > > forgot about it until now.
> >
> > I went and checked, and yes it does currently do that for vector. I
> > don't think that that is what userspace would expect, that Google
> > cpu_features project for example would draw incorrect conclusions.
>=20
> I'm lost, could you explain a little more?

There (may be/)are userspace programs that will interpret the appearance
of extensions in cpuinfo as meaning they can be used without performing
any further checks.

> My goal was to say that
> there's no blanket guarantee that the feature is 100% ready to go for
> userspace just because it's seen here.

Right. I was agreeing that this is true, but it is also not how some
userspace programs have interpreted things. Consider a platform & kernel
that support the V extension but vector has not been enabled by default
or by early userspace. If someone cats cpuinfo, they'll see v there, but
it won't be usable. That Google cpu_features project (or a punter) may
then assume they can use it, as that's been the case so far in general*.

The caveat producing the * being that the same problem actually exists
for F/D too AFAICT, but it's likely that nobody really encountered it
as they didn't build non-FP userspaces & then try to use FP in some
userspace applications.

> For some extensions, it may in
> fact end up meaning just that (hence the "additional ... may be
> required" rather than "is required").

> This is true for FD (maybe,
> depending on history?),

AFAICT, it's not true for FD. The FPU config option not being set, or
either of F and D being missing will lead to unusable extensions
appearing.

> or extensions whose minimal/zero kernel
> support was unconditionally added at the same time as its parsing for
> it. But it's not true solely by virtue of being in /proc/cpuinfo. In
> other words, I'm trying to establish the floor of what /proc/cpuinfo
> guarantees, without fully specifying the ceiling.

> Are you saying that
> we need to spell out the guarantees for each extension?

No, I don't want that!

> Or are you
> saying the floor I've defined in general is incorrect or insufficient?

I think the floor that you have defined is probably misleading to users.
It's also the floor that has existed for quite a while, so this might be
a case of the userspace devs messing up due to an absence of any
explanation of what to do here.
Things will get abhorrently messy if we try to do what these userspace
programs expect, and I don't think we should go there. We just need to
bear in mind that the behaviour we have & the behaviour that you are
documenting flys in the face of what some userspace expects.

> I'm also open to direct suggestions of wording if you've got something
> in mind :)

Someone mentioned it recently, but it really is starting to feel more
and more like lscpu should grow support for hwprobe and funnel people
into using that instead of /proc/cpuinfo when all they want is to see
what their hardware can do.

--aCAI2NXGHYe29Jnj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZOzQ+wAKCRB4tDGHoIJi
0j1CAQCe8GWS5VD8NFejCRPuSJ6/pP1JUyquNhe39pMWCPiWeAEAn8aUvX+1hEc/
vqfunXKaopveZfu1/fwF0cv2XyTnNw0=
=zgPv
-----END PGP SIGNATURE-----

--aCAI2NXGHYe29Jnj--
