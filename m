Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C945776CBD
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 01:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbjHIXW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 19:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231337AbjHIXW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 19:22:27 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD89E7F;
        Wed,  9 Aug 2023 16:22:26 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-d44c2ca78ceso2137190276.0;
        Wed, 09 Aug 2023 16:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691623346; x=1692228146;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BIUl3FxuenbYgegtww4zsQx4goyBh2oZ6RD1qE04nf0=;
        b=YOX5rrcHgZWY2PAuT84zdMK5Yo/XpX16IfVAZhlkaZrKsZXwKG64Js58zCjXWXaTIH
         PZrdehNDUIQ4TQguPx1elh2OcQF+y315TIYCyNzgJ3NHUh2+xPmCsPrvLd2BVxdP9sGR
         5oRCEf+xHeM0b0kFaftTOX8s+ou0dNYRWqMkiXMw5LjZN1cJ3H5wnuZQkTlgxSiPjVSN
         0VyJvWLNwsGL6SXH0ieyGbucyBUrrFT6WKlpqXZxTfYh3fe+VbKuc4mCm3shUwWkMRH3
         CBNPQ28F+3l/osELuaK8AWaq4pogM48Xuur+/+o/mYykeXjNCjtS/mfBIfyy3NyaN2eL
         7SIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691623346; x=1692228146;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BIUl3FxuenbYgegtww4zsQx4goyBh2oZ6RD1qE04nf0=;
        b=j2FSn8LfvfVrS4QTmTD1Aqh8JKQPggYx+1GkZPbssp+pflOHHVPuyF/fQdgJGacjd0
         jMEDTNlXIMpecGbEqVFsCUzQD0vCphlY76SZxd0oerAuzX37QSvUTWV7untVCjIOF0Ux
         EiuJXEJjedJwBESXF9nA1Si+UrnGTEZ3M14cPRCXJKBNUvif9dXNB9Hsqjt4hIkxTqqu
         ZD6lGb/dB5MIH7/WfH58YCBE1mRpgtqcmV4kjgJ7N2YTp5L0Jtzr7R2guB/ju1WAINmp
         kWCp+FYjMwWU7L1qH/aAZ4KmsbL3uwmvTsu9bWHZzMtln4Yjqk14pedTddYpIQNzQizV
         lacA==
X-Gm-Message-State: AOJu0YxMlxs+xAZrWNpU08CGr4bJ1eFlqzBSk8+vJ3nZjIyHzb9TCm9g
        5OeV+B2V0f0B8P7mvNrZDOWh9Ta9IAwQZhNRDQs=
X-Google-Smtp-Source: AGHT+IGLgG6fnTW8GY0KR28FUGaZr8piFyex7tKSH8C5xVXqQcVCymCcPeoxd043VzbV1SnRMfbD3/5O6YjG/WOweuI=
X-Received: by 2002:a25:adc6:0:b0:cb2:7e6:191c with SMTP id
 d6-20020a25adc6000000b00cb207e6191cmr499022ybe.20.1691623346002; Wed, 09 Aug
 2023 16:22:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230628171108.1150742-1-gary@garyguo.net>
In-Reply-To: <20230628171108.1150742-1-gary@garyguo.net>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 10 Aug 2023 01:22:15 +0200
Message-ID: <CANiq72nm3ZHqzAWr-8q894_TbOayEx0xmDeeMPpqQz9b-jGU6Q@mail.gmail.com>
Subject: Re: [PATCH] rust: macros: add `paste!` proc macro
To:     Gary Guo <gary@garyguo.net>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 7:12=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
>
> This macro provides a flexible way to concatenated identifiers together
> and it allows the resulting identifier to be used to declare new items,
> which `concat_idents!` does not allow. It also allows identifiers to be
> transformed before concatenated.
>
> The `concat_idents!` example
>
>     let x_1 =3D 42;
>     let x_2 =3D concat_idents!(x, _1);
>     assert!(x_1 =3D=3D x_2);
>
> can be written with `paste!` macro like this:
>
>     let x_1 =3D 42;
>     let x_2 =3D paste!([<x _1>]);
>     assert!(x_1 =3D=3D x_2);
>
> However `paste!` macro is more flexible because it can be used to create
> a new variable:
>
>     let x_1 =3D 42;
>     paste!(let [<x _2>] =3D [<x _1>];);
>     assert!(x_1 =3D=3D x_2);
>
> While this is not possible with `concat_idents!`.
>
> This macro is similar to the `paste!` crate [1], but this is a fresh
> implementation to avoid vendoring large amount of code directly. Also, I
> have augmented it to provide a way to specify span of the resulting
> token, allowing precise control.
>
> For example, this code is broken because the variable is declared inside
> the macro, so Rust macro hygiene rules prevents access from the outside:
>
>     macro_rules! m {
>         ($id: ident) =3D> {
>             // The resulting token has hygiene of the macro.
>             paste!(let [<$id>] =3D 1;)
>         }
>     }
>
>     m!(a);
>     let _ =3D a;
>
> In this versionn of `paste!` macro I added a `span` modifier to allow
> this:
>
>     macro_rules! m {
>         ($id: ident) =3D> {
>             // The resulting token has hygiene of `$id`.
>             paste!(let [<$id:span>] =3D 1;)
>         }
>     }
>
>     m!(a);
>     let _ =3D a;
>
> Link: http://docs.rs/paste/ [1]
> Signed-off-by: Gary Guo <gary@garyguo.net>

Applied to `rust-next` with the SPDX license identifier added as
discussed and the typo fixed -- thanks everyone!

Cheers,
Miguel
