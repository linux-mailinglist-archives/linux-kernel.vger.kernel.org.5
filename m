Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF4E784872
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 19:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjHVRfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 13:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjHVRfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 13:35:54 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0B8B241DC
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 10:35:51 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b9d07a8d84so74910451fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 10:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1692725750; x=1693330550;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=twBuWXcpeKseh33O2uRZCxjPfvxhPgWOIfaDx6iIFFg=;
        b=JMBwuFf+eTpkQ//DsPnmN3MjwuC+S7NPLfzgQxu6E7e/Kj8n0G2FO+sEw1AwqyhQua
         UDf3xM7uIV9jK4eU1CXZq/84y5w5MValxIh8kRp7R1VqExWWW/Llr3kyyrGGOyN6fb8+
         x6jh9zLCbnYBgvXrYAQNKUKsYn7uGO/YVLLzs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692725750; x=1693330550;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=twBuWXcpeKseh33O2uRZCxjPfvxhPgWOIfaDx6iIFFg=;
        b=XLxqvS5hsOqzBcgOYQhn5TjvMoBYZk4c61Da+JKZQUrvYjcqKmM+Et3ctlQ+D/m7NW
         TL1FfgcxwLEKbYWnOlJwR9TkazL5LwRwKvJ/JDpS57uh8PEykG6O/38q2nGXCF0YsR3f
         2Lk59mzUznJV4AjZDfQOoHNsJnjToPXZ4xes5SyyPIR3h2H2tkM2K8POKKn8zPQESO6q
         xpyixiKfa8xpn3qDTNH1vo0uY7TFpHcvSDVZpbrFJoaszc9cJPeAHyK2HVxjjeFvIM4X
         WRUvIonu+AJd0eQ150lUbaZPjxorJL3QVwYesjZ/Q+risL7Fg1MYqydyHcSP7DyEkDKi
         hyiQ==
X-Gm-Message-State: AOJu0YxZwPO/bFo9nwrSjW0PzJZdlXNo9p3UfAOSvrWGtcoQIaK5UOVl
        mAJvxRUvSQISIocNH2jAYtCdDH8GTjBzItBIjtQ=
X-Google-Smtp-Source: AGHT+IFvXWUExYuvw7mlEE2ICe2mtCEabGvWe6MqsrYRIEke4T8TzLyxsGrKr9zlN45+C3ZLmm4p/g==
X-Received: by 2002:a2e:3801:0:b0:2bc:b29e:8fef with SMTP id f1-20020a2e3801000000b002bcb29e8fefmr6815139lja.34.1692725749866;
        Tue, 22 Aug 2023 10:35:49 -0700 (PDT)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id r25-20020a170906a21900b00992f309cfe8sm8520162ejy.178.2023.08.22.10.35.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Aug 2023 10:35:48 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-99bf8e5ab39so645748266b.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 10:35:48 -0700 (PDT)
X-Received: by 2002:a17:906:ef8c:b0:99b:bf8d:b7e1 with SMTP id
 ze12-20020a170906ef8c00b0099bbf8db7e1mr8141530ejb.17.1692725748394; Tue, 22
 Aug 2023 10:35:48 -0700 (PDT)
MIME-Version: 1.0
References: <01e3e09005e9434b8f558a893a47c053@AcuMS.aculab.com>
 <202308141416.89AC5C2@keescook> <2dd09c4033644239a314247e635fa735@AcuMS.aculab.com>
 <202308211113.4F49E73109@keescook>
In-Reply-To: <202308211113.4F49E73109@keescook>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 22 Aug 2023 10:35:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=whwEAc22wm8h9FESPB5X+P4bLDgv0erBQMa1buTNQW7tA@mail.gmail.com>
Message-ID: <CAHk-=whwEAc22wm8h9FESPB5X+P4bLDgv0erBQMa1buTNQW7tA@mail.gmail.com>
Subject: Re: [PATCH next v3 0/5] minmax: Relax type checks in min() and max().
To:     Kees Cook <keescook@chromium.org>
Cc:     David Laight <David.Laight@aculab.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Aug 2023 at 11:24, Kees Cook <keescook@chromium.org> wrote:
>
> It seems like the foot-gun problems are when a value gets clamped by the
> imposed type. Can't we just warn about those cases?

I think that the problem with min_t() is that it is used as a random
"when min() warns about different types", and that it basically just
adds a cast without any semantic meaning.

End result: we currently have 4500+ of those cases (and another 1300
uses of 'max_t') and I bet that several of them are the narrowing
kind. And some are probably valid.

And if we tighten up "min_t()" type rules, we'll just hit the *next*
problem in the series, namely "what are people going to do now?"

We don't want to just keep pushing the problem down.

So I actually mostly liked all the *other* patches in David's series:
using 'min_unsigned()' and friends adds a nice *semantic* layer, not
just a cast. And relaxing the checking of min/max doesn't cause the
same the "push problems down" issue, as long as the relaxing is
reasonable.

(Side note: I'm not convinced 'min_unsigned()' is the right syntax.
While I like the concept, I think 'min()' is often used as a part of
other expressions, and 'min_unsigned()' ends up making for a very
illegible long and complex thing. I think we might as well use
'umin()/umax()', matching our type system).

It's just that I very much don't think it's reasonable to relax "20u"
(or - more commonly - sizeof) to be any random constant signed
integer, and it should *not* compare well with signed integers and not
silently become a signed compare.

(But I do think that it's very ok to go the other way: compare a
_unsigned_ value with a "signed" constant integer like 20. The two
cases are not symmetrical: '20' can be a perfectly fine unsigned
value, but '20u' cannot be treated signed).

And while I don't like David's patch to silently turn unsigned
constant signed, I do acknowledge that very often the *source* of the
unsignedness is a 'sizeof()' expression, and then you have an integer
that gets compared to a size, and you end up using 'min_t()'. But I do
*NOT* want to fix those cases by ignoring the signedness.

Just a quick grep of

    git grep 'min_t(size_t' | wc

shows that quite a lot of the 'min_t()' cases are this exact issue.
But I absolutely do *not* think the solution is to relax 'min()'.

I suspect the fix to those cases is to much more eagerly use
'clamp()'. Almost every single time you do a "compare to a size", it
really is "make sure the integer is within the size range". So while

    int val
   ...
    x = min(val,sizeof(xyz));

is horrendously wrong and *should* warn, I think doing

   x = clamp(val, 0, sizeof(xyz));

is a *much* nicer model, and should not warn even if "val" and the
upper bound do not agree. In the above kind of situation, suddenly it
*is* ok to treat the 'sizeof()' as a signed integer, but only because
we have that explicit lower bound too.

In other words: we should not "try to fix the types". That was what
caused the problem in the first place, with "min_t()" just trying to
fix the type mismatch with a cast. Casts are wrong, and we should have
known that. The end result is horrendous, and I do agree with David on
that too.

I think we should strive to fix it with "semantic" fixes instead. Like
the above "use clamp() instead of min(), and the fundamental
signedness problem simply goes away because it has enough semantic
meaning to be well-defined".

Hmm?

                  Linus
