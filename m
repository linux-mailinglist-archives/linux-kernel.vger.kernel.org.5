Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E16B67BD59E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 10:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345543AbjJIIuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 04:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345404AbjJIIt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 04:49:59 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EEF9A3;
        Mon,  9 Oct 2023 01:49:55 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2bffc55af02so50227961fa.2;
        Mon, 09 Oct 2023 01:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696841393; x=1697446193; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jo6aI4gZvvCpMFiUGs+gs/M6BlZphmb01wWlOsiDfrc=;
        b=H2Bj2kSvgKP+CH3itFfqGsifKd06Vlmx1nCBRu+7c+3Br85nA77Uf8YcuQK0UC/qGu
         /e1QfT2Go0qUee74IIhFCxouEAXf41nOLfFDihSq6o/XUPn/v2GiZWQ0nfSG9d7qRsPz
         c+QAZNWIK/Ly+DIAWmmsE5SPvVIVXu/6INOXB/yG55/E3436sYuQXT4QQkwHfIdDvke2
         To9BKT6cQs/TvBDswoCX07gf6HTkRHrlpm4AWEClcdb3NCNPUm/hKlykilXfEq2rZPV7
         xCSRuBFw7P2LcClYDTe2C9wIsoAxWulvsYK6Bn1q/eBUdXqWDAS1Ki/TLHFRQws2qiip
         h/PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696841393; x=1697446193;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jo6aI4gZvvCpMFiUGs+gs/M6BlZphmb01wWlOsiDfrc=;
        b=m9EiB/RyXD/WA6llk3bwahLQE9BX6OkxPtEtpLMv3pLP3VYpzfNwKpAUZpJwDh6pDj
         n6KoDZr+ENLg4Rhd/b1IL/pg3pGWAqdBXzx8KYTjCP4SPh2+ss9+BMMcd/8xbIHpuVwG
         7xXGJuvesIfC+3JZxIKfg69bD8O90d8h2o5HIhVETdSDNe1cA0rQl8/HnivgG/MmN6jc
         Vz2VvFwL276/ROFXin1tv5/t9UuJfxjvrsxCK2RvTw7YxMNAzLVXz2pszWVP872e2dtu
         Az2raftOEfcBJObTV0b4VIbyZVFKCY6KDT1ZVBRyf590KkBvgGer3txIhwC1JJknEAeV
         4XYw==
X-Gm-Message-State: AOJu0YxhuiDZnLDD5NGqbwqK2cLLPiPtMgE8l+V58UvxizY5c61+03Xo
        BbhtdWTNYjMReVifVfzf7LQ=
X-Google-Smtp-Source: AGHT+IH1y1lLyCexGC0VNVkJhwZly2dg4RHXFhz+DgANrRNwfMwSA+OcjLwrQHPclRFcs+DB3BPN1g==
X-Received: by 2002:a2e:97d2:0:b0:2bc:ed75:1ba with SMTP id m18-20020a2e97d2000000b002bced7501bamr12695953ljj.16.1696841393368;
        Mon, 09 Oct 2023 01:49:53 -0700 (PDT)
Received: from localhost ([146.70.182.19])
        by smtp.gmail.com with ESMTPSA id u4-20020a2e9f04000000b002bcd94f9714sm1947547ljk.126.2023.10.09.01.49.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Oct 2023 01:49:53 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 09 Oct 2023 10:49:51 +0200
Message-Id: <CW3S2LWWUVG7.2STK9HS3VBQFR@gmail.com>
Cc:     "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
        =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        "Benno Lossin" <benno.lossin@proton.me>,
        "Andreas Hindborg" <a.hindborg@samsung.com>,
        "Alice Ryhl" <aliceryhl@google.com>,
        <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@lists.linux.dev>, "Jonathan Corbet" <corbet@lwn.net>,
        <workflows@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: Re: [PATCH 3/3] rust: upgrade to Rust 1.73.0
From:   "Vincenzo Palazzo" <vincenzopalazzodev@gmail.com>
To:     "Miguel Ojeda" <ojeda@kernel.org>,
        "Wedson Almeida Filho" <wedsonaf@gmail.com>,
        "Alex Gaynor" <alex.gaynor@gmail.com>
X-Mailer: aerc 0.15.2-211-g37d5fc691aff
References: <20231005210556.466856-1-ojeda@kernel.org>
 <20231005210556.466856-4-ojeda@kernel.org>
In-Reply-To: <20231005210556.466856-4-ojeda@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The vast majority of changes are due to our `alloc` fork being upgraded
> at once.

Ah this is annoying sometimes :/

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
> Link: https://github.com/rust-lang/rust/blob/stable/RELEASES.md#version-1=
730-2023-10-05 [1]
> Link: https://rust-for-linux.com/rust-version-policy [2]
> Link: https://github.com/Rust-for-Linux/linux/issues/2 [3]
> Link: https://github.com/rust-lang/compiler-team/issues/596 [4]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
>  Documentation/process/changes.rst |  2 +-
>  rust/alloc/alloc.rs               | 22 --------------
>  rust/alloc/boxed.rs               | 48 ++++++++++++++++++++-----------
>  rust/alloc/lib.rs                 |  5 ++--
>  rust/alloc/raw_vec.rs             | 30 ++++++++++++-------
>  rust/alloc/vec/mod.rs             |  4 +--
>  rust/alloc/vec/spec_extend.rs     |  8 +++---
>  rust/compiler_builtins.rs         |  1 +
>  scripts/min-tool-version.sh       |  2 +-
>  9 files changed, 63 insertions(+), 59 deletions(-)
>
> diff --git a/Documentation/process/changes.rst b/Documentation/process/ch=
anges.rst
> index 731cc104c56f..bb96ca0f774b 100644
> --- a/Documentation/process/changes.rst

Reviewed-by: Vincenzo Palazzo <vincenzopalazzodev@gmail.com>
