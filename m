Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C227753EAE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 17:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236281AbjGNPVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 11:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235850AbjGNPVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 11:21:17 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28DA3270A;
        Fri, 14 Jul 2023 08:21:15 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-98e011f45ffso252717466b.3;
        Fri, 14 Jul 2023 08:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689348073; x=1691940073;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B6EWyZrZTRUnDLqfmzBc9BCzhKd7v1QVcOcDm6JSV+s=;
        b=EMWTX/o66jAYPaLdDO9WokfvxmdzqLwCazsDOLmdp91IiV+2HgwyPKHHC212eXc1MR
         0QdQIvkUuqhgoKmymajEDGbm0RRrzlVgmv1JX0Ei8ZgN9Pv7vFg5PDxX9gP2ZDre6rg2
         gMuFKULYyp0MnJFq0BJNAda3kAXZUYGYRs6c8RYd5cZ2tZuVY98zwWFNpjtwZCZUtKA+
         He29roOFPku2r/nywCj0eNHS1CSQAZp/77qXGwB7HnkheRyUdi5M3VW+dSl2jxrMgRVQ
         toKJQd8pEnMQqamb6Zqp8Pg9i63/xoXHgWE+KJkjOep2eCACpZNSPwXthxmBSkXmt3qg
         v0rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689348073; x=1691940073;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B6EWyZrZTRUnDLqfmzBc9BCzhKd7v1QVcOcDm6JSV+s=;
        b=iF54VBD0ZqMqAPUn5hU/oZt12P8peC56itV1ubl+ntq+itD7VYN+6s4DovvcwZ9RIM
         ljldVSrmBhrY4A2vHYkx5LrxZPRxkyCyWnkiwN8djU5E9bJPIVx6nIeMeAV2g4r+BukP
         p0nyOCwghzIBCOCatbGljro6G5aAntZl9+HEjHkKyVFzMq+sm6ljmaKwifyP/6adcYf4
         6OsIHRfNT1gGWWAnAnd+AhLMpekLGjbOJozy0DSh9Ky8qjwmMnACxkDwuO2XwMZQ8Ydq
         Oq953hZBZEzmICP7fxijhye5xqGYFa5G8y8nr86AHql5sG8TobBmLXOuCVKfg/q7+Bc2
         pltA==
X-Gm-Message-State: ABy/qLauEpEobS2mQVXr4LowSME8n9r3Om2oM6gqvE2YC0GH+CFueIiV
        KlV5AnNtaV7+06K1NRZ03M8=
X-Google-Smtp-Source: APBJJlGsjormWvTRUCS9mKkmz2zcSCRmFetdfRsijk7Xv2zqTZvKLFQk2WTTGK3htj/KSCVnQZTghg==
X-Received: by 2002:a17:906:7496:b0:993:d617:bdc8 with SMTP id e22-20020a170906749600b00993d617bdc8mr4727852ejl.7.1689348073313;
        Fri, 14 Jul 2023 08:21:13 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id kb9-20020a1709070f8900b009894b476310sm5521816ejc.163.2023.07.14.08.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 08:21:12 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 9581C27C0054;
        Fri, 14 Jul 2023 11:21:09 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 14 Jul 2023 11:21:09 -0400
X-ME-Sender: <xms:42exZHFPnmnsqSlvpoTzDYBO-Hgb1dxQChEn4pHv5LtIRI_JIBw5gw>
    <xme:42exZEV16bWU57L3_42vg1gVIj_P_ukRuOBXUAbHI_nCEM3-cCZiTNZ9_SC3NzdBz
    mVpiVTbUGPxgCU9tA>
X-ME-Received: <xmr:42exZJJEvxzBMTzqlWg1PUUEuQdYZq-Z6yIrk7yWWHGoynDmKcAULvYRyog>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrfeeigdekjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveeiudff
    iedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    hoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieeg
    qddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigi
    hmvgdrnhgrmhgv
X-ME-Proxy: <xmx:42exZFHKhiwCooNTRUdv0BNUxOhJ-iXXTsePesVzkInkwuGCP1PXnA>
    <xmx:42exZNWuGAydsuDWN5_PvTJAlx5RLryDzSAuAuvBEltQ0D-LOHAlOw>
    <xmx:42exZANr2LZxAbKe3uN9CvOfrsgE4fDZrQJq0wtWod9uchSb5K82sw>
    <xmx:5WexZCep91DeCSedF65Yb2bAlc2T5_cCSWJlQJ5oHdPwWWnp1JYc6g>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Jul 2023 11:21:07 -0400 (EDT)
Date:   Fri, 14 Jul 2023 08:21:05 -0700
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Alice Ryhl <aliceryhl@google.com>
Cc:     lina@asahilina.net, alex.gaynor@gmail.com, alyssa@rosenzweig.io,
        asahi@lists.linux.dev, benno.lossin@proton.me,
        bjorn3_gh@protonmail.com, daniel@ffwll.ch, gary@garyguo.net,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, marcan@marcan.st, masahiroy@kernel.org,
        nathan@kernel.org, ndesaulniers@google.com, nicolas@fjasle.eu,
        ojeda@kernel.org, rust-for-linux@vger.kernel.org,
        sven@svenpeter.dev, trix@redhat.com, wedsonaf@gmail.com
Subject: Re: [PATCH RFC 00/11] rust: Implicit lock class creation & Arc
 Lockdep integration
Message-ID: <ZLFn4RPiK3ig9I5M@Boquns-Mac-mini.home>
References: <f974e5a4-1211-5ad7-4864-f3e210499e5e@asahilina.net>
 <20230714135926.382695-1-aliceryhl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230714135926.382695-1-aliceryhl@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2023 at 01:59:26PM +0000, Alice Ryhl wrote:
> Asahi Lina <lina@asahilina.net> writes:
> > On 14/07/2023 19.13, Alice Ryhl wrote:
> > > Asahi Lina <lina@asahilina.net> writes:
> > >> Begone, lock classes!
> > >>
> > >> As discussed in meetings/etc, we would really like to support implicit
> > >> lock class creation for Rust code. Right now, lock classes are created

Thanks for looking into this! Could you also copy locking maintainers in
the next version?

> > >> using macros and passed around (similar to C). Unfortunately, Rust
> > >> macros don't look like Rust functions, which means adding lockdep to a
> > >> type is a breaking API change. This makes Rust mutex creation rather
> > >> ugly, with the new_mutex!() macro and friends.
> > >>
> > >> Implicit lock classes have to be unique per instantiation code site.
> > >> Notably, with Rust generics and monomorphization, this is not the same
> > >> as unique per generated code instance. If this weren't the case, we
> > >> could use inline functions and asm!() magic to try to create lock
> > >> classes that have the right uniqueness semantics. But that doesn't work,
> > >> since it would create too many lock classes for the same actual lock
> > >> creation in the source code.
> > >>
> > >> But Rust does have one trick we can use: it can track the caller
> > >> location (as file:line:column), across multiple functions. This works
> > >> using an implicit argument that gets passed around, which is exactly the
> > >> thing we do for lock classes. The tricky bit is that, while the value of
> > >> these Location objects has the semantics we want (unique value per
> > >> source code location), there is no guarantee that they are deduplicated
> > >> in memory.
> > >>
> > >> So we use a hash table, and map Location values to lock classes. Et
> > >> voila, implicit lock class support!
> > >>
> > >> This lets us clean up the Mutex & co APIs and make them look a lot more
> > >> Rust-like, but it also means we can now throw Lockdep into more APIs
> > >> without breaking the API. And so we can pull a neat trick: adding
> > >> Lockdep support into Arc<T>. This catches cases where the Arc Drop
> > >> implementation could create a locking correctness violation only when
> > >> the reference count drops to 0 at that particular drop site, which is
> > >> otherwise not detectable unless that condition actually happens at
> > >> runtime. Since Drop is "magic" in Rust and Drop codepaths very difficult
> > >> to audit, this helps a lot.
> > >>
> > >> For the initial RFC, this implements the new API only for Mutex. If this
> > >> looks good, I can extend it to CondVar & friends in the next version.
> > >> This series also folds in a few related minor dependencies / changes
> > >> (like the pin_init mutex stuff).
> > > 
> > > I'm not convinced that this is the right compromise. Moving lockdep
> > > class creation to runtime sounds unfortunate, especially since this
> > > makes them fallible due to memory allocations (I think?).
> > > 
> > > I would be inclined to keep using macros for this.
> > 
> > Most people were very enthusiastic about this change in the meetings... 
> > it wasn't even my own idea ^^
> 
> I don't think I was in that meeting. Anyway,
>  
> > I don't think the fallibility is an issue. Lockdep is a debugging tool, 
> > and it doesn't have to handle all possible circumstances perfectly. If 
> > you are debugging normal lock issues you probably shouldn't be running 
> > out of RAM, and if you are debugging OOM situations the lock keys would 
> > normally have been created long before you reach an OOM situation, since 
> > they would be created the first time a relevant lock class is used. More 
> > objects of the same class don't cause any more allocations. And the code 
> > has a fallback for the OOM case, where it just uses the Location object 
> > as a static lock class. That's not ideal and degrades the quality of the 
> > lockdep results, but it shouldn't completely break anything.
> 
> If you have a fallback when the allocation fails, that helps ...
> 
> You say that Location objects are not necessarily unique per file
> location. In practice, how often are they not unique? Always just using
> the Location object as a static lock class seems like it would
> significantly simplify this proposal.
> 

Agreed. For example, `caller_lock_class_inner` has a Mutex critical
section in it (for the hash table synchronization), that makes it
impossible to be called in preemption disabled contexts, which limits
the usage.

Regards,
Boqun

> > The advantages of being able to throw lockdep checking into arbitrary 
> > types, like the Arc<T> thing, are pretty significant. It closes a major 
> > correctness checking issue we have with Rust and its automagic Drop 
> > implementations that are almost impossible to properly audit for 
> > potential locking issues. I think that alone makes this worth it, even 
> > if you don't use it for normal mutex creation...
> 
> I do agree that there is value in being able to more easily detect
> potential deadlocks involving destructors of ref-counted values. I once
> had a case of that myself, though lockdep was able to catch it without
> this change because it saw the refcount hit zero in the right place.
> 
> Alice
> 
