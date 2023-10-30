Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DFBE7DB80B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 11:27:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232533AbjJ3K05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 06:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232532AbjJ3K0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 06:26:54 -0400
X-Greylist: delayed 178 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 30 Oct 2023 03:26:52 PDT
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 402FFE9
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 03:26:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1698661431; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=OYveJeGr3RNT499TRmN+g8UPPI8wXtE9UlzNQ3/e7Rz8BdZ50r/TERSC4fHvmwAg91
    HiUHnlaB1yPPEmdstr4knjxj0aIRjX9E8BT0XpenLcTvznW5p2dFo8pWsgWRjOn/D0l1
    WBGJSk5SyR+jyCBqT3QbthcjKziXSs9oRETz3bIqr7xvfqSGtm1EU9Sp0l2xxD4ECZEw
    KfI2u/gv9Wfhc6Z0cF1ndg8JFCVuQefdn4YdW/aRBkd94jNpw231U2qH4q1N8vxbaVm0
    2otahnLz26yY/OVkkXxv5vwNq+gi4UFSCmyiwmMkyIl9oWoRpCe8Y4hR64KvDl4KA/GL
    kEUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1698661431;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=Is4ojSgv4+/AkEpUYaQLScwdT0YQ0luLjdPNWA9pmk4=;
    b=mKIv/NBfuAsFOEqVF3pAcU92xIYWJ6eJxW8gdFLTlfnSWDR/ATHMVBx9JXd28P5vkn
    hxNd7/EY1A9xoIGw7UZx4NiTF8d4e93rzsIF9Wu9lZWyoUbPaM5GwuL0ZRdFwc0XbI9A
    I5LFSOYCuxdy2xxx02Vdxbw8FGlDljRf0DuPT+K+QdZp8JKtyHgbXRGNJvDVFzHmSTdf
    3+uzegsk+o5ZiNcoICYvZ4YNVV36q6FJjVxOjqNQb32MazjS/ZcuidfwWVKmOF06zRpo
    9PFQ64DQmGBJ3egY9rJq15u7ALLicyRuTQYfBcbWqDN6aHePiTvbi96otxwVayFtJpmj
    YPWg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1698661431;
    s=strato-dkim-0002; d=chronox.de;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=Is4ojSgv4+/AkEpUYaQLScwdT0YQ0luLjdPNWA9pmk4=;
    b=J8gpWczp4C/WTKP9oImFoca1P33GTm+6lY3UuERoIDozFQ5NijQ6N1EjK1LJkIx0EH
    GhIJWd+5pH507Lcumjgaop9wt0ccbaGrSzP4wZTEr5gPsUqd6uGl28aE7BxwiQ+eJr8Z
    +hdqT8+RQjoOGQ+nQOF9c0468tTDZe4mYbBrxOiOBJgjts97XSsBK0Ot9kAgfwnFJKnY
    biYAzs8FW0nABmf9mXyg9cz2H8sKLDWAUDTdyQJSQKJ1JvHogev9+4c/dGMWiLFW4qpm
    KY8Yl7v1bpguGL84Jt3YQTxnhSSSCwR0Z3boLEHWn08/odi9op7DTeZ0xEkNlEz+FPU2
    4SqA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1698661431;
    s=strato-dkim-0003; d=chronox.de;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=Is4ojSgv4+/AkEpUYaQLScwdT0YQ0luLjdPNWA9pmk4=;
    b=7c2ELGgCqjWSYYNL1Y2+FW6P6MhCUOa8GPPiZqwc65ZMdGn4UVHC2s/yIPBLmrRh1O
    K/PE1nmJGjsy/lQ5+fAw==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9yWsdNeEDyFXR1lg3JD8="
Received: from tauon.chronox.de
    by smtp.strato.de (RZmta 49.9.1 AUTH)
    with ESMTPSA id 6b1cadz9UANnTda
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 30 Oct 2023 11:23:49 +0100 (CET)
From:   Stephan Mueller <smueller@chronox.de>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Dimitri John Ledkov <dimitri.ledkov@canonical.com>
Cc:     simo@redhat.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] crypto: drbg - update FIPS CTR self-checks to aes256
Date:   Mon, 30 Oct 2023 11:23:49 +0100
Message-ID: <6413919.eMfrkXpHmx@tauon.chronox.de>
In-Reply-To: <20231029204823.663930-2-dimitri.ledkov@canonical.com>
References: <20231029204823.663930-1-dimitri.ledkov@canonical.com>
 <20231029204823.663930-2-dimitri.ledkov@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 29. Oktober 2023, 21:48:21 CET schrieb Dimitri John Ledkov:

Hi Dimitri,

> When originally drbg was introduced FIPS self-checks for all types but
> CTR were using the most preferred parameters for each type of
> DRBG. Update CTR self-check to use aes256.
> 
> Fixes: 541af946fe ("crypto: drbg - SP800-90A Deterministic Random Bit
> Generator") Signed-off-by: Dimitri John Ledkov
> <dimitri.ledkov@canonical.com>



> ---
>  crypto/drbg.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/crypto/drbg.c b/crypto/drbg.c
> index 2cce18dcfc..b120e2866b 100644
> --- a/crypto/drbg.c
> +++ b/crypto/drbg.c
> @@ -1478,8 +1478,8 @@ static int drbg_generate(struct drbg_state *drbg,
>  			err = alg_test("drbg_pr_hmac_sha256",
>  				       "drbg_pr_hmac_sha256", 0, 0);
>  		else if (drbg->core->flags & DRBG_CTR)
> -			err = alg_test("drbg_pr_ctr_aes128",
> -				       "drbg_pr_ctr_aes128", 0, 0);
> +			err = alg_test("drbg_pr_ctr_aes256",
> +				       "drbg_pr_ctr_aes256", 0, 0);
>  		else
>  			err = alg_test("drbg_pr_sha256",
>  				       "drbg_pr_sha256", 0, 0);
> @@ -2017,7 +2017,7 @@ static inline int __init drbg_healthcheck_sanity(void)
> return 0;
> 
>  #ifdef CONFIG_CRYPTO_DRBG_CTR
> -	drbg_convert_tfm_core("drbg_nopr_ctr_aes128", &coreref, &pr);
> +	drbg_convert_tfm_core("drbg_nopr_ctr_aes256", &coreref, &pr);
>  #endif
>  #ifdef CONFIG_CRYPTO_DRBG_HASH
>  	drbg_convert_tfm_core("drbg_nopr_sha256", &coreref, &pr);

I am not sure again whether this warrants a "Fixes" tag, because the first 
modification is in a commented-out code section and the latter again intends 
to test the DRBG thresholds and thus just needs "a" DRBG.

Anyhow:

Reviewed-by: Stephan Mueller <smueller@chronox.de>


Ciao
Stephan


