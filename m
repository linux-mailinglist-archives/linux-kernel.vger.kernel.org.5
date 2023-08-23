Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 885FB7853E9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 11:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235052AbjHWJ3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 05:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235382AbjHWJ0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 05:26:40 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49DD82681
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 02:14:55 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3ff5ddb4329so1951865e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 02:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20221208.gappssmtp.com; s=20221208; t=1692782094; x=1693386894;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=qiZlM8QEOpDTpRFMe/2/zEZ6wsyKpsV1KUA2VGwkVqc=;
        b=TZmuqPNeD3vmbShzj7gSb9+WRe+VS3qWdT9gRNdlIP9KZZgdfonNFTcwLwx5mRJt4q
         ZN6MwyNgTnqxerFqVS838PDSa9SZahDI+0GrYqHbmOOI0lS1z9cmYY8xV/NJtu+8RZJo
         6tQuut33WKBdRXsVpKVyM69X8LCHU2KjK3uJqfZjXbMlenzYj+FYyfvMDqZA33cydqgy
         XTmSgGZeHwVcHBM5nX+9NbJetLEwqVrJOHnKcl3ZIwQavAH4RDuNakYzvfwbxEhH8/ET
         ebPNY+1w72xFkKQFbxQILYIPWjBdxqGfbMHKXsQ+VYtIjpovbaEVa3H62hZEtJ8g71KQ
         g0PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692782094; x=1693386894;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qiZlM8QEOpDTpRFMe/2/zEZ6wsyKpsV1KUA2VGwkVqc=;
        b=Epk0+saZvtuqoOu1tzHtT9AzfT/REbGVvCXqYC8EdsDkKFZkU+2+4Cton9CxUCbuMQ
         hrPyzzCmAriIQSSpkCPN/EK8mjYyyUxVZvEtjPSU4rJBq7hkQwXrgT6Dkq7SuhHAaops
         eFsqTy7/Rq77G6N7qscpTLcgtsCFWkQWljq9SUAlAINsP9hYfoUffjLrssvw6oBJyymy
         nmLn+kvOfWG+7ZuC6F4D/vxBb8BWG7wg0e/OXRhPn4qT64FJy9gpK1eP82GHj54POSM7
         ueevSQbyP0lfwFV7m+MlOkbmrO9dZ1ngOL0py6nLQPfQirbyuxxVWi7jilVxHgzE8cbl
         0dTw==
X-Gm-Message-State: AOJu0YzPPyMjwOoRAXOzjSBLqwRk//OXEwtbsTzYgIU251/th+ZkxFEN
        pLdNlvOM/kpfXMUXILSxiuPrGw==
X-Google-Smtp-Source: AGHT+IGmx49TcZyNIesZ0Y8hEQR3pLmQeKegxY8NL7lzkFIt1BTGvLiiowVfWMRULj4No2sYruY+WA==
X-Received: by 2002:a05:600c:3007:b0:3fa:91d0:8ddb with SMTP id j7-20020a05600c300700b003fa91d08ddbmr9556489wmh.14.1692782093753;
        Wed, 23 Aug 2023 02:14:53 -0700 (PDT)
Received: from localhost ([165.225.194.205])
        by smtp.gmail.com with ESMTPSA id n22-20020a1c7216000000b003fefe70ec9csm2536983wmc.10.2023.08.23.02.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 02:14:53 -0700 (PDT)
References: <20230711093303.1433770-1-aliceryhl@google.com>
 <20230711093303.1433770-7-aliceryhl@google.com>
 <vyrVN334oIXneb9VWievGpPTOCy0irxvoG-mDR0sQX5-xN-TL2Hngl0cl_XrVUwjDB3rXkXfR9Mdjy_no6fzhe4yIf_c7xpKa5OURt43k9c=@proton.me>
 <87msyisvmi.fsf@metaspace.dk>
User-agent: mu4e 1.10.5; emacs 28.2.50
From:   "Andreas Hindborg (Samsung)" <nmi@metaspace.dk>
To:     Benno Lossin <benno.lossin@proton.me>
Cc:     Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH v3 6/9] rust: workqueue: add helper for defining
 work_struct fields
Date:   Wed, 23 Aug 2023 11:06:37 +0200
In-reply-to: <87msyisvmi.fsf@metaspace.dk>
Message-ID: <87il963ysz.fsf@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


"Andreas Hindborg (Samsung)" <nmi@metaspace.dk> writes:

> Hi Benno,
>
> Benno Lossin <benno.lossin@proton.me> writes:
>
> ...
>
>>> +/// Links for a work item.
>>> +///
>>> +/// This struct contains a function pointer to the `run` function from the [`WorkItemPointer`]
>>> +/// trait, and defines the linked list pointers necessary to enqueue a work item in a workqueue.
>>> +///
>>> +/// Wraps the kernel's C `struct work_struct`.
>>> +///
>>> +/// This is a helper type used to associate a `work_struct` with the [`WorkItem`] that uses it.
>>> +#[repr(transparent)]
>>> +pub struct Work<T: ?Sized, const ID: u64 = 0> {
>>> +    work: Opaque<bindings::work_struct>,
>>> +    _inner: PhantomData<T>,
>>
>> Should this really be `PhantomData<T>`? Are you dropping `T`s in the 
>> destructor of `Work<T>`? I do not think so `PhantomData<fn() -> Box<T>>`
>> should do the trick.
>>
>
> Could you elaborate what is the issue in having `PhantomData<T>`?

I played around with this and as far as I can tell, using
`PhantomData<fn() -> Box<T>>` does not disable dropck for T. Thus,
`PhantomData<T>` has the same effect as `PhantomData<fn() -> Box<T>`,
which is covariance over T and dropck:

```rust
use std::marker::PhantomData;

struct A<T> {
    _marker: PhantomData<fn() -> Box<T>>,
}

//#[cfg(disable)]
impl<T> Drop for A<T> {
    fn drop(&mut self) {
        todo!()
    }
}

struct B {}

fn main() {
    let (_a, b);
    b = B {};
    _a = foo(&b);
}

fn foo<'a>(_b: &'a B) -> A<&'a B> {
    let a: A<&'a B> = A {
        _marker: PhantomData,
    };
    a
}
```

This is a little surprising to me since nomicon [1] explicitly marks
`PhantomData<T>` as "covariant (with drop check)" but only "covariant"
for `PhantomData<fn() -> T>`.

Not sure why you wanted the box?

Best regards,
Andreas


[1] https://doc.rust-lang.org/nomicon/phantom-data.html#table-of-phantomdata-patterns
