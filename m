Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EEDE7A279B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 22:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237129AbjIOUEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 16:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237096AbjIOUEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 16:04:07 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C16FA210A
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 13:04:02 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-d81b803b09aso1385273276.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 13:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694808242; x=1695413042; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Vvpdf+bQmSjjcViV7hWhTMDmVZmln8TozUHjeEqwR7o=;
        b=D0ANqcb2qfJZ/MzHqe0K7IFv17pg4i5cLXikJ3j1/LgJ4Hl8dWDLzF9ERZ3GQTb0gf
         QQOD2Jw4nVMxuX6R61/Ek29bjEeZxKEmYx3sVIKmj153k++vcc/NVL1x721WiBCulMYx
         lrHd3ZjG94ib4WmdHYwL4kIOxP9zj3fOry9M4dgL7Zp6mzv9q0gdjaH/K0s0IdybLApY
         l5oJpT7Ad4wppAGhHuppE72XlA0LFO7dbAOuowavFU+y4jNvtABoys/IBzeXCutLsxJm
         YiirCPH76Ir+GKMDl472QYzZ/Vgw0BXyZR+P6yMWQmqMxgUFvaBvNbTSm43ONaweuagF
         ufUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694808242; x=1695413042;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vvpdf+bQmSjjcViV7hWhTMDmVZmln8TozUHjeEqwR7o=;
        b=K7HL2veaNHgW/Vaqe4NS8a8XulNdQgZ9cbTPIiYQF5FZTxaZR8U95k0Nf21w6vnyJA
         buqDSKqf2BipUowVNrynDZnK3+9BEQZ5M0sfeaegPfv3/UoXuT5mTpyaaDTUEoRBtZQ4
         gOVZBMBITJm3EasrGk52EyDwyWG9GBUMeXak8pTRqyBBQHp6X2KIbS9m7qe43M1V22x6
         VNLaLu88Wr991tods2Vs4JYB54fq5gVd0M1+HKvExy2BYbkH+71jvOJyT5G7eiRATql5
         41woZYXzZ3WQUfTIapnV/LWEd9UaX2JYe6Bo1Wj5aR4lsI6ODtfyjeuYvk85u5iOma1N
         PU3g==
X-Gm-Message-State: AOJu0Yw6tvqg9fi2xMSlQAXtxFOOQNXqO99cCH/u0iZBjT/gZCWrEAmh
        Ahe9CqO2uFfXdSc6yDMi1REzRwY9k1fIu3ZGQGC3Tw==
X-Google-Smtp-Source: AGHT+IGQawKid7DIxszxVNG6QvDOxIULIid4PJ+/yV6qY1sUYavIwVG71V+BVf81ifOuw6WGtmHOAfO8orYdBlZ3Ews=
X-Received: by 2002:a25:2d22:0:b0:d7a:e348:1e47 with SMTP id
 t34-20020a252d22000000b00d7ae3481e47mr2666037ybt.36.1694808242030; Fri, 15
 Sep 2023 13:04:02 -0700 (PDT)
MIME-Version: 1.0
References: <07c32bf1-6c1a-49d9-b97d-f0ae4a2b42ab@p183> <CAHk-=whO1+-4ALjFWSE0kzytz1kEbWPvy3xWvcUP1dJ4t-QqkA@mail.gmail.com>
 <CACMJSetxQi+t3SBXu6OvBbmxV8AbX2CfdSA9JvF1chLJSU9Ppw@mail.gmail.com>
 <CAHk-=wgRHiV5VSxtfXA4S6aLUmcQYEuB67u3BJPJPtuESs1JyA@mail.gmail.com> <CACMJSevZQgik7S-62fz9H7+Mib+W0CgYMV4GyWjYV7N_E6iHVQ@mail.gmail.com>
In-Reply-To: <CACMJSevZQgik7S-62fz9H7+Mib+W0CgYMV4GyWjYV7N_E6iHVQ@mail.gmail.com>
From:   Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date:   Fri, 15 Sep 2023 22:03:51 +0200
Message-ID: <CACMJSevrJ5KSPAZVheXkNaYj8KQFD8ck55kU_E4vEj4vzR8wnQ@mail.gmail.com>
Subject: Re: Buggy __free(kfree) usage pattern already in tree
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        akpm@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Sept 2023 at 21:27, Bartosz Golaszewski
<bartosz.golaszewski@linaro.org> wrote:
>

[snip!]

>
> Understood. I'll go with a modified version of maybe-sane. I'll send a
> v2 tomorrow and make sure to Cc you.
>

[snip!]

One more question wrt the __free() coding style.

Is the following acceptable:

void foo(void)
{
    char *s __free(kfree) = NULL;

    do_stuff();
    s = kmalloc(42, GFP_KERNEL);
}

Or does it always have to be:

void foo(void)
{
    do_stuff();
    char *s __free(kfree) = kmalloc(42, GFP_KERNEL);
}

?

I guess it would be useful to get these rules into
Documentation/process/coding-style.rst at some point as we also have
an ongoing discussion about whether scoped guards should always
require curly braces[1] even for single statements.

Bartosz

[1] https://lore.kernel.org/lkml/CAMuHMdVYDSPGP48OXxi-s4GFegfzUu900ASBnRmMo=18UzmCrQ@mail.gmail.com/
