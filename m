Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3B9C7AF62C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 00:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjIZWLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 18:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235925AbjIZWF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 18:05:58 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 330EF23108;
        Tue, 26 Sep 2023 15:05:56 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 500EA5C01AD;
        Tue, 26 Sep 2023 17:27:47 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 26 Sep 2023 17:27:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ryhl.io; h=cc:cc
        :content-transfer-encoding:content-type:content-type:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1695763667; x=1695850067; bh=XDIRBChqlfk/DCrf6Ep9put6x7+MkOaAmB2
        M/1bJBGg=; b=dlZaLUGRzUOqugL8TkI+YnAnX2VMQA7C0U7LcwVOSnUBS8Cr72E
        DQoHCryWsc98H0IbIZ4U04Ai4hp5g/SjV41blLqHFJYWWACflhiwDhEQXgafiLmv
        AOEB7YqV0885r7PNkF+3+WkGKyaWwAYxdhdGPHurq2A4d4q5Hn+E0szWN8yd+m3S
        3KL/RfLgaQSw+21VgvO64mwdlehzDizhAPy7nFVjGQfWuUhcgSwUYzBzv/7lFg7p
        NhN3A6quTirUiCAFkWpdhCpSiTifZwLtXJivIZWhxqZ1QmQBrSeZ3xdR0GDt9Vub
        GOBgMRy8g0Nf3sIpylmWQES3VMdDXjD4SjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1695763667; x=1695850067; bh=XDIRBChqlfk/DCrf6Ep9put6x7+MkOaAmB2
        M/1bJBGg=; b=ATQvZS3Eaqd/4vnP+upZ8VK/IVldczOdiSvHwNonuWMftkMCzty
        +Q4rY2yWBIej9D4Mxn+XlKHFY6jfnJTqYNr+DguEs6T5Q1v59hKTHdUUhCiCJmZZ
        T2Iyr2Ps+8vqCOX31JtLhsOwMrlhqSqZDIgoYJ+XAJmQRmuJcqmYtUKMK+a+3dCI
        yn1fe1y3E9K/RVZZjcyTGJplEjPAn37mZCoWwdy8uY+Ozc+tU1P9maGxT0Zdvdiq
        LU/W/J7aUop+L/WfbXQbuU/2daWYa1NU5yuM3hZB/tbPrU1zI4VGxWYnYZ57jtao
        aJEzZBcNPA46XxOuUCbosFgEFRdH6dlosSw==
X-ME-Sender: <xms:0kwTZWeOmD3obGHAaM7PH2O5OaCgKRhp_tsy5Mn44BYpG1j699L17w>
    <xme:0kwTZQNIzyo0gxVXjktgMF0QQtjvgYsYloNV-bWB-uBDXVAZvke-O0_urt7rzV6St
    ZFhCnVhhWaVPKzWJg>
X-ME-Received: <xmr:0kwTZXizGGnzW3u6QxbbiVDNJz3Smf7UGuhfAPwqGxD_cY6H49diNwnj3qA-nR6BBxn9RTMb1FsIovIWsPJR3JBatNUJw6b92NP5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvjedrtddtgddufeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeetlhhi
    tggvucfthihhlhcuoegrlhhitggvsehrhihhlhdrihhoqeenucggtffrrghtthgvrhhnpe
    fgffeltddtgfetteeukefgieeufedtkefghffgvdeijedutedvvedvgfdulefffeenucff
    ohhmrghinhepphhtrhdrrghspdhgvghtrdgrmhenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhitggvsehrhihhlhdrihho
X-ME-Proxy: <xmx:0kwTZT-mRbjiGtY33C_lR2lgR__nIkL7uYlYR4hqzCb1FUng3DyU2g>
    <xmx:0kwTZSsnXCksEUgm9ORHDtMPR2p9Jrw_F11j_pTdynO1ZIwQF1Ry-Q>
    <xmx:0kwTZaHr903FpAxyZwaxutKUrLLJ7O3eoqDd6Erm2b_lzNcVDX47DA>
    <xmx:00wTZTnalqi3hSHqT8pos5wGk1VyrlCbgYYAWUInjmz85ccbda63wQ>
Feedback-ID: i56684263:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Sep 2023 17:27:44 -0400 (EDT)
Message-ID: <a438231d-8a31-4a3f-932b-3f1e79fa33d9@ryhl.io>
Date:   Tue, 26 Sep 2023 23:27:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] rust: arc: remove `ArcBorrow` in favour of
 `WithRef`
Content-Language: en-US-large
To:     Boqun Feng <boqun.feng@gmail.com>,
        Benno Lossin <benno.lossin@proton.me>
Cc:     Alice Ryhl <aliceryhl@google.com>, Gary Guo <gary@garyguo.net>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>
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
 <ZRMg81kOYlBP023z@boqun-archlinux>
From:   Alice Ryhl <alice@ryhl.io>
In-Reply-To: <ZRMg81kOYlBP023z@boqun-archlinux>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/26/23 20:20, Boqun Feng wrote:
> On Tue, Sep 26, 2023 at 05:15:52PM +0000, Benno Lossin wrote:
> [...]
>>>
>>> But here the difference it that we only derive a `*mut` from a `&`,
>>> rather than transmute to a `&mut`, right? We only use `&` to get a
>>> pointer value (a usize), so I don't think that rule applies here? Or in
>>> other words, does the following implemenation look good to you?
>>>
>>> 	impl<T: ?Sized> Arc<T> {
>>> 	    pub fn as_with_ref(&self) -> &WithRef<T> {
>>> 		// expose
>>> 		let _ = self.ptr.as_ptr() as usize;
>>> 		unsafe { self.ptr.as_ref() }
>>> 	    }
>>> 	}
>>>
>>> 	impl<T: ?Sized> From<&WithRef<T>> for Arc<T> {
>>> 	    fn from(b: &WithRef<T>) -> Self {
>>> 		// from exposed
>>> 		let ptr = unsafe { NonNull::new_unchecked(b as *const _ as usize as *mut _) };
>>> 		// SAFETY: The existence of `b` guarantees that the refcount is non-zero. `ManuallyDrop`
>>> 		// guarantees that `drop` isn't called, so it's ok that the temporary `Arc` doesn't own the
>>> 		// increment.
>>> 		ManuallyDrop::new(unsafe { Arc::from_inner(ptr) })
>>> 		    .deref()
>>> 		    .clone()
>>> 	    }
>>> 	}
>>>
>>>
>>> An equivalent code snippet is as below (in case anyone wants to try it
>>> in miri):
>>> ```rust
>>>       let raw = Box::into_raw(arc);
>>>
>>>       // as_with_ref()
>>>       let _ = raw as usize;
>>>       let reference = unsafe { &*raw };
>>>
>>>       // from()
>>>       let raw: *mut T = reference as *const _ as usize as  *mut _ ;
>>>
>>>       // drop()
>>>       let arc = unsafe { Box::from_raw(raw) };
>>> ```
>>
>> I don't understand why we are trying to use ptr2int to fix this.
>> Simply wrapping the `T` field inside `WithRef` with `UnsafeCell`
>> should be enough.
>>
> 
> BTW, how do you fix this with only wrapping `T` field in `WithRef`?
> 
> Let say `WithRef` is defined as:
> 
> struct WithRef<T> {
>      refcount: Opaque<bindings::refcount_t>,
>      data: UnsafeCell<T>,
> }
> 
> 
> impl<T: ?Sized> From<&WithRef<T>> for Arc<T> {
>      fn from(b: &WithRef<T>) -> Self {
>          let data_ptr: *mut T = b.data.get();
> 
> 	let ptr = ?; // how to get a pointer to `WithRef<T>` with the
>                       // provenance to the whole data?
> 
>          ManuallyDrop::new(unsafe { Arc::from_inner(ptr) })
>              .deref()
>              .clone()
>      }
> }
> 
> The `data_ptr` above only has provenance to part of the struct for the
> similar reason that my proposal of (ab)using `b.refcount.get()`. Am I
> missing something here?

Easiest is to wrap the entire thing:

struct WithRef<T>(UnsafeCell<ArcInner<T>>);

struct ArcInner<T> {
     refcount: Opaque<bindings::refcount_t>,
     data: T,
}

Alice
