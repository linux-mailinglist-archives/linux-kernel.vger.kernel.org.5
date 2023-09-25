Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A04DB7AE187
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 00:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231905AbjIYWHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 18:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjIYWHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 18:07:09 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5553AF;
        Mon, 25 Sep 2023 15:07:02 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9ad8bba8125so980944166b.3;
        Mon, 25 Sep 2023 15:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695679621; x=1696284421; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JUIG4xw/fGQG/BKrffhAQGfYP16ndxdkwQiaa0ZhJiA=;
        b=OnX11QsMkXOM8IHe+AN98YC7Em3pHTS1n8J8borSDHLxrbo821PzdfRT+VwlHy/6JJ
         Fr5yZkXptGg3syJ9lrdnA4HM0guXxcRhIZ0VzteL1TpWcNxT8MNqdUxgtyxZGUZD2TM6
         YCk3hrZ3DFD5VRB/3GcR86j6NA1s3TM71KsJ9Zi5yjhmlKT9zR8tN09gI+QKGICchXIy
         5XoRyXZctgE5gyJnt9MYM+/QnRBRKJh02LwH8Px2cmIRbrwQROCKKDkyjjp9Lz0eAxWX
         nFLQ1YjEcequdc57/7ZpZ8aYO62ayf2zY35iipgLjhPp4IAPq4H8JOxzXeBYjOIHF3/K
         ESkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695679621; x=1696284421;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JUIG4xw/fGQG/BKrffhAQGfYP16ndxdkwQiaa0ZhJiA=;
        b=iuLN1byJsjD1oLcXD55mjyOL+ODGSM6IfeGNOz+6BuS0taT8i+rT+ZODUQOSE29BAZ
         SS0boCp1rnGcDLZ15gTlJcbJhJx8eulJMhcQ5aEjF0a0SMhiB6vdYwDcd3J75aEQbb+c
         KiLAgOKjieWUpgWKnI/iu2HZ6eiEgshPnlyOKKT9bwlB9p9qFzfZYfIkb7huK9xxqcfC
         ksPjqQNRnVSnln/meQwybV3aRgaN6notyeziNa5kR/5pLKR0kcPguDFIx51JF6z82QQS
         MDWh6ippv8bBz9KKR38G0qiMa75pmnEduVfDJGbWv9s7I2C31RTwwRRjT8UzuaYttQC+
         nSEw==
X-Gm-Message-State: AOJu0Yw6Rj00VfqgluvPxWehHIfusco3MSWrCbkGFuzvm7KiqTH4HLqX
        K/jsmzC7qIBciPn6nucLs8U=
X-Google-Smtp-Source: AGHT+IH9qXLGYRNl5QIc1PyUVeS9d0AHE6l2DOrzeDBaajUkjSxEUBUlmt+jhxjaHgZjiPQcPvrCpw==
X-Received: by 2002:a17:906:8a45:b0:9ae:4eb7:ae8b with SMTP id gx5-20020a1709068a4500b009ae4eb7ae8bmr7308493ejc.7.1695679620896;
        Mon, 25 Sep 2023 15:07:00 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id qk8-20020a170906d9c800b009ad89697c86sm6912868ejb.144.2023.09.25.15.06.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 15:07:00 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id 9484527C0054;
        Mon, 25 Sep 2023 18:06:58 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 25 Sep 2023 18:06:58 -0400
X-ME-Sender: <xms:ggQSZZZiOX6AcwhJh1oy1ufQpAalr6sz9m_O8x7QXCD4dV_9jk6j0w>
    <xme:ggQSZQbaP4vHpaRdPI-MhVLGn8WXxbjwTLQt-CiBvuRgwQfO5LKHjfNZofd52nw9q
    ZEqmlFmdmSEccf8Kw>
X-ME-Received: <xmr:ggQSZb-Q-dAdHcHWRDS1U7vNkPC6rJB1fXKKeQ7FEG1Uwq0pNUX1Oq7moFY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudelhedgtdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:ggQSZXqnRYk0VH5F_RHrxw4YRAknELzleqXCNyBSZEqYD3AeKhW5Sg>
    <xmx:ggQSZUqv23P63TUMxrr2prLEJdGl9ple7YvRWXnTETxMNOwXXKTHYA>
    <xmx:ggQSZdS6JPnZlWd34x1TGp2B21LAJMQl1RFfYfolOLsWgaz7FHRdSQ>
    <xmx:ggQSZZQqb_KIHcDhcfW9U-JlaJazDGfIU2ijyURsh0mil1__qeeXsw>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Sep 2023 18:06:57 -0400 (EDT)
Date:   Mon, 25 Sep 2023 15:06:26 -0700
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Alice Ryhl <alice@ryhl.io>
Cc:     Benno Lossin <benno.lossin@proton.me>,
        Alice Ryhl <aliceryhl@google.com>,
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
Message-ID: <ZRIEYg9L9ZSYRLgd@boqun-archlinux>
References: <969eab7f-ad40-0dfb-18b9-6002fc54e12b@proton.me>
 <ZRGd4lsNP30L2yB3@Boquns-Mac-mini.home>
 <14513589-cc31-8985-8ff6-a97d2882f593@proton.me>
 <ZRGyRQuBcWvgtdNR@Boquns-Mac-mini.home>
 <9d6d6c94-5da6-a56d-4e85-fbf8da26a0b0@proton.me>
 <ZRHWqbvYlXBXEOh-@boqun-archlinux>
 <c5134a1a-a60d-73bb-9faa-aa1dfc3bc30d@proton.me>
 <ZRIB0hXNvmJtmyak@boqun-archlinux>
 <edc0b599-c5d1-4e9c-a51b-eb8ceaef7acc@ryhl.io>
 <ZRIDc_x9Qh5EJNC8@boqun-archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRIDc_x9Qh5EJNC8@boqun-archlinux>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 03:02:27PM -0700, Boqun Feng wrote:
> On Mon, Sep 25, 2023 at 11:58:46PM +0200, Alice Ryhl wrote:
> > On 9/25/23 23:55, Boqun Feng wrote:
> > > On Mon, Sep 25, 2023 at 09:03:52PM +0000, Benno Lossin wrote:
> > > > On 25.09.23 20:51, Boqun Feng wrote:
> > > > > On Mon, Sep 25, 2023 at 05:00:45PM +0000, Benno Lossin wrote:
> > > > > > On 25.09.23 18:16, Boqun Feng wrote:
> > > > > > > On Mon, Sep 25, 2023 at 03:07:44PM +0000, Benno Lossin wrote:
> > > > > > > > ```rust
> > > > > > > > struct MutatingDrop {
> > > > > > > >         value: i32,
> > > > > > > > }
> > > > > > > > 
> > > > > > > > impl Drop for MutatingDrop {
> > > > > > > >         fn drop(&mut self) {
> > > > > > > >             self.value = 0;
> > > > > > > >         }
> > > > > > > > }
> > > > > > > > 
> > > > > > > > let arc = Arc::new(MutatingDrop { value: 42 });
> > > > > > > > let wr = arc.as_with_ref(); // this creates a shared `&` reference to the MutatingDrop
> > > > > > > > let arc2: Arc<MutatingDrop> = wr.into(); // increments the reference count to 2
> > > > > > > 
> > > > > > > More precisely, here we did a
> > > > > > > 
> > > > > > > 	&WithRef<_> -> NonNull<WithRef<_>>
> > > > > > > 
> > > > > > > conversion, and later on, we may use the `NonNull<WithRef<_>>` in
> > > > > > > `drop` to get a `Box<WithRef<_>>`.
> > > > > > 
> > > > > > Indeed.
> > > > > > 
> > > > > 
> > > > > Can we workaround this issue by (ab)using the `UnsafeCell` inside
> > > > > `WithRef<T>`?
> > > > > 
> > > > > impl<T: ?Sized> From<&WithRef<T>> for Arc<T> {
> > > > >       fn from(b: &WithRef<T>) -> Self {
> > > > >           // SAFETY: The existence of the references proves that
> > > > > 	// `b.refcount.get()` is a valid pointer to `WithRef<T>`.
> > > > > 	let ptr = unsafe { NonNull::new_unchecked(b.refcount.get().cast::<WithRef<T>>()) };
> > > > > 
> > > > > 	// SAFETY: see the SAFETY above `let ptr = ..` line.
> > > > >           ManuallyDrop::new(unsafe { Arc::from_inner(ptr) })
> > > > >               .deref()
> > > > >               .clone()
> > > > >       }
> > > > > }
> > > > > 
> > > > > This way, the raw pointer in the new Arc no longer derives from the
> > > > > reference of `WithRef<T>`.
> > > > 
> > > > No, the code above only obtains a pointer that has provenance valid
> > > > for a `bindings::refcount_t` (or type with the same layout, such as
> > > > `Opaque<bindings::refcount_t>`). But not the whole `WithRef<T>`, so accessing
> > > > it by reading/writing will still be UB.
> > > > 
> > > 
> > > Hmm... but we do the similar thing in `Arc::from_raw()`, right?
> > > 
> > >      	pub unsafe fn from_raw(ptr: *const T) -> Self {
> > > 	    ..
> > > 	}
> > > 
> > > , what we have is a pointer to T, and we construct a pointer to
> > > `ArcInner<T>/WithRef<T>`, in that function. Because the `sub` on pointer
> > > gets away from provenance? If so, we can also do a sub(0) in the above
> > > code.
> > 
> > Not sure what you mean. Operations on raw pointers leave provenance
> > unchanged.
> 
> Let's look at the function from_raw(), the input is a pointer to T,
> right? So you only have the provenance to T, but in that function, the
> pointer is casted to a pointer to WithRef<T>/ArcInner<T>, that means you
> have the provenance to the whole WithRef<T>/ArcInner<T>, right? My
> question is: why isn't that a UB?
> 

Or how does it get away from provenance checkings?

Regards,
Boqun

> Regards,
> Boqun
> 
> > 
> > Alice
> > 
