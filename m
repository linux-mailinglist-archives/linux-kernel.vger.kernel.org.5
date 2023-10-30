Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 596B57DB832
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 11:35:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232637AbjJ3Kfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 06:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232535AbjJ3Kff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 06:35:35 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9297B4;
        Mon, 30 Oct 2023 03:35:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1698662130; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=akDGj953efFQEJfaAaz3wJPWsZqsl8dwjZHGf/QuEY6dAdSLtBA8JXUDXIO4/lsTGq
    RuJ65IyGjEewgBgucWwV/1bSbfCcIMsumuDXTiJPTYzH5TE5IDXlWVWuI1tvrKEofaP0
    e8YVZNmq+OZeaJx2tleu0BUgwT9fNDE4AX9iFVV6CEHY1Bo8lpW8rvRCylXVhT9OMAVf
    6cLOxRXR6Hc6R3sKxjVld8SwyYeEpAlxwP6QR2w6GFXQ9E2wW/gwGcIsB0882RqPY1f7
    dPAQvQBnqHo2kXpj8HPpkuYCcCSSaZs9pRd75A3UaaDfn77E0PEh6Jvw+3oWIGNz8F3r
    nONg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1698662130;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=C4AOi4HruYGw3hZLrT2mTKcCjB4YO62MIePJfTz8dds=;
    b=tmIv/pfzXtbYehKUaGKdXc4V0AHypbPsF8JYFUw52XWKgQi3m70Rxx7tt0USV6h4ch
    ZNB+fB9BWi3cdu+1jVcCH8GC+aB+2GBCR5WRBMQCm57YyVT5NPdKnJCiAs+m8MSBjYAN
    yyvmeT/dv4iQbbYOxeRodoTbMywSovsvXiFI3bpOXatXOZ8uJeyHmvPDzmUjVzb0+exW
    LwbIHyh/VOBQZ8+gJGoxijP4BuuCM/HaTrItUlgsCWhv4YKmM+jYR2SXZO2fy7ZcCPOk
    DDtguFJxT7oiC5QWqDUo59X73SpxuGaY2omHuo2Xc6CkcuA8ZWmIcavwpEV4pCWEPwBD
    wDkg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1698662130;
    s=strato-dkim-0002; d=chronox.de;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=C4AOi4HruYGw3hZLrT2mTKcCjB4YO62MIePJfTz8dds=;
    b=W1+Bx6ohvt5grgmuq91SISNICpxt6EpRDg90q4HrlzmfoN6LTFPWOOMjA2pHTWXkY9
    ya81fMapmB3JiEShzxktNkBAtnTNWJYoCbToMpG68gFPEWW727/vLt9EYOZt+g/sRp9s
    BeBLdU0EPtdpvJVhUT+c2O9YWBSUv5lzh3/Hkm/zj3nJytsPj59p/YBaAZzYccHmTcsW
    r2sG04fXRu72h0ekdKsiIwitijyDlwYEcXigBbbIO1LX9oRLRaslF6KvrpsjBEOkl31o
    YbXG+DGcMkXapFWvHEakA4avQjSDuXi/yIkVaudzehxvTLmlvKP0xJ/+CHwXumoO5lxT
    I/CA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1698662130;
    s=strato-dkim-0003; d=chronox.de;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=C4AOi4HruYGw3hZLrT2mTKcCjB4YO62MIePJfTz8dds=;
    b=SYVIZLhY6r8eGwhWoshmHTlqz1V8OliewM+S5cGopHPqNQUMWi7l1ge2qW1ffkUqgA
    jKlp2mAnEGd5bdzLrlBQ==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9yWsdNeEDyFXR1lg3JD8="
Received: from tauon.chronox.de
    by smtp.strato.de (RZmta 49.9.1 AUTH)
    with ESMTPSA id 6b1cadz9UAZTTj9
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 30 Oct 2023 11:35:29 +0100 (CET)
From:   Stephan Mueller <smueller@chronox.de>
To:     Dimitri John Ledkov <dimitri.ledkov@canonical.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, simo@redhat.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] crypto: drbg - update FIPS CTR self-checks to aes256
Date:   Mon, 30 Oct 2023 11:35:28 +0100
Message-ID: <1906073.RjUZ0rb3Up@tauon.chronox.de>
In-Reply-To: <CADWks+Z0b8GPSg37=TQK_5LqVejC_CzbOxn_TUsvkQ45TOyuYw@mail.gmail.com>
References: <20231029204823.663930-1-dimitri.ledkov@canonical.com>
 <6413919.eMfrkXpHmx@tauon.chronox.de>
 <CADWks+Z0b8GPSg37=TQK_5LqVejC_CzbOxn_TUsvkQ45TOyuYw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 30. Oktober 2023, 11:30:32 CET schrieb Dimitri John Ledkov:

Hi Dimitri,

> On Mon, 30 Oct 2023 at 12:23, Stephan Mueller <smueller@chronox.de> wrote:
> > Am Sonntag, 29. Oktober 2023, 21:48:21 CET schrieb Dimitri John Ledkov:
> > 
> > Hi Dimitri,
> > 
> > > When originally drbg was introduced FIPS self-checks for all types but
> > > CTR were using the most preferred parameters for each type of
> > > DRBG. Update CTR self-check to use aes256.
> > > 
> > > Fixes: 541af946fe ("crypto: drbg - SP800-90A Deterministic Random Bit
> > > Generator") Signed-off-by: Dimitri John Ledkov
> > > <dimitri.ledkov@canonical.com>
> > > 
> > > 
> > > 
> > > ---
> > > 
> > >  crypto/drbg.c | 6 +++---
> > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/crypto/drbg.c b/crypto/drbg.c
> > > index 2cce18dcfc..b120e2866b 100644
> > > --- a/crypto/drbg.c
> > > +++ b/crypto/drbg.c
> > > @@ -1478,8 +1478,8 @@ static int drbg_generate(struct drbg_state *drbg,
> > > 
> > >                       err = alg_test("drbg_pr_hmac_sha256",
> > >                       
> > >                                      "drbg_pr_hmac_sha256", 0, 0);
> > >               
> > >               else if (drbg->core->flags & DRBG_CTR)
> > > 
> > > -                     err = alg_test("drbg_pr_ctr_aes128",
> > > -                                    "drbg_pr_ctr_aes128", 0, 0);
> > > +                     err = alg_test("drbg_pr_ctr_aes256",
> > > +                                    "drbg_pr_ctr_aes256", 0, 0);
> > > 
> > >               else
> > >               
> > >                       err = alg_test("drbg_pr_sha256",
> > >                       
> > >                                      "drbg_pr_sha256", 0, 0);
> > > 
> > > @@ -2017,7 +2017,7 @@ static inline int __init
> > > drbg_healthcheck_sanity(void) return 0;
> > > 
> > >  #ifdef CONFIG_CRYPTO_DRBG_CTR
> > > 
> > > -     drbg_convert_tfm_core("drbg_nopr_ctr_aes128", &coreref, &pr);
> > > +     drbg_convert_tfm_core("drbg_nopr_ctr_aes256", &coreref, &pr);
> > > 
> > >  #endif
> > >  #ifdef CONFIG_CRYPTO_DRBG_HASH
> > >  
> > >       drbg_convert_tfm_core("drbg_nopr_sha256", &coreref, &pr);
> > 
> > I am not sure again whether this warrants a "Fixes" tag, because the first
> > modification is in a commented-out code section and the latter again
> > intends to test the DRBG thresholds and thus just needs "a" DRBG.
> 
> Agreed, it is more of a reference. But yes, I don't believe this needs
> to trigger stable backports - because yes it is like dead code, or
> fips only code which majority kernels don't do. Maybe I should
> reference that commit in description only?

I think this would be good to avoid the need to trigger backports for this 
"trivial" patch.

Thanks a lot.
> 
> > Anyhow:
> > 
> > Reviewed-by: Stephan Mueller <smueller@chronox.de>
> > 
> > 
> > Ciao
> > Stephan


Ciao
Stephan


