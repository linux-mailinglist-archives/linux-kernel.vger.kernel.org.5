Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCCDA7AC297
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 16:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbjIWONJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 10:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231307AbjIWONH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 10:13:07 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 030059E;
        Sat, 23 Sep 2023 07:13:00 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-d81d09d883dso4226392276.0;
        Sat, 23 Sep 2023 07:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695478379; x=1696083179; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=I27QSkJfyuEvUa4n1zGSchXIF6bDq2xv+lKsYDTk2zk=;
        b=VRhcd8lMPjvpl6/P/4Zql1FSa3ViHDbMxyYhfns7H4Bsn2nlMhSdc+w++OEc9yue5X
         rhSfjdYM87IaYjlBA+xZTBH82AFuWpZUmKBuZNXyUrF8ew8EjgCrPMrx8xzTEdwXX81x
         lPwTPA1dvRF9G6DgJ54kaXZN9TQ+kM6RtpQzzu/yrUs/acb1zytCC9+oWu8OyJXx8fuv
         PMu3yBDd5uUd8XosLslY9zkhxG4GBSTvtqucLzJRgeAUOJcLkktDEDy9o/uR1PrFqNf5
         Oym6D8Uuo5QT9E52fGS9rKvzNmokRB47E0c+Bh51EkWSexsOt7j7163Ry2UxtnoHpqe+
         /wag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695478379; x=1696083179;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I27QSkJfyuEvUa4n1zGSchXIF6bDq2xv+lKsYDTk2zk=;
        b=t3GbOdB3NeKWqcCv7Kl27wi6+Xmwj0bhIzCtU5EDJlzP0+HeJflw6A5X2CRMaBqKTU
         +p4b+2f/c9jK0+/ffGA8jy9HUvzE/oqLQMUlrFuEfW6gxi6QdG8jhcDY3Dx0rlayAjrg
         Y2RFPr4Ke3SdsNVjsG2PZXyLsl0JWSA+zF7qSGCZDbWYfLeRAjAib62VK2VzerTjsWqg
         TLmG869KRoAuVpD2DW/2dQm8wXh7H4g22zK5Sj19EViDhlpvB+mRNtHT0wuz40bjsGAP
         LS3o2AnU+sgpdvQacO9qVk13ZAw4m1oRlbmp5RRYXEqLT165NsgVuW7d/ltaY+Mz34eb
         EZOw==
X-Gm-Message-State: AOJu0Yzs0Cel/3g7FIljixTTgtPHaoHs3dCCWzsw53I5Q66ncbeVmDQp
        UNFvl9IGFG9X78xH1M0RmWvqt4DaPonqYtbEq3Y=
X-Google-Smtp-Source: AGHT+IHoeONm9mXnNIIWfqHVR5rbozlBnT+ern3ts2eGCC+APcPjoNV2NrUTMNzHWDhkjzOv5Y66Mw+cOiRscQqIPZ4=
X-Received: by 2002:a25:6881:0:b0:d15:e204:a7be with SMTP id
 d123-20020a256881000000b00d15e204a7bemr1918154ybc.8.1695478378988; Sat, 23
 Sep 2023 07:12:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230921213440.202017-1-wedsonaf@gmail.com> <20230921213440.202017-3-wedsonaf@gmail.com>
 <x2zddticeo7gpnq62bxwzdpeckkzenfl2efuh2t3dpgsbmvq3x@6yoc7om5nxa5>
In-Reply-To: <x2zddticeo7gpnq62bxwzdpeckkzenfl2efuh2t3dpgsbmvq3x@6yoc7om5nxa5>
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
Date:   Sat, 23 Sep 2023 11:12:48 -0300
Message-ID: <CANeycqpdhG8Yw+fUMy_bf8sq9=AC6uPdKcWo9yw0LX83f7yE5g@mail.gmail.com>
Subject: Re: [PATCH 2/2] rust: arc: remove `ArcBorrow` in favour of `WithRef`
To:     Jianguo Bao <roidinev@gmail.com>
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Sept 2023 at 02:17, Jianguo Bao <roidinev@gmail.com> wrote:
>
> On Thu, Sep 21, 2023 at 06:34:40PM -0300, Wedson Almeida Filho wrote:
> > From: Wedson Almeida Filho <walmeida@microsoft.com>
> >
> > With GATs, we don't need a separate type to represent a borrowed object
> > with a refcount, we can just use Rust's regular shared borrowing. In
> > this case, we use `&WithRef<T>` instead of `ArcBorrow<'_, T>`.
> >
> > Co-developed-by: Boqun Feng <boqun.feng@gmail.com>
> > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> > Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> > ---
> >  rust/kernel/sync.rs     |   2 +-
> >  rust/kernel/sync/arc.rs | 180 ++++++++++++++--------------------------
> >  2 files changed, 62 insertions(+), 120 deletions(-)
> >
> > diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
> > index d219ee518eff..083494884500 100644
> > --- a/rust/kernel/sync.rs
> > +++ b/rust/kernel/sync.rs
> > @@ -12,7 +12,7 @@
> >  pub mod lock;
> >  mod locked_by;
> >
> > -pub use arc::{Arc, ArcBorrow, UniqueArc};
> > +pub use arc::{Arc, UniqueArc, WithRef};
> >  pub use condvar::CondVar;
> >  pub use lock::{mutex::Mutex, spinlock::SpinLock};
> >  pub use locked_by::LockedBy;
> > diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> > index 86bff1e0002c..5948e42b9c8f 100644
> > --- a/rust/kernel/sync/arc.rs
> > +++ b/rust/kernel/sync/arc.rs
> > @@ -105,14 +105,14 @@
> >  /// Coercion from `Arc<Example>` to `Arc<dyn MyTrait>`:
> >  ///
> >  /// ```
> > -/// use kernel::sync::{Arc, ArcBorrow};
> > +/// use kernel::sync::{Arc, WithRef};
> >  ///
> >  /// trait MyTrait {
> >  ///     // Trait has a function whose `self` type is `Arc<Self>`.
> >  ///     fn example1(self: Arc<Self>) {}
> >  ///
> > -///     // Trait has a function whose `self` type is `ArcBorrow<'_, Self>`.
> > -///     fn example2(self: ArcBorrow<'_, Self>) {}
> > +///     // Trait has a function whose `self` type is `&WithRef<Self>`.
> > +///     fn example2(self: &WithRef<Self>) {}
> >  /// }
> >  ///
> >  /// struct Example;
> > @@ -130,9 +130,48 @@ pub struct Arc<T: ?Sized> {
> >      _p: PhantomData<WithRef<T>>,
> >  }
> >
> > +/// An instance of `T` with an attached reference count.
> > +///
> > +/// # Examples
> > +///
> > +/// ```
> > +/// use kernel::sync::{Arc, WithRef};
> > +///
> > +/// struct Example;
> > +///
> > +/// fn do_something(e: &WithRef<Example>) -> Arc<Example> {
> > +///     e.into()
> > +/// }
> > +///
> > +/// let obj = Arc::try_new(Example)?;
> > +/// let cloned = do_something(obj.as_with_ref());
> > +///
> > +/// // Assert that both `obj` and `cloned` point to the same underlying object.
> > +/// assert!(core::ptr::eq(&*obj, &*cloned));
> > +/// ```
> > +///
> > +/// Using `WithRef<T>` as the type of `self`:
> > +///
> > +/// ```
> > +/// use kernel::sync::{Arc, WithRef};
> > +///
> > +/// struct Example {
> > +///     _a: u32,
> > +///     _b: u32,
> > +/// }
> > +///
> > +/// impl Example {
> > +///     fn use_reference(self: &WithRef<Self>) {
> > +///         // ...
> > +///     }
> > +/// }
> > +///
> > +/// let obj = Arc::try_new(Example { _a: 10, _b: 20 })?;
> > +/// obj.as_with_ref().use_reference();
> > +/// ```
> >  #[pin_data]
> >  #[repr(C)]
> > -struct WithRef<T: ?Sized> {
> > +pub struct WithRef<T: ?Sized> {
> >      refcount: Opaque<bindings::refcount_t>,
> >      data: T,
> >  }
> > @@ -215,16 +254,16 @@ unsafe fn from_inner(inner: NonNull<WithRef<T>>) -> Self {
> >          }
> >      }
> >
> > -    /// Returns an [`ArcBorrow`] from the given [`Arc`].
> > +    /// Returns a [`WithRef`] from the given [`Arc`].
>
>        /// Returns a shared reference of [`WithRef`] from the given [`Arc`].

Thanks Jianguo.. I'll make this change in v2.

> >      ///
> > -    /// This is useful when the argument of a function call is an [`ArcBorrow`] (e.g., in a method
> > -    /// receiver), but we have an [`Arc`] instead. Getting an [`ArcBorrow`] is free when optimised.
> > +    /// This is useful when the argument of a function call is a [`WithRef`] (e.g., in a method
> > +    /// receiver), but we have an [`Arc`] instead. Getting a [`WithRef`] is free when optimised.
> >      #[inline]
> > -    pub fn as_arc_borrow(&self) -> ArcBorrow<'_, T> {
> > +    pub fn as_with_ref(&self) -> &WithRef<T> {
> >          // SAFETY: The constraint that the lifetime of the shared reference must outlive that of
> > -        // the returned `ArcBorrow` ensures that the object remains alive and that no mutable
> > +        // the returned `WithRef` ensures that the object remains alive and that no mutable
> >          // reference can be created.
> > -        unsafe { ArcBorrow::new(self.ptr) }
> > +        unsafe { self.ptr.as_ref() }
> >      }
> >
> >      /// Compare whether two [`Arc`] pointers reference the same underlying object.
> > @@ -234,20 +273,17 @@ pub fn ptr_eq(this: &Self, other: &Self) -> bool {
> >  }
> >
> >  impl<T: 'static> ForeignOwnable for Arc<T> {
> > -    type Borrowed<'a> = ArcBorrow<'a, T>;
> > +    type Borrowed<'a> = &'a WithRef<T>;
> >
> >      fn into_foreign(self) -> *const core::ffi::c_void {
> >          ManuallyDrop::new(self).ptr.as_ptr() as _
> >      }
> >
> > -    unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> ArcBorrow<'a, T> {
> > +    unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> &'a WithRef<T> {
> >          // SAFETY: By the safety requirement of this function, we know that `ptr` came from
> > -        // a previous call to `Arc::into_foreign`.
> > -        let inner = NonNull::new(ptr as *mut WithRef<T>).unwrap();
> > -
> > -        // SAFETY: The safety requirements of `from_foreign` ensure that the object remains alive
> > -        // for the lifetime of the returned value.
> > -        unsafe { ArcBorrow::new(inner) }
> > +        // a previous call to `Arc::into_foreign`. The safety requirements of `from_foreign` ensure
> > +        // that the object remains alive for the lifetime of the returned value.
> > +        unsafe { &*(ptr.cast::<WithRef<T>>()) }
> >      }
> >
> >      unsafe fn from_foreign(ptr: *const core::ffi::c_void) -> Self {
> > @@ -320,119 +356,25 @@ fn from(item: Pin<UniqueArc<T>>) -> Self {
> >      }
> >  }
> >
> > -/// A borrowed reference to an [`Arc`] instance.
> > -///
> > -/// For cases when one doesn't ever need to increment the refcount on the allocation, it is simpler
> > -/// to use just `&T`, which we can trivially get from an `Arc<T>` instance.
> > -///
> > -/// However, when one may need to increment the refcount, it is preferable to use an `ArcBorrow<T>`
> > -/// over `&Arc<T>` because the latter results in a double-indirection: a pointer (shared reference)
> > -/// to a pointer (`Arc<T>`) to the object (`T`). An [`ArcBorrow`] eliminates this double
> > -/// indirection while still allowing one to increment the refcount and getting an `Arc<T>` when/if
> > -/// needed.
> > -///
> > -/// # Invariants
> > -///
> > -/// There are no mutable references to the underlying [`Arc`], and it remains valid for the
> > -/// lifetime of the [`ArcBorrow`] instance.
> > -///
> > -/// # Example
> > -///
> > -/// ```
> > -/// use kernel::sync::{Arc, ArcBorrow};
> > -///
> > -/// struct Example;
> > -///
> > -/// fn do_something(e: ArcBorrow<'_, Example>) -> Arc<Example> {
> > -///     e.into()
> > -/// }
> > -///
> > -/// let obj = Arc::try_new(Example)?;
> > -/// let cloned = do_something(obj.as_arc_borrow());
> > -///
> > -/// // Assert that both `obj` and `cloned` point to the same underlying object.
> > -/// assert!(core::ptr::eq(&*obj, &*cloned));
> > -/// # Ok::<(), Error>(())
> > -/// ```
> > -///
> > -/// Using `ArcBorrow<T>` as the type of `self`:
> > -///
> > -/// ```
> > -/// use kernel::sync::{Arc, ArcBorrow};
> > -///
> > -/// struct Example {
> > -///     a: u32,
> > -///     b: u32,
> > -/// }
> > -///
> > -/// impl Example {
> > -///     fn use_reference(self: ArcBorrow<'_, Self>) {
> > -///         // ...
> > -///     }
> > -/// }
> > -///
> > -/// let obj = Arc::try_new(Example { a: 10, b: 20 })?;
> > -/// obj.as_arc_borrow().use_reference();
> > -/// # Ok::<(), Error>(())
> > -/// ```
> > -pub struct ArcBorrow<'a, T: ?Sized + 'a> {
> > -    inner: NonNull<WithRef<T>>,
> > -    _p: PhantomData<&'a ()>,
> > -}
> > -
> > -// This is to allow [`ArcBorrow`] (and variants) to be used as the type of `self`.
> > -impl<T: ?Sized> core::ops::Receiver for ArcBorrow<'_, T> {}
> > -
> > -// This is to allow `ArcBorrow<U>` to be dispatched on when `ArcBorrow<T>` can be coerced into
> > -// `ArcBorrow<U>`.
> > -impl<T: ?Sized + Unsize<U>, U: ?Sized> core::ops::DispatchFromDyn<ArcBorrow<'_, U>>
> > -    for ArcBorrow<'_, T>
> > -{
> > -}
> > -
> > -impl<T: ?Sized> Clone for ArcBorrow<'_, T> {
> > -    fn clone(&self) -> Self {
> > -        *self
> > -    }
> > -}
> > -
> > -impl<T: ?Sized> Copy for ArcBorrow<'_, T> {}
> > -
> > -impl<T: ?Sized> ArcBorrow<'_, T> {
> > -    /// Creates a new [`ArcBorrow`] instance.
> > -    ///
> > -    /// # Safety
> > -    ///
> > -    /// Callers must ensure the following for the lifetime of the returned [`ArcBorrow`] instance:
> > -    /// 1. That `inner` remains valid;
> > -    /// 2. That no mutable references to `inner` are created.
> > -    unsafe fn new(inner: NonNull<WithRef<T>>) -> Self {
> > -        // INVARIANT: The safety requirements guarantee the invariants.
> > -        Self {
> > -            inner,
> > -            _p: PhantomData,
> > -        }
> > -    }
> > -}
> > +// This is to allow [`WithRef`] (and variants) to be used as the type of `self`.
> > +impl<T: ?Sized> core::ops::Receiver for WithRef<T> {}
> >
> > -impl<T: ?Sized> From<ArcBorrow<'_, T>> for Arc<T> {
> > -    fn from(b: ArcBorrow<'_, T>) -> Self {
> > +impl<T: ?Sized> From<&WithRef<T>> for Arc<T> {
> > +    fn from(b: &WithRef<T>) -> Self {
> >          // SAFETY: The existence of `b` guarantees that the refcount is non-zero. `ManuallyDrop`
> >          // guarantees that `drop` isn't called, so it's ok that the temporary `Arc` doesn't own the
> >          // increment.
> > -        ManuallyDrop::new(unsafe { Arc::from_inner(b.inner) })
> > +        ManuallyDrop::new(unsafe { Arc::from_inner(b.into()) })
> >              .deref()
> >              .clone()
> >      }
> >  }
> >
> > -impl<T: ?Sized> Deref for ArcBorrow<'_, T> {
> > +impl<T: ?Sized> Deref for WithRef<T> {
> >      type Target = T;
> >
> >      fn deref(&self) -> &Self::Target {
> > -        // SAFETY: By the type invariant, the underlying object is still alive with no mutable
> > -        // references to it, so it is safe to create a shared reference.
> > -        unsafe { &self.inner.as_ref().data }
> > +        &self.data
> >      }
> >  }
> >
> > --
> > 2.34.1
> >
