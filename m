Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB905811FA1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 21:02:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378978AbjLMUC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 15:02:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjLMUC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 15:02:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3276DDC
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 12:02:34 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C1AFC433C8;
        Wed, 13 Dec 2023 20:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702497753;
        bh=TWKx/EtzYbtKFgsobV53zPra9sAQTzvSeeX3jZwDlRo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rw52VftygnvuTCgOrGI+gXe3TWpHtVdnfgBKILZHSSoQQfWcj4FiDZBF3q0xg/p1U
         yMyKDh7CfJhMPcfzgFLat+8qbBLeFz+kC6B1tBll2xoDe6ZR+lL4atc7TiTHTaVBXM
         KlV6aWd7XISTwMfEZMAy3uUu9bt6AO01rkUbbhpNndDZiRNqiRth1R5905LQyKnKba
         /Gu969kcPjCpd8VYSh4acTvsQvcFLrQg/odEGgysmo+09v0y9yHqoazxNAXt1jERrU
         3PEg1LuMx6NGBxtg6PTj1VO7B1PTnSanvAI6Vm8xADmZDlQepBudQj+aTfcAbjr2x0
         iLnlO4srSoqvg==
Date:   Wed, 13 Dec 2023 20:02:24 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Deepak Gupta <debug@rivosinc.com>
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
        Ard Biesheuvel <ardb@kernel.org>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        "H.J. Lu" <hjl.tools@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Florian Weimer <fweimer@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        Thiago Jung Bauermann <thiago.bauermann@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v7 20/39] arm64/gcs: Context switch GCS state for EL0
Message-ID: <b2a717a7-e6d3-4fa9-921e-156c17ad5424@sirena.org.uk>
References: <20231122-arm64-gcs-v7-0-201c483bd775@kernel.org>
 <20231122-arm64-gcs-v7-20-201c483bd775@kernel.org>
 <CAKC1njQVB71A8fQBLmBnx++agM12XDLhS=7iL7-A4NTXSqUM+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="p5BMo6xEVagOzbFU"
Content-Disposition: inline
In-Reply-To: <CAKC1njQVB71A8fQBLmBnx++agM12XDLhS=7iL7-A4NTXSqUM+A@mail.gmail.com>
X-Cookie: One size fits all.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--p5BMo6xEVagOzbFU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 11:59:45AM -0800, Deepak Gupta wrote:
> On Wed, Nov 22, 2023 at 1:45=E2=80=AFAM Mark Brown <broonie@kernel.org> w=
rote:

> > +       if (task->thread.gcs_el0_mode & PR_SHADOW_STACK_ENABLE)
> > +               gcscre0_el1 |=3D GCSCRE0_EL1_RVCHKEN | GCSCRE0_EL1_PCRS=
EL;

> If the intent is to disable, is the GCS stack freed or kept around?
> I expect if libc is taking the decision to disable, kernel should free it=
 up.
> Is it freed in some other flow?

Kept around and freed on thread exit.  There is a potential race between
for example disabling in a signal handler and something trying to walk
the stack so we err on the side of caution.

--p5BMo6xEVagOzbFU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmV6Dc8ACgkQJNaLcl1U
h9D/UQf/drLKsAxcIavasAKyvNxy00BF9vIZyHv3vJ+sFZEMcKnnX/8KO6A54p3z
Y5Oowl7starF/ef/S94c9GDD6e9ErIIZiUHOIWoegLpSIr9NL3p3q2pzJTSgEigR
7gxmR840FSDV235o0T16ajXu4aj3hg3eSiDmycP9Wh2TY6lNU+Uab1nhCM6mIgzY
Spu0s0+naKP+fYEkXZjhn15XHplZNEI2qLOIXhEpNJZHiEt1imkFwLa5GqHbaWUz
wqtAF1RUqcDm5hATvxuPbnPA0WsnHFGCniy5C7vyRNlcPGx+FBg2pW0O9Y47ff2a
Vt+12qPfZq/CDUunfX/IvKyQ3YO5+Q==
=JGbe
-----END PGP SIGNATURE-----

--p5BMo6xEVagOzbFU--
