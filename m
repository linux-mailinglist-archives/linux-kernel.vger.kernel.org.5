Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2693B78B6D7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 19:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232965AbjH1R6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 13:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233027AbjH1R60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 13:58:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0293F9;
        Mon, 28 Aug 2023 10:58:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 40905616E2;
        Mon, 28 Aug 2023 17:58:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6936C433C8;
        Mon, 28 Aug 2023 17:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693245501;
        bh=bXx/kmNErccJ1kDScOf9v40zDw4ERKiaA2oGHkRg8LY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FNzzYv/5GDgzpkVMgp8TtGso8ENsEfSH51zpHazWPFVIoncBn9jIoksrPz+2GciLd
         hmaX4TgfETJBMyNRu2SZPr2GN04CL8xE+a15H9VUYYnHnxft9HPMzBpos2PcWTAfo/
         wheuvfG4DqWv0Rt3nbqpf6lDj+u3VAZvplwf1mCBmY3A93JEPvNrXSngeNEEXpvEWW
         hvl5gVC6jH+6Dk+PqjelcBXSTwzwqLt/2pvB89teYOJMukdRtF34qInFnE9cT6lJzp
         HvbNvl98TeBL4ASEHGvgD5DaZk3lR1let1pfEhfpah0hdnTc4ntQ6XDOYCeGji9wyS
         ABuyr9fRcmCAg==
Date:   Mon, 28 Aug 2023 18:58:16 +0100
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
Message-ID: <20230828-stonewall-eaten-d79cd057c845@spud>
References: <20230825231139.1145522-1-evan@rivosinc.com>
 <20230826-anguished-tutu-81d63b3081a7@spud>
 <20230826-copper-suffocate-5f4f0e67f9a7@spud>
 <CALs-HsvwLpcUMPeKEs3ZW3tOwLGeGRQSe=grxE5L14Tj8b+XHw@mail.gmail.com>
 <20230828-dangling-decency-ededaa58d014@spud>
 <CALs-Hss8KNV9zkEHujVmzb7Rf8Zp9OGkDF9Fj8BCjQuFDYaHHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="NE90RS6KjVwl6f8L"
Content-Disposition: inline
In-Reply-To: <CALs-Hss8KNV9zkEHujVmzb7Rf8Zp9OGkDF9Fj8BCjQuFDYaHHA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NE90RS6KjVwl6f8L
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 28, 2023 at 10:18:24AM -0700, Evan Green wrote:
> On Mon, Aug 28, 2023 at 9:53=E2=80=AFAM Conor Dooley <conor@kernel.org> w=
rote:
> >
> > On Mon, Aug 28, 2023 at 09:24:03AM -0700, Evan Green wrote:
> > > On Sat, Aug 26, 2023 at 2:56=E2=80=AFAM Conor Dooley <conor@kernel.or=
g> wrote:
> > > >
> > > > On Sat, Aug 26, 2023 at 12:26:25AM +0100, Conor Dooley wrote:
> > > > > On Fri, Aug 25, 2023 at 04:11:38PM -0700, Evan Green wrote:
> > > > > > In /proc/cpuinfo, most of the information we show for each proc=
essor is
> > > > > > specific to that hart: marchid, mvendorid, mimpid, processor, h=
art,
> > > > > > compatible, and the mmu size. But the ISA string gets filtered =
through a
> > > > > > lowest common denominator mask, so that if one CPU is missing a=
n ISA
> > > > > > extension, no CPUs will show it.
> > > > > >
> > > > > > Now that we track the ISA extensions for each hart, let's repor=
t ISA
> > > > > > extension info accurately per-hart in /proc/cpuinfo. We cannot =
change
> > > > > > the "isa:" line, as usermode may be relying on that line to sho=
w only
> > > > > > the common set of extensions supported across all harts. Add a =
new "hart
> > > > > > isa" line instead, which reports the true set of extensions for=
 that
> > > > > > hart.
> > > > > >
> > > > > > Signed-off-by: Evan Green <evan@rivosinc.com>
> > > > > > Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> > > > >
> > > > > > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > > > >
> > > > > Can you drop this if you repost?
> > >
> > > Will do.
> > >
> > > > >
> > > > > > +"isa" vs "hart isa" lines in /proc/cpuinfo
> > > > > > +------------------------------------------
> > > > > > +
> > > > > > +The "isa" line in /proc/cpuinfo describes the lowest common de=
nominator of
> > > > > > +RISC-V ISA extensions recognized by the kernel and implemented=
 on all harts. The
> > > > > > +"hart isa" line, in contrast, describes the set of extensions =
recognized by the
> > > > > > +kernel on the particular hart being described, even if those e=
xtensions may not
> > > > > > +be present on all harts in the system.
> > > > >
> > > > > > In both cases, the presence of a feature
> > > > > > +in these lines guarantees only that the hardware has the descr=
ibed capability.
> > > > > > +Additional kernel support or policy control changes may be req=
uired before a
> > > > > > +feature is fully usable by userspace programs.
> > > > >
> > > > > I do not think that "in both cases" matches the expectations of
> > > > > userspace for the existing line. It's too late at night for me to=
 think
> > > > > properly, but I think our existing implementation does work like =
you
> > > > > have documented for FD/V. I think I previously mentioned that it =
could
> > > > > misreport things for vector during the review of the vector serie=
s but
> > > > > forgot about it until now.
> > > >
> > > > I went and checked, and yes it does currently do that for vector. I
> > > > don't think that that is what userspace would expect, that Google
> > > > cpu_features project for example would draw incorrect conclusions.
> > >
> > > I'm lost, could you explain a little more?
> >
> > There (may be/)are userspace programs that will interpret the appearance
> > of extensions in cpuinfo as meaning they can be used without performing
> > any further checks.
> >
> > > My goal was to say that
> > > there's no blanket guarantee that the feature is 100% ready to go for
> > > userspace just because it's seen here.
> >
> > Right. I was agreeing that this is true, but it is also not how some
> > userspace programs have interpreted things. Consider a platform & kernel
> > that support the V extension but vector has not been enabled by default
> > or by early userspace. If someone cats cpuinfo, they'll see v there, but
> > it won't be usable. That Google cpu_features project (or a punter) may
> > then assume they can use it, as that's been the case so far in general*.
> >
> > The caveat producing the * being that the same problem actually exists
> > for F/D too AFAICT, but it's likely that nobody really encountered it
> > as they didn't build non-FP userspaces & then try to use FP in some
> > userspace applications.
> >
> > > For some extensions, it may in
> > > fact end up meaning just that (hence the "additional ... may be
> > > required" rather than "is required").
> >
> > > This is true for FD (maybe,
> > > depending on history?),
> >
> > AFAICT, it's not true for FD. The FPU config option not being set, or
> > either of F and D being missing will lead to unusable extensions
> > appearing.
>=20
> Ah ok.
>=20
> >
> > > or extensions whose minimal/zero kernel
> > > support was unconditionally added at the same time as its parsing for
> > > it. But it's not true solely by virtue of being in /proc/cpuinfo. In
> > > other words, I'm trying to establish the floor of what /proc/cpuinfo
> > > guarantees, without fully specifying the ceiling.
> >
> > > Are you saying that
> > > we need to spell out the guarantees for each extension?
> >
> > No, I don't want that!
> >
> > > Or are you
> > > saying the floor I've defined in general is incorrect or insufficient?
> >
> > I think the floor that you have defined is probably misleading to users.
> > It's also the floor that has existed for quite a while, so this might be
> > a case of the userspace devs messing up due to an absence of any
> > explanation of what to do here.
> > Things will get abhorrently messy if we try to do what these userspace
> > programs expect, and I don't think we should go there. We just need to
> > bear in mind that the behaviour we have & the behaviour that you are
> > documenting flys in the face of what some userspace expects.
>=20
> Thanks, I think I understand now. You're saying the floor I'm defining
> might surprise some users, who were expecting the floor to be "fully
> enabled and ready to party".

Yes.

> Given there was no documentation about it
> before, and this documentation is consistent with what we actually do
> (and there seems to be consensus this is a maintainable position to
> hold), can we just tell those users they're holding it wrong?

I think we have to. Dealing with the vector prctls & sysctls here would
be horrid, as I discussed with Andy on one of the versions of that
series.

> > > I'm also open to direct suggestions of wording if you've got something
> > > in mind :)
> >
> > Someone mentioned it recently, but it really is starting to feel more
> > and more like lscpu should grow support for hwprobe and funnel people
> > into using that instead of /proc/cpuinfo when all they want is to see
> > what their hardware can do.
>=20
> Maybe for the fiddly microarchitectural bits, yeah. But I'd think our
> newly proposed documentation for /proc/cpuinfo of keeping it closer to
> what the hardware can do would suit the lscpu folks' mission well. (In
> ChromeOS at least, we didn't have lscpu, but snarfed /proc/cpuinfo
> directly into feedback reports that consented to sending along system
> info). Really I'd think it's the application/library writers who want
> to know "am I ready to go right now" are who we should be pushing to
> use hwprobe, since we can define those bits to be as specific as we
> want (eg V is on AND it's a full moon, so go for it).
>=20
> Depending on your thoughts on this, if there are changes requested on
> this patch, let me know what they are.

Nah, I think it's fine & the r-b I left on the previous version can stay
:)

--NE90RS6KjVwl6f8L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZOzgOAAKCRB4tDGHoIJi
0sGqAP0WR+lKNV6sYI3gk9/Pb8lzcwHW5J9KJX2jJTtEj7OCegEAkf2RsZ4lbi1Y
t20plNNZNamNXHrilwTeFNa4KklKkgo=
=A3qg
-----END PGP SIGNATURE-----

--NE90RS6KjVwl6f8L--
