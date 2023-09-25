Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2D3A7AE231
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 01:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233404AbjIYXY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 19:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjIYXY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 19:24:57 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF2E101;
        Mon, 25 Sep 2023 16:24:50 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-5031ccf004cso12226807e87.2;
        Mon, 25 Sep 2023 16:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695684288; x=1696289088; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aRn2eUojH5cYHTSFKhn78L78ZOiesxh0ceTCMdYPg6I=;
        b=POQjTzmLWM1IIAXHdDDall+DJdoc6+iWL9EeQAfjjYbWlWVEZ3ueBIcLVD3ojKB5GG
         5U6F+OKEF6fn/wOnVzk0BOmOcQoevEY4BnM/7u6XvI5+ecw+FeSRkW/OAroSNFf5yIcU
         DprvGrBz7rU4vGBv86g2KziPQE1k2etFmHR+pql1p+b4IBKIiAR7IpG1GObn1rDE2DmP
         uaIvcWQqTDAYujoIF55Kk4Rlbz3l9buAKCjF29gpEORAH/iPCHWjVd13VEY6OgeZKg//
         oM8sGnCYaNC27/KrY7Q8eoXDYgWR2S1XHGrTBQnSfdk+0hHaT8aL1UbXldwovk7LKcm1
         Iavw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695684288; x=1696289088;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aRn2eUojH5cYHTSFKhn78L78ZOiesxh0ceTCMdYPg6I=;
        b=C+OkF7bqwCNqmJP32rz+aULbjBUr7BF+I2Vhzlu/J34L00hu++6kbO43MP8Sl1r2F7
         umnwJTldBfAsx4hw6Sx5AqjUy+fCKrzgZQVJmDJlGbO+a0l2J1fEEwx8CCrFMF68clfd
         BbE+GGBwgM8iv1+0BCZOAiElTcfQNW7z7SA9ZhIcFt1ZYeTt118xSSuBxvhbnAbQtU/6
         3l9VO9UdSmi7uZb2zgS4NsLYrYudn6lIfTkfaG4MV57NUMaEinTSAUXcAjTxtg68Xzvr
         LkQTiingstPUEwE8wsd7Ya2zLxO3IzLQ74hLXHQ+x822TcV6ICzeIISVwBUKn7GEXbuy
         pduw==
X-Gm-Message-State: AOJu0YzBHPzJt+ckyxESMZg6t07V8HDsOwPC+JkoRh9P377R0G6263MG
        Xg8R8rm1VL1Nmey9IBOKYvE=
X-Google-Smtp-Source: AGHT+IHKljnrGeJbIfz2RhZgpIhu/Pm8h7UegD6DUEjx0OEUGy9MMy5JIE64YHfBFKZmoPoqonJauw==
X-Received: by 2002:a05:6512:3af:b0:500:9839:b13a with SMTP id v15-20020a05651203af00b005009839b13amr5714411lfp.66.1695684288421;
        Mon, 25 Sep 2023 16:24:48 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id g7-20020aa7d1c7000000b0053112d6a40esm6103001edp.82.2023.09.25.16.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 16:24:47 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 8398927C0054;
        Mon, 25 Sep 2023 19:24:45 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 25 Sep 2023 19:24:45 -0400
X-ME-Sender: <xms:vRYSZSrISRUVxy2t2BqE8GtvM9RGKy2rd2Ij_s2aqdkhUisKnWZFqw>
    <xme:vRYSZQoS7pTbwJD-EMXUS4LTVVwWw6FwEusuNOZoYLnJ79v7vjLB0pzXjBJOYcQhz
    sdAuORK7BEX2Wp_8g>
X-ME-Received: <xmr:vRYSZXMCK5JYC9GHFanJV6L18DSyGGQknK05dA43VFhVAiaqhmcCVRPEgnI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudelhedgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpefhkeduhfefffdvhffhvdethfevfffhfedtfedvheejgeekfedtgefgveff
    hfevkeenucffohhmrghinhepphhtrhdrrghsnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhs
    ohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnh
    hgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:vRYSZR7JaiGWhQjRFiJMHPleHmw3-52DWA__lTjBVDL_D66WG8bTAw>
    <xmx:vRYSZR5aFNOjakWpVF3t2sUlv0Yj74uIIz95qy7tdNO6UIXIvr8aJg>
    <xmx:vRYSZRjvL8FL7wWn1gyq-1rv3gTPpKPVEuU5s07xE1jjimH95fdJ9A>
    <xmx:vRYSZdj3fwL6qcxZK2upwCXFITldHCqx7qs3mHGTD4ot80J9Rm-kSw>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Sep 2023 19:24:44 -0400 (EDT)
Date:   Mon, 25 Sep 2023 16:24:08 -0700
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
Message-ID: <ZRIWmPa0mN6s7Yoj@boqun-archlinux>
References: <14513589-cc31-8985-8ff6-a97d2882f593@proton.me>
 <ZRGyRQuBcWvgtdNR@Boquns-Mac-mini.home>
 <9d6d6c94-5da6-a56d-4e85-fbf8da26a0b0@proton.me>
 <ZRHWqbvYlXBXEOh-@boqun-archlinux>
 <c5134a1a-a60d-73bb-9faa-aa1dfc3bc30d@proton.me>
 <ZRIB0hXNvmJtmyak@boqun-archlinux>
 <edc0b599-c5d1-4e9c-a51b-eb8ceaef7acc@ryhl.io>
 <ZRIDc_x9Qh5EJNC8@boqun-archlinux>
 <61ccfb87-54fd-3f1b-105c-253d0350cd56@proton.me>
 <ZRILEIsKW6LsGdfb@boqun-archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRILEIsKW6LsGdfb@boqun-archlinux>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 03:34:56PM -0700, Boqun Feng wrote:
[...]
> > >>>
> > >>> Hmm... but we do the similar thing in `Arc::from_raw()`, right?
> > >>>
> > >>>       	pub unsafe fn from_raw(ptr: *const T) -> Self {
> > >>> 	    ..
> > >>> 	}
> > >>>
> > >>> , what we have is a pointer to T, and we construct a pointer to
> > >>> `ArcInner<T>/WithRef<T>`, in that function. Because the `sub` on pointer
> > >>> gets away from provenance? If so, we can also do a sub(0) in the above
> > >>> code.
> > >>
> > >> Not sure what you mean. Operations on raw pointers leave provenance
> > >> unchanged.
> > > 
> > > Let's look at the function from_raw(), the input is a pointer to T,
> > > right? So you only have the provenance to T, but in that function, the
> > > pointer is casted to a pointer to WithRef<T>/ArcInner<T>, that means you
> > > have the provenance to the whole WithRef<T>/ArcInner<T>, right? My
> > > question is: why isn't that a UB?
> > 
> > The pointer was originally derived by a call to `into_raw`:
> > ```
> >      pub fn into_raw(self) -> *const T {
> >          let ptr = self.ptr.as_ptr();
> >          core::mem::forget(self);
> >          // SAFETY: The pointer is valid.
> >          unsafe { core::ptr::addr_of!((*ptr).data) }
> >      }
> > ```
> > So in this function the origin (also the origin of the provenance)
> > of the pointer is `ptr` which is of type `NonNull<WithRef<T>>`.
> > Raw pointers do not lose this provenance information when you cast
> > it and when using `addr_of`/`addr_of_mut`. So provenance is something
> > that is not really represented in the type system for raw pointers.
> 
> Ah, I see, that's the thing I was missing. Now it makes much sense to
> me, thank you both!
> 
> > 
> > When doing a round trip through a reference though, the provenance is
> > newly assigned and thus would only be valid for a `T`:
> > ```
> > let raw = arc.into_raw();
> > let reference = unsafe { &*raw };
> > let raw: *const T = reference;
> > let arc = unsafe { Arc::from_raw(raw) };
> > ```
> 
> Agreed. This example demonstrates the key point: the provenances of raw
> pointers are decided at derive time.
> 

So the original problem the Alice brought up is also because of the
provenance, right? To get a `&WithRef<T>`, we reborrow the pointer to
get a `&`, and any pointer derived from that reference will have a
different (and read-only) provenance, which causes the problem. Like:

```rust
let raw = Box::into_raw(arc);
let reference = unsafe { &*raw }; // as_with_ref()
let raw: *mut T = reference as *const _ as  *mut _ ;
let arc = unsafe { Box::from_raw(raw) };
```

Regards,
Boqun

> Regards,
> Boqun
> 
> 
> > Miri would complain about the above code.
> > 
> > -- 
> > Cheers,
> > Benno
> > 
> > 
