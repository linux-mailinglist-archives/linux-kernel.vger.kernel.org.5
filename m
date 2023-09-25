Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 405C17ADB2D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 17:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232038AbjIYPSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 11:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbjIYPSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 11:18:01 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A509C;
        Mon, 25 Sep 2023 08:17:54 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-99c93638322so1517828366b.1;
        Mon, 25 Sep 2023 08:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695655073; x=1696259873; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cp05RJcC1kdlonhGXdkkByIHpEVtVJUJziov6gnH670=;
        b=ZFVqU31W2m8GZQlgRKzGzniC2VYw+yfFaqsIsn0Q7VzHrk9gxtsY89C/Zm2R+rPD8R
         W5es7notYtwI/Nj4o10WnuCgaTaSpMMhsXyiAnwsGmQka2bMRnZtFDTQKBpWPe3jSXaN
         NHXpuOHzah/sTxd2GfkZlBCUv5Tf4RauYzRHWreamswERK5Z9ezqE54i5jRv4rkU5jfO
         GzV/UBoWCmYr58fbWHLSN/EvmXRbHj2O1eJMg/SqTOXBdGYwebPow7+HdSwCF0kt+mtY
         DX+zz80/amZ7pyIq4XUdWoz4dAViqcD9b4vZcmG+N9SdRaEoGzohRCdcfniUYxUVB5wF
         fnjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695655073; x=1696259873;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cp05RJcC1kdlonhGXdkkByIHpEVtVJUJziov6gnH670=;
        b=i/5Yjs+VGRsQMZaDsAmHS59Fey45NEjbCWqf4AqywIH5G6PsUSjnc9zvMKsZrdhPce
         N7jBVs8XG/7b2YANH+djZQRvSHFeJZiFws+3DTNWbn2lmKd/K1Q+b7ZYwvP2OiXlkt/I
         Is1cZoOETjfOdT//8lYs6v0O13Om5e4UcV/7YyOgItHbRfts3niHGLidGiZG+7XbpM6Z
         p7lHF1vlmw7k7PHqtf7I+z5/V3rI9L9dLY+BXCEvb5y8fxa8eBQ31KRh3LjRWhtRsyar
         BSdDolX32aWdeeCn1W6Yomt1NUcJHgAG1uU7w4CiMm22DGTob6RQSoYtrdZgsjHeFxtA
         2DVg==
X-Gm-Message-State: AOJu0Yz8VWFjBiD8uRfnW5U2cdxem3h2CXopHiuH2NJoteDGwoppcykm
        SeUXA2DJxcGBehvbVRA2LEI=
X-Google-Smtp-Source: AGHT+IH17sOAakA6E4KIl7AQ2cJ0ihfCuFvx8Dn3Ay6445MXkQDyU0l3BiWoooFZywY+fEu45pmmzQ==
X-Received: by 2002:a17:907:60cc:b0:9a1:8993:9532 with SMTP id hv12-20020a17090760cc00b009a189939532mr15927357ejc.30.1695655072767;
        Mon, 25 Sep 2023 08:17:52 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id s16-20020a05640217d000b0053420e55616sm1166104edy.75.2023.09.25.08.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 08:17:52 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id 5254527C005C;
        Mon, 25 Sep 2023 11:17:50 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 25 Sep 2023 11:17:50 -0400
X-ME-Sender: <xms:nqQRZQRWdODf_W6EBlylGlOjcBsv_OtE8nAB2yb0Dh3rCSuic2HAYA>
    <xme:nqQRZdxTdiL3aBr9kmz82XXiWcPYd7W8MBBmlqBBok4JxI8HQXsSjU8JnUWYmUUit
    7LvK0QPUgJgyuvt6w>
X-ME-Received: <xmr:nqQRZd206QmrRemHVyTsJp43-uTCAeuHJ4TMunNwxGEIykEEyWzzBrdwwao>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudelgedgkeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:nqQRZUD8n9cX46mi6HI8R3bwLCjTLbBXYP_QGxq7wPCV4GvvVJlp7Q>
    <xmx:nqQRZZirA9NjzTfLdRDOzN3WF13EXe4FcLnegcaanlXSsi1sKaLlXQ>
    <xmx:nqQRZQo8waW6EePgwQ-uB_dAqatYIowUGzdhDRIhVZKx1zM4lTTpgw>
    <xmx:nqQRZeZTjOyuNGyEiyrdGKzIUUEJEN_z0eKd4bPh6_MGL2X00IgNlg>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Sep 2023 11:17:49 -0400 (EDT)
Date:   Mon, 25 Sep 2023 08:17:48 -0700
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Alice Ryhl <aliceryhl@google.com>
Cc:     a.hindborg@samsung.com, alex.gaynor@gmail.com,
        benno.lossin@proton.me, bjorn3_gh@protonmail.com, gary@garyguo.net,
        linux-kernel@vger.kernel.org, ojeda@kernel.org,
        rust-for-linux@vger.kernel.org, walmeida@microsoft.com,
        wedsonaf@gmail.com
Subject: Re: [PATCH v2 2/2] rust: arc: remove `ArcBorrow` in favour of
 `WithRef`
Message-ID: <ZRGknJCB6tFgX3Gr@Boquns-Mac-mini.home>
References: <ZRGd4lsNP30L2yB3@Boquns-Mac-mini.home>
 <20230925150047.1961646-1-aliceryhl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230925150047.1961646-1-aliceryhl@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 03:00:47PM +0000, Alice Ryhl wrote:
> >>> I'm concerned about this change, because an `&WithRef<T>` only has
> >>> immutable permissions for the allocation. No pointer derived from it
> >>> may be used to modify the value in the Arc, however, the drop
> >>> implementation of Arc will do exactly that. 
> >> 
> >> That is indeed a problem. We could put the value in an `UnsafeCell`, but
> >> that would lose us niche optimizations and probably also other optimizations.
> >> 
> > 
> > Not sure I understand the problem here, why do we allow modifying the
> > value in the Arc if you only have a shared ownership?
> 
> Well, usually it's when you have exclusive access even though the value
> is in an `Arc`.
> 
> The main example of this is the destructor of the `Arc`. When the last
> refcount drops to zero, this gives you exclusive access. This lets you
> run the destructor. The destructor requires mutable access.
> 
> Another example would be converting the `Arc` back into an `UniqueArc`
> by checking that the refcount is 1. Once you have a `UniqueArc`, you can
> use it to mutate the inner value.
> 
> Finally, there are methods like `Arc::get_mut_unchecked`, where you
> unsafely assert that nobody else is using the value while you are
> modifying it. We don't have that in our version of `Arc` right now, but
> we might want to add it later.
> 

Hmm.. but the only way to get an `Arc` from `&WithRef` is

	impl From<&WithRef<T>> for Arc<T> {
	    ...
	}

, and we clone `Arc` in the that function (i.e. copying the raw
pointer), so we are still good?

Regards,
Boqun

> > Also I fail to see why `ArcBorrow` doesn't have the problem. Maybe I'm
> > missing something subtle here? Could you provide an example?
> 
> It's because `ArcBorrow` just has a raw pointer inside it. Immutable
> references give up write permissions, but raw pointers don't even if
> they are `*const T`.
> 
> Alice
