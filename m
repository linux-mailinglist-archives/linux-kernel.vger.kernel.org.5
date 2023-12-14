Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68372812E9F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 12:34:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444005AbjLNLeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 06:34:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444003AbjLNLeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 06:34:00 -0500
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90AE012D
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 03:34:06 -0800 (PST)
Received: by mail-ua1-x932.google.com with SMTP id a1e0cc1a2514c-7caa6ec63aaso2177276241.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 03:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702553645; x=1703158445; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OVpZi9LWxDndkG/jKZcYbbE5b7b5vMwfJTUTNSHguf8=;
        b=NYvUOsohI7nw2QtWaoeH047jWp1Uxl6M3HQdaJzfbtrfOTFaMWEikpy4d3xSh6bFNa
         nE8eZieUQOx1NalQ4XRJb76v0leaF0DBCh59Z6PL7wYgIBuXL+1dvRHjjKPxzJwNcfkc
         0oGRJ/v/6KIFR3NHPJKlXosU3BI9CjTlOWNZhN1Ha32masXnaZkI/NK+T8GiQLzk+bxw
         zgKRtHyR+N6UscsW/Vyf/RXxBfNgqqOV8jOlQOYo5gXh2OiYKx2V3TCzYwCbjiEaBQci
         W4X6p8IJTqdei//UqaZEw/AylD43vAQyiokbd/LVbWf9BiLtV1ftLHQhBA6WeB74t0Jb
         809w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702553645; x=1703158445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OVpZi9LWxDndkG/jKZcYbbE5b7b5vMwfJTUTNSHguf8=;
        b=H18roXvkiY3p3GOYP4wm2/I7R1/c+TgFfAIzucViL+qlAwdTFnGSPFrrQzIlSnJ0aL
         dUShXB2kh77x/pDZsJbHK0T19hzsqKTKlOY39NmCrhU44r38xGdWjSwqhxYJ7OTZIEgo
         vNFd1fsIJvRd0yHKBvsxHQJ3i+JyB6C4QY63Ca98aMftFh43fQxhkxoMZQ4zWI9wvr60
         m+8jPFAyh88sjXhUwjGVwUoYh15IK2GRyun4Vg13jAyB1G+872fiFMm7SdyHd5CCCEhm
         s4aDrVp3HLrMITGUcUzsaUmuRgXBZAwwy3lSSGajKXVBuUT/Rpwj5M3YwZQw11UiAdmX
         /Y/A==
X-Gm-Message-State: AOJu0Yy+hPzjMnTb2Ybmbvqn6C2SKe6qXW73rHmvdm3I0XY3IXgrRuXU
        wkV8h/fjHHrIU8pfcSGo3qI8TGEqGr19La+hI7bBQQ==
X-Google-Smtp-Source: AGHT+IGeIFMmkXzAkE9CquW7ofTFH0Rne6ZQ1/XSFA5z4R3Le9J9sRiwED3yszhOxfCM+mmsLl4seJ5a8HkLRjI4a9c=
X-Received: by 2002:a05:6102:3d90:b0:466:6074:122 with SMTP id
 h16-20020a0561023d9000b0046660740122mr544557vsv.18.1702553645344; Thu, 14 Dec
 2023 03:34:05 -0800 (PST)
MIME-Version: 1.0
References: <20231214092958.377061-1-ojeda@kernel.org>
In-Reply-To: <20231214092958.377061-1-ojeda@kernel.org>
From:   Alice Ryhl <aliceryhl@google.com>
Date:   Thu, 14 Dec 2023 12:33:54 +0100
Message-ID: <CAH5fLggnkWAVBmmeSk-DAbkLQU9QTApE_CqsMxiVm1z=h+uhYQ@mail.gmail.com>
Subject: Re: [PATCH] rust: upgrade to Rust 1.74.1
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
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

On Thu, Dec 14, 2023 at 10:30=E2=80=AFAM Miguel Ojeda <ojeda@kernel.org> wr=
ote:
>
> This is the next upgrade to the Rust toolchain, from 1.73.0 to 1.74.1
> (i.e. the latest) [1].
>
> See the upgrade policy [2] and the comments on the first upgrade in
> commit 3ed03f4da06e ("rust: upgrade to Rust 1.68.2").
>
> [...]
>
> Link: https://github.com/rust-lang/rust/blob/stable/RELEASES.md#version-1=
741-2023-12-07 [1]
> Link: https://rust-for-linux.com/rust-version-policy [2]
> Link: https://github.com/Rust-for-Linux/linux/issues/2 [3]
> Link: https://github.com/rust-lang/rust/pull/114201 [4]
> Link: https://github.com/rust-lang/rust-clippy/issues/11219 [5]
> Link: https://github.com/rust-lang/rust-clippy/issues/11431 [6]
> Link: https://github.com/rust-lang/rust/issues/117976#issuecomment-182222=
5691 [7]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
