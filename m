Return-Path: <linux-kernel+bounces-10810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9629281DC2D
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 20:49:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2329B20FF6
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 19:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D1BDDD3;
	Sun, 24 Dec 2023 19:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OMqfNbqQ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE32FD52C;
	Sun, 24 Dec 2023 19:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-35fea35c432so16440785ab.0;
        Sun, 24 Dec 2023 11:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703447380; x=1704052180; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1a9E1LViCf6D+7FBiOySiyQNCFNcTHBrGbKDaNup/O8=;
        b=OMqfNbqQVGYM70IxJBz3JQjUOXapqmXnKBUHu/Fu3hYyWtmine84VozZMO+biJQwSU
         I6GRLA5lnk2vh/KTSBt7Q8uJVS9Xvm9rMhovH4yA0WdCB6waAPZ6K78J3CiorvQkpTiq
         eKSin3UYT/5DnsJD7Mf6nlwwZBiH9yzvlcSfhDTX/PEXyqlu41qjaW4kSGGS3dq0bAhl
         RHHYnyEz14IKnDdBcZFCjFjMSLQJiO8jIYUelQOtQaVGgvQlWekhe9JZYCadIWB5w4Pd
         kFWDFc+KiZwpYbJ8bBDXCfez+2xia80+57x84jQ1be47CYQQBt/znBN/QsQ9j0+GylmF
         dJ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703447380; x=1704052180;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1a9E1LViCf6D+7FBiOySiyQNCFNcTHBrGbKDaNup/O8=;
        b=GxlpjEbHW9ahmtg/SzEnAzcZosHCcu8goGEaG/wQEOQPPNa21KchnZrLg8heGLg5NU
         UH36uuaUQoU1gMdGL3nhi/8LsJAzI3W7cDN6o0RWAbT1LeMdGlz8nJUw+d/Wqag89MeD
         E2PX+5eD+hZhA2+s8qUcAV2agRuqc72fzBrqtBruBi5sZZvyMUOu/i/VsTNpYiuTCMwR
         NXxZ15wWfG9o3H4pdc7bvyNbvbkVCbPuKAz4jAmh+ZRRnsz5GNFP+HYZRpmAWghw+C1O
         0SPf5EXzuieBindkD9BMgHvrQiUk+wtH+wKIb9TfkOGZ5m7YeZLuUpQLMNEYe9WVPyMO
         CAwA==
X-Gm-Message-State: AOJu0Yw6npmMgRdZu8O+uuYUEPDM76+v4XsrEH7MVYfxH1sLgCyJlHxY
	gY9qm91UwARH0R3UHYevCm7Nvw0wijY=
X-Google-Smtp-Source: AGHT+IGAv75SOEMOaoQf6DNB5iKcUoA67G9VSjxhXvVSr6nViVbqMGDPacmo4DLtXXfQQYdGpQyzSw==
X-Received: by 2002:a05:6e02:1b8e:b0:35f:f1a9:8149 with SMTP id h14-20020a056e021b8e00b0035ff1a98149mr4253511ili.30.1703447379776;
        Sun, 24 Dec 2023 11:49:39 -0800 (PST)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id m25-20020aa78a19000000b006d9b38f2e75sm1310557pfa.32.2023.12.24.11.49.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Dec 2023 11:49:39 -0800 (PST)
Message-ID: <4e5ea975-c423-4878-b368-ad033875fe1a@gmail.com>
Date: Sun, 24 Dec 2023 16:49:34 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rust: upgrade to Rust 1.75.0
To: Miguel Ojeda <ojeda@kernel.org>, Wedson Almeida Filho
 <wedsonaf@gmail.com>, Alex Gaynor <alex.gaynor@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl
 <aliceryhl@google.com>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, patches@lists.linux.dev
References: <20231224172128.271447-1-ojeda@kernel.org>
Content-Language: en-US
From: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20231224172128.271447-1-ojeda@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/24/23 14:21, Miguel Ojeda wrote:
> This is the next upgrade to the Rust toolchain, from 1.74.1 to 1.75.0
> (i.e. the latest) [1].
> 
> See the upgrade policy [2] and the comments on the first upgrade in
> commit 3ed03f4da06e ("rust: upgrade to Rust 1.68.2").
> 
> # Unstable features
> 
> The `const_maybe_uninit_zeroed` unstable feature [3] was stabilized in
> Rust 1.75.0, which we were using in the PHYLIB abstractions.
> 
> The only unstable features allowed to be used outside the `kernel` crate
> are still `new_uninit,offset_of`, though other code to be upstreamed
> may increase the list.
> 
> Please see [4] for details.
> 
> # Other improvements
> 
> Rust 1.75.0 stabilized `pointer_byte_offsets` [5] which we could
> potentially use as an alternative for `ptr_metadata` in the future.
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
> Link: https://github.com/rust-lang/rust/blob/stable/RELEASES.md#version-1750-2023-12-28 [1]
> Link: https://rust-for-linux.com/rust-version-policy [2]
> Link: https://github.com/rust-lang/rust/issues/91850 [3]
> Link: https://github.com/Rust-for-Linux/linux/issues/2 [4]
> Link: https://github.com/rust-lang/rust/issues/96283 [5]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
> [...]

Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>

