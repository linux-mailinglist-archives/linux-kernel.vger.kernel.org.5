Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6BA776CB6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 01:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbjHIXUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 19:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjHIXUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 19:20:17 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD6E6E5B;
        Wed,  9 Aug 2023 16:20:16 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6bb140cd5a5so314085a34.3;
        Wed, 09 Aug 2023 16:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691623216; x=1692228016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q4bjpbOVzhS/c71+nx5Vv5jKZGKpCfxh8wPlkNMHQKA=;
        b=jjJOPhx6JTrsO9FS7aBuBZ1m4BVV4rSCmkmT7q0epzQwjEGjsYbjj7WWhQr504ivDT
         whbaPitcK7eiPRqQdOlSIrRZXuE6xiqfcCtFYOmF/Oqk2IJMCHjv3MOpnu2uNBmf0FVw
         yknUDb7q+DMM7LIW2Amun+1mbYCVTG/+oYsrSN5QsTKR3ErxcoQxbQLiaJcmzgcO6Xb3
         8zfpb5pM/DbK6wJayfk4HYxy85iU8M/C5Ij9H5WyQ3qdA38A0dvcdgkuNOj2A+5PgBK1
         yFhoUjmmFhXPVMVtSwMJBclyayEox4B1LxEB8lgcGK3BUucovjoehA91etuXl739JCJ7
         eY9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691623216; x=1692228016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q4bjpbOVzhS/c71+nx5Vv5jKZGKpCfxh8wPlkNMHQKA=;
        b=VTFwX0z5I95b86bZBxjHLGRumDKj1y7bDWPWxfeEZ/dfmARpNoFgt9gxZR04+mZ8ZQ
         oMatENvva3K2dfksD0HmmOmLnQdcm8d+v1K+gL7C41lRACuzH/T4wMDw4zVF/jmNKj4Y
         iAT18E9wSsQLcj+NR3ZJfxmfofCXPF6m4xisZ9jBNcirVtDGEBHqx6qcP0c730PYEp+0
         pGgNGAiblG2ZQcBfQziKxfhuzUYOElgDo7RGgcOF1twDWDP4fnTR0px379TwvuxKqRe2
         mXpFYkmk28knov/o0lyFa1/zZRK5DfbjhN1QZVD8CHJMyUQhr0vx22eTwSzjim7ZvB13
         gukw==
X-Gm-Message-State: AOJu0Yz9M1CJ/XtFrxH5DTZYimz9WuV6GJmoqjzSQjozPpnFwm3NlkWQ
        vO0TjqxKMFQHratJ9qaXRfE2oeiZimeRYbhvlYU=
X-Google-Smtp-Source: AGHT+IFzc9WExJTelE4UFXJdXGTsbbj7zl8kEJ1ObbVww635P/YePw5RXRXX2R/HzdZTmwBWSFoSOsp+jAXgiJNEqMk=
X-Received: by 2002:a05:6358:905:b0:135:89d6:22e9 with SMTP id
 r5-20020a056358090500b0013589d622e9mr972139rwi.13.1691623215946; Wed, 09 Aug
 2023 16:20:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230718054521.1048785-1-ojeda@kernel.org>
In-Reply-To: <20230718054521.1048785-1-ojeda@kernel.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 10 Aug 2023 01:20:05 +0200
Message-ID: <CANiq72mizpDgKq+1vn0aQejMw0205oq6A_1yfw5RCVsVA1mVkA@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: add Alice Ryhl as Rust reviewer
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Alice Ryhl <aliceryhl@google.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 7:45=E2=80=AFAM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> Alice has been involved with the Rust for Linux project for
> almost a year now. She has been primarily working on the
> Android Binder Driver [1].
>
> In addition, she has been reviewing patches in the mailing
> list for some months and has submitted improvements to the
> core Rust support.
>
> She is also part of the core maintainer team for the widely
> used library Tokio [2], an asynchronous Rust runtime.
>
> Her expertise with the language will be very useful to have
> around in the future if Rust grows within the kernel, thus
> add her to the `RUST` entry as reviewer.
>
> Link: https://rust-for-linux.com/android-binder-driver [1]
> Link: https://tokio.rs [2]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Applied to `rust-next` -- thanks & welcome!

Cheers,
Miguel
