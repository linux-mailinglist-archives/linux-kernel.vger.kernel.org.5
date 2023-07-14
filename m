Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16C26753C5F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 15:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235943AbjGNN7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 09:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235941AbjGNN7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 09:59:35 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3532A35A2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 06:59:30 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-c0d62f4487cso1647730276.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 06:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689343169; x=1691935169;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=f3VLhyez7S8Fxr0ERu9RhgaoTPXwLJ8e9ss5xTgd/5U=;
        b=tTXXO37YV5oOkkCaZ5ruVLZvB1BwunC+5QG9IjqXfPk2ekddHPXHpr54pHFwYZN5F0
         WKlDOfm65SOnOOOG8dFDaNLOvVB1gIrypNJtOHHr7AWfDN3aFtGncM1dsfwIIjlfrhxP
         spvsoJYCZkB196gFxY9sGWnE/R4BtCIjupP6Z3oTmZE3Q3SzzJSrC9nIurmQnYCf8Ceo
         qpmVKouRgVRtfVTaJI0F5vMwUOYs5TD7B87+TOqGjoC1WDl+2rSP7R/i6kkNM8HDUoDy
         jK/eFcxwux46y3o+/DfdGwHoGtp21Pmy03qEw0Jx392W/hOJXvVyEhjMaul45Tf35dV1
         TtsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689343169; x=1691935169;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f3VLhyez7S8Fxr0ERu9RhgaoTPXwLJ8e9ss5xTgd/5U=;
        b=PChRX5G1ktC9vn6kQaIfpKnev1ZOW6YtET3ZXiD2LQoq80/bmEWiUTPHCLGfsJ3j7L
         j9wQ1EL+kzsxymyrYVluo9V5tIMXss7RY9uqTG8Z+TZDDRrGcONEDjneGWeCIb1ArO4r
         2mKKhOUGesCwe7iUb+8uyP7ANUTL0WiaABv1fiQ1yRMB5EE0f3AHWsTo4iW8XeUXkE/0
         UakxpqOj8VPCbrn5ivUpZFp8wOUu7ooRX0d015ASNAe7jPQfntYT3VwoeaP0qywbB4ug
         aE2Deio+g1KmDqXwEDl+wAOPy6cC7N4Lc6pZ38dG5gbGLUIHaqxkmJoB/T4rH6X/5l9b
         skzQ==
X-Gm-Message-State: ABy/qLbgt0lLWoH94atyDKHRSMSou1ntvohRc3l9/tax6SggWv7cb7JI
        /zyMQrbcxv0kwQ5YFPMIG3upjxWVh2iiNWw=
X-Google-Smtp-Source: APBJJlFY2TUbKqfNgWUbCaHnI40Hy7nUOoN90khfXB8t0UYtJOdB7SfJmtYKrqPge3WsT7kBkeGohfUbpMkLeN8=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:6c8])
 (user=aliceryhl job=sendgmr) by 2002:a05:6902:1817:b0:c5d:5b6f:f5c5 with SMTP
 id cf23-20020a056902181700b00c5d5b6ff5c5mr28360ybb.4.1689343169351; Fri, 14
 Jul 2023 06:59:29 -0700 (PDT)
Date:   Fri, 14 Jul 2023 13:59:26 +0000
In-Reply-To: <f974e5a4-1211-5ad7-4864-f3e210499e5e@asahilina.net>
Mime-Version: 1.0
References: <f974e5a4-1211-5ad7-4864-f3e210499e5e@asahilina.net>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230714135926.382695-1-aliceryhl@google.com>
Subject: Re: [PATCH RFC 00/11] rust: Implicit lock class creation & Arc
 Lockdep integration
From:   Alice Ryhl <aliceryhl@google.com>
To:     lina@asahilina.net
Cc:     alex.gaynor@gmail.com, aliceryhl@google.com, alyssa@rosenzweig.io,
        asahi@lists.linux.dev, benno.lossin@proton.me,
        bjorn3_gh@protonmail.com, boqun.feng@gmail.com, daniel@ffwll.ch,
        gary@garyguo.net, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        marcan@marcan.st, masahiroy@kernel.org, nathan@kernel.org,
        ndesaulniers@google.com, nicolas@fjasle.eu, ojeda@kernel.org,
        rust-for-linux@vger.kernel.org, sven@svenpeter.dev,
        trix@redhat.com, wedsonaf@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Asahi Lina <lina@asahilina.net> writes:
> On 14/07/2023 19.13, Alice Ryhl wrote:
> > Asahi Lina <lina@asahilina.net> writes:
> >> Begone, lock classes!
> >>
> >> As discussed in meetings/etc, we would really like to support implicit
> >> lock class creation for Rust code. Right now, lock classes are created
> >> using macros and passed around (similar to C). Unfortunately, Rust
> >> macros don't look like Rust functions, which means adding lockdep to a
> >> type is a breaking API change. This makes Rust mutex creation rather
> >> ugly, with the new_mutex!() macro and friends.
> >>
> >> Implicit lock classes have to be unique per instantiation code site.
> >> Notably, with Rust generics and monomorphization, this is not the same
> >> as unique per generated code instance. If this weren't the case, we
> >> could use inline functions and asm!() magic to try to create lock
> >> classes that have the right uniqueness semantics. But that doesn't work,
> >> since it would create too many lock classes for the same actual lock
> >> creation in the source code.
> >>
> >> But Rust does have one trick we can use: it can track the caller
> >> location (as file:line:column), across multiple functions. This works
> >> using an implicit argument that gets passed around, which is exactly the
> >> thing we do for lock classes. The tricky bit is that, while the value of
> >> these Location objects has the semantics we want (unique value per
> >> source code location), there is no guarantee that they are deduplicated
> >> in memory.
> >>
> >> So we use a hash table, and map Location values to lock classes. Et
> >> voila, implicit lock class support!
> >>
> >> This lets us clean up the Mutex & co APIs and make them look a lot more
> >> Rust-like, but it also means we can now throw Lockdep into more APIs
> >> without breaking the API. And so we can pull a neat trick: adding
> >> Lockdep support into Arc<T>. This catches cases where the Arc Drop
> >> implementation could create a locking correctness violation only when
> >> the reference count drops to 0 at that particular drop site, which is
> >> otherwise not detectable unless that condition actually happens at
> >> runtime. Since Drop is "magic" in Rust and Drop codepaths very difficult
> >> to audit, this helps a lot.
> >>
> >> For the initial RFC, this implements the new API only for Mutex. If this
> >> looks good, I can extend it to CondVar & friends in the next version.
> >> This series also folds in a few related minor dependencies / changes
> >> (like the pin_init mutex stuff).
> > 
> > I'm not convinced that this is the right compromise. Moving lockdep
> > class creation to runtime sounds unfortunate, especially since this
> > makes them fallible due to memory allocations (I think?).
> > 
> > I would be inclined to keep using macros for this.
> 
> Most people were very enthusiastic about this change in the meetings... 
> it wasn't even my own idea ^^

I don't think I was in that meeting. Anyway,
 
> I don't think the fallibility is an issue. Lockdep is a debugging tool, 
> and it doesn't have to handle all possible circumstances perfectly. If 
> you are debugging normal lock issues you probably shouldn't be running 
> out of RAM, and if you are debugging OOM situations the lock keys would 
> normally have been created long before you reach an OOM situation, since 
> they would be created the first time a relevant lock class is used. More 
> objects of the same class don't cause any more allocations. And the code 
> has a fallback for the OOM case, where it just uses the Location object 
> as a static lock class. That's not ideal and degrades the quality of the 
> lockdep results, but it shouldn't completely break anything.

If you have a fallback when the allocation fails, that helps ...

You say that Location objects are not necessarily unique per file
location. In practice, how often are they not unique? Always just using
the Location object as a static lock class seems like it would
significantly simplify this proposal.

> The advantages of being able to throw lockdep checking into arbitrary 
> types, like the Arc<T> thing, are pretty significant. It closes a major 
> correctness checking issue we have with Rust and its automagic Drop 
> implementations that are almost impossible to properly audit for 
> potential locking issues. I think that alone makes this worth it, even 
> if you don't use it for normal mutex creation...

I do agree that there is value in being able to more easily detect
potential deadlocks involving destructors of ref-counted values. I once
had a case of that myself, though lockdep was able to catch it without
this change because it saw the refcount hit zero in the right place.

Alice

