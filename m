Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 144C577C398
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 00:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233372AbjHNWlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 18:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233310AbjHNWkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 18:40:55 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD15EAB;
        Mon, 14 Aug 2023 15:40:52 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-d6b1025fc7aso1433888276.3;
        Mon, 14 Aug 2023 15:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692052852; x=1692657652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ST9EDbMOZFXnqi0vd0YF7UvQtOruYHigj9crRoWalvM=;
        b=D7mNCMah/yau6g6kumYNQvMPHpBreLI/ewr1wb8zCKLZASymha+E57jdh0RvNUFNhn
         jCVbDnpGmsO72u42u4H50tSbbuEprScRweO+JhyWz25t9l5lY2uVbj8vGjJCYS6fLClq
         UdWT6ShQfn1DDmkbjfQCqE90OEczjdNvjufEk7KwoMOjqZGp055QnUQbgL3ofEqh3re+
         a6IFwge0eZN3JM3wxKPh2M59Crnio9UM21RmQu85xegsj9wX6v5jdv9Ew8niPypYs0BN
         MIA9a16gxYEBRM4RUTFbt52sj+jImGKpE33SM7zYWQwNhyTNVWoi8eKk72VQR/+At7ll
         6lPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692052852; x=1692657652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ST9EDbMOZFXnqi0vd0YF7UvQtOruYHigj9crRoWalvM=;
        b=k/25ulfFDGELds4dJh7UB5jbABXyRNq3D+SS/BQmnCJivYPSeRhgXmb+sOkeJY0tCU
         TdCUMtLgMeE3PZnrxowtgKGMYqJbWN9o/OQM/5FNdnx9ya6phVaJblphr4Rsom0VsUzB
         +zCLYbhvItvB2Dd/zYw/wntUjQ3OukQ2Q1MsPGf7wbLyi2ltsDBG6HULyjXOIv65slku
         2PnYiXRXwP6ptZdIXgvUBPZnZXDm3JcWs0Ev3ciK/n2eukP0XpNFnQSAMMhqunb18aZG
         kgdiJgr+mIqfBNImlxagBHbHkcFXl1fV/hZVxnmRNIYMrTSLjZNVmgH9vyHn4JmK13ph
         wIPg==
X-Gm-Message-State: AOJu0Yz+KuBl8rEP8x+CYcq24VZBdQ4AK0kziZNpa9y6C7fcjqg9W2LR
        ik9xC3KOk+QTF4/I/RwkY4egoYncbZbuW/1SoA0=
X-Google-Smtp-Source: AGHT+IFBu2vNjExAtBSX0HHSL9CHjFV7NRbjoamH5RTWuOApwfEkFSQnkFsv7Ky9xYSdSsFW0Da05PSwTr9sCVQugVs=
X-Received: by 2002:a5b:24e:0:b0:d0a:353b:b939 with SMTP id
 g14-20020a5b024e000000b00d0a353bb939mr11876763ybp.52.1692052851891; Mon, 14
 Aug 2023 15:40:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230729220317.416771-1-ojeda@kernel.org>
In-Reply-To: <20230729220317.416771-1-ojeda@kernel.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 15 Aug 2023 00:40:40 +0200
Message-ID: <CANiq72mrzALO3J2VvDntscXwt7Z9KzT4+S8sc_HGc8u8izjyLw@mail.gmail.com>
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 30, 2023 at 12:04=E2=80=AFAM Miguel Ojeda <ojeda@kernel.org> wr=
ote:
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

Applied to `rust-next` -- thanks everyone!

As mentioned earlier, I have moved to 1.71.1 instead that got released
meanwhile, since it does not require any changes w.r.t. this one
except the obvious ones and it is likely the one that people would
like to use/have (so less warnings).

Cheers,
Miguel
