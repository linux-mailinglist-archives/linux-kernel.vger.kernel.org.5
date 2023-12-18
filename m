Return-Path: <linux-kernel+bounces-3748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E019817084
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 14:33:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FD721F22336
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 13:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A303D1D122;
	Mon, 18 Dec 2023 13:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j7x23AtU"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32C88464;
	Mon, 18 Dec 2023 13:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-5e4b6353482so19494337b3.1;
        Mon, 18 Dec 2023 05:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702906414; x=1703511214; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/XTxombejJvrSz1c0NBYh3w/CnJqcWskHUIi/zqhoTE=;
        b=j7x23AtUuTkUPYyfKxS0VVHjI26UBmcVa8DPCZGb79Q1MHE9H1ShYDitXQ6CQigfBy
         JLt5Y8ZBbPGk1m5KMUkTrM5G1nxEo/Tq8eqnGY3Wge2UntDD1KcrpFO6yy/HFSomfqPB
         EPNpXUVeSGmwUA6L33IVEwYiD5R7baPUU266JUsh0XRq0IlkT9umM6HuDgpNaDv1rU/f
         C3H5n3VaSn/f9cwmM2kEX5IncEs00yI6OLYNXoIKsZftartPF87b43ByA7W7oF/1CNdp
         ab+DvnuN4aFiP5/KptFDZPSStd71n+PCpmWx5X3oNFPmyc9MmsIsuHmfmC0tSw7Scz6J
         jIbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702906414; x=1703511214;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/XTxombejJvrSz1c0NBYh3w/CnJqcWskHUIi/zqhoTE=;
        b=lnNAjr7SIRP8g51xkkAYvC/taE95GUyuw1XIifzR07KuXYMMizwXszWtqlv4CY2npt
         uyYQypPNIvEb8TlMxBmeRcYoOE9sjhiZoeyXGl7Est4jRwySjXdfnYJPgD21bwH/zcZM
         Vt7T1JR3CTZiIVjNVSOBDYljqlR4jZwrFqyHHwjmA1TDouJRja4LwydBPUSGaaY6fi8D
         t+nyqn5S0dKo2TklxKavg4gFFSfZXYHYMHIzmPX/fj6mSacfZ/GME9wiXJvBhbfmIAV+
         lXA/AXMaYOgJmDGXQpFc9ei6tDOHlhpvh+dRUPY17hLr1zKaDLwpEflmeizU0Hvov/7y
         G6TQ==
X-Gm-Message-State: AOJu0YzK3LTaL4cgTGm/IZPzs91DiPiKt0M8qLPyxXxrYAqY2qd9srb/
	gUu95X3U+OoMF7Pe9bhwcMSnAYavvlrQ4GiUcZk=
X-Google-Smtp-Source: AGHT+IEgynr5hzCh0Yha5bdcybxD+4XDoDnyLoi/Bwrt1GyqD5BuO0u/e2Nyf02WVuvJdzMUrAZd3A7000NFrBCts2s=
X-Received: by 2002:a0d:d241:0:b0:5d7:1a33:5ad7 with SMTP id
 u62-20020a0dd241000000b005d71a335ad7mr10904091ywd.36.1702906414703; Mon, 18
 Dec 2023 05:33:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231214222253.116734-1-ojeda@kernel.org> <CABVgOS=LXUzRD-c63sxn0FMfGWvxCPP1t_8nY5Xgk30Y9qMAcw@mail.gmail.com>
 <CANiq72kw326HyrDM0v0mFNu5jfb=eL1a+k-idr-5Vbc6_gmY2A@mail.gmail.com> <CAK7LNAQ7A79fMg3Teh7H+NRwnztrNU73s5C_fybUVH+vEX0YeQ@mail.gmail.com>
In-Reply-To: <CAK7LNAQ7A79fMg3Teh7H+NRwnztrNU73s5C_fybUVH+vEX0YeQ@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 18 Dec 2023 14:33:23 +0100
Message-ID: <CANiq72mjSVqLNrdhK6H+X2=9ydwzX3RM2jBf1AwRFngSJ2kQ9Q@mail.gmail.com>
Subject: Re: [PATCH] kbuild: rust: add `rustupoverride` target
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: David Gow <davidgow@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Nicolas Schier <nicolas@fjasle.eu>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, linux-kbuild@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2023 at 1:10=E2=80=AFPM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> In principle, Kbuild does not require internet connection,
> or proactively change the system setting.

Yeah, that was what I thought. I agree it can be surprising to have
Make targets that modify environment/system-level bits (i.e. affecting
things outside the build).

> Rather, I will manually do this one time for the parent directory:

That can work for many people, yeah. Though I imagine some people may
want to keep builds (and sources) of different kernel versions in the
same parent folder (or even other projects). But one can use nested
overrides too.

> If you want to provide a way for automated settings,
> you can do it in a script you maintain.

Sounds good. In that case, we can send to the list your patch from the
`rust` branch if that is OK with you (i.e. I understand you would
prefer to avoid not just `rustsetup` but also `rustupoverride`).

Thanks Masahiro!

Cheers,
Miguel

