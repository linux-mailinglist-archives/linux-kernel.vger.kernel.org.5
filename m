Return-Path: <linux-kernel+bounces-9093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94DB581C061
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 22:42:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C757E1C213E2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 21:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A82277644;
	Thu, 21 Dec 2023 21:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jXDORxV+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4550FA5B;
	Thu, 21 Dec 2023 21:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dbdb5e37f93so1195324276.3;
        Thu, 21 Dec 2023 13:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703194935; x=1703799735; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rid+g3xZdJDgqp/Yc2xW5mOJwNnrU6NKIQJkfAyL0OA=;
        b=jXDORxV+wKg3EANpQVSXrPPrOMKvaYts+sOabSekqwKsu512y2dhDH1eoIlpUZEsQm
         4JD4Ayez+eupx17KVta0ya16t99O1YNEjN8I204J4gBhLhtGJewQYNH4uZp3y1xVb1Yx
         Hfw2D+U/9ZwxIfkGNK16HJGZ1CKLnuPcU/IZHNPG17PIRiE33svjQrAqZfq9Gp5+d4aA
         8ZvEoqMAuFlfkTRNjd9ONfR6euCV2hh0VAiD6pxfsq627LsnJayJU1JUSbxxbMJHvvZB
         +pOEVrYKV86ULifpPSBj5aL3zx/8QpCojqJM9XQ9v48J5Kbtfq0GTHrzys3jJ7UQAnQY
         3oAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703194935; x=1703799735;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rid+g3xZdJDgqp/Yc2xW5mOJwNnrU6NKIQJkfAyL0OA=;
        b=Euq86DPWKPRfJgf1yha9YRfBOZulSTFJo/ZUvZFf3BktRU2H1k1wvLorwt/WzYWXko
         e1KShOyFP6dvD03LJXn2j+krCT3a19BB3wO/nuBxF1TBTfbiiUg340UrYjDDPAs/OMwO
         L38DstwvUiyD97d7/6FIYxkNz+2EXxUYS3NTZtPm0vo77j0qFxvdomlnPYTJbbtyeslM
         wXsNdl95glT2pT1mnWw+e+axGM6x4s5XjdfPuv65xZjPefSdIeK1xWLbeYXy1WMb5P8t
         qCcePlNe8X7CRJrKAUOr+0U9Y/B21IREiwaJmEn5d9hz7WDGkPJuNSOO5EFJnHbHQAW1
         BC6A==
X-Gm-Message-State: AOJu0Yzmoz5eNnzzwF+vJEOXeE7bWFrqPo7QA1O17vTCmZ/GJJISqeTj
	ac/+vL8+evivi6nyo6aL91AmUXZbdyJR2t2N5pg=
X-Google-Smtp-Source: AGHT+IFV/LMIZxkaJdLt4PJlTuBD8C3WJ6yeE+gO4Dg47v3tAtxOHZpyXy5abBbykfI3FbNxJ/O8C5pwwo8G880SUJs=
X-Received: by 2002:a25:d782:0:b0:dbd:6506:d8df with SMTP id
 o124-20020a25d782000000b00dbd6506d8dfmr388370ybg.74.1703194935306; Thu, 21
 Dec 2023 13:42:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231215124751.175191-1-ojeda@kernel.org>
In-Reply-To: <20231215124751.175191-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 21 Dec 2023 22:42:04 +0100
Message-ID: <CANiq72=vkdLQ=vu4tDZpWz8C+YJCeZfwToRAR3wKm1Vt2wxzcg@mail.gmail.com>
Subject: Re: [PATCH] docs: rust: remove `CC=clang` mentions
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Wedson Almeida Filho <wedsonaf@gmail.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev, 
	Jonathan Corbet <corbet@lwn.net>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, linux-doc@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2023 at 1:48=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> Nowadays all architectures except s390 recommend using `LLVM=3D1` instead=
 of
> `CC=3Dclang`, and since commit a3c6bfba4429 ("Documentation/llvm: refresh
> docs") the Kbuild LLVM documentation makes `LLVM=3D1` the way to go:
>
>     We want to encourage the use of ``LLVM=3D1`` rather than just
>     ``CC=3Dclang``. Make that suggestion "above the fold" and "front and
>     center" in our docs.
>
> In particular, that commit removes the examples with `CC=3Dclang`.
>
> Thus do the same in the Rust Quick Start guide, i.e. remove the `CC=3Dcla=
ng`
> mentions, especially since the architectures that have had their Rust
> support upstreamed (or soon to be upstreamed) are all `LLVM=3D1` ones
> anyway. And perhaps by the time Rust is supported for s390 (or new
> architectures), it may have moved to `LLVM=3D1` anyway. Otherwise,
> this can be added back if needed (or perhaps an extra link to
> Documentation/kbuild/llvm.rst).
>
> This should also help avoiding potential confusion around `CC=3Dclang` [1=
].
>
> Link: https://lore.kernel.org/rust-for-linux/6df6e8e5-8d5b-4d3d-91b5-bc0e=
90c424ea@nvidia.com/ [1]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Applied to `rust-next` -- thanks everyone!

Cheers,
Miguel

