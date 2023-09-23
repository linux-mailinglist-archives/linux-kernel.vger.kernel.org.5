Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBDC87AC28F
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 16:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbjIWOB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 10:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjIWOBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 10:01:25 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C9E819F;
        Sat, 23 Sep 2023 07:01:18 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-d85800eb234so4118574276.0;
        Sat, 23 Sep 2023 07:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695477678; x=1696082478; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LY3Ph9x6pWQb69i1+N/rSHqRZP4MX+dDBpge1hAwHaQ=;
        b=YYLwik+2r9cb6AmSOBULWdCYUyAy5PPAWnuHoLRAbF4xaCy9q7Rc5OkNqX+CmYVhBY
         EC8RlXoBA8MM+pt++0K37lPpFWw81VSZPTdDuPeyvaely/97uZzpj5+D9CNjCikwWxVV
         ZFpv7ym2fA1RQwnv/IegU7Bw8Vz9q4YrzJiCnckgbHoWTfvsW4qD29zL+7HgHkvbRsgX
         Fhcdxu3pEnDBKCOcaKs3nduWLz7vWMUAjx5hCKXyk7BvLBh/mRaOjMzh+ndM+03rU2V/
         FYXr46KJE8rsG1SepW8DwGlpbcWsCiEtMWRNynhtA7UQHkbz10TwjC69NG9prmbOXJD+
         mMiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695477678; x=1696082478;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LY3Ph9x6pWQb69i1+N/rSHqRZP4MX+dDBpge1hAwHaQ=;
        b=bgvWOrV0lSNe9oGVMBsCITSkrdLzJJJLa5sQfvvBQ7ymUNrTJ3lGSfcLiplDOd+1v9
         wJluCz2AKGFpVh+M5bqVbeU5diFPG2oN0mahD+1fT0b35OmgePXZfILZVZML4B/SQtOK
         TkzoC/+n0q7GrW55qKal8sZPzMi2z7KFnHHd6RE0SvRySeLwxbBeB5hX6XTnzolm7flM
         BTivcOa5VLZEre2sFVDUVZtIvV1T7Mc1vr+KBRx3lphaEkxiGx3xQZBpb3V43S3lcMX2
         l3ABGwgh0/mEzw9bJdOprmKcXJvBOYZthTC+PXMxcMOJak2d5reyJrYdzBi04WwdkvI/
         kPoQ==
X-Gm-Message-State: AOJu0YzDbrCxOKYBmwsdoTgJ0XHoQv0rGa6RStdCOsHFnTJcjCRL9sqM
        ryfqywPnjcUVQJ4oIRwfVzcYuHujh4AMtHKCphI=
X-Google-Smtp-Source: AGHT+IGHWk5pPC5D1Lv1UJow7LAO0Lj/VkV4jZ0gut7OVhjLlWARbqy2uZbal5a4NZwoCt//+lH24qJlEHfGyMsHVIU=
X-Received: by 2002:a25:e087:0:b0:d81:65a9:ac6d with SMTP id
 x129-20020a25e087000000b00d8165a9ac6dmr2541416ybg.37.1695477677564; Sat, 23
 Sep 2023 07:01:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230921213440.202017-1-wedsonaf@gmail.com> <20230921213440.202017-3-wedsonaf@gmail.com>
 <63223594-1bbe-c4f2-ea82-9b34c66ba1f6@proton.me>
In-Reply-To: <63223594-1bbe-c4f2-ea82-9b34c66ba1f6@proton.me>
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
Date:   Sat, 23 Sep 2023 11:01:05 -0300
Message-ID: <CANeycqrpCaQpSJVS2wJ0Mx3eF0PUor25Y9tNc9=6u+yt0qqLcg@mail.gmail.com>
Subject: Re: [PATCH 2/2] rust: arc: remove `ArcBorrow` in favour of `WithRef`
To:     Benno Lossin <benno.lossin@proton.me>
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
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

On Fri, 22 Sept 2023 at 05:53, Benno Lossin <benno.lossin@proton.me> wrote:
>
> On 21.09.23 23:34, Wedson Almeida Filho wrote:
> > From: Wedson Almeida Filho <walmeida@microsoft.com>
> >
> > With GATs, we don't need a separate type to represent a borrowed object
> > with a refcount, we can just use Rust's regular shared borrowing. In
> > this case, we use `&WithRef<T>` instead of `ArcBorrow<'_, T>`.
> >
> > Co-developed-by: Boqun Feng <boqun.feng@gmail.com>
> > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> > Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
>
> I only have a very small comment below, so
>
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>
>
> > ---
> >   rust/kernel/sync.rs     |   2 +-
> >   rust/kernel/sync/arc.rs | 180 ++++++++++++++--------------------------
> >   2 files changed, 62 insertions(+), 120 deletions(-)
> >
> > diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
> > index d219ee518eff..083494884500 100644
> > --- a/rust/kernel/sync.rs
> > +++ b/rust/kernel/sync.rs
> > @@ -12,7 +12,7 @@
> >   pub mod lock;
> >   mod locked_by;
> >
> > -pub use arc::{Arc, ArcBorrow, UniqueArc};
> > +pub use arc::{Arc, UniqueArc, WithRef};
> >   pub use condvar::CondVar;
> >   pub use lock::{mutex::Mutex, spinlock::SpinLock};
> >   pub use locked_by::LockedBy;
> > diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> > index 86bff1e0002c..5948e42b9c8f 100644
> > --- a/rust/kernel/sync/arc.rs
> > +++ b/rust/kernel/sync/arc.rs
> > @@ -105,14 +105,14 @@
> >   /// Coercion from `Arc<Example>` to `Arc<dyn MyTrait>`:
> >   ///
> >   /// ```
> > -/// use kernel::sync::{Arc, ArcBorrow};
> > +/// use kernel::sync::{Arc, WithRef};
> >   ///
> >   /// trait MyTrait {
> >   ///     // Trait has a function whose `self` type is `Arc<Self>`.
> >   ///     fn example1(self: Arc<Self>) {}
> >   ///
> > -///     // Trait has a function whose `self` type is `ArcBorrow<'_, Self>`.
> > -///     fn example2(self: ArcBorrow<'_, Self>) {}
> > +///     // Trait has a function whose `self` type is `&WithRef<Self>`.
> > +///     fn example2(self: &WithRef<Self>) {}
> >   /// }
> >   ///
> >   /// struct Example;
> > @@ -130,9 +130,48 @@ pub struct Arc<T: ?Sized> {
> >       _p: PhantomData<WithRef<T>>,
> >   }
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
> >   #[pin_data]
> >   #[repr(C)]
> > -struct WithRef<T: ?Sized> {
> > +pub struct WithRef<T: ?Sized> {
> >       refcount: Opaque<bindings::refcount_t>,
> >       data: T,
> >   }
>
> I do not really like the position of this definition in this file.
> It should be further down with the other code (like the
> `impl<T: ?Sized> From<&WithRef<T>> for Arc<T>`).

Yeah, I think it was ok originally because it was just a private
standalone auxiliary type. Since this is not the case anymore, it's
probably better to move it down. Will do for v2.

> > @@ -215,16 +254,16 @@ unsafe fn from_inner(inner: NonNull<WithRef<T>>) -> Self {
> >           }
> >       }
> >
> > -    /// Returns an [`ArcBorrow`] from the given [`Arc`].
> > +    /// Returns a [`WithRef`] from the given [`Arc`].
> >       ///
> > -    /// This is useful when the argument of a function call is an [`ArcBorrow`] (e.g., in a method
> > -    /// receiver), but we have an [`Arc`] instead. Getting an [`ArcBorrow`] is free when optimised.
> > +    /// This is useful when the argument of a function call is a [`WithRef`] (e.g., in a method
> > +    /// receiver), but we have an [`Arc`] instead. Getting a [`WithRef`] is free when optimised.
> >       #[inline]
> > -    pub fn as_arc_borrow(&self) -> ArcBorrow<'_, T> {
> > +    pub fn as_with_ref(&self) -> &WithRef<T> {
> >           // SAFETY: The constraint that the lifetime of the shared reference must outlive that of
> > -        // the returned `ArcBorrow` ensures that the object remains alive and that no mutable
> > +        // the returned `WithRef` ensures that the object remains alive and that no mutable
> >           // reference can be created.
> > -        unsafe { ArcBorrow::new(self.ptr) }
> > +        unsafe { self.ptr.as_ref() }
> >       }
> >
> >       /// Compare whether two [`Arc`] pointers reference the same underlying object.
> > @@ -234,20 +273,17 @@ pub fn ptr_eq(this: &Self, other: &Self) -> bool {
> >   }
> >
> >   impl<T: 'static> ForeignOwnable for Arc<T> {
> > -    type Borrowed<'a> = ArcBorrow<'a, T>;
> > +    type Borrowed<'a> = &'a WithRef<T>;
> >
> >       fn into_foreign(self) -> *const core::ffi::c_void {
> >           ManuallyDrop::new(self).ptr.as_ptr() as _
> >       }
> >
> > -    unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> ArcBorrow<'a, T> {
> > +    unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> &'a WithRef<T> {
> >           // SAFETY: By the safety requirement of this function, we know that `ptr` came from
> > -        // a previous call to `Arc::into_foreign`.
> > -        let inner = NonNull::new(ptr as *mut WithRef<T>).unwrap();
> > -
> > -        // SAFETY: The safety requirements of `from_foreign` ensure that the object remains alive
> > -        // for the lifetime of the returned value.
> > -        unsafe { ArcBorrow::new(inner) }
> > +        // a previous call to `Arc::into_foreign`. The safety requirements of `from_foreign` ensure
> > +        // that the object remains alive for the lifetime of the returned value.
> > +        unsafe { &*(ptr.cast::<WithRef<T>>()) }
> >       }
> >
> >       unsafe fn from_foreign(ptr: *const core::ffi::c_void) -> Self {
> > @@ -320,119 +356,25 @@ fn from(item: Pin<UniqueArc<T>>) -> Self {
> >       }
> >   }
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
>
> I think here would be the correct location. Another option would be
> to move this code up to the definition. I don't think this is important,
> so I can maybe just create an issue and let this be someone's first contribution.
>
> > +// This is to allow [`WithRef`] (and variants) to be used as the type of `self`.
> > +impl<T: ?Sized> core::ops::Receiver for WithRef<T> {}
> >
> > -impl<T: ?Sized> From<ArcBorrow<'_, T>> for Arc<T> {
> > -    fn from(b: ArcBorrow<'_, T>) -> Self {
> > +impl<T: ?Sized> From<&WithRef<T>> for Arc<T> {
> > +    fn from(b: &WithRef<T>) -> Self {
> >           // SAFETY: The existence of `b` guarantees that the refcount is non-zero. `ManuallyDrop`
> >           // guarantees that `drop` isn't called, so it's ok that the temporary `Arc` doesn't own the
> >           // increment.
> > -        ManuallyDrop::new(unsafe { Arc::from_inner(b.inner) })
> > +        ManuallyDrop::new(unsafe { Arc::from_inner(b.into()) })
> >               .deref()
> >               .clone()
> >       }
> >   }
> >
> > -impl<T: ?Sized> Deref for ArcBorrow<'_, T> {
> > +impl<T: ?Sized> Deref for WithRef<T> {
> >       type Target = T;
> >
> >       fn deref(&self) -> &Self::Target {
> > -        // SAFETY: By the type invariant, the underlying object is still alive with no mutable
> > -        // references to it, so it is safe to create a shared reference.
> > -        unsafe { &self.inner.as_ref().data }
> > +        &self.data
> >       }
> >   }
> >
> > --
> > 2.34.1
> >
>
>
