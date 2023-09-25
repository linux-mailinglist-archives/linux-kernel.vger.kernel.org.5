Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD787ADF4A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 20:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233254AbjIYSwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 14:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbjIYSwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 14:52:05 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D2D2B8;
        Mon, 25 Sep 2023 11:51:58 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9ad8bf9bfabso896984666b.3;
        Mon, 25 Sep 2023 11:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695667916; x=1696272716; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SsKjzM3VWnsoW8OT4lS3fTqfMwcvnAnchQOe6+ytjKw=;
        b=TUL/bhVzF5aKs8aKxYG5IAsTjGwPbS41kbQTy+uDf0x9OW6SfO/u7itbv07yURMUNd
         oxnm3QvNuZg0arL86BOSIZmxhzR8ygnNy9y4MSMRQTZKzj8vZ+JyPJZbkZ+YBPDbtoX1
         cXN9uRAxZ7AdqC9XwzVpScFumxae083pNZACmparK52bfU6z9k7k1GWnoh7fbzeT58+K
         WInhsp9Dwyf8haSwKZ7Jtkq/BwX4N6FIxQ1J7xCs17LLoBZ4HaPnygppZYyQLiKuYj0l
         Uz3Igq8M3C9dOuYV1Vkql//Ww+wSILouCca+86lyZNJkthMXQUUXWiTGzL9bv7U5E+Qf
         y3vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695667916; x=1696272716;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SsKjzM3VWnsoW8OT4lS3fTqfMwcvnAnchQOe6+ytjKw=;
        b=kTqwwtvCsEdk2LVJil6xfQuP0MHRjSeqfDD6gpRCfjyecB1n7GjK7JJes4Pvxx5j08
         vHub2ySeoBA2mWWfgmj/fvgKM7dzSE7jF1AWxrXgZxz2GEGHDrYqDTY4OpDIgDtEyHtq
         wv136tYgZ0ksep7q8IYiJBcPY8HymuvGRASBtcekzEqrV7pvVrkcI8JTR7TtDGL5ULSB
         L3k2frNnFPFtXFG8c82/XOGmBEFpFIFy/of3O/vT2pSPTl0mydhTXRX8nkfMjetwLiYt
         RudldtncFHiDTDjKf+cw5zxh4pT31fcVS514tzrbeoh1UnyPh9gXPBaMkHhuxLUvtgd9
         eHGw==
X-Gm-Message-State: AOJu0YxcKSmbwzgUV1LF+uP/GaGeZcJnapM/LhQ/51X3Q3zj8XLqHxQg
        ax9TSyNtaIFrpiUBdpDg2h8=
X-Google-Smtp-Source: AGHT+IGc400/afEse+ow1fyXyoihqmAOpd+15G0wCSjS+gfKgGOcwkkDiuOkZ7L3Adg8rkM23VqXpA==
X-Received: by 2002:a17:906:2189:b0:9ad:ece6:eeb with SMTP id 9-20020a170906218900b009adece60eebmr6397423eju.32.1695667916188;
        Mon, 25 Sep 2023 11:51:56 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id rh27-20020a17090720fb00b0099b6becb107sm6731039ejb.95.2023.09.25.11.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 11:51:55 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id A461A27C005A;
        Mon, 25 Sep 2023 14:51:53 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 25 Sep 2023 14:51:53 -0400
X-ME-Sender: <xms:ydYRZfmhsVy3tlk0hqpUgla1M-gT2IY7Uxn6EzteuFbxZMu_Go8Q-g>
    <xme:ydYRZS3JqZbgvpDwjKKvGsyPtVxyT_dc0aRzKJ0F4e8ox3RporV8nlzvqrsJg-Irn
    apaicsVM4wEaO2dOw>
X-ME-Received: <xmr:ydYRZVpu5SNaH2wbs7x1-Rb2WPq_GIM5-PCR2lxzJYn1fmUHntK0fb5xg3w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudelgedguddvlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveei
    udffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedt
    ieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfh
    higihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:ydYRZXlEsHUWA5kUbFlW50ykvz8osehngrBG5uzO6HKx9451j1KVHw>
    <xmx:ydYRZd2hYcPUrZ6BktN_c5kYorEBxt1NP13NEO4e28FcA2qhM6JgFQ>
    <xmx:ydYRZWsVoUYqtEbryqYj5KLmLLI8sqPrl8rpMPGqPjpDEJOHLfe77Q>
    <xmx:ydYRZWtlmCcT_SJMHy6nS5h54XIN1oFZ7tConIotiJiGb-GtuXvHCg>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Sep 2023 14:51:52 -0400 (EDT)
Date:   Mon, 25 Sep 2023 11:51:21 -0700
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
Message-ID: <ZRHWqbvYlXBXEOh-@boqun-archlinux>
References: <20230923144938.219517-1-wedsonaf@gmail.com>
 <20230923144938.219517-3-wedsonaf@gmail.com>
 <CAH5fLggxsewmtzXjehbawDCTHO0C7kteU_CLnh80eMNj=QyP9Q@mail.gmail.com>
 <969eab7f-ad40-0dfb-18b9-6002fc54e12b@proton.me>
 <ZRGd4lsNP30L2yB3@Boquns-Mac-mini.home>
 <14513589-cc31-8985-8ff6-a97d2882f593@proton.me>
 <ZRGyRQuBcWvgtdNR@Boquns-Mac-mini.home>
 <9d6d6c94-5da6-a56d-4e85-fbf8da26a0b0@proton.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d6d6c94-5da6-a56d-4e85-fbf8da26a0b0@proton.me>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 05:00:45PM +0000, Benno Lossin wrote:
> On 25.09.23 18:16, Boqun Feng wrote:
> > On Mon, Sep 25, 2023 at 03:07:44PM +0000, Benno Lossin wrote:
> >> ```rust
> >> struct MutatingDrop {
> >>       value: i32,
> >> }
> >>
> >> impl Drop for MutatingDrop {
> >>       fn drop(&mut self) {
> >>           self.value = 0;
> >>       }
> >> }
> >>
> >> let arc = Arc::new(MutatingDrop { value: 42 });
> >> let wr = arc.as_with_ref(); // this creates a shared `&` reference to the MutatingDrop
> >> let arc2: Arc<MutatingDrop> = wr.into(); // increments the reference count to 2
> > 
> > More precisely, here we did a
> > 
> > 	&WithRef<_> -> NonNull<WithRef<_>>
> > 
> > conversion, and later on, we may use the `NonNull<WithRef<_>>` in
> > `drop` to get a `Box<WithRef<_>>`.
> 
> Indeed.
> 

Can we workaround this issue by (ab)using the `UnsafeCell` inside
`WithRef<T>`?

impl<T: ?Sized> From<&WithRef<T>> for Arc<T> {
    fn from(b: &WithRef<T>) -> Self {
        // SAFETY: The existence of the references proves that
	// `b.refcount.get()` is a valid pointer to `WithRef<T>`.
	let ptr = unsafe { NonNull::new_unchecked(b.refcount.get().cast::<WithRef<T>>()) };

	// SAFETY: see the SAFETY above `let ptr = ..` line.
        ManuallyDrop::new(unsafe { Arc::from_inner(ptr) })
            .deref()
            .clone()
    }
}

This way, the raw pointer in the new Arc no longer derives from the
reference of `WithRef<T>`.

Regards,
Boqun

> > 
> >> drop(arc); // this decrements the reference count to 1
> >> drop(arc2); // this decrements the reference count to 0, so it will drop it
> >> ```
> >> When dropping `arc2` it will run the destructor for `MutatingDrop`,
> >> which mutates `value`. This is a problem, because the mutable reference
> >> supplied was derived from a `&`, that is not allowed in Rust.
> >>
> > 
> > Is this an UB? I kinda wonder what's the real damage we can get, because
> > in this case, we just use a reference to carry a value of a pointer,
> > i.e.
> > 
> > 	ptr -> reference -> ptr
> > 
> > I cannot think of any real damage compiler can make, but I'm happy to be
> > surprised ;-)
> 
> This is UB, so anything can happen :)
> 
> -- 
> Cheers,
> Benno
> 
> 
