Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 179327765FB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 19:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232560AbjHIRCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 13:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232437AbjHIRCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 13:02:14 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEDE9210D
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 10:02:10 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4fe28e4671dso11454788e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 10:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1691600529; x=1692205329;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bjIM/ijvSM8/MDaGJoo16Y0WNhCaEmIRqKMsiPBM2wM=;
        b=T9ZQUjKWWfmPZqDf3wQWwhBnsSq5HwjyhNx06C/Qs/b28tTqhURb6KY/+OUCVNp/Kr
         KzUuXVC7p/fUclfJcpjpvo81oHhy4+HJjBrSTAMzEvoAgIUvccLqdLKmzC63krToqn39
         4SakwAuGj/80v9DUUFGzdqpfH8AcWRQD/7m/Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691600529; x=1692205329;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bjIM/ijvSM8/MDaGJoo16Y0WNhCaEmIRqKMsiPBM2wM=;
        b=CPZytMs8aKpTYTlR+bXpXseUUmTdSq398itfO1rZuo8lP/ZDvlZj6pzrhGwVcRPuFp
         m3gvJZOrefo2RZnHyvkUzbBjy9prMdG6FZ6sSyUpb8Fz3tv1uxW6B5OffulUnk2prT9R
         XaZyoJMf5xRFMfEDhY8D4+DYHwtkGIa35GSHPoKdVOeCCzqVACvhohbqLd+LPujB1ZuZ
         dYi6eMLr3FPxl3g1IYi+CLSYRwi3VJ5srlu6wCKn+/qrEuuqWcspBPe8QuW4XrpmI4Ki
         Rw7lmdaxo/5jY2kgyDnxBA7lH6BuBgtu4dblya1vWMKOJGsMFXLFNGvpuyBnbMy7nvG+
         jXnQ==
X-Gm-Message-State: AOJu0Ywdl3I8rFAEqu2YMuw0UQu3um7wiqKyp2SOq+aSL2gyRb9Vjdbq
        kUmnV9ZQFuOGnHdKM5lcbSF3DLhj7CBprdv9JPpRWniF
X-Google-Smtp-Source: AGHT+IHwW9c7bsAYiWoZftgXgtDNjAWOk0Cb4yJ5OUMW5dFusNom8UULJ2nH6DJ1TINyoVkHk3BzrA==
X-Received: by 2002:a05:6512:3ec:b0:4fb:77d6:89c3 with SMTP id n12-20020a05651203ec00b004fb77d689c3mr2352023lfq.12.1691600528743;
        Wed, 09 Aug 2023 10:02:08 -0700 (PDT)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id w1-20020a17090652c100b009927a49ba94sm8188120ejn.169.2023.08.09.10.02.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Aug 2023 10:02:08 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-99c136ee106so11754166b.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 10:02:08 -0700 (PDT)
X-Received: by 2002:a17:906:7486:b0:99b:4bab:2844 with SMTP id
 e6-20020a170906748600b0099b4bab2844mr2356279ejl.55.1691600527705; Wed, 09 Aug
 2023 10:02:07 -0700 (PDT)
MIME-Version: 1.0
References: <87edkce118.wl-tiwai@suse.de> <20230809143801.GA693@lst.de>
 <CAHk-=wiyWOaPtOJ1PTdERswXV9m7W_UkPV-HE0kbpr48mbnrEA@mail.gmail.com> <87wmy4ciap.wl-tiwai@suse.de>
In-Reply-To: <87wmy4ciap.wl-tiwai@suse.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 9 Aug 2023 10:01:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh-mUL6mp4chAc6E_UjwpPLyCPRCJK+iB4ZMD2BqjwGHA@mail.gmail.com>
Message-ID: <CAHk-=wh-mUL6mp4chAc6E_UjwpPLyCPRCJK+iB4ZMD2BqjwGHA@mail.gmail.com>
Subject: Re: [PATCH RFC] Introduce uniptr_t as a generic "universal" pointer
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, netdev@vger.kernel.org
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

On Wed, 9 Aug 2023 at 09:05, Takashi Iwai <tiwai@suse.de> wrote:
>
> OTOH, it simplifies the code well for us; as of now, we have two
> callbacks for copying PCM memory from/to the device, distinct for
> kernel and user pointers.  It's basically either copy_from_user() or
> memcpy() of the given size depending on the caller.  The sockptr_t or
> its variant would allow us to unify those to a single callback.

I didn't see the follow-up patches that use this, but...

> (And yeah, iov_iter is there, but it's definitely overkill for the
> purpose.)

You can actually use a "simplified form" of iov_iter, and it's not all that bad.

If the actual copying operation is just a memcpy, you're all set: just
do copy_to/from_iter(), and it's a really nice interface, and you
don't have to carry "ptr+size" things around.

And we now have a simple way to generate simple iov_iter's, so
*creating* the iter is trivial too:

        struct iov_iter iter;
        int ret = import_ubuf(ITER_SRC/DEST, uptr, len, &iter);

        if (unlikely(ret < 0))
                return ret;

and you're all done. You can now pass '&iter' around, and it has a
nice user pointer and a range in it, and copying that thing is easy.

Perhaps somewhat strangely (*) we don't have the same for a simple
kernel buffer, but adding that wouldn't be hard. You either end up
using a 'kvec', or we could even add something like ITER_KBUF if it
really matters.

Right now the kernel buffer init is a *bit* more involved than the
above ubuf case:

        struct iov_iter iter;
        struct kvec kvec = { kptr, len};

        iov_iter_kvec(&iter, ITER_SRC/DEST, &kvec, 1, len);

and that's maybe a *bit* annoying, but we could maybe simplify this
with some helper macros even without ITER_KBUF.

So yes, iov_iter does have some abstraction overhead, but it really
isn't that bad. And it *does* allow you to do a lot of things, and can
actually simplify the users quite a bit, exactly because it allows you
to just pass that single iter pointer around, and you automatically
have not just the user/kernel distinction, you have the buffer size,
and you have a lot of helper functions to use it.

I really think that if you want a user-or-kernel buffer interface, you
should use these things.

Please? At least look into it.

                 Linus

(*) Well, not so strange - we've just never needed it.
