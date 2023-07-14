Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 405F1753772
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 12:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235467AbjGNKFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 06:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235800AbjGNKFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 06:05:52 -0400
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E552E3A86
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 03:05:28 -0700 (PDT)
Received: by mail-ed1-x549.google.com with SMTP id 4fb4d7f45d1cf-51dd4df2477so1038412a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 03:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689329127; x=1691921127;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q5MF44XQzouX2FbGdHpxAthvfg7u3iO2oNPh/cM8NKE=;
        b=apJ81VA8GA3jTnw53j82PIZMpXO2K7A7oa/aWR/pG0xVkTrMRoSr2WO7woWzhaKgks
         Qiu5Ef2OtOLcCCthMBik8jre5JgKbOQ296jPDHO+0XBtbeQZ3GCV++0K6RdSFg4RJLtx
         HI5xt3Zx+SZVy5n98a+5XUHMB8tMTj6+uvbS9OppSt9LaXPRTaCyk7dj/0vpRi483Q/w
         mMeuWWvg9oj5KISbLCA6AXRIem3Ndp1x+G4RQ0XIlDX39FHUS6Q4CERdEKP9pZtXSvxP
         St538WJiTpZgiaPMGVu8ypTZGB9xPR5JNHSI92L2DHBK2iYWCB6Zt6EOsYaik2bKgOu7
         3ZHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689329127; x=1691921127;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q5MF44XQzouX2FbGdHpxAthvfg7u3iO2oNPh/cM8NKE=;
        b=XI773s93p9OP32+W8E7jfvwyHjwDGWfst6E14EFR7LKLra4ahWiUNJCeEf8cQUY67h
         vVQ5ThQXwzjQfYBhJ77aZHABazcgIXM9Vb7YYRHfy9zmogbcPUqxJaDqY71Bihv+pilI
         jxCjxn1tFrFA5RJbCq7FoCn6h2yhUbr2ZUSXwQzm6jfs6WJpFmGarDG6trxSDpWlj3Sf
         svBRoXIJxs9LF2k9x3FtN3RuIAI/XkCMxgAtdscUuHaZ9mvtRBMzgtioNPc43k0lQCxD
         mxNMN48C+9zOaClZS1u1sVGETNgbspeMdei31X/q7fSXC5DLLWNq8ZRLlotk40gYOtRg
         84cw==
X-Gm-Message-State: ABy/qLahyBBulqT7USx4Eu/Akv7nNrtI23KmSItt1fT9fSEoo83w+jVB
        JHJHfDCdTEdHVd7ciPJIiGkNzWkBteMM0v4=
X-Google-Smtp-Source: APBJJlHwVKX/eQQLU8nLjAGvJpMaB1Jw8Jm+qhCHiVH05w5ZGIxlbFTKtQ7Ig8Do+3M/gB90uk1NNJRpAEM9C74=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:6c8])
 (user=aliceryhl job=sendgmr) by 2002:a50:9f07:0:b0:510:dd95:da5d with SMTP id
 b7-20020a509f07000000b00510dd95da5dmr19412edf.4.1689329127461; Fri, 14 Jul
 2023 03:05:27 -0700 (PDT)
Date:   Fri, 14 Jul 2023 10:05:25 +0000
In-Reply-To: <20230714-rust-time-v2-1-f5aed84218c4@asahilina.net>
Mime-Version: 1.0
References: <20230714-rust-time-v2-1-f5aed84218c4@asahilina.net>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230714100525.2192448-1-aliceryhl@google.com>
Subject: Re: [PATCH v2] rust: time: New module for timekeeping functions
From:   Alice Ryhl <aliceryhl@google.com>
To:     lina@asahilina.net
Cc:     alex.gaynor@gmail.com, asahi@lists.linux.dev,
        bjorn3_gh@protonmail.com, boqun.feng@gmail.com, gary@garyguo.net,
        gbs@canishe.com, heghedus.razvan@protonmail.com,
        jistone@redhat.com, jstultz@google.com,
        linux-kernel@vger.kernel.org, ojeda@kernel.org,
        rust-for-linux@vger.kernel.org, sboyd@kernel.org,
        tglx@linutronix.de, wedsonaf@gmail.com
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
> +/// Marker trait for clock sources that represent a calendar (wall clock)
> +/// relative to the UNIX epoch.
> +pub trait WallTime {}

What's the purpose of this trait? Perhaps it should have a method to get
the UNIX epoch as an Instant?

> +    /// Returns the time elapsed since an earlier Instant<t>, or
> +    /// None if the argument is a later Instant.
> +    pub fn since(&self, earlier: Instant<T>) -> Option<Duration> {
> +        if earlier.nanoseconds > self.nanoseconds {
> +            None
> +        } else {
> +            // Casting to u64 and subtracting is guaranteed to give the right
> +            // result for all inputs, as long as the condition we checked above
> +            // holds.
> +            Some(Duration::from_nanos(
> +                self.nanoseconds as u64 - earlier.nanoseconds as u64,
> +            ))

It looks like you intend to use wrapping semantics for this subtraction
so that self=1,earlier=-1 results in a difference of two.

In that case, you should explicitly use `.wrapping_sub` instead to
convey your intent.

I guess you could also use `abs_diff`, which takes two i64s and returns
an u64.

> +/// Contains the various clock source types available to the kernel.
> +pub mod clock {
> +    use super::*;
> +
> +    /// A clock representing the default kernel time source.
> +    ///
> +    /// This is `CLOCK_MONOTONIC` (though it is not the only
> +    /// monotonic clock) and also the default clock used by
> +    /// `ktime_get()` in the C API.
> +    ///
> +    /// This is like `BootTime`, but does not include time
> +    /// spent sleeping.
> +
> +    pub struct KernelTime;
> +
> +    impl Clock for KernelTime {}
> +    impl Monotonic for KernelTime {}
> +    impl Now for KernelTime {
> +        fn now() -> Instant<Self> {
> +            Instant::<Self>::new(unsafe { bindings::ktime_get() })
> +        }
> +    }

We usually add a SAFETY comment even if it is trivial.

// SAFETY: Just an FFI call without any safety requirements.

Alice

