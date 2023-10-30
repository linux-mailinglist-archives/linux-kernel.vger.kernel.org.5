Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A16647DB805
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 11:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232773AbjJ3KZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 06:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232670AbjJ3KZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 06:25:32 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBBBF30F4;
        Mon, 30 Oct 2023 03:25:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1698661512; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Lyvo1+Y3zYEMiJCSxo002lV70DgPCaCJFvjjdPZxqKhGIIZ/pZhp636eJVD7NTXbCm
    VZ9GfeVdNBmwkoPTwLOmZ5lT8x1FgVkK20bI9TWyt5ScUwHcfZ+2QaYdQ9lTahPN9QRz
    cGC8CMBIUnehxLSdABDhwyFfRbkpFzeZ8v9EvumoLM2PRZqNH7ywAZmxN3dOsgvMG5K7
    xPV645MuRc87017GuXkasGQHsaVUpEuEgsFXrNOMN7BBU1rkdiMpaxF0ZuGPpH5Qq1hd
    zuB0rYJu3qI+OayUVq0tiuKgOkKvemQrkApWApvmjjWJczIHVcXv+EkuYHGWK52PmJm0
    c7Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1698661512;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=nW7t5qk8ZOwl0I2iOjUs2qZZIIv055srKXHOAhTKjx8=;
    b=N48Vt45waqCxZYBHaKI2/DFxG0h6xGr483ilrNK8VPKybXHj/ODw3fre2RQYk3S9na
    9DKwbr4O9ZN0H4O1VbyKEr9qBEbLbiNlrEbpusCBxaCTkHMhuClFEtXgGU9kO3zxPJfc
    SnyhnSNq9/0cTr9AkbPPDz5pVGyL4TupT4iG0yJb75M+HH1j8JpWrx7eAHRJ/wvbEZr3
    jpXOa30qRP0XM8NagOzys+VYo0EKIN8x2SFDkYXcGEnUVR+bKYRvGGcnT1s7RyS+PdD3
    X3QAk8TWF+mPR4BBmYguV9bBqx+UPQNHUZp486yUVlDlJI+SqDQX5R+8FT/WUfsOG1y9
    izOQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1698661512;
    s=strato-dkim-0002; d=chronox.de;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=nW7t5qk8ZOwl0I2iOjUs2qZZIIv055srKXHOAhTKjx8=;
    b=thVYhhwbZzOu7Qq/u2cfoR56bZiDUpqV+550ZdmlpD8qVUybmBGB3Q6LvZRBVa2r0G
    MtS/W6hcfW7xk8n7RwLyV4Ov2pjmDv8o0Iokh3xjRieJjOiMfUfzCYGkEi7nEfBDddnJ
    FI+zfmPOB/86szIeQw1pjrrOKNksfteUIy+aApmj+QlqC+zol0K25HLBf2iqwMhAzIHq
    6IOHYszgTEQ/eAtR+ZJqbJTj6JkKR//4kBFaLkX+g0pgAGjAeQKjtxbVgVPKTgtJifZu
    UnKJ80KzB/F4sBuUwxO4ko0bAr9cMbrScQV/CYWbjIMpbJ2aCuRzw2uH8ha4rZIr/UKb
    kIDg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1698661512;
    s=strato-dkim-0003; d=chronox.de;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=nW7t5qk8ZOwl0I2iOjUs2qZZIIv055srKXHOAhTKjx8=;
    b=Ac/3+YounsoAC9R4UW0zBnFHrbMNIVu7qb97py7s4GNIphcG3toDiwcQTDxVxu9Zj7
    CkmXI16ifTn+vJoCCaCA==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9yWsdNeEDyFXR1lg3JD8="
Received: from tauon.chronox.de
    by smtp.strato.de (RZmta 49.9.1 AUTH)
    with ESMTPSA id 6b1cadz9UAPBTeZ
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 30 Oct 2023 11:25:11 +0100 (CET)
From:   Stephan Mueller <smueller@chronox.de>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        simo Sorce <simo@redhat.com>,
        Dimitri John Ledkov <dimitri.ledkov@canonical.com>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] crypto: drbg - ensure drbg hmac sha512 is used in FIPS
 selftests
Date:   Mon, 30 Oct 2023 11:25:10 +0100
Message-ID: <13171794.nZ9L9QUk69@tauon.chronox.de>
In-Reply-To: <20231029204823.663930-3-dimitri.ledkov@canonical.com>
References: <20231029204823.663930-1-dimitri.ledkov@canonical.com>
 <20231029204823.663930-3-dimitri.ledkov@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 29. Oktober 2023, 21:48:22 CET schrieb Dimitri John Ledkov:

Hi Dimitri,

> Update code comment, self test & healthcheck to use HMAC SHA512,
> instead of HMAC SHA256. These changes are in dead-code, or FIPS
> enabled code-paths only and have not effect on usual kernel builds.
> 
> On systems booting in FIPS mode that has the effect of switch sanity
> selftest to HMAC sha512 based (which has been the default DRBG).
> 
> Fixes: 9b7b94683a ("crypto: DRBG - switch to HMAC SHA512 DRBG as default
> DRBG") Signed-off-by: Dimitri John Ledkov <dimitri.ledkov@canonical.com>
> ---
>  crypto/drbg.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/crypto/drbg.c b/crypto/drbg.c
> index b120e2866b..99666193d9 100644
> --- a/crypto/drbg.c
> +++ b/crypto/drbg.c
> @@ -111,9 +111,9 @@
>   * as stdrng. Each DRBG receives an increasing cra_priority values the
> later * they are defined in this array (see drbg_fill_array).
>   *
> - * HMAC DRBGs are favored over Hash DRBGs over CTR DRBGs, and
> - * the SHA256 / AES 256 over other ciphers. Thus, the favored
> - * DRBGs are the latest entries in this array.
> + * HMAC DRBGs are favored over Hash DRBGs over CTR DRBGs, and the
> + * HMAC-SHA512 / SHA256 / AES 256 over other ciphers. Thus, the
> + * favored DRBGs are the latest entries in this array.
>   */
>  static const struct drbg_core drbg_cores[] = {
>  #ifdef CONFIG_CRYPTO_DRBG_CTR
> @@ -1475,8 +1475,8 @@ static int drbg_generate(struct drbg_state *drbg,
>  		int err = 0;
>  		pr_devel("DRBG: start to perform self test\n");
>  		if (drbg->core->flags & DRBG_HMAC)
> -			err = alg_test("drbg_pr_hmac_sha256",
> -				       "drbg_pr_hmac_sha256", 0, 0);
> +			err = alg_test("drbg_pr_hmac_sha512",
> +				       "drbg_pr_hmac_sha512", 0, 0);
>  		else if (drbg->core->flags & DRBG_CTR)
>  			err = alg_test("drbg_pr_ctr_aes256",
>  				       "drbg_pr_ctr_aes256", 0, 0);
> @@ -2023,7 +2023,7 @@ static inline int __init drbg_healthcheck_sanity(void)
> drbg_convert_tfm_core("drbg_nopr_sha256", &coreref, &pr);
>  #endif
>  #ifdef CONFIG_CRYPTO_DRBG_HMAC
> -	drbg_convert_tfm_core("drbg_nopr_hmac_sha256", &coreref, &pr);
> +	drbg_convert_tfm_core("drbg_nopr_hmac_sha512", &coreref, &pr);
>  #endif
> 
>  	drbg = kzalloc(sizeof(struct drbg_state), GFP_KERNEL);

Reviewed-by: Stephan Mueller <smueller@chronox.de>

Ciao
Stephan


