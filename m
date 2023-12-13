Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7A91811D2A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 19:45:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379071AbjLMSpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 13:45:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233651AbjLMSpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 13:45:30 -0500
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50226DD;
        Wed, 13 Dec 2023 10:45:37 -0800 (PST)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-5e266e8d39eso17185567b3.1;
        Wed, 13 Dec 2023 10:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702493136; x=1703097936; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8kdpPGKT7W/htzVmzX+GVwFRmAQOFC9bkN2uytvBCpY=;
        b=SoAUaShDUQms2iEQcsW5Z8V3Nl+h37bJJ/bFjMIA2AiD8cuZb3ooj3B3G6PJ97icmq
         prLUdZqqRX8rgd4pU+cxBhHjiy1rsukyzVRbQKJQY1J4EB1GzyFcsalxpMjgZOuO3wLS
         ZsEOBnlf8W4kUNS/NNJvKaRpslYl9Hy50zn2g0DZOP4Yb4gp18vRBtblgGg5AQI7Dp/J
         jYfTzAelfCPPsnLcVr16PjrC2Uc+phzaiCxopCNNWKSRw25U7YtUS4YWADy1ygZBzumk
         ERNrKJnbHAkciF/ItWnMA0W9/tJ/FHfzj41rgs9hEzuwR5lu7ac163JdhPp9fiP+wzak
         KOPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702493136; x=1703097936;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8kdpPGKT7W/htzVmzX+GVwFRmAQOFC9bkN2uytvBCpY=;
        b=VQfa5JhGUl8chBe3z5P9g2sVvqeNHixFGbUZMleVY+ire5LdSo3JewFwrkdfzyzMe+
         ta4vA74ePmV4sKceH6MkGWROnTyF6ozcXq5WprEeg7ZsF98rW2L2+yrA4LHYhniYLg0h
         9G1LqGjNNKshIg8f3ZrJMPzbv+AhY5KBLIsWMvVyrcR9oSwHSPwDt+91XKSboCj9gLsw
         33pYnKCb1nM8f+dhCbPpst6pRlYYxGicn6Sydq27KWGkMHHaXUr58n6Y0WdiKhVq2CG6
         1Iow7OdmuJRGoMso0tKw2qDPCcT97o7g2Z+9GUrmXWMoV8ZrKUsxJUBqzwp+V/ynM7PE
         LE1A==
X-Gm-Message-State: AOJu0YzbNstYdgPC9VZJPTtotU8C5H+SEnzjab9uaBr49a8s2/KA4hTG
        2+9XhoH8utjEE1dIFeX6lPbiDu9LMf8vr8Kked0=
X-Google-Smtp-Source: AGHT+IEp/QnTz9hl1J5TCHI6eIHEOdWsqB2OwicWVGX1cpaFK3RhGSdQQDm4J0tE1TyFZ2hiCyg7aZ8Vz32dqbMaFJM=
X-Received: by 2002:a0d:c344:0:b0:5d7:1941:2c19 with SMTP id
 f65-20020a0dc344000000b005d719412c19mr6456637ywd.70.1702493136530; Wed, 13
 Dec 2023 10:45:36 -0800 (PST)
MIME-Version: 1.0
References: <20231031201752.1189213-1-mmaurer@google.com>
In-Reply-To: <20231031201752.1189213-1-mmaurer@google.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 13 Dec 2023 19:45:25 +0100
Message-ID: <CANiq72nDq-jr-sQT5aCo6VevqOPX+EUPk9ByUtwjixy5Ut7mag@mail.gmail.com>
Subject: Re: [PATCH] rust: Suppress searching builtin sysroot
To:     Matthew Maurer <mmaurer@google.com>
Cc:     Jamie.Cunliffe@arm.com, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>, will@kernel.org,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org
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

On Tue, Oct 31, 2023 at 9:18=E2=80=AFPM Matthew Maurer <mmaurer@google.com>=
 wrote:
>
> By default, if Rust is passed `--target=3Dfoo` rather than a target.json
> file, it will infer a default sysroot if that component is installed. As
> the proposed aarch64 support uses `aarch64-unknown-none` rather than a
> target.json file, this is needed to prevent rustc from being confused
> between the custom kernel sysroot and the pre-installed one.
>
> Signed-off-by: Matthew Maurer <mmaurer@google.com>

Applied to `rust-next`. I added Boqun's fix for `rusttest` as well as
a fix for `rustdoc` (which requires a conditional for host crates like
`macros`); and added a couple `Links` to the arm64 discussions.

I would appreciate extra testing for this one (please use `rust-next`
commits in that case).

Thanks everyone!

Cheers,
Miguel
