Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 722CD811D1F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 19:44:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378134AbjLMSoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 13:44:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233516AbjLMSoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 13:44:02 -0500
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 763D0EA;
        Wed, 13 Dec 2023 10:44:08 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5d33574f64eso74030817b3.3;
        Wed, 13 Dec 2023 10:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702493047; x=1703097847; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l2LwifpOgXej1dsHd1KHJezfiI8h2hD12gEj1McMU+k=;
        b=AkneJdYSedv/ZYOsBalOkTWnlwtta2QsasKigF6ZNO3JvglzTDRN7/BMBrs4+OyMEe
         2/8Be1gHml/OqR0OYR7ATngNfz13xtB6RWWtbni3rmVxnFRXcr+97XNweotJ3S2d7RZp
         B7lyn3gCN92EaVIhtDoM5GVcNuYj7QXaeKgcpZLeDbscteRZm+OS9XKOorwG+gZ3jL5C
         JNjnzsqpsw9u2I2SqDIsGPRqoUM6dkNLT70rG0gTmGhTBKAzYW2JsihuaZen/sGwCLA5
         3sHG90e/Rt2CtV1qh7Nb1DpXZXAqoXnPYUhNpIInZlbnLVhspWM/jAbNLBfJQvzRplOZ
         5EwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702493047; x=1703097847;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l2LwifpOgXej1dsHd1KHJezfiI8h2hD12gEj1McMU+k=;
        b=dQ7AbKwbrpB8WNBJhW5Mb5UzB/Ljrk0nSW81iwB5iw/9LjMASccNB68JaM01WMTZx5
         Gozg1Ab3hC/Czh6bBQ/AtvInJc/aHWlLBEMYHM7NlxjCSVo7881i9N2vcyzIBVgTXh0m
         O9oYQuDn3CI6T5ewQNEUTIZgDm0eqSbqW8rXa/Y13pGmenda4Mr0YqK5X8Hldl892wH9
         3qm7A41eENhXxi7dlXtfI8xZv69RuRsLCaKlYnFJgFv67B00M9Lxek9FQgxnYpv3usQ6
         nYsN1YGJ5rdRdcdQCVoP/wV5Y90QqXl5Q+KgQtrQVPIGBXXONAeO4f4063j1C35QkuD5
         FM/g==
X-Gm-Message-State: AOJu0YwVNaC49hIktnwDDwZ1zwolOecJuAf3Fr+4WuUJKnkg3dUfoLIn
        7HmI5OH9l2bShRJrwqarvIZPldZOxxJG6uxb2EQ=
X-Google-Smtp-Source: AGHT+IFd3K+SY9c18W79MkJVqB2q5KL7a71Eye1yZ2Yet4HXlhA9PPM7Cwa5kQtzyj27Aii8A7ptyLqtukiMGfgBB+A=
X-Received: by 2002:a81:8415:0:b0:5e2:f017:24b5 with SMTP id
 u21-20020a818415000000b005e2f01724b5mr989270ywf.21.1702493047731; Wed, 13 Dec
 2023 10:44:07 -0800 (PST)
MIME-Version: 1.0
References: <20231031201945.1412345-1-mmaurer@google.com>
In-Reply-To: <20231031201945.1412345-1-mmaurer@google.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 13 Dec 2023 19:43:56 +0100
Message-ID: <CANiq72mmx01ow3fN_8uaWFOw1wDZ2DfN2ZgEA5O+412gzeYCCg@mail.gmail.com>
Subject: Re: [PATCH] rust: Ignore preserve-most functions
To:     Matthew Maurer <mmaurer@google.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>, Tom Rix <trix@redhat.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2023 at 9:20=E2=80=AFPM Matthew Maurer <mmaurer@google.com>=
 wrote:
>
> Neither bindgen nor Rust know about the preserve-most calling
> convention, and Clang describes it as unstable. Since we aren't using
> functions with this calling convention from Rust, blocklist them.
>
> These functions are only added to the build when list hardening is
> enabled, which is likely why others didn't notice this yet.
>
> Signed-off-by: Matthew Maurer <mmaurer@google.com>

Applied to `rust-next` (used Markdown for consistency with the other
comments in the file).

Thanks everyone!

Cheers,
Miguel
