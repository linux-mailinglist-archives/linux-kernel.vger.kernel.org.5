Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5997EC269
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 13:37:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343764AbjKOMhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 07:37:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234948AbjKOMhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 07:37:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26BAF11D
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 04:37:01 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1EA7C433C8;
        Wed, 15 Nov 2023 12:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700051820;
        bh=MeaNwT9drnv7V7gmXshtmN5Q7mXUr90qsX5EUyFZ1HE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UiUY5PwpMDNuSSFMYA+7Qf0jNtFakPirp9veX1A6Oz8YB8sKCwVD/zQ2mngevlA0g
         y1hlQ+C4joF6LpLy2RxmOJkUQDemBowqYlXDBZbOkUgtpiA0WaxT9Q1TaNL6Dn0qLG
         hlu6krVcVEEABACBQDxVJekfiBJ+tiRhLR7fwyr8vDdc1S7+tuMRa2B2B6mOv+DEkJ
         pMNn6ApItO69NBIBnBhoZg9E18+NC2MAL3mM8/cMUNxjJ4f2zMUQMX1I0yXxD1M+tp
         LizFsHpZW6V2cCRAU16UQ2e1Rx00ClB5Cqp3uxrQQ4OQfCoT7f7UxRVb5p9BvhMDuf
         SsuRUUXDYxs0w==
Date:   Wed, 15 Nov 2023 12:36:51 +0000
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
Subject: Re: [PATCH RFC RFT v2 2/5] fork: Add shadow stack support to clone3()
Message-ID: <d873072c-e1f4-4e1f-9efc-dfbd53054766@sirena.org.uk>
References: <20231114-clone3-shadow-stack-v2-0-b613f8681155@kernel.org>
 <20231114-clone3-shadow-stack-v2-2-b613f8681155@kernel.org>
 <c9434fa9d864612ed9082197a601c5002ed86a38.camel@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="KriTiAZt4WP/aqiG"
Content-Disposition: inline
In-Reply-To: <c9434fa9d864612ed9082197a601c5002ed86a38.camel@intel.com>
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


--KriTiAZt4WP/aqiG
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 15, 2023 at 12:45:45AM +0000, Edgecombe, Rick P wrote:
> On Tue, 2023-11-14 at 20:05 +0000, Mark Brown wrote:

> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (size < 8)
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0r=
eturn (unsigned long)ERR_PTR(-EINVAL);

> What is the intention here? The check in map_shadow_stack is to leave
> space for the token, but here there is no token.

It was to ensure that there is sufficient space for at least one entry
on the stack.

> I think for CLONE_VM we should not require a non-zero size. Speaking of
> CLONE_VM we should probably be clear on what the expected behavior is
> for situations when a new shadow stack is not usually allocated.
> !CLONE_VM || CLONE_VFORK will use the existing shadow stack. Should we
> require shadow_stack_size be zero in this case, or just ignore it? I'd
> lean towards requiring it to be zero so userspace doesn't pass garbage
> in that we have to accommodate later. What we could possibly need to do
> around that though, I'm not sure. What do you think?

Yes, requiring it to be zero in that case makes sense I think.

> > +++ b/include/linux/sched/task.h
> > @@ -41,6 +41,8 @@ struct kernel_clone_args {
> > =A0=A0=A0=A0=A0=A0=A0=A0void *fn_arg;
> > =A0=A0=A0=A0=A0=A0=A0=A0struct cgroup *cgrp;
> > =A0=A0=A0=A0=A0=A0=A0=A0struct css_set *cset;
> > +=A0=A0=A0=A0=A0=A0=A0unsigned long shadow_stack;
>=20
> Was this ^ left in accidentally? Elsewhere in this patch it is getting
> checked too.

Yes, it's just bitrot from removing the pointer.

--KriTiAZt4WP/aqiG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVUu2IACgkQJNaLcl1U
h9BiVwf/c7wQhfKl4vMlx0SwxxKe7cZTyIJp3wxjL4gqHL9ZK62MyNiijoT390ky
VkeRCd7A8hLr/xRIcsxy9aqwiP1yR/68feC6SgQ+t48WHUKyalsV4t69rhrkrBgw
+5jJZmMHb0J2rTdHR5/OXPAAUXVrlSyuOGUi82GB0UCr2mjdrpL+Wj2GLMPyHBB4
h7QFNJ2KUVzsRG0WZPd0BwagqT8CYccMWYTksoEe38C2xz5z2TUvEQ5YvIQhx4/S
4UlBMR256vO/0CGnl1C6U1n6OUi7z5Fg5vFDvSX5Wv1DkoZnOmeHJu0ZImxLvA0S
7KN9aJ9/3aZkVvjOBc6vWOY9Kl7vqw==
=XEEC
-----END PGP SIGNATURE-----

--KriTiAZt4WP/aqiG--
