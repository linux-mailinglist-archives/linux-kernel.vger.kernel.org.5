Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C91837A272C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 21:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236970AbjIOT2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 15:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236689AbjIOT1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 15:27:31 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86C42E50
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 12:27:23 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-d8020510203so2423559276.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 12:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694806042; x=1695410842; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bXqcKedK6SgxHo3k9k/0xOhW1xAtRqrtmsu0jYsdZ4M=;
        b=Ji0K2IEFiNUS3xq5EYECTith8AycASrWMJySPpy/OGbv54djscHlwPFASklXhNy0dW
         5FZ8P7rjQOiEn9ks4NNyU30cSnAYgCbs2vKMXQruuvyWK0HqTCPBH1bt6kw66SxvY2vn
         7fRmukTCVGYvMf8pwK5B4hbj3QzFW5NMrfRD/tUhUabUcO7s/QIx6MQVL5l6oRrlUMB7
         diSN6VUZLXy7gXSkwNoDGtjOyYjEpW2EI9h2hNGDmSzO/J/SCqYGox4gxZGOE/VTsYhQ
         nso17RMOy73SlQ4MoMlpw+dFbAL+QJT2m7gQTTFgV73+2QH18zOYwqodPXjqqa2xzVTj
         /AMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694806042; x=1695410842;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bXqcKedK6SgxHo3k9k/0xOhW1xAtRqrtmsu0jYsdZ4M=;
        b=T351f9Mn7Wasoh0ThD80XubFnlQCxPvyWtX5mv9GGStg+Vktpq1E8av7z2YBfZDOz7
         IgOAtLgcamJMyiLVlTXMxFJpUIEA6HEtoIQMh+OjPQlOgzeLx9Ev9AgdPi1VCfjjpcKe
         pRUG47x9w7DtoEfczl9JxlNX6BsuYOVOVMz91eyaEFXMFkMmQhzMojbp7o0Xo+d1RjDR
         UCpnBKAmjt0//Omd2ZLegvJatKpCpFC/2bvkS5DSkgcuYvmNTHcm8lAt5qlXxejMxQU1
         iCQ4JJfAbnH7FrvDcfosJrUbEYE5tkOYSK+eboABlID56sz7d8hQ/jPWoXef6yABt5pm
         D3tA==
X-Gm-Message-State: AOJu0YzhBddQt+asqZJ+jNsWDScXQnarByFiFazgaVak1TVkNXYpN58h
        YyAjpqj7jhXKznVpS8+GqWfgtrPLp8gyhBHvq3IH0XPRqjXFHYHe
X-Google-Smtp-Source: AGHT+IEV6y9iKGysN8t5Vy+MnRnN9mOy6ZuuhCgi5jIhT9GHzPRDatFDaTyuo+Uk0fgkBsb6xUTXU4qXMirltpXkF8U=
X-Received: by 2002:a25:800a:0:b0:d81:6a21:42cb with SMTP id
 m10-20020a25800a000000b00d816a2142cbmr2452207ybk.40.1694806042685; Fri, 15
 Sep 2023 12:27:22 -0700 (PDT)
MIME-Version: 1.0
References: <07c32bf1-6c1a-49d9-b97d-f0ae4a2b42ab@p183> <CAHk-=whO1+-4ALjFWSE0kzytz1kEbWPvy3xWvcUP1dJ4t-QqkA@mail.gmail.com>
 <CACMJSetxQi+t3SBXu6OvBbmxV8AbX2CfdSA9JvF1chLJSU9Ppw@mail.gmail.com> <CAHk-=wgRHiV5VSxtfXA4S6aLUmcQYEuB67u3BJPJPtuESs1JyA@mail.gmail.com>
In-Reply-To: <CAHk-=wgRHiV5VSxtfXA4S6aLUmcQYEuB67u3BJPJPtuESs1JyA@mail.gmail.com>
From:   Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date:   Fri, 15 Sep 2023 21:27:11 +0200
Message-ID: <CACMJSevZQgik7S-62fz9H7+Mib+W0CgYMV4GyWjYV7N_E6iHVQ@mail.gmail.com>
Subject: Re: Buggy __free(kfree) usage pattern already in tree
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
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

On Fri, 15 Sept 2023 at 21:06, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, 15 Sept 2023 at 10:22, Bartosz Golaszewski
> <bartosz.golaszewski@linaro.org> wrote:
> >
> > IMO this feature has much more potential at fixing existing memory
> > leaks than introducing new ones. I agree, I should have been more
> > careful, but I wouldn't exaggerate the issue. It's a bug, I sent a
> > fix, it'll be fine in a few days. I hope it won't be seen as an
> > argument against __free(). It just needs some time to mature.
>
> Honestly, I think your "fix" is still wrong.
>
> It may *work*, but it's against the whole spirit of having an
> allocation paired with the "this is how you free it".
>
> Your model of is fundamentally fragile, and honestly, it's disgusting.
>
> The fact that you literally have
>
>         char ***line_names
>
> as an argument should have made you wonder. Yes, we have triple
> indirect pointers in some other parts of the tree, but it sure isn't a
> "feature".
>
> The thing is, your cleanup function should mirror your allocation
> function. It didn't, and it caused a bug.
>
> And it STILL DOES NOT, even with your change.
>
> So I claim you are completely mis-using the whole __free thing. What
> you are doing is simply WRONG.
>
> And unless you can do it right, I will revert that change of yours to
> mis-use the cleanup functions, because I do not want anybody else to
> look at your code and get all the wrong ideas.
>
> Seriously.
>
> So look at your code, and DO IT RIGHT. Don't try to claim that
> "kfree()" is the cleanup function for gpio_sim_make_line_names().
> Because it really isn't. One free's a random pointer. Another returns
> a complex data structure *and* a count. They aren't inverses.
>
> I don't care ONE WHIT if you have learnt to use these kinds of things
> from GLib/GObject, and if that kind of disgusting behavior is ok
> there.
>
> It's not going to fly in the kernel.
>
> So your pattern needs to be something like this:
>
>         struct X *p __free(freeXYZ) = allocXYZ();
>
> and ABSOLUTELY NOTHING ELSE.  So if you use __free(kfree), it looks like
>
>         struct obj *p __free(kfree) = kmalloc(...);
>
> and not some different variation of it.
>
> And if you want to do something more complex, we literally have that
> "CLASS()" abstraction to make the above pattern particularly easy to
> use. Use it.
>
> But don't abuse the very special 'kmalloc/kfree' class that we have as
> an example. That's for kmalloc/kfree pairs, not for your "char
> ***line_names" thing.
>
> Now, Just to give you a very concrete example, here are two TOTALLY
> UNTESTED patches.
>
> I wrote two, because there's two ways to fix this properly as per
> above, and use those functions properly.
>
> The *SANE* way is to just re-organize the code to count things
> separately, and then you can allocate it properly with a sane
>
>     char **line_names __free(kfree) = kcalloc(lines,
> sizeof(*line_names), GFP_KERNEL);
>
> and not have that crazy "count and fill and return both the count and
> the lines" model at all. The above pairs the constructor and
> destructor correctly and clearly.
>
> So that's the first "maybe-sane.diff" version. It may be untested,
> it's probably still buggy due to that, but it is what I *think* you
> should model the real fix around.
>
> The second patch is WAY overkill, and actually creates a "class" for
> this all, and keeps the old broken "count and fill in one go", and
> returns that *one* value that is just the class, and has a destructor
> for that class etc etc.
>
> It's completely broken and ridiculously over-complicated for something
> like this, but it's trying to document that way of doing things. For
> other things that aren't just one-offs, that whole CLASS() model may
> be the right one.
>
> Either of these patches *might* work, but honestly, both of them are
> likely broken. The second one in particular is almost certainly buggy
> just because it's such a crazy overkill solution, but partly *because*
> of how crazy overkill it is, I think it might be a useful example of
> what *can* be done.
>
> Again: UNTESTED. They both build for me, but that doesn't say much.
>
>                 Linus

Understood. I'll go with a modified version of maybe-sane. I'll send a
v2 tomorrow and make sure to Cc you.

WRT the silly diff: we have a bunch of helpers centered around string
arrays in the kernel. I think it would make sense to package a string
array into a class because right now we have functions like
kfree_strarray() which takes the pointer to the array AND the number
of strings to free. So it may not be that silly in the end. But that's
a different story.

Bartosz
