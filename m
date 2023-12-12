Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 162C480F7DB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 21:26:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377337AbjLLU0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 15:26:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbjLLU0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 15:26:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE8BC98
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 12:26:25 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C190EC433C7;
        Tue, 12 Dec 2023 20:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702412785;
        bh=ITS9iepxKmDBteakc9JcBmcwe4qkWaGAUfkgjLJxKz8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QK3xwh7/RovgLawsgEE27tFvsEmWXv9zo7z8pvLyL07K+1LB60nrenIjCvuljOe6O
         41c/d6u9DpvjRjFbkGD3P7jmXStQB53cqmZKdEcnFfWLpGUOCj6vXd8lnyrF285YBk
         lVETctoAeX57YmnxNLRbavEXKvRsDBaDhwBiBYye6h5MN+tCnF67DNpZdysaYny5kM
         t6INZGptEmFHhK3ZOTufikrTYp0MGbYMADqUFNtympWn8LwrjrDYUNKzFAW2JmdTUH
         jSwlGihfJo7Y1K458B8sp76wN0x2qFUaS7cUbWtzteUthuknj5NGIFYj3sBiBRZ0Ms
         PcHfkNUJGI2Qg==
Date:   Tue, 12 Dec 2023 20:26:15 +0000
From:   Mark Brown <broonie@kernel.org>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "corbet@lwn.net" <corbet@lwn.net>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "maz@kernel.org" <maz@kernel.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "Szabolcs.Nagy@arm.com" <Szabolcs.Nagy@arm.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "will@kernel.org" <will@kernel.org>,
        "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
        "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "thiago.bauermann@linaro.org" <thiago.bauermann@linaro.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v7 02/39] prctl: arch-agnostic prctl for shadow stack
Message-ID: <28c584ff-ef25-464f-852c-c5ddf66e5906@sirena.org.uk>
References: <20231122-arm64-gcs-v7-0-201c483bd775@kernel.org>
 <20231122-arm64-gcs-v7-2-201c483bd775@kernel.org>
 <e1362732ba86990b7707d3f5b785358b77c5f896.camel@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LPMEijolhyLOy67U"
Content-Disposition: inline
In-Reply-To: <e1362732ba86990b7707d3f5b785358b77c5f896.camel@intel.com>
X-Cookie: If rash develops, discontinue use.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LPMEijolhyLOy67U
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 12, 2023 at 08:17:09PM +0000, Edgecombe, Rick P wrote:
> On Wed, 2023-11-22 at 09:42 +0000, Mark Brown wrote:

> > These features are expected to be inherited by new threads and
> > cleared
> > on exec(), unknown features should be rejected for enable but
> > accepted
> > for locking (in order to allow for future proofing).

> The reason why I stuck with arch_prctl when this came up is that CRIU
> (and probably other ptracers) needs a way to unlock via ptrace. ptrace
> arch_prctl() can do this. Did you have a plan for unlocking via ptrace?

The set of locked features is read/write via ptrace in my arm64 series,
that's architecture specific unfortunately but that seems to be the way
with ptrace.

In general if things have a need to get at prctl()s via ptrace we should
just fix that, at least for arm64 there's things like the vector lengths
that are currently controlled via prctl(), but it shouldn't be a blocker
for the locking specifically.

--LPMEijolhyLOy67U
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmV4weYACgkQJNaLcl1U
h9BRvwf/S9so8PzoqYCQJHpoRcvkwkq4+soyG3JSVYBAX+IsKPFGhH92O4Zp5DZJ
aASTrqwmW/PsW8TX8LOC1w1a2OadrpSIa4r8kxsWZWdzkg6OHWcZ/XlhGe4a1yMF
kUw36Z5PIqQRf02YHLYdelHq6/xswjma9YcOb5iVB0TZAL5mQw/2CHXr4ahGlAFr
Pj4wVYIkXRohUP6gR04RuD61bfD4WIFneYjIjzPYYYo9yxWSiiOrpO/MD1Jb7bQe
BaUHpGEsUZysAGRWxVvg+6v85VbHn/PYX8xT5xk9AmfYP8KM8HaClCKtzVBg//10
a9fZcXajnHu4O2S5h6Jsn5IYnbwpcg==
=ln+K
-----END PGP SIGNATURE-----

--LPMEijolhyLOy67U--
