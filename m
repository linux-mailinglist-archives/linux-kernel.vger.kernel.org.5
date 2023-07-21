Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2401875BB85
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 02:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbjGUA0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 20:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbjGUA0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 20:26:24 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 352762D5D;
        Thu, 20 Jul 2023 17:26:05 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id 006d021491bc7-563439ea4a2so907729eaf.0;
        Thu, 20 Jul 2023 17:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689899145; x=1690503945;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AUxAUxBgznY3Og9YJhvDaTnrmVi36NxFsPUTVTYK8uw=;
        b=lqRoXVWcBtJdYaHdscHh3kf0HpNlZAqxzMFZ4J2jIXosuiKkmW+qRluZafnHEGfLFw
         9rNrbPOayyB/AHBmPQIg4LvRvwK5dq0/cJXampNJcmK3zU8g+VIlg81NfYWOigqDEAfK
         LkTawgTv3uhq1xeAzb/BoXykk55X4DqwL27H+Y+7+EPeKRsMFS0N9zaabFCcDHzyO3ih
         te1OGb+57zNJvHtA++1LyQhGgV/XVAgDLk4nhiF43K+4a/aUJ6ObEqx/ijMXEG3RlZHf
         zZYsfWFfb/EmwadYmNYjxoKZ5rCXZTX06CnqqL5ayT0+TJNcNhsnjMarkURfHBZoptAM
         C+6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689899145; x=1690503945;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AUxAUxBgznY3Og9YJhvDaTnrmVi36NxFsPUTVTYK8uw=;
        b=khAdzT9J1GABDjUh46LapYvoEP+i1m66jKJ5vTIcubMYp94osfxzKCuaCTGU5JKMkx
         dT41AHn+s144+VDT5QJRjZ3BDlf1uVgRi1K/n3yLDhiQ9l9JjdlDZd7N0805nKLXQ3o5
         Ppw8OWf6P7Y64P0oxT6wZRRV781Fms9pLD1sn4DBtZj6zw467iBJIvvKIgwi/opPVWuM
         +l0bPEnh/NhZegNt80KknigH51ciEwUFOrdZSHul2DgTn9uDWbKzUqZYdgUSHPg3Wdwu
         Mfc4p1wekuc1OeAw2g2hxQxit0kt/92FQhFyekytg7IGA7cqLQWc0lxiIUrVsg6gb3Qb
         P5aA==
X-Gm-Message-State: ABy/qLYPch+fFX3vWIfiSofjRD7PM1kLnu9d6VxCE3BwZlhUHUdSNdDL
        gpBs4rRx5VBYUYTTYtH5iVQ=
X-Google-Smtp-Source: APBJJlGcAAz1SoMX8jdQO0Gql6o9LZ8nx3n5Pgr4tRc1DmEtQYxhYfGwVKNW56tgjTajq6C6wyJNSA==
X-Received: by 2002:a05:6808:1598:b0:3a1:e3ee:742a with SMTP id t24-20020a056808159800b003a1e3ee742amr625972oiw.8.1689899145370;
        Thu, 20 Jul 2023 17:25:45 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id t25-20020a056808159900b0039ee1de4e6esm928210oiw.38.2023.07.20.17.25.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jul 2023 17:25:45 -0700 (PDT)
Message-ID: <0b818707-4762-c12d-8624-7d3c4f6841da@gmail.com>
Date:   Thu, 20 Jul 2023 21:23:20 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/12] rust: init: add `{pin_}chain` functions to
 `{Pin}Init<T, E>`
Content-Language: en-US
To:     Benno Lossin <benno.lossin@proton.me>,
        Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>
Cc:     Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Andreas Hindborg <nmi@metaspace.dk>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Asahi Lina <lina@asahilina.net>
References: <20230719141918.543938-1-benno.lossin@proton.me>
 <20230719141918.543938-12-benno.lossin@proton.me>
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20230719141918.543938-12-benno.lossin@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/19/23 11:21, Benno Lossin wrote:
> The `{pin_}chain` functions extend an initializer: it not only
> initializes the value, but also executes a closure taking a reference to
> the initialized value. This allows to do something with a value directly
> after initialization.
> 
> Suggested-by: Asahi Lina <lina@asahilina.net>
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>
> ---
>   rust/kernel/init.rs            | 138 +++++++++++++++++++++++++++++++++
>   rust/kernel/init/__internal.rs |   2 +-
>   2 files changed, 139 insertions(+), 1 deletion(-)
> 
> diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
> index 3c7cd36a424b..3b0df839f64c 100644
> --- a/rust/kernel/init.rs
> +++ b/rust/kernel/init.rs
> @@ -773,6 +773,77 @@ pub unsafe trait PinInit<T: ?Sized, E = Infallible>: Sized {
>       ///   deallocate.
>       /// - `slot` will not move until it is dropped, i.e. it will be pinned.
>       unsafe fn __pinned_init(self, slot: *mut T) -> Result<(), E>;
> +
> +    /// First initializes the value using `self` then calls the function `f` with the initialized
> +    /// value.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```rust
> +    /// # #![allow(clippy::disallowed_names)]
> +    /// use kernel::{types::Opaque, init::pin_init_from_closure};
> +    /// #[repr(C)]
> +    /// struct RawFoo([u8; 16]);
> +    /// extern {
> +    ///     fn init_foo(_: *mut RawFoo);
> +    /// }
> +    ///
> +    /// #[pin_data]
> +    /// struct Foo {
> +    ///     #[pin]
> +    ///     raw: Opaque<RawFoo>,
> +    /// }
> +    ///
> +    /// impl Foo {
> +    ///     fn setup(self: Pin<&mut Self>) {
> +    ///         pr_info!("Setting up foo");
> +    ///     }
> +    /// }
> +    ///
> +    /// let foo = pin_init!(Foo {
> +    ///     raw <- unsafe {
> +    ///         Opaque::ffi_init(|s| {
> +    ///             init_foo(s);
> +    ///         })
> +    ///     },
> +    /// }).pin_chain(|foo| {
> +    ///     foo.setup();
> +    ///     Ok(())
> +    /// });
> +    /// ```
> +    fn pin_chain<F>(self, f: F) -> ChainPinInit<Self, F, T, E>
> +    where
> +        F: FnOnce(Pin<&mut T>) -> Result<(), E>,
> +    {
> +        ChainPinInit(self, f, PhantomData)
> +    }
> +}
> +
> +/// An initializer returned by [`PinInit::pin_chain`].
> +pub struct ChainPinInit<I, F, T: ?Sized, E>(I, F, __internal::Invariant<(E, Box<T>)>);
> +
> +// SAFETY: the `__pinned_init` function is implemented such that it
> +// - returns `Ok(())` on successful initialization,
> +// - returns `Err(err)` on error and in this case `slot` will be dropped.
> +// - considers `slot` pinned.
> +unsafe impl<T: ?Sized, E, I, F> PinInit<T, E> for ChainPinInit<I, F, T, E>
> +where
> +    I: PinInit<T, E>,
> +    F: FnOnce(Pin<&mut T>) -> Result<(), E>,
> +{
> +    unsafe fn __pinned_init(self, slot: *mut T) -> Result<(), E> {
> +        // SAFETY: all requirements fulfilled since this function is `__pinned_init`.
> +        unsafe { self.0.__pinned_init(slot)? };
> +        // SAFETY: The above call initialized `slot` and we still have unique access.
> +        let val = unsafe { &mut *slot };
> +        // SAFETY: `slot` is considered pinned
> +        let val = unsafe { Pin::new_unchecked(val) };
> +        (self.1)(val).map_err(|e| {
> +            // SAFETY: `slot` was initialized above.
> +            unsafe { core::ptr::drop_in_place(slot) };
> +            e

I might stumble upon an error like EAGAIN if I call `pin_chain` but that
means `slot` will be dropped. So my recommendation is to either not drop
the value or detail in `pin_chain`'s doc comment that the closure will
drop on error.

> +        })
> +    }
>   }
>   
>   /// An initializer for `T`.
> @@ -814,6 +885,73 @@ pub unsafe trait Init<T: ?Sized, E = Infallible>: PinInit<T, E> {
>       /// - the caller does not touch `slot` when `Err` is returned, they are only permitted to
>       ///   deallocate.
>       unsafe fn __init(self, slot: *mut T) -> Result<(), E>;
> +
> +    /// First initializes the value using `self` then calls the function `f` with the initialized
> +    /// value.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```rust
> +    /// # #![allow(clippy::disallowed_names)]
> +    /// use kernel::{types::Opaque, init::{self, init_from_closure}};
> +    /// struct Foo {
> +    ///     buf: [u8; 1_000_000],
> +    /// }
> +    ///
> +    /// impl Foo {
> +    ///     fn setup(&mut self) {
> +    ///         pr_info!("Setting up foo");
> +    ///     }
> +    /// }
> +    ///
> +    /// let foo = init!(Foo {
> +    ///     buf <- init::zeroed()
> +    /// }).chain(|foo| {
> +    ///     foo.setup();
> +    ///     Ok(())
> +    /// });
> +    /// ```
> +    fn chain<F>(self, f: F) -> ChainInit<Self, F, T, E>
> +    where
> +        F: FnOnce(&mut T) -> Result<(), E>,
> +    {
> +        ChainInit(self, f, PhantomData)
> +    }
> +}
> +
> +/// An initializer returned by [`Init::chain`].
> +pub struct ChainInit<I, F, T: ?Sized, E>(I, F, __internal::Invariant<(E, Box<T>)>);
> +
> +// SAFETY: the `__init` function is implemented such that it
> +// - returns `Ok(())` on successful initialization,
> +// - returns `Err(err)` on error and in this case `slot` will be dropped.
> +unsafe impl<T: ?Sized, E, I, F> Init<T, E> for ChainInit<I, F, T, E>
> +where
> +    I: Init<T, E>,
> +    F: FnOnce(&mut T) -> Result<(), E>,
> +{
> +    unsafe fn __init(self, slot: *mut T) -> Result<(), E> {
> +        // SAFETY: all requirements fulfilled since this function is `__init`.
> +        unsafe { self.0.__pinned_init(slot)? };
> +        // SAFETY: The above call initialized `slot` and we still have unique access.
> +        (self.1)(unsafe { &mut *slot }).map_err(|e| {
> +            // SAFETY: `slot` was initialized above.
> +            unsafe { core::ptr::drop_in_place(slot) };
> +            e
> +        })
> +    }
> +}
> +
> [...]

Same as above.
