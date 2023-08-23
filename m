Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E780785C29
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 17:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237262AbjHWPcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 11:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbjHWPc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 11:32:29 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98487CF1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 08:32:25 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2bcc14ea414so47853811fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 08:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1692804743; x=1693409543;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dbDsquZPuBFtgrT86smQfcDi6beUvJZp2JAhYl0eI20=;
        b=ZhTF/IUX1HRlLZ6ROpzc40l24PsdBtVAtuFXMYEMBBixw4HhJYAnFAVtR4BqKxUHx2
         JcYh2D+i6JczqLz8nFNynjI7icAbJ27sBh2PyQvgg01AoVe8hfAzGn67VKZB00WAQdd1
         7NnfzglEFgnpbfAEU/I/CZ9/hzbFdU2w3EDmM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692804743; x=1693409543;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dbDsquZPuBFtgrT86smQfcDi6beUvJZp2JAhYl0eI20=;
        b=YJ/cMsSlxHiUGIQ5w4tQ67aL2v6PCvKw7esWQDDk2lqytuVlyaco4iJ+o0AwRyRGsN
         mQB148vTmeaTF26VCTsEXQc77lSS5JDdnMy+pP1mnJFeDp23IavcW13UjXApuLRGKBL+
         ufUsxfwrSLbn5mh/Tf0V4m5Qur61qG6aG6ysntljO3bZ5BNbfwDs+WwFaC0gOl//IGLK
         DW3RX3h/S2V93q7Hk0GH12d/RrkrwZW6Zv750VNMbFkA52h5zVCG37vEyWs2NGf6T80e
         Fr7L3Y7PYjCQKwFYX1/THtdZm0Qw9Ah+zy0JNGQTApUxvUyW/pRrXSY7KqbCD5MMZmZB
         8Bvw==
X-Gm-Message-State: AOJu0YzEZYBGmnvWgZlSjvHVFEzY/mXX77nb2y/PREl1yVKurMEAXzmA
        c99RQxZ6oZMQE6DTRD42wWdA/Vzrvn17y15pHE+Acg==
X-Google-Smtp-Source: AGHT+IHyFzBUzSM1J8aW6ZAIovXzRZGaFKgB9yZEoI3+qqjyry4VhVSmxdA4rd25bKOQNiq+x+O2+g==
X-Received: by 2002:a2e:9211:0:b0:2b6:cf6f:159e with SMTP id k17-20020a2e9211000000b002b6cf6f159emr9713059ljg.44.1692804743563;
        Wed, 23 Aug 2023 08:32:23 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id o7-20020a2e9447000000b002bcc4a0f0b0sm1166543ljh.100.2023.08.23.08.32.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Aug 2023 08:32:23 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5008d16cc36so3186908e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 08:32:22 -0700 (PDT)
X-Received: by 2002:a05:6512:250e:b0:4f9:54f0:b6db with SMTP id
 be14-20020a056512250e00b004f954f0b6dbmr10392448lfb.13.1692804742490; Wed, 23
 Aug 2023 08:32:22 -0700 (PDT)
MIME-Version: 1.0
References: <01e3e09005e9434b8f558a893a47c053@AcuMS.aculab.com>
 <202308141416.89AC5C2@keescook> <2dd09c4033644239a314247e635fa735@AcuMS.aculab.com>
 <202308211113.4F49E73109@keescook> <acf8a7389d1f47a5ac55390b7ea76692@AcuMS.aculab.com>
In-Reply-To: <acf8a7389d1f47a5ac55390b7ea76692@AcuMS.aculab.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 23 Aug 2023 08:32:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh1SFzTM1nWwC30t55jzZradQmJ4942CDD1pM_umhU_Vw@mail.gmail.com>
Message-ID: <CAHk-=wh1SFzTM1nWwC30t55jzZradQmJ4942CDD1pM_umhU_Vw@mail.gmail.com>
Subject: Re: [PATCH next v3 0/5] minmax: Relax type checks in min() and max().
To:     David Laight <David.Laight@aculab.com>
Cc:     Kees Cook <keescook@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Aug 2023 at 01:52, David Laight <David.Laight@aculab.com> wrote:
>
> Linus doesn't like me silently converting unsigned constants
> to signed.

Note that my dislike is more about changing the sign of the
*comparison*, and not warning about it.

It's not the constant conversion itself that ends up being the
problem, but the downstream issues it causes.

Having grepped for those annoying "min_t(size_t..)" uses, lots of them
seem to have perfectly fine signedness, and the 'size_t' is literally
just due to different sizes of unsigned values. In fact, several of
them seem to be due to the unfortunate fact that 'size_t' can be
'unsigned int' on 32-bit architectures, so mixing 'size_t' and
'unsigned long' will sadly warn without it.

So we literally have the issue that 'min(a,b)' will warn even if 'a'
and 'b' have the same signedness *and* the same size, because 'size_t'
and 'unsigned long' are different types.

Your patch 2/5 will fix that. And then I'd certainly be ok with a
"comparing an unsigned value to a signed positive constant" thing
(just not the other way around: "comparing a signed value to an
unsigned positive constant" is wrong)

That might get rid of a number of the more annoying cases.

            Linus
