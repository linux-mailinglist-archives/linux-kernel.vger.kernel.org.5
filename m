Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F88D7AEF8C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 17:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233955AbjIZPY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 11:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbjIZPY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 11:24:26 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D675C116;
        Tue, 26 Sep 2023 08:24:18 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9adb9fa7200so2022015466b.0;
        Tue, 26 Sep 2023 08:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695741857; x=1696346657; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TToXKTah65ZF4FvTwYn3ycaEKUB3HzvBDx4LOXb4agc=;
        b=P+U4KcTmAtd1y6VPjzB455x7MDJtgEFkaYipRW7go8jo+BnIWT6iYlHGp1PqGT9QaP
         XMUDANVGomYXojcFlIEAn4Ao2QMQ+343BKnqASXWAwEB0zzXieEymx4XgGrQEBZDYxrp
         fINR15pIYBiuOJ2qm9PAv3TDVNGLCUmSqFmeBKq16ISuYG3Gd1ExrtRQ7ME+iSsmdf4l
         0cFtTFCS3LdXboMsZQEAB/qEENLEfhfx+iXRFhOwbJaDmNkIIE6iZIRiA0Z5b6G180Ul
         G+reSzupLpHhsu8wLi0+JUi6qpxQEnHTsXOR9RiKk1dp4k304dokPEA9c9B+R1wtoqx7
         JiYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695741857; x=1696346657;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TToXKTah65ZF4FvTwYn3ycaEKUB3HzvBDx4LOXb4agc=;
        b=UHl5WhYWcxoQMF4r73w5PtbQHdlGGTgOvpgvBTd99kRQt9h0U14cgGy6pHY3DQXhbp
         Jt2ptK9oNmVxqHzyaM1R2yn0bDPCGDnIaxP26fLf0nITBRWTyK4PfMxLC0ueBnHtKwAI
         zEh3xEPOPPNFuy/q/3DcRDbuiyEkdb7pUpMWgwDRGQg5jdUUZqKA7EIAYgkK9YdyVbrc
         zpdaEai6e7oT6qqV4mKRdtayG3qA2WIPDdodWbZUJ5Cpsw1Ju2OQCj2HTpHBcxBpcLuW
         3CKgDMMJBbnwIE+qxJF2zmZTUFLaPSaULE7dg7lfJuxYQq4rSO4h9D+F/BNK7c9oPWPr
         YqTQ==
X-Gm-Message-State: AOJu0Yx/FIJ+KVxOhxwQpb2wQze5sbmG9BFU5FU/RooFMF/zyghXDwGP
        x10qzZpuXPYXq4Gc7K9RHTo=
X-Google-Smtp-Source: AGHT+IFMNTCvp6Ivt4/5Hq8TYHYZg3LPpGv8htJYJYZ2sn1FaxGruh2TpVzD5BNZPbGzcXulA/sBvg==
X-Received: by 2002:a17:907:75c2:b0:9a9:f042:deb9 with SMTP id jl2-20020a17090775c200b009a9f042deb9mr4400864ejc.19.1695741857040;
        Tue, 26 Sep 2023 08:24:17 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id x18-20020a170906b09200b0099c53c44083sm7923906ejy.79.2023.09.26.08.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 08:24:16 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 2665727C0054;
        Tue, 26 Sep 2023 11:24:14 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 26 Sep 2023 11:24:14 -0400
X-ME-Sender: <xms:nPcSZb37smFAezOWa4MyJebsZ36Tjlvoue6n9GcWq71-_HosHjUxyg>
    <xme:nPcSZaEZk6cOIOV9DTb7FivhDdLbWBf2jkHKd2EL8hfTRBVfUQGiV6GhlgDFHCsmX
    j02kCwZhYJR9cmyNQ>
X-ME-Received: <xmr:nPcSZb7ndLih9kECBp3MyF6Yy46ne0OWLZzfyLPbCrpo13oEm23iT6gQx8M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvjedrtddtgdehkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhephfekudfhfeffvdfhhfdvtefhveffhfeftdefvdehjeegkeeftdeggfevfffh
    veeknecuffhomhgrihhnpehpthhrrdgrshenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshho
    nhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngh
    eppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:nPcSZQ3MBj7-E4n2h-qGjcfLrgGDKveMjRBxIovcEMh-3jBqfT2O2g>
    <xmx:nPcSZeFTeCLd_wdwQ2Vn9t1ReWKv2Eb9xchE3-W-wYRAdeNFo7f7Fw>
    <xmx:nPcSZR956rqL1eaLDvhtV1m6JJ_GbWOmJHvMLd2KoGzGOmd5Y3Z-Nw>
    <xmx:nvcSZZ8RHQsLPMT4O6RaUjk7AlqpbWW6WFtN053WeZVqn_7yC0xGKg>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Sep 2023 11:24:12 -0400 (EDT)
Date:   Tue, 26 Sep 2023 08:24:10 -0700
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Gary Guo <gary@garyguo.net>
Cc:     Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <alice@ryhl.io>,
        Alice Ryhl <aliceryhl@google.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>
Subject: Re: [PATCH v2 2/2] rust: arc: remove `ArcBorrow` in favour of
 `WithRef`
Message-ID: <ZRL3mlWXqseER8xK@Boquns-Mac-mini.home>
References: <14513589-cc31-8985-8ff6-a97d2882f593@proton.me>
 <ZRGyRQuBcWvgtdNR@Boquns-Mac-mini.home>
 <9d6d6c94-5da6-a56d-4e85-fbf8da26a0b0@proton.me>
 <ZRHWqbvYlXBXEOh-@boqun-archlinux>
 <c5134a1a-a60d-73bb-9faa-aa1dfc3bc30d@proton.me>
 <ZRIB0hXNvmJtmyak@boqun-archlinux>
 <edc0b599-c5d1-4e9c-a51b-eb8ceaef7acc@ryhl.io>
 <ZRIDc_x9Qh5EJNC8@boqun-archlinux>
 <61ccfb87-54fd-3f1b-105c-253d0350cd56@proton.me>
 <20230926162659.6555bcdc@gary-lowrisc-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230926162659.6555bcdc@gary-lowrisc-laptop>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2023 at 04:26:59PM +0800, Gary Guo wrote:
> On Mon, 25 Sep 2023 22:26:56 +0000
> Benno Lossin <benno.lossin@proton.me> wrote:
> 
[...]
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
> > 
> > When doing a round trip through a reference though, the provenance is
> > newly assigned and thus would only be valid for a `T`:
> > ```
> > let raw = arc.into_raw();
> > let reference = unsafe { &*raw };
> > let raw: *const T = reference;
> > let arc = unsafe { Arc::from_raw(raw) };
> > ```
> > Miri would complain about the above code.
> > 
> 
> One thing we can do is to opt from strict provenance, so:
> 

A few questions about strict provenance:

> ```
> let raw = arc.into_raw();
> let _ = raw as usize; // expose the provenance of raw

Should this be a expose_addr()?

> let reference = unsafe { &*raw };
> let raw = reference as *const T as usize as *const T;

and this is a from_exposed_addr{_mut}(), right?

> let arc = unsafe { Arc::from_raw(raw) };
> ```
> 

One step back, If we were to use strict provenance API (i.e.
expose_addr()/from_exposed_addr()), we could use it to "fix" the
original problem? By:

*	expose_addr() in as_with_ref()
*	from_exposed_addr() in `impl From<&WithRef<T>> for Arc`

right?

More steps back, is the original issue only a real issue under strict
provenance rules? Don't make me wrong, I like the ideas behind strict
provenance, I just want to check, if we don't enable strict provenance
(as a matter of fact, we don't do it today), will the original issue
found by Alice be a UB? Or is there a way to disable Miri's check on
strict provenance? IIUC, the cause of the original issue is that "you
cannot reborrow a pointer derived from a `&` to get a `&mut`, even when
there is no other alias to the same object". Maybe I'm still missing
something, but without strict provenance, is this a problem? Or is there
a provenance model of Rust without strict provenance?

Regards,
Boqun
