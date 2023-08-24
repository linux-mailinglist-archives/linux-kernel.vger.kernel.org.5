Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C65CE786558
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 04:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239464AbjHXC3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 22:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234511AbjHXC3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 22:29:16 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 007A21AD;
        Wed, 23 Aug 2023 19:29:12 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1bbc87ded50so42882335ad.1;
        Wed, 23 Aug 2023 19:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692844152; x=1693448952;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zKCXhB2d9eEsIabhRkYFGz83DNRkbGFKkcNsgtOAWX4=;
        b=ffn7fTgO+vYmAGFEXgt8aPjndNN4bdpbtFiNTdc6aWN6ml2+aCOQXSZGX59R5hYrO2
         /RJphiz+Po1O/vVKcqrH2acU/cwlfbiT22E+QT2+q/p2hNZoW7oTfBPSnvKe5STxP/Rx
         KzXLR3QZJfvX7nRfz22pFhc6nvH2RXPvNARUSZUIjy54XOgKIzgDF/W1pxbcVp69T2M/
         eSDNTrlpJOsyCm8Imqnk/PPO/aiRHnWZA8Lb22F3gd6fm/s8iZ7GZmc6fSZBgHqoheYA
         Fc2A+11G8hO/h8B1yZb8otIy258fw45MJp94p3WS5E2KFZHCwPv7874VghCoBL+NgusO
         ZLzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692844152; x=1693448952;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zKCXhB2d9eEsIabhRkYFGz83DNRkbGFKkcNsgtOAWX4=;
        b=HWhNeRHVTCIVOWTZ8HO0/pISidsvylTbaYmHF7hLwnP1+my9AlQOeSb0FI7q/87YHa
         /x8dzeSe8xFNdDbjgmV17DJwgTj8WSrqWGKpUA0lJPYT8jp9+Cj1zNKXWQqMWMZ6utF0
         5I1XT2BvsbR6hLLj1Eiclczi1xJoWkjfqKSqRzuujlmcgDZIlX+ZhZPfXDFjB2B2Q4oF
         E8k1e1fI4qCDi86aEdhSdhQjqZapv0oEteuewnPxr1imcwWIbFYtfiwvEabrf/d+fxQQ
         fNPX5mRhoxvHXlZwkEd/1+jTx0rX85lBtjkBVhZ5OYrMgOoNh68XVyxgfhkyhK8G2EGB
         bJpQ==
X-Gm-Message-State: AOJu0Yx0qmcl756c80eVxnbLSMfpnBt6gW8Hlr5PNjFjwM2vcv68qh2E
        B7xpGwNP9AHR0mgAK79C9KA=
X-Google-Smtp-Source: AGHT+IEgoVqccPkY6NNtb9xdY3HJrJDVSmeLCx3iVcKjBL6dZsYoK+YU+LymbLU204An74vBUJLA6g==
X-Received: by 2002:a17:902:d507:b0:1bf:3c10:1d70 with SMTP id b7-20020a170902d50700b001bf3c101d70mr13711414plg.6.1692844152344;
        Wed, 23 Aug 2023 19:29:12 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id kx14-20020a170902f94e00b001b567bbe82dsm11568484plb.150.2023.08.23.19.29.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Aug 2023 19:29:12 -0700 (PDT)
Message-ID: <db8c6795-0632-4288-98a9-d22e50c689ac@gmail.com>
Date:   Wed, 23 Aug 2023 23:28:34 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] rust: upgrade to Rust 1.72.0
Content-Language: en-US
To:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>
Cc:     Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Jonathan Corbet <corbet@lwn.net>,
        workflows@vger.kernel.org, linux-doc@vger.kernel.org
References: <20230823160244.188033-1-ojeda@kernel.org>
 <20230823160244.188033-3-ojeda@kernel.org>
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20230823160244.188033-3-ojeda@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/23/23 13:02, Miguel Ojeda wrote:
> This is the second upgrade to the Rust toolchain, from 1.71.1 to 1.72.0
> (i.e. the latest) [1].
> 
> See the upgrade policy [2] and the comments on the first upgrade in
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
> Please see [3] for details.
> 
> # Other improvements
> 
> Previously, the compiler could incorrectly generate a `.eh_frame`
> section under `-Cpanic=abort`. We were hitting this bug in our
> old `rust` branch [4]. Gary fixed the issue in Rust 1.72.0 [5].
> 
> # Required changes
> 
> For the upgrade, the following changes are required:
> 
>    - A call to `Box::from_raw` in `rust/kernel/sync/arc.rs` now requires
>      an explicit `drop()` call. See previous patch for details.
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
>      # Get the difference with respect to the old version.
>      git -C rust checkout $(linux/scripts/min-tool-version.sh rustc)
>      git -C linux ls-tree -r --name-only HEAD -- rust/alloc |
>          cut -d/ -f3- |
>          grep -Fv README.md |
>          xargs -IPATH cp rust/library/alloc/src/PATH linux/rust/alloc/PATH
>      git -C linux diff --patch-with-stat --summary -R > old.patch
>      git -C linux restore rust/alloc
> 
>      # Apply this patch.
>      git -C linux am rust-upgrade.patch
> 
>      # Get the difference with respect to the new version.
>      git -C rust checkout $(linux/scripts/min-tool-version.sh rustc)
>      git -C linux ls-tree -r --name-only HEAD -- rust/alloc |
>          cut -d/ -f3- |
>          grep -Fv README.md |
>          xargs -IPATH cp rust/library/alloc/src/PATH linux/rust/alloc/PATH
>      git -C linux diff --patch-with-stat --summary -R > new.patch
>      git -C linux restore rust/alloc
> 
> Now one may check the `new.patch` to take a look at the additions (first
> approach) or at the difference between those two patches (second
> approach). For the latter, a side-by-side tool is recommended.
> 
> Link: https://github.com/rust-lang/rust/blob/stable/RELEASES.md#version-1720-2023-08-24 [1]
> Link: https://rust-for-linux.com/rust-version-policy [2]
> Link: https://github.com/Rust-for-Linux/linux/issues/2 [3]
> Closes: https://github.com/Rust-for-Linux/linux/issues/1012 [4]
> Link: https://github.com/rust-lang/rust/pull/112403 [5]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
> [...]
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
