Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9415C7AE10E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 23:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbjIYV4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 17:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjIYV4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 17:56:15 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0479FAF;
        Mon, 25 Sep 2023 14:56:08 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-98377c5d53eso888721666b.0;
        Mon, 25 Sep 2023 14:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695678966; x=1696283766; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JDhVxKt0fuJsO1ywUyi0HgdMgyRyKvfcjAEXNVSEPJk=;
        b=OZTY32TNHJyjiI8/1nk9jF7XXBzv4hyjh11HedGFhR0H0gzz16fgQDd/bhPNxRmJO5
         s8MAP12qFFCxmDwOYOeBRAkWiwfI3hZIpvFq2uxrGEL7mU4tOeMlPd4EP4TpWkSBdzzL
         lFuv5AYB7f6N6Cp/K7gBcH8M8HSXzpRZBb4I+Ecrq0Zl+7JURy06Si7JOFiQxY0ILnSZ
         9gedljH6LQS2aEJUDYnAiQiiRauIWYI01br1xgX6Gqpdvc28tjCjntWC2rcmA3HNr4V1
         K++mbkja05TzZlmio9AIlQOOML+5bx9Qj6eA65QLMcAj0DZr3gwOd4YmSG1YE/8qBnHj
         pzfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695678966; x=1696283766;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JDhVxKt0fuJsO1ywUyi0HgdMgyRyKvfcjAEXNVSEPJk=;
        b=ejfJt6/wUZfMduZhI+nbCsOmaXdlaEY9vybY2Ux9cvYSjFL8fhKrirh6Nhj5sm16Ke
         +QfIsEJDuUMlj0G/INa46RVR1bPhSz5iL1tJTStpsQ4wh7O/HL6eyYfv3sJ0SB7WHZxP
         jdbu0IUlK1BERZsoUiC+Fwyq+gGsEUQq/PDz2IOtCcGdg0kQZVQVpVU1zUAxoDDXwvXa
         s/hKB5IEf958PSQIN5V1M8z5fRKD632n5R5F40T3GGs8jOk1Gv2cE3LXXuuvkX4ufsI5
         03/B53VOlDl0LpPshkc6lrB7C9XOAUMreFjYf36OD/z3gYRNJsYK2No7pjTqz+dLF1pJ
         46VQ==
X-Gm-Message-State: AOJu0YzfQ1Myn3tHiATc1hjkhn6qIRy87YcJjso62HXTsmdK2LPBgj0X
        Nb/T2jHuaFaeqce0fK1gwhA=
X-Google-Smtp-Source: AGHT+IGvUvUyJoTYAY2f1zXvRB1PpDg01GN/DH7XaO7ttVxbsr3ISwaHvCSfBsLOiqRiMGXk7BgqgQ==
X-Received: by 2002:a05:6402:c84:b0:533:c75a:6f6 with SMTP id cm4-20020a0564020c8400b00533c75a06f6mr5940837edb.12.1695678966097;
        Mon, 25 Sep 2023 14:56:06 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id dm20-20020a05640222d400b0053414427690sm1726377edb.41.2023.09.25.14.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 14:56:05 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id 1967C27C0054;
        Mon, 25 Sep 2023 17:56:03 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 25 Sep 2023 17:56:03 -0400
X-ME-Sender: <xms:8gESZVHUIJiSVrqg0qTMl5foXkNVvTJUg6sxwFtv_up6qbWAm-tSXQ>
    <xme:8gESZaVIXYU4o2fDX1VtcuSEgJT5YvRpnACC8Jqp8fSfGEfpPGoLnnxqzu-xGG6WE
    qGCX208uxq3AW_hIA>
X-ME-Received: <xmr:8gESZXKEeJ3kI9k0OUI2OOctNlJGDlbYUrlbQSxV2yubLczi36gPpOmN7LU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudelhedgtdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:8gESZbE8So0DtYnd3l5YmO84eCR-8uA6dQEgRDo-xPykyq7Na9lMfQ>
    <xmx:8gESZbWhkoi9QvzDVzt6guUaDInen85hfi8NwuDZgbKS6bUAYit19Q>
    <xmx:8gESZWMUem2akHxUfmTM4gRjVOhIno3_sIUTwuUuX4fmjCIZ4DhgMw>
    <xmx:8wESZUML6YjvGHmlSuwsPbo7InKTmqjCcDUAm9RQakFRut82BpasEA>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Sep 2023 17:56:02 -0400 (EDT)
Date:   Mon, 25 Sep 2023 14:55:30 -0700
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Benno Lossin <benno.lossin@proton.me>
Cc:     Alice Ryhl <aliceryhl@google.com>,
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
Message-ID: <ZRIB0hXNvmJtmyak@boqun-archlinux>
References: <20230923144938.219517-1-wedsonaf@gmail.com>
 <20230923144938.219517-3-wedsonaf@gmail.com>
 <CAH5fLggxsewmtzXjehbawDCTHO0C7kteU_CLnh80eMNj=QyP9Q@mail.gmail.com>
 <969eab7f-ad40-0dfb-18b9-6002fc54e12b@proton.me>
 <ZRGd4lsNP30L2yB3@Boquns-Mac-mini.home>
 <14513589-cc31-8985-8ff6-a97d2882f593@proton.me>
 <ZRGyRQuBcWvgtdNR@Boquns-Mac-mini.home>
 <9d6d6c94-5da6-a56d-4e85-fbf8da26a0b0@proton.me>
 <ZRHWqbvYlXBXEOh-@boqun-archlinux>
 <c5134a1a-a60d-73bb-9faa-aa1dfc3bc30d@proton.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5134a1a-a60d-73bb-9faa-aa1dfc3bc30d@proton.me>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 09:03:52PM +0000, Benno Lossin wrote:
> On 25.09.23 20:51, Boqun Feng wrote:
> > On Mon, Sep 25, 2023 at 05:00:45PM +0000, Benno Lossin wrote:
> >> On 25.09.23 18:16, Boqun Feng wrote:
> >>> On Mon, Sep 25, 2023 at 03:07:44PM +0000, Benno Lossin wrote:
> >>>> ```rust
> >>>> struct MutatingDrop {
> >>>>        value: i32,
> >>>> }
> >>>>
> >>>> impl Drop for MutatingDrop {
> >>>>        fn drop(&mut self) {
> >>>>            self.value = 0;
> >>>>        }
> >>>> }
> >>>>
> >>>> let arc = Arc::new(MutatingDrop { value: 42 });
> >>>> let wr = arc.as_with_ref(); // this creates a shared `&` reference to the MutatingDrop
> >>>> let arc2: Arc<MutatingDrop> = wr.into(); // increments the reference count to 2
> >>>
> >>> More precisely, here we did a
> >>>
> >>> 	&WithRef<_> -> NonNull<WithRef<_>>
> >>>
> >>> conversion, and later on, we may use the `NonNull<WithRef<_>>` in
> >>> `drop` to get a `Box<WithRef<_>>`.
> >>
> >> Indeed.
> >>
> > 
> > Can we workaround this issue by (ab)using the `UnsafeCell` inside
> > `WithRef<T>`?
> > 
> > impl<T: ?Sized> From<&WithRef<T>> for Arc<T> {
> >      fn from(b: &WithRef<T>) -> Self {
> >          // SAFETY: The existence of the references proves that
> > 	// `b.refcount.get()` is a valid pointer to `WithRef<T>`.
> > 	let ptr = unsafe { NonNull::new_unchecked(b.refcount.get().cast::<WithRef<T>>()) };
> > 
> > 	// SAFETY: see the SAFETY above `let ptr = ..` line.
> >          ManuallyDrop::new(unsafe { Arc::from_inner(ptr) })
> >              .deref()
> >              .clone()
> >      }
> > }
> > 
> > This way, the raw pointer in the new Arc no longer derives from the
> > reference of `WithRef<T>`.
> 
> No, the code above only obtains a pointer that has provenance valid
> for a `bindings::refcount_t` (or type with the same layout, such as
> `Opaque<bindings::refcount_t>`). But not the whole `WithRef<T>`, so accessing
> it by reading/writing will still be UB.
> 

Hmm... but we do the similar thing in `Arc::from_raw()`, right?

    	pub unsafe fn from_raw(ptr: *const T) -> Self {
	    ..
	}

, what we have is a pointer to T, and we construct a pointer to
`ArcInner<T>/WithRef<T>`, in that function. Because the `sub` on pointer
gets away from provenance? If so, we can also do a sub(0) in the above
code.

Regards,
Boqun

> -- 
> Cheers,
> Benno
> 
> 
