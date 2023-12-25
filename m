Return-Path: <linux-kernel+bounces-11122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 238FA81E19A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 17:41:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A0B61C212A4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 16:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887A61EB5B;
	Mon, 25 Dec 2023 16:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oz46Xtnx"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4C11DFDA;
	Mon, 25 Dec 2023 16:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2ccabfd9762so22417471fa.1;
        Mon, 25 Dec 2023 08:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703522450; x=1704127250; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fyrs7Ll9Q+iAmpgy0m3tgYOMDYlC9HxJOdfyP/9chm8=;
        b=Oz46XtnxUoLruKjO92nA4e7aj5lpEZc2C3RSIW/uSwBpbS3H3Lo9yq8lHamy2N1yGY
         w61/fCXmvIY5hzkzjO3mxQ1GsoX0u6mEVLyzrgHcLCFrnCkSFolwzSnoJEiiX/hhfgT+
         BERtI7RyWtGvHyTlS+TOVZlhOdM4fis7OFhpNaZuN0r1Dq/P1DCAd5gHuMTfGUGKU7Qo
         XbPa1dVJv2SOPkj7yisC8Dbt1yHUArsg9xkQUVS2Cwjf3m6FJNoA3fXDq4FVlpOlveKN
         D3bqaU9ILGfVxNS0Ng6zN0CLbx5wGKZboohCT425FPcWRJX8jyvY3KlAYQwrgqzT2PTg
         CPBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703522450; x=1704127250;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fyrs7Ll9Q+iAmpgy0m3tgYOMDYlC9HxJOdfyP/9chm8=;
        b=DmJzCmYOQfmXoTqIWF+HMy+nJA8VyD0vZzI0hpbRqlfxYTAcCl5TiMr+AmE3wJXviz
         U+GlrURqeJQwRwSKH464E/fVVTUv0rGbuWFYvbeO9HG3GgMjSamaSchiVhB4O7DY8KxH
         5/cBcrjWd46BxIOHZqxm1dYT9l5s1QWZtOaMLpY5B8SxySvB8ccdb6cTPb+7/a6Dv+vk
         xqJKumlb9Yu7wTKABBCFg7NFzu6hPwcXu+zvHjqwh/DtTjjOg3LIqY+6YKsA0J6dZ/m9
         OPN4U4Sp/aozYg/b7Dr6TPGbEo6RDJROY/mKWOYtvSBF71FR2GqX0+fSt2876S3Q0vQ/
         8N8Q==
X-Gm-Message-State: AOJu0YzEZty0BxYcKvtVo6SW6cvmpj9Ho+NUGMAdHxt+iTTJ8xXW35sz
	CRPTUbHtICCPniuRrNZUurCYD5xI1CRR3dFqSvo=
X-Google-Smtp-Source: AGHT+IEEhAZtmtduwuOGDbra3s0u0PIh9UM9Ey7Xgh800PGovD5L2RU6Qk1YDYxCcp5ownM2AxWmguWNYO2n212nc5M=
X-Received: by 2002:a2e:8742:0:b0:2cc:7a8e:1846 with SMTP id
 q2-20020a2e8742000000b002cc7a8e1846mr3167817ljj.17.1703522449790; Mon, 25 Dec
 2023 08:40:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231224172128.271447-1-ojeda@kernel.org>
In-Reply-To: <20231224172128.271447-1-ojeda@kernel.org>
From: Vincenzo Palazzo <vincenzopalazzodev@gmail.com>
Date: Mon, 25 Dec 2023 17:40:36 +0100
Message-ID: <CAKy8djQQaR9WGv1gon49QBVGMZmg-9o75EDan0q4ohgKonnFpQ@mail.gmail.com>
Subject: Re: [PATCH] rust: upgrade to Rust 1.75.0
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Wedson Almeida Filho <wedsonaf@gmail.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

   Vincent.


On Sun, Dec 24, 2023 at 6:22=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
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
750-2023-12-28 [1]
> Link: https://rust-for-linux.com/rust-version-policy [2]
> Link: https://github.com/rust-lang/rust/issues/91850 [3]
> Link: https://github.com/Rust-for-Linux/linux/issues/2 [4]
> Link: https://github.com/rust-lang/rust/issues/96283 [5]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---


Reviewed-by: Vincenzo Palazzo <vincenzopalazzodev@gmail.com>

