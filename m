Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D50917FEE4B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 12:55:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345178AbjK3Lyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 06:54:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231784AbjK3Lyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 06:54:49 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E2D110C9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 03:54:55 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-db5416d0fccso328997276.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 03:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701345294; x=1701950094; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/Ea0g+hjygDzgDj1GEwYp4lup/QhGtb9KeZIVW/xhfo=;
        b=MVcHwtKJGkifbVfZNTWt7zcAl4ic2U4b7sU0jjyroRa+fxELpaFRl9lKmttwQo+83H
         wpMIeoWBtCwVD12k2eIsbNnTVHv8cGt1FutYoeaFtvoMH5NrU6l/ajd0Y76A30G74aBE
         r0EwwaEGlEjW0ZrgManBcbH12x3mTR8l5rHlQ8CNutHwqtpyCdkCbKNg0ddwSSqtm801
         nJKjqVh5im95NuFp4nUk0UkL7AxND37n0MQ6kCSfDY7HKJIq4C82jEBE3NMgRsSB+KIT
         1D9exUN62iZei44+0jnB8TttxiKrWaginfNq3Sb0GGSB3bs4uYsnhbLd6X1JWNYPDN1P
         kDzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701345294; x=1701950094;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/Ea0g+hjygDzgDj1GEwYp4lup/QhGtb9KeZIVW/xhfo=;
        b=GugZDIobYgMSZV2HUzLvQXtDtznUSzcKo1qt437DNbnZxnmnS1WM+NpitF4OdR+jkH
         hwHtHmFGBzijxgrILCE8wEaLyBbTPipSySkShJYGsQtZDlJ5Z1zN0ztrbDyJAoRY4IeX
         TCcxnblrbxMYxVdoaLlTgGk5uFqvI6zSOdNiGMX9LU3SHVqN7u39VPuv+db12aBN11c8
         nK77q3UOdQ0ewa+ktj+DaPRB+YdRXo6P/7oykFa8h86a175jGHnzIT827RA0vE99QEku
         DXut7cT6EvH3iLEzQEFKEUtZTs3SATLCybaTAX2/xn+wqgqkkJF2kIZHqGKOvxjCHyuI
         tLfQ==
X-Gm-Message-State: AOJu0YykW1Hzy8g3KlEGFaViU1FdgUKZx9e3T9bGtAgDC07VpFGEJ09W
        WlmOdCbfLnCF8yNH2JAh0V/nuIZtRMlMBLg=
X-Google-Smtp-Source: AGHT+IHPUC2oJigUCp4394fpGppUzbUGq5za43fjSJ3eZirrcKp2FsFh9awCLV6Z46O/m/gwIu+0t3KmwCZCHcs=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a25:d74f:0:b0:da0:c49a:5feb with SMTP id
 o76-20020a25d74f000000b00da0c49a5febmr600980ybg.4.1701345294581; Thu, 30 Nov
 2023 03:54:54 -0800 (PST)
Date:   Thu, 30 Nov 2023 11:54:51 +0000
In-Reply-To: <20231130-windungen-flogen-7b92c4013b82@brauner>
Mime-Version: 1.0
References: <20231130-windungen-flogen-7b92c4013b82@brauner>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Message-ID: <20231130115451.138496-1-aliceryhl@google.com>
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
> On Thu, Nov 30, 2023 at 09:17:56AM +0000, Alice Ryhl wrote:
>> Christian Brauner <brauner@kernel.org> writes:
>>>>>> +    /// Prevent values of this type from being moved to a different task.
>>>>>> +    ///
>>>>>> +    /// This is necessary because the C FFI calls assume that `current` is set to the task that
>>>>>> +    /// owns the fd in question.
>>>>>> +    _not_send_sync: PhantomData<*mut ()>,
>>>>> 
>>>>> I don't fully understand this. Can you explain in a little more detail
>>>>> what you mean by this and how this works?
>>>> 
>>>> Yeah, so, this has to do with the Rust trait `Send` that controls
>>>> whether it's okay for a value to get moved from one thread to another.
>>>> In this case, we don't want it to be `Send` so that it can't be moved to
>>>> another thread, since current might be different there.
>>>> 
>>>> The `Send` trait is automatically applied to structs whenever *all*
>>>> fields of the struct are `Send`. So to ensure that a struct is not
>>>> `Send`, you add a field that is not `Send`.
>>>> 
>>>> The `PhantomData` type used here is a special zero-sized type.
>>>> Basically, it says "pretend this struct has a field of type `*mut ()`,
>>>> but don't actually add the field". So for the purposes of `Send`, it has
>>>> a non-Send field, but since its wrapped in `PhantomData`, the field is
>>>> not there at runtime.
>>> 
>>> This probably a stupid suggestion, question. But while PhantomData gives
>>> the right hint of what is happening I wouldn't mind if that was very
>>> explicitly called NoSendTrait or just add the explanatory comment. Yes,
>>> that's a lot of verbiage but you'd help us a lot.
>> 
>> I suppose we could add a typedef:
>> 
>> type NoSendTrait = PhantomData<*mut ()>;
>> 
>> and use that as the field type. The way I did it here is the "standard"
>> way of doing it, and if you look at code outside the kernel, you will
>> also find them using `PhantomData` like this. However, I don't mind
>> adding the typedef if you think it is helpful.
> 
> I'm fine with just a comment as well. I just need to be able to read
> this a bit faster. I'm basically losing half a day just dealing with
> this patchset and that's not realistic if I want to keep up with other
> patches that get sent.
> 
> And if you resend and someone else review you might have to answer the
> same question again.

What do you think about this wording?

/// Prevent values of this type from being moved to a different task.
/// 
/// This field has the type `PhantomData<*mut ()>`, which does not
/// implement the Send trait. By adding a field with this property, we
/// ensure that the `FileDescriptorReservation` struct will not
/// implement the Send trait either. This has the consequence that the
/// compiler will prevent you from moving values of type
/// `FileDescriptorReservation` into a different task, which we want
/// because other tasks might have a different value of `current`. We
/// want to avoid that because `fd_install` assumes that the value of
/// `current` is unchanged since the call to `get_unused_fd_flags`.
/// 
/// The `PhantomData` type has size zero, so the field does not exist at
/// runtime.

Alice
