Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5DC7617D5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 13:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232803AbjGYL6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 07:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232626AbjGYL6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 07:58:41 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAADE1FF5
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 04:58:03 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-573d70da2afso68430337b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 04:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690286283; x=1690891083;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1VPOZThFJv0JHnA6Avw8TCcPUHE62XLzLeg/XcbHXkE=;
        b=5tXnrBdCveXXrzYmqLZ1P2TeCsTuXDBPcVAxBik99PdwIIaCnKOQ0o3W2dJBX22QCB
         lJUZFdhNrHpsBhPchNHK4cbzfV3bQWfX3FdfYs/OofZewWZ9rYEAjqDdrInhybQ8ML8x
         ddmDpmbBoHDqd3ndTwKxLV/jy4bu0yXDr7gg7uLu70CsMRHe000a6GzH9QotuIx1VCZ9
         iyM2gFIYapePiJc+W2cPeNMy7okUEk+iCV/DobjQf4Umhk/JWC/cBYvnoL79e1kw+4+D
         sImJ8rYQu3m0/+L/fidMEBVVrziwD56GAaZX1K9XyTiNNeSk/04m3awxawmUJMLptZfO
         oMTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690286283; x=1690891083;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1VPOZThFJv0JHnA6Avw8TCcPUHE62XLzLeg/XcbHXkE=;
        b=Mci+mW5OVC/oRg6Wg83Q84tLblaxDgmL9nrhyJTsiMEb6PhynpFst3RNZtEqMTTQFP
         L5KirBPTvdysqFjg7M/3ljTmNFf0OtBY7ERc+uKv3iK833z6NwjjMBpK8Dfjz9/qrKd1
         Oy5iK43vL/jk5mJjIbBl+vkB0HTZfdGbKYLn6QA1EHoPcihHYFDVgDyQZqrFK9Y2jows
         hb/MdwHDw7tDzQzLYLEVnHsIG51mMoPWjmFU9rk84qnr60TBiWaK23hauV0ecRcYRIWa
         ksQ5LoT87G3q1lmKKY2hWvRQpNb5FIKpHY8HNjlodgt7E3XeIzN4rpuQdcqRi07meJnr
         xrUg==
X-Gm-Message-State: ABy/qLYRn+1/jSinOfdQVD/wL21tC5KlKBBcMXZZqAsj0euOTHiZPNHl
        2dogPU2LkqWjNWduU647o4lMOCqZxAnB5Xo=
X-Google-Smtp-Source: APBJJlHGSHNCFMtiM27C/TIFHTgwQEAjSMl35nON1bWo4KcF0K6HUmOjyrPq5jt2EXoF14KZN1gEEEL9/6p6lsU=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:6c8])
 (user=aliceryhl job=sendgmr) by 2002:a81:af21:0:b0:579:fa4c:1f25 with SMTP id
 n33-20020a81af21000000b00579fa4c1f25mr90464ywh.7.1690286282821; Tue, 25 Jul
 2023 04:58:02 -0700 (PDT)
Date:   Tue, 25 Jul 2023 11:57:59 +0000
In-Reply-To: <16fb9977-2efc-2412-e906-3d320e37c45c@proton.me>
Mime-Version: 1.0
References: <16fb9977-2efc-2412-e906-3d320e37c45c@proton.me>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230725115759.424300-1-aliceryhl@google.com>
Subject: Re: [PATCH v2 09/12] rust: init: implement Zeroable for Opaque<T>
From:   Alice Ryhl <aliceryhl@google.com>
To:     benno.lossin@proton.me
Cc:     alex.gaynor@gmail.com, aliceryhl@google.com,
        bjorn3_gh@protonmail.com, boqun.feng@gmail.com, gary@garyguo.net,
        linux-kernel@vger.kernel.org, nmi@metaspace.dk, ojeda@kernel.org,
        rust-for-linux@vger.kernel.org, wedsonaf@gmail.com
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Benno Lossin <benno.lossin@proton.me> writes:
> On 20.07.23 15:34, Alice Ryhl wrote:
>> Benno Lossin <benno.lossin@proton.me> writes:
>>> Since `Opaque<T>` contains a `MaybeUninit<T>`, all bytes zero is a valid
>>> bit pattern for that type.
>>>
>>> Signed-off-by: Benno Lossin <benno.lossin@proton.me>
>>> ---
>>>   ///
>>>   /// This is meant to be used with FFI objects that are never interpreted by Rust code.
>>>   #[repr(transparent)]
>>> +#[derive(Zeroable)]
>>>   pub struct Opaque<T> {
>>>       value: UnsafeCell<MaybeUninit<T>>,
>>>       _pin: PhantomPinned,
>>>   }
>> 
>> Does this actually work? I don't think we implement Zeroable for
>> UnsafeCell.
> 
> Good catch, this does compile, but only because the current
> implementation of the derive expands to (modulo correct paths):
> ```
> impl<T> Zeroable for Opaque<T>
> where
>      UnsafeCell<MaybeUninit<T>>: Zeroable,
>      PhantomPinned: Zeroable,
> {}
> ```
> This implementation is of course useless, since `UnsafeCell` is never
> `Zeroable` at the moment. We could of course implement that and then this
> should work, but the question is if this is actually the desired output in
> general. I thought before that this would be a good idea, but I forgot that
> if the bounds are never satisfied it would silently compile.
> 
> Do you think that we should have this expanded output instead?
> ```
> impl<T: Zeroable> Zeroable for Foo<T> {}
> const _: () = {
>      fn assert_zeroable<T: Zeroable>() {}
>      fn ensure_zeroable<T: Zeroable>() {
>          assert_zeroable::<Field1>();
>          assert_zeroable::<Field2>();
>      }
> };
> ```
> If the input was
> ```
> #[derive(Zeroable)]
> struct Foo<T> {
>      field1: Field1,
>      field2: Field2,
> }
> ```
 
Yeah. The way that these macros usually expand is by adding `where T:
Zeroable` to the impl for each generic parameter, and failing
compilation if that is not enough to ensure that all of the fields are
`Zeroable`.

You might want to consider this expansion instead:
```
impl<T: Zeroable> Zeroable for Foo<T> {}
const _: () = {
     fn assert_zeroable<T: Zeroable>(arg: &T) {}
     fn ensure_zeroable<T: Zeroable>(arg: &Foo<T>) {
         assert_zeroable(&arg.field1);
         assert_zeroable(&arg.field2);
     }
};
```

>> I suggest you instead add Opaque to the `impl_zeroable!` macro in
>> `rust/kernel/init.rs`.
> 
> We would have to do this when using the alternative approach from
> above, since we do not want the `Zeroable` bound on `T` for `Opaque`.
> I wanted to avoid the `SAFETY` comment, since that is needed for the
> `impl_zeroable` macro (as it has an unsafe block inside).

Indeed, if we expand the derive macro in the standard way, then it
doesn't work for `Opaque` due to the extra unnecessary bound.

Alice

