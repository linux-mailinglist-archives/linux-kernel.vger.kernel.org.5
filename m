Return-Path: <linux-kernel+bounces-135133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3551989BB7D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 11:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94135B23E58
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 09:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9055E4595A;
	Mon,  8 Apr 2024 09:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kbSW43LS"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B60E3FBBE;
	Mon,  8 Apr 2024 09:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712567977; cv=none; b=DctyotTFJ6Qfv24b4PzvyoeuwsfEv71T+Ms62XeLTVR6qHUGyNKSqdO9LSfo5CvQzfT6oulL2QuIkcxrMB1ru+kSNw6cRnV5ziuhdzEfuDxTedRAnQ/8DzBVy/N3idelkWJzfQnGArzGSK+KtfKVSZ7EmpoQIzBDO6d02iDqTB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712567977; c=relaxed/simple;
	bh=xpv4GXaNvHbwNmLZOBogoUexAaRgl91nGHRAWB70R1c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jFgf9RsxuM82rLCzAQQPflgHAEupubUX9NJuvxejHIXk3zM15YN8FS+iNxhTgn0rzHnKtsjKM065DNGrshZ/PVA1Znq6iyVwEyZDtwEVTerMLyEAUrYUMfOB+FAYjgIVoD2RPZicm+NWxUWsbfVdIPlv7Fk8Pu+Rk3IF6lQDTFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kbSW43LS; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2a526803fccso302123a91.1;
        Mon, 08 Apr 2024 02:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712567976; x=1713172776; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CMNyRdQrOSFasuq0gOdjmdHM1CPNAmXdupymxZqTDfQ=;
        b=kbSW43LS53/RHgzEBoQV7dtqa2HscbuSZOvIFMVtd2wua84SWQboW+E1NMRIzwM8Kw
         5V3JJZJCHi39ZP/Ak3wvPSyN06+4yjxANEtz1bydeWbjtkxGNVqX9MFL5dFuTxbSnkGe
         gkY5xOTnNSeF+HggYpc2eMwcgwNv9VNR23GnoYsxKYm13IU2+X61N3K7l/bt7rib1CKt
         txB4b8EpQQgpm5FV7TAZuqNbw4KtiFio1hRyfbz9a5OmS99/dVNmiO/7DHxSHAQkEw2s
         F+E1j2IIrWDnL/UnoMVUzU2/R8IZenDSB4G7R2vshYAC4yzm8mMTlrCRq04HMP3TYFRZ
         B/LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712567976; x=1713172776;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CMNyRdQrOSFasuq0gOdjmdHM1CPNAmXdupymxZqTDfQ=;
        b=i6JxahFk6Jv1Pn9xib1agVVHHEgahx9Q8GO4feK9OOyTKGYHZL2LmjrFKdcYthhE0p
         h5pOATMtrLLCKk6VBvmVUaoyEPBcHPbLeJAEEFrOHPEGc5Uqsbov+uPvZUKPh6zBe7w+
         yiZhMmONveuIr0pd1RPZW31iXroErgc344caiJtroPcTW0Gp1F6Q7tK7qqBdgd6645yL
         JJP6n+zkVm54oa0kCd2MlDglrdFZHl3gLo2N3ceGIW3KKwvsZb7oxhDuoK0k+zH2Tzv8
         /KeWFA/lIUEwaVuKTRz6n2zPVy+gNuata+NnBgGhd11hD0AzHHAukOnfBMQxleT3NkMW
         k3mQ==
X-Forwarded-Encrypted: i=1; AJvYcCVA/tMcVAmoRgfjuZJwh/6iTIt1WsJ2G1aNvyzkqBIrZtGwDBj4LVeBZcTLtUsKNKYRlZbDp593HZYwUl+oSiQHhe0gw6J+N078RDEvYpaDba6W8okWIS7i9uoROLI6X0DRuhu4PRNJurvTf18=
X-Gm-Message-State: AOJu0YzI3vk8W+tqpLBMelDsqYf/Bo6mX2l89Ve2GIDp0SZ6DylXzhSi
	9L/3uHfvp8nWfkcjNTtbw+jnJmfAiRQ8q8YLG2Sey1iprW37p5WnVG+2JxSLb/NiO/NSq70AO2l
	EzGlbKPGJ+EUigf+bb+NqGG7wO+4=
X-Google-Smtp-Source: AGHT+IFhMRh7Af+1ofz2RUc8GsbDJVtkVO04aivZzCObwcByfet4XkSJddJNLUkQxaNSLaJfOd2L+aFtpEY4xfTHT9E=
X-Received: by 2002:a17:90a:e50f:b0:2a2:97ce:24f5 with SMTP id
 t15-20020a17090ae50f00b002a297ce24f5mr7693686pjy.35.1712567975830; Mon, 08
 Apr 2024 02:19:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404-alice-mm-v4-0-49a84242cf02@google.com>
 <20240404-alice-mm-v4-4-49a84242cf02@google.com> <a48b2347-b58b-432e-bdb8-d5449016ab57@proton.me>
 <CAH5fLgg3wpcDE+n6nd0CGtDzyXSrD2nLhY8RxdTHjAD8hQ9VDQ@mail.gmail.com>
 <c130a6f5-77d7-4d9e-984d-7a8bf48ff918@proton.me> <CAH5fLgigLV17+6U75MC43XFnYeqtgvrrTWD7JmDSB-ebNjCVvw@mail.gmail.com>
In-Reply-To: <CAH5fLgigLV17+6U75MC43XFnYeqtgvrrTWD7JmDSB-ebNjCVvw@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 8 Apr 2024 11:18:52 +0200
Message-ID: <CANiq72mZ5QPrb1-jWiKFhO2OF517Xvx=Js3zwM+_VyVL=dy2LA@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] rust: add abstraction for `struct page`
To: Alice Ryhl <aliceryhl@google.com>
Cc: Benno Lossin <benno.lossin@proton.me>, Miguel Ojeda <ojeda@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Andrew Morton <akpm@linux-foundation.org>, Kees Cook <keescook@chromium.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	=?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Arnd Bergmann <arnd@arndb.de>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 8, 2024 at 9:54=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> wr=
ote:
>
> From bindgen's point of view, this constant is just an integer literal
> with no type information. So I don't see how we can expect it to
> always be generated as a usize?

In the case of `PAGE_SIZE`, there is type information (`size_t`),
since it comes from the constant helper:

    const size_t RUST_CONST_HELPER_PAGE_SIZE =3D PAGE_SIZE;

For the other one, `PAGE_SHIFT`, there is also type information
(`int`), but bindgen currently picks a type based on the value for
those (but ideally/eventually bindgen should respect it instead).

So for the former, the allow and the cast are not needed since we are
already handling it explicitly. And for the latter, if we want to have
it as `usize`, we should have the cast but not the allow, because now
it does `u32`, but if it respected the type, it would be `c_int` or
`i32`. So either way we would need the cast.

Cheers,
Miguel

