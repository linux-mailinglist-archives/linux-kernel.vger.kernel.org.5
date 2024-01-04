Return-Path: <linux-kernel+bounces-16844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7538244D2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 16:19:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D12EC1F22285
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 15:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1DC241FE;
	Thu,  4 Jan 2024 15:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yryvG2Vc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D017F241E9
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 15:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3bc09844f29so410458b6e.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 07:18:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704381530; x=1704986330; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yq1QDb6qMZk3I5/DUUjoS1xIca883SGj28CqAPW/BI8=;
        b=yryvG2Vcj7WdqACavep5kAOlyvodAijNAT6S++FT1A0xXQ0PiUKu1DcA2lINlK0MjI
         6UJxfzO3ihzgbAzCQuIOrf+9I3tQNzhEDPveA5M0mvKpm2AGhlo7vBCn3SbbnyBqtMfa
         29V65+TYOOaBhrAkxkfncjJGATAUnUaU/8T5fE6tYVYgylZFv7IRj6DjoSs8+yN9397t
         7Kmw1BxDSevpEGoY1SRDKY1Jf2UHrYa+AwLH+W8Ft9IlGkhnWDFjKMOX+NhO5uoFEy/B
         TxfffTnkaSNlrW1y+VMzBr3tHZi3YX2zLzAKdQUoNKo7W9xUlXSSvCS4BkZ0wLho3gcG
         uK/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704381530; x=1704986330;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yq1QDb6qMZk3I5/DUUjoS1xIca883SGj28CqAPW/BI8=;
        b=YNl4g0ZhgMBKUcDCVnQD+nudJQJv8shhtDjNUewW8D5K7Xha1/BInkTkhm+HFxK0L4
         Gwt3e0lm8H+rgz8vvWeg3HvmiVMg7+/4QWMOdKgG4ZXm7iyDFFI+bV+9u/0ID/y0DZUn
         c2AvCRXHHZYdzCu6d7tSMx2vEv6sJgkCMslMvUSR0Rm6sO2wrmXkIwaCDpdCrIpEbqDy
         bgVDQI+j7kS9Qvswx1q2wGk/gxkFh8UKzizqJWNPnY9pBKR1dWvMEMOTCgLJ7WYmeLdB
         YXQHenA4P27AW5MRtnp2dn1x0USY8JfuZKcc0qDe7D1rC+GWB9/V4F6vm03SunwkVxgL
         Y+/w==
X-Gm-Message-State: AOJu0YzIgEUQw+OLbTz2y/Y61IRYB+VBAUgi4OJ1EtUc/kEzRT7odM3/
	E7zkzxdO5+R9/WcfRaD1/HuQgFXM9fEbjIlNzfMQB9E0Iov3
X-Google-Smtp-Source: AGHT+IF3Dflo918IleZ8UgZ/UuuZjqjkDFNPfGaU9SkeAMtXWX8kswde6L49DnrvqHKQRq38bhxIpKPfgWuGifusAvk=
X-Received: by 2002:a05:6808:3387:b0:3bb:c765:de28 with SMTP id
 ce7-20020a056808338700b003bbc765de28mr688920oib.8.1704381529703; Thu, 04 Jan
 2024 07:18:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231213220447.3613500-1-benno.lossin@proton.me> <20231213220447.3613500-2-benno.lossin@proton.me>
In-Reply-To: <20231213220447.3613500-2-benno.lossin@proton.me>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 4 Jan 2024 16:18:38 +0100
Message-ID: <CAH5fLgiKJpXF_jPnPj668P4DGjDwtfXs7dGV26i5kyLXCXLQ4Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] rust: macros: allow generic parameter default
 values in `#[pin_data]`
To: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Martin Rodriguez Reboredo <yakoyoku@gmail.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 11:09=E2=80=AFPM Benno Lossin <benno.lossin@proton.=
me> wrote:
>
> Add support for generic parameters defaults in `#[pin_data]` by using
> the newly introduced `decl_generics` instead of the `impl_generics`.
>
> Before this would not compile:
>
>     #[pin_data]
>     struct Foo<const N: usize =3D 0> {
>         // ...
>     }
>
> because it would be expanded to this:
>
>     struct Foo<const N: usize =3D 0> {
>         // ...
>     }
>
>     const _: () =3D {
>         struct __ThePinData<const N: usize =3D 0> {
>             __phantom: ::core::marker::PhantomData<fn(Foo<N>) -> Foo<N>>,
>         }
>         impl<const N: usize =3D 0> ::core::clone::Clone for __ThePinData<=
N> {
>             fn clone(&self) -> Self {
>                 *self
>             }
>         }
>
>         // [...] rest of expansion omitted
>     };
>
> The problem is with the `impl<const N: usize =3D 0>`, since that is
> invalid Rust syntax. It should not mention the default value at all,
> since default values only make sense on type definitions.
>
> The new `impl_generics` do not contain the default values, thus
> generating correct Rust code.
>
> This is used by the next commit that puts `#[pin_data]` on
> `kernel::workqueue::Work`.
>
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>

Tested-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>

