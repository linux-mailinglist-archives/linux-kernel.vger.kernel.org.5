Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE07277CC52
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 14:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237020AbjHOMG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 08:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237018AbjHOMGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 08:06:49 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9834110F4;
        Tue, 15 Aug 2023 05:06:48 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-d656d5e8265so4735597276.1;
        Tue, 15 Aug 2023 05:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692101208; x=1692706008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AQ4g8mr+OyTMsYEbUpF2F3Qa/C/YAL314bAhtTbEOlY=;
        b=OAHzoWjL+C9zwVAswXVDoqKL9lpTLe+5ddIl+npVRABzpRN5QvCvJ0ccIAcFJAnUaV
         KwsRRW9CIK3wD2G12006DqxR3xUeiZH+9yGZHL6JP9qHGy1GwZWoG0307Ty8Ryaa/dQH
         daYwEmtzk9kIM/NVKxEC9Ic5YUE/styx0Jaf4n9caZbtlTjTQIp+9YcxGbDi4kEziTqg
         YkmsWA/875Z2C/a7bD7qlOzmzZYtE3lMmgXTFiXA92Xnf1JIykjKFHpvQr40eeZio+6N
         HAapYNoQ3CoaerrUizqKW/MEe89hsie65ohbuRhB3Ni5xwI2uLdZ5uKuB0lyIyUjx6KA
         ImDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692101208; x=1692706008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AQ4g8mr+OyTMsYEbUpF2F3Qa/C/YAL314bAhtTbEOlY=;
        b=AEfTU04tcATQcPpVHMmpCksU0yApNJCA454TqOHcUq1b3SgFTTmftSx6cnaToV0EaW
         1hH5O8zccwAgNMwjzPOF5MR2Vl4ShkqwD2ILyX3NCp7ZYuSfJlOEsMKNB1SwVlXjygEM
         eQpl1g7GLUNOeYLcVkl793UYdlfah6U4EvvhRkwYc6cUJcX+3esDwu7Dpw/CtatE0Onq
         qhCP6nBNVEFnyT3TXM9NVQkUHYGNh7UQesg8x/F1v2ZRi/JZmYsZoVuYkvURy3J1v/a5
         k9FUl9bOlcDF0fWXsj5s89r916lnyJDTlRASuPUGYMe+0omn0A/aivJmWEpZvcZlJ93q
         oCmQ==
X-Gm-Message-State: AOJu0YzSjiBJQ5xDpS+KvxiGiN3uHCuPdsaclaisgugC11HewnIt7ei3
        gHRKwBRoddEy7YLBMXIYhfhhuZ6SjAvpUrHaZrk=
X-Google-Smtp-Source: AGHT+IFV/KtnWW8PqUFv2mqz9nKSPx3B+6R9TqjaXgibwlqERzUWNdKocN5ShYYtweR3BeWY+TjH34ZkF/ch7idsGcs=
X-Received: by 2002:a25:ab46:0:b0:d0e:5521:5f02 with SMTP id
 u64-20020a25ab46000000b00d0e55215f02mr12814244ybi.11.1692101207776; Tue, 15
 Aug 2023 05:06:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230815065346.131387-1-andrea.righi@canonical.com>
In-Reply-To: <20230815065346.131387-1-andrea.righi@canonical.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 15 Aug 2023 14:06:36 +0200
Message-ID: <CANiq72kv4DwGLSGTwXYh3-b9h08Erd2RH7wXvVAUAEx2x+q_BA@mail.gmail.com>
Subject: Re: [PATCH] rust: fix bindgen build error with fstrict-flex-arrays
To:     Andrea Righi <andrea.righi@canonical.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        rust-for-linux@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>
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

On Tue, Aug 15, 2023 at 8:54=E2=80=AFAM Andrea Righi <andrea.righi@canonica=
l.com> wrote:
>
> Commit df8fc4e934c1 ("kbuild: Enable -fstrict-flex-arrays=3D3") enabled
> '-fstrict-flex-arrays=3D3' globally, but bindgen does not recognized this

It may be more accurate to say libclang here (bindgen forwards the options)=
.

Also, df8fc4e934c1 did it so only conditionally (if the C compiler
supports it). This explains what you are seeing: if I am right, you
are compiling with a modern enough GCC, which enables the option, but
with an old enough Clang.

> compiler option, triggering the following build error:
>
>  error: unknown argument: '-fstrict-flex-arrays=3D3', err: true

This should only be true with libclang < 16, since Clang 16
implemented the option, right?

In fact, Clang 15 seems to work too -- it seems the compiler does not
error if the option is not within [0,3] (unlike GCC).

Kees: this should only affect `__builtin_object_size` and not `sizeof`, rig=
ht?

From a quick test across Clang 14/15/16 and different levels for the
flag (0/1/2/3/4 and no flag), bindgen seems to generate the same
output in all cases: `__IncompleteArrayField` is always generated for
`[]` and `[0]`; and never for `[1]`, i.e. regardless of the flag. The
`sizeof`s agree with the C side, and they are all the same (as
expected because this only changes BOS).

So I think the patch contents (i.e. ignoring the flag for bindgen)
should be fine. Except we could have somewhere a
`__builtin_object_size` influencing a layout. Since GCC seems to
always treat it as not a constexpr (unlike Clang), I assume nobody is
using it like that (since we compile the kernel with and without the
flag). But it is still possible in theory -- it would require
something like:

    struct X {
        int x[__is_constexpr(__builtin_object_size(s->c, 1)) ? 1 : 2];
    };

to make GCC and Clang (as well as Clang `=3D3` vs. Clang without the
flag) to compile but disagree on the size:
https://godbolt.org/z/6TqPjGK3d

Cheers,
Miguel
