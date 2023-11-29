Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1BC37FD77E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 14:05:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233793AbjK2NFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 08:05:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233775AbjK2NFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 08:05:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 235D6C4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 05:05:47 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B53B5C433C7;
        Wed, 29 Nov 2023 13:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701263146;
        bh=blG0dvwWUNRYFt86BsXbP1/OkVEhhrAXeIIL3dtK46g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IVWN4JNqjMFK54bFfURHiFipXX3aV2QymsXITbTQ+1bIS43DDRKs8ZVFbjRQZZR/Z
         KKkI8mVi+i4tCAN8rvQdlDca20b5SO/Cz6I9WKwNncLJ9NRc5FrPx5yM0YHovsz6hu
         8w40DkVhq4HQZdYxFKTcjteyw+Cw3lWUhBikdoT29Ip94XjjaPGoa1YAWsJIB1SRD+
         Kllplbirvmd1t7u3o+tnRGyjhJxPfb+/q+/mGcsvQvoRNR/SvSzAGy6othOWQkkPLd
         /u07C+ZHiK93qLL5ap++U2mI2R9SvRT4ouSCsNSbmMilngztIzRzrwR8MnQShh/IUn
         f3uySCP0zAAJQ==
Date:   Wed, 29 Nov 2023 13:05:37 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Deepak Gupta <debug@rivosinc.com>
Cc:     "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>,
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
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Kees Cook <keescook@chromium.org>, jannh@google.com,
        linux-kselftest@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH RFT v4 2/5] fork: Add shadow stack support to clone3()
Message-ID: <430ac5f8-fb83-4f12-b37a-1baeb4c68147@sirena.org.uk>
References: <20231128-clone3-shadow-stack-v4-0-8b28ffe4f676@kernel.org>
 <20231128-clone3-shadow-stack-v4-2-8b28ffe4f676@kernel.org>
 <ZWZabbeK942FToNs@debug.ba.rivosinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MUgwbL5AO9/HgtIM"
Content-Disposition: inline
In-Reply-To: <ZWZabbeK942FToNs@debug.ba.rivosinc.com>
X-Cookie: Are you a turtle?
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MUgwbL5AO9/HgtIM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 28, 2023 at 01:23:57PM -0800, Deepak Gupta wrote:
> On Tue, Nov 28, 2023 at 06:22:40PM +0000, Mark Brown wrote:

> > +#define SHADOW_STACK_SIZE_MIN 8

> nit:
> Sorry, should've mentioned it earlier.
> Can this be "#define SHADOW_STACK_SIZE_MIN sizeof(unsigned long)"

Given that the stack is full of pointers I'll go for void * instead.

--MUgwbL5AO9/HgtIM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVnNyAACgkQJNaLcl1U
h9DoAwf/coXXiYmS5fLHDskC1XDLHQoQHRCr/PLI44gfte7+GtFpLnQxOve4lSx0
PnCFpLE5tuDpivETLvfGCd1a4cbWMXm2/wh3jW7blaCRMVX64cknMrOYnv4q5xPv
UZZ+rnyaauCZ2H+MFl9gxBASlXpvbiI/VZg1pbAwLZw7PdyKoxfkDgaZtYfGUxF2
G/hOXMemqoIYr2hwlezjNN231EzV1L1OHdp4YY8kluRVK4qMqpU1fylv8J+kG3IA
5WcYYsly7Aod5A5W63jfelDlADmKkfl4WBrHK4rG5mL/HdLWrIOe6WWVWxK0YR+T
UhcJBPpMfoEyYDAn2uBDhAhM5opUgQ==
=2dyh
-----END PGP SIGNATURE-----

--MUgwbL5AO9/HgtIM--
