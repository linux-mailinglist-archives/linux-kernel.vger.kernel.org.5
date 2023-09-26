Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69C1E7AE9D0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 12:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234332AbjIZKBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 06:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233494AbjIZKBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 06:01:42 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B232BE
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 03:01:34 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59c0327b75dso150803427b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 03:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695722494; x=1696327294; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PSjOVj3NEZLcZiR/Ha2dwc9eHr7RbUTNTjvX8TFLRcY=;
        b=nWSZO9q4u/q4IPDeRiji0HqLaHHPRM3kcMAkUSYERcswAMLYk0Abw+ivGlrsM9UCAm
         vr6+1ivoZ8r9z7WpBsLkVJtMZYS0tKVrUFgM4XYMvDfHbIQYLgPs/Gv0RfyJsywvxxrz
         XvbMlcvow/goO825R3+5SVuaeswEfStLGcU7A7UDvhs63XLxgkH9awU3BK1pnHsrYaPa
         ne2BuxxdGbi4agqR7kQb/XPB8qcK6dbelk6C2+NKJc+BBnefzQTVN76wCXy3Vbo/DPHN
         w/iQ0UhB0A3vJy9/abYbrE/umXM2aueFLzu2mH6KtkVyrcJgs/Ox90mutoEEPqooT6uN
         n7+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695722494; x=1696327294;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PSjOVj3NEZLcZiR/Ha2dwc9eHr7RbUTNTjvX8TFLRcY=;
        b=H7GN3wNVYLd4sQaXvC4Lqh9mMdmvOGjLgohtkOx0SBQxCkoCTAD0vwk6mwbw+9hQAJ
         1XT+m7lc2mUpj4uk1xjGbUbxIojNdgs9WxJVOgtXWs5OSF7NdGiUV5ZwSJwgPDGLYojI
         TVonQNPrOszAQjjytK/oyviGa5JgGFulYkyOvGfQIhEc4OgPsxEOVSB8tToeUGi7DsN0
         urEGciAioj3R9w3LzidmyM8g1UBEwMgWsLpwPz4R1i2N2r796mFqwtB5d/+aTa2nzdXl
         SsDFY6STep3binbBqOkWuF9lzcdmEmsyhAj/MQVknNWo3M6v4ZRBds9wPTDsOL31G3JQ
         Dg/w==
X-Gm-Message-State: AOJu0YwhHo5kZawRfO3rNkVIjfMTTgxvEo3+VpEFo3fkJdsEXiZQW7mp
        UMzZaddzH7g8HitYeX6o6tAJEoYCRz1dtZY=
X-Google-Smtp-Source: AGHT+IENb6kAQt3SlryXf26yUjvt3kHMvyFyfMBdt8l5kkIskKFOxg0e0rnYFWlj/Hfa6u+U/vGJjT4sf4b0An8=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:6c8])
 (user=aliceryhl job=sendgmr) by 2002:a25:9c44:0:b0:d80:16bc:4e41 with SMTP id
 x4-20020a259c44000000b00d8016bc4e41mr91493ybo.0.1695722493787; Tue, 26 Sep
 2023 03:01:33 -0700 (PDT)
Date:   Tue, 26 Sep 2023 10:01:30 +0000
In-Reply-To: <ESFnxZLcZD-JbNp5PHtrjAdophrPm9gOJR1C5kwsvw6errySiqsG7zbs-0bKWKGrq3Phz7-of0M1znwoTNYAZATTHBhUaFehe5bHP1YksCw=@proton.me>
Mime-Version: 1.0
References: <ESFnxZLcZD-JbNp5PHtrjAdophrPm9gOJR1C5kwsvw6errySiqsG7zbs-0bKWKGrq3Phz7-of0M1znwoTNYAZATTHBhUaFehe5bHP1YksCw=@proton.me>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Message-ID: <20230926100130.2213190-1-aliceryhl@google.com>
Subject: Re: [PATCH v4 4/7] rust: workqueue: add helper for defining
 work_struct fields
From:   Alice Ryhl <aliceryhl@google.com>
To:     benno.lossin@proton.me
Cc:     alex.gaynor@gmail.com, aliceryhl@google.com,
        bjorn3_gh@protonmail.com, boqun.feng@gmail.com, gary@garyguo.net,
        jiangshanlai@gmail.com, linux-kernel@vger.kernel.org,
        ojeda@kernel.org, patches@lists.linux.dev,
        rust-for-linux@vger.kernel.org, tj@kernel.org, wedsonaf@gmail.com
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> +impl<T: ?Sized, const ID: u64> Work<T, ID> {
>> +    /// Creates a new instance of [`Work`].
>> +    #[inline]
>> +    #[allow(clippy::new_ret_no_self)]
>> +    pub fn new(name: &'static CStr, key: &'static LockClassKey) -> impl PinInit<Self>
>> +    where
>> +        T: WorkItem<ID>,
>> +    {
>> +        // SAFETY: The `WorkItemPointer` implementation promises that `run` can be used as the work
>> +        // item function.
>> +        unsafe {
>> +            kernel::init::pin_init_from_closure(move |slot| {
>> +                let slot = Self::raw_get(slot);
>> +                bindings::init_work_with_key(
>> +                    slot,
>> +                    Some(T::Pointer::run),
>> +                    false,
>> +                    name.as_char_ptr(),
>> +                    key.as_ptr(),
>> +                );
>> +                Ok(())
>> +            })
>> +        }
> 
> I would suggest this instead:
> ```
>         pin_init!(Self {
>             // SAFETY: The `WorkItemPointer` implementation promises that `run` can be used as the
>             // work item function.
>             work <- Opaque::ffi_init(|slot| unsafe {
>                 bindings::init_work_with_key(
>                     slot,
>                     Some(T::Pointer::run),
>                     false,
>                     name.as_char_ptr(),
>                     key.as_ptr(),
>                 )
>             }),
>             _inner: PhantomData,
>         })
> ```

I tried setting up a patch with a few nits fixed, including this one.
However, I ran into an error when adding #[pin_data] to the Work struct:

error: defaults for const parameters are only allowed in `struct`, `enum`, `type`, or `trait` definitions
   --> rust/kernel/workqueue.rs:192:28
    |
192 | pub struct Work<T: ?Sized, const ID: u64 = 0> {
    |                            ^^^^^^^^^^^^^^^^^

This nit can be fixed when #[pin_data] is updated to support default
values in struct declarations.

Alice
