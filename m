Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCD6777CCF0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 14:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237256AbjHOMui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 08:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237383AbjHOMuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 08:50:24 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 883C8199B;
        Tue, 15 Aug 2023 05:49:56 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-586bacac98aso49789427b3.2;
        Tue, 15 Aug 2023 05:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692103796; x=1692708596;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AX2xNsuS+KPLpPndR9waoObgf7HJ35Xx+VqDYH3unJs=;
        b=dDi5Jav1DqjKd5+B0Td7WZ8HDlYH/vscPvN0YQTIPnV2ArLFhm6QP4b2bwlDlSscqN
         futPjTMYK3gF/yFIB9cCqpC9jw34OQAVJcX60gbwRs57F1VNrYaSdug6V2fBpEO/YJWR
         EgA4IqXaRgD98VfYskd1ix07y6zT67dv5bllUpzGwwQNtj7z48LO9vBsYSWJvltzx+0a
         NqsxTf1WcRDYx6280xfp+ECRWDA7SYxtDXverAaesFnFWDhIohO5KWh00JkCklrGlMQo
         FaVhjH5oQQZ+fXgg9dW9gACGsRISGzBxX01Jm0xqDy/3pawEVnPdB99+CUafkngqXqMm
         YEbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692103796; x=1692708596;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AX2xNsuS+KPLpPndR9waoObgf7HJ35Xx+VqDYH3unJs=;
        b=SphBwQI6dyUCo/CIQJ4FXaRF4+qLlySYdDTCpiN/Q9rrjYFNmitWVoqKo/Dic3/kOp
         MNrRMIIVnV4hB0K4ChA8ENlMXBXG/YAK9h7aNwNSjRWm6r/5r278D4QSGIXge9GZhVmC
         rzCz46Lp0cKqWbko3Ug3AhCojAa/xFQqWlFr4POyGJIoWU5HyMCz+UyBEnMqSyhWTVfu
         EzFv2VvJC5WLOAniZExPsVUhpDHGJQN2niaOt2c3zbD2kIPhkCyKi9yygx3YyXpX/FYM
         S7NPN2F0w9ck93YO4aEj+U4rUyDJflPxZ48LvA1MVc/M1SYq1CjET0c/6w1tLSGSqfaJ
         Y/rQ==
X-Gm-Message-State: AOJu0YxknRUDbI9ylFbykrvW+rCjMXr8vtY9mYrU+vymSw42Ok/J3P7K
        8K30ooPEcu99G7Ar2kX2VEDaqdg/YQO9V06rvso=
X-Google-Smtp-Source: AGHT+IH7JtZ2nRYV3FlM97/h/LBuoVEUpr4U8RbSfIVVfO49DTLkQSEOnfX3OklASaOXrNzewFLnOzuIvy5xq4QfUZk=
X-Received: by 2002:a25:2683:0:b0:d62:b8f5:d745 with SMTP id
 m125-20020a252683000000b00d62b8f5d745mr11676467ybm.52.1692103795729; Tue, 15
 Aug 2023 05:49:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230815065346.131387-1-andrea.righi@canonical.com>
 <CANiq72kv4DwGLSGTwXYh3-b9h08Erd2RH7wXvVAUAEx2x+q_BA@mail.gmail.com> <ZNtzG3Yy1US+dpP4@righiandr-XPS-13-7390>
In-Reply-To: <ZNtzG3Yy1US+dpP4@righiandr-XPS-13-7390>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 15 Aug 2023 14:49:44 +0200
Message-ID: <CANiq72nGurz9dJjy2p8q347vfsbaoAm8Jb5L4WAW0W2+5KZHOw@mail.gmail.com>
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 2:44=E2=80=AFPM Andrea Righi <andrea.righi@canonica=
l.com> wrote:
>
> Oh yes, indeed! I'm using clang/libclang-14 with gcc-13, if I switch to
> clang-15 everything seems fine, so I can simply move to this version.

Thanks for confirming!

> The combo gcc-13 + libclang-15 seems to work in my case, instead with
> libclang-16 I get this:
>
>   BINDGEN rust/bindings/bindings_generated.rs
>   thread 'main' panicked at '"ftrace_branch_data_union_(anonymous_at__/_/=
include/linux/compiler_types_h_146_2)" is not a valid Ident', /build/rust-b=
indgen-0.56-DgAMvF/rust-bindgen-0.56-0.56.0/debian/vendor/proc-macro2-1.0.2=
4/src/fallback.rs:693:9

Yeah, this is fixed in `bindgen` 0.62.0. We have upgraded in
`rust-next`, commit 08ab786556ff ("rust: bindgen: upgrade to 0.65.1").

Cheers,
Miguel
