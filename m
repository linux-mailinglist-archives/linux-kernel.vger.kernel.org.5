Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9637AE11B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 23:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbjIYV7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 17:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjIYV7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 17:59:00 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F39AF;
        Mon, 25 Sep 2023 14:58:53 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 4E7415C0152;
        Mon, 25 Sep 2023 17:58:51 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 25 Sep 2023 17:58:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ryhl.io; h=cc:cc
        :content-transfer-encoding:content-type:content-type:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1695679131; x=1695765531; bh=kUnVeKR6NPzam27Z8wdb0Fiy0PexlWX7F9q
        WzLELfaw=; b=TiJYuPI+QfPcppWOD0lBVoZo9nqssKqzgw7Eh9vnsgI+CdLpKr1
        QXs9bFpgEOiKo3FcQ6sohoN3IWDvu2dNHcGoL17L8fpSpEBWZbhKnK53pjnObQfY
        l0nDthoMRCKih/avUk1xe283HbXCsW/+dSziAu+PTNPCWaKxU/VKb78QP61fPdkK
        ejooTcxnrckeEp57zGO3gtUTk42QZYvUR6IqIFDbHS3EDvcJPnu22IYqO/i2gI/d
        BE5peWAkAxinydwYAzothp9u78+66VLxnJFMV0A8du06jsX28fOeqTvsruKhfbR3
        rEKsr+f0BzyqM5dxkzxesw1aPIPATjxjqhw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1695679131; x=1695765531; bh=kUnVeKR6NPzam27Z8wdb0Fiy0PexlWX7F9q
        WzLELfaw=; b=bM6SeA6rOT9sCg21OHnkrZP8OA7AS7SezWXHgRFh9h4tB+cnPGL
        aiUR6S8PoieScU6VXbBr5dQY5w8+vzEztX51i+ACxLFDlqoiQLr0wMNBCT1NJWB9
        ENSANK1cdGoAtm0sk0G48kerxV7cyn+N4Hcq4kcWkdd37ULBwIqiNsRt8NupZee/
        jvUBxxaVZ/Klm48ZQIKFHZ2MvvgV45HOWBV0Z5xdezU0nrakCJ7n8cC2QkOUvZFg
        CPuAoYCTYo63CrTFXH/fBN+ykL33y44rDRTeHexc/zdOo3Wyq+t+rE2qGd7b2xgD
        WTk3a8pnia7E+UjVHC2MmvSmw29FGb06Paw==
X-ME-Sender: <xms:mwISZaAGCNFa8dIEUnXKg9LH0e9hczy1ple76AQad9kk6L_x0Msacg>
    <xme:mwISZUiu1FlyPwwWXHf1YHLgHsmSbXWP_P3Vm3hrjiD_JqwAiY4jf3ov4E_Vrnw67
    G4IVS9WzaG2NOVIuA>
X-ME-Received: <xmr:mwISZdk842Vw-kkuDLGgtjzcltAre9WR2gwucXSUyzmk_dMVCukxyyQw_vZGMAi1SCKQvRgqbmyb-jbiG9EATtfIZFosxpYY4C0G>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudelhedgtdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeetlhhi
    tggvucfthihhlhcuoegrlhhitggvsehrhihhlhdrihhoqeenucggtffrrghtthgvrhhnpe
    efgfeugfdtgefhueeiudffjefhveeuheeuheekvdetfefgheehtdffuddtgfdujeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhitggvse
    hrhihhlhdrihho
X-ME-Proxy: <xmx:mwISZYxKWxWWEb7YM1SCybbxZN0s3sITsbsXjX3EvzFz0PkBiU1a5w>
    <xmx:mwISZfRJLHo8DGVp523CkCegaZaj_W_A1V5toniCmU1kJVSa7d1VWQ>
    <xmx:mwISZTZRIxV5WytNZHNbUf4h_NY6JSKCjJFdE2TZSU4L_SKsuyyfgg>
    <xmx:mwISZUJByfAqM57HBrvam5s5NCF4MrIvcce7GZywZDmv7x7dudnN8Q>
Feedback-ID: i56684263:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Sep 2023 17:58:49 -0400 (EDT)
Message-ID: <edc0b599-c5d1-4e9c-a51b-eb8ceaef7acc@ryhl.io>
Date:   Mon, 25 Sep 2023 23:58:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] rust: arc: remove `ArcBorrow` in favour of
 `WithRef`
Content-Language: en-US-large
To:     Boqun Feng <boqun.feng@gmail.com>,
        Benno Lossin <benno.lossin@proton.me>
Cc:     Alice Ryhl <aliceryhl@google.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>
References: <20230923144938.219517-1-wedsonaf@gmail.com>
 <20230923144938.219517-3-wedsonaf@gmail.com>
 <CAH5fLggxsewmtzXjehbawDCTHO0C7kteU_CLnh80eMNj=QyP9Q@mail.gmail.com>
 <969eab7f-ad40-0dfb-18b9-6002fc54e12b@proton.me>
 <ZRGd4lsNP30L2yB3@Boquns-Mac-mini.home>
 <14513589-cc31-8985-8ff6-a97d2882f593@proton.me>
 <ZRGyRQuBcWvgtdNR@Boquns-Mac-mini.home>
 <9d6d6c94-5da6-a56d-4e85-fbf8da26a0b0@proton.me>
 <ZRHWqbvYlXBXEOh-@boqun-archlinux>
 <c5134a1a-a60d-73bb-9faa-aa1dfc3bc30d@proton.me>
 <ZRIB0hXNvmJtmyak@boqun-archlinux>
From:   Alice Ryhl <alice@ryhl.io>
In-Reply-To: <ZRIB0hXNvmJtmyak@boqun-archlinux>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/25/23 23:55, Boqun Feng wrote:
> On Mon, Sep 25, 2023 at 09:03:52PM +0000, Benno Lossin wrote:
>> On 25.09.23 20:51, Boqun Feng wrote:
>>> On Mon, Sep 25, 2023 at 05:00:45PM +0000, Benno Lossin wrote:
>>>> On 25.09.23 18:16, Boqun Feng wrote:
>>>>> On Mon, Sep 25, 2023 at 03:07:44PM +0000, Benno Lossin wrote:
>>>>>> ```rust
>>>>>> struct MutatingDrop {
>>>>>>         value: i32,
>>>>>> }
>>>>>>
>>>>>> impl Drop for MutatingDrop {
>>>>>>         fn drop(&mut self) {
>>>>>>             self.value = 0;
>>>>>>         }
>>>>>> }
>>>>>>
>>>>>> let arc = Arc::new(MutatingDrop { value: 42 });
>>>>>> let wr = arc.as_with_ref(); // this creates a shared `&` reference to the MutatingDrop
>>>>>> let arc2: Arc<MutatingDrop> = wr.into(); // increments the reference count to 2
>>>>>
>>>>> More precisely, here we did a
>>>>>
>>>>> 	&WithRef<_> -> NonNull<WithRef<_>>
>>>>>
>>>>> conversion, and later on, we may use the `NonNull<WithRef<_>>` in
>>>>> `drop` to get a `Box<WithRef<_>>`.
>>>>
>>>> Indeed.
>>>>
>>>
>>> Can we workaround this issue by (ab)using the `UnsafeCell` inside
>>> `WithRef<T>`?
>>>
>>> impl<T: ?Sized> From<&WithRef<T>> for Arc<T> {
>>>       fn from(b: &WithRef<T>) -> Self {
>>>           // SAFETY: The existence of the references proves that
>>> 	// `b.refcount.get()` is a valid pointer to `WithRef<T>`.
>>> 	let ptr = unsafe { NonNull::new_unchecked(b.refcount.get().cast::<WithRef<T>>()) };
>>>
>>> 	// SAFETY: see the SAFETY above `let ptr = ..` line.
>>>           ManuallyDrop::new(unsafe { Arc::from_inner(ptr) })
>>>               .deref()
>>>               .clone()
>>>       }
>>> }
>>>
>>> This way, the raw pointer in the new Arc no longer derives from the
>>> reference of `WithRef<T>`.
>>
>> No, the code above only obtains a pointer that has provenance valid
>> for a `bindings::refcount_t` (or type with the same layout, such as
>> `Opaque<bindings::refcount_t>`). But not the whole `WithRef<T>`, so accessing
>> it by reading/writing will still be UB.
>>
> 
> Hmm... but we do the similar thing in `Arc::from_raw()`, right?
> 
>      	pub unsafe fn from_raw(ptr: *const T) -> Self {
> 	    ..
> 	}
> 
> , what we have is a pointer to T, and we construct a pointer to
> `ArcInner<T>/WithRef<T>`, in that function. Because the `sub` on pointer
> gets away from provenance? If so, we can also do a sub(0) in the above
> code.

Not sure what you mean. Operations on raw pointers leave provenance 
unchanged.

Alice

