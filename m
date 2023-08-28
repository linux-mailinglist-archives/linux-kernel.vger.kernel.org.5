Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDBD678B7A7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 20:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233231AbjH1S4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 14:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233315AbjH1S4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 14:56:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C351A2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 11:56:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8998C63B32
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 18:56:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F8EFC433C9;
        Mon, 28 Aug 2023 18:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693248976;
        bh=OFhBnwoewdY+qFYoIfWuNLyfHMpvi+KJxJhwtNw6GgA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zg6Q5crmZhvX/zWOef3Sx7nkTyzGvtGtiyajLC5yJYEhHdzRP3T9nwWNclwFtyE0n
         t6yEbqVVYFIsHh0uTSc5NfxFMnCq5UhsdUBS6n/qriEl8wnKvdqYiRChOaGHH8B0Y6
         LcJoAV+9yoyeomjyJpI5SskUX2b7C2cJ14s323FpDnZOiTfN3TpAm+BEnL+uCJY/bA
         ht1G1crYB2RnOOL8qZXnGMM/nwH8jZZfrA+4HSDUJI1GKEP/OWnU22FoEQjMd7dGtu
         rD9I3l8Dh9kG3bNnXeOwAq2uB6F8d7F2CcoEWGs6fazPz1jaGR2k985cjwSmUdMFyc
         Ug9802jZne0GQ==
Date:   Mon, 28 Aug 2023 19:56:13 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Charlie Jenkins <charlie@rivosinc.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu
Subject: Re: [PATCH 1/5] riscv: Checksum header
Message-ID: <20230828-stonewall-eloquence-8940f33bd2f0@spud>
References: <20230827-turf-parched-b965bc697882@spud>
 <mhng-d43dc0a3-7985-4195-9611-5ca0c38390e7@palmer-ri-x1c9>
 <20230827-primer-conceal-b6f24b29e692@spud>
 <20230827-divisive-happy-cf93058c49bf@spud>
 <ZOzRlerSNjfzMYGH@ghost>
 <20230828-deserve-paging-25666290e312@spud>
 <ZOzld28wZjLpl4Hp@ghost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7xRodtzpcS727W/L"
Content-Disposition: inline
In-Reply-To: <ZOzld28wZjLpl4Hp@ghost>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7xRodtzpcS727W/L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 28, 2023 at 11:20:39AM -0700, Charlie Jenkins wrote:
> On Mon, Aug 28, 2023 at 06:08:40PM +0100, Conor Dooley wrote:
> > On Mon, Aug 28, 2023 at 09:55:49AM -0700, Charlie Jenkins wrote:
> > > On Sun, Aug 27, 2023 at 01:25:27PM +0100, Conor Dooley wrote:
> > > > On Sun, Aug 27, 2023 at 11:28:33AM +0100, Conor Dooley wrote:
> > > > > On Sat, Aug 26, 2023 at 07:00:47PM -0700, Palmer Dabbelt wrote:
> > > > > > On Sat, 26 Aug 2023 18:42:41 PDT (-0700), Conor Dooley wrote:
> > > > > > > On Sat, Aug 26, 2023 at 06:26:06PM -0700, Charlie Jenkins wro=
te:
> > > > > > > > Provide checksum algorithms that have been designed to leve=
rage riscv
> > > > > > > > instructions such as rotate. In 64-bit, can take advantage =
of the larger
> > > > > > > > register to avoid some overflow checking.
> > > > > > > >=20
> > > > > > > > Add configuration for Zba extension and add march for Zba a=
nd Zbb.
> > > > > > > >=20
> > > > > > > > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > > > > > > > ---
> > > > > > > >  arch/riscv/Kconfig                | 23 +++++++++++
> > > > > > > >  arch/riscv/Makefile               |  2 +
> > > > > > > >  arch/riscv/include/asm/checksum.h | 86 +++++++++++++++++++=
++++++++++++++++++++
> > > > > > > >  3 files changed, 111 insertions(+)
> > > > > > > >=20
> > > > > > > > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > > > > > > > index 4c07b9189c86..8d7e475ca28d 100644
> > > > > > > > --- a/arch/riscv/Kconfig
> > > > > > > > +++ b/arch/riscv/Kconfig
> > > > > > > > @@ -507,6 +507,29 @@ config RISCV_ISA_V_DEFAULT_ENABLE
> > > > > > > >  	  If you don't know what to do here, say Y.
> > > > > > > > +config TOOLCHAIN_HAS_ZBA
> > > > > > > > +	bool
> > > > > > > > +	default y
> > > > > > > > +	depends on !64BIT || $(cc-option,-mabi=3Dlp64 -march=3Drv=
64ima_zba)
> > > > > > > > +	depends on !32BIT || $(cc-option,-mabi=3Dilp32 -march=3Dr=
v32ima_zba)
> > > > > > > > +	depends on LLD_VERSION >=3D 150000 || LD_VERSION >=3D 239=
00
> > > > > > > > +	depends on AS_HAS_OPTION_ARCH
> > > > > > > > +
> > > > > > > > +config RISCV_ISA_ZBA
> > > > > > > > +	bool "Zba extension support for bit manipulation instruct=
ions"
> > > > > > > > +	depends on TOOLCHAIN_HAS_ZBA
> > > > > > > > +	depends on MMU
> > > > > > > > +	depends on RISCV_ALTERNATIVE
> > > > > > > > +	default y
> > > > > > > > +	help
> > > > > > > > +	   Adds support to dynamically detect the presence of the=
 ZBA
> > > > > > > > +	   extension (basic bit manipulation) and enable its usag=
e.
> > > > > > > > +
> > > > > > > > +	   The Zba extension provides instructions to accelerate =
a number
> > > > > > > > +	   of bit-specific address creation operations.
> > > > > > > > +
> > > > > > > > +	   If you don't know what to do here, say Y.
> > > > > > > > +
> > > > > > > >  config TOOLCHAIN_HAS_ZBB
> > > > > > > >  	bool
> > > > > > > >  	default y
> > > > > > > > diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> > > > > > > > index 6ec6d52a4180..51fa3f67fc9a 100644
> > > > > > > > --- a/arch/riscv/Makefile
> > > > > > > > +++ b/arch/riscv/Makefile
> > > > > > > > @@ -61,6 +61,8 @@ riscv-march-$(CONFIG_ARCH_RV64I)	:=3D rv6=
4ima
> > > > > > > >  riscv-march-$(CONFIG_FPU)		:=3D $(riscv-march-y)fd
> > > > > > > >  riscv-march-$(CONFIG_RISCV_ISA_C)	:=3D $(riscv-march-y)c
> > > > > > > >  riscv-march-$(CONFIG_RISCV_ISA_V)	:=3D $(riscv-march-y)v
> > > > > > > > +riscv-march-$(CONFIG_RISCV_ISA_ZBA)	:=3D $(riscv-march-y)_=
zba
> > > > > > > > +riscv-march-$(CONFIG_RISCV_ISA_ZBB)	:=3D $(riscv-march-y)_=
zbb
> > > > > > >=20
> > > > > > > AFAICT, this is going to break immediately on any system that=
 enables
> > > > > > > RISCV_ISA_ZBA (which will happen by default) but does not sup=
port the
> > > > > > > extension. You made the option depend on RISCV_ALTERNATIVE, b=
ut I do
> > > > > > > not see any use of alternatives in the code to actually perfo=
rm the
> > > > > > > dynamic detection of Zba.
> > > > > >=20
> > > > > > I guess we kind of have an ambiguity here: for stuff like C we =
just
> > > > > > unconditionally use the instructions, but for the rest we probe=
 first.  We
> > > > > > should probably have three states for each extension: disabled,=
 dynamically
> > > > > > detected, and assumed.
> > > > >=20
> > > > > You mean, just add some comments to the makefile surrounding each
> > > > > section or to some rst documentation?
> > > >=20
> > > > Also, the code here doesn't build w/
> > > > 	warning: invalid argument to '-march': '_zba_zbb_zicsr_zifencei_zi=
hintpause'
> > > > so there's something else wrong with TOOLCHAIN_HAS_ZBA :)
> > > It is odd that this is missing 'rv64ima' or 'rv32ima' at the beginnin=
g of
> > > this string. What configuration are you using that could cause that to
> > > be left off?
> >=20
> > I don't know, but that configuration is pretty pervasive. The patchwork
> > CI blew up too & that is using kernel.org toolchains built by Arnd:
> > https://mirrors.edge.kernel.org/pub/tools/crosstool/
> >=20
> > > Compiling with defconfig automatically enables Zba and appears to not
> > > cause this issue. I realized that I put the header definitions for
> > > do_csum and csum_ipv6_magic in this patch instead of the next one so =
the
> > > code will fail to compile from this but not due to march settings.
> > > >=20
> > > > >=20
> > > > > > > Note that for fd & v, we add it to riscv-march-y, but then im=
mediately
> > > > > > > remove it again before passing to the compiler, only allow th=
em in
> > > > > > > AFLAGS:
> > > > > > > 	# Remove F,D,V from isa string for all. Keep extensions betw=
een "fd" and "v" by
> > > > > > > 	# matching non-v and non-multi-letter extensions out with th=
e filter ([^v_]*)
> > > > > > > 	KBUILD_CFLAGS +=3D -march=3D$(shell echo $(riscv-march-y) | =
sed -E 's/(rv32ima|rv64ima)fd([^v_]*)v?/\1\2/')
> > > > > > >=20
> > > > > > > What am I missing?
> > > > > >=20
> > > > > > FD and V both have state that can be saved lazily, so we can't =
let arbitrary
> > > > > > code use them.  The extensions formally known as B don't add st=
ate, so they
> > > > > > are safe to flip on in arbitrary places (aside from the issues =
you pointed
> > > > > > out above).
> > > > >=20
> > > > > I probably went about this badly since you missed the point. I was
> > > > > trying to point out that for anything other than the compressed
> > > > > extensions in the block above that we only pass them in march to =
the
> > > > > assembler, and not to the compiler, in contrast to this patch whi=
ch just
> > > > > always passes them. I should have pointed to how we handled the
> > > > > in-kernel Zbb stuff & asked how this was any different, would pro=
bably
> > > > > have been clearer.
> > > > >=20
> > > I supposed it might be better if I submit these changes in a different
> > > patch so we can have more discussion there. Zbb was previously only u=
sed
> > > by assembly files (arch/riscv/lib/strcmp.S, arch/riscv/lib/strlen.S,
> > > arch/riscv/lib/strncmp.S). I wanted to add them to the compiler so th=
at
> > > that C programs could leverage these extensions. However, I neglected=
 to
> > > consider machines that compile the kernel with these extensions but h=
ave
> > > cores without these extensions.
> >=20
> > Less so cores, since we don't support heterogeneous stuff, and moreso
> > platforms that do not support the extensions. It's expected that the
> > same kernel could in theory be used across a wide variety of systems.
> >=20
> > > The purpose of using these extensions is
> > > to save a couple of clock cycles, so if it is necessary to first
> > > check if the extension is enabled it may not be worth it for these
> > > functions.
> >=20
> > That's still possible, it's what the alternatives mechanism exists for.
> > During boot the codepaths are patched to use what works for a given
> > machine, check out the code that makes use of Zbb or
> > riscv_has_extension_[un]likely(). You'd need to do something like the
> > existing users of Zbb instructions does, with an alternative used to
> > avoid the custom asm implementations when the hardware does not support
> > them. (That's what the CONFIG_ALTERNATIVE & CONFIG_AS_HAS_OPTION_ARCH
> > options you made the TOOLCHAIN_HAS_ZBA depend on are for).
>=20
> I can see how to get this to work if I port this code into assembly and
> write two different versions (one with Zbb and one without), but
> I don't see how this would work in C. Unless I am mistaken, there would
> need to be some sort of wrapper around the C code that told the compiler
> to compile it multiple times for different extension combinations and
> then use the riscv_has_extension_[un]likely() functions to determine
> which version to use at runtime. Is this feasible?

IIRC, if you put all the code using Zbb etc into a compilation unit of
its own then you can set march for that unit alone, but it may well just
be easier to write a custom asm one for the Zbb case & use the c
implementation from this patch for the non-Zbb case.

--7xRodtzpcS727W/L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZOztzQAKCRB4tDGHoIJi
0hRcAP0blwoDSEoeC2O8hY3MGRrsAzmDs/uG7nzr+5e7pdnwxAD/RgC2+MSV18Rs
wUV26acA15AfVsOOMS2Y9eWgMkJ8Vw8=
=7lrP
-----END PGP SIGNATURE-----

--7xRodtzpcS727W/L--
