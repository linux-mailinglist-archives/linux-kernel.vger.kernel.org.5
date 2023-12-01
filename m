Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6712180129F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 19:29:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbjLAS2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 13:28:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjLAS2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 13:28:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F64FC1
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 10:28:58 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3274AC433C8;
        Fri,  1 Dec 2023 18:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701455338;
        bh=GRzvb6K1F09jnFNhMGdAakhzpcFCOUV6/A//CTedh4I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A81vm8AffuWGRBlTGQ6h8Ukd3z/U1Ud6I5sNaVbK5J3kTwKD/u3+evexovH0kUvYr
         PtSE3KDikxJeZNGdGkSNH0mc6fmmAylgGwpToBd04E2B4LbMW14o+TcWeY25snyHDw
         fTtnf9n4lwHqrh8lDDaUZCoi9HMWqYsmkT0aVi2nsRZuoTN4oUBdH8i/5U/p/PTbu2
         S2lGZJkv12gi0Q+9npLmBClZCuduDTBzgKiVkuRAouu7FmM1eWtUXxo2EweuRo9LfK
         ViEAJXevymtpRykKPA7pw6Da9zAy2v538ZItO3J830G494ZzD5isvKvrohPdYQ50j0
         m6yojiW2HtnTQ==
Date:   Fri, 1 Dec 2023 18:28:48 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>,
        Deepak Gupta <debug@rivosinc.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        "H.J. Lu" <hjl.tools@gmail.com>,
        Florian Weimer <fweimer@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Kees Cook <keescook@chromium.org>, jannh@google.com,
        linux-kselftest@vger.kernel.org, linux-api@vger.kernel.org,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH RFT v4 0/5] fork: Support shadow stacks in clone3()
Message-ID: <37a35edb-e72d-4983-8be7-67c56d2292c5@sirena.org.uk>
References: <20231128-clone3-shadow-stack-v4-0-8b28ffe4f676@kernel.org>
 <ZWjb6r0RWPo199pC@arm.com>
 <fce4c169-5d19-40e8-bc32-0abec9bb008e@sirena.org.uk>
 <ZWoYLs2STGA1LZLU@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="CkFryha6tlsnAYUC"
Content-Disposition: inline
In-Reply-To: <ZWoYLs2STGA1LZLU@arm.com>
X-Cookie: The early worm gets the late bird.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--CkFryha6tlsnAYUC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 01, 2023 at 05:30:22PM +0000, Catalin Marinas wrote:

> Another concern I had was that map_shadow_stack() currently takes
> a flags arg (though only one flag) while the clone/clone3() allocate the
> shadow stack with an implicit configuration (other than size). Would
> map_shadow_stack() ever get new flags that we may also need to set on
> the default thread shadow stack (e.g. a new permission type)? At that
> point it would be better if clone3() allowed a shadow stack pointer so
> that any specific attributes would be limited to map_shadow_stack().

The flags argument currently only lets you specify if a stack switch
token should be written (which is not relevant for the clone3() case)
and if a top of stack marker should be included (which since the top of
stack marker is NULL for arm64 only has perceptible effect if a token is
being written).  I'm not particularly anticipating any further additions,
though never say never.

> If that's only theoretical, I'm fine to go ahead with a size-only
> argument for clone3(). We could also add the pointer now and allocate
> the stack if NULL or reuse it if not, maybe with some prctl to allow
> this. It might be overengineering and we'd never use such feature
> though.

Yeah, it seems like a bunch of work and interface to test that I'm not
convinced anyone would actually use.

> > As well as the actual configuration of the size the other thing that we
> > gain is that as well as relying on heuristics to determine if we need to
> > allocate a new shadow stack for the new thread we allow userspace to
> > explicitly request a new shadow stack.

> But the reverse is not true - we can't use clone3() to create a thread
> without a shadow stack AFAICT.

Right.  Given the existing implicit allocation only x86 ABI we'd need to
retrofit that by adding an explicit "no shadow stack" flag.  That is
possible though I'm having a hard time seeing the use case for it.

--CkFryha6tlsnAYUC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVqJeAACgkQJNaLcl1U
h9DzAQf+LrewNdEd54lFym1uNzfqTALngDRzqEQiwyX9OjpXl7qCfKd77el1CZ0K
CJz64ccqu/oWsPYXYcGbSzzFELkIyPbqIWZ48NeKCGVMapsadRneUI6QO0pONxhV
UBVjFK0nqQeKMuXZXSPnPQ4r2TP6/8V0GXwpTmI6t2rMAIKgUQ0co0qAQBbVUWVh
C+V88onP3gYcXwH6uKjmj27pT2gr2vJABiO/VkXt1CSXUlqK9VgG0cPwj/DHIq9X
RiFY1ItDu4w+4efoNzq6mmX+hbBRDfqWWYzUeJl/XLd/1cDY3ZLB/CCzNvN5s4YW
PXlpWyT3/osvaRjlXy33OnPqJ7lLQQ==
=UeuB
-----END PGP SIGNATURE-----

--CkFryha6tlsnAYUC--
