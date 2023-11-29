Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C84E7FDE1B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 18:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbjK2ROc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 12:14:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjK2ROb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 12:14:31 -0500
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B646DBE
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 09:14:36 -0800 (PST)
Received: by mail-oo1-xc30.google.com with SMTP id 006d021491bc7-589d4033e84so20889eaf.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 09:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701278076; x=1701882876; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MVsHkDnPJv0j8Tyw7llEjBSU+xBdT2jqqtQEJ/0zHok=;
        b=OtYewhT3wmSbRL7ryhSGj0r15FYQ7Y7RS8yNJv7JnCy4UbHx0U7mQ1W7jo42tx/M2Y
         Ie28l5Km/fGm/OXKTp8I1lnDi/dR2KHFAS9SjNa3PO3eaMczQaaTNcZlxArvnQR5ARr0
         3vAHzm98zbFAy1f+GzAeAcbIbkVvE8JUnRKm+9dlQG5sk7iFVKK2fjpod9ihR03+qKHG
         1EzJ0YCnPlPl/4ktMeFqXBZAud3heEanQVCwXxYviq/7OMVwQ18LYXlE/Xd8ELI/MYVM
         DTnJmS1UQyrFlFcrXPPJiucu40+KtOKlvl9Dv9r/kwF4kUsIJNvAHlUG5ruPOlrnExgS
         BmWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701278076; x=1701882876;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MVsHkDnPJv0j8Tyw7llEjBSU+xBdT2jqqtQEJ/0zHok=;
        b=ZrQmdagTT3sip06xQUFhtRexhgKydWfpQ4RJaOP/Ro3Q6akM0OI5khAnyZWaYhzANa
         e6B1leVCJbmvoH4oUX9ekO5ICy3LAo1YkNduIhkPsN4IOygz6x5iwIfX2ONha/AnBzY1
         R7fCjJok4XtyPJ184jmfhIZEeFplW9QVuvMQtgTFjpWt8D64T12fjzC/3r+8+PTLOnYy
         MurV/J/aJ9ht1TJPGcYTn9aLcsJb3zhPLsOgIZQSe5NQgsSohDXnUbEoKJSaReDhCvci
         ey5QtHvrq3d9qa09Y/eVMVGMdNZQXWZwvNTai0uFtO2ceRbtip7xlZwRMjyYKcwL89Cz
         eTig==
X-Gm-Message-State: AOJu0Yy2AOggUfT7HnQykdsJS/HJ/qV5++iLcNPblUJcLKrOvi+gVy31
        zHX6WEaSyaUxaC69Ou3g+LU/SpJVL6hdm4L+j3O6Zg==
X-Google-Smtp-Source: AGHT+IG/Y/jre/2EQ/tO3gsWKMCBwDqTqTUvW8ZnVpGn4c1xWujT3jYFmjBsMcCjYyA3TQyN5J0+PC1fAeByipFxMuM=
X-Received: by 2002:a05:6358:9998:b0:16b:fbd7:e34a with SMTP id
 j24-20020a056358999800b0016bfbd7e34amr20723935rwb.5.1701278075870; Wed, 29
 Nov 2023 09:14:35 -0800 (PST)
MIME-Version: 1.0
References: <20231129-zwiespalt-exakt-f1446d88a62a@brauner> <20231129165551.3476910-1-aliceryhl@google.com>
In-Reply-To: <20231129165551.3476910-1-aliceryhl@google.com>
From:   Alice Ryhl <aliceryhl@google.com>
Date:   Wed, 29 Nov 2023 18:14:24 +0100
Message-ID: <CAH5fLgi6n6WiueLkzvZ7ywt5hXWAJFAyseRr3O=KRAHUQ=hNrQ@mail.gmail.com>
Subject: Re: [PATCH 4/7] rust: file: add `FileDescriptorReservation`
To:     brauner@kernel.org
Cc:     a.hindborg@samsung.com, alex.gaynor@gmail.com, arve@android.com,
        benno.lossin@proton.me, bjorn3_gh@protonmail.com,
        boqun.feng@gmail.com, cmllamas@google.com,
        dan.j.williams@intel.com, dxu@dxuuu.xyz, gary@garyguo.net,
        gregkh@linuxfoundation.org, joel@joelfernandes.org,
        keescook@chromium.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, maco@android.com, ojeda@kernel.org,
        peterz@infradead.org, rust-for-linux@vger.kernel.org,
        surenb@google.com, tglx@linutronix.de, tkjos@android.com,
        viro@zeniv.linux.org.uk, wedsonaf@gmail.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 5:55=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> w=
rote:

> >> +    pub fn commit(self, file: ARef<File>) {
> >> +        // SAFETY: `self.fd` was previously returned by `get_unused_f=
d_flags`, and `file.ptr` is
> >> +        // guaranteed to have an owned ref count by its type invarian=
ts.
> >> +        unsafe { bindings::fd_install(self.fd, file.0.get()) };
> >
> > Why file.0.get()? Where did that come from?
>
> This gets a raw pointer to the C type.
>
> The `.0` part is a field access. `ARef` struct is a tuple struct, so its
> fields are unnamed. However, the fields can still be accessed by index.

Oh, sorry, this is wrong. Let me try again:

This gets a raw pointer to the C type. The `.0` part accesses the
field of type `Opaque<bindings::file>` in the Rust wrapper. Recall
that File is defined like this:

pub struct File(Opaque<bindings::file>);

The above syntax defines a tuple struct, which means that the fields
are unnamed. The `.0` syntax accesses the first field of a tuple
struct [1].

The `.get()` method is from the `Opaque` struct, which returns a raw
pointer to the C type being wrapped.

Alice

[1]: https://doc.rust-lang.org/std/keyword.struct.html#:~:text=3DTuple%20st=
ructs%20are%20similar%20to,with%20regular%20tuples%2C%20namely%20foo.
