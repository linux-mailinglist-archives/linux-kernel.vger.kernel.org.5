Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33E467AF289
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 20:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235315AbjIZSVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 14:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbjIZSVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 14:21:21 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92DFAE5;
        Tue, 26 Sep 2023 11:21:14 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-533edb5ac54so6579968a12.0;
        Tue, 26 Sep 2023 11:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695752473; x=1696357273; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IFaFCx2eXhg+kYgVes9eDxQpvEDaU+z47GYjWRCNqSM=;
        b=MzKSnanZc14lbNKrjRbqvjQVGfq6qiAFqpFgAuLAg8E4TxIIj6Lm2nn3XNmGwi09Pk
         ef9WB4sHL6QtGogLy6FYuh1hin8CZyAZ8a6h1R7KAjbFm60iLG5FHYAv/fR5BEg6JT/b
         PNnJVfOOJcMpjBB9jMjeYN3FHEp5SAJqNly+4omhF5hIWPaFB26KGed39YoYM6tbjRcZ
         vB9xc7FXlWpiugKhBGkUIPtgK2uJNoeTKP5/iRF2f48tgcaxCG1ecZBJArtiJU/2dPWa
         vUl/GVPOVHb/nIxHfhKUqeE0jtSbEP42bpmucAG+p1ELK38fbU2+hZs/zi9Ax3kBT18V
         8cTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695752473; x=1696357273;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IFaFCx2eXhg+kYgVes9eDxQpvEDaU+z47GYjWRCNqSM=;
        b=Sxk+Pmh2o52L5kIqP0X0fcCuRZlfblbjJgmpxB9C8nGgoZhRB+fvPAL5Pjq/4sg4W0
         LIHPwIye+/r+QBCFPAzUCwGY1VTEylgvPE4StQ8rLs4tSgCgxnBVMi63drMMZ/6HSuJM
         07bb9bgCKBLKl7OgmGgYAW9tjz9fAhpdO9EBNd6If2kRAkntGADXmyp1sHPFQPs5+A1h
         3cujgMzriM9LXCnqBrD3xFyBlV7/YxxQrdO25f+pDEdFYrDoMtJG0MAHeKbnO3FKfyLB
         NgC9t5N/ZpuKQCeOjNAXwAgFMKcUAB3+pSfkqMD5D3nzZvTwTPjscj8pmYUG4gW09Trk
         LJTA==
X-Gm-Message-State: AOJu0Yx/C2KjSsupsBxnSf7nlnObPJ4UoX/amf4+kBDK8l+K4L3DS76c
        9GLbCimZg7Jezyf2Fo1+AwM=
X-Google-Smtp-Source: AGHT+IFB1sroSQhXMZMuX6Yue2IV2CKo7/5rEUglTcsDL5Mde2lSgpfWC3LxtXIJPVBwUfLdqiCRSQ==
X-Received: by 2002:a17:906:9b92:b0:9a1:d915:637a with SMTP id dd18-20020a1709069b9200b009a1d915637amr11218733ejc.61.1695752472831;
        Tue, 26 Sep 2023 11:21:12 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id p20-20020a1709060e9400b009ae587ce135sm8062937ejf.223.2023.09.26.11.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 11:21:12 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailauth.nyi.internal (Postfix) with ESMTP id 7256A27C005B;
        Tue, 26 Sep 2023 14:21:10 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 26 Sep 2023 14:21:10 -0400
X-ME-Sender: <xms:FSETZb_JazWP2z2KpHSxH2jPL_W0WkUKqqCDowcZPyd9TkheJBhNfQ>
    <xme:FSETZXucMHz8PzwBRntT5IwXWfZrsD9GKufUEotRAPIsLynqcGo50zM_EDF-3JODM
    mQkUVXrCV1J1VjOxA>
X-ME-Received: <xmr:FSETZZB6DXBhdeSJ3d1yUbv3b5UM6yF2u4feNXaa56bmCuZFoI9Bolv7Dbo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvjedrtddtgdelgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnheptdfffeetffffjefhkeeujeelgeegtddtfeeiffefhefhudffgfduleejudfg
    geejnecuffhomhgrihhnpehpthhrrdgrshdpghgvthdrrghmnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghu
    thhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqh
    hunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:FSETZXf7ffN-gQLXJX5sSNPWTaA-JuCRMJBh4wpwAN8ybd4ekb56tA>
    <xmx:FSETZQPAiBy2aUWOAtn0TbS5CQmxdOeYOXTVqi8bY_jbS1ri1xpB0g>
    <xmx:FSETZZkPZyDlZ8jhzbsRdjqIQ-wZ4mNPW9JnoO9Jhm1aDp4pKXnRlg>
    <xmx:FiETZZk6NLhQKXJl5IPKlNMKK_jkI2OyNbZTRppn5JzS7G15-JoBVQ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Sep 2023 14:21:08 -0400 (EDT)
Date:   Tue, 26 Sep 2023 11:20:35 -0700
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
Message-ID: <ZRMg81kOYlBP023z@boqun-archlinux>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4090608-d352-742b-fe5e-054db3a8e4a5@proton.me>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2023 at 05:15:52PM +0000, Benno Lossin wrote:
[...]
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

BTW, how do you fix this with only wrapping `T` field in `WithRef`?

Let say `WithRef` is defined as:

struct WithRef<T> {
    refcount: Opaque<bindings::refcount_t>,
    data: UnsafeCell<T>,
}


impl<T: ?Sized> From<&WithRef<T>> for Arc<T> {
    fn from(b: &WithRef<T>) -> Self {
        let data_ptr: *mut T = b.data.get();

	let ptr = ?; // how to get a pointer to `WithRef<T>` with the
                     // provenance to the whole data?

        ManuallyDrop::new(unsafe { Arc::from_inner(ptr) })
            .deref()
            .clone()
    }
}

The `data_ptr` above only has provenance to part of the struct for the
similar reason that my proposal of (ab)using `b.refcount.get()`. Am I
missing something here?

Regards,
Boqun

> -- 
> Cheers,
> Benno
> 
> 
