Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38EEB7AE17A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 00:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbjIYWDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 18:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjIYWDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 18:03:09 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E053AF;
        Mon, 25 Sep 2023 15:03:03 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9ad8bf9bfabso933226766b.3;
        Mon, 25 Sep 2023 15:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695679381; x=1696284181; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ESN1WAMPIUgnNdk1lbiHL2pjFvzp9uU+qZBv39to3yM=;
        b=RTyR2ntg6bIySmMo9YMnJRDf3rx6ChrsgB1SayGGlVr+Qj42/hn8wQ+nJiPRldwzxz
         V/qlA+nQqlZHp+C2blT1cBzUA5MP/UIBZlcHAX66xvcClCphxSAqId1a5eHve758CWhZ
         N8Vq6uuwrfHGGYaINMc5X/us7GOfU2bLqP69XyRZe1oFuEAsaJYddqBjs1vWah4RGMzV
         vA1Ad3cqnSMCEvupgiyqiEAjoOsMb9h6NHODSDmaXXtAotfeT1mYxgzIcgoV9PeDn/hh
         cwQ4YFataYv4J6FXunm7ovJEC2jRNOZUl8vqT/E9N8uHy9J/k5+MNP1mwFt3BkyXMau3
         bcWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695679381; x=1696284181;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ESN1WAMPIUgnNdk1lbiHL2pjFvzp9uU+qZBv39to3yM=;
        b=TKC9n5HhuNda8Rnk3pjlN0g6naVSDvRdzQz+7tzlHm2tJ63PZJxil4vBbGKNn7TRbU
         l3/WyYQ1ZczzMtX2oz4wcbdlHGzByT0xZlIPeE9LWG7aVO7RGrf+ZK4uYzSwiIBoPz0J
         mAOW3VGEK/TnwLhnMa75744T5QucpGoj38HE9ocXv8vU6nRDsCN4crhLv9VI/6WuQJXd
         s5TLuZycQdPxAk2zgBFbh9VA4Tf6YAS+KrIMsYxq2MEaKhlGH+Zy5kEtE+Drdv+Gdxr/
         CFpS5fqxGNH4PBDEBODPfO3hEZPDgsYRhyevnTvY/CFL5f4ZrIWs01U01LZ4CGoxkD6x
         Ysnw==
X-Gm-Message-State: AOJu0YwAsknPdRt4CtOQeokT6fGdnXmuVP42DFRJWVLenzehL+/d3Iw8
        xjtbllO1QYS/dIdXd7GeSUI=
X-Google-Smtp-Source: AGHT+IHUAi3lYwIFf93/ImUMn73vU17+fyjdWDWCzIPC9erqI7yAmW0N7EolVH+JPodWc7GiFnTh0w==
X-Received: by 2002:a17:906:3281:b0:9ae:7870:1533 with SMTP id 1-20020a170906328100b009ae78701533mr7276506ejw.64.1695679381480;
        Mon, 25 Sep 2023 15:03:01 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id l25-20020a1709066b9900b0099cc36c4681sm6836344ejr.157.2023.09.25.15.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 15:03:00 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 1BE0027C0054;
        Mon, 25 Sep 2023 18:02:59 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 25 Sep 2023 18:02:59 -0400
X-ME-Sender: <xms:kgMSZY-Yjenr9VG9XVua6F6umfEaEAWDxHQZSR2eDwMwlen31-FQQQ>
    <xme:kgMSZQuLJJZmWTkOIIFD1CeTlM9QXnDY8KjEGjRRcaUPV1NslLYA0hLO-bqjq9x-1
    y_bcQg4cDdKg57B_g>
X-ME-Received: <xmr:kgMSZeBt_3GlPwnKh-HkHhc263wDAvewMO-uzGZRuN0dPcQ2Fd1o9GfotjA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudelhedgtdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:kgMSZYd03NVO32Nmi0xXbwwVznohwXo_JFRctL3SAm00mWaNNqo9IA>
    <xmx:kgMSZdOrRtoIG8IWA46NyZWTDHhmVR5--5BNIsaDs-uqtzpFMQKiDg>
    <xmx:kgMSZSlX4U-wMmWq5Kn0cA20N7-DKuX--99LRZK1Ajr1mM9vt4TAHw>
    <xmx:kwMSZSmGDyhYSYoa15g086H3I9j32ghEA7sjtQIqb8g6msuaA1z8Tg>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Sep 2023 18:02:58 -0400 (EDT)
Date:   Mon, 25 Sep 2023 15:02:27 -0700
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
Message-ID: <ZRIDc_x9Qh5EJNC8@boqun-archlinux>
References: <CAH5fLggxsewmtzXjehbawDCTHO0C7kteU_CLnh80eMNj=QyP9Q@mail.gmail.com>
 <969eab7f-ad40-0dfb-18b9-6002fc54e12b@proton.me>
 <ZRGd4lsNP30L2yB3@Boquns-Mac-mini.home>
 <14513589-cc31-8985-8ff6-a97d2882f593@proton.me>
 <ZRGyRQuBcWvgtdNR@Boquns-Mac-mini.home>
 <9d6d6c94-5da6-a56d-4e85-fbf8da26a0b0@proton.me>
 <ZRHWqbvYlXBXEOh-@boqun-archlinux>
 <c5134a1a-a60d-73bb-9faa-aa1dfc3bc30d@proton.me>
 <ZRIB0hXNvmJtmyak@boqun-archlinux>
 <edc0b599-c5d1-4e9c-a51b-eb8ceaef7acc@ryhl.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <edc0b599-c5d1-4e9c-a51b-eb8ceaef7acc@ryhl.io>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 11:58:46PM +0200, Alice Ryhl wrote:
> On 9/25/23 23:55, Boqun Feng wrote:
> > On Mon, Sep 25, 2023 at 09:03:52PM +0000, Benno Lossin wrote:
> > > On 25.09.23 20:51, Boqun Feng wrote:
> > > > On Mon, Sep 25, 2023 at 05:00:45PM +0000, Benno Lossin wrote:
> > > > > On 25.09.23 18:16, Boqun Feng wrote:
> > > > > > On Mon, Sep 25, 2023 at 03:07:44PM +0000, Benno Lossin wrote:
> > > > > > > ```rust
> > > > > > > struct MutatingDrop {
> > > > > > >         value: i32,
> > > > > > > }
> > > > > > > 
> > > > > > > impl Drop for MutatingDrop {
> > > > > > >         fn drop(&mut self) {
> > > > > > >             self.value = 0;
> > > > > > >         }
> > > > > > > }
> > > > > > > 
> > > > > > > let arc = Arc::new(MutatingDrop { value: 42 });
> > > > > > > let wr = arc.as_with_ref(); // this creates a shared `&` reference to the MutatingDrop
> > > > > > > let arc2: Arc<MutatingDrop> = wr.into(); // increments the reference count to 2
> > > > > > 
> > > > > > More precisely, here we did a
> > > > > > 
> > > > > > 	&WithRef<_> -> NonNull<WithRef<_>>
> > > > > > 
> > > > > > conversion, and later on, we may use the `NonNull<WithRef<_>>` in
> > > > > > `drop` to get a `Box<WithRef<_>>`.
> > > > > 
> > > > > Indeed.
> > > > > 
> > > > 
> > > > Can we workaround this issue by (ab)using the `UnsafeCell` inside
> > > > `WithRef<T>`?
> > > > 
> > > > impl<T: ?Sized> From<&WithRef<T>> for Arc<T> {
> > > >       fn from(b: &WithRef<T>) -> Self {
> > > >           // SAFETY: The existence of the references proves that
> > > > 	// `b.refcount.get()` is a valid pointer to `WithRef<T>`.
> > > > 	let ptr = unsafe { NonNull::new_unchecked(b.refcount.get().cast::<WithRef<T>>()) };
> > > > 
> > > > 	// SAFETY: see the SAFETY above `let ptr = ..` line.
> > > >           ManuallyDrop::new(unsafe { Arc::from_inner(ptr) })
> > > >               .deref()
> > > >               .clone()
> > > >       }
> > > > }
> > > > 
> > > > This way, the raw pointer in the new Arc no longer derives from the
> > > > reference of `WithRef<T>`.
> > > 
> > > No, the code above only obtains a pointer that has provenance valid
> > > for a `bindings::refcount_t` (or type with the same layout, such as
> > > `Opaque<bindings::refcount_t>`). But not the whole `WithRef<T>`, so accessing
> > > it by reading/writing will still be UB.
> > > 
> > 
> > Hmm... but we do the similar thing in `Arc::from_raw()`, right?
> > 
> >      	pub unsafe fn from_raw(ptr: *const T) -> Self {
> > 	    ..
> > 	}
> > 
> > , what we have is a pointer to T, and we construct a pointer to
> > `ArcInner<T>/WithRef<T>`, in that function. Because the `sub` on pointer
> > gets away from provenance? If so, we can also do a sub(0) in the above
> > code.
> 
> Not sure what you mean. Operations on raw pointers leave provenance
> unchanged.

Let's look at the function from_raw(), the input is a pointer to T,
right? So you only have the provenance to T, but in that function, the
pointer is casted to a pointer to WithRef<T>/ArcInner<T>, that means you
have the provenance to the whole WithRef<T>/ArcInner<T>, right? My
question is: why isn't that a UB?

Regards,
Boqun

> 
> Alice
> 
