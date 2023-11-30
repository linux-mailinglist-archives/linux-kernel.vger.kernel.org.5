Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2356C7FEBB0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 10:18:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231785AbjK3JRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 04:17:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235005AbjK3JRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 04:17:53 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C9271A8
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 01:18:00 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5d33b70fce8so7508407b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 01:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701335879; x=1701940679; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=O12+T4VHs59BbmEd4p1QKD8uv+vZIjQpPLDFbLiopH8=;
        b=F/y9wWP4HV0Cs8PzAfsCU7uJrkH9qlj1xMQmJwIlr7ExMwwylsCI3LE09vRBZ8WC0t
         pv/qjMkOn4OC8fQvOFHsHjS/sPZi4KHnsp73E9/yJcihOugDKt8TQ2Ezb+PUxDss+t7U
         lSj5EUn3iE4oR4dCPqC++yQwpzktZu4dZ7kRCpQl0ITgu5xwinnRGsjRGOmLclWoS3tV
         Etb6KA/cjAVz6Dew7A946kKLYaoTSx1qKSMySKaxqPExxldT4vx/n+3ZFkVFUSkmRCMy
         cUKuR9yJ1elKEpGsWrPtaranGSUY2HAah7+LEawhlFQ+QzxCXODv0JR43MTG6vxXNiZK
         lXJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701335879; x=1701940679;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O12+T4VHs59BbmEd4p1QKD8uv+vZIjQpPLDFbLiopH8=;
        b=dc5tEoSGXv3SDDLV2V3FLE2m5A2A7zEnEFH1k35YJk90Zf2ArtBPxqckQBs5wsx3s2
         ujiMsk4P6noMZhquSlBVzVdqkJlmvEzBfmaMtau9V7pi1WKdydg/6oc8ADZhTbFaYrU7
         QF+kt+TjmJoTsH4Prw/AF+T5IoK6WOrKVCO8n2bxv976bMepTFpwmj7rMS/2ZWydBNvx
         lzIW2kBF8hGfmW+J94vhbm13haNhQIdwiu3gdVNUgVRF8IgoiZJhIMgL2qKSgSihgnfx
         wHFUpggeuWXeQ2+0ISLjHrclaIx28IQoUrBk7+1n87iZ945f/N5W0pISXk5uIM16cCCS
         J9/w==
X-Gm-Message-State: AOJu0Yw0q1goJb47bnqSBvoD2cM0AXGZvsxMA2YZEijBPAZYe5bi3zp6
        +WDI3zAs6LA/RKjyeej0L1JUsc+ZAT5pUdc=
X-Google-Smtp-Source: AGHT+IHzPN7vc8Ym+e7HloN4Bx1IsbMnveO7SXtX9AogNS+hR0lbo+Q4FrLB3KXr1ynr8S4Zs45Va9u9mfVb9Gc=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a25:d604:0:b0:db5:3b5e:3925 with SMTP id
 n4-20020a25d604000000b00db53b5e3925mr45069ybg.12.1701335879254; Thu, 30 Nov
 2023 01:17:59 -0800 (PST)
Date:   Thu, 30 Nov 2023 09:17:56 +0000
In-Reply-To: <20231130-lernziel-rennen-0a5450188276@brauner>
Mime-Version: 1.0
References: <20231130-lernziel-rennen-0a5450188276@brauner>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Message-ID: <20231130091756.109655-1-aliceryhl@google.com>
Subject: Re: [PATCH 4/7] rust: file: add `FileDescriptorReservation`
From:   Alice Ryhl <aliceryhl@google.com>
To:     brauner@kernel.org
Cc:     a.hindborg@samsung.com, alex.gaynor@gmail.com,
        aliceryhl@google.com, arve@android.com, benno.lossin@proton.me,
        bjorn3_gh@protonmail.com, boqun.feng@gmail.com,
        cmllamas@google.com, dan.j.williams@intel.com, dxu@dxuuu.xyz,
        gary@garyguo.net, gregkh@linuxfoundation.org,
        joel@joelfernandes.org, keescook@chromium.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        maco@android.com, ojeda@kernel.org, peterz@infradead.org,
        rust-for-linux@vger.kernel.org, surenb@google.com,
        tglx@linutronix.de, tkjos@android.com, viro@zeniv.linux.org.uk,
        wedsonaf@gmail.com, willy@infradead.org
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Brauner <brauner@kernel.org> writes:
>>>> +    /// Prevent values of this type from being moved to a different task.
>>>> +    ///
>>>> +    /// This is necessary because the C FFI calls assume that `current` is set to the task that
>>>> +    /// owns the fd in question.
>>>> +    _not_send_sync: PhantomData<*mut ()>,
>>> 
>>> I don't fully understand this. Can you explain in a little more detail
>>> what you mean by this and how this works?
>> 
>> Yeah, so, this has to do with the Rust trait `Send` that controls
>> whether it's okay for a value to get moved from one thread to another.
>> In this case, we don't want it to be `Send` so that it can't be moved to
>> another thread, since current might be different there.
>> 
>> The `Send` trait is automatically applied to structs whenever *all*
>> fields of the struct are `Send`. So to ensure that a struct is not
>> `Send`, you add a field that is not `Send`.
>> 
>> The `PhantomData` type used here is a special zero-sized type.
>> Basically, it says "pretend this struct has a field of type `*mut ()`,
>> but don't actually add the field". So for the purposes of `Send`, it has
>> a non-Send field, but since its wrapped in `PhantomData`, the field is
>> not there at runtime.
> 
> This probably a stupid suggestion, question. But while PhantomData gives
> the right hint of what is happening I wouldn't mind if that was very
> explicitly called NoSendTrait or just add the explanatory comment. Yes,
> that's a lot of verbiage but you'd help us a lot.

I suppose we could add a typedef:

type NoSendTrait = PhantomData<*mut ()>;

and use that as the field type. The way I did it here is the "standard"
way of doing it, and if you look at code outside the kernel, you will
also find them using `PhantomData` like this. However, I don't mind
adding the typedef if you think it is helpful.

Alice
