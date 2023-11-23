Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 141B27F5EE5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 13:17:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345261AbjKWMRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 07:17:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345168AbjKWMRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 07:17:15 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C491191
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 04:17:22 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC58CC433C8;
        Thu, 23 Nov 2023 12:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700741842;
        bh=xCCEkCoA+F5EPxb6wixFuv+Y++MgTfZXWFP2tS5YmbI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DnQ+IN2CmzxBZAQar7A0chcph0OEoFG6VnV6a6nmioVv2J/i9XwLKSaBn/FSInAxx
         LjQyETOrquG0xUVyofz8IdDiXc+65v47aEFJYrkyp94Rhr7Qn+wXpibKXsoCuej9tn
         F9i+QRgxqAqc9qAEbQWB9alRJo7ThMiX5NTqYAA9/Mh1bDV5X8D1VGlgfY80qTWKKf
         JCh2pnKtcOgJ+INkcur5VZYKBtiXwOINvTJSzfLQt4T0OQuqIdxQRaxPK/lz3TIlRy
         gkPRtHSBxj21quDA8+JA3AfWf+aq3ofiXoJd0+8V6+G+YhgnXpTiH4S/qtZjio0SiG
         1qQaNC4hl1CSg==
Date:   Thu, 23 Nov 2023 12:17:19 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Christian Brauner <brauner@kernel.org>
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
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Kees Cook <keescook@chromium.org>, jannh@google.com,
        linux-kselftest@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH RFT v3 2/5] fork: Add shadow stack support to clone3()
Message-ID: <ZV9Cz00vAKd7EwKD@finisterre.sirena.org.uk>
References: <20231120-clone3-shadow-stack-v3-0-a7b8ed3e2acc@kernel.org>
 <20231120-clone3-shadow-stack-v3-2-a7b8ed3e2acc@kernel.org>
 <20231123-derivate-freikarte-6de8984caf85@brauner>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="AJGmcN2ZtlBWZhny"
Content-Disposition: inline
In-Reply-To: <20231123-derivate-freikarte-6de8984caf85@brauner>
X-Cookie: Slow day.  Practice crawling.
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--AJGmcN2ZtlBWZhny
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 23, 2023 at 11:28:47AM +0100, Christian Brauner wrote:
> On Mon, Nov 20, 2023 at 11:54:30PM +0000, Mark Brown wrote:

> Any reasonably maximum that should be assumed here? IOW, what happens if
> userspace starts specifying 4G shadow_stack_size with each clone3() call
> for lolz?

I guess we could impose RLIMIT_STACK?

> > +	} else {
> > +		/*
> > +		 * For CLONE_VFORK the child will share the parents
> > +		 * shadow stack.  Make sure to clear the internal
> > +		 * tracking of the thread shadow stack so the freeing
> > +		 * logic run for child knows to leave it alone.
> > +		 */
> > +		if (clone_flags & CLONE_VFORK) {
> > +			shstk->base = 0;
> > +			shstk->size = 0;
> > +			return 0;
> > +		}

> Why is the CLONE_VFORK handling only necessary if shadow_stack_size is
> unset? In general, a comment or explanation on the interaction between
> CLONE_VFORK and shadow_stack_size would be helpful.

This is the existing implicit behaviour that clone() has, it's current
ABI for x86.  The intent is that if the user has explicitly configured a
shadow stack then we just do whatever they asked us to do, if they
didn't we try to guess something sensible.  The comment at the top of
this block when where we check if shadow_stack_size is set is intended
to capture this requirement:

	/*
	 * If the user specified a shadow stack then do some basic
	 * validation and use it, otherwise fall back to a default
	 * shadow stack size if the clone_flags don't indicate an
	 * allocation is unneeded.
	 */
	if (args->shadow_stack_size) {
		size = args->shadow_stack_size;

		if (size < 8)
			return (unsigned long)ERR_PTR(-EINVAL);
	} else {

I'm not immediately seeing somewhere else to add something?

--AJGmcN2ZtlBWZhny
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVfQswACgkQJNaLcl1U
h9DRagf/Qr+aRzdrHJh9fSSLcdVyPWWetGTynP7apYTbfIJNAFGrD8vDR4FbXIgo
3zI00sIHLkRQiHWty6m4u9AJ8XMLCYFmQimJNZLz7I25IjHPsLRBGP17h4VGUFKp
MXKiwwy/MXn13Mt1wXsn+sizlovYp5rfd4+ta7JRpNb8w35xKAn/U9fvMeUgK/NT
OGwo4JdB/YCubVh7D7diPSYIxrsmxqCn7Y3d2g5YODah+bndYUvTUvobke1ncRiT
Z/MA21qSDAjVZ9izHDZOuR0/D0P0KhIELHWgYmVfrYYKDjQh2oG20edjGnd0KBBP
RefBRVldWZfRr0LBmg/sGFYHxzOX9w==
=EwkF
-----END PGP SIGNATURE-----

--AJGmcN2ZtlBWZhny--
