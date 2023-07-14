Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01A727543D9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 22:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236409AbjGNUiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 16:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236402AbjGNUiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 16:38:14 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12FAA3AB3;
        Fri, 14 Jul 2023 13:38:03 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-1b055510c9dso1562322fac.0;
        Fri, 14 Jul 2023 13:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689367081; x=1691959081;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W89cgNy1eNMzHOiNr0LRyucV1brLsczr4weQChBoiQg=;
        b=f9kMHGWeKmTB6HbLltAi4/fyW22V2tWlSzB4grilg1liYKvNB8vtXLS/OKa836RCJf
         GL8qyoT1a7m1v2QJ5czSZdtD7UHD/GUhIZFP+If6GRN2F9EQdHLnAHDp2kLFylDtzT9u
         +ynfreEUnSLmwbOqDSIVdrCly8rnqnHjdSHv/Ko5yNlvGfhmXEzjUHl8ErcY6IwgVxiC
         ekIR3UirrbE48novxPQLRwYTPnoioKjFo5y5rysdA0nmuwyN2HaX117MllsThEcBw2G8
         VSSqFEc6N5zsDUzBYGNlweI5B4GQwnO1Qpofnu/Prx0YpndEP0Yh4WWC/40Zn8BcKFVE
         0fTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689367081; x=1691959081;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W89cgNy1eNMzHOiNr0LRyucV1brLsczr4weQChBoiQg=;
        b=QDLJnZHvq7CGB7lt7DzKReAASWpbkLfjgwAfiDDmrpOyZBPGdeY1Q5N/jIvOquUctE
         53u3tzoYgVSBDTTT86hgcJkQL3xrf8/ROhmrO+7jt9AOMfvOKiDg1cQBckLO6JDHXQbX
         EUZQPmawksOIsNkcXzQfx8AHOG/XYCcHI1s3bMq6SkRrMC0bio+bg1acEcVDGZNV/7Dk
         uA/YURxxnwt80771EFHdiUahA+NhWmCqowIwQ9Ad+sxtjFWcan0yPDZ8zvmsgHdcmgKh
         bWjMESdNJQu+zBYtZe/x5H92C/bA6ghqvwbM5kQhoToOjYBNpvY8Fe9D8hnTE3opElLt
         x0aA==
X-Gm-Message-State: ABy/qLZ57Ad5Fex3QHm8D3BmeRB/lG0Cri6FBX+RxpCt00Pg9XZRh6iE
        BppXDhXY92U/2ene5zPYhSo=
X-Google-Smtp-Source: APBJJlHVyCp5IxFJ6qO/h2cfiutewACkZl9hi48ptZGNOKVH0KtFwusHVfRsonFsvr6QR1es6WjUVQ==
X-Received: by 2002:a05:6870:934a:b0:1a2:c181:5c85 with SMTP id j10-20020a056870934a00b001a2c1815c85mr6561375oak.9.1689367081191;
        Fri, 14 Jul 2023 13:38:01 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id ee23-20020a056870c81700b001a69e7efd13sm4403908oab.5.2023.07.14.13.37.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jul 2023 13:38:00 -0700 (PDT)
Message-ID: <28a747bb-2d14-61b6-b5b5-54f8a162155a@gmail.com>
Date:   Fri, 14 Jul 2023 16:56:17 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH RFC 07/11] rust: sync: Implement dynamic lockdep class
 creation
Content-Language: en-US
To:     Asahi Lina <lina@asahilina.net>, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>, Tom Rix <trix@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        asahi@lists.linux.dev, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        llvm@lists.linux.dev
References: <20230714-classless_lockdep-v1-0-229b9671ce31@asahilina.net>
 <20230714-classless_lockdep-v1-7-229b9671ce31@asahilina.net>
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20230714-classless_lockdep-v1-7-229b9671ce31@asahilina.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/14/23 06:13, Asahi Lina wrote:
> Using macros to create lock classes all over the place is unergonomic,
> and makes it impossible to add new features that require lock classes to
> code such as Arc<> without changing all callers.
> 
> Rust has the ability to track the caller's identity by file/line/column
> number, and we can use that to dynamically generate lock classes
> instead.
> 
> Signed-off-by: Asahi Lina <lina@asahilina.net>
> ---
> [...]
> +
> +const LOCK_CLASS_BUCKETS: usize = 1024;
> +
> +#[track_caller]
> +fn caller_lock_class_inner() -> Result<&'static DynLockClassKey> {
> +    // This is just a hack to make the below static array initialization work.
> +    #[allow(clippy::declare_interior_mutable_const)]
> +    const ATOMIC_PTR: AtomicPtr<Mutex<Vec<&'static DynLockClassKey>>> =
> +        AtomicPtr::new(core::ptr::null_mut());
> +
> +    #[allow(clippy::complexity)]
> +    static LOCK_CLASSES: [AtomicPtr<Mutex<Vec<&'static DynLockClassKey>>>; LOCK_CLASS_BUCKETS] =
> +        [ATOMIC_PTR; LOCK_CLASS_BUCKETS];
> +
> +    let loc = core::panic::Location::caller();
> +    let loc_key = LocationKey::new(loc);
> +
> +    let index = (loc_key.hash % (LOCK_CLASS_BUCKETS as u64)) as usize;
> +    let slot = &LOCK_CLASSES[index];
> +
> +    let mut ptr = slot.load(Ordering::Relaxed);
> +    if ptr.is_null() {
> +        let new_element = Box::pin_init(new_mutex!(Vec::new()))?;
> +
> +        if let Err(e) = slot.compare_exchange(
> +            core::ptr::null_mut(),
> +            // SAFETY: We never move out of this Box
> +            Box::into_raw(unsafe { Pin::into_inner_unchecked(new_element) }),
> +            Ordering::Relaxed,
> +            Ordering::Relaxed,
> +        ) {
> +            // SAFETY: We just got this pointer from `into_raw()`
> +            unsafe { Box::from_raw(e) };
> +        }
> +
> +        ptr = slot.load(Ordering::Relaxed);
> +        assert!(!ptr.is_null());
> +    }
> +
> +    // SAFETY: This mutex was either just created above or previously allocated,
> +    // and we never free these objects so the pointer is guaranteed to be valid.
> +    let mut guard = unsafe { (*ptr).lock() };
> +
> +    for i in guard.iter() {
> +        if i.loc == loc_key {
> +            return Ok(i);
> +        }
> +    }
> +
> +    // We immediately leak the class, so it becomes 'static
> +    let new_class = Box::leak(Box::try_new(DynLockClassKey {
> +        key: Opaque::zeroed(),
> +        loc: loc_key,
> +        name: CString::try_from_fmt(fmt!("{}:{}:{}", loc.file(), loc.line(), loc.column()))?,
> +    })?);
> +
> +    // SAFETY: This is safe to call with a pointer to a dynamically allocated lockdep key,
> +    // and we never free the objects so it is safe to never unregister the key.
> +    unsafe { bindings::lockdep_register_key(new_class.key.get()) };
> +
> +    guard.try_push(new_class)?;
> +
> +    Ok(new_class)
> +}
> +
> [...]

Is there any problem if we have many `DynLockClassKey`s leaked or not?
