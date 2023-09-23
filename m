Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23A7C7AC094
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 12:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjIWKhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 06:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjIWKhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 06:37:12 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB7AA9;
        Sat, 23 Sep 2023 03:37:06 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-59f57ad6126so4532607b3.3;
        Sat, 23 Sep 2023 03:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695465426; x=1696070226; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L5/b7ryqYnd2PGys4t8MfFqM18gaemddOGExKYfSuvk=;
        b=GVQ6umqu2Jtx8J6LsjilDu3cryimkt5CpDVM+rXg3uLJaECAA/6FEtXLc4HR0tXewm
         LqENuFQ7DO8Mz9YrNz8Y45taLwA/JRsIJuQE0KOMN+sItqXoc7E53xZWhRZy2Dli1/z6
         frCqaGONE+MSJCYvNuxGAWtcFbLSvaAsW4kRX/oue/9blqbQ8ycNDvuJZqVvBM2Q1FWc
         tX9oXOYYlchoS+5oChpCiEP6mQxBG1+AvRCZUYdEl/jaedXyLw1VB9+Yvnr3/yKeD6AL
         IO4359VuyWufecALG+uclbJ8IQbngB6hUiCR2fTeFyG8VFlGQEagSMfrUrAJ08afSsVD
         TDGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695465426; x=1696070226;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L5/b7ryqYnd2PGys4t8MfFqM18gaemddOGExKYfSuvk=;
        b=BLFaXRkP3wLzYzCu9dQLaowqxJUQ46BOPsyqvPMlSU/FSls/PyukGkWrspf+zEp4rw
         gYFVJck31pHYibk/jyonOC8KIag5Ti9E2F638YHdFdNYWh+hYsF7OWGN1txx2jlh5K+f
         NfEtrHPMBlpbAlG8gZ1FGO+iwilBwTw331cil0ustA0pnZ85BBpJdpWWl5nLj5c8qhmS
         OAM1qozQSX6n+lJR/rlrWX6QlA6nBqonI8CxCTb3ymre/IDQHZY3ifiWf6fMyxRdyKLs
         sOzB6btm7j6VBIq1eF//iEa/yzmgt5kSSenXxbLdAASi5Iu8qfPqC6XIwrjv9W4N4D3x
         XSiA==
X-Gm-Message-State: AOJu0Yy3HBUyTxTqUykuKi24Bvdd3JSmxkmKVIvFIktBuglV66Pae/6m
        fqaEa392fqPbLjYZHtx6Zof1EonsTkcEK7AZ6/N0SWWd2IznJozk
X-Google-Smtp-Source: AGHT+IFppYuzXzdG/r1u0vJuGlE83f9sKVVT2F5A6sqPc6g8omrWrmcOyV2RU9KHUYYVfqsGUColXegmpB1dNQOgWEU=
X-Received: by 2002:a0d:ea96:0:b0:59b:3d66:ed50 with SMTP id
 t144-20020a0dea96000000b0059b3d66ed50mr1724091ywe.6.1695465426152; Sat, 23
 Sep 2023 03:37:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230923024707.47610-1-gary@garyguo.net>
In-Reply-To: <20230923024707.47610-1-gary@garyguo.net>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 23 Sep 2023 12:36:54 +0200
Message-ID: <CANiq72mvMM5v9nQKwCV9EeBPUut-NRASNKqLjN2vAM-va5jdQQ@mail.gmail.com>
Subject: Re: [PATCH] rust: remove ignores for `clippy::new_ret_no_self`
To:     Gary Guo <gary@garyguo.net>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        Ben Gooding <ben.gooding.dev@gmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 23, 2023 at 4:47=E2=80=AFAM Gary Guo <gary@garyguo.net> wrote:
>
> The clippy false positive triggering `new_ret_no_self` lint when using
> `pin_init!` macro is fixed in 1.67, so remove all `#[allow]`s ignoring
> the lint.

+1, thanks Gary, this is one I found thanks to the `#[expect]` series
I have to send. There are a couple others that I clean up there
(`non_send_fields_in_send_ty`, `dbg_macro`). Since you sent this one,
I will take your patch :)

If you don't mind, I will reword it a bit to add the couple links I had:

    rust: kernel: remove `#[allow(clippy::new_ret_no_self)]`

    Since Rust 1.67.0, Clippy's `new_ret_no_self` lint learnt to not
    warn about `-> impl Trait<Self>` [1][2].

    The kernel is nowadays on Rust 1.71.1, thus remove the `allow`.

    Link: https://github.com/rust-lang/rust-clippy/issues/7344 [1]
    Link: https://github.com/rust-lang/rust-clippy/pull/9733 [2]

Cheers,
Miguel
