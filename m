Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF6C78B627
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 19:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbjH1ROc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 13:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232852AbjH1ROU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 13:14:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F09ED1AA;
        Mon, 28 Aug 2023 10:14:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8E25464DE2;
        Mon, 28 Aug 2023 17:14:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E49AC433C7;
        Mon, 28 Aug 2023 17:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693242840;
        bh=FOkV7yPXUTKCY+8e4n1fvk3H2HGOvC/3kmnoKum8M+4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LvS38BCw8YQG0WpYxcdTcAqnXRbR9rn3hB0mPrN788KlVO9qNZfDvWQOkc4N5Ipdw
         u/l5NzfXsxqK5Lao0VDNS/2CZeOncgmhn5m5nHX0fZcdT4T686b6/G9SC5ab4W8pNM
         G+XNJJoj4vNj8lS2DzoWNrLNcJdfBZIQOdKTmXEKdpcUOy3Gv2sh5p1mY1aBo3UMEt
         H7dw9Ov2dP5tis/Ysy63UA11F0R/7xP0lmcrBzyizV+EZWdi019OhxmCiZLNiJ7rD1
         dIuoFlOjVGyI56OrydvZQP9wX79ZJdWqdVCqQBtLNjgQ9L3sdh7SsRNsUSZTqJmPve
         3uLQfmA4dnzog==
Date:   Mon, 28 Aug 2023 18:13:54 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Evan Green <evan@rivosinc.com>
Cc:     Andrew Jones <ajones@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org,
        Heiko Stuebner <heiko.stuebner@vrull.eu>
Subject: Re: [PATCH v4] RISC-V: Show accurate per-hart isa in /proc/cpuinfo
Message-ID: <20230828-unwelcome-cauterize-8db7188a5e07@spud>
References: <20230711201831.2695097-1-evan@rivosinc.com>
 <20230824-factual-jawed-2dddd2cf2bdd@wendy>
 <CALs-Hss51fQE1yxe1Y1T86X+OfjPaAd386vosQ8gzRm=Njm1gw@mail.gmail.com>
 <20230824-exploit-spectacle-ecedd91e9075@spud>
 <CALs-HssqaOjvUOdBVn=oN+uzkkmjguys2UttTYgdcqJwJB0HnQ@mail.gmail.com>
 <20230825-374a82446ed3eea02fcb41e6@orel>
 <CALs-HstfA29DDrmVemP6bZe+kON9JDKYR3p132gG_WefA6d7eQ@mail.gmail.com>
 <20230826-3869468d499caf2850681d08@orel>
 <CALs-HsskEUu3cu8pAc272Z47ro25e=fyuPt8jQBcJE2_RmFGtQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="CLJlKiYV2dRbV0kf"
Content-Disposition: inline
In-Reply-To: <CALs-HsskEUu3cu8pAc272Z47ro25e=fyuPt8jQBcJE2_RmFGtQ@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--CLJlKiYV2dRbV0kf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 28, 2023 at 09:44:55AM -0700, Evan Green wrote:
> On Sat, Aug 26, 2023 at 1:01=E2=80=AFAM Andrew Jones <ajones@ventanamicro=
=2Ecom> wrote:
> >
> > On Fri, Aug 25, 2023 at 03:51:28PM -0700, Evan Green wrote:
> > > On Fri, Aug 25, 2023 at 1:16=E2=80=AFAM Andrew Jones <ajones@ventanam=
icro.com> wrote:
> > > >
> > > > On Thu, Aug 24, 2023 at 03:06:53PM -0700, Evan Green wrote:
> > > > > On Thu, Aug 24, 2023 at 10:29=E2=80=AFAM Conor Dooley <conor@kern=
el.org> wrote:
> > > > ...
> > > > > > Do you want to have this new thing in cpuinfo tell the user "th=
is hart
> > > > > > has xyz extensions that are supported by a kernel, but maybe no=
t this
> > > > > > kernel" or to tell the user "this hart has xyz extensions that =
are
> > > > > > supported by this kernel"? Your text above says "understood by =
the
> > > > > > kernel", but I think that's a poor definition that needs to be =
improved
> > > > > > to spell out exactly what you mean. IOW does "understood" mean =
the
> > > > > > kernel will parse them into a structure, or does it mean "yes y=
ou can
> > > > > > use this extension on this particular hart".
> > > > >
> > > > > I'm imagining /proc/cpuinfo being closer to "the CPU has it and t=
he
> > > > > kernel at least vaguely understands it, but may not have full sup=
port
> > > > > for it enabled". I'm assuming /proc/cpuinfo is mostly used by 1)
> > > > > humans wanting to know if they have hardware support for a featur=
e,
> > > > > and 2) administrators collecting telemetry to manage fleets (ie d=
o I
> > > > > have any hardware deployed that supports X).
> > > >
> > > > Is (2) a special case of (1)? (I want to make sure I understand all=
 the
> > > > cases.)
> > >
> > > More or less, yes. In bucket two are also folks wondering things like
> > > "are all these crash reports I'm getting specific to machines with X".
> > >
> > > >
> > > > > Programmers looking to
> > > > > see "is the kernel support for this feature ready right now" would
> > > > > ideally not be parsing /proc/cpuinfo text, as more direct mechani=
sms
> > > > > like specific hwprobe bits for "am I fully ready to go" would be
> > > > > easier to work with. Feel free to yell at me if this overall visi=
on
> > > > > seems flawed.
> > > > >
> > > > > I tried to look to see if there was consensus among the other
> > > > > architectures. Aarch64 seems to go with "supported and fully enab=
led",
> > > > > as their cpu_has_feature() directly tests elf_hwcap, and elements=
 in
> > > > > arm64_elf_hwcaps[] are Kconfig gated. X86 is complicated, but IIR=
C is
> > > > > more along the lines of "hardware has it". They have two macros,
> > > > > cpu_has() for "raw capability" and cpu_feature_enabled() for "ker=
nel
> > > > > can do it too", and they use cpu_has() for /proc/cpuinfo flags.
> > > > >
> > > >
> > > > I'd lean more towards the way AArch64 goes, because, unless /proc/c=
puinfo
> > > > is just a blind regurgitation of an isa string from DT / ACPI, then=
 the
> > > > kernel must at least know something about it. Advertising a feature=
 which
> > > > is known, but also known not to work, seems odd to me. So my vote i=
s that
> > > > only features which are present and enabled in the kernel or presen=
t and
> > > > not necessary to be enabled in the kernel in order for userspace or
> > > > virtual machines to use be advertised in /proc/cpuinfo.
> > > >
> > > > We still have SMBIOS (dmidecode) to blindly dump what the hardware
> > > > supports for cases (1) and (2) above.
> > >
> > > Yeah, there's an argument to be made for that. My worry is it's a
> > > difficult line to hold. The bar you're really trying to describe (or
> > > at least what people might take away from it) is "if it's listed here
> > > then it's fully ready to be used in userspace". But then things get
> > > squishy when there are additional ways to control the use of the
> > > feature (prctls() in init to turn it on, usermode policy to turn it
> > > off, security doodads that disable it, etc). I'm assuming nobody wants
> > > a version of /proc/cpuinfo that changes depending on which process is
> > > asking. So then the line would have to be more carefully described as
> > > "well, the hardware can do it, and the kernel COULD do it under some
> > > circumstances, but YMMV", which ends up falling somewhat short of the
> > > original goal. In my mind keeping /proc/cpuinfo as close to "here's
> > > what the hardware can do" seems like a more defensible position.
> > > -Evan
> >
> > I agree with that. I was actually even trying to say the same thing,
> > but only by bringing up virtual machines. Once we decide we'll expose
> > extensions to VMs, whether or not the host kernel enables them, then
> > none of the other host kernel configurations matter with respect to
> > advertising the feature, since the guest kernel may have a completely
> > different set of configurations.
>=20
> My head spins a little when I try to picture a feature which 1)
> requires kernel support to use, 2) has that kernel support turned off
> in the host kernel, but 3) is passed down into guest kernels.

Mine did too, but apparently these already exist for kvm guests. I can't
find the exact email, but either Drew or Anup told me that Svpbmt can be
used by a guest even if support for it is not present in the host
kernel.

Thanks,
Conor.

> Generally though, I agree that trying to tie the guarantees of
> features in /proc/cpuinfo too much to software gets confusing when
> viewed through the double lens of virtualization.
>=20
> >
> > So I think we should only be filtering out extensions that are disabled
> > because they're broken (have a detected erratum), have been "hidden"
> > (have a kernel command line allowing them to be treated as if not
> > present), or cannot be used at all due to missing accompanying hardware
> > descriptions (such as block size info for CBO extensions). In all cases,
> > I presume we'd wire checks up in riscv_isa_extension_check() and no
> > checks would be gated on Kconfigs or anything else. And, since
> > /proc/cpuinfo gets its list from the bitmap that's already filtered by
> > riscv_isa_extension_check(), then, long story short, we're good to go :=
-)
> >
> > But maybe we can try to spell that policy out a bit more in
> > Documentation/riscv/uabi.rst.
>=20
> Right, that sounds reasonable to me, and is consistent with the
> behavior we already have. With this documentation change I was only
> trying to define the lower bound, rather than the complete definition
> for every case. In other words, seeing a feature in cpuinfo guarantees
> only that the hardware (or virtualized hardware) supports the feature,
> but that's all the language says. So for instance NOT seeing a feature
> in cpuinfo doesn't necessarily mean the hardware doesn't support it.
> Software turning it off for the reasons you describe IMO doesn't
> contradict what's written here. I was planning to leave that tacit,
> but if you have suggestions on how to spell that out I'd take them.
>=20
> -Evan

--CLJlKiYV2dRbV0kf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZOzV0gAKCRB4tDGHoIJi
0uCkAQDrJJBsBDRdSmhWBJEcfmvJYdxtVq9gBPMdZtQUyGmYrwEAvclnY2T0sdV5
yLXH80ZP8ZXhDRxsyrvq72AhliYbAgg=
=xt3A
-----END PGP SIGNATURE-----

--CLJlKiYV2dRbV0kf--
