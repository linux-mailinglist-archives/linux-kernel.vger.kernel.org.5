Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 287E47EC2FF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 13:53:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343800AbjKOMxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 07:53:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343611AbjKOMxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 07:53:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B18F3CE
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 04:53:20 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22C82C433C7;
        Wed, 15 Nov 2023 12:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700052800;
        bh=gcFqBYw8PXGO0sV0s5kjBNpQqfZ58F4h29SX//oQGIc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gbCPss0qRiZubn7E0ZPkBxNyntffhhRLA7M5bjDO4PkW0C4TjlMl+Q54z22HUWq99
         FE1r77hwcX1dEUf71IezL52SBh7gzsAN/2gsGxUFtZ0h/jwG4E0HNiG00G7a46Gn36
         j6eMCtYs/C4fKYKFgUwmQ2huEudAL9S4/mZtnNGGjd43K2MCVQkPpKF51l6bZYou2N
         AjLPZM640fz91gAXy6x6GMJfe/l+JpZrYHVVpE+AXe6aoNK39V1E/jAR8g31dc4KBJ
         zdXf/YkYsaT8YzyfguiO+/QpxyKRugT9z0QCPmI7geTcTC2ZNlr7Kp1NsDKq3iw2DZ
         0cXvVBKTMX7IA==
Date:   Wed, 15 Nov 2023 12:53:10 +0000
From:   Mark Brown <broonie@kernel.org>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "Szabolcs.Nagy@arm.com" <Szabolcs.Nagy@arm.com>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "vschneid@redhat.com" <vschneid@redhat.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "bristot@redhat.com" <bristot@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "bsegall@google.com" <bsegall@google.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "jannh@google.com" <jannh@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "Pandey, Sunil K" <sunil.k.pandey@intel.com>
Subject: Re: [PATCH RFC RFT v2 5/5] kselftest/clone3: Test shadow stack
 support
Message-ID: <7f2f36a7-e299-4eb1-8ef4-11c08181fe27@sirena.org.uk>
References: <20231114-clone3-shadow-stack-v2-0-b613f8681155@kernel.org>
 <20231114-clone3-shadow-stack-v2-5-b613f8681155@kernel.org>
 <309927ad8bfa72ce2d084ee16cd0cd84e69fef16.camel@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3ZWyp9FLjuhAqq+o"
Content-Disposition: inline
In-Reply-To: <309927ad8bfa72ce2d084ee16cd0cd84e69fef16.camel@intel.com>
X-Cookie: For internal use only.
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3ZWyp9FLjuhAqq+o
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 14, 2023 at 11:11:58PM +0000, Edgecombe, Rick P wrote:
> On Tue, 2023-11-14 at 20:05 +0000, Mark Brown wrote:

> > +=A0=A0=A0=A0=A0=A0=A0shadow_stack =3D syscall(__NR_map_shadow_stack, 0,
> > getpagesize(), 0);

> Hmm, x86 fails this call if user shadow stack is not supported in the
> HW or the kernel, but doesn't care if it is enabled on the thread or
> not. If shadow stack is not enabled (or not yet enabled), shadow stacks
> are allowed to be mapped. Should it fail if shadow stack is not yet
> enabled?

> Since shadow stack is per thread, map_shadow_stack could still be
> called on another thread that has it enabled. Basically I don't think
> blocking it will reduce the possible states the kernel has to handle.

Indeed - I would expect map_shadow_stack() to always succeed if the
system supports it since it could reasonably be called as part of the
preparation for enabling it and even if someone calls it and never
actually uses the resulting memory there's no more harm to that than
any other memory allocation.  The arm64 code wasn't explicitly caring if
we actually had GCS enabled when we clone and just alloacating the stack
if requested which on reflection is more just an opportunity for users
to mess up than something we usefully want to support.

> The traditional way to check if shadow stack is enabled on x86 is the
> check for a non zero return from the _get_ssp() intrinsic:
> https://gcc.gnu.org/onlinedocs/gcc-9.2.0/gcc/x86-control-flow-protection-=
intrinsics.html

> It seems like there will be a need for some generic method of checking
> if shadow stack is enabled. Maybe a more generic compiler
> intrinsic/builtin or glibc API (something unrelated to SSP)?

Some sort of feature check in libc would be nice, yes.  That said since
we really want the tests to run on systems without libc support for the
feature (if only as a bootstrapping thing) we'll need to open code
anyway.  I'll add code to startup which ensures the feature is enabled,
we can't rely on it for detection without pain though since it's
possible that we might have features locked by the startup code.

--3ZWyp9FLjuhAqq+o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVUvzYACgkQJNaLcl1U
h9AOXAf8C7LO3zDmvMkVUGlWN+N+fpmKG4F/msloRjDssP4TlUtLbV/KiDUMXa/S
5WejIQQwD8ajc4nPg4zOXp4hwfdADWgI/9f+csVwADFrOth5eZqgRqTcfvdm1Arx
9YffT2zBfx0ga6x5T4ToC0ywneZTzSR4inXbHrGEZtUsxToSbxqO9wWPgjgrF/Rr
YQ8Ni6rAw2u/n2N7UngWU62zkCQ51NZBOGs56+N52tCTCUwFqdMGi5nlaUpqNZk9
bePpU3yf/8FdQ1J+bIBzj9wFDQRY8I6RcUarTm2DdL3IH6YPiNYyiOSVF7I5To40
I4svtiH5xfPhHF2HbE0A7iz0Kt2EqA==
=3hkW
-----END PGP SIGNATURE-----

--3ZWyp9FLjuhAqq+o--
