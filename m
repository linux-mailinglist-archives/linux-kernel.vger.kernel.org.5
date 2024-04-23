Return-Path: <linux-kernel+bounces-154362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D94328ADB3C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 02:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10FD51C21139
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 00:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F078A15E89;
	Tue, 23 Apr 2024 00:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TCsoTKTh"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595DF14AB2;
	Tue, 23 Apr 2024 00:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713833029; cv=none; b=YxhU0AkbTbDpRvFjNMUjBuD9wTXJnEelLxW5mEzZAE0oliTCXZzj+VbFMcyTUxD5EVRWg7bh0liPOG9HC1On1k4Yb+teBYxoT5zT183hkPjbSNGDrcF/MmKhYUuf9dIpzDEPLhpAOu5m4XfGAvR7LzcVxIPoqZcWk+BP++ZQsoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713833029; c=relaxed/simple;
	bh=VFbAJUhcP0KMuDkHhwe98YCuNuSDX2maSRVfItJn72U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Znx5u7QDQfyuw/R38rvi5Uc1+51SSkqOPP+b3Sxd24fQV6/YEiar3OduLR/5iAV++j6Mvpn32WLwitOkdH8qyeSn9yLhQtpyRGqIXrz+lCoRItGs7HuGgBt/fNkRoXNy36ueS5F0jFPp/tT/GAWR6KQE8XUuuX9V9m5pSgcS/+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TCsoTKTh; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2a7e19c440dso3519536a91.3;
        Mon, 22 Apr 2024 17:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713833026; x=1714437826; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y0vJ15HzyjugMAhNTAU3HivHhRTp3jhrffXYIhcyc1o=;
        b=TCsoTKThR0ePlUR7oq/HHjN8PMuIAsjrFjVBDRDYFthanXypThIuxtKESvB5U8sIVz
         GTL3n92czp/AV6bKemPu17qc+birgd1n0x5ocu3FRxDuol6xPumpjBA+89U+VSv1WOM9
         kt6mkSmvtazHayGrWzG8MiXRQMtyzX/TO/aU5HhgqzAZAXbsmFKpGezlJzI7IRqv7oJV
         tw3AxqWrhhj6jDfflLcsvb5rWR6hUEMFuOYe3UXYAYb6oISNyDllB27YOaXT0xgs1i9j
         oiM4G8AQ4nkLl7e6p/XZ/D6AfBP2c6EINIb1lriBbJcfnXAq5/iRVeQtOn3IanJzI6KZ
         T8ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713833026; x=1714437826;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y0vJ15HzyjugMAhNTAU3HivHhRTp3jhrffXYIhcyc1o=;
        b=cps5FrcZNr3n5an9xsoc7TndSRsDpbdYI8vCSWENSDtBdSGNxHpefRJWMM5qe/Spj3
         DNutUNtaJGJp0RKKe3bngLb6AeoZuzYErpwxfvxJuFmz8jwyBWbpB+Dqs0r+o7bNEqUn
         3sDyzR6Co3VH8wpZswkIlufIOMgBDlaiZJvUeSVrKYiR7T6Us77l5jnmTLSUmAudW4D/
         aRUVq3YQzg0M/Fkb+Wuh3RegloR6DDqkd5VRW2/gPyzde0nGmQsPsx06oiR5u6Vc/f7J
         unJaCQyPUELhP0n+ESqiaOYkbw82U4AChMyytb5bFuTj7qOTB/xCPvZApCJval2ysBHq
         a2pA==
X-Forwarded-Encrypted: i=1; AJvYcCWw7DeBt5gtFhw3JmSxvzZa2QdtTcgi69tmcVOrzysYlSAUG+3+cEWOSuWfNj8o0FYQWc4Mul89iPFWwGvBH2pIaQ+XlIo5QFEt8t6e//ynxsT6sliBghBrLj7v9Db7RqF+bxevc8tsy/UwuwahzxQmavR1BIjq2nPqutiwcSQnuYdWt7crOJbNgTRbfO6bUwYMaKbKfuiUCTcwOmhmkAR4l6I=
X-Gm-Message-State: AOJu0YxYGYaoSF2sAS+qqL3NXJ7uj48iGJ33sKIAc7G+uO1uQYGBQ+w7
	cWfXh+bA7g6GQ1em/uADhJb3Kqjg8/hdFCaz694F9kKX5lcq3BqPbMETFC8EhFKTDjNx2Mtq1ge
	GegLC9HkvlMl+Ai5M26r3GOBe/aI=
X-Google-Smtp-Source: AGHT+IGLfYyTbl9vYvOYBfXcIXSEXDht3gOfURdaONNde0mhKnSeiXHNUhWNVYDkuOveQ9YnBGixGIsOfEfiKHSuM3Q=
X-Received: by 2002:a17:90a:55cb:b0:2ab:2b1d:7dae with SMTP id
 o11-20020a17090a55cb00b002ab2b1d7daemr8899537pjm.44.1713833026513; Mon, 22
 Apr 2024 17:43:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422090644.525520-1-ojeda@kernel.org>
In-Reply-To: <20240422090644.525520-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 23 Apr 2024 02:42:41 +0200
Message-ID: <CANiq72=7BycaXS-mOpt1V5y8kw+v9yp0dLpdQTZ_KRRnEcwWVA@mail.gmail.com>
Subject: Re: [PATCH] kbuild: rust: force `alloc` extern to allow "empty" Rust files
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Nicolas Schier <nicolas@fjasle.eu>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, linux-kbuild@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev, stable@vger.kernel.org, 
	Daniel Almeida <daniel.almeida@collabora.com>, 
	Julian Stecklina <julian.stecklina@cyberus-technology.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2024 at 11:08=E2=80=AFAM Miguel Ojeda <ojeda@kernel.org> wr=
ote:
>
> If one attempts to build an essentially empty file somewhere in the
> kernel tree, it leads to a build error because the compiler does not
> recognize the `new_uninit` unstable feature:
>
>     error[E0635]: unknown feature `new_uninit`
>      --> <crate attribute>:1:9
>       |
>     1 | feature(new_uninit)
>       |         ^^^^^^^^^^
>
> The reason is that we pass `-Zcrate-attr=3D'feature(new_uninit)'` (togeth=
er
> with `-Zallow-features=3Dnew_uninit`) to let non-`rust/` code use that
> unstable feature.
>
> However, the compiler only recognizes the feature if the `alloc` crate
> is resolved (the feature is an `alloc` one). `--extern alloc`, which we
> pass, is not enough to resolve the crate.
>
> Introducing a reference like `use alloc;` or `extern crate alloc;`
> solves the issue, thus this is not seen in normal files. For instance,
> `use`ing the `kernel` prelude introduces such a reference, since `alloc`
> is used inside.
>
> While normal use of the build system is not impacted by this, it can stil=
l
> be fairly confusing for kernel developers [1], thus use the unstable
> `force` option of `--extern` [2] (added in Rust 1.71 [3]) to force the
> compiler to resolve `alloc`.
>
> This new unstable feature is only needed meanwhile we use the other
> unstable feature, since then we will not need `-Zcrate-attr`.
>
> Cc: stable@vger.kernel.org # v6.6+
> Reported-by: Daniel Almeida <daniel.almeida@collabora.com>
> Reported-by: Julian Stecklina <julian.stecklina@cyberus-technology.de>
> Closes: https://rust-for-linux.zulipchat.com/#narrow/stream/288089-Genera=
l/topic/x/near/424096982 [1]
> Fixes: 2f7ab1267dc9 ("Kbuild: add Rust support")
> Link: https://github.com/rust-lang/rust/issues/111302 [2]
> Link: https://github.com/rust-lang/rust/pull/109421 [3]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Applied to `rust-fixes` early to start getting some testing in -next.
Please feel free to send tags for this one.

Cheers,
Miguel

