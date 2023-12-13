Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78E06811311
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 14:37:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379276AbjLMNhi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 08:37:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379275AbjLMNhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 08:37:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B07CEB
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 05:37:42 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FCFAC433C8;
        Wed, 13 Dec 2023 13:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702474661;
        bh=8D28zVA3/D34uSBC1WEJ8ykZpQrL4Gv4bA1SewGPSEQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dU6A6nqfPwdapBIE6N5MQX1pPgpiei2rY3w1Dun0KrZbDxbcB1dhzPyz1J2EGaTQj
         UPKZzVa039jVPJ33WfaTofzmcvZFSA/sLBnrGvxr16zaGokjdOl0SKR/ib2Xhd4pc3
         SeyCrYIvK1T7imXgRQXe3wDjMIqDoeMuXfobvB10h24nt3i0W5VNcMCs1A+EjSLVk5
         f5bcJfQFA0CN8h3S3SdylU7dYmBC9Cd6O+XAZDg7IVkEU8ruiejVfPviMrjE77eEXR
         A5aDJUCFKs/hXAy8O8flLE5igxpFsClxETJo/OA439A7sHSLT3d8ZylWdGK4KyBm0k
         t9qtTI5q/WF8g==
Date:   Wed, 13 Dec 2023 13:37:32 +0000
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
Subject: Re: [PATCH v7 02/39] prctl: arch-agnostic prctl for shadow stack
Message-ID: <0d0d8802-09e3-4ea5-a0b4-b3a08c8a282e@sirena.org.uk>
References: <20231122-arm64-gcs-v7-0-201c483bd775@kernel.org>
 <20231122-arm64-gcs-v7-2-201c483bd775@kernel.org>
 <CAKC1njSC5cC_fXnyNAPt=WU6cD-OjLKFxo90oVPmsLJbuWf4nw@mail.gmail.com>
 <d708b493-267a-4418-be91-9bde6b2cf50c@sirena.org.uk>
 <CAKC1njSQPO8ja7AkTzQ724hhSsGjchH9dLbbH9LXP0ZiKj-zPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jOCIbEw8Unb2aajd"
Content-Disposition: inline
In-Reply-To: <CAKC1njSQPO8ja7AkTzQ724hhSsGjchH9dLbbH9LXP0ZiKj-zPQ@mail.gmail.com>
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


--jOCIbEw8Unb2aajd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 12, 2023 at 04:50:38PM -0800, Deepak Gupta wrote:

> A theoretical scenario (no current workloads should've this case
> because no shadow stack)

> - User mode did _ENABLE on the main thread. Shadow stack was allocated
> for the current
>   thread.
> - User mode created a bunch worker threads to run untrusted contained
> code. They shadow
>   stack too.
> - main thread had to do dlopen and now need to disable shadow stack on
> itself due to
>   incompatibility of incoming object in address space.
> - main thread controls worker threads and knows they're contained and
> should still be running
>   with a shadow stack. Although once in a while the main thread needs
> to perform writes to a shadow
>   stack of worker threads for some fixup (in the same addr space).
> main thread doesn't want to delegate
>   this responsibility of ss writes to worker threads because they're untrusted.

> How will it do that (currently _ENABLE is married to _WRITE and _PUSH) ?

That's feeling moderately firmly into "don't do that" territory to be
honest, the problems of trying to modify the stack of another running
thread while it's active just don't seem worth it - if you're
coordinating enough to do the modifications it's probably possible to
just ask the thread who's stack is being modified to do the modification
itself and having an unprotected thread writing into shadow stack memory
doesn't feel great.

That said in terms of the API there would be nothing stopping us saying
that _WRITE by itself is a valid combination of flags, in which case the
thread would have permission to write to any shadow stack memory it
could get to.  For arm64 I think we can implement that, I'm not sure
about x86.  _PUSH without _ENABLE is a lot less clear, you would at the
very least at some point have had a stack enabled to have a stack
pointer.

--jOCIbEw8Unb2aajd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmV5s5sACgkQJNaLcl1U
h9Av7gf+KhSSwAMSrKGbuD6mcS24/uKiaBK6VJvANYNhzxAxCIsGTekSDBnn5rx5
JlxvhNT7TTqtigEvZs5VwVjBivsip6vCjdwW3bWOP1hBY1vThXm5vDpp6+hC/Xyq
1dBwZcHedqhHVCH5AfwYiFDtW37k7rKggU19mKapXAMMLHcqniPH9vA8JNfwjvRk
IZAXnqu2sqKKqhm79iZyFDFo2+8bZYgiZ2FaFCUSA853dm4ujBY2+W9uL4me61jV
gAwO2vLgmoypMv3xyz83VV6rVoAP3icyuBVYgjuko58Xs74dY4FtD+Xyth9g93qO
A5biKwps6ME8omCBijyTFUn4Ug8G4A==
=M047
-----END PGP SIGNATURE-----

--jOCIbEw8Unb2aajd--
