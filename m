Return-Path: <linux-kernel+bounces-71071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D69DE85A041
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 10:53:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14BC81C20A5E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 09:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9506E286B2;
	Mon, 19 Feb 2024 09:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kO9kJ/t3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDD628DA7;
	Mon, 19 Feb 2024 09:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708336390; cv=none; b=q8jchfVcAfAEYZ7Y+xWNmgjSrYzyqokHH7lQBpnOuDQ9YQIaQVn8h3oz2V24qwNDZ69qh/C2GsZUduMvrR0sOTIhvPucjAIfo+Qacd1cKfZXF6AU0BGW5HOGgh158mYKzCyuSq9sA2ECdZ07M2jYG+Ssbo5sS5aRpnz89wKkvZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708336390; c=relaxed/simple;
	bh=r/h2jpPDYgXtfXZa856PSgA0VAjbWBELGgpavRLRjZA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SiwlmM0TfKWDj8QBpfeiFsvhdIlzolJsGzK08GB1sFV6GVWRHNe7EuvL0Zkl+/QtUMs9M5Yx+PdmP5GCW19d61Z6G8BsWerjsmOH1K6C+gVYIdnNN2sxChrz8yYEz7BF9d3DxItAGJaixqp9eKXFVtPOpNcqMYtv7CsPl8M9K6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kO9kJ/t3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8270AC433C7;
	Mon, 19 Feb 2024 09:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708336390;
	bh=r/h2jpPDYgXtfXZa856PSgA0VAjbWBELGgpavRLRjZA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kO9kJ/t3G0jAOCDIhSLY1AQAFvgfCoFc3tRKvHMfg1znoRsYmju7r2LReykQn8B//
	 pgkPSdQy+5n8DlDZvKImpCBcswChM9a1RdkLRc9YS+LIkEnJZggUyptYOkYwaYVQuC
	 yoRONjM+Ah6NNUwQpyVGU84lJBVlEM4fN5O1E4BYks1jDNCdsyg2M9wpbsqWGdK6Ln
	 wtxHVvvl54Kb0Z0H4zUdg5nkuHKFvaSf4OZ9VeedASEoggOUvuBCr+3Y9zRIqDg6N4
	 amlnhDkReqZ2GGazLxkfdonQ30wI32/7S9KmFgGJIWtyjByBYp+6MsFh23CLJr8t6h
	 10AiIyEikrlMQ==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-512bd533be0so272478e87.0;
        Mon, 19 Feb 2024 01:53:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXJPxjB0tenNGJen/axyCoS9U4NBiDED3i/t3c3kFCtb2RVZMV7D4ZMoYnw1eWBguJexhtEa3BO+RF1poHdeLiUNBvvFzoypTZHZRGgzI2kt1J5gA+Z2l30zwPrIw0EzXnnqDW9rMmI88YXk4eJzRdBm+0EKmiB4l+1E0g5Wgd5+8n1IpznknmCrRc=
X-Gm-Message-State: AOJu0YwVYh89MJGIE33cPG78RS2vjfC40OeZx4XGA0rdTUvrH8e0QJ2b
	2PSeKffDAYaOSVxdPx/SXYbY1UvSusE9nQTQ+lbk6+I2+LiclnBAxrovwrPUUzJnnVrFM2XEMoX
	Ikg4cBO81I27UR5r6YXI6RyO02hY=
X-Google-Smtp-Source: AGHT+IGINCyBsmxLQmWZSlm6RrqZqYWU8t65jYsoUD72iAo1Kj7M3o/u7uw7WhAGTF9nwsX7NU/Qk5xIEXvGukyZD78=
X-Received: by 2002:a05:6512:52f:b0:512:afcc:3fe8 with SMTP id
 o15-20020a056512052f00b00512afcc3fe8mr1989946lfc.23.1708336389049; Mon, 19
 Feb 2024 01:53:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240217002638.57373-1-ojeda@kernel.org>
In-Reply-To: <20240217002638.57373-1-ojeda@kernel.org>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Mon, 19 Feb 2024 18:52:32 +0900
X-Gmail-Original-Message-ID: <CAK7LNARAiPCO3GrrihrgOzeBNT+8SvLo0t-4hHsTfQQFFjkuKA@mail.gmail.com>
Message-ID: <CAK7LNARAiPCO3GrrihrgOzeBNT+8SvLo0t-4hHsTfQQFFjkuKA@mail.gmail.com>
Subject: Re: [PATCH 1/2] kbuild: mark `rustc` (and others) invocations as recursive
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Wedson Almeida Filho <wedsonaf@gmail.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, linux-kbuild@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 17, 2024 at 9:27=E2=80=AFAM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> `rustc` (like Cargo) may take advantage of the jobserver at any time
> (e.g. for backend parallelism, or eventually frontend too). In the kernel=
,
> we call `rustc` with `-Ccodegen-units=3D1` (and `-Zthreads` is 1 so far),
> so we do not expect parallelism. However, in the upcoming Rust 1.76.0, a
> warning is emitted by `rustc` when it cannot connect to the jobserver it
> was passed (in many cases, but not all: compiling and `--print sysroot`
> do, but `--version` does not). And given GNU Make always passes
> the jobserver in the environment variable (even when a line is deemed
> non-recursive), `rustc` will end up complaining about it (in particular
> in Make 4.3 where there is only the simple pipe jobserver style).
>
> One solution is to remove the jobserver from `MAKEFLAGS`. However, we
> can mark the lines with calls to `rustc` (and Cargo) as recursive, which
> looks simpler. This is what is now documented and recommended by `rustc`
> and allows us to be ready for the time we may use parallelism inside
> `rustc` (potentially now, if a user passes `-Zthreads`). Thus do so.
>
> Similarly, do the same for `rustdoc` and `cargo` calls.
>
> Finally, there is one case that the solution does not cover, which is the
> `$(shell ...)` call we have. Thus, for that one, set an empty `MAKEFLAGS`
> environment variable.
>
> Link: https://github.com/rust-lang/rust/issues/120515
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>



Acked-by: Masahiro Yamada <masahiroy@kernel.org>



--=20
Best Regards
Masahiro Yamada

