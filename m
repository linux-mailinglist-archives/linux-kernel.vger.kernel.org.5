Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB99800CC3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 15:00:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379092AbjLAOAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 09:00:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379060AbjLAOAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 09:00:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 534FACF
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 06:00:40 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2913FC433C8;
        Fri,  1 Dec 2023 14:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701439240;
        bh=cH/WQ4KETfzKoL236M7jGi9GYZdkGcwb5KqlIXUvyeg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XzdUKyurfLDqP1vkQGdkeo9Vp39hy0C1j4hwqhkwLy7UQuhcHmAyKkp1AaJR1YvpY
         wxRjWAynnlmZYfUCkPde5kSEXOKswvqf0pi37yfB8ceEgmFhbIfsHYODylbheVYZ+M
         wZRHT4F1OqsXdAoHXOVO4bc9nVePCrf5RQj2KhO2Pzg//uLffyqFr0St0XRTOHrQ6j
         LqiyoIRT2UAUU8Srdu/U64y5jcNsfh7rGTiZ437YpYybTc9hfO+eyb/jYRkRVYNdNk
         VinrS6WtrpYkKGsi0U9wEndI/l6c8EkO37vujystxtJrA3ddO160nmhXnf1zQNMAzk
         1rtXbGcyuHkEQ==
Date:   Fri, 1 Dec 2023 14:00:31 +0000
From:   Mark Brown <broonie@kernel.org>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "Szabolcs.Nagy@arm.com" <Szabolcs.Nagy@arm.com>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "vschneid@redhat.com" <vschneid@redhat.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "bristot@redhat.com" <bristot@redhat.com>,
        "will@kernel.org" <will@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "jannh@google.com" <jannh@google.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "bsegall@google.com" <bsegall@google.com>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "david@redhat.com" <david@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>
Subject: Re: [PATCH RFT v4 0/5] fork: Support shadow stacks in clone3()
Message-ID: <a3a04d9c-7c53-4399-b096-dee406716193@sirena.org.uk>
References: <20231128-clone3-shadow-stack-v4-0-8b28ffe4f676@kernel.org>
 <ZWjb6r0RWPo199pC@arm.com>
 <fce4c169-5d19-40e8-bc32-0abec9bb008e@sirena.org.uk>
 <881e1b6d89d61cef4e71c6be688635fc47bb2b8e.camel@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RXABTafy96aV2/7C"
Content-Disposition: inline
In-Reply-To: <881e1b6d89d61cef4e71c6be688635fc47bb2b8e.camel@intel.com>
X-Cookie: The early worm gets the late bird.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RXABTafy96aV2/7C
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 30, 2023 at 11:37:42PM +0000, Edgecombe, Rick P wrote:
> On Thu, 2023-11-30 at 21:51 +0000, Mark Brown wrote:
> > On Thu, Nov 30, 2023 at 07:00:58PM +0000, Catalin Marinas wrote:

> > explicitly request a new shadow stack.=A0 There was some corner case
> > with
> > IIRC posix_nspawn() mentioned where the heuristics aren't what we
> > want
> > for example.

> Can't posix_spawn() pass in a shadow stack size into clone3 to get a
> new shadow stack after this series?

Yes, the above was addressing Catalin's suggestion that we add stack
size control separately to clone3() instead - doing that would remove
the ability to explicitly request a new stack unless we add a flag to
clone3() at which point we're back to modifying clone3() anyway.

> > > Another dumb question on arm64 - is GCSPR_EL0 writeable by the
> > > user? If
> > > yes, can the libc wrapper for threads allocate a shadow stack via
> > > map_shadow_stack() and set it up in the thread initialisation
> > > handler
> > > before invoking the thread function?

> > We would need a syscall to allow GCSPR_EL0 to be written.

> I think the problem with doing this is signals. If a signal is
> delivered to the new thread, then it could push to the old shadow stack
> before userspace gets a chance to switch. So the thread needs to start
> on a new shadow/stack.

That's an issue, plus using a syscall just wouldn't work with a security
model that locked down writes to the pointer which does seem like
something people would reasonably want to deploy.

--RXABTafy96aV2/7C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVp5v4ACgkQJNaLcl1U
h9B1egf/blIXdR5uSvIkINi89u3Br4JE6lupOzoIADM0aQZN7uaqtT7T3F3qzJAV
bqBIpN//uR3KUtud8CnlC1jMqYPUtCg4qiki9BYkG5z2libk8YJg/4rgFYhei7Zl
iT9caiCXwNWGHxlp2yGLFh1VmRz4YFSuqf75Q3Cifl84LgcyvO5gu62jRHfwXDMU
9qL3k1dIhPVPKhGjORaj+80DUCC72LzolsXYrOZDwwqp9jb1g+8F31Em2P/d9HF0
7f0DkhYh+AI3t7qRYgGFYL+HW49MEfGFk0SxdOusMOsXF2CZN0LZgPuu0Xap7+CV
7IQIlw8S47qEV4/7yVFqNLoPb2Pp/g==
=hmJJ
-----END PGP SIGNATURE-----

--RXABTafy96aV2/7C--
