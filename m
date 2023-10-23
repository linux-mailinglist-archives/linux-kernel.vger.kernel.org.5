Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 308377D2CD1
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 10:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbjJWIex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 04:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjJWIeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 04:34:50 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 741E5FC
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 01:34:46 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9936b3d0286so455118666b.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 01:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20230601.gappssmtp.com; s=20230601; t=1698050085; x=1698654885; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mr09I8/vo3nr2nBuJIYetcGr8lJCNmgIPhtRToZk5ok=;
        b=pX5OTB3bmjdnesVzjWO9rRcu130m/5OJViVbioO8Kw0jonCCXUcr1Z0dAZVnqHSX2I
         okWK1qYdv2gCUvvtJzz0w8TvKx0/tvfgBxPEYITLmHBvFQCX0v48mXvGX2qcEDRhY/nD
         h/wTjX6iH3XM2OaOOYYm6OImTouGgf82vGSgsKOTKhrHXAzzoqTxQn0OwPuD2c43l1Ta
         ivtIpbXg7hf4oHDhTYiarbo/kxVWuazP2U2PwjBskFsjKY5+Jd60r257FkSTWzj7f6Xl
         GVn3HpJ9CTpl8IJ/s2oASlb3aD3FW62Qd2ZiHdzdq43axNPv1Hn4ETSQEnOvTA42vHRm
         CFTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698050085; x=1698654885;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Mr09I8/vo3nr2nBuJIYetcGr8lJCNmgIPhtRToZk5ok=;
        b=UxET1FNZNwlfW3V6TXsfr0jMOsj5uLTttDDFszOxguyYkDc/Or9UPZ5rXD5jr2fNj3
         TmnSL5B3hOtjK5vlKpG0LNilaomy44okae7WpSzu20L0bF4humONNGpTp1TU6XeqZ5kE
         8FrFHa9Bgb6iXXveSEYgp8ATJzGFakDjVpNHxg/EIf/L3s8CTTSzuoD/zl6ngSloXHLC
         Ed3tmcklSY767UBar3toYXF61IyPPjFAsvcoVmXq8YekqO3WwX00ZvbslkF9rhbS1AWG
         xsxtpqvJJ1Vp22L6M7Z0Zj/jxqOX9T4DNrk2FRRi5zRNwnS1JrdFF/jZcLlDg2VxCnEJ
         5xUA==
X-Gm-Message-State: AOJu0YyWaiSi0cF2LS/BDRAvYaW3ZjxDpMod3Z3uTDfDrmR+CefL7qeL
        H84XEAH7uEne0B/q2K8MyBH82g==
X-Google-Smtp-Source: AGHT+IF27JDoFPxmlVkE0M2eVANH6GmCStzw+JH8dPoflKLeLx/GjHnhEjRP4T2+mEbKDibHwC2jYg==
X-Received: by 2002:a17:907:1b07:b0:9c7:5207:280a with SMTP id mp7-20020a1709071b0700b009c75207280amr7141146ejc.55.1698050084722;
        Mon, 23 Oct 2023 01:34:44 -0700 (PDT)
Received: from localhost ([194.62.217.3])
        by smtp.gmail.com with ESMTPSA id xa17-20020a170907b9d100b00982a92a849asm6257017ejc.91.2023.10.23.01.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 01:34:44 -0700 (PDT)
References: <20231019171540.259173-1-benno.lossin@proton.me>
 <87fs25irel.fsf@metaspace.dk>
 <ba252f66-b204-43c1-9705-8ccd0cb12492@proton.me>
User-agent: mu4e 1.10.7; emacs 28.2.50
From:   "Andreas Hindborg (Samsung)" <nmi@metaspace.dk>
To:     Benno Lossin <benno.lossin@proton.me>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Alice Ryhl <aliceryhl@google.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rust: macros: improve `#[vtable]` documentation
Date:   Mon, 23 Oct 2023 10:30:06 +0200
In-reply-to: <ba252f66-b204-43c1-9705-8ccd0cb12492@proton.me>
Message-ID: <878r7thh3w.fsf@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Benno Lossin <benno.lossin@proton.me> writes:

> On 20.10.23 11:06, Andreas Hindborg (Samsung) wrote:
>> Benno Lossin <benno.lossin@proton.me> writes:
>>> +/// Error message for calling a default function of a [`#[vtable]`](ma=
cros::vtable) trait.
>>> +pub const VTABLE_DEFAULT_ERROR: &str =3D
>>> +    "This function must not be called, see the #[vtable] documentation=
.";
>>> diff --git a/rust/macros/lib.rs b/rust/macros/lib.rs
>>> index c42105c2ff96..daf1ef8baa62 100644
>>> --- a/rust/macros/lib.rs
>>> +++ b/rust/macros/lib.rs
>>> @@ -87,27 +87,41 @@ pub fn module(ts: TokenStream) -> TokenStream {
>>>   /// implementation could just return `Error::EINVAL`); Linux typicall=
y use C
>>>   /// `NULL` pointers to represent these functions.
>>>   ///
>>> -/// This attribute is intended to close the gap. Traits can be declare=
d and
>>> -/// implemented with the `#[vtable]` attribute, and a `HAS_*` associat=
ed constant
>>> -/// will be generated for each method in the trait, indicating if the =
implementor
>>> -/// has overridden a method.
>>> +/// This attribute closes that gap. A trait can be annotated with the =
`#[vtable]` attribute.
>>> +/// Implementers of the trait will then also have to annotate the trai=
t with `#[vtable]`. This
>>> +/// attribute generates a `HAS_*` associated constant bool for each me=
thod in the trait that is set
>>> +/// to true if the implementer has overridden the associated method.
>>> +///
>>> +/// For a function to be optional, it must have a default implementati=
on. But this default
>>> +/// implementation will never be executed, since these functions are e=
xclusively called from
>>> +/// callbacks from the C side. This is because the vtable will have a =
`NULL` entry and the C side
>>> +/// will execute the default behavior. Since it is not maintainable to=
 replicate the default
>>> +/// behavior in Rust, the default implementation should be:
>>=20
>> How about this?:
>>=20
>> For a Rust trait method to be optional, it must have a default
>> implementation. For a trait marked with `#[vtable]`, the default
>> implementation will not be executed, as the only way the trait methods
>> should be called is through function pointers installed in C side
>> vtables. When a trait implementation marked with `#[vtable]` is missing
>> a method, a `NULL` pointer will be installed in the corresponding C side
>> vtable, and thus the Rust default implementation can not be called. The
>> default implementation should be:
>>=20
>> Not sure if it is more clear =F0=9F=A4=B7
>
> I think it misses the following important point: why is it not
> possible to just replicate the default behavior?
>
> What do you think of this?:
>
> For a trait method to be optional, it must have a default implementation.
> This is also the case for traits annotated with `#[vtable]`, but in this
> case the default implementation will never be executed. The reason for th=
is
> is that the functions will be called through function pointers installed =
in
> C side vtables. When an optional method is not implemented on a `#[vtable=
]`
> trait, a NULL entry is installed in the vtable. Thus the default
> implementation is never called. Since these traits are not designed to be
> used on the Rust side, it should not be possible to call the default
> implementation.

> It is not possible to replicate the default behavior from C
> in Rust, since that is not maintainable.

I don't feel that this bit should be included. It's not a matter of
maintainability. Why would we reimplement something that is already
present in a subsystem? The functionality is already present, so we use
it.

> The default implementaiton should
> therefore call `kernel::build_error`, thus preventing calls to this
> function at compile time:

Otherwise I think it is good =F0=9F=91=8D

BR Andreas
