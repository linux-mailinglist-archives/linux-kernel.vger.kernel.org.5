Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 023A17EE0BA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 13:33:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345159AbjKPMdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 07:33:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbjKPMds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 07:33:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B19D187
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 04:33:45 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2BC7C433C8;
        Thu, 16 Nov 2023 12:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700138024;
        bh=fl2ERlYyHKp/gRtOCtc+cDz1RGc2gsvBRtB9yhmxrdI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jX8O5kJRtlXu04+yCXleGkWsnCATVdmBCfnhOjlpx9j7fHrwvOWT+qpsqXbGKlM6m
         9RsXepA+WSzbKFkApAHQVWNKLiCk1oVWFW5VyaQQBS8V/3rBL4K4E2t1WwAYuVZk5t
         Q/mTJHX7ThINLtdsu4dLwBUDM6AHMup2szsoVDnBBCMTveDZz8ou+jWujO67gOC2vN
         fmUQgF2Z3QbdUYJ0IeR7WtCO2NHhjR/E7E4THaLr1lVQdSPoIdb9R988B1smYEDydH
         OXl2rOxwYC3NzO421ZFg2u49P4+ikBD50sK/4UhN74OjFc+z/w5ZCVyiQJWRNt+D3z
         dqAOD/TjWarZQ==
Date:   Thu, 16 Nov 2023 12:33:35 +0000
From:   Mark Brown <broonie@kernel.org>
To:     "Szabolcs.Nagy@arm.com" <Szabolcs.Nagy@arm.com>
Cc:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "vschneid@redhat.com" <vschneid@redhat.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "bristot@redhat.com" <bristot@redhat.com>,
        "will@kernel.org" <will@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "jannh@google.com" <jannh@google.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "bsegall@google.com" <bsegall@google.com>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "Pandey, Sunil K" <sunil.k.pandey@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>
Subject: Re: [PATCH RFC RFT v2 2/5] fork: Add shadow stack support to clone3()
Message-ID: <1bd189e0-a7dd-422c-9766-ef1c9b0d3df8@sirena.org.uk>
References: <20231114-clone3-shadow-stack-v2-0-b613f8681155@kernel.org>
 <20231114-clone3-shadow-stack-v2-2-b613f8681155@kernel.org>
 <c9434fa9d864612ed9082197a601c5002ed86a38.camel@intel.com>
 <d873072c-e1f4-4e1f-9efc-dfbd53054766@sirena.org.uk>
 <ZVTvvJTOV777UGsP@arm.com>
 <d90884a0-c4d3-41e9-8f23-68aa87bbe269@sirena.org.uk>
 <d05d23d56bd2c7de30e7732e6bd3d313d8385c47.camel@intel.com>
 <ZVXvptSmmJ6MQ0dY@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qxzRtaK8vwjTcNK1"
Content-Disposition: inline
In-Reply-To: <ZVXvptSmmJ6MQ0dY@arm.com>
X-Cookie: micro:
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qxzRtaK8vwjTcNK1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 16, 2023 at 10:32:06AM +0000, Szabolcs.Nagy@arm.com wrote:
> The 11/16/2023 00:52, Edgecombe, Rick P wrote:
> > On Wed, 2023-11-15 at 18:43 +0000, Mark Brown wrote:

> while CLONE_VFORK allows the child to use the parent shadow
> stack (parent and child cannot execute at the same time and
> the child wont return to frames created by the parent), we
> want to enable precise size accounting of the shadow stack
> so requesting a new shadow stack should work if new stack
> is specified.

> but stack==0 can force shadow_stack_size==0.

> i guess the tricky case is stack!=0 && shadow_stack_size==0:
> the user may want a new shadow stack with default size logic,
> or (with !CLONE_VM || CLONE_VFORK) wants to use the existing
> shadow stack from the parent.

If shadow_stack_size is 0 then we're into clone() behaviour and doing
the default/implicit handling which is to do exactly what the above
describes.

> > What is the case for stack=sp bit of the logic?

> iirc it is not documented in the clone man page what stack=0
> means and of course you don't want sp==0 in the vfork child
> so some targets sets stack to sp in vfork, others set it 0
> and expect the kernel to do the right thing.

The manual page explicitly says that not specifying a stack means to use
the same stack area as the parent.

> this likely does not apply to clone3 where the size has to be
> specified so maybe stack==sp does not need special treatment.

You'd have to be jumping through hoops to manage to get the same stack
pointer while explicitly specifying a stack with clone3() on
architectures where the stack grows down.  I'm not sure there's a
reasonable use case.

--qxzRtaK8vwjTcNK1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVWDB8ACgkQJNaLcl1U
h9B/kgf/cCb0t/WDJJnLgSCdcrrBTZQDYOh6g5wc9ofAClwczUYictkrifHUtcx7
AK0RVBrSjubnCoUVVD4n9ayLlTvczZwV9qFA0YTugPTAUry8SzqtQslfj89DHvGu
O+GDXFQYIeIqLY3waqrYmp5GnsBOy9ppu2FjIw+l3sN7+5SGxTrGomEafGihSLNw
2N3ddNRd0J0/Qg0tuKFJdteyRRpIXI70Eb5EAj87Gzcf/8pZRRoYFq9Er4tZzxbB
PYe2Vg4Q2GmiblDwUO15CVvXItDaa35+peEI4SLJjQGvlJiMUlH7HKu9S6nO9+nj
DVzEt0gPGR/2ps3+VPmBAIXDtjll3w==
=H7BF
-----END PGP SIGNATURE-----

--qxzRtaK8vwjTcNK1--
