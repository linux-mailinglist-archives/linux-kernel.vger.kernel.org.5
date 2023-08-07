Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD9CA7729C2
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 17:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbjHGPtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 11:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231322AbjHGPtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 11:49:05 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92BE7E79
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 08:49:04 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4fe0fe622c3so7358958e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 08:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1691423342; x=1692028142;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=H1Z3BitHI6TO18I1jxhVlTK7Vo3w2R8qfHzMjRnoHZg=;
        b=Fgdrye/MXnaX9g9CebJwB7n5jJch4+pQJ/oL4lsbr0/AV7jyPEsc9YR/1jd5K/l8jz
         kiO1w3amFwXaV2k5MzvvgwkK5Z25aXnhxNzVy6VwxNBX2SD2kzr5/83jdQm+5Nrn5XIC
         GWixJFNJbotVl5MCWl+WmMmO8yfawbAx+FTGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691423342; x=1692028142;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H1Z3BitHI6TO18I1jxhVlTK7Vo3w2R8qfHzMjRnoHZg=;
        b=XLcsKHxA7M6RS+46wRwkN1EFUaIU+lOfQ/wmQg3+nbi0Hg1WBe2qmcg8f2iltuyxbP
         tL/U+JSRzT2kqvfsaAVzc1EROjHSHwZ1c9iMiKMK+ivxUxrcpqFfJyUPdyL8UdjFodbF
         OK7C0GDNECBBCuAh5NVpPgeFyg1vd45bC/B/B+ngz+dIw98LtblqFwobgNTEohdLaTbg
         r5MrkCQnqduCUXzWmCBBtOj75Xdwclr1eDzMwaPM8IuA1ozu3GyWuinyTXE2pssEU2WP
         OJk0On5DwVwxE+t+dNB2/f0GKIKXJVNqd9HjchwzAIuQn2/y2wD/7dZXDZEjJF3S7+WQ
         sTAQ==
X-Gm-Message-State: AOJu0YxU2FS/YZ00CpnpyMJJN1BXJyiId2AGK2DdLW7/Itbi/Cfoju1D
        wbWpcSDik/L3Szsaisk3VS3GWntoSwzuvfiUhri/gTos
X-Google-Smtp-Source: AGHT+IEpW+6b4lpWdhQRCxg+Bw/vqmWQGACRH/6NM7fuzaQh3R1uvPS68kp7e7MLasuy+I7hGfIIsg==
X-Received: by 2002:a05:6512:3139:b0:4fd:cb46:57dd with SMTP id p25-20020a056512313900b004fdcb4657ddmr5684602lfd.30.1691423342213;
        Mon, 07 Aug 2023 08:49:02 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id n16-20020a17090625d000b00988c0c175c6sm5362732ejb.189.2023.08.07.08.49.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Aug 2023 08:49:01 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-52327d63d7cso3168447a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 08:49:01 -0700 (PDT)
X-Received: by 2002:aa7:d9d6:0:b0:523:22f6:e8a5 with SMTP id
 v22-20020aa7d9d6000000b0052322f6e8a5mr6906080eds.39.1691423341197; Mon, 07
 Aug 2023 08:49:01 -0700 (PDT)
MIME-Version: 1.0
References: <01e3e09005e9434b8f558a893a47c053@AcuMS.aculab.com>
 <b6a49ed73aba427ca8bb433763fa94e9@AcuMS.aculab.com> <CAHk-=whr-iSsxEZ4fYfkQzs7XQN=aQhbZQKGEMnZiGdrDgLKPQ@mail.gmail.com>
 <82fc9f39e3914a74abc7f968b1abba68@AcuMS.aculab.com>
In-Reply-To: <82fc9f39e3914a74abc7f968b1abba68@AcuMS.aculab.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 7 Aug 2023 08:48:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=whOOMM8k+6vB5k3LA=c3OwvHo+1iS6_SOwssV5_MUdoCg@mail.gmail.com>
Message-ID: <CAHk-=whOOMM8k+6vB5k3LA=c3OwvHo+1iS6_SOwssV5_MUdoCg@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] minmax: Relax check to allow comparison between
 int and small unsigned constants.
To:     David Laight <David.Laight@aculab.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Aug 2023 at 03:50, David Laight <David.Laight@aculab.com> wrote:
>
> To my mind the value of min(variable, TWENTY) shouldn't depend
> on how TWENTY is defined regardless of the type of the variable.
> So 20, 20u, 20l, 20ul, (char)20, sizeof (foo), offsetof(x, y)
> should all be equally valid and all generate the same result.

That sounds nice, but I don't believe it is true.

If somebody writes

      a = min(b, 20u);

then that is *not* the same thing as

      a = min(b, 20);

without knowing the types.

But you make them be the same thing - now they become ambiguous and
depend on the type of 'b'.

Does that expression mean "give me a number 0..20" or "MININT..20"?

And the whole point of the type checking is very much to not have
ambiguous comparisons where you can have those kinds of questions.

> I've found all sorts of dubious min_t() while writing these patches.
> One in a filesystem was min_t(ulong, ulong_var, u64_var) and I
> couldn't convince myself it was right on 32bit.

Honestly, that's a great example, but I think that's more of an
argument against 'min_t()' than it is an argument for changing 'min()'
and 'max()'.

I think it was a mistake to do "min_t()", and we should have done
sign-based ones ("do a unsigned/signed min/max").

I agree that a "min_t()" that narrows the type is very scary, in that
it might lose bits, and it's obviously also easily dependent on word
size too, as in your example.

We could perhaps aim to make 'min_t()' warn about 't' being narrower
than the types you compare.

(Although then you hit the traditional "C doesn't really have 'char'
and 'short' types in expressions", so you'd probably have to do the
type size check with widening of 't' in place, so 'min_t(char, int,
int)' would be ok).

           Linus

                 Linus
