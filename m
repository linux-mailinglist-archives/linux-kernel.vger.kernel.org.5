Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 607C77DB823
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 11:31:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232594AbjJ3KbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 06:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232532AbjJ3KbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 06:31:19 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD4069E
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 03:31:15 -0700 (PDT)
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com [209.85.167.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id CEBFC3F129
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 10:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1698661869;
        bh=9khDIoutyVVO4OorlUjWR4zCGtUfevyQIKBqlCrcSI4=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=b7jjbcevW6TEkqWllgoeUjGHjvOfuI2jC4XmBXk3cf+A/gWbxjNdCqGzR22Hhrh1R
         G+Uj/SK5yzOJQQ56W7FKEfVpC+kVf9JNz3JDlDsveW5Z+FTxPzh7duJ7mTyggJnyYR
         fDhbxAkgvqro6bPkppuEc2mRT5fe6zk65G7WI98PjDAU0wvQf6C2T4Yt9gkmtzIb8T
         t9xUpRCB+Eq+XVyc1fp7O8JsfEmJ5zChC9yMzcI6VONO80afizsQc1pojkoXg4W/Ae
         AdjLA1CSBfF7NmffTwj4gWfYHD15p9ZJBb3vh8aILB5fqpCDID/fltYdYEnZpWacnQ
         8SozQFnZud69Q==
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-507b8ac8007so5144968e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 03:31:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698661868; x=1699266668;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9khDIoutyVVO4OorlUjWR4zCGtUfevyQIKBqlCrcSI4=;
        b=Lk4ozucOgE5Cym0We8ZbrgbwI7+SFVSUwj1vwVXh8DR9/I2shVSiUlMjkGFHJlY1O5
         b/vPBxoIZd6y+E3oNrze467Jj3TiYqHSMB2A+Ig/CvG4W+Fjw9Q5BB7qp7yIB3S5arGf
         50ncxj2aqOS6PdP5RtLMbJ8r8cTTP5BQJ/O6SiDgQRGvGRn+3IgEbIo6TwAxW1zyRfJb
         BRNr6k+UNKOGVxkwvHuk0HU2eGozL6O8/iwNAOCly+4liNSntaZqp1ttPraMQW+R3bLv
         NmYGF9g7AUVnIxc7te9qXUUtzRG9XaL1CWsUMIeyGjfouQF9ghBseObDHW4Fby+jmGlY
         R76w==
X-Gm-Message-State: AOJu0Ywa9arIeQe3T2WTpVI9SFAqmij48wZUJkR/7pfi4iLgEglnxcQ3
        Fzsf1fASBgeRG4WCkQ4MJufesO8DhpebLAIjqjXoE72H7K1cTHoRgf1FPyJKfE6iVDgJHvHQstw
        6SVT2V6MqHxCh3/C0QirtjoBwno3YYuoTLmnxsJ7i25sQ0aMGLao1qxFMQ38Ca0dkXEi3HLdtLA
        ==
X-Received: by 2002:a19:ca45:0:b0:502:9fce:b6da with SMTP id h5-20020a19ca45000000b005029fceb6damr6117131lfj.21.1698661868747;
        Mon, 30 Oct 2023 03:31:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzmok2NC2UFhT5xqTcur1IDEbtbIhjT5/OR1Odr6djEXj7xXwohl+4ifXuKC+ZtvwN2tG9K+tbsxMsHwtT0U8=
X-Received: by 2002:a19:ca45:0:b0:502:9fce:b6da with SMTP id
 h5-20020a19ca45000000b005029fceb6damr6117116lfj.21.1698661868368; Mon, 30 Oct
 2023 03:31:08 -0700 (PDT)
MIME-Version: 1.0
References: <20231029204823.663930-1-dimitri.ledkov@canonical.com>
 <20231029204823.663930-2-dimitri.ledkov@canonical.com> <6413919.eMfrkXpHmx@tauon.chronox.de>
In-Reply-To: <6413919.eMfrkXpHmx@tauon.chronox.de>
From:   Dimitri John Ledkov <dimitri.ledkov@canonical.com>
Date:   Mon, 30 Oct 2023 12:30:32 +0200
Message-ID: <CADWks+Z0b8GPSg37=TQK_5LqVejC_CzbOxn_TUsvkQ45TOyuYw@mail.gmail.com>
Subject: Re: [PATCH 2/4] crypto: drbg - update FIPS CTR self-checks to aes256
To:     Stephan Mueller <smueller@chronox.de>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, simo@redhat.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Oct 2023 at 12:23, Stephan Mueller <smueller@chronox.de> wrote:
>
> Am Sonntag, 29. Oktober 2023, 21:48:21 CET schrieb Dimitri John Ledkov:
>
> Hi Dimitri,
>
> > When originally drbg was introduced FIPS self-checks for all types but
> > CTR were using the most preferred parameters for each type of
> > DRBG. Update CTR self-check to use aes256.
> >
> > Fixes: 541af946fe ("crypto: drbg - SP800-90A Deterministic Random Bit
> > Generator") Signed-off-by: Dimitri John Ledkov
> > <dimitri.ledkov@canonical.com>
>
>
>
> > ---
> >  crypto/drbg.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/crypto/drbg.c b/crypto/drbg.c
> > index 2cce18dcfc..b120e2866b 100644
> > --- a/crypto/drbg.c
> > +++ b/crypto/drbg.c
> > @@ -1478,8 +1478,8 @@ static int drbg_generate(struct drbg_state *drbg,
> >                       err = alg_test("drbg_pr_hmac_sha256",
> >                                      "drbg_pr_hmac_sha256", 0, 0);
> >               else if (drbg->core->flags & DRBG_CTR)
> > -                     err = alg_test("drbg_pr_ctr_aes128",
> > -                                    "drbg_pr_ctr_aes128", 0, 0);
> > +                     err = alg_test("drbg_pr_ctr_aes256",
> > +                                    "drbg_pr_ctr_aes256", 0, 0);
> >               else
> >                       err = alg_test("drbg_pr_sha256",
> >                                      "drbg_pr_sha256", 0, 0);
> > @@ -2017,7 +2017,7 @@ static inline int __init drbg_healthcheck_sanity(void)
> > return 0;
> >
> >  #ifdef CONFIG_CRYPTO_DRBG_CTR
> > -     drbg_convert_tfm_core("drbg_nopr_ctr_aes128", &coreref, &pr);
> > +     drbg_convert_tfm_core("drbg_nopr_ctr_aes256", &coreref, &pr);
> >  #endif
> >  #ifdef CONFIG_CRYPTO_DRBG_HASH
> >       drbg_convert_tfm_core("drbg_nopr_sha256", &coreref, &pr);
>
> I am not sure again whether this warrants a "Fixes" tag, because the first
> modification is in a commented-out code section and the latter again intends
> to test the DRBG thresholds and thus just needs "a" DRBG.
>

Agreed, it is more of a reference. But yes, I don't believe this needs
to trigger stable backports - because yes it is like dead code, or
fips only code which majority kernels don't do. Maybe I should
reference that commit in description only?

> Anyhow:
>
> Reviewed-by: Stephan Mueller <smueller@chronox.de>
>
>
> Ciao
> Stephan
>
>

-- 
okurrr,

Dimitri
