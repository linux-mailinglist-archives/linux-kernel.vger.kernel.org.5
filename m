Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABAB17E013F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 11:31:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbjKCGdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 02:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbjKCGdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 02:33:02 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB501B4
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 23:32:56 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-543456dbd7bso5465323a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 23:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1698993175; x=1699597975; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VyO1Z+S61kc8i/PizQbBIUgo6r//ondY8h0vjsIi3rI=;
        b=VW3j1xQ7TfWnVS5CQUvuXuRug9aMR4VjwGkaDd+ILQLGHJ49mF9aNafAQNZb9tb0pH
         OakWaouChUX28UgHtDppKSH210ULPs3bVnTSSqMwFZiSSDN2bhGMKuYKlqYuWcfuUcQG
         /Q11BJEzBhvWJwelbIkWVDjgcLLQx31zlMDak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698993175; x=1699597975;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VyO1Z+S61kc8i/PizQbBIUgo6r//ondY8h0vjsIi3rI=;
        b=g058b4h3hdaeJMtG5lsqQ7rm05n9i6o0NeNsJUw98jPVNR7qZN91GY/WVitwherY/d
         utt0bpagNTec70fxONAe+x0QqDUK9lqfd61WgI/6dY7KAM8buojoGO/BrJYLoTU4tDLX
         awZtPm315/EcnQvMBw2zODazCSN1D04HvNYxqnAyIXibBIxa5Gn077t5tjobvoGQBMKr
         /6QAvgOV8r4zl2eyJGbPUDyNanrTZ34+UY6SODONYJmRGJzmhqBE41U4e1OoLDsJYt+v
         K51O66zdxeBvu1HWvHfp9jGLV7MmolrEiKnhKEtSlk1PDwA1PqDSy3v4s5nXJk6F0Okt
         XBRA==
X-Gm-Message-State: AOJu0YzTanNny//xOIU4wWhLXeVNj7t6/atRNOmP/zeDFUV2EeUtL0zV
        MZTUCnH8ObtN+vRx/j7qLorpIJayc2kkL+LbqH5yjpHb
X-Google-Smtp-Source: AGHT+IEXN4SpbKa9Q9SShUXxftKrufOPAYrxUbijp3EoCQbVEl5xL5RIgkG6i2Ny4Pvb7wqeKyBPzg==
X-Received: by 2002:aa7:c75a:0:b0:533:5d3d:7efe with SMTP id c26-20020aa7c75a000000b005335d3d7efemr1544974eds.6.1698993174988;
        Thu, 02 Nov 2023 23:32:54 -0700 (PDT)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id v23-20020a50d597000000b0053dd8898f75sm600888edi.81.2023.11.02.23.32.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Nov 2023 23:32:54 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-9c3aec5f326so558443866b.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 23:32:54 -0700 (PDT)
X-Received: by 2002:a17:906:4fca:b0:9bd:a66a:a22 with SMTP id
 i10-20020a1709064fca00b009bda66a0a22mr2119584ejw.15.1698993173801; Thu, 02
 Nov 2023 23:32:53 -0700 (PDT)
MIME-Version: 1.0
References: <YpC1/rWeVgMoA5X1@gondor.apana.org.au> <Yui+kNeY+Qg4fKVl@gondor.apana.org.au>
 <Yzv0wXi4Uu2WND37@gondor.apana.org.au> <Y5mGGrBJaDL6mnQJ@gondor.apana.org.au>
 <Y/MDmL02XYfSz8XX@gondor.apana.org.au> <ZEYLC6QsKnqlEQzW@gondor.apana.org.au>
 <ZJ0RSuWLwzikFr9r@gondor.apana.org.au> <ZOxnTFhchkTvKpZV@gondor.apana.org.au>
 <ZUNIBcBJ0VeZRmT9@gondor.apana.org.au> <CAHk-=wj0-QNH5gMeYs3b+LU-isJyE4Eu9p8vVH9fb-vHHmUw0g@mail.gmail.com>
 <ZUSKk6Tb7+0n9X5s@gondor.apana.org.au>
In-Reply-To: <ZUSKk6Tb7+0n9X5s@gondor.apana.org.au>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 2 Nov 2023 20:32:36 -1000
X-Gmail-Original-Message-ID: <CAHk-=wh=xH7TNHeaYdsrVW6p1fCQEV5PZMpaFNsZyXYqzn8Stg@mail.gmail.com>
Message-ID: <CAHk-=wh=xH7TNHeaYdsrVW6p1fCQEV5PZMpaFNsZyXYqzn8Stg@mail.gmail.com>
Subject: Re: [GIT PULL] Crypto Update for 6.7
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Steffen Klassert <steffen.klassert@secunet.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Nov 2023 at 19:52, Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> Fair enough.  How about adding an EXPERT dependency on this?

I think that would help the situation, but I assume the sizing for the
jitter buffer is at least partly due to trying to account for cache
sizing or similar issues?

Which really means that I assume any static compile-time answer to
that question is always wrong - whether you are an expert or not.
Unless you are just building the thing for one particular machine.

So I do think the problem is deeper than "this is a question only for
experts". I definitely don't think you should ask a regular user (or
even a distro kernel package manager). I suspect it's likely that the
question is just wrong in general - because any particular one buffer
size for any number of machines simply cannot be the right answer.

I realize that the commit says "*allow* for configuration of memory
size", but I really question the whole approach.

But yes - hiding these questions from any reasonable normal user is at
least a good first step.

              Linus
