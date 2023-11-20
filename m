Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B545D7F17C4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 16:48:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233118AbjKTPsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 10:48:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233731AbjKTPsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 10:48:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DBC1A0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 07:48:02 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8761EC433C7;
        Mon, 20 Nov 2023 15:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700495281;
        bh=Pqf0n0WeWapO2rexMfY7DVUbXOQsxxnsm5OV8uzP0l0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LFGlYdyZ4aooQny7HpcVdwiEhDOv+NfyxvwJDl5MhddiGZMQcQfPexiJQG5vduf+2
         e6usNZrsf9DQAJavs1p0ZasnPuxM7z42rQB5u3DPzTMUV8hocsdghKfYkL/wCemVHA
         AEQwyTdHo9DB50LPO9wiYjrKDkMo361uqixSnd4x7QE1PrBQVguNmxViYJQj8xC4L/
         QoK060hByDKtkmW7XJLgEWlg/5Pr+2adCARB2Fn0/mW3E7XBWGvOghm/6LwqcTkwFj
         ezh6zPw5NfemTc8o89g3ZOSALWluWZsI5q2KhV3AXoOz9UaKggQprcdsb35h3npn1y
         ZM6/+pcUkOJwA==
Date:   Mon, 20 Nov 2023 15:47:52 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Deepak Gupta <debug@rivosinc.com>
Cc:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "Szabolcs.Nagy@arm.com" <Szabolcs.Nagy@arm.com>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
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
Message-ID: <fde30e5a-f795-46ed-9dd8-9370c4f0aae8@sirena.org.uk>
References: <20231114-clone3-shadow-stack-v2-0-b613f8681155@kernel.org>
 <20231114-clone3-shadow-stack-v2-5-b613f8681155@kernel.org>
 <309927ad8bfa72ce2d084ee16cd0cd84e69fef16.camel@intel.com>
 <ZVfXTmVestrAwIkN@debug.ba.rivosinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3acFUUbMZ6fZyK3o"
Content-Disposition: inline
In-Reply-To: <ZVfXTmVestrAwIkN@debug.ba.rivosinc.com>
X-Cookie: <Manoj> I *like* the chicken
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3acFUUbMZ6fZyK3o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 17, 2023 at 01:12:46PM -0800, Deepak Gupta wrote:
> On Tue, Nov 14, 2023 at 11:11:58PM +0000, Edgecombe, Rick P wrote:

> > It seems like there will be a need for some generic method of checking
> > if shadow stack is enabled. Maybe a more generic compiler
> > intrinsic/builtin or glibc API (something unrelated to SSP)?

> Exposing a new file under procfs would be useful?
> Something like "/proc/sys/vm/user_shadow_stack_supported"

> `map_shadow_stack` can return MAP_FAILED for other reasons.
> I think `kselftests` are fine but I don't want people to pick up this
> as test code and run with it in production :-)

> So kernel providing a way to indicate whether it supports shadow stack
> mappings in user mode via procfs would be useful and arch agnostic.

I can see that might be useful for some higher level code that wants to
tune the size and nothing else.  I'd be tempted to do it through adding
a tuneable for the maximum default shadow stack size (x86 currently uses
4G) just so it's *vaguely* useful rather than just a file.  I question
the utility of that but just a plain file doesn't feel quite idiomatic.

In any case it feels like it's off topic for this series and should be
done separately.

--3acFUUbMZ6fZyK3o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVbf6cACgkQJNaLcl1U
h9Ak7wf8CA50MceuP83I2frKM1LB7rUjimAktBhZrwl5FbVW7GLI9WxpLtXZ4Gce
6+H6sDQmMtCmAiYmwZG214ZNu95rQr8HUxQCVs8WY7Ir3h9U02/MNpcaIXswd1oe
kbT14fSM/GGsA+uSKGkbuXMSQAONUKNC7iNF6R52pKZs4J4clVxxylydo47OFrDD
/EkwidMFHpPlsJkv48ETgjih58pssM9+B/oBIP1RlwmS4sgPshT9+wyEGnFjs83O
susJUcqp61pP6dV2CQN1YRfvGWo+vsZ6ByHLKOrOM9SEVJAm01FzzwYPEyRhXj+S
FxAsuQ+E51GZknCUfOkBnAjqeuY8hw==
=L/Yb
-----END PGP SIGNATURE-----

--3acFUUbMZ6fZyK3o--
