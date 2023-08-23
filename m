Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99BED785320
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 10:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234947AbjHWIyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 04:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234986AbjHWIrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 04:47:00 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18533268E
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 01:45:00 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3ff1c397405so3324775e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 01:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20221208.gappssmtp.com; s=20221208; t=1692780299; x=1693385099;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=q2cgmL0Oxi/Ka+T0qRkNIQGy3DlLEIQoGhbZx1wxXXg=;
        b=LonQ0vsOr7GJ73NzxO39Rbo6xOcF//DSk5ReABLOrEGbN2SFKmP7QBQ3Ds70B7+HH2
         vitmIRgQeu+cIR3Orv/AtwdGik94Po1BMx7mkzP7N/Dv2Rjpeo/Qp6+l/ABU0oO1WARc
         pxTAYpdnShdK8D803xL7MlB75J2uVsQdUeIT2tdR8lTgRk1VZ1GfPlmQJjs29YXm/1L1
         05VQ9rzA5MBCGPXA7ZYPQRunb8JkSD/STinlo/0a19Pvv8bvPzHHutMnEOZVomTEQS5a
         EVJpfwqiixoiRJ33Q0t5h39VHlf3gdSVMPiNpb2sKsWhfv43cXU5c3zEK5ePMtiRHjzy
         Fr5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692780299; x=1693385099;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q2cgmL0Oxi/Ka+T0qRkNIQGy3DlLEIQoGhbZx1wxXXg=;
        b=UhM0Bohnt0gcnZNUGjYXPbQbRblOPxp4ULFLqrcNH/N7QLZ0+Q2NpwzXd/aOczwaCg
         I5abFkIfuNkcu5KeNcwCpL8KijVvyKGJMNJJps5fi1f/IMLgX5SiLkikfp2/aghuEq2A
         rjjWH1H2c9hlhyXntaz/EPESPrmzGakwfni/L+mLDsrkxlEHvqTsdsUyI52hJKtdOPLB
         Zzoog+UgxVviJxLeNopNKs1Wl7QUixV9xobYzMBiYQ/fWxD5I+0wC/1OrPSC/FncWgCc
         yGHXKUOXL9h18YLQ+9W7SmPR6ysZzIFW5ayLzpyRot+0KQATyL9omn1ZyHAe/tw6fxVk
         nfdQ==
X-Gm-Message-State: AOJu0Yz35uzHLnQCsEWljqR9LMOTsFmpeAsn+iusrhWhC9qHkAT3LFu8
        gex+7ftHrbBovXryjt1VdHQ2OQ==
X-Google-Smtp-Source: AGHT+IHK4M5cW+ii2QsY9thF0YAboNVSBb0QymA/D8MSrbEEeJganwycbU58f5qGLuLuVPD1BN12nw==
X-Received: by 2002:a7b:c3d0:0:b0:3f9:c0f2:e1a4 with SMTP id t16-20020a7bc3d0000000b003f9c0f2e1a4mr8835302wmj.34.1692780298570;
        Wed, 23 Aug 2023 01:44:58 -0700 (PDT)
Received: from localhost ([165.225.194.193])
        by smtp.gmail.com with ESMTPSA id l11-20020a1c790b000000b003fbca942499sm21185071wme.14.2023.08.23.01.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 01:44:58 -0700 (PDT)
References: <87r0octho8.fsf@metaspace.dk>
 <20230822093154.3478754-1-aliceryhl@google.com>
User-agent: mu4e 1.10.5; emacs 28.2.50
From:   "Andreas Hindborg (Samsung)" <nmi@metaspace.dk>
To:     Alice Ryhl <aliceryhl@google.com>
Cc:     alex.gaynor@gmail.com, benno.lossin@proton.me,
        bjorn3_gh@protonmail.com, boqun.feng@gmail.com, gary@garyguo.net,
        linux-kernel@vger.kernel.org, ojeda@kernel.org,
        patches@lists.linux.dev, rust-for-linux@vger.kernel.org,
        wedsonaf@gmail.com
Subject: Re: [PATCH v1] rust: add improved version of
 `ForeignOwnable::borrow_mut`
Date:   Wed, 23 Aug 2023 10:43:18 +0200
In-reply-to: <20230822093154.3478754-1-aliceryhl@google.com>
Message-ID: <87msyi406u.fsf@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Alice Ryhl <aliceryhl@google.com> writes:

> Andreas Hindborg <nmi@metaspace.dk> writes:
>>> diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
>>> index 172f563976a9..f152a562c9c3 100644
>>> --- a/rust/kernel/sync/arc.rs
>>> +++ b/rust/kernel/sync/arc.rs
>>> @@ -232,26 +232,35 @@ pub fn ptr_eq(this: &Self, other: &Self) -> bool {
>>>  
>>>  impl<T: 'static> ForeignOwnable for Arc<T> {
>>>      type Borrowed<'a> = ArcBorrow<'a, T>;
>>> +    // Mutable access to the `Arc` does not give any extra abilities over
>>> +    // immutable access.
>>> +    type BorrowedMut<'a> = ArcBorrow<'a, T>;
>>>  
>>>      fn into_foreign(self) -> *const core::ffi::c_void {
>>>          ManuallyDrop::new(self).ptr.as_ptr() as _
>>>      }
>>>  
>>> -    unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> ArcBorrow<'a, T> {
>>> -        // SAFETY: By the safety requirement of this function, we know that `ptr` came from
>>> -        // a previous call to `Arc::into_foreign`.
>>> -        let inner = NonNull::new(ptr as *mut ArcInner<T>).unwrap();
>>> -
>>> -        // SAFETY: The safety requirements of `from_foreign` ensure that the object remains alive
>>> -        // for the lifetime of the returned value.
>>> -        unsafe { ArcBorrow::new(inner) }
>>> -    }
>>> -
>>>      unsafe fn from_foreign(ptr: *const core::ffi::c_void) -> Self {
>>>          // SAFETY: By the safety requirement of this function, we know that `ptr` came from
>>>          // a previous call to `Arc::into_foreign`, which guarantees that `ptr` is valid and
>>>          // holds a reference count increment that is transferrable to us.
>>> -        unsafe { Self::from_inner(NonNull::new(ptr as _).unwrap()) }
>>> +        unsafe { Self::from_inner(NonNull::new_unchecked(ptr as _)) }
>>>      }
>>> +
>>> +    unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> ArcBorrow<'a, T> {
>>> +        // SAFETY: By the safety requirement of this function, we know that `ptr` came from
>>> +        // a previous call to `Arc::into_foreign`.
>>> +        let inner = unsafe { NonNull::new_unchecked(ptr as *mut ArcInner<T>) };
>>> +
>>> +        // SAFETY: The safety requirements ensure that we will not give up our
>>> +        // foreign-owned refcount while the `ArcBorrow` is still live.
>>> +        unsafe { ArcBorrow::new(inner) }
>>> +    }
>>> +
>>> +    unsafe fn borrow_mut<'a>(ptr: *const core::ffi::c_void) -> ArcBorrow<'a, T> {
>>> +        // SAFETY: The safety requirements for `borrow_mut` are a superset of the safety
>>> +        // requirements for `borrow`.
>>> +        unsafe { Self::borrow(ptr) }
>>> +    }
>>
>> I am not sure this makes sense. How about splitting the trait in two,
>> immutable and mutable and only implementing the immutable one or Arc?
>
> I used this design based on what would make sense for a linked list. The
> idea is that we can have two different types of cursors for a linked
> list: immutable and mutable. The immutable cursor lets you:
>
>  * move around the linked list
>  * access the values using `borrow`
>
> The mutable cursor lets you:
>
>  * move around the linked list
>  * delete or add items to the list
>  * access the values using `borrow_mut`
>
> The mutable cursor gives you extra abilities beyond the `borrow` vs
> `borrow_mut` distinction, so we want to provide both types of cursors
> even if the pointer type is Arc. To do that, we need a trait that
> defines what it means to have mutable access to an Arc.

I don't see how that prevents this trait from being split in two?

BR Andreas

