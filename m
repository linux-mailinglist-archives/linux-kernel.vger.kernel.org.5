Return-Path: <linux-kernel+bounces-16843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D5BDD8244D1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 16:18:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78818B211B3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 15:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003CA241EF;
	Thu,  4 Jan 2024 15:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rCAJ3Bvk"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0465B2376E
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 15:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6dc02727c62so327783a34.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 07:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704381491; x=1704986291; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nZwnS2Sp7vv2PRnAVDjhBATPiqXuD/DhpKZdALVjptM=;
        b=rCAJ3BvkuCa7svBTTM856xsJPAk0VrRSewLOS76ssEEYFUMLkOQKxTAhEfU/q4F9nx
         P1hlyurUeuklxdcXm1cr+3xtujrxNuKtkXt6qrqTeKFc9NBlPGEQOIhrXh0Oc3Xj7NOc
         YqZEqqfqfVjgQnkwQERoXncM31CR/OPaiQThbiLF0VOx/n+YdoZ2UDpOOFVz2PwDWswD
         g4JwxUNMwTxZXt0LiJeehubl4+x01WCUckMz97O+d3Ft02NeEzIAgZVNv6y4x4JnUGlS
         /VcwPGI1LxQJZF3u2cZwTwyf/GKqX6rMz53BQBvD1diyBkrkUqElCd1mayDsfh6DgM4c
         U51w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704381491; x=1704986291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nZwnS2Sp7vv2PRnAVDjhBATPiqXuD/DhpKZdALVjptM=;
        b=mRwN/LaWLsMGQo6/bx/xy24KH6IucBjRgFOoO0vTlGnFcxiTpOL2P0pDgGYrSIQyqS
         ae0w+nz73WaMwmdTE7ATDN+b/Ihcj/TDSKQmEKZ+/iRBnF5dk23QQkcc3VkqYTZtlx/E
         za86OJ41edNX2ccaPk85QKoMAenAxbvo/dsmbGvOAfhcYJgDtzpDb4p3fljsimSpKGvv
         SLuCZhKF9nfG7fohYdSJCxYf/hAYeRNYc96hx7cA+6ACdv9tVyTz7bffuAGOYQiL1j+F
         4F7GM9AUNj4FkwMib5oydfc32ql96RzDucrOztSbG0xIsKbpYkigzvp48fplR7w0Xeuk
         1LJw==
X-Gm-Message-State: AOJu0YwHdGfipshoKneDIWdQZZJJ7hn4NY+WGm5dszv+IbH/T5tTqf+i
	NtDTxtl1XY00ThPsKcDrcGWSxKNK0NxgvOOGTni5/XGkEK6X
X-Google-Smtp-Source: AGHT+IGfMPGT98T1eBmmQHiBufvEQT/Hgt8TdGqVsNK+ddk26PvAtema7RxLe/wukaMT3IVYTmHVvLe6wRZS15AVPsY=
X-Received: by 2002:a05:6871:4e46:b0:1fa:f508:b5cc with SMTP id
 uj6-20020a0568714e4600b001faf508b5ccmr722750oab.55.1704381490990; Thu, 04 Jan
 2024 07:18:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231213220447.3613500-1-benno.lossin@proton.me>
In-Reply-To: <20231213220447.3613500-1-benno.lossin@proton.me>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 4 Jan 2024 16:17:59 +0100
Message-ID: <CAH5fLghY3o5keT3UGUd0h1eb1WXT98BVYsrOpwpvAKq=7NVsXQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] rust: macros: add `decl_generics` to `parse_generics()`
To: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Sumera Priyadarsini <sylphrenadin@gmail.com>, 
	Vincenzo Palazzo <vincenzopalazzodev@gmail.com>, Asahi Lina <lina@asahilina.net>, 
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 11:08=E2=80=AFPM Benno Lossin <benno.lossin@proton.=
me> wrote:
>
> The generic parameters on a type definition can specify default values.
> Currently `parse_generics()` cannot handle this though. For example when
> parsing the following generics:
>
>     <T: Clone, const N: usize =3D 0>
>
> The `impl_generics` will be set to `T: Clone, const N: usize =3D 0` and
> `ty_generics` will be set to `T, N`. Now using the `impl_generics` on an
> impl block:
>
>     impl<$($impl_generics)*> Foo {}
>
> will result in invalid Rust code, because default values are only
> available on type definitions.
>
> Therefore add parsing support for generic parameter default values using
> a new kind of generics called `decl_generics` and change the old
> behavior of `impl_generics` to not contain the generic parameter default
> values.
>
> Now `Generics` has three fields:
> - `impl_generics`: the generics with bounds
>   (e.g. `T: Clone, const N: usize`)
> - `decl_generics`: the generics with bounds and default values
>   (e.g. `T: Clone, const N: usize =3D 0`)
> - `ty_generics`:  contains the generics without bounds and without
>   default values (e.g. `T, N`)
>
> `impl_generics` is designed to be used on `impl<$impl_generics>`,
> `decl_generics` for the type definition, so `struct Foo<$decl_generics>`
> and `ty_generics` whenever you use the type, so `Foo<$ty_generics>`.
>
> Here is an example that uses all three different types of generics:
>
>     let (Generics { decl_generics, impl_generics, ty_generics }, rest) =
=3D parse_generics(input);
>     quote! {
>         struct Foo<$($decl_generics)*> {
>             // ...
>         }
>
>         impl<$impl_generics> Foo<$ty_generics> {
>             fn foo() {
>                 // ...
>             }
>         }
>     }
>
> The next commit contains a fix to the `#[pin_data]` macro making it
> compatible with generic parameter default values by relying on this new
> behavior.
>
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>

Tested-by: Alice Ryhl <aliceryhl@google.com>

