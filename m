Return-Path: <linux-kernel+bounces-92336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65FF9871EBD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 13:14:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1F511F23855
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F1B5A4CD;
	Tue,  5 Mar 2024 12:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eLOgbIcw"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850315A114;
	Tue,  5 Mar 2024 12:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709640874; cv=none; b=i3UatXFoGqZ+JrasRoPmb7sdljN8PlBkBr4U7Bf+PxIWsMArWXPd2pkFGOI+j56s4mYhITj1kLJEz5E9rLZZOWKk/PFz688hlMEjuWty2nIhDKYLQ5bN/Q2yRGtUaudFNxD4pYlHzaqX8q/dzTxx0F/p99g0YA7v2zpgSz6IGGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709640874; c=relaxed/simple;
	bh=0JSSs1/ECQnp69yxT4x70rgh4SNZT8QM+eo7Dzqxqt0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s6fqvvAFufcbF9Bj758jarO4cCQTRwnw22v2B7RJB6B2PgeTnLypQNozCaS0oo3KB3j2z/tO8gfdVZ4YDXX86Xj6MJnzmy9ZHba1+su4/9MUgzpDHOL1nS6tfnuO+a0zFOARc9z8YscPAXmS8XCzhpFwpqRXdOTB/U6s5exkbIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eLOgbIcw; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-29a2545a1e7so3779411a91.2;
        Tue, 05 Mar 2024 04:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709640872; x=1710245672; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0JSSs1/ECQnp69yxT4x70rgh4SNZT8QM+eo7Dzqxqt0=;
        b=eLOgbIcwhfT5oiYhF4SuUwv1+HQgWThVEEKgPZlQqf2FtIqL47qWQvc76p6ZPdULMP
         iKKt4dMcEVllUHVXYuMENqHWgj9K/Ekq1/FLPdidgVk8slUe/xOINfmfQE3qUqYKLwit
         uwiLmJA+84Lxfn92G/Mvi275Zha1hvryaxe7ksRv+Ria1j/2gQ3COLfqxJ2MpZl9zkDP
         Z8X4zbDedLuhfApp+0vzIlMmV2u2Bk2QC4ZYcyksR7+Mgw7Bne2iW45i2weZJml7KfU4
         pDt9+lkHx2dQiClxfX4Qr5s4mx2KupX7XeEH5nw8PT2S6L56Vkobt2Z3Y17qjvcDAdw7
         O9HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709640872; x=1710245672;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0JSSs1/ECQnp69yxT4x70rgh4SNZT8QM+eo7Dzqxqt0=;
        b=Rz/rYWNY9I1rKe54hRgt9M6Tid4YN9VjZq25HXNOD0NZ5lxX8etopj+fpXYvoIZy3U
         tB5mMiNLHLwcaYgOyMi6wRdB1y3r8OV3/fOGLBpkGcJKu1XFatVRG1zjchyjp1LWpnND
         FceOUN2JfTamA+6eX41MR1phgjJQC9oHMImkfXdAKpXSZfthG/FwbBhhhRPabm+84Wjo
         +fXHVuF8Iygm83gKjdo+kvN+E+fR36DUyMxtBOaqbVZljUbjyLSTnRkS6LMP/GcA+tpE
         Sw3EcIZvjNxRiGXTjpvN3J42chgBgj3necPjTHfUGIms1BT/CYFc8fUDaXtcurXtL+oq
         Darw==
X-Forwarded-Encrypted: i=1; AJvYcCWLFu5KNtJa+Xjv+qqK6TVKLC2DBrlbtckq3xHx1KaeU+EOKqgxxVM0VeiEX5isisLhPZfrpiDTZYw6DPC27rXhZ/m3FQTi4Gln5R3lCGgPLaVmHwaMzzZetRsiM/6BZ+bf4gqdZSFzmR9KFZEdtcR9aqePNJ3w/vElbo85IpdomzMmmB8lfJh8aLw=
X-Gm-Message-State: AOJu0Yzai8Dc4AIfZplBAqfrydh3GsAX1K6//BNeCUUO/8I8JKGs7Ghe
	E19RgBjdifrGg1eBpCDmcPJLlp41RJKHyycW4Xgoe54Tdt+ekLaulHrhVBXfVaZzF+xLJSM3s1G
	4QfzUf3VeGTKZLZdHZc4RVLFJfac=
X-Google-Smtp-Source: AGHT+IEAD/TA42QIrdoJMSBPXlvEBVmHKsROORQBIYu4NCWh6kHE4Z/OnKV7A+AM3JF9Tp8lDCFBeG6d5O+mOAMazmU=
X-Received: by 2002:a17:90b:192:b0:29a:67fa:7bb7 with SMTP id
 t18-20020a17090b019200b0029a67fa7bb7mr8058251pjs.47.1709640871794; Tue, 05
 Mar 2024 04:14:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240305-shadow-call-stack-v2-1-c7b4a3f4d616@google.com>
In-Reply-To: <20240305-shadow-call-stack-v2-1-c7b4a3f4d616@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 5 Mar 2024 13:14:19 +0100
Message-ID: <CANiq72mCzRBW7_H5Q4VQF8PGRFwaKJzQwOe8LOP2NbStz4husg@mail.gmail.com>
Subject: Re: [PATCH v2] rust: add flags for shadow call stack sanitizer
To: Alice Ryhl <aliceryhl@google.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Jamie Cunliffe <Jamie.Cunliffe@arm.com>, Sami Tolvanen <samitolvanen@google.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Ard Biesheuvel <ardb@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mark Brown <broonie@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Kees Cook <keescook@chromium.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Valentin Obst <kernel@valentinobst.de>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 5, 2024 at 12:58=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> Add flags to support the shadow call stack sanitizer, both in the
> dynamic and non-dynamic modes.
>
> Right now, the compiler will emit the warning "unknown feature specified
> for `-Ctarget-feature`: `reserve-x18`". However, the compiler still
> passes it to the codegen backend, so the flag will work just fine. Once
> rustc starts recognizing the flag (or provides another way to enable the
> feature), it will stop emitting this warning. See [1] for the relevant
> issue.
>
> Currently, the compiler thinks that the aarch64-unknown-none target
> doesn't support -Zsanitizer=3Dshadow-call-stack, so the build will fail i=
f
> you enable shadow call stack in non-dynamic mode. However, I still think
> it is reasonable to add the flag now, as it will at least fail the build
> when using an invalid configuration, until the Rust compiler is fixed to
> list -Zsanitizer=3Dshadow-call-stack as supported for the target. See [2]
> for the feature request to add this.
>
> I have tested this change with Rust Binder on an Android device using
> CONFIG_DYNAMIC_SCS. Without the -Ctarget-feature=3D+reserve-x18 flag, the
> phone crashes immediately on boot, and with the flag, the phone appears
> to work normally.
>
> This contains a TODO to add the -Zuse-sync-unwind=3Dn flag. The flag
> defaults to n, so it isn't a problem today, but the flag is unstable, so
> the default could change in a future compiler release.
>
> Link: https://github.com/rust-lang/rust/issues/121970 [1]
> Link: https://github.com/rust-lang/rust/issues/121972 [2]
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
> This patch raises the question of whether we should change the Rust
> aarch64 support to use a custom target.json specification. If we do
> that, then we can fix both the warning for dynamic SCS and the
> build-failure for non-dynamic SCS without waiting for a new version of
> rustc with the mentioned issues fixed.

If the arm64 maintainers are OK with the warning being triggered in that ca=
se:

Acked-by: Miguel Ojeda <ojeda@kernel.org>

Otherwise partially reverting to the `target.json` approach sounds good too=
.

I added the `-Zuse-sync-unwind=3Dn` to the list at
https://github.com/Rust-for-Linux/linux/issues/2. Given the default is
what we want, I have put it in the "Good to have" section.

Cheers,
Miguel

