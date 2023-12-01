Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15F1A800C7F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 14:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379056AbjLANrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 08:47:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379035AbjLANrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 08:47:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 465F7193
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 05:47:38 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1842C433C7;
        Fri,  1 Dec 2023 13:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701438457;
        bh=PWIoD2aMPLEqBngPydmFbFLwoGd432/qc5a759T7Y9Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PUMv/dn5KRZz+MsQw9uEHuyQRrNA3ATgRQhaVWpxh67zkUnneGNW5RTRkxs3sDwhU
         frHxsYyMVU2Rdj0mBd3YNj+/Dty73P12CSwRM5R/8TbIvmw07WLtEAlGb5WVS15WNu
         6758Er36i77gMNbPXV5vPvuq2WOjKonlOGMyUSdQ2DXx+ZWKyQaaHm46KYTDNX3oae
         zpG97trNA6iSAu4eOc9K9c+iI27ecdzrWHsRLCDr4QnvYfCPFUqKzRbfuYOnIybeD0
         0lr7SBYCtxJrv8cvCWaxUFFmCRNco0F8C7VT5s0rt9M+dakJ0gedf23u7jDyW8Sa8V
         YSbSzTcbAP0NQ==
Date:   Fri, 1 Dec 2023 13:47:28 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>,
        Deepak Gupta <debug@rivosinc.com>,
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
Message-ID: <dd1c8cc6-2f37-4348-b2b8-12ab0e8eca7a@sirena.org.uk>
References: <20231128-clone3-shadow-stack-v4-0-8b28ffe4f676@kernel.org>
 <ZWjb6r0RWPo199pC@arm.com>
 <fce4c169-5d19-40e8-bc32-0abec9bb008e@sirena.org.uk>
 <ZWnIgQgUW0Eyfcw9@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3hTfKmMa/MqvxEjq"
Content-Disposition: inline
In-Reply-To: <ZWnIgQgUW0Eyfcw9@arm.com>
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


--3hTfKmMa/MqvxEjq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 01, 2023 at 11:50:25AM +0000, Szabolcs Nagy wrote:
> The 11/30/2023 21:51, Mark Brown wrote:
> > The concern Rick raised was that allowing user to pick the exact shadow
> > stack pointer would allow userspace to corrupt or reuse the stack of an
> > existing thread by starting a new thread with the shadow stack pointing
> > into the existing shadow stack of that thread.  While in isolation

> note that this can be prevented by map_shadow_stack adding
> a token that clone3 verifies.

That would make it impossible to reuse the shadow stack once the token
is overwritten which does move the needle more towards making doing the
mapping separately pure overhead.

--3hTfKmMa/MqvxEjq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVp4/AACgkQJNaLcl1U
h9CCRQf+Pn7Ini93R5gb9MJbe5tEKaLk0xby27AkrWDKCFjXVLRzfGxW/1nqKTKc
nrj4iuRnG6BSUm3P4p8glFLgRzYynLPUcsmMG/uTGK+j7oZKKjJYn1KQOCAFNCBR
r9dzZmY3RbLVnE1QGnux/7Yjt962zh2Jhp2vGMmXSpF7XyrP/ntaVw5tpI2KlM0y
gnpKGkOkyHhyATNM6S01phAa+BBPYr7B+DRLi28Mp6saX9sptZgqKFRBFSwfi+hR
CK/Hj0D2DCQZinjuDXttmKghaaVPY8+Rmw+hl9GiR8KJiBFHOLcLPqX0U9FmG7RZ
4YOTrCWL9mGfraFlXT3KXCwa7DaHkA==
=skO8
-----END PGP SIGNATURE-----

--3hTfKmMa/MqvxEjq--
