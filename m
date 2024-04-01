Return-Path: <linux-kernel+bounces-127107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABD3F8946C0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 23:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C1C5281D68
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 21:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C490B55C08;
	Mon,  1 Apr 2024 21:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GK6ivugc"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E7554FA3;
	Mon,  1 Apr 2024 21:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712008369; cv=none; b=ZxpzSGcaQAmDTRToHuYlXqB7srPSAvqF5vAgveVGyIaYEkRLwZVSY8OkXy76R3ojivWxbHqYwmbkVx9zyv2oDtWbiVgz5dPRpX9d7Mbs/W/ONR33euiaUaZ6oqyARqZA5xnidbOPpC+zL6LwqwsttCnN0Ww8aYpmLJ/9+6DjYSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712008369; c=relaxed/simple;
	bh=+mUgi1Gjenu9kWJsbSxl2FyKXeH8k9dLSGa1afErYxo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BW1kzW8DPYtFhbrC655tLvuE+oCu8743oBTTycOIpNZQ2DqaOr/y3Pv8znQWHqgEv5zbhP7rmE18pN2fXwnbYOs0RnLeLP8/VBHLaloCNSydeWWkxNPWqtbZzOPgAROlupb0NxV9CgAT6HhdzIPXs83SYT98gaiu/wPBc7aET9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GK6ivugc; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5d8b887bb0cso3651867a12.2;
        Mon, 01 Apr 2024 14:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712008367; x=1712613167; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+mUgi1Gjenu9kWJsbSxl2FyKXeH8k9dLSGa1afErYxo=;
        b=GK6ivugcMlPSfINxF+nT8KVqqbQIqxkiB0t8EmdL+HVS6Pd4x39gJF8DdyKx//kswj
         2R6jRYvxQhSZmvp9XwagCbxIVTPKHvGAPU3d9ZjllvuDyAj9WjL2UfhpQVFTyaL6O7lF
         4PZiZIiV5SufhrGQyLbIGZ0lFQrt8RKUZti+e+du4ev1qsN95vRRgCyBwjPxYr5smFvd
         c0FCKOFeiuZYoEH91XHacX8HhKydbrPnWC8xIsK2KGwbORxky/i7GpMMwjlvxyjuacVP
         Lgq/vsP5xNoN42HVQn5dI1ctrD6H4S7VU0hSBYWPkSj6Y6RhM+0hJszAk4vSQOJo47ea
         I54g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712008367; x=1712613167;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+mUgi1Gjenu9kWJsbSxl2FyKXeH8k9dLSGa1afErYxo=;
        b=t3rgUcQ9lpBZj4vzbEtBcl6vHyavb1mEB3mNu43HPcppIL+jYDI5juuPvDx+YFfjTA
         aSK+XXHZ2BdJWLsuh4RSTsYcAgRSMI6qdD806bcpYOpUzntT+CEarX/OB8xwuVP6RrfR
         YZyZlfnRWEpoi++Mvrhq2xbRDw/56sZ5y1lU6Jsz7nKDwhthG6XB0tAHaRpSt94i/rzo
         QWc3JqvV5EfnZ3MJ+apS+bcOg5zdwr/l6B0flS3dJHbjikje2tD+BMAbwrPtiXWonPDt
         5iLFqXtHjfFZDx9SG6kHHRoDrz0Z/BggyrB7FyP1I5bEC2m8c4YMjy5mc7uBYCN1hGin
         lloA==
X-Forwarded-Encrypted: i=1; AJvYcCX200X7X2JQ1aXCbZfPyz5rV813qjA22vC760Oet3VJOb370lBmSZK1CehEfYyuDOvFZL+D27K0cIkSPhI+0FdaLfH9u69R+Ax/Umd+AkNh7Eo3BajE2sRZVH0kJcYbgVu6J/m2c3MJaWdKQMs=
X-Gm-Message-State: AOJu0YxOKMJRLNKhaejbbiQbTpvlp90rUZZz1NcOOtBr/xJXWB+RhrPq
	D2F0pfztPfNPrW+TdOtFRyWYX/j6ngGJxRhVi1Q8xsBEBvF2pMP1arBJ0hnxRypZPpTVNPatUfA
	VeiAzgpnqK5Gq5PSaW3a5CIxkBxA=
X-Google-Smtp-Source: AGHT+IHOVFFEVYukvj+UTvjExqrrX2EQj/VredfPX+lNRU5rsGxijk8SP8Fgw/EP+hDBGh6McIwYX9ZAn7gfBXG04q0=
X-Received: by 2002:a17:90a:62c4:b0:2a0:6649:7582 with SMTP id
 k4-20020a17090a62c400b002a066497582mr9131491pjs.46.1712008366778; Mon, 01 Apr
 2024 14:52:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240401212303.537355-1-ojeda@kernel.org> <20240401212303.537355-4-ojeda@kernel.org>
In-Reply-To: <20240401212303.537355-4-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 1 Apr 2024 23:52:11 +0200
Message-ID: <CANiq72=FM2+VWs1sJTc3i2u4Y4P-DBR8o_h4Gd7MYXfxULjR-A@mail.gmail.com>
Subject: Re: [PATCH 3/3] rust: upgrade to Rust 1.78.0
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Wedson Almeida Filho <wedsonaf@gmail.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 1, 2024 at 11:23=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> It also means that, ignoring non-language/library features, we are
> currently left with just the few language features needed to implement th=
e
> kernel `Arc`, the `new_uninit` library feature, the `compiler_builtins`
> marker and the few `no_*` `cfg`s we pass when compiling `core`/`alloc`.

To be clear, by "currently" I meant in mainline, i.e. it does not mean
that we will not need/add a few more language/library features in the
future.

> Rust 1.78.0 introduced support for mutable pointers to Rust statics,
> including a test case for the Linux kernel's `VTABLE` use case [13].

I should have mentioned constants so that it makes sense. I will link
to `const_refs_to_static`, i.e.
https://github.com/rust-lang/rust/issues/119618.

> Rust 1.78.0 with debug assertions enabled (i.e. `-Cdebug-assertions=3Dy`,
> kernel's `CONFIG_RUST_DEBUG_ASSERTIONS=3Dy`) now always checks all unsafe
> preconditions, without a way to opt-out for particular cases [14].

It would be ideal to have a way to selectively disable certain checks
per-call site for this one (i.e. not just per check but for particular
instances of a check), even if the vast majority of the checks remain
in place. I discuss the details a bit more at
https://github.com/Rust-for-Linux/linux/issues/354.

> Please note that Rust 1.78.0 will be released in a month (2024-05-02).

By the way, I tested these with arm64, loongarch64 and x86_64.

Cheers,
Miguel

