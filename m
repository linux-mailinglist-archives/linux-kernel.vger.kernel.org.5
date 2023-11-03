Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 056457DFE0C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 03:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234785AbjKCCem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 22:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjKCCej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 22:34:39 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A6419E
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 19:34:30 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-53b32dca0bfso3227205a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 19:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1698978869; x=1699583669; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=83Mh0Hre2kxUrqYxpVjiCMzDqfE2crUP+cBGGsoLEyY=;
        b=S2aQEWCAJPMS0Rd8RKVTkbSyVYThUf+sYKWWUH7RJgsA4SpOTbfO/GiH4BBbhZeFoS
         RrEO/ucxqVnBqAyf14muUyVquYYRBWUlY/UPgkrqKlDBsaUC0vszIpcs6nadxD2RC9lN
         9PEIIACcVWRJDjSKpEu2Lo9Sa5wxKuEXXyJ5c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698978869; x=1699583669;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=83Mh0Hre2kxUrqYxpVjiCMzDqfE2crUP+cBGGsoLEyY=;
        b=MZZq5t1yis4sz0nHVEKJZEjFo81jAnSAdCPWhOZT6lNMtC9PsiJVN4qV5ynk6Zbmvj
         8/YI4VRIK96MFx8lYyzZVc0uNYCBOVtcFSaKVXhI76zx4Zkw1mXaRGFWAqDKRKSpcive
         Ns1OiDOYq7pOqcg70SCsYRqZQgj+FMRZ5F+o683+HdLq9TWvWDBjOj9MWWakuTw40K7u
         lGxF1kWY2TdsLE9k1He/FnT6r8nmZN8Ak6T1H55MR1MYJAWFnQfcmLTeyPiaHy6Zm3pW
         O2L4ACfqBF9lIrwE+6cYUk8f+Af+kuKzUzngHU7Hj1D2/lJTLHpKrkOLsy+dPx06yuIG
         H6og==
X-Gm-Message-State: AOJu0YzL73HSCM2e7vM0x4v11vXHc3+/5w9gPWHViM7trnYuygpO19cG
        KSkQPNiQB4hUgrnavHW0jUp7jXvRng0ncJtf4BrtX84h
X-Google-Smtp-Source: AGHT+IH9E/1zb3eXGgt05ByKEI1WGxQ0HhmRuXU6g9oXeF7f6zFxDuOkvOCiQizu3lmgc8Pu8t/S/g==
X-Received: by 2002:a50:d550:0:b0:53e:ad97:82d3 with SMTP id f16-20020a50d550000000b0053ead9782d3mr1382172edj.13.1698978869240;
        Thu, 02 Nov 2023 19:34:29 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id j2-20020a50ed02000000b0053e8f1f79afsm402143eds.30.2023.11.02.19.34.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Nov 2023 19:34:28 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-9becde9ea7bso539381266b.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 19:34:28 -0700 (PDT)
X-Received: by 2002:a17:906:c450:b0:9a5:c38d:6b75 with SMTP id
 ck16-20020a170906c45000b009a5c38d6b75mr1120736ejb.15.1698978868229; Thu, 02
 Nov 2023 19:34:28 -0700 (PDT)
MIME-Version: 1.0
References: <YjE5yThYIzih2kM6@gondor.apana.org.au> <YkUdKiJflWqxBmx5@gondor.apana.org.au>
 <YpC1/rWeVgMoA5X1@gondor.apana.org.au> <Yui+kNeY+Qg4fKVl@gondor.apana.org.au>
 <Yzv0wXi4Uu2WND37@gondor.apana.org.au> <Y5mGGrBJaDL6mnQJ@gondor.apana.org.au>
 <Y/MDmL02XYfSz8XX@gondor.apana.org.au> <ZEYLC6QsKnqlEQzW@gondor.apana.org.au>
 <ZJ0RSuWLwzikFr9r@gondor.apana.org.au> <ZOxnTFhchkTvKpZV@gondor.apana.org.au> <ZUNIBcBJ0VeZRmT9@gondor.apana.org.au>
In-Reply-To: <ZUNIBcBJ0VeZRmT9@gondor.apana.org.au>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 2 Nov 2023 16:34:11 -1000
X-Gmail-Original-Message-ID: <CAHk-=wj0-QNH5gMeYs3b+LU-isJyE4Eu9p8vVH9fb-vHHmUw0g@mail.gmail.com>
Message-ID: <CAHk-=wj0-QNH5gMeYs3b+LU-isJyE4Eu9p8vVH9fb-vHHmUw0g@mail.gmail.com>
Subject: Re: [GIT PULL] Crypto Update for 6.7
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Nov 2023 at 20:56, Herbert Xu <herbert@gondor.apana.org.au> wrote=
:
>
> Stephan M=C3=BCller (5):
>       crypto: jitter - add RCT/APT support for different OSRs
>       crypto: jitter - Allow configuration of memory size
>       crypto: jitter - Allow configuration of oversampling rate
>       crypto: jitter - reuse allocated entropy collector
>       crypto: jitter - use permanent health test storage

This is beyond annoying.

These are adding Kconfig questions that don't make sense. The whole
jitter thing is debatably useful in the first place, and now you just
annoy users with random questions.

And I mean truly random - the whole jitter entropy is voodoo
programming to begin with, and having some crazy 8MB buffer for it is
just ridiculous.

Honestly, this all smells like somebody's PhD thesis, not a real life thing=
.

And no, we don't make our Kconfig questions more annoying for some PhD thes=
is.

We also don't ask people questions that don't have valid answers. Just
because the whole "what is entropy in the first place" isn't
clear-cut, we don't then punt some tweaking question to the user.

We have a very simple and stupid jitter entropy thing AT BOOT TIME
just to try to generate some amount of entropy to make boots
non-repeatable (see "try_to_generate_entropy()" in
drivers/char/random.c).

Honestly, the whole crypto layer one is ridiculous overkill in the
first place, but the annoying new questions have now literally made me
consider just removing it entirely.

Because no, IT IS NOT OK TO ASK CRAZY QUESTIONS. If some developer
cannot come up with a reasonable answer, a random user sure has hell
cannot.

And no, any question that says "do you want to use 8MB of memory for
jitter entropy" is just batsh*t crazy.

This kind of crap needs to stop.

If somebody wants to do this kind of thing, just do it in user space.
It's ridiculously pointless in the kernel.

Convince me I'm wrong. But there is no way in *hell* you will convince
me that we should ask users about some jitter memory sizing.
Allocating memory for timing analysis is silly to begin with, since
any kernel thing could just use the physical memory mapping we already
have in the kernel. I suspect strongly that all this code has been
influenced by code running in user space, where it belongs, and where
you do need to allocate memory to have it available.

Please just make this noise go away.

             Linus
