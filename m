Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0D476C753
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 09:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233652AbjHBHqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 03:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233451AbjHBHp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 03:45:57 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD2E144B9
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 00:43:29 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-99bd1d0cf2fso984777266b.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 00:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1690962208; x=1691567008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hTlYTUXYUY0uT5dVegExxW34rudjU0yRbAqg9Bg5Z/A=;
        b=jt1i3UyGg5T8VU7eoMf85nHf6pgJoeHFxp53BuGY+DiO76l/fHQrsYT4K/fJuRnm8S
         dVrV+pGSUvLjAqkp3PYAwaLppgWCK35UNVv/OPwqrcST2L5PLWvqp1OODp/KoipUp82s
         uZz82tOu/a1sIslbBKKYqVERgHoB4bXvh+LzeySCN45nzw2PoFcfx5mxgug/LDd9e52Y
         ZHgmGKpJNcQyHY3eddpYCexB8rEhuNvI+ula63l8RraTy1lcP2qhtPEVcgIwTuPSlbcN
         B42wWafgVMfjIK/+22+omr2Qn2GQI6MuK4qBSBPIvIrmK4tUQS4C+AYDh8mGKztFeBd5
         qcPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690962208; x=1691567008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hTlYTUXYUY0uT5dVegExxW34rudjU0yRbAqg9Bg5Z/A=;
        b=g+8bi281FxYPnLhcURtWD9Au7LahkAkSIY/rBebBbTe9Yt9ZdFjQl0XBy5IwEzssZD
         VQDZLKOm04k4yFWOgZjxrdX1GyrpEUbDKVCT8MMzEHzfgcRBcJbUJaMxZWCT7BqF0Hza
         gfLWkIgbFzIWysuSU9D6lZVyrpJ92l2gyVikiyuUB9agqG4eG9Tqdgs+18N9Oy+sV22J
         lHs8JcSgEb4GBCmwix0iGPXIv3RoZdQKMKVlIcVxNgPq9RFBU5eThQCa2QtdVDzgsluO
         3RReGw49vbtUagLgZIyjd65HLz3o2LxkW9YpyyAfuJ9ue6kOFjS1D4O2d1kt7Y9iWhCD
         N7ng==
X-Gm-Message-State: ABy/qLbU7BhgyHQ93Xcmd/KwSshty6XeAwfGdTch3QCpX7WpPNQXfsj0
        0W6jKw80x7qTnRBFM7oACGkL+JUqqcy1sCnAesGSgQ==
X-Google-Smtp-Source: APBJJlGC3J+LrdYwhV48JZyyOU8Gidc+5NZEilh6J5EIEUFvOvEAHlb2kX02GozZtGR1CKxVU4GRFeOHUPskjTJKe/Q=
X-Received: by 2002:a17:907:77ce:b0:992:a9c3:244f with SMTP id
 kz14-20020a17090777ce00b00992a9c3244fmr3991552ejc.4.1690962207821; Wed, 02
 Aug 2023 00:43:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230729220317.416771-1-ojeda@kernel.org>
In-Reply-To: <20230729220317.416771-1-ojeda@kernel.org>
From:   Trevor Gross <tmgross@umich.edu>
Date:   Wed, 2 Aug 2023 03:43:16 -0400
Message-ID: <CALNs47t8cuySRf0nTG2ipn7QSESgd44Z0LwCu6dRSU9kHzsJ8g@mail.gmail.com>
Subject: Re: [PATCH 1/2] rust: upgrade to Rust 1.71.0
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 29, 2023 at 6:05=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> This is the second upgrade to the Rust toolchain, from 1.68.2 to 1.71.0
> (i.e. the latest).
>
> See the upgrade policy [1] and the comments on the first upgrade in
> commit 3ed03f4da06e ("rust: upgrade to Rust 1.68.2").
>
> # Unstable features
>
> No unstable features (that we use) were stabilized.
>
> Therefore, the only unstable feature allowed to be used outside
> the `kernel` crate is still `new_uninit`, though other code to be
> upstreamed may increase the list.
>
> Please see [2] for details.
>
> # Required changes
>
> For the upgrade, this patch requires the following changes:
>
>   - Removal of the `__rust_*` allocator functions, together with
>     the addition of the `__rust_no_alloc_shim_is_unstable` static.
>     See [3] for details.
>
>   - Some more compiler builtins added due to `<f{32,64}>::midpoint()`
>     that got added in Rust 1.71 [4].
>
> # `alloc` upgrade and reviewing
>
> The vast majority of changes are due to our `alloc` fork being upgraded
> at once.
>
> There are two kinds of changes to be aware of: the ones coming from
> upstream, which we should follow as closely as possible, and the updates
> needed in our added fallible APIs to keep them matching the newer
> infallible APIs coming from upstream.
>
> Instead of taking a look at the diff of this patch, an alternative
> approach is reviewing a diff of the changes between upstream `alloc` and
> the kernel's. This allows to easily inspect the kernel additions only,
> especially to check if the fallible methods we already have still match
> the infallible ones in the new version coming from upstream.
>
> Another approach is reviewing the changes introduced in the additions in
> the kernel fork between the two versions. This is useful to spot
> potentially unintended changes to our additions.
>
> To apply these approaches, one may follow steps similar to the following
> to generate a pair of patches that show the differences between upstream
> Rust and the kernel (for the subset of `alloc` we use) before and after
> applying this patch:
>
>     # Get the difference with respect to the old version.
>     git -C rust checkout $(linux/scripts/min-tool-version.sh rustc)
>     git -C linux ls-tree -r --name-only HEAD -- rust/alloc |
>         cut -d/ -f3- |
>         grep -Fv README.md |
>         xargs -IPATH cp rust/library/alloc/src/PATH linux/rust/alloc/PATH
>     git -C linux diff --patch-with-stat --summary -R > old.patch
>     git -C linux restore rust/alloc
>
>     # Apply this patch.
>     git -C linux am rust-upgrade.patch
>
>     # Get the difference with respect to the new version.
>     git -C rust checkout $(linux/scripts/min-tool-version.sh rustc)
>     git -C linux ls-tree -r --name-only HEAD -- rust/alloc |
>         cut -d/ -f3- |
>         grep -Fv README.md |
>         xargs -IPATH cp rust/library/alloc/src/PATH linux/rust/alloc/PATH
>     git -C linux diff --patch-with-stat --summary -R > new.patch
>     git -C linux restore rust/alloc
>
> Now one may check the `new.patch` to take a look at the additions (first
> approach) or at the difference between those two patches (second
> approach). For the latter, a side-by-side tool is recommended.
>
> Link: https://rust-for-linux.com/rust-version-policy [1]
> Link: https://github.com/Rust-for-Linux/linux/issues/2 [2]
> Link: https://github.com/rust-lang/rust/pull/86844 [3]
> Link: https://github.com/rust-lang/rust/pull/92048 [4]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> [...]

Reviewed-by: Trevor Gross <tmgross@umich.edu>

A few highlights since 1.68.2 that may eventually be of use:

- `CStr::is_empty` and `CStr::from_bytes_until_nul` help smooth FFI a bit
- `NonNull::slice_from_raw_parts` for slice pointers
- `AtomicX::as_ptr` makes interop with C more clear (doesn't seem like we
  use these types anywhere yet)
- const `ptr::read` and `ptr::read_unaligned`
- `{Option, Result}::is_some_and`
- `core::cell::OnceCell` one-time initialization
- `repr(C)` enums now use `c_int` rather than always `i32` (no difference f=
or
  currently supported targets)
