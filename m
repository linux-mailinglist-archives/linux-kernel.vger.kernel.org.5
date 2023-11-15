Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88E137EC66C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 15:55:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344122AbjKOOzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 09:55:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234954AbjKOOzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 09:55:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E2F8E
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 06:55:16 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEB44C433C8;
        Wed, 15 Nov 2023 14:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700060115;
        bh=3Hec5autMPLguh8WZx+203t12eHE86qIIse3+7N4Kvc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q6SzQQ0G957ck8KHrzlQOTYnntTKs8MwjFGJMmRKGC7hPamKt8OlQ6F9+86ZzMhyU
         nj3lMflcXZh4jS3z36pttITWlU1IZ9UjQ9vlLW/phvpmUsFzMZ/uwdjY2OBOUVNJQN
         8t2y6wepVtLl71kdjMpogDP+yfDFuaNZ+NUEXDuJi9DlXHYuCDLEEoUNw8ZftTLN/M
         6bfcmMPHzJMfblKhLNKwcshgnpf1jY4QT7uU/f8SONKYq2daZj2JTLulzhfpoooCpH
         ZOQ/g2b02rgekfNQH/8l9hYvR7wu3HxrkudVastN0wl9I5bEqfVwAumA7YT/mRxxd1
         zcDnhpy2whkTQ==
Date:   Wed, 15 Nov 2023 14:55:06 +0000
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
        "david@redhat.com" <david@redhat.com>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "jannh@google.com" <jannh@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>
Subject: Re: [PATCH RFC RFT v2 1/5] mm: Introduce ARCH_HAS_USER_SHADOW_STACK
Message-ID: <6176c556-ae24-40b2-a785-73a1b705bd28@sirena.org.uk>
References: <20231114-clone3-shadow-stack-v2-0-b613f8681155@kernel.org>
 <20231114-clone3-shadow-stack-v2-1-b613f8681155@kernel.org>
 <837fec017b9709eb42d35e9608c24619613ed221.camel@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YCYkPF8mAZ480WWM"
Content-Disposition: inline
In-Reply-To: <837fec017b9709eb42d35e9608c24619613ed221.camel@intel.com>
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


--YCYkPF8mAZ480WWM
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 14, 2023 at 11:22:16PM +0000, Edgecombe, Rick P wrote:
> On Tue, 2023-11-14 at 20:05 +0000, Mark Brown wrote:
> > +config ARCH_HAS_USER_SHADOW_STACK
> > +=A0=A0=A0=A0=A0=A0=A0bool
> > +=A0=A0=A0=A0=A0=A0=A0help
> > +=A0=A0=A0=A0=A0=A0=A0=A0 The architecture has hardware support for use=
rspace shadow
> > call
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 stacks (eg, x86 CET, arm64 GCS, RISC-V Zis=
slpcfi).

> I feel like normally a patch like this should come with the second
> feature that gets enabled. (i.e. arm or riscv). Especially since the
> comment lists currently unsupported features. I think something like
> this got nixed by an x86 maintainer earlier, but that was before these
> other features were getting pushed.

> I don't have a strong objection to having it ahead of the other
> features though and it is nice to remove X86 defines out of core code.

Given that the GCS patches are on the list and relatively
uncontroversial it does seem reasonable to carry this - I'm only able to
test this in the context of having both serieses applied!

--YCYkPF8mAZ480WWM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVU28oACgkQJNaLcl1U
h9DyAQf9GRBwhEiEgVLxI3kug+WUZcvONEYVJZ5fMLw6R9ADbrEdd/BO/yeXfOyj
evXebqzsGZ8ilEgFdLNwsIntmqUTrkTU1DNCMfBDqQgFfRiSHD+UbwAPhuatNPFx
EKTiPfnCOoaywRuyt+Ez6GMxiDnjHnHC0CfJvGVAmOd+0HbXktLBjjZfFnaTwlbJ
VwVG9ePaLmKUji7Z9kVgdfOQg+l8ZBL6c2ynP0Cj9ylBdQjzRYojCvtJqif67aC6
tCzVm5wXo9LiGGYQPLH1JGo0GRTYNmkIehC0epVU7Pp7cH+NZ6VqxIbZTVtn8wEr
z8ycWQQAl/uEwLfSI4rkKJcmru32cg==
=Gc4i
-----END PGP SIGNATURE-----

--YCYkPF8mAZ480WWM--
