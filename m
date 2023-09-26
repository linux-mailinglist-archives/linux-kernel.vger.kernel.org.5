Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5D5B7AF1E3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 19:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234658AbjIZRoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 13:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbjIZRoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 13:44:09 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 395C59F;
        Tue, 26 Sep 2023 10:44:01 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-5033918c09eso15000362e87.2;
        Tue, 26 Sep 2023 10:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695750239; x=1696355039; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=u/0G7UZtp532WD4U9IqAMOL98DSIgotyWvhe40XiMkg=;
        b=gMPJp9/s9SgjrOgSzz0ta4gA2skueshXH2kRgPvt7uVJYX374OBl3hJafPT3uWeJVb
         DaLY5zZzGZKv2Ys3JGnpm6cAi4No3lSidclL1LK8X/vRgZRlWTs/6za3b644xdnAGC/R
         MgM056r4EYsfrFe0yEiBAcNHQfEqGb7SM4yh2dX88tNqqnL2DIPsRov6IuYkdKW6pOfY
         ZnV9Fe9MUS799nL44IAh3vb0G7W0hn4SIRU68D/15GXl5Ph0/sRpCWPMbrB4zn+SP0zB
         8LwSVFnXMDQu5m7CveOCkUulh5cX0omFiwK2ZDV0n1j3quo9fUSb6ChfBA+4dPXfA+ro
         K/KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695750239; x=1696355039;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u/0G7UZtp532WD4U9IqAMOL98DSIgotyWvhe40XiMkg=;
        b=PrYwP+5f1FoxjFrK0MUorEjH3GGQwL9g/dcg9pwDXnvwAe2Rllar6Pn2CiL+Wi4vsG
         75M64pLd8+DthZ068JJQAeRa21Iu7uNAZZAeyJeX39vYvyogUmjMopoH7Fh/ecdw7CaW
         QkA97MBDOlB3QjlZTBBNTHF/nkmnZvVqCzWkhhAu6nASHnbA5PQxZA7oalZleFBTTdd9
         SB3B425bYu1Ddo9I/KMpI4MDEn5dBLKVwm/wc+KOHnpRjasJozbJsTLiHaBCgKOMjUJC
         GqABzX2QfMJvpuGeVGnOKZE2HfcL15oohA2dJ1wCS56mObXM0/ncZLnycqQ8JaiGLlsZ
         FavQ==
X-Gm-Message-State: AOJu0YwPJ7HaM8w/Zgec1ZBrnfScyBQvOBVZYZNU+eBiU1580U5zuhXo
        5/p0EKxlKEKmHDwCRpXht4M=
X-Google-Smtp-Source: AGHT+IFsX/wVv8Ede/cmBFlIzaEJe5rAVYEP0v4/CmTJc/zD0zRK0xlN+jAB2ZkmQAzuYZ8QcU5a2w==
X-Received: by 2002:ac2:5e85:0:b0:502:a4f4:ced9 with SMTP id b5-20020ac25e85000000b00502a4f4ced9mr8301552lfq.62.1695750238924;
        Tue, 26 Sep 2023 10:43:58 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id s13-20020a056402520d00b0053450b064e2sm1533521edd.3.2023.09.26.10.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 10:43:58 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id 0CFEE27C0054;
        Tue, 26 Sep 2023 13:43:56 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 26 Sep 2023 13:43:56 -0400
X-ME-Sender: <xms:WxgTZR_2LsfcRzXuxNSz3XQvpRVtt44CWw7XD0CFC2bvNfh3OqOqqA>
    <xme:WxgTZVvBqA4ROXoy_r5yeQaCrDncGwGC5zKxqXe0-IqAnwtaEA_cgC6nFpI9WjTW8
    3-_yrqvuxQYWT_jtQ>
X-ME-Received: <xmr:WxgTZfBt1vyaNKmlH0G_55WmakdvIkuw_dC2BNuqDedCGhMFjyl-Vbc9CgU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvjedrtddtgdekiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtgeehvefghfegtdektdegtdfggfeitefgffetteetieeihfdtkeffieel
    vdeigfenucffohhmrghinhepphhtrhdrrghspdhruhhsthdqlhgrnhhgrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdo
    mhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejke
    ehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgr
    mhgv
X-ME-Proxy: <xmx:WxgTZVfbNQw6e4N1yLp_oz9vDcLBkuQgTgZkPFDe3EE-sRx4Da0ojw>
    <xmx:WxgTZWNSdngOYWeLfxGFSMC44W1lXgtIa3Ww4Qc1Y-lVQdXmYUld4g>
    <xmx:WxgTZXmikOZ1B0b7PCdjQw9QD4zGJUa7oMlt8Se_BxVRKSl-WjUP0Q>
    <xmx:XBgTZXlFaOkKgyRCPXqyvXBIVrUV0bQ4IXEtxo2ABbe4BBtohGGTCA>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Sep 2023 13:43:54 -0400 (EDT)
Date:   Tue, 26 Sep 2023 10:43:21 -0700
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Benno Lossin <benno.lossin@proton.me>
Cc:     Alice Ryhl <aliceryhl@google.com>, Gary Guo <gary@garyguo.net>,
        Alice Ryhl <alice@ryhl.io>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>
Subject: Re: [PATCH v2 2/2] rust: arc: remove `ArcBorrow` in favour of
 `WithRef`
Message-ID: <ZRMYObRby6NDKNzD@boqun-archlinux>
References: <9d6d6c94-5da6-a56d-4e85-fbf8da26a0b0@proton.me>
 <ZRIB0hXNvmJtmyak@boqun-archlinux>
 <edc0b599-c5d1-4e9c-a51b-eb8ceaef7acc@ryhl.io>
 <ZRIDc_x9Qh5EJNC8@boqun-archlinux>
 <61ccfb87-54fd-3f1b-105c-253d0350cd56@proton.me>
 <20230926162659.6555bcdc@gary-lowrisc-laptop>
 <ZRL3mlWXqseER8xK@Boquns-Mac-mini.home>
 <CAH5fLggUPQtNjLg6BnYHcLmefuHdJpg0_eGVgX+dARUTRHexsA@mail.gmail.com>
 <ZRMIOsi6-GjFaYLW@Boquns-Mac-mini.home>
 <a4090608-d352-742b-fe5e-054db3a8e4a5@proton.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a4090608-d352-742b-fe5e-054db3a8e4a5@proton.me>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2023 at 05:15:52PM +0000, Benno Lossin wrote:
> On 26.09.23 18:35, Boqun Feng wrote:
> > On Tue, Sep 26, 2023 at 05:41:17PM +0200, Alice Ryhl wrote:
> >> On Tue, Sep 26, 2023 at 5:24 PM Boqun Feng <boqun.feng@gmail.com> wrote:
> >>>
> >>> On Tue, Sep 26, 2023 at 04:26:59PM +0800, Gary Guo wrote:
> >>>> On Mon, 25 Sep 2023 22:26:56 +0000
> >>>> Benno Lossin <benno.lossin@proton.me> wrote:
> >>>>
> >>> [...]
> >>>>>
> >>>>> The pointer was originally derived by a call to `into_raw`:
> >>>>> ```
> >>>>>       pub fn into_raw(self) -> *const T {
> >>>>>           let ptr = self.ptr.as_ptr();
> >>>>>           core::mem::forget(self);
> >>>>>           // SAFETY: The pointer is valid.
> >>>>>           unsafe { core::ptr::addr_of!((*ptr).data) }
> >>>>>       }
> >>>>> ```
> >>>>> So in this function the origin (also the origin of the provenance)
> >>>>> of the pointer is `ptr` which is of type `NonNull<WithRef<T>>`.
> >>>>> Raw pointers do not lose this provenance information when you cast
> >>>>> it and when using `addr_of`/`addr_of_mut`. So provenance is something
> >>>>> that is not really represented in the type system for raw pointers.
> >>>>>
> >>>>> When doing a round trip through a reference though, the provenance is
> >>>>> newly assigned and thus would only be valid for a `T`:
> >>>>> ```
> >>>>> let raw = arc.into_raw();
> >>>>> let reference = unsafe { &*raw };
> >>>>> let raw: *const T = reference;
> >>>>> let arc = unsafe { Arc::from_raw(raw) };
> >>>>> ```
> >>>>> Miri would complain about the above code.
> >>>>>
> >>>>
> >>>> One thing we can do is to opt from strict provenance, so:
> >>>>
> >>>
> >>> A few questions about strict provenance:
> >>>
> >>>> ```
> >>>> let raw = arc.into_raw();
> >>>> let _ = raw as usize; // expose the provenance of raw
> >>>
> >>> Should this be a expose_addr()?
> >>
> >> Pointer to integer cast is equivalent to expose_addr.
> >>
> >>>> let reference = unsafe { &*raw };
> >>>> let raw = reference as *const T as usize as *const T;
> >>>
> >>> and this is a from_exposed_addr{_mut}(), right?
> >>
> >> Integer to pointer cast is equivalent to from_exposed_addr.
> >>
> > 
> > Got it, thanks!
> > 
> >>>> let arc = unsafe { Arc::from_raw(raw) };
> >>>> ```
> >>>>
> >>>
> >>> One step back, If we were to use strict provenance API (i.e.
> >>> expose_addr()/from_exposed_addr()), we could use it to "fix" the
> >>> original problem? By:
> >>>
> >>> *       expose_addr() in as_with_ref()
> >>> *       from_exposed_addr() in `impl From<&WithRef<T>> for Arc`
> >>>
> >>> right?
> >>>
> >>> More steps back, is the original issue only a real issue under strict
> >>> provenance rules? Don't make me wrong, I like the ideas behind strict
> >>> provenance, I just want to check, if we don't enable strict provenance
> >>> (as a matter of fact, we don't do it today),
> >>
> >> Outside of miri, strict provenance is not really something you enable.
> >> It's a set of rules that are stricter than the real rules, that are
> >> designed such that when you follow them, your code will be correct
> >> under any conceivable memory model we might end up with. They will
> >> never be the rules that the compiler actually uses.
> >>
> >> I think by "opt out from strict provenance", Gary just meant "use
> >> int2ptr and ptr2int casts to reset the provenance".
> >>
> >>> will the original issue found by Alice be a UB?
> >>
> >> Yes, it's UB under any ruleset that exists out there. There's no flag
> >> to turn it off.
> >>
> >>> Or is there a way to disable Miri's check on
> >>> strict provenance? IIUC, the cause of the original issue is that "you
> >>> cannot reborrow a pointer derived from a `&` to get a `&mut`, even when
> >>> there is no other alias to the same object". Maybe I'm still missing
> >>> something, but without strict provenance, is this a problem? Or is there
> >>> a provenance model of Rust without strict provenance?
> >>
> >> It's a problem under all of the memory models. The rule being violated
> >> is exactly the same rule as the one behind this paragraph:
> >>
> >>> Transmuting an & to &mut is Undefined Behavior. While certain usages may appear safe, note that the Rust optimizer is free to assume that a shared reference won't change through its lifetime and thus such transmutation will run afoul of those assumptions. So:
> >>>
> >>> Transmuting an & to &mut is always Undefined Behavior.
> >>> No you can't do it.
> >>> No you're not special.
> >> From: https://doc.rust-lang.org/nomicon/transmutes.html
> > 
> > But here the difference it that we only derive a `*mut` from a `&`,
> > rather than transmute to a `&mut`, right? We only use `&` to get a
> > pointer value (a usize), so I don't think that rule applies here? Or in
> > other words, does the following implemenation look good to you?
> > 
> > 	impl<T: ?Sized> Arc<T> {
> > 	    pub fn as_with_ref(&self) -> &WithRef<T> {
> > 		// expose
> > 		let _ = self.ptr.as_ptr() as usize;
> > 		unsafe { self.ptr.as_ref() }
> > 	    }
> > 	}
> > 
> > 	impl<T: ?Sized> From<&WithRef<T>> for Arc<T> {
> > 	    fn from(b: &WithRef<T>) -> Self {
> > 		// from exposed
> > 		let ptr = unsafe { NonNull::new_unchecked(b as *const _ as usize as *mut _) };
> > 		// SAFETY: The existence of `b` guarantees that the refcount is non-zero. `ManuallyDrop`
> > 		// guarantees that `drop` isn't called, so it's ok that the temporary `Arc` doesn't own the
> > 		// increment.
> > 		ManuallyDrop::new(unsafe { Arc::from_inner(ptr) })
> > 		    .deref()
> > 		    .clone()
> > 	    }
> > 	}
> > 
> > 
> > An equivalent code snippet is as below (in case anyone wants to try it
> > in miri):
> > ```rust
> >      let raw = Box::into_raw(arc);
> > 
> >      // as_with_ref()
> >      let _ = raw as usize;
> >      let reference = unsafe { &*raw };
> > 
> >      // from()
> >      let raw: *mut T = reference as *const _ as usize as  *mut _ ;
> > 
> >      // drop()
> >      let arc = unsafe { Box::from_raw(raw) };
> > ```
> 
> I don't understand why we are trying to use ptr2int to fix this.
> Simply wrapping the `T` field inside `WithRef` with `UnsafeCell`
> should be enough.
> 

To me (and maybe the same for Wedson), it's actually Ok that we don't do
the change (i.e. the ArcBorrow -> &WithRef) at all. It's more a
code/concept simplification.

Fixing with an `UnsafeCell` seems more like a workaround to me, because
there is no interior mutable requirement here, so I just don't want to
patch something unnecessary here just to make things work.

Put it in another way, if `UnsafeCell` can fix this and no interior
mutability is needed, we probably can fix this with another way or there
is an API like `UnsafeCell` is missing here.

Sorry for being stubborn here ;-) But I really want to find a better
solution for the similar problems.

What's the shortcoming of ptr2int?

Regards,
Boqun

> -- 
> Cheers,
> Benno
> 
> 
