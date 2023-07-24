Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B06E75FB77
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 18:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbjGXQHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 12:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbjGXQHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 12:07:11 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D73CD10FF;
        Mon, 24 Jul 2023 09:07:09 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-6b9aadde448so4066664a34.0;
        Mon, 24 Jul 2023 09:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690214829; x=1690819629;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sNi5vVMCJWfHjXXkqvqwnxz9gP61j7y0zdFiLD2AOm4=;
        b=b1cbmfyKHmtLdjno0V/bvAf32VvNFJpzM2VD9rlw08X9zpd1njJBjfqc/4AQ++uSbl
         Dm2JllG46Lyxx3hPZ9KJMj6B0UPhnnC9OROEcysatpXE5tJ2x9QTbp+z9nmC7mFdGArS
         SJoRedyiX6G/HPiW5OJcoE0H0fpz7CIZdKJ08//8arjk2akZHVkrHM+AO9qzmYp5x9bI
         4/U+gAoQwOoq4u3ki7jpL0BHB6uu69D8nGrch3zYWUQA0eAmx2Ze4G6iydhata5WgXrR
         wP+jMiuUv9E4Ch6BJVUaYYyvoskSeTxRoSmXPvuRCnLNKCchY2UU+RAiWA8Pkoey9Z8k
         Z/cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690214829; x=1690819629;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sNi5vVMCJWfHjXXkqvqwnxz9gP61j7y0zdFiLD2AOm4=;
        b=fmWoXkQhxKWuWds8plPew+uUHCaTgEzFOojR6ypd9su91NwhToioPhgP2w+kBQvayb
         ER699vBOorEOxyLxTTzWfE0hkDes7vKKbyeDf1daYKVU8cVqubvtgiU1b6n55HPp7lsg
         8j/0OJwL6q03BBBBiagoPDx51jIqeK48cMeMXv6XiocqE/Oryy5Jf91CvVFp37lQ95KE
         J1Sj0NNILoKrQnGDFI1KgMvXQP3rp6XWaY6PT8KDA1MysC/Q+Yo4+3pqvLiMWAZevYwd
         pn+hvGE6o+XpSX9EpreU9e4S8yttRG3ykxW7XMW4PsAFE/JD7WEiN4lPGHSQcgTDbVMF
         TAew==
X-Gm-Message-State: ABy/qLZUGN4qteK9s7FgjeEpGyVWF2D9bT/XQffykXQMvXTpnK1HczfN
        RoIqCls6ArMvGH1kAPbkyAQ=
X-Google-Smtp-Source: APBJJlH3usIPW2PVHeDvPhTMcX6b5v/xPdx3CCRtBadftST/7fWKXnmZp3nVJH0zxKDL4ioZx54VIw==
X-Received: by 2002:a05:6830:11da:b0:6b9:99fe:4747 with SMTP id v26-20020a05683011da00b006b999fe4747mr9267660otq.29.1690214829009;
        Mon, 24 Jul 2023 09:07:09 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id p3-20020a9d6943000000b006b9734b9fafsm4024904oto.13.2023.07.24.09.07.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 09:07:08 -0700 (PDT)
Message-ID: <ebdf2635-6003-fc62-310f-5b9071473415@gmail.com>
Date:   Mon, 24 Jul 2023 13:07:04 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/12] rust: init: add `{pin_}chain` functions to
 `{Pin}Init<T, E>`
Content-Language: en-US
To:     Benno Lossin <benno.lossin@proton.me>,
        Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>
Cc:     Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Andreas Hindborg <nmi@metaspace.dk>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Asahi Lina <lina@asahilina.net>
References: <20230719141918.543938-1-benno.lossin@proton.me>
 <20230719141918.543938-12-benno.lossin@proton.me>
 <0b818707-4762-c12d-8624-7d3c4f6841da@gmail.com>
 <5f22b25d-132d-7cbc-8bca-8333516c1663@proton.me>
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <5f22b25d-132d-7cbc-8bca-8333516c1663@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/24/23 11:08, Benno Lossin wrote:
> On 21.07.23 02:23, Martin Rodriguez Reboredo wrote:
>> On 7/19/23 11:21, Benno Lossin wrote:
>>> +/// An initializer returned by [`PinInit::pin_chain`].
>>> +pub struct ChainPinInit<I, F, T: ?Sized, E>(I, F, __internal::Invariant<(E, Box<T>)>);
>>> +
>>> +// SAFETY: the `__pinned_init` function is implemented such that it
>>> +// - returns `Ok(())` on successful initialization,
>>> +// - returns `Err(err)` on error and in this case `slot` will be dropped.
>>> +// - considers `slot` pinned.
>>> +unsafe impl<T: ?Sized, E, I, F> PinInit<T, E> for ChainPinInit<I, F, T, E>
>>> +where
>>> +    I: PinInit<T, E>,
>>> +    F: FnOnce(Pin<&mut T>) -> Result<(), E>,
>>> +{
>>> +    unsafe fn __pinned_init(self, slot: *mut T) -> Result<(), E> {
>>> +        // SAFETY: all requirements fulfilled since this function is `__pinned_init`.
>>> +        unsafe { self.0.__pinned_init(slot)? };
>>> +        // SAFETY: The above call initialized `slot` and we still have unique access.
>>> +        let val = unsafe { &mut *slot };
>>> +        // SAFETY: `slot` is considered pinned
>>> +        let val = unsafe { Pin::new_unchecked(val) };
>>> +        (self.1)(val).map_err(|e| {
>>> +            // SAFETY: `slot` was initialized above.
>>> +            unsafe { core::ptr::drop_in_place(slot) };
>>> +            e
>>
>> I might stumble upon an error like EAGAIN if I call `pin_chain` but that
>> means `slot` will be dropped. So my recommendation is to either not drop
>> the value or detail in `pin_chain`'s doc comment that the closure will
>> drop on error.
> 
> This is a bit confusing to me, because dropping the value on returning `Err`
> is a safety requirement of `PinInit`. Could you elaborate why this is
> surprising? I can of course add it to the documentation, but I do not see
> how it could be implemented differently. Since if you do not drop the value
> here, nobody would know that it is still initialized.

I knew about the requirement of dropping on `Err`, but what has caught my
attention is that `{pin_}chain` might not abide with it per the doc
comment as it says that `self` is initialized before calling `f`...

     /// First initializes the value using `self` then calls the function
     /// `f` with the initialized value.

But one can not know what would happen when `f` fails, specially if
such failure can be ignored or it's only temporarily.

So then, the best course IMO is to mention that in some way the value is
still being initialized, kinda setting it up, and that it will be dropped
when an error is returned. WDYT?
