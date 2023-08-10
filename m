Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8807781C7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 21:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236539AbjHJTrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 15:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236525AbjHJTrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 15:47:20 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 380E52727
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 12:47:18 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4fe27849e6aso2000028e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 12:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1691696836; x=1692301636;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=286Ns2OqK+imcF52KDnHgJMMRD16lSO1+0Fx6CfLtn8=;
        b=I12TKpRyje2tAX4AwIn/17eTjUy47LG3Xqfh1mM5cHhnW2djnddTUGQYAEHVzvBrGp
         CeIkvu+8qaHxCvtnD+iu8PAR2C3MWu0qeZlIvDCsfybr5WpWof8eM00hzmkIfoQfEgo4
         GF3UiL3Y91wqZgmx2V/7ok28u+v1ggojzIrqQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691696836; x=1692301636;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=286Ns2OqK+imcF52KDnHgJMMRD16lSO1+0Fx6CfLtn8=;
        b=c3sNxBM0ar+j0yW55JdVcW0gwPEO31N6vdWvCrnZqx4olXAbVh3tVXePFNK3zDBu3F
         lvhdyspRIjvf4ZMQ1JPxZLDIS4nX+pvSzTTtTjr574XUi1OeE3MwreCL7GR6De3RXSZv
         V+HbCvhIE6P1VgUQlWweeZuBJfYTY15xPU/pnh9bL5y168ypmHvHQHJRvpckFbY5I6bO
         832defXikYGTcvnStgvIhTZ3TWRd0h6+dR6i2rIyCZoVWdZT+UWFHKvJk7lqe2FABpFy
         fximneloJ18Nc/o6uao4Q2hYkOGNwOGHDpYQw0enqaY8Eo7hIp++ChbYrX0AjOi69DH1
         XbOg==
X-Gm-Message-State: AOJu0YxGy8T+Pq61IAtt4MXn2EToBxN5sQ64/WdTKRzplvd3b133FTrv
        h48RyTwSdqDEH2iisgH3orGvToF8dgtVoYVWkNXJVsAQ
X-Google-Smtp-Source: AGHT+IGaTpl8pCQeTwYlSFu7Ca/nw9ETUwcLuE0OufAxhJSBa6BrS5ZHH9F9Hiv0lL5dbbob8a+5AA==
X-Received: by 2002:a05:6512:3714:b0:4f9:6b65:32cb with SMTP id z20-20020a056512371400b004f96b6532cbmr2274611lfr.57.1691696836245;
        Thu, 10 Aug 2023 12:47:16 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id p5-20020a05651238c500b004fe3c53bb69sm407049lft.307.2023.08.10.12.47.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Aug 2023 12:47:15 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-4fe27849e6aso1999997e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 12:47:15 -0700 (PDT)
X-Received: by 2002:a05:6512:33d0:b0:4fb:77d6:89c3 with SMTP id
 d16-20020a05651233d000b004fb77d689c3mr3314903lfg.12.1691696835430; Thu, 10
 Aug 2023 12:47:15 -0700 (PDT)
MIME-Version: 1.0
References: <01e3e09005e9434b8f558a893a47c053@AcuMS.aculab.com>
 <b6a49ed73aba427ca8bb433763fa94e9@AcuMS.aculab.com> <CAHk-=whr-iSsxEZ4fYfkQzs7XQN=aQhbZQKGEMnZiGdrDgLKPQ@mail.gmail.com>
 <82fc9f39e3914a74abc7f968b1abba68@AcuMS.aculab.com> <CAHk-=whOOMM8k+6vB5k3LA=c3OwvHo+1iS6_SOwssV5_MUdoCg@mail.gmail.com>
 <f88a67c60b3d4a8c98a4aaaa32fd2c33@AcuMS.aculab.com>
In-Reply-To: <f88a67c60b3d4a8c98a4aaaa32fd2c33@AcuMS.aculab.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 10 Aug 2023 12:46:58 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiU=euKEQOzgdQqTAekJgHMMTtqMwdAw=mGkcGoR9ChEw@mail.gmail.com>
Message-ID: <CAHk-=wiU=euKEQOzgdQqTAekJgHMMTtqMwdAw=mGkcGoR9ChEw@mail.gmail.com>
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

On Thu, 10 Aug 2023 at 01:29, David Laight <David.Laight@aculab.com> wrote:
>
> > Does that expression mean "give me a number 0..20" or "MININT..20"?
>
> Why does the lower bound of any type matter?

Because it might actually be the upper bound.

That MININT becomes be 20 if it's unsigned, and you do min() on it.

Bugs when mixing unsigned and signed comparisons is WHY WE HAVE THE
TYPE CHECK IN THE FIRST PLACE.

And no, constants don't necessarily make that any different.

I think we all agree that using a (signed) constant 20 makes perfect
sense when the other side is an unsigned entity. It may be "signed",
but when the value is positive, we don't care.

But using an *unsigned* constant 20 when the other side is signed
means that now somebody is confused. We should warn.

Your argum,ent that "a constant is a constant" is bogus garbage.

I'm not going to keep telling you this. I'm telling you now, and if
you don't get it, it's no longer my problem. I'm just telling you that
your patch won't be accepted, and no amount of whining will make it
so.

              Linus
