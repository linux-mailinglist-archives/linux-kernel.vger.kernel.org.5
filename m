Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ADDD7566C7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 16:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjGQOtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 10:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjGQOtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 10:49:09 -0400
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C601E45
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 07:49:08 -0700 (PDT)
Received: by mail-ed1-x549.google.com with SMTP id 4fb4d7f45d1cf-51e2295e74eso3096988a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 07:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689605346; x=1690210146;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y4JVBrFfRISuz38C6eY0UVY6Fr1oXZLiDCBYqS66fUc=;
        b=AFwtAUXxavdRcfXLXYjDr6Bt17+SrIPjz+6ScXk60mtDaQqym9R7hOYdKRSyg1C/eL
         8RqQu41wCmuPobt0EURwT3lf8WeRo+4T/6KlMl6uicp8STNfAqIw+jlG/bVjt/dElIaq
         5LYptw3ZflWJoBKeaXw/OEhCIuedWjfikP1iuThYZ9X+cYYJWmmQEBUR3hEroy7TpK62
         5ZZiJymHTJlsQfBeA38wCTu5BI1DaBTAxqbt2CD5jdNbsWHtQQ70hc/mQJvcvPsKmMiy
         14fcRNSshM8RVD5zJb1/hL2SF1iu5agIePDfmWwxe9Ct7PqRfJH/AKklhp9F+uriNJr+
         2/RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689605346; x=1690210146;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y4JVBrFfRISuz38C6eY0UVY6Fr1oXZLiDCBYqS66fUc=;
        b=U9oJxfGnGuwGVa2FyXjY3Uepd/CLbrktlx1dIsHNDuJ5ffCNawuya3ZmL+BHGtDx+v
         s2CqUJ/DB0tiCsnV48dI4aLnmFfru/66ncm8gCNhciexYVfqITCz7E2DigXn3wKtRhR2
         p2GoFK1US32zGyZni3HZt1Fs8+EwaQyiWg4cvNWJedPaiVHaMOgIjJzYf3NuxS9ZT1eq
         Z5jG48TlqfFQBr+s9WQFpQC3ejCrUn5pJx9u+sQIi0wMhvRUg8rw3Wlhz9S277zr1lpZ
         zu2CTeSsDcFKHS9Vppexxk0WXnfzKMWqyRYFlgwAFLYI2JA/azDWxZrRD8cJbTjFGRET
         dqNQ==
X-Gm-Message-State: ABy/qLYkqwlUtyl/eNczw6UJv74wtr9iQ2p5X7bUJan8Z1bNM0PErtLs
        jDcDb6460Y5ihAhB4WN0iWeWqVi7L7p9jYA=
X-Google-Smtp-Source: APBJJlF/KCpsCV/2YIFa7djpxohGDinVuI+bknFgmFlVcG4ErNHMdBT/lnGY7RXpwPOaaurI0nnc+/OpNijt8O4=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:6c8])
 (user=aliceryhl job=sendgmr) by 2002:a50:9f6e:0:b0:50b:c4b5:bb77 with SMTP id
 b101-20020a509f6e000000b0050bc4b5bb77mr67283edf.1.1689605346438; Mon, 17 Jul
 2023 07:49:06 -0700 (PDT)
Date:   Mon, 17 Jul 2023 14:49:04 +0000
In-Reply-To: <vyrVN334oIXneb9VWievGpPTOCy0irxvoG-mDR0sQX5-xN-TL2Hngl0cl_XrVUwjDB3rXkXfR9Mdjy_no6fzhe4yIf_c7xpKa5OURt43k9c=@proton.me>
Mime-Version: 1.0
References: <vyrVN334oIXneb9VWievGpPTOCy0irxvoG-mDR0sQX5-xN-TL2Hngl0cl_XrVUwjDB3rXkXfR9Mdjy_no6fzhe4yIf_c7xpKa5OURt43k9c=@proton.me>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230717144904.1857663-1-aliceryhl@google.com>
Subject: Re: [PATCH v3 6/9] rust: workqueue: add helper for defining
 work_struct fields
From:   Alice Ryhl <aliceryhl@google.com>
To:     benno.lossin@proton.me
Cc:     alex.gaynor@gmail.com, aliceryhl@google.com,
        bjorn3_gh@protonmail.com, boqun.feng@gmail.com, gary@garyguo.net,
        jiangshanlai@gmail.com, linux-kernel@vger.kernel.org,
        ojeda@kernel.org, patches@lists.linux.dev,
        rust-for-linux@vger.kernel.org, tj@kernel.org, wedsonaf@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Benno Lossin <benno.lossin@proton.me> writes:
>> +/// Links for a work item.
>> +///
>> +/// This struct contains a function pointer to the `run` function from the [`WorkItemPointer`]
>> +/// trait, and defines the linked list pointers necessary to enqueue a work item in a workqueue.
>> +///
>> +/// Wraps the kernel's C `struct work_struct`.
>> +///
>> +/// This is a helper type used to associate a `work_struct` with the [`WorkItem`] that uses it.
>> +#[repr(transparent)]
>> +pub struct Work<T: ?Sized, const ID: u64 = 0> {
>> +    work: Opaque<bindings::work_struct>,
>> +    _inner: PhantomData<T>,
>
> Should this really be `PhantomData<T>`? Are you dropping `T`s in the 
> destructor of `Work<T>`? I do not think so `PhantomData<fn() -> Box<T>>`
> should do the trick.

Hmm. The `work_struct` effectively has a field of type `fn(T::Pointer)`,
so arguably, that's the type that should be used for the `PhantomData`.
This makes `Work` contravariant instead.

That said, the type `T` is going to be the struct itself, so, for
example, a `MyStruct<'a>` might have a `&'a i32` and a
`Work<MyStruct<'a>>` field, so it ends up being invariant.

By that argument, perhaps we should just make `Work` invariant instead?
We can do that with `PhantomData<*mut T>`.

>> +pub unsafe trait HasWork<T, const ID: u64 = 0> {
> 
> Is there a reason that `T` is `Sized` here?

Hmm, that's an oversight. In v1 of this patchset, the Sized requirement
was correct since T was the pointer type, but now it isn't anymore.

Alice
