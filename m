Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 901F97AF694
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 01:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbjIZXKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 19:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231955AbjIZXIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 19:08:09 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9784D30C2;
        Tue, 26 Sep 2023 15:10:53 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id AB8F85C2611;
        Tue, 26 Sep 2023 17:31:46 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 26 Sep 2023 17:31:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ryhl.io; h=cc:cc
        :content-transfer-encoding:content-type:content-type:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1695763906; x=1695850306; bh=7gNzlnId/cqd0ditW1NyD91+EYlsBuek2s6
        xQOapN1I=; b=J+PxmCUb+XxPik8T/uxemHsDQBfmJkhZcshV53kiMSXlH/ZZLC1
        9QRQ8DuUSu5mjfquFEEtKp5hmflZbfTBUBMmsxD3xFEtpVvKcHX0KHmq2VZRY2mX
        QHxhRpqsrb76hdBSa9BKfM6zeNr/qLQrNbeb8b1aSjRdbMoU+2fMA2Z346cuiwhM
        61V1bdYzMKTJrKzg8PSM75KAJ6SXhDVjmzPv1Bz+Sx4moSjv5mgGMgqmTy4i347X
        yxmnbmzMJLje8+eo6f8W1Z9gM9o4zKQVlneOTJTD2EFLEkqtQIYpNrnX0SWx9VhE
        JO7o3PSRQV6OQ7Y8xpJ4HivQnIwyLS7DABQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1695763906; x=1695850306; bh=7gNzlnId/cqd0ditW1NyD91+EYlsBuek2s6
        xQOapN1I=; b=qUBJOXvE2rxlVmVkmMWdurAT7CeQ/1zSsIcNviSUj9mx/GzD9z1
        ZvVE5UKhMMwpjDGi4tqQ5K5/qliVLmps6pI3E3lZ8OT7NRbOoSLCGW8FcvWJ+B9e
        97Q8fNRrGLrmp1CmmWRe3jg/kkTlnDNGHTIxjCfRCRee/GF+SBnGgV2Mu2ZArxuE
        TwbaIQ+1nmc+ZKlmTG7S84l/Gyh3QgOKFksNZtOMX1NKL/t04oGLCzeYil5SbjBQ
        vdqXOg51MjQ0L0i7hprQAXCv00y6e2LuE2Gkh33ef/A2OJAPUoZctTM1gekkXPfN
        ws4F3Qc5z6PsdijtBK7KpOAusZKTWeiIZdw==
X-ME-Sender: <xms:wk0TZUAKDf7WP5MJZkOQPggWjvj-JURQBH9ji5cI2oP_36eaBVQY1g>
    <xme:wk0TZWj5uB1xUGPRIYOGBElp7_GCVQVoQzPVFJIqY2Hgwjs8fURWds1DxUSxKIu2b
    IclRU1YunMlqHWYlQ>
X-ME-Received: <xmr:wk0TZXn5FeuKo3dckxfogKJV7ssvw_5KRZHVXheMv8KQTejCpZFY5c3J5YLiuzAcnM32bdiVNBiWxBN6s0tLfh6REizbMurJzX4K>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvjedrtddtgddufeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpeetlhhi
    tggvucfthihhlhcuoegrlhhitggvsehrhihhlhdrihhoqeenucggtffrrghtthgvrhhnpe
    euuedufeehtedtleduleevtdfhteeguddtkeegtdevhfeihefgheehtdfhtdeludenucff
    ohhmrghinhepphhtrhdrrghspdhruhhsthdqlhgrnhhgrdhorhhgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlihgtvgesrhihhhhlrdhi
    oh
X-ME-Proxy: <xmx:wk0TZaxa7QTn8uL4t-A8eieRc7gUoTakq0vr4nVsd1Qai_aDEZ4fxw>
    <xmx:wk0TZZTnWVNW07Swjd3luQcoaPmg1-J7fYSEpe__VcqaAkbYXZKLqg>
    <xmx:wk0TZVYurZiAv23nIEa6F70dOkaJYvymmuax8dZ24FcHuZLvLRCHDQ>
    <xmx:wk0TZeKGGd20odPLES4InrCkZiGO8zekjnEyDe5azSK8NgMCfzCd3w>
Feedback-ID: i56684263:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Sep 2023 17:31:44 -0400 (EDT)
Message-ID: <ba90adb6-5510-4657-bbde-41b15c291b36@ryhl.io>
Date:   Tue, 26 Sep 2023 23:31:43 +0200
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
 <ZRMYObRby6NDKNzD@boqun-archlinux>
From:   Alice Ryhl <alice@ryhl.io>
In-Reply-To: <ZRMYObRby6NDKNzD@boqun-archlinux>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/26/23 19:43, Boqun Feng wrote:
> On Tue, Sep 26, 2023 at 05:15:52PM +0000, Benno Lossin wrote:
>> On 26.09.23 18:35, Boqun Feng wrote:
>>> On Tue, Sep 26, 2023 at 05:41:17PM +0200, Alice Ryhl wrote:
>>>> On Tue, Sep 26, 2023 at 5:24 PM Boqun Feng <boqun.feng@gmail.com> wrote:
>>>>>
>>>>> On Tue, Sep 26, 2023 at 04:26:59PM +0800, Gary Guo wrote:
>>>>>> On Mon, 25 Sep 2023 22:26:56 +0000
>>>>>> Benno Lossin <benno.lossin@proton.me> wrote:
>>>>>>
>>>>> [...]
>>>>>>>
>>>>>>> The pointer was originally derived by a call to `into_raw`:
>>>>>>> ```
>>>>>>>        pub fn into_raw(self) -> *const T {
>>>>>>>            let ptr = self.ptr.as_ptr();
>>>>>>>            core::mem::forget(self);
>>>>>>>            // SAFETY: The pointer is valid.
>>>>>>>            unsafe { core::ptr::addr_of!((*ptr).data) }
>>>>>>>        }
>>>>>>> ```
>>>>>>> So in this function the origin (also the origin of the provenance)
>>>>>>> of the pointer is `ptr` which is of type `NonNull<WithRef<T>>`.
>>>>>>> Raw pointers do not lose this provenance information when you cast
>>>>>>> it and when using `addr_of`/`addr_of_mut`. So provenance is something
>>>>>>> that is not really represented in the type system for raw pointers.
>>>>>>>
>>>>>>> When doing a round trip through a reference though, the provenance is
>>>>>>> newly assigned and thus would only be valid for a `T`:
>>>>>>> ```
>>>>>>> let raw = arc.into_raw();
>>>>>>> let reference = unsafe { &*raw };
>>>>>>> let raw: *const T = reference;
>>>>>>> let arc = unsafe { Arc::from_raw(raw) };
>>>>>>> ```
>>>>>>> Miri would complain about the above code.
>>>>>>>
>>>>>>
>>>>>> One thing we can do is to opt from strict provenance, so:
>>>>>>
>>>>>
>>>>> A few questions about strict provenance:
>>>>>
>>>>>> ```
>>>>>> let raw = arc.into_raw();
>>>>>> let _ = raw as usize; // expose the provenance of raw
>>>>>
>>>>> Should this be a expose_addr()?
>>>>
>>>> Pointer to integer cast is equivalent to expose_addr.
>>>>
>>>>>> let reference = unsafe { &*raw };
>>>>>> let raw = reference as *const T as usize as *const T;
>>>>>
>>>>> and this is a from_exposed_addr{_mut}(), right?
>>>>
>>>> Integer to pointer cast is equivalent to from_exposed_addr.
>>>>
>>>
>>> Got it, thanks!
>>>
>>>>>> let arc = unsafe { Arc::from_raw(raw) };
>>>>>> ```
>>>>>>
>>>>>
>>>>> One step back, If we were to use strict provenance API (i.e.
>>>>> expose_addr()/from_exposed_addr()), we could use it to "fix" the
>>>>> original problem? By:
>>>>>
>>>>> *       expose_addr() in as_with_ref()
>>>>> *       from_exposed_addr() in `impl From<&WithRef<T>> for Arc`
>>>>>
>>>>> right?
>>>>>
>>>>> More steps back, is the original issue only a real issue under strict
>>>>> provenance rules? Don't make me wrong, I like the ideas behind strict
>>>>> provenance, I just want to check, if we don't enable strict provenance
>>>>> (as a matter of fact, we don't do it today),
>>>>
>>>> Outside of miri, strict provenance is not really something you enable.
>>>> It's a set of rules that are stricter than the real rules, that are
>>>> designed such that when you follow them, your code will be correct
>>>> under any conceivable memory model we might end up with. They will
>>>> never be the rules that the compiler actually uses.
>>>>
>>>> I think by "opt out from strict provenance", Gary just meant "use
>>>> int2ptr and ptr2int casts to reset the provenance".
>>>>
>>>>> will the original issue found by Alice be a UB?
>>>>
>>>> Yes, it's UB under any ruleset that exists out there. There's no flag
>>>> to turn it off.
>>>>
>>>>> Or is there a way to disable Miri's check on
>>>>> strict provenance? IIUC, the cause of the original issue is that "you
>>>>> cannot reborrow a pointer derived from a `&` to get a `&mut`, even when
>>>>> there is no other alias to the same object". Maybe I'm still missing
>>>>> something, but without strict provenance, is this a problem? Or is there
>>>>> a provenance model of Rust without strict provenance?
>>>>
>>>> It's a problem under all of the memory models. The rule being violated
>>>> is exactly the same rule as the one behind this paragraph:
>>>>
>>>>> Transmuting an & to &mut is Undefined Behavior. While certain usages may appear safe, note that the Rust optimizer is free to assume that a shared reference won't change through its lifetime and thus such transmutation will run afoul of those assumptions. So:
>>>>>
>>>>> Transmuting an & to &mut is always Undefined Behavior.
>>>>> No you can't do it.
>>>>> No you're not special.
>>>> From: https://doc.rust-lang.org/nomicon/transmutes.html
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
> To me (and maybe the same for Wedson), it's actually Ok that we don't do
> the change (i.e. the ArcBorrow -> &WithRef) at all. It's more a
> code/concept simplification.

Not making the change is fine with me.

> Fixing with an `UnsafeCell` seems more like a workaround to me, because
> there is no interior mutable requirement here, so I just don't want to
> patch something unnecessary here just to make things work.

I don't think it's a just a workaround. We're dealing with shared 
references to something, but they can be used to modify the value under 
some circumstances. That seems like rather standard interior mutability.

> Put it in another way, if `UnsafeCell` can fix this and no interior
> mutability is needed, we probably can fix this with another way or there
> is an API like `UnsafeCell` is missing here.
> 
> Sorry for being stubborn here ;-) But I really want to find a better
> solution for the similar problems.
> 
> What's the shortcoming of ptr2int?

To me, that's way more of a hack than using UnsafeCell is.

> Regards,
> Boqun
> 
>> -- 
>> Cheers,
>> Benno
>>
>>
