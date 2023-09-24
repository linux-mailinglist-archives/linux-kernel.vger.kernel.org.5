Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9777AC9C4
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 15:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbjIXNid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 09:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbjIXNiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 09:38:18 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F81219B2;
        Sun, 24 Sep 2023 06:37:42 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6910ea9cddbso4196290b3a.0;
        Sun, 24 Sep 2023 06:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695562662; x=1696167462; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vreia5Yjln7K/grcdVqC7UfkRGK1LxKMbc6SYxt0QU0=;
        b=WPvghzGzBdxkcam3dVTY4Vo/6f8EPnqXaLw/kdQ2cY0DWhREXby6q0aR6mHfGFk9WT
         KbWC3JDqCd9y/ROUQzEvPKNOQ8p/ZPb36vEiRBywSyEX+E4QjMjljcnKIo3hFvsEXqgt
         1iQ3qBn/REqJOjH7JANIAL/xUVu24WbIarMZwqGW364TibIMoOO9fwwY54lKBlSuV+dO
         b/EjSPZ+nncLYvjsgibWdPAwkEahALukBVknOYGyLdOs9fdep0Iy2vUuAyZjGDgYIC5k
         /XbWqVm+qAnzsH7MAI6fTTuEeh+LFGwqsmi9HwvTuFg/1XVq+5H9FX9pV1ZDPFSofNDL
         uTNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695562662; x=1696167462;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vreia5Yjln7K/grcdVqC7UfkRGK1LxKMbc6SYxt0QU0=;
        b=dSpU7MOa/5YQYiImtyVZbTXvu69OeiSXuQw2jNCtgm2cCQgs7i3B+xEbSVKwzCsnQn
         e7/BiyL48xNN+NiCXl2INc89eSyS2a4oZwUrHwugD9gDspOewVmdf1iTcWktQjA9I+2w
         mMLyl4vGCazoo+xrdZJcnWcuKTya8rrpqJzpGQpPKAEHVnxUfYJcz/qeIaTaof7sKFzS
         oqAvxClbO3bzWo0ht5rXvCwEvuGtQSb9LEMLb5CaRpjnBdHKk/2dhox6iCo095SxJ83D
         JUURK0eXFVUSyh3NnXtLFPgt8K53UbkRbJU7RTB47PRZShxKXIW+5oMRPmap0CAu411L
         gRAQ==
X-Gm-Message-State: AOJu0Yz2QhClE11lsYPV5Wde/gjYyNNIj4n1KtkWpTOlKhj82/rQNeCw
        UxhZDfMn+aOUbe0HH9GNrPg9KT5MJ/fh+g==
X-Google-Smtp-Source: AGHT+IFfMMgZ0yBeNcDTNMuSgnhA0HP2icfopWWQaMtT8OtMwBpd543Bf5yO/1x0I2wBZvAk5dQjfg==
X-Received: by 2002:a05:6a00:23d3:b0:690:2ecd:a593 with SMTP id g19-20020a056a0023d300b006902ecda593mr5881424pfc.26.1695562661563;
        Sun, 24 Sep 2023 06:37:41 -0700 (PDT)
Received: from localhost ([162.243.44.213])
        by smtp.gmail.com with ESMTPSA id bu20-20020a632954000000b0057c29fec795sm5934434pgb.37.2023.09.24.06.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Sep 2023 06:37:41 -0700 (PDT)
Date:   Sun, 24 Sep 2023 21:36:37 +0800
From:   Jianguo Bao <roidinev@gmail.com>
To:     Wedson Almeida Filho <wedsonaf@gmail.com>
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>
Subject: Re: [PATCH v2 2/2] rust: arc: remove `ArcBorrow` in favour of
 `WithRef`
Message-ID: <uufcr2fo6amzhm3434nhupqyyf7fyl4zgpp4lc3xfwouv55ukx@6c4r42ehhwwb>
References: <20230923144938.219517-1-wedsonaf@gmail.com>
 <20230923144938.219517-3-wedsonaf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230923144938.219517-3-wedsonaf@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
This time i just realize that the `Ref` in WithRef is the refcount, not the reference
in rust . So can we just change the name WithRefC or other to express this 
refcount,not reference.
If we have defined the Ref only mean the refcount already in somewhere such 
as rust doc or have some conventions in rust community before, then omit this suggest.

On Sat, Sep 23, 2023 at 11:49:38AM -0300, Wedson Almeida Filho wrote:
> From: Wedson Almeida Filho <walmeida@microsoft.com>
> 
> With GATs, we don't need a separate type to represent a borrowed object
> with a refcount, we can just use Rust's regular shared borrowing. In
> this case, we use `&WithRef<T>` instead of `ArcBorrow<'_, T>`.
> 
> Co-developed-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> ---
>  rust/kernel/sync.rs     |   2 +-
>  rust/kernel/sync/arc.rs | 134 ++++++++++++----------------------------
>  2 files changed, 39 insertions(+), 97 deletions(-)
> 
> diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
> index d219ee518eff..083494884500 100644
> --- a/rust/kernel/sync.rs
> +++ b/rust/kernel/sync.rs
> @@ -12,7 +12,7 @@
>  pub mod lock;
>  mod locked_by;
>  
> -pub use arc::{Arc, ArcBorrow, UniqueArc};
> +pub use arc::{Arc, UniqueArc, WithRef};
>  pub use condvar::CondVar;
>  pub use lock::{mutex::Mutex, spinlock::SpinLock};
>  pub use locked_by::LockedBy;
> diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> index 86bff1e0002c..a1806e38c37f 100644
> --- a/rust/kernel/sync/arc.rs
> +++ b/rust/kernel/sync/arc.rs
> @@ -105,14 +105,14 @@
>  /// Coercion from `Arc<Example>` to `Arc<dyn MyTrait>`:
>  ///
>  /// ```
> -/// use kernel::sync::{Arc, ArcBorrow};
> +/// use kernel::sync::{Arc, WithRef};
>  ///
>  /// trait MyTrait {
>  ///     // Trait has a function whose `self` type is `Arc<Self>`.
>  ///     fn example1(self: Arc<Self>) {}
>  ///
> -///     // Trait has a function whose `self` type is `ArcBorrow<'_, Self>`.
> -///     fn example2(self: ArcBorrow<'_, Self>) {}
> +///     // Trait has a function whose `self` type is `&WithRef<Self>`.
> +///     fn example2(self: &WithRef<Self>) {}
>  /// }
>  ///
>  /// struct Example;
> @@ -130,13 +130,6 @@ pub struct Arc<T: ?Sized> {
>      _p: PhantomData<WithRef<T>>,
>  }
>  
> -#[pin_data]
> -#[repr(C)]
> -struct WithRef<T: ?Sized> {
> -    refcount: Opaque<bindings::refcount_t>,
> -    data: T,
> -}
> -
>  // This is to allow [`Arc`] (and variants) to be used as the type of `self`.
>  impl<T: ?Sized> core::ops::Receiver for Arc<T> {}
>  
> @@ -215,16 +208,16 @@ unsafe fn from_inner(inner: NonNull<WithRef<T>>) -> Self {
>          }
>      }
>  
> -    /// Returns an [`ArcBorrow`] from the given [`Arc`].
> +    /// Returns a shared reference to a [`WithRef`] the given [`Arc`].

       /// Returns a shared reference to a [`WithRef`] from  the given [`Arc`].
    or 
       /// Returns a borrowed arc [`&WithRef`] from  the given [`Arc`].
    ?

>      ///
> -    /// This is useful when the argument of a function call is an [`ArcBorrow`] (e.g., in a method
> -    /// receiver), but we have an [`Arc`] instead. Getting an [`ArcBorrow`] is free when optimised.
> +    /// This is useful when the argument of a function call is a [`WithRef`] (e.g., in a method
> +    /// receiver), but we have an [`Arc`] instead. Getting a [`WithRef`] is free when optimised.
>      #[inline]
> -    pub fn as_arc_borrow(&self) -> ArcBorrow<'_, T> {
> +    pub fn as_with_ref(&self) -> &WithRef<T> {
>          // SAFETY: The constraint that the lifetime of the shared reference must outlive that of
> -        // the returned `ArcBorrow` ensures that the object remains alive and that no mutable
> +        // the returned `WithRef` ensures that the object remains alive and that no mutable
>          // reference can be created.
> -        unsafe { ArcBorrow::new(self.ptr) }
> +        unsafe { self.ptr.as_ref() }
>      }
>  
>      /// Compare whether two [`Arc`] pointers reference the same underlying object.
> @@ -234,20 +227,17 @@ pub fn ptr_eq(this: &Self, other: &Self) -> bool {
>  }
>  
>  impl<T: 'static> ForeignOwnable for Arc<T> {
> -    type Borrowed<'a> = ArcBorrow<'a, T>;
> +    type Borrowed<'a> = &'a WithRef<T>;
>  
>      fn into_foreign(self) -> *const core::ffi::c_void {
>          ManuallyDrop::new(self).ptr.as_ptr() as _
>      }
>  
> -    unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> ArcBorrow<'a, T> {
> +    unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> &'a WithRef<T> {
>          // SAFETY: By the safety requirement of this function, we know that `ptr` came from
> -        // a previous call to `Arc::into_foreign`.
> -        let inner = NonNull::new(ptr as *mut WithRef<T>).unwrap();
> -
> -        // SAFETY: The safety requirements of `from_foreign` ensure that the object remains alive
> -        // for the lifetime of the returned value.
> -        unsafe { ArcBorrow::new(inner) }
> +        // a previous call to `Arc::into_foreign`. The safety requirements of `from_foreign` ensure
> +        // that the object remains alive for the lifetime of the returned value.
> +        unsafe { &*(ptr.cast::<WithRef<T>>()) }
>      }
>  
>      unsafe fn from_foreign(ptr: *const core::ffi::c_void) -> Self {
> @@ -320,119 +310,71 @@ fn from(item: Pin<UniqueArc<T>>) -> Self {
>      }
>  }
>  
> -/// A borrowed reference to an [`Arc`] instance.
> -///
> -/// For cases when one doesn't ever need to increment the refcount on the allocation, it is simpler
> -/// to use just `&T`, which we can trivially get from an `Arc<T>` instance.
> +/// An instance of `T` with an attached reference count.
>  ///
> -/// However, when one may need to increment the refcount, it is preferable to use an `ArcBorrow<T>`
> -/// over `&Arc<T>` because the latter results in a double-indirection: a pointer (shared reference)
> -/// to a pointer (`Arc<T>`) to the object (`T`). An [`ArcBorrow`] eliminates this double
> -/// indirection while still allowing one to increment the refcount and getting an `Arc<T>` when/if
> -/// needed.
> -///
> -/// # Invariants
> -///
> -/// There are no mutable references to the underlying [`Arc`], and it remains valid for the
> -/// lifetime of the [`ArcBorrow`] instance.
> -///
> -/// # Example
> +/// # Examples
>  ///
>  /// ```
> -/// use kernel::sync::{Arc, ArcBorrow};
> +/// use kernel::sync::{Arc, WithRef};
>  ///
>  /// struct Example;
>  ///
> -/// fn do_something(e: ArcBorrow<'_, Example>) -> Arc<Example> {
> +/// fn do_something(e: &WithRef<Example>) -> Arc<Example> {
>  ///     e.into()
>  /// }
>  ///
>  /// let obj = Arc::try_new(Example)?;
> -/// let cloned = do_something(obj.as_arc_borrow());
> +/// let cloned = do_something(obj.as_with_ref());
>  ///
>  /// // Assert that both `obj` and `cloned` point to the same underlying object.
>  /// assert!(core::ptr::eq(&*obj, &*cloned));
> -/// # Ok::<(), Error>(())
>  /// ```
>  ///
> -/// Using `ArcBorrow<T>` as the type of `self`:
> +/// Using `WithRef<T>` as the type of `self`:
>  ///
>  /// ```
> -/// use kernel::sync::{Arc, ArcBorrow};
> +/// use kernel::sync::{Arc, WithRef};
>  ///
>  /// struct Example {
> -///     a: u32,
> -///     b: u32,
> +///     _a: u32,
> +///     _b: u32,
>  /// }
>  ///
>  /// impl Example {
> -///     fn use_reference(self: ArcBorrow<'_, Self>) {
> +///     fn use_reference(self: &WithRef<Self>) {
>  ///         // ...
>  ///     }
>  /// }
>  ///
> -/// let obj = Arc::try_new(Example { a: 10, b: 20 })?;
> -/// obj.as_arc_borrow().use_reference();
> -/// # Ok::<(), Error>(())
> +/// let obj = Arc::try_new(Example { _a: 10, _b: 20 })?;
> +/// obj.as_with_ref().use_reference();
>  /// ```
> -pub struct ArcBorrow<'a, T: ?Sized + 'a> {
> -    inner: NonNull<WithRef<T>>,
> -    _p: PhantomData<&'a ()>,
> -}
> -
> -// This is to allow [`ArcBorrow`] (and variants) to be used as the type of `self`.
> -impl<T: ?Sized> core::ops::Receiver for ArcBorrow<'_, T> {}
> -
> -// This is to allow `ArcBorrow<U>` to be dispatched on when `ArcBorrow<T>` can be coerced into
> -// `ArcBorrow<U>`.
> -impl<T: ?Sized + Unsize<U>, U: ?Sized> core::ops::DispatchFromDyn<ArcBorrow<'_, U>>
> -    for ArcBorrow<'_, T>
> -{
> -}
> -
> -impl<T: ?Sized> Clone for ArcBorrow<'_, T> {
> -    fn clone(&self) -> Self {
> -        *self
> -    }
> +#[pin_data]
> +#[repr(C)]
> +pub struct WithRef<T: ?Sized> {
> +    refcount: Opaque<bindings::refcount_t>,
> +    data: T,
>  }
>  
> -impl<T: ?Sized> Copy for ArcBorrow<'_, T> {}
> -
> -impl<T: ?Sized> ArcBorrow<'_, T> {
> -    /// Creates a new [`ArcBorrow`] instance.
> -    ///
> -    /// # Safety
> -    ///
> -    /// Callers must ensure the following for the lifetime of the returned [`ArcBorrow`] instance:
> -    /// 1. That `inner` remains valid;
> -    /// 2. That no mutable references to `inner` are created.
> -    unsafe fn new(inner: NonNull<WithRef<T>>) -> Self {
> -        // INVARIANT: The safety requirements guarantee the invariants.
> -        Self {
> -            inner,
> -            _p: PhantomData,
> -        }
> -    }
> -}
> +// This is to allow [`WithRef`] (and variants) to be used as the type of `self`.
> +impl<T: ?Sized> core::ops::Receiver for WithRef<T> {}
>  
> -impl<T: ?Sized> From<ArcBorrow<'_, T>> for Arc<T> {
> -    fn from(b: ArcBorrow<'_, T>) -> Self {
> +impl<T: ?Sized> From<&WithRef<T>> for Arc<T> {
> +    fn from(b: &WithRef<T>) -> Self {
>          // SAFETY: The existence of `b` guarantees that the refcount is non-zero. `ManuallyDrop`
>          // guarantees that `drop` isn't called, so it's ok that the temporary `Arc` doesn't own the
>          // increment.
> -        ManuallyDrop::new(unsafe { Arc::from_inner(b.inner) })
> +        ManuallyDrop::new(unsafe { Arc::from_inner(b.into()) })
>              .deref()
>              .clone()
>      }
>  }
>  
> -impl<T: ?Sized> Deref for ArcBorrow<'_, T> {
> +impl<T: ?Sized> Deref for WithRef<T> {
>      type Target = T;
>  
>      fn deref(&self) -> &Self::Target {
> -        // SAFETY: By the type invariant, the underlying object is still alive with no mutable
> -        // references to it, so it is safe to create a shared reference.
> -        unsafe { &self.inner.as_ref().data }
> +        &self.data
>      }
>  }
>  
> -- 
> 2.34.1
> 
