Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 990A180BB9F
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 15:23:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232543AbjLJOWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 09:22:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjLJOWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 09:22:53 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E0CF5
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 06:22:59 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9FFDC433C7;
        Sun, 10 Dec 2023 14:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702218179;
        bh=8tne0aaAREf7h+qiY6KAldko6jyI6LRXnoNCM9fma6Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z46OPbu3lxs+nSXwJj7g5+uM236T8qcWVMENzV16W8PRn+wPA90J2c/MU1TR09r9G
         V7uktPMYA+kX07nhFqGBeWzVnfPGq1sWi8TmA2O/Ypbc+HHzOKCOCc6aUZpI1E2ux5
         i7a4xJ46nLuCB9P/YSDucazqkfc40Pwk2ruWwXth0yedV7jS/lBPvlu9h8D8FqQQ5E
         7NrgTVM832Ck4BiiNruf7natGB4ETT1vuYgIR5796kVSPSFEDz9SqMvV2j2pOXJx2O
         kYv2KFYNFZhj2cny4Ad3h63HQeFh23ezu4307DrPbna88E2yARpEbrhoRhlGsNFA2m
         xH4AUl7qyB+aQ==
Date:   Sun, 10 Dec 2023 14:22:56 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Thiago Jung Bauermann <thiago.bauermann@linaro.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Oleg Nesterov <oleg@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <shuah@kernel.org>,
        "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>,
        Deepak Gupta <debug@rivosinc.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        "H.J. Lu" <hjl.tools@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Florian Weimer <fweimer@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v7 26/39] arm64/ptrace: Expose GCS via ptrace and core
 files
Message-ID: <ZXXJwNdKC/y6bRYn@finisterre.sirena.org.uk>
References: <20231122-arm64-gcs-v7-0-201c483bd775@kernel.org>
 <20231122-arm64-gcs-v7-26-201c483bd775@kernel.org>
 <877clney35.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+xOPyWhFp+ttqF+R"
Content-Disposition: inline
In-Reply-To: <877clney35.fsf@linaro.org>
X-Cookie: You might have mail.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+xOPyWhFp+ttqF+R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Dec 09, 2023 at 08:49:02PM -0300, Thiago Jung Bauermann wrote:
> Mark Brown <broonie@kernel.org> writes:

> > Provide a new register type NT_ARM_GCS reporting the current GCS mode
> > and pointer for EL0.  Due to the interactions with allocation and
> > deallocation of Guarded Control Stacks we do not permit any changes to
> > the GCS mode via ptrace, only GCSPR_EL0 may be changed.

> The code allows disabling GCS. Is that unintended?

No, it's intentional - ptrace has a lot of control over the process,
there's not a huge point trying to protect against it doing a disable.
The reason we prevent enabling is the allocation of a GCS along with
enable, the complexity of doing that on a remote process seemed
unjustified.  If clone3() ends up allowing manual allocation and
placement that'll likely be revised.

--+xOPyWhFp+ttqF+R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmV1yb8ACgkQJNaLcl1U
h9BWYwf/Tu6vlQCwGJ174Zum1yyKhNrP0gXrNj0hXhil/y9CwTApo4pvBUMmBwQz
JO0qoPePZDOSlxns1bELpj5O5sFq0c8qB1e29Y1nFzNClHf+uyVDswS2nZDBU6Rk
QyW/T7yJerJVj/Lw5Mh1iJMbf8+iOPyRCJ8iMOnYiCbPpOmz7FuarOxPowUXUTqe
e/bnana1ic+ctkWCw67wxEB6SJsOSaN2uW7mCj2ftjf9Cq9GmxzYnn8WuOvPHLxQ
1id5Q0hqIWUqpgKGWDeIng5VHThiIuZDUa4EWQga6fnVZnApv4pRNJY7ttyNS6SS
VfquKJpzBaa9lItRtIz5Dxs2gX1jyg==
=9ttk
-----END PGP SIGNATURE-----

--+xOPyWhFp+ttqF+R--
