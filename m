Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 539A9787B7F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 00:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243914AbjHXW2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 18:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243924AbjHXW2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 18:28:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 009581BE9;
        Thu, 24 Aug 2023 15:28:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B756637B1;
        Thu, 24 Aug 2023 22:28:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AC09C433C8;
        Thu, 24 Aug 2023 22:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692916084;
        bh=WqAtIq7IsK7szXpa+lBv1CmFm3GRA8mTZ5KiH4fule0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IeOJc5nz1D9s4Qd5dmZEDDBfsaqFQbiSR98xd7n3eB2nFKcjd+cR1xugj30C0OjgV
         UUs5RtQmBljfAlcly0aCTSIHaFc0B3vMKnzGfSMLz2nHL0JWDyQ0aW0hG+uSz0nX+Q
         zQXPjCiEr4gtYprz6xilHexYCBU0hWpNiE825PzGO+lkdlESMfwpqXdP5YstV7YWQy
         Lbc8oRodkf4ql6gJzhnBDOlvAXMzhs/LWoC+g9xF0G6Q+ZXqqkQAlXG5vPAVq2cvSx
         rv0s15OUAjwfs9nf2d6vmzFaEBDEwv6XpuyodTJqMFPtfwlGE1OD8KarqqAWvYz1yD
         OUrtBxjpTG2DQ==
Date:   Thu, 24 Aug 2023 23:27:59 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Evan Green <evan@rivosinc.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Andrew Jones <ajones@ventanamicro.com>
Subject: Re: [PATCH v4] RISC-V: Show accurate per-hart isa in /proc/cpuinfo
Message-ID: <20230824-sizing-booth-e1068c6d033f@spud>
References: <20230711201831.2695097-1-evan@rivosinc.com>
 <20230824-factual-jawed-2dddd2cf2bdd@wendy>
 <CALs-Hss51fQE1yxe1Y1T86X+OfjPaAd386vosQ8gzRm=Njm1gw@mail.gmail.com>
 <20230824-exploit-spectacle-ecedd91e9075@spud>
 <CALs-HssqaOjvUOdBVn=oN+uzkkmjguys2UttTYgdcqJwJB0HnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="9nRT9N61BFY+AwES"
Content-Disposition: inline
In-Reply-To: <CALs-HssqaOjvUOdBVn=oN+uzkkmjguys2UttTYgdcqJwJB0HnQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9nRT9N61BFY+AwES
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 24, 2023 at 03:06:53PM -0700, Evan Green wrote:
> On Thu, Aug 24, 2023 at 10:29=E2=80=AFAM Conor Dooley <conor@kernel.org> =
wrote:
> > On Thu, Aug 24, 2023 at 09:18:16AM -0700, Evan Green wrote:
> > > On Thu, Aug 24, 2023 at 5:20=E2=80=AFAM Conor Dooley <conor.dooley@mi=
crochip.com> wrote:
> > > > On Tue, Jul 11, 2023 at 01:18:30PM -0700, Evan Green wrote:

> > > > > +"isa" vs "hart isa" lines in /proc/cpuinfo
> > > > > +------------------------------------------
> > > > > +
> > > > > +The "isa" line in /proc/cpuinfo describes the lowest common deno=
minator of
> > > > > +RISC-V ISA extensions understood by the kernel and implemented o=
n all harts. The
> > > > > +"hart isa" line, in contrast, describes the set of extensions un=
derstood by the
> > > > > +kernel on the particular hart being described, even if those ext=
ensions may not
> > > > > +be present on all harts in the system. The "hart isa" line is co=
nsistent with
> > > > > +what's returned by __riscv_hwprobe() when querying for that spec=
ific CPU.
> > > >
> > > > Thinking about this again, I don't think this is true. hwprobe uses
> > > > has_fpu(), has_vector() etc that interact with Kconfig options but =
the
> > > > percpu isa bitmap isn't affected by these.
> > >
> > > Ugh yeah it's kind of a mishmash isn't it. hwprobe_isa_ext0() uses the
> > > lowest common denominator for FD, C, V, but per-hart info for
> > > Zba,Zbb,Zbs. Given the interface, per-hart info seems like what we
> > > should have done there, and the FD, C, and V were my bad. The good
> > > news is we can define new bits that do the right thing, though maybe
> > > we should wait until someone actually wants them. For this patch we
> > > should just remove this sentence. We can also correct the
> > > documentation in hwprobe to mention the shortcoming in FD,C,V.
> >
> > I'm not really sure it's all that much of a shortcoming for V or FD,
> > since without the kernel support you shouldn't be using those extensions
> > anyway. A hwprobe thing for that sounds like a footgun to me & I think
> > the current behaviour is how it should be for these extensions.
> > It not being per-cpu is arguably a bug I suppose? But I would contend
>=20
> Yeah it was mostly the not being per-cpu I was pointing to in my previous=
 email.
>=20
> > that we are conveying support for the extension on a per-hart level,
> > with it then also gated by the kernel supporting V or FD, which is on a
> > system-wide basis.
> > Any other extensions that require Kconfig-gated kernel support should
> > also not report via hwprobe that the extension is supported when the
> > Kconfig option is disabled. It just so happens that the set of
> > extensions that hwprobe supports that are Kconfig-gated and those that
> > require all-hart support are one and the same right now, so we can kinda
> > just conflate the two & use has_vector() et al that handles both
> > kconfig-gating and all-hart support. Until something comes along that n=
eeds
> > anything different, I'd leave well enough alone for hwprobe...
>=20
> Sounds good.
>=20
> >
> > > Palmer, do you want a spin of this patch or a followup on top to
> > > remove the above sentence?
> >
> > It's not actually been applied yet, right?
> >
> > Do you want to have this new thing in cpuinfo tell the user "this hart
> > has xyz extensions that are supported by a kernel, but maybe not this
> > kernel" or to tell the user "this hart has xyz extensions that are
> > supported by this kernel"? Your text above says "understood by the
> > kernel", but I think that's a poor definition that needs to be improved
> > to spell out exactly what you mean. IOW does "understood" mean the
> > kernel will parse them into a structure, or does it mean "yes you can
> > use this extension on this particular hart".
>=20
> I'm imagining /proc/cpuinfo being closer to "the CPU has it and the
> kernel at least vaguely understands it, but may not have full support
> for it enabled". I'm assuming /proc/cpuinfo is mostly used by 1)
> humans wanting to know if they have hardware support for a feature,
> and 2) administrators collecting telemetry to manage fleets (ie do I
> have any hardware deployed that supports X). Programmers looking to
> see "is the kernel support for this feature ready right now" would
> ideally not be parsing /proc/cpuinfo text, as more direct mechanisms
> like specific hwprobe bits for "am I fully ready to go" would be
> easier to work with. Feel free to yell at me if this overall vision
> seems flawed.
>=20
> I tried to look to see if there was consensus among the other
> architectures. Aarch64 seems to go with "supported and fully enabled",
> as their cpu_has_feature() directly tests elf_hwcap, and elements in
> arm64_elf_hwcaps[] are Kconfig gated. X86 is complicated, but IIRC is
> more along the lines of "hardware has it". They have two macros,
> cpu_has() for "raw capability" and cpu_feature_enabled() for "kernel
> can do it too", and they use cpu_has() for /proc/cpuinfo flags.

I'm fine with the per-cpu stuff meaning "the hardware has it and a kernel,
but not necessarily this one, supports it" - just please make the
documentation clear about it.

--9nRT9N61BFY+AwES
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZOfZbwAKCRB4tDGHoIJi
0j96AQCz2U9LEfRGbkVV3MA8SeG92ywPIkT6Jw9jbptC9rmgZwEA8F/03WtMvHqs
pSIHopIVSUU7IrR9ZUgxILoDJjT7ZA8=
=d2M6
-----END PGP SIGNATURE-----

--9nRT9N61BFY+AwES--
