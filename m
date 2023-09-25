Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB007ADC97
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 18:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232187AbjIYQDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 12:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIYQDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 12:03:03 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADCE092;
        Mon, 25 Sep 2023 09:02:56 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-99bdcade7fbso812760066b.1;
        Mon, 25 Sep 2023 09:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695657775; x=1696262575; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d2UmPgaSrDYavCWMmIxY3UB+Wc5RLpCTVeJXM3UZ7x4=;
        b=GhN+nUeGn2VybaIu1e0/GPXKutMutXW8awkVK50JMM6EJP2HKfzgB5+rbKzNdMq5O6
         ER63EeB+yGX1KUnviQeQGs5cYjlXGZzEHLptZotFs4Za6SXy1l+3lC7lWANYHfe9wdRR
         7vhM3xK0fKcmbCeo/THV9vAGVWBQvvEHsqQdTCVpZVviQkVIPiduNBHffiJFkhK0XeYS
         2RSr/GnrsZZb9q4+rnBCMWnmGoRgmHr7H0rDEl+GMrxwl9wa5aOuILtAO/og/z3B3ZIi
         VxbJO6ClTJl5ZJ0amPILnVXokEN8JuKFbOGqw1OtAKxric7fB05Z/68h9c9LNNMCoXdi
         D7Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695657775; x=1696262575;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d2UmPgaSrDYavCWMmIxY3UB+Wc5RLpCTVeJXM3UZ7x4=;
        b=V3khMeYydaANPYkTEz2VcaanRYCTsE6zJBaEToQbiwMwFjfi3XjBbwdJboUpr79J8B
         WL6GhkG0muJiTUFxbX+g9smlLCU9iEkAezplT29rMXdaViH5bd4arpnY3wnugurOtwQL
         5lAkn+EK9p3VEktKU9xFjGLkQRF/lNKopLVCtDjsEcU+Y+RckLEvLEKS+liFbXdH/AI6
         Rz4U+N64cngwPn3MJRqDr4PwybOaem426V/vV/J4/JwZSofN8qZQYVYyIBXBy5Vldpmo
         O/R7uFvsHNXlpDYFlMp1J8t4yoJ5rQOox5aw6MfJ8TYklrnqTR/pwRjUpyUsWTaDMZhR
         2ciQ==
X-Gm-Message-State: AOJu0YwR+yDk5dcV2sEWPrXhMstYXxFkmhuXNMag8EZaWV5NL/+ZO5F6
        2JsnMLrcF5jlDlRyKY4UvsQ=
X-Google-Smtp-Source: AGHT+IHXWW8FgENY2i1TZ92MCSuBa9qUKEpJiJATcz+PcVQHsEMoJnNdLCGCH5PcI1VFy5IacyUshw==
X-Received: by 2002:a17:906:53d8:b0:9ae:5643:6493 with SMTP id p24-20020a17090653d800b009ae56436493mr5955062ejo.74.1695657774826;
        Mon, 25 Sep 2023 09:02:54 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id q26-20020a1709064c9a00b009ad87fd4e65sm6537614eju.108.2023.09.25.09.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 09:02:54 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailauth.nyi.internal (Postfix) with ESMTP id 0359127C0060;
        Mon, 25 Sep 2023 12:02:52 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 25 Sep 2023 12:02:52 -0400
X-ME-Sender: <xms:Kq8RZQbXlFQPvdiCKyHpfE0ODOpy_dHsdxb1zVIeXGbXFh3cMW_eow>
    <xme:Kq8RZbYNDXIvi3DIHN7J3mqV5KtsyfxKRW-4gNm8zBBIUuMODnq-KdboxbzffwqKE
    zpp9xc5VaUXE0P1Pg>
X-ME-Received: <xmr:Kq8RZa-yCLnW5SHYEKFk6HB1QLIMrOzmpfIctQWR-C9D_fRZNvai_jQX_1E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudelgedgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtrodttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeeitdefvefhteeklefgtefhgeelkeefffelvdevhfehueektdevhfettddv
    teevvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:Kq8RZaq6dFl4q3vDLWgHyr4T-l69mIMqvK7xdQglkTbwyNMBVsVFRg>
    <xmx:Kq8RZbr6Y7PiSr7tzy4Y4A-oh0QG-PDB235RZ5JBBUFeSARpvXn5GA>
    <xmx:Kq8RZYR5MyWI-D77CpGEsPs5s6b2UuqrBpqOnmX5BkY49CnzOBd6YA>
    <xmx:LK8RZUT1aqdTAfLof0ZYVwLN_-VIPD-evpBJcQ40Z31VZaxB67CDZA>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Sep 2023 12:02:49 -0400 (EDT)
Date:   Mon, 25 Sep 2023 09:02:48 -0700
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Alice Ryhl <alice@ryhl.io>
Cc:     Alice Ryhl <aliceryhl@google.com>, a.hindborg@samsung.com,
        alex.gaynor@gmail.com, benno.lossin@proton.me,
        bjorn3_gh@protonmail.com, gary@garyguo.net,
        linux-kernel@vger.kernel.org, ojeda@kernel.org,
        rust-for-linux@vger.kernel.org, walmeida@microsoft.com,
        wedsonaf@gmail.com
Subject: Re: [PATCH v2 2/2] rust: arc: remove `ArcBorrow` in favour of
 `WithRef`
Message-ID: <ZRGvKPhgJXWfluyZ@Boquns-Mac-mini.home>
References: <ZRGd4lsNP30L2yB3@Boquns-Mac-mini.home>
 <20230925150047.1961646-1-aliceryhl@google.com>
 <ZRGknJCB6tFgX3Gr@Boquns-Mac-mini.home>
 <0b7fc71c-b3c7-4c29-92a9-587daa46ad59@ryhl.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b7fc71c-b3c7-4c29-92a9-587daa46ad59@ryhl.io>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 05:30:05PM +0200, Alice Ryhl wrote:
> On 9/25/23 17:17, Boqun Feng wrote:
> > On Mon, Sep 25, 2023 at 03:00:47PM +0000, Alice Ryhl wrote:
> > > > > > I'm concerned about this change, because an `&WithRef<T>` only has
> > > > > > immutable permissions for the allocation. No pointer derived from it
> > > > > > may be used to modify the value in the Arc, however, the drop
> > > > > > implementation of Arc will do exactly that.
> > > > > 
> > > > > That is indeed a problem. We could put the value in an `UnsafeCell`, but
> > > > > that would lose us niche optimizations and probably also other optimizations.
> > > > > 
> > > > 
> > > > Not sure I understand the problem here, why do we allow modifying the
> > > > value in the Arc if you only have a shared ownership?
> > > 
> > > Well, usually it's when you have exclusive access even though the value
> > > is in an `Arc`.
> > > 
> > > The main example of this is the destructor of the `Arc`. When the last
> > > refcount drops to zero, this gives you exclusive access. This lets you
> > > run the destructor. The destructor requires mutable access.
> > > 
> > > Another example would be converting the `Arc` back into an `UniqueArc`
> > > by checking that the refcount is 1. Once you have a `UniqueArc`, you can
> > > use it to mutate the inner value.
> > > 
> > > Finally, there are methods like `Arc::get_mut_unchecked`, where you
> > > unsafely assert that nobody else is using the value while you are
> > > modifying it. We don't have that in our version of `Arc` right now, but
> > > we might want to add it later.
> > > 
> > 
> > Hmm.. but the only way to get an `Arc` from `&WithRef` is
> > 
> > 	impl From<&WithRef<T>> for Arc<T> {
> > 	    ...
> > 	}
> > 
> > , and we clone `Arc` in the that function (i.e. copying the raw
> > pointer), so we are still good?
> > 
> 
> No, the raw pointer in the Arc was created from the immutable reference, so
> the raw pointer has the same restrictions as the immutable reference did.
> 

I see, this was the part I was missing. Thanks!

Looks like the only fix is replacing `&WithRef<T>` with
`&UnsafeCell<WithRef<T>>`? But that's a bit wordy and I'm not sure
whether it's better than `ArcBorrow<'_, T>`...

Regards,
Boqun

> Alice
