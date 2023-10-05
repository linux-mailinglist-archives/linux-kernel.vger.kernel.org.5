Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6EFC7BAC15
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 23:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbjJEVax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 17:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231722AbjJEVat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 17:30:49 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D287495;
        Thu,  5 Oct 2023 14:30:47 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1c61bde0b4bso12081785ad.3;
        Thu, 05 Oct 2023 14:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696541447; x=1697146247; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eEZ6HGHY7M39jHS8HQsMgoR34dJ/9xEfGiox94C3KTE=;
        b=IByvvbL4w91DZXPVd8WXRcz9EG2WizQdpa07B17CkeWSSVR5eUMDvNJbRv3ybrLKEU
         /Wu6naF5Ln4+T5jvuN5YC5Q5+rBWKHAxZ9ic/3Y8EDd+wjXXURiKSQvp7sxdjgmN6B6g
         by8WolHyy+LqmckpwgIxYPX9O+u317DvkQwe0EAXgy583PnvubnwR9ptF3iS+IVBZ1RH
         PB2OvbJv4TzbG0qSqzlvVR7ksubQ4iNSnkEx5pVjnPL9UhYMO6smmhFL/C5B86soSOL/
         bWEpx7rO3tNnFYPsALXjBEV4JxDBExYYrtxLFNZyKJw6qFrAdMWFTr9l6hreqtqmHTZu
         7aFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696541447; x=1697146247;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eEZ6HGHY7M39jHS8HQsMgoR34dJ/9xEfGiox94C3KTE=;
        b=qHdwun21qPivFcdUiwiBVZX2aZ4DAkWjZLA66lp3AhInRsOFnjkDso0erpjB6AszJj
         AdHhRDVDdKORqyHRhEH2SyTgtk1XMXsw0fINTKui6ul4o9codshlD9kamM6Cd6JR/FNB
         6SwtrcaqGmu4yc16KiwS9cdTP8zD51xUHUrdRKsnzfRqk3x6bmYp/sqkT7i0ikiMo6nq
         ofAo668OSkqhDeh6XxWdekg9m+LU1KVvFBbL9fefClZ7cdtHYcgmdq84pvGBteFWzb09
         LHwY+9++HqDfInzTuk4YNxZoj2LFNwh27pb+Y9qlI07SFdmWsHhLZ3dU+/wJfTq44qmd
         NrcA==
X-Gm-Message-State: AOJu0Ywd7txs49jwSuvml8jW3p1r6+dP9AVae+G6bJStYf1sqiDmn1k9
        ZAAo+37xisSp64otYB2HZ/c=
X-Google-Smtp-Source: AGHT+IEAAKJOemdFQh6i8JbzDMBhV0u3VP1X20yG7F/HYr2B1uqkkb3aY/7Qb20W548P94yx10rOFQ==
X-Received: by 2002:a17:902:e84a:b0:1c2:218c:3754 with SMTP id t10-20020a170902e84a00b001c2218c3754mr7419410plg.53.1696541447132;
        Thu, 05 Oct 2023 14:30:47 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id l7-20020a170903244700b001b8a00d4f7asm2230148pls.9.2023.10.05.14.30.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Oct 2023 14:30:46 -0700 (PDT)
Message-ID: <7a98dc62-924c-4b6a-844d-d6db2b9e5a3b@gmail.com>
Date:   Thu, 5 Oct 2023 18:30:21 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] rust: upgrade to Rust 1.73.0
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
References: <20231005210556.466856-1-ojeda@kernel.org>
 <20231005210556.466856-4-ojeda@kernel.org>
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20231005210556.466856-4-ojeda@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/5/23 18:05, Miguel Ojeda wrote:
> This is the next upgrade to the Rust toolchain, from 1.72.1 to 1.73.0
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
> # Required changes
> 
> For the upgrade, the following changes are required:
> 
>    - Allow `internal_features` for `feature(compiler_builtins)` since
>      now Rust warns about using internal compiler and standard library
>      features (similar to how it also warns about incomplete ones) [4].
> 
>    - A cleanup for a documentation link thanks to a new `rustdoc` lint.
>      See previous commits for details.
> 
>    - A need to make an intra-doc link to a macro explicit, due to a
>      change in behavior in `rustdoc`. See previous commits for details.
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
> Link: https://github.com/rust-lang/rust/blob/stable/RELEASES.md#version-1730-2023-10-05 [1]
> Link: https://rust-for-linux.com/rust-version-policy [2]
> Link: https://github.com/Rust-for-Linux/linux/issues/2 [3]
> Link: https://github.com/rust-lang/compiler-team/issues/596 [4]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
> [...]
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
