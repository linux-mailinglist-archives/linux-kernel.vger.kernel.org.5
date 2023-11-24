Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F327D7F7354
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 13:04:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbjKXMEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 07:04:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjKXMEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 07:04:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1AC210CB
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 04:04:44 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C12FAC433C7;
        Fri, 24 Nov 2023 12:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700827484;
        bh=iYS7ANsuZ6vwOLgQk5XN795HJ5oXfHcHZNUjCJ6SXCw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ASSOqFUTTJHCjKWaYnDmAWOsdJx6xpTr/qPcu1HB+Fm5a/QclWrV0vncK2Q3Q7xX2
         aCCX9KBbw2Az9X58fZvG86NOH/nrOeX7BVzsNXr5gajrQU9ziayJ62atPHT8DwDcCc
         ahgZtb/ixwvuzDrehPu48aUVx6G2ccUCRb+KcZHUWGGyWnosZcOgffotJMEG6Q3zmg
         BKh8HHr1sjhFvHUZ1Iby4sERa66rD1silvF54u1GkmzyyDomzoGyssBaqUowuIrSEm
         G36HFkUDw4hjv0/b3iAj4rjrfH4/y0Ks3nDD/1Xr+xB/Qamv83b+9r9W6Jyz43KFdu
         6MPuY/CW+rmPA==
Date:   Fri, 24 Nov 2023 12:04:40 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Matt Turner <mattst88@gmail.com>,
        Vineet Gupta <vgupta@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Guo Ren <guoren@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Geoff Levand <geoff@infradead.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "David S. Miller" <davem@davemloft.net>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Helge Deller <deller@gmx.de>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Timur Tabi <timur@kernel.org>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        David Woodhouse <dwmw2@infradead.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-alpha@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-trace-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        netdev@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-bcachefs@vger.kernel.org,
        linux-mtd@lists.infradead.org,
        Aishwarya TCV <aishwarya.tcv@arm.com>
Subject: Re: [PATCH 15/22] arch: vdso: consolidate gettime prototypes
Message-ID: <ZWCRWArzbTYUjvon@finisterre.sirena.org.uk>
References: <20231108125843.3806765-1-arnd@kernel.org>
 <20231108125843.3806765-16-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="woSdJmrFfLwaS8m2"
Content-Disposition: inline
In-Reply-To: <20231108125843.3806765-16-arnd@kernel.org>
X-Cookie: Am I in GRADUATE SCHOOL yet?
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--woSdJmrFfLwaS8m2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 08, 2023 at 01:58:36PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> The VDSO functions are defined as globals in the kernel sources but inten=
ded
> to be called from userspace, so there is no need to declare them in a ker=
nel
> side header.

This is in -next as commit 42874e4eb35bdfc54f8514685e50434098ba4f6c and
breaks an arm64 defconfig build, the 32 bit vDSO build is broken:

/build/stage/linux/arch/arm64/kernel/vdso32/vgettimeofday.c:10:5: error: co=
nflic
ting types for =E2=80=98__vdso_clock_gettime=E2=80=99; have =E2=80=98int(cl=
ockid_t,  struct old_timespec
32 *)=E2=80=99 {aka =E2=80=98int(int,  struct old_timespec32 *)=E2=80=99}
   10 | int __vdso_clock_gettime(clockid_t clock,
      |     ^~~~~~~~~~~~~~~~~~~~
In file included from /build/stage/linux/arch/arm64/kernel/vdso32/vgettimeo=
fday.
c:8:
/build/stage/linux/include/vdso/gettime.h:16:5: note: previous declaration =
of =E2=80=98__vdso_clock_gettime=E2=80=99 with type =E2=80=98int(clockid_t,=
  struct __kernel_timespec *)=E2=80=99 {aka =E2=80=98int(int,  struct __ker=
nel_timespec *)=E2=80=99}
   16 | int __vdso_clock_gettime(clockid_t clock, struct __kernel_timespec =
*ts);
      |     ^~~~~~~~~~~~~~~~~~~~
/build/stage/linux/arch/arm64/kernel/vdso32/vgettimeofday.c:28:5: error: co=
nflicting types for =E2=80=98__vdso_clock_getres=E2=80=99; have =E2=80=98in=
t(clockid_t,  struct old_timespec32 *)=E2=80=99 {aka =E2=80=98int(int,  str=
uct old_timespec32 *)=E2=80=99}
   28 | int __vdso_clock_getres(clockid_t clock_id,
      |     ^~~~~~~~~~~~~~~~~~~
/build/stage/linux/include/vdso/gettime.h:15:5: note: previous declaration =
of =E2=80=98__vdso_clock_getres=E2=80=99 with type =E2=80=98int(clockid_t, =
 struct __kernel_timespec *)=E2=80=99 {aka =E2=80=98int(int,  struct __kern=
el_timespec *)=E2=80=99}
   15 | int __vdso_clock_getres(clockid_t clock, struct __kernel_timespec *=
res);
      |     ^~~~~~~~~~~~~~~~~~~

--woSdJmrFfLwaS8m2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVgkVgACgkQJNaLcl1U
h9Dz9gf/VMa1PvhU/bO1IxdTJVCJWAk44qPipqzqyUg2pLaBosU5v8Dx8eAPyIg0
DgxKA9Cycd3l3JSSqWIwJ1xEztqi2CvdmV5Ljrml8UqOvqHNPtg16JgCCOZ+Ssww
82B8fl93C3CmUtTLFx3u3lZRKd7FjyeOiiemekfHvdbZSOn+K6Dk9zvPAE63gI0I
5m6xp+q1eJ7Uyq7o4kCOnJOo/y9eDGX3lGqOsVQ7bnQAH6Id5y32aplMkStvzLKI
TrSlxBsnU/wry1msxEbcgmhN2YebA1wWGNC0j6fT4xg0MzuHevZwPTSm/2sK5Exc
fOQ/QL09MCXtNwNJ3QpItc8VaAFrVQ==
=sHT7
-----END PGP SIGNATURE-----

--woSdJmrFfLwaS8m2--
