Return-Path: <linux-kernel+bounces-954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C367B814876
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 13:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB8E71C2337F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 12:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 686912D047;
	Fri, 15 Dec 2023 12:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lmcpd2DB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C362F867
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 12:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-4647ed7941aso179204137.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 04:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702644712; x=1703249512; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/amUsMdukpvUs/gATYcpXgU/bNaTGRBLojO0rCY2bTM=;
        b=lmcpd2DByEM8q8tflYaFSLtHYzWvmWU9eYz46Oi1mIBLv1rBRpjCVX7vcqUuDym7J1
         aHnlSFyiscrDBPu2YEBEdM375tP8jVN5SGXXEv291rQm7KLMEK2L2MfEOAtrZzRjEzLf
         kPjsVN4XYPD0TKfE9efTkDa85EvuM5jX3nzlAnwl4EcdjpIcLCjMjorK/4i0JYVj7jSF
         kkhPeEGc3nRzOPxvkzW6Z9Etq1GKr0oTqr3dpHHfu4PeDe8ex/3tlW0XNjWHnrX1QFXa
         Jl+qQ8vU4Q55T3TVOc1bWH4f5F3Mz08o5qsyNMn03X/gF4mdpVqoTRjnWmYFxj0OYlco
         j2UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702644712; x=1703249512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/amUsMdukpvUs/gATYcpXgU/bNaTGRBLojO0rCY2bTM=;
        b=K7VhinxGXEB6c4tsGnVplqJt58ETUK5mEMSnETP4UsIA7/u2aVmlStya7OArtPHARS
         TcaqdePINmdQapH7GFGcnnQN+xe6rDvZuxhMaKyonPgVcRJsaqvikUwFmx/YrOoLoRjk
         qflw1Q55XifAJz9DYzVKW4xaYwLs3RT90tnvT9mxsEdc8VFArodUkpmS2L6YCyePjcNc
         qw0sCJYKOeDLdH5ip/DvOJaZeb57uJWXIyIoy/BwVymrd5OaMK1hQPcKbZYx52Reo9ve
         8Xhg5cfwYlmNuvyHJ71q2oGec7OIoffPJ8hB62pJkK26I44+POr7ei6y1cDkxdRigrY5
         lS3w==
X-Gm-Message-State: AOJu0YwP2rnvL6vjT9daCdRVtc+yp5SN3szuTVvFGGvJG4FiAzmiOC/1
	NFJDIuewJ+oBIZbMAJEjn58LizL3sK+RBdSontuTmQ==
X-Google-Smtp-Source: AGHT+IHO1d4i21i8Ce+aVgKTZYqcdXxdqABuqr+WSle2HNf7ucrVLYhaY40y3LgoCGQ2roFwOXppI9igvBnBX8o2sk4=
X-Received: by 2002:a05:6102:ccf:b0:464:426c:a5c with SMTP id
 g15-20020a0561020ccf00b00464426c0a5cmr11869653vst.18.1702644712467; Fri, 15
 Dec 2023 04:51:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231215124751.175191-1-ojeda@kernel.org>
In-Reply-To: <20231215124751.175191-1-ojeda@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 15 Dec 2023 13:51:41 +0100
Message-ID: <CAH5fLgjYMpd-NG5D2dh=zH3+RWGtuHZE+6Td7tDE+s7n7qsm4A@mail.gmail.com>
Subject: Re: [PATCH] docs: rust: remove `CC=clang` mentions
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Wedson Almeida Filho <wedsonaf@gmail.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev, Jonathan Corbet <corbet@lwn.net>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, linux-doc@vger.kernel.org, 
	llvm@lists.linux.dev
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

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

