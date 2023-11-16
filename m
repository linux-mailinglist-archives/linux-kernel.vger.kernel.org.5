Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9237EE687
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 19:14:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345395AbjKPSOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 13:14:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345368AbjKPSOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 13:14:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 026B419D
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 10:14:19 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 408A5C433C8;
        Thu, 16 Nov 2023 18:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700158458;
        bh=fU9UbtrsIqmGuD7XgmjRY/5d5B/QYSrBZgF4IZZYGTw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tAviU7jubktNs951PoKcGBu4o5sD3xt8QsVKXloraDS99HD4ozv6XhqsV2PXFtK+S
         R1It3k0KIsLumPM77URN6Yrq1mQ7y25JL04zaPvM75PjvZDufW9ls45UOoxokroHak
         Vv9RUij8AiP5+wTpq0Z4ZgcO3r5WFBAKAjkWXpUha97JiWHO0kciorfu59zd6ufLjq
         ryC6wk0hbWkL71gJ4xT+QZizLMqFjqQaI6bUBrnbO+J2lZ6JgIA+srmG1cOALOAdAn
         dTin/yRPGTktcUWlHlF6RM5EXwjZ4dknmbaWN5vOY2rQQoHxWvtZsdVjS/2v/xhklk
         NrB/wrQeykMtg==
Date:   Thu, 16 Nov 2023 18:14:09 +0000
From:   Mark Brown <broonie@kernel.org>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "Szabolcs.Nagy@arm.com" <Szabolcs.Nagy@arm.com>,
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
Message-ID: <2b4b935e-aea1-4283-a459-5d6004b24b28@sirena.org.uk>
References: <20231114-clone3-shadow-stack-v2-0-b613f8681155@kernel.org>
 <20231114-clone3-shadow-stack-v2-2-b613f8681155@kernel.org>
 <c9434fa9d864612ed9082197a601c5002ed86a38.camel@intel.com>
 <d873072c-e1f4-4e1f-9efc-dfbd53054766@sirena.org.uk>
 <ZVTvvJTOV777UGsP@arm.com>
 <d90884a0-c4d3-41e9-8f23-68aa87bbe269@sirena.org.uk>
 <d05d23d56bd2c7de30e7732e6bd3d313d8385c47.camel@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="15rJUYEsjrHhwsZm"
Content-Disposition: inline
In-Reply-To: <d05d23d56bd2c7de30e7732e6bd3d313d8385c47.camel@intel.com>
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


--15rJUYEsjrHhwsZm
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 16, 2023 at 12:52:09AM +0000, Edgecombe, Rick P wrote:
> On Wed, 2023-11-15 at 18:43 +0000, Mark Brown wrote:
> > > end marker token (0) needs it i guess.

> > x86 doesn't currently have end markers.=A0 Actually, that's a point -
> > should we add a flag for specifying the use of end markers here?
> > There's code in my map_shadow_stack() implementation for arm64 which
> > does that.

> Hmm, I guess there isn't a way to pass a flag for the initial exec
> stack? So probably it should just mirror that behavior. Unless you
> think a lot of people would like to skip the default behavior.

I don't really know that anyone would particularly want to use a flag on
arm64, I was more thinking for the benefit of x86 where any termination
record would be a change.  It's certainly easier to not have flags so
I'm more than happy to leave things as they are, there's nothing
stopping further extensions of the ABI if we decide we want them later.

> And of course we don't have a marker on x86 (TODO with alt shadow
> stacks). We could still check for size < 8 if we want it to be a
> universal thing.

It does seem simpler, size < 8 is all edge case.

--15rJUYEsjrHhwsZm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVWW/AACgkQJNaLcl1U
h9CzZQf/dIUyUF/fRB2YA6pvIXvNE5ZU2z1Domwxa98+bLpNitJrcbiBgQGOxFZb
ryxcalGm1nhzTbcyGM45iJQb48ageOjQEVGr2ztoKX8bVsRBNCfCSWEATPhSAi0r
ek28N2U9wEVNiQyoYaDztE7wMABEihBZLacKKYSsQ8tSyLfcJOU7o3FN9DdVx316
GfkPWEC2uSTgHvZozm66MUoP1n+GIFobMATYrdtxu2LI65rjrP5YxmMe5/c7TqB2
3b2ctcgr3SiKHg+rOl4rxmYR1nlACbJnE9sF4NZv6BYIgTYaze9EHizu44+Usm2N
we2gOehM/hZyskUKxv/NvW7skuQl2w==
=zUsz
-----END PGP SIGNATURE-----

--15rJUYEsjrHhwsZm--
