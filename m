Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6C3813215
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 14:49:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573230AbjLNNtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 08:49:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573102AbjLNNtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 08:49:09 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F1911B;
        Thu, 14 Dec 2023 05:49:11 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-28aeacb2dfdso1094707a91.0;
        Thu, 14 Dec 2023 05:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702561751; x=1703166551; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UTgQg5ey7t1gN8vRT5vRqf8veCr45WdokAmFaMYA3+E=;
        b=HpsGmDfrQAXXmLmF9+MyM7P4KI+VmntHmtvpA30TrA9z0xVFctdQBL4guem5MSi3Sr
         DXKuDBrozlZ4sqrbgh0qnjA607aWRymYy6cf9/g17D03IKoFDfX8O+AEejnXHToMtTI1
         DZTUm/uJFy78YrFx+U1FJ+mICE7iDEICCtM/4NKnmlc93TRfbdEx5XrsgKgV20Nwjuw5
         OznfTF7lFNZIgQjmPm2UhzS5Q+Xw5MKqGmka7X9N9l6OOXUndBJxasnINDvzZACbEjyO
         NTneZz6ByIE0uQLTJXs5l9wiFN8KVTKNs1LgDUfWxAR0xduYtXye0W0/NzXeOJhUiXMt
         cOMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702561751; x=1703166551;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UTgQg5ey7t1gN8vRT5vRqf8veCr45WdokAmFaMYA3+E=;
        b=YhtBMC4MgFf45VwK46w5pA35H0GebnqJxGtnt9vfPOzPzZAd3RqJHp4iefqMt6PUJo
         fiY9qMG/IOZUNkCSTUS+dtSNYAfD0nxNlW1l4U9ytZsrSy4x0OfSUTcOPmHD47i7JApb
         KzHc+2LWm9OFE4HlBPe05Xf2WoBUfO7HaeT+HfbZIjibA7bYB+N2qFeS+NmIi1mi5xOh
         jFRHOgcTYscB4vlqYNPg1jCQQYRyQVnXfxqMjsuisyMiwA9mRRMi76dsnQkZIYs+aa18
         rkSOJ7IfUVZcAV5QmBnhKhtgrngar2ClrxkcFH8n9JQGPHPyMyLcLUenfPX967DJ4S/Z
         Ur1Q==
X-Gm-Message-State: AOJu0YzXE34HyXZBpRm8I0+Q9075xo71InZdyKkErjQFe10YXXpP3BlE
        3cCwFaTXhXatJj6A0SII+FE=
X-Google-Smtp-Source: AGHT+IEv3GGnQfkJxzqP9Db4Qf3Fpn/fdX4KnRYiGqn+0eH/2LWeqGdMECO7teg0UArVZGBkQXHQ3Q==
X-Received: by 2002:a17:90a:a10f:b0:28b:201f:c2be with SMTP id s15-20020a17090aa10f00b0028b201fc2bemr63542pjp.62.1702561750754;
        Thu, 14 Dec 2023 05:49:10 -0800 (PST)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id q2-20020a17090a430200b0028a4c85a55csm10995876pjg.27.2023.12.14.05.49.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Dec 2023 05:49:10 -0800 (PST)
Message-ID: <29100969-106a-47c1-bfe3-6e2ca38c8c54@gmail.com>
Date:   Thu, 14 Dec 2023 10:49:05 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rust: upgrade to Rust 1.74.1
To:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>
Cc:     Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
References: <20231214092958.377061-1-ojeda@kernel.org>
Content-Language: en-US
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20231214092958.377061-1-ojeda@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/14/23 06:29, Miguel Ojeda wrote:
> This is the next upgrade to the Rust toolchain, from 1.73.0 to 1.74.1
> (i.e. the latest) [1].
> 
> See the upgrade policy [2] and the comments on the first upgrade in
> commit 3ed03f4da06e ("rust: upgrade to Rust 1.68.2").
> 
> # Unstable features
> 
> No unstable features (that we use) were stabilized.
> 
> Therefore, the only unstable features allowed to be used outside the
> `kernel` crate are still `new_uninit,offset_of`, though other code to
> be upstreamed may increase the list (e.g. `offset_of` was added recently).
> 
> Please see [3] for details.
> 
> # Other improvements
> 
> Rust 1.74.0 allows to use `#[repr(Rust)]` explicitly [4], which can be
> useful to be explicit about particular cases that would normally use
> e.g. the C representation, such as silencing lints like the upcoming
> additions we requested [5] to the `no_mangle_with_rust_abi` Clippy lint
> (which in turn triggered the `#[repr(Rust)]` addition).
> 
> Rust 1.74.0 includes a fix for one of the false negative cases we reported
> in Clippy's `disallowed_macros` lint [6] that we would like to use in
> the future.
> 
> Rust 1.74.1 fixes an ICE that the Apple AGX GPU driver was hitting [7].
> 
> # Required changes
> 
> For this upgrade, no changes were required (i.e. on our side).
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
> Link: https://github.com/rust-lang/rust/blob/stable/RELEASES.md#version-1741-2023-12-07 [1]
> Link: https://rust-for-linux.com/rust-version-policy [2]
> Link: https://github.com/Rust-for-Linux/linux/issues/2 [3]
> Link: https://github.com/rust-lang/rust/pull/114201 [4]
> Link: https://github.com/rust-lang/rust-clippy/issues/11219 [5]
> Link: https://github.com/rust-lang/rust-clippy/issues/11431 [6]
> Link: https://github.com/rust-lang/rust/issues/117976#issuecomment-1822225691 [7]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
> [...]
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
