Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6457E7FC2
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 18:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbjKJR5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 12:57:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235665AbjKJR4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 12:56:02 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 256503481F
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 04:44:46 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1Qqm-0008RY-G3; Fri, 10 Nov 2023 13:43:04 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1Qqd-0081VE-CM; Fri, 10 Nov 2023 13:42:55 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1Qqd-00Gimy-0Z; Fri, 10 Nov 2023 13:42:55 +0100
Date:   Fri, 10 Nov 2023 13:41:23 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
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
        Al Viro <viro@zeniv.linux.org.uk>, linux-alpha@vger.kernel.org,
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
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH 04/22] [RESEND] time: make sysfs_get_uname() function
 visible in header
Message-ID: <20231110124123.5mado2cc5vnywqfx@pengutronix.de>
References: <20231108125843.3806765-1-arnd@kernel.org>
 <20231108125843.3806765-5-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ljpauxr7qypfgjtq"
Content-Disposition: inline
In-Reply-To: <20231108125843.3806765-5-arnd@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ljpauxr7qypfgjtq
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Arnd,

On Wed, Nov 08, 2023 at 01:58:25PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> This function is defined globally in clocksource.c and used conditionally
> in clockevent.c, which the declaration hidden when clockevent support

s/which/with/ ?

> is disabled. This causes a harmless warning in the definition:
>=20
> kernel/time/clocksource.c:1324:9: warning: no previous prototype for 'sys=
fs_get_uname' [-Wmissing-prototypes]
>  1324 | ssize_t sysfs_get_uname(const char *buf, char *dst, size_t cnt)
>=20
> Move the declaration out of the #ifdef so it is always visible.
>=20
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Other than that:

Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ljpauxr7qypfgjtq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmVOJO4ACgkQj4D7WH0S
/k65EAf/UjDsSsmivHFeg9uWSJLPICzRXZuL3swrSrbDypaI8PuJaX8767ZWsiYT
oDeWDpXzpAvyvz7WUCuFkRJIytR6EpscoR2t39XsflnxAYmcgYmiBDesY/A6xtuZ
k2ZldHp9NVszzJP3PiXQ8JOcEFA1LEc08SjHzEz4F6QAsno6WZD/do4yBIU+ikEg
57Rbk4CJghGfXhgOAmwcWrN91qOFQwhPpKHHDgFfYSZ3zLo+f6H9hSUkzOuLGDhx
zbK1UnRCuRi3iiJlIqS2LzaSySmRQ9tsbtjk9aQx7+GqdGprHajLMikxQ13xn8jh
U+F4kOqRAwsIV6i5/GUFGEGtLnMsSQ==
=9raj
-----END PGP SIGNATURE-----

--ljpauxr7qypfgjtq--
