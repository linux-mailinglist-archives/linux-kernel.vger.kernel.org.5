Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 074C77AE1BE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 00:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233082AbjIYWfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 18:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233059AbjIYWfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 18:35:43 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C33120;
        Mon, 25 Sep 2023 15:35:33 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2c108e106f0so125113761fa.1;
        Mon, 25 Sep 2023 15:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695681331; x=1696286131; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0UzaCYvcBs1gMx5NdAE4t7LYfLSUqG/KsQwFf1alrY0=;
        b=NCA1TsoJy7h0GZMlRknnnmbnkxZlh9SIL4/vWrUZQN00YQt56c7WKY7sKQpOwRPvI9
         b0kyaOvKIrVCLkHg7u+I+dtLYdZQ0PeTaMkB3NS2X/bW/Llq8PP0ajBy85aR352xt3Ix
         mm5inp/OEUFUIE42rubpNfqXcjvr2kU2wXE1bFKPvXgRdOK8jTlDaKNo+sIBDdMTxbXb
         sHuE0rXsvrOEcGtRdQK3yTylB94/+9SCfZhvK8ZlNkeuUyDrGsGh4nLVD+rvFCWJ41Mp
         09e0E6s/tp1qeqGtvo0MABbdmdlFpKyREzAhR0x0U9XK9nEX3ASkp/9kAoKuNpc/4WWG
         fHXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695681331; x=1696286131;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0UzaCYvcBs1gMx5NdAE4t7LYfLSUqG/KsQwFf1alrY0=;
        b=ezCCIyANVfznyZ3H3VZJpCkCMG4b7/Q4cBOrgQXcvoIJDVcCQu2n7yUSSmD6s4SSMI
         37aGr8+Fsy2MoLiA6YgNo5sjLFhEgpjjovHlv/JFfg5Dy96BQekZcSVT3PMeP2OPsxpp
         rhqqqdl9LRIr3/feR3XnAXrdGMCiyFyDDxpLSjHaxPrqipQmtJNTypmvnRMKENQJb5fY
         iWG6vG+o3P4HbwicSMo5ivKkI5bkNXAYqXZZMr/O4SqzvB0R1lnl17EmphfNus6Oa5P+
         Hyuv3Z2h3uTMERFIlhrt7J8UuZjULH+G29ZiQPma/hcu8pHB8LcAxkmoTC34h93pOVvZ
         CJlw==
X-Gm-Message-State: AOJu0YxbzsCZ54fXE3QgdMJSbDcxiV3KezivLS8ckBbaTJnf+kPlfXXb
        4d5VLSaRYWXZFzT1jb/3JVk=
X-Google-Smtp-Source: AGHT+IF1TJ7XvnriCzgZd/o5zcKpK4XKX/uRmoMsPeAvk6HaDWu6g/GJtlH14AS/+k2ms3WYzlhvMg==
X-Received: by 2002:a2e:3305:0:b0:2bf:ea78:c3b with SMTP id d5-20020a2e3305000000b002bfea780c3bmr7243346ljc.9.1695681331017;
        Mon, 25 Sep 2023 15:35:31 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id l3-20020a170906230300b009932337747esm6921705eja.86.2023.09.25.15.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 15:35:30 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailauth.nyi.internal (Postfix) with ESMTP id A6B6C27C0067;
        Mon, 25 Sep 2023 18:35:28 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 25 Sep 2023 18:35:28 -0400
X-ME-Sender: <xms:MAsSZcRsSkLR5wftSSSwgFaLvpI6x-Qj4Ej3v9pMzx708ITsT_OaHw>
    <xme:MAsSZZyDDpy239aaqNbPqUbKfqcNQxespCo4z1sTH1YT0rWkQYAc74ZsNmxtbBKm9
    eQvolBQywEvAbF0qA>
X-ME-Received: <xmr:MAsSZZ2JnA-v7sVo9FPOqYuCak7YYnC_aG3Ty-xU6N7Cs4n5BivKq8pQ5Q4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudelhedgudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpefhkeduhfefffdvhffhvdethfevfffhfedtfedvheejgeekfedtgefgveff
    hfevkeenucffohhmrghinhepphhtrhdrrghsnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhs
    ohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnh
    hgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:MAsSZQAS6ZAbKvzr605CXwhePZv9n6TxqLFOt-AIHMbweDju3qKung>
    <xmx:MAsSZVhurO3H4-_wtngAx4hapUhcSsZHVr9r4IDzwIK1vBd1zNMiDg>
    <xmx:MAsSZcqnlKfSNhKff4Eul9oKX9UleNNn4dt1BL3NpCklXwoyCZmHUQ>
    <xmx:MAsSZQpBLLyldB4M1kLjwTSuRl8k2RAyrmlcfSd7-0bBm6XCHuDfDw>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Sep 2023 18:35:27 -0400 (EDT)
Date:   Mon, 25 Sep 2023 15:34:56 -0700
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Benno Lossin <benno.lossin@proton.me>
Cc:     Alice Ryhl <alice@ryhl.io>, Alice Ryhl <aliceryhl@google.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>
Subject: Re: [PATCH v2 2/2] rust: arc: remove `ArcBorrow` in favour of
 `WithRef`
Message-ID: <ZRILEIsKW6LsGdfb@boqun-archlinux>
References: <CAH5fLggxsewmtzXjehbawDCTHO0C7kteU_CLnh80eMNj=QyP9Q@mail.gmail.com>
 <14513589-cc31-8985-8ff6-a97d2882f593@proton.me>
 <ZRGyRQuBcWvgtdNR@Boquns-Mac-mini.home>
 <9d6d6c94-5da6-a56d-4e85-fbf8da26a0b0@proton.me>
 <ZRHWqbvYlXBXEOh-@boqun-archlinux>
 <c5134a1a-a60d-73bb-9faa-aa1dfc3bc30d@proton.me>
 <ZRIB0hXNvmJtmyak@boqun-archlinux>
 <edc0b599-c5d1-4e9c-a51b-eb8ceaef7acc@ryhl.io>
 <ZRIDc_x9Qh5EJNC8@boqun-archlinux>
 <61ccfb87-54fd-3f1b-105c-253d0350cd56@proton.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61ccfb87-54fd-3f1b-105c-253d0350cd56@proton.me>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 10:26:56PM +0000, Benno Lossin wrote:
> On 26.09.23 00:02, Boqun Feng wrote:
> > On Mon, Sep 25, 2023 at 11:58:46PM +0200, Alice Ryhl wrote:
> >> On 9/25/23 23:55, Boqun Feng wrote:
> >>> On Mon, Sep 25, 2023 at 09:03:52PM +0000, Benno Lossin wrote:
> >>>> On 25.09.23 20:51, Boqun Feng wrote:
> >>>>> On Mon, Sep 25, 2023 at 05:00:45PM +0000, Benno Lossin wrote:
> >>>>>> On 25.09.23 18:16, Boqun Feng wrote:
> >>>>>>> On Mon, Sep 25, 2023 at 03:07:44PM +0000, Benno Lossin wrote:
> >>>>>>>> ```rust
> >>>>>>>> struct MutatingDrop {
> >>>>>>>>          value: i32,
> >>>>>>>> }
> >>>>>>>>
> >>>>>>>> impl Drop for MutatingDrop {
> >>>>>>>>          fn drop(&mut self) {
> >>>>>>>>              self.value = 0;
> >>>>>>>>          }
> >>>>>>>> }
> >>>>>>>>
> >>>>>>>> let arc = Arc::new(MutatingDrop { value: 42 });
> >>>>>>>> let wr = arc.as_with_ref(); // this creates a shared `&` reference to the MutatingDrop
> >>>>>>>> let arc2: Arc<MutatingDrop> = wr.into(); // increments the reference count to 2
> >>>>>>>
> >>>>>>> More precisely, here we did a
> >>>>>>>
> >>>>>>> 	&WithRef<_> -> NonNull<WithRef<_>>
> >>>>>>>
> >>>>>>> conversion, and later on, we may use the `NonNull<WithRef<_>>` in
> >>>>>>> `drop` to get a `Box<WithRef<_>>`.
> >>>>>>
> >>>>>> Indeed.
> >>>>>>
> >>>>>
> >>>>> Can we workaround this issue by (ab)using the `UnsafeCell` inside
> >>>>> `WithRef<T>`?
> >>>>>
> >>>>> impl<T: ?Sized> From<&WithRef<T>> for Arc<T> {
> >>>>>        fn from(b: &WithRef<T>) -> Self {
> >>>>>            // SAFETY: The existence of the references proves that
> >>>>> 	// `b.refcount.get()` is a valid pointer to `WithRef<T>`.
> >>>>> 	let ptr = unsafe { NonNull::new_unchecked(b.refcount.get().cast::<WithRef<T>>()) };
> >>>>>
> >>>>> 	// SAFETY: see the SAFETY above `let ptr = ..` line.
> >>>>>            ManuallyDrop::new(unsafe { Arc::from_inner(ptr) })
> >>>>>                .deref()
> >>>>>                .clone()
> >>>>>        }
> >>>>> }
> >>>>>
> >>>>> This way, the raw pointer in the new Arc no longer derives from the
> >>>>> reference of `WithRef<T>`.
> >>>>
> >>>> No, the code above only obtains a pointer that has provenance valid
> >>>> for a `bindings::refcount_t` (or type with the same layout, such as
> >>>> `Opaque<bindings::refcount_t>`). But not the whole `WithRef<T>`, so accessing
> >>>> it by reading/writing will still be UB.
> >>>>
> >>>
> >>> Hmm... but we do the similar thing in `Arc::from_raw()`, right?
> >>>
> >>>       	pub unsafe fn from_raw(ptr: *const T) -> Self {
> >>> 	    ..
> >>> 	}
> >>>
> >>> , what we have is a pointer to T, and we construct a pointer to
> >>> `ArcInner<T>/WithRef<T>`, in that function. Because the `sub` on pointer
> >>> gets away from provenance? If so, we can also do a sub(0) in the above
> >>> code.
> >>
> >> Not sure what you mean. Operations on raw pointers leave provenance
> >> unchanged.
> > 
> > Let's look at the function from_raw(), the input is a pointer to T,
> > right? So you only have the provenance to T, but in that function, the
> > pointer is casted to a pointer to WithRef<T>/ArcInner<T>, that means you
> > have the provenance to the whole WithRef<T>/ArcInner<T>, right? My
> > question is: why isn't that a UB?
> 
> The pointer was originally derived by a call to `into_raw`:
> ```
>      pub fn into_raw(self) -> *const T {
>          let ptr = self.ptr.as_ptr();
>          core::mem::forget(self);
>          // SAFETY: The pointer is valid.
>          unsafe { core::ptr::addr_of!((*ptr).data) }
>      }
> ```
> So in this function the origin (also the origin of the provenance)
> of the pointer is `ptr` which is of type `NonNull<WithRef<T>>`.
> Raw pointers do not lose this provenance information when you cast
> it and when using `addr_of`/`addr_of_mut`. So provenance is something
> that is not really represented in the type system for raw pointers.

Ah, I see, that's the thing I was missing. Now it makes much sense to
me, thank you both!

> 
> When doing a round trip through a reference though, the provenance is
> newly assigned and thus would only be valid for a `T`:
> ```
> let raw = arc.into_raw();
> let reference = unsafe { &*raw };
> let raw: *const T = reference;
> let arc = unsafe { Arc::from_raw(raw) };
> ```

Agreed. This example demonstrates the key point: the provenances of raw
pointers are decided at derive time.

Regards,
Boqun


> Miri would complain about the above code.
> 
> -- 
> Cheers,
> Benno
> 
> 
