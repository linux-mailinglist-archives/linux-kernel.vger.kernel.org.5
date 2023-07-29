Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BACC5767D18
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 10:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbjG2IN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 04:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbjG2IN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 04:13:26 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC5034200;
        Sat, 29 Jul 2023 01:13:24 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 2A9B95C00DA;
        Sat, 29 Jul 2023 04:13:22 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sat, 29 Jul 2023 04:13:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ryhl.io; h=cc:cc
        :content-transfer-encoding:content-type:content-type:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1690618402; x=1690704802; bh=/br9xDmq1Dnr4Zm96zUw+8bYrch6yCb1Af5
        OY1q0Ufc=; b=g/c6hJpG0fgybXRVzX7Myr88NKB6Xx3sdbaHaA6zFrF/gPJ5WtE
        w/OfVfrByZLWWy8Dp7OZfoarP+SMt6ih6QxRdySvydjU3SeNyWh2I2Rihgd0i9tK
        8CqGV8/0Tvos4EZKwffNDuu+a6iQJKNlH50peLC/mJBnLS/rRjr8NMfo42Jg9Wtx
        /3YfmAg8Bact/tlSlq67UH3Ejj9vy8YxAmF1LBF7u80Y2q5Z8xA8dI7xNNt/tOZl
        Lo70oYPIISTk3y04QXh6QnYOuJbobnatho6mWGU8JN4LMfdgoixUhu/dXiVjJxu5
        iSbs0g9KBWnFM96Xc4JM1TZcYqxxHJTXhZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1690618402; x=1690704802; bh=/br9xDmq1Dnr4Zm96zUw+8bYrch6yCb1Af5
        OY1q0Ufc=; b=l8UwsO9Up8VpeeBgG4mECsTAetW5UHdWawT0vEz4EZCvMgcGPE7
        +e4L8tPxirc3TA3m2v3xqBNd+KWAHlei9yTJNKd1g6ibI8ituFd3CWNX+HXCidgI
        VuSj5dQdBo6zlcDL3OgolHi/oECINfoVQUK2qSF/+bnp003Wx4o9nCg5026Kj/iu
        EK6ZnwtaeGpMaZfl1mZQkjTh4z6i+nO8CyHJj+e297b4X6Ns9jMpbvmCtsW7SEob
        wbQflZxg7soCJPuQ0eZy0nBFcmHpkAgjUuUJ4tFwwXftgoQBqMTc65xZe5YvBbnc
        HBbUXQHUWhD6qs2dB9O5ESTamerBpq9tXtg==
X-ME-Sender: <xms:IcrEZAt2R8m-bKfN4hfirtDdB-CritJpCqpO9mfBA9durQnhpeUAjw>
    <xme:IcrEZNdAlYvE1-AdOQFsmDL4dogD1uHJf8yqXARiRp50nI5RGkaTTVkvBnu8772dy
    nFoBFE5yDktHBQ9Vg>
X-ME-Received: <xmr:IcrEZLwdYrZPiKRn2jpLfyJ59xM3K2U8v3omZWOuKZhlJgMFIWaN97PAATLdszxVHqAxceNaLzAUlnWRvD5U5ofP3Nci1zrFqrgU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrieejgdduvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtfeejnecuhfhrohhmpeetlhhi
    tggvucfthihhlhcuoegrlhhitggvsehrhihhlhdrihhoqeenucggtffrrghtthgvrhhnpe
    ehudduvdetkedvkedtudeludfgfffhudegjeeguedvvedtteevjeehheeiffefgeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhitggvse
    hrhihhlhdrihho
X-ME-Proxy: <xmx:IcrEZDP9sISc5s-MVNd31GNaqdVKsPYyVb5xnp9UmzQNVKEDhDf91w>
    <xmx:IcrEZA9lH2T1tluWWfRXY80Bf9xPnIfPUvC9vRvxsxtqzY-cfniE1g>
    <xmx:IcrEZLUd5IL2oag8PI-Kb0weqoVsSAi1g4gLskqJwNA0GFyWvdW5Fw>
    <xmx:IsrEZLbQGws2TUnb1z6ZP-tZEG93n_mi1zB4pMj61FsIJ6LpAKFfOg>
Feedback-ID: i56684263:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 29 Jul 2023 04:13:19 -0400 (EDT)
Message-ID: <d106217b-b92a-56db-0c48-7ae3d1c4ee10@ryhl.io>
Date:   Sat, 29 Jul 2023 10:14:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 09/12] rust: init: implement Zeroable for Opaque<T>
Content-Language: en-US, da
To:     Benno Lossin <benno.lossin@proton.me>
Cc:     alex.gaynor@gmail.com, bjorn3_gh@protonmail.com,
        boqun.feng@gmail.com, gary@garyguo.net,
        linux-kernel@vger.kernel.org, nmi@metaspace.dk, ojeda@kernel.org,
        rust-for-linux@vger.kernel.org, wedsonaf@gmail.com,
        Alice Ryhl <aliceryhl@google.com>
References: <16fb9977-2efc-2412-e906-3d320e37c45c@proton.me>
 <20230725115759.424300-1-aliceryhl@google.com>
 <18653bf6-c177-ab14-d026-2d2b5c2bbac3@proton.me>
From:   Alice Ryhl <alice@ryhl.io>
In-Reply-To: <18653bf6-c177-ab14-d026-2d2b5c2bbac3@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I suggested it because it seemed less fragile.

That said, after seeing what #[derive(Eq)] expands to, I'm not so sure. 
I'd probably investigate why the Eq macro has to expand to what it does.

On 7/29/23 06:11, Benno Lossin wrote:
> On 25.07.23 13:57, Alice Ryhl wrote:
>> Benno Lossin <benno.lossin@proton.me> writes:
>>> On 20.07.23 15:34, Alice Ryhl wrote:
>>>> Benno Lossin <benno.lossin@proton.me> writes:
>>>>> Since `Opaque<T>` contains a `MaybeUninit<T>`, all bytes zero is a valid
>>>>> bit pattern for that type.
>>>>>
>>>>> Signed-off-by: Benno Lossin <benno.lossin@proton.me>
>>>>> ---
>>>>>     ///
>>>>>     /// This is meant to be used with FFI objects that are never interpreted by Rust code.
>>>>>     #[repr(transparent)]
>>>>> +#[derive(Zeroable)]
>>>>>     pub struct Opaque<T> {
>>>>>         value: UnsafeCell<MaybeUninit<T>>,
>>>>>         _pin: PhantomPinned,
>>>>>     }
>>>>
>>>> Does this actually work? I don't think we implement Zeroable for
>>>> UnsafeCell.
>>>
>>> Good catch, this does compile, but only because the current
>>> implementation of the derive expands to (modulo correct paths):
>>> ```
>>> impl<T> Zeroable for Opaque<T>
>>> where
>>>        UnsafeCell<MaybeUninit<T>>: Zeroable,
>>>        PhantomPinned: Zeroable,
>>> {}
>>> ```
>>> This implementation is of course useless, since `UnsafeCell` is never
>>> `Zeroable` at the moment. We could of course implement that and then this
>>> should work, but the question is if this is actually the desired output in
>>> general. I thought before that this would be a good idea, but I forgot that
>>> if the bounds are never satisfied it would silently compile.
>>>
>>> Do you think that we should have this expanded output instead?
>>> ```
>>> impl<T: Zeroable> Zeroable for Foo<T> {}
>>> const _: () = {
>>>        fn assert_zeroable<T: Zeroable>() {}
>>>        fn ensure_zeroable<T: Zeroable>() {
>>>            assert_zeroable::<Field1>();
>>>            assert_zeroable::<Field2>();
>>>        }
>>> };
>>> ```
>>> If the input was
>>> ```
>>> #[derive(Zeroable)]
>>> struct Foo<T> {
>>>        field1: Field1,
>>>        field2: Field2,
>>> }
>>> ```
>>
>> Yeah. The way that these macros usually expand is by adding `where T:
>> Zeroable` to the impl for each generic parameter, and failing
>> compilation if that is not enough to ensure that all of the fields are
>> `Zeroable`.
>>
>> You might want to consider this expansion instead:
>> ```
>> impl<T: Zeroable> Zeroable for Foo<T> {}
>> const _: () = {
>>        fn assert_zeroable<T: Zeroable>(arg: &T) {}
>>        fn ensure_zeroable<T: Zeroable>(arg: &Foo<T>) {
>>            assert_zeroable(&arg.field1);
>>            assert_zeroable(&arg.field2);
>>        }
>> };
>> ```
> 
> Is there a specific reason you think that I should us references here
> instead of the expansion from above (where I just use the types and
> not the fields themselves)?
> 
