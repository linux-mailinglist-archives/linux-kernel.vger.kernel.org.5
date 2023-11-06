Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 322187E289C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 16:26:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbjKFP0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 10:26:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232077AbjKFP0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 10:26:04 -0500
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA4F8125;
        Mon,  6 Nov 2023 07:25:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1699284356; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=UCypJLI2/6Im0BcJK2hsUf5uWGwEgvC6d7BF+zVrib0j+3ldCtveiqz0JlHaqubsQ/
    F1ZDbHMuh1mLc8BG6iaMiAOVz01HCqzmF6bj9463VXt0myJ7i3flaZL8x2DSbgNEFdeP
    NCd52aTp/wLkAqqQjZJ6/KyOUsnMi05g5oGr0JZCesYFiUdcI3ARx2hDUmcb1D1RTHV9
    Tq0CzEPH5S4JwCg8XuGKLsPZOCVYkP4ez1MvsxSqNxB1Vl6srjhggvP1RsNMpDqP3g6c
    Ulx8vcwSu+9z6AiUeVVRQgnzqyeTbz7WOv+S13qSkkTGHiXmRJTU+9y7cZ3+VjwocCI7
    gTjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1699284356;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=4+7Xy5eB573jOAnhsPwiB88+6XPcbZGKnLQ8s6Ckgzo=;
    b=m8RlJIOtDcYSysLv/GKbiCjSuEGVVhagrGvDMTdNm1I/CGp/Q7inMUdeLeZXnDLBwt
    64skjjyNhIuRMS5pdlMPqP5VgZOzWNuwfxvMDaS9f+JsvF6Z6PozFSJGBajcAEd0SkiC
    OrUEAlAaCR+b9Q3XXpFdYfCTJG5QDkDCo8z2nX0ZIOWsfT7esEGubqUMASP+BUSjpxlV
    LF4NYJcLsHHKshDH4qh1is6cMsRXpPrFt6+qH+VAR5RxlCDDc9XoZTuyp6k4h0hq8fAy
    IR1r1wBb3+6S/T4qqvFAL3apQrRxG84iICrSFc6EnPx0LFpUZl9AWAM+8TYFOCKskZom
    AG5w==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1699284356;
    s=strato-dkim-0002; d=chronox.de;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=4+7Xy5eB573jOAnhsPwiB88+6XPcbZGKnLQ8s6Ckgzo=;
    b=XRo1mPwdu9PLzhUr5RqXiezTiv3NxqcdNsI2ctoiy915GEbsgr6s3cpS0iAMHX6ohh
    lRmW6+I4XrtQyIOQwmbuf6EiBP1RsC43HQiD9KptwKxi7fzXGG4enR141j+QXw7yMaPQ
    InNFinFzTemGQdMgpWfJFgFzsz3FrY60w/n9Rx586ohS3VDAX9v5Ve0dBLhvZTFUDrGn
    lF+u5n5GoxL70duglcOkpumo06UzSvKk2hudk1HwPZAbSwcskylIcfll2e/Ye4i68woZ
    CmedpbHoBsD06z/GpLbNd06w1Pz5lZd08QYDdScoAlfr8OePD5iFn+cpqvWnYIc6tDWO
    kN6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1699284356;
    s=strato-dkim-0003; d=chronox.de;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=4+7Xy5eB573jOAnhsPwiB88+6XPcbZGKnLQ8s6Ckgzo=;
    b=oOrkLeqOsc787HxWrD7wGw20Eu/e6FHS9dXU5xvGR5f0Minu2DVhDTYXxVW1r0Leum
    LswCVbMvhD62XWy7DzBg==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9zmwdP57PWmc+BP1jdA=="
Received: from tauon.chronox.de
    by smtp.strato.de (RZmta 49.9.1 AUTH)
    with ESMTPSA id 6b1cadzA6FPrBht
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 6 Nov 2023 16:25:53 +0100 (CET)
From:   Stephan Mueller <smueller@chronox.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Steffen Klassert <steffen.klassert@secunet.com>
Subject: Re: [PATCH] crypto: jitterentropy - Hide esoteric Kconfig options under FIPS
 and EXPERT
Date:   Mon, 06 Nov 2023 16:25:51 +0100
Message-ID: <3094055.QNPB7aoccF@tauon.chronox.de>
In-Reply-To: <ZUi5KMUaNkp0c1Ds@gondor.apana.org.au>
References: <Yzv0wXi4Uu2WND37@gondor.apana.org.au>
 <CAHk-=wh=xH7TNHeaYdsrVW6p1fCQEV5PZMpaFNsZyXYqzn8Stg@mail.gmail.com>
 <ZUi5KMUaNkp0c1Ds@gondor.apana.org.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 6. November 2023, 11:00:08 CET schrieb Herbert Xu:

Hi Herbert,

> On Thu, Nov 02, 2023 at 08:32:36PM -1000, Linus Torvalds wrote:
> > I think that would help the situation, but I assume the sizing for the
> > jitter buffer is at least partly due to trying to account for cache
> > sizing or similar issues?
> > 
> > Which really means that I assume any static compile-time answer to
> > that question is always wrong - whether you are an expert or not.
> > Unless you are just building the thing for one particular machine.
> > 
> > So I do think the problem is deeper than "this is a question only for
> > experts". I definitely don't think you should ask a regular user (or
> > even a distro kernel package manager). I suspect it's likely that the
> > question is just wrong in general - because any particular one buffer
> > size for any number of machines simply cannot be the right answer.
> > 
> > I realize that the commit says "*allow* for configuration of memory
> > size", but I really question the whole approach.
> 
> Yes I think these are all valid points.  I just noticed that I
> forgot to cc the author so let's see if Stephan has anything to
> add.

I concur that these questions are more for experts. 
> 
> > But yes - hiding these questions from any reasonable normal user is at
> > least a good first step.
> 
> OK here's the patch:
> 
> ---8<---
> As JITTERENTROPY is selected by default if you enable the CRYPTO
> API, any Kconfig options added there will show up for every single
> user.  Hide the esoteric options under EXPERT as well as FIPS so
> that only distro makers will see them.
> 
> Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
> 
> diff --git a/crypto/Kconfig b/crypto/Kconfig
> index bbf51d55724e..70661f58ee41 100644
> --- a/crypto/Kconfig
> +++ b/crypto/Kconfig
> @@ -1297,10 +1297,12 @@ config CRYPTO_JITTERENTROPY
> 
>  	  See https://www.chronox.de/jent.html
> 
> +if CRYPTO_JITTERENTROPY
> +if CRYPTO_FIPS && EXPERT
> +
>  choice
>  	prompt "CPU Jitter RNG Memory Size"
>  	default CRYPTO_JITTERENTROPY_MEMSIZE_2
> -	depends on CRYPTO_JITTERENTROPY
>  	help
>  	  The Jitter RNG measures the execution time of memory accesses.
>  	  Multiple consecutive memory accesses are performed. If the memory
> @@ -1344,7 +1346,6 @@ config CRYPTO_JITTERENTROPY_OSR
>  	int "CPU Jitter RNG Oversampling Rate"
>  	range 1 15
>  	default 1
> -	depends on CRYPTO_JITTERENTROPY
>  	help
>  	  The Jitter RNG allows the specification of an oversampling rate (OSR).
>  	  The Jitter RNG operation requires a fixed amount of timing
> @@ -1359,7 +1360,6 @@ config CRYPTO_JITTERENTROPY_OSR
> 
>  config CRYPTO_JITTERENTROPY_TESTINTERFACE
>  	bool "CPU Jitter RNG Test Interface"
> -	depends on CRYPTO_JITTERENTROPY
>  	help
>  	  The test interface allows a privileged process to capture
>  	  the raw unconditioned high resolution time stamp noise that
> @@ -1377,6 +1377,28 @@ config CRYPTO_JITTERENTROPY_TESTINTERFACE
> 
>  	  If unsure, select N.
> 
> +endif	# if CRYPTO_FIPS && EXPERT
> +
> +if !(CRYPTO_FIPS && EXPERT)
> +
> +config CRYPTO_JITTERENTROPY_MEMORY_BLOCKS
> +	int
> +	default 64
> +
> +config CRYPTO_JITTERENTROPY_MEMORY_BLOCKSIZE
> +	int
> +	default 32
> +
> +config CRYPTO_JITTERENTROPY_OSR
> +	int
> +	default 1
> +
> +config CRYPTO_JITTERENTROPY_TESTINTERFACE
> +	bool
> +
> +endif	# if !(CRYPTO_FIPS && EXPERT)
> +endif	# if CRYPTO_JITTERENTROPY
> +
>  config CRYPTO_KDF800108_CTR
>  	tristate
>  	select CRYPTO_HMAC

Reviewed-by: Stephan Mueller <smueller@chronox.de>


Ciao
Stephan


