Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD6FA7E6B79
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 14:49:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234055AbjKINtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 08:49:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbjKINtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 08:49:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FFED2D59
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 05:49:03 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B717BC433C9;
        Thu,  9 Nov 2023 13:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699537743;
        bh=zRN/6P5lrsqVZwM9CTjtyq9M5h0TpNvvCvqPY+fc9Fk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HJ14EKtQsn2SophxX8pKBwLgmqhSlvFF0PhYFTRbQ3O9+rjlI6qcL3RKEkBmWLLlM
         qikTtADC5C2Gc8hs3tFLIiIqS77lecxoYu0gqyLWXP9sGb8RXaxVMgmDSBGTkjlmfG
         tin7Tw9BcQvPRKXub995nBRY642+0sMS/8rEBpWrXRRZK5FKicLYuzC6ECuo+BdE8Q
         dmR8VVAh7cXSM9DWjachOTfDq76Vlt5RLcxv+Xu2aXuxveoYaPbnB/a9DX8otn2cCr
         Pra3/n05tjNrvhbgPh3SErDNH83osTI6aNhMsJLCLUgQDuNEZnlEkpWvPbTz3y9/xF
         KXWudR+iOskag==
Date:   Thu, 9 Nov 2023 13:49:00 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     x86@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, luto@kernel.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        debug@rivosinc.com, pengfei.xu@intel.com
Subject: Re: [PATCH] x86/shstk: Change SSP after user accesses
Message-ID: <ZUzjLy0IzqypDHYV@finisterre.sirena.org.uk>
References: <20231107182251.91276-1-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Q3Gs7OgqUD5phJZ1"
Content-Disposition: inline
In-Reply-To: <20231107182251.91276-1-rick.p.edgecombe@intel.com>
X-Cookie: Slow day.  Practice crawling.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Q3Gs7OgqUD5phJZ1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 07, 2023 at 10:22:51AM -0800, Rick Edgecombe wrote:

> Fix this by adjusting the SSP register only after any userspace accesses,
> such that there can be no failures after the SSP is adjusted. Do this by
> moving the shadow stack sigframe push logic to happen after all other
> userspace accesses.

Thanks for the heads up on this.  From inspection it looks like the
arm64 patches currently order things similarly to your new x86 code.

Reviewed-by: Mark Brown <broonie@kernel.org>

--Q3Gs7OgqUD5phJZ1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVM40sACgkQJNaLcl1U
h9BKYgf/axzjgkzK55seZ98dWUhnmtDN0m/OzeP7UBiD/oVzQKjt9e65XTpwO75Q
PlRWQ0Ci+1V0qiUNPUs2oBgHj9MBObK3Ofq+vzo1lI5jzERUJdLVUmp/zIfG8CiV
r9z5aeQP1O3wMknIdtgrj0txUpV7slESDtvMIoj2l1OlG4Rc7UsqUkC/VMaSZibA
ujtOPK5k23GdL4E3Yy2J8JYubpEJB4uRPqrd0nVhnnmTGFuE4KOWc1iK7FoCnbuv
GJvG2Y/HDhU383xN1MKZfw0jlJDTzdmCwv2M7Wmw/b0vSH0RMtDsgdYQ/oypMkHf
97vsriyKrLq8q9wn87oNJlwiaqDqfA==
=ta/2
-----END PGP SIGNATURE-----

--Q3Gs7OgqUD5phJZ1--
